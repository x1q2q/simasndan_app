class Santri {
  String id;
  String username;
  String? email;
  String namaSantri;
  String tingkatan;
  String tempatLahir;
  String? tglLahir;
  String alamat;
  String? foto;
  bool isPengurus;
  String universitas;
  String? uuid;

  Santri(
      {required this.id,
      this.email,
      required this.username,
      required this.namaSantri,
      required this.tingkatan,
      required this.tempatLahir,
      this.tglLahir,
      required this.alamat,
      this.foto,
      required this.isPengurus,
      required this.universitas,
      this.uuid});
  factory Santri.fromMap(Map<String, dynamic> json) {
    return Santri(
        id: json['id'].toString(),
        email: json['email'],
        username: json['username'],
        namaSantri: json['nama_santri'],
        tingkatan: json['tingkatan'],
        tempatLahir: json['tempat_lahir'],
        tglLahir: json['tgl_lahir'],
        alamat: json['alamat'],
        foto: json['foto'],
        isPengurus: (json['is_pengurus'] == 1) ? true : false,
        universitas: json['universitas'],
        uuid: json['uuid']);
  }
  Map toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'nama_santri': namaSantri,
      'tempat_lahir': tempatLahir,
      'tgl_lahir': tglLahir,
      'universitas': universitas,
      'alamat': alamat
    };
  }
}
