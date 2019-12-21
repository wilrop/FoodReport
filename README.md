# FoodReport Ontology

## Installation
1. Go to the jetty directory
2. execute the command ```sudo java -jar start.jar```
3. Go to [http://localhost:8080/fuseki/](http://localhost:8080/fuseki/)
4. Go to the manage datasets page
5. Add a new dataset _foodreport_
6. Add the two files: foodreport.owl and foodreport-data.owl
7. Try it with a query!
   
## Example Queries

```sql
PREFIX foodreport: <http://www.foodreport.be/ontology#>

select ?country ?continent WHERE {
?country foodreport:isPartOf ?continent
}
```
## R2RML

1. Turn off the Jetty server
2. Open the fuseki data folder (/etc/fuseki/) (on Windows this directory should exist in the root of
your drive where you are running Jetty.)
3. Open the ”databases” directory (/etc/fuseki/databases/)
4. Inside there is a ”foodreport” directory, open it and delete all the files inside (Otherwise restart the Jetty server, go to localhost:8080 and make a new empty dataset (with no files), turn off jetty server and remove all the files in the folder)
5. Start Jetty and check if there are any errors
6. Upload the ”foodreport.owl” file (the one with no data)
7. Turn off the Jetty server
8. Open the fuseki data folder (/etc/fuseki/)
9. Go the ”configuration” directory
10. Inside you should see a ”foodreport.ttl” configuration file. Open this with an editor
11. Replace the code in the file with the code in the file on Github _configurationtll.ttl_ Note that you have to replace the paths with the correct paths on your computer
