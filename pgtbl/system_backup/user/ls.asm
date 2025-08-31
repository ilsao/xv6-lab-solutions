
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

char*
fmtname(char *path)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  10:	00000097          	auipc	ra,0x0
  14:	33a080e7          	jalr	826(ra) # 34a <strlen>
  18:	1502                	slli	a0,a0,0x20
  1a:	9101                	srli	a0,a0,0x20
  1c:	9526                	add	a0,a0,s1
  1e:	02956163          	bltu	a0,s1,40 <fmtname+0x40>
  22:	00054703          	lbu	a4,0(a0)
  26:	02f00793          	li	a5,47
  2a:	00f70b63          	beq	a4,a5,40 <fmtname+0x40>
  2e:	02f00713          	li	a4,47
  32:	157d                	addi	a0,a0,-1
  34:	00956663          	bltu	a0,s1,40 <fmtname+0x40>
  38:	00054783          	lbu	a5,0(a0)
  3c:	fee79be3          	bne	a5,a4,32 <fmtname+0x32>
    ;
  p++;
  40:	00150493          	addi	s1,a0,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  44:	8526                	mv	a0,s1
  46:	00000097          	auipc	ra,0x0
  4a:	304080e7          	jalr	772(ra) # 34a <strlen>
  4e:	2501                	sext.w	a0,a0
  50:	47b5                	li	a5,13
  52:	00a7fa63          	bgeu	a5,a0,66 <fmtname+0x66>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  56:	8526                	mv	a0,s1
  58:	70a2                	ld	ra,40(sp)
  5a:	7402                	ld	s0,32(sp)
  5c:	64e2                	ld	s1,24(sp)
  5e:	6942                	ld	s2,16(sp)
  60:	69a2                	ld	s3,8(sp)
  62:	6145                	addi	sp,sp,48
  64:	8082                	ret
  memmove(buf, p, strlen(p));
  66:	8526                	mv	a0,s1
  68:	00000097          	auipc	ra,0x0
  6c:	2e2080e7          	jalr	738(ra) # 34a <strlen>
  70:	00001917          	auipc	s2,0x1
  74:	fa090913          	addi	s2,s2,-96 # 1010 <buf.1140>
  78:	0005061b          	sext.w	a2,a0
  7c:	85a6                	mv	a1,s1
  7e:	854a                	mv	a0,s2
  80:	00000097          	auipc	ra,0x0
  84:	448080e7          	jalr	1096(ra) # 4c8 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  88:	8526                	mv	a0,s1
  8a:	00000097          	auipc	ra,0x0
  8e:	2c0080e7          	jalr	704(ra) # 34a <strlen>
  92:	0005099b          	sext.w	s3,a0
  96:	8526                	mv	a0,s1
  98:	00000097          	auipc	ra,0x0
  9c:	2b2080e7          	jalr	690(ra) # 34a <strlen>
  a0:	1982                	slli	s3,s3,0x20
  a2:	0209d993          	srli	s3,s3,0x20
  a6:	4639                	li	a2,14
  a8:	9e09                	subw	a2,a2,a0
  aa:	02000593          	li	a1,32
  ae:	01390533          	add	a0,s2,s3
  b2:	00000097          	auipc	ra,0x0
  b6:	2c2080e7          	jalr	706(ra) # 374 <memset>
  return buf;
  ba:	84ca                	mv	s1,s2
  bc:	bf69                	j	56 <fmtname+0x56>

00000000000000be <ls>:

void
ls(char *path)
{
  be:	d9010113          	addi	sp,sp,-624
  c2:	26113423          	sd	ra,616(sp)
  c6:	26813023          	sd	s0,608(sp)
  ca:	24913c23          	sd	s1,600(sp)
  ce:	25213823          	sd	s2,592(sp)
  d2:	25313423          	sd	s3,584(sp)
  d6:	25413023          	sd	s4,576(sp)
  da:	23513c23          	sd	s5,568(sp)
  de:	1c80                	addi	s0,sp,624
  e0:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, O_RDONLY)) < 0){
  e2:	4581                	li	a1,0
  e4:	00000097          	auipc	ra,0x0
  e8:	4fc080e7          	jalr	1276(ra) # 5e0 <open>
  ec:	08054163          	bltz	a0,16e <ls+0xb0>
  f0:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  f2:	d9840593          	addi	a1,s0,-616
  f6:	00000097          	auipc	ra,0x0
  fa:	502080e7          	jalr	1282(ra) # 5f8 <fstat>
  fe:	08054363          	bltz	a0,184 <ls+0xc6>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
 102:	da041783          	lh	a5,-608(s0)
 106:	0007869b          	sext.w	a3,a5
 10a:	4705                	li	a4,1
 10c:	08e68c63          	beq	a3,a4,1a4 <ls+0xe6>
 110:	02d05963          	blez	a3,142 <ls+0x84>
 114:	470d                	li	a4,3
 116:	02d74663          	blt	a4,a3,142 <ls+0x84>
  case T_DEVICE:
  case T_FILE:
    printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
 11a:	854a                	mv	a0,s2
 11c:	00000097          	auipc	ra,0x0
 120:	ee4080e7          	jalr	-284(ra) # 0 <fmtname>
 124:	da843703          	ld	a4,-600(s0)
 128:	d9c42683          	lw	a3,-612(s0)
 12c:	da041603          	lh	a2,-608(s0)
 130:	85aa                	mv	a1,a0
 132:	00001517          	auipc	a0,0x1
 136:	9de50513          	addi	a0,a0,-1570 # b10 <malloc+0x11a>
 13a:	00000097          	auipc	ra,0x0
 13e:	7fc080e7          	jalr	2044(ra) # 936 <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 142:	8526                	mv	a0,s1
 144:	00000097          	auipc	ra,0x0
 148:	484080e7          	jalr	1156(ra) # 5c8 <close>
}
 14c:	26813083          	ld	ra,616(sp)
 150:	26013403          	ld	s0,608(sp)
 154:	25813483          	ld	s1,600(sp)
 158:	25013903          	ld	s2,592(sp)
 15c:	24813983          	ld	s3,584(sp)
 160:	24013a03          	ld	s4,576(sp)
 164:	23813a83          	ld	s5,568(sp)
 168:	27010113          	addi	sp,sp,624
 16c:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
 16e:	864a                	mv	a2,s2
 170:	00001597          	auipc	a1,0x1
 174:	97058593          	addi	a1,a1,-1680 # ae0 <malloc+0xea>
 178:	4509                	li	a0,2
 17a:	00000097          	auipc	ra,0x0
 17e:	78e080e7          	jalr	1934(ra) # 908 <fprintf>
    return;
 182:	b7e9                	j	14c <ls+0x8e>
    fprintf(2, "ls: cannot stat %s\n", path);
 184:	864a                	mv	a2,s2
 186:	00001597          	auipc	a1,0x1
 18a:	97258593          	addi	a1,a1,-1678 # af8 <malloc+0x102>
 18e:	4509                	li	a0,2
 190:	00000097          	auipc	ra,0x0
 194:	778080e7          	jalr	1912(ra) # 908 <fprintf>
    close(fd);
 198:	8526                	mv	a0,s1
 19a:	00000097          	auipc	ra,0x0
 19e:	42e080e7          	jalr	1070(ra) # 5c8 <close>
    return;
 1a2:	b76d                	j	14c <ls+0x8e>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1a4:	854a                	mv	a0,s2
 1a6:	00000097          	auipc	ra,0x0
 1aa:	1a4080e7          	jalr	420(ra) # 34a <strlen>
 1ae:	2541                	addiw	a0,a0,16
 1b0:	20000793          	li	a5,512
 1b4:	00a7fb63          	bgeu	a5,a0,1ca <ls+0x10c>
      printf("ls: path too long\n");
 1b8:	00001517          	auipc	a0,0x1
 1bc:	96850513          	addi	a0,a0,-1688 # b20 <malloc+0x12a>
 1c0:	00000097          	auipc	ra,0x0
 1c4:	776080e7          	jalr	1910(ra) # 936 <printf>
      break;
 1c8:	bfad                	j	142 <ls+0x84>
    strcpy(buf, path);
 1ca:	85ca                	mv	a1,s2
 1cc:	dc040513          	addi	a0,s0,-576
 1d0:	00000097          	auipc	ra,0x0
 1d4:	12a080e7          	jalr	298(ra) # 2fa <strcpy>
    p = buf+strlen(buf);
 1d8:	dc040513          	addi	a0,s0,-576
 1dc:	00000097          	auipc	ra,0x0
 1e0:	16e080e7          	jalr	366(ra) # 34a <strlen>
 1e4:	1502                	slli	a0,a0,0x20
 1e6:	9101                	srli	a0,a0,0x20
 1e8:	dc040793          	addi	a5,s0,-576
 1ec:	00a78933          	add	s2,a5,a0
    *p++ = '/';
 1f0:	00190993          	addi	s3,s2,1
 1f4:	02f00793          	li	a5,47
 1f8:	00f90023          	sb	a5,0(s2)
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 1fc:	00001a17          	auipc	s4,0x1
 200:	93ca0a13          	addi	s4,s4,-1732 # b38 <malloc+0x142>
        printf("ls: cannot stat %s\n", buf);
 204:	00001a97          	auipc	s5,0x1
 208:	8f4a8a93          	addi	s5,s5,-1804 # af8 <malloc+0x102>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 20c:	a01d                	j	232 <ls+0x174>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 20e:	dc040513          	addi	a0,s0,-576
 212:	00000097          	auipc	ra,0x0
 216:	dee080e7          	jalr	-530(ra) # 0 <fmtname>
 21a:	da843703          	ld	a4,-600(s0)
 21e:	d9c42683          	lw	a3,-612(s0)
 222:	da041603          	lh	a2,-608(s0)
 226:	85aa                	mv	a1,a0
 228:	8552                	mv	a0,s4
 22a:	00000097          	auipc	ra,0x0
 22e:	70c080e7          	jalr	1804(ra) # 936 <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 232:	4641                	li	a2,16
 234:	db040593          	addi	a1,s0,-592
 238:	8526                	mv	a0,s1
 23a:	00000097          	auipc	ra,0x0
 23e:	37e080e7          	jalr	894(ra) # 5b8 <read>
 242:	47c1                	li	a5,16
 244:	eef51fe3          	bne	a0,a5,142 <ls+0x84>
      if(de.inum == 0)
 248:	db045783          	lhu	a5,-592(s0)
 24c:	d3fd                	beqz	a5,232 <ls+0x174>
      memmove(p, de.name, DIRSIZ);
 24e:	4639                	li	a2,14
 250:	db240593          	addi	a1,s0,-590
 254:	854e                	mv	a0,s3
 256:	00000097          	auipc	ra,0x0
 25a:	272080e7          	jalr	626(ra) # 4c8 <memmove>
      p[DIRSIZ] = 0;
 25e:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 262:	d9840593          	addi	a1,s0,-616
 266:	dc040513          	addi	a0,s0,-576
 26a:	00000097          	auipc	ra,0x0
 26e:	1ce080e7          	jalr	462(ra) # 438 <stat>
 272:	f8055ee3          	bgez	a0,20e <ls+0x150>
        printf("ls: cannot stat %s\n", buf);
 276:	dc040593          	addi	a1,s0,-576
 27a:	8556                	mv	a0,s5
 27c:	00000097          	auipc	ra,0x0
 280:	6ba080e7          	jalr	1722(ra) # 936 <printf>
        continue;
 284:	b77d                	j	232 <ls+0x174>

0000000000000286 <main>:

int
main(int argc, char *argv[])
{
 286:	1101                	addi	sp,sp,-32
 288:	ec06                	sd	ra,24(sp)
 28a:	e822                	sd	s0,16(sp)
 28c:	e426                	sd	s1,8(sp)
 28e:	e04a                	sd	s2,0(sp)
 290:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
 292:	4785                	li	a5,1
 294:	02a7d963          	bge	a5,a0,2c6 <main+0x40>
 298:	00858493          	addi	s1,a1,8
 29c:	ffe5091b          	addiw	s2,a0,-2
 2a0:	1902                	slli	s2,s2,0x20
 2a2:	02095913          	srli	s2,s2,0x20
 2a6:	090e                	slli	s2,s2,0x3
 2a8:	05c1                	addi	a1,a1,16
 2aa:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 2ac:	6088                	ld	a0,0(s1)
 2ae:	00000097          	auipc	ra,0x0
 2b2:	e10080e7          	jalr	-496(ra) # be <ls>
 2b6:	04a1                	addi	s1,s1,8
  for(i=1; i<argc; i++)
 2b8:	ff249ae3          	bne	s1,s2,2ac <main+0x26>
  exit(0);
 2bc:	4501                	li	a0,0
 2be:	00000097          	auipc	ra,0x0
 2c2:	2e2080e7          	jalr	738(ra) # 5a0 <exit>
    ls(".");
 2c6:	00001517          	auipc	a0,0x1
 2ca:	88250513          	addi	a0,a0,-1918 # b48 <malloc+0x152>
 2ce:	00000097          	auipc	ra,0x0
 2d2:	df0080e7          	jalr	-528(ra) # be <ls>
    exit(0);
 2d6:	4501                	li	a0,0
 2d8:	00000097          	auipc	ra,0x0
 2dc:	2c8080e7          	jalr	712(ra) # 5a0 <exit>

00000000000002e0 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 2e0:	1141                	addi	sp,sp,-16
 2e2:	e406                	sd	ra,8(sp)
 2e4:	e022                	sd	s0,0(sp)
 2e6:	0800                	addi	s0,sp,16
  extern int main();
  main();
 2e8:	00000097          	auipc	ra,0x0
 2ec:	f9e080e7          	jalr	-98(ra) # 286 <main>
  exit(0);
 2f0:	4501                	li	a0,0
 2f2:	00000097          	auipc	ra,0x0
 2f6:	2ae080e7          	jalr	686(ra) # 5a0 <exit>

00000000000002fa <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 2fa:	1141                	addi	sp,sp,-16
 2fc:	e422                	sd	s0,8(sp)
 2fe:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 300:	87aa                	mv	a5,a0
 302:	0585                	addi	a1,a1,1
 304:	0785                	addi	a5,a5,1
 306:	fff5c703          	lbu	a4,-1(a1)
 30a:	fee78fa3          	sb	a4,-1(a5)
 30e:	fb75                	bnez	a4,302 <strcpy+0x8>
    ;
  return os;
}
 310:	6422                	ld	s0,8(sp)
 312:	0141                	addi	sp,sp,16
 314:	8082                	ret

0000000000000316 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 316:	1141                	addi	sp,sp,-16
 318:	e422                	sd	s0,8(sp)
 31a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 31c:	00054783          	lbu	a5,0(a0)
 320:	cf91                	beqz	a5,33c <strcmp+0x26>
 322:	0005c703          	lbu	a4,0(a1)
 326:	00f71b63          	bne	a4,a5,33c <strcmp+0x26>
    p++, q++;
 32a:	0505                	addi	a0,a0,1
 32c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 32e:	00054783          	lbu	a5,0(a0)
 332:	c789                	beqz	a5,33c <strcmp+0x26>
 334:	0005c703          	lbu	a4,0(a1)
 338:	fef709e3          	beq	a4,a5,32a <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 33c:	0005c503          	lbu	a0,0(a1)
}
 340:	40a7853b          	subw	a0,a5,a0
 344:	6422                	ld	s0,8(sp)
 346:	0141                	addi	sp,sp,16
 348:	8082                	ret

000000000000034a <strlen>:

uint
strlen(const char *s)
{
 34a:	1141                	addi	sp,sp,-16
 34c:	e422                	sd	s0,8(sp)
 34e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 350:	00054783          	lbu	a5,0(a0)
 354:	cf91                	beqz	a5,370 <strlen+0x26>
 356:	0505                	addi	a0,a0,1
 358:	87aa                	mv	a5,a0
 35a:	4685                	li	a3,1
 35c:	9e89                	subw	a3,a3,a0
    ;
 35e:	00f6853b          	addw	a0,a3,a5
 362:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
 364:	fff7c703          	lbu	a4,-1(a5)
 368:	fb7d                	bnez	a4,35e <strlen+0x14>
  return n;
}
 36a:	6422                	ld	s0,8(sp)
 36c:	0141                	addi	sp,sp,16
 36e:	8082                	ret
  for(n = 0; s[n]; n++)
 370:	4501                	li	a0,0
 372:	bfe5                	j	36a <strlen+0x20>

0000000000000374 <memset>:

void*
memset(void *dst, int c, uint n)
{
 374:	1141                	addi	sp,sp,-16
 376:	e422                	sd	s0,8(sp)
 378:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 37a:	ce09                	beqz	a2,394 <memset+0x20>
 37c:	87aa                	mv	a5,a0
 37e:	fff6071b          	addiw	a4,a2,-1
 382:	1702                	slli	a4,a4,0x20
 384:	9301                	srli	a4,a4,0x20
 386:	0705                	addi	a4,a4,1
 388:	972a                	add	a4,a4,a0
    cdst[i] = c;
 38a:	00b78023          	sb	a1,0(a5)
 38e:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 390:	fee79de3          	bne	a5,a4,38a <memset+0x16>
  }
  return dst;
}
 394:	6422                	ld	s0,8(sp)
 396:	0141                	addi	sp,sp,16
 398:	8082                	ret

000000000000039a <strchr>:

char*
strchr(const char *s, char c)
{
 39a:	1141                	addi	sp,sp,-16
 39c:	e422                	sd	s0,8(sp)
 39e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 3a0:	00054783          	lbu	a5,0(a0)
 3a4:	cf91                	beqz	a5,3c0 <strchr+0x26>
    if(*s == c)
 3a6:	00f58a63          	beq	a1,a5,3ba <strchr+0x20>
  for(; *s; s++)
 3aa:	0505                	addi	a0,a0,1
 3ac:	00054783          	lbu	a5,0(a0)
 3b0:	c781                	beqz	a5,3b8 <strchr+0x1e>
    if(*s == c)
 3b2:	feb79ce3          	bne	a5,a1,3aa <strchr+0x10>
 3b6:	a011                	j	3ba <strchr+0x20>
      return (char*)s;
  return 0;
 3b8:	4501                	li	a0,0
}
 3ba:	6422                	ld	s0,8(sp)
 3bc:	0141                	addi	sp,sp,16
 3be:	8082                	ret
  return 0;
 3c0:	4501                	li	a0,0
 3c2:	bfe5                	j	3ba <strchr+0x20>

00000000000003c4 <gets>:

char*
gets(char *buf, int max)
{
 3c4:	711d                	addi	sp,sp,-96
 3c6:	ec86                	sd	ra,88(sp)
 3c8:	e8a2                	sd	s0,80(sp)
 3ca:	e4a6                	sd	s1,72(sp)
 3cc:	e0ca                	sd	s2,64(sp)
 3ce:	fc4e                	sd	s3,56(sp)
 3d0:	f852                	sd	s4,48(sp)
 3d2:	f456                	sd	s5,40(sp)
 3d4:	f05a                	sd	s6,32(sp)
 3d6:	ec5e                	sd	s7,24(sp)
 3d8:	1080                	addi	s0,sp,96
 3da:	8baa                	mv	s7,a0
 3dc:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3de:	892a                	mv	s2,a0
 3e0:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3e2:	4aa9                	li	s5,10
 3e4:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3e6:	0019849b          	addiw	s1,s3,1
 3ea:	0344d863          	bge	s1,s4,41a <gets+0x56>
    cc = read(0, &c, 1);
 3ee:	4605                	li	a2,1
 3f0:	faf40593          	addi	a1,s0,-81
 3f4:	4501                	li	a0,0
 3f6:	00000097          	auipc	ra,0x0
 3fa:	1c2080e7          	jalr	450(ra) # 5b8 <read>
    if(cc < 1)
 3fe:	00a05e63          	blez	a0,41a <gets+0x56>
    buf[i++] = c;
 402:	faf44783          	lbu	a5,-81(s0)
 406:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 40a:	01578763          	beq	a5,s5,418 <gets+0x54>
 40e:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 410:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 412:	fd679ae3          	bne	a5,s6,3e6 <gets+0x22>
 416:	a011                	j	41a <gets+0x56>
  for(i=0; i+1 < max; ){
 418:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 41a:	99de                	add	s3,s3,s7
 41c:	00098023          	sb	zero,0(s3)
  return buf;
}
 420:	855e                	mv	a0,s7
 422:	60e6                	ld	ra,88(sp)
 424:	6446                	ld	s0,80(sp)
 426:	64a6                	ld	s1,72(sp)
 428:	6906                	ld	s2,64(sp)
 42a:	79e2                	ld	s3,56(sp)
 42c:	7a42                	ld	s4,48(sp)
 42e:	7aa2                	ld	s5,40(sp)
 430:	7b02                	ld	s6,32(sp)
 432:	6be2                	ld	s7,24(sp)
 434:	6125                	addi	sp,sp,96
 436:	8082                	ret

0000000000000438 <stat>:

int
stat(const char *n, struct stat *st)
{
 438:	1101                	addi	sp,sp,-32
 43a:	ec06                	sd	ra,24(sp)
 43c:	e822                	sd	s0,16(sp)
 43e:	e426                	sd	s1,8(sp)
 440:	e04a                	sd	s2,0(sp)
 442:	1000                	addi	s0,sp,32
 444:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 446:	4581                	li	a1,0
 448:	00000097          	auipc	ra,0x0
 44c:	198080e7          	jalr	408(ra) # 5e0 <open>
  if(fd < 0)
 450:	02054563          	bltz	a0,47a <stat+0x42>
 454:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 456:	85ca                	mv	a1,s2
 458:	00000097          	auipc	ra,0x0
 45c:	1a0080e7          	jalr	416(ra) # 5f8 <fstat>
 460:	892a                	mv	s2,a0
  close(fd);
 462:	8526                	mv	a0,s1
 464:	00000097          	auipc	ra,0x0
 468:	164080e7          	jalr	356(ra) # 5c8 <close>
  return r;
}
 46c:	854a                	mv	a0,s2
 46e:	60e2                	ld	ra,24(sp)
 470:	6442                	ld	s0,16(sp)
 472:	64a2                	ld	s1,8(sp)
 474:	6902                	ld	s2,0(sp)
 476:	6105                	addi	sp,sp,32
 478:	8082                	ret
    return -1;
 47a:	597d                	li	s2,-1
 47c:	bfc5                	j	46c <stat+0x34>

000000000000047e <atoi>:

int
atoi(const char *s)
{
 47e:	1141                	addi	sp,sp,-16
 480:	e422                	sd	s0,8(sp)
 482:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 484:	00054683          	lbu	a3,0(a0)
 488:	fd06879b          	addiw	a5,a3,-48
 48c:	0ff7f793          	andi	a5,a5,255
 490:	4725                	li	a4,9
 492:	02f76963          	bltu	a4,a5,4c4 <atoi+0x46>
 496:	862a                	mv	a2,a0
  n = 0;
 498:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 49a:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 49c:	0605                	addi	a2,a2,1
 49e:	0025179b          	slliw	a5,a0,0x2
 4a2:	9fa9                	addw	a5,a5,a0
 4a4:	0017979b          	slliw	a5,a5,0x1
 4a8:	9fb5                	addw	a5,a5,a3
 4aa:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4ae:	00064683          	lbu	a3,0(a2)
 4b2:	fd06871b          	addiw	a4,a3,-48
 4b6:	0ff77713          	andi	a4,a4,255
 4ba:	fee5f1e3          	bgeu	a1,a4,49c <atoi+0x1e>
  return n;
}
 4be:	6422                	ld	s0,8(sp)
 4c0:	0141                	addi	sp,sp,16
 4c2:	8082                	ret
  n = 0;
 4c4:	4501                	li	a0,0
 4c6:	bfe5                	j	4be <atoi+0x40>

00000000000004c8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4c8:	1141                	addi	sp,sp,-16
 4ca:	e422                	sd	s0,8(sp)
 4cc:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4ce:	02b57663          	bgeu	a0,a1,4fa <memmove+0x32>
    while(n-- > 0)
 4d2:	02c05163          	blez	a2,4f4 <memmove+0x2c>
 4d6:	fff6079b          	addiw	a5,a2,-1
 4da:	1782                	slli	a5,a5,0x20
 4dc:	9381                	srli	a5,a5,0x20
 4de:	0785                	addi	a5,a5,1
 4e0:	97aa                	add	a5,a5,a0
  dst = vdst;
 4e2:	872a                	mv	a4,a0
      *dst++ = *src++;
 4e4:	0585                	addi	a1,a1,1
 4e6:	0705                	addi	a4,a4,1
 4e8:	fff5c683          	lbu	a3,-1(a1)
 4ec:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4f0:	fee79ae3          	bne	a5,a4,4e4 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4f4:	6422                	ld	s0,8(sp)
 4f6:	0141                	addi	sp,sp,16
 4f8:	8082                	ret
    dst += n;
 4fa:	00c50733          	add	a4,a0,a2
    src += n;
 4fe:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 500:	fec05ae3          	blez	a2,4f4 <memmove+0x2c>
 504:	fff6079b          	addiw	a5,a2,-1
 508:	1782                	slli	a5,a5,0x20
 50a:	9381                	srli	a5,a5,0x20
 50c:	fff7c793          	not	a5,a5
 510:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 512:	15fd                	addi	a1,a1,-1
 514:	177d                	addi	a4,a4,-1
 516:	0005c683          	lbu	a3,0(a1)
 51a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 51e:	fef71ae3          	bne	a4,a5,512 <memmove+0x4a>
 522:	bfc9                	j	4f4 <memmove+0x2c>

0000000000000524 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 524:	1141                	addi	sp,sp,-16
 526:	e422                	sd	s0,8(sp)
 528:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 52a:	ce15                	beqz	a2,566 <memcmp+0x42>
 52c:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 530:	00054783          	lbu	a5,0(a0)
 534:	0005c703          	lbu	a4,0(a1)
 538:	02e79063          	bne	a5,a4,558 <memcmp+0x34>
 53c:	1682                	slli	a3,a3,0x20
 53e:	9281                	srli	a3,a3,0x20
 540:	0685                	addi	a3,a3,1
 542:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 544:	0505                	addi	a0,a0,1
    p2++;
 546:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 548:	00d50d63          	beq	a0,a3,562 <memcmp+0x3e>
    if (*p1 != *p2) {
 54c:	00054783          	lbu	a5,0(a0)
 550:	0005c703          	lbu	a4,0(a1)
 554:	fee788e3          	beq	a5,a4,544 <memcmp+0x20>
      return *p1 - *p2;
 558:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 55c:	6422                	ld	s0,8(sp)
 55e:	0141                	addi	sp,sp,16
 560:	8082                	ret
  return 0;
 562:	4501                	li	a0,0
 564:	bfe5                	j	55c <memcmp+0x38>
 566:	4501                	li	a0,0
 568:	bfd5                	j	55c <memcmp+0x38>

000000000000056a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 56a:	1141                	addi	sp,sp,-16
 56c:	e406                	sd	ra,8(sp)
 56e:	e022                	sd	s0,0(sp)
 570:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 572:	00000097          	auipc	ra,0x0
 576:	f56080e7          	jalr	-170(ra) # 4c8 <memmove>
}
 57a:	60a2                	ld	ra,8(sp)
 57c:	6402                	ld	s0,0(sp)
 57e:	0141                	addi	sp,sp,16
 580:	8082                	ret

0000000000000582 <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 582:	1141                	addi	sp,sp,-16
 584:	e422                	sd	s0,8(sp)
 586:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 588:	040007b7          	lui	a5,0x4000
}
 58c:	17f5                	addi	a5,a5,-3
 58e:	07b2                	slli	a5,a5,0xc
 590:	4388                	lw	a0,0(a5)
 592:	6422                	ld	s0,8(sp)
 594:	0141                	addi	sp,sp,16
 596:	8082                	ret

0000000000000598 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 598:	4885                	li	a7,1
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5a0:	4889                	li	a7,2
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5a8:	488d                	li	a7,3
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5b0:	4891                	li	a7,4
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <read>:
.global read
read:
 li a7, SYS_read
 5b8:	4895                	li	a7,5
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <write>:
.global write
write:
 li a7, SYS_write
 5c0:	48c1                	li	a7,16
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <close>:
.global close
close:
 li a7, SYS_close
 5c8:	48d5                	li	a7,21
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5d0:	4899                	li	a7,6
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5d8:	489d                	li	a7,7
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <open>:
.global open
open:
 li a7, SYS_open
 5e0:	48bd                	li	a7,15
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5e8:	48c5                	li	a7,17
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5f0:	48c9                	li	a7,18
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5f8:	48a1                	li	a7,8
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <link>:
.global link
link:
 li a7, SYS_link
 600:	48cd                	li	a7,19
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 608:	48d1                	li	a7,20
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 610:	48a5                	li	a7,9
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <dup>:
.global dup
dup:
 li a7, SYS_dup
 618:	48a9                	li	a7,10
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 620:	48ad                	li	a7,11
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 628:	48b1                	li	a7,12
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 630:	48b5                	li	a7,13
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 638:	48b9                	li	a7,14
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <trace>:
.global trace
trace:
 li a7, SYS_trace
 640:	48d9                	li	a7,22
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 648:	48dd                	li	a7,23
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <connect>:
.global connect
connect:
 li a7, SYS_connect
 650:	48f5                	li	a7,29
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 658:	48f9                	li	a7,30
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 660:	1101                	addi	sp,sp,-32
 662:	ec06                	sd	ra,24(sp)
 664:	e822                	sd	s0,16(sp)
 666:	1000                	addi	s0,sp,32
 668:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 66c:	4605                	li	a2,1
 66e:	fef40593          	addi	a1,s0,-17
 672:	00000097          	auipc	ra,0x0
 676:	f4e080e7          	jalr	-178(ra) # 5c0 <write>
}
 67a:	60e2                	ld	ra,24(sp)
 67c:	6442                	ld	s0,16(sp)
 67e:	6105                	addi	sp,sp,32
 680:	8082                	ret

0000000000000682 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 682:	7139                	addi	sp,sp,-64
 684:	fc06                	sd	ra,56(sp)
 686:	f822                	sd	s0,48(sp)
 688:	f426                	sd	s1,40(sp)
 68a:	f04a                	sd	s2,32(sp)
 68c:	ec4e                	sd	s3,24(sp)
 68e:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 690:	c299                	beqz	a3,696 <printint+0x14>
 692:	0005cd63          	bltz	a1,6ac <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 696:	2581                	sext.w	a1,a1
  neg = 0;
 698:	4301                	li	t1,0
 69a:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 69e:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 6a0:	2601                	sext.w	a2,a2
 6a2:	00000897          	auipc	a7,0x0
 6a6:	4ae88893          	addi	a7,a7,1198 # b50 <digits>
 6aa:	a039                	j	6b8 <printint+0x36>
    x = -xx;
 6ac:	40b005bb          	negw	a1,a1
    neg = 1;
 6b0:	4305                	li	t1,1
    x = -xx;
 6b2:	b7e5                	j	69a <printint+0x18>
  }while((x /= base) != 0);
 6b4:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 6b6:	8836                	mv	a6,a3
 6b8:	0018069b          	addiw	a3,a6,1
 6bc:	02c5f7bb          	remuw	a5,a1,a2
 6c0:	1782                	slli	a5,a5,0x20
 6c2:	9381                	srli	a5,a5,0x20
 6c4:	97c6                	add	a5,a5,a7
 6c6:	0007c783          	lbu	a5,0(a5) # 4000000 <base+0x3ffefe0>
 6ca:	00f70023          	sb	a5,0(a4)
 6ce:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 6d0:	02c5d7bb          	divuw	a5,a1,a2
 6d4:	fec5f0e3          	bgeu	a1,a2,6b4 <printint+0x32>
  if(neg)
 6d8:	00030b63          	beqz	t1,6ee <printint+0x6c>
    buf[i++] = '-';
 6dc:	fd040793          	addi	a5,s0,-48
 6e0:	96be                	add	a3,a3,a5
 6e2:	02d00793          	li	a5,45
 6e6:	fef68823          	sb	a5,-16(a3)
 6ea:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 6ee:	02d05963          	blez	a3,720 <printint+0x9e>
 6f2:	89aa                	mv	s3,a0
 6f4:	fc040793          	addi	a5,s0,-64
 6f8:	00d784b3          	add	s1,a5,a3
 6fc:	fff78913          	addi	s2,a5,-1
 700:	9936                	add	s2,s2,a3
 702:	36fd                	addiw	a3,a3,-1
 704:	1682                	slli	a3,a3,0x20
 706:	9281                	srli	a3,a3,0x20
 708:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 70c:	fff4c583          	lbu	a1,-1(s1)
 710:	854e                	mv	a0,s3
 712:	00000097          	auipc	ra,0x0
 716:	f4e080e7          	jalr	-178(ra) # 660 <putc>
 71a:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 71c:	ff2498e3          	bne	s1,s2,70c <printint+0x8a>
}
 720:	70e2                	ld	ra,56(sp)
 722:	7442                	ld	s0,48(sp)
 724:	74a2                	ld	s1,40(sp)
 726:	7902                	ld	s2,32(sp)
 728:	69e2                	ld	s3,24(sp)
 72a:	6121                	addi	sp,sp,64
 72c:	8082                	ret

000000000000072e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 72e:	7119                	addi	sp,sp,-128
 730:	fc86                	sd	ra,120(sp)
 732:	f8a2                	sd	s0,112(sp)
 734:	f4a6                	sd	s1,104(sp)
 736:	f0ca                	sd	s2,96(sp)
 738:	ecce                	sd	s3,88(sp)
 73a:	e8d2                	sd	s4,80(sp)
 73c:	e4d6                	sd	s5,72(sp)
 73e:	e0da                	sd	s6,64(sp)
 740:	fc5e                	sd	s7,56(sp)
 742:	f862                	sd	s8,48(sp)
 744:	f466                	sd	s9,40(sp)
 746:	f06a                	sd	s10,32(sp)
 748:	ec6e                	sd	s11,24(sp)
 74a:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 74c:	0005c483          	lbu	s1,0(a1)
 750:	18048d63          	beqz	s1,8ea <vprintf+0x1bc>
 754:	8aaa                	mv	s5,a0
 756:	8b32                	mv	s6,a2
 758:	00158913          	addi	s2,a1,1
  state = 0;
 75c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 75e:	02500a13          	li	s4,37
      if(c == 'd'){
 762:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 766:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 76a:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 76e:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 772:	00000b97          	auipc	s7,0x0
 776:	3deb8b93          	addi	s7,s7,990 # b50 <digits>
 77a:	a839                	j	798 <vprintf+0x6a>
        putc(fd, c);
 77c:	85a6                	mv	a1,s1
 77e:	8556                	mv	a0,s5
 780:	00000097          	auipc	ra,0x0
 784:	ee0080e7          	jalr	-288(ra) # 660 <putc>
 788:	a019                	j	78e <vprintf+0x60>
    } else if(state == '%'){
 78a:	01498f63          	beq	s3,s4,7a8 <vprintf+0x7a>
 78e:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 790:	fff94483          	lbu	s1,-1(s2)
 794:	14048b63          	beqz	s1,8ea <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 798:	0004879b          	sext.w	a5,s1
    if(state == 0){
 79c:	fe0997e3          	bnez	s3,78a <vprintf+0x5c>
      if(c == '%'){
 7a0:	fd479ee3          	bne	a5,s4,77c <vprintf+0x4e>
        state = '%';
 7a4:	89be                	mv	s3,a5
 7a6:	b7e5                	j	78e <vprintf+0x60>
      if(c == 'd'){
 7a8:	05878063          	beq	a5,s8,7e8 <vprintf+0xba>
      } else if(c == 'l') {
 7ac:	05978c63          	beq	a5,s9,804 <vprintf+0xd6>
      } else if(c == 'x') {
 7b0:	07a78863          	beq	a5,s10,820 <vprintf+0xf2>
      } else if(c == 'p') {
 7b4:	09b78463          	beq	a5,s11,83c <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 7b8:	07300713          	li	a4,115
 7bc:	0ce78563          	beq	a5,a4,886 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7c0:	06300713          	li	a4,99
 7c4:	0ee78c63          	beq	a5,a4,8bc <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 7c8:	11478663          	beq	a5,s4,8d4 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7cc:	85d2                	mv	a1,s4
 7ce:	8556                	mv	a0,s5
 7d0:	00000097          	auipc	ra,0x0
 7d4:	e90080e7          	jalr	-368(ra) # 660 <putc>
        putc(fd, c);
 7d8:	85a6                	mv	a1,s1
 7da:	8556                	mv	a0,s5
 7dc:	00000097          	auipc	ra,0x0
 7e0:	e84080e7          	jalr	-380(ra) # 660 <putc>
      }
      state = 0;
 7e4:	4981                	li	s3,0
 7e6:	b765                	j	78e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 7e8:	008b0493          	addi	s1,s6,8
 7ec:	4685                	li	a3,1
 7ee:	4629                	li	a2,10
 7f0:	000b2583          	lw	a1,0(s6)
 7f4:	8556                	mv	a0,s5
 7f6:	00000097          	auipc	ra,0x0
 7fa:	e8c080e7          	jalr	-372(ra) # 682 <printint>
 7fe:	8b26                	mv	s6,s1
      state = 0;
 800:	4981                	li	s3,0
 802:	b771                	j	78e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 804:	008b0493          	addi	s1,s6,8
 808:	4681                	li	a3,0
 80a:	4629                	li	a2,10
 80c:	000b2583          	lw	a1,0(s6)
 810:	8556                	mv	a0,s5
 812:	00000097          	auipc	ra,0x0
 816:	e70080e7          	jalr	-400(ra) # 682 <printint>
 81a:	8b26                	mv	s6,s1
      state = 0;
 81c:	4981                	li	s3,0
 81e:	bf85                	j	78e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 820:	008b0493          	addi	s1,s6,8
 824:	4681                	li	a3,0
 826:	4641                	li	a2,16
 828:	000b2583          	lw	a1,0(s6)
 82c:	8556                	mv	a0,s5
 82e:	00000097          	auipc	ra,0x0
 832:	e54080e7          	jalr	-428(ra) # 682 <printint>
 836:	8b26                	mv	s6,s1
      state = 0;
 838:	4981                	li	s3,0
 83a:	bf91                	j	78e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 83c:	008b0793          	addi	a5,s6,8
 840:	f8f43423          	sd	a5,-120(s0)
 844:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 848:	03000593          	li	a1,48
 84c:	8556                	mv	a0,s5
 84e:	00000097          	auipc	ra,0x0
 852:	e12080e7          	jalr	-494(ra) # 660 <putc>
  putc(fd, 'x');
 856:	85ea                	mv	a1,s10
 858:	8556                	mv	a0,s5
 85a:	00000097          	auipc	ra,0x0
 85e:	e06080e7          	jalr	-506(ra) # 660 <putc>
 862:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 864:	03c9d793          	srli	a5,s3,0x3c
 868:	97de                	add	a5,a5,s7
 86a:	0007c583          	lbu	a1,0(a5)
 86e:	8556                	mv	a0,s5
 870:	00000097          	auipc	ra,0x0
 874:	df0080e7          	jalr	-528(ra) # 660 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 878:	0992                	slli	s3,s3,0x4
 87a:	34fd                	addiw	s1,s1,-1
 87c:	f4e5                	bnez	s1,864 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 87e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 882:	4981                	li	s3,0
 884:	b729                	j	78e <vprintf+0x60>
        s = va_arg(ap, char*);
 886:	008b0993          	addi	s3,s6,8
 88a:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 88e:	c085                	beqz	s1,8ae <vprintf+0x180>
        while(*s != 0){
 890:	0004c583          	lbu	a1,0(s1)
 894:	c9a1                	beqz	a1,8e4 <vprintf+0x1b6>
          putc(fd, *s);
 896:	8556                	mv	a0,s5
 898:	00000097          	auipc	ra,0x0
 89c:	dc8080e7          	jalr	-568(ra) # 660 <putc>
          s++;
 8a0:	0485                	addi	s1,s1,1
        while(*s != 0){
 8a2:	0004c583          	lbu	a1,0(s1)
 8a6:	f9e5                	bnez	a1,896 <vprintf+0x168>
        s = va_arg(ap, char*);
 8a8:	8b4e                	mv	s6,s3
      state = 0;
 8aa:	4981                	li	s3,0
 8ac:	b5cd                	j	78e <vprintf+0x60>
          s = "(null)";
 8ae:	00000497          	auipc	s1,0x0
 8b2:	2ba48493          	addi	s1,s1,698 # b68 <digits+0x18>
        while(*s != 0){
 8b6:	02800593          	li	a1,40
 8ba:	bff1                	j	896 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 8bc:	008b0493          	addi	s1,s6,8
 8c0:	000b4583          	lbu	a1,0(s6)
 8c4:	8556                	mv	a0,s5
 8c6:	00000097          	auipc	ra,0x0
 8ca:	d9a080e7          	jalr	-614(ra) # 660 <putc>
 8ce:	8b26                	mv	s6,s1
      state = 0;
 8d0:	4981                	li	s3,0
 8d2:	bd75                	j	78e <vprintf+0x60>
        putc(fd, c);
 8d4:	85d2                	mv	a1,s4
 8d6:	8556                	mv	a0,s5
 8d8:	00000097          	auipc	ra,0x0
 8dc:	d88080e7          	jalr	-632(ra) # 660 <putc>
      state = 0;
 8e0:	4981                	li	s3,0
 8e2:	b575                	j	78e <vprintf+0x60>
        s = va_arg(ap, char*);
 8e4:	8b4e                	mv	s6,s3
      state = 0;
 8e6:	4981                	li	s3,0
 8e8:	b55d                	j	78e <vprintf+0x60>
    }
  }
}
 8ea:	70e6                	ld	ra,120(sp)
 8ec:	7446                	ld	s0,112(sp)
 8ee:	74a6                	ld	s1,104(sp)
 8f0:	7906                	ld	s2,96(sp)
 8f2:	69e6                	ld	s3,88(sp)
 8f4:	6a46                	ld	s4,80(sp)
 8f6:	6aa6                	ld	s5,72(sp)
 8f8:	6b06                	ld	s6,64(sp)
 8fa:	7be2                	ld	s7,56(sp)
 8fc:	7c42                	ld	s8,48(sp)
 8fe:	7ca2                	ld	s9,40(sp)
 900:	7d02                	ld	s10,32(sp)
 902:	6de2                	ld	s11,24(sp)
 904:	6109                	addi	sp,sp,128
 906:	8082                	ret

0000000000000908 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 908:	715d                	addi	sp,sp,-80
 90a:	ec06                	sd	ra,24(sp)
 90c:	e822                	sd	s0,16(sp)
 90e:	1000                	addi	s0,sp,32
 910:	e010                	sd	a2,0(s0)
 912:	e414                	sd	a3,8(s0)
 914:	e818                	sd	a4,16(s0)
 916:	ec1c                	sd	a5,24(s0)
 918:	03043023          	sd	a6,32(s0)
 91c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 920:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 924:	8622                	mv	a2,s0
 926:	00000097          	auipc	ra,0x0
 92a:	e08080e7          	jalr	-504(ra) # 72e <vprintf>
}
 92e:	60e2                	ld	ra,24(sp)
 930:	6442                	ld	s0,16(sp)
 932:	6161                	addi	sp,sp,80
 934:	8082                	ret

0000000000000936 <printf>:

void
printf(const char *fmt, ...)
{
 936:	711d                	addi	sp,sp,-96
 938:	ec06                	sd	ra,24(sp)
 93a:	e822                	sd	s0,16(sp)
 93c:	1000                	addi	s0,sp,32
 93e:	e40c                	sd	a1,8(s0)
 940:	e810                	sd	a2,16(s0)
 942:	ec14                	sd	a3,24(s0)
 944:	f018                	sd	a4,32(s0)
 946:	f41c                	sd	a5,40(s0)
 948:	03043823          	sd	a6,48(s0)
 94c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 950:	00840613          	addi	a2,s0,8
 954:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 958:	85aa                	mv	a1,a0
 95a:	4505                	li	a0,1
 95c:	00000097          	auipc	ra,0x0
 960:	dd2080e7          	jalr	-558(ra) # 72e <vprintf>
}
 964:	60e2                	ld	ra,24(sp)
 966:	6442                	ld	s0,16(sp)
 968:	6125                	addi	sp,sp,96
 96a:	8082                	ret

000000000000096c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 96c:	1141                	addi	sp,sp,-16
 96e:	e422                	sd	s0,8(sp)
 970:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 972:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 976:	00000797          	auipc	a5,0x0
 97a:	68a78793          	addi	a5,a5,1674 # 1000 <freep>
 97e:	639c                	ld	a5,0(a5)
 980:	a805                	j	9b0 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 982:	4618                	lw	a4,8(a2)
 984:	9db9                	addw	a1,a1,a4
 986:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 98a:	6398                	ld	a4,0(a5)
 98c:	6318                	ld	a4,0(a4)
 98e:	fee53823          	sd	a4,-16(a0)
 992:	a091                	j	9d6 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 994:	ff852703          	lw	a4,-8(a0)
 998:	9e39                	addw	a2,a2,a4
 99a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 99c:	ff053703          	ld	a4,-16(a0)
 9a0:	e398                	sd	a4,0(a5)
 9a2:	a099                	j	9e8 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9a4:	6398                	ld	a4,0(a5)
 9a6:	00e7e463          	bltu	a5,a4,9ae <free+0x42>
 9aa:	00e6ea63          	bltu	a3,a4,9be <free+0x52>
{
 9ae:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9b0:	fed7fae3          	bgeu	a5,a3,9a4 <free+0x38>
 9b4:	6398                	ld	a4,0(a5)
 9b6:	00e6e463          	bltu	a3,a4,9be <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9ba:	fee7eae3          	bltu	a5,a4,9ae <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 9be:	ff852583          	lw	a1,-8(a0)
 9c2:	6390                	ld	a2,0(a5)
 9c4:	02059713          	slli	a4,a1,0x20
 9c8:	9301                	srli	a4,a4,0x20
 9ca:	0712                	slli	a4,a4,0x4
 9cc:	9736                	add	a4,a4,a3
 9ce:	fae60ae3          	beq	a2,a4,982 <free+0x16>
    bp->s.ptr = p->s.ptr;
 9d2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9d6:	4790                	lw	a2,8(a5)
 9d8:	02061713          	slli	a4,a2,0x20
 9dc:	9301                	srli	a4,a4,0x20
 9de:	0712                	slli	a4,a4,0x4
 9e0:	973e                	add	a4,a4,a5
 9e2:	fae689e3          	beq	a3,a4,994 <free+0x28>
  } else
    p->s.ptr = bp;
 9e6:	e394                	sd	a3,0(a5)
  freep = p;
 9e8:	00000717          	auipc	a4,0x0
 9ec:	60f73c23          	sd	a5,1560(a4) # 1000 <freep>
}
 9f0:	6422                	ld	s0,8(sp)
 9f2:	0141                	addi	sp,sp,16
 9f4:	8082                	ret

00000000000009f6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9f6:	7139                	addi	sp,sp,-64
 9f8:	fc06                	sd	ra,56(sp)
 9fa:	f822                	sd	s0,48(sp)
 9fc:	f426                	sd	s1,40(sp)
 9fe:	f04a                	sd	s2,32(sp)
 a00:	ec4e                	sd	s3,24(sp)
 a02:	e852                	sd	s4,16(sp)
 a04:	e456                	sd	s5,8(sp)
 a06:	e05a                	sd	s6,0(sp)
 a08:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a0a:	02051993          	slli	s3,a0,0x20
 a0e:	0209d993          	srli	s3,s3,0x20
 a12:	09bd                	addi	s3,s3,15
 a14:	0049d993          	srli	s3,s3,0x4
 a18:	2985                	addiw	s3,s3,1
 a1a:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 a1e:	00000797          	auipc	a5,0x0
 a22:	5e278793          	addi	a5,a5,1506 # 1000 <freep>
 a26:	6388                	ld	a0,0(a5)
 a28:	c515                	beqz	a0,a54 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a2a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a2c:	4798                	lw	a4,8(a5)
 a2e:	03277f63          	bgeu	a4,s2,a6c <malloc+0x76>
 a32:	8a4e                	mv	s4,s3
 a34:	0009871b          	sext.w	a4,s3
 a38:	6685                	lui	a3,0x1
 a3a:	00d77363          	bgeu	a4,a3,a40 <malloc+0x4a>
 a3e:	6a05                	lui	s4,0x1
 a40:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 a44:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a48:	00000497          	auipc	s1,0x0
 a4c:	5b848493          	addi	s1,s1,1464 # 1000 <freep>
  if(p == (char*)-1)
 a50:	5b7d                	li	s6,-1
 a52:	a885                	j	ac2 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 a54:	00000797          	auipc	a5,0x0
 a58:	5cc78793          	addi	a5,a5,1484 # 1020 <base>
 a5c:	00000717          	auipc	a4,0x0
 a60:	5af73223          	sd	a5,1444(a4) # 1000 <freep>
 a64:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a66:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a6a:	b7e1                	j	a32 <malloc+0x3c>
      if(p->s.size == nunits)
 a6c:	02e90b63          	beq	s2,a4,aa2 <malloc+0xac>
        p->s.size -= nunits;
 a70:	4137073b          	subw	a4,a4,s3
 a74:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a76:	1702                	slli	a4,a4,0x20
 a78:	9301                	srli	a4,a4,0x20
 a7a:	0712                	slli	a4,a4,0x4
 a7c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a7e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a82:	00000717          	auipc	a4,0x0
 a86:	56a73f23          	sd	a0,1406(a4) # 1000 <freep>
      return (void*)(p + 1);
 a8a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a8e:	70e2                	ld	ra,56(sp)
 a90:	7442                	ld	s0,48(sp)
 a92:	74a2                	ld	s1,40(sp)
 a94:	7902                	ld	s2,32(sp)
 a96:	69e2                	ld	s3,24(sp)
 a98:	6a42                	ld	s4,16(sp)
 a9a:	6aa2                	ld	s5,8(sp)
 a9c:	6b02                	ld	s6,0(sp)
 a9e:	6121                	addi	sp,sp,64
 aa0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 aa2:	6398                	ld	a4,0(a5)
 aa4:	e118                	sd	a4,0(a0)
 aa6:	bff1                	j	a82 <malloc+0x8c>
  hp->s.size = nu;
 aa8:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 aac:	0541                	addi	a0,a0,16
 aae:	00000097          	auipc	ra,0x0
 ab2:	ebe080e7          	jalr	-322(ra) # 96c <free>
  return freep;
 ab6:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 ab8:	d979                	beqz	a0,a8e <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aba:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 abc:	4798                	lw	a4,8(a5)
 abe:	fb2777e3          	bgeu	a4,s2,a6c <malloc+0x76>
    if(p == freep)
 ac2:	6098                	ld	a4,0(s1)
 ac4:	853e                	mv	a0,a5
 ac6:	fef71ae3          	bne	a4,a5,aba <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 aca:	8552                	mv	a0,s4
 acc:	00000097          	auipc	ra,0x0
 ad0:	b5c080e7          	jalr	-1188(ra) # 628 <sbrk>
  if(p == (char*)-1)
 ad4:	fd651ae3          	bne	a0,s6,aa8 <malloc+0xb2>
        return 0;
 ad8:	4501                	li	a0,0
 ada:	bf55                	j	a8e <malloc+0x98>
