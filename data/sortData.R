library(dplyr)
data <- read.csv("Mini_Project/data/haunted_places_data.csv")

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

# Print the values of column 1 for selected entries
print("Tragic Events:")
print(tragic_events)
print("Paranormal Events:")
print(paranormal)
print("Unexplainable Events:")
print(unexplainable_events)


# Load required libraries
library(dplyr)
library(ggplot2)

# Read the CSV file
data <- read.csv("Mini_Project/data/haunted_places_data.csv")

# Create a data frame with the count of events by state
events_by_state <- data %>%
  mutate(event_type = case_when(
    grepl("commited suicide|death|died|drowned|killed|murdered|murder", tolower(description)) ~ "Tragic Events",
    grepl("haunted|ghost|apparition|apparitions|ghostly|supernatural|paranormal|spirit", description) ~ "Paranormal Events",
    TRUE ~ "Unexplainable Events"
  )) %>%
  group_by(state, event_type) %>%
  summarize(count = n())

# Create a line graph that separates each event type
ggplot(events_by_state, aes(x = state, y = count, color = event_type, group = event_type)) +
  geom_line() +
  geom_point() +
  labs(title = "Comparison of Events by State",
       x = "State",
       y = "Count of Events",
       color = "Event Type") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90)) +
  scale_color_manual(values = c("Tragic Events" = "skyblue", "Paranormal Events" = "orange", "Unexplainable Events" = "green"))

# # Create a comparison bar chart
# ggplot(events_by_state, aes(x = state, y = count, fill = event_type)) +
#   geom_bar(stat = "identity", position = "dodge") +
#   geom_text(aes(label = count), position = position_dodge(width = 0.9), vjust = -0.5, size = 3) +
#   labs(title = "Comparison of Events by State",
#        x = "State",
#        y = "Count of Events",
#        fill = "Event Type") +
#   theme_minimal() +
#   theme(axis.text.x = element_text(angle = 90)) +
#   scale_fill_manual(values = c("Tragic Events" = "skyblue", "Paranormal Events" = "orange", "Unexplainable Events" = "green"))

# # Create a data frame with the count of tragic events by state
# tragic_events_by_state <- data %>%
#   filter(grepl("commited suicide|death|died|drowned|killed|murdered|murder", tolower(description))) %>%
#   group_by(state) %>%
#   summarize(count = n())
# 
# # Create a bar chart
# ggplot(tragic_events_by_state, aes(x = state, y = count, fill = state)) +
#   geom_bar(stat = "identity") +
#   geom_text(aes(label = count), vjust = -0.5, size = 3) +
#   geom_hline(yintercept = 0, color = "black", size = 0.5) + 
#   geom_vline(xintercept = 0, color = "black", size = 0.5) +
#   labs(title = "Number of Tragic Events by State",
#        x = "State",
#        y = "Count of Tragic Events") +
#   theme_minimal() +
#   theme(axis.text.x = element_text(angle = 90))
# 








