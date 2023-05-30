import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool checkedState = false;
  bool priorityState = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Task",
            style: TextStyle(color: Colors.black, fontSize: 28.0),
          ),
          backgroundColor: Colors.transparent,
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add),
            onPressed: () {}),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              color: Colors.white,
              elevation: 5.0,
              shadowColor: Colors.black45,
              margin:
                  const EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular((7.0))),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
                leading: Checkbox(
                    activeColor: Colors.green,
                    value: checkedState,
                    onChanged: (value) {
                      setState(() {
                        checkedState = value!;
                      });
                    }),
                title: Text(
                  "Today's Task",
                  style: TextStyle(
                    fontSize: 19.5,
                    fontWeight: FontWeight.w500,
                    decoration: checkedState
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                subtitle: Row(
                  children: const <Widget>[
                    Text("Task Category"),
                    SizedBox(
                        width: 20.0,
                        child: Icon(Icons.circle_rounded, size: 5.0)),
                    Text("Due Date"),
                    SizedBox(
                        width: 20.0,
                        child: Icon(Icons.circle_rounded, size: 5.0)),
                    Text("Due Time")
                  ],
                ),
                trailing: GestureDetector(
                    onTap: () {
                      setState(() {
                        priorityState = !priorityState;
                      });
                    },
                    child: Icon(
                        priorityState
                            ? Icons.star_outlined
                            : Icons.star_outline,
                        color: Colors.black)),
              ),
            ),
            const SizedBox(height: 25.0),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () async {
                    final SharedPreferences sharedPrefs =
                        await SharedPreferences.getInstance();
                    sharedPrefs.setBool('loginState', false);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login_screen', (route) => false);
                  },
                  child: const Text("Log out")),
            )
          ],
        ));
  }
}
