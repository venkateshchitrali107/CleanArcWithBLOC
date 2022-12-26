import 'package:clean_arc_bloc/app/home/domain/usecases/get_rick_and_morty_list.dart';
import 'package:clean_arc_bloc/core/usecases/usecases.dart';
import 'package:clean_arc_bloc/dependency_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dependency_container.dart' as dc;

void main() {
  dc.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      final data = await serviceLocator<GetRickAndMortyList>().call(
        Params(
          pageNumber: 2,
        ),
      );
      data.fold((l) => print("error"), (r) => print(r.length));
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
