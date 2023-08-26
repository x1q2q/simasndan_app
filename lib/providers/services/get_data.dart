import 'package:dio/dio.dart';
import 'dart:convert';
import '../models/materi.dart';
import '../models/santri.dart';
import '../models/berita.dart';
import '../../core/api.dart';
import 'dart:io';

class GetData {
  Dio dio = Dio();
  Future<Materi?> detailMateri(String? idMateri) async {
    String urlGet = '${Api.getMateri}/$idMateri';
    try {
      Response resp = await dio.get(urlGet);
      if (resp.statusCode == 200) {
        return Materi.fromMap(resp.data['data']);
      } else {
        return null;
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

  Future<Santri?> detailSantri(String? idSantri) async {
    String urlGet = '${Api.getSantri}/$idSantri';
    try {
      Response resp = await dio.get(urlGet);
      if (resp.statusCode == 200) {
        return Santri.fromMap(resp.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('error $e');
    }
  }

  Future<bool> updateProfil(Santri dtSantri, String id, File? filePhoto) async {
    bool res;
    Map<String, dynamic> data = {'image': null, ...dtSantri.toJson()};
    if (filePhoto != null) {
      data["image"] = await MultipartFile.fromFile(filePhoto.path,
          filename: filePhoto.path.split('/').last);
    }
    FormData formData = FormData.fromMap(data);
    try {
      Response resp = await dio.post('${Api.getSantri}/$id?_method=PUT',
          data: formData,
          options: Options(headers: {'Content-Type': 'multipart/form-data'}));
      res = true;
    } catch (e) {
      res = false;
      print(e.toString());
    }
    return res;
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
    Map<String, dynamic> res = {"success": bool, "data": Santri};
    try {
      Response resp = await dio.post(Api.login, data: json.encode(data));
      if (resp.statusCode == 200) {
        res["success"] = true;
        res["data"] = Santri.fromMap(resp.data['data']);
      } else {
        throw Exception('error server');
      }
    } catch (e) {
      res["success"] = false;
      res["data"] = null;
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
        return [];
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
        return [];
      }
    } catch (e) {
      throw Exception('error $e');
    }
  }

  Future<Berita?> detailBerita(String? idBerita) async {
    String urlGet = '${Api.getBerita}/$idBerita';
    try {
      Response resp = await dio.get(urlGet);
      if (resp.statusCode == 200) {
        return Berita.fromMap(resp.data['data']);
      } else {
        return null;
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
        return [];
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
        return [];
      }
    } catch (e) {
      throw Exception('error $e');
    }
  }

  Future<Santri?> checkUUID(String? uid) async {
    String urlGet = '${Api.checkUUID}/$uid';
    try {
      Response resp = await dio.get(urlGet);
      if (resp.statusCode == 200) {
        return Santri.fromMap(resp.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Santri?> updateUUID(
      String? idSantri, Map<String, dynamic> data) async {
    String urlPost = '${Api.updateUUID}/$idSantri';
    try {
      Response resp = await dio.post(urlPost, data: json.encode(data));
      if (resp.statusCode == 200) {
        return Santri.fromMap(resp.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('error $e');
    }
  }

  Future<List> allNotif(String? idSantri) async {
    String urlGet = '${Api.getNotif}/$idSantri';
    try {
      Response resp = await dio.get(urlGet);
      if (resp.statusCode == 200) {
        return resp.data['data'];
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('error $e');
    }
  }

  Future<List> headlinesBerita(double count) async {
    String urlGet = '${Api.getHeadlines}/${count.toString()}';
    try {
      Response resp = await dio.get(urlGet);
      if (resp.statusCode == 200) {
        return resp.data['data'];
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('error $e');
    }
  }
}
