import 'package:flutter/material.dart';

import 'store.dart';

/// [RStoreNamedBuilder] allows you to create widgets that can be updated
/// manually by name (see [RStore.updateBuildersByNames])
class RStoreNamedBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, Widget? child)? builder;
  final Widget Function(BuildContext context)? onChange;
  final String name;
  final RStore store;

  /// The child widget to pass to the builder, should not be rebuilt
  final Widget? child;

  const RStoreNamedBuilder({
    Key? key,
    this.builder,
    this.onChange,
    required this.store,
    required this.name,
    this.child,
  })  : assert(name.length > 0, 'name must not be empty string'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RStoreBuilder(
      builder: builder != null
          ? (context, child) {
              return builder!.call(context, child);
            }
          : null,
      onChange: (context) => onChange?.call(context),
      child: child,
      name: name,
      store: store,
    );
  }
}

/// [RStoreContextNamedBuilder] allows you to create widgets that can be updated
/// manually by name (see [RStore.updateBuildersByNames])
class RStoreContextNamedBuilder<T extends RStore> extends StatelessWidget {
  final Widget Function(BuildContext context, T store, Widget? child)? builder;
  final Widget Function(BuildContext context, T store)? onChange;
  final String name;

  /// The child widget to pass to the builder, should not be rebuilt
  final Widget? child;

  const RStoreContextNamedBuilder({
    Key? key,
    this.builder,
    this.onChange,
    required this.name,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = RStoreWidget.store<T>(context);
    return RStoreBuilder(
      builder: builder != null
          ? (context, child) {
              return builder!.call(context, store, child);
            }
          : null,
      onChange: (context) => onChange?.call(context, store),
      child: child,
      name: name,
      store: store,
    );
  }
}

class RStoreWatchBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, Widget? child)? builder;
  final void Function(BuildContext context)? onChange;
  final List<dynamic> Function() watch;
  final RStore store;

  /// The child widget to pass to the builder, should not be rebuilt
  final Widget? child;

  const RStoreWatchBuilder({
    Key? key,
    this.builder,
    this.onChange,
    required this.store,
    required this.watch,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RStoreBuilder(
      builder: builder != null
          ? (context, child) {
              return builder!.call(context, child);
            }
          : null,
      onChange: (context) => onChange?.call(context),
      child: child,
      watch: watch,
      store: store,
    );
  }
}

class RStoreValueBuilder<V> extends StatelessWidget {
  final Widget Function(BuildContext context, V value, Widget? child)? builder;
  final void Function(BuildContext context, V value)? onChange;
  final V Function() watch;
  final RStore store;

  /// The child widget to pass to the builder, should not be rebuilt
  final Widget? child;

  const RStoreValueBuilder({
    Key? key,
    this.builder,
    this.onChange,
    required this.store,
    required this.watch,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RStoreBuilder(
      builder: builder != null
          ? (context, child) {
              return builder!.call(context, watch(), child);
            }
          : null,
      onChange: (context) => onChange?.call(context, watch()),
      child: child,
      watch: () => [watch()],
      store: store,
    );
  }
}

class RStoreContextBuilder<T extends RStore> extends StatelessWidget {
  final Widget Function(BuildContext context, T store, Widget? child)? builder;
  final void Function(BuildContext context, T store)? onChange;
  final List<dynamic> Function(T store) watch;

  /// The child widget to pass to the builder, should not be rebuilt
  final Widget? child;

  const RStoreContextBuilder({
    Key? key,
    this.builder,
    this.onChange,
    required this.watch,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = RStoreWidget.store<T>(context);
    return RStoreBuilder(
      builder: builder != null
          ? (context, child) {
              return builder!.call(context, store, child);
            }
          : null,
      onChange: (context) => onChange?.call(context, store),
      child: child,
      watch: () => watch(store),
      store: store,
    );
  }
}

class RStoreContextValueBuilder<T extends RStore, V> extends StatelessWidget {
  final Widget Function(BuildContext context, V value, Widget? child)? builder;
  final void Function(BuildContext context, V value)? onChange;
  final V Function(T store) watch;

  /// The child widget to pass to the builder, should not be rebuilt
  final Widget? child;

  const RStoreContextValueBuilder({
    Key? key,
    this.builder,
    this.onChange,
    required this.watch,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = RStoreWidget.store<T>(context);
    return RStoreBuilder(
      builder: builder != null
          ? (context, child) {
              return builder!.call(context, watch(store), child);
            }
          : null,
      onChange: (context) => onChange?.call(context, watch(store)),
      child: child,
      watch: () => [watch(store)],
      store: store,
    );
  }
}
