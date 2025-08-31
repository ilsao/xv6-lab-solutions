
user/_echo:     file format elf64-littleriscv


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
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  int i;

  for(i = 1; i < argc; i++){
  10:	4785                	li	a5,1
  12:	06a7d463          	bge	a5,a0,7a <main+0x7a>
  16:	00858493          	addi	s1,a1,8
  1a:	ffe5099b          	addiw	s3,a0,-2
  1e:	1982                	slli	s3,s3,0x20
  20:	0209d993          	srli	s3,s3,0x20
  24:	098e                	slli	s3,s3,0x3
  26:	05c1                	addi	a1,a1,16
  28:	99ae                	add	s3,s3,a1
    write(1, argv[i], strlen(argv[i]));
    if(i + 1 < argc){
      write(1, " ", 1);
  2a:	00001a17          	auipc	s4,0x1
  2e:	856a0a13          	addi	s4,s4,-1962 # 880 <malloc+0xe6>
    write(1, argv[i], strlen(argv[i]));
  32:	0004b903          	ld	s2,0(s1)
  36:	854a                	mv	a0,s2
  38:	00000097          	auipc	ra,0x0
  3c:	0b6080e7          	jalr	182(ra) # ee <strlen>
  40:	0005061b          	sext.w	a2,a0
  44:	85ca                	mv	a1,s2
  46:	4505                	li	a0,1
  48:	00000097          	auipc	ra,0x0
  4c:	31c080e7          	jalr	796(ra) # 364 <write>
    if(i + 1 < argc){
  50:	04a1                	addi	s1,s1,8
  52:	01348a63          	beq	s1,s3,66 <main+0x66>
      write(1, " ", 1);
  56:	4605                	li	a2,1
  58:	85d2                	mv	a1,s4
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	308080e7          	jalr	776(ra) # 364 <write>
  64:	b7f9                	j	32 <main+0x32>
    } else {
      write(1, "\n", 1);
  66:	4605                	li	a2,1
  68:	00001597          	auipc	a1,0x1
  6c:	82058593          	addi	a1,a1,-2016 # 888 <malloc+0xee>
  70:	4505                	li	a0,1
  72:	00000097          	auipc	ra,0x0
  76:	2f2080e7          	jalr	754(ra) # 364 <write>
    }
  }
  exit(0);
  7a:	4501                	li	a0,0
  7c:	00000097          	auipc	ra,0x0
  80:	2c8080e7          	jalr	712(ra) # 344 <exit>

0000000000000084 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  84:	1141                	addi	sp,sp,-16
  86:	e406                	sd	ra,8(sp)
  88:	e022                	sd	s0,0(sp)
  8a:	0800                	addi	s0,sp,16
  extern int main();
  main();
  8c:	00000097          	auipc	ra,0x0
  90:	f74080e7          	jalr	-140(ra) # 0 <main>
  exit(0);
  94:	4501                	li	a0,0
  96:	00000097          	auipc	ra,0x0
  9a:	2ae080e7          	jalr	686(ra) # 344 <exit>

000000000000009e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  9e:	1141                	addi	sp,sp,-16
  a0:	e422                	sd	s0,8(sp)
  a2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  a4:	87aa                	mv	a5,a0
  a6:	0585                	addi	a1,a1,1
  a8:	0785                	addi	a5,a5,1
  aa:	fff5c703          	lbu	a4,-1(a1)
  ae:	fee78fa3          	sb	a4,-1(a5)
  b2:	fb75                	bnez	a4,a6 <strcpy+0x8>
    ;
  return os;
}
  b4:	6422                	ld	s0,8(sp)
  b6:	0141                	addi	sp,sp,16
  b8:	8082                	ret

00000000000000ba <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ba:	1141                	addi	sp,sp,-16
  bc:	e422                	sd	s0,8(sp)
  be:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  c0:	00054783          	lbu	a5,0(a0)
  c4:	cf91                	beqz	a5,e0 <strcmp+0x26>
  c6:	0005c703          	lbu	a4,0(a1)
  ca:	00f71b63          	bne	a4,a5,e0 <strcmp+0x26>
    p++, q++;
  ce:	0505                	addi	a0,a0,1
  d0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  d2:	00054783          	lbu	a5,0(a0)
  d6:	c789                	beqz	a5,e0 <strcmp+0x26>
  d8:	0005c703          	lbu	a4,0(a1)
  dc:	fef709e3          	beq	a4,a5,ce <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  e0:	0005c503          	lbu	a0,0(a1)
}
  e4:	40a7853b          	subw	a0,a5,a0
  e8:	6422                	ld	s0,8(sp)
  ea:	0141                	addi	sp,sp,16
  ec:	8082                	ret

00000000000000ee <strlen>:

uint
strlen(const char *s)
{
  ee:	1141                	addi	sp,sp,-16
  f0:	e422                	sd	s0,8(sp)
  f2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  f4:	00054783          	lbu	a5,0(a0)
  f8:	cf91                	beqz	a5,114 <strlen+0x26>
  fa:	0505                	addi	a0,a0,1
  fc:	87aa                	mv	a5,a0
  fe:	4685                	li	a3,1
 100:	9e89                	subw	a3,a3,a0
    ;
 102:	00f6853b          	addw	a0,a3,a5
 106:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
 108:	fff7c703          	lbu	a4,-1(a5)
 10c:	fb7d                	bnez	a4,102 <strlen+0x14>
  return n;
}
 10e:	6422                	ld	s0,8(sp)
 110:	0141                	addi	sp,sp,16
 112:	8082                	ret
  for(n = 0; s[n]; n++)
 114:	4501                	li	a0,0
 116:	bfe5                	j	10e <strlen+0x20>

0000000000000118 <memset>:

void*
memset(void *dst, int c, uint n)
{
 118:	1141                	addi	sp,sp,-16
 11a:	e422                	sd	s0,8(sp)
 11c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 11e:	ce09                	beqz	a2,138 <memset+0x20>
 120:	87aa                	mv	a5,a0
 122:	fff6071b          	addiw	a4,a2,-1
 126:	1702                	slli	a4,a4,0x20
 128:	9301                	srli	a4,a4,0x20
 12a:	0705                	addi	a4,a4,1
 12c:	972a                	add	a4,a4,a0
    cdst[i] = c;
 12e:	00b78023          	sb	a1,0(a5)
 132:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 134:	fee79de3          	bne	a5,a4,12e <memset+0x16>
  }
  return dst;
}
 138:	6422                	ld	s0,8(sp)
 13a:	0141                	addi	sp,sp,16
 13c:	8082                	ret

000000000000013e <strchr>:

char*
strchr(const char *s, char c)
{
 13e:	1141                	addi	sp,sp,-16
 140:	e422                	sd	s0,8(sp)
 142:	0800                	addi	s0,sp,16
  for(; *s; s++)
 144:	00054783          	lbu	a5,0(a0)
 148:	cf91                	beqz	a5,164 <strchr+0x26>
    if(*s == c)
 14a:	00f58a63          	beq	a1,a5,15e <strchr+0x20>
  for(; *s; s++)
 14e:	0505                	addi	a0,a0,1
 150:	00054783          	lbu	a5,0(a0)
 154:	c781                	beqz	a5,15c <strchr+0x1e>
    if(*s == c)
 156:	feb79ce3          	bne	a5,a1,14e <strchr+0x10>
 15a:	a011                	j	15e <strchr+0x20>
      return (char*)s;
  return 0;
 15c:	4501                	li	a0,0
}
 15e:	6422                	ld	s0,8(sp)
 160:	0141                	addi	sp,sp,16
 162:	8082                	ret
  return 0;
 164:	4501                	li	a0,0
 166:	bfe5                	j	15e <strchr+0x20>

0000000000000168 <gets>:

char*
gets(char *buf, int max)
{
 168:	711d                	addi	sp,sp,-96
 16a:	ec86                	sd	ra,88(sp)
 16c:	e8a2                	sd	s0,80(sp)
 16e:	e4a6                	sd	s1,72(sp)
 170:	e0ca                	sd	s2,64(sp)
 172:	fc4e                	sd	s3,56(sp)
 174:	f852                	sd	s4,48(sp)
 176:	f456                	sd	s5,40(sp)
 178:	f05a                	sd	s6,32(sp)
 17a:	ec5e                	sd	s7,24(sp)
 17c:	1080                	addi	s0,sp,96
 17e:	8baa                	mv	s7,a0
 180:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 182:	892a                	mv	s2,a0
 184:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 186:	4aa9                	li	s5,10
 188:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 18a:	0019849b          	addiw	s1,s3,1
 18e:	0344d863          	bge	s1,s4,1be <gets+0x56>
    cc = read(0, &c, 1);
 192:	4605                	li	a2,1
 194:	faf40593          	addi	a1,s0,-81
 198:	4501                	li	a0,0
 19a:	00000097          	auipc	ra,0x0
 19e:	1c2080e7          	jalr	450(ra) # 35c <read>
    if(cc < 1)
 1a2:	00a05e63          	blez	a0,1be <gets+0x56>
    buf[i++] = c;
 1a6:	faf44783          	lbu	a5,-81(s0)
 1aa:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1ae:	01578763          	beq	a5,s5,1bc <gets+0x54>
 1b2:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 1b4:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 1b6:	fd679ae3          	bne	a5,s6,18a <gets+0x22>
 1ba:	a011                	j	1be <gets+0x56>
  for(i=0; i+1 < max; ){
 1bc:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1be:	99de                	add	s3,s3,s7
 1c0:	00098023          	sb	zero,0(s3)
  return buf;
}
 1c4:	855e                	mv	a0,s7
 1c6:	60e6                	ld	ra,88(sp)
 1c8:	6446                	ld	s0,80(sp)
 1ca:	64a6                	ld	s1,72(sp)
 1cc:	6906                	ld	s2,64(sp)
 1ce:	79e2                	ld	s3,56(sp)
 1d0:	7a42                	ld	s4,48(sp)
 1d2:	7aa2                	ld	s5,40(sp)
 1d4:	7b02                	ld	s6,32(sp)
 1d6:	6be2                	ld	s7,24(sp)
 1d8:	6125                	addi	sp,sp,96
 1da:	8082                	ret

00000000000001dc <stat>:

int
stat(const char *n, struct stat *st)
{
 1dc:	1101                	addi	sp,sp,-32
 1de:	ec06                	sd	ra,24(sp)
 1e0:	e822                	sd	s0,16(sp)
 1e2:	e426                	sd	s1,8(sp)
 1e4:	e04a                	sd	s2,0(sp)
 1e6:	1000                	addi	s0,sp,32
 1e8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ea:	4581                	li	a1,0
 1ec:	00000097          	auipc	ra,0x0
 1f0:	198080e7          	jalr	408(ra) # 384 <open>
  if(fd < 0)
 1f4:	02054563          	bltz	a0,21e <stat+0x42>
 1f8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1fa:	85ca                	mv	a1,s2
 1fc:	00000097          	auipc	ra,0x0
 200:	1a0080e7          	jalr	416(ra) # 39c <fstat>
 204:	892a                	mv	s2,a0
  close(fd);
 206:	8526                	mv	a0,s1
 208:	00000097          	auipc	ra,0x0
 20c:	164080e7          	jalr	356(ra) # 36c <close>
  return r;
}
 210:	854a                	mv	a0,s2
 212:	60e2                	ld	ra,24(sp)
 214:	6442                	ld	s0,16(sp)
 216:	64a2                	ld	s1,8(sp)
 218:	6902                	ld	s2,0(sp)
 21a:	6105                	addi	sp,sp,32
 21c:	8082                	ret
    return -1;
 21e:	597d                	li	s2,-1
 220:	bfc5                	j	210 <stat+0x34>

0000000000000222 <atoi>:

int
atoi(const char *s)
{
 222:	1141                	addi	sp,sp,-16
 224:	e422                	sd	s0,8(sp)
 226:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 228:	00054683          	lbu	a3,0(a0)
 22c:	fd06879b          	addiw	a5,a3,-48
 230:	0ff7f793          	andi	a5,a5,255
 234:	4725                	li	a4,9
 236:	02f76963          	bltu	a4,a5,268 <atoi+0x46>
 23a:	862a                	mv	a2,a0
  n = 0;
 23c:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 23e:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 240:	0605                	addi	a2,a2,1
 242:	0025179b          	slliw	a5,a0,0x2
 246:	9fa9                	addw	a5,a5,a0
 248:	0017979b          	slliw	a5,a5,0x1
 24c:	9fb5                	addw	a5,a5,a3
 24e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 252:	00064683          	lbu	a3,0(a2)
 256:	fd06871b          	addiw	a4,a3,-48
 25a:	0ff77713          	andi	a4,a4,255
 25e:	fee5f1e3          	bgeu	a1,a4,240 <atoi+0x1e>
  return n;
}
 262:	6422                	ld	s0,8(sp)
 264:	0141                	addi	sp,sp,16
 266:	8082                	ret
  n = 0;
 268:	4501                	li	a0,0
 26a:	bfe5                	j	262 <atoi+0x40>

000000000000026c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 26c:	1141                	addi	sp,sp,-16
 26e:	e422                	sd	s0,8(sp)
 270:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 272:	02b57663          	bgeu	a0,a1,29e <memmove+0x32>
    while(n-- > 0)
 276:	02c05163          	blez	a2,298 <memmove+0x2c>
 27a:	fff6079b          	addiw	a5,a2,-1
 27e:	1782                	slli	a5,a5,0x20
 280:	9381                	srli	a5,a5,0x20
 282:	0785                	addi	a5,a5,1
 284:	97aa                	add	a5,a5,a0
  dst = vdst;
 286:	872a                	mv	a4,a0
      *dst++ = *src++;
 288:	0585                	addi	a1,a1,1
 28a:	0705                	addi	a4,a4,1
 28c:	fff5c683          	lbu	a3,-1(a1)
 290:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 294:	fee79ae3          	bne	a5,a4,288 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 298:	6422                	ld	s0,8(sp)
 29a:	0141                	addi	sp,sp,16
 29c:	8082                	ret
    dst += n;
 29e:	00c50733          	add	a4,a0,a2
    src += n;
 2a2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2a4:	fec05ae3          	blez	a2,298 <memmove+0x2c>
 2a8:	fff6079b          	addiw	a5,a2,-1
 2ac:	1782                	slli	a5,a5,0x20
 2ae:	9381                	srli	a5,a5,0x20
 2b0:	fff7c793          	not	a5,a5
 2b4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2b6:	15fd                	addi	a1,a1,-1
 2b8:	177d                	addi	a4,a4,-1
 2ba:	0005c683          	lbu	a3,0(a1)
 2be:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2c2:	fef71ae3          	bne	a4,a5,2b6 <memmove+0x4a>
 2c6:	bfc9                	j	298 <memmove+0x2c>

00000000000002c8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2c8:	1141                	addi	sp,sp,-16
 2ca:	e422                	sd	s0,8(sp)
 2cc:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2ce:	ce15                	beqz	a2,30a <memcmp+0x42>
 2d0:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 2d4:	00054783          	lbu	a5,0(a0)
 2d8:	0005c703          	lbu	a4,0(a1)
 2dc:	02e79063          	bne	a5,a4,2fc <memcmp+0x34>
 2e0:	1682                	slli	a3,a3,0x20
 2e2:	9281                	srli	a3,a3,0x20
 2e4:	0685                	addi	a3,a3,1
 2e6:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 2e8:	0505                	addi	a0,a0,1
    p2++;
 2ea:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2ec:	00d50d63          	beq	a0,a3,306 <memcmp+0x3e>
    if (*p1 != *p2) {
 2f0:	00054783          	lbu	a5,0(a0)
 2f4:	0005c703          	lbu	a4,0(a1)
 2f8:	fee788e3          	beq	a5,a4,2e8 <memcmp+0x20>
      return *p1 - *p2;
 2fc:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 300:	6422                	ld	s0,8(sp)
 302:	0141                	addi	sp,sp,16
 304:	8082                	ret
  return 0;
 306:	4501                	li	a0,0
 308:	bfe5                	j	300 <memcmp+0x38>
 30a:	4501                	li	a0,0
 30c:	bfd5                	j	300 <memcmp+0x38>

000000000000030e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 30e:	1141                	addi	sp,sp,-16
 310:	e406                	sd	ra,8(sp)
 312:	e022                	sd	s0,0(sp)
 314:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 316:	00000097          	auipc	ra,0x0
 31a:	f56080e7          	jalr	-170(ra) # 26c <memmove>
}
 31e:	60a2                	ld	ra,8(sp)
 320:	6402                	ld	s0,0(sp)
 322:	0141                	addi	sp,sp,16
 324:	8082                	ret

0000000000000326 <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 326:	1141                	addi	sp,sp,-16
 328:	e422                	sd	s0,8(sp)
 32a:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 32c:	040007b7          	lui	a5,0x4000
}
 330:	17f5                	addi	a5,a5,-3
 332:	07b2                	slli	a5,a5,0xc
 334:	4388                	lw	a0,0(a5)
 336:	6422                	ld	s0,8(sp)
 338:	0141                	addi	sp,sp,16
 33a:	8082                	ret

000000000000033c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 33c:	4885                	li	a7,1
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <exit>:
.global exit
exit:
 li a7, SYS_exit
 344:	4889                	li	a7,2
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <wait>:
.global wait
wait:
 li a7, SYS_wait
 34c:	488d                	li	a7,3
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 354:	4891                	li	a7,4
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <read>:
.global read
read:
 li a7, SYS_read
 35c:	4895                	li	a7,5
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <write>:
.global write
write:
 li a7, SYS_write
 364:	48c1                	li	a7,16
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <close>:
.global close
close:
 li a7, SYS_close
 36c:	48d5                	li	a7,21
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <kill>:
.global kill
kill:
 li a7, SYS_kill
 374:	4899                	li	a7,6
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <exec>:
.global exec
exec:
 li a7, SYS_exec
 37c:	489d                	li	a7,7
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <open>:
.global open
open:
 li a7, SYS_open
 384:	48bd                	li	a7,15
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 38c:	48c5                	li	a7,17
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 394:	48c9                	li	a7,18
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 39c:	48a1                	li	a7,8
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <link>:
.global link
link:
 li a7, SYS_link
 3a4:	48cd                	li	a7,19
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3ac:	48d1                	li	a7,20
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3b4:	48a5                	li	a7,9
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <dup>:
.global dup
dup:
 li a7, SYS_dup
 3bc:	48a9                	li	a7,10
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3c4:	48ad                	li	a7,11
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3cc:	48b1                	li	a7,12
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3d4:	48b5                	li	a7,13
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3dc:	48b9                	li	a7,14
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <trace>:
.global trace
trace:
 li a7, SYS_trace
 3e4:	48d9                	li	a7,22
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 3ec:	48dd                	li	a7,23
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <connect>:
.global connect
connect:
 li a7, SYS_connect
 3f4:	48f5                	li	a7,29
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 3fc:	48f9                	li	a7,30
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 404:	1101                	addi	sp,sp,-32
 406:	ec06                	sd	ra,24(sp)
 408:	e822                	sd	s0,16(sp)
 40a:	1000                	addi	s0,sp,32
 40c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 410:	4605                	li	a2,1
 412:	fef40593          	addi	a1,s0,-17
 416:	00000097          	auipc	ra,0x0
 41a:	f4e080e7          	jalr	-178(ra) # 364 <write>
}
 41e:	60e2                	ld	ra,24(sp)
 420:	6442                	ld	s0,16(sp)
 422:	6105                	addi	sp,sp,32
 424:	8082                	ret

0000000000000426 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 426:	7139                	addi	sp,sp,-64
 428:	fc06                	sd	ra,56(sp)
 42a:	f822                	sd	s0,48(sp)
 42c:	f426                	sd	s1,40(sp)
 42e:	f04a                	sd	s2,32(sp)
 430:	ec4e                	sd	s3,24(sp)
 432:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 434:	c299                	beqz	a3,43a <printint+0x14>
 436:	0005cd63          	bltz	a1,450 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 43a:	2581                	sext.w	a1,a1
  neg = 0;
 43c:	4301                	li	t1,0
 43e:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 442:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 444:	2601                	sext.w	a2,a2
 446:	00000897          	auipc	a7,0x0
 44a:	44a88893          	addi	a7,a7,1098 # 890 <digits>
 44e:	a039                	j	45c <printint+0x36>
    x = -xx;
 450:	40b005bb          	negw	a1,a1
    neg = 1;
 454:	4305                	li	t1,1
    x = -xx;
 456:	b7e5                	j	43e <printint+0x18>
  }while((x /= base) != 0);
 458:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 45a:	8836                	mv	a6,a3
 45c:	0018069b          	addiw	a3,a6,1
 460:	02c5f7bb          	remuw	a5,a1,a2
 464:	1782                	slli	a5,a5,0x20
 466:	9381                	srli	a5,a5,0x20
 468:	97c6                	add	a5,a5,a7
 46a:	0007c783          	lbu	a5,0(a5) # 4000000 <base+0x3ffeff0>
 46e:	00f70023          	sb	a5,0(a4)
 472:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 474:	02c5d7bb          	divuw	a5,a1,a2
 478:	fec5f0e3          	bgeu	a1,a2,458 <printint+0x32>
  if(neg)
 47c:	00030b63          	beqz	t1,492 <printint+0x6c>
    buf[i++] = '-';
 480:	fd040793          	addi	a5,s0,-48
 484:	96be                	add	a3,a3,a5
 486:	02d00793          	li	a5,45
 48a:	fef68823          	sb	a5,-16(a3)
 48e:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 492:	02d05963          	blez	a3,4c4 <printint+0x9e>
 496:	89aa                	mv	s3,a0
 498:	fc040793          	addi	a5,s0,-64
 49c:	00d784b3          	add	s1,a5,a3
 4a0:	fff78913          	addi	s2,a5,-1
 4a4:	9936                	add	s2,s2,a3
 4a6:	36fd                	addiw	a3,a3,-1
 4a8:	1682                	slli	a3,a3,0x20
 4aa:	9281                	srli	a3,a3,0x20
 4ac:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 4b0:	fff4c583          	lbu	a1,-1(s1)
 4b4:	854e                	mv	a0,s3
 4b6:	00000097          	auipc	ra,0x0
 4ba:	f4e080e7          	jalr	-178(ra) # 404 <putc>
 4be:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 4c0:	ff2498e3          	bne	s1,s2,4b0 <printint+0x8a>
}
 4c4:	70e2                	ld	ra,56(sp)
 4c6:	7442                	ld	s0,48(sp)
 4c8:	74a2                	ld	s1,40(sp)
 4ca:	7902                	ld	s2,32(sp)
 4cc:	69e2                	ld	s3,24(sp)
 4ce:	6121                	addi	sp,sp,64
 4d0:	8082                	ret

00000000000004d2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4d2:	7119                	addi	sp,sp,-128
 4d4:	fc86                	sd	ra,120(sp)
 4d6:	f8a2                	sd	s0,112(sp)
 4d8:	f4a6                	sd	s1,104(sp)
 4da:	f0ca                	sd	s2,96(sp)
 4dc:	ecce                	sd	s3,88(sp)
 4de:	e8d2                	sd	s4,80(sp)
 4e0:	e4d6                	sd	s5,72(sp)
 4e2:	e0da                	sd	s6,64(sp)
 4e4:	fc5e                	sd	s7,56(sp)
 4e6:	f862                	sd	s8,48(sp)
 4e8:	f466                	sd	s9,40(sp)
 4ea:	f06a                	sd	s10,32(sp)
 4ec:	ec6e                	sd	s11,24(sp)
 4ee:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4f0:	0005c483          	lbu	s1,0(a1)
 4f4:	18048d63          	beqz	s1,68e <vprintf+0x1bc>
 4f8:	8aaa                	mv	s5,a0
 4fa:	8b32                	mv	s6,a2
 4fc:	00158913          	addi	s2,a1,1
  state = 0;
 500:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 502:	02500a13          	li	s4,37
      if(c == 'd'){
 506:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 50a:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 50e:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 512:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 516:	00000b97          	auipc	s7,0x0
 51a:	37ab8b93          	addi	s7,s7,890 # 890 <digits>
 51e:	a839                	j	53c <vprintf+0x6a>
        putc(fd, c);
 520:	85a6                	mv	a1,s1
 522:	8556                	mv	a0,s5
 524:	00000097          	auipc	ra,0x0
 528:	ee0080e7          	jalr	-288(ra) # 404 <putc>
 52c:	a019                	j	532 <vprintf+0x60>
    } else if(state == '%'){
 52e:	01498f63          	beq	s3,s4,54c <vprintf+0x7a>
 532:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 534:	fff94483          	lbu	s1,-1(s2)
 538:	14048b63          	beqz	s1,68e <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 53c:	0004879b          	sext.w	a5,s1
    if(state == 0){
 540:	fe0997e3          	bnez	s3,52e <vprintf+0x5c>
      if(c == '%'){
 544:	fd479ee3          	bne	a5,s4,520 <vprintf+0x4e>
        state = '%';
 548:	89be                	mv	s3,a5
 54a:	b7e5                	j	532 <vprintf+0x60>
      if(c == 'd'){
 54c:	05878063          	beq	a5,s8,58c <vprintf+0xba>
      } else if(c == 'l') {
 550:	05978c63          	beq	a5,s9,5a8 <vprintf+0xd6>
      } else if(c == 'x') {
 554:	07a78863          	beq	a5,s10,5c4 <vprintf+0xf2>
      } else if(c == 'p') {
 558:	09b78463          	beq	a5,s11,5e0 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 55c:	07300713          	li	a4,115
 560:	0ce78563          	beq	a5,a4,62a <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 564:	06300713          	li	a4,99
 568:	0ee78c63          	beq	a5,a4,660 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 56c:	11478663          	beq	a5,s4,678 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 570:	85d2                	mv	a1,s4
 572:	8556                	mv	a0,s5
 574:	00000097          	auipc	ra,0x0
 578:	e90080e7          	jalr	-368(ra) # 404 <putc>
        putc(fd, c);
 57c:	85a6                	mv	a1,s1
 57e:	8556                	mv	a0,s5
 580:	00000097          	auipc	ra,0x0
 584:	e84080e7          	jalr	-380(ra) # 404 <putc>
      }
      state = 0;
 588:	4981                	li	s3,0
 58a:	b765                	j	532 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 58c:	008b0493          	addi	s1,s6,8
 590:	4685                	li	a3,1
 592:	4629                	li	a2,10
 594:	000b2583          	lw	a1,0(s6)
 598:	8556                	mv	a0,s5
 59a:	00000097          	auipc	ra,0x0
 59e:	e8c080e7          	jalr	-372(ra) # 426 <printint>
 5a2:	8b26                	mv	s6,s1
      state = 0;
 5a4:	4981                	li	s3,0
 5a6:	b771                	j	532 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5a8:	008b0493          	addi	s1,s6,8
 5ac:	4681                	li	a3,0
 5ae:	4629                	li	a2,10
 5b0:	000b2583          	lw	a1,0(s6)
 5b4:	8556                	mv	a0,s5
 5b6:	00000097          	auipc	ra,0x0
 5ba:	e70080e7          	jalr	-400(ra) # 426 <printint>
 5be:	8b26                	mv	s6,s1
      state = 0;
 5c0:	4981                	li	s3,0
 5c2:	bf85                	j	532 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 5c4:	008b0493          	addi	s1,s6,8
 5c8:	4681                	li	a3,0
 5ca:	4641                	li	a2,16
 5cc:	000b2583          	lw	a1,0(s6)
 5d0:	8556                	mv	a0,s5
 5d2:	00000097          	auipc	ra,0x0
 5d6:	e54080e7          	jalr	-428(ra) # 426 <printint>
 5da:	8b26                	mv	s6,s1
      state = 0;
 5dc:	4981                	li	s3,0
 5de:	bf91                	j	532 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 5e0:	008b0793          	addi	a5,s6,8
 5e4:	f8f43423          	sd	a5,-120(s0)
 5e8:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 5ec:	03000593          	li	a1,48
 5f0:	8556                	mv	a0,s5
 5f2:	00000097          	auipc	ra,0x0
 5f6:	e12080e7          	jalr	-494(ra) # 404 <putc>
  putc(fd, 'x');
 5fa:	85ea                	mv	a1,s10
 5fc:	8556                	mv	a0,s5
 5fe:	00000097          	auipc	ra,0x0
 602:	e06080e7          	jalr	-506(ra) # 404 <putc>
 606:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 608:	03c9d793          	srli	a5,s3,0x3c
 60c:	97de                	add	a5,a5,s7
 60e:	0007c583          	lbu	a1,0(a5)
 612:	8556                	mv	a0,s5
 614:	00000097          	auipc	ra,0x0
 618:	df0080e7          	jalr	-528(ra) # 404 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 61c:	0992                	slli	s3,s3,0x4
 61e:	34fd                	addiw	s1,s1,-1
 620:	f4e5                	bnez	s1,608 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 622:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 626:	4981                	li	s3,0
 628:	b729                	j	532 <vprintf+0x60>
        s = va_arg(ap, char*);
 62a:	008b0993          	addi	s3,s6,8
 62e:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 632:	c085                	beqz	s1,652 <vprintf+0x180>
        while(*s != 0){
 634:	0004c583          	lbu	a1,0(s1)
 638:	c9a1                	beqz	a1,688 <vprintf+0x1b6>
          putc(fd, *s);
 63a:	8556                	mv	a0,s5
 63c:	00000097          	auipc	ra,0x0
 640:	dc8080e7          	jalr	-568(ra) # 404 <putc>
          s++;
 644:	0485                	addi	s1,s1,1
        while(*s != 0){
 646:	0004c583          	lbu	a1,0(s1)
 64a:	f9e5                	bnez	a1,63a <vprintf+0x168>
        s = va_arg(ap, char*);
 64c:	8b4e                	mv	s6,s3
      state = 0;
 64e:	4981                	li	s3,0
 650:	b5cd                	j	532 <vprintf+0x60>
          s = "(null)";
 652:	00000497          	auipc	s1,0x0
 656:	25648493          	addi	s1,s1,598 # 8a8 <digits+0x18>
        while(*s != 0){
 65a:	02800593          	li	a1,40
 65e:	bff1                	j	63a <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 660:	008b0493          	addi	s1,s6,8
 664:	000b4583          	lbu	a1,0(s6)
 668:	8556                	mv	a0,s5
 66a:	00000097          	auipc	ra,0x0
 66e:	d9a080e7          	jalr	-614(ra) # 404 <putc>
 672:	8b26                	mv	s6,s1
      state = 0;
 674:	4981                	li	s3,0
 676:	bd75                	j	532 <vprintf+0x60>
        putc(fd, c);
 678:	85d2                	mv	a1,s4
 67a:	8556                	mv	a0,s5
 67c:	00000097          	auipc	ra,0x0
 680:	d88080e7          	jalr	-632(ra) # 404 <putc>
      state = 0;
 684:	4981                	li	s3,0
 686:	b575                	j	532 <vprintf+0x60>
        s = va_arg(ap, char*);
 688:	8b4e                	mv	s6,s3
      state = 0;
 68a:	4981                	li	s3,0
 68c:	b55d                	j	532 <vprintf+0x60>
    }
  }
}
 68e:	70e6                	ld	ra,120(sp)
 690:	7446                	ld	s0,112(sp)
 692:	74a6                	ld	s1,104(sp)
 694:	7906                	ld	s2,96(sp)
 696:	69e6                	ld	s3,88(sp)
 698:	6a46                	ld	s4,80(sp)
 69a:	6aa6                	ld	s5,72(sp)
 69c:	6b06                	ld	s6,64(sp)
 69e:	7be2                	ld	s7,56(sp)
 6a0:	7c42                	ld	s8,48(sp)
 6a2:	7ca2                	ld	s9,40(sp)
 6a4:	7d02                	ld	s10,32(sp)
 6a6:	6de2                	ld	s11,24(sp)
 6a8:	6109                	addi	sp,sp,128
 6aa:	8082                	ret

00000000000006ac <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6ac:	715d                	addi	sp,sp,-80
 6ae:	ec06                	sd	ra,24(sp)
 6b0:	e822                	sd	s0,16(sp)
 6b2:	1000                	addi	s0,sp,32
 6b4:	e010                	sd	a2,0(s0)
 6b6:	e414                	sd	a3,8(s0)
 6b8:	e818                	sd	a4,16(s0)
 6ba:	ec1c                	sd	a5,24(s0)
 6bc:	03043023          	sd	a6,32(s0)
 6c0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6c4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6c8:	8622                	mv	a2,s0
 6ca:	00000097          	auipc	ra,0x0
 6ce:	e08080e7          	jalr	-504(ra) # 4d2 <vprintf>
}
 6d2:	60e2                	ld	ra,24(sp)
 6d4:	6442                	ld	s0,16(sp)
 6d6:	6161                	addi	sp,sp,80
 6d8:	8082                	ret

00000000000006da <printf>:

void
printf(const char *fmt, ...)
{
 6da:	711d                	addi	sp,sp,-96
 6dc:	ec06                	sd	ra,24(sp)
 6de:	e822                	sd	s0,16(sp)
 6e0:	1000                	addi	s0,sp,32
 6e2:	e40c                	sd	a1,8(s0)
 6e4:	e810                	sd	a2,16(s0)
 6e6:	ec14                	sd	a3,24(s0)
 6e8:	f018                	sd	a4,32(s0)
 6ea:	f41c                	sd	a5,40(s0)
 6ec:	03043823          	sd	a6,48(s0)
 6f0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6f4:	00840613          	addi	a2,s0,8
 6f8:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6fc:	85aa                	mv	a1,a0
 6fe:	4505                	li	a0,1
 700:	00000097          	auipc	ra,0x0
 704:	dd2080e7          	jalr	-558(ra) # 4d2 <vprintf>
}
 708:	60e2                	ld	ra,24(sp)
 70a:	6442                	ld	s0,16(sp)
 70c:	6125                	addi	sp,sp,96
 70e:	8082                	ret

0000000000000710 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 710:	1141                	addi	sp,sp,-16
 712:	e422                	sd	s0,8(sp)
 714:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 716:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 71a:	00001797          	auipc	a5,0x1
 71e:	8e678793          	addi	a5,a5,-1818 # 1000 <freep>
 722:	639c                	ld	a5,0(a5)
 724:	a805                	j	754 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 726:	4618                	lw	a4,8(a2)
 728:	9db9                	addw	a1,a1,a4
 72a:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 72e:	6398                	ld	a4,0(a5)
 730:	6318                	ld	a4,0(a4)
 732:	fee53823          	sd	a4,-16(a0)
 736:	a091                	j	77a <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 738:	ff852703          	lw	a4,-8(a0)
 73c:	9e39                	addw	a2,a2,a4
 73e:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 740:	ff053703          	ld	a4,-16(a0)
 744:	e398                	sd	a4,0(a5)
 746:	a099                	j	78c <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 748:	6398                	ld	a4,0(a5)
 74a:	00e7e463          	bltu	a5,a4,752 <free+0x42>
 74e:	00e6ea63          	bltu	a3,a4,762 <free+0x52>
{
 752:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 754:	fed7fae3          	bgeu	a5,a3,748 <free+0x38>
 758:	6398                	ld	a4,0(a5)
 75a:	00e6e463          	bltu	a3,a4,762 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 75e:	fee7eae3          	bltu	a5,a4,752 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 762:	ff852583          	lw	a1,-8(a0)
 766:	6390                	ld	a2,0(a5)
 768:	02059713          	slli	a4,a1,0x20
 76c:	9301                	srli	a4,a4,0x20
 76e:	0712                	slli	a4,a4,0x4
 770:	9736                	add	a4,a4,a3
 772:	fae60ae3          	beq	a2,a4,726 <free+0x16>
    bp->s.ptr = p->s.ptr;
 776:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 77a:	4790                	lw	a2,8(a5)
 77c:	02061713          	slli	a4,a2,0x20
 780:	9301                	srli	a4,a4,0x20
 782:	0712                	slli	a4,a4,0x4
 784:	973e                	add	a4,a4,a5
 786:	fae689e3          	beq	a3,a4,738 <free+0x28>
  } else
    p->s.ptr = bp;
 78a:	e394                	sd	a3,0(a5)
  freep = p;
 78c:	00001717          	auipc	a4,0x1
 790:	86f73a23          	sd	a5,-1932(a4) # 1000 <freep>
}
 794:	6422                	ld	s0,8(sp)
 796:	0141                	addi	sp,sp,16
 798:	8082                	ret

000000000000079a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 79a:	7139                	addi	sp,sp,-64
 79c:	fc06                	sd	ra,56(sp)
 79e:	f822                	sd	s0,48(sp)
 7a0:	f426                	sd	s1,40(sp)
 7a2:	f04a                	sd	s2,32(sp)
 7a4:	ec4e                	sd	s3,24(sp)
 7a6:	e852                	sd	s4,16(sp)
 7a8:	e456                	sd	s5,8(sp)
 7aa:	e05a                	sd	s6,0(sp)
 7ac:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7ae:	02051993          	slli	s3,a0,0x20
 7b2:	0209d993          	srli	s3,s3,0x20
 7b6:	09bd                	addi	s3,s3,15
 7b8:	0049d993          	srli	s3,s3,0x4
 7bc:	2985                	addiw	s3,s3,1
 7be:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 7c2:	00001797          	auipc	a5,0x1
 7c6:	83e78793          	addi	a5,a5,-1986 # 1000 <freep>
 7ca:	6388                	ld	a0,0(a5)
 7cc:	c515                	beqz	a0,7f8 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ce:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7d0:	4798                	lw	a4,8(a5)
 7d2:	03277f63          	bgeu	a4,s2,810 <malloc+0x76>
 7d6:	8a4e                	mv	s4,s3
 7d8:	0009871b          	sext.w	a4,s3
 7dc:	6685                	lui	a3,0x1
 7de:	00d77363          	bgeu	a4,a3,7e4 <malloc+0x4a>
 7e2:	6a05                	lui	s4,0x1
 7e4:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 7e8:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7ec:	00001497          	auipc	s1,0x1
 7f0:	81448493          	addi	s1,s1,-2028 # 1000 <freep>
  if(p == (char*)-1)
 7f4:	5b7d                	li	s6,-1
 7f6:	a885                	j	866 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 7f8:	00001797          	auipc	a5,0x1
 7fc:	81878793          	addi	a5,a5,-2024 # 1010 <base>
 800:	00001717          	auipc	a4,0x1
 804:	80f73023          	sd	a5,-2048(a4) # 1000 <freep>
 808:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 80a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 80e:	b7e1                	j	7d6 <malloc+0x3c>
      if(p->s.size == nunits)
 810:	02e90b63          	beq	s2,a4,846 <malloc+0xac>
        p->s.size -= nunits;
 814:	4137073b          	subw	a4,a4,s3
 818:	c798                	sw	a4,8(a5)
        p += p->s.size;
 81a:	1702                	slli	a4,a4,0x20
 81c:	9301                	srli	a4,a4,0x20
 81e:	0712                	slli	a4,a4,0x4
 820:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 822:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 826:	00000717          	auipc	a4,0x0
 82a:	7ca73d23          	sd	a0,2010(a4) # 1000 <freep>
      return (void*)(p + 1);
 82e:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 832:	70e2                	ld	ra,56(sp)
 834:	7442                	ld	s0,48(sp)
 836:	74a2                	ld	s1,40(sp)
 838:	7902                	ld	s2,32(sp)
 83a:	69e2                	ld	s3,24(sp)
 83c:	6a42                	ld	s4,16(sp)
 83e:	6aa2                	ld	s5,8(sp)
 840:	6b02                	ld	s6,0(sp)
 842:	6121                	addi	sp,sp,64
 844:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 846:	6398                	ld	a4,0(a5)
 848:	e118                	sd	a4,0(a0)
 84a:	bff1                	j	826 <malloc+0x8c>
  hp->s.size = nu;
 84c:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 850:	0541                	addi	a0,a0,16
 852:	00000097          	auipc	ra,0x0
 856:	ebe080e7          	jalr	-322(ra) # 710 <free>
  return freep;
 85a:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 85c:	d979                	beqz	a0,832 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 85e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 860:	4798                	lw	a4,8(a5)
 862:	fb2777e3          	bgeu	a4,s2,810 <malloc+0x76>
    if(p == freep)
 866:	6098                	ld	a4,0(s1)
 868:	853e                	mv	a0,a5
 86a:	fef71ae3          	bne	a4,a5,85e <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 86e:	8552                	mv	a0,s4
 870:	00000097          	auipc	ra,0x0
 874:	b5c080e7          	jalr	-1188(ra) # 3cc <sbrk>
  if(p == (char*)-1)
 878:	fd651ae3          	bne	a0,s6,84c <malloc+0xb2>
        return 0;
 87c:	4501                	li	a0,0
 87e:	bf55                	j	832 <malloc+0x98>
