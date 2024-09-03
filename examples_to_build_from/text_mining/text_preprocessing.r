# Load necessary libraries
install.packages(c("tm", "SnowballC"))
library(tm)         # For text mining and preprocessing
library(SnowballC)  # For stemming

# Set working directory (adjust the path as needed)
setwd("your/working/directory/path")

### 1. Sample Text Data

# Create a sample text data vector
text_data <- c(
  "This is the first document. It contains some text data!",
  "Here is the second document with more text data.",
  "The third document is here, and it also contains text data.",
  "This is the fourth document, which is quite different from the rest.",
  "Finally, the fifth document contains text data, but it's the last one."
)

# Print the original text data
print("Original Text Data:")
print(text_data)

### 2. Text Preprocessing

# Create a text corpus using `tm::Corpus`
corpus <- Corpus(VectorSource(text_data))

# Print the content of the corpus
print("Text Corpus:")
print(corpus)

# a) Convert text to lowercase
corpus <- tm_map(corpus, content_transformer(tolower))

# b) Remove punctuation
corpus <- tm_map(corpus, removePunctuation)

# c) Remove numbers
corpus <- tm_map(corpus, removeNumbers)

# d) Remove stop words (common words like "the", "is", etc.)
corpus <- tm_map(corpus, removeWords, stopwords("en"))

# e) Perform stemming (reduce words to their root form)
corpus <- tm_map(corpus, stemDocument)

# f) Strip whitespace
corpus <- tm_map(corpus, stripWhitespace)

# Print the processed text data
print("Processed Text Data:")
for (i in 1:length(corpus)) {
  print(corpus[[i]]$content)
}

### 3. Tokenization and Term-Document Matrix

# Tokenization is implicitly handled when creating a Document-Term Matrix (DTM)
dtm <- DocumentTermMatrix(corpus)

# Print the Document-Term Matrix
print("Document-Term Matrix:")
print(inspect(dtm))

### Conclusion
print("Text preprocessing, tokenization, stemming, and stop word removal complete.")
