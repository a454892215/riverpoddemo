# riverpoddemo

A new Flutter project.

///flutter 状态管理框架riverpod中 1.StateProvider 2.NotifierProvider  3. StateNotifierProvider 有什么区别
///| 类型                    | 用途      | 是否推荐     | 是否有业务逻辑 | 写法复杂度 |
// | --------------------- | ------- | -------- | ------- | ----- |
// | StateProvider         | 简单状态    | ✔ 小范围用   | ❌ 很少    | ⭐     |
// | NotifierProvider      | 复杂状态（新） | ⭐⭐⭐ 强烈推荐 | ✔ 有     | ⭐⭐    |
// | StateNotifierProvider | 旧复杂状态   | ⚠️ 逐步淘汰  | ✔ 有     | ⭐⭐⭐⭐  |