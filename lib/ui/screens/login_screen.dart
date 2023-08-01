import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/my_text_field.dart';
import '../components/my_button.dart';
import '../components/base_alert.dart';
import 'home_screen.dart';
import '../../providers/services/get_data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final GetData getData = GetData();

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
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: lightv2,
        body: ListView(
          padding: const EdgeInsets.only(top: 100),
          shrinkWrap: true,
          reverse: true,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                verticalSpaceMedium,
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
                              image: AssetImage(
                                  'assets/images/logo_pondok.png')))),
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
                      height: screenSizes.height / 1.6,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: lightv1,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                                    icon:
                                        const Icon(Icons.remove_red_eye_sharp),
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
                                        onPressed: () => {},
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
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return BaseAlert(
                                              bgColor: lightv2,
                                              title: "Informasi",
                                              msg:
                                                  "Fitur ini tersedia nanti yaa hehe :D",
                                              onTap: () =>
                                                  Navigator.pop(context),
                                            );
                                          });
                                    },
                                    btnText: 'Masuk dengan Google',
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _submit(BuildContext ctx, String username, String password) async {
    bool resSubmit;
    Map<String, dynamic> dataField = {
      'username': username,
      'password': password
    };
    resSubmit = await getData.login(dataField);
    if (resSubmit) {
      Navigator.of(ctx).pushNamed("/home-screen");
      _showMsg(ctx, true, "Anda sukses login!");
    } else {
      _showMsg(ctx, false, "Gagal login. User tidak ditemukan!");
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
