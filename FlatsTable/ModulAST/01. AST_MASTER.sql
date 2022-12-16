drop materialized view saktiksl.MV_AST_T_MASTER_220930_221023;
create materialized view saktiksl.MV_AST_T_MASTER_220930_221023
AS 
with
master_all as
(	select	*
	from	saktiksl.BPK_AST_T_MASTER_220930_221023
	union all
	(	select	aa.*
		from	saktiksl.BPK_AST_T_MASTER_2021_221023 aa
		where	id not in
		(	select	id
			from	saktiksl.BPK_AST_T_MASTER_220930_221023
		)
	)
)
select	aa.ID,
		aa.ASAL_PEROLEHAN,
		aa.DASAR_HARGA,
		CASE	when aa.DASAR_HARGA = '1' then 'Perolehan'
				when aa.DASAR_HARGA = '2' then 'Taksiran'
			end as ur_dasar_harga,
		aa.FLAG_DISUSUTKAN,
		CASE	when aa.FLAG_DISUSUTKAN = '1' then 'Tidak Disusutkan'
				when aa.FLAG_DISUSUTKAN = '2' then 'Disusutkan'
			end as ur_flag_disusutkan,
		aa.HARGA_PEROLEHAN,
		aa.HARGA_SATUAN,
		aa.ID_ASAL,
		aa.JENIS_ASSET,
		CASE	when aa.JENIS_ASSET = '1' then 'Intrakomptabel'
				when aa.JENIS_ASSET = '2' then 'Ekstrakomptabel'
			end as ur_JENIS_ASSET,	
		aa.KETERANGAN,
		aa.KODE_BARANG,
		dd.NAMA_BARANG,
		aa.KODE_KEPEMILIKAN,
		CASE	when aa.KODE_KEPEMILIKAN = '1' then 'milik sendiri'
				when aa.KODE_KEPEMILIKAN = '2' then 'milik pihak ketiga'
			end as ur_KODE_KEPEMILIKAN,
		aa.KODE_KONDISI,
		case	when aa.KODE_KONDISI = '1' then 'Baik'
				when aa.KODE_KONDISI = '2' then 'Rusak Ringan'
				when aa.KODE_KONDISI = '3' then 'Rusak Berat'
			end as ur_KODE_KONDISI,
		aa.KODE_TERCATAT,
		CASE	when aa.KODE_TERCATAT = '1' then 'DBR'
				when aa.KODE_TERCATAT = '2' then 'DBL'
				when aa.KODE_TERCATAT = '3' then 'KIB'
			end as ur_KODE_TERCATAT,
		aa.KODE_UAKPB,
		aa.MEREK_TIPE,
		aa.NO_ASSET,
		aa.NO_BUKTI,
		aa.STATUS_ASSET,
		ee.URAIAN						ur_STATUS_ASSET,
		EE.KATEGORI						KATEGORI_STATUS,
		aa.TGL_PEROLEHAN,
		aa.TGL_AWAL_PEMAKAIAN,
		aa.STATUS_ASSET_SBLM,
		ff.uraian						ur_STATUS_ASSET_SBLM,
		FF.KATEGORI						KATEGORI_STATUS_SBLM,
		aa.TIDAK_DITEMUKAN,
		SUBSTR(AA.KODE_UAKPB,1,3)		KODE_BA_SATKER,
		TRIM(GG.DESKRIPSI)				NAMA_BA_SATKER,
		SUBSTR(AA.KODE_UAKPB,4,2)		KODE_eselon1_SATKER,
		TRIM(HH.DESKRIPSI)				NAMA_eselon1_SATKER,
		SUBSTR(AA.KODE_UAKPB,10,6)		kode_satker,
		TRIM(cc.DESKRIPSI)				NAMA_SATKER,
		SUBSTR(AA.KODE_UAKPB,16,3)		kode_subsatker,
		dd.AKUN,
		dd.NAMA_AKUN,
		substr(dd.group_data,1,1)		group_data,
		dd.group_data					ur_group_data,
		SUBSTR(AA.KODE_UAKPB,1,5)||'.'||SUBSTR(AA.KODE_UAKPB,10,6)||'.'||SUBSTR(AA.KODE_UAKPB,16,3)
				||'.'||SUBSTR(AA.KODE_UAKPB,-2)||'.'||AA.KODE_BARANG||'.'||abs(AA.NO_ASSET) 
										NUP_X_KWL
from	master_all aa
left join	SAKTIKSL.BPK_ADM_R_SATKER_220731 CC
	ON	SUBSTR(AA.KODE_UAKPB,10,6) = CC.KODE
LEFT JOIN	saktiksl.REF_ASET_BARANG_MONSAKTI_2022 dd
	ON	aa.KODE_BARANG = dd.KODE_BARANG
left join
	(	select	*
		from	saktiksl.BPK_ADM_STATUS_ASET_220731
		where	NOTES not in ('ADK TKTM','ADK Likuidasi')
				or notes is null
	) ee
	on	to_char(aa.STATUS_ASSET) = ee.status
left join
	(	select	*
		from	saktiksl.BPK_ADM_STATUS_ASET_220731
		where	NOTES not in ('ADK TKTM','ADK Likuidasi')
				or notes is null
	) ff
	on	to_char(aa.STATUS_ASSET_SBLM) = ff.status
left join
	(	SELECT	DISTINCT *
		FROM	saktiksl.BPK_ADM_R_KEMENTERIAN_220731
		WHERE	LEVEL_ = '1'
	) GG
	ON	SUBSTR(AA.KODE_UAKPB,1,3) = GG.KODE
LEFT JOIN
	(	SELECT	DISTINCT *
		FROM	saktiksl.BPK_ADM_R_KEMENTERIAN_220731
		WHERE	LEVEL_ = '2'
	) HH
	ON	SUBSTR(AA.KODE_UAKPB,1,3)||'.'||SUBSTR(AA.KODE_UAKPB,4,2) = HH.KODE
;
create index saktiksl.IDX_MV_ATM_221023_BA on saktiksl.MV_AST_T_MASTER_220930_221023(KODE_BA_SATKER);
create index saktiksl.IDX_MV_ATM_221023_BAES1 on saktiksl.MV_AST_T_MASTER_220930_221023(KODE_BA_SATKER||KODE_eselon1_SATKER);
create index saktiksl.IDX_MV_ATM_221023_NUP on saktiksl.MV_AST_T_MASTER_220930_221023(NUP_X_KWL);
create index saktiksl.IDX_MV_ATM_221023_ID on saktiksl.MV_AST_T_MASTER_220930_221023(ID);