import 'package:attendencesystem/shared/Componnents/constants.dart';
import 'package:dio/dio.dart';

class DioHelper
{
  static late Dio dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://omar-gradeuation-project.forloop-eg.com/api',
        receiveDataWhenStatusError: true,
      )
    );
  }

  static Future<Response> postData(
  String url,
  {
  required dynamic data,
    dynamic query
})async
  {
    dio.options.headers={
      'Content-Type':'application/json',

    };
    return await dio.post(url,data: data,queryParameters: query);
  }


  static Future<Response> getData(
      String url,
      {
        String? token,
        Map < String,dynamic>? query,
      })async{
    dio.options.headers={
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      return await dio.get(url, queryParameters: query); // Change this line
    } catch (e) {
      print('Failed to get data: $e');  // Change this line
      throw e;  // rethrow the exception
    }
  }


}