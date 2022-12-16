drop materialized view saktiksl.MV_SPM_POTONGAN_220930_221023;
create materialized view saktiksl.MV_SPM_POTONGAN_220930_221023
as
SELECT	AA.ID_AKUN_POTONGAN,
		AA.DELETED,
		CASE	when AA.DELETED = '0' then 'normal'
				when AA.DELETED = '1' then 'deleted'
			end as ur_DELETED,
		AA.CADANGAN,
		AA.KD_COA,
		substr(AA.KD_COA,12,6) 			KODE_akun,
		ff.DESKRIPSI					NAMA_AKUN,
		substr(bb.kode_unit,1,3)		kode_ba_satker,
		trim(cc.deskripsi)				nama_ba_satker,
		substr(bb.kode_unit,-2)			kode_eselon1_satker,
		trim(dd.deskripsi)				nama_eselon1_satker,
		AA.KD_SATKER,
		trim(bb.deskripsi)				nama_satker,
		AA.KJS,
		AA.KODE_BUKU_BESAR,
		AA.KODE_VALAS,
		AA.NILAI_AKUN_POT,
		AA.NILAI_PEMBAYARAN_VALAS,
		AA.NILAI_VALAS,
		AA.NO_POT,
		AA.REVISI,
		AA.TGL_DIPA,
		AA.ID_SPP,											--FK ke SPM_T_SPP.ID
		AA.KODE_BUKU_BESAR_SPM,
		AA.NILAI_UM_TERMIN,
		AA.ID_SBS,
		AA.KODE_BUKU_BESAR_KOROLARI,
		AA.KODE_BUKU_BESAR_SPM_KOROLARI,
		AA.NO_SBS,
		AA.KODE_BUKU_BEAR_SPM_KURS,
		AA.KODE_BUKU_BEAR_SPP_KURS,
		AA.KURS_SP2D,
		AA.NILAI_PEMBAYARAN_VALAS_SP2D,
		AA.NILAI_VALAS_SP2D,
		AA.TGL_KURS_SP2D
FROM	SAKTIKSL.BPK_SPM_POTONGAN_220930_221023	AA
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
left join	SAKTIKSL.BPK_ADM_R_AKUN_220731	ff
	on	substr(AA.KD_COA,12,6) = ff.kode;
create index saktiksl.mv_SPMPOT_221023_BA on saktiksl.MV_SPM_POTONGAN_220930_221023 (kode_ba_satker);
create index saktiksl.mv_SPMPOT_221023_BAES1 on saktiksl.MV_SPM_POTONGAN_220930_221023 (kode_ba_satker||kode_eselon1_satker);