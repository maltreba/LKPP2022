drop MATERIALIZED VIEW SAKTIKSL.MV_KOM_BAST_ALL_220930_221023;
CREATE MATERIALIZED VIEW SAKTIKSL.MV_KOM_BAST_ALL_220930_221023
AS 
WITH
HEADER AS
(	select	distinct ID_BAST ID_BAST_DOKUMEN_HEAD,
			DELETED DELETED_HEADER,
			KATEGORI,
			cast (null as VARCHAR2(255)) as KODE_GLP_T_COA,
			cast (null as VARCHAR2(255)) as KODE_KPPN,
			KODE_SATKER,
			KODE_TAHUN_ANGGARAN,
			NILAI_KURS,
			cast (null as VARCHAR2(50)) as NO_DIPA,
			NO_BAST,
			STATUS_DIBAYAR,
			cast (null as DATE) as TGL_DIPA,
			cast (null as DATE) as TGL_DOKUMEN,
			cast (null as VARCHAR2(255)) as URAIAN_DOKUMEN,
			cast (null as VARCHAR2(255)) as KODE_MATA_UANG,
			cast (null as NUMBER(19,2)) as NILAI_BAST,
			SPP_ID,
			cast (null as VARCHAR2(255)) as KODE_UNIT_TEKNIS,
			PROGRESS_PEKERJAAN,
			TGL_BAST,
			ID_DIST_COA,
			'KOM_BAST' as SUMBER_HEAD
	from	SAKTIKSL.BPK_KOM_BAST_HEADER_220930_221023
	UNION ALL
	select	distinct ID_DOKUMEN,
			DELETED,
			KATEGORI,
			KODE_GLP_T_COA,
			KODE_KPPN,
			KODE_SATKER,
			KODE_TAHUN_ANGGARAN,
			NILAI_KURS,
			NO_DIPA,
			NO_DOKUMEN,
			STATUS_DIBAYAR,
			TGL_DIPA,
			TGL_DOKUMEN,
			URAIAN_DOKUMEN,
			KODE_MATA_UANG,
			NILAI_BAST,
			SPP_ID,
			KODE_UNIT_TEKNIS,
			cast (null as FLOAT) as PROGRESS_PEKERJAAN,
			cast (null as DATE) as TGL_BAST,
			cast (null as NUMBER(19,0)) as ID_DIST_COA,
			'KOM_BAST_NONK' as SUMBER_HEAD
	from	SAKTIKSL.BPK_KOM_BAST_NONK_HEADER_220930_221023
	UNION ALL
	SELECT	DISTINCT ID_DOKUMEN,
			DELETED,
			KATEGORI,
			KODE_GLP_T_COA,
			KODE_KPPN,
			KODE_SATKER,
			KODE_TAHUN_ANGGARAN,
			NILAI_KURS,
			NO_DIPA,
			NO_DOKUMEN,
			STATUS_DIBAYAR,
			TGL_DIPA,
			TGL_DOKUMEN,
			URAIAN_DOKUMEN,
			KODE_MATA_UANG,
			NILAI_BAST,
			SPP_ID,
			cast (null as VARCHAR2(255)) as KODE_UNIT_TEKNIS,
			cast (null as FLOAT) as PROGRESS_PEKERJAAN,
			cast (null as DATE) as TGL_BAST,
			cast (null as NUMBER(19,0)) as ID_DIST_COA,
			'KOM_BAST_HIBAH' as SUMBER_HEAD
	FROM	SAKTIKSL.BPK_KOM_BAST_HIBAH_HEADER_220930_221023
),
DETAIL AS
(	select	distinct ID_BAST_DETAIL		ID_BAST_DOKUMEN_DETAIL,
			DELETED						DELETED_DETAIL,
			IS_DICATAT,
			HARGA_SATUAN,
			JUMLAH_BARANG,
			KODE_BARANG,
			NO_SPPA,
			SATKER_ID,
			SISA_HARGA,
			SISA_JUMLAH,
			TGL_CATAT,
			TOTAL_HARGA,
			ID_BAST						ID_BAST_DOKUMEN,
			KODE_BUKU_BESAR,
			HARGA_ORIGINAL,
			CAST (NULL AS VARCHAR2 (255)) as KODE_COA,
			'KOM_BAST_DETAIL' as SUMBER_DETAIL
	from	saktiksl.BPK_KOM_BAST_DETAIL_220930_221023
	union all
	select	distinct ID_DOKUMEN_DETAIL,
			DELETED,
			IS_DICATAT,
			HARGA_SATUAN,
			JUMLAH_BARANG,
			KODE_BARANG,
			CAST (NULL AS VARCHAR2 (255)) as NO_SPPA,
			SATKER_ID,
			SISA_HARGA,
			SISA_JUMLAH,
			CAST (NULL AS DATE) as TGL_CATAT,
			TOTAL_HARGA,
			ID_DOKUMEN,
			KODE_BUKU_BESAR,
			HARGA_ORIGINAL,
			CAST (NULL AS VARCHAR2 (255)) as KODE_COA,
			'KOM_BAST_NONK_DETAIL' as SUMBER_DETAIL
	from	saktiksl.BPK_KOM_BAST_NONK_DETAIL_220930_221023
	UNION ALL
	SELECT	DISTINCT ID_DOKUMEN_DETAIL,
			DELETED,
			IS_DICATAT,
			HARGA_SATUAN,
			JUMLAH_BARANG,
			KODE_BARANG,
			CAST (NULL AS VARCHAR2 (255)) AS NO_SPPA,
			SATKER_ID,
			SISA_HARGA,
			SISA_JUMLAH,
			CAST (NULL AS DATE) AS TGL_CATAT,
			TOTAL_HARGA,
			ID_DOKUMEN,
			KODE_BUKU_BESAR,
			CAST (NULL AS NUMBER (19,2)) AS HARGA_ORIGINAL,
			KODE_COA,
			'KOM_BAST_HIBAH_DETAIL' as SUMBER_DETAIL
	FROM	SAKTIKSL.BPK_KOM_BAST_HIBAH_DETAIL_220930_221023
)
select	AA.ID_BAST_DOKUMEN_DETAIL,
		AA.DELETED_DETAIL,
		case	when AA.deleted_detail = '0' then 'aktif'
				when AA.deleted_detail = '1' then 'deleted'
			end as ur_DELETED_DETAIL,
		AA.IS_DICATAT,
		case	when AA.IS_DICATAT = '0' then 'Belum didetailkan'
				when AA.IS_DICATAT = '1' then 'Sudah didetailkan'
			end as ur_IS_DICATAT,
		AA.HARGA_SATUAN,
		AA.JUMLAH_BARANG,
		AA.KODE_BARANG,
		BB.DESKRIPSI					NAMA_BARANG,
		AA.NO_SPPA,
		substr(CC.kode_unit,1,3)		kode_ba_satker_D,
		trim(DD.deskripsi)				nama_ba_satker_D,
		substr(CC.kode_unit,-2)			kode_eselon1_satker_D,
		trim(EE.deskripsi)				nama_eselon1_satker_D,
		AA.SATKER_ID,
		trim(CC.deskripsi)				nama_satker_D,
		AA.SISA_HARGA,
		AA.SISA_JUMLAH,
		AA.TGL_CATAT,
		AA.TOTAL_HARGA,
		AA.ID_BAST_DOKUMEN,
		AA.KODE_BUKU_BESAR,
		AA.HARGA_ORIGINAL,
		AA.KODE_COA,
		substr(aa.KODE_COA,12,6)		kode_akun_D,
		FF.DESKRIPSI					NAMA_AKUN_D,
		AA.SUMBER_DETAIL,
		AA.ID_BAST_DOKUMEN_HEAD,
		AA.DELETED_HEADER,
		case	when AA.DELETED_HEADER = '0' then 'aktif'
				when AA.DELETED_HEADER = '1' then 'deleted'
			end as ur_DELETED_HEADER,
		AA.KATEGORI,
		case	when AA.SUMBER_HEAD = 'KOM_BAST' then 
					case	when AA.KATEGORI = '1' then 'BAST Barang'
							when AA.KATEGORI = '2' then 'BAST Jasa'
							when AA.KATEGORI = '17' then 'BAST BG'
						end
				when AA.SUMBER_HEAD = 'KOM_BAST_NONK' then 
					case	when AA.KATEGORI = '1' then 'BAST Barang'
							when AA.KATEGORI = '2' then 'BAST Jasa'
							when AA.KATEGORI = '3' then 'Kuitansi GUP KKP Barang'
							when AA.KATEGORI = '4' then 'Kuitansi GUP KKP Jasa'
							when AA.KATEGORI = '5' then 'Kuitansi TUP KKP Barang'
							when AA.KATEGORI = '6' then 'Kuitansi TUP KKP Jasa'
							when AA.KATEGORI = '7' then 'Kuitansi GUP Valas Barang'
							when AA.KATEGORI = '8' then 'Kuitansi GUP Valas Jasa'
							when AA.KATEGORI = '9' then 'Kuitansi TUP Valas Barang'
							when AA.KATEGORI = '10' then 'Kuitansi TUP Valas Jasa'
							when AA.KATEGORI = '11' then 'BAST Barang UP'
							when AA.KATEGORI = '12' then 'BAST Jasa UP'
							when AA.KATEGORI = '13' then 'BAST Barang TUP'
							when AA.KATEGORI = '14' then 'BAST Jasa TUP'
							when AA.KATEGORI = '15' then 'BAST Barang HIBAH'
							when AA.KATEGORI = '16' then 'BAST Jasa HIBAH'
						end
				when AA.SUMBER_HEAD = 'KOM_BAST_HIBAH' then 
					case	when AA.KATEGORI = '1' then 'BAST Barang'
							when AA.KATEGORI = '2' then 'BAST Jasa'
						end
			end as ur_KATEGORI,
		AA.KODE_GLP_T_COA,
		substr(aa.KODE_GLP_T_COA,12,6)	kode_akun_H,
		GG.DESKRIPSI					NAMA_AKUN_H,
		AA.KODE_KPPN,
		TRIM(KK.NMKPPN)					NAMA_KPPN,
		substr(HH.kode_unit,1,3)		kode_ba_satker_H,
		trim(II.deskripsi)				nama_ba_satker_H,
		substr(HH.kode_unit,-2)			kode_eselon1_satker_H,
		trim(JJ.deskripsi)				nama_eselon1_satker_H,
		AA.KODE_SATKER,
		trim(HH.deskripsi)				nama_satker_H,
		AA.KODE_TAHUN_ANGGARAN,
		AA.NILAI_KURS,
		AA.NO_DIPA,
		AA.NO_BAST,
		AA.STATUS_DIBAYAR,
		case	when AA.STATUS_DIBAYAR = '0' then 'Belum dibayar'
				when AA.STATUS_DIBAYAR = '1' then 'Sudah dibayar'
				when AA.STATUS_DIBAYAR = '2' then 'BAST Final'
			end as ur_STATUS_DIBAYAR,
		AA.TGL_DIPA,
		AA.TGL_DOKUMEN,
		AA.URAIAN_DOKUMEN,
		AA.KODE_MATA_UANG,
		AA.NILAI_BAST,
		AA.SPP_ID,
		AA.KODE_UNIT_TEKNIS,
		AA.PROGRESS_PEKERJAAN,
		AA.TGL_BAST,
		AA.ID_DIST_COA,
		AA.SUMBER_HEAD
from
(	SELECT	DISTINCT *
	FROM
	(	SELECT	BB.*,
				AA.*
		FROM	DETAIL BB
		LEFT JOIN	HEADER AA
			ON	BB.ID_BAST_DOKUMEN = AA.ID_BAST_DOKUMEN_HEAD
		UNION ALL
		SELECT	BB.*,
				AA.*
		FROM	HEADER AA
		LEFT JOIN	DETAIL BB
			ON	BB.ID_BAST_DOKUMEN = AA.ID_BAST_DOKUMEN_HEAD
	)
) aa
LEFT JOIN	SAKTIKSL.BPK_ADM_R_KAT_SUBSUB_KELOMPOK_220731	BB
	ON	AA.KODE_BARANG = BB.KODE
left join	SAKTIKSL.BPK_ADM_R_SATKER_220731 CC
	ON	aa.KODE_SATKER = CC.KODE
left join
	(	SELECT	DISTINCT *
		FROM	saktiksl.BPK_ADM_R_KEMENTERIAN_220731
		WHERE	LEVEL_ = '1'
	) DD
	ON	substr(CC.kode_unit,1,3) = DD.KODE
LEFT JOIN
	(	SELECT	DISTINCT *
		FROM	saktiksl.BPK_ADM_R_KEMENTERIAN_220731
		WHERE	LEVEL_ = '2'
	) EE
	ON	CC.kode_unit = EE.KODE
left join	SAKTIKSL.BPK_ADM_R_AKUN_220731	FF
	ON	substr(aa.KODE_COA,12,6) = FF.KODE
left join	SAKTIKSL.BPK_ADM_R_AKUN_220731	GG
	ON	substr(aa.KODE_GLP_T_COA,12,6) = GG.KODE
left join	SAKTIKSL.BPK_ADM_R_SATKER_220731 HH
	ON	aa.SATKER_ID = HH.KODE
left join
	(	SELECT	DISTINCT *
		FROM	saktiksl.BPK_ADM_R_KEMENTERIAN_220731
		WHERE	LEVEL_ = '1'
	) II
	ON	substr(HH.kode_unit,1,3) = II.KODE
LEFT JOIN
	(	SELECT	DISTINCT *
		FROM	saktiksl.BPK_ADM_R_KEMENTERIAN_220731
		WHERE	LEVEL_ = '2'
	) JJ
	ON	HH.kode_unit = JJ.KODE
LEFT JOIN	EREKON.T_KPPN_220525	KK
	ON	AA.KODE_KPPN = KK.KDKPPN;
create index SAKTIKSL.MV_BAST_221023_DD ON SAKTIKSL.MV_KOM_BAST_ALL_220930_221023(DELETED_DETAIL);
create index SAKTIKSL.MV_BAST_221023_DH ON SAKTIKSL.MV_KOM_BAST_ALL_220930_221023(DELETED_HEADER);
create index SAKTIKSL.MV_BAST_221023_SPPID ON SAKTIKSL.MV_KOM_BAST_ALL_220930_221023(SPP_ID);
create index SAKTIKSL.MV_BAST_221023_BA ON SAKTIKSL.MV_KOM_BAST_ALL_220930_221023(NVL(kode_ba_satker_D,kode_ba_satker_H));
create index SAKTIKSL.MV_BAST_221023_BAES1 ON SAKTIKSL.MV_KOM_BAST_ALL_220930_221023(NVL(kode_ba_satker_D||kode_eselon1_satker_D,kode_ba_satker_H||kode_eselon1_satker_h));
create index SAKTIKSL.MV_BAST_221023_KDSR ON SAKTIKSL.MV_KOM_BAST_ALL_220930_221023(KODE_SATKER);
create index SAKTIKSL.MV_BAST_221023_IDH ON SAKTIKSL.MV_KOM_BAST_ALL_220930_221023(ID_BAST_DOKUMEN_HEAD);
create index SAKTIKSL.MV_BAST_221023_IDD ON SAKTIKSL.MV_KOM_BAST_ALL_220930_221023(ID_BAST_DOKUMEN_DETAIL);
create index SAKTIKSL.MV_BAST_221023_KBB ON SAKTIKSL.MV_KOM_BAST_ALL_220930_221023(KODE_BUKU_BESAR);