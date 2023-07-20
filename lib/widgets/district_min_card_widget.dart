// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:nobetci_eczane/screens/district_screen.dart';

class DistrictMinCardWidget extends StatefulWidget {
  late String districtName;
  DistrictMinCardWidget({super.key, required this.districtName});

  @override
  State<DistrictMinCardWidget> createState() => _DistrictMinCardWidgetState();
}

class _DistrictMinCardWidgetState extends State<DistrictMinCardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DistrictScreen(districtName: widget.districtName)));
      },
      child: Card(
        shape: _buildCardShape(),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: ListTile(
            leading: const Icon(
              Icons.location_on,
              color: Colors.red,
              size: 32,
            ),
            title: Text(
              widget.districtName,
              style: const TextStyle(
                fontSize: 26,
              ),
            ),
          ),
        ),
      ),
    );
  }

  RoundedRectangleBorder _buildCardShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );
  }
}
