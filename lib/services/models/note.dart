import 'dart:convert';

class NoteModel {
  String? id;
  String? title;
  String? description;
  String? date;
  String? time;
  NoteModel({
    this.id,
    this.title,
    this.description,
    this.date,
    this.time,
  });

  NoteModel copyWith({
    String? id,
    String? title,
    String? description,
    String? date,
    String? time,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NoteModel(id: $id, title: $title, description: $description, date: $date, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is NoteModel &&
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.date == date &&
      other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      date.hashCode ^
      time.hashCode;
  }
}
