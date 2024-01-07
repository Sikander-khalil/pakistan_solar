import 'package:firebase_database/firebase_database.dart';

class PanelWidgets {
  static final DatabaseReference _userRef2 =
      FirebaseDatabase.instance.reference().child('users');

  static Future<List<Map<String, dynamic>>> fetchDataForPanel(
      String category) async {
    List<Map<String, dynamic>> fetchedData = [];

    try {
      DatabaseEvent snapshot = await _userRef2.once();

      if (snapshot.snapshot.value != null) {
        Map<dynamic, dynamic>? usersData =
            snapshot.snapshot.value as Map<dynamic, dynamic>?;

        if (usersData != null) {
          usersData.forEach((key, value) {
            if (value[category] != null &&
                value[category] is Map<dynamic, dynamic>) {
              String fullName = value['fullName'] ?? '';
              String phone = value['phone'] ?? '';
              String image = value['image'] ?? '';

              (value[category] as Map<dynamic, dynamic>)
                  .forEach((catKey, catValue) {
                if (catValue is Map<dynamic, dynamic>) {
                  Map<String, dynamic> catData = {
                    'fullName': fullName,
                    'phone': phone,
                    'image': image,
                    'Available': catValue['Available'] ?? '',
                    'Location': catValue['Location'] ?? '',
                    'Number': catValue['Number'] ?? '',
                    'Price': catValue['Price'] ?? '',
                    'Size': catValue['Size'] ?? '',
                    'SubCategories': catValue['SubCategories'] ?? '',
                    'Type': catValue['Type'] ?? '',
                  };
                  fetchedData.add(catData);
                }
              });
            }
          });

          fetchedData.sort((a, b) {
            var priceA = double.tryParse(a['Price'] ?? '0');
            var priceB = double.tryParse(b['Price'] ?? '0');

            bool isPriceAEqualTo45 = (priceA != null && priceA == 45.0);
            bool isPriceBEqualTo45 = (priceB != null && priceB == 45.0);

            if (isPriceAEqualTo45 && !isPriceBEqualTo45) {
              return -1;
            } else if (!isPriceAEqualTo45 && isPriceBEqualTo45) {
              return 1;
            } else if (priceA != null && priceB != null) {
              if (!isPriceAEqualTo45 && !isPriceBEqualTo45) {
                return priceA.compareTo(priceB);
              }
            }

            return 0;
          });
        }
      }
    } catch (e) {
      print('Error: $e');
    }

    return fetchedData;
  }

  static Future<double> getMarketRate() async {
    double marketRate = 0;

    try {
      DatabaseReference marketDataRef = FirebaseDatabase.instance
          .reference()
          .child('marketPrice')
          .child('Rate');
      DatabaseEvent snapshot = await marketDataRef.once();

      if (snapshot.snapshot.value != null) {
        Map<dynamic, dynamic> marketData = snapshot.snapshot.value as Map;
        marketRate = marketData['Price'];
      }
    } catch (e) {
      print('Error: $e');
    }

    return marketRate;
  }
}
