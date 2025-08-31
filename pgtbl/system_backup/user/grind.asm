
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	1141                	addi	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	addi	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       6:	611c                	ld	a5,0(a0)
       8:	80000737          	lui	a4,0x80000
       c:	ffe74713          	xori	a4,a4,-2
      10:	02e7f7b3          	remu	a5,a5,a4
      14:	0785                	addi	a5,a5,1
    hi = x / 127773;
    lo = x % 127773;
      16:	66fd                	lui	a3,0x1f
      18:	31d68693          	addi	a3,a3,797 # 1f31d <base+0x1cf15>
      1c:	02d7e733          	rem	a4,a5,a3
    x = 16807 * lo - 2836 * hi;
      20:	6611                	lui	a2,0x4
      22:	1a760613          	addi	a2,a2,423 # 41a7 <base+0x1d9f>
      26:	02c70733          	mul	a4,a4,a2
    hi = x / 127773;
      2a:	02d7c7b3          	div	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      2e:	76fd                	lui	a3,0xfffff
      30:	4ec68693          	addi	a3,a3,1260 # fffffffffffff4ec <base+0xffffffffffffd0e4>
      34:	02d787b3          	mul	a5,a5,a3
      38:	97ba                	add	a5,a5,a4
    if (x < 0)
      3a:	0007c963          	bltz	a5,4c <do_rand+0x4c>
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      3e:	17fd                	addi	a5,a5,-1
    *ctx = x;
      40:	e11c                	sd	a5,0(a0)
    return (x);
}
      42:	0007851b          	sext.w	a0,a5
      46:	6422                	ld	s0,8(sp)
      48:	0141                	addi	sp,sp,16
      4a:	8082                	ret
        x += 0x7fffffff;
      4c:	80000737          	lui	a4,0x80000
      50:	fff74713          	not	a4,a4
      54:	97ba                	add	a5,a5,a4
      56:	b7e5                	j	3e <do_rand+0x3e>

0000000000000058 <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      58:	1141                	addi	sp,sp,-16
      5a:	e406                	sd	ra,8(sp)
      5c:	e022                	sd	s0,0(sp)
      5e:	0800                	addi	s0,sp,16
    return (do_rand(&rand_next));
      60:	00002517          	auipc	a0,0x2
      64:	fa050513          	addi	a0,a0,-96 # 2000 <rand_next>
      68:	00000097          	auipc	ra,0x0
      6c:	f98080e7          	jalr	-104(ra) # 0 <do_rand>
}
      70:	60a2                	ld	ra,8(sp)
      72:	6402                	ld	s0,0(sp)
      74:	0141                	addi	sp,sp,16
      76:	8082                	ret

0000000000000078 <go>:

void
go(int which_child)
{
      78:	7159                	addi	sp,sp,-112
      7a:	f486                	sd	ra,104(sp)
      7c:	f0a2                	sd	s0,96(sp)
      7e:	eca6                	sd	s1,88(sp)
      80:	e8ca                	sd	s2,80(sp)
      82:	e4ce                	sd	s3,72(sp)
      84:	e0d2                	sd	s4,64(sp)
      86:	fc56                	sd	s5,56(sp)
      88:	f85a                	sd	s6,48(sp)
      8a:	1880                	addi	s0,sp,112
      8c:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      8e:	4501                	li	a0,0
      90:	00001097          	auipc	ra,0x1
      94:	ed0080e7          	jalr	-304(ra) # f60 <sbrk>
      98:	8aaa                	mv	s5,a0
  uint64 iters = 0;

  mkdir("grindir");
      9a:	00001517          	auipc	a0,0x1
      9e:	38650513          	addi	a0,a0,902 # 1420 <malloc+0xf2>
      a2:	00001097          	auipc	ra,0x1
      a6:	e9e080e7          	jalr	-354(ra) # f40 <mkdir>
  if(chdir("grindir") != 0){
      aa:	00001517          	auipc	a0,0x1
      ae:	37650513          	addi	a0,a0,886 # 1420 <malloc+0xf2>
      b2:	00001097          	auipc	ra,0x1
      b6:	e96080e7          	jalr	-362(ra) # f48 <chdir>
      ba:	cd11                	beqz	a0,d6 <go+0x5e>
    printf("grind: chdir grindir failed\n");
      bc:	00001517          	auipc	a0,0x1
      c0:	36c50513          	addi	a0,a0,876 # 1428 <malloc+0xfa>
      c4:	00001097          	auipc	ra,0x1
      c8:	1aa080e7          	jalr	426(ra) # 126e <printf>
    exit(1);
      cc:	4505                	li	a0,1
      ce:	00001097          	auipc	ra,0x1
      d2:	e0a080e7          	jalr	-502(ra) # ed8 <exit>
  }
  chdir("/");
      d6:	00001517          	auipc	a0,0x1
      da:	37250513          	addi	a0,a0,882 # 1448 <malloc+0x11a>
      de:	00001097          	auipc	ra,0x1
      e2:	e6a080e7          	jalr	-406(ra) # f48 <chdir>
  
  while(1){
    iters++;
    if((iters % 500) == 0)
      e6:	00001917          	auipc	s2,0x1
      ea:	37290913          	addi	s2,s2,882 # 1458 <malloc+0x12a>
      ee:	c489                	beqz	s1,f8 <go+0x80>
      f0:	00001917          	auipc	s2,0x1
      f4:	36090913          	addi	s2,s2,864 # 1450 <malloc+0x122>
    iters++;
      f8:	4485                	li	s1,1
  int fd = -1;
      fa:	59fd                	li	s3,-1
      close(fd);
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
    } else if(what == 7){
      write(fd, buf, sizeof(buf));
    } else if(what == 8){
      read(fd, buf, sizeof(buf));
      fc:	00002a17          	auipc	s4,0x2
     100:	f24a0a13          	addi	s4,s4,-220 # 2020 <buf.1269>
     104:	a825                	j	13c <go+0xc4>
      close(open("grindir/../a", O_CREATE|O_RDWR));
     106:	20200593          	li	a1,514
     10a:	00001517          	auipc	a0,0x1
     10e:	35650513          	addi	a0,a0,854 # 1460 <malloc+0x132>
     112:	00001097          	auipc	ra,0x1
     116:	e06080e7          	jalr	-506(ra) # f18 <open>
     11a:	00001097          	auipc	ra,0x1
     11e:	de6080e7          	jalr	-538(ra) # f00 <close>
    iters++;
     122:	0485                	addi	s1,s1,1
    if((iters % 500) == 0)
     124:	1f400793          	li	a5,500
     128:	02f4f7b3          	remu	a5,s1,a5
     12c:	eb81                	bnez	a5,13c <go+0xc4>
      write(1, which_child?"B":"A", 1);
     12e:	4605                	li	a2,1
     130:	85ca                	mv	a1,s2
     132:	4505                	li	a0,1
     134:	00001097          	auipc	ra,0x1
     138:	dc4080e7          	jalr	-572(ra) # ef8 <write>
    int what = rand() % 23;
     13c:	00000097          	auipc	ra,0x0
     140:	f1c080e7          	jalr	-228(ra) # 58 <rand>
     144:	47dd                	li	a5,23
     146:	02f5653b          	remw	a0,a0,a5
    if(what == 1){
     14a:	4785                	li	a5,1
     14c:	faf50de3          	beq	a0,a5,106 <go+0x8e>
    } else if(what == 2){
     150:	4789                	li	a5,2
     152:	18f50b63          	beq	a0,a5,2e8 <go+0x270>
    } else if(what == 3){
     156:	478d                	li	a5,3
     158:	1af50763          	beq	a0,a5,306 <go+0x28e>
    } else if(what == 4){
     15c:	4791                	li	a5,4
     15e:	1af50d63          	beq	a0,a5,318 <go+0x2a0>
    } else if(what == 5){
     162:	4795                	li	a5,5
     164:	20f50163          	beq	a0,a5,366 <go+0x2ee>
    } else if(what == 6){
     168:	4799                	li	a5,6
     16a:	20f50f63          	beq	a0,a5,388 <go+0x310>
    } else if(what == 7){
     16e:	479d                	li	a5,7
     170:	22f50d63          	beq	a0,a5,3aa <go+0x332>
    } else if(what == 8){
     174:	47a1                	li	a5,8
     176:	24f50363          	beq	a0,a5,3bc <go+0x344>
    } else if(what == 9){
     17a:	47a5                	li	a5,9
     17c:	24f50963          	beq	a0,a5,3ce <go+0x356>
      mkdir("grindir/../a");
      close(open("a/../a/./a", O_CREATE|O_RDWR));
      unlink("a/a");
    } else if(what == 10){
     180:	47a9                	li	a5,10
     182:	28f50563          	beq	a0,a5,40c <go+0x394>
      mkdir("/../b");
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
      unlink("b/b");
    } else if(what == 11){
     186:	47ad                	li	a5,11
     188:	2cf50163          	beq	a0,a5,44a <go+0x3d2>
      unlink("b");
      link("../grindir/./../a", "../b");
    } else if(what == 12){
     18c:	47b1                	li	a5,12
     18e:	2ef50363          	beq	a0,a5,474 <go+0x3fc>
      unlink("../grindir/../a");
      link(".././b", "/grindir/../a");
    } else if(what == 13){
     192:	47b5                	li	a5,13
     194:	30f50563          	beq	a0,a5,49e <go+0x426>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
    } else if(what == 14){
     198:	47b9                	li	a5,14
     19a:	34f50063          	beq	a0,a5,4da <go+0x462>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
    } else if(what == 15){
     19e:	47bd                	li	a5,15
     1a0:	38f50463          	beq	a0,a5,528 <go+0x4b0>
      sbrk(6011);
    } else if(what == 16){
     1a4:	47c1                	li	a5,16
     1a6:	38f50963          	beq	a0,a5,538 <go+0x4c0>
      if(sbrk(0) > break0)
        sbrk(-(sbrk(0) - break0));
    } else if(what == 17){
     1aa:	47c5                	li	a5,17
     1ac:	3af50963          	beq	a0,a5,55e <go+0x4e6>
        printf("grind: chdir failed\n");
        exit(1);
      }
      kill(pid);
      wait(0);
    } else if(what == 18){
     1b0:	47c9                	li	a5,18
     1b2:	42f50f63          	beq	a0,a5,5f0 <go+0x578>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
    } else if(what == 19){
     1b6:	47cd                	li	a5,19
     1b8:	48f50363          	beq	a0,a5,63e <go+0x5c6>
        exit(1);
      }
      close(fds[0]);
      close(fds[1]);
      wait(0);
    } else if(what == 20){
     1bc:	47d1                	li	a5,20
     1be:	56f50463          	beq	a0,a5,726 <go+0x6ae>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
    } else if(what == 21){
     1c2:	47d5                	li	a5,21
     1c4:	60f50263          	beq	a0,a5,7c8 <go+0x750>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
        exit(1);
      }
      close(fd1);
      unlink("c");
    } else if(what == 22){
     1c8:	47d9                	li	a5,22
     1ca:	f4f51ce3          	bne	a0,a5,122 <go+0xaa>
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     1ce:	f9840513          	addi	a0,s0,-104
     1d2:	00001097          	auipc	ra,0x1
     1d6:	d16080e7          	jalr	-746(ra) # ee8 <pipe>
     1da:	6e054b63          	bltz	a0,8d0 <go+0x858>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     1de:	fa040513          	addi	a0,s0,-96
     1e2:	00001097          	auipc	ra,0x1
     1e6:	d06080e7          	jalr	-762(ra) # ee8 <pipe>
     1ea:	70054163          	bltz	a0,8ec <go+0x874>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     1ee:	00001097          	auipc	ra,0x1
     1f2:	ce2080e7          	jalr	-798(ra) # ed0 <fork>
      if(pid1 == 0){
     1f6:	70050963          	beqz	a0,908 <go+0x890>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     1fa:	7c054163          	bltz	a0,9bc <go+0x944>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     1fe:	00001097          	auipc	ra,0x1
     202:	cd2080e7          	jalr	-814(ra) # ed0 <fork>
      if(pid2 == 0){
     206:	7c050963          	beqz	a0,9d8 <go+0x960>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     20a:	0a0545e3          	bltz	a0,ab4 <go+0xa3c>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     20e:	f9842503          	lw	a0,-104(s0)
     212:	00001097          	auipc	ra,0x1
     216:	cee080e7          	jalr	-786(ra) # f00 <close>
      close(aa[1]);
     21a:	f9c42503          	lw	a0,-100(s0)
     21e:	00001097          	auipc	ra,0x1
     222:	ce2080e7          	jalr	-798(ra) # f00 <close>
      close(bb[1]);
     226:	fa442503          	lw	a0,-92(s0)
     22a:	00001097          	auipc	ra,0x1
     22e:	cd6080e7          	jalr	-810(ra) # f00 <close>
      char buf[4] = { 0, 0, 0, 0 };
     232:	f8040823          	sb	zero,-112(s0)
     236:	f80408a3          	sb	zero,-111(s0)
     23a:	f8040923          	sb	zero,-110(s0)
     23e:	f80409a3          	sb	zero,-109(s0)
      read(bb[0], buf+0, 1);
     242:	4605                	li	a2,1
     244:	f9040593          	addi	a1,s0,-112
     248:	fa042503          	lw	a0,-96(s0)
     24c:	00001097          	auipc	ra,0x1
     250:	ca4080e7          	jalr	-860(ra) # ef0 <read>
      read(bb[0], buf+1, 1);
     254:	4605                	li	a2,1
     256:	f9140593          	addi	a1,s0,-111
     25a:	fa042503          	lw	a0,-96(s0)
     25e:	00001097          	auipc	ra,0x1
     262:	c92080e7          	jalr	-878(ra) # ef0 <read>
      read(bb[0], buf+2, 1);
     266:	4605                	li	a2,1
     268:	f9240593          	addi	a1,s0,-110
     26c:	fa042503          	lw	a0,-96(s0)
     270:	00001097          	auipc	ra,0x1
     274:	c80080e7          	jalr	-896(ra) # ef0 <read>
      close(bb[0]);
     278:	fa042503          	lw	a0,-96(s0)
     27c:	00001097          	auipc	ra,0x1
     280:	c84080e7          	jalr	-892(ra) # f00 <close>
      int st1, st2;
      wait(&st1);
     284:	f9440513          	addi	a0,s0,-108
     288:	00001097          	auipc	ra,0x1
     28c:	c58080e7          	jalr	-936(ra) # ee0 <wait>
      wait(&st2);
     290:	fa840513          	addi	a0,s0,-88
     294:	00001097          	auipc	ra,0x1
     298:	c4c080e7          	jalr	-948(ra) # ee0 <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     29c:	f9442783          	lw	a5,-108(s0)
     2a0:	fa842703          	lw	a4,-88(s0)
     2a4:	8fd9                	or	a5,a5,a4
     2a6:	2781                	sext.w	a5,a5
     2a8:	ef89                	bnez	a5,2c2 <go+0x24a>
     2aa:	00001597          	auipc	a1,0x1
     2ae:	42e58593          	addi	a1,a1,1070 # 16d8 <malloc+0x3aa>
     2b2:	f9040513          	addi	a0,s0,-112
     2b6:	00001097          	auipc	ra,0x1
     2ba:	998080e7          	jalr	-1640(ra) # c4e <strcmp>
     2be:	e60502e3          	beqz	a0,122 <go+0xaa>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     2c2:	f9040693          	addi	a3,s0,-112
     2c6:	fa842603          	lw	a2,-88(s0)
     2ca:	f9442583          	lw	a1,-108(s0)
     2ce:	00001517          	auipc	a0,0x1
     2d2:	41250513          	addi	a0,a0,1042 # 16e0 <malloc+0x3b2>
     2d6:	00001097          	auipc	ra,0x1
     2da:	f98080e7          	jalr	-104(ra) # 126e <printf>
        exit(1);
     2de:	4505                	li	a0,1
     2e0:	00001097          	auipc	ra,0x1
     2e4:	bf8080e7          	jalr	-1032(ra) # ed8 <exit>
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     2e8:	20200593          	li	a1,514
     2ec:	00001517          	auipc	a0,0x1
     2f0:	18450513          	addi	a0,a0,388 # 1470 <malloc+0x142>
     2f4:	00001097          	auipc	ra,0x1
     2f8:	c24080e7          	jalr	-988(ra) # f18 <open>
     2fc:	00001097          	auipc	ra,0x1
     300:	c04080e7          	jalr	-1020(ra) # f00 <close>
     304:	bd39                	j	122 <go+0xaa>
      unlink("grindir/../a");
     306:	00001517          	auipc	a0,0x1
     30a:	15a50513          	addi	a0,a0,346 # 1460 <malloc+0x132>
     30e:	00001097          	auipc	ra,0x1
     312:	c1a080e7          	jalr	-998(ra) # f28 <unlink>
     316:	b531                	j	122 <go+0xaa>
      if(chdir("grindir") != 0){
     318:	00001517          	auipc	a0,0x1
     31c:	10850513          	addi	a0,a0,264 # 1420 <malloc+0xf2>
     320:	00001097          	auipc	ra,0x1
     324:	c28080e7          	jalr	-984(ra) # f48 <chdir>
     328:	e115                	bnez	a0,34c <go+0x2d4>
      unlink("../b");
     32a:	00001517          	auipc	a0,0x1
     32e:	15e50513          	addi	a0,a0,350 # 1488 <malloc+0x15a>
     332:	00001097          	auipc	ra,0x1
     336:	bf6080e7          	jalr	-1034(ra) # f28 <unlink>
      chdir("/");
     33a:	00001517          	auipc	a0,0x1
     33e:	10e50513          	addi	a0,a0,270 # 1448 <malloc+0x11a>
     342:	00001097          	auipc	ra,0x1
     346:	c06080e7          	jalr	-1018(ra) # f48 <chdir>
     34a:	bbe1                	j	122 <go+0xaa>
        printf("grind: chdir grindir failed\n");
     34c:	00001517          	auipc	a0,0x1
     350:	0dc50513          	addi	a0,a0,220 # 1428 <malloc+0xfa>
     354:	00001097          	auipc	ra,0x1
     358:	f1a080e7          	jalr	-230(ra) # 126e <printf>
        exit(1);
     35c:	4505                	li	a0,1
     35e:	00001097          	auipc	ra,0x1
     362:	b7a080e7          	jalr	-1158(ra) # ed8 <exit>
      close(fd);
     366:	854e                	mv	a0,s3
     368:	00001097          	auipc	ra,0x1
     36c:	b98080e7          	jalr	-1128(ra) # f00 <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     370:	20200593          	li	a1,514
     374:	00001517          	auipc	a0,0x1
     378:	11c50513          	addi	a0,a0,284 # 1490 <malloc+0x162>
     37c:	00001097          	auipc	ra,0x1
     380:	b9c080e7          	jalr	-1124(ra) # f18 <open>
     384:	89aa                	mv	s3,a0
     386:	bb71                	j	122 <go+0xaa>
      close(fd);
     388:	854e                	mv	a0,s3
     38a:	00001097          	auipc	ra,0x1
     38e:	b76080e7          	jalr	-1162(ra) # f00 <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     392:	20200593          	li	a1,514
     396:	00001517          	auipc	a0,0x1
     39a:	10a50513          	addi	a0,a0,266 # 14a0 <malloc+0x172>
     39e:	00001097          	auipc	ra,0x1
     3a2:	b7a080e7          	jalr	-1158(ra) # f18 <open>
     3a6:	89aa                	mv	s3,a0
     3a8:	bbad                	j	122 <go+0xaa>
      write(fd, buf, sizeof(buf));
     3aa:	3e700613          	li	a2,999
     3ae:	85d2                	mv	a1,s4
     3b0:	854e                	mv	a0,s3
     3b2:	00001097          	auipc	ra,0x1
     3b6:	b46080e7          	jalr	-1210(ra) # ef8 <write>
     3ba:	b3a5                	j	122 <go+0xaa>
      read(fd, buf, sizeof(buf));
     3bc:	3e700613          	li	a2,999
     3c0:	85d2                	mv	a1,s4
     3c2:	854e                	mv	a0,s3
     3c4:	00001097          	auipc	ra,0x1
     3c8:	b2c080e7          	jalr	-1236(ra) # ef0 <read>
     3cc:	bb99                	j	122 <go+0xaa>
      mkdir("grindir/../a");
     3ce:	00001517          	auipc	a0,0x1
     3d2:	09250513          	addi	a0,a0,146 # 1460 <malloc+0x132>
     3d6:	00001097          	auipc	ra,0x1
     3da:	b6a080e7          	jalr	-1174(ra) # f40 <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     3de:	20200593          	li	a1,514
     3e2:	00001517          	auipc	a0,0x1
     3e6:	0d650513          	addi	a0,a0,214 # 14b8 <malloc+0x18a>
     3ea:	00001097          	auipc	ra,0x1
     3ee:	b2e080e7          	jalr	-1234(ra) # f18 <open>
     3f2:	00001097          	auipc	ra,0x1
     3f6:	b0e080e7          	jalr	-1266(ra) # f00 <close>
      unlink("a/a");
     3fa:	00001517          	auipc	a0,0x1
     3fe:	0ce50513          	addi	a0,a0,206 # 14c8 <malloc+0x19a>
     402:	00001097          	auipc	ra,0x1
     406:	b26080e7          	jalr	-1242(ra) # f28 <unlink>
     40a:	bb21                	j	122 <go+0xaa>
      mkdir("/../b");
     40c:	00001517          	auipc	a0,0x1
     410:	0c450513          	addi	a0,a0,196 # 14d0 <malloc+0x1a2>
     414:	00001097          	auipc	ra,0x1
     418:	b2c080e7          	jalr	-1236(ra) # f40 <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     41c:	20200593          	li	a1,514
     420:	00001517          	auipc	a0,0x1
     424:	0b850513          	addi	a0,a0,184 # 14d8 <malloc+0x1aa>
     428:	00001097          	auipc	ra,0x1
     42c:	af0080e7          	jalr	-1296(ra) # f18 <open>
     430:	00001097          	auipc	ra,0x1
     434:	ad0080e7          	jalr	-1328(ra) # f00 <close>
      unlink("b/b");
     438:	00001517          	auipc	a0,0x1
     43c:	0b050513          	addi	a0,a0,176 # 14e8 <malloc+0x1ba>
     440:	00001097          	auipc	ra,0x1
     444:	ae8080e7          	jalr	-1304(ra) # f28 <unlink>
     448:	b9e9                	j	122 <go+0xaa>
      unlink("b");
     44a:	00001517          	auipc	a0,0x1
     44e:	06650513          	addi	a0,a0,102 # 14b0 <malloc+0x182>
     452:	00001097          	auipc	ra,0x1
     456:	ad6080e7          	jalr	-1322(ra) # f28 <unlink>
      link("../grindir/./../a", "../b");
     45a:	00001597          	auipc	a1,0x1
     45e:	02e58593          	addi	a1,a1,46 # 1488 <malloc+0x15a>
     462:	00001517          	auipc	a0,0x1
     466:	08e50513          	addi	a0,a0,142 # 14f0 <malloc+0x1c2>
     46a:	00001097          	auipc	ra,0x1
     46e:	ace080e7          	jalr	-1330(ra) # f38 <link>
     472:	b945                	j	122 <go+0xaa>
      unlink("../grindir/../a");
     474:	00001517          	auipc	a0,0x1
     478:	09450513          	addi	a0,a0,148 # 1508 <malloc+0x1da>
     47c:	00001097          	auipc	ra,0x1
     480:	aac080e7          	jalr	-1364(ra) # f28 <unlink>
      link(".././b", "/grindir/../a");
     484:	00001597          	auipc	a1,0x1
     488:	00c58593          	addi	a1,a1,12 # 1490 <malloc+0x162>
     48c:	00001517          	auipc	a0,0x1
     490:	08c50513          	addi	a0,a0,140 # 1518 <malloc+0x1ea>
     494:	00001097          	auipc	ra,0x1
     498:	aa4080e7          	jalr	-1372(ra) # f38 <link>
     49c:	b159                	j	122 <go+0xaa>
      int pid = fork();
     49e:	00001097          	auipc	ra,0x1
     4a2:	a32080e7          	jalr	-1486(ra) # ed0 <fork>
      if(pid == 0){
     4a6:	c909                	beqz	a0,4b8 <go+0x440>
      } else if(pid < 0){
     4a8:	00054c63          	bltz	a0,4c0 <go+0x448>
      wait(0);
     4ac:	4501                	li	a0,0
     4ae:	00001097          	auipc	ra,0x1
     4b2:	a32080e7          	jalr	-1486(ra) # ee0 <wait>
     4b6:	b1b5                	j	122 <go+0xaa>
        exit(0);
     4b8:	00001097          	auipc	ra,0x1
     4bc:	a20080e7          	jalr	-1504(ra) # ed8 <exit>
        printf("grind: fork failed\n");
     4c0:	00001517          	auipc	a0,0x1
     4c4:	06050513          	addi	a0,a0,96 # 1520 <malloc+0x1f2>
     4c8:	00001097          	auipc	ra,0x1
     4cc:	da6080e7          	jalr	-602(ra) # 126e <printf>
        exit(1);
     4d0:	4505                	li	a0,1
     4d2:	00001097          	auipc	ra,0x1
     4d6:	a06080e7          	jalr	-1530(ra) # ed8 <exit>
      int pid = fork();
     4da:	00001097          	auipc	ra,0x1
     4de:	9f6080e7          	jalr	-1546(ra) # ed0 <fork>
      if(pid == 0){
     4e2:	c909                	beqz	a0,4f4 <go+0x47c>
      } else if(pid < 0){
     4e4:	02054563          	bltz	a0,50e <go+0x496>
      wait(0);
     4e8:	4501                	li	a0,0
     4ea:	00001097          	auipc	ra,0x1
     4ee:	9f6080e7          	jalr	-1546(ra) # ee0 <wait>
     4f2:	b905                	j	122 <go+0xaa>
        fork();
     4f4:	00001097          	auipc	ra,0x1
     4f8:	9dc080e7          	jalr	-1572(ra) # ed0 <fork>
        fork();
     4fc:	00001097          	auipc	ra,0x1
     500:	9d4080e7          	jalr	-1580(ra) # ed0 <fork>
        exit(0);
     504:	4501                	li	a0,0
     506:	00001097          	auipc	ra,0x1
     50a:	9d2080e7          	jalr	-1582(ra) # ed8 <exit>
        printf("grind: fork failed\n");
     50e:	00001517          	auipc	a0,0x1
     512:	01250513          	addi	a0,a0,18 # 1520 <malloc+0x1f2>
     516:	00001097          	auipc	ra,0x1
     51a:	d58080e7          	jalr	-680(ra) # 126e <printf>
        exit(1);
     51e:	4505                	li	a0,1
     520:	00001097          	auipc	ra,0x1
     524:	9b8080e7          	jalr	-1608(ra) # ed8 <exit>
      sbrk(6011);
     528:	6505                	lui	a0,0x1
     52a:	77b50513          	addi	a0,a0,1915 # 177b <digits+0x73>
     52e:	00001097          	auipc	ra,0x1
     532:	a32080e7          	jalr	-1486(ra) # f60 <sbrk>
     536:	b6f5                	j	122 <go+0xaa>
      if(sbrk(0) > break0)
     538:	4501                	li	a0,0
     53a:	00001097          	auipc	ra,0x1
     53e:	a26080e7          	jalr	-1498(ra) # f60 <sbrk>
     542:	beaaf0e3          	bgeu	s5,a0,122 <go+0xaa>
        sbrk(-(sbrk(0) - break0));
     546:	4501                	li	a0,0
     548:	00001097          	auipc	ra,0x1
     54c:	a18080e7          	jalr	-1512(ra) # f60 <sbrk>
     550:	40aa853b          	subw	a0,s5,a0
     554:	00001097          	auipc	ra,0x1
     558:	a0c080e7          	jalr	-1524(ra) # f60 <sbrk>
     55c:	b6d9                	j	122 <go+0xaa>
      int pid = fork();
     55e:	00001097          	auipc	ra,0x1
     562:	972080e7          	jalr	-1678(ra) # ed0 <fork>
     566:	8b2a                	mv	s6,a0
      if(pid == 0){
     568:	c51d                	beqz	a0,596 <go+0x51e>
      } else if(pid < 0){
     56a:	04054963          	bltz	a0,5bc <go+0x544>
      if(chdir("../grindir/..") != 0){
     56e:	00001517          	auipc	a0,0x1
     572:	fca50513          	addi	a0,a0,-54 # 1538 <malloc+0x20a>
     576:	00001097          	auipc	ra,0x1
     57a:	9d2080e7          	jalr	-1582(ra) # f48 <chdir>
     57e:	ed21                	bnez	a0,5d6 <go+0x55e>
      kill(pid);
     580:	855a                	mv	a0,s6
     582:	00001097          	auipc	ra,0x1
     586:	986080e7          	jalr	-1658(ra) # f08 <kill>
      wait(0);
     58a:	4501                	li	a0,0
     58c:	00001097          	auipc	ra,0x1
     590:	954080e7          	jalr	-1708(ra) # ee0 <wait>
     594:	b679                	j	122 <go+0xaa>
        close(open("a", O_CREATE|O_RDWR));
     596:	20200593          	li	a1,514
     59a:	00001517          	auipc	a0,0x1
     59e:	f6650513          	addi	a0,a0,-154 # 1500 <malloc+0x1d2>
     5a2:	00001097          	auipc	ra,0x1
     5a6:	976080e7          	jalr	-1674(ra) # f18 <open>
     5aa:	00001097          	auipc	ra,0x1
     5ae:	956080e7          	jalr	-1706(ra) # f00 <close>
        exit(0);
     5b2:	4501                	li	a0,0
     5b4:	00001097          	auipc	ra,0x1
     5b8:	924080e7          	jalr	-1756(ra) # ed8 <exit>
        printf("grind: fork failed\n");
     5bc:	00001517          	auipc	a0,0x1
     5c0:	f6450513          	addi	a0,a0,-156 # 1520 <malloc+0x1f2>
     5c4:	00001097          	auipc	ra,0x1
     5c8:	caa080e7          	jalr	-854(ra) # 126e <printf>
        exit(1);
     5cc:	4505                	li	a0,1
     5ce:	00001097          	auipc	ra,0x1
     5d2:	90a080e7          	jalr	-1782(ra) # ed8 <exit>
        printf("grind: chdir failed\n");
     5d6:	00001517          	auipc	a0,0x1
     5da:	f7250513          	addi	a0,a0,-142 # 1548 <malloc+0x21a>
     5de:	00001097          	auipc	ra,0x1
     5e2:	c90080e7          	jalr	-880(ra) # 126e <printf>
        exit(1);
     5e6:	4505                	li	a0,1
     5e8:	00001097          	auipc	ra,0x1
     5ec:	8f0080e7          	jalr	-1808(ra) # ed8 <exit>
      int pid = fork();
     5f0:	00001097          	auipc	ra,0x1
     5f4:	8e0080e7          	jalr	-1824(ra) # ed0 <fork>
      if(pid == 0){
     5f8:	c909                	beqz	a0,60a <go+0x592>
      } else if(pid < 0){
     5fa:	02054563          	bltz	a0,624 <go+0x5ac>
      wait(0);
     5fe:	4501                	li	a0,0
     600:	00001097          	auipc	ra,0x1
     604:	8e0080e7          	jalr	-1824(ra) # ee0 <wait>
     608:	be29                	j	122 <go+0xaa>
        kill(getpid());
     60a:	00001097          	auipc	ra,0x1
     60e:	94e080e7          	jalr	-1714(ra) # f58 <getpid>
     612:	00001097          	auipc	ra,0x1
     616:	8f6080e7          	jalr	-1802(ra) # f08 <kill>
        exit(0);
     61a:	4501                	li	a0,0
     61c:	00001097          	auipc	ra,0x1
     620:	8bc080e7          	jalr	-1860(ra) # ed8 <exit>
        printf("grind: fork failed\n");
     624:	00001517          	auipc	a0,0x1
     628:	efc50513          	addi	a0,a0,-260 # 1520 <malloc+0x1f2>
     62c:	00001097          	auipc	ra,0x1
     630:	c42080e7          	jalr	-958(ra) # 126e <printf>
        exit(1);
     634:	4505                	li	a0,1
     636:	00001097          	auipc	ra,0x1
     63a:	8a2080e7          	jalr	-1886(ra) # ed8 <exit>
      if(pipe(fds) < 0){
     63e:	fa840513          	addi	a0,s0,-88
     642:	00001097          	auipc	ra,0x1
     646:	8a6080e7          	jalr	-1882(ra) # ee8 <pipe>
     64a:	02054b63          	bltz	a0,680 <go+0x608>
      int pid = fork();
     64e:	00001097          	auipc	ra,0x1
     652:	882080e7          	jalr	-1918(ra) # ed0 <fork>
      if(pid == 0){
     656:	c131                	beqz	a0,69a <go+0x622>
      } else if(pid < 0){
     658:	0a054a63          	bltz	a0,70c <go+0x694>
      close(fds[0]);
     65c:	fa842503          	lw	a0,-88(s0)
     660:	00001097          	auipc	ra,0x1
     664:	8a0080e7          	jalr	-1888(ra) # f00 <close>
      close(fds[1]);
     668:	fac42503          	lw	a0,-84(s0)
     66c:	00001097          	auipc	ra,0x1
     670:	894080e7          	jalr	-1900(ra) # f00 <close>
      wait(0);
     674:	4501                	li	a0,0
     676:	00001097          	auipc	ra,0x1
     67a:	86a080e7          	jalr	-1942(ra) # ee0 <wait>
     67e:	b455                	j	122 <go+0xaa>
        printf("grind: pipe failed\n");
     680:	00001517          	auipc	a0,0x1
     684:	ee050513          	addi	a0,a0,-288 # 1560 <malloc+0x232>
     688:	00001097          	auipc	ra,0x1
     68c:	be6080e7          	jalr	-1050(ra) # 126e <printf>
        exit(1);
     690:	4505                	li	a0,1
     692:	00001097          	auipc	ra,0x1
     696:	846080e7          	jalr	-1978(ra) # ed8 <exit>
        fork();
     69a:	00001097          	auipc	ra,0x1
     69e:	836080e7          	jalr	-1994(ra) # ed0 <fork>
        fork();
     6a2:	00001097          	auipc	ra,0x1
     6a6:	82e080e7          	jalr	-2002(ra) # ed0 <fork>
        if(write(fds[1], "x", 1) != 1)
     6aa:	4605                	li	a2,1
     6ac:	00001597          	auipc	a1,0x1
     6b0:	ecc58593          	addi	a1,a1,-308 # 1578 <malloc+0x24a>
     6b4:	fac42503          	lw	a0,-84(s0)
     6b8:	00001097          	auipc	ra,0x1
     6bc:	840080e7          	jalr	-1984(ra) # ef8 <write>
     6c0:	4785                	li	a5,1
     6c2:	02f51363          	bne	a0,a5,6e8 <go+0x670>
        if(read(fds[0], &c, 1) != 1)
     6c6:	4605                	li	a2,1
     6c8:	fa040593          	addi	a1,s0,-96
     6cc:	fa842503          	lw	a0,-88(s0)
     6d0:	00001097          	auipc	ra,0x1
     6d4:	820080e7          	jalr	-2016(ra) # ef0 <read>
     6d8:	4785                	li	a5,1
     6da:	02f51063          	bne	a0,a5,6fa <go+0x682>
        exit(0);
     6de:	4501                	li	a0,0
     6e0:	00000097          	auipc	ra,0x0
     6e4:	7f8080e7          	jalr	2040(ra) # ed8 <exit>
          printf("grind: pipe write failed\n");
     6e8:	00001517          	auipc	a0,0x1
     6ec:	e9850513          	addi	a0,a0,-360 # 1580 <malloc+0x252>
     6f0:	00001097          	auipc	ra,0x1
     6f4:	b7e080e7          	jalr	-1154(ra) # 126e <printf>
     6f8:	b7f9                	j	6c6 <go+0x64e>
          printf("grind: pipe read failed\n");
     6fa:	00001517          	auipc	a0,0x1
     6fe:	ea650513          	addi	a0,a0,-346 # 15a0 <malloc+0x272>
     702:	00001097          	auipc	ra,0x1
     706:	b6c080e7          	jalr	-1172(ra) # 126e <printf>
     70a:	bfd1                	j	6de <go+0x666>
        printf("grind: fork failed\n");
     70c:	00001517          	auipc	a0,0x1
     710:	e1450513          	addi	a0,a0,-492 # 1520 <malloc+0x1f2>
     714:	00001097          	auipc	ra,0x1
     718:	b5a080e7          	jalr	-1190(ra) # 126e <printf>
        exit(1);
     71c:	4505                	li	a0,1
     71e:	00000097          	auipc	ra,0x0
     722:	7ba080e7          	jalr	1978(ra) # ed8 <exit>
      int pid = fork();
     726:	00000097          	auipc	ra,0x0
     72a:	7aa080e7          	jalr	1962(ra) # ed0 <fork>
      if(pid == 0){
     72e:	c909                	beqz	a0,740 <go+0x6c8>
      } else if(pid < 0){
     730:	06054f63          	bltz	a0,7ae <go+0x736>
      wait(0);
     734:	4501                	li	a0,0
     736:	00000097          	auipc	ra,0x0
     73a:	7aa080e7          	jalr	1962(ra) # ee0 <wait>
     73e:	b2d5                	j	122 <go+0xaa>
        unlink("a");
     740:	00001517          	auipc	a0,0x1
     744:	dc050513          	addi	a0,a0,-576 # 1500 <malloc+0x1d2>
     748:	00000097          	auipc	ra,0x0
     74c:	7e0080e7          	jalr	2016(ra) # f28 <unlink>
        mkdir("a");
     750:	00001517          	auipc	a0,0x1
     754:	db050513          	addi	a0,a0,-592 # 1500 <malloc+0x1d2>
     758:	00000097          	auipc	ra,0x0
     75c:	7e8080e7          	jalr	2024(ra) # f40 <mkdir>
        chdir("a");
     760:	00001517          	auipc	a0,0x1
     764:	da050513          	addi	a0,a0,-608 # 1500 <malloc+0x1d2>
     768:	00000097          	auipc	ra,0x0
     76c:	7e0080e7          	jalr	2016(ra) # f48 <chdir>
        unlink("../a");
     770:	00001517          	auipc	a0,0x1
     774:	cf850513          	addi	a0,a0,-776 # 1468 <malloc+0x13a>
     778:	00000097          	auipc	ra,0x0
     77c:	7b0080e7          	jalr	1968(ra) # f28 <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     780:	20200593          	li	a1,514
     784:	00001517          	auipc	a0,0x1
     788:	df450513          	addi	a0,a0,-524 # 1578 <malloc+0x24a>
     78c:	00000097          	auipc	ra,0x0
     790:	78c080e7          	jalr	1932(ra) # f18 <open>
        unlink("x");
     794:	00001517          	auipc	a0,0x1
     798:	de450513          	addi	a0,a0,-540 # 1578 <malloc+0x24a>
     79c:	00000097          	auipc	ra,0x0
     7a0:	78c080e7          	jalr	1932(ra) # f28 <unlink>
        exit(0);
     7a4:	4501                	li	a0,0
     7a6:	00000097          	auipc	ra,0x0
     7aa:	732080e7          	jalr	1842(ra) # ed8 <exit>
        printf("grind: fork failed\n");
     7ae:	00001517          	auipc	a0,0x1
     7b2:	d7250513          	addi	a0,a0,-654 # 1520 <malloc+0x1f2>
     7b6:	00001097          	auipc	ra,0x1
     7ba:	ab8080e7          	jalr	-1352(ra) # 126e <printf>
        exit(1);
     7be:	4505                	li	a0,1
     7c0:	00000097          	auipc	ra,0x0
     7c4:	718080e7          	jalr	1816(ra) # ed8 <exit>
      unlink("c");
     7c8:	00001517          	auipc	a0,0x1
     7cc:	df850513          	addi	a0,a0,-520 # 15c0 <malloc+0x292>
     7d0:	00000097          	auipc	ra,0x0
     7d4:	758080e7          	jalr	1880(ra) # f28 <unlink>
      int fd1 = open("c", O_CREATE|O_RDWR);
     7d8:	20200593          	li	a1,514
     7dc:	00001517          	auipc	a0,0x1
     7e0:	de450513          	addi	a0,a0,-540 # 15c0 <malloc+0x292>
     7e4:	00000097          	auipc	ra,0x0
     7e8:	734080e7          	jalr	1844(ra) # f18 <open>
     7ec:	8b2a                	mv	s6,a0
      if(fd1 < 0){
     7ee:	04054f63          	bltz	a0,84c <go+0x7d4>
      if(write(fd1, "x", 1) != 1){
     7f2:	4605                	li	a2,1
     7f4:	00001597          	auipc	a1,0x1
     7f8:	d8458593          	addi	a1,a1,-636 # 1578 <malloc+0x24a>
     7fc:	00000097          	auipc	ra,0x0
     800:	6fc080e7          	jalr	1788(ra) # ef8 <write>
     804:	4785                	li	a5,1
     806:	06f51063          	bne	a0,a5,866 <go+0x7ee>
      if(fstat(fd1, &st) != 0){
     80a:	fa840593          	addi	a1,s0,-88
     80e:	855a                	mv	a0,s6
     810:	00000097          	auipc	ra,0x0
     814:	720080e7          	jalr	1824(ra) # f30 <fstat>
     818:	e525                	bnez	a0,880 <go+0x808>
      if(st.size != 1){
     81a:	fb843583          	ld	a1,-72(s0)
     81e:	4785                	li	a5,1
     820:	06f59d63          	bne	a1,a5,89a <go+0x822>
      if(st.ino > 200){
     824:	fac42583          	lw	a1,-84(s0)
     828:	0c800793          	li	a5,200
     82c:	08b7e563          	bltu	a5,a1,8b6 <go+0x83e>
      close(fd1);
     830:	855a                	mv	a0,s6
     832:	00000097          	auipc	ra,0x0
     836:	6ce080e7          	jalr	1742(ra) # f00 <close>
      unlink("c");
     83a:	00001517          	auipc	a0,0x1
     83e:	d8650513          	addi	a0,a0,-634 # 15c0 <malloc+0x292>
     842:	00000097          	auipc	ra,0x0
     846:	6e6080e7          	jalr	1766(ra) # f28 <unlink>
     84a:	b8e1                	j	122 <go+0xaa>
        printf("grind: create c failed\n");
     84c:	00001517          	auipc	a0,0x1
     850:	d7c50513          	addi	a0,a0,-644 # 15c8 <malloc+0x29a>
     854:	00001097          	auipc	ra,0x1
     858:	a1a080e7          	jalr	-1510(ra) # 126e <printf>
        exit(1);
     85c:	4505                	li	a0,1
     85e:	00000097          	auipc	ra,0x0
     862:	67a080e7          	jalr	1658(ra) # ed8 <exit>
        printf("grind: write c failed\n");
     866:	00001517          	auipc	a0,0x1
     86a:	d7a50513          	addi	a0,a0,-646 # 15e0 <malloc+0x2b2>
     86e:	00001097          	auipc	ra,0x1
     872:	a00080e7          	jalr	-1536(ra) # 126e <printf>
        exit(1);
     876:	4505                	li	a0,1
     878:	00000097          	auipc	ra,0x0
     87c:	660080e7          	jalr	1632(ra) # ed8 <exit>
        printf("grind: fstat failed\n");
     880:	00001517          	auipc	a0,0x1
     884:	d7850513          	addi	a0,a0,-648 # 15f8 <malloc+0x2ca>
     888:	00001097          	auipc	ra,0x1
     88c:	9e6080e7          	jalr	-1562(ra) # 126e <printf>
        exit(1);
     890:	4505                	li	a0,1
     892:	00000097          	auipc	ra,0x0
     896:	646080e7          	jalr	1606(ra) # ed8 <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     89a:	2581                	sext.w	a1,a1
     89c:	00001517          	auipc	a0,0x1
     8a0:	d7450513          	addi	a0,a0,-652 # 1610 <malloc+0x2e2>
     8a4:	00001097          	auipc	ra,0x1
     8a8:	9ca080e7          	jalr	-1590(ra) # 126e <printf>
        exit(1);
     8ac:	4505                	li	a0,1
     8ae:	00000097          	auipc	ra,0x0
     8b2:	62a080e7          	jalr	1578(ra) # ed8 <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     8b6:	00001517          	auipc	a0,0x1
     8ba:	d8250513          	addi	a0,a0,-638 # 1638 <malloc+0x30a>
     8be:	00001097          	auipc	ra,0x1
     8c2:	9b0080e7          	jalr	-1616(ra) # 126e <printf>
        exit(1);
     8c6:	4505                	li	a0,1
     8c8:	00000097          	auipc	ra,0x0
     8cc:	610080e7          	jalr	1552(ra) # ed8 <exit>
        fprintf(2, "grind: pipe failed\n");
     8d0:	00001597          	auipc	a1,0x1
     8d4:	c9058593          	addi	a1,a1,-880 # 1560 <malloc+0x232>
     8d8:	4509                	li	a0,2
     8da:	00001097          	auipc	ra,0x1
     8de:	966080e7          	jalr	-1690(ra) # 1240 <fprintf>
        exit(1);
     8e2:	4505                	li	a0,1
     8e4:	00000097          	auipc	ra,0x0
     8e8:	5f4080e7          	jalr	1524(ra) # ed8 <exit>
        fprintf(2, "grind: pipe failed\n");
     8ec:	00001597          	auipc	a1,0x1
     8f0:	c7458593          	addi	a1,a1,-908 # 1560 <malloc+0x232>
     8f4:	4509                	li	a0,2
     8f6:	00001097          	auipc	ra,0x1
     8fa:	94a080e7          	jalr	-1718(ra) # 1240 <fprintf>
        exit(1);
     8fe:	4505                	li	a0,1
     900:	00000097          	auipc	ra,0x0
     904:	5d8080e7          	jalr	1496(ra) # ed8 <exit>
        close(bb[0]);
     908:	fa042503          	lw	a0,-96(s0)
     90c:	00000097          	auipc	ra,0x0
     910:	5f4080e7          	jalr	1524(ra) # f00 <close>
        close(bb[1]);
     914:	fa442503          	lw	a0,-92(s0)
     918:	00000097          	auipc	ra,0x0
     91c:	5e8080e7          	jalr	1512(ra) # f00 <close>
        close(aa[0]);
     920:	f9842503          	lw	a0,-104(s0)
     924:	00000097          	auipc	ra,0x0
     928:	5dc080e7          	jalr	1500(ra) # f00 <close>
        close(1);
     92c:	4505                	li	a0,1
     92e:	00000097          	auipc	ra,0x0
     932:	5d2080e7          	jalr	1490(ra) # f00 <close>
        if(dup(aa[1]) != 1){
     936:	f9c42503          	lw	a0,-100(s0)
     93a:	00000097          	auipc	ra,0x0
     93e:	616080e7          	jalr	1558(ra) # f50 <dup>
     942:	4785                	li	a5,1
     944:	02f50063          	beq	a0,a5,964 <go+0x8ec>
          fprintf(2, "grind: dup failed\n");
     948:	00001597          	auipc	a1,0x1
     94c:	d1858593          	addi	a1,a1,-744 # 1660 <malloc+0x332>
     950:	4509                	li	a0,2
     952:	00001097          	auipc	ra,0x1
     956:	8ee080e7          	jalr	-1810(ra) # 1240 <fprintf>
          exit(1);
     95a:	4505                	li	a0,1
     95c:	00000097          	auipc	ra,0x0
     960:	57c080e7          	jalr	1404(ra) # ed8 <exit>
        close(aa[1]);
     964:	f9c42503          	lw	a0,-100(s0)
     968:	00000097          	auipc	ra,0x0
     96c:	598080e7          	jalr	1432(ra) # f00 <close>
        char *args[3] = { "echo", "hi", 0 };
     970:	00001797          	auipc	a5,0x1
     974:	d0878793          	addi	a5,a5,-760 # 1678 <malloc+0x34a>
     978:	faf43423          	sd	a5,-88(s0)
     97c:	00001797          	auipc	a5,0x1
     980:	d0478793          	addi	a5,a5,-764 # 1680 <malloc+0x352>
     984:	faf43823          	sd	a5,-80(s0)
     988:	fa043c23          	sd	zero,-72(s0)
        exec("grindir/../echo", args);
     98c:	fa840593          	addi	a1,s0,-88
     990:	00001517          	auipc	a0,0x1
     994:	cf850513          	addi	a0,a0,-776 # 1688 <malloc+0x35a>
     998:	00000097          	auipc	ra,0x0
     99c:	578080e7          	jalr	1400(ra) # f10 <exec>
        fprintf(2, "grind: echo: not found\n");
     9a0:	00001597          	auipc	a1,0x1
     9a4:	cf858593          	addi	a1,a1,-776 # 1698 <malloc+0x36a>
     9a8:	4509                	li	a0,2
     9aa:	00001097          	auipc	ra,0x1
     9ae:	896080e7          	jalr	-1898(ra) # 1240 <fprintf>
        exit(2);
     9b2:	4509                	li	a0,2
     9b4:	00000097          	auipc	ra,0x0
     9b8:	524080e7          	jalr	1316(ra) # ed8 <exit>
        fprintf(2, "grind: fork failed\n");
     9bc:	00001597          	auipc	a1,0x1
     9c0:	b6458593          	addi	a1,a1,-1180 # 1520 <malloc+0x1f2>
     9c4:	4509                	li	a0,2
     9c6:	00001097          	auipc	ra,0x1
     9ca:	87a080e7          	jalr	-1926(ra) # 1240 <fprintf>
        exit(3);
     9ce:	450d                	li	a0,3
     9d0:	00000097          	auipc	ra,0x0
     9d4:	508080e7          	jalr	1288(ra) # ed8 <exit>
        close(aa[1]);
     9d8:	f9c42503          	lw	a0,-100(s0)
     9dc:	00000097          	auipc	ra,0x0
     9e0:	524080e7          	jalr	1316(ra) # f00 <close>
        close(bb[0]);
     9e4:	fa042503          	lw	a0,-96(s0)
     9e8:	00000097          	auipc	ra,0x0
     9ec:	518080e7          	jalr	1304(ra) # f00 <close>
        close(0);
     9f0:	4501                	li	a0,0
     9f2:	00000097          	auipc	ra,0x0
     9f6:	50e080e7          	jalr	1294(ra) # f00 <close>
        if(dup(aa[0]) != 0){
     9fa:	f9842503          	lw	a0,-104(s0)
     9fe:	00000097          	auipc	ra,0x0
     a02:	552080e7          	jalr	1362(ra) # f50 <dup>
     a06:	cd19                	beqz	a0,a24 <go+0x9ac>
          fprintf(2, "grind: dup failed\n");
     a08:	00001597          	auipc	a1,0x1
     a0c:	c5858593          	addi	a1,a1,-936 # 1660 <malloc+0x332>
     a10:	4509                	li	a0,2
     a12:	00001097          	auipc	ra,0x1
     a16:	82e080e7          	jalr	-2002(ra) # 1240 <fprintf>
          exit(4);
     a1a:	4511                	li	a0,4
     a1c:	00000097          	auipc	ra,0x0
     a20:	4bc080e7          	jalr	1212(ra) # ed8 <exit>
        close(aa[0]);
     a24:	f9842503          	lw	a0,-104(s0)
     a28:	00000097          	auipc	ra,0x0
     a2c:	4d8080e7          	jalr	1240(ra) # f00 <close>
        close(1);
     a30:	4505                	li	a0,1
     a32:	00000097          	auipc	ra,0x0
     a36:	4ce080e7          	jalr	1230(ra) # f00 <close>
        if(dup(bb[1]) != 1){
     a3a:	fa442503          	lw	a0,-92(s0)
     a3e:	00000097          	auipc	ra,0x0
     a42:	512080e7          	jalr	1298(ra) # f50 <dup>
     a46:	4785                	li	a5,1
     a48:	02f50063          	beq	a0,a5,a68 <go+0x9f0>
          fprintf(2, "grind: dup failed\n");
     a4c:	00001597          	auipc	a1,0x1
     a50:	c1458593          	addi	a1,a1,-1004 # 1660 <malloc+0x332>
     a54:	4509                	li	a0,2
     a56:	00000097          	auipc	ra,0x0
     a5a:	7ea080e7          	jalr	2026(ra) # 1240 <fprintf>
          exit(5);
     a5e:	4515                	li	a0,5
     a60:	00000097          	auipc	ra,0x0
     a64:	478080e7          	jalr	1144(ra) # ed8 <exit>
        close(bb[1]);
     a68:	fa442503          	lw	a0,-92(s0)
     a6c:	00000097          	auipc	ra,0x0
     a70:	494080e7          	jalr	1172(ra) # f00 <close>
        char *args[2] = { "cat", 0 };
     a74:	00001797          	auipc	a5,0x1
     a78:	c3c78793          	addi	a5,a5,-964 # 16b0 <malloc+0x382>
     a7c:	faf43423          	sd	a5,-88(s0)
     a80:	fa043823          	sd	zero,-80(s0)
        exec("/cat", args);
     a84:	fa840593          	addi	a1,s0,-88
     a88:	00001517          	auipc	a0,0x1
     a8c:	c3050513          	addi	a0,a0,-976 # 16b8 <malloc+0x38a>
     a90:	00000097          	auipc	ra,0x0
     a94:	480080e7          	jalr	1152(ra) # f10 <exec>
        fprintf(2, "grind: cat: not found\n");
     a98:	00001597          	auipc	a1,0x1
     a9c:	c2858593          	addi	a1,a1,-984 # 16c0 <malloc+0x392>
     aa0:	4509                	li	a0,2
     aa2:	00000097          	auipc	ra,0x0
     aa6:	79e080e7          	jalr	1950(ra) # 1240 <fprintf>
        exit(6);
     aaa:	4519                	li	a0,6
     aac:	00000097          	auipc	ra,0x0
     ab0:	42c080e7          	jalr	1068(ra) # ed8 <exit>
        fprintf(2, "grind: fork failed\n");
     ab4:	00001597          	auipc	a1,0x1
     ab8:	a6c58593          	addi	a1,a1,-1428 # 1520 <malloc+0x1f2>
     abc:	4509                	li	a0,2
     abe:	00000097          	auipc	ra,0x0
     ac2:	782080e7          	jalr	1922(ra) # 1240 <fprintf>
        exit(7);
     ac6:	451d                	li	a0,7
     ac8:	00000097          	auipc	ra,0x0
     acc:	410080e7          	jalr	1040(ra) # ed8 <exit>

0000000000000ad0 <iter>:
  }
}

void
iter()
{
     ad0:	7179                	addi	sp,sp,-48
     ad2:	f406                	sd	ra,40(sp)
     ad4:	f022                	sd	s0,32(sp)
     ad6:	ec26                	sd	s1,24(sp)
     ad8:	e84a                	sd	s2,16(sp)
     ada:	1800                	addi	s0,sp,48
  unlink("a");
     adc:	00001517          	auipc	a0,0x1
     ae0:	a2450513          	addi	a0,a0,-1500 # 1500 <malloc+0x1d2>
     ae4:	00000097          	auipc	ra,0x0
     ae8:	444080e7          	jalr	1092(ra) # f28 <unlink>
  unlink("b");
     aec:	00001517          	auipc	a0,0x1
     af0:	9c450513          	addi	a0,a0,-1596 # 14b0 <malloc+0x182>
     af4:	00000097          	auipc	ra,0x0
     af8:	434080e7          	jalr	1076(ra) # f28 <unlink>
  
  int pid1 = fork();
     afc:	00000097          	auipc	ra,0x0
     b00:	3d4080e7          	jalr	980(ra) # ed0 <fork>
  if(pid1 < 0){
     b04:	02054163          	bltz	a0,b26 <iter+0x56>
     b08:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     b0a:	e91d                	bnez	a0,b40 <iter+0x70>
    rand_next ^= 31;
     b0c:	00001717          	auipc	a4,0x1
     b10:	4f470713          	addi	a4,a4,1268 # 2000 <rand_next>
     b14:	631c                	ld	a5,0(a4)
     b16:	01f7c793          	xori	a5,a5,31
     b1a:	e31c                	sd	a5,0(a4)
    go(0);
     b1c:	4501                	li	a0,0
     b1e:	fffff097          	auipc	ra,0xfffff
     b22:	55a080e7          	jalr	1370(ra) # 78 <go>
    printf("grind: fork failed\n");
     b26:	00001517          	auipc	a0,0x1
     b2a:	9fa50513          	addi	a0,a0,-1542 # 1520 <malloc+0x1f2>
     b2e:	00000097          	auipc	ra,0x0
     b32:	740080e7          	jalr	1856(ra) # 126e <printf>
    exit(1);
     b36:	4505                	li	a0,1
     b38:	00000097          	auipc	ra,0x0
     b3c:	3a0080e7          	jalr	928(ra) # ed8 <exit>
    exit(0);
  }

  int pid2 = fork();
     b40:	00000097          	auipc	ra,0x0
     b44:	390080e7          	jalr	912(ra) # ed0 <fork>
     b48:	892a                	mv	s2,a0
  if(pid2 < 0){
     b4a:	02054263          	bltz	a0,b6e <iter+0x9e>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     b4e:	ed0d                	bnez	a0,b88 <iter+0xb8>
    rand_next ^= 7177;
     b50:	00001697          	auipc	a3,0x1
     b54:	4b068693          	addi	a3,a3,1200 # 2000 <rand_next>
     b58:	629c                	ld	a5,0(a3)
     b5a:	6709                	lui	a4,0x2
     b5c:	c0970713          	addi	a4,a4,-1015 # 1c09 <digits+0x501>
     b60:	8fb9                	xor	a5,a5,a4
     b62:	e29c                	sd	a5,0(a3)
    go(1);
     b64:	4505                	li	a0,1
     b66:	fffff097          	auipc	ra,0xfffff
     b6a:	512080e7          	jalr	1298(ra) # 78 <go>
    printf("grind: fork failed\n");
     b6e:	00001517          	auipc	a0,0x1
     b72:	9b250513          	addi	a0,a0,-1614 # 1520 <malloc+0x1f2>
     b76:	00000097          	auipc	ra,0x0
     b7a:	6f8080e7          	jalr	1784(ra) # 126e <printf>
    exit(1);
     b7e:	4505                	li	a0,1
     b80:	00000097          	auipc	ra,0x0
     b84:	358080e7          	jalr	856(ra) # ed8 <exit>
    exit(0);
  }

  int st1 = -1;
     b88:	57fd                	li	a5,-1
     b8a:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     b8e:	fdc40513          	addi	a0,s0,-36
     b92:	00000097          	auipc	ra,0x0
     b96:	34e080e7          	jalr	846(ra) # ee0 <wait>
  if(st1 != 0){
     b9a:	fdc42783          	lw	a5,-36(s0)
     b9e:	ef99                	bnez	a5,bbc <iter+0xec>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     ba0:	57fd                	li	a5,-1
     ba2:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
     ba6:	fd840513          	addi	a0,s0,-40
     baa:	00000097          	auipc	ra,0x0
     bae:	336080e7          	jalr	822(ra) # ee0 <wait>

  exit(0);
     bb2:	4501                	li	a0,0
     bb4:	00000097          	auipc	ra,0x0
     bb8:	324080e7          	jalr	804(ra) # ed8 <exit>
    kill(pid1);
     bbc:	8526                	mv	a0,s1
     bbe:	00000097          	auipc	ra,0x0
     bc2:	34a080e7          	jalr	842(ra) # f08 <kill>
    kill(pid2);
     bc6:	854a                	mv	a0,s2
     bc8:	00000097          	auipc	ra,0x0
     bcc:	340080e7          	jalr	832(ra) # f08 <kill>
     bd0:	bfc1                	j	ba0 <iter+0xd0>

0000000000000bd2 <main>:
}

int
main()
{
     bd2:	1101                	addi	sp,sp,-32
     bd4:	ec06                	sd	ra,24(sp)
     bd6:	e822                	sd	s0,16(sp)
     bd8:	e426                	sd	s1,8(sp)
     bda:	1000                	addi	s0,sp,32
    }
    if(pid > 0){
      wait(0);
    }
    sleep(20);
    rand_next += 1;
     bdc:	00001497          	auipc	s1,0x1
     be0:	42448493          	addi	s1,s1,1060 # 2000 <rand_next>
     be4:	a829                	j	bfe <main+0x2c>
      iter();
     be6:	00000097          	auipc	ra,0x0
     bea:	eea080e7          	jalr	-278(ra) # ad0 <iter>
    sleep(20);
     bee:	4551                	li	a0,20
     bf0:	00000097          	auipc	ra,0x0
     bf4:	378080e7          	jalr	888(ra) # f68 <sleep>
    rand_next += 1;
     bf8:	609c                	ld	a5,0(s1)
     bfa:	0785                	addi	a5,a5,1
     bfc:	e09c                	sd	a5,0(s1)
    int pid = fork();
     bfe:	00000097          	auipc	ra,0x0
     c02:	2d2080e7          	jalr	722(ra) # ed0 <fork>
    if(pid == 0){
     c06:	d165                	beqz	a0,be6 <main+0x14>
    if(pid > 0){
     c08:	fea053e3          	blez	a0,bee <main+0x1c>
      wait(0);
     c0c:	4501                	li	a0,0
     c0e:	00000097          	auipc	ra,0x0
     c12:	2d2080e7          	jalr	722(ra) # ee0 <wait>
     c16:	bfe1                	j	bee <main+0x1c>

0000000000000c18 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
     c18:	1141                	addi	sp,sp,-16
     c1a:	e406                	sd	ra,8(sp)
     c1c:	e022                	sd	s0,0(sp)
     c1e:	0800                	addi	s0,sp,16
  extern int main();
  main();
     c20:	00000097          	auipc	ra,0x0
     c24:	fb2080e7          	jalr	-78(ra) # bd2 <main>
  exit(0);
     c28:	4501                	li	a0,0
     c2a:	00000097          	auipc	ra,0x0
     c2e:	2ae080e7          	jalr	686(ra) # ed8 <exit>

0000000000000c32 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     c32:	1141                	addi	sp,sp,-16
     c34:	e422                	sd	s0,8(sp)
     c36:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     c38:	87aa                	mv	a5,a0
     c3a:	0585                	addi	a1,a1,1
     c3c:	0785                	addi	a5,a5,1
     c3e:	fff5c703          	lbu	a4,-1(a1)
     c42:	fee78fa3          	sb	a4,-1(a5)
     c46:	fb75                	bnez	a4,c3a <strcpy+0x8>
    ;
  return os;
}
     c48:	6422                	ld	s0,8(sp)
     c4a:	0141                	addi	sp,sp,16
     c4c:	8082                	ret

0000000000000c4e <strcmp>:

int
strcmp(const char *p, const char *q)
{
     c4e:	1141                	addi	sp,sp,-16
     c50:	e422                	sd	s0,8(sp)
     c52:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     c54:	00054783          	lbu	a5,0(a0)
     c58:	cf91                	beqz	a5,c74 <strcmp+0x26>
     c5a:	0005c703          	lbu	a4,0(a1)
     c5e:	00f71b63          	bne	a4,a5,c74 <strcmp+0x26>
    p++, q++;
     c62:	0505                	addi	a0,a0,1
     c64:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     c66:	00054783          	lbu	a5,0(a0)
     c6a:	c789                	beqz	a5,c74 <strcmp+0x26>
     c6c:	0005c703          	lbu	a4,0(a1)
     c70:	fef709e3          	beq	a4,a5,c62 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
     c74:	0005c503          	lbu	a0,0(a1)
}
     c78:	40a7853b          	subw	a0,a5,a0
     c7c:	6422                	ld	s0,8(sp)
     c7e:	0141                	addi	sp,sp,16
     c80:	8082                	ret

0000000000000c82 <strlen>:

uint
strlen(const char *s)
{
     c82:	1141                	addi	sp,sp,-16
     c84:	e422                	sd	s0,8(sp)
     c86:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     c88:	00054783          	lbu	a5,0(a0)
     c8c:	cf91                	beqz	a5,ca8 <strlen+0x26>
     c8e:	0505                	addi	a0,a0,1
     c90:	87aa                	mv	a5,a0
     c92:	4685                	li	a3,1
     c94:	9e89                	subw	a3,a3,a0
    ;
     c96:	00f6853b          	addw	a0,a3,a5
     c9a:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
     c9c:	fff7c703          	lbu	a4,-1(a5)
     ca0:	fb7d                	bnez	a4,c96 <strlen+0x14>
  return n;
}
     ca2:	6422                	ld	s0,8(sp)
     ca4:	0141                	addi	sp,sp,16
     ca6:	8082                	ret
  for(n = 0; s[n]; n++)
     ca8:	4501                	li	a0,0
     caa:	bfe5                	j	ca2 <strlen+0x20>

0000000000000cac <memset>:

void*
memset(void *dst, int c, uint n)
{
     cac:	1141                	addi	sp,sp,-16
     cae:	e422                	sd	s0,8(sp)
     cb0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     cb2:	ce09                	beqz	a2,ccc <memset+0x20>
     cb4:	87aa                	mv	a5,a0
     cb6:	fff6071b          	addiw	a4,a2,-1
     cba:	1702                	slli	a4,a4,0x20
     cbc:	9301                	srli	a4,a4,0x20
     cbe:	0705                	addi	a4,a4,1
     cc0:	972a                	add	a4,a4,a0
    cdst[i] = c;
     cc2:	00b78023          	sb	a1,0(a5)
     cc6:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
     cc8:	fee79de3          	bne	a5,a4,cc2 <memset+0x16>
  }
  return dst;
}
     ccc:	6422                	ld	s0,8(sp)
     cce:	0141                	addi	sp,sp,16
     cd0:	8082                	ret

0000000000000cd2 <strchr>:

char*
strchr(const char *s, char c)
{
     cd2:	1141                	addi	sp,sp,-16
     cd4:	e422                	sd	s0,8(sp)
     cd6:	0800                	addi	s0,sp,16
  for(; *s; s++)
     cd8:	00054783          	lbu	a5,0(a0)
     cdc:	cf91                	beqz	a5,cf8 <strchr+0x26>
    if(*s == c)
     cde:	00f58a63          	beq	a1,a5,cf2 <strchr+0x20>
  for(; *s; s++)
     ce2:	0505                	addi	a0,a0,1
     ce4:	00054783          	lbu	a5,0(a0)
     ce8:	c781                	beqz	a5,cf0 <strchr+0x1e>
    if(*s == c)
     cea:	feb79ce3          	bne	a5,a1,ce2 <strchr+0x10>
     cee:	a011                	j	cf2 <strchr+0x20>
      return (char*)s;
  return 0;
     cf0:	4501                	li	a0,0
}
     cf2:	6422                	ld	s0,8(sp)
     cf4:	0141                	addi	sp,sp,16
     cf6:	8082                	ret
  return 0;
     cf8:	4501                	li	a0,0
     cfa:	bfe5                	j	cf2 <strchr+0x20>

0000000000000cfc <gets>:

char*
gets(char *buf, int max)
{
     cfc:	711d                	addi	sp,sp,-96
     cfe:	ec86                	sd	ra,88(sp)
     d00:	e8a2                	sd	s0,80(sp)
     d02:	e4a6                	sd	s1,72(sp)
     d04:	e0ca                	sd	s2,64(sp)
     d06:	fc4e                	sd	s3,56(sp)
     d08:	f852                	sd	s4,48(sp)
     d0a:	f456                	sd	s5,40(sp)
     d0c:	f05a                	sd	s6,32(sp)
     d0e:	ec5e                	sd	s7,24(sp)
     d10:	1080                	addi	s0,sp,96
     d12:	8baa                	mv	s7,a0
     d14:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     d16:	892a                	mv	s2,a0
     d18:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     d1a:	4aa9                	li	s5,10
     d1c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     d1e:	0019849b          	addiw	s1,s3,1
     d22:	0344d863          	bge	s1,s4,d52 <gets+0x56>
    cc = read(0, &c, 1);
     d26:	4605                	li	a2,1
     d28:	faf40593          	addi	a1,s0,-81
     d2c:	4501                	li	a0,0
     d2e:	00000097          	auipc	ra,0x0
     d32:	1c2080e7          	jalr	450(ra) # ef0 <read>
    if(cc < 1)
     d36:	00a05e63          	blez	a0,d52 <gets+0x56>
    buf[i++] = c;
     d3a:	faf44783          	lbu	a5,-81(s0)
     d3e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     d42:	01578763          	beq	a5,s5,d50 <gets+0x54>
     d46:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
     d48:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
     d4a:	fd679ae3          	bne	a5,s6,d1e <gets+0x22>
     d4e:	a011                	j	d52 <gets+0x56>
  for(i=0; i+1 < max; ){
     d50:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     d52:	99de                	add	s3,s3,s7
     d54:	00098023          	sb	zero,0(s3)
  return buf;
}
     d58:	855e                	mv	a0,s7
     d5a:	60e6                	ld	ra,88(sp)
     d5c:	6446                	ld	s0,80(sp)
     d5e:	64a6                	ld	s1,72(sp)
     d60:	6906                	ld	s2,64(sp)
     d62:	79e2                	ld	s3,56(sp)
     d64:	7a42                	ld	s4,48(sp)
     d66:	7aa2                	ld	s5,40(sp)
     d68:	7b02                	ld	s6,32(sp)
     d6a:	6be2                	ld	s7,24(sp)
     d6c:	6125                	addi	sp,sp,96
     d6e:	8082                	ret

0000000000000d70 <stat>:

int
stat(const char *n, struct stat *st)
{
     d70:	1101                	addi	sp,sp,-32
     d72:	ec06                	sd	ra,24(sp)
     d74:	e822                	sd	s0,16(sp)
     d76:	e426                	sd	s1,8(sp)
     d78:	e04a                	sd	s2,0(sp)
     d7a:	1000                	addi	s0,sp,32
     d7c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     d7e:	4581                	li	a1,0
     d80:	00000097          	auipc	ra,0x0
     d84:	198080e7          	jalr	408(ra) # f18 <open>
  if(fd < 0)
     d88:	02054563          	bltz	a0,db2 <stat+0x42>
     d8c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     d8e:	85ca                	mv	a1,s2
     d90:	00000097          	auipc	ra,0x0
     d94:	1a0080e7          	jalr	416(ra) # f30 <fstat>
     d98:	892a                	mv	s2,a0
  close(fd);
     d9a:	8526                	mv	a0,s1
     d9c:	00000097          	auipc	ra,0x0
     da0:	164080e7          	jalr	356(ra) # f00 <close>
  return r;
}
     da4:	854a                	mv	a0,s2
     da6:	60e2                	ld	ra,24(sp)
     da8:	6442                	ld	s0,16(sp)
     daa:	64a2                	ld	s1,8(sp)
     dac:	6902                	ld	s2,0(sp)
     dae:	6105                	addi	sp,sp,32
     db0:	8082                	ret
    return -1;
     db2:	597d                	li	s2,-1
     db4:	bfc5                	j	da4 <stat+0x34>

0000000000000db6 <atoi>:

int
atoi(const char *s)
{
     db6:	1141                	addi	sp,sp,-16
     db8:	e422                	sd	s0,8(sp)
     dba:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     dbc:	00054683          	lbu	a3,0(a0)
     dc0:	fd06879b          	addiw	a5,a3,-48
     dc4:	0ff7f793          	andi	a5,a5,255
     dc8:	4725                	li	a4,9
     dca:	02f76963          	bltu	a4,a5,dfc <atoi+0x46>
     dce:	862a                	mv	a2,a0
  n = 0;
     dd0:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
     dd2:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
     dd4:	0605                	addi	a2,a2,1
     dd6:	0025179b          	slliw	a5,a0,0x2
     dda:	9fa9                	addw	a5,a5,a0
     ddc:	0017979b          	slliw	a5,a5,0x1
     de0:	9fb5                	addw	a5,a5,a3
     de2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     de6:	00064683          	lbu	a3,0(a2)
     dea:	fd06871b          	addiw	a4,a3,-48
     dee:	0ff77713          	andi	a4,a4,255
     df2:	fee5f1e3          	bgeu	a1,a4,dd4 <atoi+0x1e>
  return n;
}
     df6:	6422                	ld	s0,8(sp)
     df8:	0141                	addi	sp,sp,16
     dfa:	8082                	ret
  n = 0;
     dfc:	4501                	li	a0,0
     dfe:	bfe5                	j	df6 <atoi+0x40>

0000000000000e00 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     e00:	1141                	addi	sp,sp,-16
     e02:	e422                	sd	s0,8(sp)
     e04:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     e06:	02b57663          	bgeu	a0,a1,e32 <memmove+0x32>
    while(n-- > 0)
     e0a:	02c05163          	blez	a2,e2c <memmove+0x2c>
     e0e:	fff6079b          	addiw	a5,a2,-1
     e12:	1782                	slli	a5,a5,0x20
     e14:	9381                	srli	a5,a5,0x20
     e16:	0785                	addi	a5,a5,1
     e18:	97aa                	add	a5,a5,a0
  dst = vdst;
     e1a:	872a                	mv	a4,a0
      *dst++ = *src++;
     e1c:	0585                	addi	a1,a1,1
     e1e:	0705                	addi	a4,a4,1
     e20:	fff5c683          	lbu	a3,-1(a1)
     e24:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     e28:	fee79ae3          	bne	a5,a4,e1c <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     e2c:	6422                	ld	s0,8(sp)
     e2e:	0141                	addi	sp,sp,16
     e30:	8082                	ret
    dst += n;
     e32:	00c50733          	add	a4,a0,a2
    src += n;
     e36:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     e38:	fec05ae3          	blez	a2,e2c <memmove+0x2c>
     e3c:	fff6079b          	addiw	a5,a2,-1
     e40:	1782                	slli	a5,a5,0x20
     e42:	9381                	srli	a5,a5,0x20
     e44:	fff7c793          	not	a5,a5
     e48:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     e4a:	15fd                	addi	a1,a1,-1
     e4c:	177d                	addi	a4,a4,-1
     e4e:	0005c683          	lbu	a3,0(a1)
     e52:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     e56:	fef71ae3          	bne	a4,a5,e4a <memmove+0x4a>
     e5a:	bfc9                	j	e2c <memmove+0x2c>

0000000000000e5c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     e5c:	1141                	addi	sp,sp,-16
     e5e:	e422                	sd	s0,8(sp)
     e60:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     e62:	ce15                	beqz	a2,e9e <memcmp+0x42>
     e64:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
     e68:	00054783          	lbu	a5,0(a0)
     e6c:	0005c703          	lbu	a4,0(a1)
     e70:	02e79063          	bne	a5,a4,e90 <memcmp+0x34>
     e74:	1682                	slli	a3,a3,0x20
     e76:	9281                	srli	a3,a3,0x20
     e78:	0685                	addi	a3,a3,1
     e7a:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
     e7c:	0505                	addi	a0,a0,1
    p2++;
     e7e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     e80:	00d50d63          	beq	a0,a3,e9a <memcmp+0x3e>
    if (*p1 != *p2) {
     e84:	00054783          	lbu	a5,0(a0)
     e88:	0005c703          	lbu	a4,0(a1)
     e8c:	fee788e3          	beq	a5,a4,e7c <memcmp+0x20>
      return *p1 - *p2;
     e90:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
     e94:	6422                	ld	s0,8(sp)
     e96:	0141                	addi	sp,sp,16
     e98:	8082                	ret
  return 0;
     e9a:	4501                	li	a0,0
     e9c:	bfe5                	j	e94 <memcmp+0x38>
     e9e:	4501                	li	a0,0
     ea0:	bfd5                	j	e94 <memcmp+0x38>

0000000000000ea2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     ea2:	1141                	addi	sp,sp,-16
     ea4:	e406                	sd	ra,8(sp)
     ea6:	e022                	sd	s0,0(sp)
     ea8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     eaa:	00000097          	auipc	ra,0x0
     eae:	f56080e7          	jalr	-170(ra) # e00 <memmove>
}
     eb2:	60a2                	ld	ra,8(sp)
     eb4:	6402                	ld	s0,0(sp)
     eb6:	0141                	addi	sp,sp,16
     eb8:	8082                	ret

0000000000000eba <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
     eba:	1141                	addi	sp,sp,-16
     ebc:	e422                	sd	s0,8(sp)
     ebe:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
     ec0:	040007b7          	lui	a5,0x4000
}
     ec4:	17f5                	addi	a5,a5,-3
     ec6:	07b2                	slli	a5,a5,0xc
     ec8:	4388                	lw	a0,0(a5)
     eca:	6422                	ld	s0,8(sp)
     ecc:	0141                	addi	sp,sp,16
     ece:	8082                	ret

0000000000000ed0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     ed0:	4885                	li	a7,1
 ecall
     ed2:	00000073          	ecall
 ret
     ed6:	8082                	ret

0000000000000ed8 <exit>:
.global exit
exit:
 li a7, SYS_exit
     ed8:	4889                	li	a7,2
 ecall
     eda:	00000073          	ecall
 ret
     ede:	8082                	ret

0000000000000ee0 <wait>:
.global wait
wait:
 li a7, SYS_wait
     ee0:	488d                	li	a7,3
 ecall
     ee2:	00000073          	ecall
 ret
     ee6:	8082                	ret

0000000000000ee8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     ee8:	4891                	li	a7,4
 ecall
     eea:	00000073          	ecall
 ret
     eee:	8082                	ret

0000000000000ef0 <read>:
.global read
read:
 li a7, SYS_read
     ef0:	4895                	li	a7,5
 ecall
     ef2:	00000073          	ecall
 ret
     ef6:	8082                	ret

0000000000000ef8 <write>:
.global write
write:
 li a7, SYS_write
     ef8:	48c1                	li	a7,16
 ecall
     efa:	00000073          	ecall
 ret
     efe:	8082                	ret

0000000000000f00 <close>:
.global close
close:
 li a7, SYS_close
     f00:	48d5                	li	a7,21
 ecall
     f02:	00000073          	ecall
 ret
     f06:	8082                	ret

0000000000000f08 <kill>:
.global kill
kill:
 li a7, SYS_kill
     f08:	4899                	li	a7,6
 ecall
     f0a:	00000073          	ecall
 ret
     f0e:	8082                	ret

0000000000000f10 <exec>:
.global exec
exec:
 li a7, SYS_exec
     f10:	489d                	li	a7,7
 ecall
     f12:	00000073          	ecall
 ret
     f16:	8082                	ret

0000000000000f18 <open>:
.global open
open:
 li a7, SYS_open
     f18:	48bd                	li	a7,15
 ecall
     f1a:	00000073          	ecall
 ret
     f1e:	8082                	ret

0000000000000f20 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     f20:	48c5                	li	a7,17
 ecall
     f22:	00000073          	ecall
 ret
     f26:	8082                	ret

0000000000000f28 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     f28:	48c9                	li	a7,18
 ecall
     f2a:	00000073          	ecall
 ret
     f2e:	8082                	ret

0000000000000f30 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     f30:	48a1                	li	a7,8
 ecall
     f32:	00000073          	ecall
 ret
     f36:	8082                	ret

0000000000000f38 <link>:
.global link
link:
 li a7, SYS_link
     f38:	48cd                	li	a7,19
 ecall
     f3a:	00000073          	ecall
 ret
     f3e:	8082                	ret

0000000000000f40 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     f40:	48d1                	li	a7,20
 ecall
     f42:	00000073          	ecall
 ret
     f46:	8082                	ret

0000000000000f48 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     f48:	48a5                	li	a7,9
 ecall
     f4a:	00000073          	ecall
 ret
     f4e:	8082                	ret

0000000000000f50 <dup>:
.global dup
dup:
 li a7, SYS_dup
     f50:	48a9                	li	a7,10
 ecall
     f52:	00000073          	ecall
 ret
     f56:	8082                	ret

0000000000000f58 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     f58:	48ad                	li	a7,11
 ecall
     f5a:	00000073          	ecall
 ret
     f5e:	8082                	ret

0000000000000f60 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     f60:	48b1                	li	a7,12
 ecall
     f62:	00000073          	ecall
 ret
     f66:	8082                	ret

0000000000000f68 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     f68:	48b5                	li	a7,13
 ecall
     f6a:	00000073          	ecall
 ret
     f6e:	8082                	ret

0000000000000f70 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     f70:	48b9                	li	a7,14
 ecall
     f72:	00000073          	ecall
 ret
     f76:	8082                	ret

0000000000000f78 <trace>:
.global trace
trace:
 li a7, SYS_trace
     f78:	48d9                	li	a7,22
 ecall
     f7a:	00000073          	ecall
 ret
     f7e:	8082                	ret

0000000000000f80 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
     f80:	48dd                	li	a7,23
 ecall
     f82:	00000073          	ecall
 ret
     f86:	8082                	ret

0000000000000f88 <connect>:
.global connect
connect:
 li a7, SYS_connect
     f88:	48f5                	li	a7,29
 ecall
     f8a:	00000073          	ecall
 ret
     f8e:	8082                	ret

0000000000000f90 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
     f90:	48f9                	li	a7,30
 ecall
     f92:	00000073          	ecall
 ret
     f96:	8082                	ret

0000000000000f98 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     f98:	1101                	addi	sp,sp,-32
     f9a:	ec06                	sd	ra,24(sp)
     f9c:	e822                	sd	s0,16(sp)
     f9e:	1000                	addi	s0,sp,32
     fa0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     fa4:	4605                	li	a2,1
     fa6:	fef40593          	addi	a1,s0,-17
     faa:	00000097          	auipc	ra,0x0
     fae:	f4e080e7          	jalr	-178(ra) # ef8 <write>
}
     fb2:	60e2                	ld	ra,24(sp)
     fb4:	6442                	ld	s0,16(sp)
     fb6:	6105                	addi	sp,sp,32
     fb8:	8082                	ret

0000000000000fba <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     fba:	7139                	addi	sp,sp,-64
     fbc:	fc06                	sd	ra,56(sp)
     fbe:	f822                	sd	s0,48(sp)
     fc0:	f426                	sd	s1,40(sp)
     fc2:	f04a                	sd	s2,32(sp)
     fc4:	ec4e                	sd	s3,24(sp)
     fc6:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     fc8:	c299                	beqz	a3,fce <printint+0x14>
     fca:	0005cd63          	bltz	a1,fe4 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     fce:	2581                	sext.w	a1,a1
  neg = 0;
     fd0:	4301                	li	t1,0
     fd2:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
     fd6:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
     fd8:	2601                	sext.w	a2,a2
     fda:	00000897          	auipc	a7,0x0
     fde:	72e88893          	addi	a7,a7,1838 # 1708 <digits>
     fe2:	a039                	j	ff0 <printint+0x36>
    x = -xx;
     fe4:	40b005bb          	negw	a1,a1
    neg = 1;
     fe8:	4305                	li	t1,1
    x = -xx;
     fea:	b7e5                	j	fd2 <printint+0x18>
  }while((x /= base) != 0);
     fec:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
     fee:	8836                	mv	a6,a3
     ff0:	0018069b          	addiw	a3,a6,1
     ff4:	02c5f7bb          	remuw	a5,a1,a2
     ff8:	1782                	slli	a5,a5,0x20
     ffa:	9381                	srli	a5,a5,0x20
     ffc:	97c6                	add	a5,a5,a7
     ffe:	0007c783          	lbu	a5,0(a5) # 4000000 <base+0x3ffdbf8>
    1002:	00f70023          	sb	a5,0(a4)
    1006:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
    1008:	02c5d7bb          	divuw	a5,a1,a2
    100c:	fec5f0e3          	bgeu	a1,a2,fec <printint+0x32>
  if(neg)
    1010:	00030b63          	beqz	t1,1026 <printint+0x6c>
    buf[i++] = '-';
    1014:	fd040793          	addi	a5,s0,-48
    1018:	96be                	add	a3,a3,a5
    101a:	02d00793          	li	a5,45
    101e:	fef68823          	sb	a5,-16(a3)
    1022:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
    1026:	02d05963          	blez	a3,1058 <printint+0x9e>
    102a:	89aa                	mv	s3,a0
    102c:	fc040793          	addi	a5,s0,-64
    1030:	00d784b3          	add	s1,a5,a3
    1034:	fff78913          	addi	s2,a5,-1
    1038:	9936                	add	s2,s2,a3
    103a:	36fd                	addiw	a3,a3,-1
    103c:	1682                	slli	a3,a3,0x20
    103e:	9281                	srli	a3,a3,0x20
    1040:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
    1044:	fff4c583          	lbu	a1,-1(s1)
    1048:	854e                	mv	a0,s3
    104a:	00000097          	auipc	ra,0x0
    104e:	f4e080e7          	jalr	-178(ra) # f98 <putc>
    1052:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
    1054:	ff2498e3          	bne	s1,s2,1044 <printint+0x8a>
}
    1058:	70e2                	ld	ra,56(sp)
    105a:	7442                	ld	s0,48(sp)
    105c:	74a2                	ld	s1,40(sp)
    105e:	7902                	ld	s2,32(sp)
    1060:	69e2                	ld	s3,24(sp)
    1062:	6121                	addi	sp,sp,64
    1064:	8082                	ret

0000000000001066 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    1066:	7119                	addi	sp,sp,-128
    1068:	fc86                	sd	ra,120(sp)
    106a:	f8a2                	sd	s0,112(sp)
    106c:	f4a6                	sd	s1,104(sp)
    106e:	f0ca                	sd	s2,96(sp)
    1070:	ecce                	sd	s3,88(sp)
    1072:	e8d2                	sd	s4,80(sp)
    1074:	e4d6                	sd	s5,72(sp)
    1076:	e0da                	sd	s6,64(sp)
    1078:	fc5e                	sd	s7,56(sp)
    107a:	f862                	sd	s8,48(sp)
    107c:	f466                	sd	s9,40(sp)
    107e:	f06a                	sd	s10,32(sp)
    1080:	ec6e                	sd	s11,24(sp)
    1082:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    1084:	0005c483          	lbu	s1,0(a1)
    1088:	18048d63          	beqz	s1,1222 <vprintf+0x1bc>
    108c:	8aaa                	mv	s5,a0
    108e:	8b32                	mv	s6,a2
    1090:	00158913          	addi	s2,a1,1
  state = 0;
    1094:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1096:	02500a13          	li	s4,37
      if(c == 'd'){
    109a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    109e:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    10a2:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    10a6:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    10aa:	00000b97          	auipc	s7,0x0
    10ae:	65eb8b93          	addi	s7,s7,1630 # 1708 <digits>
    10b2:	a839                	j	10d0 <vprintf+0x6a>
        putc(fd, c);
    10b4:	85a6                	mv	a1,s1
    10b6:	8556                	mv	a0,s5
    10b8:	00000097          	auipc	ra,0x0
    10bc:	ee0080e7          	jalr	-288(ra) # f98 <putc>
    10c0:	a019                	j	10c6 <vprintf+0x60>
    } else if(state == '%'){
    10c2:	01498f63          	beq	s3,s4,10e0 <vprintf+0x7a>
    10c6:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
    10c8:	fff94483          	lbu	s1,-1(s2)
    10cc:	14048b63          	beqz	s1,1222 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
    10d0:	0004879b          	sext.w	a5,s1
    if(state == 0){
    10d4:	fe0997e3          	bnez	s3,10c2 <vprintf+0x5c>
      if(c == '%'){
    10d8:	fd479ee3          	bne	a5,s4,10b4 <vprintf+0x4e>
        state = '%';
    10dc:	89be                	mv	s3,a5
    10de:	b7e5                	j	10c6 <vprintf+0x60>
      if(c == 'd'){
    10e0:	05878063          	beq	a5,s8,1120 <vprintf+0xba>
      } else if(c == 'l') {
    10e4:	05978c63          	beq	a5,s9,113c <vprintf+0xd6>
      } else if(c == 'x') {
    10e8:	07a78863          	beq	a5,s10,1158 <vprintf+0xf2>
      } else if(c == 'p') {
    10ec:	09b78463          	beq	a5,s11,1174 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    10f0:	07300713          	li	a4,115
    10f4:	0ce78563          	beq	a5,a4,11be <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    10f8:	06300713          	li	a4,99
    10fc:	0ee78c63          	beq	a5,a4,11f4 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    1100:	11478663          	beq	a5,s4,120c <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1104:	85d2                	mv	a1,s4
    1106:	8556                	mv	a0,s5
    1108:	00000097          	auipc	ra,0x0
    110c:	e90080e7          	jalr	-368(ra) # f98 <putc>
        putc(fd, c);
    1110:	85a6                	mv	a1,s1
    1112:	8556                	mv	a0,s5
    1114:	00000097          	auipc	ra,0x0
    1118:	e84080e7          	jalr	-380(ra) # f98 <putc>
      }
      state = 0;
    111c:	4981                	li	s3,0
    111e:	b765                	j	10c6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    1120:	008b0493          	addi	s1,s6,8
    1124:	4685                	li	a3,1
    1126:	4629                	li	a2,10
    1128:	000b2583          	lw	a1,0(s6)
    112c:	8556                	mv	a0,s5
    112e:	00000097          	auipc	ra,0x0
    1132:	e8c080e7          	jalr	-372(ra) # fba <printint>
    1136:	8b26                	mv	s6,s1
      state = 0;
    1138:	4981                	li	s3,0
    113a:	b771                	j	10c6 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    113c:	008b0493          	addi	s1,s6,8
    1140:	4681                	li	a3,0
    1142:	4629                	li	a2,10
    1144:	000b2583          	lw	a1,0(s6)
    1148:	8556                	mv	a0,s5
    114a:	00000097          	auipc	ra,0x0
    114e:	e70080e7          	jalr	-400(ra) # fba <printint>
    1152:	8b26                	mv	s6,s1
      state = 0;
    1154:	4981                	li	s3,0
    1156:	bf85                	j	10c6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    1158:	008b0493          	addi	s1,s6,8
    115c:	4681                	li	a3,0
    115e:	4641                	li	a2,16
    1160:	000b2583          	lw	a1,0(s6)
    1164:	8556                	mv	a0,s5
    1166:	00000097          	auipc	ra,0x0
    116a:	e54080e7          	jalr	-428(ra) # fba <printint>
    116e:	8b26                	mv	s6,s1
      state = 0;
    1170:	4981                	li	s3,0
    1172:	bf91                	j	10c6 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    1174:	008b0793          	addi	a5,s6,8
    1178:	f8f43423          	sd	a5,-120(s0)
    117c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    1180:	03000593          	li	a1,48
    1184:	8556                	mv	a0,s5
    1186:	00000097          	auipc	ra,0x0
    118a:	e12080e7          	jalr	-494(ra) # f98 <putc>
  putc(fd, 'x');
    118e:	85ea                	mv	a1,s10
    1190:	8556                	mv	a0,s5
    1192:	00000097          	auipc	ra,0x0
    1196:	e06080e7          	jalr	-506(ra) # f98 <putc>
    119a:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    119c:	03c9d793          	srli	a5,s3,0x3c
    11a0:	97de                	add	a5,a5,s7
    11a2:	0007c583          	lbu	a1,0(a5)
    11a6:	8556                	mv	a0,s5
    11a8:	00000097          	auipc	ra,0x0
    11ac:	df0080e7          	jalr	-528(ra) # f98 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    11b0:	0992                	slli	s3,s3,0x4
    11b2:	34fd                	addiw	s1,s1,-1
    11b4:	f4e5                	bnez	s1,119c <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    11b6:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    11ba:	4981                	li	s3,0
    11bc:	b729                	j	10c6 <vprintf+0x60>
        s = va_arg(ap, char*);
    11be:	008b0993          	addi	s3,s6,8
    11c2:	000b3483          	ld	s1,0(s6)
        if(s == 0)
    11c6:	c085                	beqz	s1,11e6 <vprintf+0x180>
        while(*s != 0){
    11c8:	0004c583          	lbu	a1,0(s1)
    11cc:	c9a1                	beqz	a1,121c <vprintf+0x1b6>
          putc(fd, *s);
    11ce:	8556                	mv	a0,s5
    11d0:	00000097          	auipc	ra,0x0
    11d4:	dc8080e7          	jalr	-568(ra) # f98 <putc>
          s++;
    11d8:	0485                	addi	s1,s1,1
        while(*s != 0){
    11da:	0004c583          	lbu	a1,0(s1)
    11de:	f9e5                	bnez	a1,11ce <vprintf+0x168>
        s = va_arg(ap, char*);
    11e0:	8b4e                	mv	s6,s3
      state = 0;
    11e2:	4981                	li	s3,0
    11e4:	b5cd                	j	10c6 <vprintf+0x60>
          s = "(null)";
    11e6:	00000497          	auipc	s1,0x0
    11ea:	53a48493          	addi	s1,s1,1338 # 1720 <digits+0x18>
        while(*s != 0){
    11ee:	02800593          	li	a1,40
    11f2:	bff1                	j	11ce <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
    11f4:	008b0493          	addi	s1,s6,8
    11f8:	000b4583          	lbu	a1,0(s6)
    11fc:	8556                	mv	a0,s5
    11fe:	00000097          	auipc	ra,0x0
    1202:	d9a080e7          	jalr	-614(ra) # f98 <putc>
    1206:	8b26                	mv	s6,s1
      state = 0;
    1208:	4981                	li	s3,0
    120a:	bd75                	j	10c6 <vprintf+0x60>
        putc(fd, c);
    120c:	85d2                	mv	a1,s4
    120e:	8556                	mv	a0,s5
    1210:	00000097          	auipc	ra,0x0
    1214:	d88080e7          	jalr	-632(ra) # f98 <putc>
      state = 0;
    1218:	4981                	li	s3,0
    121a:	b575                	j	10c6 <vprintf+0x60>
        s = va_arg(ap, char*);
    121c:	8b4e                	mv	s6,s3
      state = 0;
    121e:	4981                	li	s3,0
    1220:	b55d                	j	10c6 <vprintf+0x60>
    }
  }
}
    1222:	70e6                	ld	ra,120(sp)
    1224:	7446                	ld	s0,112(sp)
    1226:	74a6                	ld	s1,104(sp)
    1228:	7906                	ld	s2,96(sp)
    122a:	69e6                	ld	s3,88(sp)
    122c:	6a46                	ld	s4,80(sp)
    122e:	6aa6                	ld	s5,72(sp)
    1230:	6b06                	ld	s6,64(sp)
    1232:	7be2                	ld	s7,56(sp)
    1234:	7c42                	ld	s8,48(sp)
    1236:	7ca2                	ld	s9,40(sp)
    1238:	7d02                	ld	s10,32(sp)
    123a:	6de2                	ld	s11,24(sp)
    123c:	6109                	addi	sp,sp,128
    123e:	8082                	ret

0000000000001240 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1240:	715d                	addi	sp,sp,-80
    1242:	ec06                	sd	ra,24(sp)
    1244:	e822                	sd	s0,16(sp)
    1246:	1000                	addi	s0,sp,32
    1248:	e010                	sd	a2,0(s0)
    124a:	e414                	sd	a3,8(s0)
    124c:	e818                	sd	a4,16(s0)
    124e:	ec1c                	sd	a5,24(s0)
    1250:	03043023          	sd	a6,32(s0)
    1254:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1258:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    125c:	8622                	mv	a2,s0
    125e:	00000097          	auipc	ra,0x0
    1262:	e08080e7          	jalr	-504(ra) # 1066 <vprintf>
}
    1266:	60e2                	ld	ra,24(sp)
    1268:	6442                	ld	s0,16(sp)
    126a:	6161                	addi	sp,sp,80
    126c:	8082                	ret

000000000000126e <printf>:

void
printf(const char *fmt, ...)
{
    126e:	711d                	addi	sp,sp,-96
    1270:	ec06                	sd	ra,24(sp)
    1272:	e822                	sd	s0,16(sp)
    1274:	1000                	addi	s0,sp,32
    1276:	e40c                	sd	a1,8(s0)
    1278:	e810                	sd	a2,16(s0)
    127a:	ec14                	sd	a3,24(s0)
    127c:	f018                	sd	a4,32(s0)
    127e:	f41c                	sd	a5,40(s0)
    1280:	03043823          	sd	a6,48(s0)
    1284:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1288:	00840613          	addi	a2,s0,8
    128c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1290:	85aa                	mv	a1,a0
    1292:	4505                	li	a0,1
    1294:	00000097          	auipc	ra,0x0
    1298:	dd2080e7          	jalr	-558(ra) # 1066 <vprintf>
}
    129c:	60e2                	ld	ra,24(sp)
    129e:	6442                	ld	s0,16(sp)
    12a0:	6125                	addi	sp,sp,96
    12a2:	8082                	ret

00000000000012a4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    12a4:	1141                	addi	sp,sp,-16
    12a6:	e422                	sd	s0,8(sp)
    12a8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    12aa:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    12ae:	00001797          	auipc	a5,0x1
    12b2:	d6278793          	addi	a5,a5,-670 # 2010 <freep>
    12b6:	639c                	ld	a5,0(a5)
    12b8:	a805                	j	12e8 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    12ba:	4618                	lw	a4,8(a2)
    12bc:	9db9                	addw	a1,a1,a4
    12be:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    12c2:	6398                	ld	a4,0(a5)
    12c4:	6318                	ld	a4,0(a4)
    12c6:	fee53823          	sd	a4,-16(a0)
    12ca:	a091                	j	130e <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    12cc:	ff852703          	lw	a4,-8(a0)
    12d0:	9e39                	addw	a2,a2,a4
    12d2:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    12d4:	ff053703          	ld	a4,-16(a0)
    12d8:	e398                	sd	a4,0(a5)
    12da:	a099                	j	1320 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    12dc:	6398                	ld	a4,0(a5)
    12de:	00e7e463          	bltu	a5,a4,12e6 <free+0x42>
    12e2:	00e6ea63          	bltu	a3,a4,12f6 <free+0x52>
{
    12e6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    12e8:	fed7fae3          	bgeu	a5,a3,12dc <free+0x38>
    12ec:	6398                	ld	a4,0(a5)
    12ee:	00e6e463          	bltu	a3,a4,12f6 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    12f2:	fee7eae3          	bltu	a5,a4,12e6 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
    12f6:	ff852583          	lw	a1,-8(a0)
    12fa:	6390                	ld	a2,0(a5)
    12fc:	02059713          	slli	a4,a1,0x20
    1300:	9301                	srli	a4,a4,0x20
    1302:	0712                	slli	a4,a4,0x4
    1304:	9736                	add	a4,a4,a3
    1306:	fae60ae3          	beq	a2,a4,12ba <free+0x16>
    bp->s.ptr = p->s.ptr;
    130a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    130e:	4790                	lw	a2,8(a5)
    1310:	02061713          	slli	a4,a2,0x20
    1314:	9301                	srli	a4,a4,0x20
    1316:	0712                	slli	a4,a4,0x4
    1318:	973e                	add	a4,a4,a5
    131a:	fae689e3          	beq	a3,a4,12cc <free+0x28>
  } else
    p->s.ptr = bp;
    131e:	e394                	sd	a3,0(a5)
  freep = p;
    1320:	00001717          	auipc	a4,0x1
    1324:	cef73823          	sd	a5,-784(a4) # 2010 <freep>
}
    1328:	6422                	ld	s0,8(sp)
    132a:	0141                	addi	sp,sp,16
    132c:	8082                	ret

000000000000132e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    132e:	7139                	addi	sp,sp,-64
    1330:	fc06                	sd	ra,56(sp)
    1332:	f822                	sd	s0,48(sp)
    1334:	f426                	sd	s1,40(sp)
    1336:	f04a                	sd	s2,32(sp)
    1338:	ec4e                	sd	s3,24(sp)
    133a:	e852                	sd	s4,16(sp)
    133c:	e456                	sd	s5,8(sp)
    133e:	e05a                	sd	s6,0(sp)
    1340:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1342:	02051993          	slli	s3,a0,0x20
    1346:	0209d993          	srli	s3,s3,0x20
    134a:	09bd                	addi	s3,s3,15
    134c:	0049d993          	srli	s3,s3,0x4
    1350:	2985                	addiw	s3,s3,1
    1352:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
    1356:	00001797          	auipc	a5,0x1
    135a:	cba78793          	addi	a5,a5,-838 # 2010 <freep>
    135e:	6388                	ld	a0,0(a5)
    1360:	c515                	beqz	a0,138c <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1362:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1364:	4798                	lw	a4,8(a5)
    1366:	03277f63          	bgeu	a4,s2,13a4 <malloc+0x76>
    136a:	8a4e                	mv	s4,s3
    136c:	0009871b          	sext.w	a4,s3
    1370:	6685                	lui	a3,0x1
    1372:	00d77363          	bgeu	a4,a3,1378 <malloc+0x4a>
    1376:	6a05                	lui	s4,0x1
    1378:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
    137c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1380:	00001497          	auipc	s1,0x1
    1384:	c9048493          	addi	s1,s1,-880 # 2010 <freep>
  if(p == (char*)-1)
    1388:	5b7d                	li	s6,-1
    138a:	a885                	j	13fa <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
    138c:	00001797          	auipc	a5,0x1
    1390:	07c78793          	addi	a5,a5,124 # 2408 <base>
    1394:	00001717          	auipc	a4,0x1
    1398:	c6f73e23          	sd	a5,-900(a4) # 2010 <freep>
    139c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    139e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    13a2:	b7e1                	j	136a <malloc+0x3c>
      if(p->s.size == nunits)
    13a4:	02e90b63          	beq	s2,a4,13da <malloc+0xac>
        p->s.size -= nunits;
    13a8:	4137073b          	subw	a4,a4,s3
    13ac:	c798                	sw	a4,8(a5)
        p += p->s.size;
    13ae:	1702                	slli	a4,a4,0x20
    13b0:	9301                	srli	a4,a4,0x20
    13b2:	0712                	slli	a4,a4,0x4
    13b4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    13b6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    13ba:	00001717          	auipc	a4,0x1
    13be:	c4a73b23          	sd	a0,-938(a4) # 2010 <freep>
      return (void*)(p + 1);
    13c2:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    13c6:	70e2                	ld	ra,56(sp)
    13c8:	7442                	ld	s0,48(sp)
    13ca:	74a2                	ld	s1,40(sp)
    13cc:	7902                	ld	s2,32(sp)
    13ce:	69e2                	ld	s3,24(sp)
    13d0:	6a42                	ld	s4,16(sp)
    13d2:	6aa2                	ld	s5,8(sp)
    13d4:	6b02                	ld	s6,0(sp)
    13d6:	6121                	addi	sp,sp,64
    13d8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    13da:	6398                	ld	a4,0(a5)
    13dc:	e118                	sd	a4,0(a0)
    13de:	bff1                	j	13ba <malloc+0x8c>
  hp->s.size = nu;
    13e0:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
    13e4:	0541                	addi	a0,a0,16
    13e6:	00000097          	auipc	ra,0x0
    13ea:	ebe080e7          	jalr	-322(ra) # 12a4 <free>
  return freep;
    13ee:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
    13f0:	d979                	beqz	a0,13c6 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13f2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    13f4:	4798                	lw	a4,8(a5)
    13f6:	fb2777e3          	bgeu	a4,s2,13a4 <malloc+0x76>
    if(p == freep)
    13fa:	6098                	ld	a4,0(s1)
    13fc:	853e                	mv	a0,a5
    13fe:	fef71ae3          	bne	a4,a5,13f2 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
    1402:	8552                	mv	a0,s4
    1404:	00000097          	auipc	ra,0x0
    1408:	b5c080e7          	jalr	-1188(ra) # f60 <sbrk>
  if(p == (char*)-1)
    140c:	fd651ae3          	bne	a0,s6,13e0 <malloc+0xb2>
        return 0;
    1410:	4501                	li	a0,0
    1412:	bf55                	j	13c6 <malloc+0x98>
