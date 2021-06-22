import 'package:flutter/material.dart';
import 'package:flutter_sqflite_base/data_sources/databases/mark_database/mark_database.dart';
import 'package:flutter_sqflite_base/data_sources/databases/mark_database/mark_model.dart';
class AllMark extends StatefulWidget {
  @override
  _AllMarkState createState() => _AllMarkState();
}

class _AllMarkState extends State<AllMark> {

  final mark_db = MarkDatabase();
  Future<List<MarkModel>> markList ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadMarkDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Students"),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: ()
        {
          Navigator.of(context).pop();
        }),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
              future: markList,
              builder: (context, snapshot)
              {
                if((snapshot.hasError)||(!snapshot.hasData))
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                List<MarkModel> list = snapshot.data;
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return itemListView(list[index]);
                    }
                );

              }
          ),

      ),
    );
  }

  textAndText( {@required lablel, @required content})
  {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
              child: Text(lablel, style: TextStyle(fontWeight: FontWeight.bold),)),
          Expanded(
            flex: 2,
              child: Text(content))
        ],
      ),
    );
  }

  itemListView(MarkModel markModel)
  {
    return Container(
      //padding: EdgeInsets.all(10),
      child: Column(
        children: [
          textAndText(lablel : "Họ Và Tên", content: markModel.user_name),
          textAndText(lablel : "Toán", content: markModel.math_mark.toString()),
          textAndText(lablel : "Văn", content: markModel.liteture_mark.toString()),
          textAndText(lablel : "Anh", content: markModel.english_mark.toString()),
          Divider(),
          ],
      ),
    );
  }

  loadMarkDatabase()  {
    markList =  mark_db.fetchAll();
  }


}
