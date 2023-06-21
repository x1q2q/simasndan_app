import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/my_text_field.dart';
import '../components/my_button.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                      height: 560,
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
                                    onChanged: (() => {}),
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
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen()))
                                    },
                                    btnText: 'Masuk',
                                  )),
                                  verticalSpaceXSmall,
                                  Center(
                                      child: MyButton(
                                    type: 'outlineicon',
                                    icon: Icons.store,
                                    onTap: () => {},
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
}
