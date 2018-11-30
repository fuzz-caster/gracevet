<?php
    mysqli_report(MYSQLI_REPORT_STRICT);
    define('BASE_URL', 'http://localhost');
    define('APP_NAME', 'GraceVET');
    $BASE_PATH = $_SERVER['DOCUMENT_ROOT'];

    function staticContent ($relPath) {
        echo BASE_URL . '/' . $relPath;
    }

    function appLink ($path) {
        echo BASE_URL . '/' . $path;
    }

    function checkQuery($cmd, $val) {
        $comps = parse_url($_SERVER['REQUEST_URI'], PHP_URL_QUERY);
    }

    function generateRandomString($length = 10) {
        $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $charactersLength = strlen($characters);
        $randomString = '';
        for ($i = 0; $i < $length; $i++) {
            $randomString .= $characters[rand(0, $charactersLength - 1)];
        }
        return $randomString;
    }

    function returnJson($any) {
      header('Content-type:application/json;charset=utf-8');
      echo json_encode($any);
    }
?>