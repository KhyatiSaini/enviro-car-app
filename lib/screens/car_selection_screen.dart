import 'package:envirocar/theme/colors_cario.dart';
import 'package:envirocar/widgets/drop_down_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CarSelectionScreen extends StatelessWidget {
  static String routeName = '/car_selection_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CarSelectionScreenPage(),
    );
  }
}

class CarSelectionScreenPage extends StatefulWidget {
  @override
  _CarSelectionScreenPageState createState() => _CarSelectionScreenPageState();
}

class _CarSelectionScreenPageState extends State<CarSelectionScreenPage> {

  List<String> manufacturerList = [
    'ALFA LANCIA (I)',
    'ALFA ROMEO (I)',
    'ALPINA',
    'AUDI(H)',
    'AUTO BIANCHI (I)',
    'BARKAS-VEB',
    'Buick'
  ];

  List<String> modelList = [

  ];

  List<String> constructionYearList = [

  ];

  List<String> fuelTypeList = [
    'Gasoline',
    'Diesel',
    'Gas',
    'Hybrid',
    'Electric'
  ];

  List<String> engineDisplacementList = [

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

  final _key = GlobalKey<FormState>();

  String manufacturer = '', model = '', constructionYear = '', fuelType = '', engineDisplacement = '';
  bool displayEngineDisplacement = true;

  var manufacturerModel = {
    'ALFA LANCIA (I)': [
      'ALFA 164',
      'ALFA 33 KOMBI'
    ],
    'ALFA ROMEO (I)': [
      '1300 SPIDER JUNIOR'
    ],
    'ALPINA': [
      'BMW ALPINA 33 BIT URB Carb',
      'SBITURBO'
    ],
    'AUDI(H)': [
      'AUDI TT'
    ],
    'AUTO BIANCHI (I)': [
      'A 112 A1'
    ],
    'BARKAS-VEB': [
      'B 1000 KM/1',
      'B 1000 KM/2',
      'B 1000 KM/VA',
    ],
    'Buick': [
      'excelle'
    ],
  };

  var constructionYearModel = {
    'ALFA 164': [
      '1990',
    ],
    'ALFA 33 KOMBI': [
      '1988',
      '2000',
    ],
    '1300 SPIDER JUNIOR': [
      '1968',
      '2000',
      '2020',
    ],
    'BMW ALPINA 33 BIT URB Carb': [
      '2010'
    ],
    'SBITURBO': [
      '2017'
    ],
    'AUDI TT': [
      '2008',
    ],
    'A 112 A1': [
      '1975'
    ],
    'B 1000 KM/1': [
      '1976',
    ],
    'B 1000 KM/2': [
      '1976',
    ],
    'B 1000 KM/VA': [
      '1976',
    ],
    'excelle': [
      '2000'
    ]
  };

  /// function to hide engine displacement [drop_down_field] if [electric] is selected as [FuelType]
  void toggleEngineDisplacement(String fuel) {
    if (fuel == 'Electric') {
      setState(() {
        displayEngineDisplacement = false;
      });
    } else {
      setState(() {
        displayEngineDisplacement = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                              child: IconButton(
                                icon: Icon(
                                  Icons.check,
                                  color: CarioColors.whiteCario,
                                ),
                                onPressed: () {
                                  addCarDetails();
                                },
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
                          Form(
                            key: _key,
                            child: Column(
                              children: [
                                DropDownField(
                                  onValueChanged: (value) {
                                    setState(() {
                                      manufacturer = value;
                                      modelList = manufacturerModel[manufacturer];
                                      modelController.text = '';
                                      model = '';
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
                                  items: manufacturerList,
                                  setter: (value) {
                                    setState(() {
                                      manufacturer = value;
                                      modelList = manufacturerModel[manufacturer];
                                      modelController.text = '';
                                      model = '';
                                    });
                                  },
                                ),
                                SizedBox(height: 20),
                                DropDownField(
                                  onValueChanged: (value) {
                                    model = value;
                                    constructionYearList = constructionYearModel[model];
                                    constructionYearController.text = '';
                                    constructionYear = '';
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
                                  items: modelList,
                                  setter: (value) {
                                    model = value;
                                    constructionYearList = constructionYearModel[model];
                                    constructionYearController.text = '';
                                    constructionYear = '';
                                  },
                                ),
                                SizedBox(height: 20),
                                DropDownField(
                                  onValueChanged: (value) {
                                    constructionYear = value;
                                  },
                                  textEditingController: constructionYearController,
                                  focusNode: constructionYearFocusNode,
                                  hintText: 'Construction Year',
                                  labelText: 'Construction Year',
                                  keyBoardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                                  textInputFormatter: [
                                    WhitelistingTextInputFormatter(RegExp(r"^\d?\.?\d{0,3}")),
                                  ],
                                  prefixIcon: Icon(
                                    Icons.calendar_today,
                                    size: 20,
                                    color: Colors.grey.shade700,
                                  ),
                                  items: constructionYearList,
                                  setter: (value) {
                                    constructionYear = value;
                                  },
                                ),
                                SizedBox(height: 20),
                                DropDownField(
                                  onValueChanged: (value) {
                                    fuelType = value;
                                    toggleEngineDisplacement(value);
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
                                  items: fuelTypeList,
                                  setter: (value) {
                                    fuelType = value;
                                    toggleEngineDisplacement(value);
                                  },
                                ),
                                SizedBox(height: 20),
                                Visibility(
                                  visible: displayEngineDisplacement,
                                  child: DropDownField(
                                    onValueChanged: (value) {
                                      engineDisplacement = value;
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
                                    keyBoardType: TextInputType.number,
                                    items: engineDisplacementList,
                                    setter: (value) {
                                      engineDisplacement = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
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
    );
  }

  void addCarDetails() {
    if (_key.currentState.validate()) {
      // TODO: save the data

    }
  }
}