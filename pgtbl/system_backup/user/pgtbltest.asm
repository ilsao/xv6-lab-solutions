
user/_pgtbltest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <err>:

char *testname = "???";

void
err(char *why)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
   c:	892a                	mv	s2,a0
  printf("pgtbltest: %s failed: %s, pid=%d\n", testname, why, getpid());
   e:	00001797          	auipc	a5,0x1
  12:	ff278793          	addi	a5,a5,-14 # 1000 <testname>
  16:	6384                	ld	s1,0(a5)
  18:	00000097          	auipc	ra,0x0
  1c:	52e080e7          	jalr	1326(ra) # 546 <getpid>
  20:	86aa                	mv	a3,a0
  22:	864a                	mv	a2,s2
  24:	85a6                	mv	a1,s1
  26:	00001517          	auipc	a0,0x1
  2a:	9ea50513          	addi	a0,a0,-1558 # a10 <malloc+0xf4>
  2e:	00001097          	auipc	ra,0x1
  32:	82e080e7          	jalr	-2002(ra) # 85c <printf>
  exit(1);
  36:	4505                	li	a0,1
  38:	00000097          	auipc	ra,0x0
  3c:	48e080e7          	jalr	1166(ra) # 4c6 <exit>

0000000000000040 <ugetpid_test>:
}

void
ugetpid_test()
{
  40:	7179                	addi	sp,sp,-48
  42:	f406                	sd	ra,40(sp)
  44:	f022                	sd	s0,32(sp)
  46:	ec26                	sd	s1,24(sp)
  48:	1800                	addi	s0,sp,48
  int i;

  printf("ugetpid_test starting\n");
  4a:	00001517          	auipc	a0,0x1
  4e:	9ee50513          	addi	a0,a0,-1554 # a38 <malloc+0x11c>
  52:	00001097          	auipc	ra,0x1
  56:	80a080e7          	jalr	-2038(ra) # 85c <printf>
  testname = "ugetpid_test";
  5a:	00001797          	auipc	a5,0x1
  5e:	9f678793          	addi	a5,a5,-1546 # a50 <malloc+0x134>
  62:	00001717          	auipc	a4,0x1
  66:	f8f73f23          	sd	a5,-98(a4) # 1000 <testname>
  6a:	04000493          	li	s1,64

  for (i = 0; i < 64; i++) {
    int ret = fork();
  6e:	00000097          	auipc	ra,0x0
  72:	450080e7          	jalr	1104(ra) # 4be <fork>
  76:	fca42e23          	sw	a0,-36(s0)
    if (ret != 0) {
  7a:	cd15                	beqz	a0,b6 <ugetpid_test+0x76>
      wait(&ret);
  7c:	fdc40513          	addi	a0,s0,-36
  80:	00000097          	auipc	ra,0x0
  84:	44e080e7          	jalr	1102(ra) # 4ce <wait>
      if (ret != 0)
  88:	fdc42783          	lw	a5,-36(s0)
  8c:	e385                	bnez	a5,ac <ugetpid_test+0x6c>
        exit(1);
      continue;
  8e:	34fd                	addiw	s1,s1,-1
  for (i = 0; i < 64; i++) {
  90:	fcf9                	bnez	s1,6e <ugetpid_test+0x2e>
    }
    if (getpid() != ugetpid())
      err("missmatched PID");
    exit(0);
  }
  printf("ugetpid_test: OK\n");
  92:	00001517          	auipc	a0,0x1
  96:	9de50513          	addi	a0,a0,-1570 # a70 <malloc+0x154>
  9a:	00000097          	auipc	ra,0x0
  9e:	7c2080e7          	jalr	1986(ra) # 85c <printf>
}
  a2:	70a2                	ld	ra,40(sp)
  a4:	7402                	ld	s0,32(sp)
  a6:	64e2                	ld	s1,24(sp)
  a8:	6145                	addi	sp,sp,48
  aa:	8082                	ret
        exit(1);
  ac:	4505                	li	a0,1
  ae:	00000097          	auipc	ra,0x0
  b2:	418080e7          	jalr	1048(ra) # 4c6 <exit>
    if (getpid() != ugetpid())
  b6:	00000097          	auipc	ra,0x0
  ba:	490080e7          	jalr	1168(ra) # 546 <getpid>
  be:	84aa                	mv	s1,a0
  c0:	00000097          	auipc	ra,0x0
  c4:	3e8080e7          	jalr	1000(ra) # 4a8 <ugetpid>
  c8:	00a48a63          	beq	s1,a0,dc <ugetpid_test+0x9c>
      err("missmatched PID");
  cc:	00001517          	auipc	a0,0x1
  d0:	99450513          	addi	a0,a0,-1644 # a60 <malloc+0x144>
  d4:	00000097          	auipc	ra,0x0
  d8:	f2c080e7          	jalr	-212(ra) # 0 <err>
    exit(0);
  dc:	4501                	li	a0,0
  de:	00000097          	auipc	ra,0x0
  e2:	3e8080e7          	jalr	1000(ra) # 4c6 <exit>

00000000000000e6 <pgaccess_test>:

void
pgaccess_test()
{
  e6:	7179                	addi	sp,sp,-48
  e8:	f406                	sd	ra,40(sp)
  ea:	f022                	sd	s0,32(sp)
  ec:	ec26                	sd	s1,24(sp)
  ee:	1800                	addi	s0,sp,48
  char *buf;
  unsigned int abits;
  printf("pgaccess_test starting\n");
  f0:	00001517          	auipc	a0,0x1
  f4:	99850513          	addi	a0,a0,-1640 # a88 <malloc+0x16c>
  f8:	00000097          	auipc	ra,0x0
  fc:	764080e7          	jalr	1892(ra) # 85c <printf>
  testname = "pgaccess_test";
 100:	00001797          	auipc	a5,0x1
 104:	9a078793          	addi	a5,a5,-1632 # aa0 <malloc+0x184>
 108:	00001717          	auipc	a4,0x1
 10c:	eef73c23          	sd	a5,-264(a4) # 1000 <testname>
  buf = malloc(32 * PGSIZE);
 110:	00020537          	lui	a0,0x20
 114:	00001097          	auipc	ra,0x1
 118:	808080e7          	jalr	-2040(ra) # 91c <malloc>
 11c:	84aa                	mv	s1,a0
  if (pgaccess(buf, 32, &abits) < 0)
 11e:	fdc40613          	addi	a2,s0,-36
 122:	02000593          	li	a1,32
 126:	00000097          	auipc	ra,0x0
 12a:	458080e7          	jalr	1112(ra) # 57e <pgaccess>
 12e:	06054b63          	bltz	a0,1a4 <pgaccess_test+0xbe>
    err("pgaccess failed");
  buf[PGSIZE * 1] += 1;
 132:	6785                	lui	a5,0x1
 134:	97a6                	add	a5,a5,s1
 136:	0007c703          	lbu	a4,0(a5) # 1000 <testname>
 13a:	2705                	addiw	a4,a4,1
 13c:	00e78023          	sb	a4,0(a5)
  buf[PGSIZE * 2] += 1;
 140:	6789                	lui	a5,0x2
 142:	97a6                	add	a5,a5,s1
 144:	0007c703          	lbu	a4,0(a5) # 2000 <base+0xfe0>
 148:	2705                	addiw	a4,a4,1
 14a:	00e78023          	sb	a4,0(a5)
  buf[PGSIZE * 30] += 1;
 14e:	67f9                	lui	a5,0x1e
 150:	97a6                	add	a5,a5,s1
 152:	0007c703          	lbu	a4,0(a5) # 1e000 <base+0x1cfe0>
 156:	2705                	addiw	a4,a4,1
 158:	00e78023          	sb	a4,0(a5)
  if (pgaccess(buf, 32, &abits) < 0)
 15c:	fdc40613          	addi	a2,s0,-36
 160:	02000593          	li	a1,32
 164:	8526                	mv	a0,s1
 166:	00000097          	auipc	ra,0x0
 16a:	418080e7          	jalr	1048(ra) # 57e <pgaccess>
 16e:	04054363          	bltz	a0,1b4 <pgaccess_test+0xce>
    err("pgaccess failed");
  if (abits != ((1 << 1) | (1 << 2) | (1 << 30)))
 172:	fdc42703          	lw	a4,-36(s0)
 176:	400007b7          	lui	a5,0x40000
 17a:	0799                	addi	a5,a5,6
 17c:	04f71463          	bne	a4,a5,1c4 <pgaccess_test+0xde>
    err("incorrect access bits set");
  free(buf);
 180:	8526                	mv	a0,s1
 182:	00000097          	auipc	ra,0x0
 186:	710080e7          	jalr	1808(ra) # 892 <free>
  printf("pgaccess_test: OK\n");
 18a:	00001517          	auipc	a0,0x1
 18e:	95650513          	addi	a0,a0,-1706 # ae0 <malloc+0x1c4>
 192:	00000097          	auipc	ra,0x0
 196:	6ca080e7          	jalr	1738(ra) # 85c <printf>
}
 19a:	70a2                	ld	ra,40(sp)
 19c:	7402                	ld	s0,32(sp)
 19e:	64e2                	ld	s1,24(sp)
 1a0:	6145                	addi	sp,sp,48
 1a2:	8082                	ret
    err("pgaccess failed");
 1a4:	00001517          	auipc	a0,0x1
 1a8:	90c50513          	addi	a0,a0,-1780 # ab0 <malloc+0x194>
 1ac:	00000097          	auipc	ra,0x0
 1b0:	e54080e7          	jalr	-428(ra) # 0 <err>
    err("pgaccess failed");
 1b4:	00001517          	auipc	a0,0x1
 1b8:	8fc50513          	addi	a0,a0,-1796 # ab0 <malloc+0x194>
 1bc:	00000097          	auipc	ra,0x0
 1c0:	e44080e7          	jalr	-444(ra) # 0 <err>
    err("incorrect access bits set");
 1c4:	00001517          	auipc	a0,0x1
 1c8:	8fc50513          	addi	a0,a0,-1796 # ac0 <malloc+0x1a4>
 1cc:	00000097          	auipc	ra,0x0
 1d0:	e34080e7          	jalr	-460(ra) # 0 <err>

00000000000001d4 <main>:
{
 1d4:	1141                	addi	sp,sp,-16
 1d6:	e406                	sd	ra,8(sp)
 1d8:	e022                	sd	s0,0(sp)
 1da:	0800                	addi	s0,sp,16
  ugetpid_test();
 1dc:	00000097          	auipc	ra,0x0
 1e0:	e64080e7          	jalr	-412(ra) # 40 <ugetpid_test>
  pgaccess_test();
 1e4:	00000097          	auipc	ra,0x0
 1e8:	f02080e7          	jalr	-254(ra) # e6 <pgaccess_test>
  printf("pgtbltest: all tests succeeded\n");
 1ec:	00001517          	auipc	a0,0x1
 1f0:	90c50513          	addi	a0,a0,-1780 # af8 <malloc+0x1dc>
 1f4:	00000097          	auipc	ra,0x0
 1f8:	668080e7          	jalr	1640(ra) # 85c <printf>
  exit(0);
 1fc:	4501                	li	a0,0
 1fe:	00000097          	auipc	ra,0x0
 202:	2c8080e7          	jalr	712(ra) # 4c6 <exit>

0000000000000206 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 206:	1141                	addi	sp,sp,-16
 208:	e406                	sd	ra,8(sp)
 20a:	e022                	sd	s0,0(sp)
 20c:	0800                	addi	s0,sp,16
  extern int main();
  main();
 20e:	00000097          	auipc	ra,0x0
 212:	fc6080e7          	jalr	-58(ra) # 1d4 <main>
  exit(0);
 216:	4501                	li	a0,0
 218:	00000097          	auipc	ra,0x0
 21c:	2ae080e7          	jalr	686(ra) # 4c6 <exit>

0000000000000220 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 220:	1141                	addi	sp,sp,-16
 222:	e422                	sd	s0,8(sp)
 224:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 226:	87aa                	mv	a5,a0
 228:	0585                	addi	a1,a1,1
 22a:	0785                	addi	a5,a5,1
 22c:	fff5c703          	lbu	a4,-1(a1)
 230:	fee78fa3          	sb	a4,-1(a5) # 3fffffff <base+0x3fffefdf>
 234:	fb75                	bnez	a4,228 <strcpy+0x8>
    ;
  return os;
}
 236:	6422                	ld	s0,8(sp)
 238:	0141                	addi	sp,sp,16
 23a:	8082                	ret

000000000000023c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 23c:	1141                	addi	sp,sp,-16
 23e:	e422                	sd	s0,8(sp)
 240:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 242:	00054783          	lbu	a5,0(a0)
 246:	cf91                	beqz	a5,262 <strcmp+0x26>
 248:	0005c703          	lbu	a4,0(a1)
 24c:	00f71b63          	bne	a4,a5,262 <strcmp+0x26>
    p++, q++;
 250:	0505                	addi	a0,a0,1
 252:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 254:	00054783          	lbu	a5,0(a0)
 258:	c789                	beqz	a5,262 <strcmp+0x26>
 25a:	0005c703          	lbu	a4,0(a1)
 25e:	fef709e3          	beq	a4,a5,250 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 262:	0005c503          	lbu	a0,0(a1)
}
 266:	40a7853b          	subw	a0,a5,a0
 26a:	6422                	ld	s0,8(sp)
 26c:	0141                	addi	sp,sp,16
 26e:	8082                	ret

0000000000000270 <strlen>:

uint
strlen(const char *s)
{
 270:	1141                	addi	sp,sp,-16
 272:	e422                	sd	s0,8(sp)
 274:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 276:	00054783          	lbu	a5,0(a0)
 27a:	cf91                	beqz	a5,296 <strlen+0x26>
 27c:	0505                	addi	a0,a0,1
 27e:	87aa                	mv	a5,a0
 280:	4685                	li	a3,1
 282:	9e89                	subw	a3,a3,a0
    ;
 284:	00f6853b          	addw	a0,a3,a5
 288:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
 28a:	fff7c703          	lbu	a4,-1(a5)
 28e:	fb7d                	bnez	a4,284 <strlen+0x14>
  return n;
}
 290:	6422                	ld	s0,8(sp)
 292:	0141                	addi	sp,sp,16
 294:	8082                	ret
  for(n = 0; s[n]; n++)
 296:	4501                	li	a0,0
 298:	bfe5                	j	290 <strlen+0x20>

000000000000029a <memset>:

void*
memset(void *dst, int c, uint n)
{
 29a:	1141                	addi	sp,sp,-16
 29c:	e422                	sd	s0,8(sp)
 29e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2a0:	ce09                	beqz	a2,2ba <memset+0x20>
 2a2:	87aa                	mv	a5,a0
 2a4:	fff6071b          	addiw	a4,a2,-1
 2a8:	1702                	slli	a4,a4,0x20
 2aa:	9301                	srli	a4,a4,0x20
 2ac:	0705                	addi	a4,a4,1
 2ae:	972a                	add	a4,a4,a0
    cdst[i] = c;
 2b0:	00b78023          	sb	a1,0(a5)
 2b4:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 2b6:	fee79de3          	bne	a5,a4,2b0 <memset+0x16>
  }
  return dst;
}
 2ba:	6422                	ld	s0,8(sp)
 2bc:	0141                	addi	sp,sp,16
 2be:	8082                	ret

00000000000002c0 <strchr>:

char*
strchr(const char *s, char c)
{
 2c0:	1141                	addi	sp,sp,-16
 2c2:	e422                	sd	s0,8(sp)
 2c4:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2c6:	00054783          	lbu	a5,0(a0)
 2ca:	cf91                	beqz	a5,2e6 <strchr+0x26>
    if(*s == c)
 2cc:	00f58a63          	beq	a1,a5,2e0 <strchr+0x20>
  for(; *s; s++)
 2d0:	0505                	addi	a0,a0,1
 2d2:	00054783          	lbu	a5,0(a0)
 2d6:	c781                	beqz	a5,2de <strchr+0x1e>
    if(*s == c)
 2d8:	feb79ce3          	bne	a5,a1,2d0 <strchr+0x10>
 2dc:	a011                	j	2e0 <strchr+0x20>
      return (char*)s;
  return 0;
 2de:	4501                	li	a0,0
}
 2e0:	6422                	ld	s0,8(sp)
 2e2:	0141                	addi	sp,sp,16
 2e4:	8082                	ret
  return 0;
 2e6:	4501                	li	a0,0
 2e8:	bfe5                	j	2e0 <strchr+0x20>

00000000000002ea <gets>:

char*
gets(char *buf, int max)
{
 2ea:	711d                	addi	sp,sp,-96
 2ec:	ec86                	sd	ra,88(sp)
 2ee:	e8a2                	sd	s0,80(sp)
 2f0:	e4a6                	sd	s1,72(sp)
 2f2:	e0ca                	sd	s2,64(sp)
 2f4:	fc4e                	sd	s3,56(sp)
 2f6:	f852                	sd	s4,48(sp)
 2f8:	f456                	sd	s5,40(sp)
 2fa:	f05a                	sd	s6,32(sp)
 2fc:	ec5e                	sd	s7,24(sp)
 2fe:	1080                	addi	s0,sp,96
 300:	8baa                	mv	s7,a0
 302:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 304:	892a                	mv	s2,a0
 306:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 308:	4aa9                	li	s5,10
 30a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 30c:	0019849b          	addiw	s1,s3,1
 310:	0344d863          	bge	s1,s4,340 <gets+0x56>
    cc = read(0, &c, 1);
 314:	4605                	li	a2,1
 316:	faf40593          	addi	a1,s0,-81
 31a:	4501                	li	a0,0
 31c:	00000097          	auipc	ra,0x0
 320:	1c2080e7          	jalr	450(ra) # 4de <read>
    if(cc < 1)
 324:	00a05e63          	blez	a0,340 <gets+0x56>
    buf[i++] = c;
 328:	faf44783          	lbu	a5,-81(s0)
 32c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 330:	01578763          	beq	a5,s5,33e <gets+0x54>
 334:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 336:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 338:	fd679ae3          	bne	a5,s6,30c <gets+0x22>
 33c:	a011                	j	340 <gets+0x56>
  for(i=0; i+1 < max; ){
 33e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 340:	99de                	add	s3,s3,s7
 342:	00098023          	sb	zero,0(s3)
  return buf;
}
 346:	855e                	mv	a0,s7
 348:	60e6                	ld	ra,88(sp)
 34a:	6446                	ld	s0,80(sp)
 34c:	64a6                	ld	s1,72(sp)
 34e:	6906                	ld	s2,64(sp)
 350:	79e2                	ld	s3,56(sp)
 352:	7a42                	ld	s4,48(sp)
 354:	7aa2                	ld	s5,40(sp)
 356:	7b02                	ld	s6,32(sp)
 358:	6be2                	ld	s7,24(sp)
 35a:	6125                	addi	sp,sp,96
 35c:	8082                	ret

000000000000035e <stat>:

int
stat(const char *n, struct stat *st)
{
 35e:	1101                	addi	sp,sp,-32
 360:	ec06                	sd	ra,24(sp)
 362:	e822                	sd	s0,16(sp)
 364:	e426                	sd	s1,8(sp)
 366:	e04a                	sd	s2,0(sp)
 368:	1000                	addi	s0,sp,32
 36a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 36c:	4581                	li	a1,0
 36e:	00000097          	auipc	ra,0x0
 372:	198080e7          	jalr	408(ra) # 506 <open>
  if(fd < 0)
 376:	02054563          	bltz	a0,3a0 <stat+0x42>
 37a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 37c:	85ca                	mv	a1,s2
 37e:	00000097          	auipc	ra,0x0
 382:	1a0080e7          	jalr	416(ra) # 51e <fstat>
 386:	892a                	mv	s2,a0
  close(fd);
 388:	8526                	mv	a0,s1
 38a:	00000097          	auipc	ra,0x0
 38e:	164080e7          	jalr	356(ra) # 4ee <close>
  return r;
}
 392:	854a                	mv	a0,s2
 394:	60e2                	ld	ra,24(sp)
 396:	6442                	ld	s0,16(sp)
 398:	64a2                	ld	s1,8(sp)
 39a:	6902                	ld	s2,0(sp)
 39c:	6105                	addi	sp,sp,32
 39e:	8082                	ret
    return -1;
 3a0:	597d                	li	s2,-1
 3a2:	bfc5                	j	392 <stat+0x34>

00000000000003a4 <atoi>:

int
atoi(const char *s)
{
 3a4:	1141                	addi	sp,sp,-16
 3a6:	e422                	sd	s0,8(sp)
 3a8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3aa:	00054683          	lbu	a3,0(a0)
 3ae:	fd06879b          	addiw	a5,a3,-48
 3b2:	0ff7f793          	andi	a5,a5,255
 3b6:	4725                	li	a4,9
 3b8:	02f76963          	bltu	a4,a5,3ea <atoi+0x46>
 3bc:	862a                	mv	a2,a0
  n = 0;
 3be:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 3c0:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 3c2:	0605                	addi	a2,a2,1
 3c4:	0025179b          	slliw	a5,a0,0x2
 3c8:	9fa9                	addw	a5,a5,a0
 3ca:	0017979b          	slliw	a5,a5,0x1
 3ce:	9fb5                	addw	a5,a5,a3
 3d0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3d4:	00064683          	lbu	a3,0(a2)
 3d8:	fd06871b          	addiw	a4,a3,-48
 3dc:	0ff77713          	andi	a4,a4,255
 3e0:	fee5f1e3          	bgeu	a1,a4,3c2 <atoi+0x1e>
  return n;
}
 3e4:	6422                	ld	s0,8(sp)
 3e6:	0141                	addi	sp,sp,16
 3e8:	8082                	ret
  n = 0;
 3ea:	4501                	li	a0,0
 3ec:	bfe5                	j	3e4 <atoi+0x40>

00000000000003ee <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3ee:	1141                	addi	sp,sp,-16
 3f0:	e422                	sd	s0,8(sp)
 3f2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3f4:	02b57663          	bgeu	a0,a1,420 <memmove+0x32>
    while(n-- > 0)
 3f8:	02c05163          	blez	a2,41a <memmove+0x2c>
 3fc:	fff6079b          	addiw	a5,a2,-1
 400:	1782                	slli	a5,a5,0x20
 402:	9381                	srli	a5,a5,0x20
 404:	0785                	addi	a5,a5,1
 406:	97aa                	add	a5,a5,a0
  dst = vdst;
 408:	872a                	mv	a4,a0
      *dst++ = *src++;
 40a:	0585                	addi	a1,a1,1
 40c:	0705                	addi	a4,a4,1
 40e:	fff5c683          	lbu	a3,-1(a1)
 412:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 416:	fee79ae3          	bne	a5,a4,40a <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 41a:	6422                	ld	s0,8(sp)
 41c:	0141                	addi	sp,sp,16
 41e:	8082                	ret
    dst += n;
 420:	00c50733          	add	a4,a0,a2
    src += n;
 424:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 426:	fec05ae3          	blez	a2,41a <memmove+0x2c>
 42a:	fff6079b          	addiw	a5,a2,-1
 42e:	1782                	slli	a5,a5,0x20
 430:	9381                	srli	a5,a5,0x20
 432:	fff7c793          	not	a5,a5
 436:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 438:	15fd                	addi	a1,a1,-1
 43a:	177d                	addi	a4,a4,-1
 43c:	0005c683          	lbu	a3,0(a1)
 440:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 444:	fef71ae3          	bne	a4,a5,438 <memmove+0x4a>
 448:	bfc9                	j	41a <memmove+0x2c>

000000000000044a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 44a:	1141                	addi	sp,sp,-16
 44c:	e422                	sd	s0,8(sp)
 44e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 450:	ce15                	beqz	a2,48c <memcmp+0x42>
 452:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 456:	00054783          	lbu	a5,0(a0)
 45a:	0005c703          	lbu	a4,0(a1)
 45e:	02e79063          	bne	a5,a4,47e <memcmp+0x34>
 462:	1682                	slli	a3,a3,0x20
 464:	9281                	srli	a3,a3,0x20
 466:	0685                	addi	a3,a3,1
 468:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 46a:	0505                	addi	a0,a0,1
    p2++;
 46c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 46e:	00d50d63          	beq	a0,a3,488 <memcmp+0x3e>
    if (*p1 != *p2) {
 472:	00054783          	lbu	a5,0(a0)
 476:	0005c703          	lbu	a4,0(a1)
 47a:	fee788e3          	beq	a5,a4,46a <memcmp+0x20>
      return *p1 - *p2;
 47e:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 482:	6422                	ld	s0,8(sp)
 484:	0141                	addi	sp,sp,16
 486:	8082                	ret
  return 0;
 488:	4501                	li	a0,0
 48a:	bfe5                	j	482 <memcmp+0x38>
 48c:	4501                	li	a0,0
 48e:	bfd5                	j	482 <memcmp+0x38>

0000000000000490 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 490:	1141                	addi	sp,sp,-16
 492:	e406                	sd	ra,8(sp)
 494:	e022                	sd	s0,0(sp)
 496:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 498:	00000097          	auipc	ra,0x0
 49c:	f56080e7          	jalr	-170(ra) # 3ee <memmove>
}
 4a0:	60a2                	ld	ra,8(sp)
 4a2:	6402                	ld	s0,0(sp)
 4a4:	0141                	addi	sp,sp,16
 4a6:	8082                	ret

00000000000004a8 <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 4a8:	1141                	addi	sp,sp,-16
 4aa:	e422                	sd	s0,8(sp)
 4ac:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 4ae:	040007b7          	lui	a5,0x4000
}
 4b2:	17f5                	addi	a5,a5,-3
 4b4:	07b2                	slli	a5,a5,0xc
 4b6:	4388                	lw	a0,0(a5)
 4b8:	6422                	ld	s0,8(sp)
 4ba:	0141                	addi	sp,sp,16
 4bc:	8082                	ret

00000000000004be <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4be:	4885                	li	a7,1
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4c6:	4889                	li	a7,2
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <wait>:
.global wait
wait:
 li a7, SYS_wait
 4ce:	488d                	li	a7,3
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4d6:	4891                	li	a7,4
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <read>:
.global read
read:
 li a7, SYS_read
 4de:	4895                	li	a7,5
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <write>:
.global write
write:
 li a7, SYS_write
 4e6:	48c1                	li	a7,16
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <close>:
.global close
close:
 li a7, SYS_close
 4ee:	48d5                	li	a7,21
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4f6:	4899                	li	a7,6
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <exec>:
.global exec
exec:
 li a7, SYS_exec
 4fe:	489d                	li	a7,7
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <open>:
.global open
open:
 li a7, SYS_open
 506:	48bd                	li	a7,15
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 50e:	48c5                	li	a7,17
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 516:	48c9                	li	a7,18
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 51e:	48a1                	li	a7,8
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <link>:
.global link
link:
 li a7, SYS_link
 526:	48cd                	li	a7,19
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 52e:	48d1                	li	a7,20
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 536:	48a5                	li	a7,9
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <dup>:
.global dup
dup:
 li a7, SYS_dup
 53e:	48a9                	li	a7,10
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 546:	48ad                	li	a7,11
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 54e:	48b1                	li	a7,12
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 556:	48b5                	li	a7,13
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 55e:	48b9                	li	a7,14
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <trace>:
.global trace
trace:
 li a7, SYS_trace
 566:	48d9                	li	a7,22
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 56e:	48dd                	li	a7,23
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <connect>:
.global connect
connect:
 li a7, SYS_connect
 576:	48f5                	li	a7,29
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 57e:	48f9                	li	a7,30
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 586:	1101                	addi	sp,sp,-32
 588:	ec06                	sd	ra,24(sp)
 58a:	e822                	sd	s0,16(sp)
 58c:	1000                	addi	s0,sp,32
 58e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 592:	4605                	li	a2,1
 594:	fef40593          	addi	a1,s0,-17
 598:	00000097          	auipc	ra,0x0
 59c:	f4e080e7          	jalr	-178(ra) # 4e6 <write>
}
 5a0:	60e2                	ld	ra,24(sp)
 5a2:	6442                	ld	s0,16(sp)
 5a4:	6105                	addi	sp,sp,32
 5a6:	8082                	ret

00000000000005a8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5a8:	7139                	addi	sp,sp,-64
 5aa:	fc06                	sd	ra,56(sp)
 5ac:	f822                	sd	s0,48(sp)
 5ae:	f426                	sd	s1,40(sp)
 5b0:	f04a                	sd	s2,32(sp)
 5b2:	ec4e                	sd	s3,24(sp)
 5b4:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5b6:	c299                	beqz	a3,5bc <printint+0x14>
 5b8:	0005cd63          	bltz	a1,5d2 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5bc:	2581                	sext.w	a1,a1
  neg = 0;
 5be:	4301                	li	t1,0
 5c0:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 5c4:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 5c6:	2601                	sext.w	a2,a2
 5c8:	00000897          	auipc	a7,0x0
 5cc:	55888893          	addi	a7,a7,1368 # b20 <digits>
 5d0:	a039                	j	5de <printint+0x36>
    x = -xx;
 5d2:	40b005bb          	negw	a1,a1
    neg = 1;
 5d6:	4305                	li	t1,1
    x = -xx;
 5d8:	b7e5                	j	5c0 <printint+0x18>
  }while((x /= base) != 0);
 5da:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 5dc:	8836                	mv	a6,a3
 5de:	0018069b          	addiw	a3,a6,1
 5e2:	02c5f7bb          	remuw	a5,a1,a2
 5e6:	1782                	slli	a5,a5,0x20
 5e8:	9381                	srli	a5,a5,0x20
 5ea:	97c6                	add	a5,a5,a7
 5ec:	0007c783          	lbu	a5,0(a5) # 4000000 <base+0x3ffefe0>
 5f0:	00f70023          	sb	a5,0(a4)
 5f4:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 5f6:	02c5d7bb          	divuw	a5,a1,a2
 5fa:	fec5f0e3          	bgeu	a1,a2,5da <printint+0x32>
  if(neg)
 5fe:	00030b63          	beqz	t1,614 <printint+0x6c>
    buf[i++] = '-';
 602:	fd040793          	addi	a5,s0,-48
 606:	96be                	add	a3,a3,a5
 608:	02d00793          	li	a5,45
 60c:	fef68823          	sb	a5,-16(a3)
 610:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 614:	02d05963          	blez	a3,646 <printint+0x9e>
 618:	89aa                	mv	s3,a0
 61a:	fc040793          	addi	a5,s0,-64
 61e:	00d784b3          	add	s1,a5,a3
 622:	fff78913          	addi	s2,a5,-1
 626:	9936                	add	s2,s2,a3
 628:	36fd                	addiw	a3,a3,-1
 62a:	1682                	slli	a3,a3,0x20
 62c:	9281                	srli	a3,a3,0x20
 62e:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 632:	fff4c583          	lbu	a1,-1(s1)
 636:	854e                	mv	a0,s3
 638:	00000097          	auipc	ra,0x0
 63c:	f4e080e7          	jalr	-178(ra) # 586 <putc>
 640:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 642:	ff2498e3          	bne	s1,s2,632 <printint+0x8a>
}
 646:	70e2                	ld	ra,56(sp)
 648:	7442                	ld	s0,48(sp)
 64a:	74a2                	ld	s1,40(sp)
 64c:	7902                	ld	s2,32(sp)
 64e:	69e2                	ld	s3,24(sp)
 650:	6121                	addi	sp,sp,64
 652:	8082                	ret

0000000000000654 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 654:	7119                	addi	sp,sp,-128
 656:	fc86                	sd	ra,120(sp)
 658:	f8a2                	sd	s0,112(sp)
 65a:	f4a6                	sd	s1,104(sp)
 65c:	f0ca                	sd	s2,96(sp)
 65e:	ecce                	sd	s3,88(sp)
 660:	e8d2                	sd	s4,80(sp)
 662:	e4d6                	sd	s5,72(sp)
 664:	e0da                	sd	s6,64(sp)
 666:	fc5e                	sd	s7,56(sp)
 668:	f862                	sd	s8,48(sp)
 66a:	f466                	sd	s9,40(sp)
 66c:	f06a                	sd	s10,32(sp)
 66e:	ec6e                	sd	s11,24(sp)
 670:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 672:	0005c483          	lbu	s1,0(a1)
 676:	18048d63          	beqz	s1,810 <vprintf+0x1bc>
 67a:	8aaa                	mv	s5,a0
 67c:	8b32                	mv	s6,a2
 67e:	00158913          	addi	s2,a1,1
  state = 0;
 682:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 684:	02500a13          	li	s4,37
      if(c == 'd'){
 688:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 68c:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 690:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 694:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 698:	00000b97          	auipc	s7,0x0
 69c:	488b8b93          	addi	s7,s7,1160 # b20 <digits>
 6a0:	a839                	j	6be <vprintf+0x6a>
        putc(fd, c);
 6a2:	85a6                	mv	a1,s1
 6a4:	8556                	mv	a0,s5
 6a6:	00000097          	auipc	ra,0x0
 6aa:	ee0080e7          	jalr	-288(ra) # 586 <putc>
 6ae:	a019                	j	6b4 <vprintf+0x60>
    } else if(state == '%'){
 6b0:	01498f63          	beq	s3,s4,6ce <vprintf+0x7a>
 6b4:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 6b6:	fff94483          	lbu	s1,-1(s2)
 6ba:	14048b63          	beqz	s1,810 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 6be:	0004879b          	sext.w	a5,s1
    if(state == 0){
 6c2:	fe0997e3          	bnez	s3,6b0 <vprintf+0x5c>
      if(c == '%'){
 6c6:	fd479ee3          	bne	a5,s4,6a2 <vprintf+0x4e>
        state = '%';
 6ca:	89be                	mv	s3,a5
 6cc:	b7e5                	j	6b4 <vprintf+0x60>
      if(c == 'd'){
 6ce:	05878063          	beq	a5,s8,70e <vprintf+0xba>
      } else if(c == 'l') {
 6d2:	05978c63          	beq	a5,s9,72a <vprintf+0xd6>
      } else if(c == 'x') {
 6d6:	07a78863          	beq	a5,s10,746 <vprintf+0xf2>
      } else if(c == 'p') {
 6da:	09b78463          	beq	a5,s11,762 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6de:	07300713          	li	a4,115
 6e2:	0ce78563          	beq	a5,a4,7ac <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6e6:	06300713          	li	a4,99
 6ea:	0ee78c63          	beq	a5,a4,7e2 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6ee:	11478663          	beq	a5,s4,7fa <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6f2:	85d2                	mv	a1,s4
 6f4:	8556                	mv	a0,s5
 6f6:	00000097          	auipc	ra,0x0
 6fa:	e90080e7          	jalr	-368(ra) # 586 <putc>
        putc(fd, c);
 6fe:	85a6                	mv	a1,s1
 700:	8556                	mv	a0,s5
 702:	00000097          	auipc	ra,0x0
 706:	e84080e7          	jalr	-380(ra) # 586 <putc>
      }
      state = 0;
 70a:	4981                	li	s3,0
 70c:	b765                	j	6b4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 70e:	008b0493          	addi	s1,s6,8
 712:	4685                	li	a3,1
 714:	4629                	li	a2,10
 716:	000b2583          	lw	a1,0(s6)
 71a:	8556                	mv	a0,s5
 71c:	00000097          	auipc	ra,0x0
 720:	e8c080e7          	jalr	-372(ra) # 5a8 <printint>
 724:	8b26                	mv	s6,s1
      state = 0;
 726:	4981                	li	s3,0
 728:	b771                	j	6b4 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 72a:	008b0493          	addi	s1,s6,8
 72e:	4681                	li	a3,0
 730:	4629                	li	a2,10
 732:	000b2583          	lw	a1,0(s6)
 736:	8556                	mv	a0,s5
 738:	00000097          	auipc	ra,0x0
 73c:	e70080e7          	jalr	-400(ra) # 5a8 <printint>
 740:	8b26                	mv	s6,s1
      state = 0;
 742:	4981                	li	s3,0
 744:	bf85                	j	6b4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 746:	008b0493          	addi	s1,s6,8
 74a:	4681                	li	a3,0
 74c:	4641                	li	a2,16
 74e:	000b2583          	lw	a1,0(s6)
 752:	8556                	mv	a0,s5
 754:	00000097          	auipc	ra,0x0
 758:	e54080e7          	jalr	-428(ra) # 5a8 <printint>
 75c:	8b26                	mv	s6,s1
      state = 0;
 75e:	4981                	li	s3,0
 760:	bf91                	j	6b4 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 762:	008b0793          	addi	a5,s6,8
 766:	f8f43423          	sd	a5,-120(s0)
 76a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 76e:	03000593          	li	a1,48
 772:	8556                	mv	a0,s5
 774:	00000097          	auipc	ra,0x0
 778:	e12080e7          	jalr	-494(ra) # 586 <putc>
  putc(fd, 'x');
 77c:	85ea                	mv	a1,s10
 77e:	8556                	mv	a0,s5
 780:	00000097          	auipc	ra,0x0
 784:	e06080e7          	jalr	-506(ra) # 586 <putc>
 788:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 78a:	03c9d793          	srli	a5,s3,0x3c
 78e:	97de                	add	a5,a5,s7
 790:	0007c583          	lbu	a1,0(a5)
 794:	8556                	mv	a0,s5
 796:	00000097          	auipc	ra,0x0
 79a:	df0080e7          	jalr	-528(ra) # 586 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 79e:	0992                	slli	s3,s3,0x4
 7a0:	34fd                	addiw	s1,s1,-1
 7a2:	f4e5                	bnez	s1,78a <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 7a4:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7a8:	4981                	li	s3,0
 7aa:	b729                	j	6b4 <vprintf+0x60>
        s = va_arg(ap, char*);
 7ac:	008b0993          	addi	s3,s6,8
 7b0:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 7b4:	c085                	beqz	s1,7d4 <vprintf+0x180>
        while(*s != 0){
 7b6:	0004c583          	lbu	a1,0(s1)
 7ba:	c9a1                	beqz	a1,80a <vprintf+0x1b6>
          putc(fd, *s);
 7bc:	8556                	mv	a0,s5
 7be:	00000097          	auipc	ra,0x0
 7c2:	dc8080e7          	jalr	-568(ra) # 586 <putc>
          s++;
 7c6:	0485                	addi	s1,s1,1
        while(*s != 0){
 7c8:	0004c583          	lbu	a1,0(s1)
 7cc:	f9e5                	bnez	a1,7bc <vprintf+0x168>
        s = va_arg(ap, char*);
 7ce:	8b4e                	mv	s6,s3
      state = 0;
 7d0:	4981                	li	s3,0
 7d2:	b5cd                	j	6b4 <vprintf+0x60>
          s = "(null)";
 7d4:	00000497          	auipc	s1,0x0
 7d8:	36448493          	addi	s1,s1,868 # b38 <digits+0x18>
        while(*s != 0){
 7dc:	02800593          	li	a1,40
 7e0:	bff1                	j	7bc <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 7e2:	008b0493          	addi	s1,s6,8
 7e6:	000b4583          	lbu	a1,0(s6)
 7ea:	8556                	mv	a0,s5
 7ec:	00000097          	auipc	ra,0x0
 7f0:	d9a080e7          	jalr	-614(ra) # 586 <putc>
 7f4:	8b26                	mv	s6,s1
      state = 0;
 7f6:	4981                	li	s3,0
 7f8:	bd75                	j	6b4 <vprintf+0x60>
        putc(fd, c);
 7fa:	85d2                	mv	a1,s4
 7fc:	8556                	mv	a0,s5
 7fe:	00000097          	auipc	ra,0x0
 802:	d88080e7          	jalr	-632(ra) # 586 <putc>
      state = 0;
 806:	4981                	li	s3,0
 808:	b575                	j	6b4 <vprintf+0x60>
        s = va_arg(ap, char*);
 80a:	8b4e                	mv	s6,s3
      state = 0;
 80c:	4981                	li	s3,0
 80e:	b55d                	j	6b4 <vprintf+0x60>
    }
  }
}
 810:	70e6                	ld	ra,120(sp)
 812:	7446                	ld	s0,112(sp)
 814:	74a6                	ld	s1,104(sp)
 816:	7906                	ld	s2,96(sp)
 818:	69e6                	ld	s3,88(sp)
 81a:	6a46                	ld	s4,80(sp)
 81c:	6aa6                	ld	s5,72(sp)
 81e:	6b06                	ld	s6,64(sp)
 820:	7be2                	ld	s7,56(sp)
 822:	7c42                	ld	s8,48(sp)
 824:	7ca2                	ld	s9,40(sp)
 826:	7d02                	ld	s10,32(sp)
 828:	6de2                	ld	s11,24(sp)
 82a:	6109                	addi	sp,sp,128
 82c:	8082                	ret

000000000000082e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 82e:	715d                	addi	sp,sp,-80
 830:	ec06                	sd	ra,24(sp)
 832:	e822                	sd	s0,16(sp)
 834:	1000                	addi	s0,sp,32
 836:	e010                	sd	a2,0(s0)
 838:	e414                	sd	a3,8(s0)
 83a:	e818                	sd	a4,16(s0)
 83c:	ec1c                	sd	a5,24(s0)
 83e:	03043023          	sd	a6,32(s0)
 842:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 846:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 84a:	8622                	mv	a2,s0
 84c:	00000097          	auipc	ra,0x0
 850:	e08080e7          	jalr	-504(ra) # 654 <vprintf>
}
 854:	60e2                	ld	ra,24(sp)
 856:	6442                	ld	s0,16(sp)
 858:	6161                	addi	sp,sp,80
 85a:	8082                	ret

000000000000085c <printf>:

void
printf(const char *fmt, ...)
{
 85c:	711d                	addi	sp,sp,-96
 85e:	ec06                	sd	ra,24(sp)
 860:	e822                	sd	s0,16(sp)
 862:	1000                	addi	s0,sp,32
 864:	e40c                	sd	a1,8(s0)
 866:	e810                	sd	a2,16(s0)
 868:	ec14                	sd	a3,24(s0)
 86a:	f018                	sd	a4,32(s0)
 86c:	f41c                	sd	a5,40(s0)
 86e:	03043823          	sd	a6,48(s0)
 872:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 876:	00840613          	addi	a2,s0,8
 87a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 87e:	85aa                	mv	a1,a0
 880:	4505                	li	a0,1
 882:	00000097          	auipc	ra,0x0
 886:	dd2080e7          	jalr	-558(ra) # 654 <vprintf>
}
 88a:	60e2                	ld	ra,24(sp)
 88c:	6442                	ld	s0,16(sp)
 88e:	6125                	addi	sp,sp,96
 890:	8082                	ret

0000000000000892 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 892:	1141                	addi	sp,sp,-16
 894:	e422                	sd	s0,8(sp)
 896:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 898:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 89c:	00000797          	auipc	a5,0x0
 8a0:	77478793          	addi	a5,a5,1908 # 1010 <freep>
 8a4:	639c                	ld	a5,0(a5)
 8a6:	a805                	j	8d6 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8a8:	4618                	lw	a4,8(a2)
 8aa:	9db9                	addw	a1,a1,a4
 8ac:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8b0:	6398                	ld	a4,0(a5)
 8b2:	6318                	ld	a4,0(a4)
 8b4:	fee53823          	sd	a4,-16(a0)
 8b8:	a091                	j	8fc <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8ba:	ff852703          	lw	a4,-8(a0)
 8be:	9e39                	addw	a2,a2,a4
 8c0:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 8c2:	ff053703          	ld	a4,-16(a0)
 8c6:	e398                	sd	a4,0(a5)
 8c8:	a099                	j	90e <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ca:	6398                	ld	a4,0(a5)
 8cc:	00e7e463          	bltu	a5,a4,8d4 <free+0x42>
 8d0:	00e6ea63          	bltu	a3,a4,8e4 <free+0x52>
{
 8d4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d6:	fed7fae3          	bgeu	a5,a3,8ca <free+0x38>
 8da:	6398                	ld	a4,0(a5)
 8dc:	00e6e463          	bltu	a3,a4,8e4 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8e0:	fee7eae3          	bltu	a5,a4,8d4 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 8e4:	ff852583          	lw	a1,-8(a0)
 8e8:	6390                	ld	a2,0(a5)
 8ea:	02059713          	slli	a4,a1,0x20
 8ee:	9301                	srli	a4,a4,0x20
 8f0:	0712                	slli	a4,a4,0x4
 8f2:	9736                	add	a4,a4,a3
 8f4:	fae60ae3          	beq	a2,a4,8a8 <free+0x16>
    bp->s.ptr = p->s.ptr;
 8f8:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8fc:	4790                	lw	a2,8(a5)
 8fe:	02061713          	slli	a4,a2,0x20
 902:	9301                	srli	a4,a4,0x20
 904:	0712                	slli	a4,a4,0x4
 906:	973e                	add	a4,a4,a5
 908:	fae689e3          	beq	a3,a4,8ba <free+0x28>
  } else
    p->s.ptr = bp;
 90c:	e394                	sd	a3,0(a5)
  freep = p;
 90e:	00000717          	auipc	a4,0x0
 912:	70f73123          	sd	a5,1794(a4) # 1010 <freep>
}
 916:	6422                	ld	s0,8(sp)
 918:	0141                	addi	sp,sp,16
 91a:	8082                	ret

000000000000091c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 91c:	7139                	addi	sp,sp,-64
 91e:	fc06                	sd	ra,56(sp)
 920:	f822                	sd	s0,48(sp)
 922:	f426                	sd	s1,40(sp)
 924:	f04a                	sd	s2,32(sp)
 926:	ec4e                	sd	s3,24(sp)
 928:	e852                	sd	s4,16(sp)
 92a:	e456                	sd	s5,8(sp)
 92c:	e05a                	sd	s6,0(sp)
 92e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 930:	02051993          	slli	s3,a0,0x20
 934:	0209d993          	srli	s3,s3,0x20
 938:	09bd                	addi	s3,s3,15
 93a:	0049d993          	srli	s3,s3,0x4
 93e:	2985                	addiw	s3,s3,1
 940:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 944:	00000797          	auipc	a5,0x0
 948:	6cc78793          	addi	a5,a5,1740 # 1010 <freep>
 94c:	6388                	ld	a0,0(a5)
 94e:	c515                	beqz	a0,97a <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 950:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 952:	4798                	lw	a4,8(a5)
 954:	03277f63          	bgeu	a4,s2,992 <malloc+0x76>
 958:	8a4e                	mv	s4,s3
 95a:	0009871b          	sext.w	a4,s3
 95e:	6685                	lui	a3,0x1
 960:	00d77363          	bgeu	a4,a3,966 <malloc+0x4a>
 964:	6a05                	lui	s4,0x1
 966:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 96a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 96e:	00000497          	auipc	s1,0x0
 972:	6a248493          	addi	s1,s1,1698 # 1010 <freep>
  if(p == (char*)-1)
 976:	5b7d                	li	s6,-1
 978:	a885                	j	9e8 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 97a:	00000797          	auipc	a5,0x0
 97e:	6a678793          	addi	a5,a5,1702 # 1020 <base>
 982:	00000717          	auipc	a4,0x0
 986:	68f73723          	sd	a5,1678(a4) # 1010 <freep>
 98a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 98c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 990:	b7e1                	j	958 <malloc+0x3c>
      if(p->s.size == nunits)
 992:	02e90b63          	beq	s2,a4,9c8 <malloc+0xac>
        p->s.size -= nunits;
 996:	4137073b          	subw	a4,a4,s3
 99a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 99c:	1702                	slli	a4,a4,0x20
 99e:	9301                	srli	a4,a4,0x20
 9a0:	0712                	slli	a4,a4,0x4
 9a2:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9a4:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9a8:	00000717          	auipc	a4,0x0
 9ac:	66a73423          	sd	a0,1640(a4) # 1010 <freep>
      return (void*)(p + 1);
 9b0:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9b4:	70e2                	ld	ra,56(sp)
 9b6:	7442                	ld	s0,48(sp)
 9b8:	74a2                	ld	s1,40(sp)
 9ba:	7902                	ld	s2,32(sp)
 9bc:	69e2                	ld	s3,24(sp)
 9be:	6a42                	ld	s4,16(sp)
 9c0:	6aa2                	ld	s5,8(sp)
 9c2:	6b02                	ld	s6,0(sp)
 9c4:	6121                	addi	sp,sp,64
 9c6:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9c8:	6398                	ld	a4,0(a5)
 9ca:	e118                	sd	a4,0(a0)
 9cc:	bff1                	j	9a8 <malloc+0x8c>
  hp->s.size = nu;
 9ce:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 9d2:	0541                	addi	a0,a0,16
 9d4:	00000097          	auipc	ra,0x0
 9d8:	ebe080e7          	jalr	-322(ra) # 892 <free>
  return freep;
 9dc:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 9de:	d979                	beqz	a0,9b4 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9e2:	4798                	lw	a4,8(a5)
 9e4:	fb2777e3          	bgeu	a4,s2,992 <malloc+0x76>
    if(p == freep)
 9e8:	6098                	ld	a4,0(s1)
 9ea:	853e                	mv	a0,a5
 9ec:	fef71ae3          	bne	a4,a5,9e0 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 9f0:	8552                	mv	a0,s4
 9f2:	00000097          	auipc	ra,0x0
 9f6:	b5c080e7          	jalr	-1188(ra) # 54e <sbrk>
  if(p == (char*)-1)
 9fa:	fd651ae3          	bne	a0,s6,9ce <malloc+0xb2>
        return 0;
 9fe:	4501                	li	a0,0
 a00:	bf55                	j	9b4 <malloc+0x98>
