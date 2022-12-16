drop materialized view saktiksl.mv_SPM_T_SPP_220930_221023;
create materialized view saktiksl.mv_SPM_T_SPP_220930_221023
as
SELECT	AA.ID,
		AA.AKUN_SSPB,
		AA.DELETED,
		case	when aa.DELETED = '0' then 'normal'
				when aa.DELETED = '1' then 'deleted'
			end as ur_DELETED,
		AA.AMOUNT_NOD,
		AA.BAST_IDS,
		AA.BELANJA,
		AA.BULAN_GAJI,
		AA.ID_JADWAL_BYR_KONTRAK,
		AA.ID_KONTRAK,
		AA.ID_SSPB,
		AA.ID_TUP,
		AA.ID_UP,
		AA.JML_PEMBAYARAN,
		AA.JML_PENGELUARAN,
		AA.JML_POTONGAN,
		AA.JUMLAH_SSPB,
		AA.JUMLAH_TUP,
		AA.KD_CARA_BAYAR,
		AA.KD_CARA_PENARIKAN,
		AA.KD_JATUH_TEMPO,
		AA.KD_JNS_BAYAR,
		AA.KD_JNS_SPP,
		ff.deskripsi					ur_jns_spp,
		AA.KD_KPPN,
		TRIM(EE.NMKPPN)					NAMA_KPPN,
		substr(bb.kode_unit,1,3)		kode_ba_satker,
		trim(cc.deskripsi)				nama_ba_satker,
		substr(bb.kode_unit,-2)			kode_eselon1_satker,
		trim(dd.deskripsi)				nama_eselon1_satker,
		AA.KD_SATKER,
		trim(bb.deskripsi)				nama_satker,
		AA.KD_SIFAT_BAYAR,
		AA.KD_VALAS,
		AA.KOMPEN_POT_SPMKP,
		AA.KOMPEN_TRANSFER,
		AA.KOMPENSASI_UM,
		AA.KURS_NOD,
		AA.NILAI_APLIKASI,
		AA.NILAI_BAST,
		AA.NILAI_KEMBALI,
		AA.NILAI_POTONGAN,
		AA.NILAI_REG_INV,
		AA.NILAI_RUPIAH,
		AA.NILAI_SP2B,
		AA.NILAI_SP2D,
		AA.NILAI_SPM,
		AA.NILAI_TUKAR,
		AA.NILAI_UP,
		AA.NO_APLIKASI,
		AA.NO_DIPA,
		AA.NO_DIPA_SSPB,
		AA.NO_GAJI,
		AA.NO_NOD,
		AA.NO_PENGESAHAN,
		AA.NO_PENGESHANAN_SSPB,
		AA.NO_REG_INV,
		AA.NO_REGISTER,
		SS.NAMA_LOAN_GRANT				NAMA_PINJAMAN_HIBAH,
		SS.LENDER_NAME					NAMA_DONOR,
		AA.NO_SSPB,
		AA.NO_SP2B,
		AA.NO_SP2D,
		AA.NO_SP3HL_BJS,
		AA.NO_SPM,
		AA.NO_SPP,
		AA.NO_SPP2,
		AA.NO_TUP,
		AA.NO_UP,
		AA.NO_WA,
		AA.NOMOR_BAST,
		AA.NOP,
		AA.PAYMENT_TERMS,
		AA.PEMOTONGAN_RETENSI,
		AA.PENDAPATAN,
		AA.PERIODE_TRIWULAN,
		AA.PORSI_DISETOR,
		AA.PORSI_TIDAK_DISETOR,
		AA.SALDO_AKHIR,
		AA.SALDO_AKHIR_HIBAH,
		AA.SALDO_AWAL,
		AA.SB_DATA,
		AA.SISA_HIBAH,
		AA.STS_DATA,
		case	when aa.sts_data = 'SPM_STS_DATA_01' then 'Baru'
				when aa.sts_data = 'SPM_STS_DATA_02' then 'Cetak SPP'
				when aa.sts_data = 'SPM_STS_DATA_03' then 'Batal SPP'
				when aa.sts_data = 'SPM_STS_DATA_04' then 'Setuju SPP'
				when aa.sts_data = 'SPM_STS_DATA_05' then 'ADK SPP'
				when aa.sts_data = 'SPM_STS_DATA_06' then 'Batal ADK SPP'
				when aa.sts_data = 'SPM_STS_DATA_07' then 'Upload NTT'
				when aa.sts_data = 'SPM_STS_DATA_08' then 'Cetak SPM'
				when aa.sts_data = 'SPM_STS_DATA_09' then 'Batal SPM'
				when aa.sts_data = 'SPM_STS_DATA_10' then 'Setuju SPM'
				when aa.sts_data = 'SPM_STS_DATA_11' then 'ADK SPM'
				when aa.sts_data = 'SPM_STS_DATA_12' then 'Batal ADK SPM'
				when aa.sts_data = 'SPM_STS_DATA_13' then 'Upload SP2D'
				when aa.sts_data = 'SPM_STS_DATA_14' then 'Permohonan Pembatalan ADK SPM'
				when aa.sts_data = 'SPM_STS_DATA_15' then 'Void SP2D'
			end as ur_sts_data,
		AA.TGL_ADK_SPM,
		AA.TGL_ADK_SPP,
		AA.TGL_APLIKASI,
		AA.TGL_BUKU,
		AA.TGL_DIPA,
		AA.TGL_KURS,
		AA.TGL_KURS_NOD,
		AA.TGL_NOD,
		AA.TGL_PENGESAHAN,
		AA.TGL_PENGESAHAN_SSPB,
		AA.TGL_REG_INV,
		AA.TGL_REGISTER,
		AA.TGL_SSPB,
		AA.TGL_SP2B,
		AA.TGL_SP2D,
		AA.TGL_SP3HL_BJS,
		AA.TGL_SPM,
		AA.TGL_SPP,
		AA.TGL_TUP,
		AA.TGL_UP,
		AA.TGL_WA,
		AA.THN_ANG,
		AA.THN_PAJAK,
		AA.TIPE_INVOICE,
		AA.TIPE_KURS,
		AA.URAIAN,
		AA.URAIAN_PEMBAYARAN,
		AA.NILAI_KONTRAK_PDN,
		AA.NILAI_KONTRAK_PDP,
		AA.NILAI_KONTRAK_PLN,
		AA.PEMBAYARAN_PENDAMPING,
		AA.PORSI_SETOR_SAAT_INI,
		AA.PORSI_TDK_SETOR_SAAT_INI,
		AA.NO_KONTRAK,
		AA.STATUS_APD,
		case	when aa.STATUS_APD = '1' then 'UM'
				when aa.STATUS_APD = '2' then 'KONTRAK'
				when aa.STATUS_APD = '3' then 'RETENSI'
			end as ur_STATUS_APD,
		AA.JNS_SPP_KOREKSI,
		AA.NO_SPP_KOREKSI,
		AA.TGL_SPP_KOREKSI,
		AA.NILAI_KONTRAK_APD,
		AA.ID_SPTB,
		AA.ID_SPP_YG_DIKOREKSI,
		AA.KOREKSI_FLAG,
		case	when KOREKSI_FLAG = '1' then 'SPP Sudah Dikoreksi'
			end as ur_KOREKSI_FLAG,
		AA.ID_JADWAL_RETENSI,
		AA.ID_KONTRAK_RETENSI,
		AA.TGL_SPM_KOREKSI,
		AA.NILAI_TUKAR_SP2D,
		AA.TEMPAT_CETAK_SPM,
		AA.TEMPAT_CETAK_SPP,
		AA.TGL_CETAK_SPM,
		AA.TGL_CETAK_SPP,
		AA.REQ_ID_SPM,
		AA.REQ_ID_SPP
FROM	SAKTIKSL.BPK_SPM_T_SPP_220930_221023	AA
left join	SAKTIKSL.BPK_ADM_R_SATKER_220731 bb
	ON	aa.KD_SATKER = bb.KODE
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
LEFT JOIN	EREKON.T_KPPN_220525	EE
	ON	AA.KD_KPPN = EE.KDKPPN
left join	saktiksl.REF_KODE_JENIS_SPP_2022	ff
	ON	aa.KD_JNS_SPP = ff.kode
LEFT JOIN	SPAN.SPPM_REGISTER_LENDER_220825	SS
		ON	AA.NO_REGISTER = SS.REGISTER_NO;
create index saktiksl.mv_SPMtspp_221023_BA on saktiksl.mv_SPM_T_SPP_220930_221023 (kode_ba_satker);
create index saktiksl.mv_SPMtspp_221023_BAES1 on saktiksl.mv_SPM_T_SPP_220930_221023 (kode_ba_satker||kode_eselon1_satker);