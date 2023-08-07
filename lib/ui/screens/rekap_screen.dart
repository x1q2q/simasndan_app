import 'package:flutter/material.dart';
import '../components/def_appbar.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/my_button.dart';
import 'detail_rekap_screen.dart';
import '../../providers/services/get_data.dart';
import '../../core/api.dart';

enum MenuPopup { itemOne, itemTwo }

class RekapScreen extends StatefulWidget {
  final String? idSantri;
  const RekapScreen({super.key, this.idSantri});

  @override
  State<RekapScreen> createState() => _RekapScreenState();
}

class _RekapScreenState extends State<RekapScreen> {
  final GetData getData = GetData();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isLoading = true;
  MenuPopup? selectedMenu;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  List? allSemester;
  _getData() async {
    allSemester = await getData.allSemester(widget.idSantri);
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: const DefAppBar(title: "Rekap Belajar"),
            backgroundColor: Colors.white,
            body: Column(children: <Widget>[
              Expanded(
                flex: 1,
                child: RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: () async {
                      _getData();
                    },
                    child: _boxSemester(context)),
              )
            ])));
  }

  Widget _boxSemester(BuildContext ctx) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              strokeWidth: 5,
              color: greenv3,
            ),
          )
        : ListView.builder(
            itemCount: allSemester!.length,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                          child: Text('${(index + 1).toString()}',
                              style: const TextStyle(
                                  color: greenv3,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Wrap(
                          direction: Axis.vertical,
                          children: <Widget>[
                            Text('Semester ${allSemester![index]['semester']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    fontFamily: 'Poppins',
                                    color: greenv3)),
                            Text(
                                'Tahun pelajaran ${allSemester![index]['tahun_pelajaran']}',
                                style: const TextStyle(
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
                          icon: const Icon(Icons.more_vert,
                              size: 45, color: greenv1),
                          onSelected: (MenuPopup item) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailRekapScreen(
                                        idSantri: '1',
                                        idSemester: allSemester![index]['id']
                                            .toString(),
                                        semester: allSemester![index]
                                            ['semester'],
                                        thPelajaran: allSemester![index]
                                            ['tahun_pelajaran'])));
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
                  ));
            });
  }
}
