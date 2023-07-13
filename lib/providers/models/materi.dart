class Materi {
  String id;
  String kode;
  String nama;
  String? foto;
  String? link;
  String deskripsi;

  Materi(
      {required this.id,
      required this.kode,
      required this.nama,
      required this.foto,
      required this.link,
      required this.deskripsi});

  factory Materi.fromMap(Map<String, dynamic> map) {
    return Materi(
        id: map['id'].toString(),
        kode: map['kode'],
        nama: map['nama'],
        foto: map['foto'],
        link: map['link'],
        deskripsi: map['deskripsi']);
  }
  Map toJson() {
    return {
      'id': id,
      'kode': kode,
      'foto': foto,
      'link': link,
      'deskripsi': deskripsi
    };
  }
}
