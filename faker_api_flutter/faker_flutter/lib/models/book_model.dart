class Book {
  final int id;
  final String title;
  final String author;
  final String genre;
  final String description;

  Book(
      {required this.id,
      required this.title,
      required this.author,
      required this.genre,
      required this.description});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        id: json['id'],
        title: json['title'],
        author: json['author'],
        genre: json['genre'],
        description: json['description']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'genre': genre,
        'description': description
      };
}
