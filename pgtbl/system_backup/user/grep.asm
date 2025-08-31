
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  16:	02e00a13          	li	s4,46
    if(matchhere(re, text))
  1a:	85a6                	mv	a1,s1
  1c:	854e                	mv	a0,s3
  1e:	00000097          	auipc	ra,0x0
  22:	030080e7          	jalr	48(ra) # 4e <matchhere>
  26:	e919                	bnez	a0,3c <matchstar+0x3c>
  }while(*text!='\0' && (*text++==c || c=='.'));
  28:	0004c783          	lbu	a5,0(s1)
  2c:	cb89                	beqz	a5,3e <matchstar+0x3e>
  2e:	0485                	addi	s1,s1,1
  30:	2781                	sext.w	a5,a5
  32:	ff2784e3          	beq	a5,s2,1a <matchstar+0x1a>
  36:	ff4902e3          	beq	s2,s4,1a <matchstar+0x1a>
  3a:	a011                	j	3e <matchstar+0x3e>
      return 1;
  3c:	4505                	li	a0,1
  return 0;
}
  3e:	70a2                	ld	ra,40(sp)
  40:	7402                	ld	s0,32(sp)
  42:	64e2                	ld	s1,24(sp)
  44:	6942                	ld	s2,16(sp)
  46:	69a2                	ld	s3,8(sp)
  48:	6a02                	ld	s4,0(sp)
  4a:	6145                	addi	sp,sp,48
  4c:	8082                	ret

000000000000004e <matchhere>:
  if(re[0] == '\0')
  4e:	00054703          	lbu	a4,0(a0)
  52:	cb3d                	beqz	a4,c8 <matchhere+0x7a>
{
  54:	1141                	addi	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	addi	s0,sp,16
  5c:	87aa                	mv	a5,a0
  if(re[1] == '*')
  5e:	00154683          	lbu	a3,1(a0)
  62:	02a00613          	li	a2,42
  66:	02c68563          	beq	a3,a2,90 <matchhere+0x42>
  if(re[0] == '$' && re[1] == '\0')
  6a:	02400613          	li	a2,36
  6e:	02c70a63          	beq	a4,a2,a2 <matchhere+0x54>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  72:	0005c683          	lbu	a3,0(a1)
  return 0;
  76:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  78:	ca81                	beqz	a3,88 <matchhere+0x3a>
  7a:	02e00613          	li	a2,46
  7e:	02c70d63          	beq	a4,a2,b8 <matchhere+0x6a>
  return 0;
  82:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  84:	02d70a63          	beq	a4,a3,b8 <matchhere+0x6a>
}
  88:	60a2                	ld	ra,8(sp)
  8a:	6402                	ld	s0,0(sp)
  8c:	0141                	addi	sp,sp,16
  8e:	8082                	ret
    return matchstar(re[0], re+2, text);
  90:	862e                	mv	a2,a1
  92:	00250593          	addi	a1,a0,2
  96:	853a                	mv	a0,a4
  98:	00000097          	auipc	ra,0x0
  9c:	f68080e7          	jalr	-152(ra) # 0 <matchstar>
  a0:	b7e5                	j	88 <matchhere+0x3a>
  if(re[0] == '$' && re[1] == '\0')
  a2:	c691                	beqz	a3,ae <matchhere+0x60>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  a4:	0005c683          	lbu	a3,0(a1)
  a8:	fee9                	bnez	a3,82 <matchhere+0x34>
  return 0;
  aa:	4501                	li	a0,0
  ac:	bff1                	j	88 <matchhere+0x3a>
    return *text == '\0';
  ae:	0005c503          	lbu	a0,0(a1)
  b2:	00153513          	seqz	a0,a0
  b6:	bfc9                	j	88 <matchhere+0x3a>
    return matchhere(re+1, text+1);
  b8:	0585                	addi	a1,a1,1
  ba:	00178513          	addi	a0,a5,1
  be:	00000097          	auipc	ra,0x0
  c2:	f90080e7          	jalr	-112(ra) # 4e <matchhere>
  c6:	b7c9                	j	88 <matchhere+0x3a>
    return 1;
  c8:	4505                	li	a0,1
}
  ca:	8082                	ret

00000000000000cc <match>:
{
  cc:	1101                	addi	sp,sp,-32
  ce:	ec06                	sd	ra,24(sp)
  d0:	e822                	sd	s0,16(sp)
  d2:	e426                	sd	s1,8(sp)
  d4:	e04a                	sd	s2,0(sp)
  d6:	1000                	addi	s0,sp,32
  d8:	892a                	mv	s2,a0
  da:	84ae                	mv	s1,a1
  if(re[0] == '^')
  dc:	00054703          	lbu	a4,0(a0)
  e0:	05e00793          	li	a5,94
  e4:	00f70e63          	beq	a4,a5,100 <match+0x34>
    if(matchhere(re, text))
  e8:	85a6                	mv	a1,s1
  ea:	854a                	mv	a0,s2
  ec:	00000097          	auipc	ra,0x0
  f0:	f62080e7          	jalr	-158(ra) # 4e <matchhere>
  f4:	ed01                	bnez	a0,10c <match+0x40>
  }while(*text++ != '\0');
  f6:	0485                	addi	s1,s1,1
  f8:	fff4c783          	lbu	a5,-1(s1)
  fc:	f7f5                	bnez	a5,e8 <match+0x1c>
  fe:	a801                	j	10e <match+0x42>
    return matchhere(re+1, text);
 100:	0505                	addi	a0,a0,1
 102:	00000097          	auipc	ra,0x0
 106:	f4c080e7          	jalr	-180(ra) # 4e <matchhere>
 10a:	a011                	j	10e <match+0x42>
      return 1;
 10c:	4505                	li	a0,1
}
 10e:	60e2                	ld	ra,24(sp)
 110:	6442                	ld	s0,16(sp)
 112:	64a2                	ld	s1,8(sp)
 114:	6902                	ld	s2,0(sp)
 116:	6105                	addi	sp,sp,32
 118:	8082                	ret

000000000000011a <grep>:
{
 11a:	711d                	addi	sp,sp,-96
 11c:	ec86                	sd	ra,88(sp)
 11e:	e8a2                	sd	s0,80(sp)
 120:	e4a6                	sd	s1,72(sp)
 122:	e0ca                	sd	s2,64(sp)
 124:	fc4e                	sd	s3,56(sp)
 126:	f852                	sd	s4,48(sp)
 128:	f456                	sd	s5,40(sp)
 12a:	f05a                	sd	s6,32(sp)
 12c:	ec5e                	sd	s7,24(sp)
 12e:	e862                	sd	s8,16(sp)
 130:	e466                	sd	s9,8(sp)
 132:	1080                	addi	s0,sp,96
 134:	89aa                	mv	s3,a0
 136:	8bae                	mv	s7,a1
  m = 0;
 138:	4a01                	li	s4,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 13a:	3ff00b13          	li	s6,1023
 13e:	00001a97          	auipc	s5,0x1
 142:	ed2a8a93          	addi	s5,s5,-302 # 1010 <buf>
    p = buf;
 146:	8cd6                	mv	s9,s5
 148:	8c56                	mv	s8,s5
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 14a:	a0a1                	j	192 <grep+0x78>
        *q = '\n';
 14c:	47a9                	li	a5,10
 14e:	00f48023          	sb	a5,0(s1)
        write(1, p, q+1 - p);
 152:	00148613          	addi	a2,s1,1
 156:	4126063b          	subw	a2,a2,s2
 15a:	85ca                	mv	a1,s2
 15c:	4505                	li	a0,1
 15e:	00000097          	auipc	ra,0x0
 162:	428080e7          	jalr	1064(ra) # 586 <write>
      p = q+1;
 166:	00148913          	addi	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 16a:	45a9                	li	a1,10
 16c:	854a                	mv	a0,s2
 16e:	00000097          	auipc	ra,0x0
 172:	1f2080e7          	jalr	498(ra) # 360 <strchr>
 176:	84aa                	mv	s1,a0
 178:	c919                	beqz	a0,18e <grep+0x74>
      *q = 0;
 17a:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
 17e:	85ca                	mv	a1,s2
 180:	854e                	mv	a0,s3
 182:	00000097          	auipc	ra,0x0
 186:	f4a080e7          	jalr	-182(ra) # cc <match>
 18a:	dd71                	beqz	a0,166 <grep+0x4c>
 18c:	b7c1                	j	14c <grep+0x32>
    if(m > 0){
 18e:	03404563          	bgtz	s4,1b8 <grep+0x9e>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 192:	414b063b          	subw	a2,s6,s4
 196:	014a85b3          	add	a1,s5,s4
 19a:	855e                	mv	a0,s7
 19c:	00000097          	auipc	ra,0x0
 1a0:	3e2080e7          	jalr	994(ra) # 57e <read>
 1a4:	02a05663          	blez	a0,1d0 <grep+0xb6>
    m += n;
 1a8:	00aa0a3b          	addw	s4,s4,a0
    buf[m] = '\0';
 1ac:	014a87b3          	add	a5,s5,s4
 1b0:	00078023          	sb	zero,0(a5)
    p = buf;
 1b4:	8962                	mv	s2,s8
    while((q = strchr(p, '\n')) != 0){
 1b6:	bf55                	j	16a <grep+0x50>
      m -= p - buf;
 1b8:	415907b3          	sub	a5,s2,s5
 1bc:	40fa0a3b          	subw	s4,s4,a5
      memmove(buf, p, m);
 1c0:	8652                	mv	a2,s4
 1c2:	85ca                	mv	a1,s2
 1c4:	8566                	mv	a0,s9
 1c6:	00000097          	auipc	ra,0x0
 1ca:	2c8080e7          	jalr	712(ra) # 48e <memmove>
 1ce:	b7d1                	j	192 <grep+0x78>
}
 1d0:	60e6                	ld	ra,88(sp)
 1d2:	6446                	ld	s0,80(sp)
 1d4:	64a6                	ld	s1,72(sp)
 1d6:	6906                	ld	s2,64(sp)
 1d8:	79e2                	ld	s3,56(sp)
 1da:	7a42                	ld	s4,48(sp)
 1dc:	7aa2                	ld	s5,40(sp)
 1de:	7b02                	ld	s6,32(sp)
 1e0:	6be2                	ld	s7,24(sp)
 1e2:	6c42                	ld	s8,16(sp)
 1e4:	6ca2                	ld	s9,8(sp)
 1e6:	6125                	addi	sp,sp,96
 1e8:	8082                	ret

00000000000001ea <main>:
{
 1ea:	7139                	addi	sp,sp,-64
 1ec:	fc06                	sd	ra,56(sp)
 1ee:	f822                	sd	s0,48(sp)
 1f0:	f426                	sd	s1,40(sp)
 1f2:	f04a                	sd	s2,32(sp)
 1f4:	ec4e                	sd	s3,24(sp)
 1f6:	e852                	sd	s4,16(sp)
 1f8:	e456                	sd	s5,8(sp)
 1fa:	0080                	addi	s0,sp,64
  if(argc <= 1){
 1fc:	4785                	li	a5,1
 1fe:	04a7dd63          	bge	a5,a0,258 <main+0x6e>
  pattern = argv[1];
 202:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
 206:	4789                	li	a5,2
 208:	06a7d663          	bge	a5,a0,274 <main+0x8a>
 20c:	01058493          	addi	s1,a1,16
 210:	ffd5099b          	addiw	s3,a0,-3
 214:	1982                	slli	s3,s3,0x20
 216:	0209d993          	srli	s3,s3,0x20
 21a:	098e                	slli	s3,s3,0x3
 21c:	05e1                	addi	a1,a1,24
 21e:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], O_RDONLY)) < 0){
 220:	4581                	li	a1,0
 222:	6088                	ld	a0,0(s1)
 224:	00000097          	auipc	ra,0x0
 228:	382080e7          	jalr	898(ra) # 5a6 <open>
 22c:	892a                	mv	s2,a0
 22e:	04054e63          	bltz	a0,28a <main+0xa0>
    grep(pattern, fd);
 232:	85aa                	mv	a1,a0
 234:	8552                	mv	a0,s4
 236:	00000097          	auipc	ra,0x0
 23a:	ee4080e7          	jalr	-284(ra) # 11a <grep>
    close(fd);
 23e:	854a                	mv	a0,s2
 240:	00000097          	auipc	ra,0x0
 244:	34e080e7          	jalr	846(ra) # 58e <close>
 248:	04a1                	addi	s1,s1,8
  for(i = 2; i < argc; i++){
 24a:	fd349be3          	bne	s1,s3,220 <main+0x36>
  exit(0);
 24e:	4501                	li	a0,0
 250:	00000097          	auipc	ra,0x0
 254:	316080e7          	jalr	790(ra) # 566 <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 258:	00001597          	auipc	a1,0x1
 25c:	85858593          	addi	a1,a1,-1960 # ab0 <malloc+0xf4>
 260:	4509                	li	a0,2
 262:	00000097          	auipc	ra,0x0
 266:	66c080e7          	jalr	1644(ra) # 8ce <fprintf>
    exit(1);
 26a:	4505                	li	a0,1
 26c:	00000097          	auipc	ra,0x0
 270:	2fa080e7          	jalr	762(ra) # 566 <exit>
    grep(pattern, 0);
 274:	4581                	li	a1,0
 276:	8552                	mv	a0,s4
 278:	00000097          	auipc	ra,0x0
 27c:	ea2080e7          	jalr	-350(ra) # 11a <grep>
    exit(0);
 280:	4501                	li	a0,0
 282:	00000097          	auipc	ra,0x0
 286:	2e4080e7          	jalr	740(ra) # 566 <exit>
      printf("grep: cannot open %s\n", argv[i]);
 28a:	608c                	ld	a1,0(s1)
 28c:	00001517          	auipc	a0,0x1
 290:	84450513          	addi	a0,a0,-1980 # ad0 <malloc+0x114>
 294:	00000097          	auipc	ra,0x0
 298:	668080e7          	jalr	1640(ra) # 8fc <printf>
      exit(1);
 29c:	4505                	li	a0,1
 29e:	00000097          	auipc	ra,0x0
 2a2:	2c8080e7          	jalr	712(ra) # 566 <exit>

00000000000002a6 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 2a6:	1141                	addi	sp,sp,-16
 2a8:	e406                	sd	ra,8(sp)
 2aa:	e022                	sd	s0,0(sp)
 2ac:	0800                	addi	s0,sp,16
  extern int main();
  main();
 2ae:	00000097          	auipc	ra,0x0
 2b2:	f3c080e7          	jalr	-196(ra) # 1ea <main>
  exit(0);
 2b6:	4501                	li	a0,0
 2b8:	00000097          	auipc	ra,0x0
 2bc:	2ae080e7          	jalr	686(ra) # 566 <exit>

00000000000002c0 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 2c0:	1141                	addi	sp,sp,-16
 2c2:	e422                	sd	s0,8(sp)
 2c4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2c6:	87aa                	mv	a5,a0
 2c8:	0585                	addi	a1,a1,1
 2ca:	0785                	addi	a5,a5,1
 2cc:	fff5c703          	lbu	a4,-1(a1)
 2d0:	fee78fa3          	sb	a4,-1(a5)
 2d4:	fb75                	bnez	a4,2c8 <strcpy+0x8>
    ;
  return os;
}
 2d6:	6422                	ld	s0,8(sp)
 2d8:	0141                	addi	sp,sp,16
 2da:	8082                	ret

00000000000002dc <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2dc:	1141                	addi	sp,sp,-16
 2de:	e422                	sd	s0,8(sp)
 2e0:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2e2:	00054783          	lbu	a5,0(a0)
 2e6:	cf91                	beqz	a5,302 <strcmp+0x26>
 2e8:	0005c703          	lbu	a4,0(a1)
 2ec:	00f71b63          	bne	a4,a5,302 <strcmp+0x26>
    p++, q++;
 2f0:	0505                	addi	a0,a0,1
 2f2:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2f4:	00054783          	lbu	a5,0(a0)
 2f8:	c789                	beqz	a5,302 <strcmp+0x26>
 2fa:	0005c703          	lbu	a4,0(a1)
 2fe:	fef709e3          	beq	a4,a5,2f0 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 302:	0005c503          	lbu	a0,0(a1)
}
 306:	40a7853b          	subw	a0,a5,a0
 30a:	6422                	ld	s0,8(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret

0000000000000310 <strlen>:

uint
strlen(const char *s)
{
 310:	1141                	addi	sp,sp,-16
 312:	e422                	sd	s0,8(sp)
 314:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 316:	00054783          	lbu	a5,0(a0)
 31a:	cf91                	beqz	a5,336 <strlen+0x26>
 31c:	0505                	addi	a0,a0,1
 31e:	87aa                	mv	a5,a0
 320:	4685                	li	a3,1
 322:	9e89                	subw	a3,a3,a0
    ;
 324:	00f6853b          	addw	a0,a3,a5
 328:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
 32a:	fff7c703          	lbu	a4,-1(a5)
 32e:	fb7d                	bnez	a4,324 <strlen+0x14>
  return n;
}
 330:	6422                	ld	s0,8(sp)
 332:	0141                	addi	sp,sp,16
 334:	8082                	ret
  for(n = 0; s[n]; n++)
 336:	4501                	li	a0,0
 338:	bfe5                	j	330 <strlen+0x20>

000000000000033a <memset>:

void*
memset(void *dst, int c, uint n)
{
 33a:	1141                	addi	sp,sp,-16
 33c:	e422                	sd	s0,8(sp)
 33e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 340:	ce09                	beqz	a2,35a <memset+0x20>
 342:	87aa                	mv	a5,a0
 344:	fff6071b          	addiw	a4,a2,-1
 348:	1702                	slli	a4,a4,0x20
 34a:	9301                	srli	a4,a4,0x20
 34c:	0705                	addi	a4,a4,1
 34e:	972a                	add	a4,a4,a0
    cdst[i] = c;
 350:	00b78023          	sb	a1,0(a5)
 354:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 356:	fee79de3          	bne	a5,a4,350 <memset+0x16>
  }
  return dst;
}
 35a:	6422                	ld	s0,8(sp)
 35c:	0141                	addi	sp,sp,16
 35e:	8082                	ret

0000000000000360 <strchr>:

char*
strchr(const char *s, char c)
{
 360:	1141                	addi	sp,sp,-16
 362:	e422                	sd	s0,8(sp)
 364:	0800                	addi	s0,sp,16
  for(; *s; s++)
 366:	00054783          	lbu	a5,0(a0)
 36a:	cf91                	beqz	a5,386 <strchr+0x26>
    if(*s == c)
 36c:	00f58a63          	beq	a1,a5,380 <strchr+0x20>
  for(; *s; s++)
 370:	0505                	addi	a0,a0,1
 372:	00054783          	lbu	a5,0(a0)
 376:	c781                	beqz	a5,37e <strchr+0x1e>
    if(*s == c)
 378:	feb79ce3          	bne	a5,a1,370 <strchr+0x10>
 37c:	a011                	j	380 <strchr+0x20>
      return (char*)s;
  return 0;
 37e:	4501                	li	a0,0
}
 380:	6422                	ld	s0,8(sp)
 382:	0141                	addi	sp,sp,16
 384:	8082                	ret
  return 0;
 386:	4501                	li	a0,0
 388:	bfe5                	j	380 <strchr+0x20>

000000000000038a <gets>:

char*
gets(char *buf, int max)
{
 38a:	711d                	addi	sp,sp,-96
 38c:	ec86                	sd	ra,88(sp)
 38e:	e8a2                	sd	s0,80(sp)
 390:	e4a6                	sd	s1,72(sp)
 392:	e0ca                	sd	s2,64(sp)
 394:	fc4e                	sd	s3,56(sp)
 396:	f852                	sd	s4,48(sp)
 398:	f456                	sd	s5,40(sp)
 39a:	f05a                	sd	s6,32(sp)
 39c:	ec5e                	sd	s7,24(sp)
 39e:	1080                	addi	s0,sp,96
 3a0:	8baa                	mv	s7,a0
 3a2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3a4:	892a                	mv	s2,a0
 3a6:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3a8:	4aa9                	li	s5,10
 3aa:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3ac:	0019849b          	addiw	s1,s3,1
 3b0:	0344d863          	bge	s1,s4,3e0 <gets+0x56>
    cc = read(0, &c, 1);
 3b4:	4605                	li	a2,1
 3b6:	faf40593          	addi	a1,s0,-81
 3ba:	4501                	li	a0,0
 3bc:	00000097          	auipc	ra,0x0
 3c0:	1c2080e7          	jalr	450(ra) # 57e <read>
    if(cc < 1)
 3c4:	00a05e63          	blez	a0,3e0 <gets+0x56>
    buf[i++] = c;
 3c8:	faf44783          	lbu	a5,-81(s0)
 3cc:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3d0:	01578763          	beq	a5,s5,3de <gets+0x54>
 3d4:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 3d6:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 3d8:	fd679ae3          	bne	a5,s6,3ac <gets+0x22>
 3dc:	a011                	j	3e0 <gets+0x56>
  for(i=0; i+1 < max; ){
 3de:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3e0:	99de                	add	s3,s3,s7
 3e2:	00098023          	sb	zero,0(s3)
  return buf;
}
 3e6:	855e                	mv	a0,s7
 3e8:	60e6                	ld	ra,88(sp)
 3ea:	6446                	ld	s0,80(sp)
 3ec:	64a6                	ld	s1,72(sp)
 3ee:	6906                	ld	s2,64(sp)
 3f0:	79e2                	ld	s3,56(sp)
 3f2:	7a42                	ld	s4,48(sp)
 3f4:	7aa2                	ld	s5,40(sp)
 3f6:	7b02                	ld	s6,32(sp)
 3f8:	6be2                	ld	s7,24(sp)
 3fa:	6125                	addi	sp,sp,96
 3fc:	8082                	ret

00000000000003fe <stat>:

int
stat(const char *n, struct stat *st)
{
 3fe:	1101                	addi	sp,sp,-32
 400:	ec06                	sd	ra,24(sp)
 402:	e822                	sd	s0,16(sp)
 404:	e426                	sd	s1,8(sp)
 406:	e04a                	sd	s2,0(sp)
 408:	1000                	addi	s0,sp,32
 40a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 40c:	4581                	li	a1,0
 40e:	00000097          	auipc	ra,0x0
 412:	198080e7          	jalr	408(ra) # 5a6 <open>
  if(fd < 0)
 416:	02054563          	bltz	a0,440 <stat+0x42>
 41a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 41c:	85ca                	mv	a1,s2
 41e:	00000097          	auipc	ra,0x0
 422:	1a0080e7          	jalr	416(ra) # 5be <fstat>
 426:	892a                	mv	s2,a0
  close(fd);
 428:	8526                	mv	a0,s1
 42a:	00000097          	auipc	ra,0x0
 42e:	164080e7          	jalr	356(ra) # 58e <close>
  return r;
}
 432:	854a                	mv	a0,s2
 434:	60e2                	ld	ra,24(sp)
 436:	6442                	ld	s0,16(sp)
 438:	64a2                	ld	s1,8(sp)
 43a:	6902                	ld	s2,0(sp)
 43c:	6105                	addi	sp,sp,32
 43e:	8082                	ret
    return -1;
 440:	597d                	li	s2,-1
 442:	bfc5                	j	432 <stat+0x34>

0000000000000444 <atoi>:

int
atoi(const char *s)
{
 444:	1141                	addi	sp,sp,-16
 446:	e422                	sd	s0,8(sp)
 448:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 44a:	00054683          	lbu	a3,0(a0)
 44e:	fd06879b          	addiw	a5,a3,-48
 452:	0ff7f793          	andi	a5,a5,255
 456:	4725                	li	a4,9
 458:	02f76963          	bltu	a4,a5,48a <atoi+0x46>
 45c:	862a                	mv	a2,a0
  n = 0;
 45e:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 460:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 462:	0605                	addi	a2,a2,1
 464:	0025179b          	slliw	a5,a0,0x2
 468:	9fa9                	addw	a5,a5,a0
 46a:	0017979b          	slliw	a5,a5,0x1
 46e:	9fb5                	addw	a5,a5,a3
 470:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 474:	00064683          	lbu	a3,0(a2)
 478:	fd06871b          	addiw	a4,a3,-48
 47c:	0ff77713          	andi	a4,a4,255
 480:	fee5f1e3          	bgeu	a1,a4,462 <atoi+0x1e>
  return n;
}
 484:	6422                	ld	s0,8(sp)
 486:	0141                	addi	sp,sp,16
 488:	8082                	ret
  n = 0;
 48a:	4501                	li	a0,0
 48c:	bfe5                	j	484 <atoi+0x40>

000000000000048e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 48e:	1141                	addi	sp,sp,-16
 490:	e422                	sd	s0,8(sp)
 492:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 494:	02b57663          	bgeu	a0,a1,4c0 <memmove+0x32>
    while(n-- > 0)
 498:	02c05163          	blez	a2,4ba <memmove+0x2c>
 49c:	fff6079b          	addiw	a5,a2,-1
 4a0:	1782                	slli	a5,a5,0x20
 4a2:	9381                	srli	a5,a5,0x20
 4a4:	0785                	addi	a5,a5,1
 4a6:	97aa                	add	a5,a5,a0
  dst = vdst;
 4a8:	872a                	mv	a4,a0
      *dst++ = *src++;
 4aa:	0585                	addi	a1,a1,1
 4ac:	0705                	addi	a4,a4,1
 4ae:	fff5c683          	lbu	a3,-1(a1)
 4b2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4b6:	fee79ae3          	bne	a5,a4,4aa <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4ba:	6422                	ld	s0,8(sp)
 4bc:	0141                	addi	sp,sp,16
 4be:	8082                	ret
    dst += n;
 4c0:	00c50733          	add	a4,a0,a2
    src += n;
 4c4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4c6:	fec05ae3          	blez	a2,4ba <memmove+0x2c>
 4ca:	fff6079b          	addiw	a5,a2,-1
 4ce:	1782                	slli	a5,a5,0x20
 4d0:	9381                	srli	a5,a5,0x20
 4d2:	fff7c793          	not	a5,a5
 4d6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4d8:	15fd                	addi	a1,a1,-1
 4da:	177d                	addi	a4,a4,-1
 4dc:	0005c683          	lbu	a3,0(a1)
 4e0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4e4:	fef71ae3          	bne	a4,a5,4d8 <memmove+0x4a>
 4e8:	bfc9                	j	4ba <memmove+0x2c>

00000000000004ea <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4ea:	1141                	addi	sp,sp,-16
 4ec:	e422                	sd	s0,8(sp)
 4ee:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4f0:	ce15                	beqz	a2,52c <memcmp+0x42>
 4f2:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 4f6:	00054783          	lbu	a5,0(a0)
 4fa:	0005c703          	lbu	a4,0(a1)
 4fe:	02e79063          	bne	a5,a4,51e <memcmp+0x34>
 502:	1682                	slli	a3,a3,0x20
 504:	9281                	srli	a3,a3,0x20
 506:	0685                	addi	a3,a3,1
 508:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 50a:	0505                	addi	a0,a0,1
    p2++;
 50c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 50e:	00d50d63          	beq	a0,a3,528 <memcmp+0x3e>
    if (*p1 != *p2) {
 512:	00054783          	lbu	a5,0(a0)
 516:	0005c703          	lbu	a4,0(a1)
 51a:	fee788e3          	beq	a5,a4,50a <memcmp+0x20>
      return *p1 - *p2;
 51e:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 522:	6422                	ld	s0,8(sp)
 524:	0141                	addi	sp,sp,16
 526:	8082                	ret
  return 0;
 528:	4501                	li	a0,0
 52a:	bfe5                	j	522 <memcmp+0x38>
 52c:	4501                	li	a0,0
 52e:	bfd5                	j	522 <memcmp+0x38>

0000000000000530 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 530:	1141                	addi	sp,sp,-16
 532:	e406                	sd	ra,8(sp)
 534:	e022                	sd	s0,0(sp)
 536:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 538:	00000097          	auipc	ra,0x0
 53c:	f56080e7          	jalr	-170(ra) # 48e <memmove>
}
 540:	60a2                	ld	ra,8(sp)
 542:	6402                	ld	s0,0(sp)
 544:	0141                	addi	sp,sp,16
 546:	8082                	ret

0000000000000548 <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 548:	1141                	addi	sp,sp,-16
 54a:	e422                	sd	s0,8(sp)
 54c:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 54e:	040007b7          	lui	a5,0x4000
}
 552:	17f5                	addi	a5,a5,-3
 554:	07b2                	slli	a5,a5,0xc
 556:	4388                	lw	a0,0(a5)
 558:	6422                	ld	s0,8(sp)
 55a:	0141                	addi	sp,sp,16
 55c:	8082                	ret

000000000000055e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 55e:	4885                	li	a7,1
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <exit>:
.global exit
exit:
 li a7, SYS_exit
 566:	4889                	li	a7,2
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <wait>:
.global wait
wait:
 li a7, SYS_wait
 56e:	488d                	li	a7,3
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 576:	4891                	li	a7,4
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <read>:
.global read
read:
 li a7, SYS_read
 57e:	4895                	li	a7,5
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <write>:
.global write
write:
 li a7, SYS_write
 586:	48c1                	li	a7,16
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <close>:
.global close
close:
 li a7, SYS_close
 58e:	48d5                	li	a7,21
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <kill>:
.global kill
kill:
 li a7, SYS_kill
 596:	4899                	li	a7,6
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <exec>:
.global exec
exec:
 li a7, SYS_exec
 59e:	489d                	li	a7,7
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <open>:
.global open
open:
 li a7, SYS_open
 5a6:	48bd                	li	a7,15
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5ae:	48c5                	li	a7,17
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5b6:	48c9                	li	a7,18
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5be:	48a1                	li	a7,8
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <link>:
.global link
link:
 li a7, SYS_link
 5c6:	48cd                	li	a7,19
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5ce:	48d1                	li	a7,20
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5d6:	48a5                	li	a7,9
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <dup>:
.global dup
dup:
 li a7, SYS_dup
 5de:	48a9                	li	a7,10
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5e6:	48ad                	li	a7,11
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5ee:	48b1                	li	a7,12
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5f6:	48b5                	li	a7,13
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5fe:	48b9                	li	a7,14
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <trace>:
.global trace
trace:
 li a7, SYS_trace
 606:	48d9                	li	a7,22
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 60e:	48dd                	li	a7,23
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <connect>:
.global connect
connect:
 li a7, SYS_connect
 616:	48f5                	li	a7,29
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 61e:	48f9                	li	a7,30
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 626:	1101                	addi	sp,sp,-32
 628:	ec06                	sd	ra,24(sp)
 62a:	e822                	sd	s0,16(sp)
 62c:	1000                	addi	s0,sp,32
 62e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 632:	4605                	li	a2,1
 634:	fef40593          	addi	a1,s0,-17
 638:	00000097          	auipc	ra,0x0
 63c:	f4e080e7          	jalr	-178(ra) # 586 <write>
}
 640:	60e2                	ld	ra,24(sp)
 642:	6442                	ld	s0,16(sp)
 644:	6105                	addi	sp,sp,32
 646:	8082                	ret

0000000000000648 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 648:	7139                	addi	sp,sp,-64
 64a:	fc06                	sd	ra,56(sp)
 64c:	f822                	sd	s0,48(sp)
 64e:	f426                	sd	s1,40(sp)
 650:	f04a                	sd	s2,32(sp)
 652:	ec4e                	sd	s3,24(sp)
 654:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 656:	c299                	beqz	a3,65c <printint+0x14>
 658:	0005cd63          	bltz	a1,672 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 65c:	2581                	sext.w	a1,a1
  neg = 0;
 65e:	4301                	li	t1,0
 660:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 664:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 666:	2601                	sext.w	a2,a2
 668:	00000897          	auipc	a7,0x0
 66c:	48088893          	addi	a7,a7,1152 # ae8 <digits>
 670:	a039                	j	67e <printint+0x36>
    x = -xx;
 672:	40b005bb          	negw	a1,a1
    neg = 1;
 676:	4305                	li	t1,1
    x = -xx;
 678:	b7e5                	j	660 <printint+0x18>
  }while((x /= base) != 0);
 67a:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 67c:	8836                	mv	a6,a3
 67e:	0018069b          	addiw	a3,a6,1
 682:	02c5f7bb          	remuw	a5,a1,a2
 686:	1782                	slli	a5,a5,0x20
 688:	9381                	srli	a5,a5,0x20
 68a:	97c6                	add	a5,a5,a7
 68c:	0007c783          	lbu	a5,0(a5) # 4000000 <base+0x3ffebf0>
 690:	00f70023          	sb	a5,0(a4)
 694:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 696:	02c5d7bb          	divuw	a5,a1,a2
 69a:	fec5f0e3          	bgeu	a1,a2,67a <printint+0x32>
  if(neg)
 69e:	00030b63          	beqz	t1,6b4 <printint+0x6c>
    buf[i++] = '-';
 6a2:	fd040793          	addi	a5,s0,-48
 6a6:	96be                	add	a3,a3,a5
 6a8:	02d00793          	li	a5,45
 6ac:	fef68823          	sb	a5,-16(a3)
 6b0:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 6b4:	02d05963          	blez	a3,6e6 <printint+0x9e>
 6b8:	89aa                	mv	s3,a0
 6ba:	fc040793          	addi	a5,s0,-64
 6be:	00d784b3          	add	s1,a5,a3
 6c2:	fff78913          	addi	s2,a5,-1
 6c6:	9936                	add	s2,s2,a3
 6c8:	36fd                	addiw	a3,a3,-1
 6ca:	1682                	slli	a3,a3,0x20
 6cc:	9281                	srli	a3,a3,0x20
 6ce:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 6d2:	fff4c583          	lbu	a1,-1(s1)
 6d6:	854e                	mv	a0,s3
 6d8:	00000097          	auipc	ra,0x0
 6dc:	f4e080e7          	jalr	-178(ra) # 626 <putc>
 6e0:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 6e2:	ff2498e3          	bne	s1,s2,6d2 <printint+0x8a>
}
 6e6:	70e2                	ld	ra,56(sp)
 6e8:	7442                	ld	s0,48(sp)
 6ea:	74a2                	ld	s1,40(sp)
 6ec:	7902                	ld	s2,32(sp)
 6ee:	69e2                	ld	s3,24(sp)
 6f0:	6121                	addi	sp,sp,64
 6f2:	8082                	ret

00000000000006f4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6f4:	7119                	addi	sp,sp,-128
 6f6:	fc86                	sd	ra,120(sp)
 6f8:	f8a2                	sd	s0,112(sp)
 6fa:	f4a6                	sd	s1,104(sp)
 6fc:	f0ca                	sd	s2,96(sp)
 6fe:	ecce                	sd	s3,88(sp)
 700:	e8d2                	sd	s4,80(sp)
 702:	e4d6                	sd	s5,72(sp)
 704:	e0da                	sd	s6,64(sp)
 706:	fc5e                	sd	s7,56(sp)
 708:	f862                	sd	s8,48(sp)
 70a:	f466                	sd	s9,40(sp)
 70c:	f06a                	sd	s10,32(sp)
 70e:	ec6e                	sd	s11,24(sp)
 710:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 712:	0005c483          	lbu	s1,0(a1)
 716:	18048d63          	beqz	s1,8b0 <vprintf+0x1bc>
 71a:	8aaa                	mv	s5,a0
 71c:	8b32                	mv	s6,a2
 71e:	00158913          	addi	s2,a1,1
  state = 0;
 722:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 724:	02500a13          	li	s4,37
      if(c == 'd'){
 728:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 72c:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 730:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 734:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 738:	00000b97          	auipc	s7,0x0
 73c:	3b0b8b93          	addi	s7,s7,944 # ae8 <digits>
 740:	a839                	j	75e <vprintf+0x6a>
        putc(fd, c);
 742:	85a6                	mv	a1,s1
 744:	8556                	mv	a0,s5
 746:	00000097          	auipc	ra,0x0
 74a:	ee0080e7          	jalr	-288(ra) # 626 <putc>
 74e:	a019                	j	754 <vprintf+0x60>
    } else if(state == '%'){
 750:	01498f63          	beq	s3,s4,76e <vprintf+0x7a>
 754:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 756:	fff94483          	lbu	s1,-1(s2)
 75a:	14048b63          	beqz	s1,8b0 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 75e:	0004879b          	sext.w	a5,s1
    if(state == 0){
 762:	fe0997e3          	bnez	s3,750 <vprintf+0x5c>
      if(c == '%'){
 766:	fd479ee3          	bne	a5,s4,742 <vprintf+0x4e>
        state = '%';
 76a:	89be                	mv	s3,a5
 76c:	b7e5                	j	754 <vprintf+0x60>
      if(c == 'd'){
 76e:	05878063          	beq	a5,s8,7ae <vprintf+0xba>
      } else if(c == 'l') {
 772:	05978c63          	beq	a5,s9,7ca <vprintf+0xd6>
      } else if(c == 'x') {
 776:	07a78863          	beq	a5,s10,7e6 <vprintf+0xf2>
      } else if(c == 'p') {
 77a:	09b78463          	beq	a5,s11,802 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 77e:	07300713          	li	a4,115
 782:	0ce78563          	beq	a5,a4,84c <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 786:	06300713          	li	a4,99
 78a:	0ee78c63          	beq	a5,a4,882 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 78e:	11478663          	beq	a5,s4,89a <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 792:	85d2                	mv	a1,s4
 794:	8556                	mv	a0,s5
 796:	00000097          	auipc	ra,0x0
 79a:	e90080e7          	jalr	-368(ra) # 626 <putc>
        putc(fd, c);
 79e:	85a6                	mv	a1,s1
 7a0:	8556                	mv	a0,s5
 7a2:	00000097          	auipc	ra,0x0
 7a6:	e84080e7          	jalr	-380(ra) # 626 <putc>
      }
      state = 0;
 7aa:	4981                	li	s3,0
 7ac:	b765                	j	754 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 7ae:	008b0493          	addi	s1,s6,8
 7b2:	4685                	li	a3,1
 7b4:	4629                	li	a2,10
 7b6:	000b2583          	lw	a1,0(s6)
 7ba:	8556                	mv	a0,s5
 7bc:	00000097          	auipc	ra,0x0
 7c0:	e8c080e7          	jalr	-372(ra) # 648 <printint>
 7c4:	8b26                	mv	s6,s1
      state = 0;
 7c6:	4981                	li	s3,0
 7c8:	b771                	j	754 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7ca:	008b0493          	addi	s1,s6,8
 7ce:	4681                	li	a3,0
 7d0:	4629                	li	a2,10
 7d2:	000b2583          	lw	a1,0(s6)
 7d6:	8556                	mv	a0,s5
 7d8:	00000097          	auipc	ra,0x0
 7dc:	e70080e7          	jalr	-400(ra) # 648 <printint>
 7e0:	8b26                	mv	s6,s1
      state = 0;
 7e2:	4981                	li	s3,0
 7e4:	bf85                	j	754 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 7e6:	008b0493          	addi	s1,s6,8
 7ea:	4681                	li	a3,0
 7ec:	4641                	li	a2,16
 7ee:	000b2583          	lw	a1,0(s6)
 7f2:	8556                	mv	a0,s5
 7f4:	00000097          	auipc	ra,0x0
 7f8:	e54080e7          	jalr	-428(ra) # 648 <printint>
 7fc:	8b26                	mv	s6,s1
      state = 0;
 7fe:	4981                	li	s3,0
 800:	bf91                	j	754 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 802:	008b0793          	addi	a5,s6,8
 806:	f8f43423          	sd	a5,-120(s0)
 80a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 80e:	03000593          	li	a1,48
 812:	8556                	mv	a0,s5
 814:	00000097          	auipc	ra,0x0
 818:	e12080e7          	jalr	-494(ra) # 626 <putc>
  putc(fd, 'x');
 81c:	85ea                	mv	a1,s10
 81e:	8556                	mv	a0,s5
 820:	00000097          	auipc	ra,0x0
 824:	e06080e7          	jalr	-506(ra) # 626 <putc>
 828:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 82a:	03c9d793          	srli	a5,s3,0x3c
 82e:	97de                	add	a5,a5,s7
 830:	0007c583          	lbu	a1,0(a5)
 834:	8556                	mv	a0,s5
 836:	00000097          	auipc	ra,0x0
 83a:	df0080e7          	jalr	-528(ra) # 626 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 83e:	0992                	slli	s3,s3,0x4
 840:	34fd                	addiw	s1,s1,-1
 842:	f4e5                	bnez	s1,82a <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 844:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 848:	4981                	li	s3,0
 84a:	b729                	j	754 <vprintf+0x60>
        s = va_arg(ap, char*);
 84c:	008b0993          	addi	s3,s6,8
 850:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 854:	c085                	beqz	s1,874 <vprintf+0x180>
        while(*s != 0){
 856:	0004c583          	lbu	a1,0(s1)
 85a:	c9a1                	beqz	a1,8aa <vprintf+0x1b6>
          putc(fd, *s);
 85c:	8556                	mv	a0,s5
 85e:	00000097          	auipc	ra,0x0
 862:	dc8080e7          	jalr	-568(ra) # 626 <putc>
          s++;
 866:	0485                	addi	s1,s1,1
        while(*s != 0){
 868:	0004c583          	lbu	a1,0(s1)
 86c:	f9e5                	bnez	a1,85c <vprintf+0x168>
        s = va_arg(ap, char*);
 86e:	8b4e                	mv	s6,s3
      state = 0;
 870:	4981                	li	s3,0
 872:	b5cd                	j	754 <vprintf+0x60>
          s = "(null)";
 874:	00000497          	auipc	s1,0x0
 878:	28c48493          	addi	s1,s1,652 # b00 <digits+0x18>
        while(*s != 0){
 87c:	02800593          	li	a1,40
 880:	bff1                	j	85c <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 882:	008b0493          	addi	s1,s6,8
 886:	000b4583          	lbu	a1,0(s6)
 88a:	8556                	mv	a0,s5
 88c:	00000097          	auipc	ra,0x0
 890:	d9a080e7          	jalr	-614(ra) # 626 <putc>
 894:	8b26                	mv	s6,s1
      state = 0;
 896:	4981                	li	s3,0
 898:	bd75                	j	754 <vprintf+0x60>
        putc(fd, c);
 89a:	85d2                	mv	a1,s4
 89c:	8556                	mv	a0,s5
 89e:	00000097          	auipc	ra,0x0
 8a2:	d88080e7          	jalr	-632(ra) # 626 <putc>
      state = 0;
 8a6:	4981                	li	s3,0
 8a8:	b575                	j	754 <vprintf+0x60>
        s = va_arg(ap, char*);
 8aa:	8b4e                	mv	s6,s3
      state = 0;
 8ac:	4981                	li	s3,0
 8ae:	b55d                	j	754 <vprintf+0x60>
    }
  }
}
 8b0:	70e6                	ld	ra,120(sp)
 8b2:	7446                	ld	s0,112(sp)
 8b4:	74a6                	ld	s1,104(sp)
 8b6:	7906                	ld	s2,96(sp)
 8b8:	69e6                	ld	s3,88(sp)
 8ba:	6a46                	ld	s4,80(sp)
 8bc:	6aa6                	ld	s5,72(sp)
 8be:	6b06                	ld	s6,64(sp)
 8c0:	7be2                	ld	s7,56(sp)
 8c2:	7c42                	ld	s8,48(sp)
 8c4:	7ca2                	ld	s9,40(sp)
 8c6:	7d02                	ld	s10,32(sp)
 8c8:	6de2                	ld	s11,24(sp)
 8ca:	6109                	addi	sp,sp,128
 8cc:	8082                	ret

00000000000008ce <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8ce:	715d                	addi	sp,sp,-80
 8d0:	ec06                	sd	ra,24(sp)
 8d2:	e822                	sd	s0,16(sp)
 8d4:	1000                	addi	s0,sp,32
 8d6:	e010                	sd	a2,0(s0)
 8d8:	e414                	sd	a3,8(s0)
 8da:	e818                	sd	a4,16(s0)
 8dc:	ec1c                	sd	a5,24(s0)
 8de:	03043023          	sd	a6,32(s0)
 8e2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8e6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8ea:	8622                	mv	a2,s0
 8ec:	00000097          	auipc	ra,0x0
 8f0:	e08080e7          	jalr	-504(ra) # 6f4 <vprintf>
}
 8f4:	60e2                	ld	ra,24(sp)
 8f6:	6442                	ld	s0,16(sp)
 8f8:	6161                	addi	sp,sp,80
 8fa:	8082                	ret

00000000000008fc <printf>:

void
printf(const char *fmt, ...)
{
 8fc:	711d                	addi	sp,sp,-96
 8fe:	ec06                	sd	ra,24(sp)
 900:	e822                	sd	s0,16(sp)
 902:	1000                	addi	s0,sp,32
 904:	e40c                	sd	a1,8(s0)
 906:	e810                	sd	a2,16(s0)
 908:	ec14                	sd	a3,24(s0)
 90a:	f018                	sd	a4,32(s0)
 90c:	f41c                	sd	a5,40(s0)
 90e:	03043823          	sd	a6,48(s0)
 912:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 916:	00840613          	addi	a2,s0,8
 91a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 91e:	85aa                	mv	a1,a0
 920:	4505                	li	a0,1
 922:	00000097          	auipc	ra,0x0
 926:	dd2080e7          	jalr	-558(ra) # 6f4 <vprintf>
}
 92a:	60e2                	ld	ra,24(sp)
 92c:	6442                	ld	s0,16(sp)
 92e:	6125                	addi	sp,sp,96
 930:	8082                	ret

0000000000000932 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 932:	1141                	addi	sp,sp,-16
 934:	e422                	sd	s0,8(sp)
 936:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 938:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 93c:	00000797          	auipc	a5,0x0
 940:	6c478793          	addi	a5,a5,1732 # 1000 <freep>
 944:	639c                	ld	a5,0(a5)
 946:	a805                	j	976 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 948:	4618                	lw	a4,8(a2)
 94a:	9db9                	addw	a1,a1,a4
 94c:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 950:	6398                	ld	a4,0(a5)
 952:	6318                	ld	a4,0(a4)
 954:	fee53823          	sd	a4,-16(a0)
 958:	a091                	j	99c <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 95a:	ff852703          	lw	a4,-8(a0)
 95e:	9e39                	addw	a2,a2,a4
 960:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 962:	ff053703          	ld	a4,-16(a0)
 966:	e398                	sd	a4,0(a5)
 968:	a099                	j	9ae <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 96a:	6398                	ld	a4,0(a5)
 96c:	00e7e463          	bltu	a5,a4,974 <free+0x42>
 970:	00e6ea63          	bltu	a3,a4,984 <free+0x52>
{
 974:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 976:	fed7fae3          	bgeu	a5,a3,96a <free+0x38>
 97a:	6398                	ld	a4,0(a5)
 97c:	00e6e463          	bltu	a3,a4,984 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 980:	fee7eae3          	bltu	a5,a4,974 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 984:	ff852583          	lw	a1,-8(a0)
 988:	6390                	ld	a2,0(a5)
 98a:	02059713          	slli	a4,a1,0x20
 98e:	9301                	srli	a4,a4,0x20
 990:	0712                	slli	a4,a4,0x4
 992:	9736                	add	a4,a4,a3
 994:	fae60ae3          	beq	a2,a4,948 <free+0x16>
    bp->s.ptr = p->s.ptr;
 998:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 99c:	4790                	lw	a2,8(a5)
 99e:	02061713          	slli	a4,a2,0x20
 9a2:	9301                	srli	a4,a4,0x20
 9a4:	0712                	slli	a4,a4,0x4
 9a6:	973e                	add	a4,a4,a5
 9a8:	fae689e3          	beq	a3,a4,95a <free+0x28>
  } else
    p->s.ptr = bp;
 9ac:	e394                	sd	a3,0(a5)
  freep = p;
 9ae:	00000717          	auipc	a4,0x0
 9b2:	64f73923          	sd	a5,1618(a4) # 1000 <freep>
}
 9b6:	6422                	ld	s0,8(sp)
 9b8:	0141                	addi	sp,sp,16
 9ba:	8082                	ret

00000000000009bc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9bc:	7139                	addi	sp,sp,-64
 9be:	fc06                	sd	ra,56(sp)
 9c0:	f822                	sd	s0,48(sp)
 9c2:	f426                	sd	s1,40(sp)
 9c4:	f04a                	sd	s2,32(sp)
 9c6:	ec4e                	sd	s3,24(sp)
 9c8:	e852                	sd	s4,16(sp)
 9ca:	e456                	sd	s5,8(sp)
 9cc:	e05a                	sd	s6,0(sp)
 9ce:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9d0:	02051993          	slli	s3,a0,0x20
 9d4:	0209d993          	srli	s3,s3,0x20
 9d8:	09bd                	addi	s3,s3,15
 9da:	0049d993          	srli	s3,s3,0x4
 9de:	2985                	addiw	s3,s3,1
 9e0:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 9e4:	00000797          	auipc	a5,0x0
 9e8:	61c78793          	addi	a5,a5,1564 # 1000 <freep>
 9ec:	6388                	ld	a0,0(a5)
 9ee:	c515                	beqz	a0,a1a <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9f0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9f2:	4798                	lw	a4,8(a5)
 9f4:	03277f63          	bgeu	a4,s2,a32 <malloc+0x76>
 9f8:	8a4e                	mv	s4,s3
 9fa:	0009871b          	sext.w	a4,s3
 9fe:	6685                	lui	a3,0x1
 a00:	00d77363          	bgeu	a4,a3,a06 <malloc+0x4a>
 a04:	6a05                	lui	s4,0x1
 a06:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 a0a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a0e:	00000497          	auipc	s1,0x0
 a12:	5f248493          	addi	s1,s1,1522 # 1000 <freep>
  if(p == (char*)-1)
 a16:	5b7d                	li	s6,-1
 a18:	a885                	j	a88 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 a1a:	00001797          	auipc	a5,0x1
 a1e:	9f678793          	addi	a5,a5,-1546 # 1410 <base>
 a22:	00000717          	auipc	a4,0x0
 a26:	5cf73f23          	sd	a5,1502(a4) # 1000 <freep>
 a2a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a2c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a30:	b7e1                	j	9f8 <malloc+0x3c>
      if(p->s.size == nunits)
 a32:	02e90b63          	beq	s2,a4,a68 <malloc+0xac>
        p->s.size -= nunits;
 a36:	4137073b          	subw	a4,a4,s3
 a3a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a3c:	1702                	slli	a4,a4,0x20
 a3e:	9301                	srli	a4,a4,0x20
 a40:	0712                	slli	a4,a4,0x4
 a42:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a44:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a48:	00000717          	auipc	a4,0x0
 a4c:	5aa73c23          	sd	a0,1464(a4) # 1000 <freep>
      return (void*)(p + 1);
 a50:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a54:	70e2                	ld	ra,56(sp)
 a56:	7442                	ld	s0,48(sp)
 a58:	74a2                	ld	s1,40(sp)
 a5a:	7902                	ld	s2,32(sp)
 a5c:	69e2                	ld	s3,24(sp)
 a5e:	6a42                	ld	s4,16(sp)
 a60:	6aa2                	ld	s5,8(sp)
 a62:	6b02                	ld	s6,0(sp)
 a64:	6121                	addi	sp,sp,64
 a66:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a68:	6398                	ld	a4,0(a5)
 a6a:	e118                	sd	a4,0(a0)
 a6c:	bff1                	j	a48 <malloc+0x8c>
  hp->s.size = nu;
 a6e:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 a72:	0541                	addi	a0,a0,16
 a74:	00000097          	auipc	ra,0x0
 a78:	ebe080e7          	jalr	-322(ra) # 932 <free>
  return freep;
 a7c:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 a7e:	d979                	beqz	a0,a54 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a80:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a82:	4798                	lw	a4,8(a5)
 a84:	fb2777e3          	bgeu	a4,s2,a32 <malloc+0x76>
    if(p == freep)
 a88:	6098                	ld	a4,0(s1)
 a8a:	853e                	mv	a0,a5
 a8c:	fef71ae3          	bne	a4,a5,a80 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 a90:	8552                	mv	a0,s4
 a92:	00000097          	auipc	ra,0x0
 a96:	b5c080e7          	jalr	-1188(ra) # 5ee <sbrk>
  if(p == (char*)-1)
 a9a:	fd651ae3          	bne	a0,s6,a6e <malloc+0xb2>
        return 0;
 a9e:	4501                	li	a0,0
 aa0:	bf55                	j	a54 <malloc+0x98>
