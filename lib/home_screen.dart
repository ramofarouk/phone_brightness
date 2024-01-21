import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:phone_brightness/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool status = false;
  double _currentSliderValue = 0;
  double opacity = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: buildBody(height, width),
    );
  }

  // Fonction pour créer la partie principale du widget
  Widget buildBody(double height, double width) {
    return Stack(
      children: [
        Container(
          height: height,
        ),
        buildCircleAvatar(height, width),
        buildPhoneImage(height),
        buildHeaderText(width),
        buildHeaderIcon(width),
        buildPowerSection(height, width),
        buildBrightnessSliderSection(height, width),
        buildControlIconsSection(height, width),
        buildProgrammerSection(height, width),
        buildDailyConsumptionSection(height, width),
      ],
    );
  }

  // Fonction pour créer le cercle flou en arrière-plan
  Widget buildCircleAvatar(double height, double width) {
    return Positioned(
      top: height * 0.2,
      left: -10,
      child: CircleAvatar(
        backgroundColor:
            const Color.fromARGB(255, 217, 211, 159).withOpacity(opacity),
        radius: width * 0.29,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }

  // Fonction pour créer l'image du téléphone
  Widget buildPhoneImage(double height) {
    return Positioned(
      left: 5,
      child: Image.asset(
        "assets/light.png",
        height: height * 0.45,
      ),
    );
  }

  // Fonction pour créer l'en-tête du widget
  Widget buildHeaderText(double width) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      child: SizedBox(
        width: width,
        child: const Center(
          child: Text(
            'Phone Brightness',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // Fonction pour créer l'en-tête du widget
  Widget buildHeaderIcon(double width) {
    return Positioned(
      right: 20,
      top: MediaQuery.of(context).padding.top + 10,
      child: const FaIcon(
        FontAwesomeIcons.angleRight,
        size: 25,
      ),
    );
  }

  // Fonction pour créer la section de contrôle de la puissance et de la luminosité
  Widget buildPowerSection(double height, double width) {
    return Positioned(
      right: 20,
      top: height * 0.2,
      child: Container(
        width: width * 0.44,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Power",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: height * 0.007,
            ),
            buildFlutterSwitch(height, width),
            SizedBox(
              height: height * 0.1,
            ),
            buildBrightnessText(height),
          ],
        ),
      ),
    );
  }

  // Fonction pour créer le commutateur de puissance
  Widget buildFlutterSwitch(double height, double width) {
    return FlutterSwitch(
      width: width * 0.24,
      height: 35.0,
      valueFontSize: 30.0,
      activeColor: AppColor.primaryColor,
      toggleColor: AppColor.primaryColor,
      activeToggleColor: Colors.white,
      inactiveColor: Colors.white,
      toggleSize: 30,
      value: status,
      borderRadius: 30.0,
      padding: 5.0,
      onToggle: (val) {
        setState(() {
          status = val;
          if (!status) {
            _currentSliderValue = 0;
            opacity = 0;
          } else {
            opacity = _currentSliderValue * 0.2;
          }
        });
      },
    );
  }

  // Fonction pour créer le texte de luminosité
  Widget buildBrightnessText(double height) {
    return Column(
      children: [
        Text(
          "${(20 * _currentSliderValue).toInt()}%",
          style: const TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
        ),
        const Text("Luminosité"),
      ],
    );
  }

  // Fonction pour créer la section du curseur de luminosité
  Widget buildBrightnessSliderSection(double height, double width) {
    return Positioned(
      top: height * 0.52,
      right: width * 0.1,
      left: width * 0.1,
      child: SizedBox(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const FaIcon(FontAwesomeIcons.lightbulb),
            buildBrightnessSlider(width),
            const FaIcon(Icons.light_mode),
          ],
        ),
      ),
    );
  }

  Widget buildControlIconsSection(double height, double width) {
    return Positioned(
      top: height * 0.52,
      right: width * 0.1,
      left: width * 0.1,
      child: SizedBox(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const FaIcon(FontAwesomeIcons.lightbulb),
            buildBrightnessSlider(width),
            const FaIcon(Icons.light_mode),
          ],
        ),
      ),
    );
  }

  // Fonction pour créer le curseur de luminosité
  Widget buildBrightnessSlider(double width) {
    return SizedBox(
      width: width * 0.67,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Slider(
            value: _currentSliderValue,
            max: 5,
            divisions: 5,
            label: _currentSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
                if (status) {
                  opacity = _currentSliderValue * 0.2;
                }
              });
            },
            activeColor: Colors.white,
          ),
          buildSliderTicks(width),
        ],
      ),
    );
  }

  // Fonction pour créer les marques du curseur de luminosité
  Widget buildSliderTicks(double width) {
    return Container(
      height: 12,
      margin: EdgeInsets.symmetric(horizontal: width * 0.16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          4,
          (index) => SizedBox(
            child: Container(
              width: 2.5,
              height: double.infinity,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Fonction pour créer la section du programmateur
  Widget buildProgrammerSection(double height, double width) {
    return Positioned(
      bottom: height * 0,
      right: 0,
      left: 0,
      child: Container(
        height: height * 0.33,
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.1, vertical: height * 0.02),
        decoration: ShapeDecoration(
          color: AppColor.primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
        ),
        child: buildProgrammerContent(),
      ),
    );
  }

  // Fonction pour créer le contenu de la section du programmateur
  Widget buildProgrammerContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Programmer",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        buildProgrammerTimeRow(),
      ],
    );
  }

  // Fonction pour créer la rangée du temps du programmateur
  Widget buildProgrammerTimeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("De"),
        const Text(
          "17h30",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        const Text("à"),
        const Text(
          "23h30",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        buildProgrammerIconsRow(),
      ],
    );
  }

  // Fonction pour créer la rangée des icônes du programmateur
  Widget buildProgrammerIconsRow() {
    return const Row(
      children: [
        FaIcon(
          FontAwesomeIcons.file,
          size: 18,
        ),
        SizedBox(
          width: 10,
        ),
        FaIcon(
          FontAwesomeIcons.pencil,
          size: 18,
        )
      ],
    );
  }

  // Fonction pour créer la section de la consommation quotidienne
  Widget buildDailyConsumptionSection(double height, double width) {
    return Positioned(
      bottom: height * 0,
      right: 0,
      left: 0,
      child: Container(
        height: height * 0.2,
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.1, vertical: height * 0.02),
        decoration: ShapeDecoration(
          color: AppColor.secondColor.withOpacity(0.7),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
        ),
        child: buildDailyConsumptionContent(),
      ),
    );
  }

  // Fonction pour créer le contenu de la section de la consommation quotidienne
  Widget buildDailyConsumptionContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildConsumptionRow("Conso. Journalière", "2", "Kw"),
        const SizedBox(
          height: 10,
        ),
        buildConsumptionRow("Conso. Mensuelle", "60", "Kw"),
        const SizedBox(
          height: 10,
        ),
        buildConsumptionRow("Heure de conso. totale", "76", "Heu"),
      ],
    );
  }

  // Fonction pour créer une rangée d'informations de consommation
  Widget buildConsumptionRow(String title, String value, String unit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              unit,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        )
      ],
    );
  }
}
