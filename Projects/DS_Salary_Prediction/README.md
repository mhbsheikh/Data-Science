<!-- PROJECT LOGO -->
<br />
<p align="center">
  <h1 align="center">Data Science Salary Prediction</h1>

<!--   <h4 align="center">
    A machine learning approach to estimate the data science salary.
  <br> <br>
  </h4> -->
  
<!--   <a href="https://github.com/mehedihasanbijoy/">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a> -->
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#overview">Overview</a></li>
    <li><a href="#data_cleaning">Data Cleaning</a></li>
    <li><a href="#feature_engineering">Feature Engineering</a></li>
    <li><a href="#eda">Exploratory Data Analysis</a></li>
    <li><a href="#ml">Machine Learning</a></li>
    <li><a href="#refs">References</a></li>
  </ol>
</details>



<!-- ############################################################## -->
<h2 id='overview'> Overview </h2>
It is a machine learning model that estimates data science salaries to help data scientists negotiate their income when they get a job. The project incudes Data Cleaning, Featire Engineering, Exploratory Data Analysis, and Regression. In the case of predictive models, optimized Linear, Lasso, and Random Forest Regressors using GridsearchCV to reach the best model.



<!-- ############################################################## -->
<h2 id='data_cleaning'> Data Cleaning </h2>
<ul>
  <li>Parsed numeric data out of salary</li>
  <li>Removed rows without salary</li>
  <li>Removed unnecessary texts from company names</li>
  <li>Fixed differnet state name and abbreviation mismatches</li>
</ul>



<!-- ############################################################## -->
<h2 id='feature_engineering'> Feature Engineering </h2>
<ul>
  <li>Made columns for employer provided salary and hourly wages</li>
  <li>Parsed rating out of company text</li>
  <li>Made a new column for company state</li>
  <li>Added a column for if the job was at the company’s headquarters</li>
  <li>Transformed founded date into age of company</li>
  <li>Made columns for if different skills were listed in the job description: Python, R, Excel, AWS, Spark</li>
  <li>Added column for simplified job title and Seniority</li>
  <li>Calculated the description length in a new column</li>
</ul>



<!-- ############################################################## -->
<h2 id='eda'> Exploratory Data Analysis </h2>
Illustrated the distributions of the data and the value counts for the various categorical variables and pivot table. Also, visualized a few queries in <a href="https://public.tableau.com/app/profile/mehedi.hasan.bijoy/viz/DataScience_Salary_Prediction_0/Dashboard1" target="_blank">Tableau</a> including:
<ul>
  <li>Top-5 most paying positions</li>
  <li>Top skills required for data science related jobs</li>
  <li>Average salary of different positions</li>
  <li>Top-5 positions with highest starting salary</li>
</ul>




<!-- ############################################################## -->
<h2 id='ml'> Machine Learning </h2>
Interpreted three different models including Linear, Lasso, and Random Forest Regressor and evaluated them using Mean Absolute Error. Started with Multiple Linear Regression and then tried Lasso and Random Forest. Among these three models, Linear Regression performs the worst and Random Forest Regressor performs the best.



<!-- ############################################################## -->
<h2 id='refs'> References </h2>
[1] <a href="https://www.youtube.com/playlist?list=PL2zq7klxX5ASFejJj80ob9ZAnBHdz5O1t">Data Science Project From Scratch</a>




<!-- ############################################################## -->
<h2 id=''> License </h2>
Distributed under the MIT License. See `LICENSE` for more information.



<!-- ############################################################## -->
<h2 id=''> Contact </h2>
Mehedi Hasan Bijoy - [@Facebook](https://facebook.com/mhbsheikh) - [@LinkedIn](https://www.linkedin.com/in/mhbsheikh/)

