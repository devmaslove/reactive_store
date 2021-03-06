import 'package:flutter/material.dart';
import 'package:reactive_store/reactive_store.dart';

class SplashScreenPageStore extends RStore {
  bool showNextScreen = false;

  startTimerNextPage() {
    setTimer(
      duration: const Duration(seconds: 2),
      onTimer: () => setStore(() {
        showNextScreen = true;
      }),
    );
  }

  @override
  SplashScreenPage get widget => super.widget as SplashScreenPage;

  static SplashScreenPageStore of(BuildContext context) {
    return RStoreWidget.store<SplashScreenPageStore>(context);
  }
}

class SplashScreenPage extends RStoreWidget<SplashScreenPageStore> {
  const SplashScreenPage({
    super.key,
  });

  @override
  initRStore(store) => store.startTimerNextPage();

  @override
  Widget build(BuildContext context, SplashScreenPageStore store) {
    return Scaffold(
      appBar: AppBar(title: const Text('Splash screen')),
      body: Center(
        child: RStoreValueBuilder<bool>(
          store: store,
          watch: () => store.showNextScreen,
          onChange: (context, _) => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => const _NextPage(),
            ),
          ),
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  SplashScreenPageStore createRStore() => SplashScreenPageStore();
}

class _NextPage extends StatelessWidget {
  const _NextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Next screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Back'),
        ),
      ),
    );
  }
}
