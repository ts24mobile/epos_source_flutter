import 'package:epos_source_flutter/src/app/app_localizations.dart';
import 'package:epos_source_flutter/src/app/core/baseViewModel.dart';
import 'package:epos_source_flutter/src/app/helper/loading_spinner.dart';
import 'package:epos_source_flutter/src/app/pages/configDomain/configDomain_page_viewmodel.dart';
import 'package:epos_source_flutter/src/app/theme/theme_primary.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class ConfigDomainPage extends StatefulWidget {
  static const String routeName = "/configDomain";
  @override
  _ConfigDomainPageState createState() => _ConfigDomainPageState();
}

class _ConfigDomainPageState extends State<ConfigDomainPage> {
  ConfigDomainPageViewModel viewModel = ConfigDomainPageViewModel();

  @override
  void initState() {
    viewModel.reloadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(viewModel),
      body: ViewModelProvider(
        viewmodel: viewModel,
        child: StreamBuilder<Object>(
            stream: viewModel.stream,
            builder: (context, snapshot) {
              return ConfigDomainBodyWidget();
            }),
      ),
    );
  }

  Widget _appBar(ConfigDomainPageViewModel viewModel) => GradientAppBar(
        title: Text(translation.text("CONFIG_DOMAIN.CONFIG_DOMAIN")),
        backgroundColorStart: Theme.of(context).primaryColor,
        backgroundColorEnd: Color(0Xff135691),
        // bottom: TabBar(
        //   tabs: <Widget>[Text('Một'), Text('Hai')],
        // ),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              viewModel.onSaveConfigDomain();
            },
            child: Text(
              translation.text("CONFIG_DOMAIN.SAVE"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      );
}
// class ConfigDomainPage extends StatelessWidget {
//   static const String routeName = "/configDomain";
//   @override
//   Widget build(BuildContext context) {
//     ConfigDomainPageViewModel viewModel = ConfigDomainPageViewModel();
//     return Scaffold(
//       appBar: _appBar(viewModel),
//       body: ViewModelProvider(
//         viewmodel: viewModel,
//         child: ConfigDomainBodyWidget(),
//       ),
//     );
//   }

//   Widget _appBar(ConfigDomainPageViewModel viewModel) =>
//       GradientAppBar(
//         title: Text("Cấu hình domain"),
//         backgroundColorStart: Colors.blue,
//         backgroundColorEnd: Color(0Xff135691),
//         // bottom: TabBar(
//         //   tabs: <Widget>[Text('Một'), Text('Hai')],
//         // ),
//         actions: <Widget>[
//           FlatButton(
//             textColor: Colors.white,
//             onPressed: () {
//               viewModel.onSaveConfigDomain();
//             },
//             child: Text(
//               "Lưu",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//             ),
//             shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
//           ),
//         ],
//       );
// }

class ConfigDomainBodyWidget extends StatefulWidget {
  @override
  _ConfigDomainBodyWidgetState createState() => _ConfigDomainBodyWidgetState();
}

class _ConfigDomainBodyWidgetState extends State<ConfigDomainBodyWidget> {
  ConfigDomainPageViewModel viewModel;
  final focusClientId = FocusNode();
  final focusClientSerect = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ViewModelProvider.of(context);
    viewModel.context = context;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              child: TextFormField(
                controller: viewModel.domainController,
                //controller: _domainController,
                style: TextStyle(fontSize: 18, color: Colors.black),
                autofocus: true,
                decoration: InputDecoration(
                    labelText: "DOMAIN",
                    labelStyle: ThemePrimary.loginPageButton(context)),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (v) {
                  FocusScope.of(context).requestFocus(focusClientId);
                },
              ),
            ),
            Container(
              child: TextFormField(
                controller: viewModel.clientIDController,
                focusNode: focusClientId,
                style: TextStyle(fontSize: 18, color: Colors.black),
                decoration: InputDecoration(
                    labelText: "CLIENT ID",
                    labelStyle: ThemePrimary.loginPageButton(context)),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (v) {
                  FocusScope.of(context).requestFocus(focusClientSerect);
                },
              ),
            ),
            Container(
              child: TextFormField(
                controller: viewModel.clientSerectController,
                focusNode: focusClientSerect,
                style: TextStyle(fontSize: 18, color: Colors.black),
                decoration: InputDecoration(
                    labelText: "CLIENT SECRET",
                    labelStyle: ThemePrimary.loginPageButton(context)),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (v) {
                  viewModel.onSaveConfigDomain();
                },
              ),
            ),
            LoadingSpinner.loadingView(
                context: context, loading: viewModel.loading),
          ],
        ),
      ),
    );
  }
}
