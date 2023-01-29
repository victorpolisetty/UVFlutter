import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:async';
import 'package:syncfusion_flutter_gauges/gauges.dart';



class DeterminatePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  const DeterminatePage({Key? key}) : super(key: key);

  @override
  _DeterminatePageState createState() => _DeterminatePageState();
}

class _DeterminatePageState extends State<DeterminatePage> {
  late Timer _timer;
  double progressValue = 0;
  double secondaryProgressValue = 0;
  // ignore: sort_constructors_first
  _DeterminatePageState() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (Timer _timer) {
      setState(() {
        progressValue++;
        secondaryProgressValue = secondaryProgressValue + 2;
        if (progressValue == 100) {
          _timer.cancel();
        }
        if (secondaryProgressValue > 100) {
          secondaryProgressValue = 100;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('Flutter circular progress bar')),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getSegmentedProgressStyle()
            ]));
  }

  @override
  Widget getSegmentedProgressStyle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            height: 120,
            width: 120,
            child: SfRadialGauge(axes: <RadialAxis>[
              // Create primary radial axis
              RadialAxis(
                minimum: 0,
                interval: 1,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                startAngle: 270,
                endAngle: 270,
                radiusFactor: 0.8,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.2,
                  color: const Color.fromARGB(30, 0, 169, 181),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                // pointers: <GaugePointer>[
                //   RangePointer(
                //       value: progressValue,
                //       width: 0.05,
                //       pointerOffset: 0.07,
                //       sizeUnit: GaugeSizeUnit.factor,
                //       enableAnimation: true,
                //       animationDuration: 100,
                //       animationType: AnimationType.linear)
                // ],
              ),
              // Create secondary radial axis for segmented line
              RadialAxis(
                minimum: 0,
                interval: 1,
                maximum: 4,
                showLabels: false,
                showTicks: true,
                showAxisLine: false,
                tickOffset: -0.05,
                offsetUnit: GaugeSizeUnit.factor,
                minorTicksPerInterval: 0,
                startAngle: 270,
                endAngle: 270,
                radiusFactor: 0.8,
                majorTickStyle: MajorTickStyle(
                    length: 0.3,
                    thickness: 3,
                    lengthUnit: GaugeSizeUnit.factor,
                    color: Colors.white),
              )
            ])),
        Container(
          height: 120,
          width: 120,
          child: SfRadialGauge(axes: <RadialAxis>[
            // Create primary radial axis
            RadialAxis(
                minimum: 0,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                radiusFactor: 0.8,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.3,
                  color: const Color.fromARGB(40, 0, 169, 181),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                      value: progressValue,
                      width: 0.3,
                      sizeUnit: GaugeSizeUnit.factor,
                      enableAnimation: true,
                      animationDuration: 100,
                      animationType: AnimationType.linear)
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      positionFactor: 0.2,
                      horizontalAlignment: GaugeAlignment.center,
                      widget: Text(progressValue.toStringAsFixed(0) + '%'))
                ]),
            // Create secondary radial axis for segmented line
            RadialAxis(
              minimum: 0,
              maximum: 100,
              showLabels: false,
              showTicks: false,
              showAxisLine: true,
              tickOffset: -0.05,
              offsetUnit: GaugeSizeUnit.factor,
              minorTicksPerInterval: 0,
              radiusFactor: 0.8,
              axisLineStyle: AxisLineStyle(
                thickness: 0.3,
                color: Colors.white,
                dashArray: <double>[4, 3],
                thicknessUnit: GaugeSizeUnit.factor,
              ),
            )
          ]),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}



// class _ProgressBarTimerState extends State<ProgressBarTimer>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 5),
//     );
//     _controller.forward();
//   }

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     children: <Widget>[
  //       LinearProgressIndicator(
  //         value: _controller.value,
  //       ),
  //       ElevatedButton(
  //         onPressed: () {
  //           _controller.reset();
  //           _controller.forward();
  //         },
  //         child: Text("Start"),
  //       )
  //     ],
  //   );
  // }


// }