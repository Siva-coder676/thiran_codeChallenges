class Repository {
  final String name;
  final String description;
  final int stars;
  final String ownerName;
  final String ownerAvatarUrl;

  Repository({
    required this.name,
    required this.description,
    required this.stars,
    required this.ownerName,
    required this.ownerAvatarUrl,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'],
      description: json['description'] ?? '',
      stars: json['stargazers_count'],
      ownerName: json['owner']['login'],
      ownerAvatarUrl: json['owner']['avatar_url'],
    );
  }
}
