DROP MATERIALIZED VIEW SAKTIKSL.MV_KOM_BAST_HEADER_220930_221023;
CREATE MATERIALIZED VIEW SAKTIKSL.MV_KOM_BAST_HEADER_220930_221023
AS
select	AA.ID_BAST,
		AA.DELETED,
		CASE	WHEN AA.DELETED = '0' THEN 'aktif'
				WHEN AA.DELETED = '1' THEN 'deleted'
			END AS UR_DELETED,
		AA.KATEGORI,
		case	when KATEGORI = '1' then 'BAST Barang'
				when KATEGORI = '2' then 'BAST Jasa'
				when KATEGORI = '17' then 'BAST BG'
			end AS UR_KATEGORI,
		substr(bb.kode_unit,1,3)		kode_ba_satker,
		trim(cc.deskripsi)				nama_ba_satker,
		substr(bb.kode_unit,-2)			kode_eselon1_satker,
		trim(dd.deskripsi)				nama_eselon1_satker,
		AA.KODE_SATKER,
		trim(bb.deskripsi)				nama_satker,
		AA.KODE_TAHUN_ANGGARAN,
		AA.NILAI_KURS,
		AA.NO_BAST,
		AA.PROGRESS_PEKERJAAN,
		AA.STATUS_DIBAYAR,
		case	when STATUS_DIBAYAR = '0' then 'Belum dibayar'
				when STATUS_DIBAYAR = '1' then 'Sudah dibayar'
				when STATUS_DIBAYAR = '2' then 'BAST Final'
			end as ur_STATUS_DIBAYAR,
		AA.TGL_BAST,
		AA.ID_DIST_COA,
		AA.SPP_ID
from	saktiksl.BPK_KOM_BAST_HEADER_220930_221023	aa
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
	ON	bb.kode_unit = dd.KODE;
CREATE INDEX SAKTIKSL.IDX_MV_KBHD_221023_BA ON SAKTIKSL.MV_KOM_BAST_HEADER_220930_221023 (kode_ba_satker);
CREATE INDEX SAKTIKSL.IDX_MV_KBHD_221023_BAES1 ON SAKTIKSL.MV_KOM_BAST_HEADER_220930_221023 (kode_ba_satker||kode_eselon1_satker);