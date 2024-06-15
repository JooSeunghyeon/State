import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

// Bloc 이벤트 클래스 정의
abstract class CounterEvent {}

class CounterIncrementEvent extends CounterEvent {}

class CounterDecrementEvent extends CounterEvent {}

// Bloc 클래스 정의
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    if (event is CounterIncrementEvent) {
      yield state + 1;
    } else if (event is CounterDecrementEvent) {
      yield state - 1;
    }
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        BlocProvider(create: (_) => CounterBloc()),
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

// 홈 화면
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Provider & Bloc Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProviderExample()),
                );
              },
              child: Text('Provider Example'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BlocExample()),
                );
              },
              child: Text('Bloc Example'),
            ),
          ],
        ),
      ),
    );
  }
}

// Provider 예제 UI
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
                  onPressed: () =>
                      Provider.of<Counter>(context, listen: false).increment(),
                  child: Icon(Icons.add),
                ),
                SizedBox(width: 20),
                FloatingActionButton(
// Counter의 decrement 메서드를 호출하여 카운터 값을 감소
// 마찬가지로, listen: false를 사용하여 불필요한 리빌드를 방지합니다.
                  onPressed: () =>
                      Provider.of<Counter>(context, listen: false).decrement(),
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

// Bloc 예제 UI
class BlocExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bloc Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
// CounterBloc의 상태를 구독하고 UI를 업데이트하는 BlocBuilder 위젯
            BlocBuilder<CounterBloc, int>(
              builder: (context, count) {
                return Text(
                  'Count: $count',
                  style: TextStyle(fontSize: 48),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
// CounterIncrementEvent를 추가하여 카운터 값을 증가
                  onPressed: () =>
                      context.read<CounterBloc>().add(CounterIncrementEvent()),
                  child: Icon(Icons.add),
                ),
                SizedBox(width: 20),
                FloatingActionButton(
// CounterDecrementEvent를 추가하여 카운터 값을 감소
                  onPressed: () =>
                      context.read<CounterBloc>().add(CounterDecrementEvent()),
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
