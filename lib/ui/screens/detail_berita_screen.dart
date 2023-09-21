import 'package:flutter/material.dart';
import '../components/def_appbar.dart';
import '../components/my_button.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../../core/api.dart';
import '../../providers/models/berita.dart';
import '../../providers/services/get_data.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../components/skeleton.dart';
import '../components/svg.dart';

class DetailBeritaScreen extends StatefulWidget {
  final String? idBerita;
  const DetailBeritaScreen({super.key, this.idBerita});

  @override
  State<DetailBeritaScreen> createState() => _DetailBeritaScreenState();
}

class _DetailBeritaScreenState extends State<DetailBeritaScreen> {
  final GetData getData = GetData();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
    _getData();
  }

  Berita? dtBerita;
  _getData() async {
    _isLoading = true;
    dtBerita = await getData.detailBerita(widget.idBerita).catchError((e) {
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
                  _getData();
                },
                child: konten(context))));
  }

  String tglBerita(String tgl) {
    return DateFormat("EEEE, d MMMM yyyy", "id_ID")
        .format(DateTime.parse(tgl))
        .toString();
  }

  Widget konten(BuildContext ctx) {
    return _isLoading
        ? Skeleton.shimmerDetailNews
        : (dtBerita != null)
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
    var screenSizes = MediaQuery.of(ctx).size;
    return ListView(shrinkWrap: true, reverse: false, children: <Widget>[
      Container(
          padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 25),
          child: Text(dtBerita!.judul, style: Styles.headStyle)),
      const Divider(
        color: orangev3,
        thickness: 1,
        height: 0,
      ),
      Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text.rich(
                TextSpan(
                  children: [
                    const WidgetSpan(
                        child: Icon(
                      Icons.person,
                      size: 18,
                      color: orangev3,
                    )),
                    TextSpan(
                        text: ' oleh ${dtBerita!.penulis} ',
                        style: const TextStyle(
                          fontSize: 14,
                          color: orangev3,
                        )),
                    const WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(
                          Icons.circle,
                          size: 8,
                          color: orangev3,
                        )),
                    TextSpan(
                        text: ' ${tglBerita(dtBerita!.tanggal)} ',
                        style: const TextStyle(
                          fontSize: 14,
                          color: orangev3,
                        ))
                  ],
                ),
              ),
              verticalSpaceSmall,
              Badge(
                backgroundColor: orangev3,
                largeSize: 20,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                label: Text(dtBerita!.kategori, style: Styles.badgeStyle),
              ),
            ],
          )),
      Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          color: Colors.black12,
          child: SizedBox(
              height: 300,
              width: screenSizes.width,
              child: (dtBerita!.media == null)
                  ? Svg.imgNotFoundPortrait
                  : Image.network(
                      "${Api.baseURL}/public/assets/img/uploads/berita/${dtBerita!.media!['nama']}",
                      fit: BoxFit.contain))),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Text(
          dtBerita!.isi,
          overflow: TextOverflow.ellipsis,
          maxLines: 500,
          textAlign: TextAlign.justify,
        ),
      )
    ]);
  }
}
