import 'dart:async';
import 'package:multipleprojects/constants/endpoints.dart';
import 'package:multipleprojects/data/base_api.dart';
import 'package:multipleprojects/models/reddit.dart';

class RedditApi extends BaseApi {
  Future<List<RedditModel>> getRedditData({
    int countSize = 20,
  }) async {
    try {
      final res = await dioClient
          .get(Endpoints.redditUrl + '?count=' + countSize.toString());
      List<RedditModel> _reddits = res.data['data']['children']
          .map<RedditModel>(
              (statusSummary) => RedditModel.fromJson(statusSummary))
          .toList();
      return _reddits;
    } catch (error) {
      print("Api Error - getRedditData: " + error.toString());
      throw error;
    }
  }
}
