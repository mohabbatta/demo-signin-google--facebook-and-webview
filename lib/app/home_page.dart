import 'package:flutter/material.dart';
import 'package:mohab_task/app/web_view_page.dart';
import 'package:mohab_task/common_widget/custom_raised_button.dart';
import 'package:mohab_task/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_blue/flutter_blue.dart';

class MyHomePage extends StatefulWidget {
  final List<BluetoothDevice> devicesList = [];
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _urlController = TextEditingController();

  _addDeviceTolist(final BluetoothDevice device) {
    if (!widget.devicesList.contains(device)) {
      setState(() {
        widget.devicesList.add(device);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceTolist(device);
      }
    });
    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result.device);
      }
    });
    widget.flutterBlue.startScan();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("essac"),
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.login),
              onPressed: auth.signOut,
            ),
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: Container(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    child: _buildHeader(),
                    height: 50,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(auth.user.url),
                    ),
                    title: Text(auth.user.name ?? ''),
                    subtitle: Text(auth.user.email),
                  ),
                  TextField(
                    controller: _urlController,
                  ),
                  SizedBox(height: 20),
                  CustomRaisedButton(
                    child: Text(
                      "Go",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    color: Colors.red,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebViewPage(
                                  url: _urlController.text,
                                )),
                      );
                    },
                  ),
                  new DropdownButton<String>(
                    hint: Text("Devices"),
                    items: widget.devicesList.map((BluetoothDevice device) {
                      return new DropdownMenuItem<String>(
                        value: device.id.toString() ?? " ",
                        child: new Text(device.id.toString() ?? " "),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Text(
      'Welcome',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
