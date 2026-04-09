import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'count_notifier.dart';
import 'data_provider.dart';

/// flutter riverpod legacy 使用示例-第3部分-ConsumerWidget

/// 1. UI 跟节点类要继承ConsumerWidget 提供 WidgetRef ref 对象
class ManualExampleScreen extends ConsumerWidget {
  const ManualExampleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 1 . 使用ref.watch(provider) 监听普通的Provider，当目标provider中对应的数据（这里是URL）发生改变
    final baseUrl = ref.watch(apiBaseUrlProvider);

    /// 2. 使用ref.watch(provider) 监听异步的FutureProvider（一般是获取网络数据）
    /// 问题：上面的  final baseUrl = ref.watch(apiBaseUrlProvider); 已经监听了 apiBaseUrlProvider，
    ///      但是 userProfileProvider内部也监听了 apiBaseUrlProvider。 是否存在重复监听问题呢，重复监听是否可能有bug呢?
    ///      不会造成重复监听的bug. 这是正常的业务逻辑，Riverpod完全支持这种同一个ConsumerWidget中 多个ref.watch直接或者间接重复监听一个相同的Provider
    final profileAsync = ref.watch(userProfileProvider);

    /// 3. 监听StateNotifierProvider（关联了Notifier的Provider）
    final count = ref.watch(manualCounterProvider);

    return Scaffold(
      appBar: AppBar(title: Text("riverpod legacy 使用示例")),
      body: Column(
        children: [
          Text("API 地址: $baseUrl"),

          const Divider(),

          // 处理异步请求的 UI
          profileAsync.when(
            data: (data) => Text("用户姓名: ${data['name']}  level:${data['level']}"),
            loading: () => CircularProgressIndicator(),
            error: (err, stack) => Text("加载失败: $err"),
          ),

          const Divider(),

          Text("当前计数: $count"),
          ElevatedButton(
            onPressed: () {
              /// 使用ref.read(manualCounterProvider.notifier)获取关联的Notifier对象
              ref.read(manualCounterProvider.notifier).increment();
            },
            child: Text("增加-（访问 Notifier 实例并调用方法）"),
          ),

          ElevatedButton(
            onPressed: () {
              /// 强制刷新异步请求，会再次执行userProfileProvider中的异步回调函数
              ref.read(levelProvider.notifier).update((state) => state + 1);
              // ref.refresh(userProfileProvider);
            },
            child: Text("重新加载用户信息-refresh"),
          ),
        ],
      ),
    );
  }
}