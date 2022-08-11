class ChatGeolocationDto {
  ChatGeolocationDto({
    required this.latitude,
    required this.longitude,
  });

  ChatGeolocationDto.fromGeoPoint(List<double> geopoint)
      : latitude = geopoint[0],
        longitude = geopoint[1];

  late final double latitude;
  final double longitude;

  @override
  String toString() =>
      'ChatGeolocationDto(latitude: $latitude, longitude: $longitude)';

  List<double> toGeopoint() => <double>[latitude, longitude];
}
