import 'package:flutter/material.dart';
import '../components/def_appbar.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/my_button.dart';

class NotifikasiScreen extends StatefulWidget {
  const NotifikasiScreen({super.key, this.idSantri});
  final String? idSantri;

  @override
  State<NotifikasiScreen> createState() => _NotifikasiScreenState();
}

class _NotifikasiScreenState extends State<NotifikasiScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: const DefAppBar(title: "Semua Notifikasi"),
            backgroundColor: Colors.white,
            body: ListView(shrinkWrap: true, reverse: false, children: <Widget>[
              _boxNotif(context),
              _boxNotif(context),
              _boxNotif(context),
              _boxNotif(context),
              _boxNotif(context),
              _boxNotif(context),
              _boxNotif(context),
              _boxNotif(context),
            ])));
  }

  Widget _boxNotif(BuildContext context) {
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
              children: [
                const CircleAvatar(
                    radius: 24,
                    foregroundColor: orangev1,
                    backgroundImage: NetworkImage(
                        'https://aniyuki.com/wp-content/uploads/2023/04/aniyuki-muichiro-tokito-avatar-10.jpg')),
                const SizedBox(width: 10),
                const Flexible(
                    child: Text(
                  maxLines: 2,
                  softWrap: true,
                  'Pengurus1 telah membuat jadwal "Piket Bulanan"',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500),
                )),
                const SizedBox(width: 10),
                IconButton(
                  iconSize: 30,
                  color: greenv1,
                  icon: const Icon(Icons.note_alt_rounded),
                  onPressed: () => {},
                )
              ],
            ),
          )),
    );
  }
}
