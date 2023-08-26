import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/my_text_field.dart';
import '../components/my_button.dart';
import '../../providers/services/get_data.dart';
import '../../providers/services/auth_service.dart';
import '../../providers/models/santri.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bot_toast/bot_toast.dart';
import '../../providers/services/messaging_service.dart';
import '../../providers/services/general_service.dart';
import '../components/svg.dart';

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
  final _messagingService = MessagingService();

  @override
  void initState() {
    super.initState();
    box = Hive.box('user');
  }

  @override
  Widget build(BuildContext context) {
    var screenSizes = MediaQuery.of(context).size;

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
                child: Padding(
                    padding: EdgeInsets.all(15), child: Svg.imgLogoPondok),
              ),
              verticalSpaceXSmall,
              const Text(
                "Simasndan Apps",
                style: Styles.headStyle,
              ),
              verticalSpaceMedium,
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
                                  icon: Icon(Icons.visibility)),
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
                                  checkFieldLogin(
                                      context,
                                      usernameController.text,
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
      await GeneralService().showNotif(false, "Whatsapp tidak terinstall");
    }
  }

  void _signInGoogle(BuildContext ctx) async {
    bool resSubmit = false;

    resSubmit = await AuthService().signInWithGoogle();
    if (resSubmit) {
      String uuid = await AuthService().getUUID();
      Santri? santriLogin = await GetData().checkUUID(uuid);
      if (santriLogin != null) {
        String? fcmToken = await _messagingService.getDeviceToken();
        Map<String, dynamic> resTautan = {
          "uuid": null,
          "email": null,
          "fcm_token": fcmToken ?? '-'
        };
        await GetData().updateUUID(santriLogin.id, resTautan);

        await box.put('id', santriLogin.id);
        await box.put('uuid', santriLogin.uuid);
        await box.put('username', santriLogin.username);
        Navigator.of(ctx).popAndPushNamed("/home-screen");
        await GeneralService().showNotif(true,
            "Selamat datang, ${santriLogin.namaSantri}. Akun anda berhasil login !");
      } else {
        await AuthService().signOut();

        await GeneralService().showNotif(
            false, "Anda gagal login, akun google tidak terdaftar pada data");
      }
    } else {
      await GeneralService()
          .showNotif(false, "Anda gagal login, akun tidak ditemukan!");
    }
  }

  void checkFieldLogin(
      BuildContext ctx, String username, String password) async {
    if (username.isNotEmpty && password.isNotEmpty) {
      submitCredential(ctx, username, password);
    } else {
      if (username.isEmpty) {
        GeneralService().showNotif(false, "Username masih kosong");
      } else if (password.isEmpty) {
        GeneralService().showNotif(false, "Password masih kosong");
      } else {
        GeneralService().showNotif(false, "Username dan password masih kosong");
      }
    }
  }

  void submitCredential(
      BuildContext ctx, String username, String password) async {
    var loader = BotToast.showLoading();
    Map<String, dynamic> resSubmit = {"success": bool, "data": Santri};
    Map<String, dynamic> dataField = {
      'username': username,
      'password': password
    };
    resSubmit = await getData.login(dataField);
    loader();
    if (resSubmit["success"]) {
      Santri santriLogin = resSubmit["data"];
      await box.put('id', santriLogin.id);
      await box.put('uuid', santriLogin.uuid ?? '-');
      await box.put('username', santriLogin.username);

      Navigator.of(ctx).popAndPushNamed("/home-screen");
      await GeneralService().showNotif(true,
          "Selamat datang, ${santriLogin.namaSantri}. Akun anda berhasil login !");
    } else {
      await GeneralService()
          .showNotif(false, "Anda Gagal login. User tidak ditemukan!");
    }
  }
}
