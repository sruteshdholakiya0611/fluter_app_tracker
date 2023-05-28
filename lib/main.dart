import 'package:flutter/material.dart';
import 'package:usage_stats/usage_stats.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<UsageInfo> _appUsageList = [];

  @override
  void initState() {
    super.initState();
    _getAppUsage();
  }

  Future<void> _getAppUsage() async {
    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(const Duration(days: 1)); // Adjust the duration as per your requirement
    List<UsageInfo> usageList = await UsageStats.queryUsageStats(startDate, endDate);
    setState(() {
      _appUsageList = usageList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Tracker'),
      ),
      body: ListView.builder(
        itemCount: _appUsageList.length,
        itemBuilder: (BuildContext context, int index) {
          final appUsage = _appUsageList[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(appUsage.packageName![0]),
            ),
            title: Text('${appUsage.packageName}'),
            subtitle: Text('Total Time: ${appUsage.totalTimeInForeground}.'),
          );
        },
      ),
    );
  }
}
