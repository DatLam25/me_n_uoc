part of menuoc;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
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
                "Login",
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.pink,
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                  decoration: InputDecoration(
                hintText: "Username",
                border: OutlineInputBorder(),
              )),
              const SizedBox(height: 10),
              const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
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
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    )),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                  },
                  child: const Text(
                    "Don't have an account? Register here",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  )),
            ],
          ),
        ));
  }
}
