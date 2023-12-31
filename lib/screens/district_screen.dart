// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nobetci_eczane/models/pharmacy.dart';
import 'package:nobetci_eczane/services/pharmacy_service.dart';
import 'package:nobetci_eczane/widgets/pharmacy_min_card_widget.dart';

class DistrictScreen extends StatefulWidget {
  late String districtName;
  DistrictScreen({super.key, required this.districtName});

  @override
  State<DistrictScreen> createState() => _DistrictScreenState();
}

class _DistrictScreenState extends State<DistrictScreen> {
  List<Pharmacy> pharmacies = [];

  late Widget _loadingBody;
  late Widget _mainBody;

  int delayTime = 100;

  @override
  void initState() {
    getPharmacies();
    delayFunction();
    super.initState();
  }

  Function? delayFunction() {
    Future.delayed(
      Duration(
        milliseconds: delayTime,
      ),
      () {
        if (pharmacies.isEmpty) {
          return delayFunction();
        } else {
          setState(
            () {
              _loadingBody;
            },
          );
        }
      },
    );
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _loadingBody = _errorLoadingScreen();
    _mainBody = _buildMainBody();

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
      body: pharmacies.isEmpty ? _loadingBody : _mainBody,
    );
  }

  Padding _buildMainBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: pharmacies.map((e) => PharmacyMinCardWidget(pharmacy: e),).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getPharmacies() async {
    await PharmacyService.getPharmacies(widget.districtName).then((value) => pharmacies = value);
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
