import '../../core/api.dart';
import 'package:dio/dio.dart';
import '../models/jadwal_adhan.dart';
import 'package:intl/intl.dart';

class AdhanService {
  Dio dio = Dio();
  Future<String?> getIdKota(String? kota) async {
    String urlGet = '${Api.cariKota}/$kota';
    try {
      Response resp = await dio.get(urlGet);
      if (resp.statusCode == 200) {
        return resp.data["data"][0]["id"];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<JadwalAdhan>> getJadwal(Map<String, dynamic> args) async {
    List<JadwalAdhan> res = [];
    String urlGet =
        '${Api.getJadwal}/${args["idkota"]}/${args["tahun"]}/${args["bulan"]}/${args["tanggal"]}';
    try {
      Response resp = await dio.get(urlGet);
      if (resp.statusCode == 200) {
        Map<String, dynamic> respJadwal = resp.data["data"]["jadwal"];
        List adhanList = [
          "terbit",
          "subuh",
          "dzuhur",
          "ashar",
          "maghrib",
          "isya"
        ];
        res = respJadwal.entries
            .map((e) => JadwalAdhan(e.key, e.value))
            .where((element) => adhanList.contains(element.title))
            .toList();
      } else {}
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

  Future<String?> getAdhanTime(
      DateTime skrg, List? jadwal, Map<String, dynamic> args) async {
    String waktu = "${args['tahun']}-${args['bulan']}-${args['tanggal']}";
    String res = "";
    final dtTimes = jadwal
        ?.map((e) => DateFormat('y-M-d H:m:s').parse("${waktu} ${e.waktu}:00"))
        .toList();
    final DateTime closetsDateTimeToNow = dtTimes!.reduce(
        (a, b) => a.difference(skrg).abs() < b.difference(skrg).abs() ? a : b);

    jadwal?.forEach((el) {
      DateTime times =
          DateFormat('y-M-d H:m:s').parse("${waktu} ${el.waktu}:00");
      if (times == closetsDateTimeToNow) {
        res = "Waktu ${el.title} ${el.waktu}";
      }
    });

    return res;
  }
}
