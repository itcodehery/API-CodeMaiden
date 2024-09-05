class Blog {
  final int id;
  final String title;
  final String url;
  final String imgUrl;
  final String newsSite;
  final String summary;
  final DateTime publishedAt;
  final DateTime updatedAt;
  final bool isFeatured;

  Blog(
      {required this.id,
      required this.title,
      required this.url,
      required this.imgUrl,
      required this.newsSite,
      required this.summary,
      required this.publishedAt,
      required this.updatedAt,
      required this.isFeatured});

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      imgUrl: json['image_url'],
      newsSite: json['news_site'],
      summary: json['summary'],
      publishedAt: DateTime.parse(json['published_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      isFeatured: json['featured'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'image_url': imgUrl,
      'news_site': newsSite,
      'summary': summary,
      'published_at': publishedAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'featured': isFeatured,
    };
  }
}
