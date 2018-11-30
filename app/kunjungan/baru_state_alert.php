<div class="row">
      <div class="col-sm-12">
        <div class="alert alert-success" v-if="saveState == 'success'">
          Sukses simpan data
        </div>
        <div class="alert alert-danger" v-if="saveState == 'fail'">
          Gagal simpan data
        </div>
        <div class="alert alert-warning" v-if="saveState == 'idle'">
          Menunggu Perubahan
        </div>
        <div class="alert alert-info" v-if="saveState == 'saving'">
          Autosaving...
        </div>
      </div>
    </div>