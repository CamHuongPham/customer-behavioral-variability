library(readxl)
library(dplyr)
library(here)

retail <- bind_rows(
  read_excel(
    here("data", "online_retail_II.xlsx"),
    sheet = "Year 2009-2010"
  ),
  read_excel(
    here("data", "online_retail_II.xlsx"),
    sheet = "Year 2010-2011"
  )
)

data_clean <- retail %>%
  filter(
    !is.na(`Customer ID`),
    Quantity > 0
  )

