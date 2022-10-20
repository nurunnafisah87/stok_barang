import 'package:flutter/material.dart';
import 'form_stok_barang.dart';

import 'database/db.dart';
import 'model/stok.dart';

class ListStok extends StatefulWidget {
  const ListStok({Key? key}) : super(key: key);

  @override
  _ListStokState createState() => _ListStokState();
}

class _ListStokState extends State<ListStok> {
  List<Stok> listStok = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    //menjalankan fungsi getallstok saat pertama kali dimuat
    _getAllStok();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 19, 175, 136),
        title: Center(
          child: Text(
            "LIST STOK GALERY NAFEESAH",
            style: TextStyle(fontFamily: "Wrong Delivery", fontSize: 20),
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: listStok.length,
          itemBuilder: (context, index) {
            Stok stok = listStok[index];
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading: Icon(
                  Icons.input,
                  size: 50,
                ),
                title: Text('${stok.name}'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("warna: ${stok.warna}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("ukuran: ${stok.ukuran}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("harga: ${stok.harga}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Jumlah: ${stok.jumlah}"),
                    )
                  ],
                ),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      // button edit
                      IconButton(
                          onPressed: () {
                            _openFormEdit(stok);
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          )),
                      // button hapus
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          //membuat dialog konfirmasi hapus
                          AlertDialog hapus = AlertDialog(
                            title: Text("Peringatan!"),
                            content: Container(
                              height: 40,
                              child: Column(
                                children: [Text("Yakin ingin Menghapus Data")],
                              ),
                            ),
                            //terdapat 2 button.
                            //jika ya maka jalankan _deletestok() dan tutup dialog
                            //jika tidak maka tutup dialog
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    _deleteStok(stok, index);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ya")),
                              TextButton(
                                child: Text('Tidak'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                          showDialog(
                              context: context, builder: (context) => hapus);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
      //membuat button mengapung di bagian bawah kanan layar
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 19, 175, 136),
        child: Icon(Icons.add),
        onPressed: () {
          _openFormCreate();
        },
      ),
    );
  }

  //mengambil semua data stok
  Future<void> _getAllStok() async {
    //list menampung data dari database
    var list = await db.getAllStok();

    //ada perubahanan state
    setState(() {
      //hapus data pada liststok
      listStok.clear();

      //lakukan perulangan pada variabel list
      list!.forEach((stok) {
        //masukan data ke listStok
        listStok.add(Stok.fromMap(stok));
      });
    });
  }

  //menghapus data Stok
  Future<void> _deleteStok(Stok stok, int position) async {
    await db.deleteStok(stok.id!);
    setState(() {
      listStok.removeAt(position);
    });
  }

  // membuka halaman tambah Stok
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormStok()));
    if (result == 'save') {
      await _getAllStok();
    }
  }

  //membuka halaman edit Stok
  Future<void> _openFormEdit(Stok stok) async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormStok(stok: stok)));
    if (result == 'update') {
      await _getAllStok();
    }
  }
}
