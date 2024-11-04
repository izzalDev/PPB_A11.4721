import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:menu_makanan/menu.dart';
import 'package:menu_makanan/nota_page.dart';

//ignore: must_be_immutable
class PesanPage extends StatefulWidget {
  PesanPage({super.key, required this.pesananMenu});
  Menu pesananMenu;
  @override
  State<StatefulWidget> createState() => _PesanPage(pesananMenu: pesananMenu);
}

class _PesanPage extends State {
  _PesanPage({required this.pesananMenu});
  Menu pesananMenu;
  int total = 0;
  int curJml = 0;
  TextEditingController jmlCtrl = TextEditingController();
  @override
  void initState() {
    super.initState();
    jmlCtrl.text = '0';
  }

  void changeJml(String op) {
    curJml = int.tryParse(jmlCtrl.text.toString()) ?? 0;
    if (op == '+') {
      curJml++;
    } else if (op == '-') {
      curJml--;
    }
    jmlCtrl.text = curJml.toString();
    setState(() {
      total = curJml * pesananMenu.harga;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pesanan Anda")),
      body: Column(
        children: [
          Image.asset('assets/images/${pesananMenu.gambar}'),
          Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(pesananMenu.nama)),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(pesananMenu.deskripsi),
          ),
          Container(
            child: Text("Rp. ${pesananMenu.harga}"),
          ),
          Row(
            children: [
              Center(
                child: Ink(
                  decoration: const ShapeDecoration(
                      shape: CircleBorder(), color: Colors.pink),
                  child: IconButton(
                      onPressed: () {
                        changeJml('-');
                      },
                      color: Colors.amber,
                      icon: const Icon(Icons.remove, size: 20)),
                ),
              ),
              SizedBox(width: 70, child: TextField(controller: jmlCtrl)),
              IconButton(
                  onPressed: () {
                    changeJml('+');
                  },
                  color: Colors.greenAccent,
                  icon: const Icon(Icons.add, size: 10)),
              Expanded(child: Text(total.toString())),
            ],
          ),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotaPage(
                                pesanan: pesananMenu, jumlah: curJml)));
                  },
                  child: const Text("Pesan Sekarang")))
        ],
      ),
    );
  }
}
