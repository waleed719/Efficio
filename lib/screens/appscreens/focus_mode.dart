import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class FocusMode extends StatefulWidget {
  const FocusMode({super.key});

  @override
  State<FocusMode> createState() => _FocusModeState();
}

class _FocusModeState extends State<FocusMode> {
  int _remainingTime = 1800; // Default 30 minutes
  int _totalTime = 1800;
  Timer? _timer;
  late AudioPlayer _audioPlayer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  void _startPauseTimer() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_remainingTime > 0) {
          setState(() {
            _remainingTime--;
          });
        } else {
          _playAlarmSound();
          _timer?.cancel();
          setState(() {
            _isRunning = false;
          });
          // Play sound when timer ends
        }
      });
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

// Function to play the alarm sound
  void _playAlarmSound() async {
    await _audioPlayer.play(AssetSource('alarm.mp3'));
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _remainingTime = _totalTime;
      _isRunning = false;
    });
  }

  void _setTime() async {
    int hours = 0;
    int minutes = 0;
    int seconds = 0;

    int? selectedTime = await showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: Text(
            "Set Timer",
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: "Hours",
                    labelStyle: TextStyle(color: Colors.white)),
                onChanged: (value) {
                  hours = int.tryParse(value) ?? 0;
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: "Minutes",
                    labelStyle: TextStyle(color: Colors.white)),
                onChanged: (value) {
                  minutes = int.tryParse(value) ?? 0;
                },
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Seconds",
                    labelStyle: TextStyle(color: Colors.white)),
                onChanged: (value) {
                  seconds = int.tryParse(value) ?? 0;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                    context, (hours * 3600) + (minutes * 60) + seconds);
              },
              child: Text("Set"),
            ),
          ],
        );
      },
    );

    if (selectedTime != null) {
      setState(() {
        _totalTime = selectedTime;
        _remainingTime = _totalTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = _remainingTime / _totalTime;
    return Scaffold(
      appBar: AppBar(
        title: Text('Focus Mode'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 30),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 15,
                      backgroundColor: Color.fromRGBO(54, 54, 54, 1),
                      valueColor:
                          AlwaysStoppedAnimation(Colors.deepPurpleAccent),
                    ),
                  ),
                  Text(
                    "${(_remainingTime ~/ 60).toString().padLeft(2, '0')}:${(_remainingTime % 60).toString().padLeft(2, '0')}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _setTime,
                    child: Text("Set Timer"),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _startPauseTimer,
                    child: Text(_isRunning ? "Pause" : "Start Timer"),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _stopTimer,
                    child: Text("Stop"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
