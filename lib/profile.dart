part of menuoc;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final bioController = TextEditingController();

  static const _pageSize = 10;
  Profile profile = Profile("", "");

  final _formKey = GlobalKey<FormState>();
  final PagingController<int, Post> _pagingController =
      PagingController(firstPageKey: 0);

  String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Cursus vitae congue mauris rhoncus aenean vel elit scelerisque. Risus feugiat in ante metus dictum at. Sed euismod nisi porta lorem. Ullamcorper sit amet risus nullam eget felis eget. Vel quam elementum pulvinar etiam non quam. Blandit turpis cursus in hac. Volutpat blandit aliquam etiam erat velit scelerisque in dictum. Neque sodales ut etiam sit. Ultricies integer quis auctor elit sed.";

  Future<void> _pageFetch(int pageKey) async {
    await Future.delayed(const Duration(milliseconds: 100));
    //TODO: Fetch Post by Username
    List<Post> newData = pageKey >= 100
        ? []
        : List.generate(
            _pageSize,
            (index) => Post("Title ${index + pageKey}", loremIpsum,
                index + pageKey, globals.currentUser.username));

    final isLastPage = newData.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(newData);
    } else {
      final nextPageKey = pageKey + newData.length;
      _pagingController.appendPage(newData, nextPageKey);
    }
  }

  Future<void> _bioFetch() async {
    await Future.delayed(const Duration(milliseconds: 100));
    //TODO: Fetch Profile by Username
    Profile userProfile = Profile("testTag", loremIpsum);
    setState(() {
      profile = userProfile;
    });
  }

  Future<void> _refresh() async {
    setState(() {
      _pagingController.refresh();
    });
  }



  @override
  void initState() {
    super.initState();
    _bioFetch();
    _pagingController.addPageRequestListener((pageKey) {
      _pageFetch(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text("${globals.currentUser.username}@${profile.tag}")),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }, //To Home Page
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              //TODO: Make popup for editing post content
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        content: Form(
                      key: _formKey,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: bioController,
                                  decoration: const InputDecoration(
                                hintText: "New Bio",
                                border: OutlineInputBorder(),
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                child: const Text("Save"),
                                onPressed: () {
                                  //TODO: Call to Update Bio
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                  }
                                  setState(() {
                                    profile.bio = bioController.text;
                                  });
                                  bioController.clear();
                                  Navigator.of(context).pop();
                                },
                              ),
                            )
                          ]),
                    ));
                  });
            },
          ),
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
          Container(
            color: Colors.blueGrey[50],
            child: Text(profile.bio, style: const TextStyle(fontSize: 20)),
          ),
          Text("Posts by ${globals.currentUser.username}", style: const TextStyle(fontSize: 30)),
          PagedListView<int, Post>(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Post>(
                itemBuilder: (BuildContext context, Post item, int index) {
                  return Stack(
                    children: <Widget>[
                      Card(
                        child: Column(
                          //mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(5),
                              color: randomColor(index),
                              height: 35.0,
                              alignment: Alignment.topLeft,
                              child: Text(
                                item.title,
                                style: const TextStyle(fontSize: 25),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              color: randomColor(index),
                              height: 140.0,
                              alignment: Alignment.topLeft,
                              child: Text(
                                item.content,
                                style: const TextStyle(fontSize: 25),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned.fill(
                          child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return DetailedPost(index, item);
                                  })).then((_) => _refresh());
                                }, //Go to the Specific Post Page
                              )))
                    ],
                  );
                },
              ))
        ],
      ),
    );
  }
}
