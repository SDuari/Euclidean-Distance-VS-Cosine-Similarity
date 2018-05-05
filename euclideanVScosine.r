########################################################################################
#                         ASSIGNMENT 3 - TEXT MINING COURSEWORK
# QUESTION:Show the difference between Cosine and Euclidean distance. Prove analytically
#          that these are closely related. Show empirically the relation between these 
#          two distance measures using a set of 20 documents.
#
# AUTHOR OF THE SCRIPT: SWAGATA DUARI
########################################################################################

library(tm) # for text mining related function, eg. Corpus()
library(proxy) # for dist() function [stats package also has dist() but no method for cosine similarity]
library(SnowballC) # for stemming
library(openNLP) # for POS tagging, some actions require NLP package
library(NLP) # for NLP related functions


# GOAL: Analytically show the differece between cosine and euclidean distance using a
#       set of 20 documents.


# Path to directory: "/Users/swagata/Documents/DATASETS/Hulth-20docs/"
# Directory contains 20 documents from the Hulth2003 dataset with following ids:
# 2 3 4 6 7 8 9 11  12  13  14  20  21  22  23  24  25  26  27  28

#####################################################
# USER FUNCTIONS
#####################################################
# Function to normalize a vector to unit length
normalize_vector <- function(x) {x / sqrt(sum(x^2))} # x here is the input vector

# Function to normalize tdm columnwise
normalize_tdm <- function(x){ # x here is the input matrix
  col_num <- ncol(x) # gets number of columns
  for (i in 1:col_num) { # for loop going through all columns
    x[,i] <- normalize_vector(x[,i]) # calling function to normalize the particular column, the column is passed as a vector
  }
  return(x)
}

#####################################################
# MAIN CODE
#####################################################
# Create the corpus
corp = Corpus(DirSource("/Users/swagata/Documents/DATASETS/Hulth-20docs/"))

# Clean and preprocess the corpus
# 1. delete all unwanted whitespaces
corp <- tm_map(corp, stripWhitespace)
# 2. transform all letters to lowercase
corp <- tm_map(corp, content_transformer(tolower))
# 3. remove punctuation marks
corp <- tm_map(corp, removePunctuation)
# 4. remove numbers [optional, not required if numbers are important]
corp <- tm_map(corp,removeNumbers)
# 5. remove stopwords [using inbuilt english stopwords list]
corp <- tm_map(corp,removeWords,stopwords(kind = "english"))
# 6. stemming using Porter stemmer
corp <- tm_map(corp, stemDocument, language = "english")

# Create the term-document matrix
tdm <- TermDocumentMatrix(corp)

# Convert tdm to matrix form
tdm = as.matrix(tdm)

# Normalize tdm
tdm_norm <- normalize_tdm(tdm)


# Compute Euclidean distance
euc_dist = proxy::dist(t(tdm), method = "Euclidean")
euc_dist # to print the result

euc_dist_norm = proxy::dist(t(tdm_norm), method = "Euclidean") # tdm normalized to unit length
euc_dist_norm # to print the result

# Compute Cosine similarity
cos_simil = proxy::simil(t(tdm), method = "cosine")
cos_simil # to print the result

cos_simil_norm = proxy::simil(t(tdm_norm), method = "cosine") # result same as above, no effect of normalization
cos_simil_norm # to print the result


# Correlation between Cosine similarity and Euclidean distance
cor(c(as.matrix(cos_simil)), c(as.matrix(euc_dist)), use = "complete.obs") # shows little or no correlation
cor(c(as.matrix(cos_simil_norm)), c(as.matrix(euc_dist_norm)), use = "complete.obs") # shows negative correlation
