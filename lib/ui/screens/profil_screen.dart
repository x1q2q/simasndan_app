import 'package:flutter/material.dart';
import '../components/def_appbar.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/my_button.dart';
import 'edit_profil_screen.dart';
import '../../core/api.dart';
import '../../providers/models/santri.dart';
import '../../providers/services/get_data.dart';
import '../../core/auth.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/messaging_service.dart';

class ProfilScreen extends StatefulWidget {
  final String? idSantri;
  const ProfilScreen({super.key, this.idSantri});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final GetData getData = GetData();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isLoading = true;
  late final Box box;
  final _messagingService = MessagingService();
  String? fcmToken;

  @override
  void initState() {
    super.initState();
    box = Hive.box('user');
    _getData();
  }

  Santri? dtSantri;
  _getData() async {
    dtSantri = await getData.detailSantri(widget.idSantri);
    fcmToken = await _messagingService.getDeviceToken();
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: const DefAppBar(title: "Profil"),
            backgroundColor: Colors.white,
            body: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () async {
                  _getData();
                },
                child: konten(context))));
  }

  Widget konten(BuildContext ctx) {
    bool checkIsNoValidEmail(String? email) {
      return (email == null || email == '-' || email == '');
    }

    var screenSizes = MediaQuery.of(context).size;
    String sttsSantri(dynamic stts) {
      return (stts) ? 'Pengurus' : 'Santri Biasa';
    }

    bool checkisNoValidImage(dynamic foto) {
      return (foto == null || foto == '-' || foto == '');
    }

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              strokeWidth: 5,
              color: greenv3,
            ),
          )
        : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 40),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              CircleAvatar(
                backgroundColor: orangev2,
                radius: 70,
                child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        image: DecorationImage(
                            alignment: Alignment.center,
                            fit: BoxFit.cover,
                            image: (checkisNoValidImage(dtSantri!.foto))
                                ? const NetworkImage(
                                    "${Api.baseURL}/assets/img/no-image.png")
                                : NetworkImage(
                                    "${Api.baseURL}/assets/img/uploads/santri/${dtSantri!.foto}")))),
              ),
              verticalSpaceSmall,
              Center(
                  child:
                      Text('@${dtSantri!.username}', style: Styles.headStyle)),
              verticalSpaceSmall,
              Center(
                  child: MyButton(
                type: 'elevicon',
                icon: Icons.edit,
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfilScreen(
                                idSantri: dtSantri!.id,
                              )))
                },
                btnText: 'Edit Profil',
              )),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    children: <Widget>[
                      _boxField(context, 'Nama', dtSantri!.namaSantri),
                      _boxField(
                          context,
                          'Email',
                          checkIsNoValidEmail(dtSantri!.email)
                              ? '-'
                              : dtSantri!.email),
                      _boxField(context, 'Tingkatan', dtSantri!.tingkatan),
                      _boxField(
                          context, 'Status', sttsSantri(dtSantri!.isPengurus)),
                      _boxField(context, 'TTL',
                          '${dtSantri!.tempatLahir}, ${dtSantri!.tglLahir ?? '-'}'),
                      _boxField(context, 'Pendidikan', dtSantri!.universitas),
                      _boxField(context, 'Alamat', dtSantri!.alamat),
                    ],
                  )),
              Center(
                  child: MyButton(
                type: 'outline',
                onTap: () async {
                  if (checkIsNoValidEmail(dtSantri!.email)) {
                    setState(() {
                      _handleTautkan(context);
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'anda sudah menautkan email anda, harap hubungi pengurus untuk mengganti!')));
                  }
                },
                btnText: 'Tautkan akun Google',
              )),
              verticalSpaceSmall,
              Center(
                  child: MyButton(
                type: 'outlineicon',
                icon: Icons.logout,
                onTap: () => {_keluar()},
                btnText: 'Keluar',
              )),
            ]));
  }

  void _handleTautkan(BuildContext ctx) async {
    try {
      Map<String, dynamic> resTautan = await Auth().tautkanGoogle();
      resTautan["fcm_token"] = fcmToken ?? '-';
      Santri santri = await GetData().updateUUID(widget.idSantri, resTautan);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Berhasil menautkan akun ${santri.namaSantri}')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Gagal menautkan akun!')));
    }
  }

  void _keluar() async {
    await Auth().signOut();
    await box.delete('id');
    await box.delete('uuid');
    await box.delete('username');
    Navigator.pushNamedAndRemoveUntil(
        context, '/login-screen', (route) => false);
  }

  Widget _boxField(BuildContext context, String txt1, String? txt2) {
    return Material(
      color: lightv1,
      child: Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: greenv1))),
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              txt1,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  color: greenv3),
            ),
            const SizedBox(width: 10),
            Text(
              txt2!,
              style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: greenv2),
            )
          ],
        ),
      ),
    );
  }
}
