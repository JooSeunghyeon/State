import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Provider 상태 관리 클래스
class Counter extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }
}

class ProviderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Counter(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(title: Text('Provider Example')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<Counter>(
                  builder: (context, counter, child) {
                    return Text(
                      'Count: ${counter.count}',
                      style: TextStyle(fontSize: 48),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      heroTag: 'provider_increment',
                      onPressed: () => Provider.of<Counter>(context, listen: false).increment(),
                      child: Icon(Icons.add),
                    ),
                    SizedBox(width: 20),
                    FloatingActionButton(
                      heroTag: 'provider_decrement',
                      onPressed: () => Provider.of<Counter>(context, listen: false).decrement(),
                      child: Icon(Icons.remove),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
