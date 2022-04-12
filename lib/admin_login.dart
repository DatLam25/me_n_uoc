part of menuoc;

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({Key? key}) : super(key: key);

  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}


class _AdminLoginPageState extends State<AdminLoginPage> {
  final usernameController = TextEditingController();
  final passWordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passWordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }, //To Home Page
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "Admin Login",
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.pink,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                hintText: "Username",
                border: OutlineInputBorder(),
              )),
              const SizedBox(height: 10),
              TextField(
                  controller: passWordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(),
                  )),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        backgroundColor: Colors.black,
                        fixedSize: Size.infinite),
                    onPressed: () {
                          //TODO: Add Login API Call
                          setState(() {
                            globals.currentUser.isLoggedIn = true;
                            globals.currentUser.username = "admin 0";
                            globals.currentUser.isAdmin = true;
                          });
                          Navigator.pop(context);
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    )),
              ),
            ],
          ),
        ));
  }
}
