import 'package:riverpod_annotation/riverpod_annotation.dart';
/// flutter 开发框架 riverpod 使用示例-第1部分，控制器部分
/// 使用 @riverpod 注解修饰的类 本质上是 什么？ 是notify? 还是什么 ，专业的名字叫什么？ 是类似getx 中的controller吗
/// 1.  fvm dart run build_runner build  这一行很重要，名字必须和文件名一致
part 'counter.g.dart';

/// 2. 使用 @riverpod 注解  这一行很重要，名字必须和文件名一致
@riverpod
class Counter extends _$Counter {

  /// 3. build 方法相当于 GetX 的 onInit，初始化你的状态
  ///  build() 必须返回 int吗 名字也必须是 build()吗 这是固定写法？
  @override
  int build() => 0;

  // 4. 业务逻辑方法
  void increment() {
    /// 4. 这个 state从哪里来的？ 是什么东西？ 为什么更新state 会刷新UI
    state++; // 直接修改 state，UI 会自动刷新
  }
}