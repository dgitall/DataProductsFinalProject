Data Products: Final Project
========================================================
author: Darrell Gerber
date: October 5, 2021
autosize: true
font-family: 'Arial'
<br>
<br>
<h2 style="text-align:center">Exploring fuel economy data</h2>

Fuel Efficiency Data
========================================================

The 'ggplot2' R package contains a data set with the fuel efficiency of
38 models of cars for 1999 to 2008.  
  
- a rich data set 
- useful to practice many analysis and graphing tasks.  
- But, can be tedious to explore (234 rows and 11 variables)

```
# A tibble: 3 x 11
  manufacturer model displ  year   cyl trans      drv     cty   hwy fl    class 
  <chr>        <chr> <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr> 
1 audi         a4      1.8  1999     4 auto(l5)   f        18    29 p     compa~
2 audi         a4      1.8  1999     4 manual(m5) f        21    29 p     compa~
3 audi         a4      2    2008     4 manual(m6) f        20    31 p     compa~
```
Exploring Fuel Efficiency
========================================================

[Exploring Auto Fuel Efficiency]( https://dgitall.shinyapps.io/ExploringFuelEfficiency/)
an interactive web app for simple exploration of the 'mpg' data set in the 'ggplot2' package.
  
* The application will:  
   + Display the data in a easy to read, sortable table
   + Allow the user to filter the data set to focus on specific manufacturers, transmission 
types, or number of cylinders
   + Graph either city or highway fuel efficiency against a user selected variable

View and Graph Data
========================================================
The ['Exploring Fuel Efficiency'](https://dgitall.shinyapps.io/ExploringFuelEfficiency/) app has four main sections  
  
  
  
![Application Image] (App1-small.png)  

***
- Filters: The user can filter the data to show only the selected
manufacturer, transmission type, or number of cylinders.   
- Data: The filtered data is displayed in the table in the 'Data' tab at the bottom.
The data can be sorted and the user can set the 
number of rows to display per page. A selected a row in the data
table is highlighted in the graph.  
  

View and Graph Data
========================================================
![Application Image] (App2-small.png)  
[Exploring Fuel Efficiency](https://dgitall.shinyapps.io/ExploringFuelEfficiency/)
***
- Controls: The user to selects which
fuel efficiency type to display in the graph (either city or highway) and the x-axis variable.
- Graph: The selected fuel efficiency type is plotted on the y-axis against a
user selected parameter on the x-axis.  
  
Information on the 'mpg' data set:  [Fuel economy data from 1999 to 2008 for 38 popular models of cars](https://ggplot2.tidyverse.org/reference/mpg.html)


