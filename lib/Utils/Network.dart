import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:qr/main.dart';

const storage = FlutterSecureStorage();

class Network
{
  String url;

  Network(this.url);

  static Dio dio = Dio();

  static const String baseUrlBackend = "";
  static const String baseUrlWeb = "";

  Future<bool> takeToken(bool t) async
  {
    if(t)
    {
      try
      {
        String? username = await storage.read(key: "username");
        String? password = await storage.read(key: "password");
        dynamic response = await Network("").post(
            {
              "username": username,
              "password": password,
            });
        dio.options.headers['Authorization'] = "Bearer ${response["data"]["token"]}";
        await storage.write(key: "token", value: response["data"]["token"]);
        return true;
      }
      catch (e) {rethrow;}
    }
    return false;
  }

  Future<dynamic> get ({bool? b, bool? t, String? adres, dynamic parametre, dynamic data}) async => await process(b, t??false, "Get", adres, parametre, data);

  Future<dynamic> post (dynamic data, {bool? b, bool? t, String? adres, dynamic parametre}) async => await process(b, t??false, "Post", adres, parametre, data);

  Future<dynamic> put (dynamic data, {bool? b, bool? t, String? adres, dynamic parametre}) async => process(b, t??false, "Put", adres, parametre, data);

  Future<dynamic> delete (String adres, {bool? b, bool? t, dynamic parametre, dynamic data}) async => process(b, t??false, "Delete", adres, parametre, data);

  Future<dynamic> process (bool? b, bool t, String process, String? adres, dynamic parametre, dynamic data) async
  {
    Response? response;
    String baseUrl = b == null ? baseUrlBackend : (b ? baseUrlBackend : baseUrlWeb);
    try
    {
      t = await takeToken(t);
      adres = adres == null ? "" : "/$adres";
      switch (process)
      {
        case "Get":
          response = await dio.get("$baseUrl$url$adres", queryParameters: parametre, data: data);
          debug(process, response, baseUrl+url+adres, parametre, data, t);
          return response.data;

        case "Post":
          response = await dio.post("$baseUrl$url$adres", queryParameters: parametre, data: data);
          debug(process, response, baseUrl+url+adres, parametre, data, t);
          return response.data;

        case "Put":
          response = await dio.put("$baseUrl$url$adres", queryParameters: parametre, data: data);
          debug(process, response, baseUrl+url+adres, parametre, data, t);
          return response.data;

        case "Delete":
          response = await dio.delete("$baseUrl$url$adres", queryParameters: parametre, data: data);
          debug(process, response, baseUrl+url+adres, parametre, data, t);
          return response.data;

        default:
          debug(process, response, baseUrl+url+adres, parametre, data, t);
      }
    }
    on DioError catch (e)
    {
      debug(process, response, baseUrl+url+adres!, parametre, data, t);
      throw e.response!.toString();
    }
    catch (e)
    {
      rethrow;
    }
  }

  debug(String? process, Response? response, String? link, dynamic parametre, dynamic data, bool t)
  {
    if(debugMode)
    {
      if(t)
      {
        print(" \nTOKEN DEĞİŞTİ: ${dio.options.headers['Authorization']}\n ");
      }
      print(" \n$process | KOD: ${response?.statusCode.toString()} | URL: $link | PARAMETRE: $parametre\n ");
      print("GÖNDERİLEN VERİ: ${data.toString()}\n ");
      print("ALINAN VERİ: ${response?.data.toString()}\n ");
    }
  }
}