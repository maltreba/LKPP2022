DROP MATERIALIZED VIEW SAKTIKSL.MV_KOM_BAST_NONK_HEADER_220930_221023;
CREATE MATERIALIZED VIEW SAKTIKSL.MV_KOM_BAST_NONK_HEADER_220930_221023
AS
SELECT	AA.ID_DOKUMEN,
		AA.DELETED,
		CASE	WHEN AA.DELETED = '0' THEN 'aktif'
				WHEN AA.DELETED = '1' THEN 'deleted'
			END AS UR_DELETED,
		AA.KATEGORI,
		case	when KATEGORI = '1' then 'BAST Barang'
				when KATEGORI = '2' then 'BAST Jasa'
				when KATEGORI = '3' then 'Kuitansi GUP KKP Barang'
				when KATEGORI = '4' then 'Kuitansi GUP KKP Jasa'
				when KATEGORI = '5' then 'Kuitansi TUP KKP Barang'
				when KATEGORI = '6' then 'Kuitansi TUP KKP Jasa'
				when KATEGORI = '7' then 'Kuitansi GUP Valas Barang'
				when KATEGORI = '8' then 'Kuitansi GUP Valas Jasa'
				when KATEGORI = '9' then 'Kuitansi TUP Valas Barang'
				when KATEGORI = '10' then 'Kuitansi TUP Valas Jasa'
				when KATEGORI = '11' then 'BAST Barang UP'
				when KATEGORI = '12' then 'BAST Jasa UP'
				when KATEGORI = '13' then 'BAST Barang TUP'
				when KATEGORI = '14' then 'BAST Jasa TUP'
				when KATEGORI = '15' then 'BAST Barang HIBAH'
				when KATEGORI = '16' then 'BAST Jasa HIBAH'
			end as ur_KATEGORI,
		AA.KODE_GLP_T_COA,
		substr(aa.KODE_GLP_T_COA,12,6)	kode_akun,
		ff.DESKRIPSI					NAMA_AKUN,
		AA.KODE_KPPN,
		TRIM(EE.NMKPPN)					NAMA_KPPN,
		substr(bb.kode_unit,1,3)		kode_ba_satker,
		trim(cc.deskripsi)				nama_ba_satker,
		substr(bb.kode_unit,-2)			kode_eselon1_satker,
		trim(dd.deskripsi)				nama_eselon1_satker,
		AA.KODE_SATKER,
		trim(bb.deskripsi)				nama_satker,
		AA.KODE_TAHUN_ANGGARAN,
		AA.NILAI_KURS,
		AA.NO_DIPA,
		AA.NO_DOKUMEN,
		AA.STATUS_DIBAYAR,
		case	when STATUS_DIBAYAR = '0' then 'Belum dibayar'
				when STATUS_DIBAYAR = '1' then 'Sudah dibayar'
			end as ur_STATUS_DIBAYAR,
		AA.TGL_DIPA,
		AA.TGL_DOKUMEN,
		AA.URAIAN_DOKUMEN,
		AA.KODE_MATA_UANG,
		AA.NILAI_BAST,
		AA.SPP_ID,
		AA.KODE_UNIT_TEKNIS
FROM	SAKTIKSL.BPK_KOM_BAST_NONK_HEADER_220930_221023	AA
left join	SAKTIKSL.BPK_ADM_R_SATKER_220731 bb
	ON	aa.KODE_SATKER = bb.KODE
left join
	(	SELECT	DISTINCT *
		FROM	saktiksl.BPK_ADM_R_KEMENTERIAN_220731
		WHERE	LEVEL_ = '1'
	) cc
	ON	substr(bb.kode_unit,1,3) = cc.KODE
LEFT JOIN
	(	SELECT	DISTINCT *
		FROM	saktiksl.BPK_ADM_R_KEMENTERIAN_220731
		WHERE	LEVEL_ = '2'
	) dd
	ON	bb.kode_unit = dd.KODE
LEFT JOIN	EREKON.T_KPPN_220525	EE
	ON	AA.KODE_KPPN = EE.KDKPPN
left join	SAKTIKSL.BPK_ADM_R_AKUN_220731	ff
	ON	substr(aa.KODE_GLP_T_COA,12,6) = ff.KODE;
CREATE INDEX SAKTIKSL.IDX_MV_KBNHDR_221023_BA ON SAKTIKSL.MV_KOM_BAST_NONK_HEADER_220930_221023 (kode_ba_satker);
CREATE INDEX SAKTIKSL.IDX_MV_KBNHDR_221023_BAES1 ON SAKTIKSL.MV_KOM_BAST_NONK_HEADER_220930_221023 (kode_ba_satker||kode_eselon1_satker);