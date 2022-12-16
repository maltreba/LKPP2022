DROP MATERIALIZED VIEW SAKTIKSL.MV_ANGGARAN_AKUN_220930_221120;
CREATE MATERIALIZED VIEW SAKTIKSL.MV_ANGGARAN_AKUN_220930_221120
AS 
WITH 
LIST_DETAIL
AS
(	select	DISTINCT bel_kode_kementerian||'.'||bel_kode_unit||'.'||out_kode_program||'.'||out_kode_kegiatan||'.'||out_kode_output||'.'||subout_kode kode_detail,
			bel_kode_satker,
			AKUN_KODE_AKUN,
			BEL_NOMOR_DIPA
	FROM	saktiksl.mv_anggaran_base_table_220930_221120
),
LIST_SATKER AS
(	select	distinct AA.kode								kdsatker,
			AA.deskripsi									nmsatker,
			substr(AA.kode_unit,1,3)						KDDEPT ,
			BB.DESKRIPSI									NMDEPT,
			substr(AA.kode_unit,1,3)||substr(kode_unit,-2)	KDBAES1 ,
			CC.DESKRIPSI									NMBAES1
	from	saktiksl.BPK_ADM_R_SATKER_220731	aa
	LEFT JOIN
		(	SELECT	DISTINCT *
			FROM	saktiksl.BPK_ADM_R_KEMENTERIAN_220731
			WHERE	LEVEL_ = '1'
		) BB
			ON	substr(AA.kode_unit,1,3) = BB.KODE
	LEFT JOIN
		(	SELECT	DISTINCT *
			FROM	saktiksl.BPK_ADM_R_KEMENTERIAN_220731
			WHERE	LEVEL_ = '2'
		) CC
			ON	AA.kode_unit = cc.kode
),
DIPA_AWAL AS
(	--coding DIPA Awal
	--Perlu distinct target suboutput per kode RO
	--dan distinct nilai DIPA per kode RO + per kode lokasi
	SELECT	AA.kode_detail,
			AA.bel_kode_satker,
			AA.BEL_NOMOR_DIPA,
			AA.bel_revisi_ke,
			aa.AKUN_KODE_AKUN,
			AA.subout_total nilai_awal
	from	
	(	SELECT	kode_detail,
				bel_kode_satker,
				BEL_NOMOR_DIPA,
				bel_revisi_ke,
				AKUN_KODE_AKUN,
				sum(item_total) subout_total
		from
		(	select	bel_kode_kementerian||'.'||bel_kode_unit||'.'||out_kode_program||'.'||out_kode_kegiatan||'.'||out_kode_output||'.'||subout_kode kode_detail,
					bel_kode_satker,
					BEL_NOMOR_DIPA,
					bel_revisi_ke,
					SUBOUT_KODE_PROPINSI,
					SUBOUT_KODE_KOTA,
					SUBOUT_KODE_PROPINSI||SUBOUT_KODE_KOTA SUBOUT_KODE_LOKASI,
					AKUN_KODE_AKUN,
					ITEM_TOTAL 
			from	saktiksl.mv_anggaran_base_table_220930_221120
			WHERE	BEL_JENIS_REVISI  = 'DIPA_AWAL'
		)
		GROUP BY	kode_detail,
					bel_kode_satker,
					BEL_NOMOR_DIPA,
					bel_revisi_ke,
					AKUN_KODE_AKUN
	) AA
),
DIPA_REVISI AS
(	--Coding DIPA Revisi
	--Perlu distinct target suboutput per kode RO
	--dan distinct nilai DIPA per kode RO + per kode lokasi
	SELECT	AA.kode_detail,
			AA.bel_kode_satker,
			AA.BEL_NOMOR_DIPA,
			AA.bel_revisi_ke,
			aa.AKUN_KODE_AKUN,
			AA.subout_total nilai_revisi
	from	
	(	SELECT	kode_detail,
				bel_kode_satker,
				BEL_NOMOR_DIPA,
				bel_revisi_ke,
				AKUN_KODE_AKUN,
				sum(item_total) subout_total
		from
		(	select	bel_kode_kementerian||'.'||bel_kode_unit||'.'||out_kode_program||'.'||out_kode_kegiatan||'.'||out_kode_output||'.'||subout_kode kode_detail,
					bel_kode_satker,
					BEL_NOMOR_DIPA,
					bel_revisi_ke,
					SUBOUT_KODE_PROPINSI,
					SUBOUT_KODE_KOTA,
					SUBOUT_KODE_PROPINSI||SUBOUT_KODE_KOTA SUBOUT_KODE_LOKASI,
					AKUN_KODE_AKUN,
					item_total
			from	saktiksl.mv_anggaran_base_table_220930_221120
			WHERE	BEL_JENIS_REVISI  = 'DIPA_REVISI'
		)
		GROUP BY	kode_detail,
					bel_kode_satker,
					BEL_NOMOR_DIPA,
					bel_revisi_ke,
					AKUN_KODE_AKUN
	) AA
),
MAX_REV_KE AS
(	select	bel_nomor_dipa,
			max(bel_revisi_ke) bel_revisi_ke
	from	saktiksl.mv_anggaran_base_table_220930_221120
	group by	bel_nomor_dipa
)
select	AA1.kode_detail, 
		CC1.KDDEPT ,
		CC1.NMDEPT ,
		CC1.KDBAES1 ,
		CC1.NMBAES1 ,
		AA1.bel_kode_satker kode_satker,
		CC1.nmsatker,
		AA1.BEL_NOMOR_DIPA,
		aa1.akun_kode_akun,
		DD1.bel_revisi_ke,
		NVL(EE1.nilai_awal,0) nilai_awal,
		CASE	WHEN DD1.bel_revisi_ke = 0 THEN NVL(EE1.nilai_awal,0)
				ELSE NVL(FF1.nilai_revisi,0) 
		END AS nilai_revisi
FROM	LIST_DETAIL AA1
LEFT JOIN	LIST_SATKER CC1
	ON	AA1.bel_kode_satker = CC1.kdsatker
LEFT JOIN	MAX_REV_KE DD1
	ON	AA1.BEL_NOMOR_DIPA = DD1.BEL_NOMOR_DIPA
LEFT JOIN	DIPA_AWAL EE1
	ON	AA1.kode_detail = EE1.kode_detail
		AND AA1.BEL_KODE_SATKER = EE1.BEL_KODE_SATKER
		AND AA1.BEL_NOMOR_DIPA = EE1.BEL_NOMOR_DIPA
		AND aa1.akun_kode_akun = ee1.akun_kode_akun
LEFT JOIN	DIPA_REVISI FF1
	ON	AA1.kode_detail = FF1.kode_detail
		AND AA1.BEL_KODE_SATKER = FF1.BEL_KODE_SATKER
		AND AA1.BEL_NOMOR_DIPA = FF1.BEL_NOMOR_DIPA
		AND aa1.akun_kode_akun = ff1.akun_kode_akun;