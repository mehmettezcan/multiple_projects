import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multipleprojects/bloc/reddit/reddit_bloc.dart';
import 'package:multipleprojects/bloc/spacex/spacex_bloc.dart';
import 'package:multipleprojects/data/reddit_api.dart';
import 'package:multipleprojects/data/spacex_api.dart';
import 'package:multipleprojects/locator.dart';
import 'package:multipleprojects/screens/reddit/home.dart';
import 'package:multipleprojects/screens/device_info/home.dart';
import 'package:multipleprojects/screens/spacex/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupGetit();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  SpaceXApi spaceXApi = new SpaceXApi();
  RedditApi redditApi = new RedditApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Projects'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildNavigateButton(
              context: context,
              buttonIcon: Icons.amp_stories_rounded,
              buttonLabel: 'SpaceX',
              onTapped: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => SpaceXBloc(
                      spaceXApi: spaceXApi,
                    ),
                    child: SpacexHomeScreen(),
                  ),
                ),
              ),
            ),
            _buildNavigateButton(
              context: context,
              buttonIcon: Icons.reduce_capacity_outlined,
              buttonLabel: 'Reddit',
              onTapped: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => RedditBloc(
                      redditApi: redditApi,
                    ),
                    child: RedditHomeScreen(),
                  ),
                ),
              ),
            ),
            _buildNavigateButton(
              context: context,
              buttonIcon: Icons.device_unknown_outlined,
              buttonLabel: 'Device Info',
              onTapped: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeviceInfoHomeScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigateButton({
    BuildContext? context,
    Function()? onTapped,
    required String buttonLabel,
    required IconData buttonIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 24,
      ),
      child: Card(
        child: InkWell(
          onTap: onTapped,
          child: Ink(
            width: MediaQuery.of(context!).size.width,
            height: 150,
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        buttonIcon,
                        size: 32,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        buttonLabel,
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
