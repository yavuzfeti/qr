import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr/Components/TopBar.dart';
import 'package:qr/Utils/Network.dart';
import 'package:qr/main.dart';

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

  dynamic response;

  al() async
  {
    setState(() {
      loading = true;
    });
    id = await storage.read(key: "id");
    response = await Network("logs?user_id=$id&key=$key").get();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar("İşlem Geçmişi"),
      body: loading ? Center(child: CircularProgressIndicator(),)
          : Container(
        padding: EdgeInsets.all(25),
            child: ListView.builder(
                    itemCount: response.length ?? 0,
            itemBuilder: (context, index)
            {
              return ListTile(
                title: Text(response[index]["action"] == "1" ? "Giriş" : "Çıkış"),
                subtitle: Text(DateFormat("dd.MM.yyyy | HH:mm:ss").format((DateTime.parse(response[index]["updated_at"])))),
              );
            }
                  ),
          ),
    );
  }
}
