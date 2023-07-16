class StudentAttendanceModel {
  bool? status;
  String? message;
  List<Courses3>? courses;

  StudentAttendanceModel({this.status, this.message, this.courses});

  StudentAttendanceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['courses'] != null) {
      courses = <Courses3>[];
      json['courses'].forEach((v) {
        courses!.add(Courses3.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Courses3 {
  int? id;
  String? title;
  String? image;

  Courses3({this.id, this.title, this.image});

  Courses3.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    return data;
  }
}
