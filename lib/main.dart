import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      home:new Simcalc(),
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
      ),
    ),
  );
}

class Simcalc extends StatefulWidget{
  @override
  SimcalcState createState() => SimcalcState();

}

class SimcalcState extends State<Simcalc>{
 var _formKey = GlobalKey<FormState>();
 var _currencies = ['Rupees','Dollar','Ponds','Other'];
 var _newChangedvalue= 'Rupees';

 TextEditingController principalcontroller = TextEditingController();
 TextEditingController roicontroller = TextEditingController();
 TextEditingController termcontroller =TextEditingController();

 var answer = '';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple interest calculator'),
      ),
      body: new Form(
        key: _formKey,
       child: ListView(
        children: <Widget>[
          getImageAsset(),

          Padding(
            padding:EdgeInsets.all(5.0),
          child:TextFormField(
            controller: principalcontroller,
            validator: (String value){
              if (value.isEmpty){   
                return 'please enter principal amount';
              }
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              
              
              labelText: 'Principal',
              hintText: 'Enter principal eg.12000',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ) ,
            ),
          ),
          ),

          Padding(
            padding: EdgeInsets.all(5.0),
            child:TextFormField(
              validator: (String value){
                if(value.isEmpty){
                  return 'please enter the rate of interest';
                }
              },

              controller: roicontroller,
              
          
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              
              labelText: 'Rate of Interest',
              hintText: 'in percent',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ) ,
            ),
          ),
          ),
          

          Padding(
            padding:EdgeInsets.all(5.0),
          child:Row(
            children: <Widget>[
              new Expanded(
                child: TextFormField(
                  validator: (String value){
                    if(value.isEmpty){
                      return 'please enter the term';
                    }
                  },
                  controller: termcontroller,
          
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              
              labelText: 'Term',
              hintText: 'in percent',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ) ,
            ),
          ),
              ),

              Container(width:24.0),
                
          
               Expanded(
                
                child: DropdownButton<String>(
                  items: _currencies.map((String dropDownvalue){
                    return DropdownMenuItem<String>(
                      value: dropDownvalue,
                      child: Text(dropDownvalue),
                    );
                  }).toList(),

                  value: _newChangedvalue,

                  onChanged: (String newValue) {
                    setState(() {
                      _newChangedvalue=newValue;
                      
                    });

                  },
                ),
              ),
              
              

            ],
          ),
          ),
          
          
            
            Row(
            children: <Widget>[
              Padding(
                padding:EdgeInsets.only(left: 90.0),
              child:RaisedButton(
                child: Text('Calculate'),
                color: Colors.deepOrange,
                onPressed: () {

                  setState(() {
                    if (_formKey.currentState.validate()){

                   this.answer = calculateIt(); 
                    }
                  });

                },
              ),
              ),

               RaisedButton(
                child: Text('Reset'),
                onPressed: () {
                  setState(() {

                   changeEverything(); 
                  });
                },
              ),


            ],
          ),
            
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(this.answer),
            )
          

        ],
      ),
      ),
    );
  }

  Widget getImageAsset(){ 
    
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(image: assetImage,width: 125.0,height: 125.0);
    return Container(child: image,margin: EdgeInsets.all(25.0) ,);
    }

    String calculateIt(){
      double principal = double.parse(principalcontroller.text);
      double roi = double.parse(roicontroller.text);
      double term = double.parse(termcontroller.text);

      double amount = principal + (principal * roi * term) /100 ;

      String result = 'After $term year , your investmen will be worth $amount in $_newChangedvalue';

      return result;

    }


    void changeEverything(){
      principalcontroller.text='';
      roicontroller.text = '';
      termcontroller.text= ' ';
      answer= '';
      _newChangedvalue = 'Rupees'; 


    }
}