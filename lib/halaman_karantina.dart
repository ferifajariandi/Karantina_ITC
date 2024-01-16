import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:karantina/edit_karantina.dart';
import 'package:karantina/tambah_karantina.dart';

import 'detail_karantina.dart';

class HalamanKarantina extends StatefulWidget {
  const HalamanKarantina({Key? key}) : super(key: key);

  @override
  _HalamanKarantinaState createState() => _HalamanKarantinaState();
}

class _HalamanKarantinaState extends State<HalamanKarantina> {
  List _listdata = [];
  bool _loading = true;

  Future _getData() async {
    try {
      final respon = await http
          .get(Uri.parse('http://192.168.1.33/api_karantina/read.php'));
      if (respon.statusCode == 200) {
        final data = jsonDecode(respon.body);
        setState(() {
          _listdata = data;
          _loading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _hapus(String id) async {
    try {
      final respon = await http.post(
        Uri.parse('http://192.168.1.33/api_karantina/delete.php'),
        body: {
          "id_karantina": id,
        },
      );
      if (respon.statusCode == 200) {
        final data = jsonDecode(respon.body);
        setState(() {
          _listdata = data;
          _loading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Center(
          child: Text(
            'Halaman Karantina',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      drawer: MyDrawer(),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: _listdata.isEmpty
                  ? Center(
                      child: Text(
                        'Tidak ada data',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _listdata.length,
                      itemBuilder: ((context, index) {
                        return Card(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailKarantina(
                                    ListData: {
                                      'id_karantina': _listdata[index]
                                              ['id_karantina'] ??
                                          '',
                                      'nama_perusahaan': _listdata[index]
                                              ['nama_perusahaan'] ??
                                          '',
                                      'alamat_perusahaan': _listdata[index]
                                              ['alamat_perusahaan'] ??
                                          '',
                                      'nomor_permohonan': _listdata[index]
                                              ['nomor_permohonan'] ??
                                          '',
                                      'alamat_domisili': _listdata[index]
                                              ['alamat_domisili'] ??
                                          '',
                                    },
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(_listdata[index]['nama_perusahaan']),
                              subtitle:
                                  Text(_listdata[index]['alamat_perusahaan']),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditKarantina(
                                              ListData: {
                                                'id_karantina': _listdata[index]
                                                    ['id_karantina'],
                                                'nama_perusahaan':
                                                    _listdata[index]
                                                        ['nama_perusahaan'],
                                                'alamat_perusahaan':
                                                    _listdata[index]
                                                        ['alamat_perusahaan'],
                                                'nomor_permohonan':
                                                    _listdata[index]
                                                        ['nomor_permohonan'],
                                                'alamat_domisili':
                                                    _listdata[index]
                                                        ['alamat_domisili'],
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: ((context) {
                                            return AlertDialog(
                                              content: const Text(
                                                'Hapus data ini?',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    _hapus(_listdata[index]
                                                            ['id_karantina'])
                                                        .then((value) {
                                                      Navigator
                                                          .pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: ((context) =>
                                                              HalamanKarantina()),
                                                        ),
                                                        (route) => false,
                                                      );
                                                    });
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.deepOrange,
                                                  ),
                                                  child: Text(
                                                    'Hapus',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Cancel'),
                                                ),
                                              ],
                                            );
                                          }),
                                        );
                                      },
                                      icon: Icon(Icons.delete))
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Text(
          '+',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahKarantina()),
          );
        },
      ),
    );
  }
}

// Widget tambahan
class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepOrange,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Menu 1'),
            onTap: () {
              // Action ketika menu 1 di-tap
            },
          ),
          ListTile(
            title: Text('Menu 2'),
            onTap: () {
              // Action ketika menu 2 di-tap
            },
          ),
          // ... tambahkan menu lainnya sesuai kebutuhan
        ],
      ),
    );
  }
}
