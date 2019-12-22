# FoodReport Ontology

## Installation

1. Go to the Jetty-distribution directory in the repository with a terminal.
2. Execute the command in your terminal:  ```sudo java -jar start.jar```
3. Go to [http://localhost:8080/fuseki/](http://localhost:8080/fuseki/)
4. Go to the manage datasets page of the Jena Fuseki server.
5. Add a new dataset _foodreport_
6. Stop the Jetty server in your terminal by pressing <kbd>CTRL</kbd>+<kbd>C</kbd>
7. Open the fuseki data folder (/etc/fuseki/) (on Windows this directory should exist in the root of your drive where you are running Jetty.)
8. Open the ”databases” directory (/etc/fuseki/databases/)
9. Inside there is a ”foodreport” directory, open it and delete all the files inside.
10. Start the Jetty server and check if there are any errors.
11. Upload the ”foodreport.owl” file (This is the file with no entities) in the manage datasets window of the manage datasets. This file can be found in the repository (ontology/foodreport.owl)
12. Stop the Jetty server in your terminal by pressing <kbd>CTRL</kbd>+<kbd>C</kbd>
13. Open the Fuseki data folder (/etc/fuseki/) again.
14. Go to the ”configuration” directory (/etc/fuseki/configuration/).
15. Inside this directory, you should see a ”foodreport.ttl” configuration file. Open this file with an editor.
16. Replace the code in that file with the code in the file on GitHub _configuration.ttl_ in the root directory. Note that you have to replace the paths with the correct paths on your computer. The paths need to be routed to the _foodreport-database.db_ and the _foodreport-mapping.ttl_ files that can be found in our repository (database/...).
17. Restart the Jetty server and check if there are any errors.
18. Try to see if everything works with a query.

## Example Queries

This query will give all the ingredients that come from France.

```sql
PREFIX ontology: <http://www.foodreport.be/ontology#>
PREFIX data: <http://www.foodreport.be/data#>

SELECT ?ingredient
WHERE {
  ?ingredient ontology:manufacturedFrom data:France
}
```

This query will give the total amount of sugar in Spaghetti Bolognese.

```sql
PREFIX ontology: <http://www.foodreport.be/ontology#>
PREFIX data: <http://www.foodreport.be/data#>

SELECT (SUM(?sugar) AS ?sugarSum)
WHERE {
  data:Spaghetti%20Bolognese ontology:needsIngredient ?ingredient .
  ?ingredient ontology:sugar ?sugar
}
```

This query will give all the steps of the recipe Spaghetti Bolognese in the correct order.

```sql
PREFIX ontology: <http://www.foodreport.be/ontology#>
PREFIX data: <http://www.foodreport.be/data#>

SELECT ?step
WHERE {
  ?step ontology:describesRecipe data:Tomato%20Soup
} ORDER BY ASC(?step)
```

This query will give the average labourScore and environmentScore for tomatoes produced in France.

```sql
PREFIX ontology: <http://www.foodreport.be/ontology#>
PREFIX data: <http://www.foodreport.be/data#>

SELECT ?avgLabour ?avgEnv
  WHERE {

    {
      SELECT (AVG(?labourScore) AS ?avgLabour)
      WHERE {
        data:Tomato ontology:manufacturedFrom data:France .
        data:France ontology:imposes ?law .
        ?law ontology:labourScore ?labourScore

        # Law applies to foodtype of ingredient or to ingredient itself
        { 
          data:Tomato ontology:hasFoodType ?foodtype .
          ?law ontology:appliesToFoodType ?foodtype 
        }
        UNION
        { 
          ?law ontology:appliesToIngredient data:Tomato
        }
      }
    }

    {
      SELECT (AVG(?environmentScore) AS ?avgEnv)
      WHERE {
        data:Tomato ontology:manufacturedFrom data:France .
        data:France ontology:imposes ?law .
        ?law ontology:environmentScore ?environmentScore

        # Law applies to foodtype of ingredient or to ingredient itself
        { 
          data:Tomato ontology:hasFoodType ?foodtype .
          ?law ontology:appliesToFoodType ?foodtype 
        }
        UNION
        { 
          ?law ontology:appliesToIngredient data:Tomato
        }
      }
    }

}
```
