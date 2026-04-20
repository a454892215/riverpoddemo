import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user_list_notifier.dart';

/// NotifierProvider 示例页面
/// - 模拟网络请求：Future.delayed
/// - 通过 NotifierProvider 更新 UI
/// - 演示常用 ref API：watch/read/listen/select/invalidate
class NotifierProviderSampleScreen extends ConsumerStatefulWidget {
  const NotifierProviderSampleScreen({super.key});

  @override
  ConsumerState<NotifierProviderSampleScreen> createState() =>
      _NotifierProviderSampleScreenState();
}

class _NotifierProviderSampleScreenState
    extends ConsumerState<NotifierProviderSampleScreen> {
  @override
  void initState() {
    super.initState();

    /// 【重点：ref.listen】监听 provider 状态变化，适合做“弹窗/Toast/路由跳转”这类副作用。
    /// 这里用 AsyncValue.hasError 来抓错误并提示。
    ref.listen(
      userListProvider,
      (prev, next) {
        if (!next.hasError) return;
        final err = next.error;
        if (err == null) return;
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(err.toString())),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    /// 【重点：ref.watch】监听整个 state（只要 state 变更就会刷新）
    final state = ref.watch(userListProvider);

    /// 【重点：ref.watch + select】只监听某个字段，减少无关 rebuild
    final userCount = ref.watch(
      userListProvider.select((v) => v.asData?.value.length ?? 0),
    );
    final users = state.asData?.value ?? const [];

    return Scaffold(
      appBar: AppBar(title: const Text('NotifierProvider 请求/更新 UI 示例')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('用户数量: $userCount'),
                ),
                Expanded(
                  child: Text(
                    'loading: ${state.isLoading}',
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('hasError: ${state.hasError}'),
            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton(
                  onPressed: () {
                    /// 【重点：ref.read】读取 notifier 实例并调用业务方法（不会监听）
                    ref.read(userListProvider.notifier).fetchUsers();
                  },
                  child: const Text('请求成功(模拟)'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(userListProvider.notifier)
                        .fetchUsers(simulateError: true);
                  },
                  child: const Text('请求失败(模拟)'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(userListProvider.notifier)
                        .fetchUsers(randomError: true);
                  },
                  child: const Text('随机失败'),
                ),
                OutlinedButton(
                  onPressed: () {
                    ref.read(userListProvider.notifier).clear();
                  },
                  child: const Text('clear 本地状态'),
                ),
                OutlinedButton(
                  onPressed: () {
                    ref.read(userListProvider.notifier).promoteFirstUserLevel();
                  },
                  child: const Text('提升第 1 个用户等级'),
                ),
                TextButton(
                  onPressed: () {
                    /// 【重点：ref.invalidate】让 provider 失效并重建（会触发 Notifier 的 build()）
                    /// 适合“恢复初始状态 + 重新走初始化逻辑”
                    ref.invalidate(userListProvider);
                  },
                  child: const Text('invalidate(重建并初始化加载)'),
                ),
              ],
            ),

            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),

            Expanded(
              child: Stack(
                children: [
                  if (users.isEmpty && !state.isLoading)
                    const Center(child: Text('暂无数据，点上面的按钮发起请求')),
                  ListView.separated(
                    itemCount: users.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final u = users[index];
                      return ListTile(
                        title: Text(u.name),
                        subtitle: Text('id=${u.id}  level=${u.level}'),
                      );
                    },
                  ),
                  if (state.isLoading)
                    const Positioned.fill(
                      child: ColoredBox(
                        color: Color(0x33FFFFFF),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

