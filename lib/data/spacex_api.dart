import 'dart:async';
import 'package:multipleprojects/constants/endpoints.dart';
import 'package:multipleprojects/data/base_api.dart';
import 'package:multipleprojects/models/spacex.dart';

class SpaceXApi extends BaseApi {
  Future<SpaceXModel> getSpaceXData() async {
    try {
      final res = await dioClient.get(Endpoints.spaceXUrl);
      return SpaceXModel.fromJson(res.data);
    } catch (error) {
      print("Api Error - getSpaceXData: " + error.toString());
      throw error;
    }
  }
}
