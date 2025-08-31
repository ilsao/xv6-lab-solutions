
user/_sleep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char *argv[])
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
    if (argc != 2) {
   8:	4789                	li	a5,2
   a:	02f50263          	beq	a0,a5,2e <main+0x2e>
        write(1, "sleep error: argument is needed\n", 33);
   e:	02100613          	li	a2,33
  12:	00001597          	auipc	a1,0x1
  16:	83e58593          	addi	a1,a1,-1986 # 850 <malloc+0xf0>
  1a:	4505                	li	a0,1
  1c:	00000097          	auipc	ra,0x0
  20:	30e080e7          	jalr	782(ra) # 32a <write>
        exit(0);
  24:	4501                	li	a0,0
  26:	00000097          	auipc	ra,0x0
  2a:	2e4080e7          	jalr	740(ra) # 30a <exit>
    }
    
    sleep(atoi(argv[1]));
  2e:	6588                	ld	a0,8(a1)
  30:	00000097          	auipc	ra,0x0
  34:	1b8080e7          	jalr	440(ra) # 1e8 <atoi>
  38:	00000097          	auipc	ra,0x0
  3c:	362080e7          	jalr	866(ra) # 39a <sleep>
    exit(0);
  40:	4501                	li	a0,0
  42:	00000097          	auipc	ra,0x0
  46:	2c8080e7          	jalr	712(ra) # 30a <exit>

000000000000004a <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  4a:	1141                	addi	sp,sp,-16
  4c:	e406                	sd	ra,8(sp)
  4e:	e022                	sd	s0,0(sp)
  50:	0800                	addi	s0,sp,16
  extern int main();
  main();
  52:	00000097          	auipc	ra,0x0
  56:	fae080e7          	jalr	-82(ra) # 0 <main>
  exit(0);
  5a:	4501                	li	a0,0
  5c:	00000097          	auipc	ra,0x0
  60:	2ae080e7          	jalr	686(ra) # 30a <exit>

0000000000000064 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  64:	1141                	addi	sp,sp,-16
  66:	e422                	sd	s0,8(sp)
  68:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6a:	87aa                	mv	a5,a0
  6c:	0585                	addi	a1,a1,1
  6e:	0785                	addi	a5,a5,1
  70:	fff5c703          	lbu	a4,-1(a1)
  74:	fee78fa3          	sb	a4,-1(a5)
  78:	fb75                	bnez	a4,6c <strcpy+0x8>
    ;
  return os;
}
  7a:	6422                	ld	s0,8(sp)
  7c:	0141                	addi	sp,sp,16
  7e:	8082                	ret

0000000000000080 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80:	1141                	addi	sp,sp,-16
  82:	e422                	sd	s0,8(sp)
  84:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  86:	00054783          	lbu	a5,0(a0)
  8a:	cf91                	beqz	a5,a6 <strcmp+0x26>
  8c:	0005c703          	lbu	a4,0(a1)
  90:	00f71b63          	bne	a4,a5,a6 <strcmp+0x26>
    p++, q++;
  94:	0505                	addi	a0,a0,1
  96:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  98:	00054783          	lbu	a5,0(a0)
  9c:	c789                	beqz	a5,a6 <strcmp+0x26>
  9e:	0005c703          	lbu	a4,0(a1)
  a2:	fef709e3          	beq	a4,a5,94 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  a6:	0005c503          	lbu	a0,0(a1)
}
  aa:	40a7853b          	subw	a0,a5,a0
  ae:	6422                	ld	s0,8(sp)
  b0:	0141                	addi	sp,sp,16
  b2:	8082                	ret

00000000000000b4 <strlen>:

uint
strlen(const char *s)
{
  b4:	1141                	addi	sp,sp,-16
  b6:	e422                	sd	s0,8(sp)
  b8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  ba:	00054783          	lbu	a5,0(a0)
  be:	cf91                	beqz	a5,da <strlen+0x26>
  c0:	0505                	addi	a0,a0,1
  c2:	87aa                	mv	a5,a0
  c4:	4685                	li	a3,1
  c6:	9e89                	subw	a3,a3,a0
    ;
  c8:	00f6853b          	addw	a0,a3,a5
  cc:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
  ce:	fff7c703          	lbu	a4,-1(a5)
  d2:	fb7d                	bnez	a4,c8 <strlen+0x14>
  return n;
}
  d4:	6422                	ld	s0,8(sp)
  d6:	0141                	addi	sp,sp,16
  d8:	8082                	ret
  for(n = 0; s[n]; n++)
  da:	4501                	li	a0,0
  dc:	bfe5                	j	d4 <strlen+0x20>

00000000000000de <memset>:

void*
memset(void *dst, int c, uint n)
{
  de:	1141                	addi	sp,sp,-16
  e0:	e422                	sd	s0,8(sp)
  e2:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  e4:	ce09                	beqz	a2,fe <memset+0x20>
  e6:	87aa                	mv	a5,a0
  e8:	fff6071b          	addiw	a4,a2,-1
  ec:	1702                	slli	a4,a4,0x20
  ee:	9301                	srli	a4,a4,0x20
  f0:	0705                	addi	a4,a4,1
  f2:	972a                	add	a4,a4,a0
    cdst[i] = c;
  f4:	00b78023          	sb	a1,0(a5)
  f8:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
  fa:	fee79de3          	bne	a5,a4,f4 <memset+0x16>
  }
  return dst;
}
  fe:	6422                	ld	s0,8(sp)
 100:	0141                	addi	sp,sp,16
 102:	8082                	ret

0000000000000104 <strchr>:

char*
strchr(const char *s, char c)
{
 104:	1141                	addi	sp,sp,-16
 106:	e422                	sd	s0,8(sp)
 108:	0800                	addi	s0,sp,16
  for(; *s; s++)
 10a:	00054783          	lbu	a5,0(a0)
 10e:	cf91                	beqz	a5,12a <strchr+0x26>
    if(*s == c)
 110:	00f58a63          	beq	a1,a5,124 <strchr+0x20>
  for(; *s; s++)
 114:	0505                	addi	a0,a0,1
 116:	00054783          	lbu	a5,0(a0)
 11a:	c781                	beqz	a5,122 <strchr+0x1e>
    if(*s == c)
 11c:	feb79ce3          	bne	a5,a1,114 <strchr+0x10>
 120:	a011                	j	124 <strchr+0x20>
      return (char*)s;
  return 0;
 122:	4501                	li	a0,0
}
 124:	6422                	ld	s0,8(sp)
 126:	0141                	addi	sp,sp,16
 128:	8082                	ret
  return 0;
 12a:	4501                	li	a0,0
 12c:	bfe5                	j	124 <strchr+0x20>

000000000000012e <gets>:

char*
gets(char *buf, int max)
{
 12e:	711d                	addi	sp,sp,-96
 130:	ec86                	sd	ra,88(sp)
 132:	e8a2                	sd	s0,80(sp)
 134:	e4a6                	sd	s1,72(sp)
 136:	e0ca                	sd	s2,64(sp)
 138:	fc4e                	sd	s3,56(sp)
 13a:	f852                	sd	s4,48(sp)
 13c:	f456                	sd	s5,40(sp)
 13e:	f05a                	sd	s6,32(sp)
 140:	ec5e                	sd	s7,24(sp)
 142:	1080                	addi	s0,sp,96
 144:	8baa                	mv	s7,a0
 146:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 148:	892a                	mv	s2,a0
 14a:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 14c:	4aa9                	li	s5,10
 14e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 150:	0019849b          	addiw	s1,s3,1
 154:	0344d863          	bge	s1,s4,184 <gets+0x56>
    cc = read(0, &c, 1);
 158:	4605                	li	a2,1
 15a:	faf40593          	addi	a1,s0,-81
 15e:	4501                	li	a0,0
 160:	00000097          	auipc	ra,0x0
 164:	1c2080e7          	jalr	450(ra) # 322 <read>
    if(cc < 1)
 168:	00a05e63          	blez	a0,184 <gets+0x56>
    buf[i++] = c;
 16c:	faf44783          	lbu	a5,-81(s0)
 170:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 174:	01578763          	beq	a5,s5,182 <gets+0x54>
 178:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 17a:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 17c:	fd679ae3          	bne	a5,s6,150 <gets+0x22>
 180:	a011                	j	184 <gets+0x56>
  for(i=0; i+1 < max; ){
 182:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 184:	99de                	add	s3,s3,s7
 186:	00098023          	sb	zero,0(s3)
  return buf;
}
 18a:	855e                	mv	a0,s7
 18c:	60e6                	ld	ra,88(sp)
 18e:	6446                	ld	s0,80(sp)
 190:	64a6                	ld	s1,72(sp)
 192:	6906                	ld	s2,64(sp)
 194:	79e2                	ld	s3,56(sp)
 196:	7a42                	ld	s4,48(sp)
 198:	7aa2                	ld	s5,40(sp)
 19a:	7b02                	ld	s6,32(sp)
 19c:	6be2                	ld	s7,24(sp)
 19e:	6125                	addi	sp,sp,96
 1a0:	8082                	ret

00000000000001a2 <stat>:

int
stat(const char *n, struct stat *st)
{
 1a2:	1101                	addi	sp,sp,-32
 1a4:	ec06                	sd	ra,24(sp)
 1a6:	e822                	sd	s0,16(sp)
 1a8:	e426                	sd	s1,8(sp)
 1aa:	e04a                	sd	s2,0(sp)
 1ac:	1000                	addi	s0,sp,32
 1ae:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b0:	4581                	li	a1,0
 1b2:	00000097          	auipc	ra,0x0
 1b6:	198080e7          	jalr	408(ra) # 34a <open>
  if(fd < 0)
 1ba:	02054563          	bltz	a0,1e4 <stat+0x42>
 1be:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1c0:	85ca                	mv	a1,s2
 1c2:	00000097          	auipc	ra,0x0
 1c6:	1a0080e7          	jalr	416(ra) # 362 <fstat>
 1ca:	892a                	mv	s2,a0
  close(fd);
 1cc:	8526                	mv	a0,s1
 1ce:	00000097          	auipc	ra,0x0
 1d2:	164080e7          	jalr	356(ra) # 332 <close>
  return r;
}
 1d6:	854a                	mv	a0,s2
 1d8:	60e2                	ld	ra,24(sp)
 1da:	6442                	ld	s0,16(sp)
 1dc:	64a2                	ld	s1,8(sp)
 1de:	6902                	ld	s2,0(sp)
 1e0:	6105                	addi	sp,sp,32
 1e2:	8082                	ret
    return -1;
 1e4:	597d                	li	s2,-1
 1e6:	bfc5                	j	1d6 <stat+0x34>

00000000000001e8 <atoi>:

int
atoi(const char *s)
{
 1e8:	1141                	addi	sp,sp,-16
 1ea:	e422                	sd	s0,8(sp)
 1ec:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1ee:	00054683          	lbu	a3,0(a0)
 1f2:	fd06879b          	addiw	a5,a3,-48
 1f6:	0ff7f793          	andi	a5,a5,255
 1fa:	4725                	li	a4,9
 1fc:	02f76963          	bltu	a4,a5,22e <atoi+0x46>
 200:	862a                	mv	a2,a0
  n = 0;
 202:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 204:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 206:	0605                	addi	a2,a2,1
 208:	0025179b          	slliw	a5,a0,0x2
 20c:	9fa9                	addw	a5,a5,a0
 20e:	0017979b          	slliw	a5,a5,0x1
 212:	9fb5                	addw	a5,a5,a3
 214:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 218:	00064683          	lbu	a3,0(a2)
 21c:	fd06871b          	addiw	a4,a3,-48
 220:	0ff77713          	andi	a4,a4,255
 224:	fee5f1e3          	bgeu	a1,a4,206 <atoi+0x1e>
  return n;
}
 228:	6422                	ld	s0,8(sp)
 22a:	0141                	addi	sp,sp,16
 22c:	8082                	ret
  n = 0;
 22e:	4501                	li	a0,0
 230:	bfe5                	j	228 <atoi+0x40>

0000000000000232 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 232:	1141                	addi	sp,sp,-16
 234:	e422                	sd	s0,8(sp)
 236:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 238:	02b57663          	bgeu	a0,a1,264 <memmove+0x32>
    while(n-- > 0)
 23c:	02c05163          	blez	a2,25e <memmove+0x2c>
 240:	fff6079b          	addiw	a5,a2,-1
 244:	1782                	slli	a5,a5,0x20
 246:	9381                	srli	a5,a5,0x20
 248:	0785                	addi	a5,a5,1
 24a:	97aa                	add	a5,a5,a0
  dst = vdst;
 24c:	872a                	mv	a4,a0
      *dst++ = *src++;
 24e:	0585                	addi	a1,a1,1
 250:	0705                	addi	a4,a4,1
 252:	fff5c683          	lbu	a3,-1(a1)
 256:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 25a:	fee79ae3          	bne	a5,a4,24e <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 25e:	6422                	ld	s0,8(sp)
 260:	0141                	addi	sp,sp,16
 262:	8082                	ret
    dst += n;
 264:	00c50733          	add	a4,a0,a2
    src += n;
 268:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 26a:	fec05ae3          	blez	a2,25e <memmove+0x2c>
 26e:	fff6079b          	addiw	a5,a2,-1
 272:	1782                	slli	a5,a5,0x20
 274:	9381                	srli	a5,a5,0x20
 276:	fff7c793          	not	a5,a5
 27a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 27c:	15fd                	addi	a1,a1,-1
 27e:	177d                	addi	a4,a4,-1
 280:	0005c683          	lbu	a3,0(a1)
 284:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 288:	fef71ae3          	bne	a4,a5,27c <memmove+0x4a>
 28c:	bfc9                	j	25e <memmove+0x2c>

000000000000028e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 28e:	1141                	addi	sp,sp,-16
 290:	e422                	sd	s0,8(sp)
 292:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 294:	ce15                	beqz	a2,2d0 <memcmp+0x42>
 296:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 29a:	00054783          	lbu	a5,0(a0)
 29e:	0005c703          	lbu	a4,0(a1)
 2a2:	02e79063          	bne	a5,a4,2c2 <memcmp+0x34>
 2a6:	1682                	slli	a3,a3,0x20
 2a8:	9281                	srli	a3,a3,0x20
 2aa:	0685                	addi	a3,a3,1
 2ac:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 2ae:	0505                	addi	a0,a0,1
    p2++;
 2b0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2b2:	00d50d63          	beq	a0,a3,2cc <memcmp+0x3e>
    if (*p1 != *p2) {
 2b6:	00054783          	lbu	a5,0(a0)
 2ba:	0005c703          	lbu	a4,0(a1)
 2be:	fee788e3          	beq	a5,a4,2ae <memcmp+0x20>
      return *p1 - *p2;
 2c2:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 2c6:	6422                	ld	s0,8(sp)
 2c8:	0141                	addi	sp,sp,16
 2ca:	8082                	ret
  return 0;
 2cc:	4501                	li	a0,0
 2ce:	bfe5                	j	2c6 <memcmp+0x38>
 2d0:	4501                	li	a0,0
 2d2:	bfd5                	j	2c6 <memcmp+0x38>

00000000000002d4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2d4:	1141                	addi	sp,sp,-16
 2d6:	e406                	sd	ra,8(sp)
 2d8:	e022                	sd	s0,0(sp)
 2da:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2dc:	00000097          	auipc	ra,0x0
 2e0:	f56080e7          	jalr	-170(ra) # 232 <memmove>
}
 2e4:	60a2                	ld	ra,8(sp)
 2e6:	6402                	ld	s0,0(sp)
 2e8:	0141                	addi	sp,sp,16
 2ea:	8082                	ret

00000000000002ec <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 2ec:	1141                	addi	sp,sp,-16
 2ee:	e422                	sd	s0,8(sp)
 2f0:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 2f2:	040007b7          	lui	a5,0x4000
}
 2f6:	17f5                	addi	a5,a5,-3
 2f8:	07b2                	slli	a5,a5,0xc
 2fa:	4388                	lw	a0,0(a5)
 2fc:	6422                	ld	s0,8(sp)
 2fe:	0141                	addi	sp,sp,16
 300:	8082                	ret

0000000000000302 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 302:	4885                	li	a7,1
 ecall
 304:	00000073          	ecall
 ret
 308:	8082                	ret

000000000000030a <exit>:
.global exit
exit:
 li a7, SYS_exit
 30a:	4889                	li	a7,2
 ecall
 30c:	00000073          	ecall
 ret
 310:	8082                	ret

0000000000000312 <wait>:
.global wait
wait:
 li a7, SYS_wait
 312:	488d                	li	a7,3
 ecall
 314:	00000073          	ecall
 ret
 318:	8082                	ret

000000000000031a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 31a:	4891                	li	a7,4
 ecall
 31c:	00000073          	ecall
 ret
 320:	8082                	ret

0000000000000322 <read>:
.global read
read:
 li a7, SYS_read
 322:	4895                	li	a7,5
 ecall
 324:	00000073          	ecall
 ret
 328:	8082                	ret

000000000000032a <write>:
.global write
write:
 li a7, SYS_write
 32a:	48c1                	li	a7,16
 ecall
 32c:	00000073          	ecall
 ret
 330:	8082                	ret

0000000000000332 <close>:
.global close
close:
 li a7, SYS_close
 332:	48d5                	li	a7,21
 ecall
 334:	00000073          	ecall
 ret
 338:	8082                	ret

000000000000033a <kill>:
.global kill
kill:
 li a7, SYS_kill
 33a:	4899                	li	a7,6
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <exec>:
.global exec
exec:
 li a7, SYS_exec
 342:	489d                	li	a7,7
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <open>:
.global open
open:
 li a7, SYS_open
 34a:	48bd                	li	a7,15
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 352:	48c5                	li	a7,17
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 35a:	48c9                	li	a7,18
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 362:	48a1                	li	a7,8
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <link>:
.global link
link:
 li a7, SYS_link
 36a:	48cd                	li	a7,19
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 372:	48d1                	li	a7,20
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 37a:	48a5                	li	a7,9
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <dup>:
.global dup
dup:
 li a7, SYS_dup
 382:	48a9                	li	a7,10
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 38a:	48ad                	li	a7,11
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 392:	48b1                	li	a7,12
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 39a:	48b5                	li	a7,13
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3a2:	48b9                	li	a7,14
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <trace>:
.global trace
trace:
 li a7, SYS_trace
 3aa:	48d9                	li	a7,22
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 3b2:	48dd                	li	a7,23
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <connect>:
.global connect
connect:
 li a7, SYS_connect
 3ba:	48f5                	li	a7,29
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 3c2:	48f9                	li	a7,30
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3ca:	1101                	addi	sp,sp,-32
 3cc:	ec06                	sd	ra,24(sp)
 3ce:	e822                	sd	s0,16(sp)
 3d0:	1000                	addi	s0,sp,32
 3d2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3d6:	4605                	li	a2,1
 3d8:	fef40593          	addi	a1,s0,-17
 3dc:	00000097          	auipc	ra,0x0
 3e0:	f4e080e7          	jalr	-178(ra) # 32a <write>
}
 3e4:	60e2                	ld	ra,24(sp)
 3e6:	6442                	ld	s0,16(sp)
 3e8:	6105                	addi	sp,sp,32
 3ea:	8082                	ret

00000000000003ec <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3ec:	7139                	addi	sp,sp,-64
 3ee:	fc06                	sd	ra,56(sp)
 3f0:	f822                	sd	s0,48(sp)
 3f2:	f426                	sd	s1,40(sp)
 3f4:	f04a                	sd	s2,32(sp)
 3f6:	ec4e                	sd	s3,24(sp)
 3f8:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3fa:	c299                	beqz	a3,400 <printint+0x14>
 3fc:	0005cd63          	bltz	a1,416 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 400:	2581                	sext.w	a1,a1
  neg = 0;
 402:	4301                	li	t1,0
 404:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 408:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 40a:	2601                	sext.w	a2,a2
 40c:	00000897          	auipc	a7,0x0
 410:	46c88893          	addi	a7,a7,1132 # 878 <digits>
 414:	a039                	j	422 <printint+0x36>
    x = -xx;
 416:	40b005bb          	negw	a1,a1
    neg = 1;
 41a:	4305                	li	t1,1
    x = -xx;
 41c:	b7e5                	j	404 <printint+0x18>
  }while((x /= base) != 0);
 41e:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 420:	8836                	mv	a6,a3
 422:	0018069b          	addiw	a3,a6,1
 426:	02c5f7bb          	remuw	a5,a1,a2
 42a:	1782                	slli	a5,a5,0x20
 42c:	9381                	srli	a5,a5,0x20
 42e:	97c6                	add	a5,a5,a7
 430:	0007c783          	lbu	a5,0(a5) # 4000000 <base+0x3ffeff0>
 434:	00f70023          	sb	a5,0(a4)
 438:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 43a:	02c5d7bb          	divuw	a5,a1,a2
 43e:	fec5f0e3          	bgeu	a1,a2,41e <printint+0x32>
  if(neg)
 442:	00030b63          	beqz	t1,458 <printint+0x6c>
    buf[i++] = '-';
 446:	fd040793          	addi	a5,s0,-48
 44a:	96be                	add	a3,a3,a5
 44c:	02d00793          	li	a5,45
 450:	fef68823          	sb	a5,-16(a3)
 454:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 458:	02d05963          	blez	a3,48a <printint+0x9e>
 45c:	89aa                	mv	s3,a0
 45e:	fc040793          	addi	a5,s0,-64
 462:	00d784b3          	add	s1,a5,a3
 466:	fff78913          	addi	s2,a5,-1
 46a:	9936                	add	s2,s2,a3
 46c:	36fd                	addiw	a3,a3,-1
 46e:	1682                	slli	a3,a3,0x20
 470:	9281                	srli	a3,a3,0x20
 472:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 476:	fff4c583          	lbu	a1,-1(s1)
 47a:	854e                	mv	a0,s3
 47c:	00000097          	auipc	ra,0x0
 480:	f4e080e7          	jalr	-178(ra) # 3ca <putc>
 484:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 486:	ff2498e3          	bne	s1,s2,476 <printint+0x8a>
}
 48a:	70e2                	ld	ra,56(sp)
 48c:	7442                	ld	s0,48(sp)
 48e:	74a2                	ld	s1,40(sp)
 490:	7902                	ld	s2,32(sp)
 492:	69e2                	ld	s3,24(sp)
 494:	6121                	addi	sp,sp,64
 496:	8082                	ret

0000000000000498 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 498:	7119                	addi	sp,sp,-128
 49a:	fc86                	sd	ra,120(sp)
 49c:	f8a2                	sd	s0,112(sp)
 49e:	f4a6                	sd	s1,104(sp)
 4a0:	f0ca                	sd	s2,96(sp)
 4a2:	ecce                	sd	s3,88(sp)
 4a4:	e8d2                	sd	s4,80(sp)
 4a6:	e4d6                	sd	s5,72(sp)
 4a8:	e0da                	sd	s6,64(sp)
 4aa:	fc5e                	sd	s7,56(sp)
 4ac:	f862                	sd	s8,48(sp)
 4ae:	f466                	sd	s9,40(sp)
 4b0:	f06a                	sd	s10,32(sp)
 4b2:	ec6e                	sd	s11,24(sp)
 4b4:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4b6:	0005c483          	lbu	s1,0(a1)
 4ba:	18048d63          	beqz	s1,654 <vprintf+0x1bc>
 4be:	8aaa                	mv	s5,a0
 4c0:	8b32                	mv	s6,a2
 4c2:	00158913          	addi	s2,a1,1
  state = 0;
 4c6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4c8:	02500a13          	li	s4,37
      if(c == 'd'){
 4cc:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 4d0:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 4d4:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 4d8:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 4dc:	00000b97          	auipc	s7,0x0
 4e0:	39cb8b93          	addi	s7,s7,924 # 878 <digits>
 4e4:	a839                	j	502 <vprintf+0x6a>
        putc(fd, c);
 4e6:	85a6                	mv	a1,s1
 4e8:	8556                	mv	a0,s5
 4ea:	00000097          	auipc	ra,0x0
 4ee:	ee0080e7          	jalr	-288(ra) # 3ca <putc>
 4f2:	a019                	j	4f8 <vprintf+0x60>
    } else if(state == '%'){
 4f4:	01498f63          	beq	s3,s4,512 <vprintf+0x7a>
 4f8:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 4fa:	fff94483          	lbu	s1,-1(s2)
 4fe:	14048b63          	beqz	s1,654 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 502:	0004879b          	sext.w	a5,s1
    if(state == 0){
 506:	fe0997e3          	bnez	s3,4f4 <vprintf+0x5c>
      if(c == '%'){
 50a:	fd479ee3          	bne	a5,s4,4e6 <vprintf+0x4e>
        state = '%';
 50e:	89be                	mv	s3,a5
 510:	b7e5                	j	4f8 <vprintf+0x60>
      if(c == 'd'){
 512:	05878063          	beq	a5,s8,552 <vprintf+0xba>
      } else if(c == 'l') {
 516:	05978c63          	beq	a5,s9,56e <vprintf+0xd6>
      } else if(c == 'x') {
 51a:	07a78863          	beq	a5,s10,58a <vprintf+0xf2>
      } else if(c == 'p') {
 51e:	09b78463          	beq	a5,s11,5a6 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 522:	07300713          	li	a4,115
 526:	0ce78563          	beq	a5,a4,5f0 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 52a:	06300713          	li	a4,99
 52e:	0ee78c63          	beq	a5,a4,626 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 532:	11478663          	beq	a5,s4,63e <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 536:	85d2                	mv	a1,s4
 538:	8556                	mv	a0,s5
 53a:	00000097          	auipc	ra,0x0
 53e:	e90080e7          	jalr	-368(ra) # 3ca <putc>
        putc(fd, c);
 542:	85a6                	mv	a1,s1
 544:	8556                	mv	a0,s5
 546:	00000097          	auipc	ra,0x0
 54a:	e84080e7          	jalr	-380(ra) # 3ca <putc>
      }
      state = 0;
 54e:	4981                	li	s3,0
 550:	b765                	j	4f8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 552:	008b0493          	addi	s1,s6,8
 556:	4685                	li	a3,1
 558:	4629                	li	a2,10
 55a:	000b2583          	lw	a1,0(s6)
 55e:	8556                	mv	a0,s5
 560:	00000097          	auipc	ra,0x0
 564:	e8c080e7          	jalr	-372(ra) # 3ec <printint>
 568:	8b26                	mv	s6,s1
      state = 0;
 56a:	4981                	li	s3,0
 56c:	b771                	j	4f8 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 56e:	008b0493          	addi	s1,s6,8
 572:	4681                	li	a3,0
 574:	4629                	li	a2,10
 576:	000b2583          	lw	a1,0(s6)
 57a:	8556                	mv	a0,s5
 57c:	00000097          	auipc	ra,0x0
 580:	e70080e7          	jalr	-400(ra) # 3ec <printint>
 584:	8b26                	mv	s6,s1
      state = 0;
 586:	4981                	li	s3,0
 588:	bf85                	j	4f8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 58a:	008b0493          	addi	s1,s6,8
 58e:	4681                	li	a3,0
 590:	4641                	li	a2,16
 592:	000b2583          	lw	a1,0(s6)
 596:	8556                	mv	a0,s5
 598:	00000097          	auipc	ra,0x0
 59c:	e54080e7          	jalr	-428(ra) # 3ec <printint>
 5a0:	8b26                	mv	s6,s1
      state = 0;
 5a2:	4981                	li	s3,0
 5a4:	bf91                	j	4f8 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 5a6:	008b0793          	addi	a5,s6,8
 5aa:	f8f43423          	sd	a5,-120(s0)
 5ae:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 5b2:	03000593          	li	a1,48
 5b6:	8556                	mv	a0,s5
 5b8:	00000097          	auipc	ra,0x0
 5bc:	e12080e7          	jalr	-494(ra) # 3ca <putc>
  putc(fd, 'x');
 5c0:	85ea                	mv	a1,s10
 5c2:	8556                	mv	a0,s5
 5c4:	00000097          	auipc	ra,0x0
 5c8:	e06080e7          	jalr	-506(ra) # 3ca <putc>
 5cc:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5ce:	03c9d793          	srli	a5,s3,0x3c
 5d2:	97de                	add	a5,a5,s7
 5d4:	0007c583          	lbu	a1,0(a5)
 5d8:	8556                	mv	a0,s5
 5da:	00000097          	auipc	ra,0x0
 5de:	df0080e7          	jalr	-528(ra) # 3ca <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5e2:	0992                	slli	s3,s3,0x4
 5e4:	34fd                	addiw	s1,s1,-1
 5e6:	f4e5                	bnez	s1,5ce <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 5e8:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 5ec:	4981                	li	s3,0
 5ee:	b729                	j	4f8 <vprintf+0x60>
        s = va_arg(ap, char*);
 5f0:	008b0993          	addi	s3,s6,8
 5f4:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 5f8:	c085                	beqz	s1,618 <vprintf+0x180>
        while(*s != 0){
 5fa:	0004c583          	lbu	a1,0(s1)
 5fe:	c9a1                	beqz	a1,64e <vprintf+0x1b6>
          putc(fd, *s);
 600:	8556                	mv	a0,s5
 602:	00000097          	auipc	ra,0x0
 606:	dc8080e7          	jalr	-568(ra) # 3ca <putc>
          s++;
 60a:	0485                	addi	s1,s1,1
        while(*s != 0){
 60c:	0004c583          	lbu	a1,0(s1)
 610:	f9e5                	bnez	a1,600 <vprintf+0x168>
        s = va_arg(ap, char*);
 612:	8b4e                	mv	s6,s3
      state = 0;
 614:	4981                	li	s3,0
 616:	b5cd                	j	4f8 <vprintf+0x60>
          s = "(null)";
 618:	00000497          	auipc	s1,0x0
 61c:	27848493          	addi	s1,s1,632 # 890 <digits+0x18>
        while(*s != 0){
 620:	02800593          	li	a1,40
 624:	bff1                	j	600 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 626:	008b0493          	addi	s1,s6,8
 62a:	000b4583          	lbu	a1,0(s6)
 62e:	8556                	mv	a0,s5
 630:	00000097          	auipc	ra,0x0
 634:	d9a080e7          	jalr	-614(ra) # 3ca <putc>
 638:	8b26                	mv	s6,s1
      state = 0;
 63a:	4981                	li	s3,0
 63c:	bd75                	j	4f8 <vprintf+0x60>
        putc(fd, c);
 63e:	85d2                	mv	a1,s4
 640:	8556                	mv	a0,s5
 642:	00000097          	auipc	ra,0x0
 646:	d88080e7          	jalr	-632(ra) # 3ca <putc>
      state = 0;
 64a:	4981                	li	s3,0
 64c:	b575                	j	4f8 <vprintf+0x60>
        s = va_arg(ap, char*);
 64e:	8b4e                	mv	s6,s3
      state = 0;
 650:	4981                	li	s3,0
 652:	b55d                	j	4f8 <vprintf+0x60>
    }
  }
}
 654:	70e6                	ld	ra,120(sp)
 656:	7446                	ld	s0,112(sp)
 658:	74a6                	ld	s1,104(sp)
 65a:	7906                	ld	s2,96(sp)
 65c:	69e6                	ld	s3,88(sp)
 65e:	6a46                	ld	s4,80(sp)
 660:	6aa6                	ld	s5,72(sp)
 662:	6b06                	ld	s6,64(sp)
 664:	7be2                	ld	s7,56(sp)
 666:	7c42                	ld	s8,48(sp)
 668:	7ca2                	ld	s9,40(sp)
 66a:	7d02                	ld	s10,32(sp)
 66c:	6de2                	ld	s11,24(sp)
 66e:	6109                	addi	sp,sp,128
 670:	8082                	ret

0000000000000672 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 672:	715d                	addi	sp,sp,-80
 674:	ec06                	sd	ra,24(sp)
 676:	e822                	sd	s0,16(sp)
 678:	1000                	addi	s0,sp,32
 67a:	e010                	sd	a2,0(s0)
 67c:	e414                	sd	a3,8(s0)
 67e:	e818                	sd	a4,16(s0)
 680:	ec1c                	sd	a5,24(s0)
 682:	03043023          	sd	a6,32(s0)
 686:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 68a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 68e:	8622                	mv	a2,s0
 690:	00000097          	auipc	ra,0x0
 694:	e08080e7          	jalr	-504(ra) # 498 <vprintf>
}
 698:	60e2                	ld	ra,24(sp)
 69a:	6442                	ld	s0,16(sp)
 69c:	6161                	addi	sp,sp,80
 69e:	8082                	ret

00000000000006a0 <printf>:

void
printf(const char *fmt, ...)
{
 6a0:	711d                	addi	sp,sp,-96
 6a2:	ec06                	sd	ra,24(sp)
 6a4:	e822                	sd	s0,16(sp)
 6a6:	1000                	addi	s0,sp,32
 6a8:	e40c                	sd	a1,8(s0)
 6aa:	e810                	sd	a2,16(s0)
 6ac:	ec14                	sd	a3,24(s0)
 6ae:	f018                	sd	a4,32(s0)
 6b0:	f41c                	sd	a5,40(s0)
 6b2:	03043823          	sd	a6,48(s0)
 6b6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6ba:	00840613          	addi	a2,s0,8
 6be:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6c2:	85aa                	mv	a1,a0
 6c4:	4505                	li	a0,1
 6c6:	00000097          	auipc	ra,0x0
 6ca:	dd2080e7          	jalr	-558(ra) # 498 <vprintf>
}
 6ce:	60e2                	ld	ra,24(sp)
 6d0:	6442                	ld	s0,16(sp)
 6d2:	6125                	addi	sp,sp,96
 6d4:	8082                	ret

00000000000006d6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d6:	1141                	addi	sp,sp,-16
 6d8:	e422                	sd	s0,8(sp)
 6da:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6dc:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e0:	00001797          	auipc	a5,0x1
 6e4:	92078793          	addi	a5,a5,-1760 # 1000 <freep>
 6e8:	639c                	ld	a5,0(a5)
 6ea:	a805                	j	71a <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6ec:	4618                	lw	a4,8(a2)
 6ee:	9db9                	addw	a1,a1,a4
 6f0:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6f4:	6398                	ld	a4,0(a5)
 6f6:	6318                	ld	a4,0(a4)
 6f8:	fee53823          	sd	a4,-16(a0)
 6fc:	a091                	j	740 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6fe:	ff852703          	lw	a4,-8(a0)
 702:	9e39                	addw	a2,a2,a4
 704:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 706:	ff053703          	ld	a4,-16(a0)
 70a:	e398                	sd	a4,0(a5)
 70c:	a099                	j	752 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 70e:	6398                	ld	a4,0(a5)
 710:	00e7e463          	bltu	a5,a4,718 <free+0x42>
 714:	00e6ea63          	bltu	a3,a4,728 <free+0x52>
{
 718:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 71a:	fed7fae3          	bgeu	a5,a3,70e <free+0x38>
 71e:	6398                	ld	a4,0(a5)
 720:	00e6e463          	bltu	a3,a4,728 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 724:	fee7eae3          	bltu	a5,a4,718 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 728:	ff852583          	lw	a1,-8(a0)
 72c:	6390                	ld	a2,0(a5)
 72e:	02059713          	slli	a4,a1,0x20
 732:	9301                	srli	a4,a4,0x20
 734:	0712                	slli	a4,a4,0x4
 736:	9736                	add	a4,a4,a3
 738:	fae60ae3          	beq	a2,a4,6ec <free+0x16>
    bp->s.ptr = p->s.ptr;
 73c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 740:	4790                	lw	a2,8(a5)
 742:	02061713          	slli	a4,a2,0x20
 746:	9301                	srli	a4,a4,0x20
 748:	0712                	slli	a4,a4,0x4
 74a:	973e                	add	a4,a4,a5
 74c:	fae689e3          	beq	a3,a4,6fe <free+0x28>
  } else
    p->s.ptr = bp;
 750:	e394                	sd	a3,0(a5)
  freep = p;
 752:	00001717          	auipc	a4,0x1
 756:	8af73723          	sd	a5,-1874(a4) # 1000 <freep>
}
 75a:	6422                	ld	s0,8(sp)
 75c:	0141                	addi	sp,sp,16
 75e:	8082                	ret

0000000000000760 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 760:	7139                	addi	sp,sp,-64
 762:	fc06                	sd	ra,56(sp)
 764:	f822                	sd	s0,48(sp)
 766:	f426                	sd	s1,40(sp)
 768:	f04a                	sd	s2,32(sp)
 76a:	ec4e                	sd	s3,24(sp)
 76c:	e852                	sd	s4,16(sp)
 76e:	e456                	sd	s5,8(sp)
 770:	e05a                	sd	s6,0(sp)
 772:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 774:	02051993          	slli	s3,a0,0x20
 778:	0209d993          	srli	s3,s3,0x20
 77c:	09bd                	addi	s3,s3,15
 77e:	0049d993          	srli	s3,s3,0x4
 782:	2985                	addiw	s3,s3,1
 784:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 788:	00001797          	auipc	a5,0x1
 78c:	87878793          	addi	a5,a5,-1928 # 1000 <freep>
 790:	6388                	ld	a0,0(a5)
 792:	c515                	beqz	a0,7be <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 794:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 796:	4798                	lw	a4,8(a5)
 798:	03277f63          	bgeu	a4,s2,7d6 <malloc+0x76>
 79c:	8a4e                	mv	s4,s3
 79e:	0009871b          	sext.w	a4,s3
 7a2:	6685                	lui	a3,0x1
 7a4:	00d77363          	bgeu	a4,a3,7aa <malloc+0x4a>
 7a8:	6a05                	lui	s4,0x1
 7aa:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 7ae:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7b2:	00001497          	auipc	s1,0x1
 7b6:	84e48493          	addi	s1,s1,-1970 # 1000 <freep>
  if(p == (char*)-1)
 7ba:	5b7d                	li	s6,-1
 7bc:	a885                	j	82c <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 7be:	00001797          	auipc	a5,0x1
 7c2:	85278793          	addi	a5,a5,-1966 # 1010 <base>
 7c6:	00001717          	auipc	a4,0x1
 7ca:	82f73d23          	sd	a5,-1990(a4) # 1000 <freep>
 7ce:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7d0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7d4:	b7e1                	j	79c <malloc+0x3c>
      if(p->s.size == nunits)
 7d6:	02e90b63          	beq	s2,a4,80c <malloc+0xac>
        p->s.size -= nunits;
 7da:	4137073b          	subw	a4,a4,s3
 7de:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7e0:	1702                	slli	a4,a4,0x20
 7e2:	9301                	srli	a4,a4,0x20
 7e4:	0712                	slli	a4,a4,0x4
 7e6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7e8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7ec:	00001717          	auipc	a4,0x1
 7f0:	80a73a23          	sd	a0,-2028(a4) # 1000 <freep>
      return (void*)(p + 1);
 7f4:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7f8:	70e2                	ld	ra,56(sp)
 7fa:	7442                	ld	s0,48(sp)
 7fc:	74a2                	ld	s1,40(sp)
 7fe:	7902                	ld	s2,32(sp)
 800:	69e2                	ld	s3,24(sp)
 802:	6a42                	ld	s4,16(sp)
 804:	6aa2                	ld	s5,8(sp)
 806:	6b02                	ld	s6,0(sp)
 808:	6121                	addi	sp,sp,64
 80a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 80c:	6398                	ld	a4,0(a5)
 80e:	e118                	sd	a4,0(a0)
 810:	bff1                	j	7ec <malloc+0x8c>
  hp->s.size = nu;
 812:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 816:	0541                	addi	a0,a0,16
 818:	00000097          	auipc	ra,0x0
 81c:	ebe080e7          	jalr	-322(ra) # 6d6 <free>
  return freep;
 820:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 822:	d979                	beqz	a0,7f8 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 824:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 826:	4798                	lw	a4,8(a5)
 828:	fb2777e3          	bgeu	a4,s2,7d6 <malloc+0x76>
    if(p == freep)
 82c:	6098                	ld	a4,0(s1)
 82e:	853e                	mv	a0,a5
 830:	fef71ae3          	bne	a4,a5,824 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 834:	8552                	mv	a0,s4
 836:	00000097          	auipc	ra,0x0
 83a:	b5c080e7          	jalr	-1188(ra) # 392 <sbrk>
  if(p == (char*)-1)
 83e:	fd651ae3          	bne	a0,s6,812 <malloc+0xb2>
        return 0;
 842:	4501                	li	a0,0
 844:	bf55                	j	7f8 <malloc+0x98>
