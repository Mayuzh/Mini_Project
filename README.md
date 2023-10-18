# Haunted Places Dataset

This dataset contains a comprehensive list of haunted locations throughout the United States. It is a compilation of 10,992 observations on various haunted places in the United States, each described by multiple variables. The data was originally compiled by Tim Renner using The Shadowlands Haunted Places Index, which allows users to submit haunted places not currently on record. The dataset provides valuable insights into the locations, descriptions, and other attributes associated with these haunted places.

## Dimensions
- Observations: 10,992
- Variables: 10

## Data Dictionary
1. `city`: The city where the haunted place is located.
2. `country`: The country in which the haunted place is situated.
3. `description`: A brief description of the haunted place.
4. `location`: Specific location details of the haunted place.
5. `state`: The state in which the haunted place is found.
6. `state abbreviation`: The abbreviation of the state where the haunted place is situated.
7. `longitude`: The longitude coordinate of the haunted place.
8. `latitude`: The latitude coordinate of the haunted place.
9. `city longitude`: The longitude coordinate of the city where the haunted place is located.
10. `city latitude`: The latitude coordinate of the city where the haunted place is situated.

For more detailed information about the dataset, please refer to the [original data dictionary](https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-10-10/readme.md).

## Summary
A summary of the dataset is as follows:

```{r}
library(tidyverse)

# Reading the data
data <- read.csv("data/haunted_places.csv")

# Printing the summary of the data frame
glimpse(data)
