import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigClass {
  final remoteconfig = FirebaseRemoteConfig.instance;

  Future<String> initializeConfig() async {
    await remoteconfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await remoteconfig.fetchAndActivate();

    var temp = remoteconfig.getString('dummy_data');
    // print(temp);

    return temp;
  }

  Future<String> initializeConfigoffer() async {
    await remoteconfig.fetchAndActivate();
    await remoteconfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 1),
      minimumFetchInterval: const Duration(seconds: 1),
    ));

    var temp = remoteconfig.getString('dummy_details');
    return temp;
  }
}
