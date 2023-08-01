import 'package:flutter/material.dart';
import 'dart:io';
import '../components/def_appbar.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/my_button.dart';
import '../components/base_alert.dart';
import '../components/profil_text_field.dart';
import '../../core/api.dart';
import '../../providers/models/santri.dart';
import '../../providers/services/get_data.dart';
import 'package:image_picker/image_picker.dart';
import '../../ui/components/menu_button.dart';

class EditProfilScreen extends StatefulWidget {
  final String? idSantri;
  const EditProfilScreen({super.key, this.idSantri});

  @override
  State<EditProfilScreen> createState() => _EditProfilScreenState();
}

class _EditProfilScreenState extends State<EditProfilScreen> {
  final namaCtrl = TextEditingController();
  final tmptLahirCtrl = TextEditingController();
  final univCtrl = TextEditingController();
  final alamatCtrl = TextEditingController();
  final tglLahirCtrl = TextEditingController();

  final GetData getData = GetData();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isLoading = true;
  bool btnPhotoPressed = false;

  XFile? image;
  File? filePhoto;

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
      filePhoto = File(image!.path);
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Santri? dtSantri;
  _getData() async {
    dtSantri = await getData.detailSantri(widget.idSantri);
    namaCtrl.text = dtSantri!.namaSantri;
    tmptLahirCtrl.text = dtSantri!.tempatLahir;
    tglLahirCtrl.text = dtSantri!.tglLahir;
    univCtrl.text = dtSantri!.universitas;
    alamatCtrl.text = dtSantri!.alamat;
    _isLoading = false;
    setState(() {});
  }

  void myAlert() {
    btnPhotoPressed = true;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: lightv2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Pilih media untuk diupload',
                style: Styles.labelTxtStyle),
            content: Container(
              height: 130,
              width: MediaQuery.of(context).size.width / 2,
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                children: <Widget>[
                  MenuButton(
                      btnTxt: "Galeri",
                      iconBtn: Icons.image,
                      typeBtn: 'btn1',
                      onTap: () {
                        Navigator.pop(context);
                        getImage(ImageSource.gallery);
                      }),
                  MenuButton(
                      btnTxt: "Kamera",
                      iconBtn: Icons.photo_camera,
                      typeBtn: 'btn3',
                      onTap: () {
                        Navigator.pop(context);
                        getImage(ImageSource.camera);
                      }),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: const DefAppBar(title: "Edit Profil"),
            backgroundColor: Colors.white,
            body: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () async {
                  _getData();
                },
                child: konten(context))));
  }

  Widget konten(BuildContext ctx) {
    bool checkIsValidImage(dynamic foto) {
      return (foto == null || foto == '-' || foto == '');
    }

    ImageProvider<Object> chooseImage(dynamic foto) {
      return (checkIsValidImage(foto))
          ? const NetworkImage("${Api.baseURL}/assets/img/no-image.png")
          : NetworkImage("${Api.baseURL}/assets/img/uploads/santri/${foto}");
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
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: orangev2,
                      radius: 70,
                      child: (btnPhotoPressed && image != null)
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                File(image!.path),
                                fit: BoxFit.cover,
                                height: 120,
                                width: 120,
                              ),
                            )
                          : Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                  image: DecorationImage(
                                      alignment: Alignment.center,
                                      fit: BoxFit.cover,
                                      image: chooseImage(dtSantri!.foto)))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        left: 80,
                        child: CircleAvatar(
                            backgroundColor: greenv2,
                            child: IconButton(
                                iconSize: 25,
                                color: Colors.white,
                                icon: const Icon(Icons.photo_camera),
                                onPressed: () {
                                  myAlert();
                                }))),
                  ],
                ),
                verticalSpaceXSmall,
                Center(
                    child: Text('@${dtSantri!.username}',
                        style: Styles.headStyle)),
                verticalSpaceSmall,
                _fieldInput(context, "Nama", "", namaCtrl, false, false),
                _fieldInput(
                    context, "Tempat Lahir", "", tmptLahirCtrl, false, false),
                _fieldInput(
                    context, "Tanggal Lahir", "", tglLahirCtrl, false, true),
                _fieldInput(context, "Pendidikan", "", univCtrl, false, false),
                _fieldInput(context, "Alamat", "", alamatCtrl, true, false),
                verticalSpaceSmall,
                Center(
                    child: MyButton(
                  type: 'elevicon',
                  icon: Icons.save,
                  onTap: () async => {_saveData(context, dtSantri!)},
                  btnText: 'Simpan',
                )),
              ]);
  }

  Widget _fieldInput(BuildContext context, String label, String hint,
      TextEditingController ctrlr, bool isTxtArea, bool isInputDate) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: Styles.labelTxtStyle,
            ),
            verticalSpaceXSmall,
            ProfilTextField(
              controller: ctrlr,
              hintText: hint,
              textArea: isTxtArea,
              inputDate: isInputDate,
            ),
          ],
        ));
  }

  void _saveData(BuildContext ctx, Santri newSantri) async {
    bool resSubmit;
    Map<String, dynamic> dataField = {
      'id': newSantri.id,
      'username': newSantri.username,
      'nama_santri': namaCtrl.text,
      'tingkatan': newSantri.tingkatan,
      'tempat_lahir': tmptLahirCtrl.text,
      'tgl_lahir': tglLahirCtrl.text,
      'is_pengurus': newSantri.isPengurus,
      'universitas': univCtrl.text,
      'alamat': alamatCtrl.text
    };
    final dtSantri = Santri.fromMap(dataField);
    String idSantri = dataField['id'];
    resSubmit = await getData.updateProfil(
        dtSantri, idSantri, filePhoto!, filePhoto!.path.split('/').last);
    if (resSubmit) {
      _showMsg(ctx, true, "Sukses memperbarui profil!");
    } else {
      _showMsg(ctx, false, "Gagal memperbarui profil!");
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
            onTap: () => {Navigator.of(context).pushNamed("/home-screen")},
          );
        });
  }
}
