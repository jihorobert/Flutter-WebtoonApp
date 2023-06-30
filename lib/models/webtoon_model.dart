class WebtoonModel {
  final String title, thumb, id;

  // named constructor (원래 constructor쓰는 방식이라 같지만 더 간단화시킴. 더많이쓰이는법)
  // fromJson 이라는 이름을 가진 constructor
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        thumb = json["thumb"],
        id = json["id"];
}
