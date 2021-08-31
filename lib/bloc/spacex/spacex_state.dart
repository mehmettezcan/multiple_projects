import 'package:multipleprojects/models/spacex.dart';

abstract class SpaceXState {
  final SpaceXModel? spaceXModel;
  SpaceXState({this.spaceXModel});
}

class SpaceXInitState extends SpaceXState {}

class SpaceXLoading extends SpaceXState {}

class SpaceXLoaded extends SpaceXState {
  final SpaceXModel? spaceXModel;
  SpaceXLoaded({this.spaceXModel});
}

class SpaceXWidgetError extends SpaceXState {
  final error;
  SpaceXWidgetError({this.error});
}
