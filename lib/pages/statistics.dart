import 'package:L1_sean/model/statisticsModel.dart';
import 'package:L1_sean/services/statistics.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/widgets/arrows.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Statistics extends StatefulWidget {
  const Statistics({key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  double calculate(double total, double completed) {
    if (total == 0 && completed == 0) {
      return 0;
    } else {
      return completed / total;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ButtonArrow(context, 'home')],
        ),
        title: Text(
          'Statistics (Completed)',
          style: Theme.of(context).textTheme.headline2,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 60, right: 60),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: FutureBuilder(
                  future: StatisticService().fetchListStatistics(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<StatisticsModel> list = snapshot.data;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.only(bottom: 30),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      list[index].listname,
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                  LinearPercentIndicator(
                                    center: Text(
                                      (calculate(
                                                  double.parse(
                                                      list[index].totalItems),
                                                  double.parse(list[index]
                                                          .completed) *
                                                      100))
                                              .toStringAsFixed(0) +
                                          "%",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        fontFamily: 'SansPro-Bold',
                                      ),
                                    ),
                                    lineHeight: 30,
                                    animationDuration: 800,
                                    animation: true,
                                    percent: calculate(
                                        double.parse(list[index].totalItems),
                                        double.parse(list[index].completed)),
                                    progressColor:
                                        Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.deepPurple
                                            : Colors.blue[800],
                                    backgroundColor:
                                        Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.deepPurple.shade100
                                            : Colors.blue[400],
                                  ),
                                ],
                              ));
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ),
              margin20,
              FutureBuilder(
                future: StatisticService().fetchUserStatistics(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data[0].total != 0 &&
                      snapshot.data[0].completed != null) {
                    var item = snapshot.data;
                    return Container(
                      alignment: Alignment.center,
                      child: CircularPercentIndicator(
                        animationDuration: 1000,
                        animation: true,
                        radius: 200,
                        lineWidth: 20,
                        percent: calculate(double.parse(item[0].total),
                            double.parse(item[0].completed)),
                        progressColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.deepPurple
                                : Colors.blue[800],
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.deepPurple.shade100
                                : Colors.blue[400],
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Text(
                          (calculate(double.parse(item[0].total),
                                      double.parse(item[0].completed) * 100))
                                  .toStringAsFixed(0) +
                              "%",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
