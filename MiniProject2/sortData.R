# sortData for MiniProject3
tuesdata <- tidytuesdayR::tt_load('2023-10-10')
data <- tuesdata$haunted_places
#library(dplyr)
#data <- read.csv("data/haunted_places_data.csv")

# Create empty vectors to store selected entries
tragic_events <- c()
paranormal <- c()
unexplainable_events <- c()

# Loop through the "description" column and filter entries
for (i in 1:nrow(data)) {
  description <- tolower(data$description[i])  # Convert to lowercase for case-insensitivity
  if (grepl("commited suicide|death|died|drowned|killed|murdered|murder", description)) {
    tragic_events <- c(tragic_events, data[i, 1])
  } 
  if (grepl("haunted|ghost|apparition|apparitions|ghostly|supernatural|paranormal|spirit", description)) {
    paranormal <- c(paranormal, data[i, 1])
  } 
  else {
    unexplainable_events <- c(unexplainable_events, data[i, 1])
  }
}

# Load required libraries
library(dplyr)
library(ggplot2)

# Create a data frame with the count of events by state
events_by_state <- data %>%
  mutate(event_type = case_when(
    grepl("commited suicide|death|died|drowned|killed|murdered|murder", tolower(description)) ~ "Tragic Events",
    grepl("haunted|ghost|apparition|apparitions|ghostly|supernatural|paranormal|spirit", description) ~ "Paranormal Events",
    TRUE ~ "Unexplainable Events"
  )) %>%
  group_by(state_abbrev, event_type) %>%
  summarize(count = n())

# Create a line graph that separates each event type
eventsByState <- ggplot(events_by_state, aes(x = state_abbrev, y = count, color = event_type, group = event_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Comparison of Events by State",
       x = "State",
       y = "Count of Events",
       color = "Event Type") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90)) +
  scale_color_manual(values = c("Tragic Events" = "skyblue", "Paranormal Events" = "red", "Unexplainable Events" = "green"))

ggsave(filename="images/US-events-by-states.png", 
       plot = eventsByState, 
       width = 50, height = 15, 
       dpi = 300,
       units = "cm")

# Create a data frame with the count of tragic events by state
tragic_events_by_state <- data %>%
  filter(grepl("commited suicide|death|died|drowned|killed|murdered|murder", tolower(description))) %>%
  group_by(state_abbrev) %>%
  summarize(count = n())

# Create a bar chart
tragicEventsByState <- ggplot(tragic_events_by_state, aes(x = state_abbrev, y = count, fill = state_abbrev)) +
  geom_bar(stat = "identity", width = 0.7) +
  geom_text(aes(label = count), vjust = -0.5, size = 3) +
  geom_hline(yintercept = 0, color = "black", size = 0.5) +
  geom_vline(xintercept = 0, color = "black", size = 0.5) +
  labs(title = "Number of Tragic Events by State",
       x = "State",
       y = "Count of Tragic Events") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, size = 7),
        axis.text.y = element_text(size = 7))

ggsave(filename="images/US-tragic-events-by-states.png", 
       plot = tragicEventsByState, 
       width = 50, height = 15, 
       dpi = 300,
       units = "cm")

# Create a data frame with the count of tragic events by state
paranormal_events_by_state <- data %>%
  filter(grepl("haunted|ghost|apparition|apparitions|ghostly|supernatural|paranormal|spirit", tolower(description))) %>%
  group_by(state_abbrev) %>%
  summarize(count = n())

# Create a bar chart
paranormalEventsByState <- ggplot(paranormal_events_by_state, aes(x = state_abbrev, y = count, fill = state_abbrev)) +
  geom_bar(stat = "identity", width = 0.7) +
  geom_text(aes(label = count), vjust = -0.5, size = 3) +
  geom_hline(yintercept = 0, color = "black", size = 0.5) +
  geom_vline(xintercept = 0, color = "black", size = 0.5) +
  labs(title = "Number of Paranormal Events by State",
       x = "State",
       y = "Count of Paranormal Events") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, size = 7),
        axis.text.y = element_text(size = 7))

ggsave(filename="images/US-paranormal-events-by-states.png", 
       plot = paranormalEventsByState, 
       width = 50, height = 15, 
       dpi = 300,
       units = "cm")

# Create a data frame with the count of unexplainable events by state
unexplainable_events_by_state <- data %>%
  filter(!grepl("commited suicide|death|died|drowned|killed|murdered|murder|haunted|ghost|apparition|apparitions|ghostly|supernatural|paranormal|spirit", tolower(description))) %>%
  group_by(state_abbrev) %>%
  summarize(count = n())

# Create a bar chart for unexplainable events
unexplainableEventsByState <- ggplot(unexplainable_events_by_state, aes(x = state_abbrev, y = count, fill = state_abbrev)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = count), vjust = -0.5, size = 3) +
  geom_hline(yintercept = 0, color = "black", size = 0.5) +
  geom_vline(xintercept = 0, color = "black", size = 0.5) +
  labs(title = "Number of Unexplainable Events by State",
       x = "State",
       y = "Count of Unexplainable Events") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, size = 7),
        axis.text.y = element_text(size = 7))

ggsave(filename="images/US-unexplainable-events-by-states.png", 
       plot = unexplainableEventsByState, 
       width = 50, height = 15, 
       dpi = 300,
       units = "cm")

# Create a data frame with the total count of events by event type
total_events <- events_by_state %>%
  group_by(event_type) %>%
  summarize(total_count = sum(count))

# Create a bar graph to show the total count of events
totalCountofEvents <- ggplot(total_events, aes(x = event_type, y = total_count, fill = event_type)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = total_count), vjust = -0.5, size = 3) +
  labs(title = "Total Count of Events by Event Type",
       x = "Event Type",
       y = "Total Count",
       fill = "Event Type") +
  theme_minimal() +
  scale_fill_manual(values = c("Tragic Events" = "skyblue", "Paranormal Events" = "orange", "Unexplainable Events" = "green"))

ggsave(filename="images/US-total-count-of-events.png", 
       plot = totalCountofEvents, 
       width = 50, height = 15, 
       dpi = 300,
       units = "cm")

# Create a data frame with the count of haunted locations by state
haunted_locations_by_state <- data %>%
  group_by(state_abbrev) %>%
  summarize(count = n())

# Create a bar chart
hauntedLocationsByState <- ggplot(haunted_locations_by_state, aes(x = state_abbrev, y = count, fill = state_abbrev)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = count), vjust = -0.5, size = 3) +  # Add labels on top of the bars
  labs(title = "Number of Haunted Locations by State",
       x = "State",
       y = "Count of Haunted Locations") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 90, size = 7),
        axis.text.y = element_text(size = 7))

ggsave(filename="images/US-haunted-locations-by-state.png", 
       plot = hauntedLocationsByState, 
       width = 50, height = 15, 
       dpi = 300,
       units = "cm")