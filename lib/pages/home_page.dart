import 'dart:convert';

import 'package:appday/pages/offer_details.dart';
import 'package:appday/utils/drawer.dart';
import 'package:appday/utils/remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/homedata.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Homedata> homedata = [];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  Future<List<Homedata>> getdata() async {
    var serverjsondata = await FirebaseRemoteConfigClass().initializeConfig();

    var data = jsonDecode(serverjsondata);
    for (var map in data) {
      homedata.add(Homedata.fromJson(map));
    }
    return homedata;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myappbar(),
      body: FutureBuilder(
          future: getdata(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return mainbody(homedata);
            }
          }),
      drawer: MyDrawer(),
    );
  }

  TabBarView mainbody(List<Homedata> homedata) {
    return TabBarView(
      controller: _tabController,
      children: [
        Alloffers(
          homedata: homedata,
        ),
        Center(child: Text('Gifts Page')),
        Center(child: Text('upcoming Page')),
        Center(child: Text('MyGifts Page')),
      ],
    );
  }

  AppBar myappbar() {
    return AppBar(
      leadingWidth: 20,
      title: Text("Hey Ashish"),
      actions: [
        Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8.0),
          child: TextButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, shape: StadiumBorder()),
              onPressed: () {},
              icon: CircleAvatar(
                  child: Icon(
                Icons.wallet,
                color: Colors.white,
                size: 15,
              )),
              label: Text('\u{20B9} 452')),
        ),
      ],
      bottom: TabBar(
        labelStyle: TextStyle(
          fontSize: 12.0,
        ),
        labelColor: Colors.white,
        indicatorColor: Colors.blue,
        controller: _tabController,
        tabs: [
          Tab(
              icon: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 12,
                child: Image.asset(
                  "assets/icons/shapes.png",
                  color: Colors.white,
                ),
              ),
              text: 'All Offers'),
          Tab(icon: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 12,
              child: Image.asset(
                "assets/icons/gift-box.png",
                color: Colors.white,
              ),
            ), text: 'Gifts'),
          Tab(
              icon: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 12,
                child: Image.asset(
                  "assets/icons/clock.png",
                  color: Colors.white,
                ),
              ),
              text: 'Upcoming'),
          Tab(
            icon: Icon(Icons.check_circle_outline),
            text: "My Offers",
          )
        ],
      ),
    );
  }
}

class Alloffers extends StatefulWidget {
  final List<Homedata> homedata;
  const Alloffers({
    super.key,
    required this.homedata,
  });

  @override
  State<Alloffers> createState() => _AlloffersState();
}

class _AlloffersState extends State<Alloffers> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              "Sameer earned \u{20B9}452 from BookMyShow Offer Rakesh earned \u{20B9} 120 from...",
              style: TextStyle(backgroundColor: Color(0xFFE7F5FB)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Trending(),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.homedata.length,
              itemBuilder: (context, index) {
                return TrendingOffers(homedata: widget.homedata[index]);
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: const [
              Icon(CupertinoIcons.table),
              SizedBox(
                width: 8,
              ),
              Text("More offers"),
            ],
          ),
        ),
        SizedBox(
          height: Get.height * 0.4,
          width: Get.width,
          child: ListView.builder(
              itemCount: widget.homedata.length,
              itemBuilder: (context, index) {
                return moreoffers(widget.homedata[index]);
              }),
        )
      ],
    );
  }

  Widget moreoffers(Homedata item) {
    String colorstring = item.customData!.dominantColor!.substring(1);
    Color mycolor = Color(int.parse(colorstring, radix: 16)).withOpacity(1.0);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Get.to(() => OfferDetails(
              item: item,
            )),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  width: 3, color: mycolor, style: BorderStyle.solid)),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Image.network(item.thumbnail.toString()),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.brand!.title.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                                style: ElevatedButton.styleFrom(
                                    maximumSize: Size(90, 36)),
                                onPressed: () => Get.to(() => OfferDetails(
                                      item: item,
                                    )),
                                child: Text(
                                    "Get ${item.payoutCurrency}${item.payoutAmt}")),
                            Text("\u26A1 ${item.totalLead}")
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TrendingOffers extends StatelessWidget {
  final Homedata homedata;
  const TrendingOffers({super.key, required this.homedata});

  @override
  Widget build(BuildContext context) {
    String colorstring = homedata.customData!.dominantColor!.substring(1);
    Color mycolor = Color(int.parse(colorstring, radix: 16)).withOpacity(1.0);

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: InkWell(
        onTap: () => Get.to(() => OfferDetails(
              item: homedata,
            )),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: mycolor,
          ),
          height: 160,
          width: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(homedata.thumbnail.toString()),
                height: 100,
                width: 140,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      homedata.brand!.title.toString(),
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        homedata.payout.toString(),
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    Text(
                      " \u26A1 4,687 users",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Trending extends StatelessWidget {
  const Trending({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          "assets/icons/fire.png",
          width: 24,
          height: 24,
        ),
        Text(
          "Trending offers",
          style: TextStyle(color: Colors.grey, fontSize: 20),
        )
      ],
    );
  }
}
