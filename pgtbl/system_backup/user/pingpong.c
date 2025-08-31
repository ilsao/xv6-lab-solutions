#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main()
{
    int p1[2];
    pipe(p1);

    int p2[2];
    pipe(p2);

    int pid;
    char buf;

    if ((pid = fork()) == 0) {
        close(p2[1]);
        close(p1[0]);
        read(p2[0], &buf, 1);
        printf("%d: received ping\n", getpid());
        write(p1[1], "o", 1);
        close(p2[0]);
        close(p1[1]);
    }
    else {
        close(p1[1]);
        close(p2[0]);
        write(p2[1], "i", 1);
        read(p1[0], &buf, 1);
        printf("%d: received pong\n", getpid());
        close(p1[0]);
        close(p2[1]);
    }

    exit(0);
}