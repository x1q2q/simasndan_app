import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../../ui/components/menu_button.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: greenv2,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Expanded(
                                child: Wrap(
                                  direction: Axis.vertical,
                                  children: <Widget>[
                                    Text("Assalamualaikum wr wb, Sahabat!",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            color: Colors.white)),
                                    Text("Surakarta, 21 Juni 2023",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                              IconButton(
                                iconSize: 30,
                                color: Colors.white,
                                icon: const Icon(
                                  Icons.notifications,
                                ),
                                onPressed: () => {},
                              )
                            ],
                          ),
                          verticalSpaceSmall,
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                                color: greenv3,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: <Widget>[
                                const Expanded(
                                  child: Wrap(
                                    direction: Axis.vertical,
                                    children: <Widget>[
                                      Text("Subuh 04:34 WIB",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              fontFamily: 'Poppins',
                                              color: Colors.white)),
                                      Text("04:00:00 menjelang adzan shubuh",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: orangev1,
                                  radius: 30,
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              alignment: Alignment.center,
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'assets/images/logo_pondok.png')))),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                  Stack(
                    children: [
                      Container(
                          height: 150,
                          padding: const EdgeInsets.all(15),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: lightv1,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 4,
                            children: <Widget>[
                              MenuButton(
                                btnTxt: "Berita",
                                iconBtn: Icons.newspaper,
                                typeBtn: 'btn1',
                                onTap: () => {},
                              ),
                              MenuButton(
                                  btnTxt: "Materi",
                                  iconBtn: Icons.menu_book,
                                  typeBtn: 'btn2',
                                  onTap: () => {}),
                              MenuButton(
                                  btnTxt: "Rekap",
                                  iconBtn: Icons.timeline,
                                  typeBtn: 'btn2',
                                  onTap: () => {}),
                              MenuButton(
                                  btnTxt: "Profil",
                                  iconBtn: Icons.person,
                                  typeBtn: 'btn3',
                                  onTap: () => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ProfileScreen()))
                                      })
                            ],
                          ))
                    ],
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 10,
                    height: 0,
                  ),
                  Container(
                      height: 580,
                      width: double.infinity,
                      color: lightv1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              color: greenv3, width: 3))),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 8.0),
                                  child: const Text("Headline",
                                      style: Styles.labelTxtStyle))),
                          Flexible(
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: <Widget>[
                                _boxNews(context),
                                _boxNews(context),
                                _boxNews(context),
                                _boxNews(context),
                                _boxNews(context),
                                _boxNews(context),
                              ],
                            ),
                          )
                        ],
                      ))
                ],
              ),
            )));
  }

  Widget _boxNews(BuildContext context) {
    return Material(
      color: lightv2,
      child: InkWell(
          onTap: () {},
          splashColor: greenv2,
          child: Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: greenv1))),
            padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
            child: Row(
              children: [
                const Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Judul Berita satu',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Colors.black87),
                      ),
                      Text(
                        softWrap: true,
                        'lorem ipsum dolor sit amet consecteur dolor sit amet banget uh juni plan plan pak sopirr. spontan uhuyy',
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.18,
                  child: Image.asset(
                    "assets/images/luffyeeeh.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
