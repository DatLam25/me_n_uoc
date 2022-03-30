part of menuoc;

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String dropdownValue = 'Friend A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: DropdownButton<String>(
          value: dropdownValue,
          elevation: 16,
          style: const TextStyle(color: Colors.pink),
          underline: Container(
            height: 2,
            color: Colors.pinkAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['Friend A', 'Friend B', 'Friend C', 'Friend D']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset(
                logoAsset,
                semanticsLabel: "Me&UofC",
              ))
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.pink[100],
                      border: Border.all(
                        color: Colors.pink.shade50,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: const Text(
                    "You: Sup",
                    style: TextStyle(fontSize: 20),
                  )),
              const SizedBox(height: 10),
              Container(
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.pink[100],
                      border: Border.all(
                        color: Colors.pink.shade50,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Text(
                    "$dropdownValue: Do you know how to center a div",
                    style: const TextStyle(fontSize: 20),
                  )),
              const SizedBox(height: 10),
              Container(
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.pink[100],
                      border: Border.all(
                        color: Colors.pink.shade50,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: const Text(
                    "You: I don't even know webdev lol",
                    style: TextStyle(fontSize: 20),
                  )),
            ],
          )),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                // First child is enter comment text input
                Expanded(
                  child: TextFormField(
                    autocorrect: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          // borderRadius:
                          //     BorderRadius.all(Radius.zero(5.0)),
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                ),
                // Second child is button
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.black,
                  iconSize: 20.0,
                  onPressed: () {},
                )
              ])),
        ],
      ),
    );
  }
}
