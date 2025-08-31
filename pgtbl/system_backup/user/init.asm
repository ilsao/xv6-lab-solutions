
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   c:	4589                	li	a1,2
   e:	00001517          	auipc	a0,0x1
  12:	8f250513          	addi	a0,a0,-1806 # 900 <malloc+0xf2>
  16:	00000097          	auipc	ra,0x0
  1a:	3e2080e7          	jalr	994(ra) # 3f8 <open>
  1e:	06054363          	bltz	a0,84 <main+0x84>
    mknod("console", CONSOLE, 0);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  22:	4501                	li	a0,0
  24:	00000097          	auipc	ra,0x0
  28:	40c080e7          	jalr	1036(ra) # 430 <dup>
  dup(0);  // stderr
  2c:	4501                	li	a0,0
  2e:	00000097          	auipc	ra,0x0
  32:	402080e7          	jalr	1026(ra) # 430 <dup>

  for(;;){
    printf("init: starting sh\n");
  36:	00001917          	auipc	s2,0x1
  3a:	8d290913          	addi	s2,s2,-1838 # 908 <malloc+0xfa>
  3e:	854a                	mv	a0,s2
  40:	00000097          	auipc	ra,0x0
  44:	70e080e7          	jalr	1806(ra) # 74e <printf>
    pid = fork();
  48:	00000097          	auipc	ra,0x0
  4c:	368080e7          	jalr	872(ra) # 3b0 <fork>
  50:	84aa                	mv	s1,a0
    if(pid < 0){
  52:	04054d63          	bltz	a0,ac <main+0xac>
      printf("init: fork failed\n");
      exit(1);
    }
    if(pid == 0){
  56:	c925                	beqz	a0,c6 <main+0xc6>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  58:	4501                	li	a0,0
  5a:	00000097          	auipc	ra,0x0
  5e:	366080e7          	jalr	870(ra) # 3c0 <wait>
      if(wpid == pid){
  62:	fca48ee3          	beq	s1,a0,3e <main+0x3e>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  66:	fe0559e3          	bgez	a0,58 <main+0x58>
        printf("init: wait returned an error\n");
  6a:	00001517          	auipc	a0,0x1
  6e:	8ee50513          	addi	a0,a0,-1810 # 958 <malloc+0x14a>
  72:	00000097          	auipc	ra,0x0
  76:	6dc080e7          	jalr	1756(ra) # 74e <printf>
        exit(1);
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	33c080e7          	jalr	828(ra) # 3b8 <exit>
    mknod("console", CONSOLE, 0);
  84:	4601                	li	a2,0
  86:	4585                	li	a1,1
  88:	00001517          	auipc	a0,0x1
  8c:	87850513          	addi	a0,a0,-1928 # 900 <malloc+0xf2>
  90:	00000097          	auipc	ra,0x0
  94:	370080e7          	jalr	880(ra) # 400 <mknod>
    open("console", O_RDWR);
  98:	4589                	li	a1,2
  9a:	00001517          	auipc	a0,0x1
  9e:	86650513          	addi	a0,a0,-1946 # 900 <malloc+0xf2>
  a2:	00000097          	auipc	ra,0x0
  a6:	356080e7          	jalr	854(ra) # 3f8 <open>
  aa:	bfa5                	j	22 <main+0x22>
      printf("init: fork failed\n");
  ac:	00001517          	auipc	a0,0x1
  b0:	87450513          	addi	a0,a0,-1932 # 920 <malloc+0x112>
  b4:	00000097          	auipc	ra,0x0
  b8:	69a080e7          	jalr	1690(ra) # 74e <printf>
      exit(1);
  bc:	4505                	li	a0,1
  be:	00000097          	auipc	ra,0x0
  c2:	2fa080e7          	jalr	762(ra) # 3b8 <exit>
      exec("sh", argv);
  c6:	00001597          	auipc	a1,0x1
  ca:	f3a58593          	addi	a1,a1,-198 # 1000 <argv>
  ce:	00001517          	auipc	a0,0x1
  d2:	86a50513          	addi	a0,a0,-1942 # 938 <malloc+0x12a>
  d6:	00000097          	auipc	ra,0x0
  da:	31a080e7          	jalr	794(ra) # 3f0 <exec>
      printf("init: exec sh failed\n");
  de:	00001517          	auipc	a0,0x1
  e2:	86250513          	addi	a0,a0,-1950 # 940 <malloc+0x132>
  e6:	00000097          	auipc	ra,0x0
  ea:	668080e7          	jalr	1640(ra) # 74e <printf>
      exit(1);
  ee:	4505                	li	a0,1
  f0:	00000097          	auipc	ra,0x0
  f4:	2c8080e7          	jalr	712(ra) # 3b8 <exit>

00000000000000f8 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  f8:	1141                	addi	sp,sp,-16
  fa:	e406                	sd	ra,8(sp)
  fc:	e022                	sd	s0,0(sp)
  fe:	0800                	addi	s0,sp,16
  extern int main();
  main();
 100:	00000097          	auipc	ra,0x0
 104:	f00080e7          	jalr	-256(ra) # 0 <main>
  exit(0);
 108:	4501                	li	a0,0
 10a:	00000097          	auipc	ra,0x0
 10e:	2ae080e7          	jalr	686(ra) # 3b8 <exit>

0000000000000112 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 112:	1141                	addi	sp,sp,-16
 114:	e422                	sd	s0,8(sp)
 116:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 118:	87aa                	mv	a5,a0
 11a:	0585                	addi	a1,a1,1
 11c:	0785                	addi	a5,a5,1
 11e:	fff5c703          	lbu	a4,-1(a1)
 122:	fee78fa3          	sb	a4,-1(a5)
 126:	fb75                	bnez	a4,11a <strcpy+0x8>
    ;
  return os;
}
 128:	6422                	ld	s0,8(sp)
 12a:	0141                	addi	sp,sp,16
 12c:	8082                	ret

000000000000012e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 12e:	1141                	addi	sp,sp,-16
 130:	e422                	sd	s0,8(sp)
 132:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 134:	00054783          	lbu	a5,0(a0)
 138:	cf91                	beqz	a5,154 <strcmp+0x26>
 13a:	0005c703          	lbu	a4,0(a1)
 13e:	00f71b63          	bne	a4,a5,154 <strcmp+0x26>
    p++, q++;
 142:	0505                	addi	a0,a0,1
 144:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 146:	00054783          	lbu	a5,0(a0)
 14a:	c789                	beqz	a5,154 <strcmp+0x26>
 14c:	0005c703          	lbu	a4,0(a1)
 150:	fef709e3          	beq	a4,a5,142 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 154:	0005c503          	lbu	a0,0(a1)
}
 158:	40a7853b          	subw	a0,a5,a0
 15c:	6422                	ld	s0,8(sp)
 15e:	0141                	addi	sp,sp,16
 160:	8082                	ret

0000000000000162 <strlen>:

uint
strlen(const char *s)
{
 162:	1141                	addi	sp,sp,-16
 164:	e422                	sd	s0,8(sp)
 166:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 168:	00054783          	lbu	a5,0(a0)
 16c:	cf91                	beqz	a5,188 <strlen+0x26>
 16e:	0505                	addi	a0,a0,1
 170:	87aa                	mv	a5,a0
 172:	4685                	li	a3,1
 174:	9e89                	subw	a3,a3,a0
    ;
 176:	00f6853b          	addw	a0,a3,a5
 17a:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
 17c:	fff7c703          	lbu	a4,-1(a5)
 180:	fb7d                	bnez	a4,176 <strlen+0x14>
  return n;
}
 182:	6422                	ld	s0,8(sp)
 184:	0141                	addi	sp,sp,16
 186:	8082                	ret
  for(n = 0; s[n]; n++)
 188:	4501                	li	a0,0
 18a:	bfe5                	j	182 <strlen+0x20>

000000000000018c <memset>:

void*
memset(void *dst, int c, uint n)
{
 18c:	1141                	addi	sp,sp,-16
 18e:	e422                	sd	s0,8(sp)
 190:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 192:	ce09                	beqz	a2,1ac <memset+0x20>
 194:	87aa                	mv	a5,a0
 196:	fff6071b          	addiw	a4,a2,-1
 19a:	1702                	slli	a4,a4,0x20
 19c:	9301                	srli	a4,a4,0x20
 19e:	0705                	addi	a4,a4,1
 1a0:	972a                	add	a4,a4,a0
    cdst[i] = c;
 1a2:	00b78023          	sb	a1,0(a5)
 1a6:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 1a8:	fee79de3          	bne	a5,a4,1a2 <memset+0x16>
  }
  return dst;
}
 1ac:	6422                	ld	s0,8(sp)
 1ae:	0141                	addi	sp,sp,16
 1b0:	8082                	ret

00000000000001b2 <strchr>:

char*
strchr(const char *s, char c)
{
 1b2:	1141                	addi	sp,sp,-16
 1b4:	e422                	sd	s0,8(sp)
 1b6:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1b8:	00054783          	lbu	a5,0(a0)
 1bc:	cf91                	beqz	a5,1d8 <strchr+0x26>
    if(*s == c)
 1be:	00f58a63          	beq	a1,a5,1d2 <strchr+0x20>
  for(; *s; s++)
 1c2:	0505                	addi	a0,a0,1
 1c4:	00054783          	lbu	a5,0(a0)
 1c8:	c781                	beqz	a5,1d0 <strchr+0x1e>
    if(*s == c)
 1ca:	feb79ce3          	bne	a5,a1,1c2 <strchr+0x10>
 1ce:	a011                	j	1d2 <strchr+0x20>
      return (char*)s;
  return 0;
 1d0:	4501                	li	a0,0
}
 1d2:	6422                	ld	s0,8(sp)
 1d4:	0141                	addi	sp,sp,16
 1d6:	8082                	ret
  return 0;
 1d8:	4501                	li	a0,0
 1da:	bfe5                	j	1d2 <strchr+0x20>

00000000000001dc <gets>:

char*
gets(char *buf, int max)
{
 1dc:	711d                	addi	sp,sp,-96
 1de:	ec86                	sd	ra,88(sp)
 1e0:	e8a2                	sd	s0,80(sp)
 1e2:	e4a6                	sd	s1,72(sp)
 1e4:	e0ca                	sd	s2,64(sp)
 1e6:	fc4e                	sd	s3,56(sp)
 1e8:	f852                	sd	s4,48(sp)
 1ea:	f456                	sd	s5,40(sp)
 1ec:	f05a                	sd	s6,32(sp)
 1ee:	ec5e                	sd	s7,24(sp)
 1f0:	1080                	addi	s0,sp,96
 1f2:	8baa                	mv	s7,a0
 1f4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f6:	892a                	mv	s2,a0
 1f8:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1fa:	4aa9                	li	s5,10
 1fc:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1fe:	0019849b          	addiw	s1,s3,1
 202:	0344d863          	bge	s1,s4,232 <gets+0x56>
    cc = read(0, &c, 1);
 206:	4605                	li	a2,1
 208:	faf40593          	addi	a1,s0,-81
 20c:	4501                	li	a0,0
 20e:	00000097          	auipc	ra,0x0
 212:	1c2080e7          	jalr	450(ra) # 3d0 <read>
    if(cc < 1)
 216:	00a05e63          	blez	a0,232 <gets+0x56>
    buf[i++] = c;
 21a:	faf44783          	lbu	a5,-81(s0)
 21e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 222:	01578763          	beq	a5,s5,230 <gets+0x54>
 226:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 228:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 22a:	fd679ae3          	bne	a5,s6,1fe <gets+0x22>
 22e:	a011                	j	232 <gets+0x56>
  for(i=0; i+1 < max; ){
 230:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 232:	99de                	add	s3,s3,s7
 234:	00098023          	sb	zero,0(s3)
  return buf;
}
 238:	855e                	mv	a0,s7
 23a:	60e6                	ld	ra,88(sp)
 23c:	6446                	ld	s0,80(sp)
 23e:	64a6                	ld	s1,72(sp)
 240:	6906                	ld	s2,64(sp)
 242:	79e2                	ld	s3,56(sp)
 244:	7a42                	ld	s4,48(sp)
 246:	7aa2                	ld	s5,40(sp)
 248:	7b02                	ld	s6,32(sp)
 24a:	6be2                	ld	s7,24(sp)
 24c:	6125                	addi	sp,sp,96
 24e:	8082                	ret

0000000000000250 <stat>:

int
stat(const char *n, struct stat *st)
{
 250:	1101                	addi	sp,sp,-32
 252:	ec06                	sd	ra,24(sp)
 254:	e822                	sd	s0,16(sp)
 256:	e426                	sd	s1,8(sp)
 258:	e04a                	sd	s2,0(sp)
 25a:	1000                	addi	s0,sp,32
 25c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 25e:	4581                	li	a1,0
 260:	00000097          	auipc	ra,0x0
 264:	198080e7          	jalr	408(ra) # 3f8 <open>
  if(fd < 0)
 268:	02054563          	bltz	a0,292 <stat+0x42>
 26c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 26e:	85ca                	mv	a1,s2
 270:	00000097          	auipc	ra,0x0
 274:	1a0080e7          	jalr	416(ra) # 410 <fstat>
 278:	892a                	mv	s2,a0
  close(fd);
 27a:	8526                	mv	a0,s1
 27c:	00000097          	auipc	ra,0x0
 280:	164080e7          	jalr	356(ra) # 3e0 <close>
  return r;
}
 284:	854a                	mv	a0,s2
 286:	60e2                	ld	ra,24(sp)
 288:	6442                	ld	s0,16(sp)
 28a:	64a2                	ld	s1,8(sp)
 28c:	6902                	ld	s2,0(sp)
 28e:	6105                	addi	sp,sp,32
 290:	8082                	ret
    return -1;
 292:	597d                	li	s2,-1
 294:	bfc5                	j	284 <stat+0x34>

0000000000000296 <atoi>:

int
atoi(const char *s)
{
 296:	1141                	addi	sp,sp,-16
 298:	e422                	sd	s0,8(sp)
 29a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 29c:	00054683          	lbu	a3,0(a0)
 2a0:	fd06879b          	addiw	a5,a3,-48
 2a4:	0ff7f793          	andi	a5,a5,255
 2a8:	4725                	li	a4,9
 2aa:	02f76963          	bltu	a4,a5,2dc <atoi+0x46>
 2ae:	862a                	mv	a2,a0
  n = 0;
 2b0:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 2b2:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2b4:	0605                	addi	a2,a2,1
 2b6:	0025179b          	slliw	a5,a0,0x2
 2ba:	9fa9                	addw	a5,a5,a0
 2bc:	0017979b          	slliw	a5,a5,0x1
 2c0:	9fb5                	addw	a5,a5,a3
 2c2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2c6:	00064683          	lbu	a3,0(a2)
 2ca:	fd06871b          	addiw	a4,a3,-48
 2ce:	0ff77713          	andi	a4,a4,255
 2d2:	fee5f1e3          	bgeu	a1,a4,2b4 <atoi+0x1e>
  return n;
}
 2d6:	6422                	ld	s0,8(sp)
 2d8:	0141                	addi	sp,sp,16
 2da:	8082                	ret
  n = 0;
 2dc:	4501                	li	a0,0
 2de:	bfe5                	j	2d6 <atoi+0x40>

00000000000002e0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2e0:	1141                	addi	sp,sp,-16
 2e2:	e422                	sd	s0,8(sp)
 2e4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2e6:	02b57663          	bgeu	a0,a1,312 <memmove+0x32>
    while(n-- > 0)
 2ea:	02c05163          	blez	a2,30c <memmove+0x2c>
 2ee:	fff6079b          	addiw	a5,a2,-1
 2f2:	1782                	slli	a5,a5,0x20
 2f4:	9381                	srli	a5,a5,0x20
 2f6:	0785                	addi	a5,a5,1
 2f8:	97aa                	add	a5,a5,a0
  dst = vdst;
 2fa:	872a                	mv	a4,a0
      *dst++ = *src++;
 2fc:	0585                	addi	a1,a1,1
 2fe:	0705                	addi	a4,a4,1
 300:	fff5c683          	lbu	a3,-1(a1)
 304:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 308:	fee79ae3          	bne	a5,a4,2fc <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 30c:	6422                	ld	s0,8(sp)
 30e:	0141                	addi	sp,sp,16
 310:	8082                	ret
    dst += n;
 312:	00c50733          	add	a4,a0,a2
    src += n;
 316:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 318:	fec05ae3          	blez	a2,30c <memmove+0x2c>
 31c:	fff6079b          	addiw	a5,a2,-1
 320:	1782                	slli	a5,a5,0x20
 322:	9381                	srli	a5,a5,0x20
 324:	fff7c793          	not	a5,a5
 328:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 32a:	15fd                	addi	a1,a1,-1
 32c:	177d                	addi	a4,a4,-1
 32e:	0005c683          	lbu	a3,0(a1)
 332:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 336:	fef71ae3          	bne	a4,a5,32a <memmove+0x4a>
 33a:	bfc9                	j	30c <memmove+0x2c>

000000000000033c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 33c:	1141                	addi	sp,sp,-16
 33e:	e422                	sd	s0,8(sp)
 340:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 342:	ce15                	beqz	a2,37e <memcmp+0x42>
 344:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 348:	00054783          	lbu	a5,0(a0)
 34c:	0005c703          	lbu	a4,0(a1)
 350:	02e79063          	bne	a5,a4,370 <memcmp+0x34>
 354:	1682                	slli	a3,a3,0x20
 356:	9281                	srli	a3,a3,0x20
 358:	0685                	addi	a3,a3,1
 35a:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 35c:	0505                	addi	a0,a0,1
    p2++;
 35e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 360:	00d50d63          	beq	a0,a3,37a <memcmp+0x3e>
    if (*p1 != *p2) {
 364:	00054783          	lbu	a5,0(a0)
 368:	0005c703          	lbu	a4,0(a1)
 36c:	fee788e3          	beq	a5,a4,35c <memcmp+0x20>
      return *p1 - *p2;
 370:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 374:	6422                	ld	s0,8(sp)
 376:	0141                	addi	sp,sp,16
 378:	8082                	ret
  return 0;
 37a:	4501                	li	a0,0
 37c:	bfe5                	j	374 <memcmp+0x38>
 37e:	4501                	li	a0,0
 380:	bfd5                	j	374 <memcmp+0x38>

0000000000000382 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 382:	1141                	addi	sp,sp,-16
 384:	e406                	sd	ra,8(sp)
 386:	e022                	sd	s0,0(sp)
 388:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 38a:	00000097          	auipc	ra,0x0
 38e:	f56080e7          	jalr	-170(ra) # 2e0 <memmove>
}
 392:	60a2                	ld	ra,8(sp)
 394:	6402                	ld	s0,0(sp)
 396:	0141                	addi	sp,sp,16
 398:	8082                	ret

000000000000039a <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 39a:	1141                	addi	sp,sp,-16
 39c:	e422                	sd	s0,8(sp)
 39e:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 3a0:	040007b7          	lui	a5,0x4000
}
 3a4:	17f5                	addi	a5,a5,-3
 3a6:	07b2                	slli	a5,a5,0xc
 3a8:	4388                	lw	a0,0(a5)
 3aa:	6422                	ld	s0,8(sp)
 3ac:	0141                	addi	sp,sp,16
 3ae:	8082                	ret

00000000000003b0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3b0:	4885                	li	a7,1
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3b8:	4889                	li	a7,2
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3c0:	488d                	li	a7,3
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3c8:	4891                	li	a7,4
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <read>:
.global read
read:
 li a7, SYS_read
 3d0:	4895                	li	a7,5
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <write>:
.global write
write:
 li a7, SYS_write
 3d8:	48c1                	li	a7,16
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <close>:
.global close
close:
 li a7, SYS_close
 3e0:	48d5                	li	a7,21
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3e8:	4899                	li	a7,6
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3f0:	489d                	li	a7,7
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <open>:
.global open
open:
 li a7, SYS_open
 3f8:	48bd                	li	a7,15
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 400:	48c5                	li	a7,17
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 408:	48c9                	li	a7,18
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 410:	48a1                	li	a7,8
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <link>:
.global link
link:
 li a7, SYS_link
 418:	48cd                	li	a7,19
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 420:	48d1                	li	a7,20
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 428:	48a5                	li	a7,9
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <dup>:
.global dup
dup:
 li a7, SYS_dup
 430:	48a9                	li	a7,10
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 438:	48ad                	li	a7,11
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 440:	48b1                	li	a7,12
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 448:	48b5                	li	a7,13
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 450:	48b9                	li	a7,14
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <trace>:
.global trace
trace:
 li a7, SYS_trace
 458:	48d9                	li	a7,22
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 460:	48dd                	li	a7,23
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <connect>:
.global connect
connect:
 li a7, SYS_connect
 468:	48f5                	li	a7,29
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 470:	48f9                	li	a7,30
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 478:	1101                	addi	sp,sp,-32
 47a:	ec06                	sd	ra,24(sp)
 47c:	e822                	sd	s0,16(sp)
 47e:	1000                	addi	s0,sp,32
 480:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 484:	4605                	li	a2,1
 486:	fef40593          	addi	a1,s0,-17
 48a:	00000097          	auipc	ra,0x0
 48e:	f4e080e7          	jalr	-178(ra) # 3d8 <write>
}
 492:	60e2                	ld	ra,24(sp)
 494:	6442                	ld	s0,16(sp)
 496:	6105                	addi	sp,sp,32
 498:	8082                	ret

000000000000049a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 49a:	7139                	addi	sp,sp,-64
 49c:	fc06                	sd	ra,56(sp)
 49e:	f822                	sd	s0,48(sp)
 4a0:	f426                	sd	s1,40(sp)
 4a2:	f04a                	sd	s2,32(sp)
 4a4:	ec4e                	sd	s3,24(sp)
 4a6:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4a8:	c299                	beqz	a3,4ae <printint+0x14>
 4aa:	0005cd63          	bltz	a1,4c4 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4ae:	2581                	sext.w	a1,a1
  neg = 0;
 4b0:	4301                	li	t1,0
 4b2:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 4b6:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 4b8:	2601                	sext.w	a2,a2
 4ba:	00000897          	auipc	a7,0x0
 4be:	4be88893          	addi	a7,a7,1214 # 978 <digits>
 4c2:	a039                	j	4d0 <printint+0x36>
    x = -xx;
 4c4:	40b005bb          	negw	a1,a1
    neg = 1;
 4c8:	4305                	li	t1,1
    x = -xx;
 4ca:	b7e5                	j	4b2 <printint+0x18>
  }while((x /= base) != 0);
 4cc:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 4ce:	8836                	mv	a6,a3
 4d0:	0018069b          	addiw	a3,a6,1
 4d4:	02c5f7bb          	remuw	a5,a1,a2
 4d8:	1782                	slli	a5,a5,0x20
 4da:	9381                	srli	a5,a5,0x20
 4dc:	97c6                	add	a5,a5,a7
 4de:	0007c783          	lbu	a5,0(a5) # 4000000 <base+0x3ffefe0>
 4e2:	00f70023          	sb	a5,0(a4)
 4e6:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 4e8:	02c5d7bb          	divuw	a5,a1,a2
 4ec:	fec5f0e3          	bgeu	a1,a2,4cc <printint+0x32>
  if(neg)
 4f0:	00030b63          	beqz	t1,506 <printint+0x6c>
    buf[i++] = '-';
 4f4:	fd040793          	addi	a5,s0,-48
 4f8:	96be                	add	a3,a3,a5
 4fa:	02d00793          	li	a5,45
 4fe:	fef68823          	sb	a5,-16(a3)
 502:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 506:	02d05963          	blez	a3,538 <printint+0x9e>
 50a:	89aa                	mv	s3,a0
 50c:	fc040793          	addi	a5,s0,-64
 510:	00d784b3          	add	s1,a5,a3
 514:	fff78913          	addi	s2,a5,-1
 518:	9936                	add	s2,s2,a3
 51a:	36fd                	addiw	a3,a3,-1
 51c:	1682                	slli	a3,a3,0x20
 51e:	9281                	srli	a3,a3,0x20
 520:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 524:	fff4c583          	lbu	a1,-1(s1)
 528:	854e                	mv	a0,s3
 52a:	00000097          	auipc	ra,0x0
 52e:	f4e080e7          	jalr	-178(ra) # 478 <putc>
 532:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 534:	ff2498e3          	bne	s1,s2,524 <printint+0x8a>
}
 538:	70e2                	ld	ra,56(sp)
 53a:	7442                	ld	s0,48(sp)
 53c:	74a2                	ld	s1,40(sp)
 53e:	7902                	ld	s2,32(sp)
 540:	69e2                	ld	s3,24(sp)
 542:	6121                	addi	sp,sp,64
 544:	8082                	ret

0000000000000546 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 546:	7119                	addi	sp,sp,-128
 548:	fc86                	sd	ra,120(sp)
 54a:	f8a2                	sd	s0,112(sp)
 54c:	f4a6                	sd	s1,104(sp)
 54e:	f0ca                	sd	s2,96(sp)
 550:	ecce                	sd	s3,88(sp)
 552:	e8d2                	sd	s4,80(sp)
 554:	e4d6                	sd	s5,72(sp)
 556:	e0da                	sd	s6,64(sp)
 558:	fc5e                	sd	s7,56(sp)
 55a:	f862                	sd	s8,48(sp)
 55c:	f466                	sd	s9,40(sp)
 55e:	f06a                	sd	s10,32(sp)
 560:	ec6e                	sd	s11,24(sp)
 562:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 564:	0005c483          	lbu	s1,0(a1)
 568:	18048d63          	beqz	s1,702 <vprintf+0x1bc>
 56c:	8aaa                	mv	s5,a0
 56e:	8b32                	mv	s6,a2
 570:	00158913          	addi	s2,a1,1
  state = 0;
 574:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 576:	02500a13          	li	s4,37
      if(c == 'd'){
 57a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 57e:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 582:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 586:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 58a:	00000b97          	auipc	s7,0x0
 58e:	3eeb8b93          	addi	s7,s7,1006 # 978 <digits>
 592:	a839                	j	5b0 <vprintf+0x6a>
        putc(fd, c);
 594:	85a6                	mv	a1,s1
 596:	8556                	mv	a0,s5
 598:	00000097          	auipc	ra,0x0
 59c:	ee0080e7          	jalr	-288(ra) # 478 <putc>
 5a0:	a019                	j	5a6 <vprintf+0x60>
    } else if(state == '%'){
 5a2:	01498f63          	beq	s3,s4,5c0 <vprintf+0x7a>
 5a6:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 5a8:	fff94483          	lbu	s1,-1(s2)
 5ac:	14048b63          	beqz	s1,702 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 5b0:	0004879b          	sext.w	a5,s1
    if(state == 0){
 5b4:	fe0997e3          	bnez	s3,5a2 <vprintf+0x5c>
      if(c == '%'){
 5b8:	fd479ee3          	bne	a5,s4,594 <vprintf+0x4e>
        state = '%';
 5bc:	89be                	mv	s3,a5
 5be:	b7e5                	j	5a6 <vprintf+0x60>
      if(c == 'd'){
 5c0:	05878063          	beq	a5,s8,600 <vprintf+0xba>
      } else if(c == 'l') {
 5c4:	05978c63          	beq	a5,s9,61c <vprintf+0xd6>
      } else if(c == 'x') {
 5c8:	07a78863          	beq	a5,s10,638 <vprintf+0xf2>
      } else if(c == 'p') {
 5cc:	09b78463          	beq	a5,s11,654 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 5d0:	07300713          	li	a4,115
 5d4:	0ce78563          	beq	a5,a4,69e <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5d8:	06300713          	li	a4,99
 5dc:	0ee78c63          	beq	a5,a4,6d4 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 5e0:	11478663          	beq	a5,s4,6ec <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5e4:	85d2                	mv	a1,s4
 5e6:	8556                	mv	a0,s5
 5e8:	00000097          	auipc	ra,0x0
 5ec:	e90080e7          	jalr	-368(ra) # 478 <putc>
        putc(fd, c);
 5f0:	85a6                	mv	a1,s1
 5f2:	8556                	mv	a0,s5
 5f4:	00000097          	auipc	ra,0x0
 5f8:	e84080e7          	jalr	-380(ra) # 478 <putc>
      }
      state = 0;
 5fc:	4981                	li	s3,0
 5fe:	b765                	j	5a6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 600:	008b0493          	addi	s1,s6,8
 604:	4685                	li	a3,1
 606:	4629                	li	a2,10
 608:	000b2583          	lw	a1,0(s6)
 60c:	8556                	mv	a0,s5
 60e:	00000097          	auipc	ra,0x0
 612:	e8c080e7          	jalr	-372(ra) # 49a <printint>
 616:	8b26                	mv	s6,s1
      state = 0;
 618:	4981                	li	s3,0
 61a:	b771                	j	5a6 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 61c:	008b0493          	addi	s1,s6,8
 620:	4681                	li	a3,0
 622:	4629                	li	a2,10
 624:	000b2583          	lw	a1,0(s6)
 628:	8556                	mv	a0,s5
 62a:	00000097          	auipc	ra,0x0
 62e:	e70080e7          	jalr	-400(ra) # 49a <printint>
 632:	8b26                	mv	s6,s1
      state = 0;
 634:	4981                	li	s3,0
 636:	bf85                	j	5a6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 638:	008b0493          	addi	s1,s6,8
 63c:	4681                	li	a3,0
 63e:	4641                	li	a2,16
 640:	000b2583          	lw	a1,0(s6)
 644:	8556                	mv	a0,s5
 646:	00000097          	auipc	ra,0x0
 64a:	e54080e7          	jalr	-428(ra) # 49a <printint>
 64e:	8b26                	mv	s6,s1
      state = 0;
 650:	4981                	li	s3,0
 652:	bf91                	j	5a6 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 654:	008b0793          	addi	a5,s6,8
 658:	f8f43423          	sd	a5,-120(s0)
 65c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 660:	03000593          	li	a1,48
 664:	8556                	mv	a0,s5
 666:	00000097          	auipc	ra,0x0
 66a:	e12080e7          	jalr	-494(ra) # 478 <putc>
  putc(fd, 'x');
 66e:	85ea                	mv	a1,s10
 670:	8556                	mv	a0,s5
 672:	00000097          	auipc	ra,0x0
 676:	e06080e7          	jalr	-506(ra) # 478 <putc>
 67a:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 67c:	03c9d793          	srli	a5,s3,0x3c
 680:	97de                	add	a5,a5,s7
 682:	0007c583          	lbu	a1,0(a5)
 686:	8556                	mv	a0,s5
 688:	00000097          	auipc	ra,0x0
 68c:	df0080e7          	jalr	-528(ra) # 478 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 690:	0992                	slli	s3,s3,0x4
 692:	34fd                	addiw	s1,s1,-1
 694:	f4e5                	bnez	s1,67c <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 696:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 69a:	4981                	li	s3,0
 69c:	b729                	j	5a6 <vprintf+0x60>
        s = va_arg(ap, char*);
 69e:	008b0993          	addi	s3,s6,8
 6a2:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 6a6:	c085                	beqz	s1,6c6 <vprintf+0x180>
        while(*s != 0){
 6a8:	0004c583          	lbu	a1,0(s1)
 6ac:	c9a1                	beqz	a1,6fc <vprintf+0x1b6>
          putc(fd, *s);
 6ae:	8556                	mv	a0,s5
 6b0:	00000097          	auipc	ra,0x0
 6b4:	dc8080e7          	jalr	-568(ra) # 478 <putc>
          s++;
 6b8:	0485                	addi	s1,s1,1
        while(*s != 0){
 6ba:	0004c583          	lbu	a1,0(s1)
 6be:	f9e5                	bnez	a1,6ae <vprintf+0x168>
        s = va_arg(ap, char*);
 6c0:	8b4e                	mv	s6,s3
      state = 0;
 6c2:	4981                	li	s3,0
 6c4:	b5cd                	j	5a6 <vprintf+0x60>
          s = "(null)";
 6c6:	00000497          	auipc	s1,0x0
 6ca:	2ca48493          	addi	s1,s1,714 # 990 <digits+0x18>
        while(*s != 0){
 6ce:	02800593          	li	a1,40
 6d2:	bff1                	j	6ae <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 6d4:	008b0493          	addi	s1,s6,8
 6d8:	000b4583          	lbu	a1,0(s6)
 6dc:	8556                	mv	a0,s5
 6de:	00000097          	auipc	ra,0x0
 6e2:	d9a080e7          	jalr	-614(ra) # 478 <putc>
 6e6:	8b26                	mv	s6,s1
      state = 0;
 6e8:	4981                	li	s3,0
 6ea:	bd75                	j	5a6 <vprintf+0x60>
        putc(fd, c);
 6ec:	85d2                	mv	a1,s4
 6ee:	8556                	mv	a0,s5
 6f0:	00000097          	auipc	ra,0x0
 6f4:	d88080e7          	jalr	-632(ra) # 478 <putc>
      state = 0;
 6f8:	4981                	li	s3,0
 6fa:	b575                	j	5a6 <vprintf+0x60>
        s = va_arg(ap, char*);
 6fc:	8b4e                	mv	s6,s3
      state = 0;
 6fe:	4981                	li	s3,0
 700:	b55d                	j	5a6 <vprintf+0x60>
    }
  }
}
 702:	70e6                	ld	ra,120(sp)
 704:	7446                	ld	s0,112(sp)
 706:	74a6                	ld	s1,104(sp)
 708:	7906                	ld	s2,96(sp)
 70a:	69e6                	ld	s3,88(sp)
 70c:	6a46                	ld	s4,80(sp)
 70e:	6aa6                	ld	s5,72(sp)
 710:	6b06                	ld	s6,64(sp)
 712:	7be2                	ld	s7,56(sp)
 714:	7c42                	ld	s8,48(sp)
 716:	7ca2                	ld	s9,40(sp)
 718:	7d02                	ld	s10,32(sp)
 71a:	6de2                	ld	s11,24(sp)
 71c:	6109                	addi	sp,sp,128
 71e:	8082                	ret

0000000000000720 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 720:	715d                	addi	sp,sp,-80
 722:	ec06                	sd	ra,24(sp)
 724:	e822                	sd	s0,16(sp)
 726:	1000                	addi	s0,sp,32
 728:	e010                	sd	a2,0(s0)
 72a:	e414                	sd	a3,8(s0)
 72c:	e818                	sd	a4,16(s0)
 72e:	ec1c                	sd	a5,24(s0)
 730:	03043023          	sd	a6,32(s0)
 734:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 738:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 73c:	8622                	mv	a2,s0
 73e:	00000097          	auipc	ra,0x0
 742:	e08080e7          	jalr	-504(ra) # 546 <vprintf>
}
 746:	60e2                	ld	ra,24(sp)
 748:	6442                	ld	s0,16(sp)
 74a:	6161                	addi	sp,sp,80
 74c:	8082                	ret

000000000000074e <printf>:

void
printf(const char *fmt, ...)
{
 74e:	711d                	addi	sp,sp,-96
 750:	ec06                	sd	ra,24(sp)
 752:	e822                	sd	s0,16(sp)
 754:	1000                	addi	s0,sp,32
 756:	e40c                	sd	a1,8(s0)
 758:	e810                	sd	a2,16(s0)
 75a:	ec14                	sd	a3,24(s0)
 75c:	f018                	sd	a4,32(s0)
 75e:	f41c                	sd	a5,40(s0)
 760:	03043823          	sd	a6,48(s0)
 764:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 768:	00840613          	addi	a2,s0,8
 76c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 770:	85aa                	mv	a1,a0
 772:	4505                	li	a0,1
 774:	00000097          	auipc	ra,0x0
 778:	dd2080e7          	jalr	-558(ra) # 546 <vprintf>
}
 77c:	60e2                	ld	ra,24(sp)
 77e:	6442                	ld	s0,16(sp)
 780:	6125                	addi	sp,sp,96
 782:	8082                	ret

0000000000000784 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 784:	1141                	addi	sp,sp,-16
 786:	e422                	sd	s0,8(sp)
 788:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 78a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 78e:	00001797          	auipc	a5,0x1
 792:	88278793          	addi	a5,a5,-1918 # 1010 <freep>
 796:	639c                	ld	a5,0(a5)
 798:	a805                	j	7c8 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 79a:	4618                	lw	a4,8(a2)
 79c:	9db9                	addw	a1,a1,a4
 79e:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7a2:	6398                	ld	a4,0(a5)
 7a4:	6318                	ld	a4,0(a4)
 7a6:	fee53823          	sd	a4,-16(a0)
 7aa:	a091                	j	7ee <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7ac:	ff852703          	lw	a4,-8(a0)
 7b0:	9e39                	addw	a2,a2,a4
 7b2:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 7b4:	ff053703          	ld	a4,-16(a0)
 7b8:	e398                	sd	a4,0(a5)
 7ba:	a099                	j	800 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7bc:	6398                	ld	a4,0(a5)
 7be:	00e7e463          	bltu	a5,a4,7c6 <free+0x42>
 7c2:	00e6ea63          	bltu	a3,a4,7d6 <free+0x52>
{
 7c6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c8:	fed7fae3          	bgeu	a5,a3,7bc <free+0x38>
 7cc:	6398                	ld	a4,0(a5)
 7ce:	00e6e463          	bltu	a3,a4,7d6 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d2:	fee7eae3          	bltu	a5,a4,7c6 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 7d6:	ff852583          	lw	a1,-8(a0)
 7da:	6390                	ld	a2,0(a5)
 7dc:	02059713          	slli	a4,a1,0x20
 7e0:	9301                	srli	a4,a4,0x20
 7e2:	0712                	slli	a4,a4,0x4
 7e4:	9736                	add	a4,a4,a3
 7e6:	fae60ae3          	beq	a2,a4,79a <free+0x16>
    bp->s.ptr = p->s.ptr;
 7ea:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7ee:	4790                	lw	a2,8(a5)
 7f0:	02061713          	slli	a4,a2,0x20
 7f4:	9301                	srli	a4,a4,0x20
 7f6:	0712                	slli	a4,a4,0x4
 7f8:	973e                	add	a4,a4,a5
 7fa:	fae689e3          	beq	a3,a4,7ac <free+0x28>
  } else
    p->s.ptr = bp;
 7fe:	e394                	sd	a3,0(a5)
  freep = p;
 800:	00001717          	auipc	a4,0x1
 804:	80f73823          	sd	a5,-2032(a4) # 1010 <freep>
}
 808:	6422                	ld	s0,8(sp)
 80a:	0141                	addi	sp,sp,16
 80c:	8082                	ret

000000000000080e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 80e:	7139                	addi	sp,sp,-64
 810:	fc06                	sd	ra,56(sp)
 812:	f822                	sd	s0,48(sp)
 814:	f426                	sd	s1,40(sp)
 816:	f04a                	sd	s2,32(sp)
 818:	ec4e                	sd	s3,24(sp)
 81a:	e852                	sd	s4,16(sp)
 81c:	e456                	sd	s5,8(sp)
 81e:	e05a                	sd	s6,0(sp)
 820:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 822:	02051993          	slli	s3,a0,0x20
 826:	0209d993          	srli	s3,s3,0x20
 82a:	09bd                	addi	s3,s3,15
 82c:	0049d993          	srli	s3,s3,0x4
 830:	2985                	addiw	s3,s3,1
 832:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 836:	00000797          	auipc	a5,0x0
 83a:	7da78793          	addi	a5,a5,2010 # 1010 <freep>
 83e:	6388                	ld	a0,0(a5)
 840:	c515                	beqz	a0,86c <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 842:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 844:	4798                	lw	a4,8(a5)
 846:	03277f63          	bgeu	a4,s2,884 <malloc+0x76>
 84a:	8a4e                	mv	s4,s3
 84c:	0009871b          	sext.w	a4,s3
 850:	6685                	lui	a3,0x1
 852:	00d77363          	bgeu	a4,a3,858 <malloc+0x4a>
 856:	6a05                	lui	s4,0x1
 858:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 85c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 860:	00000497          	auipc	s1,0x0
 864:	7b048493          	addi	s1,s1,1968 # 1010 <freep>
  if(p == (char*)-1)
 868:	5b7d                	li	s6,-1
 86a:	a885                	j	8da <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 86c:	00000797          	auipc	a5,0x0
 870:	7b478793          	addi	a5,a5,1972 # 1020 <base>
 874:	00000717          	auipc	a4,0x0
 878:	78f73e23          	sd	a5,1948(a4) # 1010 <freep>
 87c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 87e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 882:	b7e1                	j	84a <malloc+0x3c>
      if(p->s.size == nunits)
 884:	02e90b63          	beq	s2,a4,8ba <malloc+0xac>
        p->s.size -= nunits;
 888:	4137073b          	subw	a4,a4,s3
 88c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 88e:	1702                	slli	a4,a4,0x20
 890:	9301                	srli	a4,a4,0x20
 892:	0712                	slli	a4,a4,0x4
 894:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 896:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 89a:	00000717          	auipc	a4,0x0
 89e:	76a73b23          	sd	a0,1910(a4) # 1010 <freep>
      return (void*)(p + 1);
 8a2:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8a6:	70e2                	ld	ra,56(sp)
 8a8:	7442                	ld	s0,48(sp)
 8aa:	74a2                	ld	s1,40(sp)
 8ac:	7902                	ld	s2,32(sp)
 8ae:	69e2                	ld	s3,24(sp)
 8b0:	6a42                	ld	s4,16(sp)
 8b2:	6aa2                	ld	s5,8(sp)
 8b4:	6b02                	ld	s6,0(sp)
 8b6:	6121                	addi	sp,sp,64
 8b8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8ba:	6398                	ld	a4,0(a5)
 8bc:	e118                	sd	a4,0(a0)
 8be:	bff1                	j	89a <malloc+0x8c>
  hp->s.size = nu;
 8c0:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 8c4:	0541                	addi	a0,a0,16
 8c6:	00000097          	auipc	ra,0x0
 8ca:	ebe080e7          	jalr	-322(ra) # 784 <free>
  return freep;
 8ce:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 8d0:	d979                	beqz	a0,8a6 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8d4:	4798                	lw	a4,8(a5)
 8d6:	fb2777e3          	bgeu	a4,s2,884 <malloc+0x76>
    if(p == freep)
 8da:	6098                	ld	a4,0(s1)
 8dc:	853e                	mv	a0,a5
 8de:	fef71ae3          	bne	a4,a5,8d2 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 8e2:	8552                	mv	a0,s4
 8e4:	00000097          	auipc	ra,0x0
 8e8:	b5c080e7          	jalr	-1188(ra) # 440 <sbrk>
  if(p == (char*)-1)
 8ec:	fd651ae3          	bne	a0,s6,8c0 <malloc+0xb2>
        return 0;
 8f0:	4501                	li	a0,0
 8f2:	bf55                	j	8a6 <malloc+0x98>
