import 'package:flutter/material.dart';
import '../components/def_appbar.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import 'detail_berita_screen.dart';

class BeritaScreen extends StatefulWidget {
  const BeritaScreen({Key? key}) : super(key: key);

  @override
  State<BeritaScreen> createState() => _BeritaScreenState();
}

enum KategoriFilter { artikel, pengumuman, jadwal }

class _BeritaScreenState extends State<BeritaScreen> {
  Set<KategoriFilter> filters = <KategoriFilter>{};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: const DefAppBar(title: "Semua Berita"),
            backgroundColor: Colors.white,
            body: ListView(shrinkWrap: true, reverse: false, children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 5.0,
                  children:
                      KategoriFilter.values.map((KategoriFilter kategori) {
                    return FilterChip(
                      side: const BorderSide(color: orangev3),
                      checkmarkColor: orangev3,
                      selectedColor: orangev1,
                      label: Text(
                        kategori.name,
                        style: Styles.filterStyle,
                      ),
                      selected: filters.contains(kategori),
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            filters.add(kategori);
                          } else {
                            filters.remove(kategori);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
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
                ],
              ),
            ])));
  }

  Widget _boxNews(BuildContext context) {
    return Material(
      color: lightv1,
      child: InkWell(
          onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DetailBeritaScreen(
                              idBerita: '1',
                            )))
              },
          splashColor: lightv2,
          child: Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: greenv1))),
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              children: [
                const Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 2,
                        'Jadwal Imsak Hari Ini Kota Surakarta - Jadwal Imsakiyah',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            color: Colors.black87),
                      ),
                      verticalSpaceXSmall,
                      Row(children: <Widget>[
                        Badge(
                          backgroundColor: greenv3,
                          largeSize: 20,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          label: Text('jadwal', style: Styles.badgeStyle),
                        ),
                        SizedBox(width: 10),
                        Text.rich(
                          TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Icon(
                                Icons.person,
                                size: 14,
                                color: greenv3,
                              )),
                              TextSpan(
                                  text: ' by admin',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: greenv3,
                                      fontStyle: FontStyle.italic)),
                            ],
                          ),
                        )
                      ]),
                      Text(
                        maxLines: 2,
                        softWrap: true,
                        'lorem ipsum dolor sit amet consecteur dolor sit amet banget uh juni plan plan pak sopirr. spontan uhuyy',
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10),
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
