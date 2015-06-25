local function get_solat(code)
  local xml = require 'xml'
  local parser = xml.Parser(xml.Parser.Fastest)
  local url = 'http://www2.e-solat.gov.my/xml/today/?zon='..URL.escape(code)
  local res, code = http.request(url)
  local parsed = parser:load(res)
 
  local main = xml.find(parsed, 'rss', 'channel')
  local bandar = xml.find(main, 'description')
  local text = ''
  local i = 0
  for k,v in pairs(main[1]) do
    i = i+1
    if i < 16 and i > 8 then
      local item = xml.find(main[1][i], 'item')
      text = text..item[1][1]..' : '..item[2][1]..'\n'
    end
  end
  return 'Waktu solat bagi kawasan: '..bandar[1]..'\n\n'..text
end
 
local function run(msg, matches)
  local solat = get_solat(matches[1])
  return solat
end
 
return {
   description = "Semak waktu solat. Data fetch from e-solat.gov.my",
   usage = "!solat [kod]\n\n-- MELAKA --\nBandar Melaka, Alor Gajah, Jasin, Masjid Tanah, Merlimau, Nyalas - MLK01\n\n-- SELANGOR --\nGombak,H.Selangor,Rawang, H.Langat,Sepang,Petaling, S.Alam - SGR01\nSabak Bernam, Kuala Selangor, Klang, Kuala Langat - SGR02\n\n-- KEDAH --\nKota Setar, Kubang Pasu, Pokok Sena - KDH01\nPendang, Kuala Muda, Yan - KDH02\nPadang Terap, Sik - KDH03\nBaling - KDH04\nKulim, Bandar Bahru - KDH05\nLangkawi - KDH06\nGunung Jerai - KDH07\n\n-- PULAU PINANG --\nSeluruh Negeri Pulau Pinang - PNG01\n\n-- PERAK --\nTapah,Slim River dan Tanjung Malim - PRK01\nIpoh, Batu Gajah, Kampar, Sg. Siput dan Kuala Kangsar - PRK02\nPengkalan Hulu, Grik dan Lenggong - PRK03\nTemengor dan Belum - PRK04\nTeluk Intan, Bagan Datoh, Kg.Gajah,Sri Iskandar, Beruas,Parit,Lumut,Setiawan dan Pulau Pangkor - PRK05\nSelama, Taiping, Bagan Serai dan Parit Buntar - PRK06\nBukit Larut - PRK07\n\n-- KUALA LUMPUR --\nKuala Lumpur -  SGR03\n\n-- PUTRAJAYA --\nPutrajaya - SGR04\n\n-- LABUAN --\nLabuan - WLY02\n\n-- NEGERI SEMBILAN --\nJempol, Tampin - NGS01\nPort Dickson, Seremban, Kuala Pilah, Jelebu, Rembau - NGS02\n\n-- JOHOR --\nPulau Aur dan Pemanggil - JHR01\nKota Tinggi, Mersing, Johor Bahru - JHR02\nKluang dan Pontian - JHR03\nBatu Pahat, Muar, Segamat, Gemas - JHR04\n\n-- PERLIS --\nKangar, Padang Besar, Arau     PLS01\n\n-- PAHANG --\nPulau Tioman - PHG01\nKuantan, Pekan, Rompin, Muadzam Shah - PHG02\nMaran, Chenor, Temerloh, Bera, Jerantut - PHG03\nBentong, Raub, Kuala Lipis - PHG04\nGenting Sempah, Janda Baik, Bukit Tinggi - PHG05\nBukit Fraser, Genting Higlands, Cameron Higlands - PHG06\n\n-- KELANTAN --\nK.Bharu,Bachok,Pasir Puteh,Tumpat,Pasir Mas,Tnh. Merah,Machang,Kuala Krai,Mukim Chiku - KTN01\nJeli, Gua Musang (Mukim Galas, Bertam) - KTN03\n\n-- TERENGGANU --\nKuala Terengganu, Marang - TRG01\nBesut, Setiu - TRG02\nHulu Terengganu - TRG03\nKemaman Dungun - TRG04\n\n-- SABAH --\nZon 1 - Sandakan, Bdr. Bkt. Garam, Semawang, Temanggong, Tambisan - SBH01\nZon 2 - Pinangah, Terusan, Beluran, Kuamut, Telupit - SBH02\nZon 3 - Lahad Datu, Kunak, Silabukan, Tungku, Sahabat, Semporna - SBH03\nZon 4 - Tawau, Balong, Merotai, Kalabakan - SBH04\nZon 5 - Kudat, Kota Marudu, Pitas, Pulau Banggi  - SBH05\nZon 6 - Gunung Kinabalu - SBH06\nZon 7 - Papar, Ranau, Kota Belud, Tuaran, Penampang, Kota Kinabalu - SBH07\nZon 8 - Pensiangan, Keningau, Tambunan, Nabawan - SBH08\nZon 9 - Sipitang, Membakut, Beaufort, Kuala Penyu, Weston, Tenom, Long Pa Sia - SBH09\n\n-- SARAWAK --\nZon 1 - Limbang, Sundar, Terusan, Lawas - SWK01\nZon 2 - Niah, Belaga, Sibuti, Miri, Bekenu, Marudi - SWK02\nZon 3 - Song, Belingan, Sebauh, Bintulu, Tatau, Kapit - SWK03\nZon 4 - Igan, Kanowit, Sibu, Dalat, Oya - SWK04\nZon 5 - Belawai, Matu, Daro, Sarikei, Julau, Bitangor, Rajang - SWK05\nZon 6 - Kabong, Lingga, Sri Aman, Engkelili, Betong, Spaoh, Pusa, Saratok, Roban, Debak - SWK06\nZon 7 - Samarahan, Simunjan, Serian, Sebuyau, Meludam - SWK07\nZon 8 - Kuching, Bau, Lundu,Sematan - SWK08\nZon 9 - Zon Khas - SWK09\n\n",
   patterns = {
      "^!solat (.*)$"
   },
   run = run
}
