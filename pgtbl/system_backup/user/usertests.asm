
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };

  for(int ai = 0; ai < 2; ai++){
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
       8:	20100593          	li	a1,513
       c:	4505                	li	a0,1
       e:	057e                	slli	a0,a0,0x1f
      10:	00006097          	auipc	ra,0x6
      14:	c48080e7          	jalr	-952(ra) # 5c58 <open>
    if(fd >= 0){
      18:	02055063          	bgez	a0,38 <copyinstr1+0x38>
    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      1c:	20100593          	li	a1,513
      20:	557d                	li	a0,-1
      22:	00006097          	auipc	ra,0x6
      26:	c36080e7          	jalr	-970(ra) # 5c58 <open>
    uint64 addr = addrs[ai];
      2a:	55fd                	li	a1,-1
    if(fd >= 0){
      2c:	00055863          	bgez	a0,3c <copyinstr1+0x3c>
      printf("open(%p) returned %d, not -1\n", addr, fd);
      exit(1);
    }
  }
}
      30:	60a2                	ld	ra,8(sp)
      32:	6402                	ld	s0,0(sp)
      34:	0141                	addi	sp,sp,16
      36:	8082                	ret
    uint64 addr = addrs[ai];
      38:	4585                	li	a1,1
      3a:	05fe                	slli	a1,a1,0x1f
      printf("open(%p) returned %d, not -1\n", addr, fd);
      3c:	862a                	mv	a2,a0
      3e:	00006517          	auipc	a0,0x6
      42:	14250513          	addi	a0,a0,322 # 6180 <malloc+0x112>
      46:	00006097          	auipc	ra,0x6
      4a:	f68080e7          	jalr	-152(ra) # 5fae <printf>
      exit(1);
      4e:	4505                	li	a0,1
      50:	00006097          	auipc	ra,0x6
      54:	bc8080e7          	jalr	-1080(ra) # 5c18 <exit>

0000000000000058 <bsstest>:
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
      58:	0000a797          	auipc	a5,0xa
      5c:	5107c783          	lbu	a5,1296(a5) # a568 <uninit>
      60:	e385                	bnez	a5,80 <bsstest+0x28>
      62:	0000a797          	auipc	a5,0xa
      66:	50778793          	addi	a5,a5,1287 # a569 <uninit+0x1>
      6a:	0000d697          	auipc	a3,0xd
      6e:	c0e68693          	addi	a3,a3,-1010 # cc78 <buf>
      72:	0007c703          	lbu	a4,0(a5)
      76:	e709                	bnez	a4,80 <bsstest+0x28>
      78:	0785                	addi	a5,a5,1
  for(i = 0; i < sizeof(uninit); i++){
      7a:	fed79ce3          	bne	a5,a3,72 <bsstest+0x1a>
      7e:	8082                	ret
{
      80:	1141                	addi	sp,sp,-16
      82:	e406                	sd	ra,8(sp)
      84:	e022                	sd	s0,0(sp)
      86:	0800                	addi	s0,sp,16
      88:	85aa                	mv	a1,a0
      printf("%s: bss test failed\n", s);
      8a:	00006517          	auipc	a0,0x6
      8e:	11650513          	addi	a0,a0,278 # 61a0 <malloc+0x132>
      92:	00006097          	auipc	ra,0x6
      96:	f1c080e7          	jalr	-228(ra) # 5fae <printf>
      exit(1);
      9a:	4505                	li	a0,1
      9c:	00006097          	auipc	ra,0x6
      a0:	b7c080e7          	jalr	-1156(ra) # 5c18 <exit>

00000000000000a4 <opentest>:
{
      a4:	1101                	addi	sp,sp,-32
      a6:	ec06                	sd	ra,24(sp)
      a8:	e822                	sd	s0,16(sp)
      aa:	e426                	sd	s1,8(sp)
      ac:	1000                	addi	s0,sp,32
      ae:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      b0:	4581                	li	a1,0
      b2:	00006517          	auipc	a0,0x6
      b6:	10650513          	addi	a0,a0,262 # 61b8 <malloc+0x14a>
      ba:	00006097          	auipc	ra,0x6
      be:	b9e080e7          	jalr	-1122(ra) # 5c58 <open>
  if(fd < 0){
      c2:	02054663          	bltz	a0,ee <opentest+0x4a>
  close(fd);
      c6:	00006097          	auipc	ra,0x6
      ca:	b7a080e7          	jalr	-1158(ra) # 5c40 <close>
  fd = open("doesnotexist", 0);
      ce:	4581                	li	a1,0
      d0:	00006517          	auipc	a0,0x6
      d4:	10850513          	addi	a0,a0,264 # 61d8 <malloc+0x16a>
      d8:	00006097          	auipc	ra,0x6
      dc:	b80080e7          	jalr	-1152(ra) # 5c58 <open>
  if(fd >= 0){
      e0:	02055563          	bgez	a0,10a <opentest+0x66>
}
      e4:	60e2                	ld	ra,24(sp)
      e6:	6442                	ld	s0,16(sp)
      e8:	64a2                	ld	s1,8(sp)
      ea:	6105                	addi	sp,sp,32
      ec:	8082                	ret
    printf("%s: open echo failed!\n", s);
      ee:	85a6                	mv	a1,s1
      f0:	00006517          	auipc	a0,0x6
      f4:	0d050513          	addi	a0,a0,208 # 61c0 <malloc+0x152>
      f8:	00006097          	auipc	ra,0x6
      fc:	eb6080e7          	jalr	-330(ra) # 5fae <printf>
    exit(1);
     100:	4505                	li	a0,1
     102:	00006097          	auipc	ra,0x6
     106:	b16080e7          	jalr	-1258(ra) # 5c18 <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     10a:	85a6                	mv	a1,s1
     10c:	00006517          	auipc	a0,0x6
     110:	0dc50513          	addi	a0,a0,220 # 61e8 <malloc+0x17a>
     114:	00006097          	auipc	ra,0x6
     118:	e9a080e7          	jalr	-358(ra) # 5fae <printf>
    exit(1);
     11c:	4505                	li	a0,1
     11e:	00006097          	auipc	ra,0x6
     122:	afa080e7          	jalr	-1286(ra) # 5c18 <exit>

0000000000000126 <truncate2>:
{
     126:	7179                	addi	sp,sp,-48
     128:	f406                	sd	ra,40(sp)
     12a:	f022                	sd	s0,32(sp)
     12c:	ec26                	sd	s1,24(sp)
     12e:	e84a                	sd	s2,16(sp)
     130:	e44e                	sd	s3,8(sp)
     132:	1800                	addi	s0,sp,48
     134:	89aa                	mv	s3,a0
  unlink("truncfile");
     136:	00006517          	auipc	a0,0x6
     13a:	0da50513          	addi	a0,a0,218 # 6210 <malloc+0x1a2>
     13e:	00006097          	auipc	ra,0x6
     142:	b2a080e7          	jalr	-1238(ra) # 5c68 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     146:	60100593          	li	a1,1537
     14a:	00006517          	auipc	a0,0x6
     14e:	0c650513          	addi	a0,a0,198 # 6210 <malloc+0x1a2>
     152:	00006097          	auipc	ra,0x6
     156:	b06080e7          	jalr	-1274(ra) # 5c58 <open>
     15a:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     15c:	4611                	li	a2,4
     15e:	00006597          	auipc	a1,0x6
     162:	0c258593          	addi	a1,a1,194 # 6220 <malloc+0x1b2>
     166:	00006097          	auipc	ra,0x6
     16a:	ad2080e7          	jalr	-1326(ra) # 5c38 <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     16e:	40100593          	li	a1,1025
     172:	00006517          	auipc	a0,0x6
     176:	09e50513          	addi	a0,a0,158 # 6210 <malloc+0x1a2>
     17a:	00006097          	auipc	ra,0x6
     17e:	ade080e7          	jalr	-1314(ra) # 5c58 <open>
     182:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     184:	4605                	li	a2,1
     186:	00006597          	auipc	a1,0x6
     18a:	0a258593          	addi	a1,a1,162 # 6228 <malloc+0x1ba>
     18e:	8526                	mv	a0,s1
     190:	00006097          	auipc	ra,0x6
     194:	aa8080e7          	jalr	-1368(ra) # 5c38 <write>
  if(n != -1){
     198:	57fd                	li	a5,-1
     19a:	02f51b63          	bne	a0,a5,1d0 <truncate2+0xaa>
  unlink("truncfile");
     19e:	00006517          	auipc	a0,0x6
     1a2:	07250513          	addi	a0,a0,114 # 6210 <malloc+0x1a2>
     1a6:	00006097          	auipc	ra,0x6
     1aa:	ac2080e7          	jalr	-1342(ra) # 5c68 <unlink>
  close(fd1);
     1ae:	8526                	mv	a0,s1
     1b0:	00006097          	auipc	ra,0x6
     1b4:	a90080e7          	jalr	-1392(ra) # 5c40 <close>
  close(fd2);
     1b8:	854a                	mv	a0,s2
     1ba:	00006097          	auipc	ra,0x6
     1be:	a86080e7          	jalr	-1402(ra) # 5c40 <close>
}
     1c2:	70a2                	ld	ra,40(sp)
     1c4:	7402                	ld	s0,32(sp)
     1c6:	64e2                	ld	s1,24(sp)
     1c8:	6942                	ld	s2,16(sp)
     1ca:	69a2                	ld	s3,8(sp)
     1cc:	6145                	addi	sp,sp,48
     1ce:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1d0:	862a                	mv	a2,a0
     1d2:	85ce                	mv	a1,s3
     1d4:	00006517          	auipc	a0,0x6
     1d8:	05c50513          	addi	a0,a0,92 # 6230 <malloc+0x1c2>
     1dc:	00006097          	auipc	ra,0x6
     1e0:	dd2080e7          	jalr	-558(ra) # 5fae <printf>
    exit(1);
     1e4:	4505                	li	a0,1
     1e6:	00006097          	auipc	ra,0x6
     1ea:	a32080e7          	jalr	-1486(ra) # 5c18 <exit>

00000000000001ee <createtest>:
{
     1ee:	7179                	addi	sp,sp,-48
     1f0:	f406                	sd	ra,40(sp)
     1f2:	f022                	sd	s0,32(sp)
     1f4:	ec26                	sd	s1,24(sp)
     1f6:	e84a                	sd	s2,16(sp)
     1f8:	1800                	addi	s0,sp,48
  name[0] = 'a';
     1fa:	06100793          	li	a5,97
     1fe:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     202:	fc040d23          	sb	zero,-38(s0)
     206:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     20a:	06400913          	li	s2,100
    name[1] = '0' + i;
     20e:	fc940ca3          	sb	s1,-39(s0)
    fd = open(name, O_CREATE|O_RDWR);
     212:	20200593          	li	a1,514
     216:	fd840513          	addi	a0,s0,-40
     21a:	00006097          	auipc	ra,0x6
     21e:	a3e080e7          	jalr	-1474(ra) # 5c58 <open>
    close(fd);
     222:	00006097          	auipc	ra,0x6
     226:	a1e080e7          	jalr	-1506(ra) # 5c40 <close>
     22a:	2485                	addiw	s1,s1,1
     22c:	0ff4f493          	andi	s1,s1,255
  for(i = 0; i < N; i++){
     230:	fd249fe3          	bne	s1,s2,20e <createtest+0x20>
  name[0] = 'a';
     234:	06100793          	li	a5,97
     238:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     23c:	fc040d23          	sb	zero,-38(s0)
     240:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     244:	06400913          	li	s2,100
    name[1] = '0' + i;
     248:	fc940ca3          	sb	s1,-39(s0)
    unlink(name);
     24c:	fd840513          	addi	a0,s0,-40
     250:	00006097          	auipc	ra,0x6
     254:	a18080e7          	jalr	-1512(ra) # 5c68 <unlink>
     258:	2485                	addiw	s1,s1,1
     25a:	0ff4f493          	andi	s1,s1,255
  for(i = 0; i < N; i++){
     25e:	ff2495e3          	bne	s1,s2,248 <createtest+0x5a>
}
     262:	70a2                	ld	ra,40(sp)
     264:	7402                	ld	s0,32(sp)
     266:	64e2                	ld	s1,24(sp)
     268:	6942                	ld	s2,16(sp)
     26a:	6145                	addi	sp,sp,48
     26c:	8082                	ret

000000000000026e <bigwrite>:
{
     26e:	715d                	addi	sp,sp,-80
     270:	e486                	sd	ra,72(sp)
     272:	e0a2                	sd	s0,64(sp)
     274:	fc26                	sd	s1,56(sp)
     276:	f84a                	sd	s2,48(sp)
     278:	f44e                	sd	s3,40(sp)
     27a:	f052                	sd	s4,32(sp)
     27c:	ec56                	sd	s5,24(sp)
     27e:	e85a                	sd	s6,16(sp)
     280:	e45e                	sd	s7,8(sp)
     282:	0880                	addi	s0,sp,80
     284:	8baa                	mv	s7,a0
  unlink("bigwrite");
     286:	00006517          	auipc	a0,0x6
     28a:	fd250513          	addi	a0,a0,-46 # 6258 <malloc+0x1ea>
     28e:	00006097          	auipc	ra,0x6
     292:	9da080e7          	jalr	-1574(ra) # 5c68 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     296:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     29a:	00006a17          	auipc	s4,0x6
     29e:	fbea0a13          	addi	s4,s4,-66 # 6258 <malloc+0x1ea>
      int cc = write(fd, buf, sz);
     2a2:	0000d997          	auipc	s3,0xd
     2a6:	9d698993          	addi	s3,s3,-1578 # cc78 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2aa:	6b0d                	lui	s6,0x3
     2ac:	1c9b0b13          	addi	s6,s6,457 # 31c9 <fourteen+0x185>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     2b0:	20200593          	li	a1,514
     2b4:	8552                	mv	a0,s4
     2b6:	00006097          	auipc	ra,0x6
     2ba:	9a2080e7          	jalr	-1630(ra) # 5c58 <open>
     2be:	892a                	mv	s2,a0
    if(fd < 0){
     2c0:	04054d63          	bltz	a0,31a <bigwrite+0xac>
      int cc = write(fd, buf, sz);
     2c4:	8626                	mv	a2,s1
     2c6:	85ce                	mv	a1,s3
     2c8:	00006097          	auipc	ra,0x6
     2cc:	970080e7          	jalr	-1680(ra) # 5c38 <write>
     2d0:	8aaa                	mv	s5,a0
      if(cc != sz){
     2d2:	06a49463          	bne	s1,a0,33a <bigwrite+0xcc>
      int cc = write(fd, buf, sz);
     2d6:	8626                	mv	a2,s1
     2d8:	85ce                	mv	a1,s3
     2da:	854a                	mv	a0,s2
     2dc:	00006097          	auipc	ra,0x6
     2e0:	95c080e7          	jalr	-1700(ra) # 5c38 <write>
      if(cc != sz){
     2e4:	04951963          	bne	a0,s1,336 <bigwrite+0xc8>
    close(fd);
     2e8:	854a                	mv	a0,s2
     2ea:	00006097          	auipc	ra,0x6
     2ee:	956080e7          	jalr	-1706(ra) # 5c40 <close>
    unlink("bigwrite");
     2f2:	8552                	mv	a0,s4
     2f4:	00006097          	auipc	ra,0x6
     2f8:	974080e7          	jalr	-1676(ra) # 5c68 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2fc:	1d74849b          	addiw	s1,s1,471
     300:	fb6498e3          	bne	s1,s6,2b0 <bigwrite+0x42>
}
     304:	60a6                	ld	ra,72(sp)
     306:	6406                	ld	s0,64(sp)
     308:	74e2                	ld	s1,56(sp)
     30a:	7942                	ld	s2,48(sp)
     30c:	79a2                	ld	s3,40(sp)
     30e:	7a02                	ld	s4,32(sp)
     310:	6ae2                	ld	s5,24(sp)
     312:	6b42                	ld	s6,16(sp)
     314:	6ba2                	ld	s7,8(sp)
     316:	6161                	addi	sp,sp,80
     318:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     31a:	85de                	mv	a1,s7
     31c:	00006517          	auipc	a0,0x6
     320:	f4c50513          	addi	a0,a0,-180 # 6268 <malloc+0x1fa>
     324:	00006097          	auipc	ra,0x6
     328:	c8a080e7          	jalr	-886(ra) # 5fae <printf>
      exit(1);
     32c:	4505                	li	a0,1
     32e:	00006097          	auipc	ra,0x6
     332:	8ea080e7          	jalr	-1814(ra) # 5c18 <exit>
     336:	84d6                	mv	s1,s5
      int cc = write(fd, buf, sz);
     338:	8aaa                	mv	s5,a0
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     33a:	86d6                	mv	a3,s5
     33c:	8626                	mv	a2,s1
     33e:	85de                	mv	a1,s7
     340:	00006517          	auipc	a0,0x6
     344:	f4850513          	addi	a0,a0,-184 # 6288 <malloc+0x21a>
     348:	00006097          	auipc	ra,0x6
     34c:	c66080e7          	jalr	-922(ra) # 5fae <printf>
        exit(1);
     350:	4505                	li	a0,1
     352:	00006097          	auipc	ra,0x6
     356:	8c6080e7          	jalr	-1850(ra) # 5c18 <exit>

000000000000035a <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
     35a:	7179                	addi	sp,sp,-48
     35c:	f406                	sd	ra,40(sp)
     35e:	f022                	sd	s0,32(sp)
     360:	ec26                	sd	s1,24(sp)
     362:	e84a                	sd	s2,16(sp)
     364:	e44e                	sd	s3,8(sp)
     366:	e052                	sd	s4,0(sp)
     368:	1800                	addi	s0,sp,48
  int assumed_free = 600;
  
  unlink("junk");
     36a:	00006517          	auipc	a0,0x6
     36e:	f3650513          	addi	a0,a0,-202 # 62a0 <malloc+0x232>
     372:	00006097          	auipc	ra,0x6
     376:	8f6080e7          	jalr	-1802(ra) # 5c68 <unlink>
     37a:	25800913          	li	s2,600
  for(int i = 0; i < assumed_free; i++){
    int fd = open("junk", O_CREATE|O_WRONLY);
     37e:	00006997          	auipc	s3,0x6
     382:	f2298993          	addi	s3,s3,-222 # 62a0 <malloc+0x232>
    if(fd < 0){
      printf("open junk failed\n");
      exit(1);
    }
    write(fd, (char*)0xffffffffffL, 1);
     386:	5a7d                	li	s4,-1
     388:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
     38c:	20100593          	li	a1,513
     390:	854e                	mv	a0,s3
     392:	00006097          	auipc	ra,0x6
     396:	8c6080e7          	jalr	-1850(ra) # 5c58 <open>
     39a:	84aa                	mv	s1,a0
    if(fd < 0){
     39c:	06054b63          	bltz	a0,412 <badwrite+0xb8>
    write(fd, (char*)0xffffffffffL, 1);
     3a0:	4605                	li	a2,1
     3a2:	85d2                	mv	a1,s4
     3a4:	00006097          	auipc	ra,0x6
     3a8:	894080e7          	jalr	-1900(ra) # 5c38 <write>
    close(fd);
     3ac:	8526                	mv	a0,s1
     3ae:	00006097          	auipc	ra,0x6
     3b2:	892080e7          	jalr	-1902(ra) # 5c40 <close>
    unlink("junk");
     3b6:	854e                	mv	a0,s3
     3b8:	00006097          	auipc	ra,0x6
     3bc:	8b0080e7          	jalr	-1872(ra) # 5c68 <unlink>
     3c0:	397d                	addiw	s2,s2,-1
  for(int i = 0; i < assumed_free; i++){
     3c2:	fc0915e3          	bnez	s2,38c <badwrite+0x32>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
     3c6:	20100593          	li	a1,513
     3ca:	00006517          	auipc	a0,0x6
     3ce:	ed650513          	addi	a0,a0,-298 # 62a0 <malloc+0x232>
     3d2:	00006097          	auipc	ra,0x6
     3d6:	886080e7          	jalr	-1914(ra) # 5c58 <open>
     3da:	84aa                	mv	s1,a0
  if(fd < 0){
     3dc:	04054863          	bltz	a0,42c <badwrite+0xd2>
    printf("open junk failed\n");
    exit(1);
  }
  if(write(fd, "x", 1) != 1){
     3e0:	4605                	li	a2,1
     3e2:	00006597          	auipc	a1,0x6
     3e6:	e4658593          	addi	a1,a1,-442 # 6228 <malloc+0x1ba>
     3ea:	00006097          	auipc	ra,0x6
     3ee:	84e080e7          	jalr	-1970(ra) # 5c38 <write>
     3f2:	4785                	li	a5,1
     3f4:	04f50963          	beq	a0,a5,446 <badwrite+0xec>
    printf("write failed\n");
     3f8:	00006517          	auipc	a0,0x6
     3fc:	ec850513          	addi	a0,a0,-312 # 62c0 <malloc+0x252>
     400:	00006097          	auipc	ra,0x6
     404:	bae080e7          	jalr	-1106(ra) # 5fae <printf>
    exit(1);
     408:	4505                	li	a0,1
     40a:	00006097          	auipc	ra,0x6
     40e:	80e080e7          	jalr	-2034(ra) # 5c18 <exit>
      printf("open junk failed\n");
     412:	00006517          	auipc	a0,0x6
     416:	e9650513          	addi	a0,a0,-362 # 62a8 <malloc+0x23a>
     41a:	00006097          	auipc	ra,0x6
     41e:	b94080e7          	jalr	-1132(ra) # 5fae <printf>
      exit(1);
     422:	4505                	li	a0,1
     424:	00005097          	auipc	ra,0x5
     428:	7f4080e7          	jalr	2036(ra) # 5c18 <exit>
    printf("open junk failed\n");
     42c:	00006517          	auipc	a0,0x6
     430:	e7c50513          	addi	a0,a0,-388 # 62a8 <malloc+0x23a>
     434:	00006097          	auipc	ra,0x6
     438:	b7a080e7          	jalr	-1158(ra) # 5fae <printf>
    exit(1);
     43c:	4505                	li	a0,1
     43e:	00005097          	auipc	ra,0x5
     442:	7da080e7          	jalr	2010(ra) # 5c18 <exit>
  }
  close(fd);
     446:	8526                	mv	a0,s1
     448:	00005097          	auipc	ra,0x5
     44c:	7f8080e7          	jalr	2040(ra) # 5c40 <close>
  unlink("junk");
     450:	00006517          	auipc	a0,0x6
     454:	e5050513          	addi	a0,a0,-432 # 62a0 <malloc+0x232>
     458:	00006097          	auipc	ra,0x6
     45c:	810080e7          	jalr	-2032(ra) # 5c68 <unlink>

  exit(0);
     460:	4501                	li	a0,0
     462:	00005097          	auipc	ra,0x5
     466:	7b6080e7          	jalr	1974(ra) # 5c18 <exit>

000000000000046a <outofinodes>:
  }
}

void
outofinodes(char *s)
{
     46a:	715d                	addi	sp,sp,-80
     46c:	e486                	sd	ra,72(sp)
     46e:	e0a2                	sd	s0,64(sp)
     470:	fc26                	sd	s1,56(sp)
     472:	f84a                	sd	s2,48(sp)
     474:	f44e                	sd	s3,40(sp)
     476:	0880                	addi	s0,sp,80
  int nzz = 32*32;
  for(int i = 0; i < nzz; i++){
     478:	4481                	li	s1,0
    char name[32];
    name[0] = 'z';
     47a:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
     47e:	40000993          	li	s3,1024
    name[0] = 'z';
     482:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     486:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     48a:	41f4d79b          	sraiw	a5,s1,0x1f
     48e:	01b7d71b          	srliw	a4,a5,0x1b
     492:	009707bb          	addw	a5,a4,s1
     496:	4057d69b          	sraiw	a3,a5,0x5
     49a:	0306869b          	addiw	a3,a3,48
     49e:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     4a2:	8bfd                	andi	a5,a5,31
     4a4:	9f99                	subw	a5,a5,a4
     4a6:	0307879b          	addiw	a5,a5,48
     4aa:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     4ae:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     4b2:	fb040513          	addi	a0,s0,-80
     4b6:	00005097          	auipc	ra,0x5
     4ba:	7b2080e7          	jalr	1970(ra) # 5c68 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
     4be:	60200593          	li	a1,1538
     4c2:	fb040513          	addi	a0,s0,-80
     4c6:	00005097          	auipc	ra,0x5
     4ca:	792080e7          	jalr	1938(ra) # 5c58 <open>
    if(fd < 0){
     4ce:	00054963          	bltz	a0,4e0 <outofinodes+0x76>
      // failure is eventually expected.
      break;
    }
    close(fd);
     4d2:	00005097          	auipc	ra,0x5
     4d6:	76e080e7          	jalr	1902(ra) # 5c40 <close>
  for(int i = 0; i < nzz; i++){
     4da:	2485                	addiw	s1,s1,1
     4dc:	fb3493e3          	bne	s1,s3,482 <outofinodes+0x18>
     4e0:	4481                	li	s1,0
  }

  for(int i = 0; i < nzz; i++){
    char name[32];
    name[0] = 'z';
     4e2:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
     4e6:	40000993          	li	s3,1024
    name[0] = 'z';
     4ea:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     4ee:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     4f2:	41f4d79b          	sraiw	a5,s1,0x1f
     4f6:	01b7d71b          	srliw	a4,a5,0x1b
     4fa:	009707bb          	addw	a5,a4,s1
     4fe:	4057d69b          	sraiw	a3,a5,0x5
     502:	0306869b          	addiw	a3,a3,48
     506:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     50a:	8bfd                	andi	a5,a5,31
     50c:	9f99                	subw	a5,a5,a4
     50e:	0307879b          	addiw	a5,a5,48
     512:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     516:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     51a:	fb040513          	addi	a0,s0,-80
     51e:	00005097          	auipc	ra,0x5
     522:	74a080e7          	jalr	1866(ra) # 5c68 <unlink>
  for(int i = 0; i < nzz; i++){
     526:	2485                	addiw	s1,s1,1
     528:	fd3491e3          	bne	s1,s3,4ea <outofinodes+0x80>
  }
}
     52c:	60a6                	ld	ra,72(sp)
     52e:	6406                	ld	s0,64(sp)
     530:	74e2                	ld	s1,56(sp)
     532:	7942                	ld	s2,48(sp)
     534:	79a2                	ld	s3,40(sp)
     536:	6161                	addi	sp,sp,80
     538:	8082                	ret

000000000000053a <copyin>:
{
     53a:	711d                	addi	sp,sp,-96
     53c:	ec86                	sd	ra,88(sp)
     53e:	e8a2                	sd	s0,80(sp)
     540:	e4a6                	sd	s1,72(sp)
     542:	e0ca                	sd	s2,64(sp)
     544:	fc4e                	sd	s3,56(sp)
     546:	f852                	sd	s4,48(sp)
     548:	f456                	sd	s5,40(sp)
     54a:	1080                	addi	s0,sp,96
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     54c:	4785                	li	a5,1
     54e:	07fe                	slli	a5,a5,0x1f
     550:	faf43823          	sd	a5,-80(s0)
     554:	57fd                	li	a5,-1
     556:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < 2; ai++){
     55a:	fb040493          	addi	s1,s0,-80
     55e:	fc040a93          	addi	s5,s0,-64
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     562:	00006a17          	auipc	s4,0x6
     566:	d6ea0a13          	addi	s4,s4,-658 # 62d0 <malloc+0x262>
    uint64 addr = addrs[ai];
     56a:	0004b903          	ld	s2,0(s1)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     56e:	20100593          	li	a1,513
     572:	8552                	mv	a0,s4
     574:	00005097          	auipc	ra,0x5
     578:	6e4080e7          	jalr	1764(ra) # 5c58 <open>
     57c:	89aa                	mv	s3,a0
    if(fd < 0){
     57e:	08054763          	bltz	a0,60c <copyin+0xd2>
    int n = write(fd, (void*)addr, 8192);
     582:	6609                	lui	a2,0x2
     584:	85ca                	mv	a1,s2
     586:	00005097          	auipc	ra,0x5
     58a:	6b2080e7          	jalr	1714(ra) # 5c38 <write>
    if(n >= 0){
     58e:	08055c63          	bgez	a0,626 <copyin+0xec>
    close(fd);
     592:	854e                	mv	a0,s3
     594:	00005097          	auipc	ra,0x5
     598:	6ac080e7          	jalr	1708(ra) # 5c40 <close>
    unlink("copyin1");
     59c:	8552                	mv	a0,s4
     59e:	00005097          	auipc	ra,0x5
     5a2:	6ca080e7          	jalr	1738(ra) # 5c68 <unlink>
    n = write(1, (char*)addr, 8192);
     5a6:	6609                	lui	a2,0x2
     5a8:	85ca                	mv	a1,s2
     5aa:	4505                	li	a0,1
     5ac:	00005097          	auipc	ra,0x5
     5b0:	68c080e7          	jalr	1676(ra) # 5c38 <write>
    if(n > 0){
     5b4:	08a04863          	bgtz	a0,644 <copyin+0x10a>
    if(pipe(fds) < 0){
     5b8:	fa840513          	addi	a0,s0,-88
     5bc:	00005097          	auipc	ra,0x5
     5c0:	66c080e7          	jalr	1644(ra) # 5c28 <pipe>
     5c4:	08054f63          	bltz	a0,662 <copyin+0x128>
    n = write(fds[1], (char*)addr, 8192);
     5c8:	6609                	lui	a2,0x2
     5ca:	85ca                	mv	a1,s2
     5cc:	fac42503          	lw	a0,-84(s0)
     5d0:	00005097          	auipc	ra,0x5
     5d4:	668080e7          	jalr	1640(ra) # 5c38 <write>
    if(n > 0){
     5d8:	0aa04263          	bgtz	a0,67c <copyin+0x142>
    close(fds[0]);
     5dc:	fa842503          	lw	a0,-88(s0)
     5e0:	00005097          	auipc	ra,0x5
     5e4:	660080e7          	jalr	1632(ra) # 5c40 <close>
    close(fds[1]);
     5e8:	fac42503          	lw	a0,-84(s0)
     5ec:	00005097          	auipc	ra,0x5
     5f0:	654080e7          	jalr	1620(ra) # 5c40 <close>
     5f4:	04a1                	addi	s1,s1,8
  for(int ai = 0; ai < 2; ai++){
     5f6:	f7549ae3          	bne	s1,s5,56a <copyin+0x30>
}
     5fa:	60e6                	ld	ra,88(sp)
     5fc:	6446                	ld	s0,80(sp)
     5fe:	64a6                	ld	s1,72(sp)
     600:	6906                	ld	s2,64(sp)
     602:	79e2                	ld	s3,56(sp)
     604:	7a42                	ld	s4,48(sp)
     606:	7aa2                	ld	s5,40(sp)
     608:	6125                	addi	sp,sp,96
     60a:	8082                	ret
      printf("open(copyin1) failed\n");
     60c:	00006517          	auipc	a0,0x6
     610:	ccc50513          	addi	a0,a0,-820 # 62d8 <malloc+0x26a>
     614:	00006097          	auipc	ra,0x6
     618:	99a080e7          	jalr	-1638(ra) # 5fae <printf>
      exit(1);
     61c:	4505                	li	a0,1
     61e:	00005097          	auipc	ra,0x5
     622:	5fa080e7          	jalr	1530(ra) # 5c18 <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
     626:	862a                	mv	a2,a0
     628:	85ca                	mv	a1,s2
     62a:	00006517          	auipc	a0,0x6
     62e:	cc650513          	addi	a0,a0,-826 # 62f0 <malloc+0x282>
     632:	00006097          	auipc	ra,0x6
     636:	97c080e7          	jalr	-1668(ra) # 5fae <printf>
      exit(1);
     63a:	4505                	li	a0,1
     63c:	00005097          	auipc	ra,0x5
     640:	5dc080e7          	jalr	1500(ra) # 5c18 <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     644:	862a                	mv	a2,a0
     646:	85ca                	mv	a1,s2
     648:	00006517          	auipc	a0,0x6
     64c:	cd850513          	addi	a0,a0,-808 # 6320 <malloc+0x2b2>
     650:	00006097          	auipc	ra,0x6
     654:	95e080e7          	jalr	-1698(ra) # 5fae <printf>
      exit(1);
     658:	4505                	li	a0,1
     65a:	00005097          	auipc	ra,0x5
     65e:	5be080e7          	jalr	1470(ra) # 5c18 <exit>
      printf("pipe() failed\n");
     662:	00006517          	auipc	a0,0x6
     666:	cee50513          	addi	a0,a0,-786 # 6350 <malloc+0x2e2>
     66a:	00006097          	auipc	ra,0x6
     66e:	944080e7          	jalr	-1724(ra) # 5fae <printf>
      exit(1);
     672:	4505                	li	a0,1
     674:	00005097          	auipc	ra,0x5
     678:	5a4080e7          	jalr	1444(ra) # 5c18 <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     67c:	862a                	mv	a2,a0
     67e:	85ca                	mv	a1,s2
     680:	00006517          	auipc	a0,0x6
     684:	ce050513          	addi	a0,a0,-800 # 6360 <malloc+0x2f2>
     688:	00006097          	auipc	ra,0x6
     68c:	926080e7          	jalr	-1754(ra) # 5fae <printf>
      exit(1);
     690:	4505                	li	a0,1
     692:	00005097          	auipc	ra,0x5
     696:	586080e7          	jalr	1414(ra) # 5c18 <exit>

000000000000069a <copyout>:
{
     69a:	711d                	addi	sp,sp,-96
     69c:	ec86                	sd	ra,88(sp)
     69e:	e8a2                	sd	s0,80(sp)
     6a0:	e4a6                	sd	s1,72(sp)
     6a2:	e0ca                	sd	s2,64(sp)
     6a4:	fc4e                	sd	s3,56(sp)
     6a6:	f852                	sd	s4,48(sp)
     6a8:	f456                	sd	s5,40(sp)
     6aa:	f05a                	sd	s6,32(sp)
     6ac:	1080                	addi	s0,sp,96
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     6ae:	4785                	li	a5,1
     6b0:	07fe                	slli	a5,a5,0x1f
     6b2:	faf43823          	sd	a5,-80(s0)
     6b6:	57fd                	li	a5,-1
     6b8:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < 2; ai++){
     6bc:	fb040493          	addi	s1,s0,-80
     6c0:	fc040b13          	addi	s6,s0,-64
    int fd = open("README", 0);
     6c4:	00006a17          	auipc	s4,0x6
     6c8:	ccca0a13          	addi	s4,s4,-820 # 6390 <malloc+0x322>
    n = write(fds[1], "x", 1);
     6cc:	00006a97          	auipc	s5,0x6
     6d0:	b5ca8a93          	addi	s5,s5,-1188 # 6228 <malloc+0x1ba>
    uint64 addr = addrs[ai];
     6d4:	0004b983          	ld	s3,0(s1)
    int fd = open("README", 0);
     6d8:	4581                	li	a1,0
     6da:	8552                	mv	a0,s4
     6dc:	00005097          	auipc	ra,0x5
     6e0:	57c080e7          	jalr	1404(ra) # 5c58 <open>
     6e4:	892a                	mv	s2,a0
    if(fd < 0){
     6e6:	08054563          	bltz	a0,770 <copyout+0xd6>
    int n = read(fd, (void*)addr, 8192);
     6ea:	6609                	lui	a2,0x2
     6ec:	85ce                	mv	a1,s3
     6ee:	00005097          	auipc	ra,0x5
     6f2:	542080e7          	jalr	1346(ra) # 5c30 <read>
    if(n > 0){
     6f6:	08a04a63          	bgtz	a0,78a <copyout+0xf0>
    close(fd);
     6fa:	854a                	mv	a0,s2
     6fc:	00005097          	auipc	ra,0x5
     700:	544080e7          	jalr	1348(ra) # 5c40 <close>
    if(pipe(fds) < 0){
     704:	fa840513          	addi	a0,s0,-88
     708:	00005097          	auipc	ra,0x5
     70c:	520080e7          	jalr	1312(ra) # 5c28 <pipe>
     710:	08054c63          	bltz	a0,7a8 <copyout+0x10e>
    n = write(fds[1], "x", 1);
     714:	4605                	li	a2,1
     716:	85d6                	mv	a1,s5
     718:	fac42503          	lw	a0,-84(s0)
     71c:	00005097          	auipc	ra,0x5
     720:	51c080e7          	jalr	1308(ra) # 5c38 <write>
    if(n != 1){
     724:	4785                	li	a5,1
     726:	08f51e63          	bne	a0,a5,7c2 <copyout+0x128>
    n = read(fds[0], (void*)addr, 8192);
     72a:	6609                	lui	a2,0x2
     72c:	85ce                	mv	a1,s3
     72e:	fa842503          	lw	a0,-88(s0)
     732:	00005097          	auipc	ra,0x5
     736:	4fe080e7          	jalr	1278(ra) # 5c30 <read>
    if(n > 0){
     73a:	0aa04163          	bgtz	a0,7dc <copyout+0x142>
    close(fds[0]);
     73e:	fa842503          	lw	a0,-88(s0)
     742:	00005097          	auipc	ra,0x5
     746:	4fe080e7          	jalr	1278(ra) # 5c40 <close>
    close(fds[1]);
     74a:	fac42503          	lw	a0,-84(s0)
     74e:	00005097          	auipc	ra,0x5
     752:	4f2080e7          	jalr	1266(ra) # 5c40 <close>
     756:	04a1                	addi	s1,s1,8
  for(int ai = 0; ai < 2; ai++){
     758:	f7649ee3          	bne	s1,s6,6d4 <copyout+0x3a>
}
     75c:	60e6                	ld	ra,88(sp)
     75e:	6446                	ld	s0,80(sp)
     760:	64a6                	ld	s1,72(sp)
     762:	6906                	ld	s2,64(sp)
     764:	79e2                	ld	s3,56(sp)
     766:	7a42                	ld	s4,48(sp)
     768:	7aa2                	ld	s5,40(sp)
     76a:	7b02                	ld	s6,32(sp)
     76c:	6125                	addi	sp,sp,96
     76e:	8082                	ret
      printf("open(README) failed\n");
     770:	00006517          	auipc	a0,0x6
     774:	c2850513          	addi	a0,a0,-984 # 6398 <malloc+0x32a>
     778:	00006097          	auipc	ra,0x6
     77c:	836080e7          	jalr	-1994(ra) # 5fae <printf>
      exit(1);
     780:	4505                	li	a0,1
     782:	00005097          	auipc	ra,0x5
     786:	496080e7          	jalr	1174(ra) # 5c18 <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     78a:	862a                	mv	a2,a0
     78c:	85ce                	mv	a1,s3
     78e:	00006517          	auipc	a0,0x6
     792:	c2250513          	addi	a0,a0,-990 # 63b0 <malloc+0x342>
     796:	00006097          	auipc	ra,0x6
     79a:	818080e7          	jalr	-2024(ra) # 5fae <printf>
      exit(1);
     79e:	4505                	li	a0,1
     7a0:	00005097          	auipc	ra,0x5
     7a4:	478080e7          	jalr	1144(ra) # 5c18 <exit>
      printf("pipe() failed\n");
     7a8:	00006517          	auipc	a0,0x6
     7ac:	ba850513          	addi	a0,a0,-1112 # 6350 <malloc+0x2e2>
     7b0:	00005097          	auipc	ra,0x5
     7b4:	7fe080e7          	jalr	2046(ra) # 5fae <printf>
      exit(1);
     7b8:	4505                	li	a0,1
     7ba:	00005097          	auipc	ra,0x5
     7be:	45e080e7          	jalr	1118(ra) # 5c18 <exit>
      printf("pipe write failed\n");
     7c2:	00006517          	auipc	a0,0x6
     7c6:	c1e50513          	addi	a0,a0,-994 # 63e0 <malloc+0x372>
     7ca:	00005097          	auipc	ra,0x5
     7ce:	7e4080e7          	jalr	2020(ra) # 5fae <printf>
      exit(1);
     7d2:	4505                	li	a0,1
     7d4:	00005097          	auipc	ra,0x5
     7d8:	444080e7          	jalr	1092(ra) # 5c18 <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     7dc:	862a                	mv	a2,a0
     7de:	85ce                	mv	a1,s3
     7e0:	00006517          	auipc	a0,0x6
     7e4:	c1850513          	addi	a0,a0,-1000 # 63f8 <malloc+0x38a>
     7e8:	00005097          	auipc	ra,0x5
     7ec:	7c6080e7          	jalr	1990(ra) # 5fae <printf>
      exit(1);
     7f0:	4505                	li	a0,1
     7f2:	00005097          	auipc	ra,0x5
     7f6:	426080e7          	jalr	1062(ra) # 5c18 <exit>

00000000000007fa <truncate1>:
{
     7fa:	711d                	addi	sp,sp,-96
     7fc:	ec86                	sd	ra,88(sp)
     7fe:	e8a2                	sd	s0,80(sp)
     800:	e4a6                	sd	s1,72(sp)
     802:	e0ca                	sd	s2,64(sp)
     804:	fc4e                	sd	s3,56(sp)
     806:	f852                	sd	s4,48(sp)
     808:	f456                	sd	s5,40(sp)
     80a:	1080                	addi	s0,sp,96
     80c:	8aaa                	mv	s5,a0
  unlink("truncfile");
     80e:	00006517          	auipc	a0,0x6
     812:	a0250513          	addi	a0,a0,-1534 # 6210 <malloc+0x1a2>
     816:	00005097          	auipc	ra,0x5
     81a:	452080e7          	jalr	1106(ra) # 5c68 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     81e:	60100593          	li	a1,1537
     822:	00006517          	auipc	a0,0x6
     826:	9ee50513          	addi	a0,a0,-1554 # 6210 <malloc+0x1a2>
     82a:	00005097          	auipc	ra,0x5
     82e:	42e080e7          	jalr	1070(ra) # 5c58 <open>
     832:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     834:	4611                	li	a2,4
     836:	00006597          	auipc	a1,0x6
     83a:	9ea58593          	addi	a1,a1,-1558 # 6220 <malloc+0x1b2>
     83e:	00005097          	auipc	ra,0x5
     842:	3fa080e7          	jalr	1018(ra) # 5c38 <write>
  close(fd1);
     846:	8526                	mv	a0,s1
     848:	00005097          	auipc	ra,0x5
     84c:	3f8080e7          	jalr	1016(ra) # 5c40 <close>
  int fd2 = open("truncfile", O_RDONLY);
     850:	4581                	li	a1,0
     852:	00006517          	auipc	a0,0x6
     856:	9be50513          	addi	a0,a0,-1602 # 6210 <malloc+0x1a2>
     85a:	00005097          	auipc	ra,0x5
     85e:	3fe080e7          	jalr	1022(ra) # 5c58 <open>
     862:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     864:	02000613          	li	a2,32
     868:	fa040593          	addi	a1,s0,-96
     86c:	00005097          	auipc	ra,0x5
     870:	3c4080e7          	jalr	964(ra) # 5c30 <read>
  if(n != 4){
     874:	4791                	li	a5,4
     876:	0cf51e63          	bne	a0,a5,952 <truncate1+0x158>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     87a:	40100593          	li	a1,1025
     87e:	00006517          	auipc	a0,0x6
     882:	99250513          	addi	a0,a0,-1646 # 6210 <malloc+0x1a2>
     886:	00005097          	auipc	ra,0x5
     88a:	3d2080e7          	jalr	978(ra) # 5c58 <open>
     88e:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     890:	4581                	li	a1,0
     892:	00006517          	auipc	a0,0x6
     896:	97e50513          	addi	a0,a0,-1666 # 6210 <malloc+0x1a2>
     89a:	00005097          	auipc	ra,0x5
     89e:	3be080e7          	jalr	958(ra) # 5c58 <open>
     8a2:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     8a4:	02000613          	li	a2,32
     8a8:	fa040593          	addi	a1,s0,-96
     8ac:	00005097          	auipc	ra,0x5
     8b0:	384080e7          	jalr	900(ra) # 5c30 <read>
     8b4:	8a2a                	mv	s4,a0
  if(n != 0){
     8b6:	ed4d                	bnez	a0,970 <truncate1+0x176>
  n = read(fd2, buf, sizeof(buf));
     8b8:	02000613          	li	a2,32
     8bc:	fa040593          	addi	a1,s0,-96
     8c0:	8526                	mv	a0,s1
     8c2:	00005097          	auipc	ra,0x5
     8c6:	36e080e7          	jalr	878(ra) # 5c30 <read>
     8ca:	8a2a                	mv	s4,a0
  if(n != 0){
     8cc:	e971                	bnez	a0,9a0 <truncate1+0x1a6>
  write(fd1, "abcdef", 6);
     8ce:	4619                	li	a2,6
     8d0:	00006597          	auipc	a1,0x6
     8d4:	bb858593          	addi	a1,a1,-1096 # 6488 <malloc+0x41a>
     8d8:	854e                	mv	a0,s3
     8da:	00005097          	auipc	ra,0x5
     8de:	35e080e7          	jalr	862(ra) # 5c38 <write>
  n = read(fd3, buf, sizeof(buf));
     8e2:	02000613          	li	a2,32
     8e6:	fa040593          	addi	a1,s0,-96
     8ea:	854a                	mv	a0,s2
     8ec:	00005097          	auipc	ra,0x5
     8f0:	344080e7          	jalr	836(ra) # 5c30 <read>
  if(n != 6){
     8f4:	4799                	li	a5,6
     8f6:	0cf51d63          	bne	a0,a5,9d0 <truncate1+0x1d6>
  n = read(fd2, buf, sizeof(buf));
     8fa:	02000613          	li	a2,32
     8fe:	fa040593          	addi	a1,s0,-96
     902:	8526                	mv	a0,s1
     904:	00005097          	auipc	ra,0x5
     908:	32c080e7          	jalr	812(ra) # 5c30 <read>
  if(n != 2){
     90c:	4789                	li	a5,2
     90e:	0ef51063          	bne	a0,a5,9ee <truncate1+0x1f4>
  unlink("truncfile");
     912:	00006517          	auipc	a0,0x6
     916:	8fe50513          	addi	a0,a0,-1794 # 6210 <malloc+0x1a2>
     91a:	00005097          	auipc	ra,0x5
     91e:	34e080e7          	jalr	846(ra) # 5c68 <unlink>
  close(fd1);
     922:	854e                	mv	a0,s3
     924:	00005097          	auipc	ra,0x5
     928:	31c080e7          	jalr	796(ra) # 5c40 <close>
  close(fd2);
     92c:	8526                	mv	a0,s1
     92e:	00005097          	auipc	ra,0x5
     932:	312080e7          	jalr	786(ra) # 5c40 <close>
  close(fd3);
     936:	854a                	mv	a0,s2
     938:	00005097          	auipc	ra,0x5
     93c:	308080e7          	jalr	776(ra) # 5c40 <close>
}
     940:	60e6                	ld	ra,88(sp)
     942:	6446                	ld	s0,80(sp)
     944:	64a6                	ld	s1,72(sp)
     946:	6906                	ld	s2,64(sp)
     948:	79e2                	ld	s3,56(sp)
     94a:	7a42                	ld	s4,48(sp)
     94c:	7aa2                	ld	s5,40(sp)
     94e:	6125                	addi	sp,sp,96
     950:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     952:	862a                	mv	a2,a0
     954:	85d6                	mv	a1,s5
     956:	00006517          	auipc	a0,0x6
     95a:	ad250513          	addi	a0,a0,-1326 # 6428 <malloc+0x3ba>
     95e:	00005097          	auipc	ra,0x5
     962:	650080e7          	jalr	1616(ra) # 5fae <printf>
    exit(1);
     966:	4505                	li	a0,1
     968:	00005097          	auipc	ra,0x5
     96c:	2b0080e7          	jalr	688(ra) # 5c18 <exit>
    printf("aaa fd3=%d\n", fd3);
     970:	85ca                	mv	a1,s2
     972:	00006517          	auipc	a0,0x6
     976:	ad650513          	addi	a0,a0,-1322 # 6448 <malloc+0x3da>
     97a:	00005097          	auipc	ra,0x5
     97e:	634080e7          	jalr	1588(ra) # 5fae <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     982:	8652                	mv	a2,s4
     984:	85d6                	mv	a1,s5
     986:	00006517          	auipc	a0,0x6
     98a:	ad250513          	addi	a0,a0,-1326 # 6458 <malloc+0x3ea>
     98e:	00005097          	auipc	ra,0x5
     992:	620080e7          	jalr	1568(ra) # 5fae <printf>
    exit(1);
     996:	4505                	li	a0,1
     998:	00005097          	auipc	ra,0x5
     99c:	280080e7          	jalr	640(ra) # 5c18 <exit>
    printf("bbb fd2=%d\n", fd2);
     9a0:	85a6                	mv	a1,s1
     9a2:	00006517          	auipc	a0,0x6
     9a6:	ad650513          	addi	a0,a0,-1322 # 6478 <malloc+0x40a>
     9aa:	00005097          	auipc	ra,0x5
     9ae:	604080e7          	jalr	1540(ra) # 5fae <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     9b2:	8652                	mv	a2,s4
     9b4:	85d6                	mv	a1,s5
     9b6:	00006517          	auipc	a0,0x6
     9ba:	aa250513          	addi	a0,a0,-1374 # 6458 <malloc+0x3ea>
     9be:	00005097          	auipc	ra,0x5
     9c2:	5f0080e7          	jalr	1520(ra) # 5fae <printf>
    exit(1);
     9c6:	4505                	li	a0,1
     9c8:	00005097          	auipc	ra,0x5
     9cc:	250080e7          	jalr	592(ra) # 5c18 <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     9d0:	862a                	mv	a2,a0
     9d2:	85d6                	mv	a1,s5
     9d4:	00006517          	auipc	a0,0x6
     9d8:	abc50513          	addi	a0,a0,-1348 # 6490 <malloc+0x422>
     9dc:	00005097          	auipc	ra,0x5
     9e0:	5d2080e7          	jalr	1490(ra) # 5fae <printf>
    exit(1);
     9e4:	4505                	li	a0,1
     9e6:	00005097          	auipc	ra,0x5
     9ea:	232080e7          	jalr	562(ra) # 5c18 <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     9ee:	862a                	mv	a2,a0
     9f0:	85d6                	mv	a1,s5
     9f2:	00006517          	auipc	a0,0x6
     9f6:	abe50513          	addi	a0,a0,-1346 # 64b0 <malloc+0x442>
     9fa:	00005097          	auipc	ra,0x5
     9fe:	5b4080e7          	jalr	1460(ra) # 5fae <printf>
    exit(1);
     a02:	4505                	li	a0,1
     a04:	00005097          	auipc	ra,0x5
     a08:	214080e7          	jalr	532(ra) # 5c18 <exit>

0000000000000a0c <writetest>:
{
     a0c:	7139                	addi	sp,sp,-64
     a0e:	fc06                	sd	ra,56(sp)
     a10:	f822                	sd	s0,48(sp)
     a12:	f426                	sd	s1,40(sp)
     a14:	f04a                	sd	s2,32(sp)
     a16:	ec4e                	sd	s3,24(sp)
     a18:	e852                	sd	s4,16(sp)
     a1a:	e456                	sd	s5,8(sp)
     a1c:	e05a                	sd	s6,0(sp)
     a1e:	0080                	addi	s0,sp,64
     a20:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE|O_RDWR);
     a22:	20200593          	li	a1,514
     a26:	00006517          	auipc	a0,0x6
     a2a:	aaa50513          	addi	a0,a0,-1366 # 64d0 <malloc+0x462>
     a2e:	00005097          	auipc	ra,0x5
     a32:	22a080e7          	jalr	554(ra) # 5c58 <open>
  if(fd < 0){
     a36:	0a054d63          	bltz	a0,af0 <writetest+0xe4>
     a3a:	892a                	mv	s2,a0
     a3c:	4481                	li	s1,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     a3e:	00006997          	auipc	s3,0x6
     a42:	aba98993          	addi	s3,s3,-1350 # 64f8 <malloc+0x48a>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     a46:	00006a97          	auipc	s5,0x6
     a4a:	aeaa8a93          	addi	s5,s5,-1302 # 6530 <malloc+0x4c2>
  for(i = 0; i < N; i++){
     a4e:	06400a13          	li	s4,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     a52:	4629                	li	a2,10
     a54:	85ce                	mv	a1,s3
     a56:	854a                	mv	a0,s2
     a58:	00005097          	auipc	ra,0x5
     a5c:	1e0080e7          	jalr	480(ra) # 5c38 <write>
     a60:	47a9                	li	a5,10
     a62:	0af51563          	bne	a0,a5,b0c <writetest+0x100>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     a66:	4629                	li	a2,10
     a68:	85d6                	mv	a1,s5
     a6a:	854a                	mv	a0,s2
     a6c:	00005097          	auipc	ra,0x5
     a70:	1cc080e7          	jalr	460(ra) # 5c38 <write>
     a74:	47a9                	li	a5,10
     a76:	0af51a63          	bne	a0,a5,b2a <writetest+0x11e>
  for(i = 0; i < N; i++){
     a7a:	2485                	addiw	s1,s1,1
     a7c:	fd449be3          	bne	s1,s4,a52 <writetest+0x46>
  close(fd);
     a80:	854a                	mv	a0,s2
     a82:	00005097          	auipc	ra,0x5
     a86:	1be080e7          	jalr	446(ra) # 5c40 <close>
  fd = open("small", O_RDONLY);
     a8a:	4581                	li	a1,0
     a8c:	00006517          	auipc	a0,0x6
     a90:	a4450513          	addi	a0,a0,-1468 # 64d0 <malloc+0x462>
     a94:	00005097          	auipc	ra,0x5
     a98:	1c4080e7          	jalr	452(ra) # 5c58 <open>
     a9c:	84aa                	mv	s1,a0
  if(fd < 0){
     a9e:	0a054563          	bltz	a0,b48 <writetest+0x13c>
  i = read(fd, buf, N*SZ*2);
     aa2:	7d000613          	li	a2,2000
     aa6:	0000c597          	auipc	a1,0xc
     aaa:	1d258593          	addi	a1,a1,466 # cc78 <buf>
     aae:	00005097          	auipc	ra,0x5
     ab2:	182080e7          	jalr	386(ra) # 5c30 <read>
  if(i != N*SZ*2){
     ab6:	7d000793          	li	a5,2000
     aba:	0af51563          	bne	a0,a5,b64 <writetest+0x158>
  close(fd);
     abe:	8526                	mv	a0,s1
     ac0:	00005097          	auipc	ra,0x5
     ac4:	180080e7          	jalr	384(ra) # 5c40 <close>
  if(unlink("small") < 0){
     ac8:	00006517          	auipc	a0,0x6
     acc:	a0850513          	addi	a0,a0,-1528 # 64d0 <malloc+0x462>
     ad0:	00005097          	auipc	ra,0x5
     ad4:	198080e7          	jalr	408(ra) # 5c68 <unlink>
     ad8:	0a054463          	bltz	a0,b80 <writetest+0x174>
}
     adc:	70e2                	ld	ra,56(sp)
     ade:	7442                	ld	s0,48(sp)
     ae0:	74a2                	ld	s1,40(sp)
     ae2:	7902                	ld	s2,32(sp)
     ae4:	69e2                	ld	s3,24(sp)
     ae6:	6a42                	ld	s4,16(sp)
     ae8:	6aa2                	ld	s5,8(sp)
     aea:	6b02                	ld	s6,0(sp)
     aec:	6121                	addi	sp,sp,64
     aee:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     af0:	85da                	mv	a1,s6
     af2:	00006517          	auipc	a0,0x6
     af6:	9e650513          	addi	a0,a0,-1562 # 64d8 <malloc+0x46a>
     afa:	00005097          	auipc	ra,0x5
     afe:	4b4080e7          	jalr	1204(ra) # 5fae <printf>
    exit(1);
     b02:	4505                	li	a0,1
     b04:	00005097          	auipc	ra,0x5
     b08:	114080e7          	jalr	276(ra) # 5c18 <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     b0c:	8626                	mv	a2,s1
     b0e:	85da                	mv	a1,s6
     b10:	00006517          	auipc	a0,0x6
     b14:	9f850513          	addi	a0,a0,-1544 # 6508 <malloc+0x49a>
     b18:	00005097          	auipc	ra,0x5
     b1c:	496080e7          	jalr	1174(ra) # 5fae <printf>
      exit(1);
     b20:	4505                	li	a0,1
     b22:	00005097          	auipc	ra,0x5
     b26:	0f6080e7          	jalr	246(ra) # 5c18 <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     b2a:	8626                	mv	a2,s1
     b2c:	85da                	mv	a1,s6
     b2e:	00006517          	auipc	a0,0x6
     b32:	a1250513          	addi	a0,a0,-1518 # 6540 <malloc+0x4d2>
     b36:	00005097          	auipc	ra,0x5
     b3a:	478080e7          	jalr	1144(ra) # 5fae <printf>
      exit(1);
     b3e:	4505                	li	a0,1
     b40:	00005097          	auipc	ra,0x5
     b44:	0d8080e7          	jalr	216(ra) # 5c18 <exit>
    printf("%s: error: open small failed!\n", s);
     b48:	85da                	mv	a1,s6
     b4a:	00006517          	auipc	a0,0x6
     b4e:	a1e50513          	addi	a0,a0,-1506 # 6568 <malloc+0x4fa>
     b52:	00005097          	auipc	ra,0x5
     b56:	45c080e7          	jalr	1116(ra) # 5fae <printf>
    exit(1);
     b5a:	4505                	li	a0,1
     b5c:	00005097          	auipc	ra,0x5
     b60:	0bc080e7          	jalr	188(ra) # 5c18 <exit>
    printf("%s: read failed\n", s);
     b64:	85da                	mv	a1,s6
     b66:	00006517          	auipc	a0,0x6
     b6a:	a2250513          	addi	a0,a0,-1502 # 6588 <malloc+0x51a>
     b6e:	00005097          	auipc	ra,0x5
     b72:	440080e7          	jalr	1088(ra) # 5fae <printf>
    exit(1);
     b76:	4505                	li	a0,1
     b78:	00005097          	auipc	ra,0x5
     b7c:	0a0080e7          	jalr	160(ra) # 5c18 <exit>
    printf("%s: unlink small failed\n", s);
     b80:	85da                	mv	a1,s6
     b82:	00006517          	auipc	a0,0x6
     b86:	a1e50513          	addi	a0,a0,-1506 # 65a0 <malloc+0x532>
     b8a:	00005097          	auipc	ra,0x5
     b8e:	424080e7          	jalr	1060(ra) # 5fae <printf>
    exit(1);
     b92:	4505                	li	a0,1
     b94:	00005097          	auipc	ra,0x5
     b98:	084080e7          	jalr	132(ra) # 5c18 <exit>

0000000000000b9c <writebig>:
{
     b9c:	7139                	addi	sp,sp,-64
     b9e:	fc06                	sd	ra,56(sp)
     ba0:	f822                	sd	s0,48(sp)
     ba2:	f426                	sd	s1,40(sp)
     ba4:	f04a                	sd	s2,32(sp)
     ba6:	ec4e                	sd	s3,24(sp)
     ba8:	e852                	sd	s4,16(sp)
     baa:	e456                	sd	s5,8(sp)
     bac:	0080                	addi	s0,sp,64
     bae:	8aaa                	mv	s5,a0
  fd = open("big", O_CREATE|O_RDWR);
     bb0:	20200593          	li	a1,514
     bb4:	00006517          	auipc	a0,0x6
     bb8:	a0c50513          	addi	a0,a0,-1524 # 65c0 <malloc+0x552>
     bbc:	00005097          	auipc	ra,0x5
     bc0:	09c080e7          	jalr	156(ra) # 5c58 <open>
     bc4:	89aa                	mv	s3,a0
  for(i = 0; i < MAXFILE; i++){
     bc6:	4481                	li	s1,0
    ((int*)buf)[0] = i;
     bc8:	0000c917          	auipc	s2,0xc
     bcc:	0b090913          	addi	s2,s2,176 # cc78 <buf>
  for(i = 0; i < MAXFILE; i++){
     bd0:	10c00a13          	li	s4,268
  if(fd < 0){
     bd4:	06054c63          	bltz	a0,c4c <writebig+0xb0>
    ((int*)buf)[0] = i;
     bd8:	00992023          	sw	s1,0(s2)
    if(write(fd, buf, BSIZE) != BSIZE){
     bdc:	40000613          	li	a2,1024
     be0:	85ca                	mv	a1,s2
     be2:	854e                	mv	a0,s3
     be4:	00005097          	auipc	ra,0x5
     be8:	054080e7          	jalr	84(ra) # 5c38 <write>
     bec:	40000793          	li	a5,1024
     bf0:	06f51c63          	bne	a0,a5,c68 <writebig+0xcc>
  for(i = 0; i < MAXFILE; i++){
     bf4:	2485                	addiw	s1,s1,1
     bf6:	ff4491e3          	bne	s1,s4,bd8 <writebig+0x3c>
  close(fd);
     bfa:	854e                	mv	a0,s3
     bfc:	00005097          	auipc	ra,0x5
     c00:	044080e7          	jalr	68(ra) # 5c40 <close>
  fd = open("big", O_RDONLY);
     c04:	4581                	li	a1,0
     c06:	00006517          	auipc	a0,0x6
     c0a:	9ba50513          	addi	a0,a0,-1606 # 65c0 <malloc+0x552>
     c0e:	00005097          	auipc	ra,0x5
     c12:	04a080e7          	jalr	74(ra) # 5c58 <open>
     c16:	89aa                	mv	s3,a0
  n = 0;
     c18:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     c1a:	0000c917          	auipc	s2,0xc
     c1e:	05e90913          	addi	s2,s2,94 # cc78 <buf>
  if(fd < 0){
     c22:	06054263          	bltz	a0,c86 <writebig+0xea>
    i = read(fd, buf, BSIZE);
     c26:	40000613          	li	a2,1024
     c2a:	85ca                	mv	a1,s2
     c2c:	854e                	mv	a0,s3
     c2e:	00005097          	auipc	ra,0x5
     c32:	002080e7          	jalr	2(ra) # 5c30 <read>
    if(i == 0){
     c36:	c535                	beqz	a0,ca2 <writebig+0x106>
    } else if(i != BSIZE){
     c38:	40000793          	li	a5,1024
     c3c:	0af51f63          	bne	a0,a5,cfa <writebig+0x15e>
    if(((int*)buf)[0] != n){
     c40:	00092683          	lw	a3,0(s2)
     c44:	0c969a63          	bne	a3,s1,d18 <writebig+0x17c>
    n++;
     c48:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
     c4a:	bff1                	j	c26 <writebig+0x8a>
    printf("%s: error: creat big failed!\n", s);
     c4c:	85d6                	mv	a1,s5
     c4e:	00006517          	auipc	a0,0x6
     c52:	97a50513          	addi	a0,a0,-1670 # 65c8 <malloc+0x55a>
     c56:	00005097          	auipc	ra,0x5
     c5a:	358080e7          	jalr	856(ra) # 5fae <printf>
    exit(1);
     c5e:	4505                	li	a0,1
     c60:	00005097          	auipc	ra,0x5
     c64:	fb8080e7          	jalr	-72(ra) # 5c18 <exit>
      printf("%s: error: write big file failed\n", s, i);
     c68:	8626                	mv	a2,s1
     c6a:	85d6                	mv	a1,s5
     c6c:	00006517          	auipc	a0,0x6
     c70:	97c50513          	addi	a0,a0,-1668 # 65e8 <malloc+0x57a>
     c74:	00005097          	auipc	ra,0x5
     c78:	33a080e7          	jalr	826(ra) # 5fae <printf>
      exit(1);
     c7c:	4505                	li	a0,1
     c7e:	00005097          	auipc	ra,0x5
     c82:	f9a080e7          	jalr	-102(ra) # 5c18 <exit>
    printf("%s: error: open big failed!\n", s);
     c86:	85d6                	mv	a1,s5
     c88:	00006517          	auipc	a0,0x6
     c8c:	98850513          	addi	a0,a0,-1656 # 6610 <malloc+0x5a2>
     c90:	00005097          	auipc	ra,0x5
     c94:	31e080e7          	jalr	798(ra) # 5fae <printf>
    exit(1);
     c98:	4505                	li	a0,1
     c9a:	00005097          	auipc	ra,0x5
     c9e:	f7e080e7          	jalr	-130(ra) # 5c18 <exit>
      if(n == MAXFILE - 1){
     ca2:	10b00793          	li	a5,267
     ca6:	02f48a63          	beq	s1,a5,cda <writebig+0x13e>
  close(fd);
     caa:	854e                	mv	a0,s3
     cac:	00005097          	auipc	ra,0x5
     cb0:	f94080e7          	jalr	-108(ra) # 5c40 <close>
  if(unlink("big") < 0){
     cb4:	00006517          	auipc	a0,0x6
     cb8:	90c50513          	addi	a0,a0,-1780 # 65c0 <malloc+0x552>
     cbc:	00005097          	auipc	ra,0x5
     cc0:	fac080e7          	jalr	-84(ra) # 5c68 <unlink>
     cc4:	06054963          	bltz	a0,d36 <writebig+0x19a>
}
     cc8:	70e2                	ld	ra,56(sp)
     cca:	7442                	ld	s0,48(sp)
     ccc:	74a2                	ld	s1,40(sp)
     cce:	7902                	ld	s2,32(sp)
     cd0:	69e2                	ld	s3,24(sp)
     cd2:	6a42                	ld	s4,16(sp)
     cd4:	6aa2                	ld	s5,8(sp)
     cd6:	6121                	addi	sp,sp,64
     cd8:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     cda:	10b00613          	li	a2,267
     cde:	85d6                	mv	a1,s5
     ce0:	00006517          	auipc	a0,0x6
     ce4:	95050513          	addi	a0,a0,-1712 # 6630 <malloc+0x5c2>
     ce8:	00005097          	auipc	ra,0x5
     cec:	2c6080e7          	jalr	710(ra) # 5fae <printf>
        exit(1);
     cf0:	4505                	li	a0,1
     cf2:	00005097          	auipc	ra,0x5
     cf6:	f26080e7          	jalr	-218(ra) # 5c18 <exit>
      printf("%s: read failed %d\n", s, i);
     cfa:	862a                	mv	a2,a0
     cfc:	85d6                	mv	a1,s5
     cfe:	00006517          	auipc	a0,0x6
     d02:	95a50513          	addi	a0,a0,-1702 # 6658 <malloc+0x5ea>
     d06:	00005097          	auipc	ra,0x5
     d0a:	2a8080e7          	jalr	680(ra) # 5fae <printf>
      exit(1);
     d0e:	4505                	li	a0,1
     d10:	00005097          	auipc	ra,0x5
     d14:	f08080e7          	jalr	-248(ra) # 5c18 <exit>
      printf("%s: read content of block %d is %d\n", s,
     d18:	8626                	mv	a2,s1
     d1a:	85d6                	mv	a1,s5
     d1c:	00006517          	auipc	a0,0x6
     d20:	95450513          	addi	a0,a0,-1708 # 6670 <malloc+0x602>
     d24:	00005097          	auipc	ra,0x5
     d28:	28a080e7          	jalr	650(ra) # 5fae <printf>
      exit(1);
     d2c:	4505                	li	a0,1
     d2e:	00005097          	auipc	ra,0x5
     d32:	eea080e7          	jalr	-278(ra) # 5c18 <exit>
    printf("%s: unlink big failed\n", s);
     d36:	85d6                	mv	a1,s5
     d38:	00006517          	auipc	a0,0x6
     d3c:	96050513          	addi	a0,a0,-1696 # 6698 <malloc+0x62a>
     d40:	00005097          	auipc	ra,0x5
     d44:	26e080e7          	jalr	622(ra) # 5fae <printf>
    exit(1);
     d48:	4505                	li	a0,1
     d4a:	00005097          	auipc	ra,0x5
     d4e:	ece080e7          	jalr	-306(ra) # 5c18 <exit>

0000000000000d52 <unlinkread>:
{
     d52:	7179                	addi	sp,sp,-48
     d54:	f406                	sd	ra,40(sp)
     d56:	f022                	sd	s0,32(sp)
     d58:	ec26                	sd	s1,24(sp)
     d5a:	e84a                	sd	s2,16(sp)
     d5c:	e44e                	sd	s3,8(sp)
     d5e:	1800                	addi	s0,sp,48
     d60:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     d62:	20200593          	li	a1,514
     d66:	00006517          	auipc	a0,0x6
     d6a:	94a50513          	addi	a0,a0,-1718 # 66b0 <malloc+0x642>
     d6e:	00005097          	auipc	ra,0x5
     d72:	eea080e7          	jalr	-278(ra) # 5c58 <open>
  if(fd < 0){
     d76:	0e054563          	bltz	a0,e60 <unlinkread+0x10e>
     d7a:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     d7c:	4615                	li	a2,5
     d7e:	00006597          	auipc	a1,0x6
     d82:	96258593          	addi	a1,a1,-1694 # 66e0 <malloc+0x672>
     d86:	00005097          	auipc	ra,0x5
     d8a:	eb2080e7          	jalr	-334(ra) # 5c38 <write>
  close(fd);
     d8e:	8526                	mv	a0,s1
     d90:	00005097          	auipc	ra,0x5
     d94:	eb0080e7          	jalr	-336(ra) # 5c40 <close>
  fd = open("unlinkread", O_RDWR);
     d98:	4589                	li	a1,2
     d9a:	00006517          	auipc	a0,0x6
     d9e:	91650513          	addi	a0,a0,-1770 # 66b0 <malloc+0x642>
     da2:	00005097          	auipc	ra,0x5
     da6:	eb6080e7          	jalr	-330(ra) # 5c58 <open>
     daa:	84aa                	mv	s1,a0
  if(fd < 0){
     dac:	0c054863          	bltz	a0,e7c <unlinkread+0x12a>
  if(unlink("unlinkread") != 0){
     db0:	00006517          	auipc	a0,0x6
     db4:	90050513          	addi	a0,a0,-1792 # 66b0 <malloc+0x642>
     db8:	00005097          	auipc	ra,0x5
     dbc:	eb0080e7          	jalr	-336(ra) # 5c68 <unlink>
     dc0:	ed61                	bnez	a0,e98 <unlinkread+0x146>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     dc2:	20200593          	li	a1,514
     dc6:	00006517          	auipc	a0,0x6
     dca:	8ea50513          	addi	a0,a0,-1814 # 66b0 <malloc+0x642>
     dce:	00005097          	auipc	ra,0x5
     dd2:	e8a080e7          	jalr	-374(ra) # 5c58 <open>
     dd6:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     dd8:	460d                	li	a2,3
     dda:	00006597          	auipc	a1,0x6
     dde:	94e58593          	addi	a1,a1,-1714 # 6728 <malloc+0x6ba>
     de2:	00005097          	auipc	ra,0x5
     de6:	e56080e7          	jalr	-426(ra) # 5c38 <write>
  close(fd1);
     dea:	854a                	mv	a0,s2
     dec:	00005097          	auipc	ra,0x5
     df0:	e54080e7          	jalr	-428(ra) # 5c40 <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     df4:	660d                	lui	a2,0x3
     df6:	0000c597          	auipc	a1,0xc
     dfa:	e8258593          	addi	a1,a1,-382 # cc78 <buf>
     dfe:	8526                	mv	a0,s1
     e00:	00005097          	auipc	ra,0x5
     e04:	e30080e7          	jalr	-464(ra) # 5c30 <read>
     e08:	4795                	li	a5,5
     e0a:	0af51563          	bne	a0,a5,eb4 <unlinkread+0x162>
  if(buf[0] != 'h'){
     e0e:	0000c717          	auipc	a4,0xc
     e12:	e6a74703          	lbu	a4,-406(a4) # cc78 <buf>
     e16:	06800793          	li	a5,104
     e1a:	0af71b63          	bne	a4,a5,ed0 <unlinkread+0x17e>
  if(write(fd, buf, 10) != 10){
     e1e:	4629                	li	a2,10
     e20:	0000c597          	auipc	a1,0xc
     e24:	e5858593          	addi	a1,a1,-424 # cc78 <buf>
     e28:	8526                	mv	a0,s1
     e2a:	00005097          	auipc	ra,0x5
     e2e:	e0e080e7          	jalr	-498(ra) # 5c38 <write>
     e32:	47a9                	li	a5,10
     e34:	0af51c63          	bne	a0,a5,eec <unlinkread+0x19a>
  close(fd);
     e38:	8526                	mv	a0,s1
     e3a:	00005097          	auipc	ra,0x5
     e3e:	e06080e7          	jalr	-506(ra) # 5c40 <close>
  unlink("unlinkread");
     e42:	00006517          	auipc	a0,0x6
     e46:	86e50513          	addi	a0,a0,-1938 # 66b0 <malloc+0x642>
     e4a:	00005097          	auipc	ra,0x5
     e4e:	e1e080e7          	jalr	-482(ra) # 5c68 <unlink>
}
     e52:	70a2                	ld	ra,40(sp)
     e54:	7402                	ld	s0,32(sp)
     e56:	64e2                	ld	s1,24(sp)
     e58:	6942                	ld	s2,16(sp)
     e5a:	69a2                	ld	s3,8(sp)
     e5c:	6145                	addi	sp,sp,48
     e5e:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     e60:	85ce                	mv	a1,s3
     e62:	00006517          	auipc	a0,0x6
     e66:	85e50513          	addi	a0,a0,-1954 # 66c0 <malloc+0x652>
     e6a:	00005097          	auipc	ra,0x5
     e6e:	144080e7          	jalr	324(ra) # 5fae <printf>
    exit(1);
     e72:	4505                	li	a0,1
     e74:	00005097          	auipc	ra,0x5
     e78:	da4080e7          	jalr	-604(ra) # 5c18 <exit>
    printf("%s: open unlinkread failed\n", s);
     e7c:	85ce                	mv	a1,s3
     e7e:	00006517          	auipc	a0,0x6
     e82:	86a50513          	addi	a0,a0,-1942 # 66e8 <malloc+0x67a>
     e86:	00005097          	auipc	ra,0x5
     e8a:	128080e7          	jalr	296(ra) # 5fae <printf>
    exit(1);
     e8e:	4505                	li	a0,1
     e90:	00005097          	auipc	ra,0x5
     e94:	d88080e7          	jalr	-632(ra) # 5c18 <exit>
    printf("%s: unlink unlinkread failed\n", s);
     e98:	85ce                	mv	a1,s3
     e9a:	00006517          	auipc	a0,0x6
     e9e:	86e50513          	addi	a0,a0,-1938 # 6708 <malloc+0x69a>
     ea2:	00005097          	auipc	ra,0x5
     ea6:	10c080e7          	jalr	268(ra) # 5fae <printf>
    exit(1);
     eaa:	4505                	li	a0,1
     eac:	00005097          	auipc	ra,0x5
     eb0:	d6c080e7          	jalr	-660(ra) # 5c18 <exit>
    printf("%s: unlinkread read failed", s);
     eb4:	85ce                	mv	a1,s3
     eb6:	00006517          	auipc	a0,0x6
     eba:	87a50513          	addi	a0,a0,-1926 # 6730 <malloc+0x6c2>
     ebe:	00005097          	auipc	ra,0x5
     ec2:	0f0080e7          	jalr	240(ra) # 5fae <printf>
    exit(1);
     ec6:	4505                	li	a0,1
     ec8:	00005097          	auipc	ra,0x5
     ecc:	d50080e7          	jalr	-688(ra) # 5c18 <exit>
    printf("%s: unlinkread wrong data\n", s);
     ed0:	85ce                	mv	a1,s3
     ed2:	00006517          	auipc	a0,0x6
     ed6:	87e50513          	addi	a0,a0,-1922 # 6750 <malloc+0x6e2>
     eda:	00005097          	auipc	ra,0x5
     ede:	0d4080e7          	jalr	212(ra) # 5fae <printf>
    exit(1);
     ee2:	4505                	li	a0,1
     ee4:	00005097          	auipc	ra,0x5
     ee8:	d34080e7          	jalr	-716(ra) # 5c18 <exit>
    printf("%s: unlinkread write failed\n", s);
     eec:	85ce                	mv	a1,s3
     eee:	00006517          	auipc	a0,0x6
     ef2:	88250513          	addi	a0,a0,-1918 # 6770 <malloc+0x702>
     ef6:	00005097          	auipc	ra,0x5
     efa:	0b8080e7          	jalr	184(ra) # 5fae <printf>
    exit(1);
     efe:	4505                	li	a0,1
     f00:	00005097          	auipc	ra,0x5
     f04:	d18080e7          	jalr	-744(ra) # 5c18 <exit>

0000000000000f08 <linktest>:
{
     f08:	1101                	addi	sp,sp,-32
     f0a:	ec06                	sd	ra,24(sp)
     f0c:	e822                	sd	s0,16(sp)
     f0e:	e426                	sd	s1,8(sp)
     f10:	e04a                	sd	s2,0(sp)
     f12:	1000                	addi	s0,sp,32
     f14:	892a                	mv	s2,a0
  unlink("lf1");
     f16:	00006517          	auipc	a0,0x6
     f1a:	87a50513          	addi	a0,a0,-1926 # 6790 <malloc+0x722>
     f1e:	00005097          	auipc	ra,0x5
     f22:	d4a080e7          	jalr	-694(ra) # 5c68 <unlink>
  unlink("lf2");
     f26:	00006517          	auipc	a0,0x6
     f2a:	87250513          	addi	a0,a0,-1934 # 6798 <malloc+0x72a>
     f2e:	00005097          	auipc	ra,0x5
     f32:	d3a080e7          	jalr	-710(ra) # 5c68 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
     f36:	20200593          	li	a1,514
     f3a:	00006517          	auipc	a0,0x6
     f3e:	85650513          	addi	a0,a0,-1962 # 6790 <malloc+0x722>
     f42:	00005097          	auipc	ra,0x5
     f46:	d16080e7          	jalr	-746(ra) # 5c58 <open>
  if(fd < 0){
     f4a:	10054763          	bltz	a0,1058 <linktest+0x150>
     f4e:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
     f50:	4615                	li	a2,5
     f52:	00005597          	auipc	a1,0x5
     f56:	78e58593          	addi	a1,a1,1934 # 66e0 <malloc+0x672>
     f5a:	00005097          	auipc	ra,0x5
     f5e:	cde080e7          	jalr	-802(ra) # 5c38 <write>
     f62:	4795                	li	a5,5
     f64:	10f51863          	bne	a0,a5,1074 <linktest+0x16c>
  close(fd);
     f68:	8526                	mv	a0,s1
     f6a:	00005097          	auipc	ra,0x5
     f6e:	cd6080e7          	jalr	-810(ra) # 5c40 <close>
  if(link("lf1", "lf2") < 0){
     f72:	00006597          	auipc	a1,0x6
     f76:	82658593          	addi	a1,a1,-2010 # 6798 <malloc+0x72a>
     f7a:	00006517          	auipc	a0,0x6
     f7e:	81650513          	addi	a0,a0,-2026 # 6790 <malloc+0x722>
     f82:	00005097          	auipc	ra,0x5
     f86:	cf6080e7          	jalr	-778(ra) # 5c78 <link>
     f8a:	10054363          	bltz	a0,1090 <linktest+0x188>
  unlink("lf1");
     f8e:	00006517          	auipc	a0,0x6
     f92:	80250513          	addi	a0,a0,-2046 # 6790 <malloc+0x722>
     f96:	00005097          	auipc	ra,0x5
     f9a:	cd2080e7          	jalr	-814(ra) # 5c68 <unlink>
  if(open("lf1", 0) >= 0){
     f9e:	4581                	li	a1,0
     fa0:	00005517          	auipc	a0,0x5
     fa4:	7f050513          	addi	a0,a0,2032 # 6790 <malloc+0x722>
     fa8:	00005097          	auipc	ra,0x5
     fac:	cb0080e7          	jalr	-848(ra) # 5c58 <open>
     fb0:	0e055e63          	bgez	a0,10ac <linktest+0x1a4>
  fd = open("lf2", 0);
     fb4:	4581                	li	a1,0
     fb6:	00005517          	auipc	a0,0x5
     fba:	7e250513          	addi	a0,a0,2018 # 6798 <malloc+0x72a>
     fbe:	00005097          	auipc	ra,0x5
     fc2:	c9a080e7          	jalr	-870(ra) # 5c58 <open>
     fc6:	84aa                	mv	s1,a0
  if(fd < 0){
     fc8:	10054063          	bltz	a0,10c8 <linktest+0x1c0>
  if(read(fd, buf, sizeof(buf)) != SZ){
     fcc:	660d                	lui	a2,0x3
     fce:	0000c597          	auipc	a1,0xc
     fd2:	caa58593          	addi	a1,a1,-854 # cc78 <buf>
     fd6:	00005097          	auipc	ra,0x5
     fda:	c5a080e7          	jalr	-934(ra) # 5c30 <read>
     fde:	4795                	li	a5,5
     fe0:	10f51263          	bne	a0,a5,10e4 <linktest+0x1dc>
  close(fd);
     fe4:	8526                	mv	a0,s1
     fe6:	00005097          	auipc	ra,0x5
     fea:	c5a080e7          	jalr	-934(ra) # 5c40 <close>
  if(link("lf2", "lf2") >= 0){
     fee:	00005597          	auipc	a1,0x5
     ff2:	7aa58593          	addi	a1,a1,1962 # 6798 <malloc+0x72a>
     ff6:	852e                	mv	a0,a1
     ff8:	00005097          	auipc	ra,0x5
     ffc:	c80080e7          	jalr	-896(ra) # 5c78 <link>
    1000:	10055063          	bgez	a0,1100 <linktest+0x1f8>
  unlink("lf2");
    1004:	00005517          	auipc	a0,0x5
    1008:	79450513          	addi	a0,a0,1940 # 6798 <malloc+0x72a>
    100c:	00005097          	auipc	ra,0x5
    1010:	c5c080e7          	jalr	-932(ra) # 5c68 <unlink>
  if(link("lf2", "lf1") >= 0){
    1014:	00005597          	auipc	a1,0x5
    1018:	77c58593          	addi	a1,a1,1916 # 6790 <malloc+0x722>
    101c:	00005517          	auipc	a0,0x5
    1020:	77c50513          	addi	a0,a0,1916 # 6798 <malloc+0x72a>
    1024:	00005097          	auipc	ra,0x5
    1028:	c54080e7          	jalr	-940(ra) # 5c78 <link>
    102c:	0e055863          	bgez	a0,111c <linktest+0x214>
  if(link(".", "lf1") >= 0){
    1030:	00005597          	auipc	a1,0x5
    1034:	76058593          	addi	a1,a1,1888 # 6790 <malloc+0x722>
    1038:	00006517          	auipc	a0,0x6
    103c:	86850513          	addi	a0,a0,-1944 # 68a0 <malloc+0x832>
    1040:	00005097          	auipc	ra,0x5
    1044:	c38080e7          	jalr	-968(ra) # 5c78 <link>
    1048:	0e055863          	bgez	a0,1138 <linktest+0x230>
}
    104c:	60e2                	ld	ra,24(sp)
    104e:	6442                	ld	s0,16(sp)
    1050:	64a2                	ld	s1,8(sp)
    1052:	6902                	ld	s2,0(sp)
    1054:	6105                	addi	sp,sp,32
    1056:	8082                	ret
    printf("%s: create lf1 failed\n", s);
    1058:	85ca                	mv	a1,s2
    105a:	00005517          	auipc	a0,0x5
    105e:	74650513          	addi	a0,a0,1862 # 67a0 <malloc+0x732>
    1062:	00005097          	auipc	ra,0x5
    1066:	f4c080e7          	jalr	-180(ra) # 5fae <printf>
    exit(1);
    106a:	4505                	li	a0,1
    106c:	00005097          	auipc	ra,0x5
    1070:	bac080e7          	jalr	-1108(ra) # 5c18 <exit>
    printf("%s: write lf1 failed\n", s);
    1074:	85ca                	mv	a1,s2
    1076:	00005517          	auipc	a0,0x5
    107a:	74250513          	addi	a0,a0,1858 # 67b8 <malloc+0x74a>
    107e:	00005097          	auipc	ra,0x5
    1082:	f30080e7          	jalr	-208(ra) # 5fae <printf>
    exit(1);
    1086:	4505                	li	a0,1
    1088:	00005097          	auipc	ra,0x5
    108c:	b90080e7          	jalr	-1136(ra) # 5c18 <exit>
    printf("%s: link lf1 lf2 failed\n", s);
    1090:	85ca                	mv	a1,s2
    1092:	00005517          	auipc	a0,0x5
    1096:	73e50513          	addi	a0,a0,1854 # 67d0 <malloc+0x762>
    109a:	00005097          	auipc	ra,0x5
    109e:	f14080e7          	jalr	-236(ra) # 5fae <printf>
    exit(1);
    10a2:	4505                	li	a0,1
    10a4:	00005097          	auipc	ra,0x5
    10a8:	b74080e7          	jalr	-1164(ra) # 5c18 <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
    10ac:	85ca                	mv	a1,s2
    10ae:	00005517          	auipc	a0,0x5
    10b2:	74250513          	addi	a0,a0,1858 # 67f0 <malloc+0x782>
    10b6:	00005097          	auipc	ra,0x5
    10ba:	ef8080e7          	jalr	-264(ra) # 5fae <printf>
    exit(1);
    10be:	4505                	li	a0,1
    10c0:	00005097          	auipc	ra,0x5
    10c4:	b58080e7          	jalr	-1192(ra) # 5c18 <exit>
    printf("%s: open lf2 failed\n", s);
    10c8:	85ca                	mv	a1,s2
    10ca:	00005517          	auipc	a0,0x5
    10ce:	75650513          	addi	a0,a0,1878 # 6820 <malloc+0x7b2>
    10d2:	00005097          	auipc	ra,0x5
    10d6:	edc080e7          	jalr	-292(ra) # 5fae <printf>
    exit(1);
    10da:	4505                	li	a0,1
    10dc:	00005097          	auipc	ra,0x5
    10e0:	b3c080e7          	jalr	-1220(ra) # 5c18 <exit>
    printf("%s: read lf2 failed\n", s);
    10e4:	85ca                	mv	a1,s2
    10e6:	00005517          	auipc	a0,0x5
    10ea:	75250513          	addi	a0,a0,1874 # 6838 <malloc+0x7ca>
    10ee:	00005097          	auipc	ra,0x5
    10f2:	ec0080e7          	jalr	-320(ra) # 5fae <printf>
    exit(1);
    10f6:	4505                	li	a0,1
    10f8:	00005097          	auipc	ra,0x5
    10fc:	b20080e7          	jalr	-1248(ra) # 5c18 <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
    1100:	85ca                	mv	a1,s2
    1102:	00005517          	auipc	a0,0x5
    1106:	74e50513          	addi	a0,a0,1870 # 6850 <malloc+0x7e2>
    110a:	00005097          	auipc	ra,0x5
    110e:	ea4080e7          	jalr	-348(ra) # 5fae <printf>
    exit(1);
    1112:	4505                	li	a0,1
    1114:	00005097          	auipc	ra,0x5
    1118:	b04080e7          	jalr	-1276(ra) # 5c18 <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
    111c:	85ca                	mv	a1,s2
    111e:	00005517          	auipc	a0,0x5
    1122:	75a50513          	addi	a0,a0,1882 # 6878 <malloc+0x80a>
    1126:	00005097          	auipc	ra,0x5
    112a:	e88080e7          	jalr	-376(ra) # 5fae <printf>
    exit(1);
    112e:	4505                	li	a0,1
    1130:	00005097          	auipc	ra,0x5
    1134:	ae8080e7          	jalr	-1304(ra) # 5c18 <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
    1138:	85ca                	mv	a1,s2
    113a:	00005517          	auipc	a0,0x5
    113e:	76e50513          	addi	a0,a0,1902 # 68a8 <malloc+0x83a>
    1142:	00005097          	auipc	ra,0x5
    1146:	e6c080e7          	jalr	-404(ra) # 5fae <printf>
    exit(1);
    114a:	4505                	li	a0,1
    114c:	00005097          	auipc	ra,0x5
    1150:	acc080e7          	jalr	-1332(ra) # 5c18 <exit>

0000000000001154 <validatetest>:
{
    1154:	7139                	addi	sp,sp,-64
    1156:	fc06                	sd	ra,56(sp)
    1158:	f822                	sd	s0,48(sp)
    115a:	f426                	sd	s1,40(sp)
    115c:	f04a                	sd	s2,32(sp)
    115e:	ec4e                	sd	s3,24(sp)
    1160:	e852                	sd	s4,16(sp)
    1162:	e456                	sd	s5,8(sp)
    1164:	e05a                	sd	s6,0(sp)
    1166:	0080                	addi	s0,sp,64
    1168:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    116a:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
    116c:	00005997          	auipc	s3,0x5
    1170:	75c98993          	addi	s3,s3,1884 # 68c8 <malloc+0x85a>
    1174:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    1176:	6a85                	lui	s5,0x1
    1178:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
    117c:	85a6                	mv	a1,s1
    117e:	854e                	mv	a0,s3
    1180:	00005097          	auipc	ra,0x5
    1184:	af8080e7          	jalr	-1288(ra) # 5c78 <link>
    1188:	01251f63          	bne	a0,s2,11a6 <validatetest+0x52>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    118c:	94d6                	add	s1,s1,s5
    118e:	ff4497e3          	bne	s1,s4,117c <validatetest+0x28>
}
    1192:	70e2                	ld	ra,56(sp)
    1194:	7442                	ld	s0,48(sp)
    1196:	74a2                	ld	s1,40(sp)
    1198:	7902                	ld	s2,32(sp)
    119a:	69e2                	ld	s3,24(sp)
    119c:	6a42                	ld	s4,16(sp)
    119e:	6aa2                	ld	s5,8(sp)
    11a0:	6b02                	ld	s6,0(sp)
    11a2:	6121                	addi	sp,sp,64
    11a4:	8082                	ret
      printf("%s: link should not succeed\n", s);
    11a6:	85da                	mv	a1,s6
    11a8:	00005517          	auipc	a0,0x5
    11ac:	73050513          	addi	a0,a0,1840 # 68d8 <malloc+0x86a>
    11b0:	00005097          	auipc	ra,0x5
    11b4:	dfe080e7          	jalr	-514(ra) # 5fae <printf>
      exit(1);
    11b8:	4505                	li	a0,1
    11ba:	00005097          	auipc	ra,0x5
    11be:	a5e080e7          	jalr	-1442(ra) # 5c18 <exit>

00000000000011c2 <bigdir>:
{
    11c2:	715d                	addi	sp,sp,-80
    11c4:	e486                	sd	ra,72(sp)
    11c6:	e0a2                	sd	s0,64(sp)
    11c8:	fc26                	sd	s1,56(sp)
    11ca:	f84a                	sd	s2,48(sp)
    11cc:	f44e                	sd	s3,40(sp)
    11ce:	f052                	sd	s4,32(sp)
    11d0:	ec56                	sd	s5,24(sp)
    11d2:	e85a                	sd	s6,16(sp)
    11d4:	0880                	addi	s0,sp,80
    11d6:	89aa                	mv	s3,a0
  unlink("bd");
    11d8:	00005517          	auipc	a0,0x5
    11dc:	72050513          	addi	a0,a0,1824 # 68f8 <malloc+0x88a>
    11e0:	00005097          	auipc	ra,0x5
    11e4:	a88080e7          	jalr	-1400(ra) # 5c68 <unlink>
  fd = open("bd", O_CREATE);
    11e8:	20000593          	li	a1,512
    11ec:	00005517          	auipc	a0,0x5
    11f0:	70c50513          	addi	a0,a0,1804 # 68f8 <malloc+0x88a>
    11f4:	00005097          	auipc	ra,0x5
    11f8:	a64080e7          	jalr	-1436(ra) # 5c58 <open>
  if(fd < 0){
    11fc:	0c054963          	bltz	a0,12ce <bigdir+0x10c>
  close(fd);
    1200:	00005097          	auipc	ra,0x5
    1204:	a40080e7          	jalr	-1472(ra) # 5c40 <close>
  for(i = 0; i < N; i++){
    1208:	4901                	li	s2,0
    name[0] = 'x';
    120a:	07800a93          	li	s5,120
    if(link("bd", name) != 0){
    120e:	00005a17          	auipc	s4,0x5
    1212:	6eaa0a13          	addi	s4,s4,1770 # 68f8 <malloc+0x88a>
  for(i = 0; i < N; i++){
    1216:	1f400b13          	li	s6,500
    name[0] = 'x';
    121a:	fb540823          	sb	s5,-80(s0)
    name[1] = '0' + (i / 64);
    121e:	41f9579b          	sraiw	a5,s2,0x1f
    1222:	01a7d71b          	srliw	a4,a5,0x1a
    1226:	012707bb          	addw	a5,a4,s2
    122a:	4067d69b          	sraiw	a3,a5,0x6
    122e:	0306869b          	addiw	a3,a3,48
    1232:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    1236:	03f7f793          	andi	a5,a5,63
    123a:	9f99                	subw	a5,a5,a4
    123c:	0307879b          	addiw	a5,a5,48
    1240:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    1244:	fa0409a3          	sb	zero,-77(s0)
    if(link("bd", name) != 0){
    1248:	fb040593          	addi	a1,s0,-80
    124c:	8552                	mv	a0,s4
    124e:	00005097          	auipc	ra,0x5
    1252:	a2a080e7          	jalr	-1494(ra) # 5c78 <link>
    1256:	84aa                	mv	s1,a0
    1258:	e949                	bnez	a0,12ea <bigdir+0x128>
  for(i = 0; i < N; i++){
    125a:	2905                	addiw	s2,s2,1
    125c:	fb691fe3          	bne	s2,s6,121a <bigdir+0x58>
  unlink("bd");
    1260:	00005517          	auipc	a0,0x5
    1264:	69850513          	addi	a0,a0,1688 # 68f8 <malloc+0x88a>
    1268:	00005097          	auipc	ra,0x5
    126c:	a00080e7          	jalr	-1536(ra) # 5c68 <unlink>
    name[0] = 'x';
    1270:	07800913          	li	s2,120
  for(i = 0; i < N; i++){
    1274:	1f400a13          	li	s4,500
    name[0] = 'x';
    1278:	fb240823          	sb	s2,-80(s0)
    name[1] = '0' + (i / 64);
    127c:	41f4d79b          	sraiw	a5,s1,0x1f
    1280:	01a7d71b          	srliw	a4,a5,0x1a
    1284:	009707bb          	addw	a5,a4,s1
    1288:	4067d69b          	sraiw	a3,a5,0x6
    128c:	0306869b          	addiw	a3,a3,48
    1290:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    1294:	03f7f793          	andi	a5,a5,63
    1298:	9f99                	subw	a5,a5,a4
    129a:	0307879b          	addiw	a5,a5,48
    129e:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    12a2:	fa0409a3          	sb	zero,-77(s0)
    if(unlink(name) != 0){
    12a6:	fb040513          	addi	a0,s0,-80
    12aa:	00005097          	auipc	ra,0x5
    12ae:	9be080e7          	jalr	-1602(ra) # 5c68 <unlink>
    12b2:	ed21                	bnez	a0,130a <bigdir+0x148>
  for(i = 0; i < N; i++){
    12b4:	2485                	addiw	s1,s1,1
    12b6:	fd4491e3          	bne	s1,s4,1278 <bigdir+0xb6>
}
    12ba:	60a6                	ld	ra,72(sp)
    12bc:	6406                	ld	s0,64(sp)
    12be:	74e2                	ld	s1,56(sp)
    12c0:	7942                	ld	s2,48(sp)
    12c2:	79a2                	ld	s3,40(sp)
    12c4:	7a02                	ld	s4,32(sp)
    12c6:	6ae2                	ld	s5,24(sp)
    12c8:	6b42                	ld	s6,16(sp)
    12ca:	6161                	addi	sp,sp,80
    12cc:	8082                	ret
    printf("%s: bigdir create failed\n", s);
    12ce:	85ce                	mv	a1,s3
    12d0:	00005517          	auipc	a0,0x5
    12d4:	63050513          	addi	a0,a0,1584 # 6900 <malloc+0x892>
    12d8:	00005097          	auipc	ra,0x5
    12dc:	cd6080e7          	jalr	-810(ra) # 5fae <printf>
    exit(1);
    12e0:	4505                	li	a0,1
    12e2:	00005097          	auipc	ra,0x5
    12e6:	936080e7          	jalr	-1738(ra) # 5c18 <exit>
      printf("%s: bigdir link(bd, %s) failed\n", s, name);
    12ea:	fb040613          	addi	a2,s0,-80
    12ee:	85ce                	mv	a1,s3
    12f0:	00005517          	auipc	a0,0x5
    12f4:	63050513          	addi	a0,a0,1584 # 6920 <malloc+0x8b2>
    12f8:	00005097          	auipc	ra,0x5
    12fc:	cb6080e7          	jalr	-842(ra) # 5fae <printf>
      exit(1);
    1300:	4505                	li	a0,1
    1302:	00005097          	auipc	ra,0x5
    1306:	916080e7          	jalr	-1770(ra) # 5c18 <exit>
      printf("%s: bigdir unlink failed", s);
    130a:	85ce                	mv	a1,s3
    130c:	00005517          	auipc	a0,0x5
    1310:	63450513          	addi	a0,a0,1588 # 6940 <malloc+0x8d2>
    1314:	00005097          	auipc	ra,0x5
    1318:	c9a080e7          	jalr	-870(ra) # 5fae <printf>
      exit(1);
    131c:	4505                	li	a0,1
    131e:	00005097          	auipc	ra,0x5
    1322:	8fa080e7          	jalr	-1798(ra) # 5c18 <exit>

0000000000001326 <pgbug>:
{
    1326:	7179                	addi	sp,sp,-48
    1328:	f406                	sd	ra,40(sp)
    132a:	f022                	sd	s0,32(sp)
    132c:	ec26                	sd	s1,24(sp)
    132e:	1800                	addi	s0,sp,48
  argv[0] = 0;
    1330:	fc043c23          	sd	zero,-40(s0)
  exec(big, argv);
    1334:	00008497          	auipc	s1,0x8
    1338:	ccc48493          	addi	s1,s1,-820 # 9000 <big>
    133c:	fd840593          	addi	a1,s0,-40
    1340:	6088                	ld	a0,0(s1)
    1342:	00005097          	auipc	ra,0x5
    1346:	90e080e7          	jalr	-1778(ra) # 5c50 <exec>
  pipe(big);
    134a:	6088                	ld	a0,0(s1)
    134c:	00005097          	auipc	ra,0x5
    1350:	8dc080e7          	jalr	-1828(ra) # 5c28 <pipe>
  exit(0);
    1354:	4501                	li	a0,0
    1356:	00005097          	auipc	ra,0x5
    135a:	8c2080e7          	jalr	-1854(ra) # 5c18 <exit>

000000000000135e <badarg>:
{
    135e:	7139                	addi	sp,sp,-64
    1360:	fc06                	sd	ra,56(sp)
    1362:	f822                	sd	s0,48(sp)
    1364:	f426                	sd	s1,40(sp)
    1366:	f04a                	sd	s2,32(sp)
    1368:	ec4e                	sd	s3,24(sp)
    136a:	0080                	addi	s0,sp,64
    136c:	64b1                	lui	s1,0xc
    136e:	35048493          	addi	s1,s1,848 # c350 <uninit+0x1de8>
    argv[0] = (char*)0xffffffff;
    1372:	597d                	li	s2,-1
    1374:	02095913          	srli	s2,s2,0x20
    exec("echo", argv);
    1378:	00005997          	auipc	s3,0x5
    137c:	e4098993          	addi	s3,s3,-448 # 61b8 <malloc+0x14a>
    argv[0] = (char*)0xffffffff;
    1380:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    1384:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    1388:	fc040593          	addi	a1,s0,-64
    138c:	854e                	mv	a0,s3
    138e:	00005097          	auipc	ra,0x5
    1392:	8c2080e7          	jalr	-1854(ra) # 5c50 <exec>
    1396:	34fd                	addiw	s1,s1,-1
  for(int i = 0; i < 50000; i++){
    1398:	f4e5                	bnez	s1,1380 <badarg+0x22>
  exit(0);
    139a:	4501                	li	a0,0
    139c:	00005097          	auipc	ra,0x5
    13a0:	87c080e7          	jalr	-1924(ra) # 5c18 <exit>

00000000000013a4 <copyinstr2>:
{
    13a4:	7155                	addi	sp,sp,-208
    13a6:	e586                	sd	ra,200(sp)
    13a8:	e1a2                	sd	s0,192(sp)
    13aa:	0980                	addi	s0,sp,208
  for(int i = 0; i < MAXPATH; i++)
    13ac:	f6840793          	addi	a5,s0,-152
    13b0:	fe840693          	addi	a3,s0,-24
    b[i] = 'x';
    13b4:	07800713          	li	a4,120
    13b8:	00e78023          	sb	a4,0(a5)
    13bc:	0785                	addi	a5,a5,1
  for(int i = 0; i < MAXPATH; i++)
    13be:	fed79de3          	bne	a5,a3,13b8 <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    13c2:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    13c6:	f6840513          	addi	a0,s0,-152
    13ca:	00005097          	auipc	ra,0x5
    13ce:	89e080e7          	jalr	-1890(ra) # 5c68 <unlink>
  if(ret != -1){
    13d2:	57fd                	li	a5,-1
    13d4:	0ef51063          	bne	a0,a5,14b4 <copyinstr2+0x110>
  int fd = open(b, O_CREATE | O_WRONLY);
    13d8:	20100593          	li	a1,513
    13dc:	f6840513          	addi	a0,s0,-152
    13e0:	00005097          	auipc	ra,0x5
    13e4:	878080e7          	jalr	-1928(ra) # 5c58 <open>
  if(fd != -1){
    13e8:	57fd                	li	a5,-1
    13ea:	0ef51563          	bne	a0,a5,14d4 <copyinstr2+0x130>
  ret = link(b, b);
    13ee:	f6840593          	addi	a1,s0,-152
    13f2:	852e                	mv	a0,a1
    13f4:	00005097          	auipc	ra,0x5
    13f8:	884080e7          	jalr	-1916(ra) # 5c78 <link>
  if(ret != -1){
    13fc:	57fd                	li	a5,-1
    13fe:	0ef51b63          	bne	a0,a5,14f4 <copyinstr2+0x150>
  char *args[] = { "xx", 0 };
    1402:	00006797          	auipc	a5,0x6
    1406:	79678793          	addi	a5,a5,1942 # 7b98 <malloc+0x1b2a>
    140a:	f4f43c23          	sd	a5,-168(s0)
    140e:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    1412:	f5840593          	addi	a1,s0,-168
    1416:	f6840513          	addi	a0,s0,-152
    141a:	00005097          	auipc	ra,0x5
    141e:	836080e7          	jalr	-1994(ra) # 5c50 <exec>
  if(ret != -1){
    1422:	57fd                	li	a5,-1
    1424:	0ef51963          	bne	a0,a5,1516 <copyinstr2+0x172>
  int pid = fork();
    1428:	00004097          	auipc	ra,0x4
    142c:	7e8080e7          	jalr	2024(ra) # 5c10 <fork>
  if(pid < 0){
    1430:	10054363          	bltz	a0,1536 <copyinstr2+0x192>
  if(pid == 0){
    1434:	12051463          	bnez	a0,155c <copyinstr2+0x1b8>
    1438:	00008797          	auipc	a5,0x8
    143c:	12878793          	addi	a5,a5,296 # 9560 <big.1302>
    1440:	00009697          	auipc	a3,0x9
    1444:	12068693          	addi	a3,a3,288 # a560 <big.1302+0x1000>
      big[i] = 'x';
    1448:	07800713          	li	a4,120
    144c:	00e78023          	sb	a4,0(a5)
    1450:	0785                	addi	a5,a5,1
    for(int i = 0; i < PGSIZE; i++)
    1452:	fed79de3          	bne	a5,a3,144c <copyinstr2+0xa8>
    big[PGSIZE] = '\0';
    1456:	00009797          	auipc	a5,0x9
    145a:	10078523          	sb	zero,266(a5) # a560 <big.1302+0x1000>
    char *args2[] = { big, big, big, 0 };
    145e:	00005797          	auipc	a5,0x5
    1462:	d0278793          	addi	a5,a5,-766 # 6160 <malloc+0xf2>
    1466:	6390                	ld	a2,0(a5)
    1468:	6794                	ld	a3,8(a5)
    146a:	6b98                	ld	a4,16(a5)
    146c:	6f9c                	ld	a5,24(a5)
    146e:	f2c43823          	sd	a2,-208(s0)
    1472:	f2d43c23          	sd	a3,-200(s0)
    1476:	f4e43023          	sd	a4,-192(s0)
    147a:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    147e:	f3040593          	addi	a1,s0,-208
    1482:	00005517          	auipc	a0,0x5
    1486:	d3650513          	addi	a0,a0,-714 # 61b8 <malloc+0x14a>
    148a:	00004097          	auipc	ra,0x4
    148e:	7c6080e7          	jalr	1990(ra) # 5c50 <exec>
    if(ret != -1){
    1492:	57fd                	li	a5,-1
    1494:	0af50e63          	beq	a0,a5,1550 <copyinstr2+0x1ac>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    1498:	55fd                	li	a1,-1
    149a:	00005517          	auipc	a0,0x5
    149e:	54e50513          	addi	a0,a0,1358 # 69e8 <malloc+0x97a>
    14a2:	00005097          	auipc	ra,0x5
    14a6:	b0c080e7          	jalr	-1268(ra) # 5fae <printf>
      exit(1);
    14aa:	4505                	li	a0,1
    14ac:	00004097          	auipc	ra,0x4
    14b0:	76c080e7          	jalr	1900(ra) # 5c18 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    14b4:	862a                	mv	a2,a0
    14b6:	f6840593          	addi	a1,s0,-152
    14ba:	00005517          	auipc	a0,0x5
    14be:	4a650513          	addi	a0,a0,1190 # 6960 <malloc+0x8f2>
    14c2:	00005097          	auipc	ra,0x5
    14c6:	aec080e7          	jalr	-1300(ra) # 5fae <printf>
    exit(1);
    14ca:	4505                	li	a0,1
    14cc:	00004097          	auipc	ra,0x4
    14d0:	74c080e7          	jalr	1868(ra) # 5c18 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    14d4:	862a                	mv	a2,a0
    14d6:	f6840593          	addi	a1,s0,-152
    14da:	00005517          	auipc	a0,0x5
    14de:	4a650513          	addi	a0,a0,1190 # 6980 <malloc+0x912>
    14e2:	00005097          	auipc	ra,0x5
    14e6:	acc080e7          	jalr	-1332(ra) # 5fae <printf>
    exit(1);
    14ea:	4505                	li	a0,1
    14ec:	00004097          	auipc	ra,0x4
    14f0:	72c080e7          	jalr	1836(ra) # 5c18 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    14f4:	86aa                	mv	a3,a0
    14f6:	f6840613          	addi	a2,s0,-152
    14fa:	85b2                	mv	a1,a2
    14fc:	00005517          	auipc	a0,0x5
    1500:	4a450513          	addi	a0,a0,1188 # 69a0 <malloc+0x932>
    1504:	00005097          	auipc	ra,0x5
    1508:	aaa080e7          	jalr	-1366(ra) # 5fae <printf>
    exit(1);
    150c:	4505                	li	a0,1
    150e:	00004097          	auipc	ra,0x4
    1512:	70a080e7          	jalr	1802(ra) # 5c18 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    1516:	567d                	li	a2,-1
    1518:	f6840593          	addi	a1,s0,-152
    151c:	00005517          	auipc	a0,0x5
    1520:	4ac50513          	addi	a0,a0,1196 # 69c8 <malloc+0x95a>
    1524:	00005097          	auipc	ra,0x5
    1528:	a8a080e7          	jalr	-1398(ra) # 5fae <printf>
    exit(1);
    152c:	4505                	li	a0,1
    152e:	00004097          	auipc	ra,0x4
    1532:	6ea080e7          	jalr	1770(ra) # 5c18 <exit>
    printf("fork failed\n");
    1536:	00006517          	auipc	a0,0x6
    153a:	91250513          	addi	a0,a0,-1774 # 6e48 <malloc+0xdda>
    153e:	00005097          	auipc	ra,0x5
    1542:	a70080e7          	jalr	-1424(ra) # 5fae <printf>
    exit(1);
    1546:	4505                	li	a0,1
    1548:	00004097          	auipc	ra,0x4
    154c:	6d0080e7          	jalr	1744(ra) # 5c18 <exit>
    exit(747); // OK
    1550:	2eb00513          	li	a0,747
    1554:	00004097          	auipc	ra,0x4
    1558:	6c4080e7          	jalr	1732(ra) # 5c18 <exit>
  int st = 0;
    155c:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    1560:	f5440513          	addi	a0,s0,-172
    1564:	00004097          	auipc	ra,0x4
    1568:	6bc080e7          	jalr	1724(ra) # 5c20 <wait>
  if(st != 747){
    156c:	f5442703          	lw	a4,-172(s0)
    1570:	2eb00793          	li	a5,747
    1574:	00f71663          	bne	a4,a5,1580 <copyinstr2+0x1dc>
}
    1578:	60ae                	ld	ra,200(sp)
    157a:	640e                	ld	s0,192(sp)
    157c:	6169                	addi	sp,sp,208
    157e:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    1580:	00005517          	auipc	a0,0x5
    1584:	49050513          	addi	a0,a0,1168 # 6a10 <malloc+0x9a2>
    1588:	00005097          	auipc	ra,0x5
    158c:	a26080e7          	jalr	-1498(ra) # 5fae <printf>
    exit(1);
    1590:	4505                	li	a0,1
    1592:	00004097          	auipc	ra,0x4
    1596:	686080e7          	jalr	1670(ra) # 5c18 <exit>

000000000000159a <truncate3>:
{
    159a:	7159                	addi	sp,sp,-112
    159c:	f486                	sd	ra,104(sp)
    159e:	f0a2                	sd	s0,96(sp)
    15a0:	eca6                	sd	s1,88(sp)
    15a2:	e8ca                	sd	s2,80(sp)
    15a4:	e4ce                	sd	s3,72(sp)
    15a6:	e0d2                	sd	s4,64(sp)
    15a8:	fc56                	sd	s5,56(sp)
    15aa:	1880                	addi	s0,sp,112
    15ac:	8a2a                	mv	s4,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    15ae:	60100593          	li	a1,1537
    15b2:	00005517          	auipc	a0,0x5
    15b6:	c5e50513          	addi	a0,a0,-930 # 6210 <malloc+0x1a2>
    15ba:	00004097          	auipc	ra,0x4
    15be:	69e080e7          	jalr	1694(ra) # 5c58 <open>
    15c2:	00004097          	auipc	ra,0x4
    15c6:	67e080e7          	jalr	1662(ra) # 5c40 <close>
  pid = fork();
    15ca:	00004097          	auipc	ra,0x4
    15ce:	646080e7          	jalr	1606(ra) # 5c10 <fork>
  if(pid < 0){
    15d2:	08054063          	bltz	a0,1652 <truncate3+0xb8>
  if(pid == 0){
    15d6:	e969                	bnez	a0,16a8 <truncate3+0x10e>
    15d8:	06400913          	li	s2,100
      int fd = open("truncfile", O_WRONLY);
    15dc:	00005997          	auipc	s3,0x5
    15e0:	c3498993          	addi	s3,s3,-972 # 6210 <malloc+0x1a2>
      int n = write(fd, "1234567890", 10);
    15e4:	00005a97          	auipc	s5,0x5
    15e8:	48ca8a93          	addi	s5,s5,1164 # 6a70 <malloc+0xa02>
      int fd = open("truncfile", O_WRONLY);
    15ec:	4585                	li	a1,1
    15ee:	854e                	mv	a0,s3
    15f0:	00004097          	auipc	ra,0x4
    15f4:	668080e7          	jalr	1640(ra) # 5c58 <open>
    15f8:	84aa                	mv	s1,a0
      if(fd < 0){
    15fa:	06054a63          	bltz	a0,166e <truncate3+0xd4>
      int n = write(fd, "1234567890", 10);
    15fe:	4629                	li	a2,10
    1600:	85d6                	mv	a1,s5
    1602:	00004097          	auipc	ra,0x4
    1606:	636080e7          	jalr	1590(ra) # 5c38 <write>
      if(n != 10){
    160a:	47a9                	li	a5,10
    160c:	06f51f63          	bne	a0,a5,168a <truncate3+0xf0>
      close(fd);
    1610:	8526                	mv	a0,s1
    1612:	00004097          	auipc	ra,0x4
    1616:	62e080e7          	jalr	1582(ra) # 5c40 <close>
      fd = open("truncfile", O_RDONLY);
    161a:	4581                	li	a1,0
    161c:	854e                	mv	a0,s3
    161e:	00004097          	auipc	ra,0x4
    1622:	63a080e7          	jalr	1594(ra) # 5c58 <open>
    1626:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    1628:	02000613          	li	a2,32
    162c:	f9840593          	addi	a1,s0,-104
    1630:	00004097          	auipc	ra,0x4
    1634:	600080e7          	jalr	1536(ra) # 5c30 <read>
      close(fd);
    1638:	8526                	mv	a0,s1
    163a:	00004097          	auipc	ra,0x4
    163e:	606080e7          	jalr	1542(ra) # 5c40 <close>
    1642:	397d                	addiw	s2,s2,-1
    for(int i = 0; i < 100; i++){
    1644:	fa0914e3          	bnez	s2,15ec <truncate3+0x52>
    exit(0);
    1648:	4501                	li	a0,0
    164a:	00004097          	auipc	ra,0x4
    164e:	5ce080e7          	jalr	1486(ra) # 5c18 <exit>
    printf("%s: fork failed\n", s);
    1652:	85d2                	mv	a1,s4
    1654:	00005517          	auipc	a0,0x5
    1658:	3ec50513          	addi	a0,a0,1004 # 6a40 <malloc+0x9d2>
    165c:	00005097          	auipc	ra,0x5
    1660:	952080e7          	jalr	-1710(ra) # 5fae <printf>
    exit(1);
    1664:	4505                	li	a0,1
    1666:	00004097          	auipc	ra,0x4
    166a:	5b2080e7          	jalr	1458(ra) # 5c18 <exit>
        printf("%s: open failed\n", s);
    166e:	85d2                	mv	a1,s4
    1670:	00005517          	auipc	a0,0x5
    1674:	3e850513          	addi	a0,a0,1000 # 6a58 <malloc+0x9ea>
    1678:	00005097          	auipc	ra,0x5
    167c:	936080e7          	jalr	-1738(ra) # 5fae <printf>
        exit(1);
    1680:	4505                	li	a0,1
    1682:	00004097          	auipc	ra,0x4
    1686:	596080e7          	jalr	1430(ra) # 5c18 <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    168a:	862a                	mv	a2,a0
    168c:	85d2                	mv	a1,s4
    168e:	00005517          	auipc	a0,0x5
    1692:	3f250513          	addi	a0,a0,1010 # 6a80 <malloc+0xa12>
    1696:	00005097          	auipc	ra,0x5
    169a:	918080e7          	jalr	-1768(ra) # 5fae <printf>
        exit(1);
    169e:	4505                	li	a0,1
    16a0:	00004097          	auipc	ra,0x4
    16a4:	578080e7          	jalr	1400(ra) # 5c18 <exit>
    16a8:	09600913          	li	s2,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    16ac:	00005997          	auipc	s3,0x5
    16b0:	b6498993          	addi	s3,s3,-1180 # 6210 <malloc+0x1a2>
    int n = write(fd, "xxx", 3);
    16b4:	00005a97          	auipc	s5,0x5
    16b8:	3eca8a93          	addi	s5,s5,1004 # 6aa0 <malloc+0xa32>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    16bc:	60100593          	li	a1,1537
    16c0:	854e                	mv	a0,s3
    16c2:	00004097          	auipc	ra,0x4
    16c6:	596080e7          	jalr	1430(ra) # 5c58 <open>
    16ca:	84aa                	mv	s1,a0
    if(fd < 0){
    16cc:	04054763          	bltz	a0,171a <truncate3+0x180>
    int n = write(fd, "xxx", 3);
    16d0:	460d                	li	a2,3
    16d2:	85d6                	mv	a1,s5
    16d4:	00004097          	auipc	ra,0x4
    16d8:	564080e7          	jalr	1380(ra) # 5c38 <write>
    if(n != 3){
    16dc:	478d                	li	a5,3
    16de:	04f51c63          	bne	a0,a5,1736 <truncate3+0x19c>
    close(fd);
    16e2:	8526                	mv	a0,s1
    16e4:	00004097          	auipc	ra,0x4
    16e8:	55c080e7          	jalr	1372(ra) # 5c40 <close>
    16ec:	397d                	addiw	s2,s2,-1
  for(int i = 0; i < 150; i++){
    16ee:	fc0917e3          	bnez	s2,16bc <truncate3+0x122>
  wait(&xstatus);
    16f2:	fbc40513          	addi	a0,s0,-68
    16f6:	00004097          	auipc	ra,0x4
    16fa:	52a080e7          	jalr	1322(ra) # 5c20 <wait>
  unlink("truncfile");
    16fe:	00005517          	auipc	a0,0x5
    1702:	b1250513          	addi	a0,a0,-1262 # 6210 <malloc+0x1a2>
    1706:	00004097          	auipc	ra,0x4
    170a:	562080e7          	jalr	1378(ra) # 5c68 <unlink>
  exit(xstatus);
    170e:	fbc42503          	lw	a0,-68(s0)
    1712:	00004097          	auipc	ra,0x4
    1716:	506080e7          	jalr	1286(ra) # 5c18 <exit>
      printf("%s: open failed\n", s);
    171a:	85d2                	mv	a1,s4
    171c:	00005517          	auipc	a0,0x5
    1720:	33c50513          	addi	a0,a0,828 # 6a58 <malloc+0x9ea>
    1724:	00005097          	auipc	ra,0x5
    1728:	88a080e7          	jalr	-1910(ra) # 5fae <printf>
      exit(1);
    172c:	4505                	li	a0,1
    172e:	00004097          	auipc	ra,0x4
    1732:	4ea080e7          	jalr	1258(ra) # 5c18 <exit>
      printf("%s: write got %d, expected 3\n", s, n);
    1736:	862a                	mv	a2,a0
    1738:	85d2                	mv	a1,s4
    173a:	00005517          	auipc	a0,0x5
    173e:	36e50513          	addi	a0,a0,878 # 6aa8 <malloc+0xa3a>
    1742:	00005097          	auipc	ra,0x5
    1746:	86c080e7          	jalr	-1940(ra) # 5fae <printf>
      exit(1);
    174a:	4505                	li	a0,1
    174c:	00004097          	auipc	ra,0x4
    1750:	4cc080e7          	jalr	1228(ra) # 5c18 <exit>

0000000000001754 <exectest>:
{
    1754:	715d                	addi	sp,sp,-80
    1756:	e486                	sd	ra,72(sp)
    1758:	e0a2                	sd	s0,64(sp)
    175a:	fc26                	sd	s1,56(sp)
    175c:	f84a                	sd	s2,48(sp)
    175e:	0880                	addi	s0,sp,80
    1760:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    1762:	00005797          	auipc	a5,0x5
    1766:	a5678793          	addi	a5,a5,-1450 # 61b8 <malloc+0x14a>
    176a:	fcf43023          	sd	a5,-64(s0)
    176e:	00005797          	auipc	a5,0x5
    1772:	35a78793          	addi	a5,a5,858 # 6ac8 <malloc+0xa5a>
    1776:	fcf43423          	sd	a5,-56(s0)
    177a:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    177e:	00005517          	auipc	a0,0x5
    1782:	35250513          	addi	a0,a0,850 # 6ad0 <malloc+0xa62>
    1786:	00004097          	auipc	ra,0x4
    178a:	4e2080e7          	jalr	1250(ra) # 5c68 <unlink>
  pid = fork();
    178e:	00004097          	auipc	ra,0x4
    1792:	482080e7          	jalr	1154(ra) # 5c10 <fork>
  if(pid < 0) {
    1796:	04054663          	bltz	a0,17e2 <exectest+0x8e>
    179a:	84aa                	mv	s1,a0
  if(pid == 0) {
    179c:	e959                	bnez	a0,1832 <exectest+0xde>
    close(1);
    179e:	4505                	li	a0,1
    17a0:	00004097          	auipc	ra,0x4
    17a4:	4a0080e7          	jalr	1184(ra) # 5c40 <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    17a8:	20100593          	li	a1,513
    17ac:	00005517          	auipc	a0,0x5
    17b0:	32450513          	addi	a0,a0,804 # 6ad0 <malloc+0xa62>
    17b4:	00004097          	auipc	ra,0x4
    17b8:	4a4080e7          	jalr	1188(ra) # 5c58 <open>
    if(fd < 0) {
    17bc:	04054163          	bltz	a0,17fe <exectest+0xaa>
    if(fd != 1) {
    17c0:	4785                	li	a5,1
    17c2:	04f50c63          	beq	a0,a5,181a <exectest+0xc6>
      printf("%s: wrong fd\n", s);
    17c6:	85ca                	mv	a1,s2
    17c8:	00005517          	auipc	a0,0x5
    17cc:	32850513          	addi	a0,a0,808 # 6af0 <malloc+0xa82>
    17d0:	00004097          	auipc	ra,0x4
    17d4:	7de080e7          	jalr	2014(ra) # 5fae <printf>
      exit(1);
    17d8:	4505                	li	a0,1
    17da:	00004097          	auipc	ra,0x4
    17de:	43e080e7          	jalr	1086(ra) # 5c18 <exit>
     printf("%s: fork failed\n", s);
    17e2:	85ca                	mv	a1,s2
    17e4:	00005517          	auipc	a0,0x5
    17e8:	25c50513          	addi	a0,a0,604 # 6a40 <malloc+0x9d2>
    17ec:	00004097          	auipc	ra,0x4
    17f0:	7c2080e7          	jalr	1986(ra) # 5fae <printf>
     exit(1);
    17f4:	4505                	li	a0,1
    17f6:	00004097          	auipc	ra,0x4
    17fa:	422080e7          	jalr	1058(ra) # 5c18 <exit>
      printf("%s: create failed\n", s);
    17fe:	85ca                	mv	a1,s2
    1800:	00005517          	auipc	a0,0x5
    1804:	2d850513          	addi	a0,a0,728 # 6ad8 <malloc+0xa6a>
    1808:	00004097          	auipc	ra,0x4
    180c:	7a6080e7          	jalr	1958(ra) # 5fae <printf>
      exit(1);
    1810:	4505                	li	a0,1
    1812:	00004097          	auipc	ra,0x4
    1816:	406080e7          	jalr	1030(ra) # 5c18 <exit>
    if(exec("echo", echoargv) < 0){
    181a:	fc040593          	addi	a1,s0,-64
    181e:	00005517          	auipc	a0,0x5
    1822:	99a50513          	addi	a0,a0,-1638 # 61b8 <malloc+0x14a>
    1826:	00004097          	auipc	ra,0x4
    182a:	42a080e7          	jalr	1066(ra) # 5c50 <exec>
    182e:	02054163          	bltz	a0,1850 <exectest+0xfc>
  if (wait(&xstatus) != pid) {
    1832:	fdc40513          	addi	a0,s0,-36
    1836:	00004097          	auipc	ra,0x4
    183a:	3ea080e7          	jalr	1002(ra) # 5c20 <wait>
    183e:	02951763          	bne	a0,s1,186c <exectest+0x118>
  if(xstatus != 0)
    1842:	fdc42503          	lw	a0,-36(s0)
    1846:	cd0d                	beqz	a0,1880 <exectest+0x12c>
    exit(xstatus);
    1848:	00004097          	auipc	ra,0x4
    184c:	3d0080e7          	jalr	976(ra) # 5c18 <exit>
      printf("%s: exec echo failed\n", s);
    1850:	85ca                	mv	a1,s2
    1852:	00005517          	auipc	a0,0x5
    1856:	2ae50513          	addi	a0,a0,686 # 6b00 <malloc+0xa92>
    185a:	00004097          	auipc	ra,0x4
    185e:	754080e7          	jalr	1876(ra) # 5fae <printf>
      exit(1);
    1862:	4505                	li	a0,1
    1864:	00004097          	auipc	ra,0x4
    1868:	3b4080e7          	jalr	948(ra) # 5c18 <exit>
    printf("%s: wait failed!\n", s);
    186c:	85ca                	mv	a1,s2
    186e:	00005517          	auipc	a0,0x5
    1872:	2aa50513          	addi	a0,a0,682 # 6b18 <malloc+0xaaa>
    1876:	00004097          	auipc	ra,0x4
    187a:	738080e7          	jalr	1848(ra) # 5fae <printf>
    187e:	b7d1                	j	1842 <exectest+0xee>
  fd = open("echo-ok", O_RDONLY);
    1880:	4581                	li	a1,0
    1882:	00005517          	auipc	a0,0x5
    1886:	24e50513          	addi	a0,a0,590 # 6ad0 <malloc+0xa62>
    188a:	00004097          	auipc	ra,0x4
    188e:	3ce080e7          	jalr	974(ra) # 5c58 <open>
  if(fd < 0) {
    1892:	02054a63          	bltz	a0,18c6 <exectest+0x172>
  if (read(fd, buf, 2) != 2) {
    1896:	4609                	li	a2,2
    1898:	fb840593          	addi	a1,s0,-72
    189c:	00004097          	auipc	ra,0x4
    18a0:	394080e7          	jalr	916(ra) # 5c30 <read>
    18a4:	4789                	li	a5,2
    18a6:	02f50e63          	beq	a0,a5,18e2 <exectest+0x18e>
    printf("%s: read failed\n", s);
    18aa:	85ca                	mv	a1,s2
    18ac:	00005517          	auipc	a0,0x5
    18b0:	cdc50513          	addi	a0,a0,-804 # 6588 <malloc+0x51a>
    18b4:	00004097          	auipc	ra,0x4
    18b8:	6fa080e7          	jalr	1786(ra) # 5fae <printf>
    exit(1);
    18bc:	4505                	li	a0,1
    18be:	00004097          	auipc	ra,0x4
    18c2:	35a080e7          	jalr	858(ra) # 5c18 <exit>
    printf("%s: open failed\n", s);
    18c6:	85ca                	mv	a1,s2
    18c8:	00005517          	auipc	a0,0x5
    18cc:	19050513          	addi	a0,a0,400 # 6a58 <malloc+0x9ea>
    18d0:	00004097          	auipc	ra,0x4
    18d4:	6de080e7          	jalr	1758(ra) # 5fae <printf>
    exit(1);
    18d8:	4505                	li	a0,1
    18da:	00004097          	auipc	ra,0x4
    18de:	33e080e7          	jalr	830(ra) # 5c18 <exit>
  unlink("echo-ok");
    18e2:	00005517          	auipc	a0,0x5
    18e6:	1ee50513          	addi	a0,a0,494 # 6ad0 <malloc+0xa62>
    18ea:	00004097          	auipc	ra,0x4
    18ee:	37e080e7          	jalr	894(ra) # 5c68 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    18f2:	fb844703          	lbu	a4,-72(s0)
    18f6:	04f00793          	li	a5,79
    18fa:	00f71863          	bne	a4,a5,190a <exectest+0x1b6>
    18fe:	fb944703          	lbu	a4,-71(s0)
    1902:	04b00793          	li	a5,75
    1906:	02f70063          	beq	a4,a5,1926 <exectest+0x1d2>
    printf("%s: wrong output\n", s);
    190a:	85ca                	mv	a1,s2
    190c:	00005517          	auipc	a0,0x5
    1910:	22450513          	addi	a0,a0,548 # 6b30 <malloc+0xac2>
    1914:	00004097          	auipc	ra,0x4
    1918:	69a080e7          	jalr	1690(ra) # 5fae <printf>
    exit(1);
    191c:	4505                	li	a0,1
    191e:	00004097          	auipc	ra,0x4
    1922:	2fa080e7          	jalr	762(ra) # 5c18 <exit>
    exit(0);
    1926:	4501                	li	a0,0
    1928:	00004097          	auipc	ra,0x4
    192c:	2f0080e7          	jalr	752(ra) # 5c18 <exit>

0000000000001930 <pipe1>:
{
    1930:	715d                	addi	sp,sp,-80
    1932:	e486                	sd	ra,72(sp)
    1934:	e0a2                	sd	s0,64(sp)
    1936:	fc26                	sd	s1,56(sp)
    1938:	f84a                	sd	s2,48(sp)
    193a:	f44e                	sd	s3,40(sp)
    193c:	f052                	sd	s4,32(sp)
    193e:	ec56                	sd	s5,24(sp)
    1940:	e85a                	sd	s6,16(sp)
    1942:	0880                	addi	s0,sp,80
    1944:	89aa                	mv	s3,a0
  if(pipe(fds) != 0){
    1946:	fb840513          	addi	a0,s0,-72
    194a:	00004097          	auipc	ra,0x4
    194e:	2de080e7          	jalr	734(ra) # 5c28 <pipe>
    1952:	e935                	bnez	a0,19c6 <pipe1+0x96>
    1954:	84aa                	mv	s1,a0
  pid = fork();
    1956:	00004097          	auipc	ra,0x4
    195a:	2ba080e7          	jalr	698(ra) # 5c10 <fork>
  if(pid == 0){
    195e:	c151                	beqz	a0,19e2 <pipe1+0xb2>
  } else if(pid > 0){
    1960:	18a05963          	blez	a0,1af2 <pipe1+0x1c2>
    close(fds[1]);
    1964:	fbc42503          	lw	a0,-68(s0)
    1968:	00004097          	auipc	ra,0x4
    196c:	2d8080e7          	jalr	728(ra) # 5c40 <close>
    total = 0;
    1970:	8aa6                	mv	s5,s1
    cc = 1;
    1972:	4a05                	li	s4,1
    while((n = read(fds[0], buf, cc)) > 0){
    1974:	0000b917          	auipc	s2,0xb
    1978:	30490913          	addi	s2,s2,772 # cc78 <buf>
      if(cc > sizeof(buf))
    197c:	6b0d                	lui	s6,0x3
    while((n = read(fds[0], buf, cc)) > 0){
    197e:	8652                	mv	a2,s4
    1980:	85ca                	mv	a1,s2
    1982:	fb842503          	lw	a0,-72(s0)
    1986:	00004097          	auipc	ra,0x4
    198a:	2aa080e7          	jalr	682(ra) # 5c30 <read>
    198e:	10a05d63          	blez	a0,1aa8 <pipe1+0x178>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1992:	0014879b          	addiw	a5,s1,1
    1996:	00094683          	lbu	a3,0(s2)
    199a:	0ff4f713          	andi	a4,s1,255
    199e:	0ce69863          	bne	a3,a4,1a6e <pipe1+0x13e>
    19a2:	0000b717          	auipc	a4,0xb
    19a6:	2d770713          	addi	a4,a4,727 # cc79 <buf+0x1>
    19aa:	9ca9                	addw	s1,s1,a0
      for(i = 0; i < n; i++){
    19ac:	0e978463          	beq	a5,s1,1a94 <pipe1+0x164>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    19b0:	00074683          	lbu	a3,0(a4)
    19b4:	0017861b          	addiw	a2,a5,1
    19b8:	0705                	addi	a4,a4,1
    19ba:	0ff7f793          	andi	a5,a5,255
    19be:	0af69863          	bne	a3,a5,1a6e <pipe1+0x13e>
    19c2:	87b2                	mv	a5,a2
    19c4:	b7e5                	j	19ac <pipe1+0x7c>
    printf("%s: pipe() failed\n", s);
    19c6:	85ce                	mv	a1,s3
    19c8:	00005517          	auipc	a0,0x5
    19cc:	18050513          	addi	a0,a0,384 # 6b48 <malloc+0xada>
    19d0:	00004097          	auipc	ra,0x4
    19d4:	5de080e7          	jalr	1502(ra) # 5fae <printf>
    exit(1);
    19d8:	4505                	li	a0,1
    19da:	00004097          	auipc	ra,0x4
    19de:	23e080e7          	jalr	574(ra) # 5c18 <exit>
    close(fds[0]);
    19e2:	fb842503          	lw	a0,-72(s0)
    19e6:	00004097          	auipc	ra,0x4
    19ea:	25a080e7          	jalr	602(ra) # 5c40 <close>
    for(n = 0; n < N; n++){
    19ee:	0000ba97          	auipc	s5,0xb
    19f2:	28aa8a93          	addi	s5,s5,650 # cc78 <buf>
    19f6:	0ffaf793          	andi	a5,s5,255
    19fa:	40f004bb          	negw	s1,a5
    19fe:	0ff4f493          	andi	s1,s1,255
    1a02:	02d00a13          	li	s4,45
    1a06:	40fa0a3b          	subw	s4,s4,a5
    1a0a:	0ffa7a13          	andi	s4,s4,255
    1a0e:	409a8913          	addi	s2,s5,1033
      if(write(fds[1], buf, SZ) != SZ){
    1a12:	8b56                	mv	s6,s5
{
    1a14:	87d6                	mv	a5,s5
        buf[i] = seq++;
    1a16:	0097873b          	addw	a4,a5,s1
    1a1a:	00e78023          	sb	a4,0(a5)
    1a1e:	0785                	addi	a5,a5,1
      for(i = 0; i < SZ; i++)
    1a20:	fef91be3          	bne	s2,a5,1a16 <pipe1+0xe6>
      if(write(fds[1], buf, SZ) != SZ){
    1a24:	40900613          	li	a2,1033
    1a28:	85da                	mv	a1,s6
    1a2a:	fbc42503          	lw	a0,-68(s0)
    1a2e:	00004097          	auipc	ra,0x4
    1a32:	20a080e7          	jalr	522(ra) # 5c38 <write>
    1a36:	40900793          	li	a5,1033
    1a3a:	00f51c63          	bne	a0,a5,1a52 <pipe1+0x122>
    1a3e:	24a5                	addiw	s1,s1,9
    1a40:	0ff4f493          	andi	s1,s1,255
    for(n = 0; n < N; n++){
    1a44:	fd4498e3          	bne	s1,s4,1a14 <pipe1+0xe4>
    exit(0);
    1a48:	4501                	li	a0,0
    1a4a:	00004097          	auipc	ra,0x4
    1a4e:	1ce080e7          	jalr	462(ra) # 5c18 <exit>
        printf("%s: pipe1 oops 1\n", s);
    1a52:	85ce                	mv	a1,s3
    1a54:	00005517          	auipc	a0,0x5
    1a58:	10c50513          	addi	a0,a0,268 # 6b60 <malloc+0xaf2>
    1a5c:	00004097          	auipc	ra,0x4
    1a60:	552080e7          	jalr	1362(ra) # 5fae <printf>
        exit(1);
    1a64:	4505                	li	a0,1
    1a66:	00004097          	auipc	ra,0x4
    1a6a:	1b2080e7          	jalr	434(ra) # 5c18 <exit>
          printf("%s: pipe1 oops 2\n", s);
    1a6e:	85ce                	mv	a1,s3
    1a70:	00005517          	auipc	a0,0x5
    1a74:	10850513          	addi	a0,a0,264 # 6b78 <malloc+0xb0a>
    1a78:	00004097          	auipc	ra,0x4
    1a7c:	536080e7          	jalr	1334(ra) # 5fae <printf>
}
    1a80:	60a6                	ld	ra,72(sp)
    1a82:	6406                	ld	s0,64(sp)
    1a84:	74e2                	ld	s1,56(sp)
    1a86:	7942                	ld	s2,48(sp)
    1a88:	79a2                	ld	s3,40(sp)
    1a8a:	7a02                	ld	s4,32(sp)
    1a8c:	6ae2                	ld	s5,24(sp)
    1a8e:	6b42                	ld	s6,16(sp)
    1a90:	6161                	addi	sp,sp,80
    1a92:	8082                	ret
      total += n;
    1a94:	00aa8abb          	addw	s5,s5,a0
      cc = cc * 2;
    1a98:	001a179b          	slliw	a5,s4,0x1
    1a9c:	00078a1b          	sext.w	s4,a5
      if(cc > sizeof(buf))
    1aa0:	ed4b7fe3          	bgeu	s6,s4,197e <pipe1+0x4e>
        cc = sizeof(buf);
    1aa4:	8a5a                	mv	s4,s6
    1aa6:	bde1                	j	197e <pipe1+0x4e>
    if(total != N * SZ){
    1aa8:	6785                	lui	a5,0x1
    1aaa:	42d78793          	addi	a5,a5,1069 # 142d <copyinstr2+0x89>
    1aae:	02fa8063          	beq	s5,a5,1ace <pipe1+0x19e>
      printf("%s: pipe1 oops 3 total %d\n", total);
    1ab2:	85d6                	mv	a1,s5
    1ab4:	00005517          	auipc	a0,0x5
    1ab8:	0dc50513          	addi	a0,a0,220 # 6b90 <malloc+0xb22>
    1abc:	00004097          	auipc	ra,0x4
    1ac0:	4f2080e7          	jalr	1266(ra) # 5fae <printf>
      exit(1);
    1ac4:	4505                	li	a0,1
    1ac6:	00004097          	auipc	ra,0x4
    1aca:	152080e7          	jalr	338(ra) # 5c18 <exit>
    close(fds[0]);
    1ace:	fb842503          	lw	a0,-72(s0)
    1ad2:	00004097          	auipc	ra,0x4
    1ad6:	16e080e7          	jalr	366(ra) # 5c40 <close>
    wait(&xstatus);
    1ada:	fb440513          	addi	a0,s0,-76
    1ade:	00004097          	auipc	ra,0x4
    1ae2:	142080e7          	jalr	322(ra) # 5c20 <wait>
    exit(xstatus);
    1ae6:	fb442503          	lw	a0,-76(s0)
    1aea:	00004097          	auipc	ra,0x4
    1aee:	12e080e7          	jalr	302(ra) # 5c18 <exit>
    printf("%s: fork() failed\n", s);
    1af2:	85ce                	mv	a1,s3
    1af4:	00005517          	auipc	a0,0x5
    1af8:	0bc50513          	addi	a0,a0,188 # 6bb0 <malloc+0xb42>
    1afc:	00004097          	auipc	ra,0x4
    1b00:	4b2080e7          	jalr	1202(ra) # 5fae <printf>
    exit(1);
    1b04:	4505                	li	a0,1
    1b06:	00004097          	auipc	ra,0x4
    1b0a:	112080e7          	jalr	274(ra) # 5c18 <exit>

0000000000001b0e <exitwait>:
{
    1b0e:	7139                	addi	sp,sp,-64
    1b10:	fc06                	sd	ra,56(sp)
    1b12:	f822                	sd	s0,48(sp)
    1b14:	f426                	sd	s1,40(sp)
    1b16:	f04a                	sd	s2,32(sp)
    1b18:	ec4e                	sd	s3,24(sp)
    1b1a:	e852                	sd	s4,16(sp)
    1b1c:	0080                	addi	s0,sp,64
    1b1e:	8a2a                	mv	s4,a0
  for(i = 0; i < 100; i++){
    1b20:	4481                	li	s1,0
    1b22:	06400993          	li	s3,100
    pid = fork();
    1b26:	00004097          	auipc	ra,0x4
    1b2a:	0ea080e7          	jalr	234(ra) # 5c10 <fork>
    1b2e:	892a                	mv	s2,a0
    if(pid < 0){
    1b30:	02054a63          	bltz	a0,1b64 <exitwait+0x56>
    if(pid){
    1b34:	c151                	beqz	a0,1bb8 <exitwait+0xaa>
      if(wait(&xstate) != pid){
    1b36:	fcc40513          	addi	a0,s0,-52
    1b3a:	00004097          	auipc	ra,0x4
    1b3e:	0e6080e7          	jalr	230(ra) # 5c20 <wait>
    1b42:	03251f63          	bne	a0,s2,1b80 <exitwait+0x72>
      if(i != xstate) {
    1b46:	fcc42783          	lw	a5,-52(s0)
    1b4a:	04979963          	bne	a5,s1,1b9c <exitwait+0x8e>
  for(i = 0; i < 100; i++){
    1b4e:	2485                	addiw	s1,s1,1
    1b50:	fd349be3          	bne	s1,s3,1b26 <exitwait+0x18>
}
    1b54:	70e2                	ld	ra,56(sp)
    1b56:	7442                	ld	s0,48(sp)
    1b58:	74a2                	ld	s1,40(sp)
    1b5a:	7902                	ld	s2,32(sp)
    1b5c:	69e2                	ld	s3,24(sp)
    1b5e:	6a42                	ld	s4,16(sp)
    1b60:	6121                	addi	sp,sp,64
    1b62:	8082                	ret
      printf("%s: fork failed\n", s);
    1b64:	85d2                	mv	a1,s4
    1b66:	00005517          	auipc	a0,0x5
    1b6a:	eda50513          	addi	a0,a0,-294 # 6a40 <malloc+0x9d2>
    1b6e:	00004097          	auipc	ra,0x4
    1b72:	440080e7          	jalr	1088(ra) # 5fae <printf>
      exit(1);
    1b76:	4505                	li	a0,1
    1b78:	00004097          	auipc	ra,0x4
    1b7c:	0a0080e7          	jalr	160(ra) # 5c18 <exit>
        printf("%s: wait wrong pid\n", s);
    1b80:	85d2                	mv	a1,s4
    1b82:	00005517          	auipc	a0,0x5
    1b86:	04650513          	addi	a0,a0,70 # 6bc8 <malloc+0xb5a>
    1b8a:	00004097          	auipc	ra,0x4
    1b8e:	424080e7          	jalr	1060(ra) # 5fae <printf>
        exit(1);
    1b92:	4505                	li	a0,1
    1b94:	00004097          	auipc	ra,0x4
    1b98:	084080e7          	jalr	132(ra) # 5c18 <exit>
        printf("%s: wait wrong exit status\n", s);
    1b9c:	85d2                	mv	a1,s4
    1b9e:	00005517          	auipc	a0,0x5
    1ba2:	04250513          	addi	a0,a0,66 # 6be0 <malloc+0xb72>
    1ba6:	00004097          	auipc	ra,0x4
    1baa:	408080e7          	jalr	1032(ra) # 5fae <printf>
        exit(1);
    1bae:	4505                	li	a0,1
    1bb0:	00004097          	auipc	ra,0x4
    1bb4:	068080e7          	jalr	104(ra) # 5c18 <exit>
      exit(i);
    1bb8:	8526                	mv	a0,s1
    1bba:	00004097          	auipc	ra,0x4
    1bbe:	05e080e7          	jalr	94(ra) # 5c18 <exit>

0000000000001bc2 <twochildren>:
{
    1bc2:	1101                	addi	sp,sp,-32
    1bc4:	ec06                	sd	ra,24(sp)
    1bc6:	e822                	sd	s0,16(sp)
    1bc8:	e426                	sd	s1,8(sp)
    1bca:	e04a                	sd	s2,0(sp)
    1bcc:	1000                	addi	s0,sp,32
    1bce:	892a                	mv	s2,a0
    1bd0:	3e800493          	li	s1,1000
    int pid1 = fork();
    1bd4:	00004097          	auipc	ra,0x4
    1bd8:	03c080e7          	jalr	60(ra) # 5c10 <fork>
    if(pid1 < 0){
    1bdc:	02054c63          	bltz	a0,1c14 <twochildren+0x52>
    if(pid1 == 0){
    1be0:	c921                	beqz	a0,1c30 <twochildren+0x6e>
      int pid2 = fork();
    1be2:	00004097          	auipc	ra,0x4
    1be6:	02e080e7          	jalr	46(ra) # 5c10 <fork>
      if(pid2 < 0){
    1bea:	04054763          	bltz	a0,1c38 <twochildren+0x76>
      if(pid2 == 0){
    1bee:	c13d                	beqz	a0,1c54 <twochildren+0x92>
        wait(0);
    1bf0:	4501                	li	a0,0
    1bf2:	00004097          	auipc	ra,0x4
    1bf6:	02e080e7          	jalr	46(ra) # 5c20 <wait>
        wait(0);
    1bfa:	4501                	li	a0,0
    1bfc:	00004097          	auipc	ra,0x4
    1c00:	024080e7          	jalr	36(ra) # 5c20 <wait>
    1c04:	34fd                	addiw	s1,s1,-1
  for(int i = 0; i < 1000; i++){
    1c06:	f4f9                	bnez	s1,1bd4 <twochildren+0x12>
}
    1c08:	60e2                	ld	ra,24(sp)
    1c0a:	6442                	ld	s0,16(sp)
    1c0c:	64a2                	ld	s1,8(sp)
    1c0e:	6902                	ld	s2,0(sp)
    1c10:	6105                	addi	sp,sp,32
    1c12:	8082                	ret
      printf("%s: fork failed\n", s);
    1c14:	85ca                	mv	a1,s2
    1c16:	00005517          	auipc	a0,0x5
    1c1a:	e2a50513          	addi	a0,a0,-470 # 6a40 <malloc+0x9d2>
    1c1e:	00004097          	auipc	ra,0x4
    1c22:	390080e7          	jalr	912(ra) # 5fae <printf>
      exit(1);
    1c26:	4505                	li	a0,1
    1c28:	00004097          	auipc	ra,0x4
    1c2c:	ff0080e7          	jalr	-16(ra) # 5c18 <exit>
      exit(0);
    1c30:	00004097          	auipc	ra,0x4
    1c34:	fe8080e7          	jalr	-24(ra) # 5c18 <exit>
        printf("%s: fork failed\n", s);
    1c38:	85ca                	mv	a1,s2
    1c3a:	00005517          	auipc	a0,0x5
    1c3e:	e0650513          	addi	a0,a0,-506 # 6a40 <malloc+0x9d2>
    1c42:	00004097          	auipc	ra,0x4
    1c46:	36c080e7          	jalr	876(ra) # 5fae <printf>
        exit(1);
    1c4a:	4505                	li	a0,1
    1c4c:	00004097          	auipc	ra,0x4
    1c50:	fcc080e7          	jalr	-52(ra) # 5c18 <exit>
        exit(0);
    1c54:	00004097          	auipc	ra,0x4
    1c58:	fc4080e7          	jalr	-60(ra) # 5c18 <exit>

0000000000001c5c <forkfork>:
{
    1c5c:	7179                	addi	sp,sp,-48
    1c5e:	f406                	sd	ra,40(sp)
    1c60:	f022                	sd	s0,32(sp)
    1c62:	ec26                	sd	s1,24(sp)
    1c64:	1800                	addi	s0,sp,48
    1c66:	84aa                	mv	s1,a0
    int pid = fork();
    1c68:	00004097          	auipc	ra,0x4
    1c6c:	fa8080e7          	jalr	-88(ra) # 5c10 <fork>
    if(pid < 0){
    1c70:	04054163          	bltz	a0,1cb2 <forkfork+0x56>
    if(pid == 0){
    1c74:	cd29                	beqz	a0,1cce <forkfork+0x72>
    int pid = fork();
    1c76:	00004097          	auipc	ra,0x4
    1c7a:	f9a080e7          	jalr	-102(ra) # 5c10 <fork>
    if(pid < 0){
    1c7e:	02054a63          	bltz	a0,1cb2 <forkfork+0x56>
    if(pid == 0){
    1c82:	c531                	beqz	a0,1cce <forkfork+0x72>
    wait(&xstatus);
    1c84:	fdc40513          	addi	a0,s0,-36
    1c88:	00004097          	auipc	ra,0x4
    1c8c:	f98080e7          	jalr	-104(ra) # 5c20 <wait>
    if(xstatus != 0) {
    1c90:	fdc42783          	lw	a5,-36(s0)
    1c94:	ebbd                	bnez	a5,1d0a <forkfork+0xae>
    wait(&xstatus);
    1c96:	fdc40513          	addi	a0,s0,-36
    1c9a:	00004097          	auipc	ra,0x4
    1c9e:	f86080e7          	jalr	-122(ra) # 5c20 <wait>
    if(xstatus != 0) {
    1ca2:	fdc42783          	lw	a5,-36(s0)
    1ca6:	e3b5                	bnez	a5,1d0a <forkfork+0xae>
}
    1ca8:	70a2                	ld	ra,40(sp)
    1caa:	7402                	ld	s0,32(sp)
    1cac:	64e2                	ld	s1,24(sp)
    1cae:	6145                	addi	sp,sp,48
    1cb0:	8082                	ret
      printf("%s: fork failed", s);
    1cb2:	85a6                	mv	a1,s1
    1cb4:	00005517          	auipc	a0,0x5
    1cb8:	f4c50513          	addi	a0,a0,-180 # 6c00 <malloc+0xb92>
    1cbc:	00004097          	auipc	ra,0x4
    1cc0:	2f2080e7          	jalr	754(ra) # 5fae <printf>
      exit(1);
    1cc4:	4505                	li	a0,1
    1cc6:	00004097          	auipc	ra,0x4
    1cca:	f52080e7          	jalr	-174(ra) # 5c18 <exit>
{
    1cce:	0c800493          	li	s1,200
        int pid1 = fork();
    1cd2:	00004097          	auipc	ra,0x4
    1cd6:	f3e080e7          	jalr	-194(ra) # 5c10 <fork>
        if(pid1 < 0){
    1cda:	00054f63          	bltz	a0,1cf8 <forkfork+0x9c>
        if(pid1 == 0){
    1cde:	c115                	beqz	a0,1d02 <forkfork+0xa6>
        wait(0);
    1ce0:	4501                	li	a0,0
    1ce2:	00004097          	auipc	ra,0x4
    1ce6:	f3e080e7          	jalr	-194(ra) # 5c20 <wait>
    1cea:	34fd                	addiw	s1,s1,-1
      for(int j = 0; j < 200; j++){
    1cec:	f0fd                	bnez	s1,1cd2 <forkfork+0x76>
      exit(0);
    1cee:	4501                	li	a0,0
    1cf0:	00004097          	auipc	ra,0x4
    1cf4:	f28080e7          	jalr	-216(ra) # 5c18 <exit>
          exit(1);
    1cf8:	4505                	li	a0,1
    1cfa:	00004097          	auipc	ra,0x4
    1cfe:	f1e080e7          	jalr	-226(ra) # 5c18 <exit>
          exit(0);
    1d02:	00004097          	auipc	ra,0x4
    1d06:	f16080e7          	jalr	-234(ra) # 5c18 <exit>
      printf("%s: fork in child failed", s);
    1d0a:	85a6                	mv	a1,s1
    1d0c:	00005517          	auipc	a0,0x5
    1d10:	f0450513          	addi	a0,a0,-252 # 6c10 <malloc+0xba2>
    1d14:	00004097          	auipc	ra,0x4
    1d18:	29a080e7          	jalr	666(ra) # 5fae <printf>
      exit(1);
    1d1c:	4505                	li	a0,1
    1d1e:	00004097          	auipc	ra,0x4
    1d22:	efa080e7          	jalr	-262(ra) # 5c18 <exit>

0000000000001d26 <reparent2>:
{
    1d26:	1101                	addi	sp,sp,-32
    1d28:	ec06                	sd	ra,24(sp)
    1d2a:	e822                	sd	s0,16(sp)
    1d2c:	e426                	sd	s1,8(sp)
    1d2e:	1000                	addi	s0,sp,32
    1d30:	32000493          	li	s1,800
    int pid1 = fork();
    1d34:	00004097          	auipc	ra,0x4
    1d38:	edc080e7          	jalr	-292(ra) # 5c10 <fork>
    if(pid1 < 0){
    1d3c:	00054f63          	bltz	a0,1d5a <reparent2+0x34>
    if(pid1 == 0){
    1d40:	c915                	beqz	a0,1d74 <reparent2+0x4e>
    wait(0);
    1d42:	4501                	li	a0,0
    1d44:	00004097          	auipc	ra,0x4
    1d48:	edc080e7          	jalr	-292(ra) # 5c20 <wait>
    1d4c:	34fd                	addiw	s1,s1,-1
  for(int i = 0; i < 800; i++){
    1d4e:	f0fd                	bnez	s1,1d34 <reparent2+0xe>
  exit(0);
    1d50:	4501                	li	a0,0
    1d52:	00004097          	auipc	ra,0x4
    1d56:	ec6080e7          	jalr	-314(ra) # 5c18 <exit>
      printf("fork failed\n");
    1d5a:	00005517          	auipc	a0,0x5
    1d5e:	0ee50513          	addi	a0,a0,238 # 6e48 <malloc+0xdda>
    1d62:	00004097          	auipc	ra,0x4
    1d66:	24c080e7          	jalr	588(ra) # 5fae <printf>
      exit(1);
    1d6a:	4505                	li	a0,1
    1d6c:	00004097          	auipc	ra,0x4
    1d70:	eac080e7          	jalr	-340(ra) # 5c18 <exit>
      fork();
    1d74:	00004097          	auipc	ra,0x4
    1d78:	e9c080e7          	jalr	-356(ra) # 5c10 <fork>
      fork();
    1d7c:	00004097          	auipc	ra,0x4
    1d80:	e94080e7          	jalr	-364(ra) # 5c10 <fork>
      exit(0);
    1d84:	4501                	li	a0,0
    1d86:	00004097          	auipc	ra,0x4
    1d8a:	e92080e7          	jalr	-366(ra) # 5c18 <exit>

0000000000001d8e <createdelete>:
{
    1d8e:	7175                	addi	sp,sp,-144
    1d90:	e506                	sd	ra,136(sp)
    1d92:	e122                	sd	s0,128(sp)
    1d94:	fca6                	sd	s1,120(sp)
    1d96:	f8ca                	sd	s2,112(sp)
    1d98:	f4ce                	sd	s3,104(sp)
    1d9a:	f0d2                	sd	s4,96(sp)
    1d9c:	ecd6                	sd	s5,88(sp)
    1d9e:	e8da                	sd	s6,80(sp)
    1da0:	e4de                	sd	s7,72(sp)
    1da2:	e0e2                	sd	s8,64(sp)
    1da4:	fc66                	sd	s9,56(sp)
    1da6:	0900                	addi	s0,sp,144
    1da8:	8caa                	mv	s9,a0
  for(pi = 0; pi < NCHILD; pi++){
    1daa:	4901                	li	s2,0
    1dac:	4991                	li	s3,4
    pid = fork();
    1dae:	00004097          	auipc	ra,0x4
    1db2:	e62080e7          	jalr	-414(ra) # 5c10 <fork>
    1db6:	84aa                	mv	s1,a0
    if(pid < 0){
    1db8:	02054f63          	bltz	a0,1df6 <createdelete+0x68>
    if(pid == 0){
    1dbc:	c939                	beqz	a0,1e12 <createdelete+0x84>
  for(pi = 0; pi < NCHILD; pi++){
    1dbe:	2905                	addiw	s2,s2,1
    1dc0:	ff3917e3          	bne	s2,s3,1dae <createdelete+0x20>
    1dc4:	4491                	li	s1,4
    wait(&xstatus);
    1dc6:	f7c40513          	addi	a0,s0,-132
    1dca:	00004097          	auipc	ra,0x4
    1dce:	e56080e7          	jalr	-426(ra) # 5c20 <wait>
    if(xstatus != 0)
    1dd2:	f7c42903          	lw	s2,-132(s0)
    1dd6:	0e091263          	bnez	s2,1eba <createdelete+0x12c>
    1dda:	34fd                	addiw	s1,s1,-1
  for(pi = 0; pi < NCHILD; pi++){
    1ddc:	f4ed                	bnez	s1,1dc6 <createdelete+0x38>
  name[0] = name[1] = name[2] = 0;
    1dde:	f8040123          	sb	zero,-126(s0)
    1de2:	03000993          	li	s3,48
    1de6:	5a7d                	li	s4,-1
    1de8:	07000c13          	li	s8,112
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1dec:	4b21                	li	s6,8
      if((i == 0 || i >= N/2) && fd < 0){
    1dee:	4ba5                	li	s7,9
    for(pi = 0; pi < NCHILD; pi++){
    1df0:	07400a93          	li	s5,116
    1df4:	a29d                	j	1f5a <createdelete+0x1cc>
      printf("fork failed\n", s);
    1df6:	85e6                	mv	a1,s9
    1df8:	00005517          	auipc	a0,0x5
    1dfc:	05050513          	addi	a0,a0,80 # 6e48 <malloc+0xdda>
    1e00:	00004097          	auipc	ra,0x4
    1e04:	1ae080e7          	jalr	430(ra) # 5fae <printf>
      exit(1);
    1e08:	4505                	li	a0,1
    1e0a:	00004097          	auipc	ra,0x4
    1e0e:	e0e080e7          	jalr	-498(ra) # 5c18 <exit>
      name[0] = 'p' + pi;
    1e12:	0709091b          	addiw	s2,s2,112
    1e16:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
    1e1a:	f8040123          	sb	zero,-126(s0)
      for(i = 0; i < N; i++){
    1e1e:	4951                	li	s2,20
    1e20:	a015                	j	1e44 <createdelete+0xb6>
          printf("%s: create failed\n", s);
    1e22:	85e6                	mv	a1,s9
    1e24:	00005517          	auipc	a0,0x5
    1e28:	cb450513          	addi	a0,a0,-844 # 6ad8 <malloc+0xa6a>
    1e2c:	00004097          	auipc	ra,0x4
    1e30:	182080e7          	jalr	386(ra) # 5fae <printf>
          exit(1);
    1e34:	4505                	li	a0,1
    1e36:	00004097          	auipc	ra,0x4
    1e3a:	de2080e7          	jalr	-542(ra) # 5c18 <exit>
      for(i = 0; i < N; i++){
    1e3e:	2485                	addiw	s1,s1,1
    1e40:	07248863          	beq	s1,s2,1eb0 <createdelete+0x122>
        name[1] = '0' + i;
    1e44:	0304879b          	addiw	a5,s1,48
    1e48:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1e4c:	20200593          	li	a1,514
    1e50:	f8040513          	addi	a0,s0,-128
    1e54:	00004097          	auipc	ra,0x4
    1e58:	e04080e7          	jalr	-508(ra) # 5c58 <open>
        if(fd < 0){
    1e5c:	fc0543e3          	bltz	a0,1e22 <createdelete+0x94>
        close(fd);
    1e60:	00004097          	auipc	ra,0x4
    1e64:	de0080e7          	jalr	-544(ra) # 5c40 <close>
        if(i > 0 && (i % 2 ) == 0){
    1e68:	fc905be3          	blez	s1,1e3e <createdelete+0xb0>
    1e6c:	0014f793          	andi	a5,s1,1
    1e70:	f7f9                	bnez	a5,1e3e <createdelete+0xb0>
          name[1] = '0' + (i / 2);
    1e72:	01f4d79b          	srliw	a5,s1,0x1f
    1e76:	9fa5                	addw	a5,a5,s1
    1e78:	4017d79b          	sraiw	a5,a5,0x1
    1e7c:	0307879b          	addiw	a5,a5,48
    1e80:	f8f400a3          	sb	a5,-127(s0)
          if(unlink(name) < 0){
    1e84:	f8040513          	addi	a0,s0,-128
    1e88:	00004097          	auipc	ra,0x4
    1e8c:	de0080e7          	jalr	-544(ra) # 5c68 <unlink>
    1e90:	fa0557e3          	bgez	a0,1e3e <createdelete+0xb0>
            printf("%s: unlink failed\n", s);
    1e94:	85e6                	mv	a1,s9
    1e96:	00005517          	auipc	a0,0x5
    1e9a:	d9a50513          	addi	a0,a0,-614 # 6c30 <malloc+0xbc2>
    1e9e:	00004097          	auipc	ra,0x4
    1ea2:	110080e7          	jalr	272(ra) # 5fae <printf>
            exit(1);
    1ea6:	4505                	li	a0,1
    1ea8:	00004097          	auipc	ra,0x4
    1eac:	d70080e7          	jalr	-656(ra) # 5c18 <exit>
      exit(0);
    1eb0:	4501                	li	a0,0
    1eb2:	00004097          	auipc	ra,0x4
    1eb6:	d66080e7          	jalr	-666(ra) # 5c18 <exit>
      exit(1);
    1eba:	4505                	li	a0,1
    1ebc:	00004097          	auipc	ra,0x4
    1ec0:	d5c080e7          	jalr	-676(ra) # 5c18 <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    1ec4:	f8040613          	addi	a2,s0,-128
    1ec8:	85e6                	mv	a1,s9
    1eca:	00005517          	auipc	a0,0x5
    1ece:	d7e50513          	addi	a0,a0,-642 # 6c48 <malloc+0xbda>
    1ed2:	00004097          	auipc	ra,0x4
    1ed6:	0dc080e7          	jalr	220(ra) # 5fae <printf>
        exit(1);
    1eda:	4505                	li	a0,1
    1edc:	00004097          	auipc	ra,0x4
    1ee0:	d3c080e7          	jalr	-708(ra) # 5c18 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1ee4:	054b7163          	bgeu	s6,s4,1f26 <createdelete+0x198>
      if(fd >= 0)
    1ee8:	02055a63          	bgez	a0,1f1c <createdelete+0x18e>
    1eec:	2485                	addiw	s1,s1,1
    1eee:	0ff4f493          	andi	s1,s1,255
    for(pi = 0; pi < NCHILD; pi++){
    1ef2:	05548c63          	beq	s1,s5,1f4a <createdelete+0x1bc>
      name[0] = 'p' + pi;
    1ef6:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    1efa:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
    1efe:	4581                	li	a1,0
    1f00:	f8040513          	addi	a0,s0,-128
    1f04:	00004097          	auipc	ra,0x4
    1f08:	d54080e7          	jalr	-684(ra) # 5c58 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1f0c:	00090463          	beqz	s2,1f14 <createdelete+0x186>
    1f10:	fd2bdae3          	bge	s7,s2,1ee4 <createdelete+0x156>
    1f14:	fa0548e3          	bltz	a0,1ec4 <createdelete+0x136>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1f18:	014b7963          	bgeu	s6,s4,1f2a <createdelete+0x19c>
        close(fd);
    1f1c:	00004097          	auipc	ra,0x4
    1f20:	d24080e7          	jalr	-732(ra) # 5c40 <close>
    1f24:	b7e1                	j	1eec <createdelete+0x15e>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1f26:	fc0543e3          	bltz	a0,1eec <createdelete+0x15e>
        printf("%s: oops createdelete %s did exist\n", s, name);
    1f2a:	f8040613          	addi	a2,s0,-128
    1f2e:	85e6                	mv	a1,s9
    1f30:	00005517          	auipc	a0,0x5
    1f34:	d4050513          	addi	a0,a0,-704 # 6c70 <malloc+0xc02>
    1f38:	00004097          	auipc	ra,0x4
    1f3c:	076080e7          	jalr	118(ra) # 5fae <printf>
        exit(1);
    1f40:	4505                	li	a0,1
    1f42:	00004097          	auipc	ra,0x4
    1f46:	cd6080e7          	jalr	-810(ra) # 5c18 <exit>
  for(i = 0; i < N; i++){
    1f4a:	2905                	addiw	s2,s2,1
    1f4c:	2a05                	addiw	s4,s4,1
    1f4e:	2985                	addiw	s3,s3,1
    1f50:	0ff9f993          	andi	s3,s3,255
    1f54:	47d1                	li	a5,20
    1f56:	02f90a63          	beq	s2,a5,1f8a <createdelete+0x1fc>
    1f5a:	84e2                	mv	s1,s8
    1f5c:	bf69                	j	1ef6 <createdelete+0x168>
    1f5e:	2905                	addiw	s2,s2,1
    1f60:	0ff97913          	andi	s2,s2,255
    1f64:	2985                	addiw	s3,s3,1
    1f66:	0ff9f993          	andi	s3,s3,255
  for(i = 0; i < N; i++){
    1f6a:	03490863          	beq	s2,s4,1f9a <createdelete+0x20c>
  name[0] = name[1] = name[2] = 0;
    1f6e:	84d6                	mv	s1,s5
      name[0] = 'p' + i;
    1f70:	f9240023          	sb	s2,-128(s0)
      name[1] = '0' + i;
    1f74:	f93400a3          	sb	s3,-127(s0)
      unlink(name);
    1f78:	f8040513          	addi	a0,s0,-128
    1f7c:	00004097          	auipc	ra,0x4
    1f80:	cec080e7          	jalr	-788(ra) # 5c68 <unlink>
    1f84:	34fd                	addiw	s1,s1,-1
    for(pi = 0; pi < NCHILD; pi++){
    1f86:	f4ed                	bnez	s1,1f70 <createdelete+0x1e2>
    1f88:	bfd9                	j	1f5e <createdelete+0x1d0>
    1f8a:	03000993          	li	s3,48
    1f8e:	07000913          	li	s2,112
  name[0] = name[1] = name[2] = 0;
    1f92:	4a91                	li	s5,4
  for(i = 0; i < N; i++){
    1f94:	08400a13          	li	s4,132
    1f98:	bfd9                	j	1f6e <createdelete+0x1e0>
}
    1f9a:	60aa                	ld	ra,136(sp)
    1f9c:	640a                	ld	s0,128(sp)
    1f9e:	74e6                	ld	s1,120(sp)
    1fa0:	7946                	ld	s2,112(sp)
    1fa2:	79a6                	ld	s3,104(sp)
    1fa4:	7a06                	ld	s4,96(sp)
    1fa6:	6ae6                	ld	s5,88(sp)
    1fa8:	6b46                	ld	s6,80(sp)
    1faa:	6ba6                	ld	s7,72(sp)
    1fac:	6c06                	ld	s8,64(sp)
    1fae:	7ce2                	ld	s9,56(sp)
    1fb0:	6149                	addi	sp,sp,144
    1fb2:	8082                	ret

0000000000001fb4 <linkunlink>:
{
    1fb4:	711d                	addi	sp,sp,-96
    1fb6:	ec86                	sd	ra,88(sp)
    1fb8:	e8a2                	sd	s0,80(sp)
    1fba:	e4a6                	sd	s1,72(sp)
    1fbc:	e0ca                	sd	s2,64(sp)
    1fbe:	fc4e                	sd	s3,56(sp)
    1fc0:	f852                	sd	s4,48(sp)
    1fc2:	f456                	sd	s5,40(sp)
    1fc4:	f05a                	sd	s6,32(sp)
    1fc6:	ec5e                	sd	s7,24(sp)
    1fc8:	e862                	sd	s8,16(sp)
    1fca:	e466                	sd	s9,8(sp)
    1fcc:	1080                	addi	s0,sp,96
    1fce:	84aa                	mv	s1,a0
  unlink("x");
    1fd0:	00004517          	auipc	a0,0x4
    1fd4:	25850513          	addi	a0,a0,600 # 6228 <malloc+0x1ba>
    1fd8:	00004097          	auipc	ra,0x4
    1fdc:	c90080e7          	jalr	-880(ra) # 5c68 <unlink>
  pid = fork();
    1fe0:	00004097          	auipc	ra,0x4
    1fe4:	c30080e7          	jalr	-976(ra) # 5c10 <fork>
  if(pid < 0){
    1fe8:	02054b63          	bltz	a0,201e <linkunlink+0x6a>
    1fec:	8c2a                	mv	s8,a0
  unsigned int x = (pid ? 1 : 97);
    1fee:	4c85                	li	s9,1
    1ff0:	e119                	bnez	a0,1ff6 <linkunlink+0x42>
    1ff2:	06100c93          	li	s9,97
    1ff6:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    1ffa:	41c659b7          	lui	s3,0x41c65
    1ffe:	e6d9899b          	addiw	s3,s3,-403
    2002:	690d                	lui	s2,0x3
    2004:	0399091b          	addiw	s2,s2,57
    if((x % 3) == 0){
    2008:	4a0d                	li	s4,3
    } else if((x % 3) == 1){
    200a:	4b05                	li	s6,1
      unlink("x");
    200c:	00004a97          	auipc	s5,0x4
    2010:	21ca8a93          	addi	s5,s5,540 # 6228 <malloc+0x1ba>
      link("cat", "x");
    2014:	00005b97          	auipc	s7,0x5
    2018:	c84b8b93          	addi	s7,s7,-892 # 6c98 <malloc+0xc2a>
    201c:	a091                	j	2060 <linkunlink+0xac>
    printf("%s: fork failed\n", s);
    201e:	85a6                	mv	a1,s1
    2020:	00005517          	auipc	a0,0x5
    2024:	a2050513          	addi	a0,a0,-1504 # 6a40 <malloc+0x9d2>
    2028:	00004097          	auipc	ra,0x4
    202c:	f86080e7          	jalr	-122(ra) # 5fae <printf>
    exit(1);
    2030:	4505                	li	a0,1
    2032:	00004097          	auipc	ra,0x4
    2036:	be6080e7          	jalr	-1050(ra) # 5c18 <exit>
      close(open("x", O_RDWR | O_CREATE));
    203a:	20200593          	li	a1,514
    203e:	8556                	mv	a0,s5
    2040:	00004097          	auipc	ra,0x4
    2044:	c18080e7          	jalr	-1000(ra) # 5c58 <open>
    2048:	00004097          	auipc	ra,0x4
    204c:	bf8080e7          	jalr	-1032(ra) # 5c40 <close>
    2050:	a031                	j	205c <linkunlink+0xa8>
      unlink("x");
    2052:	8556                	mv	a0,s5
    2054:	00004097          	auipc	ra,0x4
    2058:	c14080e7          	jalr	-1004(ra) # 5c68 <unlink>
    205c:	34fd                	addiw	s1,s1,-1
  for(i = 0; i < 100; i++){
    205e:	c09d                	beqz	s1,2084 <linkunlink+0xd0>
    x = x * 1103515245 + 12345;
    2060:	033c87bb          	mulw	a5,s9,s3
    2064:	012787bb          	addw	a5,a5,s2
    2068:	00078c9b          	sext.w	s9,a5
    if((x % 3) == 0){
    206c:	0347f7bb          	remuw	a5,a5,s4
    2070:	d7e9                	beqz	a5,203a <linkunlink+0x86>
    } else if((x % 3) == 1){
    2072:	ff6790e3          	bne	a5,s6,2052 <linkunlink+0x9e>
      link("cat", "x");
    2076:	85d6                	mv	a1,s5
    2078:	855e                	mv	a0,s7
    207a:	00004097          	auipc	ra,0x4
    207e:	bfe080e7          	jalr	-1026(ra) # 5c78 <link>
    2082:	bfe9                	j	205c <linkunlink+0xa8>
  if(pid)
    2084:	020c0463          	beqz	s8,20ac <linkunlink+0xf8>
    wait(0);
    2088:	4501                	li	a0,0
    208a:	00004097          	auipc	ra,0x4
    208e:	b96080e7          	jalr	-1130(ra) # 5c20 <wait>
}
    2092:	60e6                	ld	ra,88(sp)
    2094:	6446                	ld	s0,80(sp)
    2096:	64a6                	ld	s1,72(sp)
    2098:	6906                	ld	s2,64(sp)
    209a:	79e2                	ld	s3,56(sp)
    209c:	7a42                	ld	s4,48(sp)
    209e:	7aa2                	ld	s5,40(sp)
    20a0:	7b02                	ld	s6,32(sp)
    20a2:	6be2                	ld	s7,24(sp)
    20a4:	6c42                	ld	s8,16(sp)
    20a6:	6ca2                	ld	s9,8(sp)
    20a8:	6125                	addi	sp,sp,96
    20aa:	8082                	ret
    exit(0);
    20ac:	4501                	li	a0,0
    20ae:	00004097          	auipc	ra,0x4
    20b2:	b6a080e7          	jalr	-1174(ra) # 5c18 <exit>

00000000000020b6 <forktest>:
{
    20b6:	7179                	addi	sp,sp,-48
    20b8:	f406                	sd	ra,40(sp)
    20ba:	f022                	sd	s0,32(sp)
    20bc:	ec26                	sd	s1,24(sp)
    20be:	e84a                	sd	s2,16(sp)
    20c0:	e44e                	sd	s3,8(sp)
    20c2:	1800                	addi	s0,sp,48
    20c4:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    20c6:	4481                	li	s1,0
    20c8:	3e800913          	li	s2,1000
    pid = fork();
    20cc:	00004097          	auipc	ra,0x4
    20d0:	b44080e7          	jalr	-1212(ra) # 5c10 <fork>
    if(pid < 0)
    20d4:	02054863          	bltz	a0,2104 <forktest+0x4e>
    if(pid == 0)
    20d8:	c115                	beqz	a0,20fc <forktest+0x46>
  for(n=0; n<N; n++){
    20da:	2485                	addiw	s1,s1,1
    20dc:	ff2498e3          	bne	s1,s2,20cc <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    20e0:	85ce                	mv	a1,s3
    20e2:	00005517          	auipc	a0,0x5
    20e6:	bd650513          	addi	a0,a0,-1066 # 6cb8 <malloc+0xc4a>
    20ea:	00004097          	auipc	ra,0x4
    20ee:	ec4080e7          	jalr	-316(ra) # 5fae <printf>
    exit(1);
    20f2:	4505                	li	a0,1
    20f4:	00004097          	auipc	ra,0x4
    20f8:	b24080e7          	jalr	-1244(ra) # 5c18 <exit>
      exit(0);
    20fc:	00004097          	auipc	ra,0x4
    2100:	b1c080e7          	jalr	-1252(ra) # 5c18 <exit>
  if (n == 0) {
    2104:	cc9d                	beqz	s1,2142 <forktest+0x8c>
  if(n == N){
    2106:	3e800793          	li	a5,1000
    210a:	fcf48be3          	beq	s1,a5,20e0 <forktest+0x2a>
  for(; n > 0; n--){
    210e:	00905b63          	blez	s1,2124 <forktest+0x6e>
    if(wait(0) < 0){
    2112:	4501                	li	a0,0
    2114:	00004097          	auipc	ra,0x4
    2118:	b0c080e7          	jalr	-1268(ra) # 5c20 <wait>
    211c:	04054163          	bltz	a0,215e <forktest+0xa8>
  for(; n > 0; n--){
    2120:	34fd                	addiw	s1,s1,-1
    2122:	f8e5                	bnez	s1,2112 <forktest+0x5c>
  if(wait(0) != -1){
    2124:	4501                	li	a0,0
    2126:	00004097          	auipc	ra,0x4
    212a:	afa080e7          	jalr	-1286(ra) # 5c20 <wait>
    212e:	57fd                	li	a5,-1
    2130:	04f51563          	bne	a0,a5,217a <forktest+0xc4>
}
    2134:	70a2                	ld	ra,40(sp)
    2136:	7402                	ld	s0,32(sp)
    2138:	64e2                	ld	s1,24(sp)
    213a:	6942                	ld	s2,16(sp)
    213c:	69a2                	ld	s3,8(sp)
    213e:	6145                	addi	sp,sp,48
    2140:	8082                	ret
    printf("%s: no fork at all!\n", s);
    2142:	85ce                	mv	a1,s3
    2144:	00005517          	auipc	a0,0x5
    2148:	b5c50513          	addi	a0,a0,-1188 # 6ca0 <malloc+0xc32>
    214c:	00004097          	auipc	ra,0x4
    2150:	e62080e7          	jalr	-414(ra) # 5fae <printf>
    exit(1);
    2154:	4505                	li	a0,1
    2156:	00004097          	auipc	ra,0x4
    215a:	ac2080e7          	jalr	-1342(ra) # 5c18 <exit>
      printf("%s: wait stopped early\n", s);
    215e:	85ce                	mv	a1,s3
    2160:	00005517          	auipc	a0,0x5
    2164:	b8050513          	addi	a0,a0,-1152 # 6ce0 <malloc+0xc72>
    2168:	00004097          	auipc	ra,0x4
    216c:	e46080e7          	jalr	-442(ra) # 5fae <printf>
      exit(1);
    2170:	4505                	li	a0,1
    2172:	00004097          	auipc	ra,0x4
    2176:	aa6080e7          	jalr	-1370(ra) # 5c18 <exit>
    printf("%s: wait got too many\n", s);
    217a:	85ce                	mv	a1,s3
    217c:	00005517          	auipc	a0,0x5
    2180:	b7c50513          	addi	a0,a0,-1156 # 6cf8 <malloc+0xc8a>
    2184:	00004097          	auipc	ra,0x4
    2188:	e2a080e7          	jalr	-470(ra) # 5fae <printf>
    exit(1);
    218c:	4505                	li	a0,1
    218e:	00004097          	auipc	ra,0x4
    2192:	a8a080e7          	jalr	-1398(ra) # 5c18 <exit>

0000000000002196 <kernmem>:
{
    2196:	715d                	addi	sp,sp,-80
    2198:	e486                	sd	ra,72(sp)
    219a:	e0a2                	sd	s0,64(sp)
    219c:	fc26                	sd	s1,56(sp)
    219e:	f84a                	sd	s2,48(sp)
    21a0:	f44e                	sd	s3,40(sp)
    21a2:	f052                	sd	s4,32(sp)
    21a4:	ec56                	sd	s5,24(sp)
    21a6:	0880                	addi	s0,sp,80
    21a8:	8aaa                	mv	s5,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    21aa:	4485                	li	s1,1
    21ac:	04fe                	slli	s1,s1,0x1f
    if(xstatus != -1)  // did kernel kill child?
    21ae:	5a7d                	li	s4,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    21b0:	69b1                	lui	s3,0xc
    21b2:	35098993          	addi	s3,s3,848 # c350 <uninit+0x1de8>
    21b6:	1003d937          	lui	s2,0x1003d
    21ba:	090e                	slli	s2,s2,0x3
    21bc:	48090913          	addi	s2,s2,1152 # 1003d480 <base+0x1002d808>
    pid = fork();
    21c0:	00004097          	auipc	ra,0x4
    21c4:	a50080e7          	jalr	-1456(ra) # 5c10 <fork>
    if(pid < 0){
    21c8:	02054963          	bltz	a0,21fa <kernmem+0x64>
    if(pid == 0){
    21cc:	c529                	beqz	a0,2216 <kernmem+0x80>
    wait(&xstatus);
    21ce:	fbc40513          	addi	a0,s0,-68
    21d2:	00004097          	auipc	ra,0x4
    21d6:	a4e080e7          	jalr	-1458(ra) # 5c20 <wait>
    if(xstatus != -1)  // did kernel kill child?
    21da:	fbc42783          	lw	a5,-68(s0)
    21de:	05479d63          	bne	a5,s4,2238 <kernmem+0xa2>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    21e2:	94ce                	add	s1,s1,s3
    21e4:	fd249ee3          	bne	s1,s2,21c0 <kernmem+0x2a>
}
    21e8:	60a6                	ld	ra,72(sp)
    21ea:	6406                	ld	s0,64(sp)
    21ec:	74e2                	ld	s1,56(sp)
    21ee:	7942                	ld	s2,48(sp)
    21f0:	79a2                	ld	s3,40(sp)
    21f2:	7a02                	ld	s4,32(sp)
    21f4:	6ae2                	ld	s5,24(sp)
    21f6:	6161                	addi	sp,sp,80
    21f8:	8082                	ret
      printf("%s: fork failed\n", s);
    21fa:	85d6                	mv	a1,s5
    21fc:	00005517          	auipc	a0,0x5
    2200:	84450513          	addi	a0,a0,-1980 # 6a40 <malloc+0x9d2>
    2204:	00004097          	auipc	ra,0x4
    2208:	daa080e7          	jalr	-598(ra) # 5fae <printf>
      exit(1);
    220c:	4505                	li	a0,1
    220e:	00004097          	auipc	ra,0x4
    2212:	a0a080e7          	jalr	-1526(ra) # 5c18 <exit>
      printf("%s: oops could read %x = %x\n", s, a, *a);
    2216:	0004c683          	lbu	a3,0(s1)
    221a:	8626                	mv	a2,s1
    221c:	85d6                	mv	a1,s5
    221e:	00005517          	auipc	a0,0x5
    2222:	af250513          	addi	a0,a0,-1294 # 6d10 <malloc+0xca2>
    2226:	00004097          	auipc	ra,0x4
    222a:	d88080e7          	jalr	-632(ra) # 5fae <printf>
      exit(1);
    222e:	4505                	li	a0,1
    2230:	00004097          	auipc	ra,0x4
    2234:	9e8080e7          	jalr	-1560(ra) # 5c18 <exit>
      exit(1);
    2238:	4505                	li	a0,1
    223a:	00004097          	auipc	ra,0x4
    223e:	9de080e7          	jalr	-1570(ra) # 5c18 <exit>

0000000000002242 <MAXVAplus>:
{
    2242:	7179                	addi	sp,sp,-48
    2244:	f406                	sd	ra,40(sp)
    2246:	f022                	sd	s0,32(sp)
    2248:	ec26                	sd	s1,24(sp)
    224a:	e84a                	sd	s2,16(sp)
    224c:	1800                	addi	s0,sp,48
  volatile uint64 a = MAXVA;
    224e:	4785                	li	a5,1
    2250:	179a                	slli	a5,a5,0x26
    2252:	fcf43c23          	sd	a5,-40(s0)
  for( ; a != 0; a <<= 1){
    2256:	fd843783          	ld	a5,-40(s0)
    225a:	cf85                	beqz	a5,2292 <MAXVAplus+0x50>
    225c:	892a                	mv	s2,a0
    if(xstatus != -1)  // did kernel kill child?
    225e:	54fd                	li	s1,-1
    pid = fork();
    2260:	00004097          	auipc	ra,0x4
    2264:	9b0080e7          	jalr	-1616(ra) # 5c10 <fork>
    if(pid < 0){
    2268:	02054b63          	bltz	a0,229e <MAXVAplus+0x5c>
    if(pid == 0){
    226c:	c539                	beqz	a0,22ba <MAXVAplus+0x78>
    wait(&xstatus);
    226e:	fd440513          	addi	a0,s0,-44
    2272:	00004097          	auipc	ra,0x4
    2276:	9ae080e7          	jalr	-1618(ra) # 5c20 <wait>
    if(xstatus != -1)  // did kernel kill child?
    227a:	fd442783          	lw	a5,-44(s0)
    227e:	06979463          	bne	a5,s1,22e6 <MAXVAplus+0xa4>
  for( ; a != 0; a <<= 1){
    2282:	fd843783          	ld	a5,-40(s0)
    2286:	0786                	slli	a5,a5,0x1
    2288:	fcf43c23          	sd	a5,-40(s0)
    228c:	fd843783          	ld	a5,-40(s0)
    2290:	fbe1                	bnez	a5,2260 <MAXVAplus+0x1e>
}
    2292:	70a2                	ld	ra,40(sp)
    2294:	7402                	ld	s0,32(sp)
    2296:	64e2                	ld	s1,24(sp)
    2298:	6942                	ld	s2,16(sp)
    229a:	6145                	addi	sp,sp,48
    229c:	8082                	ret
      printf("%s: fork failed\n", s);
    229e:	85ca                	mv	a1,s2
    22a0:	00004517          	auipc	a0,0x4
    22a4:	7a050513          	addi	a0,a0,1952 # 6a40 <malloc+0x9d2>
    22a8:	00004097          	auipc	ra,0x4
    22ac:	d06080e7          	jalr	-762(ra) # 5fae <printf>
      exit(1);
    22b0:	4505                	li	a0,1
    22b2:	00004097          	auipc	ra,0x4
    22b6:	966080e7          	jalr	-1690(ra) # 5c18 <exit>
      *(char*)a = 99;
    22ba:	fd843783          	ld	a5,-40(s0)
    22be:	06300713          	li	a4,99
    22c2:	00e78023          	sb	a4,0(a5)
      printf("%s: oops wrote %x\n", s, a);
    22c6:	fd843603          	ld	a2,-40(s0)
    22ca:	85ca                	mv	a1,s2
    22cc:	00005517          	auipc	a0,0x5
    22d0:	a6450513          	addi	a0,a0,-1436 # 6d30 <malloc+0xcc2>
    22d4:	00004097          	auipc	ra,0x4
    22d8:	cda080e7          	jalr	-806(ra) # 5fae <printf>
      exit(1);
    22dc:	4505                	li	a0,1
    22de:	00004097          	auipc	ra,0x4
    22e2:	93a080e7          	jalr	-1734(ra) # 5c18 <exit>
      exit(1);
    22e6:	4505                	li	a0,1
    22e8:	00004097          	auipc	ra,0x4
    22ec:	930080e7          	jalr	-1744(ra) # 5c18 <exit>

00000000000022f0 <bigargtest>:
{
    22f0:	7179                	addi	sp,sp,-48
    22f2:	f406                	sd	ra,40(sp)
    22f4:	f022                	sd	s0,32(sp)
    22f6:	ec26                	sd	s1,24(sp)
    22f8:	1800                	addi	s0,sp,48
    22fa:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    22fc:	00005517          	auipc	a0,0x5
    2300:	a4c50513          	addi	a0,a0,-1460 # 6d48 <malloc+0xcda>
    2304:	00004097          	auipc	ra,0x4
    2308:	964080e7          	jalr	-1692(ra) # 5c68 <unlink>
  pid = fork();
    230c:	00004097          	auipc	ra,0x4
    2310:	904080e7          	jalr	-1788(ra) # 5c10 <fork>
  if(pid == 0){
    2314:	c121                	beqz	a0,2354 <bigargtest+0x64>
  } else if(pid < 0){
    2316:	0a054063          	bltz	a0,23b6 <bigargtest+0xc6>
  wait(&xstatus);
    231a:	fdc40513          	addi	a0,s0,-36
    231e:	00004097          	auipc	ra,0x4
    2322:	902080e7          	jalr	-1790(ra) # 5c20 <wait>
  if(xstatus != 0)
    2326:	fdc42503          	lw	a0,-36(s0)
    232a:	e545                	bnez	a0,23d2 <bigargtest+0xe2>
  fd = open("bigarg-ok", 0);
    232c:	4581                	li	a1,0
    232e:	00005517          	auipc	a0,0x5
    2332:	a1a50513          	addi	a0,a0,-1510 # 6d48 <malloc+0xcda>
    2336:	00004097          	auipc	ra,0x4
    233a:	922080e7          	jalr	-1758(ra) # 5c58 <open>
  if(fd < 0){
    233e:	08054e63          	bltz	a0,23da <bigargtest+0xea>
  close(fd);
    2342:	00004097          	auipc	ra,0x4
    2346:	8fe080e7          	jalr	-1794(ra) # 5c40 <close>
}
    234a:	70a2                	ld	ra,40(sp)
    234c:	7402                	ld	s0,32(sp)
    234e:	64e2                	ld	s1,24(sp)
    2350:	6145                	addi	sp,sp,48
    2352:	8082                	ret
    2354:	00007797          	auipc	a5,0x7
    2358:	10c78793          	addi	a5,a5,268 # 9460 <args.1850>
    235c:	00007697          	auipc	a3,0x7
    2360:	1fc68693          	addi	a3,a3,508 # 9558 <args.1850+0xf8>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    2364:	00005717          	auipc	a4,0x5
    2368:	9f470713          	addi	a4,a4,-1548 # 6d58 <malloc+0xcea>
    236c:	e398                	sd	a4,0(a5)
    236e:	07a1                	addi	a5,a5,8
    for(i = 0; i < MAXARG-1; i++)
    2370:	fed79ee3          	bne	a5,a3,236c <bigargtest+0x7c>
    args[MAXARG-1] = 0;
    2374:	00007597          	auipc	a1,0x7
    2378:	0ec58593          	addi	a1,a1,236 # 9460 <args.1850>
    237c:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    2380:	00004517          	auipc	a0,0x4
    2384:	e3850513          	addi	a0,a0,-456 # 61b8 <malloc+0x14a>
    2388:	00004097          	auipc	ra,0x4
    238c:	8c8080e7          	jalr	-1848(ra) # 5c50 <exec>
    fd = open("bigarg-ok", O_CREATE);
    2390:	20000593          	li	a1,512
    2394:	00005517          	auipc	a0,0x5
    2398:	9b450513          	addi	a0,a0,-1612 # 6d48 <malloc+0xcda>
    239c:	00004097          	auipc	ra,0x4
    23a0:	8bc080e7          	jalr	-1860(ra) # 5c58 <open>
    close(fd);
    23a4:	00004097          	auipc	ra,0x4
    23a8:	89c080e7          	jalr	-1892(ra) # 5c40 <close>
    exit(0);
    23ac:	4501                	li	a0,0
    23ae:	00004097          	auipc	ra,0x4
    23b2:	86a080e7          	jalr	-1942(ra) # 5c18 <exit>
    printf("%s: bigargtest: fork failed\n", s);
    23b6:	85a6                	mv	a1,s1
    23b8:	00005517          	auipc	a0,0x5
    23bc:	a8050513          	addi	a0,a0,-1408 # 6e38 <malloc+0xdca>
    23c0:	00004097          	auipc	ra,0x4
    23c4:	bee080e7          	jalr	-1042(ra) # 5fae <printf>
    exit(1);
    23c8:	4505                	li	a0,1
    23ca:	00004097          	auipc	ra,0x4
    23ce:	84e080e7          	jalr	-1970(ra) # 5c18 <exit>
    exit(xstatus);
    23d2:	00004097          	auipc	ra,0x4
    23d6:	846080e7          	jalr	-1978(ra) # 5c18 <exit>
    printf("%s: bigarg test failed!\n", s);
    23da:	85a6                	mv	a1,s1
    23dc:	00005517          	auipc	a0,0x5
    23e0:	a7c50513          	addi	a0,a0,-1412 # 6e58 <malloc+0xdea>
    23e4:	00004097          	auipc	ra,0x4
    23e8:	bca080e7          	jalr	-1078(ra) # 5fae <printf>
    exit(1);
    23ec:	4505                	li	a0,1
    23ee:	00004097          	auipc	ra,0x4
    23f2:	82a080e7          	jalr	-2006(ra) # 5c18 <exit>

00000000000023f6 <stacktest>:
{
    23f6:	7179                	addi	sp,sp,-48
    23f8:	f406                	sd	ra,40(sp)
    23fa:	f022                	sd	s0,32(sp)
    23fc:	ec26                	sd	s1,24(sp)
    23fe:	1800                	addi	s0,sp,48
    2400:	84aa                	mv	s1,a0
  pid = fork();
    2402:	00004097          	auipc	ra,0x4
    2406:	80e080e7          	jalr	-2034(ra) # 5c10 <fork>
  if(pid == 0) {
    240a:	c115                	beqz	a0,242e <stacktest+0x38>
  } else if(pid < 0){
    240c:	04054463          	bltz	a0,2454 <stacktest+0x5e>
  wait(&xstatus);
    2410:	fdc40513          	addi	a0,s0,-36
    2414:	00004097          	auipc	ra,0x4
    2418:	80c080e7          	jalr	-2036(ra) # 5c20 <wait>
  if(xstatus == -1)  // kernel killed child?
    241c:	fdc42503          	lw	a0,-36(s0)
    2420:	57fd                	li	a5,-1
    2422:	04f50763          	beq	a0,a5,2470 <stacktest+0x7a>
    exit(xstatus);
    2426:	00003097          	auipc	ra,0x3
    242a:	7f2080e7          	jalr	2034(ra) # 5c18 <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    242e:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %p\n", s, *sp);
    2430:	77fd                	lui	a5,0xfffff
    2432:	97ba                	add	a5,a5,a4
    2434:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <base+0xfffffffffffef388>
    2438:	85a6                	mv	a1,s1
    243a:	00005517          	auipc	a0,0x5
    243e:	a3e50513          	addi	a0,a0,-1474 # 6e78 <malloc+0xe0a>
    2442:	00004097          	auipc	ra,0x4
    2446:	b6c080e7          	jalr	-1172(ra) # 5fae <printf>
    exit(1);
    244a:	4505                	li	a0,1
    244c:	00003097          	auipc	ra,0x3
    2450:	7cc080e7          	jalr	1996(ra) # 5c18 <exit>
    printf("%s: fork failed\n", s);
    2454:	85a6                	mv	a1,s1
    2456:	00004517          	auipc	a0,0x4
    245a:	5ea50513          	addi	a0,a0,1514 # 6a40 <malloc+0x9d2>
    245e:	00004097          	auipc	ra,0x4
    2462:	b50080e7          	jalr	-1200(ra) # 5fae <printf>
    exit(1);
    2466:	4505                	li	a0,1
    2468:	00003097          	auipc	ra,0x3
    246c:	7b0080e7          	jalr	1968(ra) # 5c18 <exit>
    exit(0);
    2470:	4501                	li	a0,0
    2472:	00003097          	auipc	ra,0x3
    2476:	7a6080e7          	jalr	1958(ra) # 5c18 <exit>

000000000000247a <textwrite>:
{
    247a:	7179                	addi	sp,sp,-48
    247c:	f406                	sd	ra,40(sp)
    247e:	f022                	sd	s0,32(sp)
    2480:	ec26                	sd	s1,24(sp)
    2482:	1800                	addi	s0,sp,48
    2484:	84aa                	mv	s1,a0
  pid = fork();
    2486:	00003097          	auipc	ra,0x3
    248a:	78a080e7          	jalr	1930(ra) # 5c10 <fork>
  if(pid == 0) {
    248e:	c115                	beqz	a0,24b2 <textwrite+0x38>
  } else if(pid < 0){
    2490:	02054963          	bltz	a0,24c2 <textwrite+0x48>
  wait(&xstatus);
    2494:	fdc40513          	addi	a0,s0,-36
    2498:	00003097          	auipc	ra,0x3
    249c:	788080e7          	jalr	1928(ra) # 5c20 <wait>
  if(xstatus == -1)  // kernel killed child?
    24a0:	fdc42503          	lw	a0,-36(s0)
    24a4:	57fd                	li	a5,-1
    24a6:	02f50c63          	beq	a0,a5,24de <textwrite+0x64>
    exit(xstatus);
    24aa:	00003097          	auipc	ra,0x3
    24ae:	76e080e7          	jalr	1902(ra) # 5c18 <exit>
    *addr = 10;
    24b2:	47a9                	li	a5,10
    24b4:	00f02023          	sw	a5,0(zero) # 0 <copyinstr1>
    exit(1);
    24b8:	4505                	li	a0,1
    24ba:	00003097          	auipc	ra,0x3
    24be:	75e080e7          	jalr	1886(ra) # 5c18 <exit>
    printf("%s: fork failed\n", s);
    24c2:	85a6                	mv	a1,s1
    24c4:	00004517          	auipc	a0,0x4
    24c8:	57c50513          	addi	a0,a0,1404 # 6a40 <malloc+0x9d2>
    24cc:	00004097          	auipc	ra,0x4
    24d0:	ae2080e7          	jalr	-1310(ra) # 5fae <printf>
    exit(1);
    24d4:	4505                	li	a0,1
    24d6:	00003097          	auipc	ra,0x3
    24da:	742080e7          	jalr	1858(ra) # 5c18 <exit>
    exit(0);
    24de:	4501                	li	a0,0
    24e0:	00003097          	auipc	ra,0x3
    24e4:	738080e7          	jalr	1848(ra) # 5c18 <exit>

00000000000024e8 <manywrites>:
{
    24e8:	711d                	addi	sp,sp,-96
    24ea:	ec86                	sd	ra,88(sp)
    24ec:	e8a2                	sd	s0,80(sp)
    24ee:	e4a6                	sd	s1,72(sp)
    24f0:	e0ca                	sd	s2,64(sp)
    24f2:	fc4e                	sd	s3,56(sp)
    24f4:	f852                	sd	s4,48(sp)
    24f6:	f456                	sd	s5,40(sp)
    24f8:	f05a                	sd	s6,32(sp)
    24fa:	ec5e                	sd	s7,24(sp)
    24fc:	1080                	addi	s0,sp,96
    24fe:	8b2a                	mv	s6,a0
  for(int ci = 0; ci < nchildren; ci++){
    2500:	4481                	li	s1,0
    2502:	4991                	li	s3,4
    int pid = fork();
    2504:	00003097          	auipc	ra,0x3
    2508:	70c080e7          	jalr	1804(ra) # 5c10 <fork>
    250c:	892a                	mv	s2,a0
    if(pid < 0){
    250e:	02054963          	bltz	a0,2540 <manywrites+0x58>
    if(pid == 0){
    2512:	c521                	beqz	a0,255a <manywrites+0x72>
  for(int ci = 0; ci < nchildren; ci++){
    2514:	2485                	addiw	s1,s1,1
    2516:	ff3497e3          	bne	s1,s3,2504 <manywrites+0x1c>
    251a:	4491                	li	s1,4
    int st = 0;
    251c:	fa042423          	sw	zero,-88(s0)
    wait(&st);
    2520:	fa840513          	addi	a0,s0,-88
    2524:	00003097          	auipc	ra,0x3
    2528:	6fc080e7          	jalr	1788(ra) # 5c20 <wait>
    if(st != 0)
    252c:	fa842503          	lw	a0,-88(s0)
    2530:	ed6d                	bnez	a0,262a <manywrites+0x142>
    2532:	34fd                	addiw	s1,s1,-1
  for(int ci = 0; ci < nchildren; ci++){
    2534:	f4e5                	bnez	s1,251c <manywrites+0x34>
  exit(0);
    2536:	4501                	li	a0,0
    2538:	00003097          	auipc	ra,0x3
    253c:	6e0080e7          	jalr	1760(ra) # 5c18 <exit>
      printf("fork failed\n");
    2540:	00005517          	auipc	a0,0x5
    2544:	90850513          	addi	a0,a0,-1784 # 6e48 <malloc+0xdda>
    2548:	00004097          	auipc	ra,0x4
    254c:	a66080e7          	jalr	-1434(ra) # 5fae <printf>
      exit(1);
    2550:	4505                	li	a0,1
    2552:	00003097          	auipc	ra,0x3
    2556:	6c6080e7          	jalr	1734(ra) # 5c18 <exit>
      name[0] = 'b';
    255a:	06200793          	li	a5,98
    255e:	faf40423          	sb	a5,-88(s0)
      name[1] = 'a' + ci;
    2562:	0614879b          	addiw	a5,s1,97
    2566:	faf404a3          	sb	a5,-87(s0)
      name[2] = '\0';
    256a:	fa040523          	sb	zero,-86(s0)
      unlink(name);
    256e:	fa840513          	addi	a0,s0,-88
    2572:	00003097          	auipc	ra,0x3
    2576:	6f6080e7          	jalr	1782(ra) # 5c68 <unlink>
    257a:	4bf9                	li	s7,30
          int cc = write(fd, buf, sz);
    257c:	0000aa97          	auipc	s5,0xa
    2580:	6fca8a93          	addi	s5,s5,1788 # cc78 <buf>
        for(int i = 0; i < ci+1; i++){
    2584:	8a4a                	mv	s4,s2
    2586:	0204ce63          	bltz	s1,25c2 <manywrites+0xda>
          int fd = open(name, O_CREATE | O_RDWR);
    258a:	20200593          	li	a1,514
    258e:	fa840513          	addi	a0,s0,-88
    2592:	00003097          	auipc	ra,0x3
    2596:	6c6080e7          	jalr	1734(ra) # 5c58 <open>
    259a:	89aa                	mv	s3,a0
          if(fd < 0){
    259c:	04054763          	bltz	a0,25ea <manywrites+0x102>
          int cc = write(fd, buf, sz);
    25a0:	660d                	lui	a2,0x3
    25a2:	85d6                	mv	a1,s5
    25a4:	00003097          	auipc	ra,0x3
    25a8:	694080e7          	jalr	1684(ra) # 5c38 <write>
          if(cc != sz){
    25ac:	678d                	lui	a5,0x3
    25ae:	04f51e63          	bne	a0,a5,260a <manywrites+0x122>
          close(fd);
    25b2:	854e                	mv	a0,s3
    25b4:	00003097          	auipc	ra,0x3
    25b8:	68c080e7          	jalr	1676(ra) # 5c40 <close>
        for(int i = 0; i < ci+1; i++){
    25bc:	2a05                	addiw	s4,s4,1
    25be:	fd44d6e3          	bge	s1,s4,258a <manywrites+0xa2>
        unlink(name);
    25c2:	fa840513          	addi	a0,s0,-88
    25c6:	00003097          	auipc	ra,0x3
    25ca:	6a2080e7          	jalr	1698(ra) # 5c68 <unlink>
    25ce:	3bfd                	addiw	s7,s7,-1
      for(int iters = 0; iters < howmany; iters++){
    25d0:	fa0b9ae3          	bnez	s7,2584 <manywrites+0x9c>
      unlink(name);
    25d4:	fa840513          	addi	a0,s0,-88
    25d8:	00003097          	auipc	ra,0x3
    25dc:	690080e7          	jalr	1680(ra) # 5c68 <unlink>
      exit(0);
    25e0:	4501                	li	a0,0
    25e2:	00003097          	auipc	ra,0x3
    25e6:	636080e7          	jalr	1590(ra) # 5c18 <exit>
            printf("%s: cannot create %s\n", s, name);
    25ea:	fa840613          	addi	a2,s0,-88
    25ee:	85da                	mv	a1,s6
    25f0:	00005517          	auipc	a0,0x5
    25f4:	8b050513          	addi	a0,a0,-1872 # 6ea0 <malloc+0xe32>
    25f8:	00004097          	auipc	ra,0x4
    25fc:	9b6080e7          	jalr	-1610(ra) # 5fae <printf>
            exit(1);
    2600:	4505                	li	a0,1
    2602:	00003097          	auipc	ra,0x3
    2606:	616080e7          	jalr	1558(ra) # 5c18 <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    260a:	86aa                	mv	a3,a0
    260c:	660d                	lui	a2,0x3
    260e:	85da                	mv	a1,s6
    2610:	00004517          	auipc	a0,0x4
    2614:	c7850513          	addi	a0,a0,-904 # 6288 <malloc+0x21a>
    2618:	00004097          	auipc	ra,0x4
    261c:	996080e7          	jalr	-1642(ra) # 5fae <printf>
            exit(1);
    2620:	4505                	li	a0,1
    2622:	00003097          	auipc	ra,0x3
    2626:	5f6080e7          	jalr	1526(ra) # 5c18 <exit>
      exit(st);
    262a:	00003097          	auipc	ra,0x3
    262e:	5ee080e7          	jalr	1518(ra) # 5c18 <exit>

0000000000002632 <copyinstr3>:
{
    2632:	7179                	addi	sp,sp,-48
    2634:	f406                	sd	ra,40(sp)
    2636:	f022                	sd	s0,32(sp)
    2638:	ec26                	sd	s1,24(sp)
    263a:	1800                	addi	s0,sp,48
  sbrk(8192);
    263c:	6509                	lui	a0,0x2
    263e:	00003097          	auipc	ra,0x3
    2642:	662080e7          	jalr	1634(ra) # 5ca0 <sbrk>
  uint64 top = (uint64) sbrk(0);
    2646:	4501                	li	a0,0
    2648:	00003097          	auipc	ra,0x3
    264c:	658080e7          	jalr	1624(ra) # 5ca0 <sbrk>
  if((top % PGSIZE) != 0){
    2650:	03451793          	slli	a5,a0,0x34
    2654:	e3c9                	bnez	a5,26d6 <copyinstr3+0xa4>
  top = (uint64) sbrk(0);
    2656:	4501                	li	a0,0
    2658:	00003097          	auipc	ra,0x3
    265c:	648080e7          	jalr	1608(ra) # 5ca0 <sbrk>
  if(top % PGSIZE){
    2660:	03451793          	slli	a5,a0,0x34
    2664:	e3d9                	bnez	a5,26ea <copyinstr3+0xb8>
  char *b = (char *) (top - 1);
    2666:	fff50493          	addi	s1,a0,-1 # 1fff <linkunlink+0x4b>
  *b = 'x';
    266a:	07800793          	li	a5,120
    266e:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    2672:	8526                	mv	a0,s1
    2674:	00003097          	auipc	ra,0x3
    2678:	5f4080e7          	jalr	1524(ra) # 5c68 <unlink>
  if(ret != -1){
    267c:	57fd                	li	a5,-1
    267e:	08f51363          	bne	a0,a5,2704 <copyinstr3+0xd2>
  int fd = open(b, O_CREATE | O_WRONLY);
    2682:	20100593          	li	a1,513
    2686:	8526                	mv	a0,s1
    2688:	00003097          	auipc	ra,0x3
    268c:	5d0080e7          	jalr	1488(ra) # 5c58 <open>
  if(fd != -1){
    2690:	57fd                	li	a5,-1
    2692:	08f51863          	bne	a0,a5,2722 <copyinstr3+0xf0>
  ret = link(b, b);
    2696:	85a6                	mv	a1,s1
    2698:	8526                	mv	a0,s1
    269a:	00003097          	auipc	ra,0x3
    269e:	5de080e7          	jalr	1502(ra) # 5c78 <link>
  if(ret != -1){
    26a2:	57fd                	li	a5,-1
    26a4:	08f51e63          	bne	a0,a5,2740 <copyinstr3+0x10e>
  char *args[] = { "xx", 0 };
    26a8:	00005797          	auipc	a5,0x5
    26ac:	4f078793          	addi	a5,a5,1264 # 7b98 <malloc+0x1b2a>
    26b0:	fcf43823          	sd	a5,-48(s0)
    26b4:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    26b8:	fd040593          	addi	a1,s0,-48
    26bc:	8526                	mv	a0,s1
    26be:	00003097          	auipc	ra,0x3
    26c2:	592080e7          	jalr	1426(ra) # 5c50 <exec>
  if(ret != -1){
    26c6:	57fd                	li	a5,-1
    26c8:	08f51c63          	bne	a0,a5,2760 <copyinstr3+0x12e>
}
    26cc:	70a2                	ld	ra,40(sp)
    26ce:	7402                	ld	s0,32(sp)
    26d0:	64e2                	ld	s1,24(sp)
    26d2:	6145                	addi	sp,sp,48
    26d4:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    26d6:	1552                	slli	a0,a0,0x34
    26d8:	9151                	srli	a0,a0,0x34
    26da:	6785                	lui	a5,0x1
    26dc:	40a7853b          	subw	a0,a5,a0
    26e0:	00003097          	auipc	ra,0x3
    26e4:	5c0080e7          	jalr	1472(ra) # 5ca0 <sbrk>
    26e8:	b7bd                	j	2656 <copyinstr3+0x24>
    printf("oops\n");
    26ea:	00004517          	auipc	a0,0x4
    26ee:	7ce50513          	addi	a0,a0,1998 # 6eb8 <malloc+0xe4a>
    26f2:	00004097          	auipc	ra,0x4
    26f6:	8bc080e7          	jalr	-1860(ra) # 5fae <printf>
    exit(1);
    26fa:	4505                	li	a0,1
    26fc:	00003097          	auipc	ra,0x3
    2700:	51c080e7          	jalr	1308(ra) # 5c18 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    2704:	862a                	mv	a2,a0
    2706:	85a6                	mv	a1,s1
    2708:	00004517          	auipc	a0,0x4
    270c:	25850513          	addi	a0,a0,600 # 6960 <malloc+0x8f2>
    2710:	00004097          	auipc	ra,0x4
    2714:	89e080e7          	jalr	-1890(ra) # 5fae <printf>
    exit(1);
    2718:	4505                	li	a0,1
    271a:	00003097          	auipc	ra,0x3
    271e:	4fe080e7          	jalr	1278(ra) # 5c18 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    2722:	862a                	mv	a2,a0
    2724:	85a6                	mv	a1,s1
    2726:	00004517          	auipc	a0,0x4
    272a:	25a50513          	addi	a0,a0,602 # 6980 <malloc+0x912>
    272e:	00004097          	auipc	ra,0x4
    2732:	880080e7          	jalr	-1920(ra) # 5fae <printf>
    exit(1);
    2736:	4505                	li	a0,1
    2738:	00003097          	auipc	ra,0x3
    273c:	4e0080e7          	jalr	1248(ra) # 5c18 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    2740:	86aa                	mv	a3,a0
    2742:	8626                	mv	a2,s1
    2744:	85a6                	mv	a1,s1
    2746:	00004517          	auipc	a0,0x4
    274a:	25a50513          	addi	a0,a0,602 # 69a0 <malloc+0x932>
    274e:	00004097          	auipc	ra,0x4
    2752:	860080e7          	jalr	-1952(ra) # 5fae <printf>
    exit(1);
    2756:	4505                	li	a0,1
    2758:	00003097          	auipc	ra,0x3
    275c:	4c0080e7          	jalr	1216(ra) # 5c18 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    2760:	567d                	li	a2,-1
    2762:	85a6                	mv	a1,s1
    2764:	00004517          	auipc	a0,0x4
    2768:	26450513          	addi	a0,a0,612 # 69c8 <malloc+0x95a>
    276c:	00004097          	auipc	ra,0x4
    2770:	842080e7          	jalr	-1982(ra) # 5fae <printf>
    exit(1);
    2774:	4505                	li	a0,1
    2776:	00003097          	auipc	ra,0x3
    277a:	4a2080e7          	jalr	1186(ra) # 5c18 <exit>

000000000000277e <rwsbrk>:
{
    277e:	1101                	addi	sp,sp,-32
    2780:	ec06                	sd	ra,24(sp)
    2782:	e822                	sd	s0,16(sp)
    2784:	e426                	sd	s1,8(sp)
    2786:	e04a                	sd	s2,0(sp)
    2788:	1000                	addi	s0,sp,32
  uint64 a = (uint64) sbrk(8192);
    278a:	6509                	lui	a0,0x2
    278c:	00003097          	auipc	ra,0x3
    2790:	514080e7          	jalr	1300(ra) # 5ca0 <sbrk>
  if(a == 0xffffffffffffffffLL) {
    2794:	57fd                	li	a5,-1
    2796:	06f50263          	beq	a0,a5,27fa <rwsbrk+0x7c>
    279a:	84aa                	mv	s1,a0
  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
    279c:	7579                	lui	a0,0xffffe
    279e:	00003097          	auipc	ra,0x3
    27a2:	502080e7          	jalr	1282(ra) # 5ca0 <sbrk>
    27a6:	57fd                	li	a5,-1
    27a8:	06f50663          	beq	a0,a5,2814 <rwsbrk+0x96>
  fd = open("rwsbrk", O_CREATE|O_WRONLY);
    27ac:	20100593          	li	a1,513
    27b0:	00004517          	auipc	a0,0x4
    27b4:	74850513          	addi	a0,a0,1864 # 6ef8 <malloc+0xe8a>
    27b8:	00003097          	auipc	ra,0x3
    27bc:	4a0080e7          	jalr	1184(ra) # 5c58 <open>
    27c0:	892a                	mv	s2,a0
  if(fd < 0){
    27c2:	06054663          	bltz	a0,282e <rwsbrk+0xb0>
  n = write(fd, (void*)(a+4096), 1024);
    27c6:	6785                	lui	a5,0x1
    27c8:	94be                	add	s1,s1,a5
    27ca:	40000613          	li	a2,1024
    27ce:	85a6                	mv	a1,s1
    27d0:	00003097          	auipc	ra,0x3
    27d4:	468080e7          	jalr	1128(ra) # 5c38 <write>
  if(n >= 0){
    27d8:	06054863          	bltz	a0,2848 <rwsbrk+0xca>
    printf("write(fd, %p, 1024) returned %d, not -1\n", a+4096, n);
    27dc:	862a                	mv	a2,a0
    27de:	85a6                	mv	a1,s1
    27e0:	00004517          	auipc	a0,0x4
    27e4:	73850513          	addi	a0,a0,1848 # 6f18 <malloc+0xeaa>
    27e8:	00003097          	auipc	ra,0x3
    27ec:	7c6080e7          	jalr	1990(ra) # 5fae <printf>
    exit(1);
    27f0:	4505                	li	a0,1
    27f2:	00003097          	auipc	ra,0x3
    27f6:	426080e7          	jalr	1062(ra) # 5c18 <exit>
    printf("sbrk(rwsbrk) failed\n");
    27fa:	00004517          	auipc	a0,0x4
    27fe:	6c650513          	addi	a0,a0,1734 # 6ec0 <malloc+0xe52>
    2802:	00003097          	auipc	ra,0x3
    2806:	7ac080e7          	jalr	1964(ra) # 5fae <printf>
    exit(1);
    280a:	4505                	li	a0,1
    280c:	00003097          	auipc	ra,0x3
    2810:	40c080e7          	jalr	1036(ra) # 5c18 <exit>
    printf("sbrk(rwsbrk) shrink failed\n");
    2814:	00004517          	auipc	a0,0x4
    2818:	6c450513          	addi	a0,a0,1732 # 6ed8 <malloc+0xe6a>
    281c:	00003097          	auipc	ra,0x3
    2820:	792080e7          	jalr	1938(ra) # 5fae <printf>
    exit(1);
    2824:	4505                	li	a0,1
    2826:	00003097          	auipc	ra,0x3
    282a:	3f2080e7          	jalr	1010(ra) # 5c18 <exit>
    printf("open(rwsbrk) failed\n");
    282e:	00004517          	auipc	a0,0x4
    2832:	6d250513          	addi	a0,a0,1746 # 6f00 <malloc+0xe92>
    2836:	00003097          	auipc	ra,0x3
    283a:	778080e7          	jalr	1912(ra) # 5fae <printf>
    exit(1);
    283e:	4505                	li	a0,1
    2840:	00003097          	auipc	ra,0x3
    2844:	3d8080e7          	jalr	984(ra) # 5c18 <exit>
  close(fd);
    2848:	854a                	mv	a0,s2
    284a:	00003097          	auipc	ra,0x3
    284e:	3f6080e7          	jalr	1014(ra) # 5c40 <close>
  unlink("rwsbrk");
    2852:	00004517          	auipc	a0,0x4
    2856:	6a650513          	addi	a0,a0,1702 # 6ef8 <malloc+0xe8a>
    285a:	00003097          	auipc	ra,0x3
    285e:	40e080e7          	jalr	1038(ra) # 5c68 <unlink>
  fd = open("README", O_RDONLY);
    2862:	4581                	li	a1,0
    2864:	00004517          	auipc	a0,0x4
    2868:	b2c50513          	addi	a0,a0,-1236 # 6390 <malloc+0x322>
    286c:	00003097          	auipc	ra,0x3
    2870:	3ec080e7          	jalr	1004(ra) # 5c58 <open>
    2874:	892a                	mv	s2,a0
  if(fd < 0){
    2876:	02054963          	bltz	a0,28a8 <rwsbrk+0x12a>
  n = read(fd, (void*)(a+4096), 10);
    287a:	4629                	li	a2,10
    287c:	85a6                	mv	a1,s1
    287e:	00003097          	auipc	ra,0x3
    2882:	3b2080e7          	jalr	946(ra) # 5c30 <read>
  if(n >= 0){
    2886:	02054e63          	bltz	a0,28c2 <rwsbrk+0x144>
    printf("read(fd, %p, 10) returned %d, not -1\n", a+4096, n);
    288a:	862a                	mv	a2,a0
    288c:	85a6                	mv	a1,s1
    288e:	00004517          	auipc	a0,0x4
    2892:	6ba50513          	addi	a0,a0,1722 # 6f48 <malloc+0xeda>
    2896:	00003097          	auipc	ra,0x3
    289a:	718080e7          	jalr	1816(ra) # 5fae <printf>
    exit(1);
    289e:	4505                	li	a0,1
    28a0:	00003097          	auipc	ra,0x3
    28a4:	378080e7          	jalr	888(ra) # 5c18 <exit>
    printf("open(rwsbrk) failed\n");
    28a8:	00004517          	auipc	a0,0x4
    28ac:	65850513          	addi	a0,a0,1624 # 6f00 <malloc+0xe92>
    28b0:	00003097          	auipc	ra,0x3
    28b4:	6fe080e7          	jalr	1790(ra) # 5fae <printf>
    exit(1);
    28b8:	4505                	li	a0,1
    28ba:	00003097          	auipc	ra,0x3
    28be:	35e080e7          	jalr	862(ra) # 5c18 <exit>
  close(fd);
    28c2:	854a                	mv	a0,s2
    28c4:	00003097          	auipc	ra,0x3
    28c8:	37c080e7          	jalr	892(ra) # 5c40 <close>
  exit(0);
    28cc:	4501                	li	a0,0
    28ce:	00003097          	auipc	ra,0x3
    28d2:	34a080e7          	jalr	842(ra) # 5c18 <exit>

00000000000028d6 <sbrkbasic>:
{
    28d6:	7139                	addi	sp,sp,-64
    28d8:	fc06                	sd	ra,56(sp)
    28da:	f822                	sd	s0,48(sp)
    28dc:	f426                	sd	s1,40(sp)
    28de:	f04a                	sd	s2,32(sp)
    28e0:	ec4e                	sd	s3,24(sp)
    28e2:	e852                	sd	s4,16(sp)
    28e4:	0080                	addi	s0,sp,64
    28e6:	8a2a                	mv	s4,a0
  pid = fork();
    28e8:	00003097          	auipc	ra,0x3
    28ec:	328080e7          	jalr	808(ra) # 5c10 <fork>
  if(pid < 0){
    28f0:	02054c63          	bltz	a0,2928 <sbrkbasic+0x52>
  if(pid == 0){
    28f4:	ed21                	bnez	a0,294c <sbrkbasic+0x76>
    a = sbrk(TOOMUCH);
    28f6:	40000537          	lui	a0,0x40000
    28fa:	00003097          	auipc	ra,0x3
    28fe:	3a6080e7          	jalr	934(ra) # 5ca0 <sbrk>
    if(a == (char*)0xffffffffffffffffL){
    2902:	57fd                	li	a5,-1
    2904:	02f50f63          	beq	a0,a5,2942 <sbrkbasic+0x6c>
    for(b = a; b < a+TOOMUCH; b += 4096){
    2908:	400007b7          	lui	a5,0x40000
    290c:	97aa                	add	a5,a5,a0
      *b = 99;
    290e:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += 4096){
    2912:	6705                	lui	a4,0x1
      *b = 99;
    2914:	00d50023          	sb	a3,0(a0) # 40000000 <base+0x3fff0388>
    for(b = a; b < a+TOOMUCH; b += 4096){
    2918:	953a                	add	a0,a0,a4
    291a:	fef51de3          	bne	a0,a5,2914 <sbrkbasic+0x3e>
    exit(1);
    291e:	4505                	li	a0,1
    2920:	00003097          	auipc	ra,0x3
    2924:	2f8080e7          	jalr	760(ra) # 5c18 <exit>
    printf("fork failed in sbrkbasic\n");
    2928:	00004517          	auipc	a0,0x4
    292c:	64850513          	addi	a0,a0,1608 # 6f70 <malloc+0xf02>
    2930:	00003097          	auipc	ra,0x3
    2934:	67e080e7          	jalr	1662(ra) # 5fae <printf>
    exit(1);
    2938:	4505                	li	a0,1
    293a:	00003097          	auipc	ra,0x3
    293e:	2de080e7          	jalr	734(ra) # 5c18 <exit>
      exit(0);
    2942:	4501                	li	a0,0
    2944:	00003097          	auipc	ra,0x3
    2948:	2d4080e7          	jalr	724(ra) # 5c18 <exit>
  wait(&xstatus);
    294c:	fcc40513          	addi	a0,s0,-52
    2950:	00003097          	auipc	ra,0x3
    2954:	2d0080e7          	jalr	720(ra) # 5c20 <wait>
  if(xstatus == 1){
    2958:	fcc42703          	lw	a4,-52(s0)
    295c:	4785                	li	a5,1
    295e:	00f70d63          	beq	a4,a5,2978 <sbrkbasic+0xa2>
  a = sbrk(0);
    2962:	4501                	li	a0,0
    2964:	00003097          	auipc	ra,0x3
    2968:	33c080e7          	jalr	828(ra) # 5ca0 <sbrk>
    296c:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    296e:	4901                	li	s2,0
    2970:	6985                	lui	s3,0x1
    2972:	38898993          	addi	s3,s3,904 # 1388 <badarg+0x2a>
    2976:	a005                	j	2996 <sbrkbasic+0xc0>
    printf("%s: too much memory allocated!\n", s);
    2978:	85d2                	mv	a1,s4
    297a:	00004517          	auipc	a0,0x4
    297e:	61650513          	addi	a0,a0,1558 # 6f90 <malloc+0xf22>
    2982:	00003097          	auipc	ra,0x3
    2986:	62c080e7          	jalr	1580(ra) # 5fae <printf>
    exit(1);
    298a:	4505                	li	a0,1
    298c:	00003097          	auipc	ra,0x3
    2990:	28c080e7          	jalr	652(ra) # 5c18 <exit>
    a = b + 1;
    2994:	84be                	mv	s1,a5
    b = sbrk(1);
    2996:	4505                	li	a0,1
    2998:	00003097          	auipc	ra,0x3
    299c:	308080e7          	jalr	776(ra) # 5ca0 <sbrk>
    if(b != a){
    29a0:	04951c63          	bne	a0,s1,29f8 <sbrkbasic+0x122>
    *b = 1;
    29a4:	4785                	li	a5,1
    29a6:	00f48023          	sb	a5,0(s1)
    a = b + 1;
    29aa:	00148793          	addi	a5,s1,1
  for(i = 0; i < 5000; i++){
    29ae:	2905                	addiw	s2,s2,1
    29b0:	ff3912e3          	bne	s2,s3,2994 <sbrkbasic+0xbe>
  pid = fork();
    29b4:	00003097          	auipc	ra,0x3
    29b8:	25c080e7          	jalr	604(ra) # 5c10 <fork>
    29bc:	892a                	mv	s2,a0
  if(pid < 0){
    29be:	04054e63          	bltz	a0,2a1a <sbrkbasic+0x144>
  c = sbrk(1);
    29c2:	4505                	li	a0,1
    29c4:	00003097          	auipc	ra,0x3
    29c8:	2dc080e7          	jalr	732(ra) # 5ca0 <sbrk>
  c = sbrk(1);
    29cc:	4505                	li	a0,1
    29ce:	00003097          	auipc	ra,0x3
    29d2:	2d2080e7          	jalr	722(ra) # 5ca0 <sbrk>
  if(c != a + 1){
    29d6:	0489                	addi	s1,s1,2
    29d8:	04a48f63          	beq	s1,a0,2a36 <sbrkbasic+0x160>
    printf("%s: sbrk test failed post-fork\n", s);
    29dc:	85d2                	mv	a1,s4
    29de:	00004517          	auipc	a0,0x4
    29e2:	61250513          	addi	a0,a0,1554 # 6ff0 <malloc+0xf82>
    29e6:	00003097          	auipc	ra,0x3
    29ea:	5c8080e7          	jalr	1480(ra) # 5fae <printf>
    exit(1);
    29ee:	4505                	li	a0,1
    29f0:	00003097          	auipc	ra,0x3
    29f4:	228080e7          	jalr	552(ra) # 5c18 <exit>
      printf("%s: sbrk test failed %d %x %x\n", s, i, a, b);
    29f8:	872a                	mv	a4,a0
    29fa:	86a6                	mv	a3,s1
    29fc:	864a                	mv	a2,s2
    29fe:	85d2                	mv	a1,s4
    2a00:	00004517          	auipc	a0,0x4
    2a04:	5b050513          	addi	a0,a0,1456 # 6fb0 <malloc+0xf42>
    2a08:	00003097          	auipc	ra,0x3
    2a0c:	5a6080e7          	jalr	1446(ra) # 5fae <printf>
      exit(1);
    2a10:	4505                	li	a0,1
    2a12:	00003097          	auipc	ra,0x3
    2a16:	206080e7          	jalr	518(ra) # 5c18 <exit>
    printf("%s: sbrk test fork failed\n", s);
    2a1a:	85d2                	mv	a1,s4
    2a1c:	00004517          	auipc	a0,0x4
    2a20:	5b450513          	addi	a0,a0,1460 # 6fd0 <malloc+0xf62>
    2a24:	00003097          	auipc	ra,0x3
    2a28:	58a080e7          	jalr	1418(ra) # 5fae <printf>
    exit(1);
    2a2c:	4505                	li	a0,1
    2a2e:	00003097          	auipc	ra,0x3
    2a32:	1ea080e7          	jalr	490(ra) # 5c18 <exit>
  if(pid == 0)
    2a36:	00091763          	bnez	s2,2a44 <sbrkbasic+0x16e>
    exit(0);
    2a3a:	4501                	li	a0,0
    2a3c:	00003097          	auipc	ra,0x3
    2a40:	1dc080e7          	jalr	476(ra) # 5c18 <exit>
  wait(&xstatus);
    2a44:	fcc40513          	addi	a0,s0,-52
    2a48:	00003097          	auipc	ra,0x3
    2a4c:	1d8080e7          	jalr	472(ra) # 5c20 <wait>
  exit(xstatus);
    2a50:	fcc42503          	lw	a0,-52(s0)
    2a54:	00003097          	auipc	ra,0x3
    2a58:	1c4080e7          	jalr	452(ra) # 5c18 <exit>

0000000000002a5c <sbrkmuch>:
{
    2a5c:	7179                	addi	sp,sp,-48
    2a5e:	f406                	sd	ra,40(sp)
    2a60:	f022                	sd	s0,32(sp)
    2a62:	ec26                	sd	s1,24(sp)
    2a64:	e84a                	sd	s2,16(sp)
    2a66:	e44e                	sd	s3,8(sp)
    2a68:	e052                	sd	s4,0(sp)
    2a6a:	1800                	addi	s0,sp,48
    2a6c:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    2a6e:	4501                	li	a0,0
    2a70:	00003097          	auipc	ra,0x3
    2a74:	230080e7          	jalr	560(ra) # 5ca0 <sbrk>
    2a78:	892a                	mv	s2,a0
  a = sbrk(0);
    2a7a:	4501                	li	a0,0
    2a7c:	00003097          	auipc	ra,0x3
    2a80:	224080e7          	jalr	548(ra) # 5ca0 <sbrk>
    2a84:	84aa                	mv	s1,a0
  p = sbrk(amt);
    2a86:	06400537          	lui	a0,0x6400
    2a8a:	9d05                	subw	a0,a0,s1
    2a8c:	00003097          	auipc	ra,0x3
    2a90:	214080e7          	jalr	532(ra) # 5ca0 <sbrk>
  if (p != a) {
    2a94:	0ca49763          	bne	s1,a0,2b62 <sbrkmuch+0x106>
  char *eee = sbrk(0);
    2a98:	4501                	li	a0,0
    2a9a:	00003097          	auipc	ra,0x3
    2a9e:	206080e7          	jalr	518(ra) # 5ca0 <sbrk>
  for(char *pp = a; pp < eee; pp += 4096)
    2aa2:	00a4f963          	bgeu	s1,a0,2ab4 <sbrkmuch+0x58>
    *pp = 1;
    2aa6:	4705                	li	a4,1
  for(char *pp = a; pp < eee; pp += 4096)
    2aa8:	6785                	lui	a5,0x1
    *pp = 1;
    2aaa:	00e48023          	sb	a4,0(s1)
  for(char *pp = a; pp < eee; pp += 4096)
    2aae:	94be                	add	s1,s1,a5
    2ab0:	fea4ede3          	bltu	s1,a0,2aaa <sbrkmuch+0x4e>
  *lastaddr = 99;
    2ab4:	064007b7          	lui	a5,0x6400
    2ab8:	06300713          	li	a4,99
    2abc:	fee78fa3          	sb	a4,-1(a5) # 63fffff <base+0x63f0387>
  a = sbrk(0);
    2ac0:	4501                	li	a0,0
    2ac2:	00003097          	auipc	ra,0x3
    2ac6:	1de080e7          	jalr	478(ra) # 5ca0 <sbrk>
    2aca:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    2acc:	757d                	lui	a0,0xfffff
    2ace:	00003097          	auipc	ra,0x3
    2ad2:	1d2080e7          	jalr	466(ra) # 5ca0 <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    2ad6:	57fd                	li	a5,-1
    2ad8:	0af50363          	beq	a0,a5,2b7e <sbrkmuch+0x122>
  c = sbrk(0);
    2adc:	4501                	li	a0,0
    2ade:	00003097          	auipc	ra,0x3
    2ae2:	1c2080e7          	jalr	450(ra) # 5ca0 <sbrk>
  if(c != a - PGSIZE){
    2ae6:	77fd                	lui	a5,0xfffff
    2ae8:	97a6                	add	a5,a5,s1
    2aea:	0af51863          	bne	a0,a5,2b9a <sbrkmuch+0x13e>
  a = sbrk(0);
    2aee:	4501                	li	a0,0
    2af0:	00003097          	auipc	ra,0x3
    2af4:	1b0080e7          	jalr	432(ra) # 5ca0 <sbrk>
    2af8:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    2afa:	6505                	lui	a0,0x1
    2afc:	00003097          	auipc	ra,0x3
    2b00:	1a4080e7          	jalr	420(ra) # 5ca0 <sbrk>
    2b04:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    2b06:	0aa49a63          	bne	s1,a0,2bba <sbrkmuch+0x15e>
    2b0a:	4501                	li	a0,0
    2b0c:	00003097          	auipc	ra,0x3
    2b10:	194080e7          	jalr	404(ra) # 5ca0 <sbrk>
    2b14:	6785                	lui	a5,0x1
    2b16:	97a6                	add	a5,a5,s1
    2b18:	0af51163          	bne	a0,a5,2bba <sbrkmuch+0x15e>
  if(*lastaddr == 99){
    2b1c:	064007b7          	lui	a5,0x6400
    2b20:	fff7c703          	lbu	a4,-1(a5) # 63fffff <base+0x63f0387>
    2b24:	06300793          	li	a5,99
    2b28:	0af70963          	beq	a4,a5,2bda <sbrkmuch+0x17e>
  a = sbrk(0);
    2b2c:	4501                	li	a0,0
    2b2e:	00003097          	auipc	ra,0x3
    2b32:	172080e7          	jalr	370(ra) # 5ca0 <sbrk>
    2b36:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    2b38:	4501                	li	a0,0
    2b3a:	00003097          	auipc	ra,0x3
    2b3e:	166080e7          	jalr	358(ra) # 5ca0 <sbrk>
    2b42:	40a9053b          	subw	a0,s2,a0
    2b46:	00003097          	auipc	ra,0x3
    2b4a:	15a080e7          	jalr	346(ra) # 5ca0 <sbrk>
  if(c != a){
    2b4e:	0aa49463          	bne	s1,a0,2bf6 <sbrkmuch+0x19a>
}
    2b52:	70a2                	ld	ra,40(sp)
    2b54:	7402                	ld	s0,32(sp)
    2b56:	64e2                	ld	s1,24(sp)
    2b58:	6942                	ld	s2,16(sp)
    2b5a:	69a2                	ld	s3,8(sp)
    2b5c:	6a02                	ld	s4,0(sp)
    2b5e:	6145                	addi	sp,sp,48
    2b60:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    2b62:	85ce                	mv	a1,s3
    2b64:	00004517          	auipc	a0,0x4
    2b68:	4ac50513          	addi	a0,a0,1196 # 7010 <malloc+0xfa2>
    2b6c:	00003097          	auipc	ra,0x3
    2b70:	442080e7          	jalr	1090(ra) # 5fae <printf>
    exit(1);
    2b74:	4505                	li	a0,1
    2b76:	00003097          	auipc	ra,0x3
    2b7a:	0a2080e7          	jalr	162(ra) # 5c18 <exit>
    printf("%s: sbrk could not deallocate\n", s);
    2b7e:	85ce                	mv	a1,s3
    2b80:	00004517          	auipc	a0,0x4
    2b84:	4d850513          	addi	a0,a0,1240 # 7058 <malloc+0xfea>
    2b88:	00003097          	auipc	ra,0x3
    2b8c:	426080e7          	jalr	1062(ra) # 5fae <printf>
    exit(1);
    2b90:	4505                	li	a0,1
    2b92:	00003097          	auipc	ra,0x3
    2b96:	086080e7          	jalr	134(ra) # 5c18 <exit>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", s, a, c);
    2b9a:	86aa                	mv	a3,a0
    2b9c:	8626                	mv	a2,s1
    2b9e:	85ce                	mv	a1,s3
    2ba0:	00004517          	auipc	a0,0x4
    2ba4:	4d850513          	addi	a0,a0,1240 # 7078 <malloc+0x100a>
    2ba8:	00003097          	auipc	ra,0x3
    2bac:	406080e7          	jalr	1030(ra) # 5fae <printf>
    exit(1);
    2bb0:	4505                	li	a0,1
    2bb2:	00003097          	auipc	ra,0x3
    2bb6:	066080e7          	jalr	102(ra) # 5c18 <exit>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", s, a, c);
    2bba:	86d2                	mv	a3,s4
    2bbc:	8626                	mv	a2,s1
    2bbe:	85ce                	mv	a1,s3
    2bc0:	00004517          	auipc	a0,0x4
    2bc4:	4f850513          	addi	a0,a0,1272 # 70b8 <malloc+0x104a>
    2bc8:	00003097          	auipc	ra,0x3
    2bcc:	3e6080e7          	jalr	998(ra) # 5fae <printf>
    exit(1);
    2bd0:	4505                	li	a0,1
    2bd2:	00003097          	auipc	ra,0x3
    2bd6:	046080e7          	jalr	70(ra) # 5c18 <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    2bda:	85ce                	mv	a1,s3
    2bdc:	00004517          	auipc	a0,0x4
    2be0:	50c50513          	addi	a0,a0,1292 # 70e8 <malloc+0x107a>
    2be4:	00003097          	auipc	ra,0x3
    2be8:	3ca080e7          	jalr	970(ra) # 5fae <printf>
    exit(1);
    2bec:	4505                	li	a0,1
    2bee:	00003097          	auipc	ra,0x3
    2bf2:	02a080e7          	jalr	42(ra) # 5c18 <exit>
    printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
    2bf6:	86aa                	mv	a3,a0
    2bf8:	8626                	mv	a2,s1
    2bfa:	85ce                	mv	a1,s3
    2bfc:	00004517          	auipc	a0,0x4
    2c00:	52450513          	addi	a0,a0,1316 # 7120 <malloc+0x10b2>
    2c04:	00003097          	auipc	ra,0x3
    2c08:	3aa080e7          	jalr	938(ra) # 5fae <printf>
    exit(1);
    2c0c:	4505                	li	a0,1
    2c0e:	00003097          	auipc	ra,0x3
    2c12:	00a080e7          	jalr	10(ra) # 5c18 <exit>

0000000000002c16 <sbrkarg>:
{
    2c16:	7179                	addi	sp,sp,-48
    2c18:	f406                	sd	ra,40(sp)
    2c1a:	f022                	sd	s0,32(sp)
    2c1c:	ec26                	sd	s1,24(sp)
    2c1e:	e84a                	sd	s2,16(sp)
    2c20:	e44e                	sd	s3,8(sp)
    2c22:	1800                	addi	s0,sp,48
    2c24:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    2c26:	6505                	lui	a0,0x1
    2c28:	00003097          	auipc	ra,0x3
    2c2c:	078080e7          	jalr	120(ra) # 5ca0 <sbrk>
    2c30:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    2c32:	20100593          	li	a1,513
    2c36:	00004517          	auipc	a0,0x4
    2c3a:	51250513          	addi	a0,a0,1298 # 7148 <malloc+0x10da>
    2c3e:	00003097          	auipc	ra,0x3
    2c42:	01a080e7          	jalr	26(ra) # 5c58 <open>
    2c46:	84aa                	mv	s1,a0
  unlink("sbrk");
    2c48:	00004517          	auipc	a0,0x4
    2c4c:	50050513          	addi	a0,a0,1280 # 7148 <malloc+0x10da>
    2c50:	00003097          	auipc	ra,0x3
    2c54:	018080e7          	jalr	24(ra) # 5c68 <unlink>
  if(fd < 0)  {
    2c58:	0404c163          	bltz	s1,2c9a <sbrkarg+0x84>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    2c5c:	6605                	lui	a2,0x1
    2c5e:	85ca                	mv	a1,s2
    2c60:	8526                	mv	a0,s1
    2c62:	00003097          	auipc	ra,0x3
    2c66:	fd6080e7          	jalr	-42(ra) # 5c38 <write>
    2c6a:	04054663          	bltz	a0,2cb6 <sbrkarg+0xa0>
  close(fd);
    2c6e:	8526                	mv	a0,s1
    2c70:	00003097          	auipc	ra,0x3
    2c74:	fd0080e7          	jalr	-48(ra) # 5c40 <close>
  a = sbrk(PGSIZE);
    2c78:	6505                	lui	a0,0x1
    2c7a:	00003097          	auipc	ra,0x3
    2c7e:	026080e7          	jalr	38(ra) # 5ca0 <sbrk>
  if(pipe((int *) a) != 0){
    2c82:	00003097          	auipc	ra,0x3
    2c86:	fa6080e7          	jalr	-90(ra) # 5c28 <pipe>
    2c8a:	e521                	bnez	a0,2cd2 <sbrkarg+0xbc>
}
    2c8c:	70a2                	ld	ra,40(sp)
    2c8e:	7402                	ld	s0,32(sp)
    2c90:	64e2                	ld	s1,24(sp)
    2c92:	6942                	ld	s2,16(sp)
    2c94:	69a2                	ld	s3,8(sp)
    2c96:	6145                	addi	sp,sp,48
    2c98:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    2c9a:	85ce                	mv	a1,s3
    2c9c:	00004517          	auipc	a0,0x4
    2ca0:	4b450513          	addi	a0,a0,1204 # 7150 <malloc+0x10e2>
    2ca4:	00003097          	auipc	ra,0x3
    2ca8:	30a080e7          	jalr	778(ra) # 5fae <printf>
    exit(1);
    2cac:	4505                	li	a0,1
    2cae:	00003097          	auipc	ra,0x3
    2cb2:	f6a080e7          	jalr	-150(ra) # 5c18 <exit>
    printf("%s: write sbrk failed\n", s);
    2cb6:	85ce                	mv	a1,s3
    2cb8:	00004517          	auipc	a0,0x4
    2cbc:	4b050513          	addi	a0,a0,1200 # 7168 <malloc+0x10fa>
    2cc0:	00003097          	auipc	ra,0x3
    2cc4:	2ee080e7          	jalr	750(ra) # 5fae <printf>
    exit(1);
    2cc8:	4505                	li	a0,1
    2cca:	00003097          	auipc	ra,0x3
    2cce:	f4e080e7          	jalr	-178(ra) # 5c18 <exit>
    printf("%s: pipe() failed\n", s);
    2cd2:	85ce                	mv	a1,s3
    2cd4:	00004517          	auipc	a0,0x4
    2cd8:	e7450513          	addi	a0,a0,-396 # 6b48 <malloc+0xada>
    2cdc:	00003097          	auipc	ra,0x3
    2ce0:	2d2080e7          	jalr	722(ra) # 5fae <printf>
    exit(1);
    2ce4:	4505                	li	a0,1
    2ce6:	00003097          	auipc	ra,0x3
    2cea:	f32080e7          	jalr	-206(ra) # 5c18 <exit>

0000000000002cee <argptest>:
{
    2cee:	1101                	addi	sp,sp,-32
    2cf0:	ec06                	sd	ra,24(sp)
    2cf2:	e822                	sd	s0,16(sp)
    2cf4:	e426                	sd	s1,8(sp)
    2cf6:	e04a                	sd	s2,0(sp)
    2cf8:	1000                	addi	s0,sp,32
    2cfa:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    2cfc:	4581                	li	a1,0
    2cfe:	00004517          	auipc	a0,0x4
    2d02:	48250513          	addi	a0,a0,1154 # 7180 <malloc+0x1112>
    2d06:	00003097          	auipc	ra,0x3
    2d0a:	f52080e7          	jalr	-174(ra) # 5c58 <open>
  if (fd < 0) {
    2d0e:	02054b63          	bltz	a0,2d44 <argptest+0x56>
    2d12:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    2d14:	4501                	li	a0,0
    2d16:	00003097          	auipc	ra,0x3
    2d1a:	f8a080e7          	jalr	-118(ra) # 5ca0 <sbrk>
    2d1e:	567d                	li	a2,-1
    2d20:	fff50593          	addi	a1,a0,-1
    2d24:	8526                	mv	a0,s1
    2d26:	00003097          	auipc	ra,0x3
    2d2a:	f0a080e7          	jalr	-246(ra) # 5c30 <read>
  close(fd);
    2d2e:	8526                	mv	a0,s1
    2d30:	00003097          	auipc	ra,0x3
    2d34:	f10080e7          	jalr	-240(ra) # 5c40 <close>
}
    2d38:	60e2                	ld	ra,24(sp)
    2d3a:	6442                	ld	s0,16(sp)
    2d3c:	64a2                	ld	s1,8(sp)
    2d3e:	6902                	ld	s2,0(sp)
    2d40:	6105                	addi	sp,sp,32
    2d42:	8082                	ret
    printf("%s: open failed\n", s);
    2d44:	85ca                	mv	a1,s2
    2d46:	00004517          	auipc	a0,0x4
    2d4a:	d1250513          	addi	a0,a0,-750 # 6a58 <malloc+0x9ea>
    2d4e:	00003097          	auipc	ra,0x3
    2d52:	260080e7          	jalr	608(ra) # 5fae <printf>
    exit(1);
    2d56:	4505                	li	a0,1
    2d58:	00003097          	auipc	ra,0x3
    2d5c:	ec0080e7          	jalr	-320(ra) # 5c18 <exit>

0000000000002d60 <sbrkbugs>:
{
    2d60:	1141                	addi	sp,sp,-16
    2d62:	e406                	sd	ra,8(sp)
    2d64:	e022                	sd	s0,0(sp)
    2d66:	0800                	addi	s0,sp,16
  int pid = fork();
    2d68:	00003097          	auipc	ra,0x3
    2d6c:	ea8080e7          	jalr	-344(ra) # 5c10 <fork>
  if(pid < 0){
    2d70:	02054263          	bltz	a0,2d94 <sbrkbugs+0x34>
  if(pid == 0){
    2d74:	ed0d                	bnez	a0,2dae <sbrkbugs+0x4e>
    int sz = (uint64) sbrk(0);
    2d76:	00003097          	auipc	ra,0x3
    2d7a:	f2a080e7          	jalr	-214(ra) # 5ca0 <sbrk>
    sbrk(-sz);
    2d7e:	40a0053b          	negw	a0,a0
    2d82:	00003097          	auipc	ra,0x3
    2d86:	f1e080e7          	jalr	-226(ra) # 5ca0 <sbrk>
    exit(0);
    2d8a:	4501                	li	a0,0
    2d8c:	00003097          	auipc	ra,0x3
    2d90:	e8c080e7          	jalr	-372(ra) # 5c18 <exit>
    printf("fork failed\n");
    2d94:	00004517          	auipc	a0,0x4
    2d98:	0b450513          	addi	a0,a0,180 # 6e48 <malloc+0xdda>
    2d9c:	00003097          	auipc	ra,0x3
    2da0:	212080e7          	jalr	530(ra) # 5fae <printf>
    exit(1);
    2da4:	4505                	li	a0,1
    2da6:	00003097          	auipc	ra,0x3
    2daa:	e72080e7          	jalr	-398(ra) # 5c18 <exit>
  wait(0);
    2dae:	4501                	li	a0,0
    2db0:	00003097          	auipc	ra,0x3
    2db4:	e70080e7          	jalr	-400(ra) # 5c20 <wait>
  pid = fork();
    2db8:	00003097          	auipc	ra,0x3
    2dbc:	e58080e7          	jalr	-424(ra) # 5c10 <fork>
  if(pid < 0){
    2dc0:	02054563          	bltz	a0,2dea <sbrkbugs+0x8a>
  if(pid == 0){
    2dc4:	e121                	bnez	a0,2e04 <sbrkbugs+0xa4>
    int sz = (uint64) sbrk(0);
    2dc6:	00003097          	auipc	ra,0x3
    2dca:	eda080e7          	jalr	-294(ra) # 5ca0 <sbrk>
    sbrk(-(sz - 3500));
    2dce:	6785                	lui	a5,0x1
    2dd0:	dac7879b          	addiw	a5,a5,-596
    2dd4:	40a7853b          	subw	a0,a5,a0
    2dd8:	00003097          	auipc	ra,0x3
    2ddc:	ec8080e7          	jalr	-312(ra) # 5ca0 <sbrk>
    exit(0);
    2de0:	4501                	li	a0,0
    2de2:	00003097          	auipc	ra,0x3
    2de6:	e36080e7          	jalr	-458(ra) # 5c18 <exit>
    printf("fork failed\n");
    2dea:	00004517          	auipc	a0,0x4
    2dee:	05e50513          	addi	a0,a0,94 # 6e48 <malloc+0xdda>
    2df2:	00003097          	auipc	ra,0x3
    2df6:	1bc080e7          	jalr	444(ra) # 5fae <printf>
    exit(1);
    2dfa:	4505                	li	a0,1
    2dfc:	00003097          	auipc	ra,0x3
    2e00:	e1c080e7          	jalr	-484(ra) # 5c18 <exit>
  wait(0);
    2e04:	4501                	li	a0,0
    2e06:	00003097          	auipc	ra,0x3
    2e0a:	e1a080e7          	jalr	-486(ra) # 5c20 <wait>
  pid = fork();
    2e0e:	00003097          	auipc	ra,0x3
    2e12:	e02080e7          	jalr	-510(ra) # 5c10 <fork>
  if(pid < 0){
    2e16:	02054a63          	bltz	a0,2e4a <sbrkbugs+0xea>
  if(pid == 0){
    2e1a:	e529                	bnez	a0,2e64 <sbrkbugs+0x104>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    2e1c:	00003097          	auipc	ra,0x3
    2e20:	e84080e7          	jalr	-380(ra) # 5ca0 <sbrk>
    2e24:	67ad                	lui	a5,0xb
    2e26:	8007879b          	addiw	a5,a5,-2048
    2e2a:	40a7853b          	subw	a0,a5,a0
    2e2e:	00003097          	auipc	ra,0x3
    2e32:	e72080e7          	jalr	-398(ra) # 5ca0 <sbrk>
    sbrk(-10);
    2e36:	5559                	li	a0,-10
    2e38:	00003097          	auipc	ra,0x3
    2e3c:	e68080e7          	jalr	-408(ra) # 5ca0 <sbrk>
    exit(0);
    2e40:	4501                	li	a0,0
    2e42:	00003097          	auipc	ra,0x3
    2e46:	dd6080e7          	jalr	-554(ra) # 5c18 <exit>
    printf("fork failed\n");
    2e4a:	00004517          	auipc	a0,0x4
    2e4e:	ffe50513          	addi	a0,a0,-2 # 6e48 <malloc+0xdda>
    2e52:	00003097          	auipc	ra,0x3
    2e56:	15c080e7          	jalr	348(ra) # 5fae <printf>
    exit(1);
    2e5a:	4505                	li	a0,1
    2e5c:	00003097          	auipc	ra,0x3
    2e60:	dbc080e7          	jalr	-580(ra) # 5c18 <exit>
  wait(0);
    2e64:	4501                	li	a0,0
    2e66:	00003097          	auipc	ra,0x3
    2e6a:	dba080e7          	jalr	-582(ra) # 5c20 <wait>
  exit(0);
    2e6e:	4501                	li	a0,0
    2e70:	00003097          	auipc	ra,0x3
    2e74:	da8080e7          	jalr	-600(ra) # 5c18 <exit>

0000000000002e78 <sbrklast>:
{
    2e78:	7179                	addi	sp,sp,-48
    2e7a:	f406                	sd	ra,40(sp)
    2e7c:	f022                	sd	s0,32(sp)
    2e7e:	ec26                	sd	s1,24(sp)
    2e80:	e84a                	sd	s2,16(sp)
    2e82:	e44e                	sd	s3,8(sp)
    2e84:	e052                	sd	s4,0(sp)
    2e86:	1800                	addi	s0,sp,48
  uint64 top = (uint64) sbrk(0);
    2e88:	4501                	li	a0,0
    2e8a:	00003097          	auipc	ra,0x3
    2e8e:	e16080e7          	jalr	-490(ra) # 5ca0 <sbrk>
  if((top % 4096) != 0)
    2e92:	03451793          	slli	a5,a0,0x34
    2e96:	ebd9                	bnez	a5,2f2c <sbrklast+0xb4>
  sbrk(4096);
    2e98:	6505                	lui	a0,0x1
    2e9a:	00003097          	auipc	ra,0x3
    2e9e:	e06080e7          	jalr	-506(ra) # 5ca0 <sbrk>
  sbrk(10);
    2ea2:	4529                	li	a0,10
    2ea4:	00003097          	auipc	ra,0x3
    2ea8:	dfc080e7          	jalr	-516(ra) # 5ca0 <sbrk>
  sbrk(-20);
    2eac:	5531                	li	a0,-20
    2eae:	00003097          	auipc	ra,0x3
    2eb2:	df2080e7          	jalr	-526(ra) # 5ca0 <sbrk>
  top = (uint64) sbrk(0);
    2eb6:	4501                	li	a0,0
    2eb8:	00003097          	auipc	ra,0x3
    2ebc:	de8080e7          	jalr	-536(ra) # 5ca0 <sbrk>
    2ec0:	892a                	mv	s2,a0
  char *p = (char *) (top - 64);
    2ec2:	fc050493          	addi	s1,a0,-64 # fc0 <linktest+0xb8>
  p[0] = 'x';
    2ec6:	07800993          	li	s3,120
    2eca:	fd350023          	sb	s3,-64(a0)
  p[1] = '\0';
    2ece:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR|O_CREATE);
    2ed2:	20200593          	li	a1,514
    2ed6:	8526                	mv	a0,s1
    2ed8:	00003097          	auipc	ra,0x3
    2edc:	d80080e7          	jalr	-640(ra) # 5c58 <open>
    2ee0:	8a2a                	mv	s4,a0
  write(fd, p, 1);
    2ee2:	4605                	li	a2,1
    2ee4:	85a6                	mv	a1,s1
    2ee6:	00003097          	auipc	ra,0x3
    2eea:	d52080e7          	jalr	-686(ra) # 5c38 <write>
  close(fd);
    2eee:	8552                	mv	a0,s4
    2ef0:	00003097          	auipc	ra,0x3
    2ef4:	d50080e7          	jalr	-688(ra) # 5c40 <close>
  fd = open(p, O_RDWR);
    2ef8:	4589                	li	a1,2
    2efa:	8526                	mv	a0,s1
    2efc:	00003097          	auipc	ra,0x3
    2f00:	d5c080e7          	jalr	-676(ra) # 5c58 <open>
  p[0] = '\0';
    2f04:	fc090023          	sb	zero,-64(s2)
  read(fd, p, 1);
    2f08:	4605                	li	a2,1
    2f0a:	85a6                	mv	a1,s1
    2f0c:	00003097          	auipc	ra,0x3
    2f10:	d24080e7          	jalr	-732(ra) # 5c30 <read>
  if(p[0] != 'x')
    2f14:	fc094783          	lbu	a5,-64(s2)
    2f18:	03379463          	bne	a5,s3,2f40 <sbrklast+0xc8>
}
    2f1c:	70a2                	ld	ra,40(sp)
    2f1e:	7402                	ld	s0,32(sp)
    2f20:	64e2                	ld	s1,24(sp)
    2f22:	6942                	ld	s2,16(sp)
    2f24:	69a2                	ld	s3,8(sp)
    2f26:	6a02                	ld	s4,0(sp)
    2f28:	6145                	addi	sp,sp,48
    2f2a:	8082                	ret
    sbrk(4096 - (top % 4096));
    2f2c:	1552                	slli	a0,a0,0x34
    2f2e:	9151                	srli	a0,a0,0x34
    2f30:	6785                	lui	a5,0x1
    2f32:	40a7853b          	subw	a0,a5,a0
    2f36:	00003097          	auipc	ra,0x3
    2f3a:	d6a080e7          	jalr	-662(ra) # 5ca0 <sbrk>
    2f3e:	bfa9                	j	2e98 <sbrklast+0x20>
    exit(1);
    2f40:	4505                	li	a0,1
    2f42:	00003097          	auipc	ra,0x3
    2f46:	cd6080e7          	jalr	-810(ra) # 5c18 <exit>

0000000000002f4a <sbrk8000>:
{
    2f4a:	1141                	addi	sp,sp,-16
    2f4c:	e406                	sd	ra,8(sp)
    2f4e:	e022                	sd	s0,0(sp)
    2f50:	0800                	addi	s0,sp,16
  sbrk(0x80000004);
    2f52:	80000537          	lui	a0,0x80000
    2f56:	0511                	addi	a0,a0,4
    2f58:	00003097          	auipc	ra,0x3
    2f5c:	d48080e7          	jalr	-696(ra) # 5ca0 <sbrk>
  volatile char *top = sbrk(0);
    2f60:	4501                	li	a0,0
    2f62:	00003097          	auipc	ra,0x3
    2f66:	d3e080e7          	jalr	-706(ra) # 5ca0 <sbrk>
  *(top-1) = *(top-1) + 1;
    2f6a:	fff54783          	lbu	a5,-1(a0) # ffffffff7fffffff <base+0xffffffff7fff0387>
    2f6e:	2785                	addiw	a5,a5,1
    2f70:	0ff7f793          	andi	a5,a5,255
    2f74:	fef50fa3          	sb	a5,-1(a0)
}
    2f78:	60a2                	ld	ra,8(sp)
    2f7a:	6402                	ld	s0,0(sp)
    2f7c:	0141                	addi	sp,sp,16
    2f7e:	8082                	ret

0000000000002f80 <execout>:
{
    2f80:	715d                	addi	sp,sp,-80
    2f82:	e486                	sd	ra,72(sp)
    2f84:	e0a2                	sd	s0,64(sp)
    2f86:	fc26                	sd	s1,56(sp)
    2f88:	f84a                	sd	s2,48(sp)
    2f8a:	f44e                	sd	s3,40(sp)
    2f8c:	f052                	sd	s4,32(sp)
    2f8e:	0880                	addi	s0,sp,80
  for(int avail = 0; avail < 15; avail++){
    2f90:	4901                	li	s2,0
    2f92:	49bd                	li	s3,15
    int pid = fork();
    2f94:	00003097          	auipc	ra,0x3
    2f98:	c7c080e7          	jalr	-900(ra) # 5c10 <fork>
    2f9c:	84aa                	mv	s1,a0
    if(pid < 0){
    2f9e:	02054063          	bltz	a0,2fbe <execout+0x3e>
    } else if(pid == 0){
    2fa2:	c91d                	beqz	a0,2fd8 <execout+0x58>
      wait((int*)0);
    2fa4:	4501                	li	a0,0
    2fa6:	00003097          	auipc	ra,0x3
    2faa:	c7a080e7          	jalr	-902(ra) # 5c20 <wait>
  for(int avail = 0; avail < 15; avail++){
    2fae:	2905                	addiw	s2,s2,1
    2fb0:	ff3912e3          	bne	s2,s3,2f94 <execout+0x14>
  exit(0);
    2fb4:	4501                	li	a0,0
    2fb6:	00003097          	auipc	ra,0x3
    2fba:	c62080e7          	jalr	-926(ra) # 5c18 <exit>
      printf("fork failed\n");
    2fbe:	00004517          	auipc	a0,0x4
    2fc2:	e8a50513          	addi	a0,a0,-374 # 6e48 <malloc+0xdda>
    2fc6:	00003097          	auipc	ra,0x3
    2fca:	fe8080e7          	jalr	-24(ra) # 5fae <printf>
      exit(1);
    2fce:	4505                	li	a0,1
    2fd0:	00003097          	auipc	ra,0x3
    2fd4:	c48080e7          	jalr	-952(ra) # 5c18 <exit>
        if(a == 0xffffffffffffffffLL)
    2fd8:	59fd                	li	s3,-1
        *(char*)(a + 4096 - 1) = 1;
    2fda:	4a05                	li	s4,1
        uint64 a = (uint64) sbrk(4096);
    2fdc:	6505                	lui	a0,0x1
    2fde:	00003097          	auipc	ra,0x3
    2fe2:	cc2080e7          	jalr	-830(ra) # 5ca0 <sbrk>
        if(a == 0xffffffffffffffffLL)
    2fe6:	01350763          	beq	a0,s3,2ff4 <execout+0x74>
        *(char*)(a + 4096 - 1) = 1;
    2fea:	6785                	lui	a5,0x1
    2fec:	97aa                	add	a5,a5,a0
    2fee:	ff478fa3          	sb	s4,-1(a5) # fff <linktest+0xf7>
      while(1){
    2ff2:	b7ed                	j	2fdc <execout+0x5c>
      for(int i = 0; i < avail; i++)
    2ff4:	01205a63          	blez	s2,3008 <execout+0x88>
        sbrk(-4096);
    2ff8:	757d                	lui	a0,0xfffff
    2ffa:	00003097          	auipc	ra,0x3
    2ffe:	ca6080e7          	jalr	-858(ra) # 5ca0 <sbrk>
      for(int i = 0; i < avail; i++)
    3002:	2485                	addiw	s1,s1,1
    3004:	ff249ae3          	bne	s1,s2,2ff8 <execout+0x78>
      close(1);
    3008:	4505                	li	a0,1
    300a:	00003097          	auipc	ra,0x3
    300e:	c36080e7          	jalr	-970(ra) # 5c40 <close>
      char *args[] = { "echo", "x", 0 };
    3012:	00003517          	auipc	a0,0x3
    3016:	1a650513          	addi	a0,a0,422 # 61b8 <malloc+0x14a>
    301a:	faa43c23          	sd	a0,-72(s0)
    301e:	00003797          	auipc	a5,0x3
    3022:	20a78793          	addi	a5,a5,522 # 6228 <malloc+0x1ba>
    3026:	fcf43023          	sd	a5,-64(s0)
    302a:	fc043423          	sd	zero,-56(s0)
      exec("echo", args);
    302e:	fb840593          	addi	a1,s0,-72
    3032:	00003097          	auipc	ra,0x3
    3036:	c1e080e7          	jalr	-994(ra) # 5c50 <exec>
      exit(0);
    303a:	4501                	li	a0,0
    303c:	00003097          	auipc	ra,0x3
    3040:	bdc080e7          	jalr	-1060(ra) # 5c18 <exit>

0000000000003044 <fourteen>:
{
    3044:	1101                	addi	sp,sp,-32
    3046:	ec06                	sd	ra,24(sp)
    3048:	e822                	sd	s0,16(sp)
    304a:	e426                	sd	s1,8(sp)
    304c:	1000                	addi	s0,sp,32
    304e:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    3050:	00004517          	auipc	a0,0x4
    3054:	30850513          	addi	a0,a0,776 # 7358 <malloc+0x12ea>
    3058:	00003097          	auipc	ra,0x3
    305c:	c28080e7          	jalr	-984(ra) # 5c80 <mkdir>
    3060:	e165                	bnez	a0,3140 <fourteen+0xfc>
  if(mkdir("12345678901234/123456789012345") != 0){
    3062:	00004517          	auipc	a0,0x4
    3066:	14e50513          	addi	a0,a0,334 # 71b0 <malloc+0x1142>
    306a:	00003097          	auipc	ra,0x3
    306e:	c16080e7          	jalr	-1002(ra) # 5c80 <mkdir>
    3072:	e56d                	bnez	a0,315c <fourteen+0x118>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    3074:	20000593          	li	a1,512
    3078:	00004517          	auipc	a0,0x4
    307c:	19050513          	addi	a0,a0,400 # 7208 <malloc+0x119a>
    3080:	00003097          	auipc	ra,0x3
    3084:	bd8080e7          	jalr	-1064(ra) # 5c58 <open>
  if(fd < 0){
    3088:	0e054863          	bltz	a0,3178 <fourteen+0x134>
  close(fd);
    308c:	00003097          	auipc	ra,0x3
    3090:	bb4080e7          	jalr	-1100(ra) # 5c40 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    3094:	4581                	li	a1,0
    3096:	00004517          	auipc	a0,0x4
    309a:	1ea50513          	addi	a0,a0,490 # 7280 <malloc+0x1212>
    309e:	00003097          	auipc	ra,0x3
    30a2:	bba080e7          	jalr	-1094(ra) # 5c58 <open>
  if(fd < 0){
    30a6:	0e054763          	bltz	a0,3194 <fourteen+0x150>
  close(fd);
    30aa:	00003097          	auipc	ra,0x3
    30ae:	b96080e7          	jalr	-1130(ra) # 5c40 <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    30b2:	00004517          	auipc	a0,0x4
    30b6:	23e50513          	addi	a0,a0,574 # 72f0 <malloc+0x1282>
    30ba:	00003097          	auipc	ra,0x3
    30be:	bc6080e7          	jalr	-1082(ra) # 5c80 <mkdir>
    30c2:	c57d                	beqz	a0,31b0 <fourteen+0x16c>
  if(mkdir("123456789012345/12345678901234") == 0){
    30c4:	00004517          	auipc	a0,0x4
    30c8:	28450513          	addi	a0,a0,644 # 7348 <malloc+0x12da>
    30cc:	00003097          	auipc	ra,0x3
    30d0:	bb4080e7          	jalr	-1100(ra) # 5c80 <mkdir>
    30d4:	cd65                	beqz	a0,31cc <fourteen+0x188>
  unlink("123456789012345/12345678901234");
    30d6:	00004517          	auipc	a0,0x4
    30da:	27250513          	addi	a0,a0,626 # 7348 <malloc+0x12da>
    30de:	00003097          	auipc	ra,0x3
    30e2:	b8a080e7          	jalr	-1142(ra) # 5c68 <unlink>
  unlink("12345678901234/12345678901234");
    30e6:	00004517          	auipc	a0,0x4
    30ea:	20a50513          	addi	a0,a0,522 # 72f0 <malloc+0x1282>
    30ee:	00003097          	auipc	ra,0x3
    30f2:	b7a080e7          	jalr	-1158(ra) # 5c68 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    30f6:	00004517          	auipc	a0,0x4
    30fa:	18a50513          	addi	a0,a0,394 # 7280 <malloc+0x1212>
    30fe:	00003097          	auipc	ra,0x3
    3102:	b6a080e7          	jalr	-1174(ra) # 5c68 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    3106:	00004517          	auipc	a0,0x4
    310a:	10250513          	addi	a0,a0,258 # 7208 <malloc+0x119a>
    310e:	00003097          	auipc	ra,0x3
    3112:	b5a080e7          	jalr	-1190(ra) # 5c68 <unlink>
  unlink("12345678901234/123456789012345");
    3116:	00004517          	auipc	a0,0x4
    311a:	09a50513          	addi	a0,a0,154 # 71b0 <malloc+0x1142>
    311e:	00003097          	auipc	ra,0x3
    3122:	b4a080e7          	jalr	-1206(ra) # 5c68 <unlink>
  unlink("12345678901234");
    3126:	00004517          	auipc	a0,0x4
    312a:	23250513          	addi	a0,a0,562 # 7358 <malloc+0x12ea>
    312e:	00003097          	auipc	ra,0x3
    3132:	b3a080e7          	jalr	-1222(ra) # 5c68 <unlink>
}
    3136:	60e2                	ld	ra,24(sp)
    3138:	6442                	ld	s0,16(sp)
    313a:	64a2                	ld	s1,8(sp)
    313c:	6105                	addi	sp,sp,32
    313e:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    3140:	85a6                	mv	a1,s1
    3142:	00004517          	auipc	a0,0x4
    3146:	04650513          	addi	a0,a0,70 # 7188 <malloc+0x111a>
    314a:	00003097          	auipc	ra,0x3
    314e:	e64080e7          	jalr	-412(ra) # 5fae <printf>
    exit(1);
    3152:	4505                	li	a0,1
    3154:	00003097          	auipc	ra,0x3
    3158:	ac4080e7          	jalr	-1340(ra) # 5c18 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    315c:	85a6                	mv	a1,s1
    315e:	00004517          	auipc	a0,0x4
    3162:	07250513          	addi	a0,a0,114 # 71d0 <malloc+0x1162>
    3166:	00003097          	auipc	ra,0x3
    316a:	e48080e7          	jalr	-440(ra) # 5fae <printf>
    exit(1);
    316e:	4505                	li	a0,1
    3170:	00003097          	auipc	ra,0x3
    3174:	aa8080e7          	jalr	-1368(ra) # 5c18 <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    3178:	85a6                	mv	a1,s1
    317a:	00004517          	auipc	a0,0x4
    317e:	0be50513          	addi	a0,a0,190 # 7238 <malloc+0x11ca>
    3182:	00003097          	auipc	ra,0x3
    3186:	e2c080e7          	jalr	-468(ra) # 5fae <printf>
    exit(1);
    318a:	4505                	li	a0,1
    318c:	00003097          	auipc	ra,0x3
    3190:	a8c080e7          	jalr	-1396(ra) # 5c18 <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    3194:	85a6                	mv	a1,s1
    3196:	00004517          	auipc	a0,0x4
    319a:	11a50513          	addi	a0,a0,282 # 72b0 <malloc+0x1242>
    319e:	00003097          	auipc	ra,0x3
    31a2:	e10080e7          	jalr	-496(ra) # 5fae <printf>
    exit(1);
    31a6:	4505                	li	a0,1
    31a8:	00003097          	auipc	ra,0x3
    31ac:	a70080e7          	jalr	-1424(ra) # 5c18 <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    31b0:	85a6                	mv	a1,s1
    31b2:	00004517          	auipc	a0,0x4
    31b6:	15e50513          	addi	a0,a0,350 # 7310 <malloc+0x12a2>
    31ba:	00003097          	auipc	ra,0x3
    31be:	df4080e7          	jalr	-524(ra) # 5fae <printf>
    exit(1);
    31c2:	4505                	li	a0,1
    31c4:	00003097          	auipc	ra,0x3
    31c8:	a54080e7          	jalr	-1452(ra) # 5c18 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    31cc:	85a6                	mv	a1,s1
    31ce:	00004517          	auipc	a0,0x4
    31d2:	19a50513          	addi	a0,a0,410 # 7368 <malloc+0x12fa>
    31d6:	00003097          	auipc	ra,0x3
    31da:	dd8080e7          	jalr	-552(ra) # 5fae <printf>
    exit(1);
    31de:	4505                	li	a0,1
    31e0:	00003097          	auipc	ra,0x3
    31e4:	a38080e7          	jalr	-1480(ra) # 5c18 <exit>

00000000000031e8 <diskfull>:
{
    31e8:	b9010113          	addi	sp,sp,-1136
    31ec:	46113423          	sd	ra,1128(sp)
    31f0:	46813023          	sd	s0,1120(sp)
    31f4:	44913c23          	sd	s1,1112(sp)
    31f8:	45213823          	sd	s2,1104(sp)
    31fc:	45313423          	sd	s3,1096(sp)
    3200:	45413023          	sd	s4,1088(sp)
    3204:	43513c23          	sd	s5,1080(sp)
    3208:	43613823          	sd	s6,1072(sp)
    320c:	43713423          	sd	s7,1064(sp)
    3210:	43813023          	sd	s8,1056(sp)
    3214:	47010413          	addi	s0,sp,1136
    3218:	8c2a                	mv	s8,a0
  unlink("diskfulldir");
    321a:	00004517          	auipc	a0,0x4
    321e:	18650513          	addi	a0,a0,390 # 73a0 <malloc+0x1332>
    3222:	00003097          	auipc	ra,0x3
    3226:	a46080e7          	jalr	-1466(ra) # 5c68 <unlink>
  for(fi = 0; done == 0; fi++){
    322a:	4a01                	li	s4,0
    name[0] = 'b';
    322c:	06200b13          	li	s6,98
    name[1] = 'i';
    3230:	06900a93          	li	s5,105
    name[2] = 'g';
    3234:	06700993          	li	s3,103
    3238:	10c00b93          	li	s7,268
    323c:	aabd                	j	33ba <diskfull+0x1d2>
      printf("%s: could not create file %s\n", s, name);
    323e:	b9040613          	addi	a2,s0,-1136
    3242:	85e2                	mv	a1,s8
    3244:	00004517          	auipc	a0,0x4
    3248:	16c50513          	addi	a0,a0,364 # 73b0 <malloc+0x1342>
    324c:	00003097          	auipc	ra,0x3
    3250:	d62080e7          	jalr	-670(ra) # 5fae <printf>
      break;
    3254:	a821                	j	326c <diskfull+0x84>
        close(fd);
    3256:	854a                	mv	a0,s2
    3258:	00003097          	auipc	ra,0x3
    325c:	9e8080e7          	jalr	-1560(ra) # 5c40 <close>
    close(fd);
    3260:	854a                	mv	a0,s2
    3262:	00003097          	auipc	ra,0x3
    3266:	9de080e7          	jalr	-1570(ra) # 5c40 <close>
  for(fi = 0; done == 0; fi++){
    326a:	2a05                	addiw	s4,s4,1
    326c:	4481                	li	s1,0
    name[0] = 'z';
    326e:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    3272:	08000993          	li	s3,128
    name[0] = 'z';
    3276:	bb240823          	sb	s2,-1104(s0)
    name[1] = 'z';
    327a:	bb2408a3          	sb	s2,-1103(s0)
    name[2] = '0' + (i / 32);
    327e:	41f4d79b          	sraiw	a5,s1,0x1f
    3282:	01b7d71b          	srliw	a4,a5,0x1b
    3286:	009707bb          	addw	a5,a4,s1
    328a:	4057d69b          	sraiw	a3,a5,0x5
    328e:	0306869b          	addiw	a3,a3,48
    3292:	bad40923          	sb	a3,-1102(s0)
    name[3] = '0' + (i % 32);
    3296:	8bfd                	andi	a5,a5,31
    3298:	9f99                	subw	a5,a5,a4
    329a:	0307879b          	addiw	a5,a5,48
    329e:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    32a2:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    32a6:	bb040513          	addi	a0,s0,-1104
    32aa:	00003097          	auipc	ra,0x3
    32ae:	9be080e7          	jalr	-1602(ra) # 5c68 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    32b2:	60200593          	li	a1,1538
    32b6:	bb040513          	addi	a0,s0,-1104
    32ba:	00003097          	auipc	ra,0x3
    32be:	99e080e7          	jalr	-1634(ra) # 5c58 <open>
    if(fd < 0)
    32c2:	00054963          	bltz	a0,32d4 <diskfull+0xec>
    close(fd);
    32c6:	00003097          	auipc	ra,0x3
    32ca:	97a080e7          	jalr	-1670(ra) # 5c40 <close>
  for(int i = 0; i < nzz; i++){
    32ce:	2485                	addiw	s1,s1,1
    32d0:	fb3493e3          	bne	s1,s3,3276 <diskfull+0x8e>
  if(mkdir("diskfulldir") == 0)
    32d4:	00004517          	auipc	a0,0x4
    32d8:	0cc50513          	addi	a0,a0,204 # 73a0 <malloc+0x1332>
    32dc:	00003097          	auipc	ra,0x3
    32e0:	9a4080e7          	jalr	-1628(ra) # 5c80 <mkdir>
    32e4:	12050963          	beqz	a0,3416 <diskfull+0x22e>
  unlink("diskfulldir");
    32e8:	00004517          	auipc	a0,0x4
    32ec:	0b850513          	addi	a0,a0,184 # 73a0 <malloc+0x1332>
    32f0:	00003097          	auipc	ra,0x3
    32f4:	978080e7          	jalr	-1672(ra) # 5c68 <unlink>
  for(int i = 0; i < nzz; i++){
    32f8:	4481                	li	s1,0
    name[0] = 'z';
    32fa:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    32fe:	08000993          	li	s3,128
    name[0] = 'z';
    3302:	bb240823          	sb	s2,-1104(s0)
    name[1] = 'z';
    3306:	bb2408a3          	sb	s2,-1103(s0)
    name[2] = '0' + (i / 32);
    330a:	41f4d79b          	sraiw	a5,s1,0x1f
    330e:	01b7d71b          	srliw	a4,a5,0x1b
    3312:	009707bb          	addw	a5,a4,s1
    3316:	4057d69b          	sraiw	a3,a5,0x5
    331a:	0306869b          	addiw	a3,a3,48
    331e:	bad40923          	sb	a3,-1102(s0)
    name[3] = '0' + (i % 32);
    3322:	8bfd                	andi	a5,a5,31
    3324:	9f99                	subw	a5,a5,a4
    3326:	0307879b          	addiw	a5,a5,48
    332a:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    332e:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    3332:	bb040513          	addi	a0,s0,-1104
    3336:	00003097          	auipc	ra,0x3
    333a:	932080e7          	jalr	-1742(ra) # 5c68 <unlink>
  for(int i = 0; i < nzz; i++){
    333e:	2485                	addiw	s1,s1,1
    3340:	fd3491e3          	bne	s1,s3,3302 <diskfull+0x11a>
  for(int i = 0; i < fi; i++){
    3344:	03405e63          	blez	s4,3380 <diskfull+0x198>
    3348:	4481                	li	s1,0
    name[0] = 'b';
    334a:	06200a93          	li	s5,98
    name[1] = 'i';
    334e:	06900993          	li	s3,105
    name[2] = 'g';
    3352:	06700913          	li	s2,103
    name[0] = 'b';
    3356:	bb540823          	sb	s5,-1104(s0)
    name[1] = 'i';
    335a:	bb3408a3          	sb	s3,-1103(s0)
    name[2] = 'g';
    335e:	bb240923          	sb	s2,-1102(s0)
    name[3] = '0' + i;
    3362:	0304879b          	addiw	a5,s1,48
    3366:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    336a:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    336e:	bb040513          	addi	a0,s0,-1104
    3372:	00003097          	auipc	ra,0x3
    3376:	8f6080e7          	jalr	-1802(ra) # 5c68 <unlink>
  for(int i = 0; i < fi; i++){
    337a:	2485                	addiw	s1,s1,1
    337c:	fd449de3          	bne	s1,s4,3356 <diskfull+0x16e>
}
    3380:	46813083          	ld	ra,1128(sp)
    3384:	46013403          	ld	s0,1120(sp)
    3388:	45813483          	ld	s1,1112(sp)
    338c:	45013903          	ld	s2,1104(sp)
    3390:	44813983          	ld	s3,1096(sp)
    3394:	44013a03          	ld	s4,1088(sp)
    3398:	43813a83          	ld	s5,1080(sp)
    339c:	43013b03          	ld	s6,1072(sp)
    33a0:	42813b83          	ld	s7,1064(sp)
    33a4:	42013c03          	ld	s8,1056(sp)
    33a8:	47010113          	addi	sp,sp,1136
    33ac:	8082                	ret
    close(fd);
    33ae:	854a                	mv	a0,s2
    33b0:	00003097          	auipc	ra,0x3
    33b4:	890080e7          	jalr	-1904(ra) # 5c40 <close>
  for(fi = 0; done == 0; fi++){
    33b8:	2a05                	addiw	s4,s4,1
    name[0] = 'b';
    33ba:	b9640823          	sb	s6,-1136(s0)
    name[1] = 'i';
    33be:	b95408a3          	sb	s5,-1135(s0)
    name[2] = 'g';
    33c2:	b9340923          	sb	s3,-1134(s0)
    name[3] = '0' + fi;
    33c6:	030a079b          	addiw	a5,s4,48
    33ca:	b8f409a3          	sb	a5,-1133(s0)
    name[4] = '\0';
    33ce:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    33d2:	b9040513          	addi	a0,s0,-1136
    33d6:	00003097          	auipc	ra,0x3
    33da:	892080e7          	jalr	-1902(ra) # 5c68 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    33de:	60200593          	li	a1,1538
    33e2:	b9040513          	addi	a0,s0,-1136
    33e6:	00003097          	auipc	ra,0x3
    33ea:	872080e7          	jalr	-1934(ra) # 5c58 <open>
    33ee:	892a                	mv	s2,a0
    if(fd < 0){
    33f0:	e40547e3          	bltz	a0,323e <diskfull+0x56>
    33f4:	84de                	mv	s1,s7
      if(write(fd, buf, BSIZE) != BSIZE){
    33f6:	40000613          	li	a2,1024
    33fa:	bb040593          	addi	a1,s0,-1104
    33fe:	854a                	mv	a0,s2
    3400:	00003097          	auipc	ra,0x3
    3404:	838080e7          	jalr	-1992(ra) # 5c38 <write>
    3408:	40000793          	li	a5,1024
    340c:	e4f515e3          	bne	a0,a5,3256 <diskfull+0x6e>
    3410:	34fd                	addiw	s1,s1,-1
    for(int i = 0; i < MAXFILE; i++){
    3412:	f0f5                	bnez	s1,33f6 <diskfull+0x20e>
    3414:	bf69                	j	33ae <diskfull+0x1c6>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n");
    3416:	00004517          	auipc	a0,0x4
    341a:	fba50513          	addi	a0,a0,-70 # 73d0 <malloc+0x1362>
    341e:	00003097          	auipc	ra,0x3
    3422:	b90080e7          	jalr	-1136(ra) # 5fae <printf>
    3426:	b5c9                	j	32e8 <diskfull+0x100>

0000000000003428 <iputtest>:
{
    3428:	1101                	addi	sp,sp,-32
    342a:	ec06                	sd	ra,24(sp)
    342c:	e822                	sd	s0,16(sp)
    342e:	e426                	sd	s1,8(sp)
    3430:	1000                	addi	s0,sp,32
    3432:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    3434:	00004517          	auipc	a0,0x4
    3438:	fcc50513          	addi	a0,a0,-52 # 7400 <malloc+0x1392>
    343c:	00003097          	auipc	ra,0x3
    3440:	844080e7          	jalr	-1980(ra) # 5c80 <mkdir>
    3444:	04054563          	bltz	a0,348e <iputtest+0x66>
  if(chdir("iputdir") < 0){
    3448:	00004517          	auipc	a0,0x4
    344c:	fb850513          	addi	a0,a0,-72 # 7400 <malloc+0x1392>
    3450:	00003097          	auipc	ra,0x3
    3454:	838080e7          	jalr	-1992(ra) # 5c88 <chdir>
    3458:	04054963          	bltz	a0,34aa <iputtest+0x82>
  if(unlink("../iputdir") < 0){
    345c:	00004517          	auipc	a0,0x4
    3460:	fe450513          	addi	a0,a0,-28 # 7440 <malloc+0x13d2>
    3464:	00003097          	auipc	ra,0x3
    3468:	804080e7          	jalr	-2044(ra) # 5c68 <unlink>
    346c:	04054d63          	bltz	a0,34c6 <iputtest+0x9e>
  if(chdir("/") < 0){
    3470:	00004517          	auipc	a0,0x4
    3474:	00050513          	mv	a0,a0
    3478:	00003097          	auipc	ra,0x3
    347c:	810080e7          	jalr	-2032(ra) # 5c88 <chdir>
    3480:	06054163          	bltz	a0,34e2 <iputtest+0xba>
}
    3484:	60e2                	ld	ra,24(sp)
    3486:	6442                	ld	s0,16(sp)
    3488:	64a2                	ld	s1,8(sp)
    348a:	6105                	addi	sp,sp,32
    348c:	8082                	ret
    printf("%s: mkdir failed\n", s);
    348e:	85a6                	mv	a1,s1
    3490:	00004517          	auipc	a0,0x4
    3494:	f7850513          	addi	a0,a0,-136 # 7408 <malloc+0x139a>
    3498:	00003097          	auipc	ra,0x3
    349c:	b16080e7          	jalr	-1258(ra) # 5fae <printf>
    exit(1);
    34a0:	4505                	li	a0,1
    34a2:	00002097          	auipc	ra,0x2
    34a6:	776080e7          	jalr	1910(ra) # 5c18 <exit>
    printf("%s: chdir iputdir failed\n", s);
    34aa:	85a6                	mv	a1,s1
    34ac:	00004517          	auipc	a0,0x4
    34b0:	f7450513          	addi	a0,a0,-140 # 7420 <malloc+0x13b2>
    34b4:	00003097          	auipc	ra,0x3
    34b8:	afa080e7          	jalr	-1286(ra) # 5fae <printf>
    exit(1);
    34bc:	4505                	li	a0,1
    34be:	00002097          	auipc	ra,0x2
    34c2:	75a080e7          	jalr	1882(ra) # 5c18 <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    34c6:	85a6                	mv	a1,s1
    34c8:	00004517          	auipc	a0,0x4
    34cc:	f8850513          	addi	a0,a0,-120 # 7450 <malloc+0x13e2>
    34d0:	00003097          	auipc	ra,0x3
    34d4:	ade080e7          	jalr	-1314(ra) # 5fae <printf>
    exit(1);
    34d8:	4505                	li	a0,1
    34da:	00002097          	auipc	ra,0x2
    34de:	73e080e7          	jalr	1854(ra) # 5c18 <exit>
    printf("%s: chdir / failed\n", s);
    34e2:	85a6                	mv	a1,s1
    34e4:	00004517          	auipc	a0,0x4
    34e8:	f9450513          	addi	a0,a0,-108 # 7478 <malloc+0x140a>
    34ec:	00003097          	auipc	ra,0x3
    34f0:	ac2080e7          	jalr	-1342(ra) # 5fae <printf>
    exit(1);
    34f4:	4505                	li	a0,1
    34f6:	00002097          	auipc	ra,0x2
    34fa:	722080e7          	jalr	1826(ra) # 5c18 <exit>

00000000000034fe <exitiputtest>:
{
    34fe:	7179                	addi	sp,sp,-48
    3500:	f406                	sd	ra,40(sp)
    3502:	f022                	sd	s0,32(sp)
    3504:	ec26                	sd	s1,24(sp)
    3506:	1800                	addi	s0,sp,48
    3508:	84aa                	mv	s1,a0
  pid = fork();
    350a:	00002097          	auipc	ra,0x2
    350e:	706080e7          	jalr	1798(ra) # 5c10 <fork>
  if(pid < 0){
    3512:	04054663          	bltz	a0,355e <exitiputtest+0x60>
  if(pid == 0){
    3516:	ed45                	bnez	a0,35ce <exitiputtest+0xd0>
    if(mkdir("iputdir") < 0){
    3518:	00004517          	auipc	a0,0x4
    351c:	ee850513          	addi	a0,a0,-280 # 7400 <malloc+0x1392>
    3520:	00002097          	auipc	ra,0x2
    3524:	760080e7          	jalr	1888(ra) # 5c80 <mkdir>
    3528:	04054963          	bltz	a0,357a <exitiputtest+0x7c>
    if(chdir("iputdir") < 0){
    352c:	00004517          	auipc	a0,0x4
    3530:	ed450513          	addi	a0,a0,-300 # 7400 <malloc+0x1392>
    3534:	00002097          	auipc	ra,0x2
    3538:	754080e7          	jalr	1876(ra) # 5c88 <chdir>
    353c:	04054d63          	bltz	a0,3596 <exitiputtest+0x98>
    if(unlink("../iputdir") < 0){
    3540:	00004517          	auipc	a0,0x4
    3544:	f0050513          	addi	a0,a0,-256 # 7440 <malloc+0x13d2>
    3548:	00002097          	auipc	ra,0x2
    354c:	720080e7          	jalr	1824(ra) # 5c68 <unlink>
    3550:	06054163          	bltz	a0,35b2 <exitiputtest+0xb4>
    exit(0);
    3554:	4501                	li	a0,0
    3556:	00002097          	auipc	ra,0x2
    355a:	6c2080e7          	jalr	1730(ra) # 5c18 <exit>
    printf("%s: fork failed\n", s);
    355e:	85a6                	mv	a1,s1
    3560:	00003517          	auipc	a0,0x3
    3564:	4e050513          	addi	a0,a0,1248 # 6a40 <malloc+0x9d2>
    3568:	00003097          	auipc	ra,0x3
    356c:	a46080e7          	jalr	-1466(ra) # 5fae <printf>
    exit(1);
    3570:	4505                	li	a0,1
    3572:	00002097          	auipc	ra,0x2
    3576:	6a6080e7          	jalr	1702(ra) # 5c18 <exit>
      printf("%s: mkdir failed\n", s);
    357a:	85a6                	mv	a1,s1
    357c:	00004517          	auipc	a0,0x4
    3580:	e8c50513          	addi	a0,a0,-372 # 7408 <malloc+0x139a>
    3584:	00003097          	auipc	ra,0x3
    3588:	a2a080e7          	jalr	-1494(ra) # 5fae <printf>
      exit(1);
    358c:	4505                	li	a0,1
    358e:	00002097          	auipc	ra,0x2
    3592:	68a080e7          	jalr	1674(ra) # 5c18 <exit>
      printf("%s: child chdir failed\n", s);
    3596:	85a6                	mv	a1,s1
    3598:	00004517          	auipc	a0,0x4
    359c:	ef850513          	addi	a0,a0,-264 # 7490 <malloc+0x1422>
    35a0:	00003097          	auipc	ra,0x3
    35a4:	a0e080e7          	jalr	-1522(ra) # 5fae <printf>
      exit(1);
    35a8:	4505                	li	a0,1
    35aa:	00002097          	auipc	ra,0x2
    35ae:	66e080e7          	jalr	1646(ra) # 5c18 <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    35b2:	85a6                	mv	a1,s1
    35b4:	00004517          	auipc	a0,0x4
    35b8:	e9c50513          	addi	a0,a0,-356 # 7450 <malloc+0x13e2>
    35bc:	00003097          	auipc	ra,0x3
    35c0:	9f2080e7          	jalr	-1550(ra) # 5fae <printf>
      exit(1);
    35c4:	4505                	li	a0,1
    35c6:	00002097          	auipc	ra,0x2
    35ca:	652080e7          	jalr	1618(ra) # 5c18 <exit>
  wait(&xstatus);
    35ce:	fdc40513          	addi	a0,s0,-36
    35d2:	00002097          	auipc	ra,0x2
    35d6:	64e080e7          	jalr	1614(ra) # 5c20 <wait>
  exit(xstatus);
    35da:	fdc42503          	lw	a0,-36(s0)
    35de:	00002097          	auipc	ra,0x2
    35e2:	63a080e7          	jalr	1594(ra) # 5c18 <exit>

00000000000035e6 <dirtest>:
{
    35e6:	1101                	addi	sp,sp,-32
    35e8:	ec06                	sd	ra,24(sp)
    35ea:	e822                	sd	s0,16(sp)
    35ec:	e426                	sd	s1,8(sp)
    35ee:	1000                	addi	s0,sp,32
    35f0:	84aa                	mv	s1,a0
  if(mkdir("dir0") < 0){
    35f2:	00004517          	auipc	a0,0x4
    35f6:	eb650513          	addi	a0,a0,-330 # 74a8 <malloc+0x143a>
    35fa:	00002097          	auipc	ra,0x2
    35fe:	686080e7          	jalr	1670(ra) # 5c80 <mkdir>
    3602:	04054563          	bltz	a0,364c <dirtest+0x66>
  if(chdir("dir0") < 0){
    3606:	00004517          	auipc	a0,0x4
    360a:	ea250513          	addi	a0,a0,-350 # 74a8 <malloc+0x143a>
    360e:	00002097          	auipc	ra,0x2
    3612:	67a080e7          	jalr	1658(ra) # 5c88 <chdir>
    3616:	04054963          	bltz	a0,3668 <dirtest+0x82>
  if(chdir("..") < 0){
    361a:	00004517          	auipc	a0,0x4
    361e:	eae50513          	addi	a0,a0,-338 # 74c8 <malloc+0x145a>
    3622:	00002097          	auipc	ra,0x2
    3626:	666080e7          	jalr	1638(ra) # 5c88 <chdir>
    362a:	04054d63          	bltz	a0,3684 <dirtest+0x9e>
  if(unlink("dir0") < 0){
    362e:	00004517          	auipc	a0,0x4
    3632:	e7a50513          	addi	a0,a0,-390 # 74a8 <malloc+0x143a>
    3636:	00002097          	auipc	ra,0x2
    363a:	632080e7          	jalr	1586(ra) # 5c68 <unlink>
    363e:	06054163          	bltz	a0,36a0 <dirtest+0xba>
}
    3642:	60e2                	ld	ra,24(sp)
    3644:	6442                	ld	s0,16(sp)
    3646:	64a2                	ld	s1,8(sp)
    3648:	6105                	addi	sp,sp,32
    364a:	8082                	ret
    printf("%s: mkdir failed\n", s);
    364c:	85a6                	mv	a1,s1
    364e:	00004517          	auipc	a0,0x4
    3652:	dba50513          	addi	a0,a0,-582 # 7408 <malloc+0x139a>
    3656:	00003097          	auipc	ra,0x3
    365a:	958080e7          	jalr	-1704(ra) # 5fae <printf>
    exit(1);
    365e:	4505                	li	a0,1
    3660:	00002097          	auipc	ra,0x2
    3664:	5b8080e7          	jalr	1464(ra) # 5c18 <exit>
    printf("%s: chdir dir0 failed\n", s);
    3668:	85a6                	mv	a1,s1
    366a:	00004517          	auipc	a0,0x4
    366e:	e4650513          	addi	a0,a0,-442 # 74b0 <malloc+0x1442>
    3672:	00003097          	auipc	ra,0x3
    3676:	93c080e7          	jalr	-1732(ra) # 5fae <printf>
    exit(1);
    367a:	4505                	li	a0,1
    367c:	00002097          	auipc	ra,0x2
    3680:	59c080e7          	jalr	1436(ra) # 5c18 <exit>
    printf("%s: chdir .. failed\n", s);
    3684:	85a6                	mv	a1,s1
    3686:	00004517          	auipc	a0,0x4
    368a:	e4a50513          	addi	a0,a0,-438 # 74d0 <malloc+0x1462>
    368e:	00003097          	auipc	ra,0x3
    3692:	920080e7          	jalr	-1760(ra) # 5fae <printf>
    exit(1);
    3696:	4505                	li	a0,1
    3698:	00002097          	auipc	ra,0x2
    369c:	580080e7          	jalr	1408(ra) # 5c18 <exit>
    printf("%s: unlink dir0 failed\n", s);
    36a0:	85a6                	mv	a1,s1
    36a2:	00004517          	auipc	a0,0x4
    36a6:	e4650513          	addi	a0,a0,-442 # 74e8 <malloc+0x147a>
    36aa:	00003097          	auipc	ra,0x3
    36ae:	904080e7          	jalr	-1788(ra) # 5fae <printf>
    exit(1);
    36b2:	4505                	li	a0,1
    36b4:	00002097          	auipc	ra,0x2
    36b8:	564080e7          	jalr	1380(ra) # 5c18 <exit>

00000000000036bc <subdir>:
{
    36bc:	1101                	addi	sp,sp,-32
    36be:	ec06                	sd	ra,24(sp)
    36c0:	e822                	sd	s0,16(sp)
    36c2:	e426                	sd	s1,8(sp)
    36c4:	e04a                	sd	s2,0(sp)
    36c6:	1000                	addi	s0,sp,32
    36c8:	892a                	mv	s2,a0
  unlink("ff");
    36ca:	00004517          	auipc	a0,0x4
    36ce:	f6650513          	addi	a0,a0,-154 # 7630 <malloc+0x15c2>
    36d2:	00002097          	auipc	ra,0x2
    36d6:	596080e7          	jalr	1430(ra) # 5c68 <unlink>
  if(mkdir("dd") != 0){
    36da:	00004517          	auipc	a0,0x4
    36de:	e2650513          	addi	a0,a0,-474 # 7500 <malloc+0x1492>
    36e2:	00002097          	auipc	ra,0x2
    36e6:	59e080e7          	jalr	1438(ra) # 5c80 <mkdir>
    36ea:	38051663          	bnez	a0,3a76 <subdir+0x3ba>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    36ee:	20200593          	li	a1,514
    36f2:	00004517          	auipc	a0,0x4
    36f6:	e2e50513          	addi	a0,a0,-466 # 7520 <malloc+0x14b2>
    36fa:	00002097          	auipc	ra,0x2
    36fe:	55e080e7          	jalr	1374(ra) # 5c58 <open>
    3702:	84aa                	mv	s1,a0
  if(fd < 0){
    3704:	38054763          	bltz	a0,3a92 <subdir+0x3d6>
  write(fd, "ff", 2);
    3708:	4609                	li	a2,2
    370a:	00004597          	auipc	a1,0x4
    370e:	f2658593          	addi	a1,a1,-218 # 7630 <malloc+0x15c2>
    3712:	00002097          	auipc	ra,0x2
    3716:	526080e7          	jalr	1318(ra) # 5c38 <write>
  close(fd);
    371a:	8526                	mv	a0,s1
    371c:	00002097          	auipc	ra,0x2
    3720:	524080e7          	jalr	1316(ra) # 5c40 <close>
  if(unlink("dd") >= 0){
    3724:	00004517          	auipc	a0,0x4
    3728:	ddc50513          	addi	a0,a0,-548 # 7500 <malloc+0x1492>
    372c:	00002097          	auipc	ra,0x2
    3730:	53c080e7          	jalr	1340(ra) # 5c68 <unlink>
    3734:	36055d63          	bgez	a0,3aae <subdir+0x3f2>
  if(mkdir("/dd/dd") != 0){
    3738:	00004517          	auipc	a0,0x4
    373c:	e4050513          	addi	a0,a0,-448 # 7578 <malloc+0x150a>
    3740:	00002097          	auipc	ra,0x2
    3744:	540080e7          	jalr	1344(ra) # 5c80 <mkdir>
    3748:	38051163          	bnez	a0,3aca <subdir+0x40e>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    374c:	20200593          	li	a1,514
    3750:	00004517          	auipc	a0,0x4
    3754:	e5050513          	addi	a0,a0,-432 # 75a0 <malloc+0x1532>
    3758:	00002097          	auipc	ra,0x2
    375c:	500080e7          	jalr	1280(ra) # 5c58 <open>
    3760:	84aa                	mv	s1,a0
  if(fd < 0){
    3762:	38054263          	bltz	a0,3ae6 <subdir+0x42a>
  write(fd, "FF", 2);
    3766:	4609                	li	a2,2
    3768:	00004597          	auipc	a1,0x4
    376c:	e6858593          	addi	a1,a1,-408 # 75d0 <malloc+0x1562>
    3770:	00002097          	auipc	ra,0x2
    3774:	4c8080e7          	jalr	1224(ra) # 5c38 <write>
  close(fd);
    3778:	8526                	mv	a0,s1
    377a:	00002097          	auipc	ra,0x2
    377e:	4c6080e7          	jalr	1222(ra) # 5c40 <close>
  fd = open("dd/dd/../ff", 0);
    3782:	4581                	li	a1,0
    3784:	00004517          	auipc	a0,0x4
    3788:	e5450513          	addi	a0,a0,-428 # 75d8 <malloc+0x156a>
    378c:	00002097          	auipc	ra,0x2
    3790:	4cc080e7          	jalr	1228(ra) # 5c58 <open>
    3794:	84aa                	mv	s1,a0
  if(fd < 0){
    3796:	36054663          	bltz	a0,3b02 <subdir+0x446>
  cc = read(fd, buf, sizeof(buf));
    379a:	660d                	lui	a2,0x3
    379c:	00009597          	auipc	a1,0x9
    37a0:	4dc58593          	addi	a1,a1,1244 # cc78 <buf>
    37a4:	00002097          	auipc	ra,0x2
    37a8:	48c080e7          	jalr	1164(ra) # 5c30 <read>
  if(cc != 2 || buf[0] != 'f'){
    37ac:	4789                	li	a5,2
    37ae:	36f51863          	bne	a0,a5,3b1e <subdir+0x462>
    37b2:	00009717          	auipc	a4,0x9
    37b6:	4c674703          	lbu	a4,1222(a4) # cc78 <buf>
    37ba:	06600793          	li	a5,102
    37be:	36f71063          	bne	a4,a5,3b1e <subdir+0x462>
  close(fd);
    37c2:	8526                	mv	a0,s1
    37c4:	00002097          	auipc	ra,0x2
    37c8:	47c080e7          	jalr	1148(ra) # 5c40 <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    37cc:	00004597          	auipc	a1,0x4
    37d0:	e5c58593          	addi	a1,a1,-420 # 7628 <malloc+0x15ba>
    37d4:	00004517          	auipc	a0,0x4
    37d8:	dcc50513          	addi	a0,a0,-564 # 75a0 <malloc+0x1532>
    37dc:	00002097          	auipc	ra,0x2
    37e0:	49c080e7          	jalr	1180(ra) # 5c78 <link>
    37e4:	34051b63          	bnez	a0,3b3a <subdir+0x47e>
  if(unlink("dd/dd/ff") != 0){
    37e8:	00004517          	auipc	a0,0x4
    37ec:	db850513          	addi	a0,a0,-584 # 75a0 <malloc+0x1532>
    37f0:	00002097          	auipc	ra,0x2
    37f4:	478080e7          	jalr	1144(ra) # 5c68 <unlink>
    37f8:	34051f63          	bnez	a0,3b56 <subdir+0x49a>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    37fc:	4581                	li	a1,0
    37fe:	00004517          	auipc	a0,0x4
    3802:	da250513          	addi	a0,a0,-606 # 75a0 <malloc+0x1532>
    3806:	00002097          	auipc	ra,0x2
    380a:	452080e7          	jalr	1106(ra) # 5c58 <open>
    380e:	36055263          	bgez	a0,3b72 <subdir+0x4b6>
  if(chdir("dd") != 0){
    3812:	00004517          	auipc	a0,0x4
    3816:	cee50513          	addi	a0,a0,-786 # 7500 <malloc+0x1492>
    381a:	00002097          	auipc	ra,0x2
    381e:	46e080e7          	jalr	1134(ra) # 5c88 <chdir>
    3822:	36051663          	bnez	a0,3b8e <subdir+0x4d2>
  if(chdir("dd/../../dd") != 0){
    3826:	00004517          	auipc	a0,0x4
    382a:	e9a50513          	addi	a0,a0,-358 # 76c0 <malloc+0x1652>
    382e:	00002097          	auipc	ra,0x2
    3832:	45a080e7          	jalr	1114(ra) # 5c88 <chdir>
    3836:	36051a63          	bnez	a0,3baa <subdir+0x4ee>
  if(chdir("dd/../../../dd") != 0){
    383a:	00004517          	auipc	a0,0x4
    383e:	eb650513          	addi	a0,a0,-330 # 76f0 <malloc+0x1682>
    3842:	00002097          	auipc	ra,0x2
    3846:	446080e7          	jalr	1094(ra) # 5c88 <chdir>
    384a:	36051e63          	bnez	a0,3bc6 <subdir+0x50a>
  if(chdir("./..") != 0){
    384e:	00004517          	auipc	a0,0x4
    3852:	ed250513          	addi	a0,a0,-302 # 7720 <malloc+0x16b2>
    3856:	00002097          	auipc	ra,0x2
    385a:	432080e7          	jalr	1074(ra) # 5c88 <chdir>
    385e:	38051263          	bnez	a0,3be2 <subdir+0x526>
  fd = open("dd/dd/ffff", 0);
    3862:	4581                	li	a1,0
    3864:	00004517          	auipc	a0,0x4
    3868:	dc450513          	addi	a0,a0,-572 # 7628 <malloc+0x15ba>
    386c:	00002097          	auipc	ra,0x2
    3870:	3ec080e7          	jalr	1004(ra) # 5c58 <open>
    3874:	84aa                	mv	s1,a0
  if(fd < 0){
    3876:	38054463          	bltz	a0,3bfe <subdir+0x542>
  if(read(fd, buf, sizeof(buf)) != 2){
    387a:	660d                	lui	a2,0x3
    387c:	00009597          	auipc	a1,0x9
    3880:	3fc58593          	addi	a1,a1,1020 # cc78 <buf>
    3884:	00002097          	auipc	ra,0x2
    3888:	3ac080e7          	jalr	940(ra) # 5c30 <read>
    388c:	4789                	li	a5,2
    388e:	38f51663          	bne	a0,a5,3c1a <subdir+0x55e>
  close(fd);
    3892:	8526                	mv	a0,s1
    3894:	00002097          	auipc	ra,0x2
    3898:	3ac080e7          	jalr	940(ra) # 5c40 <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    389c:	4581                	li	a1,0
    389e:	00004517          	auipc	a0,0x4
    38a2:	d0250513          	addi	a0,a0,-766 # 75a0 <malloc+0x1532>
    38a6:	00002097          	auipc	ra,0x2
    38aa:	3b2080e7          	jalr	946(ra) # 5c58 <open>
    38ae:	38055463          	bgez	a0,3c36 <subdir+0x57a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    38b2:	20200593          	li	a1,514
    38b6:	00004517          	auipc	a0,0x4
    38ba:	efa50513          	addi	a0,a0,-262 # 77b0 <malloc+0x1742>
    38be:	00002097          	auipc	ra,0x2
    38c2:	39a080e7          	jalr	922(ra) # 5c58 <open>
    38c6:	38055663          	bgez	a0,3c52 <subdir+0x596>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    38ca:	20200593          	li	a1,514
    38ce:	00004517          	auipc	a0,0x4
    38d2:	f1250513          	addi	a0,a0,-238 # 77e0 <malloc+0x1772>
    38d6:	00002097          	auipc	ra,0x2
    38da:	382080e7          	jalr	898(ra) # 5c58 <open>
    38de:	38055863          	bgez	a0,3c6e <subdir+0x5b2>
  if(open("dd", O_CREATE) >= 0){
    38e2:	20000593          	li	a1,512
    38e6:	00004517          	auipc	a0,0x4
    38ea:	c1a50513          	addi	a0,a0,-998 # 7500 <malloc+0x1492>
    38ee:	00002097          	auipc	ra,0x2
    38f2:	36a080e7          	jalr	874(ra) # 5c58 <open>
    38f6:	38055a63          	bgez	a0,3c8a <subdir+0x5ce>
  if(open("dd", O_RDWR) >= 0){
    38fa:	4589                	li	a1,2
    38fc:	00004517          	auipc	a0,0x4
    3900:	c0450513          	addi	a0,a0,-1020 # 7500 <malloc+0x1492>
    3904:	00002097          	auipc	ra,0x2
    3908:	354080e7          	jalr	852(ra) # 5c58 <open>
    390c:	38055d63          	bgez	a0,3ca6 <subdir+0x5ea>
  if(open("dd", O_WRONLY) >= 0){
    3910:	4585                	li	a1,1
    3912:	00004517          	auipc	a0,0x4
    3916:	bee50513          	addi	a0,a0,-1042 # 7500 <malloc+0x1492>
    391a:	00002097          	auipc	ra,0x2
    391e:	33e080e7          	jalr	830(ra) # 5c58 <open>
    3922:	3a055063          	bgez	a0,3cc2 <subdir+0x606>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    3926:	00004597          	auipc	a1,0x4
    392a:	f4a58593          	addi	a1,a1,-182 # 7870 <malloc+0x1802>
    392e:	00004517          	auipc	a0,0x4
    3932:	e8250513          	addi	a0,a0,-382 # 77b0 <malloc+0x1742>
    3936:	00002097          	auipc	ra,0x2
    393a:	342080e7          	jalr	834(ra) # 5c78 <link>
    393e:	3a050063          	beqz	a0,3cde <subdir+0x622>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    3942:	00004597          	auipc	a1,0x4
    3946:	f2e58593          	addi	a1,a1,-210 # 7870 <malloc+0x1802>
    394a:	00004517          	auipc	a0,0x4
    394e:	e9650513          	addi	a0,a0,-362 # 77e0 <malloc+0x1772>
    3952:	00002097          	auipc	ra,0x2
    3956:	326080e7          	jalr	806(ra) # 5c78 <link>
    395a:	3a050063          	beqz	a0,3cfa <subdir+0x63e>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    395e:	00004597          	auipc	a1,0x4
    3962:	cca58593          	addi	a1,a1,-822 # 7628 <malloc+0x15ba>
    3966:	00004517          	auipc	a0,0x4
    396a:	bba50513          	addi	a0,a0,-1094 # 7520 <malloc+0x14b2>
    396e:	00002097          	auipc	ra,0x2
    3972:	30a080e7          	jalr	778(ra) # 5c78 <link>
    3976:	3a050063          	beqz	a0,3d16 <subdir+0x65a>
  if(mkdir("dd/ff/ff") == 0){
    397a:	00004517          	auipc	a0,0x4
    397e:	e3650513          	addi	a0,a0,-458 # 77b0 <malloc+0x1742>
    3982:	00002097          	auipc	ra,0x2
    3986:	2fe080e7          	jalr	766(ra) # 5c80 <mkdir>
    398a:	3a050463          	beqz	a0,3d32 <subdir+0x676>
  if(mkdir("dd/xx/ff") == 0){
    398e:	00004517          	auipc	a0,0x4
    3992:	e5250513          	addi	a0,a0,-430 # 77e0 <malloc+0x1772>
    3996:	00002097          	auipc	ra,0x2
    399a:	2ea080e7          	jalr	746(ra) # 5c80 <mkdir>
    399e:	3a050863          	beqz	a0,3d4e <subdir+0x692>
  if(mkdir("dd/dd/ffff") == 0){
    39a2:	00004517          	auipc	a0,0x4
    39a6:	c8650513          	addi	a0,a0,-890 # 7628 <malloc+0x15ba>
    39aa:	00002097          	auipc	ra,0x2
    39ae:	2d6080e7          	jalr	726(ra) # 5c80 <mkdir>
    39b2:	3a050c63          	beqz	a0,3d6a <subdir+0x6ae>
  if(unlink("dd/xx/ff") == 0){
    39b6:	00004517          	auipc	a0,0x4
    39ba:	e2a50513          	addi	a0,a0,-470 # 77e0 <malloc+0x1772>
    39be:	00002097          	auipc	ra,0x2
    39c2:	2aa080e7          	jalr	682(ra) # 5c68 <unlink>
    39c6:	3c050063          	beqz	a0,3d86 <subdir+0x6ca>
  if(unlink("dd/ff/ff") == 0){
    39ca:	00004517          	auipc	a0,0x4
    39ce:	de650513          	addi	a0,a0,-538 # 77b0 <malloc+0x1742>
    39d2:	00002097          	auipc	ra,0x2
    39d6:	296080e7          	jalr	662(ra) # 5c68 <unlink>
    39da:	3c050463          	beqz	a0,3da2 <subdir+0x6e6>
  if(chdir("dd/ff") == 0){
    39de:	00004517          	auipc	a0,0x4
    39e2:	b4250513          	addi	a0,a0,-1214 # 7520 <malloc+0x14b2>
    39e6:	00002097          	auipc	ra,0x2
    39ea:	2a2080e7          	jalr	674(ra) # 5c88 <chdir>
    39ee:	3c050863          	beqz	a0,3dbe <subdir+0x702>
  if(chdir("dd/xx") == 0){
    39f2:	00004517          	auipc	a0,0x4
    39f6:	fce50513          	addi	a0,a0,-50 # 79c0 <malloc+0x1952>
    39fa:	00002097          	auipc	ra,0x2
    39fe:	28e080e7          	jalr	654(ra) # 5c88 <chdir>
    3a02:	3c050c63          	beqz	a0,3dda <subdir+0x71e>
  if(unlink("dd/dd/ffff") != 0){
    3a06:	00004517          	auipc	a0,0x4
    3a0a:	c2250513          	addi	a0,a0,-990 # 7628 <malloc+0x15ba>
    3a0e:	00002097          	auipc	ra,0x2
    3a12:	25a080e7          	jalr	602(ra) # 5c68 <unlink>
    3a16:	3e051063          	bnez	a0,3df6 <subdir+0x73a>
  if(unlink("dd/ff") != 0){
    3a1a:	00004517          	auipc	a0,0x4
    3a1e:	b0650513          	addi	a0,a0,-1274 # 7520 <malloc+0x14b2>
    3a22:	00002097          	auipc	ra,0x2
    3a26:	246080e7          	jalr	582(ra) # 5c68 <unlink>
    3a2a:	3e051463          	bnez	a0,3e12 <subdir+0x756>
  if(unlink("dd") == 0){
    3a2e:	00004517          	auipc	a0,0x4
    3a32:	ad250513          	addi	a0,a0,-1326 # 7500 <malloc+0x1492>
    3a36:	00002097          	auipc	ra,0x2
    3a3a:	232080e7          	jalr	562(ra) # 5c68 <unlink>
    3a3e:	3e050863          	beqz	a0,3e2e <subdir+0x772>
  if(unlink("dd/dd") < 0){
    3a42:	00004517          	auipc	a0,0x4
    3a46:	fee50513          	addi	a0,a0,-18 # 7a30 <malloc+0x19c2>
    3a4a:	00002097          	auipc	ra,0x2
    3a4e:	21e080e7          	jalr	542(ra) # 5c68 <unlink>
    3a52:	3e054c63          	bltz	a0,3e4a <subdir+0x78e>
  if(unlink("dd") < 0){
    3a56:	00004517          	auipc	a0,0x4
    3a5a:	aaa50513          	addi	a0,a0,-1366 # 7500 <malloc+0x1492>
    3a5e:	00002097          	auipc	ra,0x2
    3a62:	20a080e7          	jalr	522(ra) # 5c68 <unlink>
    3a66:	40054063          	bltz	a0,3e66 <subdir+0x7aa>
}
    3a6a:	60e2                	ld	ra,24(sp)
    3a6c:	6442                	ld	s0,16(sp)
    3a6e:	64a2                	ld	s1,8(sp)
    3a70:	6902                	ld	s2,0(sp)
    3a72:	6105                	addi	sp,sp,32
    3a74:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    3a76:	85ca                	mv	a1,s2
    3a78:	00004517          	auipc	a0,0x4
    3a7c:	a9050513          	addi	a0,a0,-1392 # 7508 <malloc+0x149a>
    3a80:	00002097          	auipc	ra,0x2
    3a84:	52e080e7          	jalr	1326(ra) # 5fae <printf>
    exit(1);
    3a88:	4505                	li	a0,1
    3a8a:	00002097          	auipc	ra,0x2
    3a8e:	18e080e7          	jalr	398(ra) # 5c18 <exit>
    printf("%s: create dd/ff failed\n", s);
    3a92:	85ca                	mv	a1,s2
    3a94:	00004517          	auipc	a0,0x4
    3a98:	a9450513          	addi	a0,a0,-1388 # 7528 <malloc+0x14ba>
    3a9c:	00002097          	auipc	ra,0x2
    3aa0:	512080e7          	jalr	1298(ra) # 5fae <printf>
    exit(1);
    3aa4:	4505                	li	a0,1
    3aa6:	00002097          	auipc	ra,0x2
    3aaa:	172080e7          	jalr	370(ra) # 5c18 <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    3aae:	85ca                	mv	a1,s2
    3ab0:	00004517          	auipc	a0,0x4
    3ab4:	a9850513          	addi	a0,a0,-1384 # 7548 <malloc+0x14da>
    3ab8:	00002097          	auipc	ra,0x2
    3abc:	4f6080e7          	jalr	1270(ra) # 5fae <printf>
    exit(1);
    3ac0:	4505                	li	a0,1
    3ac2:	00002097          	auipc	ra,0x2
    3ac6:	156080e7          	jalr	342(ra) # 5c18 <exit>
    printf("subdir mkdir dd/dd failed\n", s);
    3aca:	85ca                	mv	a1,s2
    3acc:	00004517          	auipc	a0,0x4
    3ad0:	ab450513          	addi	a0,a0,-1356 # 7580 <malloc+0x1512>
    3ad4:	00002097          	auipc	ra,0x2
    3ad8:	4da080e7          	jalr	1242(ra) # 5fae <printf>
    exit(1);
    3adc:	4505                	li	a0,1
    3ade:	00002097          	auipc	ra,0x2
    3ae2:	13a080e7          	jalr	314(ra) # 5c18 <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    3ae6:	85ca                	mv	a1,s2
    3ae8:	00004517          	auipc	a0,0x4
    3aec:	ac850513          	addi	a0,a0,-1336 # 75b0 <malloc+0x1542>
    3af0:	00002097          	auipc	ra,0x2
    3af4:	4be080e7          	jalr	1214(ra) # 5fae <printf>
    exit(1);
    3af8:	4505                	li	a0,1
    3afa:	00002097          	auipc	ra,0x2
    3afe:	11e080e7          	jalr	286(ra) # 5c18 <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    3b02:	85ca                	mv	a1,s2
    3b04:	00004517          	auipc	a0,0x4
    3b08:	ae450513          	addi	a0,a0,-1308 # 75e8 <malloc+0x157a>
    3b0c:	00002097          	auipc	ra,0x2
    3b10:	4a2080e7          	jalr	1186(ra) # 5fae <printf>
    exit(1);
    3b14:	4505                	li	a0,1
    3b16:	00002097          	auipc	ra,0x2
    3b1a:	102080e7          	jalr	258(ra) # 5c18 <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    3b1e:	85ca                	mv	a1,s2
    3b20:	00004517          	auipc	a0,0x4
    3b24:	ae850513          	addi	a0,a0,-1304 # 7608 <malloc+0x159a>
    3b28:	00002097          	auipc	ra,0x2
    3b2c:	486080e7          	jalr	1158(ra) # 5fae <printf>
    exit(1);
    3b30:	4505                	li	a0,1
    3b32:	00002097          	auipc	ra,0x2
    3b36:	0e6080e7          	jalr	230(ra) # 5c18 <exit>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    3b3a:	85ca                	mv	a1,s2
    3b3c:	00004517          	auipc	a0,0x4
    3b40:	afc50513          	addi	a0,a0,-1284 # 7638 <malloc+0x15ca>
    3b44:	00002097          	auipc	ra,0x2
    3b48:	46a080e7          	jalr	1130(ra) # 5fae <printf>
    exit(1);
    3b4c:	4505                	li	a0,1
    3b4e:	00002097          	auipc	ra,0x2
    3b52:	0ca080e7          	jalr	202(ra) # 5c18 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3b56:	85ca                	mv	a1,s2
    3b58:	00004517          	auipc	a0,0x4
    3b5c:	b0850513          	addi	a0,a0,-1272 # 7660 <malloc+0x15f2>
    3b60:	00002097          	auipc	ra,0x2
    3b64:	44e080e7          	jalr	1102(ra) # 5fae <printf>
    exit(1);
    3b68:	4505                	li	a0,1
    3b6a:	00002097          	auipc	ra,0x2
    3b6e:	0ae080e7          	jalr	174(ra) # 5c18 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    3b72:	85ca                	mv	a1,s2
    3b74:	00004517          	auipc	a0,0x4
    3b78:	b0c50513          	addi	a0,a0,-1268 # 7680 <malloc+0x1612>
    3b7c:	00002097          	auipc	ra,0x2
    3b80:	432080e7          	jalr	1074(ra) # 5fae <printf>
    exit(1);
    3b84:	4505                	li	a0,1
    3b86:	00002097          	auipc	ra,0x2
    3b8a:	092080e7          	jalr	146(ra) # 5c18 <exit>
    printf("%s: chdir dd failed\n", s);
    3b8e:	85ca                	mv	a1,s2
    3b90:	00004517          	auipc	a0,0x4
    3b94:	b1850513          	addi	a0,a0,-1256 # 76a8 <malloc+0x163a>
    3b98:	00002097          	auipc	ra,0x2
    3b9c:	416080e7          	jalr	1046(ra) # 5fae <printf>
    exit(1);
    3ba0:	4505                	li	a0,1
    3ba2:	00002097          	auipc	ra,0x2
    3ba6:	076080e7          	jalr	118(ra) # 5c18 <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    3baa:	85ca                	mv	a1,s2
    3bac:	00004517          	auipc	a0,0x4
    3bb0:	b2450513          	addi	a0,a0,-1244 # 76d0 <malloc+0x1662>
    3bb4:	00002097          	auipc	ra,0x2
    3bb8:	3fa080e7          	jalr	1018(ra) # 5fae <printf>
    exit(1);
    3bbc:	4505                	li	a0,1
    3bbe:	00002097          	auipc	ra,0x2
    3bc2:	05a080e7          	jalr	90(ra) # 5c18 <exit>
    printf("chdir dd/../../dd failed\n", s);
    3bc6:	85ca                	mv	a1,s2
    3bc8:	00004517          	auipc	a0,0x4
    3bcc:	b3850513          	addi	a0,a0,-1224 # 7700 <malloc+0x1692>
    3bd0:	00002097          	auipc	ra,0x2
    3bd4:	3de080e7          	jalr	990(ra) # 5fae <printf>
    exit(1);
    3bd8:	4505                	li	a0,1
    3bda:	00002097          	auipc	ra,0x2
    3bde:	03e080e7          	jalr	62(ra) # 5c18 <exit>
    printf("%s: chdir ./.. failed\n", s);
    3be2:	85ca                	mv	a1,s2
    3be4:	00004517          	auipc	a0,0x4
    3be8:	b4450513          	addi	a0,a0,-1212 # 7728 <malloc+0x16ba>
    3bec:	00002097          	auipc	ra,0x2
    3bf0:	3c2080e7          	jalr	962(ra) # 5fae <printf>
    exit(1);
    3bf4:	4505                	li	a0,1
    3bf6:	00002097          	auipc	ra,0x2
    3bfa:	022080e7          	jalr	34(ra) # 5c18 <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    3bfe:	85ca                	mv	a1,s2
    3c00:	00004517          	auipc	a0,0x4
    3c04:	b4050513          	addi	a0,a0,-1216 # 7740 <malloc+0x16d2>
    3c08:	00002097          	auipc	ra,0x2
    3c0c:	3a6080e7          	jalr	934(ra) # 5fae <printf>
    exit(1);
    3c10:	4505                	li	a0,1
    3c12:	00002097          	auipc	ra,0x2
    3c16:	006080e7          	jalr	6(ra) # 5c18 <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    3c1a:	85ca                	mv	a1,s2
    3c1c:	00004517          	auipc	a0,0x4
    3c20:	b4450513          	addi	a0,a0,-1212 # 7760 <malloc+0x16f2>
    3c24:	00002097          	auipc	ra,0x2
    3c28:	38a080e7          	jalr	906(ra) # 5fae <printf>
    exit(1);
    3c2c:	4505                	li	a0,1
    3c2e:	00002097          	auipc	ra,0x2
    3c32:	fea080e7          	jalr	-22(ra) # 5c18 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    3c36:	85ca                	mv	a1,s2
    3c38:	00004517          	auipc	a0,0x4
    3c3c:	b4850513          	addi	a0,a0,-1208 # 7780 <malloc+0x1712>
    3c40:	00002097          	auipc	ra,0x2
    3c44:	36e080e7          	jalr	878(ra) # 5fae <printf>
    exit(1);
    3c48:	4505                	li	a0,1
    3c4a:	00002097          	auipc	ra,0x2
    3c4e:	fce080e7          	jalr	-50(ra) # 5c18 <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    3c52:	85ca                	mv	a1,s2
    3c54:	00004517          	auipc	a0,0x4
    3c58:	b6c50513          	addi	a0,a0,-1172 # 77c0 <malloc+0x1752>
    3c5c:	00002097          	auipc	ra,0x2
    3c60:	352080e7          	jalr	850(ra) # 5fae <printf>
    exit(1);
    3c64:	4505                	li	a0,1
    3c66:	00002097          	auipc	ra,0x2
    3c6a:	fb2080e7          	jalr	-78(ra) # 5c18 <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    3c6e:	85ca                	mv	a1,s2
    3c70:	00004517          	auipc	a0,0x4
    3c74:	b8050513          	addi	a0,a0,-1152 # 77f0 <malloc+0x1782>
    3c78:	00002097          	auipc	ra,0x2
    3c7c:	336080e7          	jalr	822(ra) # 5fae <printf>
    exit(1);
    3c80:	4505                	li	a0,1
    3c82:	00002097          	auipc	ra,0x2
    3c86:	f96080e7          	jalr	-106(ra) # 5c18 <exit>
    printf("%s: create dd succeeded!\n", s);
    3c8a:	85ca                	mv	a1,s2
    3c8c:	00004517          	auipc	a0,0x4
    3c90:	b8450513          	addi	a0,a0,-1148 # 7810 <malloc+0x17a2>
    3c94:	00002097          	auipc	ra,0x2
    3c98:	31a080e7          	jalr	794(ra) # 5fae <printf>
    exit(1);
    3c9c:	4505                	li	a0,1
    3c9e:	00002097          	auipc	ra,0x2
    3ca2:	f7a080e7          	jalr	-134(ra) # 5c18 <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    3ca6:	85ca                	mv	a1,s2
    3ca8:	00004517          	auipc	a0,0x4
    3cac:	b8850513          	addi	a0,a0,-1144 # 7830 <malloc+0x17c2>
    3cb0:	00002097          	auipc	ra,0x2
    3cb4:	2fe080e7          	jalr	766(ra) # 5fae <printf>
    exit(1);
    3cb8:	4505                	li	a0,1
    3cba:	00002097          	auipc	ra,0x2
    3cbe:	f5e080e7          	jalr	-162(ra) # 5c18 <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    3cc2:	85ca                	mv	a1,s2
    3cc4:	00004517          	auipc	a0,0x4
    3cc8:	b8c50513          	addi	a0,a0,-1140 # 7850 <malloc+0x17e2>
    3ccc:	00002097          	auipc	ra,0x2
    3cd0:	2e2080e7          	jalr	738(ra) # 5fae <printf>
    exit(1);
    3cd4:	4505                	li	a0,1
    3cd6:	00002097          	auipc	ra,0x2
    3cda:	f42080e7          	jalr	-190(ra) # 5c18 <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    3cde:	85ca                	mv	a1,s2
    3ce0:	00004517          	auipc	a0,0x4
    3ce4:	ba050513          	addi	a0,a0,-1120 # 7880 <malloc+0x1812>
    3ce8:	00002097          	auipc	ra,0x2
    3cec:	2c6080e7          	jalr	710(ra) # 5fae <printf>
    exit(1);
    3cf0:	4505                	li	a0,1
    3cf2:	00002097          	auipc	ra,0x2
    3cf6:	f26080e7          	jalr	-218(ra) # 5c18 <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    3cfa:	85ca                	mv	a1,s2
    3cfc:	00004517          	auipc	a0,0x4
    3d00:	bac50513          	addi	a0,a0,-1108 # 78a8 <malloc+0x183a>
    3d04:	00002097          	auipc	ra,0x2
    3d08:	2aa080e7          	jalr	682(ra) # 5fae <printf>
    exit(1);
    3d0c:	4505                	li	a0,1
    3d0e:	00002097          	auipc	ra,0x2
    3d12:	f0a080e7          	jalr	-246(ra) # 5c18 <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    3d16:	85ca                	mv	a1,s2
    3d18:	00004517          	auipc	a0,0x4
    3d1c:	bb850513          	addi	a0,a0,-1096 # 78d0 <malloc+0x1862>
    3d20:	00002097          	auipc	ra,0x2
    3d24:	28e080e7          	jalr	654(ra) # 5fae <printf>
    exit(1);
    3d28:	4505                	li	a0,1
    3d2a:	00002097          	auipc	ra,0x2
    3d2e:	eee080e7          	jalr	-274(ra) # 5c18 <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    3d32:	85ca                	mv	a1,s2
    3d34:	00004517          	auipc	a0,0x4
    3d38:	bc450513          	addi	a0,a0,-1084 # 78f8 <malloc+0x188a>
    3d3c:	00002097          	auipc	ra,0x2
    3d40:	272080e7          	jalr	626(ra) # 5fae <printf>
    exit(1);
    3d44:	4505                	li	a0,1
    3d46:	00002097          	auipc	ra,0x2
    3d4a:	ed2080e7          	jalr	-302(ra) # 5c18 <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    3d4e:	85ca                	mv	a1,s2
    3d50:	00004517          	auipc	a0,0x4
    3d54:	bc850513          	addi	a0,a0,-1080 # 7918 <malloc+0x18aa>
    3d58:	00002097          	auipc	ra,0x2
    3d5c:	256080e7          	jalr	598(ra) # 5fae <printf>
    exit(1);
    3d60:	4505                	li	a0,1
    3d62:	00002097          	auipc	ra,0x2
    3d66:	eb6080e7          	jalr	-330(ra) # 5c18 <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    3d6a:	85ca                	mv	a1,s2
    3d6c:	00004517          	auipc	a0,0x4
    3d70:	bcc50513          	addi	a0,a0,-1076 # 7938 <malloc+0x18ca>
    3d74:	00002097          	auipc	ra,0x2
    3d78:	23a080e7          	jalr	570(ra) # 5fae <printf>
    exit(1);
    3d7c:	4505                	li	a0,1
    3d7e:	00002097          	auipc	ra,0x2
    3d82:	e9a080e7          	jalr	-358(ra) # 5c18 <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    3d86:	85ca                	mv	a1,s2
    3d88:	00004517          	auipc	a0,0x4
    3d8c:	bd850513          	addi	a0,a0,-1064 # 7960 <malloc+0x18f2>
    3d90:	00002097          	auipc	ra,0x2
    3d94:	21e080e7          	jalr	542(ra) # 5fae <printf>
    exit(1);
    3d98:	4505                	li	a0,1
    3d9a:	00002097          	auipc	ra,0x2
    3d9e:	e7e080e7          	jalr	-386(ra) # 5c18 <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    3da2:	85ca                	mv	a1,s2
    3da4:	00004517          	auipc	a0,0x4
    3da8:	bdc50513          	addi	a0,a0,-1060 # 7980 <malloc+0x1912>
    3dac:	00002097          	auipc	ra,0x2
    3db0:	202080e7          	jalr	514(ra) # 5fae <printf>
    exit(1);
    3db4:	4505                	li	a0,1
    3db6:	00002097          	auipc	ra,0x2
    3dba:	e62080e7          	jalr	-414(ra) # 5c18 <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    3dbe:	85ca                	mv	a1,s2
    3dc0:	00004517          	auipc	a0,0x4
    3dc4:	be050513          	addi	a0,a0,-1056 # 79a0 <malloc+0x1932>
    3dc8:	00002097          	auipc	ra,0x2
    3dcc:	1e6080e7          	jalr	486(ra) # 5fae <printf>
    exit(1);
    3dd0:	4505                	li	a0,1
    3dd2:	00002097          	auipc	ra,0x2
    3dd6:	e46080e7          	jalr	-442(ra) # 5c18 <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    3dda:	85ca                	mv	a1,s2
    3ddc:	00004517          	auipc	a0,0x4
    3de0:	bec50513          	addi	a0,a0,-1044 # 79c8 <malloc+0x195a>
    3de4:	00002097          	auipc	ra,0x2
    3de8:	1ca080e7          	jalr	458(ra) # 5fae <printf>
    exit(1);
    3dec:	4505                	li	a0,1
    3dee:	00002097          	auipc	ra,0x2
    3df2:	e2a080e7          	jalr	-470(ra) # 5c18 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3df6:	85ca                	mv	a1,s2
    3df8:	00004517          	auipc	a0,0x4
    3dfc:	86850513          	addi	a0,a0,-1944 # 7660 <malloc+0x15f2>
    3e00:	00002097          	auipc	ra,0x2
    3e04:	1ae080e7          	jalr	430(ra) # 5fae <printf>
    exit(1);
    3e08:	4505                	li	a0,1
    3e0a:	00002097          	auipc	ra,0x2
    3e0e:	e0e080e7          	jalr	-498(ra) # 5c18 <exit>
    printf("%s: unlink dd/ff failed\n", s);
    3e12:	85ca                	mv	a1,s2
    3e14:	00004517          	auipc	a0,0x4
    3e18:	bd450513          	addi	a0,a0,-1068 # 79e8 <malloc+0x197a>
    3e1c:	00002097          	auipc	ra,0x2
    3e20:	192080e7          	jalr	402(ra) # 5fae <printf>
    exit(1);
    3e24:	4505                	li	a0,1
    3e26:	00002097          	auipc	ra,0x2
    3e2a:	df2080e7          	jalr	-526(ra) # 5c18 <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    3e2e:	85ca                	mv	a1,s2
    3e30:	00004517          	auipc	a0,0x4
    3e34:	bd850513          	addi	a0,a0,-1064 # 7a08 <malloc+0x199a>
    3e38:	00002097          	auipc	ra,0x2
    3e3c:	176080e7          	jalr	374(ra) # 5fae <printf>
    exit(1);
    3e40:	4505                	li	a0,1
    3e42:	00002097          	auipc	ra,0x2
    3e46:	dd6080e7          	jalr	-554(ra) # 5c18 <exit>
    printf("%s: unlink dd/dd failed\n", s);
    3e4a:	85ca                	mv	a1,s2
    3e4c:	00004517          	auipc	a0,0x4
    3e50:	bec50513          	addi	a0,a0,-1044 # 7a38 <malloc+0x19ca>
    3e54:	00002097          	auipc	ra,0x2
    3e58:	15a080e7          	jalr	346(ra) # 5fae <printf>
    exit(1);
    3e5c:	4505                	li	a0,1
    3e5e:	00002097          	auipc	ra,0x2
    3e62:	dba080e7          	jalr	-582(ra) # 5c18 <exit>
    printf("%s: unlink dd failed\n", s);
    3e66:	85ca                	mv	a1,s2
    3e68:	00004517          	auipc	a0,0x4
    3e6c:	bf050513          	addi	a0,a0,-1040 # 7a58 <malloc+0x19ea>
    3e70:	00002097          	auipc	ra,0x2
    3e74:	13e080e7          	jalr	318(ra) # 5fae <printf>
    exit(1);
    3e78:	4505                	li	a0,1
    3e7a:	00002097          	auipc	ra,0x2
    3e7e:	d9e080e7          	jalr	-610(ra) # 5c18 <exit>

0000000000003e82 <rmdot>:
{
    3e82:	1101                	addi	sp,sp,-32
    3e84:	ec06                	sd	ra,24(sp)
    3e86:	e822                	sd	s0,16(sp)
    3e88:	e426                	sd	s1,8(sp)
    3e8a:	1000                	addi	s0,sp,32
    3e8c:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    3e8e:	00004517          	auipc	a0,0x4
    3e92:	be250513          	addi	a0,a0,-1054 # 7a70 <malloc+0x1a02>
    3e96:	00002097          	auipc	ra,0x2
    3e9a:	dea080e7          	jalr	-534(ra) # 5c80 <mkdir>
    3e9e:	e549                	bnez	a0,3f28 <rmdot+0xa6>
  if(chdir("dots") != 0){
    3ea0:	00004517          	auipc	a0,0x4
    3ea4:	bd050513          	addi	a0,a0,-1072 # 7a70 <malloc+0x1a02>
    3ea8:	00002097          	auipc	ra,0x2
    3eac:	de0080e7          	jalr	-544(ra) # 5c88 <chdir>
    3eb0:	e951                	bnez	a0,3f44 <rmdot+0xc2>
  if(unlink(".") == 0){
    3eb2:	00003517          	auipc	a0,0x3
    3eb6:	9ee50513          	addi	a0,a0,-1554 # 68a0 <malloc+0x832>
    3eba:	00002097          	auipc	ra,0x2
    3ebe:	dae080e7          	jalr	-594(ra) # 5c68 <unlink>
    3ec2:	cd59                	beqz	a0,3f60 <rmdot+0xde>
  if(unlink("..") == 0){
    3ec4:	00003517          	auipc	a0,0x3
    3ec8:	60450513          	addi	a0,a0,1540 # 74c8 <malloc+0x145a>
    3ecc:	00002097          	auipc	ra,0x2
    3ed0:	d9c080e7          	jalr	-612(ra) # 5c68 <unlink>
    3ed4:	c545                	beqz	a0,3f7c <rmdot+0xfa>
  if(chdir("/") != 0){
    3ed6:	00003517          	auipc	a0,0x3
    3eda:	59a50513          	addi	a0,a0,1434 # 7470 <malloc+0x1402>
    3ede:	00002097          	auipc	ra,0x2
    3ee2:	daa080e7          	jalr	-598(ra) # 5c88 <chdir>
    3ee6:	e94d                	bnez	a0,3f98 <rmdot+0x116>
  if(unlink("dots/.") == 0){
    3ee8:	00004517          	auipc	a0,0x4
    3eec:	bf050513          	addi	a0,a0,-1040 # 7ad8 <malloc+0x1a6a>
    3ef0:	00002097          	auipc	ra,0x2
    3ef4:	d78080e7          	jalr	-648(ra) # 5c68 <unlink>
    3ef8:	cd55                	beqz	a0,3fb4 <rmdot+0x132>
  if(unlink("dots/..") == 0){
    3efa:	00004517          	auipc	a0,0x4
    3efe:	c0650513          	addi	a0,a0,-1018 # 7b00 <malloc+0x1a92>
    3f02:	00002097          	auipc	ra,0x2
    3f06:	d66080e7          	jalr	-666(ra) # 5c68 <unlink>
    3f0a:	c179                	beqz	a0,3fd0 <rmdot+0x14e>
  if(unlink("dots") != 0){
    3f0c:	00004517          	auipc	a0,0x4
    3f10:	b6450513          	addi	a0,a0,-1180 # 7a70 <malloc+0x1a02>
    3f14:	00002097          	auipc	ra,0x2
    3f18:	d54080e7          	jalr	-684(ra) # 5c68 <unlink>
    3f1c:	e961                	bnez	a0,3fec <rmdot+0x16a>
}
    3f1e:	60e2                	ld	ra,24(sp)
    3f20:	6442                	ld	s0,16(sp)
    3f22:	64a2                	ld	s1,8(sp)
    3f24:	6105                	addi	sp,sp,32
    3f26:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    3f28:	85a6                	mv	a1,s1
    3f2a:	00004517          	auipc	a0,0x4
    3f2e:	b4e50513          	addi	a0,a0,-1202 # 7a78 <malloc+0x1a0a>
    3f32:	00002097          	auipc	ra,0x2
    3f36:	07c080e7          	jalr	124(ra) # 5fae <printf>
    exit(1);
    3f3a:	4505                	li	a0,1
    3f3c:	00002097          	auipc	ra,0x2
    3f40:	cdc080e7          	jalr	-804(ra) # 5c18 <exit>
    printf("%s: chdir dots failed\n", s);
    3f44:	85a6                	mv	a1,s1
    3f46:	00004517          	auipc	a0,0x4
    3f4a:	b4a50513          	addi	a0,a0,-1206 # 7a90 <malloc+0x1a22>
    3f4e:	00002097          	auipc	ra,0x2
    3f52:	060080e7          	jalr	96(ra) # 5fae <printf>
    exit(1);
    3f56:	4505                	li	a0,1
    3f58:	00002097          	auipc	ra,0x2
    3f5c:	cc0080e7          	jalr	-832(ra) # 5c18 <exit>
    printf("%s: rm . worked!\n", s);
    3f60:	85a6                	mv	a1,s1
    3f62:	00004517          	auipc	a0,0x4
    3f66:	b4650513          	addi	a0,a0,-1210 # 7aa8 <malloc+0x1a3a>
    3f6a:	00002097          	auipc	ra,0x2
    3f6e:	044080e7          	jalr	68(ra) # 5fae <printf>
    exit(1);
    3f72:	4505                	li	a0,1
    3f74:	00002097          	auipc	ra,0x2
    3f78:	ca4080e7          	jalr	-860(ra) # 5c18 <exit>
    printf("%s: rm .. worked!\n", s);
    3f7c:	85a6                	mv	a1,s1
    3f7e:	00004517          	auipc	a0,0x4
    3f82:	b4250513          	addi	a0,a0,-1214 # 7ac0 <malloc+0x1a52>
    3f86:	00002097          	auipc	ra,0x2
    3f8a:	028080e7          	jalr	40(ra) # 5fae <printf>
    exit(1);
    3f8e:	4505                	li	a0,1
    3f90:	00002097          	auipc	ra,0x2
    3f94:	c88080e7          	jalr	-888(ra) # 5c18 <exit>
    printf("%s: chdir / failed\n", s);
    3f98:	85a6                	mv	a1,s1
    3f9a:	00003517          	auipc	a0,0x3
    3f9e:	4de50513          	addi	a0,a0,1246 # 7478 <malloc+0x140a>
    3fa2:	00002097          	auipc	ra,0x2
    3fa6:	00c080e7          	jalr	12(ra) # 5fae <printf>
    exit(1);
    3faa:	4505                	li	a0,1
    3fac:	00002097          	auipc	ra,0x2
    3fb0:	c6c080e7          	jalr	-916(ra) # 5c18 <exit>
    printf("%s: unlink dots/. worked!\n", s);
    3fb4:	85a6                	mv	a1,s1
    3fb6:	00004517          	auipc	a0,0x4
    3fba:	b2a50513          	addi	a0,a0,-1238 # 7ae0 <malloc+0x1a72>
    3fbe:	00002097          	auipc	ra,0x2
    3fc2:	ff0080e7          	jalr	-16(ra) # 5fae <printf>
    exit(1);
    3fc6:	4505                	li	a0,1
    3fc8:	00002097          	auipc	ra,0x2
    3fcc:	c50080e7          	jalr	-944(ra) # 5c18 <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    3fd0:	85a6                	mv	a1,s1
    3fd2:	00004517          	auipc	a0,0x4
    3fd6:	b3650513          	addi	a0,a0,-1226 # 7b08 <malloc+0x1a9a>
    3fda:	00002097          	auipc	ra,0x2
    3fde:	fd4080e7          	jalr	-44(ra) # 5fae <printf>
    exit(1);
    3fe2:	4505                	li	a0,1
    3fe4:	00002097          	auipc	ra,0x2
    3fe8:	c34080e7          	jalr	-972(ra) # 5c18 <exit>
    printf("%s: unlink dots failed!\n", s);
    3fec:	85a6                	mv	a1,s1
    3fee:	00004517          	auipc	a0,0x4
    3ff2:	b3a50513          	addi	a0,a0,-1222 # 7b28 <malloc+0x1aba>
    3ff6:	00002097          	auipc	ra,0x2
    3ffa:	fb8080e7          	jalr	-72(ra) # 5fae <printf>
    exit(1);
    3ffe:	4505                	li	a0,1
    4000:	00002097          	auipc	ra,0x2
    4004:	c18080e7          	jalr	-1000(ra) # 5c18 <exit>

0000000000004008 <dirfile>:
{
    4008:	1101                	addi	sp,sp,-32
    400a:	ec06                	sd	ra,24(sp)
    400c:	e822                	sd	s0,16(sp)
    400e:	e426                	sd	s1,8(sp)
    4010:	e04a                	sd	s2,0(sp)
    4012:	1000                	addi	s0,sp,32
    4014:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    4016:	20000593          	li	a1,512
    401a:	00004517          	auipc	a0,0x4
    401e:	b2e50513          	addi	a0,a0,-1234 # 7b48 <malloc+0x1ada>
    4022:	00002097          	auipc	ra,0x2
    4026:	c36080e7          	jalr	-970(ra) # 5c58 <open>
  if(fd < 0){
    402a:	0e054d63          	bltz	a0,4124 <dirfile+0x11c>
  close(fd);
    402e:	00002097          	auipc	ra,0x2
    4032:	c12080e7          	jalr	-1006(ra) # 5c40 <close>
  if(chdir("dirfile") == 0){
    4036:	00004517          	auipc	a0,0x4
    403a:	b1250513          	addi	a0,a0,-1262 # 7b48 <malloc+0x1ada>
    403e:	00002097          	auipc	ra,0x2
    4042:	c4a080e7          	jalr	-950(ra) # 5c88 <chdir>
    4046:	cd6d                	beqz	a0,4140 <dirfile+0x138>
  fd = open("dirfile/xx", 0);
    4048:	4581                	li	a1,0
    404a:	00004517          	auipc	a0,0x4
    404e:	b4650513          	addi	a0,a0,-1210 # 7b90 <malloc+0x1b22>
    4052:	00002097          	auipc	ra,0x2
    4056:	c06080e7          	jalr	-1018(ra) # 5c58 <open>
  if(fd >= 0){
    405a:	10055163          	bgez	a0,415c <dirfile+0x154>
  fd = open("dirfile/xx", O_CREATE);
    405e:	20000593          	li	a1,512
    4062:	00004517          	auipc	a0,0x4
    4066:	b2e50513          	addi	a0,a0,-1234 # 7b90 <malloc+0x1b22>
    406a:	00002097          	auipc	ra,0x2
    406e:	bee080e7          	jalr	-1042(ra) # 5c58 <open>
  if(fd >= 0){
    4072:	10055363          	bgez	a0,4178 <dirfile+0x170>
  if(mkdir("dirfile/xx") == 0){
    4076:	00004517          	auipc	a0,0x4
    407a:	b1a50513          	addi	a0,a0,-1254 # 7b90 <malloc+0x1b22>
    407e:	00002097          	auipc	ra,0x2
    4082:	c02080e7          	jalr	-1022(ra) # 5c80 <mkdir>
    4086:	10050763          	beqz	a0,4194 <dirfile+0x18c>
  if(unlink("dirfile/xx") == 0){
    408a:	00004517          	auipc	a0,0x4
    408e:	b0650513          	addi	a0,a0,-1274 # 7b90 <malloc+0x1b22>
    4092:	00002097          	auipc	ra,0x2
    4096:	bd6080e7          	jalr	-1066(ra) # 5c68 <unlink>
    409a:	10050b63          	beqz	a0,41b0 <dirfile+0x1a8>
  if(link("README", "dirfile/xx") == 0){
    409e:	00004597          	auipc	a1,0x4
    40a2:	af258593          	addi	a1,a1,-1294 # 7b90 <malloc+0x1b22>
    40a6:	00002517          	auipc	a0,0x2
    40aa:	2ea50513          	addi	a0,a0,746 # 6390 <malloc+0x322>
    40ae:	00002097          	auipc	ra,0x2
    40b2:	bca080e7          	jalr	-1078(ra) # 5c78 <link>
    40b6:	10050b63          	beqz	a0,41cc <dirfile+0x1c4>
  if(unlink("dirfile") != 0){
    40ba:	00004517          	auipc	a0,0x4
    40be:	a8e50513          	addi	a0,a0,-1394 # 7b48 <malloc+0x1ada>
    40c2:	00002097          	auipc	ra,0x2
    40c6:	ba6080e7          	jalr	-1114(ra) # 5c68 <unlink>
    40ca:	10051f63          	bnez	a0,41e8 <dirfile+0x1e0>
  fd = open(".", O_RDWR);
    40ce:	4589                	li	a1,2
    40d0:	00002517          	auipc	a0,0x2
    40d4:	7d050513          	addi	a0,a0,2000 # 68a0 <malloc+0x832>
    40d8:	00002097          	auipc	ra,0x2
    40dc:	b80080e7          	jalr	-1152(ra) # 5c58 <open>
  if(fd >= 0){
    40e0:	12055263          	bgez	a0,4204 <dirfile+0x1fc>
  fd = open(".", 0);
    40e4:	4581                	li	a1,0
    40e6:	00002517          	auipc	a0,0x2
    40ea:	7ba50513          	addi	a0,a0,1978 # 68a0 <malloc+0x832>
    40ee:	00002097          	auipc	ra,0x2
    40f2:	b6a080e7          	jalr	-1174(ra) # 5c58 <open>
    40f6:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    40f8:	4605                	li	a2,1
    40fa:	00002597          	auipc	a1,0x2
    40fe:	12e58593          	addi	a1,a1,302 # 6228 <malloc+0x1ba>
    4102:	00002097          	auipc	ra,0x2
    4106:	b36080e7          	jalr	-1226(ra) # 5c38 <write>
    410a:	10a04b63          	bgtz	a0,4220 <dirfile+0x218>
  close(fd);
    410e:	8526                	mv	a0,s1
    4110:	00002097          	auipc	ra,0x2
    4114:	b30080e7          	jalr	-1232(ra) # 5c40 <close>
}
    4118:	60e2                	ld	ra,24(sp)
    411a:	6442                	ld	s0,16(sp)
    411c:	64a2                	ld	s1,8(sp)
    411e:	6902                	ld	s2,0(sp)
    4120:	6105                	addi	sp,sp,32
    4122:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    4124:	85ca                	mv	a1,s2
    4126:	00004517          	auipc	a0,0x4
    412a:	a2a50513          	addi	a0,a0,-1494 # 7b50 <malloc+0x1ae2>
    412e:	00002097          	auipc	ra,0x2
    4132:	e80080e7          	jalr	-384(ra) # 5fae <printf>
    exit(1);
    4136:	4505                	li	a0,1
    4138:	00002097          	auipc	ra,0x2
    413c:	ae0080e7          	jalr	-1312(ra) # 5c18 <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    4140:	85ca                	mv	a1,s2
    4142:	00004517          	auipc	a0,0x4
    4146:	a2e50513          	addi	a0,a0,-1490 # 7b70 <malloc+0x1b02>
    414a:	00002097          	auipc	ra,0x2
    414e:	e64080e7          	jalr	-412(ra) # 5fae <printf>
    exit(1);
    4152:	4505                	li	a0,1
    4154:	00002097          	auipc	ra,0x2
    4158:	ac4080e7          	jalr	-1340(ra) # 5c18 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    415c:	85ca                	mv	a1,s2
    415e:	00004517          	auipc	a0,0x4
    4162:	a4250513          	addi	a0,a0,-1470 # 7ba0 <malloc+0x1b32>
    4166:	00002097          	auipc	ra,0x2
    416a:	e48080e7          	jalr	-440(ra) # 5fae <printf>
    exit(1);
    416e:	4505                	li	a0,1
    4170:	00002097          	auipc	ra,0x2
    4174:	aa8080e7          	jalr	-1368(ra) # 5c18 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    4178:	85ca                	mv	a1,s2
    417a:	00004517          	auipc	a0,0x4
    417e:	a2650513          	addi	a0,a0,-1498 # 7ba0 <malloc+0x1b32>
    4182:	00002097          	auipc	ra,0x2
    4186:	e2c080e7          	jalr	-468(ra) # 5fae <printf>
    exit(1);
    418a:	4505                	li	a0,1
    418c:	00002097          	auipc	ra,0x2
    4190:	a8c080e7          	jalr	-1396(ra) # 5c18 <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    4194:	85ca                	mv	a1,s2
    4196:	00004517          	auipc	a0,0x4
    419a:	a3250513          	addi	a0,a0,-1486 # 7bc8 <malloc+0x1b5a>
    419e:	00002097          	auipc	ra,0x2
    41a2:	e10080e7          	jalr	-496(ra) # 5fae <printf>
    exit(1);
    41a6:	4505                	li	a0,1
    41a8:	00002097          	auipc	ra,0x2
    41ac:	a70080e7          	jalr	-1424(ra) # 5c18 <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    41b0:	85ca                	mv	a1,s2
    41b2:	00004517          	auipc	a0,0x4
    41b6:	a3e50513          	addi	a0,a0,-1474 # 7bf0 <malloc+0x1b82>
    41ba:	00002097          	auipc	ra,0x2
    41be:	df4080e7          	jalr	-524(ra) # 5fae <printf>
    exit(1);
    41c2:	4505                	li	a0,1
    41c4:	00002097          	auipc	ra,0x2
    41c8:	a54080e7          	jalr	-1452(ra) # 5c18 <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    41cc:	85ca                	mv	a1,s2
    41ce:	00004517          	auipc	a0,0x4
    41d2:	a4a50513          	addi	a0,a0,-1462 # 7c18 <malloc+0x1baa>
    41d6:	00002097          	auipc	ra,0x2
    41da:	dd8080e7          	jalr	-552(ra) # 5fae <printf>
    exit(1);
    41de:	4505                	li	a0,1
    41e0:	00002097          	auipc	ra,0x2
    41e4:	a38080e7          	jalr	-1480(ra) # 5c18 <exit>
    printf("%s: unlink dirfile failed!\n", s);
    41e8:	85ca                	mv	a1,s2
    41ea:	00004517          	auipc	a0,0x4
    41ee:	a5650513          	addi	a0,a0,-1450 # 7c40 <malloc+0x1bd2>
    41f2:	00002097          	auipc	ra,0x2
    41f6:	dbc080e7          	jalr	-580(ra) # 5fae <printf>
    exit(1);
    41fa:	4505                	li	a0,1
    41fc:	00002097          	auipc	ra,0x2
    4200:	a1c080e7          	jalr	-1508(ra) # 5c18 <exit>
    printf("%s: open . for writing succeeded!\n", s);
    4204:	85ca                	mv	a1,s2
    4206:	00004517          	auipc	a0,0x4
    420a:	a5a50513          	addi	a0,a0,-1446 # 7c60 <malloc+0x1bf2>
    420e:	00002097          	auipc	ra,0x2
    4212:	da0080e7          	jalr	-608(ra) # 5fae <printf>
    exit(1);
    4216:	4505                	li	a0,1
    4218:	00002097          	auipc	ra,0x2
    421c:	a00080e7          	jalr	-1536(ra) # 5c18 <exit>
    printf("%s: write . succeeded!\n", s);
    4220:	85ca                	mv	a1,s2
    4222:	00004517          	auipc	a0,0x4
    4226:	a6650513          	addi	a0,a0,-1434 # 7c88 <malloc+0x1c1a>
    422a:	00002097          	auipc	ra,0x2
    422e:	d84080e7          	jalr	-636(ra) # 5fae <printf>
    exit(1);
    4232:	4505                	li	a0,1
    4234:	00002097          	auipc	ra,0x2
    4238:	9e4080e7          	jalr	-1564(ra) # 5c18 <exit>

000000000000423c <iref>:
{
    423c:	7139                	addi	sp,sp,-64
    423e:	fc06                	sd	ra,56(sp)
    4240:	f822                	sd	s0,48(sp)
    4242:	f426                	sd	s1,40(sp)
    4244:	f04a                	sd	s2,32(sp)
    4246:	ec4e                	sd	s3,24(sp)
    4248:	e852                	sd	s4,16(sp)
    424a:	e456                	sd	s5,8(sp)
    424c:	e05a                	sd	s6,0(sp)
    424e:	0080                	addi	s0,sp,64
    4250:	8b2a                	mv	s6,a0
    4252:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    4256:	00004a17          	auipc	s4,0x4
    425a:	a4aa0a13          	addi	s4,s4,-1462 # 7ca0 <malloc+0x1c32>
    mkdir("");
    425e:	00003497          	auipc	s1,0x3
    4262:	54a48493          	addi	s1,s1,1354 # 77a8 <malloc+0x173a>
    link("README", "");
    4266:	00002a97          	auipc	s5,0x2
    426a:	12aa8a93          	addi	s5,s5,298 # 6390 <malloc+0x322>
    fd = open("xx", O_CREATE);
    426e:	00004997          	auipc	s3,0x4
    4272:	92a98993          	addi	s3,s3,-1750 # 7b98 <malloc+0x1b2a>
    4276:	a891                	j	42ca <iref+0x8e>
      printf("%s: mkdir irefd failed\n", s);
    4278:	85da                	mv	a1,s6
    427a:	00004517          	auipc	a0,0x4
    427e:	a2e50513          	addi	a0,a0,-1490 # 7ca8 <malloc+0x1c3a>
    4282:	00002097          	auipc	ra,0x2
    4286:	d2c080e7          	jalr	-724(ra) # 5fae <printf>
      exit(1);
    428a:	4505                	li	a0,1
    428c:	00002097          	auipc	ra,0x2
    4290:	98c080e7          	jalr	-1652(ra) # 5c18 <exit>
      printf("%s: chdir irefd failed\n", s);
    4294:	85da                	mv	a1,s6
    4296:	00004517          	auipc	a0,0x4
    429a:	a2a50513          	addi	a0,a0,-1494 # 7cc0 <malloc+0x1c52>
    429e:	00002097          	auipc	ra,0x2
    42a2:	d10080e7          	jalr	-752(ra) # 5fae <printf>
      exit(1);
    42a6:	4505                	li	a0,1
    42a8:	00002097          	auipc	ra,0x2
    42ac:	970080e7          	jalr	-1680(ra) # 5c18 <exit>
      close(fd);
    42b0:	00002097          	auipc	ra,0x2
    42b4:	990080e7          	jalr	-1648(ra) # 5c40 <close>
    42b8:	a889                	j	430a <iref+0xce>
    unlink("xx");
    42ba:	854e                	mv	a0,s3
    42bc:	00002097          	auipc	ra,0x2
    42c0:	9ac080e7          	jalr	-1620(ra) # 5c68 <unlink>
    42c4:	397d                	addiw	s2,s2,-1
  for(i = 0; i < NINODE + 1; i++){
    42c6:	06090063          	beqz	s2,4326 <iref+0xea>
    if(mkdir("irefd") != 0){
    42ca:	8552                	mv	a0,s4
    42cc:	00002097          	auipc	ra,0x2
    42d0:	9b4080e7          	jalr	-1612(ra) # 5c80 <mkdir>
    42d4:	f155                	bnez	a0,4278 <iref+0x3c>
    if(chdir("irefd") != 0){
    42d6:	8552                	mv	a0,s4
    42d8:	00002097          	auipc	ra,0x2
    42dc:	9b0080e7          	jalr	-1616(ra) # 5c88 <chdir>
    42e0:	f955                	bnez	a0,4294 <iref+0x58>
    mkdir("");
    42e2:	8526                	mv	a0,s1
    42e4:	00002097          	auipc	ra,0x2
    42e8:	99c080e7          	jalr	-1636(ra) # 5c80 <mkdir>
    link("README", "");
    42ec:	85a6                	mv	a1,s1
    42ee:	8556                	mv	a0,s5
    42f0:	00002097          	auipc	ra,0x2
    42f4:	988080e7          	jalr	-1656(ra) # 5c78 <link>
    fd = open("", O_CREATE);
    42f8:	20000593          	li	a1,512
    42fc:	8526                	mv	a0,s1
    42fe:	00002097          	auipc	ra,0x2
    4302:	95a080e7          	jalr	-1702(ra) # 5c58 <open>
    if(fd >= 0)
    4306:	fa0555e3          	bgez	a0,42b0 <iref+0x74>
    fd = open("xx", O_CREATE);
    430a:	20000593          	li	a1,512
    430e:	854e                	mv	a0,s3
    4310:	00002097          	auipc	ra,0x2
    4314:	948080e7          	jalr	-1720(ra) # 5c58 <open>
    if(fd >= 0)
    4318:	fa0541e3          	bltz	a0,42ba <iref+0x7e>
      close(fd);
    431c:	00002097          	auipc	ra,0x2
    4320:	924080e7          	jalr	-1756(ra) # 5c40 <close>
    4324:	bf59                	j	42ba <iref+0x7e>
    4326:	03300493          	li	s1,51
    chdir("..");
    432a:	00003997          	auipc	s3,0x3
    432e:	19e98993          	addi	s3,s3,414 # 74c8 <malloc+0x145a>
    unlink("irefd");
    4332:	00004917          	auipc	s2,0x4
    4336:	96e90913          	addi	s2,s2,-1682 # 7ca0 <malloc+0x1c32>
    chdir("..");
    433a:	854e                	mv	a0,s3
    433c:	00002097          	auipc	ra,0x2
    4340:	94c080e7          	jalr	-1716(ra) # 5c88 <chdir>
    unlink("irefd");
    4344:	854a                	mv	a0,s2
    4346:	00002097          	auipc	ra,0x2
    434a:	922080e7          	jalr	-1758(ra) # 5c68 <unlink>
    434e:	34fd                	addiw	s1,s1,-1
  for(i = 0; i < NINODE + 1; i++){
    4350:	f4ed                	bnez	s1,433a <iref+0xfe>
  chdir("/");
    4352:	00003517          	auipc	a0,0x3
    4356:	11e50513          	addi	a0,a0,286 # 7470 <malloc+0x1402>
    435a:	00002097          	auipc	ra,0x2
    435e:	92e080e7          	jalr	-1746(ra) # 5c88 <chdir>
}
    4362:	70e2                	ld	ra,56(sp)
    4364:	7442                	ld	s0,48(sp)
    4366:	74a2                	ld	s1,40(sp)
    4368:	7902                	ld	s2,32(sp)
    436a:	69e2                	ld	s3,24(sp)
    436c:	6a42                	ld	s4,16(sp)
    436e:	6aa2                	ld	s5,8(sp)
    4370:	6b02                	ld	s6,0(sp)
    4372:	6121                	addi	sp,sp,64
    4374:	8082                	ret

0000000000004376 <openiputtest>:
{
    4376:	7179                	addi	sp,sp,-48
    4378:	f406                	sd	ra,40(sp)
    437a:	f022                	sd	s0,32(sp)
    437c:	ec26                	sd	s1,24(sp)
    437e:	1800                	addi	s0,sp,48
    4380:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    4382:	00004517          	auipc	a0,0x4
    4386:	95650513          	addi	a0,a0,-1706 # 7cd8 <malloc+0x1c6a>
    438a:	00002097          	auipc	ra,0x2
    438e:	8f6080e7          	jalr	-1802(ra) # 5c80 <mkdir>
    4392:	04054263          	bltz	a0,43d6 <openiputtest+0x60>
  pid = fork();
    4396:	00002097          	auipc	ra,0x2
    439a:	87a080e7          	jalr	-1926(ra) # 5c10 <fork>
  if(pid < 0){
    439e:	04054a63          	bltz	a0,43f2 <openiputtest+0x7c>
  if(pid == 0){
    43a2:	e93d                	bnez	a0,4418 <openiputtest+0xa2>
    int fd = open("oidir", O_RDWR);
    43a4:	4589                	li	a1,2
    43a6:	00004517          	auipc	a0,0x4
    43aa:	93250513          	addi	a0,a0,-1742 # 7cd8 <malloc+0x1c6a>
    43ae:	00002097          	auipc	ra,0x2
    43b2:	8aa080e7          	jalr	-1878(ra) # 5c58 <open>
    if(fd >= 0){
    43b6:	04054c63          	bltz	a0,440e <openiputtest+0x98>
      printf("%s: open directory for write succeeded\n", s);
    43ba:	85a6                	mv	a1,s1
    43bc:	00004517          	auipc	a0,0x4
    43c0:	93c50513          	addi	a0,a0,-1732 # 7cf8 <malloc+0x1c8a>
    43c4:	00002097          	auipc	ra,0x2
    43c8:	bea080e7          	jalr	-1046(ra) # 5fae <printf>
      exit(1);
    43cc:	4505                	li	a0,1
    43ce:	00002097          	auipc	ra,0x2
    43d2:	84a080e7          	jalr	-1974(ra) # 5c18 <exit>
    printf("%s: mkdir oidir failed\n", s);
    43d6:	85a6                	mv	a1,s1
    43d8:	00004517          	auipc	a0,0x4
    43dc:	90850513          	addi	a0,a0,-1784 # 7ce0 <malloc+0x1c72>
    43e0:	00002097          	auipc	ra,0x2
    43e4:	bce080e7          	jalr	-1074(ra) # 5fae <printf>
    exit(1);
    43e8:	4505                	li	a0,1
    43ea:	00002097          	auipc	ra,0x2
    43ee:	82e080e7          	jalr	-2002(ra) # 5c18 <exit>
    printf("%s: fork failed\n", s);
    43f2:	85a6                	mv	a1,s1
    43f4:	00002517          	auipc	a0,0x2
    43f8:	64c50513          	addi	a0,a0,1612 # 6a40 <malloc+0x9d2>
    43fc:	00002097          	auipc	ra,0x2
    4400:	bb2080e7          	jalr	-1102(ra) # 5fae <printf>
    exit(1);
    4404:	4505                	li	a0,1
    4406:	00002097          	auipc	ra,0x2
    440a:	812080e7          	jalr	-2030(ra) # 5c18 <exit>
    exit(0);
    440e:	4501                	li	a0,0
    4410:	00002097          	auipc	ra,0x2
    4414:	808080e7          	jalr	-2040(ra) # 5c18 <exit>
  sleep(1);
    4418:	4505                	li	a0,1
    441a:	00002097          	auipc	ra,0x2
    441e:	88e080e7          	jalr	-1906(ra) # 5ca8 <sleep>
  if(unlink("oidir") != 0){
    4422:	00004517          	auipc	a0,0x4
    4426:	8b650513          	addi	a0,a0,-1866 # 7cd8 <malloc+0x1c6a>
    442a:	00002097          	auipc	ra,0x2
    442e:	83e080e7          	jalr	-1986(ra) # 5c68 <unlink>
    4432:	cd19                	beqz	a0,4450 <openiputtest+0xda>
    printf("%s: unlink failed\n", s);
    4434:	85a6                	mv	a1,s1
    4436:	00002517          	auipc	a0,0x2
    443a:	7fa50513          	addi	a0,a0,2042 # 6c30 <malloc+0xbc2>
    443e:	00002097          	auipc	ra,0x2
    4442:	b70080e7          	jalr	-1168(ra) # 5fae <printf>
    exit(1);
    4446:	4505                	li	a0,1
    4448:	00001097          	auipc	ra,0x1
    444c:	7d0080e7          	jalr	2000(ra) # 5c18 <exit>
  wait(&xstatus);
    4450:	fdc40513          	addi	a0,s0,-36
    4454:	00001097          	auipc	ra,0x1
    4458:	7cc080e7          	jalr	1996(ra) # 5c20 <wait>
  exit(xstatus);
    445c:	fdc42503          	lw	a0,-36(s0)
    4460:	00001097          	auipc	ra,0x1
    4464:	7b8080e7          	jalr	1976(ra) # 5c18 <exit>

0000000000004468 <forkforkfork>:
{
    4468:	1101                	addi	sp,sp,-32
    446a:	ec06                	sd	ra,24(sp)
    446c:	e822                	sd	s0,16(sp)
    446e:	e426                	sd	s1,8(sp)
    4470:	1000                	addi	s0,sp,32
    4472:	84aa                	mv	s1,a0
  unlink("stopforking");
    4474:	00004517          	auipc	a0,0x4
    4478:	8ac50513          	addi	a0,a0,-1876 # 7d20 <malloc+0x1cb2>
    447c:	00001097          	auipc	ra,0x1
    4480:	7ec080e7          	jalr	2028(ra) # 5c68 <unlink>
  int pid = fork();
    4484:	00001097          	auipc	ra,0x1
    4488:	78c080e7          	jalr	1932(ra) # 5c10 <fork>
  if(pid < 0){
    448c:	04054563          	bltz	a0,44d6 <forkforkfork+0x6e>
  if(pid == 0){
    4490:	c12d                	beqz	a0,44f2 <forkforkfork+0x8a>
  sleep(20); // two seconds
    4492:	4551                	li	a0,20
    4494:	00002097          	auipc	ra,0x2
    4498:	814080e7          	jalr	-2028(ra) # 5ca8 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    449c:	20200593          	li	a1,514
    44a0:	00004517          	auipc	a0,0x4
    44a4:	88050513          	addi	a0,a0,-1920 # 7d20 <malloc+0x1cb2>
    44a8:	00001097          	auipc	ra,0x1
    44ac:	7b0080e7          	jalr	1968(ra) # 5c58 <open>
    44b0:	00001097          	auipc	ra,0x1
    44b4:	790080e7          	jalr	1936(ra) # 5c40 <close>
  wait(0);
    44b8:	4501                	li	a0,0
    44ba:	00001097          	auipc	ra,0x1
    44be:	766080e7          	jalr	1894(ra) # 5c20 <wait>
  sleep(10); // one second
    44c2:	4529                	li	a0,10
    44c4:	00001097          	auipc	ra,0x1
    44c8:	7e4080e7          	jalr	2020(ra) # 5ca8 <sleep>
}
    44cc:	60e2                	ld	ra,24(sp)
    44ce:	6442                	ld	s0,16(sp)
    44d0:	64a2                	ld	s1,8(sp)
    44d2:	6105                	addi	sp,sp,32
    44d4:	8082                	ret
    printf("%s: fork failed", s);
    44d6:	85a6                	mv	a1,s1
    44d8:	00002517          	auipc	a0,0x2
    44dc:	72850513          	addi	a0,a0,1832 # 6c00 <malloc+0xb92>
    44e0:	00002097          	auipc	ra,0x2
    44e4:	ace080e7          	jalr	-1330(ra) # 5fae <printf>
    exit(1);
    44e8:	4505                	li	a0,1
    44ea:	00001097          	auipc	ra,0x1
    44ee:	72e080e7          	jalr	1838(ra) # 5c18 <exit>
      int fd = open("stopforking", 0);
    44f2:	00004497          	auipc	s1,0x4
    44f6:	82e48493          	addi	s1,s1,-2002 # 7d20 <malloc+0x1cb2>
    44fa:	4581                	li	a1,0
    44fc:	8526                	mv	a0,s1
    44fe:	00001097          	auipc	ra,0x1
    4502:	75a080e7          	jalr	1882(ra) # 5c58 <open>
      if(fd >= 0){
    4506:	02055463          	bgez	a0,452e <forkforkfork+0xc6>
      if(fork() < 0){
    450a:	00001097          	auipc	ra,0x1
    450e:	706080e7          	jalr	1798(ra) # 5c10 <fork>
    4512:	fe0554e3          	bgez	a0,44fa <forkforkfork+0x92>
        close(open("stopforking", O_CREATE|O_RDWR));
    4516:	20200593          	li	a1,514
    451a:	8526                	mv	a0,s1
    451c:	00001097          	auipc	ra,0x1
    4520:	73c080e7          	jalr	1852(ra) # 5c58 <open>
    4524:	00001097          	auipc	ra,0x1
    4528:	71c080e7          	jalr	1820(ra) # 5c40 <close>
    452c:	b7f9                	j	44fa <forkforkfork+0x92>
        exit(0);
    452e:	4501                	li	a0,0
    4530:	00001097          	auipc	ra,0x1
    4534:	6e8080e7          	jalr	1768(ra) # 5c18 <exit>

0000000000004538 <killstatus>:
{
    4538:	7139                	addi	sp,sp,-64
    453a:	fc06                	sd	ra,56(sp)
    453c:	f822                	sd	s0,48(sp)
    453e:	f426                	sd	s1,40(sp)
    4540:	f04a                	sd	s2,32(sp)
    4542:	ec4e                	sd	s3,24(sp)
    4544:	e852                	sd	s4,16(sp)
    4546:	0080                	addi	s0,sp,64
    4548:	8a2a                	mv	s4,a0
    454a:	06400913          	li	s2,100
    if(xst != -1) {
    454e:	59fd                	li	s3,-1
    int pid1 = fork();
    4550:	00001097          	auipc	ra,0x1
    4554:	6c0080e7          	jalr	1728(ra) # 5c10 <fork>
    4558:	84aa                	mv	s1,a0
    if(pid1 < 0){
    455a:	02054f63          	bltz	a0,4598 <killstatus+0x60>
    if(pid1 == 0){
    455e:	c939                	beqz	a0,45b4 <killstatus+0x7c>
    sleep(1);
    4560:	4505                	li	a0,1
    4562:	00001097          	auipc	ra,0x1
    4566:	746080e7          	jalr	1862(ra) # 5ca8 <sleep>
    kill(pid1);
    456a:	8526                	mv	a0,s1
    456c:	00001097          	auipc	ra,0x1
    4570:	6dc080e7          	jalr	1756(ra) # 5c48 <kill>
    wait(&xst);
    4574:	fcc40513          	addi	a0,s0,-52
    4578:	00001097          	auipc	ra,0x1
    457c:	6a8080e7          	jalr	1704(ra) # 5c20 <wait>
    if(xst != -1) {
    4580:	fcc42783          	lw	a5,-52(s0)
    4584:	03379d63          	bne	a5,s3,45be <killstatus+0x86>
    4588:	397d                	addiw	s2,s2,-1
  for(int i = 0; i < 100; i++){
    458a:	fc0913e3          	bnez	s2,4550 <killstatus+0x18>
  exit(0);
    458e:	4501                	li	a0,0
    4590:	00001097          	auipc	ra,0x1
    4594:	688080e7          	jalr	1672(ra) # 5c18 <exit>
      printf("%s: fork failed\n", s);
    4598:	85d2                	mv	a1,s4
    459a:	00002517          	auipc	a0,0x2
    459e:	4a650513          	addi	a0,a0,1190 # 6a40 <malloc+0x9d2>
    45a2:	00002097          	auipc	ra,0x2
    45a6:	a0c080e7          	jalr	-1524(ra) # 5fae <printf>
      exit(1);
    45aa:	4505                	li	a0,1
    45ac:	00001097          	auipc	ra,0x1
    45b0:	66c080e7          	jalr	1644(ra) # 5c18 <exit>
        getpid();
    45b4:	00001097          	auipc	ra,0x1
    45b8:	6e4080e7          	jalr	1764(ra) # 5c98 <getpid>
    45bc:	bfe5                	j	45b4 <killstatus+0x7c>
       printf("%s: status should be -1\n", s);
    45be:	85d2                	mv	a1,s4
    45c0:	00003517          	auipc	a0,0x3
    45c4:	77050513          	addi	a0,a0,1904 # 7d30 <malloc+0x1cc2>
    45c8:	00002097          	auipc	ra,0x2
    45cc:	9e6080e7          	jalr	-1562(ra) # 5fae <printf>
       exit(1);
    45d0:	4505                	li	a0,1
    45d2:	00001097          	auipc	ra,0x1
    45d6:	646080e7          	jalr	1606(ra) # 5c18 <exit>

00000000000045da <preempt>:
{
    45da:	7139                	addi	sp,sp,-64
    45dc:	fc06                	sd	ra,56(sp)
    45de:	f822                	sd	s0,48(sp)
    45e0:	f426                	sd	s1,40(sp)
    45e2:	f04a                	sd	s2,32(sp)
    45e4:	ec4e                	sd	s3,24(sp)
    45e6:	e852                	sd	s4,16(sp)
    45e8:	0080                	addi	s0,sp,64
    45ea:	8a2a                	mv	s4,a0
  pid1 = fork();
    45ec:	00001097          	auipc	ra,0x1
    45f0:	624080e7          	jalr	1572(ra) # 5c10 <fork>
  if(pid1 < 0) {
    45f4:	00054563          	bltz	a0,45fe <preempt+0x24>
    45f8:	89aa                	mv	s3,a0
  if(pid1 == 0)
    45fa:	e105                	bnez	a0,461a <preempt+0x40>
      ;
    45fc:	a001                	j	45fc <preempt+0x22>
    printf("%s: fork failed", s);
    45fe:	85d2                	mv	a1,s4
    4600:	00002517          	auipc	a0,0x2
    4604:	60050513          	addi	a0,a0,1536 # 6c00 <malloc+0xb92>
    4608:	00002097          	auipc	ra,0x2
    460c:	9a6080e7          	jalr	-1626(ra) # 5fae <printf>
    exit(1);
    4610:	4505                	li	a0,1
    4612:	00001097          	auipc	ra,0x1
    4616:	606080e7          	jalr	1542(ra) # 5c18 <exit>
  pid2 = fork();
    461a:	00001097          	auipc	ra,0x1
    461e:	5f6080e7          	jalr	1526(ra) # 5c10 <fork>
    4622:	892a                	mv	s2,a0
  if(pid2 < 0) {
    4624:	00054463          	bltz	a0,462c <preempt+0x52>
  if(pid2 == 0)
    4628:	e105                	bnez	a0,4648 <preempt+0x6e>
      ;
    462a:	a001                	j	462a <preempt+0x50>
    printf("%s: fork failed\n", s);
    462c:	85d2                	mv	a1,s4
    462e:	00002517          	auipc	a0,0x2
    4632:	41250513          	addi	a0,a0,1042 # 6a40 <malloc+0x9d2>
    4636:	00002097          	auipc	ra,0x2
    463a:	978080e7          	jalr	-1672(ra) # 5fae <printf>
    exit(1);
    463e:	4505                	li	a0,1
    4640:	00001097          	auipc	ra,0x1
    4644:	5d8080e7          	jalr	1496(ra) # 5c18 <exit>
  pipe(pfds);
    4648:	fc840513          	addi	a0,s0,-56
    464c:	00001097          	auipc	ra,0x1
    4650:	5dc080e7          	jalr	1500(ra) # 5c28 <pipe>
  pid3 = fork();
    4654:	00001097          	auipc	ra,0x1
    4658:	5bc080e7          	jalr	1468(ra) # 5c10 <fork>
    465c:	84aa                	mv	s1,a0
  if(pid3 < 0) {
    465e:	02054e63          	bltz	a0,469a <preempt+0xc0>
  if(pid3 == 0){
    4662:	e525                	bnez	a0,46ca <preempt+0xf0>
    close(pfds[0]);
    4664:	fc842503          	lw	a0,-56(s0)
    4668:	00001097          	auipc	ra,0x1
    466c:	5d8080e7          	jalr	1496(ra) # 5c40 <close>
    if(write(pfds[1], "x", 1) != 1)
    4670:	4605                	li	a2,1
    4672:	00002597          	auipc	a1,0x2
    4676:	bb658593          	addi	a1,a1,-1098 # 6228 <malloc+0x1ba>
    467a:	fcc42503          	lw	a0,-52(s0)
    467e:	00001097          	auipc	ra,0x1
    4682:	5ba080e7          	jalr	1466(ra) # 5c38 <write>
    4686:	4785                	li	a5,1
    4688:	02f51763          	bne	a0,a5,46b6 <preempt+0xdc>
    close(pfds[1]);
    468c:	fcc42503          	lw	a0,-52(s0)
    4690:	00001097          	auipc	ra,0x1
    4694:	5b0080e7          	jalr	1456(ra) # 5c40 <close>
      ;
    4698:	a001                	j	4698 <preempt+0xbe>
     printf("%s: fork failed\n", s);
    469a:	85d2                	mv	a1,s4
    469c:	00002517          	auipc	a0,0x2
    46a0:	3a450513          	addi	a0,a0,932 # 6a40 <malloc+0x9d2>
    46a4:	00002097          	auipc	ra,0x2
    46a8:	90a080e7          	jalr	-1782(ra) # 5fae <printf>
     exit(1);
    46ac:	4505                	li	a0,1
    46ae:	00001097          	auipc	ra,0x1
    46b2:	56a080e7          	jalr	1386(ra) # 5c18 <exit>
      printf("%s: preempt write error", s);
    46b6:	85d2                	mv	a1,s4
    46b8:	00003517          	auipc	a0,0x3
    46bc:	69850513          	addi	a0,a0,1688 # 7d50 <malloc+0x1ce2>
    46c0:	00002097          	auipc	ra,0x2
    46c4:	8ee080e7          	jalr	-1810(ra) # 5fae <printf>
    46c8:	b7d1                	j	468c <preempt+0xb2>
  close(pfds[1]);
    46ca:	fcc42503          	lw	a0,-52(s0)
    46ce:	00001097          	auipc	ra,0x1
    46d2:	572080e7          	jalr	1394(ra) # 5c40 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    46d6:	660d                	lui	a2,0x3
    46d8:	00008597          	auipc	a1,0x8
    46dc:	5a058593          	addi	a1,a1,1440 # cc78 <buf>
    46e0:	fc842503          	lw	a0,-56(s0)
    46e4:	00001097          	auipc	ra,0x1
    46e8:	54c080e7          	jalr	1356(ra) # 5c30 <read>
    46ec:	4785                	li	a5,1
    46ee:	02f50363          	beq	a0,a5,4714 <preempt+0x13a>
    printf("%s: preempt read error", s);
    46f2:	85d2                	mv	a1,s4
    46f4:	00003517          	auipc	a0,0x3
    46f8:	67450513          	addi	a0,a0,1652 # 7d68 <malloc+0x1cfa>
    46fc:	00002097          	auipc	ra,0x2
    4700:	8b2080e7          	jalr	-1870(ra) # 5fae <printf>
}
    4704:	70e2                	ld	ra,56(sp)
    4706:	7442                	ld	s0,48(sp)
    4708:	74a2                	ld	s1,40(sp)
    470a:	7902                	ld	s2,32(sp)
    470c:	69e2                	ld	s3,24(sp)
    470e:	6a42                	ld	s4,16(sp)
    4710:	6121                	addi	sp,sp,64
    4712:	8082                	ret
  close(pfds[0]);
    4714:	fc842503          	lw	a0,-56(s0)
    4718:	00001097          	auipc	ra,0x1
    471c:	528080e7          	jalr	1320(ra) # 5c40 <close>
  printf("kill... ");
    4720:	00003517          	auipc	a0,0x3
    4724:	66050513          	addi	a0,a0,1632 # 7d80 <malloc+0x1d12>
    4728:	00002097          	auipc	ra,0x2
    472c:	886080e7          	jalr	-1914(ra) # 5fae <printf>
  kill(pid1);
    4730:	854e                	mv	a0,s3
    4732:	00001097          	auipc	ra,0x1
    4736:	516080e7          	jalr	1302(ra) # 5c48 <kill>
  kill(pid2);
    473a:	854a                	mv	a0,s2
    473c:	00001097          	auipc	ra,0x1
    4740:	50c080e7          	jalr	1292(ra) # 5c48 <kill>
  kill(pid3);
    4744:	8526                	mv	a0,s1
    4746:	00001097          	auipc	ra,0x1
    474a:	502080e7          	jalr	1282(ra) # 5c48 <kill>
  printf("wait... ");
    474e:	00003517          	auipc	a0,0x3
    4752:	64250513          	addi	a0,a0,1602 # 7d90 <malloc+0x1d22>
    4756:	00002097          	auipc	ra,0x2
    475a:	858080e7          	jalr	-1960(ra) # 5fae <printf>
  wait(0);
    475e:	4501                	li	a0,0
    4760:	00001097          	auipc	ra,0x1
    4764:	4c0080e7          	jalr	1216(ra) # 5c20 <wait>
  wait(0);
    4768:	4501                	li	a0,0
    476a:	00001097          	auipc	ra,0x1
    476e:	4b6080e7          	jalr	1206(ra) # 5c20 <wait>
  wait(0);
    4772:	4501                	li	a0,0
    4774:	00001097          	auipc	ra,0x1
    4778:	4ac080e7          	jalr	1196(ra) # 5c20 <wait>
    477c:	b761                	j	4704 <preempt+0x12a>

000000000000477e <reparent>:
{
    477e:	7179                	addi	sp,sp,-48
    4780:	f406                	sd	ra,40(sp)
    4782:	f022                	sd	s0,32(sp)
    4784:	ec26                	sd	s1,24(sp)
    4786:	e84a                	sd	s2,16(sp)
    4788:	e44e                	sd	s3,8(sp)
    478a:	e052                	sd	s4,0(sp)
    478c:	1800                	addi	s0,sp,48
    478e:	89aa                	mv	s3,a0
  int master_pid = getpid();
    4790:	00001097          	auipc	ra,0x1
    4794:	508080e7          	jalr	1288(ra) # 5c98 <getpid>
    4798:	8a2a                	mv	s4,a0
    479a:	0c800913          	li	s2,200
    int pid = fork();
    479e:	00001097          	auipc	ra,0x1
    47a2:	472080e7          	jalr	1138(ra) # 5c10 <fork>
    47a6:	84aa                	mv	s1,a0
    if(pid < 0){
    47a8:	02054263          	bltz	a0,47cc <reparent+0x4e>
    if(pid){
    47ac:	cd21                	beqz	a0,4804 <reparent+0x86>
      if(wait(0) != pid){
    47ae:	4501                	li	a0,0
    47b0:	00001097          	auipc	ra,0x1
    47b4:	470080e7          	jalr	1136(ra) # 5c20 <wait>
    47b8:	02951863          	bne	a0,s1,47e8 <reparent+0x6a>
    47bc:	397d                	addiw	s2,s2,-1
  for(int i = 0; i < 200; i++){
    47be:	fe0910e3          	bnez	s2,479e <reparent+0x20>
  exit(0);
    47c2:	4501                	li	a0,0
    47c4:	00001097          	auipc	ra,0x1
    47c8:	454080e7          	jalr	1108(ra) # 5c18 <exit>
      printf("%s: fork failed\n", s);
    47cc:	85ce                	mv	a1,s3
    47ce:	00002517          	auipc	a0,0x2
    47d2:	27250513          	addi	a0,a0,626 # 6a40 <malloc+0x9d2>
    47d6:	00001097          	auipc	ra,0x1
    47da:	7d8080e7          	jalr	2008(ra) # 5fae <printf>
      exit(1);
    47de:	4505                	li	a0,1
    47e0:	00001097          	auipc	ra,0x1
    47e4:	438080e7          	jalr	1080(ra) # 5c18 <exit>
        printf("%s: wait wrong pid\n", s);
    47e8:	85ce                	mv	a1,s3
    47ea:	00002517          	auipc	a0,0x2
    47ee:	3de50513          	addi	a0,a0,990 # 6bc8 <malloc+0xb5a>
    47f2:	00001097          	auipc	ra,0x1
    47f6:	7bc080e7          	jalr	1980(ra) # 5fae <printf>
        exit(1);
    47fa:	4505                	li	a0,1
    47fc:	00001097          	auipc	ra,0x1
    4800:	41c080e7          	jalr	1052(ra) # 5c18 <exit>
      int pid2 = fork();
    4804:	00001097          	auipc	ra,0x1
    4808:	40c080e7          	jalr	1036(ra) # 5c10 <fork>
      if(pid2 < 0){
    480c:	00054763          	bltz	a0,481a <reparent+0x9c>
      exit(0);
    4810:	4501                	li	a0,0
    4812:	00001097          	auipc	ra,0x1
    4816:	406080e7          	jalr	1030(ra) # 5c18 <exit>
        kill(master_pid);
    481a:	8552                	mv	a0,s4
    481c:	00001097          	auipc	ra,0x1
    4820:	42c080e7          	jalr	1068(ra) # 5c48 <kill>
        exit(1);
    4824:	4505                	li	a0,1
    4826:	00001097          	auipc	ra,0x1
    482a:	3f2080e7          	jalr	1010(ra) # 5c18 <exit>

000000000000482e <sbrkfail>:
{
    482e:	7119                	addi	sp,sp,-128
    4830:	fc86                	sd	ra,120(sp)
    4832:	f8a2                	sd	s0,112(sp)
    4834:	f4a6                	sd	s1,104(sp)
    4836:	f0ca                	sd	s2,96(sp)
    4838:	ecce                	sd	s3,88(sp)
    483a:	e8d2                	sd	s4,80(sp)
    483c:	e4d6                	sd	s5,72(sp)
    483e:	0100                	addi	s0,sp,128
    4840:	8aaa                	mv	s5,a0
  if(pipe(fds) != 0){
    4842:	fb040513          	addi	a0,s0,-80
    4846:	00001097          	auipc	ra,0x1
    484a:	3e2080e7          	jalr	994(ra) # 5c28 <pipe>
    484e:	e901                	bnez	a0,485e <sbrkfail+0x30>
    4850:	f8040493          	addi	s1,s0,-128
    4854:	fa840993          	addi	s3,s0,-88
    4858:	8926                	mv	s2,s1
    if(pids[i] != -1)
    485a:	5a7d                	li	s4,-1
    485c:	a085                	j	48bc <sbrkfail+0x8e>
    printf("%s: pipe() failed\n", s);
    485e:	85d6                	mv	a1,s5
    4860:	00002517          	auipc	a0,0x2
    4864:	2e850513          	addi	a0,a0,744 # 6b48 <malloc+0xada>
    4868:	00001097          	auipc	ra,0x1
    486c:	746080e7          	jalr	1862(ra) # 5fae <printf>
    exit(1);
    4870:	4505                	li	a0,1
    4872:	00001097          	auipc	ra,0x1
    4876:	3a6080e7          	jalr	934(ra) # 5c18 <exit>
      sbrk(BIG - (uint64)sbrk(0));
    487a:	00001097          	auipc	ra,0x1
    487e:	426080e7          	jalr	1062(ra) # 5ca0 <sbrk>
    4882:	064007b7          	lui	a5,0x6400
    4886:	40a7853b          	subw	a0,a5,a0
    488a:	00001097          	auipc	ra,0x1
    488e:	416080e7          	jalr	1046(ra) # 5ca0 <sbrk>
      write(fds[1], "x", 1);
    4892:	4605                	li	a2,1
    4894:	00002597          	auipc	a1,0x2
    4898:	99458593          	addi	a1,a1,-1644 # 6228 <malloc+0x1ba>
    489c:	fb442503          	lw	a0,-76(s0)
    48a0:	00001097          	auipc	ra,0x1
    48a4:	398080e7          	jalr	920(ra) # 5c38 <write>
      for(;;) sleep(1000);
    48a8:	3e800513          	li	a0,1000
    48ac:	00001097          	auipc	ra,0x1
    48b0:	3fc080e7          	jalr	1020(ra) # 5ca8 <sleep>
    48b4:	bfd5                	j	48a8 <sbrkfail+0x7a>
    48b6:	0911                	addi	s2,s2,4
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    48b8:	03390563          	beq	s2,s3,48e2 <sbrkfail+0xb4>
    if((pids[i] = fork()) == 0){
    48bc:	00001097          	auipc	ra,0x1
    48c0:	354080e7          	jalr	852(ra) # 5c10 <fork>
    48c4:	00a92023          	sw	a0,0(s2)
    48c8:	d94d                	beqz	a0,487a <sbrkfail+0x4c>
    if(pids[i] != -1)
    48ca:	ff4506e3          	beq	a0,s4,48b6 <sbrkfail+0x88>
      read(fds[0], &scratch, 1);
    48ce:	4605                	li	a2,1
    48d0:	faf40593          	addi	a1,s0,-81
    48d4:	fb042503          	lw	a0,-80(s0)
    48d8:	00001097          	auipc	ra,0x1
    48dc:	358080e7          	jalr	856(ra) # 5c30 <read>
    48e0:	bfd9                	j	48b6 <sbrkfail+0x88>
  c = sbrk(PGSIZE);
    48e2:	6505                	lui	a0,0x1
    48e4:	00001097          	auipc	ra,0x1
    48e8:	3bc080e7          	jalr	956(ra) # 5ca0 <sbrk>
    48ec:	892a                	mv	s2,a0
    if(pids[i] == -1)
    48ee:	5a7d                	li	s4,-1
    48f0:	a021                	j	48f8 <sbrkfail+0xca>
    48f2:	0491                	addi	s1,s1,4
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    48f4:	01348f63          	beq	s1,s3,4912 <sbrkfail+0xe4>
    if(pids[i] == -1)
    48f8:	4088                	lw	a0,0(s1)
    48fa:	ff450ce3          	beq	a0,s4,48f2 <sbrkfail+0xc4>
    kill(pids[i]);
    48fe:	00001097          	auipc	ra,0x1
    4902:	34a080e7          	jalr	842(ra) # 5c48 <kill>
    wait(0);
    4906:	4501                	li	a0,0
    4908:	00001097          	auipc	ra,0x1
    490c:	318080e7          	jalr	792(ra) # 5c20 <wait>
    4910:	b7cd                	j	48f2 <sbrkfail+0xc4>
  if(c == (char*)0xffffffffffffffffL){
    4912:	57fd                	li	a5,-1
    4914:	04f90163          	beq	s2,a5,4956 <sbrkfail+0x128>
  pid = fork();
    4918:	00001097          	auipc	ra,0x1
    491c:	2f8080e7          	jalr	760(ra) # 5c10 <fork>
    4920:	84aa                	mv	s1,a0
  if(pid < 0){
    4922:	04054863          	bltz	a0,4972 <sbrkfail+0x144>
  if(pid == 0){
    4926:	c525                	beqz	a0,498e <sbrkfail+0x160>
  wait(&xstatus);
    4928:	fbc40513          	addi	a0,s0,-68
    492c:	00001097          	auipc	ra,0x1
    4930:	2f4080e7          	jalr	756(ra) # 5c20 <wait>
  if(xstatus != -1 && xstatus != 2)
    4934:	fbc42783          	lw	a5,-68(s0)
    4938:	577d                	li	a4,-1
    493a:	00e78563          	beq	a5,a4,4944 <sbrkfail+0x116>
    493e:	4709                	li	a4,2
    4940:	08e79d63          	bne	a5,a4,49da <sbrkfail+0x1ac>
}
    4944:	70e6                	ld	ra,120(sp)
    4946:	7446                	ld	s0,112(sp)
    4948:	74a6                	ld	s1,104(sp)
    494a:	7906                	ld	s2,96(sp)
    494c:	69e6                	ld	s3,88(sp)
    494e:	6a46                	ld	s4,80(sp)
    4950:	6aa6                	ld	s5,72(sp)
    4952:	6109                	addi	sp,sp,128
    4954:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    4956:	85d6                	mv	a1,s5
    4958:	00003517          	auipc	a0,0x3
    495c:	44850513          	addi	a0,a0,1096 # 7da0 <malloc+0x1d32>
    4960:	00001097          	auipc	ra,0x1
    4964:	64e080e7          	jalr	1614(ra) # 5fae <printf>
    exit(1);
    4968:	4505                	li	a0,1
    496a:	00001097          	auipc	ra,0x1
    496e:	2ae080e7          	jalr	686(ra) # 5c18 <exit>
    printf("%s: fork failed\n", s);
    4972:	85d6                	mv	a1,s5
    4974:	00002517          	auipc	a0,0x2
    4978:	0cc50513          	addi	a0,a0,204 # 6a40 <malloc+0x9d2>
    497c:	00001097          	auipc	ra,0x1
    4980:	632080e7          	jalr	1586(ra) # 5fae <printf>
    exit(1);
    4984:	4505                	li	a0,1
    4986:	00001097          	auipc	ra,0x1
    498a:	292080e7          	jalr	658(ra) # 5c18 <exit>
    a = sbrk(0);
    498e:	4501                	li	a0,0
    4990:	00001097          	auipc	ra,0x1
    4994:	310080e7          	jalr	784(ra) # 5ca0 <sbrk>
    4998:	892a                	mv	s2,a0
    sbrk(10*BIG);
    499a:	3e800537          	lui	a0,0x3e800
    499e:	00001097          	auipc	ra,0x1
    49a2:	302080e7          	jalr	770(ra) # 5ca0 <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    49a6:	874a                	mv	a4,s2
    49a8:	3e8007b7          	lui	a5,0x3e800
    49ac:	97ca                	add	a5,a5,s2
    49ae:	6685                	lui	a3,0x1
      n += *(a+i);
    49b0:	00074603          	lbu	a2,0(a4)
    49b4:	9cb1                	addw	s1,s1,a2
    49b6:	9736                	add	a4,a4,a3
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    49b8:	fee79ce3          	bne	a5,a4,49b0 <sbrkfail+0x182>
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    49bc:	8626                	mv	a2,s1
    49be:	85d6                	mv	a1,s5
    49c0:	00003517          	auipc	a0,0x3
    49c4:	40050513          	addi	a0,a0,1024 # 7dc0 <malloc+0x1d52>
    49c8:	00001097          	auipc	ra,0x1
    49cc:	5e6080e7          	jalr	1510(ra) # 5fae <printf>
    exit(1);
    49d0:	4505                	li	a0,1
    49d2:	00001097          	auipc	ra,0x1
    49d6:	246080e7          	jalr	582(ra) # 5c18 <exit>
    exit(1);
    49da:	4505                	li	a0,1
    49dc:	00001097          	auipc	ra,0x1
    49e0:	23c080e7          	jalr	572(ra) # 5c18 <exit>

00000000000049e4 <mem>:
{
    49e4:	7139                	addi	sp,sp,-64
    49e6:	fc06                	sd	ra,56(sp)
    49e8:	f822                	sd	s0,48(sp)
    49ea:	f426                	sd	s1,40(sp)
    49ec:	f04a                	sd	s2,32(sp)
    49ee:	ec4e                	sd	s3,24(sp)
    49f0:	0080                	addi	s0,sp,64
    49f2:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    49f4:	00001097          	auipc	ra,0x1
    49f8:	21c080e7          	jalr	540(ra) # 5c10 <fork>
    m1 = 0;
    49fc:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    49fe:	6909                	lui	s2,0x2
    4a00:	71190913          	addi	s2,s2,1809 # 2711 <copyinstr3+0xdf>
  if((pid = fork()) == 0){
    4a04:	e135                	bnez	a0,4a68 <mem+0x84>
    while((m2 = malloc(10001)) != 0){
    4a06:	854a                	mv	a0,s2
    4a08:	00001097          	auipc	ra,0x1
    4a0c:	666080e7          	jalr	1638(ra) # 606e <malloc>
    4a10:	c501                	beqz	a0,4a18 <mem+0x34>
      *(char**)m2 = m1;
    4a12:	e104                	sd	s1,0(a0)
      m1 = m2;
    4a14:	84aa                	mv	s1,a0
    4a16:	bfc5                	j	4a06 <mem+0x22>
    while(m1){
    4a18:	c899                	beqz	s1,4a2e <mem+0x4a>
      m2 = *(char**)m1;
    4a1a:	0004b903          	ld	s2,0(s1)
      free(m1);
    4a1e:	8526                	mv	a0,s1
    4a20:	00001097          	auipc	ra,0x1
    4a24:	5c4080e7          	jalr	1476(ra) # 5fe4 <free>
      m1 = m2;
    4a28:	84ca                	mv	s1,s2
    while(m1){
    4a2a:	fe0918e3          	bnez	s2,4a1a <mem+0x36>
    m1 = malloc(1024*20);
    4a2e:	6515                	lui	a0,0x5
    4a30:	00001097          	auipc	ra,0x1
    4a34:	63e080e7          	jalr	1598(ra) # 606e <malloc>
    if(m1 == 0){
    4a38:	c911                	beqz	a0,4a4c <mem+0x68>
    free(m1);
    4a3a:	00001097          	auipc	ra,0x1
    4a3e:	5aa080e7          	jalr	1450(ra) # 5fe4 <free>
    exit(0);
    4a42:	4501                	li	a0,0
    4a44:	00001097          	auipc	ra,0x1
    4a48:	1d4080e7          	jalr	468(ra) # 5c18 <exit>
      printf("couldn't allocate mem?!!\n", s);
    4a4c:	85ce                	mv	a1,s3
    4a4e:	00003517          	auipc	a0,0x3
    4a52:	3a250513          	addi	a0,a0,930 # 7df0 <malloc+0x1d82>
    4a56:	00001097          	auipc	ra,0x1
    4a5a:	558080e7          	jalr	1368(ra) # 5fae <printf>
      exit(1);
    4a5e:	4505                	li	a0,1
    4a60:	00001097          	auipc	ra,0x1
    4a64:	1b8080e7          	jalr	440(ra) # 5c18 <exit>
    wait(&xstatus);
    4a68:	fcc40513          	addi	a0,s0,-52
    4a6c:	00001097          	auipc	ra,0x1
    4a70:	1b4080e7          	jalr	436(ra) # 5c20 <wait>
    if(xstatus == -1){
    4a74:	fcc42503          	lw	a0,-52(s0)
    4a78:	57fd                	li	a5,-1
    4a7a:	00f50663          	beq	a0,a5,4a86 <mem+0xa2>
    exit(xstatus);
    4a7e:	00001097          	auipc	ra,0x1
    4a82:	19a080e7          	jalr	410(ra) # 5c18 <exit>
      exit(0);
    4a86:	4501                	li	a0,0
    4a88:	00001097          	auipc	ra,0x1
    4a8c:	190080e7          	jalr	400(ra) # 5c18 <exit>

0000000000004a90 <sharedfd>:
{
    4a90:	7159                	addi	sp,sp,-112
    4a92:	f486                	sd	ra,104(sp)
    4a94:	f0a2                	sd	s0,96(sp)
    4a96:	eca6                	sd	s1,88(sp)
    4a98:	e8ca                	sd	s2,80(sp)
    4a9a:	e4ce                	sd	s3,72(sp)
    4a9c:	e0d2                	sd	s4,64(sp)
    4a9e:	fc56                	sd	s5,56(sp)
    4aa0:	f85a                	sd	s6,48(sp)
    4aa2:	f45e                	sd	s7,40(sp)
    4aa4:	1880                	addi	s0,sp,112
    4aa6:	89aa                	mv	s3,a0
  unlink("sharedfd");
    4aa8:	00003517          	auipc	a0,0x3
    4aac:	36850513          	addi	a0,a0,872 # 7e10 <malloc+0x1da2>
    4ab0:	00001097          	auipc	ra,0x1
    4ab4:	1b8080e7          	jalr	440(ra) # 5c68 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    4ab8:	20200593          	li	a1,514
    4abc:	00003517          	auipc	a0,0x3
    4ac0:	35450513          	addi	a0,a0,852 # 7e10 <malloc+0x1da2>
    4ac4:	00001097          	auipc	ra,0x1
    4ac8:	194080e7          	jalr	404(ra) # 5c58 <open>
  if(fd < 0){
    4acc:	04054a63          	bltz	a0,4b20 <sharedfd+0x90>
    4ad0:	892a                	mv	s2,a0
  pid = fork();
    4ad2:	00001097          	auipc	ra,0x1
    4ad6:	13e080e7          	jalr	318(ra) # 5c10 <fork>
    4ada:	8a2a                	mv	s4,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    4adc:	06300593          	li	a1,99
    4ae0:	c119                	beqz	a0,4ae6 <sharedfd+0x56>
    4ae2:	07000593          	li	a1,112
    4ae6:	4629                	li	a2,10
    4ae8:	fa040513          	addi	a0,s0,-96
    4aec:	00001097          	auipc	ra,0x1
    4af0:	f00080e7          	jalr	-256(ra) # 59ec <memset>
    4af4:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    4af8:	4629                	li	a2,10
    4afa:	fa040593          	addi	a1,s0,-96
    4afe:	854a                	mv	a0,s2
    4b00:	00001097          	auipc	ra,0x1
    4b04:	138080e7          	jalr	312(ra) # 5c38 <write>
    4b08:	47a9                	li	a5,10
    4b0a:	02f51963          	bne	a0,a5,4b3c <sharedfd+0xac>
    4b0e:	34fd                	addiw	s1,s1,-1
  for(i = 0; i < N; i++){
    4b10:	f4e5                	bnez	s1,4af8 <sharedfd+0x68>
  if(pid == 0) {
    4b12:	040a1363          	bnez	s4,4b58 <sharedfd+0xc8>
    exit(0);
    4b16:	4501                	li	a0,0
    4b18:	00001097          	auipc	ra,0x1
    4b1c:	100080e7          	jalr	256(ra) # 5c18 <exit>
    printf("%s: cannot open sharedfd for writing", s);
    4b20:	85ce                	mv	a1,s3
    4b22:	00003517          	auipc	a0,0x3
    4b26:	2fe50513          	addi	a0,a0,766 # 7e20 <malloc+0x1db2>
    4b2a:	00001097          	auipc	ra,0x1
    4b2e:	484080e7          	jalr	1156(ra) # 5fae <printf>
    exit(1);
    4b32:	4505                	li	a0,1
    4b34:	00001097          	auipc	ra,0x1
    4b38:	0e4080e7          	jalr	228(ra) # 5c18 <exit>
      printf("%s: write sharedfd failed\n", s);
    4b3c:	85ce                	mv	a1,s3
    4b3e:	00003517          	auipc	a0,0x3
    4b42:	30a50513          	addi	a0,a0,778 # 7e48 <malloc+0x1dda>
    4b46:	00001097          	auipc	ra,0x1
    4b4a:	468080e7          	jalr	1128(ra) # 5fae <printf>
      exit(1);
    4b4e:	4505                	li	a0,1
    4b50:	00001097          	auipc	ra,0x1
    4b54:	0c8080e7          	jalr	200(ra) # 5c18 <exit>
    wait(&xstatus);
    4b58:	f9c40513          	addi	a0,s0,-100
    4b5c:	00001097          	auipc	ra,0x1
    4b60:	0c4080e7          	jalr	196(ra) # 5c20 <wait>
    if(xstatus != 0)
    4b64:	f9c42a03          	lw	s4,-100(s0)
    4b68:	000a0763          	beqz	s4,4b76 <sharedfd+0xe6>
      exit(xstatus);
    4b6c:	8552                	mv	a0,s4
    4b6e:	00001097          	auipc	ra,0x1
    4b72:	0aa080e7          	jalr	170(ra) # 5c18 <exit>
  close(fd);
    4b76:	854a                	mv	a0,s2
    4b78:	00001097          	auipc	ra,0x1
    4b7c:	0c8080e7          	jalr	200(ra) # 5c40 <close>
  fd = open("sharedfd", 0);
    4b80:	4581                	li	a1,0
    4b82:	00003517          	auipc	a0,0x3
    4b86:	28e50513          	addi	a0,a0,654 # 7e10 <malloc+0x1da2>
    4b8a:	00001097          	auipc	ra,0x1
    4b8e:	0ce080e7          	jalr	206(ra) # 5c58 <open>
    4b92:	8baa                	mv	s7,a0
  nc = np = 0;
    4b94:	8ad2                	mv	s5,s4
  if(fd < 0){
    4b96:	02054563          	bltz	a0,4bc0 <sharedfd+0x130>
    4b9a:	faa40913          	addi	s2,s0,-86
      if(buf[i] == 'c')
    4b9e:	06300493          	li	s1,99
      if(buf[i] == 'p')
    4ba2:	07000b13          	li	s6,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    4ba6:	4629                	li	a2,10
    4ba8:	fa040593          	addi	a1,s0,-96
    4bac:	855e                	mv	a0,s7
    4bae:	00001097          	auipc	ra,0x1
    4bb2:	082080e7          	jalr	130(ra) # 5c30 <read>
    4bb6:	02a05f63          	blez	a0,4bf4 <sharedfd+0x164>
    4bba:	fa040793          	addi	a5,s0,-96
    4bbe:	a01d                	j	4be4 <sharedfd+0x154>
    printf("%s: cannot open sharedfd for reading\n", s);
    4bc0:	85ce                	mv	a1,s3
    4bc2:	00003517          	auipc	a0,0x3
    4bc6:	2a650513          	addi	a0,a0,678 # 7e68 <malloc+0x1dfa>
    4bca:	00001097          	auipc	ra,0x1
    4bce:	3e4080e7          	jalr	996(ra) # 5fae <printf>
    exit(1);
    4bd2:	4505                	li	a0,1
    4bd4:	00001097          	auipc	ra,0x1
    4bd8:	044080e7          	jalr	68(ra) # 5c18 <exit>
        nc++;
    4bdc:	2a05                	addiw	s4,s4,1
      if(buf[i] == 'p')
    4bde:	0785                	addi	a5,a5,1
    for(i = 0; i < sizeof(buf); i++){
    4be0:	fd2783e3          	beq	a5,s2,4ba6 <sharedfd+0x116>
      if(buf[i] == 'c')
    4be4:	0007c703          	lbu	a4,0(a5) # 3e800000 <base+0x3e7f0388>
    4be8:	fe970ae3          	beq	a4,s1,4bdc <sharedfd+0x14c>
      if(buf[i] == 'p')
    4bec:	ff6719e3          	bne	a4,s6,4bde <sharedfd+0x14e>
        np++;
    4bf0:	2a85                	addiw	s5,s5,1
    4bf2:	b7f5                	j	4bde <sharedfd+0x14e>
  close(fd);
    4bf4:	855e                	mv	a0,s7
    4bf6:	00001097          	auipc	ra,0x1
    4bfa:	04a080e7          	jalr	74(ra) # 5c40 <close>
  unlink("sharedfd");
    4bfe:	00003517          	auipc	a0,0x3
    4c02:	21250513          	addi	a0,a0,530 # 7e10 <malloc+0x1da2>
    4c06:	00001097          	auipc	ra,0x1
    4c0a:	062080e7          	jalr	98(ra) # 5c68 <unlink>
  if(nc == N*SZ && np == N*SZ){
    4c0e:	6789                	lui	a5,0x2
    4c10:	71078793          	addi	a5,a5,1808 # 2710 <copyinstr3+0xde>
    4c14:	00fa1763          	bne	s4,a5,4c22 <sharedfd+0x192>
    4c18:	6789                	lui	a5,0x2
    4c1a:	71078793          	addi	a5,a5,1808 # 2710 <copyinstr3+0xde>
    4c1e:	02fa8063          	beq	s5,a5,4c3e <sharedfd+0x1ae>
    printf("%s: nc/np test fails\n", s);
    4c22:	85ce                	mv	a1,s3
    4c24:	00003517          	auipc	a0,0x3
    4c28:	26c50513          	addi	a0,a0,620 # 7e90 <malloc+0x1e22>
    4c2c:	00001097          	auipc	ra,0x1
    4c30:	382080e7          	jalr	898(ra) # 5fae <printf>
    exit(1);
    4c34:	4505                	li	a0,1
    4c36:	00001097          	auipc	ra,0x1
    4c3a:	fe2080e7          	jalr	-30(ra) # 5c18 <exit>
    exit(0);
    4c3e:	4501                	li	a0,0
    4c40:	00001097          	auipc	ra,0x1
    4c44:	fd8080e7          	jalr	-40(ra) # 5c18 <exit>

0000000000004c48 <fourfiles>:
{
    4c48:	7135                	addi	sp,sp,-160
    4c4a:	ed06                	sd	ra,152(sp)
    4c4c:	e922                	sd	s0,144(sp)
    4c4e:	e526                	sd	s1,136(sp)
    4c50:	e14a                	sd	s2,128(sp)
    4c52:	fcce                	sd	s3,120(sp)
    4c54:	f8d2                	sd	s4,112(sp)
    4c56:	f4d6                	sd	s5,104(sp)
    4c58:	f0da                	sd	s6,96(sp)
    4c5a:	ecde                	sd	s7,88(sp)
    4c5c:	e8e2                	sd	s8,80(sp)
    4c5e:	e4e6                	sd	s9,72(sp)
    4c60:	e0ea                	sd	s10,64(sp)
    4c62:	fc6e                	sd	s11,56(sp)
    4c64:	1100                	addi	s0,sp,160
    4c66:	8d2a                	mv	s10,a0
  char *names[] = { "f0", "f1", "f2", "f3" };
    4c68:	00003797          	auipc	a5,0x3
    4c6c:	24078793          	addi	a5,a5,576 # 7ea8 <malloc+0x1e3a>
    4c70:	f6f43823          	sd	a5,-144(s0)
    4c74:	00003797          	auipc	a5,0x3
    4c78:	23c78793          	addi	a5,a5,572 # 7eb0 <malloc+0x1e42>
    4c7c:	f6f43c23          	sd	a5,-136(s0)
    4c80:	00003797          	auipc	a5,0x3
    4c84:	23878793          	addi	a5,a5,568 # 7eb8 <malloc+0x1e4a>
    4c88:	f8f43023          	sd	a5,-128(s0)
    4c8c:	00003797          	auipc	a5,0x3
    4c90:	23478793          	addi	a5,a5,564 # 7ec0 <malloc+0x1e52>
    4c94:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    4c98:	f7040b13          	addi	s6,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    4c9c:	895a                	mv	s2,s6
  for(pi = 0; pi < NCHILD; pi++){
    4c9e:	4481                	li	s1,0
    4ca0:	4a11                	li	s4,4
    fname = names[pi];
    4ca2:	00093983          	ld	s3,0(s2)
    unlink(fname);
    4ca6:	854e                	mv	a0,s3
    4ca8:	00001097          	auipc	ra,0x1
    4cac:	fc0080e7          	jalr	-64(ra) # 5c68 <unlink>
    pid = fork();
    4cb0:	00001097          	auipc	ra,0x1
    4cb4:	f60080e7          	jalr	-160(ra) # 5c10 <fork>
    if(pid < 0){
    4cb8:	04054063          	bltz	a0,4cf8 <fourfiles+0xb0>
    if(pid == 0){
    4cbc:	cd21                	beqz	a0,4d14 <fourfiles+0xcc>
  for(pi = 0; pi < NCHILD; pi++){
    4cbe:	2485                	addiw	s1,s1,1
    4cc0:	0921                	addi	s2,s2,8
    4cc2:	ff4490e3          	bne	s1,s4,4ca2 <fourfiles+0x5a>
    4cc6:	4491                	li	s1,4
    wait(&xstatus);
    4cc8:	f6c40513          	addi	a0,s0,-148
    4ccc:	00001097          	auipc	ra,0x1
    4cd0:	f54080e7          	jalr	-172(ra) # 5c20 <wait>
    if(xstatus != 0)
    4cd4:	f6c42503          	lw	a0,-148(s0)
    4cd8:	e961                	bnez	a0,4da8 <fourfiles+0x160>
    4cda:	34fd                	addiw	s1,s1,-1
  for(pi = 0; pi < NCHILD; pi++){
    4cdc:	f4f5                	bnez	s1,4cc8 <fourfiles+0x80>
    4cde:	03000a93          	li	s5,48
    total = 0;
    4ce2:	8daa                	mv	s11,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4ce4:	00008997          	auipc	s3,0x8
    4ce8:	f9498993          	addi	s3,s3,-108 # cc78 <buf>
    if(total != N*SZ){
    4cec:	6c05                	lui	s8,0x1
    4cee:	770c0c13          	addi	s8,s8,1904 # 1770 <exectest+0x1c>
  for(i = 0; i < NCHILD; i++){
    4cf2:	03400c93          	li	s9,52
    4cf6:	aa15                	j	4e2a <fourfiles+0x1e2>
      printf("fork failed\n", s);
    4cf8:	85ea                	mv	a1,s10
    4cfa:	00002517          	auipc	a0,0x2
    4cfe:	14e50513          	addi	a0,a0,334 # 6e48 <malloc+0xdda>
    4d02:	00001097          	auipc	ra,0x1
    4d06:	2ac080e7          	jalr	684(ra) # 5fae <printf>
      exit(1);
    4d0a:	4505                	li	a0,1
    4d0c:	00001097          	auipc	ra,0x1
    4d10:	f0c080e7          	jalr	-244(ra) # 5c18 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    4d14:	20200593          	li	a1,514
    4d18:	854e                	mv	a0,s3
    4d1a:	00001097          	auipc	ra,0x1
    4d1e:	f3e080e7          	jalr	-194(ra) # 5c58 <open>
    4d22:	892a                	mv	s2,a0
      if(fd < 0){
    4d24:	04054663          	bltz	a0,4d70 <fourfiles+0x128>
      memset(buf, '0'+pi, SZ);
    4d28:	1f400613          	li	a2,500
    4d2c:	0304859b          	addiw	a1,s1,48
    4d30:	00008517          	auipc	a0,0x8
    4d34:	f4850513          	addi	a0,a0,-184 # cc78 <buf>
    4d38:	00001097          	auipc	ra,0x1
    4d3c:	cb4080e7          	jalr	-844(ra) # 59ec <memset>
    4d40:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    4d42:	00008997          	auipc	s3,0x8
    4d46:	f3698993          	addi	s3,s3,-202 # cc78 <buf>
    4d4a:	1f400613          	li	a2,500
    4d4e:	85ce                	mv	a1,s3
    4d50:	854a                	mv	a0,s2
    4d52:	00001097          	auipc	ra,0x1
    4d56:	ee6080e7          	jalr	-282(ra) # 5c38 <write>
    4d5a:	1f400793          	li	a5,500
    4d5e:	02f51763          	bne	a0,a5,4d8c <fourfiles+0x144>
    4d62:	34fd                	addiw	s1,s1,-1
      for(i = 0; i < N; i++){
    4d64:	f0fd                	bnez	s1,4d4a <fourfiles+0x102>
      exit(0);
    4d66:	4501                	li	a0,0
    4d68:	00001097          	auipc	ra,0x1
    4d6c:	eb0080e7          	jalr	-336(ra) # 5c18 <exit>
        printf("create failed\n", s);
    4d70:	85ea                	mv	a1,s10
    4d72:	00003517          	auipc	a0,0x3
    4d76:	15650513          	addi	a0,a0,342 # 7ec8 <malloc+0x1e5a>
    4d7a:	00001097          	auipc	ra,0x1
    4d7e:	234080e7          	jalr	564(ra) # 5fae <printf>
        exit(1);
    4d82:	4505                	li	a0,1
    4d84:	00001097          	auipc	ra,0x1
    4d88:	e94080e7          	jalr	-364(ra) # 5c18 <exit>
          printf("write failed %d\n", n);
    4d8c:	85aa                	mv	a1,a0
    4d8e:	00003517          	auipc	a0,0x3
    4d92:	14a50513          	addi	a0,a0,330 # 7ed8 <malloc+0x1e6a>
    4d96:	00001097          	auipc	ra,0x1
    4d9a:	218080e7          	jalr	536(ra) # 5fae <printf>
          exit(1);
    4d9e:	4505                	li	a0,1
    4da0:	00001097          	auipc	ra,0x1
    4da4:	e78080e7          	jalr	-392(ra) # 5c18 <exit>
      exit(xstatus);
    4da8:	00001097          	auipc	ra,0x1
    4dac:	e70080e7          	jalr	-400(ra) # 5c18 <exit>
      total += n;
    4db0:	00a9093b          	addw	s2,s2,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4db4:	660d                	lui	a2,0x3
    4db6:	85ce                	mv	a1,s3
    4db8:	8552                	mv	a0,s4
    4dba:	00001097          	auipc	ra,0x1
    4dbe:	e76080e7          	jalr	-394(ra) # 5c30 <read>
    4dc2:	04a05463          	blez	a0,4e0a <fourfiles+0x1c2>
        if(buf[j] != '0'+i){
    4dc6:	0009c783          	lbu	a5,0(s3)
    4dca:	02979263          	bne	a5,s1,4dee <fourfiles+0x1a6>
    4dce:	00008797          	auipc	a5,0x8
    4dd2:	eab78793          	addi	a5,a5,-341 # cc79 <buf+0x1>
    4dd6:	fff5069b          	addiw	a3,a0,-1
    4dda:	1682                	slli	a3,a3,0x20
    4ddc:	9281                	srli	a3,a3,0x20
    4dde:	96be                	add	a3,a3,a5
      for(j = 0; j < n; j++){
    4de0:	fcd788e3          	beq	a5,a3,4db0 <fourfiles+0x168>
        if(buf[j] != '0'+i){
    4de4:	0007c703          	lbu	a4,0(a5)
    4de8:	0785                	addi	a5,a5,1
    4dea:	fe970be3          	beq	a4,s1,4de0 <fourfiles+0x198>
          printf("wrong char\n", s);
    4dee:	85ea                	mv	a1,s10
    4df0:	00003517          	auipc	a0,0x3
    4df4:	10050513          	addi	a0,a0,256 # 7ef0 <malloc+0x1e82>
    4df8:	00001097          	auipc	ra,0x1
    4dfc:	1b6080e7          	jalr	438(ra) # 5fae <printf>
          exit(1);
    4e00:	4505                	li	a0,1
    4e02:	00001097          	auipc	ra,0x1
    4e06:	e16080e7          	jalr	-490(ra) # 5c18 <exit>
    close(fd);
    4e0a:	8552                	mv	a0,s4
    4e0c:	00001097          	auipc	ra,0x1
    4e10:	e34080e7          	jalr	-460(ra) # 5c40 <close>
    if(total != N*SZ){
    4e14:	03891863          	bne	s2,s8,4e44 <fourfiles+0x1fc>
    unlink(fname);
    4e18:	855e                	mv	a0,s7
    4e1a:	00001097          	auipc	ra,0x1
    4e1e:	e4e080e7          	jalr	-434(ra) # 5c68 <unlink>
    4e22:	0b21                	addi	s6,s6,8
    4e24:	2a85                	addiw	s5,s5,1
  for(i = 0; i < NCHILD; i++){
    4e26:	039a8d63          	beq	s5,s9,4e60 <fourfiles+0x218>
    fname = names[i];
    4e2a:	000b3b83          	ld	s7,0(s6) # 3000 <execout+0x80>
    fd = open(fname, 0);
    4e2e:	4581                	li	a1,0
    4e30:	855e                	mv	a0,s7
    4e32:	00001097          	auipc	ra,0x1
    4e36:	e26080e7          	jalr	-474(ra) # 5c58 <open>
    4e3a:	8a2a                	mv	s4,a0
    total = 0;
    4e3c:	896e                	mv	s2,s11
    4e3e:	000a849b          	sext.w	s1,s5
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4e42:	bf8d                	j	4db4 <fourfiles+0x16c>
      printf("wrong length %d\n", total);
    4e44:	85ca                	mv	a1,s2
    4e46:	00003517          	auipc	a0,0x3
    4e4a:	0ba50513          	addi	a0,a0,186 # 7f00 <malloc+0x1e92>
    4e4e:	00001097          	auipc	ra,0x1
    4e52:	160080e7          	jalr	352(ra) # 5fae <printf>
      exit(1);
    4e56:	4505                	li	a0,1
    4e58:	00001097          	auipc	ra,0x1
    4e5c:	dc0080e7          	jalr	-576(ra) # 5c18 <exit>
}
    4e60:	60ea                	ld	ra,152(sp)
    4e62:	644a                	ld	s0,144(sp)
    4e64:	64aa                	ld	s1,136(sp)
    4e66:	690a                	ld	s2,128(sp)
    4e68:	79e6                	ld	s3,120(sp)
    4e6a:	7a46                	ld	s4,112(sp)
    4e6c:	7aa6                	ld	s5,104(sp)
    4e6e:	7b06                	ld	s6,96(sp)
    4e70:	6be6                	ld	s7,88(sp)
    4e72:	6c46                	ld	s8,80(sp)
    4e74:	6ca6                	ld	s9,72(sp)
    4e76:	6d06                	ld	s10,64(sp)
    4e78:	7de2                	ld	s11,56(sp)
    4e7a:	610d                	addi	sp,sp,160
    4e7c:	8082                	ret

0000000000004e7e <concreate>:
{
    4e7e:	7135                	addi	sp,sp,-160
    4e80:	ed06                	sd	ra,152(sp)
    4e82:	e922                	sd	s0,144(sp)
    4e84:	e526                	sd	s1,136(sp)
    4e86:	e14a                	sd	s2,128(sp)
    4e88:	fcce                	sd	s3,120(sp)
    4e8a:	f8d2                	sd	s4,112(sp)
    4e8c:	f4d6                	sd	s5,104(sp)
    4e8e:	f0da                	sd	s6,96(sp)
    4e90:	ecde                	sd	s7,88(sp)
    4e92:	1100                	addi	s0,sp,160
    4e94:	89aa                	mv	s3,a0
  file[0] = 'C';
    4e96:	04300793          	li	a5,67
    4e9a:	faf40423          	sb	a5,-88(s0)
  file[2] = '\0';
    4e9e:	fa040523          	sb	zero,-86(s0)
  for(i = 0; i < N; i++){
    4ea2:	4901                	li	s2,0
    if(pid && (i % 3) == 1){
    4ea4:	4b0d                	li	s6,3
    4ea6:	4a85                	li	s5,1
      link("C0", file);
    4ea8:	00003b97          	auipc	s7,0x3
    4eac:	070b8b93          	addi	s7,s7,112 # 7f18 <malloc+0x1eaa>
  for(i = 0; i < N; i++){
    4eb0:	02800a13          	li	s4,40
    4eb4:	acc1                	j	5184 <concreate+0x306>
      link("C0", file);
    4eb6:	fa840593          	addi	a1,s0,-88
    4eba:	855e                	mv	a0,s7
    4ebc:	00001097          	auipc	ra,0x1
    4ec0:	dbc080e7          	jalr	-580(ra) # 5c78 <link>
    if(pid == 0) {
    4ec4:	a45d                	j	516a <concreate+0x2ec>
    } else if(pid == 0 && (i % 5) == 1){
    4ec6:	4795                	li	a5,5
    4ec8:	02f9693b          	remw	s2,s2,a5
    4ecc:	4785                	li	a5,1
    4ece:	02f90b63          	beq	s2,a5,4f04 <concreate+0x86>
      fd = open(file, O_CREATE | O_RDWR);
    4ed2:	20200593          	li	a1,514
    4ed6:	fa840513          	addi	a0,s0,-88
    4eda:	00001097          	auipc	ra,0x1
    4ede:	d7e080e7          	jalr	-642(ra) # 5c58 <open>
      if(fd < 0){
    4ee2:	26055b63          	bgez	a0,5158 <concreate+0x2da>
        printf("concreate create %s failed\n", file);
    4ee6:	fa840593          	addi	a1,s0,-88
    4eea:	00003517          	auipc	a0,0x3
    4eee:	03650513          	addi	a0,a0,54 # 7f20 <malloc+0x1eb2>
    4ef2:	00001097          	auipc	ra,0x1
    4ef6:	0bc080e7          	jalr	188(ra) # 5fae <printf>
        exit(1);
    4efa:	4505                	li	a0,1
    4efc:	00001097          	auipc	ra,0x1
    4f00:	d1c080e7          	jalr	-740(ra) # 5c18 <exit>
      link("C0", file);
    4f04:	fa840593          	addi	a1,s0,-88
    4f08:	00003517          	auipc	a0,0x3
    4f0c:	01050513          	addi	a0,a0,16 # 7f18 <malloc+0x1eaa>
    4f10:	00001097          	auipc	ra,0x1
    4f14:	d68080e7          	jalr	-664(ra) # 5c78 <link>
      exit(0);
    4f18:	4501                	li	a0,0
    4f1a:	00001097          	auipc	ra,0x1
    4f1e:	cfe080e7          	jalr	-770(ra) # 5c18 <exit>
        exit(1);
    4f22:	4505                	li	a0,1
    4f24:	00001097          	auipc	ra,0x1
    4f28:	cf4080e7          	jalr	-780(ra) # 5c18 <exit>
  memset(fa, 0, sizeof(fa));
    4f2c:	02800613          	li	a2,40
    4f30:	4581                	li	a1,0
    4f32:	f8040513          	addi	a0,s0,-128
    4f36:	00001097          	auipc	ra,0x1
    4f3a:	ab6080e7          	jalr	-1354(ra) # 59ec <memset>
  fd = open(".", 0);
    4f3e:	4581                	li	a1,0
    4f40:	00002517          	auipc	a0,0x2
    4f44:	96050513          	addi	a0,a0,-1696 # 68a0 <malloc+0x832>
    4f48:	00001097          	auipc	ra,0x1
    4f4c:	d10080e7          	jalr	-752(ra) # 5c58 <open>
    4f50:	892a                	mv	s2,a0
  n = 0;
    4f52:	8aa6                	mv	s5,s1
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4f54:	04300a13          	li	s4,67
      if(i < 0 || i >= sizeof(fa)){
    4f58:	02700b13          	li	s6,39
      fa[i] = 1;
    4f5c:	4b85                	li	s7,1
  while(read(fd, &de, sizeof(de)) > 0){
    4f5e:	4641                	li	a2,16
    4f60:	f7040593          	addi	a1,s0,-144
    4f64:	854a                	mv	a0,s2
    4f66:	00001097          	auipc	ra,0x1
    4f6a:	cca080e7          	jalr	-822(ra) # 5c30 <read>
    4f6e:	08a05163          	blez	a0,4ff0 <concreate+0x172>
    if(de.inum == 0)
    4f72:	f7045783          	lhu	a5,-144(s0)
    4f76:	d7e5                	beqz	a5,4f5e <concreate+0xe0>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4f78:	f7244783          	lbu	a5,-142(s0)
    4f7c:	ff4791e3          	bne	a5,s4,4f5e <concreate+0xe0>
    4f80:	f7444783          	lbu	a5,-140(s0)
    4f84:	ffe9                	bnez	a5,4f5e <concreate+0xe0>
      i = de.name[1] - '0';
    4f86:	f7344783          	lbu	a5,-141(s0)
    4f8a:	fd07879b          	addiw	a5,a5,-48
    4f8e:	0007871b          	sext.w	a4,a5
      if(i < 0 || i >= sizeof(fa)){
    4f92:	00eb6f63          	bltu	s6,a4,4fb0 <concreate+0x132>
      if(fa[i]){
    4f96:	fb040793          	addi	a5,s0,-80
    4f9a:	97ba                	add	a5,a5,a4
    4f9c:	fd07c783          	lbu	a5,-48(a5)
    4fa0:	eb85                	bnez	a5,4fd0 <concreate+0x152>
      fa[i] = 1;
    4fa2:	fb040793          	addi	a5,s0,-80
    4fa6:	973e                	add	a4,a4,a5
    4fa8:	fd770823          	sb	s7,-48(a4)
      n++;
    4fac:	2a85                	addiw	s5,s5,1
    4fae:	bf45                	j	4f5e <concreate+0xe0>
        printf("%s: concreate weird file %s\n", s, de.name);
    4fb0:	f7240613          	addi	a2,s0,-142
    4fb4:	85ce                	mv	a1,s3
    4fb6:	00003517          	auipc	a0,0x3
    4fba:	f8a50513          	addi	a0,a0,-118 # 7f40 <malloc+0x1ed2>
    4fbe:	00001097          	auipc	ra,0x1
    4fc2:	ff0080e7          	jalr	-16(ra) # 5fae <printf>
        exit(1);
    4fc6:	4505                	li	a0,1
    4fc8:	00001097          	auipc	ra,0x1
    4fcc:	c50080e7          	jalr	-944(ra) # 5c18 <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    4fd0:	f7240613          	addi	a2,s0,-142
    4fd4:	85ce                	mv	a1,s3
    4fd6:	00003517          	auipc	a0,0x3
    4fda:	f8a50513          	addi	a0,a0,-118 # 7f60 <malloc+0x1ef2>
    4fde:	00001097          	auipc	ra,0x1
    4fe2:	fd0080e7          	jalr	-48(ra) # 5fae <printf>
        exit(1);
    4fe6:	4505                	li	a0,1
    4fe8:	00001097          	auipc	ra,0x1
    4fec:	c30080e7          	jalr	-976(ra) # 5c18 <exit>
  close(fd);
    4ff0:	854a                	mv	a0,s2
    4ff2:	00001097          	auipc	ra,0x1
    4ff6:	c4e080e7          	jalr	-946(ra) # 5c40 <close>
  if(n != N){
    4ffa:	02800793          	li	a5,40
    4ffe:	00fa9763          	bne	s5,a5,500c <concreate+0x18e>
    if(((i % 3) == 0 && pid == 0) ||
    5002:	4a8d                	li	s5,3
    5004:	4b05                	li	s6,1
  for(i = 0; i < N; i++){
    5006:	02800a13          	li	s4,40
    500a:	a8c9                	j	50dc <concreate+0x25e>
    printf("%s: concreate not enough files in directory listing\n", s);
    500c:	85ce                	mv	a1,s3
    500e:	00003517          	auipc	a0,0x3
    5012:	f7a50513          	addi	a0,a0,-134 # 7f88 <malloc+0x1f1a>
    5016:	00001097          	auipc	ra,0x1
    501a:	f98080e7          	jalr	-104(ra) # 5fae <printf>
    exit(1);
    501e:	4505                	li	a0,1
    5020:	00001097          	auipc	ra,0x1
    5024:	bf8080e7          	jalr	-1032(ra) # 5c18 <exit>
      printf("%s: fork failed\n", s);
    5028:	85ce                	mv	a1,s3
    502a:	00002517          	auipc	a0,0x2
    502e:	a1650513          	addi	a0,a0,-1514 # 6a40 <malloc+0x9d2>
    5032:	00001097          	auipc	ra,0x1
    5036:	f7c080e7          	jalr	-132(ra) # 5fae <printf>
      exit(1);
    503a:	4505                	li	a0,1
    503c:	00001097          	auipc	ra,0x1
    5040:	bdc080e7          	jalr	-1060(ra) # 5c18 <exit>
      close(open(file, 0));
    5044:	4581                	li	a1,0
    5046:	fa840513          	addi	a0,s0,-88
    504a:	00001097          	auipc	ra,0x1
    504e:	c0e080e7          	jalr	-1010(ra) # 5c58 <open>
    5052:	00001097          	auipc	ra,0x1
    5056:	bee080e7          	jalr	-1042(ra) # 5c40 <close>
      close(open(file, 0));
    505a:	4581                	li	a1,0
    505c:	fa840513          	addi	a0,s0,-88
    5060:	00001097          	auipc	ra,0x1
    5064:	bf8080e7          	jalr	-1032(ra) # 5c58 <open>
    5068:	00001097          	auipc	ra,0x1
    506c:	bd8080e7          	jalr	-1064(ra) # 5c40 <close>
      close(open(file, 0));
    5070:	4581                	li	a1,0
    5072:	fa840513          	addi	a0,s0,-88
    5076:	00001097          	auipc	ra,0x1
    507a:	be2080e7          	jalr	-1054(ra) # 5c58 <open>
    507e:	00001097          	auipc	ra,0x1
    5082:	bc2080e7          	jalr	-1086(ra) # 5c40 <close>
      close(open(file, 0));
    5086:	4581                	li	a1,0
    5088:	fa840513          	addi	a0,s0,-88
    508c:	00001097          	auipc	ra,0x1
    5090:	bcc080e7          	jalr	-1076(ra) # 5c58 <open>
    5094:	00001097          	auipc	ra,0x1
    5098:	bac080e7          	jalr	-1108(ra) # 5c40 <close>
      close(open(file, 0));
    509c:	4581                	li	a1,0
    509e:	fa840513          	addi	a0,s0,-88
    50a2:	00001097          	auipc	ra,0x1
    50a6:	bb6080e7          	jalr	-1098(ra) # 5c58 <open>
    50aa:	00001097          	auipc	ra,0x1
    50ae:	b96080e7          	jalr	-1130(ra) # 5c40 <close>
      close(open(file, 0));
    50b2:	4581                	li	a1,0
    50b4:	fa840513          	addi	a0,s0,-88
    50b8:	00001097          	auipc	ra,0x1
    50bc:	ba0080e7          	jalr	-1120(ra) # 5c58 <open>
    50c0:	00001097          	auipc	ra,0x1
    50c4:	b80080e7          	jalr	-1152(ra) # 5c40 <close>
    if(pid == 0)
    50c8:	08090363          	beqz	s2,514e <concreate+0x2d0>
      wait(0);
    50cc:	4501                	li	a0,0
    50ce:	00001097          	auipc	ra,0x1
    50d2:	b52080e7          	jalr	-1198(ra) # 5c20 <wait>
  for(i = 0; i < N; i++){
    50d6:	2485                	addiw	s1,s1,1
    50d8:	0f448563          	beq	s1,s4,51c2 <concreate+0x344>
    file[1] = '0' + i;
    50dc:	0304879b          	addiw	a5,s1,48
    50e0:	faf404a3          	sb	a5,-87(s0)
    pid = fork();
    50e4:	00001097          	auipc	ra,0x1
    50e8:	b2c080e7          	jalr	-1236(ra) # 5c10 <fork>
    50ec:	892a                	mv	s2,a0
    if(pid < 0){
    50ee:	f2054de3          	bltz	a0,5028 <concreate+0x1aa>
    if(((i % 3) == 0 && pid == 0) ||
    50f2:	0354e73b          	remw	a4,s1,s5
    50f6:	00a767b3          	or	a5,a4,a0
    50fa:	2781                	sext.w	a5,a5
    50fc:	d7a1                	beqz	a5,5044 <concreate+0x1c6>
    50fe:	01671363          	bne	a4,s6,5104 <concreate+0x286>
       ((i % 3) == 1 && pid != 0)){
    5102:	f129                	bnez	a0,5044 <concreate+0x1c6>
      unlink(file);
    5104:	fa840513          	addi	a0,s0,-88
    5108:	00001097          	auipc	ra,0x1
    510c:	b60080e7          	jalr	-1184(ra) # 5c68 <unlink>
      unlink(file);
    5110:	fa840513          	addi	a0,s0,-88
    5114:	00001097          	auipc	ra,0x1
    5118:	b54080e7          	jalr	-1196(ra) # 5c68 <unlink>
      unlink(file);
    511c:	fa840513          	addi	a0,s0,-88
    5120:	00001097          	auipc	ra,0x1
    5124:	b48080e7          	jalr	-1208(ra) # 5c68 <unlink>
      unlink(file);
    5128:	fa840513          	addi	a0,s0,-88
    512c:	00001097          	auipc	ra,0x1
    5130:	b3c080e7          	jalr	-1220(ra) # 5c68 <unlink>
      unlink(file);
    5134:	fa840513          	addi	a0,s0,-88
    5138:	00001097          	auipc	ra,0x1
    513c:	b30080e7          	jalr	-1232(ra) # 5c68 <unlink>
      unlink(file);
    5140:	fa840513          	addi	a0,s0,-88
    5144:	00001097          	auipc	ra,0x1
    5148:	b24080e7          	jalr	-1244(ra) # 5c68 <unlink>
    514c:	bfb5                	j	50c8 <concreate+0x24a>
      exit(0);
    514e:	4501                	li	a0,0
    5150:	00001097          	auipc	ra,0x1
    5154:	ac8080e7          	jalr	-1336(ra) # 5c18 <exit>
      close(fd);
    5158:	00001097          	auipc	ra,0x1
    515c:	ae8080e7          	jalr	-1304(ra) # 5c40 <close>
    if(pid == 0) {
    5160:	bb65                	j	4f18 <concreate+0x9a>
      close(fd);
    5162:	00001097          	auipc	ra,0x1
    5166:	ade080e7          	jalr	-1314(ra) # 5c40 <close>
      wait(&xstatus);
    516a:	f6c40513          	addi	a0,s0,-148
    516e:	00001097          	auipc	ra,0x1
    5172:	ab2080e7          	jalr	-1358(ra) # 5c20 <wait>
      if(xstatus != 0)
    5176:	f6c42483          	lw	s1,-148(s0)
    517a:	da0494e3          	bnez	s1,4f22 <concreate+0xa4>
  for(i = 0; i < N; i++){
    517e:	2905                	addiw	s2,s2,1
    5180:	db4906e3          	beq	s2,s4,4f2c <concreate+0xae>
    file[1] = '0' + i;
    5184:	0309079b          	addiw	a5,s2,48
    5188:	faf404a3          	sb	a5,-87(s0)
    unlink(file);
    518c:	fa840513          	addi	a0,s0,-88
    5190:	00001097          	auipc	ra,0x1
    5194:	ad8080e7          	jalr	-1320(ra) # 5c68 <unlink>
    pid = fork();
    5198:	00001097          	auipc	ra,0x1
    519c:	a78080e7          	jalr	-1416(ra) # 5c10 <fork>
    if(pid && (i % 3) == 1){
    51a0:	d20503e3          	beqz	a0,4ec6 <concreate+0x48>
    51a4:	036967bb          	remw	a5,s2,s6
    51a8:	d15787e3          	beq	a5,s5,4eb6 <concreate+0x38>
      fd = open(file, O_CREATE | O_RDWR);
    51ac:	20200593          	li	a1,514
    51b0:	fa840513          	addi	a0,s0,-88
    51b4:	00001097          	auipc	ra,0x1
    51b8:	aa4080e7          	jalr	-1372(ra) # 5c58 <open>
      if(fd < 0){
    51bc:	fa0553e3          	bgez	a0,5162 <concreate+0x2e4>
    51c0:	b31d                	j	4ee6 <concreate+0x68>
}
    51c2:	60ea                	ld	ra,152(sp)
    51c4:	644a                	ld	s0,144(sp)
    51c6:	64aa                	ld	s1,136(sp)
    51c8:	690a                	ld	s2,128(sp)
    51ca:	79e6                	ld	s3,120(sp)
    51cc:	7a46                	ld	s4,112(sp)
    51ce:	7aa6                	ld	s5,104(sp)
    51d0:	7b06                	ld	s6,96(sp)
    51d2:	6be6                	ld	s7,88(sp)
    51d4:	610d                	addi	sp,sp,160
    51d6:	8082                	ret

00000000000051d8 <bigfile>:
{
    51d8:	7139                	addi	sp,sp,-64
    51da:	fc06                	sd	ra,56(sp)
    51dc:	f822                	sd	s0,48(sp)
    51de:	f426                	sd	s1,40(sp)
    51e0:	f04a                	sd	s2,32(sp)
    51e2:	ec4e                	sd	s3,24(sp)
    51e4:	e852                	sd	s4,16(sp)
    51e6:	e456                	sd	s5,8(sp)
    51e8:	0080                	addi	s0,sp,64
    51ea:	8aaa                	mv	s5,a0
  unlink("bigfile.dat");
    51ec:	00003517          	auipc	a0,0x3
    51f0:	dd450513          	addi	a0,a0,-556 # 7fc0 <malloc+0x1f52>
    51f4:	00001097          	auipc	ra,0x1
    51f8:	a74080e7          	jalr	-1420(ra) # 5c68 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    51fc:	20200593          	li	a1,514
    5200:	00003517          	auipc	a0,0x3
    5204:	dc050513          	addi	a0,a0,-576 # 7fc0 <malloc+0x1f52>
    5208:	00001097          	auipc	ra,0x1
    520c:	a50080e7          	jalr	-1456(ra) # 5c58 <open>
    5210:	89aa                	mv	s3,a0
  for(i = 0; i < N; i++){
    5212:	4481                	li	s1,0
    memset(buf, i, SZ);
    5214:	00008917          	auipc	s2,0x8
    5218:	a6490913          	addi	s2,s2,-1436 # cc78 <buf>
  for(i = 0; i < N; i++){
    521c:	4a51                	li	s4,20
  if(fd < 0){
    521e:	0a054063          	bltz	a0,52be <bigfile+0xe6>
    memset(buf, i, SZ);
    5222:	25800613          	li	a2,600
    5226:	85a6                	mv	a1,s1
    5228:	854a                	mv	a0,s2
    522a:	00000097          	auipc	ra,0x0
    522e:	7c2080e7          	jalr	1986(ra) # 59ec <memset>
    if(write(fd, buf, SZ) != SZ){
    5232:	25800613          	li	a2,600
    5236:	85ca                	mv	a1,s2
    5238:	854e                	mv	a0,s3
    523a:	00001097          	auipc	ra,0x1
    523e:	9fe080e7          	jalr	-1538(ra) # 5c38 <write>
    5242:	25800793          	li	a5,600
    5246:	08f51a63          	bne	a0,a5,52da <bigfile+0x102>
  for(i = 0; i < N; i++){
    524a:	2485                	addiw	s1,s1,1
    524c:	fd449be3          	bne	s1,s4,5222 <bigfile+0x4a>
  close(fd);
    5250:	854e                	mv	a0,s3
    5252:	00001097          	auipc	ra,0x1
    5256:	9ee080e7          	jalr	-1554(ra) # 5c40 <close>
  fd = open("bigfile.dat", 0);
    525a:	4581                	li	a1,0
    525c:	00003517          	auipc	a0,0x3
    5260:	d6450513          	addi	a0,a0,-668 # 7fc0 <malloc+0x1f52>
    5264:	00001097          	auipc	ra,0x1
    5268:	9f4080e7          	jalr	-1548(ra) # 5c58 <open>
    526c:	8a2a                	mv	s4,a0
  total = 0;
    526e:	4981                	li	s3,0
  for(i = 0; ; i++){
    5270:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    5272:	00008917          	auipc	s2,0x8
    5276:	a0690913          	addi	s2,s2,-1530 # cc78 <buf>
  if(fd < 0){
    527a:	06054e63          	bltz	a0,52f6 <bigfile+0x11e>
    cc = read(fd, buf, SZ/2);
    527e:	12c00613          	li	a2,300
    5282:	85ca                	mv	a1,s2
    5284:	8552                	mv	a0,s4
    5286:	00001097          	auipc	ra,0x1
    528a:	9aa080e7          	jalr	-1622(ra) # 5c30 <read>
    if(cc < 0){
    528e:	08054263          	bltz	a0,5312 <bigfile+0x13a>
    if(cc == 0)
    5292:	c971                	beqz	a0,5366 <bigfile+0x18e>
    if(cc != SZ/2){
    5294:	12c00793          	li	a5,300
    5298:	08f51b63          	bne	a0,a5,532e <bigfile+0x156>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    529c:	01f4d79b          	srliw	a5,s1,0x1f
    52a0:	9fa5                	addw	a5,a5,s1
    52a2:	4017d79b          	sraiw	a5,a5,0x1
    52a6:	00094703          	lbu	a4,0(s2)
    52aa:	0af71063          	bne	a4,a5,534a <bigfile+0x172>
    52ae:	12b94703          	lbu	a4,299(s2)
    52b2:	08f71c63          	bne	a4,a5,534a <bigfile+0x172>
    total += cc;
    52b6:	12c9899b          	addiw	s3,s3,300
  for(i = 0; ; i++){
    52ba:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    52bc:	b7c9                	j	527e <bigfile+0xa6>
    printf("%s: cannot create bigfile", s);
    52be:	85d6                	mv	a1,s5
    52c0:	00003517          	auipc	a0,0x3
    52c4:	d1050513          	addi	a0,a0,-752 # 7fd0 <malloc+0x1f62>
    52c8:	00001097          	auipc	ra,0x1
    52cc:	ce6080e7          	jalr	-794(ra) # 5fae <printf>
    exit(1);
    52d0:	4505                	li	a0,1
    52d2:	00001097          	auipc	ra,0x1
    52d6:	946080e7          	jalr	-1722(ra) # 5c18 <exit>
      printf("%s: write bigfile failed\n", s);
    52da:	85d6                	mv	a1,s5
    52dc:	00003517          	auipc	a0,0x3
    52e0:	d1450513          	addi	a0,a0,-748 # 7ff0 <malloc+0x1f82>
    52e4:	00001097          	auipc	ra,0x1
    52e8:	cca080e7          	jalr	-822(ra) # 5fae <printf>
      exit(1);
    52ec:	4505                	li	a0,1
    52ee:	00001097          	auipc	ra,0x1
    52f2:	92a080e7          	jalr	-1750(ra) # 5c18 <exit>
    printf("%s: cannot open bigfile\n", s);
    52f6:	85d6                	mv	a1,s5
    52f8:	00003517          	auipc	a0,0x3
    52fc:	d1850513          	addi	a0,a0,-744 # 8010 <malloc+0x1fa2>
    5300:	00001097          	auipc	ra,0x1
    5304:	cae080e7          	jalr	-850(ra) # 5fae <printf>
    exit(1);
    5308:	4505                	li	a0,1
    530a:	00001097          	auipc	ra,0x1
    530e:	90e080e7          	jalr	-1778(ra) # 5c18 <exit>
      printf("%s: read bigfile failed\n", s);
    5312:	85d6                	mv	a1,s5
    5314:	00003517          	auipc	a0,0x3
    5318:	d1c50513          	addi	a0,a0,-740 # 8030 <malloc+0x1fc2>
    531c:	00001097          	auipc	ra,0x1
    5320:	c92080e7          	jalr	-878(ra) # 5fae <printf>
      exit(1);
    5324:	4505                	li	a0,1
    5326:	00001097          	auipc	ra,0x1
    532a:	8f2080e7          	jalr	-1806(ra) # 5c18 <exit>
      printf("%s: short read bigfile\n", s);
    532e:	85d6                	mv	a1,s5
    5330:	00003517          	auipc	a0,0x3
    5334:	d2050513          	addi	a0,a0,-736 # 8050 <malloc+0x1fe2>
    5338:	00001097          	auipc	ra,0x1
    533c:	c76080e7          	jalr	-906(ra) # 5fae <printf>
      exit(1);
    5340:	4505                	li	a0,1
    5342:	00001097          	auipc	ra,0x1
    5346:	8d6080e7          	jalr	-1834(ra) # 5c18 <exit>
      printf("%s: read bigfile wrong data\n", s);
    534a:	85d6                	mv	a1,s5
    534c:	00003517          	auipc	a0,0x3
    5350:	d1c50513          	addi	a0,a0,-740 # 8068 <malloc+0x1ffa>
    5354:	00001097          	auipc	ra,0x1
    5358:	c5a080e7          	jalr	-934(ra) # 5fae <printf>
      exit(1);
    535c:	4505                	li	a0,1
    535e:	00001097          	auipc	ra,0x1
    5362:	8ba080e7          	jalr	-1862(ra) # 5c18 <exit>
  close(fd);
    5366:	8552                	mv	a0,s4
    5368:	00001097          	auipc	ra,0x1
    536c:	8d8080e7          	jalr	-1832(ra) # 5c40 <close>
  if(total != N*SZ){
    5370:	678d                	lui	a5,0x3
    5372:	ee078793          	addi	a5,a5,-288 # 2ee0 <sbrklast+0x68>
    5376:	02f99363          	bne	s3,a5,539c <bigfile+0x1c4>
  unlink("bigfile.dat");
    537a:	00003517          	auipc	a0,0x3
    537e:	c4650513          	addi	a0,a0,-954 # 7fc0 <malloc+0x1f52>
    5382:	00001097          	auipc	ra,0x1
    5386:	8e6080e7          	jalr	-1818(ra) # 5c68 <unlink>
}
    538a:	70e2                	ld	ra,56(sp)
    538c:	7442                	ld	s0,48(sp)
    538e:	74a2                	ld	s1,40(sp)
    5390:	7902                	ld	s2,32(sp)
    5392:	69e2                	ld	s3,24(sp)
    5394:	6a42                	ld	s4,16(sp)
    5396:	6aa2                	ld	s5,8(sp)
    5398:	6121                	addi	sp,sp,64
    539a:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    539c:	85d6                	mv	a1,s5
    539e:	00003517          	auipc	a0,0x3
    53a2:	cea50513          	addi	a0,a0,-790 # 8088 <malloc+0x201a>
    53a6:	00001097          	auipc	ra,0x1
    53aa:	c08080e7          	jalr	-1016(ra) # 5fae <printf>
    exit(1);
    53ae:	4505                	li	a0,1
    53b0:	00001097          	auipc	ra,0x1
    53b4:	868080e7          	jalr	-1944(ra) # 5c18 <exit>

00000000000053b8 <fsfull>:
{
    53b8:	7171                	addi	sp,sp,-176
    53ba:	f506                	sd	ra,168(sp)
    53bc:	f122                	sd	s0,160(sp)
    53be:	ed26                	sd	s1,152(sp)
    53c0:	e94a                	sd	s2,144(sp)
    53c2:	e54e                	sd	s3,136(sp)
    53c4:	e152                	sd	s4,128(sp)
    53c6:	fcd6                	sd	s5,120(sp)
    53c8:	f8da                	sd	s6,112(sp)
    53ca:	f4de                	sd	s7,104(sp)
    53cc:	f0e2                	sd	s8,96(sp)
    53ce:	ece6                	sd	s9,88(sp)
    53d0:	e8ea                	sd	s10,80(sp)
    53d2:	e4ee                	sd	s11,72(sp)
    53d4:	1900                	addi	s0,sp,176
  printf("fsfull test\n");
    53d6:	00003517          	auipc	a0,0x3
    53da:	cd250513          	addi	a0,a0,-814 # 80a8 <malloc+0x203a>
    53de:	00001097          	auipc	ra,0x1
    53e2:	bd0080e7          	jalr	-1072(ra) # 5fae <printf>
  for(nfiles = 0; ; nfiles++){
    53e6:	4481                	li	s1,0
    name[0] = 'f';
    53e8:	06600d13          	li	s10,102
    name[1] = '0' + nfiles / 1000;
    53ec:	3e800c13          	li	s8,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    53f0:	06400b93          	li	s7,100
    name[3] = '0' + (nfiles % 100) / 10;
    53f4:	4b29                	li	s6,10
    printf("writing %s\n", name);
    53f6:	00003c97          	auipc	s9,0x3
    53fa:	cc2c8c93          	addi	s9,s9,-830 # 80b8 <malloc+0x204a>
    int total = 0;
    53fe:	4d81                	li	s11,0
      int cc = write(fd, buf, BSIZE);
    5400:	00008a17          	auipc	s4,0x8
    5404:	878a0a13          	addi	s4,s4,-1928 # cc78 <buf>
    name[0] = 'f';
    5408:	f5a40823          	sb	s10,-176(s0)
    name[1] = '0' + nfiles / 1000;
    540c:	0384c7bb          	divw	a5,s1,s8
    5410:	0307879b          	addiw	a5,a5,48
    5414:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    5418:	0384e7bb          	remw	a5,s1,s8
    541c:	0377c7bb          	divw	a5,a5,s7
    5420:	0307879b          	addiw	a5,a5,48
    5424:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    5428:	0374e7bb          	remw	a5,s1,s7
    542c:	0367c7bb          	divw	a5,a5,s6
    5430:	0307879b          	addiw	a5,a5,48
    5434:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    5438:	0364e7bb          	remw	a5,s1,s6
    543c:	0307879b          	addiw	a5,a5,48
    5440:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    5444:	f4040aa3          	sb	zero,-171(s0)
    printf("writing %s\n", name);
    5448:	f5040593          	addi	a1,s0,-176
    544c:	8566                	mv	a0,s9
    544e:	00001097          	auipc	ra,0x1
    5452:	b60080e7          	jalr	-1184(ra) # 5fae <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    5456:	20200593          	li	a1,514
    545a:	f5040513          	addi	a0,s0,-176
    545e:	00000097          	auipc	ra,0x0
    5462:	7fa080e7          	jalr	2042(ra) # 5c58 <open>
    5466:	89aa                	mv	s3,a0
    if(fd < 0){
    5468:	0a055663          	bgez	a0,5514 <fsfull+0x15c>
      printf("open %s failed\n", name);
    546c:	f5040593          	addi	a1,s0,-176
    5470:	00003517          	auipc	a0,0x3
    5474:	c5850513          	addi	a0,a0,-936 # 80c8 <malloc+0x205a>
    5478:	00001097          	auipc	ra,0x1
    547c:	b36080e7          	jalr	-1226(ra) # 5fae <printf>
  while(nfiles >= 0){
    5480:	0604c363          	bltz	s1,54e6 <fsfull+0x12e>
    name[0] = 'f';
    5484:	06600b13          	li	s6,102
    name[1] = '0' + nfiles / 1000;
    5488:	3e800a13          	li	s4,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    548c:	06400993          	li	s3,100
    name[3] = '0' + (nfiles % 100) / 10;
    5490:	4929                	li	s2,10
  while(nfiles >= 0){
    5492:	5afd                	li	s5,-1
    name[0] = 'f';
    5494:	f5640823          	sb	s6,-176(s0)
    name[1] = '0' + nfiles / 1000;
    5498:	0344c7bb          	divw	a5,s1,s4
    549c:	0307879b          	addiw	a5,a5,48
    54a0:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    54a4:	0344e7bb          	remw	a5,s1,s4
    54a8:	0337c7bb          	divw	a5,a5,s3
    54ac:	0307879b          	addiw	a5,a5,48
    54b0:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    54b4:	0334e7bb          	remw	a5,s1,s3
    54b8:	0327c7bb          	divw	a5,a5,s2
    54bc:	0307879b          	addiw	a5,a5,48
    54c0:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    54c4:	0324e7bb          	remw	a5,s1,s2
    54c8:	0307879b          	addiw	a5,a5,48
    54cc:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    54d0:	f4040aa3          	sb	zero,-171(s0)
    unlink(name);
    54d4:	f5040513          	addi	a0,s0,-176
    54d8:	00000097          	auipc	ra,0x0
    54dc:	790080e7          	jalr	1936(ra) # 5c68 <unlink>
    nfiles--;
    54e0:	34fd                	addiw	s1,s1,-1
  while(nfiles >= 0){
    54e2:	fb5499e3          	bne	s1,s5,5494 <fsfull+0xdc>
  printf("fsfull test finished\n");
    54e6:	00003517          	auipc	a0,0x3
    54ea:	c0250513          	addi	a0,a0,-1022 # 80e8 <malloc+0x207a>
    54ee:	00001097          	auipc	ra,0x1
    54f2:	ac0080e7          	jalr	-1344(ra) # 5fae <printf>
}
    54f6:	70aa                	ld	ra,168(sp)
    54f8:	740a                	ld	s0,160(sp)
    54fa:	64ea                	ld	s1,152(sp)
    54fc:	694a                	ld	s2,144(sp)
    54fe:	69aa                	ld	s3,136(sp)
    5500:	6a0a                	ld	s4,128(sp)
    5502:	7ae6                	ld	s5,120(sp)
    5504:	7b46                	ld	s6,112(sp)
    5506:	7ba6                	ld	s7,104(sp)
    5508:	7c06                	ld	s8,96(sp)
    550a:	6ce6                	ld	s9,88(sp)
    550c:	6d46                	ld	s10,80(sp)
    550e:	6da6                	ld	s11,72(sp)
    5510:	614d                	addi	sp,sp,176
    5512:	8082                	ret
    int total = 0;
    5514:	896e                	mv	s2,s11
      if(cc < BSIZE)
    5516:	3ff00a93          	li	s5,1023
      int cc = write(fd, buf, BSIZE);
    551a:	40000613          	li	a2,1024
    551e:	85d2                	mv	a1,s4
    5520:	854e                	mv	a0,s3
    5522:	00000097          	auipc	ra,0x0
    5526:	716080e7          	jalr	1814(ra) # 5c38 <write>
      if(cc < BSIZE)
    552a:	00aad563          	bge	s5,a0,5534 <fsfull+0x17c>
      total += cc;
    552e:	00a9093b          	addw	s2,s2,a0
    while(1){
    5532:	b7e5                	j	551a <fsfull+0x162>
    printf("wrote %d bytes\n", total);
    5534:	85ca                	mv	a1,s2
    5536:	00003517          	auipc	a0,0x3
    553a:	ba250513          	addi	a0,a0,-1118 # 80d8 <malloc+0x206a>
    553e:	00001097          	auipc	ra,0x1
    5542:	a70080e7          	jalr	-1424(ra) # 5fae <printf>
    close(fd);
    5546:	854e                	mv	a0,s3
    5548:	00000097          	auipc	ra,0x0
    554c:	6f8080e7          	jalr	1784(ra) # 5c40 <close>
    if(total == 0)
    5550:	f20908e3          	beqz	s2,5480 <fsfull+0xc8>
  for(nfiles = 0; ; nfiles++){
    5554:	2485                	addiw	s1,s1,1
    5556:	bd4d                	j	5408 <fsfull+0x50>

0000000000005558 <run>:
//

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    5558:	7179                	addi	sp,sp,-48
    555a:	f406                	sd	ra,40(sp)
    555c:	f022                	sd	s0,32(sp)
    555e:	ec26                	sd	s1,24(sp)
    5560:	e84a                	sd	s2,16(sp)
    5562:	1800                	addi	s0,sp,48
    5564:	84aa                	mv	s1,a0
    5566:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    5568:	00003517          	auipc	a0,0x3
    556c:	b9850513          	addi	a0,a0,-1128 # 8100 <malloc+0x2092>
    5570:	00001097          	auipc	ra,0x1
    5574:	a3e080e7          	jalr	-1474(ra) # 5fae <printf>
  if((pid = fork()) < 0) {
    5578:	00000097          	auipc	ra,0x0
    557c:	698080e7          	jalr	1688(ra) # 5c10 <fork>
    5580:	02054e63          	bltz	a0,55bc <run+0x64>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    5584:	c929                	beqz	a0,55d6 <run+0x7e>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    5586:	fdc40513          	addi	a0,s0,-36
    558a:	00000097          	auipc	ra,0x0
    558e:	696080e7          	jalr	1686(ra) # 5c20 <wait>
    if(xstatus != 0) 
    5592:	fdc42783          	lw	a5,-36(s0)
    5596:	c7b9                	beqz	a5,55e4 <run+0x8c>
      printf("FAILED\n");
    5598:	00003517          	auipc	a0,0x3
    559c:	b9050513          	addi	a0,a0,-1136 # 8128 <malloc+0x20ba>
    55a0:	00001097          	auipc	ra,0x1
    55a4:	a0e080e7          	jalr	-1522(ra) # 5fae <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    55a8:	fdc42503          	lw	a0,-36(s0)
  }
}
    55ac:	00153513          	seqz	a0,a0
    55b0:	70a2                	ld	ra,40(sp)
    55b2:	7402                	ld	s0,32(sp)
    55b4:	64e2                	ld	s1,24(sp)
    55b6:	6942                	ld	s2,16(sp)
    55b8:	6145                	addi	sp,sp,48
    55ba:	8082                	ret
    printf("runtest: fork error\n");
    55bc:	00003517          	auipc	a0,0x3
    55c0:	b5450513          	addi	a0,a0,-1196 # 8110 <malloc+0x20a2>
    55c4:	00001097          	auipc	ra,0x1
    55c8:	9ea080e7          	jalr	-1558(ra) # 5fae <printf>
    exit(1);
    55cc:	4505                	li	a0,1
    55ce:	00000097          	auipc	ra,0x0
    55d2:	64a080e7          	jalr	1610(ra) # 5c18 <exit>
    f(s);
    55d6:	854a                	mv	a0,s2
    55d8:	9482                	jalr	s1
    exit(0);
    55da:	4501                	li	a0,0
    55dc:	00000097          	auipc	ra,0x0
    55e0:	63c080e7          	jalr	1596(ra) # 5c18 <exit>
      printf("OK\n");
    55e4:	00003517          	auipc	a0,0x3
    55e8:	b4c50513          	addi	a0,a0,-1204 # 8130 <malloc+0x20c2>
    55ec:	00001097          	auipc	ra,0x1
    55f0:	9c2080e7          	jalr	-1598(ra) # 5fae <printf>
    55f4:	bf55                	j	55a8 <run+0x50>

00000000000055f6 <runtests>:

int
runtests(struct test *tests, char *justone) {
    55f6:	1101                	addi	sp,sp,-32
    55f8:	ec06                	sd	ra,24(sp)
    55fa:	e822                	sd	s0,16(sp)
    55fc:	e426                	sd	s1,8(sp)
    55fe:	e04a                	sd	s2,0(sp)
    5600:	1000                	addi	s0,sp,32
    5602:	84aa                	mv	s1,a0
    5604:	892e                	mv	s2,a1
  for (struct test *t = tests; t->s != 0; t++) {
    5606:	6508                	ld	a0,8(a0)
    5608:	ed09                	bnez	a0,5622 <runtests+0x2c>
        printf("SOME TESTS FAILED\n");
        return 1;
      }
    }
  }
  return 0;
    560a:	4501                	li	a0,0
    560c:	a82d                	j	5646 <runtests+0x50>
      if(!run(t->f, t->s)){
    560e:	648c                	ld	a1,8(s1)
    5610:	6088                	ld	a0,0(s1)
    5612:	00000097          	auipc	ra,0x0
    5616:	f46080e7          	jalr	-186(ra) # 5558 <run>
    561a:	cd09                	beqz	a0,5634 <runtests+0x3e>
  for (struct test *t = tests; t->s != 0; t++) {
    561c:	04c1                	addi	s1,s1,16
    561e:	6488                	ld	a0,8(s1)
    5620:	c11d                	beqz	a0,5646 <runtests+0x50>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    5622:	fe0906e3          	beqz	s2,560e <runtests+0x18>
    5626:	85ca                	mv	a1,s2
    5628:	00000097          	auipc	ra,0x0
    562c:	366080e7          	jalr	870(ra) # 598e <strcmp>
    5630:	f575                	bnez	a0,561c <runtests+0x26>
    5632:	bff1                	j	560e <runtests+0x18>
        printf("SOME TESTS FAILED\n");
    5634:	00003517          	auipc	a0,0x3
    5638:	b0450513          	addi	a0,a0,-1276 # 8138 <malloc+0x20ca>
    563c:	00001097          	auipc	ra,0x1
    5640:	972080e7          	jalr	-1678(ra) # 5fae <printf>
        return 1;
    5644:	4505                	li	a0,1
}
    5646:	60e2                	ld	ra,24(sp)
    5648:	6442                	ld	s0,16(sp)
    564a:	64a2                	ld	s1,8(sp)
    564c:	6902                	ld	s2,0(sp)
    564e:	6105                	addi	sp,sp,32
    5650:	8082                	ret

0000000000005652 <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    5652:	7139                	addi	sp,sp,-64
    5654:	fc06                	sd	ra,56(sp)
    5656:	f822                	sd	s0,48(sp)
    5658:	f426                	sd	s1,40(sp)
    565a:	f04a                	sd	s2,32(sp)
    565c:	ec4e                	sd	s3,24(sp)
    565e:	0080                	addi	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    5660:	fc840513          	addi	a0,s0,-56
    5664:	00000097          	auipc	ra,0x0
    5668:	5c4080e7          	jalr	1476(ra) # 5c28 <pipe>
    566c:	06054763          	bltz	a0,56da <countfree+0x88>
    printf("pipe() failed in countfree()\n");
    exit(1);
  }
  
  int pid = fork();
    5670:	00000097          	auipc	ra,0x0
    5674:	5a0080e7          	jalr	1440(ra) # 5c10 <fork>

  if(pid < 0){
    5678:	06054e63          	bltz	a0,56f4 <countfree+0xa2>
    printf("fork failed in countfree()\n");
    exit(1);
  }

  if(pid == 0){
    567c:	ed51                	bnez	a0,5718 <countfree+0xc6>
    close(fds[0]);
    567e:	fc842503          	lw	a0,-56(s0)
    5682:	00000097          	auipc	ra,0x0
    5686:	5be080e7          	jalr	1470(ra) # 5c40 <close>
    
    while(1){
      uint64 a = (uint64) sbrk(4096);
      if(a == 0xffffffffffffffff){
    568a:	597d                	li	s2,-1
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    568c:	4485                	li	s1,1

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    568e:	00001997          	auipc	s3,0x1
    5692:	b9a98993          	addi	s3,s3,-1126 # 6228 <malloc+0x1ba>
      uint64 a = (uint64) sbrk(4096);
    5696:	6505                	lui	a0,0x1
    5698:	00000097          	auipc	ra,0x0
    569c:	608080e7          	jalr	1544(ra) # 5ca0 <sbrk>
      if(a == 0xffffffffffffffff){
    56a0:	07250763          	beq	a0,s2,570e <countfree+0xbc>
      *(char *)(a + 4096 - 1) = 1;
    56a4:	6785                	lui	a5,0x1
    56a6:	97aa                	add	a5,a5,a0
    56a8:	fe978fa3          	sb	s1,-1(a5) # fff <linktest+0xf7>
      if(write(fds[1], "x", 1) != 1){
    56ac:	8626                	mv	a2,s1
    56ae:	85ce                	mv	a1,s3
    56b0:	fcc42503          	lw	a0,-52(s0)
    56b4:	00000097          	auipc	ra,0x0
    56b8:	584080e7          	jalr	1412(ra) # 5c38 <write>
    56bc:	fc950de3          	beq	a0,s1,5696 <countfree+0x44>
        printf("write() failed in countfree()\n");
    56c0:	00003517          	auipc	a0,0x3
    56c4:	ad050513          	addi	a0,a0,-1328 # 8190 <malloc+0x2122>
    56c8:	00001097          	auipc	ra,0x1
    56cc:	8e6080e7          	jalr	-1818(ra) # 5fae <printf>
        exit(1);
    56d0:	4505                	li	a0,1
    56d2:	00000097          	auipc	ra,0x0
    56d6:	546080e7          	jalr	1350(ra) # 5c18 <exit>
    printf("pipe() failed in countfree()\n");
    56da:	00003517          	auipc	a0,0x3
    56de:	a7650513          	addi	a0,a0,-1418 # 8150 <malloc+0x20e2>
    56e2:	00001097          	auipc	ra,0x1
    56e6:	8cc080e7          	jalr	-1844(ra) # 5fae <printf>
    exit(1);
    56ea:	4505                	li	a0,1
    56ec:	00000097          	auipc	ra,0x0
    56f0:	52c080e7          	jalr	1324(ra) # 5c18 <exit>
    printf("fork failed in countfree()\n");
    56f4:	00003517          	auipc	a0,0x3
    56f8:	a7c50513          	addi	a0,a0,-1412 # 8170 <malloc+0x2102>
    56fc:	00001097          	auipc	ra,0x1
    5700:	8b2080e7          	jalr	-1870(ra) # 5fae <printf>
    exit(1);
    5704:	4505                	li	a0,1
    5706:	00000097          	auipc	ra,0x0
    570a:	512080e7          	jalr	1298(ra) # 5c18 <exit>
      }
    }

    exit(0);
    570e:	4501                	li	a0,0
    5710:	00000097          	auipc	ra,0x0
    5714:	508080e7          	jalr	1288(ra) # 5c18 <exit>
  }

  close(fds[1]);
    5718:	fcc42503          	lw	a0,-52(s0)
    571c:	00000097          	auipc	ra,0x0
    5720:	524080e7          	jalr	1316(ra) # 5c40 <close>

  int n = 0;
    5724:	4481                	li	s1,0
    5726:	a839                	j	5744 <countfree+0xf2>
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    if(cc < 0){
      printf("read() failed in countfree()\n");
    5728:	00003517          	auipc	a0,0x3
    572c:	a8850513          	addi	a0,a0,-1400 # 81b0 <malloc+0x2142>
    5730:	00001097          	auipc	ra,0x1
    5734:	87e080e7          	jalr	-1922(ra) # 5fae <printf>
      exit(1);
    5738:	4505                	li	a0,1
    573a:	00000097          	auipc	ra,0x0
    573e:	4de080e7          	jalr	1246(ra) # 5c18 <exit>
    }
    if(cc == 0)
      break;
    n += 1;
    5742:	2485                	addiw	s1,s1,1
    int cc = read(fds[0], &c, 1);
    5744:	4605                	li	a2,1
    5746:	fc740593          	addi	a1,s0,-57
    574a:	fc842503          	lw	a0,-56(s0)
    574e:	00000097          	auipc	ra,0x0
    5752:	4e2080e7          	jalr	1250(ra) # 5c30 <read>
    if(cc < 0){
    5756:	fc0549e3          	bltz	a0,5728 <countfree+0xd6>
    if(cc == 0)
    575a:	f565                	bnez	a0,5742 <countfree+0xf0>
  }

  close(fds[0]);
    575c:	fc842503          	lw	a0,-56(s0)
    5760:	00000097          	auipc	ra,0x0
    5764:	4e0080e7          	jalr	1248(ra) # 5c40 <close>
  wait((int*)0);
    5768:	4501                	li	a0,0
    576a:	00000097          	auipc	ra,0x0
    576e:	4b6080e7          	jalr	1206(ra) # 5c20 <wait>
  
  return n;
}
    5772:	8526                	mv	a0,s1
    5774:	70e2                	ld	ra,56(sp)
    5776:	7442                	ld	s0,48(sp)
    5778:	74a2                	ld	s1,40(sp)
    577a:	7902                	ld	s2,32(sp)
    577c:	69e2                	ld	s3,24(sp)
    577e:	6121                	addi	sp,sp,64
    5780:	8082                	ret

0000000000005782 <drivetests>:

int
drivetests(int quick, int continuous, char *justone) {
    5782:	711d                	addi	sp,sp,-96
    5784:	ec86                	sd	ra,88(sp)
    5786:	e8a2                	sd	s0,80(sp)
    5788:	e4a6                	sd	s1,72(sp)
    578a:	e0ca                	sd	s2,64(sp)
    578c:	fc4e                	sd	s3,56(sp)
    578e:	f852                	sd	s4,48(sp)
    5790:	f456                	sd	s5,40(sp)
    5792:	f05a                	sd	s6,32(sp)
    5794:	ec5e                	sd	s7,24(sp)
    5796:	e862                	sd	s8,16(sp)
    5798:	e466                	sd	s9,8(sp)
    579a:	e06a                	sd	s10,0(sp)
    579c:	1080                	addi	s0,sp,96
    579e:	8baa                	mv	s7,a0
    57a0:	89ae                	mv	s3,a1
    57a2:	84b2                	mv	s1,a2
  do {
    printf("usertests starting\n");
    57a4:	00003b17          	auipc	s6,0x3
    57a8:	a2cb0b13          	addi	s6,s6,-1492 # 81d0 <malloc+0x2162>
    int free0 = countfree();
    int free1 = 0;
    if (runtests(quicktests, justone)) {
    57ac:	00004a97          	auipc	s5,0x4
    57b0:	864a8a93          	addi	s5,s5,-1948 # 9010 <quicktests>
      if(continuous != 2) {
    57b4:	4a09                	li	s4,2
          return 1;
        }
      }
    }
    if((free1 = countfree()) < free0) {
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    57b6:	00003c97          	auipc	s9,0x3
    57ba:	a52c8c93          	addi	s9,s9,-1454 # 8208 <malloc+0x219a>
      if (runtests(slowtests, justone)) {
    57be:	00004c17          	auipc	s8,0x4
    57c2:	c22c0c13          	addi	s8,s8,-990 # 93e0 <slowtests>
        printf("usertests slow tests starting\n");
    57c6:	00003d17          	auipc	s10,0x3
    57ca:	a22d0d13          	addi	s10,s10,-1502 # 81e8 <malloc+0x217a>
    57ce:	a839                	j	57ec <drivetests+0x6a>
    57d0:	856a                	mv	a0,s10
    57d2:	00000097          	auipc	ra,0x0
    57d6:	7dc080e7          	jalr	2012(ra) # 5fae <printf>
    57da:	a83d                	j	5818 <drivetests+0x96>
    if((free1 = countfree()) < free0) {
    57dc:	00000097          	auipc	ra,0x0
    57e0:	e76080e7          	jalr	-394(ra) # 5652 <countfree>
    57e4:	07254163          	blt	a0,s2,5846 <drivetests+0xc4>
      if(continuous != 2) {
        return 1;
      }
    }
  } while(continuous);
    57e8:	06098a63          	beqz	s3,585c <drivetests+0xda>
    printf("usertests starting\n");
    57ec:	855a                	mv	a0,s6
    57ee:	00000097          	auipc	ra,0x0
    57f2:	7c0080e7          	jalr	1984(ra) # 5fae <printf>
    int free0 = countfree();
    57f6:	00000097          	auipc	ra,0x0
    57fa:	e5c080e7          	jalr	-420(ra) # 5652 <countfree>
    57fe:	892a                	mv	s2,a0
    if (runtests(quicktests, justone)) {
    5800:	85a6                	mv	a1,s1
    5802:	8556                	mv	a0,s5
    5804:	00000097          	auipc	ra,0x0
    5808:	df2080e7          	jalr	-526(ra) # 55f6 <runtests>
    580c:	c119                	beqz	a0,5812 <drivetests+0x90>
      if(continuous != 2) {
    580e:	07499663          	bne	s3,s4,587a <drivetests+0xf8>
    if(!quick) {
    5812:	fc0b95e3          	bnez	s7,57dc <drivetests+0x5a>
      if (justone == 0)
    5816:	dccd                	beqz	s1,57d0 <drivetests+0x4e>
      if (runtests(slowtests, justone)) {
    5818:	85a6                	mv	a1,s1
    581a:	8562                	mv	a0,s8
    581c:	00000097          	auipc	ra,0x0
    5820:	dda080e7          	jalr	-550(ra) # 55f6 <runtests>
    5824:	dd45                	beqz	a0,57dc <drivetests+0x5a>
        if(continuous != 2) {
    5826:	05499c63          	bne	s3,s4,587e <drivetests+0xfc>
    if((free1 = countfree()) < free0) {
    582a:	00000097          	auipc	ra,0x0
    582e:	e28080e7          	jalr	-472(ra) # 5652 <countfree>
    5832:	fb255be3          	bge	a0,s2,57e8 <drivetests+0x66>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    5836:	864a                	mv	a2,s2
    5838:	85aa                	mv	a1,a0
    583a:	8566                	mv	a0,s9
    583c:	00000097          	auipc	ra,0x0
    5840:	772080e7          	jalr	1906(ra) # 5fae <printf>
      if(continuous != 2) {
    5844:	b765                	j	57ec <drivetests+0x6a>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    5846:	864a                	mv	a2,s2
    5848:	85aa                	mv	a1,a0
    584a:	8566                	mv	a0,s9
    584c:	00000097          	auipc	ra,0x0
    5850:	762080e7          	jalr	1890(ra) # 5fae <printf>
      if(continuous != 2) {
    5854:	f9498ce3          	beq	s3,s4,57ec <drivetests+0x6a>
        return 1;
    5858:	4505                	li	a0,1
    585a:	a011                	j	585e <drivetests+0xdc>
  return 0;
    585c:	854e                	mv	a0,s3
}
    585e:	60e6                	ld	ra,88(sp)
    5860:	6446                	ld	s0,80(sp)
    5862:	64a6                	ld	s1,72(sp)
    5864:	6906                	ld	s2,64(sp)
    5866:	79e2                	ld	s3,56(sp)
    5868:	7a42                	ld	s4,48(sp)
    586a:	7aa2                	ld	s5,40(sp)
    586c:	7b02                	ld	s6,32(sp)
    586e:	6be2                	ld	s7,24(sp)
    5870:	6c42                	ld	s8,16(sp)
    5872:	6ca2                	ld	s9,8(sp)
    5874:	6d02                	ld	s10,0(sp)
    5876:	6125                	addi	sp,sp,96
    5878:	8082                	ret
        return 1;
    587a:	4505                	li	a0,1
    587c:	b7cd                	j	585e <drivetests+0xdc>
          return 1;
    587e:	4505                	li	a0,1
    5880:	bff9                	j	585e <drivetests+0xdc>

0000000000005882 <main>:

int
main(int argc, char *argv[])
{
    5882:	1101                	addi	sp,sp,-32
    5884:	ec06                	sd	ra,24(sp)
    5886:	e822                	sd	s0,16(sp)
    5888:	e426                	sd	s1,8(sp)
    588a:	e04a                	sd	s2,0(sp)
    588c:	1000                	addi	s0,sp,32
    588e:	84aa                	mv	s1,a0
  int continuous = 0;
  int quick = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    5890:	4789                	li	a5,2
    5892:	02f50263          	beq	a0,a5,58b6 <main+0x34>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    5896:	4785                	li	a5,1
    5898:	06a7cd63          	blt	a5,a0,5912 <main+0x90>
  char *justone = 0;
    589c:	4601                	li	a2,0
  int quick = 0;
    589e:	4501                	li	a0,0
  int continuous = 0;
    58a0:	4581                	li	a1,0
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    exit(1);
  }
  if (drivetests(quick, continuous, justone)) {
    58a2:	00000097          	auipc	ra,0x0
    58a6:	ee0080e7          	jalr	-288(ra) # 5782 <drivetests>
    58aa:	c951                	beqz	a0,593e <main+0xbc>
    exit(1);
    58ac:	4505                	li	a0,1
    58ae:	00000097          	auipc	ra,0x0
    58b2:	36a080e7          	jalr	874(ra) # 5c18 <exit>
    58b6:	892e                	mv	s2,a1
  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    58b8:	00003597          	auipc	a1,0x3
    58bc:	98058593          	addi	a1,a1,-1664 # 8238 <malloc+0x21ca>
    58c0:	00893503          	ld	a0,8(s2)
    58c4:	00000097          	auipc	ra,0x0
    58c8:	0ca080e7          	jalr	202(ra) # 598e <strcmp>
    58cc:	85aa                	mv	a1,a0
    58ce:	cd39                	beqz	a0,592c <main+0xaa>
  } else if(argc == 2 && strcmp(argv[1], "-c") == 0){
    58d0:	00003597          	auipc	a1,0x3
    58d4:	9c058593          	addi	a1,a1,-1600 # 8290 <malloc+0x2222>
    58d8:	00893503          	ld	a0,8(s2)
    58dc:	00000097          	auipc	ra,0x0
    58e0:	0b2080e7          	jalr	178(ra) # 598e <strcmp>
    58e4:	c931                	beqz	a0,5938 <main+0xb6>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    58e6:	00003597          	auipc	a1,0x3
    58ea:	9a258593          	addi	a1,a1,-1630 # 8288 <malloc+0x221a>
    58ee:	00893503          	ld	a0,8(s2)
    58f2:	00000097          	auipc	ra,0x0
    58f6:	09c080e7          	jalr	156(ra) # 598e <strcmp>
    58fa:	cd05                	beqz	a0,5932 <main+0xb0>
  } else if(argc == 2 && argv[1][0] != '-'){
    58fc:	00893603          	ld	a2,8(s2)
    5900:	00064703          	lbu	a4,0(a2) # 3000 <execout+0x80>
    5904:	02d00793          	li	a5,45
    5908:	00f70563          	beq	a4,a5,5912 <main+0x90>
  int quick = 0;
    590c:	4501                	li	a0,0
  int continuous = 0;
    590e:	4581                	li	a1,0
    5910:	bf49                	j	58a2 <main+0x20>
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    5912:	00003517          	auipc	a0,0x3
    5916:	92e50513          	addi	a0,a0,-1746 # 8240 <malloc+0x21d2>
    591a:	00000097          	auipc	ra,0x0
    591e:	694080e7          	jalr	1684(ra) # 5fae <printf>
    exit(1);
    5922:	4505                	li	a0,1
    5924:	00000097          	auipc	ra,0x0
    5928:	2f4080e7          	jalr	756(ra) # 5c18 <exit>
  char *justone = 0;
    592c:	4601                	li	a2,0
    quick = 1;
    592e:	4505                	li	a0,1
    5930:	bf8d                	j	58a2 <main+0x20>
    continuous = 2;
    5932:	85a6                	mv	a1,s1
  char *justone = 0;
    5934:	4601                	li	a2,0
    5936:	b7b5                	j	58a2 <main+0x20>
    5938:	4601                	li	a2,0
    continuous = 1;
    593a:	4585                	li	a1,1
    593c:	b79d                	j	58a2 <main+0x20>
  }
  printf("ALL TESTS PASSED\n");
    593e:	00003517          	auipc	a0,0x3
    5942:	93250513          	addi	a0,a0,-1742 # 8270 <malloc+0x2202>
    5946:	00000097          	auipc	ra,0x0
    594a:	668080e7          	jalr	1640(ra) # 5fae <printf>
  exit(0);
    594e:	4501                	li	a0,0
    5950:	00000097          	auipc	ra,0x0
    5954:	2c8080e7          	jalr	712(ra) # 5c18 <exit>

0000000000005958 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    5958:	1141                	addi	sp,sp,-16
    595a:	e406                	sd	ra,8(sp)
    595c:	e022                	sd	s0,0(sp)
    595e:	0800                	addi	s0,sp,16
  extern int main();
  main();
    5960:	00000097          	auipc	ra,0x0
    5964:	f22080e7          	jalr	-222(ra) # 5882 <main>
  exit(0);
    5968:	4501                	li	a0,0
    596a:	00000097          	auipc	ra,0x0
    596e:	2ae080e7          	jalr	686(ra) # 5c18 <exit>

0000000000005972 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    5972:	1141                	addi	sp,sp,-16
    5974:	e422                	sd	s0,8(sp)
    5976:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    5978:	87aa                	mv	a5,a0
    597a:	0585                	addi	a1,a1,1
    597c:	0785                	addi	a5,a5,1
    597e:	fff5c703          	lbu	a4,-1(a1)
    5982:	fee78fa3          	sb	a4,-1(a5)
    5986:	fb75                	bnez	a4,597a <strcpy+0x8>
    ;
  return os;
}
    5988:	6422                	ld	s0,8(sp)
    598a:	0141                	addi	sp,sp,16
    598c:	8082                	ret

000000000000598e <strcmp>:

int
strcmp(const char *p, const char *q)
{
    598e:	1141                	addi	sp,sp,-16
    5990:	e422                	sd	s0,8(sp)
    5992:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    5994:	00054783          	lbu	a5,0(a0)
    5998:	cf91                	beqz	a5,59b4 <strcmp+0x26>
    599a:	0005c703          	lbu	a4,0(a1)
    599e:	00f71b63          	bne	a4,a5,59b4 <strcmp+0x26>
    p++, q++;
    59a2:	0505                	addi	a0,a0,1
    59a4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    59a6:	00054783          	lbu	a5,0(a0)
    59aa:	c789                	beqz	a5,59b4 <strcmp+0x26>
    59ac:	0005c703          	lbu	a4,0(a1)
    59b0:	fef709e3          	beq	a4,a5,59a2 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
    59b4:	0005c503          	lbu	a0,0(a1)
}
    59b8:	40a7853b          	subw	a0,a5,a0
    59bc:	6422                	ld	s0,8(sp)
    59be:	0141                	addi	sp,sp,16
    59c0:	8082                	ret

00000000000059c2 <strlen>:

uint
strlen(const char *s)
{
    59c2:	1141                	addi	sp,sp,-16
    59c4:	e422                	sd	s0,8(sp)
    59c6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    59c8:	00054783          	lbu	a5,0(a0)
    59cc:	cf91                	beqz	a5,59e8 <strlen+0x26>
    59ce:	0505                	addi	a0,a0,1
    59d0:	87aa                	mv	a5,a0
    59d2:	4685                	li	a3,1
    59d4:	9e89                	subw	a3,a3,a0
    ;
    59d6:	00f6853b          	addw	a0,a3,a5
    59da:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
    59dc:	fff7c703          	lbu	a4,-1(a5)
    59e0:	fb7d                	bnez	a4,59d6 <strlen+0x14>
  return n;
}
    59e2:	6422                	ld	s0,8(sp)
    59e4:	0141                	addi	sp,sp,16
    59e6:	8082                	ret
  for(n = 0; s[n]; n++)
    59e8:	4501                	li	a0,0
    59ea:	bfe5                	j	59e2 <strlen+0x20>

00000000000059ec <memset>:

void*
memset(void *dst, int c, uint n)
{
    59ec:	1141                	addi	sp,sp,-16
    59ee:	e422                	sd	s0,8(sp)
    59f0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    59f2:	ce09                	beqz	a2,5a0c <memset+0x20>
    59f4:	87aa                	mv	a5,a0
    59f6:	fff6071b          	addiw	a4,a2,-1
    59fa:	1702                	slli	a4,a4,0x20
    59fc:	9301                	srli	a4,a4,0x20
    59fe:	0705                	addi	a4,a4,1
    5a00:	972a                	add	a4,a4,a0
    cdst[i] = c;
    5a02:	00b78023          	sb	a1,0(a5)
    5a06:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
    5a08:	fee79de3          	bne	a5,a4,5a02 <memset+0x16>
  }
  return dst;
}
    5a0c:	6422                	ld	s0,8(sp)
    5a0e:	0141                	addi	sp,sp,16
    5a10:	8082                	ret

0000000000005a12 <strchr>:

char*
strchr(const char *s, char c)
{
    5a12:	1141                	addi	sp,sp,-16
    5a14:	e422                	sd	s0,8(sp)
    5a16:	0800                	addi	s0,sp,16
  for(; *s; s++)
    5a18:	00054783          	lbu	a5,0(a0)
    5a1c:	cf91                	beqz	a5,5a38 <strchr+0x26>
    if(*s == c)
    5a1e:	00f58a63          	beq	a1,a5,5a32 <strchr+0x20>
  for(; *s; s++)
    5a22:	0505                	addi	a0,a0,1
    5a24:	00054783          	lbu	a5,0(a0)
    5a28:	c781                	beqz	a5,5a30 <strchr+0x1e>
    if(*s == c)
    5a2a:	feb79ce3          	bne	a5,a1,5a22 <strchr+0x10>
    5a2e:	a011                	j	5a32 <strchr+0x20>
      return (char*)s;
  return 0;
    5a30:	4501                	li	a0,0
}
    5a32:	6422                	ld	s0,8(sp)
    5a34:	0141                	addi	sp,sp,16
    5a36:	8082                	ret
  return 0;
    5a38:	4501                	li	a0,0
    5a3a:	bfe5                	j	5a32 <strchr+0x20>

0000000000005a3c <gets>:

char*
gets(char *buf, int max)
{
    5a3c:	711d                	addi	sp,sp,-96
    5a3e:	ec86                	sd	ra,88(sp)
    5a40:	e8a2                	sd	s0,80(sp)
    5a42:	e4a6                	sd	s1,72(sp)
    5a44:	e0ca                	sd	s2,64(sp)
    5a46:	fc4e                	sd	s3,56(sp)
    5a48:	f852                	sd	s4,48(sp)
    5a4a:	f456                	sd	s5,40(sp)
    5a4c:	f05a                	sd	s6,32(sp)
    5a4e:	ec5e                	sd	s7,24(sp)
    5a50:	1080                	addi	s0,sp,96
    5a52:	8baa                	mv	s7,a0
    5a54:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    5a56:	892a                	mv	s2,a0
    5a58:	4981                	li	s3,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    5a5a:	4aa9                	li	s5,10
    5a5c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    5a5e:	0019849b          	addiw	s1,s3,1
    5a62:	0344d863          	bge	s1,s4,5a92 <gets+0x56>
    cc = read(0, &c, 1);
    5a66:	4605                	li	a2,1
    5a68:	faf40593          	addi	a1,s0,-81
    5a6c:	4501                	li	a0,0
    5a6e:	00000097          	auipc	ra,0x0
    5a72:	1c2080e7          	jalr	450(ra) # 5c30 <read>
    if(cc < 1)
    5a76:	00a05e63          	blez	a0,5a92 <gets+0x56>
    buf[i++] = c;
    5a7a:	faf44783          	lbu	a5,-81(s0)
    5a7e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    5a82:	01578763          	beq	a5,s5,5a90 <gets+0x54>
    5a86:	0905                	addi	s2,s2,1
  for(i=0; i+1 < max; ){
    5a88:	89a6                	mv	s3,s1
    if(c == '\n' || c == '\r')
    5a8a:	fd679ae3          	bne	a5,s6,5a5e <gets+0x22>
    5a8e:	a011                	j	5a92 <gets+0x56>
  for(i=0; i+1 < max; ){
    5a90:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    5a92:	99de                	add	s3,s3,s7
    5a94:	00098023          	sb	zero,0(s3)
  return buf;
}
    5a98:	855e                	mv	a0,s7
    5a9a:	60e6                	ld	ra,88(sp)
    5a9c:	6446                	ld	s0,80(sp)
    5a9e:	64a6                	ld	s1,72(sp)
    5aa0:	6906                	ld	s2,64(sp)
    5aa2:	79e2                	ld	s3,56(sp)
    5aa4:	7a42                	ld	s4,48(sp)
    5aa6:	7aa2                	ld	s5,40(sp)
    5aa8:	7b02                	ld	s6,32(sp)
    5aaa:	6be2                	ld	s7,24(sp)
    5aac:	6125                	addi	sp,sp,96
    5aae:	8082                	ret

0000000000005ab0 <stat>:

int
stat(const char *n, struct stat *st)
{
    5ab0:	1101                	addi	sp,sp,-32
    5ab2:	ec06                	sd	ra,24(sp)
    5ab4:	e822                	sd	s0,16(sp)
    5ab6:	e426                	sd	s1,8(sp)
    5ab8:	e04a                	sd	s2,0(sp)
    5aba:	1000                	addi	s0,sp,32
    5abc:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    5abe:	4581                	li	a1,0
    5ac0:	00000097          	auipc	ra,0x0
    5ac4:	198080e7          	jalr	408(ra) # 5c58 <open>
  if(fd < 0)
    5ac8:	02054563          	bltz	a0,5af2 <stat+0x42>
    5acc:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    5ace:	85ca                	mv	a1,s2
    5ad0:	00000097          	auipc	ra,0x0
    5ad4:	1a0080e7          	jalr	416(ra) # 5c70 <fstat>
    5ad8:	892a                	mv	s2,a0
  close(fd);
    5ada:	8526                	mv	a0,s1
    5adc:	00000097          	auipc	ra,0x0
    5ae0:	164080e7          	jalr	356(ra) # 5c40 <close>
  return r;
}
    5ae4:	854a                	mv	a0,s2
    5ae6:	60e2                	ld	ra,24(sp)
    5ae8:	6442                	ld	s0,16(sp)
    5aea:	64a2                	ld	s1,8(sp)
    5aec:	6902                	ld	s2,0(sp)
    5aee:	6105                	addi	sp,sp,32
    5af0:	8082                	ret
    return -1;
    5af2:	597d                	li	s2,-1
    5af4:	bfc5                	j	5ae4 <stat+0x34>

0000000000005af6 <atoi>:

int
atoi(const char *s)
{
    5af6:	1141                	addi	sp,sp,-16
    5af8:	e422                	sd	s0,8(sp)
    5afa:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    5afc:	00054683          	lbu	a3,0(a0)
    5b00:	fd06879b          	addiw	a5,a3,-48
    5b04:	0ff7f793          	andi	a5,a5,255
    5b08:	4725                	li	a4,9
    5b0a:	02f76963          	bltu	a4,a5,5b3c <atoi+0x46>
    5b0e:	862a                	mv	a2,a0
  n = 0;
    5b10:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    5b12:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    5b14:	0605                	addi	a2,a2,1
    5b16:	0025179b          	slliw	a5,a0,0x2
    5b1a:	9fa9                	addw	a5,a5,a0
    5b1c:	0017979b          	slliw	a5,a5,0x1
    5b20:	9fb5                	addw	a5,a5,a3
    5b22:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    5b26:	00064683          	lbu	a3,0(a2)
    5b2a:	fd06871b          	addiw	a4,a3,-48
    5b2e:	0ff77713          	andi	a4,a4,255
    5b32:	fee5f1e3          	bgeu	a1,a4,5b14 <atoi+0x1e>
  return n;
}
    5b36:	6422                	ld	s0,8(sp)
    5b38:	0141                	addi	sp,sp,16
    5b3a:	8082                	ret
  n = 0;
    5b3c:	4501                	li	a0,0
    5b3e:	bfe5                	j	5b36 <atoi+0x40>

0000000000005b40 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    5b40:	1141                	addi	sp,sp,-16
    5b42:	e422                	sd	s0,8(sp)
    5b44:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    5b46:	02b57663          	bgeu	a0,a1,5b72 <memmove+0x32>
    while(n-- > 0)
    5b4a:	02c05163          	blez	a2,5b6c <memmove+0x2c>
    5b4e:	fff6079b          	addiw	a5,a2,-1
    5b52:	1782                	slli	a5,a5,0x20
    5b54:	9381                	srli	a5,a5,0x20
    5b56:	0785                	addi	a5,a5,1
    5b58:	97aa                	add	a5,a5,a0
  dst = vdst;
    5b5a:	872a                	mv	a4,a0
      *dst++ = *src++;
    5b5c:	0585                	addi	a1,a1,1
    5b5e:	0705                	addi	a4,a4,1
    5b60:	fff5c683          	lbu	a3,-1(a1)
    5b64:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    5b68:	fee79ae3          	bne	a5,a4,5b5c <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    5b6c:	6422                	ld	s0,8(sp)
    5b6e:	0141                	addi	sp,sp,16
    5b70:	8082                	ret
    dst += n;
    5b72:	00c50733          	add	a4,a0,a2
    src += n;
    5b76:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    5b78:	fec05ae3          	blez	a2,5b6c <memmove+0x2c>
    5b7c:	fff6079b          	addiw	a5,a2,-1
    5b80:	1782                	slli	a5,a5,0x20
    5b82:	9381                	srli	a5,a5,0x20
    5b84:	fff7c793          	not	a5,a5
    5b88:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    5b8a:	15fd                	addi	a1,a1,-1
    5b8c:	177d                	addi	a4,a4,-1
    5b8e:	0005c683          	lbu	a3,0(a1)
    5b92:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    5b96:	fef71ae3          	bne	a4,a5,5b8a <memmove+0x4a>
    5b9a:	bfc9                	j	5b6c <memmove+0x2c>

0000000000005b9c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    5b9c:	1141                	addi	sp,sp,-16
    5b9e:	e422                	sd	s0,8(sp)
    5ba0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    5ba2:	ce15                	beqz	a2,5bde <memcmp+0x42>
    5ba4:	fff6069b          	addiw	a3,a2,-1
    if (*p1 != *p2) {
    5ba8:	00054783          	lbu	a5,0(a0)
    5bac:	0005c703          	lbu	a4,0(a1)
    5bb0:	02e79063          	bne	a5,a4,5bd0 <memcmp+0x34>
    5bb4:	1682                	slli	a3,a3,0x20
    5bb6:	9281                	srli	a3,a3,0x20
    5bb8:	0685                	addi	a3,a3,1
    5bba:	96aa                	add	a3,a3,a0
      return *p1 - *p2;
    }
    p1++;
    5bbc:	0505                	addi	a0,a0,1
    p2++;
    5bbe:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    5bc0:	00d50d63          	beq	a0,a3,5bda <memcmp+0x3e>
    if (*p1 != *p2) {
    5bc4:	00054783          	lbu	a5,0(a0)
    5bc8:	0005c703          	lbu	a4,0(a1)
    5bcc:	fee788e3          	beq	a5,a4,5bbc <memcmp+0x20>
      return *p1 - *p2;
    5bd0:	40e7853b          	subw	a0,a5,a4
  }
  return 0;
}
    5bd4:	6422                	ld	s0,8(sp)
    5bd6:	0141                	addi	sp,sp,16
    5bd8:	8082                	ret
  return 0;
    5bda:	4501                	li	a0,0
    5bdc:	bfe5                	j	5bd4 <memcmp+0x38>
    5bde:	4501                	li	a0,0
    5be0:	bfd5                	j	5bd4 <memcmp+0x38>

0000000000005be2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    5be2:	1141                	addi	sp,sp,-16
    5be4:	e406                	sd	ra,8(sp)
    5be6:	e022                	sd	s0,0(sp)
    5be8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    5bea:	00000097          	auipc	ra,0x0
    5bee:	f56080e7          	jalr	-170(ra) # 5b40 <memmove>
}
    5bf2:	60a2                	ld	ra,8(sp)
    5bf4:	6402                	ld	s0,0(sp)
    5bf6:	0141                	addi	sp,sp,16
    5bf8:	8082                	ret

0000000000005bfa <ugetpid>:

#ifdef LAB_PGTBL
int
ugetpid(void)
{
    5bfa:	1141                	addi	sp,sp,-16
    5bfc:	e422                	sd	s0,8(sp)
    5bfe:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
    5c00:	040007b7          	lui	a5,0x4000
}
    5c04:	17f5                	addi	a5,a5,-3
    5c06:	07b2                	slli	a5,a5,0xc
    5c08:	4388                	lw	a0,0(a5)
    5c0a:	6422                	ld	s0,8(sp)
    5c0c:	0141                	addi	sp,sp,16
    5c0e:	8082                	ret

0000000000005c10 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    5c10:	4885                	li	a7,1
 ecall
    5c12:	00000073          	ecall
 ret
    5c16:	8082                	ret

0000000000005c18 <exit>:
.global exit
exit:
 li a7, SYS_exit
    5c18:	4889                	li	a7,2
 ecall
    5c1a:	00000073          	ecall
 ret
    5c1e:	8082                	ret

0000000000005c20 <wait>:
.global wait
wait:
 li a7, SYS_wait
    5c20:	488d                	li	a7,3
 ecall
    5c22:	00000073          	ecall
 ret
    5c26:	8082                	ret

0000000000005c28 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    5c28:	4891                	li	a7,4
 ecall
    5c2a:	00000073          	ecall
 ret
    5c2e:	8082                	ret

0000000000005c30 <read>:
.global read
read:
 li a7, SYS_read
    5c30:	4895                	li	a7,5
 ecall
    5c32:	00000073          	ecall
 ret
    5c36:	8082                	ret

0000000000005c38 <write>:
.global write
write:
 li a7, SYS_write
    5c38:	48c1                	li	a7,16
 ecall
    5c3a:	00000073          	ecall
 ret
    5c3e:	8082                	ret

0000000000005c40 <close>:
.global close
close:
 li a7, SYS_close
    5c40:	48d5                	li	a7,21
 ecall
    5c42:	00000073          	ecall
 ret
    5c46:	8082                	ret

0000000000005c48 <kill>:
.global kill
kill:
 li a7, SYS_kill
    5c48:	4899                	li	a7,6
 ecall
    5c4a:	00000073          	ecall
 ret
    5c4e:	8082                	ret

0000000000005c50 <exec>:
.global exec
exec:
 li a7, SYS_exec
    5c50:	489d                	li	a7,7
 ecall
    5c52:	00000073          	ecall
 ret
    5c56:	8082                	ret

0000000000005c58 <open>:
.global open
open:
 li a7, SYS_open
    5c58:	48bd                	li	a7,15
 ecall
    5c5a:	00000073          	ecall
 ret
    5c5e:	8082                	ret

0000000000005c60 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    5c60:	48c5                	li	a7,17
 ecall
    5c62:	00000073          	ecall
 ret
    5c66:	8082                	ret

0000000000005c68 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    5c68:	48c9                	li	a7,18
 ecall
    5c6a:	00000073          	ecall
 ret
    5c6e:	8082                	ret

0000000000005c70 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    5c70:	48a1                	li	a7,8
 ecall
    5c72:	00000073          	ecall
 ret
    5c76:	8082                	ret

0000000000005c78 <link>:
.global link
link:
 li a7, SYS_link
    5c78:	48cd                	li	a7,19
 ecall
    5c7a:	00000073          	ecall
 ret
    5c7e:	8082                	ret

0000000000005c80 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    5c80:	48d1                	li	a7,20
 ecall
    5c82:	00000073          	ecall
 ret
    5c86:	8082                	ret

0000000000005c88 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    5c88:	48a5                	li	a7,9
 ecall
    5c8a:	00000073          	ecall
 ret
    5c8e:	8082                	ret

0000000000005c90 <dup>:
.global dup
dup:
 li a7, SYS_dup
    5c90:	48a9                	li	a7,10
 ecall
    5c92:	00000073          	ecall
 ret
    5c96:	8082                	ret

0000000000005c98 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    5c98:	48ad                	li	a7,11
 ecall
    5c9a:	00000073          	ecall
 ret
    5c9e:	8082                	ret

0000000000005ca0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    5ca0:	48b1                	li	a7,12
 ecall
    5ca2:	00000073          	ecall
 ret
    5ca6:	8082                	ret

0000000000005ca8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    5ca8:	48b5                	li	a7,13
 ecall
    5caa:	00000073          	ecall
 ret
    5cae:	8082                	ret

0000000000005cb0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    5cb0:	48b9                	li	a7,14
 ecall
    5cb2:	00000073          	ecall
 ret
    5cb6:	8082                	ret

0000000000005cb8 <trace>:
.global trace
trace:
 li a7, SYS_trace
    5cb8:	48d9                	li	a7,22
 ecall
    5cba:	00000073          	ecall
 ret
    5cbe:	8082                	ret

0000000000005cc0 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
    5cc0:	48dd                	li	a7,23
 ecall
    5cc2:	00000073          	ecall
 ret
    5cc6:	8082                	ret

0000000000005cc8 <connect>:
.global connect
connect:
 li a7, SYS_connect
    5cc8:	48f5                	li	a7,29
 ecall
    5cca:	00000073          	ecall
 ret
    5cce:	8082                	ret

0000000000005cd0 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
    5cd0:	48f9                	li	a7,30
 ecall
    5cd2:	00000073          	ecall
 ret
    5cd6:	8082                	ret

0000000000005cd8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    5cd8:	1101                	addi	sp,sp,-32
    5cda:	ec06                	sd	ra,24(sp)
    5cdc:	e822                	sd	s0,16(sp)
    5cde:	1000                	addi	s0,sp,32
    5ce0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    5ce4:	4605                	li	a2,1
    5ce6:	fef40593          	addi	a1,s0,-17
    5cea:	00000097          	auipc	ra,0x0
    5cee:	f4e080e7          	jalr	-178(ra) # 5c38 <write>
}
    5cf2:	60e2                	ld	ra,24(sp)
    5cf4:	6442                	ld	s0,16(sp)
    5cf6:	6105                	addi	sp,sp,32
    5cf8:	8082                	ret

0000000000005cfa <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    5cfa:	7139                	addi	sp,sp,-64
    5cfc:	fc06                	sd	ra,56(sp)
    5cfe:	f822                	sd	s0,48(sp)
    5d00:	f426                	sd	s1,40(sp)
    5d02:	f04a                	sd	s2,32(sp)
    5d04:	ec4e                	sd	s3,24(sp)
    5d06:	0080                	addi	s0,sp,64
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    5d08:	c299                	beqz	a3,5d0e <printint+0x14>
    5d0a:	0005cd63          	bltz	a1,5d24 <printint+0x2a>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    5d0e:	2581                	sext.w	a1,a1
  neg = 0;
    5d10:	4301                	li	t1,0
    5d12:	fc040713          	addi	a4,s0,-64
  }

  i = 0;
    5d16:	4801                	li	a6,0
  do{
    buf[i++] = digits[x % base];
    5d18:	2601                	sext.w	a2,a2
    5d1a:	00003897          	auipc	a7,0x3
    5d1e:	8be88893          	addi	a7,a7,-1858 # 85d8 <digits>
    5d22:	a039                	j	5d30 <printint+0x36>
    x = -xx;
    5d24:	40b005bb          	negw	a1,a1
    neg = 1;
    5d28:	4305                	li	t1,1
    x = -xx;
    5d2a:	b7e5                	j	5d12 <printint+0x18>
  }while((x /= base) != 0);
    5d2c:	85be                	mv	a1,a5
    buf[i++] = digits[x % base];
    5d2e:	8836                	mv	a6,a3
    5d30:	0018069b          	addiw	a3,a6,1
    5d34:	02c5f7bb          	remuw	a5,a1,a2
    5d38:	1782                	slli	a5,a5,0x20
    5d3a:	9381                	srli	a5,a5,0x20
    5d3c:	97c6                	add	a5,a5,a7
    5d3e:	0007c783          	lbu	a5,0(a5) # 4000000 <base+0x3ff0388>
    5d42:	00f70023          	sb	a5,0(a4)
    5d46:	0705                	addi	a4,a4,1
  }while((x /= base) != 0);
    5d48:	02c5d7bb          	divuw	a5,a1,a2
    5d4c:	fec5f0e3          	bgeu	a1,a2,5d2c <printint+0x32>
  if(neg)
    5d50:	00030b63          	beqz	t1,5d66 <printint+0x6c>
    buf[i++] = '-';
    5d54:	fd040793          	addi	a5,s0,-48
    5d58:	96be                	add	a3,a3,a5
    5d5a:	02d00793          	li	a5,45
    5d5e:	fef68823          	sb	a5,-16(a3) # ff0 <linktest+0xe8>
    5d62:	0028069b          	addiw	a3,a6,2

  while(--i >= 0)
    5d66:	02d05963          	blez	a3,5d98 <printint+0x9e>
    5d6a:	89aa                	mv	s3,a0
    5d6c:	fc040793          	addi	a5,s0,-64
    5d70:	00d784b3          	add	s1,a5,a3
    5d74:	fff78913          	addi	s2,a5,-1
    5d78:	9936                	add	s2,s2,a3
    5d7a:	36fd                	addiw	a3,a3,-1
    5d7c:	1682                	slli	a3,a3,0x20
    5d7e:	9281                	srli	a3,a3,0x20
    5d80:	40d90933          	sub	s2,s2,a3
    putc(fd, buf[i]);
    5d84:	fff4c583          	lbu	a1,-1(s1)
    5d88:	854e                	mv	a0,s3
    5d8a:	00000097          	auipc	ra,0x0
    5d8e:	f4e080e7          	jalr	-178(ra) # 5cd8 <putc>
    5d92:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
    5d94:	ff2498e3          	bne	s1,s2,5d84 <printint+0x8a>
}
    5d98:	70e2                	ld	ra,56(sp)
    5d9a:	7442                	ld	s0,48(sp)
    5d9c:	74a2                	ld	s1,40(sp)
    5d9e:	7902                	ld	s2,32(sp)
    5da0:	69e2                	ld	s3,24(sp)
    5da2:	6121                	addi	sp,sp,64
    5da4:	8082                	ret

0000000000005da6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    5da6:	7119                	addi	sp,sp,-128
    5da8:	fc86                	sd	ra,120(sp)
    5daa:	f8a2                	sd	s0,112(sp)
    5dac:	f4a6                	sd	s1,104(sp)
    5dae:	f0ca                	sd	s2,96(sp)
    5db0:	ecce                	sd	s3,88(sp)
    5db2:	e8d2                	sd	s4,80(sp)
    5db4:	e4d6                	sd	s5,72(sp)
    5db6:	e0da                	sd	s6,64(sp)
    5db8:	fc5e                	sd	s7,56(sp)
    5dba:	f862                	sd	s8,48(sp)
    5dbc:	f466                	sd	s9,40(sp)
    5dbe:	f06a                	sd	s10,32(sp)
    5dc0:	ec6e                	sd	s11,24(sp)
    5dc2:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    5dc4:	0005c483          	lbu	s1,0(a1)
    5dc8:	18048d63          	beqz	s1,5f62 <vprintf+0x1bc>
    5dcc:	8aaa                	mv	s5,a0
    5dce:	8b32                	mv	s6,a2
    5dd0:	00158913          	addi	s2,a1,1
  state = 0;
    5dd4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    5dd6:	02500a13          	li	s4,37
      if(c == 'd'){
    5dda:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    5dde:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    5de2:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    5de6:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5dea:	00002b97          	auipc	s7,0x2
    5dee:	7eeb8b93          	addi	s7,s7,2030 # 85d8 <digits>
    5df2:	a839                	j	5e10 <vprintf+0x6a>
        putc(fd, c);
    5df4:	85a6                	mv	a1,s1
    5df6:	8556                	mv	a0,s5
    5df8:	00000097          	auipc	ra,0x0
    5dfc:	ee0080e7          	jalr	-288(ra) # 5cd8 <putc>
    5e00:	a019                	j	5e06 <vprintf+0x60>
    } else if(state == '%'){
    5e02:	01498f63          	beq	s3,s4,5e20 <vprintf+0x7a>
    5e06:	0905                	addi	s2,s2,1
  for(i = 0; fmt[i]; i++){
    5e08:	fff94483          	lbu	s1,-1(s2)
    5e0c:	14048b63          	beqz	s1,5f62 <vprintf+0x1bc>
    c = fmt[i] & 0xff;
    5e10:	0004879b          	sext.w	a5,s1
    if(state == 0){
    5e14:	fe0997e3          	bnez	s3,5e02 <vprintf+0x5c>
      if(c == '%'){
    5e18:	fd479ee3          	bne	a5,s4,5df4 <vprintf+0x4e>
        state = '%';
    5e1c:	89be                	mv	s3,a5
    5e1e:	b7e5                	j	5e06 <vprintf+0x60>
      if(c == 'd'){
    5e20:	05878063          	beq	a5,s8,5e60 <vprintf+0xba>
      } else if(c == 'l') {
    5e24:	05978c63          	beq	a5,s9,5e7c <vprintf+0xd6>
      } else if(c == 'x') {
    5e28:	07a78863          	beq	a5,s10,5e98 <vprintf+0xf2>
      } else if(c == 'p') {
    5e2c:	09b78463          	beq	a5,s11,5eb4 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    5e30:	07300713          	li	a4,115
    5e34:	0ce78563          	beq	a5,a4,5efe <vprintf+0x158>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    5e38:	06300713          	li	a4,99
    5e3c:	0ee78c63          	beq	a5,a4,5f34 <vprintf+0x18e>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    5e40:	11478663          	beq	a5,s4,5f4c <vprintf+0x1a6>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    5e44:	85d2                	mv	a1,s4
    5e46:	8556                	mv	a0,s5
    5e48:	00000097          	auipc	ra,0x0
    5e4c:	e90080e7          	jalr	-368(ra) # 5cd8 <putc>
        putc(fd, c);
    5e50:	85a6                	mv	a1,s1
    5e52:	8556                	mv	a0,s5
    5e54:	00000097          	auipc	ra,0x0
    5e58:	e84080e7          	jalr	-380(ra) # 5cd8 <putc>
      }
      state = 0;
    5e5c:	4981                	li	s3,0
    5e5e:	b765                	j	5e06 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    5e60:	008b0493          	addi	s1,s6,8
    5e64:	4685                	li	a3,1
    5e66:	4629                	li	a2,10
    5e68:	000b2583          	lw	a1,0(s6)
    5e6c:	8556                	mv	a0,s5
    5e6e:	00000097          	auipc	ra,0x0
    5e72:	e8c080e7          	jalr	-372(ra) # 5cfa <printint>
    5e76:	8b26                	mv	s6,s1
      state = 0;
    5e78:	4981                	li	s3,0
    5e7a:	b771                	j	5e06 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    5e7c:	008b0493          	addi	s1,s6,8
    5e80:	4681                	li	a3,0
    5e82:	4629                	li	a2,10
    5e84:	000b2583          	lw	a1,0(s6)
    5e88:	8556                	mv	a0,s5
    5e8a:	00000097          	auipc	ra,0x0
    5e8e:	e70080e7          	jalr	-400(ra) # 5cfa <printint>
    5e92:	8b26                	mv	s6,s1
      state = 0;
    5e94:	4981                	li	s3,0
    5e96:	bf85                	j	5e06 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    5e98:	008b0493          	addi	s1,s6,8
    5e9c:	4681                	li	a3,0
    5e9e:	4641                	li	a2,16
    5ea0:	000b2583          	lw	a1,0(s6)
    5ea4:	8556                	mv	a0,s5
    5ea6:	00000097          	auipc	ra,0x0
    5eaa:	e54080e7          	jalr	-428(ra) # 5cfa <printint>
    5eae:	8b26                	mv	s6,s1
      state = 0;
    5eb0:	4981                	li	s3,0
    5eb2:	bf91                	j	5e06 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    5eb4:	008b0793          	addi	a5,s6,8
    5eb8:	f8f43423          	sd	a5,-120(s0)
    5ebc:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    5ec0:	03000593          	li	a1,48
    5ec4:	8556                	mv	a0,s5
    5ec6:	00000097          	auipc	ra,0x0
    5eca:	e12080e7          	jalr	-494(ra) # 5cd8 <putc>
  putc(fd, 'x');
    5ece:	85ea                	mv	a1,s10
    5ed0:	8556                	mv	a0,s5
    5ed2:	00000097          	auipc	ra,0x0
    5ed6:	e06080e7          	jalr	-506(ra) # 5cd8 <putc>
    5eda:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5edc:	03c9d793          	srli	a5,s3,0x3c
    5ee0:	97de                	add	a5,a5,s7
    5ee2:	0007c583          	lbu	a1,0(a5)
    5ee6:	8556                	mv	a0,s5
    5ee8:	00000097          	auipc	ra,0x0
    5eec:	df0080e7          	jalr	-528(ra) # 5cd8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    5ef0:	0992                	slli	s3,s3,0x4
    5ef2:	34fd                	addiw	s1,s1,-1
    5ef4:	f4e5                	bnez	s1,5edc <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    5ef6:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    5efa:	4981                	li	s3,0
    5efc:	b729                	j	5e06 <vprintf+0x60>
        s = va_arg(ap, char*);
    5efe:	008b0993          	addi	s3,s6,8
    5f02:	000b3483          	ld	s1,0(s6)
        if(s == 0)
    5f06:	c085                	beqz	s1,5f26 <vprintf+0x180>
        while(*s != 0){
    5f08:	0004c583          	lbu	a1,0(s1)
    5f0c:	c9a1                	beqz	a1,5f5c <vprintf+0x1b6>
          putc(fd, *s);
    5f0e:	8556                	mv	a0,s5
    5f10:	00000097          	auipc	ra,0x0
    5f14:	dc8080e7          	jalr	-568(ra) # 5cd8 <putc>
          s++;
    5f18:	0485                	addi	s1,s1,1
        while(*s != 0){
    5f1a:	0004c583          	lbu	a1,0(s1)
    5f1e:	f9e5                	bnez	a1,5f0e <vprintf+0x168>
        s = va_arg(ap, char*);
    5f20:	8b4e                	mv	s6,s3
      state = 0;
    5f22:	4981                	li	s3,0
    5f24:	b5cd                	j	5e06 <vprintf+0x60>
          s = "(null)";
    5f26:	00002497          	auipc	s1,0x2
    5f2a:	6ca48493          	addi	s1,s1,1738 # 85f0 <digits+0x18>
        while(*s != 0){
    5f2e:	02800593          	li	a1,40
    5f32:	bff1                	j	5f0e <vprintf+0x168>
        putc(fd, va_arg(ap, uint));
    5f34:	008b0493          	addi	s1,s6,8
    5f38:	000b4583          	lbu	a1,0(s6)
    5f3c:	8556                	mv	a0,s5
    5f3e:	00000097          	auipc	ra,0x0
    5f42:	d9a080e7          	jalr	-614(ra) # 5cd8 <putc>
    5f46:	8b26                	mv	s6,s1
      state = 0;
    5f48:	4981                	li	s3,0
    5f4a:	bd75                	j	5e06 <vprintf+0x60>
        putc(fd, c);
    5f4c:	85d2                	mv	a1,s4
    5f4e:	8556                	mv	a0,s5
    5f50:	00000097          	auipc	ra,0x0
    5f54:	d88080e7          	jalr	-632(ra) # 5cd8 <putc>
      state = 0;
    5f58:	4981                	li	s3,0
    5f5a:	b575                	j	5e06 <vprintf+0x60>
        s = va_arg(ap, char*);
    5f5c:	8b4e                	mv	s6,s3
      state = 0;
    5f5e:	4981                	li	s3,0
    5f60:	b55d                	j	5e06 <vprintf+0x60>
    }
  }
}
    5f62:	70e6                	ld	ra,120(sp)
    5f64:	7446                	ld	s0,112(sp)
    5f66:	74a6                	ld	s1,104(sp)
    5f68:	7906                	ld	s2,96(sp)
    5f6a:	69e6                	ld	s3,88(sp)
    5f6c:	6a46                	ld	s4,80(sp)
    5f6e:	6aa6                	ld	s5,72(sp)
    5f70:	6b06                	ld	s6,64(sp)
    5f72:	7be2                	ld	s7,56(sp)
    5f74:	7c42                	ld	s8,48(sp)
    5f76:	7ca2                	ld	s9,40(sp)
    5f78:	7d02                	ld	s10,32(sp)
    5f7a:	6de2                	ld	s11,24(sp)
    5f7c:	6109                	addi	sp,sp,128
    5f7e:	8082                	ret

0000000000005f80 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    5f80:	715d                	addi	sp,sp,-80
    5f82:	ec06                	sd	ra,24(sp)
    5f84:	e822                	sd	s0,16(sp)
    5f86:	1000                	addi	s0,sp,32
    5f88:	e010                	sd	a2,0(s0)
    5f8a:	e414                	sd	a3,8(s0)
    5f8c:	e818                	sd	a4,16(s0)
    5f8e:	ec1c                	sd	a5,24(s0)
    5f90:	03043023          	sd	a6,32(s0)
    5f94:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    5f98:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    5f9c:	8622                	mv	a2,s0
    5f9e:	00000097          	auipc	ra,0x0
    5fa2:	e08080e7          	jalr	-504(ra) # 5da6 <vprintf>
}
    5fa6:	60e2                	ld	ra,24(sp)
    5fa8:	6442                	ld	s0,16(sp)
    5faa:	6161                	addi	sp,sp,80
    5fac:	8082                	ret

0000000000005fae <printf>:

void
printf(const char *fmt, ...)
{
    5fae:	711d                	addi	sp,sp,-96
    5fb0:	ec06                	sd	ra,24(sp)
    5fb2:	e822                	sd	s0,16(sp)
    5fb4:	1000                	addi	s0,sp,32
    5fb6:	e40c                	sd	a1,8(s0)
    5fb8:	e810                	sd	a2,16(s0)
    5fba:	ec14                	sd	a3,24(s0)
    5fbc:	f018                	sd	a4,32(s0)
    5fbe:	f41c                	sd	a5,40(s0)
    5fc0:	03043823          	sd	a6,48(s0)
    5fc4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    5fc8:	00840613          	addi	a2,s0,8
    5fcc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    5fd0:	85aa                	mv	a1,a0
    5fd2:	4505                	li	a0,1
    5fd4:	00000097          	auipc	ra,0x0
    5fd8:	dd2080e7          	jalr	-558(ra) # 5da6 <vprintf>
}
    5fdc:	60e2                	ld	ra,24(sp)
    5fde:	6442                	ld	s0,16(sp)
    5fe0:	6125                	addi	sp,sp,96
    5fe2:	8082                	ret

0000000000005fe4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    5fe4:	1141                	addi	sp,sp,-16
    5fe6:	e422                	sd	s0,8(sp)
    5fe8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    5fea:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5fee:	00003797          	auipc	a5,0x3
    5ff2:	46278793          	addi	a5,a5,1122 # 9450 <freep>
    5ff6:	639c                	ld	a5,0(a5)
    5ff8:	a805                	j	6028 <free+0x44>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    5ffa:	4618                	lw	a4,8(a2)
    5ffc:	9db9                	addw	a1,a1,a4
    5ffe:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    6002:	6398                	ld	a4,0(a5)
    6004:	6318                	ld	a4,0(a4)
    6006:	fee53823          	sd	a4,-16(a0)
    600a:	a091                	j	604e <free+0x6a>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    600c:	ff852703          	lw	a4,-8(a0)
    6010:	9e39                	addw	a2,a2,a4
    6012:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    6014:	ff053703          	ld	a4,-16(a0)
    6018:	e398                	sd	a4,0(a5)
    601a:	a099                	j	6060 <free+0x7c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    601c:	6398                	ld	a4,0(a5)
    601e:	00e7e463          	bltu	a5,a4,6026 <free+0x42>
    6022:	00e6ea63          	bltu	a3,a4,6036 <free+0x52>
{
    6026:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    6028:	fed7fae3          	bgeu	a5,a3,601c <free+0x38>
    602c:	6398                	ld	a4,0(a5)
    602e:	00e6e463          	bltu	a3,a4,6036 <free+0x52>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    6032:	fee7eae3          	bltu	a5,a4,6026 <free+0x42>
  if(bp + bp->s.size == p->s.ptr){
    6036:	ff852583          	lw	a1,-8(a0)
    603a:	6390                	ld	a2,0(a5)
    603c:	02059713          	slli	a4,a1,0x20
    6040:	9301                	srli	a4,a4,0x20
    6042:	0712                	slli	a4,a4,0x4
    6044:	9736                	add	a4,a4,a3
    6046:	fae60ae3          	beq	a2,a4,5ffa <free+0x16>
    bp->s.ptr = p->s.ptr;
    604a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    604e:	4790                	lw	a2,8(a5)
    6050:	02061713          	slli	a4,a2,0x20
    6054:	9301                	srli	a4,a4,0x20
    6056:	0712                	slli	a4,a4,0x4
    6058:	973e                	add	a4,a4,a5
    605a:	fae689e3          	beq	a3,a4,600c <free+0x28>
  } else
    p->s.ptr = bp;
    605e:	e394                	sd	a3,0(a5)
  freep = p;
    6060:	00003717          	auipc	a4,0x3
    6064:	3ef73823          	sd	a5,1008(a4) # 9450 <freep>
}
    6068:	6422                	ld	s0,8(sp)
    606a:	0141                	addi	sp,sp,16
    606c:	8082                	ret

000000000000606e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    606e:	7139                	addi	sp,sp,-64
    6070:	fc06                	sd	ra,56(sp)
    6072:	f822                	sd	s0,48(sp)
    6074:	f426                	sd	s1,40(sp)
    6076:	f04a                	sd	s2,32(sp)
    6078:	ec4e                	sd	s3,24(sp)
    607a:	e852                	sd	s4,16(sp)
    607c:	e456                	sd	s5,8(sp)
    607e:	e05a                	sd	s6,0(sp)
    6080:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    6082:	02051993          	slli	s3,a0,0x20
    6086:	0209d993          	srli	s3,s3,0x20
    608a:	09bd                	addi	s3,s3,15
    608c:	0049d993          	srli	s3,s3,0x4
    6090:	2985                	addiw	s3,s3,1
    6092:	0009891b          	sext.w	s2,s3
  if((prevp = freep) == 0){
    6096:	00003797          	auipc	a5,0x3
    609a:	3ba78793          	addi	a5,a5,954 # 9450 <freep>
    609e:	6388                	ld	a0,0(a5)
    60a0:	c515                	beqz	a0,60cc <malloc+0x5e>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    60a2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    60a4:	4798                	lw	a4,8(a5)
    60a6:	03277f63          	bgeu	a4,s2,60e4 <malloc+0x76>
    60aa:	8a4e                	mv	s4,s3
    60ac:	0009871b          	sext.w	a4,s3
    60b0:	6685                	lui	a3,0x1
    60b2:	00d77363          	bgeu	a4,a3,60b8 <malloc+0x4a>
    60b6:	6a05                	lui	s4,0x1
    60b8:	000a0a9b          	sext.w	s5,s4
  p = sbrk(nu * sizeof(Header));
    60bc:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    60c0:	00003497          	auipc	s1,0x3
    60c4:	39048493          	addi	s1,s1,912 # 9450 <freep>
  if(p == (char*)-1)
    60c8:	5b7d                	li	s6,-1
    60ca:	a885                	j	613a <malloc+0xcc>
    base.s.ptr = freep = prevp = &base;
    60cc:	0000a797          	auipc	a5,0xa
    60d0:	bac78793          	addi	a5,a5,-1108 # fc78 <base>
    60d4:	00003717          	auipc	a4,0x3
    60d8:	36f73e23          	sd	a5,892(a4) # 9450 <freep>
    60dc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    60de:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    60e2:	b7e1                	j	60aa <malloc+0x3c>
      if(p->s.size == nunits)
    60e4:	02e90b63          	beq	s2,a4,611a <malloc+0xac>
        p->s.size -= nunits;
    60e8:	4137073b          	subw	a4,a4,s3
    60ec:	c798                	sw	a4,8(a5)
        p += p->s.size;
    60ee:	1702                	slli	a4,a4,0x20
    60f0:	9301                	srli	a4,a4,0x20
    60f2:	0712                	slli	a4,a4,0x4
    60f4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    60f6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    60fa:	00003717          	auipc	a4,0x3
    60fe:	34a73b23          	sd	a0,854(a4) # 9450 <freep>
      return (void*)(p + 1);
    6102:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    6106:	70e2                	ld	ra,56(sp)
    6108:	7442                	ld	s0,48(sp)
    610a:	74a2                	ld	s1,40(sp)
    610c:	7902                	ld	s2,32(sp)
    610e:	69e2                	ld	s3,24(sp)
    6110:	6a42                	ld	s4,16(sp)
    6112:	6aa2                	ld	s5,8(sp)
    6114:	6b02                	ld	s6,0(sp)
    6116:	6121                	addi	sp,sp,64
    6118:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    611a:	6398                	ld	a4,0(a5)
    611c:	e118                	sd	a4,0(a0)
    611e:	bff1                	j	60fa <malloc+0x8c>
  hp->s.size = nu;
    6120:	01552423          	sw	s5,8(a0)
  free((void*)(hp + 1));
    6124:	0541                	addi	a0,a0,16
    6126:	00000097          	auipc	ra,0x0
    612a:	ebe080e7          	jalr	-322(ra) # 5fe4 <free>
  return freep;
    612e:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
    6130:	d979                	beqz	a0,6106 <malloc+0x98>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    6132:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    6134:	4798                	lw	a4,8(a5)
    6136:	fb2777e3          	bgeu	a4,s2,60e4 <malloc+0x76>
    if(p == freep)
    613a:	6098                	ld	a4,0(s1)
    613c:	853e                	mv	a0,a5
    613e:	fef71ae3          	bne	a4,a5,6132 <malloc+0xc4>
  p = sbrk(nu * sizeof(Header));
    6142:	8552                	mv	a0,s4
    6144:	00000097          	auipc	ra,0x0
    6148:	b5c080e7          	jalr	-1188(ra) # 5ca0 <sbrk>
  if(p == (char*)-1)
    614c:	fd651ae3          	bne	a0,s6,6120 <malloc+0xb2>
        return 0;
    6150:	4501                	li	a0,0
    6152:	bf55                	j	6106 <malloc+0x98>
