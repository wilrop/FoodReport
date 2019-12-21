CREATE TABLE Recipe
(
  recipeName TEXT NOT NULL,
  PRIMARY KEY (recipeName)
);

CREATE TABLE Step
(
  describesRecipe TEXT NOT NULL,
  orderNumber INT NOT NULL,
  description TEXT NOT NULL,
  FOREIGN KEY (describesRecipe) REFERENCES Recipe(recipeName),
  PRIMARY KEY (describesRecipe, orderNumber)
);

CREATE TABLE Ingredient
(
  ingredientName TEXT NOT NULL,
  foodType TEXT NOT NULL,
  calcium FLOAT NOT NULL,
  calories FLOAT NOT NULL,
  carbohydrates FLOAT NOT NULL,
  fat FLOAT NOT NULL,
  proteins FLOAT NOT NULL,
  sodium FLOAT NOT NULL,
  sugar FLOAT NOT NULL,
  FOREIGN KEY (foodType) REFERENCES FoodType(foodTypeName)
  PRIMARY KEY (ingredientName)
);

CREATE TABLE NeedsIngredient
(
  recipe TEXT NOT NULL,
  ingredient TEXT NOT NULL,
  FOREIGN KEY (recipe) REFERENCES Recipe(recipeName),
  FOREIGN KEY (ingredient) REFERENCES Ingredient(ingredientName),
  UNIQUE (ingredient, recipe)
);

CREATE TABLE Country
(
  countryName TEXT NOT NULL,
  continent TEXT NOT NULL,
  FOREIGN KEY (continent) REFERENCES Continent(continentName),
  PRIMARY KEY (countryName)
);

CREATE TABLE ManufacturedFrom
(
  ingredient TEXT NOT NULL,
  country TEXT NOT NULL,
  FOREIGN KEY (ingredient) REFERENCES Ingredient(ingredientName),
  FOREIGN KEY (country) REFERENCES Country(countryName),
  UNIQUE (ingredient, country)
);

CREATE TABLE Law
(
  lawName TEXT NOT NULL,
  lawText TEXT NOT NULL,
  labourScore FLOAT, 
  environmentScore FLOAT,
  PRIMARY KEY (lawName)
);

CREATE TABLE AppliesToIngredient
(
  law TEXT NOT NULL,
  ingredient TEXT NOT NULL,
  FOREIGN KEY (law) REFERENCES Law(lawName),
  FOREIGN KEY (ingredient) REFERENCES Ingredient(ingredientName),
  UNIQUE (law, ingredient)
);

CREATE TABLE Imposes
(
  country TEXT NOT NULL,
  law TEXT NOT NULL,
  FOREIGN KEY (country) REFERENCES Country(countryName),
  FOREIGN KEY (law) REFERENCES Law(lawName),
  UNIQUE (country, law)
);

CREATE TABLE Continent
(
  continentName TEXT NOT NULL,
  PRIMARY KEY (continentName)
);

CREATE TABLE FoodType
(
  foodTypeName TEXT NOT NULL,
  PRIMARY KEY (foodTypeName)
);

CREATE TABLE AppliesToFoodType
(
  law TEXT NOT NULL,
  foodType TEXT NOT NULL,
  FOREIGN KEY (law) REFERENCES Law(lawName),
  FOREIGN KEY (foodType) REFERENCES FoodType(foodTypeName),
  UNIQUE (law, foodType)
);

CREATE TABLE Trajectory
(
  trajectoryName TEXT NOT NULL,
  countryFrom TEXT NOT NULL,
  countryTo TEXT NOT NULL,
  ingredient TEXT NOT NULL,
  distance FLOAT NOT NULL,
  trajectoryScore FLOAT NOT NULL,
  FOREIGN KEY (ingredient) REFERENCES Ingredient(ingredientName),
  FOREIGN KEY (countryFrom) REFERENCES Country(countryName),
  FOREIGN KEY (countryTo) REFERENCES Country(countryName),
  PRIMARY KEY (trajectoryName, countryFrom, countryTo)
);

INSERT INTO "Recipe" VALUES ('Spaghetti Bolognese');
INSERT INTO "Recipe" VALUES ('Tomato Soup');

INSERT INTO "Step" VALUES ('Spaghetti Bolognese', 1, 'Put a large saucepan on a medium heat and add 1 tbsp olive oil.');
INSERT INTO "Step" VALUES ('Spaghetti Bolognese', 2, 'Add 4 finely chopped bacon rashers and fry for 10 mins until golden and crisp.');
INSERT INTO "Step" VALUES ('Tomato Soup', 1, 'Cut 5 tomatoes in small pieces.');
INSERT INTO "Step" VALUES ('Tomato Soup', 2, 'Fill a pot with (hot) water and boil it to about 100 degrees celcius.');
INSERT INTO "Step" VALUES ('Tomato Soup', 3, 'Add tomatoes to the bowl.');

INSERT INTO "FoodType" VALUES ('Fruits');
INSERT INTO "FoodType" VALUES ('Oils');
INSERT INTO "FoodType" VALUES ('Pastas');

INSERT INTO "Ingredient" VALUES ('Tomato', 'Fruits', 18.0, 32.0, 5.8, 0.3, 1.3, 7.5, 3.9);
INSERT INTO "Ingredient" VALUES ('Capellini', 'Pastas', 0.0, 357.0, 78.6, 1.8, 12.5, 0.0, 1.8);
INSERT INTO "Ingredient" VALUES ('Olive Oil', 'Oils', 1.0, 884.0, 0.0, 0.0, 100.0, 2.0, 0.0);

INSERT INTO "NeedsIngredient" VALUES ('Spaghetti Bolognese', 'Tomato');
INSERT INTO "NeedsIngredient" VALUES ('Spaghetti Bolognese', 'Capellini');
INSERT INTO "NeedsIngredient" VALUES ('Spaghetti Bolognese', 'Olive Oil');
INSERT INTO "NeedsIngredient" VALUES ('Tomato Soup', 'Tomato');

INSERT INTO "Continent" VALUES ('Europe');
INSERT INTO "Continent" VALUES ('North America');

INSERT INTO "Country" VALUES ('France', 'Europe');
INSERT INTO "Country" VALUES ('Italy', 'Europe');
INSERT INTO "Country" VALUES ('Mexico', 'North America');

INSERT INTO "ManufacturedFrom" VALUES ('Tomato', 'Mexico');
INSERT INTO "ManufacturedFrom" VALUES ('Tomato', 'France');
INSERT INTO "ManufacturedFrom" VALUES ('Olive Oil', 'Italy');

INSERT INTO "Law" VALUES ('Pesticide restriction K-58', 'Pesticides with dangerous chemicals are not allowed.', NULL, 85.0);
INSERT INTO "Law" VALUES ('80 hour work week', "All workmen have to work at least 80 hours a week.", 12.0, NULL);

INSERT INTO "Imposes" VALUES ('France', '80 hour work week');
INSERT INTO "Imposes" VALUES ('Mexico', '80 hour work week');

INSERT INTO "AppliesToFoodType" VALUES ('Pesticide restriction K-58', 'Fruits');
INSERT INTO "AppliesToFoodType" VALUES ('80 hour work week', 'Fruits');
INSERT INTO "AppliesToFoodType" VALUES ('80 hour work week', 'Oils');
INSERT INTO "AppliesToFoodType" VALUES ('80 hour work week', 'Pastas');

INSERT INTO "Trajectory" VALUES ('trajectory18', 'France', 'Italy', 'Tomato', 580.0, 42.0);
INSERT INTO "Trajectory" VALUES ('trajectory18', 'Mexico', 'Italy', 'Tomato', 1997.0, 30.0);
INSERT INTO "Trajectory" VALUES ('trajectory83', 'France', 'Italy', 'Tomato', 555.0, 44.0);
