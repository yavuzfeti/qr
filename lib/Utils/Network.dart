import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:qr/main.dart';

const storage = FlutterSecureStorage();

class Network
{
  String url;

  Network(this.url);

  static Dio dio = Dio();

  static const String baseUrl = "https://api.qrpdks.com/api/";

  Future<dynamic> get ({String? adres, dynamic parametre, dynamic data}) async => await process("Get", adres, parametre, data);

  Future<dynamic> post (dynamic data, {String? adres, dynamic parametre}) async => await process("Post", adres, parametre, data);

  Future<dynamic> put (dynamic data, {String? adres, dynamic parametre}) async => process("Put", adres, parametre, data);

  Future<dynamic> delete (String adres, {dynamic parametre, dynamic data}) async => process("Delete", adres, parametre, data);

  Future<dynamic> process (String process, String? adres, dynamic parametre, dynamic data) async
  {
    Response? response;
    try
    {
      adres = adres == null ? "" : "/$adres";
      switch (process)
      {
        case "Get":
          response = await dio.get("$baseUrl$url$adres", queryParameters: parametre, data: data);
          debug(process, response, baseUrl+url+adres, parametre, data);
          return response.data;

        case "Post":
          response = await dio.post("$baseUrl$url$adres", queryParameters: parametre, data: data);
          debug(process, response, baseUrl+url+adres, parametre, data);
          return response.data;

        case "Put":
          response = await dio.put("$baseUrl$url$adres", queryParameters: parametre, data: data);
          debug(process, response, baseUrl+url+adres, parametre, data);
          return response.data;

        case "Delete":
          response = await dio.delete("$baseUrl$url$adres", queryParameters: parametre, data: data);
          debug(process, response, baseUrl+url+adres, parametre, data);
          return response.data;

        default:
          debug(process, response, baseUrl+url+adres, parametre, data);
      }
    }
    on DioError catch (e)
    {
      debug(process, response, baseUrl+url+adres!, parametre, data);
      throw e.response!.toString();
    }
    catch (e)
    {
      rethrow;
    }
  }

  debug(String? process, Response? response, String? link, dynamic parametre, dynamic data)
  {
    if(debugMode)
    {
      print(" \n$process | KOD: ${response?.statusCode.toString()} | URL: $link | PARAMETRE: $parametre\n ");
      print("GÖNDERİLEN VERİ: ${data.toString()}\n ");
      print("ALINAN VERİ: ${response?.data.toString()}\n ");
    }
  }
}