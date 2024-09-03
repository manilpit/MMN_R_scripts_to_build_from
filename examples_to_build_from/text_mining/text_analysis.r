# Load necessary libraries
install.packages(c("tm", "syuzhet", "tidytext", "dplyr"))
library(tm)         # For text mining and preprocessing
library(syuzhet)    # For sentiment analysis
library(tidytext)   # For text data manipulation
library(dplyr)      # For data manipulation

# Set working directory (adjust the path as needed)
setwd("your/working/directory/path")

### 1. Sample Text Data

# Create a sample text data vector
text_data <- c(
  "I love this product! It's amazing and works perfectly.",
  "This is the worst experience I've ever had. Completely disappointed!",
  "The service was okay, not great but not terrible either.",
  "Fantastic quality and superb support. Highly recommend!",
  "I don't like the taste of this item. It's too bitter for me."
)

# Print the original text data
print("Original Text Data:")
print(text_data)

### 2. Text Preprocessing for Term-Document Matrix

# Create a text corpus using `tm::Corpus`
corpus <- Corpus(VectorSource(text_data))

# Text preprocessing: Convert to lowercase, remove punctuation, remove numbers, and remove stop words
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeWords, stopwords("en"))
corpus <- tm_map(corpus, stripWhitespace)

### 3. Term-Document Matrix Creation

# Create a Term-Document Matrix (TDM) using `tm::TermDocumentMatrix`
tdm <- TermDocumentMatrix(corpus)

# Print the Term-Document Matrix
print("Term-Document Matrix:")
print(inspect(tdm))

### 4. Sentiment Analysis using `syuzhet`

# Perform sentiment analysis using `syuzhet::get_sentiment()`
sentiments <- get_sentiment(text_data, method = "syuzhet")  # Using the "syuzhet" method

# Print sentiment scores
print("Sentiment Scores using syuzhet:")
print(sentiments)

# Add sentiment scores to the original text data
sentiment_data <- data.frame(Text = text_data, Sentiment_Score = sentiments)

# Print the sentiment analysis results
print("Sentiment Analysis Results:")
print(sentiment_data)

### 5. Sentiment Analysis using `tidytext`

# Tokenize text data into words
tidy_text <- data.frame(line = 1:length(text_data), text = text_data) %>%
  unnest_tokens(word, text)

# Load the Bing lexicon for sentiment analysis
bing <- get_sentiments("bing")

# Perform sentiment analysis using `tidytext`
tidy_sentiment <- tidy_text %>%
  inner_join(bing, by = "word") %>%
  count(line, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment_score = positive - negative)

# Print the sentiment analysis using tidytext
print("Sentiment Analysis using tidytext:")
print(tidy_sentiment)

### Conclusion
print("Text analysis with Term-Document Matrix creation and sentiment analysis complete.")
