import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc 이벤트 클래스 정의
abstract class CounterEvent {}
class CounterIncrementEvent extends CounterEvent {}
class CounterDecrementEvent extends CounterEvent {}

// Bloc 상태 관리 클래스 정의
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementEvent>((event, emit) {
      emit(state + 1);
    });
    on<CounterDecrementEvent>((event, emit) {
      emit(state - 1);
    });
  }
}

class BlocScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: Text('Bloc Example')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                        heroTag: 'bloc_increment',
                        onPressed: () => context.read<CounterBloc>().add(CounterIncrementEvent()),
                        child: Icon(Icons.add),
                      ),
                      SizedBox(width: 20),
                      FloatingActionButton(
                        heroTag: 'bloc_decrement',
                        onPressed: () => context.read<CounterBloc>().add(CounterDecrementEvent()),
                        child: Icon(Icons.remove),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
