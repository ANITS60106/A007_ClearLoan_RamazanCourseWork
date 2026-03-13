import 'api_client.dart';

class RatingsService {
  static Future<void> rateBank({required String code, required int rating, String comment = ''}) async {
    await ApiClient.post('/api/loans/banks/$code/rate/', body: {'rating': rating, 'comment': comment});
  }
}
