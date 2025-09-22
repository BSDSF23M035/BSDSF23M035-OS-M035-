#include <stdio.h>
#include <stdlib.h>
#include "../include/mystrfunctions.h"
#include "../include/myfilefunctions.h"

int main() {
    printf("--- Testing String Functions ---\n");
    char str1[100] = "Hello";
    char str2[100];
    char str3[100] = " World";

    printf("Length of str1: %d\n", mystrlen(str1));
    mystrcpy(str2, str1);
    printf("Copied string: %s\n", str2);
    mystrcat(str1, str3);
    printf("Concatenated string: %s\n", str1);

    printf("\n--- Testing File Functions ---\n");
    FILE* fp = fopen("test.txt", "r");
    if (fp) {
        int lines, words, chars;
        wordCount(fp, &lines, &words, &chars);
        printf("Lines: %d, Words: %d, Chars: %d\n", lines, words, chars);

        char** matches;
        int matchCount = mygrep(fp, "Hello", &matches);
        printf("Found %d matches:\n", matchCount);
        for (int i = 0; i < matchCount; i++) {
            printf("%s", matches[i]);
            free(matches[i]);
        }
        free(matches);
        fclose(fp);
    } else {
        printf("test.txt not found. Create it with some text.\n");
    }

    return 0;
}
