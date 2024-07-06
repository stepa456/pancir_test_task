class ListPostModel {
  const ListPostModel({
    required this.name,
    required this.description,
    required this.comments,
  });

  final String name;
  final String description;
  final List<String> comments;
}
