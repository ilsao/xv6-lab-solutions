
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	89aa                	mv	s3,a0
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  10:	00001917          	auipc	s2,0x1
  14:	00090913          	mv	s2,s2
  18:	20000613          	li	a2,512
  1c:	85ca                	mv	a1,s2
  1e:	854e                	mv	a0,s3
  20:	00000097          	auipc	ra,0x0
  24:	3d2080e7          	jalr	978(ra) # 3f2 <read>
  28:	84aa                	mv	s1,a0
  2a:	02a05963          	blez	a0,5c <cat+0x5c>
    if (write(1, buf, n) != n) {
  2e:	8626                	mv	a2,s1
  30:	85ca                	mv	a1,s2
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	3c6080e7          	jalr	966(ra) # 3fa <write>
  3c:	fc950ee3          	beq	a0,s1,18 <cat+0x18>
      fprintf(2, "cat: write error\n");
  40:	00001597          	auipc	a1,0x1
  44:	8e058593          	addi	a1,a1,-1824 # 920 <malloc+0xf0>
  48:	4509                	li	a0,2
  4a:	00000097          	auipc	ra,0x0
  4e:	6f8080e7          	jalr	1784(ra) # 742 <fprintf>
      exit(1);
  52:	4505                	li	a0,1
  54:	00000097          	auipc	ra,0x0
  58:	386080e7          	jalr	902(ra) # 3da <exit>
    }
  }
  if(n < 0){
  5c:	00054963          	bltz	a0,6e <cat+0x6e>
    fprintf(2, "cat: read error\n");
    exit(1);
  }
}
  60:	70a2                	ld	ra,40(sp)
  62:	7402                	ld	s0,32(sp)
  64:	64e2                	ld	s1,24(sp)
  66:	6942                	ld	s2,16(sp)
  68:	69a2                	ld	s3,8(sp)
  6a:	6145                	addi	sp,sp,48
  6c:	8082                	ret
    fprintf(2, "cat: read error\n");
  6e:	00001597          	auipc	a1,0x1
  72:	8ca58593          	addi	a1,a1,-1846 # 938 <malloc+0x108>
  76:	4509                	li	a0,2
  78:	00000097          	auipc	ra,0x0
  7c:	6ca080e7          	jalr	1738(ra) # 742 <fprintf>
    exit(1);
  80:	4505                	li	a0,1
  82:	00000097          	auipc	ra,0x0
  86:	358080e7          	jalr	856(ra) # 3da <exit>

000000000000008a <main>:

int
main(int argc, char *argv[])
{
  8a:	7179                	addi	sp,sp,-48
  8c:	f406                	sd	ra,40(sp)
  8e:	f022                	sd	s0,32(sp)
  90:	ec26                	sd	s1,24(sp)
  92:	e84a                	sd	s2,16(sp)
  94:	e44e                	sd	s3,8(sp)
  96:	e052                	sd	s4,0(sp)
  98:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
  9a:	4785                	li	a5,1
  9c:	04a7d663          	bge	a5,a0,e8 <main+0x5e>
  a0:	00858493          	addi	s1,a1,8
  a4:	ffe5099b          	addiw	s3,a0,-2
  a8:	1982                	slli	s3,s3,0x20
  aa:	0209d993          	srli	s3,s3,0x20
  ae:	098e                	slli	s3,s3,0x3
  b0:	05c1                	addi	a1,a1,16
  b2:	99ae                	add	s3,s3,a1
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], O_RDONLY)) < 0){
  b4:	4581                	li	a1,0
  b6:	6088                	ld	a0,0(s1)
  b8:	00000097          	auipc	ra,0x0
  bc:	362080e7          	jalr	866(ra) # 41a <open>
  c0:	892a                	mv	s2,a0
  c2:	02054d63          	bltz	a0,fc <main+0x72>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
      exit(1);
    }
    cat(fd);
  c6:	00000097          	auipc	ra,0x0
  ca:	f3a080e7          	jalr	-198(ra) # 0 <cat>
    close(fd);
  ce:	854a                	mv	a0,s2
  d0:	00000097          	auipc	ra,0x0
  d4:	332080e7          	jalr	818(ra) # 402 <close>
  d8:	04a1                	addi	s1,s1,8
  for(i = 1; i < argc; i++){
  da:	fd349de3          	bne	s1,s3,b4 <main+0x2a>
  }
  exit(0);
  de:	4501                	li	a0,0
  e0:	00000097          	auipc	ra,0x0
  e4:	2fa080e7          	jalr	762(ra) # 3da <exit>
    cat(0);
  e8:	4501                	li	a0,0
  ea:	00000097          	auipc	ra,0x0
  ee:	f16080e7          	jalr	-234(ra) # 0 <cat>
    exit(0);
  f2:	4501                	li	a0,0
  f4:	00000097          	auipc	ra,0x0
  f8:	2e6080e7          	jalr	742(ra) # 3da <exit>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
  fc:	6090                	ld	a2,0(s1)
  fe:	00001597          	auipc	a1,0x1
 102:	85258593          	addi	a1,a1,-1966 # 950 <malloc+0x120>
 106:	4509                	li	a0,2
 108:	00000097          	auipc	ra,0x0
 10c:	63a080e7          	jalr	1594(ra) # 742 <fprintf>
      exit(1);
 110:	4505                	li	a0,1
 112:	00000097          	auipc	ra,0x0
 116:	2c8080e7          	jalr	712(ra) # 3da <exit>

000000000000011a <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 11a:	1141                	addi	sp,sp,-16
 11c:	e406                	sd	ra,8(sp)
 11e:	e022                	sd	s0,0(sp)
 120:	0800                	addi	s0,sp,16
  extern int main();
  main();
 122:	00000097          	auipc	ra,0x0
 126:	f68080e7          	jalr	-152(ra) # 8a <main>
  exit(0);
 12a:	4501                	li	a0,0
 12c:	00000097          	auipc	ra,0x0
 130:	2ae080e7          	jalr	686(ra) # 3da <exit>

0000000000000134 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 134:	1141                	addi	sp,sp,-16
 136:	e422                	sd	s0,8(sp)
 138:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 13a:	87aa                	mv	a5,a0
 13c:	0585                	addi	a1,a1,1
 13e:	0785                	addi	a5,a5,1
 140:	fff5c703          	lbu	a4,-1(a1)
 144:	fee78fa3          	sb	a4,-1(a5)
 148:	fb75                	bnez	a4,13c <strcpy+0x8>
    ;
  return os;
}
 14a:	6422                	ld	s0,8(sp)
 14c:	0141                	addi	sp,sp,16
 14e:	8082                	ret

0000000000000150 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 150:	1141                	addi	sp,sp,-16
 152:	e422                	sd	s0,8(sp)
 154:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 156:	00054783          	lbu	a5,0(a0)
 15a:	cf91                	beqz	a5,176 <strcmp+0x26>
 15c:	0005c703          	lbu	a4,0(a1)
 160:	00f71b63          	bne	a4,a5,176 <strcmp+0x26>
    p++, q++;
 164:	0505                	addi	a0,a0,1
 166:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 168:	00054783          	lbu	a5,0(a0)
 16c:	c789                	beqz	a5,176 <strcmp+0x26>
 16e:	0005c703          	lbu	a4,0(a1)
 172:	fef709e3          	beq	a4,a5,164 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 176:	0005c503          	lbu	a0,0(a1)
}
 17a:	40a7853b          	subw	a0,a5,a0
 17e:	6422                	ld	s0,8(sp)
 180:	0141                	addi	sp,sp,16
 182:	8082                	ret

0000000000000184 <strlen>:

uint
strlen(const char *s)
{
 184:	1141                	addi	sp,sp,-16
 186:	e422                	sd	s0,8(sp)
 188:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 18a:	00054783          	lbu	a5,0(a0)
 18e:	cf91                	beqz	a5,1aa <strlen+0x26>
 190:	0505                	addi	a0,a0,1
 192:	87aa                	mv	a5,a0
 194:	4685                	li	a3,1
 196:	9e89                	subw	a3,a3,a0
    ;
 198:	00f6853b          	addw	a0,a3,a5
 19c:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
 19e:	fff7c703          	lbu	a4,-1(a5)
 1a2:	fb7d                	bnez	a4,198 <strlen+0x14>
  return n;
}
 1a4:	6422                	ld	s0,8(sp)
 1a6:	0141                	addi	sp,sp,16
 1a8:	8082                	ret
  for(n = 0; s[n]; n++)
 1aa:	4501                	li	a0,0
 1ac:	bfe5                	j	1a4 <strlen+0x20>

00000000000001ae <memset>:

void*
memset(void *dst, int c, uint n)
{
 1ae:	1141                	addi	sp,sp,-16
 1b0:	e422                	sd	s0,8(sp)
 1b2:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1b4:	ce09                	beqz	a2,1ce <memset+0x20>
 1b6:	87aa                	mv	a5,a0
 1b8:	fff6071b          	addiw	a4,a2,-1
 1bc:	1702                	slli	a4,a4,0x20
 1be:	9301                	srli	a4,a4,0x20
 1c0:	0705                	addi	a4,a4,1
 1c2:	972a                	add	a4,a4,a0
    cdst[i] = c;
 1c4:	00b78023          	sb	a1,0(a5)
 1c8:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 1ca:	fee79de3          	bne	a5,a4,1c4 <memset+0x16>
  }
  return dst;
}
 1ce:	6422                	ld	s0,8(sp)
 1d0:	0141                	addi	sp,sp,16
 1d2:	8082                	ret

00000000000001d4 <strchr>:

char*
strchr(const char *s, char c)
{
 1d4:	1141                	addi	sp,sp,-16
 1d6:	e422                	sd	s0,8(sp)
 1d8:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1da:	00054783          	lbu	a5,0(a0)
 1de:	cf91                	beqz	a5,1fa <strchr+0x26>
    if(*s == c)
 1e0:	00f58a63          	beq	a1,a5,1f4 <strchr+0x20>
  for(; *s; s++)
 1e4:	0505                	addi	a0,a0,1
 1e6:	00054783          	lbu	a5,0(a0)
 1ea:	c781                	beqz	a5,1f2 <strchr+0x1e>
    if(*s == c)
 1ec:	feb79ce3          	bne	a5,a1,1e4 <strchr+0x10>
 1f0:	a011                	j	1f4 <strchr+0x20>
      return (char*)s;
  return 0;
 1f2:	4501                	li	a0,0
}
 1f4:	6422                	ld	s0,8(sp)
 1f6:	0141                	addi	sp,sp,16
 1f8:	8082                	ret
  return 0;
 1fa:	4501                	li	a0,0
 1fc:	bfe5                	j	1f4 <strchr+0x20>

00000000000001fe <gets>:

char*
gets(char *buf, int max)
{
 1fe:	711d                	addi	sp,sp,-96
 200:	ec86                	sd	ra,88(sp)
 202:	e8a2                	sd	s0,80(sp)
 204:	e4a6                	sd	s1,72(sp)
 206:	e0ca                	sd	s2,64(sp)
 208:	fc4e                	sd	s3,56(sp)
 20a:	f852                	sd	s4,48(sp)
 20c:	f456                	sd	s5,40(sp)
 20e:	f05a                	sd	s6,32(sp)
 210:	ec5e                	sd	s7,24(sp)
 212:	1080                	addi	s0,sp,96
 214:	8baa                	mv	s7,a0
 216:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 218:	892a                	mv	s2,a0
 21a:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 21c:	4aa9                	li	s5,10
 21e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 220:	0019849b          	addiw	s1,s3,1
 224:	0344d863          	bge	s1,s4,254 <gets+0x56>
    cc = read(0, &c, 1);
 228:	4605                	li	a2,1
 22a:	faf40593          	addi	a1,s0,-81
 22e:	4501                	li	a0,0
 230:	00000097          	auipc	ra,0x0
 234:	1c2080e7          	jalr	450(ra) # 3f2 <read>
    if(cc < 1)
 238:	00a05e63          	blez	a0,254 <gets+0x56>
    buf[i++] = c;
 23c:	faf44783          	lbu	a5,-81(s0)
 240:	00f90023          	sb	a5,0(s2) # 1010 <buf>
    if(c == '\n' || c == '\r')
 244:	01578763          	beq	a5,s5,252 <gets+0x54>
 248:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 24a:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 24c:	fd679ae3          	bne	a5,s6,220 <gets+0x22>
 250:	a011                	j	254 <gets+0x56>
  for(i=0; i+1 < max; ){
 252:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 254:	99de                	add	s3,s3,s7
 256:	00098023          	sb	zero,0(s3)
  return buf;
}
 25a:	855e                	mv	a0,s7
 25c:	60e6                	ld	ra,88(sp)
 25e:	6446                	ld	s0,80(sp)
 260:	64a6                	ld	s1,72(sp)
 262:	6906                	ld	s2,64(sp)
 264:	79e2                	ld	s3,56(sp)
 266:	7a42                	ld	s4,48(sp)
 268:	7aa2                	ld	s5,40(sp)
 26a:	7b02                	ld	s6,32(sp)
 26c:	6be2                	ld	s7,24(sp)
 26e:	6125                	addi	sp,sp,96
 270:	8082                	ret

0000000000000272 <stat>:

int
stat(const char *n, struct stat *st)
{
 272:	1101                	addi	sp,sp,-32
 274:	ec06                	sd	ra,24(sp)
 276:	e822                	sd	s0,16(sp)
 278:	e426                	sd	s1,8(sp)
 27a:	e04a                	sd	s2,0(sp)
 27c:	1000                	addi	s0,sp,32
 27e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 280:	4581                	li	a1,0
 282:	00000097          	auipc	ra,0x0
 286:	198080e7          	jalr	408(ra) # 41a <open>
  if(fd < 0)
 28a:	02054563          	bltz	a0,2b4 <stat+0x42>
 28e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 290:	85ca                	mv	a1,s2
 292:	00000097          	auipc	ra,0x0
 296:	1a0080e7          	jalr	416(ra) # 432 <fstat>
 29a:	892a                	mv	s2,a0
  close(fd);
 29c:	8526                	mv	a0,s1
 29e:	00000097          	auipc	ra,0x0
 2a2:	164080e7          	jalr	356(ra) # 402 <close>
  return r;
}
 2a6:	854a                	mv	a0,s2
 2a8:	60e2                	ld	ra,24(sp)
 2aa:	6442                	ld	s0,16(sp)
 2ac:	64a2                	ld	s1,8(sp)
 2ae:	6902                	ld	s2,0(sp)
 2b0:	6105                	addi	sp,sp,32
 2b2:	8082                	ret
    return -1;
 2b4:	597d                	li	s2,-1
 2b6:	bfc5                	j	2a6 <stat+0x34>

00000000000002b8 <atoi>:

int
atoi(const char *s)
{
 2b8:	1141                	addi	sp,sp,-16
 2ba:	e422                	sd	s0,8(sp)
 2bc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2be:	00054683          	lbu	a3,0(a0)
 2c2:	fd06879b          	addiw	a5,a3,-48
 2c6:	0ff7f793          	andi	a5,a5,255
 2ca:	4725                	li	a4,9
 2cc:	02f76963          	bltu	a4,a5,2fe <atoi+0x46>
 2d0:	862a                	mv	a2,a0
  n = 0;
 2d2:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 2d4:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2d6:	0605                	addi	a2,a2,1
 2d8:	0025179b          	slliw	a5,a0,0x2
 2dc:	9fa9                	addw	a5,a5,a0
 2de:	0017979b          	slliw	a5,a5,0x1
 2e2:	9fb5                	addw	a5,a5,a3
 2e4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2e8:	00064683          	lbu	a3,0(a2)
 2ec:	fd06871b          	addiw	a4,a3,-48
 2f0:	0ff77713          	andi	a4,a4,255
 2f4:	fee5f1e3          	bgeu	a1,a4,2d6 <atoi+0x1e>
  return n;
}
 2f8:	6422                	ld	s0,8(sp)
 2fa:	0141                	addi	sp,sp,16
 2fc:	8082                	ret
  n = 0;
 2fe:	4501                	li	a0,0
 300:	bfe5                	j	2f8 <atoi+0x40>

0000000000000302 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 302:	1141                	addi	sp,sp,-16
 304:	e422                	sd	s0,8(sp)
 306:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 308:	02b57663          	bgeu	a0,a1,334 <memmove+0x32>
    while(n-- > 0)
 30c:	02c05163          	blez	a2,32e <memmove+0x2c>
 310:	fff6079b          	addiw	a5,a2,-1
 314:	1782                	slli	a5,a5,0x20
 316:	9381                	srli	a5,a5,0x20
 318:	0785                	addi	a5,a5,1
 31a:	97aa                	add	a5,a5,a0
  dst = vdst;
 31c:	872a                	mv	a4,a0
      *dst++ = *src++;
 31e:	0585                	addi	a1,a1,1
 320:	0705                	addi	a4,a4,1
 322:	fff5c683          	lbu	a3,-1(a1)
 326:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 32a:	fee79ae3          	bne	a5,a4,31e <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 32e:	6422                	ld	s0,8(sp)
 330:	0141                	addi	sp,sp,16
 332:	8082                	ret
    dst += n;
 334:	00c50733          	add	a4,a0,a2
    src += n;
 338:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 33a:	fec05ae3          	blez	a2,32e <memmove+0x2c>
 33e:	fff6079b          	addiw	a5,a2,-1
 342:	1782                	slli	a5,a5,0x20
 344:	9381                	srli	a5,a5,0x20
 346:	fff7c793          	not	a5,a5
 34a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 34c:	15fd                	addi	a1,a1,-1
 34e:	177d                	addi	a4,a4,-1
 350:	0005c683          	lbu	a3,0(a1)
 354:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 358:	fef71ae3          	bne	a4,a5,34c <memmove+0x4a>
 35c:	bfc9                	j	32e <memmove+0x2c>

000000000000035e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 35e:	1141                	addi	sp,sp,-16
 360:	e422                	sd	s0,8(sp)
 362:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 364:	ce15                	beqz	a2,3a0 <memcmp+0x42>
 366:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 36a:	00054783          	lbu	a5,0(a0)
 36e:	0005c703          	lbu	a4,0(a1)
 372:	02e79063          	bne	a5,a4,392 <memcmp+0x34>
 376:	1682                	slli	a3,a3,0x20
 378:	9281                	srli	a3,a3,0x20
 37a:	0685                	addi	a3,a3,1
 37c:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 37e:	0505                	addi	a0,a0,1
    p2++;
 380:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 382:	00d50d63          	beq	a0,a3,39c <memcmp+0x3e>
    if (*p1 != *p2) {
 386:	00054783          	lbu	a5,0(a0)
 38a:	0005c703          	lbu	a4,0(a1)
 38e:	fee788e3          	beq	a5,a4,37e <memcmp+0x20>
      return *p1 - *p2;
 392:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 396:	6422                	ld	s0,8(sp)
 398:	0141                	addi	sp,sp,16
 39a:	8082                	ret
  return 0;
 39c:	4501                	li	a0,0
 39e:	bfe5                	j	396 <memcmp+0x38>
 3a0:	4501                	li	a0,0
 3a2:	bfd5                	j	396 <memcmp+0x38>

00000000000003a4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3a4:	1141                	addi	sp,sp,-16
 3a6:	e406                	sd	ra,8(sp)
 3a8:	e022                	sd	s0,0(sp)
 3aa:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3ac:	00000097          	auipc	ra,0x0
 3b0:	f56080e7          	jalr	-170(ra) # 302 <memmove>
}
 3b4:	60a2                	ld	ra,8(sp)
 3b6:	6402                	ld	s0,0(sp)
 3b8:	0141                	addi	sp,sp,16
 3ba:	8082                	ret

00000000000003bc <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 3bc:	1141                	addi	sp,sp,-16
 3be:	e422                	sd	s0,8(sp)
 3c0:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 3c2:	040007b7          	lui	a5,0x4000
}
 3c6:	17f5                	addi	a5,a5,-3
 3c8:	07b2                	slli	a5,a5,0xc
 3ca:	4388                	lw	a0,0(a5)
 3cc:	6422                	ld	s0,8(sp)
 3ce:	0141                	addi	sp,sp,16
 3d0:	8082                	ret

00000000000003d2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3d2:	4885                	li	a7,1
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <exit>:
.global exit
exit:
 li a7, SYS_exit
 3da:	4889                	li	a7,2
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3e2:	488d                	li	a7,3
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3ea:	4891                	li	a7,4
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <read>:
.global read
read:
 li a7, SYS_read
 3f2:	4895                	li	a7,5
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <write>:
.global write
write:
 li a7, SYS_write
 3fa:	48c1                	li	a7,16
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <close>:
.global close
close:
 li a7, SYS_close
 402:	48d5                	li	a7,21
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <kill>:
.global kill
kill:
 li a7, SYS_kill
 40a:	4899                	li	a7,6
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <exec>:
.global exec
exec:
 li a7, SYS_exec
 412:	489d                	li	a7,7
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <open>:
.global open
open:
 li a7, SYS_open
 41a:	48bd                	li	a7,15
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 422:	48c5                	li	a7,17
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 42a:	48c9                	li	a7,18
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 432:	48a1                	li	a7,8
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <link>:
.global link
link:
 li a7, SYS_link
 43a:	48cd                	li	a7,19
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 442:	48d1                	li	a7,20
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 44a:	48a5                	li	a7,9
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <dup>:
.global dup
dup:
 li a7, SYS_dup
 452:	48a9                	li	a7,10
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 45a:	48ad                	li	a7,11
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 462:	48b1                	li	a7,12
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 46a:	48b5                	li	a7,13
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 472:	48b9                	li	a7,14
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <trace>:
.global trace
trace:
 li a7, SYS_trace
 47a:	48d9                	li	a7,22
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 482:	48dd                	li	a7,23
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <connect>:
.global connect
connect:
 li a7, SYS_connect
 48a:	48f5                	li	a7,29
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 492:	48f9                	li	a7,30
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 49a:	1101                	addi	sp,sp,-32
 49c:	ec06                	sd	ra,24(sp)
 49e:	e822                	sd	s0,16(sp)
 4a0:	1000                	addi	s0,sp,32
 4a2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4a6:	4605                	li	a2,1
 4a8:	fef40593          	addi	a1,s0,-17
 4ac:	00000097          	auipc	ra,0x0
 4b0:	f4e080e7          	jalr	-178(ra) # 3fa <write>
}
 4b4:	60e2                	ld	ra,24(sp)
 4b6:	6442                	ld	s0,16(sp)
 4b8:	6105                	addi	sp,sp,32
 4ba:	8082                	ret

00000000000004bc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4bc:	7139                	addi	sp,sp,-64
 4be:	fc06                	sd	ra,56(sp)
 4c0:	f822                	sd	s0,48(sp)
 4c2:	f426                	sd	s1,40(sp)
 4c4:	f04a                	sd	s2,32(sp)
 4c6:	ec4e                	sd	s3,24(sp)
 4c8:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4ca:	c299                	beqz	a3,4d0 <printint+0x14>
 4cc:	0005cd63          	bltz	a1,4e6 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4d0:	2581                	sext.w	a1,a1
  neg = 0;
 4d2:	4301                	li	t1,0
 4d4:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 4d8:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 4da:	2601                	sext.w	a2,a2
 4dc:	00000897          	auipc	a7,0x0
 4e0:	48c88893          	addi	a7,a7,1164 # 968 <digits>
 4e4:	a039                	j	4f2 <printint+0x36>
    x = -xx;
 4e6:	40b005bb          	negw	a1,a1
    neg = 1;
 4ea:	4305                	li	t1,1
    x = -xx;
 4ec:	b7e5                	j	4d4 <printint+0x18>
  }while((x /= base) != 0);
 4ee:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 4f0:	8836                	mv	a6,a3
 4f2:	0018069b          	addiw	a3,a6,1
 4f6:	02c5f7bb          	remuw	a5,a1,a2
 4fa:	1782                	slli	a5,a5,0x20
 4fc:	9381                	srli	a5,a5,0x20
 4fe:	97c6                	add	a5,a5,a7
 500:	0007c783          	lbu	a5,0(a5) # 4000000 <base+0x3ffedf0>
 504:	00f70023          	sb	a5,0(a4)
 508:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 50a:	02c5d7bb          	divuw	a5,a1,a2
 50e:	fec5f0e3          	bgeu	a1,a2,4ee <printint+0x32>
  if(neg)
 512:	00030b63          	beqz	t1,528 <printint+0x6c>
    buf[i++] = '-';
 516:	fd040793          	addi	a5,s0,-48
 51a:	96be                	add	a3,a3,a5
 51c:	02d00793          	li	a5,45
 520:	fef68823          	sb	a5,-16(a3)
 524:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 528:	02d05963          	blez	a3,55a <printint+0x9e>
 52c:	89aa                	mv	s3,a0
 52e:	fc040793          	addi	a5,s0,-64
 532:	00d784b3          	add	s1,a5,a3
 536:	fff78913          	addi	s2,a5,-1
 53a:	9936                	add	s2,s2,a3
 53c:	36fd                	addiw	a3,a3,-1
 53e:	1682                	slli	a3,a3,0x20
 540:	9281                	srli	a3,a3,0x20
 542:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 546:	fff4c583          	lbu	a1,-1(s1)
 54a:	854e                	mv	a0,s3
 54c:	00000097          	auipc	ra,0x0
 550:	f4e080e7          	jalr	-178(ra) # 49a <putc>
 554:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 556:	ff2498e3          	bne	s1,s2,546 <printint+0x8a>
}
 55a:	70e2                	ld	ra,56(sp)
 55c:	7442                	ld	s0,48(sp)
 55e:	74a2                	ld	s1,40(sp)
 560:	7902                	ld	s2,32(sp)
 562:	69e2                	ld	s3,24(sp)
 564:	6121                	addi	sp,sp,64
 566:	8082                	ret

0000000000000568 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 568:	7119                	addi	sp,sp,-128
 56a:	fc86                	sd	ra,120(sp)
 56c:	f8a2                	sd	s0,112(sp)
 56e:	f4a6                	sd	s1,104(sp)
 570:	f0ca                	sd	s2,96(sp)
 572:	ecce                	sd	s3,88(sp)
 574:	e8d2                	sd	s4,80(sp)
 576:	e4d6                	sd	s5,72(sp)
 578:	e0da                	sd	s6,64(sp)
 57a:	fc5e                	sd	s7,56(sp)
 57c:	f862                	sd	s8,48(sp)
 57e:	f466                	sd	s9,40(sp)
 580:	f06a                	sd	s10,32(sp)
 582:	ec6e                	sd	s11,24(sp)
 584:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 586:	0005c483          	lbu	s1,0(a1)
 58a:	18048d63          	beqz	s1,724 <vprintf+0x1bc>
 58e:	8aaa                	mv	s5,a0
 590:	8b32                	mv	s6,a2
 592:	00158913          	addi	s2,a1,1
  state = 0;
 596:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 598:	02500a13          	li	s4,37
      if(c == 'd'){
 59c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 5a0:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 5a4:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 5a8:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5ac:	00000b97          	auipc	s7,0x0
 5b0:	3bcb8b93          	addi	s7,s7,956 # 968 <digits>
 5b4:	a839                	j	5d2 <vprintf+0x6a>
        putc(fd, c);
 5b6:	85a6                	mv	a1,s1
 5b8:	8556                	mv	a0,s5
 5ba:	00000097          	auipc	ra,0x0
 5be:	ee0080e7          	jalr	-288(ra) # 49a <putc>
 5c2:	a019                	j	5c8 <vprintf+0x60>
    } else if(state == '%'){
 5c4:	01498f63          	beq	s3,s4,5e2 <vprintf+0x7a>
 5c8:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 5ca:	fff94483          	lbu	s1,-1(s2)
 5ce:	14048b63          	beqz	s1,724 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 5d2:	0004879b          	sext.w	a5,s1
    if(state == 0){
 5d6:	fe0997e3          	bnez	s3,5c4 <vprintf+0x5c>
      if(c == '%'){
 5da:	fd479ee3          	bne	a5,s4,5b6 <vprintf+0x4e>
        state = '%';
 5de:	89be                	mv	s3,a5
 5e0:	b7e5                	j	5c8 <vprintf+0x60>
      if(c == 'd'){
 5e2:	05878063          	beq	a5,s8,622 <vprintf+0xba>
      } else if(c == 'l') {
 5e6:	05978c63          	beq	a5,s9,63e <vprintf+0xd6>
      } else if(c == 'x') {
 5ea:	07a78863          	beq	a5,s10,65a <vprintf+0xf2>
      } else if(c == 'p') {
 5ee:	09b78463          	beq	a5,s11,676 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 5f2:	07300713          	li	a4,115
 5f6:	0ce78563          	beq	a5,a4,6c0 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5fa:	06300713          	li	a4,99
 5fe:	0ee78c63          	beq	a5,a4,6f6 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 602:	11478663          	beq	a5,s4,70e <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 606:	85d2                	mv	a1,s4
 608:	8556                	mv	a0,s5
 60a:	00000097          	auipc	ra,0x0
 60e:	e90080e7          	jalr	-368(ra) # 49a <putc>
        putc(fd, c);
 612:	85a6                	mv	a1,s1
 614:	8556                	mv	a0,s5
 616:	00000097          	auipc	ra,0x0
 61a:	e84080e7          	jalr	-380(ra) # 49a <putc>
      }
      state = 0;
 61e:	4981                	li	s3,0
 620:	b765                	j	5c8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 622:	008b0493          	addi	s1,s6,8
 626:	4685                	li	a3,1
 628:	4629                	li	a2,10
 62a:	000b2583          	lw	a1,0(s6)
 62e:	8556                	mv	a0,s5
 630:	00000097          	auipc	ra,0x0
 634:	e8c080e7          	jalr	-372(ra) # 4bc <printint>
 638:	8b26                	mv	s6,s1
      state = 0;
 63a:	4981                	li	s3,0
 63c:	b771                	j	5c8 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 63e:	008b0493          	addi	s1,s6,8
 642:	4681                	li	a3,0
 644:	4629                	li	a2,10
 646:	000b2583          	lw	a1,0(s6)
 64a:	8556                	mv	a0,s5
 64c:	00000097          	auipc	ra,0x0
 650:	e70080e7          	jalr	-400(ra) # 4bc <printint>
 654:	8b26                	mv	s6,s1
      state = 0;
 656:	4981                	li	s3,0
 658:	bf85                	j	5c8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 65a:	008b0493          	addi	s1,s6,8
 65e:	4681                	li	a3,0
 660:	4641                	li	a2,16
 662:	000b2583          	lw	a1,0(s6)
 666:	8556                	mv	a0,s5
 668:	00000097          	auipc	ra,0x0
 66c:	e54080e7          	jalr	-428(ra) # 4bc <printint>
 670:	8b26                	mv	s6,s1
      state = 0;
 672:	4981                	li	s3,0
 674:	bf91                	j	5c8 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 676:	008b0793          	addi	a5,s6,8
 67a:	f8f43423          	sd	a5,-120(s0)
 67e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 682:	03000593          	li	a1,48
 686:	8556                	mv	a0,s5
 688:	00000097          	auipc	ra,0x0
 68c:	e12080e7          	jalr	-494(ra) # 49a <putc>
  putc(fd, 'x');
 690:	85ea                	mv	a1,s10
 692:	8556                	mv	a0,s5
 694:	00000097          	auipc	ra,0x0
 698:	e06080e7          	jalr	-506(ra) # 49a <putc>
 69c:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 69e:	03c9d793          	srli	a5,s3,0x3c
 6a2:	97de                	add	a5,a5,s7
 6a4:	0007c583          	lbu	a1,0(a5)
 6a8:	8556                	mv	a0,s5
 6aa:	00000097          	auipc	ra,0x0
 6ae:	df0080e7          	jalr	-528(ra) # 49a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6b2:	0992                	slli	s3,s3,0x4
 6b4:	34fd                	addiw	s1,s1,-1
 6b6:	f4e5                	bnez	s1,69e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 6b8:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6bc:	4981                	li	s3,0
 6be:	b729                	j	5c8 <vprintf+0x60>
        s = va_arg(ap, char*);
 6c0:	008b0993          	addi	s3,s6,8
 6c4:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 6c8:	c085                	beqz	s1,6e8 <vprintf+0x180>
        while(*s != 0){
 6ca:	0004c583          	lbu	a1,0(s1)
 6ce:	c9a1                	beqz	a1,71e <vprintf+0x1b6>
          putc(fd, *s);
 6d0:	8556                	mv	a0,s5
 6d2:	00000097          	auipc	ra,0x0
 6d6:	dc8080e7          	jalr	-568(ra) # 49a <putc>
          s++;
 6da:	0485                	addi	s1,s1,1
        while(*s != 0){
 6dc:	0004c583          	lbu	a1,0(s1)
 6e0:	f9e5                	bnez	a1,6d0 <vprintf+0x168>
        s = va_arg(ap, char*);
 6e2:	8b4e                	mv	s6,s3
      state = 0;
 6e4:	4981                	li	s3,0
 6e6:	b5cd                	j	5c8 <vprintf+0x60>
          s = "(null)";
 6e8:	00000497          	auipc	s1,0x0
 6ec:	29848493          	addi	s1,s1,664 # 980 <digits+0x18>
        while(*s != 0){
 6f0:	02800593          	li	a1,40
 6f4:	bff1                	j	6d0 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 6f6:	008b0493          	addi	s1,s6,8
 6fa:	000b4583          	lbu	a1,0(s6)
 6fe:	8556                	mv	a0,s5
 700:	00000097          	auipc	ra,0x0
 704:	d9a080e7          	jalr	-614(ra) # 49a <putc>
 708:	8b26                	mv	s6,s1
      state = 0;
 70a:	4981                	li	s3,0
 70c:	bd75                	j	5c8 <vprintf+0x60>
        putc(fd, c);
 70e:	85d2                	mv	a1,s4
 710:	8556                	mv	a0,s5
 712:	00000097          	auipc	ra,0x0
 716:	d88080e7          	jalr	-632(ra) # 49a <putc>
      state = 0;
 71a:	4981                	li	s3,0
 71c:	b575                	j	5c8 <vprintf+0x60>
        s = va_arg(ap, char*);
 71e:	8b4e                	mv	s6,s3
      state = 0;
 720:	4981                	li	s3,0
 722:	b55d                	j	5c8 <vprintf+0x60>
    }
  }
}
 724:	70e6                	ld	ra,120(sp)
 726:	7446                	ld	s0,112(sp)
 728:	74a6                	ld	s1,104(sp)
 72a:	7906                	ld	s2,96(sp)
 72c:	69e6                	ld	s3,88(sp)
 72e:	6a46                	ld	s4,80(sp)
 730:	6aa6                	ld	s5,72(sp)
 732:	6b06                	ld	s6,64(sp)
 734:	7be2                	ld	s7,56(sp)
 736:	7c42                	ld	s8,48(sp)
 738:	7ca2                	ld	s9,40(sp)
 73a:	7d02                	ld	s10,32(sp)
 73c:	6de2                	ld	s11,24(sp)
 73e:	6109                	addi	sp,sp,128
 740:	8082                	ret

0000000000000742 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 742:	715d                	addi	sp,sp,-80
 744:	ec06                	sd	ra,24(sp)
 746:	e822                	sd	s0,16(sp)
 748:	1000                	addi	s0,sp,32
 74a:	e010                	sd	a2,0(s0)
 74c:	e414                	sd	a3,8(s0)
 74e:	e818                	sd	a4,16(s0)
 750:	ec1c                	sd	a5,24(s0)
 752:	03043023          	sd	a6,32(s0)
 756:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 75a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 75e:	8622                	mv	a2,s0
 760:	00000097          	auipc	ra,0x0
 764:	e08080e7          	jalr	-504(ra) # 568 <vprintf>
}
 768:	60e2                	ld	ra,24(sp)
 76a:	6442                	ld	s0,16(sp)
 76c:	6161                	addi	sp,sp,80
 76e:	8082                	ret

0000000000000770 <printf>:

void
printf(const char *fmt, ...)
{
 770:	711d                	addi	sp,sp,-96
 772:	ec06                	sd	ra,24(sp)
 774:	e822                	sd	s0,16(sp)
 776:	1000                	addi	s0,sp,32
 778:	e40c                	sd	a1,8(s0)
 77a:	e810                	sd	a2,16(s0)
 77c:	ec14                	sd	a3,24(s0)
 77e:	f018                	sd	a4,32(s0)
 780:	f41c                	sd	a5,40(s0)
 782:	03043823          	sd	a6,48(s0)
 786:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 78a:	00840613          	addi	a2,s0,8
 78e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 792:	85aa                	mv	a1,a0
 794:	4505                	li	a0,1
 796:	00000097          	auipc	ra,0x0
 79a:	dd2080e7          	jalr	-558(ra) # 568 <vprintf>
}
 79e:	60e2                	ld	ra,24(sp)
 7a0:	6442                	ld	s0,16(sp)
 7a2:	6125                	addi	sp,sp,96
 7a4:	8082                	ret

00000000000007a6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a6:	1141                	addi	sp,sp,-16
 7a8:	e422                	sd	s0,8(sp)
 7aa:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7ac:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b0:	00001797          	auipc	a5,0x1
 7b4:	85078793          	addi	a5,a5,-1968 # 1000 <freep>
 7b8:	639c                	ld	a5,0(a5)
 7ba:	a805                	j	7ea <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7bc:	4618                	lw	a4,8(a2)
 7be:	9db9                	addw	a1,a1,a4
 7c0:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7c4:	6398                	ld	a4,0(a5)
 7c6:	6318                	ld	a4,0(a4)
 7c8:	fee53823          	sd	a4,-16(a0)
 7cc:	a091                	j	810 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7ce:	ff852703          	lw	a4,-8(a0)
 7d2:	9e39                	addw	a2,a2,a4
 7d4:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 7d6:	ff053703          	ld	a4,-16(a0)
 7da:	e398                	sd	a4,0(a5)
 7dc:	a099                	j	822 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7de:	6398                	ld	a4,0(a5)
 7e0:	00e7e463          	bltu	a5,a4,7e8 <free+0x42>
 7e4:	00e6ea63          	bltu	a3,a4,7f8 <free+0x52>
{
 7e8:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ea:	fed7fae3          	bgeu	a5,a3,7de <free+0x38>
 7ee:	6398                	ld	a4,0(a5)
 7f0:	00e6e463          	bltu	a3,a4,7f8 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7f4:	fee7eae3          	bltu	a5,a4,7e8 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 7f8:	ff852583          	lw	a1,-8(a0)
 7fc:	6390                	ld	a2,0(a5)
 7fe:	02059713          	slli	a4,a1,0x20
 802:	9301                	srli	a4,a4,0x20
 804:	0712                	slli	a4,a4,0x4
 806:	9736                	add	a4,a4,a3
 808:	fae60ae3          	beq	a2,a4,7bc <free+0x16>
    bp->s.ptr = p->s.ptr;
 80c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 810:	4790                	lw	a2,8(a5)
 812:	02061713          	slli	a4,a2,0x20
 816:	9301                	srli	a4,a4,0x20
 818:	0712                	slli	a4,a4,0x4
 81a:	973e                	add	a4,a4,a5
 81c:	fae689e3          	beq	a3,a4,7ce <free+0x28>
  } else
    p->s.ptr = bp;
 820:	e394                	sd	a3,0(a5)
  freep = p;
 822:	00000717          	auipc	a4,0x0
 826:	7cf73f23          	sd	a5,2014(a4) # 1000 <freep>
}
 82a:	6422                	ld	s0,8(sp)
 82c:	0141                	addi	sp,sp,16
 82e:	8082                	ret

0000000000000830 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 830:	7139                	addi	sp,sp,-64
 832:	fc06                	sd	ra,56(sp)
 834:	f822                	sd	s0,48(sp)
 836:	f426                	sd	s1,40(sp)
 838:	f04a                	sd	s2,32(sp)
 83a:	ec4e                	sd	s3,24(sp)
 83c:	e852                	sd	s4,16(sp)
 83e:	e456                	sd	s5,8(sp)
 840:	e05a                	sd	s6,0(sp)
 842:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 844:	02051993          	slli	s3,a0,0x20
 848:	0209d993          	srli	s3,s3,0x20
 84c:	09bd                	addi	s3,s3,15
 84e:	0049d993          	srli	s3,s3,0x4
 852:	2985                	addiw	s3,s3,1
 854:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 858:	00000797          	auipc	a5,0x0
 85c:	7a878793          	addi	a5,a5,1960 # 1000 <freep>
 860:	6388                	ld	a0,0(a5)
 862:	c515                	beqz	a0,88e <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 864:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 866:	4798                	lw	a4,8(a5)
 868:	03277f63          	bgeu	a4,s2,8a6 <malloc+0x76>
 86c:	8a4e                	mv	s4,s3
 86e:	0009871b          	sext.w	a4,s3
 872:	6685                	lui	a3,0x1
 874:	00d77363          	bgeu	a4,a3,87a <malloc+0x4a>
 878:	6a05                	lui	s4,0x1
 87a:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 87e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 882:	00000497          	auipc	s1,0x0
 886:	77e48493          	addi	s1,s1,1918 # 1000 <freep>
  if(p == (char*)-1)
 88a:	5b7d                	li	s6,-1
 88c:	a885                	j	8fc <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 88e:	00001797          	auipc	a5,0x1
 892:	98278793          	addi	a5,a5,-1662 # 1210 <base>
 896:	00000717          	auipc	a4,0x0
 89a:	76f73523          	sd	a5,1898(a4) # 1000 <freep>
 89e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8a0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8a4:	b7e1                	j	86c <malloc+0x3c>
      if(p->s.size == nunits)
 8a6:	02e90b63          	beq	s2,a4,8dc <malloc+0xac>
        p->s.size -= nunits;
 8aa:	4137073b          	subw	a4,a4,s3
 8ae:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8b0:	1702                	slli	a4,a4,0x20
 8b2:	9301                	srli	a4,a4,0x20
 8b4:	0712                	slli	a4,a4,0x4
 8b6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8b8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8bc:	00000717          	auipc	a4,0x0
 8c0:	74a73223          	sd	a0,1860(a4) # 1000 <freep>
      return (void*)(p + 1);
 8c4:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8c8:	70e2                	ld	ra,56(sp)
 8ca:	7442                	ld	s0,48(sp)
 8cc:	74a2                	ld	s1,40(sp)
 8ce:	7902                	ld	s2,32(sp)
 8d0:	69e2                	ld	s3,24(sp)
 8d2:	6a42                	ld	s4,16(sp)
 8d4:	6aa2                	ld	s5,8(sp)
 8d6:	6b02                	ld	s6,0(sp)
 8d8:	6121                	addi	sp,sp,64
 8da:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8dc:	6398                	ld	a4,0(a5)
 8de:	e118                	sd	a4,0(a0)
 8e0:	bff1                	j	8bc <malloc+0x8c>
  hp->s.size = nu;
 8e2:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 8e6:	0541                	addi	a0,a0,16
 8e8:	00000097          	auipc	ra,0x0
 8ec:	ebe080e7          	jalr	-322(ra) # 7a6 <free>
  return freep;
 8f0:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 8f2:	d979                	beqz	a0,8c8 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8f6:	4798                	lw	a4,8(a5)
 8f8:	fb2777e3          	bgeu	a4,s2,8a6 <malloc+0x76>
    if(p == freep)
 8fc:	6098                	ld	a4,0(s1)
 8fe:	853e                	mv	a0,a5
 900:	fef71ae3          	bne	a4,a5,8f4 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 904:	8552                	mv	a0,s4
 906:	00000097          	auipc	ra,0x0
 90a:	b5c080e7          	jalr	-1188(ra) # 462 <sbrk>
  if(p == (char*)-1)
 90e:	fd651ae3          	bne	a0,s6,8e2 <malloc+0xb2>
        return 0;
 912:	4501                	li	a0,0
 914:	bf55                	j	8c8 <malloc+0x98>
