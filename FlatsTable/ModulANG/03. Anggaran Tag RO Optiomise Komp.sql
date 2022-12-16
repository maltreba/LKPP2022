DROP MATERIALIZED VIEW SAKTIKSL.MV_SAKTI_ANG_TAGRO_KOM_220930_221120;
CREATE MATERIALIZED VIEW SAKTIKSL.MV_SAKTI_ANG_TAGRO_KOM_220930_221120
AS 
WITH 
LIST_DETAIL
AS
(	select	DISTINCT bel_kode_kementerian||'.'||bel_kode_unit||'.'||out_kode_program||'.'||out_kode_kegiatan||'.'||out_kode_output||'.'||subout_kode kode_detail,
			bel_kode_satker,
			BEL_NOMOR_DIPA,
			KOM_KODE,
			KOM_URAIAN,
			SUBKOM_KODE,
			SUBKOM_URAIAN
	FROM	saktiksl.MV_anggaran_base_table_220930_221120
),
LIST_REFERENSI
AS
(	SELECT	AA.kode_detail, 
			AA.KDDEPT,
			AA.KDUNIT,
			aa.kdprogram,
			JJ.NMPROGRAM NAMA_PROGRAM,
			aa.kdgiat,
			KK.NMGIAT NAMA_GIAT,
			aa.kdoutput,
			LL.NMOUTPUT NAMA_OUTPUT,
			aa.kdsoutput,
			AA.nmsoutput, 
			AA.satuan, 
			AA.kode_janpres,
			BB.NMJANPRES NAMA_JANPRES,
			AA.kode_nawacita, 
			CC.NMNAWACITA NAMA_NAWACITA,
			AA.kode_pn, 
			DD.NMPN NAMA_PN,
			AA.kode_pp, 
			EE.NMPP NAMA_PP,
			AA.kode_kp,
			FF.NMKP NAMA_KP,
			AA.kode_proyek,
			GG.NMPROY NAMA_PROY,
--			AA.kode_tematik,
			AA.kode_pen,
			HH.NMPEN NAMA_PEN
--			AA.kode_mp
	FROM
	(	select	DISTINCT kddept||'.'||kdunit||'.'||kdprogram||'.'||kdgiat||'.'||kdoutput||'.'||kdsoutput kode_detail, 
				kddept,
				kdunit,
				kdprogram,
				kdgiat,
				kdoutput,
				kdsoutput,
				nmsoutput, 
				sat as satuan, 
				kdjanpres as kode_janpres, 
				kdnawacita as kode_nawacita, 
				kdpn as kode_pn, 
				kdpp as kode_pp, 
				kdkp as kode_kp,
				kdproy as kode_proyek,
				kdtema as kode_tematik,
				kdpen as kode_pen--,
--				kdmp as kode_mp
		from	saktiksl.T_SOUTPUT_220930_221120 
		where	thang = '2022'
	) AA
	LEFT JOIN
	(	SELECT	DISTINCT KDJANPRES,
				NMJANPRES
		FROM	SAKTIKSL.T_JANPRES_220930_221120 
	) BB
	ON	AA.kode_janpres = BB.KDJANPRES
	LEFT JOIN
	(	SELECT	DISTINCT KDNAWACITA,
				NMNAWACITA
		FROM	SAKTIKSL.T_NAWACITA_220930_221120
	) CC
	ON	AA.kode_nawacita = CC.KDNAWACITA
	LEFT JOIN
	(	SELECT	DISTINCT KDPN,
				NMPN
		FROM	SAKTIKSL.T_PRINAS_220930_221120
	) DD
	ON	AA.kode_pn = DD.KDPN
	LEFT JOIN
	(	SELECT	DISTINCT KDPN,
				KDPP,
				NMPP
		FROM	SAKTIKSL.T_PRIPROG_220930_221120
	) EE
	ON	AA.KODE_PN = EE.KDPN 
		AND AA.kode_pp = EE.KDPP 
	LEFT JOIN
	(	SELECT	DISTINCT KDPN,
				KDPP,
				KDKP,
				NMKP
		FROM	SAKTIKSL.T_PRIGIAT_220930_221120 
	) FF
	ON	AA.KODE_PN = FF.KDPN 
		AND AA.kode_pp = FF.KDPP 
		AND AA.kode_kp = FF.KDKP
	LEFT JOIN
	(	SELECT	DISTINCT KDPN,
				KDPP,
				KDKP,
				KDPROY,
				NMPROY
		FROM	SAKTIKSL.T_PRIPROY_220930_221120 
	) GG
	ON	AA.KODE_PN = GG.KDPN 
		AND AA.kode_pp = GG.KDPP 
		AND AA.kode_kp = GG.KDKP
		AND AA.kode_proyek = GG.KDPROY 
	LEFT JOIN
	(	SELECT	DISTINCT KDPEN,
				NMPEN
		FROM	SAKTIKSL.T_PEN_CLUSTER_220930_221120 
	) HH
	ON 	AA.kode_pen = HH.KDPEN 
	LEFT JOIN
	(	SELECT	DISTINCT KDDEPT,
				KDUNIT,
				KDPROGRAM,
				NMPROGRAM
		FROM	SAKTIKSL.T_PROGRAM_220930_221120 
		WHERE	THANG = '2022'
	) JJ
	ON	AA.KDDEPT = JJ.KDDEPT
		AND AA.KDUNIT = JJ.KDUNIT
		AND AA.KDPROGRAM = JJ.KDPROGRAM
	LEFT JOIN
	(	SELECT	DISTINCT KDDEPT,
				KDUNIT,
				KDPROGRAM,
				KDGIAT,
				NMGIAT
		FROM	SAKTIKSL.T_GIAT_220930_221120 
		WHERE	THANG = '2022'
	) KK
	ON	AA.KDDEPT = KK.KDDEPT
		AND AA.KDUNIT = KK.KDUNIT
		AND AA.KDPROGRAM = KK.KDPROGRAM
		AND AA.KDGIAT = KK.KDGIAT
	LEFT JOIN
	(	SELECT	DISTINCT KDDEPT,
				KDUNIT,
				KDPROGRAM,
				KDGIAT,
				KDOUTPUT,
				NMOUTPUT
		FROM	SAKTIKSL.T_OUTPUT_220930_221120 
		WHERE	THANG = '2022'
	) LL
	ON	AA.KDDEPT = LL.KDDEPT
		AND AA.KDUNIT = LL.KDUNIT
		AND AA.KDPROGRAM = LL.KDPROGRAM
		AND AA.KDGIAT = LL.KDGIAT
		AND aa.KDOUTPUT = LL.KDOUTPUT
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
			AA.KOM_KODE,
			AA.SUBKOM_KODE,
--			bb.subout_volume vol_awal,
			AA.subout_total nilai_awal
	from	
	(	SELECT	bel_kode_kementerian||'.'||bel_kode_unit||'.'||out_kode_program||'.'||out_kode_kegiatan||'.'||out_kode_output||'.'||subout_kode	kode_detail,
				bel_kode_satker,
				BEL_NOMOR_DIPA,
				bel_revisi_ke,
				KOM_KODE,
				SUBKOM_KODE,
				sum(ITEM_TOTAL) subout_total
		from	saktiksl.MV_anggaran_base_table_220930_221120
		WHERE	BEL_JENIS_REVISI  = 'DIPA_AWAL'
		GROUP BY	bel_kode_kementerian||'.'||bel_kode_unit||'.'||out_kode_program||'.'||out_kode_kegiatan||'.'||out_kode_output||'.'||subout_kode,
					bel_kode_satker,
					BEL_NOMOR_DIPA,
					bel_revisi_ke,
					KOM_KODE,
					SUBKOM_KODE
	) AA
/*	JOIN
	(	SELECT	kode_detail,
				bel_kode_satker,
				BEL_NOMOR_DIPA,
				sum(subout_volume) subout_volume
		from
		(	SELECT	DISTINCT bel_kode_kementerian||'.'||bel_kode_unit||'.'||out_kode_program||'.'||out_kode_kegiatan||'.'||out_kode_output||'.'||subout_kode kode_detail,
					bel_kode_satker,
					BEL_NOMOR_DIPA,	
					subout_volume
			FROM	saktiksl.MV_anggaran_base_table_220930_221120
			WHERE	BEL_JENIS_REVISI  = 'DIPA_AWAL'
		)
		GROUP BY	kode_detail,
					bel_kode_satker,
					BEL_NOMOR_DIPA
	) BB
	ON	AA.kode_detail = BB.kode_detail
		AND AA.bel_kode_satker = BB.bel_kode_satker
		AND AA.BEL_NOMOR_DIPA = BB.BEL_NOMOR_DIPA*/
),
DIPA_REVISI AS
(	SELECT	*
	from
	(	--Coding DIPA Revisi
		--Perlu distinct target suboutput per kode RO
		--dan distinct nilai DIPA per kode RO + per kode lokasi
		SELECT	AA.kode_detail,
				AA.bel_kode_satker,
				AA.BEL_NOMOR_DIPA,
				AA.bel_revisi_ke,
				AA.KOM_KODE,
				AA.SUBKOM_KODE,
				max(AA.bel_revisi_ke) over (partition by AA.kode_detail, AA.bel_kode_satker, AA.BEL_NOMOR_DIPA) max_rev,
--				bb.subout_volume vol_revisi,
				AA.subout_total nilai_revisi
		from	
		(	SELECT	bel_kode_kementerian||'.'||bel_kode_unit||'.'||out_kode_program||'.'||out_kode_kegiatan||'.'||out_kode_output||'.'||subout_kode	kode_detail,
					bel_kode_satker,
					BEL_NOMOR_DIPA,
					bel_revisi_ke,
					KOM_KODE,
					SUBKOM_KODE,
					sum(ITEM_TOTAL) subout_total
			from	saktiksl.MV_anggaran_base_table_220930_221120
			WHERE	BEL_JENIS_REVISI  = 'DIPA_REVISI'
			GROUP BY	bel_kode_kementerian||'.'||bel_kode_unit||'.'||out_kode_program||'.'||out_kode_kegiatan||'.'||out_kode_output||'.'||subout_kode,
						bel_kode_satker,
						BEL_NOMOR_DIPA,
						bel_revisi_ke,
						KOM_KODE,
						SUBKOM_KODE
		) AA
/*		JOIN
		(	SELECT	kode_detail,
					bel_kode_satker,
					BEL_NOMOR_DIPA,
					sum(subout_volume) subout_volume
			from
			(	SELECT	DISTINCT bel_kode_kementerian||'.'||bel_kode_unit||'.'||out_kode_program||'.'||out_kode_kegiatan||'.'||out_kode_output||'.'||subout_kode kode_detail,
						bel_kode_satker,
						BEL_NOMOR_DIPA,	
						subout_volume
				FROM	saktiksl.MV_anggaran_base_table_220930_221120
				WHERE	BEL_JENIS_REVISI  = 'DIPA_REVISI'
			)
			GROUP BY	kode_detail,
						bel_kode_satker,
						BEL_NOMOR_DIPA
		) BB
		ON	AA.kode_detail = BB.kode_detail
			AND AA.bel_kode_satker = BB.bel_kode_satker
			AND AA.BEL_NOMOR_DIPA = BB.BEL_NOMOR_DIPA*/
	)
	where	bel_revisi_ke = max_rev
),
MAX_REV_KE AS
(	select	bel_nomor_dipa,
			max(bel_revisi_ke) bel_revisi_ke
	from	saktiksl.MV_anggaran_base_table_220930_221120
	group by	bel_nomor_dipa
)
select	AA1.kode_detail, 
		CC1.KDDEPT ,
		trim(CC1.NMDEPT)			NMDEPT,
		CC1.KDBAES1 ,
		trim(CC1.NMBAES1)			NMBAES1,
		AA1.bel_kode_satker			kode_satker,
		trim(CC1.nmsatker)			nmsatker,
		AA1.BEL_NOMOR_DIPA,
		DD1.bel_revisi_ke,
		BB1.kdprogram,
		trim(BB1.NAMA_PROGRAM)		NAMA_PROGRAM,
		BB1.kdgiat,
		trim(BB1.NAMA_GIAT)			NAMA_GIAT,
		BB1.kdoutput,
		trim(BB1.NAMA_OUTPUT)		NAMA_OUTPUT,
		BB1.kdsoutput,
		trim(BB1.nmsoutput)			nmsoutput, 
		BB1.satuan satuan_soutput, 
--		NVL(EE1.vol_awal,0) vol_awal,
--		CASE	WHEN DD1.bel_revisi_ke = 0 THEN NVL(EE1.vol_awal,0)
--				ELSE NVL(FF1.vol_revisi,0) 
--		END AS vol_revisi,
		NVL(EE1.nilai_awal,0) nilai_awal,
		CASE	WHEN DD1.bel_revisi_ke = 0 THEN NVL(EE1.nilai_awal,0)
				ELSE NVL(FF1.nilai_revisi,0) 
		END AS nilai_revisi,
		BB1.kode_janpres, 
		trim(BB1.NAMA_JANPRES)		NAMA_JANPRES,
		BB1.kode_nawacita, 
		trim(BB1.NAMA_NAWACITA)		NAMA_NAWACITA,
		BB1.kode_pn, 
		trim(BB1.NAMA_PN)			NAMA_PN,
		BB1.kode_pp, 
		trim(BB1.NAMA_PP)			NAMA_PP,
		BB1.kode_kp,
		trim(BB1.NAMA_KP)			NAMA_KP,
		BB1.kode_proyek,
		trim(BB1.NAMA_PROY)			NAMA_PROY,
	--	BB1.kode_tematik,
		BB1.kode_pen,
		trim(BB1.NAMA_PEN)			NAMA_PEN,
	--	BB1.kode_mp
		AA1.KOM_KODE,
		AA1.KOM_URAIAN,
		AA1.SUBKOM_KODE,
		AA1.SUBKOM_URAIAN
FROM	LIST_DETAIL AA1
LEFT JOIN	LIST_REFERENSI BB1
	ON	AA1.kode_detail = BB1.kode_detail
LEFT JOIN	LIST_SATKER CC1
	ON	AA1.bel_kode_satker = CC1.kdsatker
LEFT JOIN	MAX_REV_KE DD1
	ON	AA1.BEL_NOMOR_DIPA = DD1.BEL_NOMOR_DIPA
LEFT JOIN	DIPA_AWAL EE1
	ON	AA1.kode_detail = EE1.kode_detail
		AND AA1.BEL_KODE_SATKER = EE1.BEL_KODE_SATKER
		AND AA1.BEL_NOMOR_DIPA = EE1.BEL_NOMOR_DIPA
		AND AA1.KOM_KODE = EE1.KOM_KODE
		AND AA1.SUBKOM_KODE = EE1.SUBKOM_KODE
LEFT JOIN	DIPA_REVISI FF1
	ON	AA1.kode_detail = FF1.kode_detail
		AND AA1.BEL_KODE_SATKER = FF1.BEL_KODE_SATKER
		AND AA1.BEL_NOMOR_DIPA = FF1.BEL_NOMOR_DIPA
		AND AA1.KOM_KODE = FF1.KOM_KODE
		AND AA1.SUBKOM_KODE = FF1.SUBKOM_KODE;