#library(shiny)
library(dplyr)
library(ggplot2)
#library(tidyr)
library(lubridate)

ms19=read.csv("massshootings19.csv", stringsAsFactors = FALSE)
ms18 <- read.csv("mshoot18.csv", stringsAsFactors = FALSE)
ms17 <- read.csv("mshoot17.csv", stringsAsFactors = FALSE)
ms16 <- read.csv("mshoot16.csv", stringsAsFactors = FALSE)
ms15 <- read.csv("mshoot15.csv", stringsAsFactors = FALSE)
ms14 <- read.csv("mshoot14.csv", stringsAsFactors = FALSE)
ms15 [, c("Incident.ID")] <- NULL
ms14[, c("Incident.ID")] <- NULL
total <- rbind(ms14, ms15)
total<- rbind(total, ms16)
total <- rbind(total, ms17)
total <-rbind(total, ms18)
total <- rbind(total, ms19)
total$Incident.Date <- parse_date_time(total$Incident.Date, orders = "BdY")
maybe <- total %>%
  mutate(., "Year" = format(as.Date(Incident.Date, "%Y-%m-%d"), "%Y"))
maybe[, c("Operations")] <- NULL