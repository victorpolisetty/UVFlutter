import 'package:flutter/material.dart';
import 'dart:async';
import 'package:syncfusion_flutter_gauges/gauges.dart';



class DeterminatePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  DeterminatePage({Key? key}) : super(key: key);
  // Map<String, dynamic> data;
  // String age;
  // String heavilyClothed;

  @override
  _DeterminatePageState createState() => _DeterminatePageState();
}

class _DeterminatePageState extends State<DeterminatePage> {
  bool startTimer = false;
  @override
  void initState() {
    // widget.data = {};
    // widget.age = "0";


    // TODO: implement initState
    // print("HERE");
    // print(widget.data);
    // print(widget.age);
    // print(widget.heavilyClothed);
    super.initState();
  }
  Timer _timer = Timer(Duration(milliseconds: 1), () {});
  double progressValue = 0;
  double secondaryProgressValue = 0;
  // ignore: sort_constructors_first

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF4BB96),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getSegmentedProgressStyle(),
              displayText()
            ]));
  }

  @override
  Widget displayText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5,0,0,0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
      Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)
        ),
          child: Text("You are located in: San Francisco, CA")
      ),
    SizedBox(height: 20,),
    Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
    color: Colors.white, borderRadius: BorderRadius.circular(10)
    ),
    child:
    Text("Current UV Index: 8.16"),

    ),
          SizedBox(height: 10,),

          Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
    color: Colors.white, borderRadius: BorderRadius.circular(10)
    ),
    child:
    Text("Unsafe Exposure Warning: 30.24 minutes"),
    ),
          SizedBox(height: 10,),

          !_timer.isActive ? Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
    color: Colors.white, borderRadius: BorderRadius.circular(10)
    ),
    child:
     Text("All done! You've got your daily Vitamin D from the Sun!")
    ) : Container(),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: () {
            startTimer = true;
            _timer = Timer.periodic(const Duration(milliseconds: 500), (Timer _timer) {
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
          },
              child: Text("Start Timer"))
        ]
      ),
    );
  }

  @override
  Widget getSegmentedProgressStyle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
            height: 0,
            width: 0,
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
                axisLineStyle: const AxisLineStyle(
                  thickness: 0.2,
                  color: Color(0xFF995201),
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
                majorTickStyle: const MajorTickStyle(
                    length: 0.3,
                    thickness: 3,
                    lengthUnit: GaugeSizeUnit.factor,
                    color: Color(0xFF995201)),
              )
            ])),
        SizedBox(
          height: 240,
          width: 240,
          child: SfRadialGauge(axes: <RadialAxis>[
            // Create primary radial axis
            RadialAxis(
                minimum: 0,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                radiusFactor: 0.8,
                axisLineStyle: const AxisLineStyle(
                  thickness: 0.3,
                  color: Color(0xFF995201),
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
                      widget: Text('Total Time: 8:41'))
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
              axisLineStyle: const AxisLineStyle(
                thickness: 0.3,
                color: Color(0xFFF4BB96),
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