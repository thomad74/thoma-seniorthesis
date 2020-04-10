#!/bin/bash

### MongoDB single-node cluster set-up in a MacOS environment ###

# To install mongodb:
# brew services start mongodb-community@4.2 --> install newest version of MongoDB
# brew services restart mongodb-community --> restart MongoDB services when necessary
# ps aux | grep -v grep | grep mongod --> see if mongod is running correctly

# 1. mongod --> start mongo server
# 2. mongo --> in a new terminal window to open a shell with mongod running in background
# 3. show dbs --> list of databases within mongo shell
# 4. use myDB --> switch to database used for testing
# 5. show collections --> list of collections within selected database
# 6. import data from local machine --> mongoimport --db <nameOfDb> --collection <nameOfCollection> --file <nameOfFile.json>
# 7. run script from local machine in mongodb data directory --> mongo mongo.sh

# echo "Starting timer: "
# start=$SECONDS # start timer #

echo "MongoDB Single Node Cluster Set Up"

mongoimport --db myDB --collection tests --file countries-big.json # import data to mongo shell

mongo # start mongo shell

use myDB # select database for use

db.tests.find() # ensure data is imported properly

var mapFunction1 = function(){ emit(this._id,this.name);}; # declares the map function to emit items with _id (key) and name (value)

var reduceFunction1 = function(keyId,valuesNames){return Array.sum(valuesNames);}; # declares reduce function to take emitted items as key value pairs

db.test2.mapReduce(mapFunction1,reduceFunction1,{ out: "test2_totals"})

db.tests_totals.find() # print the output folder with the results of the MapReduce job

db.tests_totals.count() # ensures all data points were included in the MapReduce job

# duration=$(( SECONDS - start )) # end timer #
# echo "Printing Duration: "
# echo $duration
echo "Thank you for using this tool! Goodbye!"

# db.collection.mapReduce(
#    function() {emit(key,value);},
#    function(key,values) {return reduceFunction}, {
#       out: collection,
#       query: document,
#       sort: document,
#       limit: number
#    }
# )
