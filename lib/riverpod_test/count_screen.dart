import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'counter.dart';

/// flutter 开发框架 riverpod 使用示例-第2部分，UI页面部分
/// 1. 在 Riverpod 中，UI 组件需要继承 ConsumerWidget，它会给你提供一个 WidgetRef ref。
class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 【重点 1: ref.watch】 —— 用于监听（具体是监听counterProvider中的或者对应的什么？）
    /// 只要 counter 的值变了（这是什么意思 Count类的值是指什么），build 方法就会重新运行，UI 自动刷新。
    final count = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod 示例')),
      body: Center(
        child: Column(
          children: [
            Text('当前数字: $count'),

            ElevatedButton(
              onPressed: () {
                /// 【重点 2: ref.read】 —— 用于读取counterProvider对应的值，但是为什么counterProvider后面.notifier?
                /// 只读取当前那一刻的对象，不监听后续变化。 就像 Get.find<Counter>().increment()
                ref.read(counterProvider.notifier).increment();
              },
              child: const Text('加 1'),
            ),

            ElevatedButton(
              onPressed: () {
                ///
                ref.refresh(counterProvider);
              },
              child: const Text('ref.refresh 方法作用-调用测试'),
            ),
          ],
        ),
      ),
    );
  }
}