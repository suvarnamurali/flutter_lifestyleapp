/*
 * This file is part of wger Workout Manager <https://github.com/wger-project>.
 * Copyright (C) 2020, 2021 wger Team
 *
 * wger Workout Manager is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * wger Workout Manager is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wger/helpers/misc.dart';
import 'package:wger/providers/auth.dart';

class AboutPage extends StatefulWidget {
  static String routeName = '/AboutPage';
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).aboutPageTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 0.125 * deviceSize.height,
              // color: Colors.red,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 75,
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Wger',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text('App: ${authProvider.applicationVersion!.version}\n'
                          'Server: ${authProvider.serverVersion}'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.225 * deviceSize.width),
              child: Text(
                '\u{a9} 2020 - 2021 contributors',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            SizedBox(height: 0.025 * deviceSize.height),
            Text(
              AppLocalizations.of(context).aboutDescription,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
            ),
            SizedBox(height: 0.04 * deviceSize.height),
            ListTile(
              leading: const Icon(Icons.code),
              title: Text(AppLocalizations.of(context).aboutSourceTitle),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context).aboutSourceText),
                  const Text(
                    'https://github.com/wger-project',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
              contentPadding: EdgeInsets.zero,
              onTap: () async => launchURL('https://github.com/wger-project', context),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.bug_report),
              title: Text(AppLocalizations.of(context).aboutBugsTitle),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context).aboutBugsText),
                  const Text(
                    'https://github.com/wger-project/flutter/issues/new/choose',
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              ),
              contentPadding: EdgeInsets.zero,
              onTap: () async =>
                  launchURL('https://github.com/wger-project/flutter/issues/new/choose', context),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.chat),
              title: Text(AppLocalizations.of(context).aboutContactUsTitle),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context).aboutContactUsText),
                  const Text(
                    'https://discord.gg/rPWFv6W',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
              contentPadding: EdgeInsets.zero,
              onTap: () async => launchURL('https://discord.gg/rPWFv6W', context),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.translate),
              title: Text(AppLocalizations.of(context).aboutTranslationTitle),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context).aboutTranslationText),
                  const Text(
                    'https://hosted.weblate.org/engage/wger/',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
              contentPadding: EdgeInsets.zero,
              onTap: () async => launchURL('https://hosted.weblate.org/engage/wger/', context),
            ),
            ListTile(
              leading: const Icon(Icons.article),
              title: const Text('View Licenses'),
              contentPadding: EdgeInsets.zero,
              onTap: () {
                showLicensePage(
                  context: context,
                  applicationName: 'wger',
                  applicationVersion: 'App: ${authProvider.applicationVersion!.version}\n'
                      'Server: ${authProvider.serverVersion}',
                  applicationLegalese: '\u{a9} 2020 - 2021 contributors',
                  applicationIcon: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 60,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
