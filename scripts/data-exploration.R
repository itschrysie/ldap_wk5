---
title: "ldap_wk5.Rmd"
author: "Her Royal Eminence of the Lab Rats"
output:
  bookdown::html_document2: default
---

The following exercises are a test in disguise. What do you think about the coding? Can you think of any improvements to the following?

```{r, cleaning}
rm(list=ls()) # always clean up your environment! 

```

```{r loading packages}
# install.packages("tidyverse") #uncomment to install tidyverse if you haven't already

library(tidyverse)

```

## PROBLEM 1

Visualizing your data is important! Summary statistics can be highly misleading, and simply plotting the data can reveal a lot more! Lets look at the Anscombe's Quartet data ([Anscombe, 1973](doi:10.1080/00031305.1973.10478966)). There are four different data sets.

```{r ascombe data}
anscombe_quartet = readRDS("anscombe_quartet.rds")

# let's explore the dataset 
str(anscombe_quartet)

# what does the function str() do? 
# displays the structure of an R object

# let's check some summary statistics:

anscombe_quartet %>% 
  group_by(dataset) %>% 
  summarise(
    mean_x    = mean(x),
    mean_y    = mean(y),
    min_x     = min(x),
    min_y     = min(y),
    max_x     = max(x),
    max_y     = max(y),
    crrltn    = cor(x, y)
  )

# what do the summary statistics tell us about the different datasets? 
{#   dataset   mean_x mean_y min_x min_y max_x max_y crrltn
# 1 dataset_1      9   7.50     4  4.26    14 10.8   0.816
# 2 dataset_2      9   7.50     4  3.1     14  9.26  0.816
# 3 dataset_3      9   7.5      4  5.39    14 12.7   0.816
# 4 dataset_4      9   7.50     8  5.25    19 12.5   0.817
}
# all the datasets have the same mean x and y and then vary with their min and max but there correlations are also very similar

# let's plot the data with ggplot:

require(ggplot2)

 ggplot(anscombe_quartet, aes(x=x,y=y)) +
  geom_point() + 
  geom_smooth(method = "lm",formula = "y ~ x") +
  facet_wrap(~dataset)

#save the plot

ggsave("anscombe_quartet.png", width = 20, height = 20, units = "cm")

```

What do the plots tell us about the different datasets? - The plots tell us there is a positive relationship between x and y in all four datasets but the specifics of that positive relationship vary - Also dataset four seems to have an outlier

Describe the relationship between x and y in the different datasets. - see above

Would linear regression be an appropriate statistical model to analyse the x-y relationship in each dataset? - not for all of them i.e. something funky's going on with dataset 4

What conclusions can you draw for the plots and summary statistics? - x and y generally tend to have a positive relationship where as x increases so does y but this isn't consistent across all data sets i.e., dataset 3

## PROBLEM 2

```{r datasurus_dozen, fig.width=4, fig.height=4}
# load in the datasaurus dataset
datasaurus_dozen = readRDS("datasaurus_dozen.rds")

# explore the dataset 
str(datasaurus_dozen)
# how many rows and columns does the datasaurus_dozen file have? 
  # 1864 rows
  # 3 columns

# plot the dataset 
ggplot(datasaurus_dozen, aes(x=x,y=y)) +
  geom_point() + 
  geom_smooth(method = "lm",formula = "y ~ x") +
  facet_wrap(~dataset)

# calculate the correlations and summary statistics for x and y in all datasets: 
datasaurus_dozen %>% 
  group_by(dataset) %>% 
  summarise(
    mean_x    = mean(x),
    mean_y    = mean(y),
    min_x     = min(x),
    min_y     = min(y),
    max_x     = max(x),
    max_y     = max(y),
    crrltn    = cor(x, y)
  )

{#    dataset    mean_x mean_y min_x   min_y max_x max_y  crrltn
# 1  away         54.3   47.8  15.6  0.0151  91.6  97.5 -0.0641
# 2  bullseye     54.3   47.8  19.3  9.69    91.7  85.9 -0.0686
# 3  circle       54.3   47.8  21.9  16.3    85.7  85.6 -0.0683
# 4  dino         54.3   47.8  22.3  2.95    98.2  99.5 -0.0645
# 5  dots         54.3   47.8  25.4  15.8    78.0  94.2 -0.0603
# 6  h_lines      54.3   47.8  22.0  10.5    98.3  90.5 -0.0617
# 7  high_lines   54.3   47.8  17.9  14.9    96.1  87.2 -0.0685
# 8  slant_down   54.3   47.8  18.1  0.304   95.6  99.6 -0.0690
# 9  slant_up     54.3   47.8  20.2  5.65    95.3  99.6 -0.0686
# 10 star         54.3   47.8  27.0  14.4    86.4  92.2 -0.0630
# 11 v_lines      54.3   47.8  30.4  2.73    89.5  99.7 -0.0694
# 12 wide_lines   54.3   47.8  27.4  0.217   77.9  99.3 -0.0666
# 13 x_shape      54.3   47.8  31.1  4.58    85.4  97.8 -0.0656
  }

# Plot the relationships between x and y in each dataset including the line of best fit.
  # see above

# save the plot 
ggsave("datasuraus_dozen.png", width = 20, height = 20, units = "cm")

```

What conclusions can you draw for the plots and summary statistics?

-   andrea is going to be a great data with all these lil easter egg jokes.

### References

Anscombe, F. J. (1973). "Graphs in Statistical Analysis". *American Statistician*, 27(1), 17--21. <doi:10.1080/00031305.1973.10478966>. JSTOR 2682899.
