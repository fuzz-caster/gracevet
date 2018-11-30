<?php

  function create_pemilik ($db, $pemilik) {
    $query = "INSERT INTO pemilik (nama, alamat, no_telp) VALUES (?, ?, ?)";
    $statement = $db->prepate($query);
    if (!$statement) {
      throw new Exception('Fail to create statement');
    }
    $bindSuccessful = $statement->bind_param('sss', $pemilik['nama'], $pemilik['alamat'], $pemilik['no_telp']);
    if (!$bindSuccessful) {
      throw new Exception('Fail to bind parameters');
    }

    $result = $statement->execute();
    if (!$result) {
      throw new Exception('Fail to execute statement');
    }

    $insert_id = $statement->insert_id;
    return $insert_id;
  }

  function create_pasien ($db, $pasien) {
    $query = "INSERT INTO pasien (nama, lahir, jk, id_ras, signalemen) VALUES (?, ?, ?, ?, ?)";
    $statement = $db->prepate($query);
    if (!$statement) {
      throw new Exception('Fail to create statement');
    }
    $bindSuccessful = $statement->bind_param('ssiis', 
                          $pasien['nama'], $pasien['lahir'], $pasien['jk'],
                          $pasien['id_ras'], $pasien['signalemen']
                      );
    if (!$bindSuccessful) {
      throw new Exception('Fail to bind parameters');
    }

    $result = $statement->execute();
    if (!$result) {
      throw new Exception('Fail to execute statement');
    }

    $insert_id = $statement->insert_id;
    return $insert_id;
  }

  function create_rekam_medik ($db, $pasien_id, $pemilik_id) {
    $query = 'INSERT INTO rekam_medik';
  }

  $QUERY = [
    'INSERT_PASIEN' => "
      INSERT INTO pasien (nama, lahir, jk, id_ras, signalemen) VALUES (?, ?, ?, ?, ?)
    ",

    'INSERT_PEMILIK' => 
  ];

  if ($_REQUEST['method'] == 'POST' && isset($_GET['command']) && $_GET['command'] == 'PasienBaruPemilikBaru') {
    $data = json_decode(file_get_contents('php://input'), true);
    $pemilik = $data['pemilik'];
    $pasien = $data['pasien'];
  }