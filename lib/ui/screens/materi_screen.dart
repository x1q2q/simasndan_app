import 'package:flutter/material.dart';
import '../components/def_appbar.dart';
import '../../core/ui_helper.dart';
import '../../core/api.dart';
import 'detail_materi_screen.dart';
import '../../providers/services/get_data.dart';
import '../components/skeleton.dart';
import '../components/my_button.dart';
import '../../providers/services/general_service.dart';
import '../components/svg.dart';

class MateriScreen extends StatefulWidget {
  const MateriScreen({Key? key}) : super(key: key);

  @override
  State<MateriScreen> createState() => _MateriScreenState();
}

class _MateriScreenState extends State<MateriScreen> {
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

  List? allMateri;
  _getData() async {
    _isLoading = true;
    allMateri = await getData.allMateri().catchError((e) {
      _isLoading = false;
      _isError = true;
      return [];
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
            appBar: const DefAppBar(title: "Semua Materi"),
            backgroundColor: Colors.white,
            body: Column(children: <Widget>[
              Expanded(
                flex: 1,
                child: RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: () async {
                      setState(() {
                        _getData();
                      });
                    },
                    child: boxMateri(context)),
              )
            ])));
  }

  Widget boxMateri(BuildContext ctx) {
    return _isLoading
        ? Skeleton.shimmerMateri
        : (allMateri!.isNotEmpty)
            ? listMateri(ctx)
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

  Widget listMateri(BuildContext ctx) {
    return ListView.builder(
        itemCount: allMateri!.length,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return Material(
            color: Colors.white,
            child: InkWell(
                splashColor: orangev2,
                onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailMateriScreen(
                                    idMateri:
                                        allMateri![index]['id'].toString(),
                                  )))
                    },
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: orangev3))),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: 120,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: (GeneralService().checkisNoValidImage(
                                  allMateri![index]['foto']))
                              ? Svg.imgNotFoundPortrait
                              : Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      image: DecorationImage(
                                          alignment: Alignment.center,
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "${Api.baseURL}/public/assets/img/uploads/materi/${allMateri![index]['foto']}"))))),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              maxLines: 2,
                              "${allMateri![index]['nama']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  color: orangev3),
                            ),
                            Text(
                              maxLines: 2,
                              softWrap: true,
                              "${allMateri![index]['deskripsi']}",
                              style: const TextStyle(
                                  fontSize: 13, color: orangev3),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
                      IconButton(
                        iconSize: 40,
                        color: orangev3,
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () => {},
                      )
                    ],
                  ),
                )),
          );
        });
  }
}
