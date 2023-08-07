import 'package:dio/dio.dart';
import 'dart:convert';
import '../models/materi.dart';
import '../models/santri.dart';
import '../models/berita.dart';
import '../../core/api.dart';
import 'dart:io';

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
        return Santri.fromMap(resp.data['data']);
      } else {
        throw Exception('error server');
      }
    } catch (e) {
      throw Exception('error $e');
    }
  }

  Future<bool> updateProfil(
      Santri dtSantri, String id, File empFace, String empCode) async {
    bool res;
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(empFace.path, filename: empCode),
      ...dtSantri.toJson()
    });
    try {
      Response resp = await dio.post('${Api.getSantri}/$id?_method=PUT',
          data: formData,
          options: Options(headers: {'Content-Type': 'multipart/form-data'}));
      print(resp.toString());
      res = true;
    } catch (e) {
      res = false;
      print(e.toString());
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

  Future<List> allBerita() async {
    String urlGet = Api.getBerita;
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

  Future<List> filteredBerita(String filter) async {
    String urlGet = '${Api.getBeritaFilter}/$filter';
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

  Future<Berita> detailBerita(String? idBerita) async {
    String urlGet = '${Api.getBerita}/$idBerita';
    try {
      Response resp = await dio.get(urlGet);
      if (resp.statusCode == 200) {
        return Berita.fromMap(resp.data['data']);
      } else {
        throw Exception('error server');
      }
    } catch (e) {
      throw Exception('error $e');
    }
  }

  Future<List> allSemester(String? idSantri) async {
    String urlGet = '${Api.getSemester}/$idSantri';
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

  Future<List> allPenilaian(String? idSantri, String? idSemt) async {
    String urlGet = '${Api.getTimeline}/$idSantri/$idSemt';
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
}
