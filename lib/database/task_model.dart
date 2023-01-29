class Task {
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;
  Task({
    this.id = '',
    required this.title,
    required this.description,
    required this.dateTime,
    this.isDone = false
});

  Task.fromFireStore(Map<String,dynamic> data) :
    this(
      id: data['id'],
      title : data ['title'],
      description : data['description'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
      isDone : data['isDone']
    );

  // or
  // {
  // id = data ['id'], ....etc without using this keyword which refer to constructor f TaskModel
  // }

  Map<String,dynamic> toFireStore(){
    return {
      'id' : id,
      'title' : title,
      'description' : description,
      'dateTime' : dateTime.millisecondsSinceEpoch,
      'isDone' : isDone
    };
  }

}