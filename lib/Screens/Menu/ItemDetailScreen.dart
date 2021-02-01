import 'package:SafeDine/Models/AddOn.dart';
import 'package:SafeDine/Models/ItemDetails.dart';
import 'package:SafeDine/Screens/Menu/widgets/ItemDetailAppBar.dart';
import 'package:SafeDine/Utilities/AppTheme.dart';
import 'package:SafeDine/Widgets/SafeDineButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ItemDetailScreen extends StatefulWidget {
  final ItemDetails itemDetails;
  final String buttonText;
  final Function buttonFunction;
  ItemDetailScreen(
      {@required this.itemDetails,
      @required this.buttonFunction,
      @required this.buttonText});

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  List<AddOn> tempSelectedAddOns;
  int tempQuantity;

  @override
  void initState() {
    super.initState();
    tempSelectedAddOns = widget.itemDetails
        .getSelectedAddOns()
        .toList(); // toList will create a new refrence (clone)
    tempQuantity = widget.itemDetails.getQuantity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<AppTheme>(context).white,
      body: CustomScrollView(slivers: [
        SliverPersistentHeader(
          delegate: ItemDetailAppBar(
              expandedHeight: 180.h,
              item: widget.itemDetails.getItem(),
              collapsedHeight: 100),
          pinned: true,
        ),
        SliverPadding(
          padding: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              details(),
              SizedBox(height: 20),
              Divider(
                color: Provider.of<AppTheme>(context).grey,
              ),
              SizedBox(height: 10),
              addOnsWidget(context),
              SizedBox(height: 10),
              Text(
                'Quantity',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              quantityWidget(context),
              SizedBox(height: 130),
            ]),
          ),
        ),
      ]),
      floatingActionButton: bottomButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget details() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.itemDetails.getItem().getName()}',
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text('${widget.itemDetails.getItem().getDescription()}',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[700])),
      ],
    );
  }

  Widget bottomButton(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 15, spreadRadius: -6)
          ],
        ),
        child: SafeDineButton(
          text:
              '${widget.buttonText} SAR ${getTempSelectionPrice().toStringAsFixed(2)}',
          fontSize: 14,
          function: () {
            if (widget.buttonFunction != null) {
              widget.itemDetails.setQuantity(tempQuantity);
              widget.itemDetails.setSelectedAddOns(tempSelectedAddOns);
              widget.buttonFunction();
            }
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget quantityWidget(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 30.w,
          height: 30.w,
          decoration: BoxDecoration(
            color: Provider.of<AppTheme>(context).darkWhite,
            borderRadius: BorderRadius.circular(3.w),
          ),
          child: Center(
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  if (tempQuantity > 1) tempQuantity--;
                });
              },
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.w),
          child: Text('$tempQuantity',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        ),
        Container(
          width: 30.w,
          height: 30.w,
          decoration: BoxDecoration(
            color: Provider.of<AppTheme>(context).darkWhite,
            borderRadius: BorderRadius.circular(3.w),
          ),
          child: Center(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  tempQuantity++;
                });
              },
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  Widget addOnsWidget(context) {
    if (widget.itemDetails.getItem().getAddOns().length < 1) return SizedBox();
    return Column(
      children: [
        Text(
          'Additions',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Column(
          children: widget.itemDetails
              .getItem()
              .getAddOns()
              .asMap()
              .map((index, addOn) => MapEntry(
                    index,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${addOn.getName()}'),
                        Row(
                          children: [
                            Text('${addOn.getPrice().toStringAsFixed(2)}'),
                            Checkbox(
                              value: tempSelectedAddOns.contains(addOn),
                              activeColor:
                                  Provider.of<AppTheme>(context).primary,
                              onChanged: (selected) {
                                setState(() {
                                  if (selected)
                                    tempSelectedAddOns.add(addOn);
                                  else
                                    tempSelectedAddOns.remove(addOn);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
              .values
              .toList(),
        ),
        Divider(
          color: Provider.of<AppTheme>(context).grey,
        ),
      ],
    );
  }

  double getTempSelectionPrice() {
    double tempAddOnsPrice = 0.00;
    for (AddOn addon in tempSelectedAddOns) tempAddOnsPrice += addon.getPrice();

    return (widget.itemDetails.getItem().getPrice() + tempAddOnsPrice) *
        tempQuantity;
  }
}
