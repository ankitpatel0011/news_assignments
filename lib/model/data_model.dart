class Source {
  final String id;
  final String name;

  Source({required this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Article {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
}

class APIResponse {
  final String status;
  final int totalResults;
  final List<Article> articles;

  APIResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory APIResponse.fromJson(Map<String, dynamic> json) {
    List<Article> articlesList = [];
    if (json['articles'] != null) {
      json['articles'].forEach((articleJson) {
        articlesList.add(Article.fromJson(articleJson));
      });
    }
    return APIResponse(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: articlesList,
    );
  }
}
