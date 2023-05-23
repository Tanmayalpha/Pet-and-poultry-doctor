import 'package:eshopmultivendor/Helper/AppBtn.dart';
import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Model/DocterRegisterModel/patient_request_response.dart';
import 'package:eshopmultivendor/Screen/Doctor/prescribe_view.dart';
import 'package:flutter/material.dart';

class AnimalDetailScreen extends StatefulWidget {
  AnimalDetailScreen({Key? key, this.animalDetail }) : super(key: key);

  Accepted? animalDetail;

  @override
  State<AnimalDetailScreen> createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          "assets/logo/food_on_the_way.png",
          height: 70,
        ),
        backgroundColor: white,
        iconTheme: IconThemeData(color: grad2Color),),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Owner Information',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Row(children: [
                  Text('Username:'),
                  SizedBox(width: 8),
                  Text('${widget.animalDetail?.username}'),
                ],),
                Row(children: [
                  Text('Email:'),
                  SizedBox(width: 8),
                  Text('${widget.animalDetail?.username}'),
                ],),
                Row(children: [
                  Text('Mobile:'),
                  SizedBox(width: 8),
                  Text('${widget.animalDetail?.mobile}'),
                ],),

                SizedBox(height: 16),
                Text('Animal Information',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Name: ${widget.animalDetail?.name}'),
                Text('Gender: ${widget.animalDetail?.gender}'),
                Text('Age: ${widget.animalDetail?.age}'),
                Text('Weight: ${widget.animalDetail?.weight}'),
                Text('Breed: ${widget.animalDetail?.breed}'),
                Text('Species: ${widget.animalDetail?.species}'),
                SizedBox(height: 16),
                Text('Pet Information',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Name of Pet: ${widget.animalDetail?.json?.nameOfPet}'),
                Text('Type of Pet: ${widget.animalDetail?.json?.typeOfPet}'),
                Text('Breed of Pet: ${widget.animalDetail?.json?.breedOfPet}'),
                Text('Sex of Pet: ${widget.animalDetail?.json?.sexOfPet}'),
                Text('Pregnant: ${widget.animalDetail?.json?.pregnant}'),
                Text('Age of Pet: ${widget.animalDetail?.json?.ageOfPet}'),
                Text('Temperature: ${widget.animalDetail?.json?.temperature}'),
                Text(
                    'Weight of Pet: ${widget.animalDetail?.json?.weightOfPet}'),
                Text('Body Weight Changes: ${widget.animalDetail?.json
                    ?.bodyWeightChanges}'),
                Text('Feed Consumption per Day: ${widget.animalDetail?.json
                    ?.feedConsumptionPerDay}'),
                Text('Water Consumption per Day: ${widget.animalDetail?.json
                    ?.waterConsumptionPerDay}'),
                Text('Average Milk Production: ${widget.animalDetail?.json
                    ?.avgMilkProduction}'),
                Text('Calving History: ${widget.animalDetail?.json
                    ?.calvingHistory}'),
                Text('Vaccination: ${widget.animalDetail?.json?.vaccination}'),
                Text('Vaccine Name: ${widget.animalDetail?.json?.vaccineName}'),
                Text('Medication: ${widget.animalDetail?.json?.medication}'),
                Text('Medicine: ${widget.animalDetail?.json?.medicine}'),
                Text('Surgery: ${widget.animalDetail?.json?.surgery}'),
                Text(
                    'Type of Surgery: ${widget.animalDetail?.json?.typeOfPet}'),
                Text('Travelling History: ${widget.animalDetail?.json
                    ?.travellingHistory}'),
                Text('Symptoms: ${widget.animalDetail?.json?.symptoms}'),
                Text('Stool Consistency: ${widget.animalDetail?.json
                    ?.stoolConsitancy}'),
                Text('Stool Color: ${widget.animalDetail?.json?.stoolColor}'),
                Text('Urine Frequency: ${widget.animalDetail?.json
                    ?.urineFrequency}'),
                Text('Urine Color: ${widget.animalDetail?.json?.urineColor}'),
                Text('Any Change in Weather: ${widget.animalDetail?.json
                    ?.anyChangeWeather}'),
                Text('Weather: ${widget.animalDetail?.json?.weather}'),

                AppButton(onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        PrescribeScreen(age: widget.animalDetail?.json
                            ?.ageOfPet, petName: widget.animalDetail?.json
                            ?.nameOfPet,weight: widget.animalDetail?.json?.weightOfPet,clientName:widget.animalDetail?.username, id: widget.animalDetail?.id, ),));
                }, titleText: 'Diagnosis',),


              ],),
          ),
        ),
      ),
    );
  }
}
