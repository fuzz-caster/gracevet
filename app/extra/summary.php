<?php
  include_once $_SERVER['DOCUMENT_ROOT'] . '/koneksi.php';
  include_once $_SERVER['DOCUMENT_ROOT'] . '/conf.php';

  $year = date('Y');
  $month = date('n');

  if (isset($_GET['year'])) {
    $year = $_GET['year'];
  }
  if (isset($_GET['month'])) {
    $month = $_GET['month'];
  }

  // Select all rekam medik
  $query = "SELECT 
        rm.id as id,
        rm.tanggal as tanggal,
  
        pasien.id AS pasien_id,
        pasien.nama AS pasien_nama,
        pasien.lahir AS pasien_lahir,
        IF(pasien.jk = 1, 'Jantan', 'Betina') AS pasien_format_jk,
  
        ras.id AS ras_id,
  
        penyakit.id as penyakit_id,
        penyakit.nama as penyakit_nama,
  
        jenis_hewan.id AS jh_id,
  
        pemilik.id as pemilik_id
  
        FROM rekam_medik rm

        JOIN pemilik ON rm.pemilik_id = pemilik.id
        JOIN penyakit ON rm.penyakit_id = penyakit.id
        JOIN pasien ON rm.pasien_id = pasien.id
        JOIN ras ON pasien.id_ras = ras.id
        JOIN jenis_hewan ON ras.id_jenis_hewan = jenis_hewan.id

        WHERE MONTH(tanggal) = $month AND YEAR(tanggal) = $year";
  $resultRm = $db->query($query);
  $resultRm = $resultRm->fetch_all(MYSQLI_ASSOC);

  // Select all jenis hewan
  $queryJh = "SELECT * FROM jenis_hewan";
  $queryRas = "SELECT r.id, r.nama, jh.nama as jhNama  
                FROM ras r JOIN jenis_hewan jh ON r.id_jenis_hewan = jh.id";
  $queryPenyakit = "SELECT * FROM penyakit";

  $resultJh = $db->query($queryJh);
  $resultRas = $db->query($queryRas);
  $resultPenyakit = $db->query($queryPenyakit);

  $resultJh = $resultJh->fetch_all(MYSQLI_ASSOC);
  $resultRas = $resultRas->fetch_all(MYSQLI_ASSOC);
  $resultPenyakit = $resultPenyakit->fetch_all(MYSQLI_ASSOC);

  $toSendJh = [];
  $toSendRas = [];
  $toSendPenyakit = [];

  for ($i = 0; $i < count($resultJh); $i++) {
    $jh = $resultJh[$i];
    $jh['total'] = 0;
    // Iterate through resultRm
    foreach ($resultRm as $rm) {
      if ($rm['jh_id'] == $jh['id']) {
        $jh['total'] += 1;
      }
    }
    array_push($toSendJh, $jh);
  }
  for ($i = 0; $i < count($resultRas); $i++) {
    $ras = $resultRas[$i];
    $ras['total'] = 0;
    // Iterate through resultRm
    foreach ($resultRm as $rm) {
      if ($rm['ras_id'] == $ras['id']) {
        $ras['total'] += 1;
      }
    }
    array_push($toSendRas, $ras);
  }

  for ($i = 0; $i < count($resultPenyakit); $i++) {
    $penyakit = $resultPenyakit[$i];
    $penyakit['total'] = 0;
    // Iterate through resultRm
    foreach ($resultRm as $rm) {
      if ($rm['penyakit_id'] == $penyakit['id']) {
        $penyakit['total'] += 1;
      }
    }
    array_push($toSendPenyakit, $penyakit);
  }

  $result = [
    'jenis_hewan' => $toSendJh,
    'ras' => $toSendRas,
    'penyakit' => $toSendPenyakit
  ];
  returnJson($result);