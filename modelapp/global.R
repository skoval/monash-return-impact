library(ggplot2)
library(tidyverse)
library(shiny)
library(dplyr)
library(plotly)
library(Rmixmod)
library(shinydashboard)



position <- readRDS("data/position.rds") 
positions <- position %>% 
  mutate(hard = case_when(surface == "Hard" ~ "1",
                          surface == "Hard" ~ "0")) %>%
  pivot_longer(AdT:DeuceWide,
               names_to = "Servetype", 
               values_to = "values") %>%
  filter(values == 1) 
# Define dimensions of tennis court on negative X (receiver) side only
courtTrace <- data.frame(x = c(-11.89, -11.89, -5.4, -5.4, -11.89, -11.89, -5.4, -5.4, -11.89, -6.4, -6.4, -5.4, -5.4, -5.4, -6.4),
                         y = c(5.49, -5.49, -5.49, 5.49, 5.49, 4.115, 4.115, -4.115, -4.115, -4.115, 4.115, 4.115, -4.115, 0, 0))