set.seed(1111)
setwd("C:/Users/aidan/Desktop/Kaggle/pizza")
library(jsonlite)
library(caret)
library(tm)
testing <- fromJSON("test.json")
training <-fromJSON("train.json")
training <- training[,c("requester_received_pizza",                                                          
                         "request_text_edit_aware",                           
                         "request_title",                                     
                         "requester_account_age_in_days_at_request",          
                         "requester_days_since_first_post_on_raop_at_request",
                         "requester_number_of_comments_at_request",           
                         "requester_number_of_comments_in_raop_at_request",   
                         "requester_number_of_posts_at_request",              
                         "requester_number_of_posts_on_raop_at_request",      
                         "requester_number_of_subreddits_at_request",         
                         "requester_subreddits_at_request",                   
                         "requester_upvotes_minus_downvotes_at_request",      
                         "requester_upvotes_plus_downvotes_at_request",       
                         "requester_username",                                
                         "unix_timestamp_of_request",                         
                         "unix_timestamp_of_request_utc")]
request_id <- testing$request_id
training$length <- apply(as.matrix(training$request_text_edit_aware), 2, function(x) nchar(x))
training$length <- as.numeric(training$length)


# training$money1 <- ifelse(grepl("week|ramen|paycheck|work|couple|rice|check|grocery|rent|anyone|favor|someone|bill", 
#           training$request_text_edit_aware)==TRUE, 1, 0)
# 
# training$money2 <- ifelse(grepl("food|house|stamp|month|today|parent|help", 
#                                 training$request_text_edit_aware)==TRUE, 1, 0)
# 
# training$job <- ifelse(grepl("year|interview|luck|unemployment|end", 
#                           training$request_text_edit_aware)==TRUE, 1, 0)
# 
# training$friend <- ifelse(grepl("house|night|mine|birthday|school|story|movie", 
#                           training$request_text_edit_aware)==TRUE, 1, 0)
# 
# training$student <- ifelse(grepl("college|final|loan|summer|semester|story", 
#                           training$request_text_edit_aware)==TRUE, 1, 0)
# 
# training$time <- ifelse(grepl("tonight|night|today|tomorrow|friday|dinner|account|family", 
#                           training$request_text_edit_aware)==TRUE, 1, 0)
# 
# training$gratitude <- ifelse(grepl("thanks|advance|reading|kind|favor", 
#                           training$request_text_edit_aware)==TRUE, 1, 0)


training <- training[,c("requester_received_pizza",                                                          
                        "length",                           
                        #"request_title",                                     
                        "requester_account_age_in_days_at_request",          
                        "requester_days_since_first_post_on_raop_at_request",
                        "requester_number_of_comments_at_request",           
                        "requester_number_of_comments_in_raop_at_request",   
                        "requester_number_of_posts_at_request",              
                        "requester_number_of_posts_on_raop_at_request",      
                        "requester_number_of_subreddits_at_request",         
                        #"requester_subreddits_at_request",                   
                        "requester_upvotes_minus_downvotes_at_request",      
                        "requester_upvotes_plus_downvotes_at_request",       
                        #"requester_username",                                
                        #"unix_timestamp_of_request",                         
                        "unix_timestamp_of_request_utc")]
#                         "money1",
#                         "money2",
#                         "job",
#                         "friend",
#                         "student",
#                         "time",
#                         "gratitude")]
training$requester_received_pizza <- factor(training$requester_received_pizza)





#Same processing for testing
testing <- testing[,c("request_text_edit_aware",                           
                        "request_title",                                     
                        "requester_account_age_in_days_at_request",          
                        "requester_days_since_first_post_on_raop_at_request",
                        "requester_number_of_comments_at_request",           
                        "requester_number_of_comments_in_raop_at_request",   
                        "requester_number_of_posts_at_request",              
                        "requester_number_of_posts_on_raop_at_request",      
                        "requester_number_of_subreddits_at_request",         
                        "requester_subreddits_at_request",                   
                        "requester_upvotes_minus_downvotes_at_request",      
                        "requester_upvotes_plus_downvotes_at_request",       
                        "requester_username",                                
                        "unix_timestamp_of_request",                         
                        "unix_timestamp_of_request_utc")]
testing$length <- apply(as.matrix(testing$request_text_edit_aware), 2, function(x) nchar(x))
testing$length <- as.numeric(testing$length)

# #testing$money1 <- ifelse(grepl("week|ramen|paycheck|work|couple|rice|check|grocery|rent|anyone|favor|someone|bill", 
#                                testing$request_text_edit_aware)==TRUE, 1, 0)
# 
# testing$money2 <- ifelse(grepl("food|house|stamp|month|today|parent|help", 
#                                testing$request_text_edit_aware)==TRUE, 1, 0)
# 
# testing$job <- ifelse(grepl("year|interview|luck|unemployment|end", 
#                             testing$request_text_edit_aware)==TRUE, 1, 0)
# 
# testing$friend <- ifelse(grepl("house|night|mine|birthday|school|story|movie", 
#                                testing$request_text_edit_aware)==TRUE, 1, 0)
# 
# testing$student <- ifelse(grepl("college|final|loan|summer|semester|story", 
#                                 testing$request_text_edit_aware)==TRUE, 1, 0)
# 
# testing$time <- ifelse(grepl("tonight|night|today|tomorrow|friday|dinner|account|family", 
#                              testing$request_text_edit_aware)==TRUE, 1, 0)
# 
# testing$gratitude <- ifelse(grepl("thanks|advance|reading|kind|favor", 
#                                   testing$request_text_edit_aware)==TRUE, 1, 0)

testing <- testing[,c("length",                           
                        #"request_title",                                     
                        "requester_account_age_in_days_at_request",          
                        "requester_days_since_first_post_on_raop_at_request",
                        "requester_number_of_comments_at_request",           
                        "requester_number_of_comments_in_raop_at_request",   
                        "requester_number_of_posts_at_request",              
                        "requester_number_of_posts_on_raop_at_request",      
                        "requester_number_of_subreddits_at_request",         
                        #"requester_subreddits_at_request",                   
                        "requester_upvotes_minus_downvotes_at_request",      
                        "requester_upvotes_plus_downvotes_at_request",       
                        #"requester_username",                                
                        #"unix_timestamp_of_request",                         
                        "unix_timestamp_of_request_utc")]
#                         "money1",
#                         "money2",
#                         "job",
#                         "friend",
#                         "student",
#                         "time",
#                         "gratitude")]


#lm1 <- lm(requester_received_pizza ~ requester_number_of_comments_at_request, 
#          data=training)

#plot(training$requester_number_of_comments_at_request, 
#     training$requester_received_pizza, pch=19, cex=0.5)

#points(training$requester_number_of_comments_at_request, 
#       predict(lm1, newdata=training), col="red", pch=19, cex=0.5)

#lm1probs <- predict(lm1, newdata=testing, type="prob")

#######
#library(aod)
#library(ggplot2)
#mylogit <- glm(requester_received_pizza ~ ., data = training, family = "binomial")
#summary(mylogit)
#logP <- predict(mylogit, newdata = testing)

#submit <- as.data.frame(cbind(testing$request_id, bayesP))
#names(submit) <- c("request_id", "requester_received_pizza")

#write.csv(submit, file="pizzaSub.csv", row.names=FALSE)

########
bayesglm <- train(requester_received_pizza ~ .,
                  data = training,
                  method = "bayesglm",
                  preProcess=c("center", "scale"))

bayesP <- predict(bayesglm, newdata = testing)
summary(bayesglm)

submit <- as.data.frame(cbind(request_id, bayesP))
names(submit) <- c("request_id", "requester_received_pizza")

write.csv(submit, file="pizzaSub.csv", row.names=FALSE)

########
boosted <- train(requester_received_pizza ~ .,
                  data = training,
                  method = "LogitBoost",
                  preProcess=c("center", "scale"))

boostedP <- predict(boosted, newdata = testing)
summary(boosted)

submitB <- as.data.frame(cbind(request_id, boostedP))
names(submitB) <- c("request_id", "requester_received_pizza")
write.csv(submitB, file="pizzaBoostedYeHawCowboy.csv", row.names=FALSE)

########
rf <- train(requester_received_pizza ~ .,
                 data = training,
                 method = "rf",
                 preProcess=c("center", "scale"),
                 allowParallel=TRUE)

rfP <- predict(rf, newdata = testing)
summary(rf)

submitRF <- as.data.frame(cbind(request_id, rfP))
names(submitRF) <- c("request_id", "requester_received_pizza")
write.csv(submitRF, file="pizzaRanFor.csv", row.names=FALSE)
