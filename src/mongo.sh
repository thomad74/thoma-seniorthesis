#!/bin/bash

### MongoDB single-node cluster set-up in a MacOS environment ###

# To install mongodb:
# brew services start mongodb-community@4.2 --> install newest version of MongoDB
# brew services restart mongodb-community --> restart MongoDB services when necessary
# ps aux | grep -v grep | grep mongod --> see if mongod is running correctly

# 1. mongod --> start mongo services
# 2. mongo --> in a new terminal window to open a shell with mongod running in background
# 3. show dbs --> list of databases within mongo shell
# 4. use myDB --> switch to database used for testing
# 5. show collections --> list of collections within selected database
# 6. import data from local machine --> mongoimport --db <nameOfDb> --collection <nameOfCollection> --file <nameOfFile.json>
# 7.

echo "MongoDB Single Node Cluster Set Up"
mongo

# db.orders.insertMany([{cust_id:"A123",amount:500,status:"A"},
# {cust_id:"A123",amount:250,status:"A"},{cust_id:"B212",amount:200,status:"A"},
# {cust_id:"A123",amount:300,status:"D"}])

db.tests.find()

db.tests.find( { ISO: { $gt: 0 } } )

db.tests.mapReduce( function(){emit (this._id,this.Language);}, function(key,values){return
Array.sum(values)}, { query:{Language: "af"}, out:"tests_totals" } )

db.tests_totals.find()


# db.collection.mapReduce(
#    function() {emit(key,value);},
#    function(key,values) {return reduceFunction}, {
#       out: collection,
#       query: document,
#       sort: document,
#       limit: number
#    }
# )
