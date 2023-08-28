import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';

class BoxJadwal extends StatelessWidget {
  final String tglNow;
  final String? fullLoc;
  final List? dataJadwal;
  const BoxJadwal(
      {Key? key,
      required this.tglNow,
      required this.fullLoc,
      required this.dataJadwal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        color: orangev2,
        child: ListView(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(tglNow, style: Styles.whiteStyle),
              ),
              ListView.builder(
                  itemCount: dataJadwal!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    return Container(
                      decoration: const BoxDecoration(
                          color: greyv1,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        trailing: const Icon(Icons.mosque_outlined,
                            size: 45, color: orangev3),
                        title: Text(dataJadwal?[index].title,
                            style: Styles.headStyle),
                        subtitle: Text(dataJadwal?[index].waktu,
                            style: Styles.labelTxtStyle2),
                      ),
                    );
                  }),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: Text.rich(TextSpan(
                    children: [
                      const WidgetSpan(
                          child: Icon(
                        Icons.location_pin,
                        size: 18,
                        color: Colors.white,
                      )),
                      TextSpan(text: fullLoc ?? '', style: Styles.whiteStyle),
                    ],
                  ))),
            ]));
  }
}
