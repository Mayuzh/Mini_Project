tuesdata <- tidytuesdayR::tt_load('2023-10-10')
haunted_places <- tuesdata$haunted_places

print(haunted_places)

write.csv(x = haunted_places, file="haunted_places_data.csv")

glimpse(haunted_places)
