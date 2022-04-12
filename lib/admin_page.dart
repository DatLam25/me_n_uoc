part of menuoc;

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final communitiesController = TextEditingController();
  final _adminFormKey = GlobalKey<FormState>();
  static const _pageSize = 10;

  final PagingController<int, String> _pagingController =
  PagingController(firstPageKey: 0);

  String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Cursus vitae congue mauris rhoncus aenean vel elit scelerisque. Risus feugiat in ante metus dictum at. Sed euismod nisi porta lorem. Ullamcorper sit amet risus nullam eget felis eget. Vel quam elementum pulvinar etiam non quam. Blandit turpis cursus in hac. Volutpat blandit aliquam etiam erat velit scelerisque in dictum. Neque sodales ut etiam sit. Ultricies integer quis auctor elit sed.";

  Future<void> _communitiesFetch(int pageKey) async {
    await Future.delayed(const Duration(milliseconds: 100));
    //TODO: Fetch Post by Username
    List<String> newData = pageKey >= 100
        ? []
        : List.generate(
        _pageSize,
            (index) => "Community ${pageKey + index}");

    final isLastPage = newData.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(newData);
    } else {
      final nextPageKey = pageKey + newData.length;
      _pagingController.appendPage(newData, nextPageKey);
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _pagingController.refresh();
    });
  }



  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _communitiesFetch(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text("${globals.currentUser.username}'s Admin Page")),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }, //To Home Page
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: (){
              globals.currentUser = globals.CurrentUser(false, "", false);
              storage.deleteAll();
              Navigator.pop(context);
            },

          )
        ],
      ),
      body: ListView(
        children: <Widget>[

          const Text("Communities", style: TextStyle(fontSize: 30)),
          PagedListView.separated(
              separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 0, height: 20, color: Colors.white,),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<String>(
                itemBuilder: (BuildContext context, String item, int index) {
                  return Container(
                    color: randomColor(index),
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(5),
                          height: 35.0,
                          alignment: Alignment.topLeft,
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: (){
                              //TODO: add logic to remove from the list
                              _refresh();
                            },
                            icon: const Icon(Icons.clear)
                        )
                      ]
                    ),
                  );
                },
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    content: Form(
                      key: _adminFormKey,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                  controller: communitiesController,
                                  decoration: const InputDecoration(
                                    hintText: "New Community",
                                    border: OutlineInputBorder(),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                child: const Text("Save"),
                                onPressed: () {
                                  //TODO: Call to add new community
                                  if (_adminFormKey.currentState!.validate()) {
                                    _adminFormKey.currentState!.save();
                                  }
                                  _refresh();
                                  communitiesController.clear();
                                  Navigator.of(context).pop();
                                },
                              ),
                            )
                          ]),
                    ));
              });
        },
        tooltip: 'Add new community',
        child: const Icon(Icons.add),
        backgroundColor: Colors.pink.shade200,
      ),
    );
  }
}
