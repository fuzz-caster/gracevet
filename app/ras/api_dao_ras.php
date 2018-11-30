<?php

  include_once $_SERVER['DOCUMENT_ROOT'] . '/koneksi.php';
  include_once $_SERVER['DOCUMENT_ROOT'] . '/conf.php';
  include_once $_SERVER['DOCUMENT_ROOT'] . '/app/counter.php';

  class RasDAO {
      protected $db;
      protected $tbname = 'ras';

			public function __construct($db) {
					$this->db = $db;
			}

			public function add ($nama, $id_jenis_hewan) {
					$stmt = $this->db->prepare('INSERT INTO ras (nama, id_jenis_hewan) VALUES (?, ?)');
					if (!$stmt) {
						http_response_code(500);
						echo 'Error Creating statement';
						die();
					}
					if (!$stmt->bind_param('si', $nama, $id_jenis_hewan)) {
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
          $query = "
          SELECT ras.id, ras.nama, jenis_hewan.nama AS nama_jh,
            ras.kunj_terakhir,
            ras.total_kunjungan,
            jenis_hewan.id AS id_jh
            FROM ras
            JOIN jenis_hewan ON ras.id_jenis_hewan = jenis_hewan.id
            WHERE UPPER(ras.nama) LIKE '%$k%'
            LIMIT $skip, $limit
          ";
					$result = $this->db->query($query);
					if (!$result) {
            http_response_code(500);
            echo $query;
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
						SELECT ras.id, ras.nama, jenis_hewan.nama AS nama_jh, jenis_hewan.id AS id_jh
						FROM ras
						JOIN jenis_hewan ON ras.id_jenis_hewan = jenis_hewan.id
						WHERE ras.id = $id
					");
          $result = $result->fetch_array();
          if (!$result) {
            http_response_code(500);
						die('Error: can not get data');
          }
					return $result;
			}

			public function update ($id, $nama, $id_jenis_hewan) {
					if (!$id) {
						http_response_code(500);
						die('Error: Empty id');
					}
					$result = $this->db->query("UPDATE ras
						SET nama =  '$nama', id_jenis_hewan = $id_jenis_hewan WHERE id = $id");
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
				$stmt = $this->db->prepare('DELETE FROM ras WHERE id = ?');
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

  $DAO_ras = new RasDAO($db);

  // Handle the commands
  // POST data
  if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_GET['command']) && $_GET['command'] == 'add') {
    $data = json_decode(file_get_contents('php://input'), true);
    if (empty($data['nama'])) {
      http_response_code(500);   
      die('Error: property "nama" is required');
    }
    if (empty($data['id_jenis_hewan'])) {
      http_response_code(500);   
      die('Error: property "id_jenis_hewan" is required');
    }

    $nama = $data['nama'];
    $id_jenis_hewan = $data['id_jenis_hewan'];
    $result = $DAO_ras->add($nama, $id_jenis_hewan);
    if (!$result) {
      http_response_code(500);   
      die('Error: can not add ras');
    }
    http_response_code(201);
  }

  // PUT data
  if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_GET['command']) && $_GET['command'] == 'update') {
    $data = json_decode(file_get_contents('php://input'), true);
    if (empty($data['nama'])) {
      http_response_code(500);   
      die('Error: property "nama" is required');
    }
    if (empty($data['id'])) {
      http_response_code(500);   
      die('Error: property "id" is required');
    }
    if (empty($data['id_jenis_hewan'])) {
      http_response_code(500);   
      die('Error: property "id_jenis_hewan" is required');
    }

    $nama = $data['nama'];
    $id = $data['id'];
		$id_jenis_hewan = $data['id_jenis_hewan'];
    $result = $DAO_ras->update($id, $nama, $id_jenis_hewan);
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
		$id = $_GET['id'];
		$result = $DAO_ras->delete($id);
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
    returnJson($DAO_ras->listPagination($page, $keyword));
  }

  if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['command']) && $_GET['command'] == 'load_by_id') {
    if (empty($_GET['id'])) {
      http_response_code(500);
      die('Error: id is not defined');
    }
    $id = $_GET['id'];
    $result = $DAO_ras->getById($id);
    if (!$result) {
      http_response_code(500);
      die('Error: can not get data');
    }
    returnJson($result);
  }
?>