
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <find>:
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

void find(char *path, char *target)
{
   0:	d8010113          	addi	sp,sp,-640
   4:	26113c23          	sd	ra,632(sp)
   8:	26813823          	sd	s0,624(sp)
   c:	26913423          	sd	s1,616(sp)
  10:	27213023          	sd	s2,608(sp)
  14:	25313c23          	sd	s3,600(sp)
  18:	25413823          	sd	s4,592(sp)
  1c:	25513423          	sd	s5,584(sp)
  20:	25613023          	sd	s6,576(sp)
  24:	23713c23          	sd	s7,568(sp)
  28:	0500                	addi	s0,sp,640
  2a:	84aa                	mv	s1,a0
  2c:	89ae                	mv	s3,a1
    char *filename, *p1;
    int fd;
    struct dirent de;
    struct stat st;

    if ((fd = open(path, 0)) < 0) {
  2e:	4581                	li	a1,0
  30:	00000097          	auipc	ra,0x0
  34:	546080e7          	jalr	1350(ra) # 576 <open>
  38:	08054f63          	bltz	a0,d6 <find+0xd6>
  3c:	892a                	mv	s2,a0
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }
    if (fstat(fd, &st) < 0) {
  3e:	d8840593          	addi	a1,s0,-632
  42:	00000097          	auipc	ra,0x0
  46:	54c080e7          	jalr	1356(ra) # 58e <fstat>
  4a:	0a054163          	bltz	a0,ec <find+0xec>
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return;
    }

    switch (st.type)
  4e:	d9041783          	lh	a5,-624(s0)
  52:	0007869b          	sext.w	a3,a5
  56:	4705                	li	a4,1
  58:	0ce68463          	beq	a3,a4,120 <find+0x120>
  5c:	4709                	li	a4,2
  5e:	04e69263          	bne	a3,a4,a2 <find+0xa2>
    {
    case T_FILE:
        /* Split the file name from path */
        /* End to begin */
        p1 = path + strlen(path);
  62:	8526                	mv	a0,s1
  64:	00000097          	auipc	ra,0x0
  68:	27c080e7          	jalr	636(ra) # 2e0 <strlen>
  6c:	1502                	slli	a0,a0,0x20
  6e:	9101                	srli	a0,a0,0x20
  70:	9526                	add	a0,a0,s1
        while (p1 >= path && *p1 != '/') {
  72:	02956163          	bltu	a0,s1,94 <find+0x94>
  76:	00054703          	lbu	a4,0(a0)
  7a:	02f00793          	li	a5,47
  7e:	00f70b63          	beq	a4,a5,94 <find+0x94>
  82:	02f00713          	li	a4,47
            p1--;
  86:	157d                	addi	a0,a0,-1
        while (p1 >= path && *p1 != '/') {
  88:	00956663          	bltu	a0,s1,94 <find+0x94>
  8c:	00054783          	lbu	a5,0(a0)
  90:	fee79be3          	bne	a5,a4,86 <find+0x86>
        }
        filename = ++p1;
        /* Check if current file is target */
        if (strcmp(filename, target) == 0)
  94:	85ce                	mv	a1,s3
  96:	0505                	addi	a0,a0,1
  98:	00000097          	auipc	ra,0x0
  9c:	214080e7          	jalr	532(ra) # 2ac <strcmp>
  a0:	c535                	beqz	a0,10c <find+0x10c>
                printf("%s\n", buf);
            find(buf, target);
        }
        break;
    }
    close(fd);
  a2:	854a                	mv	a0,s2
  a4:	00000097          	auipc	ra,0x0
  a8:	4ba080e7          	jalr	1210(ra) # 55e <close>
}
  ac:	27813083          	ld	ra,632(sp)
  b0:	27013403          	ld	s0,624(sp)
  b4:	26813483          	ld	s1,616(sp)
  b8:	26013903          	ld	s2,608(sp)
  bc:	25813983          	ld	s3,600(sp)
  c0:	25013a03          	ld	s4,592(sp)
  c4:	24813a83          	ld	s5,584(sp)
  c8:	24013b03          	ld	s6,576(sp)
  cc:	23813b83          	ld	s7,568(sp)
  d0:	28010113          	addi	sp,sp,640
  d4:	8082                	ret
        fprintf(2, "find: cannot open %s\n", path);
  d6:	8626                	mv	a2,s1
  d8:	00001597          	auipc	a1,0x1
  dc:	9a858593          	addi	a1,a1,-1624 # a80 <malloc+0xf4>
  e0:	4509                	li	a0,2
  e2:	00000097          	auipc	ra,0x0
  e6:	7bc080e7          	jalr	1980(ra) # 89e <fprintf>
        return;
  ea:	b7c9                	j	ac <find+0xac>
        fprintf(2, "find: cannot stat %s\n", path);
  ec:	8626                	mv	a2,s1
  ee:	00001597          	auipc	a1,0x1
  f2:	9aa58593          	addi	a1,a1,-1622 # a98 <malloc+0x10c>
  f6:	4509                	li	a0,2
  f8:	00000097          	auipc	ra,0x0
  fc:	7a6080e7          	jalr	1958(ra) # 89e <fprintf>
        close(fd);
 100:	854a                	mv	a0,s2
 102:	00000097          	auipc	ra,0x0
 106:	45c080e7          	jalr	1116(ra) # 55e <close>
        return;
 10a:	b74d                	j	ac <find+0xac>
            printf("%s\n", path);
 10c:	85a6                	mv	a1,s1
 10e:	00001517          	auipc	a0,0x1
 112:	9a250513          	addi	a0,a0,-1630 # ab0 <malloc+0x124>
 116:	00000097          	auipc	ra,0x0
 11a:	7b6080e7          	jalr	1974(ra) # 8cc <printf>
 11e:	b751                	j	a2 <find+0xa2>
        if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 120:	8526                	mv	a0,s1
 122:	00000097          	auipc	ra,0x0
 126:	1be080e7          	jalr	446(ra) # 2e0 <strlen>
 12a:	2541                	addiw	a0,a0,16
 12c:	20000793          	li	a5,512
 130:	00a7fb63          	bgeu	a5,a0,146 <find+0x146>
            printf("find: path too long\n");
 134:	00001517          	auipc	a0,0x1
 138:	98450513          	addi	a0,a0,-1660 # ab8 <malloc+0x12c>
 13c:	00000097          	auipc	ra,0x0
 140:	790080e7          	jalr	1936(ra) # 8cc <printf>
            break;
 144:	bfb9                	j	a2 <find+0xa2>
        strcpy(buf, path);
 146:	85a6                	mv	a1,s1
 148:	db040513          	addi	a0,s0,-592
 14c:	00000097          	auipc	ra,0x0
 150:	144080e7          	jalr	324(ra) # 290 <strcpy>
        p = buf+strlen(buf);
 154:	db040513          	addi	a0,s0,-592
 158:	00000097          	auipc	ra,0x0
 15c:	188080e7          	jalr	392(ra) # 2e0 <strlen>
 160:	1502                	slli	a0,a0,0x20
 162:	9101                	srli	a0,a0,0x20
 164:	db040793          	addi	a5,s0,-592
 168:	00a784b3          	add	s1,a5,a0
        *p++ = '/';
 16c:	00148a13          	addi	s4,s1,1
 170:	02f00793          	li	a5,47
 174:	00f48023          	sb	a5,0(s1)
            if (strcmp(p, ".") == 0 || strcmp(p, "..") == 0)
 178:	00001a97          	auipc	s5,0x1
 17c:	958a8a93          	addi	s5,s5,-1704 # ad0 <malloc+0x144>
 180:	00001b17          	auipc	s6,0x1
 184:	958b0b13          	addi	s6,s6,-1704 # ad8 <malloc+0x14c>
                printf("%s\n", buf);
 188:	00001b97          	auipc	s7,0x1
 18c:	928b8b93          	addi	s7,s7,-1752 # ab0 <malloc+0x124>
        while (read(fd, &de, sizeof(de)) == sizeof(de)) {
 190:	4641                	li	a2,16
 192:	da040593          	addi	a1,s0,-608
 196:	854a                	mv	a0,s2
 198:	00000097          	auipc	ra,0x0
 19c:	3b6080e7          	jalr	950(ra) # 54e <read>
 1a0:	47c1                	li	a5,16
 1a2:	f0f510e3          	bne	a0,a5,a2 <find+0xa2>
            if (de.inum == 0)
 1a6:	da045783          	lhu	a5,-608(s0)
 1aa:	d3fd                	beqz	a5,190 <find+0x190>
            memmove(p, de.name, DIRSIZ);
 1ac:	4639                	li	a2,14
 1ae:	da240593          	addi	a1,s0,-606
 1b2:	8552                	mv	a0,s4
 1b4:	00000097          	auipc	ra,0x0
 1b8:	2aa080e7          	jalr	682(ra) # 45e <memmove>
            p[DIRSIZ] = 0;
 1bc:	000487a3          	sb	zero,15(s1)
            if (strcmp(p, ".") == 0 || strcmp(p, "..") == 0)
 1c0:	85d6                	mv	a1,s5
 1c2:	8552                	mv	a0,s4
 1c4:	00000097          	auipc	ra,0x0
 1c8:	0e8080e7          	jalr	232(ra) # 2ac <strcmp>
 1cc:	d171                	beqz	a0,190 <find+0x190>
 1ce:	85da                	mv	a1,s6
 1d0:	8552                	mv	a0,s4
 1d2:	00000097          	auipc	ra,0x0
 1d6:	0da080e7          	jalr	218(ra) # 2ac <strcmp>
 1da:	d95d                	beqz	a0,190 <find+0x190>
            if (stat(buf, &st) < 0) {
 1dc:	d8840593          	addi	a1,s0,-632
 1e0:	db040513          	addi	a0,s0,-592
 1e4:	00000097          	auipc	ra,0x0
 1e8:	1ea080e7          	jalr	490(ra) # 3ce <stat>
 1ec:	02054163          	bltz	a0,20e <find+0x20e>
            if (strcmp(p, target) == 0)
 1f0:	85ce                	mv	a1,s3
 1f2:	8552                	mv	a0,s4
 1f4:	00000097          	auipc	ra,0x0
 1f8:	0b8080e7          	jalr	184(ra) # 2ac <strcmp>
 1fc:	c505                	beqz	a0,224 <find+0x224>
            find(buf, target);
 1fe:	85ce                	mv	a1,s3
 200:	db040513          	addi	a0,s0,-592
 204:	00000097          	auipc	ra,0x0
 208:	dfc080e7          	jalr	-516(ra) # 0 <find>
 20c:	b751                	j	190 <find+0x190>
                printf("find: cannot stat %s\n", buf);
 20e:	db040593          	addi	a1,s0,-592
 212:	00001517          	auipc	a0,0x1
 216:	88650513          	addi	a0,a0,-1914 # a98 <malloc+0x10c>
 21a:	00000097          	auipc	ra,0x0
 21e:	6b2080e7          	jalr	1714(ra) # 8cc <printf>
                continue;
 222:	b7bd                	j	190 <find+0x190>
                printf("%s\n", buf);
 224:	db040593          	addi	a1,s0,-592
 228:	855e                	mv	a0,s7
 22a:	00000097          	auipc	ra,0x0
 22e:	6a2080e7          	jalr	1698(ra) # 8cc <printf>
 232:	b7f1                	j	1fe <find+0x1fe>

0000000000000234 <main>:

int main(int argc, char *argv[])
{
 234:	1141                	addi	sp,sp,-16
 236:	e406                	sd	ra,8(sp)
 238:	e022                	sd	s0,0(sp)
 23a:	0800                	addi	s0,sp,16
    if (argc != 3) {
 23c:	478d                	li	a5,3
 23e:	02f50063          	beq	a0,a5,25e <main+0x2a>
        fprintf(2, "find: arguments needed\n");
 242:	00001597          	auipc	a1,0x1
 246:	89e58593          	addi	a1,a1,-1890 # ae0 <malloc+0x154>
 24a:	4509                	li	a0,2
 24c:	00000097          	auipc	ra,0x0
 250:	652080e7          	jalr	1618(ra) # 89e <fprintf>
        exit(0);
 254:	4501                	li	a0,0
 256:	00000097          	auipc	ra,0x0
 25a:	2e0080e7          	jalr	736(ra) # 536 <exit>
 25e:	872e                	mv	a4,a1
    }

    find(argv[1], argv[2]);
 260:	698c                	ld	a1,16(a1)
 262:	6708                	ld	a0,8(a4)
 264:	00000097          	auipc	ra,0x0
 268:	d9c080e7          	jalr	-612(ra) # 0 <find>

    exit(0);
 26c:	4501                	li	a0,0
 26e:	00000097          	auipc	ra,0x0
 272:	2c8080e7          	jalr	712(ra) # 536 <exit>

0000000000000276 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 276:	1141                	addi	sp,sp,-16
 278:	e406                	sd	ra,8(sp)
 27a:	e022                	sd	s0,0(sp)
 27c:	0800                	addi	s0,sp,16
  extern int main();
  main();
 27e:	00000097          	auipc	ra,0x0
 282:	fb6080e7          	jalr	-74(ra) # 234 <main>
  exit(0);
 286:	4501                	li	a0,0
 288:	00000097          	auipc	ra,0x0
 28c:	2ae080e7          	jalr	686(ra) # 536 <exit>

0000000000000290 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 290:	1141                	addi	sp,sp,-16
 292:	e422                	sd	s0,8(sp)
 294:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 296:	87aa                	mv	a5,a0
 298:	0585                	addi	a1,a1,1
 29a:	0785                	addi	a5,a5,1
 29c:	fff5c703          	lbu	a4,-1(a1)
 2a0:	fee78fa3          	sb	a4,-1(a5)
 2a4:	fb75                	bnez	a4,298 <strcpy+0x8>
    ;
  return os;
}
 2a6:	6422                	ld	s0,8(sp)
 2a8:	0141                	addi	sp,sp,16
 2aa:	8082                	ret

00000000000002ac <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2ac:	1141                	addi	sp,sp,-16
 2ae:	e422                	sd	s0,8(sp)
 2b0:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2b2:	00054783          	lbu	a5,0(a0)
 2b6:	cf91                	beqz	a5,2d2 <strcmp+0x26>
 2b8:	0005c703          	lbu	a4,0(a1)
 2bc:	00f71b63          	bne	a4,a5,2d2 <strcmp+0x26>
    p++, q++;
 2c0:	0505                	addi	a0,a0,1
 2c2:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2c4:	00054783          	lbu	a5,0(a0)
 2c8:	c789                	beqz	a5,2d2 <strcmp+0x26>
 2ca:	0005c703          	lbu	a4,0(a1)
 2ce:	fef709e3          	beq	a4,a5,2c0 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 2d2:	0005c503          	lbu	a0,0(a1)
}
 2d6:	40a7853b          	subw	a0,a5,a0
 2da:	6422                	ld	s0,8(sp)
 2dc:	0141                	addi	sp,sp,16
 2de:	8082                	ret

00000000000002e0 <strlen>:

uint
strlen(const char *s)
{
 2e0:	1141                	addi	sp,sp,-16
 2e2:	e422                	sd	s0,8(sp)
 2e4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2e6:	00054783          	lbu	a5,0(a0)
 2ea:	cf91                	beqz	a5,306 <strlen+0x26>
 2ec:	0505                	addi	a0,a0,1
 2ee:	87aa                	mv	a5,a0
 2f0:	4685                	li	a3,1
 2f2:	9e89                	subw	a3,a3,a0
    ;
 2f4:	00f6853b          	addw	a0,a3,a5
 2f8:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
 2fa:	fff7c703          	lbu	a4,-1(a5)
 2fe:	fb7d                	bnez	a4,2f4 <strlen+0x14>
  return n;
}
 300:	6422                	ld	s0,8(sp)
 302:	0141                	addi	sp,sp,16
 304:	8082                	ret
  for(n = 0; s[n]; n++)
 306:	4501                	li	a0,0
 308:	bfe5                	j	300 <strlen+0x20>

000000000000030a <memset>:

void*
memset(void *dst, int c, uint n)
{
 30a:	1141                	addi	sp,sp,-16
 30c:	e422                	sd	s0,8(sp)
 30e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 310:	ce09                	beqz	a2,32a <memset+0x20>
 312:	87aa                	mv	a5,a0
 314:	fff6071b          	addiw	a4,a2,-1
 318:	1702                	slli	a4,a4,0x20
 31a:	9301                	srli	a4,a4,0x20
 31c:	0705                	addi	a4,a4,1
 31e:	972a                	add	a4,a4,a0
    cdst[i] = c;
 320:	00b78023          	sb	a1,0(a5)
 324:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 326:	fee79de3          	bne	a5,a4,320 <memset+0x16>
  }
  return dst;
}
 32a:	6422                	ld	s0,8(sp)
 32c:	0141                	addi	sp,sp,16
 32e:	8082                	ret

0000000000000330 <strchr>:

char*
strchr(const char *s, char c)
{
 330:	1141                	addi	sp,sp,-16
 332:	e422                	sd	s0,8(sp)
 334:	0800                	addi	s0,sp,16
  for(; *s; s++)
 336:	00054783          	lbu	a5,0(a0)
 33a:	cf91                	beqz	a5,356 <strchr+0x26>
    if(*s == c)
 33c:	00f58a63          	beq	a1,a5,350 <strchr+0x20>
  for(; *s; s++)
 340:	0505                	addi	a0,a0,1
 342:	00054783          	lbu	a5,0(a0)
 346:	c781                	beqz	a5,34e <strchr+0x1e>
    if(*s == c)
 348:	feb79ce3          	bne	a5,a1,340 <strchr+0x10>
 34c:	a011                	j	350 <strchr+0x20>
      return (char*)s;
  return 0;
 34e:	4501                	li	a0,0
}
 350:	6422                	ld	s0,8(sp)
 352:	0141                	addi	sp,sp,16
 354:	8082                	ret
  return 0;
 356:	4501                	li	a0,0
 358:	bfe5                	j	350 <strchr+0x20>

000000000000035a <gets>:

char*
gets(char *buf, int max)
{
 35a:	711d                	addi	sp,sp,-96
 35c:	ec86                	sd	ra,88(sp)
 35e:	e8a2                	sd	s0,80(sp)
 360:	e4a6                	sd	s1,72(sp)
 362:	e0ca                	sd	s2,64(sp)
 364:	fc4e                	sd	s3,56(sp)
 366:	f852                	sd	s4,48(sp)
 368:	f456                	sd	s5,40(sp)
 36a:	f05a                	sd	s6,32(sp)
 36c:	ec5e                	sd	s7,24(sp)
 36e:	1080                	addi	s0,sp,96
 370:	8baa                	mv	s7,a0
 372:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 374:	892a                	mv	s2,a0
 376:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 378:	4aa9                	li	s5,10
 37a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 37c:	0019849b          	addiw	s1,s3,1
 380:	0344d863          	bge	s1,s4,3b0 <gets+0x56>
    cc = read(0, &c, 1);
 384:	4605                	li	a2,1
 386:	faf40593          	addi	a1,s0,-81
 38a:	4501                	li	a0,0
 38c:	00000097          	auipc	ra,0x0
 390:	1c2080e7          	jalr	450(ra) # 54e <read>
    if(cc < 1)
 394:	00a05e63          	blez	a0,3b0 <gets+0x56>
    buf[i++] = c;
 398:	faf44783          	lbu	a5,-81(s0)
 39c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3a0:	01578763          	beq	a5,s5,3ae <gets+0x54>
 3a4:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 3a6:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 3a8:	fd679ae3          	bne	a5,s6,37c <gets+0x22>
 3ac:	a011                	j	3b0 <gets+0x56>
  for(i=0; i+1 < max; ){
 3ae:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3b0:	99de                	add	s3,s3,s7
 3b2:	00098023          	sb	zero,0(s3)
  return buf;
}
 3b6:	855e                	mv	a0,s7
 3b8:	60e6                	ld	ra,88(sp)
 3ba:	6446                	ld	s0,80(sp)
 3bc:	64a6                	ld	s1,72(sp)
 3be:	6906                	ld	s2,64(sp)
 3c0:	79e2                	ld	s3,56(sp)
 3c2:	7a42                	ld	s4,48(sp)
 3c4:	7aa2                	ld	s5,40(sp)
 3c6:	7b02                	ld	s6,32(sp)
 3c8:	6be2                	ld	s7,24(sp)
 3ca:	6125                	addi	sp,sp,96
 3cc:	8082                	ret

00000000000003ce <stat>:

int
stat(const char *n, struct stat *st)
{
 3ce:	1101                	addi	sp,sp,-32
 3d0:	ec06                	sd	ra,24(sp)
 3d2:	e822                	sd	s0,16(sp)
 3d4:	e426                	sd	s1,8(sp)
 3d6:	e04a                	sd	s2,0(sp)
 3d8:	1000                	addi	s0,sp,32
 3da:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3dc:	4581                	li	a1,0
 3de:	00000097          	auipc	ra,0x0
 3e2:	198080e7          	jalr	408(ra) # 576 <open>
  if(fd < 0)
 3e6:	02054563          	bltz	a0,410 <stat+0x42>
 3ea:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3ec:	85ca                	mv	a1,s2
 3ee:	00000097          	auipc	ra,0x0
 3f2:	1a0080e7          	jalr	416(ra) # 58e <fstat>
 3f6:	892a                	mv	s2,a0
  close(fd);
 3f8:	8526                	mv	a0,s1
 3fa:	00000097          	auipc	ra,0x0
 3fe:	164080e7          	jalr	356(ra) # 55e <close>
  return r;
}
 402:	854a                	mv	a0,s2
 404:	60e2                	ld	ra,24(sp)
 406:	6442                	ld	s0,16(sp)
 408:	64a2                	ld	s1,8(sp)
 40a:	6902                	ld	s2,0(sp)
 40c:	6105                	addi	sp,sp,32
 40e:	8082                	ret
    return -1;
 410:	597d                	li	s2,-1
 412:	bfc5                	j	402 <stat+0x34>

0000000000000414 <atoi>:

int
atoi(const char *s)
{
 414:	1141                	addi	sp,sp,-16
 416:	e422                	sd	s0,8(sp)
 418:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 41a:	00054683          	lbu	a3,0(a0)
 41e:	fd06879b          	addiw	a5,a3,-48
 422:	0ff7f793          	andi	a5,a5,255
 426:	4725                	li	a4,9
 428:	02f76963          	bltu	a4,a5,45a <atoi+0x46>
 42c:	862a                	mv	a2,a0
  n = 0;
 42e:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 430:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 432:	0605                	addi	a2,a2,1
 434:	0025179b          	slliw	a5,a0,0x2
 438:	9fa9                	addw	a5,a5,a0
 43a:	0017979b          	slliw	a5,a5,0x1
 43e:	9fb5                	addw	a5,a5,a3
 440:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 444:	00064683          	lbu	a3,0(a2)
 448:	fd06871b          	addiw	a4,a3,-48
 44c:	0ff77713          	andi	a4,a4,255
 450:	fee5f1e3          	bgeu	a1,a4,432 <atoi+0x1e>
  return n;
}
 454:	6422                	ld	s0,8(sp)
 456:	0141                	addi	sp,sp,16
 458:	8082                	ret
  n = 0;
 45a:	4501                	li	a0,0
 45c:	bfe5                	j	454 <atoi+0x40>

000000000000045e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 45e:	1141                	addi	sp,sp,-16
 460:	e422                	sd	s0,8(sp)
 462:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 464:	02b57663          	bgeu	a0,a1,490 <memmove+0x32>
    while(n-- > 0)
 468:	02c05163          	blez	a2,48a <memmove+0x2c>
 46c:	fff6079b          	addiw	a5,a2,-1
 470:	1782                	slli	a5,a5,0x20
 472:	9381                	srli	a5,a5,0x20
 474:	0785                	addi	a5,a5,1
 476:	97aa                	add	a5,a5,a0
  dst = vdst;
 478:	872a                	mv	a4,a0
      *dst++ = *src++;
 47a:	0585                	addi	a1,a1,1
 47c:	0705                	addi	a4,a4,1
 47e:	fff5c683          	lbu	a3,-1(a1)
 482:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 486:	fee79ae3          	bne	a5,a4,47a <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 48a:	6422                	ld	s0,8(sp)
 48c:	0141                	addi	sp,sp,16
 48e:	8082                	ret
    dst += n;
 490:	00c50733          	add	a4,a0,a2
    src += n;
 494:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 496:	fec05ae3          	blez	a2,48a <memmove+0x2c>
 49a:	fff6079b          	addiw	a5,a2,-1
 49e:	1782                	slli	a5,a5,0x20
 4a0:	9381                	srli	a5,a5,0x20
 4a2:	fff7c793          	not	a5,a5
 4a6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4a8:	15fd                	addi	a1,a1,-1
 4aa:	177d                	addi	a4,a4,-1
 4ac:	0005c683          	lbu	a3,0(a1)
 4b0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4b4:	fef71ae3          	bne	a4,a5,4a8 <memmove+0x4a>
 4b8:	bfc9                	j	48a <memmove+0x2c>

00000000000004ba <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4ba:	1141                	addi	sp,sp,-16
 4bc:	e422                	sd	s0,8(sp)
 4be:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4c0:	ce15                	beqz	a2,4fc <memcmp+0x42>
 4c2:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 4c6:	00054783          	lbu	a5,0(a0)
 4ca:	0005c703          	lbu	a4,0(a1)
 4ce:	02e79063          	bne	a5,a4,4ee <memcmp+0x34>
 4d2:	1682                	slli	a3,a3,0x20
 4d4:	9281                	srli	a3,a3,0x20
 4d6:	0685                	addi	a3,a3,1
 4d8:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 4da:	0505                	addi	a0,a0,1
    p2++;
 4dc:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4de:	00d50d63          	beq	a0,a3,4f8 <memcmp+0x3e>
    if (*p1 != *p2) {
 4e2:	00054783          	lbu	a5,0(a0)
 4e6:	0005c703          	lbu	a4,0(a1)
 4ea:	fee788e3          	beq	a5,a4,4da <memcmp+0x20>
      return *p1 - *p2;
 4ee:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 4f2:	6422                	ld	s0,8(sp)
 4f4:	0141                	addi	sp,sp,16
 4f6:	8082                	ret
  return 0;
 4f8:	4501                	li	a0,0
 4fa:	bfe5                	j	4f2 <memcmp+0x38>
 4fc:	4501                	li	a0,0
 4fe:	bfd5                	j	4f2 <memcmp+0x38>

0000000000000500 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 500:	1141                	addi	sp,sp,-16
 502:	e406                	sd	ra,8(sp)
 504:	e022                	sd	s0,0(sp)
 506:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 508:	00000097          	auipc	ra,0x0
 50c:	f56080e7          	jalr	-170(ra) # 45e <memmove>
}
 510:	60a2                	ld	ra,8(sp)
 512:	6402                	ld	s0,0(sp)
 514:	0141                	addi	sp,sp,16
 516:	8082                	ret

0000000000000518 <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 518:	1141                	addi	sp,sp,-16
 51a:	e422                	sd	s0,8(sp)
 51c:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 51e:	040007b7          	lui	a5,0x4000
}
 522:	17f5                	addi	a5,a5,-3
 524:	07b2                	slli	a5,a5,0xc
 526:	4388                	lw	a0,0(a5)
 528:	6422                	ld	s0,8(sp)
 52a:	0141                	addi	sp,sp,16
 52c:	8082                	ret

000000000000052e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 52e:	4885                	li	a7,1
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <exit>:
.global exit
exit:
 li a7, SYS_exit
 536:	4889                	li	a7,2
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <wait>:
.global wait
wait:
 li a7, SYS_wait
 53e:	488d                	li	a7,3
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 546:	4891                	li	a7,4
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <read>:
.global read
read:
 li a7, SYS_read
 54e:	4895                	li	a7,5
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <write>:
.global write
write:
 li a7, SYS_write
 556:	48c1                	li	a7,16
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <close>:
.global close
close:
 li a7, SYS_close
 55e:	48d5                	li	a7,21
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <kill>:
.global kill
kill:
 li a7, SYS_kill
 566:	4899                	li	a7,6
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <exec>:
.global exec
exec:
 li a7, SYS_exec
 56e:	489d                	li	a7,7
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <open>:
.global open
open:
 li a7, SYS_open
 576:	48bd                	li	a7,15
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 57e:	48c5                	li	a7,17
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 586:	48c9                	li	a7,18
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 58e:	48a1                	li	a7,8
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <link>:
.global link
link:
 li a7, SYS_link
 596:	48cd                	li	a7,19
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 59e:	48d1                	li	a7,20
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5a6:	48a5                	li	a7,9
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <dup>:
.global dup
dup:
 li a7, SYS_dup
 5ae:	48a9                	li	a7,10
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5b6:	48ad                	li	a7,11
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5be:	48b1                	li	a7,12
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5c6:	48b5                	li	a7,13
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5ce:	48b9                	li	a7,14
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <trace>:
.global trace
trace:
 li a7, SYS_trace
 5d6:	48d9                	li	a7,22
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 5de:	48dd                	li	a7,23
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <connect>:
.global connect
connect:
 li a7, SYS_connect
 5e6:	48f5                	li	a7,29
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 5ee:	48f9                	li	a7,30
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5f6:	1101                	addi	sp,sp,-32
 5f8:	ec06                	sd	ra,24(sp)
 5fa:	e822                	sd	s0,16(sp)
 5fc:	1000                	addi	s0,sp,32
 5fe:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 602:	4605                	li	a2,1
 604:	fef40593          	addi	a1,s0,-17
 608:	00000097          	auipc	ra,0x0
 60c:	f4e080e7          	jalr	-178(ra) # 556 <write>
}
 610:	60e2                	ld	ra,24(sp)
 612:	6442                	ld	s0,16(sp)
 614:	6105                	addi	sp,sp,32
 616:	8082                	ret

0000000000000618 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 618:	7139                	addi	sp,sp,-64
 61a:	fc06                	sd	ra,56(sp)
 61c:	f822                	sd	s0,48(sp)
 61e:	f426                	sd	s1,40(sp)
 620:	f04a                	sd	s2,32(sp)
 622:	ec4e                	sd	s3,24(sp)
 624:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 626:	c299                	beqz	a3,62c <printint+0x14>
 628:	0005cd63          	bltz	a1,642 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 62c:	2581                	sext.w	a1,a1
  neg = 0;
 62e:	4301                	li	t1,0
 630:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 634:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 636:	2601                	sext.w	a2,a2
 638:	00000897          	auipc	a7,0x0
 63c:	4c088893          	addi	a7,a7,1216 # af8 <digits>
 640:	a039                	j	64e <printint+0x36>
    x = -xx;
 642:	40b005bb          	negw	a1,a1
    neg = 1;
 646:	4305                	li	t1,1
    x = -xx;
 648:	b7e5                	j	630 <printint+0x18>
  }while((x /= base) != 0);
 64a:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 64c:	8836                	mv	a6,a3
 64e:	0018069b          	addiw	a3,a6,1
 652:	02c5f7bb          	remuw	a5,a1,a2
 656:	1782                	slli	a5,a5,0x20
 658:	9381                	srli	a5,a5,0x20
 65a:	97c6                	add	a5,a5,a7
 65c:	0007c783          	lbu	a5,0(a5) # 4000000 <base+0x3ffeff0>
 660:	00f70023          	sb	a5,0(a4)
 664:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 666:	02c5d7bb          	divuw	a5,a1,a2
 66a:	fec5f0e3          	bgeu	a1,a2,64a <printint+0x32>
  if(neg)
 66e:	00030b63          	beqz	t1,684 <printint+0x6c>
    buf[i++] = '-';
 672:	fd040793          	addi	a5,s0,-48
 676:	96be                	add	a3,a3,a5
 678:	02d00793          	li	a5,45
 67c:	fef68823          	sb	a5,-16(a3)
 680:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 684:	02d05963          	blez	a3,6b6 <printint+0x9e>
 688:	89aa                	mv	s3,a0
 68a:	fc040793          	addi	a5,s0,-64
 68e:	00d784b3          	add	s1,a5,a3
 692:	fff78913          	addi	s2,a5,-1
 696:	9936                	add	s2,s2,a3
 698:	36fd                	addiw	a3,a3,-1
 69a:	1682                	slli	a3,a3,0x20
 69c:	9281                	srli	a3,a3,0x20
 69e:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 6a2:	fff4c583          	lbu	a1,-1(s1)
 6a6:	854e                	mv	a0,s3
 6a8:	00000097          	auipc	ra,0x0
 6ac:	f4e080e7          	jalr	-178(ra) # 5f6 <putc>
 6b0:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 6b2:	ff2498e3          	bne	s1,s2,6a2 <printint+0x8a>
}
 6b6:	70e2                	ld	ra,56(sp)
 6b8:	7442                	ld	s0,48(sp)
 6ba:	74a2                	ld	s1,40(sp)
 6bc:	7902                	ld	s2,32(sp)
 6be:	69e2                	ld	s3,24(sp)
 6c0:	6121                	addi	sp,sp,64
 6c2:	8082                	ret

00000000000006c4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6c4:	7119                	addi	sp,sp,-128
 6c6:	fc86                	sd	ra,120(sp)
 6c8:	f8a2                	sd	s0,112(sp)
 6ca:	f4a6                	sd	s1,104(sp)
 6cc:	f0ca                	sd	s2,96(sp)
 6ce:	ecce                	sd	s3,88(sp)
 6d0:	e8d2                	sd	s4,80(sp)
 6d2:	e4d6                	sd	s5,72(sp)
 6d4:	e0da                	sd	s6,64(sp)
 6d6:	fc5e                	sd	s7,56(sp)
 6d8:	f862                	sd	s8,48(sp)
 6da:	f466                	sd	s9,40(sp)
 6dc:	f06a                	sd	s10,32(sp)
 6de:	ec6e                	sd	s11,24(sp)
 6e0:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6e2:	0005c483          	lbu	s1,0(a1)
 6e6:	18048d63          	beqz	s1,880 <vprintf+0x1bc>
 6ea:	8aaa                	mv	s5,a0
 6ec:	8b32                	mv	s6,a2
 6ee:	00158913          	addi	s2,a1,1
  state = 0;
 6f2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6f4:	02500a13          	li	s4,37
      if(c == 'd'){
 6f8:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 6fc:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 700:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 704:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 708:	00000b97          	auipc	s7,0x0
 70c:	3f0b8b93          	addi	s7,s7,1008 # af8 <digits>
 710:	a839                	j	72e <vprintf+0x6a>
        putc(fd, c);
 712:	85a6                	mv	a1,s1
 714:	8556                	mv	a0,s5
 716:	00000097          	auipc	ra,0x0
 71a:	ee0080e7          	jalr	-288(ra) # 5f6 <putc>
 71e:	a019                	j	724 <vprintf+0x60>
    } else if(state == '%'){
 720:	01498f63          	beq	s3,s4,73e <vprintf+0x7a>
 724:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 726:	fff94483          	lbu	s1,-1(s2)
 72a:	14048b63          	beqz	s1,880 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 72e:	0004879b          	sext.w	a5,s1
    if(state == 0){
 732:	fe0997e3          	bnez	s3,720 <vprintf+0x5c>
      if(c == '%'){
 736:	fd479ee3          	bne	a5,s4,712 <vprintf+0x4e>
        state = '%';
 73a:	89be                	mv	s3,a5
 73c:	b7e5                	j	724 <vprintf+0x60>
      if(c == 'd'){
 73e:	05878063          	beq	a5,s8,77e <vprintf+0xba>
      } else if(c == 'l') {
 742:	05978c63          	beq	a5,s9,79a <vprintf+0xd6>
      } else if(c == 'x') {
 746:	07a78863          	beq	a5,s10,7b6 <vprintf+0xf2>
      } else if(c == 'p') {
 74a:	09b78463          	beq	a5,s11,7d2 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 74e:	07300713          	li	a4,115
 752:	0ce78563          	beq	a5,a4,81c <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 756:	06300713          	li	a4,99
 75a:	0ee78c63          	beq	a5,a4,852 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 75e:	11478663          	beq	a5,s4,86a <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 762:	85d2                	mv	a1,s4
 764:	8556                	mv	a0,s5
 766:	00000097          	auipc	ra,0x0
 76a:	e90080e7          	jalr	-368(ra) # 5f6 <putc>
        putc(fd, c);
 76e:	85a6                	mv	a1,s1
 770:	8556                	mv	a0,s5
 772:	00000097          	auipc	ra,0x0
 776:	e84080e7          	jalr	-380(ra) # 5f6 <putc>
      }
      state = 0;
 77a:	4981                	li	s3,0
 77c:	b765                	j	724 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 77e:	008b0493          	addi	s1,s6,8
 782:	4685                	li	a3,1
 784:	4629                	li	a2,10
 786:	000b2583          	lw	a1,0(s6)
 78a:	8556                	mv	a0,s5
 78c:	00000097          	auipc	ra,0x0
 790:	e8c080e7          	jalr	-372(ra) # 618 <printint>
 794:	8b26                	mv	s6,s1
      state = 0;
 796:	4981                	li	s3,0
 798:	b771                	j	724 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 79a:	008b0493          	addi	s1,s6,8
 79e:	4681                	li	a3,0
 7a0:	4629                	li	a2,10
 7a2:	000b2583          	lw	a1,0(s6)
 7a6:	8556                	mv	a0,s5
 7a8:	00000097          	auipc	ra,0x0
 7ac:	e70080e7          	jalr	-400(ra) # 618 <printint>
 7b0:	8b26                	mv	s6,s1
      state = 0;
 7b2:	4981                	li	s3,0
 7b4:	bf85                	j	724 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 7b6:	008b0493          	addi	s1,s6,8
 7ba:	4681                	li	a3,0
 7bc:	4641                	li	a2,16
 7be:	000b2583          	lw	a1,0(s6)
 7c2:	8556                	mv	a0,s5
 7c4:	00000097          	auipc	ra,0x0
 7c8:	e54080e7          	jalr	-428(ra) # 618 <printint>
 7cc:	8b26                	mv	s6,s1
      state = 0;
 7ce:	4981                	li	s3,0
 7d0:	bf91                	j	724 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 7d2:	008b0793          	addi	a5,s6,8
 7d6:	f8f43423          	sd	a5,-120(s0)
 7da:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7de:	03000593          	li	a1,48
 7e2:	8556                	mv	a0,s5
 7e4:	00000097          	auipc	ra,0x0
 7e8:	e12080e7          	jalr	-494(ra) # 5f6 <putc>
  putc(fd, 'x');
 7ec:	85ea                	mv	a1,s10
 7ee:	8556                	mv	a0,s5
 7f0:	00000097          	auipc	ra,0x0
 7f4:	e06080e7          	jalr	-506(ra) # 5f6 <putc>
 7f8:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7fa:	03c9d793          	srli	a5,s3,0x3c
 7fe:	97de                	add	a5,a5,s7
 800:	0007c583          	lbu	a1,0(a5)
 804:	8556                	mv	a0,s5
 806:	00000097          	auipc	ra,0x0
 80a:	df0080e7          	jalr	-528(ra) # 5f6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 80e:	0992                	slli	s3,s3,0x4
 810:	34fd                	addiw	s1,s1,-1
 812:	f4e5                	bnez	s1,7fa <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 814:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 818:	4981                	li	s3,0
 81a:	b729                	j	724 <vprintf+0x60>
        s = va_arg(ap, char*);
 81c:	008b0993          	addi	s3,s6,8
 820:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 824:	c085                	beqz	s1,844 <vprintf+0x180>
        while(*s != 0){
 826:	0004c583          	lbu	a1,0(s1)
 82a:	c9a1                	beqz	a1,87a <vprintf+0x1b6>
          putc(fd, *s);
 82c:	8556                	mv	a0,s5
 82e:	00000097          	auipc	ra,0x0
 832:	dc8080e7          	jalr	-568(ra) # 5f6 <putc>
          s++;
 836:	0485                	addi	s1,s1,1
        while(*s != 0){
 838:	0004c583          	lbu	a1,0(s1)
 83c:	f9e5                	bnez	a1,82c <vprintf+0x168>
        s = va_arg(ap, char*);
 83e:	8b4e                	mv	s6,s3
      state = 0;
 840:	4981                	li	s3,0
 842:	b5cd                	j	724 <vprintf+0x60>
          s = "(null)";
 844:	00000497          	auipc	s1,0x0
 848:	2cc48493          	addi	s1,s1,716 # b10 <digits+0x18>
        while(*s != 0){
 84c:	02800593          	li	a1,40
 850:	bff1                	j	82c <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 852:	008b0493          	addi	s1,s6,8
 856:	000b4583          	lbu	a1,0(s6)
 85a:	8556                	mv	a0,s5
 85c:	00000097          	auipc	ra,0x0
 860:	d9a080e7          	jalr	-614(ra) # 5f6 <putc>
 864:	8b26                	mv	s6,s1
      state = 0;
 866:	4981                	li	s3,0
 868:	bd75                	j	724 <vprintf+0x60>
        putc(fd, c);
 86a:	85d2                	mv	a1,s4
 86c:	8556                	mv	a0,s5
 86e:	00000097          	auipc	ra,0x0
 872:	d88080e7          	jalr	-632(ra) # 5f6 <putc>
      state = 0;
 876:	4981                	li	s3,0
 878:	b575                	j	724 <vprintf+0x60>
        s = va_arg(ap, char*);
 87a:	8b4e                	mv	s6,s3
      state = 0;
 87c:	4981                	li	s3,0
 87e:	b55d                	j	724 <vprintf+0x60>
    }
  }
}
 880:	70e6                	ld	ra,120(sp)
 882:	7446                	ld	s0,112(sp)
 884:	74a6                	ld	s1,104(sp)
 886:	7906                	ld	s2,96(sp)
 888:	69e6                	ld	s3,88(sp)
 88a:	6a46                	ld	s4,80(sp)
 88c:	6aa6                	ld	s5,72(sp)
 88e:	6b06                	ld	s6,64(sp)
 890:	7be2                	ld	s7,56(sp)
 892:	7c42                	ld	s8,48(sp)
 894:	7ca2                	ld	s9,40(sp)
 896:	7d02                	ld	s10,32(sp)
 898:	6de2                	ld	s11,24(sp)
 89a:	6109                	addi	sp,sp,128
 89c:	8082                	ret

000000000000089e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 89e:	715d                	addi	sp,sp,-80
 8a0:	ec06                	sd	ra,24(sp)
 8a2:	e822                	sd	s0,16(sp)
 8a4:	1000                	addi	s0,sp,32
 8a6:	e010                	sd	a2,0(s0)
 8a8:	e414                	sd	a3,8(s0)
 8aa:	e818                	sd	a4,16(s0)
 8ac:	ec1c                	sd	a5,24(s0)
 8ae:	03043023          	sd	a6,32(s0)
 8b2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8b6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8ba:	8622                	mv	a2,s0
 8bc:	00000097          	auipc	ra,0x0
 8c0:	e08080e7          	jalr	-504(ra) # 6c4 <vprintf>
}
 8c4:	60e2                	ld	ra,24(sp)
 8c6:	6442                	ld	s0,16(sp)
 8c8:	6161                	addi	sp,sp,80
 8ca:	8082                	ret

00000000000008cc <printf>:

void
printf(const char *fmt, ...)
{
 8cc:	711d                	addi	sp,sp,-96
 8ce:	ec06                	sd	ra,24(sp)
 8d0:	e822                	sd	s0,16(sp)
 8d2:	1000                	addi	s0,sp,32
 8d4:	e40c                	sd	a1,8(s0)
 8d6:	e810                	sd	a2,16(s0)
 8d8:	ec14                	sd	a3,24(s0)
 8da:	f018                	sd	a4,32(s0)
 8dc:	f41c                	sd	a5,40(s0)
 8de:	03043823          	sd	a6,48(s0)
 8e2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8e6:	00840613          	addi	a2,s0,8
 8ea:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8ee:	85aa                	mv	a1,a0
 8f0:	4505                	li	a0,1
 8f2:	00000097          	auipc	ra,0x0
 8f6:	dd2080e7          	jalr	-558(ra) # 6c4 <vprintf>
}
 8fa:	60e2                	ld	ra,24(sp)
 8fc:	6442                	ld	s0,16(sp)
 8fe:	6125                	addi	sp,sp,96
 900:	8082                	ret

0000000000000902 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 902:	1141                	addi	sp,sp,-16
 904:	e422                	sd	s0,8(sp)
 906:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 908:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 90c:	00000797          	auipc	a5,0x0
 910:	6f478793          	addi	a5,a5,1780 # 1000 <freep>
 914:	639c                	ld	a5,0(a5)
 916:	a805                	j	946 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 918:	4618                	lw	a4,8(a2)
 91a:	9db9                	addw	a1,a1,a4
 91c:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 920:	6398                	ld	a4,0(a5)
 922:	6318                	ld	a4,0(a4)
 924:	fee53823          	sd	a4,-16(a0)
 928:	a091                	j	96c <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 92a:	ff852703          	lw	a4,-8(a0)
 92e:	9e39                	addw	a2,a2,a4
 930:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 932:	ff053703          	ld	a4,-16(a0)
 936:	e398                	sd	a4,0(a5)
 938:	a099                	j	97e <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 93a:	6398                	ld	a4,0(a5)
 93c:	00e7e463          	bltu	a5,a4,944 <free+0x42>
 940:	00e6ea63          	bltu	a3,a4,954 <free+0x52>
{
 944:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 946:	fed7fae3          	bgeu	a5,a3,93a <free+0x38>
 94a:	6398                	ld	a4,0(a5)
 94c:	00e6e463          	bltu	a3,a4,954 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 950:	fee7eae3          	bltu	a5,a4,944 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 954:	ff852583          	lw	a1,-8(a0)
 958:	6390                	ld	a2,0(a5)
 95a:	02059713          	slli	a4,a1,0x20
 95e:	9301                	srli	a4,a4,0x20
 960:	0712                	slli	a4,a4,0x4
 962:	9736                	add	a4,a4,a3
 964:	fae60ae3          	beq	a2,a4,918 <free+0x16>
    bp->s.ptr = p->s.ptr;
 968:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 96c:	4790                	lw	a2,8(a5)
 96e:	02061713          	slli	a4,a2,0x20
 972:	9301                	srli	a4,a4,0x20
 974:	0712                	slli	a4,a4,0x4
 976:	973e                	add	a4,a4,a5
 978:	fae689e3          	beq	a3,a4,92a <free+0x28>
  } else
    p->s.ptr = bp;
 97c:	e394                	sd	a3,0(a5)
  freep = p;
 97e:	00000717          	auipc	a4,0x0
 982:	68f73123          	sd	a5,1666(a4) # 1000 <freep>
}
 986:	6422                	ld	s0,8(sp)
 988:	0141                	addi	sp,sp,16
 98a:	8082                	ret

000000000000098c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 98c:	7139                	addi	sp,sp,-64
 98e:	fc06                	sd	ra,56(sp)
 990:	f822                	sd	s0,48(sp)
 992:	f426                	sd	s1,40(sp)
 994:	f04a                	sd	s2,32(sp)
 996:	ec4e                	sd	s3,24(sp)
 998:	e852                	sd	s4,16(sp)
 99a:	e456                	sd	s5,8(sp)
 99c:	e05a                	sd	s6,0(sp)
 99e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9a0:	02051993          	slli	s3,a0,0x20
 9a4:	0209d993          	srli	s3,s3,0x20
 9a8:	09bd                	addi	s3,s3,15
 9aa:	0049d993          	srli	s3,s3,0x4
 9ae:	2985                	addiw	s3,s3,1
 9b0:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 9b4:	00000797          	auipc	a5,0x0
 9b8:	64c78793          	addi	a5,a5,1612 # 1000 <freep>
 9bc:	6388                	ld	a0,0(a5)
 9be:	c515                	beqz	a0,9ea <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9c0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9c2:	4798                	lw	a4,8(a5)
 9c4:	03277f63          	bgeu	a4,s2,a02 <malloc+0x76>
 9c8:	8a4e                	mv	s4,s3
 9ca:	0009871b          	sext.w	a4,s3
 9ce:	6685                	lui	a3,0x1
 9d0:	00d77363          	bgeu	a4,a3,9d6 <malloc+0x4a>
 9d4:	6a05                	lui	s4,0x1
 9d6:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 9da:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9de:	00000497          	auipc	s1,0x0
 9e2:	62248493          	addi	s1,s1,1570 # 1000 <freep>
  if(p == (char*)-1)
 9e6:	5b7d                	li	s6,-1
 9e8:	a885                	j	a58 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 9ea:	00000797          	auipc	a5,0x0
 9ee:	62678793          	addi	a5,a5,1574 # 1010 <base>
 9f2:	00000717          	auipc	a4,0x0
 9f6:	60f73723          	sd	a5,1550(a4) # 1000 <freep>
 9fa:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9fc:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a00:	b7e1                	j	9c8 <malloc+0x3c>
      if(p->s.size == nunits)
 a02:	02e90b63          	beq	s2,a4,a38 <malloc+0xac>
        p->s.size -= nunits;
 a06:	4137073b          	subw	a4,a4,s3
 a0a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a0c:	1702                	slli	a4,a4,0x20
 a0e:	9301                	srli	a4,a4,0x20
 a10:	0712                	slli	a4,a4,0x4
 a12:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a14:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a18:	00000717          	auipc	a4,0x0
 a1c:	5ea73423          	sd	a0,1512(a4) # 1000 <freep>
      return (void*)(p + 1);
 a20:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a24:	70e2                	ld	ra,56(sp)
 a26:	7442                	ld	s0,48(sp)
 a28:	74a2                	ld	s1,40(sp)
 a2a:	7902                	ld	s2,32(sp)
 a2c:	69e2                	ld	s3,24(sp)
 a2e:	6a42                	ld	s4,16(sp)
 a30:	6aa2                	ld	s5,8(sp)
 a32:	6b02                	ld	s6,0(sp)
 a34:	6121                	addi	sp,sp,64
 a36:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a38:	6398                	ld	a4,0(a5)
 a3a:	e118                	sd	a4,0(a0)
 a3c:	bff1                	j	a18 <malloc+0x8c>
  hp->s.size = nu;
 a3e:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 a42:	0541                	addi	a0,a0,16
 a44:	00000097          	auipc	ra,0x0
 a48:	ebe080e7          	jalr	-322(ra) # 902 <free>
  return freep;
 a4c:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 a4e:	d979                	beqz	a0,a24 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a50:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a52:	4798                	lw	a4,8(a5)
 a54:	fb2777e3          	bgeu	a4,s2,a02 <malloc+0x76>
    if(p == freep)
 a58:	6098                	ld	a4,0(s1)
 a5a:	853e                	mv	a0,a5
 a5c:	fef71ae3          	bne	a4,a5,a50 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 a60:	8552                	mv	a0,s4
 a62:	00000097          	auipc	ra,0x0
 a66:	b5c080e7          	jalr	-1188(ra) # 5be <sbrk>
  if(p == (char*)-1)
 a6a:	fd651ae3          	bne	a0,s6,a3e <malloc+0xb2>
        return 0;
 a6e:	4501                	li	a0,0
 a70:	bf55                	j	a24 <malloc+0x98>
