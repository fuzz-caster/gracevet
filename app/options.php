<?php
  include_once $_SERVER['DOCUMENT_ROOT'] . '/koneksi.php';
  include_once $_SERVER['DOCUMENT_ROOT'] . '/conf.php';

  function options($db, $tbname) {
    $query = "SELECT id as `value`, nama as `text` FROM $tbname";
    if ($tbname == 'pasien') {
      $query = "SELECT id as `value`, CONCAT('#', tipe_norek, ':', norek, ' - ', nama) as `text` FROM $tbname";
    }
    $result = $db->query($query);
    if (!$result) {
      die('Fail to query options on table: ' . $tbname);
    }
    $result = $result->fetch_all(MYSQLI_ASSOC);
    return $result;
  }

  if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['command']) && $_GET['command'] == 'load') {
    if (empty($_GET['tbname'])) {
      die('Error: tablename is not defined');
    }
    $tbname = $_GET['tbname'];
    returnJson(options($db, $tbname));
  }
?>