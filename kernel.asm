
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 50 6f 11 80       	mov    $0x80116f50,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 70 30 10 80       	mov    $0x80103070,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 c0 7f 10 80       	push   $0x80107fc0
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 85 4f 00 00       	call   80104fe0 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 c7 7f 10 80       	push   $0x80107fc7
80100097:	50                   	push   %eax
80100098:	e8 13 4e 00 00       	call   80104eb0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 c7 50 00 00       	call   801051b0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 b5 10 80       	push   $0x8010b520
80100162:	e8 e9 4f 00 00       	call   80105150 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 7e 4d 00 00       	call   80104ef0 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 5f 21 00 00       	call   801022f0 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
  panic("bget: no buffers");
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 ce 7f 10 80       	push   $0x80107fce
801001a6:	e8 d5 01 00 00       	call   80100380 <panic>
801001ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001af:	90                   	nop

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 cd 4d 00 00       	call   80104f90 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave  
  iderw(b);
801001d4:	e9 17 21 00 00       	jmp    801022f0 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 df 7f 10 80       	push   $0x80107fdf
801001e1:	e8 9a 01 00 00       	call   80100380 <panic>
801001e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ed:	8d 76 00             	lea    0x0(%esi),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 8c 4d 00 00       	call   80104f90 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 3c 4d 00 00       	call   80104f50 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 90 4f 00 00       	call   801051b0 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2f                	jne    8010025f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 43 54             	mov    0x54(%ebx),%eax
80100233:	8b 53 50             	mov    0x50(%ebx),%edx
80100236:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100239:	8b 43 50             	mov    0x50(%ebx),%eax
8010023c:	8b 53 54             	mov    0x54(%ebx),%edx
8010023f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100242:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
    b->prev = &bcache.head;
80100247:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    b->next = bcache.head.next;
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100251:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100259:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  }
  
  release(&bcache.lock);
8010025f:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010026c:	e9 df 4e 00 00       	jmp    80105150 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 e6 7f 10 80       	push   $0x80107fe6
80100279:	e8 02 01 00 00       	call   80100380 <panic>
8010027e:	66 90                	xchg   %ax,%ax

80100280 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 18             	sub    $0x18,%esp
80100289:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010028c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010028f:	ff 75 08             	push   0x8(%ebp)
  target = n;
80100292:	89 df                	mov    %ebx,%edi
  iunlock(ip);
80100294:	e8 d7 15 00 00       	call   80101870 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801002a0:	e8 0b 4f 00 00       	call   801051b0 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002b5:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002bb:	74 25                	je     801002e2 <consoleread+0x62>
801002bd:	eb 59                	jmp    80100318 <consoleread+0x98>
801002bf:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002c0:	83 ec 08             	sub    $0x8,%esp
801002c3:	68 20 ff 10 80       	push   $0x8010ff20
801002c8:	68 00 ff 10 80       	push   $0x8010ff00
801002cd:	e8 de 40 00 00       	call   801043b0 <sleep>
    while(input.r == input.w){
801002d2:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 d9 36 00 00       	call   801039c0 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 20 ff 10 80       	push   $0x8010ff20
801002f6:	e8 55 4e 00 00       	call   80105150 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 8c 14 00 00       	call   80101790 <ilock>
        return -1;
80100304:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100307:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010030a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010030f:	5b                   	pop    %ebx
80100310:	5e                   	pop    %esi
80100311:	5f                   	pop    %edi
80100312:	5d                   	pop    %ebp
80100313:	c3                   	ret    
80100314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100318:	8d 50 01             	lea    0x1(%eax),%edx
8010031b:	89 15 00 ff 10 80    	mov    %edx,0x8010ff00
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 80 fe 10 80 	movsbl -0x7fef0180(%edx),%ecx
    if(c == C('D')){  // EOF
8010032d:	80 f9 04             	cmp    $0x4,%cl
80100330:	74 37                	je     80100369 <consoleread+0xe9>
    *dst++ = c;
80100332:	83 c6 01             	add    $0x1,%esi
    --n;
80100335:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100338:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010033b:	83 f9 0a             	cmp    $0xa,%ecx
8010033e:	0f 85 64 ff ff ff    	jne    801002a8 <consoleread+0x28>
  release(&cons.lock);
80100344:	83 ec 0c             	sub    $0xc,%esp
80100347:	68 20 ff 10 80       	push   $0x8010ff20
8010034c:	e8 ff 4d 00 00       	call   80105150 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 36 14 00 00       	call   80101790 <ilock>
  return target - n;
8010035a:	89 f8                	mov    %edi,%eax
8010035c:	83 c4 10             	add    $0x10,%esp
}
8010035f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100362:	29 d8                	sub    %ebx,%eax
}
80100364:	5b                   	pop    %ebx
80100365:	5e                   	pop    %esi
80100366:	5f                   	pop    %edi
80100367:	5d                   	pop    %ebp
80100368:	c3                   	ret    
      if(n < target){
80100369:	39 fb                	cmp    %edi,%ebx
8010036b:	73 d7                	jae    80100344 <consoleread+0xc4>
        input.r--;
8010036d:	a3 00 ff 10 80       	mov    %eax,0x8010ff00
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010037b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010037f:	90                   	nop

80100380 <panic>:
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100388:	fa                   	cli    
  cons.locking = 0;
80100389:	c7 05 54 ff 10 80 00 	movl   $0x0,0x8010ff54
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 62 25 00 00       	call   80102900 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 ed 7f 10 80       	push   $0x80107fed
801003a7:	e8 f4 02 00 00       	call   801006a0 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	push   0x8(%ebp)
801003b0:	e8 eb 02 00 00       	call   801006a0 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 77 8b 10 80 	movl   $0x80108b77,(%esp)
801003bc:	e8 df 02 00 00       	call   801006a0 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 33 4c 00 00       	call   80105000 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003d8:	68 01 80 10 80       	push   $0x80108001
801003dd:	e8 be 02 00 00       	call   801006a0 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 58 ff 10 80 01 	movl   $0x1,0x8010ff58
801003f0:	00 00 00 
  for(;;)
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100400 <consputc.part.0>:
consputc(int c)
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 ea 00 00 00    	je     80100500 <consputc.part.0+0x100>
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 c1 66 00 00       	call   80106ae0 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100434:	89 f2                	mov    %esi,%edx
80100436:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	b8 0f 00 00 00       	mov    $0xf,%eax
80100441:	c1 e1 08             	shl    $0x8,%ecx
80100444:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100445:	89 f2                	mov    %esi,%edx
80100447:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100448:	0f b6 c0             	movzbl %al,%eax
8010044b:	09 c8                	or     %ecx,%eax
  if(c == '\n')
8010044d:	83 fb 0a             	cmp    $0xa,%ebx
80100450:	0f 84 92 00 00 00    	je     801004e8 <consputc.part.0+0xe8>
  else if(c == BACKSPACE){
80100456:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045c:	74 72                	je     801004d0 <consputc.part.0+0xd0>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010045e:	0f b6 db             	movzbl %bl,%ebx
80100461:	8d 70 01             	lea    0x1(%eax),%esi
80100464:	80 cf 07             	or     $0x7,%bh
80100467:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
8010046e:	80 
  if(pos < 0 || pos > 25*80)
8010046f:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
80100475:	0f 8f fb 00 00 00    	jg     80100576 <consputc.part.0+0x176>
  if((pos/80) >= 24){  // Scroll up.
8010047b:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100481:	0f 8f a9 00 00 00    	jg     80100530 <consputc.part.0+0x130>
  outb(CRTPORT+1, pos>>8);
80100487:	89 f0                	mov    %esi,%eax
  crt[pos] = ' ' | 0x0700;
80100489:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
80100490:	88 45 e7             	mov    %al,-0x19(%ebp)
  outb(CRTPORT+1, pos>>8);
80100493:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100496:	bb d4 03 00 00       	mov    $0x3d4,%ebx
8010049b:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a0:	89 da                	mov    %ebx,%edx
801004a2:	ee                   	out    %al,(%dx)
801004a3:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801004a8:	89 f8                	mov    %edi,%eax
801004aa:	89 ca                	mov    %ecx,%edx
801004ac:	ee                   	out    %al,(%dx)
801004ad:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b2:	89 da                	mov    %ebx,%edx
801004b4:	ee                   	out    %al,(%dx)
801004b5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004b9:	89 ca                	mov    %ecx,%edx
801004bb:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004bc:	b8 20 07 00 00       	mov    $0x720,%eax
801004c1:	66 89 06             	mov    %ax,(%esi)
}
801004c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c7:	5b                   	pop    %ebx
801004c8:	5e                   	pop    %esi
801004c9:	5f                   	pop    %edi
801004ca:	5d                   	pop    %ebp
801004cb:	c3                   	ret    
801004cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pos > 0) --pos;
801004d0:	8d 70 ff             	lea    -0x1(%eax),%esi
801004d3:	85 c0                	test   %eax,%eax
801004d5:	75 98                	jne    8010046f <consputc.part.0+0x6f>
801004d7:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
801004db:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004e0:	31 ff                	xor    %edi,%edi
801004e2:	eb b2                	jmp    80100496 <consputc.part.0+0x96>
801004e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pos += 80 - pos%80;
801004e8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004ed:	f7 e2                	mul    %edx
801004ef:	c1 ea 06             	shr    $0x6,%edx
801004f2:	8d 04 92             	lea    (%edx,%edx,4),%eax
801004f5:	c1 e0 04             	shl    $0x4,%eax
801004f8:	8d 70 50             	lea    0x50(%eax),%esi
801004fb:	e9 6f ff ff ff       	jmp    8010046f <consputc.part.0+0x6f>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100500:	83 ec 0c             	sub    $0xc,%esp
80100503:	6a 08                	push   $0x8
80100505:	e8 d6 65 00 00       	call   80106ae0 <uartputc>
8010050a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100511:	e8 ca 65 00 00       	call   80106ae0 <uartputc>
80100516:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010051d:	e8 be 65 00 00       	call   80106ae0 <uartputc>
80100522:	83 c4 10             	add    $0x10,%esp
80100525:	e9 f8 fe ff ff       	jmp    80100422 <consputc.part.0+0x22>
8010052a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100530:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100533:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100536:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
8010053d:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100542:	68 60 0e 00 00       	push   $0xe60
80100547:	68 a0 80 0b 80       	push   $0x800b80a0
8010054c:	68 00 80 0b 80       	push   $0x800b8000
80100551:	e8 ba 4d 00 00       	call   80105310 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100556:	b8 80 07 00 00       	mov    $0x780,%eax
8010055b:	83 c4 0c             	add    $0xc,%esp
8010055e:	29 d8                	sub    %ebx,%eax
80100560:	01 c0                	add    %eax,%eax
80100562:	50                   	push   %eax
80100563:	6a 00                	push   $0x0
80100565:	56                   	push   %esi
80100566:	e8 05 4d 00 00       	call   80105270 <memset>
  outb(CRTPORT+1, pos);
8010056b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010056e:	83 c4 10             	add    $0x10,%esp
80100571:	e9 20 ff ff ff       	jmp    80100496 <consputc.part.0+0x96>
    panic("pos under/overflow");
80100576:	83 ec 0c             	sub    $0xc,%esp
80100579:	68 05 80 10 80       	push   $0x80108005
8010057e:	e8 fd fd ff ff       	call   80100380 <panic>
80100583:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010058a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100590 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100590:	55                   	push   %ebp
80100591:	89 e5                	mov    %esp,%ebp
80100593:	57                   	push   %edi
80100594:	56                   	push   %esi
80100595:	53                   	push   %ebx
80100596:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100599:	ff 75 08             	push   0x8(%ebp)
{
8010059c:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
8010059f:	e8 cc 12 00 00       	call   80101870 <iunlock>
  acquire(&cons.lock);
801005a4:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801005ab:	e8 00 4c 00 00       	call   801051b0 <acquire>
  for(i = 0; i < n; i++)
801005b0:	83 c4 10             	add    $0x10,%esp
801005b3:	85 f6                	test   %esi,%esi
801005b5:	7e 25                	jle    801005dc <consolewrite+0x4c>
801005b7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801005ba:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
801005bd:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
    consputc(buf[i] & 0xff);
801005c3:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
801005c6:	85 d2                	test   %edx,%edx
801005c8:	74 06                	je     801005d0 <consolewrite+0x40>
  asm volatile("cli");
801005ca:	fa                   	cli    
    for(;;)
801005cb:	eb fe                	jmp    801005cb <consolewrite+0x3b>
801005cd:	8d 76 00             	lea    0x0(%esi),%esi
801005d0:	e8 2b fe ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; i < n; i++)
801005d5:	83 c3 01             	add    $0x1,%ebx
801005d8:	39 df                	cmp    %ebx,%edi
801005da:	75 e1                	jne    801005bd <consolewrite+0x2d>
  release(&cons.lock);
801005dc:	83 ec 0c             	sub    $0xc,%esp
801005df:	68 20 ff 10 80       	push   $0x8010ff20
801005e4:	e8 67 4b 00 00       	call   80105150 <release>
  ilock(ip);
801005e9:	58                   	pop    %eax
801005ea:	ff 75 08             	push   0x8(%ebp)
801005ed:	e8 9e 11 00 00       	call   80101790 <ilock>

  return n;
}
801005f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801005f5:	89 f0                	mov    %esi,%eax
801005f7:	5b                   	pop    %ebx
801005f8:	5e                   	pop    %esi
801005f9:	5f                   	pop    %edi
801005fa:	5d                   	pop    %ebp
801005fb:	c3                   	ret    
801005fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100600 <printint>:
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 2c             	sub    $0x2c,%esp
80100609:	89 55 d4             	mov    %edx,-0x2c(%ebp)
8010060c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  if(sign && (sign = xx < 0))
8010060f:	85 c9                	test   %ecx,%ecx
80100611:	74 04                	je     80100617 <printint+0x17>
80100613:	85 c0                	test   %eax,%eax
80100615:	78 6d                	js     80100684 <printint+0x84>
    x = xx;
80100617:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
8010061e:	89 c1                	mov    %eax,%ecx
  i = 0;
80100620:	31 db                	xor    %ebx,%ebx
80100622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    buf[i++] = digits[x % base];
80100628:	89 c8                	mov    %ecx,%eax
8010062a:	31 d2                	xor    %edx,%edx
8010062c:	89 de                	mov    %ebx,%esi
8010062e:	89 cf                	mov    %ecx,%edi
80100630:	f7 75 d4             	divl   -0x2c(%ebp)
80100633:	8d 5b 01             	lea    0x1(%ebx),%ebx
80100636:	0f b6 92 30 80 10 80 	movzbl -0x7fef7fd0(%edx),%edx
  }while((x /= base) != 0);
8010063d:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
8010063f:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
80100643:	3b 7d d4             	cmp    -0x2c(%ebp),%edi
80100646:	73 e0                	jae    80100628 <printint+0x28>
  if(sign)
80100648:	8b 4d d0             	mov    -0x30(%ebp),%ecx
8010064b:	85 c9                	test   %ecx,%ecx
8010064d:	74 0c                	je     8010065b <printint+0x5b>
    buf[i++] = '-';
8010064f:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
80100654:	89 de                	mov    %ebx,%esi
    buf[i++] = '-';
80100656:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while(--i >= 0)
8010065b:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
8010065f:	0f be c2             	movsbl %dl,%eax
  if(panicked){
80100662:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100668:	85 d2                	test   %edx,%edx
8010066a:	74 04                	je     80100670 <printint+0x70>
8010066c:	fa                   	cli    
    for(;;)
8010066d:	eb fe                	jmp    8010066d <printint+0x6d>
8010066f:	90                   	nop
80100670:	e8 8b fd ff ff       	call   80100400 <consputc.part.0>
  while(--i >= 0)
80100675:	8d 45 d7             	lea    -0x29(%ebp),%eax
80100678:	39 c3                	cmp    %eax,%ebx
8010067a:	74 0e                	je     8010068a <printint+0x8a>
    consputc(buf[i]);
8010067c:	0f be 03             	movsbl (%ebx),%eax
8010067f:	83 eb 01             	sub    $0x1,%ebx
80100682:	eb de                	jmp    80100662 <printint+0x62>
    x = -xx;
80100684:	f7 d8                	neg    %eax
80100686:	89 c1                	mov    %eax,%ecx
80100688:	eb 96                	jmp    80100620 <printint+0x20>
}
8010068a:	83 c4 2c             	add    $0x2c,%esp
8010068d:	5b                   	pop    %ebx
8010068e:	5e                   	pop    %esi
8010068f:	5f                   	pop    %edi
80100690:	5d                   	pop    %ebp
80100691:	c3                   	ret    
80100692:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801006a0 <cprintf>:
{
801006a0:	55                   	push   %ebp
801006a1:	89 e5                	mov    %esp,%ebp
801006a3:	57                   	push   %edi
801006a4:	56                   	push   %esi
801006a5:	53                   	push   %ebx
801006a6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006a9:	a1 54 ff 10 80       	mov    0x8010ff54,%eax
801006ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(locking)
801006b1:	85 c0                	test   %eax,%eax
801006b3:	0f 85 27 01 00 00    	jne    801007e0 <cprintf+0x140>
  if (fmt == 0)
801006b9:	8b 75 08             	mov    0x8(%ebp),%esi
801006bc:	85 f6                	test   %esi,%esi
801006be:	0f 84 ac 01 00 00    	je     80100870 <cprintf+0x1d0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006c4:	0f b6 06             	movzbl (%esi),%eax
  argp = (uint*)(void*)(&fmt + 1);
801006c7:	8d 7d 0c             	lea    0xc(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006ca:	31 db                	xor    %ebx,%ebx
801006cc:	85 c0                	test   %eax,%eax
801006ce:	74 56                	je     80100726 <cprintf+0x86>
    if(c != '%'){
801006d0:	83 f8 25             	cmp    $0x25,%eax
801006d3:	0f 85 cf 00 00 00    	jne    801007a8 <cprintf+0x108>
    c = fmt[++i] & 0xff;
801006d9:	83 c3 01             	add    $0x1,%ebx
801006dc:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
801006e0:	85 d2                	test   %edx,%edx
801006e2:	74 42                	je     80100726 <cprintf+0x86>
    switch(c){
801006e4:	83 fa 70             	cmp    $0x70,%edx
801006e7:	0f 84 90 00 00 00    	je     8010077d <cprintf+0xdd>
801006ed:	7f 51                	jg     80100740 <cprintf+0xa0>
801006ef:	83 fa 25             	cmp    $0x25,%edx
801006f2:	0f 84 c0 00 00 00    	je     801007b8 <cprintf+0x118>
801006f8:	83 fa 64             	cmp    $0x64,%edx
801006fb:	0f 85 f4 00 00 00    	jne    801007f5 <cprintf+0x155>
      printint(*argp++, 10, 1);
80100701:	8d 47 04             	lea    0x4(%edi),%eax
80100704:	b9 01 00 00 00       	mov    $0x1,%ecx
80100709:	ba 0a 00 00 00       	mov    $0xa,%edx
8010070e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100711:	8b 07                	mov    (%edi),%eax
80100713:	e8 e8 fe ff ff       	call   80100600 <printint>
80100718:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010071b:	83 c3 01             	add    $0x1,%ebx
8010071e:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100722:	85 c0                	test   %eax,%eax
80100724:	75 aa                	jne    801006d0 <cprintf+0x30>
  if(locking)
80100726:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100729:	85 c0                	test   %eax,%eax
8010072b:	0f 85 22 01 00 00    	jne    80100853 <cprintf+0x1b3>
}
80100731:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100734:	5b                   	pop    %ebx
80100735:	5e                   	pop    %esi
80100736:	5f                   	pop    %edi
80100737:	5d                   	pop    %ebp
80100738:	c3                   	ret    
80100739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100740:	83 fa 73             	cmp    $0x73,%edx
80100743:	75 33                	jne    80100778 <cprintf+0xd8>
      if((s = (char*)*argp++) == 0)
80100745:	8d 47 04             	lea    0x4(%edi),%eax
80100748:	8b 3f                	mov    (%edi),%edi
8010074a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010074d:	85 ff                	test   %edi,%edi
8010074f:	0f 84 e3 00 00 00    	je     80100838 <cprintf+0x198>
      for(; *s; s++)
80100755:	0f be 07             	movsbl (%edi),%eax
80100758:	84 c0                	test   %al,%al
8010075a:	0f 84 08 01 00 00    	je     80100868 <cprintf+0x1c8>
  if(panicked){
80100760:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100766:	85 d2                	test   %edx,%edx
80100768:	0f 84 b2 00 00 00    	je     80100820 <cprintf+0x180>
8010076e:	fa                   	cli    
    for(;;)
8010076f:	eb fe                	jmp    8010076f <cprintf+0xcf>
80100771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100778:	83 fa 78             	cmp    $0x78,%edx
8010077b:	75 78                	jne    801007f5 <cprintf+0x155>
      printint(*argp++, 16, 0);
8010077d:	8d 47 04             	lea    0x4(%edi),%eax
80100780:	31 c9                	xor    %ecx,%ecx
80100782:	ba 10 00 00 00       	mov    $0x10,%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100787:	83 c3 01             	add    $0x1,%ebx
      printint(*argp++, 16, 0);
8010078a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010078d:	8b 07                	mov    (%edi),%eax
8010078f:	e8 6c fe ff ff       	call   80100600 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100794:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      printint(*argp++, 16, 0);
80100798:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010079b:	85 c0                	test   %eax,%eax
8010079d:	0f 85 2d ff ff ff    	jne    801006d0 <cprintf+0x30>
801007a3:	eb 81                	jmp    80100726 <cprintf+0x86>
801007a5:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
801007a8:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
801007ae:	85 c9                	test   %ecx,%ecx
801007b0:	74 14                	je     801007c6 <cprintf+0x126>
801007b2:	fa                   	cli    
    for(;;)
801007b3:	eb fe                	jmp    801007b3 <cprintf+0x113>
801007b5:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
801007b8:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
801007bd:	85 c0                	test   %eax,%eax
801007bf:	75 6c                	jne    8010082d <cprintf+0x18d>
801007c1:	b8 25 00 00 00       	mov    $0x25,%eax
801007c6:	e8 35 fc ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007cb:	83 c3 01             	add    $0x1,%ebx
801007ce:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801007d2:	85 c0                	test   %eax,%eax
801007d4:	0f 85 f6 fe ff ff    	jne    801006d0 <cprintf+0x30>
801007da:	e9 47 ff ff ff       	jmp    80100726 <cprintf+0x86>
801007df:	90                   	nop
    acquire(&cons.lock);
801007e0:	83 ec 0c             	sub    $0xc,%esp
801007e3:	68 20 ff 10 80       	push   $0x8010ff20
801007e8:	e8 c3 49 00 00       	call   801051b0 <acquire>
801007ed:	83 c4 10             	add    $0x10,%esp
801007f0:	e9 c4 fe ff ff       	jmp    801006b9 <cprintf+0x19>
  if(panicked){
801007f5:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
801007fb:	85 c9                	test   %ecx,%ecx
801007fd:	75 31                	jne    80100830 <cprintf+0x190>
801007ff:	b8 25 00 00 00       	mov    $0x25,%eax
80100804:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100807:	e8 f4 fb ff ff       	call   80100400 <consputc.part.0>
8010080c:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100812:	85 d2                	test   %edx,%edx
80100814:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100817:	74 2e                	je     80100847 <cprintf+0x1a7>
80100819:	fa                   	cli    
    for(;;)
8010081a:	eb fe                	jmp    8010081a <cprintf+0x17a>
8010081c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100820:	e8 db fb ff ff       	call   80100400 <consputc.part.0>
      for(; *s; s++)
80100825:	83 c7 01             	add    $0x1,%edi
80100828:	e9 28 ff ff ff       	jmp    80100755 <cprintf+0xb5>
8010082d:	fa                   	cli    
    for(;;)
8010082e:	eb fe                	jmp    8010082e <cprintf+0x18e>
80100830:	fa                   	cli    
80100831:	eb fe                	jmp    80100831 <cprintf+0x191>
80100833:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100837:	90                   	nop
        s = "(null)";
80100838:	bf 18 80 10 80       	mov    $0x80108018,%edi
      for(; *s; s++)
8010083d:	b8 28 00 00 00       	mov    $0x28,%eax
80100842:	e9 19 ff ff ff       	jmp    80100760 <cprintf+0xc0>
80100847:	89 d0                	mov    %edx,%eax
80100849:	e8 b2 fb ff ff       	call   80100400 <consputc.part.0>
8010084e:	e9 c8 fe ff ff       	jmp    8010071b <cprintf+0x7b>
    release(&cons.lock);
80100853:	83 ec 0c             	sub    $0xc,%esp
80100856:	68 20 ff 10 80       	push   $0x8010ff20
8010085b:	e8 f0 48 00 00       	call   80105150 <release>
80100860:	83 c4 10             	add    $0x10,%esp
}
80100863:	e9 c9 fe ff ff       	jmp    80100731 <cprintf+0x91>
      if((s = (char*)*argp++) == 0)
80100868:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010086b:	e9 ab fe ff ff       	jmp    8010071b <cprintf+0x7b>
    panic("null fmt");
80100870:	83 ec 0c             	sub    $0xc,%esp
80100873:	68 1f 80 10 80       	push   $0x8010801f
80100878:	e8 03 fb ff ff       	call   80100380 <panic>
8010087d:	8d 76 00             	lea    0x0(%esi),%esi

80100880 <consoleintr>:
{
80100880:	55                   	push   %ebp
80100881:	89 e5                	mov    %esp,%ebp
80100883:	57                   	push   %edi
80100884:	56                   	push   %esi
  int c, doprocdump = 0;
80100885:	31 f6                	xor    %esi,%esi
{
80100887:	53                   	push   %ebx
80100888:	83 ec 18             	sub    $0x18,%esp
8010088b:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquire(&cons.lock);
8010088e:	68 20 ff 10 80       	push   $0x8010ff20
80100893:	e8 18 49 00 00       	call   801051b0 <acquire>
  while((c = getc()) >= 0){
80100898:	83 c4 10             	add    $0x10,%esp
8010089b:	eb 1a                	jmp    801008b7 <consoleintr+0x37>
8010089d:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
801008a0:	83 fb 08             	cmp    $0x8,%ebx
801008a3:	0f 84 d7 00 00 00    	je     80100980 <consoleintr+0x100>
801008a9:	83 fb 10             	cmp    $0x10,%ebx
801008ac:	0f 85 32 01 00 00    	jne    801009e4 <consoleintr+0x164>
801008b2:	be 01 00 00 00       	mov    $0x1,%esi
  while((c = getc()) >= 0){
801008b7:	ff d7                	call   *%edi
801008b9:	89 c3                	mov    %eax,%ebx
801008bb:	85 c0                	test   %eax,%eax
801008bd:	0f 88 05 01 00 00    	js     801009c8 <consoleintr+0x148>
    switch(c){
801008c3:	83 fb 15             	cmp    $0x15,%ebx
801008c6:	74 78                	je     80100940 <consoleintr+0xc0>
801008c8:	7e d6                	jle    801008a0 <consoleintr+0x20>
801008ca:	83 fb 7f             	cmp    $0x7f,%ebx
801008cd:	0f 84 ad 00 00 00    	je     80100980 <consoleintr+0x100>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008d3:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801008d8:	89 c2                	mov    %eax,%edx
801008da:	2b 15 00 ff 10 80    	sub    0x8010ff00,%edx
801008e0:	83 fa 7f             	cmp    $0x7f,%edx
801008e3:	77 d2                	ja     801008b7 <consoleintr+0x37>
        input.buf[input.e++ % INPUT_BUF] = c;
801008e5:	8d 48 01             	lea    0x1(%eax),%ecx
  if(panicked){
801008e8:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
801008ee:	83 e0 7f             	and    $0x7f,%eax
801008f1:	89 0d 08 ff 10 80    	mov    %ecx,0x8010ff08
        c = (c == '\r') ? '\n' : c;
801008f7:	83 fb 0d             	cmp    $0xd,%ebx
801008fa:	0f 84 13 01 00 00    	je     80100a13 <consoleintr+0x193>
        input.buf[input.e++ % INPUT_BUF] = c;
80100900:	88 98 80 fe 10 80    	mov    %bl,-0x7fef0180(%eax)
  if(panicked){
80100906:	85 d2                	test   %edx,%edx
80100908:	0f 85 10 01 00 00    	jne    80100a1e <consoleintr+0x19e>
8010090e:	89 d8                	mov    %ebx,%eax
80100910:	e8 eb fa ff ff       	call   80100400 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100915:	83 fb 0a             	cmp    $0xa,%ebx
80100918:	0f 84 14 01 00 00    	je     80100a32 <consoleintr+0x1b2>
8010091e:	83 fb 04             	cmp    $0x4,%ebx
80100921:	0f 84 0b 01 00 00    	je     80100a32 <consoleintr+0x1b2>
80100927:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
8010092c:	83 e8 80             	sub    $0xffffff80,%eax
8010092f:	39 05 08 ff 10 80    	cmp    %eax,0x8010ff08
80100935:	75 80                	jne    801008b7 <consoleintr+0x37>
80100937:	e9 fb 00 00 00       	jmp    80100a37 <consoleintr+0x1b7>
8010093c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      while(input.e != input.w &&
80100940:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100945:	39 05 04 ff 10 80    	cmp    %eax,0x8010ff04
8010094b:	0f 84 66 ff ff ff    	je     801008b7 <consoleintr+0x37>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100951:	83 e8 01             	sub    $0x1,%eax
80100954:	89 c2                	mov    %eax,%edx
80100956:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100959:	80 ba 80 fe 10 80 0a 	cmpb   $0xa,-0x7fef0180(%edx)
80100960:	0f 84 51 ff ff ff    	je     801008b7 <consoleintr+0x37>
  if(panicked){
80100966:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
        input.e--;
8010096c:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
80100971:	85 d2                	test   %edx,%edx
80100973:	74 33                	je     801009a8 <consoleintr+0x128>
80100975:	fa                   	cli    
    for(;;)
80100976:	eb fe                	jmp    80100976 <consoleintr+0xf6>
80100978:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010097f:	90                   	nop
      if(input.e != input.w){
80100980:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100985:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
8010098b:	0f 84 26 ff ff ff    	je     801008b7 <consoleintr+0x37>
        input.e--;
80100991:	83 e8 01             	sub    $0x1,%eax
80100994:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
80100999:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
8010099e:	85 c0                	test   %eax,%eax
801009a0:	74 56                	je     801009f8 <consoleintr+0x178>
801009a2:	fa                   	cli    
    for(;;)
801009a3:	eb fe                	jmp    801009a3 <consoleintr+0x123>
801009a5:	8d 76 00             	lea    0x0(%esi),%esi
801009a8:	b8 00 01 00 00       	mov    $0x100,%eax
801009ad:	e8 4e fa ff ff       	call   80100400 <consputc.part.0>
      while(input.e != input.w &&
801009b2:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801009b7:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801009bd:	75 92                	jne    80100951 <consoleintr+0xd1>
801009bf:	e9 f3 fe ff ff       	jmp    801008b7 <consoleintr+0x37>
801009c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
801009c8:	83 ec 0c             	sub    $0xc,%esp
801009cb:	68 20 ff 10 80       	push   $0x8010ff20
801009d0:	e8 7b 47 00 00       	call   80105150 <release>
  if(doprocdump) {
801009d5:	83 c4 10             	add    $0x10,%esp
801009d8:	85 f6                	test   %esi,%esi
801009da:	75 2b                	jne    80100a07 <consoleintr+0x187>
}
801009dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009df:	5b                   	pop    %ebx
801009e0:	5e                   	pop    %esi
801009e1:	5f                   	pop    %edi
801009e2:	5d                   	pop    %ebp
801009e3:	c3                   	ret    
      if(c != 0 && input.e-input.r < INPUT_BUF){
801009e4:	85 db                	test   %ebx,%ebx
801009e6:	0f 84 cb fe ff ff    	je     801008b7 <consoleintr+0x37>
801009ec:	e9 e2 fe ff ff       	jmp    801008d3 <consoleintr+0x53>
801009f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801009f8:	b8 00 01 00 00       	mov    $0x100,%eax
801009fd:	e8 fe f9 ff ff       	call   80100400 <consputc.part.0>
80100a02:	e9 b0 fe ff ff       	jmp    801008b7 <consoleintr+0x37>
}
80100a07:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a0a:	5b                   	pop    %ebx
80100a0b:	5e                   	pop    %esi
80100a0c:	5f                   	pop    %edi
80100a0d:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100a0e:	e9 3d 3b 00 00       	jmp    80104550 <procdump>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a13:	c6 80 80 fe 10 80 0a 	movb   $0xa,-0x7fef0180(%eax)
  if(panicked){
80100a1a:	85 d2                	test   %edx,%edx
80100a1c:	74 0a                	je     80100a28 <consoleintr+0x1a8>
80100a1e:	fa                   	cli    
    for(;;)
80100a1f:	eb fe                	jmp    80100a1f <consoleintr+0x19f>
80100a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a28:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a2d:	e8 ce f9 ff ff       	call   80100400 <consputc.part.0>
          input.w = input.e;
80100a32:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
          wakeup(&input.r);
80100a37:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a3a:	a3 04 ff 10 80       	mov    %eax,0x8010ff04
          wakeup(&input.r);
80100a3f:	68 00 ff 10 80       	push   $0x8010ff00
80100a44:	e8 27 3a 00 00       	call   80104470 <wakeup>
80100a49:	83 c4 10             	add    $0x10,%esp
80100a4c:	e9 66 fe ff ff       	jmp    801008b7 <consoleintr+0x37>
80100a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a5f:	90                   	nop

80100a60 <consoleinit>:

void
consoleinit(void)
{
80100a60:	55                   	push   %ebp
80100a61:	89 e5                	mov    %esp,%ebp
80100a63:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100a66:	68 28 80 10 80       	push   $0x80108028
80100a6b:	68 20 ff 10 80       	push   $0x8010ff20
80100a70:	e8 6b 45 00 00       	call   80104fe0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100a75:	58                   	pop    %eax
80100a76:	5a                   	pop    %edx
80100a77:	6a 00                	push   $0x0
80100a79:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100a7b:	c7 05 0c 09 11 80 90 	movl   $0x80100590,0x8011090c
80100a82:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100a85:	c7 05 08 09 11 80 80 	movl   $0x80100280,0x80110908
80100a8c:	02 10 80 
  cons.locking = 1;
80100a8f:	c7 05 54 ff 10 80 01 	movl   $0x1,0x8010ff54
80100a96:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100a99:	e8 f2 19 00 00       	call   80102490 <ioapicenable>
}
80100a9e:	83 c4 10             	add    $0x10,%esp
80100aa1:	c9                   	leave  
80100aa2:	c3                   	ret    
80100aa3:	66 90                	xchg   %ax,%ax
80100aa5:	66 90                	xchg   %ax,%ax
80100aa7:	66 90                	xchg   %ax,%ax
80100aa9:	66 90                	xchg   %ax,%ax
80100aab:	66 90                	xchg   %ax,%ax
80100aad:	66 90                	xchg   %ax,%ax
80100aaf:	90                   	nop

80100ab0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100ab0:	55                   	push   %ebp
80100ab1:	89 e5                	mov    %esp,%ebp
80100ab3:	57                   	push   %edi
80100ab4:	56                   	push   %esi
80100ab5:	53                   	push   %ebx
80100ab6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100abc:	e8 ff 2e 00 00       	call   801039c0 <myproc>
80100ac1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100ac7:	e8 a4 22 00 00       	call   80102d70 <begin_op>

  if((ip = namei(path)) == 0){
80100acc:	83 ec 0c             	sub    $0xc,%esp
80100acf:	ff 75 08             	push   0x8(%ebp)
80100ad2:	e8 d9 15 00 00       	call   801020b0 <namei>
80100ad7:	83 c4 10             	add    $0x10,%esp
80100ada:	85 c0                	test   %eax,%eax
80100adc:	0f 84 0c 03 00 00    	je     80100dee <exec+0x33e>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100ae2:	83 ec 0c             	sub    $0xc,%esp
80100ae5:	89 c3                	mov    %eax,%ebx
80100ae7:	50                   	push   %eax
80100ae8:	e8 a3 0c 00 00       	call   80101790 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100aed:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100af3:	6a 34                	push   $0x34
80100af5:	6a 00                	push   $0x0
80100af7:	50                   	push   %eax
80100af8:	53                   	push   %ebx
80100af9:	e8 a2 0f 00 00       	call   80101aa0 <readi>
80100afe:	83 c4 20             	add    $0x20,%esp
80100b01:	83 f8 34             	cmp    $0x34,%eax
80100b04:	74 22                	je     80100b28 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100b06:	83 ec 0c             	sub    $0xc,%esp
80100b09:	53                   	push   %ebx
80100b0a:	e8 11 0f 00 00       	call   80101a20 <iunlockput>
    end_op();
80100b0f:	e8 cc 22 00 00       	call   80102de0 <end_op>
80100b14:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100b17:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100b1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100b1f:	5b                   	pop    %ebx
80100b20:	5e                   	pop    %esi
80100b21:	5f                   	pop    %edi
80100b22:	5d                   	pop    %ebp
80100b23:	c3                   	ret    
80100b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100b28:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b2f:	45 4c 46 
80100b32:	75 d2                	jne    80100b06 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100b34:	e8 37 71 00 00       	call   80107c70 <setupkvm>
80100b39:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b3f:	85 c0                	test   %eax,%eax
80100b41:	74 c3                	je     80100b06 <exec+0x56>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b43:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b4a:	00 
80100b4b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100b51:	0f 84 b6 02 00 00    	je     80100e0d <exec+0x35d>
  sz = 0;
80100b57:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100b5e:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b61:	31 ff                	xor    %edi,%edi
80100b63:	e9 8e 00 00 00       	jmp    80100bf6 <exec+0x146>
80100b68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100b6f:	90                   	nop
    if(ph.type != ELF_PROG_LOAD)
80100b70:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b77:	75 6c                	jne    80100be5 <exec+0x135>
    if(ph.memsz < ph.filesz)
80100b79:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b7f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b85:	0f 82 87 00 00 00    	jb     80100c12 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100b8b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b91:	72 7f                	jb     80100c12 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b93:	83 ec 04             	sub    $0x4,%esp
80100b96:	50                   	push   %eax
80100b97:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100b9d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100ba3:	e8 e8 6e 00 00       	call   80107a90 <allocuvm>
80100ba8:	83 c4 10             	add    $0x10,%esp
80100bab:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100bb1:	85 c0                	test   %eax,%eax
80100bb3:	74 5d                	je     80100c12 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80100bb5:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bbb:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100bc0:	75 50                	jne    80100c12 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100bc2:	83 ec 0c             	sub    $0xc,%esp
80100bc5:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100bcb:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100bd1:	53                   	push   %ebx
80100bd2:	50                   	push   %eax
80100bd3:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100bd9:	e8 c2 6d 00 00       	call   801079a0 <loaduvm>
80100bde:	83 c4 20             	add    $0x20,%esp
80100be1:	85 c0                	test   %eax,%eax
80100be3:	78 2d                	js     80100c12 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100be5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100bec:	83 c7 01             	add    $0x1,%edi
80100bef:	83 c6 20             	add    $0x20,%esi
80100bf2:	39 f8                	cmp    %edi,%eax
80100bf4:	7e 3a                	jle    80100c30 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bf6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100bfc:	6a 20                	push   $0x20
80100bfe:	56                   	push   %esi
80100bff:	50                   	push   %eax
80100c00:	53                   	push   %ebx
80100c01:	e8 9a 0e 00 00       	call   80101aa0 <readi>
80100c06:	83 c4 10             	add    $0x10,%esp
80100c09:	83 f8 20             	cmp    $0x20,%eax
80100c0c:	0f 84 5e ff ff ff    	je     80100b70 <exec+0xc0>
    freevm(pgdir);
80100c12:	83 ec 0c             	sub    $0xc,%esp
80100c15:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c1b:	e8 d0 6f 00 00       	call   80107bf0 <freevm>
  if(ip){
80100c20:	83 c4 10             	add    $0x10,%esp
80100c23:	e9 de fe ff ff       	jmp    80100b06 <exec+0x56>
80100c28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c2f:	90                   	nop
  sz = PGROUNDUP(sz);
80100c30:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100c36:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100c3c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c42:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100c48:	83 ec 0c             	sub    $0xc,%esp
80100c4b:	53                   	push   %ebx
80100c4c:	e8 cf 0d 00 00       	call   80101a20 <iunlockput>
  end_op();
80100c51:	e8 8a 21 00 00       	call   80102de0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c56:	83 c4 0c             	add    $0xc,%esp
80100c59:	56                   	push   %esi
80100c5a:	57                   	push   %edi
80100c5b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100c61:	57                   	push   %edi
80100c62:	e8 29 6e 00 00       	call   80107a90 <allocuvm>
80100c67:	83 c4 10             	add    $0x10,%esp
80100c6a:	89 c6                	mov    %eax,%esi
80100c6c:	85 c0                	test   %eax,%eax
80100c6e:	0f 84 94 00 00 00    	je     80100d08 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c74:	83 ec 08             	sub    $0x8,%esp
80100c77:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100c7d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c7f:	50                   	push   %eax
80100c80:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80100c81:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c83:	e8 88 70 00 00       	call   80107d10 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c88:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c8b:	83 c4 10             	add    $0x10,%esp
80100c8e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c94:	8b 00                	mov    (%eax),%eax
80100c96:	85 c0                	test   %eax,%eax
80100c98:	0f 84 8b 00 00 00    	je     80100d29 <exec+0x279>
80100c9e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100ca4:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100caa:	eb 23                	jmp    80100ccf <exec+0x21f>
80100cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100cb0:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100cb3:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100cba:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100cbd:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100cc3:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100cc6:	85 c0                	test   %eax,%eax
80100cc8:	74 59                	je     80100d23 <exec+0x273>
    if(argc >= MAXARG)
80100cca:	83 ff 20             	cmp    $0x20,%edi
80100ccd:	74 39                	je     80100d08 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ccf:	83 ec 0c             	sub    $0xc,%esp
80100cd2:	50                   	push   %eax
80100cd3:	e8 98 47 00 00       	call   80105470 <strlen>
80100cd8:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cda:	58                   	pop    %eax
80100cdb:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cde:	83 eb 01             	sub    $0x1,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ce1:	ff 34 b8             	push   (%eax,%edi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ce4:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ce7:	e8 84 47 00 00       	call   80105470 <strlen>
80100cec:	83 c0 01             	add    $0x1,%eax
80100cef:	50                   	push   %eax
80100cf0:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cf3:	ff 34 b8             	push   (%eax,%edi,4)
80100cf6:	53                   	push   %ebx
80100cf7:	56                   	push   %esi
80100cf8:	e8 e3 71 00 00       	call   80107ee0 <copyout>
80100cfd:	83 c4 20             	add    $0x20,%esp
80100d00:	85 c0                	test   %eax,%eax
80100d02:	79 ac                	jns    80100cb0 <exec+0x200>
80100d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    freevm(pgdir);
80100d08:	83 ec 0c             	sub    $0xc,%esp
80100d0b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d11:	e8 da 6e 00 00       	call   80107bf0 <freevm>
80100d16:	83 c4 10             	add    $0x10,%esp
  return -1;
80100d19:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100d1e:	e9 f9 fd ff ff       	jmp    80100b1c <exec+0x6c>
80100d23:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d29:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100d30:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100d32:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100d39:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d3d:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100d3f:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80100d42:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80100d48:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d4a:	50                   	push   %eax
80100d4b:	52                   	push   %edx
80100d4c:	53                   	push   %ebx
80100d4d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80100d53:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d5a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d5d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d63:	e8 78 71 00 00       	call   80107ee0 <copyout>
80100d68:	83 c4 10             	add    $0x10,%esp
80100d6b:	85 c0                	test   %eax,%eax
80100d6d:	78 99                	js     80100d08 <exec+0x258>
  for(last=s=path; *s; s++)
80100d6f:	8b 45 08             	mov    0x8(%ebp),%eax
80100d72:	8b 55 08             	mov    0x8(%ebp),%edx
80100d75:	0f b6 00             	movzbl (%eax),%eax
80100d78:	84 c0                	test   %al,%al
80100d7a:	74 13                	je     80100d8f <exec+0x2df>
80100d7c:	89 d1                	mov    %edx,%ecx
80100d7e:	66 90                	xchg   %ax,%ax
      last = s+1;
80100d80:	83 c1 01             	add    $0x1,%ecx
80100d83:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100d85:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80100d88:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100d8b:	84 c0                	test   %al,%al
80100d8d:	75 f1                	jne    80100d80 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100d8f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80100d95:	83 ec 04             	sub    $0x4,%esp
80100d98:	6a 10                	push   $0x10
80100d9a:	89 f8                	mov    %edi,%eax
80100d9c:	52                   	push   %edx
80100d9d:	83 c0 6c             	add    $0x6c,%eax
80100da0:	50                   	push   %eax
80100da1:	e8 8a 46 00 00       	call   80105430 <safestrcpy>
  curproc->pgdir = pgdir;
80100da6:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100dac:	89 f8                	mov    %edi,%eax
80100dae:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80100db1:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80100db3:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100db6:	89 c1                	mov    %eax,%ecx
80100db8:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100dbe:	8b 40 18             	mov    0x18(%eax),%eax
80100dc1:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100dc4:	8b 41 18             	mov    0x18(%ecx),%eax
80100dc7:	89 58 44             	mov    %ebx,0x44(%eax)
  curproc->q = 1;
80100dca:	c7 81 88 00 00 00 01 	movl   $0x1,0x88(%ecx)
80100dd1:	00 00 00 
  switchuvm(curproc);
80100dd4:	89 0c 24             	mov    %ecx,(%esp)
80100dd7:	e8 34 6a 00 00       	call   80107810 <switchuvm>
  freevm(oldpgdir);
80100ddc:	89 3c 24             	mov    %edi,(%esp)
80100ddf:	e8 0c 6e 00 00       	call   80107bf0 <freevm>
  return 0;
80100de4:	83 c4 10             	add    $0x10,%esp
80100de7:	31 c0                	xor    %eax,%eax
80100de9:	e9 2e fd ff ff       	jmp    80100b1c <exec+0x6c>
    end_op();
80100dee:	e8 ed 1f 00 00       	call   80102de0 <end_op>
    cprintf("exec: fail\n");
80100df3:	83 ec 0c             	sub    $0xc,%esp
80100df6:	68 41 80 10 80       	push   $0x80108041
80100dfb:	e8 a0 f8 ff ff       	call   801006a0 <cprintf>
    return -1;
80100e00:	83 c4 10             	add    $0x10,%esp
80100e03:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100e08:	e9 0f fd ff ff       	jmp    80100b1c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e0d:	be 00 20 00 00       	mov    $0x2000,%esi
80100e12:	31 ff                	xor    %edi,%edi
80100e14:	e9 2f fe ff ff       	jmp    80100c48 <exec+0x198>
80100e19:	66 90                	xchg   %ax,%ax
80100e1b:	66 90                	xchg   %ax,%ax
80100e1d:	66 90                	xchg   %ax,%ax
80100e1f:	90                   	nop

80100e20 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100e20:	55                   	push   %ebp
80100e21:	89 e5                	mov    %esp,%ebp
80100e23:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100e26:	68 4d 80 10 80       	push   $0x8010804d
80100e2b:	68 60 ff 10 80       	push   $0x8010ff60
80100e30:	e8 ab 41 00 00       	call   80104fe0 <initlock>
}
80100e35:	83 c4 10             	add    $0x10,%esp
80100e38:	c9                   	leave  
80100e39:	c3                   	ret    
80100e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100e40 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e40:	55                   	push   %ebp
80100e41:	89 e5                	mov    %esp,%ebp
80100e43:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e44:	bb 94 ff 10 80       	mov    $0x8010ff94,%ebx
{
80100e49:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e4c:	68 60 ff 10 80       	push   $0x8010ff60
80100e51:	e8 5a 43 00 00       	call   801051b0 <acquire>
80100e56:	83 c4 10             	add    $0x10,%esp
80100e59:	eb 10                	jmp    80100e6b <filealloc+0x2b>
80100e5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e5f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e60:	83 c3 18             	add    $0x18,%ebx
80100e63:	81 fb f4 08 11 80    	cmp    $0x801108f4,%ebx
80100e69:	74 25                	je     80100e90 <filealloc+0x50>
    if(f->ref == 0){
80100e6b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e6e:	85 c0                	test   %eax,%eax
80100e70:	75 ee                	jne    80100e60 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e72:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100e75:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e7c:	68 60 ff 10 80       	push   $0x8010ff60
80100e81:	e8 ca 42 00 00       	call   80105150 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e86:	89 d8                	mov    %ebx,%eax
      return f;
80100e88:	83 c4 10             	add    $0x10,%esp
}
80100e8b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e8e:	c9                   	leave  
80100e8f:	c3                   	ret    
  release(&ftable.lock);
80100e90:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100e93:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100e95:	68 60 ff 10 80       	push   $0x8010ff60
80100e9a:	e8 b1 42 00 00       	call   80105150 <release>
}
80100e9f:	89 d8                	mov    %ebx,%eax
  return 0;
80100ea1:	83 c4 10             	add    $0x10,%esp
}
80100ea4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ea7:	c9                   	leave  
80100ea8:	c3                   	ret    
80100ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100eb0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100eb0:	55                   	push   %ebp
80100eb1:	89 e5                	mov    %esp,%ebp
80100eb3:	53                   	push   %ebx
80100eb4:	83 ec 10             	sub    $0x10,%esp
80100eb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100eba:	68 60 ff 10 80       	push   $0x8010ff60
80100ebf:	e8 ec 42 00 00       	call   801051b0 <acquire>
  if(f->ref < 1)
80100ec4:	8b 43 04             	mov    0x4(%ebx),%eax
80100ec7:	83 c4 10             	add    $0x10,%esp
80100eca:	85 c0                	test   %eax,%eax
80100ecc:	7e 1a                	jle    80100ee8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100ece:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100ed1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100ed4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100ed7:	68 60 ff 10 80       	push   $0x8010ff60
80100edc:	e8 6f 42 00 00       	call   80105150 <release>
  return f;
}
80100ee1:	89 d8                	mov    %ebx,%eax
80100ee3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ee6:	c9                   	leave  
80100ee7:	c3                   	ret    
    panic("filedup");
80100ee8:	83 ec 0c             	sub    $0xc,%esp
80100eeb:	68 54 80 10 80       	push   $0x80108054
80100ef0:	e8 8b f4 ff ff       	call   80100380 <panic>
80100ef5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f00 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100f00:	55                   	push   %ebp
80100f01:	89 e5                	mov    %esp,%ebp
80100f03:	57                   	push   %edi
80100f04:	56                   	push   %esi
80100f05:	53                   	push   %ebx
80100f06:	83 ec 28             	sub    $0x28,%esp
80100f09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100f0c:	68 60 ff 10 80       	push   $0x8010ff60
80100f11:	e8 9a 42 00 00       	call   801051b0 <acquire>
  if(f->ref < 1)
80100f16:	8b 53 04             	mov    0x4(%ebx),%edx
80100f19:	83 c4 10             	add    $0x10,%esp
80100f1c:	85 d2                	test   %edx,%edx
80100f1e:	0f 8e a5 00 00 00    	jle    80100fc9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80100f24:	83 ea 01             	sub    $0x1,%edx
80100f27:	89 53 04             	mov    %edx,0x4(%ebx)
80100f2a:	75 44                	jne    80100f70 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100f2c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100f30:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100f33:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80100f35:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100f3b:	8b 73 0c             	mov    0xc(%ebx),%esi
80100f3e:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f41:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100f44:	68 60 ff 10 80       	push   $0x8010ff60
  ff = *f;
80100f49:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f4c:	e8 ff 41 00 00       	call   80105150 <release>

  if(ff.type == FD_PIPE)
80100f51:	83 c4 10             	add    $0x10,%esp
80100f54:	83 ff 01             	cmp    $0x1,%edi
80100f57:	74 57                	je     80100fb0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100f59:	83 ff 02             	cmp    $0x2,%edi
80100f5c:	74 2a                	je     80100f88 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f5e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f61:	5b                   	pop    %ebx
80100f62:	5e                   	pop    %esi
80100f63:	5f                   	pop    %edi
80100f64:	5d                   	pop    %ebp
80100f65:	c3                   	ret    
80100f66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f6d:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ftable.lock);
80100f70:	c7 45 08 60 ff 10 80 	movl   $0x8010ff60,0x8(%ebp)
}
80100f77:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f7a:	5b                   	pop    %ebx
80100f7b:	5e                   	pop    %esi
80100f7c:	5f                   	pop    %edi
80100f7d:	5d                   	pop    %ebp
    release(&ftable.lock);
80100f7e:	e9 cd 41 00 00       	jmp    80105150 <release>
80100f83:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f87:	90                   	nop
    begin_op();
80100f88:	e8 e3 1d 00 00       	call   80102d70 <begin_op>
    iput(ff.ip);
80100f8d:	83 ec 0c             	sub    $0xc,%esp
80100f90:	ff 75 e0             	push   -0x20(%ebp)
80100f93:	e8 28 09 00 00       	call   801018c0 <iput>
    end_op();
80100f98:	83 c4 10             	add    $0x10,%esp
}
80100f9b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f9e:	5b                   	pop    %ebx
80100f9f:	5e                   	pop    %esi
80100fa0:	5f                   	pop    %edi
80100fa1:	5d                   	pop    %ebp
    end_op();
80100fa2:	e9 39 1e 00 00       	jmp    80102de0 <end_op>
80100fa7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100fae:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80100fb0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100fb4:	83 ec 08             	sub    $0x8,%esp
80100fb7:	53                   	push   %ebx
80100fb8:	56                   	push   %esi
80100fb9:	e8 82 25 00 00       	call   80103540 <pipeclose>
80100fbe:	83 c4 10             	add    $0x10,%esp
}
80100fc1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fc4:	5b                   	pop    %ebx
80100fc5:	5e                   	pop    %esi
80100fc6:	5f                   	pop    %edi
80100fc7:	5d                   	pop    %ebp
80100fc8:	c3                   	ret    
    panic("fileclose");
80100fc9:	83 ec 0c             	sub    $0xc,%esp
80100fcc:	68 5c 80 10 80       	push   $0x8010805c
80100fd1:	e8 aa f3 ff ff       	call   80100380 <panic>
80100fd6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100fdd:	8d 76 00             	lea    0x0(%esi),%esi

80100fe0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100fe0:	55                   	push   %ebp
80100fe1:	89 e5                	mov    %esp,%ebp
80100fe3:	53                   	push   %ebx
80100fe4:	83 ec 04             	sub    $0x4,%esp
80100fe7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100fea:	83 3b 02             	cmpl   $0x2,(%ebx)
80100fed:	75 31                	jne    80101020 <filestat+0x40>
    ilock(f->ip);
80100fef:	83 ec 0c             	sub    $0xc,%esp
80100ff2:	ff 73 10             	push   0x10(%ebx)
80100ff5:	e8 96 07 00 00       	call   80101790 <ilock>
    stati(f->ip, st);
80100ffa:	58                   	pop    %eax
80100ffb:	5a                   	pop    %edx
80100ffc:	ff 75 0c             	push   0xc(%ebp)
80100fff:	ff 73 10             	push   0x10(%ebx)
80101002:	e8 69 0a 00 00       	call   80101a70 <stati>
    iunlock(f->ip);
80101007:	59                   	pop    %ecx
80101008:	ff 73 10             	push   0x10(%ebx)
8010100b:	e8 60 08 00 00       	call   80101870 <iunlock>
    return 0;
  }
  return -1;
}
80101010:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101013:	83 c4 10             	add    $0x10,%esp
80101016:	31 c0                	xor    %eax,%eax
}
80101018:	c9                   	leave  
80101019:	c3                   	ret    
8010101a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101020:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101023:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101028:	c9                   	leave  
80101029:	c3                   	ret    
8010102a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101030 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101030:	55                   	push   %ebp
80101031:	89 e5                	mov    %esp,%ebp
80101033:	57                   	push   %edi
80101034:	56                   	push   %esi
80101035:	53                   	push   %ebx
80101036:	83 ec 0c             	sub    $0xc,%esp
80101039:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010103c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010103f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101042:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101046:	74 60                	je     801010a8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101048:	8b 03                	mov    (%ebx),%eax
8010104a:	83 f8 01             	cmp    $0x1,%eax
8010104d:	74 41                	je     80101090 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010104f:	83 f8 02             	cmp    $0x2,%eax
80101052:	75 5b                	jne    801010af <fileread+0x7f>
    ilock(f->ip);
80101054:	83 ec 0c             	sub    $0xc,%esp
80101057:	ff 73 10             	push   0x10(%ebx)
8010105a:	e8 31 07 00 00       	call   80101790 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010105f:	57                   	push   %edi
80101060:	ff 73 14             	push   0x14(%ebx)
80101063:	56                   	push   %esi
80101064:	ff 73 10             	push   0x10(%ebx)
80101067:	e8 34 0a 00 00       	call   80101aa0 <readi>
8010106c:	83 c4 20             	add    $0x20,%esp
8010106f:	89 c6                	mov    %eax,%esi
80101071:	85 c0                	test   %eax,%eax
80101073:	7e 03                	jle    80101078 <fileread+0x48>
      f->off += r;
80101075:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101078:	83 ec 0c             	sub    $0xc,%esp
8010107b:	ff 73 10             	push   0x10(%ebx)
8010107e:	e8 ed 07 00 00       	call   80101870 <iunlock>
    return r;
80101083:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101086:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101089:	89 f0                	mov    %esi,%eax
8010108b:	5b                   	pop    %ebx
8010108c:	5e                   	pop    %esi
8010108d:	5f                   	pop    %edi
8010108e:	5d                   	pop    %ebp
8010108f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101090:	8b 43 0c             	mov    0xc(%ebx),%eax
80101093:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101096:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101099:	5b                   	pop    %ebx
8010109a:	5e                   	pop    %esi
8010109b:	5f                   	pop    %edi
8010109c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010109d:	e9 3e 26 00 00       	jmp    801036e0 <piperead>
801010a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801010a8:	be ff ff ff ff       	mov    $0xffffffff,%esi
801010ad:	eb d7                	jmp    80101086 <fileread+0x56>
  panic("fileread");
801010af:	83 ec 0c             	sub    $0xc,%esp
801010b2:	68 66 80 10 80       	push   $0x80108066
801010b7:	e8 c4 f2 ff ff       	call   80100380 <panic>
801010bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801010c0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801010c0:	55                   	push   %ebp
801010c1:	89 e5                	mov    %esp,%ebp
801010c3:	57                   	push   %edi
801010c4:	56                   	push   %esi
801010c5:	53                   	push   %ebx
801010c6:	83 ec 1c             	sub    $0x1c,%esp
801010c9:	8b 45 0c             	mov    0xc(%ebp),%eax
801010cc:	8b 5d 08             	mov    0x8(%ebp),%ebx
801010cf:	89 45 dc             	mov    %eax,-0x24(%ebp)
801010d2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
801010d5:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
801010d9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801010dc:	0f 84 bd 00 00 00    	je     8010119f <filewrite+0xdf>
    return -1;
  if(f->type == FD_PIPE)
801010e2:	8b 03                	mov    (%ebx),%eax
801010e4:	83 f8 01             	cmp    $0x1,%eax
801010e7:	0f 84 bf 00 00 00    	je     801011ac <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010ed:	83 f8 02             	cmp    $0x2,%eax
801010f0:	0f 85 c8 00 00 00    	jne    801011be <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801010f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801010f9:	31 f6                	xor    %esi,%esi
    while(i < n){
801010fb:	85 c0                	test   %eax,%eax
801010fd:	7f 30                	jg     8010112f <filewrite+0x6f>
801010ff:	e9 94 00 00 00       	jmp    80101198 <filewrite+0xd8>
80101104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101108:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
8010110b:	83 ec 0c             	sub    $0xc,%esp
8010110e:	ff 73 10             	push   0x10(%ebx)
        f->off += r;
80101111:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101114:	e8 57 07 00 00       	call   80101870 <iunlock>
      end_op();
80101119:	e8 c2 1c 00 00       	call   80102de0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
8010111e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101121:	83 c4 10             	add    $0x10,%esp
80101124:	39 c7                	cmp    %eax,%edi
80101126:	75 5c                	jne    80101184 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
80101128:	01 fe                	add    %edi,%esi
    while(i < n){
8010112a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010112d:	7e 69                	jle    80101198 <filewrite+0xd8>
      int n1 = n - i;
8010112f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101132:	b8 00 06 00 00       	mov    $0x600,%eax
80101137:	29 f7                	sub    %esi,%edi
80101139:	39 c7                	cmp    %eax,%edi
8010113b:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
8010113e:	e8 2d 1c 00 00       	call   80102d70 <begin_op>
      ilock(f->ip);
80101143:	83 ec 0c             	sub    $0xc,%esp
80101146:	ff 73 10             	push   0x10(%ebx)
80101149:	e8 42 06 00 00       	call   80101790 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010114e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101151:	57                   	push   %edi
80101152:	ff 73 14             	push   0x14(%ebx)
80101155:	01 f0                	add    %esi,%eax
80101157:	50                   	push   %eax
80101158:	ff 73 10             	push   0x10(%ebx)
8010115b:	e8 40 0a 00 00       	call   80101ba0 <writei>
80101160:	83 c4 20             	add    $0x20,%esp
80101163:	85 c0                	test   %eax,%eax
80101165:	7f a1                	jg     80101108 <filewrite+0x48>
      iunlock(f->ip);
80101167:	83 ec 0c             	sub    $0xc,%esp
8010116a:	ff 73 10             	push   0x10(%ebx)
8010116d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101170:	e8 fb 06 00 00       	call   80101870 <iunlock>
      end_op();
80101175:	e8 66 1c 00 00       	call   80102de0 <end_op>
      if(r < 0)
8010117a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010117d:	83 c4 10             	add    $0x10,%esp
80101180:	85 c0                	test   %eax,%eax
80101182:	75 1b                	jne    8010119f <filewrite+0xdf>
        panic("short filewrite");
80101184:	83 ec 0c             	sub    $0xc,%esp
80101187:	68 6f 80 10 80       	push   $0x8010806f
8010118c:	e8 ef f1 ff ff       	call   80100380 <panic>
80101191:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101198:	89 f0                	mov    %esi,%eax
8010119a:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
8010119d:	74 05                	je     801011a4 <filewrite+0xe4>
8010119f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
801011a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011a7:	5b                   	pop    %ebx
801011a8:	5e                   	pop    %esi
801011a9:	5f                   	pop    %edi
801011aa:	5d                   	pop    %ebp
801011ab:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
801011ac:	8b 43 0c             	mov    0xc(%ebx),%eax
801011af:	89 45 08             	mov    %eax,0x8(%ebp)
}
801011b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011b5:	5b                   	pop    %ebx
801011b6:	5e                   	pop    %esi
801011b7:	5f                   	pop    %edi
801011b8:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801011b9:	e9 22 24 00 00       	jmp    801035e0 <pipewrite>
  panic("filewrite");
801011be:	83 ec 0c             	sub    $0xc,%esp
801011c1:	68 75 80 10 80       	push   $0x80108075
801011c6:	e8 b5 f1 ff ff       	call   80100380 <panic>
801011cb:	66 90                	xchg   %ax,%ax
801011cd:	66 90                	xchg   %ax,%ax
801011cf:	90                   	nop

801011d0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801011d0:	55                   	push   %ebp
801011d1:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
801011d3:	89 d0                	mov    %edx,%eax
801011d5:	c1 e8 0c             	shr    $0xc,%eax
801011d8:	03 05 cc 25 11 80    	add    0x801125cc,%eax
{
801011de:	89 e5                	mov    %esp,%ebp
801011e0:	56                   	push   %esi
801011e1:	53                   	push   %ebx
801011e2:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
801011e4:	83 ec 08             	sub    $0x8,%esp
801011e7:	50                   	push   %eax
801011e8:	51                   	push   %ecx
801011e9:	e8 e2 ee ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801011ee:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801011f0:	c1 fb 03             	sar    $0x3,%ebx
801011f3:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
801011f6:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
801011f8:	83 e1 07             	and    $0x7,%ecx
801011fb:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80101200:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
80101206:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80101208:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
8010120d:	85 c1                	test   %eax,%ecx
8010120f:	74 23                	je     80101234 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101211:	f7 d0                	not    %eax
  log_write(bp);
80101213:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101216:	21 c8                	and    %ecx,%eax
80101218:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010121c:	56                   	push   %esi
8010121d:	e8 2e 1d 00 00       	call   80102f50 <log_write>
  brelse(bp);
80101222:	89 34 24             	mov    %esi,(%esp)
80101225:	e8 c6 ef ff ff       	call   801001f0 <brelse>
}
8010122a:	83 c4 10             	add    $0x10,%esp
8010122d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101230:	5b                   	pop    %ebx
80101231:	5e                   	pop    %esi
80101232:	5d                   	pop    %ebp
80101233:	c3                   	ret    
    panic("freeing free block");
80101234:	83 ec 0c             	sub    $0xc,%esp
80101237:	68 7f 80 10 80       	push   $0x8010807f
8010123c:	e8 3f f1 ff ff       	call   80100380 <panic>
80101241:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101248:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010124f:	90                   	nop

80101250 <balloc>:
{
80101250:	55                   	push   %ebp
80101251:	89 e5                	mov    %esp,%ebp
80101253:	57                   	push   %edi
80101254:	56                   	push   %esi
80101255:	53                   	push   %ebx
80101256:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101259:	8b 0d b4 25 11 80    	mov    0x801125b4,%ecx
{
8010125f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101262:	85 c9                	test   %ecx,%ecx
80101264:	0f 84 87 00 00 00    	je     801012f1 <balloc+0xa1>
8010126a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101271:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101274:	83 ec 08             	sub    $0x8,%esp
80101277:	89 f0                	mov    %esi,%eax
80101279:	c1 f8 0c             	sar    $0xc,%eax
8010127c:	03 05 cc 25 11 80    	add    0x801125cc,%eax
80101282:	50                   	push   %eax
80101283:	ff 75 d8             	push   -0x28(%ebp)
80101286:	e8 45 ee ff ff       	call   801000d0 <bread>
8010128b:	83 c4 10             	add    $0x10,%esp
8010128e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101291:	a1 b4 25 11 80       	mov    0x801125b4,%eax
80101296:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101299:	31 c0                	xor    %eax,%eax
8010129b:	eb 2f                	jmp    801012cc <balloc+0x7c>
8010129d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801012a0:	89 c1                	mov    %eax,%ecx
801012a2:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801012a7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801012aa:	83 e1 07             	and    $0x7,%ecx
801012ad:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801012af:	89 c1                	mov    %eax,%ecx
801012b1:	c1 f9 03             	sar    $0x3,%ecx
801012b4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801012b9:	89 fa                	mov    %edi,%edx
801012bb:	85 df                	test   %ebx,%edi
801012bd:	74 41                	je     80101300 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801012bf:	83 c0 01             	add    $0x1,%eax
801012c2:	83 c6 01             	add    $0x1,%esi
801012c5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801012ca:	74 05                	je     801012d1 <balloc+0x81>
801012cc:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801012cf:	77 cf                	ja     801012a0 <balloc+0x50>
    brelse(bp);
801012d1:	83 ec 0c             	sub    $0xc,%esp
801012d4:	ff 75 e4             	push   -0x1c(%ebp)
801012d7:	e8 14 ef ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801012dc:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801012e3:	83 c4 10             	add    $0x10,%esp
801012e6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801012e9:	39 05 b4 25 11 80    	cmp    %eax,0x801125b4
801012ef:	77 80                	ja     80101271 <balloc+0x21>
  panic("balloc: out of blocks");
801012f1:	83 ec 0c             	sub    $0xc,%esp
801012f4:	68 92 80 10 80       	push   $0x80108092
801012f9:	e8 82 f0 ff ff       	call   80100380 <panic>
801012fe:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101300:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101303:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101306:	09 da                	or     %ebx,%edx
80101308:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010130c:	57                   	push   %edi
8010130d:	e8 3e 1c 00 00       	call   80102f50 <log_write>
        brelse(bp);
80101312:	89 3c 24             	mov    %edi,(%esp)
80101315:	e8 d6 ee ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
8010131a:	58                   	pop    %eax
8010131b:	5a                   	pop    %edx
8010131c:	56                   	push   %esi
8010131d:	ff 75 d8             	push   -0x28(%ebp)
80101320:	e8 ab ed ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101325:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101328:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
8010132a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010132d:	68 00 02 00 00       	push   $0x200
80101332:	6a 00                	push   $0x0
80101334:	50                   	push   %eax
80101335:	e8 36 3f 00 00       	call   80105270 <memset>
  log_write(bp);
8010133a:	89 1c 24             	mov    %ebx,(%esp)
8010133d:	e8 0e 1c 00 00       	call   80102f50 <log_write>
  brelse(bp);
80101342:	89 1c 24             	mov    %ebx,(%esp)
80101345:	e8 a6 ee ff ff       	call   801001f0 <brelse>
}
8010134a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010134d:	89 f0                	mov    %esi,%eax
8010134f:	5b                   	pop    %ebx
80101350:	5e                   	pop    %esi
80101351:	5f                   	pop    %edi
80101352:	5d                   	pop    %ebp
80101353:	c3                   	ret    
80101354:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010135b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010135f:	90                   	nop

80101360 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101360:	55                   	push   %ebp
80101361:	89 e5                	mov    %esp,%ebp
80101363:	57                   	push   %edi
80101364:	89 c7                	mov    %eax,%edi
80101366:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101367:	31 f6                	xor    %esi,%esi
{
80101369:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010136a:	bb 94 09 11 80       	mov    $0x80110994,%ebx
{
8010136f:	83 ec 28             	sub    $0x28,%esp
80101372:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101375:	68 60 09 11 80       	push   $0x80110960
8010137a:	e8 31 3e 00 00       	call   801051b0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010137f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101382:	83 c4 10             	add    $0x10,%esp
80101385:	eb 1b                	jmp    801013a2 <iget+0x42>
80101387:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010138e:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101390:	39 3b                	cmp    %edi,(%ebx)
80101392:	74 6c                	je     80101400 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101394:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010139a:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
801013a0:	73 26                	jae    801013c8 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013a2:	8b 43 08             	mov    0x8(%ebx),%eax
801013a5:	85 c0                	test   %eax,%eax
801013a7:	7f e7                	jg     80101390 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801013a9:	85 f6                	test   %esi,%esi
801013ab:	75 e7                	jne    80101394 <iget+0x34>
801013ad:	85 c0                	test   %eax,%eax
801013af:	75 76                	jne    80101427 <iget+0xc7>
801013b1:	89 de                	mov    %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013b3:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013b9:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
801013bf:	72 e1                	jb     801013a2 <iget+0x42>
801013c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801013c8:	85 f6                	test   %esi,%esi
801013ca:	74 79                	je     80101445 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801013cc:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801013cf:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801013d1:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801013d4:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801013db:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801013e2:	68 60 09 11 80       	push   $0x80110960
801013e7:	e8 64 3d 00 00       	call   80105150 <release>

  return ip;
801013ec:	83 c4 10             	add    $0x10,%esp
}
801013ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013f2:	89 f0                	mov    %esi,%eax
801013f4:	5b                   	pop    %ebx
801013f5:	5e                   	pop    %esi
801013f6:	5f                   	pop    %edi
801013f7:	5d                   	pop    %ebp
801013f8:	c3                   	ret    
801013f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101400:	39 53 04             	cmp    %edx,0x4(%ebx)
80101403:	75 8f                	jne    80101394 <iget+0x34>
      release(&icache.lock);
80101405:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101408:	83 c0 01             	add    $0x1,%eax
      return ip;
8010140b:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
8010140d:	68 60 09 11 80       	push   $0x80110960
      ip->ref++;
80101412:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101415:	e8 36 3d 00 00       	call   80105150 <release>
      return ip;
8010141a:	83 c4 10             	add    $0x10,%esp
}
8010141d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101420:	89 f0                	mov    %esi,%eax
80101422:	5b                   	pop    %ebx
80101423:	5e                   	pop    %esi
80101424:	5f                   	pop    %edi
80101425:	5d                   	pop    %ebp
80101426:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101427:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010142d:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
80101433:	73 10                	jae    80101445 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101435:	8b 43 08             	mov    0x8(%ebx),%eax
80101438:	85 c0                	test   %eax,%eax
8010143a:	0f 8f 50 ff ff ff    	jg     80101390 <iget+0x30>
80101440:	e9 68 ff ff ff       	jmp    801013ad <iget+0x4d>
    panic("iget: no inodes");
80101445:	83 ec 0c             	sub    $0xc,%esp
80101448:	68 a8 80 10 80       	push   $0x801080a8
8010144d:	e8 2e ef ff ff       	call   80100380 <panic>
80101452:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101460 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101460:	55                   	push   %ebp
80101461:	89 e5                	mov    %esp,%ebp
80101463:	57                   	push   %edi
80101464:	56                   	push   %esi
80101465:	89 c6                	mov    %eax,%esi
80101467:	53                   	push   %ebx
80101468:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010146b:	83 fa 0b             	cmp    $0xb,%edx
8010146e:	0f 86 8c 00 00 00    	jbe    80101500 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101474:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101477:	83 fb 7f             	cmp    $0x7f,%ebx
8010147a:	0f 87 a2 00 00 00    	ja     80101522 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101480:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101486:	85 c0                	test   %eax,%eax
80101488:	74 5e                	je     801014e8 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010148a:	83 ec 08             	sub    $0x8,%esp
8010148d:	50                   	push   %eax
8010148e:	ff 36                	push   (%esi)
80101490:	e8 3b ec ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101495:	83 c4 10             	add    $0x10,%esp
80101498:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010149c:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
8010149e:	8b 3b                	mov    (%ebx),%edi
801014a0:	85 ff                	test   %edi,%edi
801014a2:	74 1c                	je     801014c0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801014a4:	83 ec 0c             	sub    $0xc,%esp
801014a7:	52                   	push   %edx
801014a8:	e8 43 ed ff ff       	call   801001f0 <brelse>
801014ad:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
801014b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014b3:	89 f8                	mov    %edi,%eax
801014b5:	5b                   	pop    %ebx
801014b6:	5e                   	pop    %esi
801014b7:	5f                   	pop    %edi
801014b8:	5d                   	pop    %ebp
801014b9:	c3                   	ret    
801014ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801014c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
801014c3:	8b 06                	mov    (%esi),%eax
801014c5:	e8 86 fd ff ff       	call   80101250 <balloc>
      log_write(bp);
801014ca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801014cd:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801014d0:	89 03                	mov    %eax,(%ebx)
801014d2:	89 c7                	mov    %eax,%edi
      log_write(bp);
801014d4:	52                   	push   %edx
801014d5:	e8 76 1a 00 00       	call   80102f50 <log_write>
801014da:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801014dd:	83 c4 10             	add    $0x10,%esp
801014e0:	eb c2                	jmp    801014a4 <bmap+0x44>
801014e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801014e8:	8b 06                	mov    (%esi),%eax
801014ea:	e8 61 fd ff ff       	call   80101250 <balloc>
801014ef:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801014f5:	eb 93                	jmp    8010148a <bmap+0x2a>
801014f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801014fe:	66 90                	xchg   %ax,%ax
    if((addr = ip->addrs[bn]) == 0)
80101500:	8d 5a 14             	lea    0x14(%edx),%ebx
80101503:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80101507:	85 ff                	test   %edi,%edi
80101509:	75 a5                	jne    801014b0 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010150b:	8b 00                	mov    (%eax),%eax
8010150d:	e8 3e fd ff ff       	call   80101250 <balloc>
80101512:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101516:	89 c7                	mov    %eax,%edi
}
80101518:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010151b:	5b                   	pop    %ebx
8010151c:	89 f8                	mov    %edi,%eax
8010151e:	5e                   	pop    %esi
8010151f:	5f                   	pop    %edi
80101520:	5d                   	pop    %ebp
80101521:	c3                   	ret    
  panic("bmap: out of range");
80101522:	83 ec 0c             	sub    $0xc,%esp
80101525:	68 b8 80 10 80       	push   $0x801080b8
8010152a:	e8 51 ee ff ff       	call   80100380 <panic>
8010152f:	90                   	nop

80101530 <readsb>:
{
80101530:	55                   	push   %ebp
80101531:	89 e5                	mov    %esp,%ebp
80101533:	56                   	push   %esi
80101534:	53                   	push   %ebx
80101535:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101538:	83 ec 08             	sub    $0x8,%esp
8010153b:	6a 01                	push   $0x1
8010153d:	ff 75 08             	push   0x8(%ebp)
80101540:	e8 8b eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101545:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101548:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010154a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010154d:	6a 1c                	push   $0x1c
8010154f:	50                   	push   %eax
80101550:	56                   	push   %esi
80101551:	e8 ba 3d 00 00       	call   80105310 <memmove>
  brelse(bp);
80101556:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101559:	83 c4 10             	add    $0x10,%esp
}
8010155c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010155f:	5b                   	pop    %ebx
80101560:	5e                   	pop    %esi
80101561:	5d                   	pop    %ebp
  brelse(bp);
80101562:	e9 89 ec ff ff       	jmp    801001f0 <brelse>
80101567:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010156e:	66 90                	xchg   %ax,%ax

80101570 <iinit>:
{
80101570:	55                   	push   %ebp
80101571:	89 e5                	mov    %esp,%ebp
80101573:	53                   	push   %ebx
80101574:	bb a0 09 11 80       	mov    $0x801109a0,%ebx
80101579:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010157c:	68 cb 80 10 80       	push   $0x801080cb
80101581:	68 60 09 11 80       	push   $0x80110960
80101586:	e8 55 3a 00 00       	call   80104fe0 <initlock>
  for(i = 0; i < NINODE; i++) {
8010158b:	83 c4 10             	add    $0x10,%esp
8010158e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101590:	83 ec 08             	sub    $0x8,%esp
80101593:	68 d2 80 10 80       	push   $0x801080d2
80101598:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80101599:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010159f:	e8 0c 39 00 00       	call   80104eb0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801015a4:	83 c4 10             	add    $0x10,%esp
801015a7:	81 fb c0 25 11 80    	cmp    $0x801125c0,%ebx
801015ad:	75 e1                	jne    80101590 <iinit+0x20>
  bp = bread(dev, 1);
801015af:	83 ec 08             	sub    $0x8,%esp
801015b2:	6a 01                	push   $0x1
801015b4:	ff 75 08             	push   0x8(%ebp)
801015b7:	e8 14 eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801015bc:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801015bf:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801015c1:	8d 40 5c             	lea    0x5c(%eax),%eax
801015c4:	6a 1c                	push   $0x1c
801015c6:	50                   	push   %eax
801015c7:	68 b4 25 11 80       	push   $0x801125b4
801015cc:	e8 3f 3d 00 00       	call   80105310 <memmove>
  brelse(bp);
801015d1:	89 1c 24             	mov    %ebx,(%esp)
801015d4:	e8 17 ec ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801015d9:	ff 35 cc 25 11 80    	push   0x801125cc
801015df:	ff 35 c8 25 11 80    	push   0x801125c8
801015e5:	ff 35 c4 25 11 80    	push   0x801125c4
801015eb:	ff 35 c0 25 11 80    	push   0x801125c0
801015f1:	ff 35 bc 25 11 80    	push   0x801125bc
801015f7:	ff 35 b8 25 11 80    	push   0x801125b8
801015fd:	ff 35 b4 25 11 80    	push   0x801125b4
80101603:	68 38 81 10 80       	push   $0x80108138
80101608:	e8 93 f0 ff ff       	call   801006a0 <cprintf>
}
8010160d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101610:	83 c4 30             	add    $0x30,%esp
80101613:	c9                   	leave  
80101614:	c3                   	ret    
80101615:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010161c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101620 <ialloc>:
{
80101620:	55                   	push   %ebp
80101621:	89 e5                	mov    %esp,%ebp
80101623:	57                   	push   %edi
80101624:	56                   	push   %esi
80101625:	53                   	push   %ebx
80101626:	83 ec 1c             	sub    $0x1c,%esp
80101629:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010162c:	83 3d bc 25 11 80 01 	cmpl   $0x1,0x801125bc
{
80101633:	8b 75 08             	mov    0x8(%ebp),%esi
80101636:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101639:	0f 86 91 00 00 00    	jbe    801016d0 <ialloc+0xb0>
8010163f:	bf 01 00 00 00       	mov    $0x1,%edi
80101644:	eb 21                	jmp    80101667 <ialloc+0x47>
80101646:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010164d:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80101650:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101653:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101656:	53                   	push   %ebx
80101657:	e8 94 eb ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010165c:	83 c4 10             	add    $0x10,%esp
8010165f:	3b 3d bc 25 11 80    	cmp    0x801125bc,%edi
80101665:	73 69                	jae    801016d0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101667:	89 f8                	mov    %edi,%eax
80101669:	83 ec 08             	sub    $0x8,%esp
8010166c:	c1 e8 03             	shr    $0x3,%eax
8010166f:	03 05 c8 25 11 80    	add    0x801125c8,%eax
80101675:	50                   	push   %eax
80101676:	56                   	push   %esi
80101677:	e8 54 ea ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010167c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010167f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101681:	89 f8                	mov    %edi,%eax
80101683:	83 e0 07             	and    $0x7,%eax
80101686:	c1 e0 06             	shl    $0x6,%eax
80101689:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010168d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101691:	75 bd                	jne    80101650 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101693:	83 ec 04             	sub    $0x4,%esp
80101696:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101699:	6a 40                	push   $0x40
8010169b:	6a 00                	push   $0x0
8010169d:	51                   	push   %ecx
8010169e:	e8 cd 3b 00 00       	call   80105270 <memset>
      dip->type = type;
801016a3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801016a7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801016aa:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801016ad:	89 1c 24             	mov    %ebx,(%esp)
801016b0:	e8 9b 18 00 00       	call   80102f50 <log_write>
      brelse(bp);
801016b5:	89 1c 24             	mov    %ebx,(%esp)
801016b8:	e8 33 eb ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
801016bd:	83 c4 10             	add    $0x10,%esp
}
801016c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801016c3:	89 fa                	mov    %edi,%edx
}
801016c5:	5b                   	pop    %ebx
      return iget(dev, inum);
801016c6:	89 f0                	mov    %esi,%eax
}
801016c8:	5e                   	pop    %esi
801016c9:	5f                   	pop    %edi
801016ca:	5d                   	pop    %ebp
      return iget(dev, inum);
801016cb:	e9 90 fc ff ff       	jmp    80101360 <iget>
  panic("ialloc: no inodes");
801016d0:	83 ec 0c             	sub    $0xc,%esp
801016d3:	68 d8 80 10 80       	push   $0x801080d8
801016d8:	e8 a3 ec ff ff       	call   80100380 <panic>
801016dd:	8d 76 00             	lea    0x0(%esi),%esi

801016e0 <iupdate>:
{
801016e0:	55                   	push   %ebp
801016e1:	89 e5                	mov    %esp,%ebp
801016e3:	56                   	push   %esi
801016e4:	53                   	push   %ebx
801016e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016e8:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016eb:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016ee:	83 ec 08             	sub    $0x8,%esp
801016f1:	c1 e8 03             	shr    $0x3,%eax
801016f4:	03 05 c8 25 11 80    	add    0x801125c8,%eax
801016fa:	50                   	push   %eax
801016fb:	ff 73 a4             	push   -0x5c(%ebx)
801016fe:	e8 cd e9 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101703:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101707:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010170a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010170c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010170f:	83 e0 07             	and    $0x7,%eax
80101712:	c1 e0 06             	shl    $0x6,%eax
80101715:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101719:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010171c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101720:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101723:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101727:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010172b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010172f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101733:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101737:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010173a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010173d:	6a 34                	push   $0x34
8010173f:	53                   	push   %ebx
80101740:	50                   	push   %eax
80101741:	e8 ca 3b 00 00       	call   80105310 <memmove>
  log_write(bp);
80101746:	89 34 24             	mov    %esi,(%esp)
80101749:	e8 02 18 00 00       	call   80102f50 <log_write>
  brelse(bp);
8010174e:	89 75 08             	mov    %esi,0x8(%ebp)
80101751:	83 c4 10             	add    $0x10,%esp
}
80101754:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101757:	5b                   	pop    %ebx
80101758:	5e                   	pop    %esi
80101759:	5d                   	pop    %ebp
  brelse(bp);
8010175a:	e9 91 ea ff ff       	jmp    801001f0 <brelse>
8010175f:	90                   	nop

80101760 <idup>:
{
80101760:	55                   	push   %ebp
80101761:	89 e5                	mov    %esp,%ebp
80101763:	53                   	push   %ebx
80101764:	83 ec 10             	sub    $0x10,%esp
80101767:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010176a:	68 60 09 11 80       	push   $0x80110960
8010176f:	e8 3c 3a 00 00       	call   801051b0 <acquire>
  ip->ref++;
80101774:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101778:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010177f:	e8 cc 39 00 00       	call   80105150 <release>
}
80101784:	89 d8                	mov    %ebx,%eax
80101786:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101789:	c9                   	leave  
8010178a:	c3                   	ret    
8010178b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010178f:	90                   	nop

80101790 <ilock>:
{
80101790:	55                   	push   %ebp
80101791:	89 e5                	mov    %esp,%ebp
80101793:	56                   	push   %esi
80101794:	53                   	push   %ebx
80101795:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101798:	85 db                	test   %ebx,%ebx
8010179a:	0f 84 b7 00 00 00    	je     80101857 <ilock+0xc7>
801017a0:	8b 53 08             	mov    0x8(%ebx),%edx
801017a3:	85 d2                	test   %edx,%edx
801017a5:	0f 8e ac 00 00 00    	jle    80101857 <ilock+0xc7>
  acquiresleep(&ip->lock);
801017ab:	83 ec 0c             	sub    $0xc,%esp
801017ae:	8d 43 0c             	lea    0xc(%ebx),%eax
801017b1:	50                   	push   %eax
801017b2:	e8 39 37 00 00       	call   80104ef0 <acquiresleep>
  if(ip->valid == 0){
801017b7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801017ba:	83 c4 10             	add    $0x10,%esp
801017bd:	85 c0                	test   %eax,%eax
801017bf:	74 0f                	je     801017d0 <ilock+0x40>
}
801017c1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017c4:	5b                   	pop    %ebx
801017c5:	5e                   	pop    %esi
801017c6:	5d                   	pop    %ebp
801017c7:	c3                   	ret    
801017c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801017cf:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017d0:	8b 43 04             	mov    0x4(%ebx),%eax
801017d3:	83 ec 08             	sub    $0x8,%esp
801017d6:	c1 e8 03             	shr    $0x3,%eax
801017d9:	03 05 c8 25 11 80    	add    0x801125c8,%eax
801017df:	50                   	push   %eax
801017e0:	ff 33                	push   (%ebx)
801017e2:	e8 e9 e8 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017e7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017ea:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801017ec:	8b 43 04             	mov    0x4(%ebx),%eax
801017ef:	83 e0 07             	and    $0x7,%eax
801017f2:	c1 e0 06             	shl    $0x6,%eax
801017f5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801017f9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017fc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801017ff:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101803:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101807:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010180b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010180f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101813:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101817:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010181b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010181e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101821:	6a 34                	push   $0x34
80101823:	50                   	push   %eax
80101824:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101827:	50                   	push   %eax
80101828:	e8 e3 3a 00 00       	call   80105310 <memmove>
    brelse(bp);
8010182d:	89 34 24             	mov    %esi,(%esp)
80101830:	e8 bb e9 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101835:	83 c4 10             	add    $0x10,%esp
80101838:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010183d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101844:	0f 85 77 ff ff ff    	jne    801017c1 <ilock+0x31>
      panic("ilock: no type");
8010184a:	83 ec 0c             	sub    $0xc,%esp
8010184d:	68 f0 80 10 80       	push   $0x801080f0
80101852:	e8 29 eb ff ff       	call   80100380 <panic>
    panic("ilock");
80101857:	83 ec 0c             	sub    $0xc,%esp
8010185a:	68 ea 80 10 80       	push   $0x801080ea
8010185f:	e8 1c eb ff ff       	call   80100380 <panic>
80101864:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010186b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010186f:	90                   	nop

80101870 <iunlock>:
{
80101870:	55                   	push   %ebp
80101871:	89 e5                	mov    %esp,%ebp
80101873:	56                   	push   %esi
80101874:	53                   	push   %ebx
80101875:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101878:	85 db                	test   %ebx,%ebx
8010187a:	74 28                	je     801018a4 <iunlock+0x34>
8010187c:	83 ec 0c             	sub    $0xc,%esp
8010187f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101882:	56                   	push   %esi
80101883:	e8 08 37 00 00       	call   80104f90 <holdingsleep>
80101888:	83 c4 10             	add    $0x10,%esp
8010188b:	85 c0                	test   %eax,%eax
8010188d:	74 15                	je     801018a4 <iunlock+0x34>
8010188f:	8b 43 08             	mov    0x8(%ebx),%eax
80101892:	85 c0                	test   %eax,%eax
80101894:	7e 0e                	jle    801018a4 <iunlock+0x34>
  releasesleep(&ip->lock);
80101896:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101899:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010189c:	5b                   	pop    %ebx
8010189d:	5e                   	pop    %esi
8010189e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010189f:	e9 ac 36 00 00       	jmp    80104f50 <releasesleep>
    panic("iunlock");
801018a4:	83 ec 0c             	sub    $0xc,%esp
801018a7:	68 ff 80 10 80       	push   $0x801080ff
801018ac:	e8 cf ea ff ff       	call   80100380 <panic>
801018b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018bf:	90                   	nop

801018c0 <iput>:
{
801018c0:	55                   	push   %ebp
801018c1:	89 e5                	mov    %esp,%ebp
801018c3:	57                   	push   %edi
801018c4:	56                   	push   %esi
801018c5:	53                   	push   %ebx
801018c6:	83 ec 28             	sub    $0x28,%esp
801018c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801018cc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801018cf:	57                   	push   %edi
801018d0:	e8 1b 36 00 00       	call   80104ef0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801018d5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801018d8:	83 c4 10             	add    $0x10,%esp
801018db:	85 d2                	test   %edx,%edx
801018dd:	74 07                	je     801018e6 <iput+0x26>
801018df:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801018e4:	74 32                	je     80101918 <iput+0x58>
  releasesleep(&ip->lock);
801018e6:	83 ec 0c             	sub    $0xc,%esp
801018e9:	57                   	push   %edi
801018ea:	e8 61 36 00 00       	call   80104f50 <releasesleep>
  acquire(&icache.lock);
801018ef:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
801018f6:	e8 b5 38 00 00       	call   801051b0 <acquire>
  ip->ref--;
801018fb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801018ff:	83 c4 10             	add    $0x10,%esp
80101902:	c7 45 08 60 09 11 80 	movl   $0x80110960,0x8(%ebp)
}
80101909:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010190c:	5b                   	pop    %ebx
8010190d:	5e                   	pop    %esi
8010190e:	5f                   	pop    %edi
8010190f:	5d                   	pop    %ebp
  release(&icache.lock);
80101910:	e9 3b 38 00 00       	jmp    80105150 <release>
80101915:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101918:	83 ec 0c             	sub    $0xc,%esp
8010191b:	68 60 09 11 80       	push   $0x80110960
80101920:	e8 8b 38 00 00       	call   801051b0 <acquire>
    int r = ip->ref;
80101925:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101928:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010192f:	e8 1c 38 00 00       	call   80105150 <release>
    if(r == 1){
80101934:	83 c4 10             	add    $0x10,%esp
80101937:	83 fe 01             	cmp    $0x1,%esi
8010193a:	75 aa                	jne    801018e6 <iput+0x26>
8010193c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101942:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101945:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101948:	89 cf                	mov    %ecx,%edi
8010194a:	eb 0b                	jmp    80101957 <iput+0x97>
8010194c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101950:	83 c6 04             	add    $0x4,%esi
80101953:	39 fe                	cmp    %edi,%esi
80101955:	74 19                	je     80101970 <iput+0xb0>
    if(ip->addrs[i]){
80101957:	8b 16                	mov    (%esi),%edx
80101959:	85 d2                	test   %edx,%edx
8010195b:	74 f3                	je     80101950 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010195d:	8b 03                	mov    (%ebx),%eax
8010195f:	e8 6c f8 ff ff       	call   801011d0 <bfree>
      ip->addrs[i] = 0;
80101964:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010196a:	eb e4                	jmp    80101950 <iput+0x90>
8010196c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101970:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101976:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101979:	85 c0                	test   %eax,%eax
8010197b:	75 2d                	jne    801019aa <iput+0xea>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010197d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101980:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101987:	53                   	push   %ebx
80101988:	e8 53 fd ff ff       	call   801016e0 <iupdate>
      ip->type = 0;
8010198d:	31 c0                	xor    %eax,%eax
8010198f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101993:	89 1c 24             	mov    %ebx,(%esp)
80101996:	e8 45 fd ff ff       	call   801016e0 <iupdate>
      ip->valid = 0;
8010199b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801019a2:	83 c4 10             	add    $0x10,%esp
801019a5:	e9 3c ff ff ff       	jmp    801018e6 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801019aa:	83 ec 08             	sub    $0x8,%esp
801019ad:	50                   	push   %eax
801019ae:	ff 33                	push   (%ebx)
801019b0:	e8 1b e7 ff ff       	call   801000d0 <bread>
801019b5:	89 7d e0             	mov    %edi,-0x20(%ebp)
801019b8:	83 c4 10             	add    $0x10,%esp
801019bb:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801019c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
801019c4:	8d 70 5c             	lea    0x5c(%eax),%esi
801019c7:	89 cf                	mov    %ecx,%edi
801019c9:	eb 0c                	jmp    801019d7 <iput+0x117>
801019cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801019cf:	90                   	nop
801019d0:	83 c6 04             	add    $0x4,%esi
801019d3:	39 f7                	cmp    %esi,%edi
801019d5:	74 0f                	je     801019e6 <iput+0x126>
      if(a[j])
801019d7:	8b 16                	mov    (%esi),%edx
801019d9:	85 d2                	test   %edx,%edx
801019db:	74 f3                	je     801019d0 <iput+0x110>
        bfree(ip->dev, a[j]);
801019dd:	8b 03                	mov    (%ebx),%eax
801019df:	e8 ec f7 ff ff       	call   801011d0 <bfree>
801019e4:	eb ea                	jmp    801019d0 <iput+0x110>
    brelse(bp);
801019e6:	83 ec 0c             	sub    $0xc,%esp
801019e9:	ff 75 e4             	push   -0x1c(%ebp)
801019ec:	8b 7d e0             	mov    -0x20(%ebp),%edi
801019ef:	e8 fc e7 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801019f4:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
801019fa:	8b 03                	mov    (%ebx),%eax
801019fc:	e8 cf f7 ff ff       	call   801011d0 <bfree>
    ip->addrs[NDIRECT] = 0;
80101a01:	83 c4 10             	add    $0x10,%esp
80101a04:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101a0b:	00 00 00 
80101a0e:	e9 6a ff ff ff       	jmp    8010197d <iput+0xbd>
80101a13:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101a20 <iunlockput>:
{
80101a20:	55                   	push   %ebp
80101a21:	89 e5                	mov    %esp,%ebp
80101a23:	56                   	push   %esi
80101a24:	53                   	push   %ebx
80101a25:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101a28:	85 db                	test   %ebx,%ebx
80101a2a:	74 34                	je     80101a60 <iunlockput+0x40>
80101a2c:	83 ec 0c             	sub    $0xc,%esp
80101a2f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101a32:	56                   	push   %esi
80101a33:	e8 58 35 00 00       	call   80104f90 <holdingsleep>
80101a38:	83 c4 10             	add    $0x10,%esp
80101a3b:	85 c0                	test   %eax,%eax
80101a3d:	74 21                	je     80101a60 <iunlockput+0x40>
80101a3f:	8b 43 08             	mov    0x8(%ebx),%eax
80101a42:	85 c0                	test   %eax,%eax
80101a44:	7e 1a                	jle    80101a60 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101a46:	83 ec 0c             	sub    $0xc,%esp
80101a49:	56                   	push   %esi
80101a4a:	e8 01 35 00 00       	call   80104f50 <releasesleep>
  iput(ip);
80101a4f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101a52:	83 c4 10             	add    $0x10,%esp
}
80101a55:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101a58:	5b                   	pop    %ebx
80101a59:	5e                   	pop    %esi
80101a5a:	5d                   	pop    %ebp
  iput(ip);
80101a5b:	e9 60 fe ff ff       	jmp    801018c0 <iput>
    panic("iunlock");
80101a60:	83 ec 0c             	sub    $0xc,%esp
80101a63:	68 ff 80 10 80       	push   $0x801080ff
80101a68:	e8 13 e9 ff ff       	call   80100380 <panic>
80101a6d:	8d 76 00             	lea    0x0(%esi),%esi

80101a70 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101a70:	55                   	push   %ebp
80101a71:	89 e5                	mov    %esp,%ebp
80101a73:	8b 55 08             	mov    0x8(%ebp),%edx
80101a76:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101a79:	8b 0a                	mov    (%edx),%ecx
80101a7b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101a7e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101a81:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101a84:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101a88:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101a8b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101a8f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101a93:	8b 52 58             	mov    0x58(%edx),%edx
80101a96:	89 50 10             	mov    %edx,0x10(%eax)
}
80101a99:	5d                   	pop    %ebp
80101a9a:	c3                   	ret    
80101a9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a9f:	90                   	nop

80101aa0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101aa0:	55                   	push   %ebp
80101aa1:	89 e5                	mov    %esp,%ebp
80101aa3:	57                   	push   %edi
80101aa4:	56                   	push   %esi
80101aa5:	53                   	push   %ebx
80101aa6:	83 ec 1c             	sub    $0x1c,%esp
80101aa9:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101aac:	8b 45 08             	mov    0x8(%ebp),%eax
80101aaf:	8b 75 10             	mov    0x10(%ebp),%esi
80101ab2:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101ab5:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ab8:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101abd:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101ac0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101ac3:	0f 84 a7 00 00 00    	je     80101b70 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101ac9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101acc:	8b 40 58             	mov    0x58(%eax),%eax
80101acf:	39 c6                	cmp    %eax,%esi
80101ad1:	0f 87 ba 00 00 00    	ja     80101b91 <readi+0xf1>
80101ad7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101ada:	31 c9                	xor    %ecx,%ecx
80101adc:	89 da                	mov    %ebx,%edx
80101ade:	01 f2                	add    %esi,%edx
80101ae0:	0f 92 c1             	setb   %cl
80101ae3:	89 cf                	mov    %ecx,%edi
80101ae5:	0f 82 a6 00 00 00    	jb     80101b91 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101aeb:	89 c1                	mov    %eax,%ecx
80101aed:	29 f1                	sub    %esi,%ecx
80101aef:	39 d0                	cmp    %edx,%eax
80101af1:	0f 43 cb             	cmovae %ebx,%ecx
80101af4:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101af7:	85 c9                	test   %ecx,%ecx
80101af9:	74 67                	je     80101b62 <readi+0xc2>
80101afb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101aff:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b00:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101b03:	89 f2                	mov    %esi,%edx
80101b05:	c1 ea 09             	shr    $0x9,%edx
80101b08:	89 d8                	mov    %ebx,%eax
80101b0a:	e8 51 f9 ff ff       	call   80101460 <bmap>
80101b0f:	83 ec 08             	sub    $0x8,%esp
80101b12:	50                   	push   %eax
80101b13:	ff 33                	push   (%ebx)
80101b15:	e8 b6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b1a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101b1d:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b22:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b24:	89 f0                	mov    %esi,%eax
80101b26:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b2b:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b2d:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101b30:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101b32:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b36:	39 d9                	cmp    %ebx,%ecx
80101b38:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b3b:	83 c4 0c             	add    $0xc,%esp
80101b3e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b3f:	01 df                	add    %ebx,%edi
80101b41:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101b43:	50                   	push   %eax
80101b44:	ff 75 e0             	push   -0x20(%ebp)
80101b47:	e8 c4 37 00 00       	call   80105310 <memmove>
    brelse(bp);
80101b4c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101b4f:	89 14 24             	mov    %edx,(%esp)
80101b52:	e8 99 e6 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b57:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101b5a:	83 c4 10             	add    $0x10,%esp
80101b5d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101b60:	77 9e                	ja     80101b00 <readi+0x60>
  }
  return n;
80101b62:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101b65:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b68:	5b                   	pop    %ebx
80101b69:	5e                   	pop    %esi
80101b6a:	5f                   	pop    %edi
80101b6b:	5d                   	pop    %ebp
80101b6c:	c3                   	ret    
80101b6d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101b70:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b74:	66 83 f8 09          	cmp    $0x9,%ax
80101b78:	77 17                	ja     80101b91 <readi+0xf1>
80101b7a:	8b 04 c5 00 09 11 80 	mov    -0x7feef700(,%eax,8),%eax
80101b81:	85 c0                	test   %eax,%eax
80101b83:	74 0c                	je     80101b91 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101b85:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b8b:	5b                   	pop    %ebx
80101b8c:	5e                   	pop    %esi
80101b8d:	5f                   	pop    %edi
80101b8e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101b8f:	ff e0                	jmp    *%eax
      return -1;
80101b91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b96:	eb cd                	jmp    80101b65 <readi+0xc5>
80101b98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b9f:	90                   	nop

80101ba0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101ba0:	55                   	push   %ebp
80101ba1:	89 e5                	mov    %esp,%ebp
80101ba3:	57                   	push   %edi
80101ba4:	56                   	push   %esi
80101ba5:	53                   	push   %ebx
80101ba6:	83 ec 1c             	sub    $0x1c,%esp
80101ba9:	8b 45 08             	mov    0x8(%ebp),%eax
80101bac:	8b 75 0c             	mov    0xc(%ebp),%esi
80101baf:	8b 55 14             	mov    0x14(%ebp),%edx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101bb2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101bb7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101bba:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101bbd:	8b 75 10             	mov    0x10(%ebp),%esi
80101bc0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(ip->type == T_DEV){
80101bc3:	0f 84 b7 00 00 00    	je     80101c80 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101bc9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bcc:	3b 70 58             	cmp    0x58(%eax),%esi
80101bcf:	0f 87 e7 00 00 00    	ja     80101cbc <writei+0x11c>
80101bd5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101bd8:	31 d2                	xor    %edx,%edx
80101bda:	89 f8                	mov    %edi,%eax
80101bdc:	01 f0                	add    %esi,%eax
80101bde:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101be1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101be6:	0f 87 d0 00 00 00    	ja     80101cbc <writei+0x11c>
80101bec:	85 d2                	test   %edx,%edx
80101bee:	0f 85 c8 00 00 00    	jne    80101cbc <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101bf4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101bfb:	85 ff                	test   %edi,%edi
80101bfd:	74 72                	je     80101c71 <writei+0xd1>
80101bff:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c00:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101c03:	89 f2                	mov    %esi,%edx
80101c05:	c1 ea 09             	shr    $0x9,%edx
80101c08:	89 f8                	mov    %edi,%eax
80101c0a:	e8 51 f8 ff ff       	call   80101460 <bmap>
80101c0f:	83 ec 08             	sub    $0x8,%esp
80101c12:	50                   	push   %eax
80101c13:	ff 37                	push   (%edi)
80101c15:	e8 b6 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c1a:	b9 00 02 00 00       	mov    $0x200,%ecx
80101c1f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c22:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c25:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101c27:	89 f0                	mov    %esi,%eax
80101c29:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c2e:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101c30:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c34:	39 d9                	cmp    %ebx,%ecx
80101c36:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101c39:	83 c4 0c             	add    $0xc,%esp
80101c3c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c3d:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101c3f:	ff 75 dc             	push   -0x24(%ebp)
80101c42:	50                   	push   %eax
80101c43:	e8 c8 36 00 00       	call   80105310 <memmove>
    log_write(bp);
80101c48:	89 3c 24             	mov    %edi,(%esp)
80101c4b:	e8 00 13 00 00       	call   80102f50 <log_write>
    brelse(bp);
80101c50:	89 3c 24             	mov    %edi,(%esp)
80101c53:	e8 98 e5 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c58:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101c5b:	83 c4 10             	add    $0x10,%esp
80101c5e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c61:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101c64:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101c67:	77 97                	ja     80101c00 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101c69:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c6c:	3b 70 58             	cmp    0x58(%eax),%esi
80101c6f:	77 37                	ja     80101ca8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101c71:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101c74:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c77:	5b                   	pop    %ebx
80101c78:	5e                   	pop    %esi
80101c79:	5f                   	pop    %edi
80101c7a:	5d                   	pop    %ebp
80101c7b:	c3                   	ret    
80101c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101c80:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c84:	66 83 f8 09          	cmp    $0x9,%ax
80101c88:	77 32                	ja     80101cbc <writei+0x11c>
80101c8a:	8b 04 c5 04 09 11 80 	mov    -0x7feef6fc(,%eax,8),%eax
80101c91:	85 c0                	test   %eax,%eax
80101c93:	74 27                	je     80101cbc <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80101c95:	89 55 10             	mov    %edx,0x10(%ebp)
}
80101c98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c9b:	5b                   	pop    %ebx
80101c9c:	5e                   	pop    %esi
80101c9d:	5f                   	pop    %edi
80101c9e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101c9f:	ff e0                	jmp    *%eax
80101ca1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101ca8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101cab:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101cae:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101cb1:	50                   	push   %eax
80101cb2:	e8 29 fa ff ff       	call   801016e0 <iupdate>
80101cb7:	83 c4 10             	add    $0x10,%esp
80101cba:	eb b5                	jmp    80101c71 <writei+0xd1>
      return -1;
80101cbc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101cc1:	eb b1                	jmp    80101c74 <writei+0xd4>
80101cc3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101cd0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101cd0:	55                   	push   %ebp
80101cd1:	89 e5                	mov    %esp,%ebp
80101cd3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101cd6:	6a 0e                	push   $0xe
80101cd8:	ff 75 0c             	push   0xc(%ebp)
80101cdb:	ff 75 08             	push   0x8(%ebp)
80101cde:	e8 9d 36 00 00       	call   80105380 <strncmp>
}
80101ce3:	c9                   	leave  
80101ce4:	c3                   	ret    
80101ce5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101cf0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101cf0:	55                   	push   %ebp
80101cf1:	89 e5                	mov    %esp,%ebp
80101cf3:	57                   	push   %edi
80101cf4:	56                   	push   %esi
80101cf5:	53                   	push   %ebx
80101cf6:	83 ec 1c             	sub    $0x1c,%esp
80101cf9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101cfc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101d01:	0f 85 85 00 00 00    	jne    80101d8c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101d07:	8b 53 58             	mov    0x58(%ebx),%edx
80101d0a:	31 ff                	xor    %edi,%edi
80101d0c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101d0f:	85 d2                	test   %edx,%edx
80101d11:	74 3e                	je     80101d51 <dirlookup+0x61>
80101d13:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d17:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101d18:	6a 10                	push   $0x10
80101d1a:	57                   	push   %edi
80101d1b:	56                   	push   %esi
80101d1c:	53                   	push   %ebx
80101d1d:	e8 7e fd ff ff       	call   80101aa0 <readi>
80101d22:	83 c4 10             	add    $0x10,%esp
80101d25:	83 f8 10             	cmp    $0x10,%eax
80101d28:	75 55                	jne    80101d7f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101d2a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101d2f:	74 18                	je     80101d49 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101d31:	83 ec 04             	sub    $0x4,%esp
80101d34:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d37:	6a 0e                	push   $0xe
80101d39:	50                   	push   %eax
80101d3a:	ff 75 0c             	push   0xc(%ebp)
80101d3d:	e8 3e 36 00 00       	call   80105380 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101d42:	83 c4 10             	add    $0x10,%esp
80101d45:	85 c0                	test   %eax,%eax
80101d47:	74 17                	je     80101d60 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101d49:	83 c7 10             	add    $0x10,%edi
80101d4c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101d4f:	72 c7                	jb     80101d18 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101d51:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101d54:	31 c0                	xor    %eax,%eax
}
80101d56:	5b                   	pop    %ebx
80101d57:	5e                   	pop    %esi
80101d58:	5f                   	pop    %edi
80101d59:	5d                   	pop    %ebp
80101d5a:	c3                   	ret    
80101d5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d5f:	90                   	nop
      if(poff)
80101d60:	8b 45 10             	mov    0x10(%ebp),%eax
80101d63:	85 c0                	test   %eax,%eax
80101d65:	74 05                	je     80101d6c <dirlookup+0x7c>
        *poff = off;
80101d67:	8b 45 10             	mov    0x10(%ebp),%eax
80101d6a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101d6c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101d70:	8b 03                	mov    (%ebx),%eax
80101d72:	e8 e9 f5 ff ff       	call   80101360 <iget>
}
80101d77:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d7a:	5b                   	pop    %ebx
80101d7b:	5e                   	pop    %esi
80101d7c:	5f                   	pop    %edi
80101d7d:	5d                   	pop    %ebp
80101d7e:	c3                   	ret    
      panic("dirlookup read");
80101d7f:	83 ec 0c             	sub    $0xc,%esp
80101d82:	68 19 81 10 80       	push   $0x80108119
80101d87:	e8 f4 e5 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
80101d8c:	83 ec 0c             	sub    $0xc,%esp
80101d8f:	68 07 81 10 80       	push   $0x80108107
80101d94:	e8 e7 e5 ff ff       	call   80100380 <panic>
80101d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101da0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101da0:	55                   	push   %ebp
80101da1:	89 e5                	mov    %esp,%ebp
80101da3:	57                   	push   %edi
80101da4:	56                   	push   %esi
80101da5:	53                   	push   %ebx
80101da6:	89 c3                	mov    %eax,%ebx
80101da8:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101dab:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101dae:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101db1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101db4:	0f 84 64 01 00 00    	je     80101f1e <namex+0x17e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101dba:	e8 01 1c 00 00       	call   801039c0 <myproc>
  acquire(&icache.lock);
80101dbf:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101dc2:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101dc5:	68 60 09 11 80       	push   $0x80110960
80101dca:	e8 e1 33 00 00       	call   801051b0 <acquire>
  ip->ref++;
80101dcf:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101dd3:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101dda:	e8 71 33 00 00       	call   80105150 <release>
80101ddf:	83 c4 10             	add    $0x10,%esp
80101de2:	eb 07                	jmp    80101deb <namex+0x4b>
80101de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101de8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101deb:	0f b6 03             	movzbl (%ebx),%eax
80101dee:	3c 2f                	cmp    $0x2f,%al
80101df0:	74 f6                	je     80101de8 <namex+0x48>
  if(*path == 0)
80101df2:	84 c0                	test   %al,%al
80101df4:	0f 84 06 01 00 00    	je     80101f00 <namex+0x160>
  while(*path != '/' && *path != 0)
80101dfa:	0f b6 03             	movzbl (%ebx),%eax
80101dfd:	84 c0                	test   %al,%al
80101dff:	0f 84 10 01 00 00    	je     80101f15 <namex+0x175>
80101e05:	89 df                	mov    %ebx,%edi
80101e07:	3c 2f                	cmp    $0x2f,%al
80101e09:	0f 84 06 01 00 00    	je     80101f15 <namex+0x175>
80101e0f:	90                   	nop
80101e10:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80101e14:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80101e17:	3c 2f                	cmp    $0x2f,%al
80101e19:	74 04                	je     80101e1f <namex+0x7f>
80101e1b:	84 c0                	test   %al,%al
80101e1d:	75 f1                	jne    80101e10 <namex+0x70>
  len = path - s;
80101e1f:	89 f8                	mov    %edi,%eax
80101e21:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80101e23:	83 f8 0d             	cmp    $0xd,%eax
80101e26:	0f 8e ac 00 00 00    	jle    80101ed8 <namex+0x138>
    memmove(name, s, DIRSIZ);
80101e2c:	83 ec 04             	sub    $0x4,%esp
80101e2f:	6a 0e                	push   $0xe
80101e31:	53                   	push   %ebx
    path++;
80101e32:	89 fb                	mov    %edi,%ebx
    memmove(name, s, DIRSIZ);
80101e34:	ff 75 e4             	push   -0x1c(%ebp)
80101e37:	e8 d4 34 00 00       	call   80105310 <memmove>
80101e3c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101e3f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101e42:	75 0c                	jne    80101e50 <namex+0xb0>
80101e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101e48:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101e4b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101e4e:	74 f8                	je     80101e48 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101e50:	83 ec 0c             	sub    $0xc,%esp
80101e53:	56                   	push   %esi
80101e54:	e8 37 f9 ff ff       	call   80101790 <ilock>
    if(ip->type != T_DIR){
80101e59:	83 c4 10             	add    $0x10,%esp
80101e5c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101e61:	0f 85 cd 00 00 00    	jne    80101f34 <namex+0x194>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101e67:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101e6a:	85 c0                	test   %eax,%eax
80101e6c:	74 09                	je     80101e77 <namex+0xd7>
80101e6e:	80 3b 00             	cmpb   $0x0,(%ebx)
80101e71:	0f 84 22 01 00 00    	je     80101f99 <namex+0x1f9>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101e77:	83 ec 04             	sub    $0x4,%esp
80101e7a:	6a 00                	push   $0x0
80101e7c:	ff 75 e4             	push   -0x1c(%ebp)
80101e7f:	56                   	push   %esi
80101e80:	e8 6b fe ff ff       	call   80101cf0 <dirlookup>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101e85:	8d 56 0c             	lea    0xc(%esi),%edx
    if((next = dirlookup(ip, name, 0)) == 0){
80101e88:	83 c4 10             	add    $0x10,%esp
80101e8b:	89 c7                	mov    %eax,%edi
80101e8d:	85 c0                	test   %eax,%eax
80101e8f:	0f 84 e1 00 00 00    	je     80101f76 <namex+0x1d6>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101e95:	83 ec 0c             	sub    $0xc,%esp
80101e98:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101e9b:	52                   	push   %edx
80101e9c:	e8 ef 30 00 00       	call   80104f90 <holdingsleep>
80101ea1:	83 c4 10             	add    $0x10,%esp
80101ea4:	85 c0                	test   %eax,%eax
80101ea6:	0f 84 30 01 00 00    	je     80101fdc <namex+0x23c>
80101eac:	8b 56 08             	mov    0x8(%esi),%edx
80101eaf:	85 d2                	test   %edx,%edx
80101eb1:	0f 8e 25 01 00 00    	jle    80101fdc <namex+0x23c>
  releasesleep(&ip->lock);
80101eb7:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101eba:	83 ec 0c             	sub    $0xc,%esp
80101ebd:	52                   	push   %edx
80101ebe:	e8 8d 30 00 00       	call   80104f50 <releasesleep>
  iput(ip);
80101ec3:	89 34 24             	mov    %esi,(%esp)
80101ec6:	89 fe                	mov    %edi,%esi
80101ec8:	e8 f3 f9 ff ff       	call   801018c0 <iput>
80101ecd:	83 c4 10             	add    $0x10,%esp
80101ed0:	e9 16 ff ff ff       	jmp    80101deb <namex+0x4b>
80101ed5:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80101ed8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101edb:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    memmove(name, s, len);
80101ede:	83 ec 04             	sub    $0x4,%esp
80101ee1:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101ee4:	50                   	push   %eax
80101ee5:	53                   	push   %ebx
    name[len] = 0;
80101ee6:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80101ee8:	ff 75 e4             	push   -0x1c(%ebp)
80101eeb:	e8 20 34 00 00       	call   80105310 <memmove>
    name[len] = 0;
80101ef0:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101ef3:	83 c4 10             	add    $0x10,%esp
80101ef6:	c6 02 00             	movb   $0x0,(%edx)
80101ef9:	e9 41 ff ff ff       	jmp    80101e3f <namex+0x9f>
80101efe:	66 90                	xchg   %ax,%ax
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101f00:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101f03:	85 c0                	test   %eax,%eax
80101f05:	0f 85 be 00 00 00    	jne    80101fc9 <namex+0x229>
    iput(ip);
    return 0;
  }
  return ip;
}
80101f0b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f0e:	89 f0                	mov    %esi,%eax
80101f10:	5b                   	pop    %ebx
80101f11:	5e                   	pop    %esi
80101f12:	5f                   	pop    %edi
80101f13:	5d                   	pop    %ebp
80101f14:	c3                   	ret    
  while(*path != '/' && *path != 0)
80101f15:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101f18:	89 df                	mov    %ebx,%edi
80101f1a:	31 c0                	xor    %eax,%eax
80101f1c:	eb c0                	jmp    80101ede <namex+0x13e>
    ip = iget(ROOTDEV, ROOTINO);
80101f1e:	ba 01 00 00 00       	mov    $0x1,%edx
80101f23:	b8 01 00 00 00       	mov    $0x1,%eax
80101f28:	e8 33 f4 ff ff       	call   80101360 <iget>
80101f2d:	89 c6                	mov    %eax,%esi
80101f2f:	e9 b7 fe ff ff       	jmp    80101deb <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f34:	83 ec 0c             	sub    $0xc,%esp
80101f37:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101f3a:	53                   	push   %ebx
80101f3b:	e8 50 30 00 00       	call   80104f90 <holdingsleep>
80101f40:	83 c4 10             	add    $0x10,%esp
80101f43:	85 c0                	test   %eax,%eax
80101f45:	0f 84 91 00 00 00    	je     80101fdc <namex+0x23c>
80101f4b:	8b 46 08             	mov    0x8(%esi),%eax
80101f4e:	85 c0                	test   %eax,%eax
80101f50:	0f 8e 86 00 00 00    	jle    80101fdc <namex+0x23c>
  releasesleep(&ip->lock);
80101f56:	83 ec 0c             	sub    $0xc,%esp
80101f59:	53                   	push   %ebx
80101f5a:	e8 f1 2f 00 00       	call   80104f50 <releasesleep>
  iput(ip);
80101f5f:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101f62:	31 f6                	xor    %esi,%esi
  iput(ip);
80101f64:	e8 57 f9 ff ff       	call   801018c0 <iput>
      return 0;
80101f69:	83 c4 10             	add    $0x10,%esp
}
80101f6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f6f:	89 f0                	mov    %esi,%eax
80101f71:	5b                   	pop    %ebx
80101f72:	5e                   	pop    %esi
80101f73:	5f                   	pop    %edi
80101f74:	5d                   	pop    %ebp
80101f75:	c3                   	ret    
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f76:	83 ec 0c             	sub    $0xc,%esp
80101f79:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101f7c:	52                   	push   %edx
80101f7d:	e8 0e 30 00 00       	call   80104f90 <holdingsleep>
80101f82:	83 c4 10             	add    $0x10,%esp
80101f85:	85 c0                	test   %eax,%eax
80101f87:	74 53                	je     80101fdc <namex+0x23c>
80101f89:	8b 4e 08             	mov    0x8(%esi),%ecx
80101f8c:	85 c9                	test   %ecx,%ecx
80101f8e:	7e 4c                	jle    80101fdc <namex+0x23c>
  releasesleep(&ip->lock);
80101f90:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101f93:	83 ec 0c             	sub    $0xc,%esp
80101f96:	52                   	push   %edx
80101f97:	eb c1                	jmp    80101f5a <namex+0x1ba>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f99:	83 ec 0c             	sub    $0xc,%esp
80101f9c:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101f9f:	53                   	push   %ebx
80101fa0:	e8 eb 2f 00 00       	call   80104f90 <holdingsleep>
80101fa5:	83 c4 10             	add    $0x10,%esp
80101fa8:	85 c0                	test   %eax,%eax
80101faa:	74 30                	je     80101fdc <namex+0x23c>
80101fac:	8b 7e 08             	mov    0x8(%esi),%edi
80101faf:	85 ff                	test   %edi,%edi
80101fb1:	7e 29                	jle    80101fdc <namex+0x23c>
  releasesleep(&ip->lock);
80101fb3:	83 ec 0c             	sub    $0xc,%esp
80101fb6:	53                   	push   %ebx
80101fb7:	e8 94 2f 00 00       	call   80104f50 <releasesleep>
}
80101fbc:	83 c4 10             	add    $0x10,%esp
}
80101fbf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fc2:	89 f0                	mov    %esi,%eax
80101fc4:	5b                   	pop    %ebx
80101fc5:	5e                   	pop    %esi
80101fc6:	5f                   	pop    %edi
80101fc7:	5d                   	pop    %ebp
80101fc8:	c3                   	ret    
    iput(ip);
80101fc9:	83 ec 0c             	sub    $0xc,%esp
80101fcc:	56                   	push   %esi
    return 0;
80101fcd:	31 f6                	xor    %esi,%esi
    iput(ip);
80101fcf:	e8 ec f8 ff ff       	call   801018c0 <iput>
    return 0;
80101fd4:	83 c4 10             	add    $0x10,%esp
80101fd7:	e9 2f ff ff ff       	jmp    80101f0b <namex+0x16b>
    panic("iunlock");
80101fdc:	83 ec 0c             	sub    $0xc,%esp
80101fdf:	68 ff 80 10 80       	push   $0x801080ff
80101fe4:	e8 97 e3 ff ff       	call   80100380 <panic>
80101fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101ff0 <dirlink>:
{
80101ff0:	55                   	push   %ebp
80101ff1:	89 e5                	mov    %esp,%ebp
80101ff3:	57                   	push   %edi
80101ff4:	56                   	push   %esi
80101ff5:	53                   	push   %ebx
80101ff6:	83 ec 20             	sub    $0x20,%esp
80101ff9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101ffc:	6a 00                	push   $0x0
80101ffe:	ff 75 0c             	push   0xc(%ebp)
80102001:	53                   	push   %ebx
80102002:	e8 e9 fc ff ff       	call   80101cf0 <dirlookup>
80102007:	83 c4 10             	add    $0x10,%esp
8010200a:	85 c0                	test   %eax,%eax
8010200c:	75 67                	jne    80102075 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
8010200e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102011:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102014:	85 ff                	test   %edi,%edi
80102016:	74 29                	je     80102041 <dirlink+0x51>
80102018:	31 ff                	xor    %edi,%edi
8010201a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010201d:	eb 09                	jmp    80102028 <dirlink+0x38>
8010201f:	90                   	nop
80102020:	83 c7 10             	add    $0x10,%edi
80102023:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102026:	73 19                	jae    80102041 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102028:	6a 10                	push   $0x10
8010202a:	57                   	push   %edi
8010202b:	56                   	push   %esi
8010202c:	53                   	push   %ebx
8010202d:	e8 6e fa ff ff       	call   80101aa0 <readi>
80102032:	83 c4 10             	add    $0x10,%esp
80102035:	83 f8 10             	cmp    $0x10,%eax
80102038:	75 4e                	jne    80102088 <dirlink+0x98>
    if(de.inum == 0)
8010203a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010203f:	75 df                	jne    80102020 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102041:	83 ec 04             	sub    $0x4,%esp
80102044:	8d 45 da             	lea    -0x26(%ebp),%eax
80102047:	6a 0e                	push   $0xe
80102049:	ff 75 0c             	push   0xc(%ebp)
8010204c:	50                   	push   %eax
8010204d:	e8 7e 33 00 00       	call   801053d0 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102052:	6a 10                	push   $0x10
  de.inum = inum;
80102054:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102057:	57                   	push   %edi
80102058:	56                   	push   %esi
80102059:	53                   	push   %ebx
  de.inum = inum;
8010205a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010205e:	e8 3d fb ff ff       	call   80101ba0 <writei>
80102063:	83 c4 20             	add    $0x20,%esp
80102066:	83 f8 10             	cmp    $0x10,%eax
80102069:	75 2a                	jne    80102095 <dirlink+0xa5>
  return 0;
8010206b:	31 c0                	xor    %eax,%eax
}
8010206d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102070:	5b                   	pop    %ebx
80102071:	5e                   	pop    %esi
80102072:	5f                   	pop    %edi
80102073:	5d                   	pop    %ebp
80102074:	c3                   	ret    
    iput(ip);
80102075:	83 ec 0c             	sub    $0xc,%esp
80102078:	50                   	push   %eax
80102079:	e8 42 f8 ff ff       	call   801018c0 <iput>
    return -1;
8010207e:	83 c4 10             	add    $0x10,%esp
80102081:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102086:	eb e5                	jmp    8010206d <dirlink+0x7d>
      panic("dirlink read");
80102088:	83 ec 0c             	sub    $0xc,%esp
8010208b:	68 28 81 10 80       	push   $0x80108128
80102090:	e8 eb e2 ff ff       	call   80100380 <panic>
    panic("dirlink");
80102095:	83 ec 0c             	sub    $0xc,%esp
80102098:	68 ea 88 10 80       	push   $0x801088ea
8010209d:	e8 de e2 ff ff       	call   80100380 <panic>
801020a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801020b0 <namei>:

struct inode*
namei(char *path)
{
801020b0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801020b1:	31 d2                	xor    %edx,%edx
{
801020b3:	89 e5                	mov    %esp,%ebp
801020b5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
801020b8:	8b 45 08             	mov    0x8(%ebp),%eax
801020bb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801020be:	e8 dd fc ff ff       	call   80101da0 <namex>
}
801020c3:	c9                   	leave  
801020c4:	c3                   	ret    
801020c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801020d0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801020d0:	55                   	push   %ebp
  return namex(path, 1, name);
801020d1:	ba 01 00 00 00       	mov    $0x1,%edx
{
801020d6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
801020d8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801020db:	8b 45 08             	mov    0x8(%ebp),%eax
}
801020de:	5d                   	pop    %ebp
  return namex(path, 1, name);
801020df:	e9 bc fc ff ff       	jmp    80101da0 <namex>
801020e4:	66 90                	xchg   %ax,%ax
801020e6:	66 90                	xchg   %ax,%ax
801020e8:	66 90                	xchg   %ax,%ax
801020ea:	66 90                	xchg   %ax,%ax
801020ec:	66 90                	xchg   %ax,%ax
801020ee:	66 90                	xchg   %ax,%ax

801020f0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801020f0:	55                   	push   %ebp
801020f1:	89 e5                	mov    %esp,%ebp
801020f3:	57                   	push   %edi
801020f4:	56                   	push   %esi
801020f5:	53                   	push   %ebx
801020f6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801020f9:	85 c0                	test   %eax,%eax
801020fb:	0f 84 b4 00 00 00    	je     801021b5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102101:	8b 70 08             	mov    0x8(%eax),%esi
80102104:	89 c3                	mov    %eax,%ebx
80102106:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010210c:	0f 87 96 00 00 00    	ja     801021a8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102112:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102117:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010211e:	66 90                	xchg   %ax,%ax
80102120:	89 ca                	mov    %ecx,%edx
80102122:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102123:	83 e0 c0             	and    $0xffffffc0,%eax
80102126:	3c 40                	cmp    $0x40,%al
80102128:	75 f6                	jne    80102120 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010212a:	31 ff                	xor    %edi,%edi
8010212c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102131:	89 f8                	mov    %edi,%eax
80102133:	ee                   	out    %al,(%dx)
80102134:	b8 01 00 00 00       	mov    $0x1,%eax
80102139:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010213e:	ee                   	out    %al,(%dx)
8010213f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102144:	89 f0                	mov    %esi,%eax
80102146:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102147:	89 f0                	mov    %esi,%eax
80102149:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010214e:	c1 f8 08             	sar    $0x8,%eax
80102151:	ee                   	out    %al,(%dx)
80102152:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102157:	89 f8                	mov    %edi,%eax
80102159:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010215a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010215e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102163:	c1 e0 04             	shl    $0x4,%eax
80102166:	83 e0 10             	and    $0x10,%eax
80102169:	83 c8 e0             	or     $0xffffffe0,%eax
8010216c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010216d:	f6 03 04             	testb  $0x4,(%ebx)
80102170:	75 16                	jne    80102188 <idestart+0x98>
80102172:	b8 20 00 00 00       	mov    $0x20,%eax
80102177:	89 ca                	mov    %ecx,%edx
80102179:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010217a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010217d:	5b                   	pop    %ebx
8010217e:	5e                   	pop    %esi
8010217f:	5f                   	pop    %edi
80102180:	5d                   	pop    %ebp
80102181:	c3                   	ret    
80102182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102188:	b8 30 00 00 00       	mov    $0x30,%eax
8010218d:	89 ca                	mov    %ecx,%edx
8010218f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102190:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102195:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102198:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010219d:	fc                   	cld    
8010219e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801021a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021a3:	5b                   	pop    %ebx
801021a4:	5e                   	pop    %esi
801021a5:	5f                   	pop    %edi
801021a6:	5d                   	pop    %ebp
801021a7:	c3                   	ret    
    panic("incorrect blockno");
801021a8:	83 ec 0c             	sub    $0xc,%esp
801021ab:	68 94 81 10 80       	push   $0x80108194
801021b0:	e8 cb e1 ff ff       	call   80100380 <panic>
    panic("idestart");
801021b5:	83 ec 0c             	sub    $0xc,%esp
801021b8:	68 8b 81 10 80       	push   $0x8010818b
801021bd:	e8 be e1 ff ff       	call   80100380 <panic>
801021c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801021d0 <ideinit>:
{
801021d0:	55                   	push   %ebp
801021d1:	89 e5                	mov    %esp,%ebp
801021d3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801021d6:	68 a6 81 10 80       	push   $0x801081a6
801021db:	68 00 26 11 80       	push   $0x80112600
801021e0:	e8 fb 2d 00 00       	call   80104fe0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801021e5:	58                   	pop    %eax
801021e6:	a1 84 27 11 80       	mov    0x80112784,%eax
801021eb:	5a                   	pop    %edx
801021ec:	83 e8 01             	sub    $0x1,%eax
801021ef:	50                   	push   %eax
801021f0:	6a 0e                	push   $0xe
801021f2:	e8 99 02 00 00       	call   80102490 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021f7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021fa:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021ff:	90                   	nop
80102200:	ec                   	in     (%dx),%al
80102201:	83 e0 c0             	and    $0xffffffc0,%eax
80102204:	3c 40                	cmp    $0x40,%al
80102206:	75 f8                	jne    80102200 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102208:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010220d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102212:	ee                   	out    %al,(%dx)
80102213:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102218:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010221d:	eb 06                	jmp    80102225 <ideinit+0x55>
8010221f:	90                   	nop
  for(i=0; i<1000; i++){
80102220:	83 e9 01             	sub    $0x1,%ecx
80102223:	74 0f                	je     80102234 <ideinit+0x64>
80102225:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102226:	84 c0                	test   %al,%al
80102228:	74 f6                	je     80102220 <ideinit+0x50>
      havedisk1 = 1;
8010222a:	c7 05 e0 25 11 80 01 	movl   $0x1,0x801125e0
80102231:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102234:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102239:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010223e:	ee                   	out    %al,(%dx)
}
8010223f:	c9                   	leave  
80102240:	c3                   	ret    
80102241:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102248:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010224f:	90                   	nop

80102250 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102250:	55                   	push   %ebp
80102251:	89 e5                	mov    %esp,%ebp
80102253:	57                   	push   %edi
80102254:	56                   	push   %esi
80102255:	53                   	push   %ebx
80102256:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102259:	68 00 26 11 80       	push   $0x80112600
8010225e:	e8 4d 2f 00 00       	call   801051b0 <acquire>

  if((b = idequeue) == 0){
80102263:	8b 1d e4 25 11 80    	mov    0x801125e4,%ebx
80102269:	83 c4 10             	add    $0x10,%esp
8010226c:	85 db                	test   %ebx,%ebx
8010226e:	74 63                	je     801022d3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102270:	8b 43 58             	mov    0x58(%ebx),%eax
80102273:	a3 e4 25 11 80       	mov    %eax,0x801125e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102278:	8b 33                	mov    (%ebx),%esi
8010227a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102280:	75 2f                	jne    801022b1 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102282:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102287:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010228e:	66 90                	xchg   %ax,%ax
80102290:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102291:	89 c1                	mov    %eax,%ecx
80102293:	83 e1 c0             	and    $0xffffffc0,%ecx
80102296:	80 f9 40             	cmp    $0x40,%cl
80102299:	75 f5                	jne    80102290 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010229b:	a8 21                	test   $0x21,%al
8010229d:	75 12                	jne    801022b1 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010229f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801022a2:	b9 80 00 00 00       	mov    $0x80,%ecx
801022a7:	ba f0 01 00 00       	mov    $0x1f0,%edx
801022ac:	fc                   	cld    
801022ad:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
801022af:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
801022b1:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801022b4:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801022b7:	83 ce 02             	or     $0x2,%esi
801022ba:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801022bc:	53                   	push   %ebx
801022bd:	e8 ae 21 00 00       	call   80104470 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801022c2:	a1 e4 25 11 80       	mov    0x801125e4,%eax
801022c7:	83 c4 10             	add    $0x10,%esp
801022ca:	85 c0                	test   %eax,%eax
801022cc:	74 05                	je     801022d3 <ideintr+0x83>
    idestart(idequeue);
801022ce:	e8 1d fe ff ff       	call   801020f0 <idestart>
    release(&idelock);
801022d3:	83 ec 0c             	sub    $0xc,%esp
801022d6:	68 00 26 11 80       	push   $0x80112600
801022db:	e8 70 2e 00 00       	call   80105150 <release>

  release(&idelock);
}
801022e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022e3:	5b                   	pop    %ebx
801022e4:	5e                   	pop    %esi
801022e5:	5f                   	pop    %edi
801022e6:	5d                   	pop    %ebp
801022e7:	c3                   	ret    
801022e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022ef:	90                   	nop

801022f0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801022f0:	55                   	push   %ebp
801022f1:	89 e5                	mov    %esp,%ebp
801022f3:	53                   	push   %ebx
801022f4:	83 ec 10             	sub    $0x10,%esp
801022f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801022fa:	8d 43 0c             	lea    0xc(%ebx),%eax
801022fd:	50                   	push   %eax
801022fe:	e8 8d 2c 00 00       	call   80104f90 <holdingsleep>
80102303:	83 c4 10             	add    $0x10,%esp
80102306:	85 c0                	test   %eax,%eax
80102308:	0f 84 c3 00 00 00    	je     801023d1 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010230e:	8b 03                	mov    (%ebx),%eax
80102310:	83 e0 06             	and    $0x6,%eax
80102313:	83 f8 02             	cmp    $0x2,%eax
80102316:	0f 84 a8 00 00 00    	je     801023c4 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010231c:	8b 53 04             	mov    0x4(%ebx),%edx
8010231f:	85 d2                	test   %edx,%edx
80102321:	74 0d                	je     80102330 <iderw+0x40>
80102323:	a1 e0 25 11 80       	mov    0x801125e0,%eax
80102328:	85 c0                	test   %eax,%eax
8010232a:	0f 84 87 00 00 00    	je     801023b7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102330:	83 ec 0c             	sub    $0xc,%esp
80102333:	68 00 26 11 80       	push   $0x80112600
80102338:	e8 73 2e 00 00       	call   801051b0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010233d:	a1 e4 25 11 80       	mov    0x801125e4,%eax
  b->qnext = 0;
80102342:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102349:	83 c4 10             	add    $0x10,%esp
8010234c:	85 c0                	test   %eax,%eax
8010234e:	74 60                	je     801023b0 <iderw+0xc0>
80102350:	89 c2                	mov    %eax,%edx
80102352:	8b 40 58             	mov    0x58(%eax),%eax
80102355:	85 c0                	test   %eax,%eax
80102357:	75 f7                	jne    80102350 <iderw+0x60>
80102359:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010235c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010235e:	39 1d e4 25 11 80    	cmp    %ebx,0x801125e4
80102364:	74 3a                	je     801023a0 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102366:	8b 03                	mov    (%ebx),%eax
80102368:	83 e0 06             	and    $0x6,%eax
8010236b:	83 f8 02             	cmp    $0x2,%eax
8010236e:	74 1b                	je     8010238b <iderw+0x9b>
    sleep(b, &idelock);
80102370:	83 ec 08             	sub    $0x8,%esp
80102373:	68 00 26 11 80       	push   $0x80112600
80102378:	53                   	push   %ebx
80102379:	e8 32 20 00 00       	call   801043b0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010237e:	8b 03                	mov    (%ebx),%eax
80102380:	83 c4 10             	add    $0x10,%esp
80102383:	83 e0 06             	and    $0x6,%eax
80102386:	83 f8 02             	cmp    $0x2,%eax
80102389:	75 e5                	jne    80102370 <iderw+0x80>
  }


  release(&idelock);
8010238b:	c7 45 08 00 26 11 80 	movl   $0x80112600,0x8(%ebp)
}
80102392:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102395:	c9                   	leave  
  release(&idelock);
80102396:	e9 b5 2d 00 00       	jmp    80105150 <release>
8010239b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010239f:	90                   	nop
    idestart(b);
801023a0:	89 d8                	mov    %ebx,%eax
801023a2:	e8 49 fd ff ff       	call   801020f0 <idestart>
801023a7:	eb bd                	jmp    80102366 <iderw+0x76>
801023a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801023b0:	ba e4 25 11 80       	mov    $0x801125e4,%edx
801023b5:	eb a5                	jmp    8010235c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
801023b7:	83 ec 0c             	sub    $0xc,%esp
801023ba:	68 d5 81 10 80       	push   $0x801081d5
801023bf:	e8 bc df ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
801023c4:	83 ec 0c             	sub    $0xc,%esp
801023c7:	68 c0 81 10 80       	push   $0x801081c0
801023cc:	e8 af df ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
801023d1:	83 ec 0c             	sub    $0xc,%esp
801023d4:	68 aa 81 10 80       	push   $0x801081aa
801023d9:	e8 a2 df ff ff       	call   80100380 <panic>
801023de:	66 90                	xchg   %ax,%ax

801023e0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801023e0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801023e1:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
801023e8:	00 c0 fe 
{
801023eb:	89 e5                	mov    %esp,%ebp
801023ed:	56                   	push   %esi
801023ee:	53                   	push   %ebx
  ioapic->reg = reg;
801023ef:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801023f6:	00 00 00 
  return ioapic->data;
801023f9:	8b 15 34 26 11 80    	mov    0x80112634,%edx
801023ff:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102402:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102408:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010240e:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102415:	c1 ee 10             	shr    $0x10,%esi
80102418:	89 f0                	mov    %esi,%eax
8010241a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010241d:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80102420:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102423:	39 c2                	cmp    %eax,%edx
80102425:	74 16                	je     8010243d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102427:	83 ec 0c             	sub    $0xc,%esp
8010242a:	68 f4 81 10 80       	push   $0x801081f4
8010242f:	e8 6c e2 ff ff       	call   801006a0 <cprintf>
  ioapic->reg = reg;
80102434:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010243a:	83 c4 10             	add    $0x10,%esp
8010243d:	83 c6 21             	add    $0x21,%esi
{
80102440:	ba 10 00 00 00       	mov    $0x10,%edx
80102445:	b8 20 00 00 00       	mov    $0x20,%eax
8010244a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
80102450:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102452:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80102454:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  for(i = 0; i <= maxintr; i++){
8010245a:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010245d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80102463:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80102466:	8d 5a 01             	lea    0x1(%edx),%ebx
  for(i = 0; i <= maxintr; i++){
80102469:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
8010246c:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
8010246e:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102474:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010247b:	39 f0                	cmp    %esi,%eax
8010247d:	75 d1                	jne    80102450 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010247f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102482:	5b                   	pop    %ebx
80102483:	5e                   	pop    %esi
80102484:	5d                   	pop    %ebp
80102485:	c3                   	ret    
80102486:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010248d:	8d 76 00             	lea    0x0(%esi),%esi

80102490 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102490:	55                   	push   %ebp
  ioapic->reg = reg;
80102491:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
80102497:	89 e5                	mov    %esp,%ebp
80102499:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010249c:	8d 50 20             	lea    0x20(%eax),%edx
8010249f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801024a3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801024a5:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801024ab:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801024ae:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801024b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801024b4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801024b6:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801024bb:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801024be:	89 50 10             	mov    %edx,0x10(%eax)
}
801024c1:	5d                   	pop    %ebp
801024c2:	c3                   	ret    
801024c3:	66 90                	xchg   %ax,%ax
801024c5:	66 90                	xchg   %ax,%ax
801024c7:	66 90                	xchg   %ax,%ax
801024c9:	66 90                	xchg   %ax,%ax
801024cb:	66 90                	xchg   %ax,%ax
801024cd:	66 90                	xchg   %ax,%ax
801024cf:	90                   	nop

801024d0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801024d0:	55                   	push   %ebp
801024d1:	89 e5                	mov    %esp,%ebp
801024d3:	53                   	push   %ebx
801024d4:	83 ec 04             	sub    $0x4,%esp
801024d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801024da:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801024e0:	75 76                	jne    80102558 <kfree+0x88>
801024e2:	81 fb 50 6f 11 80    	cmp    $0x80116f50,%ebx
801024e8:	72 6e                	jb     80102558 <kfree+0x88>
801024ea:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801024f0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801024f5:	77 61                	ja     80102558 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801024f7:	83 ec 04             	sub    $0x4,%esp
801024fa:	68 00 10 00 00       	push   $0x1000
801024ff:	6a 01                	push   $0x1
80102501:	53                   	push   %ebx
80102502:	e8 69 2d 00 00       	call   80105270 <memset>

  if(kmem.use_lock)
80102507:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010250d:	83 c4 10             	add    $0x10,%esp
80102510:	85 d2                	test   %edx,%edx
80102512:	75 1c                	jne    80102530 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102514:	a1 78 26 11 80       	mov    0x80112678,%eax
80102519:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010251b:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80102520:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102526:	85 c0                	test   %eax,%eax
80102528:	75 1e                	jne    80102548 <kfree+0x78>
    release(&kmem.lock);
}
8010252a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010252d:	c9                   	leave  
8010252e:	c3                   	ret    
8010252f:	90                   	nop
    acquire(&kmem.lock);
80102530:	83 ec 0c             	sub    $0xc,%esp
80102533:	68 40 26 11 80       	push   $0x80112640
80102538:	e8 73 2c 00 00       	call   801051b0 <acquire>
8010253d:	83 c4 10             	add    $0x10,%esp
80102540:	eb d2                	jmp    80102514 <kfree+0x44>
80102542:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102548:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
8010254f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102552:	c9                   	leave  
    release(&kmem.lock);
80102553:	e9 f8 2b 00 00       	jmp    80105150 <release>
    panic("kfree");
80102558:	83 ec 0c             	sub    $0xc,%esp
8010255b:	68 26 82 10 80       	push   $0x80108226
80102560:	e8 1b de ff ff       	call   80100380 <panic>
80102565:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010256c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102570 <freerange>:
{
80102570:	55                   	push   %ebp
80102571:	89 e5                	mov    %esp,%ebp
80102573:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102574:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102577:	8b 75 0c             	mov    0xc(%ebp),%esi
8010257a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010257b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102581:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102587:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010258d:	39 de                	cmp    %ebx,%esi
8010258f:	72 23                	jb     801025b4 <freerange+0x44>
80102591:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102598:	83 ec 0c             	sub    $0xc,%esp
8010259b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025a1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801025a7:	50                   	push   %eax
801025a8:	e8 23 ff ff ff       	call   801024d0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025ad:	83 c4 10             	add    $0x10,%esp
801025b0:	39 f3                	cmp    %esi,%ebx
801025b2:	76 e4                	jbe    80102598 <freerange+0x28>
}
801025b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025b7:	5b                   	pop    %ebx
801025b8:	5e                   	pop    %esi
801025b9:	5d                   	pop    %ebp
801025ba:	c3                   	ret    
801025bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801025bf:	90                   	nop

801025c0 <kinit2>:
{
801025c0:	55                   	push   %ebp
801025c1:	89 e5                	mov    %esp,%ebp
801025c3:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801025c4:	8b 45 08             	mov    0x8(%ebp),%eax
{
801025c7:	8b 75 0c             	mov    0xc(%ebp),%esi
801025ca:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801025cb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025d1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025d7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025dd:	39 de                	cmp    %ebx,%esi
801025df:	72 23                	jb     80102604 <kinit2+0x44>
801025e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801025e8:	83 ec 0c             	sub    $0xc,%esp
801025eb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025f1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801025f7:	50                   	push   %eax
801025f8:	e8 d3 fe ff ff       	call   801024d0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025fd:	83 c4 10             	add    $0x10,%esp
80102600:	39 de                	cmp    %ebx,%esi
80102602:	73 e4                	jae    801025e8 <kinit2+0x28>
  kmem.use_lock = 1;
80102604:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
8010260b:	00 00 00 
}
8010260e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102611:	5b                   	pop    %ebx
80102612:	5e                   	pop    %esi
80102613:	5d                   	pop    %ebp
80102614:	c3                   	ret    
80102615:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010261c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102620 <kinit1>:
{
80102620:	55                   	push   %ebp
80102621:	89 e5                	mov    %esp,%ebp
80102623:	56                   	push   %esi
80102624:	53                   	push   %ebx
80102625:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102628:	83 ec 08             	sub    $0x8,%esp
8010262b:	68 2c 82 10 80       	push   $0x8010822c
80102630:	68 40 26 11 80       	push   $0x80112640
80102635:	e8 a6 29 00 00       	call   80104fe0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010263a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010263d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102640:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102647:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010264a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102650:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102656:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010265c:	39 de                	cmp    %ebx,%esi
8010265e:	72 1c                	jb     8010267c <kinit1+0x5c>
    kfree(p);
80102660:	83 ec 0c             	sub    $0xc,%esp
80102663:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102669:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010266f:	50                   	push   %eax
80102670:	e8 5b fe ff ff       	call   801024d0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102675:	83 c4 10             	add    $0x10,%esp
80102678:	39 de                	cmp    %ebx,%esi
8010267a:	73 e4                	jae    80102660 <kinit1+0x40>
}
8010267c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010267f:	5b                   	pop    %ebx
80102680:	5e                   	pop    %esi
80102681:	5d                   	pop    %ebp
80102682:	c3                   	ret    
80102683:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010268a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102690 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102690:	a1 74 26 11 80       	mov    0x80112674,%eax
80102695:	85 c0                	test   %eax,%eax
80102697:	75 1f                	jne    801026b8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102699:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
8010269e:	85 c0                	test   %eax,%eax
801026a0:	74 0e                	je     801026b0 <kalloc+0x20>
    kmem.freelist = r->next;
801026a2:	8b 10                	mov    (%eax),%edx
801026a4:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
801026aa:	c3                   	ret    
801026ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801026af:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
801026b0:	c3                   	ret    
801026b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
801026b8:	55                   	push   %ebp
801026b9:	89 e5                	mov    %esp,%ebp
801026bb:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801026be:	68 40 26 11 80       	push   $0x80112640
801026c3:	e8 e8 2a 00 00       	call   801051b0 <acquire>
  r = kmem.freelist;
801026c8:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(kmem.use_lock)
801026cd:	8b 15 74 26 11 80    	mov    0x80112674,%edx
  if(r)
801026d3:	83 c4 10             	add    $0x10,%esp
801026d6:	85 c0                	test   %eax,%eax
801026d8:	74 08                	je     801026e2 <kalloc+0x52>
    kmem.freelist = r->next;
801026da:	8b 08                	mov    (%eax),%ecx
801026dc:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
  if(kmem.use_lock)
801026e2:	85 d2                	test   %edx,%edx
801026e4:	74 16                	je     801026fc <kalloc+0x6c>
    release(&kmem.lock);
801026e6:	83 ec 0c             	sub    $0xc,%esp
801026e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801026ec:	68 40 26 11 80       	push   $0x80112640
801026f1:	e8 5a 2a 00 00       	call   80105150 <release>
  return (char*)r;
801026f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
801026f9:	83 c4 10             	add    $0x10,%esp
}
801026fc:	c9                   	leave  
801026fd:	c3                   	ret    
801026fe:	66 90                	xchg   %ax,%ax

80102700 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102700:	ba 64 00 00 00       	mov    $0x64,%edx
80102705:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102706:	a8 01                	test   $0x1,%al
80102708:	0f 84 c2 00 00 00    	je     801027d0 <kbdgetc+0xd0>
{
8010270e:	55                   	push   %ebp
8010270f:	ba 60 00 00 00       	mov    $0x60,%edx
80102714:	89 e5                	mov    %esp,%ebp
80102716:	53                   	push   %ebx
80102717:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102718:	8b 1d 7c 26 11 80    	mov    0x8011267c,%ebx
  data = inb(KBDATAP);
8010271e:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80102721:	3c e0                	cmp    $0xe0,%al
80102723:	74 5b                	je     80102780 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102725:	89 da                	mov    %ebx,%edx
80102727:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
8010272a:	84 c0                	test   %al,%al
8010272c:	78 62                	js     80102790 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010272e:	85 d2                	test   %edx,%edx
80102730:	74 09                	je     8010273b <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102732:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102735:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102738:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
8010273b:	0f b6 91 60 83 10 80 	movzbl -0x7fef7ca0(%ecx),%edx
  shift ^= togglecode[data];
80102742:	0f b6 81 60 82 10 80 	movzbl -0x7fef7da0(%ecx),%eax
  shift |= shiftcode[data];
80102749:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
8010274b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010274d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
8010274f:	89 15 7c 26 11 80    	mov    %edx,0x8011267c
  c = charcode[shift & (CTL | SHIFT)][data];
80102755:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102758:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010275b:	8b 04 85 40 82 10 80 	mov    -0x7fef7dc0(,%eax,4),%eax
80102762:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102766:	74 0b                	je     80102773 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80102768:	8d 50 9f             	lea    -0x61(%eax),%edx
8010276b:	83 fa 19             	cmp    $0x19,%edx
8010276e:	77 48                	ja     801027b8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102770:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102773:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102776:	c9                   	leave  
80102777:	c3                   	ret    
80102778:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010277f:	90                   	nop
    shift |= E0ESC;
80102780:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102783:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102785:	89 1d 7c 26 11 80    	mov    %ebx,0x8011267c
}
8010278b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010278e:	c9                   	leave  
8010278f:	c3                   	ret    
    data = (shift & E0ESC ? data : data & 0x7F);
80102790:	83 e0 7f             	and    $0x7f,%eax
80102793:	85 d2                	test   %edx,%edx
80102795:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102798:	0f b6 81 60 83 10 80 	movzbl -0x7fef7ca0(%ecx),%eax
8010279f:	83 c8 40             	or     $0x40,%eax
801027a2:	0f b6 c0             	movzbl %al,%eax
801027a5:	f7 d0                	not    %eax
801027a7:	21 d8                	and    %ebx,%eax
}
801027a9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    shift &= ~(shiftcode[data] | E0ESC);
801027ac:	a3 7c 26 11 80       	mov    %eax,0x8011267c
    return 0;
801027b1:	31 c0                	xor    %eax,%eax
}
801027b3:	c9                   	leave  
801027b4:	c3                   	ret    
801027b5:	8d 76 00             	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
801027b8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801027bb:	8d 50 20             	lea    0x20(%eax),%edx
}
801027be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801027c1:	c9                   	leave  
      c += 'a' - 'A';
801027c2:	83 f9 1a             	cmp    $0x1a,%ecx
801027c5:	0f 42 c2             	cmovb  %edx,%eax
}
801027c8:	c3                   	ret    
801027c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801027d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801027d5:	c3                   	ret    
801027d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027dd:	8d 76 00             	lea    0x0(%esi),%esi

801027e0 <kbdintr>:

void
kbdintr(void)
{
801027e0:	55                   	push   %ebp
801027e1:	89 e5                	mov    %esp,%ebp
801027e3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801027e6:	68 00 27 10 80       	push   $0x80102700
801027eb:	e8 90 e0 ff ff       	call   80100880 <consoleintr>
}
801027f0:	83 c4 10             	add    $0x10,%esp
801027f3:	c9                   	leave  
801027f4:	c3                   	ret    
801027f5:	66 90                	xchg   %ax,%ax
801027f7:	66 90                	xchg   %ax,%ax
801027f9:	66 90                	xchg   %ax,%ax
801027fb:	66 90                	xchg   %ax,%ax
801027fd:	66 90                	xchg   %ax,%ax
801027ff:	90                   	nop

80102800 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102800:	a1 80 26 11 80       	mov    0x80112680,%eax
80102805:	85 c0                	test   %eax,%eax
80102807:	0f 84 cb 00 00 00    	je     801028d8 <lapicinit+0xd8>
  lapic[index] = value;
8010280d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102814:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102817:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010281a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102821:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102824:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102827:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010282e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102831:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102834:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010283b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010283e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102841:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102848:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010284b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010284e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102855:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102858:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010285b:	8b 50 30             	mov    0x30(%eax),%edx
8010285e:	c1 ea 10             	shr    $0x10,%edx
80102861:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102867:	75 77                	jne    801028e0 <lapicinit+0xe0>
  lapic[index] = value;
80102869:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102870:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102873:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102876:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010287d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102880:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102883:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010288a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010288d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102890:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102897:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010289a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010289d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801028a4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028a7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028aa:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801028b1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801028b4:	8b 50 20             	mov    0x20(%eax),%edx
801028b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028be:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801028c0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801028c6:	80 e6 10             	and    $0x10,%dh
801028c9:	75 f5                	jne    801028c0 <lapicinit+0xc0>
  lapic[index] = value;
801028cb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801028d2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028d5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801028d8:	c3                   	ret    
801028d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
801028e0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801028e7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801028ea:	8b 50 20             	mov    0x20(%eax),%edx
}
801028ed:	e9 77 ff ff ff       	jmp    80102869 <lapicinit+0x69>
801028f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102900 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102900:	a1 80 26 11 80       	mov    0x80112680,%eax
80102905:	85 c0                	test   %eax,%eax
80102907:	74 07                	je     80102910 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102909:	8b 40 20             	mov    0x20(%eax),%eax
8010290c:	c1 e8 18             	shr    $0x18,%eax
8010290f:	c3                   	ret    
    return 0;
80102910:	31 c0                	xor    %eax,%eax
}
80102912:	c3                   	ret    
80102913:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010291a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102920 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102920:	a1 80 26 11 80       	mov    0x80112680,%eax
80102925:	85 c0                	test   %eax,%eax
80102927:	74 0d                	je     80102936 <lapiceoi+0x16>
  lapic[index] = value;
80102929:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102930:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102933:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102936:	c3                   	ret    
80102937:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010293e:	66 90                	xchg   %ax,%ax

80102940 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102940:	c3                   	ret    
80102941:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102948:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010294f:	90                   	nop

80102950 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102950:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102951:	b8 0f 00 00 00       	mov    $0xf,%eax
80102956:	ba 70 00 00 00       	mov    $0x70,%edx
8010295b:	89 e5                	mov    %esp,%ebp
8010295d:	53                   	push   %ebx
8010295e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102961:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102964:	ee                   	out    %al,(%dx)
80102965:	b8 0a 00 00 00       	mov    $0xa,%eax
8010296a:	ba 71 00 00 00       	mov    $0x71,%edx
8010296f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102970:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102972:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102975:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010297b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010297d:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80102980:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102982:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102985:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102988:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010298e:	a1 80 26 11 80       	mov    0x80112680,%eax
80102993:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102999:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010299c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801029a3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029a6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029a9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801029b0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029b3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029b6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029bc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029bf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029c5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029c8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029ce:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029d1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029d7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
801029da:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029dd:	c9                   	leave  
801029de:	c3                   	ret    
801029df:	90                   	nop

801029e0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801029e0:	55                   	push   %ebp
801029e1:	b8 0b 00 00 00       	mov    $0xb,%eax
801029e6:	ba 70 00 00 00       	mov    $0x70,%edx
801029eb:	89 e5                	mov    %esp,%ebp
801029ed:	57                   	push   %edi
801029ee:	56                   	push   %esi
801029ef:	53                   	push   %ebx
801029f0:	83 ec 4c             	sub    $0x4c,%esp
801029f3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029f4:	ba 71 00 00 00       	mov    $0x71,%edx
801029f9:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
801029fa:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029fd:	bb 70 00 00 00       	mov    $0x70,%ebx
80102a02:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102a05:	8d 76 00             	lea    0x0(%esi),%esi
80102a08:	31 c0                	xor    %eax,%eax
80102a0a:	89 da                	mov    %ebx,%edx
80102a0c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a0d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102a12:	89 ca                	mov    %ecx,%edx
80102a14:	ec                   	in     (%dx),%al
80102a15:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a18:	89 da                	mov    %ebx,%edx
80102a1a:	b8 02 00 00 00       	mov    $0x2,%eax
80102a1f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a20:	89 ca                	mov    %ecx,%edx
80102a22:	ec                   	in     (%dx),%al
80102a23:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a26:	89 da                	mov    %ebx,%edx
80102a28:	b8 04 00 00 00       	mov    $0x4,%eax
80102a2d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a2e:	89 ca                	mov    %ecx,%edx
80102a30:	ec                   	in     (%dx),%al
80102a31:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a34:	89 da                	mov    %ebx,%edx
80102a36:	b8 07 00 00 00       	mov    $0x7,%eax
80102a3b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a3c:	89 ca                	mov    %ecx,%edx
80102a3e:	ec                   	in     (%dx),%al
80102a3f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a42:	89 da                	mov    %ebx,%edx
80102a44:	b8 08 00 00 00       	mov    $0x8,%eax
80102a49:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a4a:	89 ca                	mov    %ecx,%edx
80102a4c:	ec                   	in     (%dx),%al
80102a4d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a4f:	89 da                	mov    %ebx,%edx
80102a51:	b8 09 00 00 00       	mov    $0x9,%eax
80102a56:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a57:	89 ca                	mov    %ecx,%edx
80102a59:	ec                   	in     (%dx),%al
80102a5a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a5c:	89 da                	mov    %ebx,%edx
80102a5e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a63:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a64:	89 ca                	mov    %ecx,%edx
80102a66:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102a67:	84 c0                	test   %al,%al
80102a69:	78 9d                	js     80102a08 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102a6b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102a6f:	89 fa                	mov    %edi,%edx
80102a71:	0f b6 fa             	movzbl %dl,%edi
80102a74:	89 f2                	mov    %esi,%edx
80102a76:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102a79:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102a7d:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a80:	89 da                	mov    %ebx,%edx
80102a82:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102a85:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102a88:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102a8c:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102a8f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102a92:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102a96:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102a99:	31 c0                	xor    %eax,%eax
80102a9b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a9c:	89 ca                	mov    %ecx,%edx
80102a9e:	ec                   	in     (%dx),%al
80102a9f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aa2:	89 da                	mov    %ebx,%edx
80102aa4:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102aa7:	b8 02 00 00 00       	mov    $0x2,%eax
80102aac:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102aad:	89 ca                	mov    %ecx,%edx
80102aaf:	ec                   	in     (%dx),%al
80102ab0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ab3:	89 da                	mov    %ebx,%edx
80102ab5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102ab8:	b8 04 00 00 00       	mov    $0x4,%eax
80102abd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102abe:	89 ca                	mov    %ecx,%edx
80102ac0:	ec                   	in     (%dx),%al
80102ac1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ac4:	89 da                	mov    %ebx,%edx
80102ac6:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102ac9:	b8 07 00 00 00       	mov    $0x7,%eax
80102ace:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102acf:	89 ca                	mov    %ecx,%edx
80102ad1:	ec                   	in     (%dx),%al
80102ad2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ad5:	89 da                	mov    %ebx,%edx
80102ad7:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102ada:	b8 08 00 00 00       	mov    $0x8,%eax
80102adf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ae0:	89 ca                	mov    %ecx,%edx
80102ae2:	ec                   	in     (%dx),%al
80102ae3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ae6:	89 da                	mov    %ebx,%edx
80102ae8:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102aeb:	b8 09 00 00 00       	mov    $0x9,%eax
80102af0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102af1:	89 ca                	mov    %ecx,%edx
80102af3:	ec                   	in     (%dx),%al
80102af4:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102af7:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102afa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102afd:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102b00:	6a 18                	push   $0x18
80102b02:	50                   	push   %eax
80102b03:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102b06:	50                   	push   %eax
80102b07:	e8 b4 27 00 00       	call   801052c0 <memcmp>
80102b0c:	83 c4 10             	add    $0x10,%esp
80102b0f:	85 c0                	test   %eax,%eax
80102b11:	0f 85 f1 fe ff ff    	jne    80102a08 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102b17:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102b1b:	75 78                	jne    80102b95 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102b1d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b20:	89 c2                	mov    %eax,%edx
80102b22:	83 e0 0f             	and    $0xf,%eax
80102b25:	c1 ea 04             	shr    $0x4,%edx
80102b28:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b2b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b2e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102b31:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b34:	89 c2                	mov    %eax,%edx
80102b36:	83 e0 0f             	and    $0xf,%eax
80102b39:	c1 ea 04             	shr    $0x4,%edx
80102b3c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b3f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b42:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102b45:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b48:	89 c2                	mov    %eax,%edx
80102b4a:	83 e0 0f             	and    $0xf,%eax
80102b4d:	c1 ea 04             	shr    $0x4,%edx
80102b50:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b53:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b56:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102b59:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b5c:	89 c2                	mov    %eax,%edx
80102b5e:	83 e0 0f             	and    $0xf,%eax
80102b61:	c1 ea 04             	shr    $0x4,%edx
80102b64:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b67:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b6a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102b6d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b70:	89 c2                	mov    %eax,%edx
80102b72:	83 e0 0f             	and    $0xf,%eax
80102b75:	c1 ea 04             	shr    $0x4,%edx
80102b78:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b7b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b7e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102b81:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b84:	89 c2                	mov    %eax,%edx
80102b86:	83 e0 0f             	and    $0xf,%eax
80102b89:	c1 ea 04             	shr    $0x4,%edx
80102b8c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b8f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b92:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102b95:	8b 75 08             	mov    0x8(%ebp),%esi
80102b98:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b9b:	89 06                	mov    %eax,(%esi)
80102b9d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ba0:	89 46 04             	mov    %eax,0x4(%esi)
80102ba3:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ba6:	89 46 08             	mov    %eax,0x8(%esi)
80102ba9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102bac:	89 46 0c             	mov    %eax,0xc(%esi)
80102baf:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102bb2:	89 46 10             	mov    %eax,0x10(%esi)
80102bb5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102bb8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102bbb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102bc2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102bc5:	5b                   	pop    %ebx
80102bc6:	5e                   	pop    %esi
80102bc7:	5f                   	pop    %edi
80102bc8:	5d                   	pop    %ebp
80102bc9:	c3                   	ret    
80102bca:	66 90                	xchg   %ax,%ax
80102bcc:	66 90                	xchg   %ax,%ax
80102bce:	66 90                	xchg   %ax,%ax

80102bd0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102bd0:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102bd6:	85 c9                	test   %ecx,%ecx
80102bd8:	0f 8e 8a 00 00 00    	jle    80102c68 <install_trans+0x98>
{
80102bde:	55                   	push   %ebp
80102bdf:	89 e5                	mov    %esp,%ebp
80102be1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102be2:	31 ff                	xor    %edi,%edi
{
80102be4:	56                   	push   %esi
80102be5:	53                   	push   %ebx
80102be6:	83 ec 0c             	sub    $0xc,%esp
80102be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102bf0:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102bf5:	83 ec 08             	sub    $0x8,%esp
80102bf8:	01 f8                	add    %edi,%eax
80102bfa:	83 c0 01             	add    $0x1,%eax
80102bfd:	50                   	push   %eax
80102bfe:	ff 35 e4 26 11 80    	push   0x801126e4
80102c04:	e8 c7 d4 ff ff       	call   801000d0 <bread>
80102c09:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102c0b:	58                   	pop    %eax
80102c0c:	5a                   	pop    %edx
80102c0d:	ff 34 bd ec 26 11 80 	push   -0x7feed914(,%edi,4)
80102c14:	ff 35 e4 26 11 80    	push   0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102c1a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102c1d:	e8 ae d4 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102c22:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102c25:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102c27:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c2a:	68 00 02 00 00       	push   $0x200
80102c2f:	50                   	push   %eax
80102c30:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102c33:	50                   	push   %eax
80102c34:	e8 d7 26 00 00       	call   80105310 <memmove>
    bwrite(dbuf);  // write dst to disk
80102c39:	89 1c 24             	mov    %ebx,(%esp)
80102c3c:	e8 6f d5 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102c41:	89 34 24             	mov    %esi,(%esp)
80102c44:	e8 a7 d5 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102c49:	89 1c 24             	mov    %ebx,(%esp)
80102c4c:	e8 9f d5 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102c51:	83 c4 10             	add    $0x10,%esp
80102c54:	39 3d e8 26 11 80    	cmp    %edi,0x801126e8
80102c5a:	7f 94                	jg     80102bf0 <install_trans+0x20>
  }
}
80102c5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c5f:	5b                   	pop    %ebx
80102c60:	5e                   	pop    %esi
80102c61:	5f                   	pop    %edi
80102c62:	5d                   	pop    %ebp
80102c63:	c3                   	ret    
80102c64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c68:	c3                   	ret    
80102c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102c70 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102c70:	55                   	push   %ebp
80102c71:	89 e5                	mov    %esp,%ebp
80102c73:	53                   	push   %ebx
80102c74:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c77:	ff 35 d4 26 11 80    	push   0x801126d4
80102c7d:	ff 35 e4 26 11 80    	push   0x801126e4
80102c83:	e8 48 d4 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c88:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c8b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102c8d:	a1 e8 26 11 80       	mov    0x801126e8,%eax
80102c92:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102c95:	85 c0                	test   %eax,%eax
80102c97:	7e 19                	jle    80102cb2 <write_head+0x42>
80102c99:	31 d2                	xor    %edx,%edx
80102c9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c9f:	90                   	nop
    hb->block[i] = log.lh.block[i];
80102ca0:	8b 0c 95 ec 26 11 80 	mov    -0x7feed914(,%edx,4),%ecx
80102ca7:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102cab:	83 c2 01             	add    $0x1,%edx
80102cae:	39 d0                	cmp    %edx,%eax
80102cb0:	75 ee                	jne    80102ca0 <write_head+0x30>
  }
  bwrite(buf);
80102cb2:	83 ec 0c             	sub    $0xc,%esp
80102cb5:	53                   	push   %ebx
80102cb6:	e8 f5 d4 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102cbb:	89 1c 24             	mov    %ebx,(%esp)
80102cbe:	e8 2d d5 ff ff       	call   801001f0 <brelse>
}
80102cc3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102cc6:	83 c4 10             	add    $0x10,%esp
80102cc9:	c9                   	leave  
80102cca:	c3                   	ret    
80102ccb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ccf:	90                   	nop

80102cd0 <initlog>:
{
80102cd0:	55                   	push   %ebp
80102cd1:	89 e5                	mov    %esp,%ebp
80102cd3:	53                   	push   %ebx
80102cd4:	83 ec 2c             	sub    $0x2c,%esp
80102cd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102cda:	68 60 84 10 80       	push   $0x80108460
80102cdf:	68 a0 26 11 80       	push   $0x801126a0
80102ce4:	e8 f7 22 00 00       	call   80104fe0 <initlock>
  readsb(dev, &sb);
80102ce9:	58                   	pop    %eax
80102cea:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102ced:	5a                   	pop    %edx
80102cee:	50                   	push   %eax
80102cef:	53                   	push   %ebx
80102cf0:	e8 3b e8 ff ff       	call   80101530 <readsb>
  log.start = sb.logstart;
80102cf5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102cf8:	59                   	pop    %ecx
  log.dev = dev;
80102cf9:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
  log.size = sb.nlog;
80102cff:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102d02:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  log.size = sb.nlog;
80102d07:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
  struct buf *buf = bread(log.dev, log.start);
80102d0d:	5a                   	pop    %edx
80102d0e:	50                   	push   %eax
80102d0f:	53                   	push   %ebx
80102d10:	e8 bb d3 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102d15:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102d18:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102d1b:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102d21:	85 db                	test   %ebx,%ebx
80102d23:	7e 1d                	jle    80102d42 <initlog+0x72>
80102d25:	31 d2                	xor    %edx,%edx
80102d27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d2e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102d30:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102d34:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102d3b:	83 c2 01             	add    $0x1,%edx
80102d3e:	39 d3                	cmp    %edx,%ebx
80102d40:	75 ee                	jne    80102d30 <initlog+0x60>
  brelse(buf);
80102d42:	83 ec 0c             	sub    $0xc,%esp
80102d45:	50                   	push   %eax
80102d46:	e8 a5 d4 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102d4b:	e8 80 fe ff ff       	call   80102bd0 <install_trans>
  log.lh.n = 0;
80102d50:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102d57:	00 00 00 
  write_head(); // clear the log
80102d5a:	e8 11 ff ff ff       	call   80102c70 <write_head>
}
80102d5f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d62:	83 c4 10             	add    $0x10,%esp
80102d65:	c9                   	leave  
80102d66:	c3                   	ret    
80102d67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d6e:	66 90                	xchg   %ax,%ax

80102d70 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102d70:	55                   	push   %ebp
80102d71:	89 e5                	mov    %esp,%ebp
80102d73:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102d76:	68 a0 26 11 80       	push   $0x801126a0
80102d7b:	e8 30 24 00 00       	call   801051b0 <acquire>
80102d80:	83 c4 10             	add    $0x10,%esp
80102d83:	eb 18                	jmp    80102d9d <begin_op+0x2d>
80102d85:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102d88:	83 ec 08             	sub    $0x8,%esp
80102d8b:	68 a0 26 11 80       	push   $0x801126a0
80102d90:	68 a0 26 11 80       	push   $0x801126a0
80102d95:	e8 16 16 00 00       	call   801043b0 <sleep>
80102d9a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102d9d:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102da2:	85 c0                	test   %eax,%eax
80102da4:	75 e2                	jne    80102d88 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102da6:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102dab:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102db1:	83 c0 01             	add    $0x1,%eax
80102db4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102db7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102dba:	83 fa 1e             	cmp    $0x1e,%edx
80102dbd:	7f c9                	jg     80102d88 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102dbf:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102dc2:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102dc7:	68 a0 26 11 80       	push   $0x801126a0
80102dcc:	e8 7f 23 00 00       	call   80105150 <release>
      break;
    }
  }
}
80102dd1:	83 c4 10             	add    $0x10,%esp
80102dd4:	c9                   	leave  
80102dd5:	c3                   	ret    
80102dd6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ddd:	8d 76 00             	lea    0x0(%esi),%esi

80102de0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102de0:	55                   	push   %ebp
80102de1:	89 e5                	mov    %esp,%ebp
80102de3:	57                   	push   %edi
80102de4:	56                   	push   %esi
80102de5:	53                   	push   %ebx
80102de6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102de9:	68 a0 26 11 80       	push   $0x801126a0
80102dee:	e8 bd 23 00 00       	call   801051b0 <acquire>
  log.outstanding -= 1;
80102df3:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102df8:	8b 35 e0 26 11 80    	mov    0x801126e0,%esi
80102dfe:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102e01:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102e04:	89 1d dc 26 11 80    	mov    %ebx,0x801126dc
  if(log.committing)
80102e0a:	85 f6                	test   %esi,%esi
80102e0c:	0f 85 22 01 00 00    	jne    80102f34 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102e12:	85 db                	test   %ebx,%ebx
80102e14:	0f 85 f6 00 00 00    	jne    80102f10 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102e1a:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102e21:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102e24:	83 ec 0c             	sub    $0xc,%esp
80102e27:	68 a0 26 11 80       	push   $0x801126a0
80102e2c:	e8 1f 23 00 00       	call   80105150 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102e31:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102e37:	83 c4 10             	add    $0x10,%esp
80102e3a:	85 c9                	test   %ecx,%ecx
80102e3c:	7f 42                	jg     80102e80 <end_op+0xa0>
    acquire(&log.lock);
80102e3e:	83 ec 0c             	sub    $0xc,%esp
80102e41:	68 a0 26 11 80       	push   $0x801126a0
80102e46:	e8 65 23 00 00       	call   801051b0 <acquire>
    wakeup(&log);
80102e4b:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
    log.committing = 0;
80102e52:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102e59:	00 00 00 
    wakeup(&log);
80102e5c:	e8 0f 16 00 00       	call   80104470 <wakeup>
    release(&log.lock);
80102e61:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102e68:	e8 e3 22 00 00       	call   80105150 <release>
80102e6d:	83 c4 10             	add    $0x10,%esp
}
80102e70:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e73:	5b                   	pop    %ebx
80102e74:	5e                   	pop    %esi
80102e75:	5f                   	pop    %edi
80102e76:	5d                   	pop    %ebp
80102e77:	c3                   	ret    
80102e78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e7f:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102e80:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102e85:	83 ec 08             	sub    $0x8,%esp
80102e88:	01 d8                	add    %ebx,%eax
80102e8a:	83 c0 01             	add    $0x1,%eax
80102e8d:	50                   	push   %eax
80102e8e:	ff 35 e4 26 11 80    	push   0x801126e4
80102e94:	e8 37 d2 ff ff       	call   801000d0 <bread>
80102e99:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e9b:	58                   	pop    %eax
80102e9c:	5a                   	pop    %edx
80102e9d:	ff 34 9d ec 26 11 80 	push   -0x7feed914(,%ebx,4)
80102ea4:	ff 35 e4 26 11 80    	push   0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102eaa:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102ead:	e8 1e d2 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102eb2:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102eb5:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102eb7:	8d 40 5c             	lea    0x5c(%eax),%eax
80102eba:	68 00 02 00 00       	push   $0x200
80102ebf:	50                   	push   %eax
80102ec0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102ec3:	50                   	push   %eax
80102ec4:	e8 47 24 00 00       	call   80105310 <memmove>
    bwrite(to);  // write the log
80102ec9:	89 34 24             	mov    %esi,(%esp)
80102ecc:	e8 df d2 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80102ed1:	89 3c 24             	mov    %edi,(%esp)
80102ed4:	e8 17 d3 ff ff       	call   801001f0 <brelse>
    brelse(to);
80102ed9:	89 34 24             	mov    %esi,(%esp)
80102edc:	e8 0f d3 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102ee1:	83 c4 10             	add    $0x10,%esp
80102ee4:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102eea:	7c 94                	jl     80102e80 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102eec:	e8 7f fd ff ff       	call   80102c70 <write_head>
    install_trans(); // Now install writes to home locations
80102ef1:	e8 da fc ff ff       	call   80102bd0 <install_trans>
    log.lh.n = 0;
80102ef6:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102efd:	00 00 00 
    write_head();    // Erase the transaction from the log
80102f00:	e8 6b fd ff ff       	call   80102c70 <write_head>
80102f05:	e9 34 ff ff ff       	jmp    80102e3e <end_op+0x5e>
80102f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80102f10:	83 ec 0c             	sub    $0xc,%esp
80102f13:	68 a0 26 11 80       	push   $0x801126a0
80102f18:	e8 53 15 00 00       	call   80104470 <wakeup>
  release(&log.lock);
80102f1d:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102f24:	e8 27 22 00 00       	call   80105150 <release>
80102f29:	83 c4 10             	add    $0x10,%esp
}
80102f2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f2f:	5b                   	pop    %ebx
80102f30:	5e                   	pop    %esi
80102f31:	5f                   	pop    %edi
80102f32:	5d                   	pop    %ebp
80102f33:	c3                   	ret    
    panic("log.committing");
80102f34:	83 ec 0c             	sub    $0xc,%esp
80102f37:	68 64 84 10 80       	push   $0x80108464
80102f3c:	e8 3f d4 ff ff       	call   80100380 <panic>
80102f41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f4f:	90                   	nop

80102f50 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102f50:	55                   	push   %ebp
80102f51:	89 e5                	mov    %esp,%ebp
80102f53:	53                   	push   %ebx
80102f54:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f57:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
{
80102f5d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f60:	83 fa 1d             	cmp    $0x1d,%edx
80102f63:	0f 8f 85 00 00 00    	jg     80102fee <log_write+0x9e>
80102f69:	a1 d8 26 11 80       	mov    0x801126d8,%eax
80102f6e:	83 e8 01             	sub    $0x1,%eax
80102f71:	39 c2                	cmp    %eax,%edx
80102f73:	7d 79                	jge    80102fee <log_write+0x9e>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102f75:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102f7a:	85 c0                	test   %eax,%eax
80102f7c:	7e 7d                	jle    80102ffb <log_write+0xab>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102f7e:	83 ec 0c             	sub    $0xc,%esp
80102f81:	68 a0 26 11 80       	push   $0x801126a0
80102f86:	e8 25 22 00 00       	call   801051b0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102f8b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102f91:	83 c4 10             	add    $0x10,%esp
80102f94:	85 d2                	test   %edx,%edx
80102f96:	7e 4a                	jle    80102fe2 <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f98:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102f9b:	31 c0                	xor    %eax,%eax
80102f9d:	eb 08                	jmp    80102fa7 <log_write+0x57>
80102f9f:	90                   	nop
80102fa0:	83 c0 01             	add    $0x1,%eax
80102fa3:	39 c2                	cmp    %eax,%edx
80102fa5:	74 29                	je     80102fd0 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102fa7:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
80102fae:	75 f0                	jne    80102fa0 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80102fb0:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80102fb7:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80102fba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80102fbd:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80102fc4:	c9                   	leave  
  release(&log.lock);
80102fc5:	e9 86 21 00 00       	jmp    80105150 <release>
80102fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102fd0:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
    log.lh.n++;
80102fd7:	83 c2 01             	add    $0x1,%edx
80102fda:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
80102fe0:	eb d5                	jmp    80102fb7 <log_write+0x67>
  log.lh.block[i] = b->blockno;
80102fe2:	8b 43 08             	mov    0x8(%ebx),%eax
80102fe5:	a3 ec 26 11 80       	mov    %eax,0x801126ec
  if (i == log.lh.n)
80102fea:	75 cb                	jne    80102fb7 <log_write+0x67>
80102fec:	eb e9                	jmp    80102fd7 <log_write+0x87>
    panic("too big a transaction");
80102fee:	83 ec 0c             	sub    $0xc,%esp
80102ff1:	68 73 84 10 80       	push   $0x80108473
80102ff6:	e8 85 d3 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
80102ffb:	83 ec 0c             	sub    $0xc,%esp
80102ffe:	68 89 84 10 80       	push   $0x80108489
80103003:	e8 78 d3 ff ff       	call   80100380 <panic>
80103008:	66 90                	xchg   %ax,%ax
8010300a:	66 90                	xchg   %ax,%ax
8010300c:	66 90                	xchg   %ax,%ax
8010300e:	66 90                	xchg   %ax,%ax

80103010 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103010:	55                   	push   %ebp
80103011:	89 e5                	mov    %esp,%ebp
80103013:	53                   	push   %ebx
80103014:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103017:	e8 84 09 00 00       	call   801039a0 <cpuid>
8010301c:	89 c3                	mov    %eax,%ebx
8010301e:	e8 7d 09 00 00       	call   801039a0 <cpuid>
80103023:	83 ec 04             	sub    $0x4,%esp
80103026:	53                   	push   %ebx
80103027:	50                   	push   %eax
80103028:	68 a4 84 10 80       	push   $0x801084a4
8010302d:	e8 6e d6 ff ff       	call   801006a0 <cprintf>
  idtinit();       // load idt register
80103032:	e8 d9 36 00 00       	call   80106710 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103037:	e8 04 09 00 00       	call   80103940 <mycpu>
8010303c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010303e:	b8 01 00 00 00       	mov    $0x1,%eax
80103043:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010304a:	e8 71 0e 00 00       	call   80103ec0 <scheduler>
8010304f:	90                   	nop

80103050 <mpenter>:
{
80103050:	55                   	push   %ebp
80103051:	89 e5                	mov    %esp,%ebp
80103053:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103056:	e8 a5 47 00 00       	call   80107800 <switchkvm>
  seginit();
8010305b:	e8 10 47 00 00       	call   80107770 <seginit>
  lapicinit();
80103060:	e8 9b f7 ff ff       	call   80102800 <lapicinit>
  mpmain();
80103065:	e8 a6 ff ff ff       	call   80103010 <mpmain>
8010306a:	66 90                	xchg   %ax,%ax
8010306c:	66 90                	xchg   %ax,%ax
8010306e:	66 90                	xchg   %ax,%ax

80103070 <main>:
{
80103070:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103074:	83 e4 f0             	and    $0xfffffff0,%esp
80103077:	ff 71 fc             	push   -0x4(%ecx)
8010307a:	55                   	push   %ebp
8010307b:	89 e5                	mov    %esp,%ebp
8010307d:	53                   	push   %ebx
8010307e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010307f:	83 ec 08             	sub    $0x8,%esp
80103082:	68 00 00 40 80       	push   $0x80400000
80103087:	68 50 6f 11 80       	push   $0x80116f50
8010308c:	e8 8f f5 ff ff       	call   80102620 <kinit1>
  kvmalloc();      // kernel page table
80103091:	e8 5a 4c 00 00       	call   80107cf0 <kvmalloc>
  mpinit();        // detect other processors
80103096:	e8 85 01 00 00       	call   80103220 <mpinit>
  lapicinit();     // interrupt controller
8010309b:	e8 60 f7 ff ff       	call   80102800 <lapicinit>
  seginit();       // segment descriptors
801030a0:	e8 cb 46 00 00       	call   80107770 <seginit>
  picinit();       // disable pic
801030a5:	e8 76 03 00 00       	call   80103420 <picinit>
  ioapicinit();    // another interrupt controller
801030aa:	e8 31 f3 ff ff       	call   801023e0 <ioapicinit>
  consoleinit();   // console hardware
801030af:	e8 ac d9 ff ff       	call   80100a60 <consoleinit>
  uartinit();      // serial port
801030b4:	e8 47 39 00 00       	call   80106a00 <uartinit>
  pinit();         // process table
801030b9:	e8 62 08 00 00       	call   80103920 <pinit>
  tvinit();        // trap vectors
801030be:	e8 cd 35 00 00       	call   80106690 <tvinit>
  binit();         // buffer cache
801030c3:	e8 78 cf ff ff       	call   80100040 <binit>
  fileinit();      // file table
801030c8:	e8 53 dd ff ff       	call   80100e20 <fileinit>
  ideinit();       // disk 
801030cd:	e8 fe f0 ff ff       	call   801021d0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801030d2:	83 c4 0c             	add    $0xc,%esp
801030d5:	68 8a 00 00 00       	push   $0x8a
801030da:	68 8c b4 10 80       	push   $0x8010b48c
801030df:	68 00 70 00 80       	push   $0x80007000
801030e4:	e8 27 22 00 00       	call   80105310 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801030e9:	83 c4 10             	add    $0x10,%esp
801030ec:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
801030f3:	00 00 00 
801030f6:	05 a0 27 11 80       	add    $0x801127a0,%eax
801030fb:	3d a0 27 11 80       	cmp    $0x801127a0,%eax
80103100:	76 7e                	jbe    80103180 <main+0x110>
80103102:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
80103107:	eb 20                	jmp    80103129 <main+0xb9>
80103109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103110:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
80103117:	00 00 00 
8010311a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103120:	05 a0 27 11 80       	add    $0x801127a0,%eax
80103125:	39 c3                	cmp    %eax,%ebx
80103127:	73 57                	jae    80103180 <main+0x110>
    if(c == mycpu())  // We've started already.
80103129:	e8 12 08 00 00       	call   80103940 <mycpu>
8010312e:	39 c3                	cmp    %eax,%ebx
80103130:	74 de                	je     80103110 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103132:	e8 59 f5 ff ff       	call   80102690 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103137:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
8010313a:	c7 05 f8 6f 00 80 50 	movl   $0x80103050,0x80006ff8
80103141:	30 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103144:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010314b:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010314e:	05 00 10 00 00       	add    $0x1000,%eax
80103153:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103158:	0f b6 03             	movzbl (%ebx),%eax
8010315b:	68 00 70 00 00       	push   $0x7000
80103160:	50                   	push   %eax
80103161:	e8 ea f7 ff ff       	call   80102950 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103166:	83 c4 10             	add    $0x10,%esp
80103169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103170:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103176:	85 c0                	test   %eax,%eax
80103178:	74 f6                	je     80103170 <main+0x100>
8010317a:	eb 94                	jmp    80103110 <main+0xa0>
8010317c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103180:	83 ec 08             	sub    $0x8,%esp
80103183:	68 00 00 00 8e       	push   $0x8e000000
80103188:	68 00 00 40 80       	push   $0x80400000
8010318d:	e8 2e f4 ff ff       	call   801025c0 <kinit2>
  userinit();      // first user process
80103192:	e8 59 08 00 00       	call   801039f0 <userinit>
  mpmain();        // finish this processor's setup
80103197:	e8 74 fe ff ff       	call   80103010 <mpmain>
8010319c:	66 90                	xchg   %ax,%ax
8010319e:	66 90                	xchg   %ax,%ax

801031a0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801031a0:	55                   	push   %ebp
801031a1:	89 e5                	mov    %esp,%ebp
801031a3:	57                   	push   %edi
801031a4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801031a5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801031ab:	53                   	push   %ebx
  e = addr+len;
801031ac:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801031af:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801031b2:	39 de                	cmp    %ebx,%esi
801031b4:	72 10                	jb     801031c6 <mpsearch1+0x26>
801031b6:	eb 50                	jmp    80103208 <mpsearch1+0x68>
801031b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031bf:	90                   	nop
801031c0:	89 fe                	mov    %edi,%esi
801031c2:	39 fb                	cmp    %edi,%ebx
801031c4:	76 42                	jbe    80103208 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801031c6:	83 ec 04             	sub    $0x4,%esp
801031c9:	8d 7e 10             	lea    0x10(%esi),%edi
801031cc:	6a 04                	push   $0x4
801031ce:	68 b8 84 10 80       	push   $0x801084b8
801031d3:	56                   	push   %esi
801031d4:	e8 e7 20 00 00       	call   801052c0 <memcmp>
801031d9:	83 c4 10             	add    $0x10,%esp
801031dc:	85 c0                	test   %eax,%eax
801031de:	75 e0                	jne    801031c0 <mpsearch1+0x20>
801031e0:	89 f2                	mov    %esi,%edx
801031e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801031e8:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801031eb:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801031ee:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801031f0:	39 fa                	cmp    %edi,%edx
801031f2:	75 f4                	jne    801031e8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801031f4:	84 c0                	test   %al,%al
801031f6:	75 c8                	jne    801031c0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801031f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031fb:	89 f0                	mov    %esi,%eax
801031fd:	5b                   	pop    %ebx
801031fe:	5e                   	pop    %esi
801031ff:	5f                   	pop    %edi
80103200:	5d                   	pop    %ebp
80103201:	c3                   	ret    
80103202:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103208:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010320b:	31 f6                	xor    %esi,%esi
}
8010320d:	5b                   	pop    %ebx
8010320e:	89 f0                	mov    %esi,%eax
80103210:	5e                   	pop    %esi
80103211:	5f                   	pop    %edi
80103212:	5d                   	pop    %ebp
80103213:	c3                   	ret    
80103214:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010321b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010321f:	90                   	nop

80103220 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103220:	55                   	push   %ebp
80103221:	89 e5                	mov    %esp,%ebp
80103223:	57                   	push   %edi
80103224:	56                   	push   %esi
80103225:	53                   	push   %ebx
80103226:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103229:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103230:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103237:	c1 e0 08             	shl    $0x8,%eax
8010323a:	09 d0                	or     %edx,%eax
8010323c:	c1 e0 04             	shl    $0x4,%eax
8010323f:	75 1b                	jne    8010325c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103241:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103248:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010324f:	c1 e0 08             	shl    $0x8,%eax
80103252:	09 d0                	or     %edx,%eax
80103254:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103257:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010325c:	ba 00 04 00 00       	mov    $0x400,%edx
80103261:	e8 3a ff ff ff       	call   801031a0 <mpsearch1>
80103266:	89 c3                	mov    %eax,%ebx
80103268:	85 c0                	test   %eax,%eax
8010326a:	0f 84 40 01 00 00    	je     801033b0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103270:	8b 73 04             	mov    0x4(%ebx),%esi
80103273:	85 f6                	test   %esi,%esi
80103275:	0f 84 25 01 00 00    	je     801033a0 <mpinit+0x180>
  if(memcmp(conf, "PCMP", 4) != 0)
8010327b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010327e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103284:	6a 04                	push   $0x4
80103286:	68 bd 84 10 80       	push   $0x801084bd
8010328b:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010328c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
8010328f:	e8 2c 20 00 00       	call   801052c0 <memcmp>
80103294:	83 c4 10             	add    $0x10,%esp
80103297:	85 c0                	test   %eax,%eax
80103299:	0f 85 01 01 00 00    	jne    801033a0 <mpinit+0x180>
  if(conf->version != 1 && conf->version != 4)
8010329f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
801032a6:	3c 01                	cmp    $0x1,%al
801032a8:	74 08                	je     801032b2 <mpinit+0x92>
801032aa:	3c 04                	cmp    $0x4,%al
801032ac:	0f 85 ee 00 00 00    	jne    801033a0 <mpinit+0x180>
  if(sum((uchar*)conf, conf->length) != 0)
801032b2:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
801032b9:	66 85 d2             	test   %dx,%dx
801032bc:	74 22                	je     801032e0 <mpinit+0xc0>
801032be:	8d 3c 32             	lea    (%edx,%esi,1),%edi
801032c1:	89 f0                	mov    %esi,%eax
  sum = 0;
801032c3:	31 d2                	xor    %edx,%edx
801032c5:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801032c8:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
801032cf:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801032d2:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801032d4:	39 c7                	cmp    %eax,%edi
801032d6:	75 f0                	jne    801032c8 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
801032d8:	84 d2                	test   %dl,%dl
801032da:	0f 85 c0 00 00 00    	jne    801033a0 <mpinit+0x180>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801032e0:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
801032e6:	a3 80 26 11 80       	mov    %eax,0x80112680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032eb:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
801032f2:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
  ismp = 1;
801032f8:	be 01 00 00 00       	mov    $0x1,%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032fd:	03 55 e4             	add    -0x1c(%ebp),%edx
80103300:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80103303:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103307:	90                   	nop
80103308:	39 d0                	cmp    %edx,%eax
8010330a:	73 15                	jae    80103321 <mpinit+0x101>
    switch(*p){
8010330c:	0f b6 08             	movzbl (%eax),%ecx
8010330f:	80 f9 02             	cmp    $0x2,%cl
80103312:	74 4c                	je     80103360 <mpinit+0x140>
80103314:	77 3a                	ja     80103350 <mpinit+0x130>
80103316:	84 c9                	test   %cl,%cl
80103318:	74 56                	je     80103370 <mpinit+0x150>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
8010331a:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010331d:	39 d0                	cmp    %edx,%eax
8010331f:	72 eb                	jb     8010330c <mpinit+0xec>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103321:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103324:	85 f6                	test   %esi,%esi
80103326:	0f 84 d9 00 00 00    	je     80103405 <mpinit+0x1e5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010332c:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80103330:	74 15                	je     80103347 <mpinit+0x127>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103332:	b8 70 00 00 00       	mov    $0x70,%eax
80103337:	ba 22 00 00 00       	mov    $0x22,%edx
8010333c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010333d:	ba 23 00 00 00       	mov    $0x23,%edx
80103342:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103343:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103346:	ee                   	out    %al,(%dx)
  }
}
80103347:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010334a:	5b                   	pop    %ebx
8010334b:	5e                   	pop    %esi
8010334c:	5f                   	pop    %edi
8010334d:	5d                   	pop    %ebp
8010334e:	c3                   	ret    
8010334f:	90                   	nop
    switch(*p){
80103350:	83 e9 03             	sub    $0x3,%ecx
80103353:	80 f9 01             	cmp    $0x1,%cl
80103356:	76 c2                	jbe    8010331a <mpinit+0xfa>
80103358:	31 f6                	xor    %esi,%esi
8010335a:	eb ac                	jmp    80103308 <mpinit+0xe8>
8010335c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103360:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103364:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103367:	88 0d 80 27 11 80    	mov    %cl,0x80112780
      continue;
8010336d:	eb 99                	jmp    80103308 <mpinit+0xe8>
8010336f:	90                   	nop
      if(ncpu < NCPU) {
80103370:	8b 0d 84 27 11 80    	mov    0x80112784,%ecx
80103376:	83 f9 07             	cmp    $0x7,%ecx
80103379:	7f 19                	jg     80103394 <mpinit+0x174>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010337b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103381:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103385:	83 c1 01             	add    $0x1,%ecx
80103388:	89 0d 84 27 11 80    	mov    %ecx,0x80112784
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010338e:	88 9f a0 27 11 80    	mov    %bl,-0x7feed860(%edi)
      p += sizeof(struct mpproc);
80103394:	83 c0 14             	add    $0x14,%eax
      continue;
80103397:	e9 6c ff ff ff       	jmp    80103308 <mpinit+0xe8>
8010339c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
801033a0:	83 ec 0c             	sub    $0xc,%esp
801033a3:	68 c2 84 10 80       	push   $0x801084c2
801033a8:	e8 d3 cf ff ff       	call   80100380 <panic>
801033ad:	8d 76 00             	lea    0x0(%esi),%esi
{
801033b0:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
801033b5:	eb 13                	jmp    801033ca <mpinit+0x1aa>
801033b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033be:	66 90                	xchg   %ax,%ax
  for(p = addr; p < e; p += sizeof(struct mp))
801033c0:	89 f3                	mov    %esi,%ebx
801033c2:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
801033c8:	74 d6                	je     801033a0 <mpinit+0x180>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033ca:	83 ec 04             	sub    $0x4,%esp
801033cd:	8d 73 10             	lea    0x10(%ebx),%esi
801033d0:	6a 04                	push   $0x4
801033d2:	68 b8 84 10 80       	push   $0x801084b8
801033d7:	53                   	push   %ebx
801033d8:	e8 e3 1e 00 00       	call   801052c0 <memcmp>
801033dd:	83 c4 10             	add    $0x10,%esp
801033e0:	85 c0                	test   %eax,%eax
801033e2:	75 dc                	jne    801033c0 <mpinit+0x1a0>
801033e4:	89 da                	mov    %ebx,%edx
801033e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033ed:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801033f0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801033f3:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801033f6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801033f8:	39 d6                	cmp    %edx,%esi
801033fa:	75 f4                	jne    801033f0 <mpinit+0x1d0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033fc:	84 c0                	test   %al,%al
801033fe:	75 c0                	jne    801033c0 <mpinit+0x1a0>
80103400:	e9 6b fe ff ff       	jmp    80103270 <mpinit+0x50>
    panic("Didn't find a suitable machine");
80103405:	83 ec 0c             	sub    $0xc,%esp
80103408:	68 dc 84 10 80       	push   $0x801084dc
8010340d:	e8 6e cf ff ff       	call   80100380 <panic>
80103412:	66 90                	xchg   %ax,%ax
80103414:	66 90                	xchg   %ax,%ax
80103416:	66 90                	xchg   %ax,%ax
80103418:	66 90                	xchg   %ax,%ax
8010341a:	66 90                	xchg   %ax,%ax
8010341c:	66 90                	xchg   %ax,%ax
8010341e:	66 90                	xchg   %ax,%ax

80103420 <picinit>:
80103420:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103425:	ba 21 00 00 00       	mov    $0x21,%edx
8010342a:	ee                   	out    %al,(%dx)
8010342b:	ba a1 00 00 00       	mov    $0xa1,%edx
80103430:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103431:	c3                   	ret    
80103432:	66 90                	xchg   %ax,%ax
80103434:	66 90                	xchg   %ax,%ax
80103436:	66 90                	xchg   %ax,%ax
80103438:	66 90                	xchg   %ax,%ax
8010343a:	66 90                	xchg   %ax,%ax
8010343c:	66 90                	xchg   %ax,%ax
8010343e:	66 90                	xchg   %ax,%ax

80103440 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103440:	55                   	push   %ebp
80103441:	89 e5                	mov    %esp,%ebp
80103443:	57                   	push   %edi
80103444:	56                   	push   %esi
80103445:	53                   	push   %ebx
80103446:	83 ec 0c             	sub    $0xc,%esp
80103449:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010344c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010344f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103455:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010345b:	e8 e0 d9 ff ff       	call   80100e40 <filealloc>
80103460:	89 03                	mov    %eax,(%ebx)
80103462:	85 c0                	test   %eax,%eax
80103464:	0f 84 a8 00 00 00    	je     80103512 <pipealloc+0xd2>
8010346a:	e8 d1 d9 ff ff       	call   80100e40 <filealloc>
8010346f:	89 06                	mov    %eax,(%esi)
80103471:	85 c0                	test   %eax,%eax
80103473:	0f 84 87 00 00 00    	je     80103500 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103479:	e8 12 f2 ff ff       	call   80102690 <kalloc>
8010347e:	89 c7                	mov    %eax,%edi
80103480:	85 c0                	test   %eax,%eax
80103482:	0f 84 b0 00 00 00    	je     80103538 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
80103488:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010348f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103492:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103495:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010349c:	00 00 00 
  p->nwrite = 0;
8010349f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801034a6:	00 00 00 
  p->nread = 0;
801034a9:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801034b0:	00 00 00 
  initlock(&p->lock, "pipe");
801034b3:	68 fb 84 10 80       	push   $0x801084fb
801034b8:	50                   	push   %eax
801034b9:	e8 22 1b 00 00       	call   80104fe0 <initlock>
  (*f0)->type = FD_PIPE;
801034be:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801034c0:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801034c3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801034c9:	8b 03                	mov    (%ebx),%eax
801034cb:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801034cf:	8b 03                	mov    (%ebx),%eax
801034d1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801034d5:	8b 03                	mov    (%ebx),%eax
801034d7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801034da:	8b 06                	mov    (%esi),%eax
801034dc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801034e2:	8b 06                	mov    (%esi),%eax
801034e4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801034e8:	8b 06                	mov    (%esi),%eax
801034ea:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801034ee:	8b 06                	mov    (%esi),%eax
801034f0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801034f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801034f6:	31 c0                	xor    %eax,%eax
}
801034f8:	5b                   	pop    %ebx
801034f9:	5e                   	pop    %esi
801034fa:	5f                   	pop    %edi
801034fb:	5d                   	pop    %ebp
801034fc:	c3                   	ret    
801034fd:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
80103500:	8b 03                	mov    (%ebx),%eax
80103502:	85 c0                	test   %eax,%eax
80103504:	74 1e                	je     80103524 <pipealloc+0xe4>
    fileclose(*f0);
80103506:	83 ec 0c             	sub    $0xc,%esp
80103509:	50                   	push   %eax
8010350a:	e8 f1 d9 ff ff       	call   80100f00 <fileclose>
8010350f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103512:	8b 06                	mov    (%esi),%eax
80103514:	85 c0                	test   %eax,%eax
80103516:	74 0c                	je     80103524 <pipealloc+0xe4>
    fileclose(*f1);
80103518:	83 ec 0c             	sub    $0xc,%esp
8010351b:	50                   	push   %eax
8010351c:	e8 df d9 ff ff       	call   80100f00 <fileclose>
80103521:	83 c4 10             	add    $0x10,%esp
}
80103524:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80103527:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010352c:	5b                   	pop    %ebx
8010352d:	5e                   	pop    %esi
8010352e:	5f                   	pop    %edi
8010352f:	5d                   	pop    %ebp
80103530:	c3                   	ret    
80103531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103538:	8b 03                	mov    (%ebx),%eax
8010353a:	85 c0                	test   %eax,%eax
8010353c:	75 c8                	jne    80103506 <pipealloc+0xc6>
8010353e:	eb d2                	jmp    80103512 <pipealloc+0xd2>

80103540 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103540:	55                   	push   %ebp
80103541:	89 e5                	mov    %esp,%ebp
80103543:	56                   	push   %esi
80103544:	53                   	push   %ebx
80103545:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103548:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010354b:	83 ec 0c             	sub    $0xc,%esp
8010354e:	53                   	push   %ebx
8010354f:	e8 5c 1c 00 00       	call   801051b0 <acquire>
  if(writable){
80103554:	83 c4 10             	add    $0x10,%esp
80103557:	85 f6                	test   %esi,%esi
80103559:	74 65                	je     801035c0 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010355b:	83 ec 0c             	sub    $0xc,%esp
8010355e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103564:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010356b:	00 00 00 
    wakeup(&p->nread);
8010356e:	50                   	push   %eax
8010356f:	e8 fc 0e 00 00       	call   80104470 <wakeup>
80103574:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103577:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010357d:	85 d2                	test   %edx,%edx
8010357f:	75 0a                	jne    8010358b <pipeclose+0x4b>
80103581:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103587:	85 c0                	test   %eax,%eax
80103589:	74 15                	je     801035a0 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010358b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010358e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103591:	5b                   	pop    %ebx
80103592:	5e                   	pop    %esi
80103593:	5d                   	pop    %ebp
    release(&p->lock);
80103594:	e9 b7 1b 00 00       	jmp    80105150 <release>
80103599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
801035a0:	83 ec 0c             	sub    $0xc,%esp
801035a3:	53                   	push   %ebx
801035a4:	e8 a7 1b 00 00       	call   80105150 <release>
    kfree((char*)p);
801035a9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801035ac:	83 c4 10             	add    $0x10,%esp
}
801035af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801035b2:	5b                   	pop    %ebx
801035b3:	5e                   	pop    %esi
801035b4:	5d                   	pop    %ebp
    kfree((char*)p);
801035b5:	e9 16 ef ff ff       	jmp    801024d0 <kfree>
801035ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
801035c0:	83 ec 0c             	sub    $0xc,%esp
801035c3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801035c9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801035d0:	00 00 00 
    wakeup(&p->nwrite);
801035d3:	50                   	push   %eax
801035d4:	e8 97 0e 00 00       	call   80104470 <wakeup>
801035d9:	83 c4 10             	add    $0x10,%esp
801035dc:	eb 99                	jmp    80103577 <pipeclose+0x37>
801035de:	66 90                	xchg   %ax,%ax

801035e0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801035e0:	55                   	push   %ebp
801035e1:	89 e5                	mov    %esp,%ebp
801035e3:	57                   	push   %edi
801035e4:	56                   	push   %esi
801035e5:	53                   	push   %ebx
801035e6:	83 ec 28             	sub    $0x28,%esp
801035e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801035ec:	53                   	push   %ebx
801035ed:	e8 be 1b 00 00       	call   801051b0 <acquire>
  for(i = 0; i < n; i++){
801035f2:	8b 45 10             	mov    0x10(%ebp),%eax
801035f5:	83 c4 10             	add    $0x10,%esp
801035f8:	85 c0                	test   %eax,%eax
801035fa:	0f 8e c0 00 00 00    	jle    801036c0 <pipewrite+0xe0>
80103600:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103603:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103609:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010360f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103612:	03 45 10             	add    0x10(%ebp),%eax
80103615:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103618:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010361e:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103624:	89 ca                	mov    %ecx,%edx
80103626:	05 00 02 00 00       	add    $0x200,%eax
8010362b:	39 c1                	cmp    %eax,%ecx
8010362d:	74 3f                	je     8010366e <pipewrite+0x8e>
8010362f:	eb 67                	jmp    80103698 <pipewrite+0xb8>
80103631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80103638:	e8 83 03 00 00       	call   801039c0 <myproc>
8010363d:	8b 48 24             	mov    0x24(%eax),%ecx
80103640:	85 c9                	test   %ecx,%ecx
80103642:	75 34                	jne    80103678 <pipewrite+0x98>
      wakeup(&p->nread);
80103644:	83 ec 0c             	sub    $0xc,%esp
80103647:	57                   	push   %edi
80103648:	e8 23 0e 00 00       	call   80104470 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010364d:	58                   	pop    %eax
8010364e:	5a                   	pop    %edx
8010364f:	53                   	push   %ebx
80103650:	56                   	push   %esi
80103651:	e8 5a 0d 00 00       	call   801043b0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103656:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010365c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103662:	83 c4 10             	add    $0x10,%esp
80103665:	05 00 02 00 00       	add    $0x200,%eax
8010366a:	39 c2                	cmp    %eax,%edx
8010366c:	75 2a                	jne    80103698 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
8010366e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103674:	85 c0                	test   %eax,%eax
80103676:	75 c0                	jne    80103638 <pipewrite+0x58>
        release(&p->lock);
80103678:	83 ec 0c             	sub    $0xc,%esp
8010367b:	53                   	push   %ebx
8010367c:	e8 cf 1a 00 00       	call   80105150 <release>
        return -1;
80103681:	83 c4 10             	add    $0x10,%esp
80103684:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103689:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010368c:	5b                   	pop    %ebx
8010368d:	5e                   	pop    %esi
8010368e:	5f                   	pop    %edi
8010368f:	5d                   	pop    %ebp
80103690:	c3                   	ret    
80103691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103698:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010369b:	8d 4a 01             	lea    0x1(%edx),%ecx
8010369e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801036a4:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
801036aa:	0f b6 06             	movzbl (%esi),%eax
  for(i = 0; i < n; i++){
801036ad:	83 c6 01             	add    $0x1,%esi
801036b0:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801036b3:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801036b7:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801036ba:	0f 85 58 ff ff ff    	jne    80103618 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801036c0:	83 ec 0c             	sub    $0xc,%esp
801036c3:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801036c9:	50                   	push   %eax
801036ca:	e8 a1 0d 00 00       	call   80104470 <wakeup>
  release(&p->lock);
801036cf:	89 1c 24             	mov    %ebx,(%esp)
801036d2:	e8 79 1a 00 00       	call   80105150 <release>
  return n;
801036d7:	8b 45 10             	mov    0x10(%ebp),%eax
801036da:	83 c4 10             	add    $0x10,%esp
801036dd:	eb aa                	jmp    80103689 <pipewrite+0xa9>
801036df:	90                   	nop

801036e0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801036e0:	55                   	push   %ebp
801036e1:	89 e5                	mov    %esp,%ebp
801036e3:	57                   	push   %edi
801036e4:	56                   	push   %esi
801036e5:	53                   	push   %ebx
801036e6:	83 ec 18             	sub    $0x18,%esp
801036e9:	8b 75 08             	mov    0x8(%ebp),%esi
801036ec:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801036ef:	56                   	push   %esi
801036f0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801036f6:	e8 b5 1a 00 00       	call   801051b0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036fb:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103701:	83 c4 10             	add    $0x10,%esp
80103704:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
8010370a:	74 2f                	je     8010373b <piperead+0x5b>
8010370c:	eb 37                	jmp    80103745 <piperead+0x65>
8010370e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80103710:	e8 ab 02 00 00       	call   801039c0 <myproc>
80103715:	8b 48 24             	mov    0x24(%eax),%ecx
80103718:	85 c9                	test   %ecx,%ecx
8010371a:	0f 85 80 00 00 00    	jne    801037a0 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103720:	83 ec 08             	sub    $0x8,%esp
80103723:	56                   	push   %esi
80103724:	53                   	push   %ebx
80103725:	e8 86 0c 00 00       	call   801043b0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010372a:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103730:	83 c4 10             	add    $0x10,%esp
80103733:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103739:	75 0a                	jne    80103745 <piperead+0x65>
8010373b:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103741:	85 c0                	test   %eax,%eax
80103743:	75 cb                	jne    80103710 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103745:	8b 55 10             	mov    0x10(%ebp),%edx
80103748:	31 db                	xor    %ebx,%ebx
8010374a:	85 d2                	test   %edx,%edx
8010374c:	7f 20                	jg     8010376e <piperead+0x8e>
8010374e:	eb 2c                	jmp    8010377c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103750:	8d 48 01             	lea    0x1(%eax),%ecx
80103753:	25 ff 01 00 00       	and    $0x1ff,%eax
80103758:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010375e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103763:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103766:	83 c3 01             	add    $0x1,%ebx
80103769:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010376c:	74 0e                	je     8010377c <piperead+0x9c>
    if(p->nread == p->nwrite)
8010376e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103774:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010377a:	75 d4                	jne    80103750 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010377c:	83 ec 0c             	sub    $0xc,%esp
8010377f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103785:	50                   	push   %eax
80103786:	e8 e5 0c 00 00       	call   80104470 <wakeup>
  release(&p->lock);
8010378b:	89 34 24             	mov    %esi,(%esp)
8010378e:	e8 bd 19 00 00       	call   80105150 <release>
  return i;
80103793:	83 c4 10             	add    $0x10,%esp
}
80103796:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103799:	89 d8                	mov    %ebx,%eax
8010379b:	5b                   	pop    %ebx
8010379c:	5e                   	pop    %esi
8010379d:	5f                   	pop    %edi
8010379e:	5d                   	pop    %ebp
8010379f:	c3                   	ret    
      release(&p->lock);
801037a0:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801037a3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801037a8:	56                   	push   %esi
801037a9:	e8 a2 19 00 00       	call   80105150 <release>
      return -1;
801037ae:	83 c4 10             	add    $0x10,%esp
}
801037b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801037b4:	89 d8                	mov    %ebx,%eax
801037b6:	5b                   	pop    %ebx
801037b7:	5e                   	pop    %esi
801037b8:	5f                   	pop    %edi
801037b9:	5d                   	pop    %ebp
801037ba:	c3                   	ret    
801037bb:	66 90                	xchg   %ax,%ax
801037bd:	66 90                	xchg   %ax,%ax
801037bf:	90                   	nop

801037c0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801037c0:	55                   	push   %ebp
801037c1:	89 e5                	mov    %esp,%ebp
801037c3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037c4:	bb d4 2e 11 80       	mov    $0x80112ed4,%ebx
{
801037c9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801037cc:	68 a0 2e 11 80       	push   $0x80112ea0
801037d1:	e8 da 19 00 00       	call   801051b0 <acquire>
801037d6:	83 c4 10             	add    $0x10,%esp
801037d9:	eb 17                	jmp    801037f2 <allocproc+0x32>
801037db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801037df:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037e0:	81 c3 a0 00 00 00    	add    $0xa0,%ebx
801037e6:	81 fb d4 56 11 80    	cmp    $0x801156d4,%ebx
801037ec:	0f 84 ae 00 00 00    	je     801038a0 <allocproc+0xe0>
    if(p->state == UNUSED)
801037f2:	8b 43 0c             	mov    0xc(%ebx),%eax
801037f5:	85 c0                	test   %eax,%eax
801037f7:	75 e7                	jne    801037e0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037f9:	a1 04 b0 10 80       	mov    0x8010b004,%eax
  p->creation_time = ticks;
  p->waiting_time = 0;
  p->executed_cycle_number = 1;
  p->hrrn_priority = 0;

  release(&ptable.lock);
801037fe:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103801:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->q = 2;
80103808:	c7 83 88 00 00 00 02 	movl   $0x2,0x88(%ebx)
8010380f:	00 00 00 
  p->pid = nextpid++;
80103812:	8d 50 01             	lea    0x1(%eax),%edx
80103815:	89 43 10             	mov    %eax,0x10(%ebx)
  p->creation_time = ticks;
80103818:	a1 e0 56 11 80       	mov    0x801156e0,%eax
  p->waiting_time = 0;
8010381d:	c7 83 94 00 00 00 00 	movl   $0x0,0x94(%ebx)
80103824:	00 00 00 
  p->creation_time = ticks;
80103827:	89 83 90 00 00 00    	mov    %eax,0x90(%ebx)
  p->executed_cycle_number = 1;
8010382d:	c7 83 98 00 00 00 01 	movl   $0x1,0x98(%ebx)
80103834:	00 00 00 
  p->hrrn_priority = 0;
80103837:	c7 83 9c 00 00 00 00 	movl   $0x0,0x9c(%ebx)
8010383e:	00 00 00 
  release(&ptable.lock);
80103841:	68 a0 2e 11 80       	push   $0x80112ea0
  p->pid = nextpid++;
80103846:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
8010384c:	e8 ff 18 00 00       	call   80105150 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103851:	e8 3a ee ff ff       	call   80102690 <kalloc>
80103856:	83 c4 10             	add    $0x10,%esp
80103859:	89 43 08             	mov    %eax,0x8(%ebx)
8010385c:	85 c0                	test   %eax,%eax
8010385e:	74 59                	je     801038b9 <allocproc+0xf9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103860:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103866:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103869:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
8010386e:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103871:	c7 40 14 84 66 10 80 	movl   $0x80106684,0x14(%eax)
  p->context = (struct context*)sp;
80103878:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010387b:	6a 14                	push   $0x14
8010387d:	6a 00                	push   $0x0
8010387f:	50                   	push   %eax
80103880:	e8 eb 19 00 00       	call   80105270 <memset>
  p->context->eip = (uint)forkret;
80103885:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103888:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
8010388b:	c7 40 10 d0 38 10 80 	movl   $0x801038d0,0x10(%eax)
}
80103892:	89 d8                	mov    %ebx,%eax
80103894:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103897:	c9                   	leave  
80103898:	c3                   	ret    
80103899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801038a0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801038a3:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801038a5:	68 a0 2e 11 80       	push   $0x80112ea0
801038aa:	e8 a1 18 00 00       	call   80105150 <release>
}
801038af:	89 d8                	mov    %ebx,%eax
  return 0;
801038b1:	83 c4 10             	add    $0x10,%esp
}
801038b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038b7:	c9                   	leave  
801038b8:	c3                   	ret    
    p->state = UNUSED;
801038b9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801038c0:	31 db                	xor    %ebx,%ebx
}
801038c2:	89 d8                	mov    %ebx,%eax
801038c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038c7:	c9                   	leave  
801038c8:	c3                   	ret    
801038c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801038d0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801038d0:	55                   	push   %ebp
801038d1:	89 e5                	mov    %esp,%ebp
801038d3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801038d6:	68 a0 2e 11 80       	push   $0x80112ea0
801038db:	e8 70 18 00 00       	call   80105150 <release>

  if (first) {
801038e0:	a1 00 b0 10 80       	mov    0x8010b000,%eax
801038e5:	83 c4 10             	add    $0x10,%esp
801038e8:	85 c0                	test   %eax,%eax
801038ea:	75 04                	jne    801038f0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801038ec:	c9                   	leave  
801038ed:	c3                   	ret    
801038ee:	66 90                	xchg   %ax,%ax
    first = 0;
801038f0:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
801038f7:	00 00 00 
    iinit(ROOTDEV);
801038fa:	83 ec 0c             	sub    $0xc,%esp
801038fd:	6a 01                	push   $0x1
801038ff:	e8 6c dc ff ff       	call   80101570 <iinit>
    initlog(ROOTDEV);
80103904:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010390b:	e8 c0 f3 ff ff       	call   80102cd0 <initlog>
}
80103910:	83 c4 10             	add    $0x10,%esp
80103913:	c9                   	leave  
80103914:	c3                   	ret    
80103915:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010391c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103920 <pinit>:
{
80103920:	55                   	push   %ebp
80103921:	89 e5                	mov    %esp,%ebp
80103923:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103926:	68 00 85 10 80       	push   $0x80108500
8010392b:	68 a0 2e 11 80       	push   $0x80112ea0
80103930:	e8 ab 16 00 00       	call   80104fe0 <initlock>
}
80103935:	83 c4 10             	add    $0x10,%esp
80103938:	c9                   	leave  
80103939:	c3                   	ret    
8010393a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103940 <mycpu>:
{
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	56                   	push   %esi
80103944:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103945:	9c                   	pushf  
80103946:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103947:	f6 c4 02             	test   $0x2,%ah
8010394a:	75 46                	jne    80103992 <mycpu+0x52>
  apicid = lapicid();
8010394c:	e8 af ef ff ff       	call   80102900 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103951:	8b 35 84 27 11 80    	mov    0x80112784,%esi
80103957:	85 f6                	test   %esi,%esi
80103959:	7e 2a                	jle    80103985 <mycpu+0x45>
8010395b:	31 d2                	xor    %edx,%edx
8010395d:	eb 08                	jmp    80103967 <mycpu+0x27>
8010395f:	90                   	nop
80103960:	83 c2 01             	add    $0x1,%edx
80103963:	39 f2                	cmp    %esi,%edx
80103965:	74 1e                	je     80103985 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80103967:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
8010396d:	0f b6 99 a0 27 11 80 	movzbl -0x7feed860(%ecx),%ebx
80103974:	39 c3                	cmp    %eax,%ebx
80103976:	75 e8                	jne    80103960 <mycpu+0x20>
}
80103978:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
8010397b:	8d 81 a0 27 11 80    	lea    -0x7feed860(%ecx),%eax
}
80103981:	5b                   	pop    %ebx
80103982:	5e                   	pop    %esi
80103983:	5d                   	pop    %ebp
80103984:	c3                   	ret    
  panic("unknown apicid\n");
80103985:	83 ec 0c             	sub    $0xc,%esp
80103988:	68 07 85 10 80       	push   $0x80108507
8010398d:	e8 ee c9 ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
80103992:	83 ec 0c             	sub    $0xc,%esp
80103995:	68 1c 86 10 80       	push   $0x8010861c
8010399a:	e8 e1 c9 ff ff       	call   80100380 <panic>
8010399f:	90                   	nop

801039a0 <cpuid>:
cpuid() {
801039a0:	55                   	push   %ebp
801039a1:	89 e5                	mov    %esp,%ebp
801039a3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801039a6:	e8 95 ff ff ff       	call   80103940 <mycpu>
}
801039ab:	c9                   	leave  
  return mycpu()-cpus;
801039ac:	2d a0 27 11 80       	sub    $0x801127a0,%eax
801039b1:	c1 f8 04             	sar    $0x4,%eax
801039b4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801039ba:	c3                   	ret    
801039bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801039bf:	90                   	nop

801039c0 <myproc>:
myproc(void) {
801039c0:	55                   	push   %ebp
801039c1:	89 e5                	mov    %esp,%ebp
801039c3:	53                   	push   %ebx
801039c4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801039c7:	e8 94 16 00 00       	call   80105060 <pushcli>
  c = mycpu();
801039cc:	e8 6f ff ff ff       	call   80103940 <mycpu>
  p = c->proc;
801039d1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039d7:	e8 d4 16 00 00       	call   801050b0 <popcli>
}
801039dc:	89 d8                	mov    %ebx,%eax
801039de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039e1:	c9                   	leave  
801039e2:	c3                   	ret    
801039e3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801039f0 <userinit>:
{
801039f0:	55                   	push   %ebp
801039f1:	89 e5                	mov    %esp,%ebp
801039f3:	53                   	push   %ebx
801039f4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
801039f7:	e8 c4 fd ff ff       	call   801037c0 <allocproc>
801039fc:	89 c3                	mov    %eax,%ebx
  initproc = p;
801039fe:	a3 d4 56 11 80       	mov    %eax,0x801156d4
  if((p->pgdir = setupkvm()) == 0)
80103a03:	e8 68 42 00 00       	call   80107c70 <setupkvm>
80103a08:	89 43 04             	mov    %eax,0x4(%ebx)
80103a0b:	85 c0                	test   %eax,%eax
80103a0d:	0f 84 bd 00 00 00    	je     80103ad0 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103a13:	83 ec 04             	sub    $0x4,%esp
80103a16:	68 2c 00 00 00       	push   $0x2c
80103a1b:	68 60 b4 10 80       	push   $0x8010b460
80103a20:	50                   	push   %eax
80103a21:	e8 fa 3e 00 00       	call   80107920 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103a26:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103a29:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103a2f:	6a 4c                	push   $0x4c
80103a31:	6a 00                	push   $0x0
80103a33:	ff 73 18             	push   0x18(%ebx)
80103a36:	e8 35 18 00 00       	call   80105270 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a3b:	8b 43 18             	mov    0x18(%ebx),%eax
80103a3e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a43:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a46:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a4b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a4f:	8b 43 18             	mov    0x18(%ebx),%eax
80103a52:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103a56:	8b 43 18             	mov    0x18(%ebx),%eax
80103a59:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a5d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103a61:	8b 43 18             	mov    0x18(%ebx),%eax
80103a64:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a68:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103a6c:	8b 43 18             	mov    0x18(%ebx),%eax
80103a6f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103a76:	8b 43 18             	mov    0x18(%ebx),%eax
80103a79:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103a80:	8b 43 18             	mov    0x18(%ebx),%eax
80103a83:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a8a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a8d:	6a 10                	push   $0x10
80103a8f:	68 30 85 10 80       	push   $0x80108530
80103a94:	50                   	push   %eax
80103a95:	e8 96 19 00 00       	call   80105430 <safestrcpy>
  p->cwd = namei("/");
80103a9a:	c7 04 24 39 85 10 80 	movl   $0x80108539,(%esp)
80103aa1:	e8 0a e6 ff ff       	call   801020b0 <namei>
80103aa6:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103aa9:	c7 04 24 a0 2e 11 80 	movl   $0x80112ea0,(%esp)
80103ab0:	e8 fb 16 00 00       	call   801051b0 <acquire>
  p->state = RUNNABLE;
80103ab5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103abc:	c7 04 24 a0 2e 11 80 	movl   $0x80112ea0,(%esp)
80103ac3:	e8 88 16 00 00       	call   80105150 <release>
}
80103ac8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103acb:	83 c4 10             	add    $0x10,%esp
80103ace:	c9                   	leave  
80103acf:	c3                   	ret    
    panic("userinit: out of memory?");
80103ad0:	83 ec 0c             	sub    $0xc,%esp
80103ad3:	68 17 85 10 80       	push   $0x80108517
80103ad8:	e8 a3 c8 ff ff       	call   80100380 <panic>
80103add:	8d 76 00             	lea    0x0(%esi),%esi

80103ae0 <growproc>:
{
80103ae0:	55                   	push   %ebp
80103ae1:	89 e5                	mov    %esp,%ebp
80103ae3:	56                   	push   %esi
80103ae4:	53                   	push   %ebx
80103ae5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103ae8:	e8 73 15 00 00       	call   80105060 <pushcli>
  c = mycpu();
80103aed:	e8 4e fe ff ff       	call   80103940 <mycpu>
  p = c->proc;
80103af2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103af8:	e8 b3 15 00 00       	call   801050b0 <popcli>
  sz = curproc->sz;
80103afd:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103aff:	85 f6                	test   %esi,%esi
80103b01:	7f 1d                	jg     80103b20 <growproc+0x40>
  } else if(n < 0){
80103b03:	75 3b                	jne    80103b40 <growproc+0x60>
  switchuvm(curproc);
80103b05:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103b08:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103b0a:	53                   	push   %ebx
80103b0b:	e8 00 3d 00 00       	call   80107810 <switchuvm>
  return 0;
80103b10:	83 c4 10             	add    $0x10,%esp
80103b13:	31 c0                	xor    %eax,%eax
}
80103b15:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b18:	5b                   	pop    %ebx
80103b19:	5e                   	pop    %esi
80103b1a:	5d                   	pop    %ebp
80103b1b:	c3                   	ret    
80103b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b20:	83 ec 04             	sub    $0x4,%esp
80103b23:	01 c6                	add    %eax,%esi
80103b25:	56                   	push   %esi
80103b26:	50                   	push   %eax
80103b27:	ff 73 04             	push   0x4(%ebx)
80103b2a:	e8 61 3f 00 00       	call   80107a90 <allocuvm>
80103b2f:	83 c4 10             	add    $0x10,%esp
80103b32:	85 c0                	test   %eax,%eax
80103b34:	75 cf                	jne    80103b05 <growproc+0x25>
      return -1;
80103b36:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b3b:	eb d8                	jmp    80103b15 <growproc+0x35>
80103b3d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b40:	83 ec 04             	sub    $0x4,%esp
80103b43:	01 c6                	add    %eax,%esi
80103b45:	56                   	push   %esi
80103b46:	50                   	push   %eax
80103b47:	ff 73 04             	push   0x4(%ebx)
80103b4a:	e8 71 40 00 00       	call   80107bc0 <deallocuvm>
80103b4f:	83 c4 10             	add    $0x10,%esp
80103b52:	85 c0                	test   %eax,%eax
80103b54:	75 af                	jne    80103b05 <growproc+0x25>
80103b56:	eb de                	jmp    80103b36 <growproc+0x56>
80103b58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b5f:	90                   	nop

80103b60 <fork>:
{
80103b60:	55                   	push   %ebp
80103b61:	89 e5                	mov    %esp,%ebp
80103b63:	57                   	push   %edi
80103b64:	56                   	push   %esi
80103b65:	53                   	push   %ebx
80103b66:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103b69:	e8 f2 14 00 00       	call   80105060 <pushcli>
  c = mycpu();
80103b6e:	e8 cd fd ff ff       	call   80103940 <mycpu>
  p = c->proc;
80103b73:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b79:	e8 32 15 00 00       	call   801050b0 <popcli>
  if((np = allocproc()) == 0){
80103b7e:	e8 3d fc ff ff       	call   801037c0 <allocproc>
80103b83:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103b86:	85 c0                	test   %eax,%eax
80103b88:	0f 84 b7 00 00 00    	je     80103c45 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103b8e:	83 ec 08             	sub    $0x8,%esp
80103b91:	ff 33                	push   (%ebx)
80103b93:	89 c7                	mov    %eax,%edi
80103b95:	ff 73 04             	push   0x4(%ebx)
80103b98:	e8 c3 41 00 00       	call   80107d60 <copyuvm>
80103b9d:	83 c4 10             	add    $0x10,%esp
80103ba0:	89 47 04             	mov    %eax,0x4(%edi)
80103ba3:	85 c0                	test   %eax,%eax
80103ba5:	0f 84 a1 00 00 00    	je     80103c4c <fork+0xec>
  np->sz = curproc->sz;
80103bab:	8b 03                	mov    (%ebx),%eax
80103bad:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103bb0:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103bb2:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103bb5:	89 c8                	mov    %ecx,%eax
80103bb7:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103bba:	b9 13 00 00 00       	mov    $0x13,%ecx
80103bbf:	8b 73 18             	mov    0x18(%ebx),%esi
80103bc2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103bc4:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103bc6:	8b 40 18             	mov    0x18(%eax),%eax
80103bc9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103bd0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103bd4:	85 c0                	test   %eax,%eax
80103bd6:	74 13                	je     80103beb <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103bd8:	83 ec 0c             	sub    $0xc,%esp
80103bdb:	50                   	push   %eax
80103bdc:	e8 cf d2 ff ff       	call   80100eb0 <filedup>
80103be1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103be4:	83 c4 10             	add    $0x10,%esp
80103be7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103beb:	83 c6 01             	add    $0x1,%esi
80103bee:	83 fe 10             	cmp    $0x10,%esi
80103bf1:	75 dd                	jne    80103bd0 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103bf3:	83 ec 0c             	sub    $0xc,%esp
80103bf6:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103bf9:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103bfc:	e8 5f db ff ff       	call   80101760 <idup>
80103c01:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c04:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103c07:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c0a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103c0d:	6a 10                	push   $0x10
80103c0f:	53                   	push   %ebx
80103c10:	50                   	push   %eax
80103c11:	e8 1a 18 00 00       	call   80105430 <safestrcpy>
  pid = np->pid;
80103c16:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103c19:	c7 04 24 a0 2e 11 80 	movl   $0x80112ea0,(%esp)
80103c20:	e8 8b 15 00 00       	call   801051b0 <acquire>
  np->state = RUNNABLE;
80103c25:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103c2c:	c7 04 24 a0 2e 11 80 	movl   $0x80112ea0,(%esp)
80103c33:	e8 18 15 00 00       	call   80105150 <release>
  return pid;
80103c38:	83 c4 10             	add    $0x10,%esp
}
80103c3b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c3e:	89 d8                	mov    %ebx,%eax
80103c40:	5b                   	pop    %ebx
80103c41:	5e                   	pop    %esi
80103c42:	5f                   	pop    %edi
80103c43:	5d                   	pop    %ebp
80103c44:	c3                   	ret    
    return -1;
80103c45:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103c4a:	eb ef                	jmp    80103c3b <fork+0xdb>
    kfree(np->kstack);
80103c4c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103c4f:	83 ec 0c             	sub    $0xc,%esp
80103c52:	ff 73 08             	push   0x8(%ebx)
80103c55:	e8 76 e8 ff ff       	call   801024d0 <kfree>
    np->kstack = 0;
80103c5a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103c61:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103c64:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103c6b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103c70:	eb c9                	jmp    80103c3b <fork+0xdb>
80103c72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103c80 <get_mhrrn>:
{
80103c80:	55                   	push   %ebp
80103c81:	89 e5                	mov    %esp,%ebp
80103c83:	83 ec 08             	sub    $0x8,%esp
    int waiting_time = ticks - process->creation_time;
80103c86:	a1 e0 56 11 80       	mov    0x801156e0,%eax
{
80103c8b:	8b 55 08             	mov    0x8(%ebp),%edx
    int waiting_time = ticks - process->creation_time;
80103c8e:	2b 82 90 00 00 00    	sub    0x90(%edx),%eax
    float hrrn = (waiting_time - process->executed_cycle_number) * 1.0 / process->executed_cycle_number;
80103c94:	2b 82 98 00 00 00    	sub    0x98(%edx),%eax
80103c9a:	89 45 f8             	mov    %eax,-0x8(%ebp)
80103c9d:	db 45 f8             	fildl  -0x8(%ebp)
80103ca0:	db 82 98 00 00 00    	fildl  0x98(%edx)
80103ca6:	de f9                	fdivrp %st,%st(1)
80103ca8:	d9 5d f8             	fstps  -0x8(%ebp)
80103cab:	d9 45 f8             	flds   -0x8(%ebp)
    float mhrrn = (hrrn + process->hrrn_priority) / 2;
80103cae:	db 82 9c 00 00 00    	fildl  0x9c(%edx)
    return mhrrn;
80103cb4:	d9 7d fe             	fnstcw -0x2(%ebp)
80103cb7:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
    float mhrrn = (hrrn + process->hrrn_priority) / 2;
80103cbb:	de c1                	faddp  %st,%st(1)
80103cbd:	d8 0d c8 87 10 80    	fmuls  0x801087c8
    return mhrrn;
80103cc3:	80 cc 0c             	or     $0xc,%ah
80103cc6:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80103cca:	d9 6d fc             	fldcw  -0x4(%ebp)
80103ccd:	db 5d f8             	fistpl -0x8(%ebp)
80103cd0:	d9 6d fe             	fldcw  -0x2(%ebp)
80103cd3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103cd6:	c9                   	leave  
80103cd7:	c3                   	ret    
80103cd8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cdf:	90                   	nop

80103ce0 <rr_next>:
struct proc* rr_next(void){
80103ce0:	55                   	push   %ebp
  int process_max = -99999999;
80103ce1:	b9 01 1f 0a fa       	mov    $0xfa0a1f01,%ecx
  for (process = ptable.proc ; process < &ptable.proc[NPROC] ; process++){
80103ce6:	b8 d4 2e 11 80       	mov    $0x80112ed4,%eax
struct proc* rr_next(void){
80103ceb:	89 e5                	mov    %esp,%ebp
80103ced:	56                   	push   %esi
  struct proc* next = 0;
80103cee:	31 f6                	xor    %esi,%esi
struct proc* rr_next(void){
80103cf0:	53                   	push   %ebx
  int now = ticks;
80103cf1:	8b 1d e0 56 11 80    	mov    0x801156e0,%ebx
  for (process = ptable.proc ; process < &ptable.proc[NPROC] ; process++){
80103cf7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cfe:	66 90                	xchg   %ax,%ax
    if ((process->state != RUNNABLE) || (process->q != 1)) continue;
80103d00:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103d04:	75 1a                	jne    80103d20 <rr_next+0x40>
80103d06:	83 b8 88 00 00 00 01 	cmpl   $0x1,0x88(%eax)
80103d0d:	75 11                	jne    80103d20 <rr_next+0x40>
    if (process_max < (now - process->last_processor_time)){
80103d0f:	89 da                	mov    %ebx,%edx
80103d11:	2b 90 8c 00 00 00    	sub    0x8c(%eax),%edx
80103d17:	39 ca                	cmp    %ecx,%edx
80103d19:	7e 05                	jle    80103d20 <rr_next+0x40>
80103d1b:	89 d1                	mov    %edx,%ecx
80103d1d:	89 c6                	mov    %eax,%esi
80103d1f:	90                   	nop
  for (process = ptable.proc ; process < &ptable.proc[NPROC] ; process++){
80103d20:	05 a0 00 00 00       	add    $0xa0,%eax
80103d25:	3d d4 56 11 80       	cmp    $0x801156d4,%eax
80103d2a:	75 d4                	jne    80103d00 <rr_next+0x20>
}
80103d2c:	89 f0                	mov    %esi,%eax
80103d2e:	5b                   	pop    %ebx
80103d2f:	5e                   	pop    %esi
80103d30:	5d                   	pop    %ebp
80103d31:	c3                   	ret    
80103d32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103d40 <lcfc>:
struct proc* lcfc(void){
80103d40:	55                   	push   %ebp
  int last_creation_time = -1;
80103d41:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  for (process = ptable.proc ; process < &ptable.proc[NPROC] ; process++){
80103d46:	b8 d4 2e 11 80       	mov    $0x80112ed4,%eax
struct proc* lcfc(void){
80103d4b:	89 e5                	mov    %esp,%ebp
80103d4d:	53                   	push   %ebx
  struct proc* next = 0;
80103d4e:	31 db                	xor    %ebx,%ebx
    if ((process->state != RUNNABLE) || (process->q != 2)) continue;
80103d50:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103d54:	75 1a                	jne    80103d70 <lcfc+0x30>
80103d56:	83 b8 88 00 00 00 02 	cmpl   $0x2,0x88(%eax)
80103d5d:	75 11                	jne    80103d70 <lcfc+0x30>
    if (last_creation_time < process->creation_time){
80103d5f:	8b 90 90 00 00 00    	mov    0x90(%eax),%edx
80103d65:	39 ca                	cmp    %ecx,%edx
80103d67:	7e 07                	jle    80103d70 <lcfc+0x30>
80103d69:	89 d1                	mov    %edx,%ecx
80103d6b:	89 c3                	mov    %eax,%ebx
80103d6d:	8d 76 00             	lea    0x0(%esi),%esi
  for (process = ptable.proc ; process < &ptable.proc[NPROC] ; process++){
80103d70:	05 a0 00 00 00       	add    $0xa0,%eax
80103d75:	3d d4 56 11 80       	cmp    $0x801156d4,%eax
80103d7a:	75 d4                	jne    80103d50 <lcfc+0x10>
}
80103d7c:	89 d8                	mov    %ebx,%eax
80103d7e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d81:	c9                   	leave  
80103d82:	c3                   	ret    
80103d83:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103d90 <mhrrn>:
struct proc* mhrrn(void){
80103d90:	55                   	push   %ebp
  for (process = ptable.proc ; process < &ptable.proc[NPROC] ; process++){
80103d91:	b8 d4 2e 11 80       	mov    $0x80112ed4,%eax
struct proc* mhrrn(void){
80103d96:	89 e5                	mov    %esp,%ebp
80103d98:	53                   	push   %ebx
  struct proc* next = 0;
80103d99:	31 db                	xor    %ebx,%ebx
struct proc* mhrrn(void){
80103d9b:	83 ec 14             	sub    $0x14,%esp
  int max_mhrrn = -1;
80103d9e:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%ebp)
    int waiting_time = ticks - process->creation_time;
80103da5:	8b 0d e0 56 11 80    	mov    0x801156e0,%ecx
80103dab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103daf:	90                   	nop
    if ((process->state != RUNNABLE) || (process->q != 3)) continue;
80103db0:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103db4:	75 7a                	jne    80103e30 <mhrrn+0xa0>
80103db6:	83 b8 88 00 00 00 03 	cmpl   $0x3,0x88(%eax)
80103dbd:	75 71                	jne    80103e30 <mhrrn+0xa0>
    int waiting_time = ticks - process->creation_time;
80103dbf:	89 ca                	mov    %ecx,%edx
80103dc1:	2b 90 90 00 00 00    	sub    0x90(%eax),%edx
    float hrrn = (waiting_time - process->executed_cycle_number) * 1.0 / process->executed_cycle_number;
80103dc7:	2b 90 98 00 00 00    	sub    0x98(%eax),%edx
80103dcd:	89 55 f0             	mov    %edx,-0x10(%ebp)
80103dd0:	db 45 f0             	fildl  -0x10(%ebp)
80103dd3:	db 80 98 00 00 00    	fildl  0x98(%eax)
80103dd9:	de f9                	fdivrp %st,%st(1)
80103ddb:	d9 5d f0             	fstps  -0x10(%ebp)
80103dde:	d9 45 f0             	flds   -0x10(%ebp)
    float mhrrn = (hrrn + process->hrrn_priority) / 2;
80103de1:	db 80 9c 00 00 00    	fildl  0x9c(%eax)
    return mhrrn;
80103de7:	d9 7d f6             	fnstcw -0xa(%ebp)
80103dea:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
    float mhrrn = (hrrn + process->hrrn_priority) / 2;
80103dee:	de c1                	faddp  %st,%st(1)
80103df0:	d8 0d c8 87 10 80    	fmuls  0x801087c8
    return mhrrn;
80103df6:	80 ce 0c             	or     $0xc,%dh
80103df9:	66 89 55 f4          	mov    %dx,-0xc(%ebp)
80103dfd:	d9 6d f4             	fldcw  -0xc(%ebp)
80103e00:	db 5d f0             	fistpl -0x10(%ebp)
80103e03:	d9 6d f6             	fldcw  -0xa(%ebp)
    float mhrrn = get_mhrrn(process);
80103e06:	db 45 f0             	fildl  -0x10(%ebp)
    if (max_mhrrn < mhrrn){
80103e09:	db 45 ec             	fildl  -0x14(%ebp)
80103e0c:	d9 c9                	fxch   %st(1)
80103e0e:	db f1                	fcomi  %st(1),%st
80103e10:	dd d9                	fstp   %st(1)
80103e12:	76 14                	jbe    80103e28 <mhrrn+0x98>
      max_mhrrn = mhrrn;
80103e14:	d9 6d f4             	fldcw  -0xc(%ebp)
80103e17:	db 5d ec             	fistpl -0x14(%ebp)
80103e1a:	d9 6d f6             	fldcw  -0xa(%ebp)
80103e1d:	89 c3                	mov    %eax,%ebx
80103e1f:	eb 0f                	jmp    80103e30 <mhrrn+0xa0>
80103e21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e28:	dd d8                	fstp   %st(0)
80103e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for (process = ptable.proc ; process < &ptable.proc[NPROC] ; process++){
80103e30:	05 a0 00 00 00       	add    $0xa0,%eax
80103e35:	3d d4 56 11 80       	cmp    $0x801156d4,%eax
80103e3a:	0f 85 70 ff ff ff    	jne    80103db0 <mhrrn+0x20>
}
80103e40:	89 d8                	mov    %ebx,%eax
80103e42:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e45:	c9                   	leave  
80103e46:	c3                   	ret    
80103e47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e4e:	66 90                	xchg   %ax,%ax

80103e50 <update_waiting_time>:
  for (process = ptable.proc ; process < &ptable.proc[NPROC] ; process++){
80103e50:	b8 d4 2e 11 80       	mov    $0x80112ed4,%eax
80103e55:	eb 1a                	jmp    80103e71 <update_waiting_time+0x21>
80103e57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e5e:	66 90                	xchg   %ax,%ax
    if (process->waiting_time > 8000 && process->state == RUNNABLE) {
80103e60:	83 f9 03             	cmp    $0x3,%ecx
80103e63:	74 43                	je     80103ea8 <update_waiting_time+0x58>
  for (process = ptable.proc ; process < &ptable.proc[NPROC] ; process++){
80103e65:	05 a0 00 00 00       	add    $0xa0,%eax
80103e6a:	3d d4 56 11 80       	cmp    $0x801156d4,%eax
80103e6f:	74 31                	je     80103ea2 <update_waiting_time+0x52>
    if (process->q == 1) continue;
80103e71:	83 b8 88 00 00 00 01 	cmpl   $0x1,0x88(%eax)
80103e78:	74 eb                	je     80103e65 <update_waiting_time+0x15>
    if (process->waiting_time > 8000 && process->state == RUNNABLE) {
80103e7a:	8b 90 94 00 00 00    	mov    0x94(%eax),%edx
80103e80:	8b 48 0c             	mov    0xc(%eax),%ecx
80103e83:	81 fa 40 1f 00 00    	cmp    $0x1f40,%edx
80103e89:	7f d5                	jg     80103e60 <update_waiting_time+0x10>
    if (process->state == RUNNABLE)
80103e8b:	83 f9 03             	cmp    $0x3,%ecx
80103e8e:	75 d5                	jne    80103e65 <update_waiting_time+0x15>
      process->waiting_time += 1;
80103e90:	83 c2 01             	add    $0x1,%edx
  for (process = ptable.proc ; process < &ptable.proc[NPROC] ; process++){
80103e93:	05 a0 00 00 00       	add    $0xa0,%eax
      process->waiting_time += 1;
80103e98:	89 50 f4             	mov    %edx,-0xc(%eax)
  for (process = ptable.proc ; process < &ptable.proc[NPROC] ; process++){
80103e9b:	3d d4 56 11 80       	cmp    $0x801156d4,%eax
80103ea0:	75 cf                	jne    80103e71 <update_waiting_time+0x21>
}
80103ea2:	c3                   	ret    
80103ea3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ea7:	90                   	nop
      process->waiting_time = 0;
80103ea8:	c7 80 94 00 00 00 00 	movl   $0x0,0x94(%eax)
80103eaf:	00 00 00 
      process->q = 1;
80103eb2:	c7 80 88 00 00 00 01 	movl   $0x1,0x88(%eax)
80103eb9:	00 00 00 
      continue;
80103ebc:	eb a7                	jmp    80103e65 <update_waiting_time+0x15>
80103ebe:	66 90                	xchg   %ax,%ax

80103ec0 <scheduler>:
{
80103ec0:	55                   	push   %ebp
80103ec1:	89 e5                	mov    %esp,%ebp
80103ec3:	57                   	push   %edi
80103ec4:	56                   	push   %esi
80103ec5:	53                   	push   %ebx
80103ec6:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80103ec9:	e8 72 fa ff ff       	call   80103940 <mycpu>
  c->proc = 0;
80103ece:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103ed5:	00 00 00 
  struct cpu *c = mycpu();
80103ed8:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
80103eda:	8d 40 04             	lea    0x4(%eax),%eax
80103edd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  asm volatile("sti");
80103ee0:	fb                   	sti    
    acquire(&ptable.lock);
80103ee1:	83 ec 0c             	sub    $0xc,%esp
  struct proc* next = 0;
80103ee4:	31 f6                	xor    %esi,%esi
    acquire(&ptable.lock);
80103ee6:	68 a0 2e 11 80       	push   $0x80112ea0
80103eeb:	e8 c0 12 00 00       	call   801051b0 <acquire>
    update_waiting_time();
80103ef0:	e8 5b ff ff ff       	call   80103e50 <update_waiting_time>
  int now = ticks;
80103ef5:	8b 3d e0 56 11 80    	mov    0x801156e0,%edi
80103efb:	83 c4 10             	add    $0x10,%esp
  int process_max = -99999999;
80103efe:	b9 01 1f 0a fa       	mov    $0xfa0a1f01,%ecx
  for (process = ptable.proc ; process < &ptable.proc[NPROC] ; process++){
80103f03:	b8 d4 2e 11 80       	mov    $0x80112ed4,%eax
80103f08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f0f:	90                   	nop
    if ((process->state != RUNNABLE) || (process->q != 1)) continue;
80103f10:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103f14:	75 1a                	jne    80103f30 <scheduler+0x70>
80103f16:	83 b8 88 00 00 00 01 	cmpl   $0x1,0x88(%eax)
80103f1d:	75 11                	jne    80103f30 <scheduler+0x70>
    if (process_max < (now - process->last_processor_time)){
80103f1f:	89 fa                	mov    %edi,%edx
80103f21:	2b 90 8c 00 00 00    	sub    0x8c(%eax),%edx
80103f27:	39 ca                	cmp    %ecx,%edx
80103f29:	7e 05                	jle    80103f30 <scheduler+0x70>
80103f2b:	89 d1                	mov    %edx,%ecx
80103f2d:	89 c6                	mov    %eax,%esi
80103f2f:	90                   	nop
  for (process = ptable.proc ; process < &ptable.proc[NPROC] ; process++){
80103f30:	05 a0 00 00 00       	add    $0xa0,%eax
80103f35:	3d d4 56 11 80       	cmp    $0x801156d4,%eax
80103f3a:	75 d4                	jne    80103f10 <scheduler+0x50>
    if (p == 0) 
80103f3c:	85 f6                	test   %esi,%esi
80103f3e:	74 50                	je     80103f90 <scheduler+0xd0>
    p->waiting_time = 0;
80103f40:	c7 86 94 00 00 00 00 	movl   $0x0,0x94(%esi)
80103f47:	00 00 00 
    switchuvm(p);
80103f4a:	83 ec 0c             	sub    $0xc,%esp
    c->proc = p;
80103f4d:	89 b3 ac 00 00 00    	mov    %esi,0xac(%ebx)
    switchuvm(p);
80103f53:	56                   	push   %esi
80103f54:	e8 b7 38 00 00       	call   80107810 <switchuvm>
    p->state = RUNNING;
80103f59:	c7 46 0c 04 00 00 00 	movl   $0x4,0xc(%esi)
    swtch(&(c->scheduler), p->context);
80103f60:	58                   	pop    %eax
80103f61:	5a                   	pop    %edx
80103f62:	ff 76 1c             	push   0x1c(%esi)
80103f65:	ff 75 e4             	push   -0x1c(%ebp)
80103f68:	e8 1e 15 00 00       	call   8010548b <swtch>
    switchkvm();
80103f6d:	e8 8e 38 00 00       	call   80107800 <switchkvm>
    c->proc = 0;
80103f72:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80103f79:	00 00 00 
    release(&ptable.lock);
80103f7c:	c7 04 24 a0 2e 11 80 	movl   $0x80112ea0,(%esp)
80103f83:	e8 c8 11 00 00       	call   80105150 <release>
80103f88:	83 c4 10             	add    $0x10,%esp
80103f8b:	e9 50 ff ff ff       	jmp    80103ee0 <scheduler+0x20>
  int last_creation_time = -1;
80103f90:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  for (process = ptable.proc ; process < &ptable.proc[NPROC] ; process++){
80103f95:	b8 d4 2e 11 80       	mov    $0x80112ed4,%eax
80103f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if ((process->state != RUNNABLE) || (process->q != 2)) continue;
80103fa0:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103fa4:	75 1a                	jne    80103fc0 <scheduler+0x100>
80103fa6:	83 b8 88 00 00 00 02 	cmpl   $0x2,0x88(%eax)
80103fad:	75 11                	jne    80103fc0 <scheduler+0x100>
    if (last_creation_time < process->creation_time){
80103faf:	8b 90 90 00 00 00    	mov    0x90(%eax),%edx
80103fb5:	39 ca                	cmp    %ecx,%edx
80103fb7:	7e 07                	jle    80103fc0 <scheduler+0x100>
80103fb9:	89 d1                	mov    %edx,%ecx
80103fbb:	89 c6                	mov    %eax,%esi
80103fbd:	8d 76 00             	lea    0x0(%esi),%esi
  for (process = ptable.proc ; process < &ptable.proc[NPROC] ; process++){
80103fc0:	05 a0 00 00 00       	add    $0xa0,%eax
80103fc5:	3d d4 56 11 80       	cmp    $0x801156d4,%eax
80103fca:	75 d4                	jne    80103fa0 <scheduler+0xe0>
      if (p == 0) 
80103fcc:	85 f6                	test   %esi,%esi
80103fce:	0f 85 6c ff ff ff    	jne    80103f40 <scheduler+0x80>
        p = mhrrn();
80103fd4:	e8 b7 fd ff ff       	call   80103d90 <mhrrn>
80103fd9:	89 c6                	mov    %eax,%esi
    if (p == 0){
80103fdb:	85 c0                	test   %eax,%eax
80103fdd:	0f 85 5d ff ff ff    	jne    80103f40 <scheduler+0x80>
      release(&ptable.lock);
80103fe3:	83 ec 0c             	sub    $0xc,%esp
80103fe6:	68 a0 2e 11 80       	push   $0x80112ea0
80103feb:	e8 60 11 00 00       	call   80105150 <release>
      continue;
80103ff0:	83 c4 10             	add    $0x10,%esp
80103ff3:	e9 e8 fe ff ff       	jmp    80103ee0 <scheduler+0x20>
80103ff8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103fff:	90                   	nop

80104000 <sched>:
{
80104000:	55                   	push   %ebp
80104001:	89 e5                	mov    %esp,%ebp
80104003:	56                   	push   %esi
80104004:	53                   	push   %ebx
  pushcli();
80104005:	e8 56 10 00 00       	call   80105060 <pushcli>
  c = mycpu();
8010400a:	e8 31 f9 ff ff       	call   80103940 <mycpu>
  p = c->proc;
8010400f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104015:	e8 96 10 00 00       	call   801050b0 <popcli>
  if(!holding(&ptable.lock))
8010401a:	83 ec 0c             	sub    $0xc,%esp
8010401d:	68 a0 2e 11 80       	push   $0x80112ea0
80104022:	e8 e9 10 00 00       	call   80105110 <holding>
80104027:	83 c4 10             	add    $0x10,%esp
8010402a:	85 c0                	test   %eax,%eax
8010402c:	74 4f                	je     8010407d <sched+0x7d>
  if(mycpu()->ncli != 1)
8010402e:	e8 0d f9 ff ff       	call   80103940 <mycpu>
80104033:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010403a:	75 68                	jne    801040a4 <sched+0xa4>
  if(p->state == RUNNING)
8010403c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104040:	74 55                	je     80104097 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104042:	9c                   	pushf  
80104043:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104044:	f6 c4 02             	test   $0x2,%ah
80104047:	75 41                	jne    8010408a <sched+0x8a>
  intena = mycpu()->intena;
80104049:	e8 f2 f8 ff ff       	call   80103940 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010404e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104051:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104057:	e8 e4 f8 ff ff       	call   80103940 <mycpu>
8010405c:	83 ec 08             	sub    $0x8,%esp
8010405f:	ff 70 04             	push   0x4(%eax)
80104062:	53                   	push   %ebx
80104063:	e8 23 14 00 00       	call   8010548b <swtch>
  mycpu()->intena = intena;
80104068:	e8 d3 f8 ff ff       	call   80103940 <mycpu>
}
8010406d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104070:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104076:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104079:	5b                   	pop    %ebx
8010407a:	5e                   	pop    %esi
8010407b:	5d                   	pop    %ebp
8010407c:	c3                   	ret    
    panic("sched ptable.lock");
8010407d:	83 ec 0c             	sub    $0xc,%esp
80104080:	68 3b 85 10 80       	push   $0x8010853b
80104085:	e8 f6 c2 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
8010408a:	83 ec 0c             	sub    $0xc,%esp
8010408d:	68 67 85 10 80       	push   $0x80108567
80104092:	e8 e9 c2 ff ff       	call   80100380 <panic>
    panic("sched running");
80104097:	83 ec 0c             	sub    $0xc,%esp
8010409a:	68 59 85 10 80       	push   $0x80108559
8010409f:	e8 dc c2 ff ff       	call   80100380 <panic>
    panic("sched locks");
801040a4:	83 ec 0c             	sub    $0xc,%esp
801040a7:	68 4d 85 10 80       	push   $0x8010854d
801040ac:	e8 cf c2 ff ff       	call   80100380 <panic>
801040b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040bf:	90                   	nop

801040c0 <exit>:
{
801040c0:	55                   	push   %ebp
801040c1:	89 e5                	mov    %esp,%ebp
801040c3:	57                   	push   %edi
801040c4:	56                   	push   %esi
801040c5:	53                   	push   %ebx
801040c6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
801040c9:	e8 f2 f8 ff ff       	call   801039c0 <myproc>
  if(curproc == initproc)
801040ce:	39 05 d4 56 11 80    	cmp    %eax,0x801156d4
801040d4:	0f 84 07 01 00 00    	je     801041e1 <exit+0x121>
801040da:	89 c3                	mov    %eax,%ebx
801040dc:	8d 70 28             	lea    0x28(%eax),%esi
801040df:	8d 78 68             	lea    0x68(%eax),%edi
801040e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
801040e8:	8b 06                	mov    (%esi),%eax
801040ea:	85 c0                	test   %eax,%eax
801040ec:	74 12                	je     80104100 <exit+0x40>
      fileclose(curproc->ofile[fd]);
801040ee:	83 ec 0c             	sub    $0xc,%esp
801040f1:	50                   	push   %eax
801040f2:	e8 09 ce ff ff       	call   80100f00 <fileclose>
      curproc->ofile[fd] = 0;
801040f7:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801040fd:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104100:	83 c6 04             	add    $0x4,%esi
80104103:	39 f7                	cmp    %esi,%edi
80104105:	75 e1                	jne    801040e8 <exit+0x28>
  begin_op();
80104107:	e8 64 ec ff ff       	call   80102d70 <begin_op>
  iput(curproc->cwd);
8010410c:	83 ec 0c             	sub    $0xc,%esp
8010410f:	ff 73 68             	push   0x68(%ebx)
80104112:	e8 a9 d7 ff ff       	call   801018c0 <iput>
  end_op();
80104117:	e8 c4 ec ff ff       	call   80102de0 <end_op>
  curproc->cwd = 0;
8010411c:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80104123:	c7 04 24 a0 2e 11 80 	movl   $0x80112ea0,(%esp)
8010412a:	e8 81 10 00 00       	call   801051b0 <acquire>
  wakeup1(curproc->parent);
8010412f:	8b 53 14             	mov    0x14(%ebx),%edx
80104132:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104135:	b8 d4 2e 11 80       	mov    $0x80112ed4,%eax
8010413a:	eb 10                	jmp    8010414c <exit+0x8c>
8010413c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104140:	05 a0 00 00 00       	add    $0xa0,%eax
80104145:	3d d4 56 11 80       	cmp    $0x801156d4,%eax
8010414a:	74 1e                	je     8010416a <exit+0xaa>
    if(p->state == SLEEPING && p->chan == chan)
8010414c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104150:	75 ee                	jne    80104140 <exit+0x80>
80104152:	3b 50 20             	cmp    0x20(%eax),%edx
80104155:	75 e9                	jne    80104140 <exit+0x80>
      p->state = RUNNABLE;
80104157:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010415e:	05 a0 00 00 00       	add    $0xa0,%eax
80104163:	3d d4 56 11 80       	cmp    $0x801156d4,%eax
80104168:	75 e2                	jne    8010414c <exit+0x8c>
      p->parent = initproc;
8010416a:	8b 0d d4 56 11 80    	mov    0x801156d4,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104170:	ba d4 2e 11 80       	mov    $0x80112ed4,%edx
80104175:	eb 17                	jmp    8010418e <exit+0xce>
80104177:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010417e:	66 90                	xchg   %ax,%ax
80104180:	81 c2 a0 00 00 00    	add    $0xa0,%edx
80104186:	81 fa d4 56 11 80    	cmp    $0x801156d4,%edx
8010418c:	74 3a                	je     801041c8 <exit+0x108>
    if(p->parent == curproc){
8010418e:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104191:	75 ed                	jne    80104180 <exit+0xc0>
      if(p->state == ZOMBIE)
80104193:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104197:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010419a:	75 e4                	jne    80104180 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010419c:	b8 d4 2e 11 80       	mov    $0x80112ed4,%eax
801041a1:	eb 11                	jmp    801041b4 <exit+0xf4>
801041a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801041a7:	90                   	nop
801041a8:	05 a0 00 00 00       	add    $0xa0,%eax
801041ad:	3d d4 56 11 80       	cmp    $0x801156d4,%eax
801041b2:	74 cc                	je     80104180 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
801041b4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801041b8:	75 ee                	jne    801041a8 <exit+0xe8>
801041ba:	3b 48 20             	cmp    0x20(%eax),%ecx
801041bd:	75 e9                	jne    801041a8 <exit+0xe8>
      p->state = RUNNABLE;
801041bf:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801041c6:	eb e0                	jmp    801041a8 <exit+0xe8>
  curproc->state = ZOMBIE;
801041c8:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
801041cf:	e8 2c fe ff ff       	call   80104000 <sched>
  panic("zombie exit");
801041d4:	83 ec 0c             	sub    $0xc,%esp
801041d7:	68 88 85 10 80       	push   $0x80108588
801041dc:	e8 9f c1 ff ff       	call   80100380 <panic>
    panic("init exiting");
801041e1:	83 ec 0c             	sub    $0xc,%esp
801041e4:	68 7b 85 10 80       	push   $0x8010857b
801041e9:	e8 92 c1 ff ff       	call   80100380 <panic>
801041ee:	66 90                	xchg   %ax,%ax

801041f0 <wait>:
{
801041f0:	55                   	push   %ebp
801041f1:	89 e5                	mov    %esp,%ebp
801041f3:	56                   	push   %esi
801041f4:	53                   	push   %ebx
  pushcli();
801041f5:	e8 66 0e 00 00       	call   80105060 <pushcli>
  c = mycpu();
801041fa:	e8 41 f7 ff ff       	call   80103940 <mycpu>
  p = c->proc;
801041ff:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104205:	e8 a6 0e 00 00       	call   801050b0 <popcli>
  acquire(&ptable.lock);
8010420a:	83 ec 0c             	sub    $0xc,%esp
8010420d:	68 a0 2e 11 80       	push   $0x80112ea0
80104212:	e8 99 0f 00 00       	call   801051b0 <acquire>
80104217:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010421a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010421c:	bb d4 2e 11 80       	mov    $0x80112ed4,%ebx
80104221:	eb 13                	jmp    80104236 <wait+0x46>
80104223:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104227:	90                   	nop
80104228:	81 c3 a0 00 00 00    	add    $0xa0,%ebx
8010422e:	81 fb d4 56 11 80    	cmp    $0x801156d4,%ebx
80104234:	74 1e                	je     80104254 <wait+0x64>
      if(p->parent != curproc)
80104236:	39 73 14             	cmp    %esi,0x14(%ebx)
80104239:	75 ed                	jne    80104228 <wait+0x38>
      if(p->state == ZOMBIE){
8010423b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010423f:	74 5f                	je     801042a0 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104241:	81 c3 a0 00 00 00    	add    $0xa0,%ebx
      havekids = 1;
80104247:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010424c:	81 fb d4 56 11 80    	cmp    $0x801156d4,%ebx
80104252:	75 e2                	jne    80104236 <wait+0x46>
    if(!havekids || curproc->killed){
80104254:	85 c0                	test   %eax,%eax
80104256:	0f 84 9a 00 00 00    	je     801042f6 <wait+0x106>
8010425c:	8b 46 24             	mov    0x24(%esi),%eax
8010425f:	85 c0                	test   %eax,%eax
80104261:	0f 85 8f 00 00 00    	jne    801042f6 <wait+0x106>
  pushcli();
80104267:	e8 f4 0d 00 00       	call   80105060 <pushcli>
  c = mycpu();
8010426c:	e8 cf f6 ff ff       	call   80103940 <mycpu>
  p = c->proc;
80104271:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104277:	e8 34 0e 00 00       	call   801050b0 <popcli>
  if(p == 0)
8010427c:	85 db                	test   %ebx,%ebx
8010427e:	0f 84 89 00 00 00    	je     8010430d <wait+0x11d>
  p->chan = chan;
80104284:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104287:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
8010428e:	e8 6d fd ff ff       	call   80104000 <sched>
  p->chan = 0;
80104293:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010429a:	e9 7b ff ff ff       	jmp    8010421a <wait+0x2a>
8010429f:	90                   	nop
        kfree(p->kstack);
801042a0:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
801042a3:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801042a6:	ff 73 08             	push   0x8(%ebx)
801042a9:	e8 22 e2 ff ff       	call   801024d0 <kfree>
        p->kstack = 0;
801042ae:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801042b5:	5a                   	pop    %edx
801042b6:	ff 73 04             	push   0x4(%ebx)
801042b9:	e8 32 39 00 00       	call   80107bf0 <freevm>
        p->pid = 0;
801042be:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801042c5:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801042cc:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801042d0:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801042d7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801042de:	c7 04 24 a0 2e 11 80 	movl   $0x80112ea0,(%esp)
801042e5:	e8 66 0e 00 00       	call   80105150 <release>
        return pid;
801042ea:	83 c4 10             	add    $0x10,%esp
}
801042ed:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042f0:	89 f0                	mov    %esi,%eax
801042f2:	5b                   	pop    %ebx
801042f3:	5e                   	pop    %esi
801042f4:	5d                   	pop    %ebp
801042f5:	c3                   	ret    
      release(&ptable.lock);
801042f6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801042f9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801042fe:	68 a0 2e 11 80       	push   $0x80112ea0
80104303:	e8 48 0e 00 00       	call   80105150 <release>
      return -1;
80104308:	83 c4 10             	add    $0x10,%esp
8010430b:	eb e0                	jmp    801042ed <wait+0xfd>
    panic("sleep");
8010430d:	83 ec 0c             	sub    $0xc,%esp
80104310:	68 94 85 10 80       	push   $0x80108594
80104315:	e8 66 c0 ff ff       	call   80100380 <panic>
8010431a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104320 <yield>:
{
80104320:	55                   	push   %ebp
80104321:	89 e5                	mov    %esp,%ebp
80104323:	56                   	push   %esi
80104324:	53                   	push   %ebx
  acquire(&ptable.lock);  //DOC: yieldlock
80104325:	83 ec 0c             	sub    $0xc,%esp
80104328:	68 a0 2e 11 80       	push   $0x80112ea0
8010432d:	e8 7e 0e 00 00       	call   801051b0 <acquire>
  pushcli();
80104332:	e8 29 0d 00 00       	call   80105060 <pushcli>
  c = mycpu();
80104337:	e8 04 f6 ff ff       	call   80103940 <mycpu>
  p = c->proc;
8010433c:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104342:	e8 69 0d 00 00       	call   801050b0 <popcli>
  myproc()->last_processor_time = ticks;
80104347:	8b 35 e0 56 11 80    	mov    0x801156e0,%esi
  myproc()->state = RUNNABLE;
8010434d:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  pushcli();
80104354:	e8 07 0d 00 00       	call   80105060 <pushcli>
  c = mycpu();
80104359:	e8 e2 f5 ff ff       	call   80103940 <mycpu>
  p = c->proc;
8010435e:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104364:	e8 47 0d 00 00       	call   801050b0 <popcli>
  myproc()->last_processor_time = ticks;
80104369:	89 b3 8c 00 00 00    	mov    %esi,0x8c(%ebx)
  pushcli();
8010436f:	e8 ec 0c 00 00       	call   80105060 <pushcli>
  c = mycpu();
80104374:	e8 c7 f5 ff ff       	call   80103940 <mycpu>
  p = c->proc;
80104379:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010437f:	e8 2c 0d 00 00       	call   801050b0 <popcli>
  myproc()->executed_cycle_number += 1;
80104384:	83 83 98 00 00 00 01 	addl   $0x1,0x98(%ebx)
  sched();
8010438b:	e8 70 fc ff ff       	call   80104000 <sched>
  release(&ptable.lock);
80104390:	c7 04 24 a0 2e 11 80 	movl   $0x80112ea0,(%esp)
80104397:	e8 b4 0d 00 00       	call   80105150 <release>
}
8010439c:	83 c4 10             	add    $0x10,%esp
8010439f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043a2:	5b                   	pop    %ebx
801043a3:	5e                   	pop    %esi
801043a4:	5d                   	pop    %ebp
801043a5:	c3                   	ret    
801043a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043ad:	8d 76 00             	lea    0x0(%esi),%esi

801043b0 <sleep>:
{
801043b0:	55                   	push   %ebp
801043b1:	89 e5                	mov    %esp,%ebp
801043b3:	57                   	push   %edi
801043b4:	56                   	push   %esi
801043b5:	53                   	push   %ebx
801043b6:	83 ec 0c             	sub    $0xc,%esp
801043b9:	8b 7d 08             	mov    0x8(%ebp),%edi
801043bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
801043bf:	e8 9c 0c 00 00       	call   80105060 <pushcli>
  c = mycpu();
801043c4:	e8 77 f5 ff ff       	call   80103940 <mycpu>
  p = c->proc;
801043c9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801043cf:	e8 dc 0c 00 00       	call   801050b0 <popcli>
  if(p == 0)
801043d4:	85 db                	test   %ebx,%ebx
801043d6:	0f 84 87 00 00 00    	je     80104463 <sleep+0xb3>
  if(lk == 0)
801043dc:	85 f6                	test   %esi,%esi
801043de:	74 76                	je     80104456 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801043e0:	81 fe a0 2e 11 80    	cmp    $0x80112ea0,%esi
801043e6:	74 50                	je     80104438 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
801043e8:	83 ec 0c             	sub    $0xc,%esp
801043eb:	68 a0 2e 11 80       	push   $0x80112ea0
801043f0:	e8 bb 0d 00 00       	call   801051b0 <acquire>
    release(lk);
801043f5:	89 34 24             	mov    %esi,(%esp)
801043f8:	e8 53 0d 00 00       	call   80105150 <release>
  p->chan = chan;
801043fd:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104400:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104407:	e8 f4 fb ff ff       	call   80104000 <sched>
  p->chan = 0;
8010440c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104413:	c7 04 24 a0 2e 11 80 	movl   $0x80112ea0,(%esp)
8010441a:	e8 31 0d 00 00       	call   80105150 <release>
    acquire(lk);
8010441f:	89 75 08             	mov    %esi,0x8(%ebp)
80104422:	83 c4 10             	add    $0x10,%esp
}
80104425:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104428:	5b                   	pop    %ebx
80104429:	5e                   	pop    %esi
8010442a:	5f                   	pop    %edi
8010442b:	5d                   	pop    %ebp
    acquire(lk);
8010442c:	e9 7f 0d 00 00       	jmp    801051b0 <acquire>
80104431:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104438:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010443b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104442:	e8 b9 fb ff ff       	call   80104000 <sched>
  p->chan = 0;
80104447:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010444e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104451:	5b                   	pop    %ebx
80104452:	5e                   	pop    %esi
80104453:	5f                   	pop    %edi
80104454:	5d                   	pop    %ebp
80104455:	c3                   	ret    
    panic("sleep without lk");
80104456:	83 ec 0c             	sub    $0xc,%esp
80104459:	68 9a 85 10 80       	push   $0x8010859a
8010445e:	e8 1d bf ff ff       	call   80100380 <panic>
    panic("sleep");
80104463:	83 ec 0c             	sub    $0xc,%esp
80104466:	68 94 85 10 80       	push   $0x80108594
8010446b:	e8 10 bf ff ff       	call   80100380 <panic>

80104470 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104470:	55                   	push   %ebp
80104471:	89 e5                	mov    %esp,%ebp
80104473:	53                   	push   %ebx
80104474:	83 ec 10             	sub    $0x10,%esp
80104477:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010447a:	68 a0 2e 11 80       	push   $0x80112ea0
8010447f:	e8 2c 0d 00 00       	call   801051b0 <acquire>
80104484:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104487:	b8 d4 2e 11 80       	mov    $0x80112ed4,%eax
8010448c:	eb 0e                	jmp    8010449c <wakeup+0x2c>
8010448e:	66 90                	xchg   %ax,%ax
80104490:	05 a0 00 00 00       	add    $0xa0,%eax
80104495:	3d d4 56 11 80       	cmp    $0x801156d4,%eax
8010449a:	74 1e                	je     801044ba <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010449c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801044a0:	75 ee                	jne    80104490 <wakeup+0x20>
801044a2:	3b 58 20             	cmp    0x20(%eax),%ebx
801044a5:	75 e9                	jne    80104490 <wakeup+0x20>
      p->state = RUNNABLE;
801044a7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044ae:	05 a0 00 00 00       	add    $0xa0,%eax
801044b3:	3d d4 56 11 80       	cmp    $0x801156d4,%eax
801044b8:	75 e2                	jne    8010449c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
801044ba:	c7 45 08 a0 2e 11 80 	movl   $0x80112ea0,0x8(%ebp)
}
801044c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044c4:	c9                   	leave  
  release(&ptable.lock);
801044c5:	e9 86 0c 00 00       	jmp    80105150 <release>
801044ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801044d0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	53                   	push   %ebx
801044d4:	83 ec 10             	sub    $0x10,%esp
801044d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801044da:	68 a0 2e 11 80       	push   $0x80112ea0
801044df:	e8 cc 0c 00 00       	call   801051b0 <acquire>
801044e4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044e7:	b8 d4 2e 11 80       	mov    $0x80112ed4,%eax
801044ec:	eb 0e                	jmp    801044fc <kill+0x2c>
801044ee:	66 90                	xchg   %ax,%ax
801044f0:	05 a0 00 00 00       	add    $0xa0,%eax
801044f5:	3d d4 56 11 80       	cmp    $0x801156d4,%eax
801044fa:	74 34                	je     80104530 <kill+0x60>
    if(p->pid == pid){
801044fc:	39 58 10             	cmp    %ebx,0x10(%eax)
801044ff:	75 ef                	jne    801044f0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104501:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104505:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010450c:	75 07                	jne    80104515 <kill+0x45>
        p->state = RUNNABLE;
8010450e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104515:	83 ec 0c             	sub    $0xc,%esp
80104518:	68 a0 2e 11 80       	push   $0x80112ea0
8010451d:	e8 2e 0c 00 00       	call   80105150 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104522:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104525:	83 c4 10             	add    $0x10,%esp
80104528:	31 c0                	xor    %eax,%eax
}
8010452a:	c9                   	leave  
8010452b:	c3                   	ret    
8010452c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104530:	83 ec 0c             	sub    $0xc,%esp
80104533:	68 a0 2e 11 80       	push   $0x80112ea0
80104538:	e8 13 0c 00 00       	call   80105150 <release>
}
8010453d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104540:	83 c4 10             	add    $0x10,%esp
80104543:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104548:	c9                   	leave  
80104549:	c3                   	ret    
8010454a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104550 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104550:	55                   	push   %ebp
80104551:	89 e5                	mov    %esp,%ebp
80104553:	57                   	push   %edi
80104554:	56                   	push   %esi
80104555:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104558:	53                   	push   %ebx
80104559:	bb 40 2f 11 80       	mov    $0x80112f40,%ebx
8010455e:	83 ec 3c             	sub    $0x3c,%esp
80104561:	eb 27                	jmp    8010458a <procdump+0x3a>
80104563:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104567:	90                   	nop
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104568:	83 ec 0c             	sub    $0xc,%esp
8010456b:	68 77 8b 10 80       	push   $0x80108b77
80104570:	e8 2b c1 ff ff       	call   801006a0 <cprintf>
80104575:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104578:	81 c3 a0 00 00 00    	add    $0xa0,%ebx
8010457e:	81 fb 40 57 11 80    	cmp    $0x80115740,%ebx
80104584:	0f 84 7e 00 00 00    	je     80104608 <procdump+0xb8>
    if(p->state == UNUSED)
8010458a:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010458d:	85 c0                	test   %eax,%eax
8010458f:	74 e7                	je     80104578 <procdump+0x28>
      state = "???";
80104591:	ba ab 85 10 80       	mov    $0x801085ab,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104596:	83 f8 05             	cmp    $0x5,%eax
80104599:	77 11                	ja     801045ac <procdump+0x5c>
8010459b:	8b 14 85 b0 87 10 80 	mov    -0x7fef7850(,%eax,4),%edx
      state = "???";
801045a2:	b8 ab 85 10 80       	mov    $0x801085ab,%eax
801045a7:	85 d2                	test   %edx,%edx
801045a9:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801045ac:	53                   	push   %ebx
801045ad:	52                   	push   %edx
801045ae:	ff 73 a4             	push   -0x5c(%ebx)
801045b1:	68 af 85 10 80       	push   $0x801085af
801045b6:	e8 e5 c0 ff ff       	call   801006a0 <cprintf>
    if(p->state == SLEEPING){
801045bb:	83 c4 10             	add    $0x10,%esp
801045be:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801045c2:	75 a4                	jne    80104568 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801045c4:	83 ec 08             	sub    $0x8,%esp
801045c7:	8d 45 c0             	lea    -0x40(%ebp),%eax
801045ca:	8d 7d c0             	lea    -0x40(%ebp),%edi
801045cd:	50                   	push   %eax
801045ce:	8b 43 b0             	mov    -0x50(%ebx),%eax
801045d1:	8b 40 0c             	mov    0xc(%eax),%eax
801045d4:	83 c0 08             	add    $0x8,%eax
801045d7:	50                   	push   %eax
801045d8:	e8 23 0a 00 00       	call   80105000 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
801045dd:	83 c4 10             	add    $0x10,%esp
801045e0:	8b 17                	mov    (%edi),%edx
801045e2:	85 d2                	test   %edx,%edx
801045e4:	74 82                	je     80104568 <procdump+0x18>
        cprintf(" %p", pc[i]);
801045e6:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801045e9:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
801045ec:	52                   	push   %edx
801045ed:	68 01 80 10 80       	push   $0x80108001
801045f2:	e8 a9 c0 ff ff       	call   801006a0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801045f7:	83 c4 10             	add    $0x10,%esp
801045fa:	39 fe                	cmp    %edi,%esi
801045fc:	75 e2                	jne    801045e0 <procdump+0x90>
801045fe:	e9 65 ff ff ff       	jmp    80104568 <procdump+0x18>
80104603:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104607:	90                   	nop
  }
}
80104608:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010460b:	5b                   	pop    %ebx
8010460c:	5e                   	pop    %esi
8010460d:	5f                   	pop    %edi
8010460e:	5d                   	pop    %ebp
8010460f:	c3                   	ret    

80104610 <calculate_sum_of_digits>:

int calculate_sum_of_digits(int n)
{
80104610:	55                   	push   %ebp
80104611:	89 e5                	mov    %esp,%ebp
80104613:	56                   	push   %esi
80104614:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104617:	53                   	push   %ebx
  int result = 0;
80104618:	31 db                	xor    %ebx,%ebx

    while (n != 0)
8010461a:	85 c9                	test   %ecx,%ecx
8010461c:	74 27                	je     80104645 <calculate_sum_of_digits+0x35>
    {
        result += (n % 10);
8010461e:	be 67 66 66 66       	mov    $0x66666667,%esi
80104623:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104627:	90                   	nop
80104628:	89 c8                	mov    %ecx,%eax
8010462a:	f7 ee                	imul   %esi
8010462c:	89 c8                	mov    %ecx,%eax
8010462e:	c1 f8 1f             	sar    $0x1f,%eax
80104631:	c1 fa 02             	sar    $0x2,%edx
80104634:	29 c2                	sub    %eax,%edx
80104636:	8d 04 92             	lea    (%edx,%edx,4),%eax
80104639:	01 c0                	add    %eax,%eax
8010463b:	29 c1                	sub    %eax,%ecx
8010463d:	01 cb                	add    %ecx,%ebx
        n /= 10;
8010463f:	89 d1                	mov    %edx,%ecx
    while (n != 0)
80104641:	85 d2                	test   %edx,%edx
80104643:	75 e3                	jne    80104628 <calculate_sum_of_digits+0x18>
    }

    return result;
}
80104645:	89 d8                	mov    %ebx,%eax
80104647:	5b                   	pop    %ebx
80104648:	5e                   	pop    %esi
80104649:	5d                   	pop    %ebp
8010464a:	c3                   	ret    
8010464b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010464f:	90                   	nop

80104650 <set_process_parent>:

void set_process_parent(int pid)
{
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	57                   	push   %edi
80104654:	56                   	push   %esi
80104655:	53                   	push   %ebx
  struct proc* p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104656:	bb d4 2e 11 80       	mov    $0x80112ed4,%ebx
{
8010465b:	83 ec 0c             	sub    $0xc,%esp
8010465e:	8b 45 08             	mov    0x8(%ebp),%eax
80104661:	eb 13                	jmp    80104676 <set_process_parent+0x26>
80104663:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104667:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104668:	81 c3 a0 00 00 00    	add    $0xa0,%ebx
8010466e:	81 fb d4 56 11 80    	cmp    $0x801156d4,%ebx
80104674:	74 05                	je     8010467b <set_process_parent+0x2b>
  {
    if(p->pid == pid)
80104676:	39 43 10             	cmp    %eax,0x10(%ebx)
80104679:	75 ed                	jne    80104668 <set_process_parent+0x18>
  pushcli();
8010467b:	e8 e0 09 00 00       	call   80105060 <pushcli>
  c = mycpu();
80104680:	e8 bb f2 ff ff       	call   80103940 <mycpu>
  p = c->proc;
80104685:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
8010468b:	e8 20 0a 00 00       	call   801050b0 <popcli>
    {
      break;
    }
  }
  struct proc* myp = myproc();
  myp->is_tracer = 1;
80104690:	c7 46 7c 01 00 00 00 	movl   $0x1,0x7c(%esi)
  myp->tracer_parent = p->parent;
80104697:	8b 43 14             	mov    0x14(%ebx),%eax
  myp->traced_process = p;
8010469a:	89 9e 84 00 00 00    	mov    %ebx,0x84(%esi)
  myp->tracer_parent = p->parent;
801046a0:	89 86 80 00 00 00    	mov    %eax,0x80(%esi)
  pushcli();
801046a6:	e8 b5 09 00 00       	call   80105060 <pushcli>
  c = mycpu();
801046ab:	e8 90 f2 ff ff       	call   80103940 <mycpu>
  p = c->proc;
801046b0:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
801046b6:	e8 f5 09 00 00       	call   801050b0 <popcli>
  p->parent = myproc();
  cprintf("process %d parent changed to %d\n", p->pid, myp->pid);
801046bb:	83 ec 04             	sub    $0x4,%esp
  p->parent = myproc();
801046be:	89 7b 14             	mov    %edi,0x14(%ebx)
  cprintf("process %d parent changed to %d\n", p->pid, myp->pid);
801046c1:	ff 76 10             	push   0x10(%esi)
801046c4:	ff 73 10             	push   0x10(%ebx)
801046c7:	68 44 86 10 80       	push   $0x80108644
801046cc:	e8 cf bf ff ff       	call   801006a0 <cprintf>
}
801046d1:	83 c4 10             	add    $0x10,%esp
801046d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801046d7:	5b                   	pop    %ebx
801046d8:	5e                   	pop    %esi
801046d9:	5f                   	pop    %edi
801046da:	5d                   	pop    %ebp
801046db:	c3                   	ret    
801046dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046e0 <change_process_queue>:

void change_process_queue(int pid, int dest_q)
{
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	56                   	push   %esi
801046e4:	53                   	push   %ebx
801046e5:	8b 75 0c             	mov    0xc(%ebp),%esi
801046e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801046eb:	83 ec 0c             	sub    $0xc,%esp
801046ee:	68 a0 2e 11 80       	push   $0x80112ea0
801046f3:	e8 b8 0a 00 00       	call   801051b0 <acquire>
801046f8:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801046fb:	b8 d4 2e 11 80       	mov    $0x80112ed4,%eax
80104700:	eb 15                	jmp    80104717 <change_process_queue+0x37>
80104702:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104708:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
8010470e:	3d 34 56 11 80       	cmp    $0x80115634,%eax
80104713:	74 3b                	je     80104750 <change_process_queue+0x70>
80104715:	89 d0                	mov    %edx,%eax
  {
    if (p->pid == pid)
80104717:	39 58 10             	cmp    %ebx,0x10(%eax)
8010471a:	75 ec                	jne    80104708 <change_process_queue+0x28>
      break;
    }
  }
  p->q = dest_q;
  p->waiting_time = 0;
  cprintf("process %d priority changed to %d\n", p->pid, dest_q);
8010471c:	83 ec 04             	sub    $0x4,%esp
  p->q = dest_q;
8010471f:	89 b0 88 00 00 00    	mov    %esi,0x88(%eax)
  p->waiting_time = 0;
80104725:	c7 80 94 00 00 00 00 	movl   $0x0,0x94(%eax)
8010472c:	00 00 00 
  cprintf("process %d priority changed to %d\n", p->pid, dest_q);
8010472f:	56                   	push   %esi
80104730:	53                   	push   %ebx
80104731:	68 68 86 10 80       	push   $0x80108668
80104736:	e8 65 bf ff ff       	call   801006a0 <cprintf>

  release(&ptable.lock);
8010473b:	c7 45 08 a0 2e 11 80 	movl   $0x80112ea0,0x8(%ebp)
80104742:	83 c4 10             	add    $0x10,%esp
}
80104745:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104748:	5b                   	pop    %ebx
80104749:	5e                   	pop    %esi
8010474a:	5d                   	pop    %ebp
  release(&ptable.lock);
8010474b:	e9 00 0a 00 00       	jmp    80105150 <release>
  cprintf("process %d priority changed to %d\n", p->pid, dest_q);
80104750:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104756:	b8 d4 56 11 80       	mov    $0x801156d4,%eax
8010475b:	eb bf                	jmp    8010471c <change_process_queue+0x3c>
8010475d:	8d 76 00             	lea    0x0(%esi),%esi

80104760 <set_hrrn_priority>:

void set_hrrn_priority(int pid, int new_priority)
{
80104760:	55                   	push   %ebp
80104761:	89 e5                	mov    %esp,%ebp
80104763:	56                   	push   %esi
80104764:	53                   	push   %ebx
80104765:	8b 75 0c             	mov    0xc(%ebp),%esi
80104768:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010476b:	83 ec 0c             	sub    $0xc,%esp
8010476e:	68 a0 2e 11 80       	push   $0x80112ea0
80104773:	e8 38 0a 00 00       	call   801051b0 <acquire>
80104778:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010477b:	b8 d4 2e 11 80       	mov    $0x80112ed4,%eax
80104780:	eb 15                	jmp    80104797 <set_hrrn_priority+0x37>
80104782:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104788:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
8010478e:	3d 34 56 11 80       	cmp    $0x80115634,%eax
80104793:	74 3b                	je     801047d0 <set_hrrn_priority+0x70>
80104795:	89 d0                	mov    %edx,%eax
  {
    if (p->pid == pid)
80104797:	39 58 10             	cmp    %ebx,0x10(%eax)
8010479a:	75 ec                	jne    80104788 <set_hrrn_priority+0x28>
    {
      break;
    }
  }
  p->hrrn_priority = new_priority;
  cprintf("process %d HRRN priority changed to %d\n", p->pid, new_priority);
8010479c:	83 ec 04             	sub    $0x4,%esp
  p->hrrn_priority = new_priority;
8010479f:	89 b0 9c 00 00 00    	mov    %esi,0x9c(%eax)
  cprintf("process %d HRRN priority changed to %d\n", p->pid, new_priority);
801047a5:	56                   	push   %esi
801047a6:	53                   	push   %ebx
801047a7:	68 8c 86 10 80       	push   $0x8010868c
801047ac:	e8 ef be ff ff       	call   801006a0 <cprintf>

  release(&ptable.lock);
801047b1:	c7 45 08 a0 2e 11 80 	movl   $0x80112ea0,0x8(%ebp)
801047b8:	83 c4 10             	add    $0x10,%esp
}
801047bb:	8d 65 f8             	lea    -0x8(%ebp),%esp
801047be:	5b                   	pop    %ebx
801047bf:	5e                   	pop    %esi
801047c0:	5d                   	pop    %ebp
  release(&ptable.lock);
801047c1:	e9 8a 09 00 00       	jmp    80105150 <release>
801047c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047cd:	8d 76 00             	lea    0x0(%esi),%esi
  cprintf("process %d HRRN priority changed to %d\n", p->pid, new_priority);
801047d0:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801047d6:	b8 d4 56 11 80       	mov    $0x801156d4,%eax
801047db:	eb bf                	jmp    8010479c <set_hrrn_priority+0x3c>
801047dd:	8d 76 00             	lea    0x0(%esi),%esi

801047e0 <set_ptable_hrrn_priority>:

void set_ptable_hrrn_priority(int new_priority)
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	53                   	push   %ebx
801047e4:	83 ec 10             	sub    $0x10,%esp
801047e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801047ea:	68 a0 2e 11 80       	push   $0x80112ea0
801047ef:	e8 bc 09 00 00       	call   801051b0 <acquire>
801047f4:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801047f7:	b8 d4 2e 11 80       	mov    $0x80112ed4,%eax
801047fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  {
    p->hrrn_priority = new_priority;
80104800:	89 98 9c 00 00 00    	mov    %ebx,0x9c(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104806:	05 a0 00 00 00       	add    $0xa0,%eax
8010480b:	3d d4 56 11 80       	cmp    $0x801156d4,%eax
80104810:	75 ee                	jne    80104800 <set_ptable_hrrn_priority+0x20>
  }
  cprintf("all processes HRRN priority changed to %d\n", new_priority);
80104812:	83 ec 08             	sub    $0x8,%esp
80104815:	53                   	push   %ebx
80104816:	68 b4 86 10 80       	push   $0x801086b4
8010481b:	e8 80 be ff ff       	call   801006a0 <cprintf>

  release(&ptable.lock);
80104820:	c7 45 08 a0 2e 11 80 	movl   $0x80112ea0,0x8(%ebp)
}
80104827:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&ptable.lock);
8010482a:	83 c4 10             	add    $0x10,%esp
}
8010482d:	c9                   	leave  
  release(&ptable.lock);
8010482e:	e9 1d 09 00 00       	jmp    80105150 <release>
80104833:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010483a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104840 <get_proc_state>:

char* get_proc_state(int state)
{
80104840:	55                   	push   %ebp
80104841:	b8 b8 85 10 80       	mov    $0x801085b8,%eax
80104846:	89 e5                	mov    %esp,%ebp
80104848:	8b 55 08             	mov    0x8(%ebp),%edx
8010484b:	83 fa 05             	cmp    $0x5,%edx
8010484e:	77 07                	ja     80104857 <get_proc_state+0x17>
80104850:	8b 04 95 98 87 10 80 	mov    -0x7fef7868(,%edx,4),%eax
    return "RUNNING";
  else if(state == ZOMBIE)
    return "ZOMBIE";
  else
    return "UNKNOWN";
}
80104857:	5d                   	pop    %ebp
80104858:	c3                   	ret    
80104859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104860 <get_lenght>:

int get_lenght(int num)
{
80104860:	55                   	push   %ebp
80104861:	89 e5                	mov    %esp,%ebp
80104863:	56                   	push   %esi
80104864:	8b 55 08             	mov    0x8(%ebp),%edx
80104867:	53                   	push   %ebx
  int len = 0;
  if(num == 0)
    return 1;
80104868:	bb 01 00 00 00       	mov    $0x1,%ebx
  if(num == 0)
8010486d:	85 d2                	test   %edx,%edx
8010486f:	74 20                	je     80104891 <get_lenght+0x31>
  int len = 0;
80104871:	bb 00 00 00 00       	mov    $0x0,%ebx
  while(num > 0)
80104876:	7e 19                	jle    80104891 <get_lenght+0x31>
  {
    num /= 10;
80104878:	be cd cc cc cc       	mov    $0xcccccccd,%esi
8010487d:	8d 76 00             	lea    0x0(%esi),%esi
80104880:	89 d0                	mov    %edx,%eax
80104882:	89 d1                	mov    %edx,%ecx
    len++;
80104884:	83 c3 01             	add    $0x1,%ebx
    num /= 10;
80104887:	f7 e6                	mul    %esi
80104889:	c1 ea 03             	shr    $0x3,%edx
  while(num > 0)
8010488c:	83 f9 09             	cmp    $0x9,%ecx
8010488f:	7f ef                	jg     80104880 <get_lenght+0x20>
  }
  return len;
}
80104891:	89 d8                	mov    %ebx,%eax
80104893:	5b                   	pop    %ebx
80104894:	5e                   	pop    %esi
80104895:	5d                   	pop    %ebp
80104896:	c3                   	ret    
80104897:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010489e:	66 90                	xchg   %ax,%ax

801048a0 <print_processes>:

void print_processes(void)
{
801048a0:	55                   	push   %ebp
801048a1:	89 e5                	mov    %esp,%ebp
801048a3:	57                   	push   %edi
801048a4:	56                   	push   %esi
801048a5:	53                   	push   %ebx
801048a6:	83 ec 38             	sub    $0x38,%esp
  struct proc *p;
  acquire(&ptable.lock);
801048a9:	68 a0 2e 11 80       	push   $0x80112ea0
801048ae:	e8 fd 08 00 00       	call   801051b0 <acquire>
  cprintf("name      pid       state       queue_level       cycle        arrival     HRRN     MHRRN\n");
801048b3:	c7 04 24 e0 86 10 80 	movl   $0x801086e0,(%esp)
801048ba:	e8 e1 bd ff ff       	call   801006a0 <cprintf>
  cprintf(".........................................................................................\n");
801048bf:	c7 04 24 3c 87 10 80 	movl   $0x8010873c,(%esp)
801048c6:	e8 d5 bd ff ff       	call   801006a0 <cprintf>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801048cb:	c7 45 e0 40 2f 11 80 	movl   $0x80112f40,-0x20(%ebp)
801048d2:	83 c4 10             	add    $0x10,%esp
801048d5:	eb 20                	jmp    801048f7 <print_processes+0x57>
801048d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048de:	66 90                	xchg   %ax,%ax
801048e0:	81 45 e0 a0 00 00 00 	addl   $0xa0,-0x20(%ebp)
801048e7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801048ea:	bf 40 57 11 80       	mov    $0x80115740,%edi
801048ef:	39 c7                	cmp    %eax,%edi
801048f1:	0f 84 f3 03 00 00    	je     80104cea <print_processes+0x44a>
  {
    if(p->state == UNUSED)
801048f7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801048fa:	8b 50 a0             	mov    -0x60(%eax),%edx
801048fd:	85 d2                	test   %edx,%edx
801048ff:	74 df                	je     801048e0 <print_processes+0x40>
      continue;
    cprintf("%s", p->name);
80104901:	83 ec 08             	sub    $0x8,%esp
80104904:	89 c7                	mov    %eax,%edi
    for(int i = 0; i < 10 - strlen(p->name); i++) cprintf(" ");
80104906:	31 db                	xor    %ebx,%ebx
80104908:	be 0a 00 00 00       	mov    $0xa,%esi
    cprintf("%s", p->name);
8010490d:	50                   	push   %eax
8010490e:	68 b5 85 10 80       	push   $0x801085b5
80104913:	e8 88 bd ff ff       	call   801006a0 <cprintf>
    for(int i = 0; i < 10 - strlen(p->name); i++) cprintf(" ");
80104918:	83 c4 10             	add    $0x10,%esp
8010491b:	eb 16                	jmp    80104933 <print_processes+0x93>
8010491d:	8d 76 00             	lea    0x0(%esi),%esi
80104920:	83 ec 0c             	sub    $0xc,%esp
80104923:	83 c3 01             	add    $0x1,%ebx
80104926:	68 13 86 10 80       	push   $0x80108613
8010492b:	e8 70 bd ff ff       	call   801006a0 <cprintf>
80104930:	83 c4 10             	add    $0x10,%esp
80104933:	83 ec 0c             	sub    $0xc,%esp
80104936:	57                   	push   %edi
80104937:	e8 34 0b 00 00       	call   80105470 <strlen>
8010493c:	83 c4 10             	add    $0x10,%esp
8010493f:	89 c2                	mov    %eax,%edx
80104941:	89 f0                	mov    %esi,%eax
80104943:	29 d0                	sub    %edx,%eax
80104945:	39 d8                	cmp    %ebx,%eax
80104947:	7f d7                	jg     80104920 <print_processes+0x80>

    cprintf("%d", p->pid);
80104949:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010494c:	83 ec 08             	sub    $0x8,%esp
    for(int i = 0; i < 8 - get_lenght(p->pid); i++) cprintf(" ");
8010494f:	31 ff                	xor    %edi,%edi
    cprintf("%d", p->pid);
80104951:	ff 70 a4             	push   -0x5c(%eax)
80104954:	68 c0 85 10 80       	push   $0x801085c0
80104959:	e8 42 bd ff ff       	call   801006a0 <cprintf>
    for(int i = 0; i < 8 - get_lenght(p->pid); i++) cprintf(" ");
8010495e:	83 c4 10             	add    $0x10,%esp
80104961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104968:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010496b:	8b 50 a4             	mov    -0x5c(%eax),%edx
  if(num == 0)
8010496e:	b8 07 00 00 00       	mov    $0x7,%eax
80104973:	85 d2                	test   %edx,%edx
80104975:	74 29                	je     801049a0 <print_processes+0x100>
  while(num > 0)
80104977:	0f 8e 63 03 00 00    	jle    80104ce0 <print_processes+0x440>
  int len = 0;
8010497d:	31 db                	xor    %ebx,%ebx
    num /= 10;
8010497f:	be cd cc cc cc       	mov    $0xcccccccd,%esi
80104984:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104988:	89 d0                	mov    %edx,%eax
8010498a:	89 d1                	mov    %edx,%ecx
    len++;
8010498c:	83 c3 01             	add    $0x1,%ebx
    num /= 10;
8010498f:	f7 e6                	mul    %esi
80104991:	c1 ea 03             	shr    $0x3,%edx
  while(num > 0)
80104994:	83 f9 09             	cmp    $0x9,%ecx
80104997:	7f ef                	jg     80104988 <print_processes+0xe8>
    for(int i = 0; i < 8 - get_lenght(p->pid); i++) cprintf(" ");
80104999:	b8 08 00 00 00       	mov    $0x8,%eax
8010499e:	29 d8                	sub    %ebx,%eax
801049a0:	39 c7                	cmp    %eax,%edi
801049a2:	7d 1c                	jge    801049c0 <print_processes+0x120>
801049a4:	83 ec 0c             	sub    $0xc,%esp
801049a7:	83 c7 01             	add    $0x1,%edi
801049aa:	68 13 86 10 80       	push   $0x80108613
801049af:	e8 ec bc ff ff       	call   801006a0 <cprintf>
801049b4:	83 c4 10             	add    $0x10,%esp
801049b7:	eb af                	jmp    80104968 <print_processes+0xc8>
801049b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    cprintf("%s", get_proc_state(p->state));
801049c0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801049c3:	8b 50 a0             	mov    -0x60(%eax),%edx
801049c6:	b8 b8 85 10 80       	mov    $0x801085b8,%eax
801049cb:	83 fa 05             	cmp    $0x5,%edx
801049ce:	77 07                	ja     801049d7 <print_processes+0x137>
801049d0:	8b 04 95 98 87 10 80 	mov    -0x7fef7868(,%edx,4),%eax
801049d7:	83 ec 08             	sub    $0x8,%esp
    for(int i = 0; i < 17 - strlen(get_proc_state(p->state)); i++) cprintf(" ");
801049da:	31 db                	xor    %ebx,%ebx
801049dc:	be 11 00 00 00       	mov    $0x11,%esi
    cprintf("%s", get_proc_state(p->state));
801049e1:	50                   	push   %eax
801049e2:	68 b5 85 10 80       	push   $0x801085b5
801049e7:	e8 b4 bc ff ff       	call   801006a0 <cprintf>
    for(int i = 0; i < 17 - strlen(get_proc_state(p->state)); i++) cprintf(" ");
801049ec:	8b 7d e0             	mov    -0x20(%ebp),%edi
801049ef:	83 c4 10             	add    $0x10,%esp
801049f2:	eb 17                	jmp    80104a0b <print_processes+0x16b>
801049f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049f8:	83 ec 0c             	sub    $0xc,%esp
801049fb:	83 c3 01             	add    $0x1,%ebx
801049fe:	68 13 86 10 80       	push   $0x80108613
80104a03:	e8 98 bc ff ff       	call   801006a0 <cprintf>
80104a08:	83 c4 10             	add    $0x10,%esp
80104a0b:	8b 57 a0             	mov    -0x60(%edi),%edx
80104a0e:	b8 b8 85 10 80       	mov    $0x801085b8,%eax
80104a13:	83 fa 05             	cmp    $0x5,%edx
80104a16:	77 07                	ja     80104a1f <print_processes+0x17f>
80104a18:	8b 04 95 98 87 10 80 	mov    -0x7fef7868(,%edx,4),%eax
80104a1f:	83 ec 0c             	sub    $0xc,%esp
80104a22:	50                   	push   %eax
80104a23:	e8 48 0a 00 00       	call   80105470 <strlen>
80104a28:	83 c4 10             	add    $0x10,%esp
80104a2b:	89 c2                	mov    %eax,%edx
80104a2d:	89 f0                	mov    %esi,%eax
80104a2f:	29 d0                	sub    %edx,%eax
80104a31:	39 d8                	cmp    %ebx,%eax
80104a33:	7f c3                	jg     801049f8 <print_processes+0x158>

    cprintf("%d", p->q);
80104a35:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104a38:	83 ec 08             	sub    $0x8,%esp
    for(int i = 0; i < 17 - get_lenght(p->q); i++) cprintf(" ");
80104a3b:	31 ff                	xor    %edi,%edi
    cprintf("%d", p->q);
80104a3d:	ff 70 1c             	push   0x1c(%eax)
80104a40:	68 c0 85 10 80       	push   $0x801085c0
80104a45:	e8 56 bc ff ff       	call   801006a0 <cprintf>
    for(int i = 0; i < 17 - get_lenght(p->q); i++) cprintf(" ");
80104a4a:	83 c4 10             	add    $0x10,%esp
80104a4d:	8d 76 00             	lea    0x0(%esi),%esi
80104a50:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104a53:	8b 50 1c             	mov    0x1c(%eax),%edx
  if(num == 0)
80104a56:	b8 10 00 00 00       	mov    $0x10,%eax
80104a5b:	85 d2                	test   %edx,%edx
80104a5d:	74 29                	je     80104a88 <print_processes+0x1e8>
  while(num > 0)
80104a5f:	0f 8e 6b 02 00 00    	jle    80104cd0 <print_processes+0x430>
  int len = 0;
80104a65:	31 db                	xor    %ebx,%ebx
    num /= 10;
80104a67:	be cd cc cc cc       	mov    $0xcccccccd,%esi
80104a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a70:	89 d0                	mov    %edx,%eax
80104a72:	89 d1                	mov    %edx,%ecx
    len++;
80104a74:	83 c3 01             	add    $0x1,%ebx
    num /= 10;
80104a77:	f7 e6                	mul    %esi
80104a79:	c1 ea 03             	shr    $0x3,%edx
  while(num > 0)
80104a7c:	83 f9 09             	cmp    $0x9,%ecx
80104a7f:	7f ef                	jg     80104a70 <print_processes+0x1d0>
    for(int i = 0; i < 17 - get_lenght(p->q); i++) cprintf(" ");
80104a81:	b8 11 00 00 00       	mov    $0x11,%eax
80104a86:	29 d8                	sub    %ebx,%eax
80104a88:	39 c7                	cmp    %eax,%edi
80104a8a:	7d 1c                	jge    80104aa8 <print_processes+0x208>
80104a8c:	83 ec 0c             	sub    $0xc,%esp
80104a8f:	83 c7 01             	add    $0x1,%edi
80104a92:	68 13 86 10 80       	push   $0x80108613
80104a97:	e8 04 bc ff ff       	call   801006a0 <cprintf>
80104a9c:	83 c4 10             	add    $0x10,%esp
80104a9f:	eb af                	jmp    80104a50 <print_processes+0x1b0>
80104aa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    cprintf("%d", p->executed_cycle_number);
80104aa8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104aab:	83 ec 08             	sub    $0x8,%esp
    for(int i = 0; i < 15 - get_lenght(p->executed_cycle_number); i++) cprintf(" ");
80104aae:	31 ff                	xor    %edi,%edi
    cprintf("%d", p->executed_cycle_number);
80104ab0:	ff 70 2c             	push   0x2c(%eax)
80104ab3:	68 c0 85 10 80       	push   $0x801085c0
80104ab8:	e8 e3 bb ff ff       	call   801006a0 <cprintf>
    for(int i = 0; i < 15 - get_lenght(p->executed_cycle_number); i++) cprintf(" ");
80104abd:	83 c4 10             	add    $0x10,%esp
80104ac0:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104ac3:	8b 50 2c             	mov    0x2c(%eax),%edx
  if(num == 0)
80104ac6:	b8 0e 00 00 00       	mov    $0xe,%eax
80104acb:	85 d2                	test   %edx,%edx
80104acd:	74 29                	je     80104af8 <print_processes+0x258>
  while(num > 0)
80104acf:	0f 8e eb 01 00 00    	jle    80104cc0 <print_processes+0x420>
  int len = 0;
80104ad5:	31 db                	xor    %ebx,%ebx
    num /= 10;
80104ad7:	be cd cc cc cc       	mov    $0xcccccccd,%esi
80104adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ae0:	89 d0                	mov    %edx,%eax
80104ae2:	89 d1                	mov    %edx,%ecx
    len++;
80104ae4:	83 c3 01             	add    $0x1,%ebx
    num /= 10;
80104ae7:	f7 e6                	mul    %esi
80104ae9:	c1 ea 03             	shr    $0x3,%edx
  while(num > 0)
80104aec:	83 f9 09             	cmp    $0x9,%ecx
80104aef:	7f ef                	jg     80104ae0 <print_processes+0x240>
    for(int i = 0; i < 15 - get_lenght(p->executed_cycle_number); i++) cprintf(" ");
80104af1:	b8 0f 00 00 00       	mov    $0xf,%eax
80104af6:	29 d8                	sub    %ebx,%eax
80104af8:	39 c7                	cmp    %eax,%edi
80104afa:	7d 1c                	jge    80104b18 <print_processes+0x278>
80104afc:	83 ec 0c             	sub    $0xc,%esp
80104aff:	83 c7 01             	add    $0x1,%edi
80104b02:	68 13 86 10 80       	push   $0x80108613
80104b07:	e8 94 bb ff ff       	call   801006a0 <cprintf>
80104b0c:	83 c4 10             	add    $0x10,%esp
80104b0f:	eb af                	jmp    80104ac0 <print_processes+0x220>
80104b11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    cprintf("%d", p->creation_time);
80104b18:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104b1b:	83 ec 08             	sub    $0x8,%esp
    for(int i = 0; i < 10 - get_lenght(p->creation_time); i++) cprintf(" ");
80104b1e:	31 ff                	xor    %edi,%edi
    cprintf("%d", p->creation_time);
80104b20:	ff 70 24             	push   0x24(%eax)
80104b23:	68 c0 85 10 80       	push   $0x801085c0
80104b28:	e8 73 bb ff ff       	call   801006a0 <cprintf>
    for(int i = 0; i < 10 - get_lenght(p->creation_time); i++) cprintf(" ");
80104b2d:	83 c4 10             	add    $0x10,%esp
80104b30:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104b33:	8b 50 24             	mov    0x24(%eax),%edx
  if(num == 0)
80104b36:	b8 09 00 00 00       	mov    $0x9,%eax
80104b3b:	85 d2                	test   %edx,%edx
80104b3d:	74 29                	je     80104b68 <print_processes+0x2c8>
  while(num > 0)
80104b3f:	0f 8e 6b 01 00 00    	jle    80104cb0 <print_processes+0x410>
  int len = 0;
80104b45:	31 db                	xor    %ebx,%ebx
    num /= 10;
80104b47:	be cd cc cc cc       	mov    $0xcccccccd,%esi
80104b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b50:	89 d0                	mov    %edx,%eax
80104b52:	89 d1                	mov    %edx,%ecx
    len++;
80104b54:	83 c3 01             	add    $0x1,%ebx
    num /= 10;
80104b57:	f7 e6                	mul    %esi
80104b59:	c1 ea 03             	shr    $0x3,%edx
  while(num > 0)
80104b5c:	83 f9 09             	cmp    $0x9,%ecx
80104b5f:	7f ef                	jg     80104b50 <print_processes+0x2b0>
    for(int i = 0; i < 10 - get_lenght(p->creation_time); i++) cprintf(" ");
80104b61:	b8 0a 00 00 00       	mov    $0xa,%eax
80104b66:	29 d8                	sub    %ebx,%eax
80104b68:	39 c7                	cmp    %eax,%edi
80104b6a:	7d 1c                	jge    80104b88 <print_processes+0x2e8>
80104b6c:	83 ec 0c             	sub    $0xc,%esp
80104b6f:	83 c7 01             	add    $0x1,%edi
80104b72:	68 13 86 10 80       	push   $0x80108613
80104b77:	e8 24 bb ff ff       	call   801006a0 <cprintf>
80104b7c:	83 c4 10             	add    $0x10,%esp
80104b7f:	eb af                	jmp    80104b30 <print_processes+0x290>
80104b81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    cprintf("%d", p->hrrn_priority);
80104b88:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104b8b:	83 ec 08             	sub    $0x8,%esp
    for(int i = 0; i < 10 - get_lenght(p->hrrn_priority); i++) cprintf(" ");
80104b8e:	31 ff                	xor    %edi,%edi
    cprintf("%d", p->hrrn_priority);
80104b90:	ff 70 30             	push   0x30(%eax)
80104b93:	68 c0 85 10 80       	push   $0x801085c0
80104b98:	e8 03 bb ff ff       	call   801006a0 <cprintf>
    for(int i = 0; i < 10 - get_lenght(p->hrrn_priority); i++) cprintf(" ");
80104b9d:	83 c4 10             	add    $0x10,%esp
80104ba0:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104ba3:	8b 50 30             	mov    0x30(%eax),%edx
80104ba6:	b8 09 00 00 00       	mov    $0x9,%eax
80104bab:	89 55 dc             	mov    %edx,-0x24(%ebp)
  if(num == 0)
80104bae:	85 d2                	test   %edx,%edx
80104bb0:	74 26                	je     80104bd8 <print_processes+0x338>
  while(num > 0)
80104bb2:	0f 8e e8 00 00 00    	jle    80104ca0 <print_processes+0x400>
  int len = 0;
80104bb8:	31 db                	xor    %ebx,%ebx
    num /= 10;
80104bba:	be cd cc cc cc       	mov    $0xcccccccd,%esi
80104bbf:	90                   	nop
80104bc0:	89 d0                	mov    %edx,%eax
80104bc2:	89 d1                	mov    %edx,%ecx
    len++;
80104bc4:	83 c3 01             	add    $0x1,%ebx
    num /= 10;
80104bc7:	f7 e6                	mul    %esi
80104bc9:	c1 ea 03             	shr    $0x3,%edx
  while(num > 0)
80104bcc:	83 f9 09             	cmp    $0x9,%ecx
80104bcf:	7f ef                	jg     80104bc0 <print_processes+0x320>
    for(int i = 0; i < 10 - get_lenght(p->hrrn_priority); i++) cprintf(" ");
80104bd1:	b8 0a 00 00 00       	mov    $0xa,%eax
80104bd6:	29 d8                	sub    %ebx,%eax
80104bd8:	39 c7                	cmp    %eax,%edi
80104bda:	7d 1c                	jge    80104bf8 <print_processes+0x358>
80104bdc:	83 ec 0c             	sub    $0xc,%esp
80104bdf:	83 c7 01             	add    $0x1,%edi
80104be2:	68 13 86 10 80       	push   $0x80108613
80104be7:	e8 b4 ba ff ff       	call   801006a0 <cprintf>
80104bec:	83 c4 10             	add    $0x10,%esp
80104bef:	eb af                	jmp    80104ba0 <print_processes+0x300>
80104bf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    float hrrn = (waiting_time - process->executed_cycle_number) * 1.0 / process->executed_cycle_number;
80104bf8:	8b 7d e0             	mov    -0x20(%ebp),%edi

    cprintf("%d", get_mhrrn(p));
80104bfb:	83 ec 08             	sub    $0x8,%esp
    float hrrn = (waiting_time - process->executed_cycle_number) * 1.0 / process->executed_cycle_number;
80104bfe:	8b 47 2c             	mov    0x2c(%edi),%eax
80104c01:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int waiting_time = ticks - process->creation_time;
80104c04:	a1 e0 56 11 80       	mov    0x801156e0,%eax
80104c09:	2b 47 24             	sub    0x24(%edi),%eax
    float hrrn = (waiting_time - process->executed_cycle_number) * 1.0 / process->executed_cycle_number;
80104c0c:	2b 45 d8             	sub    -0x28(%ebp),%eax
    return mhrrn;
80104c0f:	d9 7d e6             	fnstcw -0x1a(%ebp)
    float hrrn = (waiting_time - process->executed_cycle_number) * 1.0 / process->executed_cycle_number;
80104c12:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80104c15:	db 45 d4             	fildl  -0x2c(%ebp)
80104c18:	db 45 d8             	fildl  -0x28(%ebp)
    return mhrrn;
80104c1b:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
    float hrrn = (waiting_time - process->executed_cycle_number) * 1.0 / process->executed_cycle_number;
80104c1f:	de f9                	fdivrp %st,%st(1)
    return mhrrn;
80104c21:	80 cc 0c             	or     $0xc,%ah
80104c24:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
    float hrrn = (waiting_time - process->executed_cycle_number) * 1.0 / process->executed_cycle_number;
80104c28:	d9 5d d8             	fstps  -0x28(%ebp)
80104c2b:	d9 45 d8             	flds   -0x28(%ebp)
    float mhrrn = (hrrn + process->hrrn_priority) / 2;
80104c2e:	db 45 dc             	fildl  -0x24(%ebp)
80104c31:	de c1                	faddp  %st,%st(1)
80104c33:	d8 0d c8 87 10 80    	fmuls  0x801087c8
    return mhrrn;
80104c39:	d9 6d e4             	fldcw  -0x1c(%ebp)
80104c3c:	db 5d dc             	fistpl -0x24(%ebp)
80104c3f:	d9 6d e6             	fldcw  -0x1a(%ebp)
80104c42:	8b 45 dc             	mov    -0x24(%ebp),%eax
    cprintf("%d", get_mhrrn(p));
80104c45:	50                   	push   %eax
80104c46:	68 c0 85 10 80       	push   $0x801085c0
80104c4b:	e8 50 ba ff ff       	call   801006a0 <cprintf>
    for(int i = 0; i < 5; i++) cprintf(" ");
80104c50:	c7 04 24 13 86 10 80 	movl   $0x80108613,(%esp)
80104c57:	e8 44 ba ff ff       	call   801006a0 <cprintf>
80104c5c:	c7 04 24 13 86 10 80 	movl   $0x80108613,(%esp)
80104c63:	e8 38 ba ff ff       	call   801006a0 <cprintf>
80104c68:	c7 04 24 13 86 10 80 	movl   $0x80108613,(%esp)
80104c6f:	e8 2c ba ff ff       	call   801006a0 <cprintf>
80104c74:	c7 04 24 13 86 10 80 	movl   $0x80108613,(%esp)
80104c7b:	e8 20 ba ff ff       	call   801006a0 <cprintf>
80104c80:	c7 04 24 13 86 10 80 	movl   $0x80108613,(%esp)
80104c87:	e8 14 ba ff ff       	call   801006a0 <cprintf>
    cprintf("\n");
80104c8c:	c7 04 24 77 8b 10 80 	movl   $0x80108b77,(%esp)
80104c93:	e8 08 ba ff ff       	call   801006a0 <cprintf>
80104c98:	83 c4 10             	add    $0x10,%esp
80104c9b:	e9 40 fc ff ff       	jmp    801048e0 <print_processes+0x40>
  while(num > 0)
80104ca0:	b8 0a 00 00 00       	mov    $0xa,%eax
80104ca5:	e9 2e ff ff ff       	jmp    80104bd8 <print_processes+0x338>
80104caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104cb0:	b8 0a 00 00 00       	mov    $0xa,%eax
80104cb5:	e9 ae fe ff ff       	jmp    80104b68 <print_processes+0x2c8>
80104cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104cc0:	b8 0f 00 00 00       	mov    $0xf,%eax
80104cc5:	e9 2e fe ff ff       	jmp    80104af8 <print_processes+0x258>
80104cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104cd0:	b8 11 00 00 00       	mov    $0x11,%eax
80104cd5:	e9 ae fd ff ff       	jmp    80104a88 <print_processes+0x1e8>
80104cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ce0:	b8 08 00 00 00       	mov    $0x8,%eax
80104ce5:	e9 b6 fc ff ff       	jmp    801049a0 <print_processes+0x100>

  }
  release(&ptable.lock);
80104cea:	83 ec 0c             	sub    $0xc,%esp
80104ced:	68 a0 2e 11 80       	push   $0x80112ea0
80104cf2:	e8 59 04 00 00       	call   80105150 <release>
}
80104cf7:	83 c4 10             	add    $0x10,%esp
80104cfa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104cfd:	5b                   	pop    %ebx
80104cfe:	5e                   	pop    %esi
80104cff:	5f                   	pop    %edi
80104d00:	5d                   	pop    %ebp
80104d01:	c3                   	ret    
80104d02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104d10 <sem_init>:
  struct spinlock lock;
};

struct semaphore chop_stick[6];

int sem_init(int i, int v){
80104d10:	55                   	push   %ebp
80104d11:	89 e5                	mov    %esp,%ebp
80104d13:	57                   	push   %edi
80104d14:	56                   	push   %esi
80104d15:	53                   	push   %ebx
80104d16:	83 ec 18             	sub    $0x18,%esp

  acquire(&chop_stick[i].lock);
80104d19:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104d1c:	c1 e3 06             	shl    $0x6,%ebx
80104d1f:	8d bb 2c 2d 11 80    	lea    -0x7feed2d4(%ebx),%edi
80104d25:	57                   	push   %edi
80104d26:	e8 85 04 00 00       	call   801051b0 <acquire>

  if (chop_stick[i].locked == 0) {
80104d2b:	8b b3 24 2d 11 80    	mov    -0x7feed2dc(%ebx),%esi
80104d31:	83 c4 10             	add    $0x10,%esp
80104d34:	85 f6                	test   %esi,%esi
80104d36:	75 38                	jne    80104d70 <sem_init+0x60>
    chop_stick[i].locked = 1;
80104d38:	c7 83 24 2d 11 80 01 	movl   $0x1,-0x7feed2dc(%ebx)
80104d3f:	00 00 00 
  } else {
    release(&chop_stick[i].lock);
    return -1;
  }  

  release(&chop_stick[i].lock);
80104d42:	83 ec 0c             	sub    $0xc,%esp
    chop_stick[i].value = v;
80104d45:	8b 55 0c             	mov    0xc(%ebp),%edx
  release(&chop_stick[i].lock);
80104d48:	57                   	push   %edi
    chop_stick[i].value = v;
80104d49:	89 93 20 2d 11 80    	mov    %edx,-0x7feed2e0(%ebx)
    chop_stick[i].owner = -1;
80104d4f:	c7 83 28 2d 11 80 ff 	movl   $0xffffffff,-0x7feed2d8(%ebx)
80104d56:	ff ff ff 
  release(&chop_stick[i].lock);
80104d59:	e8 f2 03 00 00       	call   80105150 <release>

  return 0;
80104d5e:	83 c4 10             	add    $0x10,%esp

}
80104d61:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d64:	89 f0                	mov    %esi,%eax
80104d66:	5b                   	pop    %ebx
80104d67:	5e                   	pop    %esi
80104d68:	5f                   	pop    %edi
80104d69:	5d                   	pop    %ebp
80104d6a:	c3                   	ret    
80104d6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d6f:	90                   	nop
    release(&chop_stick[i].lock);
80104d70:	83 ec 0c             	sub    $0xc,%esp
    return -1;
80104d73:	be ff ff ff ff       	mov    $0xffffffff,%esi
    release(&chop_stick[i].lock);
80104d78:	57                   	push   %edi
80104d79:	e8 d2 03 00 00       	call   80105150 <release>
    return -1;
80104d7e:	83 c4 10             	add    $0x10,%esp
80104d81:	eb de                	jmp    80104d61 <sem_init+0x51>
80104d83:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104d90 <sem_acquire>:

int sem_acquire(int i){
80104d90:	55                   	push   %ebp
80104d91:	89 e5                	mov    %esp,%ebp
80104d93:	57                   	push   %edi
80104d94:	56                   	push   %esi
80104d95:	53                   	push   %ebx
80104d96:	83 ec 18             	sub    $0x18,%esp
80104d99:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104d9c:	c1 e3 06             	shl    $0x6,%ebx

  acquire(&chop_stick[i].lock);
80104d9f:	8d b3 2c 2d 11 80    	lea    -0x7feed2d4(%ebx),%esi

  if (chop_stick[i].value >= 1) {
80104da5:	8d bb 20 2d 11 80    	lea    -0x7feed2e0(%ebx),%edi
  acquire(&chop_stick[i].lock);
80104dab:	56                   	push   %esi
80104dac:	e8 ff 03 00 00       	call   801051b0 <acquire>
  if (chop_stick[i].value >= 1) {
80104db1:	8b 93 20 2d 11 80    	mov    -0x7feed2e0(%ebx),%edx
80104db7:	83 c4 10             	add    $0x10,%esp
80104dba:	8d 42 ff             	lea    -0x1(%edx),%eax
80104dbd:	85 d2                	test   %edx,%edx
80104dbf:	7e 2f                	jle    80104df0 <sem_acquire+0x60>
     chop_stick[i].value = chop_stick[i].value - 1;
80104dc1:	8b 55 08             	mov    0x8(%ebp),%edx
    while (chop_stick[i].value < 1) sleep(&chop_stick[i],&chop_stick[i].lock);
    chop_stick[i].value = chop_stick[i].value - 1;
    chop_stick[i].owner = i;
  }

  release(&chop_stick[i].lock);
80104dc4:	83 ec 0c             	sub    $0xc,%esp
80104dc7:	56                   	push   %esi
     chop_stick[i].value = chop_stick[i].value - 1;
80104dc8:	c1 e2 06             	shl    $0x6,%edx
80104dcb:	89 82 20 2d 11 80    	mov    %eax,-0x7feed2e0(%edx)
     chop_stick[i].owner = i;
80104dd1:	8b 45 08             	mov    0x8(%ebp),%eax
80104dd4:	89 82 28 2d 11 80    	mov    %eax,-0x7feed2d8(%edx)
  release(&chop_stick[i].lock);
80104dda:	e8 71 03 00 00       	call   80105150 <release>

  return 0;
}
80104ddf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104de2:	31 c0                	xor    %eax,%eax
80104de4:	5b                   	pop    %ebx
80104de5:	5e                   	pop    %esi
80104de6:	5f                   	pop    %edi
80104de7:	5d                   	pop    %ebp
80104de8:	c3                   	ret    
80104de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while (chop_stick[i].value < 1) sleep(&chop_stick[i],&chop_stick[i].lock);
80104df0:	83 ec 08             	sub    $0x8,%esp
80104df3:	56                   	push   %esi
80104df4:	57                   	push   %edi
80104df5:	e8 b6 f5 ff ff       	call   801043b0 <sleep>
80104dfa:	8b 83 20 2d 11 80    	mov    -0x7feed2e0(%ebx),%eax
80104e00:	83 c4 10             	add    $0x10,%esp
80104e03:	85 c0                	test   %eax,%eax
80104e05:	7e e9                	jle    80104df0 <sem_acquire+0x60>
    chop_stick[i].value = chop_stick[i].value - 1;
80104e07:	83 e8 01             	sub    $0x1,%eax
    chop_stick[i].owner = i;
80104e0a:	eb b5                	jmp    80104dc1 <sem_acquire+0x31>
80104e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104e10 <sem_release>:

int sem_release(int i){
80104e10:	55                   	push   %ebp
80104e11:	89 e5                	mov    %esp,%ebp
80104e13:	57                   	push   %edi
80104e14:	56                   	push   %esi
80104e15:	53                   	push   %ebx
80104e16:	83 ec 18             	sub    $0x18,%esp
80104e19:	8b 7d 08             	mov    0x8(%ebp),%edi
80104e1c:	c1 e7 06             	shl    $0x6,%edi
  
  acquire(&chop_stick[i].lock);
80104e1f:	8d b7 2c 2d 11 80    	lea    -0x7feed2d4(%edi),%esi
  chop_stick[i].value = chop_stick[i].value + 1;
80104e25:	8d 9f 20 2d 11 80    	lea    -0x7feed2e0(%edi),%ebx
  acquire(&chop_stick[i].lock);
80104e2b:	56                   	push   %esi
80104e2c:	e8 7f 03 00 00       	call   801051b0 <acquire>
  acquire(&ptable.lock);
80104e31:	c7 04 24 a0 2e 11 80 	movl   $0x80112ea0,(%esp)
  chop_stick[i].value = chop_stick[i].value + 1;
80104e38:	83 87 20 2d 11 80 01 	addl   $0x1,-0x7feed2e0(%edi)
  chop_stick[i].owner = -1;
80104e3f:	c7 43 08 ff ff ff ff 	movl   $0xffffffff,0x8(%ebx)
  acquire(&ptable.lock);
80104e46:	e8 65 03 00 00       	call   801051b0 <acquire>
80104e4b:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104e4e:	b8 d4 2e 11 80       	mov    $0x80112ed4,%eax
80104e53:	eb 0f                	jmp    80104e64 <sem_release+0x54>
80104e55:	8d 76 00             	lea    0x0(%esi),%esi
80104e58:	05 a0 00 00 00       	add    $0xa0,%eax
80104e5d:	3d d4 56 11 80       	cmp    $0x801156d4,%eax
80104e62:	74 1e                	je     80104e82 <sem_release+0x72>
    if(p->state == SLEEPING && p->chan == chan)
80104e64:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104e68:	75 ee                	jne    80104e58 <sem_release+0x48>
80104e6a:	3b 58 20             	cmp    0x20(%eax),%ebx
80104e6d:	75 e9                	jne    80104e58 <sem_release+0x48>
      p->state = RUNNABLE;
80104e6f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104e76:	05 a0 00 00 00       	add    $0xa0,%eax
80104e7b:	3d d4 56 11 80       	cmp    $0x801156d4,%eax
80104e80:	75 e2                	jne    80104e64 <sem_release+0x54>
  release(&ptable.lock);
80104e82:	83 ec 0c             	sub    $0xc,%esp
80104e85:	68 a0 2e 11 80       	push   $0x80112ea0
80104e8a:	e8 c1 02 00 00       	call   80105150 <release>
  wakeup(&chop_stick[i]); 
  release(&chop_stick[i].lock);
80104e8f:	89 34 24             	mov    %esi,(%esp)
80104e92:	e8 b9 02 00 00       	call   80105150 <release>

  return 0;
}
80104e97:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e9a:	31 c0                	xor    %eax,%eax
80104e9c:	5b                   	pop    %ebx
80104e9d:	5e                   	pop    %esi
80104e9e:	5f                   	pop    %edi
80104e9f:	5d                   	pop    %ebp
80104ea0:	c3                   	ret    
80104ea1:	66 90                	xchg   %ax,%ax
80104ea3:	66 90                	xchg   %ax,%ax
80104ea5:	66 90                	xchg   %ax,%ax
80104ea7:	66 90                	xchg   %ax,%ax
80104ea9:	66 90                	xchg   %ax,%ax
80104eab:	66 90                	xchg   %ax,%ax
80104ead:	66 90                	xchg   %ax,%ax
80104eaf:	90                   	nop

80104eb0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104eb0:	55                   	push   %ebp
80104eb1:	89 e5                	mov    %esp,%ebp
80104eb3:	53                   	push   %ebx
80104eb4:	83 ec 0c             	sub    $0xc,%esp
80104eb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104eba:	68 cc 87 10 80       	push   $0x801087cc
80104ebf:	8d 43 04             	lea    0x4(%ebx),%eax
80104ec2:	50                   	push   %eax
80104ec3:	e8 18 01 00 00       	call   80104fe0 <initlock>
  lk->name = name;
80104ec8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104ecb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104ed1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104ed4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104edb:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104ede:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ee1:	c9                   	leave  
80104ee2:	c3                   	ret    
80104ee3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ef0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104ef0:	55                   	push   %ebp
80104ef1:	89 e5                	mov    %esp,%ebp
80104ef3:	56                   	push   %esi
80104ef4:	53                   	push   %ebx
80104ef5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104ef8:	8d 73 04             	lea    0x4(%ebx),%esi
80104efb:	83 ec 0c             	sub    $0xc,%esp
80104efe:	56                   	push   %esi
80104eff:	e8 ac 02 00 00       	call   801051b0 <acquire>
  while (lk->locked) {
80104f04:	8b 13                	mov    (%ebx),%edx
80104f06:	83 c4 10             	add    $0x10,%esp
80104f09:	85 d2                	test   %edx,%edx
80104f0b:	74 16                	je     80104f23 <acquiresleep+0x33>
80104f0d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104f10:	83 ec 08             	sub    $0x8,%esp
80104f13:	56                   	push   %esi
80104f14:	53                   	push   %ebx
80104f15:	e8 96 f4 ff ff       	call   801043b0 <sleep>
  while (lk->locked) {
80104f1a:	8b 03                	mov    (%ebx),%eax
80104f1c:	83 c4 10             	add    $0x10,%esp
80104f1f:	85 c0                	test   %eax,%eax
80104f21:	75 ed                	jne    80104f10 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104f23:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104f29:	e8 92 ea ff ff       	call   801039c0 <myproc>
80104f2e:	8b 40 10             	mov    0x10(%eax),%eax
80104f31:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104f34:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104f37:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f3a:	5b                   	pop    %ebx
80104f3b:	5e                   	pop    %esi
80104f3c:	5d                   	pop    %ebp
  release(&lk->lk);
80104f3d:	e9 0e 02 00 00       	jmp    80105150 <release>
80104f42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104f50 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104f50:	55                   	push   %ebp
80104f51:	89 e5                	mov    %esp,%ebp
80104f53:	56                   	push   %esi
80104f54:	53                   	push   %ebx
80104f55:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104f58:	8d 73 04             	lea    0x4(%ebx),%esi
80104f5b:	83 ec 0c             	sub    $0xc,%esp
80104f5e:	56                   	push   %esi
80104f5f:	e8 4c 02 00 00       	call   801051b0 <acquire>
  lk->locked = 0;
80104f64:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104f6a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104f71:	89 1c 24             	mov    %ebx,(%esp)
80104f74:	e8 f7 f4 ff ff       	call   80104470 <wakeup>
  release(&lk->lk);
80104f79:	89 75 08             	mov    %esi,0x8(%ebp)
80104f7c:	83 c4 10             	add    $0x10,%esp
}
80104f7f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f82:	5b                   	pop    %ebx
80104f83:	5e                   	pop    %esi
80104f84:	5d                   	pop    %ebp
  release(&lk->lk);
80104f85:	e9 c6 01 00 00       	jmp    80105150 <release>
80104f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104f90 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104f90:	55                   	push   %ebp
80104f91:	89 e5                	mov    %esp,%ebp
80104f93:	57                   	push   %edi
80104f94:	31 ff                	xor    %edi,%edi
80104f96:	56                   	push   %esi
80104f97:	53                   	push   %ebx
80104f98:	83 ec 18             	sub    $0x18,%esp
80104f9b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104f9e:	8d 73 04             	lea    0x4(%ebx),%esi
80104fa1:	56                   	push   %esi
80104fa2:	e8 09 02 00 00       	call   801051b0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104fa7:	8b 03                	mov    (%ebx),%eax
80104fa9:	83 c4 10             	add    $0x10,%esp
80104fac:	85 c0                	test   %eax,%eax
80104fae:	75 18                	jne    80104fc8 <holdingsleep+0x38>
  release(&lk->lk);
80104fb0:	83 ec 0c             	sub    $0xc,%esp
80104fb3:	56                   	push   %esi
80104fb4:	e8 97 01 00 00       	call   80105150 <release>
  return r;
}
80104fb9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104fbc:	89 f8                	mov    %edi,%eax
80104fbe:	5b                   	pop    %ebx
80104fbf:	5e                   	pop    %esi
80104fc0:	5f                   	pop    %edi
80104fc1:	5d                   	pop    %ebp
80104fc2:	c3                   	ret    
80104fc3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fc7:	90                   	nop
  r = lk->locked && (lk->pid == myproc()->pid);
80104fc8:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104fcb:	e8 f0 e9 ff ff       	call   801039c0 <myproc>
80104fd0:	39 58 10             	cmp    %ebx,0x10(%eax)
80104fd3:	0f 94 c0             	sete   %al
80104fd6:	0f b6 c0             	movzbl %al,%eax
80104fd9:	89 c7                	mov    %eax,%edi
80104fdb:	eb d3                	jmp    80104fb0 <holdingsleep+0x20>
80104fdd:	66 90                	xchg   %ax,%ax
80104fdf:	90                   	nop

80104fe0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104fe0:	55                   	push   %ebp
80104fe1:	89 e5                	mov    %esp,%ebp
80104fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104fe6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104fe9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104fef:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104ff2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104ff9:	5d                   	pop    %ebp
80104ffa:	c3                   	ret    
80104ffb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fff:	90                   	nop

80105000 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105000:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105001:	31 d2                	xor    %edx,%edx
{
80105003:	89 e5                	mov    %esp,%ebp
80105005:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80105006:	8b 45 08             	mov    0x8(%ebp),%eax
{
80105009:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010500c:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
8010500f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105010:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105016:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010501c:	77 1a                	ja     80105038 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010501e:	8b 58 04             	mov    0x4(%eax),%ebx
80105021:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80105024:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105027:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105029:	83 fa 0a             	cmp    $0xa,%edx
8010502c:	75 e2                	jne    80105010 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010502e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105031:	c9                   	leave  
80105032:	c3                   	ret    
80105033:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105037:	90                   	nop
  for(; i < 10; i++)
80105038:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010503b:	8d 51 28             	lea    0x28(%ecx),%edx
8010503e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105040:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105046:	83 c0 04             	add    $0x4,%eax
80105049:	39 d0                	cmp    %edx,%eax
8010504b:	75 f3                	jne    80105040 <getcallerpcs+0x40>
}
8010504d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105050:	c9                   	leave  
80105051:	c3                   	ret    
80105052:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105060 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105060:	55                   	push   %ebp
80105061:	89 e5                	mov    %esp,%ebp
80105063:	53                   	push   %ebx
80105064:	83 ec 04             	sub    $0x4,%esp
80105067:	9c                   	pushf  
80105068:	5b                   	pop    %ebx
  asm volatile("cli");
80105069:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010506a:	e8 d1 e8 ff ff       	call   80103940 <mycpu>
8010506f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105075:	85 c0                	test   %eax,%eax
80105077:	74 17                	je     80105090 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80105079:	e8 c2 e8 ff ff       	call   80103940 <mycpu>
8010507e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80105085:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105088:	c9                   	leave  
80105089:	c3                   	ret    
8010508a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80105090:	e8 ab e8 ff ff       	call   80103940 <mycpu>
80105095:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010509b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
801050a1:	eb d6                	jmp    80105079 <pushcli+0x19>
801050a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801050b0 <popcli>:

void
popcli(void)
{
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801050b6:	9c                   	pushf  
801050b7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801050b8:	f6 c4 02             	test   $0x2,%ah
801050bb:	75 35                	jne    801050f2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801050bd:	e8 7e e8 ff ff       	call   80103940 <mycpu>
801050c2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801050c9:	78 34                	js     801050ff <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801050cb:	e8 70 e8 ff ff       	call   80103940 <mycpu>
801050d0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801050d6:	85 d2                	test   %edx,%edx
801050d8:	74 06                	je     801050e0 <popcli+0x30>
    sti();
}
801050da:	c9                   	leave  
801050db:	c3                   	ret    
801050dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801050e0:	e8 5b e8 ff ff       	call   80103940 <mycpu>
801050e5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801050eb:	85 c0                	test   %eax,%eax
801050ed:	74 eb                	je     801050da <popcli+0x2a>
  asm volatile("sti");
801050ef:	fb                   	sti    
}
801050f0:	c9                   	leave  
801050f1:	c3                   	ret    
    panic("popcli - interruptible");
801050f2:	83 ec 0c             	sub    $0xc,%esp
801050f5:	68 d7 87 10 80       	push   $0x801087d7
801050fa:	e8 81 b2 ff ff       	call   80100380 <panic>
    panic("popcli");
801050ff:	83 ec 0c             	sub    $0xc,%esp
80105102:	68 ee 87 10 80       	push   $0x801087ee
80105107:	e8 74 b2 ff ff       	call   80100380 <panic>
8010510c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105110 <holding>:
{
80105110:	55                   	push   %ebp
80105111:	89 e5                	mov    %esp,%ebp
80105113:	56                   	push   %esi
80105114:	53                   	push   %ebx
80105115:	8b 75 08             	mov    0x8(%ebp),%esi
80105118:	31 db                	xor    %ebx,%ebx
  pushcli();
8010511a:	e8 41 ff ff ff       	call   80105060 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010511f:	8b 06                	mov    (%esi),%eax
80105121:	85 c0                	test   %eax,%eax
80105123:	75 0b                	jne    80105130 <holding+0x20>
  popcli();
80105125:	e8 86 ff ff ff       	call   801050b0 <popcli>
}
8010512a:	89 d8                	mov    %ebx,%eax
8010512c:	5b                   	pop    %ebx
8010512d:	5e                   	pop    %esi
8010512e:	5d                   	pop    %ebp
8010512f:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
80105130:	8b 5e 08             	mov    0x8(%esi),%ebx
80105133:	e8 08 e8 ff ff       	call   80103940 <mycpu>
80105138:	39 c3                	cmp    %eax,%ebx
8010513a:	0f 94 c3             	sete   %bl
  popcli();
8010513d:	e8 6e ff ff ff       	call   801050b0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80105142:	0f b6 db             	movzbl %bl,%ebx
}
80105145:	89 d8                	mov    %ebx,%eax
80105147:	5b                   	pop    %ebx
80105148:	5e                   	pop    %esi
80105149:	5d                   	pop    %ebp
8010514a:	c3                   	ret    
8010514b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010514f:	90                   	nop

80105150 <release>:
{
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	56                   	push   %esi
80105154:	53                   	push   %ebx
80105155:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80105158:	e8 03 ff ff ff       	call   80105060 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010515d:	8b 03                	mov    (%ebx),%eax
8010515f:	85 c0                	test   %eax,%eax
80105161:	75 15                	jne    80105178 <release+0x28>
  popcli();
80105163:	e8 48 ff ff ff       	call   801050b0 <popcli>
    panic("release");
80105168:	83 ec 0c             	sub    $0xc,%esp
8010516b:	68 f5 87 10 80       	push   $0x801087f5
80105170:	e8 0b b2 ff ff       	call   80100380 <panic>
80105175:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80105178:	8b 73 08             	mov    0x8(%ebx),%esi
8010517b:	e8 c0 e7 ff ff       	call   80103940 <mycpu>
80105180:	39 c6                	cmp    %eax,%esi
80105182:	75 df                	jne    80105163 <release+0x13>
  popcli();
80105184:	e8 27 ff ff ff       	call   801050b0 <popcli>
  lk->pcs[0] = 0;
80105189:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105190:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105197:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010519c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801051a2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801051a5:	5b                   	pop    %ebx
801051a6:	5e                   	pop    %esi
801051a7:	5d                   	pop    %ebp
  popcli();
801051a8:	e9 03 ff ff ff       	jmp    801050b0 <popcli>
801051ad:	8d 76 00             	lea    0x0(%esi),%esi

801051b0 <acquire>:
{
801051b0:	55                   	push   %ebp
801051b1:	89 e5                	mov    %esp,%ebp
801051b3:	53                   	push   %ebx
801051b4:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801051b7:	e8 a4 fe ff ff       	call   80105060 <pushcli>
  if(holding(lk))
801051bc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801051bf:	e8 9c fe ff ff       	call   80105060 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801051c4:	8b 03                	mov    (%ebx),%eax
801051c6:	85 c0                	test   %eax,%eax
801051c8:	75 7e                	jne    80105248 <acquire+0x98>
  popcli();
801051ca:	e8 e1 fe ff ff       	call   801050b0 <popcli>
  asm volatile("lock; xchgl %0, %1" :
801051cf:	b9 01 00 00 00       	mov    $0x1,%ecx
801051d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(xchg(&lk->locked, 1) != 0)
801051d8:	8b 55 08             	mov    0x8(%ebp),%edx
801051db:	89 c8                	mov    %ecx,%eax
801051dd:	f0 87 02             	lock xchg %eax,(%edx)
801051e0:	85 c0                	test   %eax,%eax
801051e2:	75 f4                	jne    801051d8 <acquire+0x28>
  __sync_synchronize();
801051e4:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801051e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801051ec:	e8 4f e7 ff ff       	call   80103940 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801051f1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
801051f4:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
801051f6:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
801051f9:	31 c0                	xor    %eax,%eax
801051fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051ff:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105200:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80105206:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010520c:	77 1a                	ja     80105228 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
8010520e:	8b 5a 04             	mov    0x4(%edx),%ebx
80105211:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80105215:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80105218:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
8010521a:	83 f8 0a             	cmp    $0xa,%eax
8010521d:	75 e1                	jne    80105200 <acquire+0x50>
}
8010521f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105222:	c9                   	leave  
80105223:	c3                   	ret    
80105224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80105228:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
8010522c:	8d 51 34             	lea    0x34(%ecx),%edx
8010522f:	90                   	nop
    pcs[i] = 0;
80105230:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105236:	83 c0 04             	add    $0x4,%eax
80105239:	39 c2                	cmp    %eax,%edx
8010523b:	75 f3                	jne    80105230 <acquire+0x80>
}
8010523d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105240:	c9                   	leave  
80105241:	c3                   	ret    
80105242:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80105248:	8b 5b 08             	mov    0x8(%ebx),%ebx
8010524b:	e8 f0 e6 ff ff       	call   80103940 <mycpu>
80105250:	39 c3                	cmp    %eax,%ebx
80105252:	0f 85 72 ff ff ff    	jne    801051ca <acquire+0x1a>
  popcli();
80105258:	e8 53 fe ff ff       	call   801050b0 <popcli>
    panic("acquire");
8010525d:	83 ec 0c             	sub    $0xc,%esp
80105260:	68 fd 87 10 80       	push   $0x801087fd
80105265:	e8 16 b1 ff ff       	call   80100380 <panic>
8010526a:	66 90                	xchg   %ax,%ax
8010526c:	66 90                	xchg   %ax,%ax
8010526e:	66 90                	xchg   %ax,%ax

80105270 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105270:	55                   	push   %ebp
80105271:	89 e5                	mov    %esp,%ebp
80105273:	57                   	push   %edi
80105274:	8b 55 08             	mov    0x8(%ebp),%edx
80105277:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010527a:	53                   	push   %ebx
8010527b:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
8010527e:	89 d7                	mov    %edx,%edi
80105280:	09 cf                	or     %ecx,%edi
80105282:	83 e7 03             	and    $0x3,%edi
80105285:	75 29                	jne    801052b0 <memset+0x40>
    c &= 0xFF;
80105287:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010528a:	c1 e0 18             	shl    $0x18,%eax
8010528d:	89 fb                	mov    %edi,%ebx
8010528f:	c1 e9 02             	shr    $0x2,%ecx
80105292:	c1 e3 10             	shl    $0x10,%ebx
80105295:	09 d8                	or     %ebx,%eax
80105297:	09 f8                	or     %edi,%eax
80105299:	c1 e7 08             	shl    $0x8,%edi
8010529c:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
8010529e:	89 d7                	mov    %edx,%edi
801052a0:	fc                   	cld    
801052a1:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
801052a3:	5b                   	pop    %ebx
801052a4:	89 d0                	mov    %edx,%eax
801052a6:	5f                   	pop    %edi
801052a7:	5d                   	pop    %ebp
801052a8:	c3                   	ret    
801052a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
801052b0:	89 d7                	mov    %edx,%edi
801052b2:	fc                   	cld    
801052b3:	f3 aa                	rep stos %al,%es:(%edi)
801052b5:	5b                   	pop    %ebx
801052b6:	89 d0                	mov    %edx,%eax
801052b8:	5f                   	pop    %edi
801052b9:	5d                   	pop    %ebp
801052ba:	c3                   	ret    
801052bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801052bf:	90                   	nop

801052c0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801052c0:	55                   	push   %ebp
801052c1:	89 e5                	mov    %esp,%ebp
801052c3:	56                   	push   %esi
801052c4:	8b 75 10             	mov    0x10(%ebp),%esi
801052c7:	8b 55 08             	mov    0x8(%ebp),%edx
801052ca:	53                   	push   %ebx
801052cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801052ce:	85 f6                	test   %esi,%esi
801052d0:	74 2e                	je     80105300 <memcmp+0x40>
801052d2:	01 c6                	add    %eax,%esi
801052d4:	eb 14                	jmp    801052ea <memcmp+0x2a>
801052d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052dd:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
801052e0:	83 c0 01             	add    $0x1,%eax
801052e3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
801052e6:	39 f0                	cmp    %esi,%eax
801052e8:	74 16                	je     80105300 <memcmp+0x40>
    if(*s1 != *s2)
801052ea:	0f b6 0a             	movzbl (%edx),%ecx
801052ed:	0f b6 18             	movzbl (%eax),%ebx
801052f0:	38 d9                	cmp    %bl,%cl
801052f2:	74 ec                	je     801052e0 <memcmp+0x20>
      return *s1 - *s2;
801052f4:	0f b6 c1             	movzbl %cl,%eax
801052f7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
801052f9:	5b                   	pop    %ebx
801052fa:	5e                   	pop    %esi
801052fb:	5d                   	pop    %ebp
801052fc:	c3                   	ret    
801052fd:	8d 76 00             	lea    0x0(%esi),%esi
80105300:	5b                   	pop    %ebx
  return 0;
80105301:	31 c0                	xor    %eax,%eax
}
80105303:	5e                   	pop    %esi
80105304:	5d                   	pop    %ebp
80105305:	c3                   	ret    
80105306:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010530d:	8d 76 00             	lea    0x0(%esi),%esi

80105310 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105310:	55                   	push   %ebp
80105311:	89 e5                	mov    %esp,%ebp
80105313:	57                   	push   %edi
80105314:	8b 55 08             	mov    0x8(%ebp),%edx
80105317:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010531a:	56                   	push   %esi
8010531b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010531e:	39 d6                	cmp    %edx,%esi
80105320:	73 26                	jae    80105348 <memmove+0x38>
80105322:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80105325:	39 fa                	cmp    %edi,%edx
80105327:	73 1f                	jae    80105348 <memmove+0x38>
80105329:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
8010532c:	85 c9                	test   %ecx,%ecx
8010532e:	74 0c                	je     8010533c <memmove+0x2c>
      *--d = *--s;
80105330:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80105334:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80105337:	83 e8 01             	sub    $0x1,%eax
8010533a:	73 f4                	jae    80105330 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010533c:	5e                   	pop    %esi
8010533d:	89 d0                	mov    %edx,%eax
8010533f:	5f                   	pop    %edi
80105340:	5d                   	pop    %ebp
80105341:	c3                   	ret    
80105342:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80105348:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
8010534b:	89 d7                	mov    %edx,%edi
8010534d:	85 c9                	test   %ecx,%ecx
8010534f:	74 eb                	je     8010533c <memmove+0x2c>
80105351:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80105358:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80105359:	39 c6                	cmp    %eax,%esi
8010535b:	75 fb                	jne    80105358 <memmove+0x48>
}
8010535d:	5e                   	pop    %esi
8010535e:	89 d0                	mov    %edx,%eax
80105360:	5f                   	pop    %edi
80105361:	5d                   	pop    %ebp
80105362:	c3                   	ret    
80105363:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010536a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105370 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80105370:	eb 9e                	jmp    80105310 <memmove>
80105372:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105380 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	56                   	push   %esi
80105384:	8b 75 10             	mov    0x10(%ebp),%esi
80105387:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010538a:	53                   	push   %ebx
8010538b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(n > 0 && *p && *p == *q)
8010538e:	85 f6                	test   %esi,%esi
80105390:	74 2e                	je     801053c0 <strncmp+0x40>
80105392:	01 d6                	add    %edx,%esi
80105394:	eb 18                	jmp    801053ae <strncmp+0x2e>
80105396:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010539d:	8d 76 00             	lea    0x0(%esi),%esi
801053a0:	38 d8                	cmp    %bl,%al
801053a2:	75 14                	jne    801053b8 <strncmp+0x38>
    n--, p++, q++;
801053a4:	83 c2 01             	add    $0x1,%edx
801053a7:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801053aa:	39 f2                	cmp    %esi,%edx
801053ac:	74 12                	je     801053c0 <strncmp+0x40>
801053ae:	0f b6 01             	movzbl (%ecx),%eax
801053b1:	0f b6 1a             	movzbl (%edx),%ebx
801053b4:	84 c0                	test   %al,%al
801053b6:	75 e8                	jne    801053a0 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801053b8:	29 d8                	sub    %ebx,%eax
}
801053ba:	5b                   	pop    %ebx
801053bb:	5e                   	pop    %esi
801053bc:	5d                   	pop    %ebp
801053bd:	c3                   	ret    
801053be:	66 90                	xchg   %ax,%ax
801053c0:	5b                   	pop    %ebx
    return 0;
801053c1:	31 c0                	xor    %eax,%eax
}
801053c3:	5e                   	pop    %esi
801053c4:	5d                   	pop    %ebp
801053c5:	c3                   	ret    
801053c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801053cd:	8d 76 00             	lea    0x0(%esi),%esi

801053d0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801053d0:	55                   	push   %ebp
801053d1:	89 e5                	mov    %esp,%ebp
801053d3:	57                   	push   %edi
801053d4:	56                   	push   %esi
801053d5:	8b 75 08             	mov    0x8(%ebp),%esi
801053d8:	53                   	push   %ebx
801053d9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801053dc:	89 f0                	mov    %esi,%eax
801053de:	eb 15                	jmp    801053f5 <strncpy+0x25>
801053e0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
801053e4:	8b 7d 0c             	mov    0xc(%ebp),%edi
801053e7:	83 c0 01             	add    $0x1,%eax
801053ea:	0f b6 57 ff          	movzbl -0x1(%edi),%edx
801053ee:	88 50 ff             	mov    %dl,-0x1(%eax)
801053f1:	84 d2                	test   %dl,%dl
801053f3:	74 09                	je     801053fe <strncpy+0x2e>
801053f5:	89 cb                	mov    %ecx,%ebx
801053f7:	83 e9 01             	sub    $0x1,%ecx
801053fa:	85 db                	test   %ebx,%ebx
801053fc:	7f e2                	jg     801053e0 <strncpy+0x10>
    ;
  while(n-- > 0)
801053fe:	89 c2                	mov    %eax,%edx
80105400:	85 c9                	test   %ecx,%ecx
80105402:	7e 17                	jle    8010541b <strncpy+0x4b>
80105404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80105408:	83 c2 01             	add    $0x1,%edx
8010540b:	89 c1                	mov    %eax,%ecx
8010540d:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
  while(n-- > 0)
80105411:	29 d1                	sub    %edx,%ecx
80105413:	8d 4c 0b ff          	lea    -0x1(%ebx,%ecx,1),%ecx
80105417:	85 c9                	test   %ecx,%ecx
80105419:	7f ed                	jg     80105408 <strncpy+0x38>
  return os;
}
8010541b:	5b                   	pop    %ebx
8010541c:	89 f0                	mov    %esi,%eax
8010541e:	5e                   	pop    %esi
8010541f:	5f                   	pop    %edi
80105420:	5d                   	pop    %ebp
80105421:	c3                   	ret    
80105422:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105430 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105430:	55                   	push   %ebp
80105431:	89 e5                	mov    %esp,%ebp
80105433:	56                   	push   %esi
80105434:	8b 55 10             	mov    0x10(%ebp),%edx
80105437:	8b 75 08             	mov    0x8(%ebp),%esi
8010543a:	53                   	push   %ebx
8010543b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
8010543e:	85 d2                	test   %edx,%edx
80105440:	7e 25                	jle    80105467 <safestrcpy+0x37>
80105442:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80105446:	89 f2                	mov    %esi,%edx
80105448:	eb 16                	jmp    80105460 <safestrcpy+0x30>
8010544a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105450:	0f b6 08             	movzbl (%eax),%ecx
80105453:	83 c0 01             	add    $0x1,%eax
80105456:	83 c2 01             	add    $0x1,%edx
80105459:	88 4a ff             	mov    %cl,-0x1(%edx)
8010545c:	84 c9                	test   %cl,%cl
8010545e:	74 04                	je     80105464 <safestrcpy+0x34>
80105460:	39 d8                	cmp    %ebx,%eax
80105462:	75 ec                	jne    80105450 <safestrcpy+0x20>
    ;
  *s = 0;
80105464:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80105467:	89 f0                	mov    %esi,%eax
80105469:	5b                   	pop    %ebx
8010546a:	5e                   	pop    %esi
8010546b:	5d                   	pop    %ebp
8010546c:	c3                   	ret    
8010546d:	8d 76 00             	lea    0x0(%esi),%esi

80105470 <strlen>:

int
strlen(const char *s)
{
80105470:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105471:	31 c0                	xor    %eax,%eax
{
80105473:	89 e5                	mov    %esp,%ebp
80105475:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105478:	80 3a 00             	cmpb   $0x0,(%edx)
8010547b:	74 0c                	je     80105489 <strlen+0x19>
8010547d:	8d 76 00             	lea    0x0(%esi),%esi
80105480:	83 c0 01             	add    $0x1,%eax
80105483:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105487:	75 f7                	jne    80105480 <strlen+0x10>
    ;
  return n;
}
80105489:	5d                   	pop    %ebp
8010548a:	c3                   	ret    

8010548b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010548b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010548f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80105493:	55                   	push   %ebp
  pushl %ebx
80105494:	53                   	push   %ebx
  pushl %esi
80105495:	56                   	push   %esi
  pushl %edi
80105496:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105497:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105499:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010549b:	5f                   	pop    %edi
  popl %esi
8010549c:	5e                   	pop    %esi
  popl %ebx
8010549d:	5b                   	pop    %ebx
  popl %ebp
8010549e:	5d                   	pop    %ebp
  ret
8010549f:	c3                   	ret    

801054a0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801054a0:	55                   	push   %ebp
801054a1:	89 e5                	mov    %esp,%ebp
801054a3:	53                   	push   %ebx
801054a4:	83 ec 04             	sub    $0x4,%esp
801054a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801054aa:	e8 11 e5 ff ff       	call   801039c0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801054af:	8b 00                	mov    (%eax),%eax
801054b1:	39 d8                	cmp    %ebx,%eax
801054b3:	76 1b                	jbe    801054d0 <fetchint+0x30>
801054b5:	8d 53 04             	lea    0x4(%ebx),%edx
801054b8:	39 d0                	cmp    %edx,%eax
801054ba:	72 14                	jb     801054d0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801054bc:	8b 45 0c             	mov    0xc(%ebp),%eax
801054bf:	8b 13                	mov    (%ebx),%edx
801054c1:	89 10                	mov    %edx,(%eax)
  return 0;
801054c3:	31 c0                	xor    %eax,%eax
}
801054c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801054c8:	c9                   	leave  
801054c9:	c3                   	ret    
801054ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801054d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054d5:	eb ee                	jmp    801054c5 <fetchint+0x25>
801054d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054de:	66 90                	xchg   %ax,%ax

801054e0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801054e0:	55                   	push   %ebp
801054e1:	89 e5                	mov    %esp,%ebp
801054e3:	53                   	push   %ebx
801054e4:	83 ec 04             	sub    $0x4,%esp
801054e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801054ea:	e8 d1 e4 ff ff       	call   801039c0 <myproc>

  if(addr >= curproc->sz)
801054ef:	39 18                	cmp    %ebx,(%eax)
801054f1:	76 2d                	jbe    80105520 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
801054f3:	8b 55 0c             	mov    0xc(%ebp),%edx
801054f6:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801054f8:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801054fa:	39 d3                	cmp    %edx,%ebx
801054fc:	73 22                	jae    80105520 <fetchstr+0x40>
801054fe:	89 d8                	mov    %ebx,%eax
80105500:	eb 0d                	jmp    8010550f <fetchstr+0x2f>
80105502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105508:	83 c0 01             	add    $0x1,%eax
8010550b:	39 c2                	cmp    %eax,%edx
8010550d:	76 11                	jbe    80105520 <fetchstr+0x40>
    if(*s == 0)
8010550f:	80 38 00             	cmpb   $0x0,(%eax)
80105512:	75 f4                	jne    80105508 <fetchstr+0x28>
      return s - *pp;
80105514:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80105516:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105519:	c9                   	leave  
8010551a:	c3                   	ret    
8010551b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010551f:	90                   	nop
80105520:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80105523:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105528:	c9                   	leave  
80105529:	c3                   	ret    
8010552a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105530 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105530:	55                   	push   %ebp
80105531:	89 e5                	mov    %esp,%ebp
80105533:	56                   	push   %esi
80105534:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105535:	e8 86 e4 ff ff       	call   801039c0 <myproc>
8010553a:	8b 55 08             	mov    0x8(%ebp),%edx
8010553d:	8b 40 18             	mov    0x18(%eax),%eax
80105540:	8b 40 44             	mov    0x44(%eax),%eax
80105543:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105546:	e8 75 e4 ff ff       	call   801039c0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010554b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010554e:	8b 00                	mov    (%eax),%eax
80105550:	39 c6                	cmp    %eax,%esi
80105552:	73 1c                	jae    80105570 <argint+0x40>
80105554:	8d 53 08             	lea    0x8(%ebx),%edx
80105557:	39 d0                	cmp    %edx,%eax
80105559:	72 15                	jb     80105570 <argint+0x40>
  *ip = *(int*)(addr);
8010555b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010555e:	8b 53 04             	mov    0x4(%ebx),%edx
80105561:	89 10                	mov    %edx,(%eax)
  return 0;
80105563:	31 c0                	xor    %eax,%eax
}
80105565:	5b                   	pop    %ebx
80105566:	5e                   	pop    %esi
80105567:	5d                   	pop    %ebp
80105568:	c3                   	ret    
80105569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105570:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105575:	eb ee                	jmp    80105565 <argint+0x35>
80105577:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010557e:	66 90                	xchg   %ax,%ax

80105580 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105580:	55                   	push   %ebp
80105581:	89 e5                	mov    %esp,%ebp
80105583:	57                   	push   %edi
80105584:	56                   	push   %esi
80105585:	53                   	push   %ebx
80105586:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80105589:	e8 32 e4 ff ff       	call   801039c0 <myproc>
8010558e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105590:	e8 2b e4 ff ff       	call   801039c0 <myproc>
80105595:	8b 55 08             	mov    0x8(%ebp),%edx
80105598:	8b 40 18             	mov    0x18(%eax),%eax
8010559b:	8b 40 44             	mov    0x44(%eax),%eax
8010559e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801055a1:	e8 1a e4 ff ff       	call   801039c0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801055a6:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801055a9:	8b 00                	mov    (%eax),%eax
801055ab:	39 c7                	cmp    %eax,%edi
801055ad:	73 31                	jae    801055e0 <argptr+0x60>
801055af:	8d 4b 08             	lea    0x8(%ebx),%ecx
801055b2:	39 c8                	cmp    %ecx,%eax
801055b4:	72 2a                	jb     801055e0 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801055b6:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
801055b9:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801055bc:	85 d2                	test   %edx,%edx
801055be:	78 20                	js     801055e0 <argptr+0x60>
801055c0:	8b 16                	mov    (%esi),%edx
801055c2:	39 c2                	cmp    %eax,%edx
801055c4:	76 1a                	jbe    801055e0 <argptr+0x60>
801055c6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801055c9:	01 c3                	add    %eax,%ebx
801055cb:	39 da                	cmp    %ebx,%edx
801055cd:	72 11                	jb     801055e0 <argptr+0x60>
    return -1;
  *pp = (char*)i;
801055cf:	8b 55 0c             	mov    0xc(%ebp),%edx
801055d2:	89 02                	mov    %eax,(%edx)
  return 0;
801055d4:	31 c0                	xor    %eax,%eax
}
801055d6:	83 c4 0c             	add    $0xc,%esp
801055d9:	5b                   	pop    %ebx
801055da:	5e                   	pop    %esi
801055db:	5f                   	pop    %edi
801055dc:	5d                   	pop    %ebp
801055dd:	c3                   	ret    
801055de:	66 90                	xchg   %ax,%ax
    return -1;
801055e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055e5:	eb ef                	jmp    801055d6 <argptr+0x56>
801055e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055ee:	66 90                	xchg   %ax,%ax

801055f0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801055f0:	55                   	push   %ebp
801055f1:	89 e5                	mov    %esp,%ebp
801055f3:	56                   	push   %esi
801055f4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801055f5:	e8 c6 e3 ff ff       	call   801039c0 <myproc>
801055fa:	8b 55 08             	mov    0x8(%ebp),%edx
801055fd:	8b 40 18             	mov    0x18(%eax),%eax
80105600:	8b 40 44             	mov    0x44(%eax),%eax
80105603:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105606:	e8 b5 e3 ff ff       	call   801039c0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010560b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010560e:	8b 00                	mov    (%eax),%eax
80105610:	39 c6                	cmp    %eax,%esi
80105612:	73 44                	jae    80105658 <argstr+0x68>
80105614:	8d 53 08             	lea    0x8(%ebx),%edx
80105617:	39 d0                	cmp    %edx,%eax
80105619:	72 3d                	jb     80105658 <argstr+0x68>
  *ip = *(int*)(addr);
8010561b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
8010561e:	e8 9d e3 ff ff       	call   801039c0 <myproc>
  if(addr >= curproc->sz)
80105623:	3b 18                	cmp    (%eax),%ebx
80105625:	73 31                	jae    80105658 <argstr+0x68>
  *pp = (char*)addr;
80105627:	8b 55 0c             	mov    0xc(%ebp),%edx
8010562a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
8010562c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010562e:	39 d3                	cmp    %edx,%ebx
80105630:	73 26                	jae    80105658 <argstr+0x68>
80105632:	89 d8                	mov    %ebx,%eax
80105634:	eb 11                	jmp    80105647 <argstr+0x57>
80105636:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010563d:	8d 76 00             	lea    0x0(%esi),%esi
80105640:	83 c0 01             	add    $0x1,%eax
80105643:	39 c2                	cmp    %eax,%edx
80105645:	76 11                	jbe    80105658 <argstr+0x68>
    if(*s == 0)
80105647:	80 38 00             	cmpb   $0x0,(%eax)
8010564a:	75 f4                	jne    80105640 <argstr+0x50>
      return s - *pp;
8010564c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
8010564e:	5b                   	pop    %ebx
8010564f:	5e                   	pop    %esi
80105650:	5d                   	pop    %ebp
80105651:	c3                   	ret    
80105652:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105658:	5b                   	pop    %ebx
    return -1;
80105659:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010565e:	5e                   	pop    %esi
8010565f:	5d                   	pop    %ebp
80105660:	c3                   	ret    
80105661:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105668:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010566f:	90                   	nop

80105670 <syscall>:
[SYS_sem_release] sys_sem_release
};

void
syscall(void)
{
80105670:	55                   	push   %ebp
80105671:	89 e5                	mov    %esp,%ebp
80105673:	53                   	push   %ebx
80105674:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80105677:	e8 44 e3 ff ff       	call   801039c0 <myproc>
8010567c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010567e:	8b 40 18             	mov    0x18(%eax),%eax
80105681:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105684:	8d 50 ff             	lea    -0x1(%eax),%edx
80105687:	83 fa 1f             	cmp    $0x1f,%edx
8010568a:	77 24                	ja     801056b0 <syscall+0x40>
8010568c:	8b 14 85 40 88 10 80 	mov    -0x7fef77c0(,%eax,4),%edx
80105693:	85 d2                	test   %edx,%edx
80105695:	74 19                	je     801056b0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80105697:	ff d2                	call   *%edx
80105699:	89 c2                	mov    %eax,%edx
8010569b:	8b 43 18             	mov    0x18(%ebx),%eax
8010569e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801056a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056a4:	c9                   	leave  
801056a5:	c3                   	ret    
801056a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056ad:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
801056b0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
801056b1:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
801056b4:	50                   	push   %eax
801056b5:	ff 73 10             	push   0x10(%ebx)
801056b8:	68 05 88 10 80       	push   $0x80108805
801056bd:	e8 de af ff ff       	call   801006a0 <cprintf>
    curproc->tf->eax = -1;
801056c2:	8b 43 18             	mov    0x18(%ebx),%eax
801056c5:	83 c4 10             	add    $0x10,%esp
801056c8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801056cf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056d2:	c9                   	leave  
801056d3:	c3                   	ret    
801056d4:	66 90                	xchg   %ax,%ax
801056d6:	66 90                	xchg   %ax,%ax
801056d8:	66 90                	xchg   %ax,%ax
801056da:	66 90                	xchg   %ax,%ax
801056dc:	66 90                	xchg   %ax,%ax
801056de:	66 90                	xchg   %ax,%ax

801056e0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
801056e3:	57                   	push   %edi
801056e4:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801056e5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
801056e8:	53                   	push   %ebx
801056e9:	83 ec 34             	sub    $0x34,%esp
801056ec:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801056ef:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
801056f2:	57                   	push   %edi
801056f3:	50                   	push   %eax
{
801056f4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801056f7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801056fa:	e8 d1 c9 ff ff       	call   801020d0 <nameiparent>
801056ff:	83 c4 10             	add    $0x10,%esp
80105702:	85 c0                	test   %eax,%eax
80105704:	0f 84 46 01 00 00    	je     80105850 <create+0x170>
    return 0;
  ilock(dp);
8010570a:	83 ec 0c             	sub    $0xc,%esp
8010570d:	89 c3                	mov    %eax,%ebx
8010570f:	50                   	push   %eax
80105710:	e8 7b c0 ff ff       	call   80101790 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80105715:	83 c4 0c             	add    $0xc,%esp
80105718:	6a 00                	push   $0x0
8010571a:	57                   	push   %edi
8010571b:	53                   	push   %ebx
8010571c:	e8 cf c5 ff ff       	call   80101cf0 <dirlookup>
80105721:	83 c4 10             	add    $0x10,%esp
80105724:	89 c6                	mov    %eax,%esi
80105726:	85 c0                	test   %eax,%eax
80105728:	74 56                	je     80105780 <create+0xa0>
    iunlockput(dp);
8010572a:	83 ec 0c             	sub    $0xc,%esp
8010572d:	53                   	push   %ebx
8010572e:	e8 ed c2 ff ff       	call   80101a20 <iunlockput>
    ilock(ip);
80105733:	89 34 24             	mov    %esi,(%esp)
80105736:	e8 55 c0 ff ff       	call   80101790 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010573b:	83 c4 10             	add    $0x10,%esp
8010573e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105743:	75 1b                	jne    80105760 <create+0x80>
80105745:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010574a:	75 14                	jne    80105760 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010574c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010574f:	89 f0                	mov    %esi,%eax
80105751:	5b                   	pop    %ebx
80105752:	5e                   	pop    %esi
80105753:	5f                   	pop    %edi
80105754:	5d                   	pop    %ebp
80105755:	c3                   	ret    
80105756:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010575d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105760:	83 ec 0c             	sub    $0xc,%esp
80105763:	56                   	push   %esi
    return 0;
80105764:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80105766:	e8 b5 c2 ff ff       	call   80101a20 <iunlockput>
    return 0;
8010576b:	83 c4 10             	add    $0x10,%esp
}
8010576e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105771:	89 f0                	mov    %esi,%eax
80105773:	5b                   	pop    %ebx
80105774:	5e                   	pop    %esi
80105775:	5f                   	pop    %edi
80105776:	5d                   	pop    %ebp
80105777:	c3                   	ret    
80105778:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010577f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80105780:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105784:	83 ec 08             	sub    $0x8,%esp
80105787:	50                   	push   %eax
80105788:	ff 33                	push   (%ebx)
8010578a:	e8 91 be ff ff       	call   80101620 <ialloc>
8010578f:	83 c4 10             	add    $0x10,%esp
80105792:	89 c6                	mov    %eax,%esi
80105794:	85 c0                	test   %eax,%eax
80105796:	0f 84 cd 00 00 00    	je     80105869 <create+0x189>
  ilock(ip);
8010579c:	83 ec 0c             	sub    $0xc,%esp
8010579f:	50                   	push   %eax
801057a0:	e8 eb bf ff ff       	call   80101790 <ilock>
  ip->major = major;
801057a5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
801057a9:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
801057ad:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
801057b1:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
801057b5:	b8 01 00 00 00       	mov    $0x1,%eax
801057ba:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
801057be:	89 34 24             	mov    %esi,(%esp)
801057c1:	e8 1a bf ff ff       	call   801016e0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801057c6:	83 c4 10             	add    $0x10,%esp
801057c9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801057ce:	74 30                	je     80105800 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
801057d0:	83 ec 04             	sub    $0x4,%esp
801057d3:	ff 76 04             	push   0x4(%esi)
801057d6:	57                   	push   %edi
801057d7:	53                   	push   %ebx
801057d8:	e8 13 c8 ff ff       	call   80101ff0 <dirlink>
801057dd:	83 c4 10             	add    $0x10,%esp
801057e0:	85 c0                	test   %eax,%eax
801057e2:	78 78                	js     8010585c <create+0x17c>
  iunlockput(dp);
801057e4:	83 ec 0c             	sub    $0xc,%esp
801057e7:	53                   	push   %ebx
801057e8:	e8 33 c2 ff ff       	call   80101a20 <iunlockput>
  return ip;
801057ed:	83 c4 10             	add    $0x10,%esp
}
801057f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057f3:	89 f0                	mov    %esi,%eax
801057f5:	5b                   	pop    %ebx
801057f6:	5e                   	pop    %esi
801057f7:	5f                   	pop    %edi
801057f8:	5d                   	pop    %ebp
801057f9:	c3                   	ret    
801057fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80105800:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80105803:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105808:	53                   	push   %ebx
80105809:	e8 d2 be ff ff       	call   801016e0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010580e:	83 c4 0c             	add    $0xc,%esp
80105811:	ff 76 04             	push   0x4(%esi)
80105814:	68 e0 88 10 80       	push   $0x801088e0
80105819:	56                   	push   %esi
8010581a:	e8 d1 c7 ff ff       	call   80101ff0 <dirlink>
8010581f:	83 c4 10             	add    $0x10,%esp
80105822:	85 c0                	test   %eax,%eax
80105824:	78 18                	js     8010583e <create+0x15e>
80105826:	83 ec 04             	sub    $0x4,%esp
80105829:	ff 73 04             	push   0x4(%ebx)
8010582c:	68 df 88 10 80       	push   $0x801088df
80105831:	56                   	push   %esi
80105832:	e8 b9 c7 ff ff       	call   80101ff0 <dirlink>
80105837:	83 c4 10             	add    $0x10,%esp
8010583a:	85 c0                	test   %eax,%eax
8010583c:	79 92                	jns    801057d0 <create+0xf0>
      panic("create dots");
8010583e:	83 ec 0c             	sub    $0xc,%esp
80105841:	68 d3 88 10 80       	push   $0x801088d3
80105846:	e8 35 ab ff ff       	call   80100380 <panic>
8010584b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010584f:	90                   	nop
}
80105850:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105853:	31 f6                	xor    %esi,%esi
}
80105855:	5b                   	pop    %ebx
80105856:	89 f0                	mov    %esi,%eax
80105858:	5e                   	pop    %esi
80105859:	5f                   	pop    %edi
8010585a:	5d                   	pop    %ebp
8010585b:	c3                   	ret    
    panic("create: dirlink");
8010585c:	83 ec 0c             	sub    $0xc,%esp
8010585f:	68 e2 88 10 80       	push   $0x801088e2
80105864:	e8 17 ab ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80105869:	83 ec 0c             	sub    $0xc,%esp
8010586c:	68 c4 88 10 80       	push   $0x801088c4
80105871:	e8 0a ab ff ff       	call   80100380 <panic>
80105876:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010587d:	8d 76 00             	lea    0x0(%esi),%esi

80105880 <sys_dup>:
{
80105880:	55                   	push   %ebp
80105881:	89 e5                	mov    %esp,%ebp
80105883:	56                   	push   %esi
80105884:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105885:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105888:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010588b:	50                   	push   %eax
8010588c:	6a 00                	push   $0x0
8010588e:	e8 9d fc ff ff       	call   80105530 <argint>
80105893:	83 c4 10             	add    $0x10,%esp
80105896:	85 c0                	test   %eax,%eax
80105898:	78 36                	js     801058d0 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010589a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010589e:	77 30                	ja     801058d0 <sys_dup+0x50>
801058a0:	e8 1b e1 ff ff       	call   801039c0 <myproc>
801058a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801058a8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801058ac:	85 f6                	test   %esi,%esi
801058ae:	74 20                	je     801058d0 <sys_dup+0x50>
  struct proc *curproc = myproc();
801058b0:	e8 0b e1 ff ff       	call   801039c0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801058b5:	31 db                	xor    %ebx,%ebx
801058b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058be:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
801058c0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801058c4:	85 d2                	test   %edx,%edx
801058c6:	74 18                	je     801058e0 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
801058c8:	83 c3 01             	add    $0x1,%ebx
801058cb:	83 fb 10             	cmp    $0x10,%ebx
801058ce:	75 f0                	jne    801058c0 <sys_dup+0x40>
}
801058d0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
801058d3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801058d8:	89 d8                	mov    %ebx,%eax
801058da:	5b                   	pop    %ebx
801058db:	5e                   	pop    %esi
801058dc:	5d                   	pop    %ebp
801058dd:	c3                   	ret    
801058de:	66 90                	xchg   %ax,%ax
  filedup(f);
801058e0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801058e3:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
801058e7:	56                   	push   %esi
801058e8:	e8 c3 b5 ff ff       	call   80100eb0 <filedup>
  return fd;
801058ed:	83 c4 10             	add    $0x10,%esp
}
801058f0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801058f3:	89 d8                	mov    %ebx,%eax
801058f5:	5b                   	pop    %ebx
801058f6:	5e                   	pop    %esi
801058f7:	5d                   	pop    %ebp
801058f8:	c3                   	ret    
801058f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105900 <sys_read>:
{
80105900:	55                   	push   %ebp
80105901:	89 e5                	mov    %esp,%ebp
80105903:	56                   	push   %esi
80105904:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105905:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105908:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010590b:	53                   	push   %ebx
8010590c:	6a 00                	push   $0x0
8010590e:	e8 1d fc ff ff       	call   80105530 <argint>
80105913:	83 c4 10             	add    $0x10,%esp
80105916:	85 c0                	test   %eax,%eax
80105918:	78 5e                	js     80105978 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010591a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010591e:	77 58                	ja     80105978 <sys_read+0x78>
80105920:	e8 9b e0 ff ff       	call   801039c0 <myproc>
80105925:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105928:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010592c:	85 f6                	test   %esi,%esi
8010592e:	74 48                	je     80105978 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105930:	83 ec 08             	sub    $0x8,%esp
80105933:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105936:	50                   	push   %eax
80105937:	6a 02                	push   $0x2
80105939:	e8 f2 fb ff ff       	call   80105530 <argint>
8010593e:	83 c4 10             	add    $0x10,%esp
80105941:	85 c0                	test   %eax,%eax
80105943:	78 33                	js     80105978 <sys_read+0x78>
80105945:	83 ec 04             	sub    $0x4,%esp
80105948:	ff 75 f0             	push   -0x10(%ebp)
8010594b:	53                   	push   %ebx
8010594c:	6a 01                	push   $0x1
8010594e:	e8 2d fc ff ff       	call   80105580 <argptr>
80105953:	83 c4 10             	add    $0x10,%esp
80105956:	85 c0                	test   %eax,%eax
80105958:	78 1e                	js     80105978 <sys_read+0x78>
  return fileread(f, p, n);
8010595a:	83 ec 04             	sub    $0x4,%esp
8010595d:	ff 75 f0             	push   -0x10(%ebp)
80105960:	ff 75 f4             	push   -0xc(%ebp)
80105963:	56                   	push   %esi
80105964:	e8 c7 b6 ff ff       	call   80101030 <fileread>
80105969:	83 c4 10             	add    $0x10,%esp
}
8010596c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010596f:	5b                   	pop    %ebx
80105970:	5e                   	pop    %esi
80105971:	5d                   	pop    %ebp
80105972:	c3                   	ret    
80105973:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105977:	90                   	nop
    return -1;
80105978:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010597d:	eb ed                	jmp    8010596c <sys_read+0x6c>
8010597f:	90                   	nop

80105980 <sys_write>:
{
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	56                   	push   %esi
80105984:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105985:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105988:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010598b:	53                   	push   %ebx
8010598c:	6a 00                	push   $0x0
8010598e:	e8 9d fb ff ff       	call   80105530 <argint>
80105993:	83 c4 10             	add    $0x10,%esp
80105996:	85 c0                	test   %eax,%eax
80105998:	78 5e                	js     801059f8 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010599a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010599e:	77 58                	ja     801059f8 <sys_write+0x78>
801059a0:	e8 1b e0 ff ff       	call   801039c0 <myproc>
801059a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801059a8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801059ac:	85 f6                	test   %esi,%esi
801059ae:	74 48                	je     801059f8 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801059b0:	83 ec 08             	sub    $0x8,%esp
801059b3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801059b6:	50                   	push   %eax
801059b7:	6a 02                	push   $0x2
801059b9:	e8 72 fb ff ff       	call   80105530 <argint>
801059be:	83 c4 10             	add    $0x10,%esp
801059c1:	85 c0                	test   %eax,%eax
801059c3:	78 33                	js     801059f8 <sys_write+0x78>
801059c5:	83 ec 04             	sub    $0x4,%esp
801059c8:	ff 75 f0             	push   -0x10(%ebp)
801059cb:	53                   	push   %ebx
801059cc:	6a 01                	push   $0x1
801059ce:	e8 ad fb ff ff       	call   80105580 <argptr>
801059d3:	83 c4 10             	add    $0x10,%esp
801059d6:	85 c0                	test   %eax,%eax
801059d8:	78 1e                	js     801059f8 <sys_write+0x78>
  return filewrite(f, p, n);
801059da:	83 ec 04             	sub    $0x4,%esp
801059dd:	ff 75 f0             	push   -0x10(%ebp)
801059e0:	ff 75 f4             	push   -0xc(%ebp)
801059e3:	56                   	push   %esi
801059e4:	e8 d7 b6 ff ff       	call   801010c0 <filewrite>
801059e9:	83 c4 10             	add    $0x10,%esp
}
801059ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
801059ef:	5b                   	pop    %ebx
801059f0:	5e                   	pop    %esi
801059f1:	5d                   	pop    %ebp
801059f2:	c3                   	ret    
801059f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059f7:	90                   	nop
    return -1;
801059f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059fd:	eb ed                	jmp    801059ec <sys_write+0x6c>
801059ff:	90                   	nop

80105a00 <sys_close>:
{
80105a00:	55                   	push   %ebp
80105a01:	89 e5                	mov    %esp,%ebp
80105a03:	56                   	push   %esi
80105a04:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105a05:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105a08:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105a0b:	50                   	push   %eax
80105a0c:	6a 00                	push   $0x0
80105a0e:	e8 1d fb ff ff       	call   80105530 <argint>
80105a13:	83 c4 10             	add    $0x10,%esp
80105a16:	85 c0                	test   %eax,%eax
80105a18:	78 3e                	js     80105a58 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105a1a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105a1e:	77 38                	ja     80105a58 <sys_close+0x58>
80105a20:	e8 9b df ff ff       	call   801039c0 <myproc>
80105a25:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105a28:	8d 5a 08             	lea    0x8(%edx),%ebx
80105a2b:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
80105a2f:	85 f6                	test   %esi,%esi
80105a31:	74 25                	je     80105a58 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80105a33:	e8 88 df ff ff       	call   801039c0 <myproc>
  fileclose(f);
80105a38:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105a3b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80105a42:	00 
  fileclose(f);
80105a43:	56                   	push   %esi
80105a44:	e8 b7 b4 ff ff       	call   80100f00 <fileclose>
  return 0;
80105a49:	83 c4 10             	add    $0x10,%esp
80105a4c:	31 c0                	xor    %eax,%eax
}
80105a4e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a51:	5b                   	pop    %ebx
80105a52:	5e                   	pop    %esi
80105a53:	5d                   	pop    %ebp
80105a54:	c3                   	ret    
80105a55:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105a58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a5d:	eb ef                	jmp    80105a4e <sys_close+0x4e>
80105a5f:	90                   	nop

80105a60 <sys_fstat>:
{
80105a60:	55                   	push   %ebp
80105a61:	89 e5                	mov    %esp,%ebp
80105a63:	56                   	push   %esi
80105a64:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105a65:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105a68:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105a6b:	53                   	push   %ebx
80105a6c:	6a 00                	push   $0x0
80105a6e:	e8 bd fa ff ff       	call   80105530 <argint>
80105a73:	83 c4 10             	add    $0x10,%esp
80105a76:	85 c0                	test   %eax,%eax
80105a78:	78 46                	js     80105ac0 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105a7a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105a7e:	77 40                	ja     80105ac0 <sys_fstat+0x60>
80105a80:	e8 3b df ff ff       	call   801039c0 <myproc>
80105a85:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105a88:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105a8c:	85 f6                	test   %esi,%esi
80105a8e:	74 30                	je     80105ac0 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105a90:	83 ec 04             	sub    $0x4,%esp
80105a93:	6a 14                	push   $0x14
80105a95:	53                   	push   %ebx
80105a96:	6a 01                	push   $0x1
80105a98:	e8 e3 fa ff ff       	call   80105580 <argptr>
80105a9d:	83 c4 10             	add    $0x10,%esp
80105aa0:	85 c0                	test   %eax,%eax
80105aa2:	78 1c                	js     80105ac0 <sys_fstat+0x60>
  return filestat(f, st);
80105aa4:	83 ec 08             	sub    $0x8,%esp
80105aa7:	ff 75 f4             	push   -0xc(%ebp)
80105aaa:	56                   	push   %esi
80105aab:	e8 30 b5 ff ff       	call   80100fe0 <filestat>
80105ab0:	83 c4 10             	add    $0x10,%esp
}
80105ab3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105ab6:	5b                   	pop    %ebx
80105ab7:	5e                   	pop    %esi
80105ab8:	5d                   	pop    %ebp
80105ab9:	c3                   	ret    
80105aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105ac0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ac5:	eb ec                	jmp    80105ab3 <sys_fstat+0x53>
80105ac7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ace:	66 90                	xchg   %ax,%ax

80105ad0 <sys_link>:
{
80105ad0:	55                   	push   %ebp
80105ad1:	89 e5                	mov    %esp,%ebp
80105ad3:	57                   	push   %edi
80105ad4:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105ad5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105ad8:	53                   	push   %ebx
80105ad9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105adc:	50                   	push   %eax
80105add:	6a 00                	push   $0x0
80105adf:	e8 0c fb ff ff       	call   801055f0 <argstr>
80105ae4:	83 c4 10             	add    $0x10,%esp
80105ae7:	85 c0                	test   %eax,%eax
80105ae9:	0f 88 fb 00 00 00    	js     80105bea <sys_link+0x11a>
80105aef:	83 ec 08             	sub    $0x8,%esp
80105af2:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105af5:	50                   	push   %eax
80105af6:	6a 01                	push   $0x1
80105af8:	e8 f3 fa ff ff       	call   801055f0 <argstr>
80105afd:	83 c4 10             	add    $0x10,%esp
80105b00:	85 c0                	test   %eax,%eax
80105b02:	0f 88 e2 00 00 00    	js     80105bea <sys_link+0x11a>
  begin_op();
80105b08:	e8 63 d2 ff ff       	call   80102d70 <begin_op>
  if((ip = namei(old)) == 0){
80105b0d:	83 ec 0c             	sub    $0xc,%esp
80105b10:	ff 75 d4             	push   -0x2c(%ebp)
80105b13:	e8 98 c5 ff ff       	call   801020b0 <namei>
80105b18:	83 c4 10             	add    $0x10,%esp
80105b1b:	89 c3                	mov    %eax,%ebx
80105b1d:	85 c0                	test   %eax,%eax
80105b1f:	0f 84 e4 00 00 00    	je     80105c09 <sys_link+0x139>
  ilock(ip);
80105b25:	83 ec 0c             	sub    $0xc,%esp
80105b28:	50                   	push   %eax
80105b29:	e8 62 bc ff ff       	call   80101790 <ilock>
  if(ip->type == T_DIR){
80105b2e:	83 c4 10             	add    $0x10,%esp
80105b31:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105b36:	0f 84 b5 00 00 00    	je     80105bf1 <sys_link+0x121>
  iupdate(ip);
80105b3c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80105b3f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105b44:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105b47:	53                   	push   %ebx
80105b48:	e8 93 bb ff ff       	call   801016e0 <iupdate>
  iunlock(ip);
80105b4d:	89 1c 24             	mov    %ebx,(%esp)
80105b50:	e8 1b bd ff ff       	call   80101870 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105b55:	58                   	pop    %eax
80105b56:	5a                   	pop    %edx
80105b57:	57                   	push   %edi
80105b58:	ff 75 d0             	push   -0x30(%ebp)
80105b5b:	e8 70 c5 ff ff       	call   801020d0 <nameiparent>
80105b60:	83 c4 10             	add    $0x10,%esp
80105b63:	89 c6                	mov    %eax,%esi
80105b65:	85 c0                	test   %eax,%eax
80105b67:	74 5b                	je     80105bc4 <sys_link+0xf4>
  ilock(dp);
80105b69:	83 ec 0c             	sub    $0xc,%esp
80105b6c:	50                   	push   %eax
80105b6d:	e8 1e bc ff ff       	call   80101790 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105b72:	8b 03                	mov    (%ebx),%eax
80105b74:	83 c4 10             	add    $0x10,%esp
80105b77:	39 06                	cmp    %eax,(%esi)
80105b79:	75 3d                	jne    80105bb8 <sys_link+0xe8>
80105b7b:	83 ec 04             	sub    $0x4,%esp
80105b7e:	ff 73 04             	push   0x4(%ebx)
80105b81:	57                   	push   %edi
80105b82:	56                   	push   %esi
80105b83:	e8 68 c4 ff ff       	call   80101ff0 <dirlink>
80105b88:	83 c4 10             	add    $0x10,%esp
80105b8b:	85 c0                	test   %eax,%eax
80105b8d:	78 29                	js     80105bb8 <sys_link+0xe8>
  iunlockput(dp);
80105b8f:	83 ec 0c             	sub    $0xc,%esp
80105b92:	56                   	push   %esi
80105b93:	e8 88 be ff ff       	call   80101a20 <iunlockput>
  iput(ip);
80105b98:	89 1c 24             	mov    %ebx,(%esp)
80105b9b:	e8 20 bd ff ff       	call   801018c0 <iput>
  end_op();
80105ba0:	e8 3b d2 ff ff       	call   80102de0 <end_op>
  return 0;
80105ba5:	83 c4 10             	add    $0x10,%esp
80105ba8:	31 c0                	xor    %eax,%eax
}
80105baa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bad:	5b                   	pop    %ebx
80105bae:	5e                   	pop    %esi
80105baf:	5f                   	pop    %edi
80105bb0:	5d                   	pop    %ebp
80105bb1:	c3                   	ret    
80105bb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105bb8:	83 ec 0c             	sub    $0xc,%esp
80105bbb:	56                   	push   %esi
80105bbc:	e8 5f be ff ff       	call   80101a20 <iunlockput>
    goto bad;
80105bc1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105bc4:	83 ec 0c             	sub    $0xc,%esp
80105bc7:	53                   	push   %ebx
80105bc8:	e8 c3 bb ff ff       	call   80101790 <ilock>
  ip->nlink--;
80105bcd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105bd2:	89 1c 24             	mov    %ebx,(%esp)
80105bd5:	e8 06 bb ff ff       	call   801016e0 <iupdate>
  iunlockput(ip);
80105bda:	89 1c 24             	mov    %ebx,(%esp)
80105bdd:	e8 3e be ff ff       	call   80101a20 <iunlockput>
  end_op();
80105be2:	e8 f9 d1 ff ff       	call   80102de0 <end_op>
  return -1;
80105be7:	83 c4 10             	add    $0x10,%esp
80105bea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bef:	eb b9                	jmp    80105baa <sys_link+0xda>
    iunlockput(ip);
80105bf1:	83 ec 0c             	sub    $0xc,%esp
80105bf4:	53                   	push   %ebx
80105bf5:	e8 26 be ff ff       	call   80101a20 <iunlockput>
    end_op();
80105bfa:	e8 e1 d1 ff ff       	call   80102de0 <end_op>
    return -1;
80105bff:	83 c4 10             	add    $0x10,%esp
80105c02:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c07:	eb a1                	jmp    80105baa <sys_link+0xda>
    end_op();
80105c09:	e8 d2 d1 ff ff       	call   80102de0 <end_op>
    return -1;
80105c0e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c13:	eb 95                	jmp    80105baa <sys_link+0xda>
80105c15:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c20 <sys_unlink>:
{
80105c20:	55                   	push   %ebp
80105c21:	89 e5                	mov    %esp,%ebp
80105c23:	57                   	push   %edi
80105c24:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105c25:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105c28:	53                   	push   %ebx
80105c29:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80105c2c:	50                   	push   %eax
80105c2d:	6a 00                	push   $0x0
80105c2f:	e8 bc f9 ff ff       	call   801055f0 <argstr>
80105c34:	83 c4 10             	add    $0x10,%esp
80105c37:	85 c0                	test   %eax,%eax
80105c39:	0f 88 7a 01 00 00    	js     80105db9 <sys_unlink+0x199>
  begin_op();
80105c3f:	e8 2c d1 ff ff       	call   80102d70 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105c44:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105c47:	83 ec 08             	sub    $0x8,%esp
80105c4a:	53                   	push   %ebx
80105c4b:	ff 75 c0             	push   -0x40(%ebp)
80105c4e:	e8 7d c4 ff ff       	call   801020d0 <nameiparent>
80105c53:	83 c4 10             	add    $0x10,%esp
80105c56:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105c59:	85 c0                	test   %eax,%eax
80105c5b:	0f 84 62 01 00 00    	je     80105dc3 <sys_unlink+0x1a3>
  ilock(dp);
80105c61:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105c64:	83 ec 0c             	sub    $0xc,%esp
80105c67:	57                   	push   %edi
80105c68:	e8 23 bb ff ff       	call   80101790 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105c6d:	58                   	pop    %eax
80105c6e:	5a                   	pop    %edx
80105c6f:	68 e0 88 10 80       	push   $0x801088e0
80105c74:	53                   	push   %ebx
80105c75:	e8 56 c0 ff ff       	call   80101cd0 <namecmp>
80105c7a:	83 c4 10             	add    $0x10,%esp
80105c7d:	85 c0                	test   %eax,%eax
80105c7f:	0f 84 fb 00 00 00    	je     80105d80 <sys_unlink+0x160>
80105c85:	83 ec 08             	sub    $0x8,%esp
80105c88:	68 df 88 10 80       	push   $0x801088df
80105c8d:	53                   	push   %ebx
80105c8e:	e8 3d c0 ff ff       	call   80101cd0 <namecmp>
80105c93:	83 c4 10             	add    $0x10,%esp
80105c96:	85 c0                	test   %eax,%eax
80105c98:	0f 84 e2 00 00 00    	je     80105d80 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105c9e:	83 ec 04             	sub    $0x4,%esp
80105ca1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105ca4:	50                   	push   %eax
80105ca5:	53                   	push   %ebx
80105ca6:	57                   	push   %edi
80105ca7:	e8 44 c0 ff ff       	call   80101cf0 <dirlookup>
80105cac:	83 c4 10             	add    $0x10,%esp
80105caf:	89 c3                	mov    %eax,%ebx
80105cb1:	85 c0                	test   %eax,%eax
80105cb3:	0f 84 c7 00 00 00    	je     80105d80 <sys_unlink+0x160>
  ilock(ip);
80105cb9:	83 ec 0c             	sub    $0xc,%esp
80105cbc:	50                   	push   %eax
80105cbd:	e8 ce ba ff ff       	call   80101790 <ilock>
  if(ip->nlink < 1)
80105cc2:	83 c4 10             	add    $0x10,%esp
80105cc5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105cca:	0f 8e 1c 01 00 00    	jle    80105dec <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105cd0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105cd5:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105cd8:	74 66                	je     80105d40 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105cda:	83 ec 04             	sub    $0x4,%esp
80105cdd:	6a 10                	push   $0x10
80105cdf:	6a 00                	push   $0x0
80105ce1:	57                   	push   %edi
80105ce2:	e8 89 f5 ff ff       	call   80105270 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105ce7:	6a 10                	push   $0x10
80105ce9:	ff 75 c4             	push   -0x3c(%ebp)
80105cec:	57                   	push   %edi
80105ced:	ff 75 b4             	push   -0x4c(%ebp)
80105cf0:	e8 ab be ff ff       	call   80101ba0 <writei>
80105cf5:	83 c4 20             	add    $0x20,%esp
80105cf8:	83 f8 10             	cmp    $0x10,%eax
80105cfb:	0f 85 de 00 00 00    	jne    80105ddf <sys_unlink+0x1bf>
  if(ip->type == T_DIR){
80105d01:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105d06:	0f 84 94 00 00 00    	je     80105da0 <sys_unlink+0x180>
  iunlockput(dp);
80105d0c:	83 ec 0c             	sub    $0xc,%esp
80105d0f:	ff 75 b4             	push   -0x4c(%ebp)
80105d12:	e8 09 bd ff ff       	call   80101a20 <iunlockput>
  ip->nlink--;
80105d17:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105d1c:	89 1c 24             	mov    %ebx,(%esp)
80105d1f:	e8 bc b9 ff ff       	call   801016e0 <iupdate>
  iunlockput(ip);
80105d24:	89 1c 24             	mov    %ebx,(%esp)
80105d27:	e8 f4 bc ff ff       	call   80101a20 <iunlockput>
  end_op();
80105d2c:	e8 af d0 ff ff       	call   80102de0 <end_op>
  return 0;
80105d31:	83 c4 10             	add    $0x10,%esp
80105d34:	31 c0                	xor    %eax,%eax
}
80105d36:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d39:	5b                   	pop    %ebx
80105d3a:	5e                   	pop    %esi
80105d3b:	5f                   	pop    %edi
80105d3c:	5d                   	pop    %ebp
80105d3d:	c3                   	ret    
80105d3e:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105d40:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105d44:	76 94                	jbe    80105cda <sys_unlink+0xba>
80105d46:	be 20 00 00 00       	mov    $0x20,%esi
80105d4b:	eb 0b                	jmp    80105d58 <sys_unlink+0x138>
80105d4d:	8d 76 00             	lea    0x0(%esi),%esi
80105d50:	83 c6 10             	add    $0x10,%esi
80105d53:	3b 73 58             	cmp    0x58(%ebx),%esi
80105d56:	73 82                	jae    80105cda <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105d58:	6a 10                	push   $0x10
80105d5a:	56                   	push   %esi
80105d5b:	57                   	push   %edi
80105d5c:	53                   	push   %ebx
80105d5d:	e8 3e bd ff ff       	call   80101aa0 <readi>
80105d62:	83 c4 10             	add    $0x10,%esp
80105d65:	83 f8 10             	cmp    $0x10,%eax
80105d68:	75 68                	jne    80105dd2 <sys_unlink+0x1b2>
    if(de.inum != 0)
80105d6a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105d6f:	74 df                	je     80105d50 <sys_unlink+0x130>
    iunlockput(ip);
80105d71:	83 ec 0c             	sub    $0xc,%esp
80105d74:	53                   	push   %ebx
80105d75:	e8 a6 bc ff ff       	call   80101a20 <iunlockput>
    goto bad;
80105d7a:	83 c4 10             	add    $0x10,%esp
80105d7d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105d80:	83 ec 0c             	sub    $0xc,%esp
80105d83:	ff 75 b4             	push   -0x4c(%ebp)
80105d86:	e8 95 bc ff ff       	call   80101a20 <iunlockput>
  end_op();
80105d8b:	e8 50 d0 ff ff       	call   80102de0 <end_op>
  return -1;
80105d90:	83 c4 10             	add    $0x10,%esp
80105d93:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d98:	eb 9c                	jmp    80105d36 <sys_unlink+0x116>
80105d9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105da0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105da3:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105da6:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105dab:	50                   	push   %eax
80105dac:	e8 2f b9 ff ff       	call   801016e0 <iupdate>
80105db1:	83 c4 10             	add    $0x10,%esp
80105db4:	e9 53 ff ff ff       	jmp    80105d0c <sys_unlink+0xec>
    return -1;
80105db9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dbe:	e9 73 ff ff ff       	jmp    80105d36 <sys_unlink+0x116>
    end_op();
80105dc3:	e8 18 d0 ff ff       	call   80102de0 <end_op>
    return -1;
80105dc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dcd:	e9 64 ff ff ff       	jmp    80105d36 <sys_unlink+0x116>
      panic("isdirempty: readi");
80105dd2:	83 ec 0c             	sub    $0xc,%esp
80105dd5:	68 04 89 10 80       	push   $0x80108904
80105dda:	e8 a1 a5 ff ff       	call   80100380 <panic>
    panic("unlink: writei");
80105ddf:	83 ec 0c             	sub    $0xc,%esp
80105de2:	68 16 89 10 80       	push   $0x80108916
80105de7:	e8 94 a5 ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
80105dec:	83 ec 0c             	sub    $0xc,%esp
80105def:	68 f2 88 10 80       	push   $0x801088f2
80105df4:	e8 87 a5 ff ff       	call   80100380 <panic>
80105df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e00 <sys_open>:

int
sys_open(void)
{
80105e00:	55                   	push   %ebp
80105e01:	89 e5                	mov    %esp,%ebp
80105e03:	57                   	push   %edi
80105e04:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105e05:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105e08:	53                   	push   %ebx
80105e09:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105e0c:	50                   	push   %eax
80105e0d:	6a 00                	push   $0x0
80105e0f:	e8 dc f7 ff ff       	call   801055f0 <argstr>
80105e14:	83 c4 10             	add    $0x10,%esp
80105e17:	85 c0                	test   %eax,%eax
80105e19:	0f 88 8e 00 00 00    	js     80105ead <sys_open+0xad>
80105e1f:	83 ec 08             	sub    $0x8,%esp
80105e22:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105e25:	50                   	push   %eax
80105e26:	6a 01                	push   $0x1
80105e28:	e8 03 f7 ff ff       	call   80105530 <argint>
80105e2d:	83 c4 10             	add    $0x10,%esp
80105e30:	85 c0                	test   %eax,%eax
80105e32:	78 79                	js     80105ead <sys_open+0xad>
    return -1;

  begin_op();
80105e34:	e8 37 cf ff ff       	call   80102d70 <begin_op>

  if(omode & O_CREATE){
80105e39:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105e3d:	75 79                	jne    80105eb8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105e3f:	83 ec 0c             	sub    $0xc,%esp
80105e42:	ff 75 e0             	push   -0x20(%ebp)
80105e45:	e8 66 c2 ff ff       	call   801020b0 <namei>
80105e4a:	83 c4 10             	add    $0x10,%esp
80105e4d:	89 c6                	mov    %eax,%esi
80105e4f:	85 c0                	test   %eax,%eax
80105e51:	0f 84 7e 00 00 00    	je     80105ed5 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105e57:	83 ec 0c             	sub    $0xc,%esp
80105e5a:	50                   	push   %eax
80105e5b:	e8 30 b9 ff ff       	call   80101790 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105e60:	83 c4 10             	add    $0x10,%esp
80105e63:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105e68:	0f 84 c2 00 00 00    	je     80105f30 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105e6e:	e8 cd af ff ff       	call   80100e40 <filealloc>
80105e73:	89 c7                	mov    %eax,%edi
80105e75:	85 c0                	test   %eax,%eax
80105e77:	74 23                	je     80105e9c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105e79:	e8 42 db ff ff       	call   801039c0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105e7e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105e80:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105e84:	85 d2                	test   %edx,%edx
80105e86:	74 60                	je     80105ee8 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80105e88:	83 c3 01             	add    $0x1,%ebx
80105e8b:	83 fb 10             	cmp    $0x10,%ebx
80105e8e:	75 f0                	jne    80105e80 <sys_open+0x80>
    if(f)
      fileclose(f);
80105e90:	83 ec 0c             	sub    $0xc,%esp
80105e93:	57                   	push   %edi
80105e94:	e8 67 b0 ff ff       	call   80100f00 <fileclose>
80105e99:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105e9c:	83 ec 0c             	sub    $0xc,%esp
80105e9f:	56                   	push   %esi
80105ea0:	e8 7b bb ff ff       	call   80101a20 <iunlockput>
    end_op();
80105ea5:	e8 36 cf ff ff       	call   80102de0 <end_op>
    return -1;
80105eaa:	83 c4 10             	add    $0x10,%esp
80105ead:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105eb2:	eb 6d                	jmp    80105f21 <sys_open+0x121>
80105eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105eb8:	83 ec 0c             	sub    $0xc,%esp
80105ebb:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105ebe:	31 c9                	xor    %ecx,%ecx
80105ec0:	ba 02 00 00 00       	mov    $0x2,%edx
80105ec5:	6a 00                	push   $0x0
80105ec7:	e8 14 f8 ff ff       	call   801056e0 <create>
    if(ip == 0){
80105ecc:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80105ecf:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105ed1:	85 c0                	test   %eax,%eax
80105ed3:	75 99                	jne    80105e6e <sys_open+0x6e>
      end_op();
80105ed5:	e8 06 cf ff ff       	call   80102de0 <end_op>
      return -1;
80105eda:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105edf:	eb 40                	jmp    80105f21 <sys_open+0x121>
80105ee1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105ee8:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105eeb:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105eef:	56                   	push   %esi
80105ef0:	e8 7b b9 ff ff       	call   80101870 <iunlock>
  end_op();
80105ef5:	e8 e6 ce ff ff       	call   80102de0 <end_op>

  f->type = FD_INODE;
80105efa:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105f00:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105f03:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105f06:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105f09:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105f0b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105f12:	f7 d0                	not    %eax
80105f14:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105f17:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105f1a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105f1d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105f21:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f24:	89 d8                	mov    %ebx,%eax
80105f26:	5b                   	pop    %ebx
80105f27:	5e                   	pop    %esi
80105f28:	5f                   	pop    %edi
80105f29:	5d                   	pop    %ebp
80105f2a:	c3                   	ret    
80105f2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105f2f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80105f30:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105f33:	85 c9                	test   %ecx,%ecx
80105f35:	0f 84 33 ff ff ff    	je     80105e6e <sys_open+0x6e>
80105f3b:	e9 5c ff ff ff       	jmp    80105e9c <sys_open+0x9c>

80105f40 <sys_mkdir>:

int
sys_mkdir(void)
{
80105f40:	55                   	push   %ebp
80105f41:	89 e5                	mov    %esp,%ebp
80105f43:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105f46:	e8 25 ce ff ff       	call   80102d70 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105f4b:	83 ec 08             	sub    $0x8,%esp
80105f4e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f51:	50                   	push   %eax
80105f52:	6a 00                	push   $0x0
80105f54:	e8 97 f6 ff ff       	call   801055f0 <argstr>
80105f59:	83 c4 10             	add    $0x10,%esp
80105f5c:	85 c0                	test   %eax,%eax
80105f5e:	78 30                	js     80105f90 <sys_mkdir+0x50>
80105f60:	83 ec 0c             	sub    $0xc,%esp
80105f63:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f66:	31 c9                	xor    %ecx,%ecx
80105f68:	ba 01 00 00 00       	mov    $0x1,%edx
80105f6d:	6a 00                	push   $0x0
80105f6f:	e8 6c f7 ff ff       	call   801056e0 <create>
80105f74:	83 c4 10             	add    $0x10,%esp
80105f77:	85 c0                	test   %eax,%eax
80105f79:	74 15                	je     80105f90 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105f7b:	83 ec 0c             	sub    $0xc,%esp
80105f7e:	50                   	push   %eax
80105f7f:	e8 9c ba ff ff       	call   80101a20 <iunlockput>
  end_op();
80105f84:	e8 57 ce ff ff       	call   80102de0 <end_op>
  return 0;
80105f89:	83 c4 10             	add    $0x10,%esp
80105f8c:	31 c0                	xor    %eax,%eax
}
80105f8e:	c9                   	leave  
80105f8f:	c3                   	ret    
    end_op();
80105f90:	e8 4b ce ff ff       	call   80102de0 <end_op>
    return -1;
80105f95:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f9a:	c9                   	leave  
80105f9b:	c3                   	ret    
80105f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105fa0 <sys_mknod>:

int
sys_mknod(void)
{
80105fa0:	55                   	push   %ebp
80105fa1:	89 e5                	mov    %esp,%ebp
80105fa3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105fa6:	e8 c5 cd ff ff       	call   80102d70 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105fab:	83 ec 08             	sub    $0x8,%esp
80105fae:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105fb1:	50                   	push   %eax
80105fb2:	6a 00                	push   $0x0
80105fb4:	e8 37 f6 ff ff       	call   801055f0 <argstr>
80105fb9:	83 c4 10             	add    $0x10,%esp
80105fbc:	85 c0                	test   %eax,%eax
80105fbe:	78 60                	js     80106020 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105fc0:	83 ec 08             	sub    $0x8,%esp
80105fc3:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105fc6:	50                   	push   %eax
80105fc7:	6a 01                	push   $0x1
80105fc9:	e8 62 f5 ff ff       	call   80105530 <argint>
  if((argstr(0, &path)) < 0 ||
80105fce:	83 c4 10             	add    $0x10,%esp
80105fd1:	85 c0                	test   %eax,%eax
80105fd3:	78 4b                	js     80106020 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105fd5:	83 ec 08             	sub    $0x8,%esp
80105fd8:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105fdb:	50                   	push   %eax
80105fdc:	6a 02                	push   $0x2
80105fde:	e8 4d f5 ff ff       	call   80105530 <argint>
     argint(1, &major) < 0 ||
80105fe3:	83 c4 10             	add    $0x10,%esp
80105fe6:	85 c0                	test   %eax,%eax
80105fe8:	78 36                	js     80106020 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105fea:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105fee:	83 ec 0c             	sub    $0xc,%esp
80105ff1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105ff5:	ba 03 00 00 00       	mov    $0x3,%edx
80105ffa:	50                   	push   %eax
80105ffb:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105ffe:	e8 dd f6 ff ff       	call   801056e0 <create>
     argint(2, &minor) < 0 ||
80106003:	83 c4 10             	add    $0x10,%esp
80106006:	85 c0                	test   %eax,%eax
80106008:	74 16                	je     80106020 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010600a:	83 ec 0c             	sub    $0xc,%esp
8010600d:	50                   	push   %eax
8010600e:	e8 0d ba ff ff       	call   80101a20 <iunlockput>
  end_op();
80106013:	e8 c8 cd ff ff       	call   80102de0 <end_op>
  return 0;
80106018:	83 c4 10             	add    $0x10,%esp
8010601b:	31 c0                	xor    %eax,%eax
}
8010601d:	c9                   	leave  
8010601e:	c3                   	ret    
8010601f:	90                   	nop
    end_op();
80106020:	e8 bb cd ff ff       	call   80102de0 <end_op>
    return -1;
80106025:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010602a:	c9                   	leave  
8010602b:	c3                   	ret    
8010602c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106030 <sys_chdir>:

int
sys_chdir(void)
{
80106030:	55                   	push   %ebp
80106031:	89 e5                	mov    %esp,%ebp
80106033:	56                   	push   %esi
80106034:	53                   	push   %ebx
80106035:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106038:	e8 83 d9 ff ff       	call   801039c0 <myproc>
8010603d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010603f:	e8 2c cd ff ff       	call   80102d70 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106044:	83 ec 08             	sub    $0x8,%esp
80106047:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010604a:	50                   	push   %eax
8010604b:	6a 00                	push   $0x0
8010604d:	e8 9e f5 ff ff       	call   801055f0 <argstr>
80106052:	83 c4 10             	add    $0x10,%esp
80106055:	85 c0                	test   %eax,%eax
80106057:	78 77                	js     801060d0 <sys_chdir+0xa0>
80106059:	83 ec 0c             	sub    $0xc,%esp
8010605c:	ff 75 f4             	push   -0xc(%ebp)
8010605f:	e8 4c c0 ff ff       	call   801020b0 <namei>
80106064:	83 c4 10             	add    $0x10,%esp
80106067:	89 c3                	mov    %eax,%ebx
80106069:	85 c0                	test   %eax,%eax
8010606b:	74 63                	je     801060d0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010606d:	83 ec 0c             	sub    $0xc,%esp
80106070:	50                   	push   %eax
80106071:	e8 1a b7 ff ff       	call   80101790 <ilock>
  if(ip->type != T_DIR){
80106076:	83 c4 10             	add    $0x10,%esp
80106079:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010607e:	75 30                	jne    801060b0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106080:	83 ec 0c             	sub    $0xc,%esp
80106083:	53                   	push   %ebx
80106084:	e8 e7 b7 ff ff       	call   80101870 <iunlock>
  iput(curproc->cwd);
80106089:	58                   	pop    %eax
8010608a:	ff 76 68             	push   0x68(%esi)
8010608d:	e8 2e b8 ff ff       	call   801018c0 <iput>
  end_op();
80106092:	e8 49 cd ff ff       	call   80102de0 <end_op>
  curproc->cwd = ip;
80106097:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010609a:	83 c4 10             	add    $0x10,%esp
8010609d:	31 c0                	xor    %eax,%eax
}
8010609f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801060a2:	5b                   	pop    %ebx
801060a3:	5e                   	pop    %esi
801060a4:	5d                   	pop    %ebp
801060a5:	c3                   	ret    
801060a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060ad:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
801060b0:	83 ec 0c             	sub    $0xc,%esp
801060b3:	53                   	push   %ebx
801060b4:	e8 67 b9 ff ff       	call   80101a20 <iunlockput>
    end_op();
801060b9:	e8 22 cd ff ff       	call   80102de0 <end_op>
    return -1;
801060be:	83 c4 10             	add    $0x10,%esp
801060c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060c6:	eb d7                	jmp    8010609f <sys_chdir+0x6f>
801060c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060cf:	90                   	nop
    end_op();
801060d0:	e8 0b cd ff ff       	call   80102de0 <end_op>
    return -1;
801060d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060da:	eb c3                	jmp    8010609f <sys_chdir+0x6f>
801060dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801060e0 <sys_exec>:

int
sys_exec(void)
{
801060e0:	55                   	push   %ebp
801060e1:	89 e5                	mov    %esp,%ebp
801060e3:	57                   	push   %edi
801060e4:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801060e5:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801060eb:	53                   	push   %ebx
801060ec:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801060f2:	50                   	push   %eax
801060f3:	6a 00                	push   $0x0
801060f5:	e8 f6 f4 ff ff       	call   801055f0 <argstr>
801060fa:	83 c4 10             	add    $0x10,%esp
801060fd:	85 c0                	test   %eax,%eax
801060ff:	0f 88 87 00 00 00    	js     8010618c <sys_exec+0xac>
80106105:	83 ec 08             	sub    $0x8,%esp
80106108:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010610e:	50                   	push   %eax
8010610f:	6a 01                	push   $0x1
80106111:	e8 1a f4 ff ff       	call   80105530 <argint>
80106116:	83 c4 10             	add    $0x10,%esp
80106119:	85 c0                	test   %eax,%eax
8010611b:	78 6f                	js     8010618c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010611d:	83 ec 04             	sub    $0x4,%esp
80106120:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80106126:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106128:	68 80 00 00 00       	push   $0x80
8010612d:	6a 00                	push   $0x0
8010612f:	56                   	push   %esi
80106130:	e8 3b f1 ff ff       	call   80105270 <memset>
80106135:	83 c4 10             	add    $0x10,%esp
80106138:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010613f:	90                   	nop
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106140:	83 ec 08             	sub    $0x8,%esp
80106143:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80106149:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80106150:	50                   	push   %eax
80106151:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106157:	01 f8                	add    %edi,%eax
80106159:	50                   	push   %eax
8010615a:	e8 41 f3 ff ff       	call   801054a0 <fetchint>
8010615f:	83 c4 10             	add    $0x10,%esp
80106162:	85 c0                	test   %eax,%eax
80106164:	78 26                	js     8010618c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80106166:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010616c:	85 c0                	test   %eax,%eax
8010616e:	74 30                	je     801061a0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106170:	83 ec 08             	sub    $0x8,%esp
80106173:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80106176:	52                   	push   %edx
80106177:	50                   	push   %eax
80106178:	e8 63 f3 ff ff       	call   801054e0 <fetchstr>
8010617d:	83 c4 10             	add    $0x10,%esp
80106180:	85 c0                	test   %eax,%eax
80106182:	78 08                	js     8010618c <sys_exec+0xac>
  for(i=0;; i++){
80106184:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80106187:	83 fb 20             	cmp    $0x20,%ebx
8010618a:	75 b4                	jne    80106140 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010618c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010618f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106194:	5b                   	pop    %ebx
80106195:	5e                   	pop    %esi
80106196:	5f                   	pop    %edi
80106197:	5d                   	pop    %ebp
80106198:	c3                   	ret    
80106199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
801061a0:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801061a7:	00 00 00 00 
  return exec(path, argv);
801061ab:	83 ec 08             	sub    $0x8,%esp
801061ae:	56                   	push   %esi
801061af:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
801061b5:	e8 f6 a8 ff ff       	call   80100ab0 <exec>
801061ba:	83 c4 10             	add    $0x10,%esp
}
801061bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801061c0:	5b                   	pop    %ebx
801061c1:	5e                   	pop    %esi
801061c2:	5f                   	pop    %edi
801061c3:	5d                   	pop    %ebp
801061c4:	c3                   	ret    
801061c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801061d0 <sys_pipe>:

int
sys_pipe(void)
{
801061d0:	55                   	push   %ebp
801061d1:	89 e5                	mov    %esp,%ebp
801061d3:	57                   	push   %edi
801061d4:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801061d5:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801061d8:	53                   	push   %ebx
801061d9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801061dc:	6a 08                	push   $0x8
801061de:	50                   	push   %eax
801061df:	6a 00                	push   $0x0
801061e1:	e8 9a f3 ff ff       	call   80105580 <argptr>
801061e6:	83 c4 10             	add    $0x10,%esp
801061e9:	85 c0                	test   %eax,%eax
801061eb:	78 4a                	js     80106237 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801061ed:	83 ec 08             	sub    $0x8,%esp
801061f0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801061f3:	50                   	push   %eax
801061f4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801061f7:	50                   	push   %eax
801061f8:	e8 43 d2 ff ff       	call   80103440 <pipealloc>
801061fd:	83 c4 10             	add    $0x10,%esp
80106200:	85 c0                	test   %eax,%eax
80106202:	78 33                	js     80106237 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106204:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80106207:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80106209:	e8 b2 d7 ff ff       	call   801039c0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010620e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80106210:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80106214:	85 f6                	test   %esi,%esi
80106216:	74 28                	je     80106240 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
80106218:	83 c3 01             	add    $0x1,%ebx
8010621b:	83 fb 10             	cmp    $0x10,%ebx
8010621e:	75 f0                	jne    80106210 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80106220:	83 ec 0c             	sub    $0xc,%esp
80106223:	ff 75 e0             	push   -0x20(%ebp)
80106226:	e8 d5 ac ff ff       	call   80100f00 <fileclose>
    fileclose(wf);
8010622b:	58                   	pop    %eax
8010622c:	ff 75 e4             	push   -0x1c(%ebp)
8010622f:	e8 cc ac ff ff       	call   80100f00 <fileclose>
    return -1;
80106234:	83 c4 10             	add    $0x10,%esp
80106237:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010623c:	eb 53                	jmp    80106291 <sys_pipe+0xc1>
8010623e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80106240:	8d 73 08             	lea    0x8(%ebx),%esi
80106243:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106247:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010624a:	e8 71 d7 ff ff       	call   801039c0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010624f:	31 d2                	xor    %edx,%edx
80106251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80106258:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010625c:	85 c9                	test   %ecx,%ecx
8010625e:	74 20                	je     80106280 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
80106260:	83 c2 01             	add    $0x1,%edx
80106263:	83 fa 10             	cmp    $0x10,%edx
80106266:	75 f0                	jne    80106258 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
80106268:	e8 53 d7 ff ff       	call   801039c0 <myproc>
8010626d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80106274:	00 
80106275:	eb a9                	jmp    80106220 <sys_pipe+0x50>
80106277:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010627e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80106280:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80106284:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106287:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106289:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010628c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
8010628f:	31 c0                	xor    %eax,%eax
}
80106291:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106294:	5b                   	pop    %ebx
80106295:	5e                   	pop    %esi
80106296:	5f                   	pop    %edi
80106297:	5d                   	pop    %ebp
80106298:	c3                   	ret    
80106299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801062a0 <sys_get_file_sectors>:

int
sys_get_file_sectors(void)
{
801062a0:	55                   	push   %ebp
801062a1:	89 e5                	mov    %esp,%ebp
801062a3:	57                   	push   %edi
801062a4:	56                   	push   %esi
  if(argint(n, &fd) < 0)
801062a5:	8d 75 e4             	lea    -0x1c(%ebp),%esi
{
801062a8:	53                   	push   %ebx
801062a9:	83 ec 24             	sub    $0x24,%esp
  if(argint(n, &fd) < 0)
801062ac:	56                   	push   %esi
801062ad:	6a 00                	push   $0x0
801062af:	e8 7c f2 ff ff       	call   80105530 <argint>
801062b4:	83 c4 10             	add    $0x10,%esp
801062b7:	85 c0                	test   %eax,%eax
801062b9:	78 64                	js     8010631f <sys_get_file_sectors+0x7f>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801062bb:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
801062bf:	77 5e                	ja     8010631f <sys_get_file_sectors+0x7f>
801062c1:	e8 fa d6 ff ff       	call   801039c0 <myproc>
801062c6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801062c9:	8b 5c b8 28          	mov    0x28(%eax,%edi,4),%ebx
801062cd:	85 db                	test   %ebx,%ebx
801062cf:	74 4e                	je     8010631f <sys_get_file_sectors+0x7f>
  int fd;
  int *sectors;
  struct file *f;
  if(argfd(0, &fd, &f) < 0 || argptr(1, (void*)&sectors, sizeof(*sectors) * 13) < 0)
801062d1:	83 ec 04             	sub    $0x4,%esp
801062d4:	6a 34                	push   $0x34
801062d6:	56                   	push   %esi
801062d7:	6a 01                	push   $0x1
801062d9:	e8 a2 f2 ff ff       	call   80105580 <argptr>
801062de:	83 c4 10             	add    $0x10,%esp
801062e1:	85 c0                	test   %eax,%eax
801062e3:	78 3a                	js     8010631f <sys_get_file_sectors+0x7f>
    return -1;    
  cprintf("sys_get_file_sectores(%d, sectors)\n", fd);
801062e5:	83 ec 08             	sub    $0x8,%esp
801062e8:	57                   	push   %edi
801062e9:	68 28 89 10 80       	push   $0x80108928
801062ee:	e8 ad a3 ff ff       	call   801006a0 <cprintf>
801062f3:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < 13; i++)
801062f6:	31 c0                	xor    %eax,%eax
801062f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801062ff:	90                   	nop
    sectors[i] = f->ip->addrs[i];
80106300:	8b 53 10             	mov    0x10(%ebx),%edx
80106303:	8b 4c 82 5c          	mov    0x5c(%edx,%eax,4),%ecx
80106307:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010630a:	89 0c 82             	mov    %ecx,(%edx,%eax,4)
  for(int i = 0; i < 13; i++)
8010630d:	83 c0 01             	add    $0x1,%eax
80106310:	83 f8 0d             	cmp    $0xd,%eax
80106313:	75 eb                	jne    80106300 <sys_get_file_sectors+0x60>
  return 0;
80106315:	31 c0                	xor    %eax,%eax
}
80106317:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010631a:	5b                   	pop    %ebx
8010631b:	5e                   	pop    %esi
8010631c:	5f                   	pop    %edi
8010631d:	5d                   	pop    %ebp
8010631e:	c3                   	ret    
    return -1;    
8010631f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106324:	eb f1                	jmp    80106317 <sys_get_file_sectors+0x77>
80106326:	66 90                	xchg   %ax,%ax
80106328:	66 90                	xchg   %ax,%ax
8010632a:	66 90                	xchg   %ax,%ax
8010632c:	66 90                	xchg   %ax,%ax
8010632e:	66 90                	xchg   %ax,%ax

80106330 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80106330:	e9 2b d8 ff ff       	jmp    80103b60 <fork>
80106335:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010633c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106340 <sys_exit>:
}

int
sys_exit(void)
{
80106340:	55                   	push   %ebp
80106341:	89 e5                	mov    %esp,%ebp
80106343:	83 ec 08             	sub    $0x8,%esp
  exit();
80106346:	e8 75 dd ff ff       	call   801040c0 <exit>
  return 0;  // not reached
}
8010634b:	31 c0                	xor    %eax,%eax
8010634d:	c9                   	leave  
8010634e:	c3                   	ret    
8010634f:	90                   	nop

80106350 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80106350:	e9 9b de ff ff       	jmp    801041f0 <wait>
80106355:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010635c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106360 <sys_kill>:
}

int
sys_kill(void)
{
80106360:	55                   	push   %ebp
80106361:	89 e5                	mov    %esp,%ebp
80106363:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106366:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106369:	50                   	push   %eax
8010636a:	6a 00                	push   $0x0
8010636c:	e8 bf f1 ff ff       	call   80105530 <argint>
80106371:	83 c4 10             	add    $0x10,%esp
80106374:	85 c0                	test   %eax,%eax
80106376:	78 18                	js     80106390 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106378:	83 ec 0c             	sub    $0xc,%esp
8010637b:	ff 75 f4             	push   -0xc(%ebp)
8010637e:	e8 4d e1 ff ff       	call   801044d0 <kill>
80106383:	83 c4 10             	add    $0x10,%esp
}
80106386:	c9                   	leave  
80106387:	c3                   	ret    
80106388:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010638f:	90                   	nop
80106390:	c9                   	leave  
    return -1;
80106391:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106396:	c3                   	ret    
80106397:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010639e:	66 90                	xchg   %ax,%ax

801063a0 <sys_getpid>:

int
sys_getpid(void)
{
801063a0:	55                   	push   %ebp
801063a1:	89 e5                	mov    %esp,%ebp
801063a3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801063a6:	e8 15 d6 ff ff       	call   801039c0 <myproc>
801063ab:	8b 40 10             	mov    0x10(%eax),%eax
}
801063ae:	c9                   	leave  
801063af:	c3                   	ret    

801063b0 <sys_sbrk>:

int
sys_sbrk(void)
{
801063b0:	55                   	push   %ebp
801063b1:	89 e5                	mov    %esp,%ebp
801063b3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801063b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801063b7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801063ba:	50                   	push   %eax
801063bb:	6a 00                	push   $0x0
801063bd:	e8 6e f1 ff ff       	call   80105530 <argint>
801063c2:	83 c4 10             	add    $0x10,%esp
801063c5:	85 c0                	test   %eax,%eax
801063c7:	78 27                	js     801063f0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801063c9:	e8 f2 d5 ff ff       	call   801039c0 <myproc>
  if(growproc(n) < 0)
801063ce:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801063d1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801063d3:	ff 75 f4             	push   -0xc(%ebp)
801063d6:	e8 05 d7 ff ff       	call   80103ae0 <growproc>
801063db:	83 c4 10             	add    $0x10,%esp
801063de:	85 c0                	test   %eax,%eax
801063e0:	78 0e                	js     801063f0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801063e2:	89 d8                	mov    %ebx,%eax
801063e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801063e7:	c9                   	leave  
801063e8:	c3                   	ret    
801063e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801063f0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801063f5:	eb eb                	jmp    801063e2 <sys_sbrk+0x32>
801063f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063fe:	66 90                	xchg   %ax,%ax

80106400 <sys_sleep>:

int
sys_sleep(void)
{
80106400:	55                   	push   %ebp
80106401:	89 e5                	mov    %esp,%ebp
80106403:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106404:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106407:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010640a:	50                   	push   %eax
8010640b:	6a 00                	push   $0x0
8010640d:	e8 1e f1 ff ff       	call   80105530 <argint>
80106412:	83 c4 10             	add    $0x10,%esp
80106415:	85 c0                	test   %eax,%eax
80106417:	0f 88 8a 00 00 00    	js     801064a7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010641d:	83 ec 0c             	sub    $0xc,%esp
80106420:	68 00 57 11 80       	push   $0x80115700
80106425:	e8 86 ed ff ff       	call   801051b0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010642a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
8010642d:	8b 1d e0 56 11 80    	mov    0x801156e0,%ebx
  while(ticks - ticks0 < n){
80106433:	83 c4 10             	add    $0x10,%esp
80106436:	85 d2                	test   %edx,%edx
80106438:	75 27                	jne    80106461 <sys_sleep+0x61>
8010643a:	eb 54                	jmp    80106490 <sys_sleep+0x90>
8010643c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106440:	83 ec 08             	sub    $0x8,%esp
80106443:	68 00 57 11 80       	push   $0x80115700
80106448:	68 e0 56 11 80       	push   $0x801156e0
8010644d:	e8 5e df ff ff       	call   801043b0 <sleep>
  while(ticks - ticks0 < n){
80106452:	a1 e0 56 11 80       	mov    0x801156e0,%eax
80106457:	83 c4 10             	add    $0x10,%esp
8010645a:	29 d8                	sub    %ebx,%eax
8010645c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010645f:	73 2f                	jae    80106490 <sys_sleep+0x90>
    if(myproc()->killed){
80106461:	e8 5a d5 ff ff       	call   801039c0 <myproc>
80106466:	8b 40 24             	mov    0x24(%eax),%eax
80106469:	85 c0                	test   %eax,%eax
8010646b:	74 d3                	je     80106440 <sys_sleep+0x40>
      release(&tickslock);
8010646d:	83 ec 0c             	sub    $0xc,%esp
80106470:	68 00 57 11 80       	push   $0x80115700
80106475:	e8 d6 ec ff ff       	call   80105150 <release>
  }
  release(&tickslock);
  return 0;
}
8010647a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
8010647d:	83 c4 10             	add    $0x10,%esp
80106480:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106485:	c9                   	leave  
80106486:	c3                   	ret    
80106487:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010648e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80106490:	83 ec 0c             	sub    $0xc,%esp
80106493:	68 00 57 11 80       	push   $0x80115700
80106498:	e8 b3 ec ff ff       	call   80105150 <release>
  return 0;
8010649d:	83 c4 10             	add    $0x10,%esp
801064a0:	31 c0                	xor    %eax,%eax
}
801064a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801064a5:	c9                   	leave  
801064a6:	c3                   	ret    
    return -1;
801064a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064ac:	eb f4                	jmp    801064a2 <sys_sleep+0xa2>
801064ae:	66 90                	xchg   %ax,%ax

801064b0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801064b0:	55                   	push   %ebp
801064b1:	89 e5                	mov    %esp,%ebp
801064b3:	53                   	push   %ebx
801064b4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801064b7:	68 00 57 11 80       	push   $0x80115700
801064bc:	e8 ef ec ff ff       	call   801051b0 <acquire>
  xticks = ticks;
801064c1:	8b 1d e0 56 11 80    	mov    0x801156e0,%ebx
  release(&tickslock);
801064c7:	c7 04 24 00 57 11 80 	movl   $0x80115700,(%esp)
801064ce:	e8 7d ec ff ff       	call   80105150 <release>
  return xticks;
}
801064d3:	89 d8                	mov    %ebx,%eax
801064d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801064d8:	c9                   	leave  
801064d9:	c3                   	ret    
801064da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801064e0 <sys_calculate_sum_of_digits>:

int sys_calculate_sum_of_digits(void)
{
801064e0:	55                   	push   %ebp
801064e1:	89 e5                	mov    %esp,%ebp
801064e3:	53                   	push   %ebx
801064e4:	83 ec 04             	sub    $0x4,%esp
  int num = myproc()->tf->ebx;
801064e7:	e8 d4 d4 ff ff       	call   801039c0 <myproc>
  cprintf("sys_calculate_sum_of_digits : %d\n",num);
801064ec:	83 ec 08             	sub    $0x8,%esp
  int num = myproc()->tf->ebx;
801064ef:	8b 40 18             	mov    0x18(%eax),%eax
801064f2:	8b 58 10             	mov    0x10(%eax),%ebx
  cprintf("sys_calculate_sum_of_digits : %d\n",num);
801064f5:	53                   	push   %ebx
801064f6:	68 4c 89 10 80       	push   $0x8010894c
801064fb:	e8 a0 a1 ff ff       	call   801006a0 <cprintf>
  return calculate_sum_of_digits(num);
80106500:	89 1c 24             	mov    %ebx,(%esp)
80106503:	e8 08 e1 ff ff       	call   80104610 <calculate_sum_of_digits>
}
80106508:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010650b:	c9                   	leave  
8010650c:	c3                   	ret    
8010650d:	8d 76 00             	lea    0x0(%esi),%esi

80106510 <sys_get_parent_pid>:

int sys_get_parent_pid(void)
{
80106510:	55                   	push   %ebp
80106511:	89 e5                	mov    %esp,%ebp
80106513:	83 ec 08             	sub    $0x8,%esp
  struct proc *p = myproc()->parent;
80106516:	e8 a5 d4 ff ff       	call   801039c0 <myproc>
8010651b:	8b 40 14             	mov    0x14(%eax),%eax
  while (p->is_tracer) {
8010651e:	8b 48 7c             	mov    0x7c(%eax),%ecx
80106521:	85 c9                	test   %ecx,%ecx
80106523:	74 10                	je     80106535 <sys_get_parent_pid+0x25>
80106525:	8d 76 00             	lea    0x0(%esi),%esi
    p = p->tracer_parent;
80106528:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
  while (p->is_tracer) {
8010652e:	8b 50 7c             	mov    0x7c(%eax),%edx
80106531:	85 d2                	test   %edx,%edx
80106533:	75 f3                	jne    80106528 <sys_get_parent_pid+0x18>
  }
  return p->pid;
80106535:	8b 40 10             	mov    0x10(%eax),%eax
}
80106538:	c9                   	leave  
80106539:	c3                   	ret    
8010653a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106540 <sys_set_process_parent>:

void sys_set_process_parent(void)
{
80106540:	55                   	push   %ebp
80106541:	89 e5                	mov    %esp,%ebp
80106543:	53                   	push   %ebx
80106544:	83 ec 04             	sub    $0x4,%esp
  int pid = myproc()->tf->ebx;
80106547:	e8 74 d4 ff ff       	call   801039c0 <myproc>
  cprintf("sys_set_process_parent for process %d\n", pid);
8010654c:	83 ec 08             	sub    $0x8,%esp
  int pid = myproc()->tf->ebx;
8010654f:	8b 40 18             	mov    0x18(%eax),%eax
80106552:	8b 58 10             	mov    0x10(%eax),%ebx
  cprintf("sys_set_process_parent for process %d\n", pid);
80106555:	53                   	push   %ebx
80106556:	68 70 89 10 80       	push   $0x80108970
8010655b:	e8 40 a1 ff ff       	call   801006a0 <cprintf>
  return set_process_parent(pid);
80106560:	89 1c 24             	mov    %ebx,(%esp)
80106563:	e8 e8 e0 ff ff       	call   80104650 <set_process_parent>
}
80106568:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return set_process_parent(pid);
8010656b:	83 c4 10             	add    $0x10,%esp
}
8010656e:	c9                   	leave  
8010656f:	c3                   	ret    

80106570 <sys_change_process_queue>:

int sys_change_process_queue(void)
{
80106570:	55                   	push   %ebp
80106571:	89 e5                	mov    %esp,%ebp
80106573:	83 ec 20             	sub    $0x20,%esp
  int pid ,new_priority;
  argint(0, &pid);
80106576:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106579:	50                   	push   %eax
8010657a:	6a 00                	push   $0x0
8010657c:	e8 af ef ff ff       	call   80105530 <argint>
  argint(1, &new_priority);
80106581:	58                   	pop    %eax
80106582:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106585:	5a                   	pop    %edx
80106586:	50                   	push   %eax
80106587:	6a 01                	push   $0x1
80106589:	e8 a2 ef ff ff       	call   80105530 <argint>
  change_process_queue(pid, new_priority);
8010658e:	59                   	pop    %ecx
8010658f:	58                   	pop    %eax
80106590:	ff 75 f4             	push   -0xc(%ebp)
80106593:	ff 75 f0             	push   -0x10(%ebp)
80106596:	e8 45 e1 ff ff       	call   801046e0 <change_process_queue>
  return 0;
}
8010659b:	31 c0                	xor    %eax,%eax
8010659d:	c9                   	leave  
8010659e:	c3                   	ret    
8010659f:	90                   	nop

801065a0 <sys_set_hrrn_priority>:

int sys_set_hrrn_priority(void)
{
801065a0:	55                   	push   %ebp
801065a1:	89 e5                	mov    %esp,%ebp
801065a3:	83 ec 20             	sub    $0x20,%esp
  int pid ,new_priority;
  argint(0, &pid);
801065a6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801065a9:	50                   	push   %eax
801065aa:	6a 00                	push   $0x0
801065ac:	e8 7f ef ff ff       	call   80105530 <argint>
  argint(1, &new_priority);
801065b1:	58                   	pop    %eax
801065b2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801065b5:	5a                   	pop    %edx
801065b6:	50                   	push   %eax
801065b7:	6a 01                	push   $0x1
801065b9:	e8 72 ef ff ff       	call   80105530 <argint>
  set_hrrn_priority(pid, new_priority);
801065be:	59                   	pop    %ecx
801065bf:	58                   	pop    %eax
801065c0:	ff 75 f4             	push   -0xc(%ebp)
801065c3:	ff 75 f0             	push   -0x10(%ebp)
801065c6:	e8 95 e1 ff ff       	call   80104760 <set_hrrn_priority>
  return 0;
}
801065cb:	31 c0                	xor    %eax,%eax
801065cd:	c9                   	leave  
801065ce:	c3                   	ret    
801065cf:	90                   	nop

801065d0 <sys_set_ptable_hrrn_priority>:

int sys_set_ptable_hrrn_priority(void)
{
801065d0:	55                   	push   %ebp
801065d1:	89 e5                	mov    %esp,%ebp
801065d3:	83 ec 20             	sub    $0x20,%esp
  int new_priority;
  argint(0, &new_priority);
801065d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801065d9:	50                   	push   %eax
801065da:	6a 00                	push   $0x0
801065dc:	e8 4f ef ff ff       	call   80105530 <argint>
  set_ptable_hrrn_priority(new_priority);
801065e1:	58                   	pop    %eax
801065e2:	ff 75 f4             	push   -0xc(%ebp)
801065e5:	e8 f6 e1 ff ff       	call   801047e0 <set_ptable_hrrn_priority>
  return 0;
}
801065ea:	31 c0                	xor    %eax,%eax
801065ec:	c9                   	leave  
801065ed:	c3                   	ret    
801065ee:	66 90                	xchg   %ax,%ax

801065f0 <sys_print_processes>:

int sys_print_processes(void)
{
801065f0:	55                   	push   %ebp
801065f1:	89 e5                	mov    %esp,%ebp
801065f3:	83 ec 08             	sub    $0x8,%esp
  print_processes();
801065f6:	e8 a5 e2 ff ff       	call   801048a0 <print_processes>
  return 0;
}
801065fb:	31 c0                	xor    %eax,%eax
801065fd:	c9                   	leave  
801065fe:	c3                   	ret    
801065ff:	90                   	nop

80106600 <sys_sem_init>:

int sys_sem_init(void){
80106600:	55                   	push   %ebp
80106601:	89 e5                	mov    %esp,%ebp
80106603:	83 ec 20             	sub    $0x20,%esp
  int i , j;
  argint(0,&i);
80106606:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106609:	50                   	push   %eax
8010660a:	6a 00                	push   $0x0
8010660c:	e8 1f ef ff ff       	call   80105530 <argint>
  argint(1,&j);
80106611:	58                   	pop    %eax
80106612:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106615:	5a                   	pop    %edx
80106616:	50                   	push   %eax
80106617:	6a 01                	push   $0x1
80106619:	e8 12 ef ff ff       	call   80105530 <argint>
  return sem_init(i,j);
8010661e:	59                   	pop    %ecx
8010661f:	58                   	pop    %eax
80106620:	ff 75 f4             	push   -0xc(%ebp)
80106623:	ff 75 f0             	push   -0x10(%ebp)
80106626:	e8 e5 e6 ff ff       	call   80104d10 <sem_init>
}
8010662b:	c9                   	leave  
8010662c:	c3                   	ret    
8010662d:	8d 76 00             	lea    0x0(%esi),%esi

80106630 <sys_sem_acquire>:

int sys_sem_acquire(void){
80106630:	55                   	push   %ebp
80106631:	89 e5                	mov    %esp,%ebp
80106633:	83 ec 20             	sub    $0x20,%esp
  int i;
  argint(0,&i);
80106636:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106639:	50                   	push   %eax
8010663a:	6a 00                	push   $0x0
8010663c:	e8 ef ee ff ff       	call   80105530 <argint>
  return sem_acquire(i);
80106641:	58                   	pop    %eax
80106642:	ff 75 f4             	push   -0xc(%ebp)
80106645:	e8 46 e7 ff ff       	call   80104d90 <sem_acquire>
}
8010664a:	c9                   	leave  
8010664b:	c3                   	ret    
8010664c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106650 <sys_sem_release>:

int sys_sem_release(void){
80106650:	55                   	push   %ebp
80106651:	89 e5                	mov    %esp,%ebp
80106653:	83 ec 20             	sub    $0x20,%esp
  int i;
  argint(0,&i);
80106656:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106659:	50                   	push   %eax
8010665a:	6a 00                	push   $0x0
8010665c:	e8 cf ee ff ff       	call   80105530 <argint>
  return sem_release(i);
80106661:	58                   	pop    %eax
80106662:	ff 75 f4             	push   -0xc(%ebp)
80106665:	e8 a6 e7 ff ff       	call   80104e10 <sem_release>
}
8010666a:	c9                   	leave  
8010666b:	c3                   	ret    

8010666c <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010666c:	1e                   	push   %ds
  pushl %es
8010666d:	06                   	push   %es
  pushl %fs
8010666e:	0f a0                	push   %fs
  pushl %gs
80106670:	0f a8                	push   %gs
  pushal
80106672:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106673:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106677:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106679:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
8010667b:	54                   	push   %esp
  call trap
8010667c:	e8 bf 00 00 00       	call   80106740 <trap>
  addl $4, %esp
80106681:	83 c4 04             	add    $0x4,%esp

80106684 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106684:	61                   	popa   
  popl %gs
80106685:	0f a9                	pop    %gs
  popl %fs
80106687:	0f a1                	pop    %fs
  popl %es
80106689:	07                   	pop    %es
  popl %ds
8010668a:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
8010668b:	83 c4 08             	add    $0x8,%esp
  iret
8010668e:	cf                   	iret   
8010668f:	90                   	nop

80106690 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106690:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106691:	31 c0                	xor    %eax,%eax
{
80106693:	89 e5                	mov    %esp,%ebp
80106695:	83 ec 08             	sub    $0x8,%esp
80106698:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010669f:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801066a0:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
801066a7:	c7 04 c5 42 57 11 80 	movl   $0x8e000008,-0x7feea8be(,%eax,8)
801066ae:	08 00 00 8e 
801066b2:	66 89 14 c5 40 57 11 	mov    %dx,-0x7feea8c0(,%eax,8)
801066b9:	80 
801066ba:	c1 ea 10             	shr    $0x10,%edx
801066bd:	66 89 14 c5 46 57 11 	mov    %dx,-0x7feea8ba(,%eax,8)
801066c4:	80 
  for(i = 0; i < 256; i++)
801066c5:	83 c0 01             	add    $0x1,%eax
801066c8:	3d 00 01 00 00       	cmp    $0x100,%eax
801066cd:	75 d1                	jne    801066a0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
801066cf:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801066d2:	a1 08 b1 10 80       	mov    0x8010b108,%eax
801066d7:	c7 05 42 59 11 80 08 	movl   $0xef000008,0x80115942
801066de:	00 00 ef 
  initlock(&tickslock, "time");
801066e1:	68 97 89 10 80       	push   $0x80108997
801066e6:	68 00 57 11 80       	push   $0x80115700
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801066eb:	66 a3 40 59 11 80    	mov    %ax,0x80115940
801066f1:	c1 e8 10             	shr    $0x10,%eax
801066f4:	66 a3 46 59 11 80    	mov    %ax,0x80115946
  initlock(&tickslock, "time");
801066fa:	e8 e1 e8 ff ff       	call   80104fe0 <initlock>
}
801066ff:	83 c4 10             	add    $0x10,%esp
80106702:	c9                   	leave  
80106703:	c3                   	ret    
80106704:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010670b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010670f:	90                   	nop

80106710 <idtinit>:

void
idtinit(void)
{
80106710:	55                   	push   %ebp
  pd[0] = size-1;
80106711:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106716:	89 e5                	mov    %esp,%ebp
80106718:	83 ec 10             	sub    $0x10,%esp
8010671b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010671f:	b8 40 57 11 80       	mov    $0x80115740,%eax
80106724:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106728:	c1 e8 10             	shr    $0x10,%eax
8010672b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010672f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106732:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106735:	c9                   	leave  
80106736:	c3                   	ret    
80106737:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010673e:	66 90                	xchg   %ax,%ax

80106740 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106740:	55                   	push   %ebp
80106741:	89 e5                	mov    %esp,%ebp
80106743:	57                   	push   %edi
80106744:	56                   	push   %esi
80106745:	53                   	push   %ebx
80106746:	83 ec 1c             	sub    $0x1c,%esp
80106749:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
8010674c:	8b 43 30             	mov    0x30(%ebx),%eax
8010674f:	83 f8 40             	cmp    $0x40,%eax
80106752:	0f 84 68 01 00 00    	je     801068c0 <trap+0x180>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106758:	83 e8 20             	sub    $0x20,%eax
8010675b:	83 f8 1f             	cmp    $0x1f,%eax
8010675e:	0f 87 8c 00 00 00    	ja     801067f0 <trap+0xb0>
80106764:	ff 24 85 40 8a 10 80 	jmp    *-0x7fef75c0(,%eax,4)
8010676b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010676f:	90                   	nop
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106770:	e8 db ba ff ff       	call   80102250 <ideintr>
    lapiceoi();
80106775:	e8 a6 c1 ff ff       	call   80102920 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010677a:	e8 41 d2 ff ff       	call   801039c0 <myproc>
8010677f:	85 c0                	test   %eax,%eax
80106781:	74 1d                	je     801067a0 <trap+0x60>
80106783:	e8 38 d2 ff ff       	call   801039c0 <myproc>
80106788:	8b 50 24             	mov    0x24(%eax),%edx
8010678b:	85 d2                	test   %edx,%edx
8010678d:	74 11                	je     801067a0 <trap+0x60>
8010678f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106793:	83 e0 03             	and    $0x3,%eax
80106796:	66 83 f8 03          	cmp    $0x3,%ax
8010679a:	0f 84 e8 01 00 00    	je     80106988 <trap+0x248>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801067a0:	e8 1b d2 ff ff       	call   801039c0 <myproc>
801067a5:	85 c0                	test   %eax,%eax
801067a7:	74 0f                	je     801067b8 <trap+0x78>
801067a9:	e8 12 d2 ff ff       	call   801039c0 <myproc>
801067ae:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801067b2:	0f 84 b8 00 00 00    	je     80106870 <trap+0x130>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801067b8:	e8 03 d2 ff ff       	call   801039c0 <myproc>
801067bd:	85 c0                	test   %eax,%eax
801067bf:	74 1d                	je     801067de <trap+0x9e>
801067c1:	e8 fa d1 ff ff       	call   801039c0 <myproc>
801067c6:	8b 40 24             	mov    0x24(%eax),%eax
801067c9:	85 c0                	test   %eax,%eax
801067cb:	74 11                	je     801067de <trap+0x9e>
801067cd:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801067d1:	83 e0 03             	and    $0x3,%eax
801067d4:	66 83 f8 03          	cmp    $0x3,%ax
801067d8:	0f 84 0f 01 00 00    	je     801068ed <trap+0x1ad>
    exit();
}
801067de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801067e1:	5b                   	pop    %ebx
801067e2:	5e                   	pop    %esi
801067e3:	5f                   	pop    %edi
801067e4:	5d                   	pop    %ebp
801067e5:	c3                   	ret    
801067e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801067ed:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
801067f0:	e8 cb d1 ff ff       	call   801039c0 <myproc>
801067f5:	8b 7b 38             	mov    0x38(%ebx),%edi
801067f8:	85 c0                	test   %eax,%eax
801067fa:	0f 84 a2 01 00 00    	je     801069a2 <trap+0x262>
80106800:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106804:	0f 84 98 01 00 00    	je     801069a2 <trap+0x262>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010680a:	0f 20 d1             	mov    %cr2,%ecx
8010680d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106810:	e8 8b d1 ff ff       	call   801039a0 <cpuid>
80106815:	8b 73 30             	mov    0x30(%ebx),%esi
80106818:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010681b:	8b 43 34             	mov    0x34(%ebx),%eax
8010681e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80106821:	e8 9a d1 ff ff       	call   801039c0 <myproc>
80106826:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106829:	e8 92 d1 ff ff       	call   801039c0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010682e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106831:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106834:	51                   	push   %ecx
80106835:	57                   	push   %edi
80106836:	52                   	push   %edx
80106837:	ff 75 e4             	push   -0x1c(%ebp)
8010683a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010683b:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010683e:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106841:	56                   	push   %esi
80106842:	ff 70 10             	push   0x10(%eax)
80106845:	68 fc 89 10 80       	push   $0x801089fc
8010684a:	e8 51 9e ff ff       	call   801006a0 <cprintf>
    myproc()->killed = 1;
8010684f:	83 c4 20             	add    $0x20,%esp
80106852:	e8 69 d1 ff ff       	call   801039c0 <myproc>
80106857:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010685e:	e8 5d d1 ff ff       	call   801039c0 <myproc>
80106863:	85 c0                	test   %eax,%eax
80106865:	0f 85 18 ff ff ff    	jne    80106783 <trap+0x43>
8010686b:	e9 30 ff ff ff       	jmp    801067a0 <trap+0x60>
  if(myproc() && myproc()->state == RUNNING &&
80106870:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106874:	0f 85 3e ff ff ff    	jne    801067b8 <trap+0x78>
    yield();
8010687a:	e8 a1 da ff ff       	call   80104320 <yield>
8010687f:	e9 34 ff ff ff       	jmp    801067b8 <trap+0x78>
80106884:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106888:	8b 7b 38             	mov    0x38(%ebx),%edi
8010688b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
8010688f:	e8 0c d1 ff ff       	call   801039a0 <cpuid>
80106894:	57                   	push   %edi
80106895:	56                   	push   %esi
80106896:	50                   	push   %eax
80106897:	68 a4 89 10 80       	push   $0x801089a4
8010689c:	e8 ff 9d ff ff       	call   801006a0 <cprintf>
    lapiceoi();
801068a1:	e8 7a c0 ff ff       	call   80102920 <lapiceoi>
    break;
801068a6:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801068a9:	e8 12 d1 ff ff       	call   801039c0 <myproc>
801068ae:	85 c0                	test   %eax,%eax
801068b0:	0f 85 cd fe ff ff    	jne    80106783 <trap+0x43>
801068b6:	e9 e5 fe ff ff       	jmp    801067a0 <trap+0x60>
801068bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801068bf:	90                   	nop
    if(myproc()->killed)
801068c0:	e8 fb d0 ff ff       	call   801039c0 <myproc>
801068c5:	8b 70 24             	mov    0x24(%eax),%esi
801068c8:	85 f6                	test   %esi,%esi
801068ca:	0f 85 c8 00 00 00    	jne    80106998 <trap+0x258>
    myproc()->tf = tf;
801068d0:	e8 eb d0 ff ff       	call   801039c0 <myproc>
801068d5:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
801068d8:	e8 93 ed ff ff       	call   80105670 <syscall>
    if(myproc()->killed)
801068dd:	e8 de d0 ff ff       	call   801039c0 <myproc>
801068e2:	8b 48 24             	mov    0x24(%eax),%ecx
801068e5:	85 c9                	test   %ecx,%ecx
801068e7:	0f 84 f1 fe ff ff    	je     801067de <trap+0x9e>
}
801068ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068f0:	5b                   	pop    %ebx
801068f1:	5e                   	pop    %esi
801068f2:	5f                   	pop    %edi
801068f3:	5d                   	pop    %ebp
      exit();
801068f4:	e9 c7 d7 ff ff       	jmp    801040c0 <exit>
801068f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106900:	e8 3b 02 00 00       	call   80106b40 <uartintr>
    lapiceoi();
80106905:	e8 16 c0 ff ff       	call   80102920 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010690a:	e8 b1 d0 ff ff       	call   801039c0 <myproc>
8010690f:	85 c0                	test   %eax,%eax
80106911:	0f 85 6c fe ff ff    	jne    80106783 <trap+0x43>
80106917:	e9 84 fe ff ff       	jmp    801067a0 <trap+0x60>
8010691c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106920:	e8 bb be ff ff       	call   801027e0 <kbdintr>
    lapiceoi();
80106925:	e8 f6 bf ff ff       	call   80102920 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010692a:	e8 91 d0 ff ff       	call   801039c0 <myproc>
8010692f:	85 c0                	test   %eax,%eax
80106931:	0f 85 4c fe ff ff    	jne    80106783 <trap+0x43>
80106937:	e9 64 fe ff ff       	jmp    801067a0 <trap+0x60>
8010693c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80106940:	e8 5b d0 ff ff       	call   801039a0 <cpuid>
80106945:	85 c0                	test   %eax,%eax
80106947:	0f 85 28 fe ff ff    	jne    80106775 <trap+0x35>
      acquire(&tickslock);
8010694d:	83 ec 0c             	sub    $0xc,%esp
80106950:	68 00 57 11 80       	push   $0x80115700
80106955:	e8 56 e8 ff ff       	call   801051b0 <acquire>
      wakeup(&ticks);
8010695a:	c7 04 24 e0 56 11 80 	movl   $0x801156e0,(%esp)
      ticks++;
80106961:	83 05 e0 56 11 80 01 	addl   $0x1,0x801156e0
      wakeup(&ticks);
80106968:	e8 03 db ff ff       	call   80104470 <wakeup>
      release(&tickslock);
8010696d:	c7 04 24 00 57 11 80 	movl   $0x80115700,(%esp)
80106974:	e8 d7 e7 ff ff       	call   80105150 <release>
80106979:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
8010697c:	e9 f4 fd ff ff       	jmp    80106775 <trap+0x35>
80106981:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80106988:	e8 33 d7 ff ff       	call   801040c0 <exit>
8010698d:	e9 0e fe ff ff       	jmp    801067a0 <trap+0x60>
80106992:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106998:	e8 23 d7 ff ff       	call   801040c0 <exit>
8010699d:	e9 2e ff ff ff       	jmp    801068d0 <trap+0x190>
801069a2:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801069a5:	e8 f6 cf ff ff       	call   801039a0 <cpuid>
801069aa:	83 ec 0c             	sub    $0xc,%esp
801069ad:	56                   	push   %esi
801069ae:	57                   	push   %edi
801069af:	50                   	push   %eax
801069b0:	ff 73 30             	push   0x30(%ebx)
801069b3:	68 c8 89 10 80       	push   $0x801089c8
801069b8:	e8 e3 9c ff ff       	call   801006a0 <cprintf>
      panic("trap");
801069bd:	83 c4 14             	add    $0x14,%esp
801069c0:	68 9c 89 10 80       	push   $0x8010899c
801069c5:	e8 b6 99 ff ff       	call   80100380 <panic>
801069ca:	66 90                	xchg   %ax,%ax
801069cc:	66 90                	xchg   %ax,%ax
801069ce:	66 90                	xchg   %ax,%ax

801069d0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801069d0:	a1 40 5f 11 80       	mov    0x80115f40,%eax
801069d5:	85 c0                	test   %eax,%eax
801069d7:	74 17                	je     801069f0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801069d9:	ba fd 03 00 00       	mov    $0x3fd,%edx
801069de:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801069df:	a8 01                	test   $0x1,%al
801069e1:	74 0d                	je     801069f0 <uartgetc+0x20>
801069e3:	ba f8 03 00 00       	mov    $0x3f8,%edx
801069e8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801069e9:	0f b6 c0             	movzbl %al,%eax
801069ec:	c3                   	ret    
801069ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801069f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801069f5:	c3                   	ret    
801069f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069fd:	8d 76 00             	lea    0x0(%esi),%esi

80106a00 <uartinit>:
{
80106a00:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106a01:	31 c9                	xor    %ecx,%ecx
80106a03:	89 c8                	mov    %ecx,%eax
80106a05:	89 e5                	mov    %esp,%ebp
80106a07:	57                   	push   %edi
80106a08:	bf fa 03 00 00       	mov    $0x3fa,%edi
80106a0d:	56                   	push   %esi
80106a0e:	89 fa                	mov    %edi,%edx
80106a10:	53                   	push   %ebx
80106a11:	83 ec 1c             	sub    $0x1c,%esp
80106a14:	ee                   	out    %al,(%dx)
80106a15:	be fb 03 00 00       	mov    $0x3fb,%esi
80106a1a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80106a1f:	89 f2                	mov    %esi,%edx
80106a21:	ee                   	out    %al,(%dx)
80106a22:	b8 0c 00 00 00       	mov    $0xc,%eax
80106a27:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106a2c:	ee                   	out    %al,(%dx)
80106a2d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80106a32:	89 c8                	mov    %ecx,%eax
80106a34:	89 da                	mov    %ebx,%edx
80106a36:	ee                   	out    %al,(%dx)
80106a37:	b8 03 00 00 00       	mov    $0x3,%eax
80106a3c:	89 f2                	mov    %esi,%edx
80106a3e:	ee                   	out    %al,(%dx)
80106a3f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106a44:	89 c8                	mov    %ecx,%eax
80106a46:	ee                   	out    %al,(%dx)
80106a47:	b8 01 00 00 00       	mov    $0x1,%eax
80106a4c:	89 da                	mov    %ebx,%edx
80106a4e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106a4f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106a54:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106a55:	3c ff                	cmp    $0xff,%al
80106a57:	74 78                	je     80106ad1 <uartinit+0xd1>
  uart = 1;
80106a59:	c7 05 40 5f 11 80 01 	movl   $0x1,0x80115f40
80106a60:	00 00 00 
80106a63:	89 fa                	mov    %edi,%edx
80106a65:	ec                   	in     (%dx),%al
80106a66:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106a6b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106a6c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80106a6f:	bf c0 8a 10 80       	mov    $0x80108ac0,%edi
80106a74:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
80106a79:	6a 00                	push   $0x0
80106a7b:	6a 04                	push   $0x4
80106a7d:	e8 0e ba ff ff       	call   80102490 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80106a82:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
  ioapicenable(IRQ_COM1, 0);
80106a86:	83 c4 10             	add    $0x10,%esp
80106a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
80106a90:	a1 40 5f 11 80       	mov    0x80115f40,%eax
80106a95:	bb 80 00 00 00       	mov    $0x80,%ebx
80106a9a:	85 c0                	test   %eax,%eax
80106a9c:	75 14                	jne    80106ab2 <uartinit+0xb2>
80106a9e:	eb 23                	jmp    80106ac3 <uartinit+0xc3>
    microdelay(10);
80106aa0:	83 ec 0c             	sub    $0xc,%esp
80106aa3:	6a 0a                	push   $0xa
80106aa5:	e8 96 be ff ff       	call   80102940 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106aaa:	83 c4 10             	add    $0x10,%esp
80106aad:	83 eb 01             	sub    $0x1,%ebx
80106ab0:	74 07                	je     80106ab9 <uartinit+0xb9>
80106ab2:	89 f2                	mov    %esi,%edx
80106ab4:	ec                   	in     (%dx),%al
80106ab5:	a8 20                	test   $0x20,%al
80106ab7:	74 e7                	je     80106aa0 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106ab9:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80106abd:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106ac2:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80106ac3:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80106ac7:	83 c7 01             	add    $0x1,%edi
80106aca:	88 45 e7             	mov    %al,-0x19(%ebp)
80106acd:	84 c0                	test   %al,%al
80106acf:	75 bf                	jne    80106a90 <uartinit+0x90>
}
80106ad1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ad4:	5b                   	pop    %ebx
80106ad5:	5e                   	pop    %esi
80106ad6:	5f                   	pop    %edi
80106ad7:	5d                   	pop    %ebp
80106ad8:	c3                   	ret    
80106ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ae0 <uartputc>:
  if(!uart)
80106ae0:	a1 40 5f 11 80       	mov    0x80115f40,%eax
80106ae5:	85 c0                	test   %eax,%eax
80106ae7:	74 47                	je     80106b30 <uartputc+0x50>
{
80106ae9:	55                   	push   %ebp
80106aea:	89 e5                	mov    %esp,%ebp
80106aec:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106aed:	be fd 03 00 00       	mov    $0x3fd,%esi
80106af2:	53                   	push   %ebx
80106af3:	bb 80 00 00 00       	mov    $0x80,%ebx
80106af8:	eb 18                	jmp    80106b12 <uartputc+0x32>
80106afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80106b00:	83 ec 0c             	sub    $0xc,%esp
80106b03:	6a 0a                	push   $0xa
80106b05:	e8 36 be ff ff       	call   80102940 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106b0a:	83 c4 10             	add    $0x10,%esp
80106b0d:	83 eb 01             	sub    $0x1,%ebx
80106b10:	74 07                	je     80106b19 <uartputc+0x39>
80106b12:	89 f2                	mov    %esi,%edx
80106b14:	ec                   	in     (%dx),%al
80106b15:	a8 20                	test   $0x20,%al
80106b17:	74 e7                	je     80106b00 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106b19:	8b 45 08             	mov    0x8(%ebp),%eax
80106b1c:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106b21:	ee                   	out    %al,(%dx)
}
80106b22:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106b25:	5b                   	pop    %ebx
80106b26:	5e                   	pop    %esi
80106b27:	5d                   	pop    %ebp
80106b28:	c3                   	ret    
80106b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b30:	c3                   	ret    
80106b31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b3f:	90                   	nop

80106b40 <uartintr>:

void
uartintr(void)
{
80106b40:	55                   	push   %ebp
80106b41:	89 e5                	mov    %esp,%ebp
80106b43:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106b46:	68 d0 69 10 80       	push   $0x801069d0
80106b4b:	e8 30 9d ff ff       	call   80100880 <consoleintr>
}
80106b50:	83 c4 10             	add    $0x10,%esp
80106b53:	c9                   	leave  
80106b54:	c3                   	ret    

80106b55 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106b55:	6a 00                	push   $0x0
  pushl $0
80106b57:	6a 00                	push   $0x0
  jmp alltraps
80106b59:	e9 0e fb ff ff       	jmp    8010666c <alltraps>

80106b5e <vector1>:
.globl vector1
vector1:
  pushl $0
80106b5e:	6a 00                	push   $0x0
  pushl $1
80106b60:	6a 01                	push   $0x1
  jmp alltraps
80106b62:	e9 05 fb ff ff       	jmp    8010666c <alltraps>

80106b67 <vector2>:
.globl vector2
vector2:
  pushl $0
80106b67:	6a 00                	push   $0x0
  pushl $2
80106b69:	6a 02                	push   $0x2
  jmp alltraps
80106b6b:	e9 fc fa ff ff       	jmp    8010666c <alltraps>

80106b70 <vector3>:
.globl vector3
vector3:
  pushl $0
80106b70:	6a 00                	push   $0x0
  pushl $3
80106b72:	6a 03                	push   $0x3
  jmp alltraps
80106b74:	e9 f3 fa ff ff       	jmp    8010666c <alltraps>

80106b79 <vector4>:
.globl vector4
vector4:
  pushl $0
80106b79:	6a 00                	push   $0x0
  pushl $4
80106b7b:	6a 04                	push   $0x4
  jmp alltraps
80106b7d:	e9 ea fa ff ff       	jmp    8010666c <alltraps>

80106b82 <vector5>:
.globl vector5
vector5:
  pushl $0
80106b82:	6a 00                	push   $0x0
  pushl $5
80106b84:	6a 05                	push   $0x5
  jmp alltraps
80106b86:	e9 e1 fa ff ff       	jmp    8010666c <alltraps>

80106b8b <vector6>:
.globl vector6
vector6:
  pushl $0
80106b8b:	6a 00                	push   $0x0
  pushl $6
80106b8d:	6a 06                	push   $0x6
  jmp alltraps
80106b8f:	e9 d8 fa ff ff       	jmp    8010666c <alltraps>

80106b94 <vector7>:
.globl vector7
vector7:
  pushl $0
80106b94:	6a 00                	push   $0x0
  pushl $7
80106b96:	6a 07                	push   $0x7
  jmp alltraps
80106b98:	e9 cf fa ff ff       	jmp    8010666c <alltraps>

80106b9d <vector8>:
.globl vector8
vector8:
  pushl $8
80106b9d:	6a 08                	push   $0x8
  jmp alltraps
80106b9f:	e9 c8 fa ff ff       	jmp    8010666c <alltraps>

80106ba4 <vector9>:
.globl vector9
vector9:
  pushl $0
80106ba4:	6a 00                	push   $0x0
  pushl $9
80106ba6:	6a 09                	push   $0x9
  jmp alltraps
80106ba8:	e9 bf fa ff ff       	jmp    8010666c <alltraps>

80106bad <vector10>:
.globl vector10
vector10:
  pushl $10
80106bad:	6a 0a                	push   $0xa
  jmp alltraps
80106baf:	e9 b8 fa ff ff       	jmp    8010666c <alltraps>

80106bb4 <vector11>:
.globl vector11
vector11:
  pushl $11
80106bb4:	6a 0b                	push   $0xb
  jmp alltraps
80106bb6:	e9 b1 fa ff ff       	jmp    8010666c <alltraps>

80106bbb <vector12>:
.globl vector12
vector12:
  pushl $12
80106bbb:	6a 0c                	push   $0xc
  jmp alltraps
80106bbd:	e9 aa fa ff ff       	jmp    8010666c <alltraps>

80106bc2 <vector13>:
.globl vector13
vector13:
  pushl $13
80106bc2:	6a 0d                	push   $0xd
  jmp alltraps
80106bc4:	e9 a3 fa ff ff       	jmp    8010666c <alltraps>

80106bc9 <vector14>:
.globl vector14
vector14:
  pushl $14
80106bc9:	6a 0e                	push   $0xe
  jmp alltraps
80106bcb:	e9 9c fa ff ff       	jmp    8010666c <alltraps>

80106bd0 <vector15>:
.globl vector15
vector15:
  pushl $0
80106bd0:	6a 00                	push   $0x0
  pushl $15
80106bd2:	6a 0f                	push   $0xf
  jmp alltraps
80106bd4:	e9 93 fa ff ff       	jmp    8010666c <alltraps>

80106bd9 <vector16>:
.globl vector16
vector16:
  pushl $0
80106bd9:	6a 00                	push   $0x0
  pushl $16
80106bdb:	6a 10                	push   $0x10
  jmp alltraps
80106bdd:	e9 8a fa ff ff       	jmp    8010666c <alltraps>

80106be2 <vector17>:
.globl vector17
vector17:
  pushl $17
80106be2:	6a 11                	push   $0x11
  jmp alltraps
80106be4:	e9 83 fa ff ff       	jmp    8010666c <alltraps>

80106be9 <vector18>:
.globl vector18
vector18:
  pushl $0
80106be9:	6a 00                	push   $0x0
  pushl $18
80106beb:	6a 12                	push   $0x12
  jmp alltraps
80106bed:	e9 7a fa ff ff       	jmp    8010666c <alltraps>

80106bf2 <vector19>:
.globl vector19
vector19:
  pushl $0
80106bf2:	6a 00                	push   $0x0
  pushl $19
80106bf4:	6a 13                	push   $0x13
  jmp alltraps
80106bf6:	e9 71 fa ff ff       	jmp    8010666c <alltraps>

80106bfb <vector20>:
.globl vector20
vector20:
  pushl $0
80106bfb:	6a 00                	push   $0x0
  pushl $20
80106bfd:	6a 14                	push   $0x14
  jmp alltraps
80106bff:	e9 68 fa ff ff       	jmp    8010666c <alltraps>

80106c04 <vector21>:
.globl vector21
vector21:
  pushl $0
80106c04:	6a 00                	push   $0x0
  pushl $21
80106c06:	6a 15                	push   $0x15
  jmp alltraps
80106c08:	e9 5f fa ff ff       	jmp    8010666c <alltraps>

80106c0d <vector22>:
.globl vector22
vector22:
  pushl $0
80106c0d:	6a 00                	push   $0x0
  pushl $22
80106c0f:	6a 16                	push   $0x16
  jmp alltraps
80106c11:	e9 56 fa ff ff       	jmp    8010666c <alltraps>

80106c16 <vector23>:
.globl vector23
vector23:
  pushl $0
80106c16:	6a 00                	push   $0x0
  pushl $23
80106c18:	6a 17                	push   $0x17
  jmp alltraps
80106c1a:	e9 4d fa ff ff       	jmp    8010666c <alltraps>

80106c1f <vector24>:
.globl vector24
vector24:
  pushl $0
80106c1f:	6a 00                	push   $0x0
  pushl $24
80106c21:	6a 18                	push   $0x18
  jmp alltraps
80106c23:	e9 44 fa ff ff       	jmp    8010666c <alltraps>

80106c28 <vector25>:
.globl vector25
vector25:
  pushl $0
80106c28:	6a 00                	push   $0x0
  pushl $25
80106c2a:	6a 19                	push   $0x19
  jmp alltraps
80106c2c:	e9 3b fa ff ff       	jmp    8010666c <alltraps>

80106c31 <vector26>:
.globl vector26
vector26:
  pushl $0
80106c31:	6a 00                	push   $0x0
  pushl $26
80106c33:	6a 1a                	push   $0x1a
  jmp alltraps
80106c35:	e9 32 fa ff ff       	jmp    8010666c <alltraps>

80106c3a <vector27>:
.globl vector27
vector27:
  pushl $0
80106c3a:	6a 00                	push   $0x0
  pushl $27
80106c3c:	6a 1b                	push   $0x1b
  jmp alltraps
80106c3e:	e9 29 fa ff ff       	jmp    8010666c <alltraps>

80106c43 <vector28>:
.globl vector28
vector28:
  pushl $0
80106c43:	6a 00                	push   $0x0
  pushl $28
80106c45:	6a 1c                	push   $0x1c
  jmp alltraps
80106c47:	e9 20 fa ff ff       	jmp    8010666c <alltraps>

80106c4c <vector29>:
.globl vector29
vector29:
  pushl $0
80106c4c:	6a 00                	push   $0x0
  pushl $29
80106c4e:	6a 1d                	push   $0x1d
  jmp alltraps
80106c50:	e9 17 fa ff ff       	jmp    8010666c <alltraps>

80106c55 <vector30>:
.globl vector30
vector30:
  pushl $0
80106c55:	6a 00                	push   $0x0
  pushl $30
80106c57:	6a 1e                	push   $0x1e
  jmp alltraps
80106c59:	e9 0e fa ff ff       	jmp    8010666c <alltraps>

80106c5e <vector31>:
.globl vector31
vector31:
  pushl $0
80106c5e:	6a 00                	push   $0x0
  pushl $31
80106c60:	6a 1f                	push   $0x1f
  jmp alltraps
80106c62:	e9 05 fa ff ff       	jmp    8010666c <alltraps>

80106c67 <vector32>:
.globl vector32
vector32:
  pushl $0
80106c67:	6a 00                	push   $0x0
  pushl $32
80106c69:	6a 20                	push   $0x20
  jmp alltraps
80106c6b:	e9 fc f9 ff ff       	jmp    8010666c <alltraps>

80106c70 <vector33>:
.globl vector33
vector33:
  pushl $0
80106c70:	6a 00                	push   $0x0
  pushl $33
80106c72:	6a 21                	push   $0x21
  jmp alltraps
80106c74:	e9 f3 f9 ff ff       	jmp    8010666c <alltraps>

80106c79 <vector34>:
.globl vector34
vector34:
  pushl $0
80106c79:	6a 00                	push   $0x0
  pushl $34
80106c7b:	6a 22                	push   $0x22
  jmp alltraps
80106c7d:	e9 ea f9 ff ff       	jmp    8010666c <alltraps>

80106c82 <vector35>:
.globl vector35
vector35:
  pushl $0
80106c82:	6a 00                	push   $0x0
  pushl $35
80106c84:	6a 23                	push   $0x23
  jmp alltraps
80106c86:	e9 e1 f9 ff ff       	jmp    8010666c <alltraps>

80106c8b <vector36>:
.globl vector36
vector36:
  pushl $0
80106c8b:	6a 00                	push   $0x0
  pushl $36
80106c8d:	6a 24                	push   $0x24
  jmp alltraps
80106c8f:	e9 d8 f9 ff ff       	jmp    8010666c <alltraps>

80106c94 <vector37>:
.globl vector37
vector37:
  pushl $0
80106c94:	6a 00                	push   $0x0
  pushl $37
80106c96:	6a 25                	push   $0x25
  jmp alltraps
80106c98:	e9 cf f9 ff ff       	jmp    8010666c <alltraps>

80106c9d <vector38>:
.globl vector38
vector38:
  pushl $0
80106c9d:	6a 00                	push   $0x0
  pushl $38
80106c9f:	6a 26                	push   $0x26
  jmp alltraps
80106ca1:	e9 c6 f9 ff ff       	jmp    8010666c <alltraps>

80106ca6 <vector39>:
.globl vector39
vector39:
  pushl $0
80106ca6:	6a 00                	push   $0x0
  pushl $39
80106ca8:	6a 27                	push   $0x27
  jmp alltraps
80106caa:	e9 bd f9 ff ff       	jmp    8010666c <alltraps>

80106caf <vector40>:
.globl vector40
vector40:
  pushl $0
80106caf:	6a 00                	push   $0x0
  pushl $40
80106cb1:	6a 28                	push   $0x28
  jmp alltraps
80106cb3:	e9 b4 f9 ff ff       	jmp    8010666c <alltraps>

80106cb8 <vector41>:
.globl vector41
vector41:
  pushl $0
80106cb8:	6a 00                	push   $0x0
  pushl $41
80106cba:	6a 29                	push   $0x29
  jmp alltraps
80106cbc:	e9 ab f9 ff ff       	jmp    8010666c <alltraps>

80106cc1 <vector42>:
.globl vector42
vector42:
  pushl $0
80106cc1:	6a 00                	push   $0x0
  pushl $42
80106cc3:	6a 2a                	push   $0x2a
  jmp alltraps
80106cc5:	e9 a2 f9 ff ff       	jmp    8010666c <alltraps>

80106cca <vector43>:
.globl vector43
vector43:
  pushl $0
80106cca:	6a 00                	push   $0x0
  pushl $43
80106ccc:	6a 2b                	push   $0x2b
  jmp alltraps
80106cce:	e9 99 f9 ff ff       	jmp    8010666c <alltraps>

80106cd3 <vector44>:
.globl vector44
vector44:
  pushl $0
80106cd3:	6a 00                	push   $0x0
  pushl $44
80106cd5:	6a 2c                	push   $0x2c
  jmp alltraps
80106cd7:	e9 90 f9 ff ff       	jmp    8010666c <alltraps>

80106cdc <vector45>:
.globl vector45
vector45:
  pushl $0
80106cdc:	6a 00                	push   $0x0
  pushl $45
80106cde:	6a 2d                	push   $0x2d
  jmp alltraps
80106ce0:	e9 87 f9 ff ff       	jmp    8010666c <alltraps>

80106ce5 <vector46>:
.globl vector46
vector46:
  pushl $0
80106ce5:	6a 00                	push   $0x0
  pushl $46
80106ce7:	6a 2e                	push   $0x2e
  jmp alltraps
80106ce9:	e9 7e f9 ff ff       	jmp    8010666c <alltraps>

80106cee <vector47>:
.globl vector47
vector47:
  pushl $0
80106cee:	6a 00                	push   $0x0
  pushl $47
80106cf0:	6a 2f                	push   $0x2f
  jmp alltraps
80106cf2:	e9 75 f9 ff ff       	jmp    8010666c <alltraps>

80106cf7 <vector48>:
.globl vector48
vector48:
  pushl $0
80106cf7:	6a 00                	push   $0x0
  pushl $48
80106cf9:	6a 30                	push   $0x30
  jmp alltraps
80106cfb:	e9 6c f9 ff ff       	jmp    8010666c <alltraps>

80106d00 <vector49>:
.globl vector49
vector49:
  pushl $0
80106d00:	6a 00                	push   $0x0
  pushl $49
80106d02:	6a 31                	push   $0x31
  jmp alltraps
80106d04:	e9 63 f9 ff ff       	jmp    8010666c <alltraps>

80106d09 <vector50>:
.globl vector50
vector50:
  pushl $0
80106d09:	6a 00                	push   $0x0
  pushl $50
80106d0b:	6a 32                	push   $0x32
  jmp alltraps
80106d0d:	e9 5a f9 ff ff       	jmp    8010666c <alltraps>

80106d12 <vector51>:
.globl vector51
vector51:
  pushl $0
80106d12:	6a 00                	push   $0x0
  pushl $51
80106d14:	6a 33                	push   $0x33
  jmp alltraps
80106d16:	e9 51 f9 ff ff       	jmp    8010666c <alltraps>

80106d1b <vector52>:
.globl vector52
vector52:
  pushl $0
80106d1b:	6a 00                	push   $0x0
  pushl $52
80106d1d:	6a 34                	push   $0x34
  jmp alltraps
80106d1f:	e9 48 f9 ff ff       	jmp    8010666c <alltraps>

80106d24 <vector53>:
.globl vector53
vector53:
  pushl $0
80106d24:	6a 00                	push   $0x0
  pushl $53
80106d26:	6a 35                	push   $0x35
  jmp alltraps
80106d28:	e9 3f f9 ff ff       	jmp    8010666c <alltraps>

80106d2d <vector54>:
.globl vector54
vector54:
  pushl $0
80106d2d:	6a 00                	push   $0x0
  pushl $54
80106d2f:	6a 36                	push   $0x36
  jmp alltraps
80106d31:	e9 36 f9 ff ff       	jmp    8010666c <alltraps>

80106d36 <vector55>:
.globl vector55
vector55:
  pushl $0
80106d36:	6a 00                	push   $0x0
  pushl $55
80106d38:	6a 37                	push   $0x37
  jmp alltraps
80106d3a:	e9 2d f9 ff ff       	jmp    8010666c <alltraps>

80106d3f <vector56>:
.globl vector56
vector56:
  pushl $0
80106d3f:	6a 00                	push   $0x0
  pushl $56
80106d41:	6a 38                	push   $0x38
  jmp alltraps
80106d43:	e9 24 f9 ff ff       	jmp    8010666c <alltraps>

80106d48 <vector57>:
.globl vector57
vector57:
  pushl $0
80106d48:	6a 00                	push   $0x0
  pushl $57
80106d4a:	6a 39                	push   $0x39
  jmp alltraps
80106d4c:	e9 1b f9 ff ff       	jmp    8010666c <alltraps>

80106d51 <vector58>:
.globl vector58
vector58:
  pushl $0
80106d51:	6a 00                	push   $0x0
  pushl $58
80106d53:	6a 3a                	push   $0x3a
  jmp alltraps
80106d55:	e9 12 f9 ff ff       	jmp    8010666c <alltraps>

80106d5a <vector59>:
.globl vector59
vector59:
  pushl $0
80106d5a:	6a 00                	push   $0x0
  pushl $59
80106d5c:	6a 3b                	push   $0x3b
  jmp alltraps
80106d5e:	e9 09 f9 ff ff       	jmp    8010666c <alltraps>

80106d63 <vector60>:
.globl vector60
vector60:
  pushl $0
80106d63:	6a 00                	push   $0x0
  pushl $60
80106d65:	6a 3c                	push   $0x3c
  jmp alltraps
80106d67:	e9 00 f9 ff ff       	jmp    8010666c <alltraps>

80106d6c <vector61>:
.globl vector61
vector61:
  pushl $0
80106d6c:	6a 00                	push   $0x0
  pushl $61
80106d6e:	6a 3d                	push   $0x3d
  jmp alltraps
80106d70:	e9 f7 f8 ff ff       	jmp    8010666c <alltraps>

80106d75 <vector62>:
.globl vector62
vector62:
  pushl $0
80106d75:	6a 00                	push   $0x0
  pushl $62
80106d77:	6a 3e                	push   $0x3e
  jmp alltraps
80106d79:	e9 ee f8 ff ff       	jmp    8010666c <alltraps>

80106d7e <vector63>:
.globl vector63
vector63:
  pushl $0
80106d7e:	6a 00                	push   $0x0
  pushl $63
80106d80:	6a 3f                	push   $0x3f
  jmp alltraps
80106d82:	e9 e5 f8 ff ff       	jmp    8010666c <alltraps>

80106d87 <vector64>:
.globl vector64
vector64:
  pushl $0
80106d87:	6a 00                	push   $0x0
  pushl $64
80106d89:	6a 40                	push   $0x40
  jmp alltraps
80106d8b:	e9 dc f8 ff ff       	jmp    8010666c <alltraps>

80106d90 <vector65>:
.globl vector65
vector65:
  pushl $0
80106d90:	6a 00                	push   $0x0
  pushl $65
80106d92:	6a 41                	push   $0x41
  jmp alltraps
80106d94:	e9 d3 f8 ff ff       	jmp    8010666c <alltraps>

80106d99 <vector66>:
.globl vector66
vector66:
  pushl $0
80106d99:	6a 00                	push   $0x0
  pushl $66
80106d9b:	6a 42                	push   $0x42
  jmp alltraps
80106d9d:	e9 ca f8 ff ff       	jmp    8010666c <alltraps>

80106da2 <vector67>:
.globl vector67
vector67:
  pushl $0
80106da2:	6a 00                	push   $0x0
  pushl $67
80106da4:	6a 43                	push   $0x43
  jmp alltraps
80106da6:	e9 c1 f8 ff ff       	jmp    8010666c <alltraps>

80106dab <vector68>:
.globl vector68
vector68:
  pushl $0
80106dab:	6a 00                	push   $0x0
  pushl $68
80106dad:	6a 44                	push   $0x44
  jmp alltraps
80106daf:	e9 b8 f8 ff ff       	jmp    8010666c <alltraps>

80106db4 <vector69>:
.globl vector69
vector69:
  pushl $0
80106db4:	6a 00                	push   $0x0
  pushl $69
80106db6:	6a 45                	push   $0x45
  jmp alltraps
80106db8:	e9 af f8 ff ff       	jmp    8010666c <alltraps>

80106dbd <vector70>:
.globl vector70
vector70:
  pushl $0
80106dbd:	6a 00                	push   $0x0
  pushl $70
80106dbf:	6a 46                	push   $0x46
  jmp alltraps
80106dc1:	e9 a6 f8 ff ff       	jmp    8010666c <alltraps>

80106dc6 <vector71>:
.globl vector71
vector71:
  pushl $0
80106dc6:	6a 00                	push   $0x0
  pushl $71
80106dc8:	6a 47                	push   $0x47
  jmp alltraps
80106dca:	e9 9d f8 ff ff       	jmp    8010666c <alltraps>

80106dcf <vector72>:
.globl vector72
vector72:
  pushl $0
80106dcf:	6a 00                	push   $0x0
  pushl $72
80106dd1:	6a 48                	push   $0x48
  jmp alltraps
80106dd3:	e9 94 f8 ff ff       	jmp    8010666c <alltraps>

80106dd8 <vector73>:
.globl vector73
vector73:
  pushl $0
80106dd8:	6a 00                	push   $0x0
  pushl $73
80106dda:	6a 49                	push   $0x49
  jmp alltraps
80106ddc:	e9 8b f8 ff ff       	jmp    8010666c <alltraps>

80106de1 <vector74>:
.globl vector74
vector74:
  pushl $0
80106de1:	6a 00                	push   $0x0
  pushl $74
80106de3:	6a 4a                	push   $0x4a
  jmp alltraps
80106de5:	e9 82 f8 ff ff       	jmp    8010666c <alltraps>

80106dea <vector75>:
.globl vector75
vector75:
  pushl $0
80106dea:	6a 00                	push   $0x0
  pushl $75
80106dec:	6a 4b                	push   $0x4b
  jmp alltraps
80106dee:	e9 79 f8 ff ff       	jmp    8010666c <alltraps>

80106df3 <vector76>:
.globl vector76
vector76:
  pushl $0
80106df3:	6a 00                	push   $0x0
  pushl $76
80106df5:	6a 4c                	push   $0x4c
  jmp alltraps
80106df7:	e9 70 f8 ff ff       	jmp    8010666c <alltraps>

80106dfc <vector77>:
.globl vector77
vector77:
  pushl $0
80106dfc:	6a 00                	push   $0x0
  pushl $77
80106dfe:	6a 4d                	push   $0x4d
  jmp alltraps
80106e00:	e9 67 f8 ff ff       	jmp    8010666c <alltraps>

80106e05 <vector78>:
.globl vector78
vector78:
  pushl $0
80106e05:	6a 00                	push   $0x0
  pushl $78
80106e07:	6a 4e                	push   $0x4e
  jmp alltraps
80106e09:	e9 5e f8 ff ff       	jmp    8010666c <alltraps>

80106e0e <vector79>:
.globl vector79
vector79:
  pushl $0
80106e0e:	6a 00                	push   $0x0
  pushl $79
80106e10:	6a 4f                	push   $0x4f
  jmp alltraps
80106e12:	e9 55 f8 ff ff       	jmp    8010666c <alltraps>

80106e17 <vector80>:
.globl vector80
vector80:
  pushl $0
80106e17:	6a 00                	push   $0x0
  pushl $80
80106e19:	6a 50                	push   $0x50
  jmp alltraps
80106e1b:	e9 4c f8 ff ff       	jmp    8010666c <alltraps>

80106e20 <vector81>:
.globl vector81
vector81:
  pushl $0
80106e20:	6a 00                	push   $0x0
  pushl $81
80106e22:	6a 51                	push   $0x51
  jmp alltraps
80106e24:	e9 43 f8 ff ff       	jmp    8010666c <alltraps>

80106e29 <vector82>:
.globl vector82
vector82:
  pushl $0
80106e29:	6a 00                	push   $0x0
  pushl $82
80106e2b:	6a 52                	push   $0x52
  jmp alltraps
80106e2d:	e9 3a f8 ff ff       	jmp    8010666c <alltraps>

80106e32 <vector83>:
.globl vector83
vector83:
  pushl $0
80106e32:	6a 00                	push   $0x0
  pushl $83
80106e34:	6a 53                	push   $0x53
  jmp alltraps
80106e36:	e9 31 f8 ff ff       	jmp    8010666c <alltraps>

80106e3b <vector84>:
.globl vector84
vector84:
  pushl $0
80106e3b:	6a 00                	push   $0x0
  pushl $84
80106e3d:	6a 54                	push   $0x54
  jmp alltraps
80106e3f:	e9 28 f8 ff ff       	jmp    8010666c <alltraps>

80106e44 <vector85>:
.globl vector85
vector85:
  pushl $0
80106e44:	6a 00                	push   $0x0
  pushl $85
80106e46:	6a 55                	push   $0x55
  jmp alltraps
80106e48:	e9 1f f8 ff ff       	jmp    8010666c <alltraps>

80106e4d <vector86>:
.globl vector86
vector86:
  pushl $0
80106e4d:	6a 00                	push   $0x0
  pushl $86
80106e4f:	6a 56                	push   $0x56
  jmp alltraps
80106e51:	e9 16 f8 ff ff       	jmp    8010666c <alltraps>

80106e56 <vector87>:
.globl vector87
vector87:
  pushl $0
80106e56:	6a 00                	push   $0x0
  pushl $87
80106e58:	6a 57                	push   $0x57
  jmp alltraps
80106e5a:	e9 0d f8 ff ff       	jmp    8010666c <alltraps>

80106e5f <vector88>:
.globl vector88
vector88:
  pushl $0
80106e5f:	6a 00                	push   $0x0
  pushl $88
80106e61:	6a 58                	push   $0x58
  jmp alltraps
80106e63:	e9 04 f8 ff ff       	jmp    8010666c <alltraps>

80106e68 <vector89>:
.globl vector89
vector89:
  pushl $0
80106e68:	6a 00                	push   $0x0
  pushl $89
80106e6a:	6a 59                	push   $0x59
  jmp alltraps
80106e6c:	e9 fb f7 ff ff       	jmp    8010666c <alltraps>

80106e71 <vector90>:
.globl vector90
vector90:
  pushl $0
80106e71:	6a 00                	push   $0x0
  pushl $90
80106e73:	6a 5a                	push   $0x5a
  jmp alltraps
80106e75:	e9 f2 f7 ff ff       	jmp    8010666c <alltraps>

80106e7a <vector91>:
.globl vector91
vector91:
  pushl $0
80106e7a:	6a 00                	push   $0x0
  pushl $91
80106e7c:	6a 5b                	push   $0x5b
  jmp alltraps
80106e7e:	e9 e9 f7 ff ff       	jmp    8010666c <alltraps>

80106e83 <vector92>:
.globl vector92
vector92:
  pushl $0
80106e83:	6a 00                	push   $0x0
  pushl $92
80106e85:	6a 5c                	push   $0x5c
  jmp alltraps
80106e87:	e9 e0 f7 ff ff       	jmp    8010666c <alltraps>

80106e8c <vector93>:
.globl vector93
vector93:
  pushl $0
80106e8c:	6a 00                	push   $0x0
  pushl $93
80106e8e:	6a 5d                	push   $0x5d
  jmp alltraps
80106e90:	e9 d7 f7 ff ff       	jmp    8010666c <alltraps>

80106e95 <vector94>:
.globl vector94
vector94:
  pushl $0
80106e95:	6a 00                	push   $0x0
  pushl $94
80106e97:	6a 5e                	push   $0x5e
  jmp alltraps
80106e99:	e9 ce f7 ff ff       	jmp    8010666c <alltraps>

80106e9e <vector95>:
.globl vector95
vector95:
  pushl $0
80106e9e:	6a 00                	push   $0x0
  pushl $95
80106ea0:	6a 5f                	push   $0x5f
  jmp alltraps
80106ea2:	e9 c5 f7 ff ff       	jmp    8010666c <alltraps>

80106ea7 <vector96>:
.globl vector96
vector96:
  pushl $0
80106ea7:	6a 00                	push   $0x0
  pushl $96
80106ea9:	6a 60                	push   $0x60
  jmp alltraps
80106eab:	e9 bc f7 ff ff       	jmp    8010666c <alltraps>

80106eb0 <vector97>:
.globl vector97
vector97:
  pushl $0
80106eb0:	6a 00                	push   $0x0
  pushl $97
80106eb2:	6a 61                	push   $0x61
  jmp alltraps
80106eb4:	e9 b3 f7 ff ff       	jmp    8010666c <alltraps>

80106eb9 <vector98>:
.globl vector98
vector98:
  pushl $0
80106eb9:	6a 00                	push   $0x0
  pushl $98
80106ebb:	6a 62                	push   $0x62
  jmp alltraps
80106ebd:	e9 aa f7 ff ff       	jmp    8010666c <alltraps>

80106ec2 <vector99>:
.globl vector99
vector99:
  pushl $0
80106ec2:	6a 00                	push   $0x0
  pushl $99
80106ec4:	6a 63                	push   $0x63
  jmp alltraps
80106ec6:	e9 a1 f7 ff ff       	jmp    8010666c <alltraps>

80106ecb <vector100>:
.globl vector100
vector100:
  pushl $0
80106ecb:	6a 00                	push   $0x0
  pushl $100
80106ecd:	6a 64                	push   $0x64
  jmp alltraps
80106ecf:	e9 98 f7 ff ff       	jmp    8010666c <alltraps>

80106ed4 <vector101>:
.globl vector101
vector101:
  pushl $0
80106ed4:	6a 00                	push   $0x0
  pushl $101
80106ed6:	6a 65                	push   $0x65
  jmp alltraps
80106ed8:	e9 8f f7 ff ff       	jmp    8010666c <alltraps>

80106edd <vector102>:
.globl vector102
vector102:
  pushl $0
80106edd:	6a 00                	push   $0x0
  pushl $102
80106edf:	6a 66                	push   $0x66
  jmp alltraps
80106ee1:	e9 86 f7 ff ff       	jmp    8010666c <alltraps>

80106ee6 <vector103>:
.globl vector103
vector103:
  pushl $0
80106ee6:	6a 00                	push   $0x0
  pushl $103
80106ee8:	6a 67                	push   $0x67
  jmp alltraps
80106eea:	e9 7d f7 ff ff       	jmp    8010666c <alltraps>

80106eef <vector104>:
.globl vector104
vector104:
  pushl $0
80106eef:	6a 00                	push   $0x0
  pushl $104
80106ef1:	6a 68                	push   $0x68
  jmp alltraps
80106ef3:	e9 74 f7 ff ff       	jmp    8010666c <alltraps>

80106ef8 <vector105>:
.globl vector105
vector105:
  pushl $0
80106ef8:	6a 00                	push   $0x0
  pushl $105
80106efa:	6a 69                	push   $0x69
  jmp alltraps
80106efc:	e9 6b f7 ff ff       	jmp    8010666c <alltraps>

80106f01 <vector106>:
.globl vector106
vector106:
  pushl $0
80106f01:	6a 00                	push   $0x0
  pushl $106
80106f03:	6a 6a                	push   $0x6a
  jmp alltraps
80106f05:	e9 62 f7 ff ff       	jmp    8010666c <alltraps>

80106f0a <vector107>:
.globl vector107
vector107:
  pushl $0
80106f0a:	6a 00                	push   $0x0
  pushl $107
80106f0c:	6a 6b                	push   $0x6b
  jmp alltraps
80106f0e:	e9 59 f7 ff ff       	jmp    8010666c <alltraps>

80106f13 <vector108>:
.globl vector108
vector108:
  pushl $0
80106f13:	6a 00                	push   $0x0
  pushl $108
80106f15:	6a 6c                	push   $0x6c
  jmp alltraps
80106f17:	e9 50 f7 ff ff       	jmp    8010666c <alltraps>

80106f1c <vector109>:
.globl vector109
vector109:
  pushl $0
80106f1c:	6a 00                	push   $0x0
  pushl $109
80106f1e:	6a 6d                	push   $0x6d
  jmp alltraps
80106f20:	e9 47 f7 ff ff       	jmp    8010666c <alltraps>

80106f25 <vector110>:
.globl vector110
vector110:
  pushl $0
80106f25:	6a 00                	push   $0x0
  pushl $110
80106f27:	6a 6e                	push   $0x6e
  jmp alltraps
80106f29:	e9 3e f7 ff ff       	jmp    8010666c <alltraps>

80106f2e <vector111>:
.globl vector111
vector111:
  pushl $0
80106f2e:	6a 00                	push   $0x0
  pushl $111
80106f30:	6a 6f                	push   $0x6f
  jmp alltraps
80106f32:	e9 35 f7 ff ff       	jmp    8010666c <alltraps>

80106f37 <vector112>:
.globl vector112
vector112:
  pushl $0
80106f37:	6a 00                	push   $0x0
  pushl $112
80106f39:	6a 70                	push   $0x70
  jmp alltraps
80106f3b:	e9 2c f7 ff ff       	jmp    8010666c <alltraps>

80106f40 <vector113>:
.globl vector113
vector113:
  pushl $0
80106f40:	6a 00                	push   $0x0
  pushl $113
80106f42:	6a 71                	push   $0x71
  jmp alltraps
80106f44:	e9 23 f7 ff ff       	jmp    8010666c <alltraps>

80106f49 <vector114>:
.globl vector114
vector114:
  pushl $0
80106f49:	6a 00                	push   $0x0
  pushl $114
80106f4b:	6a 72                	push   $0x72
  jmp alltraps
80106f4d:	e9 1a f7 ff ff       	jmp    8010666c <alltraps>

80106f52 <vector115>:
.globl vector115
vector115:
  pushl $0
80106f52:	6a 00                	push   $0x0
  pushl $115
80106f54:	6a 73                	push   $0x73
  jmp alltraps
80106f56:	e9 11 f7 ff ff       	jmp    8010666c <alltraps>

80106f5b <vector116>:
.globl vector116
vector116:
  pushl $0
80106f5b:	6a 00                	push   $0x0
  pushl $116
80106f5d:	6a 74                	push   $0x74
  jmp alltraps
80106f5f:	e9 08 f7 ff ff       	jmp    8010666c <alltraps>

80106f64 <vector117>:
.globl vector117
vector117:
  pushl $0
80106f64:	6a 00                	push   $0x0
  pushl $117
80106f66:	6a 75                	push   $0x75
  jmp alltraps
80106f68:	e9 ff f6 ff ff       	jmp    8010666c <alltraps>

80106f6d <vector118>:
.globl vector118
vector118:
  pushl $0
80106f6d:	6a 00                	push   $0x0
  pushl $118
80106f6f:	6a 76                	push   $0x76
  jmp alltraps
80106f71:	e9 f6 f6 ff ff       	jmp    8010666c <alltraps>

80106f76 <vector119>:
.globl vector119
vector119:
  pushl $0
80106f76:	6a 00                	push   $0x0
  pushl $119
80106f78:	6a 77                	push   $0x77
  jmp alltraps
80106f7a:	e9 ed f6 ff ff       	jmp    8010666c <alltraps>

80106f7f <vector120>:
.globl vector120
vector120:
  pushl $0
80106f7f:	6a 00                	push   $0x0
  pushl $120
80106f81:	6a 78                	push   $0x78
  jmp alltraps
80106f83:	e9 e4 f6 ff ff       	jmp    8010666c <alltraps>

80106f88 <vector121>:
.globl vector121
vector121:
  pushl $0
80106f88:	6a 00                	push   $0x0
  pushl $121
80106f8a:	6a 79                	push   $0x79
  jmp alltraps
80106f8c:	e9 db f6 ff ff       	jmp    8010666c <alltraps>

80106f91 <vector122>:
.globl vector122
vector122:
  pushl $0
80106f91:	6a 00                	push   $0x0
  pushl $122
80106f93:	6a 7a                	push   $0x7a
  jmp alltraps
80106f95:	e9 d2 f6 ff ff       	jmp    8010666c <alltraps>

80106f9a <vector123>:
.globl vector123
vector123:
  pushl $0
80106f9a:	6a 00                	push   $0x0
  pushl $123
80106f9c:	6a 7b                	push   $0x7b
  jmp alltraps
80106f9e:	e9 c9 f6 ff ff       	jmp    8010666c <alltraps>

80106fa3 <vector124>:
.globl vector124
vector124:
  pushl $0
80106fa3:	6a 00                	push   $0x0
  pushl $124
80106fa5:	6a 7c                	push   $0x7c
  jmp alltraps
80106fa7:	e9 c0 f6 ff ff       	jmp    8010666c <alltraps>

80106fac <vector125>:
.globl vector125
vector125:
  pushl $0
80106fac:	6a 00                	push   $0x0
  pushl $125
80106fae:	6a 7d                	push   $0x7d
  jmp alltraps
80106fb0:	e9 b7 f6 ff ff       	jmp    8010666c <alltraps>

80106fb5 <vector126>:
.globl vector126
vector126:
  pushl $0
80106fb5:	6a 00                	push   $0x0
  pushl $126
80106fb7:	6a 7e                	push   $0x7e
  jmp alltraps
80106fb9:	e9 ae f6 ff ff       	jmp    8010666c <alltraps>

80106fbe <vector127>:
.globl vector127
vector127:
  pushl $0
80106fbe:	6a 00                	push   $0x0
  pushl $127
80106fc0:	6a 7f                	push   $0x7f
  jmp alltraps
80106fc2:	e9 a5 f6 ff ff       	jmp    8010666c <alltraps>

80106fc7 <vector128>:
.globl vector128
vector128:
  pushl $0
80106fc7:	6a 00                	push   $0x0
  pushl $128
80106fc9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106fce:	e9 99 f6 ff ff       	jmp    8010666c <alltraps>

80106fd3 <vector129>:
.globl vector129
vector129:
  pushl $0
80106fd3:	6a 00                	push   $0x0
  pushl $129
80106fd5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106fda:	e9 8d f6 ff ff       	jmp    8010666c <alltraps>

80106fdf <vector130>:
.globl vector130
vector130:
  pushl $0
80106fdf:	6a 00                	push   $0x0
  pushl $130
80106fe1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106fe6:	e9 81 f6 ff ff       	jmp    8010666c <alltraps>

80106feb <vector131>:
.globl vector131
vector131:
  pushl $0
80106feb:	6a 00                	push   $0x0
  pushl $131
80106fed:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106ff2:	e9 75 f6 ff ff       	jmp    8010666c <alltraps>

80106ff7 <vector132>:
.globl vector132
vector132:
  pushl $0
80106ff7:	6a 00                	push   $0x0
  pushl $132
80106ff9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106ffe:	e9 69 f6 ff ff       	jmp    8010666c <alltraps>

80107003 <vector133>:
.globl vector133
vector133:
  pushl $0
80107003:	6a 00                	push   $0x0
  pushl $133
80107005:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010700a:	e9 5d f6 ff ff       	jmp    8010666c <alltraps>

8010700f <vector134>:
.globl vector134
vector134:
  pushl $0
8010700f:	6a 00                	push   $0x0
  pushl $134
80107011:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107016:	e9 51 f6 ff ff       	jmp    8010666c <alltraps>

8010701b <vector135>:
.globl vector135
vector135:
  pushl $0
8010701b:	6a 00                	push   $0x0
  pushl $135
8010701d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107022:	e9 45 f6 ff ff       	jmp    8010666c <alltraps>

80107027 <vector136>:
.globl vector136
vector136:
  pushl $0
80107027:	6a 00                	push   $0x0
  pushl $136
80107029:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010702e:	e9 39 f6 ff ff       	jmp    8010666c <alltraps>

80107033 <vector137>:
.globl vector137
vector137:
  pushl $0
80107033:	6a 00                	push   $0x0
  pushl $137
80107035:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010703a:	e9 2d f6 ff ff       	jmp    8010666c <alltraps>

8010703f <vector138>:
.globl vector138
vector138:
  pushl $0
8010703f:	6a 00                	push   $0x0
  pushl $138
80107041:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107046:	e9 21 f6 ff ff       	jmp    8010666c <alltraps>

8010704b <vector139>:
.globl vector139
vector139:
  pushl $0
8010704b:	6a 00                	push   $0x0
  pushl $139
8010704d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107052:	e9 15 f6 ff ff       	jmp    8010666c <alltraps>

80107057 <vector140>:
.globl vector140
vector140:
  pushl $0
80107057:	6a 00                	push   $0x0
  pushl $140
80107059:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010705e:	e9 09 f6 ff ff       	jmp    8010666c <alltraps>

80107063 <vector141>:
.globl vector141
vector141:
  pushl $0
80107063:	6a 00                	push   $0x0
  pushl $141
80107065:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010706a:	e9 fd f5 ff ff       	jmp    8010666c <alltraps>

8010706f <vector142>:
.globl vector142
vector142:
  pushl $0
8010706f:	6a 00                	push   $0x0
  pushl $142
80107071:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107076:	e9 f1 f5 ff ff       	jmp    8010666c <alltraps>

8010707b <vector143>:
.globl vector143
vector143:
  pushl $0
8010707b:	6a 00                	push   $0x0
  pushl $143
8010707d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107082:	e9 e5 f5 ff ff       	jmp    8010666c <alltraps>

80107087 <vector144>:
.globl vector144
vector144:
  pushl $0
80107087:	6a 00                	push   $0x0
  pushl $144
80107089:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010708e:	e9 d9 f5 ff ff       	jmp    8010666c <alltraps>

80107093 <vector145>:
.globl vector145
vector145:
  pushl $0
80107093:	6a 00                	push   $0x0
  pushl $145
80107095:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010709a:	e9 cd f5 ff ff       	jmp    8010666c <alltraps>

8010709f <vector146>:
.globl vector146
vector146:
  pushl $0
8010709f:	6a 00                	push   $0x0
  pushl $146
801070a1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801070a6:	e9 c1 f5 ff ff       	jmp    8010666c <alltraps>

801070ab <vector147>:
.globl vector147
vector147:
  pushl $0
801070ab:	6a 00                	push   $0x0
  pushl $147
801070ad:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801070b2:	e9 b5 f5 ff ff       	jmp    8010666c <alltraps>

801070b7 <vector148>:
.globl vector148
vector148:
  pushl $0
801070b7:	6a 00                	push   $0x0
  pushl $148
801070b9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801070be:	e9 a9 f5 ff ff       	jmp    8010666c <alltraps>

801070c3 <vector149>:
.globl vector149
vector149:
  pushl $0
801070c3:	6a 00                	push   $0x0
  pushl $149
801070c5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801070ca:	e9 9d f5 ff ff       	jmp    8010666c <alltraps>

801070cf <vector150>:
.globl vector150
vector150:
  pushl $0
801070cf:	6a 00                	push   $0x0
  pushl $150
801070d1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801070d6:	e9 91 f5 ff ff       	jmp    8010666c <alltraps>

801070db <vector151>:
.globl vector151
vector151:
  pushl $0
801070db:	6a 00                	push   $0x0
  pushl $151
801070dd:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801070e2:	e9 85 f5 ff ff       	jmp    8010666c <alltraps>

801070e7 <vector152>:
.globl vector152
vector152:
  pushl $0
801070e7:	6a 00                	push   $0x0
  pushl $152
801070e9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801070ee:	e9 79 f5 ff ff       	jmp    8010666c <alltraps>

801070f3 <vector153>:
.globl vector153
vector153:
  pushl $0
801070f3:	6a 00                	push   $0x0
  pushl $153
801070f5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801070fa:	e9 6d f5 ff ff       	jmp    8010666c <alltraps>

801070ff <vector154>:
.globl vector154
vector154:
  pushl $0
801070ff:	6a 00                	push   $0x0
  pushl $154
80107101:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107106:	e9 61 f5 ff ff       	jmp    8010666c <alltraps>

8010710b <vector155>:
.globl vector155
vector155:
  pushl $0
8010710b:	6a 00                	push   $0x0
  pushl $155
8010710d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107112:	e9 55 f5 ff ff       	jmp    8010666c <alltraps>

80107117 <vector156>:
.globl vector156
vector156:
  pushl $0
80107117:	6a 00                	push   $0x0
  pushl $156
80107119:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010711e:	e9 49 f5 ff ff       	jmp    8010666c <alltraps>

80107123 <vector157>:
.globl vector157
vector157:
  pushl $0
80107123:	6a 00                	push   $0x0
  pushl $157
80107125:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010712a:	e9 3d f5 ff ff       	jmp    8010666c <alltraps>

8010712f <vector158>:
.globl vector158
vector158:
  pushl $0
8010712f:	6a 00                	push   $0x0
  pushl $158
80107131:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107136:	e9 31 f5 ff ff       	jmp    8010666c <alltraps>

8010713b <vector159>:
.globl vector159
vector159:
  pushl $0
8010713b:	6a 00                	push   $0x0
  pushl $159
8010713d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107142:	e9 25 f5 ff ff       	jmp    8010666c <alltraps>

80107147 <vector160>:
.globl vector160
vector160:
  pushl $0
80107147:	6a 00                	push   $0x0
  pushl $160
80107149:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010714e:	e9 19 f5 ff ff       	jmp    8010666c <alltraps>

80107153 <vector161>:
.globl vector161
vector161:
  pushl $0
80107153:	6a 00                	push   $0x0
  pushl $161
80107155:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010715a:	e9 0d f5 ff ff       	jmp    8010666c <alltraps>

8010715f <vector162>:
.globl vector162
vector162:
  pushl $0
8010715f:	6a 00                	push   $0x0
  pushl $162
80107161:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107166:	e9 01 f5 ff ff       	jmp    8010666c <alltraps>

8010716b <vector163>:
.globl vector163
vector163:
  pushl $0
8010716b:	6a 00                	push   $0x0
  pushl $163
8010716d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80107172:	e9 f5 f4 ff ff       	jmp    8010666c <alltraps>

80107177 <vector164>:
.globl vector164
vector164:
  pushl $0
80107177:	6a 00                	push   $0x0
  pushl $164
80107179:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010717e:	e9 e9 f4 ff ff       	jmp    8010666c <alltraps>

80107183 <vector165>:
.globl vector165
vector165:
  pushl $0
80107183:	6a 00                	push   $0x0
  pushl $165
80107185:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010718a:	e9 dd f4 ff ff       	jmp    8010666c <alltraps>

8010718f <vector166>:
.globl vector166
vector166:
  pushl $0
8010718f:	6a 00                	push   $0x0
  pushl $166
80107191:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107196:	e9 d1 f4 ff ff       	jmp    8010666c <alltraps>

8010719b <vector167>:
.globl vector167
vector167:
  pushl $0
8010719b:	6a 00                	push   $0x0
  pushl $167
8010719d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801071a2:	e9 c5 f4 ff ff       	jmp    8010666c <alltraps>

801071a7 <vector168>:
.globl vector168
vector168:
  pushl $0
801071a7:	6a 00                	push   $0x0
  pushl $168
801071a9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801071ae:	e9 b9 f4 ff ff       	jmp    8010666c <alltraps>

801071b3 <vector169>:
.globl vector169
vector169:
  pushl $0
801071b3:	6a 00                	push   $0x0
  pushl $169
801071b5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801071ba:	e9 ad f4 ff ff       	jmp    8010666c <alltraps>

801071bf <vector170>:
.globl vector170
vector170:
  pushl $0
801071bf:	6a 00                	push   $0x0
  pushl $170
801071c1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801071c6:	e9 a1 f4 ff ff       	jmp    8010666c <alltraps>

801071cb <vector171>:
.globl vector171
vector171:
  pushl $0
801071cb:	6a 00                	push   $0x0
  pushl $171
801071cd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801071d2:	e9 95 f4 ff ff       	jmp    8010666c <alltraps>

801071d7 <vector172>:
.globl vector172
vector172:
  pushl $0
801071d7:	6a 00                	push   $0x0
  pushl $172
801071d9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801071de:	e9 89 f4 ff ff       	jmp    8010666c <alltraps>

801071e3 <vector173>:
.globl vector173
vector173:
  pushl $0
801071e3:	6a 00                	push   $0x0
  pushl $173
801071e5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801071ea:	e9 7d f4 ff ff       	jmp    8010666c <alltraps>

801071ef <vector174>:
.globl vector174
vector174:
  pushl $0
801071ef:	6a 00                	push   $0x0
  pushl $174
801071f1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801071f6:	e9 71 f4 ff ff       	jmp    8010666c <alltraps>

801071fb <vector175>:
.globl vector175
vector175:
  pushl $0
801071fb:	6a 00                	push   $0x0
  pushl $175
801071fd:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107202:	e9 65 f4 ff ff       	jmp    8010666c <alltraps>

80107207 <vector176>:
.globl vector176
vector176:
  pushl $0
80107207:	6a 00                	push   $0x0
  pushl $176
80107209:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010720e:	e9 59 f4 ff ff       	jmp    8010666c <alltraps>

80107213 <vector177>:
.globl vector177
vector177:
  pushl $0
80107213:	6a 00                	push   $0x0
  pushl $177
80107215:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010721a:	e9 4d f4 ff ff       	jmp    8010666c <alltraps>

8010721f <vector178>:
.globl vector178
vector178:
  pushl $0
8010721f:	6a 00                	push   $0x0
  pushl $178
80107221:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107226:	e9 41 f4 ff ff       	jmp    8010666c <alltraps>

8010722b <vector179>:
.globl vector179
vector179:
  pushl $0
8010722b:	6a 00                	push   $0x0
  pushl $179
8010722d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107232:	e9 35 f4 ff ff       	jmp    8010666c <alltraps>

80107237 <vector180>:
.globl vector180
vector180:
  pushl $0
80107237:	6a 00                	push   $0x0
  pushl $180
80107239:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010723e:	e9 29 f4 ff ff       	jmp    8010666c <alltraps>

80107243 <vector181>:
.globl vector181
vector181:
  pushl $0
80107243:	6a 00                	push   $0x0
  pushl $181
80107245:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010724a:	e9 1d f4 ff ff       	jmp    8010666c <alltraps>

8010724f <vector182>:
.globl vector182
vector182:
  pushl $0
8010724f:	6a 00                	push   $0x0
  pushl $182
80107251:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107256:	e9 11 f4 ff ff       	jmp    8010666c <alltraps>

8010725b <vector183>:
.globl vector183
vector183:
  pushl $0
8010725b:	6a 00                	push   $0x0
  pushl $183
8010725d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107262:	e9 05 f4 ff ff       	jmp    8010666c <alltraps>

80107267 <vector184>:
.globl vector184
vector184:
  pushl $0
80107267:	6a 00                	push   $0x0
  pushl $184
80107269:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010726e:	e9 f9 f3 ff ff       	jmp    8010666c <alltraps>

80107273 <vector185>:
.globl vector185
vector185:
  pushl $0
80107273:	6a 00                	push   $0x0
  pushl $185
80107275:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010727a:	e9 ed f3 ff ff       	jmp    8010666c <alltraps>

8010727f <vector186>:
.globl vector186
vector186:
  pushl $0
8010727f:	6a 00                	push   $0x0
  pushl $186
80107281:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107286:	e9 e1 f3 ff ff       	jmp    8010666c <alltraps>

8010728b <vector187>:
.globl vector187
vector187:
  pushl $0
8010728b:	6a 00                	push   $0x0
  pushl $187
8010728d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107292:	e9 d5 f3 ff ff       	jmp    8010666c <alltraps>

80107297 <vector188>:
.globl vector188
vector188:
  pushl $0
80107297:	6a 00                	push   $0x0
  pushl $188
80107299:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010729e:	e9 c9 f3 ff ff       	jmp    8010666c <alltraps>

801072a3 <vector189>:
.globl vector189
vector189:
  pushl $0
801072a3:	6a 00                	push   $0x0
  pushl $189
801072a5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801072aa:	e9 bd f3 ff ff       	jmp    8010666c <alltraps>

801072af <vector190>:
.globl vector190
vector190:
  pushl $0
801072af:	6a 00                	push   $0x0
  pushl $190
801072b1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801072b6:	e9 b1 f3 ff ff       	jmp    8010666c <alltraps>

801072bb <vector191>:
.globl vector191
vector191:
  pushl $0
801072bb:	6a 00                	push   $0x0
  pushl $191
801072bd:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801072c2:	e9 a5 f3 ff ff       	jmp    8010666c <alltraps>

801072c7 <vector192>:
.globl vector192
vector192:
  pushl $0
801072c7:	6a 00                	push   $0x0
  pushl $192
801072c9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801072ce:	e9 99 f3 ff ff       	jmp    8010666c <alltraps>

801072d3 <vector193>:
.globl vector193
vector193:
  pushl $0
801072d3:	6a 00                	push   $0x0
  pushl $193
801072d5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801072da:	e9 8d f3 ff ff       	jmp    8010666c <alltraps>

801072df <vector194>:
.globl vector194
vector194:
  pushl $0
801072df:	6a 00                	push   $0x0
  pushl $194
801072e1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801072e6:	e9 81 f3 ff ff       	jmp    8010666c <alltraps>

801072eb <vector195>:
.globl vector195
vector195:
  pushl $0
801072eb:	6a 00                	push   $0x0
  pushl $195
801072ed:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801072f2:	e9 75 f3 ff ff       	jmp    8010666c <alltraps>

801072f7 <vector196>:
.globl vector196
vector196:
  pushl $0
801072f7:	6a 00                	push   $0x0
  pushl $196
801072f9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801072fe:	e9 69 f3 ff ff       	jmp    8010666c <alltraps>

80107303 <vector197>:
.globl vector197
vector197:
  pushl $0
80107303:	6a 00                	push   $0x0
  pushl $197
80107305:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010730a:	e9 5d f3 ff ff       	jmp    8010666c <alltraps>

8010730f <vector198>:
.globl vector198
vector198:
  pushl $0
8010730f:	6a 00                	push   $0x0
  pushl $198
80107311:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107316:	e9 51 f3 ff ff       	jmp    8010666c <alltraps>

8010731b <vector199>:
.globl vector199
vector199:
  pushl $0
8010731b:	6a 00                	push   $0x0
  pushl $199
8010731d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107322:	e9 45 f3 ff ff       	jmp    8010666c <alltraps>

80107327 <vector200>:
.globl vector200
vector200:
  pushl $0
80107327:	6a 00                	push   $0x0
  pushl $200
80107329:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010732e:	e9 39 f3 ff ff       	jmp    8010666c <alltraps>

80107333 <vector201>:
.globl vector201
vector201:
  pushl $0
80107333:	6a 00                	push   $0x0
  pushl $201
80107335:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010733a:	e9 2d f3 ff ff       	jmp    8010666c <alltraps>

8010733f <vector202>:
.globl vector202
vector202:
  pushl $0
8010733f:	6a 00                	push   $0x0
  pushl $202
80107341:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107346:	e9 21 f3 ff ff       	jmp    8010666c <alltraps>

8010734b <vector203>:
.globl vector203
vector203:
  pushl $0
8010734b:	6a 00                	push   $0x0
  pushl $203
8010734d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107352:	e9 15 f3 ff ff       	jmp    8010666c <alltraps>

80107357 <vector204>:
.globl vector204
vector204:
  pushl $0
80107357:	6a 00                	push   $0x0
  pushl $204
80107359:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010735e:	e9 09 f3 ff ff       	jmp    8010666c <alltraps>

80107363 <vector205>:
.globl vector205
vector205:
  pushl $0
80107363:	6a 00                	push   $0x0
  pushl $205
80107365:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010736a:	e9 fd f2 ff ff       	jmp    8010666c <alltraps>

8010736f <vector206>:
.globl vector206
vector206:
  pushl $0
8010736f:	6a 00                	push   $0x0
  pushl $206
80107371:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107376:	e9 f1 f2 ff ff       	jmp    8010666c <alltraps>

8010737b <vector207>:
.globl vector207
vector207:
  pushl $0
8010737b:	6a 00                	push   $0x0
  pushl $207
8010737d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107382:	e9 e5 f2 ff ff       	jmp    8010666c <alltraps>

80107387 <vector208>:
.globl vector208
vector208:
  pushl $0
80107387:	6a 00                	push   $0x0
  pushl $208
80107389:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010738e:	e9 d9 f2 ff ff       	jmp    8010666c <alltraps>

80107393 <vector209>:
.globl vector209
vector209:
  pushl $0
80107393:	6a 00                	push   $0x0
  pushl $209
80107395:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010739a:	e9 cd f2 ff ff       	jmp    8010666c <alltraps>

8010739f <vector210>:
.globl vector210
vector210:
  pushl $0
8010739f:	6a 00                	push   $0x0
  pushl $210
801073a1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801073a6:	e9 c1 f2 ff ff       	jmp    8010666c <alltraps>

801073ab <vector211>:
.globl vector211
vector211:
  pushl $0
801073ab:	6a 00                	push   $0x0
  pushl $211
801073ad:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801073b2:	e9 b5 f2 ff ff       	jmp    8010666c <alltraps>

801073b7 <vector212>:
.globl vector212
vector212:
  pushl $0
801073b7:	6a 00                	push   $0x0
  pushl $212
801073b9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801073be:	e9 a9 f2 ff ff       	jmp    8010666c <alltraps>

801073c3 <vector213>:
.globl vector213
vector213:
  pushl $0
801073c3:	6a 00                	push   $0x0
  pushl $213
801073c5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801073ca:	e9 9d f2 ff ff       	jmp    8010666c <alltraps>

801073cf <vector214>:
.globl vector214
vector214:
  pushl $0
801073cf:	6a 00                	push   $0x0
  pushl $214
801073d1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801073d6:	e9 91 f2 ff ff       	jmp    8010666c <alltraps>

801073db <vector215>:
.globl vector215
vector215:
  pushl $0
801073db:	6a 00                	push   $0x0
  pushl $215
801073dd:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801073e2:	e9 85 f2 ff ff       	jmp    8010666c <alltraps>

801073e7 <vector216>:
.globl vector216
vector216:
  pushl $0
801073e7:	6a 00                	push   $0x0
  pushl $216
801073e9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801073ee:	e9 79 f2 ff ff       	jmp    8010666c <alltraps>

801073f3 <vector217>:
.globl vector217
vector217:
  pushl $0
801073f3:	6a 00                	push   $0x0
  pushl $217
801073f5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801073fa:	e9 6d f2 ff ff       	jmp    8010666c <alltraps>

801073ff <vector218>:
.globl vector218
vector218:
  pushl $0
801073ff:	6a 00                	push   $0x0
  pushl $218
80107401:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107406:	e9 61 f2 ff ff       	jmp    8010666c <alltraps>

8010740b <vector219>:
.globl vector219
vector219:
  pushl $0
8010740b:	6a 00                	push   $0x0
  pushl $219
8010740d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107412:	e9 55 f2 ff ff       	jmp    8010666c <alltraps>

80107417 <vector220>:
.globl vector220
vector220:
  pushl $0
80107417:	6a 00                	push   $0x0
  pushl $220
80107419:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010741e:	e9 49 f2 ff ff       	jmp    8010666c <alltraps>

80107423 <vector221>:
.globl vector221
vector221:
  pushl $0
80107423:	6a 00                	push   $0x0
  pushl $221
80107425:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010742a:	e9 3d f2 ff ff       	jmp    8010666c <alltraps>

8010742f <vector222>:
.globl vector222
vector222:
  pushl $0
8010742f:	6a 00                	push   $0x0
  pushl $222
80107431:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107436:	e9 31 f2 ff ff       	jmp    8010666c <alltraps>

8010743b <vector223>:
.globl vector223
vector223:
  pushl $0
8010743b:	6a 00                	push   $0x0
  pushl $223
8010743d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107442:	e9 25 f2 ff ff       	jmp    8010666c <alltraps>

80107447 <vector224>:
.globl vector224
vector224:
  pushl $0
80107447:	6a 00                	push   $0x0
  pushl $224
80107449:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010744e:	e9 19 f2 ff ff       	jmp    8010666c <alltraps>

80107453 <vector225>:
.globl vector225
vector225:
  pushl $0
80107453:	6a 00                	push   $0x0
  pushl $225
80107455:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010745a:	e9 0d f2 ff ff       	jmp    8010666c <alltraps>

8010745f <vector226>:
.globl vector226
vector226:
  pushl $0
8010745f:	6a 00                	push   $0x0
  pushl $226
80107461:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107466:	e9 01 f2 ff ff       	jmp    8010666c <alltraps>

8010746b <vector227>:
.globl vector227
vector227:
  pushl $0
8010746b:	6a 00                	push   $0x0
  pushl $227
8010746d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107472:	e9 f5 f1 ff ff       	jmp    8010666c <alltraps>

80107477 <vector228>:
.globl vector228
vector228:
  pushl $0
80107477:	6a 00                	push   $0x0
  pushl $228
80107479:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010747e:	e9 e9 f1 ff ff       	jmp    8010666c <alltraps>

80107483 <vector229>:
.globl vector229
vector229:
  pushl $0
80107483:	6a 00                	push   $0x0
  pushl $229
80107485:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010748a:	e9 dd f1 ff ff       	jmp    8010666c <alltraps>

8010748f <vector230>:
.globl vector230
vector230:
  pushl $0
8010748f:	6a 00                	push   $0x0
  pushl $230
80107491:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107496:	e9 d1 f1 ff ff       	jmp    8010666c <alltraps>

8010749b <vector231>:
.globl vector231
vector231:
  pushl $0
8010749b:	6a 00                	push   $0x0
  pushl $231
8010749d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801074a2:	e9 c5 f1 ff ff       	jmp    8010666c <alltraps>

801074a7 <vector232>:
.globl vector232
vector232:
  pushl $0
801074a7:	6a 00                	push   $0x0
  pushl $232
801074a9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801074ae:	e9 b9 f1 ff ff       	jmp    8010666c <alltraps>

801074b3 <vector233>:
.globl vector233
vector233:
  pushl $0
801074b3:	6a 00                	push   $0x0
  pushl $233
801074b5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801074ba:	e9 ad f1 ff ff       	jmp    8010666c <alltraps>

801074bf <vector234>:
.globl vector234
vector234:
  pushl $0
801074bf:	6a 00                	push   $0x0
  pushl $234
801074c1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801074c6:	e9 a1 f1 ff ff       	jmp    8010666c <alltraps>

801074cb <vector235>:
.globl vector235
vector235:
  pushl $0
801074cb:	6a 00                	push   $0x0
  pushl $235
801074cd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801074d2:	e9 95 f1 ff ff       	jmp    8010666c <alltraps>

801074d7 <vector236>:
.globl vector236
vector236:
  pushl $0
801074d7:	6a 00                	push   $0x0
  pushl $236
801074d9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801074de:	e9 89 f1 ff ff       	jmp    8010666c <alltraps>

801074e3 <vector237>:
.globl vector237
vector237:
  pushl $0
801074e3:	6a 00                	push   $0x0
  pushl $237
801074e5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801074ea:	e9 7d f1 ff ff       	jmp    8010666c <alltraps>

801074ef <vector238>:
.globl vector238
vector238:
  pushl $0
801074ef:	6a 00                	push   $0x0
  pushl $238
801074f1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801074f6:	e9 71 f1 ff ff       	jmp    8010666c <alltraps>

801074fb <vector239>:
.globl vector239
vector239:
  pushl $0
801074fb:	6a 00                	push   $0x0
  pushl $239
801074fd:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107502:	e9 65 f1 ff ff       	jmp    8010666c <alltraps>

80107507 <vector240>:
.globl vector240
vector240:
  pushl $0
80107507:	6a 00                	push   $0x0
  pushl $240
80107509:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010750e:	e9 59 f1 ff ff       	jmp    8010666c <alltraps>

80107513 <vector241>:
.globl vector241
vector241:
  pushl $0
80107513:	6a 00                	push   $0x0
  pushl $241
80107515:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010751a:	e9 4d f1 ff ff       	jmp    8010666c <alltraps>

8010751f <vector242>:
.globl vector242
vector242:
  pushl $0
8010751f:	6a 00                	push   $0x0
  pushl $242
80107521:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107526:	e9 41 f1 ff ff       	jmp    8010666c <alltraps>

8010752b <vector243>:
.globl vector243
vector243:
  pushl $0
8010752b:	6a 00                	push   $0x0
  pushl $243
8010752d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107532:	e9 35 f1 ff ff       	jmp    8010666c <alltraps>

80107537 <vector244>:
.globl vector244
vector244:
  pushl $0
80107537:	6a 00                	push   $0x0
  pushl $244
80107539:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010753e:	e9 29 f1 ff ff       	jmp    8010666c <alltraps>

80107543 <vector245>:
.globl vector245
vector245:
  pushl $0
80107543:	6a 00                	push   $0x0
  pushl $245
80107545:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010754a:	e9 1d f1 ff ff       	jmp    8010666c <alltraps>

8010754f <vector246>:
.globl vector246
vector246:
  pushl $0
8010754f:	6a 00                	push   $0x0
  pushl $246
80107551:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107556:	e9 11 f1 ff ff       	jmp    8010666c <alltraps>

8010755b <vector247>:
.globl vector247
vector247:
  pushl $0
8010755b:	6a 00                	push   $0x0
  pushl $247
8010755d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107562:	e9 05 f1 ff ff       	jmp    8010666c <alltraps>

80107567 <vector248>:
.globl vector248
vector248:
  pushl $0
80107567:	6a 00                	push   $0x0
  pushl $248
80107569:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010756e:	e9 f9 f0 ff ff       	jmp    8010666c <alltraps>

80107573 <vector249>:
.globl vector249
vector249:
  pushl $0
80107573:	6a 00                	push   $0x0
  pushl $249
80107575:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010757a:	e9 ed f0 ff ff       	jmp    8010666c <alltraps>

8010757f <vector250>:
.globl vector250
vector250:
  pushl $0
8010757f:	6a 00                	push   $0x0
  pushl $250
80107581:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107586:	e9 e1 f0 ff ff       	jmp    8010666c <alltraps>

8010758b <vector251>:
.globl vector251
vector251:
  pushl $0
8010758b:	6a 00                	push   $0x0
  pushl $251
8010758d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107592:	e9 d5 f0 ff ff       	jmp    8010666c <alltraps>

80107597 <vector252>:
.globl vector252
vector252:
  pushl $0
80107597:	6a 00                	push   $0x0
  pushl $252
80107599:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010759e:	e9 c9 f0 ff ff       	jmp    8010666c <alltraps>

801075a3 <vector253>:
.globl vector253
vector253:
  pushl $0
801075a3:	6a 00                	push   $0x0
  pushl $253
801075a5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801075aa:	e9 bd f0 ff ff       	jmp    8010666c <alltraps>

801075af <vector254>:
.globl vector254
vector254:
  pushl $0
801075af:	6a 00                	push   $0x0
  pushl $254
801075b1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801075b6:	e9 b1 f0 ff ff       	jmp    8010666c <alltraps>

801075bb <vector255>:
.globl vector255
vector255:
  pushl $0
801075bb:	6a 00                	push   $0x0
  pushl $255
801075bd:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801075c2:	e9 a5 f0 ff ff       	jmp    8010666c <alltraps>
801075c7:	66 90                	xchg   %ax,%ax
801075c9:	66 90                	xchg   %ax,%ax
801075cb:	66 90                	xchg   %ax,%ax
801075cd:	66 90                	xchg   %ax,%ax
801075cf:	90                   	nop

801075d0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801075d0:	55                   	push   %ebp
801075d1:	89 e5                	mov    %esp,%ebp
801075d3:	57                   	push   %edi
801075d4:	56                   	push   %esi
801075d5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801075d6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
801075dc:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801075e2:	83 ec 1c             	sub    $0x1c,%esp
801075e5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801075e8:	39 d3                	cmp    %edx,%ebx
801075ea:	73 49                	jae    80107635 <deallocuvm.part.0+0x65>
801075ec:	89 c7                	mov    %eax,%edi
801075ee:	eb 0c                	jmp    801075fc <deallocuvm.part.0+0x2c>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801075f0:	83 c0 01             	add    $0x1,%eax
801075f3:	c1 e0 16             	shl    $0x16,%eax
801075f6:	89 c3                	mov    %eax,%ebx
  for(; a  < oldsz; a += PGSIZE){
801075f8:	39 da                	cmp    %ebx,%edx
801075fa:	76 39                	jbe    80107635 <deallocuvm.part.0+0x65>
  pde = &pgdir[PDX(va)];
801075fc:	89 d8                	mov    %ebx,%eax
801075fe:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107601:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
80107604:	f6 c1 01             	test   $0x1,%cl
80107607:	74 e7                	je     801075f0 <deallocuvm.part.0+0x20>
  return &pgtab[PTX(va)];
80107609:	89 de                	mov    %ebx,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010760b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107611:	c1 ee 0a             	shr    $0xa,%esi
80107614:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
8010761a:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
    if(!pte)
80107621:	85 f6                	test   %esi,%esi
80107623:	74 cb                	je     801075f0 <deallocuvm.part.0+0x20>
    else if((*pte & PTE_P) != 0){
80107625:	8b 06                	mov    (%esi),%eax
80107627:	a8 01                	test   $0x1,%al
80107629:	75 15                	jne    80107640 <deallocuvm.part.0+0x70>
  for(; a  < oldsz; a += PGSIZE){
8010762b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107631:	39 da                	cmp    %ebx,%edx
80107633:	77 c7                	ja     801075fc <deallocuvm.part.0+0x2c>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80107635:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107638:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010763b:	5b                   	pop    %ebx
8010763c:	5e                   	pop    %esi
8010763d:	5f                   	pop    %edi
8010763e:	5d                   	pop    %ebp
8010763f:	c3                   	ret    
      if(pa == 0)
80107640:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107645:	74 25                	je     8010766c <deallocuvm.part.0+0x9c>
      kfree(v);
80107647:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010764a:	05 00 00 00 80       	add    $0x80000000,%eax
8010764f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107652:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80107658:	50                   	push   %eax
80107659:	e8 72 ae ff ff       	call   801024d0 <kfree>
      *pte = 0;
8010765e:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(; a  < oldsz; a += PGSIZE){
80107664:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107667:	83 c4 10             	add    $0x10,%esp
8010766a:	eb 8c                	jmp    801075f8 <deallocuvm.part.0+0x28>
        panic("kfree");
8010766c:	83 ec 0c             	sub    $0xc,%esp
8010766f:	68 26 82 10 80       	push   $0x80108226
80107674:	e8 07 8d ff ff       	call   80100380 <panic>
80107679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107680 <mappages>:
{
80107680:	55                   	push   %ebp
80107681:	89 e5                	mov    %esp,%ebp
80107683:	57                   	push   %edi
80107684:	56                   	push   %esi
80107685:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107686:	89 d3                	mov    %edx,%ebx
80107688:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010768e:	83 ec 1c             	sub    $0x1c,%esp
80107691:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107694:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107698:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010769d:	89 45 dc             	mov    %eax,-0x24(%ebp)
801076a0:	8b 45 08             	mov    0x8(%ebp),%eax
801076a3:	29 d8                	sub    %ebx,%eax
801076a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801076a8:	eb 3d                	jmp    801076e7 <mappages+0x67>
801076aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801076b0:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801076b2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801076b7:	c1 ea 0a             	shr    $0xa,%edx
801076ba:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801076c0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801076c7:	85 c0                	test   %eax,%eax
801076c9:	74 75                	je     80107740 <mappages+0xc0>
    if(*pte & PTE_P)
801076cb:	f6 00 01             	testb  $0x1,(%eax)
801076ce:	0f 85 86 00 00 00    	jne    8010775a <mappages+0xda>
    *pte = pa | perm | PTE_P;
801076d4:	0b 75 0c             	or     0xc(%ebp),%esi
801076d7:	83 ce 01             	or     $0x1,%esi
801076da:	89 30                	mov    %esi,(%eax)
    if(a == last)
801076dc:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
801076df:	74 6f                	je     80107750 <mappages+0xd0>
    a += PGSIZE;
801076e1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
801076e7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  pde = &pgdir[PDX(va)];
801076ea:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801076ed:	8d 34 18             	lea    (%eax,%ebx,1),%esi
801076f0:	89 d8                	mov    %ebx,%eax
801076f2:	c1 e8 16             	shr    $0x16,%eax
801076f5:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
801076f8:	8b 07                	mov    (%edi),%eax
801076fa:	a8 01                	test   $0x1,%al
801076fc:	75 b2                	jne    801076b0 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801076fe:	e8 8d af ff ff       	call   80102690 <kalloc>
80107703:	85 c0                	test   %eax,%eax
80107705:	74 39                	je     80107740 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80107707:	83 ec 04             	sub    $0x4,%esp
8010770a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010770d:	68 00 10 00 00       	push   $0x1000
80107712:	6a 00                	push   $0x0
80107714:	50                   	push   %eax
80107715:	e8 56 db ff ff       	call   80105270 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010771a:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
8010771d:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107720:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80107726:	83 c8 07             	or     $0x7,%eax
80107729:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
8010772b:	89 d8                	mov    %ebx,%eax
8010772d:	c1 e8 0a             	shr    $0xa,%eax
80107730:	25 fc 0f 00 00       	and    $0xffc,%eax
80107735:	01 d0                	add    %edx,%eax
80107737:	eb 92                	jmp    801076cb <mappages+0x4b>
80107739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80107740:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107743:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107748:	5b                   	pop    %ebx
80107749:	5e                   	pop    %esi
8010774a:	5f                   	pop    %edi
8010774b:	5d                   	pop    %ebp
8010774c:	c3                   	ret    
8010774d:	8d 76 00             	lea    0x0(%esi),%esi
80107750:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107753:	31 c0                	xor    %eax,%eax
}
80107755:	5b                   	pop    %ebx
80107756:	5e                   	pop    %esi
80107757:	5f                   	pop    %edi
80107758:	5d                   	pop    %ebp
80107759:	c3                   	ret    
      panic("remap");
8010775a:	83 ec 0c             	sub    $0xc,%esp
8010775d:	68 c8 8a 10 80       	push   $0x80108ac8
80107762:	e8 19 8c ff ff       	call   80100380 <panic>
80107767:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010776e:	66 90                	xchg   %ax,%ax

80107770 <seginit>:
{
80107770:	55                   	push   %ebp
80107771:	89 e5                	mov    %esp,%ebp
80107773:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107776:	e8 25 c2 ff ff       	call   801039a0 <cpuid>
  pd[0] = size-1;
8010777b:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107780:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80107786:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010778a:	c7 80 18 28 11 80 ff 	movl   $0xffff,-0x7feed7e8(%eax)
80107791:	ff 00 00 
80107794:	c7 80 1c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7e4(%eax)
8010779b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010779e:	c7 80 20 28 11 80 ff 	movl   $0xffff,-0x7feed7e0(%eax)
801077a5:	ff 00 00 
801077a8:	c7 80 24 28 11 80 00 	movl   $0xcf9200,-0x7feed7dc(%eax)
801077af:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801077b2:	c7 80 28 28 11 80 ff 	movl   $0xffff,-0x7feed7d8(%eax)
801077b9:	ff 00 00 
801077bc:	c7 80 2c 28 11 80 00 	movl   $0xcffa00,-0x7feed7d4(%eax)
801077c3:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801077c6:	c7 80 30 28 11 80 ff 	movl   $0xffff,-0x7feed7d0(%eax)
801077cd:	ff 00 00 
801077d0:	c7 80 34 28 11 80 00 	movl   $0xcff200,-0x7feed7cc(%eax)
801077d7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801077da:	05 10 28 11 80       	add    $0x80112810,%eax
  pd[1] = (uint)p;
801077df:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801077e3:	c1 e8 10             	shr    $0x10,%eax
801077e6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801077ea:	8d 45 f2             	lea    -0xe(%ebp),%eax
801077ed:	0f 01 10             	lgdtl  (%eax)
}
801077f0:	c9                   	leave  
801077f1:	c3                   	ret    
801077f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801077f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107800 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107800:	a1 44 5f 11 80       	mov    0x80115f44,%eax
80107805:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010780a:	0f 22 d8             	mov    %eax,%cr3
}
8010780d:	c3                   	ret    
8010780e:	66 90                	xchg   %ax,%ax

80107810 <switchuvm>:
{
80107810:	55                   	push   %ebp
80107811:	89 e5                	mov    %esp,%ebp
80107813:	57                   	push   %edi
80107814:	56                   	push   %esi
80107815:	53                   	push   %ebx
80107816:	83 ec 1c             	sub    $0x1c,%esp
80107819:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010781c:	85 f6                	test   %esi,%esi
8010781e:	0f 84 cb 00 00 00    	je     801078ef <switchuvm+0xdf>
  if(p->kstack == 0)
80107824:	8b 46 08             	mov    0x8(%esi),%eax
80107827:	85 c0                	test   %eax,%eax
80107829:	0f 84 da 00 00 00    	je     80107909 <switchuvm+0xf9>
  if(p->pgdir == 0)
8010782f:	8b 46 04             	mov    0x4(%esi),%eax
80107832:	85 c0                	test   %eax,%eax
80107834:	0f 84 c2 00 00 00    	je     801078fc <switchuvm+0xec>
  pushcli();
8010783a:	e8 21 d8 ff ff       	call   80105060 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010783f:	e8 fc c0 ff ff       	call   80103940 <mycpu>
80107844:	89 c3                	mov    %eax,%ebx
80107846:	e8 f5 c0 ff ff       	call   80103940 <mycpu>
8010784b:	89 c7                	mov    %eax,%edi
8010784d:	e8 ee c0 ff ff       	call   80103940 <mycpu>
80107852:	83 c7 08             	add    $0x8,%edi
80107855:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107858:	e8 e3 c0 ff ff       	call   80103940 <mycpu>
8010785d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107860:	ba 67 00 00 00       	mov    $0x67,%edx
80107865:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
8010786c:	83 c0 08             	add    $0x8,%eax
8010786f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107876:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010787b:	83 c1 08             	add    $0x8,%ecx
8010787e:	c1 e8 18             	shr    $0x18,%eax
80107881:	c1 e9 10             	shr    $0x10,%ecx
80107884:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010788a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107890:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107895:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010789c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
801078a1:	e8 9a c0 ff ff       	call   80103940 <mycpu>
801078a6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801078ad:	e8 8e c0 ff ff       	call   80103940 <mycpu>
801078b2:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801078b6:	8b 5e 08             	mov    0x8(%esi),%ebx
801078b9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801078bf:	e8 7c c0 ff ff       	call   80103940 <mycpu>
801078c4:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801078c7:	e8 74 c0 ff ff       	call   80103940 <mycpu>
801078cc:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801078d0:	b8 28 00 00 00       	mov    $0x28,%eax
801078d5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801078d8:	8b 46 04             	mov    0x4(%esi),%eax
801078db:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801078e0:	0f 22 d8             	mov    %eax,%cr3
}
801078e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078e6:	5b                   	pop    %ebx
801078e7:	5e                   	pop    %esi
801078e8:	5f                   	pop    %edi
801078e9:	5d                   	pop    %ebp
  popcli();
801078ea:	e9 c1 d7 ff ff       	jmp    801050b0 <popcli>
    panic("switchuvm: no process");
801078ef:	83 ec 0c             	sub    $0xc,%esp
801078f2:	68 ce 8a 10 80       	push   $0x80108ace
801078f7:	e8 84 8a ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
801078fc:	83 ec 0c             	sub    $0xc,%esp
801078ff:	68 f9 8a 10 80       	push   $0x80108af9
80107904:	e8 77 8a ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
80107909:	83 ec 0c             	sub    $0xc,%esp
8010790c:	68 e4 8a 10 80       	push   $0x80108ae4
80107911:	e8 6a 8a ff ff       	call   80100380 <panic>
80107916:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010791d:	8d 76 00             	lea    0x0(%esi),%esi

80107920 <inituvm>:
{
80107920:	55                   	push   %ebp
80107921:	89 e5                	mov    %esp,%ebp
80107923:	57                   	push   %edi
80107924:	56                   	push   %esi
80107925:	53                   	push   %ebx
80107926:	83 ec 1c             	sub    $0x1c,%esp
80107929:	8b 45 0c             	mov    0xc(%ebp),%eax
8010792c:	8b 75 10             	mov    0x10(%ebp),%esi
8010792f:	8b 7d 08             	mov    0x8(%ebp),%edi
80107932:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107935:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010793b:	77 4b                	ja     80107988 <inituvm+0x68>
  mem = kalloc();
8010793d:	e8 4e ad ff ff       	call   80102690 <kalloc>
  memset(mem, 0, PGSIZE);
80107942:	83 ec 04             	sub    $0x4,%esp
80107945:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010794a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
8010794c:	6a 00                	push   $0x0
8010794e:	50                   	push   %eax
8010794f:	e8 1c d9 ff ff       	call   80105270 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107954:	58                   	pop    %eax
80107955:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010795b:	5a                   	pop    %edx
8010795c:	6a 06                	push   $0x6
8010795e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107963:	31 d2                	xor    %edx,%edx
80107965:	50                   	push   %eax
80107966:	89 f8                	mov    %edi,%eax
80107968:	e8 13 fd ff ff       	call   80107680 <mappages>
  memmove(mem, init, sz);
8010796d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107970:	89 75 10             	mov    %esi,0x10(%ebp)
80107973:	83 c4 10             	add    $0x10,%esp
80107976:	89 5d 08             	mov    %ebx,0x8(%ebp)
80107979:	89 45 0c             	mov    %eax,0xc(%ebp)
}
8010797c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010797f:	5b                   	pop    %ebx
80107980:	5e                   	pop    %esi
80107981:	5f                   	pop    %edi
80107982:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107983:	e9 88 d9 ff ff       	jmp    80105310 <memmove>
    panic("inituvm: more than a page");
80107988:	83 ec 0c             	sub    $0xc,%esp
8010798b:	68 0d 8b 10 80       	push   $0x80108b0d
80107990:	e8 eb 89 ff ff       	call   80100380 <panic>
80107995:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010799c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801079a0 <loaduvm>:
{
801079a0:	55                   	push   %ebp
801079a1:	89 e5                	mov    %esp,%ebp
801079a3:	57                   	push   %edi
801079a4:	56                   	push   %esi
801079a5:	53                   	push   %ebx
801079a6:	83 ec 1c             	sub    $0x1c,%esp
801079a9:	8b 45 0c             	mov    0xc(%ebp),%eax
801079ac:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
801079af:	a9 ff 0f 00 00       	test   $0xfff,%eax
801079b4:	0f 85 bb 00 00 00    	jne    80107a75 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
801079ba:	01 f0                	add    %esi,%eax
801079bc:	89 f3                	mov    %esi,%ebx
801079be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
801079c1:	8b 45 14             	mov    0x14(%ebp),%eax
801079c4:	01 f0                	add    %esi,%eax
801079c6:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
801079c9:	85 f6                	test   %esi,%esi
801079cb:	0f 84 87 00 00 00    	je     80107a58 <loaduvm+0xb8>
801079d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
801079d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(*pde & PTE_P){
801079db:	8b 4d 08             	mov    0x8(%ebp),%ecx
801079de:	29 d8                	sub    %ebx,%eax
  pde = &pgdir[PDX(va)];
801079e0:	89 c2                	mov    %eax,%edx
801079e2:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
801079e5:	8b 14 91             	mov    (%ecx,%edx,4),%edx
801079e8:	f6 c2 01             	test   $0x1,%dl
801079eb:	75 13                	jne    80107a00 <loaduvm+0x60>
      panic("loaduvm: address should exist");
801079ed:	83 ec 0c             	sub    $0xc,%esp
801079f0:	68 27 8b 10 80       	push   $0x80108b27
801079f5:	e8 86 89 ff ff       	call   80100380 <panic>
801079fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107a00:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107a03:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107a09:	25 fc 0f 00 00       	and    $0xffc,%eax
80107a0e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107a15:	85 c0                	test   %eax,%eax
80107a17:	74 d4                	je     801079ed <loaduvm+0x4d>
    pa = PTE_ADDR(*pte);
80107a19:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107a1b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
80107a1e:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107a23:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107a28:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80107a2e:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107a31:	29 d9                	sub    %ebx,%ecx
80107a33:	05 00 00 00 80       	add    $0x80000000,%eax
80107a38:	57                   	push   %edi
80107a39:	51                   	push   %ecx
80107a3a:	50                   	push   %eax
80107a3b:	ff 75 10             	push   0x10(%ebp)
80107a3e:	e8 5d a0 ff ff       	call   80101aa0 <readi>
80107a43:	83 c4 10             	add    $0x10,%esp
80107a46:	39 f8                	cmp    %edi,%eax
80107a48:	75 1e                	jne    80107a68 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107a4a:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80107a50:	89 f0                	mov    %esi,%eax
80107a52:	29 d8                	sub    %ebx,%eax
80107a54:	39 c6                	cmp    %eax,%esi
80107a56:	77 80                	ja     801079d8 <loaduvm+0x38>
}
80107a58:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107a5b:	31 c0                	xor    %eax,%eax
}
80107a5d:	5b                   	pop    %ebx
80107a5e:	5e                   	pop    %esi
80107a5f:	5f                   	pop    %edi
80107a60:	5d                   	pop    %ebp
80107a61:	c3                   	ret    
80107a62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107a68:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107a6b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107a70:	5b                   	pop    %ebx
80107a71:	5e                   	pop    %esi
80107a72:	5f                   	pop    %edi
80107a73:	5d                   	pop    %ebp
80107a74:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
80107a75:	83 ec 0c             	sub    $0xc,%esp
80107a78:	68 c8 8b 10 80       	push   $0x80108bc8
80107a7d:	e8 fe 88 ff ff       	call   80100380 <panic>
80107a82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107a90 <allocuvm>:
{
80107a90:	55                   	push   %ebp
80107a91:	89 e5                	mov    %esp,%ebp
80107a93:	57                   	push   %edi
80107a94:	56                   	push   %esi
80107a95:	53                   	push   %ebx
80107a96:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107a99:	8b 45 10             	mov    0x10(%ebp),%eax
{
80107a9c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
80107a9f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107aa2:	85 c0                	test   %eax,%eax
80107aa4:	0f 88 b6 00 00 00    	js     80107b60 <allocuvm+0xd0>
  if(newsz < oldsz)
80107aaa:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
80107aad:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80107ab0:	0f 82 9a 00 00 00    	jb     80107b50 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80107ab6:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80107abc:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80107ac2:	39 75 10             	cmp    %esi,0x10(%ebp)
80107ac5:	77 44                	ja     80107b0b <allocuvm+0x7b>
80107ac7:	e9 87 00 00 00       	jmp    80107b53 <allocuvm+0xc3>
80107acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80107ad0:	83 ec 04             	sub    $0x4,%esp
80107ad3:	68 00 10 00 00       	push   $0x1000
80107ad8:	6a 00                	push   $0x0
80107ada:	50                   	push   %eax
80107adb:	e8 90 d7 ff ff       	call   80105270 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107ae0:	58                   	pop    %eax
80107ae1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107ae7:	5a                   	pop    %edx
80107ae8:	6a 06                	push   $0x6
80107aea:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107aef:	89 f2                	mov    %esi,%edx
80107af1:	50                   	push   %eax
80107af2:	89 f8                	mov    %edi,%eax
80107af4:	e8 87 fb ff ff       	call   80107680 <mappages>
80107af9:	83 c4 10             	add    $0x10,%esp
80107afc:	85 c0                	test   %eax,%eax
80107afe:	78 78                	js     80107b78 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80107b00:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107b06:	39 75 10             	cmp    %esi,0x10(%ebp)
80107b09:	76 48                	jbe    80107b53 <allocuvm+0xc3>
    mem = kalloc();
80107b0b:	e8 80 ab ff ff       	call   80102690 <kalloc>
80107b10:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107b12:	85 c0                	test   %eax,%eax
80107b14:	75 ba                	jne    80107ad0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80107b16:	83 ec 0c             	sub    $0xc,%esp
80107b19:	68 45 8b 10 80       	push   $0x80108b45
80107b1e:	e8 7d 8b ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
80107b23:	8b 45 0c             	mov    0xc(%ebp),%eax
80107b26:	83 c4 10             	add    $0x10,%esp
80107b29:	39 45 10             	cmp    %eax,0x10(%ebp)
80107b2c:	74 32                	je     80107b60 <allocuvm+0xd0>
80107b2e:	8b 55 10             	mov    0x10(%ebp),%edx
80107b31:	89 c1                	mov    %eax,%ecx
80107b33:	89 f8                	mov    %edi,%eax
80107b35:	e8 96 fa ff ff       	call   801075d0 <deallocuvm.part.0>
      return 0;
80107b3a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107b41:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107b44:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b47:	5b                   	pop    %ebx
80107b48:	5e                   	pop    %esi
80107b49:	5f                   	pop    %edi
80107b4a:	5d                   	pop    %ebp
80107b4b:	c3                   	ret    
80107b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107b50:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80107b53:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107b56:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b59:	5b                   	pop    %ebx
80107b5a:	5e                   	pop    %esi
80107b5b:	5f                   	pop    %edi
80107b5c:	5d                   	pop    %ebp
80107b5d:	c3                   	ret    
80107b5e:	66 90                	xchg   %ax,%ax
    return 0;
80107b60:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107b67:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107b6a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b6d:	5b                   	pop    %ebx
80107b6e:	5e                   	pop    %esi
80107b6f:	5f                   	pop    %edi
80107b70:	5d                   	pop    %ebp
80107b71:	c3                   	ret    
80107b72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107b78:	83 ec 0c             	sub    $0xc,%esp
80107b7b:	68 5d 8b 10 80       	push   $0x80108b5d
80107b80:	e8 1b 8b ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
80107b85:	8b 45 0c             	mov    0xc(%ebp),%eax
80107b88:	83 c4 10             	add    $0x10,%esp
80107b8b:	39 45 10             	cmp    %eax,0x10(%ebp)
80107b8e:	74 0c                	je     80107b9c <allocuvm+0x10c>
80107b90:	8b 55 10             	mov    0x10(%ebp),%edx
80107b93:	89 c1                	mov    %eax,%ecx
80107b95:	89 f8                	mov    %edi,%eax
80107b97:	e8 34 fa ff ff       	call   801075d0 <deallocuvm.part.0>
      kfree(mem);
80107b9c:	83 ec 0c             	sub    $0xc,%esp
80107b9f:	53                   	push   %ebx
80107ba0:	e8 2b a9 ff ff       	call   801024d0 <kfree>
      return 0;
80107ba5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80107bac:	83 c4 10             	add    $0x10,%esp
}
80107baf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107bb2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107bb5:	5b                   	pop    %ebx
80107bb6:	5e                   	pop    %esi
80107bb7:	5f                   	pop    %edi
80107bb8:	5d                   	pop    %ebp
80107bb9:	c3                   	ret    
80107bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107bc0 <deallocuvm>:
{
80107bc0:	55                   	push   %ebp
80107bc1:	89 e5                	mov    %esp,%ebp
80107bc3:	8b 55 0c             	mov    0xc(%ebp),%edx
80107bc6:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107bc9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80107bcc:	39 d1                	cmp    %edx,%ecx
80107bce:	73 10                	jae    80107be0 <deallocuvm+0x20>
}
80107bd0:	5d                   	pop    %ebp
80107bd1:	e9 fa f9 ff ff       	jmp    801075d0 <deallocuvm.part.0>
80107bd6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107bdd:	8d 76 00             	lea    0x0(%esi),%esi
80107be0:	89 d0                	mov    %edx,%eax
80107be2:	5d                   	pop    %ebp
80107be3:	c3                   	ret    
80107be4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107beb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107bef:	90                   	nop

80107bf0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107bf0:	55                   	push   %ebp
80107bf1:	89 e5                	mov    %esp,%ebp
80107bf3:	57                   	push   %edi
80107bf4:	56                   	push   %esi
80107bf5:	53                   	push   %ebx
80107bf6:	83 ec 0c             	sub    $0xc,%esp
80107bf9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80107bfc:	85 f6                	test   %esi,%esi
80107bfe:	74 59                	je     80107c59 <freevm+0x69>
  if(newsz >= oldsz)
80107c00:	31 c9                	xor    %ecx,%ecx
80107c02:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107c07:	89 f0                	mov    %esi,%eax
80107c09:	89 f3                	mov    %esi,%ebx
80107c0b:	e8 c0 f9 ff ff       	call   801075d0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107c10:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107c16:	eb 0f                	jmp    80107c27 <freevm+0x37>
80107c18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c1f:	90                   	nop
80107c20:	83 c3 04             	add    $0x4,%ebx
80107c23:	39 df                	cmp    %ebx,%edi
80107c25:	74 23                	je     80107c4a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107c27:	8b 03                	mov    (%ebx),%eax
80107c29:	a8 01                	test   $0x1,%al
80107c2b:	74 f3                	je     80107c20 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107c2d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107c32:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107c35:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107c38:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80107c3d:	50                   	push   %eax
80107c3e:	e8 8d a8 ff ff       	call   801024d0 <kfree>
80107c43:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107c46:	39 df                	cmp    %ebx,%edi
80107c48:	75 dd                	jne    80107c27 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80107c4a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107c4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107c50:	5b                   	pop    %ebx
80107c51:	5e                   	pop    %esi
80107c52:	5f                   	pop    %edi
80107c53:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107c54:	e9 77 a8 ff ff       	jmp    801024d0 <kfree>
    panic("freevm: no pgdir");
80107c59:	83 ec 0c             	sub    $0xc,%esp
80107c5c:	68 79 8b 10 80       	push   $0x80108b79
80107c61:	e8 1a 87 ff ff       	call   80100380 <panic>
80107c66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c6d:	8d 76 00             	lea    0x0(%esi),%esi

80107c70 <setupkvm>:
{
80107c70:	55                   	push   %ebp
80107c71:	89 e5                	mov    %esp,%ebp
80107c73:	56                   	push   %esi
80107c74:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107c75:	e8 16 aa ff ff       	call   80102690 <kalloc>
80107c7a:	89 c6                	mov    %eax,%esi
80107c7c:	85 c0                	test   %eax,%eax
80107c7e:	74 42                	je     80107cc2 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107c80:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107c83:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107c88:	68 00 10 00 00       	push   $0x1000
80107c8d:	6a 00                	push   $0x0
80107c8f:	50                   	push   %eax
80107c90:	e8 db d5 ff ff       	call   80105270 <memset>
80107c95:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107c98:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107c9b:	83 ec 08             	sub    $0x8,%esp
80107c9e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107ca1:	ff 73 0c             	push   0xc(%ebx)
80107ca4:	8b 13                	mov    (%ebx),%edx
80107ca6:	50                   	push   %eax
80107ca7:	29 c1                	sub    %eax,%ecx
80107ca9:	89 f0                	mov    %esi,%eax
80107cab:	e8 d0 f9 ff ff       	call   80107680 <mappages>
80107cb0:	83 c4 10             	add    $0x10,%esp
80107cb3:	85 c0                	test   %eax,%eax
80107cb5:	78 19                	js     80107cd0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107cb7:	83 c3 10             	add    $0x10,%ebx
80107cba:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107cc0:	75 d6                	jne    80107c98 <setupkvm+0x28>
}
80107cc2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107cc5:	89 f0                	mov    %esi,%eax
80107cc7:	5b                   	pop    %ebx
80107cc8:	5e                   	pop    %esi
80107cc9:	5d                   	pop    %ebp
80107cca:	c3                   	ret    
80107ccb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107ccf:	90                   	nop
      freevm(pgdir);
80107cd0:	83 ec 0c             	sub    $0xc,%esp
80107cd3:	56                   	push   %esi
      return 0;
80107cd4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107cd6:	e8 15 ff ff ff       	call   80107bf0 <freevm>
      return 0;
80107cdb:	83 c4 10             	add    $0x10,%esp
}
80107cde:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107ce1:	89 f0                	mov    %esi,%eax
80107ce3:	5b                   	pop    %ebx
80107ce4:	5e                   	pop    %esi
80107ce5:	5d                   	pop    %ebp
80107ce6:	c3                   	ret    
80107ce7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107cee:	66 90                	xchg   %ax,%ax

80107cf0 <kvmalloc>:
{
80107cf0:	55                   	push   %ebp
80107cf1:	89 e5                	mov    %esp,%ebp
80107cf3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107cf6:	e8 75 ff ff ff       	call   80107c70 <setupkvm>
80107cfb:	a3 44 5f 11 80       	mov    %eax,0x80115f44
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107d00:	05 00 00 00 80       	add    $0x80000000,%eax
80107d05:	0f 22 d8             	mov    %eax,%cr3
}
80107d08:	c9                   	leave  
80107d09:	c3                   	ret    
80107d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107d10 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107d10:	55                   	push   %ebp
80107d11:	89 e5                	mov    %esp,%ebp
80107d13:	83 ec 08             	sub    $0x8,%esp
80107d16:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107d19:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107d1c:	89 c1                	mov    %eax,%ecx
80107d1e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107d21:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107d24:	f6 c2 01             	test   $0x1,%dl
80107d27:	75 17                	jne    80107d40 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107d29:	83 ec 0c             	sub    $0xc,%esp
80107d2c:	68 8a 8b 10 80       	push   $0x80108b8a
80107d31:	e8 4a 86 ff ff       	call   80100380 <panic>
80107d36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107d3d:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107d40:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107d43:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107d49:	25 fc 0f 00 00       	and    $0xffc,%eax
80107d4e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107d55:	85 c0                	test   %eax,%eax
80107d57:	74 d0                	je     80107d29 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107d59:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107d5c:	c9                   	leave  
80107d5d:	c3                   	ret    
80107d5e:	66 90                	xchg   %ax,%ax

80107d60 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107d60:	55                   	push   %ebp
80107d61:	89 e5                	mov    %esp,%ebp
80107d63:	57                   	push   %edi
80107d64:	56                   	push   %esi
80107d65:	53                   	push   %ebx
80107d66:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107d69:	e8 02 ff ff ff       	call   80107c70 <setupkvm>
80107d6e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107d71:	85 c0                	test   %eax,%eax
80107d73:	0f 84 bd 00 00 00    	je     80107e36 <copyuvm+0xd6>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107d79:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107d7c:	85 c9                	test   %ecx,%ecx
80107d7e:	0f 84 b2 00 00 00    	je     80107e36 <copyuvm+0xd6>
80107d84:	31 f6                	xor    %esi,%esi
80107d86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107d8d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*pde & PTE_P){
80107d90:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107d93:	89 f0                	mov    %esi,%eax
80107d95:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107d98:	8b 04 81             	mov    (%ecx,%eax,4),%eax
80107d9b:	a8 01                	test   $0x1,%al
80107d9d:	75 11                	jne    80107db0 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80107d9f:	83 ec 0c             	sub    $0xc,%esp
80107da2:	68 94 8b 10 80       	push   $0x80108b94
80107da7:	e8 d4 85 ff ff       	call   80100380 <panic>
80107dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107db0:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107db2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107db7:	c1 ea 0a             	shr    $0xa,%edx
80107dba:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107dc0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107dc7:	85 c0                	test   %eax,%eax
80107dc9:	74 d4                	je     80107d9f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
80107dcb:	8b 00                	mov    (%eax),%eax
80107dcd:	a8 01                	test   $0x1,%al
80107dcf:	0f 84 9f 00 00 00    	je     80107e74 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107dd5:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107dd7:	25 ff 0f 00 00       	and    $0xfff,%eax
80107ddc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80107ddf:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107de5:	e8 a6 a8 ff ff       	call   80102690 <kalloc>
80107dea:	89 c3                	mov    %eax,%ebx
80107dec:	85 c0                	test   %eax,%eax
80107dee:	74 64                	je     80107e54 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107df0:	83 ec 04             	sub    $0x4,%esp
80107df3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107df9:	68 00 10 00 00       	push   $0x1000
80107dfe:	57                   	push   %edi
80107dff:	50                   	push   %eax
80107e00:	e8 0b d5 ff ff       	call   80105310 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107e05:	58                   	pop    %eax
80107e06:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107e0c:	5a                   	pop    %edx
80107e0d:	ff 75 e4             	push   -0x1c(%ebp)
80107e10:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107e15:	89 f2                	mov    %esi,%edx
80107e17:	50                   	push   %eax
80107e18:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107e1b:	e8 60 f8 ff ff       	call   80107680 <mappages>
80107e20:	83 c4 10             	add    $0x10,%esp
80107e23:	85 c0                	test   %eax,%eax
80107e25:	78 21                	js     80107e48 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
80107e27:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107e2d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107e30:	0f 87 5a ff ff ff    	ja     80107d90 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80107e36:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107e39:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107e3c:	5b                   	pop    %ebx
80107e3d:	5e                   	pop    %esi
80107e3e:	5f                   	pop    %edi
80107e3f:	5d                   	pop    %ebp
80107e40:	c3                   	ret    
80107e41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107e48:	83 ec 0c             	sub    $0xc,%esp
80107e4b:	53                   	push   %ebx
80107e4c:	e8 7f a6 ff ff       	call   801024d0 <kfree>
      goto bad;
80107e51:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80107e54:	83 ec 0c             	sub    $0xc,%esp
80107e57:	ff 75 e0             	push   -0x20(%ebp)
80107e5a:	e8 91 fd ff ff       	call   80107bf0 <freevm>
  return 0;
80107e5f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107e66:	83 c4 10             	add    $0x10,%esp
}
80107e69:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107e6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107e6f:	5b                   	pop    %ebx
80107e70:	5e                   	pop    %esi
80107e71:	5f                   	pop    %edi
80107e72:	5d                   	pop    %ebp
80107e73:	c3                   	ret    
      panic("copyuvm: page not present");
80107e74:	83 ec 0c             	sub    $0xc,%esp
80107e77:	68 ae 8b 10 80       	push   $0x80108bae
80107e7c:	e8 ff 84 ff ff       	call   80100380 <panic>
80107e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e8f:	90                   	nop

80107e90 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107e90:	55                   	push   %ebp
80107e91:	89 e5                	mov    %esp,%ebp
80107e93:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107e96:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107e99:	89 c1                	mov    %eax,%ecx
80107e9b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107e9e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107ea1:	f6 c2 01             	test   $0x1,%dl
80107ea4:	0f 84 00 01 00 00    	je     80107faa <uva2ka.cold>
  return &pgtab[PTX(va)];
80107eaa:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107ead:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107eb3:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107eb4:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107eb9:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
80107ec0:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107ec2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107ec7:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107eca:	05 00 00 00 80       	add    $0x80000000,%eax
80107ecf:	83 fa 05             	cmp    $0x5,%edx
80107ed2:	ba 00 00 00 00       	mov    $0x0,%edx
80107ed7:	0f 45 c2             	cmovne %edx,%eax
}
80107eda:	c3                   	ret    
80107edb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107edf:	90                   	nop

80107ee0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107ee0:	55                   	push   %ebp
80107ee1:	89 e5                	mov    %esp,%ebp
80107ee3:	57                   	push   %edi
80107ee4:	56                   	push   %esi
80107ee5:	53                   	push   %ebx
80107ee6:	83 ec 0c             	sub    $0xc,%esp
80107ee9:	8b 75 14             	mov    0x14(%ebp),%esi
80107eec:	8b 45 0c             	mov    0xc(%ebp),%eax
80107eef:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107ef2:	85 f6                	test   %esi,%esi
80107ef4:	75 51                	jne    80107f47 <copyout+0x67>
80107ef6:	e9 a5 00 00 00       	jmp    80107fa0 <copyout+0xc0>
80107efb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107eff:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
80107f00:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107f06:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
80107f0c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107f12:	74 75                	je     80107f89 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
80107f14:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107f16:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
80107f19:	29 c3                	sub    %eax,%ebx
80107f1b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107f21:	39 f3                	cmp    %esi,%ebx
80107f23:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
80107f26:	29 f8                	sub    %edi,%eax
80107f28:	83 ec 04             	sub    $0x4,%esp
80107f2b:	01 c1                	add    %eax,%ecx
80107f2d:	53                   	push   %ebx
80107f2e:	52                   	push   %edx
80107f2f:	51                   	push   %ecx
80107f30:	e8 db d3 ff ff       	call   80105310 <memmove>
    len -= n;
    buf += n;
80107f35:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107f38:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
80107f3e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107f41:	01 da                	add    %ebx,%edx
  while(len > 0){
80107f43:	29 de                	sub    %ebx,%esi
80107f45:	74 59                	je     80107fa0 <copyout+0xc0>
  if(*pde & PTE_P){
80107f47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
80107f4a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107f4c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
80107f4e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107f51:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80107f57:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
80107f5a:	f6 c1 01             	test   $0x1,%cl
80107f5d:	0f 84 4e 00 00 00    	je     80107fb1 <copyout.cold>
  return &pgtab[PTX(va)];
80107f63:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107f65:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107f6b:	c1 eb 0c             	shr    $0xc,%ebx
80107f6e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107f74:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
80107f7b:	89 d9                	mov    %ebx,%ecx
80107f7d:	83 e1 05             	and    $0x5,%ecx
80107f80:	83 f9 05             	cmp    $0x5,%ecx
80107f83:	0f 84 77 ff ff ff    	je     80107f00 <copyout+0x20>
  }
  return 0;
}
80107f89:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107f8c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107f91:	5b                   	pop    %ebx
80107f92:	5e                   	pop    %esi
80107f93:	5f                   	pop    %edi
80107f94:	5d                   	pop    %ebp
80107f95:	c3                   	ret    
80107f96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107f9d:	8d 76 00             	lea    0x0(%esi),%esi
80107fa0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107fa3:	31 c0                	xor    %eax,%eax
}
80107fa5:	5b                   	pop    %ebx
80107fa6:	5e                   	pop    %esi
80107fa7:	5f                   	pop    %edi
80107fa8:	5d                   	pop    %ebp
80107fa9:	c3                   	ret    

80107faa <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
80107faa:	a1 00 00 00 00       	mov    0x0,%eax
80107faf:	0f 0b                	ud2    

80107fb1 <copyout.cold>:
80107fb1:	a1 00 00 00 00       	mov    0x0,%eax
80107fb6:	0f 0b                	ud2    
