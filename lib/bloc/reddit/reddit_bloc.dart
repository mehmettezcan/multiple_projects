import 'package:bloc/bloc.dart';
import 'package:multipleprojects/bloc/reddit/reddit_event.dart';
import 'package:multipleprojects/bloc/reddit/reddit_state.dart';
import 'package:multipleprojects/data/reddit_api.dart';
import 'package:multipleprojects/models/reddit.dart';

class RedditBloc extends Bloc<RedditEvent, RedditState> {
  //
  List<RedditModel>? redditModel;

  final RedditApi? redditApi;

  RedditBloc({this.redditApi}) : super(RedditInitState());

  @override
  Stream<RedditState> mapEventToState(RedditEvent event) async* {
    yield RedditLoading();
    try {
      redditModel = await redditApi!.getRedditData();
      yield RedditLoaded(redditModel: redditModel);
    } catch (e) {
      throw e;
    }
  }
}
