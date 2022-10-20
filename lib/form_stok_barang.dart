// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_crud_uts_lagi/list_stok.dart';
import 'database/db.dart';
import 'model/stok.dart';

class FormStok extends StatefulWidget {
  final Stok? stok;

  FormStok({this.stok});

  @override
  _FormStokState createState() => _FormStokState();
}

class _FormStokState extends State<FormStok> {
  DbHelper db = DbHelper();

  TextEditingController? name;
  TextEditingController? lastName;
  TextEditingController? warna;
  TextEditingController? ukuran;
  TextEditingController? harga;
  TextEditingController? jumlah;
  String? size;
  List listsize = ["Ukuran", "XS", "S", "M", "L", "XL"];

  @override
  void initState() {
    name = TextEditingController(
        text: widget.stok == null ? '' : widget.stok!.name);

    warna = TextEditingController(
        text: widget.stok == null ? '' : widget.stok!.warna);

    ukuran = TextEditingController(
        text: widget.stok == null ? '' : widget.stok!.ukuran);

    harga = TextEditingController(
        text: widget.stok == null ? '' : widget.stok!.harga);

    jumlah = TextEditingController(
        text: widget.stok == null ? '' : widget.stok!.jumlah);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 19, 175, 136),
        title: Center(
          child: Text(
            'CATATAN GALERY NAFEESAH',
            style: TextStyle(
                fontFamily: "Wrong Delivery",
                fontSize: 20,
                color: Colors.white),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: name,
              decoration: InputDecoration(
                labelText: 'Nama Gamis',
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(8),
                // )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: warna,
              decoration: InputDecoration(
                labelText: 'Warna',
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: DropdownButton(
                hint: Text("Ukuran"),
                value: size,
                items: listsize
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    size = value as String;
                    ukuran!.text = size!;
                  });
                },
              )),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: harga,
              decoration: InputDecoration(
                labelText: 'Harga',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: jumlah,
              decoration: InputDecoration(
                labelText: 'Jumlah Stok',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 105, 100, 100)),
              child: (widget.stok == null)
                  ? Text(
                      'Tambah',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Edit',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () {
                upsertStok();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertStok() async {
    if (widget.stok != null) {
      //update
      await db.updateStok(Stok.fromMap({
        'id': widget.stok!.id,
        'name': name!.text,
        'warna': warna!.text,
        'ukuran': ukuran!.text,
        'harga': harga!.text,
        'jumlah': jumlah!.text
      }));
      Navigator.pop(context, 'update');
    } else {
      //insert
      await db.saveStok(Stok(
        name: name!.text,
        warna: warna!.text,
        ukuran: ukuran!.text,
        harga: harga!.text,
        jumlah: jumlah!.text,
      ));
      Navigator.pop(context, 'save');
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ListStok()));
    }
  }
}
