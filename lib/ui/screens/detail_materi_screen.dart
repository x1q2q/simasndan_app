import 'package:flutter/material.dart';
import '../components/def_appbar.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/my_button.dart';
import '../../providers/models/materi.dart';
import '../../providers/services/get_data.dart';
import 'webview_screen.dart';
import '../components/skeleton.dart';
import '../components/svg.dart';

class DetailMateriScreen extends StatefulWidget {
  final String? idMateri;
  const DetailMateriScreen({super.key, this.idMateri});

  @override
  State<DetailMateriScreen> createState() => _DetailMateriScreenState();
}

class _DetailMateriScreenState extends State<DetailMateriScreen> {
  final GetData getData = GetData();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Materi? dtMateri;
  _getData() async {
    _isLoading = true;
    dtMateri = await getData.detailMateri(widget.idMateri).catchError((e) {
      _isLoading = false;
      _isError = true;
      return null;
    }).then((value) {
      _isLoading = false;
      return value;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const DefAppBar(title: ""),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            setState(() {
              _getData();
            });
          },
          child: konten(context)),
    ));
  }

  Widget konten(BuildContext ctx) {
    return _isLoading
        ? Skeleton.shimmerDetailTimeline
        : (dtMateri != null)
            ? listKonten(ctx)
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
    var screenSizes = MediaQuery.of(context).size;
    return ListView(children: <Widget>[
      Container(
          padding: const EdgeInsets.all(25),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(dtMateri!.nama, style: Styles.headStyle),
                  Text('kode: ${dtMateri!.kode}',
                      style: const TextStyle(
                          color: orangev3,
                          fontWeight: FontWeight.normal,
                          fontSize: 16)),
                ],
              )),
              const IconButton(
                iconSize: 80,
                icon: Icon(
                  Icons.image,
                  color: orangev3,
                ),
                onPressed: null,
              )
            ],
          )),
      Stack(children: [
        Container(
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
            constraints: BoxConstraints(
                minHeight: screenSizes.height, maxHeight: double.infinity),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: orangev1,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              left: BorderSide(color: orangev3, width: 3))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 8.0),
                      child: const Text("Ikhtisar Materi",
                          style: Styles.labelTxtStyle2)),
                  verticalSpaceSmall,
                  Text(
                    dtMateri!.deskripsi,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 250,
                    textAlign: TextAlign.justify,
                  ),
                  verticalSpaceSmall,
                  MyButton(
                      type: 'outlineicon',
                      icon: Icons.download,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WebviewScreen(urlWeb: dtMateri!.link)));
                      },
                      btnText: "Download Materi"),
                ]))
      ]),
    ]);
  }
}
