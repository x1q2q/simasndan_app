import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/ui_helper.dart';

enum KategoriFilter { artikel, pengumuman, jadwal }

class Skeleton {
  static Widget shimmerAdhan = Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 160,
            height: 23,
            decoration: ShapeDecoration(
                color: Colors.grey[200]!,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
          verticalSpaceXSmall,
          Container(
            width: 220,
            height: 18,
            decoration: ShapeDecoration(
                color: Colors.grey[200]!,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
        ],
      ));

  static Widget shimmerNews = Shimmer.fromColors(
    baseColor: Colors.grey.shade400,
    highlightColor: Colors.grey.shade100,
    child: ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                    child: Container(
                  width: double.infinity,
                  height: 80,
                  decoration: ShapeDecoration(
                      color: Colors.grey[400]!,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                )),
                SizedBox(width: 10),
                SizedBox(
                    width: 150,
                    child: Container(
                      height: 100,
                      decoration: ShapeDecoration(
                          color: Colors.grey[400]!,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ))
              ],
            ));
      },
    ),
  );

  static Widget shimmerFilter = Shimmer.fromColors(
    baseColor: Colors.grey.shade400,
    highlightColor: Colors.grey.shade100,
    child: Wrap(
      alignment: WrapAlignment.center,
      spacing: 5.0,
      children: KategoriFilter.values.map((kategori) {
        return Container(
          width: 90,
          height: 30,
          decoration: ShapeDecoration(
              color: Colors.grey[400]!,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)))),
        );
      }).toList(),
    ),
  );

  static Widget shimmerMateri = Shimmer.fromColors(
    baseColor: Colors.grey.shade400,
    highlightColor: Colors.grey.shade100,
    child: ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                    width: 120,
                    child: Container(
                      height: 120,
                      decoration: ShapeDecoration(
                          color: Colors.grey[400]!,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    )),
                SizedBox(width: 10),
                Flexible(
                    child: Container(
                  width: double.infinity,
                  height: 80,
                  decoration: ShapeDecoration(
                      color: Colors.grey[400]!,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                )),
              ],
            ));
      },
    ),
  );
  static Widget shimmerRekap = Shimmer.fromColors(
    baseColor: Colors.grey.shade400,
    highlightColor: Colors.grey.shade100,
    child: ListView.builder(
      itemCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                    width: 70,
                    child: Container(
                      height: 70,
                      decoration: ShapeDecoration(
                          color: Colors.grey[400]!,
                          shape: const CircleBorder()),
                    )),
                SizedBox(width: 10),
                Flexible(
                    child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: ShapeDecoration(
                      color: Colors.grey[400]!,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100)))),
                )),
              ],
            ));
      },
    ),
  );

  static Widget shimmerProfil = Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          verticalSpaceLarge,
          SizedBox(
            width: 120,
            child: Container(
              height: 120,
              decoration: ShapeDecoration(
                  color: Colors.grey[400]!, shape: const CircleBorder()),
            ),
          ),
          verticalSpaceMedium,
          Container(
            width: 140,
            height: 26,
            decoration: ShapeDecoration(
                color: Colors.grey[400]!,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)))),
          ),
          verticalSpaceLarge,
          verticalSpaceSmall,
          Expanded(
              child: ListView.builder(
                  itemCount: 7,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    return Container(
                      width: double.infinity,
                      height: 50,
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      decoration: ShapeDecoration(
                          color: Colors.grey[400]!,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    );
                  }))
        ],
      ));
  static Widget shimmerNotif = Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade100,
      child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              verticalSpaceXSmall,
              Container(
                height: 30,
                width: 190,
                decoration: ShapeDecoration(
                    color: Colors.grey[400]!,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)))),
              ),
              verticalSpaceXSmall,
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                              width: 60,
                              child: Container(
                                height: 60,
                                decoration: ShapeDecoration(
                                    color: Colors.grey[400]!,
                                    shape: const CircleBorder()),
                              )),
                          SizedBox(width: 10),
                          Flexible(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 20,
                                decoration: ShapeDecoration(
                                    color: Colors.grey[400]!,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)))),
                              ),
                              verticalSpaceXSmall,
                              Container(
                                height: 15,
                                decoration: ShapeDecoration(
                                    color: Colors.grey[400]!,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)))),
                              ),
                            ],
                          )),
                        ],
                      ));
                },
              ),
            ],
          )));
  static Widget shimmerDetailNews = Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade100,
      child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 270,
                height: 30,
                decoration: ShapeDecoration(
                    color: Colors.grey[400]!,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)))),
              ),
              verticalSpaceMedium,
              verticalSpaceSmall,
              Container(
                width: 310,
                height: 14,
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: ShapeDecoration(
                    color: Colors.grey[400]!,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              verticalSpaceXSmall,
              Container(
                width: 60,
                height: 14,
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: ShapeDecoration(
                    color: Colors.grey[400]!,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              verticalSpaceSmall,
              SizedBox(
                child: Container(
                  height: 220,
                  decoration: ShapeDecoration(
                      color: Colors.grey[400]!,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
              verticalSpaceXSmall,
              Expanded(
                  child: ListView.builder(
                      itemCount: 6,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        return Container(
                          width: double.infinity,
                          height: 18,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: ShapeDecoration(
                              color: Colors.grey[400]!,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        );
                      }))
            ],
          )));

  static Widget shimmerDetailTimeline = Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade100,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                verticalSpaceMedium,
                verticalSpaceXSmall,
                Container(
                  width: 210,
                  height: 22,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: ShapeDecoration(
                      color: Colors.grey[400]!,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                Container(
                  width: 130,
                  height: 18,
                  decoration: ShapeDecoration(
                      color: Colors.grey[400]!,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                verticalSpaceLarge,
                verticalSpaceSmall,
                ListView.builder(
                    itemCount: 6,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return Container(
                        width: double.infinity,
                        height: 18,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: ShapeDecoration(
                            color: Colors.grey[400]!,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      );
                    })
              ],
            ),
          ])));

  static Widget shimmerJadwal = Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade100,
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
              itemCount: 6,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                return Container(
                  width: double.infinity,
                  height: 60,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: ShapeDecoration(
                      color: Colors.grey[400]!,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                );
              })));
}
