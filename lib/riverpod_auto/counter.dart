import 'package:riverpod_annotation/riverpod_annotation.dart';
/// flutter 开发框架 riverpod 使用示例-第1部分，控制器部分
/// 使用 @riverpod 注解修饰的类 本质上是Notifier？ 是类似 getx 中的controller 吗
/// 1.  fvm dart run build_runner build  这一行很重要，名字必须和文件名一致
part 'counter.g.dart';

/// 2. 使用 @riverpod 注解  这一行很重要，名字必须和文件名一致
@riverpod
class Counter extends _$Counter {

  /// 3. build 方法相当于 GetX 的 onInit，初始化你的状态
  ///  方法的名字必须是 build()，build() 必须返回值类型可以自定义，返回值的类型决定了 Provider 管理的数据类型
  @override
  int build() => 0;

  // 4. 业务逻辑方法
  void increment() {
    /// 4. 这个 state 就是上面 build()方法返回的对象。state 变量的名字是固定写法。
    state++; // 直接修改 state，UI 会自动刷新
  }
}