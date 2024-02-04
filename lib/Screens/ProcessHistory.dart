import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Components/TopBar.dart';
import 'package:qr/Utils/Network.dart';
import 'package:qr/main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProcessHistory extends StatefulWidget {
  const ProcessHistory({super.key});

  @override
  State<ProcessHistory> createState() => _ProcessHistoryState();
}

class _ProcessHistoryState extends State<ProcessHistory> {

  @override
  void initState() {
    super.initState();
    al();
  }

  bool loading = true;

  String? id;

  int giris = 0;
  int cikis = 1;

  dynamic response;

  al() async
  {
    setState(() {
      loading = true;
    });
    id = await storage.read(key: "id");
    response = await Network("logs?user_id=$id&key=$key").get();
    giris = 0;
    cikis = 0;
    for (var value in response) {
      if (value["action"] == "0") {
        giris++;
      } else if (value["action"] == "1") {
        cikis++;
      }
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar("İşlem Geçmişi"),
      body: loading ? Center(child: CircularProgressIndicator(),)
          : Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  height: 150,
                  child: SfCircularChart(
                    legend: Legend(isVisible: true, position: LegendPosition.right),
                    series: <CircularSeries>[
                      PieSeries<Map<String, dynamic>, String>(
                        dataSource: <Map<String, dynamic>>[
                          {'category': 'Giriş', 'value': giris},
                          {'category': 'Çıkış', 'value': cikis},
                        ],
                        xValueMapper: (Map<String, dynamic> data, _) => data['category'],
                        yValueMapper: (Map<String, dynamic> data, _) => data['value'],
                        pointColorMapper: (Map<String, dynamic> data, _) {
                          if (data['category'] == 'Giriş') {
                            return Themes.green;
                          } else if (data['category'] == 'Çıkış') {
                            return Themes.secondaryColor;
                          }
                          return Themes.grey;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("İşlem Geçmişi",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      Text("Günlük ${dateToDartTrans(DateTime.now())}")
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: Themes.decor,
              margin: const EdgeInsets.all(20),
              child: Scrollbar(
                child: ListView.builder(
                    itemCount: response.length ?? 0,
                    itemBuilder: (context, index)
                    {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(response[index]["action"] == "0" ? "Giriş" : "Çıkış",style: TextStyle(fontSize: 14)),
                            subtitle: Text(DateFormat("dd.MM.yyyy:HH.mm").format((DateTime.parse(response[index]["updated_at"])))),
                          ),
                          Container(
                            color: Themes.lightGrey,
                            width: double.infinity,
                            height: 1,
                          )
                        ],
                      );
                    }
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
