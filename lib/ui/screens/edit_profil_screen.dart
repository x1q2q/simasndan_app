import 'package:flutter/material.dart';
import 'dart:io';
import '../components/def_appbar.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/my_button.dart';
import '../components/profil_text_field.dart';
import '../../core/api.dart';
import '../../providers/models/santri.dart';
import '../../providers/services/get_data.dart';
import 'package:image_picker/image_picker.dart';
import '../../ui/components/menu_button.dart';
import '../components/skeleton.dart';
import 'package:bot_toast/bot_toast.dart';
import '../../providers/services/general_service.dart';
import '../components/svg.dart';

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
  bool _isError = false;
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
    _isLoading = true;
    dtSantri = await getData.detailSantri(widget.idSantri).catchError((e) {
      _isLoading = false;
      _isError = true;
      return null;
    }).then((value) {
      if (value != null) {
        namaCtrl.text = value.namaSantri;
        tmptLahirCtrl.text = value.tempatLahir;
        tglLahirCtrl.text = value.tglLahir ?? '';
        univCtrl.text = value.universitas;
        alamatCtrl.text = value.alamat;
      }
      _isLoading = false;
      return value;
    });

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
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
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
                    : GeneralService().checkisNoValidImage(dtSantri!.foto)
                        ? Padding(
                            padding: const EdgeInsets.all(10),
                            child: dtSantri!.jenisKelamin == 'perempuan'
                                ? Svg.imgFemaleProfile
                                : Svg.imgMaleProfile)
                        : Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                                image: DecorationImage(
                                    alignment: Alignment.center,
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "${Api.baseURL}/public/assets/img/uploads/santri/${dtSantri!.foto}")))),
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
              child: Text('@${dtSantri!.username}', style: Styles.headStyle)),
          verticalSpaceSmall,
          _fieldInput(context, "Nama", "", namaCtrl, false, false),
          _fieldInput(context, "Tempat Lahir", "", tmptLahirCtrl, false, false),
          _fieldInput(context, "Tanggal Lahir", "", tglLahirCtrl, false, true),
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
        ]));
  }

  Widget _fieldInput(BuildContext context, String? label, String hint,
      TextEditingController ctrlr, bool isTxtArea, bool isInputDate) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label!,
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
    var loader = BotToast.showLoading();
    Map<String, dynamic> dataField = {
      'id': newSantri.id,
      'username': newSantri.username,
      'jenis_kelamin': newSantri.jenisKelamin,
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
    resSubmit = await getData.updateProfil(dtSantri, idSantri, filePhoto);
    loader();
    if (resSubmit) {
      GeneralService()
          .showNotif(true, "Anda telah berhasil memperbarui profil!");
      Navigator.of(ctx).popAndPushNamed("/home-screen");
    } else {
      GeneralService().showNotif(
          false, "Anda gagal memperbarui profil. Silakan ulangi lagi!");
    }
  }
}
