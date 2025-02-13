import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:efficio/screens/appscreens/todo_provider.dart';

class EditTask extends StatefulWidget {
  final TodoItems todo;
  const EditTask({super.key, required this.todo});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late TextEditingController _titlecontroller;
  late TextEditingController _descriptioncontroller;

  String title = '';
  String description = '';
  String category = '';
  int priority = 10;

  late DateTime dueDate = DateFormat('MMM d, y').parse(widget.todo.dueDate);
  late TimeOfDay dueTime = parseTimeOfDay(widget.todo.dueTime);
  late String formattedDate;
  late String formattedTime;
  Color color = Colors.red;

  @override
  void initState() {
    super.initState();
    _titlecontroller = TextEditingController(text: widget.todo.task);
    _descriptioncontroller =
        TextEditingController(text: widget.todo.description);
    title = widget.todo.task;
    description = widget.todo.description;
    category = widget.todo.category;
    priority = widget.todo.priority;
  }

  @override
  void dispose() {
    _titlecontroller.dispose();
    _descriptioncontroller.dispose();

    super.dispose();
  }

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
                controller: _titlecontroller,
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
                controller: _descriptioncontroller,
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
              final updatedTodo = TodoItems(
                id: widget.todo.id, // Ensure the ID remains the same
                task: title,
                description: description,
                category: category.isEmpty ? 'Personal' : category,
                color: color,
                priority: priority,
                dueDate: formattedDate,
                dueTime: formattedTime,
              );

              // Add the todo to the provider
              Provider.of<Todoprovider>(context, listen: false)
                  .updateTodo(updatedTodo);
              Navigator.pop(context, updatedTodo);
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

    // Initialize with todo's values
    setState(() {
      category = widget.todo.category;
      color = widget.todo.color;
    });

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
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final lcolor =
                    predefinedColors[index % predefinedColors.length];
                final categoryName = categories[index];
                final isSelected = categoryName == category;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      category = categoryName;
                      color = lcolor;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: categoryName == category
                          ? lcolor
                          // ignore: deprecated_member_use
                          : lcolor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      border: isSelected
                          ? Border.all(color: Colors.white, width: 2)
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        categoryName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
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
    int selectedPriority = widget.todo.priority; // Store initial priority

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          // Ensures UI updates inside the dialog
          builder: (context, setDialogState) {
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
                        setDialogState(() => selectedPriority =
                            index + 1); // Update selection in dialog
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedPriority == index + 1
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
                  onPressed: () => Navigator.of(context)
                      .pop(), // Close dialog without saving
                ),
                TextButton(
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.green),
                  ),
                  onPressed: () {
                    setState(
                        () => priority = selectedPriority); // Save selection
                    Navigator.of(context).pop(); // Close dialog
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _selectDueDate() async {
    // Convert stored `dueDate` (String) to DateTime, fallback to today if null/invalid
    DateTime initialDate =
        DateFormat('MMM d, y').parse(formattedDate); // Parse from stored format

    var selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate, // Use previous date or today
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
        formattedDate = formatDate(selectedDate);
      });
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('MMM d, y').format(date); // Example: Jan 29, 2025
  }

  void _showDateTimePicker() async {
    // Convert stored `dueTime` (String) to TimeOfDay, fallback to current time if null/invalid
    TimeOfDay initialTime =
        parseTimeOfDay(formattedTime); // Convert stored string to TimeOfDay;

    var selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime, // Use previous time or now
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
        formattedTime = formatTimeOfDay(selectedTime);
      });
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

// Function to convert stored `dueTime` (String) back to `TimeOfDay`
  TimeOfDay parseTimeOfDay(String time) {
    try {
      final RegExp regex = RegExp(r'(\d+):(\d+) (\w{2})');
      final match = regex.firstMatch(time);

      if (match != null) {
        int hour = int.parse(match.group(1)!);
        int minute = int.parse(match.group(2)!);
        String period = match.group(3)!;

        if (period == "PM" && hour != 12) hour += 12;
        if (period == "AM" && hour == 12) hour = 0;

        return TimeOfDay(hour: hour, minute: minute);
      }
    } catch (e) {
      // print("Error parsing time: $e");
    }
    return TimeOfDay.now(); // Default fallback
  }
}
