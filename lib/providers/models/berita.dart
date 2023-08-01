class Berita {
  String id;
  String judul;
  String kategori;
  String isi;
  String penulis;
  String tanggal;
  Map<String, dynamic>? media;

  Berita(
      {required this.id,
      required this.judul,
      required this.kategori,
      required this.isi,
      required this.penulis,
      required this.tanggal,
      required this.media});

  factory Berita.fromMap(Map<String, dynamic> map) {
    return Berita(
        id: map['id'].toString(),
        judul: map['judul'],
        kategori: map['kategori'],
        isi: map['isi'],
        penulis: map['penulis'],
        tanggal: map['tanggal'],
        media: map['media']);
  }

  Map toJson() {
    return {
      'id': id,
      'judul': judul,
      'kategori': kategori,
      'isi': isi,
      'penulis': penulis,
      'tanggal': tanggal,
      'media': media
    };
  }
}
