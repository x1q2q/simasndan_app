import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/my_text_field.dart';
import '../components/my_button.dart';
import '../components/base_alert.dart';
import '../../providers/services/get_data.dart';
import '../../core/auth.dart';
import '../../providers/models/santri.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GetData getData = GetData();
  late final Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box('user');
  }

  @override
  Widget build(BuildContext context) {
    var screenSizes = MediaQuery.of(context).size;

    _checkNama(BuildContext ctx) async {
      await showDialog(
          context: ctx,
          builder: (BuildContext context) {
            return BaseAlert(
              bgColor: orangev1,
              title: "Peringatan!",
              msg: "Username atau password masih kosong!",
              onTap: () => Navigator.pop(context),
            );
          });
    }

    return SafeArea(
        child: GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: lightv2,
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              verticalSpaceLarge,
              verticalSpaceLarge,
              CircleAvatar(
                backgroundColor: orangev2,
                radius: 90,
                child: Container(
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            alignment: Alignment.center,
                            fit: BoxFit.fill,
                            image:
                                AssetImage('assets/images/logo_pondok.png')))),
              ),
              verticalSpaceXSmall,
              const Text(
                "Simasndan Apps",
                style: Styles.headStyle,
              ),
              verticalSpaceLarge,
              Stack(
                children: [
                  Container(
                    height: 660,
                    decoration: const BoxDecoration(
                      color: lightv1,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [Styles.boxCardShdStyle],
                    ),
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Username",
                                style: Styles.labelTxtStyle,
                              ),
                              verticalSpaceXSmall,
                              MyTextField(
                                controller: usernameController,
                                hintText: "masukkan username",
                                obscureText: false,
                                icon: const Icon(Icons.person),
                              ),
                              verticalSpaceSmall,
                              const Text(
                                "Password",
                                style: Styles.labelTxtStyle,
                              ),
                              verticalSpaceXSmall,
                              MyTextField(
                                controller: passwordController,
                                hintText: "**************",
                                obscureText: true,
                                icon: const Icon(Icons.remove_red_eye_sharp),
                              ),
                              verticalSpaceXSmall,
                              Row(
                                children: [
                                  const Text("Lupa password?",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: greyv2)),
                                  TextButton(
                                    child: const Text(
                                      "Kontak Pengurus",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: greenv3),
                                    ),
                                    onPressed: () async => {_kontakPengurus()},
                                  ),
                                ],
                              ),
                              verticalSpaceMedium,
                              Center(
                                  child: MyButton(
                                type: 'elevicon',
                                icon: Icons.login,
                                onTap: () async => {
                                  _submit(context, usernameController.text,
                                      passwordController.text)
                                },
                                btnText: 'Masuk',
                              )),
                              verticalSpaceXSmall,
                              Center(
                                  child: MyButton(
                                type: 'outline',
                                onTap: () async => {_signInGoogle(context)},
                                btnText: 'Masuk dengan Google',
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> _kontakPengurus() async {
    var urlWaPengurus =
        "whatsapp://send?phone=6285714186920&text=Permisi kak, mohon untuk bantu reset password atas nama ...";
    if (await canLaunchUrl(Uri.parse(urlWaPengurus))) {
      await launchUrl(Uri.parse(urlWaPengurus));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Whatsapp tidak terinstall")));
    }
  }

  void _signInGoogle(BuildContext ctx) async {
    bool resSubmit;

    resSubmit = await Auth().signInWithGoogle();
    if (resSubmit) {
      String uuid = await Auth().getUUID();
      Santri? santriLogin = await GetData().checkUUID(uuid);
      if (santriLogin != null) {
        Navigator.of(ctx).popAndPushNamed("/home-screen");
        await box.put('id', santriLogin!.id);
        await box.put('uuid', santriLogin!.uuid);
        await box.put('username', santriLogin!.username);
        await _showMsg(
            ctx, true, "Anda sukses login ${santriLogin!.namaSantri}!");
      } else {
        await Auth().signOut();
        await _showMsg(ctx, false, "Gagal login. User belum ditautkan");
      }
    } else {
      await _showMsg(ctx, false, "Gagal login. User tidak ditemukan!");
    }
  }

  void _submit(BuildContext ctx, String username, String password) async {
    print('submit');
    Map<String, dynamic> resSubmit = {"success": bool, "data": Santri};
    Map<String, dynamic> dataField = {
      'username': username,
      'password': password
    };
    resSubmit = await getData.login(dataField);
    if (resSubmit["success"]) {
      Santri santriLogin = resSubmit["data"];
      await box.put('id', santriLogin.id);
      await box.put('uuid', santriLogin.uuid ?? '-');
      await box.put('username', santriLogin.username);
      Navigator.of(ctx).popAndPushNamed("/home-screen");

      await _showMsg(ctx, true, "Anda sukses login ${santriLogin.namaSantri}!");
    } else {
      await _showMsg(ctx, false, "Gagal login. User tidak ditemukan!");
    }
  }

  _showMsg(BuildContext ctx, bool isSukses, String msg) async {
    await showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return BaseAlert(
            bgColor: (isSukses) ? lightv2 : orangev2,
            title: (isSukses) ? 'Berhasil!' : 'Error!',
            msg: msg,
            onTap: () => {Navigator.of(context).pop()},
          );
        });
  }
}
