
library(tidyverse)
library(janitor)
library(MCOE)
library(here)
library(ggthemes)


con <- mcoe_sql_con()





TAMO <- tbl(con, "TEACHING") %>% 
    filter(County_Name == "Monterey",
           Aggregate_Level == "C" | Aggregate_Level == "D" ,
           Charter_School == "No",
           DASS == "All",
           Teacher_Experience_Level == "All",
           Teacher_Credential_Level == "All",
    #       School_Grade_Span == "All"
           #        DistrictCode == "10272",
   #        YEAR  == max(YEAR)
    ) %>%
           head(20000) %>%
    collect() 



# By Subject

TAMO %>%
    filter(
        Aggregate_Level == "C",
        School_Grade_Span == "ALL",
        Academic_Year == "2021-22"
        ) %>%
    left_join_codebook(tablename = "TEACHING",
                       field = "Subject_Area") %>%
    lollipop(Clear_FTE_percent,
             definition,
             "steel blue") +
    labs(x = "",
         y = "",
         color ="",
         title = ("Teaching Assignments Clear by Subject"),
         caption = "") 
    

# By District

TAMO %>%
    filter(
        Aggregate_Level == "D",
        School_Grade_Span == "ALL",
        Subject_Area == "TA",
        Academic_Year == "2021-22"
    ) %>%
    lollipop(Clear_FTE_percent,
             District_Name,
             "steel blue") +
    labs(x = "",
         y = "",
         color ="",
         title = ("Teaching Assignments Clear by District"),
         caption = "") 

# By Gradespan

TAMO %>%
    filter(
        Aggregate_Level == "C",
      #  School_Grade_Span == "ALL",
        Subject_Area == "TA",
        Academic_Year == "2021-22"
    ) %>%
    lollipop(Clear_FTE_percent,
             School_Grade_Span,
             "steel blue") +
    labs(x = "",
         y = "",
         color ="",
         title = ("Teaching Assignments Clear by District"),
         caption = "") 
