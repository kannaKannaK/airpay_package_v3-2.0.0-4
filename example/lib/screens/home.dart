import 'package:airpay_package/airpay_package.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final bool isSandbox;
  Home({this.isSandbox});

  @override
  _HomeState createState() => _HomeState(isSandbox: isSandbox);
}

class _HomeState extends State<Home> {
  final bool isSandbox;
  _HomeState({this.isSandbox});

  bool isSuccess = false;

  onComplete(status, response) {
    var resp = response.toJson();
    print('Response ===========================> \n' + resp.toString());
    var txtStsMsg = resp['STATUSMSG'] ?? '';
    var txtSts = resp['TRANSACTIONSTATUS'] ?? '';
    Navigator.pop(context);
    if (resp['STATUSMSG'] == null) {
      txtStsMsg = resp['TRANSACTIONREASON'] ?? '';
      txtSts = resp['STATUS'] ?? '';
    }

    AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            headerAnimationLoop: true,
            animType: AnimType.bottomSlide,
            title: "AirPay",
            desc: 'Transaction Status: ' +
                txtSts +
                '\nTransaction Status Message: ' +
                txtStsMsg)
        .show();
  }

  void directPayment() {
    // String domainPath =
    //     'https://devtest.samil.in/samilretail/ISPaymentBillDeskConfirmation.aspx';

    // String kAirPaySecretKey = 'DQgCyxq7u3U4w2qZ';

    // String kAirPayUserName = '7576573';

    // String kAirPayPassword = 'ehG2X7M6';

    // String merchantID = '259470';

    // String successURL =
    //     'https://devtest.samil.in/samilretail/ISPaymentBillDeskConfirmation.aspx"';

    String domainPath = 'https://audio.samil.in/SAMILPG/PGConfirmation.aspx';

    String kAirPaySecretKey = 'tYQSem4gfrzAvRpy';

    String kAirPayUserName = '5074004';

    String kAirPayPassword = 'tbZJrW3R';

    String merchantID = '264087';

    String successURL = 'https://audio.samil.in/SAMILPG/PGConfirmation.aspx';

    UserRequest user = UserRequest(
        username: kAirPayUserName,
        password: kAirPayPassword,
        secret: kAirPaySecretKey,
        merchantId: merchantID,
        protoDomain: domainPath,
        fname: 'Test User',
        lname: 'test',
        email: 'testuser@gmail.com',
        phone: '7905284563',
        fulladdress: 'Mumbai',
        pincode: '400011',
        orderid: '0001',
        amount: '100',
        city: 'Mumbai',
        state: 'Maharastra',
        country: 'India',
        currency: "356",
        isCurrency: "INR",
        chMode: "",
        customVar: "test",
        txnSubtype: "",
        wallet: "0",
        isStaging: false, //True for the Staging
        successUrl: successURL,
        failedUrl: successURL);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => new AirPay(
            user: user,
            closure: (status, response) => {onComplete(status, response)}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: new ElevatedButton(
                    child: Text('Direct Payment',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: () {
                      directPayment();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
