import 'package:geolocator/geolocator.dart';
import 'package:rider_app/configMaps.dart';

class AssistantMethods
{
  static Future<String> searchCoordinateAddress() async
  {
    String placedAddress = "";
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";

    var response = await RequestAssistant.getRequest(url);

    if(response != "failed")
      {
        placeAddress = response["results"][0]["formatted_address"];
      }

    return placedAddress;
  }
}