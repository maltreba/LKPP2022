drop materialized view saktiksl.MV_AST_T_JURNAL_220930_221023;
create materialized view saktiksl.MV_AST_T_JURNAL_220930_221023
as
with
jurnal_all as
(	select	*
	FROM	saktiksl.BPK_AST_T_JURNAL_2021_221023
	union all
	select	*
	FROM	saktiksl.BPK_AST_T_JURNAL_220930_221023
)
select	AA.ID,
		AA.CREATED_BY,
		AA.CREATED_DATE,
		AA.DELETED,
		AA.MODIFIED_BY,
		AA.MODIFIED_DATE,
		AA.VERSION,
		AA.DESC_JURNAL,
		AA.ID_ASAL,
		AA.KODE_AKUN,
		trim(ff.DESKRIPSI)				NAMA_AKUN,		
		AA.KODE_BUKU_BESAR,
		AA.KODE_COA,
		substr(bb.kode_unit,1,3)		kode_ba_satker,
		trim(cc.deskripsi)				nama_ba_satker,
		substr(bb.kode_unit,-2)			kode_eselon1_satker,
		trim(dd.deskripsi)				nama_eselon1_satker,
		SUBSTR(AA.KODE_COA,1,6)			KODE_SATKER,
		trim(bb.deskripsi)				nama_satker,
		AA.KODE_TIPE_JURNAL,
		AA.KODE_UAKPB,
		AA.NILAI_DEBET,
		AA.NILAI_KREDIT,
		AA.TGL_JURNAL,
		AA.ASSET_KDP_TRX_ID,
		AA.ASSET_TRX_ID
from	jurnal_all	aa
left join	SAKTIKSL.BPK_ADM_R_SATKER_220731 bb
	ON	SUBSTR(AA.KODE_COA,1,6) = bb.KODE
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
	on	AA.KODE_AKUN = ff.kode;
create index saktiksl.MV_ATJRN_221023_BA on saktiksl.MV_AST_T_JURNAL_220930_221023 (kode_ba_satker);
create index saktiksl.MV_ATJRN_221023_BAES1 on saktiksl.MV_AST_T_JURNAL_220930_221023 (kode_ba_satker||kode_eselon1_satker);
create index saktiksl.MV_ATJRN_221023_KBB on saktiksl.MV_AST_T_JURNAL_220930_221023 (KODE_BUKU_BESAR);
create index saktiksl.MV_ATJRN_221023_TRX1 on saktiksl.MV_AST_T_JURNAL_220930_221023 (ASSET_KDP_TRX_ID);
create index saktiksl.MV_ATJRN_221023_TRX2 on saktiksl.MV_AST_T_JURNAL_220930_221023 (ASSET_TRX_ID);
create index saktiksl.MV_ATJRN_221023_id on saktiksl.MV_AST_T_JURNAL_220930_221023 (id);