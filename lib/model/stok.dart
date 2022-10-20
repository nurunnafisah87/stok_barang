class Stok {
  int? id;
  String? name;
  String? warna;
  String? ukuran;
  String? harga;
  String? jumlah;

  Stok({this.id, this.name, this.warna, this.ukuran, this.harga, this.jumlah});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['warna'] = warna;
    map['ukuran'] = ukuran;
    map['harga'] = harga;
    map['jumlah'] = jumlah;

    return map;
  }

  Stok.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.warna = map['warna'];
    this.ukuran = map['ukuran'];
    this.harga = map['harga'];
    this.jumlah = map['jumlah'];
  }
}
