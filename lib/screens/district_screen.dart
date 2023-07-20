// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nobetci_eczane/models/pharmacy.dart';
import 'package:nobetci_eczane/services/pharmacy_service.dart';

class DistrictScreen extends StatefulWidget {
  late String districtName;
  DistrictScreen({super.key, required this.districtName});

  @override
  State<DistrictScreen> createState() => _DistrictScreenState();
}

class _DistrictScreenState extends State<DistrictScreen> {
  List<Pharmacy> pharmacies = [];

  late Widget _body;

  @override
  void initState() {
    getPharmacies();
    Future.delayed(
      const Duration(
        seconds: 2,
      ),
      () {
        setState(
          () {
            _body;
            print(pharmacies.length);
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _body = _errorLoadingScreen();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        titleSpacing: 5,
        leading: Image.asset(
          'lib/assets/images/logo_img.png',
          width: 50,
          height: 50,
        ),
        title: Text(
          '${widget.districtName} Nöbetçi Eczaneler',
          style: const TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
      // ignore: prefer_const_constructors
      body: pharmacies.isEmpty
          ? _body
          : Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: pharmacies.map((e) => Column(
                            children: [
                              Text(e.name),
                              Text(e.address),
                              Text(e.number),
                            ],
                          )).toList(),
                          //mainAxisSize: MainAxisSize.min,
                          //children: districts.map((e) => DistrictMinCardWidget(districtName: e,),).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void getPharmacies() async {
    setState(() {
      PharmacyService.getPharmacies(widget.districtName).then((value) => pharmacies = value);
    });
  }

  Widget _errorLoadingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          LoadingAnimationWidget.fourRotatingDots(color: Colors.red, size: 80),
          const SizedBox(
            height: 30,
          ),
          Text(
            "Nöbetçi Eczaneler Yükleniyor...",
            style: GoogleFonts.nunito(
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Lütfen Bekleyiniz",
            style: GoogleFonts.nunito(
              textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
