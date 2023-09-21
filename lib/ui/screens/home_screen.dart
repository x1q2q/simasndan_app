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
import '../../providers/services/messaging_service.dart';
import '../../providers/services/get_data.dart';
import '../../core/api.dart';
import '../../providers/services/location_service.dart';
import '../../providers/services/adhan_service.dart';
import '../../providers/services/general_service.dart';
import '../../providers/services/fcm_provider.dart';
import '../components/skeleton.dart';
import '../components/box_jadwal.dart';
import '../components/svg.dart';
import '../components/my_button.dart';

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
  bool _isError = false;
  bool _isLoadAdhanTime = true;
  bool _isErrorLoadAdhan = false;
  String? _currentAddress = '';
  String? _currentAdhanTime = '';
  late final Box box;
  final _messagingService = MessagingService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FCMProvider.setContext(context);
    });

    initializeDateFormatting();
    box = Hive.box('user');
    _messagingService.init(context);

    _getLocation().then((value) {
      if (value != null) {
        _getAdhanTime(value);
      } else {
        _isLoadAdhanTime = false;
        _isErrorLoadAdhan = true;
        _currentAddress = 'lokasi tidak ditemukan';
        _currentAdhanTime = 'jadwal tidak diketahui';
      }
    });
    _getData();
  }

  List? allBerita;
  List? dataJadwal;
  _getData() async {
    _isLoading = true;
    allBerita = await getData.headlinesBerita(5).catchError((e) {
      _isLoading = false;
      _isError = true;
      return [];
    }).then((value) {
      _isLoading = false;
      return value;
    });
    setState(() {});
  }

  Future<String?> writeAndGetLocation() async {
    bool isGranted = await GeneralService().checkPermission('lokasi');
    String loc = "";
    if (isGranted) {
      await LocationService().getCurrentPosition().then((value) async {
        Map<String, dynamic>? addr =
            await LocationService().getAddressFromLatLng(value);
        await box.put('kec', addr?["kec"]);
        await box.put('kab', addr?["kab"]);
        await box.put('location', addr?["location"]);
        await box.put('full_location', addr?["full_location"]);
        loc = addr?["location"];
      }).onError((error, stackTrace) {
        loc = 'unknown';
      });
      return loc;
    }
    return 'unknown';
  }

  Future<String?> _getLocation() async {
    _isLoadAdhanTime = true;
    String? locName = await box.get('location') ?? await writeAndGetLocation();
    setState(() {
      _currentAddress = locName;
    });
    if (locName == 'unkown') {
      return null;
    }
    return await box.get('kab');
  }

  _getAdhanTime(String? kota) async {
    String? idKota = await AdhanService().getIdKota(kota);
    DateTime now = DateTime.now();
    Map<String, dynamic> args = {
      "idkota": idKota,
      "tahun": now.year.toString(),
      "bulan": now.month.toString(),
      "tanggal": now.day.toString()
    };
    dataJadwal = await AdhanService().getJadwal(args);
    String? adhanTime =
        await AdhanService().getAdhanTime(now, dataJadwal, args);
    setState(() {
      _isLoadAdhanTime = false;
      _isErrorLoadAdhan = false;
      _currentAdhanTime = adhanTime;
    });
  }

  String tglNow() {
    return DateFormat("EEEE, dd MMMM yyyy", "id_ID")
        .format(DateTime.now())
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    var screenSizes = MediaQuery.of(context).size;
    String uname = box.get('username');
    String? kab = box.get('kab') ?? '';
    String uuid = box.get('uuid');
    String? fullLocation = box.get('full_location');
    String idsantri = box.get('id');
    String greetingTxt = 'Halo, $uname!';

    return SafeArea(
        child: Scaffold(
            backgroundColor: greenv2,
            body: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () async {
                  _getData();
                  _getLocation().then((value) {
                    if (value != null) {
                      _getAdhanTime(value);
                    } else {
                      _isLoadAdhanTime = false;
                      _isErrorLoadAdhan = true;
                      _currentAddress = 'lokasi tidak ditemukan';
                      _currentAdhanTime = 'jadwal tidak diketahui';
                    }
                  });
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
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
                                        Text(tglNow(),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                fontSize: 14)),
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
                              Material(
                                  color: greenv3,
                                  borderRadius: BorderRadius.circular(15),
                                  child: InkWell(
                                      splashColor: orangev2,
                                      onTap: () {
                                        showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return _isLoadAdhanTime
                                                  ? Skeleton.shimmerJadwal
                                                  : _isErrorLoadAdhan
                                                      ? const BoxJadwal(
                                                          tglNow:
                                                              "Jadwal tidak diketahui",
                                                          fullLoc:
                                                              "Lokasi tidak ditemukan. Harap refresh halaman terlebih dahulu!",
                                                          dataJadwal: [],
                                                        )
                                                      : BoxJadwal(
                                                          tglNow:
                                                              "(Jadwal Sholat Hari ${tglNow()})",
                                                          fullLoc: fullLocation,
                                                          dataJadwal:
                                                              dataJadwal);
                                            });
                                      },
                                      borderRadius: BorderRadius.circular(15),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            _isLoadAdhanTime
                                                ? Skeleton.shimmerAdhan
                                                : locationInfo(context),
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
                                      )))
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
                                                            idSantri:
                                                                idsantri)))
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
                                                            idSantri:
                                                                idsantri)))
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
                          constraints: const BoxConstraints(minHeight: 700),
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
                              boxNews(context)
                            ],
                          ))
                    ],
                  ),
                ))));
  }

  Widget locationInfo(BuildContext context) {
    return Expanded(
        child: Wrap(
      direction: Axis.vertical,
      children: <Widget>[
        Text("$_currentAdhanTime",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'Poppins',
                color: Colors.white)),
        Text("$_currentAddress",
            style: const TextStyle(fontSize: 13, color: Colors.white)),
      ],
    ));
  }

  Widget boxNews(BuildContext context) {
    return _isLoading
        ? Skeleton.shimmerNews
        : (allBerita!.isNotEmpty)
            ? listNews(context)
            : ListView(
                shrinkWrap: true,
                children: <Widget>[
                  verticalSpaceLarge,
                  verticalSpaceLarge,
                  _isError == true ? Svg.imgErrorData : Svg.imgEmptyData,
                  verticalSpaceSmall,
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

  Widget listNews(BuildContext context) {
    return ListView.builder(
        itemCount: allBerita!.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
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
                        height: 110,
                        width: 150,
                        child: (GeneralService().checkisNoValidImage(
                                allBerita![index]['media']))
                            ? Svg.imgNotFoundLandscape
                            : Image.network(
                                "${Api.baseURL}/public/assets/img/uploads/berita/${allBerita![index]['media']['nama']}",
                                fit: BoxFit.cover,
                              ),
                      ),
                    ],
                  ),
                )),
          );
        });
  }
}
