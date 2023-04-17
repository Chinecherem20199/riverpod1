import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HookApp',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class Counter extends StateNotifier<int?> {
  Counter() : super(null);
  void increment() => state = state == null ? 1 : state + 1;
  void decrement() => state = state == null ? 1 : state - 1;
}

final counterProvider = StateNotifierProvider<Counter, int?>(
  (ref) => Counter(),
);

extension OptionalInfixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    }
     else {
      return null;
    }
  }

  T? operator -(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow - (other ?? 0) as T;
    } else{

      return null;
    }
  }
}
// void testIt() {
//   final int? int1 = null;
//   const int? int2 = 1;
//   final result = int1 + int2;
//   print(result);
// }

// final currentDate = Provider<DateTime>((ref) => DateTime.now());

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final data = ref.watch(currentDate);
    final counter = ref.watch(counterProvider);
    // testIt();
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (context, ref, child) {
            final count = ref.watch(counterProvider);
            final text = count == null ? "Press the button" : count.toString();
            return Text(text);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: () => {
              ref.read(counterProvider.notifier).increment(),
            },
            child: const Text("Increment"),
          ),
          TextButton(
            onPressed: () => {
              ref.read(counterProvider.notifier).decrement(),
            },
            child: const Text("Decrement"),
          ),
        ],
      ),
      // body: Center(
      //   child: Text(data.toIso8601String(),
      //       style: Theme.of(context).textTheme.headline4),
      // ),
    );
  }
}
