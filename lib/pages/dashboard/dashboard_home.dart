import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/pages/dashboard/project_breackdown.dart';
import 'package:urlnav2/pages/dashboard/widget/dashboard_create_milestone.dart';

class DashboardHomePage extends StatefulWidget {
  final AppState appState;
  const DashboardHomePage({this.appState});

  @override
  State<DashboardHomePage> createState() => _DashboardHomePageState();
}

class _DashboardHomePageState extends State<DashboardHomePage> {
  bool isViewingClock = true;
  bool isViewingClients = true;
  bool isViewingCases = false;
  int myclientindex = 0;

  Stream<QuerySnapshot> users;
  Stream<QuerySnapshot> events;
  Stream<QuerySnapshot> notes;
  Stream<QuerySnapshot> clients;
  Stream<QuerySnapshot> clients2;
  Stream<QuerySnapshot> cases;

  List<_ChartData> data;
  TooltipBehavior _tooltip;

  @override
  void initState() {
    super.initState();
    users = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('details')
        .snapshots();
    events = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('events')
        .snapshots();
    notes = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('notes')
        .snapshots();
    clients = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('clients')
        .snapshots();
    clients2 = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('clients')
        .snapshots();
    cases = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('cases')
        .snapshots();

    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);

    data = [
      _ChartData('JAN', 1500),
      _ChartData('FEB', 4500),
      _ChartData('MAR', 2000),
      _ChartData('APR', 1000),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  List<GDPData> _chartData;
  TooltipBehavior _tooltipBehavior;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: users,
          builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
          ) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final data = snapshot.requireData;

            return Column(
              children: [
                Expanded(
                  child: ResponsiveWidget.isLargeScreen(context)
                      ? method1()
                      : method2(),
                ),
              ],
            );
          }),
    );
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Oceania', 1600),
      GDPData('Africa', 2490),
      GDPData('S America', 2900),
    ];
    return chartData;
  }

  Widget method2() {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.all(paddingMax),
        children: [
          bodyContent(),
          const SizedBox(
            height: 20,
          ),
          //bodyLeftPart(),
          CreateMileStone(),
          const SizedBox(
            height: 20,
          ),
          quickLinks(),
          const SizedBox(
            height: 20,
          ),
          siteWeather(),
          const SizedBox(
            height: 20,
          ),
          workStatus(),
          const SizedBox(
            height: 20,
          ),
          bridge(),
          const SizedBox(
            height: 20,
          ),
          //bodyRightPart(),
        ],
      ),
    );
  }

  Widget method1() {
    return ListView(
      //padding: const EdgeInsets.all(paddingMax),
      children: [
        Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              bodyContent(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  bodyLeftPart(),
                  const SizedBox(
                    width: 10,
                  ),
                  bodyRightPart(),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Expanded bodyRightPart() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Weather(),
          // SizedBox(
          //   height: 20,
          // ),
          Container(
            height: MediaQuery.of(context).size.height / 1.5 + 60,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Activity',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    height: 1.5,
                    color: Color.fromARGB(255, 224, 224, 224),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('View All'),
                        const Icon(
                          MaterialIcons.keyboard_arrow_down,
                          size: 18,
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 235, 235, 235),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  const Center(child: Text('No Project Activity to Diaplay')),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 235, 235, 235),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(4)),
          ),
        ],
      ),
      flex: 1,
    );
  }

  Expanded bodyLeftPart() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CreateMileStone(),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              // quickLinks(),
              // const SizedBox(
              //   width: 10,
              // ),
              //siteWeather(),
              redialGraph(),
            ],
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          // Row(
          //   children: [
          //     workStatus(),
          //     // SizedBox(
          //     //   width: 10,
          //     // ),
          //     // bridge(),
          //   ],
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
          )
        ],
      ),
      flex: 2,
    );
  }

  Expanded redialGraph() {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 235, 235, 235),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Project Budget',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Scaffold(
                        body: SfCircularChart(
                      series: <CircularSeries>[
                        RadialBarSeries<GDPData, String>(
                            dataSource: _chartData,
                            xValueMapper: (GDPData data, _) => data.continent,
                            yValueMapper: (GDPData data, _) => data.gdp,
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                            enableTooltip: true,
                            maximumValue: 6000)
                      ],
                    )),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                      width: 600,
                      child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          primaryYAxis: NumericAxis(
                              minimum: 0, maximum: 10000, interval: 1000),
                          tooltipBehavior: _tooltip,
                          series: <ChartSeries<_ChartData, String>>[
                            BarSeries<_ChartData, String>(
                                dataSource: data,
                                xValueMapper: (_ChartData data, _) => data.x,
                                yValueMapper: (_ChartData data, _) => data.y,
                                name: 'RM',
                                color: Color.fromRGBO(8, 142, 255, 1))
                          ])),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectBreackDown(), ));
              },
              child: Text(
                'Go to Project Breakdown',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Expanded bridge() {
    return Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bridge',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                height: 1.5,
                color: Color.fromARGB(255, 224, 224, 224),
              ),
              const Text(
                "view more",
                style: TextStyle(fontSize: 12, color: Colors.blue),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 235, 235, 235),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(4)),
        height: 200,
      ),
    );
  }

  Expanded workStatus() {
    return Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'work status',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                height: 1.5,
                color: Color.fromARGB(255, 224, 224, 224),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("No Project work created"),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 235, 235, 235),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(4)),
        height: 200,
      ),
    );
  }

  Expanded siteWeather() {
    return Expanded(
      child: Weather(),
    );
  }

  Container Weather() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Site weather',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(
              height: 1.5,
              color: Color.fromARGB(255, 224, 224, 224),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  MaterialCommunityIcons.weather_partly_cloudy,
                  size: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Partly cloudy', style: TextStyle(fontSize: 18)),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text('High: 62 °F',
                        style: TextStyle(fontSize: 10, color: Colors.grey)),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text('Low: 62 °F',
                        style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Wind: 5 MPS, WSW',
                        style: TextStyle(fontSize: 10, color: Colors.grey)),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text('Humidity: 77%',
                        style: TextStyle(fontSize: 10, color: Colors.grey)),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text('Precipitions: 0.0 in',
                        style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              height: 1.5,
              color: Color.fromARGB(255, 224, 224, 224),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Show More',
                  style: TextStyle(fontSize: 15, color: blue),
                ),
                const Icon(
                  MaterialIcons.keyboard_arrow_down,
                  size: 18,
                  color: blue,
                )
              ],
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 235, 235, 235),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(4)),
    );
  }

  Expanded quickLinks() {
    return Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Quick Links',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                height: 1.5,
                color: Color.fromARGB(255, 224, 224, 224),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(MaterialCommunityIcons.google_spreadsheet),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            '0',
                            style: TextStyle(
                              fontSize: 22,
                              color: Color.fromARGB(255, 92, 91, 91),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 235, 235, 235),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              const Icon(Icons.add),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('Sheet'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  const VerticalDivider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(AntDesign.team),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            '1',
                            style: TextStyle(
                              fontSize: 22,
                              color: Color.fromARGB(255, 92, 91, 91),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 235, 235, 235),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              const Icon(Icons.add),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('Members'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 235, 235, 235),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(4)),
      ),
    );
  }

  Row bodyContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome, Teczo',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                const Text(
                  '''Here's what's happening on your project today.''',
                  style: TextStyle(color: Color.fromARGB(255, 68, 66, 66)),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/body_image.svg',
                theme: const SvgTheme(currentColor: Colors.green),
                fit: BoxFit.none,
              ),
              SvgPicture.asset(
                'assets/images/body_image1.svg',
                fit: BoxFit.none,
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('300 Mission Street'),
                const Text('San Francisco, CA'),
                const Text('94105 United States'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
