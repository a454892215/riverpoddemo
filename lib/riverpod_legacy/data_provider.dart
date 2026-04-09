import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// --- [1. Provider]: 存静态数据，不可变 ---
/// flutter riverpod legacy 使用示例-第1部分-Provider
/// 提供一个用于 ref.watch 的 Provider对象
/// 问题： 为什么把URL使用Provider包裹返回呢？URL一般都是固定的 不会改变的 使用这个作为示例代码 是否有歧义？
/// 答案： 不同的环境 URL不相同 所以这里返回的URL不是固定的，而是可能会改变的
int env = 1;
final apiBaseUrlProvider = Provider<String>((ref) {
  if (env == 1) {
    return "https://api.example1.com";
  } else if (env == 2) {
    return "https://api.example2.com";
  } else if (env == 3) {
    return "https://api.example3.com";
  }
  return "https://api.example4.com";
});

final levelProvider = StateProvider<int>((ref) => 8);
// --- [2. FutureProvider]: 处理异步请求 ---
// 相当于 GetX 中处理网络请求的逻辑，自带加载和错误状态
///使用FutureProvider构建一个异步的FutureProvider .autoDispose 表示页面销毁时，数据也销毁? 数据销毁是指代什么？

final userProfileProvider = FutureProvider.autoDispose<Map<String, dynamic>>((
  ref,
) async {
  /// 监听apiBaseUrlProvider是否发生改变,如果发生改变 该回调函数会重新执行？
  final url = ref.watch(apiBaseUrlProvider);
  final currentLevel = ref.watch(levelProvider);
  /// 模拟网络请求
  await Future.delayed(const Duration(milliseconds: 800));
  print("currentLevel: $currentLevel");
  return {"name": "张三", "level": currentLevel};
});
