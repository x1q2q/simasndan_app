class Api {
  // static const String baseURL = "http://127.0.0.1:8000";
  // static const String baseURL = "http://192.168.43.76:8000";
  static const String baseURL = "https://simasndan.crissad.com";
  static String getMateri = "$baseURL/api/materi";
  static String getBerita = "$baseURL/api/berita";
  static String getBeritaFilter = "$baseURL/api/berita/filter";
  static String getSantri = "$baseURL/api/santri";
  static String getSemester = "$baseURL/api/semester";
  static String getTimeline = "$baseURL/api/penilaian";
  static String checkUUID = "$baseURL/api/santri/checkuuid";
  static String updateUUID = "$baseURL/api/santri/updateuuid";
  static String getNotif = "$baseURL/api/santri/getnotif";
  static String getHeadlines = "$baseURL/api/berita/headlines";
  static String login = "$baseURL/api/santri/login";

  static const String adhanURL = "https://api.myquran.com/v1";
  static const String cariKota = "$adhanURL/sholat/kota/cari";
  static const String getJadwal = "$adhanURL/sholat/jadwal";
}
