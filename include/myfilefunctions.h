#include <stdio.h>

// Count lines, words and characters in file
// Return 0 on success and -1 on failure
int wordCount(FILE* file, int* lines, int* words, int* chars);

// Search lines containing search_str in a file and fill matches array
// Return count of matches, -1 on failure
int mygrep(FILE* fp, const char* search_str, char*** matches);
