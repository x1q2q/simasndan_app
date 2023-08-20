import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../../ui/components/menu_button.dart';
import 'profil_screen.dart';
import 'rekap_screen.dart';
import 'detail_berita_screen.dart';
import 'notifikasi_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/messaging_service.dart';
import '../../providers/services/get_data.dart';
import '../../core/api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.inputName}) : super(key: key);
  final String? inputName;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GetData getData = GetData();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isLoading = true;

  late final Box box;
  final _messagingService = MessagingService();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    box = Hive.box('user');
    _messagingService.init(context);
    _getData();
  }

  List? allBerita;
  _getData() async {
    allBerita = await getData.headlinesBerita(5);
    _isLoading = false;
    setState(() {});
  }

  String tglNow() {
    return DateFormat("dd MMMM yyyy", "id_ID")
        .format(DateTime.now())
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    var screenSizes = MediaQuery.of(context).size;
    String uname = box.get('username');
    String uuid = box.get('uuid');
    String idsantri = box.get('id');
    String greetingTxt = 'Assalamualaikum, $uname!';

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
                              Expanded(
                                child: Wrap(
                                  direction: Axis.vertical,
                                  children: <Widget>[
                                    Text(greetingTxt,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            color: Colors.white)),
                                    Text("Surakarta, ${tglNow()}",
                                        style: const TextStyle(
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
                                onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NotifikasiScreen(
                                                idSantri: idsantri,
                                              )))
                                },
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
                                    child: const Icon(Icons.mosque,
                                        color: orangev3, size: 40),
                                  ),
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
                            boxShadow: [Styles.boxCardShdStyle],
                          ),
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 4,
                            children: <Widget>[
                              MenuButton(
                                btnTxt: "Berita",
                                iconBtn: Icons.newspaper,
                                typeBtn: 'btn1',
                                onTap: () => {
                                  Navigator.of(context)
                                      .pushNamed("/berita-screen")
                                },
                              ),
                              MenuButton(
                                  btnTxt: "Materi",
                                  iconBtn: Icons.menu_book,
                                  typeBtn: 'btn2',
                                  onTap: () => {
                                        Navigator.of(context)
                                            .pushNamed("/materi-screen")
                                      }),
                              MenuButton(
                                  btnTxt: "Rekap",
                                  iconBtn: Icons.timeline,
                                  typeBtn: 'btn2',
                                  onTap: () => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RekapScreen(
                                                        idSantri: idsantri)))
                                      }),
                              MenuButton(
                                  btnTxt: "Profil",
                                  iconBtn: Icons.person,
                                  typeBtn: 'btn3',
                                  onTap: () => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfilScreen(
                                                        idSantri: idsantri)))
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
                      height: 700,
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
                          _boxNews(context)
                        ],
                      ))
                ],
              ),
            )));
  }

  Widget _boxNews(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              strokeWidth: 5,
              color: greenv3,
            ),
          )
        : ListView.builder(
            itemCount: allBerita!.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return Material(
                color: Colors.white,
                child: InkWell(
                    onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailBeritaScreen(
                                        idBerita:
                                            allBerita![index]['id'].toString(),
                                      )))
                        },
                    splashColor: greenv1,
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: greenv1))),
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${allBerita![index]['judul']}",
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      fontFamily: 'Poppins',
                                      color: Colors.black87),
                                ),
                                Text(
                                  softWrap: true,
                                  maxLines: 2,
                                  "${allBerita![index]['isi']}",
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.black54),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: (allBerita![index]['media'] == null)
                                ? Image.network(
                                    "${Api.baseURL}/assets/img/no-image.png")
                                : Image.network(
                                    "${Api.baseURL}/assets/img/uploads/berita/${allBerita![index]['media']['nama']}"),
                          ),
                        ],
                      ),
                    )),
              );
            });
  }
}
