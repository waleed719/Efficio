import 'package:efficio/screens/appscreens/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<Todoprovider>(context);
    final tasksForDay = todoProvider.todo
        .where((task) => task.getdate == _selectedDay.toString().split(' ')[0])
        .toList();

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text('Task Calendar'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 26),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Calendar View
          Container(
            padding: EdgeInsets.all(16),
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _selectedDay,
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
              },
              calendarStyle: CalendarStyle(
                // Customize the date text size and color
                defaultTextStyle: TextStyle(fontSize: 18, color: Colors.white),

                // Customize the size and color of the selected day
                selectedTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                selectedDecoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),

                // Customize the size and color of today's date
                todayTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow),
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),

                // Customize weekend colors (Saturday & Sunday)
                weekendTextStyle:
                    TextStyle(fontSize: 18, color: Colors.redAccent),

                // Hide outside dates
                outsideDaysVisible: false,
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(fontSize: 16, color: Colors.white),
                weekendStyle: TextStyle(fontSize: 16, color: Colors.redAccent),
              ),
            ),
          ),
          Divider(color: Colors.white),
          // Task List with Horizontal Bars
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: tasksForDay.length,
              itemBuilder: (context, index) {
                final task = tasksForDay[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.gettitle,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              color: Colors.white70, size: 16),
                          SizedBox(width: 8),
                          Text(task.getdate,
                              style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                      SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: 0.5, // Placeholder for progress logic
                        backgroundColor: Colors.white10,
                        color: Colors.green,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
