// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, non_constant_identifier_names, avoid_types_as_parameter_names, avoid_function_literals_in_foreach_calls, unused_local_variable, unused_import, use_key_in_widget_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'database/db.dart';
import 'form_stok_barang.dart';
import 'list_stok.dart';
import 'model/stok.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 19, 175, 136),
        title: Center(
          child: Text(
            'GALERY NAFEESAH',
            style: TextStyle(
                fontFamily: "Wrong Delivery",
                fontSize: 30,
                color: Colors.white),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Image.asset("gambar/gamis.png"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 105, 100, 100)),
              child: Text(
                "Form Catatan Stok\nGalery Nafeesah ✏️",
                style: TextStyle(
                    fontFamily: "Vampire Wars Italic",
                    fontSize: 20,
                    color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => FormStok()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 105, 100, 100)),
              child: Text(
                " Daftar List Stok\nGalery Nafeesah 📒",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Vampire Wars Italic",
                    fontSize: 20,
                    color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ListStok()));
              },
            ),
          )
        ],
      ),
    );
  }
}
