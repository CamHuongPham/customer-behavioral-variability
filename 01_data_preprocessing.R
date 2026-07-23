library(readxl)
library(dplyr)


retail <- bind_rows(
  read_excel("D:/online+retail+ii/online_retail_II.xlsx", sheet = "Year 2009-2010"),
  read_excel("D:/online+retail+ii/online_retail_II.xlsx", sheet = "Year 2010-2011")
)

data_clean <- retail %>%
  filter(
    !is.na(`Customer ID`),
    Quantity > 0
  )
