import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'fitness_stats_model.dart';
import 'stat_result.dart';

class FitnessStatsScreen extends StatelessWidget {
  const FitnessStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ChangeNotifierProvider(
      create: (_) => FitnessStatsModel(),
      child: Consumer<FitnessStatsModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Fitness Stats Input'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: model.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CupertinoTextField(
                        placeholder: 'Name',
                        onChanged: model.updateName,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey[850] : Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 10),
                      CupertinoTextField(
                        placeholder: 'Weight (kg)',
                        keyboardType: TextInputType.number,
                        onChanged: model.updateWeight,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey[850] : Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 10),
                      CupertinoTextField(
                        placeholder: 'Height (cm)',
                        keyboardType: TextInputType.number,
                        onChanged: model.updateHeight,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey[850] : Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 10),
                      CupertinoTextField(
                        placeholder: 'Age',
                        keyboardType: TextInputType.number,
                        onChanged: model.updateAge,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey[850] : Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: model.gender,
                        decoration: InputDecoration(labelText: 'Gender'),
                        onChanged: (String? newValue) {
                          model.updateGender(newValue!);
                        },
                        items: model.genderOptions.map<
                            DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: model.bloodType,
                        decoration: InputDecoration(labelText: 'Blood Type'),
                        onChanged: (String? newValue) {
                          model.updateBloodType(newValue!);
                        },
                        items: model.bloodTypeOptions.map<
                            DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (model.formKey.currentState!.validate()) {
                            model.calculateStats();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FitnessStatsResultsScreen(
                                  name: model.name,
                                  gender: model.gender,
                                  weight: model.weight,
                                  height: model.height,
                                  age: model.age,
                                  bloodType: model.bloodType,
                                ),
                              ),
                            );
                          }
                        },
                        child: Text('Calculate'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
