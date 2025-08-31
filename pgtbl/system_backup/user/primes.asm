
user/_primes:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <readleft>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

void readleft(int *p0)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	1800                	addi	s0,sp,48
   a:	84aa                	mv	s1,a0
    int pid;
    if ((pid = fork()) == 0) {
   c:	00000097          	auipc	ra,0x0
  10:	3e4080e7          	jalr	996(ra) # 3f0 <fork>
  14:	e145                	bnez	a0,b4 <readleft+0xb4>
        int cur, tmp;
        if (read(*p0, &cur, sizeof(int)) == 0)
  16:	4611                	li	a2,4
  18:	fd040593          	addi	a1,s0,-48
  1c:	4088                	lw	a0,0(s1)
  1e:	00000097          	auipc	ra,0x0
  22:	3f2080e7          	jalr	1010(ra) # 410 <read>
  26:	c14d                	beqz	a0,c8 <readleft+0xc8>
            return;
        printf("prime %d\n", cur);
  28:	fd042583          	lw	a1,-48(s0)
  2c:	00001517          	auipc	a0,0x1
  30:	91450513          	addi	a0,a0,-1772 # 940 <malloc+0xf2>
  34:	00000097          	auipc	ra,0x0
  38:	75a080e7          	jalr	1882(ra) # 78e <printf>

        int p[2];
        pipe(p);
  3c:	fd840513          	addi	a0,s0,-40
  40:	00000097          	auipc	ra,0x0
  44:	3c8080e7          	jalr	968(ra) # 408 <pipe>
        while(read(*p0, &tmp, sizeof(int)) != 0) {
  48:	4611                	li	a2,4
  4a:	fd440593          	addi	a1,s0,-44
  4e:	4088                	lw	a0,0(s1)
  50:	00000097          	auipc	ra,0x0
  54:	3c0080e7          	jalr	960(ra) # 410 <read>
  58:	c115                	beqz	a0,7c <readleft+0x7c>
            if (tmp % cur != 0)
  5a:	fd442783          	lw	a5,-44(s0)
  5e:	fd042703          	lw	a4,-48(s0)
  62:	02e7e7bb          	remw	a5,a5,a4
  66:	d3ed                	beqz	a5,48 <readleft+0x48>
                write(p[1], &tmp, sizeof(int));
  68:	4611                	li	a2,4
  6a:	fd440593          	addi	a1,s0,-44
  6e:	fdc42503          	lw	a0,-36(s0)
  72:	00000097          	auipc	ra,0x0
  76:	3a6080e7          	jalr	934(ra) # 418 <write>
  7a:	b7f9                	j	48 <readleft+0x48>
        }
        close(*p0);
  7c:	4088                	lw	a0,0(s1)
  7e:	00000097          	auipc	ra,0x0
  82:	3a2080e7          	jalr	930(ra) # 420 <close>
        close(p[1]);
  86:	fdc42503          	lw	a0,-36(s0)
  8a:	00000097          	auipc	ra,0x0
  8e:	396080e7          	jalr	918(ra) # 420 <close>
        readleft(p);
  92:	fd840513          	addi	a0,s0,-40
  96:	00000097          	auipc	ra,0x0
  9a:	f6a080e7          	jalr	-150(ra) # 0 <readleft>
        close(p[0]);
  9e:	fd842503          	lw	a0,-40(s0)
  a2:	00000097          	auipc	ra,0x0
  a6:	37e080e7          	jalr	894(ra) # 420 <close>
        exit(0);
  aa:	4501                	li	a0,0
  ac:	00000097          	auipc	ra,0x0
  b0:	34c080e7          	jalr	844(ra) # 3f8 <exit>
    }
    else {
        close(*p0);
  b4:	4088                	lw	a0,0(s1)
  b6:	00000097          	auipc	ra,0x0
  ba:	36a080e7          	jalr	874(ra) # 420 <close>
        wait(0);
  be:	4501                	li	a0,0
  c0:	00000097          	auipc	ra,0x0
  c4:	340080e7          	jalr	832(ra) # 400 <wait>
    }
}
  c8:	70a2                	ld	ra,40(sp)
  ca:	7402                	ld	s0,32(sp)
  cc:	64e2                	ld	s1,24(sp)
  ce:	6145                	addi	sp,sp,48
  d0:	8082                	ret

00000000000000d2 <main>:

int main()
{
  d2:	7179                	addi	sp,sp,-48
  d4:	f406                	sd	ra,40(sp)
  d6:	f022                	sd	s0,32(sp)
  d8:	ec26                	sd	s1,24(sp)
  da:	1800                	addi	s0,sp,48
    int p[2];
    pipe(p);
  dc:	fd840513          	addi	a0,s0,-40
  e0:	00000097          	auipc	ra,0x0
  e4:	328080e7          	jalr	808(ra) # 408 <pipe>

    for (int i = 2; i <= 35; i++) {
  e8:	4789                	li	a5,2
  ea:	fcf42a23          	sw	a5,-44(s0)
  ee:	02300493          	li	s1,35
        write(p[1], &i, sizeof(int));
  f2:	4611                	li	a2,4
  f4:	fd440593          	addi	a1,s0,-44
  f8:	fdc42503          	lw	a0,-36(s0)
  fc:	00000097          	auipc	ra,0x0
 100:	31c080e7          	jalr	796(ra) # 418 <write>
    for (int i = 2; i <= 35; i++) {
 104:	fd442783          	lw	a5,-44(s0)
 108:	2785                	addiw	a5,a5,1
 10a:	0007871b          	sext.w	a4,a5
 10e:	fcf42a23          	sw	a5,-44(s0)
 112:	fee4d0e3          	bge	s1,a4,f2 <main+0x20>
    }

    close(p[1]);
 116:	fdc42503          	lw	a0,-36(s0)
 11a:	00000097          	auipc	ra,0x0
 11e:	306080e7          	jalr	774(ra) # 420 <close>

    readleft(p);
 122:	fd840513          	addi	a0,s0,-40
 126:	00000097          	auipc	ra,0x0
 12a:	eda080e7          	jalr	-294(ra) # 0 <readleft>

    exit(0);
 12e:	4501                	li	a0,0
 130:	00000097          	auipc	ra,0x0
 134:	2c8080e7          	jalr	712(ra) # 3f8 <exit>

0000000000000138 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 138:	1141                	addi	sp,sp,-16
 13a:	e406                	sd	ra,8(sp)
 13c:	e022                	sd	s0,0(sp)
 13e:	0800                	addi	s0,sp,16
  extern int main();
  main();
 140:	00000097          	auipc	ra,0x0
 144:	f92080e7          	jalr	-110(ra) # d2 <main>
  exit(0);
 148:	4501                	li	a0,0
 14a:	00000097          	auipc	ra,0x0
 14e:	2ae080e7          	jalr	686(ra) # 3f8 <exit>

0000000000000152 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 152:	1141                	addi	sp,sp,-16
 154:	e422                	sd	s0,8(sp)
 156:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 158:	87aa                	mv	a5,a0
 15a:	0585                	addi	a1,a1,1
 15c:	0785                	addi	a5,a5,1
 15e:	fff5c703          	lbu	a4,-1(a1)
 162:	fee78fa3          	sb	a4,-1(a5)
 166:	fb75                	bnez	a4,15a <strcpy+0x8>
    ;
  return os;
}
 168:	6422                	ld	s0,8(sp)
 16a:	0141                	addi	sp,sp,16
 16c:	8082                	ret

000000000000016e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 16e:	1141                	addi	sp,sp,-16
 170:	e422                	sd	s0,8(sp)
 172:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 174:	00054783          	lbu	a5,0(a0)
 178:	cf91                	beqz	a5,194 <strcmp+0x26>
 17a:	0005c703          	lbu	a4,0(a1)
 17e:	00f71b63          	bne	a4,a5,194 <strcmp+0x26>
    p++, q++;
 182:	0505                	addi	a0,a0,1
 184:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 186:	00054783          	lbu	a5,0(a0)
 18a:	c789                	beqz	a5,194 <strcmp+0x26>
 18c:	0005c703          	lbu	a4,0(a1)
 190:	fef709e3          	beq	a4,a5,182 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 194:	0005c503          	lbu	a0,0(a1)
}
 198:	40a7853b          	subw	a0,a5,a0
 19c:	6422                	ld	s0,8(sp)
 19e:	0141                	addi	sp,sp,16
 1a0:	8082                	ret

00000000000001a2 <strlen>:

uint
strlen(const char *s)
{
 1a2:	1141                	addi	sp,sp,-16
 1a4:	e422                	sd	s0,8(sp)
 1a6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1a8:	00054783          	lbu	a5,0(a0)
 1ac:	cf91                	beqz	a5,1c8 <strlen+0x26>
 1ae:	0505                	addi	a0,a0,1
 1b0:	87aa                	mv	a5,a0
 1b2:	4685                	li	a3,1
 1b4:	9e89                	subw	a3,a3,a0
    ;
 1b6:	00f6853b          	addw	a0,a3,a5
 1ba:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
 1bc:	fff7c703          	lbu	a4,-1(a5)
 1c0:	fb7d                	bnez	a4,1b6 <strlen+0x14>
  return n;
}
 1c2:	6422                	ld	s0,8(sp)
 1c4:	0141                	addi	sp,sp,16
 1c6:	8082                	ret
  for(n = 0; s[n]; n++)
 1c8:	4501                	li	a0,0
 1ca:	bfe5                	j	1c2 <strlen+0x20>

00000000000001cc <memset>:

void*
memset(void *dst, int c, uint n)
{
 1cc:	1141                	addi	sp,sp,-16
 1ce:	e422                	sd	s0,8(sp)
 1d0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1d2:	ce09                	beqz	a2,1ec <memset+0x20>
 1d4:	87aa                	mv	a5,a0
 1d6:	fff6071b          	addiw	a4,a2,-1
 1da:	1702                	slli	a4,a4,0x20
 1dc:	9301                	srli	a4,a4,0x20
 1de:	0705                	addi	a4,a4,1
 1e0:	972a                	add	a4,a4,a0
    cdst[i] = c;
 1e2:	00b78023          	sb	a1,0(a5)
 1e6:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 1e8:	fee79de3          	bne	a5,a4,1e2 <memset+0x16>
  }
  return dst;
}
 1ec:	6422                	ld	s0,8(sp)
 1ee:	0141                	addi	sp,sp,16
 1f0:	8082                	ret

00000000000001f2 <strchr>:

char*
strchr(const char *s, char c)
{
 1f2:	1141                	addi	sp,sp,-16
 1f4:	e422                	sd	s0,8(sp)
 1f6:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1f8:	00054783          	lbu	a5,0(a0)
 1fc:	cf91                	beqz	a5,218 <strchr+0x26>
    if(*s == c)
 1fe:	00f58a63          	beq	a1,a5,212 <strchr+0x20>
  for(; *s; s++)
 202:	0505                	addi	a0,a0,1
 204:	00054783          	lbu	a5,0(a0)
 208:	c781                	beqz	a5,210 <strchr+0x1e>
    if(*s == c)
 20a:	feb79ce3          	bne	a5,a1,202 <strchr+0x10>
 20e:	a011                	j	212 <strchr+0x20>
      return (char*)s;
  return 0;
 210:	4501                	li	a0,0
}
 212:	6422                	ld	s0,8(sp)
 214:	0141                	addi	sp,sp,16
 216:	8082                	ret
  return 0;
 218:	4501                	li	a0,0
 21a:	bfe5                	j	212 <strchr+0x20>

000000000000021c <gets>:

char*
gets(char *buf, int max)
{
 21c:	711d                	addi	sp,sp,-96
 21e:	ec86                	sd	ra,88(sp)
 220:	e8a2                	sd	s0,80(sp)
 222:	e4a6                	sd	s1,72(sp)
 224:	e0ca                	sd	s2,64(sp)
 226:	fc4e                	sd	s3,56(sp)
 228:	f852                	sd	s4,48(sp)
 22a:	f456                	sd	s5,40(sp)
 22c:	f05a                	sd	s6,32(sp)
 22e:	ec5e                	sd	s7,24(sp)
 230:	1080                	addi	s0,sp,96
 232:	8baa                	mv	s7,a0
 234:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 236:	892a                	mv	s2,a0
 238:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 23a:	4aa9                	li	s5,10
 23c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 23e:	0019849b          	addiw	s1,s3,1
 242:	0344d863          	bge	s1,s4,272 <gets+0x56>
    cc = read(0, &c, 1);
 246:	4605                	li	a2,1
 248:	faf40593          	addi	a1,s0,-81
 24c:	4501                	li	a0,0
 24e:	00000097          	auipc	ra,0x0
 252:	1c2080e7          	jalr	450(ra) # 410 <read>
    if(cc < 1)
 256:	00a05e63          	blez	a0,272 <gets+0x56>
    buf[i++] = c;
 25a:	faf44783          	lbu	a5,-81(s0)
 25e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 262:	01578763          	beq	a5,s5,270 <gets+0x54>
 266:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 268:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 26a:	fd679ae3          	bne	a5,s6,23e <gets+0x22>
 26e:	a011                	j	272 <gets+0x56>
  for(i=0; i+1 < max; ){
 270:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 272:	99de                	add	s3,s3,s7
 274:	00098023          	sb	zero,0(s3)
  return buf;
}
 278:	855e                	mv	a0,s7
 27a:	60e6                	ld	ra,88(sp)
 27c:	6446                	ld	s0,80(sp)
 27e:	64a6                	ld	s1,72(sp)
 280:	6906                	ld	s2,64(sp)
 282:	79e2                	ld	s3,56(sp)
 284:	7a42                	ld	s4,48(sp)
 286:	7aa2                	ld	s5,40(sp)
 288:	7b02                	ld	s6,32(sp)
 28a:	6be2                	ld	s7,24(sp)
 28c:	6125                	addi	sp,sp,96
 28e:	8082                	ret

0000000000000290 <stat>:

int
stat(const char *n, struct stat *st)
{
 290:	1101                	addi	sp,sp,-32
 292:	ec06                	sd	ra,24(sp)
 294:	e822                	sd	s0,16(sp)
 296:	e426                	sd	s1,8(sp)
 298:	e04a                	sd	s2,0(sp)
 29a:	1000                	addi	s0,sp,32
 29c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 29e:	4581                	li	a1,0
 2a0:	00000097          	auipc	ra,0x0
 2a4:	198080e7          	jalr	408(ra) # 438 <open>
  if(fd < 0)
 2a8:	02054563          	bltz	a0,2d2 <stat+0x42>
 2ac:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2ae:	85ca                	mv	a1,s2
 2b0:	00000097          	auipc	ra,0x0
 2b4:	1a0080e7          	jalr	416(ra) # 450 <fstat>
 2b8:	892a                	mv	s2,a0
  close(fd);
 2ba:	8526                	mv	a0,s1
 2bc:	00000097          	auipc	ra,0x0
 2c0:	164080e7          	jalr	356(ra) # 420 <close>
  return r;
}
 2c4:	854a                	mv	a0,s2
 2c6:	60e2                	ld	ra,24(sp)
 2c8:	6442                	ld	s0,16(sp)
 2ca:	64a2                	ld	s1,8(sp)
 2cc:	6902                	ld	s2,0(sp)
 2ce:	6105                	addi	sp,sp,32
 2d0:	8082                	ret
    return -1;
 2d2:	597d                	li	s2,-1
 2d4:	bfc5                	j	2c4 <stat+0x34>

00000000000002d6 <atoi>:

int
atoi(const char *s)
{
 2d6:	1141                	addi	sp,sp,-16
 2d8:	e422                	sd	s0,8(sp)
 2da:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2dc:	00054683          	lbu	a3,0(a0)
 2e0:	fd06879b          	addiw	a5,a3,-48
 2e4:	0ff7f793          	andi	a5,a5,255
 2e8:	4725                	li	a4,9
 2ea:	02f76963          	bltu	a4,a5,31c <atoi+0x46>
 2ee:	862a                	mv	a2,a0
  n = 0;
 2f0:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 2f2:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2f4:	0605                	addi	a2,a2,1
 2f6:	0025179b          	slliw	a5,a0,0x2
 2fa:	9fa9                	addw	a5,a5,a0
 2fc:	0017979b          	slliw	a5,a5,0x1
 300:	9fb5                	addw	a5,a5,a3
 302:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 306:	00064683          	lbu	a3,0(a2)
 30a:	fd06871b          	addiw	a4,a3,-48
 30e:	0ff77713          	andi	a4,a4,255
 312:	fee5f1e3          	bgeu	a1,a4,2f4 <atoi+0x1e>
  return n;
}
 316:	6422                	ld	s0,8(sp)
 318:	0141                	addi	sp,sp,16
 31a:	8082                	ret
  n = 0;
 31c:	4501                	li	a0,0
 31e:	bfe5                	j	316 <atoi+0x40>

0000000000000320 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 320:	1141                	addi	sp,sp,-16
 322:	e422                	sd	s0,8(sp)
 324:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 326:	02b57663          	bgeu	a0,a1,352 <memmove+0x32>
    while(n-- > 0)
 32a:	02c05163          	blez	a2,34c <memmove+0x2c>
 32e:	fff6079b          	addiw	a5,a2,-1
 332:	1782                	slli	a5,a5,0x20
 334:	9381                	srli	a5,a5,0x20
 336:	0785                	addi	a5,a5,1
 338:	97aa                	add	a5,a5,a0
  dst = vdst;
 33a:	872a                	mv	a4,a0
      *dst++ = *src++;
 33c:	0585                	addi	a1,a1,1
 33e:	0705                	addi	a4,a4,1
 340:	fff5c683          	lbu	a3,-1(a1)
 344:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 348:	fee79ae3          	bne	a5,a4,33c <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 34c:	6422                	ld	s0,8(sp)
 34e:	0141                	addi	sp,sp,16
 350:	8082                	ret
    dst += n;
 352:	00c50733          	add	a4,a0,a2
    src += n;
 356:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 358:	fec05ae3          	blez	a2,34c <memmove+0x2c>
 35c:	fff6079b          	addiw	a5,a2,-1
 360:	1782                	slli	a5,a5,0x20
 362:	9381                	srli	a5,a5,0x20
 364:	fff7c793          	not	a5,a5
 368:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 36a:	15fd                	addi	a1,a1,-1
 36c:	177d                	addi	a4,a4,-1
 36e:	0005c683          	lbu	a3,0(a1)
 372:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 376:	fef71ae3          	bne	a4,a5,36a <memmove+0x4a>
 37a:	bfc9                	j	34c <memmove+0x2c>

000000000000037c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 37c:	1141                	addi	sp,sp,-16
 37e:	e422                	sd	s0,8(sp)
 380:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 382:	ce15                	beqz	a2,3be <memcmp+0x42>
 384:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 388:	00054783          	lbu	a5,0(a0)
 38c:	0005c703          	lbu	a4,0(a1)
 390:	02e79063          	bne	a5,a4,3b0 <memcmp+0x34>
 394:	1682                	slli	a3,a3,0x20
 396:	9281                	srli	a3,a3,0x20
 398:	0685                	addi	a3,a3,1
 39a:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 39c:	0505                	addi	a0,a0,1
    p2++;
 39e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3a0:	00d50d63          	beq	a0,a3,3ba <memcmp+0x3e>
    if (*p1 != *p2) {
 3a4:	00054783          	lbu	a5,0(a0)
 3a8:	0005c703          	lbu	a4,0(a1)
 3ac:	fee788e3          	beq	a5,a4,39c <memcmp+0x20>
      return *p1 - *p2;
 3b0:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 3b4:	6422                	ld	s0,8(sp)
 3b6:	0141                	addi	sp,sp,16
 3b8:	8082                	ret
  return 0;
 3ba:	4501                	li	a0,0
 3bc:	bfe5                	j	3b4 <memcmp+0x38>
 3be:	4501                	li	a0,0
 3c0:	bfd5                	j	3b4 <memcmp+0x38>

00000000000003c2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3c2:	1141                	addi	sp,sp,-16
 3c4:	e406                	sd	ra,8(sp)
 3c6:	e022                	sd	s0,0(sp)
 3c8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3ca:	00000097          	auipc	ra,0x0
 3ce:	f56080e7          	jalr	-170(ra) # 320 <memmove>
}
 3d2:	60a2                	ld	ra,8(sp)
 3d4:	6402                	ld	s0,0(sp)
 3d6:	0141                	addi	sp,sp,16
 3d8:	8082                	ret

00000000000003da <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 3da:	1141                	addi	sp,sp,-16
 3dc:	e422                	sd	s0,8(sp)
 3de:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 3e0:	040007b7          	lui	a5,0x4000
}
 3e4:	17f5                	addi	a5,a5,-3
 3e6:	07b2                	slli	a5,a5,0xc
 3e8:	4388                	lw	a0,0(a5)
 3ea:	6422                	ld	s0,8(sp)
 3ec:	0141                	addi	sp,sp,16
 3ee:	8082                	ret

00000000000003f0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3f0:	4885                	li	a7,1
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3f8:	4889                	li	a7,2
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <wait>:
.global wait
wait:
 li a7, SYS_wait
 400:	488d                	li	a7,3
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 408:	4891                	li	a7,4
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <read>:
.global read
read:
 li a7, SYS_read
 410:	4895                	li	a7,5
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <write>:
.global write
write:
 li a7, SYS_write
 418:	48c1                	li	a7,16
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <close>:
.global close
close:
 li a7, SYS_close
 420:	48d5                	li	a7,21
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <kill>:
.global kill
kill:
 li a7, SYS_kill
 428:	4899                	li	a7,6
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <exec>:
.global exec
exec:
 li a7, SYS_exec
 430:	489d                	li	a7,7
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <open>:
.global open
open:
 li a7, SYS_open
 438:	48bd                	li	a7,15
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 440:	48c5                	li	a7,17
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 448:	48c9                	li	a7,18
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 450:	48a1                	li	a7,8
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <link>:
.global link
link:
 li a7, SYS_link
 458:	48cd                	li	a7,19
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 460:	48d1                	li	a7,20
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 468:	48a5                	li	a7,9
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <dup>:
.global dup
dup:
 li a7, SYS_dup
 470:	48a9                	li	a7,10
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 478:	48ad                	li	a7,11
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 480:	48b1                	li	a7,12
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 488:	48b5                	li	a7,13
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 490:	48b9                	li	a7,14
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <trace>:
.global trace
trace:
 li a7, SYS_trace
 498:	48d9                	li	a7,22
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 4a0:	48dd                	li	a7,23
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <connect>:
.global connect
connect:
 li a7, SYS_connect
 4a8:	48f5                	li	a7,29
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 4b0:	48f9                	li	a7,30
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4b8:	1101                	addi	sp,sp,-32
 4ba:	ec06                	sd	ra,24(sp)
 4bc:	e822                	sd	s0,16(sp)
 4be:	1000                	addi	s0,sp,32
 4c0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4c4:	4605                	li	a2,1
 4c6:	fef40593          	addi	a1,s0,-17
 4ca:	00000097          	auipc	ra,0x0
 4ce:	f4e080e7          	jalr	-178(ra) # 418 <write>
}
 4d2:	60e2                	ld	ra,24(sp)
 4d4:	6442                	ld	s0,16(sp)
 4d6:	6105                	addi	sp,sp,32
 4d8:	8082                	ret

00000000000004da <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4da:	7139                	addi	sp,sp,-64
 4dc:	fc06                	sd	ra,56(sp)
 4de:	f822                	sd	s0,48(sp)
 4e0:	f426                	sd	s1,40(sp)
 4e2:	f04a                	sd	s2,32(sp)
 4e4:	ec4e                	sd	s3,24(sp)
 4e6:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4e8:	c299                	beqz	a3,4ee <printint+0x14>
 4ea:	0005cd63          	bltz	a1,504 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4ee:	2581                	sext.w	a1,a1
  neg = 0;
 4f0:	4301                	li	t1,0
 4f2:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 4f6:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 4f8:	2601                	sext.w	a2,a2
 4fa:	00000897          	auipc	a7,0x0
 4fe:	45688893          	addi	a7,a7,1110 # 950 <digits>
 502:	a039                	j	510 <printint+0x36>
    x = -xx;
 504:	40b005bb          	negw	a1,a1
    neg = 1;
 508:	4305                	li	t1,1
    x = -xx;
 50a:	b7e5                	j	4f2 <printint+0x18>
  }while((x /= base) != 0);
 50c:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 50e:	8836                	mv	a6,a3
 510:	0018069b          	addiw	a3,a6,1
 514:	02c5f7bb          	remuw	a5,a1,a2
 518:	1782                	slli	a5,a5,0x20
 51a:	9381                	srli	a5,a5,0x20
 51c:	97c6                	add	a5,a5,a7
 51e:	0007c783          	lbu	a5,0(a5) # 4000000 <base+0x3ffeff0>
 522:	00f70023          	sb	a5,0(a4)
 526:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 528:	02c5d7bb          	divuw	a5,a1,a2
 52c:	fec5f0e3          	bgeu	a1,a2,50c <printint+0x32>
  if(neg)
 530:	00030b63          	beqz	t1,546 <printint+0x6c>
    buf[i++] = '-';
 534:	fd040793          	addi	a5,s0,-48
 538:	96be                	add	a3,a3,a5
 53a:	02d00793          	li	a5,45
 53e:	fef68823          	sb	a5,-16(a3)
 542:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 546:	02d05963          	blez	a3,578 <printint+0x9e>
 54a:	89aa                	mv	s3,a0
 54c:	fc040793          	addi	a5,s0,-64
 550:	00d784b3          	add	s1,a5,a3
 554:	fff78913          	addi	s2,a5,-1
 558:	9936                	add	s2,s2,a3
 55a:	36fd                	addiw	a3,a3,-1
 55c:	1682                	slli	a3,a3,0x20
 55e:	9281                	srli	a3,a3,0x20
 560:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 564:	fff4c583          	lbu	a1,-1(s1)
 568:	854e                	mv	a0,s3
 56a:	00000097          	auipc	ra,0x0
 56e:	f4e080e7          	jalr	-178(ra) # 4b8 <putc>
 572:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 574:	ff2498e3          	bne	s1,s2,564 <printint+0x8a>
}
 578:	70e2                	ld	ra,56(sp)
 57a:	7442                	ld	s0,48(sp)
 57c:	74a2                	ld	s1,40(sp)
 57e:	7902                	ld	s2,32(sp)
 580:	69e2                	ld	s3,24(sp)
 582:	6121                	addi	sp,sp,64
 584:	8082                	ret

0000000000000586 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 586:	7119                	addi	sp,sp,-128
 588:	fc86                	sd	ra,120(sp)
 58a:	f8a2                	sd	s0,112(sp)
 58c:	f4a6                	sd	s1,104(sp)
 58e:	f0ca                	sd	s2,96(sp)
 590:	ecce                	sd	s3,88(sp)
 592:	e8d2                	sd	s4,80(sp)
 594:	e4d6                	sd	s5,72(sp)
 596:	e0da                	sd	s6,64(sp)
 598:	fc5e                	sd	s7,56(sp)
 59a:	f862                	sd	s8,48(sp)
 59c:	f466                	sd	s9,40(sp)
 59e:	f06a                	sd	s10,32(sp)
 5a0:	ec6e                	sd	s11,24(sp)
 5a2:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5a4:	0005c483          	lbu	s1,0(a1)
 5a8:	18048d63          	beqz	s1,742 <vprintf+0x1bc>
 5ac:	8aaa                	mv	s5,a0
 5ae:	8b32                	mv	s6,a2
 5b0:	00158913          	addi	s2,a1,1
  state = 0;
 5b4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5b6:	02500a13          	li	s4,37
      if(c == 'd'){
 5ba:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 5be:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 5c2:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 5c6:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5ca:	00000b97          	auipc	s7,0x0
 5ce:	386b8b93          	addi	s7,s7,902 # 950 <digits>
 5d2:	a839                	j	5f0 <vprintf+0x6a>
        putc(fd, c);
 5d4:	85a6                	mv	a1,s1
 5d6:	8556                	mv	a0,s5
 5d8:	00000097          	auipc	ra,0x0
 5dc:	ee0080e7          	jalr	-288(ra) # 4b8 <putc>
 5e0:	a019                	j	5e6 <vprintf+0x60>
    } else if(state == '%'){
 5e2:	01498f63          	beq	s3,s4,600 <vprintf+0x7a>
 5e6:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 5e8:	fff94483          	lbu	s1,-1(s2)
 5ec:	14048b63          	beqz	s1,742 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 5f0:	0004879b          	sext.w	a5,s1
    if(state == 0){
 5f4:	fe0997e3          	bnez	s3,5e2 <vprintf+0x5c>
      if(c == '%'){
 5f8:	fd479ee3          	bne	a5,s4,5d4 <vprintf+0x4e>
        state = '%';
 5fc:	89be                	mv	s3,a5
 5fe:	b7e5                	j	5e6 <vprintf+0x60>
      if(c == 'd'){
 600:	05878063          	beq	a5,s8,640 <vprintf+0xba>
      } else if(c == 'l') {
 604:	05978c63          	beq	a5,s9,65c <vprintf+0xd6>
      } else if(c == 'x') {
 608:	07a78863          	beq	a5,s10,678 <vprintf+0xf2>
      } else if(c == 'p') {
 60c:	09b78463          	beq	a5,s11,694 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 610:	07300713          	li	a4,115
 614:	0ce78563          	beq	a5,a4,6de <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 618:	06300713          	li	a4,99
 61c:	0ee78c63          	beq	a5,a4,714 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 620:	11478663          	beq	a5,s4,72c <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 624:	85d2                	mv	a1,s4
 626:	8556                	mv	a0,s5
 628:	00000097          	auipc	ra,0x0
 62c:	e90080e7          	jalr	-368(ra) # 4b8 <putc>
        putc(fd, c);
 630:	85a6                	mv	a1,s1
 632:	8556                	mv	a0,s5
 634:	00000097          	auipc	ra,0x0
 638:	e84080e7          	jalr	-380(ra) # 4b8 <putc>
      }
      state = 0;
 63c:	4981                	li	s3,0
 63e:	b765                	j	5e6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 640:	008b0493          	addi	s1,s6,8
 644:	4685                	li	a3,1
 646:	4629                	li	a2,10
 648:	000b2583          	lw	a1,0(s6)
 64c:	8556                	mv	a0,s5
 64e:	00000097          	auipc	ra,0x0
 652:	e8c080e7          	jalr	-372(ra) # 4da <printint>
 656:	8b26                	mv	s6,s1
      state = 0;
 658:	4981                	li	s3,0
 65a:	b771                	j	5e6 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 65c:	008b0493          	addi	s1,s6,8
 660:	4681                	li	a3,0
 662:	4629                	li	a2,10
 664:	000b2583          	lw	a1,0(s6)
 668:	8556                	mv	a0,s5
 66a:	00000097          	auipc	ra,0x0
 66e:	e70080e7          	jalr	-400(ra) # 4da <printint>
 672:	8b26                	mv	s6,s1
      state = 0;
 674:	4981                	li	s3,0
 676:	bf85                	j	5e6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 678:	008b0493          	addi	s1,s6,8
 67c:	4681                	li	a3,0
 67e:	4641                	li	a2,16
 680:	000b2583          	lw	a1,0(s6)
 684:	8556                	mv	a0,s5
 686:	00000097          	auipc	ra,0x0
 68a:	e54080e7          	jalr	-428(ra) # 4da <printint>
 68e:	8b26                	mv	s6,s1
      state = 0;
 690:	4981                	li	s3,0
 692:	bf91                	j	5e6 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 694:	008b0793          	addi	a5,s6,8
 698:	f8f43423          	sd	a5,-120(s0)
 69c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6a0:	03000593          	li	a1,48
 6a4:	8556                	mv	a0,s5
 6a6:	00000097          	auipc	ra,0x0
 6aa:	e12080e7          	jalr	-494(ra) # 4b8 <putc>
  putc(fd, 'x');
 6ae:	85ea                	mv	a1,s10
 6b0:	8556                	mv	a0,s5
 6b2:	00000097          	auipc	ra,0x0
 6b6:	e06080e7          	jalr	-506(ra) # 4b8 <putc>
 6ba:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6bc:	03c9d793          	srli	a5,s3,0x3c
 6c0:	97de                	add	a5,a5,s7
 6c2:	0007c583          	lbu	a1,0(a5)
 6c6:	8556                	mv	a0,s5
 6c8:	00000097          	auipc	ra,0x0
 6cc:	df0080e7          	jalr	-528(ra) # 4b8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6d0:	0992                	slli	s3,s3,0x4
 6d2:	34fd                	addiw	s1,s1,-1
 6d4:	f4e5                	bnez	s1,6bc <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 6d6:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6da:	4981                	li	s3,0
 6dc:	b729                	j	5e6 <vprintf+0x60>
        s = va_arg(ap, char*);
 6de:	008b0993          	addi	s3,s6,8
 6e2:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 6e6:	c085                	beqz	s1,706 <vprintf+0x180>
        while(*s != 0){
 6e8:	0004c583          	lbu	a1,0(s1)
 6ec:	c9a1                	beqz	a1,73c <vprintf+0x1b6>
          putc(fd, *s);
 6ee:	8556                	mv	a0,s5
 6f0:	00000097          	auipc	ra,0x0
 6f4:	dc8080e7          	jalr	-568(ra) # 4b8 <putc>
          s++;
 6f8:	0485                	addi	s1,s1,1
        while(*s != 0){
 6fa:	0004c583          	lbu	a1,0(s1)
 6fe:	f9e5                	bnez	a1,6ee <vprintf+0x168>
        s = va_arg(ap, char*);
 700:	8b4e                	mv	s6,s3
      state = 0;
 702:	4981                	li	s3,0
 704:	b5cd                	j	5e6 <vprintf+0x60>
          s = "(null)";
 706:	00000497          	auipc	s1,0x0
 70a:	26248493          	addi	s1,s1,610 # 968 <digits+0x18>
        while(*s != 0){
 70e:	02800593          	li	a1,40
 712:	bff1                	j	6ee <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 714:	008b0493          	addi	s1,s6,8
 718:	000b4583          	lbu	a1,0(s6)
 71c:	8556                	mv	a0,s5
 71e:	00000097          	auipc	ra,0x0
 722:	d9a080e7          	jalr	-614(ra) # 4b8 <putc>
 726:	8b26                	mv	s6,s1
      state = 0;
 728:	4981                	li	s3,0
 72a:	bd75                	j	5e6 <vprintf+0x60>
        putc(fd, c);
 72c:	85d2                	mv	a1,s4
 72e:	8556                	mv	a0,s5
 730:	00000097          	auipc	ra,0x0
 734:	d88080e7          	jalr	-632(ra) # 4b8 <putc>
      state = 0;
 738:	4981                	li	s3,0
 73a:	b575                	j	5e6 <vprintf+0x60>
        s = va_arg(ap, char*);
 73c:	8b4e                	mv	s6,s3
      state = 0;
 73e:	4981                	li	s3,0
 740:	b55d                	j	5e6 <vprintf+0x60>
    }
  }
}
 742:	70e6                	ld	ra,120(sp)
 744:	7446                	ld	s0,112(sp)
 746:	74a6                	ld	s1,104(sp)
 748:	7906                	ld	s2,96(sp)
 74a:	69e6                	ld	s3,88(sp)
 74c:	6a46                	ld	s4,80(sp)
 74e:	6aa6                	ld	s5,72(sp)
 750:	6b06                	ld	s6,64(sp)
 752:	7be2                	ld	s7,56(sp)
 754:	7c42                	ld	s8,48(sp)
 756:	7ca2                	ld	s9,40(sp)
 758:	7d02                	ld	s10,32(sp)
 75a:	6de2                	ld	s11,24(sp)
 75c:	6109                	addi	sp,sp,128
 75e:	8082                	ret

0000000000000760 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 760:	715d                	addi	sp,sp,-80
 762:	ec06                	sd	ra,24(sp)
 764:	e822                	sd	s0,16(sp)
 766:	1000                	addi	s0,sp,32
 768:	e010                	sd	a2,0(s0)
 76a:	e414                	sd	a3,8(s0)
 76c:	e818                	sd	a4,16(s0)
 76e:	ec1c                	sd	a5,24(s0)
 770:	03043023          	sd	a6,32(s0)
 774:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 778:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 77c:	8622                	mv	a2,s0
 77e:	00000097          	auipc	ra,0x0
 782:	e08080e7          	jalr	-504(ra) # 586 <vprintf>
}
 786:	60e2                	ld	ra,24(sp)
 788:	6442                	ld	s0,16(sp)
 78a:	6161                	addi	sp,sp,80
 78c:	8082                	ret

000000000000078e <printf>:

void
printf(const char *fmt, ...)
{
 78e:	711d                	addi	sp,sp,-96
 790:	ec06                	sd	ra,24(sp)
 792:	e822                	sd	s0,16(sp)
 794:	1000                	addi	s0,sp,32
 796:	e40c                	sd	a1,8(s0)
 798:	e810                	sd	a2,16(s0)
 79a:	ec14                	sd	a3,24(s0)
 79c:	f018                	sd	a4,32(s0)
 79e:	f41c                	sd	a5,40(s0)
 7a0:	03043823          	sd	a6,48(s0)
 7a4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7a8:	00840613          	addi	a2,s0,8
 7ac:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7b0:	85aa                	mv	a1,a0
 7b2:	4505                	li	a0,1
 7b4:	00000097          	auipc	ra,0x0
 7b8:	dd2080e7          	jalr	-558(ra) # 586 <vprintf>
}
 7bc:	60e2                	ld	ra,24(sp)
 7be:	6442                	ld	s0,16(sp)
 7c0:	6125                	addi	sp,sp,96
 7c2:	8082                	ret

00000000000007c4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7c4:	1141                	addi	sp,sp,-16
 7c6:	e422                	sd	s0,8(sp)
 7c8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7ca:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ce:	00001797          	auipc	a5,0x1
 7d2:	83278793          	addi	a5,a5,-1998 # 1000 <freep>
 7d6:	639c                	ld	a5,0(a5)
 7d8:	a805                	j	808 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7da:	4618                	lw	a4,8(a2)
 7dc:	9db9                	addw	a1,a1,a4
 7de:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7e2:	6398                	ld	a4,0(a5)
 7e4:	6318                	ld	a4,0(a4)
 7e6:	fee53823          	sd	a4,-16(a0)
 7ea:	a091                	j	82e <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7ec:	ff852703          	lw	a4,-8(a0)
 7f0:	9e39                	addw	a2,a2,a4
 7f2:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 7f4:	ff053703          	ld	a4,-16(a0)
 7f8:	e398                	sd	a4,0(a5)
 7fa:	a099                	j	840 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7fc:	6398                	ld	a4,0(a5)
 7fe:	00e7e463          	bltu	a5,a4,806 <free+0x42>
 802:	00e6ea63          	bltu	a3,a4,816 <free+0x52>
{
 806:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 808:	fed7fae3          	bgeu	a5,a3,7fc <free+0x38>
 80c:	6398                	ld	a4,0(a5)
 80e:	00e6e463          	bltu	a3,a4,816 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 812:	fee7eae3          	bltu	a5,a4,806 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 816:	ff852583          	lw	a1,-8(a0)
 81a:	6390                	ld	a2,0(a5)
 81c:	02059713          	slli	a4,a1,0x20
 820:	9301                	srli	a4,a4,0x20
 822:	0712                	slli	a4,a4,0x4
 824:	9736                	add	a4,a4,a3
 826:	fae60ae3          	beq	a2,a4,7da <free+0x16>
    bp->s.ptr = p->s.ptr;
 82a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 82e:	4790                	lw	a2,8(a5)
 830:	02061713          	slli	a4,a2,0x20
 834:	9301                	srli	a4,a4,0x20
 836:	0712                	slli	a4,a4,0x4
 838:	973e                	add	a4,a4,a5
 83a:	fae689e3          	beq	a3,a4,7ec <free+0x28>
  } else
    p->s.ptr = bp;
 83e:	e394                	sd	a3,0(a5)
  freep = p;
 840:	00000717          	auipc	a4,0x0
 844:	7cf73023          	sd	a5,1984(a4) # 1000 <freep>
}
 848:	6422                	ld	s0,8(sp)
 84a:	0141                	addi	sp,sp,16
 84c:	8082                	ret

000000000000084e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 84e:	7139                	addi	sp,sp,-64
 850:	fc06                	sd	ra,56(sp)
 852:	f822                	sd	s0,48(sp)
 854:	f426                	sd	s1,40(sp)
 856:	f04a                	sd	s2,32(sp)
 858:	ec4e                	sd	s3,24(sp)
 85a:	e852                	sd	s4,16(sp)
 85c:	e456                	sd	s5,8(sp)
 85e:	e05a                	sd	s6,0(sp)
 860:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 862:	02051993          	slli	s3,a0,0x20
 866:	0209d993          	srli	s3,s3,0x20
 86a:	09bd                	addi	s3,s3,15
 86c:	0049d993          	srli	s3,s3,0x4
 870:	2985                	addiw	s3,s3,1
 872:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 876:	00000797          	auipc	a5,0x0
 87a:	78a78793          	addi	a5,a5,1930 # 1000 <freep>
 87e:	6388                	ld	a0,0(a5)
 880:	c515                	beqz	a0,8ac <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 882:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 884:	4798                	lw	a4,8(a5)
 886:	03277f63          	bgeu	a4,s2,8c4 <malloc+0x76>
 88a:	8a4e                	mv	s4,s3
 88c:	0009871b          	sext.w	a4,s3
 890:	6685                	lui	a3,0x1
 892:	00d77363          	bgeu	a4,a3,898 <malloc+0x4a>
 896:	6a05                	lui	s4,0x1
 898:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 89c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8a0:	00000497          	auipc	s1,0x0
 8a4:	76048493          	addi	s1,s1,1888 # 1000 <freep>
  if(p == (char*)-1)
 8a8:	5b7d                	li	s6,-1
 8aa:	a885                	j	91a <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 8ac:	00000797          	auipc	a5,0x0
 8b0:	76478793          	addi	a5,a5,1892 # 1010 <base>
 8b4:	00000717          	auipc	a4,0x0
 8b8:	74f73623          	sd	a5,1868(a4) # 1000 <freep>
 8bc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8be:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8c2:	b7e1                	j	88a <malloc+0x3c>
      if(p->s.size == nunits)
 8c4:	02e90b63          	beq	s2,a4,8fa <malloc+0xac>
        p->s.size -= nunits;
 8c8:	4137073b          	subw	a4,a4,s3
 8cc:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8ce:	1702                	slli	a4,a4,0x20
 8d0:	9301                	srli	a4,a4,0x20
 8d2:	0712                	slli	a4,a4,0x4
 8d4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8d6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8da:	00000717          	auipc	a4,0x0
 8de:	72a73323          	sd	a0,1830(a4) # 1000 <freep>
      return (void*)(p + 1);
 8e2:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8e6:	70e2                	ld	ra,56(sp)
 8e8:	7442                	ld	s0,48(sp)
 8ea:	74a2                	ld	s1,40(sp)
 8ec:	7902                	ld	s2,32(sp)
 8ee:	69e2                	ld	s3,24(sp)
 8f0:	6a42                	ld	s4,16(sp)
 8f2:	6aa2                	ld	s5,8(sp)
 8f4:	6b02                	ld	s6,0(sp)
 8f6:	6121                	addi	sp,sp,64
 8f8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8fa:	6398                	ld	a4,0(a5)
 8fc:	e118                	sd	a4,0(a0)
 8fe:	bff1                	j	8da <malloc+0x8c>
  hp->s.size = nu;
 900:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 904:	0541                	addi	a0,a0,16
 906:	00000097          	auipc	ra,0x0
 90a:	ebe080e7          	jalr	-322(ra) # 7c4 <free>
  return freep;
 90e:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 910:	d979                	beqz	a0,8e6 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 912:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 914:	4798                	lw	a4,8(a5)
 916:	fb2777e3          	bgeu	a4,s2,8c4 <malloc+0x76>
    if(p == freep)
 91a:	6098                	ld	a4,0(s1)
 91c:	853e                	mv	a0,a5
 91e:	fef71ae3          	bne	a4,a5,912 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 922:	8552                	mv	a0,s4
 924:	00000097          	auipc	ra,0x0
 928:	b5c080e7          	jalr	-1188(ra) # 480 <sbrk>
  if(p == (char*)-1)
 92c:	fd651ae3          	bne	a0,s6,900 <malloc+0xb2>
        return 0;
 930:	4501                	li	a0,0
 932:	bf55                	j	8e6 <malloc+0x98>
