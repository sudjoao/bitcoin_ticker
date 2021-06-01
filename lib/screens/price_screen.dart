import 'package:bitcoin_ticker/services/coin_api.dart';
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
  Map<String, String> cryptoCoinsValues = {'BTC': "?", 'ETH': "?", 'LTC': "?"};
  bool isLoading = false;
  int precision = 0;
  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    getValues();
    super.initState();
  }

  void getValues() async {
    var bitcoin = await coinAPI.getBitCoinValue('BTC', actualCoin);
    var ethereum = await coinAPI.getBitCoinValue('ETH', actualCoin);
    var litecoin = await coinAPI.getBitCoinValue('LTC', actualCoin);
    setState(() {
      cryptoCoinsValues['BTC'] = bitcoin.runtimeType == String ? bitcoin : bitcoin.toStringAsFixed(precision);
      cryptoCoinsValues['ETH'] = ethereum.runtimeType == String ? ethereum : ethereum.toStringAsFixed(precision);
      cryptoCoinsValues['LTC'] = litecoin.runtimeType == String ? litecoin : litecoin.toStringAsFixed(precision);
      isLoading = false;
    });
  }

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
                      child: isLoading
                          ? Center(child: CircularProgressIndicator())
                          : Text(
                              '$crypto = ${cryptoCoinsValues[crypto]} $actualCoin',
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
            child: Platform.isAndroid
                ? MyAndroidDropDown(
                    actualValue: actualCoin,
                    onChange: (String value) {
                      setState(() {
                        isLoading = true;
                        actualCoin = value;
                      });
                      getValues();
                      
                    },
                    items: currenciesList,
                  )
                : MyIosPicker(
                    onSelect: (int value) {
                      setState(() {
                        isLoading = true;
                        actualCoin = currenciesList[value];
                      });
                      getValues();
                      
                    },
                    items: currenciesList,
                  ),
          ),
        ],
      ),
    );
  }
}
