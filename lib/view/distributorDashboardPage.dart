import 'package:flutter/material.dart';
import 'package:tmdb/controllers/distributor_Dashboard_Controller.dart';
import 'package:tmdb/models/distributor_dashboard_model.dart';
import  'package:tmdb/services/app_constants.dart';

class DistributorDashboardPage extends StatefulWidget {
  const DistributorDashboardPage({Key? key}) : super(key: key);

  @override
  _DistributorDashboardPageState createState() => _DistributorDashboardPageState();
}

class _DistributorDashboardPageState extends State<DistributorDashboardPage> {

  final DistributorDashboardController distributorDashboardController = DistributorDashboardController();
  final currentDate = DateTime.now().toString();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    distributorDashboardController.fetchDistributorDashboardData();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    distributorDashboardController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f1f1),
      appBar: AppBar(
        leading: Icon(Icons.menu),
        backgroundColor: Color(0xffffffff),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome',
              style: TextStyle(
                color: Color(0xff4d4d4d),
                fontSize: 16.0,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Mr. Abdul Kabir",
              style: TextStyle(
                  color: Color(0xff4d4d4d),
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: StreamBuilder<DistributorDashboardModel>(
        stream: distributorDashboardController.distributorDashboardStream,
        builder: (c,s){
          if (s.connectionState != ConnectionState.active) {
            print("all connection");
            return Container(height: 300,
                alignment: Alignment.center,
                child: Center(
                  heightFactor: 50, child: CircularProgressIndicator(
                  color: Colors.black,
                ),));
          }
          else if (s.hasError) {
            print("as3 error");
            return Container(height: 300,
              alignment: Alignment.center,
              child: Text("Error Loading Data",),);
          }
          else if (s.data
              .toString()
              .isEmpty) {
            print("as3 empty");
            return Container(height: 300,
              alignment: Alignment.center,
              child: Text("No Data Found",),);
          }
          else {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10,bottom: 10),
              child: ListView(
                children: [
                  // GetBuilder<DistDashboardController>(builder: (_) {
                  //   if (distDashboardController.tap == true) {
                  //     return SizedBox(
                  //       height: 0.0,
                  //     );
                  //   } else {
                  //     return Container(
                  //       decoration: BoxDecoration(
                  //           color: Color(0xfffffaf3),
                  //           border: Border.all(
                  //             color: Color(0xffccbea0),
                  //             width: 1,
                  //           ),
                  //           borderRadius: BorderRadius.all(Radius.circular(5))),
                  //       child: Padding(
                  //         padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
                  //         child: Column(
                  //           mainAxisSize: MainAxisSize.max,
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.stretch,
                  //           children: [
                  //             Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text(
                  //                   'Notification',
                  //                   style: TextStyle(
                  //                     color: Color(0xff957035),
                  //                     fontWeight: FontWeight.bold,
                  //                     fontSize: 16.0,
                  //                   ),
                  //                 ),
                  //                 GestureDetector(
                  //                     onTap: () {
                  //                       distDashboardController.onTapButton();
                  //                     },
                  //                     child: Icon(
                  //                       Icons.clear,
                  //                       size: 20,
                  //                       color: Color(0xff7a4d05),
                  //                     ))
                  //               ],
                  //             ),
                  //             Row(
                  //               children: [
                  //                 Text('Please go to settings and update your ',
                  //                     style: TextStyle(
                  //                       color: Color(0xff957035),
                  //                       fontWeight: FontWeight.normal,
                  //                       fontSize: 14.0,
                  //                     )),
                  //                 GestureDetector(
                  //                   onTap: () {},
                  //                   child: Text('KYC',
                  //                       style: TextStyle(
                  //                         color: Color(0xff0057a2),
                  //                         fontWeight: FontWeight.normal,
                  //                         decoration: TextDecoration.underline,
                  //                         fontSize: 14.0,
                  //                       )),
                  //                 ),
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   }
                  // }),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                      ),
                      color: AppConstants.backgroundColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0,top: 10,right: 15,bottom: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                              height: 50,
                              width: 50,
                              color: AppConstants.darkGreyColor,
                              image: AssetImage('assets/balanceicon.png'),
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                    //  distDashboardController.onTapTotalOutstanding();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: AppConstants.lightGreyColor,width: 0.2),
                                        borderRadius: BorderRadius.circular(5.0),
                                        color: Color(0xffbaba63).withOpacity(0.40),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Outstanding: ",
                                              style: TextStyle(
                                                  color: AppConstants.darkGreyColor,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              s.data!.outstanding!.total.toString(),
                                              style: TextStyle(
                                                color: AppConstants.darkGreyColor,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppConstants.lightGreyColor,width: 0.2),
                                            borderRadius: BorderRadius.circular(
                                              5.0,
                                            ),
                                            color:
                                            Color(0xffbaba63).withOpacity(0.40),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0,
                                                top: 10.0,
                                                bottom: 10.0,
                                                right: 10.0),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Dekalb/RUP (Rs.)",
                                                  style: TextStyle(
                                                      color: AppConstants
                                                          .darkGreyColor,
                                                      fontSize: 12.0,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  s.data!.outstanding!.p08.toString(),
                                                  style: TextStyle(
                                                    color: AppConstants.darkGreyColor,
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppConstants.lightGreyColor,width: 0.2),
                                            borderRadius: BorderRadius.circular(
                                              5.0,
                                            ),
                                            color:
                                            Color(0xffbaba63).withOpacity(0.40),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0,
                                                top: 10.0,
                                                bottom: 10.0,
                                                right: 10.0),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "CP/Seeds/ES (Rs.)",
                                                  style: TextStyle(
                                                      color: AppConstants
                                                          .darkGreyColor,
                                                      fontSize: 12.0,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  s.data!.outstanding!.pBC.toString(),
                                                  style: TextStyle(
                                                    color:
                                                    AppConstants.darkGreyColor,
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ]),
                          ]),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                      ),
                      color: AppConstants.backgroundColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0,top: 10,right: 15,bottom: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                              height: 50,
                              width: 50,
                              color: AppConstants.darkGreyColor,
                              image: AssetImage('assets/walleticon.png'),
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Overdues: ",
                                          style: TextStyle(
                                              color: AppConstants.darkGreyColor,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          s.data!.overdues!.total.toString(),
                                          style: TextStyle(
                                            color: AppConstants.darkGreyColor,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Dekalb/RUP (Rs.)",
                                              style: TextStyle(
                                                  color: AppConstants
                                                      .darkGreyColor,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              s.data!.overdues!.p08.toString(),
                                              style: TextStyle(
                                                color: AppConstants.darkGreyColor,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "CP/Seeds/ES (Rs.)",
                                              style: TextStyle(
                                                  color: AppConstants
                                                      .darkGreyColor,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              s.data!.overdues!.pBC.toString(),
                                              style: TextStyle(
                                                color:
                                                AppConstants.darkGreyColor,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ]),
                          ]),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height:50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color(0xff11d3ef),
                    ),
                    child: GestureDetector(
                      onTap: () {
                     //   distDashboardController.onTapViewBalance();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppConstants.lightGreyColor,width: 0.1),
                            borderRadius: BorderRadius.circular(
                              5.0,
                            ),
                            color: Color(0xff46cfde).withOpacity(0.40),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset("assets/vsa_icon.png"),
                                Text(
                                  "View Statement of Account",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xffebc29f),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0),
                          bottomRight: Radius.circular(5.0),
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10,right: 10, bottom: 10,top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image(
                                  height: 45,
                                  width: 55.3,
                                  color: AppConstants.darkGreyColor,
                                  image: AssetImage('assets/cardicon.png'),
                                ),
                                SizedBox(width: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "My Credit Limit with",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: AppConstants.darkGreyColor,
                                          letterSpacing: 0.02),
                                    ),
                                    SizedBox(width: 10,),
                                    Image(
                                      height: 46,
                                      width: 46,
                                      image: AssetImage('assets/bayericon.png'),
                                    ),
                                  ],
                                ),

                              ]),
                          Column(
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 6.6, bottom: 8.5),
                              //   child: DottedLine(
                              //     direction: Axis.horizontal,
                              //     lineLength: double.infinity,
                              //     lineThickness: 0.5,
                              //     dashLength: 2.0,
                              //     dashColor: Colors.white,
                              //     dashGapLength: 2.0,
                              //     dashGapRadius: 0.0,
                              //   ),
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Total: "+ "${s.data!.creditlimitWithMfg!.total.toString()}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppConstants.darkGreyColor,
                                        letterSpacing: 0.02,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "As on " + "${currentDate}".split(" ").first,
                                    style: TextStyle(
                                        fontSize: 8,
                                        color: AppConstants.darkGreyColor,
                                        letterSpacing: 0.02),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 9,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Dekalb/RUP : Rs. ",
                                    style: TextStyle(
                                        fontSize: 14.0, color: Color(0xff817a7a)),
                                  ),
                                  Text(
                                    s.data!.creditlimitWithMfg!.p08.toString(),
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xff817a7a),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              LinearProgressIndicator(
                                  backgroundColor: Colors.white,
                                  value: 0.8,
                                  valueColor: AlwaysStoppedAnimation(
                                    Color(0xff917575),
                                  )),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "SPENT  1,80,000",
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Color(0xff272727),
                                      letterSpacing: 0.02,
                                    ),
                                  ),
                                  Text(
                                    "AVAILABLE  2,00,000",
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Color(0xff272727),
                                      letterSpacing: 0.02,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 9,),
                              Row(
                                children: [
                                  Text(
                                    "CP/Seeds/ES : Rs. ",
                                    style: TextStyle(
                                        fontSize: 14.0, color: Color(0xff817a7a)),
                                  ),
                                  Text(
                                    s.data!.creditlimitWithMfg!.pBC.toString(),
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xff817a7a),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              LinearProgressIndicator(
                                  backgroundColor: Colors.white,
                                  value: 0.3,
                                  valueColor: AlwaysStoppedAnimation(
                                    Color(0xff757f91),
                                  )),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "SPENT  40,000",
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Color(0xff272727),
                                      letterSpacing: 0.02,
                                    ),
                                  ),
                                  Text(
                                    "AVAILABLE  1,80,000",
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Color(0xff272727),
                                      letterSpacing: 0.02,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xffebc29f),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0),
                          bottomRight: Radius.circular(5.0),
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10,right: 10, bottom: 10,top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image(
                                  height: 45,
                                  width: 55.3,
                                  color: AppConstants.darkGreyColor,
                                  image: AssetImage('assets/cardicon.png'),
                                ),
                                SizedBox(width: 20,),
                                Text(
                                  "My Credit Limit with Bank",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppConstants.darkGreyColor,
                                      letterSpacing: 0.02),
                                ),
                              ]),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Total: "+s.data!.creditlimitWithBank!.total.toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppConstants.darkGreyColor,
                                    letterSpacing: 0.02,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "As on " + "${currentDate}".split(" ").first,
                                style: TextStyle(
                                    fontSize: 8,
                                    color: AppConstants.darkGreyColor,
                                    letterSpacing: 0.02),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          LinearProgressIndicator(
                              backgroundColor: Colors.white,
                              value: 0.8,
                              valueColor: AlwaysStoppedAnimation(
                                Color(0xff917575),
                              )),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "SPENT  1,80,000",
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Color(0xff272727),
                                  letterSpacing: 0.02,
                                ),
                              ),
                              Text(
                                "AVAILABLE  2,00,000",
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Color(0xff272727),
                                  letterSpacing: 0.02,
                                ),
                              ),
                            ],
                          ),


                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
