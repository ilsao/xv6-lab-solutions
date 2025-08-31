
user/_rm:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
  int i;

  if(argc < 2){
   e:	4785                	li	a5,1
  10:	02a7d763          	bge	a5,a0,3e <main+0x3e>
  14:	00858493          	addi	s1,a1,8
  18:	ffe5091b          	addiw	s2,a0,-2
  1c:	1902                	slli	s2,s2,0x20
  1e:	02095913          	srli	s2,s2,0x20
  22:	090e                	slli	s2,s2,0x3
  24:	05c1                	addi	a1,a1,16
  26:	992e                	add	s2,s2,a1
    fprintf(2, "Usage: rm files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
  28:	6088                	ld	a0,0(s1)
  2a:	00000097          	auipc	ra,0x0
  2e:	35e080e7          	jalr	862(ra) # 388 <unlink>
  32:	02054463          	bltz	a0,5a <main+0x5a>
  36:	04a1                	addi	s1,s1,8
  for(i = 1; i < argc; i++){
  38:	ff2498e3          	bne	s1,s2,28 <main+0x28>
  3c:	a80d                	j	6e <main+0x6e>
    fprintf(2, "Usage: rm files...\n");
  3e:	00001597          	auipc	a1,0x1
  42:	84258593          	addi	a1,a1,-1982 # 880 <malloc+0xf2>
  46:	4509                	li	a0,2
  48:	00000097          	auipc	ra,0x0
  4c:	658080e7          	jalr	1624(ra) # 6a0 <fprintf>
    exit(1);
  50:	4505                	li	a0,1
  52:	00000097          	auipc	ra,0x0
  56:	2e6080e7          	jalr	742(ra) # 338 <exit>
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
  5a:	6090                	ld	a2,0(s1)
  5c:	00001597          	auipc	a1,0x1
  60:	83c58593          	addi	a1,a1,-1988 # 898 <malloc+0x10a>
  64:	4509                	li	a0,2
  66:	00000097          	auipc	ra,0x0
  6a:	63a080e7          	jalr	1594(ra) # 6a0 <fprintf>
      break;
    }
  }

  exit(0);
  6e:	4501                	li	a0,0
  70:	00000097          	auipc	ra,0x0
  74:	2c8080e7          	jalr	712(ra) # 338 <exit>

0000000000000078 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  78:	1141                	addi	sp,sp,-16
  7a:	e406                	sd	ra,8(sp)
  7c:	e022                	sd	s0,0(sp)
  7e:	0800                	addi	s0,sp,16
  extern int main();
  main();
  80:	00000097          	auipc	ra,0x0
  84:	f80080e7          	jalr	-128(ra) # 0 <main>
  exit(0);
  88:	4501                	li	a0,0
  8a:	00000097          	auipc	ra,0x0
  8e:	2ae080e7          	jalr	686(ra) # 338 <exit>

0000000000000092 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  92:	1141                	addi	sp,sp,-16
  94:	e422                	sd	s0,8(sp)
  96:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  98:	87aa                	mv	a5,a0
  9a:	0585                	addi	a1,a1,1
  9c:	0785                	addi	a5,a5,1
  9e:	fff5c703          	lbu	a4,-1(a1)
  a2:	fee78fa3          	sb	a4,-1(a5)
  a6:	fb75                	bnez	a4,9a <strcpy+0x8>
    ;
  return os;
}
  a8:	6422                	ld	s0,8(sp)
  aa:	0141                	addi	sp,sp,16
  ac:	8082                	ret

00000000000000ae <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ae:	1141                	addi	sp,sp,-16
  b0:	e422                	sd	s0,8(sp)
  b2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  b4:	00054783          	lbu	a5,0(a0)
  b8:	cf91                	beqz	a5,d4 <strcmp+0x26>
  ba:	0005c703          	lbu	a4,0(a1)
  be:	00f71b63          	bne	a4,a5,d4 <strcmp+0x26>
    p++, q++;
  c2:	0505                	addi	a0,a0,1
  c4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  c6:	00054783          	lbu	a5,0(a0)
  ca:	c789                	beqz	a5,d4 <strcmp+0x26>
  cc:	0005c703          	lbu	a4,0(a1)
  d0:	fef709e3          	beq	a4,a5,c2 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  d4:	0005c503          	lbu	a0,0(a1)
}
  d8:	40a7853b          	subw	a0,a5,a0
  dc:	6422                	ld	s0,8(sp)
  de:	0141                	addi	sp,sp,16
  e0:	8082                	ret

00000000000000e2 <strlen>:

uint
strlen(const char *s)
{
  e2:	1141                	addi	sp,sp,-16
  e4:	e422                	sd	s0,8(sp)
  e6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  e8:	00054783          	lbu	a5,0(a0)
  ec:	cf91                	beqz	a5,108 <strlen+0x26>
  ee:	0505                	addi	a0,a0,1
  f0:	87aa                	mv	a5,a0
  f2:	4685                	li	a3,1
  f4:	9e89                	subw	a3,a3,a0
    ;
  f6:	00f6853b          	addw	a0,a3,a5
  fa:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
  fc:	fff7c703          	lbu	a4,-1(a5)
 100:	fb7d                	bnez	a4,f6 <strlen+0x14>
  return n;
}
 102:	6422                	ld	s0,8(sp)
 104:	0141                	addi	sp,sp,16
 106:	8082                	ret
  for(n = 0; s[n]; n++)
 108:	4501                	li	a0,0
 10a:	bfe5                	j	102 <strlen+0x20>

000000000000010c <memset>:

void*
memset(void *dst, int c, uint n)
{
 10c:	1141                	addi	sp,sp,-16
 10e:	e422                	sd	s0,8(sp)
 110:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 112:	ce09                	beqz	a2,12c <memset+0x20>
 114:	87aa                	mv	a5,a0
 116:	fff6071b          	addiw	a4,a2,-1
 11a:	1702                	slli	a4,a4,0x20
 11c:	9301                	srli	a4,a4,0x20
 11e:	0705                	addi	a4,a4,1
 120:	972a                	add	a4,a4,a0
    cdst[i] = c;
 122:	00b78023          	sb	a1,0(a5)
 126:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 128:	fee79de3          	bne	a5,a4,122 <memset+0x16>
  }
  return dst;
}
 12c:	6422                	ld	s0,8(sp)
 12e:	0141                	addi	sp,sp,16
 130:	8082                	ret

0000000000000132 <strchr>:

char*
strchr(const char *s, char c)
{
 132:	1141                	addi	sp,sp,-16
 134:	e422                	sd	s0,8(sp)
 136:	0800                	addi	s0,sp,16
  for(; *s; s++)
 138:	00054783          	lbu	a5,0(a0)
 13c:	cf91                	beqz	a5,158 <strchr+0x26>
    if(*s == c)
 13e:	00f58a63          	beq	a1,a5,152 <strchr+0x20>
  for(; *s; s++)
 142:	0505                	addi	a0,a0,1
 144:	00054783          	lbu	a5,0(a0)
 148:	c781                	beqz	a5,150 <strchr+0x1e>
    if(*s == c)
 14a:	feb79ce3          	bne	a5,a1,142 <strchr+0x10>
 14e:	a011                	j	152 <strchr+0x20>
      return (char*)s;
  return 0;
 150:	4501                	li	a0,0
}
 152:	6422                	ld	s0,8(sp)
 154:	0141                	addi	sp,sp,16
 156:	8082                	ret
  return 0;
 158:	4501                	li	a0,0
 15a:	bfe5                	j	152 <strchr+0x20>

000000000000015c <gets>:

char*
gets(char *buf, int max)
{
 15c:	711d                	addi	sp,sp,-96
 15e:	ec86                	sd	ra,88(sp)
 160:	e8a2                	sd	s0,80(sp)
 162:	e4a6                	sd	s1,72(sp)
 164:	e0ca                	sd	s2,64(sp)
 166:	fc4e                	sd	s3,56(sp)
 168:	f852                	sd	s4,48(sp)
 16a:	f456                	sd	s5,40(sp)
 16c:	f05a                	sd	s6,32(sp)
 16e:	ec5e                	sd	s7,24(sp)
 170:	1080                	addi	s0,sp,96
 172:	8baa                	mv	s7,a0
 174:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 176:	892a                	mv	s2,a0
 178:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 17a:	4aa9                	li	s5,10
 17c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 17e:	0019849b          	addiw	s1,s3,1
 182:	0344d863          	bge	s1,s4,1b2 <gets+0x56>
    cc = read(0, &c, 1);
 186:	4605                	li	a2,1
 188:	faf40593          	addi	a1,s0,-81
 18c:	4501                	li	a0,0
 18e:	00000097          	auipc	ra,0x0
 192:	1c2080e7          	jalr	450(ra) # 350 <read>
    if(cc < 1)
 196:	00a05e63          	blez	a0,1b2 <gets+0x56>
    buf[i++] = c;
 19a:	faf44783          	lbu	a5,-81(s0)
 19e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1a2:	01578763          	beq	a5,s5,1b0 <gets+0x54>
 1a6:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 1a8:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 1aa:	fd679ae3          	bne	a5,s6,17e <gets+0x22>
 1ae:	a011                	j	1b2 <gets+0x56>
  for(i=0; i+1 < max; ){
 1b0:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1b2:	99de                	add	s3,s3,s7
 1b4:	00098023          	sb	zero,0(s3)
  return buf;
}
 1b8:	855e                	mv	a0,s7
 1ba:	60e6                	ld	ra,88(sp)
 1bc:	6446                	ld	s0,80(sp)
 1be:	64a6                	ld	s1,72(sp)
 1c0:	6906                	ld	s2,64(sp)
 1c2:	79e2                	ld	s3,56(sp)
 1c4:	7a42                	ld	s4,48(sp)
 1c6:	7aa2                	ld	s5,40(sp)
 1c8:	7b02                	ld	s6,32(sp)
 1ca:	6be2                	ld	s7,24(sp)
 1cc:	6125                	addi	sp,sp,96
 1ce:	8082                	ret

00000000000001d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1d0:	1101                	addi	sp,sp,-32
 1d2:	ec06                	sd	ra,24(sp)
 1d4:	e822                	sd	s0,16(sp)
 1d6:	e426                	sd	s1,8(sp)
 1d8:	e04a                	sd	s2,0(sp)
 1da:	1000                	addi	s0,sp,32
 1dc:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1de:	4581                	li	a1,0
 1e0:	00000097          	auipc	ra,0x0
 1e4:	198080e7          	jalr	408(ra) # 378 <open>
  if(fd < 0)
 1e8:	02054563          	bltz	a0,212 <stat+0x42>
 1ec:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1ee:	85ca                	mv	a1,s2
 1f0:	00000097          	auipc	ra,0x0
 1f4:	1a0080e7          	jalr	416(ra) # 390 <fstat>
 1f8:	892a                	mv	s2,a0
  close(fd);
 1fa:	8526                	mv	a0,s1
 1fc:	00000097          	auipc	ra,0x0
 200:	164080e7          	jalr	356(ra) # 360 <close>
  return r;
}
 204:	854a                	mv	a0,s2
 206:	60e2                	ld	ra,24(sp)
 208:	6442                	ld	s0,16(sp)
 20a:	64a2                	ld	s1,8(sp)
 20c:	6902                	ld	s2,0(sp)
 20e:	6105                	addi	sp,sp,32
 210:	8082                	ret
    return -1;
 212:	597d                	li	s2,-1
 214:	bfc5                	j	204 <stat+0x34>

0000000000000216 <atoi>:

int
atoi(const char *s)
{
 216:	1141                	addi	sp,sp,-16
 218:	e422                	sd	s0,8(sp)
 21a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 21c:	00054683          	lbu	a3,0(a0)
 220:	fd06879b          	addiw	a5,a3,-48
 224:	0ff7f793          	andi	a5,a5,255
 228:	4725                	li	a4,9
 22a:	02f76963          	bltu	a4,a5,25c <atoi+0x46>
 22e:	862a                	mv	a2,a0
  n = 0;
 230:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 232:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 234:	0605                	addi	a2,a2,1
 236:	0025179b          	slliw	a5,a0,0x2
 23a:	9fa9                	addw	a5,a5,a0
 23c:	0017979b          	slliw	a5,a5,0x1
 240:	9fb5                	addw	a5,a5,a3
 242:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 246:	00064683          	lbu	a3,0(a2)
 24a:	fd06871b          	addiw	a4,a3,-48
 24e:	0ff77713          	andi	a4,a4,255
 252:	fee5f1e3          	bgeu	a1,a4,234 <atoi+0x1e>
  return n;
}
 256:	6422                	ld	s0,8(sp)
 258:	0141                	addi	sp,sp,16
 25a:	8082                	ret
  n = 0;
 25c:	4501                	li	a0,0
 25e:	bfe5                	j	256 <atoi+0x40>

0000000000000260 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 260:	1141                	addi	sp,sp,-16
 262:	e422                	sd	s0,8(sp)
 264:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 266:	02b57663          	bgeu	a0,a1,292 <memmove+0x32>
    while(n-- > 0)
 26a:	02c05163          	blez	a2,28c <memmove+0x2c>
 26e:	fff6079b          	addiw	a5,a2,-1
 272:	1782                	slli	a5,a5,0x20
 274:	9381                	srli	a5,a5,0x20
 276:	0785                	addi	a5,a5,1
 278:	97aa                	add	a5,a5,a0
  dst = vdst;
 27a:	872a                	mv	a4,a0
      *dst++ = *src++;
 27c:	0585                	addi	a1,a1,1
 27e:	0705                	addi	a4,a4,1
 280:	fff5c683          	lbu	a3,-1(a1)
 284:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 288:	fee79ae3          	bne	a5,a4,27c <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 28c:	6422                	ld	s0,8(sp)
 28e:	0141                	addi	sp,sp,16
 290:	8082                	ret
    dst += n;
 292:	00c50733          	add	a4,a0,a2
    src += n;
 296:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 298:	fec05ae3          	blez	a2,28c <memmove+0x2c>
 29c:	fff6079b          	addiw	a5,a2,-1
 2a0:	1782                	slli	a5,a5,0x20
 2a2:	9381                	srli	a5,a5,0x20
 2a4:	fff7c793          	not	a5,a5
 2a8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2aa:	15fd                	addi	a1,a1,-1
 2ac:	177d                	addi	a4,a4,-1
 2ae:	0005c683          	lbu	a3,0(a1)
 2b2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2b6:	fef71ae3          	bne	a4,a5,2aa <memmove+0x4a>
 2ba:	bfc9                	j	28c <memmove+0x2c>

00000000000002bc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2bc:	1141                	addi	sp,sp,-16
 2be:	e422                	sd	s0,8(sp)
 2c0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2c2:	ce15                	beqz	a2,2fe <memcmp+0x42>
 2c4:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 2c8:	00054783          	lbu	a5,0(a0)
 2cc:	0005c703          	lbu	a4,0(a1)
 2d0:	02e79063          	bne	a5,a4,2f0 <memcmp+0x34>
 2d4:	1682                	slli	a3,a3,0x20
 2d6:	9281                	srli	a3,a3,0x20
 2d8:	0685                	addi	a3,a3,1
 2da:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 2dc:	0505                	addi	a0,a0,1
    p2++;
 2de:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2e0:	00d50d63          	beq	a0,a3,2fa <memcmp+0x3e>
    if (*p1 != *p2) {
 2e4:	00054783          	lbu	a5,0(a0)
 2e8:	0005c703          	lbu	a4,0(a1)
 2ec:	fee788e3          	beq	a5,a4,2dc <memcmp+0x20>
      return *p1 - *p2;
 2f0:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 2f4:	6422                	ld	s0,8(sp)
 2f6:	0141                	addi	sp,sp,16
 2f8:	8082                	ret
  return 0;
 2fa:	4501                	li	a0,0
 2fc:	bfe5                	j	2f4 <memcmp+0x38>
 2fe:	4501                	li	a0,0
 300:	bfd5                	j	2f4 <memcmp+0x38>

0000000000000302 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 302:	1141                	addi	sp,sp,-16
 304:	e406                	sd	ra,8(sp)
 306:	e022                	sd	s0,0(sp)
 308:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 30a:	00000097          	auipc	ra,0x0
 30e:	f56080e7          	jalr	-170(ra) # 260 <memmove>
}
 312:	60a2                	ld	ra,8(sp)
 314:	6402                	ld	s0,0(sp)
 316:	0141                	addi	sp,sp,16
 318:	8082                	ret

000000000000031a <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 31a:	1141                	addi	sp,sp,-16
 31c:	e422                	sd	s0,8(sp)
 31e:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 320:	040007b7          	lui	a5,0x4000
}
 324:	17f5                	addi	a5,a5,-3
 326:	07b2                	slli	a5,a5,0xc
 328:	4388                	lw	a0,0(a5)
 32a:	6422                	ld	s0,8(sp)
 32c:	0141                	addi	sp,sp,16
 32e:	8082                	ret

0000000000000330 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 330:	4885                	li	a7,1
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <exit>:
.global exit
exit:
 li a7, SYS_exit
 338:	4889                	li	a7,2
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <wait>:
.global wait
wait:
 li a7, SYS_wait
 340:	488d                	li	a7,3
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 348:	4891                	li	a7,4
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <read>:
.global read
read:
 li a7, SYS_read
 350:	4895                	li	a7,5
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <write>:
.global write
write:
 li a7, SYS_write
 358:	48c1                	li	a7,16
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <close>:
.global close
close:
 li a7, SYS_close
 360:	48d5                	li	a7,21
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <kill>:
.global kill
kill:
 li a7, SYS_kill
 368:	4899                	li	a7,6
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <exec>:
.global exec
exec:
 li a7, SYS_exec
 370:	489d                	li	a7,7
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <open>:
.global open
open:
 li a7, SYS_open
 378:	48bd                	li	a7,15
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 380:	48c5                	li	a7,17
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 388:	48c9                	li	a7,18
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 390:	48a1                	li	a7,8
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <link>:
.global link
link:
 li a7, SYS_link
 398:	48cd                	li	a7,19
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3a0:	48d1                	li	a7,20
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3a8:	48a5                	li	a7,9
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3b0:	48a9                	li	a7,10
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3b8:	48ad                	li	a7,11
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3c0:	48b1                	li	a7,12
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3c8:	48b5                	li	a7,13
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3d0:	48b9                	li	a7,14
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <trace>:
.global trace
trace:
 li a7, SYS_trace
 3d8:	48d9                	li	a7,22
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 3e0:	48dd                	li	a7,23
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <connect>:
.global connect
connect:
 li a7, SYS_connect
 3e8:	48f5                	li	a7,29
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 3f0:	48f9                	li	a7,30
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3f8:	1101                	addi	sp,sp,-32
 3fa:	ec06                	sd	ra,24(sp)
 3fc:	e822                	sd	s0,16(sp)
 3fe:	1000                	addi	s0,sp,32
 400:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 404:	4605                	li	a2,1
 406:	fef40593          	addi	a1,s0,-17
 40a:	00000097          	auipc	ra,0x0
 40e:	f4e080e7          	jalr	-178(ra) # 358 <write>
}
 412:	60e2                	ld	ra,24(sp)
 414:	6442                	ld	s0,16(sp)
 416:	6105                	addi	sp,sp,32
 418:	8082                	ret

000000000000041a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 41a:	7139                	addi	sp,sp,-64
 41c:	fc06                	sd	ra,56(sp)
 41e:	f822                	sd	s0,48(sp)
 420:	f426                	sd	s1,40(sp)
 422:	f04a                	sd	s2,32(sp)
 424:	ec4e                	sd	s3,24(sp)
 426:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 428:	c299                	beqz	a3,42e <printint+0x14>
 42a:	0005cd63          	bltz	a1,444 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 42e:	2581                	sext.w	a1,a1
  neg = 0;
 430:	4301                	li	t1,0
 432:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 436:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 438:	2601                	sext.w	a2,a2
 43a:	00000897          	auipc	a7,0x0
 43e:	47e88893          	addi	a7,a7,1150 # 8b8 <digits>
 442:	a039                	j	450 <printint+0x36>
    x = -xx;
 444:	40b005bb          	negw	a1,a1
    neg = 1;
 448:	4305                	li	t1,1
    x = -xx;
 44a:	b7e5                	j	432 <printint+0x18>
  }while((x /= base) != 0);
 44c:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 44e:	8836                	mv	a6,a3
 450:	0018069b          	addiw	a3,a6,1
 454:	02c5f7bb          	remuw	a5,a1,a2
 458:	1782                	slli	a5,a5,0x20
 45a:	9381                	srli	a5,a5,0x20
 45c:	97c6                	add	a5,a5,a7
 45e:	0007c783          	lbu	a5,0(a5) # 4000000 <base+0x3ffeff0>
 462:	00f70023          	sb	a5,0(a4)
 466:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 468:	02c5d7bb          	divuw	a5,a1,a2
 46c:	fec5f0e3          	bgeu	a1,a2,44c <printint+0x32>
  if(neg)
 470:	00030b63          	beqz	t1,486 <printint+0x6c>
    buf[i++] = '-';
 474:	fd040793          	addi	a5,s0,-48
 478:	96be                	add	a3,a3,a5
 47a:	02d00793          	li	a5,45
 47e:	fef68823          	sb	a5,-16(a3)
 482:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 486:	02d05963          	blez	a3,4b8 <printint+0x9e>
 48a:	89aa                	mv	s3,a0
 48c:	fc040793          	addi	a5,s0,-64
 490:	00d784b3          	add	s1,a5,a3
 494:	fff78913          	addi	s2,a5,-1
 498:	9936                	add	s2,s2,a3
 49a:	36fd                	addiw	a3,a3,-1
 49c:	1682                	slli	a3,a3,0x20
 49e:	9281                	srli	a3,a3,0x20
 4a0:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 4a4:	fff4c583          	lbu	a1,-1(s1)
 4a8:	854e                	mv	a0,s3
 4aa:	00000097          	auipc	ra,0x0
 4ae:	f4e080e7          	jalr	-178(ra) # 3f8 <putc>
 4b2:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 4b4:	ff2498e3          	bne	s1,s2,4a4 <printint+0x8a>
}
 4b8:	70e2                	ld	ra,56(sp)
 4ba:	7442                	ld	s0,48(sp)
 4bc:	74a2                	ld	s1,40(sp)
 4be:	7902                	ld	s2,32(sp)
 4c0:	69e2                	ld	s3,24(sp)
 4c2:	6121                	addi	sp,sp,64
 4c4:	8082                	ret

00000000000004c6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4c6:	7119                	addi	sp,sp,-128
 4c8:	fc86                	sd	ra,120(sp)
 4ca:	f8a2                	sd	s0,112(sp)
 4cc:	f4a6                	sd	s1,104(sp)
 4ce:	f0ca                	sd	s2,96(sp)
 4d0:	ecce                	sd	s3,88(sp)
 4d2:	e8d2                	sd	s4,80(sp)
 4d4:	e4d6                	sd	s5,72(sp)
 4d6:	e0da                	sd	s6,64(sp)
 4d8:	fc5e                	sd	s7,56(sp)
 4da:	f862                	sd	s8,48(sp)
 4dc:	f466                	sd	s9,40(sp)
 4de:	f06a                	sd	s10,32(sp)
 4e0:	ec6e                	sd	s11,24(sp)
 4e2:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4e4:	0005c483          	lbu	s1,0(a1)
 4e8:	18048d63          	beqz	s1,682 <vprintf+0x1bc>
 4ec:	8aaa                	mv	s5,a0
 4ee:	8b32                	mv	s6,a2
 4f0:	00158913          	addi	s2,a1,1
  state = 0;
 4f4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4f6:	02500a13          	li	s4,37
      if(c == 'd'){
 4fa:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 4fe:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 502:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 506:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 50a:	00000b97          	auipc	s7,0x0
 50e:	3aeb8b93          	addi	s7,s7,942 # 8b8 <digits>
 512:	a839                	j	530 <vprintf+0x6a>
        putc(fd, c);
 514:	85a6                	mv	a1,s1
 516:	8556                	mv	a0,s5
 518:	00000097          	auipc	ra,0x0
 51c:	ee0080e7          	jalr	-288(ra) # 3f8 <putc>
 520:	a019                	j	526 <vprintf+0x60>
    } else if(state == '%'){
 522:	01498f63          	beq	s3,s4,540 <vprintf+0x7a>
 526:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 528:	fff94483          	lbu	s1,-1(s2)
 52c:	14048b63          	beqz	s1,682 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 530:	0004879b          	sext.w	a5,s1
    if(state == 0){
 534:	fe0997e3          	bnez	s3,522 <vprintf+0x5c>
      if(c == '%'){
 538:	fd479ee3          	bne	a5,s4,514 <vprintf+0x4e>
        state = '%';
 53c:	89be                	mv	s3,a5
 53e:	b7e5                	j	526 <vprintf+0x60>
      if(c == 'd'){
 540:	05878063          	beq	a5,s8,580 <vprintf+0xba>
      } else if(c == 'l') {
 544:	05978c63          	beq	a5,s9,59c <vprintf+0xd6>
      } else if(c == 'x') {
 548:	07a78863          	beq	a5,s10,5b8 <vprintf+0xf2>
      } else if(c == 'p') {
 54c:	09b78463          	beq	a5,s11,5d4 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 550:	07300713          	li	a4,115
 554:	0ce78563          	beq	a5,a4,61e <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 558:	06300713          	li	a4,99
 55c:	0ee78c63          	beq	a5,a4,654 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 560:	11478663          	beq	a5,s4,66c <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 564:	85d2                	mv	a1,s4
 566:	8556                	mv	a0,s5
 568:	00000097          	auipc	ra,0x0
 56c:	e90080e7          	jalr	-368(ra) # 3f8 <putc>
        putc(fd, c);
 570:	85a6                	mv	a1,s1
 572:	8556                	mv	a0,s5
 574:	00000097          	auipc	ra,0x0
 578:	e84080e7          	jalr	-380(ra) # 3f8 <putc>
      }
      state = 0;
 57c:	4981                	li	s3,0
 57e:	b765                	j	526 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 580:	008b0493          	addi	s1,s6,8
 584:	4685                	li	a3,1
 586:	4629                	li	a2,10
 588:	000b2583          	lw	a1,0(s6)
 58c:	8556                	mv	a0,s5
 58e:	00000097          	auipc	ra,0x0
 592:	e8c080e7          	jalr	-372(ra) # 41a <printint>
 596:	8b26                	mv	s6,s1
      state = 0;
 598:	4981                	li	s3,0
 59a:	b771                	j	526 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 59c:	008b0493          	addi	s1,s6,8
 5a0:	4681                	li	a3,0
 5a2:	4629                	li	a2,10
 5a4:	000b2583          	lw	a1,0(s6)
 5a8:	8556                	mv	a0,s5
 5aa:	00000097          	auipc	ra,0x0
 5ae:	e70080e7          	jalr	-400(ra) # 41a <printint>
 5b2:	8b26                	mv	s6,s1
      state = 0;
 5b4:	4981                	li	s3,0
 5b6:	bf85                	j	526 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 5b8:	008b0493          	addi	s1,s6,8
 5bc:	4681                	li	a3,0
 5be:	4641                	li	a2,16
 5c0:	000b2583          	lw	a1,0(s6)
 5c4:	8556                	mv	a0,s5
 5c6:	00000097          	auipc	ra,0x0
 5ca:	e54080e7          	jalr	-428(ra) # 41a <printint>
 5ce:	8b26                	mv	s6,s1
      state = 0;
 5d0:	4981                	li	s3,0
 5d2:	bf91                	j	526 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 5d4:	008b0793          	addi	a5,s6,8
 5d8:	f8f43423          	sd	a5,-120(s0)
 5dc:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 5e0:	03000593          	li	a1,48
 5e4:	8556                	mv	a0,s5
 5e6:	00000097          	auipc	ra,0x0
 5ea:	e12080e7          	jalr	-494(ra) # 3f8 <putc>
  putc(fd, 'x');
 5ee:	85ea                	mv	a1,s10
 5f0:	8556                	mv	a0,s5
 5f2:	00000097          	auipc	ra,0x0
 5f6:	e06080e7          	jalr	-506(ra) # 3f8 <putc>
 5fa:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5fc:	03c9d793          	srli	a5,s3,0x3c
 600:	97de                	add	a5,a5,s7
 602:	0007c583          	lbu	a1,0(a5)
 606:	8556                	mv	a0,s5
 608:	00000097          	auipc	ra,0x0
 60c:	df0080e7          	jalr	-528(ra) # 3f8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 610:	0992                	slli	s3,s3,0x4
 612:	34fd                	addiw	s1,s1,-1
 614:	f4e5                	bnez	s1,5fc <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 616:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 61a:	4981                	li	s3,0
 61c:	b729                	j	526 <vprintf+0x60>
        s = va_arg(ap, char*);
 61e:	008b0993          	addi	s3,s6,8
 622:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 626:	c085                	beqz	s1,646 <vprintf+0x180>
        while(*s != 0){
 628:	0004c583          	lbu	a1,0(s1)
 62c:	c9a1                	beqz	a1,67c <vprintf+0x1b6>
          putc(fd, *s);
 62e:	8556                	mv	a0,s5
 630:	00000097          	auipc	ra,0x0
 634:	dc8080e7          	jalr	-568(ra) # 3f8 <putc>
          s++;
 638:	0485                	addi	s1,s1,1
        while(*s != 0){
 63a:	0004c583          	lbu	a1,0(s1)
 63e:	f9e5                	bnez	a1,62e <vprintf+0x168>
        s = va_arg(ap, char*);
 640:	8b4e                	mv	s6,s3
      state = 0;
 642:	4981                	li	s3,0
 644:	b5cd                	j	526 <vprintf+0x60>
          s = "(null)";
 646:	00000497          	auipc	s1,0x0
 64a:	28a48493          	addi	s1,s1,650 # 8d0 <digits+0x18>
        while(*s != 0){
 64e:	02800593          	li	a1,40
 652:	bff1                	j	62e <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 654:	008b0493          	addi	s1,s6,8
 658:	000b4583          	lbu	a1,0(s6)
 65c:	8556                	mv	a0,s5
 65e:	00000097          	auipc	ra,0x0
 662:	d9a080e7          	jalr	-614(ra) # 3f8 <putc>
 666:	8b26                	mv	s6,s1
      state = 0;
 668:	4981                	li	s3,0
 66a:	bd75                	j	526 <vprintf+0x60>
        putc(fd, c);
 66c:	85d2                	mv	a1,s4
 66e:	8556                	mv	a0,s5
 670:	00000097          	auipc	ra,0x0
 674:	d88080e7          	jalr	-632(ra) # 3f8 <putc>
      state = 0;
 678:	4981                	li	s3,0
 67a:	b575                	j	526 <vprintf+0x60>
        s = va_arg(ap, char*);
 67c:	8b4e                	mv	s6,s3
      state = 0;
 67e:	4981                	li	s3,0
 680:	b55d                	j	526 <vprintf+0x60>
    }
  }
}
 682:	70e6                	ld	ra,120(sp)
 684:	7446                	ld	s0,112(sp)
 686:	74a6                	ld	s1,104(sp)
 688:	7906                	ld	s2,96(sp)
 68a:	69e6                	ld	s3,88(sp)
 68c:	6a46                	ld	s4,80(sp)
 68e:	6aa6                	ld	s5,72(sp)
 690:	6b06                	ld	s6,64(sp)
 692:	7be2                	ld	s7,56(sp)
 694:	7c42                	ld	s8,48(sp)
 696:	7ca2                	ld	s9,40(sp)
 698:	7d02                	ld	s10,32(sp)
 69a:	6de2                	ld	s11,24(sp)
 69c:	6109                	addi	sp,sp,128
 69e:	8082                	ret

00000000000006a0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6a0:	715d                	addi	sp,sp,-80
 6a2:	ec06                	sd	ra,24(sp)
 6a4:	e822                	sd	s0,16(sp)
 6a6:	1000                	addi	s0,sp,32
 6a8:	e010                	sd	a2,0(s0)
 6aa:	e414                	sd	a3,8(s0)
 6ac:	e818                	sd	a4,16(s0)
 6ae:	ec1c                	sd	a5,24(s0)
 6b0:	03043023          	sd	a6,32(s0)
 6b4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6b8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6bc:	8622                	mv	a2,s0
 6be:	00000097          	auipc	ra,0x0
 6c2:	e08080e7          	jalr	-504(ra) # 4c6 <vprintf>
}
 6c6:	60e2                	ld	ra,24(sp)
 6c8:	6442                	ld	s0,16(sp)
 6ca:	6161                	addi	sp,sp,80
 6cc:	8082                	ret

00000000000006ce <printf>:

void
printf(const char *fmt, ...)
{
 6ce:	711d                	addi	sp,sp,-96
 6d0:	ec06                	sd	ra,24(sp)
 6d2:	e822                	sd	s0,16(sp)
 6d4:	1000                	addi	s0,sp,32
 6d6:	e40c                	sd	a1,8(s0)
 6d8:	e810                	sd	a2,16(s0)
 6da:	ec14                	sd	a3,24(s0)
 6dc:	f018                	sd	a4,32(s0)
 6de:	f41c                	sd	a5,40(s0)
 6e0:	03043823          	sd	a6,48(s0)
 6e4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6e8:	00840613          	addi	a2,s0,8
 6ec:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6f0:	85aa                	mv	a1,a0
 6f2:	4505                	li	a0,1
 6f4:	00000097          	auipc	ra,0x0
 6f8:	dd2080e7          	jalr	-558(ra) # 4c6 <vprintf>
}
 6fc:	60e2                	ld	ra,24(sp)
 6fe:	6442                	ld	s0,16(sp)
 700:	6125                	addi	sp,sp,96
 702:	8082                	ret

0000000000000704 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 704:	1141                	addi	sp,sp,-16
 706:	e422                	sd	s0,8(sp)
 708:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 70a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 70e:	00001797          	auipc	a5,0x1
 712:	8f278793          	addi	a5,a5,-1806 # 1000 <freep>
 716:	639c                	ld	a5,0(a5)
 718:	a805                	j	748 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 71a:	4618                	lw	a4,8(a2)
 71c:	9db9                	addw	a1,a1,a4
 71e:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 722:	6398                	ld	a4,0(a5)
 724:	6318                	ld	a4,0(a4)
 726:	fee53823          	sd	a4,-16(a0)
 72a:	a091                	j	76e <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 72c:	ff852703          	lw	a4,-8(a0)
 730:	9e39                	addw	a2,a2,a4
 732:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 734:	ff053703          	ld	a4,-16(a0)
 738:	e398                	sd	a4,0(a5)
 73a:	a099                	j	780 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 73c:	6398                	ld	a4,0(a5)
 73e:	00e7e463          	bltu	a5,a4,746 <free+0x42>
 742:	00e6ea63          	bltu	a3,a4,756 <free+0x52>
{
 746:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 748:	fed7fae3          	bgeu	a5,a3,73c <free+0x38>
 74c:	6398                	ld	a4,0(a5)
 74e:	00e6e463          	bltu	a3,a4,756 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 752:	fee7eae3          	bltu	a5,a4,746 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 756:	ff852583          	lw	a1,-8(a0)
 75a:	6390                	ld	a2,0(a5)
 75c:	02059713          	slli	a4,a1,0x20
 760:	9301                	srli	a4,a4,0x20
 762:	0712                	slli	a4,a4,0x4
 764:	9736                	add	a4,a4,a3
 766:	fae60ae3          	beq	a2,a4,71a <free+0x16>
    bp->s.ptr = p->s.ptr;
 76a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 76e:	4790                	lw	a2,8(a5)
 770:	02061713          	slli	a4,a2,0x20
 774:	9301                	srli	a4,a4,0x20
 776:	0712                	slli	a4,a4,0x4
 778:	973e                	add	a4,a4,a5
 77a:	fae689e3          	beq	a3,a4,72c <free+0x28>
  } else
    p->s.ptr = bp;
 77e:	e394                	sd	a3,0(a5)
  freep = p;
 780:	00001717          	auipc	a4,0x1
 784:	88f73023          	sd	a5,-1920(a4) # 1000 <freep>
}
 788:	6422                	ld	s0,8(sp)
 78a:	0141                	addi	sp,sp,16
 78c:	8082                	ret

000000000000078e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 78e:	7139                	addi	sp,sp,-64
 790:	fc06                	sd	ra,56(sp)
 792:	f822                	sd	s0,48(sp)
 794:	f426                	sd	s1,40(sp)
 796:	f04a                	sd	s2,32(sp)
 798:	ec4e                	sd	s3,24(sp)
 79a:	e852                	sd	s4,16(sp)
 79c:	e456                	sd	s5,8(sp)
 79e:	e05a                	sd	s6,0(sp)
 7a0:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a2:	02051993          	slli	s3,a0,0x20
 7a6:	0209d993          	srli	s3,s3,0x20
 7aa:	09bd                	addi	s3,s3,15
 7ac:	0049d993          	srli	s3,s3,0x4
 7b0:	2985                	addiw	s3,s3,1
 7b2:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 7b6:	00001797          	auipc	a5,0x1
 7ba:	84a78793          	addi	a5,a5,-1974 # 1000 <freep>
 7be:	6388                	ld	a0,0(a5)
 7c0:	c515                	beqz	a0,7ec <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7c4:	4798                	lw	a4,8(a5)
 7c6:	03277f63          	bgeu	a4,s2,804 <malloc+0x76>
 7ca:	8a4e                	mv	s4,s3
 7cc:	0009871b          	sext.w	a4,s3
 7d0:	6685                	lui	a3,0x1
 7d2:	00d77363          	bgeu	a4,a3,7d8 <malloc+0x4a>
 7d6:	6a05                	lui	s4,0x1
 7d8:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 7dc:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7e0:	00001497          	auipc	s1,0x1
 7e4:	82048493          	addi	s1,s1,-2016 # 1000 <freep>
  if(p == (char*)-1)
 7e8:	5b7d                	li	s6,-1
 7ea:	a885                	j	85a <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 7ec:	00001797          	auipc	a5,0x1
 7f0:	82478793          	addi	a5,a5,-2012 # 1010 <base>
 7f4:	00001717          	auipc	a4,0x1
 7f8:	80f73623          	sd	a5,-2036(a4) # 1000 <freep>
 7fc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7fe:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 802:	b7e1                	j	7ca <malloc+0x3c>
      if(p->s.size == nunits)
 804:	02e90b63          	beq	s2,a4,83a <malloc+0xac>
        p->s.size -= nunits;
 808:	4137073b          	subw	a4,a4,s3
 80c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 80e:	1702                	slli	a4,a4,0x20
 810:	9301                	srli	a4,a4,0x20
 812:	0712                	slli	a4,a4,0x4
 814:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 816:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 81a:	00000717          	auipc	a4,0x0
 81e:	7ea73323          	sd	a0,2022(a4) # 1000 <freep>
      return (void*)(p + 1);
 822:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 826:	70e2                	ld	ra,56(sp)
 828:	7442                	ld	s0,48(sp)
 82a:	74a2                	ld	s1,40(sp)
 82c:	7902                	ld	s2,32(sp)
 82e:	69e2                	ld	s3,24(sp)
 830:	6a42                	ld	s4,16(sp)
 832:	6aa2                	ld	s5,8(sp)
 834:	6b02                	ld	s6,0(sp)
 836:	6121                	addi	sp,sp,64
 838:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 83a:	6398                	ld	a4,0(a5)
 83c:	e118                	sd	a4,0(a0)
 83e:	bff1                	j	81a <malloc+0x8c>
  hp->s.size = nu;
 840:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 844:	0541                	addi	a0,a0,16
 846:	00000097          	auipc	ra,0x0
 84a:	ebe080e7          	jalr	-322(ra) # 704 <free>
  return freep;
 84e:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 850:	d979                	beqz	a0,826 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 852:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 854:	4798                	lw	a4,8(a5)
 856:	fb2777e3          	bgeu	a4,s2,804 <malloc+0x76>
    if(p == freep)
 85a:	6098                	ld	a4,0(s1)
 85c:	853e                	mv	a0,a5
 85e:	fef71ae3          	bne	a4,a5,852 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 862:	8552                	mv	a0,s4
 864:	00000097          	auipc	ra,0x0
 868:	b5c080e7          	jalr	-1188(ra) # 3c0 <sbrk>
  if(p == (char*)-1)
 86c:	fd651ae3          	bne	a0,s6,840 <malloc+0xb2>
        return 0;
 870:	4501                	li	a0,0
 872:	bf55                	j	826 <malloc+0x98>
