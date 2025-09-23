#include "../include/mystrfunctions.h"
#include <string.h>

// Return length of string
int mystrlen(const char* s) {
    int len = 0;
    while (s[len] != '\0') len++;
    return len;
}

// Copy string
int mystrcpy(char* dest, const char* src) {
    int i = 0;
    while ((dest[i] = src[i]) != '\0') i++;
    return 0;
}

// Copy n characters
int mystrncpy(char* dest, const char* src, int n) {
    int i;
    for (i = 0; i < n && src[i] != '\0'; i++) {
        dest[i] = src[i];
    }
    dest[i] = '\0';
    return 0;
}

// Concatenate strings
int mystrcat(char* dest, const char* src) {
    int i = 0, j = 0;
    while (dest[i] != '\0') i++;
    while ((dest[i++] = src[j++]) != '\0');
    return 0;
}
