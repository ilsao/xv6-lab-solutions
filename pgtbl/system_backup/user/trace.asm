
user/_trace:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	712d                	addi	sp,sp,-288
   2:	ee06                	sd	ra,280(sp)
   4:	ea22                	sd	s0,272(sp)
   6:	e626                	sd	s1,264(sp)
   8:	e24a                	sd	s2,256(sp)
   a:	1200                	addi	s0,sp,288
   c:	892e                	mv	s2,a1
  int i;
  char *nargv[MAXARG];

  if(argc < 3 || (argv[1][0] < '0' || argv[1][0] > '9')){
   e:	4789                	li	a5,2
  10:	00a7dd63          	bge	a5,a0,2a <main+0x2a>
  14:	84aa                	mv	s1,a0
  16:	6588                	ld	a0,8(a1)
  18:	00054783          	lbu	a5,0(a0)
  1c:	fd07879b          	addiw	a5,a5,-48
  20:	0ff7f793          	andi	a5,a5,255
  24:	4725                	li	a4,9
  26:	02f77263          	bgeu	a4,a5,4a <main+0x4a>
    fprintf(2, "Usage: %s mask command\n", argv[0]);
  2a:	00093603          	ld	a2,0(s2)
  2e:	00001597          	auipc	a1,0x1
  32:	89258593          	addi	a1,a1,-1902 # 8c0 <malloc+0xea>
  36:	4509                	li	a0,2
  38:	00000097          	auipc	ra,0x0
  3c:	6b0080e7          	jalr	1712(ra) # 6e8 <fprintf>
    exit(1);
  40:	4505                	li	a0,1
  42:	00000097          	auipc	ra,0x0
  46:	33e080e7          	jalr	830(ra) # 380 <exit>
  }

  if (trace(atoi(argv[1])) < 0) {
  4a:	00000097          	auipc	ra,0x0
  4e:	214080e7          	jalr	532(ra) # 25e <atoi>
  52:	00000097          	auipc	ra,0x0
  56:	3ce080e7          	jalr	974(ra) # 420 <trace>
  5a:	04054363          	bltz	a0,a0 <main+0xa0>
  5e:	01090793          	addi	a5,s2,16
  62:	ee040713          	addi	a4,s0,-288
  66:	ffd4869b          	addiw	a3,s1,-3
  6a:	1682                	slli	a3,a3,0x20
  6c:	9281                	srli	a3,a3,0x20
  6e:	068e                	slli	a3,a3,0x3
  70:	96be                	add	a3,a3,a5
  72:	10090913          	addi	s2,s2,256
    fprintf(2, "%s: trace failed\n", argv[0]);
    exit(1);
  }
  
  for(i = 2; i < argc && i < MAXARG; i++){
    nargv[i-2] = argv[i];
  76:	6390                	ld	a2,0(a5)
  78:	e310                	sd	a2,0(a4)
  for(i = 2; i < argc && i < MAXARG; i++){
  7a:	00d78663          	beq	a5,a3,86 <main+0x86>
  7e:	07a1                	addi	a5,a5,8
  80:	0721                	addi	a4,a4,8
  82:	ff279ae3          	bne	a5,s2,76 <main+0x76>
  }
  exec(nargv[0], nargv);
  86:	ee040593          	addi	a1,s0,-288
  8a:	ee043503          	ld	a0,-288(s0)
  8e:	00000097          	auipc	ra,0x0
  92:	32a080e7          	jalr	810(ra) # 3b8 <exec>
  exit(0);
  96:	4501                	li	a0,0
  98:	00000097          	auipc	ra,0x0
  9c:	2e8080e7          	jalr	744(ra) # 380 <exit>
    fprintf(2, "%s: trace failed\n", argv[0]);
  a0:	00093603          	ld	a2,0(s2)
  a4:	00001597          	auipc	a1,0x1
  a8:	83458593          	addi	a1,a1,-1996 # 8d8 <malloc+0x102>
  ac:	4509                	li	a0,2
  ae:	00000097          	auipc	ra,0x0
  b2:	63a080e7          	jalr	1594(ra) # 6e8 <fprintf>
    exit(1);
  b6:	4505                	li	a0,1
  b8:	00000097          	auipc	ra,0x0
  bc:	2c8080e7          	jalr	712(ra) # 380 <exit>

00000000000000c0 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  c0:	1141                	addi	sp,sp,-16
  c2:	e406                	sd	ra,8(sp)
  c4:	e022                	sd	s0,0(sp)
  c6:	0800                	addi	s0,sp,16
  extern int main();
  main();
  c8:	00000097          	auipc	ra,0x0
  cc:	f38080e7          	jalr	-200(ra) # 0 <main>
  exit(0);
  d0:	4501                	li	a0,0
  d2:	00000097          	auipc	ra,0x0
  d6:	2ae080e7          	jalr	686(ra) # 380 <exit>

00000000000000da <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  da:	1141                	addi	sp,sp,-16
  dc:	e422                	sd	s0,8(sp)
  de:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  e0:	87aa                	mv	a5,a0
  e2:	0585                	addi	a1,a1,1
  e4:	0785                	addi	a5,a5,1
  e6:	fff5c703          	lbu	a4,-1(a1)
  ea:	fee78fa3          	sb	a4,-1(a5)
  ee:	fb75                	bnez	a4,e2 <strcpy+0x8>
    ;
  return os;
}
  f0:	6422                	ld	s0,8(sp)
  f2:	0141                	addi	sp,sp,16
  f4:	8082                	ret

00000000000000f6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f6:	1141                	addi	sp,sp,-16
  f8:	e422                	sd	s0,8(sp)
  fa:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  fc:	00054783          	lbu	a5,0(a0)
 100:	cf91                	beqz	a5,11c <strcmp+0x26>
 102:	0005c703          	lbu	a4,0(a1)
 106:	00f71b63          	bne	a4,a5,11c <strcmp+0x26>
    p++, q++;
 10a:	0505                	addi	a0,a0,1
 10c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 10e:	00054783          	lbu	a5,0(a0)
 112:	c789                	beqz	a5,11c <strcmp+0x26>
 114:	0005c703          	lbu	a4,0(a1)
 118:	fef709e3          	beq	a4,a5,10a <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 11c:	0005c503          	lbu	a0,0(a1)
}
 120:	40a7853b          	subw	a0,a5,a0
 124:	6422                	ld	s0,8(sp)
 126:	0141                	addi	sp,sp,16
 128:	8082                	ret

000000000000012a <strlen>:

uint
strlen(const char *s)
{
 12a:	1141                	addi	sp,sp,-16
 12c:	e422                	sd	s0,8(sp)
 12e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 130:	00054783          	lbu	a5,0(a0)
 134:	cf91                	beqz	a5,150 <strlen+0x26>
 136:	0505                	addi	a0,a0,1
 138:	87aa                	mv	a5,a0
 13a:	4685                	li	a3,1
 13c:	9e89                	subw	a3,a3,a0
    ;
 13e:	00f6853b          	addw	a0,a3,a5
 142:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
 144:	fff7c703          	lbu	a4,-1(a5)
 148:	fb7d                	bnez	a4,13e <strlen+0x14>
  return n;
}
 14a:	6422                	ld	s0,8(sp)
 14c:	0141                	addi	sp,sp,16
 14e:	8082                	ret
  for(n = 0; s[n]; n++)
 150:	4501                	li	a0,0
 152:	bfe5                	j	14a <strlen+0x20>

0000000000000154 <memset>:

void*
memset(void *dst, int c, uint n)
{
 154:	1141                	addi	sp,sp,-16
 156:	e422                	sd	s0,8(sp)
 158:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 15a:	ce09                	beqz	a2,174 <memset+0x20>
 15c:	87aa                	mv	a5,a0
 15e:	fff6071b          	addiw	a4,a2,-1
 162:	1702                	slli	a4,a4,0x20
 164:	9301                	srli	a4,a4,0x20
 166:	0705                	addi	a4,a4,1
 168:	972a                	add	a4,a4,a0
    cdst[i] = c;
 16a:	00b78023          	sb	a1,0(a5)
 16e:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 170:	fee79de3          	bne	a5,a4,16a <memset+0x16>
  }
  return dst;
}
 174:	6422                	ld	s0,8(sp)
 176:	0141                	addi	sp,sp,16
 178:	8082                	ret

000000000000017a <strchr>:

char*
strchr(const char *s, char c)
{
 17a:	1141                	addi	sp,sp,-16
 17c:	e422                	sd	s0,8(sp)
 17e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 180:	00054783          	lbu	a5,0(a0)
 184:	cf91                	beqz	a5,1a0 <strchr+0x26>
    if(*s == c)
 186:	00f58a63          	beq	a1,a5,19a <strchr+0x20>
  for(; *s; s++)
 18a:	0505                	addi	a0,a0,1
 18c:	00054783          	lbu	a5,0(a0)
 190:	c781                	beqz	a5,198 <strchr+0x1e>
    if(*s == c)
 192:	feb79ce3          	bne	a5,a1,18a <strchr+0x10>
 196:	a011                	j	19a <strchr+0x20>
      return (char*)s;
  return 0;
 198:	4501                	li	a0,0
}
 19a:	6422                	ld	s0,8(sp)
 19c:	0141                	addi	sp,sp,16
 19e:	8082                	ret
  return 0;
 1a0:	4501                	li	a0,0
 1a2:	bfe5                	j	19a <strchr+0x20>

00000000000001a4 <gets>:

char*
gets(char *buf, int max)
{
 1a4:	711d                	addi	sp,sp,-96
 1a6:	ec86                	sd	ra,88(sp)
 1a8:	e8a2                	sd	s0,80(sp)
 1aa:	e4a6                	sd	s1,72(sp)
 1ac:	e0ca                	sd	s2,64(sp)
 1ae:	fc4e                	sd	s3,56(sp)
 1b0:	f852                	sd	s4,48(sp)
 1b2:	f456                	sd	s5,40(sp)
 1b4:	f05a                	sd	s6,32(sp)
 1b6:	ec5e                	sd	s7,24(sp)
 1b8:	1080                	addi	s0,sp,96
 1ba:	8baa                	mv	s7,a0
 1bc:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1be:	892a                	mv	s2,a0
 1c0:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1c2:	4aa9                	li	s5,10
 1c4:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1c6:	0019849b          	addiw	s1,s3,1
 1ca:	0344d863          	bge	s1,s4,1fa <gets+0x56>
    cc = read(0, &c, 1);
 1ce:	4605                	li	a2,1
 1d0:	faf40593          	addi	a1,s0,-81
 1d4:	4501                	li	a0,0
 1d6:	00000097          	auipc	ra,0x0
 1da:	1c2080e7          	jalr	450(ra) # 398 <read>
    if(cc < 1)
 1de:	00a05e63          	blez	a0,1fa <gets+0x56>
    buf[i++] = c;
 1e2:	faf44783          	lbu	a5,-81(s0)
 1e6:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1ea:	01578763          	beq	a5,s5,1f8 <gets+0x54>
 1ee:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 1f0:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 1f2:	fd679ae3          	bne	a5,s6,1c6 <gets+0x22>
 1f6:	a011                	j	1fa <gets+0x56>
  for(i=0; i+1 < max; ){
 1f8:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1fa:	99de                	add	s3,s3,s7
 1fc:	00098023          	sb	zero,0(s3)
  return buf;
}
 200:	855e                	mv	a0,s7
 202:	60e6                	ld	ra,88(sp)
 204:	6446                	ld	s0,80(sp)
 206:	64a6                	ld	s1,72(sp)
 208:	6906                	ld	s2,64(sp)
 20a:	79e2                	ld	s3,56(sp)
 20c:	7a42                	ld	s4,48(sp)
 20e:	7aa2                	ld	s5,40(sp)
 210:	7b02                	ld	s6,32(sp)
 212:	6be2                	ld	s7,24(sp)
 214:	6125                	addi	sp,sp,96
 216:	8082                	ret

0000000000000218 <stat>:

int
stat(const char *n, struct stat *st)
{
 218:	1101                	addi	sp,sp,-32
 21a:	ec06                	sd	ra,24(sp)
 21c:	e822                	sd	s0,16(sp)
 21e:	e426                	sd	s1,8(sp)
 220:	e04a                	sd	s2,0(sp)
 222:	1000                	addi	s0,sp,32
 224:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 226:	4581                	li	a1,0
 228:	00000097          	auipc	ra,0x0
 22c:	198080e7          	jalr	408(ra) # 3c0 <open>
  if(fd < 0)
 230:	02054563          	bltz	a0,25a <stat+0x42>
 234:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 236:	85ca                	mv	a1,s2
 238:	00000097          	auipc	ra,0x0
 23c:	1a0080e7          	jalr	416(ra) # 3d8 <fstat>
 240:	892a                	mv	s2,a0
  close(fd);
 242:	8526                	mv	a0,s1
 244:	00000097          	auipc	ra,0x0
 248:	164080e7          	jalr	356(ra) # 3a8 <close>
  return r;
}
 24c:	854a                	mv	a0,s2
 24e:	60e2                	ld	ra,24(sp)
 250:	6442                	ld	s0,16(sp)
 252:	64a2                	ld	s1,8(sp)
 254:	6902                	ld	s2,0(sp)
 256:	6105                	addi	sp,sp,32
 258:	8082                	ret
    return -1;
 25a:	597d                	li	s2,-1
 25c:	bfc5                	j	24c <stat+0x34>

000000000000025e <atoi>:

int
atoi(const char *s)
{
 25e:	1141                	addi	sp,sp,-16
 260:	e422                	sd	s0,8(sp)
 262:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 264:	00054683          	lbu	a3,0(a0)
 268:	fd06879b          	addiw	a5,a3,-48
 26c:	0ff7f793          	andi	a5,a5,255
 270:	4725                	li	a4,9
 272:	02f76963          	bltu	a4,a5,2a4 <atoi+0x46>
 276:	862a                	mv	a2,a0
  n = 0;
 278:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 27a:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 27c:	0605                	addi	a2,a2,1
 27e:	0025179b          	slliw	a5,a0,0x2
 282:	9fa9                	addw	a5,a5,a0
 284:	0017979b          	slliw	a5,a5,0x1
 288:	9fb5                	addw	a5,a5,a3
 28a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 28e:	00064683          	lbu	a3,0(a2)
 292:	fd06871b          	addiw	a4,a3,-48
 296:	0ff77713          	andi	a4,a4,255
 29a:	fee5f1e3          	bgeu	a1,a4,27c <atoi+0x1e>
  return n;
}
 29e:	6422                	ld	s0,8(sp)
 2a0:	0141                	addi	sp,sp,16
 2a2:	8082                	ret
  n = 0;
 2a4:	4501                	li	a0,0
 2a6:	bfe5                	j	29e <atoi+0x40>

00000000000002a8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a8:	1141                	addi	sp,sp,-16
 2aa:	e422                	sd	s0,8(sp)
 2ac:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2ae:	02b57663          	bgeu	a0,a1,2da <memmove+0x32>
    while(n-- > 0)
 2b2:	02c05163          	blez	a2,2d4 <memmove+0x2c>
 2b6:	fff6079b          	addiw	a5,a2,-1
 2ba:	1782                	slli	a5,a5,0x20
 2bc:	9381                	srli	a5,a5,0x20
 2be:	0785                	addi	a5,a5,1
 2c0:	97aa                	add	a5,a5,a0
  dst = vdst;
 2c2:	872a                	mv	a4,a0
      *dst++ = *src++;
 2c4:	0585                	addi	a1,a1,1
 2c6:	0705                	addi	a4,a4,1
 2c8:	fff5c683          	lbu	a3,-1(a1)
 2cc:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2d0:	fee79ae3          	bne	a5,a4,2c4 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2d4:	6422                	ld	s0,8(sp)
 2d6:	0141                	addi	sp,sp,16
 2d8:	8082                	ret
    dst += n;
 2da:	00c50733          	add	a4,a0,a2
    src += n;
 2de:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2e0:	fec05ae3          	blez	a2,2d4 <memmove+0x2c>
 2e4:	fff6079b          	addiw	a5,a2,-1
 2e8:	1782                	slli	a5,a5,0x20
 2ea:	9381                	srli	a5,a5,0x20
 2ec:	fff7c793          	not	a5,a5
 2f0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2f2:	15fd                	addi	a1,a1,-1
 2f4:	177d                	addi	a4,a4,-1
 2f6:	0005c683          	lbu	a3,0(a1)
 2fa:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2fe:	fef71ae3          	bne	a4,a5,2f2 <memmove+0x4a>
 302:	bfc9                	j	2d4 <memmove+0x2c>

0000000000000304 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 304:	1141                	addi	sp,sp,-16
 306:	e422                	sd	s0,8(sp)
 308:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 30a:	ce15                	beqz	a2,346 <memcmp+0x42>
 30c:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 310:	00054783          	lbu	a5,0(a0)
 314:	0005c703          	lbu	a4,0(a1)
 318:	02e79063          	bne	a5,a4,338 <memcmp+0x34>
 31c:	1682                	slli	a3,a3,0x20
 31e:	9281                	srli	a3,a3,0x20
 320:	0685                	addi	a3,a3,1
 322:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 324:	0505                	addi	a0,a0,1
    p2++;
 326:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 328:	00d50d63          	beq	a0,a3,342 <memcmp+0x3e>
    if (*p1 != *p2) {
 32c:	00054783          	lbu	a5,0(a0)
 330:	0005c703          	lbu	a4,0(a1)
 334:	fee788e3          	beq	a5,a4,324 <memcmp+0x20>
      return *p1 - *p2;
 338:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 33c:	6422                	ld	s0,8(sp)
 33e:	0141                	addi	sp,sp,16
 340:	8082                	ret
  return 0;
 342:	4501                	li	a0,0
 344:	bfe5                	j	33c <memcmp+0x38>
 346:	4501                	li	a0,0
 348:	bfd5                	j	33c <memcmp+0x38>

000000000000034a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 34a:	1141                	addi	sp,sp,-16
 34c:	e406                	sd	ra,8(sp)
 34e:	e022                	sd	s0,0(sp)
 350:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 352:	00000097          	auipc	ra,0x0
 356:	f56080e7          	jalr	-170(ra) # 2a8 <memmove>
}
 35a:	60a2                	ld	ra,8(sp)
 35c:	6402                	ld	s0,0(sp)
 35e:	0141                	addi	sp,sp,16
 360:	8082                	ret

0000000000000362 <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 362:	1141                	addi	sp,sp,-16
 364:	e422                	sd	s0,8(sp)
 366:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 368:	040007b7          	lui	a5,0x4000
}
 36c:	17f5                	addi	a5,a5,-3
 36e:	07b2                	slli	a5,a5,0xc
 370:	4388                	lw	a0,0(a5)
 372:	6422                	ld	s0,8(sp)
 374:	0141                	addi	sp,sp,16
 376:	8082                	ret

0000000000000378 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 378:	4885                	li	a7,1
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <exit>:
.global exit
exit:
 li a7, SYS_exit
 380:	4889                	li	a7,2
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <wait>:
.global wait
wait:
 li a7, SYS_wait
 388:	488d                	li	a7,3
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 390:	4891                	li	a7,4
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <read>:
.global read
read:
 li a7, SYS_read
 398:	4895                	li	a7,5
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <write>:
.global write
write:
 li a7, SYS_write
 3a0:	48c1                	li	a7,16
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <close>:
.global close
close:
 li a7, SYS_close
 3a8:	48d5                	li	a7,21
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3b0:	4899                	li	a7,6
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3b8:	489d                	li	a7,7
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <open>:
.global open
open:
 li a7, SYS_open
 3c0:	48bd                	li	a7,15
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3c8:	48c5                	li	a7,17
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3d0:	48c9                	li	a7,18
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3d8:	48a1                	li	a7,8
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <link>:
.global link
link:
 li a7, SYS_link
 3e0:	48cd                	li	a7,19
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3e8:	48d1                	li	a7,20
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3f0:	48a5                	li	a7,9
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3f8:	48a9                	li	a7,10
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 400:	48ad                	li	a7,11
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 408:	48b1                	li	a7,12
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 410:	48b5                	li	a7,13
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 418:	48b9                	li	a7,14
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <trace>:
.global trace
trace:
 li a7, SYS_trace
 420:	48d9                	li	a7,22
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 428:	48dd                	li	a7,23
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <connect>:
.global connect
connect:
 li a7, SYS_connect
 430:	48f5                	li	a7,29
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 438:	48f9                	li	a7,30
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 440:	1101                	addi	sp,sp,-32
 442:	ec06                	sd	ra,24(sp)
 444:	e822                	sd	s0,16(sp)
 446:	1000                	addi	s0,sp,32
 448:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 44c:	4605                	li	a2,1
 44e:	fef40593          	addi	a1,s0,-17
 452:	00000097          	auipc	ra,0x0
 456:	f4e080e7          	jalr	-178(ra) # 3a0 <write>
}
 45a:	60e2                	ld	ra,24(sp)
 45c:	6442                	ld	s0,16(sp)
 45e:	6105                	addi	sp,sp,32
 460:	8082                	ret

0000000000000462 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 462:	7139                	addi	sp,sp,-64
 464:	fc06                	sd	ra,56(sp)
 466:	f822                	sd	s0,48(sp)
 468:	f426                	sd	s1,40(sp)
 46a:	f04a                	sd	s2,32(sp)
 46c:	ec4e                	sd	s3,24(sp)
 46e:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 470:	c299                	beqz	a3,476 <printint+0x14>
 472:	0005cd63          	bltz	a1,48c <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 476:	2581                	sext.w	a1,a1
  neg = 0;
 478:	4301                	li	t1,0
 47a:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 47e:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 480:	2601                	sext.w	a2,a2
 482:	00000897          	auipc	a7,0x0
 486:	46e88893          	addi	a7,a7,1134 # 8f0 <digits>
 48a:	a039                	j	498 <printint+0x36>
    x = -xx;
 48c:	40b005bb          	negw	a1,a1
    neg = 1;
 490:	4305                	li	t1,1
    x = -xx;
 492:	b7e5                	j	47a <printint+0x18>
  }while((x /= base) != 0);
 494:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 496:	8836                	mv	a6,a3
 498:	0018069b          	addiw	a3,a6,1
 49c:	02c5f7bb          	remuw	a5,a1,a2
 4a0:	1782                	slli	a5,a5,0x20
 4a2:	9381                	srli	a5,a5,0x20
 4a4:	97c6                	add	a5,a5,a7
 4a6:	0007c783          	lbu	a5,0(a5) # 4000000 <base+0x3ffeff0>
 4aa:	00f70023          	sb	a5,0(a4)
 4ae:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 4b0:	02c5d7bb          	divuw	a5,a1,a2
 4b4:	fec5f0e3          	bgeu	a1,a2,494 <printint+0x32>
  if(neg)
 4b8:	00030b63          	beqz	t1,4ce <printint+0x6c>
    buf[i++] = '-';
 4bc:	fd040793          	addi	a5,s0,-48
 4c0:	96be                	add	a3,a3,a5
 4c2:	02d00793          	li	a5,45
 4c6:	fef68823          	sb	a5,-16(a3)
 4ca:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 4ce:	02d05963          	blez	a3,500 <printint+0x9e>
 4d2:	89aa                	mv	s3,a0
 4d4:	fc040793          	addi	a5,s0,-64
 4d8:	00d784b3          	add	s1,a5,a3
 4dc:	fff78913          	addi	s2,a5,-1
 4e0:	9936                	add	s2,s2,a3
 4e2:	36fd                	addiw	a3,a3,-1
 4e4:	1682                	slli	a3,a3,0x20
 4e6:	9281                	srli	a3,a3,0x20
 4e8:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 4ec:	fff4c583          	lbu	a1,-1(s1)
 4f0:	854e                	mv	a0,s3
 4f2:	00000097          	auipc	ra,0x0
 4f6:	f4e080e7          	jalr	-178(ra) # 440 <putc>
 4fa:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 4fc:	ff2498e3          	bne	s1,s2,4ec <printint+0x8a>
}
 500:	70e2                	ld	ra,56(sp)
 502:	7442                	ld	s0,48(sp)
 504:	74a2                	ld	s1,40(sp)
 506:	7902                	ld	s2,32(sp)
 508:	69e2                	ld	s3,24(sp)
 50a:	6121                	addi	sp,sp,64
 50c:	8082                	ret

000000000000050e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 50e:	7119                	addi	sp,sp,-128
 510:	fc86                	sd	ra,120(sp)
 512:	f8a2                	sd	s0,112(sp)
 514:	f4a6                	sd	s1,104(sp)
 516:	f0ca                	sd	s2,96(sp)
 518:	ecce                	sd	s3,88(sp)
 51a:	e8d2                	sd	s4,80(sp)
 51c:	e4d6                	sd	s5,72(sp)
 51e:	e0da                	sd	s6,64(sp)
 520:	fc5e                	sd	s7,56(sp)
 522:	f862                	sd	s8,48(sp)
 524:	f466                	sd	s9,40(sp)
 526:	f06a                	sd	s10,32(sp)
 528:	ec6e                	sd	s11,24(sp)
 52a:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 52c:	0005c483          	lbu	s1,0(a1)
 530:	18048d63          	beqz	s1,6ca <vprintf+0x1bc>
 534:	8aaa                	mv	s5,a0
 536:	8b32                	mv	s6,a2
 538:	00158913          	addi	s2,a1,1
  state = 0;
 53c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 53e:	02500a13          	li	s4,37
      if(c == 'd'){
 542:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 546:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 54a:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 54e:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 552:	00000b97          	auipc	s7,0x0
 556:	39eb8b93          	addi	s7,s7,926 # 8f0 <digits>
 55a:	a839                	j	578 <vprintf+0x6a>
        putc(fd, c);
 55c:	85a6                	mv	a1,s1
 55e:	8556                	mv	a0,s5
 560:	00000097          	auipc	ra,0x0
 564:	ee0080e7          	jalr	-288(ra) # 440 <putc>
 568:	a019                	j	56e <vprintf+0x60>
    } else if(state == '%'){
 56a:	01498f63          	beq	s3,s4,588 <vprintf+0x7a>
 56e:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 570:	fff94483          	lbu	s1,-1(s2)
 574:	14048b63          	beqz	s1,6ca <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 578:	0004879b          	sext.w	a5,s1
    if(state == 0){
 57c:	fe0997e3          	bnez	s3,56a <vprintf+0x5c>
      if(c == '%'){
 580:	fd479ee3          	bne	a5,s4,55c <vprintf+0x4e>
        state = '%';
 584:	89be                	mv	s3,a5
 586:	b7e5                	j	56e <vprintf+0x60>
      if(c == 'd'){
 588:	05878063          	beq	a5,s8,5c8 <vprintf+0xba>
      } else if(c == 'l') {
 58c:	05978c63          	beq	a5,s9,5e4 <vprintf+0xd6>
      } else if(c == 'x') {
 590:	07a78863          	beq	a5,s10,600 <vprintf+0xf2>
      } else if(c == 'p') {
 594:	09b78463          	beq	a5,s11,61c <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 598:	07300713          	li	a4,115
 59c:	0ce78563          	beq	a5,a4,666 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5a0:	06300713          	li	a4,99
 5a4:	0ee78c63          	beq	a5,a4,69c <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 5a8:	11478663          	beq	a5,s4,6b4 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5ac:	85d2                	mv	a1,s4
 5ae:	8556                	mv	a0,s5
 5b0:	00000097          	auipc	ra,0x0
 5b4:	e90080e7          	jalr	-368(ra) # 440 <putc>
        putc(fd, c);
 5b8:	85a6                	mv	a1,s1
 5ba:	8556                	mv	a0,s5
 5bc:	00000097          	auipc	ra,0x0
 5c0:	e84080e7          	jalr	-380(ra) # 440 <putc>
      }
      state = 0;
 5c4:	4981                	li	s3,0
 5c6:	b765                	j	56e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 5c8:	008b0493          	addi	s1,s6,8
 5cc:	4685                	li	a3,1
 5ce:	4629                	li	a2,10
 5d0:	000b2583          	lw	a1,0(s6)
 5d4:	8556                	mv	a0,s5
 5d6:	00000097          	auipc	ra,0x0
 5da:	e8c080e7          	jalr	-372(ra) # 462 <printint>
 5de:	8b26                	mv	s6,s1
      state = 0;
 5e0:	4981                	li	s3,0
 5e2:	b771                	j	56e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5e4:	008b0493          	addi	s1,s6,8
 5e8:	4681                	li	a3,0
 5ea:	4629                	li	a2,10
 5ec:	000b2583          	lw	a1,0(s6)
 5f0:	8556                	mv	a0,s5
 5f2:	00000097          	auipc	ra,0x0
 5f6:	e70080e7          	jalr	-400(ra) # 462 <printint>
 5fa:	8b26                	mv	s6,s1
      state = 0;
 5fc:	4981                	li	s3,0
 5fe:	bf85                	j	56e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 600:	008b0493          	addi	s1,s6,8
 604:	4681                	li	a3,0
 606:	4641                	li	a2,16
 608:	000b2583          	lw	a1,0(s6)
 60c:	8556                	mv	a0,s5
 60e:	00000097          	auipc	ra,0x0
 612:	e54080e7          	jalr	-428(ra) # 462 <printint>
 616:	8b26                	mv	s6,s1
      state = 0;
 618:	4981                	li	s3,0
 61a:	bf91                	j	56e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 61c:	008b0793          	addi	a5,s6,8
 620:	f8f43423          	sd	a5,-120(s0)
 624:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 628:	03000593          	li	a1,48
 62c:	8556                	mv	a0,s5
 62e:	00000097          	auipc	ra,0x0
 632:	e12080e7          	jalr	-494(ra) # 440 <putc>
  putc(fd, 'x');
 636:	85ea                	mv	a1,s10
 638:	8556                	mv	a0,s5
 63a:	00000097          	auipc	ra,0x0
 63e:	e06080e7          	jalr	-506(ra) # 440 <putc>
 642:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 644:	03c9d793          	srli	a5,s3,0x3c
 648:	97de                	add	a5,a5,s7
 64a:	0007c583          	lbu	a1,0(a5)
 64e:	8556                	mv	a0,s5
 650:	00000097          	auipc	ra,0x0
 654:	df0080e7          	jalr	-528(ra) # 440 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 658:	0992                	slli	s3,s3,0x4
 65a:	34fd                	addiw	s1,s1,-1
 65c:	f4e5                	bnez	s1,644 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 65e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 662:	4981                	li	s3,0
 664:	b729                	j	56e <vprintf+0x60>
        s = va_arg(ap, char*);
 666:	008b0993          	addi	s3,s6,8
 66a:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 66e:	c085                	beqz	s1,68e <vprintf+0x180>
        while(*s != 0){
 670:	0004c583          	lbu	a1,0(s1)
 674:	c9a1                	beqz	a1,6c4 <vprintf+0x1b6>
          putc(fd, *s);
 676:	8556                	mv	a0,s5
 678:	00000097          	auipc	ra,0x0
 67c:	dc8080e7          	jalr	-568(ra) # 440 <putc>
          s++;
 680:	0485                	addi	s1,s1,1
        while(*s != 0){
 682:	0004c583          	lbu	a1,0(s1)
 686:	f9e5                	bnez	a1,676 <vprintf+0x168>
        s = va_arg(ap, char*);
 688:	8b4e                	mv	s6,s3
      state = 0;
 68a:	4981                	li	s3,0
 68c:	b5cd                	j	56e <vprintf+0x60>
          s = "(null)";
 68e:	00000497          	auipc	s1,0x0
 692:	27a48493          	addi	s1,s1,634 # 908 <digits+0x18>
        while(*s != 0){
 696:	02800593          	li	a1,40
 69a:	bff1                	j	676 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 69c:	008b0493          	addi	s1,s6,8
 6a0:	000b4583          	lbu	a1,0(s6)
 6a4:	8556                	mv	a0,s5
 6a6:	00000097          	auipc	ra,0x0
 6aa:	d9a080e7          	jalr	-614(ra) # 440 <putc>
 6ae:	8b26                	mv	s6,s1
      state = 0;
 6b0:	4981                	li	s3,0
 6b2:	bd75                	j	56e <vprintf+0x60>
        putc(fd, c);
 6b4:	85d2                	mv	a1,s4
 6b6:	8556                	mv	a0,s5
 6b8:	00000097          	auipc	ra,0x0
 6bc:	d88080e7          	jalr	-632(ra) # 440 <putc>
      state = 0;
 6c0:	4981                	li	s3,0
 6c2:	b575                	j	56e <vprintf+0x60>
        s = va_arg(ap, char*);
 6c4:	8b4e                	mv	s6,s3
      state = 0;
 6c6:	4981                	li	s3,0
 6c8:	b55d                	j	56e <vprintf+0x60>
    }
  }
}
 6ca:	70e6                	ld	ra,120(sp)
 6cc:	7446                	ld	s0,112(sp)
 6ce:	74a6                	ld	s1,104(sp)
 6d0:	7906                	ld	s2,96(sp)
 6d2:	69e6                	ld	s3,88(sp)
 6d4:	6a46                	ld	s4,80(sp)
 6d6:	6aa6                	ld	s5,72(sp)
 6d8:	6b06                	ld	s6,64(sp)
 6da:	7be2                	ld	s7,56(sp)
 6dc:	7c42                	ld	s8,48(sp)
 6de:	7ca2                	ld	s9,40(sp)
 6e0:	7d02                	ld	s10,32(sp)
 6e2:	6de2                	ld	s11,24(sp)
 6e4:	6109                	addi	sp,sp,128
 6e6:	8082                	ret

00000000000006e8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6e8:	715d                	addi	sp,sp,-80
 6ea:	ec06                	sd	ra,24(sp)
 6ec:	e822                	sd	s0,16(sp)
 6ee:	1000                	addi	s0,sp,32
 6f0:	e010                	sd	a2,0(s0)
 6f2:	e414                	sd	a3,8(s0)
 6f4:	e818                	sd	a4,16(s0)
 6f6:	ec1c                	sd	a5,24(s0)
 6f8:	03043023          	sd	a6,32(s0)
 6fc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 700:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 704:	8622                	mv	a2,s0
 706:	00000097          	auipc	ra,0x0
 70a:	e08080e7          	jalr	-504(ra) # 50e <vprintf>
}
 70e:	60e2                	ld	ra,24(sp)
 710:	6442                	ld	s0,16(sp)
 712:	6161                	addi	sp,sp,80
 714:	8082                	ret

0000000000000716 <printf>:

void
printf(const char *fmt, ...)
{
 716:	711d                	addi	sp,sp,-96
 718:	ec06                	sd	ra,24(sp)
 71a:	e822                	sd	s0,16(sp)
 71c:	1000                	addi	s0,sp,32
 71e:	e40c                	sd	a1,8(s0)
 720:	e810                	sd	a2,16(s0)
 722:	ec14                	sd	a3,24(s0)
 724:	f018                	sd	a4,32(s0)
 726:	f41c                	sd	a5,40(s0)
 728:	03043823          	sd	a6,48(s0)
 72c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 730:	00840613          	addi	a2,s0,8
 734:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 738:	85aa                	mv	a1,a0
 73a:	4505                	li	a0,1
 73c:	00000097          	auipc	ra,0x0
 740:	dd2080e7          	jalr	-558(ra) # 50e <vprintf>
}
 744:	60e2                	ld	ra,24(sp)
 746:	6442                	ld	s0,16(sp)
 748:	6125                	addi	sp,sp,96
 74a:	8082                	ret

000000000000074c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 74c:	1141                	addi	sp,sp,-16
 74e:	e422                	sd	s0,8(sp)
 750:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 752:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 756:	00001797          	auipc	a5,0x1
 75a:	8aa78793          	addi	a5,a5,-1878 # 1000 <freep>
 75e:	639c                	ld	a5,0(a5)
 760:	a805                	j	790 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 762:	4618                	lw	a4,8(a2)
 764:	9db9                	addw	a1,a1,a4
 766:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 76a:	6398                	ld	a4,0(a5)
 76c:	6318                	ld	a4,0(a4)
 76e:	fee53823          	sd	a4,-16(a0)
 772:	a091                	j	7b6 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 774:	ff852703          	lw	a4,-8(a0)
 778:	9e39                	addw	a2,a2,a4
 77a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 77c:	ff053703          	ld	a4,-16(a0)
 780:	e398                	sd	a4,0(a5)
 782:	a099                	j	7c8 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 784:	6398                	ld	a4,0(a5)
 786:	00e7e463          	bltu	a5,a4,78e <free+0x42>
 78a:	00e6ea63          	bltu	a3,a4,79e <free+0x52>
{
 78e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 790:	fed7fae3          	bgeu	a5,a3,784 <free+0x38>
 794:	6398                	ld	a4,0(a5)
 796:	00e6e463          	bltu	a3,a4,79e <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 79a:	fee7eae3          	bltu	a5,a4,78e <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 79e:	ff852583          	lw	a1,-8(a0)
 7a2:	6390                	ld	a2,0(a5)
 7a4:	02059713          	slli	a4,a1,0x20
 7a8:	9301                	srli	a4,a4,0x20
 7aa:	0712                	slli	a4,a4,0x4
 7ac:	9736                	add	a4,a4,a3
 7ae:	fae60ae3          	beq	a2,a4,762 <free+0x16>
    bp->s.ptr = p->s.ptr;
 7b2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7b6:	4790                	lw	a2,8(a5)
 7b8:	02061713          	slli	a4,a2,0x20
 7bc:	9301                	srli	a4,a4,0x20
 7be:	0712                	slli	a4,a4,0x4
 7c0:	973e                	add	a4,a4,a5
 7c2:	fae689e3          	beq	a3,a4,774 <free+0x28>
  } else
    p->s.ptr = bp;
 7c6:	e394                	sd	a3,0(a5)
  freep = p;
 7c8:	00001717          	auipc	a4,0x1
 7cc:	82f73c23          	sd	a5,-1992(a4) # 1000 <freep>
}
 7d0:	6422                	ld	s0,8(sp)
 7d2:	0141                	addi	sp,sp,16
 7d4:	8082                	ret

00000000000007d6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7d6:	7139                	addi	sp,sp,-64
 7d8:	fc06                	sd	ra,56(sp)
 7da:	f822                	sd	s0,48(sp)
 7dc:	f426                	sd	s1,40(sp)
 7de:	f04a                	sd	s2,32(sp)
 7e0:	ec4e                	sd	s3,24(sp)
 7e2:	e852                	sd	s4,16(sp)
 7e4:	e456                	sd	s5,8(sp)
 7e6:	e05a                	sd	s6,0(sp)
 7e8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7ea:	02051993          	slli	s3,a0,0x20
 7ee:	0209d993          	srli	s3,s3,0x20
 7f2:	09bd                	addi	s3,s3,15
 7f4:	0049d993          	srli	s3,s3,0x4
 7f8:	2985                	addiw	s3,s3,1
 7fa:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 7fe:	00001797          	auipc	a5,0x1
 802:	80278793          	addi	a5,a5,-2046 # 1000 <freep>
 806:	6388                	ld	a0,0(a5)
 808:	c515                	beqz	a0,834 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 80a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 80c:	4798                	lw	a4,8(a5)
 80e:	03277f63          	bgeu	a4,s2,84c <malloc+0x76>
 812:	8a4e                	mv	s4,s3
 814:	0009871b          	sext.w	a4,s3
 818:	6685                	lui	a3,0x1
 81a:	00d77363          	bgeu	a4,a3,820 <malloc+0x4a>
 81e:	6a05                	lui	s4,0x1
 820:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 824:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 828:	00000497          	auipc	s1,0x0
 82c:	7d848493          	addi	s1,s1,2008 # 1000 <freep>
  if(p == (char*)-1)
 830:	5b7d                	li	s6,-1
 832:	a885                	j	8a2 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 834:	00000797          	auipc	a5,0x0
 838:	7dc78793          	addi	a5,a5,2012 # 1010 <base>
 83c:	00000717          	auipc	a4,0x0
 840:	7cf73223          	sd	a5,1988(a4) # 1000 <freep>
 844:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 846:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 84a:	b7e1                	j	812 <malloc+0x3c>
      if(p->s.size == nunits)
 84c:	02e90b63          	beq	s2,a4,882 <malloc+0xac>
        p->s.size -= nunits;
 850:	4137073b          	subw	a4,a4,s3
 854:	c798                	sw	a4,8(a5)
        p += p->s.size;
 856:	1702                	slli	a4,a4,0x20
 858:	9301                	srli	a4,a4,0x20
 85a:	0712                	slli	a4,a4,0x4
 85c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 85e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 862:	00000717          	auipc	a4,0x0
 866:	78a73f23          	sd	a0,1950(a4) # 1000 <freep>
      return (void*)(p + 1);
 86a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 86e:	70e2                	ld	ra,56(sp)
 870:	7442                	ld	s0,48(sp)
 872:	74a2                	ld	s1,40(sp)
 874:	7902                	ld	s2,32(sp)
 876:	69e2                	ld	s3,24(sp)
 878:	6a42                	ld	s4,16(sp)
 87a:	6aa2                	ld	s5,8(sp)
 87c:	6b02                	ld	s6,0(sp)
 87e:	6121                	addi	sp,sp,64
 880:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 882:	6398                	ld	a4,0(a5)
 884:	e118                	sd	a4,0(a0)
 886:	bff1                	j	862 <malloc+0x8c>
  hp->s.size = nu;
 888:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 88c:	0541                	addi	a0,a0,16
 88e:	00000097          	auipc	ra,0x0
 892:	ebe080e7          	jalr	-322(ra) # 74c <free>
  return freep;
 896:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 898:	d979                	beqz	a0,86e <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 89a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 89c:	4798                	lw	a4,8(a5)
 89e:	fb2777e3          	bgeu	a4,s2,84c <malloc+0x76>
    if(p == freep)
 8a2:	6098                	ld	a4,0(s1)
 8a4:	853e                	mv	a0,a5
 8a6:	fef71ae3          	bne	a4,a5,89a <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 8aa:	8552                	mv	a0,s4
 8ac:	00000097          	auipc	ra,0x0
 8b0:	b5c080e7          	jalr	-1188(ra) # 408 <sbrk>
  if(p == (char*)-1)
 8b4:	fd651ae3          	bne	a0,s6,888 <malloc+0xb2>
        return 0;
 8b8:	4501                	li	a0,0
 8ba:	bf55                	j	86e <malloc+0x98>
