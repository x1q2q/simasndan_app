class Api {
  static const String baseURL = "http://127.0.0.1:8000";
  // static const String baseURL = "http://192.168.43.76:8000";
  static String getMateri = "$baseURL/api/materi";
  static String getBerita = "$baseURL/api/berita";
  static String getBeritaFilter = "$baseURL/api/berita/filter";
  static String getSantri = "$baseURL/api/santri";
  static String getSemester = "$baseURL/api/semester";
  static String getTimeline = "$baseURL/api/penilaian";
  static String login = "$baseURL/api/login";
}
