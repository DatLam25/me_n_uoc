part of menuoc;

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Chat currentChat = Chat(0, "");
  final chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Chat> chats = [];
  List<Message> messages = [];
  List<String> users = [];
  List<String> chattedUsers = [];

  _userFetch() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    List<String> newData = List.generate(5, (index) => "Friend ${index * 5}");
    List<String> chattedUsersData = [];
    for (Chat chat in chats) {
      chattedUsersData.add(chat.user);
    }
    setState(() {
      users = newData;
      chattedUsers = chattedUsersData;
    });
  }

  Future<void> _chatFetch() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    //TODO: Add fetch chat by user
    List<Chat> newData =
        List.generate(5, (index) => Chat(index, "Friend $index"));
    setState(() {
      chats = newData;
      //Remember to check for null
      currentChat = chats[0];
    });
  }

  Future<void> _messageFetch() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    //TODO: Add fetch message by user
    List<Message> newData = List.generate(
        10, (index) => Message(currentChat.user, "What is up? $index"));
    newData.addAll(List.generate(
        10,
        (index) =>
            Message(globals.currentUser.username, "What is up? $index")));
    setState(() {
      messages = newData;
    });
  }

  @override
  void initState() {
    _chatFetch().then((_) => {
          if (chats.isNotEmpty) {_messageFetch()}
        });
    super.initState();
  }

  @override
  void dispose() {
    chatController.dispose();
    _scrollController.dispose();
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
        title: chats.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.black,
              ))
            : DropdownButtonFormField<Chat>(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                dropdownColor: Colors.white,
                value: currentChat,
                icon: const Icon(Icons.account_box),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                onChanged: (Chat? newValue) {
                  setState(() {
                    currentChat = newValue!;
                  });
                  _messageFetch();
                },
                items: chats.map<DropdownMenuItem<Chat>>((Chat value) {
                  return DropdownMenuItem<Chat>(
                    value: value,
                    child: Text(value.user),
                  );
                }).toList(),
              ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _userFetch();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return MultiSelectDialog(
                        title: const Text("Select Friend to Add"),
                        cancelText: const Text(
                          "CANCEL",
                          style: TextStyle(color: Colors.black),
                        ),
                        confirmText: const Text(
                          "OK",
                          style: TextStyle(color: Colors.black),
                        ),
                        initialValue: chattedUsers,
                        items:
                            users.map<MultiSelectItem<String>>((String value) {
                          return MultiSelectItem<String>(value, value);
                        }).toList(),
                        onConfirm: (values) {
                          //TODO Call API to create new chat rooms with friends selected
                          _chatFetch();
                        },
                      );
                    });
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Expanded(
              child: messages.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Colors.black,
                    ))
                  : ListView.separated(
                      controller: _scrollController,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        bool sendByCurrentUser = messages[index].sender ==
                            globals.currentUser.username;
                        return Column(
                          crossAxisAlignment: (sendByCurrentUser)
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: sendByCurrentUser
                                      ? Colors.pinkAccent
                                      : Colors.lightBlueAccent,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              child: Text(
                                messages[index].sender +
                                    ": " +
                                    messages[index].message,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        );
                      })),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                // First child is enter comment text input
                Expanded(
                  child: TextFormField(
                    controller: chatController,
                    autocorrect: true,
                    decoration: InputDecoration(
                      hintText: "Send message...",
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                // Second child is button
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.black,
                  iconSize: 20.0,
                  onPressed: () {
                    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                    //TODO: Add API call to chat

                    setState(() {});
                    chatController.clear();
                  },
                )
              ])),
        ],
      ),
    );
  }
}
