import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc 이벤트 클래스 정의
abstract class CounterEvent {}
class CounterIncrementEvent extends CounterEvent {}
class CounterDecrementEvent extends CounterEvent {}

// Bloc 상태 관리 클래스 정의
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
  runApp(
    BlocProvider(
      create: (context) => CounterBloc(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocExample(),
    );
  }
}

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
                  onPressed: () => context.read<CounterBloc>().add(CounterIncrementEvent()),
                  child: Icon(Icons.add),
                ),
                SizedBox(width: 20),
                FloatingActionButton(
                  // CounterDecrementEvent를 추가하여 카운터 값을 감소
                  onPressed: () => context.read<CounterBloc>().add(CounterDecrementEvent()),
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
