import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_challenge/bloc/states/weather_states.dart';
import 'package:weather_challenge/bloc/weather_bloc.dart';
import 'package:weather_challenge/ui/widgets/weather_box.dart';
import 'package:weather_challenge/util/dimensions.dart';
import 'package:weather_challenge/util/resources_manager.dart';

class WeatherPage extends StatelessWidget {
  final int daysToShow = 5;

  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.kMediumPadding,
            vertical: Dimensions.kPaddingFromDeviceVertical,
          ),
          child: BlocBuilder<WeatherBloc, WeatherStates>(
              builder: (context, state) {
            if (state is CityFound) {
              final allFiveDays = state.fiveDaysForecastList!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: WeatherBox(
                      model: state.currentForecastCityModel!,
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.02,
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: daysToShow,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.circularBorder,
                                    ),
                                  ),
                                  elevation: Dimensions.dialogElevation,
                                  child: SizedBox(
                                    height: constraints.maxHeight * 0.45,
                                    width: constraints.maxWidth,
                                    child: WeatherBox(
                                      model: allFiveDays[index]!,
                                      showName: false,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: ListTile(
                            leading: ResourceManager.getIconFromDescription(
                              allFiveDays[index]!,
                            ),
                            title: Text(
                              "${DateFormat('EEEE').format(
                                allFiveDays[index]!.time!,
                              )} - ${allFiveDays[index]!.time!.day} ${DateFormat.MMMM().format(allFiveDays[index]!.time!)}",
                            ),
                            subtitle: Text(
                              allFiveDays[index]!.littleDescription,
                            ),
                            trailing: Text(
                              "${allFiveDays[index]!.temp.toStringAsFixed(1)} °C",
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is ErrorState) {
              return Text(
                state.message,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        );
      }),
    );
  }
}
