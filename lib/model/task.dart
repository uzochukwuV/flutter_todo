class TaskModel {
  late String category;
  late DateTime startDate;
  late DateTime expectedEndDate;
  late int percentageDone;
  late int id;
  late final String description;
  late String title;

  TaskModel(this.id, this.description, this.title, this.category,
      this.expectedEndDate, this.percentageDone, this.startDate);

  @override
  toString() {
    return title;
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        json['id'],
        json['description'],
        json['title'],
        json['category'],
        json['expectedEndDate'],
        json['percentageDone'],
        json['startDate']);
  }
}
