<?php
  include_once $_SERVER['DOCUMENT_ROOT'] . '/koneksi.php';
  include_once $_SERVER['DOCUMENT_ROOT'] . '/conf.php';

  if (empty($_GET['id_pasien'])) {
    die();
  }

  $id_pasien = $_GET['id_pasien'];
  $result = $db->query("SELECT 
    pemilik.*
    LEFT JOIN pemilik ON pasien.temp_pemilik_id = pemilik.id
    WHERE pasien.id = $id_pasien
    LIMIT 1
  ");
  $result = $result->fetch_array();

  returnJson($result);