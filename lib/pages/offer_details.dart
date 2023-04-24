import 'dart:convert';

import 'package:appday/models/offerdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../models/homedata.dart';
import '../utils/remote_config.dart';

class OfferDetails extends StatefulWidget {
  final Homedata item;
  const OfferDetails({super.key, required this.item});

  @override
  State<OfferDetails> createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  List<Offerdata> offerdata = [];

  Future<List<Offerdata>> getdata() async {
    var offerjsondata =
        await FirebaseRemoteConfigClass().initializeConfigoffer();
    var data = jsonDecode(offerjsondata);
    for (var map in data) {
      offerdata.add(Offerdata.fromJson(map));
    }
    return offerdata;
  }

  @override
  Widget build(BuildContext context) {
    double rating = 0.0;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(CupertinoIcons.back),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text("Offer detail")),
      body: FutureBuilder(
          future: getdata(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return mainbody(offerdata, rating);
            }
          }),
    );
  }

  Column mainbody(List<Offerdata> offerdata, double rating) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.network(widget.item.thumbnail.toString()),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        widget.item.brand!.title.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Text(
                      widget.item.title.toString(),
                      softWrap: true,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RatingBar.builder(
                        initialRating: rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 30,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            rating = rating;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        //steps begin here
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Steps (1/3)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        // tasktile()
        Expanded(
          child: ListView.builder(
            itemCount: offerdata.length,
            itemBuilder: (context, index) {
              return tasktile(offerdata[index]);
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 10),
          child: Text(
            "\u26A1 ${widget.item.totalLead} useres has already participated",
            style: TextStyle(color: Colors.amber),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fixedSize: Size(Get.width * 0.9, 50)),
              onPressed: () {},
              child: Text(
                "Get \u{20B9} ${widget.item.payoutAmt}",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
        )
      ],
    );
  }

  Widget tasktile(Offerdata data) {
    String title = data.title.toString(),
        description = data.description.toString();
    bool status = data.isCompleted ?? false;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
                width: 3, color: getcolor(status), style: BorderStyle.solid)),
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      geticon(status),
                      SizedBox(
                        height: 20,
                        width: 20,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: status
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: getcolor(status)),
                      onPressed: () {},
                      child: Text("\u{20B9} ${data.payoutAmt}"))
                ],
              ),
              description != ""
                  ? Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        description,
                      ))
                  : SizedBox(
                      height: 0,
                      width: 0,
                    )
            ],
          ),
        ),
      ),
    );
  }

  Color getcolor(bool status) {
    if (status) {
      return Colors.green;
    } else {
      return Colors.orange;
    }
  }

  Widget geticon(status) {
    if (status) {
      return CircleAvatar(
        backgroundColor: Colors.green,
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      );
    } else {
      return CircleAvatar(
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.hourglass_empty,
          color: Colors.white,
        ),
      );
    }
  }
}
