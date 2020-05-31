import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_video/db/database.dart';
import 'package:sqlite_video/entitys/todo_entity.dart';
import 'package:sqlite_video/pages/todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.db}) : super(key: key);
  final AppDatabase db;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return TodoPage(db: widget.db);
              },
            ),
          );
          if (result) {
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Minhas anotações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: FutureBuilder<List<TodoEntity>>(
            future: widget.db.todoRepositoryDao.getAll(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: () async {
                              var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return TodoPage(
                                        db: widget.db,
                                        todo: snapshot.data[index]);
                                  },
                                ),
                              );
                              if (result) {
                                setState(() {});
                              }
                            },
                            title: Text(snapshot.data[index].title),
                            subtitle: Text(snapshot.data[index].anotation),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text('Não há anotações...'),
                    );
            }),
      ),
    );
  }
}
