import 'package:dealdiscover/screens/PartnerScreens/deals_management_screen.dart';
import 'package:dealdiscover/screens/menus/hidden_drawer.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class AddDealScreen extends StatefulWidget {
  const AddDealScreen({super.key});

  @override
  State<AddDealScreen> createState() => _AddDealScreenState();
}

class _AddDealScreenState extends State<AddDealScreen> {
  String? stateValue;
  bool isLoading = false;
  //DateTime? fromDate;
  //DateTime? toDate;
  //TimeOfDay? fromTime;
  //TimeOfDay? toTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              loadingHandler(context);
            },
            child: Container(
              margin: EdgeInsets.only(right: 330),
              child: Image.asset(
                'assets/images/arrowL.png',
                width: 45.0,
                height: 45.0,
              ),
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/partnerbg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Center child widgets horizontally
                children: [
                  Image.asset(
                    'assets/images/addP.png',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Add An Image",
                    style: TextStyle(
                      color: MyColors.btnBorderColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                width: 350,
                height: 655,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Title",
                      style: TextStyle(
                        color: MyColors.btnBorderColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 350, // Adjust width as needed
                      height: 55, // Adjust height as needed
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Write Your Title",
                          filled:
                              true, // Set to true to fill the TextField background
                          fillColor: MyColors.backbtn1,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.btnColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.btnBorderColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Adress",
                      style: TextStyle(
                        color: MyColors.btnBorderColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 350, // Adjust width as needed
                      height: 55, // Adjust height as needed
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Write Your Adress",
                          filled:
                              true, // Set to true to fill the TextField background
                          fillColor: MyColors.backbtn1,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.btnColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.btnBorderColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Description",
                      style: TextStyle(
                        color: MyColors.btnBorderColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 350, // Adjust width as needed
                      height: 55, // Adjust height as needed
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Write Your Description",
                          filled:
                              true, // Set to true to fill the TextField background
                          fillColor: MyColors.backbtn1,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.btnColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: MyColors.btnBorderColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Deal State",
                      style: TextStyle(
                        color: MyColors.btnBorderColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 55, // Adjust height as needed
                      decoration: BoxDecoration(
                        color: MyColors.backbtn1,
                        border: Border.all(
                            color: MyColors.btnColor), // White border
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        // Add horizontal padding
                        child: Row(
                          children: [
                            // Gender radio buttons
                            Radio<String>(
                              value: "promo",
                              groupValue: stateValue,
                              onChanged: (value) {
                                setState(() {
                                  stateValue = value;
                                });
                              },
                              activeColor: MyColors
                                  .btnBorderColor, // Change the color of the selected radio button
                            ),
                            Text("Promo"),
                            Radio<String>(
                              value: "not in promo",
                              groupValue: stateValue,
                              onChanged: (value) {
                                setState(() {
                                  stateValue = value;
                                });
                              },
                              activeColor: MyColors
                                  .btnBorderColor, // Change the color of the selected radio button
                            ),
                            Text("Not in Promo"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  // Adjust the left margin as needed
                  child: Center(
                    child: SizedBox(
                      height: 60, // Adjust height as needed
                      width: 350, // Make button full width
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DealsManagementScreen(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              MyColors.btnColor),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.white,
                                width: 4,
                              ), // Add white border
                            ),
                          ),
                        ),
                        child: Text(
                          "Done",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  void loadingHandler(BuildContext context) {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        isLoading = false;
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (_) => const HiddenDrawer(),
          ),
        );
      });
    });
  }
}
