import 'package:geolocator/geolocator.dart';
import 'package:rider_app/configMaps.dart';
import 'package:rider_app/Models/address.dart';
import 'package:rider_app/configMaps.dart';

class AssistantMethods
{
  static Future<String> searchCoordinateAddress() async
  {
    String placedAddress = "";
    String st1, st2, st3, st4;
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";

    var response = await RequestAssistant.getRequest(url);

    if(response != "failed")
      {
        //placeAddress = response["results"][0]["address_components"][0]["long_name"];
        st1 = response["results"][0]["address_components"][0]["long_name"];
        st2 = response["results"][0]["address_components"][1]["long_name"];
        st3 = response["results"][0]["address_components"][5]["long_name"];
        st4 = response["results"][0]["address_components"][6]["long_name"];
        placedAddress = st1 + ", " + st2 + ", " + st3 + ", " + st4;


        Address userPickUpAddress = new Address();
        userPickUpAddress.longitude = position.latitude;
        userPickUpAddress.latitude = postition.latitude;
        userPickUpAddress.placeName = placedAddress;

        Provider.of<AppData>(context, listen: false).updatePickUpLocationAddress(userPickUpAddress);
      }


    return placedAddress;
  }
}