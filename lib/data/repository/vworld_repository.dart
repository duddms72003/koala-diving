import 'package:dio/dio.dart';

class VWorldRepository {
  // API 키 상수
  static const String _apiKey = 'A70DAA05-7BB7-3DC8-8E36-AE207FB7EEB3';

  // Dio 클라이언트 초기화
  final Dio _client = Dio(
    BaseOptions(
      validateStatus: (status) => true,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 6),
    ),
  );

  // 주소명으로 검색
  Future<List<String>> findByName(String query) async {
    if (query.length < 2) {
      // 최소 2글자 이상일 때만 검색
      return [];
    }

    try {
      print('검색 쿼리: $query');
      final response = await _client.get(
        'https://api.vworld.kr/req/search',
        queryParameters: {
          'service': 'search',
          'request': 'search',
          'key': _apiKey,
          'query': query,
          'type': 'DISTRICT',
          'category': 'L4',
          'size': 100,
          'format': 'json',
        },
      );

      print('API 응답: ${response.data}');

      if (response.statusCode == 200 &&
          response.data['response']['status'] == 'OK') {
        final items = response.data['response']['result']['items'] as List;
        return items.map((e) => e['title'].toString()).toList();
      }

      print('검색 실패: ${response.data['response']['error']?['text']}');
      return [];
    } catch (e) {
      print('주소 검색 실패: $e');
      return [];
    }
  }

  // 위도/경도로 주소 검색
  Future<List<String>> findByLatLng({
    required double lat,
    required double lng,
  }) async {
    try {
      print('위치 검색: lat=$lat, lng=$lng'); // 디버깅용 로그

      final response = await _client.get(
        'https://api.vworld.kr/req/data',
        queryParameters: {
          'service': 'data',
          'request': 'GetFeature',
          'data': 'LT_C_ADEMD_INFO',
          'key': _apiKey,
          'geomfilter': 'POINT($lng $lat)',
          'geometry': 'false',
          'size': 1,
          'format': 'json',
        },
      );

      print('API 응답: ${response.data}'); // 디버깅용 로그

      if (response.statusCode == 200 &&
          response.data['response']['status'] == 'OK') {
        final features = response.data['response']['result']
            ['featureCollection']['features'] as List;
        return features
            .map((e) => e['properties']['full_nm'].toString())
            .toList();
      }

      print('검색 실패: ${response.data['response']['error']?['text']}');
      return [];
    } catch (e) {
      print('위치 기반 주소 검색 실패: $e');
      return [];
    }
  }
}
