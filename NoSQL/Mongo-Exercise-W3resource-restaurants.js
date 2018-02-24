//1 Write a MongoDB query to display all the documents in the collection restaurants

db.restaurants.find({})

//2  Write a MongoDB query to display the fields restaurant_id, name, borough and cuisine for all the documents in the collection restaurant.
db.restaurants.find({},{"_id":0,"restaurant_id":1,"name":1,"cuisine":1,"borough":1})

// 3. Write a MongoDB query to display the fields restaurant_id, name, borough and cuisine,
//but exclude the field _id for all the documents in the collection restaurant

db.restaurants.find({},{"_id":0,"restaurant_id":1,"name":1,"cuisine":1,"borough":1})

//4.4. Write a MongoDB query to display the fields restaurant_id, name, borough and zip code,
//but exclude the field _id for all the documents in the collection restaurant
db.restaurants.find({},{"_id":0,"restaurant_id":1,"name":1,"borough":1,"address.zipcode":1})


//5 Write a MongoDB query to display all the restaurant which is in the borough Bronx.
db.restaurants.find({"borough":"Bronx"},{"_id":0,"restaurant_id":1,"name":1})

//6 Write a MongoDB query to display the first 5 restaurant which is in the borough Bronx
db.restaurants.find({"borough":"Bronx"},{"_id":0,"restaurant_id":1,"name":1}).limit(5)

//7 skipping first 5 n displaying next 5
db.restaurants.find({"borough":"Bronx"},{"_id":0,"restaurant_id":1,"name":1}).skip(5).limit(5)

//8. Write a MongoDB query to find the restaurants who achieved a score more than 90.
db.restaurants.find({ "grades.score": {$gt:90}})

db.restaurants.find({grades : { $elemMatch:{"score":{$gt : 90}}}})
//latitude < -95
use mydb
use restaurants
db.restaurants.find({})
db.restaurants.find({"address.coord.0" : {$lt : -102.754168}})

//11 Find the restaurants that do not prepare any cuisine of American and 
//their grade score more than 70 and lattitude less than a specified number
db.restaurants.find(
               {$and:
                    [
                       {"cuisine" : {$ne :"American "}},
                       {"grades.score" : {$gt : 70}},
                       {"address.coord" : {$lt : -65.754168}}
                    ]
                }
                    )
//or can be written
db.restaurants.find( {
    "cuisine" : {$ne :"American "},"grades.score" : {$gt : 70},"address.coord" : {$lt : -65.754168}
    
} )
                      
//13. Write a MongoDB query to find the restaurants which do not prepare any cuisine of 'American ' and achieved a grade point 'A'
//not belongs to the borough Brooklyn. The document must be displayed according to the cuisine in descending order. 
db.restaurants.find(
               {$and:
                    [
                       {"cuisine" : {$ne :"American "}},
                       {"grades.grade" : "A"},
                       {"borough" : {$ne : "Brooklyn"}}
                    ]
                }
                    ).sort({ "cuisine": -1 }).limit(2)
                    
// or -1 for descending order
db.restaurants.find(
                     {$query:
                            {
                             "cuisine" : {$ne : "American "},
                             "grades.grade" :"A",
                             "borough": {$ne : "Brooklyn"}
                            },
                              $orderby : {"cuisine":-1}
                      } 
                    )
                    
//14. Write a MongoDB query to find the restaurant Id, name, borough and cuisine for 
//those restaurants which contain 'Wil' as first three letters for its name.
//db.users.find({name: /a/})  //like '%a%'
//db.users.find({name: /^pa/}) //like 'pa%' 
//db.users.find({name: /ro$/}) //like '%ro'
db.restaurants.find(
{"name": /^Wil/},
{
"restaurant_id" : 1,
"name":1,"borough":1,
"cuisine" :1
}
)
//somewhere Reg

db.restaurants.find(
{"name": /.*Reg.*/},
{
"restaurant_id" : 1,
"name":1,"borough":1,
"cuisine" :1
}
)



    
})
"borough": "Bronx" , 
$or : [
{ "cuisine" : "American " },
{ "cuisine" : "Chinese" }
] 
} 
);

db.restaurants.find(
{"borough" :{$in :["Staten Island","Queens","Bronx","Brooklyn"]}},
{
"restaurant_id" : 1,
"name":1,"borough":1,
"cuisine" :1
}
);
//or ---when it is same field and diff values ,,better to use in operator
db.restaurants.find(
{ $or:[{"borough": "Staten Island"},{"borough": "Queens"},{"borough": "Bronx"},{"borough": "Brooklyn"}]
})



db.restaurants.find(
{"borough" :{$nin :["Staten Island","Queens","Bronx","Brooklyn"]}},
{
"restaurant_id" : 1,
"name":1,"borough":1,
"cuisine" :1
}
);


db.inventory.find( { price: { $not: { $gt: 1.99 } } } )
//This query will select all documents in the inventory collection where:

//the price field value is less than or equal to 1.99 or
//the price field does not exist
//.....................................
//{ $not: { $gt: 1.99 } } is different from the $lte operator. { $lte: 1.99 }
//returns only the documentswhere price field exists and its value is less than or equal to 1.99.


db.inventory.find( { qty: { $exists: true, $nin: [ 5, 15 ] } } )
//This query will select all documents in the inventory collection where the qty field exists and its value does not equal 5 or 15.

//21. Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those restaurants which prepared dish except 'American' and 'Chinees' 
//or restaurant's name begins with letter 'Wil'. 
db.restaurants.find(
{$or :
[{"name": "/^Wil/"},{"cuisine" :{$nin :["American","Chineese"]}}]
},
{
"restaurant_id" : 1,
"name":1,"borough":1,
"cuisine" :1
}
);

//21. Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those restaurants which prepared dish except
//'American' and 'Chinees' or restaurant's name begins with letter 'Wil'. 
db.restaurants.find(
{$or: [
  {name: /^Wil/}, 
  {"$and": [
       {"cuisine" : {$ne :"American "}}, 
       {"cuisine" : {$ne :"Chinees"}}
   ]}
]}
,{"restaurant_id" : 1,"name":1,"borough":1,"cuisine" :1}
);

//22. Write a MongoDB query to find the restaurant Id, name, and grades for those restaurants which achieved a grade of "A" and scored 11 
//on an ISODate "2014-08-11T00:00:00Z" among many of survey dates.
//json it is stored this way 
//"grades": [
//     { "date": { "$date": 1393804800000 }, "grade": "A", "score": 2 },
//     { "date": { "$date": 1378857600000 }, "grade": "A", "score": 6 },
db.restaurants.find( 
                {
                 "grades.date": ISODate("2014-08-11T00:00:00Z"), 
                 "grades.grade":"A" , 
                 "grades.score" : 11
                }, 
                {"restaurant_id" : 1,"name":1,"grades":1}
             );

//23 23. Write a MongoDB query to find the restaurant Id, name, and grades for those restaurants where the 2nd element of grades array contains 
//a grade of "A" and score 9 on an ISODate "2014-08-11T00:00:00Z".

db.restaurants.find( 
                      { "grades.1.date": ISODate("2014-08-11T00:00:00Z"), 
                        "grades.1.grade":"A" , 
                        "grades.1.score" : 9
                      }, 
                       {"restaurant_id" : 1,"name":1,"grades":1}
                   );
                   
                   
//24. Write a MongoDB query to find the restaurant Id, name, address and geographical location for those restaurants where 2nd element of 
//coord array contains a value which is more than 42 and upto 52.
db.restaurants.find( 
                      { 
                        "address.coord.1": {$gt : 42, $lte : 52}
                      },
                        {"restaurant_id" : 1,"name":1,"address":1,"coord":1}
                   );
    
 //25. Write a MongoDB query to arrange the name of the restaurants in ascending order along with all the columns.
 db.restaurants.find().sort({"name":1});
 
 //28 Write a MongoDB query to know whether all the addresses contains the street or not
db.restaurants.find(
                     {"address.street" : 
                         { $exists : true } 
                     } 
                   ); 
                   
//29. Write a MongoDB query which will select all documents in the restaurants collection where the coord field value is Double
db.restaurants.find(
                    {"address.coord" : 
                       {$type : 1}
                    }
                   );
                   
//Type	Number	Alias	Notes
//Double	1	“double”	 
//String	2	“string”	 
//Object	3	“object”	 
//Array	4	“array”	 
//Binary data	5	“binData”	 
//Undefined	6	“undefined”	Deprecated.
//ObjectId	7	“objectId”	 
//Boolean	8	“bool”	 
//Date	9	“date”	 
//Null	10	“null”

//30. Write a MongoDB query which will select the restaurant Id, name and grades for those restaurants 
//which returns 0 as a remainder after dividing the score by 7.

db.restaurants.find(
                      {"grades.score" :
                         {$mod : [7,0]}
                      },
                         {"restaurant_id" : 1,"name":1,"grades":1}
                    );
                    
                    
//31. Write a MongoDB query to find the restaurant name, borough, longitude and attitude and cuisine for 
//those restaurants which contains 'mon' as three letters somewhere in its name.
//{ <field>: { $regex: /pattern/, $options: '<options>' } }
db.restaurants.find(
                   { name : 
                     { $regex : "mon.*", $options: "i" } 
                   },
                       {
                         "name":1,
                         "borough":1,
                         "address.coord":1,
                         "cuisine" :1
                        }
                   );
//Option	Description	Syntax Restrictions
// i	Case insensitivity to match upper and lower cases. For an example, see Perform Case-Insensitive Regular Expression Match.
//or can be done 
db.restaurants.find(
                   { name : {$in : [/mon/,/Mon/]}
                   },
                       {
                         "name":1,
                         "borough":1,
                         "address.coord":1,
                         "cuisine" :1
                        }
                   )
                   
db.restaurants.find(
                   { name : /^Mad/
                     
                   },
                       {
                         "name":1,
                         "borough":1,
                         "address.coord":1,
                         "cuisine" :1
                        }
                   );
                   
//  cursors
///http://nicholasjohnson.com/mongo/course/workbook/
//If we save the cursor in a variable we can call more methods on it.

var people = db.people.find( );
//We can iterate over the the cursor using a simple while loop. We can check if the cursor has a next value, and can call cursor.next to get the value out.

var people = db.people.find();
while (people.hasNext()) {
   print(tojson(people.next()));
}