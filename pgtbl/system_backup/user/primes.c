#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

void readleft(int *p0)
{
    int pid;
    if ((pid = fork()) == 0) {
        int cur, tmp;
        if (read(*p0, &cur, sizeof(int)) == 0)
            return;
        printf("prime %d\n", cur);

        int p[2];
        pipe(p);
        while(read(*p0, &tmp, sizeof(int)) != 0) {
            if (tmp % cur != 0)
                write(p[1], &tmp, sizeof(int));
        }
        close(*p0);
        close(p[1]);
        readleft(p);
        close(p[0]);
        exit(0);
    }
    else {
        close(*p0);
        wait(0);
    }
}

int main()
{
    int p[2];
    pipe(p);

    for (int i = 2; i <= 35; i++) {
        write(p[1], &i, sizeof(int));
    }

    close(p[1]);

    readleft(p);

    exit(0);
}