import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';


// Class to handle all of the Places locations services
class LocationService
{
    // This is the API access key for the Places API
    //static String key = 'AIzaSyBk-X3rlplCFjKgvpZpcwryKbDPByCa4uk';
    static String key = dotenv.env["GOOGLE_PLACE_API"].toString();

    // This function takes a string from the getPlace function
    // and sends that location to the Places API, which returns a Place ID
    Future<String> getPlaceId(String input) async
    {
      // Url for sending the request to the API
      final String url = 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';
      // Response from the API
      var response = await http.get(Uri.parse(url));
      // Converting the response to json
      var json = convert.jsonDecode(response.body);
      // Will probably have to edit this to get the specific info
      // that we are looking for
      var placeId = json['candidates'][0]['place_id'] as String;

      // Returning the placeId to the getPlace function to get the
      return placeId;
  }
    // This function takes user input from the search bar on the map page
    // and sends it to the getPlaceId function, which returns the PlaceId
    // from the Places API
    Future<Map<String, dynamic>> getPlace(String lat, String longt) async
    {
      // Getting the PlaceId from the getPlaceId function
      final placeId = await getPlaceIDFromMarker(lat, longt);
      // Url for sending the PlaceId to the API to get information about the place
      final String url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';

      // The response from the API
      var response = await http.get(Uri.parse(url));
      // Converting the response body to JSON format
      var json = convert.jsonDecode(response.body);
      // Casting the response as a Map object
      var results = json['result'] as Map<String, dynamic>;

      // Printing the results to the console
      //print(results);
      // Returning the results to the mapPage search IconButton's
      // onPressed function
      return results;

  }
    Future<String> getPlaceIDFromMarker(String lat, String longt) async
    {
       // Url for sending the request to the API
      final String url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$longt&key=$key';
      // Response from the API
      var response = await http.get(Uri.parse(url));
      // Converting the response to json
      var json = convert.jsonDecode(response.body);
      // Will probably have to edit this to get the specific info
      // that we are looking for
      var placeId = json['results'][0]['place_id'] as String;
      print(placeId);
      // Returning the placeId to the getPlace function to get the
      return placeId;

  }
}