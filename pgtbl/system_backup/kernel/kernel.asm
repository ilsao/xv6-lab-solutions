
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0001a117          	auipc	sp,0x1a
    80000004:	00010113          	mv	sp,sp
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	139050ef          	jal	ra,8000594e <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	e426                	sd	s1,8(sp)
    80000024:	e04a                	sd	s2,0(sp)
    80000026:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000028:	03451793          	slli	a5,a0,0x34
    8000002c:	ebb9                	bnez	a5,80000082 <kfree+0x66>
    8000002e:	84aa                	mv	s1,a0
    80000030:	00022797          	auipc	a5,0x22
    80000034:	0d078793          	addi	a5,a5,208 # 80022100 <end>
    80000038:	04f56563          	bltu	a0,a5,80000082 <kfree+0x66>
    8000003c:	47c5                	li	a5,17
    8000003e:	07ee                	slli	a5,a5,0x1b
    80000040:	04f57163          	bgeu	a0,a5,80000082 <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000044:	6605                	lui	a2,0x1
    80000046:	4585                	li	a1,1
    80000048:	00000097          	auipc	ra,0x0
    8000004c:	17c080e7          	jalr	380(ra) # 800001c4 <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000050:	00009917          	auipc	s2,0x9
    80000054:	a4090913          	addi	s2,s2,-1472 # 80008a90 <kmem>
    80000058:	854a                	mv	a0,s2
    8000005a:	00006097          	auipc	ra,0x6
    8000005e:	33a080e7          	jalr	826(ra) # 80006394 <acquire>
  r->next = kmem.freelist;
    80000062:	01893783          	ld	a5,24(s2)
    80000066:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000068:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    8000006c:	854a                	mv	a0,s2
    8000006e:	00006097          	auipc	ra,0x6
    80000072:	3da080e7          	jalr	986(ra) # 80006448 <release>
}
    80000076:	60e2                	ld	ra,24(sp)
    80000078:	6442                	ld	s0,16(sp)
    8000007a:	64a2                	ld	s1,8(sp)
    8000007c:	6902                	ld	s2,0(sp)
    8000007e:	6105                	addi	sp,sp,32
    80000080:	8082                	ret
    panic("kfree");
    80000082:	00008517          	auipc	a0,0x8
    80000086:	f8e50513          	addi	a0,a0,-114 # 80008010 <etext+0x10>
    8000008a:	00006097          	auipc	ra,0x6
    8000008e:	da2080e7          	jalr	-606(ra) # 80005e2c <panic>

0000000080000092 <freerange>:
{
    80000092:	7179                	addi	sp,sp,-48
    80000094:	f406                	sd	ra,40(sp)
    80000096:	f022                	sd	s0,32(sp)
    80000098:	ec26                	sd	s1,24(sp)
    8000009a:	e84a                	sd	s2,16(sp)
    8000009c:	e44e                	sd	s3,8(sp)
    8000009e:	e052                	sd	s4,0(sp)
    800000a0:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    800000a2:	6705                	lui	a4,0x1
    800000a4:	fff70793          	addi	a5,a4,-1 # fff <_entry-0x7ffff001>
    800000a8:	00f504b3          	add	s1,a0,a5
    800000ac:	77fd                	lui	a5,0xfffff
    800000ae:	8cfd                	and	s1,s1,a5
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000b0:	94ba                	add	s1,s1,a4
    800000b2:	0095ee63          	bltu	a1,s1,800000ce <freerange+0x3c>
    800000b6:	892e                	mv	s2,a1
    kfree(p);
    800000b8:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000ba:	6985                	lui	s3,0x1
    kfree(p);
    800000bc:	01448533          	add	a0,s1,s4
    800000c0:	00000097          	auipc	ra,0x0
    800000c4:	f5c080e7          	jalr	-164(ra) # 8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000c8:	94ce                	add	s1,s1,s3
    800000ca:	fe9979e3          	bgeu	s2,s1,800000bc <freerange+0x2a>
}
    800000ce:	70a2                	ld	ra,40(sp)
    800000d0:	7402                	ld	s0,32(sp)
    800000d2:	64e2                	ld	s1,24(sp)
    800000d4:	6942                	ld	s2,16(sp)
    800000d6:	69a2                	ld	s3,8(sp)
    800000d8:	6a02                	ld	s4,0(sp)
    800000da:	6145                	addi	sp,sp,48
    800000dc:	8082                	ret

00000000800000de <kinit>:
{
    800000de:	1141                	addi	sp,sp,-16
    800000e0:	e406                	sd	ra,8(sp)
    800000e2:	e022                	sd	s0,0(sp)
    800000e4:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800000e6:	00008597          	auipc	a1,0x8
    800000ea:	f3258593          	addi	a1,a1,-206 # 80008018 <etext+0x18>
    800000ee:	00009517          	auipc	a0,0x9
    800000f2:	9a250513          	addi	a0,a0,-1630 # 80008a90 <kmem>
    800000f6:	00006097          	auipc	ra,0x6
    800000fa:	20e080e7          	jalr	526(ra) # 80006304 <initlock>
  freerange(end, (void*)PHYSTOP);
    800000fe:	45c5                	li	a1,17
    80000100:	05ee                	slli	a1,a1,0x1b
    80000102:	00022517          	auipc	a0,0x22
    80000106:	ffe50513          	addi	a0,a0,-2 # 80022100 <end>
    8000010a:	00000097          	auipc	ra,0x0
    8000010e:	f88080e7          	jalr	-120(ra) # 80000092 <freerange>
}
    80000112:	60a2                	ld	ra,8(sp)
    80000114:	6402                	ld	s0,0(sp)
    80000116:	0141                	addi	sp,sp,16
    80000118:	8082                	ret

000000008000011a <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    8000011a:	1101                	addi	sp,sp,-32
    8000011c:	ec06                	sd	ra,24(sp)
    8000011e:	e822                	sd	s0,16(sp)
    80000120:	e426                	sd	s1,8(sp)
    80000122:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000124:	00009497          	auipc	s1,0x9
    80000128:	96c48493          	addi	s1,s1,-1684 # 80008a90 <kmem>
    8000012c:	8526                	mv	a0,s1
    8000012e:	00006097          	auipc	ra,0x6
    80000132:	266080e7          	jalr	614(ra) # 80006394 <acquire>
  r = kmem.freelist;
    80000136:	6c84                	ld	s1,24(s1)
  if(r)
    80000138:	c885                	beqz	s1,80000168 <kalloc+0x4e>
    kmem.freelist = r->next;
    8000013a:	609c                	ld	a5,0(s1)
    8000013c:	00009517          	auipc	a0,0x9
    80000140:	95450513          	addi	a0,a0,-1708 # 80008a90 <kmem>
    80000144:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000146:	00006097          	auipc	ra,0x6
    8000014a:	302080e7          	jalr	770(ra) # 80006448 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000014e:	6605                	lui	a2,0x1
    80000150:	4595                	li	a1,5
    80000152:	8526                	mv	a0,s1
    80000154:	00000097          	auipc	ra,0x0
    80000158:	070080e7          	jalr	112(ra) # 800001c4 <memset>
  return (void*)r;
}
    8000015c:	8526                	mv	a0,s1
    8000015e:	60e2                	ld	ra,24(sp)
    80000160:	6442                	ld	s0,16(sp)
    80000162:	64a2                	ld	s1,8(sp)
    80000164:	6105                	addi	sp,sp,32
    80000166:	8082                	ret
  release(&kmem.lock);
    80000168:	00009517          	auipc	a0,0x9
    8000016c:	92850513          	addi	a0,a0,-1752 # 80008a90 <kmem>
    80000170:	00006097          	auipc	ra,0x6
    80000174:	2d8080e7          	jalr	728(ra) # 80006448 <release>
  if(r)
    80000178:	b7d5                	j	8000015c <kalloc+0x42>

000000008000017a <kfreemem>:

uint64 kfreemem(void)
{
    8000017a:	1101                	addi	sp,sp,-32
    8000017c:	ec06                	sd	ra,24(sp)
    8000017e:	e822                	sd	s0,16(sp)
    80000180:	e426                	sd	s1,8(sp)
    80000182:	1000                	addi	s0,sp,32
  uint64 sz = 0;
  struct run *r;

  acquire(&kmem.lock);
    80000184:	00009497          	auipc	s1,0x9
    80000188:	90c48493          	addi	s1,s1,-1780 # 80008a90 <kmem>
    8000018c:	8526                	mv	a0,s1
    8000018e:	00006097          	auipc	ra,0x6
    80000192:	206080e7          	jalr	518(ra) # 80006394 <acquire>
  r = kmem.freelist;
    80000196:	6c9c                	ld	a5,24(s1)
  while(r) {
    80000198:	c785                	beqz	a5,800001c0 <kfreemem+0x46>
  uint64 sz = 0;
    8000019a:	4481                	li	s1,0
    sz += PGSIZE;
    8000019c:	6705                	lui	a4,0x1
    8000019e:	94ba                	add	s1,s1,a4
    r = r->next;
    800001a0:	639c                	ld	a5,0(a5)
  while(r) {
    800001a2:	fff5                	bnez	a5,8000019e <kfreemem+0x24>
  }
  release(&kmem.lock);
    800001a4:	00009517          	auipc	a0,0x9
    800001a8:	8ec50513          	addi	a0,a0,-1812 # 80008a90 <kmem>
    800001ac:	00006097          	auipc	ra,0x6
    800001b0:	29c080e7          	jalr	668(ra) # 80006448 <release>

  return sz;
    800001b4:	8526                	mv	a0,s1
    800001b6:	60e2                	ld	ra,24(sp)
    800001b8:	6442                	ld	s0,16(sp)
    800001ba:	64a2                	ld	s1,8(sp)
    800001bc:	6105                	addi	sp,sp,32
    800001be:	8082                	ret
  uint64 sz = 0;
    800001c0:	4481                	li	s1,0
    800001c2:	b7cd                	j	800001a4 <kfreemem+0x2a>

00000000800001c4 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    800001c4:	1141                	addi	sp,sp,-16
    800001c6:	e422                	sd	s0,8(sp)
    800001c8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    800001ca:	ce09                	beqz	a2,800001e4 <memset+0x20>
    800001cc:	87aa                	mv	a5,a0
    800001ce:	fff6071b          	addiw	a4,a2,-1
    800001d2:	1702                	slli	a4,a4,0x20
    800001d4:	9301                	srli	a4,a4,0x20
    800001d6:	0705                	addi	a4,a4,1
    800001d8:	972a                	add	a4,a4,a0
    cdst[i] = c;
    800001da:	00b78023          	sb	a1,0(a5) # fffffffffffff000 <end+0xffffffff7ffdcf00>
    800001de:	0785                	addi	a5,a5,1
  for(i = 0; i < n; i++){
    800001e0:	fee79de3          	bne	a5,a4,800001da <memset+0x16>
  }
  return dst;
}
    800001e4:	6422                	ld	s0,8(sp)
    800001e6:	0141                	addi	sp,sp,16
    800001e8:	8082                	ret

00000000800001ea <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    800001ea:	1141                	addi	sp,sp,-16
    800001ec:	e422                	sd	s0,8(sp)
    800001ee:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    800001f0:	ce15                	beqz	a2,8000022c <memcmp+0x42>
    800001f2:	fff6069b          	addiw	a3,a2,-1
    if(*s1 != *s2)
    800001f6:	00054783          	lbu	a5,0(a0)
    800001fa:	0005c703          	lbu	a4,0(a1)
    800001fe:	02e79063          	bne	a5,a4,8000021e <memcmp+0x34>
    80000202:	1682                	slli	a3,a3,0x20
    80000204:	9281                	srli	a3,a3,0x20
    80000206:	0685                	addi	a3,a3,1
    80000208:	96aa                	add	a3,a3,a0
      return *s1 - *s2;
    s1++, s2++;
    8000020a:	0505                	addi	a0,a0,1
    8000020c:	0585                	addi	a1,a1,1
  while(n-- > 0){
    8000020e:	00d50d63          	beq	a0,a3,80000228 <memcmp+0x3e>
    if(*s1 != *s2)
    80000212:	00054783          	lbu	a5,0(a0)
    80000216:	0005c703          	lbu	a4,0(a1)
    8000021a:	fee788e3          	beq	a5,a4,8000020a <memcmp+0x20>
      return *s1 - *s2;
    8000021e:	40e7853b          	subw	a0,a5,a4
  }

  return 0;
}
    80000222:	6422                	ld	s0,8(sp)
    80000224:	0141                	addi	sp,sp,16
    80000226:	8082                	ret
  return 0;
    80000228:	4501                	li	a0,0
    8000022a:	bfe5                	j	80000222 <memcmp+0x38>
    8000022c:	4501                	li	a0,0
    8000022e:	bfd5                	j	80000222 <memcmp+0x38>

0000000080000230 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    80000230:	1141                	addi	sp,sp,-16
    80000232:	e422                	sd	s0,8(sp)
    80000234:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    80000236:	c215                	beqz	a2,8000025a <memmove+0x2a>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    80000238:	02a5e463          	bltu	a1,a0,80000260 <memmove+0x30>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    8000023c:	fff6079b          	addiw	a5,a2,-1
    80000240:	1782                	slli	a5,a5,0x20
    80000242:	9381                	srli	a5,a5,0x20
    80000244:	0785                	addi	a5,a5,1
    80000246:	97ae                	add	a5,a5,a1
    80000248:	872a                	mv	a4,a0
      *d++ = *s++;
    8000024a:	0585                	addi	a1,a1,1
    8000024c:	0705                	addi	a4,a4,1
    8000024e:	fff5c683          	lbu	a3,-1(a1)
    80000252:	fed70fa3          	sb	a3,-1(a4) # fff <_entry-0x7ffff001>
    while(n-- > 0)
    80000256:	fef59ae3          	bne	a1,a5,8000024a <memmove+0x1a>

  return dst;
}
    8000025a:	6422                	ld	s0,8(sp)
    8000025c:	0141                	addi	sp,sp,16
    8000025e:	8082                	ret
  if(s < d && s + n > d){
    80000260:	02061693          	slli	a3,a2,0x20
    80000264:	9281                	srli	a3,a3,0x20
    80000266:	00d58733          	add	a4,a1,a3
    8000026a:	fce579e3          	bgeu	a0,a4,8000023c <memmove+0xc>
    d += n;
    8000026e:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    80000270:	fff6079b          	addiw	a5,a2,-1
    80000274:	1782                	slli	a5,a5,0x20
    80000276:	9381                	srli	a5,a5,0x20
    80000278:	fff7c793          	not	a5,a5
    8000027c:	97ba                	add	a5,a5,a4
      *--d = *--s;
    8000027e:	177d                	addi	a4,a4,-1
    80000280:	16fd                	addi	a3,a3,-1
    80000282:	00074603          	lbu	a2,0(a4)
    80000286:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    8000028a:	fee79ae3          	bne	a5,a4,8000027e <memmove+0x4e>
    8000028e:	b7f1                	j	8000025a <memmove+0x2a>

0000000080000290 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000290:	1141                	addi	sp,sp,-16
    80000292:	e406                	sd	ra,8(sp)
    80000294:	e022                	sd	s0,0(sp)
    80000296:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000298:	00000097          	auipc	ra,0x0
    8000029c:	f98080e7          	jalr	-104(ra) # 80000230 <memmove>
}
    800002a0:	60a2                	ld	ra,8(sp)
    800002a2:	6402                	ld	s0,0(sp)
    800002a4:	0141                	addi	sp,sp,16
    800002a6:	8082                	ret

00000000800002a8 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    800002a8:	1141                	addi	sp,sp,-16
    800002aa:	e422                	sd	s0,8(sp)
    800002ac:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    800002ae:	c229                	beqz	a2,800002f0 <strncmp+0x48>
    800002b0:	00054783          	lbu	a5,0(a0)
    800002b4:	c795                	beqz	a5,800002e0 <strncmp+0x38>
    800002b6:	0005c703          	lbu	a4,0(a1)
    800002ba:	02f71363          	bne	a4,a5,800002e0 <strncmp+0x38>
    800002be:	fff6071b          	addiw	a4,a2,-1
    800002c2:	1702                	slli	a4,a4,0x20
    800002c4:	9301                	srli	a4,a4,0x20
    800002c6:	0705                	addi	a4,a4,1
    800002c8:	972a                	add	a4,a4,a0
    n--, p++, q++;
    800002ca:	0505                	addi	a0,a0,1
    800002cc:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    800002ce:	02e50363          	beq	a0,a4,800002f4 <strncmp+0x4c>
    800002d2:	00054783          	lbu	a5,0(a0)
    800002d6:	c789                	beqz	a5,800002e0 <strncmp+0x38>
    800002d8:	0005c683          	lbu	a3,0(a1)
    800002dc:	fef687e3          	beq	a3,a5,800002ca <strncmp+0x22>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
    800002e0:	00054503          	lbu	a0,0(a0)
    800002e4:	0005c783          	lbu	a5,0(a1)
    800002e8:	9d1d                	subw	a0,a0,a5
}
    800002ea:	6422                	ld	s0,8(sp)
    800002ec:	0141                	addi	sp,sp,16
    800002ee:	8082                	ret
    return 0;
    800002f0:	4501                	li	a0,0
    800002f2:	bfe5                	j	800002ea <strncmp+0x42>
    800002f4:	4501                	li	a0,0
    800002f6:	bfd5                	j	800002ea <strncmp+0x42>

00000000800002f8 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    800002f8:	1141                	addi	sp,sp,-16
    800002fa:	e422                	sd	s0,8(sp)
    800002fc:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    800002fe:	872a                	mv	a4,a0
    80000300:	a011                	j	80000304 <strncpy+0xc>
    80000302:	8642                	mv	a2,a6
    80000304:	fff6081b          	addiw	a6,a2,-1
    80000308:	00c05963          	blez	a2,8000031a <strncpy+0x22>
    8000030c:	0705                	addi	a4,a4,1
    8000030e:	0005c783          	lbu	a5,0(a1)
    80000312:	fef70fa3          	sb	a5,-1(a4)
    80000316:	0585                	addi	a1,a1,1
    80000318:	f7ed                	bnez	a5,80000302 <strncpy+0xa>
    ;
  while(n-- > 0)
    8000031a:	86ba                	mv	a3,a4
    8000031c:	01005b63          	blez	a6,80000332 <strncpy+0x3a>
    *s++ = 0;
    80000320:	0685                	addi	a3,a3,1
    80000322:	fe068fa3          	sb	zero,-1(a3)
    80000326:	fff6c793          	not	a5,a3
    8000032a:	9fb9                	addw	a5,a5,a4
  while(n-- > 0)
    8000032c:	9fb1                	addw	a5,a5,a2
    8000032e:	fef049e3          	bgtz	a5,80000320 <strncpy+0x28>
  return os;
}
    80000332:	6422                	ld	s0,8(sp)
    80000334:	0141                	addi	sp,sp,16
    80000336:	8082                	ret

0000000080000338 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    80000338:	1141                	addi	sp,sp,-16
    8000033a:	e422                	sd	s0,8(sp)
    8000033c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    8000033e:	02c05363          	blez	a2,80000364 <safestrcpy+0x2c>
    80000342:	fff6069b          	addiw	a3,a2,-1
    80000346:	1682                	slli	a3,a3,0x20
    80000348:	9281                	srli	a3,a3,0x20
    8000034a:	96ae                	add	a3,a3,a1
    8000034c:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    8000034e:	00d58963          	beq	a1,a3,80000360 <safestrcpy+0x28>
    80000352:	0585                	addi	a1,a1,1
    80000354:	0785                	addi	a5,a5,1
    80000356:	fff5c703          	lbu	a4,-1(a1)
    8000035a:	fee78fa3          	sb	a4,-1(a5)
    8000035e:	fb65                	bnez	a4,8000034e <safestrcpy+0x16>
    ;
  *s = 0;
    80000360:	00078023          	sb	zero,0(a5)
  return os;
}
    80000364:	6422                	ld	s0,8(sp)
    80000366:	0141                	addi	sp,sp,16
    80000368:	8082                	ret

000000008000036a <strlen>:

int
strlen(const char *s)
{
    8000036a:	1141                	addi	sp,sp,-16
    8000036c:	e422                	sd	s0,8(sp)
    8000036e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    80000370:	00054783          	lbu	a5,0(a0)
    80000374:	cf91                	beqz	a5,80000390 <strlen+0x26>
    80000376:	0505                	addi	a0,a0,1
    80000378:	87aa                	mv	a5,a0
    8000037a:	4685                	li	a3,1
    8000037c:	9e89                	subw	a3,a3,a0
    ;
    8000037e:	00f6853b          	addw	a0,a3,a5
    80000382:	0785                	addi	a5,a5,1
  for(n = 0; s[n]; n++)
    80000384:	fff7c703          	lbu	a4,-1(a5)
    80000388:	fb7d                	bnez	a4,8000037e <strlen+0x14>
  return n;
}
    8000038a:	6422                	ld	s0,8(sp)
    8000038c:	0141                	addi	sp,sp,16
    8000038e:	8082                	ret
  for(n = 0; s[n]; n++)
    80000390:	4501                	li	a0,0
    80000392:	bfe5                	j	8000038a <strlen+0x20>

0000000080000394 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000394:	1141                	addi	sp,sp,-16
    80000396:	e406                	sd	ra,8(sp)
    80000398:	e022                	sd	s0,0(sp)
    8000039a:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    8000039c:	00001097          	auipc	ra,0x1
    800003a0:	b0c080e7          	jalr	-1268(ra) # 80000ea8 <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    800003a4:	00008717          	auipc	a4,0x8
    800003a8:	6bc70713          	addi	a4,a4,1724 # 80008a60 <started>
  if(cpuid() == 0){
    800003ac:	c139                	beqz	a0,800003f2 <main+0x5e>
    while(started == 0)
    800003ae:	431c                	lw	a5,0(a4)
    800003b0:	2781                	sext.w	a5,a5
    800003b2:	dff5                	beqz	a5,800003ae <main+0x1a>
      ;
    __sync_synchronize();
    800003b4:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    800003b8:	00001097          	auipc	ra,0x1
    800003bc:	af0080e7          	jalr	-1296(ra) # 80000ea8 <cpuid>
    800003c0:	85aa                	mv	a1,a0
    800003c2:	00008517          	auipc	a0,0x8
    800003c6:	c7650513          	addi	a0,a0,-906 # 80008038 <etext+0x38>
    800003ca:	00006097          	auipc	ra,0x6
    800003ce:	aac080e7          	jalr	-1364(ra) # 80005e76 <printf>
    kvminithart();    // turn on paging
    800003d2:	00000097          	auipc	ra,0x0
    800003d6:	0d8080e7          	jalr	216(ra) # 800004aa <kvminithart>
    trapinithart();   // install kernel trap vector
    800003da:	00002097          	auipc	ra,0x2
    800003de:	812080e7          	jalr	-2030(ra) # 80001bec <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    800003e2:	00005097          	auipc	ra,0x5
    800003e6:	efe080e7          	jalr	-258(ra) # 800052e0 <plicinithart>
  }

  scheduler();        
    800003ea:	00001097          	auipc	ra,0x1
    800003ee:	fe6080e7          	jalr	-26(ra) # 800013d0 <scheduler>
    consoleinit();
    800003f2:	00006097          	auipc	ra,0x6
    800003f6:	94a080e7          	jalr	-1718(ra) # 80005d3c <consoleinit>
    printfinit();
    800003fa:	00006097          	auipc	ra,0x6
    800003fe:	c62080e7          	jalr	-926(ra) # 8000605c <printfinit>
    printf("\n");
    80000402:	00008517          	auipc	a0,0x8
    80000406:	c4650513          	addi	a0,a0,-954 # 80008048 <etext+0x48>
    8000040a:	00006097          	auipc	ra,0x6
    8000040e:	a6c080e7          	jalr	-1428(ra) # 80005e76 <printf>
    printf("xv6 kernel is booting\n");
    80000412:	00008517          	auipc	a0,0x8
    80000416:	c0e50513          	addi	a0,a0,-1010 # 80008020 <etext+0x20>
    8000041a:	00006097          	auipc	ra,0x6
    8000041e:	a5c080e7          	jalr	-1444(ra) # 80005e76 <printf>
    printf("\n");
    80000422:	00008517          	auipc	a0,0x8
    80000426:	c2650513          	addi	a0,a0,-986 # 80008048 <etext+0x48>
    8000042a:	00006097          	auipc	ra,0x6
    8000042e:	a4c080e7          	jalr	-1460(ra) # 80005e76 <printf>
    kinit();         // physical page allocator
    80000432:	00000097          	auipc	ra,0x0
    80000436:	cac080e7          	jalr	-852(ra) # 800000de <kinit>
    kvminit();       // create kernel page table
    8000043a:	00000097          	auipc	ra,0x0
    8000043e:	326080e7          	jalr	806(ra) # 80000760 <kvminit>
    kvminithart();   // turn on paging
    80000442:	00000097          	auipc	ra,0x0
    80000446:	068080e7          	jalr	104(ra) # 800004aa <kvminithart>
    procinit();      // process table
    8000044a:	00001097          	auipc	ra,0x1
    8000044e:	9ac080e7          	jalr	-1620(ra) # 80000df6 <procinit>
    trapinit();      // trap vectors
    80000452:	00001097          	auipc	ra,0x1
    80000456:	772080e7          	jalr	1906(ra) # 80001bc4 <trapinit>
    trapinithart();  // install kernel trap vector
    8000045a:	00001097          	auipc	ra,0x1
    8000045e:	792080e7          	jalr	1938(ra) # 80001bec <trapinithart>
    plicinit();      // set up interrupt controller
    80000462:	00005097          	auipc	ra,0x5
    80000466:	e68080e7          	jalr	-408(ra) # 800052ca <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    8000046a:	00005097          	auipc	ra,0x5
    8000046e:	e76080e7          	jalr	-394(ra) # 800052e0 <plicinithart>
    binit();         // buffer cache
    80000472:	00002097          	auipc	ra,0x2
    80000476:	f74080e7          	jalr	-140(ra) # 800023e6 <binit>
    iinit();         // inode table
    8000047a:	00002097          	auipc	ra,0x2
    8000047e:	648080e7          	jalr	1608(ra) # 80002ac2 <iinit>
    fileinit();      // file table
    80000482:	00003097          	auipc	ra,0x3
    80000486:	610080e7          	jalr	1552(ra) # 80003a92 <fileinit>
    virtio_disk_init(); // emulated hard disk
    8000048a:	00005097          	auipc	ra,0x5
    8000048e:	f5e080e7          	jalr	-162(ra) # 800053e8 <virtio_disk_init>
    userinit();      // first user process
    80000492:	00001097          	auipc	ra,0x1
    80000496:	d1c080e7          	jalr	-740(ra) # 800011ae <userinit>
    __sync_synchronize();
    8000049a:	0ff0000f          	fence
    started = 1;
    8000049e:	4785                	li	a5,1
    800004a0:	00008717          	auipc	a4,0x8
    800004a4:	5cf72023          	sw	a5,1472(a4) # 80008a60 <started>
    800004a8:	b789                	j	800003ea <main+0x56>

00000000800004aa <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    800004aa:	1141                	addi	sp,sp,-16
    800004ac:	e422                	sd	s0,8(sp)
    800004ae:	0800                	addi	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    800004b0:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    800004b4:	00008797          	auipc	a5,0x8
    800004b8:	5b478793          	addi	a5,a5,1460 # 80008a68 <kernel_pagetable>
    800004bc:	639c                	ld	a5,0(a5)
    800004be:	83b1                	srli	a5,a5,0xc
    800004c0:	577d                	li	a4,-1
    800004c2:	177e                	slli	a4,a4,0x3f
    800004c4:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    800004c6:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    800004ca:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    800004ce:	6422                	ld	s0,8(sp)
    800004d0:	0141                	addi	sp,sp,16
    800004d2:	8082                	ret

00000000800004d4 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    800004d4:	7139                	addi	sp,sp,-64
    800004d6:	fc06                	sd	ra,56(sp)
    800004d8:	f822                	sd	s0,48(sp)
    800004da:	f426                	sd	s1,40(sp)
    800004dc:	f04a                	sd	s2,32(sp)
    800004de:	ec4e                	sd	s3,24(sp)
    800004e0:	e852                	sd	s4,16(sp)
    800004e2:	e456                	sd	s5,8(sp)
    800004e4:	e05a                	sd	s6,0(sp)
    800004e6:	0080                	addi	s0,sp,64
    800004e8:	84aa                	mv	s1,a0
    800004ea:	89ae                	mv	s3,a1
    800004ec:	8b32                	mv	s6,a2
  if(va >= MAXVA)
    800004ee:	57fd                	li	a5,-1
    800004f0:	83e9                	srli	a5,a5,0x1a
    800004f2:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    800004f4:	4ab1                	li	s5,12
  if(va >= MAXVA)
    800004f6:	04b7f263          	bgeu	a5,a1,8000053a <walk+0x66>
    panic("walk");
    800004fa:	00008517          	auipc	a0,0x8
    800004fe:	b5650513          	addi	a0,a0,-1194 # 80008050 <etext+0x50>
    80000502:	00006097          	auipc	ra,0x6
    80000506:	92a080e7          	jalr	-1750(ra) # 80005e2c <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    8000050a:	060b0663          	beqz	s6,80000576 <walk+0xa2>
    8000050e:	00000097          	auipc	ra,0x0
    80000512:	c0c080e7          	jalr	-1012(ra) # 8000011a <kalloc>
    80000516:	84aa                	mv	s1,a0
    80000518:	c529                	beqz	a0,80000562 <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    8000051a:	6605                	lui	a2,0x1
    8000051c:	4581                	li	a1,0
    8000051e:	00000097          	auipc	ra,0x0
    80000522:	ca6080e7          	jalr	-858(ra) # 800001c4 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80000526:	00c4d793          	srli	a5,s1,0xc
    8000052a:	07aa                	slli	a5,a5,0xa
    8000052c:	0017e793          	ori	a5,a5,1
    80000530:	00f93023          	sd	a5,0(s2)
    80000534:	3a5d                	addiw	s4,s4,-9
  for(int level = 2; level > 0; level--) {
    80000536:	035a0063          	beq	s4,s5,80000556 <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    8000053a:	0149d933          	srl	s2,s3,s4
    8000053e:	1ff97913          	andi	s2,s2,511
    80000542:	090e                	slli	s2,s2,0x3
    80000544:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    80000546:	00093483          	ld	s1,0(s2)
    8000054a:	0014f793          	andi	a5,s1,1
    8000054e:	dfd5                	beqz	a5,8000050a <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80000550:	80a9                	srli	s1,s1,0xa
    80000552:	04b2                	slli	s1,s1,0xc
    80000554:	b7c5                	j	80000534 <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    80000556:	00c9d513          	srli	a0,s3,0xc
    8000055a:	1ff57513          	andi	a0,a0,511
    8000055e:	050e                	slli	a0,a0,0x3
    80000560:	9526                	add	a0,a0,s1
}
    80000562:	70e2                	ld	ra,56(sp)
    80000564:	7442                	ld	s0,48(sp)
    80000566:	74a2                	ld	s1,40(sp)
    80000568:	7902                	ld	s2,32(sp)
    8000056a:	69e2                	ld	s3,24(sp)
    8000056c:	6a42                	ld	s4,16(sp)
    8000056e:	6aa2                	ld	s5,8(sp)
    80000570:	6b02                	ld	s6,0(sp)
    80000572:	6121                	addi	sp,sp,64
    80000574:	8082                	ret
        return 0;
    80000576:	4501                	li	a0,0
    80000578:	b7ed                	j	80000562 <walk+0x8e>

000000008000057a <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    8000057a:	57fd                	li	a5,-1
    8000057c:	83e9                	srli	a5,a5,0x1a
    8000057e:	00b7f463          	bgeu	a5,a1,80000586 <walkaddr+0xc>
    return 0;
    80000582:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80000584:	8082                	ret
{
    80000586:	1141                	addi	sp,sp,-16
    80000588:	e406                	sd	ra,8(sp)
    8000058a:	e022                	sd	s0,0(sp)
    8000058c:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    8000058e:	4601                	li	a2,0
    80000590:	00000097          	auipc	ra,0x0
    80000594:	f44080e7          	jalr	-188(ra) # 800004d4 <walk>
  if(pte == 0)
    80000598:	c105                	beqz	a0,800005b8 <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    8000059a:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    8000059c:	0117f693          	andi	a3,a5,17
    800005a0:	4745                	li	a4,17
    return 0;
    800005a2:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    800005a4:	00e68663          	beq	a3,a4,800005b0 <walkaddr+0x36>
}
    800005a8:	60a2                	ld	ra,8(sp)
    800005aa:	6402                	ld	s0,0(sp)
    800005ac:	0141                	addi	sp,sp,16
    800005ae:	8082                	ret
  pa = PTE2PA(*pte);
    800005b0:	00a7d513          	srli	a0,a5,0xa
    800005b4:	0532                	slli	a0,a0,0xc
  return pa;
    800005b6:	bfcd                	j	800005a8 <walkaddr+0x2e>
    return 0;
    800005b8:	4501                	li	a0,0
    800005ba:	b7fd                	j	800005a8 <walkaddr+0x2e>

00000000800005bc <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    800005bc:	715d                	addi	sp,sp,-80
    800005be:	e486                	sd	ra,72(sp)
    800005c0:	e0a2                	sd	s0,64(sp)
    800005c2:	fc26                	sd	s1,56(sp)
    800005c4:	f84a                	sd	s2,48(sp)
    800005c6:	f44e                	sd	s3,40(sp)
    800005c8:	f052                	sd	s4,32(sp)
    800005ca:	ec56                	sd	s5,24(sp)
    800005cc:	e85a                	sd	s6,16(sp)
    800005ce:	e45e                	sd	s7,8(sp)
    800005d0:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    800005d2:	ce19                	beqz	a2,800005f0 <mappages+0x34>
    800005d4:	8aaa                	mv	s5,a0
    800005d6:	8b3a                	mv	s6,a4
    panic("mappages: size");
  
  a = PGROUNDDOWN(va);
    800005d8:	79fd                	lui	s3,0xfffff
    800005da:	0135f7b3          	and	a5,a1,s3
  last = PGROUNDDOWN(va + size - 1);
    800005de:	15fd                	addi	a1,a1,-1
    800005e0:	95b2                	add	a1,a1,a2
    800005e2:	0135f9b3          	and	s3,a1,s3
  a = PGROUNDDOWN(va);
    800005e6:	893e                	mv	s2,a5
    800005e8:	40f68a33          	sub	s4,a3,a5
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    800005ec:	6b85                	lui	s7,0x1
    800005ee:	a015                	j	80000612 <mappages+0x56>
    panic("mappages: size");
    800005f0:	00008517          	auipc	a0,0x8
    800005f4:	a6850513          	addi	a0,a0,-1432 # 80008058 <etext+0x58>
    800005f8:	00006097          	auipc	ra,0x6
    800005fc:	834080e7          	jalr	-1996(ra) # 80005e2c <panic>
      panic("mappages: remap");
    80000600:	00008517          	auipc	a0,0x8
    80000604:	a6850513          	addi	a0,a0,-1432 # 80008068 <etext+0x68>
    80000608:	00006097          	auipc	ra,0x6
    8000060c:	824080e7          	jalr	-2012(ra) # 80005e2c <panic>
    a += PGSIZE;
    80000610:	995e                	add	s2,s2,s7
    pa += PGSIZE;
    80000612:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    80000616:	4605                	li	a2,1
    80000618:	85ca                	mv	a1,s2
    8000061a:	8556                	mv	a0,s5
    8000061c:	00000097          	auipc	ra,0x0
    80000620:	eb8080e7          	jalr	-328(ra) # 800004d4 <walk>
    80000624:	cd19                	beqz	a0,80000642 <mappages+0x86>
    if(*pte & PTE_V)
    80000626:	611c                	ld	a5,0(a0)
    80000628:	8b85                	andi	a5,a5,1
    8000062a:	fbf9                	bnez	a5,80000600 <mappages+0x44>
    *pte = PA2PTE(pa) | perm | PTE_V;
    8000062c:	80b1                	srli	s1,s1,0xc
    8000062e:	04aa                	slli	s1,s1,0xa
    80000630:	0164e4b3          	or	s1,s1,s6
    80000634:	0014e493          	ori	s1,s1,1
    80000638:	e104                	sd	s1,0(a0)
    if(a == last)
    8000063a:	fd391be3          	bne	s2,s3,80000610 <mappages+0x54>
  }
  return 0;
    8000063e:	4501                	li	a0,0
    80000640:	a011                	j	80000644 <mappages+0x88>
      return -1;
    80000642:	557d                	li	a0,-1
}
    80000644:	60a6                	ld	ra,72(sp)
    80000646:	6406                	ld	s0,64(sp)
    80000648:	74e2                	ld	s1,56(sp)
    8000064a:	7942                	ld	s2,48(sp)
    8000064c:	79a2                	ld	s3,40(sp)
    8000064e:	7a02                	ld	s4,32(sp)
    80000650:	6ae2                	ld	s5,24(sp)
    80000652:	6b42                	ld	s6,16(sp)
    80000654:	6ba2                	ld	s7,8(sp)
    80000656:	6161                	addi	sp,sp,80
    80000658:	8082                	ret

000000008000065a <kvmmap>:
{
    8000065a:	1141                	addi	sp,sp,-16
    8000065c:	e406                	sd	ra,8(sp)
    8000065e:	e022                	sd	s0,0(sp)
    80000660:	0800                	addi	s0,sp,16
    80000662:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80000664:	86b2                	mv	a3,a2
    80000666:	863e                	mv	a2,a5
    80000668:	00000097          	auipc	ra,0x0
    8000066c:	f54080e7          	jalr	-172(ra) # 800005bc <mappages>
    80000670:	e509                	bnez	a0,8000067a <kvmmap+0x20>
}
    80000672:	60a2                	ld	ra,8(sp)
    80000674:	6402                	ld	s0,0(sp)
    80000676:	0141                	addi	sp,sp,16
    80000678:	8082                	ret
    panic("kvmmap");
    8000067a:	00008517          	auipc	a0,0x8
    8000067e:	9fe50513          	addi	a0,a0,-1538 # 80008078 <etext+0x78>
    80000682:	00005097          	auipc	ra,0x5
    80000686:	7aa080e7          	jalr	1962(ra) # 80005e2c <panic>

000000008000068a <kvmmake>:
{
    8000068a:	1101                	addi	sp,sp,-32
    8000068c:	ec06                	sd	ra,24(sp)
    8000068e:	e822                	sd	s0,16(sp)
    80000690:	e426                	sd	s1,8(sp)
    80000692:	e04a                	sd	s2,0(sp)
    80000694:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    80000696:	00000097          	auipc	ra,0x0
    8000069a:	a84080e7          	jalr	-1404(ra) # 8000011a <kalloc>
    8000069e:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    800006a0:	6605                	lui	a2,0x1
    800006a2:	4581                	li	a1,0
    800006a4:	00000097          	auipc	ra,0x0
    800006a8:	b20080e7          	jalr	-1248(ra) # 800001c4 <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    800006ac:	4719                	li	a4,6
    800006ae:	6685                	lui	a3,0x1
    800006b0:	10000637          	lui	a2,0x10000
    800006b4:	100005b7          	lui	a1,0x10000
    800006b8:	8526                	mv	a0,s1
    800006ba:	00000097          	auipc	ra,0x0
    800006be:	fa0080e7          	jalr	-96(ra) # 8000065a <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    800006c2:	4719                	li	a4,6
    800006c4:	6685                	lui	a3,0x1
    800006c6:	10001637          	lui	a2,0x10001
    800006ca:	100015b7          	lui	a1,0x10001
    800006ce:	8526                	mv	a0,s1
    800006d0:	00000097          	auipc	ra,0x0
    800006d4:	f8a080e7          	jalr	-118(ra) # 8000065a <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    800006d8:	4719                	li	a4,6
    800006da:	004006b7          	lui	a3,0x400
    800006de:	0c000637          	lui	a2,0xc000
    800006e2:	0c0005b7          	lui	a1,0xc000
    800006e6:	8526                	mv	a0,s1
    800006e8:	00000097          	auipc	ra,0x0
    800006ec:	f72080e7          	jalr	-142(ra) # 8000065a <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800006f0:	00008917          	auipc	s2,0x8
    800006f4:	91090913          	addi	s2,s2,-1776 # 80008000 <etext>
    800006f8:	4729                	li	a4,10
    800006fa:	80008697          	auipc	a3,0x80008
    800006fe:	90668693          	addi	a3,a3,-1786 # 8000 <_entry-0x7fff8000>
    80000702:	4605                	li	a2,1
    80000704:	067e                	slli	a2,a2,0x1f
    80000706:	85b2                	mv	a1,a2
    80000708:	8526                	mv	a0,s1
    8000070a:	00000097          	auipc	ra,0x0
    8000070e:	f50080e7          	jalr	-176(ra) # 8000065a <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    80000712:	4719                	li	a4,6
    80000714:	46c5                	li	a3,17
    80000716:	06ee                	slli	a3,a3,0x1b
    80000718:	412686b3          	sub	a3,a3,s2
    8000071c:	864a                	mv	a2,s2
    8000071e:	85ca                	mv	a1,s2
    80000720:	8526                	mv	a0,s1
    80000722:	00000097          	auipc	ra,0x0
    80000726:	f38080e7          	jalr	-200(ra) # 8000065a <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    8000072a:	4729                	li	a4,10
    8000072c:	6685                	lui	a3,0x1
    8000072e:	00007617          	auipc	a2,0x7
    80000732:	8d260613          	addi	a2,a2,-1838 # 80007000 <_trampoline>
    80000736:	040005b7          	lui	a1,0x4000
    8000073a:	15fd                	addi	a1,a1,-1
    8000073c:	05b2                	slli	a1,a1,0xc
    8000073e:	8526                	mv	a0,s1
    80000740:	00000097          	auipc	ra,0x0
    80000744:	f1a080e7          	jalr	-230(ra) # 8000065a <kvmmap>
  proc_mapstacks(kpgtbl);
    80000748:	8526                	mv	a0,s1
    8000074a:	00000097          	auipc	ra,0x0
    8000074e:	618080e7          	jalr	1560(ra) # 80000d62 <proc_mapstacks>
}
    80000752:	8526                	mv	a0,s1
    80000754:	60e2                	ld	ra,24(sp)
    80000756:	6442                	ld	s0,16(sp)
    80000758:	64a2                	ld	s1,8(sp)
    8000075a:	6902                	ld	s2,0(sp)
    8000075c:	6105                	addi	sp,sp,32
    8000075e:	8082                	ret

0000000080000760 <kvminit>:
{
    80000760:	1141                	addi	sp,sp,-16
    80000762:	e406                	sd	ra,8(sp)
    80000764:	e022                	sd	s0,0(sp)
    80000766:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80000768:	00000097          	auipc	ra,0x0
    8000076c:	f22080e7          	jalr	-222(ra) # 8000068a <kvmmake>
    80000770:	00008797          	auipc	a5,0x8
    80000774:	2ea7bc23          	sd	a0,760(a5) # 80008a68 <kernel_pagetable>
}
    80000778:	60a2                	ld	ra,8(sp)
    8000077a:	6402                	ld	s0,0(sp)
    8000077c:	0141                	addi	sp,sp,16
    8000077e:	8082                	ret

0000000080000780 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80000780:	715d                	addi	sp,sp,-80
    80000782:	e486                	sd	ra,72(sp)
    80000784:	e0a2                	sd	s0,64(sp)
    80000786:	fc26                	sd	s1,56(sp)
    80000788:	f84a                	sd	s2,48(sp)
    8000078a:	f44e                	sd	s3,40(sp)
    8000078c:	f052                	sd	s4,32(sp)
    8000078e:	ec56                	sd	s5,24(sp)
    80000790:	e85a                	sd	s6,16(sp)
    80000792:	e45e                	sd	s7,8(sp)
    80000794:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80000796:	03459793          	slli	a5,a1,0x34
    8000079a:	e795                	bnez	a5,800007c6 <uvmunmap+0x46>
    8000079c:	8a2a                	mv	s4,a0
    8000079e:	84ae                	mv	s1,a1
    800007a0:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800007a2:	0632                	slli	a2,a2,0xc
    800007a4:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    800007a8:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800007aa:	6b05                	lui	s6,0x1
    800007ac:	0735e863          	bltu	a1,s3,8000081c <uvmunmap+0x9c>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    800007b0:	60a6                	ld	ra,72(sp)
    800007b2:	6406                	ld	s0,64(sp)
    800007b4:	74e2                	ld	s1,56(sp)
    800007b6:	7942                	ld	s2,48(sp)
    800007b8:	79a2                	ld	s3,40(sp)
    800007ba:	7a02                	ld	s4,32(sp)
    800007bc:	6ae2                	ld	s5,24(sp)
    800007be:	6b42                	ld	s6,16(sp)
    800007c0:	6ba2                	ld	s7,8(sp)
    800007c2:	6161                	addi	sp,sp,80
    800007c4:	8082                	ret
    panic("uvmunmap: not aligned");
    800007c6:	00008517          	auipc	a0,0x8
    800007ca:	8ba50513          	addi	a0,a0,-1862 # 80008080 <etext+0x80>
    800007ce:	00005097          	auipc	ra,0x5
    800007d2:	65e080e7          	jalr	1630(ra) # 80005e2c <panic>
      panic("uvmunmap: walk");
    800007d6:	00008517          	auipc	a0,0x8
    800007da:	8c250513          	addi	a0,a0,-1854 # 80008098 <etext+0x98>
    800007de:	00005097          	auipc	ra,0x5
    800007e2:	64e080e7          	jalr	1614(ra) # 80005e2c <panic>
      panic("uvmunmap: not mapped");
    800007e6:	00008517          	auipc	a0,0x8
    800007ea:	8c250513          	addi	a0,a0,-1854 # 800080a8 <etext+0xa8>
    800007ee:	00005097          	auipc	ra,0x5
    800007f2:	63e080e7          	jalr	1598(ra) # 80005e2c <panic>
      panic("uvmunmap: not a leaf");
    800007f6:	00008517          	auipc	a0,0x8
    800007fa:	8ca50513          	addi	a0,a0,-1846 # 800080c0 <etext+0xc0>
    800007fe:	00005097          	auipc	ra,0x5
    80000802:	62e080e7          	jalr	1582(ra) # 80005e2c <panic>
      uint64 pa = PTE2PA(*pte);
    80000806:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    80000808:	0532                	slli	a0,a0,0xc
    8000080a:	00000097          	auipc	ra,0x0
    8000080e:	812080e7          	jalr	-2030(ra) # 8000001c <kfree>
    *pte = 0;
    80000812:	00093023          	sd	zero,0(s2)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000816:	94da                	add	s1,s1,s6
    80000818:	f934fce3          	bgeu	s1,s3,800007b0 <uvmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    8000081c:	4601                	li	a2,0
    8000081e:	85a6                	mv	a1,s1
    80000820:	8552                	mv	a0,s4
    80000822:	00000097          	auipc	ra,0x0
    80000826:	cb2080e7          	jalr	-846(ra) # 800004d4 <walk>
    8000082a:	892a                	mv	s2,a0
    8000082c:	d54d                	beqz	a0,800007d6 <uvmunmap+0x56>
    if((*pte & PTE_V) == 0)
    8000082e:	6108                	ld	a0,0(a0)
    80000830:	00157793          	andi	a5,a0,1
    80000834:	dbcd                	beqz	a5,800007e6 <uvmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V)
    80000836:	3ff57793          	andi	a5,a0,1023
    8000083a:	fb778ee3          	beq	a5,s7,800007f6 <uvmunmap+0x76>
    if(do_free){
    8000083e:	fc0a8ae3          	beqz	s5,80000812 <uvmunmap+0x92>
    80000842:	b7d1                	j	80000806 <uvmunmap+0x86>

0000000080000844 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80000844:	1101                	addi	sp,sp,-32
    80000846:	ec06                	sd	ra,24(sp)
    80000848:	e822                	sd	s0,16(sp)
    8000084a:	e426                	sd	s1,8(sp)
    8000084c:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    8000084e:	00000097          	auipc	ra,0x0
    80000852:	8cc080e7          	jalr	-1844(ra) # 8000011a <kalloc>
    80000856:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000858:	c519                	beqz	a0,80000866 <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    8000085a:	6605                	lui	a2,0x1
    8000085c:	4581                	li	a1,0
    8000085e:	00000097          	auipc	ra,0x0
    80000862:	966080e7          	jalr	-1690(ra) # 800001c4 <memset>
  return pagetable;
}
    80000866:	8526                	mv	a0,s1
    80000868:	60e2                	ld	ra,24(sp)
    8000086a:	6442                	ld	s0,16(sp)
    8000086c:	64a2                	ld	s1,8(sp)
    8000086e:	6105                	addi	sp,sp,32
    80000870:	8082                	ret

0000000080000872 <uvmfirst>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvmfirst(pagetable_t pagetable, uchar *src, uint sz)
{
    80000872:	7179                	addi	sp,sp,-48
    80000874:	f406                	sd	ra,40(sp)
    80000876:	f022                	sd	s0,32(sp)
    80000878:	ec26                	sd	s1,24(sp)
    8000087a:	e84a                	sd	s2,16(sp)
    8000087c:	e44e                	sd	s3,8(sp)
    8000087e:	e052                	sd	s4,0(sp)
    80000880:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    80000882:	6785                	lui	a5,0x1
    80000884:	04f67863          	bgeu	a2,a5,800008d4 <uvmfirst+0x62>
    80000888:	8a2a                	mv	s4,a0
    8000088a:	89ae                	mv	s3,a1
    8000088c:	84b2                	mv	s1,a2
    panic("uvmfirst: more than a page");
  mem = kalloc();
    8000088e:	00000097          	auipc	ra,0x0
    80000892:	88c080e7          	jalr	-1908(ra) # 8000011a <kalloc>
    80000896:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    80000898:	6605                	lui	a2,0x1
    8000089a:	4581                	li	a1,0
    8000089c:	00000097          	auipc	ra,0x0
    800008a0:	928080e7          	jalr	-1752(ra) # 800001c4 <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    800008a4:	4779                	li	a4,30
    800008a6:	86ca                	mv	a3,s2
    800008a8:	6605                	lui	a2,0x1
    800008aa:	4581                	li	a1,0
    800008ac:	8552                	mv	a0,s4
    800008ae:	00000097          	auipc	ra,0x0
    800008b2:	d0e080e7          	jalr	-754(ra) # 800005bc <mappages>
  memmove(mem, src, sz);
    800008b6:	8626                	mv	a2,s1
    800008b8:	85ce                	mv	a1,s3
    800008ba:	854a                	mv	a0,s2
    800008bc:	00000097          	auipc	ra,0x0
    800008c0:	974080e7          	jalr	-1676(ra) # 80000230 <memmove>
}
    800008c4:	70a2                	ld	ra,40(sp)
    800008c6:	7402                	ld	s0,32(sp)
    800008c8:	64e2                	ld	s1,24(sp)
    800008ca:	6942                	ld	s2,16(sp)
    800008cc:	69a2                	ld	s3,8(sp)
    800008ce:	6a02                	ld	s4,0(sp)
    800008d0:	6145                	addi	sp,sp,48
    800008d2:	8082                	ret
    panic("uvmfirst: more than a page");
    800008d4:	00008517          	auipc	a0,0x8
    800008d8:	80450513          	addi	a0,a0,-2044 # 800080d8 <etext+0xd8>
    800008dc:	00005097          	auipc	ra,0x5
    800008e0:	550080e7          	jalr	1360(ra) # 80005e2c <panic>

00000000800008e4 <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    800008e4:	1101                	addi	sp,sp,-32
    800008e6:	ec06                	sd	ra,24(sp)
    800008e8:	e822                	sd	s0,16(sp)
    800008ea:	e426                	sd	s1,8(sp)
    800008ec:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    800008ee:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    800008f0:	00b67d63          	bgeu	a2,a1,8000090a <uvmdealloc+0x26>
    800008f4:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    800008f6:	6605                	lui	a2,0x1
    800008f8:	167d                	addi	a2,a2,-1
    800008fa:	00c487b3          	add	a5,s1,a2
    800008fe:	777d                	lui	a4,0xfffff
    80000900:	8ff9                	and	a5,a5,a4
    80000902:	962e                	add	a2,a2,a1
    80000904:	8e79                	and	a2,a2,a4
    80000906:	00c7e863          	bltu	a5,a2,80000916 <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    8000090a:	8526                	mv	a0,s1
    8000090c:	60e2                	ld	ra,24(sp)
    8000090e:	6442                	ld	s0,16(sp)
    80000910:	64a2                	ld	s1,8(sp)
    80000912:	6105                	addi	sp,sp,32
    80000914:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80000916:	8e1d                	sub	a2,a2,a5
    80000918:	8231                	srli	a2,a2,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    8000091a:	4685                	li	a3,1
    8000091c:	2601                	sext.w	a2,a2
    8000091e:	85be                	mv	a1,a5
    80000920:	00000097          	auipc	ra,0x0
    80000924:	e60080e7          	jalr	-416(ra) # 80000780 <uvmunmap>
    80000928:	b7cd                	j	8000090a <uvmdealloc+0x26>

000000008000092a <uvmalloc>:
  if(newsz < oldsz)
    8000092a:	0ab66563          	bltu	a2,a1,800009d4 <uvmalloc+0xaa>
{
    8000092e:	7139                	addi	sp,sp,-64
    80000930:	fc06                	sd	ra,56(sp)
    80000932:	f822                	sd	s0,48(sp)
    80000934:	f426                	sd	s1,40(sp)
    80000936:	f04a                	sd	s2,32(sp)
    80000938:	ec4e                	sd	s3,24(sp)
    8000093a:	e852                	sd	s4,16(sp)
    8000093c:	e456                	sd	s5,8(sp)
    8000093e:	e05a                	sd	s6,0(sp)
    80000940:	0080                	addi	s0,sp,64
  oldsz = PGROUNDUP(oldsz);
    80000942:	6a85                	lui	s5,0x1
    80000944:	1afd                	addi	s5,s5,-1
    80000946:	95d6                	add	a1,a1,s5
    80000948:	7afd                	lui	s5,0xfffff
    8000094a:	0155fab3          	and	s5,a1,s5
  for(a = oldsz; a < newsz; a += PGSIZE){
    8000094e:	08caf563          	bgeu	s5,a2,800009d8 <uvmalloc+0xae>
    80000952:	89b2                	mv	s3,a2
    80000954:	8b2a                	mv	s6,a0
    80000956:	8956                	mv	s2,s5
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000958:	0126ea13          	ori	s4,a3,18
    mem = kalloc();
    8000095c:	fffff097          	auipc	ra,0xfffff
    80000960:	7be080e7          	jalr	1982(ra) # 8000011a <kalloc>
    80000964:	84aa                	mv	s1,a0
    if(mem == 0){
    80000966:	c51d                	beqz	a0,80000994 <uvmalloc+0x6a>
    memset(mem, 0, PGSIZE);
    80000968:	6605                	lui	a2,0x1
    8000096a:	4581                	li	a1,0
    8000096c:	00000097          	auipc	ra,0x0
    80000970:	858080e7          	jalr	-1960(ra) # 800001c4 <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000974:	8752                	mv	a4,s4
    80000976:	86a6                	mv	a3,s1
    80000978:	6605                	lui	a2,0x1
    8000097a:	85ca                	mv	a1,s2
    8000097c:	855a                	mv	a0,s6
    8000097e:	00000097          	auipc	ra,0x0
    80000982:	c3e080e7          	jalr	-962(ra) # 800005bc <mappages>
    80000986:	e90d                	bnez	a0,800009b8 <uvmalloc+0x8e>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000988:	6785                	lui	a5,0x1
    8000098a:	993e                	add	s2,s2,a5
    8000098c:	fd3968e3          	bltu	s2,s3,8000095c <uvmalloc+0x32>
  return newsz;
    80000990:	854e                	mv	a0,s3
    80000992:	a809                	j	800009a4 <uvmalloc+0x7a>
      uvmdealloc(pagetable, a, oldsz);
    80000994:	8656                	mv	a2,s5
    80000996:	85ca                	mv	a1,s2
    80000998:	855a                	mv	a0,s6
    8000099a:	00000097          	auipc	ra,0x0
    8000099e:	f4a080e7          	jalr	-182(ra) # 800008e4 <uvmdealloc>
      return 0;
    800009a2:	4501                	li	a0,0
}
    800009a4:	70e2                	ld	ra,56(sp)
    800009a6:	7442                	ld	s0,48(sp)
    800009a8:	74a2                	ld	s1,40(sp)
    800009aa:	7902                	ld	s2,32(sp)
    800009ac:	69e2                	ld	s3,24(sp)
    800009ae:	6a42                	ld	s4,16(sp)
    800009b0:	6aa2                	ld	s5,8(sp)
    800009b2:	6b02                	ld	s6,0(sp)
    800009b4:	6121                	addi	sp,sp,64
    800009b6:	8082                	ret
      kfree(mem);
    800009b8:	8526                	mv	a0,s1
    800009ba:	fffff097          	auipc	ra,0xfffff
    800009be:	662080e7          	jalr	1634(ra) # 8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    800009c2:	8656                	mv	a2,s5
    800009c4:	85ca                	mv	a1,s2
    800009c6:	855a                	mv	a0,s6
    800009c8:	00000097          	auipc	ra,0x0
    800009cc:	f1c080e7          	jalr	-228(ra) # 800008e4 <uvmdealloc>
      return 0;
    800009d0:	4501                	li	a0,0
    800009d2:	bfc9                	j	800009a4 <uvmalloc+0x7a>
    return oldsz;
    800009d4:	852e                	mv	a0,a1
}
    800009d6:	8082                	ret
  return newsz;
    800009d8:	8532                	mv	a0,a2
    800009da:	b7e9                	j	800009a4 <uvmalloc+0x7a>

00000000800009dc <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    800009dc:	7179                	addi	sp,sp,-48
    800009de:	f406                	sd	ra,40(sp)
    800009e0:	f022                	sd	s0,32(sp)
    800009e2:	ec26                	sd	s1,24(sp)
    800009e4:	e84a                	sd	s2,16(sp)
    800009e6:	e44e                	sd	s3,8(sp)
    800009e8:	e052                	sd	s4,0(sp)
    800009ea:	1800                	addi	s0,sp,48
    800009ec:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    800009ee:	84aa                	mv	s1,a0
    800009f0:	6905                	lui	s2,0x1
    800009f2:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800009f4:	4985                	li	s3,1
    800009f6:	a821                	j	80000a0e <freewalk+0x32>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    800009f8:	8129                	srli	a0,a0,0xa
      freewalk((pagetable_t)child);
    800009fa:	0532                	slli	a0,a0,0xc
    800009fc:	00000097          	auipc	ra,0x0
    80000a00:	fe0080e7          	jalr	-32(ra) # 800009dc <freewalk>
      pagetable[i] = 0;
    80000a04:	0004b023          	sd	zero,0(s1)
    80000a08:	04a1                	addi	s1,s1,8
  for(int i = 0; i < 512; i++){
    80000a0a:	03248163          	beq	s1,s2,80000a2c <freewalk+0x50>
    pte_t pte = pagetable[i];
    80000a0e:	6088                	ld	a0,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000a10:	00f57793          	andi	a5,a0,15
    80000a14:	ff3782e3          	beq	a5,s3,800009f8 <freewalk+0x1c>
    } else if(pte & PTE_V){
    80000a18:	8905                	andi	a0,a0,1
    80000a1a:	d57d                	beqz	a0,80000a08 <freewalk+0x2c>
      panic("freewalk: leaf");
    80000a1c:	00007517          	auipc	a0,0x7
    80000a20:	6dc50513          	addi	a0,a0,1756 # 800080f8 <etext+0xf8>
    80000a24:	00005097          	auipc	ra,0x5
    80000a28:	408080e7          	jalr	1032(ra) # 80005e2c <panic>
    }
  }
  kfree((void*)pagetable);
    80000a2c:	8552                	mv	a0,s4
    80000a2e:	fffff097          	auipc	ra,0xfffff
    80000a32:	5ee080e7          	jalr	1518(ra) # 8000001c <kfree>
}
    80000a36:	70a2                	ld	ra,40(sp)
    80000a38:	7402                	ld	s0,32(sp)
    80000a3a:	64e2                	ld	s1,24(sp)
    80000a3c:	6942                	ld	s2,16(sp)
    80000a3e:	69a2                	ld	s3,8(sp)
    80000a40:	6a02                	ld	s4,0(sp)
    80000a42:	6145                	addi	sp,sp,48
    80000a44:	8082                	ret

0000000080000a46 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80000a46:	1101                	addi	sp,sp,-32
    80000a48:	ec06                	sd	ra,24(sp)
    80000a4a:	e822                	sd	s0,16(sp)
    80000a4c:	e426                	sd	s1,8(sp)
    80000a4e:	1000                	addi	s0,sp,32
    80000a50:	84aa                	mv	s1,a0
  if(sz > 0)
    80000a52:	e999                	bnez	a1,80000a68 <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80000a54:	8526                	mv	a0,s1
    80000a56:	00000097          	auipc	ra,0x0
    80000a5a:	f86080e7          	jalr	-122(ra) # 800009dc <freewalk>
}
    80000a5e:	60e2                	ld	ra,24(sp)
    80000a60:	6442                	ld	s0,16(sp)
    80000a62:	64a2                	ld	s1,8(sp)
    80000a64:	6105                	addi	sp,sp,32
    80000a66:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80000a68:	6605                	lui	a2,0x1
    80000a6a:	167d                	addi	a2,a2,-1
    80000a6c:	962e                	add	a2,a2,a1
    80000a6e:	4685                	li	a3,1
    80000a70:	8231                	srli	a2,a2,0xc
    80000a72:	4581                	li	a1,0
    80000a74:	00000097          	auipc	ra,0x0
    80000a78:	d0c080e7          	jalr	-756(ra) # 80000780 <uvmunmap>
    80000a7c:	bfe1                	j	80000a54 <uvmfree+0xe>

0000000080000a7e <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80000a7e:	c679                	beqz	a2,80000b4c <uvmcopy+0xce>
{
    80000a80:	715d                	addi	sp,sp,-80
    80000a82:	e486                	sd	ra,72(sp)
    80000a84:	e0a2                	sd	s0,64(sp)
    80000a86:	fc26                	sd	s1,56(sp)
    80000a88:	f84a                	sd	s2,48(sp)
    80000a8a:	f44e                	sd	s3,40(sp)
    80000a8c:	f052                	sd	s4,32(sp)
    80000a8e:	ec56                	sd	s5,24(sp)
    80000a90:	e85a                	sd	s6,16(sp)
    80000a92:	e45e                	sd	s7,8(sp)
    80000a94:	0880                	addi	s0,sp,80
    80000a96:	8ab2                	mv	s5,a2
    80000a98:	8b2e                	mv	s6,a1
    80000a9a:	8baa                	mv	s7,a0
  for(i = 0; i < sz; i += PGSIZE){
    80000a9c:	4901                	li	s2,0
    if((pte = walk(old, i, 0)) == 0)
    80000a9e:	4601                	li	a2,0
    80000aa0:	85ca                	mv	a1,s2
    80000aa2:	855e                	mv	a0,s7
    80000aa4:	00000097          	auipc	ra,0x0
    80000aa8:	a30080e7          	jalr	-1488(ra) # 800004d4 <walk>
    80000aac:	c531                	beqz	a0,80000af8 <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    80000aae:	6118                	ld	a4,0(a0)
    80000ab0:	00177793          	andi	a5,a4,1
    80000ab4:	cbb1                	beqz	a5,80000b08 <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    80000ab6:	00a75593          	srli	a1,a4,0xa
    80000aba:	00c59993          	slli	s3,a1,0xc
    flags = PTE_FLAGS(*pte);
    80000abe:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    80000ac2:	fffff097          	auipc	ra,0xfffff
    80000ac6:	658080e7          	jalr	1624(ra) # 8000011a <kalloc>
    80000aca:	8a2a                	mv	s4,a0
    80000acc:	c939                	beqz	a0,80000b22 <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    80000ace:	6605                	lui	a2,0x1
    80000ad0:	85ce                	mv	a1,s3
    80000ad2:	fffff097          	auipc	ra,0xfffff
    80000ad6:	75e080e7          	jalr	1886(ra) # 80000230 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80000ada:	8726                	mv	a4,s1
    80000adc:	86d2                	mv	a3,s4
    80000ade:	6605                	lui	a2,0x1
    80000ae0:	85ca                	mv	a1,s2
    80000ae2:	855a                	mv	a0,s6
    80000ae4:	00000097          	auipc	ra,0x0
    80000ae8:	ad8080e7          	jalr	-1320(ra) # 800005bc <mappages>
    80000aec:	e515                	bnez	a0,80000b18 <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    80000aee:	6785                	lui	a5,0x1
    80000af0:	993e                	add	s2,s2,a5
    80000af2:	fb5966e3          	bltu	s2,s5,80000a9e <uvmcopy+0x20>
    80000af6:	a081                	j	80000b36 <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    80000af8:	00007517          	auipc	a0,0x7
    80000afc:	61050513          	addi	a0,a0,1552 # 80008108 <etext+0x108>
    80000b00:	00005097          	auipc	ra,0x5
    80000b04:	32c080e7          	jalr	812(ra) # 80005e2c <panic>
      panic("uvmcopy: page not present");
    80000b08:	00007517          	auipc	a0,0x7
    80000b0c:	62050513          	addi	a0,a0,1568 # 80008128 <etext+0x128>
    80000b10:	00005097          	auipc	ra,0x5
    80000b14:	31c080e7          	jalr	796(ra) # 80005e2c <panic>
      kfree(mem);
    80000b18:	8552                	mv	a0,s4
    80000b1a:	fffff097          	auipc	ra,0xfffff
    80000b1e:	502080e7          	jalr	1282(ra) # 8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80000b22:	4685                	li	a3,1
    80000b24:	00c95613          	srli	a2,s2,0xc
    80000b28:	4581                	li	a1,0
    80000b2a:	855a                	mv	a0,s6
    80000b2c:	00000097          	auipc	ra,0x0
    80000b30:	c54080e7          	jalr	-940(ra) # 80000780 <uvmunmap>
  return -1;
    80000b34:	557d                	li	a0,-1
}
    80000b36:	60a6                	ld	ra,72(sp)
    80000b38:	6406                	ld	s0,64(sp)
    80000b3a:	74e2                	ld	s1,56(sp)
    80000b3c:	7942                	ld	s2,48(sp)
    80000b3e:	79a2                	ld	s3,40(sp)
    80000b40:	7a02                	ld	s4,32(sp)
    80000b42:	6ae2                	ld	s5,24(sp)
    80000b44:	6b42                	ld	s6,16(sp)
    80000b46:	6ba2                	ld	s7,8(sp)
    80000b48:	6161                	addi	sp,sp,80
    80000b4a:	8082                	ret
  return 0;
    80000b4c:	4501                	li	a0,0
}
    80000b4e:	8082                	ret

0000000080000b50 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80000b50:	1141                	addi	sp,sp,-16
    80000b52:	e406                	sd	ra,8(sp)
    80000b54:	e022                	sd	s0,0(sp)
    80000b56:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80000b58:	4601                	li	a2,0
    80000b5a:	00000097          	auipc	ra,0x0
    80000b5e:	97a080e7          	jalr	-1670(ra) # 800004d4 <walk>
  if(pte == 0)
    80000b62:	c901                	beqz	a0,80000b72 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000b64:	611c                	ld	a5,0(a0)
    80000b66:	9bbd                	andi	a5,a5,-17
    80000b68:	e11c                	sd	a5,0(a0)
}
    80000b6a:	60a2                	ld	ra,8(sp)
    80000b6c:	6402                	ld	s0,0(sp)
    80000b6e:	0141                	addi	sp,sp,16
    80000b70:	8082                	ret
    panic("uvmclear");
    80000b72:	00007517          	auipc	a0,0x7
    80000b76:	5d650513          	addi	a0,a0,1494 # 80008148 <etext+0x148>
    80000b7a:	00005097          	auipc	ra,0x5
    80000b7e:	2b2080e7          	jalr	690(ra) # 80005e2c <panic>

0000000080000b82 <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000b82:	c6bd                	beqz	a3,80000bf0 <copyout+0x6e>
{
    80000b84:	715d                	addi	sp,sp,-80
    80000b86:	e486                	sd	ra,72(sp)
    80000b88:	e0a2                	sd	s0,64(sp)
    80000b8a:	fc26                	sd	s1,56(sp)
    80000b8c:	f84a                	sd	s2,48(sp)
    80000b8e:	f44e                	sd	s3,40(sp)
    80000b90:	f052                	sd	s4,32(sp)
    80000b92:	ec56                	sd	s5,24(sp)
    80000b94:	e85a                	sd	s6,16(sp)
    80000b96:	e45e                	sd	s7,8(sp)
    80000b98:	e062                	sd	s8,0(sp)
    80000b9a:	0880                	addi	s0,sp,80
    80000b9c:	8baa                	mv	s7,a0
    80000b9e:	8a2e                	mv	s4,a1
    80000ba0:	8ab2                	mv	s5,a2
    80000ba2:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80000ba4:	7c7d                	lui	s8,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    80000ba6:	6b05                	lui	s6,0x1
    80000ba8:	a015                	j	80000bcc <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000baa:	9552                	add	a0,a0,s4
    80000bac:	0004861b          	sext.w	a2,s1
    80000bb0:	85d6                	mv	a1,s5
    80000bb2:	41250533          	sub	a0,a0,s2
    80000bb6:	fffff097          	auipc	ra,0xfffff
    80000bba:	67a080e7          	jalr	1658(ra) # 80000230 <memmove>

    len -= n;
    80000bbe:	409989b3          	sub	s3,s3,s1
    src += n;
    80000bc2:	9aa6                	add	s5,s5,s1
    dstva = va0 + PGSIZE;
    80000bc4:	01690a33          	add	s4,s2,s6
  while(len > 0){
    80000bc8:	02098263          	beqz	s3,80000bec <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    80000bcc:	018a7933          	and	s2,s4,s8
    pa0 = walkaddr(pagetable, va0);
    80000bd0:	85ca                	mv	a1,s2
    80000bd2:	855e                	mv	a0,s7
    80000bd4:	00000097          	auipc	ra,0x0
    80000bd8:	9a6080e7          	jalr	-1626(ra) # 8000057a <walkaddr>
    if(pa0 == 0)
    80000bdc:	cd01                	beqz	a0,80000bf4 <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    80000bde:	414904b3          	sub	s1,s2,s4
    80000be2:	94da                	add	s1,s1,s6
    if(n > len)
    80000be4:	fc99f3e3          	bgeu	s3,s1,80000baa <copyout+0x28>
    80000be8:	84ce                	mv	s1,s3
    80000bea:	b7c1                	j	80000baa <copyout+0x28>
  }
  return 0;
    80000bec:	4501                	li	a0,0
    80000bee:	a021                	j	80000bf6 <copyout+0x74>
    80000bf0:	4501                	li	a0,0
}
    80000bf2:	8082                	ret
      return -1;
    80000bf4:	557d                	li	a0,-1
}
    80000bf6:	60a6                	ld	ra,72(sp)
    80000bf8:	6406                	ld	s0,64(sp)
    80000bfa:	74e2                	ld	s1,56(sp)
    80000bfc:	7942                	ld	s2,48(sp)
    80000bfe:	79a2                	ld	s3,40(sp)
    80000c00:	7a02                	ld	s4,32(sp)
    80000c02:	6ae2                	ld	s5,24(sp)
    80000c04:	6b42                	ld	s6,16(sp)
    80000c06:	6ba2                	ld	s7,8(sp)
    80000c08:	6c02                	ld	s8,0(sp)
    80000c0a:	6161                	addi	sp,sp,80
    80000c0c:	8082                	ret

0000000080000c0e <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000c0e:	caa5                	beqz	a3,80000c7e <copyin+0x70>
{
    80000c10:	715d                	addi	sp,sp,-80
    80000c12:	e486                	sd	ra,72(sp)
    80000c14:	e0a2                	sd	s0,64(sp)
    80000c16:	fc26                	sd	s1,56(sp)
    80000c18:	f84a                	sd	s2,48(sp)
    80000c1a:	f44e                	sd	s3,40(sp)
    80000c1c:	f052                	sd	s4,32(sp)
    80000c1e:	ec56                	sd	s5,24(sp)
    80000c20:	e85a                	sd	s6,16(sp)
    80000c22:	e45e                	sd	s7,8(sp)
    80000c24:	e062                	sd	s8,0(sp)
    80000c26:	0880                	addi	s0,sp,80
    80000c28:	8baa                	mv	s7,a0
    80000c2a:	8aae                	mv	s5,a1
    80000c2c:	8a32                	mv	s4,a2
    80000c2e:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000c30:	7c7d                	lui	s8,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000c32:	6b05                	lui	s6,0x1
    80000c34:	a01d                	j	80000c5a <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000c36:	014505b3          	add	a1,a0,s4
    80000c3a:	0004861b          	sext.w	a2,s1
    80000c3e:	412585b3          	sub	a1,a1,s2
    80000c42:	8556                	mv	a0,s5
    80000c44:	fffff097          	auipc	ra,0xfffff
    80000c48:	5ec080e7          	jalr	1516(ra) # 80000230 <memmove>

    len -= n;
    80000c4c:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000c50:	9aa6                	add	s5,s5,s1
    srcva = va0 + PGSIZE;
    80000c52:	01690a33          	add	s4,s2,s6
  while(len > 0){
    80000c56:	02098263          	beqz	s3,80000c7a <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    80000c5a:	018a7933          	and	s2,s4,s8
    pa0 = walkaddr(pagetable, va0);
    80000c5e:	85ca                	mv	a1,s2
    80000c60:	855e                	mv	a0,s7
    80000c62:	00000097          	auipc	ra,0x0
    80000c66:	918080e7          	jalr	-1768(ra) # 8000057a <walkaddr>
    if(pa0 == 0)
    80000c6a:	cd01                	beqz	a0,80000c82 <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80000c6c:	414904b3          	sub	s1,s2,s4
    80000c70:	94da                	add	s1,s1,s6
    if(n > len)
    80000c72:	fc99f2e3          	bgeu	s3,s1,80000c36 <copyin+0x28>
    80000c76:	84ce                	mv	s1,s3
    80000c78:	bf7d                	j	80000c36 <copyin+0x28>
  }
  return 0;
    80000c7a:	4501                	li	a0,0
    80000c7c:	a021                	j	80000c84 <copyin+0x76>
    80000c7e:	4501                	li	a0,0
}
    80000c80:	8082                	ret
      return -1;
    80000c82:	557d                	li	a0,-1
}
    80000c84:	60a6                	ld	ra,72(sp)
    80000c86:	6406                	ld	s0,64(sp)
    80000c88:	74e2                	ld	s1,56(sp)
    80000c8a:	7942                	ld	s2,48(sp)
    80000c8c:	79a2                	ld	s3,40(sp)
    80000c8e:	7a02                	ld	s4,32(sp)
    80000c90:	6ae2                	ld	s5,24(sp)
    80000c92:	6b42                	ld	s6,16(sp)
    80000c94:	6ba2                	ld	s7,8(sp)
    80000c96:	6c02                	ld	s8,0(sp)
    80000c98:	6161                	addi	sp,sp,80
    80000c9a:	8082                	ret

0000000080000c9c <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80000c9c:	cecd                	beqz	a3,80000d56 <copyinstr+0xba>
{
    80000c9e:	715d                	addi	sp,sp,-80
    80000ca0:	e486                	sd	ra,72(sp)
    80000ca2:	e0a2                	sd	s0,64(sp)
    80000ca4:	fc26                	sd	s1,56(sp)
    80000ca6:	f84a                	sd	s2,48(sp)
    80000ca8:	f44e                	sd	s3,40(sp)
    80000caa:	f052                	sd	s4,32(sp)
    80000cac:	ec56                	sd	s5,24(sp)
    80000cae:	e85a                	sd	s6,16(sp)
    80000cb0:	e45e                	sd	s7,8(sp)
    80000cb2:	e062                	sd	s8,0(sp)
    80000cb4:	0880                	addi	s0,sp,80
    80000cb6:	8aaa                	mv	s5,a0
    80000cb8:	84ae                	mv	s1,a1
    80000cba:	8c32                	mv	s8,a2
    80000cbc:	8bb6                	mv	s7,a3
    va0 = PGROUNDDOWN(srcva);
    80000cbe:	7a7d                	lui	s4,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000cc0:	6985                	lui	s3,0x1
    80000cc2:	4b05                	li	s6,1
    80000cc4:	a801                	j	80000cd4 <copyinstr+0x38>
    if(n > max)
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
    80000cc6:	87a6                	mv	a5,s1
    80000cc8:	a085                	j	80000d28 <copyinstr+0x8c>
        *dst = *p;
      }
      --n;
      --max;
      p++;
      dst++;
    80000cca:	84b2                	mv	s1,a2
    }

    srcva = va0 + PGSIZE;
    80000ccc:	01390c33          	add	s8,s2,s3
  while(got_null == 0 && max > 0){
    80000cd0:	060b8f63          	beqz	s7,80000d4e <copyinstr+0xb2>
    va0 = PGROUNDDOWN(srcva);
    80000cd4:	014c7933          	and	s2,s8,s4
    pa0 = walkaddr(pagetable, va0);
    80000cd8:	85ca                	mv	a1,s2
    80000cda:	8556                	mv	a0,s5
    80000cdc:	00000097          	auipc	ra,0x0
    80000ce0:	89e080e7          	jalr	-1890(ra) # 8000057a <walkaddr>
    if(pa0 == 0)
    80000ce4:	c53d                	beqz	a0,80000d52 <copyinstr+0xb6>
    n = PGSIZE - (srcva - va0);
    80000ce6:	41890633          	sub	a2,s2,s8
    80000cea:	964e                	add	a2,a2,s3
    if(n > max)
    80000cec:	00cbf363          	bgeu	s7,a2,80000cf2 <copyinstr+0x56>
    80000cf0:	865e                	mv	a2,s7
    char *p = (char *) (pa0 + (srcva - va0));
    80000cf2:	9562                	add	a0,a0,s8
    80000cf4:	41250533          	sub	a0,a0,s2
    while(n > 0){
    80000cf8:	da71                	beqz	a2,80000ccc <copyinstr+0x30>
      if(*p == '\0'){
    80000cfa:	00054703          	lbu	a4,0(a0)
    80000cfe:	d761                	beqz	a4,80000cc6 <copyinstr+0x2a>
    80000d00:	9626                	add	a2,a2,s1
    80000d02:	87a6                	mv	a5,s1
    80000d04:	1bfd                	addi	s7,s7,-1
    80000d06:	009b86b3          	add	a3,s7,s1
    80000d0a:	409b04b3          	sub	s1,s6,s1
    80000d0e:	94aa                	add	s1,s1,a0
        *dst = *p;
    80000d10:	00e78023          	sb	a4,0(a5) # 1000 <_entry-0x7ffff000>
      --max;
    80000d14:	40f68bb3          	sub	s7,a3,a5
      p++;
    80000d18:	00f48733          	add	a4,s1,a5
      dst++;
    80000d1c:	0785                	addi	a5,a5,1
    while(n > 0){
    80000d1e:	faf606e3          	beq	a2,a5,80000cca <copyinstr+0x2e>
      if(*p == '\0'){
    80000d22:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <end+0xffffffff7ffdcf00>
    80000d26:	f76d                	bnez	a4,80000d10 <copyinstr+0x74>
        *dst = '\0';
    80000d28:	00078023          	sb	zero,0(a5)
    80000d2c:	4785                	li	a5,1
  }
  if(got_null){
    80000d2e:	0017b793          	seqz	a5,a5
    80000d32:	40f00533          	neg	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000d36:	60a6                	ld	ra,72(sp)
    80000d38:	6406                	ld	s0,64(sp)
    80000d3a:	74e2                	ld	s1,56(sp)
    80000d3c:	7942                	ld	s2,48(sp)
    80000d3e:	79a2                	ld	s3,40(sp)
    80000d40:	7a02                	ld	s4,32(sp)
    80000d42:	6ae2                	ld	s5,24(sp)
    80000d44:	6b42                	ld	s6,16(sp)
    80000d46:	6ba2                	ld	s7,8(sp)
    80000d48:	6c02                	ld	s8,0(sp)
    80000d4a:	6161                	addi	sp,sp,80
    80000d4c:	8082                	ret
    80000d4e:	4781                	li	a5,0
    80000d50:	bff9                	j	80000d2e <copyinstr+0x92>
      return -1;
    80000d52:	557d                	li	a0,-1
    80000d54:	b7cd                	j	80000d36 <copyinstr+0x9a>
  int got_null = 0;
    80000d56:	4781                	li	a5,0
  if(got_null){
    80000d58:	0017b793          	seqz	a5,a5
    80000d5c:	40f00533          	neg	a0,a5
}
    80000d60:	8082                	ret

0000000080000d62 <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    80000d62:	7139                	addi	sp,sp,-64
    80000d64:	fc06                	sd	ra,56(sp)
    80000d66:	f822                	sd	s0,48(sp)
    80000d68:	f426                	sd	s1,40(sp)
    80000d6a:	f04a                	sd	s2,32(sp)
    80000d6c:	ec4e                	sd	s3,24(sp)
    80000d6e:	e852                	sd	s4,16(sp)
    80000d70:	e456                	sd	s5,8(sp)
    80000d72:	e05a                	sd	s6,0(sp)
    80000d74:	0080                	addi	s0,sp,64
    80000d76:	8b2a                	mv	s6,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d78:	00008497          	auipc	s1,0x8
    80000d7c:	16848493          	addi	s1,s1,360 # 80008ee0 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000d80:	8aa6                	mv	s5,s1
    80000d82:	00007a17          	auipc	s4,0x7
    80000d86:	27ea0a13          	addi	s4,s4,638 # 80008000 <etext>
    80000d8a:	01000937          	lui	s2,0x1000
    80000d8e:	197d                	addi	s2,s2,-1
    80000d90:	093a                	slli	s2,s2,0xe
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d92:	0000e997          	auipc	s3,0xe
    80000d96:	d4e98993          	addi	s3,s3,-690 # 8000eae0 <tickslock>
    char *pa = kalloc();
    80000d9a:	fffff097          	auipc	ra,0xfffff
    80000d9e:	380080e7          	jalr	896(ra) # 8000011a <kalloc>
    80000da2:	862a                	mv	a2,a0
    if(pa == 0)
    80000da4:	c129                	beqz	a0,80000de6 <proc_mapstacks+0x84>
    uint64 va = KSTACK((int) (p - proc));
    80000da6:	415485b3          	sub	a1,s1,s5
    80000daa:	8591                	srai	a1,a1,0x4
    80000dac:	000a3783          	ld	a5,0(s4)
    80000db0:	02f585b3          	mul	a1,a1,a5
    80000db4:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000db8:	4719                	li	a4,6
    80000dba:	6685                	lui	a3,0x1
    80000dbc:	40b905b3          	sub	a1,s2,a1
    80000dc0:	855a                	mv	a0,s6
    80000dc2:	00000097          	auipc	ra,0x0
    80000dc6:	898080e7          	jalr	-1896(ra) # 8000065a <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000dca:	17048493          	addi	s1,s1,368
    80000dce:	fd3496e3          	bne	s1,s3,80000d9a <proc_mapstacks+0x38>
  }
}
    80000dd2:	70e2                	ld	ra,56(sp)
    80000dd4:	7442                	ld	s0,48(sp)
    80000dd6:	74a2                	ld	s1,40(sp)
    80000dd8:	7902                	ld	s2,32(sp)
    80000dda:	69e2                	ld	s3,24(sp)
    80000ddc:	6a42                	ld	s4,16(sp)
    80000dde:	6aa2                	ld	s5,8(sp)
    80000de0:	6b02                	ld	s6,0(sp)
    80000de2:	6121                	addi	sp,sp,64
    80000de4:	8082                	ret
      panic("kalloc");
    80000de6:	00007517          	auipc	a0,0x7
    80000dea:	3a250513          	addi	a0,a0,930 # 80008188 <states.1754+0x30>
    80000dee:	00005097          	auipc	ra,0x5
    80000df2:	03e080e7          	jalr	62(ra) # 80005e2c <panic>

0000000080000df6 <procinit>:

// initialize the proc table.
void
procinit(void)
{
    80000df6:	7139                	addi	sp,sp,-64
    80000df8:	fc06                	sd	ra,56(sp)
    80000dfa:	f822                	sd	s0,48(sp)
    80000dfc:	f426                	sd	s1,40(sp)
    80000dfe:	f04a                	sd	s2,32(sp)
    80000e00:	ec4e                	sd	s3,24(sp)
    80000e02:	e852                	sd	s4,16(sp)
    80000e04:	e456                	sd	s5,8(sp)
    80000e06:	e05a                	sd	s6,0(sp)
    80000e08:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80000e0a:	00007597          	auipc	a1,0x7
    80000e0e:	38658593          	addi	a1,a1,902 # 80008190 <states.1754+0x38>
    80000e12:	00008517          	auipc	a0,0x8
    80000e16:	c9e50513          	addi	a0,a0,-866 # 80008ab0 <pid_lock>
    80000e1a:	00005097          	auipc	ra,0x5
    80000e1e:	4ea080e7          	jalr	1258(ra) # 80006304 <initlock>
  initlock(&wait_lock, "wait_lock");
    80000e22:	00007597          	auipc	a1,0x7
    80000e26:	37658593          	addi	a1,a1,886 # 80008198 <states.1754+0x40>
    80000e2a:	00008517          	auipc	a0,0x8
    80000e2e:	c9e50513          	addi	a0,a0,-866 # 80008ac8 <wait_lock>
    80000e32:	00005097          	auipc	ra,0x5
    80000e36:	4d2080e7          	jalr	1234(ra) # 80006304 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e3a:	00008497          	auipc	s1,0x8
    80000e3e:	0a648493          	addi	s1,s1,166 # 80008ee0 <proc>
      initlock(&p->lock, "proc");
    80000e42:	00007b17          	auipc	s6,0x7
    80000e46:	366b0b13          	addi	s6,s6,870 # 800081a8 <states.1754+0x50>
      p->state = UNUSED;
      p->kstack = KSTACK((int) (p - proc));
    80000e4a:	8aa6                	mv	s5,s1
    80000e4c:	00007a17          	auipc	s4,0x7
    80000e50:	1b4a0a13          	addi	s4,s4,436 # 80008000 <etext>
    80000e54:	01000937          	lui	s2,0x1000
    80000e58:	197d                	addi	s2,s2,-1
    80000e5a:	093a                	slli	s2,s2,0xe
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e5c:	0000e997          	auipc	s3,0xe
    80000e60:	c8498993          	addi	s3,s3,-892 # 8000eae0 <tickslock>
      initlock(&p->lock, "proc");
    80000e64:	85da                	mv	a1,s6
    80000e66:	8526                	mv	a0,s1
    80000e68:	00005097          	auipc	ra,0x5
    80000e6c:	49c080e7          	jalr	1180(ra) # 80006304 <initlock>
      p->state = UNUSED;
    80000e70:	0004ac23          	sw	zero,24(s1)
      p->kstack = KSTACK((int) (p - proc));
    80000e74:	415487b3          	sub	a5,s1,s5
    80000e78:	8791                	srai	a5,a5,0x4
    80000e7a:	000a3703          	ld	a4,0(s4)
    80000e7e:	02e787b3          	mul	a5,a5,a4
    80000e82:	00d7979b          	slliw	a5,a5,0xd
    80000e86:	40f907b3          	sub	a5,s2,a5
    80000e8a:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e8c:	17048493          	addi	s1,s1,368
    80000e90:	fd349ae3          	bne	s1,s3,80000e64 <procinit+0x6e>
  }
}
    80000e94:	70e2                	ld	ra,56(sp)
    80000e96:	7442                	ld	s0,48(sp)
    80000e98:	74a2                	ld	s1,40(sp)
    80000e9a:	7902                	ld	s2,32(sp)
    80000e9c:	69e2                	ld	s3,24(sp)
    80000e9e:	6a42                	ld	s4,16(sp)
    80000ea0:	6aa2                	ld	s5,8(sp)
    80000ea2:	6b02                	ld	s6,0(sp)
    80000ea4:	6121                	addi	sp,sp,64
    80000ea6:	8082                	ret

0000000080000ea8 <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80000ea8:	1141                	addi	sp,sp,-16
    80000eaa:	e422                	sd	s0,8(sp)
    80000eac:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80000eae:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80000eb0:	2501                	sext.w	a0,a0
    80000eb2:	6422                	ld	s0,8(sp)
    80000eb4:	0141                	addi	sp,sp,16
    80000eb6:	8082                	ret

0000000080000eb8 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    80000eb8:	1141                	addi	sp,sp,-16
    80000eba:	e422                	sd	s0,8(sp)
    80000ebc:	0800                	addi	s0,sp,16
    80000ebe:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80000ec0:	2781                	sext.w	a5,a5
    80000ec2:	079e                	slli	a5,a5,0x7
  return c;
}
    80000ec4:	00008517          	auipc	a0,0x8
    80000ec8:	c1c50513          	addi	a0,a0,-996 # 80008ae0 <cpus>
    80000ecc:	953e                	add	a0,a0,a5
    80000ece:	6422                	ld	s0,8(sp)
    80000ed0:	0141                	addi	sp,sp,16
    80000ed2:	8082                	ret

0000000080000ed4 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    80000ed4:	1101                	addi	sp,sp,-32
    80000ed6:	ec06                	sd	ra,24(sp)
    80000ed8:	e822                	sd	s0,16(sp)
    80000eda:	e426                	sd	s1,8(sp)
    80000edc:	1000                	addi	s0,sp,32
  push_off();
    80000ede:	00005097          	auipc	ra,0x5
    80000ee2:	46a080e7          	jalr	1130(ra) # 80006348 <push_off>
    80000ee6:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80000ee8:	2781                	sext.w	a5,a5
    80000eea:	079e                	slli	a5,a5,0x7
    80000eec:	00008717          	auipc	a4,0x8
    80000ef0:	bc470713          	addi	a4,a4,-1084 # 80008ab0 <pid_lock>
    80000ef4:	97ba                	add	a5,a5,a4
    80000ef6:	7b84                	ld	s1,48(a5)
  pop_off();
    80000ef8:	00005097          	auipc	ra,0x5
    80000efc:	4f0080e7          	jalr	1264(ra) # 800063e8 <pop_off>
  return p;
}
    80000f00:	8526                	mv	a0,s1
    80000f02:	60e2                	ld	ra,24(sp)
    80000f04:	6442                	ld	s0,16(sp)
    80000f06:	64a2                	ld	s1,8(sp)
    80000f08:	6105                	addi	sp,sp,32
    80000f0a:	8082                	ret

0000000080000f0c <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80000f0c:	1141                	addi	sp,sp,-16
    80000f0e:	e406                	sd	ra,8(sp)
    80000f10:	e022                	sd	s0,0(sp)
    80000f12:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80000f14:	00000097          	auipc	ra,0x0
    80000f18:	fc0080e7          	jalr	-64(ra) # 80000ed4 <myproc>
    80000f1c:	00005097          	auipc	ra,0x5
    80000f20:	52c080e7          	jalr	1324(ra) # 80006448 <release>

  if (first) {
    80000f24:	00008797          	auipc	a5,0x8
    80000f28:	aec78793          	addi	a5,a5,-1300 # 80008a10 <first.1710>
    80000f2c:	439c                	lw	a5,0(a5)
    80000f2e:	eb89                	bnez	a5,80000f40 <forkret+0x34>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    80000f30:	00001097          	auipc	ra,0x1
    80000f34:	cd4080e7          	jalr	-812(ra) # 80001c04 <usertrapret>
}
    80000f38:	60a2                	ld	ra,8(sp)
    80000f3a:	6402                	ld	s0,0(sp)
    80000f3c:	0141                	addi	sp,sp,16
    80000f3e:	8082                	ret
    first = 0;
    80000f40:	00008797          	auipc	a5,0x8
    80000f44:	ac07a823          	sw	zero,-1328(a5) # 80008a10 <first.1710>
    fsinit(ROOTDEV);
    80000f48:	4505                	li	a0,1
    80000f4a:	00002097          	auipc	ra,0x2
    80000f4e:	afa080e7          	jalr	-1286(ra) # 80002a44 <fsinit>
    80000f52:	bff9                	j	80000f30 <forkret+0x24>

0000000080000f54 <allocpid>:
{
    80000f54:	1101                	addi	sp,sp,-32
    80000f56:	ec06                	sd	ra,24(sp)
    80000f58:	e822                	sd	s0,16(sp)
    80000f5a:	e426                	sd	s1,8(sp)
    80000f5c:	e04a                	sd	s2,0(sp)
    80000f5e:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80000f60:	00008917          	auipc	s2,0x8
    80000f64:	b5090913          	addi	s2,s2,-1200 # 80008ab0 <pid_lock>
    80000f68:	854a                	mv	a0,s2
    80000f6a:	00005097          	auipc	ra,0x5
    80000f6e:	42a080e7          	jalr	1066(ra) # 80006394 <acquire>
  pid = nextpid;
    80000f72:	00008797          	auipc	a5,0x8
    80000f76:	aa278793          	addi	a5,a5,-1374 # 80008a14 <nextpid>
    80000f7a:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80000f7c:	0014871b          	addiw	a4,s1,1
    80000f80:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80000f82:	854a                	mv	a0,s2
    80000f84:	00005097          	auipc	ra,0x5
    80000f88:	4c4080e7          	jalr	1220(ra) # 80006448 <release>
}
    80000f8c:	8526                	mv	a0,s1
    80000f8e:	60e2                	ld	ra,24(sp)
    80000f90:	6442                	ld	s0,16(sp)
    80000f92:	64a2                	ld	s1,8(sp)
    80000f94:	6902                	ld	s2,0(sp)
    80000f96:	6105                	addi	sp,sp,32
    80000f98:	8082                	ret

0000000080000f9a <proc_pagetable>:
{
    80000f9a:	1101                	addi	sp,sp,-32
    80000f9c:	ec06                	sd	ra,24(sp)
    80000f9e:	e822                	sd	s0,16(sp)
    80000fa0:	e426                	sd	s1,8(sp)
    80000fa2:	e04a                	sd	s2,0(sp)
    80000fa4:	1000                	addi	s0,sp,32
    80000fa6:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80000fa8:	00000097          	auipc	ra,0x0
    80000fac:	89c080e7          	jalr	-1892(ra) # 80000844 <uvmcreate>
    80000fb0:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000fb2:	c121                	beqz	a0,80000ff2 <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80000fb4:	4729                	li	a4,10
    80000fb6:	00006697          	auipc	a3,0x6
    80000fba:	04a68693          	addi	a3,a3,74 # 80007000 <_trampoline>
    80000fbe:	6605                	lui	a2,0x1
    80000fc0:	040005b7          	lui	a1,0x4000
    80000fc4:	15fd                	addi	a1,a1,-1
    80000fc6:	05b2                	slli	a1,a1,0xc
    80000fc8:	fffff097          	auipc	ra,0xfffff
    80000fcc:	5f4080e7          	jalr	1524(ra) # 800005bc <mappages>
    80000fd0:	02054863          	bltz	a0,80001000 <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80000fd4:	4719                	li	a4,6
    80000fd6:	05893683          	ld	a3,88(s2)
    80000fda:	6605                	lui	a2,0x1
    80000fdc:	020005b7          	lui	a1,0x2000
    80000fe0:	15fd                	addi	a1,a1,-1
    80000fe2:	05b6                	slli	a1,a1,0xd
    80000fe4:	8526                	mv	a0,s1
    80000fe6:	fffff097          	auipc	ra,0xfffff
    80000fea:	5d6080e7          	jalr	1494(ra) # 800005bc <mappages>
    80000fee:	02054163          	bltz	a0,80001010 <proc_pagetable+0x76>
}
    80000ff2:	8526                	mv	a0,s1
    80000ff4:	60e2                	ld	ra,24(sp)
    80000ff6:	6442                	ld	s0,16(sp)
    80000ff8:	64a2                	ld	s1,8(sp)
    80000ffa:	6902                	ld	s2,0(sp)
    80000ffc:	6105                	addi	sp,sp,32
    80000ffe:	8082                	ret
    uvmfree(pagetable, 0);
    80001000:	4581                	li	a1,0
    80001002:	8526                	mv	a0,s1
    80001004:	00000097          	auipc	ra,0x0
    80001008:	a42080e7          	jalr	-1470(ra) # 80000a46 <uvmfree>
    return 0;
    8000100c:	4481                	li	s1,0
    8000100e:	b7d5                	j	80000ff2 <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001010:	4681                	li	a3,0
    80001012:	4605                	li	a2,1
    80001014:	040005b7          	lui	a1,0x4000
    80001018:	15fd                	addi	a1,a1,-1
    8000101a:	05b2                	slli	a1,a1,0xc
    8000101c:	8526                	mv	a0,s1
    8000101e:	fffff097          	auipc	ra,0xfffff
    80001022:	762080e7          	jalr	1890(ra) # 80000780 <uvmunmap>
    uvmfree(pagetable, 0);
    80001026:	4581                	li	a1,0
    80001028:	8526                	mv	a0,s1
    8000102a:	00000097          	auipc	ra,0x0
    8000102e:	a1c080e7          	jalr	-1508(ra) # 80000a46 <uvmfree>
    return 0;
    80001032:	4481                	li	s1,0
    80001034:	bf7d                	j	80000ff2 <proc_pagetable+0x58>

0000000080001036 <proc_freepagetable>:
{
    80001036:	1101                	addi	sp,sp,-32
    80001038:	ec06                	sd	ra,24(sp)
    8000103a:	e822                	sd	s0,16(sp)
    8000103c:	e426                	sd	s1,8(sp)
    8000103e:	e04a                	sd	s2,0(sp)
    80001040:	1000                	addi	s0,sp,32
    80001042:	84aa                	mv	s1,a0
    80001044:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001046:	4681                	li	a3,0
    80001048:	4605                	li	a2,1
    8000104a:	040005b7          	lui	a1,0x4000
    8000104e:	15fd                	addi	a1,a1,-1
    80001050:	05b2                	slli	a1,a1,0xc
    80001052:	fffff097          	auipc	ra,0xfffff
    80001056:	72e080e7          	jalr	1838(ra) # 80000780 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    8000105a:	4681                	li	a3,0
    8000105c:	4605                	li	a2,1
    8000105e:	020005b7          	lui	a1,0x2000
    80001062:	15fd                	addi	a1,a1,-1
    80001064:	05b6                	slli	a1,a1,0xd
    80001066:	8526                	mv	a0,s1
    80001068:	fffff097          	auipc	ra,0xfffff
    8000106c:	718080e7          	jalr	1816(ra) # 80000780 <uvmunmap>
  uvmfree(pagetable, sz);
    80001070:	85ca                	mv	a1,s2
    80001072:	8526                	mv	a0,s1
    80001074:	00000097          	auipc	ra,0x0
    80001078:	9d2080e7          	jalr	-1582(ra) # 80000a46 <uvmfree>
}
    8000107c:	60e2                	ld	ra,24(sp)
    8000107e:	6442                	ld	s0,16(sp)
    80001080:	64a2                	ld	s1,8(sp)
    80001082:	6902                	ld	s2,0(sp)
    80001084:	6105                	addi	sp,sp,32
    80001086:	8082                	ret

0000000080001088 <freeproc>:
{
    80001088:	1101                	addi	sp,sp,-32
    8000108a:	ec06                	sd	ra,24(sp)
    8000108c:	e822                	sd	s0,16(sp)
    8000108e:	e426                	sd	s1,8(sp)
    80001090:	1000                	addi	s0,sp,32
    80001092:	84aa                	mv	s1,a0
  if(p->trapframe)
    80001094:	6d28                	ld	a0,88(a0)
    80001096:	c509                	beqz	a0,800010a0 <freeproc+0x18>
    kfree((void*)p->trapframe);
    80001098:	fffff097          	auipc	ra,0xfffff
    8000109c:	f84080e7          	jalr	-124(ra) # 8000001c <kfree>
  p->trapframe = 0;
    800010a0:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    800010a4:	68a8                	ld	a0,80(s1)
    800010a6:	c511                	beqz	a0,800010b2 <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    800010a8:	64ac                	ld	a1,72(s1)
    800010aa:	00000097          	auipc	ra,0x0
    800010ae:	f8c080e7          	jalr	-116(ra) # 80001036 <proc_freepagetable>
  p->pagetable = 0;
    800010b2:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    800010b6:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    800010ba:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    800010be:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    800010c2:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    800010c6:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    800010ca:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    800010ce:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    800010d2:	0004ac23          	sw	zero,24(s1)
}
    800010d6:	60e2                	ld	ra,24(sp)
    800010d8:	6442                	ld	s0,16(sp)
    800010da:	64a2                	ld	s1,8(sp)
    800010dc:	6105                	addi	sp,sp,32
    800010de:	8082                	ret

00000000800010e0 <allocproc>:
{
    800010e0:	1101                	addi	sp,sp,-32
    800010e2:	ec06                	sd	ra,24(sp)
    800010e4:	e822                	sd	s0,16(sp)
    800010e6:	e426                	sd	s1,8(sp)
    800010e8:	e04a                	sd	s2,0(sp)
    800010ea:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    800010ec:	00008497          	auipc	s1,0x8
    800010f0:	df448493          	addi	s1,s1,-524 # 80008ee0 <proc>
    800010f4:	0000e917          	auipc	s2,0xe
    800010f8:	9ec90913          	addi	s2,s2,-1556 # 8000eae0 <tickslock>
    acquire(&p->lock);
    800010fc:	8526                	mv	a0,s1
    800010fe:	00005097          	auipc	ra,0x5
    80001102:	296080e7          	jalr	662(ra) # 80006394 <acquire>
    if(p->state == UNUSED) {
    80001106:	4c9c                	lw	a5,24(s1)
    80001108:	cf81                	beqz	a5,80001120 <allocproc+0x40>
      release(&p->lock);
    8000110a:	8526                	mv	a0,s1
    8000110c:	00005097          	auipc	ra,0x5
    80001110:	33c080e7          	jalr	828(ra) # 80006448 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001114:	17048493          	addi	s1,s1,368
    80001118:	ff2492e3          	bne	s1,s2,800010fc <allocproc+0x1c>
  return 0;
    8000111c:	4481                	li	s1,0
    8000111e:	a889                	j	80001170 <allocproc+0x90>
  p->pid = allocpid();
    80001120:	00000097          	auipc	ra,0x0
    80001124:	e34080e7          	jalr	-460(ra) # 80000f54 <allocpid>
    80001128:	d888                	sw	a0,48(s1)
  p->state = USED;
    8000112a:	4785                	li	a5,1
    8000112c:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    8000112e:	fffff097          	auipc	ra,0xfffff
    80001132:	fec080e7          	jalr	-20(ra) # 8000011a <kalloc>
    80001136:	892a                	mv	s2,a0
    80001138:	eca8                	sd	a0,88(s1)
    8000113a:	c131                	beqz	a0,8000117e <allocproc+0x9e>
  p->pagetable = proc_pagetable(p);
    8000113c:	8526                	mv	a0,s1
    8000113e:	00000097          	auipc	ra,0x0
    80001142:	e5c080e7          	jalr	-420(ra) # 80000f9a <proc_pagetable>
    80001146:	892a                	mv	s2,a0
    80001148:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    8000114a:	c531                	beqz	a0,80001196 <allocproc+0xb6>
  memset(&p->context, 0, sizeof(p->context));
    8000114c:	07000613          	li	a2,112
    80001150:	4581                	li	a1,0
    80001152:	06048513          	addi	a0,s1,96
    80001156:	fffff097          	auipc	ra,0xfffff
    8000115a:	06e080e7          	jalr	110(ra) # 800001c4 <memset>
  p->context.ra = (uint64)forkret;
    8000115e:	00000797          	auipc	a5,0x0
    80001162:	dae78793          	addi	a5,a5,-594 # 80000f0c <forkret>
    80001166:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    80001168:	60bc                	ld	a5,64(s1)
    8000116a:	6705                	lui	a4,0x1
    8000116c:	97ba                	add	a5,a5,a4
    8000116e:	f4bc                	sd	a5,104(s1)
}
    80001170:	8526                	mv	a0,s1
    80001172:	60e2                	ld	ra,24(sp)
    80001174:	6442                	ld	s0,16(sp)
    80001176:	64a2                	ld	s1,8(sp)
    80001178:	6902                	ld	s2,0(sp)
    8000117a:	6105                	addi	sp,sp,32
    8000117c:	8082                	ret
    freeproc(p);
    8000117e:	8526                	mv	a0,s1
    80001180:	00000097          	auipc	ra,0x0
    80001184:	f08080e7          	jalr	-248(ra) # 80001088 <freeproc>
    release(&p->lock);
    80001188:	8526                	mv	a0,s1
    8000118a:	00005097          	auipc	ra,0x5
    8000118e:	2be080e7          	jalr	702(ra) # 80006448 <release>
    return 0;
    80001192:	84ca                	mv	s1,s2
    80001194:	bff1                	j	80001170 <allocproc+0x90>
    freeproc(p);
    80001196:	8526                	mv	a0,s1
    80001198:	00000097          	auipc	ra,0x0
    8000119c:	ef0080e7          	jalr	-272(ra) # 80001088 <freeproc>
    release(&p->lock);
    800011a0:	8526                	mv	a0,s1
    800011a2:	00005097          	auipc	ra,0x5
    800011a6:	2a6080e7          	jalr	678(ra) # 80006448 <release>
    return 0;
    800011aa:	84ca                	mv	s1,s2
    800011ac:	b7d1                	j	80001170 <allocproc+0x90>

00000000800011ae <userinit>:
{
    800011ae:	1101                	addi	sp,sp,-32
    800011b0:	ec06                	sd	ra,24(sp)
    800011b2:	e822                	sd	s0,16(sp)
    800011b4:	e426                	sd	s1,8(sp)
    800011b6:	1000                	addi	s0,sp,32
  p = allocproc();
    800011b8:	00000097          	auipc	ra,0x0
    800011bc:	f28080e7          	jalr	-216(ra) # 800010e0 <allocproc>
    800011c0:	84aa                	mv	s1,a0
  initproc = p;
    800011c2:	00008797          	auipc	a5,0x8
    800011c6:	8aa7b723          	sd	a0,-1874(a5) # 80008a70 <initproc>
  uvmfirst(p->pagetable, initcode, sizeof(initcode));
    800011ca:	03400613          	li	a2,52
    800011ce:	00008597          	auipc	a1,0x8
    800011d2:	85258593          	addi	a1,a1,-1966 # 80008a20 <initcode>
    800011d6:	6928                	ld	a0,80(a0)
    800011d8:	fffff097          	auipc	ra,0xfffff
    800011dc:	69a080e7          	jalr	1690(ra) # 80000872 <uvmfirst>
  p->sz = PGSIZE;
    800011e0:	6785                	lui	a5,0x1
    800011e2:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    800011e4:	6cb8                	ld	a4,88(s1)
    800011e6:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    800011ea:	6cb8                	ld	a4,88(s1)
    800011ec:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    800011ee:	4641                	li	a2,16
    800011f0:	00007597          	auipc	a1,0x7
    800011f4:	fc058593          	addi	a1,a1,-64 # 800081b0 <states.1754+0x58>
    800011f8:	15848513          	addi	a0,s1,344
    800011fc:	fffff097          	auipc	ra,0xfffff
    80001200:	13c080e7          	jalr	316(ra) # 80000338 <safestrcpy>
  p->cwd = namei("/");
    80001204:	00007517          	auipc	a0,0x7
    80001208:	fbc50513          	addi	a0,a0,-68 # 800081c0 <states.1754+0x68>
    8000120c:	00002097          	auipc	ra,0x2
    80001210:	266080e7          	jalr	614(ra) # 80003472 <namei>
    80001214:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    80001218:	478d                	li	a5,3
    8000121a:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    8000121c:	8526                	mv	a0,s1
    8000121e:	00005097          	auipc	ra,0x5
    80001222:	22a080e7          	jalr	554(ra) # 80006448 <release>
}
    80001226:	60e2                	ld	ra,24(sp)
    80001228:	6442                	ld	s0,16(sp)
    8000122a:	64a2                	ld	s1,8(sp)
    8000122c:	6105                	addi	sp,sp,32
    8000122e:	8082                	ret

0000000080001230 <growproc>:
{
    80001230:	1101                	addi	sp,sp,-32
    80001232:	ec06                	sd	ra,24(sp)
    80001234:	e822                	sd	s0,16(sp)
    80001236:	e426                	sd	s1,8(sp)
    80001238:	e04a                	sd	s2,0(sp)
    8000123a:	1000                	addi	s0,sp,32
    8000123c:	892a                	mv	s2,a0
  struct proc *p = myproc();
    8000123e:	00000097          	auipc	ra,0x0
    80001242:	c96080e7          	jalr	-874(ra) # 80000ed4 <myproc>
    80001246:	84aa                	mv	s1,a0
  sz = p->sz;
    80001248:	652c                	ld	a1,72(a0)
  if(n > 0){
    8000124a:	01204c63          	bgtz	s2,80001262 <growproc+0x32>
  } else if(n < 0){
    8000124e:	02094663          	bltz	s2,8000127a <growproc+0x4a>
  p->sz = sz;
    80001252:	e4ac                	sd	a1,72(s1)
  return 0;
    80001254:	4501                	li	a0,0
}
    80001256:	60e2                	ld	ra,24(sp)
    80001258:	6442                	ld	s0,16(sp)
    8000125a:	64a2                	ld	s1,8(sp)
    8000125c:	6902                	ld	s2,0(sp)
    8000125e:	6105                	addi	sp,sp,32
    80001260:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    80001262:	4691                	li	a3,4
    80001264:	00b90633          	add	a2,s2,a1
    80001268:	6928                	ld	a0,80(a0)
    8000126a:	fffff097          	auipc	ra,0xfffff
    8000126e:	6c0080e7          	jalr	1728(ra) # 8000092a <uvmalloc>
    80001272:	85aa                	mv	a1,a0
    80001274:	fd79                	bnez	a0,80001252 <growproc+0x22>
      return -1;
    80001276:	557d                	li	a0,-1
    80001278:	bff9                	j	80001256 <growproc+0x26>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    8000127a:	00b90633          	add	a2,s2,a1
    8000127e:	6928                	ld	a0,80(a0)
    80001280:	fffff097          	auipc	ra,0xfffff
    80001284:	664080e7          	jalr	1636(ra) # 800008e4 <uvmdealloc>
    80001288:	85aa                	mv	a1,a0
    8000128a:	b7e1                	j	80001252 <growproc+0x22>

000000008000128c <fork>:
{
    8000128c:	7179                	addi	sp,sp,-48
    8000128e:	f406                	sd	ra,40(sp)
    80001290:	f022                	sd	s0,32(sp)
    80001292:	ec26                	sd	s1,24(sp)
    80001294:	e84a                	sd	s2,16(sp)
    80001296:	e44e                	sd	s3,8(sp)
    80001298:	e052                	sd	s4,0(sp)
    8000129a:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    8000129c:	00000097          	auipc	ra,0x0
    800012a0:	c38080e7          	jalr	-968(ra) # 80000ed4 <myproc>
    800012a4:	892a                	mv	s2,a0
  if((np = allocproc()) == 0){
    800012a6:	00000097          	auipc	ra,0x0
    800012aa:	e3a080e7          	jalr	-454(ra) # 800010e0 <allocproc>
    800012ae:	10050f63          	beqz	a0,800013cc <fork+0x140>
    800012b2:	89aa                	mv	s3,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    800012b4:	04893603          	ld	a2,72(s2)
    800012b8:	692c                	ld	a1,80(a0)
    800012ba:	05093503          	ld	a0,80(s2)
    800012be:	fffff097          	auipc	ra,0xfffff
    800012c2:	7c0080e7          	jalr	1984(ra) # 80000a7e <uvmcopy>
    800012c6:	04054a63          	bltz	a0,8000131a <fork+0x8e>
  np->sz = p->sz;
    800012ca:	04893783          	ld	a5,72(s2)
    800012ce:	04f9b423          	sd	a5,72(s3)
  np->trace_mask = p->trace_mask;
    800012d2:	16892783          	lw	a5,360(s2)
    800012d6:	16f9a423          	sw	a5,360(s3)
  *(np->trapframe) = *(p->trapframe);
    800012da:	05893683          	ld	a3,88(s2)
    800012de:	87b6                	mv	a5,a3
    800012e0:	0589b703          	ld	a4,88(s3)
    800012e4:	12068693          	addi	a3,a3,288
    800012e8:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    800012ec:	6788                	ld	a0,8(a5)
    800012ee:	6b8c                	ld	a1,16(a5)
    800012f0:	6f90                	ld	a2,24(a5)
    800012f2:	01073023          	sd	a6,0(a4)
    800012f6:	e708                	sd	a0,8(a4)
    800012f8:	eb0c                	sd	a1,16(a4)
    800012fa:	ef10                	sd	a2,24(a4)
    800012fc:	02078793          	addi	a5,a5,32
    80001300:	02070713          	addi	a4,a4,32
    80001304:	fed792e3          	bne	a5,a3,800012e8 <fork+0x5c>
  np->trapframe->a0 = 0;
    80001308:	0589b783          	ld	a5,88(s3)
    8000130c:	0607b823          	sd	zero,112(a5)
    80001310:	0d000493          	li	s1,208
  for(i = 0; i < NOFILE; i++)
    80001314:	15000a13          	li	s4,336
    80001318:	a03d                	j	80001346 <fork+0xba>
    freeproc(np);
    8000131a:	854e                	mv	a0,s3
    8000131c:	00000097          	auipc	ra,0x0
    80001320:	d6c080e7          	jalr	-660(ra) # 80001088 <freeproc>
    release(&np->lock);
    80001324:	854e                	mv	a0,s3
    80001326:	00005097          	auipc	ra,0x5
    8000132a:	122080e7          	jalr	290(ra) # 80006448 <release>
    return -1;
    8000132e:	5a7d                	li	s4,-1
    80001330:	a069                	j	800013ba <fork+0x12e>
      np->ofile[i] = filedup(p->ofile[i]);
    80001332:	00003097          	auipc	ra,0x3
    80001336:	806080e7          	jalr	-2042(ra) # 80003b38 <filedup>
    8000133a:	009987b3          	add	a5,s3,s1
    8000133e:	e388                	sd	a0,0(a5)
    80001340:	04a1                	addi	s1,s1,8
  for(i = 0; i < NOFILE; i++)
    80001342:	01448763          	beq	s1,s4,80001350 <fork+0xc4>
    if(p->ofile[i])
    80001346:	009907b3          	add	a5,s2,s1
    8000134a:	6388                	ld	a0,0(a5)
    8000134c:	f17d                	bnez	a0,80001332 <fork+0xa6>
    8000134e:	bfcd                	j	80001340 <fork+0xb4>
  np->cwd = idup(p->cwd);
    80001350:	15093503          	ld	a0,336(s2)
    80001354:	00002097          	auipc	ra,0x2
    80001358:	930080e7          	jalr	-1744(ra) # 80002c84 <idup>
    8000135c:	14a9b823          	sd	a0,336(s3)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001360:	4641                	li	a2,16
    80001362:	15890593          	addi	a1,s2,344
    80001366:	15898513          	addi	a0,s3,344
    8000136a:	fffff097          	auipc	ra,0xfffff
    8000136e:	fce080e7          	jalr	-50(ra) # 80000338 <safestrcpy>
  pid = np->pid;
    80001372:	0309aa03          	lw	s4,48(s3)
  release(&np->lock);
    80001376:	854e                	mv	a0,s3
    80001378:	00005097          	auipc	ra,0x5
    8000137c:	0d0080e7          	jalr	208(ra) # 80006448 <release>
  acquire(&wait_lock);
    80001380:	00007497          	auipc	s1,0x7
    80001384:	74848493          	addi	s1,s1,1864 # 80008ac8 <wait_lock>
    80001388:	8526                	mv	a0,s1
    8000138a:	00005097          	auipc	ra,0x5
    8000138e:	00a080e7          	jalr	10(ra) # 80006394 <acquire>
  np->parent = p;
    80001392:	0329bc23          	sd	s2,56(s3)
  release(&wait_lock);
    80001396:	8526                	mv	a0,s1
    80001398:	00005097          	auipc	ra,0x5
    8000139c:	0b0080e7          	jalr	176(ra) # 80006448 <release>
  acquire(&np->lock);
    800013a0:	854e                	mv	a0,s3
    800013a2:	00005097          	auipc	ra,0x5
    800013a6:	ff2080e7          	jalr	-14(ra) # 80006394 <acquire>
  np->state = RUNNABLE;
    800013aa:	478d                	li	a5,3
    800013ac:	00f9ac23          	sw	a5,24(s3)
  release(&np->lock);
    800013b0:	854e                	mv	a0,s3
    800013b2:	00005097          	auipc	ra,0x5
    800013b6:	096080e7          	jalr	150(ra) # 80006448 <release>
}
    800013ba:	8552                	mv	a0,s4
    800013bc:	70a2                	ld	ra,40(sp)
    800013be:	7402                	ld	s0,32(sp)
    800013c0:	64e2                	ld	s1,24(sp)
    800013c2:	6942                	ld	s2,16(sp)
    800013c4:	69a2                	ld	s3,8(sp)
    800013c6:	6a02                	ld	s4,0(sp)
    800013c8:	6145                	addi	sp,sp,48
    800013ca:	8082                	ret
    return -1;
    800013cc:	5a7d                	li	s4,-1
    800013ce:	b7f5                	j	800013ba <fork+0x12e>

00000000800013d0 <scheduler>:
{
    800013d0:	7139                	addi	sp,sp,-64
    800013d2:	fc06                	sd	ra,56(sp)
    800013d4:	f822                	sd	s0,48(sp)
    800013d6:	f426                	sd	s1,40(sp)
    800013d8:	f04a                	sd	s2,32(sp)
    800013da:	ec4e                	sd	s3,24(sp)
    800013dc:	e852                	sd	s4,16(sp)
    800013de:	e456                	sd	s5,8(sp)
    800013e0:	e05a                	sd	s6,0(sp)
    800013e2:	0080                	addi	s0,sp,64
    800013e4:	8792                	mv	a5,tp
  int id = r_tp();
    800013e6:	2781                	sext.w	a5,a5
  c->proc = 0;
    800013e8:	00779a93          	slli	s5,a5,0x7
    800013ec:	00007717          	auipc	a4,0x7
    800013f0:	6c470713          	addi	a4,a4,1732 # 80008ab0 <pid_lock>
    800013f4:	9756                	add	a4,a4,s5
    800013f6:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    800013fa:	00007717          	auipc	a4,0x7
    800013fe:	6ee70713          	addi	a4,a4,1774 # 80008ae8 <cpus+0x8>
    80001402:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    80001404:	498d                	li	s3,3
        p->state = RUNNING;
    80001406:	4b11                	li	s6,4
        c->proc = p;
    80001408:	079e                	slli	a5,a5,0x7
    8000140a:	00007a17          	auipc	s4,0x7
    8000140e:	6a6a0a13          	addi	s4,s4,1702 # 80008ab0 <pid_lock>
    80001412:	9a3e                	add	s4,s4,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    80001414:	0000d917          	auipc	s2,0xd
    80001418:	6cc90913          	addi	s2,s2,1740 # 8000eae0 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000141c:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001420:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001424:	10079073          	csrw	sstatus,a5
    80001428:	00008497          	auipc	s1,0x8
    8000142c:	ab848493          	addi	s1,s1,-1352 # 80008ee0 <proc>
    80001430:	a03d                	j	8000145e <scheduler+0x8e>
        p->state = RUNNING;
    80001432:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    80001436:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    8000143a:	06048593          	addi	a1,s1,96
    8000143e:	8556                	mv	a0,s5
    80001440:	00000097          	auipc	ra,0x0
    80001444:	71a080e7          	jalr	1818(ra) # 80001b5a <swtch>
        c->proc = 0;
    80001448:	020a3823          	sd	zero,48(s4)
      release(&p->lock);
    8000144c:	8526                	mv	a0,s1
    8000144e:	00005097          	auipc	ra,0x5
    80001452:	ffa080e7          	jalr	-6(ra) # 80006448 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80001456:	17048493          	addi	s1,s1,368
    8000145a:	fd2481e3          	beq	s1,s2,8000141c <scheduler+0x4c>
      acquire(&p->lock);
    8000145e:	8526                	mv	a0,s1
    80001460:	00005097          	auipc	ra,0x5
    80001464:	f34080e7          	jalr	-204(ra) # 80006394 <acquire>
      if(p->state == RUNNABLE) {
    80001468:	4c9c                	lw	a5,24(s1)
    8000146a:	ff3791e3          	bne	a5,s3,8000144c <scheduler+0x7c>
    8000146e:	b7d1                	j	80001432 <scheduler+0x62>

0000000080001470 <sched>:
{
    80001470:	7179                	addi	sp,sp,-48
    80001472:	f406                	sd	ra,40(sp)
    80001474:	f022                	sd	s0,32(sp)
    80001476:	ec26                	sd	s1,24(sp)
    80001478:	e84a                	sd	s2,16(sp)
    8000147a:	e44e                	sd	s3,8(sp)
    8000147c:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    8000147e:	00000097          	auipc	ra,0x0
    80001482:	a56080e7          	jalr	-1450(ra) # 80000ed4 <myproc>
    80001486:	892a                	mv	s2,a0
  if(!holding(&p->lock))
    80001488:	00005097          	auipc	ra,0x5
    8000148c:	e92080e7          	jalr	-366(ra) # 8000631a <holding>
    80001490:	cd25                	beqz	a0,80001508 <sched+0x98>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001492:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    80001494:	2781                	sext.w	a5,a5
    80001496:	079e                	slli	a5,a5,0x7
    80001498:	00007717          	auipc	a4,0x7
    8000149c:	61870713          	addi	a4,a4,1560 # 80008ab0 <pid_lock>
    800014a0:	97ba                	add	a5,a5,a4
    800014a2:	0a87a703          	lw	a4,168(a5)
    800014a6:	4785                	li	a5,1
    800014a8:	06f71863          	bne	a4,a5,80001518 <sched+0xa8>
  if(p->state == RUNNING)
    800014ac:	01892703          	lw	a4,24(s2)
    800014b0:	4791                	li	a5,4
    800014b2:	06f70b63          	beq	a4,a5,80001528 <sched+0xb8>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800014b6:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800014ba:	8b89                	andi	a5,a5,2
  if(intr_get())
    800014bc:	efb5                	bnez	a5,80001538 <sched+0xc8>
  asm volatile("mv %0, tp" : "=r" (x) );
    800014be:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    800014c0:	00007497          	auipc	s1,0x7
    800014c4:	5f048493          	addi	s1,s1,1520 # 80008ab0 <pid_lock>
    800014c8:	2781                	sext.w	a5,a5
    800014ca:	079e                	slli	a5,a5,0x7
    800014cc:	97a6                	add	a5,a5,s1
    800014ce:	0ac7a983          	lw	s3,172(a5)
    800014d2:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    800014d4:	2781                	sext.w	a5,a5
    800014d6:	079e                	slli	a5,a5,0x7
    800014d8:	00007597          	auipc	a1,0x7
    800014dc:	61058593          	addi	a1,a1,1552 # 80008ae8 <cpus+0x8>
    800014e0:	95be                	add	a1,a1,a5
    800014e2:	06090513          	addi	a0,s2,96
    800014e6:	00000097          	auipc	ra,0x0
    800014ea:	674080e7          	jalr	1652(ra) # 80001b5a <swtch>
    800014ee:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    800014f0:	2781                	sext.w	a5,a5
    800014f2:	079e                	slli	a5,a5,0x7
    800014f4:	97a6                	add	a5,a5,s1
    800014f6:	0b37a623          	sw	s3,172(a5)
}
    800014fa:	70a2                	ld	ra,40(sp)
    800014fc:	7402                	ld	s0,32(sp)
    800014fe:	64e2                	ld	s1,24(sp)
    80001500:	6942                	ld	s2,16(sp)
    80001502:	69a2                	ld	s3,8(sp)
    80001504:	6145                	addi	sp,sp,48
    80001506:	8082                	ret
    panic("sched p->lock");
    80001508:	00007517          	auipc	a0,0x7
    8000150c:	cc050513          	addi	a0,a0,-832 # 800081c8 <states.1754+0x70>
    80001510:	00005097          	auipc	ra,0x5
    80001514:	91c080e7          	jalr	-1764(ra) # 80005e2c <panic>
    panic("sched locks");
    80001518:	00007517          	auipc	a0,0x7
    8000151c:	cc050513          	addi	a0,a0,-832 # 800081d8 <states.1754+0x80>
    80001520:	00005097          	auipc	ra,0x5
    80001524:	90c080e7          	jalr	-1780(ra) # 80005e2c <panic>
    panic("sched running");
    80001528:	00007517          	auipc	a0,0x7
    8000152c:	cc050513          	addi	a0,a0,-832 # 800081e8 <states.1754+0x90>
    80001530:	00005097          	auipc	ra,0x5
    80001534:	8fc080e7          	jalr	-1796(ra) # 80005e2c <panic>
    panic("sched interruptible");
    80001538:	00007517          	auipc	a0,0x7
    8000153c:	cc050513          	addi	a0,a0,-832 # 800081f8 <states.1754+0xa0>
    80001540:	00005097          	auipc	ra,0x5
    80001544:	8ec080e7          	jalr	-1812(ra) # 80005e2c <panic>

0000000080001548 <yield>:
{
    80001548:	1101                	addi	sp,sp,-32
    8000154a:	ec06                	sd	ra,24(sp)
    8000154c:	e822                	sd	s0,16(sp)
    8000154e:	e426                	sd	s1,8(sp)
    80001550:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80001552:	00000097          	auipc	ra,0x0
    80001556:	982080e7          	jalr	-1662(ra) # 80000ed4 <myproc>
    8000155a:	84aa                	mv	s1,a0
  acquire(&p->lock);
    8000155c:	00005097          	auipc	ra,0x5
    80001560:	e38080e7          	jalr	-456(ra) # 80006394 <acquire>
  p->state = RUNNABLE;
    80001564:	478d                	li	a5,3
    80001566:	cc9c                	sw	a5,24(s1)
  sched();
    80001568:	00000097          	auipc	ra,0x0
    8000156c:	f08080e7          	jalr	-248(ra) # 80001470 <sched>
  release(&p->lock);
    80001570:	8526                	mv	a0,s1
    80001572:	00005097          	auipc	ra,0x5
    80001576:	ed6080e7          	jalr	-298(ra) # 80006448 <release>
}
    8000157a:	60e2                	ld	ra,24(sp)
    8000157c:	6442                	ld	s0,16(sp)
    8000157e:	64a2                	ld	s1,8(sp)
    80001580:	6105                	addi	sp,sp,32
    80001582:	8082                	ret

0000000080001584 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80001584:	7179                	addi	sp,sp,-48
    80001586:	f406                	sd	ra,40(sp)
    80001588:	f022                	sd	s0,32(sp)
    8000158a:	ec26                	sd	s1,24(sp)
    8000158c:	e84a                	sd	s2,16(sp)
    8000158e:	e44e                	sd	s3,8(sp)
    80001590:	1800                	addi	s0,sp,48
    80001592:	89aa                	mv	s3,a0
    80001594:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001596:	00000097          	auipc	ra,0x0
    8000159a:	93e080e7          	jalr	-1730(ra) # 80000ed4 <myproc>
    8000159e:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    800015a0:	00005097          	auipc	ra,0x5
    800015a4:	df4080e7          	jalr	-524(ra) # 80006394 <acquire>
  release(lk);
    800015a8:	854a                	mv	a0,s2
    800015aa:	00005097          	auipc	ra,0x5
    800015ae:	e9e080e7          	jalr	-354(ra) # 80006448 <release>

  // Go to sleep.
  p->chan = chan;
    800015b2:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    800015b6:	4789                	li	a5,2
    800015b8:	cc9c                	sw	a5,24(s1)

  sched();
    800015ba:	00000097          	auipc	ra,0x0
    800015be:	eb6080e7          	jalr	-330(ra) # 80001470 <sched>

  // Tidy up.
  p->chan = 0;
    800015c2:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    800015c6:	8526                	mv	a0,s1
    800015c8:	00005097          	auipc	ra,0x5
    800015cc:	e80080e7          	jalr	-384(ra) # 80006448 <release>
  acquire(lk);
    800015d0:	854a                	mv	a0,s2
    800015d2:	00005097          	auipc	ra,0x5
    800015d6:	dc2080e7          	jalr	-574(ra) # 80006394 <acquire>
}
    800015da:	70a2                	ld	ra,40(sp)
    800015dc:	7402                	ld	s0,32(sp)
    800015de:	64e2                	ld	s1,24(sp)
    800015e0:	6942                	ld	s2,16(sp)
    800015e2:	69a2                	ld	s3,8(sp)
    800015e4:	6145                	addi	sp,sp,48
    800015e6:	8082                	ret

00000000800015e8 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    800015e8:	7139                	addi	sp,sp,-64
    800015ea:	fc06                	sd	ra,56(sp)
    800015ec:	f822                	sd	s0,48(sp)
    800015ee:	f426                	sd	s1,40(sp)
    800015f0:	f04a                	sd	s2,32(sp)
    800015f2:	ec4e                	sd	s3,24(sp)
    800015f4:	e852                	sd	s4,16(sp)
    800015f6:	e456                	sd	s5,8(sp)
    800015f8:	0080                	addi	s0,sp,64
    800015fa:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800015fc:	00008497          	auipc	s1,0x8
    80001600:	8e448493          	addi	s1,s1,-1820 # 80008ee0 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    80001604:	4989                	li	s3,2
        p->state = RUNNABLE;
    80001606:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    80001608:	0000d917          	auipc	s2,0xd
    8000160c:	4d890913          	addi	s2,s2,1240 # 8000eae0 <tickslock>
    80001610:	a821                	j	80001628 <wakeup+0x40>
        p->state = RUNNABLE;
    80001612:	0154ac23          	sw	s5,24(s1)
      }
      release(&p->lock);
    80001616:	8526                	mv	a0,s1
    80001618:	00005097          	auipc	ra,0x5
    8000161c:	e30080e7          	jalr	-464(ra) # 80006448 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001620:	17048493          	addi	s1,s1,368
    80001624:	03248463          	beq	s1,s2,8000164c <wakeup+0x64>
    if(p != myproc()){
    80001628:	00000097          	auipc	ra,0x0
    8000162c:	8ac080e7          	jalr	-1876(ra) # 80000ed4 <myproc>
    80001630:	fea488e3          	beq	s1,a0,80001620 <wakeup+0x38>
      acquire(&p->lock);
    80001634:	8526                	mv	a0,s1
    80001636:	00005097          	auipc	ra,0x5
    8000163a:	d5e080e7          	jalr	-674(ra) # 80006394 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    8000163e:	4c9c                	lw	a5,24(s1)
    80001640:	fd379be3          	bne	a5,s3,80001616 <wakeup+0x2e>
    80001644:	709c                	ld	a5,32(s1)
    80001646:	fd4798e3          	bne	a5,s4,80001616 <wakeup+0x2e>
    8000164a:	b7e1                	j	80001612 <wakeup+0x2a>
    }
  }
}
    8000164c:	70e2                	ld	ra,56(sp)
    8000164e:	7442                	ld	s0,48(sp)
    80001650:	74a2                	ld	s1,40(sp)
    80001652:	7902                	ld	s2,32(sp)
    80001654:	69e2                	ld	s3,24(sp)
    80001656:	6a42                	ld	s4,16(sp)
    80001658:	6aa2                	ld	s5,8(sp)
    8000165a:	6121                	addi	sp,sp,64
    8000165c:	8082                	ret

000000008000165e <reparent>:
{
    8000165e:	7179                	addi	sp,sp,-48
    80001660:	f406                	sd	ra,40(sp)
    80001662:	f022                	sd	s0,32(sp)
    80001664:	ec26                	sd	s1,24(sp)
    80001666:	e84a                	sd	s2,16(sp)
    80001668:	e44e                	sd	s3,8(sp)
    8000166a:	e052                	sd	s4,0(sp)
    8000166c:	1800                	addi	s0,sp,48
    8000166e:	89aa                	mv	s3,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001670:	00008497          	auipc	s1,0x8
    80001674:	87048493          	addi	s1,s1,-1936 # 80008ee0 <proc>
      pp->parent = initproc;
    80001678:	00007a17          	auipc	s4,0x7
    8000167c:	3f8a0a13          	addi	s4,s4,1016 # 80008a70 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001680:	0000d917          	auipc	s2,0xd
    80001684:	46090913          	addi	s2,s2,1120 # 8000eae0 <tickslock>
    80001688:	a029                	j	80001692 <reparent+0x34>
    8000168a:	17048493          	addi	s1,s1,368
    8000168e:	01248d63          	beq	s1,s2,800016a8 <reparent+0x4a>
    if(pp->parent == p){
    80001692:	7c9c                	ld	a5,56(s1)
    80001694:	ff379be3          	bne	a5,s3,8000168a <reparent+0x2c>
      pp->parent = initproc;
    80001698:	000a3503          	ld	a0,0(s4)
    8000169c:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    8000169e:	00000097          	auipc	ra,0x0
    800016a2:	f4a080e7          	jalr	-182(ra) # 800015e8 <wakeup>
    800016a6:	b7d5                	j	8000168a <reparent+0x2c>
}
    800016a8:	70a2                	ld	ra,40(sp)
    800016aa:	7402                	ld	s0,32(sp)
    800016ac:	64e2                	ld	s1,24(sp)
    800016ae:	6942                	ld	s2,16(sp)
    800016b0:	69a2                	ld	s3,8(sp)
    800016b2:	6a02                	ld	s4,0(sp)
    800016b4:	6145                	addi	sp,sp,48
    800016b6:	8082                	ret

00000000800016b8 <exit>:
{
    800016b8:	7179                	addi	sp,sp,-48
    800016ba:	f406                	sd	ra,40(sp)
    800016bc:	f022                	sd	s0,32(sp)
    800016be:	ec26                	sd	s1,24(sp)
    800016c0:	e84a                	sd	s2,16(sp)
    800016c2:	e44e                	sd	s3,8(sp)
    800016c4:	e052                	sd	s4,0(sp)
    800016c6:	1800                	addi	s0,sp,48
    800016c8:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    800016ca:	00000097          	auipc	ra,0x0
    800016ce:	80a080e7          	jalr	-2038(ra) # 80000ed4 <myproc>
    800016d2:	89aa                	mv	s3,a0
  if(p == initproc)
    800016d4:	00007797          	auipc	a5,0x7
    800016d8:	39c78793          	addi	a5,a5,924 # 80008a70 <initproc>
    800016dc:	639c                	ld	a5,0(a5)
    800016de:	0d050493          	addi	s1,a0,208
    800016e2:	15050913          	addi	s2,a0,336
    800016e6:	02a79363          	bne	a5,a0,8000170c <exit+0x54>
    panic("init exiting");
    800016ea:	00007517          	auipc	a0,0x7
    800016ee:	b2650513          	addi	a0,a0,-1242 # 80008210 <states.1754+0xb8>
    800016f2:	00004097          	auipc	ra,0x4
    800016f6:	73a080e7          	jalr	1850(ra) # 80005e2c <panic>
      fileclose(f);
    800016fa:	00002097          	auipc	ra,0x2
    800016fe:	490080e7          	jalr	1168(ra) # 80003b8a <fileclose>
      p->ofile[fd] = 0;
    80001702:	0004b023          	sd	zero,0(s1)
    80001706:	04a1                	addi	s1,s1,8
  for(int fd = 0; fd < NOFILE; fd++){
    80001708:	01248563          	beq	s1,s2,80001712 <exit+0x5a>
    if(p->ofile[fd]){
    8000170c:	6088                	ld	a0,0(s1)
    8000170e:	f575                	bnez	a0,800016fa <exit+0x42>
    80001710:	bfdd                	j	80001706 <exit+0x4e>
  begin_op();
    80001712:	00002097          	auipc	ra,0x2
    80001716:	f7e080e7          	jalr	-130(ra) # 80003690 <begin_op>
  iput(p->cwd);
    8000171a:	1509b503          	ld	a0,336(s3)
    8000171e:	00001097          	auipc	ra,0x1
    80001722:	760080e7          	jalr	1888(ra) # 80002e7e <iput>
  end_op();
    80001726:	00002097          	auipc	ra,0x2
    8000172a:	fea080e7          	jalr	-22(ra) # 80003710 <end_op>
  p->cwd = 0;
    8000172e:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    80001732:	00007497          	auipc	s1,0x7
    80001736:	39648493          	addi	s1,s1,918 # 80008ac8 <wait_lock>
    8000173a:	8526                	mv	a0,s1
    8000173c:	00005097          	auipc	ra,0x5
    80001740:	c58080e7          	jalr	-936(ra) # 80006394 <acquire>
  reparent(p);
    80001744:	854e                	mv	a0,s3
    80001746:	00000097          	auipc	ra,0x0
    8000174a:	f18080e7          	jalr	-232(ra) # 8000165e <reparent>
  wakeup(p->parent);
    8000174e:	0389b503          	ld	a0,56(s3)
    80001752:	00000097          	auipc	ra,0x0
    80001756:	e96080e7          	jalr	-362(ra) # 800015e8 <wakeup>
  acquire(&p->lock);
    8000175a:	854e                	mv	a0,s3
    8000175c:	00005097          	auipc	ra,0x5
    80001760:	c38080e7          	jalr	-968(ra) # 80006394 <acquire>
  p->xstate = status;
    80001764:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    80001768:	4795                	li	a5,5
    8000176a:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    8000176e:	8526                	mv	a0,s1
    80001770:	00005097          	auipc	ra,0x5
    80001774:	cd8080e7          	jalr	-808(ra) # 80006448 <release>
  sched();
    80001778:	00000097          	auipc	ra,0x0
    8000177c:	cf8080e7          	jalr	-776(ra) # 80001470 <sched>
  panic("zombie exit");
    80001780:	00007517          	auipc	a0,0x7
    80001784:	aa050513          	addi	a0,a0,-1376 # 80008220 <states.1754+0xc8>
    80001788:	00004097          	auipc	ra,0x4
    8000178c:	6a4080e7          	jalr	1700(ra) # 80005e2c <panic>

0000000080001790 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80001790:	7179                	addi	sp,sp,-48
    80001792:	f406                	sd	ra,40(sp)
    80001794:	f022                	sd	s0,32(sp)
    80001796:	ec26                	sd	s1,24(sp)
    80001798:	e84a                	sd	s2,16(sp)
    8000179a:	e44e                	sd	s3,8(sp)
    8000179c:	1800                	addi	s0,sp,48
    8000179e:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    800017a0:	00007497          	auipc	s1,0x7
    800017a4:	74048493          	addi	s1,s1,1856 # 80008ee0 <proc>
    800017a8:	0000d997          	auipc	s3,0xd
    800017ac:	33898993          	addi	s3,s3,824 # 8000eae0 <tickslock>
    acquire(&p->lock);
    800017b0:	8526                	mv	a0,s1
    800017b2:	00005097          	auipc	ra,0x5
    800017b6:	be2080e7          	jalr	-1054(ra) # 80006394 <acquire>
    if(p->pid == pid){
    800017ba:	589c                	lw	a5,48(s1)
    800017bc:	01278d63          	beq	a5,s2,800017d6 <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    800017c0:	8526                	mv	a0,s1
    800017c2:	00005097          	auipc	ra,0x5
    800017c6:	c86080e7          	jalr	-890(ra) # 80006448 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    800017ca:	17048493          	addi	s1,s1,368
    800017ce:	ff3491e3          	bne	s1,s3,800017b0 <kill+0x20>
  }
  return -1;
    800017d2:	557d                	li	a0,-1
    800017d4:	a829                	j	800017ee <kill+0x5e>
      p->killed = 1;
    800017d6:	4785                	li	a5,1
    800017d8:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    800017da:	4c98                	lw	a4,24(s1)
    800017dc:	4789                	li	a5,2
    800017de:	00f70f63          	beq	a4,a5,800017fc <kill+0x6c>
      release(&p->lock);
    800017e2:	8526                	mv	a0,s1
    800017e4:	00005097          	auipc	ra,0x5
    800017e8:	c64080e7          	jalr	-924(ra) # 80006448 <release>
      return 0;
    800017ec:	4501                	li	a0,0
}
    800017ee:	70a2                	ld	ra,40(sp)
    800017f0:	7402                	ld	s0,32(sp)
    800017f2:	64e2                	ld	s1,24(sp)
    800017f4:	6942                	ld	s2,16(sp)
    800017f6:	69a2                	ld	s3,8(sp)
    800017f8:	6145                	addi	sp,sp,48
    800017fa:	8082                	ret
        p->state = RUNNABLE;
    800017fc:	478d                	li	a5,3
    800017fe:	cc9c                	sw	a5,24(s1)
    80001800:	b7cd                	j	800017e2 <kill+0x52>

0000000080001802 <setkilled>:

void
setkilled(struct proc *p)
{
    80001802:	1101                	addi	sp,sp,-32
    80001804:	ec06                	sd	ra,24(sp)
    80001806:	e822                	sd	s0,16(sp)
    80001808:	e426                	sd	s1,8(sp)
    8000180a:	1000                	addi	s0,sp,32
    8000180c:	84aa                	mv	s1,a0
  acquire(&p->lock);
    8000180e:	00005097          	auipc	ra,0x5
    80001812:	b86080e7          	jalr	-1146(ra) # 80006394 <acquire>
  p->killed = 1;
    80001816:	4785                	li	a5,1
    80001818:	d49c                	sw	a5,40(s1)
  release(&p->lock);
    8000181a:	8526                	mv	a0,s1
    8000181c:	00005097          	auipc	ra,0x5
    80001820:	c2c080e7          	jalr	-980(ra) # 80006448 <release>
}
    80001824:	60e2                	ld	ra,24(sp)
    80001826:	6442                	ld	s0,16(sp)
    80001828:	64a2                	ld	s1,8(sp)
    8000182a:	6105                	addi	sp,sp,32
    8000182c:	8082                	ret

000000008000182e <killed>:

int
killed(struct proc *p)
{
    8000182e:	1101                	addi	sp,sp,-32
    80001830:	ec06                	sd	ra,24(sp)
    80001832:	e822                	sd	s0,16(sp)
    80001834:	e426                	sd	s1,8(sp)
    80001836:	e04a                	sd	s2,0(sp)
    80001838:	1000                	addi	s0,sp,32
    8000183a:	84aa                	mv	s1,a0
  int k;
  
  acquire(&p->lock);
    8000183c:	00005097          	auipc	ra,0x5
    80001840:	b58080e7          	jalr	-1192(ra) # 80006394 <acquire>
  k = p->killed;
    80001844:	0284a903          	lw	s2,40(s1)
  release(&p->lock);
    80001848:	8526                	mv	a0,s1
    8000184a:	00005097          	auipc	ra,0x5
    8000184e:	bfe080e7          	jalr	-1026(ra) # 80006448 <release>
  return k;
}
    80001852:	854a                	mv	a0,s2
    80001854:	60e2                	ld	ra,24(sp)
    80001856:	6442                	ld	s0,16(sp)
    80001858:	64a2                	ld	s1,8(sp)
    8000185a:	6902                	ld	s2,0(sp)
    8000185c:	6105                	addi	sp,sp,32
    8000185e:	8082                	ret

0000000080001860 <wait>:
{
    80001860:	715d                	addi	sp,sp,-80
    80001862:	e486                	sd	ra,72(sp)
    80001864:	e0a2                	sd	s0,64(sp)
    80001866:	fc26                	sd	s1,56(sp)
    80001868:	f84a                	sd	s2,48(sp)
    8000186a:	f44e                	sd	s3,40(sp)
    8000186c:	f052                	sd	s4,32(sp)
    8000186e:	ec56                	sd	s5,24(sp)
    80001870:	e85a                	sd	s6,16(sp)
    80001872:	e45e                	sd	s7,8(sp)
    80001874:	e062                	sd	s8,0(sp)
    80001876:	0880                	addi	s0,sp,80
    80001878:	8baa                	mv	s7,a0
  struct proc *p = myproc();
    8000187a:	fffff097          	auipc	ra,0xfffff
    8000187e:	65a080e7          	jalr	1626(ra) # 80000ed4 <myproc>
    80001882:	892a                	mv	s2,a0
  acquire(&wait_lock);
    80001884:	00007517          	auipc	a0,0x7
    80001888:	24450513          	addi	a0,a0,580 # 80008ac8 <wait_lock>
    8000188c:	00005097          	auipc	ra,0x5
    80001890:	b08080e7          	jalr	-1272(ra) # 80006394 <acquire>
    havekids = 0;
    80001894:	4b01                	li	s6,0
        if(pp->state == ZOMBIE){
    80001896:	4a15                	li	s4,5
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001898:	0000d997          	auipc	s3,0xd
    8000189c:	24898993          	addi	s3,s3,584 # 8000eae0 <tickslock>
        havekids = 1;
    800018a0:	4a85                	li	s5,1
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800018a2:	00007c17          	auipc	s8,0x7
    800018a6:	226c0c13          	addi	s8,s8,550 # 80008ac8 <wait_lock>
    havekids = 0;
    800018aa:	875a                	mv	a4,s6
    for(pp = proc; pp < &proc[NPROC]; pp++){
    800018ac:	00007497          	auipc	s1,0x7
    800018b0:	63448493          	addi	s1,s1,1588 # 80008ee0 <proc>
    800018b4:	a0bd                	j	80001922 <wait+0xc2>
          pid = pp->pid;
    800018b6:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    800018ba:	000b8e63          	beqz	s7,800018d6 <wait+0x76>
    800018be:	4691                	li	a3,4
    800018c0:	02c48613          	addi	a2,s1,44
    800018c4:	85de                	mv	a1,s7
    800018c6:	05093503          	ld	a0,80(s2)
    800018ca:	fffff097          	auipc	ra,0xfffff
    800018ce:	2b8080e7          	jalr	696(ra) # 80000b82 <copyout>
    800018d2:	02054563          	bltz	a0,800018fc <wait+0x9c>
          freeproc(pp);
    800018d6:	8526                	mv	a0,s1
    800018d8:	fffff097          	auipc	ra,0xfffff
    800018dc:	7b0080e7          	jalr	1968(ra) # 80001088 <freeproc>
          release(&pp->lock);
    800018e0:	8526                	mv	a0,s1
    800018e2:	00005097          	auipc	ra,0x5
    800018e6:	b66080e7          	jalr	-1178(ra) # 80006448 <release>
          release(&wait_lock);
    800018ea:	00007517          	auipc	a0,0x7
    800018ee:	1de50513          	addi	a0,a0,478 # 80008ac8 <wait_lock>
    800018f2:	00005097          	auipc	ra,0x5
    800018f6:	b56080e7          	jalr	-1194(ra) # 80006448 <release>
          return pid;
    800018fa:	a0b5                	j	80001966 <wait+0x106>
            release(&pp->lock);
    800018fc:	8526                	mv	a0,s1
    800018fe:	00005097          	auipc	ra,0x5
    80001902:	b4a080e7          	jalr	-1206(ra) # 80006448 <release>
            release(&wait_lock);
    80001906:	00007517          	auipc	a0,0x7
    8000190a:	1c250513          	addi	a0,a0,450 # 80008ac8 <wait_lock>
    8000190e:	00005097          	auipc	ra,0x5
    80001912:	b3a080e7          	jalr	-1222(ra) # 80006448 <release>
            return -1;
    80001916:	59fd                	li	s3,-1
    80001918:	a0b9                	j	80001966 <wait+0x106>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    8000191a:	17048493          	addi	s1,s1,368
    8000191e:	03348463          	beq	s1,s3,80001946 <wait+0xe6>
      if(pp->parent == p){
    80001922:	7c9c                	ld	a5,56(s1)
    80001924:	ff279be3          	bne	a5,s2,8000191a <wait+0xba>
        acquire(&pp->lock);
    80001928:	8526                	mv	a0,s1
    8000192a:	00005097          	auipc	ra,0x5
    8000192e:	a6a080e7          	jalr	-1430(ra) # 80006394 <acquire>
        if(pp->state == ZOMBIE){
    80001932:	4c9c                	lw	a5,24(s1)
    80001934:	f94781e3          	beq	a5,s4,800018b6 <wait+0x56>
        release(&pp->lock);
    80001938:	8526                	mv	a0,s1
    8000193a:	00005097          	auipc	ra,0x5
    8000193e:	b0e080e7          	jalr	-1266(ra) # 80006448 <release>
        havekids = 1;
    80001942:	8756                	mv	a4,s5
    80001944:	bfd9                	j	8000191a <wait+0xba>
    if(!havekids || killed(p)){
    80001946:	c719                	beqz	a4,80001954 <wait+0xf4>
    80001948:	854a                	mv	a0,s2
    8000194a:	00000097          	auipc	ra,0x0
    8000194e:	ee4080e7          	jalr	-284(ra) # 8000182e <killed>
    80001952:	c51d                	beqz	a0,80001980 <wait+0x120>
      release(&wait_lock);
    80001954:	00007517          	auipc	a0,0x7
    80001958:	17450513          	addi	a0,a0,372 # 80008ac8 <wait_lock>
    8000195c:	00005097          	auipc	ra,0x5
    80001960:	aec080e7          	jalr	-1300(ra) # 80006448 <release>
      return -1;
    80001964:	59fd                	li	s3,-1
}
    80001966:	854e                	mv	a0,s3
    80001968:	60a6                	ld	ra,72(sp)
    8000196a:	6406                	ld	s0,64(sp)
    8000196c:	74e2                	ld	s1,56(sp)
    8000196e:	7942                	ld	s2,48(sp)
    80001970:	79a2                	ld	s3,40(sp)
    80001972:	7a02                	ld	s4,32(sp)
    80001974:	6ae2                	ld	s5,24(sp)
    80001976:	6b42                	ld	s6,16(sp)
    80001978:	6ba2                	ld	s7,8(sp)
    8000197a:	6c02                	ld	s8,0(sp)
    8000197c:	6161                	addi	sp,sp,80
    8000197e:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001980:	85e2                	mv	a1,s8
    80001982:	854a                	mv	a0,s2
    80001984:	00000097          	auipc	ra,0x0
    80001988:	c00080e7          	jalr	-1024(ra) # 80001584 <sleep>
    havekids = 0;
    8000198c:	bf39                	j	800018aa <wait+0x4a>

000000008000198e <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    8000198e:	7179                	addi	sp,sp,-48
    80001990:	f406                	sd	ra,40(sp)
    80001992:	f022                	sd	s0,32(sp)
    80001994:	ec26                	sd	s1,24(sp)
    80001996:	e84a                	sd	s2,16(sp)
    80001998:	e44e                	sd	s3,8(sp)
    8000199a:	e052                	sd	s4,0(sp)
    8000199c:	1800                	addi	s0,sp,48
    8000199e:	84aa                	mv	s1,a0
    800019a0:	892e                	mv	s2,a1
    800019a2:	89b2                	mv	s3,a2
    800019a4:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800019a6:	fffff097          	auipc	ra,0xfffff
    800019aa:	52e080e7          	jalr	1326(ra) # 80000ed4 <myproc>
  if(user_dst){
    800019ae:	c08d                	beqz	s1,800019d0 <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    800019b0:	86d2                	mv	a3,s4
    800019b2:	864e                	mv	a2,s3
    800019b4:	85ca                	mv	a1,s2
    800019b6:	6928                	ld	a0,80(a0)
    800019b8:	fffff097          	auipc	ra,0xfffff
    800019bc:	1ca080e7          	jalr	458(ra) # 80000b82 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    800019c0:	70a2                	ld	ra,40(sp)
    800019c2:	7402                	ld	s0,32(sp)
    800019c4:	64e2                	ld	s1,24(sp)
    800019c6:	6942                	ld	s2,16(sp)
    800019c8:	69a2                	ld	s3,8(sp)
    800019ca:	6a02                	ld	s4,0(sp)
    800019cc:	6145                	addi	sp,sp,48
    800019ce:	8082                	ret
    memmove((char *)dst, src, len);
    800019d0:	000a061b          	sext.w	a2,s4
    800019d4:	85ce                	mv	a1,s3
    800019d6:	854a                	mv	a0,s2
    800019d8:	fffff097          	auipc	ra,0xfffff
    800019dc:	858080e7          	jalr	-1960(ra) # 80000230 <memmove>
    return 0;
    800019e0:	8526                	mv	a0,s1
    800019e2:	bff9                	j	800019c0 <either_copyout+0x32>

00000000800019e4 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    800019e4:	7179                	addi	sp,sp,-48
    800019e6:	f406                	sd	ra,40(sp)
    800019e8:	f022                	sd	s0,32(sp)
    800019ea:	ec26                	sd	s1,24(sp)
    800019ec:	e84a                	sd	s2,16(sp)
    800019ee:	e44e                	sd	s3,8(sp)
    800019f0:	e052                	sd	s4,0(sp)
    800019f2:	1800                	addi	s0,sp,48
    800019f4:	892a                	mv	s2,a0
    800019f6:	84ae                	mv	s1,a1
    800019f8:	89b2                	mv	s3,a2
    800019fa:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800019fc:	fffff097          	auipc	ra,0xfffff
    80001a00:	4d8080e7          	jalr	1240(ra) # 80000ed4 <myproc>
  if(user_src){
    80001a04:	c08d                	beqz	s1,80001a26 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80001a06:	86d2                	mv	a3,s4
    80001a08:	864e                	mv	a2,s3
    80001a0a:	85ca                	mv	a1,s2
    80001a0c:	6928                	ld	a0,80(a0)
    80001a0e:	fffff097          	auipc	ra,0xfffff
    80001a12:	200080e7          	jalr	512(ra) # 80000c0e <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80001a16:	70a2                	ld	ra,40(sp)
    80001a18:	7402                	ld	s0,32(sp)
    80001a1a:	64e2                	ld	s1,24(sp)
    80001a1c:	6942                	ld	s2,16(sp)
    80001a1e:	69a2                	ld	s3,8(sp)
    80001a20:	6a02                	ld	s4,0(sp)
    80001a22:	6145                	addi	sp,sp,48
    80001a24:	8082                	ret
    memmove(dst, (char*)src, len);
    80001a26:	000a061b          	sext.w	a2,s4
    80001a2a:	85ce                	mv	a1,s3
    80001a2c:	854a                	mv	a0,s2
    80001a2e:	fffff097          	auipc	ra,0xfffff
    80001a32:	802080e7          	jalr	-2046(ra) # 80000230 <memmove>
    return 0;
    80001a36:	8526                	mv	a0,s1
    80001a38:	bff9                	j	80001a16 <either_copyin+0x32>

0000000080001a3a <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80001a3a:	715d                	addi	sp,sp,-80
    80001a3c:	e486                	sd	ra,72(sp)
    80001a3e:	e0a2                	sd	s0,64(sp)
    80001a40:	fc26                	sd	s1,56(sp)
    80001a42:	f84a                	sd	s2,48(sp)
    80001a44:	f44e                	sd	s3,40(sp)
    80001a46:	f052                	sd	s4,32(sp)
    80001a48:	ec56                	sd	s5,24(sp)
    80001a4a:	e85a                	sd	s6,16(sp)
    80001a4c:	e45e                	sd	s7,8(sp)
    80001a4e:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80001a50:	00006517          	auipc	a0,0x6
    80001a54:	5f850513          	addi	a0,a0,1528 # 80008048 <etext+0x48>
    80001a58:	00004097          	auipc	ra,0x4
    80001a5c:	41e080e7          	jalr	1054(ra) # 80005e76 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001a60:	00007497          	auipc	s1,0x7
    80001a64:	5d848493          	addi	s1,s1,1496 # 80009038 <proc+0x158>
    80001a68:	0000d917          	auipc	s2,0xd
    80001a6c:	1d090913          	addi	s2,s2,464 # 8000ec38 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a70:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80001a72:	00006997          	auipc	s3,0x6
    80001a76:	7be98993          	addi	s3,s3,1982 # 80008230 <states.1754+0xd8>
    printf("%d %s %s", p->pid, state, p->name);
    80001a7a:	00006a97          	auipc	s5,0x6
    80001a7e:	7bea8a93          	addi	s5,s5,1982 # 80008238 <states.1754+0xe0>
    printf("\n");
    80001a82:	00006a17          	auipc	s4,0x6
    80001a86:	5c6a0a13          	addi	s4,s4,1478 # 80008048 <etext+0x48>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a8a:	00006b97          	auipc	s7,0x6
    80001a8e:	6ceb8b93          	addi	s7,s7,1742 # 80008158 <states.1754>
    80001a92:	a015                	j	80001ab6 <procdump+0x7c>
    printf("%d %s %s", p->pid, state, p->name);
    80001a94:	86ba                	mv	a3,a4
    80001a96:	ed872583          	lw	a1,-296(a4)
    80001a9a:	8556                	mv	a0,s5
    80001a9c:	00004097          	auipc	ra,0x4
    80001aa0:	3da080e7          	jalr	986(ra) # 80005e76 <printf>
    printf("\n");
    80001aa4:	8552                	mv	a0,s4
    80001aa6:	00004097          	auipc	ra,0x4
    80001aaa:	3d0080e7          	jalr	976(ra) # 80005e76 <printf>
    80001aae:	17048493          	addi	s1,s1,368
  for(p = proc; p < &proc[NPROC]; p++){
    80001ab2:	03248163          	beq	s1,s2,80001ad4 <procdump+0x9a>
    if(p->state == UNUSED)
    80001ab6:	8726                	mv	a4,s1
    80001ab8:	ec04a783          	lw	a5,-320(s1)
    80001abc:	dbed                	beqz	a5,80001aae <procdump+0x74>
      state = "???";
    80001abe:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001ac0:	fcfb6ae3          	bltu	s6,a5,80001a94 <procdump+0x5a>
    80001ac4:	1782                	slli	a5,a5,0x20
    80001ac6:	9381                	srli	a5,a5,0x20
    80001ac8:	078e                	slli	a5,a5,0x3
    80001aca:	97de                	add	a5,a5,s7
    80001acc:	6390                	ld	a2,0(a5)
    80001ace:	f279                	bnez	a2,80001a94 <procdump+0x5a>
      state = "???";
    80001ad0:	864e                	mv	a2,s3
    80001ad2:	b7c9                	j	80001a94 <procdump+0x5a>
  }
}
    80001ad4:	60a6                	ld	ra,72(sp)
    80001ad6:	6406                	ld	s0,64(sp)
    80001ad8:	74e2                	ld	s1,56(sp)
    80001ada:	7942                	ld	s2,48(sp)
    80001adc:	79a2                	ld	s3,40(sp)
    80001ade:	7a02                	ld	s4,32(sp)
    80001ae0:	6ae2                	ld	s5,24(sp)
    80001ae2:	6b42                	ld	s6,16(sp)
    80001ae4:	6ba2                	ld	s7,8(sp)
    80001ae6:	6161                	addi	sp,sp,80
    80001ae8:	8082                	ret

0000000080001aea <trace>:

int trace(int mask)
{
    80001aea:	1101                	addi	sp,sp,-32
    80001aec:	ec06                	sd	ra,24(sp)
    80001aee:	e822                	sd	s0,16(sp)
    80001af0:	e426                	sd	s1,8(sp)
    80001af2:	1000                	addi	s0,sp,32
    80001af4:	84aa                	mv	s1,a0
  myproc()->trace_mask = mask;
    80001af6:	fffff097          	auipc	ra,0xfffff
    80001afa:	3de080e7          	jalr	990(ra) # 80000ed4 <myproc>
    80001afe:	16952423          	sw	s1,360(a0)
  return 0;
}
    80001b02:	4501                	li	a0,0
    80001b04:	60e2                	ld	ra,24(sp)
    80001b06:	6442                	ld	s0,16(sp)
    80001b08:	64a2                	ld	s1,8(sp)
    80001b0a:	6105                	addi	sp,sp,32
    80001b0c:	8082                	ret

0000000080001b0e <sysinfo>:

int sysinfo(struct sysinfo *info)
{
    80001b0e:	1101                	addi	sp,sp,-32
    80001b10:	ec06                	sd	ra,24(sp)
    80001b12:	e822                	sd	s0,16(sp)
    80001b14:	e426                	sd	s1,8(sp)
    80001b16:	1000                	addi	s0,sp,32
    80001b18:	84aa                	mv	s1,a0
  info->freemem = kfreemem();
    80001b1a:	ffffe097          	auipc	ra,0xffffe
    80001b1e:	660080e7          	jalr	1632(ra) # 8000017a <kfreemem>
    80001b22:	e088                	sd	a0,0(s1)
  info->nproc = 0;
    80001b24:	0004b423          	sd	zero,8(s1)
  for (int i = 0; i < NPROC; i++) {
    80001b28:	00007797          	auipc	a5,0x7
    80001b2c:	3d078793          	addi	a5,a5,976 # 80008ef8 <proc+0x18>
    80001b30:	0000d697          	auipc	a3,0xd
    80001b34:	fc868693          	addi	a3,a3,-56 # 8000eaf8 <bcache>
    80001b38:	a029                	j	80001b42 <sysinfo+0x34>
    80001b3a:	17078793          	addi	a5,a5,368
    80001b3e:	00d78863          	beq	a5,a3,80001b4e <sysinfo+0x40>
    if (proc[i].state != UNUSED)
    80001b42:	4398                	lw	a4,0(a5)
    80001b44:	db7d                	beqz	a4,80001b3a <sysinfo+0x2c>
      info->nproc++;
    80001b46:	6498                	ld	a4,8(s1)
    80001b48:	0705                	addi	a4,a4,1
    80001b4a:	e498                	sd	a4,8(s1)
    80001b4c:	b7fd                	j	80001b3a <sysinfo+0x2c>
  }
  return 0;
    80001b4e:	4501                	li	a0,0
    80001b50:	60e2                	ld	ra,24(sp)
    80001b52:	6442                	ld	s0,16(sp)
    80001b54:	64a2                	ld	s1,8(sp)
    80001b56:	6105                	addi	sp,sp,32
    80001b58:	8082                	ret

0000000080001b5a <swtch>:
    80001b5a:	00153023          	sd	ra,0(a0)
    80001b5e:	00253423          	sd	sp,8(a0)
    80001b62:	e900                	sd	s0,16(a0)
    80001b64:	ed04                	sd	s1,24(a0)
    80001b66:	03253023          	sd	s2,32(a0)
    80001b6a:	03353423          	sd	s3,40(a0)
    80001b6e:	03453823          	sd	s4,48(a0)
    80001b72:	03553c23          	sd	s5,56(a0)
    80001b76:	05653023          	sd	s6,64(a0)
    80001b7a:	05753423          	sd	s7,72(a0)
    80001b7e:	05853823          	sd	s8,80(a0)
    80001b82:	05953c23          	sd	s9,88(a0)
    80001b86:	07a53023          	sd	s10,96(a0)
    80001b8a:	07b53423          	sd	s11,104(a0)
    80001b8e:	0005b083          	ld	ra,0(a1)
    80001b92:	0085b103          	ld	sp,8(a1)
    80001b96:	6980                	ld	s0,16(a1)
    80001b98:	6d84                	ld	s1,24(a1)
    80001b9a:	0205b903          	ld	s2,32(a1)
    80001b9e:	0285b983          	ld	s3,40(a1)
    80001ba2:	0305ba03          	ld	s4,48(a1)
    80001ba6:	0385ba83          	ld	s5,56(a1)
    80001baa:	0405bb03          	ld	s6,64(a1)
    80001bae:	0485bb83          	ld	s7,72(a1)
    80001bb2:	0505bc03          	ld	s8,80(a1)
    80001bb6:	0585bc83          	ld	s9,88(a1)
    80001bba:	0605bd03          	ld	s10,96(a1)
    80001bbe:	0685bd83          	ld	s11,104(a1)
    80001bc2:	8082                	ret

0000000080001bc4 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001bc4:	1141                	addi	sp,sp,-16
    80001bc6:	e406                	sd	ra,8(sp)
    80001bc8:	e022                	sd	s0,0(sp)
    80001bca:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001bcc:	00006597          	auipc	a1,0x6
    80001bd0:	6ac58593          	addi	a1,a1,1708 # 80008278 <states.1754+0x120>
    80001bd4:	0000d517          	auipc	a0,0xd
    80001bd8:	f0c50513          	addi	a0,a0,-244 # 8000eae0 <tickslock>
    80001bdc:	00004097          	auipc	ra,0x4
    80001be0:	728080e7          	jalr	1832(ra) # 80006304 <initlock>
}
    80001be4:	60a2                	ld	ra,8(sp)
    80001be6:	6402                	ld	s0,0(sp)
    80001be8:	0141                	addi	sp,sp,16
    80001bea:	8082                	ret

0000000080001bec <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001bec:	1141                	addi	sp,sp,-16
    80001bee:	e422                	sd	s0,8(sp)
    80001bf0:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001bf2:	00003797          	auipc	a5,0x3
    80001bf6:	61e78793          	addi	a5,a5,1566 # 80005210 <kernelvec>
    80001bfa:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001bfe:	6422                	ld	s0,8(sp)
    80001c00:	0141                	addi	sp,sp,16
    80001c02:	8082                	ret

0000000080001c04 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001c04:	1141                	addi	sp,sp,-16
    80001c06:	e406                	sd	ra,8(sp)
    80001c08:	e022                	sd	s0,0(sp)
    80001c0a:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80001c0c:	fffff097          	auipc	ra,0xfffff
    80001c10:	2c8080e7          	jalr	712(ra) # 80000ed4 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001c14:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001c18:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001c1a:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    80001c1e:	00005617          	auipc	a2,0x5
    80001c22:	3e260613          	addi	a2,a2,994 # 80007000 <_trampoline>
    80001c26:	00005697          	auipc	a3,0x5
    80001c2a:	3da68693          	addi	a3,a3,986 # 80007000 <_trampoline>
    80001c2e:	8e91                	sub	a3,a3,a2
    80001c30:	040007b7          	lui	a5,0x4000
    80001c34:	17fd                	addi	a5,a5,-1
    80001c36:	07b2                	slli	a5,a5,0xc
    80001c38:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001c3a:	10569073          	csrw	stvec,a3
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80001c3e:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80001c40:	180026f3          	csrr	a3,satp
    80001c44:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001c46:	6d38                	ld	a4,88(a0)
    80001c48:	6134                	ld	a3,64(a0)
    80001c4a:	6585                	lui	a1,0x1
    80001c4c:	96ae                	add	a3,a3,a1
    80001c4e:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001c50:	6d38                	ld	a4,88(a0)
    80001c52:	00000697          	auipc	a3,0x0
    80001c56:	13068693          	addi	a3,a3,304 # 80001d82 <usertrap>
    80001c5a:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80001c5c:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80001c5e:	8692                	mv	a3,tp
    80001c60:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001c62:	100026f3          	csrr	a3,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80001c66:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001c6a:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001c6e:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001c72:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001c74:	6f18                	ld	a4,24(a4)
    80001c76:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80001c7a:	6928                	ld	a0,80(a0)
    80001c7c:	8131                	srli	a0,a0,0xc

  // jump to userret in trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80001c7e:	00005717          	auipc	a4,0x5
    80001c82:	42270713          	addi	a4,a4,1058 # 800070a0 <userret>
    80001c86:	8f11                	sub	a4,a4,a2
    80001c88:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    80001c8a:	577d                	li	a4,-1
    80001c8c:	177e                	slli	a4,a4,0x3f
    80001c8e:	8d59                	or	a0,a0,a4
    80001c90:	9782                	jalr	a5
}
    80001c92:	60a2                	ld	ra,8(sp)
    80001c94:	6402                	ld	s0,0(sp)
    80001c96:	0141                	addi	sp,sp,16
    80001c98:	8082                	ret

0000000080001c9a <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80001c9a:	1101                	addi	sp,sp,-32
    80001c9c:	ec06                	sd	ra,24(sp)
    80001c9e:	e822                	sd	s0,16(sp)
    80001ca0:	e426                	sd	s1,8(sp)
    80001ca2:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    80001ca4:	0000d497          	auipc	s1,0xd
    80001ca8:	e3c48493          	addi	s1,s1,-452 # 8000eae0 <tickslock>
    80001cac:	8526                	mv	a0,s1
    80001cae:	00004097          	auipc	ra,0x4
    80001cb2:	6e6080e7          	jalr	1766(ra) # 80006394 <acquire>
  ticks++;
    80001cb6:	00007517          	auipc	a0,0x7
    80001cba:	dc250513          	addi	a0,a0,-574 # 80008a78 <ticks>
    80001cbe:	411c                	lw	a5,0(a0)
    80001cc0:	2785                	addiw	a5,a5,1
    80001cc2:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80001cc4:	00000097          	auipc	ra,0x0
    80001cc8:	924080e7          	jalr	-1756(ra) # 800015e8 <wakeup>
  release(&tickslock);
    80001ccc:	8526                	mv	a0,s1
    80001cce:	00004097          	auipc	ra,0x4
    80001cd2:	77a080e7          	jalr	1914(ra) # 80006448 <release>
}
    80001cd6:	60e2                	ld	ra,24(sp)
    80001cd8:	6442                	ld	s0,16(sp)
    80001cda:	64a2                	ld	s1,8(sp)
    80001cdc:	6105                	addi	sp,sp,32
    80001cde:	8082                	ret

0000000080001ce0 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80001ce0:	1101                	addi	sp,sp,-32
    80001ce2:	ec06                	sd	ra,24(sp)
    80001ce4:	e822                	sd	s0,16(sp)
    80001ce6:	e426                	sd	s1,8(sp)
    80001ce8:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001cea:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    80001cee:	00074d63          	bltz	a4,80001d08 <devintr+0x28>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000001L){
    80001cf2:	57fd                	li	a5,-1
    80001cf4:	17fe                	slli	a5,a5,0x3f
    80001cf6:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80001cf8:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80001cfa:	06f70363          	beq	a4,a5,80001d60 <devintr+0x80>
  }
}
    80001cfe:	60e2                	ld	ra,24(sp)
    80001d00:	6442                	ld	s0,16(sp)
    80001d02:	64a2                	ld	s1,8(sp)
    80001d04:	6105                	addi	sp,sp,32
    80001d06:	8082                	ret
     (scause & 0xff) == 9){
    80001d08:	0ff77793          	andi	a5,a4,255
  if((scause & 0x8000000000000000L) &&
    80001d0c:	46a5                	li	a3,9
    80001d0e:	fed792e3          	bne	a5,a3,80001cf2 <devintr+0x12>
    int irq = plic_claim();
    80001d12:	00003097          	auipc	ra,0x3
    80001d16:	606080e7          	jalr	1542(ra) # 80005318 <plic_claim>
    80001d1a:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001d1c:	47a9                	li	a5,10
    80001d1e:	02f50763          	beq	a0,a5,80001d4c <devintr+0x6c>
    } else if(irq == VIRTIO0_IRQ){
    80001d22:	4785                	li	a5,1
    80001d24:	02f50963          	beq	a0,a5,80001d56 <devintr+0x76>
    return 1;
    80001d28:	4505                	li	a0,1
    } else if(irq){
    80001d2a:	d8f1                	beqz	s1,80001cfe <devintr+0x1e>
      printf("unexpected interrupt irq=%d\n", irq);
    80001d2c:	85a6                	mv	a1,s1
    80001d2e:	00006517          	auipc	a0,0x6
    80001d32:	55250513          	addi	a0,a0,1362 # 80008280 <states.1754+0x128>
    80001d36:	00004097          	auipc	ra,0x4
    80001d3a:	140080e7          	jalr	320(ra) # 80005e76 <printf>
      plic_complete(irq);
    80001d3e:	8526                	mv	a0,s1
    80001d40:	00003097          	auipc	ra,0x3
    80001d44:	5fc080e7          	jalr	1532(ra) # 8000533c <plic_complete>
    return 1;
    80001d48:	4505                	li	a0,1
    80001d4a:	bf55                	j	80001cfe <devintr+0x1e>
      uartintr();
    80001d4c:	00004097          	auipc	ra,0x4
    80001d50:	568080e7          	jalr	1384(ra) # 800062b4 <uartintr>
    80001d54:	b7ed                	j	80001d3e <devintr+0x5e>
      virtio_disk_intr();
    80001d56:	00004097          	auipc	ra,0x4
    80001d5a:	ad4080e7          	jalr	-1324(ra) # 8000582a <virtio_disk_intr>
    80001d5e:	b7c5                	j	80001d3e <devintr+0x5e>
    if(cpuid() == 0){
    80001d60:	fffff097          	auipc	ra,0xfffff
    80001d64:	148080e7          	jalr	328(ra) # 80000ea8 <cpuid>
    80001d68:	c901                	beqz	a0,80001d78 <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80001d6a:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80001d6e:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80001d70:	14479073          	csrw	sip,a5
    return 2;
    80001d74:	4509                	li	a0,2
    80001d76:	b761                	j	80001cfe <devintr+0x1e>
      clockintr();
    80001d78:	00000097          	auipc	ra,0x0
    80001d7c:	f22080e7          	jalr	-222(ra) # 80001c9a <clockintr>
    80001d80:	b7ed                	j	80001d6a <devintr+0x8a>

0000000080001d82 <usertrap>:
{
    80001d82:	1101                	addi	sp,sp,-32
    80001d84:	ec06                	sd	ra,24(sp)
    80001d86:	e822                	sd	s0,16(sp)
    80001d88:	e426                	sd	s1,8(sp)
    80001d8a:	e04a                	sd	s2,0(sp)
    80001d8c:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001d8e:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80001d92:	1007f793          	andi	a5,a5,256
    80001d96:	e3b1                	bnez	a5,80001dda <usertrap+0x58>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001d98:	00003797          	auipc	a5,0x3
    80001d9c:	47878793          	addi	a5,a5,1144 # 80005210 <kernelvec>
    80001da0:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001da4:	fffff097          	auipc	ra,0xfffff
    80001da8:	130080e7          	jalr	304(ra) # 80000ed4 <myproc>
    80001dac:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001dae:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001db0:	14102773          	csrr	a4,sepc
    80001db4:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001db6:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80001dba:	47a1                	li	a5,8
    80001dbc:	02f70763          	beq	a4,a5,80001dea <usertrap+0x68>
  } else if((which_dev = devintr()) != 0){
    80001dc0:	00000097          	auipc	ra,0x0
    80001dc4:	f20080e7          	jalr	-224(ra) # 80001ce0 <devintr>
    80001dc8:	892a                	mv	s2,a0
    80001dca:	c151                	beqz	a0,80001e4e <usertrap+0xcc>
  if(killed(p))
    80001dcc:	8526                	mv	a0,s1
    80001dce:	00000097          	auipc	ra,0x0
    80001dd2:	a60080e7          	jalr	-1440(ra) # 8000182e <killed>
    80001dd6:	c929                	beqz	a0,80001e28 <usertrap+0xa6>
    80001dd8:	a099                	j	80001e1e <usertrap+0x9c>
    panic("usertrap: not from user mode");
    80001dda:	00006517          	auipc	a0,0x6
    80001dde:	4c650513          	addi	a0,a0,1222 # 800082a0 <states.1754+0x148>
    80001de2:	00004097          	auipc	ra,0x4
    80001de6:	04a080e7          	jalr	74(ra) # 80005e2c <panic>
    if(killed(p))
    80001dea:	00000097          	auipc	ra,0x0
    80001dee:	a44080e7          	jalr	-1468(ra) # 8000182e <killed>
    80001df2:	e921                	bnez	a0,80001e42 <usertrap+0xc0>
    p->trapframe->epc += 4;
    80001df4:	6cb8                	ld	a4,88(s1)
    80001df6:	6f1c                	ld	a5,24(a4)
    80001df8:	0791                	addi	a5,a5,4
    80001dfa:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001dfc:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001e00:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001e04:	10079073          	csrw	sstatus,a5
    syscall();
    80001e08:	00000097          	auipc	ra,0x0
    80001e0c:	2d4080e7          	jalr	724(ra) # 800020dc <syscall>
  if(killed(p))
    80001e10:	8526                	mv	a0,s1
    80001e12:	00000097          	auipc	ra,0x0
    80001e16:	a1c080e7          	jalr	-1508(ra) # 8000182e <killed>
    80001e1a:	c911                	beqz	a0,80001e2e <usertrap+0xac>
    80001e1c:	4901                	li	s2,0
    exit(-1);
    80001e1e:	557d                	li	a0,-1
    80001e20:	00000097          	auipc	ra,0x0
    80001e24:	898080e7          	jalr	-1896(ra) # 800016b8 <exit>
  if(which_dev == 2)
    80001e28:	4789                	li	a5,2
    80001e2a:	04f90f63          	beq	s2,a5,80001e88 <usertrap+0x106>
  usertrapret();
    80001e2e:	00000097          	auipc	ra,0x0
    80001e32:	dd6080e7          	jalr	-554(ra) # 80001c04 <usertrapret>
}
    80001e36:	60e2                	ld	ra,24(sp)
    80001e38:	6442                	ld	s0,16(sp)
    80001e3a:	64a2                	ld	s1,8(sp)
    80001e3c:	6902                	ld	s2,0(sp)
    80001e3e:	6105                	addi	sp,sp,32
    80001e40:	8082                	ret
      exit(-1);
    80001e42:	557d                	li	a0,-1
    80001e44:	00000097          	auipc	ra,0x0
    80001e48:	874080e7          	jalr	-1932(ra) # 800016b8 <exit>
    80001e4c:	b765                	j	80001df4 <usertrap+0x72>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001e4e:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80001e52:	5890                	lw	a2,48(s1)
    80001e54:	00006517          	auipc	a0,0x6
    80001e58:	46c50513          	addi	a0,a0,1132 # 800082c0 <states.1754+0x168>
    80001e5c:	00004097          	auipc	ra,0x4
    80001e60:	01a080e7          	jalr	26(ra) # 80005e76 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001e64:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001e68:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001e6c:	00006517          	auipc	a0,0x6
    80001e70:	48450513          	addi	a0,a0,1156 # 800082f0 <states.1754+0x198>
    80001e74:	00004097          	auipc	ra,0x4
    80001e78:	002080e7          	jalr	2(ra) # 80005e76 <printf>
    setkilled(p);
    80001e7c:	8526                	mv	a0,s1
    80001e7e:	00000097          	auipc	ra,0x0
    80001e82:	984080e7          	jalr	-1660(ra) # 80001802 <setkilled>
    80001e86:	b769                	j	80001e10 <usertrap+0x8e>
    yield();
    80001e88:	fffff097          	auipc	ra,0xfffff
    80001e8c:	6c0080e7          	jalr	1728(ra) # 80001548 <yield>
    80001e90:	bf79                	j	80001e2e <usertrap+0xac>

0000000080001e92 <kerneltrap>:
{
    80001e92:	7179                	addi	sp,sp,-48
    80001e94:	f406                	sd	ra,40(sp)
    80001e96:	f022                	sd	s0,32(sp)
    80001e98:	ec26                	sd	s1,24(sp)
    80001e9a:	e84a                	sd	s2,16(sp)
    80001e9c:	e44e                	sd	s3,8(sp)
    80001e9e:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001ea0:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001ea4:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001ea8:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80001eac:	1004f793          	andi	a5,s1,256
    80001eb0:	cb85                	beqz	a5,80001ee0 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001eb2:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001eb6:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80001eb8:	ef85                	bnez	a5,80001ef0 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80001eba:	00000097          	auipc	ra,0x0
    80001ebe:	e26080e7          	jalr	-474(ra) # 80001ce0 <devintr>
    80001ec2:	cd1d                	beqz	a0,80001f00 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001ec4:	4789                	li	a5,2
    80001ec6:	06f50a63          	beq	a0,a5,80001f3a <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001eca:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001ece:	10049073          	csrw	sstatus,s1
}
    80001ed2:	70a2                	ld	ra,40(sp)
    80001ed4:	7402                	ld	s0,32(sp)
    80001ed6:	64e2                	ld	s1,24(sp)
    80001ed8:	6942                	ld	s2,16(sp)
    80001eda:	69a2                	ld	s3,8(sp)
    80001edc:	6145                	addi	sp,sp,48
    80001ede:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001ee0:	00006517          	auipc	a0,0x6
    80001ee4:	43050513          	addi	a0,a0,1072 # 80008310 <states.1754+0x1b8>
    80001ee8:	00004097          	auipc	ra,0x4
    80001eec:	f44080e7          	jalr	-188(ra) # 80005e2c <panic>
    panic("kerneltrap: interrupts enabled");
    80001ef0:	00006517          	auipc	a0,0x6
    80001ef4:	44850513          	addi	a0,a0,1096 # 80008338 <states.1754+0x1e0>
    80001ef8:	00004097          	auipc	ra,0x4
    80001efc:	f34080e7          	jalr	-204(ra) # 80005e2c <panic>
    printf("scause %p\n", scause);
    80001f00:	85ce                	mv	a1,s3
    80001f02:	00006517          	auipc	a0,0x6
    80001f06:	45650513          	addi	a0,a0,1110 # 80008358 <states.1754+0x200>
    80001f0a:	00004097          	auipc	ra,0x4
    80001f0e:	f6c080e7          	jalr	-148(ra) # 80005e76 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001f12:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001f16:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001f1a:	00006517          	auipc	a0,0x6
    80001f1e:	44e50513          	addi	a0,a0,1102 # 80008368 <states.1754+0x210>
    80001f22:	00004097          	auipc	ra,0x4
    80001f26:	f54080e7          	jalr	-172(ra) # 80005e76 <printf>
    panic("kerneltrap");
    80001f2a:	00006517          	auipc	a0,0x6
    80001f2e:	45650513          	addi	a0,a0,1110 # 80008380 <states.1754+0x228>
    80001f32:	00004097          	auipc	ra,0x4
    80001f36:	efa080e7          	jalr	-262(ra) # 80005e2c <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001f3a:	fffff097          	auipc	ra,0xfffff
    80001f3e:	f9a080e7          	jalr	-102(ra) # 80000ed4 <myproc>
    80001f42:	d541                	beqz	a0,80001eca <kerneltrap+0x38>
    80001f44:	fffff097          	auipc	ra,0xfffff
    80001f48:	f90080e7          	jalr	-112(ra) # 80000ed4 <myproc>
    80001f4c:	4d18                	lw	a4,24(a0)
    80001f4e:	4791                	li	a5,4
    80001f50:	f6f71de3          	bne	a4,a5,80001eca <kerneltrap+0x38>
    yield();
    80001f54:	fffff097          	auipc	ra,0xfffff
    80001f58:	5f4080e7          	jalr	1524(ra) # 80001548 <yield>
    80001f5c:	b7bd                	j	80001eca <kerneltrap+0x38>

0000000080001f5e <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80001f5e:	1101                	addi	sp,sp,-32
    80001f60:	ec06                	sd	ra,24(sp)
    80001f62:	e822                	sd	s0,16(sp)
    80001f64:	e426                	sd	s1,8(sp)
    80001f66:	1000                	addi	s0,sp,32
    80001f68:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001f6a:	fffff097          	auipc	ra,0xfffff
    80001f6e:	f6a080e7          	jalr	-150(ra) # 80000ed4 <myproc>
  switch (n) {
    80001f72:	4795                	li	a5,5
    80001f74:	0497e163          	bltu	a5,s1,80001fb6 <argraw+0x58>
    80001f78:	048a                	slli	s1,s1,0x2
    80001f7a:	00006717          	auipc	a4,0x6
    80001f7e:	41670713          	addi	a4,a4,1046 # 80008390 <states.1754+0x238>
    80001f82:	94ba                	add	s1,s1,a4
    80001f84:	409c                	lw	a5,0(s1)
    80001f86:	97ba                	add	a5,a5,a4
    80001f88:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80001f8a:	6d3c                	ld	a5,88(a0)
    80001f8c:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80001f8e:	60e2                	ld	ra,24(sp)
    80001f90:	6442                	ld	s0,16(sp)
    80001f92:	64a2                	ld	s1,8(sp)
    80001f94:	6105                	addi	sp,sp,32
    80001f96:	8082                	ret
    return p->trapframe->a1;
    80001f98:	6d3c                	ld	a5,88(a0)
    80001f9a:	7fa8                	ld	a0,120(a5)
    80001f9c:	bfcd                	j	80001f8e <argraw+0x30>
    return p->trapframe->a2;
    80001f9e:	6d3c                	ld	a5,88(a0)
    80001fa0:	63c8                	ld	a0,128(a5)
    80001fa2:	b7f5                	j	80001f8e <argraw+0x30>
    return p->trapframe->a3;
    80001fa4:	6d3c                	ld	a5,88(a0)
    80001fa6:	67c8                	ld	a0,136(a5)
    80001fa8:	b7dd                	j	80001f8e <argraw+0x30>
    return p->trapframe->a4;
    80001faa:	6d3c                	ld	a5,88(a0)
    80001fac:	6bc8                	ld	a0,144(a5)
    80001fae:	b7c5                	j	80001f8e <argraw+0x30>
    return p->trapframe->a5;
    80001fb0:	6d3c                	ld	a5,88(a0)
    80001fb2:	6fc8                	ld	a0,152(a5)
    80001fb4:	bfe9                	j	80001f8e <argraw+0x30>
  panic("argraw");
    80001fb6:	00006517          	auipc	a0,0x6
    80001fba:	5aa50513          	addi	a0,a0,1450 # 80008560 <str_syscalls+0xc0>
    80001fbe:	00004097          	auipc	ra,0x4
    80001fc2:	e6e080e7          	jalr	-402(ra) # 80005e2c <panic>

0000000080001fc6 <fetchaddr>:
{
    80001fc6:	1101                	addi	sp,sp,-32
    80001fc8:	ec06                	sd	ra,24(sp)
    80001fca:	e822                	sd	s0,16(sp)
    80001fcc:	e426                	sd	s1,8(sp)
    80001fce:	e04a                	sd	s2,0(sp)
    80001fd0:	1000                	addi	s0,sp,32
    80001fd2:	84aa                	mv	s1,a0
    80001fd4:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001fd6:	fffff097          	auipc	ra,0xfffff
    80001fda:	efe080e7          	jalr	-258(ra) # 80000ed4 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    80001fde:	653c                	ld	a5,72(a0)
    80001fe0:	02f4f863          	bgeu	s1,a5,80002010 <fetchaddr+0x4a>
    80001fe4:	00848713          	addi	a4,s1,8
    80001fe8:	02e7e663          	bltu	a5,a4,80002014 <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80001fec:	46a1                	li	a3,8
    80001fee:	8626                	mv	a2,s1
    80001ff0:	85ca                	mv	a1,s2
    80001ff2:	6928                	ld	a0,80(a0)
    80001ff4:	fffff097          	auipc	ra,0xfffff
    80001ff8:	c1a080e7          	jalr	-998(ra) # 80000c0e <copyin>
    80001ffc:	00a03533          	snez	a0,a0
    80002000:	40a00533          	neg	a0,a0
}
    80002004:	60e2                	ld	ra,24(sp)
    80002006:	6442                	ld	s0,16(sp)
    80002008:	64a2                	ld	s1,8(sp)
    8000200a:	6902                	ld	s2,0(sp)
    8000200c:	6105                	addi	sp,sp,32
    8000200e:	8082                	ret
    return -1;
    80002010:	557d                	li	a0,-1
    80002012:	bfcd                	j	80002004 <fetchaddr+0x3e>
    80002014:	557d                	li	a0,-1
    80002016:	b7fd                	j	80002004 <fetchaddr+0x3e>

0000000080002018 <fetchstr>:
{
    80002018:	7179                	addi	sp,sp,-48
    8000201a:	f406                	sd	ra,40(sp)
    8000201c:	f022                	sd	s0,32(sp)
    8000201e:	ec26                	sd	s1,24(sp)
    80002020:	e84a                	sd	s2,16(sp)
    80002022:	e44e                	sd	s3,8(sp)
    80002024:	1800                	addi	s0,sp,48
    80002026:	892a                	mv	s2,a0
    80002028:	84ae                	mv	s1,a1
    8000202a:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    8000202c:	fffff097          	auipc	ra,0xfffff
    80002030:	ea8080e7          	jalr	-344(ra) # 80000ed4 <myproc>
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    80002034:	86ce                	mv	a3,s3
    80002036:	864a                	mv	a2,s2
    80002038:	85a6                	mv	a1,s1
    8000203a:	6928                	ld	a0,80(a0)
    8000203c:	fffff097          	auipc	ra,0xfffff
    80002040:	c60080e7          	jalr	-928(ra) # 80000c9c <copyinstr>
    80002044:	00054e63          	bltz	a0,80002060 <fetchstr+0x48>
  return strlen(buf);
    80002048:	8526                	mv	a0,s1
    8000204a:	ffffe097          	auipc	ra,0xffffe
    8000204e:	320080e7          	jalr	800(ra) # 8000036a <strlen>
}
    80002052:	70a2                	ld	ra,40(sp)
    80002054:	7402                	ld	s0,32(sp)
    80002056:	64e2                	ld	s1,24(sp)
    80002058:	6942                	ld	s2,16(sp)
    8000205a:	69a2                	ld	s3,8(sp)
    8000205c:	6145                	addi	sp,sp,48
    8000205e:	8082                	ret
    return -1;
    80002060:	557d                	li	a0,-1
    80002062:	bfc5                	j	80002052 <fetchstr+0x3a>

0000000080002064 <argint>:

// Fetch the nth 32-bit system call argument.
void
argint(int n, int *ip)
{
    80002064:	1101                	addi	sp,sp,-32
    80002066:	ec06                	sd	ra,24(sp)
    80002068:	e822                	sd	s0,16(sp)
    8000206a:	e426                	sd	s1,8(sp)
    8000206c:	1000                	addi	s0,sp,32
    8000206e:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002070:	00000097          	auipc	ra,0x0
    80002074:	eee080e7          	jalr	-274(ra) # 80001f5e <argraw>
    80002078:	c088                	sw	a0,0(s1)
}
    8000207a:	60e2                	ld	ra,24(sp)
    8000207c:	6442                	ld	s0,16(sp)
    8000207e:	64a2                	ld	s1,8(sp)
    80002080:	6105                	addi	sp,sp,32
    80002082:	8082                	ret

0000000080002084 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr(int n, uint64 *ip)
{
    80002084:	1101                	addi	sp,sp,-32
    80002086:	ec06                	sd	ra,24(sp)
    80002088:	e822                	sd	s0,16(sp)
    8000208a:	e426                	sd	s1,8(sp)
    8000208c:	1000                	addi	s0,sp,32
    8000208e:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002090:	00000097          	auipc	ra,0x0
    80002094:	ece080e7          	jalr	-306(ra) # 80001f5e <argraw>
    80002098:	e088                	sd	a0,0(s1)
}
    8000209a:	60e2                	ld	ra,24(sp)
    8000209c:	6442                	ld	s0,16(sp)
    8000209e:	64a2                	ld	s1,8(sp)
    800020a0:	6105                	addi	sp,sp,32
    800020a2:	8082                	ret

00000000800020a4 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    800020a4:	7179                	addi	sp,sp,-48
    800020a6:	f406                	sd	ra,40(sp)
    800020a8:	f022                	sd	s0,32(sp)
    800020aa:	ec26                	sd	s1,24(sp)
    800020ac:	e84a                	sd	s2,16(sp)
    800020ae:	1800                	addi	s0,sp,48
    800020b0:	84ae                	mv	s1,a1
    800020b2:	8932                	mv	s2,a2
  uint64 addr;
  argaddr(n, &addr);
    800020b4:	fd840593          	addi	a1,s0,-40
    800020b8:	00000097          	auipc	ra,0x0
    800020bc:	fcc080e7          	jalr	-52(ra) # 80002084 <argaddr>
  return fetchstr(addr, buf, max);
    800020c0:	864a                	mv	a2,s2
    800020c2:	85a6                	mv	a1,s1
    800020c4:	fd843503          	ld	a0,-40(s0)
    800020c8:	00000097          	auipc	ra,0x0
    800020cc:	f50080e7          	jalr	-176(ra) # 80002018 <fetchstr>
}
    800020d0:	70a2                	ld	ra,40(sp)
    800020d2:	7402                	ld	s0,32(sp)
    800020d4:	64e2                	ld	s1,24(sp)
    800020d6:	6942                	ld	s2,16(sp)
    800020d8:	6145                	addi	sp,sp,48
    800020da:	8082                	ret

00000000800020dc <syscall>:
[SYS_sysinfo]   "sysinfo",
};

void
syscall(void)
{
    800020dc:	7179                	addi	sp,sp,-48
    800020de:	f406                	sd	ra,40(sp)
    800020e0:	f022                	sd	s0,32(sp)
    800020e2:	ec26                	sd	s1,24(sp)
    800020e4:	e84a                	sd	s2,16(sp)
    800020e6:	e44e                	sd	s3,8(sp)
    800020e8:	1800                	addi	s0,sp,48
  int num;
  struct proc *p = myproc();
    800020ea:	fffff097          	auipc	ra,0xfffff
    800020ee:	dea080e7          	jalr	-534(ra) # 80000ed4 <myproc>
    800020f2:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    800020f4:	05853983          	ld	s3,88(a0)
    800020f8:	0a89b783          	ld	a5,168(s3)
    800020fc:	0007891b          	sext.w	s2,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002100:	37fd                	addiw	a5,a5,-1
    80002102:	4775                	li	a4,29
    80002104:	04f76863          	bltu	a4,a5,80002154 <syscall+0x78>
    80002108:	00391713          	slli	a4,s2,0x3
    8000210c:	00006797          	auipc	a5,0x6
    80002110:	29c78793          	addi	a5,a5,668 # 800083a8 <syscalls>
    80002114:	97ba                	add	a5,a5,a4
    80002116:	639c                	ld	a5,0(a5)
    80002118:	cf95                	beqz	a5,80002154 <syscall+0x78>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    8000211a:	9782                	jalr	a5
    8000211c:	06a9b823          	sd	a0,112(s3)
    if (1 << num & p->trace_mask)
    80002120:	1684a783          	lw	a5,360(s1)
    80002124:	4127d7bb          	sraw	a5,a5,s2
    80002128:	8b85                	andi	a5,a5,1
    8000212a:	c7a1                	beqz	a5,80002172 <syscall+0x96>
      printf("%d: syscall %s -> %d\n", p->pid, str_syscalls[num], p->trapframe->a0);
    8000212c:	6cb8                	ld	a4,88(s1)
    8000212e:	090e                	slli	s2,s2,0x3
    80002130:	00006797          	auipc	a5,0x6
    80002134:	27878793          	addi	a5,a5,632 # 800083a8 <syscalls>
    80002138:	993e                	add	s2,s2,a5
    8000213a:	7b34                	ld	a3,112(a4)
    8000213c:	0f893603          	ld	a2,248(s2)
    80002140:	588c                	lw	a1,48(s1)
    80002142:	00006517          	auipc	a0,0x6
    80002146:	42650513          	addi	a0,a0,1062 # 80008568 <str_syscalls+0xc8>
    8000214a:	00004097          	auipc	ra,0x4
    8000214e:	d2c080e7          	jalr	-724(ra) # 80005e76 <printf>
    80002152:	a005                	j	80002172 <syscall+0x96>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80002154:	86ca                	mv	a3,s2
    80002156:	15848613          	addi	a2,s1,344
    8000215a:	588c                	lw	a1,48(s1)
    8000215c:	00006517          	auipc	a0,0x6
    80002160:	42450513          	addi	a0,a0,1060 # 80008580 <str_syscalls+0xe0>
    80002164:	00004097          	auipc	ra,0x4
    80002168:	d12080e7          	jalr	-750(ra) # 80005e76 <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    8000216c:	6cbc                	ld	a5,88(s1)
    8000216e:	577d                	li	a4,-1
    80002170:	fbb8                	sd	a4,112(a5)
  }
}
    80002172:	70a2                	ld	ra,40(sp)
    80002174:	7402                	ld	s0,32(sp)
    80002176:	64e2                	ld	s1,24(sp)
    80002178:	6942                	ld	s2,16(sp)
    8000217a:	69a2                	ld	s3,8(sp)
    8000217c:	6145                	addi	sp,sp,48
    8000217e:	8082                	ret

0000000080002180 <sys_exit>:
#include "proc.h"
#include "sysinfo.h"

uint64
sys_exit(void)
{
    80002180:	1101                	addi	sp,sp,-32
    80002182:	ec06                	sd	ra,24(sp)
    80002184:	e822                	sd	s0,16(sp)
    80002186:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    80002188:	fec40593          	addi	a1,s0,-20
    8000218c:	4501                	li	a0,0
    8000218e:	00000097          	auipc	ra,0x0
    80002192:	ed6080e7          	jalr	-298(ra) # 80002064 <argint>
  exit(n);
    80002196:	fec42503          	lw	a0,-20(s0)
    8000219a:	fffff097          	auipc	ra,0xfffff
    8000219e:	51e080e7          	jalr	1310(ra) # 800016b8 <exit>
  return 0;  // not reached
}
    800021a2:	4501                	li	a0,0
    800021a4:	60e2                	ld	ra,24(sp)
    800021a6:	6442                	ld	s0,16(sp)
    800021a8:	6105                	addi	sp,sp,32
    800021aa:	8082                	ret

00000000800021ac <sys_getpid>:

uint64
sys_getpid(void)
{
    800021ac:	1141                	addi	sp,sp,-16
    800021ae:	e406                	sd	ra,8(sp)
    800021b0:	e022                	sd	s0,0(sp)
    800021b2:	0800                	addi	s0,sp,16
  return myproc()->pid;
    800021b4:	fffff097          	auipc	ra,0xfffff
    800021b8:	d20080e7          	jalr	-736(ra) # 80000ed4 <myproc>
}
    800021bc:	5908                	lw	a0,48(a0)
    800021be:	60a2                	ld	ra,8(sp)
    800021c0:	6402                	ld	s0,0(sp)
    800021c2:	0141                	addi	sp,sp,16
    800021c4:	8082                	ret

00000000800021c6 <sys_fork>:

uint64
sys_fork(void)
{
    800021c6:	1141                	addi	sp,sp,-16
    800021c8:	e406                	sd	ra,8(sp)
    800021ca:	e022                	sd	s0,0(sp)
    800021cc:	0800                	addi	s0,sp,16
  return fork();
    800021ce:	fffff097          	auipc	ra,0xfffff
    800021d2:	0be080e7          	jalr	190(ra) # 8000128c <fork>
}
    800021d6:	60a2                	ld	ra,8(sp)
    800021d8:	6402                	ld	s0,0(sp)
    800021da:	0141                	addi	sp,sp,16
    800021dc:	8082                	ret

00000000800021de <sys_wait>:

uint64
sys_wait(void)
{
    800021de:	1101                	addi	sp,sp,-32
    800021e0:	ec06                	sd	ra,24(sp)
    800021e2:	e822                	sd	s0,16(sp)
    800021e4:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    800021e6:	fe840593          	addi	a1,s0,-24
    800021ea:	4501                	li	a0,0
    800021ec:	00000097          	auipc	ra,0x0
    800021f0:	e98080e7          	jalr	-360(ra) # 80002084 <argaddr>
  return wait(p);
    800021f4:	fe843503          	ld	a0,-24(s0)
    800021f8:	fffff097          	auipc	ra,0xfffff
    800021fc:	668080e7          	jalr	1640(ra) # 80001860 <wait>
}
    80002200:	60e2                	ld	ra,24(sp)
    80002202:	6442                	ld	s0,16(sp)
    80002204:	6105                	addi	sp,sp,32
    80002206:	8082                	ret

0000000080002208 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80002208:	7179                	addi	sp,sp,-48
    8000220a:	f406                	sd	ra,40(sp)
    8000220c:	f022                	sd	s0,32(sp)
    8000220e:	ec26                	sd	s1,24(sp)
    80002210:	1800                	addi	s0,sp,48
  uint64 addr;
  int n;

  argint(0, &n);
    80002212:	fdc40593          	addi	a1,s0,-36
    80002216:	4501                	li	a0,0
    80002218:	00000097          	auipc	ra,0x0
    8000221c:	e4c080e7          	jalr	-436(ra) # 80002064 <argint>
  addr = myproc()->sz;
    80002220:	fffff097          	auipc	ra,0xfffff
    80002224:	cb4080e7          	jalr	-844(ra) # 80000ed4 <myproc>
    80002228:	6524                	ld	s1,72(a0)
  if(growproc(n) < 0)
    8000222a:	fdc42503          	lw	a0,-36(s0)
    8000222e:	fffff097          	auipc	ra,0xfffff
    80002232:	002080e7          	jalr	2(ra) # 80001230 <growproc>
    80002236:	00054863          	bltz	a0,80002246 <sys_sbrk+0x3e>
    return -1;
  return addr;
}
    8000223a:	8526                	mv	a0,s1
    8000223c:	70a2                	ld	ra,40(sp)
    8000223e:	7402                	ld	s0,32(sp)
    80002240:	64e2                	ld	s1,24(sp)
    80002242:	6145                	addi	sp,sp,48
    80002244:	8082                	ret
    return -1;
    80002246:	54fd                	li	s1,-1
    80002248:	bfcd                	j	8000223a <sys_sbrk+0x32>

000000008000224a <sys_sleep>:

uint64
sys_sleep(void)
{
    8000224a:	7139                	addi	sp,sp,-64
    8000224c:	fc06                	sd	ra,56(sp)
    8000224e:	f822                	sd	s0,48(sp)
    80002250:	f426                	sd	s1,40(sp)
    80002252:	f04a                	sd	s2,32(sp)
    80002254:	ec4e                	sd	s3,24(sp)
    80002256:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;


  argint(0, &n);
    80002258:	fcc40593          	addi	a1,s0,-52
    8000225c:	4501                	li	a0,0
    8000225e:	00000097          	auipc	ra,0x0
    80002262:	e06080e7          	jalr	-506(ra) # 80002064 <argint>
  acquire(&tickslock);
    80002266:	0000d517          	auipc	a0,0xd
    8000226a:	87a50513          	addi	a0,a0,-1926 # 8000eae0 <tickslock>
    8000226e:	00004097          	auipc	ra,0x4
    80002272:	126080e7          	jalr	294(ra) # 80006394 <acquire>
  ticks0 = ticks;
    80002276:	00007797          	auipc	a5,0x7
    8000227a:	80278793          	addi	a5,a5,-2046 # 80008a78 <ticks>
    8000227e:	0007a903          	lw	s2,0(a5)
  while(ticks - ticks0 < n){
    80002282:	fcc42783          	lw	a5,-52(s0)
    80002286:	cf9d                	beqz	a5,800022c4 <sys_sleep+0x7a>
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80002288:	0000d997          	auipc	s3,0xd
    8000228c:	85898993          	addi	s3,s3,-1960 # 8000eae0 <tickslock>
    80002290:	00006497          	auipc	s1,0x6
    80002294:	7e848493          	addi	s1,s1,2024 # 80008a78 <ticks>
    if(killed(myproc())){
    80002298:	fffff097          	auipc	ra,0xfffff
    8000229c:	c3c080e7          	jalr	-964(ra) # 80000ed4 <myproc>
    800022a0:	fffff097          	auipc	ra,0xfffff
    800022a4:	58e080e7          	jalr	1422(ra) # 8000182e <killed>
    800022a8:	ed15                	bnez	a0,800022e4 <sys_sleep+0x9a>
    sleep(&ticks, &tickslock);
    800022aa:	85ce                	mv	a1,s3
    800022ac:	8526                	mv	a0,s1
    800022ae:	fffff097          	auipc	ra,0xfffff
    800022b2:	2d6080e7          	jalr	726(ra) # 80001584 <sleep>
  while(ticks - ticks0 < n){
    800022b6:	409c                	lw	a5,0(s1)
    800022b8:	412787bb          	subw	a5,a5,s2
    800022bc:	fcc42703          	lw	a4,-52(s0)
    800022c0:	fce7ece3          	bltu	a5,a4,80002298 <sys_sleep+0x4e>
  }
  release(&tickslock);
    800022c4:	0000d517          	auipc	a0,0xd
    800022c8:	81c50513          	addi	a0,a0,-2020 # 8000eae0 <tickslock>
    800022cc:	00004097          	auipc	ra,0x4
    800022d0:	17c080e7          	jalr	380(ra) # 80006448 <release>
  return 0;
    800022d4:	4501                	li	a0,0
}
    800022d6:	70e2                	ld	ra,56(sp)
    800022d8:	7442                	ld	s0,48(sp)
    800022da:	74a2                	ld	s1,40(sp)
    800022dc:	7902                	ld	s2,32(sp)
    800022de:	69e2                	ld	s3,24(sp)
    800022e0:	6121                	addi	sp,sp,64
    800022e2:	8082                	ret
      release(&tickslock);
    800022e4:	0000c517          	auipc	a0,0xc
    800022e8:	7fc50513          	addi	a0,a0,2044 # 8000eae0 <tickslock>
    800022ec:	00004097          	auipc	ra,0x4
    800022f0:	15c080e7          	jalr	348(ra) # 80006448 <release>
      return -1;
    800022f4:	557d                	li	a0,-1
    800022f6:	b7c5                	j	800022d6 <sys_sleep+0x8c>

00000000800022f8 <sys_pgaccess>:


#ifdef LAB_PGTBL
int
sys_pgaccess(void)
{
    800022f8:	1141                	addi	sp,sp,-16
    800022fa:	e422                	sd	s0,8(sp)
    800022fc:	0800                	addi	s0,sp,16
  // lab pgtbl: your code here.
  return 0;
}
    800022fe:	4501                	li	a0,0
    80002300:	6422                	ld	s0,8(sp)
    80002302:	0141                	addi	sp,sp,16
    80002304:	8082                	ret

0000000080002306 <sys_kill>:
#endif

uint64
sys_kill(void)
{
    80002306:	1101                	addi	sp,sp,-32
    80002308:	ec06                	sd	ra,24(sp)
    8000230a:	e822                	sd	s0,16(sp)
    8000230c:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    8000230e:	fec40593          	addi	a1,s0,-20
    80002312:	4501                	li	a0,0
    80002314:	00000097          	auipc	ra,0x0
    80002318:	d50080e7          	jalr	-688(ra) # 80002064 <argint>
  return kill(pid);
    8000231c:	fec42503          	lw	a0,-20(s0)
    80002320:	fffff097          	auipc	ra,0xfffff
    80002324:	470080e7          	jalr	1136(ra) # 80001790 <kill>
}
    80002328:	60e2                	ld	ra,24(sp)
    8000232a:	6442                	ld	s0,16(sp)
    8000232c:	6105                	addi	sp,sp,32
    8000232e:	8082                	ret

0000000080002330 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80002330:	1101                	addi	sp,sp,-32
    80002332:	ec06                	sd	ra,24(sp)
    80002334:	e822                	sd	s0,16(sp)
    80002336:	e426                	sd	s1,8(sp)
    80002338:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    8000233a:	0000c517          	auipc	a0,0xc
    8000233e:	7a650513          	addi	a0,a0,1958 # 8000eae0 <tickslock>
    80002342:	00004097          	auipc	ra,0x4
    80002346:	052080e7          	jalr	82(ra) # 80006394 <acquire>
  xticks = ticks;
    8000234a:	00006797          	auipc	a5,0x6
    8000234e:	72e78793          	addi	a5,a5,1838 # 80008a78 <ticks>
    80002352:	4384                	lw	s1,0(a5)
  release(&tickslock);
    80002354:	0000c517          	auipc	a0,0xc
    80002358:	78c50513          	addi	a0,a0,1932 # 8000eae0 <tickslock>
    8000235c:	00004097          	auipc	ra,0x4
    80002360:	0ec080e7          	jalr	236(ra) # 80006448 <release>
  return xticks;
}
    80002364:	02049513          	slli	a0,s1,0x20
    80002368:	9101                	srli	a0,a0,0x20
    8000236a:	60e2                	ld	ra,24(sp)
    8000236c:	6442                	ld	s0,16(sp)
    8000236e:	64a2                	ld	s1,8(sp)
    80002370:	6105                	addi	sp,sp,32
    80002372:	8082                	ret

0000000080002374 <sys_trace>:

uint64 sys_trace(void)
{
    80002374:	1101                	addi	sp,sp,-32
    80002376:	ec06                	sd	ra,24(sp)
    80002378:	e822                	sd	s0,16(sp)
    8000237a:	1000                	addi	s0,sp,32
  int mask;

  argint(0, &mask);
    8000237c:	fec40593          	addi	a1,s0,-20
    80002380:	4501                	li	a0,0
    80002382:	00000097          	auipc	ra,0x0
    80002386:	ce2080e7          	jalr	-798(ra) # 80002064 <argint>
  return trace(mask);
    8000238a:	fec42503          	lw	a0,-20(s0)
    8000238e:	fffff097          	auipc	ra,0xfffff
    80002392:	75c080e7          	jalr	1884(ra) # 80001aea <trace>
}
    80002396:	60e2                	ld	ra,24(sp)
    80002398:	6442                	ld	s0,16(sp)
    8000239a:	6105                	addi	sp,sp,32
    8000239c:	8082                	ret

000000008000239e <sys_sysinfo>:

uint64 sys_sysinfo(void)
{
    8000239e:	7179                	addi	sp,sp,-48
    800023a0:	f406                	sd	ra,40(sp)
    800023a2:	f022                	sd	s0,32(sp)
    800023a4:	1800                	addi	s0,sp,48
  // addr from user space
  uint64 p;
  argaddr(0, &p);
    800023a6:	fe840593          	addi	a1,s0,-24
    800023aa:	4501                	li	a0,0
    800023ac:	00000097          	auipc	ra,0x0
    800023b0:	cd8080e7          	jalr	-808(ra) # 80002084 <argaddr>

  struct sysinfo info;

  sysinfo(&info);
    800023b4:	fd840513          	addi	a0,s0,-40
    800023b8:	fffff097          	auipc	ra,0xfffff
    800023bc:	756080e7          	jalr	1878(ra) # 80001b0e <sysinfo>

  if (copyout(myproc()->pagetable, p, (char *)(&info), sizeof(info)) < 0)
    800023c0:	fffff097          	auipc	ra,0xfffff
    800023c4:	b14080e7          	jalr	-1260(ra) # 80000ed4 <myproc>
    800023c8:	46c1                	li	a3,16
    800023ca:	fd840613          	addi	a2,s0,-40
    800023ce:	fe843583          	ld	a1,-24(s0)
    800023d2:	6928                	ld	a0,80(a0)
    800023d4:	ffffe097          	auipc	ra,0xffffe
    800023d8:	7ae080e7          	jalr	1966(ra) # 80000b82 <copyout>
    return -1;

  return 0;
    800023dc:	957d                	srai	a0,a0,0x3f
    800023de:	70a2                	ld	ra,40(sp)
    800023e0:	7402                	ld	s0,32(sp)
    800023e2:	6145                	addi	sp,sp,48
    800023e4:	8082                	ret

00000000800023e6 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    800023e6:	7179                	addi	sp,sp,-48
    800023e8:	f406                	sd	ra,40(sp)
    800023ea:	f022                	sd	s0,32(sp)
    800023ec:	ec26                	sd	s1,24(sp)
    800023ee:	e84a                	sd	s2,16(sp)
    800023f0:	e44e                	sd	s3,8(sp)
    800023f2:	e052                	sd	s4,0(sp)
    800023f4:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    800023f6:	00006597          	auipc	a1,0x6
    800023fa:	25a58593          	addi	a1,a1,602 # 80008650 <str_syscalls+0x1b0>
    800023fe:	0000c517          	auipc	a0,0xc
    80002402:	6fa50513          	addi	a0,a0,1786 # 8000eaf8 <bcache>
    80002406:	00004097          	auipc	ra,0x4
    8000240a:	efe080e7          	jalr	-258(ra) # 80006304 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    8000240e:	00014797          	auipc	a5,0x14
    80002412:	6ea78793          	addi	a5,a5,1770 # 80016af8 <bcache+0x8000>
    80002416:	00015717          	auipc	a4,0x15
    8000241a:	94a70713          	addi	a4,a4,-1718 # 80016d60 <bcache+0x8268>
    8000241e:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    80002422:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002426:	0000c497          	auipc	s1,0xc
    8000242a:	6ea48493          	addi	s1,s1,1770 # 8000eb10 <bcache+0x18>
    b->next = bcache.head.next;
    8000242e:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80002430:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80002432:	00006a17          	auipc	s4,0x6
    80002436:	226a0a13          	addi	s4,s4,550 # 80008658 <str_syscalls+0x1b8>
    b->next = bcache.head.next;
    8000243a:	2b893783          	ld	a5,696(s2)
    8000243e:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80002440:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80002444:	85d2                	mv	a1,s4
    80002446:	01048513          	addi	a0,s1,16
    8000244a:	00001097          	auipc	ra,0x1
    8000244e:	51e080e7          	jalr	1310(ra) # 80003968 <initsleeplock>
    bcache.head.next->prev = b;
    80002452:	2b893783          	ld	a5,696(s2)
    80002456:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80002458:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    8000245c:	45848493          	addi	s1,s1,1112
    80002460:	fd349de3          	bne	s1,s3,8000243a <binit+0x54>
  }
}
    80002464:	70a2                	ld	ra,40(sp)
    80002466:	7402                	ld	s0,32(sp)
    80002468:	64e2                	ld	s1,24(sp)
    8000246a:	6942                	ld	s2,16(sp)
    8000246c:	69a2                	ld	s3,8(sp)
    8000246e:	6a02                	ld	s4,0(sp)
    80002470:	6145                	addi	sp,sp,48
    80002472:	8082                	ret

0000000080002474 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80002474:	7179                	addi	sp,sp,-48
    80002476:	f406                	sd	ra,40(sp)
    80002478:	f022                	sd	s0,32(sp)
    8000247a:	ec26                	sd	s1,24(sp)
    8000247c:	e84a                	sd	s2,16(sp)
    8000247e:	e44e                	sd	s3,8(sp)
    80002480:	1800                	addi	s0,sp,48
    80002482:	89aa                	mv	s3,a0
    80002484:	892e                	mv	s2,a1
  acquire(&bcache.lock);
    80002486:	0000c517          	auipc	a0,0xc
    8000248a:	67250513          	addi	a0,a0,1650 # 8000eaf8 <bcache>
    8000248e:	00004097          	auipc	ra,0x4
    80002492:	f06080e7          	jalr	-250(ra) # 80006394 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80002496:	00014797          	auipc	a5,0x14
    8000249a:	66278793          	addi	a5,a5,1634 # 80016af8 <bcache+0x8000>
    8000249e:	2b87b483          	ld	s1,696(a5)
    800024a2:	00015797          	auipc	a5,0x15
    800024a6:	8be78793          	addi	a5,a5,-1858 # 80016d60 <bcache+0x8268>
    800024aa:	02f48f63          	beq	s1,a5,800024e8 <bread+0x74>
    800024ae:	873e                	mv	a4,a5
    800024b0:	a021                	j	800024b8 <bread+0x44>
    800024b2:	68a4                	ld	s1,80(s1)
    800024b4:	02e48a63          	beq	s1,a4,800024e8 <bread+0x74>
    if(b->dev == dev && b->blockno == blockno){
    800024b8:	449c                	lw	a5,8(s1)
    800024ba:	ff379ce3          	bne	a5,s3,800024b2 <bread+0x3e>
    800024be:	44dc                	lw	a5,12(s1)
    800024c0:	ff2799e3          	bne	a5,s2,800024b2 <bread+0x3e>
      b->refcnt++;
    800024c4:	40bc                	lw	a5,64(s1)
    800024c6:	2785                	addiw	a5,a5,1
    800024c8:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800024ca:	0000c517          	auipc	a0,0xc
    800024ce:	62e50513          	addi	a0,a0,1582 # 8000eaf8 <bcache>
    800024d2:	00004097          	auipc	ra,0x4
    800024d6:	f76080e7          	jalr	-138(ra) # 80006448 <release>
      acquiresleep(&b->lock);
    800024da:	01048513          	addi	a0,s1,16
    800024de:	00001097          	auipc	ra,0x1
    800024e2:	4c4080e7          	jalr	1220(ra) # 800039a2 <acquiresleep>
      return b;
    800024e6:	a8b1                	j	80002542 <bread+0xce>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800024e8:	00014797          	auipc	a5,0x14
    800024ec:	61078793          	addi	a5,a5,1552 # 80016af8 <bcache+0x8000>
    800024f0:	2b07b483          	ld	s1,688(a5)
    800024f4:	00015797          	auipc	a5,0x15
    800024f8:	86c78793          	addi	a5,a5,-1940 # 80016d60 <bcache+0x8268>
    800024fc:	04f48d63          	beq	s1,a5,80002556 <bread+0xe2>
    if(b->refcnt == 0) {
    80002500:	40bc                	lw	a5,64(s1)
    80002502:	cb91                	beqz	a5,80002516 <bread+0xa2>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002504:	00015717          	auipc	a4,0x15
    80002508:	85c70713          	addi	a4,a4,-1956 # 80016d60 <bcache+0x8268>
    8000250c:	64a4                	ld	s1,72(s1)
    8000250e:	04e48463          	beq	s1,a4,80002556 <bread+0xe2>
    if(b->refcnt == 0) {
    80002512:	40bc                	lw	a5,64(s1)
    80002514:	ffe5                	bnez	a5,8000250c <bread+0x98>
      b->dev = dev;
    80002516:	0134a423          	sw	s3,8(s1)
      b->blockno = blockno;
    8000251a:	0124a623          	sw	s2,12(s1)
      b->valid = 0;
    8000251e:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80002522:	4785                	li	a5,1
    80002524:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002526:	0000c517          	auipc	a0,0xc
    8000252a:	5d250513          	addi	a0,a0,1490 # 8000eaf8 <bcache>
    8000252e:	00004097          	auipc	ra,0x4
    80002532:	f1a080e7          	jalr	-230(ra) # 80006448 <release>
      acquiresleep(&b->lock);
    80002536:	01048513          	addi	a0,s1,16
    8000253a:	00001097          	auipc	ra,0x1
    8000253e:	468080e7          	jalr	1128(ra) # 800039a2 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80002542:	409c                	lw	a5,0(s1)
    80002544:	c38d                	beqz	a5,80002566 <bread+0xf2>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    80002546:	8526                	mv	a0,s1
    80002548:	70a2                	ld	ra,40(sp)
    8000254a:	7402                	ld	s0,32(sp)
    8000254c:	64e2                	ld	s1,24(sp)
    8000254e:	6942                	ld	s2,16(sp)
    80002550:	69a2                	ld	s3,8(sp)
    80002552:	6145                	addi	sp,sp,48
    80002554:	8082                	ret
  panic("bget: no buffers");
    80002556:	00006517          	auipc	a0,0x6
    8000255a:	10a50513          	addi	a0,a0,266 # 80008660 <str_syscalls+0x1c0>
    8000255e:	00004097          	auipc	ra,0x4
    80002562:	8ce080e7          	jalr	-1842(ra) # 80005e2c <panic>
    virtio_disk_rw(b, 0);
    80002566:	4581                	li	a1,0
    80002568:	8526                	mv	a0,s1
    8000256a:	00003097          	auipc	ra,0x3
    8000256e:	066080e7          	jalr	102(ra) # 800055d0 <virtio_disk_rw>
    b->valid = 1;
    80002572:	4785                	li	a5,1
    80002574:	c09c                	sw	a5,0(s1)
  return b;
    80002576:	bfc1                	j	80002546 <bread+0xd2>

0000000080002578 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80002578:	1101                	addi	sp,sp,-32
    8000257a:	ec06                	sd	ra,24(sp)
    8000257c:	e822                	sd	s0,16(sp)
    8000257e:	e426                	sd	s1,8(sp)
    80002580:	1000                	addi	s0,sp,32
    80002582:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002584:	0541                	addi	a0,a0,16
    80002586:	00001097          	auipc	ra,0x1
    8000258a:	4b6080e7          	jalr	1206(ra) # 80003a3c <holdingsleep>
    8000258e:	cd01                	beqz	a0,800025a6 <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80002590:	4585                	li	a1,1
    80002592:	8526                	mv	a0,s1
    80002594:	00003097          	auipc	ra,0x3
    80002598:	03c080e7          	jalr	60(ra) # 800055d0 <virtio_disk_rw>
}
    8000259c:	60e2                	ld	ra,24(sp)
    8000259e:	6442                	ld	s0,16(sp)
    800025a0:	64a2                	ld	s1,8(sp)
    800025a2:	6105                	addi	sp,sp,32
    800025a4:	8082                	ret
    panic("bwrite");
    800025a6:	00006517          	auipc	a0,0x6
    800025aa:	0d250513          	addi	a0,a0,210 # 80008678 <str_syscalls+0x1d8>
    800025ae:	00004097          	auipc	ra,0x4
    800025b2:	87e080e7          	jalr	-1922(ra) # 80005e2c <panic>

00000000800025b6 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    800025b6:	1101                	addi	sp,sp,-32
    800025b8:	ec06                	sd	ra,24(sp)
    800025ba:	e822                	sd	s0,16(sp)
    800025bc:	e426                	sd	s1,8(sp)
    800025be:	e04a                	sd	s2,0(sp)
    800025c0:	1000                	addi	s0,sp,32
    800025c2:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800025c4:	01050913          	addi	s2,a0,16
    800025c8:	854a                	mv	a0,s2
    800025ca:	00001097          	auipc	ra,0x1
    800025ce:	472080e7          	jalr	1138(ra) # 80003a3c <holdingsleep>
    800025d2:	c92d                	beqz	a0,80002644 <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    800025d4:	854a                	mv	a0,s2
    800025d6:	00001097          	auipc	ra,0x1
    800025da:	422080e7          	jalr	1058(ra) # 800039f8 <releasesleep>

  acquire(&bcache.lock);
    800025de:	0000c517          	auipc	a0,0xc
    800025e2:	51a50513          	addi	a0,a0,1306 # 8000eaf8 <bcache>
    800025e6:	00004097          	auipc	ra,0x4
    800025ea:	dae080e7          	jalr	-594(ra) # 80006394 <acquire>
  b->refcnt--;
    800025ee:	40bc                	lw	a5,64(s1)
    800025f0:	37fd                	addiw	a5,a5,-1
    800025f2:	0007871b          	sext.w	a4,a5
    800025f6:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    800025f8:	eb05                	bnez	a4,80002628 <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    800025fa:	68bc                	ld	a5,80(s1)
    800025fc:	64b8                	ld	a4,72(s1)
    800025fe:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    80002600:	64bc                	ld	a5,72(s1)
    80002602:	68b8                	ld	a4,80(s1)
    80002604:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80002606:	00014797          	auipc	a5,0x14
    8000260a:	4f278793          	addi	a5,a5,1266 # 80016af8 <bcache+0x8000>
    8000260e:	2b87b703          	ld	a4,696(a5)
    80002612:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    80002614:	00014717          	auipc	a4,0x14
    80002618:	74c70713          	addi	a4,a4,1868 # 80016d60 <bcache+0x8268>
    8000261c:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    8000261e:	2b87b703          	ld	a4,696(a5)
    80002622:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    80002624:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    80002628:	0000c517          	auipc	a0,0xc
    8000262c:	4d050513          	addi	a0,a0,1232 # 8000eaf8 <bcache>
    80002630:	00004097          	auipc	ra,0x4
    80002634:	e18080e7          	jalr	-488(ra) # 80006448 <release>
}
    80002638:	60e2                	ld	ra,24(sp)
    8000263a:	6442                	ld	s0,16(sp)
    8000263c:	64a2                	ld	s1,8(sp)
    8000263e:	6902                	ld	s2,0(sp)
    80002640:	6105                	addi	sp,sp,32
    80002642:	8082                	ret
    panic("brelse");
    80002644:	00006517          	auipc	a0,0x6
    80002648:	03c50513          	addi	a0,a0,60 # 80008680 <str_syscalls+0x1e0>
    8000264c:	00003097          	auipc	ra,0x3
    80002650:	7e0080e7          	jalr	2016(ra) # 80005e2c <panic>

0000000080002654 <bpin>:

void
bpin(struct buf *b) {
    80002654:	1101                	addi	sp,sp,-32
    80002656:	ec06                	sd	ra,24(sp)
    80002658:	e822                	sd	s0,16(sp)
    8000265a:	e426                	sd	s1,8(sp)
    8000265c:	1000                	addi	s0,sp,32
    8000265e:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002660:	0000c517          	auipc	a0,0xc
    80002664:	49850513          	addi	a0,a0,1176 # 8000eaf8 <bcache>
    80002668:	00004097          	auipc	ra,0x4
    8000266c:	d2c080e7          	jalr	-724(ra) # 80006394 <acquire>
  b->refcnt++;
    80002670:	40bc                	lw	a5,64(s1)
    80002672:	2785                	addiw	a5,a5,1
    80002674:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80002676:	0000c517          	auipc	a0,0xc
    8000267a:	48250513          	addi	a0,a0,1154 # 8000eaf8 <bcache>
    8000267e:	00004097          	auipc	ra,0x4
    80002682:	dca080e7          	jalr	-566(ra) # 80006448 <release>
}
    80002686:	60e2                	ld	ra,24(sp)
    80002688:	6442                	ld	s0,16(sp)
    8000268a:	64a2                	ld	s1,8(sp)
    8000268c:	6105                	addi	sp,sp,32
    8000268e:	8082                	ret

0000000080002690 <bunpin>:

void
bunpin(struct buf *b) {
    80002690:	1101                	addi	sp,sp,-32
    80002692:	ec06                	sd	ra,24(sp)
    80002694:	e822                	sd	s0,16(sp)
    80002696:	e426                	sd	s1,8(sp)
    80002698:	1000                	addi	s0,sp,32
    8000269a:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    8000269c:	0000c517          	auipc	a0,0xc
    800026a0:	45c50513          	addi	a0,a0,1116 # 8000eaf8 <bcache>
    800026a4:	00004097          	auipc	ra,0x4
    800026a8:	cf0080e7          	jalr	-784(ra) # 80006394 <acquire>
  b->refcnt--;
    800026ac:	40bc                	lw	a5,64(s1)
    800026ae:	37fd                	addiw	a5,a5,-1
    800026b0:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800026b2:	0000c517          	auipc	a0,0xc
    800026b6:	44650513          	addi	a0,a0,1094 # 8000eaf8 <bcache>
    800026ba:	00004097          	auipc	ra,0x4
    800026be:	d8e080e7          	jalr	-626(ra) # 80006448 <release>
}
    800026c2:	60e2                	ld	ra,24(sp)
    800026c4:	6442                	ld	s0,16(sp)
    800026c6:	64a2                	ld	s1,8(sp)
    800026c8:	6105                	addi	sp,sp,32
    800026ca:	8082                	ret

00000000800026cc <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    800026cc:	1101                	addi	sp,sp,-32
    800026ce:	ec06                	sd	ra,24(sp)
    800026d0:	e822                	sd	s0,16(sp)
    800026d2:	e426                	sd	s1,8(sp)
    800026d4:	e04a                	sd	s2,0(sp)
    800026d6:	1000                	addi	s0,sp,32
    800026d8:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    800026da:	00d5d59b          	srliw	a1,a1,0xd
    800026de:	00015797          	auipc	a5,0x15
    800026e2:	ada78793          	addi	a5,a5,-1318 # 800171b8 <sb>
    800026e6:	4fdc                	lw	a5,28(a5)
    800026e8:	9dbd                	addw	a1,a1,a5
    800026ea:	00000097          	auipc	ra,0x0
    800026ee:	d8a080e7          	jalr	-630(ra) # 80002474 <bread>
  bi = b % BPB;
    800026f2:	2481                	sext.w	s1,s1
  m = 1 << (bi % 8);
    800026f4:	0074f713          	andi	a4,s1,7
    800026f8:	4785                	li	a5,1
    800026fa:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    800026fe:	14ce                	slli	s1,s1,0x33
    80002700:	90d9                	srli	s1,s1,0x36
    80002702:	00950733          	add	a4,a0,s1
    80002706:	05874703          	lbu	a4,88(a4)
    8000270a:	00e7f6b3          	and	a3,a5,a4
    8000270e:	c69d                	beqz	a3,8000273c <bfree+0x70>
    80002710:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    80002712:	94aa                	add	s1,s1,a0
    80002714:	fff7c793          	not	a5,a5
    80002718:	8ff9                	and	a5,a5,a4
    8000271a:	04f48c23          	sb	a5,88(s1)
  log_write(bp);
    8000271e:	00001097          	auipc	ra,0x1
    80002722:	150080e7          	jalr	336(ra) # 8000386e <log_write>
  brelse(bp);
    80002726:	854a                	mv	a0,s2
    80002728:	00000097          	auipc	ra,0x0
    8000272c:	e8e080e7          	jalr	-370(ra) # 800025b6 <brelse>
}
    80002730:	60e2                	ld	ra,24(sp)
    80002732:	6442                	ld	s0,16(sp)
    80002734:	64a2                	ld	s1,8(sp)
    80002736:	6902                	ld	s2,0(sp)
    80002738:	6105                	addi	sp,sp,32
    8000273a:	8082                	ret
    panic("freeing free block");
    8000273c:	00006517          	auipc	a0,0x6
    80002740:	f4c50513          	addi	a0,a0,-180 # 80008688 <str_syscalls+0x1e8>
    80002744:	00003097          	auipc	ra,0x3
    80002748:	6e8080e7          	jalr	1768(ra) # 80005e2c <panic>

000000008000274c <balloc>:
{
    8000274c:	711d                	addi	sp,sp,-96
    8000274e:	ec86                	sd	ra,88(sp)
    80002750:	e8a2                	sd	s0,80(sp)
    80002752:	e4a6                	sd	s1,72(sp)
    80002754:	e0ca                	sd	s2,64(sp)
    80002756:	fc4e                	sd	s3,56(sp)
    80002758:	f852                	sd	s4,48(sp)
    8000275a:	f456                	sd	s5,40(sp)
    8000275c:	f05a                	sd	s6,32(sp)
    8000275e:	ec5e                	sd	s7,24(sp)
    80002760:	e862                	sd	s8,16(sp)
    80002762:	e466                	sd	s9,8(sp)
    80002764:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80002766:	00015797          	auipc	a5,0x15
    8000276a:	a5278793          	addi	a5,a5,-1454 # 800171b8 <sb>
    8000276e:	43dc                	lw	a5,4(a5)
    80002770:	10078e63          	beqz	a5,8000288c <balloc+0x140>
    80002774:	8baa                	mv	s7,a0
    80002776:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80002778:	00015b17          	auipc	s6,0x15
    8000277c:	a40b0b13          	addi	s6,s6,-1472 # 800171b8 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002780:	4c05                	li	s8,1
      m = 1 << (bi % 8);
    80002782:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002784:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80002786:	6c89                	lui	s9,0x2
    80002788:	a079                	j	80002816 <balloc+0xca>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000278a:	8942                	mv	s2,a6
      m = 1 << (bi % 8);
    8000278c:	4705                	li	a4,1
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    8000278e:	4681                	li	a3,0
        bp->data[bi/8] |= m;  // Mark block in use.
    80002790:	96a6                	add	a3,a3,s1
    80002792:	8f51                	or	a4,a4,a2
    80002794:	04e68c23          	sb	a4,88(a3)
        log_write(bp);
    80002798:	8526                	mv	a0,s1
    8000279a:	00001097          	auipc	ra,0x1
    8000279e:	0d4080e7          	jalr	212(ra) # 8000386e <log_write>
        brelse(bp);
    800027a2:	8526                	mv	a0,s1
    800027a4:	00000097          	auipc	ra,0x0
    800027a8:	e12080e7          	jalr	-494(ra) # 800025b6 <brelse>
  bp = bread(dev, bno);
    800027ac:	85ca                	mv	a1,s2
    800027ae:	855e                	mv	a0,s7
    800027b0:	00000097          	auipc	ra,0x0
    800027b4:	cc4080e7          	jalr	-828(ra) # 80002474 <bread>
    800027b8:	84aa                	mv	s1,a0
  memset(bp->data, 0, BSIZE);
    800027ba:	40000613          	li	a2,1024
    800027be:	4581                	li	a1,0
    800027c0:	05850513          	addi	a0,a0,88
    800027c4:	ffffe097          	auipc	ra,0xffffe
    800027c8:	a00080e7          	jalr	-1536(ra) # 800001c4 <memset>
  log_write(bp);
    800027cc:	8526                	mv	a0,s1
    800027ce:	00001097          	auipc	ra,0x1
    800027d2:	0a0080e7          	jalr	160(ra) # 8000386e <log_write>
  brelse(bp);
    800027d6:	8526                	mv	a0,s1
    800027d8:	00000097          	auipc	ra,0x0
    800027dc:	dde080e7          	jalr	-546(ra) # 800025b6 <brelse>
}
    800027e0:	854a                	mv	a0,s2
    800027e2:	60e6                	ld	ra,88(sp)
    800027e4:	6446                	ld	s0,80(sp)
    800027e6:	64a6                	ld	s1,72(sp)
    800027e8:	6906                	ld	s2,64(sp)
    800027ea:	79e2                	ld	s3,56(sp)
    800027ec:	7a42                	ld	s4,48(sp)
    800027ee:	7aa2                	ld	s5,40(sp)
    800027f0:	7b02                	ld	s6,32(sp)
    800027f2:	6be2                	ld	s7,24(sp)
    800027f4:	6c42                	ld	s8,16(sp)
    800027f6:	6ca2                	ld	s9,8(sp)
    800027f8:	6125                	addi	sp,sp,96
    800027fa:	8082                	ret
    brelse(bp);
    800027fc:	8526                	mv	a0,s1
    800027fe:	00000097          	auipc	ra,0x0
    80002802:	db8080e7          	jalr	-584(ra) # 800025b6 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80002806:	015c87bb          	addw	a5,s9,s5
    8000280a:	00078a9b          	sext.w	s5,a5
    8000280e:	004b2703          	lw	a4,4(s6)
    80002812:	06eafd63          	bgeu	s5,a4,8000288c <balloc+0x140>
    bp = bread(dev, BBLOCK(b, sb));
    80002816:	41fad79b          	sraiw	a5,s5,0x1f
    8000281a:	0137d79b          	srliw	a5,a5,0x13
    8000281e:	015787bb          	addw	a5,a5,s5
    80002822:	40d7d79b          	sraiw	a5,a5,0xd
    80002826:	01cb2583          	lw	a1,28(s6)
    8000282a:	9dbd                	addw	a1,a1,a5
    8000282c:	855e                	mv	a0,s7
    8000282e:	00000097          	auipc	ra,0x0
    80002832:	c46080e7          	jalr	-954(ra) # 80002474 <bread>
    80002836:	84aa                	mv	s1,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002838:	000a881b          	sext.w	a6,s5
    8000283c:	004b2503          	lw	a0,4(s6)
    80002840:	faa87ee3          	bgeu	a6,a0,800027fc <balloc+0xb0>
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80002844:	0584c603          	lbu	a2,88(s1)
    80002848:	00167793          	andi	a5,a2,1
    8000284c:	df9d                	beqz	a5,8000278a <balloc+0x3e>
    8000284e:	4105053b          	subw	a0,a0,a6
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002852:	87e2                	mv	a5,s8
    80002854:	0107893b          	addw	s2,a5,a6
    80002858:	faa782e3          	beq	a5,a0,800027fc <balloc+0xb0>
      m = 1 << (bi % 8);
    8000285c:	41f7d71b          	sraiw	a4,a5,0x1f
    80002860:	01d7561b          	srliw	a2,a4,0x1d
    80002864:	00f606bb          	addw	a3,a2,a5
    80002868:	0076f713          	andi	a4,a3,7
    8000286c:	9f11                	subw	a4,a4,a2
    8000286e:	00e9973b          	sllw	a4,s3,a4
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80002872:	4036d69b          	sraiw	a3,a3,0x3
    80002876:	00d48633          	add	a2,s1,a3
    8000287a:	05864603          	lbu	a2,88(a2)
    8000287e:	00c775b3          	and	a1,a4,a2
    80002882:	d599                	beqz	a1,80002790 <balloc+0x44>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002884:	2785                	addiw	a5,a5,1
    80002886:	fd4797e3          	bne	a5,s4,80002854 <balloc+0x108>
    8000288a:	bf8d                	j	800027fc <balloc+0xb0>
  printf("balloc: out of blocks\n");
    8000288c:	00006517          	auipc	a0,0x6
    80002890:	e1450513          	addi	a0,a0,-492 # 800086a0 <str_syscalls+0x200>
    80002894:	00003097          	auipc	ra,0x3
    80002898:	5e2080e7          	jalr	1506(ra) # 80005e76 <printf>
  return 0;
    8000289c:	4901                	li	s2,0
    8000289e:	b789                	j	800027e0 <balloc+0x94>

00000000800028a0 <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    800028a0:	7179                	addi	sp,sp,-48
    800028a2:	f406                	sd	ra,40(sp)
    800028a4:	f022                	sd	s0,32(sp)
    800028a6:	ec26                	sd	s1,24(sp)
    800028a8:	e84a                	sd	s2,16(sp)
    800028aa:	e44e                	sd	s3,8(sp)
    800028ac:	e052                	sd	s4,0(sp)
    800028ae:	1800                	addi	s0,sp,48
    800028b0:	89aa                	mv	s3,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    800028b2:	47ad                	li	a5,11
    800028b4:	02b7e763          	bltu	a5,a1,800028e2 <bmap+0x42>
    if((addr = ip->addrs[bn]) == 0){
    800028b8:	02059493          	slli	s1,a1,0x20
    800028bc:	9081                	srli	s1,s1,0x20
    800028be:	048a                	slli	s1,s1,0x2
    800028c0:	94aa                	add	s1,s1,a0
    800028c2:	0504a903          	lw	s2,80(s1)
    800028c6:	06091e63          	bnez	s2,80002942 <bmap+0xa2>
      addr = balloc(ip->dev);
    800028ca:	4108                	lw	a0,0(a0)
    800028cc:	00000097          	auipc	ra,0x0
    800028d0:	e80080e7          	jalr	-384(ra) # 8000274c <balloc>
    800028d4:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    800028d8:	06090563          	beqz	s2,80002942 <bmap+0xa2>
        return 0;
      ip->addrs[bn] = addr;
    800028dc:	0524a823          	sw	s2,80(s1)
    800028e0:	a08d                	j	80002942 <bmap+0xa2>
    }
    return addr;
  }
  bn -= NDIRECT;
    800028e2:	ff45849b          	addiw	s1,a1,-12
    800028e6:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    800028ea:	0ff00793          	li	a5,255
    800028ee:	08e7e563          	bltu	a5,a4,80002978 <bmap+0xd8>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    800028f2:	08052903          	lw	s2,128(a0)
    800028f6:	00091d63          	bnez	s2,80002910 <bmap+0x70>
      addr = balloc(ip->dev);
    800028fa:	4108                	lw	a0,0(a0)
    800028fc:	00000097          	auipc	ra,0x0
    80002900:	e50080e7          	jalr	-432(ra) # 8000274c <balloc>
    80002904:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    80002908:	02090d63          	beqz	s2,80002942 <bmap+0xa2>
        return 0;
      ip->addrs[NDIRECT] = addr;
    8000290c:	0929a023          	sw	s2,128(s3)
    }
    bp = bread(ip->dev, addr);
    80002910:	85ca                	mv	a1,s2
    80002912:	0009a503          	lw	a0,0(s3)
    80002916:	00000097          	auipc	ra,0x0
    8000291a:	b5e080e7          	jalr	-1186(ra) # 80002474 <bread>
    8000291e:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80002920:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    80002924:	02049593          	slli	a1,s1,0x20
    80002928:	9181                	srli	a1,a1,0x20
    8000292a:	058a                	slli	a1,a1,0x2
    8000292c:	00b784b3          	add	s1,a5,a1
    80002930:	0004a903          	lw	s2,0(s1)
    80002934:	02090063          	beqz	s2,80002954 <bmap+0xb4>
      if(addr){
        a[bn] = addr;
        log_write(bp);
      }
    }
    brelse(bp);
    80002938:	8552                	mv	a0,s4
    8000293a:	00000097          	auipc	ra,0x0
    8000293e:	c7c080e7          	jalr	-900(ra) # 800025b6 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    80002942:	854a                	mv	a0,s2
    80002944:	70a2                	ld	ra,40(sp)
    80002946:	7402                	ld	s0,32(sp)
    80002948:	64e2                	ld	s1,24(sp)
    8000294a:	6942                	ld	s2,16(sp)
    8000294c:	69a2                	ld	s3,8(sp)
    8000294e:	6a02                	ld	s4,0(sp)
    80002950:	6145                	addi	sp,sp,48
    80002952:	8082                	ret
      addr = balloc(ip->dev);
    80002954:	0009a503          	lw	a0,0(s3)
    80002958:	00000097          	auipc	ra,0x0
    8000295c:	df4080e7          	jalr	-524(ra) # 8000274c <balloc>
    80002960:	0005091b          	sext.w	s2,a0
      if(addr){
    80002964:	fc090ae3          	beqz	s2,80002938 <bmap+0x98>
        a[bn] = addr;
    80002968:	0124a023          	sw	s2,0(s1)
        log_write(bp);
    8000296c:	8552                	mv	a0,s4
    8000296e:	00001097          	auipc	ra,0x1
    80002972:	f00080e7          	jalr	-256(ra) # 8000386e <log_write>
    80002976:	b7c9                	j	80002938 <bmap+0x98>
  panic("bmap: out of range");
    80002978:	00006517          	auipc	a0,0x6
    8000297c:	d4050513          	addi	a0,a0,-704 # 800086b8 <str_syscalls+0x218>
    80002980:	00003097          	auipc	ra,0x3
    80002984:	4ac080e7          	jalr	1196(ra) # 80005e2c <panic>

0000000080002988 <iget>:
{
    80002988:	7179                	addi	sp,sp,-48
    8000298a:	f406                	sd	ra,40(sp)
    8000298c:	f022                	sd	s0,32(sp)
    8000298e:	ec26                	sd	s1,24(sp)
    80002990:	e84a                	sd	s2,16(sp)
    80002992:	e44e                	sd	s3,8(sp)
    80002994:	e052                	sd	s4,0(sp)
    80002996:	1800                	addi	s0,sp,48
    80002998:	89aa                	mv	s3,a0
    8000299a:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    8000299c:	00015517          	auipc	a0,0x15
    800029a0:	83c50513          	addi	a0,a0,-1988 # 800171d8 <itable>
    800029a4:	00004097          	auipc	ra,0x4
    800029a8:	9f0080e7          	jalr	-1552(ra) # 80006394 <acquire>
  empty = 0;
    800029ac:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    800029ae:	00015497          	auipc	s1,0x15
    800029b2:	84248493          	addi	s1,s1,-1982 # 800171f0 <itable+0x18>
    800029b6:	00016697          	auipc	a3,0x16
    800029ba:	2ca68693          	addi	a3,a3,714 # 80018c80 <log>
    800029be:	a039                	j	800029cc <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800029c0:	02090b63          	beqz	s2,800029f6 <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    800029c4:	08848493          	addi	s1,s1,136
    800029c8:	02d48a63          	beq	s1,a3,800029fc <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    800029cc:	449c                	lw	a5,8(s1)
    800029ce:	fef059e3          	blez	a5,800029c0 <iget+0x38>
    800029d2:	4098                	lw	a4,0(s1)
    800029d4:	ff3716e3          	bne	a4,s3,800029c0 <iget+0x38>
    800029d8:	40d8                	lw	a4,4(s1)
    800029da:	ff4713e3          	bne	a4,s4,800029c0 <iget+0x38>
      ip->ref++;
    800029de:	2785                	addiw	a5,a5,1
    800029e0:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    800029e2:	00014517          	auipc	a0,0x14
    800029e6:	7f650513          	addi	a0,a0,2038 # 800171d8 <itable>
    800029ea:	00004097          	auipc	ra,0x4
    800029ee:	a5e080e7          	jalr	-1442(ra) # 80006448 <release>
      return ip;
    800029f2:	8926                	mv	s2,s1
    800029f4:	a03d                	j	80002a22 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800029f6:	f7f9                	bnez	a5,800029c4 <iget+0x3c>
    800029f8:	8926                	mv	s2,s1
    800029fa:	b7e9                	j	800029c4 <iget+0x3c>
  if(empty == 0)
    800029fc:	02090c63          	beqz	s2,80002a34 <iget+0xac>
  ip->dev = dev;
    80002a00:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80002a04:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    80002a08:	4785                	li	a5,1
    80002a0a:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80002a0e:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80002a12:	00014517          	auipc	a0,0x14
    80002a16:	7c650513          	addi	a0,a0,1990 # 800171d8 <itable>
    80002a1a:	00004097          	auipc	ra,0x4
    80002a1e:	a2e080e7          	jalr	-1490(ra) # 80006448 <release>
}
    80002a22:	854a                	mv	a0,s2
    80002a24:	70a2                	ld	ra,40(sp)
    80002a26:	7402                	ld	s0,32(sp)
    80002a28:	64e2                	ld	s1,24(sp)
    80002a2a:	6942                	ld	s2,16(sp)
    80002a2c:	69a2                	ld	s3,8(sp)
    80002a2e:	6a02                	ld	s4,0(sp)
    80002a30:	6145                	addi	sp,sp,48
    80002a32:	8082                	ret
    panic("iget: no inodes");
    80002a34:	00006517          	auipc	a0,0x6
    80002a38:	c9c50513          	addi	a0,a0,-868 # 800086d0 <str_syscalls+0x230>
    80002a3c:	00003097          	auipc	ra,0x3
    80002a40:	3f0080e7          	jalr	1008(ra) # 80005e2c <panic>

0000000080002a44 <fsinit>:
fsinit(int dev) {
    80002a44:	7179                	addi	sp,sp,-48
    80002a46:	f406                	sd	ra,40(sp)
    80002a48:	f022                	sd	s0,32(sp)
    80002a4a:	ec26                	sd	s1,24(sp)
    80002a4c:	e84a                	sd	s2,16(sp)
    80002a4e:	e44e                	sd	s3,8(sp)
    80002a50:	1800                	addi	s0,sp,48
    80002a52:	89aa                	mv	s3,a0
  bp = bread(dev, 1);
    80002a54:	4585                	li	a1,1
    80002a56:	00000097          	auipc	ra,0x0
    80002a5a:	a1e080e7          	jalr	-1506(ra) # 80002474 <bread>
    80002a5e:	892a                	mv	s2,a0
  memmove(sb, bp->data, sizeof(*sb));
    80002a60:	00014497          	auipc	s1,0x14
    80002a64:	75848493          	addi	s1,s1,1880 # 800171b8 <sb>
    80002a68:	02000613          	li	a2,32
    80002a6c:	05850593          	addi	a1,a0,88
    80002a70:	8526                	mv	a0,s1
    80002a72:	ffffd097          	auipc	ra,0xffffd
    80002a76:	7be080e7          	jalr	1982(ra) # 80000230 <memmove>
  brelse(bp);
    80002a7a:	854a                	mv	a0,s2
    80002a7c:	00000097          	auipc	ra,0x0
    80002a80:	b3a080e7          	jalr	-1222(ra) # 800025b6 <brelse>
  if(sb.magic != FSMAGIC)
    80002a84:	4098                	lw	a4,0(s1)
    80002a86:	102037b7          	lui	a5,0x10203
    80002a8a:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80002a8e:	02f71263          	bne	a4,a5,80002ab2 <fsinit+0x6e>
  initlog(dev, &sb);
    80002a92:	00014597          	auipc	a1,0x14
    80002a96:	72658593          	addi	a1,a1,1830 # 800171b8 <sb>
    80002a9a:	854e                	mv	a0,s3
    80002a9c:	00001097          	auipc	ra,0x1
    80002aa0:	b50080e7          	jalr	-1200(ra) # 800035ec <initlog>
}
    80002aa4:	70a2                	ld	ra,40(sp)
    80002aa6:	7402                	ld	s0,32(sp)
    80002aa8:	64e2                	ld	s1,24(sp)
    80002aaa:	6942                	ld	s2,16(sp)
    80002aac:	69a2                	ld	s3,8(sp)
    80002aae:	6145                	addi	sp,sp,48
    80002ab0:	8082                	ret
    panic("invalid file system");
    80002ab2:	00006517          	auipc	a0,0x6
    80002ab6:	c2e50513          	addi	a0,a0,-978 # 800086e0 <str_syscalls+0x240>
    80002aba:	00003097          	auipc	ra,0x3
    80002abe:	372080e7          	jalr	882(ra) # 80005e2c <panic>

0000000080002ac2 <iinit>:
{
    80002ac2:	7179                	addi	sp,sp,-48
    80002ac4:	f406                	sd	ra,40(sp)
    80002ac6:	f022                	sd	s0,32(sp)
    80002ac8:	ec26                	sd	s1,24(sp)
    80002aca:	e84a                	sd	s2,16(sp)
    80002acc:	e44e                	sd	s3,8(sp)
    80002ace:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    80002ad0:	00006597          	auipc	a1,0x6
    80002ad4:	c2858593          	addi	a1,a1,-984 # 800086f8 <str_syscalls+0x258>
    80002ad8:	00014517          	auipc	a0,0x14
    80002adc:	70050513          	addi	a0,a0,1792 # 800171d8 <itable>
    80002ae0:	00004097          	auipc	ra,0x4
    80002ae4:	824080e7          	jalr	-2012(ra) # 80006304 <initlock>
  for(i = 0; i < NINODE; i++) {
    80002ae8:	00014497          	auipc	s1,0x14
    80002aec:	71848493          	addi	s1,s1,1816 # 80017200 <itable+0x28>
    80002af0:	00016997          	auipc	s3,0x16
    80002af4:	1a098993          	addi	s3,s3,416 # 80018c90 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80002af8:	00006917          	auipc	s2,0x6
    80002afc:	c0890913          	addi	s2,s2,-1016 # 80008700 <str_syscalls+0x260>
    80002b00:	85ca                	mv	a1,s2
    80002b02:	8526                	mv	a0,s1
    80002b04:	00001097          	auipc	ra,0x1
    80002b08:	e64080e7          	jalr	-412(ra) # 80003968 <initsleeplock>
    80002b0c:	08848493          	addi	s1,s1,136
  for(i = 0; i < NINODE; i++) {
    80002b10:	ff3498e3          	bne	s1,s3,80002b00 <iinit+0x3e>
}
    80002b14:	70a2                	ld	ra,40(sp)
    80002b16:	7402                	ld	s0,32(sp)
    80002b18:	64e2                	ld	s1,24(sp)
    80002b1a:	6942                	ld	s2,16(sp)
    80002b1c:	69a2                	ld	s3,8(sp)
    80002b1e:	6145                	addi	sp,sp,48
    80002b20:	8082                	ret

0000000080002b22 <ialloc>:
{
    80002b22:	715d                	addi	sp,sp,-80
    80002b24:	e486                	sd	ra,72(sp)
    80002b26:	e0a2                	sd	s0,64(sp)
    80002b28:	fc26                	sd	s1,56(sp)
    80002b2a:	f84a                	sd	s2,48(sp)
    80002b2c:	f44e                	sd	s3,40(sp)
    80002b2e:	f052                	sd	s4,32(sp)
    80002b30:	ec56                	sd	s5,24(sp)
    80002b32:	e85a                	sd	s6,16(sp)
    80002b34:	e45e                	sd	s7,8(sp)
    80002b36:	0880                	addi	s0,sp,80
  for(inum = 1; inum < sb.ninodes; inum++){
    80002b38:	00014797          	auipc	a5,0x14
    80002b3c:	68078793          	addi	a5,a5,1664 # 800171b8 <sb>
    80002b40:	47d8                	lw	a4,12(a5)
    80002b42:	4785                	li	a5,1
    80002b44:	04e7fa63          	bgeu	a5,a4,80002b98 <ialloc+0x76>
    80002b48:	8a2a                	mv	s4,a0
    80002b4a:	8b2e                	mv	s6,a1
    80002b4c:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    80002b4e:	00014997          	auipc	s3,0x14
    80002b52:	66a98993          	addi	s3,s3,1642 # 800171b8 <sb>
    80002b56:	00048a9b          	sext.w	s5,s1
    80002b5a:	0044d593          	srli	a1,s1,0x4
    80002b5e:	0189a783          	lw	a5,24(s3)
    80002b62:	9dbd                	addw	a1,a1,a5
    80002b64:	8552                	mv	a0,s4
    80002b66:	00000097          	auipc	ra,0x0
    80002b6a:	90e080e7          	jalr	-1778(ra) # 80002474 <bread>
    80002b6e:	8baa                	mv	s7,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002b70:	05850913          	addi	s2,a0,88
    80002b74:	00f4f793          	andi	a5,s1,15
    80002b78:	079a                	slli	a5,a5,0x6
    80002b7a:	993e                	add	s2,s2,a5
    if(dip->type == 0){  // a free inode
    80002b7c:	00091783          	lh	a5,0(s2)
    80002b80:	c3a1                	beqz	a5,80002bc0 <ialloc+0x9e>
    brelse(bp);
    80002b82:	00000097          	auipc	ra,0x0
    80002b86:	a34080e7          	jalr	-1484(ra) # 800025b6 <brelse>
    80002b8a:	0485                	addi	s1,s1,1
  for(inum = 1; inum < sb.ninodes; inum++){
    80002b8c:	00c9a703          	lw	a4,12(s3)
    80002b90:	0004879b          	sext.w	a5,s1
    80002b94:	fce7e1e3          	bltu	a5,a4,80002b56 <ialloc+0x34>
  printf("ialloc: no inodes\n");
    80002b98:	00006517          	auipc	a0,0x6
    80002b9c:	b7050513          	addi	a0,a0,-1168 # 80008708 <str_syscalls+0x268>
    80002ba0:	00003097          	auipc	ra,0x3
    80002ba4:	2d6080e7          	jalr	726(ra) # 80005e76 <printf>
  return 0;
    80002ba8:	4501                	li	a0,0
}
    80002baa:	60a6                	ld	ra,72(sp)
    80002bac:	6406                	ld	s0,64(sp)
    80002bae:	74e2                	ld	s1,56(sp)
    80002bb0:	7942                	ld	s2,48(sp)
    80002bb2:	79a2                	ld	s3,40(sp)
    80002bb4:	7a02                	ld	s4,32(sp)
    80002bb6:	6ae2                	ld	s5,24(sp)
    80002bb8:	6b42                	ld	s6,16(sp)
    80002bba:	6ba2                	ld	s7,8(sp)
    80002bbc:	6161                	addi	sp,sp,80
    80002bbe:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    80002bc0:	04000613          	li	a2,64
    80002bc4:	4581                	li	a1,0
    80002bc6:	854a                	mv	a0,s2
    80002bc8:	ffffd097          	auipc	ra,0xffffd
    80002bcc:	5fc080e7          	jalr	1532(ra) # 800001c4 <memset>
      dip->type = type;
    80002bd0:	01691023          	sh	s6,0(s2)
      log_write(bp);   // mark it allocated on the disk
    80002bd4:	855e                	mv	a0,s7
    80002bd6:	00001097          	auipc	ra,0x1
    80002bda:	c98080e7          	jalr	-872(ra) # 8000386e <log_write>
      brelse(bp);
    80002bde:	855e                	mv	a0,s7
    80002be0:	00000097          	auipc	ra,0x0
    80002be4:	9d6080e7          	jalr	-1578(ra) # 800025b6 <brelse>
      return iget(dev, inum);
    80002be8:	85d6                	mv	a1,s5
    80002bea:	8552                	mv	a0,s4
    80002bec:	00000097          	auipc	ra,0x0
    80002bf0:	d9c080e7          	jalr	-612(ra) # 80002988 <iget>
    80002bf4:	bf5d                	j	80002baa <ialloc+0x88>

0000000080002bf6 <iupdate>:
{
    80002bf6:	1101                	addi	sp,sp,-32
    80002bf8:	ec06                	sd	ra,24(sp)
    80002bfa:	e822                	sd	s0,16(sp)
    80002bfc:	e426                	sd	s1,8(sp)
    80002bfe:	e04a                	sd	s2,0(sp)
    80002c00:	1000                	addi	s0,sp,32
    80002c02:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002c04:	415c                	lw	a5,4(a0)
    80002c06:	0047d79b          	srliw	a5,a5,0x4
    80002c0a:	00014717          	auipc	a4,0x14
    80002c0e:	5ae70713          	addi	a4,a4,1454 # 800171b8 <sb>
    80002c12:	4f0c                	lw	a1,24(a4)
    80002c14:	9dbd                	addw	a1,a1,a5
    80002c16:	4108                	lw	a0,0(a0)
    80002c18:	00000097          	auipc	ra,0x0
    80002c1c:	85c080e7          	jalr	-1956(ra) # 80002474 <bread>
    80002c20:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002c22:	05850513          	addi	a0,a0,88
    80002c26:	40dc                	lw	a5,4(s1)
    80002c28:	8bbd                	andi	a5,a5,15
    80002c2a:	079a                	slli	a5,a5,0x6
    80002c2c:	953e                	add	a0,a0,a5
  dip->type = ip->type;
    80002c2e:	04449783          	lh	a5,68(s1)
    80002c32:	00f51023          	sh	a5,0(a0)
  dip->major = ip->major;
    80002c36:	04649783          	lh	a5,70(s1)
    80002c3a:	00f51123          	sh	a5,2(a0)
  dip->minor = ip->minor;
    80002c3e:	04849783          	lh	a5,72(s1)
    80002c42:	00f51223          	sh	a5,4(a0)
  dip->nlink = ip->nlink;
    80002c46:	04a49783          	lh	a5,74(s1)
    80002c4a:	00f51323          	sh	a5,6(a0)
  dip->size = ip->size;
    80002c4e:	44fc                	lw	a5,76(s1)
    80002c50:	c51c                	sw	a5,8(a0)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002c52:	03400613          	li	a2,52
    80002c56:	05048593          	addi	a1,s1,80
    80002c5a:	0531                	addi	a0,a0,12
    80002c5c:	ffffd097          	auipc	ra,0xffffd
    80002c60:	5d4080e7          	jalr	1492(ra) # 80000230 <memmove>
  log_write(bp);
    80002c64:	854a                	mv	a0,s2
    80002c66:	00001097          	auipc	ra,0x1
    80002c6a:	c08080e7          	jalr	-1016(ra) # 8000386e <log_write>
  brelse(bp);
    80002c6e:	854a                	mv	a0,s2
    80002c70:	00000097          	auipc	ra,0x0
    80002c74:	946080e7          	jalr	-1722(ra) # 800025b6 <brelse>
}
    80002c78:	60e2                	ld	ra,24(sp)
    80002c7a:	6442                	ld	s0,16(sp)
    80002c7c:	64a2                	ld	s1,8(sp)
    80002c7e:	6902                	ld	s2,0(sp)
    80002c80:	6105                	addi	sp,sp,32
    80002c82:	8082                	ret

0000000080002c84 <idup>:
{
    80002c84:	1101                	addi	sp,sp,-32
    80002c86:	ec06                	sd	ra,24(sp)
    80002c88:	e822                	sd	s0,16(sp)
    80002c8a:	e426                	sd	s1,8(sp)
    80002c8c:	1000                	addi	s0,sp,32
    80002c8e:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002c90:	00014517          	auipc	a0,0x14
    80002c94:	54850513          	addi	a0,a0,1352 # 800171d8 <itable>
    80002c98:	00003097          	auipc	ra,0x3
    80002c9c:	6fc080e7          	jalr	1788(ra) # 80006394 <acquire>
  ip->ref++;
    80002ca0:	449c                	lw	a5,8(s1)
    80002ca2:	2785                	addiw	a5,a5,1
    80002ca4:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002ca6:	00014517          	auipc	a0,0x14
    80002caa:	53250513          	addi	a0,a0,1330 # 800171d8 <itable>
    80002cae:	00003097          	auipc	ra,0x3
    80002cb2:	79a080e7          	jalr	1946(ra) # 80006448 <release>
}
    80002cb6:	8526                	mv	a0,s1
    80002cb8:	60e2                	ld	ra,24(sp)
    80002cba:	6442                	ld	s0,16(sp)
    80002cbc:	64a2                	ld	s1,8(sp)
    80002cbe:	6105                	addi	sp,sp,32
    80002cc0:	8082                	ret

0000000080002cc2 <ilock>:
{
    80002cc2:	1101                	addi	sp,sp,-32
    80002cc4:	ec06                	sd	ra,24(sp)
    80002cc6:	e822                	sd	s0,16(sp)
    80002cc8:	e426                	sd	s1,8(sp)
    80002cca:	e04a                	sd	s2,0(sp)
    80002ccc:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80002cce:	c115                	beqz	a0,80002cf2 <ilock+0x30>
    80002cd0:	84aa                	mv	s1,a0
    80002cd2:	451c                	lw	a5,8(a0)
    80002cd4:	00f05f63          	blez	a5,80002cf2 <ilock+0x30>
  acquiresleep(&ip->lock);
    80002cd8:	0541                	addi	a0,a0,16
    80002cda:	00001097          	auipc	ra,0x1
    80002cde:	cc8080e7          	jalr	-824(ra) # 800039a2 <acquiresleep>
  if(ip->valid == 0){
    80002ce2:	40bc                	lw	a5,64(s1)
    80002ce4:	cf99                	beqz	a5,80002d02 <ilock+0x40>
}
    80002ce6:	60e2                	ld	ra,24(sp)
    80002ce8:	6442                	ld	s0,16(sp)
    80002cea:	64a2                	ld	s1,8(sp)
    80002cec:	6902                	ld	s2,0(sp)
    80002cee:	6105                	addi	sp,sp,32
    80002cf0:	8082                	ret
    panic("ilock");
    80002cf2:	00006517          	auipc	a0,0x6
    80002cf6:	a2e50513          	addi	a0,a0,-1490 # 80008720 <str_syscalls+0x280>
    80002cfa:	00003097          	auipc	ra,0x3
    80002cfe:	132080e7          	jalr	306(ra) # 80005e2c <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002d02:	40dc                	lw	a5,4(s1)
    80002d04:	0047d79b          	srliw	a5,a5,0x4
    80002d08:	00014717          	auipc	a4,0x14
    80002d0c:	4b070713          	addi	a4,a4,1200 # 800171b8 <sb>
    80002d10:	4f0c                	lw	a1,24(a4)
    80002d12:	9dbd                	addw	a1,a1,a5
    80002d14:	4088                	lw	a0,0(s1)
    80002d16:	fffff097          	auipc	ra,0xfffff
    80002d1a:	75e080e7          	jalr	1886(ra) # 80002474 <bread>
    80002d1e:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002d20:	05850593          	addi	a1,a0,88
    80002d24:	40dc                	lw	a5,4(s1)
    80002d26:	8bbd                	andi	a5,a5,15
    80002d28:	079a                	slli	a5,a5,0x6
    80002d2a:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80002d2c:	00059783          	lh	a5,0(a1)
    80002d30:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80002d34:	00259783          	lh	a5,2(a1)
    80002d38:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80002d3c:	00459783          	lh	a5,4(a1)
    80002d40:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80002d44:	00659783          	lh	a5,6(a1)
    80002d48:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80002d4c:	459c                	lw	a5,8(a1)
    80002d4e:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002d50:	03400613          	li	a2,52
    80002d54:	05b1                	addi	a1,a1,12
    80002d56:	05048513          	addi	a0,s1,80
    80002d5a:	ffffd097          	auipc	ra,0xffffd
    80002d5e:	4d6080e7          	jalr	1238(ra) # 80000230 <memmove>
    brelse(bp);
    80002d62:	854a                	mv	a0,s2
    80002d64:	00000097          	auipc	ra,0x0
    80002d68:	852080e7          	jalr	-1966(ra) # 800025b6 <brelse>
    ip->valid = 1;
    80002d6c:	4785                	li	a5,1
    80002d6e:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80002d70:	04449783          	lh	a5,68(s1)
    80002d74:	fbad                	bnez	a5,80002ce6 <ilock+0x24>
      panic("ilock: no type");
    80002d76:	00006517          	auipc	a0,0x6
    80002d7a:	9b250513          	addi	a0,a0,-1614 # 80008728 <str_syscalls+0x288>
    80002d7e:	00003097          	auipc	ra,0x3
    80002d82:	0ae080e7          	jalr	174(ra) # 80005e2c <panic>

0000000080002d86 <iunlock>:
{
    80002d86:	1101                	addi	sp,sp,-32
    80002d88:	ec06                	sd	ra,24(sp)
    80002d8a:	e822                	sd	s0,16(sp)
    80002d8c:	e426                	sd	s1,8(sp)
    80002d8e:	e04a                	sd	s2,0(sp)
    80002d90:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80002d92:	c905                	beqz	a0,80002dc2 <iunlock+0x3c>
    80002d94:	84aa                	mv	s1,a0
    80002d96:	01050913          	addi	s2,a0,16
    80002d9a:	854a                	mv	a0,s2
    80002d9c:	00001097          	auipc	ra,0x1
    80002da0:	ca0080e7          	jalr	-864(ra) # 80003a3c <holdingsleep>
    80002da4:	cd19                	beqz	a0,80002dc2 <iunlock+0x3c>
    80002da6:	449c                	lw	a5,8(s1)
    80002da8:	00f05d63          	blez	a5,80002dc2 <iunlock+0x3c>
  releasesleep(&ip->lock);
    80002dac:	854a                	mv	a0,s2
    80002dae:	00001097          	auipc	ra,0x1
    80002db2:	c4a080e7          	jalr	-950(ra) # 800039f8 <releasesleep>
}
    80002db6:	60e2                	ld	ra,24(sp)
    80002db8:	6442                	ld	s0,16(sp)
    80002dba:	64a2                	ld	s1,8(sp)
    80002dbc:	6902                	ld	s2,0(sp)
    80002dbe:	6105                	addi	sp,sp,32
    80002dc0:	8082                	ret
    panic("iunlock");
    80002dc2:	00006517          	auipc	a0,0x6
    80002dc6:	97650513          	addi	a0,a0,-1674 # 80008738 <str_syscalls+0x298>
    80002dca:	00003097          	auipc	ra,0x3
    80002dce:	062080e7          	jalr	98(ra) # 80005e2c <panic>

0000000080002dd2 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80002dd2:	7179                	addi	sp,sp,-48
    80002dd4:	f406                	sd	ra,40(sp)
    80002dd6:	f022                	sd	s0,32(sp)
    80002dd8:	ec26                	sd	s1,24(sp)
    80002dda:	e84a                	sd	s2,16(sp)
    80002ddc:	e44e                	sd	s3,8(sp)
    80002dde:	e052                	sd	s4,0(sp)
    80002de0:	1800                	addi	s0,sp,48
    80002de2:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80002de4:	05050493          	addi	s1,a0,80
    80002de8:	08050913          	addi	s2,a0,128
    80002dec:	a821                	j	80002e04 <itrunc+0x32>
    if(ip->addrs[i]){
      bfree(ip->dev, ip->addrs[i]);
    80002dee:	0009a503          	lw	a0,0(s3)
    80002df2:	00000097          	auipc	ra,0x0
    80002df6:	8da080e7          	jalr	-1830(ra) # 800026cc <bfree>
      ip->addrs[i] = 0;
    80002dfa:	0004a023          	sw	zero,0(s1)
    80002dfe:	0491                	addi	s1,s1,4
  for(i = 0; i < NDIRECT; i++){
    80002e00:	01248563          	beq	s1,s2,80002e0a <itrunc+0x38>
    if(ip->addrs[i]){
    80002e04:	408c                	lw	a1,0(s1)
    80002e06:	dde5                	beqz	a1,80002dfe <itrunc+0x2c>
    80002e08:	b7dd                	j	80002dee <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    80002e0a:	0809a583          	lw	a1,128(s3)
    80002e0e:	e185                	bnez	a1,80002e2e <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80002e10:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80002e14:	854e                	mv	a0,s3
    80002e16:	00000097          	auipc	ra,0x0
    80002e1a:	de0080e7          	jalr	-544(ra) # 80002bf6 <iupdate>
}
    80002e1e:	70a2                	ld	ra,40(sp)
    80002e20:	7402                	ld	s0,32(sp)
    80002e22:	64e2                	ld	s1,24(sp)
    80002e24:	6942                	ld	s2,16(sp)
    80002e26:	69a2                	ld	s3,8(sp)
    80002e28:	6a02                	ld	s4,0(sp)
    80002e2a:	6145                	addi	sp,sp,48
    80002e2c:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002e2e:	0009a503          	lw	a0,0(s3)
    80002e32:	fffff097          	auipc	ra,0xfffff
    80002e36:	642080e7          	jalr	1602(ra) # 80002474 <bread>
    80002e3a:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80002e3c:	05850493          	addi	s1,a0,88
    80002e40:	45850913          	addi	s2,a0,1112
    80002e44:	a811                	j	80002e58 <itrunc+0x86>
        bfree(ip->dev, a[j]);
    80002e46:	0009a503          	lw	a0,0(s3)
    80002e4a:	00000097          	auipc	ra,0x0
    80002e4e:	882080e7          	jalr	-1918(ra) # 800026cc <bfree>
    80002e52:	0491                	addi	s1,s1,4
    for(j = 0; j < NINDIRECT; j++){
    80002e54:	01248563          	beq	s1,s2,80002e5e <itrunc+0x8c>
      if(a[j])
    80002e58:	408c                	lw	a1,0(s1)
    80002e5a:	dde5                	beqz	a1,80002e52 <itrunc+0x80>
    80002e5c:	b7ed                	j	80002e46 <itrunc+0x74>
    brelse(bp);
    80002e5e:	8552                	mv	a0,s4
    80002e60:	fffff097          	auipc	ra,0xfffff
    80002e64:	756080e7          	jalr	1878(ra) # 800025b6 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80002e68:	0809a583          	lw	a1,128(s3)
    80002e6c:	0009a503          	lw	a0,0(s3)
    80002e70:	00000097          	auipc	ra,0x0
    80002e74:	85c080e7          	jalr	-1956(ra) # 800026cc <bfree>
    ip->addrs[NDIRECT] = 0;
    80002e78:	0809a023          	sw	zero,128(s3)
    80002e7c:	bf51                	j	80002e10 <itrunc+0x3e>

0000000080002e7e <iput>:
{
    80002e7e:	1101                	addi	sp,sp,-32
    80002e80:	ec06                	sd	ra,24(sp)
    80002e82:	e822                	sd	s0,16(sp)
    80002e84:	e426                	sd	s1,8(sp)
    80002e86:	e04a                	sd	s2,0(sp)
    80002e88:	1000                	addi	s0,sp,32
    80002e8a:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002e8c:	00014517          	auipc	a0,0x14
    80002e90:	34c50513          	addi	a0,a0,844 # 800171d8 <itable>
    80002e94:	00003097          	auipc	ra,0x3
    80002e98:	500080e7          	jalr	1280(ra) # 80006394 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002e9c:	4498                	lw	a4,8(s1)
    80002e9e:	4785                	li	a5,1
    80002ea0:	02f70363          	beq	a4,a5,80002ec6 <iput+0x48>
  ip->ref--;
    80002ea4:	449c                	lw	a5,8(s1)
    80002ea6:	37fd                	addiw	a5,a5,-1
    80002ea8:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002eaa:	00014517          	auipc	a0,0x14
    80002eae:	32e50513          	addi	a0,a0,814 # 800171d8 <itable>
    80002eb2:	00003097          	auipc	ra,0x3
    80002eb6:	596080e7          	jalr	1430(ra) # 80006448 <release>
}
    80002eba:	60e2                	ld	ra,24(sp)
    80002ebc:	6442                	ld	s0,16(sp)
    80002ebe:	64a2                	ld	s1,8(sp)
    80002ec0:	6902                	ld	s2,0(sp)
    80002ec2:	6105                	addi	sp,sp,32
    80002ec4:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002ec6:	40bc                	lw	a5,64(s1)
    80002ec8:	dff1                	beqz	a5,80002ea4 <iput+0x26>
    80002eca:	04a49783          	lh	a5,74(s1)
    80002ece:	fbf9                	bnez	a5,80002ea4 <iput+0x26>
    acquiresleep(&ip->lock);
    80002ed0:	01048913          	addi	s2,s1,16
    80002ed4:	854a                	mv	a0,s2
    80002ed6:	00001097          	auipc	ra,0x1
    80002eda:	acc080e7          	jalr	-1332(ra) # 800039a2 <acquiresleep>
    release(&itable.lock);
    80002ede:	00014517          	auipc	a0,0x14
    80002ee2:	2fa50513          	addi	a0,a0,762 # 800171d8 <itable>
    80002ee6:	00003097          	auipc	ra,0x3
    80002eea:	562080e7          	jalr	1378(ra) # 80006448 <release>
    itrunc(ip);
    80002eee:	8526                	mv	a0,s1
    80002ef0:	00000097          	auipc	ra,0x0
    80002ef4:	ee2080e7          	jalr	-286(ra) # 80002dd2 <itrunc>
    ip->type = 0;
    80002ef8:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80002efc:	8526                	mv	a0,s1
    80002efe:	00000097          	auipc	ra,0x0
    80002f02:	cf8080e7          	jalr	-776(ra) # 80002bf6 <iupdate>
    ip->valid = 0;
    80002f06:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80002f0a:	854a                	mv	a0,s2
    80002f0c:	00001097          	auipc	ra,0x1
    80002f10:	aec080e7          	jalr	-1300(ra) # 800039f8 <releasesleep>
    acquire(&itable.lock);
    80002f14:	00014517          	auipc	a0,0x14
    80002f18:	2c450513          	addi	a0,a0,708 # 800171d8 <itable>
    80002f1c:	00003097          	auipc	ra,0x3
    80002f20:	478080e7          	jalr	1144(ra) # 80006394 <acquire>
    80002f24:	b741                	j	80002ea4 <iput+0x26>

0000000080002f26 <iunlockput>:
{
    80002f26:	1101                	addi	sp,sp,-32
    80002f28:	ec06                	sd	ra,24(sp)
    80002f2a:	e822                	sd	s0,16(sp)
    80002f2c:	e426                	sd	s1,8(sp)
    80002f2e:	1000                	addi	s0,sp,32
    80002f30:	84aa                	mv	s1,a0
  iunlock(ip);
    80002f32:	00000097          	auipc	ra,0x0
    80002f36:	e54080e7          	jalr	-428(ra) # 80002d86 <iunlock>
  iput(ip);
    80002f3a:	8526                	mv	a0,s1
    80002f3c:	00000097          	auipc	ra,0x0
    80002f40:	f42080e7          	jalr	-190(ra) # 80002e7e <iput>
}
    80002f44:	60e2                	ld	ra,24(sp)
    80002f46:	6442                	ld	s0,16(sp)
    80002f48:	64a2                	ld	s1,8(sp)
    80002f4a:	6105                	addi	sp,sp,32
    80002f4c:	8082                	ret

0000000080002f4e <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80002f4e:	1141                	addi	sp,sp,-16
    80002f50:	e422                	sd	s0,8(sp)
    80002f52:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80002f54:	411c                	lw	a5,0(a0)
    80002f56:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80002f58:	415c                	lw	a5,4(a0)
    80002f5a:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80002f5c:	04451783          	lh	a5,68(a0)
    80002f60:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80002f64:	04a51783          	lh	a5,74(a0)
    80002f68:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80002f6c:	04c56783          	lwu	a5,76(a0)
    80002f70:	e99c                	sd	a5,16(a1)
}
    80002f72:	6422                	ld	s0,8(sp)
    80002f74:	0141                	addi	sp,sp,16
    80002f76:	8082                	ret

0000000080002f78 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002f78:	457c                	lw	a5,76(a0)
    80002f7a:	0ed7e963          	bltu	a5,a3,8000306c <readi+0xf4>
{
    80002f7e:	7159                	addi	sp,sp,-112
    80002f80:	f486                	sd	ra,104(sp)
    80002f82:	f0a2                	sd	s0,96(sp)
    80002f84:	eca6                	sd	s1,88(sp)
    80002f86:	e8ca                	sd	s2,80(sp)
    80002f88:	e4ce                	sd	s3,72(sp)
    80002f8a:	e0d2                	sd	s4,64(sp)
    80002f8c:	fc56                	sd	s5,56(sp)
    80002f8e:	f85a                	sd	s6,48(sp)
    80002f90:	f45e                	sd	s7,40(sp)
    80002f92:	f062                	sd	s8,32(sp)
    80002f94:	ec66                	sd	s9,24(sp)
    80002f96:	e86a                	sd	s10,16(sp)
    80002f98:	e46e                	sd	s11,8(sp)
    80002f9a:	1880                	addi	s0,sp,112
    80002f9c:	8baa                	mv	s7,a0
    80002f9e:	8c2e                	mv	s8,a1
    80002fa0:	8a32                	mv	s4,a2
    80002fa2:	84b6                	mv	s1,a3
    80002fa4:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80002fa6:	9f35                	addw	a4,a4,a3
    return 0;
    80002fa8:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80002faa:	0ad76063          	bltu	a4,a3,8000304a <readi+0xd2>
  if(off + n > ip->size)
    80002fae:	00e7f463          	bgeu	a5,a4,80002fb6 <readi+0x3e>
    n = ip->size - off;
    80002fb2:	40d78b3b          	subw	s6,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002fb6:	0a0b0963          	beqz	s6,80003068 <readi+0xf0>
    80002fba:	4901                	li	s2,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80002fbc:	40000d13          	li	s10,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80002fc0:	5cfd                	li	s9,-1
    80002fc2:	a82d                	j	80002ffc <readi+0x84>
    80002fc4:	02099d93          	slli	s11,s3,0x20
    80002fc8:	020ddd93          	srli	s11,s11,0x20
    80002fcc:	058a8613          	addi	a2,s5,88
    80002fd0:	86ee                	mv	a3,s11
    80002fd2:	963a                	add	a2,a2,a4
    80002fd4:	85d2                	mv	a1,s4
    80002fd6:	8562                	mv	a0,s8
    80002fd8:	fffff097          	auipc	ra,0xfffff
    80002fdc:	9b6080e7          	jalr	-1610(ra) # 8000198e <either_copyout>
    80002fe0:	05950d63          	beq	a0,s9,8000303a <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80002fe4:	8556                	mv	a0,s5
    80002fe6:	fffff097          	auipc	ra,0xfffff
    80002fea:	5d0080e7          	jalr	1488(ra) # 800025b6 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002fee:	0129893b          	addw	s2,s3,s2
    80002ff2:	009984bb          	addw	s1,s3,s1
    80002ff6:	9a6e                	add	s4,s4,s11
    80002ff8:	05697763          	bgeu	s2,s6,80003046 <readi+0xce>
    uint addr = bmap(ip, off/BSIZE);
    80002ffc:	00a4d59b          	srliw	a1,s1,0xa
    80003000:	855e                	mv	a0,s7
    80003002:	00000097          	auipc	ra,0x0
    80003006:	89e080e7          	jalr	-1890(ra) # 800028a0 <bmap>
    8000300a:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    8000300e:	cd85                	beqz	a1,80003046 <readi+0xce>
    bp = bread(ip->dev, addr);
    80003010:	000ba503          	lw	a0,0(s7)
    80003014:	fffff097          	auipc	ra,0xfffff
    80003018:	460080e7          	jalr	1120(ra) # 80002474 <bread>
    8000301c:	8aaa                	mv	s5,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    8000301e:	3ff4f713          	andi	a4,s1,1023
    80003022:	40ed07bb          	subw	a5,s10,a4
    80003026:	412b06bb          	subw	a3,s6,s2
    8000302a:	89be                	mv	s3,a5
    8000302c:	2781                	sext.w	a5,a5
    8000302e:	0006861b          	sext.w	a2,a3
    80003032:	f8f679e3          	bgeu	a2,a5,80002fc4 <readi+0x4c>
    80003036:	89b6                	mv	s3,a3
    80003038:	b771                	j	80002fc4 <readi+0x4c>
      brelse(bp);
    8000303a:	8556                	mv	a0,s5
    8000303c:	fffff097          	auipc	ra,0xfffff
    80003040:	57a080e7          	jalr	1402(ra) # 800025b6 <brelse>
      tot = -1;
    80003044:	597d                	li	s2,-1
  }
  return tot;
    80003046:	0009051b          	sext.w	a0,s2
}
    8000304a:	70a6                	ld	ra,104(sp)
    8000304c:	7406                	ld	s0,96(sp)
    8000304e:	64e6                	ld	s1,88(sp)
    80003050:	6946                	ld	s2,80(sp)
    80003052:	69a6                	ld	s3,72(sp)
    80003054:	6a06                	ld	s4,64(sp)
    80003056:	7ae2                	ld	s5,56(sp)
    80003058:	7b42                	ld	s6,48(sp)
    8000305a:	7ba2                	ld	s7,40(sp)
    8000305c:	7c02                	ld	s8,32(sp)
    8000305e:	6ce2                	ld	s9,24(sp)
    80003060:	6d42                	ld	s10,16(sp)
    80003062:	6da2                	ld	s11,8(sp)
    80003064:	6165                	addi	sp,sp,112
    80003066:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003068:	895a                	mv	s2,s6
    8000306a:	bff1                	j	80003046 <readi+0xce>
    return 0;
    8000306c:	4501                	li	a0,0
}
    8000306e:	8082                	ret

0000000080003070 <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003070:	457c                	lw	a5,76(a0)
    80003072:	10d7e863          	bltu	a5,a3,80003182 <writei+0x112>
{
    80003076:	7159                	addi	sp,sp,-112
    80003078:	f486                	sd	ra,104(sp)
    8000307a:	f0a2                	sd	s0,96(sp)
    8000307c:	eca6                	sd	s1,88(sp)
    8000307e:	e8ca                	sd	s2,80(sp)
    80003080:	e4ce                	sd	s3,72(sp)
    80003082:	e0d2                	sd	s4,64(sp)
    80003084:	fc56                	sd	s5,56(sp)
    80003086:	f85a                	sd	s6,48(sp)
    80003088:	f45e                	sd	s7,40(sp)
    8000308a:	f062                	sd	s8,32(sp)
    8000308c:	ec66                	sd	s9,24(sp)
    8000308e:	e86a                	sd	s10,16(sp)
    80003090:	e46e                	sd	s11,8(sp)
    80003092:	1880                	addi	s0,sp,112
    80003094:	8b2a                	mv	s6,a0
    80003096:	8c2e                	mv	s8,a1
    80003098:	8ab2                	mv	s5,a2
    8000309a:	84b6                	mv	s1,a3
    8000309c:	8bba                	mv	s7,a4
  if(off > ip->size || off + n < off)
    8000309e:	00e687bb          	addw	a5,a3,a4
    800030a2:	0ed7e263          	bltu	a5,a3,80003186 <writei+0x116>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    800030a6:	00043737          	lui	a4,0x43
    800030aa:	0ef76063          	bltu	a4,a5,8000318a <writei+0x11a>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800030ae:	0c0b8863          	beqz	s7,8000317e <writei+0x10e>
    800030b2:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    800030b4:	40000d13          	li	s10,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    800030b8:	5cfd                	li	s9,-1
    800030ba:	a091                	j	800030fe <writei+0x8e>
    800030bc:	02091d93          	slli	s11,s2,0x20
    800030c0:	020ddd93          	srli	s11,s11,0x20
    800030c4:	058a0513          	addi	a0,s4,88 # 2058 <_entry-0x7fffdfa8>
    800030c8:	86ee                	mv	a3,s11
    800030ca:	8656                	mv	a2,s5
    800030cc:	85e2                	mv	a1,s8
    800030ce:	953a                	add	a0,a0,a4
    800030d0:	fffff097          	auipc	ra,0xfffff
    800030d4:	914080e7          	jalr	-1772(ra) # 800019e4 <either_copyin>
    800030d8:	07950263          	beq	a0,s9,8000313c <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    800030dc:	8552                	mv	a0,s4
    800030de:	00000097          	auipc	ra,0x0
    800030e2:	790080e7          	jalr	1936(ra) # 8000386e <log_write>
    brelse(bp);
    800030e6:	8552                	mv	a0,s4
    800030e8:	fffff097          	auipc	ra,0xfffff
    800030ec:	4ce080e7          	jalr	1230(ra) # 800025b6 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800030f0:	013909bb          	addw	s3,s2,s3
    800030f4:	009904bb          	addw	s1,s2,s1
    800030f8:	9aee                	add	s5,s5,s11
    800030fa:	0579f663          	bgeu	s3,s7,80003146 <writei+0xd6>
    uint addr = bmap(ip, off/BSIZE);
    800030fe:	00a4d59b          	srliw	a1,s1,0xa
    80003102:	855a                	mv	a0,s6
    80003104:	fffff097          	auipc	ra,0xfffff
    80003108:	79c080e7          	jalr	1948(ra) # 800028a0 <bmap>
    8000310c:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    80003110:	c99d                	beqz	a1,80003146 <writei+0xd6>
    bp = bread(ip->dev, addr);
    80003112:	000b2503          	lw	a0,0(s6)
    80003116:	fffff097          	auipc	ra,0xfffff
    8000311a:	35e080e7          	jalr	862(ra) # 80002474 <bread>
    8000311e:	8a2a                	mv	s4,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003120:	3ff4f713          	andi	a4,s1,1023
    80003124:	40ed07bb          	subw	a5,s10,a4
    80003128:	413b86bb          	subw	a3,s7,s3
    8000312c:	893e                	mv	s2,a5
    8000312e:	2781                	sext.w	a5,a5
    80003130:	0006861b          	sext.w	a2,a3
    80003134:	f8f674e3          	bgeu	a2,a5,800030bc <writei+0x4c>
    80003138:	8936                	mv	s2,a3
    8000313a:	b749                	j	800030bc <writei+0x4c>
      brelse(bp);
    8000313c:	8552                	mv	a0,s4
    8000313e:	fffff097          	auipc	ra,0xfffff
    80003142:	478080e7          	jalr	1144(ra) # 800025b6 <brelse>
  }

  if(off > ip->size)
    80003146:	04cb2783          	lw	a5,76(s6)
    8000314a:	0097f463          	bgeu	a5,s1,80003152 <writei+0xe2>
    ip->size = off;
    8000314e:	049b2623          	sw	s1,76(s6)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80003152:	855a                	mv	a0,s6
    80003154:	00000097          	auipc	ra,0x0
    80003158:	aa2080e7          	jalr	-1374(ra) # 80002bf6 <iupdate>

  return tot;
    8000315c:	0009851b          	sext.w	a0,s3
}
    80003160:	70a6                	ld	ra,104(sp)
    80003162:	7406                	ld	s0,96(sp)
    80003164:	64e6                	ld	s1,88(sp)
    80003166:	6946                	ld	s2,80(sp)
    80003168:	69a6                	ld	s3,72(sp)
    8000316a:	6a06                	ld	s4,64(sp)
    8000316c:	7ae2                	ld	s5,56(sp)
    8000316e:	7b42                	ld	s6,48(sp)
    80003170:	7ba2                	ld	s7,40(sp)
    80003172:	7c02                	ld	s8,32(sp)
    80003174:	6ce2                	ld	s9,24(sp)
    80003176:	6d42                	ld	s10,16(sp)
    80003178:	6da2                	ld	s11,8(sp)
    8000317a:	6165                	addi	sp,sp,112
    8000317c:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    8000317e:	89de                	mv	s3,s7
    80003180:	bfc9                	j	80003152 <writei+0xe2>
    return -1;
    80003182:	557d                	li	a0,-1
}
    80003184:	8082                	ret
    return -1;
    80003186:	557d                	li	a0,-1
    80003188:	bfe1                	j	80003160 <writei+0xf0>
    return -1;
    8000318a:	557d                	li	a0,-1
    8000318c:	bfd1                	j	80003160 <writei+0xf0>

000000008000318e <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    8000318e:	1141                	addi	sp,sp,-16
    80003190:	e406                	sd	ra,8(sp)
    80003192:	e022                	sd	s0,0(sp)
    80003194:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80003196:	4639                	li	a2,14
    80003198:	ffffd097          	auipc	ra,0xffffd
    8000319c:	110080e7          	jalr	272(ra) # 800002a8 <strncmp>
}
    800031a0:	60a2                	ld	ra,8(sp)
    800031a2:	6402                	ld	s0,0(sp)
    800031a4:	0141                	addi	sp,sp,16
    800031a6:	8082                	ret

00000000800031a8 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    800031a8:	7139                	addi	sp,sp,-64
    800031aa:	fc06                	sd	ra,56(sp)
    800031ac:	f822                	sd	s0,48(sp)
    800031ae:	f426                	sd	s1,40(sp)
    800031b0:	f04a                	sd	s2,32(sp)
    800031b2:	ec4e                	sd	s3,24(sp)
    800031b4:	e852                	sd	s4,16(sp)
    800031b6:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    800031b8:	04451703          	lh	a4,68(a0)
    800031bc:	4785                	li	a5,1
    800031be:	00f71a63          	bne	a4,a5,800031d2 <dirlookup+0x2a>
    800031c2:	892a                	mv	s2,a0
    800031c4:	89ae                	mv	s3,a1
    800031c6:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    800031c8:	457c                	lw	a5,76(a0)
    800031ca:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    800031cc:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    800031ce:	e79d                	bnez	a5,800031fc <dirlookup+0x54>
    800031d0:	a8a5                	j	80003248 <dirlookup+0xa0>
    panic("dirlookup not DIR");
    800031d2:	00005517          	auipc	a0,0x5
    800031d6:	56e50513          	addi	a0,a0,1390 # 80008740 <str_syscalls+0x2a0>
    800031da:	00003097          	auipc	ra,0x3
    800031de:	c52080e7          	jalr	-942(ra) # 80005e2c <panic>
      panic("dirlookup read");
    800031e2:	00005517          	auipc	a0,0x5
    800031e6:	57650513          	addi	a0,a0,1398 # 80008758 <str_syscalls+0x2b8>
    800031ea:	00003097          	auipc	ra,0x3
    800031ee:	c42080e7          	jalr	-958(ra) # 80005e2c <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800031f2:	24c1                	addiw	s1,s1,16
    800031f4:	04c92783          	lw	a5,76(s2)
    800031f8:	04f4f763          	bgeu	s1,a5,80003246 <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800031fc:	4741                	li	a4,16
    800031fe:	86a6                	mv	a3,s1
    80003200:	fc040613          	addi	a2,s0,-64
    80003204:	4581                	li	a1,0
    80003206:	854a                	mv	a0,s2
    80003208:	00000097          	auipc	ra,0x0
    8000320c:	d70080e7          	jalr	-656(ra) # 80002f78 <readi>
    80003210:	47c1                	li	a5,16
    80003212:	fcf518e3          	bne	a0,a5,800031e2 <dirlookup+0x3a>
    if(de.inum == 0)
    80003216:	fc045783          	lhu	a5,-64(s0)
    8000321a:	dfe1                	beqz	a5,800031f2 <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    8000321c:	fc240593          	addi	a1,s0,-62
    80003220:	854e                	mv	a0,s3
    80003222:	00000097          	auipc	ra,0x0
    80003226:	f6c080e7          	jalr	-148(ra) # 8000318e <namecmp>
    8000322a:	f561                	bnez	a0,800031f2 <dirlookup+0x4a>
      if(poff)
    8000322c:	000a0463          	beqz	s4,80003234 <dirlookup+0x8c>
        *poff = off;
    80003230:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    80003234:	fc045583          	lhu	a1,-64(s0)
    80003238:	00092503          	lw	a0,0(s2)
    8000323c:	fffff097          	auipc	ra,0xfffff
    80003240:	74c080e7          	jalr	1868(ra) # 80002988 <iget>
    80003244:	a011                	j	80003248 <dirlookup+0xa0>
  return 0;
    80003246:	4501                	li	a0,0
}
    80003248:	70e2                	ld	ra,56(sp)
    8000324a:	7442                	ld	s0,48(sp)
    8000324c:	74a2                	ld	s1,40(sp)
    8000324e:	7902                	ld	s2,32(sp)
    80003250:	69e2                	ld	s3,24(sp)
    80003252:	6a42                	ld	s4,16(sp)
    80003254:	6121                	addi	sp,sp,64
    80003256:	8082                	ret

0000000080003258 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80003258:	711d                	addi	sp,sp,-96
    8000325a:	ec86                	sd	ra,88(sp)
    8000325c:	e8a2                	sd	s0,80(sp)
    8000325e:	e4a6                	sd	s1,72(sp)
    80003260:	e0ca                	sd	s2,64(sp)
    80003262:	fc4e                	sd	s3,56(sp)
    80003264:	f852                	sd	s4,48(sp)
    80003266:	f456                	sd	s5,40(sp)
    80003268:	f05a                	sd	s6,32(sp)
    8000326a:	ec5e                	sd	s7,24(sp)
    8000326c:	e862                	sd	s8,16(sp)
    8000326e:	e466                	sd	s9,8(sp)
    80003270:	1080                	addi	s0,sp,96
    80003272:	84aa                	mv	s1,a0
    80003274:	8bae                	mv	s7,a1
    80003276:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    80003278:	00054703          	lbu	a4,0(a0)
    8000327c:	02f00793          	li	a5,47
    80003280:	02f70363          	beq	a4,a5,800032a6 <namex+0x4e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80003284:	ffffe097          	auipc	ra,0xffffe
    80003288:	c50080e7          	jalr	-944(ra) # 80000ed4 <myproc>
    8000328c:	15053503          	ld	a0,336(a0)
    80003290:	00000097          	auipc	ra,0x0
    80003294:	9f4080e7          	jalr	-1548(ra) # 80002c84 <idup>
    80003298:	89aa                	mv	s3,a0
  while(*path == '/')
    8000329a:	02f00913          	li	s2,47
  len = path - s;
    8000329e:	4b01                	li	s6,0
  if(len >= DIRSIZ)
    800032a0:	4cb5                	li	s9,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    800032a2:	4c05                	li	s8,1
    800032a4:	a865                	j	8000335c <namex+0x104>
    ip = iget(ROOTDEV, ROOTINO);
    800032a6:	4585                	li	a1,1
    800032a8:	4505                	li	a0,1
    800032aa:	fffff097          	auipc	ra,0xfffff
    800032ae:	6de080e7          	jalr	1758(ra) # 80002988 <iget>
    800032b2:	89aa                	mv	s3,a0
    800032b4:	b7dd                	j	8000329a <namex+0x42>
      iunlockput(ip);
    800032b6:	854e                	mv	a0,s3
    800032b8:	00000097          	auipc	ra,0x0
    800032bc:	c6e080e7          	jalr	-914(ra) # 80002f26 <iunlockput>
      return 0;
    800032c0:	4981                	li	s3,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    800032c2:	854e                	mv	a0,s3
    800032c4:	60e6                	ld	ra,88(sp)
    800032c6:	6446                	ld	s0,80(sp)
    800032c8:	64a6                	ld	s1,72(sp)
    800032ca:	6906                	ld	s2,64(sp)
    800032cc:	79e2                	ld	s3,56(sp)
    800032ce:	7a42                	ld	s4,48(sp)
    800032d0:	7aa2                	ld	s5,40(sp)
    800032d2:	7b02                	ld	s6,32(sp)
    800032d4:	6be2                	ld	s7,24(sp)
    800032d6:	6c42                	ld	s8,16(sp)
    800032d8:	6ca2                	ld	s9,8(sp)
    800032da:	6125                	addi	sp,sp,96
    800032dc:	8082                	ret
      iunlock(ip);
    800032de:	854e                	mv	a0,s3
    800032e0:	00000097          	auipc	ra,0x0
    800032e4:	aa6080e7          	jalr	-1370(ra) # 80002d86 <iunlock>
      return ip;
    800032e8:	bfe9                	j	800032c2 <namex+0x6a>
      iunlockput(ip);
    800032ea:	854e                	mv	a0,s3
    800032ec:	00000097          	auipc	ra,0x0
    800032f0:	c3a080e7          	jalr	-966(ra) # 80002f26 <iunlockput>
      return 0;
    800032f4:	89d2                	mv	s3,s4
    800032f6:	b7f1                	j	800032c2 <namex+0x6a>
  len = path - s;
    800032f8:	40b48633          	sub	a2,s1,a1
    800032fc:	00060a1b          	sext.w	s4,a2
  if(len >= DIRSIZ)
    80003300:	094cd663          	bge	s9,s4,8000338c <namex+0x134>
    memmove(name, s, DIRSIZ);
    80003304:	4639                	li	a2,14
    80003306:	8556                	mv	a0,s5
    80003308:	ffffd097          	auipc	ra,0xffffd
    8000330c:	f28080e7          	jalr	-216(ra) # 80000230 <memmove>
  while(*path == '/')
    80003310:	0004c783          	lbu	a5,0(s1)
    80003314:	01279763          	bne	a5,s2,80003322 <namex+0xca>
    path++;
    80003318:	0485                	addi	s1,s1,1
  while(*path == '/')
    8000331a:	0004c783          	lbu	a5,0(s1)
    8000331e:	ff278de3          	beq	a5,s2,80003318 <namex+0xc0>
    ilock(ip);
    80003322:	854e                	mv	a0,s3
    80003324:	00000097          	auipc	ra,0x0
    80003328:	99e080e7          	jalr	-1634(ra) # 80002cc2 <ilock>
    if(ip->type != T_DIR){
    8000332c:	04499783          	lh	a5,68(s3)
    80003330:	f98793e3          	bne	a5,s8,800032b6 <namex+0x5e>
    if(nameiparent && *path == '\0'){
    80003334:	000b8563          	beqz	s7,8000333e <namex+0xe6>
    80003338:	0004c783          	lbu	a5,0(s1)
    8000333c:	d3cd                	beqz	a5,800032de <namex+0x86>
    if((next = dirlookup(ip, name, 0)) == 0){
    8000333e:	865a                	mv	a2,s6
    80003340:	85d6                	mv	a1,s5
    80003342:	854e                	mv	a0,s3
    80003344:	00000097          	auipc	ra,0x0
    80003348:	e64080e7          	jalr	-412(ra) # 800031a8 <dirlookup>
    8000334c:	8a2a                	mv	s4,a0
    8000334e:	dd51                	beqz	a0,800032ea <namex+0x92>
    iunlockput(ip);
    80003350:	854e                	mv	a0,s3
    80003352:	00000097          	auipc	ra,0x0
    80003356:	bd4080e7          	jalr	-1068(ra) # 80002f26 <iunlockput>
    ip = next;
    8000335a:	89d2                	mv	s3,s4
  while(*path == '/')
    8000335c:	0004c783          	lbu	a5,0(s1)
    80003360:	05279d63          	bne	a5,s2,800033ba <namex+0x162>
    path++;
    80003364:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003366:	0004c783          	lbu	a5,0(s1)
    8000336a:	ff278de3          	beq	a5,s2,80003364 <namex+0x10c>
  if(*path == 0)
    8000336e:	cf8d                	beqz	a5,800033a8 <namex+0x150>
  while(*path != '/' && *path != 0)
    80003370:	01278b63          	beq	a5,s2,80003386 <namex+0x12e>
    80003374:	c795                	beqz	a5,800033a0 <namex+0x148>
    path++;
    80003376:	85a6                	mv	a1,s1
    path++;
    80003378:	0485                	addi	s1,s1,1
  while(*path != '/' && *path != 0)
    8000337a:	0004c783          	lbu	a5,0(s1)
    8000337e:	f7278de3          	beq	a5,s2,800032f8 <namex+0xa0>
    80003382:	fbfd                	bnez	a5,80003378 <namex+0x120>
    80003384:	bf95                	j	800032f8 <namex+0xa0>
    80003386:	85a6                	mv	a1,s1
  len = path - s;
    80003388:	8a5a                	mv	s4,s6
    8000338a:	865a                	mv	a2,s6
    memmove(name, s, len);
    8000338c:	2601                	sext.w	a2,a2
    8000338e:	8556                	mv	a0,s5
    80003390:	ffffd097          	auipc	ra,0xffffd
    80003394:	ea0080e7          	jalr	-352(ra) # 80000230 <memmove>
    name[len] = 0;
    80003398:	9a56                	add	s4,s4,s5
    8000339a:	000a0023          	sb	zero,0(s4)
    8000339e:	bf8d                	j	80003310 <namex+0xb8>
  while(*path != '/' && *path != 0)
    800033a0:	85a6                	mv	a1,s1
  len = path - s;
    800033a2:	8a5a                	mv	s4,s6
    800033a4:	865a                	mv	a2,s6
    800033a6:	b7dd                	j	8000338c <namex+0x134>
  if(nameiparent){
    800033a8:	f00b8de3          	beqz	s7,800032c2 <namex+0x6a>
    iput(ip);
    800033ac:	854e                	mv	a0,s3
    800033ae:	00000097          	auipc	ra,0x0
    800033b2:	ad0080e7          	jalr	-1328(ra) # 80002e7e <iput>
    return 0;
    800033b6:	4981                	li	s3,0
    800033b8:	b729                	j	800032c2 <namex+0x6a>
  if(*path == 0)
    800033ba:	d7fd                	beqz	a5,800033a8 <namex+0x150>
    800033bc:	85a6                	mv	a1,s1
    800033be:	bf6d                	j	80003378 <namex+0x120>

00000000800033c0 <dirlink>:
{
    800033c0:	7139                	addi	sp,sp,-64
    800033c2:	fc06                	sd	ra,56(sp)
    800033c4:	f822                	sd	s0,48(sp)
    800033c6:	f426                	sd	s1,40(sp)
    800033c8:	f04a                	sd	s2,32(sp)
    800033ca:	ec4e                	sd	s3,24(sp)
    800033cc:	e852                	sd	s4,16(sp)
    800033ce:	0080                	addi	s0,sp,64
    800033d0:	892a                	mv	s2,a0
    800033d2:	8a2e                	mv	s4,a1
    800033d4:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    800033d6:	4601                	li	a2,0
    800033d8:	00000097          	auipc	ra,0x0
    800033dc:	dd0080e7          	jalr	-560(ra) # 800031a8 <dirlookup>
    800033e0:	e93d                	bnez	a0,80003456 <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800033e2:	04c92483          	lw	s1,76(s2)
    800033e6:	c49d                	beqz	s1,80003414 <dirlink+0x54>
    800033e8:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800033ea:	4741                	li	a4,16
    800033ec:	86a6                	mv	a3,s1
    800033ee:	fc040613          	addi	a2,s0,-64
    800033f2:	4581                	li	a1,0
    800033f4:	854a                	mv	a0,s2
    800033f6:	00000097          	auipc	ra,0x0
    800033fa:	b82080e7          	jalr	-1150(ra) # 80002f78 <readi>
    800033fe:	47c1                	li	a5,16
    80003400:	06f51163          	bne	a0,a5,80003462 <dirlink+0xa2>
    if(de.inum == 0)
    80003404:	fc045783          	lhu	a5,-64(s0)
    80003408:	c791                	beqz	a5,80003414 <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000340a:	24c1                	addiw	s1,s1,16
    8000340c:	04c92783          	lw	a5,76(s2)
    80003410:	fcf4ede3          	bltu	s1,a5,800033ea <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    80003414:	4639                	li	a2,14
    80003416:	85d2                	mv	a1,s4
    80003418:	fc240513          	addi	a0,s0,-62
    8000341c:	ffffd097          	auipc	ra,0xffffd
    80003420:	edc080e7          	jalr	-292(ra) # 800002f8 <strncpy>
  de.inum = inum;
    80003424:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003428:	4741                	li	a4,16
    8000342a:	86a6                	mv	a3,s1
    8000342c:	fc040613          	addi	a2,s0,-64
    80003430:	4581                	li	a1,0
    80003432:	854a                	mv	a0,s2
    80003434:	00000097          	auipc	ra,0x0
    80003438:	c3c080e7          	jalr	-964(ra) # 80003070 <writei>
    8000343c:	1541                	addi	a0,a0,-16
    8000343e:	00a03533          	snez	a0,a0
    80003442:	40a00533          	neg	a0,a0
}
    80003446:	70e2                	ld	ra,56(sp)
    80003448:	7442                	ld	s0,48(sp)
    8000344a:	74a2                	ld	s1,40(sp)
    8000344c:	7902                	ld	s2,32(sp)
    8000344e:	69e2                	ld	s3,24(sp)
    80003450:	6a42                	ld	s4,16(sp)
    80003452:	6121                	addi	sp,sp,64
    80003454:	8082                	ret
    iput(ip);
    80003456:	00000097          	auipc	ra,0x0
    8000345a:	a28080e7          	jalr	-1496(ra) # 80002e7e <iput>
    return -1;
    8000345e:	557d                	li	a0,-1
    80003460:	b7dd                	j	80003446 <dirlink+0x86>
      panic("dirlink read");
    80003462:	00005517          	auipc	a0,0x5
    80003466:	30650513          	addi	a0,a0,774 # 80008768 <str_syscalls+0x2c8>
    8000346a:	00003097          	auipc	ra,0x3
    8000346e:	9c2080e7          	jalr	-1598(ra) # 80005e2c <panic>

0000000080003472 <namei>:

struct inode*
namei(char *path)
{
    80003472:	1101                	addi	sp,sp,-32
    80003474:	ec06                	sd	ra,24(sp)
    80003476:	e822                	sd	s0,16(sp)
    80003478:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    8000347a:	fe040613          	addi	a2,s0,-32
    8000347e:	4581                	li	a1,0
    80003480:	00000097          	auipc	ra,0x0
    80003484:	dd8080e7          	jalr	-552(ra) # 80003258 <namex>
}
    80003488:	60e2                	ld	ra,24(sp)
    8000348a:	6442                	ld	s0,16(sp)
    8000348c:	6105                	addi	sp,sp,32
    8000348e:	8082                	ret

0000000080003490 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80003490:	1141                	addi	sp,sp,-16
    80003492:	e406                	sd	ra,8(sp)
    80003494:	e022                	sd	s0,0(sp)
    80003496:	0800                	addi	s0,sp,16
  return namex(path, 1, name);
    80003498:	862e                	mv	a2,a1
    8000349a:	4585                	li	a1,1
    8000349c:	00000097          	auipc	ra,0x0
    800034a0:	dbc080e7          	jalr	-580(ra) # 80003258 <namex>
}
    800034a4:	60a2                	ld	ra,8(sp)
    800034a6:	6402                	ld	s0,0(sp)
    800034a8:	0141                	addi	sp,sp,16
    800034aa:	8082                	ret

00000000800034ac <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    800034ac:	1101                	addi	sp,sp,-32
    800034ae:	ec06                	sd	ra,24(sp)
    800034b0:	e822                	sd	s0,16(sp)
    800034b2:	e426                	sd	s1,8(sp)
    800034b4:	e04a                	sd	s2,0(sp)
    800034b6:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    800034b8:	00015917          	auipc	s2,0x15
    800034bc:	7c890913          	addi	s2,s2,1992 # 80018c80 <log>
    800034c0:	01892583          	lw	a1,24(s2)
    800034c4:	02892503          	lw	a0,40(s2)
    800034c8:	fffff097          	auipc	ra,0xfffff
    800034cc:	fac080e7          	jalr	-84(ra) # 80002474 <bread>
    800034d0:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    800034d2:	02c92683          	lw	a3,44(s2)
    800034d6:	cd34                	sw	a3,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    800034d8:	02d05763          	blez	a3,80003506 <write_head+0x5a>
    800034dc:	00015797          	auipc	a5,0x15
    800034e0:	7d478793          	addi	a5,a5,2004 # 80018cb0 <log+0x30>
    800034e4:	05c50713          	addi	a4,a0,92
    800034e8:	36fd                	addiw	a3,a3,-1
    800034ea:	1682                	slli	a3,a3,0x20
    800034ec:	9281                	srli	a3,a3,0x20
    800034ee:	068a                	slli	a3,a3,0x2
    800034f0:	00015617          	auipc	a2,0x15
    800034f4:	7c460613          	addi	a2,a2,1988 # 80018cb4 <log+0x34>
    800034f8:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    800034fa:	4390                	lw	a2,0(a5)
    800034fc:	c310                	sw	a2,0(a4)
    800034fe:	0791                	addi	a5,a5,4
    80003500:	0711                	addi	a4,a4,4
  for (i = 0; i < log.lh.n; i++) {
    80003502:	fed79ce3          	bne	a5,a3,800034fa <write_head+0x4e>
  }
  bwrite(buf);
    80003506:	8526                	mv	a0,s1
    80003508:	fffff097          	auipc	ra,0xfffff
    8000350c:	070080e7          	jalr	112(ra) # 80002578 <bwrite>
  brelse(buf);
    80003510:	8526                	mv	a0,s1
    80003512:	fffff097          	auipc	ra,0xfffff
    80003516:	0a4080e7          	jalr	164(ra) # 800025b6 <brelse>
}
    8000351a:	60e2                	ld	ra,24(sp)
    8000351c:	6442                	ld	s0,16(sp)
    8000351e:	64a2                	ld	s1,8(sp)
    80003520:	6902                	ld	s2,0(sp)
    80003522:	6105                	addi	sp,sp,32
    80003524:	8082                	ret

0000000080003526 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    80003526:	00015797          	auipc	a5,0x15
    8000352a:	75a78793          	addi	a5,a5,1882 # 80018c80 <log>
    8000352e:	57dc                	lw	a5,44(a5)
    80003530:	0af05d63          	blez	a5,800035ea <install_trans+0xc4>
{
    80003534:	7139                	addi	sp,sp,-64
    80003536:	fc06                	sd	ra,56(sp)
    80003538:	f822                	sd	s0,48(sp)
    8000353a:	f426                	sd	s1,40(sp)
    8000353c:	f04a                	sd	s2,32(sp)
    8000353e:	ec4e                	sd	s3,24(sp)
    80003540:	e852                	sd	s4,16(sp)
    80003542:	e456                	sd	s5,8(sp)
    80003544:	e05a                	sd	s6,0(sp)
    80003546:	0080                	addi	s0,sp,64
    80003548:	8b2a                	mv	s6,a0
    8000354a:	00015a17          	auipc	s4,0x15
    8000354e:	766a0a13          	addi	s4,s4,1894 # 80018cb0 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003552:	4981                	li	s3,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003554:	00015917          	auipc	s2,0x15
    80003558:	72c90913          	addi	s2,s2,1836 # 80018c80 <log>
    8000355c:	a035                	j	80003588 <install_trans+0x62>
      bunpin(dbuf);
    8000355e:	8526                	mv	a0,s1
    80003560:	fffff097          	auipc	ra,0xfffff
    80003564:	130080e7          	jalr	304(ra) # 80002690 <bunpin>
    brelse(lbuf);
    80003568:	8556                	mv	a0,s5
    8000356a:	fffff097          	auipc	ra,0xfffff
    8000356e:	04c080e7          	jalr	76(ra) # 800025b6 <brelse>
    brelse(dbuf);
    80003572:	8526                	mv	a0,s1
    80003574:	fffff097          	auipc	ra,0xfffff
    80003578:	042080e7          	jalr	66(ra) # 800025b6 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000357c:	2985                	addiw	s3,s3,1
    8000357e:	0a11                	addi	s4,s4,4
    80003580:	02c92783          	lw	a5,44(s2)
    80003584:	04f9d963          	bge	s3,a5,800035d6 <install_trans+0xb0>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003588:	01892583          	lw	a1,24(s2)
    8000358c:	013585bb          	addw	a1,a1,s3
    80003590:	2585                	addiw	a1,a1,1
    80003592:	02892503          	lw	a0,40(s2)
    80003596:	fffff097          	auipc	ra,0xfffff
    8000359a:	ede080e7          	jalr	-290(ra) # 80002474 <bread>
    8000359e:	8aaa                	mv	s5,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    800035a0:	000a2583          	lw	a1,0(s4)
    800035a4:	02892503          	lw	a0,40(s2)
    800035a8:	fffff097          	auipc	ra,0xfffff
    800035ac:	ecc080e7          	jalr	-308(ra) # 80002474 <bread>
    800035b0:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    800035b2:	40000613          	li	a2,1024
    800035b6:	058a8593          	addi	a1,s5,88
    800035ba:	05850513          	addi	a0,a0,88
    800035be:	ffffd097          	auipc	ra,0xffffd
    800035c2:	c72080e7          	jalr	-910(ra) # 80000230 <memmove>
    bwrite(dbuf);  // write dst to disk
    800035c6:	8526                	mv	a0,s1
    800035c8:	fffff097          	auipc	ra,0xfffff
    800035cc:	fb0080e7          	jalr	-80(ra) # 80002578 <bwrite>
    if(recovering == 0)
    800035d0:	f80b1ce3          	bnez	s6,80003568 <install_trans+0x42>
    800035d4:	b769                	j	8000355e <install_trans+0x38>
}
    800035d6:	70e2                	ld	ra,56(sp)
    800035d8:	7442                	ld	s0,48(sp)
    800035da:	74a2                	ld	s1,40(sp)
    800035dc:	7902                	ld	s2,32(sp)
    800035de:	69e2                	ld	s3,24(sp)
    800035e0:	6a42                	ld	s4,16(sp)
    800035e2:	6aa2                	ld	s5,8(sp)
    800035e4:	6b02                	ld	s6,0(sp)
    800035e6:	6121                	addi	sp,sp,64
    800035e8:	8082                	ret
    800035ea:	8082                	ret

00000000800035ec <initlog>:
{
    800035ec:	7179                	addi	sp,sp,-48
    800035ee:	f406                	sd	ra,40(sp)
    800035f0:	f022                	sd	s0,32(sp)
    800035f2:	ec26                	sd	s1,24(sp)
    800035f4:	e84a                	sd	s2,16(sp)
    800035f6:	e44e                	sd	s3,8(sp)
    800035f8:	1800                	addi	s0,sp,48
    800035fa:	892a                	mv	s2,a0
    800035fc:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    800035fe:	00015497          	auipc	s1,0x15
    80003602:	68248493          	addi	s1,s1,1666 # 80018c80 <log>
    80003606:	00005597          	auipc	a1,0x5
    8000360a:	17258593          	addi	a1,a1,370 # 80008778 <str_syscalls+0x2d8>
    8000360e:	8526                	mv	a0,s1
    80003610:	00003097          	auipc	ra,0x3
    80003614:	cf4080e7          	jalr	-780(ra) # 80006304 <initlock>
  log.start = sb->logstart;
    80003618:	0149a583          	lw	a1,20(s3)
    8000361c:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    8000361e:	0109a783          	lw	a5,16(s3)
    80003622:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    80003624:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    80003628:	854a                	mv	a0,s2
    8000362a:	fffff097          	auipc	ra,0xfffff
    8000362e:	e4a080e7          	jalr	-438(ra) # 80002474 <bread>
  log.lh.n = lh->n;
    80003632:	4d3c                	lw	a5,88(a0)
    80003634:	d4dc                	sw	a5,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    80003636:	02f05563          	blez	a5,80003660 <initlog+0x74>
    8000363a:	05c50713          	addi	a4,a0,92
    8000363e:	00015697          	auipc	a3,0x15
    80003642:	67268693          	addi	a3,a3,1650 # 80018cb0 <log+0x30>
    80003646:	37fd                	addiw	a5,a5,-1
    80003648:	1782                	slli	a5,a5,0x20
    8000364a:	9381                	srli	a5,a5,0x20
    8000364c:	078a                	slli	a5,a5,0x2
    8000364e:	06050613          	addi	a2,a0,96
    80003652:	97b2                	add	a5,a5,a2
    log.lh.block[i] = lh->block[i];
    80003654:	4310                	lw	a2,0(a4)
    80003656:	c290                	sw	a2,0(a3)
    80003658:	0711                	addi	a4,a4,4
    8000365a:	0691                	addi	a3,a3,4
  for (i = 0; i < log.lh.n; i++) {
    8000365c:	fef71ce3          	bne	a4,a5,80003654 <initlog+0x68>
  brelse(buf);
    80003660:	fffff097          	auipc	ra,0xfffff
    80003664:	f56080e7          	jalr	-170(ra) # 800025b6 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    80003668:	4505                	li	a0,1
    8000366a:	00000097          	auipc	ra,0x0
    8000366e:	ebc080e7          	jalr	-324(ra) # 80003526 <install_trans>
  log.lh.n = 0;
    80003672:	00015797          	auipc	a5,0x15
    80003676:	6207ad23          	sw	zero,1594(a5) # 80018cac <log+0x2c>
  write_head(); // clear the log
    8000367a:	00000097          	auipc	ra,0x0
    8000367e:	e32080e7          	jalr	-462(ra) # 800034ac <write_head>
}
    80003682:	70a2                	ld	ra,40(sp)
    80003684:	7402                	ld	s0,32(sp)
    80003686:	64e2                	ld	s1,24(sp)
    80003688:	6942                	ld	s2,16(sp)
    8000368a:	69a2                	ld	s3,8(sp)
    8000368c:	6145                	addi	sp,sp,48
    8000368e:	8082                	ret

0000000080003690 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80003690:	1101                	addi	sp,sp,-32
    80003692:	ec06                	sd	ra,24(sp)
    80003694:	e822                	sd	s0,16(sp)
    80003696:	e426                	sd	s1,8(sp)
    80003698:	e04a                	sd	s2,0(sp)
    8000369a:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    8000369c:	00015517          	auipc	a0,0x15
    800036a0:	5e450513          	addi	a0,a0,1508 # 80018c80 <log>
    800036a4:	00003097          	auipc	ra,0x3
    800036a8:	cf0080e7          	jalr	-784(ra) # 80006394 <acquire>
  while(1){
    if(log.committing){
    800036ac:	00015497          	auipc	s1,0x15
    800036b0:	5d448493          	addi	s1,s1,1492 # 80018c80 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    800036b4:	4979                	li	s2,30
    800036b6:	a039                	j	800036c4 <begin_op+0x34>
      sleep(&log, &log.lock);
    800036b8:	85a6                	mv	a1,s1
    800036ba:	8526                	mv	a0,s1
    800036bc:	ffffe097          	auipc	ra,0xffffe
    800036c0:	ec8080e7          	jalr	-312(ra) # 80001584 <sleep>
    if(log.committing){
    800036c4:	50dc                	lw	a5,36(s1)
    800036c6:	fbed                	bnez	a5,800036b8 <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    800036c8:	509c                	lw	a5,32(s1)
    800036ca:	0017871b          	addiw	a4,a5,1
    800036ce:	0007069b          	sext.w	a3,a4
    800036d2:	0027179b          	slliw	a5,a4,0x2
    800036d6:	9fb9                	addw	a5,a5,a4
    800036d8:	0017979b          	slliw	a5,a5,0x1
    800036dc:	54d8                	lw	a4,44(s1)
    800036de:	9fb9                	addw	a5,a5,a4
    800036e0:	00f95963          	bge	s2,a5,800036f2 <begin_op+0x62>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    800036e4:	85a6                	mv	a1,s1
    800036e6:	8526                	mv	a0,s1
    800036e8:	ffffe097          	auipc	ra,0xffffe
    800036ec:	e9c080e7          	jalr	-356(ra) # 80001584 <sleep>
    800036f0:	bfd1                	j	800036c4 <begin_op+0x34>
    } else {
      log.outstanding += 1;
    800036f2:	00015517          	auipc	a0,0x15
    800036f6:	58e50513          	addi	a0,a0,1422 # 80018c80 <log>
    800036fa:	d114                	sw	a3,32(a0)
      release(&log.lock);
    800036fc:	00003097          	auipc	ra,0x3
    80003700:	d4c080e7          	jalr	-692(ra) # 80006448 <release>
      break;
    }
  }
}
    80003704:	60e2                	ld	ra,24(sp)
    80003706:	6442                	ld	s0,16(sp)
    80003708:	64a2                	ld	s1,8(sp)
    8000370a:	6902                	ld	s2,0(sp)
    8000370c:	6105                	addi	sp,sp,32
    8000370e:	8082                	ret

0000000080003710 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80003710:	7139                	addi	sp,sp,-64
    80003712:	fc06                	sd	ra,56(sp)
    80003714:	f822                	sd	s0,48(sp)
    80003716:	f426                	sd	s1,40(sp)
    80003718:	f04a                	sd	s2,32(sp)
    8000371a:	ec4e                	sd	s3,24(sp)
    8000371c:	e852                	sd	s4,16(sp)
    8000371e:	e456                	sd	s5,8(sp)
    80003720:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80003722:	00015917          	auipc	s2,0x15
    80003726:	55e90913          	addi	s2,s2,1374 # 80018c80 <log>
    8000372a:	854a                	mv	a0,s2
    8000372c:	00003097          	auipc	ra,0x3
    80003730:	c68080e7          	jalr	-920(ra) # 80006394 <acquire>
  log.outstanding -= 1;
    80003734:	02092783          	lw	a5,32(s2)
    80003738:	37fd                	addiw	a5,a5,-1
    8000373a:	0007849b          	sext.w	s1,a5
    8000373e:	02f92023          	sw	a5,32(s2)
  if(log.committing)
    80003742:	02492783          	lw	a5,36(s2)
    80003746:	eba1                	bnez	a5,80003796 <end_op+0x86>
    panic("log.committing");
  if(log.outstanding == 0){
    80003748:	ecb9                	bnez	s1,800037a6 <end_op+0x96>
    do_commit = 1;
    log.committing = 1;
    8000374a:	00015917          	auipc	s2,0x15
    8000374e:	53690913          	addi	s2,s2,1334 # 80018c80 <log>
    80003752:	4785                	li	a5,1
    80003754:	02f92223          	sw	a5,36(s2)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    80003758:	854a                	mv	a0,s2
    8000375a:	00003097          	auipc	ra,0x3
    8000375e:	cee080e7          	jalr	-786(ra) # 80006448 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    80003762:	02c92783          	lw	a5,44(s2)
    80003766:	06f04763          	bgtz	a5,800037d4 <end_op+0xc4>
    acquire(&log.lock);
    8000376a:	00015497          	auipc	s1,0x15
    8000376e:	51648493          	addi	s1,s1,1302 # 80018c80 <log>
    80003772:	8526                	mv	a0,s1
    80003774:	00003097          	auipc	ra,0x3
    80003778:	c20080e7          	jalr	-992(ra) # 80006394 <acquire>
    log.committing = 0;
    8000377c:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    80003780:	8526                	mv	a0,s1
    80003782:	ffffe097          	auipc	ra,0xffffe
    80003786:	e66080e7          	jalr	-410(ra) # 800015e8 <wakeup>
    release(&log.lock);
    8000378a:	8526                	mv	a0,s1
    8000378c:	00003097          	auipc	ra,0x3
    80003790:	cbc080e7          	jalr	-836(ra) # 80006448 <release>
}
    80003794:	a03d                	j	800037c2 <end_op+0xb2>
    panic("log.committing");
    80003796:	00005517          	auipc	a0,0x5
    8000379a:	fea50513          	addi	a0,a0,-22 # 80008780 <str_syscalls+0x2e0>
    8000379e:	00002097          	auipc	ra,0x2
    800037a2:	68e080e7          	jalr	1678(ra) # 80005e2c <panic>
    wakeup(&log);
    800037a6:	00015497          	auipc	s1,0x15
    800037aa:	4da48493          	addi	s1,s1,1242 # 80018c80 <log>
    800037ae:	8526                	mv	a0,s1
    800037b0:	ffffe097          	auipc	ra,0xffffe
    800037b4:	e38080e7          	jalr	-456(ra) # 800015e8 <wakeup>
  release(&log.lock);
    800037b8:	8526                	mv	a0,s1
    800037ba:	00003097          	auipc	ra,0x3
    800037be:	c8e080e7          	jalr	-882(ra) # 80006448 <release>
}
    800037c2:	70e2                	ld	ra,56(sp)
    800037c4:	7442                	ld	s0,48(sp)
    800037c6:	74a2                	ld	s1,40(sp)
    800037c8:	7902                	ld	s2,32(sp)
    800037ca:	69e2                	ld	s3,24(sp)
    800037cc:	6a42                	ld	s4,16(sp)
    800037ce:	6aa2                	ld	s5,8(sp)
    800037d0:	6121                	addi	sp,sp,64
    800037d2:	8082                	ret
    800037d4:	00015a17          	auipc	s4,0x15
    800037d8:	4dca0a13          	addi	s4,s4,1244 # 80018cb0 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    800037dc:	00015917          	auipc	s2,0x15
    800037e0:	4a490913          	addi	s2,s2,1188 # 80018c80 <log>
    800037e4:	01892583          	lw	a1,24(s2)
    800037e8:	9da5                	addw	a1,a1,s1
    800037ea:	2585                	addiw	a1,a1,1
    800037ec:	02892503          	lw	a0,40(s2)
    800037f0:	fffff097          	auipc	ra,0xfffff
    800037f4:	c84080e7          	jalr	-892(ra) # 80002474 <bread>
    800037f8:	89aa                	mv	s3,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    800037fa:	000a2583          	lw	a1,0(s4)
    800037fe:	02892503          	lw	a0,40(s2)
    80003802:	fffff097          	auipc	ra,0xfffff
    80003806:	c72080e7          	jalr	-910(ra) # 80002474 <bread>
    8000380a:	8aaa                	mv	s5,a0
    memmove(to->data, from->data, BSIZE);
    8000380c:	40000613          	li	a2,1024
    80003810:	05850593          	addi	a1,a0,88
    80003814:	05898513          	addi	a0,s3,88
    80003818:	ffffd097          	auipc	ra,0xffffd
    8000381c:	a18080e7          	jalr	-1512(ra) # 80000230 <memmove>
    bwrite(to);  // write the log
    80003820:	854e                	mv	a0,s3
    80003822:	fffff097          	auipc	ra,0xfffff
    80003826:	d56080e7          	jalr	-682(ra) # 80002578 <bwrite>
    brelse(from);
    8000382a:	8556                	mv	a0,s5
    8000382c:	fffff097          	auipc	ra,0xfffff
    80003830:	d8a080e7          	jalr	-630(ra) # 800025b6 <brelse>
    brelse(to);
    80003834:	854e                	mv	a0,s3
    80003836:	fffff097          	auipc	ra,0xfffff
    8000383a:	d80080e7          	jalr	-640(ra) # 800025b6 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000383e:	2485                	addiw	s1,s1,1
    80003840:	0a11                	addi	s4,s4,4
    80003842:	02c92783          	lw	a5,44(s2)
    80003846:	f8f4cfe3          	blt	s1,a5,800037e4 <end_op+0xd4>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    8000384a:	00000097          	auipc	ra,0x0
    8000384e:	c62080e7          	jalr	-926(ra) # 800034ac <write_head>
    install_trans(0); // Now install writes to home locations
    80003852:	4501                	li	a0,0
    80003854:	00000097          	auipc	ra,0x0
    80003858:	cd2080e7          	jalr	-814(ra) # 80003526 <install_trans>
    log.lh.n = 0;
    8000385c:	00015797          	auipc	a5,0x15
    80003860:	4407a823          	sw	zero,1104(a5) # 80018cac <log+0x2c>
    write_head();    // Erase the transaction from the log
    80003864:	00000097          	auipc	ra,0x0
    80003868:	c48080e7          	jalr	-952(ra) # 800034ac <write_head>
    8000386c:	bdfd                	j	8000376a <end_op+0x5a>

000000008000386e <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    8000386e:	1101                	addi	sp,sp,-32
    80003870:	ec06                	sd	ra,24(sp)
    80003872:	e822                	sd	s0,16(sp)
    80003874:	e426                	sd	s1,8(sp)
    80003876:	e04a                	sd	s2,0(sp)
    80003878:	1000                	addi	s0,sp,32
    8000387a:	892a                	mv	s2,a0
  int i;

  acquire(&log.lock);
    8000387c:	00015497          	auipc	s1,0x15
    80003880:	40448493          	addi	s1,s1,1028 # 80018c80 <log>
    80003884:	8526                	mv	a0,s1
    80003886:	00003097          	auipc	ra,0x3
    8000388a:	b0e080e7          	jalr	-1266(ra) # 80006394 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    8000388e:	54d0                	lw	a2,44(s1)
    80003890:	47f5                	li	a5,29
    80003892:	06c7ca63          	blt	a5,a2,80003906 <log_write+0x98>
    80003896:	4cdc                	lw	a5,28(s1)
    80003898:	37fd                	addiw	a5,a5,-1
    8000389a:	06f65663          	bge	a2,a5,80003906 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    8000389e:	00015797          	auipc	a5,0x15
    800038a2:	3e278793          	addi	a5,a5,994 # 80018c80 <log>
    800038a6:	539c                	lw	a5,32(a5)
    800038a8:	06f05763          	blez	a5,80003916 <log_write+0xa8>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    800038ac:	06c05d63          	blez	a2,80003926 <log_write+0xb8>
    if (log.lh.block[i] == b->blockno)   // log absorption
    800038b0:	00c92583          	lw	a1,12(s2)
    800038b4:	00015797          	auipc	a5,0x15
    800038b8:	3cc78793          	addi	a5,a5,972 # 80018c80 <log>
    800038bc:	5b9c                	lw	a5,48(a5)
    800038be:	06b78c63          	beq	a5,a1,80003936 <log_write+0xc8>
    800038c2:	00015717          	auipc	a4,0x15
    800038c6:	3f270713          	addi	a4,a4,1010 # 80018cb4 <log+0x34>
  for (i = 0; i < log.lh.n; i++) {
    800038ca:	4781                	li	a5,0
    800038cc:	2785                	addiw	a5,a5,1
    800038ce:	06f60663          	beq	a2,a5,8000393a <log_write+0xcc>
    if (log.lh.block[i] == b->blockno)   // log absorption
    800038d2:	4314                	lw	a3,0(a4)
    800038d4:	0711                	addi	a4,a4,4
    800038d6:	feb69be3          	bne	a3,a1,800038cc <log_write+0x5e>
      break;
  }
  log.lh.block[i] = b->blockno;
    800038da:	07a1                	addi	a5,a5,8
    800038dc:	078a                	slli	a5,a5,0x2
    800038de:	00015717          	auipc	a4,0x15
    800038e2:	3a270713          	addi	a4,a4,930 # 80018c80 <log>
    800038e6:	97ba                	add	a5,a5,a4
    800038e8:	cb8c                	sw	a1,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    log.lh.n++;
  }
  release(&log.lock);
    800038ea:	00015517          	auipc	a0,0x15
    800038ee:	39650513          	addi	a0,a0,918 # 80018c80 <log>
    800038f2:	00003097          	auipc	ra,0x3
    800038f6:	b56080e7          	jalr	-1194(ra) # 80006448 <release>
}
    800038fa:	60e2                	ld	ra,24(sp)
    800038fc:	6442                	ld	s0,16(sp)
    800038fe:	64a2                	ld	s1,8(sp)
    80003900:	6902                	ld	s2,0(sp)
    80003902:	6105                	addi	sp,sp,32
    80003904:	8082                	ret
    panic("too big a transaction");
    80003906:	00005517          	auipc	a0,0x5
    8000390a:	e8a50513          	addi	a0,a0,-374 # 80008790 <str_syscalls+0x2f0>
    8000390e:	00002097          	auipc	ra,0x2
    80003912:	51e080e7          	jalr	1310(ra) # 80005e2c <panic>
    panic("log_write outside of trans");
    80003916:	00005517          	auipc	a0,0x5
    8000391a:	e9250513          	addi	a0,a0,-366 # 800087a8 <str_syscalls+0x308>
    8000391e:	00002097          	auipc	ra,0x2
    80003922:	50e080e7          	jalr	1294(ra) # 80005e2c <panic>
  log.lh.block[i] = b->blockno;
    80003926:	00c92783          	lw	a5,12(s2)
    8000392a:	00015717          	auipc	a4,0x15
    8000392e:	38f72323          	sw	a5,902(a4) # 80018cb0 <log+0x30>
  if (i == log.lh.n) {  // Add new block to log?
    80003932:	fe45                	bnez	a2,800038ea <log_write+0x7c>
    80003934:	a829                	j	8000394e <log_write+0xe0>
  for (i = 0; i < log.lh.n; i++) {
    80003936:	4781                	li	a5,0
    80003938:	b74d                	j	800038da <log_write+0x6c>
  log.lh.block[i] = b->blockno;
    8000393a:	0621                	addi	a2,a2,8
    8000393c:	060a                	slli	a2,a2,0x2
    8000393e:	00015797          	auipc	a5,0x15
    80003942:	34278793          	addi	a5,a5,834 # 80018c80 <log>
    80003946:	963e                	add	a2,a2,a5
    80003948:	00c92783          	lw	a5,12(s2)
    8000394c:	ca1c                	sw	a5,16(a2)
    bpin(b);
    8000394e:	854a                	mv	a0,s2
    80003950:	fffff097          	auipc	ra,0xfffff
    80003954:	d04080e7          	jalr	-764(ra) # 80002654 <bpin>
    log.lh.n++;
    80003958:	00015717          	auipc	a4,0x15
    8000395c:	32870713          	addi	a4,a4,808 # 80018c80 <log>
    80003960:	575c                	lw	a5,44(a4)
    80003962:	2785                	addiw	a5,a5,1
    80003964:	d75c                	sw	a5,44(a4)
    80003966:	b751                	j	800038ea <log_write+0x7c>

0000000080003968 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80003968:	1101                	addi	sp,sp,-32
    8000396a:	ec06                	sd	ra,24(sp)
    8000396c:	e822                	sd	s0,16(sp)
    8000396e:	e426                	sd	s1,8(sp)
    80003970:	e04a                	sd	s2,0(sp)
    80003972:	1000                	addi	s0,sp,32
    80003974:	84aa                	mv	s1,a0
    80003976:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80003978:	00005597          	auipc	a1,0x5
    8000397c:	e5058593          	addi	a1,a1,-432 # 800087c8 <str_syscalls+0x328>
    80003980:	0521                	addi	a0,a0,8
    80003982:	00003097          	auipc	ra,0x3
    80003986:	982080e7          	jalr	-1662(ra) # 80006304 <initlock>
  lk->name = name;
    8000398a:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    8000398e:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003992:	0204a423          	sw	zero,40(s1)
}
    80003996:	60e2                	ld	ra,24(sp)
    80003998:	6442                	ld	s0,16(sp)
    8000399a:	64a2                	ld	s1,8(sp)
    8000399c:	6902                	ld	s2,0(sp)
    8000399e:	6105                	addi	sp,sp,32
    800039a0:	8082                	ret

00000000800039a2 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    800039a2:	1101                	addi	sp,sp,-32
    800039a4:	ec06                	sd	ra,24(sp)
    800039a6:	e822                	sd	s0,16(sp)
    800039a8:	e426                	sd	s1,8(sp)
    800039aa:	e04a                	sd	s2,0(sp)
    800039ac:	1000                	addi	s0,sp,32
    800039ae:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800039b0:	00850913          	addi	s2,a0,8
    800039b4:	854a                	mv	a0,s2
    800039b6:	00003097          	auipc	ra,0x3
    800039ba:	9de080e7          	jalr	-1570(ra) # 80006394 <acquire>
  while (lk->locked) {
    800039be:	409c                	lw	a5,0(s1)
    800039c0:	cb89                	beqz	a5,800039d2 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    800039c2:	85ca                	mv	a1,s2
    800039c4:	8526                	mv	a0,s1
    800039c6:	ffffe097          	auipc	ra,0xffffe
    800039ca:	bbe080e7          	jalr	-1090(ra) # 80001584 <sleep>
  while (lk->locked) {
    800039ce:	409c                	lw	a5,0(s1)
    800039d0:	fbed                	bnez	a5,800039c2 <acquiresleep+0x20>
  }
  lk->locked = 1;
    800039d2:	4785                	li	a5,1
    800039d4:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    800039d6:	ffffd097          	auipc	ra,0xffffd
    800039da:	4fe080e7          	jalr	1278(ra) # 80000ed4 <myproc>
    800039de:	591c                	lw	a5,48(a0)
    800039e0:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    800039e2:	854a                	mv	a0,s2
    800039e4:	00003097          	auipc	ra,0x3
    800039e8:	a64080e7          	jalr	-1436(ra) # 80006448 <release>
}
    800039ec:	60e2                	ld	ra,24(sp)
    800039ee:	6442                	ld	s0,16(sp)
    800039f0:	64a2                	ld	s1,8(sp)
    800039f2:	6902                	ld	s2,0(sp)
    800039f4:	6105                	addi	sp,sp,32
    800039f6:	8082                	ret

00000000800039f8 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    800039f8:	1101                	addi	sp,sp,-32
    800039fa:	ec06                	sd	ra,24(sp)
    800039fc:	e822                	sd	s0,16(sp)
    800039fe:	e426                	sd	s1,8(sp)
    80003a00:	e04a                	sd	s2,0(sp)
    80003a02:	1000                	addi	s0,sp,32
    80003a04:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003a06:	00850913          	addi	s2,a0,8
    80003a0a:	854a                	mv	a0,s2
    80003a0c:	00003097          	auipc	ra,0x3
    80003a10:	988080e7          	jalr	-1656(ra) # 80006394 <acquire>
  lk->locked = 0;
    80003a14:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003a18:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80003a1c:	8526                	mv	a0,s1
    80003a1e:	ffffe097          	auipc	ra,0xffffe
    80003a22:	bca080e7          	jalr	-1078(ra) # 800015e8 <wakeup>
  release(&lk->lk);
    80003a26:	854a                	mv	a0,s2
    80003a28:	00003097          	auipc	ra,0x3
    80003a2c:	a20080e7          	jalr	-1504(ra) # 80006448 <release>
}
    80003a30:	60e2                	ld	ra,24(sp)
    80003a32:	6442                	ld	s0,16(sp)
    80003a34:	64a2                	ld	s1,8(sp)
    80003a36:	6902                	ld	s2,0(sp)
    80003a38:	6105                	addi	sp,sp,32
    80003a3a:	8082                	ret

0000000080003a3c <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80003a3c:	7179                	addi	sp,sp,-48
    80003a3e:	f406                	sd	ra,40(sp)
    80003a40:	f022                	sd	s0,32(sp)
    80003a42:	ec26                	sd	s1,24(sp)
    80003a44:	e84a                	sd	s2,16(sp)
    80003a46:	e44e                	sd	s3,8(sp)
    80003a48:	1800                	addi	s0,sp,48
    80003a4a:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80003a4c:	00850913          	addi	s2,a0,8
    80003a50:	854a                	mv	a0,s2
    80003a52:	00003097          	auipc	ra,0x3
    80003a56:	942080e7          	jalr	-1726(ra) # 80006394 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80003a5a:	409c                	lw	a5,0(s1)
    80003a5c:	ef99                	bnez	a5,80003a7a <holdingsleep+0x3e>
    80003a5e:	4481                	li	s1,0
  release(&lk->lk);
    80003a60:	854a                	mv	a0,s2
    80003a62:	00003097          	auipc	ra,0x3
    80003a66:	9e6080e7          	jalr	-1562(ra) # 80006448 <release>
  return r;
}
    80003a6a:	8526                	mv	a0,s1
    80003a6c:	70a2                	ld	ra,40(sp)
    80003a6e:	7402                	ld	s0,32(sp)
    80003a70:	64e2                	ld	s1,24(sp)
    80003a72:	6942                	ld	s2,16(sp)
    80003a74:	69a2                	ld	s3,8(sp)
    80003a76:	6145                	addi	sp,sp,48
    80003a78:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    80003a7a:	0284a983          	lw	s3,40(s1)
    80003a7e:	ffffd097          	auipc	ra,0xffffd
    80003a82:	456080e7          	jalr	1110(ra) # 80000ed4 <myproc>
    80003a86:	5904                	lw	s1,48(a0)
    80003a88:	413484b3          	sub	s1,s1,s3
    80003a8c:	0014b493          	seqz	s1,s1
    80003a90:	bfc1                	j	80003a60 <holdingsleep+0x24>

0000000080003a92 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80003a92:	1141                	addi	sp,sp,-16
    80003a94:	e406                	sd	ra,8(sp)
    80003a96:	e022                	sd	s0,0(sp)
    80003a98:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003a9a:	00005597          	auipc	a1,0x5
    80003a9e:	d3e58593          	addi	a1,a1,-706 # 800087d8 <str_syscalls+0x338>
    80003aa2:	00015517          	auipc	a0,0x15
    80003aa6:	32650513          	addi	a0,a0,806 # 80018dc8 <ftable>
    80003aaa:	00003097          	auipc	ra,0x3
    80003aae:	85a080e7          	jalr	-1958(ra) # 80006304 <initlock>
}
    80003ab2:	60a2                	ld	ra,8(sp)
    80003ab4:	6402                	ld	s0,0(sp)
    80003ab6:	0141                	addi	sp,sp,16
    80003ab8:	8082                	ret

0000000080003aba <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80003aba:	1101                	addi	sp,sp,-32
    80003abc:	ec06                	sd	ra,24(sp)
    80003abe:	e822                	sd	s0,16(sp)
    80003ac0:	e426                	sd	s1,8(sp)
    80003ac2:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80003ac4:	00015517          	auipc	a0,0x15
    80003ac8:	30450513          	addi	a0,a0,772 # 80018dc8 <ftable>
    80003acc:	00003097          	auipc	ra,0x3
    80003ad0:	8c8080e7          	jalr	-1848(ra) # 80006394 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
    80003ad4:	00015797          	auipc	a5,0x15
    80003ad8:	2f478793          	addi	a5,a5,756 # 80018dc8 <ftable>
    80003adc:	4fdc                	lw	a5,28(a5)
    80003ade:	cb8d                	beqz	a5,80003b10 <filealloc+0x56>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003ae0:	00015497          	auipc	s1,0x15
    80003ae4:	32848493          	addi	s1,s1,808 # 80018e08 <ftable+0x40>
    80003ae8:	00016717          	auipc	a4,0x16
    80003aec:	29870713          	addi	a4,a4,664 # 80019d80 <disk>
    if(f->ref == 0){
    80003af0:	40dc                	lw	a5,4(s1)
    80003af2:	c39d                	beqz	a5,80003b18 <filealloc+0x5e>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003af4:	02848493          	addi	s1,s1,40
    80003af8:	fee49ce3          	bne	s1,a4,80003af0 <filealloc+0x36>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80003afc:	00015517          	auipc	a0,0x15
    80003b00:	2cc50513          	addi	a0,a0,716 # 80018dc8 <ftable>
    80003b04:	00003097          	auipc	ra,0x3
    80003b08:	944080e7          	jalr	-1724(ra) # 80006448 <release>
  return 0;
    80003b0c:	4481                	li	s1,0
    80003b0e:	a839                	j	80003b2c <filealloc+0x72>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003b10:	00015497          	auipc	s1,0x15
    80003b14:	2d048493          	addi	s1,s1,720 # 80018de0 <ftable+0x18>
      f->ref = 1;
    80003b18:	4785                	li	a5,1
    80003b1a:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80003b1c:	00015517          	auipc	a0,0x15
    80003b20:	2ac50513          	addi	a0,a0,684 # 80018dc8 <ftable>
    80003b24:	00003097          	auipc	ra,0x3
    80003b28:	924080e7          	jalr	-1756(ra) # 80006448 <release>
}
    80003b2c:	8526                	mv	a0,s1
    80003b2e:	60e2                	ld	ra,24(sp)
    80003b30:	6442                	ld	s0,16(sp)
    80003b32:	64a2                	ld	s1,8(sp)
    80003b34:	6105                	addi	sp,sp,32
    80003b36:	8082                	ret

0000000080003b38 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80003b38:	1101                	addi	sp,sp,-32
    80003b3a:	ec06                	sd	ra,24(sp)
    80003b3c:	e822                	sd	s0,16(sp)
    80003b3e:	e426                	sd	s1,8(sp)
    80003b40:	1000                	addi	s0,sp,32
    80003b42:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80003b44:	00015517          	auipc	a0,0x15
    80003b48:	28450513          	addi	a0,a0,644 # 80018dc8 <ftable>
    80003b4c:	00003097          	auipc	ra,0x3
    80003b50:	848080e7          	jalr	-1976(ra) # 80006394 <acquire>
  if(f->ref < 1)
    80003b54:	40dc                	lw	a5,4(s1)
    80003b56:	02f05263          	blez	a5,80003b7a <filedup+0x42>
    panic("filedup");
  f->ref++;
    80003b5a:	2785                	addiw	a5,a5,1
    80003b5c:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80003b5e:	00015517          	auipc	a0,0x15
    80003b62:	26a50513          	addi	a0,a0,618 # 80018dc8 <ftable>
    80003b66:	00003097          	auipc	ra,0x3
    80003b6a:	8e2080e7          	jalr	-1822(ra) # 80006448 <release>
  return f;
}
    80003b6e:	8526                	mv	a0,s1
    80003b70:	60e2                	ld	ra,24(sp)
    80003b72:	6442                	ld	s0,16(sp)
    80003b74:	64a2                	ld	s1,8(sp)
    80003b76:	6105                	addi	sp,sp,32
    80003b78:	8082                	ret
    panic("filedup");
    80003b7a:	00005517          	auipc	a0,0x5
    80003b7e:	c6650513          	addi	a0,a0,-922 # 800087e0 <str_syscalls+0x340>
    80003b82:	00002097          	auipc	ra,0x2
    80003b86:	2aa080e7          	jalr	682(ra) # 80005e2c <panic>

0000000080003b8a <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80003b8a:	7139                	addi	sp,sp,-64
    80003b8c:	fc06                	sd	ra,56(sp)
    80003b8e:	f822                	sd	s0,48(sp)
    80003b90:	f426                	sd	s1,40(sp)
    80003b92:	f04a                	sd	s2,32(sp)
    80003b94:	ec4e                	sd	s3,24(sp)
    80003b96:	e852                	sd	s4,16(sp)
    80003b98:	e456                	sd	s5,8(sp)
    80003b9a:	0080                	addi	s0,sp,64
    80003b9c:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80003b9e:	00015517          	auipc	a0,0x15
    80003ba2:	22a50513          	addi	a0,a0,554 # 80018dc8 <ftable>
    80003ba6:	00002097          	auipc	ra,0x2
    80003baa:	7ee080e7          	jalr	2030(ra) # 80006394 <acquire>
  if(f->ref < 1)
    80003bae:	40dc                	lw	a5,4(s1)
    80003bb0:	06f05163          	blez	a5,80003c12 <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    80003bb4:	37fd                	addiw	a5,a5,-1
    80003bb6:	0007871b          	sext.w	a4,a5
    80003bba:	c0dc                	sw	a5,4(s1)
    80003bbc:	06e04363          	bgtz	a4,80003c22 <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003bc0:	0004a903          	lw	s2,0(s1)
    80003bc4:	0094ca83          	lbu	s5,9(s1)
    80003bc8:	0104ba03          	ld	s4,16(s1)
    80003bcc:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80003bd0:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80003bd4:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80003bd8:	00015517          	auipc	a0,0x15
    80003bdc:	1f050513          	addi	a0,a0,496 # 80018dc8 <ftable>
    80003be0:	00003097          	auipc	ra,0x3
    80003be4:	868080e7          	jalr	-1944(ra) # 80006448 <release>

  if(ff.type == FD_PIPE){
    80003be8:	4785                	li	a5,1
    80003bea:	04f90d63          	beq	s2,a5,80003c44 <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003bee:	3979                	addiw	s2,s2,-2
    80003bf0:	4785                	li	a5,1
    80003bf2:	0527e063          	bltu	a5,s2,80003c32 <fileclose+0xa8>
    begin_op();
    80003bf6:	00000097          	auipc	ra,0x0
    80003bfa:	a9a080e7          	jalr	-1382(ra) # 80003690 <begin_op>
    iput(ff.ip);
    80003bfe:	854e                	mv	a0,s3
    80003c00:	fffff097          	auipc	ra,0xfffff
    80003c04:	27e080e7          	jalr	638(ra) # 80002e7e <iput>
    end_op();
    80003c08:	00000097          	auipc	ra,0x0
    80003c0c:	b08080e7          	jalr	-1272(ra) # 80003710 <end_op>
    80003c10:	a00d                	j	80003c32 <fileclose+0xa8>
    panic("fileclose");
    80003c12:	00005517          	auipc	a0,0x5
    80003c16:	bd650513          	addi	a0,a0,-1066 # 800087e8 <str_syscalls+0x348>
    80003c1a:	00002097          	auipc	ra,0x2
    80003c1e:	212080e7          	jalr	530(ra) # 80005e2c <panic>
    release(&ftable.lock);
    80003c22:	00015517          	auipc	a0,0x15
    80003c26:	1a650513          	addi	a0,a0,422 # 80018dc8 <ftable>
    80003c2a:	00003097          	auipc	ra,0x3
    80003c2e:	81e080e7          	jalr	-2018(ra) # 80006448 <release>
  }
}
    80003c32:	70e2                	ld	ra,56(sp)
    80003c34:	7442                	ld	s0,48(sp)
    80003c36:	74a2                	ld	s1,40(sp)
    80003c38:	7902                	ld	s2,32(sp)
    80003c3a:	69e2                	ld	s3,24(sp)
    80003c3c:	6a42                	ld	s4,16(sp)
    80003c3e:	6aa2                	ld	s5,8(sp)
    80003c40:	6121                	addi	sp,sp,64
    80003c42:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80003c44:	85d6                	mv	a1,s5
    80003c46:	8552                	mv	a0,s4
    80003c48:	00000097          	auipc	ra,0x0
    80003c4c:	340080e7          	jalr	832(ra) # 80003f88 <pipeclose>
    80003c50:	b7cd                	j	80003c32 <fileclose+0xa8>

0000000080003c52 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003c52:	715d                	addi	sp,sp,-80
    80003c54:	e486                	sd	ra,72(sp)
    80003c56:	e0a2                	sd	s0,64(sp)
    80003c58:	fc26                	sd	s1,56(sp)
    80003c5a:	f84a                	sd	s2,48(sp)
    80003c5c:	f44e                	sd	s3,40(sp)
    80003c5e:	0880                	addi	s0,sp,80
    80003c60:	84aa                	mv	s1,a0
    80003c62:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80003c64:	ffffd097          	auipc	ra,0xffffd
    80003c68:	270080e7          	jalr	624(ra) # 80000ed4 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80003c6c:	409c                	lw	a5,0(s1)
    80003c6e:	37f9                	addiw	a5,a5,-2
    80003c70:	4705                	li	a4,1
    80003c72:	04f76763          	bltu	a4,a5,80003cc0 <filestat+0x6e>
    80003c76:	892a                	mv	s2,a0
    ilock(f->ip);
    80003c78:	6c88                	ld	a0,24(s1)
    80003c7a:	fffff097          	auipc	ra,0xfffff
    80003c7e:	048080e7          	jalr	72(ra) # 80002cc2 <ilock>
    stati(f->ip, &st);
    80003c82:	fb840593          	addi	a1,s0,-72
    80003c86:	6c88                	ld	a0,24(s1)
    80003c88:	fffff097          	auipc	ra,0xfffff
    80003c8c:	2c6080e7          	jalr	710(ra) # 80002f4e <stati>
    iunlock(f->ip);
    80003c90:	6c88                	ld	a0,24(s1)
    80003c92:	fffff097          	auipc	ra,0xfffff
    80003c96:	0f4080e7          	jalr	244(ra) # 80002d86 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80003c9a:	46e1                	li	a3,24
    80003c9c:	fb840613          	addi	a2,s0,-72
    80003ca0:	85ce                	mv	a1,s3
    80003ca2:	05093503          	ld	a0,80(s2)
    80003ca6:	ffffd097          	auipc	ra,0xffffd
    80003caa:	edc080e7          	jalr	-292(ra) # 80000b82 <copyout>
    80003cae:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80003cb2:	60a6                	ld	ra,72(sp)
    80003cb4:	6406                	ld	s0,64(sp)
    80003cb6:	74e2                	ld	s1,56(sp)
    80003cb8:	7942                	ld	s2,48(sp)
    80003cba:	79a2                	ld	s3,40(sp)
    80003cbc:	6161                	addi	sp,sp,80
    80003cbe:	8082                	ret
  return -1;
    80003cc0:	557d                	li	a0,-1
    80003cc2:	bfc5                	j	80003cb2 <filestat+0x60>

0000000080003cc4 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003cc4:	7179                	addi	sp,sp,-48
    80003cc6:	f406                	sd	ra,40(sp)
    80003cc8:	f022                	sd	s0,32(sp)
    80003cca:	ec26                	sd	s1,24(sp)
    80003ccc:	e84a                	sd	s2,16(sp)
    80003cce:	e44e                	sd	s3,8(sp)
    80003cd0:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80003cd2:	00854783          	lbu	a5,8(a0)
    80003cd6:	c3d5                	beqz	a5,80003d7a <fileread+0xb6>
    80003cd8:	89b2                	mv	s3,a2
    80003cda:	892e                	mv	s2,a1
    80003cdc:	84aa                	mv	s1,a0
    return -1;

  if(f->type == FD_PIPE){
    80003cde:	411c                	lw	a5,0(a0)
    80003ce0:	4705                	li	a4,1
    80003ce2:	04e78963          	beq	a5,a4,80003d34 <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003ce6:	470d                	li	a4,3
    80003ce8:	04e78d63          	beq	a5,a4,80003d42 <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80003cec:	4709                	li	a4,2
    80003cee:	06e79e63          	bne	a5,a4,80003d6a <fileread+0xa6>
    ilock(f->ip);
    80003cf2:	6d08                	ld	a0,24(a0)
    80003cf4:	fffff097          	auipc	ra,0xfffff
    80003cf8:	fce080e7          	jalr	-50(ra) # 80002cc2 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003cfc:	874e                	mv	a4,s3
    80003cfe:	5094                	lw	a3,32(s1)
    80003d00:	864a                	mv	a2,s2
    80003d02:	4585                	li	a1,1
    80003d04:	6c88                	ld	a0,24(s1)
    80003d06:	fffff097          	auipc	ra,0xfffff
    80003d0a:	272080e7          	jalr	626(ra) # 80002f78 <readi>
    80003d0e:	892a                	mv	s2,a0
    80003d10:	00a05563          	blez	a0,80003d1a <fileread+0x56>
      f->off += r;
    80003d14:	509c                	lw	a5,32(s1)
    80003d16:	9fa9                	addw	a5,a5,a0
    80003d18:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80003d1a:	6c88                	ld	a0,24(s1)
    80003d1c:	fffff097          	auipc	ra,0xfffff
    80003d20:	06a080e7          	jalr	106(ra) # 80002d86 <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    80003d24:	854a                	mv	a0,s2
    80003d26:	70a2                	ld	ra,40(sp)
    80003d28:	7402                	ld	s0,32(sp)
    80003d2a:	64e2                	ld	s1,24(sp)
    80003d2c:	6942                	ld	s2,16(sp)
    80003d2e:	69a2                	ld	s3,8(sp)
    80003d30:	6145                	addi	sp,sp,48
    80003d32:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80003d34:	6908                	ld	a0,16(a0)
    80003d36:	00000097          	auipc	ra,0x0
    80003d3a:	3c8080e7          	jalr	968(ra) # 800040fe <piperead>
    80003d3e:	892a                	mv	s2,a0
    80003d40:	b7d5                	j	80003d24 <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80003d42:	02451783          	lh	a5,36(a0)
    80003d46:	03079693          	slli	a3,a5,0x30
    80003d4a:	92c1                	srli	a3,a3,0x30
    80003d4c:	4725                	li	a4,9
    80003d4e:	02d76863          	bltu	a4,a3,80003d7e <fileread+0xba>
    80003d52:	0792                	slli	a5,a5,0x4
    80003d54:	00015717          	auipc	a4,0x15
    80003d58:	fd470713          	addi	a4,a4,-44 # 80018d28 <devsw>
    80003d5c:	97ba                	add	a5,a5,a4
    80003d5e:	639c                	ld	a5,0(a5)
    80003d60:	c38d                	beqz	a5,80003d82 <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    80003d62:	4505                	li	a0,1
    80003d64:	9782                	jalr	a5
    80003d66:	892a                	mv	s2,a0
    80003d68:	bf75                	j	80003d24 <fileread+0x60>
    panic("fileread");
    80003d6a:	00005517          	auipc	a0,0x5
    80003d6e:	a8e50513          	addi	a0,a0,-1394 # 800087f8 <str_syscalls+0x358>
    80003d72:	00002097          	auipc	ra,0x2
    80003d76:	0ba080e7          	jalr	186(ra) # 80005e2c <panic>
    return -1;
    80003d7a:	597d                	li	s2,-1
    80003d7c:	b765                	j	80003d24 <fileread+0x60>
      return -1;
    80003d7e:	597d                	li	s2,-1
    80003d80:	b755                	j	80003d24 <fileread+0x60>
    80003d82:	597d                	li	s2,-1
    80003d84:	b745                	j	80003d24 <fileread+0x60>

0000000080003d86 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80003d86:	715d                	addi	sp,sp,-80
    80003d88:	e486                	sd	ra,72(sp)
    80003d8a:	e0a2                	sd	s0,64(sp)
    80003d8c:	fc26                	sd	s1,56(sp)
    80003d8e:	f84a                	sd	s2,48(sp)
    80003d90:	f44e                	sd	s3,40(sp)
    80003d92:	f052                	sd	s4,32(sp)
    80003d94:	ec56                	sd	s5,24(sp)
    80003d96:	e85a                	sd	s6,16(sp)
    80003d98:	e45e                	sd	s7,8(sp)
    80003d9a:	e062                	sd	s8,0(sp)
    80003d9c:	0880                	addi	s0,sp,80
  int r, ret = 0;

  if(f->writable == 0)
    80003d9e:	00954783          	lbu	a5,9(a0)
    80003da2:	10078063          	beqz	a5,80003ea2 <filewrite+0x11c>
    80003da6:	84aa                	mv	s1,a0
    80003da8:	8bae                	mv	s7,a1
    80003daa:	8ab2                	mv	s5,a2
    return -1;

  if(f->type == FD_PIPE){
    80003dac:	411c                	lw	a5,0(a0)
    80003dae:	4705                	li	a4,1
    80003db0:	02e78263          	beq	a5,a4,80003dd4 <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003db4:	470d                	li	a4,3
    80003db6:	02e78663          	beq	a5,a4,80003de2 <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80003dba:	4709                	li	a4,2
    80003dbc:	0ce79b63          	bne	a5,a4,80003e92 <filewrite+0x10c>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80003dc0:	0ac05763          	blez	a2,80003e6e <filewrite+0xe8>
    int i = 0;
    80003dc4:	4901                	li	s2,0
    80003dc6:	6b05                	lui	s6,0x1
    80003dc8:	c00b0b13          	addi	s6,s6,-1024 # c00 <_entry-0x7ffff400>
    80003dcc:	6c05                	lui	s8,0x1
    80003dce:	c00c0c1b          	addiw	s8,s8,-1024
    80003dd2:	a071                	j	80003e5e <filewrite+0xd8>
    ret = pipewrite(f->pipe, addr, n);
    80003dd4:	6908                	ld	a0,16(a0)
    80003dd6:	00000097          	auipc	ra,0x0
    80003dda:	222080e7          	jalr	546(ra) # 80003ff8 <pipewrite>
    80003dde:	8aaa                	mv	s5,a0
    80003de0:	a851                	j	80003e74 <filewrite+0xee>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80003de2:	02451783          	lh	a5,36(a0)
    80003de6:	03079693          	slli	a3,a5,0x30
    80003dea:	92c1                	srli	a3,a3,0x30
    80003dec:	4725                	li	a4,9
    80003dee:	0ad76c63          	bltu	a4,a3,80003ea6 <filewrite+0x120>
    80003df2:	0792                	slli	a5,a5,0x4
    80003df4:	00015717          	auipc	a4,0x15
    80003df8:	f3470713          	addi	a4,a4,-204 # 80018d28 <devsw>
    80003dfc:	97ba                	add	a5,a5,a4
    80003dfe:	679c                	ld	a5,8(a5)
    80003e00:	c7cd                	beqz	a5,80003eaa <filewrite+0x124>
    ret = devsw[f->major].write(1, addr, n);
    80003e02:	4505                	li	a0,1
    80003e04:	9782                	jalr	a5
    80003e06:	8aaa                	mv	s5,a0
    80003e08:	a0b5                	j	80003e74 <filewrite+0xee>
    80003e0a:	00098a1b          	sext.w	s4,s3
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
    80003e0e:	00000097          	auipc	ra,0x0
    80003e12:	882080e7          	jalr	-1918(ra) # 80003690 <begin_op>
      ilock(f->ip);
    80003e16:	6c88                	ld	a0,24(s1)
    80003e18:	fffff097          	auipc	ra,0xfffff
    80003e1c:	eaa080e7          	jalr	-342(ra) # 80002cc2 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003e20:	8752                	mv	a4,s4
    80003e22:	5094                	lw	a3,32(s1)
    80003e24:	01790633          	add	a2,s2,s7
    80003e28:	4585                	li	a1,1
    80003e2a:	6c88                	ld	a0,24(s1)
    80003e2c:	fffff097          	auipc	ra,0xfffff
    80003e30:	244080e7          	jalr	580(ra) # 80003070 <writei>
    80003e34:	89aa                	mv	s3,a0
    80003e36:	00a05563          	blez	a0,80003e40 <filewrite+0xba>
        f->off += r;
    80003e3a:	509c                	lw	a5,32(s1)
    80003e3c:	9fa9                	addw	a5,a5,a0
    80003e3e:	d09c                	sw	a5,32(s1)
      iunlock(f->ip);
    80003e40:	6c88                	ld	a0,24(s1)
    80003e42:	fffff097          	auipc	ra,0xfffff
    80003e46:	f44080e7          	jalr	-188(ra) # 80002d86 <iunlock>
      end_op();
    80003e4a:	00000097          	auipc	ra,0x0
    80003e4e:	8c6080e7          	jalr	-1850(ra) # 80003710 <end_op>

      if(r != n1){
    80003e52:	01499f63          	bne	s3,s4,80003e70 <filewrite+0xea>
        // error from writei
        break;
      }
      i += r;
    80003e56:	012a093b          	addw	s2,s4,s2
    while(i < n){
    80003e5a:	01595b63          	bge	s2,s5,80003e70 <filewrite+0xea>
      int n1 = n - i;
    80003e5e:	412a87bb          	subw	a5,s5,s2
      if(n1 > max)
    80003e62:	89be                	mv	s3,a5
    80003e64:	2781                	sext.w	a5,a5
    80003e66:	fafb52e3          	bge	s6,a5,80003e0a <filewrite+0x84>
    80003e6a:	89e2                	mv	s3,s8
    80003e6c:	bf79                	j	80003e0a <filewrite+0x84>
    int i = 0;
    80003e6e:	4901                	li	s2,0
    }
    ret = (i == n ? n : -1);
    80003e70:	012a9f63          	bne	s5,s2,80003e8e <filewrite+0x108>
  } else {
    panic("filewrite");
  }

  return ret;
}
    80003e74:	8556                	mv	a0,s5
    80003e76:	60a6                	ld	ra,72(sp)
    80003e78:	6406                	ld	s0,64(sp)
    80003e7a:	74e2                	ld	s1,56(sp)
    80003e7c:	7942                	ld	s2,48(sp)
    80003e7e:	79a2                	ld	s3,40(sp)
    80003e80:	7a02                	ld	s4,32(sp)
    80003e82:	6ae2                	ld	s5,24(sp)
    80003e84:	6b42                	ld	s6,16(sp)
    80003e86:	6ba2                	ld	s7,8(sp)
    80003e88:	6c02                	ld	s8,0(sp)
    80003e8a:	6161                	addi	sp,sp,80
    80003e8c:	8082                	ret
    ret = (i == n ? n : -1);
    80003e8e:	5afd                	li	s5,-1
    80003e90:	b7d5                	j	80003e74 <filewrite+0xee>
    panic("filewrite");
    80003e92:	00005517          	auipc	a0,0x5
    80003e96:	97650513          	addi	a0,a0,-1674 # 80008808 <str_syscalls+0x368>
    80003e9a:	00002097          	auipc	ra,0x2
    80003e9e:	f92080e7          	jalr	-110(ra) # 80005e2c <panic>
    return -1;
    80003ea2:	5afd                	li	s5,-1
    80003ea4:	bfc1                	j	80003e74 <filewrite+0xee>
      return -1;
    80003ea6:	5afd                	li	s5,-1
    80003ea8:	b7f1                	j	80003e74 <filewrite+0xee>
    80003eaa:	5afd                	li	s5,-1
    80003eac:	b7e1                	j	80003e74 <filewrite+0xee>

0000000080003eae <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80003eae:	7179                	addi	sp,sp,-48
    80003eb0:	f406                	sd	ra,40(sp)
    80003eb2:	f022                	sd	s0,32(sp)
    80003eb4:	ec26                	sd	s1,24(sp)
    80003eb6:	e84a                	sd	s2,16(sp)
    80003eb8:	e44e                	sd	s3,8(sp)
    80003eba:	e052                	sd	s4,0(sp)
    80003ebc:	1800                	addi	s0,sp,48
    80003ebe:	84aa                	mv	s1,a0
    80003ec0:	892e                	mv	s2,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80003ec2:	0005b023          	sd	zero,0(a1)
    80003ec6:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80003eca:	00000097          	auipc	ra,0x0
    80003ece:	bf0080e7          	jalr	-1040(ra) # 80003aba <filealloc>
    80003ed2:	e088                	sd	a0,0(s1)
    80003ed4:	c551                	beqz	a0,80003f60 <pipealloc+0xb2>
    80003ed6:	00000097          	auipc	ra,0x0
    80003eda:	be4080e7          	jalr	-1052(ra) # 80003aba <filealloc>
    80003ede:	00a93023          	sd	a0,0(s2)
    80003ee2:	c92d                	beqz	a0,80003f54 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80003ee4:	ffffc097          	auipc	ra,0xffffc
    80003ee8:	236080e7          	jalr	566(ra) # 8000011a <kalloc>
    80003eec:	89aa                	mv	s3,a0
    80003eee:	c125                	beqz	a0,80003f4e <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80003ef0:	4a05                	li	s4,1
    80003ef2:	23452023          	sw	s4,544(a0)
  pi->writeopen = 1;
    80003ef6:	23452223          	sw	s4,548(a0)
  pi->nwrite = 0;
    80003efa:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80003efe:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80003f02:	00004597          	auipc	a1,0x4
    80003f06:	6b658593          	addi	a1,a1,1718 # 800085b8 <str_syscalls+0x118>
    80003f0a:	00002097          	auipc	ra,0x2
    80003f0e:	3fa080e7          	jalr	1018(ra) # 80006304 <initlock>
  (*f0)->type = FD_PIPE;
    80003f12:	609c                	ld	a5,0(s1)
    80003f14:	0147a023          	sw	s4,0(a5)
  (*f0)->readable = 1;
    80003f18:	609c                	ld	a5,0(s1)
    80003f1a:	01478423          	sb	s4,8(a5)
  (*f0)->writable = 0;
    80003f1e:	609c                	ld	a5,0(s1)
    80003f20:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80003f24:	609c                	ld	a5,0(s1)
    80003f26:	0137b823          	sd	s3,16(a5)
  (*f1)->type = FD_PIPE;
    80003f2a:	00093783          	ld	a5,0(s2)
    80003f2e:	0147a023          	sw	s4,0(a5)
  (*f1)->readable = 0;
    80003f32:	00093783          	ld	a5,0(s2)
    80003f36:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80003f3a:	00093783          	ld	a5,0(s2)
    80003f3e:	014784a3          	sb	s4,9(a5)
  (*f1)->pipe = pi;
    80003f42:	00093783          	ld	a5,0(s2)
    80003f46:	0137b823          	sd	s3,16(a5)
  return 0;
    80003f4a:	4501                	li	a0,0
    80003f4c:	a025                	j	80003f74 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80003f4e:	6088                	ld	a0,0(s1)
    80003f50:	e501                	bnez	a0,80003f58 <pipealloc+0xaa>
    80003f52:	a039                	j	80003f60 <pipealloc+0xb2>
    80003f54:	6088                	ld	a0,0(s1)
    80003f56:	c51d                	beqz	a0,80003f84 <pipealloc+0xd6>
    fileclose(*f0);
    80003f58:	00000097          	auipc	ra,0x0
    80003f5c:	c32080e7          	jalr	-974(ra) # 80003b8a <fileclose>
  if(*f1)
    80003f60:	00093783          	ld	a5,0(s2)
    fileclose(*f1);
  return -1;
    80003f64:	557d                	li	a0,-1
  if(*f1)
    80003f66:	c799                	beqz	a5,80003f74 <pipealloc+0xc6>
    fileclose(*f1);
    80003f68:	853e                	mv	a0,a5
    80003f6a:	00000097          	auipc	ra,0x0
    80003f6e:	c20080e7          	jalr	-992(ra) # 80003b8a <fileclose>
  return -1;
    80003f72:	557d                	li	a0,-1
}
    80003f74:	70a2                	ld	ra,40(sp)
    80003f76:	7402                	ld	s0,32(sp)
    80003f78:	64e2                	ld	s1,24(sp)
    80003f7a:	6942                	ld	s2,16(sp)
    80003f7c:	69a2                	ld	s3,8(sp)
    80003f7e:	6a02                	ld	s4,0(sp)
    80003f80:	6145                	addi	sp,sp,48
    80003f82:	8082                	ret
  return -1;
    80003f84:	557d                	li	a0,-1
    80003f86:	b7fd                	j	80003f74 <pipealloc+0xc6>

0000000080003f88 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80003f88:	1101                	addi	sp,sp,-32
    80003f8a:	ec06                	sd	ra,24(sp)
    80003f8c:	e822                	sd	s0,16(sp)
    80003f8e:	e426                	sd	s1,8(sp)
    80003f90:	e04a                	sd	s2,0(sp)
    80003f92:	1000                	addi	s0,sp,32
    80003f94:	84aa                	mv	s1,a0
    80003f96:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80003f98:	00002097          	auipc	ra,0x2
    80003f9c:	3fc080e7          	jalr	1020(ra) # 80006394 <acquire>
  if(writable){
    80003fa0:	02090d63          	beqz	s2,80003fda <pipeclose+0x52>
    pi->writeopen = 0;
    80003fa4:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80003fa8:	21848513          	addi	a0,s1,536
    80003fac:	ffffd097          	auipc	ra,0xffffd
    80003fb0:	63c080e7          	jalr	1596(ra) # 800015e8 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80003fb4:	2204b783          	ld	a5,544(s1)
    80003fb8:	eb95                	bnez	a5,80003fec <pipeclose+0x64>
    release(&pi->lock);
    80003fba:	8526                	mv	a0,s1
    80003fbc:	00002097          	auipc	ra,0x2
    80003fc0:	48c080e7          	jalr	1164(ra) # 80006448 <release>
    kfree((char*)pi);
    80003fc4:	8526                	mv	a0,s1
    80003fc6:	ffffc097          	auipc	ra,0xffffc
    80003fca:	056080e7          	jalr	86(ra) # 8000001c <kfree>
  } else
    release(&pi->lock);
}
    80003fce:	60e2                	ld	ra,24(sp)
    80003fd0:	6442                	ld	s0,16(sp)
    80003fd2:	64a2                	ld	s1,8(sp)
    80003fd4:	6902                	ld	s2,0(sp)
    80003fd6:	6105                	addi	sp,sp,32
    80003fd8:	8082                	ret
    pi->readopen = 0;
    80003fda:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80003fde:	21c48513          	addi	a0,s1,540
    80003fe2:	ffffd097          	auipc	ra,0xffffd
    80003fe6:	606080e7          	jalr	1542(ra) # 800015e8 <wakeup>
    80003fea:	b7e9                	j	80003fb4 <pipeclose+0x2c>
    release(&pi->lock);
    80003fec:	8526                	mv	a0,s1
    80003fee:	00002097          	auipc	ra,0x2
    80003ff2:	45a080e7          	jalr	1114(ra) # 80006448 <release>
}
    80003ff6:	bfe1                	j	80003fce <pipeclose+0x46>

0000000080003ff8 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80003ff8:	7159                	addi	sp,sp,-112
    80003ffa:	f486                	sd	ra,104(sp)
    80003ffc:	f0a2                	sd	s0,96(sp)
    80003ffe:	eca6                	sd	s1,88(sp)
    80004000:	e8ca                	sd	s2,80(sp)
    80004002:	e4ce                	sd	s3,72(sp)
    80004004:	e0d2                	sd	s4,64(sp)
    80004006:	fc56                	sd	s5,56(sp)
    80004008:	f85a                	sd	s6,48(sp)
    8000400a:	f45e                	sd	s7,40(sp)
    8000400c:	f062                	sd	s8,32(sp)
    8000400e:	ec66                	sd	s9,24(sp)
    80004010:	1880                	addi	s0,sp,112
    80004012:	84aa                	mv	s1,a0
    80004014:	8aae                	mv	s5,a1
    80004016:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80004018:	ffffd097          	auipc	ra,0xffffd
    8000401c:	ebc080e7          	jalr	-324(ra) # 80000ed4 <myproc>
    80004020:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80004022:	8526                	mv	a0,s1
    80004024:	00002097          	auipc	ra,0x2
    80004028:	370080e7          	jalr	880(ra) # 80006394 <acquire>
  while(i < n){
    8000402c:	0d405763          	blez	s4,800040fa <pipewrite+0x102>
    80004030:	8ba6                	mv	s7,s1
    if(pi->readopen == 0 || killed(pr)){
    80004032:	2204a783          	lw	a5,544(s1)
    80004036:	cb81                	beqz	a5,80004046 <pipewrite+0x4e>
  int i = 0;
    80004038:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    8000403a:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    8000403c:	21848c93          	addi	s9,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80004040:	21c48c13          	addi	s8,s1,540
    80004044:	a0a5                	j	800040ac <pipewrite+0xb4>
      release(&pi->lock);
    80004046:	8526                	mv	a0,s1
    80004048:	00002097          	auipc	ra,0x2
    8000404c:	400080e7          	jalr	1024(ra) # 80006448 <release>
      return -1;
    80004050:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80004052:	854a                	mv	a0,s2
    80004054:	70a6                	ld	ra,104(sp)
    80004056:	7406                	ld	s0,96(sp)
    80004058:	64e6                	ld	s1,88(sp)
    8000405a:	6946                	ld	s2,80(sp)
    8000405c:	69a6                	ld	s3,72(sp)
    8000405e:	6a06                	ld	s4,64(sp)
    80004060:	7ae2                	ld	s5,56(sp)
    80004062:	7b42                	ld	s6,48(sp)
    80004064:	7ba2                	ld	s7,40(sp)
    80004066:	7c02                	ld	s8,32(sp)
    80004068:	6ce2                	ld	s9,24(sp)
    8000406a:	6165                	addi	sp,sp,112
    8000406c:	8082                	ret
      wakeup(&pi->nread);
    8000406e:	8566                	mv	a0,s9
    80004070:	ffffd097          	auipc	ra,0xffffd
    80004074:	578080e7          	jalr	1400(ra) # 800015e8 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80004078:	85de                	mv	a1,s7
    8000407a:	8562                	mv	a0,s8
    8000407c:	ffffd097          	auipc	ra,0xffffd
    80004080:	508080e7          	jalr	1288(ra) # 80001584 <sleep>
    80004084:	a839                	j	800040a2 <pipewrite+0xaa>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80004086:	21c4a783          	lw	a5,540(s1)
    8000408a:	0017871b          	addiw	a4,a5,1
    8000408e:	20e4ae23          	sw	a4,540(s1)
    80004092:	1ff7f793          	andi	a5,a5,511
    80004096:	97a6                	add	a5,a5,s1
    80004098:	f9f44703          	lbu	a4,-97(s0)
    8000409c:	00e78c23          	sb	a4,24(a5)
      i++;
    800040a0:	2905                	addiw	s2,s2,1
  while(i < n){
    800040a2:	05495063          	bge	s2,s4,800040e2 <pipewrite+0xea>
    if(pi->readopen == 0 || killed(pr)){
    800040a6:	2204a783          	lw	a5,544(s1)
    800040aa:	dfd1                	beqz	a5,80004046 <pipewrite+0x4e>
    800040ac:	854e                	mv	a0,s3
    800040ae:	ffffd097          	auipc	ra,0xffffd
    800040b2:	780080e7          	jalr	1920(ra) # 8000182e <killed>
    800040b6:	f941                	bnez	a0,80004046 <pipewrite+0x4e>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    800040b8:	2184a783          	lw	a5,536(s1)
    800040bc:	21c4a703          	lw	a4,540(s1)
    800040c0:	2007879b          	addiw	a5,a5,512
    800040c4:	faf705e3          	beq	a4,a5,8000406e <pipewrite+0x76>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    800040c8:	4685                	li	a3,1
    800040ca:	01590633          	add	a2,s2,s5
    800040ce:	f9f40593          	addi	a1,s0,-97
    800040d2:	0509b503          	ld	a0,80(s3)
    800040d6:	ffffd097          	auipc	ra,0xffffd
    800040da:	b38080e7          	jalr	-1224(ra) # 80000c0e <copyin>
    800040de:	fb6514e3          	bne	a0,s6,80004086 <pipewrite+0x8e>
  wakeup(&pi->nread);
    800040e2:	21848513          	addi	a0,s1,536
    800040e6:	ffffd097          	auipc	ra,0xffffd
    800040ea:	502080e7          	jalr	1282(ra) # 800015e8 <wakeup>
  release(&pi->lock);
    800040ee:	8526                	mv	a0,s1
    800040f0:	00002097          	auipc	ra,0x2
    800040f4:	358080e7          	jalr	856(ra) # 80006448 <release>
  return i;
    800040f8:	bfa9                	j	80004052 <pipewrite+0x5a>
  int i = 0;
    800040fa:	4901                	li	s2,0
    800040fc:	b7dd                	j	800040e2 <pipewrite+0xea>

00000000800040fe <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    800040fe:	715d                	addi	sp,sp,-80
    80004100:	e486                	sd	ra,72(sp)
    80004102:	e0a2                	sd	s0,64(sp)
    80004104:	fc26                	sd	s1,56(sp)
    80004106:	f84a                	sd	s2,48(sp)
    80004108:	f44e                	sd	s3,40(sp)
    8000410a:	f052                	sd	s4,32(sp)
    8000410c:	ec56                	sd	s5,24(sp)
    8000410e:	e85a                	sd	s6,16(sp)
    80004110:	0880                	addi	s0,sp,80
    80004112:	84aa                	mv	s1,a0
    80004114:	89ae                	mv	s3,a1
    80004116:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80004118:	ffffd097          	auipc	ra,0xffffd
    8000411c:	dbc080e7          	jalr	-580(ra) # 80000ed4 <myproc>
    80004120:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80004122:	8526                	mv	a0,s1
    80004124:	00002097          	auipc	ra,0x2
    80004128:	270080e7          	jalr	624(ra) # 80006394 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    8000412c:	2184a703          	lw	a4,536(s1)
    80004130:	21c4a783          	lw	a5,540(s1)
    80004134:	06f71b63          	bne	a4,a5,800041aa <piperead+0xac>
    80004138:	8926                	mv	s2,s1
    8000413a:	2244a783          	lw	a5,548(s1)
    8000413e:	cb85                	beqz	a5,8000416e <piperead+0x70>
    if(killed(pr)){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004140:	21848b13          	addi	s6,s1,536
    if(killed(pr)){
    80004144:	8552                	mv	a0,s4
    80004146:	ffffd097          	auipc	ra,0xffffd
    8000414a:	6e8080e7          	jalr	1768(ra) # 8000182e <killed>
    8000414e:	e539                	bnez	a0,8000419c <piperead+0x9e>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004150:	85ca                	mv	a1,s2
    80004152:	855a                	mv	a0,s6
    80004154:	ffffd097          	auipc	ra,0xffffd
    80004158:	430080e7          	jalr	1072(ra) # 80001584 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    8000415c:	2184a703          	lw	a4,536(s1)
    80004160:	21c4a783          	lw	a5,540(s1)
    80004164:	04f71363          	bne	a4,a5,800041aa <piperead+0xac>
    80004168:	2244a783          	lw	a5,548(s1)
    8000416c:	ffe1                	bnez	a5,80004144 <piperead+0x46>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    if(pi->nread == pi->nwrite)
    8000416e:	4901                	li	s2,0
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80004170:	21c48513          	addi	a0,s1,540
    80004174:	ffffd097          	auipc	ra,0xffffd
    80004178:	474080e7          	jalr	1140(ra) # 800015e8 <wakeup>
  release(&pi->lock);
    8000417c:	8526                	mv	a0,s1
    8000417e:	00002097          	auipc	ra,0x2
    80004182:	2ca080e7          	jalr	714(ra) # 80006448 <release>
  return i;
}
    80004186:	854a                	mv	a0,s2
    80004188:	60a6                	ld	ra,72(sp)
    8000418a:	6406                	ld	s0,64(sp)
    8000418c:	74e2                	ld	s1,56(sp)
    8000418e:	7942                	ld	s2,48(sp)
    80004190:	79a2                	ld	s3,40(sp)
    80004192:	7a02                	ld	s4,32(sp)
    80004194:	6ae2                	ld	s5,24(sp)
    80004196:	6b42                	ld	s6,16(sp)
    80004198:	6161                	addi	sp,sp,80
    8000419a:	8082                	ret
      release(&pi->lock);
    8000419c:	8526                	mv	a0,s1
    8000419e:	00002097          	auipc	ra,0x2
    800041a2:	2aa080e7          	jalr	682(ra) # 80006448 <release>
      return -1;
    800041a6:	597d                	li	s2,-1
    800041a8:	bff9                	j	80004186 <piperead+0x88>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800041aa:	4901                	li	s2,0
    800041ac:	fd5052e3          	blez	s5,80004170 <piperead+0x72>
    if(pi->nread == pi->nwrite)
    800041b0:	2184a783          	lw	a5,536(s1)
    800041b4:	4901                	li	s2,0
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800041b6:	5b7d                	li	s6,-1
    ch = pi->data[pi->nread++ % PIPESIZE];
    800041b8:	0017871b          	addiw	a4,a5,1
    800041bc:	20e4ac23          	sw	a4,536(s1)
    800041c0:	1ff7f793          	andi	a5,a5,511
    800041c4:	97a6                	add	a5,a5,s1
    800041c6:	0187c783          	lbu	a5,24(a5)
    800041ca:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800041ce:	4685                	li	a3,1
    800041d0:	fbf40613          	addi	a2,s0,-65
    800041d4:	85ce                	mv	a1,s3
    800041d6:	050a3503          	ld	a0,80(s4)
    800041da:	ffffd097          	auipc	ra,0xffffd
    800041de:	9a8080e7          	jalr	-1624(ra) # 80000b82 <copyout>
    800041e2:	f96507e3          	beq	a0,s6,80004170 <piperead+0x72>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800041e6:	2905                	addiw	s2,s2,1
    800041e8:	f92a84e3          	beq	s5,s2,80004170 <piperead+0x72>
    if(pi->nread == pi->nwrite)
    800041ec:	2184a783          	lw	a5,536(s1)
    800041f0:	0985                	addi	s3,s3,1
    800041f2:	21c4a703          	lw	a4,540(s1)
    800041f6:	fcf711e3          	bne	a4,a5,800041b8 <piperead+0xba>
    800041fa:	bf9d                	j	80004170 <piperead+0x72>

00000000800041fc <flags2perm>:
#include "elf.h"

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

int flags2perm(int flags)
{
    800041fc:	1141                	addi	sp,sp,-16
    800041fe:	e422                	sd	s0,8(sp)
    80004200:	0800                	addi	s0,sp,16
    80004202:	87aa                	mv	a5,a0
    int perm = 0;
    if(flags & 0x1)
    80004204:	8905                	andi	a0,a0,1
    80004206:	c111                	beqz	a0,8000420a <flags2perm+0xe>
      perm = PTE_X;
    80004208:	4521                	li	a0,8
    if(flags & 0x2)
    8000420a:	8b89                	andi	a5,a5,2
    8000420c:	c399                	beqz	a5,80004212 <flags2perm+0x16>
      perm |= PTE_W;
    8000420e:	00456513          	ori	a0,a0,4
    return perm;
}
    80004212:	6422                	ld	s0,8(sp)
    80004214:	0141                	addi	sp,sp,16
    80004216:	8082                	ret

0000000080004218 <exec>:

int
exec(char *path, char **argv)
{
    80004218:	de010113          	addi	sp,sp,-544 # 80019de0 <disk+0x60>
    8000421c:	20113c23          	sd	ra,536(sp)
    80004220:	20813823          	sd	s0,528(sp)
    80004224:	20913423          	sd	s1,520(sp)
    80004228:	21213023          	sd	s2,512(sp)
    8000422c:	ffce                	sd	s3,504(sp)
    8000422e:	fbd2                	sd	s4,496(sp)
    80004230:	f7d6                	sd	s5,488(sp)
    80004232:	f3da                	sd	s6,480(sp)
    80004234:	efde                	sd	s7,472(sp)
    80004236:	ebe2                	sd	s8,464(sp)
    80004238:	e7e6                	sd	s9,456(sp)
    8000423a:	e3ea                	sd	s10,448(sp)
    8000423c:	ff6e                	sd	s11,440(sp)
    8000423e:	1400                	addi	s0,sp,544
    80004240:	892a                	mv	s2,a0
    80004242:	dea43823          	sd	a0,-528(s0)
    80004246:	deb43c23          	sd	a1,-520(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    8000424a:	ffffd097          	auipc	ra,0xffffd
    8000424e:	c8a080e7          	jalr	-886(ra) # 80000ed4 <myproc>
    80004252:	84aa                	mv	s1,a0

  begin_op();
    80004254:	fffff097          	auipc	ra,0xfffff
    80004258:	43c080e7          	jalr	1084(ra) # 80003690 <begin_op>

  if((ip = namei(path)) == 0){
    8000425c:	854a                	mv	a0,s2
    8000425e:	fffff097          	auipc	ra,0xfffff
    80004262:	214080e7          	jalr	532(ra) # 80003472 <namei>
    80004266:	c93d                	beqz	a0,800042dc <exec+0xc4>
    80004268:	892a                	mv	s2,a0
    end_op();
    return -1;
  }
  ilock(ip);
    8000426a:	fffff097          	auipc	ra,0xfffff
    8000426e:	a58080e7          	jalr	-1448(ra) # 80002cc2 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80004272:	04000713          	li	a4,64
    80004276:	4681                	li	a3,0
    80004278:	e5040613          	addi	a2,s0,-432
    8000427c:	4581                	li	a1,0
    8000427e:	854a                	mv	a0,s2
    80004280:	fffff097          	auipc	ra,0xfffff
    80004284:	cf8080e7          	jalr	-776(ra) # 80002f78 <readi>
    80004288:	04000793          	li	a5,64
    8000428c:	00f51a63          	bne	a0,a5,800042a0 <exec+0x88>
    goto bad;

  if(elf.magic != ELF_MAGIC)
    80004290:	e5042703          	lw	a4,-432(s0)
    80004294:	464c47b7          	lui	a5,0x464c4
    80004298:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    8000429c:	04f70663          	beq	a4,a5,800042e8 <exec+0xd0>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    800042a0:	854a                	mv	a0,s2
    800042a2:	fffff097          	auipc	ra,0xfffff
    800042a6:	c84080e7          	jalr	-892(ra) # 80002f26 <iunlockput>
    end_op();
    800042aa:	fffff097          	auipc	ra,0xfffff
    800042ae:	466080e7          	jalr	1126(ra) # 80003710 <end_op>
  }
  return -1;
    800042b2:	557d                	li	a0,-1
}
    800042b4:	21813083          	ld	ra,536(sp)
    800042b8:	21013403          	ld	s0,528(sp)
    800042bc:	20813483          	ld	s1,520(sp)
    800042c0:	20013903          	ld	s2,512(sp)
    800042c4:	79fe                	ld	s3,504(sp)
    800042c6:	7a5e                	ld	s4,496(sp)
    800042c8:	7abe                	ld	s5,488(sp)
    800042ca:	7b1e                	ld	s6,480(sp)
    800042cc:	6bfe                	ld	s7,472(sp)
    800042ce:	6c5e                	ld	s8,464(sp)
    800042d0:	6cbe                	ld	s9,456(sp)
    800042d2:	6d1e                	ld	s10,448(sp)
    800042d4:	7dfa                	ld	s11,440(sp)
    800042d6:	22010113          	addi	sp,sp,544
    800042da:	8082                	ret
    end_op();
    800042dc:	fffff097          	auipc	ra,0xfffff
    800042e0:	434080e7          	jalr	1076(ra) # 80003710 <end_op>
    return -1;
    800042e4:	557d                	li	a0,-1
    800042e6:	b7f9                	j	800042b4 <exec+0x9c>
  if((pagetable = proc_pagetable(p)) == 0)
    800042e8:	8526                	mv	a0,s1
    800042ea:	ffffd097          	auipc	ra,0xffffd
    800042ee:	cb0080e7          	jalr	-848(ra) # 80000f9a <proc_pagetable>
    800042f2:	e0a43423          	sd	a0,-504(s0)
    800042f6:	d54d                	beqz	a0,800042a0 <exec+0x88>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800042f8:	e7042983          	lw	s3,-400(s0)
    800042fc:	e8845783          	lhu	a5,-376(s0)
    80004300:	c7ad                	beqz	a5,8000436a <exec+0x152>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004302:	4a01                	li	s4,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004304:	4b01                	li	s6,0
    if(ph.vaddr % PGSIZE != 0)
    80004306:	6c05                	lui	s8,0x1
    80004308:	fffc0793          	addi	a5,s8,-1 # fff <_entry-0x7ffff001>
    8000430c:	def43423          	sd	a5,-536(s0)
    80004310:	7cfd                	lui	s9,0xfffff
    80004312:	a481                	j	80004552 <exec+0x33a>
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    80004314:	00004517          	auipc	a0,0x4
    80004318:	50450513          	addi	a0,a0,1284 # 80008818 <str_syscalls+0x378>
    8000431c:	00002097          	auipc	ra,0x2
    80004320:	b10080e7          	jalr	-1264(ra) # 80005e2c <panic>
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80004324:	8756                	mv	a4,s5
    80004326:	009d86bb          	addw	a3,s11,s1
    8000432a:	4581                	li	a1,0
    8000432c:	854a                	mv	a0,s2
    8000432e:	fffff097          	auipc	ra,0xfffff
    80004332:	c4a080e7          	jalr	-950(ra) # 80002f78 <readi>
    80004336:	2501                	sext.w	a0,a0
    80004338:	1caa9063          	bne	s5,a0,800044f8 <exec+0x2e0>
  for(i = 0; i < sz; i += PGSIZE){
    8000433c:	6785                	lui	a5,0x1
    8000433e:	9cbd                	addw	s1,s1,a5
    80004340:	014c8a3b          	addw	s4,s9,s4
    80004344:	1f74fe63          	bgeu	s1,s7,80004540 <exec+0x328>
    pa = walkaddr(pagetable, va + i);
    80004348:	02049593          	slli	a1,s1,0x20
    8000434c:	9181                	srli	a1,a1,0x20
    8000434e:	95ea                	add	a1,a1,s10
    80004350:	e0843503          	ld	a0,-504(s0)
    80004354:	ffffc097          	auipc	ra,0xffffc
    80004358:	226080e7          	jalr	550(ra) # 8000057a <walkaddr>
    8000435c:	862a                	mv	a2,a0
    if(pa == 0)
    8000435e:	d95d                	beqz	a0,80004314 <exec+0xfc>
      n = PGSIZE;
    80004360:	8ae2                	mv	s5,s8
    if(sz - i < PGSIZE)
    80004362:	fd8a71e3          	bgeu	s4,s8,80004324 <exec+0x10c>
      n = sz - i;
    80004366:	8ad2                	mv	s5,s4
    80004368:	bf75                	j	80004324 <exec+0x10c>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    8000436a:	4a01                	li	s4,0
  iunlockput(ip);
    8000436c:	854a                	mv	a0,s2
    8000436e:	fffff097          	auipc	ra,0xfffff
    80004372:	bb8080e7          	jalr	-1096(ra) # 80002f26 <iunlockput>
  end_op();
    80004376:	fffff097          	auipc	ra,0xfffff
    8000437a:	39a080e7          	jalr	922(ra) # 80003710 <end_op>
  p = myproc();
    8000437e:	ffffd097          	auipc	ra,0xffffd
    80004382:	b56080e7          	jalr	-1194(ra) # 80000ed4 <myproc>
    80004386:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    80004388:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    8000438c:	6785                	lui	a5,0x1
    8000438e:	17fd                	addi	a5,a5,-1
    80004390:	9a3e                	add	s4,s4,a5
    80004392:	77fd                	lui	a5,0xfffff
    80004394:	00fa77b3          	and	a5,s4,a5
    80004398:	e0f43023          	sd	a5,-512(s0)
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
    8000439c:	4691                	li	a3,4
    8000439e:	6609                	lui	a2,0x2
    800043a0:	963e                	add	a2,a2,a5
    800043a2:	85be                	mv	a1,a5
    800043a4:	e0843483          	ld	s1,-504(s0)
    800043a8:	8526                	mv	a0,s1
    800043aa:	ffffc097          	auipc	ra,0xffffc
    800043ae:	580080e7          	jalr	1408(ra) # 8000092a <uvmalloc>
    800043b2:	8b2a                	mv	s6,a0
  ip = 0;
    800043b4:	4901                	li	s2,0
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
    800043b6:	14050163          	beqz	a0,800044f8 <exec+0x2e0>
  uvmclear(pagetable, sz-2*PGSIZE);
    800043ba:	75f9                	lui	a1,0xffffe
    800043bc:	95aa                	add	a1,a1,a0
    800043be:	8526                	mv	a0,s1
    800043c0:	ffffc097          	auipc	ra,0xffffc
    800043c4:	790080e7          	jalr	1936(ra) # 80000b50 <uvmclear>
  stackbase = sp - PGSIZE;
    800043c8:	7bfd                	lui	s7,0xfffff
    800043ca:	9bda                	add	s7,s7,s6
  for(argc = 0; argv[argc]; argc++) {
    800043cc:	df843783          	ld	a5,-520(s0)
    800043d0:	6388                	ld	a0,0(a5)
    800043d2:	c925                	beqz	a0,80004442 <exec+0x22a>
    800043d4:	e9040993          	addi	s3,s0,-368
    800043d8:	f9040c13          	addi	s8,s0,-112
  sp = sz;
    800043dc:	895a                	mv	s2,s6
  for(argc = 0; argv[argc]; argc++) {
    800043de:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    800043e0:	ffffc097          	auipc	ra,0xffffc
    800043e4:	f8a080e7          	jalr	-118(ra) # 8000036a <strlen>
    800043e8:	2505                	addiw	a0,a0,1
    800043ea:	40a90933          	sub	s2,s2,a0
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    800043ee:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    800043f2:	13796b63          	bltu	s2,s7,80004528 <exec+0x310>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    800043f6:	df843c83          	ld	s9,-520(s0)
    800043fa:	000cba03          	ld	s4,0(s9) # fffffffffffff000 <end+0xffffffff7ffdcf00>
    800043fe:	8552                	mv	a0,s4
    80004400:	ffffc097          	auipc	ra,0xffffc
    80004404:	f6a080e7          	jalr	-150(ra) # 8000036a <strlen>
    80004408:	0015069b          	addiw	a3,a0,1
    8000440c:	8652                	mv	a2,s4
    8000440e:	85ca                	mv	a1,s2
    80004410:	e0843503          	ld	a0,-504(s0)
    80004414:	ffffc097          	auipc	ra,0xffffc
    80004418:	76e080e7          	jalr	1902(ra) # 80000b82 <copyout>
    8000441c:	10054a63          	bltz	a0,80004530 <exec+0x318>
    ustack[argc] = sp;
    80004420:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    80004424:	0485                	addi	s1,s1,1
    80004426:	008c8793          	addi	a5,s9,8
    8000442a:	def43c23          	sd	a5,-520(s0)
    8000442e:	008cb503          	ld	a0,8(s9)
    80004432:	c911                	beqz	a0,80004446 <exec+0x22e>
    if(argc >= MAXARG)
    80004434:	09a1                	addi	s3,s3,8
    80004436:	fb8995e3          	bne	s3,s8,800043e0 <exec+0x1c8>
  sz = sz1;
    8000443a:	e1643023          	sd	s6,-512(s0)
  ip = 0;
    8000443e:	4901                	li	s2,0
    80004440:	a865                	j	800044f8 <exec+0x2e0>
  sp = sz;
    80004442:	895a                	mv	s2,s6
  for(argc = 0; argv[argc]; argc++) {
    80004444:	4481                	li	s1,0
  ustack[argc] = 0;
    80004446:	00349793          	slli	a5,s1,0x3
    8000444a:	f9040713          	addi	a4,s0,-112
    8000444e:	97ba                	add	a5,a5,a4
    80004450:	f007b023          	sd	zero,-256(a5) # ffffffffffffef00 <end+0xffffffff7ffdce00>
  sp -= (argc+1) * sizeof(uint64);
    80004454:	00148693          	addi	a3,s1,1
    80004458:	068e                	slli	a3,a3,0x3
    8000445a:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    8000445e:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    80004462:	01797663          	bgeu	s2,s7,8000446e <exec+0x256>
  sz = sz1;
    80004466:	e1643023          	sd	s6,-512(s0)
  ip = 0;
    8000446a:	4901                	li	s2,0
    8000446c:	a071                	j	800044f8 <exec+0x2e0>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    8000446e:	e9040613          	addi	a2,s0,-368
    80004472:	85ca                	mv	a1,s2
    80004474:	e0843503          	ld	a0,-504(s0)
    80004478:	ffffc097          	auipc	ra,0xffffc
    8000447c:	70a080e7          	jalr	1802(ra) # 80000b82 <copyout>
    80004480:	0a054c63          	bltz	a0,80004538 <exec+0x320>
  p->trapframe->a1 = sp;
    80004484:	058ab783          	ld	a5,88(s5)
    80004488:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    8000448c:	df043783          	ld	a5,-528(s0)
    80004490:	0007c703          	lbu	a4,0(a5)
    80004494:	cf11                	beqz	a4,800044b0 <exec+0x298>
    80004496:	0785                	addi	a5,a5,1
    if(*s == '/')
    80004498:	02f00693          	li	a3,47
    8000449c:	a039                	j	800044aa <exec+0x292>
      last = s+1;
    8000449e:	def43823          	sd	a5,-528(s0)
    800044a2:	0785                	addi	a5,a5,1
  for(last=s=path; *s; s++)
    800044a4:	fff7c703          	lbu	a4,-1(a5)
    800044a8:	c701                	beqz	a4,800044b0 <exec+0x298>
    if(*s == '/')
    800044aa:	fed71ce3          	bne	a4,a3,800044a2 <exec+0x28a>
    800044ae:	bfc5                	j	8000449e <exec+0x286>
  safestrcpy(p->name, last, sizeof(p->name));
    800044b0:	4641                	li	a2,16
    800044b2:	df043583          	ld	a1,-528(s0)
    800044b6:	158a8513          	addi	a0,s5,344
    800044ba:	ffffc097          	auipc	ra,0xffffc
    800044be:	e7e080e7          	jalr	-386(ra) # 80000338 <safestrcpy>
  oldpagetable = p->pagetable;
    800044c2:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    800044c6:	e0843783          	ld	a5,-504(s0)
    800044ca:	04fab823          	sd	a5,80(s5)
  p->sz = sz;
    800044ce:	056ab423          	sd	s6,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    800044d2:	058ab783          	ld	a5,88(s5)
    800044d6:	e6843703          	ld	a4,-408(s0)
    800044da:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    800044dc:	058ab783          	ld	a5,88(s5)
    800044e0:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    800044e4:	85ea                	mv	a1,s10
    800044e6:	ffffd097          	auipc	ra,0xffffd
    800044ea:	b50080e7          	jalr	-1200(ra) # 80001036 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    800044ee:	0004851b          	sext.w	a0,s1
    800044f2:	b3c9                	j	800042b4 <exec+0x9c>
    800044f4:	e1443023          	sd	s4,-512(s0)
    proc_freepagetable(pagetable, sz);
    800044f8:	e0043583          	ld	a1,-512(s0)
    800044fc:	e0843503          	ld	a0,-504(s0)
    80004500:	ffffd097          	auipc	ra,0xffffd
    80004504:	b36080e7          	jalr	-1226(ra) # 80001036 <proc_freepagetable>
  if(ip){
    80004508:	d8091ce3          	bnez	s2,800042a0 <exec+0x88>
  return -1;
    8000450c:	557d                	li	a0,-1
    8000450e:	b35d                	j	800042b4 <exec+0x9c>
    80004510:	e1443023          	sd	s4,-512(s0)
    80004514:	b7d5                	j	800044f8 <exec+0x2e0>
    80004516:	e1443023          	sd	s4,-512(s0)
    8000451a:	bff9                	j	800044f8 <exec+0x2e0>
    8000451c:	e1443023          	sd	s4,-512(s0)
    80004520:	bfe1                	j	800044f8 <exec+0x2e0>
    80004522:	e1443023          	sd	s4,-512(s0)
    80004526:	bfc9                	j	800044f8 <exec+0x2e0>
  sz = sz1;
    80004528:	e1643023          	sd	s6,-512(s0)
  ip = 0;
    8000452c:	4901                	li	s2,0
    8000452e:	b7e9                	j	800044f8 <exec+0x2e0>
  sz = sz1;
    80004530:	e1643023          	sd	s6,-512(s0)
  ip = 0;
    80004534:	4901                	li	s2,0
    80004536:	b7c9                	j	800044f8 <exec+0x2e0>
  sz = sz1;
    80004538:	e1643023          	sd	s6,-512(s0)
  ip = 0;
    8000453c:	4901                	li	s2,0
    8000453e:	bf6d                	j	800044f8 <exec+0x2e0>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80004540:	e0043a03          	ld	s4,-512(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004544:	2b05                	addiw	s6,s6,1
    80004546:	0389899b          	addiw	s3,s3,56
    8000454a:	e8845783          	lhu	a5,-376(s0)
    8000454e:	e0fb5fe3          	bge	s6,a5,8000436c <exec+0x154>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80004552:	2981                	sext.w	s3,s3
    80004554:	03800713          	li	a4,56
    80004558:	86ce                	mv	a3,s3
    8000455a:	e1840613          	addi	a2,s0,-488
    8000455e:	4581                	li	a1,0
    80004560:	854a                	mv	a0,s2
    80004562:	fffff097          	auipc	ra,0xfffff
    80004566:	a16080e7          	jalr	-1514(ra) # 80002f78 <readi>
    8000456a:	03800793          	li	a5,56
    8000456e:	f8f513e3          	bne	a0,a5,800044f4 <exec+0x2dc>
    if(ph.type != ELF_PROG_LOAD)
    80004572:	e1842783          	lw	a5,-488(s0)
    80004576:	4705                	li	a4,1
    80004578:	fce796e3          	bne	a5,a4,80004544 <exec+0x32c>
    if(ph.memsz < ph.filesz)
    8000457c:	e4043483          	ld	s1,-448(s0)
    80004580:	e3843783          	ld	a5,-456(s0)
    80004584:	f8f4e6e3          	bltu	s1,a5,80004510 <exec+0x2f8>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80004588:	e2843783          	ld	a5,-472(s0)
    8000458c:	94be                	add	s1,s1,a5
    8000458e:	f8f4e4e3          	bltu	s1,a5,80004516 <exec+0x2fe>
    if(ph.vaddr % PGSIZE != 0)
    80004592:	de843703          	ld	a4,-536(s0)
    80004596:	8ff9                	and	a5,a5,a4
    80004598:	f3d1                	bnez	a5,8000451c <exec+0x304>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    8000459a:	e1c42503          	lw	a0,-484(s0)
    8000459e:	00000097          	auipc	ra,0x0
    800045a2:	c5e080e7          	jalr	-930(ra) # 800041fc <flags2perm>
    800045a6:	86aa                	mv	a3,a0
    800045a8:	8626                	mv	a2,s1
    800045aa:	85d2                	mv	a1,s4
    800045ac:	e0843503          	ld	a0,-504(s0)
    800045b0:	ffffc097          	auipc	ra,0xffffc
    800045b4:	37a080e7          	jalr	890(ra) # 8000092a <uvmalloc>
    800045b8:	e0a43023          	sd	a0,-512(s0)
    800045bc:	d13d                	beqz	a0,80004522 <exec+0x30a>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    800045be:	e2843d03          	ld	s10,-472(s0)
    800045c2:	e2042d83          	lw	s11,-480(s0)
    800045c6:	e3842b83          	lw	s7,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    800045ca:	f60b8be3          	beqz	s7,80004540 <exec+0x328>
    800045ce:	8a5e                	mv	s4,s7
    800045d0:	4481                	li	s1,0
    800045d2:	bb9d                	j	80004348 <exec+0x130>

00000000800045d4 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    800045d4:	7179                	addi	sp,sp,-48
    800045d6:	f406                	sd	ra,40(sp)
    800045d8:	f022                	sd	s0,32(sp)
    800045da:	ec26                	sd	s1,24(sp)
    800045dc:	e84a                	sd	s2,16(sp)
    800045de:	1800                	addi	s0,sp,48
    800045e0:	892e                	mv	s2,a1
    800045e2:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    800045e4:	fdc40593          	addi	a1,s0,-36
    800045e8:	ffffe097          	auipc	ra,0xffffe
    800045ec:	a7c080e7          	jalr	-1412(ra) # 80002064 <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    800045f0:	fdc42703          	lw	a4,-36(s0)
    800045f4:	47bd                	li	a5,15
    800045f6:	02e7eb63          	bltu	a5,a4,8000462c <argfd+0x58>
    800045fa:	ffffd097          	auipc	ra,0xffffd
    800045fe:	8da080e7          	jalr	-1830(ra) # 80000ed4 <myproc>
    80004602:	fdc42703          	lw	a4,-36(s0)
    80004606:	01a70793          	addi	a5,a4,26
    8000460a:	078e                	slli	a5,a5,0x3
    8000460c:	953e                	add	a0,a0,a5
    8000460e:	611c                	ld	a5,0(a0)
    80004610:	c385                	beqz	a5,80004630 <argfd+0x5c>
    return -1;
  if(pfd)
    80004612:	00090463          	beqz	s2,8000461a <argfd+0x46>
    *pfd = fd;
    80004616:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    8000461a:	4501                	li	a0,0
  if(pf)
    8000461c:	c091                	beqz	s1,80004620 <argfd+0x4c>
    *pf = f;
    8000461e:	e09c                	sd	a5,0(s1)
}
    80004620:	70a2                	ld	ra,40(sp)
    80004622:	7402                	ld	s0,32(sp)
    80004624:	64e2                	ld	s1,24(sp)
    80004626:	6942                	ld	s2,16(sp)
    80004628:	6145                	addi	sp,sp,48
    8000462a:	8082                	ret
    return -1;
    8000462c:	557d                	li	a0,-1
    8000462e:	bfcd                	j	80004620 <argfd+0x4c>
    80004630:	557d                	li	a0,-1
    80004632:	b7fd                	j	80004620 <argfd+0x4c>

0000000080004634 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80004634:	1101                	addi	sp,sp,-32
    80004636:	ec06                	sd	ra,24(sp)
    80004638:	e822                	sd	s0,16(sp)
    8000463a:	e426                	sd	s1,8(sp)
    8000463c:	1000                	addi	s0,sp,32
    8000463e:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80004640:	ffffd097          	auipc	ra,0xffffd
    80004644:	894080e7          	jalr	-1900(ra) # 80000ed4 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(p->ofile[fd] == 0){
    80004648:	697c                	ld	a5,208(a0)
    8000464a:	c395                	beqz	a5,8000466e <fdalloc+0x3a>
    8000464c:	0d850713          	addi	a4,a0,216
  for(fd = 0; fd < NOFILE; fd++){
    80004650:	4785                	li	a5,1
    80004652:	4641                	li	a2,16
    if(p->ofile[fd] == 0){
    80004654:	6314                	ld	a3,0(a4)
    80004656:	ce89                	beqz	a3,80004670 <fdalloc+0x3c>
  for(fd = 0; fd < NOFILE; fd++){
    80004658:	2785                	addiw	a5,a5,1
    8000465a:	0721                	addi	a4,a4,8
    8000465c:	fec79ce3          	bne	a5,a2,80004654 <fdalloc+0x20>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80004660:	57fd                	li	a5,-1
}
    80004662:	853e                	mv	a0,a5
    80004664:	60e2                	ld	ra,24(sp)
    80004666:	6442                	ld	s0,16(sp)
    80004668:	64a2                	ld	s1,8(sp)
    8000466a:	6105                	addi	sp,sp,32
    8000466c:	8082                	ret
  for(fd = 0; fd < NOFILE; fd++){
    8000466e:	4781                	li	a5,0
      p->ofile[fd] = f;
    80004670:	01a78713          	addi	a4,a5,26
    80004674:	070e                	slli	a4,a4,0x3
    80004676:	953a                	add	a0,a0,a4
    80004678:	e104                	sd	s1,0(a0)
      return fd;
    8000467a:	b7e5                	j	80004662 <fdalloc+0x2e>

000000008000467c <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    8000467c:	715d                	addi	sp,sp,-80
    8000467e:	e486                	sd	ra,72(sp)
    80004680:	e0a2                	sd	s0,64(sp)
    80004682:	fc26                	sd	s1,56(sp)
    80004684:	f84a                	sd	s2,48(sp)
    80004686:	f44e                	sd	s3,40(sp)
    80004688:	f052                	sd	s4,32(sp)
    8000468a:	ec56                	sd	s5,24(sp)
    8000468c:	e85a                	sd	s6,16(sp)
    8000468e:	0880                	addi	s0,sp,80
    80004690:	89ae                	mv	s3,a1
    80004692:	8b32                	mv	s6,a2
    80004694:	8ab6                	mv	s5,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80004696:	fb040593          	addi	a1,s0,-80
    8000469a:	fffff097          	auipc	ra,0xfffff
    8000469e:	df6080e7          	jalr	-522(ra) # 80003490 <nameiparent>
    800046a2:	84aa                	mv	s1,a0
    800046a4:	14050d63          	beqz	a0,800047fe <create+0x182>
    return 0;

  ilock(dp);
    800046a8:	ffffe097          	auipc	ra,0xffffe
    800046ac:	61a080e7          	jalr	1562(ra) # 80002cc2 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    800046b0:	4601                	li	a2,0
    800046b2:	fb040593          	addi	a1,s0,-80
    800046b6:	8526                	mv	a0,s1
    800046b8:	fffff097          	auipc	ra,0xfffff
    800046bc:	af0080e7          	jalr	-1296(ra) # 800031a8 <dirlookup>
    800046c0:	892a                	mv	s2,a0
    800046c2:	c929                	beqz	a0,80004714 <create+0x98>
    iunlockput(dp);
    800046c4:	8526                	mv	a0,s1
    800046c6:	fffff097          	auipc	ra,0xfffff
    800046ca:	860080e7          	jalr	-1952(ra) # 80002f26 <iunlockput>
    ilock(ip);
    800046ce:	854a                	mv	a0,s2
    800046d0:	ffffe097          	auipc	ra,0xffffe
    800046d4:	5f2080e7          	jalr	1522(ra) # 80002cc2 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    800046d8:	2981                	sext.w	s3,s3
    800046da:	4789                	li	a5,2
    800046dc:	02f99563          	bne	s3,a5,80004706 <create+0x8a>
    800046e0:	04495783          	lhu	a5,68(s2)
    800046e4:	37f9                	addiw	a5,a5,-2
    800046e6:	17c2                	slli	a5,a5,0x30
    800046e8:	93c1                	srli	a5,a5,0x30
    800046ea:	4705                	li	a4,1
    800046ec:	00f76d63          	bltu	a4,a5,80004706 <create+0x8a>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    800046f0:	854a                	mv	a0,s2
    800046f2:	60a6                	ld	ra,72(sp)
    800046f4:	6406                	ld	s0,64(sp)
    800046f6:	74e2                	ld	s1,56(sp)
    800046f8:	7942                	ld	s2,48(sp)
    800046fa:	79a2                	ld	s3,40(sp)
    800046fc:	7a02                	ld	s4,32(sp)
    800046fe:	6ae2                	ld	s5,24(sp)
    80004700:	6b42                	ld	s6,16(sp)
    80004702:	6161                	addi	sp,sp,80
    80004704:	8082                	ret
    iunlockput(ip);
    80004706:	854a                	mv	a0,s2
    80004708:	fffff097          	auipc	ra,0xfffff
    8000470c:	81e080e7          	jalr	-2018(ra) # 80002f26 <iunlockput>
    return 0;
    80004710:	4901                	li	s2,0
    80004712:	bff9                	j	800046f0 <create+0x74>
  if((ip = ialloc(dp->dev, type)) == 0){
    80004714:	85ce                	mv	a1,s3
    80004716:	4088                	lw	a0,0(s1)
    80004718:	ffffe097          	auipc	ra,0xffffe
    8000471c:	40a080e7          	jalr	1034(ra) # 80002b22 <ialloc>
    80004720:	8a2a                	mv	s4,a0
    80004722:	c531                	beqz	a0,8000476e <create+0xf2>
  ilock(ip);
    80004724:	ffffe097          	auipc	ra,0xffffe
    80004728:	59e080e7          	jalr	1438(ra) # 80002cc2 <ilock>
  ip->major = major;
    8000472c:	056a1323          	sh	s6,70(s4)
  ip->minor = minor;
    80004730:	055a1423          	sh	s5,72(s4)
  ip->nlink = 1;
    80004734:	4a85                	li	s5,1
    80004736:	055a1523          	sh	s5,74(s4)
  iupdate(ip);
    8000473a:	8552                	mv	a0,s4
    8000473c:	ffffe097          	auipc	ra,0xffffe
    80004740:	4ba080e7          	jalr	1210(ra) # 80002bf6 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    80004744:	2981                	sext.w	s3,s3
    80004746:	03598b63          	beq	s3,s5,8000477c <create+0x100>
  if(dirlink(dp, name, ip->inum) < 0)
    8000474a:	004a2603          	lw	a2,4(s4)
    8000474e:	fb040593          	addi	a1,s0,-80
    80004752:	8526                	mv	a0,s1
    80004754:	fffff097          	auipc	ra,0xfffff
    80004758:	c6c080e7          	jalr	-916(ra) # 800033c0 <dirlink>
    8000475c:	06054f63          	bltz	a0,800047da <create+0x15e>
  iunlockput(dp);
    80004760:	8526                	mv	a0,s1
    80004762:	ffffe097          	auipc	ra,0xffffe
    80004766:	7c4080e7          	jalr	1988(ra) # 80002f26 <iunlockput>
  return ip;
    8000476a:	8952                	mv	s2,s4
    8000476c:	b751                	j	800046f0 <create+0x74>
    iunlockput(dp);
    8000476e:	8526                	mv	a0,s1
    80004770:	ffffe097          	auipc	ra,0xffffe
    80004774:	7b6080e7          	jalr	1974(ra) # 80002f26 <iunlockput>
    return 0;
    80004778:	8952                	mv	s2,s4
    8000477a:	bf9d                	j	800046f0 <create+0x74>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    8000477c:	004a2603          	lw	a2,4(s4)
    80004780:	00004597          	auipc	a1,0x4
    80004784:	0b858593          	addi	a1,a1,184 # 80008838 <str_syscalls+0x398>
    80004788:	8552                	mv	a0,s4
    8000478a:	fffff097          	auipc	ra,0xfffff
    8000478e:	c36080e7          	jalr	-970(ra) # 800033c0 <dirlink>
    80004792:	04054463          	bltz	a0,800047da <create+0x15e>
    80004796:	40d0                	lw	a2,4(s1)
    80004798:	00004597          	auipc	a1,0x4
    8000479c:	0a858593          	addi	a1,a1,168 # 80008840 <str_syscalls+0x3a0>
    800047a0:	8552                	mv	a0,s4
    800047a2:	fffff097          	auipc	ra,0xfffff
    800047a6:	c1e080e7          	jalr	-994(ra) # 800033c0 <dirlink>
    800047aa:	02054863          	bltz	a0,800047da <create+0x15e>
  if(dirlink(dp, name, ip->inum) < 0)
    800047ae:	004a2603          	lw	a2,4(s4)
    800047b2:	fb040593          	addi	a1,s0,-80
    800047b6:	8526                	mv	a0,s1
    800047b8:	fffff097          	auipc	ra,0xfffff
    800047bc:	c08080e7          	jalr	-1016(ra) # 800033c0 <dirlink>
    800047c0:	00054d63          	bltz	a0,800047da <create+0x15e>
    dp->nlink++;  // for ".."
    800047c4:	04a4d783          	lhu	a5,74(s1)
    800047c8:	2785                	addiw	a5,a5,1
    800047ca:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    800047ce:	8526                	mv	a0,s1
    800047d0:	ffffe097          	auipc	ra,0xffffe
    800047d4:	426080e7          	jalr	1062(ra) # 80002bf6 <iupdate>
    800047d8:	b761                	j	80004760 <create+0xe4>
  ip->nlink = 0;
    800047da:	040a1523          	sh	zero,74(s4)
  iupdate(ip);
    800047de:	8552                	mv	a0,s4
    800047e0:	ffffe097          	auipc	ra,0xffffe
    800047e4:	416080e7          	jalr	1046(ra) # 80002bf6 <iupdate>
  iunlockput(ip);
    800047e8:	8552                	mv	a0,s4
    800047ea:	ffffe097          	auipc	ra,0xffffe
    800047ee:	73c080e7          	jalr	1852(ra) # 80002f26 <iunlockput>
  iunlockput(dp);
    800047f2:	8526                	mv	a0,s1
    800047f4:	ffffe097          	auipc	ra,0xffffe
    800047f8:	732080e7          	jalr	1842(ra) # 80002f26 <iunlockput>
  return 0;
    800047fc:	bdd5                	j	800046f0 <create+0x74>
    return 0;
    800047fe:	892a                	mv	s2,a0
    80004800:	bdc5                	j	800046f0 <create+0x74>

0000000080004802 <sys_dup>:
{
    80004802:	7179                	addi	sp,sp,-48
    80004804:	f406                	sd	ra,40(sp)
    80004806:	f022                	sd	s0,32(sp)
    80004808:	ec26                	sd	s1,24(sp)
    8000480a:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    8000480c:	fd840613          	addi	a2,s0,-40
    80004810:	4581                	li	a1,0
    80004812:	4501                	li	a0,0
    80004814:	00000097          	auipc	ra,0x0
    80004818:	dc0080e7          	jalr	-576(ra) # 800045d4 <argfd>
    return -1;
    8000481c:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    8000481e:	02054363          	bltz	a0,80004844 <sys_dup+0x42>
  if((fd=fdalloc(f)) < 0)
    80004822:	fd843503          	ld	a0,-40(s0)
    80004826:	00000097          	auipc	ra,0x0
    8000482a:	e0e080e7          	jalr	-498(ra) # 80004634 <fdalloc>
    8000482e:	84aa                	mv	s1,a0
    return -1;
    80004830:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    80004832:	00054963          	bltz	a0,80004844 <sys_dup+0x42>
  filedup(f);
    80004836:	fd843503          	ld	a0,-40(s0)
    8000483a:	fffff097          	auipc	ra,0xfffff
    8000483e:	2fe080e7          	jalr	766(ra) # 80003b38 <filedup>
  return fd;
    80004842:	87a6                	mv	a5,s1
}
    80004844:	853e                	mv	a0,a5
    80004846:	70a2                	ld	ra,40(sp)
    80004848:	7402                	ld	s0,32(sp)
    8000484a:	64e2                	ld	s1,24(sp)
    8000484c:	6145                	addi	sp,sp,48
    8000484e:	8082                	ret

0000000080004850 <sys_read>:
{
    80004850:	7179                	addi	sp,sp,-48
    80004852:	f406                	sd	ra,40(sp)
    80004854:	f022                	sd	s0,32(sp)
    80004856:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80004858:	fd840593          	addi	a1,s0,-40
    8000485c:	4505                	li	a0,1
    8000485e:	ffffe097          	auipc	ra,0xffffe
    80004862:	826080e7          	jalr	-2010(ra) # 80002084 <argaddr>
  argint(2, &n);
    80004866:	fe440593          	addi	a1,s0,-28
    8000486a:	4509                	li	a0,2
    8000486c:	ffffd097          	auipc	ra,0xffffd
    80004870:	7f8080e7          	jalr	2040(ra) # 80002064 <argint>
  if(argfd(0, 0, &f) < 0)
    80004874:	fe840613          	addi	a2,s0,-24
    80004878:	4581                	li	a1,0
    8000487a:	4501                	li	a0,0
    8000487c:	00000097          	auipc	ra,0x0
    80004880:	d58080e7          	jalr	-680(ra) # 800045d4 <argfd>
    return -1;
    80004884:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80004886:	00054d63          	bltz	a0,800048a0 <sys_read+0x50>
  return fileread(f, p, n);
    8000488a:	fe442603          	lw	a2,-28(s0)
    8000488e:	fd843583          	ld	a1,-40(s0)
    80004892:	fe843503          	ld	a0,-24(s0)
    80004896:	fffff097          	auipc	ra,0xfffff
    8000489a:	42e080e7          	jalr	1070(ra) # 80003cc4 <fileread>
    8000489e:	87aa                	mv	a5,a0
}
    800048a0:	853e                	mv	a0,a5
    800048a2:	70a2                	ld	ra,40(sp)
    800048a4:	7402                	ld	s0,32(sp)
    800048a6:	6145                	addi	sp,sp,48
    800048a8:	8082                	ret

00000000800048aa <sys_write>:
{
    800048aa:	7179                	addi	sp,sp,-48
    800048ac:	f406                	sd	ra,40(sp)
    800048ae:	f022                	sd	s0,32(sp)
    800048b0:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    800048b2:	fd840593          	addi	a1,s0,-40
    800048b6:	4505                	li	a0,1
    800048b8:	ffffd097          	auipc	ra,0xffffd
    800048bc:	7cc080e7          	jalr	1996(ra) # 80002084 <argaddr>
  argint(2, &n);
    800048c0:	fe440593          	addi	a1,s0,-28
    800048c4:	4509                	li	a0,2
    800048c6:	ffffd097          	auipc	ra,0xffffd
    800048ca:	79e080e7          	jalr	1950(ra) # 80002064 <argint>
  if(argfd(0, 0, &f) < 0)
    800048ce:	fe840613          	addi	a2,s0,-24
    800048d2:	4581                	li	a1,0
    800048d4:	4501                	li	a0,0
    800048d6:	00000097          	auipc	ra,0x0
    800048da:	cfe080e7          	jalr	-770(ra) # 800045d4 <argfd>
    return -1;
    800048de:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    800048e0:	00054d63          	bltz	a0,800048fa <sys_write+0x50>
  return filewrite(f, p, n);
    800048e4:	fe442603          	lw	a2,-28(s0)
    800048e8:	fd843583          	ld	a1,-40(s0)
    800048ec:	fe843503          	ld	a0,-24(s0)
    800048f0:	fffff097          	auipc	ra,0xfffff
    800048f4:	496080e7          	jalr	1174(ra) # 80003d86 <filewrite>
    800048f8:	87aa                	mv	a5,a0
}
    800048fa:	853e                	mv	a0,a5
    800048fc:	70a2                	ld	ra,40(sp)
    800048fe:	7402                	ld	s0,32(sp)
    80004900:	6145                	addi	sp,sp,48
    80004902:	8082                	ret

0000000080004904 <sys_close>:
{
    80004904:	1101                	addi	sp,sp,-32
    80004906:	ec06                	sd	ra,24(sp)
    80004908:	e822                	sd	s0,16(sp)
    8000490a:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    8000490c:	fe040613          	addi	a2,s0,-32
    80004910:	fec40593          	addi	a1,s0,-20
    80004914:	4501                	li	a0,0
    80004916:	00000097          	auipc	ra,0x0
    8000491a:	cbe080e7          	jalr	-834(ra) # 800045d4 <argfd>
    return -1;
    8000491e:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80004920:	02054463          	bltz	a0,80004948 <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    80004924:	ffffc097          	auipc	ra,0xffffc
    80004928:	5b0080e7          	jalr	1456(ra) # 80000ed4 <myproc>
    8000492c:	fec42783          	lw	a5,-20(s0)
    80004930:	07e9                	addi	a5,a5,26
    80004932:	078e                	slli	a5,a5,0x3
    80004934:	953e                	add	a0,a0,a5
    80004936:	00053023          	sd	zero,0(a0)
  fileclose(f);
    8000493a:	fe043503          	ld	a0,-32(s0)
    8000493e:	fffff097          	auipc	ra,0xfffff
    80004942:	24c080e7          	jalr	588(ra) # 80003b8a <fileclose>
  return 0;
    80004946:	4781                	li	a5,0
}
    80004948:	853e                	mv	a0,a5
    8000494a:	60e2                	ld	ra,24(sp)
    8000494c:	6442                	ld	s0,16(sp)
    8000494e:	6105                	addi	sp,sp,32
    80004950:	8082                	ret

0000000080004952 <sys_fstat>:
{
    80004952:	1101                	addi	sp,sp,-32
    80004954:	ec06                	sd	ra,24(sp)
    80004956:	e822                	sd	s0,16(sp)
    80004958:	1000                	addi	s0,sp,32
  argaddr(1, &st);
    8000495a:	fe040593          	addi	a1,s0,-32
    8000495e:	4505                	li	a0,1
    80004960:	ffffd097          	auipc	ra,0xffffd
    80004964:	724080e7          	jalr	1828(ra) # 80002084 <argaddr>
  if(argfd(0, 0, &f) < 0)
    80004968:	fe840613          	addi	a2,s0,-24
    8000496c:	4581                	li	a1,0
    8000496e:	4501                	li	a0,0
    80004970:	00000097          	auipc	ra,0x0
    80004974:	c64080e7          	jalr	-924(ra) # 800045d4 <argfd>
    return -1;
    80004978:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    8000497a:	00054b63          	bltz	a0,80004990 <sys_fstat+0x3e>
  return filestat(f, st);
    8000497e:	fe043583          	ld	a1,-32(s0)
    80004982:	fe843503          	ld	a0,-24(s0)
    80004986:	fffff097          	auipc	ra,0xfffff
    8000498a:	2cc080e7          	jalr	716(ra) # 80003c52 <filestat>
    8000498e:	87aa                	mv	a5,a0
}
    80004990:	853e                	mv	a0,a5
    80004992:	60e2                	ld	ra,24(sp)
    80004994:	6442                	ld	s0,16(sp)
    80004996:	6105                	addi	sp,sp,32
    80004998:	8082                	ret

000000008000499a <sys_link>:
{
    8000499a:	7169                	addi	sp,sp,-304
    8000499c:	f606                	sd	ra,296(sp)
    8000499e:	f222                	sd	s0,288(sp)
    800049a0:	ee26                	sd	s1,280(sp)
    800049a2:	ea4a                	sd	s2,272(sp)
    800049a4:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800049a6:	08000613          	li	a2,128
    800049aa:	ed040593          	addi	a1,s0,-304
    800049ae:	4501                	li	a0,0
    800049b0:	ffffd097          	auipc	ra,0xffffd
    800049b4:	6f4080e7          	jalr	1780(ra) # 800020a4 <argstr>
    return -1;
    800049b8:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800049ba:	10054e63          	bltz	a0,80004ad6 <sys_link+0x13c>
    800049be:	08000613          	li	a2,128
    800049c2:	f5040593          	addi	a1,s0,-176
    800049c6:	4505                	li	a0,1
    800049c8:	ffffd097          	auipc	ra,0xffffd
    800049cc:	6dc080e7          	jalr	1756(ra) # 800020a4 <argstr>
    return -1;
    800049d0:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800049d2:	10054263          	bltz	a0,80004ad6 <sys_link+0x13c>
  begin_op();
    800049d6:	fffff097          	auipc	ra,0xfffff
    800049da:	cba080e7          	jalr	-838(ra) # 80003690 <begin_op>
  if((ip = namei(old)) == 0){
    800049de:	ed040513          	addi	a0,s0,-304
    800049e2:	fffff097          	auipc	ra,0xfffff
    800049e6:	a90080e7          	jalr	-1392(ra) # 80003472 <namei>
    800049ea:	84aa                	mv	s1,a0
    800049ec:	c551                	beqz	a0,80004a78 <sys_link+0xde>
  ilock(ip);
    800049ee:	ffffe097          	auipc	ra,0xffffe
    800049f2:	2d4080e7          	jalr	724(ra) # 80002cc2 <ilock>
  if(ip->type == T_DIR){
    800049f6:	04449703          	lh	a4,68(s1)
    800049fa:	4785                	li	a5,1
    800049fc:	08f70463          	beq	a4,a5,80004a84 <sys_link+0xea>
  ip->nlink++;
    80004a00:	04a4d783          	lhu	a5,74(s1)
    80004a04:	2785                	addiw	a5,a5,1
    80004a06:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004a0a:	8526                	mv	a0,s1
    80004a0c:	ffffe097          	auipc	ra,0xffffe
    80004a10:	1ea080e7          	jalr	490(ra) # 80002bf6 <iupdate>
  iunlock(ip);
    80004a14:	8526                	mv	a0,s1
    80004a16:	ffffe097          	auipc	ra,0xffffe
    80004a1a:	370080e7          	jalr	880(ra) # 80002d86 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80004a1e:	fd040593          	addi	a1,s0,-48
    80004a22:	f5040513          	addi	a0,s0,-176
    80004a26:	fffff097          	auipc	ra,0xfffff
    80004a2a:	a6a080e7          	jalr	-1430(ra) # 80003490 <nameiparent>
    80004a2e:	892a                	mv	s2,a0
    80004a30:	c935                	beqz	a0,80004aa4 <sys_link+0x10a>
  ilock(dp);
    80004a32:	ffffe097          	auipc	ra,0xffffe
    80004a36:	290080e7          	jalr	656(ra) # 80002cc2 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80004a3a:	00092703          	lw	a4,0(s2)
    80004a3e:	409c                	lw	a5,0(s1)
    80004a40:	04f71d63          	bne	a4,a5,80004a9a <sys_link+0x100>
    80004a44:	40d0                	lw	a2,4(s1)
    80004a46:	fd040593          	addi	a1,s0,-48
    80004a4a:	854a                	mv	a0,s2
    80004a4c:	fffff097          	auipc	ra,0xfffff
    80004a50:	974080e7          	jalr	-1676(ra) # 800033c0 <dirlink>
    80004a54:	04054363          	bltz	a0,80004a9a <sys_link+0x100>
  iunlockput(dp);
    80004a58:	854a                	mv	a0,s2
    80004a5a:	ffffe097          	auipc	ra,0xffffe
    80004a5e:	4cc080e7          	jalr	1228(ra) # 80002f26 <iunlockput>
  iput(ip);
    80004a62:	8526                	mv	a0,s1
    80004a64:	ffffe097          	auipc	ra,0xffffe
    80004a68:	41a080e7          	jalr	1050(ra) # 80002e7e <iput>
  end_op();
    80004a6c:	fffff097          	auipc	ra,0xfffff
    80004a70:	ca4080e7          	jalr	-860(ra) # 80003710 <end_op>
  return 0;
    80004a74:	4781                	li	a5,0
    80004a76:	a085                	j	80004ad6 <sys_link+0x13c>
    end_op();
    80004a78:	fffff097          	auipc	ra,0xfffff
    80004a7c:	c98080e7          	jalr	-872(ra) # 80003710 <end_op>
    return -1;
    80004a80:	57fd                	li	a5,-1
    80004a82:	a891                	j	80004ad6 <sys_link+0x13c>
    iunlockput(ip);
    80004a84:	8526                	mv	a0,s1
    80004a86:	ffffe097          	auipc	ra,0xffffe
    80004a8a:	4a0080e7          	jalr	1184(ra) # 80002f26 <iunlockput>
    end_op();
    80004a8e:	fffff097          	auipc	ra,0xfffff
    80004a92:	c82080e7          	jalr	-894(ra) # 80003710 <end_op>
    return -1;
    80004a96:	57fd                	li	a5,-1
    80004a98:	a83d                	j	80004ad6 <sys_link+0x13c>
    iunlockput(dp);
    80004a9a:	854a                	mv	a0,s2
    80004a9c:	ffffe097          	auipc	ra,0xffffe
    80004aa0:	48a080e7          	jalr	1162(ra) # 80002f26 <iunlockput>
  ilock(ip);
    80004aa4:	8526                	mv	a0,s1
    80004aa6:	ffffe097          	auipc	ra,0xffffe
    80004aaa:	21c080e7          	jalr	540(ra) # 80002cc2 <ilock>
  ip->nlink--;
    80004aae:	04a4d783          	lhu	a5,74(s1)
    80004ab2:	37fd                	addiw	a5,a5,-1
    80004ab4:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004ab8:	8526                	mv	a0,s1
    80004aba:	ffffe097          	auipc	ra,0xffffe
    80004abe:	13c080e7          	jalr	316(ra) # 80002bf6 <iupdate>
  iunlockput(ip);
    80004ac2:	8526                	mv	a0,s1
    80004ac4:	ffffe097          	auipc	ra,0xffffe
    80004ac8:	462080e7          	jalr	1122(ra) # 80002f26 <iunlockput>
  end_op();
    80004acc:	fffff097          	auipc	ra,0xfffff
    80004ad0:	c44080e7          	jalr	-956(ra) # 80003710 <end_op>
  return -1;
    80004ad4:	57fd                	li	a5,-1
}
    80004ad6:	853e                	mv	a0,a5
    80004ad8:	70b2                	ld	ra,296(sp)
    80004ada:	7412                	ld	s0,288(sp)
    80004adc:	64f2                	ld	s1,280(sp)
    80004ade:	6952                	ld	s2,272(sp)
    80004ae0:	6155                	addi	sp,sp,304
    80004ae2:	8082                	ret

0000000080004ae4 <sys_unlink>:
{
    80004ae4:	7151                	addi	sp,sp,-240
    80004ae6:	f586                	sd	ra,232(sp)
    80004ae8:	f1a2                	sd	s0,224(sp)
    80004aea:	eda6                	sd	s1,216(sp)
    80004aec:	e9ca                	sd	s2,208(sp)
    80004aee:	e5ce                	sd	s3,200(sp)
    80004af0:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80004af2:	08000613          	li	a2,128
    80004af6:	f3040593          	addi	a1,s0,-208
    80004afa:	4501                	li	a0,0
    80004afc:	ffffd097          	auipc	ra,0xffffd
    80004b00:	5a8080e7          	jalr	1448(ra) # 800020a4 <argstr>
    80004b04:	16054f63          	bltz	a0,80004c82 <sys_unlink+0x19e>
  begin_op();
    80004b08:	fffff097          	auipc	ra,0xfffff
    80004b0c:	b88080e7          	jalr	-1144(ra) # 80003690 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80004b10:	fb040593          	addi	a1,s0,-80
    80004b14:	f3040513          	addi	a0,s0,-208
    80004b18:	fffff097          	auipc	ra,0xfffff
    80004b1c:	978080e7          	jalr	-1672(ra) # 80003490 <nameiparent>
    80004b20:	89aa                	mv	s3,a0
    80004b22:	c979                	beqz	a0,80004bf8 <sys_unlink+0x114>
  ilock(dp);
    80004b24:	ffffe097          	auipc	ra,0xffffe
    80004b28:	19e080e7          	jalr	414(ra) # 80002cc2 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80004b2c:	00004597          	auipc	a1,0x4
    80004b30:	d0c58593          	addi	a1,a1,-756 # 80008838 <str_syscalls+0x398>
    80004b34:	fb040513          	addi	a0,s0,-80
    80004b38:	ffffe097          	auipc	ra,0xffffe
    80004b3c:	656080e7          	jalr	1622(ra) # 8000318e <namecmp>
    80004b40:	14050863          	beqz	a0,80004c90 <sys_unlink+0x1ac>
    80004b44:	00004597          	auipc	a1,0x4
    80004b48:	cfc58593          	addi	a1,a1,-772 # 80008840 <str_syscalls+0x3a0>
    80004b4c:	fb040513          	addi	a0,s0,-80
    80004b50:	ffffe097          	auipc	ra,0xffffe
    80004b54:	63e080e7          	jalr	1598(ra) # 8000318e <namecmp>
    80004b58:	12050c63          	beqz	a0,80004c90 <sys_unlink+0x1ac>
  if((ip = dirlookup(dp, name, &off)) == 0)
    80004b5c:	f2c40613          	addi	a2,s0,-212
    80004b60:	fb040593          	addi	a1,s0,-80
    80004b64:	854e                	mv	a0,s3
    80004b66:	ffffe097          	auipc	ra,0xffffe
    80004b6a:	642080e7          	jalr	1602(ra) # 800031a8 <dirlookup>
    80004b6e:	84aa                	mv	s1,a0
    80004b70:	12050063          	beqz	a0,80004c90 <sys_unlink+0x1ac>
  ilock(ip);
    80004b74:	ffffe097          	auipc	ra,0xffffe
    80004b78:	14e080e7          	jalr	334(ra) # 80002cc2 <ilock>
  if(ip->nlink < 1)
    80004b7c:	04a49783          	lh	a5,74(s1)
    80004b80:	08f05263          	blez	a5,80004c04 <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004b84:	04449703          	lh	a4,68(s1)
    80004b88:	4785                	li	a5,1
    80004b8a:	08f70563          	beq	a4,a5,80004c14 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    80004b8e:	4641                	li	a2,16
    80004b90:	4581                	li	a1,0
    80004b92:	fc040513          	addi	a0,s0,-64
    80004b96:	ffffb097          	auipc	ra,0xffffb
    80004b9a:	62e080e7          	jalr	1582(ra) # 800001c4 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004b9e:	4741                	li	a4,16
    80004ba0:	f2c42683          	lw	a3,-212(s0)
    80004ba4:	fc040613          	addi	a2,s0,-64
    80004ba8:	4581                	li	a1,0
    80004baa:	854e                	mv	a0,s3
    80004bac:	ffffe097          	auipc	ra,0xffffe
    80004bb0:	4c4080e7          	jalr	1220(ra) # 80003070 <writei>
    80004bb4:	47c1                	li	a5,16
    80004bb6:	0af51363          	bne	a0,a5,80004c5c <sys_unlink+0x178>
  if(ip->type == T_DIR){
    80004bba:	04449703          	lh	a4,68(s1)
    80004bbe:	4785                	li	a5,1
    80004bc0:	0af70663          	beq	a4,a5,80004c6c <sys_unlink+0x188>
  iunlockput(dp);
    80004bc4:	854e                	mv	a0,s3
    80004bc6:	ffffe097          	auipc	ra,0xffffe
    80004bca:	360080e7          	jalr	864(ra) # 80002f26 <iunlockput>
  ip->nlink--;
    80004bce:	04a4d783          	lhu	a5,74(s1)
    80004bd2:	37fd                	addiw	a5,a5,-1
    80004bd4:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004bd8:	8526                	mv	a0,s1
    80004bda:	ffffe097          	auipc	ra,0xffffe
    80004bde:	01c080e7          	jalr	28(ra) # 80002bf6 <iupdate>
  iunlockput(ip);
    80004be2:	8526                	mv	a0,s1
    80004be4:	ffffe097          	auipc	ra,0xffffe
    80004be8:	342080e7          	jalr	834(ra) # 80002f26 <iunlockput>
  end_op();
    80004bec:	fffff097          	auipc	ra,0xfffff
    80004bf0:	b24080e7          	jalr	-1244(ra) # 80003710 <end_op>
  return 0;
    80004bf4:	4501                	li	a0,0
    80004bf6:	a07d                	j	80004ca4 <sys_unlink+0x1c0>
    end_op();
    80004bf8:	fffff097          	auipc	ra,0xfffff
    80004bfc:	b18080e7          	jalr	-1256(ra) # 80003710 <end_op>
    return -1;
    80004c00:	557d                	li	a0,-1
    80004c02:	a04d                	j	80004ca4 <sys_unlink+0x1c0>
    panic("unlink: nlink < 1");
    80004c04:	00004517          	auipc	a0,0x4
    80004c08:	c4450513          	addi	a0,a0,-956 # 80008848 <str_syscalls+0x3a8>
    80004c0c:	00001097          	auipc	ra,0x1
    80004c10:	220080e7          	jalr	544(ra) # 80005e2c <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004c14:	44f8                	lw	a4,76(s1)
    80004c16:	02000793          	li	a5,32
    80004c1a:	f6e7fae3          	bgeu	a5,a4,80004b8e <sys_unlink+0xaa>
    80004c1e:	02000913          	li	s2,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004c22:	4741                	li	a4,16
    80004c24:	86ca                	mv	a3,s2
    80004c26:	f1840613          	addi	a2,s0,-232
    80004c2a:	4581                	li	a1,0
    80004c2c:	8526                	mv	a0,s1
    80004c2e:	ffffe097          	auipc	ra,0xffffe
    80004c32:	34a080e7          	jalr	842(ra) # 80002f78 <readi>
    80004c36:	47c1                	li	a5,16
    80004c38:	00f51a63          	bne	a0,a5,80004c4c <sys_unlink+0x168>
    if(de.inum != 0)
    80004c3c:	f1845783          	lhu	a5,-232(s0)
    80004c40:	e3b9                	bnez	a5,80004c86 <sys_unlink+0x1a2>
    80004c42:	2941                	addiw	s2,s2,16
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004c44:	44fc                	lw	a5,76(s1)
    80004c46:	fcf96ee3          	bltu	s2,a5,80004c22 <sys_unlink+0x13e>
    80004c4a:	b791                	j	80004b8e <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80004c4c:	00004517          	auipc	a0,0x4
    80004c50:	c1450513          	addi	a0,a0,-1004 # 80008860 <str_syscalls+0x3c0>
    80004c54:	00001097          	auipc	ra,0x1
    80004c58:	1d8080e7          	jalr	472(ra) # 80005e2c <panic>
    panic("unlink: writei");
    80004c5c:	00004517          	auipc	a0,0x4
    80004c60:	c1c50513          	addi	a0,a0,-996 # 80008878 <str_syscalls+0x3d8>
    80004c64:	00001097          	auipc	ra,0x1
    80004c68:	1c8080e7          	jalr	456(ra) # 80005e2c <panic>
    dp->nlink--;
    80004c6c:	04a9d783          	lhu	a5,74(s3)
    80004c70:	37fd                	addiw	a5,a5,-1
    80004c72:	04f99523          	sh	a5,74(s3)
    iupdate(dp);
    80004c76:	854e                	mv	a0,s3
    80004c78:	ffffe097          	auipc	ra,0xffffe
    80004c7c:	f7e080e7          	jalr	-130(ra) # 80002bf6 <iupdate>
    80004c80:	b791                	j	80004bc4 <sys_unlink+0xe0>
    return -1;
    80004c82:	557d                	li	a0,-1
    80004c84:	a005                	j	80004ca4 <sys_unlink+0x1c0>
    iunlockput(ip);
    80004c86:	8526                	mv	a0,s1
    80004c88:	ffffe097          	auipc	ra,0xffffe
    80004c8c:	29e080e7          	jalr	670(ra) # 80002f26 <iunlockput>
  iunlockput(dp);
    80004c90:	854e                	mv	a0,s3
    80004c92:	ffffe097          	auipc	ra,0xffffe
    80004c96:	294080e7          	jalr	660(ra) # 80002f26 <iunlockput>
  end_op();
    80004c9a:	fffff097          	auipc	ra,0xfffff
    80004c9e:	a76080e7          	jalr	-1418(ra) # 80003710 <end_op>
  return -1;
    80004ca2:	557d                	li	a0,-1
}
    80004ca4:	70ae                	ld	ra,232(sp)
    80004ca6:	740e                	ld	s0,224(sp)
    80004ca8:	64ee                	ld	s1,216(sp)
    80004caa:	694e                	ld	s2,208(sp)
    80004cac:	69ae                	ld	s3,200(sp)
    80004cae:	616d                	addi	sp,sp,240
    80004cb0:	8082                	ret

0000000080004cb2 <sys_open>:

uint64
sys_open(void)
{
    80004cb2:	7131                	addi	sp,sp,-192
    80004cb4:	fd06                	sd	ra,184(sp)
    80004cb6:	f922                	sd	s0,176(sp)
    80004cb8:	f526                	sd	s1,168(sp)
    80004cba:	f14a                	sd	s2,160(sp)
    80004cbc:	ed4e                	sd	s3,152(sp)
    80004cbe:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    80004cc0:	f4c40593          	addi	a1,s0,-180
    80004cc4:	4505                	li	a0,1
    80004cc6:	ffffd097          	auipc	ra,0xffffd
    80004cca:	39e080e7          	jalr	926(ra) # 80002064 <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004cce:	08000613          	li	a2,128
    80004cd2:	f5040593          	addi	a1,s0,-176
    80004cd6:	4501                	li	a0,0
    80004cd8:	ffffd097          	auipc	ra,0xffffd
    80004cdc:	3cc080e7          	jalr	972(ra) # 800020a4 <argstr>
    return -1;
    80004ce0:	597d                	li	s2,-1
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004ce2:	0a054863          	bltz	a0,80004d92 <sys_open+0xe0>

  begin_op();
    80004ce6:	fffff097          	auipc	ra,0xfffff
    80004cea:	9aa080e7          	jalr	-1622(ra) # 80003690 <begin_op>

  if(omode & O_CREATE){
    80004cee:	f4c42783          	lw	a5,-180(s0)
    80004cf2:	2007f793          	andi	a5,a5,512
    80004cf6:	cbdd                	beqz	a5,80004dac <sys_open+0xfa>
    ip = create(path, T_FILE, 0, 0);
    80004cf8:	4681                	li	a3,0
    80004cfa:	4601                	li	a2,0
    80004cfc:	4589                	li	a1,2
    80004cfe:	f5040513          	addi	a0,s0,-176
    80004d02:	00000097          	auipc	ra,0x0
    80004d06:	97a080e7          	jalr	-1670(ra) # 8000467c <create>
    80004d0a:	84aa                	mv	s1,a0
    if(ip == 0){
    80004d0c:	c959                	beqz	a0,80004da2 <sys_open+0xf0>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80004d0e:	04449703          	lh	a4,68(s1)
    80004d12:	478d                	li	a5,3
    80004d14:	00f71763          	bne	a4,a5,80004d22 <sys_open+0x70>
    80004d18:	0464d703          	lhu	a4,70(s1)
    80004d1c:	47a5                	li	a5,9
    80004d1e:	0ce7ec63          	bltu	a5,a4,80004df6 <sys_open+0x144>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004d22:	fffff097          	auipc	ra,0xfffff
    80004d26:	d98080e7          	jalr	-616(ra) # 80003aba <filealloc>
    80004d2a:	89aa                	mv	s3,a0
    80004d2c:	10050263          	beqz	a0,80004e30 <sys_open+0x17e>
    80004d30:	00000097          	auipc	ra,0x0
    80004d34:	904080e7          	jalr	-1788(ra) # 80004634 <fdalloc>
    80004d38:	892a                	mv	s2,a0
    80004d3a:	0e054663          	bltz	a0,80004e26 <sys_open+0x174>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004d3e:	04449703          	lh	a4,68(s1)
    80004d42:	478d                	li	a5,3
    80004d44:	0cf70463          	beq	a4,a5,80004e0c <sys_open+0x15a>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004d48:	4789                	li	a5,2
    80004d4a:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    80004d4e:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    80004d52:	0099bc23          	sd	s1,24(s3)
  f->readable = !(omode & O_WRONLY);
    80004d56:	f4c42783          	lw	a5,-180(s0)
    80004d5a:	0017c713          	xori	a4,a5,1
    80004d5e:	8b05                	andi	a4,a4,1
    80004d60:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004d64:	0037f713          	andi	a4,a5,3
    80004d68:	00e03733          	snez	a4,a4
    80004d6c:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004d70:	4007f793          	andi	a5,a5,1024
    80004d74:	c791                	beqz	a5,80004d80 <sys_open+0xce>
    80004d76:	04449703          	lh	a4,68(s1)
    80004d7a:	4789                	li	a5,2
    80004d7c:	08f70f63          	beq	a4,a5,80004e1a <sys_open+0x168>
    itrunc(ip);
  }

  iunlock(ip);
    80004d80:	8526                	mv	a0,s1
    80004d82:	ffffe097          	auipc	ra,0xffffe
    80004d86:	004080e7          	jalr	4(ra) # 80002d86 <iunlock>
  end_op();
    80004d8a:	fffff097          	auipc	ra,0xfffff
    80004d8e:	986080e7          	jalr	-1658(ra) # 80003710 <end_op>

  return fd;
}
    80004d92:	854a                	mv	a0,s2
    80004d94:	70ea                	ld	ra,184(sp)
    80004d96:	744a                	ld	s0,176(sp)
    80004d98:	74aa                	ld	s1,168(sp)
    80004d9a:	790a                	ld	s2,160(sp)
    80004d9c:	69ea                	ld	s3,152(sp)
    80004d9e:	6129                	addi	sp,sp,192
    80004da0:	8082                	ret
      end_op();
    80004da2:	fffff097          	auipc	ra,0xfffff
    80004da6:	96e080e7          	jalr	-1682(ra) # 80003710 <end_op>
      return -1;
    80004daa:	b7e5                	j	80004d92 <sys_open+0xe0>
    if((ip = namei(path)) == 0){
    80004dac:	f5040513          	addi	a0,s0,-176
    80004db0:	ffffe097          	auipc	ra,0xffffe
    80004db4:	6c2080e7          	jalr	1730(ra) # 80003472 <namei>
    80004db8:	84aa                	mv	s1,a0
    80004dba:	c905                	beqz	a0,80004dea <sys_open+0x138>
    ilock(ip);
    80004dbc:	ffffe097          	auipc	ra,0xffffe
    80004dc0:	f06080e7          	jalr	-250(ra) # 80002cc2 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80004dc4:	04449703          	lh	a4,68(s1)
    80004dc8:	4785                	li	a5,1
    80004dca:	f4f712e3          	bne	a4,a5,80004d0e <sys_open+0x5c>
    80004dce:	f4c42783          	lw	a5,-180(s0)
    80004dd2:	dba1                	beqz	a5,80004d22 <sys_open+0x70>
      iunlockput(ip);
    80004dd4:	8526                	mv	a0,s1
    80004dd6:	ffffe097          	auipc	ra,0xffffe
    80004dda:	150080e7          	jalr	336(ra) # 80002f26 <iunlockput>
      end_op();
    80004dde:	fffff097          	auipc	ra,0xfffff
    80004de2:	932080e7          	jalr	-1742(ra) # 80003710 <end_op>
      return -1;
    80004de6:	597d                	li	s2,-1
    80004de8:	b76d                	j	80004d92 <sys_open+0xe0>
      end_op();
    80004dea:	fffff097          	auipc	ra,0xfffff
    80004dee:	926080e7          	jalr	-1754(ra) # 80003710 <end_op>
      return -1;
    80004df2:	597d                	li	s2,-1
    80004df4:	bf79                	j	80004d92 <sys_open+0xe0>
    iunlockput(ip);
    80004df6:	8526                	mv	a0,s1
    80004df8:	ffffe097          	auipc	ra,0xffffe
    80004dfc:	12e080e7          	jalr	302(ra) # 80002f26 <iunlockput>
    end_op();
    80004e00:	fffff097          	auipc	ra,0xfffff
    80004e04:	910080e7          	jalr	-1776(ra) # 80003710 <end_op>
    return -1;
    80004e08:	597d                	li	s2,-1
    80004e0a:	b761                	j	80004d92 <sys_open+0xe0>
    f->type = FD_DEVICE;
    80004e0c:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    80004e10:	04649783          	lh	a5,70(s1)
    80004e14:	02f99223          	sh	a5,36(s3)
    80004e18:	bf2d                	j	80004d52 <sys_open+0xa0>
    itrunc(ip);
    80004e1a:	8526                	mv	a0,s1
    80004e1c:	ffffe097          	auipc	ra,0xffffe
    80004e20:	fb6080e7          	jalr	-74(ra) # 80002dd2 <itrunc>
    80004e24:	bfb1                	j	80004d80 <sys_open+0xce>
      fileclose(f);
    80004e26:	854e                	mv	a0,s3
    80004e28:	fffff097          	auipc	ra,0xfffff
    80004e2c:	d62080e7          	jalr	-670(ra) # 80003b8a <fileclose>
    iunlockput(ip);
    80004e30:	8526                	mv	a0,s1
    80004e32:	ffffe097          	auipc	ra,0xffffe
    80004e36:	0f4080e7          	jalr	244(ra) # 80002f26 <iunlockput>
    end_op();
    80004e3a:	fffff097          	auipc	ra,0xfffff
    80004e3e:	8d6080e7          	jalr	-1834(ra) # 80003710 <end_op>
    return -1;
    80004e42:	597d                	li	s2,-1
    80004e44:	b7b9                	j	80004d92 <sys_open+0xe0>

0000000080004e46 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80004e46:	7175                	addi	sp,sp,-144
    80004e48:	e506                	sd	ra,136(sp)
    80004e4a:	e122                	sd	s0,128(sp)
    80004e4c:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80004e4e:	fffff097          	auipc	ra,0xfffff
    80004e52:	842080e7          	jalr	-1982(ra) # 80003690 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80004e56:	08000613          	li	a2,128
    80004e5a:	f7040593          	addi	a1,s0,-144
    80004e5e:	4501                	li	a0,0
    80004e60:	ffffd097          	auipc	ra,0xffffd
    80004e64:	244080e7          	jalr	580(ra) # 800020a4 <argstr>
    80004e68:	02054963          	bltz	a0,80004e9a <sys_mkdir+0x54>
    80004e6c:	4681                	li	a3,0
    80004e6e:	4601                	li	a2,0
    80004e70:	4585                	li	a1,1
    80004e72:	f7040513          	addi	a0,s0,-144
    80004e76:	00000097          	auipc	ra,0x0
    80004e7a:	806080e7          	jalr	-2042(ra) # 8000467c <create>
    80004e7e:	cd11                	beqz	a0,80004e9a <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004e80:	ffffe097          	auipc	ra,0xffffe
    80004e84:	0a6080e7          	jalr	166(ra) # 80002f26 <iunlockput>
  end_op();
    80004e88:	fffff097          	auipc	ra,0xfffff
    80004e8c:	888080e7          	jalr	-1912(ra) # 80003710 <end_op>
  return 0;
    80004e90:	4501                	li	a0,0
}
    80004e92:	60aa                	ld	ra,136(sp)
    80004e94:	640a                	ld	s0,128(sp)
    80004e96:	6149                	addi	sp,sp,144
    80004e98:	8082                	ret
    end_op();
    80004e9a:	fffff097          	auipc	ra,0xfffff
    80004e9e:	876080e7          	jalr	-1930(ra) # 80003710 <end_op>
    return -1;
    80004ea2:	557d                	li	a0,-1
    80004ea4:	b7fd                	j	80004e92 <sys_mkdir+0x4c>

0000000080004ea6 <sys_mknod>:

uint64
sys_mknod(void)
{
    80004ea6:	7135                	addi	sp,sp,-160
    80004ea8:	ed06                	sd	ra,152(sp)
    80004eaa:	e922                	sd	s0,144(sp)
    80004eac:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80004eae:	ffffe097          	auipc	ra,0xffffe
    80004eb2:	7e2080e7          	jalr	2018(ra) # 80003690 <begin_op>
  argint(1, &major);
    80004eb6:	f6c40593          	addi	a1,s0,-148
    80004eba:	4505                	li	a0,1
    80004ebc:	ffffd097          	auipc	ra,0xffffd
    80004ec0:	1a8080e7          	jalr	424(ra) # 80002064 <argint>
  argint(2, &minor);
    80004ec4:	f6840593          	addi	a1,s0,-152
    80004ec8:	4509                	li	a0,2
    80004eca:	ffffd097          	auipc	ra,0xffffd
    80004ece:	19a080e7          	jalr	410(ra) # 80002064 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004ed2:	08000613          	li	a2,128
    80004ed6:	f7040593          	addi	a1,s0,-144
    80004eda:	4501                	li	a0,0
    80004edc:	ffffd097          	auipc	ra,0xffffd
    80004ee0:	1c8080e7          	jalr	456(ra) # 800020a4 <argstr>
    80004ee4:	02054b63          	bltz	a0,80004f1a <sys_mknod+0x74>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80004ee8:	f6841683          	lh	a3,-152(s0)
    80004eec:	f6c41603          	lh	a2,-148(s0)
    80004ef0:	458d                	li	a1,3
    80004ef2:	f7040513          	addi	a0,s0,-144
    80004ef6:	fffff097          	auipc	ra,0xfffff
    80004efa:	786080e7          	jalr	1926(ra) # 8000467c <create>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004efe:	cd11                	beqz	a0,80004f1a <sys_mknod+0x74>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004f00:	ffffe097          	auipc	ra,0xffffe
    80004f04:	026080e7          	jalr	38(ra) # 80002f26 <iunlockput>
  end_op();
    80004f08:	fffff097          	auipc	ra,0xfffff
    80004f0c:	808080e7          	jalr	-2040(ra) # 80003710 <end_op>
  return 0;
    80004f10:	4501                	li	a0,0
}
    80004f12:	60ea                	ld	ra,152(sp)
    80004f14:	644a                	ld	s0,144(sp)
    80004f16:	610d                	addi	sp,sp,160
    80004f18:	8082                	ret
    end_op();
    80004f1a:	ffffe097          	auipc	ra,0xffffe
    80004f1e:	7f6080e7          	jalr	2038(ra) # 80003710 <end_op>
    return -1;
    80004f22:	557d                	li	a0,-1
    80004f24:	b7fd                	j	80004f12 <sys_mknod+0x6c>

0000000080004f26 <sys_chdir>:

uint64
sys_chdir(void)
{
    80004f26:	7135                	addi	sp,sp,-160
    80004f28:	ed06                	sd	ra,152(sp)
    80004f2a:	e922                	sd	s0,144(sp)
    80004f2c:	e526                	sd	s1,136(sp)
    80004f2e:	e14a                	sd	s2,128(sp)
    80004f30:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80004f32:	ffffc097          	auipc	ra,0xffffc
    80004f36:	fa2080e7          	jalr	-94(ra) # 80000ed4 <myproc>
    80004f3a:	892a                	mv	s2,a0
  
  begin_op();
    80004f3c:	ffffe097          	auipc	ra,0xffffe
    80004f40:	754080e7          	jalr	1876(ra) # 80003690 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80004f44:	08000613          	li	a2,128
    80004f48:	f6040593          	addi	a1,s0,-160
    80004f4c:	4501                	li	a0,0
    80004f4e:	ffffd097          	auipc	ra,0xffffd
    80004f52:	156080e7          	jalr	342(ra) # 800020a4 <argstr>
    80004f56:	04054b63          	bltz	a0,80004fac <sys_chdir+0x86>
    80004f5a:	f6040513          	addi	a0,s0,-160
    80004f5e:	ffffe097          	auipc	ra,0xffffe
    80004f62:	514080e7          	jalr	1300(ra) # 80003472 <namei>
    80004f66:	84aa                	mv	s1,a0
    80004f68:	c131                	beqz	a0,80004fac <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80004f6a:	ffffe097          	auipc	ra,0xffffe
    80004f6e:	d58080e7          	jalr	-680(ra) # 80002cc2 <ilock>
  if(ip->type != T_DIR){
    80004f72:	04449703          	lh	a4,68(s1)
    80004f76:	4785                	li	a5,1
    80004f78:	04f71063          	bne	a4,a5,80004fb8 <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80004f7c:	8526                	mv	a0,s1
    80004f7e:	ffffe097          	auipc	ra,0xffffe
    80004f82:	e08080e7          	jalr	-504(ra) # 80002d86 <iunlock>
  iput(p->cwd);
    80004f86:	15093503          	ld	a0,336(s2)
    80004f8a:	ffffe097          	auipc	ra,0xffffe
    80004f8e:	ef4080e7          	jalr	-268(ra) # 80002e7e <iput>
  end_op();
    80004f92:	ffffe097          	auipc	ra,0xffffe
    80004f96:	77e080e7          	jalr	1918(ra) # 80003710 <end_op>
  p->cwd = ip;
    80004f9a:	14993823          	sd	s1,336(s2)
  return 0;
    80004f9e:	4501                	li	a0,0
}
    80004fa0:	60ea                	ld	ra,152(sp)
    80004fa2:	644a                	ld	s0,144(sp)
    80004fa4:	64aa                	ld	s1,136(sp)
    80004fa6:	690a                	ld	s2,128(sp)
    80004fa8:	610d                	addi	sp,sp,160
    80004faa:	8082                	ret
    end_op();
    80004fac:	ffffe097          	auipc	ra,0xffffe
    80004fb0:	764080e7          	jalr	1892(ra) # 80003710 <end_op>
    return -1;
    80004fb4:	557d                	li	a0,-1
    80004fb6:	b7ed                	j	80004fa0 <sys_chdir+0x7a>
    iunlockput(ip);
    80004fb8:	8526                	mv	a0,s1
    80004fba:	ffffe097          	auipc	ra,0xffffe
    80004fbe:	f6c080e7          	jalr	-148(ra) # 80002f26 <iunlockput>
    end_op();
    80004fc2:	ffffe097          	auipc	ra,0xffffe
    80004fc6:	74e080e7          	jalr	1870(ra) # 80003710 <end_op>
    return -1;
    80004fca:	557d                	li	a0,-1
    80004fcc:	bfd1                	j	80004fa0 <sys_chdir+0x7a>

0000000080004fce <sys_exec>:

uint64
sys_exec(void)
{
    80004fce:	7145                	addi	sp,sp,-464
    80004fd0:	e786                	sd	ra,456(sp)
    80004fd2:	e3a2                	sd	s0,448(sp)
    80004fd4:	ff26                	sd	s1,440(sp)
    80004fd6:	fb4a                	sd	s2,432(sp)
    80004fd8:	f74e                	sd	s3,424(sp)
    80004fda:	f352                	sd	s4,416(sp)
    80004fdc:	ef56                	sd	s5,408(sp)
    80004fde:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    80004fe0:	e3840593          	addi	a1,s0,-456
    80004fe4:	4505                	li	a0,1
    80004fe6:	ffffd097          	auipc	ra,0xffffd
    80004fea:	09e080e7          	jalr	158(ra) # 80002084 <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    80004fee:	08000613          	li	a2,128
    80004ff2:	f4040593          	addi	a1,s0,-192
    80004ff6:	4501                	li	a0,0
    80004ff8:	ffffd097          	auipc	ra,0xffffd
    80004ffc:	0ac080e7          	jalr	172(ra) # 800020a4 <argstr>
    return -1;
    80005000:	597d                	li	s2,-1
  if(argstr(0, path, MAXPATH) < 0) {
    80005002:	0e054363          	bltz	a0,800050e8 <sys_exec+0x11a>
  }
  memset(argv, 0, sizeof(argv));
    80005006:	e4040913          	addi	s2,s0,-448
    8000500a:	10000613          	li	a2,256
    8000500e:	4581                	li	a1,0
    80005010:	854a                	mv	a0,s2
    80005012:	ffffb097          	auipc	ra,0xffffb
    80005016:	1b2080e7          	jalr	434(ra) # 800001c4 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    8000501a:	89ca                	mv	s3,s2
  memset(argv, 0, sizeof(argv));
    8000501c:	4481                	li	s1,0
    if(i >= NELEM(argv)){
    8000501e:	02000a93          	li	s5,32
    80005022:	00048a1b          	sext.w	s4,s1
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80005026:	00349513          	slli	a0,s1,0x3
    8000502a:	e3040593          	addi	a1,s0,-464
    8000502e:	e3843783          	ld	a5,-456(s0)
    80005032:	953e                	add	a0,a0,a5
    80005034:	ffffd097          	auipc	ra,0xffffd
    80005038:	f92080e7          	jalr	-110(ra) # 80001fc6 <fetchaddr>
    8000503c:	02054a63          	bltz	a0,80005070 <sys_exec+0xa2>
      goto bad;
    }
    if(uarg == 0){
    80005040:	e3043783          	ld	a5,-464(s0)
    80005044:	cfa9                	beqz	a5,8000509e <sys_exec+0xd0>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80005046:	ffffb097          	auipc	ra,0xffffb
    8000504a:	0d4080e7          	jalr	212(ra) # 8000011a <kalloc>
    8000504e:	00a93023          	sd	a0,0(s2)
    if(argv[i] == 0)
    80005052:	cd19                	beqz	a0,80005070 <sys_exec+0xa2>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80005054:	6605                	lui	a2,0x1
    80005056:	85aa                	mv	a1,a0
    80005058:	e3043503          	ld	a0,-464(s0)
    8000505c:	ffffd097          	auipc	ra,0xffffd
    80005060:	fbc080e7          	jalr	-68(ra) # 80002018 <fetchstr>
    80005064:	00054663          	bltz	a0,80005070 <sys_exec+0xa2>
    if(i >= NELEM(argv)){
    80005068:	0485                	addi	s1,s1,1
    8000506a:	0921                	addi	s2,s2,8
    8000506c:	fb549be3          	bne	s1,s5,80005022 <sys_exec+0x54>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005070:	e4043503          	ld	a0,-448(s0)
    kfree(argv[i]);
  return -1;
    80005074:	597d                	li	s2,-1
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005076:	c92d                	beqz	a0,800050e8 <sys_exec+0x11a>
    kfree(argv[i]);
    80005078:	ffffb097          	auipc	ra,0xffffb
    8000507c:	fa4080e7          	jalr	-92(ra) # 8000001c <kfree>
    80005080:	e4840493          	addi	s1,s0,-440
    80005084:	10098993          	addi	s3,s3,256
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005088:	6088                	ld	a0,0(s1)
    8000508a:	cd31                	beqz	a0,800050e6 <sys_exec+0x118>
    kfree(argv[i]);
    8000508c:	ffffb097          	auipc	ra,0xffffb
    80005090:	f90080e7          	jalr	-112(ra) # 8000001c <kfree>
    80005094:	04a1                	addi	s1,s1,8
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005096:	ff3499e3          	bne	s1,s3,80005088 <sys_exec+0xba>
  return -1;
    8000509a:	597d                	li	s2,-1
    8000509c:	a0b1                	j	800050e8 <sys_exec+0x11a>
      argv[i] = 0;
    8000509e:	0a0e                	slli	s4,s4,0x3
    800050a0:	fc040793          	addi	a5,s0,-64
    800050a4:	9a3e                	add	s4,s4,a5
    800050a6:	e80a3023          	sd	zero,-384(s4)
  int ret = exec(path, argv);
    800050aa:	e4040593          	addi	a1,s0,-448
    800050ae:	f4040513          	addi	a0,s0,-192
    800050b2:	fffff097          	auipc	ra,0xfffff
    800050b6:	166080e7          	jalr	358(ra) # 80004218 <exec>
    800050ba:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800050bc:	e4043503          	ld	a0,-448(s0)
    800050c0:	c505                	beqz	a0,800050e8 <sys_exec+0x11a>
    kfree(argv[i]);
    800050c2:	ffffb097          	auipc	ra,0xffffb
    800050c6:	f5a080e7          	jalr	-166(ra) # 8000001c <kfree>
    800050ca:	e4840493          	addi	s1,s0,-440
    800050ce:	10098993          	addi	s3,s3,256
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800050d2:	6088                	ld	a0,0(s1)
    800050d4:	c911                	beqz	a0,800050e8 <sys_exec+0x11a>
    kfree(argv[i]);
    800050d6:	ffffb097          	auipc	ra,0xffffb
    800050da:	f46080e7          	jalr	-186(ra) # 8000001c <kfree>
    800050de:	04a1                	addi	s1,s1,8
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800050e0:	ff3499e3          	bne	s1,s3,800050d2 <sys_exec+0x104>
    800050e4:	a011                	j	800050e8 <sys_exec+0x11a>
  return -1;
    800050e6:	597d                	li	s2,-1
}
    800050e8:	854a                	mv	a0,s2
    800050ea:	60be                	ld	ra,456(sp)
    800050ec:	641e                	ld	s0,448(sp)
    800050ee:	74fa                	ld	s1,440(sp)
    800050f0:	795a                	ld	s2,432(sp)
    800050f2:	79ba                	ld	s3,424(sp)
    800050f4:	7a1a                	ld	s4,416(sp)
    800050f6:	6afa                	ld	s5,408(sp)
    800050f8:	6179                	addi	sp,sp,464
    800050fa:	8082                	ret

00000000800050fc <sys_pipe>:

uint64
sys_pipe(void)
{
    800050fc:	7139                	addi	sp,sp,-64
    800050fe:	fc06                	sd	ra,56(sp)
    80005100:	f822                	sd	s0,48(sp)
    80005102:	f426                	sd	s1,40(sp)
    80005104:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80005106:	ffffc097          	auipc	ra,0xffffc
    8000510a:	dce080e7          	jalr	-562(ra) # 80000ed4 <myproc>
    8000510e:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    80005110:	fd840593          	addi	a1,s0,-40
    80005114:	4501                	li	a0,0
    80005116:	ffffd097          	auipc	ra,0xffffd
    8000511a:	f6e080e7          	jalr	-146(ra) # 80002084 <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    8000511e:	fc840593          	addi	a1,s0,-56
    80005122:	fd040513          	addi	a0,s0,-48
    80005126:	fffff097          	auipc	ra,0xfffff
    8000512a:	d88080e7          	jalr	-632(ra) # 80003eae <pipealloc>
    return -1;
    8000512e:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80005130:	0c054463          	bltz	a0,800051f8 <sys_pipe+0xfc>
  fd0 = -1;
    80005134:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80005138:	fd043503          	ld	a0,-48(s0)
    8000513c:	fffff097          	auipc	ra,0xfffff
    80005140:	4f8080e7          	jalr	1272(ra) # 80004634 <fdalloc>
    80005144:	fca42223          	sw	a0,-60(s0)
    80005148:	08054b63          	bltz	a0,800051de <sys_pipe+0xe2>
    8000514c:	fc843503          	ld	a0,-56(s0)
    80005150:	fffff097          	auipc	ra,0xfffff
    80005154:	4e4080e7          	jalr	1252(ra) # 80004634 <fdalloc>
    80005158:	fca42023          	sw	a0,-64(s0)
    8000515c:	06054863          	bltz	a0,800051cc <sys_pipe+0xd0>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005160:	4691                	li	a3,4
    80005162:	fc440613          	addi	a2,s0,-60
    80005166:	fd843583          	ld	a1,-40(s0)
    8000516a:	68a8                	ld	a0,80(s1)
    8000516c:	ffffc097          	auipc	ra,0xffffc
    80005170:	a16080e7          	jalr	-1514(ra) # 80000b82 <copyout>
    80005174:	02054063          	bltz	a0,80005194 <sys_pipe+0x98>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80005178:	4691                	li	a3,4
    8000517a:	fc040613          	addi	a2,s0,-64
    8000517e:	fd843583          	ld	a1,-40(s0)
    80005182:	0591                	addi	a1,a1,4
    80005184:	68a8                	ld	a0,80(s1)
    80005186:	ffffc097          	auipc	ra,0xffffc
    8000518a:	9fc080e7          	jalr	-1540(ra) # 80000b82 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    8000518e:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005190:	06055463          	bgez	a0,800051f8 <sys_pipe+0xfc>
    p->ofile[fd0] = 0;
    80005194:	fc442783          	lw	a5,-60(s0)
    80005198:	07e9                	addi	a5,a5,26
    8000519a:	078e                	slli	a5,a5,0x3
    8000519c:	97a6                	add	a5,a5,s1
    8000519e:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    800051a2:	fc042783          	lw	a5,-64(s0)
    800051a6:	07e9                	addi	a5,a5,26
    800051a8:	078e                	slli	a5,a5,0x3
    800051aa:	94be                	add	s1,s1,a5
    800051ac:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    800051b0:	fd043503          	ld	a0,-48(s0)
    800051b4:	fffff097          	auipc	ra,0xfffff
    800051b8:	9d6080e7          	jalr	-1578(ra) # 80003b8a <fileclose>
    fileclose(wf);
    800051bc:	fc843503          	ld	a0,-56(s0)
    800051c0:	fffff097          	auipc	ra,0xfffff
    800051c4:	9ca080e7          	jalr	-1590(ra) # 80003b8a <fileclose>
    return -1;
    800051c8:	57fd                	li	a5,-1
    800051ca:	a03d                	j	800051f8 <sys_pipe+0xfc>
    if(fd0 >= 0)
    800051cc:	fc442783          	lw	a5,-60(s0)
    800051d0:	0007c763          	bltz	a5,800051de <sys_pipe+0xe2>
      p->ofile[fd0] = 0;
    800051d4:	07e9                	addi	a5,a5,26
    800051d6:	078e                	slli	a5,a5,0x3
    800051d8:	94be                	add	s1,s1,a5
    800051da:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    800051de:	fd043503          	ld	a0,-48(s0)
    800051e2:	fffff097          	auipc	ra,0xfffff
    800051e6:	9a8080e7          	jalr	-1624(ra) # 80003b8a <fileclose>
    fileclose(wf);
    800051ea:	fc843503          	ld	a0,-56(s0)
    800051ee:	fffff097          	auipc	ra,0xfffff
    800051f2:	99c080e7          	jalr	-1636(ra) # 80003b8a <fileclose>
    return -1;
    800051f6:	57fd                	li	a5,-1
}
    800051f8:	853e                	mv	a0,a5
    800051fa:	70e2                	ld	ra,56(sp)
    800051fc:	7442                	ld	s0,48(sp)
    800051fe:	74a2                	ld	s1,40(sp)
    80005200:	6121                	addi	sp,sp,64
    80005202:	8082                	ret
	...

0000000080005210 <kernelvec>:
    80005210:	7111                	addi	sp,sp,-256
    80005212:	e006                	sd	ra,0(sp)
    80005214:	e40a                	sd	sp,8(sp)
    80005216:	e80e                	sd	gp,16(sp)
    80005218:	ec12                	sd	tp,24(sp)
    8000521a:	f016                	sd	t0,32(sp)
    8000521c:	f41a                	sd	t1,40(sp)
    8000521e:	f81e                	sd	t2,48(sp)
    80005220:	fc22                	sd	s0,56(sp)
    80005222:	e0a6                	sd	s1,64(sp)
    80005224:	e4aa                	sd	a0,72(sp)
    80005226:	e8ae                	sd	a1,80(sp)
    80005228:	ecb2                	sd	a2,88(sp)
    8000522a:	f0b6                	sd	a3,96(sp)
    8000522c:	f4ba                	sd	a4,104(sp)
    8000522e:	f8be                	sd	a5,112(sp)
    80005230:	fcc2                	sd	a6,120(sp)
    80005232:	e146                	sd	a7,128(sp)
    80005234:	e54a                	sd	s2,136(sp)
    80005236:	e94e                	sd	s3,144(sp)
    80005238:	ed52                	sd	s4,152(sp)
    8000523a:	f156                	sd	s5,160(sp)
    8000523c:	f55a                	sd	s6,168(sp)
    8000523e:	f95e                	sd	s7,176(sp)
    80005240:	fd62                	sd	s8,184(sp)
    80005242:	e1e6                	sd	s9,192(sp)
    80005244:	e5ea                	sd	s10,200(sp)
    80005246:	e9ee                	sd	s11,208(sp)
    80005248:	edf2                	sd	t3,216(sp)
    8000524a:	f1f6                	sd	t4,224(sp)
    8000524c:	f5fa                	sd	t5,232(sp)
    8000524e:	f9fe                	sd	t6,240(sp)
    80005250:	c43fc0ef          	jal	ra,80001e92 <kerneltrap>
    80005254:	6082                	ld	ra,0(sp)
    80005256:	6122                	ld	sp,8(sp)
    80005258:	61c2                	ld	gp,16(sp)
    8000525a:	7282                	ld	t0,32(sp)
    8000525c:	7322                	ld	t1,40(sp)
    8000525e:	73c2                	ld	t2,48(sp)
    80005260:	7462                	ld	s0,56(sp)
    80005262:	6486                	ld	s1,64(sp)
    80005264:	6526                	ld	a0,72(sp)
    80005266:	65c6                	ld	a1,80(sp)
    80005268:	6666                	ld	a2,88(sp)
    8000526a:	7686                	ld	a3,96(sp)
    8000526c:	7726                	ld	a4,104(sp)
    8000526e:	77c6                	ld	a5,112(sp)
    80005270:	7866                	ld	a6,120(sp)
    80005272:	688a                	ld	a7,128(sp)
    80005274:	692a                	ld	s2,136(sp)
    80005276:	69ca                	ld	s3,144(sp)
    80005278:	6a6a                	ld	s4,152(sp)
    8000527a:	7a8a                	ld	s5,160(sp)
    8000527c:	7b2a                	ld	s6,168(sp)
    8000527e:	7bca                	ld	s7,176(sp)
    80005280:	7c6a                	ld	s8,184(sp)
    80005282:	6c8e                	ld	s9,192(sp)
    80005284:	6d2e                	ld	s10,200(sp)
    80005286:	6dce                	ld	s11,208(sp)
    80005288:	6e6e                	ld	t3,216(sp)
    8000528a:	7e8e                	ld	t4,224(sp)
    8000528c:	7f2e                	ld	t5,232(sp)
    8000528e:	7fce                	ld	t6,240(sp)
    80005290:	6111                	addi	sp,sp,256
    80005292:	10200073          	sret
    80005296:	00000013          	nop
    8000529a:	00000013          	nop
    8000529e:	0001                	nop

00000000800052a0 <timervec>:
    800052a0:	34051573          	csrrw	a0,mscratch,a0
    800052a4:	e10c                	sd	a1,0(a0)
    800052a6:	e510                	sd	a2,8(a0)
    800052a8:	e914                	sd	a3,16(a0)
    800052aa:	6d0c                	ld	a1,24(a0)
    800052ac:	7110                	ld	a2,32(a0)
    800052ae:	6194                	ld	a3,0(a1)
    800052b0:	96b2                	add	a3,a3,a2
    800052b2:	e194                	sd	a3,0(a1)
    800052b4:	4589                	li	a1,2
    800052b6:	14459073          	csrw	sip,a1
    800052ba:	6914                	ld	a3,16(a0)
    800052bc:	6510                	ld	a2,8(a0)
    800052be:	610c                	ld	a1,0(a0)
    800052c0:	34051573          	csrrw	a0,mscratch,a0
    800052c4:	30200073          	mret
	...

00000000800052ca <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    800052ca:	1141                	addi	sp,sp,-16
    800052cc:	e422                	sd	s0,8(sp)
    800052ce:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    800052d0:	0c0007b7          	lui	a5,0xc000
    800052d4:	4705                	li	a4,1
    800052d6:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    800052d8:	c3d8                	sw	a4,4(a5)
}
    800052da:	6422                	ld	s0,8(sp)
    800052dc:	0141                	addi	sp,sp,16
    800052de:	8082                	ret

00000000800052e0 <plicinithart>:

void
plicinithart(void)
{
    800052e0:	1141                	addi	sp,sp,-16
    800052e2:	e406                	sd	ra,8(sp)
    800052e4:	e022                	sd	s0,0(sp)
    800052e6:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800052e8:	ffffc097          	auipc	ra,0xffffc
    800052ec:	bc0080e7          	jalr	-1088(ra) # 80000ea8 <cpuid>
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    800052f0:	0085171b          	slliw	a4,a0,0x8
    800052f4:	0c0027b7          	lui	a5,0xc002
    800052f8:	97ba                	add	a5,a5,a4
    800052fa:	40200713          	li	a4,1026
    800052fe:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005302:	00d5151b          	slliw	a0,a0,0xd
    80005306:	0c2017b7          	lui	a5,0xc201
    8000530a:	953e                	add	a0,a0,a5
    8000530c:	00052023          	sw	zero,0(a0)
}
    80005310:	60a2                	ld	ra,8(sp)
    80005312:	6402                	ld	s0,0(sp)
    80005314:	0141                	addi	sp,sp,16
    80005316:	8082                	ret

0000000080005318 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80005318:	1141                	addi	sp,sp,-16
    8000531a:	e406                	sd	ra,8(sp)
    8000531c:	e022                	sd	s0,0(sp)
    8000531e:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005320:	ffffc097          	auipc	ra,0xffffc
    80005324:	b88080e7          	jalr	-1144(ra) # 80000ea8 <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80005328:	00d5151b          	slliw	a0,a0,0xd
    8000532c:	0c2017b7          	lui	a5,0xc201
    80005330:	97aa                	add	a5,a5,a0
  return irq;
}
    80005332:	43c8                	lw	a0,4(a5)
    80005334:	60a2                	ld	ra,8(sp)
    80005336:	6402                	ld	s0,0(sp)
    80005338:	0141                	addi	sp,sp,16
    8000533a:	8082                	ret

000000008000533c <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    8000533c:	1101                	addi	sp,sp,-32
    8000533e:	ec06                	sd	ra,24(sp)
    80005340:	e822                	sd	s0,16(sp)
    80005342:	e426                	sd	s1,8(sp)
    80005344:	1000                	addi	s0,sp,32
    80005346:	84aa                	mv	s1,a0
  int hart = cpuid();
    80005348:	ffffc097          	auipc	ra,0xffffc
    8000534c:	b60080e7          	jalr	-1184(ra) # 80000ea8 <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80005350:	00d5151b          	slliw	a0,a0,0xd
    80005354:	0c2017b7          	lui	a5,0xc201
    80005358:	97aa                	add	a5,a5,a0
    8000535a:	c3c4                	sw	s1,4(a5)
}
    8000535c:	60e2                	ld	ra,24(sp)
    8000535e:	6442                	ld	s0,16(sp)
    80005360:	64a2                	ld	s1,8(sp)
    80005362:	6105                	addi	sp,sp,32
    80005364:	8082                	ret

0000000080005366 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80005366:	1141                	addi	sp,sp,-16
    80005368:	e406                	sd	ra,8(sp)
    8000536a:	e022                	sd	s0,0(sp)
    8000536c:	0800                	addi	s0,sp,16
  if(i >= NUM)
    8000536e:	479d                	li	a5,7
    80005370:	04a7cc63          	blt	a5,a0,800053c8 <free_desc+0x62>
    panic("free_desc 1");
  if(disk.free[i])
    80005374:	00015797          	auipc	a5,0x15
    80005378:	a0c78793          	addi	a5,a5,-1524 # 80019d80 <disk>
    8000537c:	97aa                	add	a5,a5,a0
    8000537e:	0187c783          	lbu	a5,24(a5)
    80005382:	ebb9                	bnez	a5,800053d8 <free_desc+0x72>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80005384:	00451613          	slli	a2,a0,0x4
    80005388:	00015797          	auipc	a5,0x15
    8000538c:	9f878793          	addi	a5,a5,-1544 # 80019d80 <disk>
    80005390:	6394                	ld	a3,0(a5)
    80005392:	96b2                	add	a3,a3,a2
    80005394:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    80005398:	6398                	ld	a4,0(a5)
    8000539a:	9732                	add	a4,a4,a2
    8000539c:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    800053a0:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    800053a4:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    800053a8:	97aa                	add	a5,a5,a0
    800053aa:	4705                	li	a4,1
    800053ac:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    800053b0:	00015517          	auipc	a0,0x15
    800053b4:	9e850513          	addi	a0,a0,-1560 # 80019d98 <disk+0x18>
    800053b8:	ffffc097          	auipc	ra,0xffffc
    800053bc:	230080e7          	jalr	560(ra) # 800015e8 <wakeup>
}
    800053c0:	60a2                	ld	ra,8(sp)
    800053c2:	6402                	ld	s0,0(sp)
    800053c4:	0141                	addi	sp,sp,16
    800053c6:	8082                	ret
    panic("free_desc 1");
    800053c8:	00003517          	auipc	a0,0x3
    800053cc:	4c050513          	addi	a0,a0,1216 # 80008888 <str_syscalls+0x3e8>
    800053d0:	00001097          	auipc	ra,0x1
    800053d4:	a5c080e7          	jalr	-1444(ra) # 80005e2c <panic>
    panic("free_desc 2");
    800053d8:	00003517          	auipc	a0,0x3
    800053dc:	4c050513          	addi	a0,a0,1216 # 80008898 <str_syscalls+0x3f8>
    800053e0:	00001097          	auipc	ra,0x1
    800053e4:	a4c080e7          	jalr	-1460(ra) # 80005e2c <panic>

00000000800053e8 <virtio_disk_init>:
{
    800053e8:	1101                	addi	sp,sp,-32
    800053ea:	ec06                	sd	ra,24(sp)
    800053ec:	e822                	sd	s0,16(sp)
    800053ee:	e426                	sd	s1,8(sp)
    800053f0:	e04a                	sd	s2,0(sp)
    800053f2:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    800053f4:	00003597          	auipc	a1,0x3
    800053f8:	4b458593          	addi	a1,a1,1204 # 800088a8 <str_syscalls+0x408>
    800053fc:	00015517          	auipc	a0,0x15
    80005400:	aac50513          	addi	a0,a0,-1364 # 80019ea8 <disk+0x128>
    80005404:	00001097          	auipc	ra,0x1
    80005408:	f00080e7          	jalr	-256(ra) # 80006304 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    8000540c:	100017b7          	lui	a5,0x10001
    80005410:	4398                	lw	a4,0(a5)
    80005412:	2701                	sext.w	a4,a4
    80005414:	747277b7          	lui	a5,0x74727
    80005418:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    8000541c:	14f71a63          	bne	a4,a5,80005570 <virtio_disk_init+0x188>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80005420:	100017b7          	lui	a5,0x10001
    80005424:	43dc                	lw	a5,4(a5)
    80005426:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005428:	4709                	li	a4,2
    8000542a:	14e79363          	bne	a5,a4,80005570 <virtio_disk_init+0x188>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000542e:	100017b7          	lui	a5,0x10001
    80005432:	479c                	lw	a5,8(a5)
    80005434:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80005436:	12e79d63          	bne	a5,a4,80005570 <virtio_disk_init+0x188>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    8000543a:	100017b7          	lui	a5,0x10001
    8000543e:	47d8                	lw	a4,12(a5)
    80005440:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005442:	554d47b7          	lui	a5,0x554d4
    80005446:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    8000544a:	12f71363          	bne	a4,a5,80005570 <virtio_disk_init+0x188>
  *R(VIRTIO_MMIO_STATUS) = status;
    8000544e:	100017b7          	lui	a5,0x10001
    80005452:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    80005456:	4705                	li	a4,1
    80005458:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000545a:	470d                	li	a4,3
    8000545c:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    8000545e:	4b94                	lw	a3,16(a5)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80005460:	c7ffe737          	lui	a4,0xc7ffe
    80005464:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fdc65f>
    80005468:	8f75                	and	a4,a4,a3
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    8000546a:	2701                	sext.w	a4,a4
    8000546c:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000546e:	472d                	li	a4,11
    80005470:	dbb8                	sw	a4,112(a5)
  status = *R(VIRTIO_MMIO_STATUS);
    80005472:	0707a903          	lw	s2,112(a5)
    80005476:	2901                	sext.w	s2,s2
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    80005478:	00897793          	andi	a5,s2,8
    8000547c:	10078263          	beqz	a5,80005580 <virtio_disk_init+0x198>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80005480:	100017b7          	lui	a5,0x10001
    80005484:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    80005488:	43fc                	lw	a5,68(a5)
    8000548a:	2781                	sext.w	a5,a5
    8000548c:	10079263          	bnez	a5,80005590 <virtio_disk_init+0x1a8>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80005490:	100017b7          	lui	a5,0x10001
    80005494:	5bdc                	lw	a5,52(a5)
    80005496:	2781                	sext.w	a5,a5
  if(max == 0)
    80005498:	10078463          	beqz	a5,800055a0 <virtio_disk_init+0x1b8>
  if(max < NUM)
    8000549c:	471d                	li	a4,7
    8000549e:	10f77963          	bgeu	a4,a5,800055b0 <virtio_disk_init+0x1c8>
  disk.desc = kalloc();
    800054a2:	ffffb097          	auipc	ra,0xffffb
    800054a6:	c78080e7          	jalr	-904(ra) # 8000011a <kalloc>
    800054aa:	00015497          	auipc	s1,0x15
    800054ae:	8d648493          	addi	s1,s1,-1834 # 80019d80 <disk>
    800054b2:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    800054b4:	ffffb097          	auipc	ra,0xffffb
    800054b8:	c66080e7          	jalr	-922(ra) # 8000011a <kalloc>
    800054bc:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    800054be:	ffffb097          	auipc	ra,0xffffb
    800054c2:	c5c080e7          	jalr	-932(ra) # 8000011a <kalloc>
    800054c6:	e888                	sd	a0,16(s1)
  if(!disk.desc || !disk.avail || !disk.used)
    800054c8:	609c                	ld	a5,0(s1)
    800054ca:	cbfd                	beqz	a5,800055c0 <virtio_disk_init+0x1d8>
    800054cc:	6498                	ld	a4,8(s1)
    800054ce:	cb6d                	beqz	a4,800055c0 <virtio_disk_init+0x1d8>
    800054d0:	c965                	beqz	a0,800055c0 <virtio_disk_init+0x1d8>
  memset(disk.desc, 0, PGSIZE);
    800054d2:	6605                	lui	a2,0x1
    800054d4:	4581                	li	a1,0
    800054d6:	853e                	mv	a0,a5
    800054d8:	ffffb097          	auipc	ra,0xffffb
    800054dc:	cec080e7          	jalr	-788(ra) # 800001c4 <memset>
  memset(disk.avail, 0, PGSIZE);
    800054e0:	00015497          	auipc	s1,0x15
    800054e4:	8a048493          	addi	s1,s1,-1888 # 80019d80 <disk>
    800054e8:	6605                	lui	a2,0x1
    800054ea:	4581                	li	a1,0
    800054ec:	6488                	ld	a0,8(s1)
    800054ee:	ffffb097          	auipc	ra,0xffffb
    800054f2:	cd6080e7          	jalr	-810(ra) # 800001c4 <memset>
  memset(disk.used, 0, PGSIZE);
    800054f6:	6605                	lui	a2,0x1
    800054f8:	4581                	li	a1,0
    800054fa:	6888                	ld	a0,16(s1)
    800054fc:	ffffb097          	auipc	ra,0xffffb
    80005500:	cc8080e7          	jalr	-824(ra) # 800001c4 <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80005504:	100017b7          	lui	a5,0x10001
    80005508:	4721                	li	a4,8
    8000550a:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    8000550c:	4098                	lw	a4,0(s1)
    8000550e:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    80005512:	40d8                	lw	a4,4(s1)
    80005514:	08e7a223          	sw	a4,132(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    80005518:	6498                	ld	a4,8(s1)
    8000551a:	0007069b          	sext.w	a3,a4
    8000551e:	08d7a823          	sw	a3,144(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    80005522:	9701                	srai	a4,a4,0x20
    80005524:	08e7aa23          	sw	a4,148(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    80005528:	6898                	ld	a4,16(s1)
    8000552a:	0007069b          	sext.w	a3,a4
    8000552e:	0ad7a023          	sw	a3,160(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    80005532:	9701                	srai	a4,a4,0x20
    80005534:	0ae7a223          	sw	a4,164(a5)
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    80005538:	4705                	li	a4,1
    8000553a:	c3f8                	sw	a4,68(a5)
    disk.free[i] = 1;
    8000553c:	00e48c23          	sb	a4,24(s1)
    80005540:	00e48ca3          	sb	a4,25(s1)
    80005544:	00e48d23          	sb	a4,26(s1)
    80005548:	00e48da3          	sb	a4,27(s1)
    8000554c:	00e48e23          	sb	a4,28(s1)
    80005550:	00e48ea3          	sb	a4,29(s1)
    80005554:	00e48f23          	sb	a4,30(s1)
    80005558:	00e48fa3          	sb	a4,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    8000555c:	00496913          	ori	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    80005560:	0727a823          	sw	s2,112(a5)
}
    80005564:	60e2                	ld	ra,24(sp)
    80005566:	6442                	ld	s0,16(sp)
    80005568:	64a2                	ld	s1,8(sp)
    8000556a:	6902                	ld	s2,0(sp)
    8000556c:	6105                	addi	sp,sp,32
    8000556e:	8082                	ret
    panic("could not find virtio disk");
    80005570:	00003517          	auipc	a0,0x3
    80005574:	34850513          	addi	a0,a0,840 # 800088b8 <str_syscalls+0x418>
    80005578:	00001097          	auipc	ra,0x1
    8000557c:	8b4080e7          	jalr	-1868(ra) # 80005e2c <panic>
    panic("virtio disk FEATURES_OK unset");
    80005580:	00003517          	auipc	a0,0x3
    80005584:	35850513          	addi	a0,a0,856 # 800088d8 <str_syscalls+0x438>
    80005588:	00001097          	auipc	ra,0x1
    8000558c:	8a4080e7          	jalr	-1884(ra) # 80005e2c <panic>
    panic("virtio disk should not be ready");
    80005590:	00003517          	auipc	a0,0x3
    80005594:	36850513          	addi	a0,a0,872 # 800088f8 <str_syscalls+0x458>
    80005598:	00001097          	auipc	ra,0x1
    8000559c:	894080e7          	jalr	-1900(ra) # 80005e2c <panic>
    panic("virtio disk has no queue 0");
    800055a0:	00003517          	auipc	a0,0x3
    800055a4:	37850513          	addi	a0,a0,888 # 80008918 <str_syscalls+0x478>
    800055a8:	00001097          	auipc	ra,0x1
    800055ac:	884080e7          	jalr	-1916(ra) # 80005e2c <panic>
    panic("virtio disk max queue too short");
    800055b0:	00003517          	auipc	a0,0x3
    800055b4:	38850513          	addi	a0,a0,904 # 80008938 <str_syscalls+0x498>
    800055b8:	00001097          	auipc	ra,0x1
    800055bc:	874080e7          	jalr	-1932(ra) # 80005e2c <panic>
    panic("virtio disk kalloc");
    800055c0:	00003517          	auipc	a0,0x3
    800055c4:	39850513          	addi	a0,a0,920 # 80008958 <str_syscalls+0x4b8>
    800055c8:	00001097          	auipc	ra,0x1
    800055cc:	864080e7          	jalr	-1948(ra) # 80005e2c <panic>

00000000800055d0 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    800055d0:	7159                	addi	sp,sp,-112
    800055d2:	f486                	sd	ra,104(sp)
    800055d4:	f0a2                	sd	s0,96(sp)
    800055d6:	eca6                	sd	s1,88(sp)
    800055d8:	e8ca                	sd	s2,80(sp)
    800055da:	e4ce                	sd	s3,72(sp)
    800055dc:	e0d2                	sd	s4,64(sp)
    800055de:	fc56                	sd	s5,56(sp)
    800055e0:	f85a                	sd	s6,48(sp)
    800055e2:	f45e                	sd	s7,40(sp)
    800055e4:	f062                	sd	s8,32(sp)
    800055e6:	ec66                	sd	s9,24(sp)
    800055e8:	e86a                	sd	s10,16(sp)
    800055ea:	1880                	addi	s0,sp,112
    800055ec:	892a                	mv	s2,a0
    800055ee:	8c2e                	mv	s8,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    800055f0:	00c52c83          	lw	s9,12(a0)
    800055f4:	001c9c9b          	slliw	s9,s9,0x1
    800055f8:	1c82                	slli	s9,s9,0x20
    800055fa:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    800055fe:	00015517          	auipc	a0,0x15
    80005602:	8aa50513          	addi	a0,a0,-1878 # 80019ea8 <disk+0x128>
    80005606:	00001097          	auipc	ra,0x1
    8000560a:	d8e080e7          	jalr	-626(ra) # 80006394 <acquire>
    if(disk.free[i]){
    8000560e:	00014997          	auipc	s3,0x14
    80005612:	77298993          	addi	s3,s3,1906 # 80019d80 <disk>
  for(int i = 0; i < NUM; i++){
    80005616:	4d05                	li	s10,1
    80005618:	4b21                	li	s6,8
  for(int i = 0; i < 3; i++){
    8000561a:	4a8d                	li	s5,3
  for(int i = 0; i < NUM; i++){
    8000561c:	8a6a                	mv	s4,s10
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    8000561e:	00015b97          	auipc	s7,0x15
    80005622:	88ab8b93          	addi	s7,s7,-1910 # 80019ea8 <disk+0x128>
    80005626:	a049                	j	800056a8 <virtio_disk_rw+0xd8>
      disk.free[i] = 0;
    80005628:	00f986b3          	add	a3,s3,a5
    8000562c:	00068c23          	sb	zero,24(a3)
    idx[i] = alloc_desc();
    80005630:	c21c                	sw	a5,0(a2)
    if(idx[i] < 0){
    80005632:	0207c963          	bltz	a5,80005664 <virtio_disk_rw+0x94>
  for(int i = 0; i < 3; i++){
    80005636:	2485                	addiw	s1,s1,1
    80005638:	0711                	addi	a4,a4,4
    8000563a:	07548b63          	beq	s1,s5,800056b0 <virtio_disk_rw+0xe0>
    idx[i] = alloc_desc();
    8000563e:	863a                	mv	a2,a4
    if(disk.free[i]){
    80005640:	0189c783          	lbu	a5,24(s3)
    80005644:	1c079e63          	bnez	a5,80005820 <virtio_disk_rw+0x250>
    80005648:	00014697          	auipc	a3,0x14
    8000564c:	73868693          	addi	a3,a3,1848 # 80019d80 <disk>
  for(int i = 0; i < NUM; i++){
    80005650:	87d2                	mv	a5,s4
    if(disk.free[i]){
    80005652:	0196c583          	lbu	a1,25(a3)
    80005656:	f9e9                	bnez	a1,80005628 <virtio_disk_rw+0x58>
  for(int i = 0; i < NUM; i++){
    80005658:	2785                	addiw	a5,a5,1
    8000565a:	0685                	addi	a3,a3,1
    8000565c:	ff679be3          	bne	a5,s6,80005652 <virtio_disk_rw+0x82>
    idx[i] = alloc_desc();
    80005660:	57fd                	li	a5,-1
    80005662:	c21c                	sw	a5,0(a2)
      for(int j = 0; j < i; j++)
    80005664:	02905963          	blez	s1,80005696 <virtio_disk_rw+0xc6>
        free_desc(idx[j]);
    80005668:	f9042503          	lw	a0,-112(s0)
    8000566c:	00000097          	auipc	ra,0x0
    80005670:	cfa080e7          	jalr	-774(ra) # 80005366 <free_desc>
      for(int j = 0; j < i; j++)
    80005674:	029d5163          	bge	s10,s1,80005696 <virtio_disk_rw+0xc6>
        free_desc(idx[j]);
    80005678:	f9442503          	lw	a0,-108(s0)
    8000567c:	00000097          	auipc	ra,0x0
    80005680:	cea080e7          	jalr	-790(ra) # 80005366 <free_desc>
      for(int j = 0; j < i; j++)
    80005684:	4789                	li	a5,2
    80005686:	0097d863          	bge	a5,s1,80005696 <virtio_disk_rw+0xc6>
        free_desc(idx[j]);
    8000568a:	f9842503          	lw	a0,-104(s0)
    8000568e:	00000097          	auipc	ra,0x0
    80005692:	cd8080e7          	jalr	-808(ra) # 80005366 <free_desc>
    sleep(&disk.free[0], &disk.vdisk_lock);
    80005696:	85de                	mv	a1,s7
    80005698:	00014517          	auipc	a0,0x14
    8000569c:	70050513          	addi	a0,a0,1792 # 80019d98 <disk+0x18>
    800056a0:	ffffc097          	auipc	ra,0xffffc
    800056a4:	ee4080e7          	jalr	-284(ra) # 80001584 <sleep>
  for(int i = 0; i < 3; i++){
    800056a8:	f9040713          	addi	a4,s0,-112
    800056ac:	4481                	li	s1,0
    800056ae:	bf41                	j	8000563e <virtio_disk_rw+0x6e>
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800056b0:	f9042583          	lw	a1,-112(s0)
    800056b4:	00a58793          	addi	a5,a1,10
    800056b8:	0792                	slli	a5,a5,0x4

  if(write)
    800056ba:	00014617          	auipc	a2,0x14
    800056be:	6c660613          	addi	a2,a2,1734 # 80019d80 <disk>
    800056c2:	00f60733          	add	a4,a2,a5
    800056c6:	018036b3          	snez	a3,s8
    800056ca:	c714                	sw	a3,8(a4)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    800056cc:	00072623          	sw	zero,12(a4)
  buf0->sector = sector;
    800056d0:	01973823          	sd	s9,16(a4)

  disk.desc[idx[0]].addr = (uint64) buf0;
    800056d4:	f6078693          	addi	a3,a5,-160
    800056d8:	6218                	ld	a4,0(a2)
    800056da:	9736                	add	a4,a4,a3
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800056dc:	00878513          	addi	a0,a5,8
    800056e0:	9532                	add	a0,a0,a2
  disk.desc[idx[0]].addr = (uint64) buf0;
    800056e2:	e308                	sd	a0,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    800056e4:	6208                	ld	a0,0(a2)
    800056e6:	96aa                	add	a3,a3,a0
    800056e8:	4741                	li	a4,16
    800056ea:	c698                	sw	a4,8(a3)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    800056ec:	4705                	li	a4,1
    800056ee:	00e69623          	sh	a4,12(a3)
  disk.desc[idx[0]].next = idx[1];
    800056f2:	f9442703          	lw	a4,-108(s0)
    800056f6:	00e69723          	sh	a4,14(a3)

  disk.desc[idx[1]].addr = (uint64) b->data;
    800056fa:	0712                	slli	a4,a4,0x4
    800056fc:	953a                	add	a0,a0,a4
    800056fe:	05890693          	addi	a3,s2,88
    80005702:	e114                	sd	a3,0(a0)
  disk.desc[idx[1]].len = BSIZE;
    80005704:	6208                	ld	a0,0(a2)
    80005706:	972a                	add	a4,a4,a0
    80005708:	40000693          	li	a3,1024
    8000570c:	c714                	sw	a3,8(a4)
  if(write)
    disk.desc[idx[1]].flags = 0; // device reads b->data
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    8000570e:	001c3c13          	seqz	s8,s8
    80005712:	0c06                	slli	s8,s8,0x1
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80005714:	001c6c13          	ori	s8,s8,1
    80005718:	01871623          	sh	s8,12(a4)
  disk.desc[idx[1]].next = idx[2];
    8000571c:	f9842603          	lw	a2,-104(s0)
    80005720:	00c71723          	sh	a2,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80005724:	00014697          	auipc	a3,0x14
    80005728:	65c68693          	addi	a3,a3,1628 # 80019d80 <disk>
    8000572c:	00258713          	addi	a4,a1,2
    80005730:	0712                	slli	a4,a4,0x4
    80005732:	9736                	add	a4,a4,a3
    80005734:	587d                	li	a6,-1
    80005736:	01070823          	sb	a6,16(a4)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    8000573a:	0612                	slli	a2,a2,0x4
    8000573c:	9532                	add	a0,a0,a2
    8000573e:	f9078793          	addi	a5,a5,-112
    80005742:	97b6                	add	a5,a5,a3
    80005744:	e11c                	sd	a5,0(a0)
  disk.desc[idx[2]].len = 1;
    80005746:	629c                	ld	a5,0(a3)
    80005748:	97b2                	add	a5,a5,a2
    8000574a:	4605                	li	a2,1
    8000574c:	c790                	sw	a2,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    8000574e:	4509                	li	a0,2
    80005750:	00a79623          	sh	a0,12(a5)
  disk.desc[idx[2]].next = 0;
    80005754:	00079723          	sh	zero,14(a5)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80005758:	00c92223          	sw	a2,4(s2)
  disk.info[idx[0]].b = b;
    8000575c:	01273423          	sd	s2,8(a4)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80005760:	6698                	ld	a4,8(a3)
    80005762:	00275783          	lhu	a5,2(a4)
    80005766:	8b9d                	andi	a5,a5,7
    80005768:	0786                	slli	a5,a5,0x1
    8000576a:	97ba                	add	a5,a5,a4
    8000576c:	00b79223          	sh	a1,4(a5)

  __sync_synchronize();
    80005770:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80005774:	6698                	ld	a4,8(a3)
    80005776:	00275783          	lhu	a5,2(a4)
    8000577a:	2785                	addiw	a5,a5,1
    8000577c:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80005780:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80005784:	100017b7          	lui	a5,0x10001
    80005788:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    8000578c:	00492783          	lw	a5,4(s2)
    80005790:	02c79163          	bne	a5,a2,800057b2 <virtio_disk_rw+0x1e2>
    sleep(b, &disk.vdisk_lock);
    80005794:	00014997          	auipc	s3,0x14
    80005798:	71498993          	addi	s3,s3,1812 # 80019ea8 <disk+0x128>
  while(b->disk == 1) {
    8000579c:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    8000579e:	85ce                	mv	a1,s3
    800057a0:	854a                	mv	a0,s2
    800057a2:	ffffc097          	auipc	ra,0xffffc
    800057a6:	de2080e7          	jalr	-542(ra) # 80001584 <sleep>
  while(b->disk == 1) {
    800057aa:	00492783          	lw	a5,4(s2)
    800057ae:	fe9788e3          	beq	a5,s1,8000579e <virtio_disk_rw+0x1ce>
  }

  disk.info[idx[0]].b = 0;
    800057b2:	f9042503          	lw	a0,-112(s0)
    800057b6:	00250793          	addi	a5,a0,2
    800057ba:	00479713          	slli	a4,a5,0x4
    800057be:	00014797          	auipc	a5,0x14
    800057c2:	5c278793          	addi	a5,a5,1474 # 80019d80 <disk>
    800057c6:	97ba                	add	a5,a5,a4
    800057c8:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    800057cc:	00014997          	auipc	s3,0x14
    800057d0:	5b498993          	addi	s3,s3,1460 # 80019d80 <disk>
    800057d4:	00451713          	slli	a4,a0,0x4
    800057d8:	0009b783          	ld	a5,0(s3)
    800057dc:	97ba                	add	a5,a5,a4
    800057de:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    800057e2:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    800057e6:	00000097          	auipc	ra,0x0
    800057ea:	b80080e7          	jalr	-1152(ra) # 80005366 <free_desc>
      i = nxt;
    800057ee:	854a                	mv	a0,s2
    if(flag & VRING_DESC_F_NEXT)
    800057f0:	8885                	andi	s1,s1,1
    800057f2:	f0ed                	bnez	s1,800057d4 <virtio_disk_rw+0x204>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    800057f4:	00014517          	auipc	a0,0x14
    800057f8:	6b450513          	addi	a0,a0,1716 # 80019ea8 <disk+0x128>
    800057fc:	00001097          	auipc	ra,0x1
    80005800:	c4c080e7          	jalr	-948(ra) # 80006448 <release>
}
    80005804:	70a6                	ld	ra,104(sp)
    80005806:	7406                	ld	s0,96(sp)
    80005808:	64e6                	ld	s1,88(sp)
    8000580a:	6946                	ld	s2,80(sp)
    8000580c:	69a6                	ld	s3,72(sp)
    8000580e:	6a06                	ld	s4,64(sp)
    80005810:	7ae2                	ld	s5,56(sp)
    80005812:	7b42                	ld	s6,48(sp)
    80005814:	7ba2                	ld	s7,40(sp)
    80005816:	7c02                	ld	s8,32(sp)
    80005818:	6ce2                	ld	s9,24(sp)
    8000581a:	6d42                	ld	s10,16(sp)
    8000581c:	6165                	addi	sp,sp,112
    8000581e:	8082                	ret
      disk.free[i] = 0;
    80005820:	00098c23          	sb	zero,24(s3)
    idx[i] = alloc_desc();
    80005824:	00072023          	sw	zero,0(a4)
    if(idx[i] < 0){
    80005828:	b539                	j	80005636 <virtio_disk_rw+0x66>

000000008000582a <virtio_disk_intr>:

void
virtio_disk_intr()
{
    8000582a:	1101                	addi	sp,sp,-32
    8000582c:	ec06                	sd	ra,24(sp)
    8000582e:	e822                	sd	s0,16(sp)
    80005830:	e426                	sd	s1,8(sp)
    80005832:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80005834:	00014497          	auipc	s1,0x14
    80005838:	54c48493          	addi	s1,s1,1356 # 80019d80 <disk>
    8000583c:	00014517          	auipc	a0,0x14
    80005840:	66c50513          	addi	a0,a0,1644 # 80019ea8 <disk+0x128>
    80005844:	00001097          	auipc	ra,0x1
    80005848:	b50080e7          	jalr	-1200(ra) # 80006394 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    8000584c:	10001737          	lui	a4,0x10001
    80005850:	533c                	lw	a5,96(a4)
    80005852:	8b8d                	andi	a5,a5,3
    80005854:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    80005856:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    8000585a:	689c                	ld	a5,16(s1)
    8000585c:	0204d703          	lhu	a4,32(s1)
    80005860:	0027d783          	lhu	a5,2(a5)
    80005864:	04f70863          	beq	a4,a5,800058b4 <virtio_disk_intr+0x8a>
    __sync_synchronize();
    80005868:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    8000586c:	6898                	ld	a4,16(s1)
    8000586e:	0204d783          	lhu	a5,32(s1)
    80005872:	8b9d                	andi	a5,a5,7
    80005874:	078e                	slli	a5,a5,0x3
    80005876:	97ba                	add	a5,a5,a4
    80005878:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    8000587a:	00278713          	addi	a4,a5,2
    8000587e:	0712                	slli	a4,a4,0x4
    80005880:	9726                	add	a4,a4,s1
    80005882:	01074703          	lbu	a4,16(a4) # 10001010 <_entry-0x6fffeff0>
    80005886:	e721                	bnez	a4,800058ce <virtio_disk_intr+0xa4>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80005888:	0789                	addi	a5,a5,2
    8000588a:	0792                	slli	a5,a5,0x4
    8000588c:	97a6                	add	a5,a5,s1
    8000588e:	6788                	ld	a0,8(a5)
    b->disk = 0;   // disk is done with buf
    80005890:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80005894:	ffffc097          	auipc	ra,0xffffc
    80005898:	d54080e7          	jalr	-684(ra) # 800015e8 <wakeup>

    disk.used_idx += 1;
    8000589c:	0204d783          	lhu	a5,32(s1)
    800058a0:	2785                	addiw	a5,a5,1
    800058a2:	17c2                	slli	a5,a5,0x30
    800058a4:	93c1                	srli	a5,a5,0x30
    800058a6:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    800058aa:	6898                	ld	a4,16(s1)
    800058ac:	00275703          	lhu	a4,2(a4)
    800058b0:	faf71ce3          	bne	a4,a5,80005868 <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    800058b4:	00014517          	auipc	a0,0x14
    800058b8:	5f450513          	addi	a0,a0,1524 # 80019ea8 <disk+0x128>
    800058bc:	00001097          	auipc	ra,0x1
    800058c0:	b8c080e7          	jalr	-1140(ra) # 80006448 <release>
}
    800058c4:	60e2                	ld	ra,24(sp)
    800058c6:	6442                	ld	s0,16(sp)
    800058c8:	64a2                	ld	s1,8(sp)
    800058ca:	6105                	addi	sp,sp,32
    800058cc:	8082                	ret
      panic("virtio_disk_intr status");
    800058ce:	00003517          	auipc	a0,0x3
    800058d2:	0a250513          	addi	a0,a0,162 # 80008970 <str_syscalls+0x4d0>
    800058d6:	00000097          	auipc	ra,0x0
    800058da:	556080e7          	jalr	1366(ra) # 80005e2c <panic>

00000000800058de <timerinit>:
// at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    800058de:	1141                	addi	sp,sp,-16
    800058e0:	e422                	sd	s0,8(sp)
    800058e2:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800058e4:	f1402773          	csrr	a4,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    800058e8:	2701                	sext.w	a4,a4

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    800058ea:	0037161b          	slliw	a2,a4,0x3
    800058ee:	020047b7          	lui	a5,0x2004
    800058f2:	963e                	add	a2,a2,a5
    800058f4:	0200c7b7          	lui	a5,0x200c
    800058f8:	ff87b783          	ld	a5,-8(a5) # 200bff8 <_entry-0x7dff4008>
    800058fc:	000f46b7          	lui	a3,0xf4
    80005900:	24068693          	addi	a3,a3,576 # f4240 <_entry-0x7ff0bdc0>
    80005904:	97b6                	add	a5,a5,a3
    80005906:	e21c                	sd	a5,0(a2)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    80005908:	00271793          	slli	a5,a4,0x2
    8000590c:	97ba                	add	a5,a5,a4
    8000590e:	00379713          	slli	a4,a5,0x3
    80005912:	00014797          	auipc	a5,0x14
    80005916:	5ae78793          	addi	a5,a5,1454 # 80019ec0 <timer_scratch>
    8000591a:	97ba                	add	a5,a5,a4
  scratch[3] = CLINT_MTIMECMP(id);
    8000591c:	ef90                	sd	a2,24(a5)
  scratch[4] = interval;
    8000591e:	f394                	sd	a3,32(a5)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80005920:	34079073          	csrw	mscratch,a5
  asm volatile("csrw mtvec, %0" : : "r" (x));
    80005924:	00000797          	auipc	a5,0x0
    80005928:	97c78793          	addi	a5,a5,-1668 # 800052a0 <timervec>
    8000592c:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005930:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80005934:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005938:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    8000593c:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80005940:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80005944:	30479073          	csrw	mie,a5
}
    80005948:	6422                	ld	s0,8(sp)
    8000594a:	0141                	addi	sp,sp,16
    8000594c:	8082                	ret

000000008000594e <start>:
{
    8000594e:	1141                	addi	sp,sp,-16
    80005950:	e406                	sd	ra,8(sp)
    80005952:	e022                	sd	s0,0(sp)
    80005954:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005956:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    8000595a:	7779                	lui	a4,0xffffe
    8000595c:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffdc6ff>
    80005960:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    80005962:	6705                	lui	a4,0x1
    80005964:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005968:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    8000596a:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    8000596e:	ffffb797          	auipc	a5,0xffffb
    80005972:	a2678793          	addi	a5,a5,-1498 # 80000394 <main>
    80005976:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    8000597a:	4781                	li	a5,0
    8000597c:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80005980:	67c1                	lui	a5,0x10
    80005982:	17fd                	addi	a5,a5,-1
    80005984:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80005988:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    8000598c:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80005990:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80005994:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80005998:	57fd                	li	a5,-1
    8000599a:	83a9                	srli	a5,a5,0xa
    8000599c:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    800059a0:	47bd                	li	a5,15
    800059a2:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    800059a6:	00000097          	auipc	ra,0x0
    800059aa:	f38080e7          	jalr	-200(ra) # 800058de <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800059ae:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    800059b2:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    800059b4:	823e                	mv	tp,a5
  asm volatile("mret");
    800059b6:	30200073          	mret
}
    800059ba:	60a2                	ld	ra,8(sp)
    800059bc:	6402                	ld	s0,0(sp)
    800059be:	0141                	addi	sp,sp,16
    800059c0:	8082                	ret

00000000800059c2 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    800059c2:	715d                	addi	sp,sp,-80
    800059c4:	e486                	sd	ra,72(sp)
    800059c6:	e0a2                	sd	s0,64(sp)
    800059c8:	fc26                	sd	s1,56(sp)
    800059ca:	f84a                	sd	s2,48(sp)
    800059cc:	f44e                	sd	s3,40(sp)
    800059ce:	f052                	sd	s4,32(sp)
    800059d0:	ec56                	sd	s5,24(sp)
    800059d2:	0880                	addi	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    800059d4:	04c05663          	blez	a2,80005a20 <consolewrite+0x5e>
    800059d8:	8a2a                	mv	s4,a0
    800059da:	892e                	mv	s2,a1
    800059dc:	89b2                	mv	s3,a2
    800059de:	4481                	li	s1,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    800059e0:	5afd                	li	s5,-1
    800059e2:	4685                	li	a3,1
    800059e4:	864a                	mv	a2,s2
    800059e6:	85d2                	mv	a1,s4
    800059e8:	fbf40513          	addi	a0,s0,-65
    800059ec:	ffffc097          	auipc	ra,0xffffc
    800059f0:	ff8080e7          	jalr	-8(ra) # 800019e4 <either_copyin>
    800059f4:	01550c63          	beq	a0,s5,80005a0c <consolewrite+0x4a>
      break;
    uartputc(c);
    800059f8:	fbf44503          	lbu	a0,-65(s0)
    800059fc:	00000097          	auipc	ra,0x0
    80005a00:	7d6080e7          	jalr	2006(ra) # 800061d2 <uartputc>
  for(i = 0; i < n; i++){
    80005a04:	2485                	addiw	s1,s1,1
    80005a06:	0905                	addi	s2,s2,1
    80005a08:	fc999de3          	bne	s3,s1,800059e2 <consolewrite+0x20>
  }

  return i;
}
    80005a0c:	8526                	mv	a0,s1
    80005a0e:	60a6                	ld	ra,72(sp)
    80005a10:	6406                	ld	s0,64(sp)
    80005a12:	74e2                	ld	s1,56(sp)
    80005a14:	7942                	ld	s2,48(sp)
    80005a16:	79a2                	ld	s3,40(sp)
    80005a18:	7a02                	ld	s4,32(sp)
    80005a1a:	6ae2                	ld	s5,24(sp)
    80005a1c:	6161                	addi	sp,sp,80
    80005a1e:	8082                	ret
  for(i = 0; i < n; i++){
    80005a20:	4481                	li	s1,0
    80005a22:	b7ed                	j	80005a0c <consolewrite+0x4a>

0000000080005a24 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80005a24:	7119                	addi	sp,sp,-128
    80005a26:	fc86                	sd	ra,120(sp)
    80005a28:	f8a2                	sd	s0,112(sp)
    80005a2a:	f4a6                	sd	s1,104(sp)
    80005a2c:	f0ca                	sd	s2,96(sp)
    80005a2e:	ecce                	sd	s3,88(sp)
    80005a30:	e8d2                	sd	s4,80(sp)
    80005a32:	e4d6                	sd	s5,72(sp)
    80005a34:	e0da                	sd	s6,64(sp)
    80005a36:	fc5e                	sd	s7,56(sp)
    80005a38:	f862                	sd	s8,48(sp)
    80005a3a:	f466                	sd	s9,40(sp)
    80005a3c:	f06a                	sd	s10,32(sp)
    80005a3e:	ec6e                	sd	s11,24(sp)
    80005a40:	0100                	addi	s0,sp,128
    80005a42:	8caa                	mv	s9,a0
    80005a44:	8aae                	mv	s5,a1
    80005a46:	8a32                	mv	s4,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80005a48:	00060b1b          	sext.w	s6,a2
  acquire(&cons.lock);
    80005a4c:	0001c517          	auipc	a0,0x1c
    80005a50:	5b450513          	addi	a0,a0,1460 # 80022000 <cons>
    80005a54:	00001097          	auipc	ra,0x1
    80005a58:	940080e7          	jalr	-1728(ra) # 80006394 <acquire>
  while(n > 0){
    80005a5c:	09405963          	blez	s4,80005aee <consoleread+0xca>
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80005a60:	0001c497          	auipc	s1,0x1c
    80005a64:	5a048493          	addi	s1,s1,1440 # 80022000 <cons>
      if(killed(myproc())){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80005a68:	89a6                	mv	s3,s1
    80005a6a:	0001c917          	auipc	s2,0x1c
    80005a6e:	62e90913          	addi	s2,s2,1582 # 80022098 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];

    if(c == C('D')){  // end-of-file
    80005a72:	4c11                	li	s8,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005a74:	5d7d                	li	s10,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    80005a76:	4da9                	li	s11,10
    while(cons.r == cons.w){
    80005a78:	0984a783          	lw	a5,152(s1)
    80005a7c:	09c4a703          	lw	a4,156(s1)
    80005a80:	02f71763          	bne	a4,a5,80005aae <consoleread+0x8a>
      if(killed(myproc())){
    80005a84:	ffffb097          	auipc	ra,0xffffb
    80005a88:	450080e7          	jalr	1104(ra) # 80000ed4 <myproc>
    80005a8c:	ffffc097          	auipc	ra,0xffffc
    80005a90:	da2080e7          	jalr	-606(ra) # 8000182e <killed>
    80005a94:	e925                	bnez	a0,80005b04 <consoleread+0xe0>
      sleep(&cons.r, &cons.lock);
    80005a96:	85ce                	mv	a1,s3
    80005a98:	854a                	mv	a0,s2
    80005a9a:	ffffc097          	auipc	ra,0xffffc
    80005a9e:	aea080e7          	jalr	-1302(ra) # 80001584 <sleep>
    while(cons.r == cons.w){
    80005aa2:	0984a783          	lw	a5,152(s1)
    80005aa6:	09c4a703          	lw	a4,156(s1)
    80005aaa:	fcf70de3          	beq	a4,a5,80005a84 <consoleread+0x60>
    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    80005aae:	0017871b          	addiw	a4,a5,1
    80005ab2:	08e4ac23          	sw	a4,152(s1)
    80005ab6:	07f7f713          	andi	a4,a5,127
    80005aba:	9726                	add	a4,a4,s1
    80005abc:	01874703          	lbu	a4,24(a4)
    80005ac0:	00070b9b          	sext.w	s7,a4
    if(c == C('D')){  // end-of-file
    80005ac4:	078b8863          	beq	s7,s8,80005b34 <consoleread+0x110>
    cbuf = c;
    80005ac8:	f8e407a3          	sb	a4,-113(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005acc:	4685                	li	a3,1
    80005ace:	f8f40613          	addi	a2,s0,-113
    80005ad2:	85d6                	mv	a1,s5
    80005ad4:	8566                	mv	a0,s9
    80005ad6:	ffffc097          	auipc	ra,0xffffc
    80005ada:	eb8080e7          	jalr	-328(ra) # 8000198e <either_copyout>
    80005ade:	01a50863          	beq	a0,s10,80005aee <consoleread+0xca>
    dst++;
    80005ae2:	0a85                	addi	s5,s5,1
    --n;
    80005ae4:	3a7d                	addiw	s4,s4,-1
    if(c == '\n'){
    80005ae6:	01bb8463          	beq	s7,s11,80005aee <consoleread+0xca>
  while(n > 0){
    80005aea:	f80a17e3          	bnez	s4,80005a78 <consoleread+0x54>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80005aee:	0001c517          	auipc	a0,0x1c
    80005af2:	51250513          	addi	a0,a0,1298 # 80022000 <cons>
    80005af6:	00001097          	auipc	ra,0x1
    80005afa:	952080e7          	jalr	-1710(ra) # 80006448 <release>

  return target - n;
    80005afe:	414b053b          	subw	a0,s6,s4
    80005b02:	a811                	j	80005b16 <consoleread+0xf2>
        release(&cons.lock);
    80005b04:	0001c517          	auipc	a0,0x1c
    80005b08:	4fc50513          	addi	a0,a0,1276 # 80022000 <cons>
    80005b0c:	00001097          	auipc	ra,0x1
    80005b10:	93c080e7          	jalr	-1732(ra) # 80006448 <release>
        return -1;
    80005b14:	557d                	li	a0,-1
}
    80005b16:	70e6                	ld	ra,120(sp)
    80005b18:	7446                	ld	s0,112(sp)
    80005b1a:	74a6                	ld	s1,104(sp)
    80005b1c:	7906                	ld	s2,96(sp)
    80005b1e:	69e6                	ld	s3,88(sp)
    80005b20:	6a46                	ld	s4,80(sp)
    80005b22:	6aa6                	ld	s5,72(sp)
    80005b24:	6b06                	ld	s6,64(sp)
    80005b26:	7be2                	ld	s7,56(sp)
    80005b28:	7c42                	ld	s8,48(sp)
    80005b2a:	7ca2                	ld	s9,40(sp)
    80005b2c:	7d02                	ld	s10,32(sp)
    80005b2e:	6de2                	ld	s11,24(sp)
    80005b30:	6109                	addi	sp,sp,128
    80005b32:	8082                	ret
      if(n < target){
    80005b34:	000a071b          	sext.w	a4,s4
    80005b38:	fb677be3          	bgeu	a4,s6,80005aee <consoleread+0xca>
        cons.r--;
    80005b3c:	0001c717          	auipc	a4,0x1c
    80005b40:	54f72e23          	sw	a5,1372(a4) # 80022098 <cons+0x98>
    80005b44:	b76d                	j	80005aee <consoleread+0xca>

0000000080005b46 <consputc>:
{
    80005b46:	1141                	addi	sp,sp,-16
    80005b48:	e406                	sd	ra,8(sp)
    80005b4a:	e022                	sd	s0,0(sp)
    80005b4c:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80005b4e:	10000793          	li	a5,256
    80005b52:	00f50a63          	beq	a0,a5,80005b66 <consputc+0x20>
    uartputc_sync(c);
    80005b56:	00000097          	auipc	ra,0x0
    80005b5a:	588080e7          	jalr	1416(ra) # 800060de <uartputc_sync>
}
    80005b5e:	60a2                	ld	ra,8(sp)
    80005b60:	6402                	ld	s0,0(sp)
    80005b62:	0141                	addi	sp,sp,16
    80005b64:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80005b66:	4521                	li	a0,8
    80005b68:	00000097          	auipc	ra,0x0
    80005b6c:	576080e7          	jalr	1398(ra) # 800060de <uartputc_sync>
    80005b70:	02000513          	li	a0,32
    80005b74:	00000097          	auipc	ra,0x0
    80005b78:	56a080e7          	jalr	1386(ra) # 800060de <uartputc_sync>
    80005b7c:	4521                	li	a0,8
    80005b7e:	00000097          	auipc	ra,0x0
    80005b82:	560080e7          	jalr	1376(ra) # 800060de <uartputc_sync>
    80005b86:	bfe1                	j	80005b5e <consputc+0x18>

0000000080005b88 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80005b88:	1101                	addi	sp,sp,-32
    80005b8a:	ec06                	sd	ra,24(sp)
    80005b8c:	e822                	sd	s0,16(sp)
    80005b8e:	e426                	sd	s1,8(sp)
    80005b90:	e04a                	sd	s2,0(sp)
    80005b92:	1000                	addi	s0,sp,32
    80005b94:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80005b96:	0001c517          	auipc	a0,0x1c
    80005b9a:	46a50513          	addi	a0,a0,1130 # 80022000 <cons>
    80005b9e:	00000097          	auipc	ra,0x0
    80005ba2:	7f6080e7          	jalr	2038(ra) # 80006394 <acquire>

  switch(c){
    80005ba6:	47c1                	li	a5,16
    80005ba8:	12f48463          	beq	s1,a5,80005cd0 <consoleintr+0x148>
    80005bac:	0297df63          	bge	a5,s1,80005bea <consoleintr+0x62>
    80005bb0:	47d5                	li	a5,21
    80005bb2:	0af48863          	beq	s1,a5,80005c62 <consoleintr+0xda>
    80005bb6:	07f00793          	li	a5,127
    80005bba:	02f49b63          	bne	s1,a5,80005bf0 <consoleintr+0x68>
      consputc(BACKSPACE);
    }
    break;
  case C('H'): // Backspace
  case '\x7f': // Delete key
    if(cons.e != cons.w){
    80005bbe:	0001c717          	auipc	a4,0x1c
    80005bc2:	44270713          	addi	a4,a4,1090 # 80022000 <cons>
    80005bc6:	0a072783          	lw	a5,160(a4)
    80005bca:	09c72703          	lw	a4,156(a4)
    80005bce:	10f70563          	beq	a4,a5,80005cd8 <consoleintr+0x150>
      cons.e--;
    80005bd2:	37fd                	addiw	a5,a5,-1
    80005bd4:	0001c717          	auipc	a4,0x1c
    80005bd8:	4cf72623          	sw	a5,1228(a4) # 800220a0 <cons+0xa0>
      consputc(BACKSPACE);
    80005bdc:	10000513          	li	a0,256
    80005be0:	00000097          	auipc	ra,0x0
    80005be4:	f66080e7          	jalr	-154(ra) # 80005b46 <consputc>
    80005be8:	a8c5                	j	80005cd8 <consoleintr+0x150>
  switch(c){
    80005bea:	47a1                	li	a5,8
    80005bec:	fcf489e3          	beq	s1,a5,80005bbe <consoleintr+0x36>
    }
    break;
  default:
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80005bf0:	c4e5                	beqz	s1,80005cd8 <consoleintr+0x150>
    80005bf2:	0001c717          	auipc	a4,0x1c
    80005bf6:	40e70713          	addi	a4,a4,1038 # 80022000 <cons>
    80005bfa:	0a072783          	lw	a5,160(a4)
    80005bfe:	09872703          	lw	a4,152(a4)
    80005c02:	9f99                	subw	a5,a5,a4
    80005c04:	07f00713          	li	a4,127
    80005c08:	0cf76863          	bltu	a4,a5,80005cd8 <consoleintr+0x150>
      c = (c == '\r') ? '\n' : c;
    80005c0c:	47b5                	li	a5,13
    80005c0e:	0ef48363          	beq	s1,a5,80005cf4 <consoleintr+0x16c>

      // echo back to the user.
      consputc(c);
    80005c12:	8526                	mv	a0,s1
    80005c14:	00000097          	auipc	ra,0x0
    80005c18:	f32080e7          	jalr	-206(ra) # 80005b46 <consputc>

      // store for consumption by consoleread().
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80005c1c:	0001c797          	auipc	a5,0x1c
    80005c20:	3e478793          	addi	a5,a5,996 # 80022000 <cons>
    80005c24:	0a07a683          	lw	a3,160(a5)
    80005c28:	0016871b          	addiw	a4,a3,1
    80005c2c:	0007061b          	sext.w	a2,a4
    80005c30:	0ae7a023          	sw	a4,160(a5)
    80005c34:	07f6f693          	andi	a3,a3,127
    80005c38:	97b6                	add	a5,a5,a3
    80005c3a:	00978c23          	sb	s1,24(a5)

      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    80005c3e:	47a9                	li	a5,10
    80005c40:	0ef48163          	beq	s1,a5,80005d22 <consoleintr+0x19a>
    80005c44:	4791                	li	a5,4
    80005c46:	0cf48e63          	beq	s1,a5,80005d22 <consoleintr+0x19a>
    80005c4a:	0001c797          	auipc	a5,0x1c
    80005c4e:	3b678793          	addi	a5,a5,950 # 80022000 <cons>
    80005c52:	0987a783          	lw	a5,152(a5)
    80005c56:	9f1d                	subw	a4,a4,a5
    80005c58:	08000793          	li	a5,128
    80005c5c:	06f71e63          	bne	a4,a5,80005cd8 <consoleintr+0x150>
    80005c60:	a0c9                	j	80005d22 <consoleintr+0x19a>
    while(cons.e != cons.w &&
    80005c62:	0001c717          	auipc	a4,0x1c
    80005c66:	39e70713          	addi	a4,a4,926 # 80022000 <cons>
    80005c6a:	0a072783          	lw	a5,160(a4)
    80005c6e:	09c72703          	lw	a4,156(a4)
    80005c72:	06f70363          	beq	a4,a5,80005cd8 <consoleintr+0x150>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80005c76:	37fd                	addiw	a5,a5,-1
    80005c78:	0007871b          	sext.w	a4,a5
    80005c7c:	07f7f793          	andi	a5,a5,127
    80005c80:	0001c697          	auipc	a3,0x1c
    80005c84:	38068693          	addi	a3,a3,896 # 80022000 <cons>
    80005c88:	97b6                	add	a5,a5,a3
    while(cons.e != cons.w &&
    80005c8a:	0187c683          	lbu	a3,24(a5)
    80005c8e:	47a9                	li	a5,10
      cons.e--;
    80005c90:	0001c497          	auipc	s1,0x1c
    80005c94:	37048493          	addi	s1,s1,880 # 80022000 <cons>
    while(cons.e != cons.w &&
    80005c98:	4929                	li	s2,10
    80005c9a:	02f68f63          	beq	a3,a5,80005cd8 <consoleintr+0x150>
      cons.e--;
    80005c9e:	0ae4a023          	sw	a4,160(s1)
      consputc(BACKSPACE);
    80005ca2:	10000513          	li	a0,256
    80005ca6:	00000097          	auipc	ra,0x0
    80005caa:	ea0080e7          	jalr	-352(ra) # 80005b46 <consputc>
    while(cons.e != cons.w &&
    80005cae:	0a04a783          	lw	a5,160(s1)
    80005cb2:	09c4a703          	lw	a4,156(s1)
    80005cb6:	02f70163          	beq	a4,a5,80005cd8 <consoleintr+0x150>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80005cba:	37fd                	addiw	a5,a5,-1
    80005cbc:	0007871b          	sext.w	a4,a5
    80005cc0:	07f7f793          	andi	a5,a5,127
    80005cc4:	97a6                	add	a5,a5,s1
    while(cons.e != cons.w &&
    80005cc6:	0187c783          	lbu	a5,24(a5)
    80005cca:	fd279ae3          	bne	a5,s2,80005c9e <consoleintr+0x116>
    80005cce:	a029                	j	80005cd8 <consoleintr+0x150>
    procdump();
    80005cd0:	ffffc097          	auipc	ra,0xffffc
    80005cd4:	d6a080e7          	jalr	-662(ra) # 80001a3a <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80005cd8:	0001c517          	auipc	a0,0x1c
    80005cdc:	32850513          	addi	a0,a0,808 # 80022000 <cons>
    80005ce0:	00000097          	auipc	ra,0x0
    80005ce4:	768080e7          	jalr	1896(ra) # 80006448 <release>
}
    80005ce8:	60e2                	ld	ra,24(sp)
    80005cea:	6442                	ld	s0,16(sp)
    80005cec:	64a2                	ld	s1,8(sp)
    80005cee:	6902                	ld	s2,0(sp)
    80005cf0:	6105                	addi	sp,sp,32
    80005cf2:	8082                	ret
      consputc(c);
    80005cf4:	4529                	li	a0,10
    80005cf6:	00000097          	auipc	ra,0x0
    80005cfa:	e50080e7          	jalr	-432(ra) # 80005b46 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80005cfe:	0001c797          	auipc	a5,0x1c
    80005d02:	30278793          	addi	a5,a5,770 # 80022000 <cons>
    80005d06:	0a07a703          	lw	a4,160(a5)
    80005d0a:	0017069b          	addiw	a3,a4,1
    80005d0e:	0006861b          	sext.w	a2,a3
    80005d12:	0ad7a023          	sw	a3,160(a5)
    80005d16:	07f77713          	andi	a4,a4,127
    80005d1a:	97ba                	add	a5,a5,a4
    80005d1c:	4729                	li	a4,10
    80005d1e:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80005d22:	0001c797          	auipc	a5,0x1c
    80005d26:	36c7ad23          	sw	a2,890(a5) # 8002209c <cons+0x9c>
        wakeup(&cons.r);
    80005d2a:	0001c517          	auipc	a0,0x1c
    80005d2e:	36e50513          	addi	a0,a0,878 # 80022098 <cons+0x98>
    80005d32:	ffffc097          	auipc	ra,0xffffc
    80005d36:	8b6080e7          	jalr	-1866(ra) # 800015e8 <wakeup>
    80005d3a:	bf79                	j	80005cd8 <consoleintr+0x150>

0000000080005d3c <consoleinit>:

void
consoleinit(void)
{
    80005d3c:	1141                	addi	sp,sp,-16
    80005d3e:	e406                	sd	ra,8(sp)
    80005d40:	e022                	sd	s0,0(sp)
    80005d42:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80005d44:	00003597          	auipc	a1,0x3
    80005d48:	c4458593          	addi	a1,a1,-956 # 80008988 <str_syscalls+0x4e8>
    80005d4c:	0001c517          	auipc	a0,0x1c
    80005d50:	2b450513          	addi	a0,a0,692 # 80022000 <cons>
    80005d54:	00000097          	auipc	ra,0x0
    80005d58:	5b0080e7          	jalr	1456(ra) # 80006304 <initlock>

  uartinit();
    80005d5c:	00000097          	auipc	ra,0x0
    80005d60:	332080e7          	jalr	818(ra) # 8000608e <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80005d64:	00013797          	auipc	a5,0x13
    80005d68:	fc478793          	addi	a5,a5,-60 # 80018d28 <devsw>
    80005d6c:	00000717          	auipc	a4,0x0
    80005d70:	cb870713          	addi	a4,a4,-840 # 80005a24 <consoleread>
    80005d74:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80005d76:	00000717          	auipc	a4,0x0
    80005d7a:	c4c70713          	addi	a4,a4,-948 # 800059c2 <consolewrite>
    80005d7e:	ef98                	sd	a4,24(a5)
}
    80005d80:	60a2                	ld	ra,8(sp)
    80005d82:	6402                	ld	s0,0(sp)
    80005d84:	0141                	addi	sp,sp,16
    80005d86:	8082                	ret

0000000080005d88 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    80005d88:	7179                	addi	sp,sp,-48
    80005d8a:	f406                	sd	ra,40(sp)
    80005d8c:	f022                	sd	s0,32(sp)
    80005d8e:	ec26                	sd	s1,24(sp)
    80005d90:	e84a                	sd	s2,16(sp)
    80005d92:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    80005d94:	c219                	beqz	a2,80005d9a <printint+0x12>
    80005d96:	00054d63          	bltz	a0,80005db0 <printint+0x28>
    x = -xx;
  else
    x = xx;
    80005d9a:	2501                	sext.w	a0,a0
    80005d9c:	4881                	li	a7,0
    80005d9e:	fd040713          	addi	a4,s0,-48

  i = 0;
    80005da2:	4601                	li	a2,0
  do {
    buf[i++] = digits[x % base];
    80005da4:	2581                	sext.w	a1,a1
    80005da6:	00003817          	auipc	a6,0x3
    80005daa:	bea80813          	addi	a6,a6,-1046 # 80008990 <digits>
    80005dae:	a039                	j	80005dbc <printint+0x34>
    x = -xx;
    80005db0:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    80005db4:	4885                	li	a7,1
    x = -xx;
    80005db6:	b7e5                	j	80005d9e <printint+0x16>
  } while((x /= base) != 0);
    80005db8:	853e                	mv	a0,a5
    buf[i++] = digits[x % base];
    80005dba:	8636                	mv	a2,a3
    80005dbc:	0016069b          	addiw	a3,a2,1
    80005dc0:	02b577bb          	remuw	a5,a0,a1
    80005dc4:	1782                	slli	a5,a5,0x20
    80005dc6:	9381                	srli	a5,a5,0x20
    80005dc8:	97c2                	add	a5,a5,a6
    80005dca:	0007c783          	lbu	a5,0(a5)
    80005dce:	00f70023          	sb	a5,0(a4)
    80005dd2:	0705                	addi	a4,a4,1
  } while((x /= base) != 0);
    80005dd4:	02b557bb          	divuw	a5,a0,a1
    80005dd8:	feb570e3          	bgeu	a0,a1,80005db8 <printint+0x30>

  if(sign)
    80005ddc:	00088b63          	beqz	a7,80005df2 <printint+0x6a>
    buf[i++] = '-';
    80005de0:	fe040793          	addi	a5,s0,-32
    80005de4:	96be                	add	a3,a3,a5
    80005de6:	02d00793          	li	a5,45
    80005dea:	fef68823          	sb	a5,-16(a3)
    80005dee:	0026069b          	addiw	a3,a2,2

  while(--i >= 0)
    80005df2:	02d05763          	blez	a3,80005e20 <printint+0x98>
    80005df6:	fd040793          	addi	a5,s0,-48
    80005dfa:	00d784b3          	add	s1,a5,a3
    80005dfe:	fff78913          	addi	s2,a5,-1
    80005e02:	9936                	add	s2,s2,a3
    80005e04:	36fd                	addiw	a3,a3,-1
    80005e06:	1682                	slli	a3,a3,0x20
    80005e08:	9281                	srli	a3,a3,0x20
    80005e0a:	40d90933          	sub	s2,s2,a3
    consputc(buf[i]);
    80005e0e:	fff4c503          	lbu	a0,-1(s1)
    80005e12:	00000097          	auipc	ra,0x0
    80005e16:	d34080e7          	jalr	-716(ra) # 80005b46 <consputc>
    80005e1a:	14fd                	addi	s1,s1,-1
  while(--i >= 0)
    80005e1c:	ff2499e3          	bne	s1,s2,80005e0e <printint+0x86>
}
    80005e20:	70a2                	ld	ra,40(sp)
    80005e22:	7402                	ld	s0,32(sp)
    80005e24:	64e2                	ld	s1,24(sp)
    80005e26:	6942                	ld	s2,16(sp)
    80005e28:	6145                	addi	sp,sp,48
    80005e2a:	8082                	ret

0000000080005e2c <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    80005e2c:	1101                	addi	sp,sp,-32
    80005e2e:	ec06                	sd	ra,24(sp)
    80005e30:	e822                	sd	s0,16(sp)
    80005e32:	e426                	sd	s1,8(sp)
    80005e34:	1000                	addi	s0,sp,32
    80005e36:	84aa                	mv	s1,a0
  pr.locking = 0;
    80005e38:	0001c797          	auipc	a5,0x1c
    80005e3c:	2807a423          	sw	zero,648(a5) # 800220c0 <pr+0x18>
  printf("panic: ");
    80005e40:	00003517          	auipc	a0,0x3
    80005e44:	b6850513          	addi	a0,a0,-1176 # 800089a8 <digits+0x18>
    80005e48:	00000097          	auipc	ra,0x0
    80005e4c:	02e080e7          	jalr	46(ra) # 80005e76 <printf>
  printf(s);
    80005e50:	8526                	mv	a0,s1
    80005e52:	00000097          	auipc	ra,0x0
    80005e56:	024080e7          	jalr	36(ra) # 80005e76 <printf>
  printf("\n");
    80005e5a:	00002517          	auipc	a0,0x2
    80005e5e:	1ee50513          	addi	a0,a0,494 # 80008048 <etext+0x48>
    80005e62:	00000097          	auipc	ra,0x0
    80005e66:	014080e7          	jalr	20(ra) # 80005e76 <printf>
  panicked = 1; // freeze uart output from other CPUs
    80005e6a:	4785                	li	a5,1
    80005e6c:	00003717          	auipc	a4,0x3
    80005e70:	c0f72823          	sw	a5,-1008(a4) # 80008a7c <panicked>
  for(;;)
    ;
    80005e74:	a001                	j	80005e74 <panic+0x48>

0000000080005e76 <printf>:
{
    80005e76:	7131                	addi	sp,sp,-192
    80005e78:	fc86                	sd	ra,120(sp)
    80005e7a:	f8a2                	sd	s0,112(sp)
    80005e7c:	f4a6                	sd	s1,104(sp)
    80005e7e:	f0ca                	sd	s2,96(sp)
    80005e80:	ecce                	sd	s3,88(sp)
    80005e82:	e8d2                	sd	s4,80(sp)
    80005e84:	e4d6                	sd	s5,72(sp)
    80005e86:	e0da                	sd	s6,64(sp)
    80005e88:	fc5e                	sd	s7,56(sp)
    80005e8a:	f862                	sd	s8,48(sp)
    80005e8c:	f466                	sd	s9,40(sp)
    80005e8e:	f06a                	sd	s10,32(sp)
    80005e90:	ec6e                	sd	s11,24(sp)
    80005e92:	0100                	addi	s0,sp,128
    80005e94:	8aaa                	mv	s5,a0
    80005e96:	e40c                	sd	a1,8(s0)
    80005e98:	e810                	sd	a2,16(s0)
    80005e9a:	ec14                	sd	a3,24(s0)
    80005e9c:	f018                	sd	a4,32(s0)
    80005e9e:	f41c                	sd	a5,40(s0)
    80005ea0:	03043823          	sd	a6,48(s0)
    80005ea4:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    80005ea8:	0001c797          	auipc	a5,0x1c
    80005eac:	20078793          	addi	a5,a5,512 # 800220a8 <pr>
    80005eb0:	0187ad83          	lw	s11,24(a5)
  if(locking)
    80005eb4:	020d9b63          	bnez	s11,80005eea <printf+0x74>
  if (fmt == 0)
    80005eb8:	020a8f63          	beqz	s5,80005ef6 <printf+0x80>
  va_start(ap, fmt);
    80005ebc:	00840793          	addi	a5,s0,8
    80005ec0:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005ec4:	000ac503          	lbu	a0,0(s5)
    80005ec8:	16050063          	beqz	a0,80006028 <printf+0x1b2>
    80005ecc:	4481                	li	s1,0
    if(c != '%'){
    80005ece:	02500a13          	li	s4,37
    switch(c){
    80005ed2:	07000b13          	li	s6,112
  consputc('x');
    80005ed6:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005ed8:	00003b97          	auipc	s7,0x3
    80005edc:	ab8b8b93          	addi	s7,s7,-1352 # 80008990 <digits>
    switch(c){
    80005ee0:	07300c93          	li	s9,115
    80005ee4:	06400c13          	li	s8,100
    80005ee8:	a815                	j	80005f1c <printf+0xa6>
    acquire(&pr.lock);
    80005eea:	853e                	mv	a0,a5
    80005eec:	00000097          	auipc	ra,0x0
    80005ef0:	4a8080e7          	jalr	1192(ra) # 80006394 <acquire>
    80005ef4:	b7d1                	j	80005eb8 <printf+0x42>
    panic("null fmt");
    80005ef6:	00003517          	auipc	a0,0x3
    80005efa:	ac250513          	addi	a0,a0,-1342 # 800089b8 <digits+0x28>
    80005efe:	00000097          	auipc	ra,0x0
    80005f02:	f2e080e7          	jalr	-210(ra) # 80005e2c <panic>
      consputc(c);
    80005f06:	00000097          	auipc	ra,0x0
    80005f0a:	c40080e7          	jalr	-960(ra) # 80005b46 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005f0e:	2485                	addiw	s1,s1,1
    80005f10:	009a87b3          	add	a5,s5,s1
    80005f14:	0007c503          	lbu	a0,0(a5)
    80005f18:	10050863          	beqz	a0,80006028 <printf+0x1b2>
    if(c != '%'){
    80005f1c:	ff4515e3          	bne	a0,s4,80005f06 <printf+0x90>
    c = fmt[++i] & 0xff;
    80005f20:	2485                	addiw	s1,s1,1
    80005f22:	009a87b3          	add	a5,s5,s1
    80005f26:	0007c783          	lbu	a5,0(a5)
    80005f2a:	0007891b          	sext.w	s2,a5
    if(c == 0)
    80005f2e:	0e090d63          	beqz	s2,80006028 <printf+0x1b2>
    switch(c){
    80005f32:	05678a63          	beq	a5,s6,80005f86 <printf+0x110>
    80005f36:	02fb7663          	bgeu	s6,a5,80005f62 <printf+0xec>
    80005f3a:	09978963          	beq	a5,s9,80005fcc <printf+0x156>
    80005f3e:	07800713          	li	a4,120
    80005f42:	0ce79863          	bne	a5,a4,80006012 <printf+0x19c>
      printint(va_arg(ap, int), 16, 1);
    80005f46:	f8843783          	ld	a5,-120(s0)
    80005f4a:	00878713          	addi	a4,a5,8
    80005f4e:	f8e43423          	sd	a4,-120(s0)
    80005f52:	4605                	li	a2,1
    80005f54:	85ea                	mv	a1,s10
    80005f56:	4388                	lw	a0,0(a5)
    80005f58:	00000097          	auipc	ra,0x0
    80005f5c:	e30080e7          	jalr	-464(ra) # 80005d88 <printint>
      break;
    80005f60:	b77d                	j	80005f0e <printf+0x98>
    switch(c){
    80005f62:	0b478263          	beq	a5,s4,80006006 <printf+0x190>
    80005f66:	0b879663          	bne	a5,s8,80006012 <printf+0x19c>
      printint(va_arg(ap, int), 10, 1);
    80005f6a:	f8843783          	ld	a5,-120(s0)
    80005f6e:	00878713          	addi	a4,a5,8
    80005f72:	f8e43423          	sd	a4,-120(s0)
    80005f76:	4605                	li	a2,1
    80005f78:	45a9                	li	a1,10
    80005f7a:	4388                	lw	a0,0(a5)
    80005f7c:	00000097          	auipc	ra,0x0
    80005f80:	e0c080e7          	jalr	-500(ra) # 80005d88 <printint>
      break;
    80005f84:	b769                	j	80005f0e <printf+0x98>
      printptr(va_arg(ap, uint64));
    80005f86:	f8843783          	ld	a5,-120(s0)
    80005f8a:	00878713          	addi	a4,a5,8
    80005f8e:	f8e43423          	sd	a4,-120(s0)
    80005f92:	0007b983          	ld	s3,0(a5)
  consputc('0');
    80005f96:	03000513          	li	a0,48
    80005f9a:	00000097          	auipc	ra,0x0
    80005f9e:	bac080e7          	jalr	-1108(ra) # 80005b46 <consputc>
  consputc('x');
    80005fa2:	07800513          	li	a0,120
    80005fa6:	00000097          	auipc	ra,0x0
    80005faa:	ba0080e7          	jalr	-1120(ra) # 80005b46 <consputc>
    80005fae:	896a                	mv	s2,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005fb0:	03c9d793          	srli	a5,s3,0x3c
    80005fb4:	97de                	add	a5,a5,s7
    80005fb6:	0007c503          	lbu	a0,0(a5)
    80005fba:	00000097          	auipc	ra,0x0
    80005fbe:	b8c080e7          	jalr	-1140(ra) # 80005b46 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80005fc2:	0992                	slli	s3,s3,0x4
    80005fc4:	397d                	addiw	s2,s2,-1
    80005fc6:	fe0915e3          	bnez	s2,80005fb0 <printf+0x13a>
    80005fca:	b791                	j	80005f0e <printf+0x98>
      if((s = va_arg(ap, char*)) == 0)
    80005fcc:	f8843783          	ld	a5,-120(s0)
    80005fd0:	00878713          	addi	a4,a5,8
    80005fd4:	f8e43423          	sd	a4,-120(s0)
    80005fd8:	0007b903          	ld	s2,0(a5)
    80005fdc:	00090e63          	beqz	s2,80005ff8 <printf+0x182>
      for(; *s; s++)
    80005fe0:	00094503          	lbu	a0,0(s2)
    80005fe4:	d50d                	beqz	a0,80005f0e <printf+0x98>
        consputc(*s);
    80005fe6:	00000097          	auipc	ra,0x0
    80005fea:	b60080e7          	jalr	-1184(ra) # 80005b46 <consputc>
      for(; *s; s++)
    80005fee:	0905                	addi	s2,s2,1
    80005ff0:	00094503          	lbu	a0,0(s2)
    80005ff4:	f96d                	bnez	a0,80005fe6 <printf+0x170>
    80005ff6:	bf21                	j	80005f0e <printf+0x98>
        s = "(null)";
    80005ff8:	00003917          	auipc	s2,0x3
    80005ffc:	9b890913          	addi	s2,s2,-1608 # 800089b0 <digits+0x20>
      for(; *s; s++)
    80006000:	02800513          	li	a0,40
    80006004:	b7cd                	j	80005fe6 <printf+0x170>
      consputc('%');
    80006006:	8552                	mv	a0,s4
    80006008:	00000097          	auipc	ra,0x0
    8000600c:	b3e080e7          	jalr	-1218(ra) # 80005b46 <consputc>
      break;
    80006010:	bdfd                	j	80005f0e <printf+0x98>
      consputc('%');
    80006012:	8552                	mv	a0,s4
    80006014:	00000097          	auipc	ra,0x0
    80006018:	b32080e7          	jalr	-1230(ra) # 80005b46 <consputc>
      consputc(c);
    8000601c:	854a                	mv	a0,s2
    8000601e:	00000097          	auipc	ra,0x0
    80006022:	b28080e7          	jalr	-1240(ra) # 80005b46 <consputc>
      break;
    80006026:	b5e5                	j	80005f0e <printf+0x98>
  if(locking)
    80006028:	020d9163          	bnez	s11,8000604a <printf+0x1d4>
}
    8000602c:	70e6                	ld	ra,120(sp)
    8000602e:	7446                	ld	s0,112(sp)
    80006030:	74a6                	ld	s1,104(sp)
    80006032:	7906                	ld	s2,96(sp)
    80006034:	69e6                	ld	s3,88(sp)
    80006036:	6a46                	ld	s4,80(sp)
    80006038:	6aa6                	ld	s5,72(sp)
    8000603a:	6b06                	ld	s6,64(sp)
    8000603c:	7be2                	ld	s7,56(sp)
    8000603e:	7c42                	ld	s8,48(sp)
    80006040:	7ca2                	ld	s9,40(sp)
    80006042:	7d02                	ld	s10,32(sp)
    80006044:	6de2                	ld	s11,24(sp)
    80006046:	6129                	addi	sp,sp,192
    80006048:	8082                	ret
    release(&pr.lock);
    8000604a:	0001c517          	auipc	a0,0x1c
    8000604e:	05e50513          	addi	a0,a0,94 # 800220a8 <pr>
    80006052:	00000097          	auipc	ra,0x0
    80006056:	3f6080e7          	jalr	1014(ra) # 80006448 <release>
}
    8000605a:	bfc9                	j	8000602c <printf+0x1b6>

000000008000605c <printfinit>:
}

void
printfinit(void)
{
    8000605c:	1101                	addi	sp,sp,-32
    8000605e:	ec06                	sd	ra,24(sp)
    80006060:	e822                	sd	s0,16(sp)
    80006062:	e426                	sd	s1,8(sp)
    80006064:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    80006066:	0001c497          	auipc	s1,0x1c
    8000606a:	04248493          	addi	s1,s1,66 # 800220a8 <pr>
    8000606e:	00003597          	auipc	a1,0x3
    80006072:	95a58593          	addi	a1,a1,-1702 # 800089c8 <digits+0x38>
    80006076:	8526                	mv	a0,s1
    80006078:	00000097          	auipc	ra,0x0
    8000607c:	28c080e7          	jalr	652(ra) # 80006304 <initlock>
  pr.locking = 1;
    80006080:	4785                	li	a5,1
    80006082:	cc9c                	sw	a5,24(s1)
}
    80006084:	60e2                	ld	ra,24(sp)
    80006086:	6442                	ld	s0,16(sp)
    80006088:	64a2                	ld	s1,8(sp)
    8000608a:	6105                	addi	sp,sp,32
    8000608c:	8082                	ret

000000008000608e <uartinit>:

void uartstart();

void
uartinit(void)
{
    8000608e:	1141                	addi	sp,sp,-16
    80006090:	e406                	sd	ra,8(sp)
    80006092:	e022                	sd	s0,0(sp)
    80006094:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80006096:	100007b7          	lui	a5,0x10000
    8000609a:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    8000609e:	f8000713          	li	a4,-128
    800060a2:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    800060a6:	470d                	li	a4,3
    800060a8:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    800060ac:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    800060b0:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    800060b4:	469d                	li	a3,7
    800060b6:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    800060ba:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    800060be:	00003597          	auipc	a1,0x3
    800060c2:	91258593          	addi	a1,a1,-1774 # 800089d0 <digits+0x40>
    800060c6:	0001c517          	auipc	a0,0x1c
    800060ca:	00250513          	addi	a0,a0,2 # 800220c8 <uart_tx_lock>
    800060ce:	00000097          	auipc	ra,0x0
    800060d2:	236080e7          	jalr	566(ra) # 80006304 <initlock>
}
    800060d6:	60a2                	ld	ra,8(sp)
    800060d8:	6402                	ld	s0,0(sp)
    800060da:	0141                	addi	sp,sp,16
    800060dc:	8082                	ret

00000000800060de <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    800060de:	1101                	addi	sp,sp,-32
    800060e0:	ec06                	sd	ra,24(sp)
    800060e2:	e822                	sd	s0,16(sp)
    800060e4:	e426                	sd	s1,8(sp)
    800060e6:	1000                	addi	s0,sp,32
    800060e8:	84aa                	mv	s1,a0
  push_off();
    800060ea:	00000097          	auipc	ra,0x0
    800060ee:	25e080e7          	jalr	606(ra) # 80006348 <push_off>

  if(panicked){
    800060f2:	00003797          	auipc	a5,0x3
    800060f6:	98a78793          	addi	a5,a5,-1654 # 80008a7c <panicked>
    800060fa:	439c                	lw	a5,0(a5)
    800060fc:	2781                	sext.w	a5,a5
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    800060fe:	10000737          	lui	a4,0x10000
  if(panicked){
    80006102:	c391                	beqz	a5,80006106 <uartputc_sync+0x28>
      ;
    80006104:	a001                	j	80006104 <uartputc_sync+0x26>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80006106:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000610a:	0ff7f793          	andi	a5,a5,255
    8000610e:	0207f793          	andi	a5,a5,32
    80006112:	dbf5                	beqz	a5,80006106 <uartputc_sync+0x28>
    ;
  WriteReg(THR, c);
    80006114:	0ff4f793          	andi	a5,s1,255
    80006118:	10000737          	lui	a4,0x10000
    8000611c:	00f70023          	sb	a5,0(a4) # 10000000 <_entry-0x70000000>

  pop_off();
    80006120:	00000097          	auipc	ra,0x0
    80006124:	2c8080e7          	jalr	712(ra) # 800063e8 <pop_off>
}
    80006128:	60e2                	ld	ra,24(sp)
    8000612a:	6442                	ld	s0,16(sp)
    8000612c:	64a2                	ld	s1,8(sp)
    8000612e:	6105                	addi	sp,sp,32
    80006130:	8082                	ret

0000000080006132 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    80006132:	00003797          	auipc	a5,0x3
    80006136:	94e78793          	addi	a5,a5,-1714 # 80008a80 <uart_tx_r>
    8000613a:	639c                	ld	a5,0(a5)
    8000613c:	00003717          	auipc	a4,0x3
    80006140:	94c70713          	addi	a4,a4,-1716 # 80008a88 <uart_tx_w>
    80006144:	6318                	ld	a4,0(a4)
    80006146:	08f70563          	beq	a4,a5,800061d0 <uartstart+0x9e>
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    8000614a:	10000737          	lui	a4,0x10000
    8000614e:	00574703          	lbu	a4,5(a4) # 10000005 <_entry-0x6ffffffb>
    80006152:	0ff77713          	andi	a4,a4,255
    80006156:	02077713          	andi	a4,a4,32
    8000615a:	cb3d                	beqz	a4,800061d0 <uartstart+0x9e>
{
    8000615c:	7139                	addi	sp,sp,-64
    8000615e:	fc06                	sd	ra,56(sp)
    80006160:	f822                	sd	s0,48(sp)
    80006162:	f426                	sd	s1,40(sp)
    80006164:	f04a                	sd	s2,32(sp)
    80006166:	ec4e                	sd	s3,24(sp)
    80006168:	e852                	sd	s4,16(sp)
    8000616a:	e456                	sd	s5,8(sp)
    8000616c:	0080                	addi	s0,sp,64
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    8000616e:	0001ca17          	auipc	s4,0x1c
    80006172:	f5aa0a13          	addi	s4,s4,-166 # 800220c8 <uart_tx_lock>
    uart_tx_r += 1;
    80006176:	00003497          	auipc	s1,0x3
    8000617a:	90a48493          	addi	s1,s1,-1782 # 80008a80 <uart_tx_r>
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    
    WriteReg(THR, c);
    8000617e:	10000937          	lui	s2,0x10000
    if(uart_tx_w == uart_tx_r){
    80006182:	00003997          	auipc	s3,0x3
    80006186:	90698993          	addi	s3,s3,-1786 # 80008a88 <uart_tx_w>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    8000618a:	01f7f713          	andi	a4,a5,31
    8000618e:	9752                	add	a4,a4,s4
    80006190:	01874a83          	lbu	s5,24(a4)
    uart_tx_r += 1;
    80006194:	0785                	addi	a5,a5,1
    80006196:	e09c                	sd	a5,0(s1)
    wakeup(&uart_tx_r);
    80006198:	8526                	mv	a0,s1
    8000619a:	ffffb097          	auipc	ra,0xffffb
    8000619e:	44e080e7          	jalr	1102(ra) # 800015e8 <wakeup>
    WriteReg(THR, c);
    800061a2:	01590023          	sb	s5,0(s2) # 10000000 <_entry-0x70000000>
    if(uart_tx_w == uart_tx_r){
    800061a6:	609c                	ld	a5,0(s1)
    800061a8:	0009b703          	ld	a4,0(s3)
    800061ac:	00f70963          	beq	a4,a5,800061be <uartstart+0x8c>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    800061b0:	00594703          	lbu	a4,5(s2)
    800061b4:	0ff77713          	andi	a4,a4,255
    800061b8:	02077713          	andi	a4,a4,32
    800061bc:	f779                	bnez	a4,8000618a <uartstart+0x58>
  }
}
    800061be:	70e2                	ld	ra,56(sp)
    800061c0:	7442                	ld	s0,48(sp)
    800061c2:	74a2                	ld	s1,40(sp)
    800061c4:	7902                	ld	s2,32(sp)
    800061c6:	69e2                	ld	s3,24(sp)
    800061c8:	6a42                	ld	s4,16(sp)
    800061ca:	6aa2                	ld	s5,8(sp)
    800061cc:	6121                	addi	sp,sp,64
    800061ce:	8082                	ret
    800061d0:	8082                	ret

00000000800061d2 <uartputc>:
{
    800061d2:	7179                	addi	sp,sp,-48
    800061d4:	f406                	sd	ra,40(sp)
    800061d6:	f022                	sd	s0,32(sp)
    800061d8:	ec26                	sd	s1,24(sp)
    800061da:	e84a                	sd	s2,16(sp)
    800061dc:	e44e                	sd	s3,8(sp)
    800061de:	e052                	sd	s4,0(sp)
    800061e0:	1800                	addi	s0,sp,48
    800061e2:	89aa                	mv	s3,a0
  acquire(&uart_tx_lock);
    800061e4:	0001c517          	auipc	a0,0x1c
    800061e8:	ee450513          	addi	a0,a0,-284 # 800220c8 <uart_tx_lock>
    800061ec:	00000097          	auipc	ra,0x0
    800061f0:	1a8080e7          	jalr	424(ra) # 80006394 <acquire>
  if(panicked){
    800061f4:	00003797          	auipc	a5,0x3
    800061f8:	88878793          	addi	a5,a5,-1912 # 80008a7c <panicked>
    800061fc:	439c                	lw	a5,0(a5)
    800061fe:	2781                	sext.w	a5,a5
    80006200:	e7d9                	bnez	a5,8000628e <uartputc+0xbc>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80006202:	00003797          	auipc	a5,0x3
    80006206:	88678793          	addi	a5,a5,-1914 # 80008a88 <uart_tx_w>
    8000620a:	639c                	ld	a5,0(a5)
    8000620c:	00003717          	auipc	a4,0x3
    80006210:	87470713          	addi	a4,a4,-1932 # 80008a80 <uart_tx_r>
    80006214:	6318                	ld	a4,0(a4)
    80006216:	02070713          	addi	a4,a4,32
    sleep(&uart_tx_r, &uart_tx_lock);
    8000621a:	0001ca17          	auipc	s4,0x1c
    8000621e:	eaea0a13          	addi	s4,s4,-338 # 800220c8 <uart_tx_lock>
    80006222:	00003497          	auipc	s1,0x3
    80006226:	85e48493          	addi	s1,s1,-1954 # 80008a80 <uart_tx_r>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000622a:	00003917          	auipc	s2,0x3
    8000622e:	85e90913          	addi	s2,s2,-1954 # 80008a88 <uart_tx_w>
    80006232:	00f71f63          	bne	a4,a5,80006250 <uartputc+0x7e>
    sleep(&uart_tx_r, &uart_tx_lock);
    80006236:	85d2                	mv	a1,s4
    80006238:	8526                	mv	a0,s1
    8000623a:	ffffb097          	auipc	ra,0xffffb
    8000623e:	34a080e7          	jalr	842(ra) # 80001584 <sleep>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80006242:	00093783          	ld	a5,0(s2)
    80006246:	6098                	ld	a4,0(s1)
    80006248:	02070713          	addi	a4,a4,32
    8000624c:	fef705e3          	beq	a4,a5,80006236 <uartputc+0x64>
  uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80006250:	0001c497          	auipc	s1,0x1c
    80006254:	e7848493          	addi	s1,s1,-392 # 800220c8 <uart_tx_lock>
    80006258:	01f7f713          	andi	a4,a5,31
    8000625c:	9726                	add	a4,a4,s1
    8000625e:	01370c23          	sb	s3,24(a4)
  uart_tx_w += 1;
    80006262:	0785                	addi	a5,a5,1
    80006264:	00003717          	auipc	a4,0x3
    80006268:	82f73223          	sd	a5,-2012(a4) # 80008a88 <uart_tx_w>
  uartstart();
    8000626c:	00000097          	auipc	ra,0x0
    80006270:	ec6080e7          	jalr	-314(ra) # 80006132 <uartstart>
  release(&uart_tx_lock);
    80006274:	8526                	mv	a0,s1
    80006276:	00000097          	auipc	ra,0x0
    8000627a:	1d2080e7          	jalr	466(ra) # 80006448 <release>
}
    8000627e:	70a2                	ld	ra,40(sp)
    80006280:	7402                	ld	s0,32(sp)
    80006282:	64e2                	ld	s1,24(sp)
    80006284:	6942                	ld	s2,16(sp)
    80006286:	69a2                	ld	s3,8(sp)
    80006288:	6a02                	ld	s4,0(sp)
    8000628a:	6145                	addi	sp,sp,48
    8000628c:	8082                	ret
      ;
    8000628e:	a001                	j	8000628e <uartputc+0xbc>

0000000080006290 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80006290:	1141                	addi	sp,sp,-16
    80006292:	e422                	sd	s0,8(sp)
    80006294:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80006296:	100007b7          	lui	a5,0x10000
    8000629a:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    8000629e:	8b85                	andi	a5,a5,1
    800062a0:	cb81                	beqz	a5,800062b0 <uartgetc+0x20>
    // input data is ready.
    return ReadReg(RHR);
    800062a2:	100007b7          	lui	a5,0x10000
    800062a6:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    800062aa:	6422                	ld	s0,8(sp)
    800062ac:	0141                	addi	sp,sp,16
    800062ae:	8082                	ret
    return -1;
    800062b0:	557d                	li	a0,-1
    800062b2:	bfe5                	j	800062aa <uartgetc+0x1a>

00000000800062b4 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    800062b4:	1101                	addi	sp,sp,-32
    800062b6:	ec06                	sd	ra,24(sp)
    800062b8:	e822                	sd	s0,16(sp)
    800062ba:	e426                	sd	s1,8(sp)
    800062bc:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    800062be:	54fd                	li	s1,-1
    int c = uartgetc();
    800062c0:	00000097          	auipc	ra,0x0
    800062c4:	fd0080e7          	jalr	-48(ra) # 80006290 <uartgetc>
    if(c == -1)
    800062c8:	00950763          	beq	a0,s1,800062d6 <uartintr+0x22>
      break;
    consoleintr(c);
    800062cc:	00000097          	auipc	ra,0x0
    800062d0:	8bc080e7          	jalr	-1860(ra) # 80005b88 <consoleintr>
  while(1){
    800062d4:	b7f5                	j	800062c0 <uartintr+0xc>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    800062d6:	0001c497          	auipc	s1,0x1c
    800062da:	df248493          	addi	s1,s1,-526 # 800220c8 <uart_tx_lock>
    800062de:	8526                	mv	a0,s1
    800062e0:	00000097          	auipc	ra,0x0
    800062e4:	0b4080e7          	jalr	180(ra) # 80006394 <acquire>
  uartstart();
    800062e8:	00000097          	auipc	ra,0x0
    800062ec:	e4a080e7          	jalr	-438(ra) # 80006132 <uartstart>
  release(&uart_tx_lock);
    800062f0:	8526                	mv	a0,s1
    800062f2:	00000097          	auipc	ra,0x0
    800062f6:	156080e7          	jalr	342(ra) # 80006448 <release>
}
    800062fa:	60e2                	ld	ra,24(sp)
    800062fc:	6442                	ld	s0,16(sp)
    800062fe:	64a2                	ld	s1,8(sp)
    80006300:	6105                	addi	sp,sp,32
    80006302:	8082                	ret

0000000080006304 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80006304:	1141                	addi	sp,sp,-16
    80006306:	e422                	sd	s0,8(sp)
    80006308:	0800                	addi	s0,sp,16
  lk->name = name;
    8000630a:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    8000630c:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80006310:	00053823          	sd	zero,16(a0)
}
    80006314:	6422                	ld	s0,8(sp)
    80006316:	0141                	addi	sp,sp,16
    80006318:	8082                	ret

000000008000631a <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    8000631a:	411c                	lw	a5,0(a0)
    8000631c:	e399                	bnez	a5,80006322 <holding+0x8>
    8000631e:	4501                	li	a0,0
  return r;
}
    80006320:	8082                	ret
{
    80006322:	1101                	addi	sp,sp,-32
    80006324:	ec06                	sd	ra,24(sp)
    80006326:	e822                	sd	s0,16(sp)
    80006328:	e426                	sd	s1,8(sp)
    8000632a:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    8000632c:	6904                	ld	s1,16(a0)
    8000632e:	ffffb097          	auipc	ra,0xffffb
    80006332:	b8a080e7          	jalr	-1142(ra) # 80000eb8 <mycpu>
    80006336:	40a48533          	sub	a0,s1,a0
    8000633a:	00153513          	seqz	a0,a0
}
    8000633e:	60e2                	ld	ra,24(sp)
    80006340:	6442                	ld	s0,16(sp)
    80006342:	64a2                	ld	s1,8(sp)
    80006344:	6105                	addi	sp,sp,32
    80006346:	8082                	ret

0000000080006348 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80006348:	1101                	addi	sp,sp,-32
    8000634a:	ec06                	sd	ra,24(sp)
    8000634c:	e822                	sd	s0,16(sp)
    8000634e:	e426                	sd	s1,8(sp)
    80006350:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80006352:	100024f3          	csrr	s1,sstatus
    80006356:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    8000635a:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000635c:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    80006360:	ffffb097          	auipc	ra,0xffffb
    80006364:	b58080e7          	jalr	-1192(ra) # 80000eb8 <mycpu>
    80006368:	5d3c                	lw	a5,120(a0)
    8000636a:	cf89                	beqz	a5,80006384 <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    8000636c:	ffffb097          	auipc	ra,0xffffb
    80006370:	b4c080e7          	jalr	-1204(ra) # 80000eb8 <mycpu>
    80006374:	5d3c                	lw	a5,120(a0)
    80006376:	2785                	addiw	a5,a5,1
    80006378:	dd3c                	sw	a5,120(a0)
}
    8000637a:	60e2                	ld	ra,24(sp)
    8000637c:	6442                	ld	s0,16(sp)
    8000637e:	64a2                	ld	s1,8(sp)
    80006380:	6105                	addi	sp,sp,32
    80006382:	8082                	ret
    mycpu()->intena = old;
    80006384:	ffffb097          	auipc	ra,0xffffb
    80006388:	b34080e7          	jalr	-1228(ra) # 80000eb8 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    8000638c:	8085                	srli	s1,s1,0x1
    8000638e:	8885                	andi	s1,s1,1
    80006390:	dd64                	sw	s1,124(a0)
    80006392:	bfe9                	j	8000636c <push_off+0x24>

0000000080006394 <acquire>:
{
    80006394:	1101                	addi	sp,sp,-32
    80006396:	ec06                	sd	ra,24(sp)
    80006398:	e822                	sd	s0,16(sp)
    8000639a:	e426                	sd	s1,8(sp)
    8000639c:	1000                	addi	s0,sp,32
    8000639e:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    800063a0:	00000097          	auipc	ra,0x0
    800063a4:	fa8080e7          	jalr	-88(ra) # 80006348 <push_off>
  if(holding(lk))
    800063a8:	8526                	mv	a0,s1
    800063aa:	00000097          	auipc	ra,0x0
    800063ae:	f70080e7          	jalr	-144(ra) # 8000631a <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800063b2:	4705                	li	a4,1
  if(holding(lk))
    800063b4:	e115                	bnez	a0,800063d8 <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800063b6:	87ba                	mv	a5,a4
    800063b8:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800063bc:	2781                	sext.w	a5,a5
    800063be:	ffe5                	bnez	a5,800063b6 <acquire+0x22>
  __sync_synchronize();
    800063c0:	0ff0000f          	fence
  lk->cpu = mycpu();
    800063c4:	ffffb097          	auipc	ra,0xffffb
    800063c8:	af4080e7          	jalr	-1292(ra) # 80000eb8 <mycpu>
    800063cc:	e888                	sd	a0,16(s1)
}
    800063ce:	60e2                	ld	ra,24(sp)
    800063d0:	6442                	ld	s0,16(sp)
    800063d2:	64a2                	ld	s1,8(sp)
    800063d4:	6105                	addi	sp,sp,32
    800063d6:	8082                	ret
    panic("acquire");
    800063d8:	00002517          	auipc	a0,0x2
    800063dc:	60050513          	addi	a0,a0,1536 # 800089d8 <digits+0x48>
    800063e0:	00000097          	auipc	ra,0x0
    800063e4:	a4c080e7          	jalr	-1460(ra) # 80005e2c <panic>

00000000800063e8 <pop_off>:

void
pop_off(void)
{
    800063e8:	1141                	addi	sp,sp,-16
    800063ea:	e406                	sd	ra,8(sp)
    800063ec:	e022                	sd	s0,0(sp)
    800063ee:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    800063f0:	ffffb097          	auipc	ra,0xffffb
    800063f4:	ac8080e7          	jalr	-1336(ra) # 80000eb8 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800063f8:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800063fc:	8b89                	andi	a5,a5,2
  if(intr_get())
    800063fe:	e78d                	bnez	a5,80006428 <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80006400:	5d3c                	lw	a5,120(a0)
    80006402:	02f05b63          	blez	a5,80006438 <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    80006406:	37fd                	addiw	a5,a5,-1
    80006408:	0007871b          	sext.w	a4,a5
    8000640c:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    8000640e:	eb09                	bnez	a4,80006420 <pop_off+0x38>
    80006410:	5d7c                	lw	a5,124(a0)
    80006412:	c799                	beqz	a5,80006420 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80006414:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80006418:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000641c:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80006420:	60a2                	ld	ra,8(sp)
    80006422:	6402                	ld	s0,0(sp)
    80006424:	0141                	addi	sp,sp,16
    80006426:	8082                	ret
    panic("pop_off - interruptible");
    80006428:	00002517          	auipc	a0,0x2
    8000642c:	5b850513          	addi	a0,a0,1464 # 800089e0 <digits+0x50>
    80006430:	00000097          	auipc	ra,0x0
    80006434:	9fc080e7          	jalr	-1540(ra) # 80005e2c <panic>
    panic("pop_off");
    80006438:	00002517          	auipc	a0,0x2
    8000643c:	5c050513          	addi	a0,a0,1472 # 800089f8 <digits+0x68>
    80006440:	00000097          	auipc	ra,0x0
    80006444:	9ec080e7          	jalr	-1556(ra) # 80005e2c <panic>

0000000080006448 <release>:
{
    80006448:	1101                	addi	sp,sp,-32
    8000644a:	ec06                	sd	ra,24(sp)
    8000644c:	e822                	sd	s0,16(sp)
    8000644e:	e426                	sd	s1,8(sp)
    80006450:	1000                	addi	s0,sp,32
    80006452:	84aa                	mv	s1,a0
  if(!holding(lk))
    80006454:	00000097          	auipc	ra,0x0
    80006458:	ec6080e7          	jalr	-314(ra) # 8000631a <holding>
    8000645c:	c115                	beqz	a0,80006480 <release+0x38>
  lk->cpu = 0;
    8000645e:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80006462:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    80006466:	0f50000f          	fence	iorw,ow
    8000646a:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    8000646e:	00000097          	auipc	ra,0x0
    80006472:	f7a080e7          	jalr	-134(ra) # 800063e8 <pop_off>
}
    80006476:	60e2                	ld	ra,24(sp)
    80006478:	6442                	ld	s0,16(sp)
    8000647a:	64a2                	ld	s1,8(sp)
    8000647c:	6105                	addi	sp,sp,32
    8000647e:	8082                	ret
    panic("release");
    80006480:	00002517          	auipc	a0,0x2
    80006484:	58050513          	addi	a0,a0,1408 # 80008a00 <digits+0x70>
    80006488:	00000097          	auipc	ra,0x0
    8000648c:	9a4080e7          	jalr	-1628(ra) # 80005e2c <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051073          	csrw	sscratch,a0
    80007004:	02000537          	lui	a0,0x2000
    80007008:	fff5051b          	addiw	a0,a0,-1
    8000700c:	00d51513          	slli	a0,a0,0xd
    80007010:	02153423          	sd	ra,40(a0) # 2000028 <_entry-0x7dffffd8>
    80007014:	02253823          	sd	sp,48(a0)
    80007018:	02353c23          	sd	gp,56(a0)
    8000701c:	04453023          	sd	tp,64(a0)
    80007020:	04553423          	sd	t0,72(a0)
    80007024:	04653823          	sd	t1,80(a0)
    80007028:	04753c23          	sd	t2,88(a0)
    8000702c:	f120                	sd	s0,96(a0)
    8000702e:	f524                	sd	s1,104(a0)
    80007030:	fd2c                	sd	a1,120(a0)
    80007032:	e150                	sd	a2,128(a0)
    80007034:	e554                	sd	a3,136(a0)
    80007036:	e958                	sd	a4,144(a0)
    80007038:	ed5c                	sd	a5,152(a0)
    8000703a:	0b053023          	sd	a6,160(a0)
    8000703e:	0b153423          	sd	a7,168(a0)
    80007042:	0b253823          	sd	s2,176(a0)
    80007046:	0b353c23          	sd	s3,184(a0)
    8000704a:	0d453023          	sd	s4,192(a0)
    8000704e:	0d553423          	sd	s5,200(a0)
    80007052:	0d653823          	sd	s6,208(a0)
    80007056:	0d753c23          	sd	s7,216(a0)
    8000705a:	0f853023          	sd	s8,224(a0)
    8000705e:	0f953423          	sd	s9,232(a0)
    80007062:	0fa53823          	sd	s10,240(a0)
    80007066:	0fb53c23          	sd	s11,248(a0)
    8000706a:	11c53023          	sd	t3,256(a0)
    8000706e:	11d53423          	sd	t4,264(a0)
    80007072:	11e53823          	sd	t5,272(a0)
    80007076:	11f53c23          	sd	t6,280(a0)
    8000707a:	140022f3          	csrr	t0,sscratch
    8000707e:	06553823          	sd	t0,112(a0)
    80007082:	00853103          	ld	sp,8(a0)
    80007086:	02053203          	ld	tp,32(a0)
    8000708a:	01053283          	ld	t0,16(a0)
    8000708e:	00053303          	ld	t1,0(a0)
    80007092:	12000073          	sfence.vma
    80007096:	18031073          	csrw	satp,t1
    8000709a:	12000073          	sfence.vma
    8000709e:	8282                	jr	t0

00000000800070a0 <userret>:
    800070a0:	12000073          	sfence.vma
    800070a4:	18051073          	csrw	satp,a0
    800070a8:	12000073          	sfence.vma
    800070ac:	02000537          	lui	a0,0x2000
    800070b0:	fff5051b          	addiw	a0,a0,-1
    800070b4:	00d51513          	slli	a0,a0,0xd
    800070b8:	02853083          	ld	ra,40(a0) # 2000028 <_entry-0x7dffffd8>
    800070bc:	03053103          	ld	sp,48(a0)
    800070c0:	03853183          	ld	gp,56(a0)
    800070c4:	04053203          	ld	tp,64(a0)
    800070c8:	04853283          	ld	t0,72(a0)
    800070cc:	05053303          	ld	t1,80(a0)
    800070d0:	05853383          	ld	t2,88(a0)
    800070d4:	7120                	ld	s0,96(a0)
    800070d6:	7524                	ld	s1,104(a0)
    800070d8:	7d2c                	ld	a1,120(a0)
    800070da:	6150                	ld	a2,128(a0)
    800070dc:	6554                	ld	a3,136(a0)
    800070de:	6958                	ld	a4,144(a0)
    800070e0:	6d5c                	ld	a5,152(a0)
    800070e2:	0a053803          	ld	a6,160(a0)
    800070e6:	0a853883          	ld	a7,168(a0)
    800070ea:	0b053903          	ld	s2,176(a0)
    800070ee:	0b853983          	ld	s3,184(a0)
    800070f2:	0c053a03          	ld	s4,192(a0)
    800070f6:	0c853a83          	ld	s5,200(a0)
    800070fa:	0d053b03          	ld	s6,208(a0)
    800070fe:	0d853b83          	ld	s7,216(a0)
    80007102:	0e053c03          	ld	s8,224(a0)
    80007106:	0e853c83          	ld	s9,232(a0)
    8000710a:	0f053d03          	ld	s10,240(a0)
    8000710e:	0f853d83          	ld	s11,248(a0)
    80007112:	10053e03          	ld	t3,256(a0)
    80007116:	10853e83          	ld	t4,264(a0)
    8000711a:	11053f03          	ld	t5,272(a0)
    8000711e:	11853f83          	ld	t6,280(a0)
    80007122:	7928                	ld	a0,112(a0)
    80007124:	10200073          	sret
	...
