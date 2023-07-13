import 'package:flutter/material.dart';
import '../components/def_appbar.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/my_button.dart';
import 'edit_profil_screen.dart';
import '../../core/api.dart';
import '../../providers/models/santri.dart';
import '../../providers/services/get_data.dart';

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

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Santri? dtSantri;
  _getData() async {
    dtSantri = await getData.detailSantri(widget.idSantri);
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
    var screenSizes = MediaQuery.of(context).size;
    String sttsSantri(dynamic stts) {
      return (stts) ? 'Pengurus' : 'Santri Biasa';
    }

    bool checkIsValidImage(dynamic foto) {
      return (foto == null || foto == '-' || foto == '');
    }

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              strokeWidth: 5,
              color: greenv3,
            ),
          )
        : ListView(
            padding: const EdgeInsets.symmetric(vertical: 40),
            shrinkWrap: true,
            reverse: false,
            children: <Widget>[
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
                              image: (checkIsValidImage(dtSantri!.foto))
                                  ? const NetworkImage(
                                      "${Api.baseURL}/assets/img/no-image.png")
                                  : NetworkImage(
                                      "${Api.baseURL}/assets/img/uploads/santri/${dtSantri!.foto}")))),
                ),
                verticalSpaceSmall,
                Center(
                    child: Text('@${dtSantri!.username}',
                        style: Styles.headStyle)),
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
                        _boxField(context, 'Tingkatan', dtSantri!.tingkatan),
                        _boxField(context, 'Status',
                            sttsSantri(dtSantri!.isPengurus)),
                        _boxField(context, 'TTL',
                            '${dtSantri!.tempatLahir}, ${dtSantri!.tglLahir}'),
                        _boxField(context, 'Pendidikan', dtSantri!.universitas),
                        _boxField(context, 'Alamat', dtSantri!.alamat),
                      ],
                    )),
                Center(
                    child: MyButton(
                  type: 'outlineicon',
                  icon: Icons.logout,
                  onTap: () => {},
                  btnText: 'Keluar',
                )),
              ]);
  }

  Widget _boxField(BuildContext context, String txt1, String txt2) {
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
