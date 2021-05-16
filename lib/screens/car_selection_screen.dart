import 'package:envirocar/theme/colors_cario.dart';
import 'package:envirocar/widgets/drop_down_field.dart';
import 'package:flutter/material.dart';

class CarSelectionScreen extends StatefulWidget {
  static String routeName = '/car_selection_screen';

  @override
  _CarSelectionScreenState createState() => _CarSelectionScreenState();
}

class _CarSelectionScreenState extends State<CarSelectionScreen> {
  String selectedValue = '';
  List<String> items = [
    'Android',
    'iOS',
    'Flutter',
    'Node',
    'Java',
    'Python',
    'PHP',
  ];
  final TextEditingController manufacturerController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController constructionYearController = TextEditingController();
  final TextEditingController fuelTypeController = TextEditingController();
  final TextEditingController engineDisplacementController = TextEditingController();

  final FocusNode manufacturerFocusNode = FocusNode();
  final FocusNode modelFocusNode = FocusNode();
  final FocusNode constructionYearFocusNode = FocusNode();
  final FocusNode fuelTypeFocusNode = FocusNode();
  final FocusNode engineDisplacementFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: null,
            margin: null,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: CarioColors.carioColorPrimary,
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 10),
                              alignment: Alignment.topCenter,
                              child: Image.asset('assets/images/envirocar_logo_white.png', width: 100),
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.only(top: 15, right: 15),
                              child: Icon(
                                Icons.check,
                                color: CarioColors.whiteCario,
                              )
                            ),
                            GestureDetector(
                              child: Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.all(15),
                                child: Icon(
                                  Icons.close,
                                  color: CarioColors.whiteCario,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.all(10),
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Enter the details of your car',
                                style: TextStyle(
                                  color: CarioColors.whiteCario
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(height: 50),
                            Container(
                              child: Text(
                                'Please enter the details of your vehicle. Be precise. Parts of this information are especially important for calculating estimated values such as consumption.',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w300
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            DropDownField(
                              onValueChanged: (value) {
                                setState(() {
                                  selectedValue = value;
                                });
                              },
                              hintText: 'Manufacturer',
                              labelText: 'Manufacturer',
                              prefixIcon: Icon(
                                Icons.apartment_sharp,
                                size: 20,
                                color: Colors.grey.shade700,
                              ),
                              textEditingController: manufacturerController,
                              focusNode: manufacturerFocusNode,
                              items: items,
                              setter: (value) {
                                setState(() {
                                  selectedValue = value;
                                });
                              },
                            ),
                            SizedBox(height: 20),
                            DropDownField(
                              onValueChanged: (value) {
                                print(value);
                              },
                              textEditingController: modelController,
                              focusNode: modelFocusNode,
                              hintText: 'Model',
                              labelText: 'Model',
                              prefixIcon: Icon(
                                Icons.directions_car,
                                size: 20,
                                color: Colors.grey.shade700,
                              ),
                              items: items,
                              setter: (value) {
                                print(value);
                              },
                            ),
                            SizedBox(height: 20),
                            DropDownField(
                              onValueChanged: (value) {
                                print(value);
                              },
                              textEditingController: constructionYearController,
                              focusNode: constructionYearFocusNode,
                              hintText: 'Construction Year',
                              labelText: 'Construction Year',
                              keyBoardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                              prefixIcon: Icon(
                                Icons.calendar_today,
                                size: 20,
                                color: Colors.grey.shade700,
                              ),
                              items: items,
                              setter: (value) {
                                print(value);
                              },
                            ),
                            SizedBox(height: 20),
                            DropDownField(
                              onValueChanged: (value) {
                                print(value);
                              },
                              textEditingController: fuelTypeController,
                              focusNode: fuelTypeFocusNode,
                              hintText: 'Fuel Type',
                              labelText: 'Fuel Type',
                              prefixIcon: Icon(
                                Icons.local_gas_station_outlined,
                                size: 20,
                                color: Colors.grey.shade700,
                              ),
                              items: items,
                              setter: (value) {
                                print(value);
                              },
                            ),
                            SizedBox(height: 20),
                            DropDownField(
                              onValueChanged: (value) {
                                print(value);
                              },
                              textEditingController: engineDisplacementController,
                              focusNode: engineDisplacementFocusNode,
                              hintText: 'Engine Displacement (cc)',
                              labelText: 'Engine Displacement (cc)',
                              prefixIcon: Icon(
                                Icons.directions_car,
                                size: 20,
                                color: Colors.grey.shade700,
                              ),
                              items: items,
                              setter: (value) {
                                print(value);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}