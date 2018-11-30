<?php

    include_once $_SERVER['DOCUMENT_ROOT'] . '/koneksi.php';
    include_once $_SERVER['DOCUMENT_ROOT'] . '/conf.php';
    include_once $_SERVER['DOCUMENT_ROOT'] . '/app/counter.php';

    class ObatDAO {
      protected $db;
      protected $tbname = 'penyakit';

      public function __construct($db) {
        $this->db = $db;
      }

      public function add ($data) {
          if (empty($data['nama'])) {
              http_response_code(500);
              die('property "nama" can not be empty');
          }
          $stmt = $this->db->prepare("INSERT INTO penyakit
              (nama) 
              VALUES (?)");
          if (!$stmt) {
              http_response_code(500);
              echo 'Error Creating statement';
              die();
          }
          $nama = $data['nama'];

          if (!$stmt->bind_param('s', $nama)) {
              die('Error: Can not bind param');
          }

          $result = $stmt->execute();
          return $result;
      }

      public function list ($skip, $limit, $keyword) {
          if (!isset($skip)) {
            die('Error: argument "skip" is required');
          }
          if (!isset($limit)) {
            die('Error: argument "limit" is required');
          }
          $k = strtoupper($keyword);
          $result = $this->db->query("
              SELECT *
                  FROM penyakit
                  WHERE UPPER(nama) LIKE '%$k%'
                  LIMIT $skip, $limit");
          if (!$result) {
              http_response_code(500);
              echo 
              die('Error: Fail get data');
          }
          $result = $result->fetch_all(MYSQLI_ASSOC);
          return $result;
      }

      public function listPagination($page, $keyword) {
        $paging = currentPaging($this->db, $this->tbname, $keyword);
        $paging['current'] = $page;
        $total = $paging['total'];
        $skip = ($page - 1) * ITEM_PER_PAGE;
        $limit = ITEM_PER_PAGE;
  
        $items = $this->list($skip, $limit, $keyword);
        return [
          'items' => $items,
          'paging' => $paging
        ];
      }

      public function getById ($id) {
        if (!$id) {
            http_response_code(500);
            die('Error: Empty id');
        }
        $result = $this->db->query("
            SELECT *
            FROM penyakit
            WHERE penyakit.id = $id
        ");
        if (!$result) {
          http_response_code(500);
          echo $this->db->error;
          die();
        }
        $result = $result->fetch_assoc();
        return $result;
      }

      public function update ($data) {
        if (!$data['id']) {
            http_response_code(500);
            die('Error: Empty id');
        }
        if (empty($data['nama'])) {
            http_response_code(500);
            die('property "nama" can not be empty');
        }
        
        $id = $data['id'];
        $nama = $data['nama'];
        $result = $this->db->query("UPDATE penyakit
            SET 
                nama =  '$nama', 
            WHERE id = $id");
        if (!$result) {
            die('execute failed: ' . htmlspecialchars($stmt->error));
        }
        return $result;
      }

      public function delete ($id) {
        if (!$id) {
            http_response_code(500);
            die('Error: Empty id');
        }
        $stmt = $this->db->prepare('DELETE FROM penyakit WHERE id = ?');
        if (!$stmt) {
            http_response_code(500);
            echo 'Error Creating statement';
            die();
        }
        if (!$stmt->bind_param('i', $id)) {
            die('Error: Can not bind param');
        }
        $result = $stmt->execute();
        return $result;
    }

    }

    $DAO_obat = new ObatDAO($db);

    // Handle the commands
    // POST data
    if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_GET['command']) && $_GET['command'] == 'add') {
        $data = json_decode(file_get_contents('php://input'), true);
        $result = $DAO_obat->add($data);
        if (!$result) {
            http_response_code(500);
            die('Error: can not add penyakit');
        }
        http_response_code(201);
    }

    if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['command']) && $_GET['command'] == 'load') {
      if (!isset($_GET['page'])) {
        http_response_code(500);   
        die('Error: property "page" is required');
      }
      $page = $_GET['page'];
  
      $keyword = '';
      if (!empty($_GET['keyword'])) {
        $keyword = $_GET['keyword'];
      }
      returnJson($DAO_obat->listPagination($page, $keyword));
    }

    if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['command']) && $_GET['command'] == 'load_by_id') {
        if (empty($_GET['id'])) {
          http_response_code(500);   
          die('Error: property "id" is required');
        }
        $id = $_GET['id'];
        returnJson($DAO_obat->getById($id));
    }

    // PUT data
    if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_GET['command']) && $_GET['command'] == 'update') {
        $data = json_decode(file_get_contents('php://input'), true);
        $result = $DAO_obat->update($data);
        if (!$result) {
            http_response_code(500);   
            die('Error: can not update penyakit');
        }
        http_response_code(200);
    }

    if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['command']) && $_GET['command'] == 'delete') {
        if (empty($_GET['id'])) {
            http_response_code(500);   
            die('Error: property "id" is required');
        }
        $result = $DAO_obat->delete($_GET['id']);
        if (!$result) {
            http_response_code(500);   
            die('Error: can not delete ras');
        }
        http_response_code(200);
    }
