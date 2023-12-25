import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:pakistan_solar_market/widgets/signup_screen.dart';


class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  String _noselected = 'No item selected'; // Initial value
  String _selectedValue = ''; // Initially empty
  String _selectedValue2 = ''; // Initially emp

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

  User? user = FirebaseAuth.instance.currentUser;

  String subcategoryPrefix = '';

  DatabaseReference _userRef2 =
      FirebaseDatabase.instance.reference().child('home');

  String _selectedSize = '';
  String _selectedLocation = '';

  TextEditingController numberController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController availableController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _type = ["Buyer", "Seller"];

  var _size = ["Cont", "Pallets"];
  var _locations = ["Ex-LHR", "EX-KHI", "EX-FSD", "EX-GWJ", "EX-MULTA"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 28.0),
                    child: Text(
                      "TYPE",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
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
                      value:
                          _selectedValue2.isNotEmpty ? _selectedValue2 : null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: 'Select Type',
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
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Container(
                          width: 300,
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
                                                    _DropdownValues[newValue]!
                                                        .isNotEmpty
                                                ? _DropdownValues[newValue]![0]
                                                : '';
                                      });
                                    }
                                  },
                                  items:
                                      _DropdownValues.keys.map((String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _noselected =
                                                item; // Update selected Subcategory on tap
                                          });

                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                height: 200,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  child: Column(
                                                    children:
                                                        _DropdownValues[item]!
                                                            .map(
                                                                (String value) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: ListTile(
                                                          title: Text(value),
                                                          onTap: () {
                                                            setState(() {
                                                              _selectedValue =
                                                                  value;
                                                            });
                                                            Navigator.pop(
                                                                context);
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
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(
                            'NUMBER',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: TextFormField(
                            controller: numberController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              hintText: ' Enter Number',
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
                          subtitle: DropdownButtonFormField<String>(
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
                            value:
                                _selectedSize.isNotEmpty ? _selectedSize : null,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 20, 10, 20),
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'Select Size',
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
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: TextFormField(
                            controller: priceController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
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
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            'LOCATION',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: DropdownButtonFormField<String>(
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
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 20, 10, 20),
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: ' Locations',
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
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30),
                    child: Container(
                      height: 70,
                      child: TextFormField(
                        controller: availableController,
                        decoration: InputDecoration(
                            hintText: "Enter Availality",
                            border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                          color: Colors.red,
                          // Inside the onPressed method of the MaterialButton
                          onPressed: () async {
                            var number = numberController.text.trim();
                            var price = priceController.text.trim();
                            var available = availableController.text.trim();
                            if (user != null) {
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
                                String id = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString();
                                String subCatValue =
                                    '$_noselected | $_selectedValue';
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

                                String formattedDate = DateFormat('dd MMM yyyy')
                                    .format(DateTime.now());
                                DatabaseReference useridRef3 = FirebaseDatabase
                                    .instance
                                    .reference()
                                    .child('formatDate');

                                useridRef3.set({
                                  'Date': formattedDate,
                                  'Price': price,
                                  'Available': available,
                                });
                                if (subcategoryPrefix.isNotEmpty) {
                                  Map<String, dynamic> data2 = {
                                    'Home Cat': homeCatValue,
                                    'Price': price
                                  };
                                  String userId =
                                      FirebaseAuth.instance.currentUser!.uid;

                                  DatabaseReference postRef = FirebaseDatabase
                                      .instance
                                      .reference()
                                      .child('users')
                                      .child(userId);
                                  String? postId = postRef.push().key;

                                  await postRef
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
                                  Fluttertoast.showToast(
                                      msg: 'Invalid subcategory');
                                }
                              } catch (e) {
                                print(e.toString());
                                progressDialog.dismiss();
                                Fluttertoast.showToast(
                                    msg: 'Failed to add data');
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Not Login ! Please Sign Up');
                              Future.delayed(Duration(seconds: 2), () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen()));
                              });
                            }
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
