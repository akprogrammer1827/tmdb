class PeopleModel {
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  PeopleModel({this.page, this.results, this.totalPages, this.totalResults});

  PeopleModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }
}

class Results {
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  double? popularity;
  String? profilePath;

  Results(
      {this.adult,
        this.gender,
        this.id,
        this.knownForDepartment,
        this.name,
        this.popularity,
        this.profilePath});

  Results.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['known_for_department'] = this.knownForDepartment;
    data['name'] = this.name;
    data['popularity'] = this.popularity;
    data['profile_path'] = this.profilePath;
    return data;
  }
}

