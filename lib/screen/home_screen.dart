import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Pomodoro 타이머와 휴식 타이머의 지속 시간을 상수로 정의
  static const int pomodoroDuration = 1500;
  static const int restDuration = 300;

  // 타이머 관련 변수
  int totalSeconds = pomodoroDuration;
  int completedPomodoros = 0;
  Timer? timer;
  bool isRunning = false;
  bool isResting = false;

  // 타이머 시작 로직
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (totalSeconds > 0) {
          totalSeconds--;
        } else {
          timer.cancel();

          if (isResting) {
            resetToPomodoro();
          } else {
            startRest();
          }
        }
      });
    });

    setState(() {
      isRunning = true;
    });
  }

  // 타이머 일시 정지 로직
  void pauseTimer() {
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  // 타이머 리셋 로직
  void resetTimer() {
    timer?.cancel(); // 타이머 중지
    setState(() {
      totalSeconds = pomodoroDuration;
      completedPomodoros = 0;
      isRunning = false;
    });
  }

  // Pomodoro 타이머로 리셋
  void resetToPomodoro() {
    setState(() {
      totalSeconds = pomodoroDuration;
      isResting = false;
      isRunning = true;
    });
    startTimer(); // 타이머 시작
  }

  // 휴식 시작 로직
  void startRest() {
    setState(() {
      completedPomodoros++;
      totalSeconds = restDuration;
      isResting = true;
      isRunning = true; // 휴식 타이머 실행
    });
    startTimer();
  }

  // 남은 시간을 "MM:SS" 형식으로 변환하는 함수
  String format(int seconds) {
    final Duration duration = Duration(seconds: seconds);
    final String minutes = duration.inMinutes.toString().padLeft(2, '0');
    final String remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
        color: isResting
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.primary,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 4,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  format(totalSeconds),
                  style: const TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(isRunning
                            ? Icons.pause_circle_outline_rounded
                            : Icons.play_circle_outline_rounded),
                        onPressed: isRunning ? pauseTimer : startTimer,
                        iconSize: 100,
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.restart_alt),
                        onPressed: resetTimer,
                        iconSize: 100,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(50)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Running Time',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            '$completedPomodoros',
                            style: const TextStyle(
                              fontSize: 58,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
