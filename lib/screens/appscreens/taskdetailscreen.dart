import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:efficio/screens/appscreens/edit_task.dart';
import 'package:efficio/screens/appscreens/todo_provider.dart';

class Taskdetailscreen extends StatefulWidget {
  final TodoItems todo;
  const Taskdetailscreen({super.key, required this.todo});

  @override
  State<Taskdetailscreen> createState() => _TaskdetailscreenState();
}

class _TaskdetailscreenState extends State<Taskdetailscreen> {
  late TodoItems currentTask;

  @override
  void initState() {
    super.initState();
    currentTask = widget.todo;
  }

  @override
  Widget build(BuildContext context) {
    final todoprovider = Provider.of<Todoprovider>(context);
    currentTask = todoprovider.todo.firstWhere(
      (task) => task.id == currentTask.id,
      orElse: () => currentTask,
    );
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white), // X icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Consumer<Todoprovider>(
            builder: (context, todoProvider, child) {
              // Get the updated task reference
              currentTask = todoProvider.todo.firstWhere(
                (task) => task.id == currentTask.id,
                orElse: () => currentTask,
              );

              return Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Text(currentTask.gettitle),
                    titleTextStyle: TextStyle(fontSize: 30),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(currentTask.getdescription),
                      ],
                    ),
                    subtitleTextStyle: TextStyle(fontSize: 20),
                    leading: Icon(Icons.circle_outlined,
                        color: Color.fromRGBO(54, 54, 54, 1)),
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return EditTask(todo: currentTask);
                          },
                        ).then((updatedTask) {
                          if (updatedTask != null) {
                            setState(() {
                              Provider.of<Todoprovider>(context, listen: false)
                                  .updateTodo(updatedTask);
                            });
                          }
                        });
                      },
                      icon: Icon(FontAwesome.pencil_solid),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Row(
                    children: [
                      Icon(FontAwesome.clock, color: Colors.white),
                      Text('   Task Time:',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      Spacer(),
                      SizedBox(
                        width: 100,
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          tileColor: Color.fromRGBO(54, 54, 54, 1),
                          subtitleTextStyle: TextStyle(color: Colors.white),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(currentTask.getdate),
                              Text(currentTask.gettime),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Row(
                    children: [
                      Icon(Icons.label_outline, color: Colors.white),
                      Text('   Task Category:',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      Spacer(),
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          tileColor: Color.fromRGBO(54, 54, 54, 1),
                          titleTextStyle: TextStyle(color: Colors.white),
                          title: Text(currentTask.getCategory),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Row(
                    children: [
                      Icon(FontAwesome.flag, color: Colors.white),
                      Text('   Task Priority:',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      Spacer(),
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          tileColor: Color.fromRGBO(54, 54, 54, 1),
                          titleTextStyle: TextStyle(color: Colors.white),
                          title: Center(child: Text(currentTask.getpriority)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    onTap: () {
                      Provider.of<Todoprovider>(context, listen: false)
                          .deleteTodo(currentTask);
                      Navigator.pop(context);
                    },
                    leading:
                        Icon(Icons.delete_outline_outlined, color: Colors.red),
                    title: Text('Delete Task'),
                    titleTextStyle: TextStyle(color: Colors.red),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
