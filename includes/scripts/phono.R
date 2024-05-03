

library(tidyverse)
library(patchwork)

data <- read_csv("C:\Users\locom\Desktop\Kendra Project\data\trill_data.csv") %>%
  na.omit

iddata <- data %>%
group_by(ID) %>%
summarize(meandur = mean(Duration),sddur = sd(Duration),meannum = mean(Occlusions),sdnum = sd(Occlusions))

worddata <- data %>%
group_by(Word) %>%
summarize(meandur = mean(Duration),sddur = sd(Duration),meannum = mean(Occlusions),sdnum = sd(Occlusions))


plot1 <- data %>%
  ggplot() +
  aes(x = ID, y = Occlusions) +
  geom_boxplot(fill = "plum") +
  labs( 
         subtitle="Occlusions by Participant ID",
         x="ID",
         y="Number of Occlusions")

plot2 <- data %>%
  ggplot() +
  aes(x = ID, y = Duration) +
  geom_boxplot(fill = "sienna") +
  labs( 
         subtitle="Duration by Participant ID",
         x="ID",
         y="Duration")

plot3 <- iddata %>%
  ggplot() +
  aes(x= ID, y = meannum) +
  geom_point() +
  labs( 
         subtitle="Average Occlusions by Participant ID",
         x="ID",
         y="Average Number of Occlusions")

plot4 <- iddata %>%
  ggplot() +
  aes(x= ID, y = meandur) +
  geom_point() +
  labs( 
         subtitle="Average Duration by Participant ID",
         x="ID",
         y="Average Duration")


