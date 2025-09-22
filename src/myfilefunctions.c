#include "../include/myfilefunctions.h"
#include <stdlib.h>
#include <string.h>

int wordCount(FILE* file, int* lines, int* words, int* chars) {
    if (!file) return -1;
    *lines = *words = *chars = 0;
    char c;
    int inWord = 0;

    while ((c = fgetc(file)) != EOF) {
        (*chars)++;
        if (c == '\n') (*lines)++;
        if (c == ' ' || c == '\n' || c == '\t')
            inWord = 0;
        else if (!inWord) {
            inWord = 1;
            (*words)++;
        }
    }
    rewind(file);
    return 0;
}

int mygrep(FILE* fp, const char* search_str, char*** matches) {
    if (!fp) return -1;
    char line[256];
    int count = 0;
    int capacity = 10;
    *matches = malloc(capacity * sizeof(char*));

    while (fgets(line, sizeof(line), fp)) {
        if (strstr(line, search_str)) {
            if (count >= capacity) {
                capacity *= 2;
                *matches = realloc(*matches, capacity * sizeof(char*));
            }
            (*matches)[count] = strdup(line);
            count++;
        }
    }
    rewind(fp);
    return count;
}
