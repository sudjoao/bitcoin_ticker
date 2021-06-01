import 'package:bitcoin_ticker/widgets/android_dropdown.dart';
import 'package:bitcoin_ticker/widgets/ios_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/coin_data.dart';
import 'dart:io';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String actualCoin = "USD";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: cryptoList.map((crypto) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 28.0,
                      ),
                      child: Text(
                        '$crypto= ? $actualCoin',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: !Platform.isAndroid
                ? MyAndroidDropDown(
                    actualValue: actualCoin,
                    onChange: (String value) {
                      setState(() {
                        actualCoin = value;
                      });
                    },
                    items: currenciesList,
                  )
                : MyIosPicker(
                    onSelect: (int value) {
                      setState(() {
                        actualCoin = currenciesList[value];
                      });
                    },
                    items: currenciesList,
                  ),
          ),
        ],
      ),
    );
  }
}
