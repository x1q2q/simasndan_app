import 'package:flutter/material.dart';
import '../components/def_appbar.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../../core/api.dart';
import '../../providers/models/berita.dart';
import '../../providers/services/get_data.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DetailBeritaScreen extends StatefulWidget {
  final String? idBerita;
  const DetailBeritaScreen({super.key, this.idBerita});

  @override
  State<DetailBeritaScreen> createState() => _DetailBeritaScreenState();
}

class _DetailBeritaScreenState extends State<DetailBeritaScreen> {
  final _longTxt =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

  final GetData getData = GetData();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isLoading = true;

  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
    _getData();
  }

  Berita? dtBerita;
  _getData() async {
    dtBerita = await getData.detailBerita(widget.idBerita);
    _isLoading = false;
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

  Widget konten(BuildContext ctx) {
    var screenSizes = MediaQuery.of(ctx).size;
    String tglBerita(String tgl) {
      return DateFormat("EEEE, d MMMM yyyy", "id_ID")
          .format(DateTime.parse(tgl))
          .toString();
    }

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              strokeWidth: 5,
              color: greenv3,
            ),
          )
        : ListView(shrinkWrap: true, reverse: false, children: <Widget>[
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 35, horizontal: 25),
                child: Text(dtBerita!.judul, style: Styles.headStyle)),
            const Divider(
              color: orangev3,
              thickness: 1,
              height: 0,
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
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
                              text: ' by ${dtBerita!.penulis} ',
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: SizedBox(
                    height: 280,
                    width: screenSizes.width,
                    child: (dtBerita!.media == null)
                        ? Image.network(
                            "${Api.baseURL}/assets/img/no-image.png",
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            "${Api.baseURL}/assets/img/uploads/berita/${dtBerita!.media!['nama']}",
                            fit: BoxFit.cover))),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Text(
                dtBerita!.isi,
                overflow: TextOverflow.ellipsis,
                maxLines: 250,
                textAlign: TextAlign.justify,
              ),
            )
          ]);
  }
}
