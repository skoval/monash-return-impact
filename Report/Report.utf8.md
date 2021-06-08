---
title: "MAKING AN IMPACT: A model of return impact in professional tennis"
author:
- familyname: Peimin
  othernames: Lin
  address: Monash University
  email: plin0018@student.monash.edu
  correspondingauthor: false
bibliography: references.bib
biblio-style: authoryear-comp
linestretch: 1.5
output:
  MonashEBSTemplates::report:
    fig_caption: yes
    fig_height: 5
    fig_width: 8
    includes:
      in_header: preamble.tex
    keep_tex: yes
    number_sections: yes
    citation_package: biblatex
    toc: false
---




\clearpage

# Introduction
What positions should players stand and get a better impact on the serve return? Are there any strategies that the players used during their tennis games? As we know, the serve return is also important in tennis, however, there is lots of analysis about the tennis before and return impact analysis were not really common, mainly because the positions of the data containing the 3D position is not easy to collect and there is not too much sample for analysis. In the project, we are going to explore a model for the return impact position of the profession mal players using recently go public tracking data summaries on the ATP Tour websites of the 2D position of the ball at the time of return impact,


# Project Goals
The serve return is the shot the receiver hits off of their opponent's serve. The position use (x,y) to represent, the center of the net use (0,0),Figure \@ref(fig:court) provided the visualisation of the tennis court, the (x,y) is the length and lateral position. This project will develop a generative model for the return impact position of professional male players. Furthermore, the project will identify key contextual variables that may influence return impact, including but not limited to:
* Serve number
* Serve direction
* Surface
* Receiver
* Server
Moreover, there is a shiny dashboard designed for the project visualisation, there is a section will show the user guide about the shiny dashboard.

\begin{figure}
\includegraphics[width=0.7\linewidth]{image/tennis_court} \caption{Tennis Court}(\#fig:court)
\end{figure}

# Overview the dataset
The data set Figure\@ref(fig:datset) includes return impact for returned points in ATP singles matches for events between 2018 and 2020. There are 25 variables and 126455 observations in this data set and each observation refers to a single point within a match. From Figure\@ref(fig:tidymiss), there is no missing value in the data set, so we omit the data wrragling this step and use the data directly. 

\begin{figure}
\includegraphics[width=1\linewidth]{image/dataset} \caption{Data set overview}(\#fig:datset)
\end{figure}






```
##    match_id               X                 Y                    Z         
##  Length:126455      Min.   :-23.111   Min.   :-10.587000   Min.   :-0.004  
##  Class :character   1st Qu.:-13.902   1st Qu.: -3.951000   1st Qu.: 1.191  
##  Mode  :character   Median :-12.841   Median :  0.782000   Median : 1.328  
##                     Mean   :-13.012   Mean   :  0.006236   Mean   : 1.344  
##                     3rd Qu.:-11.867   3rd Qu.:  2.903000   3rd Qu.: 1.493  
##                     Max.   : -6.423   Max.   : 10.212000   Max.   : 3.902  
##      serve          player            opponent           playerid        
##  Min.   :1.000   Length:126455      Length:126455      Length:126455     
##  1st Qu.:1.000   Class :character   Class :character   Class :character  
##  Median :1.000   Mode  :character   Mode  :character   Mode  :character  
##  Mean   :1.408                                                           
##  3rd Qu.:2.000                                                           
##  Max.   :2.000                                                           
##   event_name             year        surface                Ad        
##  Length:126455      Min.   :2018   Length:126455      Min.   :0.0000  
##  Class :character   1st Qu.:2019   Class :character   1st Qu.:0.0000  
##  Mode  :character   Median :2019   Mode  :character   Median :0.0000  
##                     Mean   :2019                      Mean   :0.4229  
##                     3rd Qu.:2020                      3rd Qu.:1.0000  
##                     Max.   :2020                      Max.   :1.0000  
##       Clay            Grass            server_n       receiver_n   
##  Min.   :0.0000   Min.   :0.00000   Min.   : 1.00   Min.   :10.00  
##  1st Qu.:0.0000   1st Qu.:0.00000   1st Qu.:16.00   1st Qu.:21.00  
##  Median :0.0000   Median :0.00000   Median :29.00   Median :32.00  
##  Mean   :0.1465   Mean   :0.05388   Mean   :28.18   Mean   :32.78  
##  3rd Qu.:0.0000   3rd Qu.:0.00000   3rd Qu.:37.00   3rd Qu.:38.00  
##  Max.   :1.0000   Max.   :1.00000   Max.   :66.00   Max.   :66.00  
##   ServeType              AdT             AdBody          AdWide      
##  Length:126455      Min.   :0.0000   Min.   :0.000   Min.   :0.0000  
##  Class :character   1st Qu.:0.0000   1st Qu.:0.000   1st Qu.:0.0000  
##  Mode  :character   Median :0.0000   Median :0.000   Median :0.0000  
##                     Mean   :0.1102   Mean   :0.138   Mean   :0.1747  
##                     3rd Qu.:0.0000   3rd Qu.:0.000   3rd Qu.:0.0000  
##                     Max.   :1.0000   Max.   :1.000   Max.   :1.0000  
##      DeuceT         DeuceBody         DeuceWide        server_id     
##  Min.   :0.0000   Min.   :0.00000   Min.   :0.0000   Min.   :  1.00  
##  1st Qu.:0.0000   1st Qu.:0.00000   1st Qu.:0.0000   1st Qu.: 50.00  
##  Median :0.0000   Median :0.00000   Median :0.0000   Median : 98.00  
##  Mean   :0.3154   Mean   :0.09277   Mean   :0.1689   Mean   : 99.94  
##  3rd Qu.:1.0000   3rd Qu.:0.00000   3rd Qu.:0.0000   3rd Qu.:151.00  
##  Max.   :1.0000   Max.   :1.00000   Max.   :1.0000   Max.   :205.00  
##    return_id    
##  Min.   : 1.00  
##  1st Qu.:21.00  
##  Median :39.00  
##  Mean   :41.05  
##  3rd Qu.:63.00  
##  Max.   :84.00
```

\begin{figure}
\includegraphics[width=1\linewidth]{Report_files/figure-latex/tidymiss-1} \caption{Check missing value}(\#fig:tidymiss)
\end{figure}

# How variables influence player’s return impact

## Model selection

Started from the basic models to find out the relationship of the return impact. 
* Logistic Regression

* Decision Tree

* Random Forests

* Gradient Boosting


* Gaussian Mixture Model






## Cluster Selection
The number of cluster components chose for the analysis was using the `Mclust` package that calculate their BIC and Figure \@ref(fig:seronems) show the trend of the BIC. 



Compare to two serve of the difference number of cluster components' BIC, the number of 9 cluster perform well in the model. Thus, it will use 9 cluster for the rest analysis. In the shiny dashboard, there is a panel can run the function below to check the change of difference components cluster by selecting serve number, serve type, player, surface type.

```
## ****************************************
## *** INPUT:
## ****************************************
## * nbCluster =  9 
## * criterion =  BIC 
## ****************************************
## *** MIXMOD Models:
## * list =  Gaussian_pk_Lk_C 
## * This list includes only models with free proportions.
## ****************************************
## * data (limited to a 10x10 matrix) =
##       X      Y     
##  [1,] -13.19 6.68  
##  [2,] -13.03 5.731 
##  [3,] -13.44 5.519 
##  [4,] -13.39 6.84  
##  [5,] -14.9  1.174 
##  [6,] -13.55 -5.544
##  [7,] -13.29 6.597 
##  [8,] -13.24 -5.542
##  [9,] -14.19 -3.489
## [10,] -13.75 1.574 
## * ... ...
## ****************************************
## *** MIXMOD Strategy:
## * algorithm            =  EM 
## * number of tries      =  1 
## * number of iterations =  200 
## * epsilon              =  0.001 
## *** Initialization strategy:
## * algorithm            =  smallEM 
## * number of tries      =  10 
## * number of iterations =  5 
## * epsilon              =  0.001 
## * seed                 =  NULL 
## ****************************************
## 
## 
## ****************************************
## *** BEST MODEL OUTPUT:
## *** According to the BIC criterion
## ****************************************
## * nbCluster   =  9 
## * model name  =  Gaussian_pk_Lk_C 
## * criterion   =  BIC(594512.8263)
## * likelihood  =  -297048.7750 
## ****************************************
## *** Cluster 1 
## * proportion =  0.1923 
## * means      =  -13.3713 1.5946 
## * variances  = |     0.4684    -0.0251 |
##                |    -0.0251     0.3017 |
## *** Cluster 2 
## * proportion =  0.1946 
## * means      =  -12.7992 -5.2246 
## * variances  = |     0.7069    -0.0379 |
##                |    -0.0379     0.4553 |
## *** Cluster 3 
## * proportion =  0.0334 
## * means      =  -15.0166 6.6092 
## * variances  = |     1.1315    -0.0606 |
##                |    -0.0606     0.7287 |
## *** Cluster 4 
## * proportion =  0.1081 
## * means      =  -14.7894 0.0460 
## * variances  = |     4.2262    -0.2263 |
##                |    -0.2263     2.7219 |
## *** Cluster 5 
## * proportion =  0.0437 
## * means      =  -13.0272 3.5503 
## * variances  = |     0.7429    -0.0398 |
##                |    -0.0398     0.4784 |
## *** Cluster 6 
## * proportion =  0.0471 
## * means      =  -14.9055 -6.0844 
## * variances  = |     1.4518    -0.0777 |
##                |    -0.0777     0.9350 |
## *** Cluster 7 
## * proportion =  0.1483 
## * means      =  -13.4998 -1.1433 
## * variances  = |     0.4578    -0.0245 |
##                |    -0.0245     0.2948 |
## *** Cluster 8 
## * proportion =  0.2010 
## * means      =  -12.4469 5.7603 
## * variances  = |     0.4643    -0.0249 |
##                |    -0.0249     0.2991 |
## *** Cluster 9 
## * proportion =  0.0315 
## * means      =  -13.1488 -3.0511 
## * variances  = |     0.7965    -0.0427 |
##                |    -0.0427     0.5130 |
## ****************************************
```

```
## [1] 1
```

```
## [1] 2
```

![](Report_files/figure-latex/unnamed-chunk-3-1.pdf)<!-- --> 

Under the result used the GMM model, there is a further discussion of the return impact base on the player, the match intensity increase and the rest of the variables.

## The strategy of top 3 players' return impact positions
Are the top players have large difference of the return impact positions? Or similar.

## Any ajust strategy in the Promotion event especially the final round?
Will player stand near or far away from the court during the semi-final ground? Or final ground? 

## How are surface type influence players'performance?
As grass and clay surface type have some slightly difference and will they influence the return impact positions?

## ATP Lefties In The Top 100 Rankings' return impact
Are the player will have similar return impact positions because they are left hand users?

## (will they change stategy when were facing familar player) 
Compare head-to-head history result, find out the player have larger win proportion and compare their each game return impact positions.

# Dashboard User Guide

Figure\@ref(fig:dashboard)

\begin{figure}
\includegraphics[width=1\linewidth]{image/dashboard} \caption{Shiny Dashboard}(\#fig:dashboard)
\end{figure}

# Conclusion

# Reference
