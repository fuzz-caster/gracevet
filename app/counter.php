<?php
  include_once $_SERVER['DOCUMENT_ROOT'] . '/koneksi.php';
  include_once $_SERVER['DOCUMENT_ROOT'] . '/conf.php';

  define('ITEM_PER_PAGE', 20);

  function countRekamMedik($db, $keyword) {
    $k = strtoupper($keyword);
    $query = "SELECT 

      COUNT(rm.id) AS total

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
    ";
    $result = $db->query($query);
    if (!$result) {
      http_response_code(500);
      die('Error: Fail get data');
    }
    $result = $result->fetch_array();
    return $result['total'];
  }

  function countByKeyword($db, $tbname, $keyword) {
    $result = $db->query("SELECT COUNT(*) as total FROM $tbname where nama LIKE '%$keyword%'");
    if (!$result) {
      die('Error: Fail count table ' . $tbname);
    }
    $result = $result->fetch_array();
    return $result['total'];
  }

  function currentPaging($db, $tbname, $keyword) {
    $total = 0;
    if ($tbname == 'rekam_medik') {
      $total = countRekamMedik($db, $keyword);
    } else {
      $total = countByKeyword($db, $tbname, $keyword);
    }
    $pages = ceil($total / ITEM_PER_PAGE);

    return [ 
      'total' => $total,
      'pages' => $pages
    ];
  }

  if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['command']) && $_GET['command'] == 'count') {
    if (empty($_GET['tbname'])) {
			http_response_code(500);   
      die('Error: property "tbname" is required');
    }

    $tbname = $_GET['tbname'];
    $keyword = '';
    
    if (isset($_GET['keyword'])) {
      $keyword = $_GET['keyword'];
    }

    $result = currentPaging($db, $tbname, $keyword);

    returnJson($result);
  }
?>