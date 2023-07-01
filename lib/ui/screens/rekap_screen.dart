import 'package:flutter/material.dart';
import '../components/def_appbar.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/my_button.dart';
import 'detail_rekap_screen.dart';

enum MenuPopup { itemOne, itemTwo }

class RekapScreen extends StatefulWidget {
  const RekapScreen({Key? key}) : super(key: key);

  @override
  State<RekapScreen> createState() => _RekapScreenState();
}

class _RekapScreenState extends State<RekapScreen> {
  MenuPopup? selectedMenu;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: const DefAppBar(title: "Rekap Belajar"),
            backgroundColor: Colors.white,
            body: ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                shrinkWrap: true,
                reverse: false,
                children: <Widget>[
                  _boxContainer(context),
                  _boxContainer(context),
                  _boxContainer(context)
                ])));
  }

  Widget _boxContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: lightv1,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: greenv2, width: 2)),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: lightv2,
            radius: 30,
            child: Container(
              padding: const EdgeInsets.all(0),
              child: const Text('1',
                  style: TextStyle(
                      color: greenv3,
                      fontSize: 26,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Wrap(
              direction: Axis.vertical,
              children: <Widget>[
                Text('Semester 1',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        fontFamily: 'Poppins',
                        color: greenv3)),
                Text("Tahun pelajaran 2022/203",
                    style: TextStyle(
                        fontSize: 14,
                        color: greenv3,
                        fontStyle: FontStyle.italic)),
              ],
            ),
          ),
          const SizedBox(width: 5),
          PopupMenuButton<MenuPopup>(
              initialValue: selectedMenu,
              color: orangev1,
              icon: const Icon(Icons.more_vert, size: 45, color: greenv1),
              onSelected: (MenuPopup item) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DetailRekapScreen(
                              idRekap: '1',
                            )));
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<MenuPopup>>[
                    const PopupMenuItem<MenuPopup>(
                      value: MenuPopup.itemOne,
                      child: Text('Detail'),
                    ),
                    const PopupMenuItem<MenuPopup>(
                      value: MenuPopup.itemTwo,
                      child: Text('Download'),
                    ),
                  ]),
        ],
      ),
    );
  }
}
