class LocationState {
  final String state;
  final String postCode;
  final String suburb;

  LocationState(
      {required this.state, required this.postCode, required this.suburb});

  factory LocationState.initial() =>
      LocationState(state: '', postCode: '', suburb: '');
}
