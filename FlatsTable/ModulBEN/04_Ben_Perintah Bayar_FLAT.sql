DROP MATERIALIZED VIEW SAKTIKSL.MV_BEN_PERINTAH_BAYAR_220930_221023;
CREATE MATERIALIZED VIEW SAKTIKSL.MV_BEN_PERINTAH_BAYAR_220930_221023
--Tabel mencatat perintah bayar.
AS 
select	aa.JENIS_PERINTAH_BAYAR,
		case	when aa.JENIS_PERINTAH_BAYAR = '1' then 'UP'
				when aa.JENIS_PERINTAH_BAYAR = '2' then 'TUP'
				when aa.JENIS_PERINTAH_BAYAR = '3' then 'KP'
				when aa.JENIS_PERINTAH_BAYAR = '4' then 'HIBAH'
			end as ur_PERINTAH_BAYAR,
		aa.DELETED,
		CASE	WHEN AA.DELETED = '0' THEN 'data aktif'
				WHEN AA.DELETED = '1' THEN 'data dihapus'
			END AS UR_DELETED,
		SUBSTR(aa.KODE_KEGIATAN,1,3)		KODE_BA_SATKER,
		TRIM(FF.DESKRIPSI)					NAMA_BA_SATKER,
		SUBSTR(aa.KODE_KEGIATAN,5,2)		KODE_BAES1_SATKER,
		TRIM(DD.DESKRIPSI)					NAMA_BAES1_SATKER,
		aa.KODE_SATKER,
		TRIM(cc.DESKRIPSI)					NAMA_SATKER,		
		aa.KODE_PROGRAM,
		TRIM(HH.NMPROGRAM)					NAMA_PROGRAM,
		aa.KODE_KEGIATAN,
		TRIM(II.NMGIAT)						NAMA_KEGIATAN,
		aa.KODE_OUTPUT,		
		TRIM(JJ.NMOUTPUT)					NAMA_OUTPUT,
		aa.KODE_SUMBER_DANA,
		bb.DESKRIPSI						ur_SUMBER_DANA,
		aa.KODE_NO_DIPA,
		aa.NO_PERINTAH_BAYAR,
		aa.IS_RETURNED,														--Perintah Bayar pernah di validasi tolak oleh validator
		aa.KODE_TAHUN_ANGGARAN,
		aa.TGL_PERINTAH_BAYAR,
		aa.CARA_TARIK,
		dd.DESKRIPSI						ur_CARA_TARIK,
		aa.NO_REGISTER,
		KK.NAMA_LOAN_GRANT					NAMA_PINJAMAN_HIBAH,
		KK.LENDER_NAME						NAMA_DONOR,
		aa.STATUS_KWITANSI,
		case	when aa.STATUS_KWITANSI = '0' then 'Belum dibuat kuitansi'
				when aa.STATUS_KWITANSI = '1' then 'Sudah dibuat kuitansi'
			end as ur_KWITANSI,
		aa.STATUS_PUNGUTAN,
		case	when aa.STATUS_PUNGUTAN = '0' then 'Belum dibuat pungutan pajak'
				when aa.STATUS_PUNGUTAN = '1' then 'Sudah dibuat pungutan pajak'
			end as ur_PUNGUTAN,
		aa.UM_RETURNED,
		case	when aa.UM_RETURNED = '0' then 'Tanpa pengembalian sisa Uang Muka' 
				when aa.UM_RETURNED = '1' then 'Terdapat pengembalian sisa Uang Muka'
			end as ur_RETURNED,
		aa.STATUS_SPP,
		aa.STATUS_SPTB,
		case	when aa.STATUS_SPTB = '0' then 'Belum buat DRPP' 
				when aa.STATUS_SPTB = '1' then 'Sudah buat DRPP'
			end as ur_drpp,
		aa.KODE_UNIT_TEKNIS,
		aa.URAIAN_PERINTAH_BAYAR,
		aa.URAIAN,
		aa.KETERANGAN_VALIDASI,
		aa.ADA_BAST,
		case	when aa.ADA_BAST = '0' then 'Perintah Bayar tidak berasal dari BAST'
				when aa.ADA_BAST = '1' then 'Perintah Bayar berasai dari BAST'
			end as ur_ADA_BAST,		
		aa.KATEGORI_PENGELUARAN,
		aa.TAHUN_ANGGARAN_HIBAH,
		case	when aa.TAHUN_ANGGARAN_HIBAH = '1' then 'TAB'
				when aa.TAHUN_ANGGARAN_HIBAH = '2' then 'TAYL'
			end as ur_TAHUN_ANGGARAN_HIBAH,	
		aa.KATEGORI_PENGELUARAN_HIBAH,
		case	when aa.KATEGORI_PENGELUARAN_HIBAH = '1' then 'Belanja'
				when aa.KATEGORI_PENGELUARAN_HIBAH = '2' then 'Pengembalian sisa hibah'
			end as ur_KATEGORI_PENGELUARAN_HIBAH,
		aa.KODE_AKUN,
		ee.DESKRIPSI						NAMA_AKUN,
		aa.JUMLAH,
		aa.TIPE_AKUN,
		case	when aa.TIPE_AKUN = '0' then 'Pengeluaran'
				when aa.TIPE_AKUN = '1' then 'potongan pajak'
			end as ur_TIPE_AKUN,
		aa.STATUS_AKUN,
		case	when aa.STATUS_AKUN = '0' then 'belum dibuat kuitansi, atau belum dibuat pungutan pajak'
				when aa.STATUS_AKUN = '1' then 'sudah dibuat kuitansi, atau sudah dibuat pungutan pajak'
			end as ur_STATUS_AKUN,
		aa.KODE_COA,
		aa.LOKASI_PROP_KOTA,
		aa.NO_REF_GL												--Kode buku besar akun pengeluaran
from	saktiksl.BPK_BEN_PERINTAH_BAYAR_220930_221023 aa
left join	saktiksl.REF_SUMBER_DANA_2022 bb
	on	aa.KODE_SUMBER_DANA = bb.KODE
left join	SAKTIKSL.BPK_ADM_R_SATKER_220731 cc
	ON	aa.KODE_SATKER = cc.KODE
left join	saktiksl.REF_CARA_TARIK_2022 dd
	ON	aa.CARA_TARIK = dd.KODE
LEFT JOIN	SAKTIKSL.BPK_ADM_R_AKUN_220731	EE
	ON	AA.KODE_AKUN = ee.KODE
left join
	(	SELECT	DISTINCT *
		FROM	saktiksl.BPK_ADM_R_KEMENTERIAN_220731
		WHERE	LEVEL_ = '1'
	) FF
	ON	SUBSTR(aa.KODE_KEGIATAN,1,3) = FF.KODE
LEFT JOIN
	(	SELECT	DISTINCT *
		FROM	saktiksl.BPK_ADM_R_KEMENTERIAN_220731
		WHERE	LEVEL_ = '2'
	) GG
	ON	SUBSTR(KODE_KEGIATAN,1,6) = GG.KODE
LEFT JOIN	SAKTIKSL.T_PROGRAM_220912	HH
	ON	AA.KODE_PROGRAM = HH.KDDEPT||'.'||HH.KDUNIT||'.'||HH.KDPROGRAM
LEFT JOIN	SAKTIKSL.T_GIAT_220912	II
	ON	AA.KODE_KEGIATAN = II.KDDEPT||'.'||II.KDUNIT||'.'||II.KDPROGRAM||'.'||II.KDGIAT
LEFT JOIN	SAKTIKSL.T_OUTPUT_220912	JJ
	ON	AA.KODE_OUTPUT = JJ.KDDEPT||'.'||JJ.KDUNIT||'.'||JJ.KDPROGRAM||'.'||JJ.KDGIAT||'.'||JJ.KDOUTPUT
LEFT JOIN	SPAN.SPPM_REGISTER_LENDER_220825	KK
	ON	AA.NO_REGISTER = KK.REGISTER_NO;
CREATE INDEX SAKTIKSL.MV_BPBAY_221023_BA ON SAKTIKSL.MV_BEN_PERINTAH_BAYAR_220930_221023(KODE_BA_SATKER);
CREATE INDEX SAKTIKSL.MV_BPBAY_221023_BAES1 ON SAKTIKSL.MV_BEN_PERINTAH_BAYAR_220930_221023(KODE_BA_SATKER||kode_eselon1_satker);
CREATE INDEX SAKTIKSL.MV_BPBAY_221023_JNS ON SAKTIKSL.MV_BEN_PERINTAH_BAYAR_220930_221023(JENIS_PERINTAH_BAYAR);