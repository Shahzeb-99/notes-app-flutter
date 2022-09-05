import 'package:floor/floor.dart';

@entity
class Notes {

  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String? heading;
  final String? body;
  final int? date;
  final int? month;
  final int? year;

  const Notes(
      {this.date,
      this.month,
      this.year,
      this.id,
      this.heading,
      this.body});

}
