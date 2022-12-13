DROP MATERIALIZED VIEW SAKTIKSL.MV_ANGGARAN_BASE_TABLE_220930_221120;
CREATE MATERIALIZED VIEW SAKTIKSL.MV_ANGGARAN_BASE_TABLE_220930_221120
AS 
select	*
from	SAKTIKSL.BPK_ANG_BELANJA_ALLHIST_220930_221120
where	bel_kode_sts_history ='B00'
union all
SELECT	*
from	
(	SELECT	a.*
	from 	
	(	SELECT	*
		FROM	SAKTIKSL.BPK_ANG_BELANJA_ALLHIST_220930_221120
	) a 
	join 
	(	select	bel_nomor_dipa, 
				max(bel_revisi_ke) maks 
		from	SAKTIKSL.BPK_ANG_BELANJA_ALLHIST_220930_221120
		where	bel_jenis_revisi ='DIPA_REVISI'
		group by	bel_nomor_dipa
	) b 
	on	a.bel_nomor_dipa = b.bel_nomor_dipa 
		and a.bel_revisi_ke = b.maks
	where	a.bel_jenis_revisi ='DIPA_REVISI'
);