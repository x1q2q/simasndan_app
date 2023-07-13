class Santri {
  String id;
  String username;
  String namaSantri;
  String tingkatan;
  String tempatLahir;
  String tglLahir;
  String alamat;
  String? foto;
  bool isPengurus;
  String universitas;

  Santri({
    required this.id,
    required this.username,
    required this.namaSantri,
    required this.tingkatan,
    required this.tempatLahir,
    required this.tglLahir,
    required this.alamat,
    this.foto,
    required this.isPengurus,
    required this.universitas,
  });
  factory Santri.fromJson(Map<String, dynamic> json) {
    return Santri(
        id: json['id'].toString(),
        username: json['username'],
        namaSantri: json['nama_santri'],
        tingkatan: json['tingkatan'],
        tempatLahir: json['tempat_lahir'],
        tglLahir: json['tgl_lahir'],
        alamat: json['alamat'],
        foto: json['foto'],
        isPengurus: (json['is_pengurus'] == 1) ? true : false,
        universitas: json['universitas']);
  }
  Map toJson() {
    return {
      'id': id,
      'nama_santri': namaSantri,
      'tempat_lahir': tempatLahir,
      'tgl_lahir': tglLahir,
      'universitas': universitas,
      'alamat': alamat
    };
  }
}
