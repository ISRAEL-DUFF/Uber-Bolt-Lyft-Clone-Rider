import 'package:cab_rider/datamodels/nearbydriver.dart';

import 'helpermethods.dart';

class FireHelper {
  static List<NearbyDriver> nearbyDriverList = [
    NearbyDriver(key: "Driver-" + HelperMethods.generateRandomNumber(60).toString())
  ];
  static void removeFromList(String key) {
    int index = nearbyDriverList.indexWhere((element) => element.key == key);
    nearbyDriverList.removeAt(index);
  }

  static void updateNearbyLocation(NearbyDriver driver) {
    int index =
        nearbyDriverList.indexWhere((element) => element.key == driver.key);
    nearbyDriverList[index].longitude = driver.longitude;
    nearbyDriverList[index].latitude = driver.latitude;
  }
}
