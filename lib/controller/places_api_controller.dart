import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

// For storing our result
class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  static final String androidKey = 'AIzaSyAF-NthyyoxzpWQpYSwzQ2ZzRgnzwdixRU';
  static final String iosKey = 'AIzaSyAF-NthyyoxzpWQpYSwzQ2ZzRgnzwdixRU';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&key=$apiKey&sessiontoken=$sessionToken';
    print(request);
    final response = await client.get(Uri.parse(request));
    if (response.statusCode == 200) {
      print(response);
      final result = json.decode(response.body);
      print(result);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
