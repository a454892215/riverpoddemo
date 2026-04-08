import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'counter.dart';

/// flutter 开发框架 riverpod 使用示例-第2部分，UI页面部分
/// 1. 在 Riverpod 中，UI 组件需要继承 ConsumerWidget，它会给你提供一个 WidgetRef ref。
class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 【重点 1: ref.watch】 —— 用于监听目标对象对应的使用了@riverpod修饰的类的build()方法返回的对象
    /// 只要监听的对象改变了 就会触发 该ConsumerWidget的Widget build(BuildContext context, WidgetRef ref) 重新调用。
    ///  问题1： 如果监听的是一个一个自定义类的对象，这个对象的某个属性改变了，也会触发更新吗？
    ///  问题2： 如果监听的是一个List呢，List中的 某个对象的某个属性改变了，也会触发更新吗？
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
                /// 1. ref.read(counterProvider)：读取的是 数据本身（那个 int 数字）。数字是没有 increment() 方法的，所以直接调用会报错
                /// 2. ref.read(counterProvider.notifier)：读取的是 控制器对象实例（即 Counter 类的实例）
                ref.read(counterProvider.notifier).increment();
              },
              child: const Text('加 1'),
            ),

            ElevatedButton(
              onPressed: () {
                /// 这个刷新方法是什么意思？有什么作用？
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