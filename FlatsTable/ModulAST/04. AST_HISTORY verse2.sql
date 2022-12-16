drop materialized view saktiksl.MV_AST_T_HISTORY_220930_221023;
create materialized view saktiksl.MV_AST_T_HISTORY_220930_221023
as
select	*
from
(	select	AA.ID,
			AA.ID_ASAL,
			AA.JENIS_ASSET,
			CASE	when AA.JENIS_ASSET = '1' then 'Intrakomptabel'
					when AA.JENIS_ASSET = '2' then 'Ekstrakomptabel'
				end as ur_JENIS_ASSET,
			NVL(AA.KODE_BARANG,BB.KODE_BARANG)		KODE_BARANG,
			BB.NAMA_BARANG,
			AA.KODE_KONDISI,
			case	when aa.KODE_KONDISI = '1' then 'Baik'
					when aa.KODE_KONDISI = '2' then 'Rusak Ringan'
					when aa.KODE_KONDISI = '3' then 'Rusak Berat'
				end as ur_KODE_KONDISI,
			AA.KUANTITAS_ASSET,
			AA.KUANTITAS_PERUBAHAN,
			AA.MASA_MANFAAT,
			AA.METODE,
			AA.NILAI_ASSET,
			AA.NILAI_ASSET_NERACA,
			AA.NILAI_PERUBAHAN,
			AA.NILAI_PERUBAHAN_NERACA,
			AA.NILAI_SATUAN,
			AA.SISA_MANFAAT,
			AA.STATUS_ASSET,
			ee.uraian								ur_STATUS_ASSET,
			ee.KATEGORI								KATEGORI_STATUS_ASSET,
			AA.STATUS_ASSET_SBLM,
			ff.uraian								ur_STATUS_ASSET_SBLM,
			ff.KATEGORI								KATEGORI_STATUS_ASSET_SBLM,
			AA.STATUS_KOREKSI,
			case	when AA.STATUS_KOREKSI = '1' then 'Belum Dikoreksi'
					when AA.STATUS_KOREKSI = '2' then 'Telah Dikoreksi'
				end ur_STATUS_KOREKSI,
			AA.TOTAL_PRODUKSI,
			AA.ASSET_ID,
			AA.ASSET_TRX_ID,
			BB.NUP_X_KWL,
			BB.no_asset,
			BB.KODE_BA_SATKER,			
			BB.NAMA_BA_SATKER,
			BB.KODE_ESELON1_SATKER,
			BB.NAMA_ESELON1_SATKER,
			BB.kode_satker,
			BB.NAMA_SATKER,
			BB.KODE_SUBSATKER,
			CC.KETERANGAN							TRX_KETERANGAN,
			cc.KODE_JENIS_TRANSAKSI					TRX_KODE_JENIS_TRANSAKSI,
			dd.NAMA_TRANSAKSI,
			--Group TRN
			case	when aa.STATUS_ASSET = '72' then gg.KATEGORI
					WHEN cc.KODE_JENIS_TRANSAKSI = '301' AND aa.STATUS_ASSET IS NULL THEN FF.KATEGORI
					WHEN cc.KODE_JENIS_TRANSAKSI IN ('312', '313', '392') THEN FF.KATEGORI
					else ee.KATEGORI
				end as KATEGORI_ASET,
			--Akun Aset
			case	when aa.STATUS_ASSET = '72' AND gg.KATEGORI = 'LAINNYA' then
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN '166113'
								ELSE '166112'
							END
					when aa.STATUS_ASSET = '72' AND gg.KATEGORI = 'NORMAL' then BB.AKUN
					WHEN cc.KODE_JENIS_TRANSAKSI = '301' AND aa.STATUS_ASSET IS NULL AND FF.KATEGORI = 'LAINNYA' then
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN '166113'
								ELSE '166112'
							END
					WHEN cc.KODE_JENIS_TRANSAKSI = '301' AND aa.STATUS_ASSET IS NULL AND FF.KATEGORI = 'NORMAL' then BB.AKUN
					WHEN cc.KODE_JENIS_TRANSAKSI IN ('312', '313', '392') AND FF.KATEGORI = 'LAINNYA' then
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN '166113'
								ELSE '166112'
							END
					WHEN cc.KODE_JENIS_TRANSAKSI IN ('312', '313', '392') AND FF.KATEGORI = 'NORMAL' then BB.AKUN
					WHEN ee.KATEGORI = 'NORMAL' then BB.AKUN
					when ee.KATEGORI = 'LAINNYA' then 
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN '166113'
								ELSE '166112'
							END
					when ee.KATEGORI = 'MITRA' then '161111'
				END AS AKUN_ASET,
			--Nama Akun Aset
			case	when aa.STATUS_ASSET = '72' AND gg.KATEGORI = 'LAINNYA' then
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN 'Aset Tak Berwujud yang tidak digunakan dalam Operasional Pemerintahan'
								ELSE 'Aset Tetap yang tidak digunakan dalam Operasi Pemerintahan'
							END
					when aa.STATUS_ASSET = '72' AND gg.KATEGORI = 'NORMAL' then BB.NAMA_AKUN
					WHEN cc.KODE_JENIS_TRANSAKSI = '301' AND aa.STATUS_ASSET IS NULL AND FF.KATEGORI = 'LAINNYA' then
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN 'Aset Tak Berwujud yang tidak digunakan dalam Operasional Pemerintahan'
								ELSE 'Aset Tetap yang tidak digunakan dalam Operasi Pemerintahan'
							END
					WHEN cc.KODE_JENIS_TRANSAKSI = '301' AND aa.STATUS_ASSET IS NULL AND FF.KATEGORI = 'NORMAL' then BB.NAMA_AKUN
					WHEN cc.KODE_JENIS_TRANSAKSI IN ('312', '313', '392') AND FF.KATEGORI = 'LAINNYA' then
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN 'Aset Tak Berwujud yang tidak digunakan dalam Operasional Pemerintahan'
								ELSE 'Aset Tetap yang tidak digunakan dalam Operasi Pemerintahan'
							END
					WHEN cc.KODE_JENIS_TRANSAKSI IN ('312', '313', '392') AND FF.KATEGORI = 'NORMAL' then BB.NAMA_AKUN
					WHEN ee.KATEGORI = 'NORMAL' then BB.NAMA_AKUN
					when ee.KATEGORI = 'LAINNYA' then 
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN 'Aset Tak Berwujud yang tidak digunakan dalam Operasional Pemerintahan'
								ELSE 'Aset Tetap yang tidak digunakan dalam Operasi Pemerintahan'
							END
					when ee.KATEGORI = 'MITRA' then 'Kemitraan Dengan Pihak Ketiga'
				END AS NAMA_AKUN_ASET,
			--Akun Penyusutan
			case	when aa.STATUS_ASSET = '72' AND gg.KATEGORI = 'LAINNYA' then
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN '169318'
								ELSE '169122'
							END
					when aa.STATUS_ASSET = '72' AND gg.KATEGORI = 'NORMAL' then
						case	WHEN SUBSTR(BB.AKUN,1,4) = '1321' THEN '137111'
								WHEN SUBSTR(BB.AKUN,1,4) = '1331' THEN '137211'
								WHEN SUBSTR(BB.AKUN,1,4) = '1351' THEN '137411'
								WHEN BB.AKUN = '134111' THEN '137311'
								WHEN BB.AKUN = '134112' THEN '137312'
								WHEN BB.AKUN = '134113' THEN '137313'
								WHEN BB.AKUN = '162111' THEN '169311'
								WHEN BB.AKUN = '162121' THEN '169312'
								WHEN BB.AKUN = '162131' THEN '169313'
								WHEN BB.AKUN = '162141' THEN '169314'
								WHEN BB.AKUN = '162151' THEN '169315'
								WHEN BB.AKUN = '162161' THEN '169316'
								WHEN BB.AKUN = '162191' THEN '169317'
							end
					WHEN cc.KODE_JENIS_TRANSAKSI = '301' AND aa.STATUS_ASSET IS NULL AND FF.KATEGORI = 'LAINNYA' then
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN '169318'
								ELSE '169122'
							END
					WHEN cc.KODE_JENIS_TRANSAKSI = '301' AND aa.STATUS_ASSET IS NULL AND FF.KATEGORI = 'NORMAL' then
						case	WHEN SUBSTR(BB.AKUN,1,4) = '1321' THEN '137111'
								WHEN SUBSTR(BB.AKUN,1,4) = '1331' THEN '137211'
								WHEN SUBSTR(BB.AKUN,1,4) = '1351' THEN '137411'
								WHEN BB.AKUN = '134111' THEN '137311'
								WHEN BB.AKUN = '134112' THEN '137312'
								WHEN BB.AKUN = '134113' THEN '137313'
								WHEN BB.AKUN = '162111' THEN '169311'
								WHEN BB.AKUN = '162121' THEN '169312'
								WHEN BB.AKUN = '162131' THEN '169313'
								WHEN BB.AKUN = '162141' THEN '169314'
								WHEN BB.AKUN = '162151' THEN '169315'
								WHEN BB.AKUN = '162161' THEN '169316'
								WHEN BB.AKUN = '162191' THEN '169317'
							end
					WHEN cc.KODE_JENIS_TRANSAKSI IN ('312', '313', '392') AND FF.KATEGORI = 'LAINNYA' then
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN '169318'
								ELSE '169122'
							END
					WHEN cc.KODE_JENIS_TRANSAKSI IN ('312', '313', '392') AND FF.KATEGORI = 'NORMAL' then
						case	WHEN SUBSTR(BB.AKUN,1,4) = '1321' THEN '137111'
								WHEN SUBSTR(BB.AKUN,1,4) = '1331' THEN '137211'
								WHEN SUBSTR(BB.AKUN,1,4) = '1351' THEN '137411'
								WHEN BB.AKUN = '134111' THEN '137311'
								WHEN BB.AKUN = '134112' THEN '137312'
								WHEN BB.AKUN = '134113' THEN '137313'
								WHEN BB.AKUN = '162111' THEN '169311'
								WHEN BB.AKUN = '162121' THEN '169312'
								WHEN BB.AKUN = '162131' THEN '169313'
								WHEN BB.AKUN = '162141' THEN '169314'
								WHEN BB.AKUN = '162151' THEN '169315'
								WHEN BB.AKUN = '162161' THEN '169316'
								WHEN BB.AKUN = '162191' THEN '169317'
							end
					WHEN ee.KATEGORI = 'NORMAL' then
						case	WHEN SUBSTR(BB.AKUN,1,4) = '1321' THEN '137111'
								WHEN SUBSTR(BB.AKUN,1,4) = '1331' THEN '137211'
								WHEN SUBSTR(BB.AKUN,1,4) = '1351' THEN '137411'
								WHEN BB.AKUN = '134111' THEN '137311'
								WHEN BB.AKUN = '134112' THEN '137312'
								WHEN BB.AKUN = '134113' THEN '137313'
								WHEN BB.AKUN = '162111' THEN '169311'
								WHEN BB.AKUN = '162121' THEN '169312'
								WHEN BB.AKUN = '162131' THEN '169313'
								WHEN BB.AKUN = '162141' THEN '169314'
								WHEN BB.AKUN = '162151' THEN '169315'
								WHEN BB.AKUN = '162161' THEN '169316'
								WHEN BB.AKUN = '162191' THEN '169317'
							end
					when ee.KATEGORI = 'LAINNYA' then 
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN '169318'
								ELSE '169122'
							END
					when ee.KATEGORI = 'MITRA' then '169111'
				END AS AKUN_SUSUT,
			--Nama Akun Penyusutan
			case	when aa.STATUS_ASSET = '72' AND gg.KATEGORI = 'LAINNYA' then
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN 'Akumulasi Amortisasi  Aset Tak Berwujud  yang tidak digunakan dalam Operasional Pemerintahan '
								ELSE 'Akumulasi Penyusutan Aset Tetap yang Tidak Digunakan dalam Operasi Pemerintahan'
							END
					when aa.STATUS_ASSET = '72' AND gg.KATEGORI = 'NORMAL' then
						case	WHEN SUBSTR(BB.AKUN,1,4) = '1321' THEN 'Akumulasi Penyusutan Peralatan dan Mesin'
								WHEN SUBSTR(BB.AKUN,1,4) = '1331' THEN 'Akumulasi Penyusutan Gedung dan Bangunan'
								WHEN SUBSTR(BB.AKUN,1,4) = '1351' THEN 'Akumulasi Penyusutan Aset Tetap Lainnya'
								WHEN BB.AKUN = '134111' THEN 'Akumulasi Penyusutan Jalan dan Jembatan'
								WHEN BB.AKUN = '134112' THEN 'Akumulasi Penyusutan Irigasi'
								WHEN BB.AKUN = '134113' THEN 'Akumulasi Penyusutan Jaringan'
								WHEN BB.AKUN = '162111' THEN 'Akumulasi Amortisasi Aset Tak Berwujud'
								WHEN BB.AKUN = '162121' THEN 'Akumulasi Amortisasi Hak Cipta'
								WHEN BB.AKUN = '162131' THEN 'Akumulasi Amortisasi Royalti'
								WHEN BB.AKUN = '162141' THEN 'Akumulasi Amortisasi Paten'
								WHEN BB.AKUN = '162151' THEN 'Akumulasi Amortisasi Software'
								WHEN BB.AKUN = '162161' THEN 'Akumulasi Amortisasi Lisensi'
								WHEN BB.AKUN = '162191' THEN 'Akumulasi Amortisasi Aset Tak Berwujud Lainnya'
							end
					WHEN cc.KODE_JENIS_TRANSAKSI = '301' AND aa.STATUS_ASSET IS NULL AND FF.KATEGORI = 'LAINNYA' then
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN 'Akumulasi Amortisasi  Aset Tak Berwujud  yang tidak digunakan dalam Operasional Pemerintahan '
								ELSE 'Akumulasi Penyusutan Aset Tetap yang Tidak Digunakan dalam Operasi Pemerintahan'
							END
					WHEN cc.KODE_JENIS_TRANSAKSI = '301' AND aa.STATUS_ASSET IS NULL AND FF.KATEGORI = 'NORMAL' then
						case	WHEN SUBSTR(BB.AKUN,1,4) = '1321' THEN 'Akumulasi Penyusutan Peralatan dan Mesin'
								WHEN SUBSTR(BB.AKUN,1,4) = '1331' THEN 'Akumulasi Penyusutan Gedung dan Bangunan'
								WHEN SUBSTR(BB.AKUN,1,4) = '1351' THEN 'Akumulasi Penyusutan Aset Tetap Lainnya'
								WHEN BB.AKUN = '134111' THEN 'Akumulasi Penyusutan Jalan dan Jembatan'
								WHEN BB.AKUN = '134112' THEN 'Akumulasi Penyusutan Irigasi'
								WHEN BB.AKUN = '134113' THEN 'Akumulasi Penyusutan Jaringan'
								WHEN BB.AKUN = '162111' THEN 'Akumulasi Amortisasi Aset Tak Berwujud'
								WHEN BB.AKUN = '162121' THEN 'Akumulasi Amortisasi Hak Cipta'
								WHEN BB.AKUN = '162131' THEN 'Akumulasi Amortisasi Royalti'
								WHEN BB.AKUN = '162141' THEN 'Akumulasi Amortisasi Paten'
								WHEN BB.AKUN = '162151' THEN 'Akumulasi Amortisasi Software'
								WHEN BB.AKUN = '162161' THEN 'Akumulasi Amortisasi Lisensi'
								WHEN BB.AKUN = '162191' THEN 'Akumulasi Amortisasi Aset Tak Berwujud Lainnya'
							end
					WHEN cc.KODE_JENIS_TRANSAKSI IN ('312', '313', '392') AND FF.KATEGORI = 'LAINNYA' then
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN 'Akumulasi Amortisasi  Aset Tak Berwujud  yang tidak digunakan dalam Operasional Pemerintahan '
								ELSE 'Akumulasi Penyusutan Aset Tetap yang Tidak Digunakan dalam Operasi Pemerintahan'
							END
					WHEN cc.KODE_JENIS_TRANSAKSI IN ('312', '313', '392') AND FF.KATEGORI = 'NORMAL' then
						case	WHEN SUBSTR(BB.AKUN,1,4) = '1321' THEN 'Akumulasi Penyusutan Peralatan dan Mesin'
								WHEN SUBSTR(BB.AKUN,1,4) = '1331' THEN 'Akumulasi Penyusutan Gedung dan Bangunan'
								WHEN SUBSTR(BB.AKUN,1,4) = '1351' THEN 'Akumulasi Penyusutan Aset Tetap Lainnya'
								WHEN BB.AKUN = '134111' THEN 'Akumulasi Penyusutan Jalan dan Jembatan'
								WHEN BB.AKUN = '134112' THEN 'Akumulasi Penyusutan Irigasi'
								WHEN BB.AKUN = '134113' THEN 'Akumulasi Penyusutan Jaringan'
								WHEN BB.AKUN = '162111' THEN 'Akumulasi Amortisasi Aset Tak Berwujud'
								WHEN BB.AKUN = '162121' THEN 'Akumulasi Amortisasi Hak Cipta'
								WHEN BB.AKUN = '162131' THEN 'Akumulasi Amortisasi Royalti'
								WHEN BB.AKUN = '162141' THEN 'Akumulasi Amortisasi Paten'
								WHEN BB.AKUN = '162151' THEN 'Akumulasi Amortisasi Software'
								WHEN BB.AKUN = '162161' THEN 'Akumulasi Amortisasi Lisensi'
								WHEN BB.AKUN = '162191' THEN 'Akumulasi Amortisasi Aset Tak Berwujud Lainnya'
							end
					WHEN ee.KATEGORI = 'NORMAL' then
						case	WHEN SUBSTR(BB.AKUN,1,4) = '1321' THEN 'Akumulasi Penyusutan Peralatan dan Mesin'
								WHEN SUBSTR(BB.AKUN,1,4) = '1331' THEN 'Akumulasi Penyusutan Gedung dan Bangunan'
								WHEN SUBSTR(BB.AKUN,1,4) = '1351' THEN 'Akumulasi Penyusutan Aset Tetap Lainnya'
								WHEN BB.AKUN = '134111' THEN 'Akumulasi Penyusutan Jalan dan Jembatan'
								WHEN BB.AKUN = '134112' THEN 'Akumulasi Penyusutan Irigasi'
								WHEN BB.AKUN = '134113' THEN 'Akumulasi Penyusutan Jaringan'
								WHEN BB.AKUN = '162111' THEN 'Akumulasi Amortisasi Aset Tak Berwujud'
								WHEN BB.AKUN = '162121' THEN 'Akumulasi Amortisasi Hak Cipta'
								WHEN BB.AKUN = '162131' THEN 'Akumulasi Amortisasi Royalti'
								WHEN BB.AKUN = '162141' THEN 'Akumulasi Amortisasi Paten'
								WHEN BB.AKUN = '162151' THEN 'Akumulasi Amortisasi Software'
								WHEN BB.AKUN = '162161' THEN 'Akumulasi Amortisasi Lisensi'
								WHEN BB.AKUN = '162191' THEN 'Akumulasi Amortisasi Aset Tak Berwujud Lainnya'
							end
					when ee.KATEGORI = 'LAINNYA' then 
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN 'Akumulasi Amortisasi  Aset Tak Berwujud  yang tidak digunakan dalam Operasional Pemerintahan '
								ELSE 'Akumulasi Penyusutan Aset Tetap yang Tidak Digunakan dalam Operasi Pemerintahan'
							END
					when ee.KATEGORI = 'MITRA' then 'Akumulasi Penyusutan Kemitraan dengan Pihak ketiga'
				END AS NAMA_AKUN_SUSUT,
			--Akun Beban
			case	when aa.STATUS_ASSET = '72' AND gg.KATEGORI = 'LAINNYA' then
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN '592126'
								ELSE '592222'
							END
					when aa.STATUS_ASSET = '72' AND gg.KATEGORI = 'NORMAL' then
						case	WHEN SUBSTR(BB.AKUN,1,4) = '1321' THEN '591111'
								WHEN SUBSTR(BB.AKUN,1,4) = '1331' THEN '591211'
								WHEN SUBSTR(BB.AKUN,1,4) = '1351' THEN '591411'
								WHEN BB.AKUN = '134111' THEN '591311'
								WHEN BB.AKUN = '134112' THEN '591312'
								WHEN BB.AKUN = '134113' THEN '591313'
								WHEN BB.AKUN = '162111' THEN '592111'
								WHEN BB.AKUN = '162121' THEN '592112'
								WHEN BB.AKUN = '162131' THEN '592113'
								WHEN BB.AKUN = '162141' THEN '592114'
								WHEN BB.AKUN = '162151' THEN '592115'
								WHEN BB.AKUN = '162161' THEN '592116'
								WHEN BB.AKUN = '162191' THEN '592117'
							end
					WHEN cc.KODE_JENIS_TRANSAKSI = '301' AND aa.STATUS_ASSET IS NULL AND FF.KATEGORI = 'LAINNYA' then
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN '592126'
								ELSE '592222'
							END
					WHEN cc.KODE_JENIS_TRANSAKSI = '301' AND aa.STATUS_ASSET IS NULL AND FF.KATEGORI = 'NORMAL' then
						case	WHEN SUBSTR(BB.AKUN,1,4) = '1321' THEN '591111'
								WHEN SUBSTR(BB.AKUN,1,4) = '1331' THEN '591211'
								WHEN SUBSTR(BB.AKUN,1,4) = '1351' THEN '591411'
								WHEN BB.AKUN = '134111' THEN '591311'
								WHEN BB.AKUN = '134112' THEN '591312'
								WHEN BB.AKUN = '134113' THEN '591313'
								WHEN BB.AKUN = '162111' THEN '592111'
								WHEN BB.AKUN = '162121' THEN '592112'
								WHEN BB.AKUN = '162131' THEN '592113'
								WHEN BB.AKUN = '162141' THEN '592114'
								WHEN BB.AKUN = '162151' THEN '592115'
								WHEN BB.AKUN = '162161' THEN '592116'
								WHEN BB.AKUN = '162191' THEN '592117'
							end
					WHEN cc.KODE_JENIS_TRANSAKSI IN ('312', '313', '392') AND FF.KATEGORI = 'LAINNYA' then
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN '592126'
								ELSE '592222'
							END
					WHEN cc.KODE_JENIS_TRANSAKSI IN ('312', '313', '392') AND FF.KATEGORI = 'NORMAL' then
						case	WHEN SUBSTR(BB.AKUN,1,4) = '1321' THEN '591111'
								WHEN SUBSTR(BB.AKUN,1,4) = '1331' THEN '591211'
								WHEN SUBSTR(BB.AKUN,1,4) = '1351' THEN '591411'
								WHEN BB.AKUN = '134111' THEN '591311'
								WHEN BB.AKUN = '134112' THEN '591312'
								WHEN BB.AKUN = '134113' THEN '591313'
								WHEN BB.AKUN = '162111' THEN '592111'
								WHEN BB.AKUN = '162121' THEN '592112'
								WHEN BB.AKUN = '162131' THEN '592113'
								WHEN BB.AKUN = '162141' THEN '592114'
								WHEN BB.AKUN = '162151' THEN '592115'
								WHEN BB.AKUN = '162161' THEN '592116'
								WHEN BB.AKUN = '162191' THEN '592117'
							end
					WHEN ee.KATEGORI = 'NORMAL' then
						case	WHEN SUBSTR(BB.AKUN,1,4) = '1321' THEN '591111'
								WHEN SUBSTR(BB.AKUN,1,4) = '1331' THEN '591211'
								WHEN SUBSTR(BB.AKUN,1,4) = '1351' THEN '591411'
								WHEN BB.AKUN = '134111' THEN '591311'
								WHEN BB.AKUN = '134112' THEN '591312'
								WHEN BB.AKUN = '134113' THEN '591313'
								WHEN BB.AKUN = '162111' THEN '592111'
								WHEN BB.AKUN = '162121' THEN '592112'
								WHEN BB.AKUN = '162131' THEN '592113'
								WHEN BB.AKUN = '162141' THEN '592114'
								WHEN BB.AKUN = '162151' THEN '592115'
								WHEN BB.AKUN = '162161' THEN '592116'
								WHEN BB.AKUN = '162191' THEN '592117'
							end
					when ee.KATEGORI = 'LAINNYA' then 
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN '592126'
								ELSE '592222'
							END
					when ee.KATEGORI = 'MITRA' then '592211'
				END AS AKUN_BEBAN,
			--Nama Akun Beban
			case	when aa.STATUS_ASSET = '72' AND gg.KATEGORI = 'LAINNYA' then
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN 'Beban Amortisasi Aset Tak Berwujud yang tidak digunakan dalam Operasional Pemerintahan '
								ELSE 'Beban Penyusutan Aset Tetap yang Tidak Digunakan dalam Operasi Pemerintahan'
							END
					when aa.STATUS_ASSET = '72' AND gg.KATEGORI = 'NORMAL' then
						case	WHEN SUBSTR(BB.AKUN,1,4) = '1321' THEN 'Beban Penyusutan Peralatan dan Mesin'
								WHEN SUBSTR(BB.AKUN,1,4) = '1331' THEN 'Beban Penyusutan Gedung dan Bangunan'
								WHEN SUBSTR(BB.AKUN,1,4) = '1351' THEN 'Beban Penyusutan Aset Tetap Lainnya'
								WHEN BB.AKUN = '134111' THEN 'Beban Penyusutan Jalan dan Jembatan'
								WHEN BB.AKUN = '134112' THEN 'Beban Penyusutan Irigasi'
								WHEN BB.AKUN = '134113' THEN 'Beban Penyusutan Jaringan'
								WHEN BB.AKUN = '162111' THEN 'Beban Amortisasi Goodwill'
								WHEN BB.AKUN = '162121' THEN 'Beban Amortisasi Hak Cipta'
								WHEN BB.AKUN = '162131' THEN 'Beban Amortisasi Royalti'
								WHEN BB.AKUN = '162141' THEN 'Beban Amortisasi Paten'
								WHEN BB.AKUN = '162151' THEN 'Beban Amortisasi Software'
								WHEN BB.AKUN = '162161' THEN 'Beban Amortisasi Lisensi'
								WHEN BB.AKUN = '162191' THEN 'Beban Amortisasi Aset Tak Berwujud Lainnya'
							end
					WHEN cc.KODE_JENIS_TRANSAKSI = '301' AND aa.STATUS_ASSET IS NULL AND FF.KATEGORI = 'LAINNYA' then
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN 'Beban Amortisasi Aset Tak Berwujud yang tidak digunakan dalam Operasional Pemerintahan '
								ELSE 'Beban Penyusutan Aset Tetap yang Tidak Digunakan dalam Operasi Pemerintahan'
							END
					WHEN cc.KODE_JENIS_TRANSAKSI = '301' AND aa.STATUS_ASSET IS NULL AND FF.KATEGORI = 'NORMAL' then
						case	WHEN SUBSTR(BB.AKUN,1,4) = '1321' THEN 'Beban Penyusutan Peralatan dan Mesin'
								WHEN SUBSTR(BB.AKUN,1,4) = '1331' THEN 'Beban Penyusutan Gedung dan Bangunan'
								WHEN SUBSTR(BB.AKUN,1,4) = '1351' THEN 'Beban Penyusutan Aset Tetap Lainnya'
								WHEN BB.AKUN = '134111' THEN 'Beban Penyusutan Jalan dan Jembatan'
								WHEN BB.AKUN = '134112' THEN 'Beban Penyusutan Irigasi'
								WHEN BB.AKUN = '134113' THEN 'Beban Penyusutan Jaringan'
								WHEN BB.AKUN = '162111' THEN 'Beban Amortisasi Goodwill'
								WHEN BB.AKUN = '162121' THEN 'Beban Amortisasi Hak Cipta'
								WHEN BB.AKUN = '162131' THEN 'Beban Amortisasi Royalti'
								WHEN BB.AKUN = '162141' THEN 'Beban Amortisasi Paten'
								WHEN BB.AKUN = '162151' THEN 'Beban Amortisasi Software'
								WHEN BB.AKUN = '162161' THEN 'Beban Amortisasi Lisensi'
								WHEN BB.AKUN = '162191' THEN 'Beban Amortisasi Aset Tak Berwujud Lainnya'
							end
					WHEN cc.KODE_JENIS_TRANSAKSI IN ('312', '313', '392') AND FF.KATEGORI = 'LAINNYA' then
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN 'Beban Amortisasi Aset Tak Berwujud yang tidak digunakan dalam Operasional Pemerintahan '
								ELSE 'Beban Penyusutan Aset Tetap yang Tidak Digunakan dalam Operasi Pemerintahan'
							END
					WHEN cc.KODE_JENIS_TRANSAKSI IN ('312', '313', '392') AND FF.KATEGORI = 'NORMAL' then
						case	WHEN SUBSTR(BB.AKUN,1,4) = '1321' THEN 'Beban Penyusutan Peralatan dan Mesin'
								WHEN SUBSTR(BB.AKUN,1,4) = '1331' THEN 'Beban Penyusutan Gedung dan Bangunan'
								WHEN SUBSTR(BB.AKUN,1,4) = '1351' THEN 'Beban Penyusutan Aset Tetap Lainnya'
								WHEN BB.AKUN = '134111' THEN 'Beban Penyusutan Jalan dan Jembatan'
								WHEN BB.AKUN = '134112' THEN 'Beban Penyusutan Irigasi'
								WHEN BB.AKUN = '134113' THEN 'Beban Penyusutan Jaringan'
								WHEN BB.AKUN = '162111' THEN 'Beban Amortisasi Goodwill'
								WHEN BB.AKUN = '162121' THEN 'Beban Amortisasi Hak Cipta'
								WHEN BB.AKUN = '162131' THEN 'Beban Amortisasi Royalti'
								WHEN BB.AKUN = '162141' THEN 'Beban Amortisasi Paten'
								WHEN BB.AKUN = '162151' THEN 'Beban Amortisasi Software'
								WHEN BB.AKUN = '162161' THEN 'Beban Amortisasi Lisensi'
								WHEN BB.AKUN = '162191' THEN 'Beban Amortisasi Aset Tak Berwujud Lainnya'
							end
					WHEN ee.KATEGORI = 'NORMAL' then
						case	WHEN SUBSTR(BB.AKUN,1,4) = '1321' THEN 'Beban Penyusutan Peralatan dan Mesin'
								WHEN SUBSTR(BB.AKUN,1,4) = '1331' THEN 'Beban Penyusutan Gedung dan Bangunan'
								WHEN SUBSTR(BB.AKUN,1,4) = '1351' THEN 'Beban Penyusutan Aset Tetap Lainnya'
								WHEN BB.AKUN = '134111' THEN 'Beban Penyusutan Jalan dan Jembatan'
								WHEN BB.AKUN = '134112' THEN 'Beban Penyusutan Irigasi'
								WHEN BB.AKUN = '134113' THEN 'Beban Penyusutan Jaringan'
								WHEN BB.AKUN = '162111' THEN 'Beban Amortisasi Goodwill'
								WHEN BB.AKUN = '162121' THEN 'Beban Amortisasi Hak Cipta'
								WHEN BB.AKUN = '162131' THEN 'Beban Amortisasi Royalti'
								WHEN BB.AKUN = '162141' THEN 'Beban Amortisasi Paten'
								WHEN BB.AKUN = '162151' THEN 'Beban Amortisasi Software'
								WHEN BB.AKUN = '162161' THEN 'Beban Amortisasi Lisensi'
								WHEN BB.AKUN = '162191' THEN 'Beban Amortisasi Aset Tak Berwujud Lainnya'
							end
					when ee.KATEGORI = 'LAINNYA' then 
						case	when SUBSTR(NVL(AA.KODE_BARANG,BB.KODE_BARANG),1,3) = '801' THEN 'Beban Amortisasi Aset Tak Berwujud yang tidak digunakan dalam Operasional Pemerintahan '
								ELSE 'Beban Penyusutan Aset Tetap yang Tidak Digunakan dalam Operasi Pemerintahan'
							END
					when ee.KATEGORI = 'MITRA' then 'Beban Penyusutan Kemitraan dengan Pihak ketiga'
				END AS NAMA_AKUN_BEBAN,
			bb.group_data,
			bb.ur_group_data,
			cc.TGL_DASAR_MUTASI				TRX_TGL_DASAR_MUTASI,
			cc.TGL_PEMBUKUAN				TRX_TGL_PEMBUKUAN,
			cc.id							TRX_ID,
			zz.id							TRX_ID2,
			cc.ID_BARANG_ASAL				TRX_ID_ASAL,
			cc.STATUS_PERSETUJUAN			TRX_STATUS_PERSETUJUAN,
			case	when CC.STATUS_PERSETUJUAN = '1' then 'Rekam'
					when CC.STATUS_PERSETUJUAN = '2' then 'Validasi'
					when CC.STATUS_PERSETUJUAN = '3' then 'Setuju'
				end as TRX_ur_STATUS_PERSETUJUAN,
			cc.STATUS_POSTING				trx_STATUS_POSTING,
			bb.TGL_PEROLEHAN				MST_TGL_PEROLEHAN,
			bb.TGL_AWAL_PEMAKAIAN			MST_TGL_AWAL_PEMAKAIAN,
			bb.STATUS_ASSET					mst_STATUS_ASSET,
			bb.ur_STATUS_ASSET				mst_ur_STATUS_ASSET,
			bb.STATUS_ASSET_SBLM			mst_STATUS_ASSET_SBLM,
			bb.ur_STATUS_ASSET_SBLM			mst_ur_STATUS_ASSET_SBLM,
			bb.KODE_UAKPB,
			cc.KODEUAPKPB					KODE_UAKPB_TKTM,
			SUBSTR(cc.KODEUAPKPB,1,3)		KODE_BA_TKTM,
			SUBSTR(cc.KODEUAPKPB,4,2)		KODE_ESELON1_TKTM,
			SUBSTR(cc.KODEUAPKPB,10,6)		KODE_SATKER_TKTM,
			SUBSTR(cc.KODEUAPKPB,16,3)		KODE_SUBSATKER_TKTM,
			CASE	WHEN cc.KODEUAPKPB IS NOT NULL THEN 
						SUBSTR(cc.KODEUAPKPB,1,5)||'.'||SUBSTR(cc.KODEUAPKPB,10,6)||'.'||SUBSTR(cc.KODEUAPKPB,16,3)
							||'.'||SUBSTR(cc.KODEUAPKPB,-2)||'.'||NVL(AA.KODE_BARANG,BB.KODE_BARANG)
				END AS kode_NUP_TKTM,
			BB.FLAG_DISUSUTKAN,
			BB.UR_FLAG_DISUSUTKAN,
			CC.TAHUN_ANGGARAN,
			CC.PERIODE,
			BB.HARGA_PEROLEHAN,
			BB.ASAL_PEROLEHAN,
			case	when JRN.ASSET_TRX_ID is not null then 'ADA'
				END AS JRN_STATUS,
			JRN.JRN_TGL_JURNAL
	FROM	SAKTIKSL.BPK_AST_T_HISTORY_220930_221023 AA
	LEFT JOIN	saktiksl.MV_AST_T_MASTER_220930_221023 BB
		ON	AA.ASSET_ID = BB.ID
	left join	saktiksl.MV_AST_T_TRX_220930_221023 cc
		ON	aa.ASSET_TRX_ID = cc.id
	left join	saktiksl.REF_ASET_TRANSAKSI_MONSAKTI_2022 dd
		on	cc.KODE_JENIS_TRANSAKSI = dd.JENIS_TRANSAKSI
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
		(	select	aa.*
			from	saktiksl.MV_AST_T_TRX_220930_221023 aa
			join
			(	select	id_barang_asal,
						count(*)
				from	saktiksl.MV_AST_T_TRX_220930_221023
				group by	id_barang_asal
				having	count(*) <= 1
			) bb
			on	aa.id_barang_asal = bb.id_barang_asal
--			where	aa.ID_BARANG_ASAL = '11465119'
		) zz
		ON	aa.ASSET_TRX_ID = zz.id_barang_asal
	left join
		(	select	*
			from	saktiksl.BPK_ADM_STATUS_ASET_220731
			where	NOTES not in ('ADK TKTM','ADK Likuidasi')
					or notes is null
		) GG
		on	to_char(bb.STATUS_ASSET_SBLM) = gg.status
	left join
		(	select	distinct ASSET_TRX_ID, 
					TGL_JURNAL 
			from	SAKTIKSL.MV_AST_T_JURNAL_220930_221023 
			where	ASSET_TRX_ID is not null 
		) jrn
		on	aa.ASSET_TRX_ID = jrn.ASSET_TRX_ID
)
--where	TRX_ID is not null
;
create index saktiksl.IDX_ASTHIST_221023_BA on saktiksl.MV_AST_T_HISTORY_220930_221023 (KODE_BA_SATKER);
create index saktiksl.IDX_ASTHIST_221023_BAES1 on saktiksl.MV_AST_T_HISTORY_220930_221023 (KODE_BA_SATKER||KODE_ESELON1_SATKER);
create index saktiksl.IDX_ASTHIST_221023_NUP on saktiksl.MV_AST_T_HISTORY_220930_221023 (NUP_X_KWL);
create index saktiksl.IDX_ASTHIST_221023_ID on saktiksl.MV_AST_T_HISTORY_220930_221023 (ID);
create index saktiksl.IDX_ASTHIST_221023_BRG1 on saktiksl.MV_AST_T_HISTORY_220930_221023 (SUBSTR(KODE_BARANG,1,1));
create index saktiksl.IDX_ASTHIST_221023_BRG3 on saktiksl.MV_AST_T_HISTORY_220930_221023 (SUBSTR(KODE_BARANG,1,3));
create index saktiksl.IDX_ASTHIST_221023_BRG5 on saktiksl.MV_AST_T_HISTORY_220930_221023 (SUBSTR(KODE_BARANG,1,5));
create index saktiksl.IDX_ASTHIST_221023_BRG on saktiksl.MV_AST_T_HISTORY_220930_221023 (KODE_BARANG);
create index saktiksl.IDX_ASTHIST_221023_JNS on saktiksl.MV_AST_T_HISTORY_220930_221023 (TRX_KODE_JENIS_TRANSAKSI); --(NVL(TRX_KODE_JENIS_TRANSAKSI,'000'));
create index saktiksl.IDX_ASTHIST_221023_SKR on saktiksl.MV_AST_T_HISTORY_220930_221023 (KODE_SATKER);
create index saktiksl.IDX_ASTHIST_221023_TRX1 ON saktiksl.MV_AST_T_HISTORY_220930_221023 (ASSET_TRX_ID);
create index saktiksl.IDX_ASTHIST_221023_TRX2 ON saktiksl.MV_AST_T_HISTORY_220930_221023 (TRX_ID); --(NVL(TRX_ID,00000000))
create index saktiksl.IDX_ASTHIST_221023_TRX3 ON saktiksl.MV_AST_T_HISTORY_220930_221023 (TRX_ID2); --(NVL(TRX_ID2,00000000))
create index saktiksl.IDX_ASTHIST_221023_AKUN1 on saktiksl.MV_AST_T_HISTORY_220930_221023 (AKUN_ASET);
create index saktiksl.IDX_ASTHIST_221023_AKUN2 on saktiksl.MV_AST_T_HISTORY_220930_221023 (AKUN_SUSUT);
create index saktiksl.IDX_ASTHIST_221023_AKUN3 on saktiksl.MV_AST_T_HISTORY_220930_221023 (AKUN_BEBAN);
create index saktiksl.IDX_ASTHIST_221023_GDAT on saktiksl.MV_AST_T_HISTORY_220930_221023 (group_data);
create index saktiksl.IDX_ASTHIST_221023_UAKPB on saktiksl.MV_AST_T_HISTORY_220930_221023 (KODE_UAKPB);
create index saktiksl.IDX_ASTHIST_221023_flas on saktiksl.MV_AST_T_HISTORY_220930_221023 (FLAG_DISUSUTKAN);
create index saktiksl.IDX_ASTHIST_221023_STTS on saktiksl.MV_AST_T_HISTORY_220930_221023 (STATUS_ASSET);
create index saktiksl.IDX_ASTHIST_221023_thn on saktiksl.MV_AST_T_HISTORY_220930_221023 (TAHUN_ANGGARAN);