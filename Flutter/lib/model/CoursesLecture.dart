class CoursesLectureModel {
  bool? status;
  String? message;
  List<Courses2>? courses;

  CoursesLectureModel({this.status, this.message, this.courses});

  CoursesLectureModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['courses'] != null) {
      courses = <Courses2>[];
      json['courses'].forEach((v) {
        courses?.add(new Courses2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.courses != null) {
      data['courses'] = this.courses?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Courses2 {
  int? id;
  String? title;
  String? date;
  String? startsAt;
  String? endsAt;

  Courses2({this.id, this.title, this.date, this.startsAt, this.endsAt});

  Courses2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    startsAt = json['starts_at'];
    endsAt = json['ends_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['starts_at'] = this.startsAt;
    data['ends_at'] = this.endsAt;
    return data;
  }
}
