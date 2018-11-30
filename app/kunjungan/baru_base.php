<?php session_start(); ?>
<?php include $_SERVER['DOCUMENT_ROOT'] . '/base.php' ?>
<?php include_once __DIR__ . '/visit-structure.php' ?>

<?php
  define('BARU_API_URL', '/app/kunjungan/baru_api.php?command');
?>

<?php
    // Initialize visit structure
    init_structure($visit_structure, $valid_states);

    $stage = $_SESSION['baru_kunjungan_stage'];
    $structure = $_SESSION['baru_kunjungan_struktur'];
    $id = $_SESSION['baru_kunjungan_trans_id'];
    $validation = $_SESSION[BARU_VALID];
    if (isset($_GET['stage'])) {
        $stage = $_GET['stage'];
    }
    $navs = [
        [
            'text' => 'Pemilik',
            'stage' => 'pemilik'
        ],
        [
            'text' => 'Pasien',
            'stage' => 'pasien'
        ],
        [
            'text' => 'Rekam Medik',
            'stage' => 'rekam_medik'
        ],
        [
            'text' => 'Penanganan Khusus',
            'stage' => 'pen_khusus'
        ],
        [
            'text' => 'Hasil lab',
            'stage' => 'hasil_lab'
        ],
        [
            'text' => 'Review',
            'stage' => 'review'
        ]
    ];
?>

<?php startblock('curr_page') ?>
  Kunjungan
<?php endblock() ?>

<?php startblock('breadcrumb') ?>
  <li><a href="#"><i class="fa fa-dashboard"></i> Kunjungan</a></li>
  <li class="active">Baru</li>
<?php endblock() ?>

<?php startblock('main_content') ?>
    <div class="row">
        <div class="col-sm-12">
          <div class="box box-solid">
            <div class="box-body">
              <div class="row">
                
                <div class="col-sm-8">
                  <div class="kunjungan-state-bar">
                      <?php foreach ($navs as $nav) {
                          $currStage = $nav['stage'];
                          $isValid = $validation[$currStage] ? ' bg-green' : ' bg-maroon';
                          $isActiveClass = $stage == $currStage ? ' active' : '';
                          $classes = 'btn btn-flat ' . $isValid . $isActiveClass;
                          echo "<a class='$classes' href='/app/kunjungan/baru_$nav[stage].php'>$nav[text]</a>";
                      } ?>
                  </div>
                </div>

                <div class="col-sm-4 text-right">
                    <div class="btn-group">
                      <button class="btn btn-flat bg-orange">Batal</button>
                      <button class="btn btn-info">Simpan</button>
                    </div>
                </div>
              </div>
            </div>
          </div>
        </div>
    </div>
    <?php startblock('baru_main_content') ?>
    <?php endblock() ?>
<?php endblock() ?>