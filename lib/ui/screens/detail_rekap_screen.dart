import 'package:flutter/material.dart';
import 'package:simasndan/ui/components/my_separator.dart';
import '../components/def_appbar.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../../providers/models/rekaps.dart';
import '../../providers/services/get_data.dart';
import '../../core/api.dart';

class DetailRekapScreen extends StatefulWidget {
  const DetailRekapScreen(
      {super.key,
      this.idSantri,
      this.idSemester,
      this.semester,
      this.thPelajaran});
  final String? idSantri;
  final String? idSemester;
  final String? semester;
  final String? thPelajaran;

  @override
  State<DetailRekapScreen> createState() => _DetailRekapScreenState();
}

class _DetailRekapScreenState extends State<DetailRekapScreen> {
  final GetData getData = GetData();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  List? allPenilaian;
  _getData() async {
    allPenilaian =
        await getData.allPenilaian(widget.idSantri, widget.idSemester);
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: const DefAppBar(title: ""),
            backgroundColor: Colors.white,
            body: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () async {
                  _getData();
                },
                child: konten(context))));
  }

  Widget konten(BuildContext context) {
    var screenSizes = MediaQuery.of(context).size;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              strokeWidth: 5,
              color: greenv3,
            ),
          )
        : ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(25),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Semester ${widget.semester}",
                                style: Styles.headStyle),
                            Text("Tahun Pelajaran ${widget.thPelajaran}",
                                style: const TextStyle(
                                    color: orangev3,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16)),
                          ],
                        )),
                        const IconButton(
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
                            ListView.builder(
                                itemCount: allPenilaian!.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (_, index) {
                                  return _timelineTrack(
                                      context,
                                      allPenilaian![index]['materi'],
                                      allPenilaian![index]['penilaian']);
                                })
                          ]))
                ]),
              ]);
  }

  Widget _timelineTrack(BuildContext context, String materi, List timeline) {
    var screenSizes = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        verticalSpaceSmall,
        Text(materi, style: Styles.labelTxtStyle2),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: timeline.length,
            itemBuilder: (context, i) {
              var waktu = timeline[i]['waktu_mulai'].substring(0, 16);
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
                                  '${waktu} - (${timeline[i]['presensi']}/${timeline[i]['nilai']}) - ${timeline[i]['nama_guru']}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: orangev3,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400)),
                              Text(
                                '-KEGIATAN: ${timeline[i]['kegiatan']}\n-DESKRIPSI: ${timeline[i]['deskripsi']}',
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
        const MySeparator(color: orangev2),
      ],
    );
  }
}
