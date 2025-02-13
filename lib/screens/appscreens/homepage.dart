import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:efficio/screens/appscreens/add_task.dart';
import 'package:efficio/screens/appscreens/calendar_screen.dart';
import 'package:efficio/screens/appscreens/focus_mode.dart';
import 'package:efficio/screens/appscreens/taskdetailscreen.dart';
import 'package:efficio/screens/appscreens/todo_provider.dart';
import 'package:efficio/screens/appscreens/user_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final todoprovider = Provider.of<Todoprovider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            FontAwesome.filter_solid,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Your Tasks',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              FontAwesome.user_astronaut_solid,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: todoprovider.todo.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Placeholder(
                      strokeWidth: -1,
                      fallbackHeight: 300,
                      fallbackWidth: double.infinity,
                      child: Image(
                        image: AssetImage('assests/homepageimage.png'),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'What do you want to do today?',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Tap + to add your tasks',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: todoprovider.todo.length,
                        itemBuilder: (BuildContext context, index) {
                          final todo = todoprovider.todo[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Taskdetailscreen(todo: todo),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Card(
                                elevation: 5,
                                color: Color.fromRGBO(54, 54, 54, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(16),
                                  title: Text(
                                    todo.task,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8),
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              todo.dueDate,
                                              style: TextStyle(
                                                color: Colors.white60,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              todo.dueTime,
                                              style: TextStyle(
                                                color: Colors.white60,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ]),
                                      Spacer(),
                                      TextButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                            todo.color,
                                          ),
                                          shape: WidgetStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                  color:
                                                      Colors.deepPurpleAccent),
                                            ),
                                          ),
                                          padding: WidgetStateProperty.all(
                                            EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 8), // Adjust padding
                                          ),
                                          minimumSize: WidgetStateProperty.all(
                                              Size(0, 40)), // Minimum height
                                        ),
                                        child: SizedBox(
                                          width:
                                              50, // Adjust this width based on your button size
                                          height: 20, // Ensure text is visible
                                          child: Marquee(
                                            text: todo.category.toString(),
                                            style: TextStyle(
                                              color: Colors.white60,
                                              fontSize: 14,
                                            ),
                                            scrollAxis: Axis
                                                .horizontal, // Horizontal scrolling
                                            blankSpace:
                                                20.0, // Space after text before restarting
                                            velocity:
                                                30.0, // Adjust scrolling speed
                                            pauseAfterRound: Duration(
                                                seconds:
                                                    30), // Pause before repeating
                                            startPadding: 10.0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      TextButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                            Color.fromRGBO(54, 54, 54, 1),
                                          ),
                                          shape: WidgetStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                  color:
                                                      Colors.deepPurpleAccent),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          todo.priority.toString(),
                                          style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color.fromRGBO(54, 54, 54, 1),
            fixedColor: Colors.white,
            unselectedItemColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Clarity.home_solid,
                  color: Colors.white,
                ),
                label: "Home",
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesome.calendar_solid),
                label: "Calendar",
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesome.clock_solid),
                label: "Focus",
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesome.user_astronaut_solid),
                label: "Profile",
              ),
            ],
            onTap: (index) {
              if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarScreen()),
                );
              } else if (index == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FocusMode()),
                );
              } else if (index == 4) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserScreen()),
                );
              }
            },
          ),
          Positioned(
            top: -30,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true, // Allows tapping outside to dismiss
                  builder: (BuildContext context) {
                    return AddTaskDialog();
                  },
                ).then((_) {
                  // This will run after dialog is dismissed
                  // print("Dialog closed");
                });
                // print("Plus button clicked");
              },
              child: CircleAvatar(
                backgroundColor: Colors.deepPurpleAccent,
                radius: 30,
                child: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
