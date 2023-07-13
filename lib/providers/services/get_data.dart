import 'package:dio/dio.dart';
import 'dart:convert';
import '../models/materi.dart';
import '../models/santri.dart';
import '../../core/api.dart';

class GetData {
  Dio dio = Dio();
  Future<Materi> detailMateri(String? idMateri) async {
    String urlGet = '${Api.getMateri}/$idMateri';
    try {
      Response resp = await dio.get(urlGet);
      if (resp.statusCode == 200) {
        return Materi.fromMap(resp.data['data']);
      } else {
        throw Exception('error server');
      }
    } catch (e) {
      throw Exception('error $e');
    }
  }

  Future<List> allMateri() async {
    String urlGet = Api.getMateri;
    try {
      Response resp = await dio.get(urlGet);
      if (resp.statusCode == 200) {
        return resp.data['data'];
      } else {
        throw Exception('error server');
      }
    } catch (e) {
      throw Exception('error $e');
    }
  }

  Future<Santri> detailSantri(String? idSantri) async {
    String urlGet = '${Api.getSantri}/$idSantri';
    try {
      Response resp = await dio.get(urlGet);
      if (resp.statusCode == 200) {
        return Santri.fromJson(resp.data['data']);
      } else {
        throw Exception('error server');
      }
    } catch (e) {
      throw Exception('error $e');
    }
  }

  Future<bool> updateProfil(Santri dtSantri, String id) async {
    bool res;
    try {
      Response resp =
          await dio.put('${Api.getSantri}/$id', data: dtSantri.toJson());
      print(resp.toString());
      res = true;
    } catch (e) {
      res = false;
    }
    return res;
  }

  Future<bool> login(Map<String, dynamic> data) async {
    bool res;
    try {
      Response resp = await dio.post(Api.login, data: json.encode(data));
      res = true;
    } catch (e) {
      res = false;
    }
    return res;
  }
}
