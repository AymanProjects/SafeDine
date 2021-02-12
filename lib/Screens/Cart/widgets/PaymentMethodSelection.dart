import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentMethodSelection extends StatefulWidget {
  final Function onMethodChanged;
  PaymentMethodSelection({this.onMethodChanged});

  @override
  _PaymentMethodSelectionState createState() => _PaymentMethodSelectionState();
}

class _PaymentMethodSelectionState extends State<PaymentMethodSelection> {
  int _selectedMethod = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Method",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        paymentMethod(
            name: 'Cash',
            value: 1,
            icon: FontAwesomeIcons.moneyBillWave,
            iconColor: Colors.green),
        paymentMethod(
            name: 'Paypal',
            value: 2,
            icon: FontAwesomeIcons.paypal,
            iconColor: Colors.blue),
        Text(
          'Note: you can cancel your order only if cash payment is chosen',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget paymentMethod(
      {String name, int value, IconData icon, Color iconColor}) {
    return InkWell(
      onTap: () {
        _selectedMethod = value;
        if (widget.onMethodChanged != null) widget.onMethodChanged(value);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IgnorePointer(
                child: Container(
                  width: 20,
                  margin: EdgeInsets.only(right: 10),
                  child: Radio(
                    activeColor: Colors.black,
                    onChanged: (_) {},
                    value: value,
                    groupValue: _selectedMethod,
                  ),
                ),
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Container(
            width: 30,
            child: Center(
              child: FaIcon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
