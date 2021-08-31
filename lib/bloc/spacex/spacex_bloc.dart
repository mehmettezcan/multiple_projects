import 'package:bloc/bloc.dart';
import 'package:multipleprojects/bloc/spacex/spacex_event.dart';
import 'package:multipleprojects/bloc/spacex/spacex_state.dart';
import 'package:multipleprojects/data/spacex_api.dart';
import 'package:multipleprojects/models/spacex.dart';

class SpaceXBloc extends Bloc<SpaceXEvent, SpaceXState> {
  //
  SpaceXModel? spaceXModel;

  final SpaceXApi? spaceXApi;

  SpaceXBloc({this.spaceXApi}) : super(SpaceXInitState());

  @override
  Stream<SpaceXState> mapEventToState(SpaceXEvent event) async* {
    yield SpaceXLoading();
    try {
      spaceXModel = await spaceXApi!.getSpaceXData();
      yield SpaceXLoaded(spaceXModel: spaceXModel);
    } catch (e) {
      throw e;
    }
  }
}
