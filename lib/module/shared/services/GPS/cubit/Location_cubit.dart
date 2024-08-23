import 'package:ecommerce_app/module/shared/services/GPS/cubit/Location_state.dart';
import 'package:ecommerce_app/module/shared/services/GPS/gps.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationState.initial());

  Future<void> getLocation() async {
    Position position = await getGeoPosition();
    final locationData =
        await getGPSLocation(position.latitude, position.longitude);
    // String location =
    //     await getGPSLocation(position.latitude, position.longitude);
    final state = locationData['state'];
    final postCode = locationData['postCode'];
    final suburb = locationData['suburb'];
    emit(LocationState(state: state, postCode: postCode, suburb: suburb));
  }
}
