# Euclidean-Distance-VS-Cosine-Similarity
Empirical evaluation to show the relation between these two distance measures.

I created a corpus of 20 documents from Hulth2003 dataset. The corpus is included in this repository. I used R to create a script to implement the following tasks. The documents were preprocessed as follows:

1. Strip whitespaces
2. Transform to lowercase
3. Remove all punctuations
4. Remove numbers
5. Remove stopwords using standard english list from R
6. Stem the documents using Porter stemmer

I then created a term-document matrix, which is used to calculate the Cosine similarity and Euclidean distance among all pairs of documents in the corpus. I also created a normalized version of the term-document matrix, which is then used to see the effect of normalization on Euclidean distance measure as well as Cosine similarity measure.

Finally, I tried to see how these two measures are correlated. I observed that when normalized, both these measures exhibit a strong negative correlation. On he other hand, when we use unnormalized matrix, both these measures show little to no correlation. 
