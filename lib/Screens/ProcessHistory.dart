import 'package:flutter/material.dart';
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

  int index = 0;

  dynamic response;
  List<Map<String,dynamic>> day = [];
  List<Map<String,dynamic>> hafta = [];

  al() async
  {
    setState(() {
      loading = true;
    });
    id = await storage.read(key: "id");
    response = await Network("logs?user_id=$id&key=$key").get();
    giris = 0;
    cikis = 0;
    day = [];
    hafta = [];
    List<String> sevenDaysList = List.generate(7, (index)
    {
      return dateToDartTrans(DateTime.now().add(Duration(days: index)));
    });
    for (var value in response)
    {
      String valuedate = dateToDartTrans(value["updated_at"]);
      if (value["action"] == "0")
      {
        giris++;
      } else if (value["action"] == "1") {
        cikis++;
      }
      if (valuedate==dateToDartTrans(DateTime.now()))
      {
        day.add(value);
      }
      if (sevenDaysList.contains(valuedate))
      {
        hafta.add(value);
      }
    }
    setState(() {
      loading = false;
    });
  }

  Container tab(String text,int i)
  {
    return Container(
      margin: EdgeInsets.only(right: 5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: index==i ? Themes.mainColor : Themes.transparent
      ),
      child: InkWell(
        onTap: ()
        {
          setState(() {
            index = i;
          });
        },
        child: Text(
          text,
          style: TextStyle(color: index==i ? Themes.light : Themes.dark),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Themes.lightGrey,
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
                            return Themes.mainColor;
                          }
                          return Themes.grey;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("İşlem Geçmişi",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                          Text("Günlük ${dateToDartTrans(DateTime.now())}")
                        ],
                      ),
                      Row(
                        children: [
                          tab("Günlük",0),
                          tab("Haftalık",1),
                          tab("Aylık",2),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: index == 0,
            child: Expanded(
              child: Container(
                color: Themes.light,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Scrollbar(
                  child: ListView.builder(
                      itemCount: day.length,
                      itemBuilder: (context, index)
                      {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(day[index]["action"] == "0" ? "Giriş" : "Çıkış",style: TextStyle(fontSize: 14)),
                              subtitle: Text(DateFormat("dd.MM.yyyy:HH.mm").format((DateTime.parse(day[index]["updated_at"])))),
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
          ),
          Visibility(
            visible: index == 1,
            child: Expanded(
              child: Container(
                color: Themes.light,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Scrollbar(
                  child: ListView.builder(
                      itemCount: hafta.length,
                      itemBuilder: (context, index)
                      {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(hafta[index]["action"] == "0" ? "Giriş" : "Çıkış",style: TextStyle(fontSize: 14)),
                              subtitle: Text(DateFormat("dd.MM.yyyy:HH.mm").format((DateTime.parse(hafta[index]["updated_at"])))),
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
          ),
          Visibility(
            visible: index == 2,
            child: Expanded(
              child: Container(
                color: Themes.light,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
          ),
        ],
      ),
    );
  }
}
