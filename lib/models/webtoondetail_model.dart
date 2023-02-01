class WebtoonDetailModel {
  final String about;
  final String genre;
  final String age;
  final String title;
  final String thumb;

  WebtoonDetailModel.fromjson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        about = json['about'],
        age = json['age'],
        genre = json['genre'];
}
