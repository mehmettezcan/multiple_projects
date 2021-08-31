import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multipleprojects/bloc/spacex/spacex_bloc.dart';
import 'package:multipleprojects/bloc/spacex/spacex_event.dart';
import 'package:multipleprojects/bloc/spacex/spacex_state.dart';
import 'package:multipleprojects/models/spacex.dart';
import 'package:multipleprojects/widgets/appbar.dart';

class SpacexHomeScreen extends StatefulWidget {
  const SpacexHomeScreen({Key? key}) : super(key: key);

  @override
  _SpacexHomeScreenState createState() => _SpacexHomeScreenState();
}

class _SpacexHomeScreenState extends State<SpacexHomeScreen> {
  @override
  void initState() {
    super.initState();
    _loadSpaceX();
  }

  _loadSpaceX() async {
    BlocProvider.of<SpaceXBloc>(context).add(SpaceXEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PrimaryAppBarWithText(
          'SpaceX',
          showBackButton: true,
        ),
        body: _buildBody(context),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<SpaceXBloc, SpaceXState>(
            builder: (BuildContext context, SpaceXState state) {
          if (state is SpaceXWidgetError) {
            final error = state.error;
            String message = '${error.message}\nTap to Retry.';
            return Container(
              child: Text(message),
            );
          }
          if (state is SpaceXLoaded) {
            SpaceXModel? spaceXModel = state.spaceXModel;
            return _buildSpaceXWidget(spaceXModel);
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

  Widget _buildSpaceXWidget(SpaceXModel? spaceXModel) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Image.network(
              spaceXModel!.links!.patch!.small!,
              errorBuilder: (context, error, stackTrace) {
                return const Text('😢');
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 24,
              ),
              child: Text(
                spaceXModel.name!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                spaceXModel.details!,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
