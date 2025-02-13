import 'package:efficio/screens/appscreens/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  String title = '';
  String description = '';
  String category = '';
  int priority = 10;

  DateTime dueDate = DateTime.now();
  TimeOfDay dueTime = TimeOfDay.now();
  late String formattedDate;
  late String formattedTime;
  Color color = Colors.red;

  @override
  Widget build(BuildContext context) {
    formattedDate = formatDate(dueDate);
    formattedTime = formatTimeOfDay(dueTime);
    return AlertDialog(
      title: Text(
        'Add Task',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Color.fromRGBO(54, 54, 54, 1),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.3,
        ),
        decoration: BoxDecoration(
          color: Color.fromRGBO(54, 54, 54, 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                style: TextStyle(color: Colors.white, fontSize: 20),
                autofocus: true,
                onChanged: (value) => setState(() => title = value),
                decoration: InputDecoration(
                  hintText: "Enter To do",
                  hintStyle: TextStyle(color: Colors.white54),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(54, 54, 54, 1)),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (value) => setState(() => description = value),
                style: TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(color: Colors.white54),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(54, 54, 54, 1)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.category, color: Colors.white),
                    onPressed: () => _selectCategory(),
                  ),
                  IconButton(
                    icon: Icon(Icons.priority_high, color: Colors.white),
                    onPressed: () => _selectPriority(),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today, color: Colors.white),
                    onPressed: () => _selectDueDate(),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: () => _showDateTimePicker(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel', style: TextStyle(color: Colors.red)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Save', style: TextStyle(color: Colors.green)),
          onPressed: () {
            if (title.isNotEmpty) {
              // Basic validation
              final newTodo = TodoItems(
                task: title,
                description: description,
                category: category.isEmpty ? 'Personal' : category,
                color: color, // Default category
                priority: priority,
                dueDate: formattedDate,
                dueTime: formattedTime,
              );

              // Add the todo to the provider
              Provider.of<Todoprovider>(context, listen: false)
                  .addTodo(newTodo);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  void _selectCategory() {
    final List<Color> predefinedColors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.cyan,
      Colors.amber,
      Colors.lime,
    ];

    final List<String> categories = [
      'Work',
      'Personal',
      'Shopping',
      'Health',
      'Fitness'
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(54, 54, 54, 1),
          title: Text(
            "Select Category",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two categories per row
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final lcolor = predefinedColors[index %
                    predefinedColors.length]; // Assign colors cyclically
                final categoryName = categories[index];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      category = categoryName;
                      color = lcolor;
                    }); // Set selected category
                    Navigator.of(context).pop(); // Close dialog
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        categoryName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _selectPriority() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(54, 54, 54, 1),
          title: Text(
            "Set Priority",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, // Adjust to fit 10 squares in 2 rows
                crossAxisSpacing: 7,
                mainAxisSpacing: 7,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() => priority = index + 1); // Set priority
                    Navigator.of(context).pop(); // Close dialog
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: priority == index + 1
                          ? Colors.deepPurpleAccent // Highlight selected
                          : Colors.grey[800],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.flag,
                          color: Colors.white,
                          size: 20,
                        ),
                        // SizedBox(height: 5),
                        Text(
                          "${index + 1}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _selectDueDate() async {
    var selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.deepPurpleAccent,
              onPrimary: Colors.white,
              surface: Color.fromRGBO(54, 54, 54, 1),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        dueDate = selectedDate;
        formattedDate = formatDate(selectedDate);
      });
      _selectPriority();
      _selectCategory();
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('MMM d, y').format(date); // Example: Jan 29, 2025
  }

  void _showDateTimePicker() async {
    var selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Color.fromRGBO(54, 54, 54, 1),
              hourMinuteColor: Colors.grey[800],
              hourMinuteTextColor: Colors.white,
              dialBackgroundColor: Colors.grey[800],
              dialTextColor: Colors.white,
              dialHandColor: Colors.blue,
            ),
          ),
          child: child!,
        );
      },
    );
    if (selectedTime != null) {
      setState(() {
        dueTime = selectedTime;
        formattedTime = formatTimeOfDay(selectedTime);
      });
      _selectDueDate();
    }
  }

  String formatTimeOfDay(TimeOfDay time) {
    final int hour = time.hour;
    final int minute = time.minute;
    final String period = hour >= 12 ? "PM" : "AM";
    final int formattedHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    final String formattedMinute = minute.toString().padLeft(2, '0');

    return "$formattedHour:$formattedMinute $period"; // Example: 10:30 AM
  }
}
