DROP MATERIALIZED VIEW SAKTIKSL.MV_SAKTI_ANG_TAGRO_220930_221120_BLOKIR;
CREATE MATERIALIZED VIEW SAKTIKSL.MV_SAKTI_ANG_TAGRO_220930_221120_BLOKIR
AS 
WITH 
LIST_DETAIL
AS
(	select	DISTINCT bel_kode_kementerian||'.'||bel_kode_unit||'.'||out_kode_program||'.'||out_kode_kegiatan||'.'||out_kode_output||'.'||subout_kode kode_detail,
			bel_kode_satker,
			BEL_NOMOR_DIPA
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
(	SELECT	AA.*,
			cc.KDKANWIL,
			CC.nmkanwil
	FROM
	(	select	distinct 
				KODE_SATKER			kdsatker,
				NAMA_SATKER			nmsatker,
				KODE_BA_SATKER		KDDEPT ,
				nmdept,
				KODE_BAES1_SATKER	KDBAES1 ,
				NMUNIT NMBAES1,
				KODE_KPPN,
				NMKPPN,
				KOTAKPPN
		from	SAKTIKSL.MV_MASTER_SATKER_MONSAKTI_2022 
	) aa
	LEFT JOIN
	(	SELECT	AA1.*,
				BB1.nmkanwil
		FROM
		(   select	distinct kdkppn,
					KDKANWIL
			from	erekon.T_KPPN_220525
			where	kdkppn not in ('555', '183', '184', '901', '902', '903', '904', '905', '909', '999', 'XXX')
		) aa1
		left join	erekon.T_KANWIL_220525 bb1
			on	aa1.kdkanwil = bb1.kdkanwil
	) CC
	ON	AA.KODE_KPPN = CC.kdkppn
),
DIPA_AWAL AS
(	--coding DIPA Awal
	--Perlu distinct target suboutput per kode RO
	--dan distinct nilai DIPA per kode RO + per kode lokasi
	SELECT	AA.kode_detail,
			AA.bel_kode_satker,
			AA.BEL_NOMOR_DIPA,
			AA.bel_revisi_ke,
			bb.subout_volume	vol_awal,
			AA.subout_total		nilai_awal,
			AA.blokir1,
			AA.blokir2,
			AA.blokir3,
			AA.blokir4,
			AA.blokir5,
			AA.blokir6,
			AA.blokir7,
			AA.blokir8,
			AA.blokir9
	from	
	(	SELECT	kode_detail,
				bel_kode_satker,
				BEL_NOMOR_DIPA,
				bel_revisi_ke,
				sum(item_total) subout_total,
				sum(item_nilai_blokir1)	blokir1,
				sum(item_nilai_blokir2) blokir2,
				sum(item_nilai_blokir3) blokir3,
				sum(item_nilai_blokir4) blokir4,
				sum(item_nilai_blokir5) blokir5,
				sum(item_nilai_blokir6) blokir6,
				sum(item_nilai_blokir7) blokir7,
				sum(item_nilai_blokir8) blokir8,
				sum(item_nilai_blokir9) blokir9
		from
		(	select	bel_kode_kementerian||'.'||bel_kode_unit||'.'||out_kode_program||'.'||out_kode_kegiatan||'.'||out_kode_output||'.'||subout_kode kode_detail,
					bel_kode_satker,
					BEL_NOMOR_DIPA,
					bel_revisi_ke,
					SUBOUT_KODE_PROPINSI,
					SUBOUT_KODE_KOTA,
					SUBOUT_KODE_PROPINSI||SUBOUT_KODE_KOTA SUBOUT_KODE_LOKASI,
					AKUN_KODE_BLOKIR,
			--		subout_total,
					item_total,
					decode(AKUN_KODE_BLOKIR,'1',ITEM_NILAI_BLOKIR_PHLN + ITEM_NILAI_BLOKIR_RM + ITEM_NILAI_BLOKIR_RMP + ITEM_NILAI_BLOKIR_RPLN, 0) item_nilai_blokir1,
					decode(AKUN_KODE_BLOKIR,'2',ITEM_NILAI_BLOKIR_PHLN + ITEM_NILAI_BLOKIR_RM + ITEM_NILAI_BLOKIR_RMP + ITEM_NILAI_BLOKIR_RPLN, 0) item_nilai_blokir2,
					decode(AKUN_KODE_BLOKIR,'3',ITEM_NILAI_BLOKIR_PHLN + ITEM_NILAI_BLOKIR_RM + ITEM_NILAI_BLOKIR_RMP + ITEM_NILAI_BLOKIR_RPLN, 0) item_nilai_blokir3,
					decode(AKUN_KODE_BLOKIR,'4',ITEM_NILAI_BLOKIR_PHLN + ITEM_NILAI_BLOKIR_RM + ITEM_NILAI_BLOKIR_RMP + ITEM_NILAI_BLOKIR_RPLN, 0) item_nilai_blokir4,
					decode(AKUN_KODE_BLOKIR,'5',ITEM_NILAI_BLOKIR_PHLN + ITEM_NILAI_BLOKIR_RM + ITEM_NILAI_BLOKIR_RMP + ITEM_NILAI_BLOKIR_RPLN, 0) item_nilai_blokir5,
					decode(AKUN_KODE_BLOKIR,'6',ITEM_NILAI_BLOKIR_PHLN + ITEM_NILAI_BLOKIR_RM + ITEM_NILAI_BLOKIR_RMP + ITEM_NILAI_BLOKIR_RPLN, 0) item_nilai_blokir6,
					decode(AKUN_KODE_BLOKIR,'7',ITEM_NILAI_BLOKIR_PHLN + ITEM_NILAI_BLOKIR_RM + ITEM_NILAI_BLOKIR_RMP + ITEM_NILAI_BLOKIR_RPLN, 0) item_nilai_blokir7,
					decode(AKUN_KODE_BLOKIR,'8',ITEM_NILAI_BLOKIR_PHLN + ITEM_NILAI_BLOKIR_RM + ITEM_NILAI_BLOKIR_RMP + ITEM_NILAI_BLOKIR_RPLN, 0) item_nilai_blokir8,
					decode(AKUN_KODE_BLOKIR,'9',ITEM_NILAI_BLOKIR_PHLN + ITEM_NILAI_BLOKIR_RM + ITEM_NILAI_BLOKIR_RMP + ITEM_NILAI_BLOKIR_RPLN, 0) item_nilai_blokir9
			from	saktiksl.MV_anggaran_base_table_220930_221120
			WHERE	BEL_JENIS_REVISI  = 'DIPA_AWAL'
		)
		GROUP BY	kode_detail,
					bel_kode_satker,
					BEL_NOMOR_DIPA,
					bel_revisi_ke
	) AA
	JOIN
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
		AND AA.BEL_NOMOR_DIPA = BB.BEL_NOMOR_DIPA
),
DIPA_REVISI AS
(	--Coding DIPA Revisi
	--Perlu distinct target suboutput per kode RO
	--dan distinct nilai DIPA per kode RO + per kode lokasi
	SELECT	AA.kode_detail,
			AA.bel_kode_satker,
			AA.BEL_NOMOR_DIPA,
			AA.bel_revisi_ke,
			bb.subout_volume vol_revisi,
			AA.subout_total nilai_revisi,
			AA.blokir1,
			AA.blokir2,
			AA.blokir3,
			AA.blokir4,
			AA.blokir5,
			AA.blokir6,
			AA.blokir7,
			AA.blokir8,
			AA.blokir9
	from	
	(	SELECT	kode_detail,
				bel_kode_satker,
				BEL_NOMOR_DIPA,
				bel_revisi_ke,
				sum(item_total) subout_total,
				sum(item_nilai_blokir1)	blokir1,
				sum(item_nilai_blokir2) blokir2,
				sum(item_nilai_blokir3) blokir3,
				sum(item_nilai_blokir4) blokir4,
				sum(item_nilai_blokir5) blokir5,
				sum(item_nilai_blokir6) blokir6,
				sum(item_nilai_blokir7) blokir7,
				sum(item_nilai_blokir8) blokir8,
				sum(item_nilai_blokir9) blokir9
		from
		(	select	bel_kode_kementerian||'.'||bel_kode_unit||'.'||out_kode_program||'.'||out_kode_kegiatan||'.'||out_kode_output||'.'||subout_kode kode_detail,
					bel_kode_satker,
					BEL_NOMOR_DIPA,
					bel_revisi_ke,
					SUBOUT_KODE_PROPINSI,
					SUBOUT_KODE_KOTA,
					SUBOUT_KODE_PROPINSI||SUBOUT_KODE_KOTA SUBOUT_KODE_LOKASI,
					AKUN_KODE_BLOKIR,
			--		subout_total,
					item_total,
					decode(AKUN_KODE_BLOKIR,'1',ITEM_NILAI_BLOKIR_PHLN + ITEM_NILAI_BLOKIR_RM + ITEM_NILAI_BLOKIR_RMP + ITEM_NILAI_BLOKIR_RPLN, 0) item_nilai_blokir1,
					decode(AKUN_KODE_BLOKIR,'2',ITEM_NILAI_BLOKIR_PHLN + ITEM_NILAI_BLOKIR_RM + ITEM_NILAI_BLOKIR_RMP + ITEM_NILAI_BLOKIR_RPLN, 0) item_nilai_blokir2,
					decode(AKUN_KODE_BLOKIR,'3',ITEM_NILAI_BLOKIR_PHLN + ITEM_NILAI_BLOKIR_RM + ITEM_NILAI_BLOKIR_RMP + ITEM_NILAI_BLOKIR_RPLN, 0) item_nilai_blokir3,
					decode(AKUN_KODE_BLOKIR,'4',ITEM_NILAI_BLOKIR_PHLN + ITEM_NILAI_BLOKIR_RM + ITEM_NILAI_BLOKIR_RMP + ITEM_NILAI_BLOKIR_RPLN, 0) item_nilai_blokir4,
					decode(AKUN_KODE_BLOKIR,'5',ITEM_NILAI_BLOKIR_PHLN + ITEM_NILAI_BLOKIR_RM + ITEM_NILAI_BLOKIR_RMP + ITEM_NILAI_BLOKIR_RPLN, 0) item_nilai_blokir5,
					decode(AKUN_KODE_BLOKIR,'6',ITEM_NILAI_BLOKIR_PHLN + ITEM_NILAI_BLOKIR_RM + ITEM_NILAI_BLOKIR_RMP + ITEM_NILAI_BLOKIR_RPLN, 0) item_nilai_blokir6,
					decode(AKUN_KODE_BLOKIR,'7',ITEM_NILAI_BLOKIR_PHLN + ITEM_NILAI_BLOKIR_RM + ITEM_NILAI_BLOKIR_RMP + ITEM_NILAI_BLOKIR_RPLN, 0) item_nilai_blokir7,
					decode(AKUN_KODE_BLOKIR,'8',ITEM_NILAI_BLOKIR_PHLN + ITEM_NILAI_BLOKIR_RM + ITEM_NILAI_BLOKIR_RMP + ITEM_NILAI_BLOKIR_RPLN, 0) item_nilai_blokir8,
					decode(AKUN_KODE_BLOKIR,'9',ITEM_NILAI_BLOKIR_PHLN + ITEM_NILAI_BLOKIR_RM + ITEM_NILAI_BLOKIR_RMP + ITEM_NILAI_BLOKIR_RPLN, 0) item_nilai_blokir9
			from	saktiksl.MV_anggaran_base_table_220930_221120
			WHERE	BEL_JENIS_REVISI  = 'DIPA_REVISI'
		)
		GROUP BY	kode_detail,
					bel_kode_satker,
					BEL_NOMOR_DIPA,
					bel_revisi_ke
	) AA
	JOIN
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
		AND AA.BEL_NOMOR_DIPA = BB.BEL_NOMOR_DIPA
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
		NVL(EE1.vol_awal,0) vol_awal,
		CASE	WHEN DD1.bel_revisi_ke = 0 THEN NVL(EE1.vol_awal,0)
				ELSE NVL(FF1.vol_revisi,0) 
			END AS vol_revisi,
		NVL(EE1.nilai_awal,0) nilai_awal,
		CASE	WHEN DD1.bel_revisi_ke = 0 THEN NVL(EE1.nilai_awal,0)
				ELSE NVL(FF1.nilai_revisi,0) 
			END AS nilai_revisi,
		nvl(EE1.blokir1,0)	blokir1_awal,
		nvl(EE1.blokir2,0)	blokir2_awal,
		nvl(EE1.blokir3,0)	blokir3_awal,
		nvl(EE1.blokir4,0)	blokir4_awal,
		nvl(EE1.blokir5,0)	blokir5_awal,
		nvl(EE1.blokir6,0)	blokir6_awal,
		nvl(EE1.blokir7,0)	blokir7_awal,
		nvl(EE1.blokir8,0)	blokir8_awal,
		nvl(EE1.blokir9,0)	blokir9_awal,
		case	when DD1.bel_revisi_ke = 0 THEN NVL(EE1.blokir1,0)
				ELSE NVL(FF1.blokir1,0) 
			END AS blokir1_revisi,
		case	when DD1.bel_revisi_ke = 0 THEN NVL(EE1.blokir2,0)
				ELSE NVL(FF1.blokir2,0) 
			END AS blokir2_revisi,
		case	when DD1.bel_revisi_ke = 0 THEN NVL(EE1.blokir3,0)
				ELSE NVL(FF1.blokir3,0) 
			END AS blokir3_revisi,
		case	when DD1.bel_revisi_ke = 0 THEN NVL(EE1.blokir4,0)
				ELSE NVL(FF1.blokir4,0) 
			END AS blokir4_revisi,
		case	when DD1.bel_revisi_ke = 0 THEN NVL(EE1.blokir5,0)
				ELSE NVL(FF1.blokir5,0) 
			END AS blokir5_revisi,
		case	when DD1.bel_revisi_ke = 0 THEN NVL(EE1.blokir6,0)
				ELSE NVL(FF1.blokir6,0) 
			END AS blokir6_revisi,
		case	when DD1.bel_revisi_ke = 0 THEN NVL(EE1.blokir7,0)
				ELSE NVL(FF1.blokir7,0) 
			END AS blokir7_revisi,
		case	when DD1.bel_revisi_ke = 0 THEN NVL(EE1.blokir8,0)
				ELSE NVL(FF1.blokir8,0) 
			END AS blokir8_revisi,
		case	when DD1.bel_revisi_ke = 0 THEN NVL(EE1.blokir9,0)
				ELSE NVL(FF1.blokir9,0) 
			END AS blokir9_revisi,
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
		CC1.KODE_KPPN,
		CC1.NMKPPN,
		CC1.KOTAKPPN,
		cc1.KDKANWIL,
		CC1.nmkanwil
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
LEFT JOIN	DIPA_REVISI FF1
	ON	AA1.kode_detail = FF1.kode_detail
		AND AA1.BEL_KODE_SATKER = FF1.BEL_KODE_SATKER
		AND AA1.BEL_NOMOR_DIPA = FF1.BEL_NOMOR_DIPA;