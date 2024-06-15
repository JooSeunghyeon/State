import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Provider 상태 관리 클래스
class Counter extends ChangeNotifier {
  int _count = 0;

  // 현재 카운터 값을 가져오는 getter
  int get count => _count;

  // 카운터 값을 증가시키고 상태 변경을 알림
  void increment() {
    _count++;
    notifyListeners();
  }

  // 카운터 값을 감소시키고 상태 변경을 알림
  void decrement() {
    _count--;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProviderExample(),
    );
  }
}

class ProviderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Provider Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Counter 상태를 구독하고 UI를 업데이트하는 Consumer 위젯
            // Consumer 위젯은 제공된 Counter 상태를 구독하고, 상태가 변경될 때마다 빌더 함수를 호출하여 UI를 업데이트합니다.
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
                  // Counter의 increment 메서드를 호출하여 카운터 값을 증가
                  // listen: false를 사용하는 이유는 이 컨텍스트에서는 Counter의 상태 변화를 구독할 필요가 없기 때문입니다.
                  // 상태를 읽기만 하고 UI 업데이트를 할 필요가 없는 경우 listen: false를 사용하여 불필요한 리빌드를 방지합니다.
                  onPressed: () => Provider.of<Counter>(context, listen: false).increment(),
                  child: Icon(Icons.add),
                ),
                SizedBox(width: 20),
                FloatingActionButton(
                  // Counter의 decrement 메서드를 호출하여 카운터 값을 감소
                  // 마찬가지로, listen: false를 사용하여 불필요한 리빌드를 방지합니다.
                  onPressed: () => Provider.of<Counter>(context, listen: false).decrement(),
                  child: Icon(Icons.remove),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
