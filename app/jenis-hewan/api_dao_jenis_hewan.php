<?php

  include_once $_SERVER['DOCUMENT_ROOT'] . '/koneksi.php';
  include_once $_SERVER['DOCUMENT_ROOT'] . '/conf.php';
  include_once $_SERVER['DOCUMENT_ROOT'] . '/app/counter.php';

  class JenisHewanDAO {
    protected $db;
    protected $tbname = 'jenis_hewan';

    public function __construct($db) {
      $this->db = $db;
    }

    public function add ($name, $kode) {
      $stmt = $this->db->prepare("INSERT INTO $this->tbname (nama, kode) VALUES (?, ?)");
      if (!$stmt) {
        http_response_code(500);
        echo 'Error Creating statement';
        die();
      }
      if (!$stmt->bind_param('ss', $name, $kode)) {
        http_response_code(500);
        die('Error: Can not bind param');
      }
      $result = $stmt->execute();
      if (!$result) {
        echo $stmt->error;
      }
      return $result;
    }

    public function loadAll() {
      $result = $this->db->query("SELECT * FROM jenis_hewan");
      $items = $result->fetch_all(MYSQLI_ASSOC);
      return $items;
    }

    public function list ($skip, $limit, $keyword) {
      if (!isset($skip)) {
        die('Error: argument "skip" is required');
      }
      if (!isset($limit)) {
        die('Error: argument "limit" is required');
      }
      $k = strtoupper($keyword);
      $result = $this->db->query("SELECT * FROM jenis_hewan 
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
      $result = $this->db->query('SELECT * FROM jenis_hewan WHERE id = ' . $id);
      $result = $result->fetch_assoc();
      return $result;
    }

    public function update ($id, $nama, $kode) {
      if (!$id) {
        http_response_code(500);
        die('Error: Empty id');
      }
      $stmt = $this->db->prepare('UPDATE jenis_hewan SET nama =  ?, kode = ? WHERE id = ?');
      if (!$stmt) {
        http_response_code(500);
        echo 'Error Creating statement';
        die();
      }
      if (!$stmt->bind_param('ssi', $nama, $kode, $id)) {
        die('Error: Can not bind param');
      }
      return $stmt->execute();
    }

    public function delete ($id) {
      if (!$id) {
        http_response_code(500);
        die('Error: Empty id');
      }
      $stmt = $this->db->prepare('DELETE FROM jenis_hewan WHERE id = ?');
      if (!$stmt) {
        http_response_code(500);
        echo 'Error Creating statement';
        die();
      }
      if (!$stmt->bind_param('i', $id)) {
        die('Error: Can not bind param');
      }
      return $stmt->execute();
    }
  }

  $DAO_jenis_hewan = new JenisHewanDAO($db);

  if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_GET['command']) && $_GET['command'] == 'add') {
    $data = json_decode(file_get_contents('php://input'), true);
    if (empty($data['nama'])) {
      die('Error: nama can not be empty');
    }
    if (empty($data['kode'])) {
      die('Error: kode can not be empty');
    }
    
    $result = $DAO_jenis_hewan->add($data['nama'], $data['kode']);
    if (!$result) {
      http_response_code(500);
    } else {
      http_response_code(201);
    }
  }

  if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_GET['command']) && $_GET['command'] == 'update') {
    $data = json_decode(file_get_contents('php://input'), true);
    if (empty($data['nama'])) {
      http_response_code(500);   
      die('Error: property "nama" is required');
    }
    if (empty($data['kode'])) {
      http_response_code(500);   
      die('Error: property "nama" is required');
    }
    if (empty($data['id'])) {
      http_response_code(500);   
    }

    $nama = $data['nama'];
    $kode = $data['kode'];
    $id = $data['id'];
    $result = $DAO_jenis_hewan->update($id, $nama, $kode);
    if (!$result) {
      http_response_code(500);   
      die('Error: can not update jenis hewan');
    } else {
      http_response_code(200);
    }
	}
	
	if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['command']) && $_GET['command'] == 'delete') {
		if (empty($_GET['id'])) {
			http_response_code(500);   
      die('Error: property "id" is required');
		}
		$id = $_GET['id'];
		$result = $DAO_jenis_hewan->delete($id);
		if (!$result) {
      http_response_code(500);   
      die('Error: can not delete jenis hewan');
    }
    header('Location: /app/ras/list.php');
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
    returnJson($DAO_jenis_hewan->listPagination($page, $keyword));
  }

  if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['command']) && $_GET['command'] == 'load-all') {
    returnJson($DAO_jenis_hewan->loadAll());
  }

  if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['command']) && $_GET['command'] == 'load_by_id') {
    if (empty($_GET['id'])) {
      http_response_code(500);
      die('Error: id is not defined');
    }
    $id = $_GET['id'];
    $result = $DAO_jenis_hewan->getById($id);
    returnJson($result);
  }

?>