class DoctorAttendanceModel {
  bool? status;
  String? message;
  List<Students>? students;

  DoctorAttendanceModel({this.status, this.message, this.students});

  DoctorAttendanceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['students'] != null) {
      students = <Students>[];
      json['students'].forEach((v) {
        students!.add(new Students.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.students != null) {
      data['students'] = this.students!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Students {
  String? name;
  bool? attended;

  Students({this.name, this.attended});

  Students.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    attended = json['attended'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['attended'] = this.attended;
    return data;
  }
}
