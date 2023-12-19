WITH
    LIST_DETAIL
    AS
        (  SELECT kode_detail,
                  bel_kode_satker,
                  BEL_NOMOR_DIPA,
                  BEL_JENIS_REVISI,
                  BEL_REVISI_KE,
                  KOM_KODE,
                  KOM_URAIAN,
                  SUBKOM_KODE,
                  SUBKOM_URAIAN,
                  AKUN_KODE,
                  AKUN_KOTA,
                  AKUN_PROPINSI,
                  AKUN_BEBAN,
                  SUM (ITEM_TOTAL)      DIPA_TOTAL,
                  CATATAN_DIPA,
                  CATATAN_DIPA2,
                  AKUN_KODE_BLOKIR,
                  AKUN_URAIAN_BLOKIR,
                  AKUN_ALASAN_BLOKIR,
                  SUM (ITEM_BLOKIR)     DIPA_BLOKIR
             FROM (SELECT    bel_kode_kementerian
                          || '.'
                          || bel_kode_unit
                          || '.'
                          || out_kode_program
                          || '.'
                          || out_kode_kegiatan
                          || '.'
                          || out_kode_output
                          || '.'
                          || subout_kode                kode_detail,
                          bel_kode_satker,
                          BEL_NOMOR_DIPA,
                          BEL_JENIS_REVISI,
                          BEL_REVISI_KE,
                          KOM_KODE,
                          KOM_URAIAN,
                          SUBKOM_KODE,
                          SUBKOM_URAIAN,
                          AKUN_KODE_AKUN                AKUN_KODE,
                          AKUN_KODE_KOTA                AKUN_KOTA,
                          AKUN_KODE_PROPINSI            AKUN_PROPINSI,
                          AKUN_KODE_JENIS_BEBAN         AKUN_BEBAN,
                          item_harga_satuan,
                          ITEM_TOTAL,
                          AKUN_CATATAN_HAL4_DIPA        CATATAN_DIPA,
                          AKUN_CATATAN_HAL4_DIPA_2      CATATAN_DIPA2,
                          AKUN_KODE_BLOKIR,
                          AKUN_URAIAN_BLOKIR,
                          AKUN_ALASAN_BLOKIR,
                          (  ITEM_NILAI_BLOKIR_PHLN
                           + ITEM_NILAI_BLOKIR_RM
                           + ITEM_NILAI_BLOKIR_RMP
                           + ITEM_NILAI_BLOKIR_RPLN)    ITEM_BLOKIR
                     FROM SAKTIRKA.MV_ANGGARAN_BASE_TABLE_230930_231123
                    WHERE     BEL_JENIS_REVISI = 'DIPA_AWAL'
                          AND item_harga_satuan != 0 --Tambahan 12 Desember 2023
                                                    )
         GROUP BY kode_detail,
                  bel_kode_satker,
                  BEL_NOMOR_DIPA,
                  BEL_JENIS_REVISI,
                  BEL_REVISI_KE,
                  KOM_KODE,
                  KOM_URAIAN,
                  SUBKOM_KODE,
                  SUBKOM_URAIAN,
                  AKUN_KODE,
                  AKUN_KOTA,
                  AKUN_PROPINSI,
                  AKUN_BEBAN,
                  CATATAN_DIPA,
                  CATATAN_DIPA2,
                  AKUN_KODE_BLOKIR,
                  AKUN_URAIAN_BLOKIR,
                  AKUN_ALASAN_BLOKIR),
    LIST_REFERENSI
    AS
        (SELECT AA.kode_detail,
                AA.KDDEPT,
                AA.KDUNIT,
                aa.kdprogram,
                JJ.NMPROGRAM      NAMA_PROGRAM,
                aa.kdgiat,
                KK.NMGIAT         NAMA_GIAT,
                aa.kdoutput,
                LL.NMOUTPUT       NAMA_OUTPUT,
                aa.kdsoutput,
                AA.nmsoutput,
                AA.satuan,
                AA.kode_janpres,
                BB.NMJANPRES      NAMA_JANPRES,
                AA.kode_nawacita,
                CC.NMNAWACITA     NAMA_NAWACITA,
                AA.kode_pn,
                DD.NMPN           NAMA_PN,
                AA.kode_pp,
                EE.NMPP           NAMA_PP,
                AA.kode_kp,
                FF.NMKP           NAMA_KP,
                --   AA.kode_proyek,
                --   GG.NMPROY NAMA_PROY,
                --   AA.kode_tematik,
                AA.kode_pen,
                HH.NMPEN          NAMA_PEN,
                aa.tema_1,
                aa.nm_tema_1,
                aa.tema_2,
                aa.nm_tema_2,
                aa.tema_3,
                aa.nm_tema_3,
                aa.tema_4,
                aa.nm_tema_4,
                aa.tema_5,
                aa.nm_tema_5,
                aa.tema_6,
                aa.nm_tema_6,
                aa.tema_7,
                aa.nm_tema_7,
                aa.tema_8,
                aa.nm_tema_8,
                AA.kode_mp,
                MM.NMMP           URAIAN_MP,
                AA.KODE_PROYEK,
                GG.NMPROY         URAIAN_PROYEK,
                NN.KDSASARAN,
                NN.NMSASARAN      NAMA_SASARAN,
                NN.KDPROGSAS      KODE_PROGSAS,
                NN.NMPROGSAS      NAMA_PROGSAS,
                AA.KODE_GIATSAS,
                NN.NMGIATSAS      NAMA_GIATSAS
           FROM (SELECT DISTINCT
                           kddept
                        || '.'
                        || kdunit
                        || '.'
                        || kdprogram
                        || '.'
                        || kdgiat
                        || '.'
                        || kdoutput
                        || '.'
                        || kdsoutput
                            kode_detail,
                        kddept,
                        kdunit,
                        kdprogram,
                        kdgiat,
                        kdoutput,
                        kdsoutput,
                        nmsoutput,
                        sat
                            satuan,
                        TRIM (kdjanpres)
                            kode_janpres,
                        TRIM (kdnawacita)
                            kode_nawacita,
                        TRIM (kdpn)
                            kode_pn,
                        TRIM (kdpp)
                            kode_pp,
                        TRIM (kdkp)
                            kode_kp,
                        TRIM (kdtema)
                            kode_tematik,
                        TRIM (kdpen)
                            kode_pen,
                        CASE WHEN KDTEMA LIKE '%001%' THEN '001' END
                            AS tema_1,
                        CASE
                            WHEN KDTEMA LIKE '%001%'
                            THEN
                                'Anggaran Infrastruktur'
                        END
                            AS nm_tema_1,
                        CASE WHEN KDTEMA LIKE '%002%' THEN '002' END
                            AS tema_2,
                        CASE
                            WHEN KDTEMA LIKE '%002%'
                            THEN
                                'Kerjasama Selatan-Selatan dan Triangular (KSST)'
                        END
                            AS nm_tema_2,
                        CASE WHEN KDTEMA LIKE '%003%' THEN '003' END
                            AS tema_3,
                        CASE
                            WHEN KDTEMA LIKE '%003%'
                            THEN
                                'Anggaran Responsif Gender'
                        END
                            AS nm_tema_3,
                        CASE WHEN KDTEMA LIKE '%004%' THEN '004' END
                            AS tema_4,
                        CASE
                            WHEN KDTEMA LIKE '%004%'
                            THEN
                                'Mitigasi perubahan Iklim'
                        END
                            AS nm_tema_4,
                        CASE WHEN KDTEMA LIKE '%005%' THEN '005' END
                            AS tema_5,
                        CASE
                            WHEN KDTEMA LIKE '%005%'
                            THEN
                                'Anggaran Pendidikan'
                        END
                            AS nm_tema_5,
                        CASE WHEN KDTEMA LIKE '%006%' THEN '006' END
                            AS tema_6,
                        CASE
                            WHEN KDTEMA LIKE '%006%'
                            THEN
                                'Anggaran Kesehatan'
                        END
                            AS nm_tema_6,
                        CASE WHEN KDTEMA LIKE '%007%' THEN '007' END
                            AS tema_7,
                        CASE
                            WHEN KDTEMA LIKE '%007%'
                            THEN
                                'Adaptasi perubahan iklim'
                        END
                            AS nm_tema_7,
                        CASE WHEN KDTEMA LIKE '%008%' THEN '008' END
                            AS tema_8,
                        CASE
                            WHEN KDTEMA LIKE '%008%'
                            THEN
                                'Upaya Konvergensi Penanganan Stunting'
                        END
                            AS nm_tema_8,
                        TRIM (kdmp)
                            kode_mp,
                        TRIM (kdproy)
                            kode_proyek,
                        TRIM (kdsaskeg)
                            kode_giatsas
                   FROM SAKTIRKA.REF_SOUTPUT_230930_231123
                  WHERE THANG = '2023') AA
                LEFT JOIN
                (SELECT DISTINCT
                        TRIM (KDJANPRES)     KDJANPRES,
                        TRIM (NMJANPRES)     NMJANPRES
                   FROM SAKTIRKA.REF_T_JANPRES_230930_231123) BB
                    ON AA.kode_janpres = BB.KDJANPRES
                LEFT JOIN
                (SELECT DISTINCT
                        TRIM (KDNAWACITA)     KDNAWACITA,
                        TRIM (NMNAWACITA)     NMNAWACITA
                   FROM SAKTIRKA.REF_T_NAWACITA_230930_231123) CC
                    ON AA.kode_nawacita = CC.KDNAWACITA
                LEFT JOIN (SELECT DISTINCT TRIM (KDPN) KDPN, TRIM (NMPN) NMPN
                             FROM SAKTIRKA.REF_T_PRINAS_230930_231123) DD
                    ON AA.kode_pn = DD.KDPN
                LEFT JOIN
                (SELECT DISTINCT
                        TRIM (KDPN) KDPN, TRIM (KDPP) KDPP, TRIM (NMPP) NMPP
                   FROM SAKTIRKA.REF_T_PRIPROG_230930_231123) EE
                    ON AA.KODE_PN = EE.KDPN AND AA.kode_pp = EE.KDPP
                LEFT JOIN (SELECT DISTINCT TRIM (KDPN)     KDPN,
                                           TRIM (KDPP)     KDPP,
                                           TRIM (KDKP)     KDKP,
                                           TRIM (NMKP)     NMKP
                             FROM SAKTIRKA.REF_T_PRIGIAT_230930_231123) FF
                    ON     AA.KODE_PN = FF.KDPN
                       AND AA.kode_pp = FF.KDPP
                       AND AA.kode_kp = FF.KDKP
                LEFT JOIN (SELECT DISTINCT TRIM (KDPN)       KDPN,
                                           TRIM (KDPP)       KDPP,
                                           TRIM (KDKP)       KDKP,
                                           TRIM (KDPROY)     KDPROY,
                                           TRIM (NMPROY)     NMPROY
                             FROM SAKTIRKA.REF_T_PRIPROY_230930_231123) GG
                    ON     AA.KODE_PN = GG.KDPN
                       AND AA.kode_pp = GG.KDPP
                       AND AA.kode_kp = GG.KDKP
                       AND AA.kode_proyek = GG.KDPROY
                LEFT JOIN
                (SELECT DISTINCT TRIM (KDPEN) KDPEN, TRIM (NMPEN) NMPEN
                   FROM SAKTIRKA.REF_T_PEN_CLUSTER_220930_221120) HH
                    ON AA.kode_pen = TRIM (HH.KDPEN)
                LEFT JOIN (SELECT TRIM (KDDEPT)        KDDEPT,
                                  TRIM (KDUNIT)        KDUNIT,
                                  TRIM (KDPROGRAM)     KDPROGRAM,
                                  TRIM (NMPROGRAM)     NMPROGRAM
                             FROM SAKTIRKA.REF_PROGRAM_230930_231123
                            WHERE THANG = '2023') JJ
                    ON     AA.KDDEPT = JJ.KDDEPT
                       AND AA.KDUNIT = JJ.KDUNIT
                       AND AA.KDPROGRAM = JJ.KDPROGRAM
                LEFT JOIN (SELECT TRIM (KDDEPT)        KDDEPT,
                                  TRIM (KDUNIT)        KDUNIT,
                                  TRIM (KDPROGRAM)     KDPROGRAM,
                                  TRIM (KDGIAT)        KDGIAT,
                                  TRIM (NMGIAT)        NMGIAT
                             FROM SAKTIRKA.REF_GIAT_230930_231123
                            WHERE THANG = '2023') KK
                    ON     AA.KDDEPT = KK.KDDEPT
                       AND AA.KDUNIT = KK.KDUNIT
                       AND AA.KDPROGRAM = KK.KDPROGRAM
                       AND AA.KDGIAT = KK.KDGIAT
                LEFT JOIN (SELECT TRIM (KDDEPT)        KDDEPT,
                                  TRIM (KDUNIT)        KDUNIT,
                                  TRIM (KDPROGRAM)     KDPROGRAM,
                                  TRIM (KDGIAT)        KDGIAT,
                                  TRIM (KDOUTPUT)      KDOUTPUT,
                                  TRIM (NMOUTPUT)      NMOUTPUT
                             FROM SAKTIRKA.REF_OUTPUT_230930_231123
                            WHERE THANG = '2023') LL
                    ON     AA.KDDEPT = LL.KDDEPT
                       AND AA.KDUNIT = LL.KDUNIT
                       AND AA.KDPROGRAM = LL.KDPROGRAM
                       AND AA.KDGIAT = LL.KDGIAT
                       AND aa.KDOUTPUT = LL.KDOUTPUT
                LEFT JOIN
                (SELECT TRIM (KDMP) KDMP, TRIM (NMMP) NMMP
                   FROM SAKTIRKA.REF_MAJOR_PROJECT_230930_231123) MM
                    ON AA.kode_mp = MM.KDMP
                LEFT JOIN
                (SELECT AA.*,
                        BB.NMPROGSAS,
                        BB.KDSASARAN,
                        CC.NMSASARAN
                   FROM SAKTIRKA.REF_GIATSAS_230930_231123  AA
                        LEFT JOIN SAKTIRKA.REF_PROGSAS_230930_231123 BB
                            ON     AA.KDDEPT = BB.KDDEPT
                               AND AA.KDUNIT = BB.KDUNIT
                               AND AA.KDPROGRAM = BB.KDPROGRAM
                               AND AA.KDPROGSAS = BB.KDPROGSAS
                        LEFT JOIN saktirka.REF_SASARAN_230630_230705 cc
                            ON     AA.KDDEPT = CC.KDDEPT
                               AND BB.KDSASARAN = CC.KDSASARAN
                  WHERE AA.THANG = '2023') NN
                    ON     AA.KDDEPT = NN.KDDEPT
                       AND AA.KDUNIT = NN.KDUNIT
                       AND AA.KDPROGRAM = NN.KDPROGRAM
                       AND AA.KDGIAT = NN.KDGIAT
                       AND AA.kode_giatsas = NN.KDGIATSAS),
    LIST_SATKER
    AS
        (SELECT KODE_SATKER     kdsatker,
                NAMA_SATKER     nmsatker,
                BA              KDDEPT,
                NM_BA           NMDEPT,
                BAES1           KDBAES1,
                NM_ES1          NMBAES1
           FROM SAKTIKSL.MV_MASTER_SATKER_2023_231120)
SELECT AA1.kode_detail,
       CC1.KDDEPT,
       TRIM (CC1.NMDEPT)            NMDEPT,
       CC1.KDBAES1,
       TRIM (CC1.NMBAES1)           NMBAES1,
       AA1.bel_kode_satker          kode_satker,
       TRIM (CC1.nmsatker)          nmsatker,
       AA1.BEL_NOMOR_DIPA           nomor_dipa,
       AA1.BEL_JENIS_REVISI         JENIS_DIPA,
       AA1.bel_revisi_ke            revisi_ke,
       BB1.kdprogram,
       TRIM (BB1.NAMA_PROGRAM)      NAMA_PROGRAM,
       BB1.kdgiat,
       TRIM (BB1.NAMA_GIAT)         NAMA_GIAT,
       BB1.kdoutput,
       TRIM (BB1.NAMA_OUTPUT)       NAMA_OUTPUT,
       BB1.kdsoutput,
       TRIM (BB1.nmsoutput)         nmsoutput,
       BB1.satuan                   satuan_soutput,
       AA1.kom_kode,
       AA1.KOM_URAIAN,
       AA1.SUBKOM_KODE,
       AA1.SUBKOM_URAIAN,
       AA1.AKUN_KODE,
       DD1.NAMA_AKUN_KAS            NM_AKUN,
       AA1.AKUN_PROPINSI,
       EE1.DESKRIPSI                NM_PROPINSI,
       AA1.AKUN_KOTA,
       FF1.DESKRIPSI                NM_KOTA,
       AA1.AKUN_BEBAN,
       GG1.DESKRIPSI                BEBAN,
       GG1.UR_DESKRIPSI             NM_BEBAN,
       AA1.DIPA_TOTAL,
       AA1.CATATAN_DIPA,
       AA1.CATATAN_DIPA2,
       AA1.AKUN_KODE_BLOKIR         KODE_BLOKIR,
       AA1.AKUN_URAIAN_BLOKIR       URAIAN_BLOKIR,
       AA1.AKUN_ALASAN_BLOKIR       ALASAN_BLOKIR,
       AA1.DIPA_BLOKIR,
       BB1.kode_janpres,
       TRIM (BB1.NAMA_JANPRES)      NAMA_JANPRES,
       BB1.kode_nawacita,
       TRIM (BB1.NAMA_NAWACITA)     NAMA_NAWACITA,
       BB1.kode_pn,
       TRIM (BB1.NAMA_PN)           NAMA_PN,
       BB1.kode_pp,
       TRIM (BB1.NAMA_PP)           NAMA_PP,
       BB1.kode_kp,
       TRIM (BB1.NAMA_KP)           NAMA_KP,
       BB1.kode_pen,
       TRIM (BB1.NAMA_PEN)          NAMA_PEN,
       BB1.tema_1,
       BB1.nm_tema_1,
       BB1.tema_2,
       BB1.nm_tema_2,
       BB1.tema_3,
       BB1.nm_tema_3,
       BB1.tema_4,
       BB1.nm_tema_4,
       BB1.tema_5,
       BB1.nm_tema_5,
       BB1.tema_6,
       BB1.nm_tema_6,
       BB1.tema_7,
       BB1.nm_tema_7,
       BB1.tema_8,
       BB1.nm_tema_8,
       BB1.kode_mp,
       BB1.URAIAN_MP,
       BB1.KODE_PROYEK,
       BB1.URAIAN_PROYEK,
       BB1.KDSASARAN,
       BB1.NAMA_SASARAN,
       BB1.KODE_PROGSAS,
       BB1.NAMA_PROGSAS,
       BB1.KODE_GIATSAS,
       BB1.NAMA_GIATSAS
  FROM LIST_DETAIL  AA1
       LEFT JOIN LIST_REFERENSI BB1 ON AA1.kode_detail = BB1.kode_detail
       LEFT JOIN LIST_SATKER CC1 ON AA1.bel_kode_satker = CC1.kdsatker
       LEFT JOIN SAKTIKSL.MV_MASTER_AKUN_2023_231120 DD1
           ON AA1.AKUN_KODE = DD1.KODE_AKUN
       LEFT JOIN (SELECT DISTINCT *
                    FROM SAKTIKSL.BPK_ADM_R_LOKASI_220731
                   WHERE LEVEL_ = 2) EE1
           ON AA1.AKUN_PROPINSI = EE1.KODE
       LEFT JOIN (SELECT DISTINCT *
                    FROM SAKTIKSL.BPK_ADM_R_LOKASI_220731
                   WHERE LEVEL_ = 3) FF1
           ON AA1.AKUN_PROPINSI || '.' || AA1.AKUN_KOTA = FF1.KODE
       LEFT JOIN SAKTIKSL.REF_SUMBER_DANA_2023 GG1
           ON AA1.AKUN_BEBAN = GG1.KODE;