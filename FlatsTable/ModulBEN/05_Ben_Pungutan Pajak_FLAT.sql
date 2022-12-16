drop materialized view saktiksl.MV_BEN_PUNGUTAN_PAJAK_220930_221023;
create materialized view saktiksl.MV_BEN_PUNGUTAN_PAJAK_220930_221023
as
--Tabel mencatat pungutan pajak
select	AA.DASAR_PUNGUT,
		CASE	WHEN AA.DASAR_PUNGUT = '0' THEN 'perintah bayar'
				WHEN AA.DASAR_PUNGUT = '1' THEN 'lain-lain'
				WHEN AA.DASAR_PUNGUT = '2' THEN 'GUP KKP'
				WHEN AA.DASAR_PUNGUT = '3' THEN 'PTUP KKP'
			END AS UR_DASAR_PUNGUT,
		AA.DELETED,
		CASE	when AA.DELETED = '0' then 'data aktif'
				when AA.DELETED = '1' then 'data dihapus'
			end as ur_DELETED,
		AA.KETERANGAN,
		AA.NO_BUKTI_PUNGUT,
		substr(bb.kode_unit,1,3)		kode_ba_satker,
		trim(cc.deskripsi)				nama_ba_satker,
		substr(bb.kode_unit,-2)			kode_eselon1_satker,
		trim(dd.deskripsi)				nama_eselon1_satker,
		AA.KODE_SATKER,
		trim(bb.deskripsi)				nama_satker,
		AA.KODE_TAHUN_ANGGARAN,
		AA.TGL_PUNGUT,
		AA.PERINTAH_BAYAR_ID,
		AA.JENIS_PEM_KAS,
		CASE	when AA.JENIS_PEM_KAS = '1' then 'kas tunai'
				when AA.JENIS_PEM_KAS = '2' then 'kas bank'
			end as ur_PEM_KAS,
		AA.KODE_UNIT_TEKNIS,
		AA.KODE_AKUN,
		trim(ee.deskripsi)				nama_akun,
		AA.JUMLAH,
		AA.NO_REF_GL,
		AA.STATUS,
		CASE	when AA.STATUS = '0' then 'Belum Dibuat SPP'
				when AA.STATUS = '1' then 'Sudah Dibuat SPP'
			end as ur_STATUS,
		AA.PUNGUTAN_PAJAK_ID,
		AA.SETORAN_PAJAK_ID,
		AA.NO_REF_GL_KKP
from	saktiksl.BPK_BEN_PUNGUTAN_PAJAK_220930_221023	AA
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
LEFT JOIN	SAKTIKSL.BPK_ADM_R_AKUN_220731	EE
	ON	AA.KODE_AKUN = ee.KODE;
create index saktiksl.IDX_MV_BPPJK_221023_BA on saktiksl.MV_BEN_PUNGUTAN_PAJAK_220930_221023(kode_ba_satker);
create index saktiksl.IDX_MV_BPPJK_221023_BAES1 on saktiksl.MV_BEN_PUNGUTAN_PAJAK_220930_221023(kode_ba_satker||kode_eselon1_satker);
create index saktiksl.IDX_MV_BPPJK_221023_BUKTI on saktiksl.MV_BEN_PUNGUTAN_PAJAK_220930_221023(NO_BUKTI_PUNGUT);
create index saktiksl.IDX_MV_BPPJK_221023_PBID on saktiksl.MV_BEN_PUNGUTAN_PAJAK_220930_221023(PERINTAH_BAYAR_ID);
create index saktiksl.IDX_MV_BPPJK_221023_REF on saktiksl.MV_BEN_PUNGUTAN_PAJAK_220930_221023(NO_REF_GL);
create index saktiksl.IDX_MV_BPPJK_221023_PID on saktiksl.MV_BEN_PUNGUTAN_PAJAK_220930_221023(PUNGUTAN_PAJAK_ID);
create index saktiksl.IDX_MV_BPPJK_221023_SID on saktiksl.MV_BEN_PUNGUTAN_PAJAK_220930_221023(SETORAN_PAJAK_ID);
create index saktiksl.IDX_MV_BPPJK_221023_REF2 on saktiksl.MV_BEN_PUNGUTAN_PAJAK_220930_221023(NO_REF_GL_KKP);