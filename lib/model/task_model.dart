
class Task {
  String? id;
  String? title;
  String? description;
  String? createAt;
  String? updatedAt;
  Task({this.id,this.title,this.description,this.createAt,this.updatedAt});

  factory Task.fromJson(Map<String,String>json){
    return Task(
      id: json['_id'],
      title: json['titel'],
      description: json['description'] ,
      createAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  } 
}