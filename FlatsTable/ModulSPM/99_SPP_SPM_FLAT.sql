DROP MATERIALIZED VIEW SAKTIKSL.MV_SPP_SPM_ALL_220930_221023;
CREATE MATERIALIZED VIEW SAKTIKSL.MV_SPP_SPM_ALL_220930_221023
AS 
select	bb.ID,
		bb.AKUN_SSPB,
		bb.DELETED,
		case	when bb.DELETED = '0' then 'normal'
				when bb.DELETED = '1' then 'deleted'
			end as ur_DELETED,
		bb.AMOUNT_NOD,
		bb.BAST_IDS,
		bb.BELANJA,
		bb.BULAN_GAJI,
		bb.ID_JADWAL_BYR_KONTRAK,
		bb.ID_KONTRAK,
		bb.ID_SSPB,
		bb.ID_TUP,
		bb.ID_UP,
		bb.JML_PEMBAYARAN,
		bb.JML_PENGELUARAN,
		bb.JML_POTONGAN,
		bb.JUMLAH_SSPB,
		bb.JUMLAH_TUP,
		bb.KD_CARA_BAYAR,
		bb.KD_CARA_PENARIKAN,
		bb.KD_JATUH_TEMPO,
		bb.KD_JNS_BAYAR,
		bb.KD_JNS_SPP,
		GG.deskripsi					ur_jns_spp,
		bb.KD_KPPN,
		TRIM(FF.NMKPPN)					NAMA_KPPN,
		substr(CC.kode_unit,1,3)		kode_ba_satker,
		trim(DD.deskripsi)				nama_ba_satker,
		substr(CC.kode_unit,-2)			kode_eselon1_satker,
		trim(EE.deskripsi)				nama_eselon1_satker,
		BB.KD_SATKER,
		trim(CC.deskripsi)				nama_satker,
		bb.KD_SIFAT_BAYAR,
		bb.KD_VALAS,
		bb.KOMPEN_POT_SPMKP,
		bb.KOMPEN_TRANSFER,
		bb.KOMPENSASI_UM,
		bb.KURS_NOD,
		bb.NILAI_APLIKASI,
		bb.NILAI_BAST,
		bb.NILAI_KEMBALI,
		bb.NILAI_POTONGAN,
		bb.NILAI_REG_INV,
		bb.NILAI_RUPIAH,
		bb.NILAI_SP2B,
		bb.NILAI_SP2D,
		bb.NILAI_SPM,
		bb.NILAI_TUKAR,
		bb.NILAI_UP,
		bb.NO_APLIKASI,
		bb.NO_DIPA,
		bb.NO_DIPA_SSPB,
		bb.NO_GAJI,
		bb.NO_NOD,
		bb.NO_PENGESAHAN,
		bb.NO_PENGESHANAN_SSPB,
		bb.NO_REG_INV,
		bb.NO_REGISTER,
		SS.NAMA_LOAN_GRANT				NAMA_PINJAMAN_HIBAH,
		SS.LENDER_NAME					NAMA_DONOR,
		bb.NO_SSPB,
		bb.NO_SP2B,
		bb.NO_SP2D,
		bb.NO_SP3HL_BJS,
		bb.NO_SPM,
		bb.NO_SPP,
		bb.NO_SPP2,
		bb.NO_TUP,
		bb.NO_UP,
		bb.NO_WA,
		bb.NOMOR_BAST,
		bb.NOP,
		bb.PAYMENT_TERMS,
		bb.PEMOTONGAN_RETENSI,
		bb.PENDAPATAN,
		bb.PERIODE_TRIWULAN,
		bb.PORSI_DISETOR,
		bb.PORSI_TIDAK_DISETOR,
		bb.SALDO_AKHIR,
		bb.SALDO_AKHIR_HIBAH,
		bb.SALDO_AWAL,
		bb.SB_DATA,
		bb.SISA_HIBAH,
		bb.STS_DATA,
		case	when bb.sts_data = 'SPM_STS_DATA_01' then 'Baru'
				when bb.sts_data = 'SPM_STS_DATA_02' then 'Cetak SPP'
				when bb.sts_data = 'SPM_STS_DATA_03' then 'Batal SPP'
				when bb.sts_data = 'SPM_STS_DATA_04' then 'Setuju SPP'
				when bb.sts_data = 'SPM_STS_DATA_05' then 'ADK SPP'
				when bb.sts_data = 'SPM_STS_DATA_06' then 'Batal ADK SPP'
				when bb.sts_data = 'SPM_STS_DATA_07' then 'Upload NTT'
				when bb.sts_data = 'SPM_STS_DATA_08' then 'Cetak SPM'
				when bb.sts_data = 'SPM_STS_DATA_09' then 'Batal SPM'
				when bb.sts_data = 'SPM_STS_DATA_10' then 'Setuju SPM'
				when bb.sts_data = 'SPM_STS_DATA_11' then 'ADK SPM'
				when bb.sts_data = 'SPM_STS_DATA_12' then 'Batal ADK SPM'
				when bb.sts_data = 'SPM_STS_DATA_13' then 'Upload SP2D'
				when bb.sts_data = 'SPM_STS_DATA_14' then 'Permohonan Pembatalan ADK SPM'
				when bb.sts_data = 'SPM_STS_DATA_15' then 'Void SP2D'
			end as ur_sts_data,
		bb.TGL_ADK_SPM,
		bb.TGL_ADK_SPP,
		bb.TGL_APLIKASI,
		bb.TGL_BUKU,
		bb.TGL_DIPA,
		bb.TGL_KURS,
		bb.TGL_KURS_NOD,
		bb.TGL_NOD,
		bb.TGL_PENGESAHAN,
		bb.TGL_PENGESAHAN_SSPB,
		bb.TGL_REG_INV,
		bb.TGL_REGISTER,
		bb.TGL_SSPB,
		bb.TGL_SP2B,
		bb.TGL_SP2D,
		bb.TGL_SP3HL_BJS,
		bb.TGL_SPM,
		bb.TGL_SPP,
		bb.TGL_TUP,
		bb.TGL_UP,
		bb.TGL_WA,
		bb.THN_ANG,
		bb.THN_PAJAK,
		bb.TIPE_INVOICE,
		bb.TIPE_KURS,
		bb.URAIAN,
		bb.URAIAN_PEMBAYARAN,
		bb.NILAI_KONTRAK_PDN,
		bb.NILAI_KONTRAK_PDP,
		bb.NILAI_KONTRAK_PLN,
		bb.PEMBAYARAN_PENDAMPING,
		bb.PORSI_SETOR_SAAT_INI,
		bb.PORSI_TDK_SETOR_SAAT_INI,
		bb.NO_KONTRAK,
		bb.STATUS_APD,
		case	when bb.STATUS_APD = '1' then 'UM'
				when bb.STATUS_APD = '2' then 'KONTRAK'
				when bb.STATUS_APD = '3' then 'RETENSI'
			end as ur_STATUS_APD,
		bb.JNS_SPP_KOREKSI,
		bb.NO_SPP_KOREKSI,
		bb.TGL_SPP_KOREKSI,
		bb.NILAI_KONTRAK_APD,
		bb.ID_SPTB,
		bb.ID_SPP_YG_DIKOREKSI,
		bb.KOREKSI_FLAG,
		case	when KOREKSI_FLAG = '1' then 'SPP Sudah Dikoreksi'
			end as ur_KOREKSI_FLAG,
		bb.ID_JADWAL_RETENSI,
		bb.ID_KONTRAK_RETENSI,
		bb.TGL_SPM_KOREKSI,
		bb.NILAI_TUKAR_SP2D,
		bb.TEMPAT_CETAK_SPM,
		bb.TEMPAT_CETAK_SPP,
		bb.TGL_CETAK_SPM,
		bb.TGL_CETAK_SPP,
		bb.REQ_ID_SPM,
		bb.REQ_ID_SPP,
		aa.*
from
(	select	distinct *
	FROM	saktiksl.BPK_SPM_T_SPP_220930_221023
) bb
LEFT JOIN
(	SELECT	distinct AA.KODE_BUKU_BESAR,
			AA.KODE_BUKU_BESAR_SPM,
			AA.KODE_BUKU_BESAR_KOROLARI,
			AA.KODE_BUKU_BESAR_SPM_KOROLARI,
			AA.KODE_BUKU_BESAR_SPM_KURS,
			AA.KODE_BUKU_BESAR_SPP_KURS,
			AA.KODE_BUKU_BESAR_SPM_KAS,
			AA.id_AKUN_PENGELUARAN,
			AA.DELETED						DELETED_DETAIL,
			AA.FA,
			to_char(AA.ID_COA)				ID_COA,
			ee.KODE_AKUN,
			ff.DESKRIPSI					NAMA_AKUN,
	--		KD_SATKER,
			AA.NILAI_AKUN_PENGELUARAN,
			0								NILAI_AKUN_POTONGAN,
			AA.ID_SPP,
			'PENGELUARAN' sumber
	FROM	SAKTIKSL.BPK_SPM_PENGELUARAN_220930_221023 AA
	left join	saktiksl.BPK_GLP_COA_220930_221023	ee
		ON	aa.ID_COA = ee.id
	left join	SAKTIKSL.BPK_ADM_R_AKUN_220731	ff
		on	ee.KODE_AKUN = ff.kode
	UNION ALL
	SELECT	DISTINCT AA.KODE_BUKU_BESAR,
			AA.KODE_BUKU_BESAR_SPM,
			AA.KODE_BUKU_BESAR_KOROLARI,
			AA.KODE_BUKU_BESAR_SPM_KOROLARI,
			AA.KODE_BUKU_BEAR_SPM_KURS,
			AA.KODE_BUKU_BEAR_SPP_KURS,
			cast (null as VARCHAR2(255))	KODE_BUKU_BESAR_SPM_KAS,
			AA.ID_AKUN_POTONGAN,
			AA.DELETED						DELETED_DETAIL,
			CAST (NULL AS NUMBER(19,2)) FA,
			AA.KD_COA,
			substr(AA.KD_COA,12,6) 			KODE_akun,
			ff.DESKRIPSI					NAMA_AKUN,
	--		KD_SATKER,
			0								NILAI_AKUN_PENGELUARAN,
			AA.NILAI_AKUN_POT				NILAI_AKUN_POTONGAN,
			AA.ID_SPP,
			'POTONGAN' SUMBER
	FROM	SAKTIKSL.BPK_SPM_POTONGAN_220930_221023	AA
	left join	SAKTIKSL.BPK_ADM_R_AKUN_220731	ff
		on	substr(AA.KD_COA,12,6) = ff.kode
) aa
on	bb.id = aa.ID_SPP
left join	SAKTIKSL.BPK_ADM_R_SATKER_220731 CC
	ON	BB.KD_SATKER = CC.KODE
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
LEFT JOIN	EREKON.T_KPPN_220525	FF
	ON	BB.KD_KPPN = FF.KDKPPN
left join	saktiksl.REF_KODE_JENIS_SPP_2022	GG
	ON	BB.KD_JNS_SPP = GG.kode
LEFT JOIN	SPAN.SPPM_REGISTER_LENDER_220825	SS
		ON	BB.NO_REGISTER = SS.REGISTER_NO;
create index SAKTIKSL.IDX_MVSPMSPP_221023_DEL ON SAKTIKSL.MV_SPP_SPM_ALL_220930_221023(DELETED);
create index SAKTIKSL.IDX_MVSPMSPP_221023_NSPP ON SAKTIKSL.MV_SPP_SPM_ALL_220930_221023(NO_SPP);
create index SAKTIKSL.IDX_MVSPMSPP_221023_NSPP2 ON SAKTIKSL.MV_SPP_SPM_ALL_220930_221023(NO_SPP_KOREKSI);
create index SAKTIKSL.IDX_MVSPMSPP_221023_KDSAT ON SAKTIKSL.MV_SPP_SPM_ALL_220930_221023(KD_SATKER);
create index SAKTIKSL.IDX_MVSPMSPP_221023_BA ON SAKTIKSL.MV_SPP_SPM_ALL_220930_221023(kode_ba_satker);
create index SAKTIKSL.IDX_MVSPMSPP_221023_BAES1 ON SAKTIKSL.MV_SPP_SPM_ALL_220930_221023(kode_ba_satker||kode_eselon1_satker);
create index SAKTIKSL.IDX_MVSPMSPP_221023_IDSPP ON SAKTIKSL.MV_SPP_SPM_ALL_220930_221023(ID);
create index SAKTIKSL.IDX_MVSPMSPP_221023_NOREG ON SAKTIKSL.MV_SPP_SPM_ALL_220930_221023(NO_REG_INV);
create index SAKTIKSL.IDX_MVSPMSPP_221023_NSP2D ON SAKTIKSL.MV_SPP_SPM_ALL_220930_221023(NO_SP2D);