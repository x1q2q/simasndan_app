import 'package:flutter/material.dart';
import '../components/def_appbar.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/my_button.dart';

class DetailMateriScreen extends StatefulWidget {
  const DetailMateriScreen({super.key, this.idMateri});
  final String? idMateri;

  @override
  State<DetailMateriScreen> createState() => _DetailMateriScreenState();
}

class _DetailMateriScreenState extends State<DetailMateriScreen> {
  final _longTxt =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  @override
  Widget build(BuildContext context) {
    var screenSizes = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            appBar: const DefAppBar(title: ""),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                child: Column(children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(25),
                  child: const Row(
                    children: <Widget>[
                      Expanded(
                          child: Text("Kitab Hadits Arbain Nawawi",
                              style: Styles.headStyle)),
                      IconButton(
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
                        minHeight: screenSizes.height,
                        maxHeight: double.infinity),
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
                                      left: BorderSide(
                                          color: orangev3, width: 3))),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 8.0),
                              child: const Text("Ikhtisar Materi",
                                  style: Styles.labelTxtStyle2)),
                          verticalSpaceSmall,
                          Text(
                            _longTxt,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 250,
                            textAlign: TextAlign.justify,
                          ),
                          verticalSpaceSmall,
                          MyButton(
                              type: 'outlineicon',
                              icon: Icons.download,
                              onTap: () {},
                              btnText: "Download Materi"),
                        ]))
              ]),
            ]))));
  }
}
