<?php session_start() ?>
<?php include_once $_SERVER['DOCUMENT_ROOT'] . '/koneksi.php' ?>
<?php include_once $_SERVER['DOCUMENT_ROOT'] . '/app/pemilik/api_dao_pemilik.php' ?>
<?php include_once $_SERVER['DOCUMENT_ROOT'] . '/app/pasien/api_dao_pasien.php' ?>
<?php include_once $_SERVER['DOCUMENT_ROOT'] . '/app/rekam-medik/api_dao_rekam_medik.php' ?>

<?php

  if ($_SERVER['REQUEST_METHOD'] == 'POST' &&  isset($_GET['command']) && $_GET['command'] == 'kunjungan_baru') {
    $data = json_decode(file_get_contents('php://input'), true);

    $pemilik_id = $data['pemilikId'];
    $pasien_id = $data['pasienId'];
    $penyakit_id = $data['penyakitId'];

    $data['rekamMedik']['pasien_id'] = $pasien_id;
    $data['rekamMedik']['pemilik_id'] = $pemilik_id;
    $data['rekamMedik']['penyakit_id'] = $penyakit_id;
    $rm_id = $DAO_rm->add($data['rekamMedik']);

    // Link to hasil lab.
    $insertHasilLabBaseQuery = 'INSERT INTO hasil_lab (id_tipe_hasil_lab, id_rekam_medik, struktur) VALUES ';
    foreach ($data['hasilLab'] as $hl) {
      $id_tipe_hasil_lab = $hl['id'];
      $struktur = json_encode($hl['struktur']);
      $insertHasilLabQuery = $insertHasilLabBaseQuery . " ($id_tipe_hasil_lab, $rm_id, '$struktur') ";
      $insertHasilLabQueryResult = $db->query($insertHasilLabQuery);
      if (!$insertHasilLabQueryResult) {
        http_response_code(500);
        die('Fail to insert hasil_lab : ' . $insertHasilLabQuery);
      }
    }

    // Link to penanganan khusus.
    $query = 'INSERT INTO pen_khusus (id_tipe_pen_khusus, id_rekam_medik, deskripsi) VALUES ';
    foreach ($data['penKhusus'] as $hl) {
      $id_tipe_pen_khusus = $hl['id'];
      $deskripsi = $hl['value'];
      $insertPenKhususQuery = $insertHasilLabBaseQuery . " ($id_tipe_pen_khusus, $rm_id, '$deskripsi') ";
      $insertPenKhususQueryResult = $db->query($insertPenKhususQuery);
      if (!$insertPenKhususQueryResult) {
        http_response_code(500);
        die('Fail to insert pen_khusus : ' . $insertPenKhususQuery);
      }
    }
    
    http_response_code(201);
    echo json_encode([
      'id' => $rm_id
    ]);
    die();
  }
?>