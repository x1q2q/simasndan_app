import 'package:flutter/material.dart';
import '../components/def_appbar.dart';
import '../../core/ui_helper.dart';
import '../../providers/services/get_data.dart';
import '../../core/styles.dart';
import '../components/my_separator.dart';
import '../components/skeleton.dart';
import 'package:intl/intl.dart';
import '../components/my_button.dart';
import '../components/svg.dart';

class NotifikasiScreen extends StatefulWidget {
  const NotifikasiScreen({super.key, this.idSantri});
  final String? idSantri;

  @override
  State<NotifikasiScreen> createState() => _NotifikasiScreenState();
}

class _NotifikasiScreenState extends State<NotifikasiScreen> {
  final GetData getData = GetData();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  List? allNotif;
  _getData() async {
    _isLoading = true;
    allNotif = await getData.allNotif(widget.idSantri).catchError((e) {
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
          appBar: const DefAppBar(title: "Semua Notifikasi"),
          backgroundColor: Colors.white,
          body: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () async {
                setState(() {
                  _getData();
                });
              },
              child: _boxNotif(context))),
    );
  }

  String tglNow(String? format) {
    DateTime form = DateFormat('y-M-d').parse("$format");
    return DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(form).toString();
  }

  Widget _boxNotif(BuildContext context) {
    return _isLoading
        ? Skeleton.shimmerNotif
        : (allNotif!.isNotEmpty)
            ? listNotif(context)
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

  Widget listNotif(BuildContext context) {
    return SingleChildScrollView(
        child: ListView.builder(
            itemCount: allNotif!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return boxNotif(context, allNotif![index]["tanggal"],
                  allNotif![index]["notif_list"]);
            }));
  }

  Widget boxNotif(BuildContext context, String? tanggal, List? notifs) {
    return Padding(
        padding: const EdgeInsets.only(top: 20, left: 15),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Badge(
                backgroundColor: lightv2,
                largeSize: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                label: Text(
                  "${tglNow(tanggal)}",
                  style: Styles.labelTxtStyle,
                ),
              ),
              verticalSpaceSmall,
              const MySeparator(color: Colors.black26),
              ListView.builder(
                  itemCount: notifs!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    final IconData typeIcon;
                    typeIcon = (notifs[index]["tipe"] == 'jadwal')
                        ? Icons.calendar_month_outlined
                        : (notifs[index]["tipe"] == 'kelas')
                            ? Icons.note_alt
                            : Icons.campaign;

                    return Material(
                        color: Colors.white,
                        child: InkWell(
                            splashColor: lightv2,
                            onTap: () {},
                            child: Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: greyv1))),
                              padding: const EdgeInsets.all(6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: greenv1,
                                    radius: 30,
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      child: Icon(typeIcon,
                                          color: orangev1, size: 35),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('${notifs[index]['judul']}',
                                            style: const TextStyle(
                                                fontSize: 17,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold)),
                                        Text('${notifs[index]['pesan']}',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black45,
                                                fontWeight: FontWeight.w500))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )));
                  })
            ]));
  }
}
