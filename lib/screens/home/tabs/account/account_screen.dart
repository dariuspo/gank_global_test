import 'package:flutter/material.dart';
import 'package:gank_global_test/custom_libs/flutter_radar_chart.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    var ticks = [10, 20, 30];
    var features = [
      "Jungle",
      "Mid",
      "Top",
      "AD",
      "Support",
      "Support 2",
      "Support 3",
    ];
    var data = [
      [10, 20, 28, 18, 16, 15, 17],
    ];
    return RadarChart.dark(
      ticks: ticks,
      features: features,
      data: data,
      reverseAxis: false,
      useSides: true,
    );
  }
}
