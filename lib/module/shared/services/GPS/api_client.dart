import 'package:dio/dio.dart';

Dio dio = Dio();
getApi(String URL) async {
  final response = await dio.get(URL);
  final state = (response.data['features'][0]['properties']['state']);
  final postCode = response.data['features'][0]['properties']['postcode'];
  final suburb = response.data['features'][0]['properties']['suburb'];
  return {'state': state, 'postCode': postCode, 'suburb': suburb};
}
