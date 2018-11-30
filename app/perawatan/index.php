<?php

    include_once $_SERVER['DOCUMENT_ROOT'] . '/koneksi.php';
    include_once $_SERVER['DOCUMENT_ROOT'] . '/conf.php';
    include_once $_SERVER['DOCUMENT_ROOT'] . '/app/counter.php';

    // Handle the commands
    // POST data
    if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_GET['command']) && $_GET['command'] == 'add') {
        $data = json_decode(file_get_contents('php://input'), true);
        $rm_id = $data['rm_id'];
        $waktu = $data['waktu'];
        $keterangan = $data['keterangan'];
        $nxm = $data['nxm'];
        $pxm = $data['pxm'];
        $toc = $data['toc'];
        $tipe = $data['tipe'];
        $query = "INSERT INTO perawatan (rm_id, waktu, keterangan, nxm, pxm, toc, tipe) VALUES 
            ($rm_id, '$waktu', '$keterangan', $nxm, $pxm, '$toc', '$tipe')";
        $result = $db->query($query);
        if (!$result) {
            http_response_code(500);
            echo $query;
            die('Error: can not add perawatan');
        }
        http_response_code(201);
    }

    if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['command']) && $_GET['command'] == 'load_by_rm') {
        $rm_id = $_GET['rm_id'];
        $query = "SELECT * FROM perawatan WHERE rm_id = $rm_id ORDER BY waktu ASC";
        $result = $db->query($query);
        $result = $result->fetch_all(MYSQLI_ASSOC);
        returnJson($result);
    }

    if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['command']) && $_GET['command'] == 'delete') {
        $id = $_GET['id'];
        $query = "DELETE FROM perawatan WHERE id = $id";
        $result = $db->query($query);
        if (!$result) {
            http_response_code(500);
            die('Error: can not remove perawatan');
        }
        http_response_code(201);
        die('ok');
    }
