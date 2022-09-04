class Notes {
  final int? id;
  final String heading;
  final String body;

  final int date;
  final int month;
  final int year;

  const Notes(
      {required this.date,
      required this.month,
      required this.year,
      this.id,
      required this.heading,

      required this.body});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'heading': heading,
      'body': body,
      'date': date,
      'month': month,
      'year': year
    };
  }
}
