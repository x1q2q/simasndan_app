class JadwalAdhan {
  String title;
  String waktu;

  JadwalAdhan(this.title, this.waktu);

  @override
  String toString() {
    return '{ ${this.title}, ${this.waktu} }';
  }
}
