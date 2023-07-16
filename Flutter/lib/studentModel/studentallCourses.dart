class StuAllModel {
  bool? status;
  String? message;
  List<StCourses>? stCourses;

  StuAllModel({this.status, this.message, this.stCourses});

  StuAllModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['courses'] != null) {
      stCourses = <StCourses>[];
      json['courses'].forEach((v) {
        stCourses!.add(new StCourses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.stCourses != null) {
      data['courses'] = this.stCourses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StCourses {
  int? id;
  String? title;
  String? date;
  String? startsAt;
  String? endsAt;

  StCourses({this.id, this.title, this.date, this.startsAt, this.endsAt});

  StCourses.fromJson(Map<String, dynamic> json) {
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
