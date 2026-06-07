class WeatherData {
  final String cityName;
  final double temp;
  final String maincondition;
  WeatherData({
    required this.cityName,
    required this.temp,
    required this.maincondition,
  });
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['name'],
      temp: json['main']['temp'].toDouble(),
      maincondition: json['weather'][0]['main'],
    );
  }
}
