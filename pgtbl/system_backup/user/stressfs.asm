
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dd010113          	addi	sp,sp,-560
   4:	22113423          	sd	ra,552(sp)
   8:	22813023          	sd	s0,544(sp)
   c:	20913c23          	sd	s1,536(sp)
  10:	21213823          	sd	s2,528(sp)
  14:	1c00                	addi	s0,sp,560
  int fd, i;
  char path[] = "stressfs0";
  16:	00001797          	auipc	a5,0x1
  1a:	92a78793          	addi	a5,a5,-1750 # 940 <malloc+0x11e>
  1e:	6398                	ld	a4,0(a5)
  20:	fce43823          	sd	a4,-48(s0)
  24:	0087d783          	lhu	a5,8(a5)
  28:	fcf41c23          	sh	a5,-40(s0)
  char data[512];

  printf("stressfs starting\n");
  2c:	00001517          	auipc	a0,0x1
  30:	8e450513          	addi	a0,a0,-1820 # 910 <malloc+0xee>
  34:	00000097          	auipc	ra,0x0
  38:	72e080e7          	jalr	1838(ra) # 762 <printf>
  memset(data, 'a', sizeof(data));
  3c:	20000613          	li	a2,512
  40:	06100593          	li	a1,97
  44:	dd040513          	addi	a0,s0,-560
  48:	00000097          	auipc	ra,0x0
  4c:	158080e7          	jalr	344(ra) # 1a0 <memset>

  for(i = 0; i < 4; i++)
  50:	4481                	li	s1,0
  52:	4911                	li	s2,4
    if(fork() > 0)
  54:	00000097          	auipc	ra,0x0
  58:	370080e7          	jalr	880(ra) # 3c4 <fork>
  5c:	00a04563          	bgtz	a0,66 <main+0x66>
  for(i = 0; i < 4; i++)
  60:	2485                	addiw	s1,s1,1
  62:	ff2499e3          	bne	s1,s2,54 <main+0x54>
      break;

  printf("write %d\n", i);
  66:	85a6                	mv	a1,s1
  68:	00001517          	auipc	a0,0x1
  6c:	8c050513          	addi	a0,a0,-1856 # 928 <malloc+0x106>
  70:	00000097          	auipc	ra,0x0
  74:	6f2080e7          	jalr	1778(ra) # 762 <printf>

  path[8] += i;
  78:	fd844783          	lbu	a5,-40(s0)
  7c:	9cbd                	addw	s1,s1,a5
  7e:	fc940c23          	sb	s1,-40(s0)
  fd = open(path, O_CREATE | O_RDWR);
  82:	20200593          	li	a1,514
  86:	fd040513          	addi	a0,s0,-48
  8a:	00000097          	auipc	ra,0x0
  8e:	382080e7          	jalr	898(ra) # 40c <open>
  92:	892a                	mv	s2,a0
  94:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  96:	20000613          	li	a2,512
  9a:	dd040593          	addi	a1,s0,-560
  9e:	854a                	mv	a0,s2
  a0:	00000097          	auipc	ra,0x0
  a4:	34c080e7          	jalr	844(ra) # 3ec <write>
  a8:	34fd                	addiw	s1,s1,-1
  for(i = 0; i < 20; i++)
  aa:	f4f5                	bnez	s1,96 <main+0x96>
  close(fd);
  ac:	854a                	mv	a0,s2
  ae:	00000097          	auipc	ra,0x0
  b2:	346080e7          	jalr	838(ra) # 3f4 <close>

  printf("read\n");
  b6:	00001517          	auipc	a0,0x1
  ba:	88250513          	addi	a0,a0,-1918 # 938 <malloc+0x116>
  be:	00000097          	auipc	ra,0x0
  c2:	6a4080e7          	jalr	1700(ra) # 762 <printf>

  fd = open(path, O_RDONLY);
  c6:	4581                	li	a1,0
  c8:	fd040513          	addi	a0,s0,-48
  cc:	00000097          	auipc	ra,0x0
  d0:	340080e7          	jalr	832(ra) # 40c <open>
  d4:	892a                	mv	s2,a0
  d6:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  d8:	20000613          	li	a2,512
  dc:	dd040593          	addi	a1,s0,-560
  e0:	854a                	mv	a0,s2
  e2:	00000097          	auipc	ra,0x0
  e6:	302080e7          	jalr	770(ra) # 3e4 <read>
  ea:	34fd                	addiw	s1,s1,-1
  for (i = 0; i < 20; i++)
  ec:	f4f5                	bnez	s1,d8 <main+0xd8>
  close(fd);
  ee:	854a                	mv	a0,s2
  f0:	00000097          	auipc	ra,0x0
  f4:	304080e7          	jalr	772(ra) # 3f4 <close>

  wait(0);
  f8:	4501                	li	a0,0
  fa:	00000097          	auipc	ra,0x0
  fe:	2da080e7          	jalr	730(ra) # 3d4 <wait>

  exit(0);
 102:	4501                	li	a0,0
 104:	00000097          	auipc	ra,0x0
 108:	2c8080e7          	jalr	712(ra) # 3cc <exit>

000000000000010c <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 10c:	1141                	addi	sp,sp,-16
 10e:	e406                	sd	ra,8(sp)
 110:	e022                	sd	s0,0(sp)
 112:	0800                	addi	s0,sp,16
  extern int main();
  main();
 114:	00000097          	auipc	ra,0x0
 118:	eec080e7          	jalr	-276(ra) # 0 <main>
  exit(0);
 11c:	4501                	li	a0,0
 11e:	00000097          	auipc	ra,0x0
 122:	2ae080e7          	jalr	686(ra) # 3cc <exit>

0000000000000126 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 126:	1141                	addi	sp,sp,-16
 128:	e422                	sd	s0,8(sp)
 12a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 12c:	87aa                	mv	a5,a0
 12e:	0585                	addi	a1,a1,1
 130:	0785                	addi	a5,a5,1
 132:	fff5c703          	lbu	a4,-1(a1)
 136:	fee78fa3          	sb	a4,-1(a5)
 13a:	fb75                	bnez	a4,12e <strcpy+0x8>
    ;
  return os;
}
 13c:	6422                	ld	s0,8(sp)
 13e:	0141                	addi	sp,sp,16
 140:	8082                	ret

0000000000000142 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 142:	1141                	addi	sp,sp,-16
 144:	e422                	sd	s0,8(sp)
 146:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 148:	00054783          	lbu	a5,0(a0)
 14c:	cf91                	beqz	a5,168 <strcmp+0x26>
 14e:	0005c703          	lbu	a4,0(a1)
 152:	00f71b63          	bne	a4,a5,168 <strcmp+0x26>
    p++, q++;
 156:	0505                	addi	a0,a0,1
 158:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 15a:	00054783          	lbu	a5,0(a0)
 15e:	c789                	beqz	a5,168 <strcmp+0x26>
 160:	0005c703          	lbu	a4,0(a1)
 164:	fef709e3          	beq	a4,a5,156 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 168:	0005c503          	lbu	a0,0(a1)
}
 16c:	40a7853b          	subw	a0,a5,a0
 170:	6422                	ld	s0,8(sp)
 172:	0141                	addi	sp,sp,16
 174:	8082                	ret

0000000000000176 <strlen>:

uint
strlen(const char *s)
{
 176:	1141                	addi	sp,sp,-16
 178:	e422                	sd	s0,8(sp)
 17a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 17c:	00054783          	lbu	a5,0(a0)
 180:	cf91                	beqz	a5,19c <strlen+0x26>
 182:	0505                	addi	a0,a0,1
 184:	87aa                	mv	a5,a0
 186:	4685                	li	a3,1
 188:	9e89                	subw	a3,a3,a0
    ;
 18a:	00f6853b          	addw	a0,a3,a5
 18e:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
 190:	fff7c703          	lbu	a4,-1(a5)
 194:	fb7d                	bnez	a4,18a <strlen+0x14>
  return n;
}
 196:	6422                	ld	s0,8(sp)
 198:	0141                	addi	sp,sp,16
 19a:	8082                	ret
  for(n = 0; s[n]; n++)
 19c:	4501                	li	a0,0
 19e:	bfe5                	j	196 <strlen+0x20>

00000000000001a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1a0:	1141                	addi	sp,sp,-16
 1a2:	e422                	sd	s0,8(sp)
 1a4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1a6:	ce09                	beqz	a2,1c0 <memset+0x20>
 1a8:	87aa                	mv	a5,a0
 1aa:	fff6071b          	addiw	a4,a2,-1
 1ae:	1702                	slli	a4,a4,0x20
 1b0:	9301                	srli	a4,a4,0x20
 1b2:	0705                	addi	a4,a4,1
 1b4:	972a                	add	a4,a4,a0
    cdst[i] = c;
 1b6:	00b78023          	sb	a1,0(a5)
 1ba:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 1bc:	fee79de3          	bne	a5,a4,1b6 <memset+0x16>
  }
  return dst;
}
 1c0:	6422                	ld	s0,8(sp)
 1c2:	0141                	addi	sp,sp,16
 1c4:	8082                	ret

00000000000001c6 <strchr>:

char*
strchr(const char *s, char c)
{
 1c6:	1141                	addi	sp,sp,-16
 1c8:	e422                	sd	s0,8(sp)
 1ca:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1cc:	00054783          	lbu	a5,0(a0)
 1d0:	cf91                	beqz	a5,1ec <strchr+0x26>
    if(*s == c)
 1d2:	00f58a63          	beq	a1,a5,1e6 <strchr+0x20>
  for(; *s; s++)
 1d6:	0505                	addi	a0,a0,1
 1d8:	00054783          	lbu	a5,0(a0)
 1dc:	c781                	beqz	a5,1e4 <strchr+0x1e>
    if(*s == c)
 1de:	feb79ce3          	bne	a5,a1,1d6 <strchr+0x10>
 1e2:	a011                	j	1e6 <strchr+0x20>
      return (char*)s;
  return 0;
 1e4:	4501                	li	a0,0
}
 1e6:	6422                	ld	s0,8(sp)
 1e8:	0141                	addi	sp,sp,16
 1ea:	8082                	ret
  return 0;
 1ec:	4501                	li	a0,0
 1ee:	bfe5                	j	1e6 <strchr+0x20>

00000000000001f0 <gets>:

char*
gets(char *buf, int max)
{
 1f0:	711d                	addi	sp,sp,-96
 1f2:	ec86                	sd	ra,88(sp)
 1f4:	e8a2                	sd	s0,80(sp)
 1f6:	e4a6                	sd	s1,72(sp)
 1f8:	e0ca                	sd	s2,64(sp)
 1fa:	fc4e                	sd	s3,56(sp)
 1fc:	f852                	sd	s4,48(sp)
 1fe:	f456                	sd	s5,40(sp)
 200:	f05a                	sd	s6,32(sp)
 202:	ec5e                	sd	s7,24(sp)
 204:	1080                	addi	s0,sp,96
 206:	8baa                	mv	s7,a0
 208:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 20a:	892a                	mv	s2,a0
 20c:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 20e:	4aa9                	li	s5,10
 210:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 212:	0019849b          	addiw	s1,s3,1
 216:	0344d863          	bge	s1,s4,246 <gets+0x56>
    cc = read(0, &c, 1);
 21a:	4605                	li	a2,1
 21c:	faf40593          	addi	a1,s0,-81
 220:	4501                	li	a0,0
 222:	00000097          	auipc	ra,0x0
 226:	1c2080e7          	jalr	450(ra) # 3e4 <read>
    if(cc < 1)
 22a:	00a05e63          	blez	a0,246 <gets+0x56>
    buf[i++] = c;
 22e:	faf44783          	lbu	a5,-81(s0)
 232:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 236:	01578763          	beq	a5,s5,244 <gets+0x54>
 23a:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 23c:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 23e:	fd679ae3          	bne	a5,s6,212 <gets+0x22>
 242:	a011                	j	246 <gets+0x56>
  for(i=0; i+1 < max; ){
 244:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 246:	99de                	add	s3,s3,s7
 248:	00098023          	sb	zero,0(s3)
  return buf;
}
 24c:	855e                	mv	a0,s7
 24e:	60e6                	ld	ra,88(sp)
 250:	6446                	ld	s0,80(sp)
 252:	64a6                	ld	s1,72(sp)
 254:	6906                	ld	s2,64(sp)
 256:	79e2                	ld	s3,56(sp)
 258:	7a42                	ld	s4,48(sp)
 25a:	7aa2                	ld	s5,40(sp)
 25c:	7b02                	ld	s6,32(sp)
 25e:	6be2                	ld	s7,24(sp)
 260:	6125                	addi	sp,sp,96
 262:	8082                	ret

0000000000000264 <stat>:

int
stat(const char *n, struct stat *st)
{
 264:	1101                	addi	sp,sp,-32
 266:	ec06                	sd	ra,24(sp)
 268:	e822                	sd	s0,16(sp)
 26a:	e426                	sd	s1,8(sp)
 26c:	e04a                	sd	s2,0(sp)
 26e:	1000                	addi	s0,sp,32
 270:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 272:	4581                	li	a1,0
 274:	00000097          	auipc	ra,0x0
 278:	198080e7          	jalr	408(ra) # 40c <open>
  if(fd < 0)
 27c:	02054563          	bltz	a0,2a6 <stat+0x42>
 280:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 282:	85ca                	mv	a1,s2
 284:	00000097          	auipc	ra,0x0
 288:	1a0080e7          	jalr	416(ra) # 424 <fstat>
 28c:	892a                	mv	s2,a0
  close(fd);
 28e:	8526                	mv	a0,s1
 290:	00000097          	auipc	ra,0x0
 294:	164080e7          	jalr	356(ra) # 3f4 <close>
  return r;
}
 298:	854a                	mv	a0,s2
 29a:	60e2                	ld	ra,24(sp)
 29c:	6442                	ld	s0,16(sp)
 29e:	64a2                	ld	s1,8(sp)
 2a0:	6902                	ld	s2,0(sp)
 2a2:	6105                	addi	sp,sp,32
 2a4:	8082                	ret
    return -1;
 2a6:	597d                	li	s2,-1
 2a8:	bfc5                	j	298 <stat+0x34>

00000000000002aa <atoi>:

int
atoi(const char *s)
{
 2aa:	1141                	addi	sp,sp,-16
 2ac:	e422                	sd	s0,8(sp)
 2ae:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2b0:	00054683          	lbu	a3,0(a0)
 2b4:	fd06879b          	addiw	a5,a3,-48
 2b8:	0ff7f793          	andi	a5,a5,255
 2bc:	4725                	li	a4,9
 2be:	02f76963          	bltu	a4,a5,2f0 <atoi+0x46>
 2c2:	862a                	mv	a2,a0
  n = 0;
 2c4:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 2c6:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2c8:	0605                	addi	a2,a2,1
 2ca:	0025179b          	slliw	a5,a0,0x2
 2ce:	9fa9                	addw	a5,a5,a0
 2d0:	0017979b          	slliw	a5,a5,0x1
 2d4:	9fb5                	addw	a5,a5,a3
 2d6:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2da:	00064683          	lbu	a3,0(a2)
 2de:	fd06871b          	addiw	a4,a3,-48
 2e2:	0ff77713          	andi	a4,a4,255
 2e6:	fee5f1e3          	bgeu	a1,a4,2c8 <atoi+0x1e>
  return n;
}
 2ea:	6422                	ld	s0,8(sp)
 2ec:	0141                	addi	sp,sp,16
 2ee:	8082                	ret
  n = 0;
 2f0:	4501                	li	a0,0
 2f2:	bfe5                	j	2ea <atoi+0x40>

00000000000002f4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2f4:	1141                	addi	sp,sp,-16
 2f6:	e422                	sd	s0,8(sp)
 2f8:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2fa:	02b57663          	bgeu	a0,a1,326 <memmove+0x32>
    while(n-- > 0)
 2fe:	02c05163          	blez	a2,320 <memmove+0x2c>
 302:	fff6079b          	addiw	a5,a2,-1
 306:	1782                	slli	a5,a5,0x20
 308:	9381                	srli	a5,a5,0x20
 30a:	0785                	addi	a5,a5,1
 30c:	97aa                	add	a5,a5,a0
  dst = vdst;
 30e:	872a                	mv	a4,a0
      *dst++ = *src++;
 310:	0585                	addi	a1,a1,1
 312:	0705                	addi	a4,a4,1
 314:	fff5c683          	lbu	a3,-1(a1)
 318:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 31c:	fee79ae3          	bne	a5,a4,310 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 320:	6422                	ld	s0,8(sp)
 322:	0141                	addi	sp,sp,16
 324:	8082                	ret
    dst += n;
 326:	00c50733          	add	a4,a0,a2
    src += n;
 32a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 32c:	fec05ae3          	blez	a2,320 <memmove+0x2c>
 330:	fff6079b          	addiw	a5,a2,-1
 334:	1782                	slli	a5,a5,0x20
 336:	9381                	srli	a5,a5,0x20
 338:	fff7c793          	not	a5,a5
 33c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 33e:	15fd                	addi	a1,a1,-1
 340:	177d                	addi	a4,a4,-1
 342:	0005c683          	lbu	a3,0(a1)
 346:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 34a:	fef71ae3          	bne	a4,a5,33e <memmove+0x4a>
 34e:	bfc9                	j	320 <memmove+0x2c>

0000000000000350 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 350:	1141                	addi	sp,sp,-16
 352:	e422                	sd	s0,8(sp)
 354:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 356:	ce15                	beqz	a2,392 <memcmp+0x42>
 358:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 35c:	00054783          	lbu	a5,0(a0)
 360:	0005c703          	lbu	a4,0(a1)
 364:	02e79063          	bne	a5,a4,384 <memcmp+0x34>
 368:	1682                	slli	a3,a3,0x20
 36a:	9281                	srli	a3,a3,0x20
 36c:	0685                	addi	a3,a3,1
 36e:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 370:	0505                	addi	a0,a0,1
    p2++;
 372:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 374:	00d50d63          	beq	a0,a3,38e <memcmp+0x3e>
    if (*p1 != *p2) {
 378:	00054783          	lbu	a5,0(a0)
 37c:	0005c703          	lbu	a4,0(a1)
 380:	fee788e3          	beq	a5,a4,370 <memcmp+0x20>
      return *p1 - *p2;
 384:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 388:	6422                	ld	s0,8(sp)
 38a:	0141                	addi	sp,sp,16
 38c:	8082                	ret
  return 0;
 38e:	4501                	li	a0,0
 390:	bfe5                	j	388 <memcmp+0x38>
 392:	4501                	li	a0,0
 394:	bfd5                	j	388 <memcmp+0x38>

0000000000000396 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 396:	1141                	addi	sp,sp,-16
 398:	e406                	sd	ra,8(sp)
 39a:	e022                	sd	s0,0(sp)
 39c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 39e:	00000097          	auipc	ra,0x0
 3a2:	f56080e7          	jalr	-170(ra) # 2f4 <memmove>
}
 3a6:	60a2                	ld	ra,8(sp)
 3a8:	6402                	ld	s0,0(sp)
 3aa:	0141                	addi	sp,sp,16
 3ac:	8082                	ret

00000000000003ae <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 3ae:	1141                	addi	sp,sp,-16
 3b0:	e422                	sd	s0,8(sp)
 3b2:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 3b4:	040007b7          	lui	a5,0x4000
}
 3b8:	17f5                	addi	a5,a5,-3
 3ba:	07b2                	slli	a5,a5,0xc
 3bc:	4388                	lw	a0,0(a5)
 3be:	6422                	ld	s0,8(sp)
 3c0:	0141                	addi	sp,sp,16
 3c2:	8082                	ret

00000000000003c4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3c4:	4885                	li	a7,1
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <exit>:
.global exit
exit:
 li a7, SYS_exit
 3cc:	4889                	li	a7,2
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3d4:	488d                	li	a7,3
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3dc:	4891                	li	a7,4
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <read>:
.global read
read:
 li a7, SYS_read
 3e4:	4895                	li	a7,5
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <write>:
.global write
write:
 li a7, SYS_write
 3ec:	48c1                	li	a7,16
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <close>:
.global close
close:
 li a7, SYS_close
 3f4:	48d5                	li	a7,21
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <kill>:
.global kill
kill:
 li a7, SYS_kill
 3fc:	4899                	li	a7,6
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <exec>:
.global exec
exec:
 li a7, SYS_exec
 404:	489d                	li	a7,7
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <open>:
.global open
open:
 li a7, SYS_open
 40c:	48bd                	li	a7,15
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 414:	48c5                	li	a7,17
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 41c:	48c9                	li	a7,18
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 424:	48a1                	li	a7,8
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <link>:
.global link
link:
 li a7, SYS_link
 42c:	48cd                	li	a7,19
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 434:	48d1                	li	a7,20
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 43c:	48a5                	li	a7,9
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <dup>:
.global dup
dup:
 li a7, SYS_dup
 444:	48a9                	li	a7,10
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 44c:	48ad                	li	a7,11
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 454:	48b1                	li	a7,12
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 45c:	48b5                	li	a7,13
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 464:	48b9                	li	a7,14
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <trace>:
.global trace
trace:
 li a7, SYS_trace
 46c:	48d9                	li	a7,22
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 474:	48dd                	li	a7,23
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <connect>:
.global connect
connect:
 li a7, SYS_connect
 47c:	48f5                	li	a7,29
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 484:	48f9                	li	a7,30
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 48c:	1101                	addi	sp,sp,-32
 48e:	ec06                	sd	ra,24(sp)
 490:	e822                	sd	s0,16(sp)
 492:	1000                	addi	s0,sp,32
 494:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 498:	4605                	li	a2,1
 49a:	fef40593          	addi	a1,s0,-17
 49e:	00000097          	auipc	ra,0x0
 4a2:	f4e080e7          	jalr	-178(ra) # 3ec <write>
}
 4a6:	60e2                	ld	ra,24(sp)
 4a8:	6442                	ld	s0,16(sp)
 4aa:	6105                	addi	sp,sp,32
 4ac:	8082                	ret

00000000000004ae <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4ae:	7139                	addi	sp,sp,-64
 4b0:	fc06                	sd	ra,56(sp)
 4b2:	f822                	sd	s0,48(sp)
 4b4:	f426                	sd	s1,40(sp)
 4b6:	f04a                	sd	s2,32(sp)
 4b8:	ec4e                	sd	s3,24(sp)
 4ba:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4bc:	c299                	beqz	a3,4c2 <printint+0x14>
 4be:	0005cd63          	bltz	a1,4d8 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4c2:	2581                	sext.w	a1,a1
  neg = 0;
 4c4:	4301                	li	t1,0
 4c6:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 4ca:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 4cc:	2601                	sext.w	a2,a2
 4ce:	00000897          	auipc	a7,0x0
 4d2:	48288893          	addi	a7,a7,1154 # 950 <digits>
 4d6:	a039                	j	4e4 <printint+0x36>
    x = -xx;
 4d8:	40b005bb          	negw	a1,a1
    neg = 1;
 4dc:	4305                	li	t1,1
    x = -xx;
 4de:	b7e5                	j	4c6 <printint+0x18>
  }while((x /= base) != 0);
 4e0:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 4e2:	8836                	mv	a6,a3
 4e4:	0018069b          	addiw	a3,a6,1
 4e8:	02c5f7bb          	remuw	a5,a1,a2
 4ec:	1782                	slli	a5,a5,0x20
 4ee:	9381                	srli	a5,a5,0x20
 4f0:	97c6                	add	a5,a5,a7
 4f2:	0007c783          	lbu	a5,0(a5) # 4000000 <base+0x3ffeff0>
 4f6:	00f70023          	sb	a5,0(a4)
 4fa:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 4fc:	02c5d7bb          	divuw	a5,a1,a2
 500:	fec5f0e3          	bgeu	a1,a2,4e0 <printint+0x32>
  if(neg)
 504:	00030b63          	beqz	t1,51a <printint+0x6c>
    buf[i++] = '-';
 508:	fd040793          	addi	a5,s0,-48
 50c:	96be                	add	a3,a3,a5
 50e:	02d00793          	li	a5,45
 512:	fef68823          	sb	a5,-16(a3)
 516:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 51a:	02d05963          	blez	a3,54c <printint+0x9e>
 51e:	89aa                	mv	s3,a0
 520:	fc040793          	addi	a5,s0,-64
 524:	00d784b3          	add	s1,a5,a3
 528:	fff78913          	addi	s2,a5,-1
 52c:	9936                	add	s2,s2,a3
 52e:	36fd                	addiw	a3,a3,-1
 530:	1682                	slli	a3,a3,0x20
 532:	9281                	srli	a3,a3,0x20
 534:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 538:	fff4c583          	lbu	a1,-1(s1)
 53c:	854e                	mv	a0,s3
 53e:	00000097          	auipc	ra,0x0
 542:	f4e080e7          	jalr	-178(ra) # 48c <putc>
 546:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 548:	ff2498e3          	bne	s1,s2,538 <printint+0x8a>
}
 54c:	70e2                	ld	ra,56(sp)
 54e:	7442                	ld	s0,48(sp)
 550:	74a2                	ld	s1,40(sp)
 552:	7902                	ld	s2,32(sp)
 554:	69e2                	ld	s3,24(sp)
 556:	6121                	addi	sp,sp,64
 558:	8082                	ret

000000000000055a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 55a:	7119                	addi	sp,sp,-128
 55c:	fc86                	sd	ra,120(sp)
 55e:	f8a2                	sd	s0,112(sp)
 560:	f4a6                	sd	s1,104(sp)
 562:	f0ca                	sd	s2,96(sp)
 564:	ecce                	sd	s3,88(sp)
 566:	e8d2                	sd	s4,80(sp)
 568:	e4d6                	sd	s5,72(sp)
 56a:	e0da                	sd	s6,64(sp)
 56c:	fc5e                	sd	s7,56(sp)
 56e:	f862                	sd	s8,48(sp)
 570:	f466                	sd	s9,40(sp)
 572:	f06a                	sd	s10,32(sp)
 574:	ec6e                	sd	s11,24(sp)
 576:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 578:	0005c483          	lbu	s1,0(a1)
 57c:	18048d63          	beqz	s1,716 <vprintf+0x1bc>
 580:	8aaa                	mv	s5,a0
 582:	8b32                	mv	s6,a2
 584:	00158913          	addi	s2,a1,1
  state = 0;
 588:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 58a:	02500a13          	li	s4,37
      if(c == 'd'){
 58e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 592:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 596:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 59a:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 59e:	00000b97          	auipc	s7,0x0
 5a2:	3b2b8b93          	addi	s7,s7,946 # 950 <digits>
 5a6:	a839                	j	5c4 <vprintf+0x6a>
        putc(fd, c);
 5a8:	85a6                	mv	a1,s1
 5aa:	8556                	mv	a0,s5
 5ac:	00000097          	auipc	ra,0x0
 5b0:	ee0080e7          	jalr	-288(ra) # 48c <putc>
 5b4:	a019                	j	5ba <vprintf+0x60>
    } else if(state == '%'){
 5b6:	01498f63          	beq	s3,s4,5d4 <vprintf+0x7a>
 5ba:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 5bc:	fff94483          	lbu	s1,-1(s2)
 5c0:	14048b63          	beqz	s1,716 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 5c4:	0004879b          	sext.w	a5,s1
    if(state == 0){
 5c8:	fe0997e3          	bnez	s3,5b6 <vprintf+0x5c>
      if(c == '%'){
 5cc:	fd479ee3          	bne	a5,s4,5a8 <vprintf+0x4e>
        state = '%';
 5d0:	89be                	mv	s3,a5
 5d2:	b7e5                	j	5ba <vprintf+0x60>
      if(c == 'd'){
 5d4:	05878063          	beq	a5,s8,614 <vprintf+0xba>
      } else if(c == 'l') {
 5d8:	05978c63          	beq	a5,s9,630 <vprintf+0xd6>
      } else if(c == 'x') {
 5dc:	07a78863          	beq	a5,s10,64c <vprintf+0xf2>
      } else if(c == 'p') {
 5e0:	09b78463          	beq	a5,s11,668 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 5e4:	07300713          	li	a4,115
 5e8:	0ce78563          	beq	a5,a4,6b2 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ec:	06300713          	li	a4,99
 5f0:	0ee78c63          	beq	a5,a4,6e8 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 5f4:	11478663          	beq	a5,s4,700 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5f8:	85d2                	mv	a1,s4
 5fa:	8556                	mv	a0,s5
 5fc:	00000097          	auipc	ra,0x0
 600:	e90080e7          	jalr	-368(ra) # 48c <putc>
        putc(fd, c);
 604:	85a6                	mv	a1,s1
 606:	8556                	mv	a0,s5
 608:	00000097          	auipc	ra,0x0
 60c:	e84080e7          	jalr	-380(ra) # 48c <putc>
      }
      state = 0;
 610:	4981                	li	s3,0
 612:	b765                	j	5ba <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 614:	008b0493          	addi	s1,s6,8
 618:	4685                	li	a3,1
 61a:	4629                	li	a2,10
 61c:	000b2583          	lw	a1,0(s6)
 620:	8556                	mv	a0,s5
 622:	00000097          	auipc	ra,0x0
 626:	e8c080e7          	jalr	-372(ra) # 4ae <printint>
 62a:	8b26                	mv	s6,s1
      state = 0;
 62c:	4981                	li	s3,0
 62e:	b771                	j	5ba <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 630:	008b0493          	addi	s1,s6,8
 634:	4681                	li	a3,0
 636:	4629                	li	a2,10
 638:	000b2583          	lw	a1,0(s6)
 63c:	8556                	mv	a0,s5
 63e:	00000097          	auipc	ra,0x0
 642:	e70080e7          	jalr	-400(ra) # 4ae <printint>
 646:	8b26                	mv	s6,s1
      state = 0;
 648:	4981                	li	s3,0
 64a:	bf85                	j	5ba <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 64c:	008b0493          	addi	s1,s6,8
 650:	4681                	li	a3,0
 652:	4641                	li	a2,16
 654:	000b2583          	lw	a1,0(s6)
 658:	8556                	mv	a0,s5
 65a:	00000097          	auipc	ra,0x0
 65e:	e54080e7          	jalr	-428(ra) # 4ae <printint>
 662:	8b26                	mv	s6,s1
      state = 0;
 664:	4981                	li	s3,0
 666:	bf91                	j	5ba <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 668:	008b0793          	addi	a5,s6,8
 66c:	f8f43423          	sd	a5,-120(s0)
 670:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 674:	03000593          	li	a1,48
 678:	8556                	mv	a0,s5
 67a:	00000097          	auipc	ra,0x0
 67e:	e12080e7          	jalr	-494(ra) # 48c <putc>
  putc(fd, 'x');
 682:	85ea                	mv	a1,s10
 684:	8556                	mv	a0,s5
 686:	00000097          	auipc	ra,0x0
 68a:	e06080e7          	jalr	-506(ra) # 48c <putc>
 68e:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 690:	03c9d793          	srli	a5,s3,0x3c
 694:	97de                	add	a5,a5,s7
 696:	0007c583          	lbu	a1,0(a5)
 69a:	8556                	mv	a0,s5
 69c:	00000097          	auipc	ra,0x0
 6a0:	df0080e7          	jalr	-528(ra) # 48c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6a4:	0992                	slli	s3,s3,0x4
 6a6:	34fd                	addiw	s1,s1,-1
 6a8:	f4e5                	bnez	s1,690 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 6aa:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6ae:	4981                	li	s3,0
 6b0:	b729                	j	5ba <vprintf+0x60>
        s = va_arg(ap, char*);
 6b2:	008b0993          	addi	s3,s6,8
 6b6:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 6ba:	c085                	beqz	s1,6da <vprintf+0x180>
        while(*s != 0){
 6bc:	0004c583          	lbu	a1,0(s1)
 6c0:	c9a1                	beqz	a1,710 <vprintf+0x1b6>
          putc(fd, *s);
 6c2:	8556                	mv	a0,s5
 6c4:	00000097          	auipc	ra,0x0
 6c8:	dc8080e7          	jalr	-568(ra) # 48c <putc>
          s++;
 6cc:	0485                	addi	s1,s1,1
        while(*s != 0){
 6ce:	0004c583          	lbu	a1,0(s1)
 6d2:	f9e5                	bnez	a1,6c2 <vprintf+0x168>
        s = va_arg(ap, char*);
 6d4:	8b4e                	mv	s6,s3
      state = 0;
 6d6:	4981                	li	s3,0
 6d8:	b5cd                	j	5ba <vprintf+0x60>
          s = "(null)";
 6da:	00000497          	auipc	s1,0x0
 6de:	28e48493          	addi	s1,s1,654 # 968 <digits+0x18>
        while(*s != 0){
 6e2:	02800593          	li	a1,40
 6e6:	bff1                	j	6c2 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 6e8:	008b0493          	addi	s1,s6,8
 6ec:	000b4583          	lbu	a1,0(s6)
 6f0:	8556                	mv	a0,s5
 6f2:	00000097          	auipc	ra,0x0
 6f6:	d9a080e7          	jalr	-614(ra) # 48c <putc>
 6fa:	8b26                	mv	s6,s1
      state = 0;
 6fc:	4981                	li	s3,0
 6fe:	bd75                	j	5ba <vprintf+0x60>
        putc(fd, c);
 700:	85d2                	mv	a1,s4
 702:	8556                	mv	a0,s5
 704:	00000097          	auipc	ra,0x0
 708:	d88080e7          	jalr	-632(ra) # 48c <putc>
      state = 0;
 70c:	4981                	li	s3,0
 70e:	b575                	j	5ba <vprintf+0x60>
        s = va_arg(ap, char*);
 710:	8b4e                	mv	s6,s3
      state = 0;
 712:	4981                	li	s3,0
 714:	b55d                	j	5ba <vprintf+0x60>
    }
  }
}
 716:	70e6                	ld	ra,120(sp)
 718:	7446                	ld	s0,112(sp)
 71a:	74a6                	ld	s1,104(sp)
 71c:	7906                	ld	s2,96(sp)
 71e:	69e6                	ld	s3,88(sp)
 720:	6a46                	ld	s4,80(sp)
 722:	6aa6                	ld	s5,72(sp)
 724:	6b06                	ld	s6,64(sp)
 726:	7be2                	ld	s7,56(sp)
 728:	7c42                	ld	s8,48(sp)
 72a:	7ca2                	ld	s9,40(sp)
 72c:	7d02                	ld	s10,32(sp)
 72e:	6de2                	ld	s11,24(sp)
 730:	6109                	addi	sp,sp,128
 732:	8082                	ret

0000000000000734 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 734:	715d                	addi	sp,sp,-80
 736:	ec06                	sd	ra,24(sp)
 738:	e822                	sd	s0,16(sp)
 73a:	1000                	addi	s0,sp,32
 73c:	e010                	sd	a2,0(s0)
 73e:	e414                	sd	a3,8(s0)
 740:	e818                	sd	a4,16(s0)
 742:	ec1c                	sd	a5,24(s0)
 744:	03043023          	sd	a6,32(s0)
 748:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 74c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 750:	8622                	mv	a2,s0
 752:	00000097          	auipc	ra,0x0
 756:	e08080e7          	jalr	-504(ra) # 55a <vprintf>
}
 75a:	60e2                	ld	ra,24(sp)
 75c:	6442                	ld	s0,16(sp)
 75e:	6161                	addi	sp,sp,80
 760:	8082                	ret

0000000000000762 <printf>:

void
printf(const char *fmt, ...)
{
 762:	711d                	addi	sp,sp,-96
 764:	ec06                	sd	ra,24(sp)
 766:	e822                	sd	s0,16(sp)
 768:	1000                	addi	s0,sp,32
 76a:	e40c                	sd	a1,8(s0)
 76c:	e810                	sd	a2,16(s0)
 76e:	ec14                	sd	a3,24(s0)
 770:	f018                	sd	a4,32(s0)
 772:	f41c                	sd	a5,40(s0)
 774:	03043823          	sd	a6,48(s0)
 778:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 77c:	00840613          	addi	a2,s0,8
 780:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 784:	85aa                	mv	a1,a0
 786:	4505                	li	a0,1
 788:	00000097          	auipc	ra,0x0
 78c:	dd2080e7          	jalr	-558(ra) # 55a <vprintf>
}
 790:	60e2                	ld	ra,24(sp)
 792:	6442                	ld	s0,16(sp)
 794:	6125                	addi	sp,sp,96
 796:	8082                	ret

0000000000000798 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 798:	1141                	addi	sp,sp,-16
 79a:	e422                	sd	s0,8(sp)
 79c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 79e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a2:	00001797          	auipc	a5,0x1
 7a6:	85e78793          	addi	a5,a5,-1954 # 1000 <freep>
 7aa:	639c                	ld	a5,0(a5)
 7ac:	a805                	j	7dc <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7ae:	4618                	lw	a4,8(a2)
 7b0:	9db9                	addw	a1,a1,a4
 7b2:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7b6:	6398                	ld	a4,0(a5)
 7b8:	6318                	ld	a4,0(a4)
 7ba:	fee53823          	sd	a4,-16(a0)
 7be:	a091                	j	802 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7c0:	ff852703          	lw	a4,-8(a0)
 7c4:	9e39                	addw	a2,a2,a4
 7c6:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 7c8:	ff053703          	ld	a4,-16(a0)
 7cc:	e398                	sd	a4,0(a5)
 7ce:	a099                	j	814 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d0:	6398                	ld	a4,0(a5)
 7d2:	00e7e463          	bltu	a5,a4,7da <free+0x42>
 7d6:	00e6ea63          	bltu	a3,a4,7ea <free+0x52>
{
 7da:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7dc:	fed7fae3          	bgeu	a5,a3,7d0 <free+0x38>
 7e0:	6398                	ld	a4,0(a5)
 7e2:	00e6e463          	bltu	a3,a4,7ea <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7e6:	fee7eae3          	bltu	a5,a4,7da <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 7ea:	ff852583          	lw	a1,-8(a0)
 7ee:	6390                	ld	a2,0(a5)
 7f0:	02059713          	slli	a4,a1,0x20
 7f4:	9301                	srli	a4,a4,0x20
 7f6:	0712                	slli	a4,a4,0x4
 7f8:	9736                	add	a4,a4,a3
 7fa:	fae60ae3          	beq	a2,a4,7ae <free+0x16>
    bp->s.ptr = p->s.ptr;
 7fe:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 802:	4790                	lw	a2,8(a5)
 804:	02061713          	slli	a4,a2,0x20
 808:	9301                	srli	a4,a4,0x20
 80a:	0712                	slli	a4,a4,0x4
 80c:	973e                	add	a4,a4,a5
 80e:	fae689e3          	beq	a3,a4,7c0 <free+0x28>
  } else
    p->s.ptr = bp;
 812:	e394                	sd	a3,0(a5)
  freep = p;
 814:	00000717          	auipc	a4,0x0
 818:	7ef73623          	sd	a5,2028(a4) # 1000 <freep>
}
 81c:	6422                	ld	s0,8(sp)
 81e:	0141                	addi	sp,sp,16
 820:	8082                	ret

0000000000000822 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 822:	7139                	addi	sp,sp,-64
 824:	fc06                	sd	ra,56(sp)
 826:	f822                	sd	s0,48(sp)
 828:	f426                	sd	s1,40(sp)
 82a:	f04a                	sd	s2,32(sp)
 82c:	ec4e                	sd	s3,24(sp)
 82e:	e852                	sd	s4,16(sp)
 830:	e456                	sd	s5,8(sp)
 832:	e05a                	sd	s6,0(sp)
 834:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 836:	02051993          	slli	s3,a0,0x20
 83a:	0209d993          	srli	s3,s3,0x20
 83e:	09bd                	addi	s3,s3,15
 840:	0049d993          	srli	s3,s3,0x4
 844:	2985                	addiw	s3,s3,1
 846:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 84a:	00000797          	auipc	a5,0x0
 84e:	7b678793          	addi	a5,a5,1974 # 1000 <freep>
 852:	6388                	ld	a0,0(a5)
 854:	c515                	beqz	a0,880 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 856:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 858:	4798                	lw	a4,8(a5)
 85a:	03277f63          	bgeu	a4,s2,898 <malloc+0x76>
 85e:	8a4e                	mv	s4,s3
 860:	0009871b          	sext.w	a4,s3
 864:	6685                	lui	a3,0x1
 866:	00d77363          	bgeu	a4,a3,86c <malloc+0x4a>
 86a:	6a05                	lui	s4,0x1
 86c:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 870:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 874:	00000497          	auipc	s1,0x0
 878:	78c48493          	addi	s1,s1,1932 # 1000 <freep>
  if(p == (char*)-1)
 87c:	5b7d                	li	s6,-1
 87e:	a885                	j	8ee <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 880:	00000797          	auipc	a5,0x0
 884:	79078793          	addi	a5,a5,1936 # 1010 <base>
 888:	00000717          	auipc	a4,0x0
 88c:	76f73c23          	sd	a5,1912(a4) # 1000 <freep>
 890:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 892:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 896:	b7e1                	j	85e <malloc+0x3c>
      if(p->s.size == nunits)
 898:	02e90b63          	beq	s2,a4,8ce <malloc+0xac>
        p->s.size -= nunits;
 89c:	4137073b          	subw	a4,a4,s3
 8a0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8a2:	1702                	slli	a4,a4,0x20
 8a4:	9301                	srli	a4,a4,0x20
 8a6:	0712                	slli	a4,a4,0x4
 8a8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8aa:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8ae:	00000717          	auipc	a4,0x0
 8b2:	74a73923          	sd	a0,1874(a4) # 1000 <freep>
      return (void*)(p + 1);
 8b6:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8ba:	70e2                	ld	ra,56(sp)
 8bc:	7442                	ld	s0,48(sp)
 8be:	74a2                	ld	s1,40(sp)
 8c0:	7902                	ld	s2,32(sp)
 8c2:	69e2                	ld	s3,24(sp)
 8c4:	6a42                	ld	s4,16(sp)
 8c6:	6aa2                	ld	s5,8(sp)
 8c8:	6b02                	ld	s6,0(sp)
 8ca:	6121                	addi	sp,sp,64
 8cc:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8ce:	6398                	ld	a4,0(a5)
 8d0:	e118                	sd	a4,0(a0)
 8d2:	bff1                	j	8ae <malloc+0x8c>
  hp->s.size = nu;
 8d4:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 8d8:	0541                	addi	a0,a0,16
 8da:	00000097          	auipc	ra,0x0
 8de:	ebe080e7          	jalr	-322(ra) # 798 <free>
  return freep;
 8e2:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 8e4:	d979                	beqz	a0,8ba <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8e8:	4798                	lw	a4,8(a5)
 8ea:	fb2777e3          	bgeu	a4,s2,898 <malloc+0x76>
    if(p == freep)
 8ee:	6098                	ld	a4,0(s1)
 8f0:	853e                	mv	a0,a5
 8f2:	fef71ae3          	bne	a4,a5,8e6 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 8f6:	8552                	mv	a0,s4
 8f8:	00000097          	auipc	ra,0x0
 8fc:	b5c080e7          	jalr	-1188(ra) # 454 <sbrk>
  if(p == (char*)-1)
 900:	fd651ae3          	bne	a0,s6,8d4 <malloc+0xb2>
        return 0;
 904:	4501                	li	a0,0
 906:	bf55                	j	8ba <malloc+0x98>
