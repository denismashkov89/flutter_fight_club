import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fight_club/pages/fight_pages.dart';
import 'package:flutter_fight_club/pages/statistics_page.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/fight_result_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../fight_result.dart';
import '../widgets/action_button.dart';
import '../widgets/secondary_action_button.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _MainPageContent();
  }
}

class _MainPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Center(
              child: Text(
                "The\nFight\nClub".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: FightClubColors.darkGreyText,
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            FutureBuilder<String?>(
              future: SharedPreferences.getInstance().then(
                (sharedPreferences) =>
                    sharedPreferences.getString("last_fight_result"),
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return const SizedBox();
                }
                final FightResult fightResult =
                    FightResult.getByName(snapshot.data!);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Last fight result",
                      style: TextStyle(
                        color: FightClubColors.darkGreyText,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    FightResultWidget(
                      fightResult: fightResult,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 10),
            Expanded(child: SizedBox()),
            Expanded(child: SizedBox()),
            SecondaryActionButton(
              text: "Statistics",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => StatisticsPage(),
                ));
              },
            ),
            const SizedBox(height: 12),
            ActionButton(
              text: "Start".toUpperCase(),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FightPage(),
                  ),
                );
              },
              color: FightClubColors.blackButton,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
