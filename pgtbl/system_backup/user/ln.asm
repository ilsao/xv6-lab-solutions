
user/_ln:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
  if(argc != 3){
   a:	478d                	li	a5,3
   c:	02f50063          	beq	a0,a5,2c <main+0x2c>
    fprintf(2, "Usage: ln old new\n");
  10:	00001597          	auipc	a1,0x1
  14:	85058593          	addi	a1,a1,-1968 # 860 <malloc+0xea>
  18:	4509                	li	a0,2
  1a:	00000097          	auipc	ra,0x0
  1e:	66e080e7          	jalr	1646(ra) # 688 <fprintf>
    exit(1);
  22:	4505                	li	a0,1
  24:	00000097          	auipc	ra,0x0
  28:	2fc080e7          	jalr	764(ra) # 320 <exit>
  2c:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  2e:	698c                	ld	a1,16(a1)
  30:	6488                	ld	a0,8(s1)
  32:	00000097          	auipc	ra,0x0
  36:	34e080e7          	jalr	846(ra) # 380 <link>
  3a:	00054763          	bltz	a0,48 <main+0x48>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	2e0080e7          	jalr	736(ra) # 320 <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  48:	6894                	ld	a3,16(s1)
  4a:	6490                	ld	a2,8(s1)
  4c:	00001597          	auipc	a1,0x1
  50:	82c58593          	addi	a1,a1,-2004 # 878 <malloc+0x102>
  54:	4509                	li	a0,2
  56:	00000097          	auipc	ra,0x0
  5a:	632080e7          	jalr	1586(ra) # 688 <fprintf>
  5e:	b7c5                	j	3e <main+0x3e>

0000000000000060 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  60:	1141                	addi	sp,sp,-16
  62:	e406                	sd	ra,8(sp)
  64:	e022                	sd	s0,0(sp)
  66:	0800                	addi	s0,sp,16
  extern int main();
  main();
  68:	00000097          	auipc	ra,0x0
  6c:	f98080e7          	jalr	-104(ra) # 0 <main>
  exit(0);
  70:	4501                	li	a0,0
  72:	00000097          	auipc	ra,0x0
  76:	2ae080e7          	jalr	686(ra) # 320 <exit>

000000000000007a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  7a:	1141                	addi	sp,sp,-16
  7c:	e422                	sd	s0,8(sp)
  7e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  80:	87aa                	mv	a5,a0
  82:	0585                	addi	a1,a1,1
  84:	0785                	addi	a5,a5,1
  86:	fff5c703          	lbu	a4,-1(a1)
  8a:	fee78fa3          	sb	a4,-1(a5)
  8e:	fb75                	bnez	a4,82 <strcpy+0x8>
    ;
  return os;
}
  90:	6422                	ld	s0,8(sp)
  92:	0141                	addi	sp,sp,16
  94:	8082                	ret

0000000000000096 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  96:	1141                	addi	sp,sp,-16
  98:	e422                	sd	s0,8(sp)
  9a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  9c:	00054783          	lbu	a5,0(a0)
  a0:	cf91                	beqz	a5,bc <strcmp+0x26>
  a2:	0005c703          	lbu	a4,0(a1)
  a6:	00f71b63          	bne	a4,a5,bc <strcmp+0x26>
    p++, q++;
  aa:	0505                	addi	a0,a0,1
  ac:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  ae:	00054783          	lbu	a5,0(a0)
  b2:	c789                	beqz	a5,bc <strcmp+0x26>
  b4:	0005c703          	lbu	a4,0(a1)
  b8:	fef709e3          	beq	a4,a5,aa <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  bc:	0005c503          	lbu	a0,0(a1)
}
  c0:	40a7853b          	subw	a0,a5,a0
  c4:	6422                	ld	s0,8(sp)
  c6:	0141                	addi	sp,sp,16
  c8:	8082                	ret

00000000000000ca <strlen>:

uint
strlen(const char *s)
{
  ca:	1141                	addi	sp,sp,-16
  cc:	e422                	sd	s0,8(sp)
  ce:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  d0:	00054783          	lbu	a5,0(a0)
  d4:	cf91                	beqz	a5,f0 <strlen+0x26>
  d6:	0505                	addi	a0,a0,1
  d8:	87aa                	mv	a5,a0
  da:	4685                	li	a3,1
  dc:	9e89                	subw	a3,a3,a0
    ;
  de:	00f6853b          	addw	a0,a3,a5
  e2:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
  e4:	fff7c703          	lbu	a4,-1(a5)
  e8:	fb7d                	bnez	a4,de <strlen+0x14>
  return n;
}
  ea:	6422                	ld	s0,8(sp)
  ec:	0141                	addi	sp,sp,16
  ee:	8082                	ret
  for(n = 0; s[n]; n++)
  f0:	4501                	li	a0,0
  f2:	bfe5                	j	ea <strlen+0x20>

00000000000000f4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f4:	1141                	addi	sp,sp,-16
  f6:	e422                	sd	s0,8(sp)
  f8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  fa:	ce09                	beqz	a2,114 <memset+0x20>
  fc:	87aa                	mv	a5,a0
  fe:	fff6071b          	addiw	a4,a2,-1
 102:	1702                	slli	a4,a4,0x20
 104:	9301                	srli	a4,a4,0x20
 106:	0705                	addi	a4,a4,1
 108:	972a                	add	a4,a4,a0
    cdst[i] = c;
 10a:	00b78023          	sb	a1,0(a5)
 10e:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 110:	fee79de3          	bne	a5,a4,10a <memset+0x16>
  }
  return dst;
}
 114:	6422                	ld	s0,8(sp)
 116:	0141                	addi	sp,sp,16
 118:	8082                	ret

000000000000011a <strchr>:

char*
strchr(const char *s, char c)
{
 11a:	1141                	addi	sp,sp,-16
 11c:	e422                	sd	s0,8(sp)
 11e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 120:	00054783          	lbu	a5,0(a0)
 124:	cf91                	beqz	a5,140 <strchr+0x26>
    if(*s == c)
 126:	00f58a63          	beq	a1,a5,13a <strchr+0x20>
  for(; *s; s++)
 12a:	0505                	addi	a0,a0,1
 12c:	00054783          	lbu	a5,0(a0)
 130:	c781                	beqz	a5,138 <strchr+0x1e>
    if(*s == c)
 132:	feb79ce3          	bne	a5,a1,12a <strchr+0x10>
 136:	a011                	j	13a <strchr+0x20>
      return (char*)s;
  return 0;
 138:	4501                	li	a0,0
}
 13a:	6422                	ld	s0,8(sp)
 13c:	0141                	addi	sp,sp,16
 13e:	8082                	ret
  return 0;
 140:	4501                	li	a0,0
 142:	bfe5                	j	13a <strchr+0x20>

0000000000000144 <gets>:

char*
gets(char *buf, int max)
{
 144:	711d                	addi	sp,sp,-96
 146:	ec86                	sd	ra,88(sp)
 148:	e8a2                	sd	s0,80(sp)
 14a:	e4a6                	sd	s1,72(sp)
 14c:	e0ca                	sd	s2,64(sp)
 14e:	fc4e                	sd	s3,56(sp)
 150:	f852                	sd	s4,48(sp)
 152:	f456                	sd	s5,40(sp)
 154:	f05a                	sd	s6,32(sp)
 156:	ec5e                	sd	s7,24(sp)
 158:	1080                	addi	s0,sp,96
 15a:	8baa                	mv	s7,a0
 15c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 15e:	892a                	mv	s2,a0
 160:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 162:	4aa9                	li	s5,10
 164:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 166:	0019849b          	addiw	s1,s3,1
 16a:	0344d863          	bge	s1,s4,19a <gets+0x56>
    cc = read(0, &c, 1);
 16e:	4605                	li	a2,1
 170:	faf40593          	addi	a1,s0,-81
 174:	4501                	li	a0,0
 176:	00000097          	auipc	ra,0x0
 17a:	1c2080e7          	jalr	450(ra) # 338 <read>
    if(cc < 1)
 17e:	00a05e63          	blez	a0,19a <gets+0x56>
    buf[i++] = c;
 182:	faf44783          	lbu	a5,-81(s0)
 186:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 18a:	01578763          	beq	a5,s5,198 <gets+0x54>
 18e:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 190:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 192:	fd679ae3          	bne	a5,s6,166 <gets+0x22>
 196:	a011                	j	19a <gets+0x56>
  for(i=0; i+1 < max; ){
 198:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 19a:	99de                	add	s3,s3,s7
 19c:	00098023          	sb	zero,0(s3)
  return buf;
}
 1a0:	855e                	mv	a0,s7
 1a2:	60e6                	ld	ra,88(sp)
 1a4:	6446                	ld	s0,80(sp)
 1a6:	64a6                	ld	s1,72(sp)
 1a8:	6906                	ld	s2,64(sp)
 1aa:	79e2                	ld	s3,56(sp)
 1ac:	7a42                	ld	s4,48(sp)
 1ae:	7aa2                	ld	s5,40(sp)
 1b0:	7b02                	ld	s6,32(sp)
 1b2:	6be2                	ld	s7,24(sp)
 1b4:	6125                	addi	sp,sp,96
 1b6:	8082                	ret

00000000000001b8 <stat>:

int
stat(const char *n, struct stat *st)
{
 1b8:	1101                	addi	sp,sp,-32
 1ba:	ec06                	sd	ra,24(sp)
 1bc:	e822                	sd	s0,16(sp)
 1be:	e426                	sd	s1,8(sp)
 1c0:	e04a                	sd	s2,0(sp)
 1c2:	1000                	addi	s0,sp,32
 1c4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c6:	4581                	li	a1,0
 1c8:	00000097          	auipc	ra,0x0
 1cc:	198080e7          	jalr	408(ra) # 360 <open>
  if(fd < 0)
 1d0:	02054563          	bltz	a0,1fa <stat+0x42>
 1d4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1d6:	85ca                	mv	a1,s2
 1d8:	00000097          	auipc	ra,0x0
 1dc:	1a0080e7          	jalr	416(ra) # 378 <fstat>
 1e0:	892a                	mv	s2,a0
  close(fd);
 1e2:	8526                	mv	a0,s1
 1e4:	00000097          	auipc	ra,0x0
 1e8:	164080e7          	jalr	356(ra) # 348 <close>
  return r;
}
 1ec:	854a                	mv	a0,s2
 1ee:	60e2                	ld	ra,24(sp)
 1f0:	6442                	ld	s0,16(sp)
 1f2:	64a2                	ld	s1,8(sp)
 1f4:	6902                	ld	s2,0(sp)
 1f6:	6105                	addi	sp,sp,32
 1f8:	8082                	ret
    return -1;
 1fa:	597d                	li	s2,-1
 1fc:	bfc5                	j	1ec <stat+0x34>

00000000000001fe <atoi>:

int
atoi(const char *s)
{
 1fe:	1141                	addi	sp,sp,-16
 200:	e422                	sd	s0,8(sp)
 202:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 204:	00054683          	lbu	a3,0(a0)
 208:	fd06879b          	addiw	a5,a3,-48
 20c:	0ff7f793          	andi	a5,a5,255
 210:	4725                	li	a4,9
 212:	02f76963          	bltu	a4,a5,244 <atoi+0x46>
 216:	862a                	mv	a2,a0
  n = 0;
 218:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 21a:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 21c:	0605                	addi	a2,a2,1
 21e:	0025179b          	slliw	a5,a0,0x2
 222:	9fa9                	addw	a5,a5,a0
 224:	0017979b          	slliw	a5,a5,0x1
 228:	9fb5                	addw	a5,a5,a3
 22a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 22e:	00064683          	lbu	a3,0(a2)
 232:	fd06871b          	addiw	a4,a3,-48
 236:	0ff77713          	andi	a4,a4,255
 23a:	fee5f1e3          	bgeu	a1,a4,21c <atoi+0x1e>
  return n;
}
 23e:	6422                	ld	s0,8(sp)
 240:	0141                	addi	sp,sp,16
 242:	8082                	ret
  n = 0;
 244:	4501                	li	a0,0
 246:	bfe5                	j	23e <atoi+0x40>

0000000000000248 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 248:	1141                	addi	sp,sp,-16
 24a:	e422                	sd	s0,8(sp)
 24c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 24e:	02b57663          	bgeu	a0,a1,27a <memmove+0x32>
    while(n-- > 0)
 252:	02c05163          	blez	a2,274 <memmove+0x2c>
 256:	fff6079b          	addiw	a5,a2,-1
 25a:	1782                	slli	a5,a5,0x20
 25c:	9381                	srli	a5,a5,0x20
 25e:	0785                	addi	a5,a5,1
 260:	97aa                	add	a5,a5,a0
  dst = vdst;
 262:	872a                	mv	a4,a0
      *dst++ = *src++;
 264:	0585                	addi	a1,a1,1
 266:	0705                	addi	a4,a4,1
 268:	fff5c683          	lbu	a3,-1(a1)
 26c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 270:	fee79ae3          	bne	a5,a4,264 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 274:	6422                	ld	s0,8(sp)
 276:	0141                	addi	sp,sp,16
 278:	8082                	ret
    dst += n;
 27a:	00c50733          	add	a4,a0,a2
    src += n;
 27e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 280:	fec05ae3          	blez	a2,274 <memmove+0x2c>
 284:	fff6079b          	addiw	a5,a2,-1
 288:	1782                	slli	a5,a5,0x20
 28a:	9381                	srli	a5,a5,0x20
 28c:	fff7c793          	not	a5,a5
 290:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 292:	15fd                	addi	a1,a1,-1
 294:	177d                	addi	a4,a4,-1
 296:	0005c683          	lbu	a3,0(a1)
 29a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 29e:	fef71ae3          	bne	a4,a5,292 <memmove+0x4a>
 2a2:	bfc9                	j	274 <memmove+0x2c>

00000000000002a4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2a4:	1141                	addi	sp,sp,-16
 2a6:	e422                	sd	s0,8(sp)
 2a8:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2aa:	ce15                	beqz	a2,2e6 <memcmp+0x42>
 2ac:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 2b0:	00054783          	lbu	a5,0(a0)
 2b4:	0005c703          	lbu	a4,0(a1)
 2b8:	02e79063          	bne	a5,a4,2d8 <memcmp+0x34>
 2bc:	1682                	slli	a3,a3,0x20
 2be:	9281                	srli	a3,a3,0x20
 2c0:	0685                	addi	a3,a3,1
 2c2:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 2c4:	0505                	addi	a0,a0,1
    p2++;
 2c6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2c8:	00d50d63          	beq	a0,a3,2e2 <memcmp+0x3e>
    if (*p1 != *p2) {
 2cc:	00054783          	lbu	a5,0(a0)
 2d0:	0005c703          	lbu	a4,0(a1)
 2d4:	fee788e3          	beq	a5,a4,2c4 <memcmp+0x20>
      return *p1 - *p2;
 2d8:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 2dc:	6422                	ld	s0,8(sp)
 2de:	0141                	addi	sp,sp,16
 2e0:	8082                	ret
  return 0;
 2e2:	4501                	li	a0,0
 2e4:	bfe5                	j	2dc <memcmp+0x38>
 2e6:	4501                	li	a0,0
 2e8:	bfd5                	j	2dc <memcmp+0x38>

00000000000002ea <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2ea:	1141                	addi	sp,sp,-16
 2ec:	e406                	sd	ra,8(sp)
 2ee:	e022                	sd	s0,0(sp)
 2f0:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2f2:	00000097          	auipc	ra,0x0
 2f6:	f56080e7          	jalr	-170(ra) # 248 <memmove>
}
 2fa:	60a2                	ld	ra,8(sp)
 2fc:	6402                	ld	s0,0(sp)
 2fe:	0141                	addi	sp,sp,16
 300:	8082                	ret

0000000000000302 <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 302:	1141                	addi	sp,sp,-16
 304:	e422                	sd	s0,8(sp)
 306:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 308:	040007b7          	lui	a5,0x4000
}
 30c:	17f5                	addi	a5,a5,-3
 30e:	07b2                	slli	a5,a5,0xc
 310:	4388                	lw	a0,0(a5)
 312:	6422                	ld	s0,8(sp)
 314:	0141                	addi	sp,sp,16
 316:	8082                	ret

0000000000000318 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 318:	4885                	li	a7,1
 ecall
 31a:	00000073          	ecall
 ret
 31e:	8082                	ret

0000000000000320 <exit>:
.global exit
exit:
 li a7, SYS_exit
 320:	4889                	li	a7,2
 ecall
 322:	00000073          	ecall
 ret
 326:	8082                	ret

0000000000000328 <wait>:
.global wait
wait:
 li a7, SYS_wait
 328:	488d                	li	a7,3
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 330:	4891                	li	a7,4
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <read>:
.global read
read:
 li a7, SYS_read
 338:	4895                	li	a7,5
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <write>:
.global write
write:
 li a7, SYS_write
 340:	48c1                	li	a7,16
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <close>:
.global close
close:
 li a7, SYS_close
 348:	48d5                	li	a7,21
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <kill>:
.global kill
kill:
 li a7, SYS_kill
 350:	4899                	li	a7,6
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <exec>:
.global exec
exec:
 li a7, SYS_exec
 358:	489d                	li	a7,7
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <open>:
.global open
open:
 li a7, SYS_open
 360:	48bd                	li	a7,15
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 368:	48c5                	li	a7,17
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 370:	48c9                	li	a7,18
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 378:	48a1                	li	a7,8
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <link>:
.global link
link:
 li a7, SYS_link
 380:	48cd                	li	a7,19
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 388:	48d1                	li	a7,20
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 390:	48a5                	li	a7,9
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <dup>:
.global dup
dup:
 li a7, SYS_dup
 398:	48a9                	li	a7,10
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3a0:	48ad                	li	a7,11
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3a8:	48b1                	li	a7,12
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3b0:	48b5                	li	a7,13
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3b8:	48b9                	li	a7,14
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <trace>:
.global trace
trace:
 li a7, SYS_trace
 3c0:	48d9                	li	a7,22
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 3c8:	48dd                	li	a7,23
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <connect>:
.global connect
connect:
 li a7, SYS_connect
 3d0:	48f5                	li	a7,29
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 3d8:	48f9                	li	a7,30
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3e0:	1101                	addi	sp,sp,-32
 3e2:	ec06                	sd	ra,24(sp)
 3e4:	e822                	sd	s0,16(sp)
 3e6:	1000                	addi	s0,sp,32
 3e8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3ec:	4605                	li	a2,1
 3ee:	fef40593          	addi	a1,s0,-17
 3f2:	00000097          	auipc	ra,0x0
 3f6:	f4e080e7          	jalr	-178(ra) # 340 <write>
}
 3fa:	60e2                	ld	ra,24(sp)
 3fc:	6442                	ld	s0,16(sp)
 3fe:	6105                	addi	sp,sp,32
 400:	8082                	ret

0000000000000402 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 402:	7139                	addi	sp,sp,-64
 404:	fc06                	sd	ra,56(sp)
 406:	f822                	sd	s0,48(sp)
 408:	f426                	sd	s1,40(sp)
 40a:	f04a                	sd	s2,32(sp)
 40c:	ec4e                	sd	s3,24(sp)
 40e:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 410:	c299                	beqz	a3,416 <printint+0x14>
 412:	0005cd63          	bltz	a1,42c <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 416:	2581                	sext.w	a1,a1
  neg = 0;
 418:	4301                	li	t1,0
 41a:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 41e:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 420:	2601                	sext.w	a2,a2
 422:	00000897          	auipc	a7,0x0
 426:	46e88893          	addi	a7,a7,1134 # 890 <digits>
 42a:	a039                	j	438 <printint+0x36>
    x = -xx;
 42c:	40b005bb          	negw	a1,a1
    neg = 1;
 430:	4305                	li	t1,1
    x = -xx;
 432:	b7e5                	j	41a <printint+0x18>
  }while((x /= base) != 0);
 434:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 436:	8836                	mv	a6,a3
 438:	0018069b          	addiw	a3,a6,1
 43c:	02c5f7bb          	remuw	a5,a1,a2
 440:	1782                	slli	a5,a5,0x20
 442:	9381                	srli	a5,a5,0x20
 444:	97c6                	add	a5,a5,a7
 446:	0007c783          	lbu	a5,0(a5) # 4000000 <base+0x3ffeff0>
 44a:	00f70023          	sb	a5,0(a4)
 44e:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 450:	02c5d7bb          	divuw	a5,a1,a2
 454:	fec5f0e3          	bgeu	a1,a2,434 <printint+0x32>
  if(neg)
 458:	00030b63          	beqz	t1,46e <printint+0x6c>
    buf[i++] = '-';
 45c:	fd040793          	addi	a5,s0,-48
 460:	96be                	add	a3,a3,a5
 462:	02d00793          	li	a5,45
 466:	fef68823          	sb	a5,-16(a3)
 46a:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 46e:	02d05963          	blez	a3,4a0 <printint+0x9e>
 472:	89aa                	mv	s3,a0
 474:	fc040793          	addi	a5,s0,-64
 478:	00d784b3          	add	s1,a5,a3
 47c:	fff78913          	addi	s2,a5,-1
 480:	9936                	add	s2,s2,a3
 482:	36fd                	addiw	a3,a3,-1
 484:	1682                	slli	a3,a3,0x20
 486:	9281                	srli	a3,a3,0x20
 488:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 48c:	fff4c583          	lbu	a1,-1(s1)
 490:	854e                	mv	a0,s3
 492:	00000097          	auipc	ra,0x0
 496:	f4e080e7          	jalr	-178(ra) # 3e0 <putc>
 49a:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 49c:	ff2498e3          	bne	s1,s2,48c <printint+0x8a>
}
 4a0:	70e2                	ld	ra,56(sp)
 4a2:	7442                	ld	s0,48(sp)
 4a4:	74a2                	ld	s1,40(sp)
 4a6:	7902                	ld	s2,32(sp)
 4a8:	69e2                	ld	s3,24(sp)
 4aa:	6121                	addi	sp,sp,64
 4ac:	8082                	ret

00000000000004ae <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4ae:	7119                	addi	sp,sp,-128
 4b0:	fc86                	sd	ra,120(sp)
 4b2:	f8a2                	sd	s0,112(sp)
 4b4:	f4a6                	sd	s1,104(sp)
 4b6:	f0ca                	sd	s2,96(sp)
 4b8:	ecce                	sd	s3,88(sp)
 4ba:	e8d2                	sd	s4,80(sp)
 4bc:	e4d6                	sd	s5,72(sp)
 4be:	e0da                	sd	s6,64(sp)
 4c0:	fc5e                	sd	s7,56(sp)
 4c2:	f862                	sd	s8,48(sp)
 4c4:	f466                	sd	s9,40(sp)
 4c6:	f06a                	sd	s10,32(sp)
 4c8:	ec6e                	sd	s11,24(sp)
 4ca:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4cc:	0005c483          	lbu	s1,0(a1)
 4d0:	18048d63          	beqz	s1,66a <vprintf+0x1bc>
 4d4:	8aaa                	mv	s5,a0
 4d6:	8b32                	mv	s6,a2
 4d8:	00158913          	addi	s2,a1,1
  state = 0;
 4dc:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4de:	02500a13          	li	s4,37
      if(c == 'd'){
 4e2:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 4e6:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 4ea:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 4ee:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 4f2:	00000b97          	auipc	s7,0x0
 4f6:	39eb8b93          	addi	s7,s7,926 # 890 <digits>
 4fa:	a839                	j	518 <vprintf+0x6a>
        putc(fd, c);
 4fc:	85a6                	mv	a1,s1
 4fe:	8556                	mv	a0,s5
 500:	00000097          	auipc	ra,0x0
 504:	ee0080e7          	jalr	-288(ra) # 3e0 <putc>
 508:	a019                	j	50e <vprintf+0x60>
    } else if(state == '%'){
 50a:	01498f63          	beq	s3,s4,528 <vprintf+0x7a>
 50e:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 510:	fff94483          	lbu	s1,-1(s2)
 514:	14048b63          	beqz	s1,66a <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 518:	0004879b          	sext.w	a5,s1
    if(state == 0){
 51c:	fe0997e3          	bnez	s3,50a <vprintf+0x5c>
      if(c == '%'){
 520:	fd479ee3          	bne	a5,s4,4fc <vprintf+0x4e>
        state = '%';
 524:	89be                	mv	s3,a5
 526:	b7e5                	j	50e <vprintf+0x60>
      if(c == 'd'){
 528:	05878063          	beq	a5,s8,568 <vprintf+0xba>
      } else if(c == 'l') {
 52c:	05978c63          	beq	a5,s9,584 <vprintf+0xd6>
      } else if(c == 'x') {
 530:	07a78863          	beq	a5,s10,5a0 <vprintf+0xf2>
      } else if(c == 'p') {
 534:	09b78463          	beq	a5,s11,5bc <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 538:	07300713          	li	a4,115
 53c:	0ce78563          	beq	a5,a4,606 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 540:	06300713          	li	a4,99
 544:	0ee78c63          	beq	a5,a4,63c <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 548:	11478663          	beq	a5,s4,654 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 54c:	85d2                	mv	a1,s4
 54e:	8556                	mv	a0,s5
 550:	00000097          	auipc	ra,0x0
 554:	e90080e7          	jalr	-368(ra) # 3e0 <putc>
        putc(fd, c);
 558:	85a6                	mv	a1,s1
 55a:	8556                	mv	a0,s5
 55c:	00000097          	auipc	ra,0x0
 560:	e84080e7          	jalr	-380(ra) # 3e0 <putc>
      }
      state = 0;
 564:	4981                	li	s3,0
 566:	b765                	j	50e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 568:	008b0493          	addi	s1,s6,8
 56c:	4685                	li	a3,1
 56e:	4629                	li	a2,10
 570:	000b2583          	lw	a1,0(s6)
 574:	8556                	mv	a0,s5
 576:	00000097          	auipc	ra,0x0
 57a:	e8c080e7          	jalr	-372(ra) # 402 <printint>
 57e:	8b26                	mv	s6,s1
      state = 0;
 580:	4981                	li	s3,0
 582:	b771                	j	50e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 584:	008b0493          	addi	s1,s6,8
 588:	4681                	li	a3,0
 58a:	4629                	li	a2,10
 58c:	000b2583          	lw	a1,0(s6)
 590:	8556                	mv	a0,s5
 592:	00000097          	auipc	ra,0x0
 596:	e70080e7          	jalr	-400(ra) # 402 <printint>
 59a:	8b26                	mv	s6,s1
      state = 0;
 59c:	4981                	li	s3,0
 59e:	bf85                	j	50e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 5a0:	008b0493          	addi	s1,s6,8
 5a4:	4681                	li	a3,0
 5a6:	4641                	li	a2,16
 5a8:	000b2583          	lw	a1,0(s6)
 5ac:	8556                	mv	a0,s5
 5ae:	00000097          	auipc	ra,0x0
 5b2:	e54080e7          	jalr	-428(ra) # 402 <printint>
 5b6:	8b26                	mv	s6,s1
      state = 0;
 5b8:	4981                	li	s3,0
 5ba:	bf91                	j	50e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 5bc:	008b0793          	addi	a5,s6,8
 5c0:	f8f43423          	sd	a5,-120(s0)
 5c4:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 5c8:	03000593          	li	a1,48
 5cc:	8556                	mv	a0,s5
 5ce:	00000097          	auipc	ra,0x0
 5d2:	e12080e7          	jalr	-494(ra) # 3e0 <putc>
  putc(fd, 'x');
 5d6:	85ea                	mv	a1,s10
 5d8:	8556                	mv	a0,s5
 5da:	00000097          	auipc	ra,0x0
 5de:	e06080e7          	jalr	-506(ra) # 3e0 <putc>
 5e2:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5e4:	03c9d793          	srli	a5,s3,0x3c
 5e8:	97de                	add	a5,a5,s7
 5ea:	0007c583          	lbu	a1,0(a5)
 5ee:	8556                	mv	a0,s5
 5f0:	00000097          	auipc	ra,0x0
 5f4:	df0080e7          	jalr	-528(ra) # 3e0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5f8:	0992                	slli	s3,s3,0x4
 5fa:	34fd                	addiw	s1,s1,-1
 5fc:	f4e5                	bnez	s1,5e4 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 5fe:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 602:	4981                	li	s3,0
 604:	b729                	j	50e <vprintf+0x60>
        s = va_arg(ap, char*);
 606:	008b0993          	addi	s3,s6,8
 60a:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 60e:	c085                	beqz	s1,62e <vprintf+0x180>
        while(*s != 0){
 610:	0004c583          	lbu	a1,0(s1)
 614:	c9a1                	beqz	a1,664 <vprintf+0x1b6>
          putc(fd, *s);
 616:	8556                	mv	a0,s5
 618:	00000097          	auipc	ra,0x0
 61c:	dc8080e7          	jalr	-568(ra) # 3e0 <putc>
          s++;
 620:	0485                	addi	s1,s1,1
        while(*s != 0){
 622:	0004c583          	lbu	a1,0(s1)
 626:	f9e5                	bnez	a1,616 <vprintf+0x168>
        s = va_arg(ap, char*);
 628:	8b4e                	mv	s6,s3
      state = 0;
 62a:	4981                	li	s3,0
 62c:	b5cd                	j	50e <vprintf+0x60>
          s = "(null)";
 62e:	00000497          	auipc	s1,0x0
 632:	27a48493          	addi	s1,s1,634 # 8a8 <digits+0x18>
        while(*s != 0){
 636:	02800593          	li	a1,40
 63a:	bff1                	j	616 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 63c:	008b0493          	addi	s1,s6,8
 640:	000b4583          	lbu	a1,0(s6)
 644:	8556                	mv	a0,s5
 646:	00000097          	auipc	ra,0x0
 64a:	d9a080e7          	jalr	-614(ra) # 3e0 <putc>
 64e:	8b26                	mv	s6,s1
      state = 0;
 650:	4981                	li	s3,0
 652:	bd75                	j	50e <vprintf+0x60>
        putc(fd, c);
 654:	85d2                	mv	a1,s4
 656:	8556                	mv	a0,s5
 658:	00000097          	auipc	ra,0x0
 65c:	d88080e7          	jalr	-632(ra) # 3e0 <putc>
      state = 0;
 660:	4981                	li	s3,0
 662:	b575                	j	50e <vprintf+0x60>
        s = va_arg(ap, char*);
 664:	8b4e                	mv	s6,s3
      state = 0;
 666:	4981                	li	s3,0
 668:	b55d                	j	50e <vprintf+0x60>
    }
  }
}
 66a:	70e6                	ld	ra,120(sp)
 66c:	7446                	ld	s0,112(sp)
 66e:	74a6                	ld	s1,104(sp)
 670:	7906                	ld	s2,96(sp)
 672:	69e6                	ld	s3,88(sp)
 674:	6a46                	ld	s4,80(sp)
 676:	6aa6                	ld	s5,72(sp)
 678:	6b06                	ld	s6,64(sp)
 67a:	7be2                	ld	s7,56(sp)
 67c:	7c42                	ld	s8,48(sp)
 67e:	7ca2                	ld	s9,40(sp)
 680:	7d02                	ld	s10,32(sp)
 682:	6de2                	ld	s11,24(sp)
 684:	6109                	addi	sp,sp,128
 686:	8082                	ret

0000000000000688 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 688:	715d                	addi	sp,sp,-80
 68a:	ec06                	sd	ra,24(sp)
 68c:	e822                	sd	s0,16(sp)
 68e:	1000                	addi	s0,sp,32
 690:	e010                	sd	a2,0(s0)
 692:	e414                	sd	a3,8(s0)
 694:	e818                	sd	a4,16(s0)
 696:	ec1c                	sd	a5,24(s0)
 698:	03043023          	sd	a6,32(s0)
 69c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6a0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6a4:	8622                	mv	a2,s0
 6a6:	00000097          	auipc	ra,0x0
 6aa:	e08080e7          	jalr	-504(ra) # 4ae <vprintf>
}
 6ae:	60e2                	ld	ra,24(sp)
 6b0:	6442                	ld	s0,16(sp)
 6b2:	6161                	addi	sp,sp,80
 6b4:	8082                	ret

00000000000006b6 <printf>:

void
printf(const char *fmt, ...)
{
 6b6:	711d                	addi	sp,sp,-96
 6b8:	ec06                	sd	ra,24(sp)
 6ba:	e822                	sd	s0,16(sp)
 6bc:	1000                	addi	s0,sp,32
 6be:	e40c                	sd	a1,8(s0)
 6c0:	e810                	sd	a2,16(s0)
 6c2:	ec14                	sd	a3,24(s0)
 6c4:	f018                	sd	a4,32(s0)
 6c6:	f41c                	sd	a5,40(s0)
 6c8:	03043823          	sd	a6,48(s0)
 6cc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6d0:	00840613          	addi	a2,s0,8
 6d4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6d8:	85aa                	mv	a1,a0
 6da:	4505                	li	a0,1
 6dc:	00000097          	auipc	ra,0x0
 6e0:	dd2080e7          	jalr	-558(ra) # 4ae <vprintf>
}
 6e4:	60e2                	ld	ra,24(sp)
 6e6:	6442                	ld	s0,16(sp)
 6e8:	6125                	addi	sp,sp,96
 6ea:	8082                	ret

00000000000006ec <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6ec:	1141                	addi	sp,sp,-16
 6ee:	e422                	sd	s0,8(sp)
 6f0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6f2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f6:	00001797          	auipc	a5,0x1
 6fa:	90a78793          	addi	a5,a5,-1782 # 1000 <freep>
 6fe:	639c                	ld	a5,0(a5)
 700:	a805                	j	730 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 702:	4618                	lw	a4,8(a2)
 704:	9db9                	addw	a1,a1,a4
 706:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 70a:	6398                	ld	a4,0(a5)
 70c:	6318                	ld	a4,0(a4)
 70e:	fee53823          	sd	a4,-16(a0)
 712:	a091                	j	756 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 714:	ff852703          	lw	a4,-8(a0)
 718:	9e39                	addw	a2,a2,a4
 71a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 71c:	ff053703          	ld	a4,-16(a0)
 720:	e398                	sd	a4,0(a5)
 722:	a099                	j	768 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 724:	6398                	ld	a4,0(a5)
 726:	00e7e463          	bltu	a5,a4,72e <free+0x42>
 72a:	00e6ea63          	bltu	a3,a4,73e <free+0x52>
{
 72e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 730:	fed7fae3          	bgeu	a5,a3,724 <free+0x38>
 734:	6398                	ld	a4,0(a5)
 736:	00e6e463          	bltu	a3,a4,73e <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 73a:	fee7eae3          	bltu	a5,a4,72e <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 73e:	ff852583          	lw	a1,-8(a0)
 742:	6390                	ld	a2,0(a5)
 744:	02059713          	slli	a4,a1,0x20
 748:	9301                	srli	a4,a4,0x20
 74a:	0712                	slli	a4,a4,0x4
 74c:	9736                	add	a4,a4,a3
 74e:	fae60ae3          	beq	a2,a4,702 <free+0x16>
    bp->s.ptr = p->s.ptr;
 752:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 756:	4790                	lw	a2,8(a5)
 758:	02061713          	slli	a4,a2,0x20
 75c:	9301                	srli	a4,a4,0x20
 75e:	0712                	slli	a4,a4,0x4
 760:	973e                	add	a4,a4,a5
 762:	fae689e3          	beq	a3,a4,714 <free+0x28>
  } else
    p->s.ptr = bp;
 766:	e394                	sd	a3,0(a5)
  freep = p;
 768:	00001717          	auipc	a4,0x1
 76c:	88f73c23          	sd	a5,-1896(a4) # 1000 <freep>
}
 770:	6422                	ld	s0,8(sp)
 772:	0141                	addi	sp,sp,16
 774:	8082                	ret

0000000000000776 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 776:	7139                	addi	sp,sp,-64
 778:	fc06                	sd	ra,56(sp)
 77a:	f822                	sd	s0,48(sp)
 77c:	f426                	sd	s1,40(sp)
 77e:	f04a                	sd	s2,32(sp)
 780:	ec4e                	sd	s3,24(sp)
 782:	e852                	sd	s4,16(sp)
 784:	e456                	sd	s5,8(sp)
 786:	e05a                	sd	s6,0(sp)
 788:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 78a:	02051993          	slli	s3,a0,0x20
 78e:	0209d993          	srli	s3,s3,0x20
 792:	09bd                	addi	s3,s3,15
 794:	0049d993          	srli	s3,s3,0x4
 798:	2985                	addiw	s3,s3,1
 79a:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 79e:	00001797          	auipc	a5,0x1
 7a2:	86278793          	addi	a5,a5,-1950 # 1000 <freep>
 7a6:	6388                	ld	a0,0(a5)
 7a8:	c515                	beqz	a0,7d4 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7aa:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7ac:	4798                	lw	a4,8(a5)
 7ae:	03277f63          	bgeu	a4,s2,7ec <malloc+0x76>
 7b2:	8a4e                	mv	s4,s3
 7b4:	0009871b          	sext.w	a4,s3
 7b8:	6685                	lui	a3,0x1
 7ba:	00d77363          	bgeu	a4,a3,7c0 <malloc+0x4a>
 7be:	6a05                	lui	s4,0x1
 7c0:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 7c4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7c8:	00001497          	auipc	s1,0x1
 7cc:	83848493          	addi	s1,s1,-1992 # 1000 <freep>
  if(p == (char*)-1)
 7d0:	5b7d                	li	s6,-1
 7d2:	a885                	j	842 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 7d4:	00001797          	auipc	a5,0x1
 7d8:	83c78793          	addi	a5,a5,-1988 # 1010 <base>
 7dc:	00001717          	auipc	a4,0x1
 7e0:	82f73223          	sd	a5,-2012(a4) # 1000 <freep>
 7e4:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7e6:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7ea:	b7e1                	j	7b2 <malloc+0x3c>
      if(p->s.size == nunits)
 7ec:	02e90b63          	beq	s2,a4,822 <malloc+0xac>
        p->s.size -= nunits;
 7f0:	4137073b          	subw	a4,a4,s3
 7f4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7f6:	1702                	slli	a4,a4,0x20
 7f8:	9301                	srli	a4,a4,0x20
 7fa:	0712                	slli	a4,a4,0x4
 7fc:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7fe:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 802:	00000717          	auipc	a4,0x0
 806:	7ea73f23          	sd	a0,2046(a4) # 1000 <freep>
      return (void*)(p + 1);
 80a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 80e:	70e2                	ld	ra,56(sp)
 810:	7442                	ld	s0,48(sp)
 812:	74a2                	ld	s1,40(sp)
 814:	7902                	ld	s2,32(sp)
 816:	69e2                	ld	s3,24(sp)
 818:	6a42                	ld	s4,16(sp)
 81a:	6aa2                	ld	s5,8(sp)
 81c:	6b02                	ld	s6,0(sp)
 81e:	6121                	addi	sp,sp,64
 820:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 822:	6398                	ld	a4,0(a5)
 824:	e118                	sd	a4,0(a0)
 826:	bff1                	j	802 <malloc+0x8c>
  hp->s.size = nu;
 828:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 82c:	0541                	addi	a0,a0,16
 82e:	00000097          	auipc	ra,0x0
 832:	ebe080e7          	jalr	-322(ra) # 6ec <free>
  return freep;
 836:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 838:	d979                	beqz	a0,80e <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 83a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 83c:	4798                	lw	a4,8(a5)
 83e:	fb2777e3          	bgeu	a4,s2,7ec <malloc+0x76>
    if(p == freep)
 842:	6098                	ld	a4,0(s1)
 844:	853e                	mv	a0,a5
 846:	fef71ae3          	bne	a4,a5,83a <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 84a:	8552                	mv	a0,s4
 84c:	00000097          	auipc	ra,0x0
 850:	b5c080e7          	jalr	-1188(ra) # 3a8 <sbrk>
  if(p == (char*)-1)
 854:	fd651ae3          	bne	a0,s6,828 <malloc+0xb2>
        return 0;
 858:	4501                	li	a0,0
 85a:	bf55                	j	80e <malloc+0x98>
