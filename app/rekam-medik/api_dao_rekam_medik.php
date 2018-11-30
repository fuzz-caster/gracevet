<?php
  include_once $_SERVER['DOCUMENT_ROOT'] . '/koneksi.php';
  include_once $_SERVER['DOCUMENT_ROOT'] . '/conf.php';

  define('ITEM_PER_PAGE_RM', 20);

  function getRasAndJhIds ($db, $pasienId) {
    $getQuery = "SELECT 
      ras.id as ras_id,
      jenis_hewan.id as jh_id
      FROM pasien 
        JOIN ras ON pasien.id_ras = ras.id
        JOIN jenis_hewan ON ras.id_jenis_hewan = jenis_hewan.id
      WHERE pasien.id = $pasienId";
    $result = $db->query($getQuery);
    if (!$result) {
      http_response_code(500);
      die("Fail to get ras and jenis hewan");
    }
    $result = $result->fetch_assoc();
    return [
      'jenis_hewan' => $result['jh_id'],
      'ras' => $result['ras_id']
    ];
  }

  function incKunjCounter ($db, $tbname, $id, $lastVisit) {
    $getQuery = "SELECT total_kunjungan, kunj_terakhir FROM $tbname WHERE id = $id";
    $result = $db->query($getQuery);
    if (!$result) {
      http_response_code(500);
      die("Fail to get previous conter on table: $tbname");
    }
    $result = $result->fetch_assoc();
    $current_count = $result['total_kunjungan'];
    $new_count = $current_count + 1;
    $last_visit = $result['kunj_terakhir'];
    if ($last_visit < $lastVisit) {
      $last_visit = $lastVisit;
    }

    $query = "UPDATE $tbname SET 
        total_kunjungan = $new_count,
        kunj_terakhir = '$last_visit'
      WHERE id = $id";
    // echo $query;
    $result = $db->query($query);
    if (!$result) {
      http_response_code(500);
      die("Fail to increment kunjungan conter on table: $tbname");
    }
  }

  function decKunjCounter ($db, $tbname, $id) {
    $getQuery = "SELECT total_kunjungan, kunj_terakhir FROM $tbname WHERE id = $id";
    $result = $db->query($getQuery);
    if (!$result) {
      http_response_code(500);
      die("Fail to get previous conter on table: $tbname");
    }
    $result = $result->fetch_assoc();
    $current_count = $result['total_kunjungan'];
    $new_count = 0;
    if ($current_count > 0) {
      $new_count = $current_count - 1;
    }
    $query = "UPDATE $tbname SET 
        total_kunjungan = $new_count,
        kunj_terakhir = NULL
      WHERE id = $id";
    // echo $query;
    $result = $db->query($query);
    if (!$result) {
      http_response_code(500);
      die("Fail to decrement kunjungan conter on table: $tbname");
    }
  }

  function countByKeywordRM($db, $tbname, $keyword) {
    $result = $db->query("SELECT COUNT(*) as total FROM $tbname");
    if (!$result) {
      die('Error: Fail count table ' . $tbname);
    }
    $result = $result->fetch_array();
    return $result['total'];
  }

  function currentPagingRM($db, $tbname, $keyword) {
    $total = countByKeywordRM($db, $tbname, $keyword);
    $pages = ceil($total / ITEM_PER_PAGE_RM);

    return [ 
      'total' => $total,
      'pages' => $pages
    ];
  }

  function checkProperty($descriptions, $obj) {
    foreach ($descriptions as $key => $value) {
      if (empty($obj[$key])) {
        die("Error: property $key is not exist on obj");
      }
    }
  }

  class RekamMedikDAO {

    protected $db;
    protected $tbname = 'rekam_medik';
    protected $newRmListeners = [];

    public function __construct($db) {
      $this->db = $db;
    }

    public function addListener($cb) {
      array_push($this->newRmListeners, $cb);
    }

    public function addMinimal($pemilik_id, $pasien_id) {
      $query = "INSERT INTO rekam_medik (pemilik_id, pasien_id) VALUES ($pemilik_id, $pasien_id)";
      $result = $this->db->query($query);
      if (!$result) {
        throw new Exception($this->db->error . " (QUERY: $query)");
      }
      $id = $this->db->insert_id;
      return $id;
    }

    public function add ($data) {
      if (empty($data['pasien_id'])) {
        http_response_code(500);
        die('property "pasien_id" can not be empty');
      }
      if (empty($data['pemilik_id'])) {
        http_response_code(500);
        die('property "pemilik_id" can not be empty');
      }

      // Construct column names
      $columns = [
        [ 'pasien_id', 'i' ],
        [ 'pemilik_id', 'i' ],
        [ 'penyakit_id', 'i' ],
        [ 'tanggal', 's' ],
        [ 'berat', 'd' ],
        [ 'freq_n', 'd' ],
        [ 'freq_p', 'd' ],
        [ 'freq_t', 'i' ],
        [ 'mth', 's' ],
        [ 'mulut', 's' ],
        [ 'kul_rambut', 's' ],
        [ 'kelenjar_limfe', 's' ],
        [ 'pernapasan', 's' ],
        [ 'peredaran_darah', 's' ],
        [ 'pencernaan', 's' ],
        [ 'kelamin_perkencingan', 's' ],
        [ 'ang_gerak', 's' ],
        [ 'diagnosa', 's' ],
        [ 'prognosis', 's' ],
        [ 'terapi', 's' ],
        [ 'norek', 's' ]
      ];
      
      $columnNames = array_map(function ($pair) {
        return $pair[0];
      }, $columns);
      // Construct column part of sql query
      $columnSqlString = implode(',', $columnNames);
      // Construct type flag for prepared statement
      $preparedTypeFlag = implode('', array_map(function ($pair) {
          return $pair[1];
        }, $columns));
      // Construct n ?
      $askN = implode(',', array_map(function ($pair) {
          return '?';
        }, $columns));
      // Convert data to n-array of arguments
      $columnVals = [];
      for ($i = 0; $i < count($columns); $i++) {
        $columnVals[$i] = $data[$columnNames[$i]];
      }

      $stmt = $this->db->prepare("INSERT INTO $this->tbname
          ($columnSqlString)
          VALUES ($askN)");
      if (!$stmt) {
          http_response_code(500);
          echo 'Error Creating statement';
          die();
      }
      // Encode the struktur
      if (!$stmt->bind_param($preparedTypeFlag, ...$columnVals)) {
          die('Error: Can not bind param');
      }

      $result = $stmt->execute();
      if (!$result) {
        http_response_code(500);
        echo $this->db->error;
        die('error');
      }
      $rm_id = $stmt->insert_id;
      return $rm_id;
    }

    public function delete ($id) {
      if (empty($id)) {
        http_response_code(500);
        die('Id is not defined');
      }
      $data = $this->getById($id);
      $pasien = $data['pasien_id'];
      $pemilik = $data['pemilik_id'];
      $rasJh = getRasAndJhIds($this->db, $pasien);
      $ras = $rasJh['ras'];
      $jenisHewan = $rasJh['jenis_hewan'];

      decKunjCounter($this->db, 'pemilik', $pemilik);
      decKunjCounter($this->db, 'pasien', $pasien);
      decKunjCounter($this->db, 'ras', $ras);
      decKunjCounter($this->db, 'jenis_hewan', $jenisHewan);

      $delQuery = "DELETE FROM rekam_medik WHERE id = $id";
      $delResult = $this->db->query($delQuery);
      if (!$delResult) {
        http_response_code(500);
        die('Fail to delete rekam medik');
      }
      return $delResult;
    }

    public function list($skip, $limit, $keyword) {
      if (!isset($skip)) {
        die('Error: argument "skip" is required');
      }
      if (!isset($limit)) {
        die('Error: argument "limit" is required');
      }
      $k = strtoupper($keyword);
      $query = "SELECT 

      rm.id as id,
      rm.tanggal as tanggal,

      pasien.id AS pasien_id,
      pasien.nama AS pasien_nama,
      pasien.lahir AS pasien_lahir,
      IF(pasien.jk = 1, 'Jantan', 'Betina') AS pasien_format_jk,
      pasien.tipe_norek as tipe_norek,
      pasien.norek as norek,

      ras.nama AS ras_nama,
      ras.id AS ras_id,

      penyakit.id as penyakit_id,
      penyakit.nama as penyakit_nama,

      jenis_hewan.nama AS jh_nama,
      jenis_hewan.id AS jh_id,

      pemilik.nama as pemilik_nama,
      pemilik.alamat as pemilik_alamat,
      pemilik.no_telp as pemilik_no_telp,
      pemilik.id as pemilik_id

      FROM rekam_medik rm
      
      JOIN pasien ON rm.pasien_id = pasien.id
      JOIN ras ON pasien.id_ras = ras.id
      JOIN jenis_hewan ON ras.id_jenis_hewan = jenis_hewan.id

      JOIN pemilik ON rm.pemilik_id = pemilik.id

      LEFT OUTER JOIN penyakit ON rm.penyakit_id = penyakit.id

      WHERE 
        UPPER(pasien.nama) LIKE '%$k%' OR 
        UPPER(jenis_hewan.nama) LIKE '%$k%' OR
        UPPER(pemilik.nama) LIKE '%$k%' OR
        UPPER(ras.nama) LIKE '%$k%' OR
        UPPER(penyakit.nama) LIKE '%$k%'
      ORDER BY tanggal DESC
      LIMIT $skip, $limit
      ";
      $result = $this->db->query($query);
      if (!$result) {
        http_response_code(500);
        die('Error: Fail get data');
      }
      return $result->fetch_all(MYSQLI_ASSOC);
    }

    public function listPagination($page, $keyword) {
      $paging = currentPagingRM($this->db, $this->tbname, $keyword);
      $paging['current'] = $page;
      $total = $paging['total'];
      $skip = ($page - 1) * ITEM_PER_PAGE_RM;
      $limit = ITEM_PER_PAGE_RM;

      $items = $this->list($skip, $limit, $keyword);
      return [
        'items' => $items,
        'paging' => $paging
      ];
    }

    public function getById($id) {
      $query = "SELECT  rm.id as id,
      rm.berat as berat,
      rm.tanggal as tanggal,
      rm.freq_n as freq_n,
      rm.freq_p as freq_p,
      rm.freq_t as freq_t,
      rm.mth as mth,
      rm.mulut as mulut,
      rm.peredaran_darah as peredaran_darah,
      rm.pencernaan as pencernaan,
      rm.kul_rambut as kul_rambut,
      rm.kelenjar_limfe as kelenjar_limfe,
      rm.pernapasan as pernapasan,
      rm.peredaran_darah as peredaran_darah,
      rm.pencernaan as pencernaan,
      rm.kelamin_perkencingan as kelamin_perkencingan,
      rm.ang_gerak as ang_gerak,
      rm.diagnosa as diagnosa,
      rm.prognosis as prognosis,
      rm.terapi as terapi,

      pasien.id AS pasien_id,
      pasien.nama AS pasien_nama,
      pasien.lahir AS pasien_lahir,
      IF(pasien.jk = 1, 'Jantan', 'Betina') AS pasien_format_jk,
      pasien.tipe_norek as tipe_norek,
      pasien.norek as norek,

      penyakit.id as penyakit_id,
      penyakit.nama as penyakit_nama,

      ras.nama AS ras_nama,
      ras.id AS ras_id,

      jenis_hewan.nama AS jh_nama,
      jenis_hewan.id AS jh_id,

      pemilik.nama as pemilik_nama,
      pemilik.id as pemilik_id

      FROM rekam_medik rm
      JOIN pemilik ON rm.pemilik_id = pemilik.id
      JOIN pasien ON rm.pasien_id = pasien.id
      JOIN ras ON pasien.id_ras = ras.id
      JOIN jenis_hewan ON ras.id_jenis_hewan = jenis_hewan.id
      LEFT OUTER JOIN penyakit ON rm.penyakit_id = penyakit.id
      WHERE rm.id = $id";
      $result = $this->db->query($query);
      if (!$result) {
        http_response_code(500);
        die('Error: Fail get data');
      }
      return $result->fetch_assoc();
    }

    public function update($id, $data) {
      if (empty($id)) {
        http_response_code(500);
        die('Error: property "id" is required');
      }
      $penyakit_id = $data['penyakit_id'];
      $tanggal = $data['tanggal'];
      $berat = $data['berat'];
      $tipe_norek = $data['tipe_norek'];
      $freq_n = $data['freq_n'];
      $freq_p = $data['freq_p'];
      $freq_t = $data['freq_t'];
      $mth = $data['mth'];
      $mulut = $data['mulut'];
      $kul_rambut = $data['kul_rambut'];
      $peredaran_darah = $data['peredaran_darah'];
      $pencernaan = $data['pencernaan'];
      $kelenjar_limfe = $data['kelenjar_limfe'];
      $pernapasan = $data['pernapasan'];
      $kelamin_perkencingan = $data['kelamin_perkencingan'];
      $ang_gerak = $data['ang_gerak'];
      $diagnosa = $data['diagnosa'];
      $prognosis = $data['prognosis'];
      $terapi = $data['terapi'];
      $norek = $data['norek'];
      $query = "
        UPDATE rekam_medik SET
          penyakit_id = $penyakit_id,
          tanggal = '$tanggal',
          berat = $berat,
          tipe_norek = '$tipe_norek',
          freq_n = $freq_n,
          freq_p = $freq_p,
          freq_t = $freq_t,
          mth = '$mth',
          mulut = '$mulut',
          kul_rambut = '$kul_rambut',
          kelenjar_limfe = '$kelenjar_limfe',
          pernapasan = '$pernapasan',
          peredaran_darah = '$peredaran_darah',
          pencernaan = '$pencernaan',
          kelamin_perkencingan = '$kelamin_perkencingan',
          ang_gerak = '$ang_gerak',
          diagnosa = '$diagnosa',
          prognosis = '$prognosis',
          terapi = '$terapi',
          norek = '$norek'
          WHERE id = $id
      ";
      $result = $this->db->query($query);
      return $result;

    }

    public function getHasilLab ($rmId) {
      if (empty($rmId)) {
        http_response_code(500);
        die('Error: rekam medik id is required');
      }
      $queryResult = $this->db->query("
        SELECT id, id_tipe_hasil_lab, struktur FROM hasil_lab
          WHERE id_rekam_medik = $rmId
      ");
      if (!$queryResult) {
        die('Error querying data in RekamMedik.geHasilLab');
        http_response_code(500);
      }
      $result = $queryResult->fetch_all(MYSQLI_ASSOC);
      return $result;
    }

    public function setHasilLab ($rmId, $data) {
      if (empty($rmId)) {
        http_response_code(500);
        die('Id of rekam medik is required');
      }
      // Clear the data first
      $clearQuery = 'DELETE FROM hasil_lab WHERE id_rekam_medik = ' . $rmId;
      $clearResult = $this->db->query($clearQuery);
      if (!$clearQuery) {
        http_response_code(500);
        die('Error clearing data');
      }

      $insertHasilLabBaseQuery = 'INSERT INTO hasil_lab (id_tipe_hasil_lab, id_rekam_medik, struktur) VALUES ';
      foreach ($data as $hl) {
        $id_tipe_hasil_lab = $hl['id'];
        $struktur = json_encode($hl['struktur']);
        $insertHasilLabQuery = $insertHasilLabBaseQuery . " ($id_tipe_hasil_lab, $rmId, '$struktur') ";
        $insertHasilLabQueryResult = $this->db->query($insertHasilLabQuery);
        if (!$insertHasilLabQueryResult) {
          http_response_code(500);
          die('Fail to insert hasil_lab : ' . $insertHasilLabQuery);
        }
      }
    }

    public function getPenangananKhusus ($rmId) {
      if (empty($rmId)) {
        http_response_code(500);
        die('Error: rekam medik id is required');
      }
      $queryResult = $this->db->query("
        SELECT id, id_tipe_pen_khusus, deskripsi FROM pen_khusus
          WHERE id_rekam_medik = $rmId
      ");
      if (!$queryResult) {
        die('Error querying data in RekamMedik.getPenKhusus');
        http_response_code(500);
      }
      $result = $queryResult->fetch_all(MYSQLI_ASSOC);
      return $result;
    }

    public function setPenangananKhusus ($rmId, $data) {
      if (empty($rmId)) {
        http_response_code(500);
        die('Id of rekam medik is required');
      }
      // Clear the data first
      $clearQuery = 'DELETE FROM pen_khusus WHERE id_rekam_medik = ' . $rmId;
      $clearResult = $this->db->query($clearQuery);
      if (!$clearQuery) {
        http_response_code(500);
        die('Error clearing data');
      }

      $insertPenKhususBaseQuery = 'INSERT INTO pen_khusus (id_tipe_pen_khusus, id_rekam_medik, deskripsi) VALUES ';
      foreach ($data as $pk) {
        $id_tipe_pen_khusus = $pk['id'];
        $deskripsi = $pk['deskripsi'];
        $insertPenKhususQuery = $insertPenKhususBaseQuery . " ($id_tipe_pen_khusus, $rmId, '$deskripsi') ";
        $insertPenKhususQueryResult = $this->db->query($insertPenKhususQuery);
        if (!$insertPenKhususQueryResult) {
          http_response_code(500);
          die('Fail to insert pen_khusus : ' . $insertHasilLabQuery);
        }
      }
    }

  }

  $DAO_rm = new RekamMedikDAO($db);
  
  // Handle the commands
  // POST data
  if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_GET['command']) && $_GET['command'] == 'add') {
      $data = json_decode(file_get_contents('php://input'), true);
      $result = $DAO_rm->add($data);
      if (!$result) {
          http_response_code(500);
          die('Error: can not add rekam medik');
      }
      http_response_code(201);
  }

  if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_GET['command']) && $_GET['command'] == 'update') {
    if (empty($_GET['id'])) {
      http_response_code(500);   
      die('Error: property "id" is required');
    }
    $id = $_GET['id'];
    $data = json_decode(file_get_contents('php://input'), true);
    $result = $DAO_rm->update($id, $data);
    if (!$result) {
      http_response_code(500);
      die('Error: Fail update rm');
    }
    http_response_code(200);
  }

  if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['command']) && $_GET['command'] == 'load') {
    $page = 1;
    if (isset($_GET['page'])) {
      $page = $_GET['page'];
    }

    $keyword = '';
    if (!empty($_GET['keyword'])) {
      $keyword = $_GET['keyword'];
    }
    returnJson($DAO_rm->listPagination($page, $keyword));
  }

  if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['command']) && $_GET['command'] == 'load_by_id') {
    if (empty($_GET['id'])) {
      http_response_code(500);
      die('Error: property "id" is required');
    }
    $id = $_GET['id'];
    returnJson($DAO_rm->getById($id));
  }

  if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['command']) && $_GET['command'] == 'delete') {
    if (empty($_GET['id'])) {
      http_response_code(500);
      die('Id is not defined');
    }
    $id = $_GET['id'];
    $DAO_rm->delete($id);
  }

  if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['command']) && $_GET['command'] == 'hasil_lab') {
    if (empty($_GET['id'])) {
      http_response_code(500);
      die('Rekam medik id is required');
    }
    $rmId = $_GET['id'];
    returnJson($DAO_rm->getHasilLab($rmId));
  }

  if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_GET['command']) && $_GET['command'] == 'hasil_lab') {
    if (empty($_GET['id'])) {
      http_response_code(500);
      die('Rekam medik id is required');
    }
    $rmId = $_GET['id'];
    $data = json_decode(file_get_contents('php://input'), true);
    returnJson($DAO_rm->setHasilLab($rmId, $data));
  }

  if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['command']) && $_GET['command'] == 'pen_khusus') {
    if (empty($_GET['id'])) {
      http_response_code(500);
      die('Rekam medik id is required');
    }
    $rmId = $_GET['id'];
    returnJson($DAO_rm->getPenangananKhusus($rmId));
  }

  if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_GET['command']) && $_GET['command'] == 'pen_khusus') {
    if (empty($_GET['id'])) {
      http_response_code(500);
      die('Rekam medik id is required');
    }
    $rmId = $_GET['id'];
    $data = json_decode(file_get_contents('php://input'), true);
    returnJson($DAO_rm->setPenangananKhusus($rmId, $data));
  }

?>