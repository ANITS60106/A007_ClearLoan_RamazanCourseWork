import '../models/app_notification.dart';
import 'api_client.dart';

class NotificationsService {
  static Future<List<AppNotification>> listNotifications() async {
    final res = await ApiClient.get('/api/loans/notifications/');
    return ((res as List)).map((e) => AppNotification.fromJson(e)).toList();
  }

  static Future<void> markRead(int id) async {
    await ApiClient.post('/api/loans/notifications/$id/read/');
  }
}
