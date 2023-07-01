import 'dart:developer';

import 'package:doximity/model/doctormodel/doctor_model.dart';
import 'package:doximity/view/animated_prompt/animated_prompt.dart';
import 'package:doximity/view/booking_page/widgets/booking_patients_datas.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/const/size/size.dart';
import 'package:doximity/view_model/booking/booking_dr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({
    super.key,
    required this.times,
    required this.drUid,
    required this.allDoctorsDetails,
  });

  final List times;
  final String drUid;
  final AllDoctorsDetails allDoctorsDetails;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final formKey = GlobalKey<FormState>();

  Razorpay? _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay?.clear();
  }

  void openCheckout(doctorname, amount) async {
    var options = {
      'key': 'rzp_test_FxIHeNPp3kLjby',
      'amount': amount,
      'name': doctorname,
      'description': 'Payment',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay?.open(options);
      await context.read<BookingProvider>().booking(
            widget.drUid,
            context,
            widget.allDoctorsDetails.profilePic,
            widget.allDoctorsDetails.department,
            widget.allDoctorsDetails.name,
          );
    } catch (e) {
      debugPrint(e as String?);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnimatedPrompt(
          title: 'Thank you for your Booking',
          msg: "SUCCESS: ${response.paymentId}",
          child: const Icon(Icons.check),
        ),
      ),
    );
    // Fluttertoast.showToast(
    //     msg: "SUCCESS: ${response.paymentId}", timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnimatedPrompt(
          title: 'Somthing Went Rong',
          msg: "ERROR: ${response.code} - ${response.message}",
          child: const Icon(Icons.cancel),
        ),
      ),
    );

    // Fluttertoast.showToast(
    //     msg: "ERROR: ${response.code} - ${response.message}",
    //     timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnimatedPrompt(
          title: 'EXTERNAL_WALLET',
          msg: "EXTERNAL_WALLET: ${response.walletName}",
          child: const Icon(Icons.cancel),
        ),
      ),
    );

    // Fluttertoast.showToast(
    //     msg: "EXTERNAL_WALLET: ${response.walletName}", timeInSecForIosWeb: 4);
  }

//declaration
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      backgroundColor: kBgcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Appoinment',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        backgroundColor: kBgcolor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kBlackColor900,
            size: 25,
          ),
        ),
      ),
      body: Consumer<BookingProvider>(
        builder: (context, bookingvalue, child) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    bookingvalue.tableCalender(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 25,
                      ),
                      child: Text(
                        'Select Consultation Time',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    )
                  ],
                ),
              ),
              bookingvalue.isWeekend
                  ? SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 30,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Weekend is not available please select another date',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                    )
                  : SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              //when selected update current index and set time selected to true
                              bookingvalue.selectedTime = widget.times[index];
                              bookingvalue.setCurrentIndex = index;
                              bookingvalue.setTimeSelected = true;
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: bookingvalue.currentIndex == index
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                color: bookingvalue.currentIndex == index
                                    ? kGreenColor
                                    : null,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${widget.times[index]}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: bookingvalue.currentIndex == index
                                          ? Colors.black
                                          : null,
                                    ),
                              ),
                            ),
                          );
                        },
                        childCount: widget.times.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1.5,
                      ),
                    ),

              //-------------------patint details in booking page----------------------
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BookingPatientDates(formKey: formKey),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          log(widget.allDoctorsDetails.consaltaionFee
                              .toString());
                          openCheckout(
                            widget.allDoctorsDetails.name,
                            '${widget.allDoctorsDetails.consaltaionFee}00',
                          );
                          // log(widget.allDoctorsDetails.toString());

                          // if (mounted) {
                          //   //Navigator.pop(context);
                          // }
                        }
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        overlayColor: MaterialStateProperty.all(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(kButtonColor),
                      ),
                      child: context.watch<BookingProvider>().isloding == false
                          ? Text(
                              'Pay & Make Appointment',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: kWhiteColor, fontSize: 15),
                            )
                          : const CupertinoActivityIndicator(),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
