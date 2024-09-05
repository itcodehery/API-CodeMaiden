class Article {
  final int id;
  final String title;
  final String url;
  final String imgUrl;
  final String newsSite;
  final String summary;
  final DateTime publishedAt;
  final DateTime updatedAt;
  final bool isFeatured;

  Article(
      {required this.id,
      required this.title,
      required this.url,
      required this.imgUrl,
      required this.newsSite,
      required this.summary,
      required this.publishedAt,
      required this.updatedAt,
      required this.isFeatured});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      imgUrl: json['imageUrl'],
      newsSite: json['newsSite'],
      summary: json['summary'],
      publishedAt: DateTime.parse(json['publishedAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      isFeatured: json['isFeatured'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'imageUrl': imgUrl,
      'newsSite': newsSite,
      'summary': summary,
      'publishedAt': publishedAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isFeatured': isFeatured,
    };
  }
}
