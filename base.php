<?php include_once __DIR__ . '/ti.php'; ?>
<!DOCTYPE html>
<html>
  <head>
    <?php include_once __DIR__ . '/commons/head.php'; ?>
  </head>
  <body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">

      <?php include_once __DIR__ . '/commons/header.php'; ?>
      <?php include_once __DIR__ . '/commons/left-aside.php'; ?>

      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            <?php emptyblock('curr_page'); ?>
          </h1>
          <ol class="breadcrumb">
            <?php emptyblock('breadcrumb'); ?>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
          <?php emptyblock('main_content'); ?>
        </section><!-- /.content -->
      </div><!-- /.content-wrapper -->

      <?php include_once __DIR__ . '/commons/footer.php'; ?>
      <?php include_once __DIR__ . '/commons/control-sidebar.php'; ?>
    </div><!-- ./wrapper -->

    <?php startblock('scripts') ?>
      <?php include_once __DIR__ . '/commons/scripts.php'; ?>
    <?php endblock() ?>
  </body>
</html>
