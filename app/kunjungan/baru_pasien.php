<?php include_once __DIR__ . '/baru_base.php' ?>
<?php include_once $_SERVER['DOCUMENT_ROOT'] . '/conf.php' ?>
<?php include_once $_SERVER['DOCUMENT_ROOT'] . '/koneksi.php' ?>
<?php include_once $_SERVER['DOCUMENT_ROOT'] . '/VUE_js_snippet.php' ?>
<?php include_once $_SERVER['DOCUMENT_ROOT'] . '/app/ras/api_dao_ras.php' ?>
<?php include_once __DIR__ . '/visit-structure.php' ?>

<?php
  $pasien = [
    'nama' => '',
    'jk' =>  1,
    'signalemen' => '',
    'lahir' => '',
    'id_ras' => null
  ];
  if (isset($_SESSION[BARU_ID_KEY])) {
    // Copy from session to $pasien
    $temp = $_SESSION[BARU_STRUCT]['pasien'];
    $nama = $temp['nama'];
    $lahir = $temp['lahir']['value'];
    $jk = $temp['jk']['value'];
    $signalemen = $temp['signalemen'];
    $id_ras = $temp['id_ras']['value'];
  }
  
  // Get all ras
  $ras_list = $DAO_ras->list();
?>

<?php startblock('baru_main_content') ?>
  <div id="vue_app">
    <?php require __DIR__ . '/baru_state_alert.php' ?>
    <div class="row">
      <!-- left column -->
      <div class="col-md-6 col-md-offset-3">
  
        <!-- Form Element sizes -->
        <div id="vue_app" class="box box-success">
          <div class="box-header with-border">
            <h3 class="box-title">Tambah Pasien</h3>
          </div>
          <form class="form-horizontal" method="post" action="/app/pasien/api_dao_pasien.php?command=add">
              <div class="box-body">
  
                  <div class="form-group">
                      <label class="col-sm-2 control-label">Nama</label>
                      <div class="col-sm-10">
                        <input
                            v-model="nama"
                            name="nama"
                            class="form-control" type="text" placeholder="Nama">
                        <?php VUE_validation_block('nama') ?>
                      </div>
                  </div>
  
                  <div class="form-group">
                      <label class="col-sm-2 control-label">Ras</label>
                      <div class="col-sm-10">
                          <select class="form-control" name="id_ras" v-model="id_ras">
                              <option v-for="r in ras_list" :value="r.id" :key="r.id">
                                  {{ r.nama }}
                              </option>
                          </select>
                          <?php VUE_validation_block('id_ras') ?>
                      </div>
                  </div>
  
                  <div class="form-group">
                      <label class="col-sm-2 control-label">Jenis Kelamin</label>
                      <div class="col-sm-10">
                          <select class="form-control" name="jk" v-model="jk">
                          <option v-for="j in jk_list" :value="j.id">
                              {{ j.nama }}
                          </option>
                          </select>
                      </div>
                  </div>
  
                  <div class="form-group">
                      <label class="col-sm-2 control-label">Signalemen</label>
                      <div class="col-sm-10">
                          <input
                              v-model="signalemen"
                              name="signalemen"
                              class="form-control" type="text" placeholder="Signalemen">
                          <?php VUE_validation_block('signalemen') ?>
                      </div>
                  </div>
  
                  <div class="form-group">
                      <label class="col-sm-2 control-label">Lahir</label>
                      <div class="col-sm-10">
                        <input
                          v-model="lahir"
                          name="lahir"
                          type="date"
                          class="form-control" type="text">
                        <?php VUE_validation_block('lahir') ?>
                      </div>
                  </div>
  
                  <button v-bind:disabled="!formValid" type="submit" class="btn btn-lg btn-block btn-primary">Simpan</button>
              </div><!-- /.box-body -->
          </form>
        </div><!-- /.box -->
  
      </div><!--/.col (left) -->
    </div>
  </div>
<?php endblock() ?>

<?php startblock('scripts') ?>
  <?php superblock() ?>
  <script src="<?php staticContent('dist/js/axios.js'); ?>"></script>
  <script src="<?php staticContent('dist/js/vue.js'); ?>"></script>
  <script>
    console.log('HERE');
    var app = new Vue({
      el: '#vue_app',
      data: {
        nama: "<?php echo $nama ?>",
        signalemen: "<?php echo $signalemen ?>",
        lahir: <?php if (!$lahir) echo 'null'; else echo $lahir; ?>,
        jk: <?php echo $jk ?>,
        id_ras: <?php if (!$id_ras) echo 'null'; else echo $id_ras; ?>,

        ras_list: [
            <?php
                $temp1 = array_map(function ($jh) {
                  $nama = $jh['nama'];
                  $id = $jh['id'];
                  return "
                      {
                        nama: '$nama',
                        id: $id
                      }
                  ";
                  }, $ras_list);
                echo implode(',', $temp1);
            ?>
        ],
        jk_list: [
            {
                id: 0,
                nama: 'Betina'
            },
            {
                id : 1,
                nama : 'Jantan'
            }
        ],

        saveState: 'idle',
        saveIntervalId: null
      },
      computed: {
        formValid () {
          return Object.values(this.validations).map(it => it.value).reduce((a, b) => a && b);
        },
        validations () {
          return {
            nama: {
              value: this.nama != null && this.nama != '',
              msg: 'Nama harus diisi'
            },
            signalemen: {
              value: this.signalemen != null && this.signalemen != '',
              msg: 'Signalemen harus diisi'
            },
            id_ras: {
              value: this.id_ras != null,
              msg: 'Id ras harus diisi'
            },
            lahir: {
              value: this.lahir != null && this.lahir != '',
              msg: 'Tanggal Lahir harus diisi'
            }
          };
        }
      },
      methods: {
        save () {
          if (!this.formValid) {
            return;
          }
          var payload = {
            nama: this.nama,
            jk: this.jk,
            signalemen: this.signalemen,
            lahir: this.lahir,
            id_ras: this.id_ras
          };
          this.saveState = 'saving';
          clearInterval(this.setIntervalId);
          axios.post("<?php echo BARU_API_URL ?>=kunjungan_baru_pasien", payload)
            .then
              (resp => {
                setTimeout(() => {
                  this.saveState = 'success';
                }, 2000);
              })
            .catch
              (err => {
                setTimeout(() => {
                  this.saveState = 'fail';
                }, 2000);
              })
            .then(
              () => {
                setTimeout(() => {
                  this.saveState = 'idle';
                }, 5000);
                this.setAutoSaving();
              });
        },
        setAutoSaving () {
          // Auto-save
          this.setIntervalId = setInterval(() => {
            this.save();
          }, 20000);
        }
      },
      mounted () {
        this.setAutoSaving();
      }
    })
  </script>
<?php endblock() ?>