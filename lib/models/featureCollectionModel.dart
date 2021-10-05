class FeatureCollectionModel {
  int? page;
  int? perPage;
  List<Collections>? collections;
  int? totalResults;
  String? nextPage;

  FeatureCollectionModel(
      {this.page,
        this.perPage,
        this.collections,
        this.totalResults,
        this.nextPage});

  FeatureCollectionModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    if (json['collections'] != null) {
      collections = <Collections>[];
      json['collections'].forEach((v) {
        collections!.add(new Collections.fromJson(v));
      });
    }
    totalResults = json['total_results'];
    nextPage = json['next_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    if (this.collections != null) {
      data['collections'] = this.collections!.map((v) => v.toJson()).toList();
    }
    data['total_results'] = this.totalResults;
    data['next_page'] = this.nextPage;
    return data;
  }
}

class Collections {
  String? id;
  String? title;
  String? description;
  bool? private;
  int? mediaCount;
  int? photosCount;
  int? videosCount;

  Collections(
      {this.id,
        this.title,
        this.description,
        this.private,
        this.mediaCount,
        this.photosCount,
        this.videosCount});

  Collections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    private = json['private'];
    mediaCount = json['media_count'];
    photosCount = json['photos_count'];
    videosCount = json['videos_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['private'] = this.private;
    data['media_count'] = this.mediaCount;
    data['photos_count'] = this.photosCount;
    data['videos_count'] = this.videosCount;
    return data;
  }
}
