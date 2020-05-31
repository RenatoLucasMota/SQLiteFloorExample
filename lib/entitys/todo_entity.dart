import 'package:floor/floor.dart';
import 'package:sqlite_video/entitys/entity_base.dart';

@Entity(tableName: 'Todos')
class TodoEntity extends EntityBase {
  TodoEntity(
      {int id, String createdAt, String updateAt, this.title, this.anotation})
      : super(id, createdAt, updateAt);

  final String title;
  final String anotation;
}
