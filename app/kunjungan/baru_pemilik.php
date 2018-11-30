<?php include_once __DIR__ . '/baru_base.php' ?>
<?php include_once __DIR__ . '/visit-structure.php' ?>

<?php
  $pemilik = [
    'nama' => '',
    'no_telp' => '',
    'alamat' => ''
  ];
  // var_dump($_SESSION);
  // die();
  if (isset($_SESSION[BARU_ID_KEY])) {
    $pemilik = $_SESSION[BARU_STRUCT]['pemilik'];
  }
  $nama = $pemilik['nama'];
  $no_telp = $pemilik['no_telp'];
  $alamat = $pemilik['alamat'];
?>

<?php startblock('baru_main_content') ?>
  <div id="vue_app">
    <?php require __DIR__ . '/baru_state_alert.php' ?>
    <div class="row" style="margin-top: 32px;">
        <!-- left column -->
        <div class="col-md-6 col-md-offset-3">

            <!-- Form Element sizes -->
            <div class="box box-success">
              <div class="box-header with-border">
                  <h3 class="box-title">Tambah Pemilik</h3>
              </div>
              <form class="form-horizontal" method="post" action="/app/pemilik/api_dao_pemilik.php?command=add">
                  <div class="box-body">

                  <div class="form-group">
                      <label class="col-sm-2 control-label">Nama</label>
                      <div class="col-sm-10">
                      <input
                          v-model="nama"
                          name="nama"
                          class="form-control" type="text" placeholder="Nama">
                      </div>
                  </div>

                  <div class="form-group">
                      <label class="col-sm-2 control-label">No. Telp</label>
                      <div class="col-sm-10">
                      <input
                          v-model="no_telp"
                          name="no_telp"
                          class="form-control" type="text" placeholder="No. Telp">
                      </div>
                  </div>

                  <div class="form-group">
                      <label class="col-sm-2 control-label">Alamat</label>
                      <div class="col-sm-10">
                      <input
                          v-model="alamat"
                          name="alamat"
                          class="form-control" type="text" placeholder="Alamat">
                      </div>
                  </div>

                  <button v-bind:disabled="!formValid" type="button" 
                    v-on:click="save" class="btn btn-lg btn-block btn-primary">Simpan</button>
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
        alamat: "<?php echo $alamat ?>",
        no_telp: "<?php echo $no_telp ?>",
        saveProgress: 0,
        saveState: 'idle',
        saveIntervalId: null
      },
      computed: {
        formValid () {
          return this.nama != '' && this.alamat != '' && this.no_telp != '';
        }
      },
      methods: {
        save () {
          var payload = {
            nama: this.nama,
            alamat: this.alamat,
            no_telp: this.no_telp
          };
          this.saveState = 'saving';
          clearInterval(this.setIntervalId);
          axios.post("<?php echo BARU_API_URL ?>=kunjungan_baru_pemilik", payload)
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