import 'api_client.dart';

class EducationArticle {
  final int id;
  final String title;
  final String body;
  EducationArticle({required this.id, required this.title, required this.body});
  static EducationArticle fromJson(Map<String,dynamic> j) => EducationArticle(id: j['id'] as int, title: j['title'] as String, body: j['body'] as String);
}

class EducationService {
  static Future<List<EducationArticle>> list() async {
    final res = await ApiClient.get('/api/loans/education/');
    return (res as List).map((e) => EducationArticle.fromJson(e as Map<String,dynamic>)).toList();
  }
}
