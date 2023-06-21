import 'package:flutter/material.dart';
import '../components/def_appbar.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/my_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: const DefAppBar(title: "Profil"),
            backgroundColor: Colors.white,
            body: ListView(
                padding: const EdgeInsets.symmetric(vertical: 40),
                shrinkWrap: true,
                reverse: false,
                children: <Widget>[
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
                                image: AssetImage('assets/images/giyu.jpg')))),
                  ),
                  verticalSpaceSmall,
                  const Center(
                      child: Text("@rizkimmi", style: Styles.headStyle)),
                  verticalSpaceSmall,
                  Center(
                      child: MyButton(
                    type: 'elevicon',
                    icon: Icons.edit,
                    onTap: () => {},
                    btnText: 'Edit Profil',
                  )),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Column(
                        children: <Widget>[
                          _boxField(context, 'Nama', 'Rizqi Umami'),
                          _boxField(context, 'Tingkatan', 'Wustho'),
                          _boxField(context, 'TTL', 'Kebumen, 05 Juni 2000'),
                          _boxField(context, 'Pendidikan', 'S2 Matematika UNS'),
                          _boxField(context, 'Alamat', 'Jl. Kebumen Raya'),
                        ],
                      )),
                  Center(
                      child: MyButton(
                    type: 'outlineicon',
                    icon: Icons.logout,
                    onTap: () => {},
                    btnText: 'Keluar',
                  )),
                ])));
  }

  Widget _boxField(BuildContext context, String txt1, String txt2) {
    return Material(
      color: lightv1,
      child: Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: greenv1))),
        padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
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
              txt2,
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
