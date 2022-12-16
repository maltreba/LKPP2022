DROP MATERIALIZED VIEW SAKTIKSL.MV_GLP_COA_ANGGARAN_220930_221023;
CREATE MATERIALIZED VIEW SAKTIKSL.MV_GLP_COA_ANGGARAN_220930_221023
AS 
select	AA.KODE_BA_SATKER,
		AA.kode_satker,
		aa.kode_akun,
		bb.nmperk6,
		aa.pagu
from
(	SELECT	KODE_BA_SATKER,
			kode_satker,
			kode_akun,
			sum(pagu) pagu
	from
	(	select	KODE_BA_SATKER,
				kode_satker,
				kode_akun,
				nomor_dipa,
				revisi,
				pagu,
				tahun,
				max(revisi) over (partition by  kode_satker) rev_max
		from	saktiksl.BPK_GLP_COA_220930_221023 
		where	tahun = '2022'
		UNION
		select	KODE_BA_SATKER,
				kode_satker,
				kode_akun,
				nomor_dipa,
				revisi,
				pagu,
				tahun,
				max(revisi) over (partition by  kode_satker) rev_max
		from	saktiksl.BPK_GLP_COA_PAJAK_220930_221023 
		where	tahun = '2022'
	)
	where	revisi = rev_max
	group by	KODE_BA_SATKER,
				kode_satker,
				kode_akun
) aa
left join
(	select	distinct KODE kdperk6,
			trim(deskripsi) nmperk6
	from	SAKTIKSL.BPK_ADM_R_AKUN_220731 
) bb
on aa.kode_akun = bb.kdperk6
--order by	kode_akun
;