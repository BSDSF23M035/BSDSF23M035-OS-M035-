#include "myfile.h"

int count_lines(const char *filename) {
    FILE *fp = fopen(filename, "r");
    if (!fp) return -1;

    int count = 0;
    char c;
    while ((c = fgetc(fp)) != EOF) {
        if (c == '\n') count++;
    }

    fclose(fp);
    return count;
}
