<?php

    include_once $_SERVER['DOCUMENT_ROOT'] . '/koneksi.php';
    include_once $_SERVER['DOCUMENT_ROOT'] . '/conf.php';
    include_once $_SERVER['DOCUMENT_ROOT'] . '/app/counter.php';

    class PasienDAO {
      protected $db;
      protected $tbname = 'pasien';

      public function __construct($db) {
        $this->db = $db;
      }

      public function add ($data) {
          if (empty($data['tipe_norek'])) {
              http_response_code(500);
              die('property "tipe" can not be empty');
          }
          if (empty($data['norek'])) {
              http_response_code(500);
              die('property "norek" can not be empty');
          }
          if (empty($data['nama'])) {
              http_response_code(500);
              die('property "nama" can not be empty');
          }
          if (empty($data['signalemen'])) {
              $data['signalemen'] = '--';
              //http_response_code(500);
              //die('property "signalemen" can not be empty');
          }
          if (empty($data['lahir'])) {
              http_response_code(500);
              die('property "lahir" can not be empty');
          }
          if (empty($data['id_ras'])) {
              http_response_code(500);
              die('property "id_ras" can not be empty');
          }
          $stmt = $this->db->prepare("INSERT INTO pasien
              (tipe_norek, norek, nama, jk, signalemen, lahir, id_ras, tatto_chip) 
              VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
          if (!$stmt) {
              http_response_code(500);
              echo 'Error Creating statement';
              die();
          }
          $tipe_norek = $data['tipe_norek'];
          $norek = $data['norek'];
          $nama = $data['nama'];
          $jk = $data['jk'];
          $signalemen = $data['signalemen'];
          $lahir = $data['lahir'];
          $id_ras = $data['id_ras'];
          $tc = $data['tatto_chip'];
          if (!$stmt->bind_param('sssissis', $tipe_norek, $norek, $nama, $jk, $signalemen, $lahir, $id_ras, $tc)) {
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
              SELECT 
                  pasien.id AS id,
                  pasien.nama AS nama,
                  pasien.signalemen AS signalemen,
                  pasien.jk AS jk,
                  pasien.lahir AS lahir,
                  pasien.kunj_terakhir AS kunj_terakhir,
                  pasien.total_kunjungan AS total_kunjungan,
                  pasien.temp_pemilik_id,
                  IF(pasien.jk = 1, 'Jantan', 'Betina') AS format_jk,
                  pasien.tipe_norek,
                  pasien.norek,
                  pasien.tatto_chip as tatto_chip,

                  ras.nama AS ras_nama,
                  ras.id AS ras_id,

                  jenis_hewan.nama AS jh_nama,
                  jenis_hewan.id AS jh_id,
                  jenis_hewan.kode AS jh_kode

                  FROM pasien
                  JOIN ras ON pasien.id_ras = ras.id
                  JOIN jenis_hewan ON ras.id_jenis_hewan = jenis_hewan.id
                  WHERE 
                    (
                        UPPER(pasien.tipe_norek) LIKE '%$k%' OR 
                        UPPER(pasien.norek) LIKE '%$k%' OR 
                        UPPER(pasien.nama) LIKE '%$k%' OR 
                        UPPER(jenis_hewan.nama) LIKE '%$k%' OR
                        UPPER(ras.nama) LIKE '%$k%'
                    )
                  LIMIT $skip, $limit");
          if (!$result) {
              http_response_code(500);
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
              SELECT 
              pasien.id AS id,
              pasien.nama AS nama,
              pasien.signalemen AS signalemen,
              pasien.jk AS jk,
              pasien.lahir AS lahir,
              pasien.kunj_terakhir AS kunj_terakhir,
              pasien.total_kunjungan AS total_kunjungan,
              IF(pasien.jk = 1, 'Jantan', 'Betina') AS format_jk,
              pasien.tipe_norek,
              pasien.tatto_chip as tatto_chip,
              pasien.temp_pemilik_id,
              pasien.norek,
              ras.nama AS ras_nama,
              ras.id AS ras_id,

              jenis_hewan.nama AS jh_nama,
              jenis_hewan.id AS jh_id,
              jenis_hewan.kode AS jh_kode

              FROM pasien
              JOIN ras ON pasien.id_ras = ras.id
              JOIN jenis_hewan ON ras.id_jenis_hewan = jenis_hewan.id
              WHERE pasien.id = $id
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
          if (empty($data['signalemen'])) {
              http_response_code(500);
              die('property "signalemen" can not be empty');
          }
          if (empty($data['lahir'])) {
              http_response_code(500);
              die('property "lahir" can not be empty');
          }
          $id = $data['id'];
          $nama = $data['nama'];
          $signalemen = $data['signalemen'];
          $jk = $data['jk'];
          $lahir = $data['lahir'];
          $id_ras = $data['id_ras'];
          $tc = $data['tatto_chip'];
          $result = $this->db->query("UPDATE pasien
              SET 
                  nama =  '$nama', 
                  signalemen = '$signalemen',
                  jk = $jk,
                  lahir = '$lahir',
                  id_ras = '$id_ras',
                  tatto_chip = '$tc'
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
          $stmt = $this->db->prepare('DELETE FROM pasien WHERE id = ?');
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

    $DAO_pasien = new PasienDAO($db);

    // Handle the commands
    // POST data
    if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_GET['command']) && $_GET['command'] == 'add') {
        $data = json_decode(file_get_contents('php://input'), true);
        $result = $DAO_pasien->add($data);
        if (!$result) {
            http_response_code(500);
            die('Error: can not add pasien');
        }
        http_response_code(201);
    }

    // PUT data
    if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_GET['command']) && $_GET['command'] == 'update') {
        $data = json_decode(file_get_contents('php://input'), true);
        $result = $DAO_pasien->update($data);
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
        $result = $DAO_pasien->delete($_GET['id']);
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
      returnJson($DAO_pasien->listPagination($page, $keyword));
    }

    if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['command']) && $_GET['command'] == 'load_by_id') {
      if (empty($_GET['id'])) {
        http_response_code(500);   
        die('Error: property "id" is required');
      }
      $id = $_GET['id'];
      returnJson($DAO_pasien->getById($id));
    }