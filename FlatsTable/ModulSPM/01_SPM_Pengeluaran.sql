drop materialized view saktiksl.mv_SPM_PENGELUARAN_220930_221023;
create materialized view saktiksl.mv_SPM_PENGELUARAN_220930_221023
as
SELECT	AA.ID_AKUN_PENGELUARAN,
		AA.DELETED,
		CASE	when AA.DELETED = '0' then 'normal'
				when AA.DELETED = '1' then 'deleted'
			end as ur_DELETED,
		AA.FA,
		AA.CADANGAN,
		AA.ID_COA,
		ee.KODE_AKUN,
		ff.DESKRIPSI					NAMA_AKUN,
		substr(bb.kode_unit,1,3)		kode_ba_satker,
		trim(cc.deskripsi)				nama_ba_satker,
		substr(bb.kode_unit,-2)			kode_eselon1_satker,
		trim(dd.deskripsi)				nama_eselon1_satker,
		AA.KD_SATKER,
		trim(bb.deskripsi)				nama_satker,
		AA.KODE_BUKU_BESAR,
		AA.KODE_VALAS,
		AA.NILAI_AKUN_PENGELUARAN,
		AA.NILAI_PEMBAYARAN_VALAS,
		AA.NILAI_VALAS,
		AA.PAGU,
		AA.REVISI,
		AA.TGL_DIPA,
		AA.ID_SPP,											--FK ke SPM_T_SPP.ID
		AA.ID_KONTRAK_COA,
		AA.NILAI_KONTRAK_COA,
		AA.KODE_BUKU_BESAR_SPM,
		AA.ID_SPTB,
		AA.NO_SPTB,
		AA.KODE_BUKU_BESAR_KOROLARI,
		AA.KODE_BUKU_BESAR_SPM_KOROLARI,
		AA.KODE_BUKU_BESAR_SPM_KURS,
		AA.KODE_BUKU_BESAR_SPP_KURS,
		AA.KURS_SP2D,
		AA.NILAI_PEMBAYARAN_VALAS_SP2D,
		AA.NILAI_VALAS_SP2D,
		AA.TGL_KUR_SP2D,
		AA.KODE_BUKU_BESAR_SPM_KAS
FROM	SAKTIKSL.BPK_SPM_PENGELUARAN_220930_221023	AA
left join	SAKTIKSL.BPK_ADM_R_SATKER_220731 bb
	ON	aa.KD_SATKER = bb.KODE
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
left join	saktiksl.BPK_GLP_COA_220930_221023	ee
	ON	aa.ID_COA = ee.id
left join	SAKTIKSL.BPK_ADM_R_AKUN_220731	ff
	on	ee.KODE_AKUN = ff.kode;
create index saktiksl.mv_SPMPENG_221023_BA on saktiksl.mv_SPM_PENGELUARAN_220930_221023 (kode_ba_satker);
create index saktiksl.mv_SPMPENG_221023_BAES1 on saktiksl.mv_SPM_PENGELUARAN_220930_221023 (kode_ba_satker||kode_eselon1_satker);