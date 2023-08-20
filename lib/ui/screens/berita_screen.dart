import 'package:flutter/material.dart';
import '../components/def_appbar.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../../core/api.dart';
import '../../providers/services/get_data.dart';
import 'detail_berita_screen.dart';

class BeritaScreen extends StatefulWidget {
  const BeritaScreen({Key? key}) : super(key: key);

  @override
  State<BeritaScreen> createState() => _BeritaScreenState();
}

enum KategoriFilter { artikel, pengumuman, jadwal }

class _BeritaScreenState extends State<BeritaScreen> {
  final GetData getData = GetData();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isLoading = true;

  Set<KategoriFilter> filters = <KategoriFilter>{};
  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List? allBerita;
  _getData() async {
    allBerita = await getData.allBerita();
    _isLoading = false;
    setState(() {});
  }

  _getFilter(String filter) async {
    allBerita = await getData.filteredBerita(filter);
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const DefAppBar(title: "Semua Berita"),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            _getData();
            filters = <KategoriFilter>{};
          },
          child: _boxBerita(context)),
    ));
  }

  Widget _boxBerita(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              strokeWidth: 5,
              color: greenv3,
            ),
          )
        : SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 5.0,
                  children:
                      KategoriFilter.values.map((KategoriFilter kategori) {
                    return FilterChip(
                      side: const BorderSide(color: orangev3),
                      checkmarkColor: orangev3,
                      selectedColor: orangev1,
                      label: Text(
                        kategori.name,
                        style: Styles.filterStyle,
                      ),
                      selected: filters.contains(kategori),
                      onSelected: (bool selected) async {
                        setState(() {
                          if (selected) {
                            _getFilter(kategori.name);
                            filters = <KategoriFilter>{kategori};
                          } else {
                            filters.remove(kategori);
                            if (filters.isEmpty) {
                              _getData();
                            }
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                  child: ListView.builder(
                      itemCount: allBerita!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        return Material(
                            color: lightv1,
                            child: InkWell(
                                onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailBeritaScreen(
                                                    idBerita: allBerita![index]
                                                            ['id']
                                                        .toString(),
                                                  )))
                                    },
                                splashColor: lightv2,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(color: greenv1))),
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              maxLines: 2,
                                              "${allBerita![index]['judul']}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  fontFamily: 'Poppins',
                                                  color: Colors.black87),
                                            ),
                                            verticalSpaceXSmall,
                                            Row(children: <Widget>[
                                              Badge(
                                                backgroundColor: greenv3,
                                                largeSize: 20,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                label: Text(
                                                    "${allBerita![index]['kategori']}",
                                                    style: Styles.badgeStyle),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                  child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    const WidgetSpan(
                                                        child: Icon(
                                                      Icons.person,
                                                      size: 14,
                                                      color: greenv3,
                                                    )),
                                                    TextSpan(
                                                        text:
                                                            ' by ${allBerita![index]['penulis']}',
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: greenv3,
                                                            fontStyle: FontStyle
                                                                .italic)),
                                                  ],
                                                ),
                                              ))
                                            ]),
                                            Text(
                                              maxLines: 2,
                                              softWrap: true,
                                              "${allBerita![index]['isi']}",
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black54),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: (allBerita![index]['media'] ==
                                                null)
                                            ? Image.network(
                                                "${Api.baseURL}/assets/img/no-image.png")
                                            : Image.network(
                                                "${Api.baseURL}/assets/img/uploads/berita/${allBerita![index]['media']['nama']}"),
                                      ),
                                    ],
                                  ),
                                )));
                      })),
              verticalSpaceSmall
            ]));
  }
}
