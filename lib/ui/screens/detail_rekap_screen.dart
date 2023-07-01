import 'package:flutter/material.dart';
import 'package:simasndan/ui/components/my_separator.dart';
import '../components/def_appbar.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../../providers/models/rekaps.dart';

class DetailRekapScreen extends StatefulWidget {
  const DetailRekapScreen({super.key, this.idRekap});
  final String? idRekap;
  @override
  State<DetailRekapScreen> createState() => _DetailRekapScreenState();
}

class _DetailRekapScreenState extends State<DetailRekapScreen> {
  final _longTxt =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  final List<Rekaps> listOfRekaps = [
    Rekaps(
        tgl: "30/06/2023",
        kode: "KLSSFNH",
        guru: "Gus Baha",
        deskripsi: "Santri telah hadir dan mendapatkan nilai 100"),
    Rekaps(
        tgl: "29/06/2023",
        kode: "KLSSFNH",
        guru: "Gus Baha",
        deskripsi: "Santri telah hadir dan mendapatkan nilai 85"),
    Rekaps(
        tgl: "27/06/2023",
        kode: "KLSSFNH",
        guru: "Gus Baha",
        deskripsi: "Santri telah hadir dan mendapatkan nilai 90"),
  ];
  @override
  Widget build(BuildContext context) {
    var screenSizes = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            appBar: const DefAppBar(title: ""),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                child: Column(children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(25),
                  child: const Row(
                    children: <Widget>[
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Semester 2", style: Styles.headStyle),
                          Text("Tahun Pelajaran 2022/2023",
                              style: TextStyle(
                                  color: orangev3,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16)),
                        ],
                      )),
                      IconButton(
                        iconSize: 70,
                        icon: Icon(
                          Icons.bookmark,
                          color: orangev3,
                        ),
                        onPressed: null,
                      )
                    ],
                  )),
              Stack(children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
                    constraints: BoxConstraints(
                        minHeight: screenSizes.height,
                        minWidth: screenSizes.width,
                        maxHeight: double.infinity),
                    decoration: const BoxDecoration(
                      color: orangev1,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color: orangev3, width: 3))),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 8.0),
                              child: const Text("Tracking Progress Belajar",
                                  style: Styles.labelTxtStyle2)),
                          verticalSpaceSmall,
                          ListView(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              children: <Widget>[
                                _timelineTrack(context),
                                _timelineTrack(context),
                                _timelineTrack(context),
                              ]),
                        ]))
              ]),
            ]))));
  }

  Widget _timelineTrack(BuildContext context) {
    var screenSizes = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        verticalSpaceMedium,
        const Text('KITAB SAFINATUN NAJAH', style: Styles.labelTxtStyle2),
        ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: listOfRekaps.length,
            itemBuilder: (context, i) {
              return Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 40),
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${listOfRekaps[i].tgl} - ${listOfRekaps[i].kode} - ${listOfRekaps[i].guru}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: orangev3,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400)),
                              Text(
                                listOfRekaps[i].deskripsi,
                                style: const TextStyle(
                                    color: orangev3,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              const Divider(
                                color: orangev3,
                                thickness: 1,
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: 18,
                    child: Container(
                      height: screenSizes.height,
                      width: 5.0,
                      color: orangev2,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: orangev2,
                      radius: 20,
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        child: Text('${i + 1}',
                            style: const TextStyle(
                                color: orangev3,
                                fontSize: 26,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              );
            }),
        verticalSpaceMedium,
        const MySeparator(color: orangev3),
      ],
    );
  }
}
