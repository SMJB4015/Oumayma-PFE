import 'package:dealdiscover/screens/dealDetails_screen.dart';
import 'package:dealdiscover/screens/menus/bottomnavbar.dart';
import 'package:dealdiscover/screens/UserScreens/calendar_screen.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_states.dart';
import '../../blocs/pub/pub_bloc.dart';
import '../../blocs/pub/pub_events.dart';
import '../../blocs/pub/pub_states.dart';
import '../../model/plan.dart';
import '../../model/pub.dart';
import '../../repo/auth_repo.dart';
import '../../repo/pub_repo.dart';

class AddPlanningScreen extends StatefulWidget {
  final Pub pub;
  const AddPlanningScreen({super.key ,required this.pub});

  @override
  State<AddPlanningScreen> createState() => _AddPlanningScreenState();
}

class _AddPlanningScreenState extends State<AddPlanningScreen> {
  late PubBloc Pubb;

  bool isLoading = false;
  DateTime? fromDate;
  DateTime? toDate;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  int numberOfPersons = 1;
  final TextEditingController _titeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _reminderController = TextEditingController();


@override
void initState() {
  Pubb=BlocProvider.of<PubBloc>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final msg=BlocBuilder<PubBloc,PubStates>(builder: (context,state){
      if(state is PubErrorState){
        return Text(state.message);
      }else if (state is PubLoadingState){
        return Center(child: CircularProgressIndicator(backgroundColor: Colors.black,),);
      }else{
        return Container();
      }
    });
    BlocListener<PubBloc,PubStates>(
        listener: (BuildContext context, PubStates state) {
          if( state is PlanPubSuccessState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Successfully Plan Added')),
            );

            // Navigate to the sign-up screen with the required BlocProvider
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => AuthBloc(LoginInitState(), AuthRepo())),
                    BlocProvider(create: (context) => PubBloc(PubInitState(), PubRepo()))
                  ],
                  child: const BottomNavBar(),
                ),
              ),
            );
          }
        });
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              loadingHandler(context,widget.pub);
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
      body:
      BlocConsumer<PubBloc,PubStates>(
      listener: (context, state){
      if( state is PlanPubSuccessState){
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully Plan Added')),
        );

    // Navigate to the sign-up screen with the required BlocProvider

        Future.delayed(Duration(seconds: 1), (){Navigator.push(context, MaterialPageRoute<BottomNavBar>(builder: (_)=>
            MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => AuthBloc(LoginInitState(), AuthRepo())),
                BlocProvider(create: (context) => PubBloc(PubInitState(), PubRepo()))
              ],
              child: const BottomNavBar(),
            )
        ));} );
    }}, builder: (context,state)
    {
     return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/add_editbg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: Column(
            children: [
              Container(
                width: 350,
                height: 655,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
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
                      child: TextField(controller: _titeController,
                        decoration: InputDecoration(
                          hintText: "Birthday Going Out",
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
                      child: TextField(controller: _addressController,
                        decoration: InputDecoration(
                          hintText: "Update your adress",
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
                      "Date & Time",
                      style: TextStyle(
                        color: MyColors.btnBorderColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Adjust alignment as needed
                      children: [
                        SizedBox(
                          width:
                              170, // Adjust width as needed for the first date picker
                          height: 55,
                          child: TextField(
                            readOnly: true,
                            onTap: () {
                              // Add logic to open date picker and set selected date to 'fromDate'
                              showDatePicker(
                                context: context,
                                initialDate: fromDate ?? DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              ).then((selectedDate) {
                                if (selectedDate != null) {
                                  setState(() {
                                    fromDate = selectedDate;
                                  });
                                }
                              });
                            },
                            decoration: InputDecoration(
                              hintText: fromDate != null
                                  ? "${DateFormat('dd-MM-yyyy').format(fromDate!)}"
                                  : "Select From Date",
                              filled: true,
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
                              suffixIcon: Icon(Icons.calendar_month_rounded),
                            ),
                          ),
                        ),
                        SizedBox(
                          width:
                              170, // Adjust width as needed for the second date picker
                          height: 55,
                          child: TextField(
                            readOnly: true,
                            onTap: () {
                              // Add logic to open date picker and set selected date to 'toDate'
                              showDatePicker(
                                context: context,
                                initialDate: toDate ?? DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              ).then((selectedDate) {
                                if (selectedDate != null) {
                                  setState(() {
                                    toDate = selectedDate;
                                  });
                                }
                              });
                            },
                            decoration: InputDecoration(
                              hintText: toDate != null
                                  ? "${DateFormat('dd-MM-yyyy').format(toDate!)}"
                                  : "Select To Date",
                              filled: true,
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
                              suffixIcon: Icon(Icons.calendar_month_rounded),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Adjust alignment as needed
                      children: [
                        SizedBox(
                          width:
                              170, // Adjust width as needed for the first time picker
                          height: 55,
                          child: TextField(
                            readOnly: true,
                            onTap: () {
                              // Add logic to open time picker and set selected time to 'fromTime'
                              showTimePicker(
                                context: context,
                                initialTime: fromTime ?? TimeOfDay.now(),
                              ).then((selectedTime) {
                                if (selectedTime != null) {
                                  setState(() {
                                    fromTime = selectedTime;
                                  });
                                }
                              });
                            },
                            decoration: InputDecoration(
                              hintText: fromTime != null
                                  ? "${fromTime!.hour}:${fromTime!.minute}"
                                  : "Select From Time",
                              filled: true,
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
                              suffixIcon: Icon(Icons.access_time),
                            ),
                          ),
                        ),
                        SizedBox(
                          width:
                              170, // Adjust width as needed for the second time picker
                          height: 55,
                          child: TextField(
                            readOnly: true,
                            onTap: () {
                              // Add logic to open time picker and set selected time to 'toTime'
                              showTimePicker(
                                context: context,
                                initialTime: toTime ?? TimeOfDay.now(),
                              ).then((selectedTime) {
                                if (selectedTime != null) {
                                  setState(() {
                                    toTime = selectedTime;
                                  });
                                }
                              });
                            },
                            decoration: InputDecoration(
                              hintText: toTime != null
                                  ? "${toTime!.hour}:${toTime!.minute}"
                                  : "Select To Time",
                              filled: true,
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
                              suffixIcon: Icon(Icons.access_time),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Number Of Persons",
                      style: TextStyle(
                        color: MyColors.btnBorderColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 350,
                      height: 55,
                      child: Container(
                        decoration: BoxDecoration(
                          color: MyColors.backbtn1,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: MyColors.btnColor,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (numberOfPersons > 1) {
                                    numberOfPersons--;
                                  }
                                });
                              },
                              icon: Icon(Icons.arrow_drop_down),
                            ),
                            Text(
                              numberOfPersons.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  numberOfPersons++;
                                });
                              },
                              icon: Icon(Icons.arrow_drop_up),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Reminder",
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
                      child: TextField(controller: _reminderController,
                        decoration: InputDecoration(
                          hintText: "Add Reminder",
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
                  ],
                ),
              ),msg,
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
                          Plan plan =
                          Plan(id: '',title: _titeController.text,address: _addressController.text, dateFrom: fromDate.toString().substring(0,10), dateTo:toDate.toString().substring(0,10) ,
                              timeFrom: fromTime.toString().substring(10,15), timeTo: toTime.toString().substring(10,15), nb_personnes: numberOfPersons, reminder: _reminderController.text);
                          Pubb.add(AddPlanPubButtonPressed(pubID: widget.pub.id, plan: plan)) ;


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
      );
    }),
    );
  }

  void loadingHandler(BuildContext context ,Pub pub) {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        isLoading = false;
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (_) =>  DealDetailsScreen(pubId: pub.id,pub: pub,),
          ),
        );
      });
    });
  }
}
