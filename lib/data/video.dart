class VideoModel {
  final String id;
  final String link;
  final String name;
  final String note;
  final String access;
  final String topic;
  final String material;
  final String essence;

  VideoModel(
      {required this.link,
      required this.name,
      required this.note,
      required this.access,
      required this.topic,
      required this.id,
      required this.material,
      required this.essence});
}
