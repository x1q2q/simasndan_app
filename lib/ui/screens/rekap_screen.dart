import 'package:flutter/material.dart';
import '../components/def_appbar.dart';
import '../components/my_button.dart';
import '../../core/ui_helper.dart';
import 'detail_rekap_screen.dart';
import '../../providers/services/get_data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../components/skeleton.dart';
import '../components/svg.dart';

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
  bool _isError = false;
  MenuPopup? selectedMenu;
  late final Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box('user');
    _getData();
  }

  List? allSemester;
  _getData() async {
    _isLoading = true;
    allSemester = await getData.allSemester(widget.idSantri).catchError((e) {
      _isLoading = false;
      _isError = true;
      return [];
    }).then((value) {
      _isLoading = false;
      return value;
    });
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
                      setState(() {
                        _getData();
                      });
                    },
                    child: containerSemester(context)),
              )
            ])));
  }

  Widget containerSemester(BuildContext ctx) {
    return _isLoading
        ? Skeleton.shimmerRekap
        : (allSemester!.isNotEmpty)
            ? listSemester(ctx)
            : ListView(
                shrinkWrap: true,
                children: <Widget>[
                  verticalSpaceLarge,
                  verticalSpaceLarge,
                  _isError == true ? Svg.imgErrorData : Svg.imgEmptyData,
                  Center(
                    child: MyButton(
                      type: 'elevicon',
                      icon: Icons.refresh,
                      onTap: () async {
                        setState(() {
                          _getData();
                        });
                      },
                      btnText: 'Refresh',
                    ),
                  ),
                  verticalSpaceLarge
                ],
              );
  }

  Widget listSemester(BuildContext ctx) {
    return ListView.builder(
        itemCount: allSemester!.length,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                      icon:
                          const Icon(Icons.more_vert, size: 45, color: greenv1),
                      onSelected: (MenuPopup item) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailRekapScreen(
                                    idSantri: box.get('id').toString(),
                                    idSemester:
                                        allSemester![index]['id'].toString(),
                                    semester: allSemester![index]['semester'],
                                    thPelajaran: allSemester![index]
                                        ['tahun_pelajaran'])));
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<MenuPopup>>[
                            const PopupMenuItem<MenuPopup>(
                              value: MenuPopup.itemOne,
                              child: Text('Detail'),
                            ),
                            // const PopupMenuItem<MenuPopup>(
                            //   value: MenuPopup.itemTwo,
                            //   child: Text('Download'),
                            // ),
                          ]),
                ],
              ));
        });
  }
}
