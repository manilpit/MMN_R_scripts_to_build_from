# Install and load the rvest package
install.packages("rvest")
library(rvest)  # For web scraping

#-----------------------------------------------------

# Set the working directory (adjust the path as needed)
setwd("your/working/directory/path")

# Specify the URL of the website to scrape
url <- "https://example.com"  # Replace with the actual URL you want to scrape

# Read the HTML content of the webpage
webpage <- read_html(url)

# Extract the nodes of interest using CSS selectors
# Example: Extracting article titles using CSS selectors
article_nodes <- html_nodes(webpage, ".article-title")  # Replace .article-title with the appropriate CSS selector

# Extract the text from the selected nodes
article_titles <- html_text(article_nodes)

# Print the extracted article titles
print("Extracted Article Titles:")
print(article_titles)

# Extract attributes (e.g., links)
# Example: Extracting article URLs
article_links <- html_attr(article_nodes, "href")

# Print the extracted article links
print("Extracted Article Links:")
print(article_links)


#-----------------------------------------------------

#V2 with real website:
# Install and load the rvest package
install.packages("rvest")
library(rvest)  # For web scraping

# Specify the URL of the website to scrape
url <- "https://example-news.com"  # Replace with the actual URL you want to scrape

# Read the HTML content of the webpage
webpage <- read_html(url)

# Extract the nodes of interest using CSS selectors
# Example: Extracting article titles using CSS selectors
article_nodes <- html_nodes(webpage, ".article-title")  # Replace .article-title with the appropriate CSS selector

# Extract the text from the selected nodes
article_titles <- html_text(article_nodes)

# Print the extracted article titles
print("Extracted Article Titles:")
print(article_titles)

# Extract attributes (e.g., links)
# Example: Extracting article URLs
article_links <- html_attr(article_nodes, "href")

# Print the extracted article links
print("Extracted Article Links:")
print(article_links)
