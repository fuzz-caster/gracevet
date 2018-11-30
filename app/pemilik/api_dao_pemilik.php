<?php

    include_once $_SERVER['DOCUMENT_ROOT'] . '/koneksi.php';
    include_once $_SERVER['DOCUMENT_ROOT'] . '/conf.php';
    include_once $_SERVER['DOCUMENT_ROOT'] . '/app/counter.php';

    class PemilikDAO {
      protected $db;
      protected $tbname = 'pemilik';

      public function __construct($db) {
          $this->db = $db;
      }

      public function add ($data) {
          if (empty($data['nama'])) {
              http_response_code(500);
              die('property "nama" can not be empty');
          }
          if (empty($data['alamat'])) {
              http_response_code(500);
              die('property "alamat" can not be empty');
          }
          $no_telp = '';
          if (isset($data['no_telp'])) {
              $no_telp = $data['no_telp'];
          }
          $stmt = $this->db->prepare("INSERT INTO pemilik
              (nama, alamat, no_telp) 
              VALUES (?, ?, ?)");
          if (!$stmt) {
              http_response_code(500);
              echo 'Error Creating statement';
              die();
          }
          $nama = $data['nama'];
          $alamat = $data['alamat'];
          if (!$stmt->bind_param('sss', $nama, $alamat, $no_telp)) {
              die('Error: Can not bind param');
          }

          $result = $stmt->execute();
          $id = $stmt->insert_id;
          return $id;
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
                  FROM pemilik
                  WHERE UPPER(nama) LIKE '%$k%'
                  LIMIT $skip, $limit");
          if (!$result) {
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
              FROM pemilik
              WHERE pemilik.id = $id
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
          if (empty($data['alamat'])) {
              http_response_code(500);
              die('property "alamat" can not be empty');
          }
          if (empty($data['no_telp'])) {
              http_response_code(500);
              die('property "no_telp" can not be empty');
          }
          $id = $data['id'];
          $nama = $data['nama'];
          $alamat = $data['alamat'];
          $no_telp = $data['no_telp'];
          $result = $this->db->query("UPDATE pemilik
              SET 
                  nama =  '$nama', 
                  alamat = '$alamat',
                  no_telp = '$no_telp'
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
          $stmt = $this->db->prepare('DELETE FROM pemilik WHERE id = ?');
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

    $DAO_pemilik = new PemilikDAO($db);

    // Handle the commands
    // POST data
    if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_GET['command']) && $_GET['command'] == 'add') {
        $data = json_decode(file_get_contents('php://input'), true);
        $result = $DAO_pemilik->add($data);
        if (!$result) {
            http_response_code(500);
            die('Error: can not add pemilik');
        }
        http_response_code(201);
    }

    // PUT data
    if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_GET['command']) && $_GET['command'] == 'update') {
        $data = json_decode(file_get_contents('php://input'), true);
        $result = $DAO_pemilik->update($data);
        if (!$result) {
            http_response_code(500);   
            die('Error: can not update ras');
        }
        http_response_code(200);
    }
        
    if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['command']) && $_GET['command'] == 'delete') {
        if (empty($_GET['id'])) {
            http_response_code(500);   
            die('Error: property "id" is required');
        }
        $result = $DAO_pemilik->delete($_GET['id']);
        if (!$result) {
            http_response_code(500);   
            die('Error: can not delete ras');
        }
        http_response_code(200);
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
      returnJson($DAO_pemilik->listPagination($page, $keyword));
    }

    if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['command']) && $_GET['command'] == 'load_by_id') {
      if (empty($_GET['id'])) {
        http_response_code(500);   
        die('Error: property "id" is required');
      }
      $id = $_GET['id'];
      returnJson($DAO_pemilik->getById($id));
    }
    