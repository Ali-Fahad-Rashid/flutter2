import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Details extends StatefulWidget {
  final car;
   Details({Key? key,this.car}) : super(key: key);
  @override
  _DetailsState createState() => _DetailsState();
}
class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
   // print("====================================================");
    //print(widget.car['ur'].length);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,
        title: Text(AppLocalizations.of(context)!.view),
      ),
      body:
          Container(
            height: MediaQuery.of(context).size.height ,
            child: ListView(children: [
              Image.network(widget.car['imageurl'],
                fit: BoxFit.fitWidth,
              ),
              Container(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                   //   height: 10,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.car['ur'].length,
                        itemBuilder: (context, i) {
                          return Container(
                              margin: EdgeInsets.all(2),
                              child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute<void>(
                                        builder: (BuildContext context) {
                                      return Scaffold(
                                        appBar: AppBar( backgroundColor: Colors.black87,
                                          //title: const Text('Next page'),
                                        ),
                                        body:  Image.network(

                                          widget.car['ur'][i],
                                        height: MediaQuery.of(context).size.height,
                                        width: MediaQuery.of(context).size.width,
                                        fit: BoxFit.contain,
                                        ),
                                      );
                                    },
                                    ));
                                  },
                                  child: Center(
                                    child: Image.network(widget.car['ur'][i],
                                    height: 70,width: 70,fit: BoxFit.fill),
                                  )
                              )) ;
                        },
                      ),
                    ),
                    //Image.network(image[0]) ,
                  ],),
              ),
           //   SizedBox(height: 20),
               Card(
                 child:  Container(
                   margin: EdgeInsets.all(10),
                   child: RichText(
                     text: TextSpan(
                       style: Theme.of(context).textTheme.bodyText2,
                       children: [
                         TextSpan(text:AppLocalizations.of(context)!.car, style: TextStyle(fontSize: 30)),
                         TextSpan(text: ': ', style: TextStyle(fontSize: 35,fontWeight: FontWeight.w700,
                         )),
                         TextSpan(text: widget.car['name']+"\n\n", style: TextStyle(
                           fontSize: 30,
                           color: Colors.red,
                         )),

                         TextSpan(text: AppLocalizations.of(context)!.company, style: TextStyle(fontSize: 30)),
                         TextSpan(text: ': ', style: TextStyle(fontSize: 35,fontWeight: FontWeight.w700,
                         )),
                         TextSpan(text: widget.car['company']+"\n\n", style: TextStyle(fontSize: 30
                         ,color: Colors.red,)),

                         TextSpan(text: AppLocalizations.of(context)!.model, style: TextStyle(fontSize: 30)),
                         TextSpan(text: ': ', style: TextStyle(fontSize: 35,fontWeight: FontWeight.w700,
                         )),
                         TextSpan(text: widget.car['model']+"\n\n", style: TextStyle(fontSize: 30,
                           color: Colors.red,)),

                         TextSpan(text: AppLocalizations.of(context)!.price, style: TextStyle(fontSize: 30)),
                         TextSpan(text: ': ', style: TextStyle(fontSize: 35,fontWeight: FontWeight.w700,
                         )),
                         TextSpan(text: widget.car['price']+"\$\n\n", style: TextStyle(fontSize: 30,
                           color: Colors.red,)),

                         TextSpan(text: AppLocalizations.of(context)!.email, style: TextStyle(fontSize: 30)),
                         TextSpan(text: ': ', style: TextStyle(fontSize: 35,fontWeight: FontWeight.w700,
                         )),
                         TextSpan(text: widget.car['user']+"\n\n", style: TextStyle(fontSize: 30,
                           color: Colors.red,)),

                         TextSpan(text: AppLocalizations.of(context)!.description, style: TextStyle(fontSize: 30)),
                         TextSpan(text: ': ', style: TextStyle(fontSize: 35,fontWeight: FontWeight.w700,
                         )),
                         TextSpan(text: widget.car['description']+"\n\n", style: TextStyle(fontSize: 30,
                           color: Colors.red,)),
                       ],
                     ),
                   ),
                 )
               ),],
            ),
          ),
        );
  }
}
