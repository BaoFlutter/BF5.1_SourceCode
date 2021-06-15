import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            // imageWidget
            coverImageWidget(),
            // titleWidget
            titleWidget(),
            // buttonWidgets
            buttonWidgets(),
            // descriptionWidget,
            descriptionWidget(text:"Shepherd Traveller is a blog born out of my love for nature, travel, and adventures, and my passion for writing. Feel free to explore my site, get immersed in nature’s wonders and get informed about unique adventures." )
          ],
        ),
      ),
    );
  }
  // imageWidget

  Widget coverImageWidget(){
    return Image.asset(
      'assets/images/cover_image.jpeg',
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height/2.5,
      width: MediaQuery.of(context).size.width,
    );
  }
  
  // titleWidget
  Widget titleWidget(){
    return Container(
      padding: EdgeInsets.only(top:20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Oschinen Lake CampGround", style: TextStyle( fontWeight: FontWeight.bold),),
                  Text("Kagstern, Switzerland", style: TextStyle(color: Colors.black26),),
                ],
              ),
            ),

          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.deepOrange,),
                  Text("41")
                ],
              ),
            ),
          ),

        ],
      ),
    );

  }

  // button Widgets

 buttonWidgets(){
    return Container(
      padding: EdgeInsets.only(top:20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex:1,
            child: itemButton(icon: Icons.call, label: "call",
              onPressed: (){
                print("Calling");
              }),),
          Expanded(
            flex: 1,
              child: itemButton(icon: Icons.navigation, label: "route",
                  onPressed: (){
                    print("Routing");
                  }),),
          Expanded(
            flex: 1,
              child: itemButton(icon: Icons.share, label: "share",
                  onPressed: (){
                    print("Shareing");
                  }),),

        ],
      ),
    );
 }

 itemButton({ @required icon, @required String label,  @required onPressed  }){
    return GestureDetector(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.blue,),
            SizedBox(height: 10,),
            Text(label.toUpperCase(), style: TextStyle(color: Colors.blue),)
          ],
        ),
      ),
      onTap: onPressed,
    );

 }

 // description Widget
Widget descriptionWidget( {String text})
{
  return Container(
    padding: EdgeInsets.only(top: 20, left: 20),
    child: Text(
      text,
      softWrap: true,
    ),
  );

}






}
