DROP MATERIALIZED VIEW SAKTIKSL.MV_GLP_BUKU_BESAR_220930_221023;
CREATE MATERIALIZED VIEW SAKTIKSL.MV_GLP_BUKU_BESAR_220930_221023
PARALLEL 4 
AS
/*
Table Required: 
	saktiksl.BPK_GLP_BUKU_BESAR_220930_221023						ADA
	SAKTIKSL.BPK_ADM_R_KEMENTERIAN_220731							ADA
	SAKTIKSL.BPK_ADM_R_SATKER_220731								ADA
	SAKTIKSL.BPK_ADM_R_KEWENANGAN_220731							ADA
	SPAN.T_FUNGSI_span_310820										ADA
	SPAN.T_SUBFUNGSI_span_310820									ADA
	SAKTIKSL.T_PROGRAM_220912										ADA
	SAKTIKSL.T_GIAT_220912											ADA
	SAKTIKSL.BPK_ADM_R_LOKASI_220731								ADA
	SAKTIKSL.REF_KPPN_2022											ADA
	SAKTIKSL.REF_SUMBER_DANA_2022									ADA
	SAKTIKSL.REF_CARA_TARIK_2022									ADA
*/
select	AA.ID,
		AA.DIVALIDASI,
		case	when AA.DIVALIDASI = '0' then 'Belum divalidasi'
				when AA.DIVALIDASI = '1' then 'Sudah divalidasi'
			end as ur_DIVALIDASI,
		AA.JENIS_DOKUMEN,
		AA.KODE_SDATA,
		AA.KODE_BUKU_BESAR,
		AA.ID_KEL_BUKU_BESAR,
		AA.KODE_JURNAL,
		AA.KODE_COA,
		AA.KAS,
		CASE	WHEN AA.KAS = '0' THEN 'Akrual'
				WHEN AA.KAS = '1' THEN 'Kas'
			END AS UR_KAS,
		--Remap kode BA dan Eselon 1 Satker menggunakan Tabel Kode Satker, tabel akrual banyak yg salah
		--Coba cek penjurnalan dari modul Aset dan modul Persediaan
--		AA.KODE_BA_SATKER,
		substr(dd.kode_unit,1,3)	KODE_BA_SATKER,
		TRIM(BB.DESKRIPSI)			NAMA_BA_SATKER,
--		AA.KODE_ESELON1_SATKER,
		substr(dd.kode_unit,-2)		KODE_ESELON1_SATKER,
		TRIM(CC.DESKRIPSI)			NAMA_ESELON1_SATKER,
		AA.KODE_SATKER,
		TRIM(DD.DESKRIPSI)			NAMA_SATKER,
		AA.KODE_KEWENANGAN,
		TRIM(EE.DESKRIPSI)			NAMA_KEWENANGAN,
		AA.KODE_FUNGSI,
		FF.NM_FUNGSI				NAMA_FUNGSI,
		AA.KODE_SUB_FUNGSI,
		GG.NM_SUBFUNGSI				NAMA_SUBFUNGSI,
		AA.KODE_PROGRAM,
		HH.NMPROGRAM				NAMA_PROGRAM,
		AA.KODE_KEGIATAN,
		II.NMGIAT					NAMA_KEGIATAN,
		AA.KODE_OUTPUT,
		JJ.NMOUTPUT					NAMA_OUTPUT,
		AA.KODE_PROPINSI_SATKER,
		KK.DESKRIPSI				NAMA_PROPINSI_SATKER,
		AA.KODE_KOTA_SATKER,
		LL.DESKRIPSI				NAMA_KOTA_SATKER,
		AA.KODE_KPPN,
		TRIM(MM.NMKPPN)				NAMA_KPPN,
		AA.KODE_AKUN,
		AA.DEBET,
		AA.KREDIT,
		AA.NAMA_AKUN,
		AA.NO_DOK,
		AA.TGL_DOK,
		case	WHEN substr(kode_akun,1,2) = '41' AND kode_ba_satker = '015' AND kode_sdata = 'INT' THEN
					'RP_'||KODE_SATKER||'_'||KODE_AKUN||'_'||to_char(tgl_dok,'yyyy-mm')
				when instr(NO_DOK,'||',1) != 0 then
					trim(replace(substr(NO_DOK, instr(NO_DOK,'||',1) + 2, LENGTH(NO_DOK)),CHR(9), ' '))
				else trim(REPLACE (no_dok, CHR(9), ' '))
			END as NTPN_SP2D, 
		case	when instr(NO_DOK,'||',1) != 0 then
					trim(substr(NO_DOK, 1, instr(NO_DOK,'||',1)-1))
			END as SPM_SSBP, 
		AA.DESKRIPSI_TRANS,
		AA.KODE_MATA_UANG_TRANS,
		AA.KURS,
		AA.NILAI_TRANS_VALAS,
		AA.KODE_BA_PELAKSANA,
		TRIM(QQ.DESKRIPSI)			NAMA_BA_PELAKSANA,
		AA.KODE_ESELON1_PELAKSANA,
		TRIM(RR.DESKRIPSI)			NAMA_ESELON1_PELAKSANA,
		AA.KODE_CADANGAN,
		AA.KODE_CARA_TARIK,
		OO.DESKRIPSI				NAMA_CARA_TARIK,
		AA.KODE_PERIODE,
		AA.KODE_REGISTER,
		SS.NAMA_LOAN_GRANT			NAMA_PINJAMAN_HIBAH,
		SS.LENDER_NAME				NAMA_DONOR,
		AA.KODE_REKENING_BANK,
		AA.KODE_SATKER_INTRACO,
		TRIM(TT.DESKRIPSI)			NAMA_SATKER_INTRACO,
		substr(TT.KODE_UNIT,1,3)	KODE_BA_INTRACO,
		substr(TT.KODE_UNIT,-2)		KODE_ESELOON1_INTRACO,
		AA.KODE_SUMBER_DANA,
		NN.DESKRIPSI				NAMA_SUMBER_DANA,
		AA.KODE_TIPE_BANK,
		AA.KODE_TIPE_BUDGET,
		PP.DESKRIPSI				NAMA_TIPE_BUDGET,
		AA.KODE_WILAYAH,
		AA.KODE_WILAYAH_1,
		AA.NOMOR_DIPA,
		AA.TGL_JURNAL,
		AA.VALIDASI_POSTING,
		CASE	WHEN AA.VALIDASI_POSTING = '0' THEN 'Belum diposting'
				WHEN AA.VALIDASI_POSTING = '1' THEN 'Sudah diposting'
			END AS UR_VALIDASI_POSTING,
		AA.KODE_KOROLARI,
		CASE	WHEN AA.KODE_KOROLARI = '0' THEN 'Non BLU'
				WHEN AA.KODE_KOROLARI = '1' THEN 'BLU'
			END AS UR_KODE_KOROLARI,
		AA.TIPE_MONITORING_JURNAL,
		CASE	WHEN AA.TIPE_MONITORING_JURNAL = '1' THEN 'Jurnal Awal'
				WHEN AA.TIPE_MONITORING_JURNAL = '3' THEN 'Jurnal Balik'
			END AS UR_TIPE_MONITORING_JURNAL
from	saktiksl.BPK_GLP_BUKU_BESAR_220930_221023	AA
LEFT JOIN
	SAKTIKSL.BPK_ADM_R_SATKER_220731	DD
		ON	AA.KODE_SATKER = DD.KODE
LEFT JOIN
	(	SELECT	DISTINCT *
		FROM	saktiksl.BPK_ADM_R_KEMENTERIAN_220731
		WHERE	LEVEL_ = '1'
	) BB
		ON	substr(dd.kode_unit,1,3) = BB.KODE
--		ON	AA.KODE_BA_SATKER = BB.KODE
LEFT JOIN
	(	SELECT	DISTINCT *
		FROM	saktiksl.BPK_ADM_R_KEMENTERIAN_220731
		WHERE	LEVEL_ = '2'
	) CC
		ON	dd.kode_unit = cc.kode
--		ON	AA.KODE_BA_SATKER||'.'||AA.KODE_ESELON1_SATKER = CC.KODE
LEFT JOIN
	SAKTIKSL.BPK_ADM_R_KEWENANGAN_220731	EE
		ON	AA.KODE_KEWENANGAN = EE.KODE
LEFT JOIN
	(	SELECT	DISTINCT KD_FUNGSI,
				trim(NM_FUNGSI) NM_FUNGSI
		FROM	EREKON.T_FUNGSI_span_310820
	) FF
		ON	AA.KODE_FUNGSI = FF.KD_FUNGSI
LEFT JOIN
	(	SELECT	DISTINCT KD_SUBFUNGSI,
				trim(NM_SUBFUNGSI) NM_SUBFUNGSI
		FROM	EREKON.T_SUBFUNGSI_span_310820
	) GG
		ON	AA.KODE_FUNGSI||AA.KODE_SUB_FUNGSI = GG.KD_SUBFUNGSI
LEFT JOIN
	SAKTIKSL.T_PROGRAM_220912	HH
		ON	AA.KODE_BA_SATKER||AA.KODE_ESELON1_SATKER||AA.KODE_PROGRAM = HH.KDDEPT||HH.KDUNIT||HH.KDPROGRAM
LEFT JOIN
	SAKTIKSL.T_GIAT_220912	II
		ON	AA.KODE_BA_SATKER||AA.KODE_ESELON1_SATKER||AA.KODE_PROGRAM||AA.KODE_KEGIATAN = II.KDDEPT||II.KDUNIT||II.KDPROGRAM||II.KDGIAT
LEFT JOIN
	SAKTIKSL.T_OUTPUT_220912	JJ
		ON	AA.KODE_BA_SATKER||AA.KODE_ESELON1_SATKER||AA.KODE_PROGRAM||AA.KODE_KEGIATAN||AA.KODE_OUTPUT = JJ.KDDEPT||JJ.KDUNIT||JJ.KDPROGRAM||JJ.KDGIAT||JJ.KDOUTPUT
LEFT JOIN
	(	SELECT	*
		FROM	SAKTIKSL.BPK_ADM_R_LOKASI_220731
		WHERE	LEVEL_ = '2'
	) KK
		ON	AA.KODE_PROPINSI_SATKER = KK.KODE
LEFT JOIN
	(	SELECT	*
		FROM	SAKTIKSL.BPK_ADM_R_LOKASI_220731
		WHERE	LEVEL_ = '3'
	) LL
		ON	AA.KODE_PROPINSI_SATKER||'.'||AA.KODE_KOTA_SATKER = LL.KODE
LEFT JOIN
	EREKON.T_KPPN_220525	MM
		ON	AA.KODE_KPPN = MM.KDKPPN
LEFT JOIN
	SAKTIKSL.REF_SUMBER_DANA_2022	NN
		ON	AA.KODE_SUMBER_DANA = NN.KODE
LEFT JOIN
	SAKTIKSL.REF_CARA_TARIK_2022	OO
		ON	AA.KODE_CARA_TARIK = OO.KODE
LEFT JOIN
	SAKTIKSL.REF_TIPE_ANGGARAN_2022	PP
		ON	AA.KODE_TIPE_BUDGET = PP.KODE
LEFT JOIN
	(	SELECT	DISTINCT *
		FROM	saktiksl.BPK_ADM_R_KEMENTERIAN_220731
		WHERE	LEVEL_ = '1'
	) QQ
		ON	AA.KODE_BA_PELAKSANA = QQ.KODE
LEFT JOIN
	(	SELECT	DISTINCT *
		FROM	saktiksl.BPK_ADM_R_KEMENTERIAN_220731
		WHERE	LEVEL_ = '2'
	) RR
		ON	AA.KODE_BA_PELAKSANA||'.'||AA.KODE_ESELON1_PELAKSANA = RR.KODE
LEFT JOIN
	SPAN.SPPM_REGISTER_LENDER_220825	SS
		ON	AA.KODE_REGISTER = SS.REGISTER_NO
LEFT JOIN
	SAKTIKSL.BPK_ADM_R_SATKER_220731	TT
		ON	AA.KODE_SATKER_INTRACO = TT.KODE;
create index saktiksl.IDX_MVBUBESAR_221023_KDBA ON SAKTIKSL.MV_GLP_BUKU_BESAR_220930_221023(KODE_BA_SATKER);
create index saktiksl.IDX_MVBUBESAR_221023_KDES1 ON SAKTIKSL.MV_GLP_BUKU_BESAR_220930_221023(KODE_BA_SATKER||kode_eselon1_satker);
create index saktiksl.IDX_MVBUBESAR_221023_ID ON SAKTIKSL.MV_GLP_BUKU_BESAR_220930_221023(ID);
create index saktiksl.IDX_MVBUBESAR_221023_KAS ON SAKTIKSL.MV_GLP_BUKU_BESAR_220930_221023(KAS);
create index saktiksl.IDX_MVBUBESAR_221023_KDAKU2 ON SAKTIKSL.MV_GLP_BUKU_BESAR_220930_221023(SUBSTR(KODE_AKUN,1,2));
create index saktiksl.IDX_MVBUBESAR_221023_KDAKUN ON SAKTIKSL.MV_GLP_BUKU_BESAR_220930_221023(KODE_AKUN);
create index saktiksl.IDX_MVBUBESAR_221023_KDBB ON SAKTIKSL.MV_GLP_BUKU_BESAR_220930_221023(KODE_BUKU_BESAR);
create index saktiksl.IDX_MVBUBESAR_221023_KDJRN ON SAKTIKSL.MV_GLP_BUKU_BESAR_220930_221023(KODE_JURNAL);
create index saktiksl.IDX_MVBUBESAR_221023_KDKOR ON SAKTIKSL.MV_GLP_BUKU_BESAR_220930_221023(KODE_KOROLARI);
create index saktiksl.IDX_MVBUBESAR_221023_KDSAT ON SAKTIKSL.MV_GLP_BUKU_BESAR_220930_221023(KODE_SATKER);
create index saktiksl.IDX_MVBUBESAR_221023_KDSATI ON SAKTIKSL.MV_GLP_BUKU_BESAR_220930_221023(KODE_SATKER_INTRACO);
create index saktiksl.IDX_MVBUBESAR_221023_KPER ON SAKTIKSL.MV_GLP_BUKU_BESAR_220930_221023(KODE_PERIODE);
create index saktiksl.IDX_MVBUBESAR_221023_KSD ON SAKTIKSL.MV_GLP_BUKU_BESAR_220930_221023(KODE_SDATA);
create index saktiksl.IDX_MVBUBESAR_221023_NODOK ON SAKTIKSL.MV_GLP_BUKU_BESAR_220930_221023(NO_DOK);
create index saktiksl.IDX_MVBUBESAR_221023_VAL ON SAKTIKSL.MV_GLP_BUKU_BESAR_220930_221023(DIVALIDASI);
create index saktiksl.IDX_MVBUBESAR_221023_VPO ON SAKTIKSL.MV_GLP_BUKU_BESAR_220930_221023(VALIDASI_POSTING);
create index saktiksl.IDX_MVBUBESAR_221023_YY ON SAKTIKSL.MV_GLP_BUKU_BESAR_220930_221023(TO_CHAR(TGL_JURNAL,'yyyy'));
create index saktiksl.IDX_MVBUBESAR_221023_SP2D ON SAKTIKSL.MV_GLP_BUKU_BESAR_220930_221023(NTPN_SP2D);
create index saktiksl.IDX_MVBUBESAR_221023_SPM ON SAKTIKSL.MV_GLP_BUKU_BESAR_220930_221023(SPM_SSBP);
create index saktiksl.IDX_MVBUBESAR_221023_REG ON SAKTIKSL.MV_GLP_BUKU_BESAR_220930_221023(KODE_REGISTER);