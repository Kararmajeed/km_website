library(tidyverse)
library(RColorBrewer)


oil = read.csv("Oil_Production_Country_2022.csv")
region = read.csv("Oil_by_Region_2022.csv")

str(region)

region$X2022.Production <- as.numeric(region$X2022.Production)

region <- region %>% mutate(Region = fct_reorder(Region, X2022.Production, .desc = TRUE))

ggplot(region, aes(y=X2022.Production, x=Region, fill=Region))+
  geom_col()+ 
  scale_fill_brewer(palette = "Set2") +
  theme(legend.position = "bottom") +
  labs(title = "Oil by Region",
     x = "Region",
     y = "Production in Thousands")  +
    theme_classic() +
    geom_text(aes(label = X2022.Production), vjust = -0.3, size = 3.5, color = "black") 
  
str(oil)


oil$Country = as.factor(oil$Country)
oil <- oil %>% mutate(Country = fct_reorder(Country, X2022.Production, .desc = FALSE))

  ggplot(oil, aes(x=X2022.Production, y=Country))+
  geom_col(color='grey') +
  theme_classic() +
  labs(title = "Oil by Country",
         x = "Oil",
         y = "Production in Thousands") 
    # geom_label(
    # label=rownames(oil), 
    #  nudge_x = 0.25, nudge_y = 0.25, 
    #  check_overlap = T)
  
  oil = oil %>% mutate(perc_color = case_when(
    YoY.Change >0 ~ "above",
    YoY.Change <= 0 ~ "below"))
  ggplot(oil, aes(x = YoY.Change, y = Country, colour=perc_color)) +
    geom_point() +
    scale_color_manual(values = c("above" = "blue", "below" = "red")) +
    theme_minimal() +
    labs(title = "YoY Change by Country in 2022",
         x = "YoY Change",
         y = "Country") 
  

