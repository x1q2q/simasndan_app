import 'package:flutter/material.dart';
import '../components/def_appbar.dart';
import '../../core/ui_helper.dart';
import '../../providers/services/get_data.dart';
import '../../core/styles.dart';

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

  @override
  void initState() {
    super.initState();
    _getData();
  }

  List? allNotif;
  _getData() async {
    allNotif = await getData.allNotif(widget.idSantri);
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: const DefAppBar(title: "Semua Notifikasi"),
            backgroundColor: Colors.white,
            body: Column(children: <Widget>[
              Expanded(
                flex: 1,
                child: RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: () async {
                      _getData();
                    },
                    child: _boxNotif(context)),
              )
            ])));
  }

  Widget _boxNotif(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              strokeWidth: 5,
              color: greenv3,
            ),
          )
        : ListView.builder(
            itemCount: allNotif!.length,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              final IconData typeIcon;
              typeIcon = (allNotif![index]["tipe"] == 'jadwal')
                  ? Icons.calendar_month_outlined
                  : (allNotif![index]["tipe"] == 'kelas')
                      ? Icons.note_alt
                      : Icons.campaign;

              return Material(
                  color: Colors.white,
                  child: InkWell(
                      splashColor: lightv2,
                      onTap: () {},
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: greyv1))),
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: greenv1,
                              radius: 30,
                              child: Container(
                                height: 35,
                                width: 35,
                                child:
                                    Icon(typeIcon, color: orangev1, size: 35),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${allNotif![index]['judul']}',
                                      style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text('${allNotif![index]['pesan']}',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),
                            const SizedBox(width: 5),
                            Badge(
                              backgroundColor: orangev2,
                              largeSize: 20,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              label: Text(
                                  "${allNotif![index]['created_at'].substring(0, 16)}",
                                  style: Styles.badgeStyle),
                            ),
                          ],
                        ),
                      )));
            });
  }
}
