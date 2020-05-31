// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TodoRepositoryDao _todoRepositoryDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Todos` (`title` TEXT, `anotation` TEXT, `id` INTEGER PRIMARY KEY AUTOINCREMENT, `createdAt` TEXT, `updateAt` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TodoRepositoryDao get todoRepositoryDao {
    return _todoRepositoryDaoInstance ??=
        _$TodoRepositoryDao(database, changeListener);
  }
}

class _$TodoRepositoryDao extends TodoRepositoryDao {
  _$TodoRepositoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _todoEntityInsertionAdapter = InsertionAdapter(
            database,
            'Todos',
            (TodoEntity item) => <String, dynamic>{
                  'title': item.title,
                  'anotation': item.anotation,
                  'id': item.id,
                  'createdAt': item.createdAt,
                  'updateAt': item.updateAt
                }),
        _todoEntityUpdateAdapter = UpdateAdapter(
            database,
            'Todos',
            ['id'],
            (TodoEntity item) => <String, dynamic>{
                  'title': item.title,
                  'anotation': item.anotation,
                  'id': item.id,
                  'createdAt': item.createdAt,
                  'updateAt': item.updateAt
                }),
        _todoEntityDeletionAdapter = DeletionAdapter(
            database,
            'Todos',
            ['id'],
            (TodoEntity item) => <String, dynamic>{
                  'title': item.title,
                  'anotation': item.anotation,
                  'id': item.id,
                  'createdAt': item.createdAt,
                  'updateAt': item.updateAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _todosMapper = (Map<String, dynamic> row) => TodoEntity(
      id: row['id'] as int,
      createdAt: row['createdAt'] as String,
      updateAt: row['updateAt'] as String,
      title: row['title'] as String,
      anotation: row['anotation'] as String);

  final InsertionAdapter<TodoEntity> _todoEntityInsertionAdapter;

  final UpdateAdapter<TodoEntity> _todoEntityUpdateAdapter;

  final DeletionAdapter<TodoEntity> _todoEntityDeletionAdapter;

  @override
  Future<TodoEntity> getById(int id) async {
    return _queryAdapter.query('SELECT * FROM Todos WHERE id = ?',
        arguments: <dynamic>[id], mapper: _todosMapper);
  }

  @override
  Future<List<TodoEntity>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM Todos', mapper: _todosMapper);
  }

  @override
  Future<int> insertItem(TodoEntity item) {
    return _todoEntityInsertionAdapter.insertAndReturnId(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItem(TodoEntity item) {
    return _todoEntityUpdateAdapter.updateAndReturnChangedRows(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteItem(TodoEntity item) {
    return _todoEntityDeletionAdapter.deleteAndReturnChangedRows(item);
  }
}
