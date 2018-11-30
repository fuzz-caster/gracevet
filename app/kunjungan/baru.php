<?php
  session_start();
  if (isset($_SESSION[BARU_ID])) {
    $stage = $_SESSION[BARU_STAGE];
    header('Location: /app/kunjungan/baru_' . $stage . '.php');
  } else {
    header('Location: /app/kunjungan/baru_pemilik.php');
  }
?>