import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://shop-app-1e31a-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    //do to make favorites unique to each user.
    try {
      final response = await http.put(
        url,
        body: json.encode(isFavorite
            /*{
          'isFavorite': isFavorite,
        } old code that worked with post*/
            ),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
    //optimistic updating for isFavorite
  }
  //"!" means the invert of said value. This function will always invert isfav
}
