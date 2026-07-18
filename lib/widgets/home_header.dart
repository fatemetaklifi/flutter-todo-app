import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/theme/app_colors.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key, required this.isLight});

  final bool isLight;

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  late final Timer _timeTimer;
  late final Timer _dateTimer;
  String _currentTime = '';
  String _currentDate = '';

  void _updateTime() {
    final now = DateTime.now();
    final formattedTime = DateFormat('Hm').format(now);

    if (mounted) {
      setState(() {
        _currentTime = formattedTime;
      });
    }
  }

  void _updateDate() {
    final now = DateTime.now();
    final formattedDate = DateFormat('yMMMEd').format(now);

    if (mounted) {
      setState(() {
        _currentDate = formattedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _updateTime();
    _updateDate();
    _timeTimer = Timer.periodic(const Duration(seconds: 60), (timer) {
      _updateTime();
    });
    _dateTimer = Timer.periodic(const Duration(days: 1), (timer) {
      _updateDate();
    });
  }

  @override
  void dispose() {
    _timeTimer.cancel();
    _dateTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height * (0.20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _currentTime.isEmpty ? "--:--" : _currentTime,
              style: TextStyle(
                fontFamily: 'bungee',
                fontSize: 75,
                fontWeight: FontWeight.bold,
                color: widget.isLight
                    ? LightColors.primary
                    : DarkColors.primary,
              ),
            ),
            Text(
              _currentDate,
              style: TextStyle(
                fontFamily: 'bungee',
                fontSize: 13,
                color: widget.isLight
                    ? Colors.grey.shade600
                    : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
