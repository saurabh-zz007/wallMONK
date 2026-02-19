import 'dart:convert';

import 'package:http/http.dart' as http;

class Wallpaperservices {
  static const String APIkey =
      'Neh41T8csj9OMWBrXYQcjiDUZwlqRibKclszS3tRcPLGwlYaSnryJZzz';
  Future<List<dynamic>> fetchWallpaper({
    required int page,
    String? query,
  }) async {
    String url;
    if (query == null || query.trim().isEmpty) {
      url =
          'https://api.pexels.com/v1/curated?per_page=80&page=$page';
    } else {
      url =
          'https://api.pexels.com/v1/search?query=$query&page=$page';
    }
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': APIkey},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(
          response.body,
        );
        return data['photos'];
      } else {
        throw Exception(
          'Error: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception(
        'Failed to load wallpaper $e',
      );
    }
  }
}
