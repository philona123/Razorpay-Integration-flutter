import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key" : "rzp_test_ex0TR0ELNqnLLM",
      "amount" : num.parse(textEditingController.text)*100,
      "name" : "Sample App",
      "description" : "Payment for the product",
      "prefill" : {
        "contact" : "9123456780",
        "email" : "abcd@gmail.com"
      },
      "external" : {
        "wallets" : ["paytm"]
      }
    };

    try{
      razorpay.open(options);
    }catch(e){
      print(e.toString());
    }
  }

  void handlerPaymentSuccess() {
    print("payment success");
    Fluttertoast.showToast(msg: "Payment success");
  }

  void handlerErrorFailure() {
    print("payment failed");
    Fluttertoast.showToast(msg: "Payment Failed");
  }

  void handlerExternalWallet() {
    print("external wallet");
    Fluttertoast.showToast(msg: "External wallet");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: "Enter the amount to pay"
              ),
            ),
            SizedBox(height: 12,),
            RaisedButton(
              color: Colors.blue,
              child: Text("Donate now", style: TextStyle(
                color: Colors.white,
              ),),
              onPressed: (){
                openCheckout();
              },
            )
          ],
        ),
      )
    );
  }
}
