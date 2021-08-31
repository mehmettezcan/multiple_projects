import 'package:dio/dio.dart';
import 'package:multipleprojects/locator.dart';

class BaseApi {
  Dio dioClient = locator.get<Dio>();
}
