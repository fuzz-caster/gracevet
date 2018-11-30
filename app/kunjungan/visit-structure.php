<?php include_once $_SERVER['DOCUMENT_ROOT'] . '/conf.php' ?>

<?php
    $visit_structure = [
        'pemilik' =>  [
            'nama' => '',
            'alamat' => '',
            'no_telp' => ''
        ],
        'pasien' => [
            'nama' => '',
            'jk' => [
                'type' => 'select',
                'options' => [ '1:Jantan', '0:Betina' ],
                'value' => 1
            ],
            'signalemen' => '',
            'lahir' => [
                'type' => 'date',
                'value' => null
            ],
            'id_ras' => [
              'type' => 'select',
              'value' => null
          ]
        ],
        'rekam_medik' => [
            'tanggal' => [
                'type' => 'date',
                'value' => ''
            ],
            'berat' => [
                'type' => 'number',
                'value' => 0
            ],
            'tipe_norek' => [
                'type' => 'select',
                'options' => [ 'GA:GA', 'GB:GB', 'GC:GC', 'GD:GD' ],
                'value' => 'GA'
            ],
            'norek' => '',
            'freq_n' => [
                'type' => 'number',
                'value' => 0
            ],
            'freq_p' => [
                'type' => 'number',
                'value' => 0
            ],
            'freq_t' => [
                'type' => 'number',
                'value' => 0
            ]
        ]
    ];

    $valid_states = [
      'pemilik' => false,
      'pasien' => false,
      'rekam_medik' => false,
      'pen_khusus' => true,
      'hasil_lab' => true,
      'review' => true
    ];

    define('BARU_ID_KEY', 'baru_kunjungan_trans_id');
    define('BARU_STAGE', 'baru_kunjungan_stage');
    define('BARU_STRUCT', 'baru_kunjungan_struktur');
    define('BARU_VALID', 'baru_kunjungan_validation');

    function init_structure ($struct, $valid_states) {
        if (empty($_SESSION[BARU_ID_KEY])) {
            $_SESSION[BARU_ID_KEY] = generateRandomString();
            $_SESSION[BARU_STAGE] = 'pemilik';
            $_SESSION[BARU_STRUCT] = $struct;
            $_SESSION[BARU_VALID] = $valid_states;

            return;
        }
    }
?>