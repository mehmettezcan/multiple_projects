import 'package:multipleprojects/models/reddit.dart';

abstract class RedditState {
  final List<RedditModel>? redditModel;
  RedditState({this.redditModel});
}

class RedditInitState extends RedditState {}

class RedditLoading extends RedditState {}

class RedditLoaded extends RedditState {
  final List<RedditModel>? redditModel;
  RedditLoaded({this.redditModel});
}

class RedditWidgetError extends RedditState {
  final error;
  RedditWidgetError({this.error});
}
