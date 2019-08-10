<?php
  include_once $_SERVER['DOCUMENT_ROOT'] . '/koneksi.php';
  include_once $_SERVER['DOCUMENT_ROOT'] . '/conf.php';
  include_once $_SERVER['DOCUMENT_ROOT'] . '/app/rekam-medik/api_dao_rekam_medik.php';

  if (empty($_GET['id_kunjungan'])) {
    die('Butuh id kunjungan');
  }

  $id_kunjungan = $_GET['id_kunjungan'];

  $rm = $DAO_rm->getById($id_kunjungan);
  $hasil_lab = $DAO_rm->getHasilLab($id_kunjungan);
  $pen_khusus = $DAO_rm->getPenangananKhusus($id_kunjungan);

  // var_dump($hasil_lab);
  // die();
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Print Kunjungan</title>

  <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
  <link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">


</head>
<body>
  <div class="container my-4">
    <div class="col-md-8 mx-auto">
      <table id="main-table" class="table table-striped">
        <thead>
          <td></td>
          <td></td>
        </thead>
        <tbody>
          <tr>
            <td>Norek: </td>
            <td><?php echo $rm['tipe_norek'] . ' - ' . $rm['norek'] ?></td>
          </tr>
          <tr>
            <td></td>
            <td></td>
          </tr>
          <tr>
            <td><strong>Pasien</strong></td>
            <td></td>
          </tr>
          <tr>
            <td>Nama: </td>
            <td><?php echo $rm['pasien_nama'] ?></td>
          </tr>
          <tr>
            <td>Jenis Hewan: </td>
            <td><?php echo $rm['jh_nama'] ?></td>
          </tr>
          <tr>
            <td>Ras: </td>
            <td><?php echo $rm['ras_nama'] ?></td>
          </tr>
          <tr>
            <td>Umur: </td>
            <td><?php echo $rm['umur'] ?> Tahun (<?php echo $rm['pasien_lahir'] ?>)</td>
          </tr>
          <tr>
            <td><strong>Pemilik</strong></td>
            <td></td>
          </tr>
          <tr>
            <td>Nama</td>
            <td><?php echo $rm['pemilik_nama'] ?></td>
          </tr>
          <tr>
            <td>Alamat</td>
            <td><?php echo $rm['pemilik_alamat'] ?></td>
          </tr>
          <tr>
            <td>No. Telp</td>
            <td><?php echo $rm['pemilik_no_telp'] ?></td>
          </tr>
          <tr>
            <td><strong>Data</strong></td>
            <td></td>
          </tr>
          <tr>
            <td>Tanggal</td>
            <td><?php echo $rm['tanggal'] ?></td>
          </tr>
          <tr>
            <td>Berat</td>
            <td><?php echo $rm['berat'] ?></td>
          </tr>
          <tr>
            <td>Freq. N</td>
            <td><?php echo $rm['freq_n'] ?></td>
          </tr>
          <tr>
            <td>Freq. P</td>
            <td><?php echo $rm['freq_p'] ?></td>
          </tr>
          <tr>
            <td>Freq. T</td>
            <td><?php echo $rm['freq_t'] ?></td>
          </tr>
          <tr>
            <td>MTH</td>
            <td><?php echo $rm['mth'] ?></td>
          </tr>
          <tr>
            <td>Mulut</td>
            <td><?php echo $rm['mulut'] ?></td>
          </tr>
          <tr>
            <td>Peredaran Darah</td>
            <td><?php echo $rm['peredaran_darah'] ?></td>
          </tr>
          <tr>
            <td>Pencernaan</td>
            <td><?php echo $rm['pencernaan'] ?></td>
          </tr>
          <tr>
            <td>Kulit Rambut</td>
            <td><?php echo $rm['kul_rambut'] ?></td>
          </tr>
          <tr>
            <td>Kelenjar Limfe</td>
            <td><?php echo $rm['kelenjar_limfe'] ?></td>
          </tr>
          <tr>
            <td>Pernapasan</td>
            <td><?php echo $rm['pernapasan'] ?></td>
          </tr>
          <tr>
            <td>Kelamin Perkencingam</td>
            <td><?php echo $rm['kelamin_perkencingan'] ?></td>
          </tr>
          <tr>
            <td>Anggota Gerak</td>
            <td><?php echo $rm['ang_gerak'] ?></td>
          </tr>
          <tr>
            <td>Diagnosa</td>
            <td><?php echo $rm['diagnosa'] ?></td>
          </tr>
          <tr>
            <td>Prognosis</td>
            <td><?php echo $rm['prognosis'] ?></td>
          </tr>
          <tr>
            <td>Anamnesis</td>
            <td><?php echo $rm['anamnesis'] ?></td>
          </tr>
          <tr>
            <td>Keadaan Umum</td>
            <td><?php echo $rm['keadaan_umum'] ?></td>
          </tr>
          <tr>
            <td>Terapi</td>
            <td><?php echo $rm['terapi'] ?></td>
          </tr>
          <tr>
            <td>Hasil Lab</td>
            <td></td>
          </tr>
          <?php 
            foreach ($hasil_lab as $hl) { ?>
              <tr>
                <td>
                  <strong><div><?php echo $hl['nama_tipe'] ?></div></strong>
                </td>
                <td>
                </td>
              </tr>
              <?php 
                $struktur = json_decode($hl['struktur']);
                foreach ($struktur as $st) { 
              ?>
                <tr>
                  <td>
                    <?php echo $st->nama ?>
                  </td>
                  <td>
                    <?php echo $st->value ?>
                  </td>
                </tr>
                <?php } ?>
            <?php }
          ?>
          <tr>
            <td>Penanganan Khusus</td>
            <td></td>
          </tr>
          <?php foreach ($pen_khusus as $pk) { ?>
              <tr>
                <td>
                  <strong><div><?php echo $pk['nama_tipe'] ?></div></strong>
                </td>
                <td>
                  <?php echo $pk['deskripsi'] ?>
                </td>
              </tr>
          <?php } ?>
        </tbody>
      </table>
    </div>
  </div>

  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
  <script src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js"></script>
  <script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.print.min.js"></script>
  <script>
    $(document).ready(function() {
      $('#main-table').DataTable({
          columns: [
            { "width": "40%" },
            { "width": "60%" }
          ],
          dom: 'Bfrtip',
          buttons: [
            {
                extend: 'print',
                customize: function ( win ) {
                    $(win.document.body)
                        .css( 'font-size', '14pt' );
 
                    $(win.document.body).find( 'table' )
                        .addClass( 'compact' )
                        .css( 'font-size', 'inherit' );
                }
            }
          ],
          paging: false,
          ordering: false,
          info: false
      });
    });
  </script>
</body>
</html>