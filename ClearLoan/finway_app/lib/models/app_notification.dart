class AppNotification {
  final int id;
  final String title;
  final String message;
  final String category;
  final bool isRead;
  final String createdAt;

  AppNotification({required this.id, required this.title, required this.message, required this.category, required this.isRead, required this.createdAt});

  factory AppNotification.fromJson(Map<String, dynamic> j) => AppNotification(
    id: (j['id'] ?? 0) as int,
    title: (j['title'] ?? '') as String,
    message: (j['message'] ?? '') as String,
    category: (j['category'] ?? 'info') as String,
    isRead: (j['is_read'] ?? false) as bool,
    createdAt: (j['created_at'] ?? '') as String,
  );
}
