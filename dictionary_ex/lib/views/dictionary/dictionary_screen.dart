import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:dictionary_ex/data_sources/dictionary/word_model.dart';
import 'package:english_ron/generated/l10n.dart';
import 'package:english_ron/home_page/home_screen.dart';
import 'package:english_ron/home_page/look_up_provider.dart';
import 'package:english_ron/pages/dictionary/dict_tool.dart';
import 'package:english_ron/pages/new_word_page/new_word_model.dart';
import 'package:english_ron/resources/theme.dart';
import 'package:english_ron/resources/utils/check_internet_connection.dart';
import 'package:english_ron/resources/utils/dismiss_keyboard.dart';
import 'package:english_ron/resources/utils/logging.dart';
import 'package:english_ron/resources/utils/translation.dart';
import 'package:english_ron/resources/utils/translation_cloud/repository/repositoy.dart';
import 'package:english_ron/resources/utils/tts_cloud/TextToSpeechAPI.dart';
import 'package:english_ron/resources/utils/tts_cloud/voice.dart';
import 'package:english_ron/resources/widgets/line.dart';
import 'package:english_ron/resources/widgets/spaces.dart';
import 'package:english_ron/sqlite_process/database.dart';
import 'package:english_ron/sqlite_process/database_vi.dart';
import 'package:english_ron/sqlite_process/new_word_database.dart';
import 'package:english_ron/sqlite_process/word_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:io' show File, Platform;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class DictionaryPage extends StatefulWidget {
  final WordModel wordModel;
  final SearchLanguage searchLanguage;
  const DictionaryPage({Key key, this.wordModel, this.searchLanguage})
      : assert(wordModel != null),
        super(key: key);

  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage>
    with TickerProviderStateMixin {
  // final LanguageIdentifier languageIdentifier =
  //     FirebaseLanguage.instance.languageIdentifier();
  TextEditingController searchController = TextEditingController();
  final db = WordDatabase();
  final dbVi = WordDatabaseVi();
  final nw_db = NewWordDatabase();

  Future<List<WordModel>> searchResultsFuture;
  int hintWordsLength = 0;
  WordModel wordModel;
  String meaning = '';
  String wordSearch;
  //TTS Cloud

  List<Voice> _USVoices = [];
  List<Voice> _UKVoices = [];
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  Voice _selectedUSVoice;
  Voice _selectedUKVoice;
  AudioPlayer audioUSPlugin = AudioPlayer();
  AudioPlayer audioUKPlugin = AudioPlayer();

  //TTS
  FlutterTts flutterTts;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.3;
  bool us_voice = true;

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    fetchWord(widget.wordModel.word);
    initTts();

    //TTS Cloud
    //_selectedUSVoice = Voice('en-US-Wavenet-A', 'MALE', ['en-US']);
    //_selectedUKVoice = Voice('en-GB-Wavenet-B', 'MALE', ['en-GB']);
  }

  @override
  void dispose() {
    searchController.dispose();
    _tabController.dispose();
    flutterTts.stop();
    super.dispose();
  }

  initTts() async {
    flutterTts = FlutterTts();
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(Platform.isAndroid ? 0.5 : rate);
    await flutterTts.setPitch(pitch);
    if (widget.searchLanguage == SearchLanguage.en) {
      await flutterTts.setLanguage("en-US");
    } else {
      await flutterTts.setLanguage("vi-VN");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<LookUpProvider>(context, listen: false).clear();
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: _searchWordItem(),
        body: SingleChildScrollView(
          child: _showMeaning(),
        ),
      ),
    );
  }

  // Show meaning
  _showMeaning() {
    return Stack(
      children: [
        Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Theme.of(context).backgroundColor,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.grey.withOpacity(0.4),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),

                //height: 85,
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            wordSearch == null
                                ? widget.wordModel.word
                                : wordSearch,
                            style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        )),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          spaceHorizontal5(),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.volume_up,
                                      size: 30,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () async {
                                      if (wordSearch != null) {
                                        if (wordSearch.isNotEmpty) {
                                          await flutterTts.speak(wordSearch);
                                        }
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              horizontal_line(context),
              wordModel != null
                  ? Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      //height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Theme.of(context).backgroundColor,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: AppTheme.grey.withOpacity(0.4),
                              offset: Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: formatResultWidget(
                          wordModel.meaning ?? "", wordSearch)
                    //child: Text(wordModel.meaning),

                  ),
                ],
              )
                  : Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Theme.of(context).backgroundColor,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.4),
                          offset: Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          S.current.text_translation,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppTheme.darkText,
                              fontFamily: AppTheme.fontName,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      horizontal_line(context),
                      Container(
                        padding:
                        EdgeInsets.only(left: 5, top: 10, bottom: 40),
                        child: Text(
                          meaning,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppTheme.darkText,
                              fontFamily: AppTheme.fontName),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
        Consumer<LookUpProvider>(
          builder: (context, value, child) {
            if (value.wordsEn.length > 0 || value.wordsVi.length > 0) {
              return Container(
                height: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    50,
                margin:
                EdgeInsets.only(top: 5, right: 20, left: 20, bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Theme.of(context).backgroundColor,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).shadowColor,
                          offset: Offset(0, 0),
                          blurRadius: 26)
                    ]),
                child: Column(
                  children: [
                    TabBar(
                        controller: _tabController,
                        indicatorPadding: EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        labelStyle: TextStyle(fontSize: 18),
                        labelPadding: EdgeInsets.symmetric(vertical: 10),
                        tabs: [
                          Text(S.current.english),
                          Text(S.current.vietnamese)
                        ]),
                    Expanded(
                      child: TabBarView(controller: _tabController, children: [
                        buildSearchResult(SearchLanguage.en, value.wordsEn),
                        buildSearchResult(SearchLanguage.vi, value.wordsVi),
                      ]),
                    )
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }

  //
  fetchWord(String string) async {
    print(widget.searchLanguage);
    if (widget.searchLanguage == SearchLanguage.en) {
      wordModel = await db.fetchWordByWord(string);
      await flutterTts.setLanguage("en-US");
    } else {
      wordModel = await dbVi.fetchWordByWord(string);
      await flutterTts.setLanguage("vi-VN");
    }

    String word = "";
    wordSearch = string;
    if (wordModel == null) {
      if (await CheckInternetConnection().connected()) {
        String langCode =
        await TranslationRepository().getDetectionLanguage(wordSearch);
        if (langCode == "vi") {
          word = await translateToEnglish(inputString: wordSearch);
          await flutterTts.setLanguage("vi-VN");
        } else {
          word = await translateToVietNamese(inputString: wordSearch);
          await flutterTts.setLanguage("en-US");
        }

        nw_db.addWord(NewWordModel(
            word_id: null,
            word: wordSearch,
            pronounce: " ",
            meaning: word + "##$langCode",
            time: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day)
                .toString()));
      } else {
        word = S.current.need_connect_to_translate;
      }
    } else {
      wordSearch = wordModel.word;
      word = wordModel.meaning;
      await nw_db.addWord(NewWordModel(
          word_id: null,
          word: wordSearch,
          pronounce: wordModel.pronounce,
          meaning: widget.searchLanguage == SearchLanguage.en
              ? word + "##en"
              : word + "##vi",
          time: DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)
              .toString()));
    }

    setState(() {
      meaning = word;
      searchResultsFuture = null;
      hintWordsLength = 0;
    });
  }

  fetchWordSearch(String string) async {
    if (_tabController.index == 0) {
      wordModel = await db.fetchWordByWord(string);
      await flutterTts.setLanguage("en-US");
    } else {
      wordModel = await dbVi.fetchWordByWord(string);
      await flutterTts.setLanguage("vi-VN");
    }

    String word = "";
    if (wordModel == null) {
      Log().printLog("Search in internet");
      if (await CheckInternetConnection().connected()) {
        String langCode =
        await TranslationRepository().getDetectionLanguage(string);
        if (langCode == "vi") {
          word = await translateToEnglish(inputString: string);
          await flutterTts.setLanguage("vi-VN");
        } else {
          word = await translateToVietNamese(inputString: string);
          await flutterTts.setLanguage("en-US");
        }
        nw_db.addWord(NewWordModel(
            word_id: null,
            word: string,
            pronounce: " ",
            meaning: word + "##$langCode",
            time: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day)
                .toString()));
      } else {
        word = S.current.need_connect_to_translate;
      }
    } else {
      word = wordModel.meaning;
      nw_db.addWord(NewWordModel(
          word_id: null,
          word: string,
          pronounce: " ",
          meaning: _tabController.index == 0 ? word + "##en" : word + "##vi",
          time: DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)
              .toString()));
    }

    setState(() {
      wordSearch = string;
      meaning = word;
      hintWordsLength = 0;
    });
    Provider.of<LookUpProvider>(context, listen: false).clear();
  }

  // Item 1 : Search word
  AppBar _searchWordItem() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Provider.of<LookUpProvider>(context, listen: false).clear();
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
          ),
          onPressed: () {
            if (searchController.text.isNotEmpty) {
              fetchWordSearch(searchController.text);
              searchController.clear();
            }
          },
        ),
        IconButton(
          icon: Icon(
            Icons.clear,
          ),
          onPressed: clearSearch,
        ),
      ],
      title: Column(
        children: [
          Container(
            // padding: EdgeInsets.only( right: 10, top: 10),
            //margin: EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              textAlign: TextAlign.start,
              controller: searchController,
              cursorColor: Colors.white,
              cursorWidth: 3,
              decoration:
              InputDecoration.collapsed(hintText: S.current.hint_look_up),

              onChanged: handlesearch,
              onFieldSubmitted: handleSearchOnSubmitted,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: AppTheme.fontName,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              // onFieldSubmitted: handlesearch,
            ),
          ),
        ],
      ),
    );
  }

  // create Dictionary Database

  handlesearch(String searchWord) async {
    if (searchWord.isNotEmpty) {
      await Provider.of<LookUpProvider>(context, listen: false)
          .lookUp(searchWord);
      if (context.read<LookUpProvider>().wordsEn.length == 0 &&
          context.read<LookUpProvider>().wordsVi.length > 0) {
        await Future.delayed(Duration(milliseconds: 100), () {
          _tabController.animateTo(1);
        });
      } else if (context.read<LookUpProvider>().wordsEn.length > 0 &&
          context.read<LookUpProvider>().wordsVi.length == 0) {
        _tabController.animateTo(0);
      } else if (context.read<LookUpProvider>().wordsEn.length > 0 &&
          context.read<LookUpProvider>().wordsVi.length > 0) {
        //
      } else {
        _tabController.animateTo(0);
        Provider.of<LookUpProvider>(context, listen: false).clear();
      }
    } else {
      _tabController.animateTo(0);
      Provider.of<LookUpProvider>(context, listen: false).clear();
    }
  }

  //
  handleSearchOnSubmitted(String searchWord) async {
    KeyBoard().off(context);
    searchController.clear();
    if (searchWord.isNotEmpty) {
      if (_tabController.index == 0) {
        wordModel = await db.fetchWordByWord(searchWord);
        await flutterTts.setLanguage("en-US");
      } else {
        wordModel = await dbVi.fetchWordByWord(searchWord);
        await flutterTts.setLanguage("vi-VN");
      }

      wordSearch = searchWord;

      String word = "";
      if (wordModel == null) {
        if (await CheckInternetConnection().connected()) {
          String langCode =
          await TranslationRepository().getDetectionLanguage(wordSearch);
          if (langCode == "vi") {
            word = await translateToEnglish(inputString: wordSearch);
            await flutterTts.setLanguage("vi-VN");
          } else {
            word = await translateToVietNamese(inputString: wordSearch);
            await flutterTts.setLanguage("en-US");
          }
          nw_db.addWord(NewWordModel(
              word_id: null,
              word: wordSearch,
              pronounce: " ",
              meaning: word + "##$langCode",
              time: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day)
                  .toString()));
        } else {
          word = S.current.need_connect_to_translate;
        }
      } else {
        word = wordModel.meaning;
        nw_db.addWord(NewWordModel(
            word_id: null,
            word: wordSearch,
            pronounce: wordModel.pronounce,
            meaning: _tabController.index == 0 ? word + "##en" : word + "##vi",
            time: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day)
                .toString()));
      }

      setState(() {
        wordSearch = searchWord;
        meaning = word;
        searchResultsFuture = null;
        hintWordsLength = 0;
      });
      Provider.of<LookUpProvider>(context, listen: false).clear();
    }
  }

  ////
  buildSearchResult(SearchLanguage searchLanguage, List<WordModel> listWords) {
    List<WordModel> searchWords = [];
    listWords.forEach((word) {
      searchWords.add(word);
    });

    return ListView.builder(
      itemCount: searchWords.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            height: 50,
            padding: EdgeInsets.all(8),
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    searchWords[index].word,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style:
                    TextStyle(fontSize: 18, fontFamily: AppTheme.fontName),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                horizontal_line(context)
              ],
            ),
          ),
          onTap: () async {
            KeyBoard().off(context);
            searchController.clear();
            Provider.of<LookUpProvider>(context, listen: false).clear();
            setState(() {
              // searchResultsFuture = null;
              wordSearch = searchWords[index].word;
              wordModel = searchWords[index];
              meaning = searchWords[index].meaning;
              searchResultsFuture = null;
              hintWordsLength = 0;
            });

            await nw_db.addWord(NewWordModel(
                word_id: null,
                word: searchWords[index].word,
                pronounce: searchWords[index].pronounce,
                meaning: _tabController.index == 0
                    ? searchWords[index].meaning + "##en"
                    : searchWords[index].meaning + "##vi",
                time: DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day)
                    .toString()));
          },
        );
      },
    );
  }

  clearSearch() {
    searchController.clear();
    _tabController.animateTo(0);
    Provider.of<LookUpProvider>(context, listen: false).clear();
    KeyBoard().off(context);
  }

  void synthesizeUSText(String text, String name) async {
    if (audioUSPlugin.state == AudioPlayerState.PLAYING) {
      await audioUSPlugin.stop();
    }
    String audioUSContent = await TextToSpeechAPI().synthesizeText(
        text, _selectedUSVoice.name, _selectedUSVoice.languageCodes.first);
    if (audioUSContent == null) return;
    final usBytes =
    Base64Decoder().convert(audioUSContent, 0, audioUSContent.length);
    final us_dir = await getTemporaryDirectory();
    final us_file = File('${us_dir.path}/wavenet.mp3');
    await us_file.writeAsBytes(usBytes);
    await audioUSPlugin.play(us_file.path, isLocal: true);
    audioUSPlugin.dispose();
  }

  void synthesizeUKText(String text, String name) async {
    if (audioUKPlugin.state == AudioPlayerState.PLAYING) {
      await audioUKPlugin.stop();
    }
    String audioUKContent = await TextToSpeechAPI().synthesizeText(
        text, _selectedUKVoice.name, _selectedUKVoice.languageCodes.first);
    if (audioUKContent == null) return;
    final uk_bytes =
    Base64Decoder().convert(audioUKContent, 0, audioUKContent.length);
    final uk_dir = await getTemporaryDirectory();
    final uk_file = File('${uk_dir.path}/wavenet.mp3');
    await uk_file.writeAsBytes(uk_bytes);
    await audioUKPlugin.play(uk_file.path, isLocal: true);
    audioUKPlugin.dispose();
  }

  void getUSVoices() async {
    final voices = await TextToSpeechAPI().getVoices();
    if (voices == null) return;
    setState(() {
      _selectedUSVoice = voices.firstWhere(
              (e) =>
          e.name == 'en-US-Wavenet-A' && e.languageCodes.first == 'en-US',
          orElse: () => Voice('en-US-Wavenet-A', 'MALE', ['en-US']));
      _USVoices = voices;
    });
  }

  void getUKVoices() async {
    final voices = await TextToSpeechAPI().getVoices();
    if (voices == null) return;
    setState(() {
      _selectedUKVoice = voices.firstWhere(
              (e) =>
          e.name == 'en-GB-Wavenet-B' && e.languageCodes.first == 'en-GB',
          orElse: () => Voice('en-GB-Wavenet-B', 'MALE', ['en-GB']));
      _UKVoices = voices;
    });
  }
}
