
user/_sysinfotest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <sinfo>:
#include "kernel/sysinfo.h"
#include "user/user.h"


void
sinfo(struct sysinfo *info) {
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  if (sysinfo(info) < 0) {
   8:	00000097          	auipc	ra,0x0
   c:	720080e7          	jalr	1824(ra) # 728 <sysinfo>
  10:	00054663          	bltz	a0,1c <sinfo+0x1c>
    printf("FAIL: sysinfo failed");
    exit(1);
  }
}
  14:	60a2                	ld	ra,8(sp)
  16:	6402                	ld	s0,0(sp)
  18:	0141                	addi	sp,sp,16
  1a:	8082                	ret
    printf("FAIL: sysinfo failed");
  1c:	00001517          	auipc	a0,0x1
  20:	bb450513          	addi	a0,a0,-1100 # bd0 <malloc+0xfa>
  24:	00001097          	auipc	ra,0x1
  28:	9f2080e7          	jalr	-1550(ra) # a16 <printf>
    exit(1);
  2c:	4505                	li	a0,1
  2e:	00000097          	auipc	ra,0x0
  32:	652080e7          	jalr	1618(ra) # 680 <exit>

0000000000000036 <countfree>:
//
// use sbrk() to count how many free physical memory pages there are.
//
int
countfree()
{
  36:	7139                	addi	sp,sp,-64
  38:	fc06                	sd	ra,56(sp)
  3a:	f822                	sd	s0,48(sp)
  3c:	f426                	sd	s1,40(sp)
  3e:	f04a                	sd	s2,32(sp)
  40:	ec4e                	sd	s3,24(sp)
  42:	e852                	sd	s4,16(sp)
  44:	0080                	addi	s0,sp,64
  uint64 sz0 = (uint64)sbrk(0);
  46:	4501                	li	a0,0
  48:	00000097          	auipc	ra,0x0
  4c:	6c0080e7          	jalr	1728(ra) # 708 <sbrk>
  50:	8a2a                	mv	s4,a0
  struct sysinfo info;
  int n = 0;
  52:	4481                	li	s1,0

  while(1){
    if((uint64)sbrk(PGSIZE) == 0xffffffffffffffff){
  54:	597d                	li	s2,-1
      break;
    }
    n += PGSIZE;
  56:	6985                	lui	s3,0x1
    if((uint64)sbrk(PGSIZE) == 0xffffffffffffffff){
  58:	6505                	lui	a0,0x1
  5a:	00000097          	auipc	ra,0x0
  5e:	6ae080e7          	jalr	1710(ra) # 708 <sbrk>
  62:	01250563          	beq	a0,s2,6c <countfree+0x36>
    n += PGSIZE;
  66:	009984bb          	addw	s1,s3,s1
    if((uint64)sbrk(PGSIZE) == 0xffffffffffffffff){
  6a:	b7fd                	j	58 <countfree+0x22>
  }
  sinfo(&info);
  6c:	fc040513          	addi	a0,s0,-64
  70:	00000097          	auipc	ra,0x0
  74:	f90080e7          	jalr	-112(ra) # 0 <sinfo>
  if (info.freemem != 0) {
  78:	fc043583          	ld	a1,-64(s0)
  7c:	e58d                	bnez	a1,a6 <countfree+0x70>
    printf("FAIL: there is no free mem, but sysinfo.freemem=%d\n",
      info.freemem);
    exit(1);
  }
  sbrk(-((uint64)sbrk(0) - sz0));
  7e:	4501                	li	a0,0
  80:	00000097          	auipc	ra,0x0
  84:	688080e7          	jalr	1672(ra) # 708 <sbrk>
  88:	40aa053b          	subw	a0,s4,a0
  8c:	00000097          	auipc	ra,0x0
  90:	67c080e7          	jalr	1660(ra) # 708 <sbrk>
  return n;
}
  94:	8526                	mv	a0,s1
  96:	70e2                	ld	ra,56(sp)
  98:	7442                	ld	s0,48(sp)
  9a:	74a2                	ld	s1,40(sp)
  9c:	7902                	ld	s2,32(sp)
  9e:	69e2                	ld	s3,24(sp)
  a0:	6a42                	ld	s4,16(sp)
  a2:	6121                	addi	sp,sp,64
  a4:	8082                	ret
    printf("FAIL: there is no free mem, but sysinfo.freemem=%d\n",
  a6:	00001517          	auipc	a0,0x1
  aa:	b4250513          	addi	a0,a0,-1214 # be8 <malloc+0x112>
  ae:	00001097          	auipc	ra,0x1
  b2:	968080e7          	jalr	-1688(ra) # a16 <printf>
    exit(1);
  b6:	4505                	li	a0,1
  b8:	00000097          	auipc	ra,0x0
  bc:	5c8080e7          	jalr	1480(ra) # 680 <exit>

00000000000000c0 <testmem>:

void
testmem() {
  c0:	7179                	addi	sp,sp,-48
  c2:	f406                	sd	ra,40(sp)
  c4:	f022                	sd	s0,32(sp)
  c6:	ec26                	sd	s1,24(sp)
  c8:	e84a                	sd	s2,16(sp)
  ca:	1800                	addi	s0,sp,48
  struct sysinfo info;
  uint64 n = countfree();
  cc:	00000097          	auipc	ra,0x0
  d0:	f6a080e7          	jalr	-150(ra) # 36 <countfree>
  d4:	84aa                	mv	s1,a0
  
  sinfo(&info);
  d6:	fd040513          	addi	a0,s0,-48
  da:	00000097          	auipc	ra,0x0
  de:	f26080e7          	jalr	-218(ra) # 0 <sinfo>

  if (info.freemem!= n) {
  e2:	fd043583          	ld	a1,-48(s0)
  e6:	04959e63          	bne	a1,s1,142 <testmem+0x82>
    printf("FAIL: free mem %d (bytes) instead of %d\n", info.freemem, n);
    exit(1);
  }
  
  if((uint64)sbrk(PGSIZE) == 0xffffffffffffffff){
  ea:	6505                	lui	a0,0x1
  ec:	00000097          	auipc	ra,0x0
  f0:	61c080e7          	jalr	1564(ra) # 708 <sbrk>
  f4:	57fd                	li	a5,-1
  f6:	06f50463          	beq	a0,a5,15e <testmem+0x9e>
    printf("sbrk failed");
    exit(1);
  }

  sinfo(&info);
  fa:	fd040513          	addi	a0,s0,-48
  fe:	00000097          	auipc	ra,0x0
 102:	f02080e7          	jalr	-254(ra) # 0 <sinfo>
    
  if (info.freemem != n-PGSIZE) {
 106:	fd043603          	ld	a2,-48(s0)
 10a:	75fd                	lui	a1,0xfffff
 10c:	95a6                	add	a1,a1,s1
 10e:	06b61563          	bne	a2,a1,178 <testmem+0xb8>
    printf("FAIL: free mem %d (bytes) instead of %d\n", n-PGSIZE, info.freemem);
    exit(1);
  }
  
  if((uint64)sbrk(-PGSIZE) == 0xffffffffffffffff){
 112:	757d                	lui	a0,0xfffff
 114:	00000097          	auipc	ra,0x0
 118:	5f4080e7          	jalr	1524(ra) # 708 <sbrk>
 11c:	57fd                	li	a5,-1
 11e:	06f50a63          	beq	a0,a5,192 <testmem+0xd2>
    printf("sbrk failed");
    exit(1);
  }

  sinfo(&info);
 122:	fd040513          	addi	a0,s0,-48
 126:	00000097          	auipc	ra,0x0
 12a:	eda080e7          	jalr	-294(ra) # 0 <sinfo>
    
  if (info.freemem != n) {
 12e:	fd043603          	ld	a2,-48(s0)
 132:	06961d63          	bne	a2,s1,1ac <testmem+0xec>
    printf("FAIL: free mem %d (bytes) instead of %d\n", n, info.freemem);
    exit(1);
  }
}
 136:	70a2                	ld	ra,40(sp)
 138:	7402                	ld	s0,32(sp)
 13a:	64e2                	ld	s1,24(sp)
 13c:	6942                	ld	s2,16(sp)
 13e:	6145                	addi	sp,sp,48
 140:	8082                	ret
    printf("FAIL: free mem %d (bytes) instead of %d\n", info.freemem, n);
 142:	8626                	mv	a2,s1
 144:	00001517          	auipc	a0,0x1
 148:	adc50513          	addi	a0,a0,-1316 # c20 <malloc+0x14a>
 14c:	00001097          	auipc	ra,0x1
 150:	8ca080e7          	jalr	-1846(ra) # a16 <printf>
    exit(1);
 154:	4505                	li	a0,1
 156:	00000097          	auipc	ra,0x0
 15a:	52a080e7          	jalr	1322(ra) # 680 <exit>
    printf("sbrk failed");
 15e:	00001517          	auipc	a0,0x1
 162:	af250513          	addi	a0,a0,-1294 # c50 <malloc+0x17a>
 166:	00001097          	auipc	ra,0x1
 16a:	8b0080e7          	jalr	-1872(ra) # a16 <printf>
    exit(1);
 16e:	4505                	li	a0,1
 170:	00000097          	auipc	ra,0x0
 174:	510080e7          	jalr	1296(ra) # 680 <exit>
    printf("FAIL: free mem %d (bytes) instead of %d\n", n-PGSIZE, info.freemem);
 178:	00001517          	auipc	a0,0x1
 17c:	aa850513          	addi	a0,a0,-1368 # c20 <malloc+0x14a>
 180:	00001097          	auipc	ra,0x1
 184:	896080e7          	jalr	-1898(ra) # a16 <printf>
    exit(1);
 188:	4505                	li	a0,1
 18a:	00000097          	auipc	ra,0x0
 18e:	4f6080e7          	jalr	1270(ra) # 680 <exit>
    printf("sbrk failed");
 192:	00001517          	auipc	a0,0x1
 196:	abe50513          	addi	a0,a0,-1346 # c50 <malloc+0x17a>
 19a:	00001097          	auipc	ra,0x1
 19e:	87c080e7          	jalr	-1924(ra) # a16 <printf>
    exit(1);
 1a2:	4505                	li	a0,1
 1a4:	00000097          	auipc	ra,0x0
 1a8:	4dc080e7          	jalr	1244(ra) # 680 <exit>
    printf("FAIL: free mem %d (bytes) instead of %d\n", n, info.freemem);
 1ac:	85a6                	mv	a1,s1
 1ae:	00001517          	auipc	a0,0x1
 1b2:	a7250513          	addi	a0,a0,-1422 # c20 <malloc+0x14a>
 1b6:	00001097          	auipc	ra,0x1
 1ba:	860080e7          	jalr	-1952(ra) # a16 <printf>
    exit(1);
 1be:	4505                	li	a0,1
 1c0:	00000097          	auipc	ra,0x0
 1c4:	4c0080e7          	jalr	1216(ra) # 680 <exit>

00000000000001c8 <testcall>:

void
testcall() {
 1c8:	1101                	addi	sp,sp,-32
 1ca:	ec06                	sd	ra,24(sp)
 1cc:	e822                	sd	s0,16(sp)
 1ce:	1000                	addi	s0,sp,32
  struct sysinfo info;
  
  if (sysinfo(&info) < 0) {
 1d0:	fe040513          	addi	a0,s0,-32
 1d4:	00000097          	auipc	ra,0x0
 1d8:	554080e7          	jalr	1364(ra) # 728 <sysinfo>
 1dc:	02054263          	bltz	a0,200 <testcall+0x38>
    printf("FAIL: sysinfo failed\n");
    exit(1);
  }

  if (sysinfo((struct sysinfo *) 0xeaeb0b5b00002f5e) !=  0xffffffffffffffff) {
 1e0:	00001797          	auipc	a5,0x1
 1e4:	9e078793          	addi	a5,a5,-1568 # bc0 <malloc+0xea>
 1e8:	6388                	ld	a0,0(a5)
 1ea:	00000097          	auipc	ra,0x0
 1ee:	53e080e7          	jalr	1342(ra) # 728 <sysinfo>
 1f2:	57fd                	li	a5,-1
 1f4:	02f51363          	bne	a0,a5,21a <testcall+0x52>
    printf("FAIL: sysinfo succeeded with bad argument\n");
    exit(1);
  }
}
 1f8:	60e2                	ld	ra,24(sp)
 1fa:	6442                	ld	s0,16(sp)
 1fc:	6105                	addi	sp,sp,32
 1fe:	8082                	ret
    printf("FAIL: sysinfo failed\n");
 200:	00001517          	auipc	a0,0x1
 204:	a6050513          	addi	a0,a0,-1440 # c60 <malloc+0x18a>
 208:	00001097          	auipc	ra,0x1
 20c:	80e080e7          	jalr	-2034(ra) # a16 <printf>
    exit(1);
 210:	4505                	li	a0,1
 212:	00000097          	auipc	ra,0x0
 216:	46e080e7          	jalr	1134(ra) # 680 <exit>
    printf("FAIL: sysinfo succeeded with bad argument\n");
 21a:	00001517          	auipc	a0,0x1
 21e:	a5e50513          	addi	a0,a0,-1442 # c78 <malloc+0x1a2>
 222:	00000097          	auipc	ra,0x0
 226:	7f4080e7          	jalr	2036(ra) # a16 <printf>
    exit(1);
 22a:	4505                	li	a0,1
 22c:	00000097          	auipc	ra,0x0
 230:	454080e7          	jalr	1108(ra) # 680 <exit>

0000000000000234 <testproc>:

void testproc() {
 234:	7139                	addi	sp,sp,-64
 236:	fc06                	sd	ra,56(sp)
 238:	f822                	sd	s0,48(sp)
 23a:	f426                	sd	s1,40(sp)
 23c:	0080                	addi	s0,sp,64
  struct sysinfo info;
  uint64 nproc;
  int status;
  int pid;
  
  sinfo(&info);
 23e:	fd040513          	addi	a0,s0,-48
 242:	00000097          	auipc	ra,0x0
 246:	dbe080e7          	jalr	-578(ra) # 0 <sinfo>
  nproc = info.nproc;
 24a:	fd843483          	ld	s1,-40(s0)

  pid = fork();
 24e:	00000097          	auipc	ra,0x0
 252:	42a080e7          	jalr	1066(ra) # 678 <fork>
  if(pid < 0){
 256:	02054c63          	bltz	a0,28e <testproc+0x5a>
    printf("sysinfotest: fork failed\n");
    exit(1);
  }
  if(pid == 0){
 25a:	ed21                	bnez	a0,2b2 <testproc+0x7e>
    sinfo(&info);
 25c:	fd040513          	addi	a0,s0,-48
 260:	00000097          	auipc	ra,0x0
 264:	da0080e7          	jalr	-608(ra) # 0 <sinfo>
    if(info.nproc != nproc+1) {
 268:	fd843583          	ld	a1,-40(s0)
 26c:	00148613          	addi	a2,s1,1
 270:	02c58c63          	beq	a1,a2,2a8 <testproc+0x74>
      printf("sysinfotest: FAIL nproc is %d instead of %d\n", info.nproc, nproc+1);
 274:	00001517          	auipc	a0,0x1
 278:	a5450513          	addi	a0,a0,-1452 # cc8 <malloc+0x1f2>
 27c:	00000097          	auipc	ra,0x0
 280:	79a080e7          	jalr	1946(ra) # a16 <printf>
      exit(1);
 284:	4505                	li	a0,1
 286:	00000097          	auipc	ra,0x0
 28a:	3fa080e7          	jalr	1018(ra) # 680 <exit>
    printf("sysinfotest: fork failed\n");
 28e:	00001517          	auipc	a0,0x1
 292:	a1a50513          	addi	a0,a0,-1510 # ca8 <malloc+0x1d2>
 296:	00000097          	auipc	ra,0x0
 29a:	780080e7          	jalr	1920(ra) # a16 <printf>
    exit(1);
 29e:	4505                	li	a0,1
 2a0:	00000097          	auipc	ra,0x0
 2a4:	3e0080e7          	jalr	992(ra) # 680 <exit>
    }
    exit(0);
 2a8:	4501                	li	a0,0
 2aa:	00000097          	auipc	ra,0x0
 2ae:	3d6080e7          	jalr	982(ra) # 680 <exit>
  }
  wait(&status);
 2b2:	fcc40513          	addi	a0,s0,-52
 2b6:	00000097          	auipc	ra,0x0
 2ba:	3d2080e7          	jalr	978(ra) # 688 <wait>
  sinfo(&info);
 2be:	fd040513          	addi	a0,s0,-48
 2c2:	00000097          	auipc	ra,0x0
 2c6:	d3e080e7          	jalr	-706(ra) # 0 <sinfo>
  if(info.nproc != nproc) {
 2ca:	fd843583          	ld	a1,-40(s0)
 2ce:	00959763          	bne	a1,s1,2dc <testproc+0xa8>
      printf("sysinfotest: FAIL nproc is %d instead of %d\n", info.nproc, nproc);
      exit(1);
  }
}
 2d2:	70e2                	ld	ra,56(sp)
 2d4:	7442                	ld	s0,48(sp)
 2d6:	74a2                	ld	s1,40(sp)
 2d8:	6121                	addi	sp,sp,64
 2da:	8082                	ret
      printf("sysinfotest: FAIL nproc is %d instead of %d\n", info.nproc, nproc);
 2dc:	8626                	mv	a2,s1
 2de:	00001517          	auipc	a0,0x1
 2e2:	9ea50513          	addi	a0,a0,-1558 # cc8 <malloc+0x1f2>
 2e6:	00000097          	auipc	ra,0x0
 2ea:	730080e7          	jalr	1840(ra) # a16 <printf>
      exit(1);
 2ee:	4505                	li	a0,1
 2f0:	00000097          	auipc	ra,0x0
 2f4:	390080e7          	jalr	912(ra) # 680 <exit>

00000000000002f8 <testbad>:

void testbad() {
 2f8:	1101                	addi	sp,sp,-32
 2fa:	ec06                	sd	ra,24(sp)
 2fc:	e822                	sd	s0,16(sp)
 2fe:	1000                	addi	s0,sp,32
  int pid = fork();
 300:	00000097          	auipc	ra,0x0
 304:	378080e7          	jalr	888(ra) # 678 <fork>
  int xstatus;
  
  if(pid < 0){
 308:	00054c63          	bltz	a0,320 <testbad+0x28>
    printf("sysinfotest: fork failed\n");
    exit(1);
  }
  if(pid == 0){
 30c:	e51d                	bnez	a0,33a <testbad+0x42>
      sinfo(0x0);
 30e:	00000097          	auipc	ra,0x0
 312:	cf2080e7          	jalr	-782(ra) # 0 <sinfo>
      exit(0);
 316:	4501                	li	a0,0
 318:	00000097          	auipc	ra,0x0
 31c:	368080e7          	jalr	872(ra) # 680 <exit>
    printf("sysinfotest: fork failed\n");
 320:	00001517          	auipc	a0,0x1
 324:	98850513          	addi	a0,a0,-1656 # ca8 <malloc+0x1d2>
 328:	00000097          	auipc	ra,0x0
 32c:	6ee080e7          	jalr	1774(ra) # a16 <printf>
    exit(1);
 330:	4505                	li	a0,1
 332:	00000097          	auipc	ra,0x0
 336:	34e080e7          	jalr	846(ra) # 680 <exit>
  }
  wait(&xstatus);
 33a:	fec40513          	addi	a0,s0,-20
 33e:	00000097          	auipc	ra,0x0
 342:	34a080e7          	jalr	842(ra) # 688 <wait>
  if(xstatus == -1)  // kernel killed child?
 346:	fec42583          	lw	a1,-20(s0)
 34a:	57fd                	li	a5,-1
 34c:	02f58063          	beq	a1,a5,36c <testbad+0x74>
    exit(0);
  else {
    printf("sysinfotest: testbad succeeded %d\n", xstatus);
 350:	00001517          	auipc	a0,0x1
 354:	9a850513          	addi	a0,a0,-1624 # cf8 <malloc+0x222>
 358:	00000097          	auipc	ra,0x0
 35c:	6be080e7          	jalr	1726(ra) # a16 <printf>
    exit(xstatus);
 360:	fec42503          	lw	a0,-20(s0)
 364:	00000097          	auipc	ra,0x0
 368:	31c080e7          	jalr	796(ra) # 680 <exit>
    exit(0);
 36c:	4501                	li	a0,0
 36e:	00000097          	auipc	ra,0x0
 372:	312080e7          	jalr	786(ra) # 680 <exit>

0000000000000376 <main>:
  }
}

int
main(int argc, char *argv[])
{
 376:	1141                	addi	sp,sp,-16
 378:	e406                	sd	ra,8(sp)
 37a:	e022                	sd	s0,0(sp)
 37c:	0800                	addi	s0,sp,16
  printf("sysinfotest: start\n");
 37e:	00001517          	auipc	a0,0x1
 382:	9a250513          	addi	a0,a0,-1630 # d20 <malloc+0x24a>
 386:	00000097          	auipc	ra,0x0
 38a:	690080e7          	jalr	1680(ra) # a16 <printf>
  testcall();
 38e:	00000097          	auipc	ra,0x0
 392:	e3a080e7          	jalr	-454(ra) # 1c8 <testcall>
  testmem();
 396:	00000097          	auipc	ra,0x0
 39a:	d2a080e7          	jalr	-726(ra) # c0 <testmem>
  testproc();
 39e:	00000097          	auipc	ra,0x0
 3a2:	e96080e7          	jalr	-362(ra) # 234 <testproc>
  printf("sysinfotest: OK\n");
 3a6:	00001517          	auipc	a0,0x1
 3aa:	99250513          	addi	a0,a0,-1646 # d38 <malloc+0x262>
 3ae:	00000097          	auipc	ra,0x0
 3b2:	668080e7          	jalr	1640(ra) # a16 <printf>
  exit(0);
 3b6:	4501                	li	a0,0
 3b8:	00000097          	auipc	ra,0x0
 3bc:	2c8080e7          	jalr	712(ra) # 680 <exit>

00000000000003c0 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 3c0:	1141                	addi	sp,sp,-16
 3c2:	e406                	sd	ra,8(sp)
 3c4:	e022                	sd	s0,0(sp)
 3c6:	0800                	addi	s0,sp,16
  extern int main();
  main();
 3c8:	00000097          	auipc	ra,0x0
 3cc:	fae080e7          	jalr	-82(ra) # 376 <main>
  exit(0);
 3d0:	4501                	li	a0,0
 3d2:	00000097          	auipc	ra,0x0
 3d6:	2ae080e7          	jalr	686(ra) # 680 <exit>

00000000000003da <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 3da:	1141                	addi	sp,sp,-16
 3dc:	e422                	sd	s0,8(sp)
 3de:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 3e0:	87aa                	mv	a5,a0
 3e2:	0585                	addi	a1,a1,1
 3e4:	0785                	addi	a5,a5,1
 3e6:	fff5c703          	lbu	a4,-1(a1) # ffffffffffffefff <base+0xffffffffffffdfef>
 3ea:	fee78fa3          	sb	a4,-1(a5)
 3ee:	fb75                	bnez	a4,3e2 <strcpy+0x8>
    ;
  return os;
}
 3f0:	6422                	ld	s0,8(sp)
 3f2:	0141                	addi	sp,sp,16
 3f4:	8082                	ret

00000000000003f6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3f6:	1141                	addi	sp,sp,-16
 3f8:	e422                	sd	s0,8(sp)
 3fa:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 3fc:	00054783          	lbu	a5,0(a0)
 400:	cf91                	beqz	a5,41c <strcmp+0x26>
 402:	0005c703          	lbu	a4,0(a1)
 406:	00f71b63          	bne	a4,a5,41c <strcmp+0x26>
    p++, q++;
 40a:	0505                	addi	a0,a0,1
 40c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 40e:	00054783          	lbu	a5,0(a0)
 412:	c789                	beqz	a5,41c <strcmp+0x26>
 414:	0005c703          	lbu	a4,0(a1)
 418:	fef709e3          	beq	a4,a5,40a <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 41c:	0005c503          	lbu	a0,0(a1)
}
 420:	40a7853b          	subw	a0,a5,a0
 424:	6422                	ld	s0,8(sp)
 426:	0141                	addi	sp,sp,16
 428:	8082                	ret

000000000000042a <strlen>:

uint
strlen(const char *s)
{
 42a:	1141                	addi	sp,sp,-16
 42c:	e422                	sd	s0,8(sp)
 42e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 430:	00054783          	lbu	a5,0(a0)
 434:	cf91                	beqz	a5,450 <strlen+0x26>
 436:	0505                	addi	a0,a0,1
 438:	87aa                	mv	a5,a0
 43a:	4685                	li	a3,1
 43c:	9e89                	subw	a3,a3,a0
    ;
 43e:	00f6853b          	addw	a0,a3,a5
 442:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
 444:	fff7c703          	lbu	a4,-1(a5)
 448:	fb7d                	bnez	a4,43e <strlen+0x14>
  return n;
}
 44a:	6422                	ld	s0,8(sp)
 44c:	0141                	addi	sp,sp,16
 44e:	8082                	ret
  for(n = 0; s[n]; n++)
 450:	4501                	li	a0,0
 452:	bfe5                	j	44a <strlen+0x20>

0000000000000454 <memset>:

void*
memset(void *dst, int c, uint n)
{
 454:	1141                	addi	sp,sp,-16
 456:	e422                	sd	s0,8(sp)
 458:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 45a:	ce09                	beqz	a2,474 <memset+0x20>
 45c:	87aa                	mv	a5,a0
 45e:	fff6071b          	addiw	a4,a2,-1
 462:	1702                	slli	a4,a4,0x20
 464:	9301                	srli	a4,a4,0x20
 466:	0705                	addi	a4,a4,1
 468:	972a                	add	a4,a4,a0
    cdst[i] = c;
 46a:	00b78023          	sb	a1,0(a5)
 46e:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
 470:	fee79de3          	bne	a5,a4,46a <memset+0x16>
  }
  return dst;
}
 474:	6422                	ld	s0,8(sp)
 476:	0141                	addi	sp,sp,16
 478:	8082                	ret

000000000000047a <strchr>:

char*
strchr(const char *s, char c)
{
 47a:	1141                	addi	sp,sp,-16
 47c:	e422                	sd	s0,8(sp)
 47e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 480:	00054783          	lbu	a5,0(a0)
 484:	cf91                	beqz	a5,4a0 <strchr+0x26>
    if(*s == c)
 486:	00f58a63          	beq	a1,a5,49a <strchr+0x20>
  for(; *s; s++)
 48a:	0505                	addi	a0,a0,1
 48c:	00054783          	lbu	a5,0(a0)
 490:	c781                	beqz	a5,498 <strchr+0x1e>
    if(*s == c)
 492:	feb79ce3          	bne	a5,a1,48a <strchr+0x10>
 496:	a011                	j	49a <strchr+0x20>
      return (char*)s;
  return 0;
 498:	4501                	li	a0,0
}
 49a:	6422                	ld	s0,8(sp)
 49c:	0141                	addi	sp,sp,16
 49e:	8082                	ret
  return 0;
 4a0:	4501                	li	a0,0
 4a2:	bfe5                	j	49a <strchr+0x20>

00000000000004a4 <gets>:

char*
gets(char *buf, int max)
{
 4a4:	711d                	addi	sp,sp,-96
 4a6:	ec86                	sd	ra,88(sp)
 4a8:	e8a2                	sd	s0,80(sp)
 4aa:	e4a6                	sd	s1,72(sp)
 4ac:	e0ca                	sd	s2,64(sp)
 4ae:	fc4e                	sd	s3,56(sp)
 4b0:	f852                	sd	s4,48(sp)
 4b2:	f456                	sd	s5,40(sp)
 4b4:	f05a                	sd	s6,32(sp)
 4b6:	ec5e                	sd	s7,24(sp)
 4b8:	1080                	addi	s0,sp,96
 4ba:	8baa                	mv	s7,a0
 4bc:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4be:	892a                	mv	s2,a0
 4c0:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 4c2:	4aa9                	li	s5,10
 4c4:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 4c6:	0019849b          	addiw	s1,s3,1
 4ca:	0344d863          	bge	s1,s4,4fa <gets+0x56>
    cc = read(0, &c, 1);
 4ce:	4605                	li	a2,1
 4d0:	faf40593          	addi	a1,s0,-81
 4d4:	4501                	li	a0,0
 4d6:	00000097          	auipc	ra,0x0
 4da:	1c2080e7          	jalr	450(ra) # 698 <read>
    if(cc < 1)
 4de:	00a05e63          	blez	a0,4fa <gets+0x56>
    buf[i++] = c;
 4e2:	faf44783          	lbu	a5,-81(s0)
 4e6:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 4ea:	01578763          	beq	a5,s5,4f8 <gets+0x54>
 4ee:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
 4f0:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
 4f2:	fd679ae3          	bne	a5,s6,4c6 <gets+0x22>
 4f6:	a011                	j	4fa <gets+0x56>
  for(i=0; i+1 < max; ){
 4f8:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 4fa:	99de                	add	s3,s3,s7
 4fc:	00098023          	sb	zero,0(s3) # 1000 <freep>
  return buf;
}
 500:	855e                	mv	a0,s7
 502:	60e6                	ld	ra,88(sp)
 504:	6446                	ld	s0,80(sp)
 506:	64a6                	ld	s1,72(sp)
 508:	6906                	ld	s2,64(sp)
 50a:	79e2                	ld	s3,56(sp)
 50c:	7a42                	ld	s4,48(sp)
 50e:	7aa2                	ld	s5,40(sp)
 510:	7b02                	ld	s6,32(sp)
 512:	6be2                	ld	s7,24(sp)
 514:	6125                	addi	sp,sp,96
 516:	8082                	ret

0000000000000518 <stat>:

int
stat(const char *n, struct stat *st)
{
 518:	1101                	addi	sp,sp,-32
 51a:	ec06                	sd	ra,24(sp)
 51c:	e822                	sd	s0,16(sp)
 51e:	e426                	sd	s1,8(sp)
 520:	e04a                	sd	s2,0(sp)
 522:	1000                	addi	s0,sp,32
 524:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 526:	4581                	li	a1,0
 528:	00000097          	auipc	ra,0x0
 52c:	198080e7          	jalr	408(ra) # 6c0 <open>
  if(fd < 0)
 530:	02054563          	bltz	a0,55a <stat+0x42>
 534:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 536:	85ca                	mv	a1,s2
 538:	00000097          	auipc	ra,0x0
 53c:	1a0080e7          	jalr	416(ra) # 6d8 <fstat>
 540:	892a                	mv	s2,a0
  close(fd);
 542:	8526                	mv	a0,s1
 544:	00000097          	auipc	ra,0x0
 548:	164080e7          	jalr	356(ra) # 6a8 <close>
  return r;
}
 54c:	854a                	mv	a0,s2
 54e:	60e2                	ld	ra,24(sp)
 550:	6442                	ld	s0,16(sp)
 552:	64a2                	ld	s1,8(sp)
 554:	6902                	ld	s2,0(sp)
 556:	6105                	addi	sp,sp,32
 558:	8082                	ret
    return -1;
 55a:	597d                	li	s2,-1
 55c:	bfc5                	j	54c <stat+0x34>

000000000000055e <atoi>:

int
atoi(const char *s)
{
 55e:	1141                	addi	sp,sp,-16
 560:	e422                	sd	s0,8(sp)
 562:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 564:	00054683          	lbu	a3,0(a0)
 568:	fd06879b          	addiw	a5,a3,-48
 56c:	0ff7f793          	andi	a5,a5,255
 570:	4725                	li	a4,9
 572:	02f76963          	bltu	a4,a5,5a4 <atoi+0x46>
 576:	862a                	mv	a2,a0
  n = 0;
 578:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 57a:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 57c:	0605                	addi	a2,a2,1
 57e:	0025179b          	slliw	a5,a0,0x2
 582:	9fa9                	addw	a5,a5,a0
 584:	0017979b          	slliw	a5,a5,0x1
 588:	9fb5                	addw	a5,a5,a3
 58a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 58e:	00064683          	lbu	a3,0(a2)
 592:	fd06871b          	addiw	a4,a3,-48
 596:	0ff77713          	andi	a4,a4,255
 59a:	fee5f1e3          	bgeu	a1,a4,57c <atoi+0x1e>
  return n;
}
 59e:	6422                	ld	s0,8(sp)
 5a0:	0141                	addi	sp,sp,16
 5a2:	8082                	ret
  n = 0;
 5a4:	4501                	li	a0,0
 5a6:	bfe5                	j	59e <atoi+0x40>

00000000000005a8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5a8:	1141                	addi	sp,sp,-16
 5aa:	e422                	sd	s0,8(sp)
 5ac:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 5ae:	02b57663          	bgeu	a0,a1,5da <memmove+0x32>
    while(n-- > 0)
 5b2:	02c05163          	blez	a2,5d4 <memmove+0x2c>
 5b6:	fff6079b          	addiw	a5,a2,-1
 5ba:	1782                	slli	a5,a5,0x20
 5bc:	9381                	srli	a5,a5,0x20
 5be:	0785                	addi	a5,a5,1
 5c0:	97aa                	add	a5,a5,a0
  dst = vdst;
 5c2:	872a                	mv	a4,a0
      *dst++ = *src++;
 5c4:	0585                	addi	a1,a1,1
 5c6:	0705                	addi	a4,a4,1
 5c8:	fff5c683          	lbu	a3,-1(a1)
 5cc:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 5d0:	fee79ae3          	bne	a5,a4,5c4 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 5d4:	6422                	ld	s0,8(sp)
 5d6:	0141                	addi	sp,sp,16
 5d8:	8082                	ret
    dst += n;
 5da:	00c50733          	add	a4,a0,a2
    src += n;
 5de:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 5e0:	fec05ae3          	blez	a2,5d4 <memmove+0x2c>
 5e4:	fff6079b          	addiw	a5,a2,-1
 5e8:	1782                	slli	a5,a5,0x20
 5ea:	9381                	srli	a5,a5,0x20
 5ec:	fff7c793          	not	a5,a5
 5f0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 5f2:	15fd                	addi	a1,a1,-1
 5f4:	177d                	addi	a4,a4,-1
 5f6:	0005c683          	lbu	a3,0(a1)
 5fa:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 5fe:	fef71ae3          	bne	a4,a5,5f2 <memmove+0x4a>
 602:	bfc9                	j	5d4 <memmove+0x2c>

0000000000000604 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 604:	1141                	addi	sp,sp,-16
 606:	e422                	sd	s0,8(sp)
 608:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 60a:	ce15                	beqz	a2,646 <memcmp+0x42>
 60c:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
 610:	00054783          	lbu	a5,0(a0)
 614:	0005c703          	lbu	a4,0(a1)
 618:	02e79063          	bne	a5,a4,638 <memcmp+0x34>
 61c:	1682                	slli	a3,a3,0x20
 61e:	9281                	srli	a3,a3,0x20
 620:	0685                	addi	a3,a3,1
 622:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
 624:	0505                	addi	a0,a0,1
    p2++;
 626:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 628:	00d50d63          	beq	a0,a3,642 <memcmp+0x3e>
    if (*p1 != *p2) {
 62c:	00054783          	lbu	a5,0(a0)
 630:	0005c703          	lbu	a4,0(a1)
 634:	fee788e3          	beq	a5,a4,624 <memcmp+0x20>
      return *p1 - *p2;
 638:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
 63c:	6422                	ld	s0,8(sp)
 63e:	0141                	addi	sp,sp,16
 640:	8082                	ret
  return 0;
 642:	4501                	li	a0,0
 644:	bfe5                	j	63c <memcmp+0x38>
 646:	4501                	li	a0,0
 648:	bfd5                	j	63c <memcmp+0x38>

000000000000064a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 64a:	1141                	addi	sp,sp,-16
 64c:	e406                	sd	ra,8(sp)
 64e:	e022                	sd	s0,0(sp)
 650:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 652:	00000097          	auipc	ra,0x0
 656:	f56080e7          	jalr	-170(ra) # 5a8 <memmove>
}
 65a:	60a2                	ld	ra,8(sp)
 65c:	6402                	ld	s0,0(sp)
 65e:	0141                	addi	sp,sp,16
 660:	8082                	ret

0000000000000662 <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
 662:	1141                	addi	sp,sp,-16
 664:	e422                	sd	s0,8(sp)
 666:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 668:	040007b7          	lui	a5,0x4000
}
 66c:	17f5                	addi	a5,a5,-3
 66e:	07b2                	slli	a5,a5,0xc
 670:	4388                	lw	a0,0(a5)
 672:	6422                	ld	s0,8(sp)
 674:	0141                	addi	sp,sp,16
 676:	8082                	ret

0000000000000678 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 678:	4885                	li	a7,1
 ecall
 67a:	00000073          	ecall
 ret
 67e:	8082                	ret

0000000000000680 <exit>:
.global exit
exit:
 li a7, SYS_exit
 680:	4889                	li	a7,2
 ecall
 682:	00000073          	ecall
 ret
 686:	8082                	ret

0000000000000688 <wait>:
.global wait
wait:
 li a7, SYS_wait
 688:	488d                	li	a7,3
 ecall
 68a:	00000073          	ecall
 ret
 68e:	8082                	ret

0000000000000690 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 690:	4891                	li	a7,4
 ecall
 692:	00000073          	ecall
 ret
 696:	8082                	ret

0000000000000698 <read>:
.global read
read:
 li a7, SYS_read
 698:	4895                	li	a7,5
 ecall
 69a:	00000073          	ecall
 ret
 69e:	8082                	ret

00000000000006a0 <write>:
.global write
write:
 li a7, SYS_write
 6a0:	48c1                	li	a7,16
 ecall
 6a2:	00000073          	ecall
 ret
 6a6:	8082                	ret

00000000000006a8 <close>:
.global close
close:
 li a7, SYS_close
 6a8:	48d5                	li	a7,21
 ecall
 6aa:	00000073          	ecall
 ret
 6ae:	8082                	ret

00000000000006b0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 6b0:	4899                	li	a7,6
 ecall
 6b2:	00000073          	ecall
 ret
 6b6:	8082                	ret

00000000000006b8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 6b8:	489d                	li	a7,7
 ecall
 6ba:	00000073          	ecall
 ret
 6be:	8082                	ret

00000000000006c0 <open>:
.global open
open:
 li a7, SYS_open
 6c0:	48bd                	li	a7,15
 ecall
 6c2:	00000073          	ecall
 ret
 6c6:	8082                	ret

00000000000006c8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6c8:	48c5                	li	a7,17
 ecall
 6ca:	00000073          	ecall
 ret
 6ce:	8082                	ret

00000000000006d0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6d0:	48c9                	li	a7,18
 ecall
 6d2:	00000073          	ecall
 ret
 6d6:	8082                	ret

00000000000006d8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6d8:	48a1                	li	a7,8
 ecall
 6da:	00000073          	ecall
 ret
 6de:	8082                	ret

00000000000006e0 <link>:
.global link
link:
 li a7, SYS_link
 6e0:	48cd                	li	a7,19
 ecall
 6e2:	00000073          	ecall
 ret
 6e6:	8082                	ret

00000000000006e8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6e8:	48d1                	li	a7,20
 ecall
 6ea:	00000073          	ecall
 ret
 6ee:	8082                	ret

00000000000006f0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6f0:	48a5                	li	a7,9
 ecall
 6f2:	00000073          	ecall
 ret
 6f6:	8082                	ret

00000000000006f8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 6f8:	48a9                	li	a7,10
 ecall
 6fa:	00000073          	ecall
 ret
 6fe:	8082                	ret

0000000000000700 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 700:	48ad                	li	a7,11
 ecall
 702:	00000073          	ecall
 ret
 706:	8082                	ret

0000000000000708 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 708:	48b1                	li	a7,12
 ecall
 70a:	00000073          	ecall
 ret
 70e:	8082                	ret

0000000000000710 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 710:	48b5                	li	a7,13
 ecall
 712:	00000073          	ecall
 ret
 716:	8082                	ret

0000000000000718 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 718:	48b9                	li	a7,14
 ecall
 71a:	00000073          	ecall
 ret
 71e:	8082                	ret

0000000000000720 <trace>:
.global trace
trace:
 li a7, SYS_trace
 720:	48d9                	li	a7,22
 ecall
 722:	00000073          	ecall
 ret
 726:	8082                	ret

0000000000000728 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 728:	48dd                	li	a7,23
 ecall
 72a:	00000073          	ecall
 ret
 72e:	8082                	ret

0000000000000730 <connect>:
.global connect
connect:
 li a7, SYS_connect
 730:	48f5                	li	a7,29
 ecall
 732:	00000073          	ecall
 ret
 736:	8082                	ret

0000000000000738 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 738:	48f9                	li	a7,30
 ecall
 73a:	00000073          	ecall
 ret
 73e:	8082                	ret

0000000000000740 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 740:	1101                	addi	sp,sp,-32
 742:	ec06                	sd	ra,24(sp)
 744:	e822                	sd	s0,16(sp)
 746:	1000                	addi	s0,sp,32
 748:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 74c:	4605                	li	a2,1
 74e:	fef40593          	addi	a1,s0,-17
 752:	00000097          	auipc	ra,0x0
 756:	f4e080e7          	jalr	-178(ra) # 6a0 <write>
}
 75a:	60e2                	ld	ra,24(sp)
 75c:	6442                	ld	s0,16(sp)
 75e:	6105                	addi	sp,sp,32
 760:	8082                	ret

0000000000000762 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 762:	7139                	addi	sp,sp,-64
 764:	fc06                	sd	ra,56(sp)
 766:	f822                	sd	s0,48(sp)
 768:	f426                	sd	s1,40(sp)
 76a:	f04a                	sd	s2,32(sp)
 76c:	ec4e                	sd	s3,24(sp)
 76e:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 770:	c299                	beqz	a3,776 <printint+0x14>
 772:	0005cd63          	bltz	a1,78c <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 776:	2581                	sext.w	a1,a1
  neg = 0;
 778:	4301                	li	t1,0
 77a:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
 77e:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
 780:	2601                	sext.w	a2,a2
 782:	00000897          	auipc	a7,0x0
 786:	5ce88893          	addi	a7,a7,1486 # d50 <digits>
 78a:	a039                	j	798 <printint+0x36>
    x = -xx;
 78c:	40b005bb          	negw	a1,a1
    neg = 1;
 790:	4305                	li	t1,1
    x = -xx;
 792:	b7e5                	j	77a <printint+0x18>
  }while((x /= base) != 0);
 794:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
 796:	8836                	mv	a6,a3
 798:	0018069b          	addiw	a3,a6,1
 79c:	02c5f7bb          	remuw	a5,a1,a2
 7a0:	1782                	slli	a5,a5,0x20
 7a2:	9381                	srli	a5,a5,0x20
 7a4:	97c6                	add	a5,a5,a7
 7a6:	0007c783          	lbu	a5,0(a5) # 4000000 <base+0x3ffeff0>
 7aa:	00f70023          	sb	a5,0(a4)
 7ae:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
 7b0:	02c5d7bb          	divuw	a5,a1,a2
 7b4:	fec5f0e3          	bgeu	a1,a2,794 <printint+0x32>
  if(neg)
 7b8:	00030b63          	beqz	t1,7ce <printint+0x6c>
    buf[i++] = '-';
 7bc:	fd040793          	addi	a5,s0,-48
 7c0:	96be                	add	a3,a3,a5
 7c2:	02d00793          	li	a5,45
 7c6:	fef68823          	sb	a5,-16(a3)
 7ca:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
 7ce:	02d05963          	blez	a3,800 <printint+0x9e>
 7d2:	89aa                	mv	s3,a0
 7d4:	fc040793          	addi	a5,s0,-64
 7d8:	00d784b3          	add	s1,a5,a3
 7dc:	fff78913          	addi	s2,a5,-1
 7e0:	9936                	add	s2,s2,a3
 7e2:	36fd                	addiw	a3,a3,-1
 7e4:	1682                	slli	a3,a3,0x20
 7e6:	9281                	srli	a3,a3,0x20
 7e8:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
 7ec:	fff4c583          	lbu	a1,-1(s1)
 7f0:	854e                	mv	a0,s3
 7f2:	00000097          	auipc	ra,0x0
 7f6:	f4e080e7          	jalr	-178(ra) # 740 <putc>
 7fa:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
 7fc:	ff2498e3          	bne	s1,s2,7ec <printint+0x8a>
}
 800:	70e2                	ld	ra,56(sp)
 802:	7442                	ld	s0,48(sp)
 804:	74a2                	ld	s1,40(sp)
 806:	7902                	ld	s2,32(sp)
 808:	69e2                	ld	s3,24(sp)
 80a:	6121                	addi	sp,sp,64
 80c:	8082                	ret

000000000000080e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 80e:	7119                	addi	sp,sp,-128
 810:	fc86                	sd	ra,120(sp)
 812:	f8a2                	sd	s0,112(sp)
 814:	f4a6                	sd	s1,104(sp)
 816:	f0ca                	sd	s2,96(sp)
 818:	ecce                	sd	s3,88(sp)
 81a:	e8d2                	sd	s4,80(sp)
 81c:	e4d6                	sd	s5,72(sp)
 81e:	e0da                	sd	s6,64(sp)
 820:	fc5e                	sd	s7,56(sp)
 822:	f862                	sd	s8,48(sp)
 824:	f466                	sd	s9,40(sp)
 826:	f06a                	sd	s10,32(sp)
 828:	ec6e                	sd	s11,24(sp)
 82a:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 82c:	0005c483          	lbu	s1,0(a1)
 830:	18048d63          	beqz	s1,9ca <vprintf+0x1bc>
 834:	8aaa                	mv	s5,a0
 836:	8b32                	mv	s6,a2
 838:	00158913          	addi	s2,a1,1
  state = 0;
 83c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 83e:	02500a13          	li	s4,37
      if(c == 'd'){
 842:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 846:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 84a:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 84e:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 852:	00000b97          	auipc	s7,0x0
 856:	4feb8b93          	addi	s7,s7,1278 # d50 <digits>
 85a:	a839                	j	878 <vprintf+0x6a>
        putc(fd, c);
 85c:	85a6                	mv	a1,s1
 85e:	8556                	mv	a0,s5
 860:	00000097          	auipc	ra,0x0
 864:	ee0080e7          	jalr	-288(ra) # 740 <putc>
 868:	a019                	j	86e <vprintf+0x60>
    } else if(state == '%'){
 86a:	01498f63          	beq	s3,s4,888 <vprintf+0x7a>
 86e:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
 870:	fff94483          	lbu	s1,-1(s2)
 874:	14048b63          	beqz	s1,9ca <vprintf+0x1bc>
    c = fmt[i] & 0xff;
 878:	0004879b          	sext.w	a5,s1
    if(state == 0){
 87c:	fe0997e3          	bnez	s3,86a <vprintf+0x5c>
      if(c == '%'){
 880:	fd479ee3          	bne	a5,s4,85c <vprintf+0x4e>
        state = '%';
 884:	89be                	mv	s3,a5
 886:	b7e5                	j	86e <vprintf+0x60>
      if(c == 'd'){
 888:	05878063          	beq	a5,s8,8c8 <vprintf+0xba>
      } else if(c == 'l') {
 88c:	05978c63          	beq	a5,s9,8e4 <vprintf+0xd6>
      } else if(c == 'x') {
 890:	07a78863          	beq	a5,s10,900 <vprintf+0xf2>
      } else if(c == 'p') {
 894:	09b78463          	beq	a5,s11,91c <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 898:	07300713          	li	a4,115
 89c:	0ce78563          	beq	a5,a4,966 <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8a0:	06300713          	li	a4,99
 8a4:	0ee78c63          	beq	a5,a4,99c <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 8a8:	11478663          	beq	a5,s4,9b4 <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8ac:	85d2                	mv	a1,s4
 8ae:	8556                	mv	a0,s5
 8b0:	00000097          	auipc	ra,0x0
 8b4:	e90080e7          	jalr	-368(ra) # 740 <putc>
        putc(fd, c);
 8b8:	85a6                	mv	a1,s1
 8ba:	8556                	mv	a0,s5
 8bc:	00000097          	auipc	ra,0x0
 8c0:	e84080e7          	jalr	-380(ra) # 740 <putc>
      }
      state = 0;
 8c4:	4981                	li	s3,0
 8c6:	b765                	j	86e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 8c8:	008b0493          	addi	s1,s6,8
 8cc:	4685                	li	a3,1
 8ce:	4629                	li	a2,10
 8d0:	000b2583          	lw	a1,0(s6)
 8d4:	8556                	mv	a0,s5
 8d6:	00000097          	auipc	ra,0x0
 8da:	e8c080e7          	jalr	-372(ra) # 762 <printint>
 8de:	8b26                	mv	s6,s1
      state = 0;
 8e0:	4981                	li	s3,0
 8e2:	b771                	j	86e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8e4:	008b0493          	addi	s1,s6,8
 8e8:	4681                	li	a3,0
 8ea:	4629                	li	a2,10
 8ec:	000b2583          	lw	a1,0(s6)
 8f0:	8556                	mv	a0,s5
 8f2:	00000097          	auipc	ra,0x0
 8f6:	e70080e7          	jalr	-400(ra) # 762 <printint>
 8fa:	8b26                	mv	s6,s1
      state = 0;
 8fc:	4981                	li	s3,0
 8fe:	bf85                	j	86e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 900:	008b0493          	addi	s1,s6,8
 904:	4681                	li	a3,0
 906:	4641                	li	a2,16
 908:	000b2583          	lw	a1,0(s6)
 90c:	8556                	mv	a0,s5
 90e:	00000097          	auipc	ra,0x0
 912:	e54080e7          	jalr	-428(ra) # 762 <printint>
 916:	8b26                	mv	s6,s1
      state = 0;
 918:	4981                	li	s3,0
 91a:	bf91                	j	86e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 91c:	008b0793          	addi	a5,s6,8
 920:	f8f43423          	sd	a5,-120(s0)
 924:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 928:	03000593          	li	a1,48
 92c:	8556                	mv	a0,s5
 92e:	00000097          	auipc	ra,0x0
 932:	e12080e7          	jalr	-494(ra) # 740 <putc>
  putc(fd, 'x');
 936:	85ea                	mv	a1,s10
 938:	8556                	mv	a0,s5
 93a:	00000097          	auipc	ra,0x0
 93e:	e06080e7          	jalr	-506(ra) # 740 <putc>
 942:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 944:	03c9d793          	srli	a5,s3,0x3c
 948:	97de                	add	a5,a5,s7
 94a:	0007c583          	lbu	a1,0(a5)
 94e:	8556                	mv	a0,s5
 950:	00000097          	auipc	ra,0x0
 954:	df0080e7          	jalr	-528(ra) # 740 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 958:	0992                	slli	s3,s3,0x4
 95a:	34fd                	addiw	s1,s1,-1
 95c:	f4e5                	bnez	s1,944 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 95e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 962:	4981                	li	s3,0
 964:	b729                	j	86e <vprintf+0x60>
        s = va_arg(ap, char*);
 966:	008b0993          	addi	s3,s6,8
 96a:	000b3483          	ld	s1,0(s6)
        if(s == 0)
 96e:	c085                	beqz	s1,98e <vprintf+0x180>
        while(*s != 0){
 970:	0004c583          	lbu	a1,0(s1)
 974:	c9a1                	beqz	a1,9c4 <vprintf+0x1b6>
          putc(fd, *s);
 976:	8556                	mv	a0,s5
 978:	00000097          	auipc	ra,0x0
 97c:	dc8080e7          	jalr	-568(ra) # 740 <putc>
          s++;
 980:	0485                	addi	s1,s1,1
        while(*s != 0){
 982:	0004c583          	lbu	a1,0(s1)
 986:	f9e5                	bnez	a1,976 <vprintf+0x168>
        s = va_arg(ap, char*);
 988:	8b4e                	mv	s6,s3
      state = 0;
 98a:	4981                	li	s3,0
 98c:	b5cd                	j	86e <vprintf+0x60>
          s = "(null)";
 98e:	00000497          	auipc	s1,0x0
 992:	3da48493          	addi	s1,s1,986 # d68 <digits+0x18>
        while(*s != 0){
 996:	02800593          	li	a1,40
 99a:	bff1                	j	976 <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
 99c:	008b0493          	addi	s1,s6,8
 9a0:	000b4583          	lbu	a1,0(s6)
 9a4:	8556                	mv	a0,s5
 9a6:	00000097          	auipc	ra,0x0
 9aa:	d9a080e7          	jalr	-614(ra) # 740 <putc>
 9ae:	8b26                	mv	s6,s1
      state = 0;
 9b0:	4981                	li	s3,0
 9b2:	bd75                	j	86e <vprintf+0x60>
        putc(fd, c);
 9b4:	85d2                	mv	a1,s4
 9b6:	8556                	mv	a0,s5
 9b8:	00000097          	auipc	ra,0x0
 9bc:	d88080e7          	jalr	-632(ra) # 740 <putc>
      state = 0;
 9c0:	4981                	li	s3,0
 9c2:	b575                	j	86e <vprintf+0x60>
        s = va_arg(ap, char*);
 9c4:	8b4e                	mv	s6,s3
      state = 0;
 9c6:	4981                	li	s3,0
 9c8:	b55d                	j	86e <vprintf+0x60>
    }
  }
}
 9ca:	70e6                	ld	ra,120(sp)
 9cc:	7446                	ld	s0,112(sp)
 9ce:	74a6                	ld	s1,104(sp)
 9d0:	7906                	ld	s2,96(sp)
 9d2:	69e6                	ld	s3,88(sp)
 9d4:	6a46                	ld	s4,80(sp)
 9d6:	6aa6                	ld	s5,72(sp)
 9d8:	6b06                	ld	s6,64(sp)
 9da:	7be2                	ld	s7,56(sp)
 9dc:	7c42                	ld	s8,48(sp)
 9de:	7ca2                	ld	s9,40(sp)
 9e0:	7d02                	ld	s10,32(sp)
 9e2:	6de2                	ld	s11,24(sp)
 9e4:	6109                	addi	sp,sp,128
 9e6:	8082                	ret

00000000000009e8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9e8:	715d                	addi	sp,sp,-80
 9ea:	ec06                	sd	ra,24(sp)
 9ec:	e822                	sd	s0,16(sp)
 9ee:	1000                	addi	s0,sp,32
 9f0:	e010                	sd	a2,0(s0)
 9f2:	e414                	sd	a3,8(s0)
 9f4:	e818                	sd	a4,16(s0)
 9f6:	ec1c                	sd	a5,24(s0)
 9f8:	03043023          	sd	a6,32(s0)
 9fc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a00:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a04:	8622                	mv	a2,s0
 a06:	00000097          	auipc	ra,0x0
 a0a:	e08080e7          	jalr	-504(ra) # 80e <vprintf>
}
 a0e:	60e2                	ld	ra,24(sp)
 a10:	6442                	ld	s0,16(sp)
 a12:	6161                	addi	sp,sp,80
 a14:	8082                	ret

0000000000000a16 <printf>:

void
printf(const char *fmt, ...)
{
 a16:	711d                	addi	sp,sp,-96
 a18:	ec06                	sd	ra,24(sp)
 a1a:	e822                	sd	s0,16(sp)
 a1c:	1000                	addi	s0,sp,32
 a1e:	e40c                	sd	a1,8(s0)
 a20:	e810                	sd	a2,16(s0)
 a22:	ec14                	sd	a3,24(s0)
 a24:	f018                	sd	a4,32(s0)
 a26:	f41c                	sd	a5,40(s0)
 a28:	03043823          	sd	a6,48(s0)
 a2c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a30:	00840613          	addi	a2,s0,8
 a34:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a38:	85aa                	mv	a1,a0
 a3a:	4505                	li	a0,1
 a3c:	00000097          	auipc	ra,0x0
 a40:	dd2080e7          	jalr	-558(ra) # 80e <vprintf>
}
 a44:	60e2                	ld	ra,24(sp)
 a46:	6442                	ld	s0,16(sp)
 a48:	6125                	addi	sp,sp,96
 a4a:	8082                	ret

0000000000000a4c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a4c:	1141                	addi	sp,sp,-16
 a4e:	e422                	sd	s0,8(sp)
 a50:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a52:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a56:	00000797          	auipc	a5,0x0
 a5a:	5aa78793          	addi	a5,a5,1450 # 1000 <freep>
 a5e:	639c                	ld	a5,0(a5)
 a60:	a805                	j	a90 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a62:	4618                	lw	a4,8(a2)
 a64:	9db9                	addw	a1,a1,a4
 a66:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a6a:	6398                	ld	a4,0(a5)
 a6c:	6318                	ld	a4,0(a4)
 a6e:	fee53823          	sd	a4,-16(a0)
 a72:	a091                	j	ab6 <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a74:	ff852703          	lw	a4,-8(a0)
 a78:	9e39                	addw	a2,a2,a4
 a7a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 a7c:	ff053703          	ld	a4,-16(a0)
 a80:	e398                	sd	a4,0(a5)
 a82:	a099                	j	ac8 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a84:	6398                	ld	a4,0(a5)
 a86:	00e7e463          	bltu	a5,a4,a8e <free+0x42>
 a8a:	00e6ea63          	bltu	a3,a4,a9e <free+0x52>
{
 a8e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a90:	fed7fae3          	bgeu	a5,a3,a84 <free+0x38>
 a94:	6398                	ld	a4,0(a5)
 a96:	00e6e463          	bltu	a3,a4,a9e <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a9a:	fee7eae3          	bltu	a5,a4,a8e <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
 a9e:	ff852583          	lw	a1,-8(a0)
 aa2:	6390                	ld	a2,0(a5)
 aa4:	02059713          	slli	a4,a1,0x20
 aa8:	9301                	srli	a4,a4,0x20
 aaa:	0712                	slli	a4,a4,0x4
 aac:	9736                	add	a4,a4,a3
 aae:	fae60ae3          	beq	a2,a4,a62 <free+0x16>
    bp->s.ptr = p->s.ptr;
 ab2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 ab6:	4790                	lw	a2,8(a5)
 ab8:	02061713          	slli	a4,a2,0x20
 abc:	9301                	srli	a4,a4,0x20
 abe:	0712                	slli	a4,a4,0x4
 ac0:	973e                	add	a4,a4,a5
 ac2:	fae689e3          	beq	a3,a4,a74 <free+0x28>
  } else
    p->s.ptr = bp;
 ac6:	e394                	sd	a3,0(a5)
  freep = p;
 ac8:	00000717          	auipc	a4,0x0
 acc:	52f73c23          	sd	a5,1336(a4) # 1000 <freep>
}
 ad0:	6422                	ld	s0,8(sp)
 ad2:	0141                	addi	sp,sp,16
 ad4:	8082                	ret

0000000000000ad6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ad6:	7139                	addi	sp,sp,-64
 ad8:	fc06                	sd	ra,56(sp)
 ada:	f822                	sd	s0,48(sp)
 adc:	f426                	sd	s1,40(sp)
 ade:	f04a                	sd	s2,32(sp)
 ae0:	ec4e                	sd	s3,24(sp)
 ae2:	e852                	sd	s4,16(sp)
 ae4:	e456                	sd	s5,8(sp)
 ae6:	e05a                	sd	s6,0(sp)
 ae8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 aea:	02051993          	slli	s3,a0,0x20
 aee:	0209d993          	srli	s3,s3,0x20
 af2:	09bd                	addi	s3,s3,15
 af4:	0049d993          	srli	s3,s3,0x4
 af8:	2985                	addiw	s3,s3,1
 afa:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
 afe:	00000797          	auipc	a5,0x0
 b02:	50278793          	addi	a5,a5,1282 # 1000 <freep>
 b06:	6388                	ld	a0,0(a5)
 b08:	c515                	beqz	a0,b34 <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b0a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b0c:	4798                	lw	a4,8(a5)
 b0e:	03277f63          	bgeu	a4,s2,b4c <malloc+0x76>
 b12:	8a4e                	mv	s4,s3
 b14:	0009871b          	sext.w	a4,s3
 b18:	6685                	lui	a3,0x1
 b1a:	00d77363          	bgeu	a4,a3,b20 <malloc+0x4a>
 b1e:	6a05                	lui	s4,0x1
 b20:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
 b24:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b28:	00000497          	auipc	s1,0x0
 b2c:	4d848493          	addi	s1,s1,1240 # 1000 <freep>
  if(p == (char*)-1)
 b30:	5b7d                	li	s6,-1
 b32:	a885                	j	ba2 <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
 b34:	00000797          	auipc	a5,0x0
 b38:	4dc78793          	addi	a5,a5,1244 # 1010 <base>
 b3c:	00000717          	auipc	a4,0x0
 b40:	4cf73223          	sd	a5,1220(a4) # 1000 <freep>
 b44:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b46:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b4a:	b7e1                	j	b12 <malloc+0x3c>
      if(p->s.size == nunits)
 b4c:	02e90b63          	beq	s2,a4,b82 <malloc+0xac>
        p->s.size -= nunits;
 b50:	4137073b          	subw	a4,a4,s3
 b54:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b56:	1702                	slli	a4,a4,0x20
 b58:	9301                	srli	a4,a4,0x20
 b5a:	0712                	slli	a4,a4,0x4
 b5c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b5e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b62:	00000717          	auipc	a4,0x0
 b66:	48a73f23          	sd	a0,1182(a4) # 1000 <freep>
      return (void*)(p + 1);
 b6a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b6e:	70e2                	ld	ra,56(sp)
 b70:	7442                	ld	s0,48(sp)
 b72:	74a2                	ld	s1,40(sp)
 b74:	7902                	ld	s2,32(sp)
 b76:	69e2                	ld	s3,24(sp)
 b78:	6a42                	ld	s4,16(sp)
 b7a:	6aa2                	ld	s5,8(sp)
 b7c:	6b02                	ld	s6,0(sp)
 b7e:	6121                	addi	sp,sp,64
 b80:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b82:	6398                	ld	a4,0(a5)
 b84:	e118                	sd	a4,0(a0)
 b86:	bff1                	j	b62 <malloc+0x8c>
  hp->s.size = nu;
 b88:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
 b8c:	0541                	addi	a0,a0,16
 b8e:	00000097          	auipc	ra,0x0
 b92:	ebe080e7          	jalr	-322(ra) # a4c <free>
  return freep;
 b96:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 b98:	d979                	beqz	a0,b6e <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b9a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b9c:	4798                	lw	a4,8(a5)
 b9e:	fb2777e3          	bgeu	a4,s2,b4c <malloc+0x76>
    if(p == freep)
 ba2:	6098                	ld	a4,0(s1)
 ba4:	853e                	mv	a0,a5
 ba6:	fef71ae3          	bne	a4,a5,b9a <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
 baa:	8552                	mv	a0,s4
 bac:	00000097          	auipc	ra,0x0
 bb0:	b5c080e7          	jalr	-1188(ra) # 708 <sbrk>
  if(p == (char*)-1)
 bb4:	fd651ae3          	bne	a0,s6,b88 <malloc+0xb2>
        return 0;
 bb8:	4501                	li	a0,0
 bba:	bf55                	j	b6e <malloc+0x98>
