class DataModel {
  String? sId;
  String? movieTitle;
  String? movieSubtitle;
  String? imageUrl;
  int? read;

  DataModel(
      {this.sId,
      this.movieTitle,
      this.movieSubtitle,
      this.imageUrl,
      this.read});

  DataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    movieTitle = json['movie_title'];
    movieSubtitle = json['movie_subtitle'];
    imageUrl = json['image_url'];
    read = json['read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['movie_title'] = movieTitle;
    data['movie_subtitle'] = movieSubtitle;
    data['image_url'] = imageUrl;
    data['read'] = read;
    return data;
  }
}
