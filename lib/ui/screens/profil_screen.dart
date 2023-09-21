import 'package:flutter/material.dart';
import '../components/def_appbar.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/my_button.dart';
import 'edit_profil_screen.dart';
import '../../core/api.dart';
import '../../providers/models/santri.dart';
import '../../providers/services/get_data.dart';
import '../../providers/services/auth_service.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../providers/services/messaging_service.dart';
import '../components/skeleton.dart';
import 'package:bot_toast/bot_toast.dart';
import '../../providers/services/general_service.dart';
import '../components/svg.dart';

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
  bool _isError = false;
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
    _isLoading = true;
    dtSantri = await getData.detailSantri(widget.idSantri).catchError((e) {
      _isLoading = false;
      _isError = true;
      return null;
    }).then((value) async {
      _isLoading = false;
      fcmToken = await _messagingService.getDeviceToken();
      return value;
    });
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
                  setState(() {
                    _getData();
                  });
                },
                child: konten(context))));
  }

  Widget konten(BuildContext ctx) {
    return _isLoading
        ? Skeleton.shimmerProfil
        : (dtSantri != null)
            ? listKonten(context)
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

  Widget listKonten(BuildContext ctx) {
    bool checkIsNoValidEmail(String? email) {
      return (email == null || email == '-' || email == '');
    }

    String sttsSantri(dynamic stts) {
      return (stts) ? 'Pengurus' : 'Santri Biasa';
    }

    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          CircleAvatar(
            backgroundColor: orangev2,
            radius: 70,
            child: GeneralService().checkisNoValidImage(dtSantri!.foto)
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: dtSantri!.jenisKelamin == 'perempuan'
                        ? Svg.imgFemaleProfile
                        : Svg.imgMaleProfile)
                : Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        image: DecorationImage(
                            alignment: Alignment.center,
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "${Api.baseURL}/public/assets/img/uploads/santri/${dtSantri!.foto}")))),
          ),
          verticalSpaceSmall,
          Center(
              child: Text('@${dtSantri!.username}', style: Styles.headStyle)),
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
                GeneralService().showNotifTitle("Tautkan akun Google",
                    'anda sudah menautkan email anda, harap hubungi pengurus untuk mengganti!');
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
      Map<String, dynamic> resTautan = await AuthService().tautkanGoogle();
      resTautan["fcm_token"] = fcmToken ?? '-';
      Santri? santri = await GetData().updateUUID(widget.idSantri, resTautan);
      if (resTautan["uuid"] != null && resTautan["email"] != null) {
        await GeneralService()
            .showNotif(true, 'Anda berhasil menautkan akun ${santri!.email}');
        await GeneralService().checkPermission('notifikasi');
        await _getData();
      } else {
        await GeneralService()
            .showNotif(false, 'Silakan pilih akun untuk ditautkan!');
      }
    } catch (e) {
      GeneralService().showNotif(false, 'Anda gagal menautkan akun!');
    }
  }

  void _keluar() async {
    var loader = BotToast.showLoading();
    Map<String, dynamic> resTautan = {
      "uuid": null,
      "email": null,
      "fcm_token": null
    };
    await GetData().updateUUID(widget.idSantri, resTautan);

    await AuthService().signOut();
    await box.delete('id');
    await box.delete('uuid');
    await box.delete('username');
    await box.delete('kab');
    await box.delete('location');
    await box.delete('full_location');

    Future.delayed(Duration(seconds: 2), () async {
      loader();
      await Navigator.pushNamedAndRemoveUntil(
          context, '/login-screen', (route) => false);
    });
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
