import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:ndialog/ndialog.dart';

import '../constant/colors.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> with SingleTickerProviderStateMixin {
  String _noselected = 'No item selected'; // Initial value
  String _inverternoselected = 'No item selected'; //
  String _selectedValue = ''; // Initially empty

  String _inverterselectedValue = ''; // Initially empty
  String _selectedValue2 = ''; // Initially emp

  String _inverterselectedValue2 = ''; // Initially emp

  Map<String, List<String>> _DropdownValues = {
    'Longi Himo 5': ['555', '560'],
    'Longi Himo 6': ['570', '575', '580', '585'],
    'Jinko P-Type': ['550', '555'],
    'Jinko N-Type': ['575', '580'],
    'Jinko N-Type Bi-Facial': ['580', '575'],
    'JA': ['545', '550', '555'],
    'JA Bi-Facial': ['545', '550', '555'],
    'Canadian P-type': ['550', '555'],
    'Canadian N-type Bi-Facial Topcon': ['570', '575'],
  };

  Map<String, List<String>> _inverterDropdownValues = {
    'GROWATT': ['10KW', '15KW', '20KW', '30KW'],
    'SOLIS': ['5KW', '10KW', '15KW'],
    'LEVOLTEC': ['6KW'],
    'KNOX': ['6KW'],
  };

  User? user = FirebaseAuth.instance.currentUser;

  String subcategoryPrefix = '';

  String invertersubcategoryPrefix = '';

  DatabaseReference _userRef2 =
      FirebaseDatabase.instance.reference().child('home');

  DatabaseReference _invereteruserRef2 =
      FirebaseDatabase.instance.reference().child('homeInverter');

  String _selectedSize = '';

  String _inverterselectedSize = '';

  String _selectedLocation = '';

  String _inverterselectedLocation = '';

  late TabController _tabController;

  TextEditingController numberController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController availableController = TextEditingController();

  TextEditingController inverternumberController = TextEditingController();
  TextEditingController inverterpriceController = TextEditingController();
  TextEditingController inverteravailableController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  dynamic userkey;
  dynamic userkey2;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getAllUserData();
    getAllUserData2();
  }

  Future<void> getAllUserData() async {
    DatabaseReference _userRef =
        FirebaseDatabase.instance.reference().child('users');

    DatabaseEvent dataSnapshot = await _userRef.once();

    if (dataSnapshot.snapshot.value != null) {
      Map<dynamic, dynamic> users = dataSnapshot.snapshot.value as Map;

      users.forEach((key, value) {
        // var fullName = value['fullName'];
        // var phone = value['phone'];

        userkey = key;
        // print('Full Name: $fullName');
        // print('Phone: $phone');
      });
    } else {
      print('No data found');
    }
  }

  Future<void> getAllUserData2() async {
    DatabaseReference _inverteruserRef =
        FirebaseDatabase.instance.reference().child('usersinverter');

    DatabaseEvent inverterdataSnapshot = await _inverteruserRef.once();

    if (inverterdataSnapshot.snapshot.value != null) {
      Map<dynamic, dynamic> inverterusers =
          inverterdataSnapshot.snapshot.value as Map;

      inverterusers.forEach((key, value) {
        // var fullName = value['fullName'];
        // var phone = value['phone'];

        userkey2 = key;
        // print('Full Name: $fullName');
        // print('Phone: $phone');
      });
    } else {
      print('No data found');
    }
  }

  var _type = ["Buyer", "Seller"];

  var _invertertype = ["Buyer", "Seller"];

  var _size = ["Cont", "Pallets"];
  var _invertersize = ["Cont", "Pallets"];

  var _locations = ["Ex-LHR", "EX-KHI", "EX-FSD", "EX-GWJ", "EX-MULTA"];

  var _inverterlocations = ["Ex-LHR", "EX-KHI", "EX-FSD", "EX-GWJ", "EX-MULTA"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                  indicatorColor: Color(0xff18be88),
                  labelColor: Colors.black,
                  dividerColor: Colors.grey,
                  tabs: [
                    Tab(text: 'Panel Market'),
                    Tab(text: 'Inverter Market'),
                  ],
                  controller: _tabController,
                ),
                Expanded(
                    child: TabBarView(
                  controller: _tabController,
                  children: [
                    BuildPanelData(),
                    BuildInverterData(),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  BuildPanelData() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 28.0),
              child: Text(
                "TYPE",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Container(
                height: 60,
                child: DropdownButtonFormField<String>(
                  items: _type.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Row(
                        children: <Widget>[
                          Text(category),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedValue2 = newValue!;
                    });
                  },
                  value: _selectedValue2.isNotEmpty ? _selectedValue2 : null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Select Type',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.only(left: 28.0),
              child: Text(
                "NAME",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Container(
                    width: 280,
                    height: 55,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        TextFormField(
                          controller: TextEditingController(
                            text: '$_noselected | $_selectedValue',
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText:
                                'Enter your text', // Optional placeholder text

                            // You can add other InputDecoration properties here
                          ),
                        ),
                        Positioned(
                          right: 10,
                          child: DropdownButton<String>(
                            underline: Container(
                              height: 0,
                            ),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _noselected =
                                      newValue; // Update selected Subcategory
                                  _selectedValue =
                                      _DropdownValues[newValue] != null &&
                                              _DropdownValues[newValue]!.isNotEmpty
                                          ? _DropdownValues[newValue]![0]
                                          : '';
                                });
                              }
                            },
                            items: _DropdownValues.keys.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _noselected =
                                          item; // Update selected Subcategory on tap
                                    });

                                    if (_noselected.isNotEmpty) {
                                      Navigator.pop(context);
                                    }

                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 200,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Column(
                                              children: _DropdownValues[item]!
                                                  .map((String value) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ListTile(
                                                    title: Text(value),
                                                    onTap: () {
                                                      setState(() {
                                                        _selectedValue = value;
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(item),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      'NUMBER',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: 60,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: numberController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8))),
                            hintText: ' Enter Number',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      'SIZE',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: 60,
                        child: DropdownButtonFormField<String>(
                          items: _size.map((String size) {
                            return DropdownMenuItem<String>(
                              value: size,
                              child: Row(
                                children: <Widget>[
                                  Text(size),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedSize = newValue!;
                            });
                          },
                          value: _selectedSize.isNotEmpty ? _selectedSize : null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: 'Select Size',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      'PRICE IN RS',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: 60,
                        child: TextFormField(
                          controller: priceController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8))),
                            hintText: 'Enter Price',
                          ),
                          validator: (value) {
                            if (double.tryParse(value!) == null ||
                                double.parse(value) <= 45) {
                              return 'Price should be a number greater than 45';
                            }
                            return null;
                          },
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      'LOCATION',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: 60,
                        child: DropdownButtonFormField<String>(
                          items: _locations.map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Row(
                                children: <Widget>[
                                  Text(category),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedLocation = newValue!;
                            });
                          },
                          value: _selectedLocation.isNotEmpty
                              ? _selectedLocation
                              : null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: ' Locations',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.only(left: 28.0),
              child: Text(
                "AVAILABILITY",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30),
              child: Container(
                height: 55,
                child: TextFormField(
                  controller: availableController,
                  decoration: InputDecoration(
                      hintText: "Enter Availality", border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  child: MaterialButton(
                      color: primaryColor,
                      // Inside the onPressed method of the MaterialButton
                      onPressed: () async {
                        var number = numberController.text.trim();
                        var price = priceController.text.trim();
                        var available = availableController.text.trim();
                        if (user != null &&
                            userkey != null &&
                            number.isNotEmpty &&
                            price.isNotEmpty &&
                            available.isNotEmpty &&
                            _selectedValue2.isNotEmpty &&
                            _selectedSize.isNotEmpty &&
                            _selectedLocation.isNotEmpty &&
                            _selectedValue.isNotEmpty) {
                          ProgressDialog progressDialog = ProgressDialog(
                            context,
                            title: const Text(
                              'Adding Market List',
                              style: TextStyle(color: Colors.black),
                            ),
                            message: const Text(
                              'Please wait',
                              style: TextStyle(color: Colors.black),
                            ),
                            backgroundColor: Colors.white,
                          );

                          try {
                            progressDialog.show();
                            String id =
                                DateTime.now().millisecondsSinceEpoch.toString();
                            String subCatValue = '$_noselected | $_selectedValue';
                            String homeCatValue = _noselected;

                            if (_noselected.contains('Longi')) {
                              subcategoryPrefix = 'Longi';
                            } else if (_noselected.contains('Jinko')) {
                              subcategoryPrefix = 'Jinko';
                            } else if (_noselected.contains('JA')) {
                              subcategoryPrefix = 'JA';
                            } else if (_noselected.contains('Canadian')) {
                              subcategoryPrefix = 'Canadian';
                            }

                            if (subcategoryPrefix.isNotEmpty) {
                              Map<String, dynamic> data2 = {
                                'Home Cat': homeCatValue,
                                'Price': price
                              };

                              DatabaseReference userPostsRef = FirebaseDatabase
                                  .instance
                                  .reference()
                                  .child('users')
                                  .child(userkey);
                              String? postId = userPostsRef.push().key;

                              await userPostsRef
                                  .child(subcategoryPrefix)
                                  .child(postId!)
                                  .set({
                                'Type': _selectedValue2,
                                "SubCategories": subCatValue,
                                'Number': number,
                                'Size': _selectedSize,
                                'Price': price,
                                'Location': _selectedLocation,
                                'Available': available,
                              });
                              _userRef2.child(id).set(data2);
                              progressDialog.dismiss();
                              numberController.clear();

                              priceController.clear();
                              availableController.clear();
                              setState(() {
                                _selectedValue2 = '';
                                _selectedValue = '';
                                _noselected = _selectedValue;

                                _selectedSize = '';
                                _selectedLocation = '';
                                _selectedValue = '';
                              });
                              progressDialog.dismiss();
                              Fluttertoast.showToast(msg: 'Success');
                            } else {
                              Fluttertoast.showToast(msg: 'Invalid subcategory');
                            }
                          } catch (e) {
                            print(e.toString());
                            progressDialog.dismiss();
                            Fluttertoast.showToast(msg: 'Failed to add data');
                          }
                        } else {
                          Fluttertoast.showToast(msg: 'Please fill the Fields');
                        }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  BuildInverterData() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 28.0),
              child: Text(
                "TYPE",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Container(
                height: 60,
                child: DropdownButtonFormField<String>(
                  items: _invertertype.map((String invertercategory) {
                    return DropdownMenuItem<String>(
                      value: invertercategory,
                      child: Row(
                        children: <Widget>[
                          Text(invertercategory),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _inverterselectedValue2 = newValue!;
                    });
                  },
                  value: _inverterselectedValue2.isNotEmpty
                      ? _inverterselectedValue2
                      : null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Select Type',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.only(left: 28.0),
              child: Text(
                "NAME",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Container(
                    width: 280,
                    height: 55,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        TextFormField(
                          controller: TextEditingController(
                            text: '$_inverternoselected | $_inverterselectedValue',
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText:
                                'Enter your text', // Optional placeholder text

                            // You can add other InputDecoration properties here
                          ),
                        ),
                        Positioned(
                          right: 10,
                          child: DropdownButton<String>(
                            underline: Container(
                              height: 0,
                            ),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _inverternoselected =
                                      newValue; // Update selected Subcategory
                                  _inverterselectedValue =
                                      _inverterDropdownValues[newValue] != null &&
                                              _inverterDropdownValues[newValue]!
                                                  .isNotEmpty
                                          ? _inverterDropdownValues[newValue]![0]
                                          : '';
                                });
                              }
                            },
                            items: _inverterDropdownValues.keys.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _inverternoselected =
                                          item; // Update selected Subcategory on tap
                                    });

                                    if (_inverternoselected.isNotEmpty) {
                                      Navigator.pop(context);
                                    }

                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 200,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Column(
                                              children:
                                                  _inverterDropdownValues[item]!
                                                      .map((String value) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ListTile(
                                                    title: Text(value),
                                                    onTap: () {
                                                      setState(() {
                                                        _inverterselectedValue =
                                                            value;
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(item),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      'NUMBER',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: 60,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: inverternumberController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8))),
                            hintText: ' Enter Number',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      'SIZE',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: 60,
                        child: DropdownButtonFormField<String>(
                          items: _invertersize.map((String size) {
                            return DropdownMenuItem<String>(
                              value: size,
                              child: Row(
                                children: <Widget>[
                                  Text(size),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _inverterselectedSize = newValue!;
                            });
                          },
                          value: _inverterselectedSize.isNotEmpty
                              ? _inverterselectedSize
                              : null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: 'Select Size',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      'PRICE IN RS',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: 60,
                        child: TextFormField(
                          controller: inverterpriceController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8))),
                            hintText: 'Enter Price',
                          ),
                          validator: (value) {
                            if (double.tryParse(value!) == null ||
                                double.parse(value) <= 45) {
                              return 'Price should be a number greater than 45';
                            }
                            return null;
                          },
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      'LOCATION',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: 60,
                        child: DropdownButtonFormField<String>(
                          items: _inverterlocations.map((String invertercategory) {
                            return DropdownMenuItem<String>(
                              value: invertercategory,
                              child: Row(
                                children: <Widget>[
                                  Text(invertercategory),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _inverterselectedLocation = newValue!;
                            });
                          },
                          value: _inverterselectedLocation.isNotEmpty
                              ? _inverterselectedLocation
                              : null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: ' Locations',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.only(left: 28.0),
              child: Text(
                "AVAILABILITY",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30),
              child: Container(
                height: 55,
                child: TextFormField(
                  controller: inverteravailableController,
                  decoration: InputDecoration(
                      hintText: "Enter Availality", border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  child: MaterialButton(
                      color: primaryColor,
                      // Inside the onPressed method of the MaterialButton
                      onPressed: () async {
                        var inverternumber = inverternumberController.text.trim();
                        var inverterprice = inverterpriceController.text.trim();
                        var inverteravailable =
                            inverteravailableController.text.trim();
                        if (user != null &&
                            userkey2 != null &&
                            inverternumber.isNotEmpty &&
                            inverterprice.isNotEmpty &&
                            inverteravailable.isNotEmpty &&
                            _inverterselectedValue2.isNotEmpty &&
                            _inverterselectedSize.isNotEmpty &&
                            _inverterselectedLocation.isNotEmpty &&
                            _inverterselectedValue.isNotEmpty) {
                          ProgressDialog progressDialog = ProgressDialog(
                            context,
                            title: const Text(
                              'Adding Market List',
                              style: TextStyle(color: Colors.black),
                            ),
                            message: const Text(
                              'Please wait',
                              style: TextStyle(color: Colors.black),
                            ),
                            backgroundColor: Colors.white,
                          );

                          try {
                            progressDialog.show();
                            String id =
                                DateTime.now().millisecondsSinceEpoch.toString();
                            String invertersubCatValue =
                                '$_inverternoselected | $_inverterselectedValue';
                            String inverterhomeCatValue = _inverternoselected;

                            if (_inverternoselected.contains('GROWATT')) {
                              invertersubcategoryPrefix = 'GROWATT';
                            } else if (_inverternoselected.contains('SOLIS')) {
                              invertersubcategoryPrefix = 'SOLIS';
                            } else if (_inverternoselected.contains('LEVOLTEC')) {
                              invertersubcategoryPrefix = 'LEVOLTEC';
                            } else if (_inverternoselected.contains('KNOX')) {
                              invertersubcategoryPrefix = 'KNOX';
                            }

                            if (invertersubcategoryPrefix.isNotEmpty) {
                              Map<String, dynamic> inverterdata2 = {
                                'Home Inverter': inverterhomeCatValue,
                                'Price': inverterprice
                              };

                              DatabaseReference inverteruserPostsRef =
                                  FirebaseDatabase.instance
                                      .reference()
                                      .child('usersinverter')
                                      .child(userkey2);
                              String? inverterpostId =
                                  inverteruserPostsRef.push().key;

                              await inverteruserPostsRef
                                  .child(invertersubcategoryPrefix)
                                  .child(inverterpostId!)
                                  .set({
                                'Type': _inverterselectedValue2,
                                "SubCategories": invertersubCatValue,
                                'Number': inverternumber,
                                'Size': _inverterselectedSize,
                                'Price': inverterprice,
                                'Location': _inverterselectedLocation,
                                'Available': inverteravailable,
                              });
                              _invereteruserRef2.child(id).set(inverterdata2);
                              progressDialog.dismiss();
                              inverternumberController.clear();

                              inverterpriceController.clear();
                              inverteravailableController.clear();
                              setState(() {
                                _inverterselectedValue2 = '';
                                _inverterselectedValue = '';
                                _inverternoselected = _inverterselectedValue;

                                _inverterselectedSize = '';
                                _inverterselectedLocation = '';
                                _inverterselectedValue = '';
                              });
                              progressDialog.dismiss();
                              Fluttertoast.showToast(msg: 'Success');
                            } else {
                              Fluttertoast.showToast(msg: 'Invalid subcategory');
                            }
                          } catch (e) {
                            print(e.toString());
                            progressDialog.dismiss();
                            Fluttertoast.showToast(msg: 'Failed to add data');
                          }
                        } else {
                          Fluttertoast.showToast(msg: 'Please fill the Fields');
                        }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
