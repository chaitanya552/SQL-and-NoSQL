// drops current database
db.dropDatabase()
show dbs
use local
//create database 
use mydb
//creates collection
db.createCollection("myCollection")
show collections
//creates collection
//if it is not present it creates otherwise it uses existing 
db.myCollection2.insert({"name":"chaitu"})
show collections
db.myCollection.drop()
show collections

use school
db.students.insert(
 {
  "StudentNo": 1,
  "FirstName": "chaitu",
  "LastName": "kumar",
  "age": 20
 }
)

db.students.insert([
 {
  "StudentNo": 4,
  "FirstName": "chaitu",
  "LastName": "kumar2",
  "age": 22
 },
 {
  "StudentNo": 5,
  "FirstName": "ciaitu",
  "LastName": "kumar3",
  "age": 23
 },
 {
  "StudentNo": 6,
  "FirstName": "cjaitu",
  "LastName": "kumar4",
  "age": 204
 }
 ]
)
//querying 
db.students.find()
//to find one element
db.students.findOne()

db.students.find({"StudentNo":2})

db.students.find(
{
  "age": 20
}
)
//lt,lte,gte,ne

db.students.find(
{
  "FirstName":"chaitu","age":20
}
)
//, is and operator
//$or :[] is or operator
db.students.find(
{
  $or : [{"FirstName":"chaitu"},{"age":22}]

}  
)

//mix of and  or operator. here age is 20 or 22

db.students.find(
{
  "FirstName":"chaitu", $or : [{"age":20},{"age":22}]
}
)
db.students.find()

//update a doc, change surname
db.students.update(
{ "_id": ObjectId("5a88b066d0e3f44899d0b5fe")},
{$set: {"LastName": "neeru"}}  
)
db.students.find()
// update multiple values
// we are having 2 ages of 20 
//only 1 will be updated
db.students.update(
{ "age":20},
{$set: {"LastName": "neerus"}},
{multi: true}  
)
db.students.find()

db.students.update(
{ "age":25},
{$set: {"LastName": "neerukondas"}},
{multi: true}  
)
db.students.find()
//another method to update
//using save , copy entire doc
//if id is not found it creates new doc
db.students.save(
{
    "_id" : ObjectId("5a88b066d0e3f44899d0b5ff"), 
    "StudentNo" : 1.0, 
    "FirstName" : "Tom", 
    "LastName" : "Jerry", 
    "age" : 17 
})
//test- doc not found so added
db.students.save(
    {
    "age":25,
     "LastName": "neerukondas"})


db.students.find()


//delete all docs
db.students.remove({})

//delete on condition
db.students.remove(
{
  "_id" : ObjectId("5a88b066d0e3f44899d0b5ff")
}
)

db.students.find()

//even if cndition matches multiple values it will delete multiple values
db.students.remove(
{
  "LastName":"neerukondas"
}
)
// removes only 1 doc
db.students.remove(
{
  "LastName":"neerukondas",
  "age":25
},1
)


db.students.find({
    age: {
        $gt: 20
    }
}, {
    FirstName: 1
})

// projection is ike view in sql. ie if you want to see only few fields
//along with first name we get id by default
db.students.find({},{"FirstName":1,"_id":0})

db.students.find({},{"FirstName":1, "_id":0})

//limit sort and skip
//to see only few docs, i.e limit docs

db.students.find({},{"_id":0,"StudentNo":1, "FirstName":1}).limit(3)

//skip is like offset, skips first two values
db.students.find({},{"_id":0,"StudentNo":1, "FirstName":1}).skip(2)


//skip n limit
db.students.find({},{"_id":0,"StudentNo":1, "FirstName":1}).skip(2).limit(2)

//sort -> 1 for ascending order, -1 for desc
db.students.find({},{"_id":0,"StudentNo":1, "FirstName":1}).sort({"FirstName":-1})


//indexes
use temp
for(i=0; i<100000; ++i)
{
  db.myCollection.insert({"student_id":i,"name":"mark"});
}
db.myCollection.find().limit(10).skip(50)
//find checks all the docs, so it is very much time taking
db.myCollection.find({"student_id":10000})

//find checks all the docs
//findOne comes out when it finds
db.myCollection.findOne({"student_id":500})

//when we endure index , we can find the elements in less time
//creating index
//create index for id like fields
db.myCollection.ensureIndex({"student_id":1})

// now search for same data
db.myCollection.findOne({"student_id":500})

//remove index
db.myCollection.dropIndex({"student_id":1})


//aggregation, something like count(*), groupby checks all the docs
use school
db.students.find()

//adding gender field
for(i=4; i<8; i++)
{
db.students.update(
 {"StudentNo": 6},{$set : {"gender":"male"}}, {multi: true} 
 )
}

// we can perform sum, min, max , avg
//gives no of male n female
db.students.find({})
db.students.aggr
db.students.aggregate(
{$group: 
  {
    _id : "$gender",myResult :{$sum: 1}
  }
})
/////https://docs.mongodb.com/manual/aggregation/
db.students.aggregate(qb.where("age").eq(22))
                      .group({ _id: "$gender", total: { $sum: 1 } })
                      .sort({total:-1})
/////
db.students.aggregate().group({ _id: "$gender", total: { $sum: 1 } })
                     

// max age in male and female groups, dont forget $ symbol
db.students.aggregate(
{$group: 
  {
    _id : "$gender",myResult :{$max: "$age"}
  }
})
// match and group
db.articles.aggregate( [
                        { $match : { score : { $gt : 70, $lte : 90 } } },
                        { $group: { _id: null, count: { $sum: 1 } } }
                       ] );

//
db.students.aggregate([
{$match: {"status":"A"}},
{$group: 
  {
    _id : "$gender",myResult :{$max: "$age"}
  }
}])


 db.myCollection.find()
 
 show dbs
 
 //to take a backup of existing databases
 // open elevatd cmd and go to bin folder of mongo
 //now type mongodump->this takes a backup
 // after dropping dbs you can restore by command mongorestore
 //to take specific database backup :
