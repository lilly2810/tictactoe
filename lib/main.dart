import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main()=> runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
    home:MyApp()));



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int count=0;
  int flag = 0; //x turn -0,o turn -1

  List<String> display = ["", "", "", "", "", "", "", "", ""];
  List<int> scores = [0,0,0,0,0,0,0,0,0];
  int xscore = 0;
  int oscore = 0;

  @override

  void initState(){
    super.initState();
    this.start();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("TIC-TAC-TOE", style: GoogleFonts.macondo(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),),

      ),
      body:
      Column(
        children: [
          Container(

            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text("   Player X\n\t\t\t     ${xscore}\t",
                          style: GoogleFonts.macondo(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow,
                          ),),
                        Text("      Player O\n\t\t\t        ${oscore}",
                            style: GoogleFonts.macondo(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                            ))
                      ],

                    ),
                  ],
                ),

              ],

            ),
          ),
          Expanded(
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _Tap(index);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(40.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.yellow),

                      ),
                      child:
                      Text(
                          display[index], style: GoogleFonts.macondo(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.yellow,
                      )
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(child:  TextButton(onPressed: start,
              child: Text("RESTART",style: TextStyle(fontSize: 20,color: Colors.yellow),)),),
         Expanded(
         child: TextButton(onPressed: reset, child: Text("RESET SCORE",style: TextStyle(fontSize: 20,color: Colors.yellow),) ))

        ],
      ),
    );
  }



  void _Tap(int index) {
    setState(() {});
    if (flag == 0 && display[index] == "") {
      display[index]="X"; count++;}
    else if (flag == 1 && display[index] == "") {
      display[index]="O"; count++;}

    if(!win(index)){
    if(flag==0) flag=1;
    else flag=0;}

  }
bool win(int index){
    int row = index ~/ 3;
    int col = index % 3;
    int score = flag == 0 ? 1 : -1;

    scores[row] += score;
    scores[3 + col] += score;
    if (row == col) scores[2 * 3] += score;
    if (3 - 1 - col == row) scores[2 * 3 + 1] += score;
    if (scores.contains(3) || scores.contains(-3)) {
      printres();
      return true;}
    if(count==9){
      showDialog(barrierDismissible: true, context: context,
          builder:(BuildContext context){
            return AlertDialog(
              title: Text("DRAW!!!"),
            );
          });
      start();
      return true;
    }

return false;
  }
  void printres(){
    String res= flag==0?"X":"O";
    showDialog(barrierDismissible: true, context: context,
        builder:(BuildContext context){
      return AlertDialog(
        title: Text(res + "  WON!!!"),
      );
    });
if(flag==0) xscore++;
else oscore++;
start();
  }
void start()async{
   count=0;
   flag = 0;
   display = ["", "", "", "", "", "", "", "", ""];
   scores = [0,0,0,0,0,0,0,0,0];
   await Future.delayed(Duration(milliseconds: 200));
   setState(() {});
}
void reset()async{

    start();
    xscore=0;
    oscore=0;
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {});

}
}
