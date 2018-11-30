<?php session_start() ?>
<?php include_once $_SERVER['DOCUMENT_ROOT'] . '/koneksi.php' ?>
<?php include_once $_SERVER['DOCUMENT_ROOT'] . '/conf.php'; ?>
<?php include_once $_SERVER['DOCUMENT_ROOT'] . '/app/pemilik/api_dao_pemilik.php' ?>
<?php include_once $_SERVER['DOCUMENT_ROOT'] . '/app/pasien/api_dao_pasien.php' ?>
<?php include_once $_SERVER['DOCUMENT_ROOT'] . '/app/rekam-medik/api_dao_rekam_medik.php' ?>
<?php
if ($_SERVER['REQUEST_METHOD'] != 'POST' || empty($_GET['command'])) {
  http_response_code(500);
  die('Unsupported method or command errror');
};

$command = $_GET['command'];
$data = json_decode(file_get_contents('php://input'), true);

$pemilik_id = null;
$pasien_id = null;

if ($command == 'PasienBaruPemilikBaru') {

  $pasien_id = $DAO_pasien->add($data['pasien']);
  $pemilik_id = $DAO_pemilik->add($data['pemilik']);

} else if ($command == 'PasienBaruPemilikLama') {

  $pasien_id = $DAO_pasien->add($data['pasien']);
  $pemilik_id = $data['pemilik_id'];

} else if ($command == 'PasienLamaPemilikBaru') {
  $pasien_id = $data['pasien_id'];
  $pemilik_id = $DAO_pemilik->add($data['pemilik']);

} else if ($command == 'PasienLamaPemilikLama') {

  $pasien_id = $data['pasien_id'];
  $pemilik_id = $data['pemilik_id'];

}

else {
  http_response_code(500);
  die('UNKNOWN COMMAND: ' . $command);
}

try {
  $rm_id = $DAO_rm->addMinimal($pemilik_id, $pasien_id);
  $result = [ 'id' => $rm_id ];
  returnJson($result);
} catch (Exception $ex) {
  http_response_code(500);
  var_dump($ex);
  die('Error');
}
?>