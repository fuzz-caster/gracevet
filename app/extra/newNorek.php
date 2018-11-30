<?php
  include_once $_SERVER['DOCUMENT_ROOT'] . '/koneksi.php';
  include_once $_SERVER['DOCUMENT_ROOT'] . '/conf.php';

  $result = $db->query('SELECT MAX(norek) + 1 as new_norek FROM `pasien` LIMIT 1 ');
  $result = $result->fetch_array();

  returnJson($result);