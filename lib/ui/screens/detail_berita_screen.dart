import 'package:flutter/material.dart';
import '../components/def_appbar.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/my_button.dart';

class DetailBeritaScreen extends StatefulWidget {
  const DetailBeritaScreen({super.key, this.idBerita});
  final String? idBerita;

  @override
  State<DetailBeritaScreen> createState() => _DetailBeritaScreenState();
}

class _DetailBeritaScreenState extends State<DetailBeritaScreen> {
  final _longTxt =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  @override
  Widget build(BuildContext context) {
    var screenSizes = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
            appBar: const DefAppBar(title: ""),
            backgroundColor: Colors.white,
            body: ListView(shrinkWrap: true, reverse: false, children: <Widget>[
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 35, horizontal: 25),
                  child: const Text(
                      'Judul Berita Satu dengan paragraf pertama yang sangat berantakan',
                      style: Styles.headStyle)),
              const Divider(
                color: orangev3,
                thickness: 1,
                height: 0,
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                                child: Icon(
                              Icons.person,
                              size: 18,
                              color: orangev3,
                            )),
                            TextSpan(
                                text: ' by admin ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: orangev3,
                                )),
                            WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Icon(
                                  Icons.circle,
                                  size: 8,
                                  color: orangev3,
                                )),
                            TextSpan(
                                text: ' Kamis, 29 Juni 2023 ',
                                style: TextStyle(
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
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        label: Text('pengumuman', style: Styles.badgeStyle),
                      ),
                    ],
                  )),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: SizedBox(
                    height: 280,
                    width: screenSizes.width,
                    child: Image.asset(
                      "assets/images/luffyeeeh.jpg",
                      fit: BoxFit.cover,
                    ),
                  )),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Text(
                  _longTxt + _longTxt + _longTxt,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 250,
                  textAlign: TextAlign.justify,
                ),
              )
            ])));
  }
}
