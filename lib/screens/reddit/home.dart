import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multipleprojects/bloc/reddit/reddit_bloc.dart';
import 'package:multipleprojects/bloc/reddit/reddit_event.dart';
import 'package:multipleprojects/bloc/reddit/reddit_state.dart';
import 'package:multipleprojects/models/reddit.dart';
import 'package:multipleprojects/widgets/appbar.dart';

class RedditHomeScreen extends StatefulWidget {
  const RedditHomeScreen({Key? key}) : super(key: key);

  @override
  _RedditHomeScreenState createState() => _RedditHomeScreenState();
}

class _RedditHomeScreenState extends State<RedditHomeScreen> {
  @override
  void initState() {
    super.initState();
    _loadReddit();
  }

  _loadReddit() async {
    BlocProvider.of<RedditBloc>(context).add(RedditEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PrimaryAppBarWithText(
          'Reddit',
          showBackButton: true,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: _buildBody(context),
          ),
        ),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<RedditBloc, RedditState>(
            builder: (BuildContext context, RedditState state) {
          if (state is RedditWidgetError) {
            final error = state.error;
            String message = '${error.message}\nTap to Retry.';
            return Container(
              child: Text(message),
            );
          }
          if (state is RedditLoaded) {
            List<RedditModel>? redditModel = state.redditModel;
            return _buildRedditWidget(redditModel!);
          }
          return Container(
            height: MediaQuery.of(context).size.height - 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildRedditWidget(List<RedditModel> redditModels) {
    return Column(
      children: redditModels
          .map<Widget>(
            (redditModel) => _buildRedditLine(redditModel),
          )
          .toList(),
    );
  }

  Widget _buildRedditLine(RedditModel redditModel) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Image.network(
                redditModel.data!.thumbnail!,
                errorBuilder: (context, error, stackTrace) {
                  return const Text('😢');
                },
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    child: Text(
                      redditModel.data!.title!,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      redditModel.data!.author!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
