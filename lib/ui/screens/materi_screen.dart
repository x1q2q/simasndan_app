import 'package:flutter/material.dart';
import '../components/def_appbar.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/my_button.dart';
import 'detail_materi_screen.dart';

class MateriScreen extends StatefulWidget {
  const MateriScreen({Key? key}) : super(key: key);

  @override
  State<MateriScreen> createState() => _MateriScreenState();
}

class _MateriScreenState extends State<MateriScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: const DefAppBar(title: "Semua Materi"),
            backgroundColor: Colors.white,
            body: ListView(shrinkWrap: true, reverse: false, children: <Widget>[
              verticalSpaceMedium,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _boxNews(context),
                  _boxNews(context),
                  _boxNews(context),
                  _boxNews(context),
                  _boxNews(context),
                  _boxNews(context),
                  _boxNews(context),
                  _boxNews(context),
                  _boxNews(context),
                  _boxNews(context),
                  _boxNews(context),
                  _boxNews(context),
                  _boxNews(context),
                  _boxNews(context),
                  _boxNews(context),
                  _boxNews(context),
                ],
              ),
            ])));
  }

  Widget _boxNews(BuildContext context) {
    return Material(
      color: orangev1,
      child: InkWell(
          onTap: null,
          child: Container(
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: orangev3))),
            padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
            child: Row(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Image.asset(
                          "assets/images/luffyeeeh.jpg",
                          fit: BoxFit.fill,
                        ))),
                const SizedBox(width: 5),
                const Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 1,
                        'Kitab Safinatun Najah',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            color: orangev3),
                      ),
                      Text(
                        maxLines: 1,
                        softWrap: true,
                        'lorem ipsum dolor sit amet consecteur dolor sit amet banget',
                        style: TextStyle(fontSize: 13, color: orangev3),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                IconButton(
                  iconSize: 50,
                  color: orangev3,
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DetailMateriScreen(
                                  idMateri: '1',
                                )))
                  },
                )
              ],
            ),
          )),
    );
  }
}
