<?php
    function haveProperty($data, $name) {
        if (!isset($data[$name])) {
            http_response_code(500);
            die("property '$nama' is not set");
        }
        return true;
    }

    function haveProperties($data, $names) {
      foreach ($names as $name) {
        if (!haveProperty($data, $name)) return false;
      }
      return true;
    }

    function isOk($val, $msg) {
        if (!$val) {
            http_response_code(500);
            die($msg);
        }
    }
?>