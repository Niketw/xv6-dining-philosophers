
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	push   -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 0c             	sub    $0xc,%esp
      11:	68 96 4d 00 00       	push   $0x4d96
      16:	6a 01                	push   $0x1
      18:	e8 63 3a 00 00       	call   3a80 <printf>
      1d:	59                   	pop    %ecx
      1e:	58                   	pop    %eax
      1f:	6a 00                	push   $0x0
      21:	68 aa 4d 00 00       	push   $0x4daa
      26:	e8 e8 38 00 00       	call   3913 <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	85 c0                	test   %eax,%eax
      30:	78 13                	js     45 <main+0x45>
      32:	52                   	push   %edx
      33:	52                   	push   %edx
      34:	68 14 55 00 00       	push   $0x5514
      39:	6a 01                	push   $0x1
      3b:	e8 40 3a 00 00       	call   3a80 <printf>
      40:	e8 8e 38 00 00       	call   38d3 <exit>
      45:	50                   	push   %eax
      46:	50                   	push   %eax
      47:	68 00 02 00 00       	push   $0x200
      4c:	68 aa 4d 00 00       	push   $0x4daa
      51:	e8 bd 38 00 00       	call   3913 <open>
      56:	89 04 24             	mov    %eax,(%esp)
      59:	e8 9d 38 00 00       	call   38fb <close>
      5e:	e8 8d 35 00 00       	call   35f0 <argptest>
      63:	e8 b8 11 00 00       	call   1220 <createdelete>
      68:	e8 73 1a 00 00       	call   1ae0 <linkunlink>
      6d:	e8 6e 17 00 00       	call   17e0 <concreate>
      72:	e8 a9 0f 00 00       	call   1020 <fourfiles>
      77:	e8 e4 0d 00 00       	call   e60 <sharedfd>
      7c:	e8 2f 32 00 00       	call   32b0 <bigargtest>
      81:	e8 7a 23 00 00       	call   2400 <bigwrite>
      86:	e8 25 32 00 00       	call   32b0 <bigargtest>
      8b:	e8 b0 31 00 00       	call   3240 <bsstest>
      90:	e8 ab 2c 00 00       	call   2d40 <sbrktest>
      95:	e8 f6 30 00 00       	call   3190 <validatetest>
      9a:	e8 61 03 00 00       	call   400 <opentest>
      9f:	e8 ec 03 00 00       	call   490 <writetest>
      a4:	e8 c7 05 00 00       	call   670 <writetest1>
      a9:	e8 92 07 00 00       	call   840 <createtest>
      ae:	e8 4d 02 00 00       	call   300 <openiputtest>
      b3:	e8 48 01 00 00       	call   200 <exitiputtest>
      b8:	e8 63 00 00 00       	call   120 <iputtest>
      bd:	e8 ce 0c 00 00       	call   d90 <mem>
      c2:	e8 59 09 00 00       	call   a20 <pipe1>
      c7:	e8 e4 0a 00 00       	call   bb0 <preempt>
      cc:	e8 3f 0c 00 00       	call   d10 <exitwait>
      d1:	e8 1a 27 00 00       	call   27f0 <rmdot>
      d6:	e8 d5 25 00 00       	call   26b0 <fourteen>
      db:	e8 00 24 00 00       	call   24e0 <bigfile>
      e0:	e8 3b 1c 00 00       	call   1d20 <subdir>
      e5:	e8 e6 14 00 00       	call   15d0 <linktest>
      ea:	e8 51 13 00 00       	call   1440 <unlinkread>
      ef:	e8 7c 28 00 00       	call   2970 <dirfile>
      f4:	e8 77 2a 00 00       	call   2b70 <iref>
      f9:	e8 92 2b 00 00       	call   2c90 <forktest>
      fe:	e8 ed 1a 00 00       	call   1bf0 <bigdir>
     103:	e8 78 34 00 00       	call   3580 <uio>
     108:	e8 c3 08 00 00       	call   9d0 <exectest>
     10d:	e8 c1 37 00 00       	call   38d3 <exit>
     112:	66 90                	xchg   %ax,%ax
     114:	66 90                	xchg   %ax,%ax
     116:	66 90                	xchg   %ax,%ax
     118:	66 90                	xchg   %ax,%ax
     11a:	66 90                	xchg   %ax,%ax
     11c:	66 90                	xchg   %ax,%ax
     11e:	66 90                	xchg   %ax,%ax

00000120 <iputtest>:
     120:	55                   	push   %ebp
     121:	89 e5                	mov    %esp,%ebp
     123:	83 ec 10             	sub    $0x10,%esp
     126:	68 3c 3e 00 00       	push   $0x3e3c
     12b:	ff 35 98 5e 00 00    	push   0x5e98
     131:	e8 4a 39 00 00       	call   3a80 <printf>
     136:	c7 04 24 cf 3d 00 00 	movl   $0x3dcf,(%esp)
     13d:	e8 f9 37 00 00       	call   393b <mkdir>
     142:	83 c4 10             	add    $0x10,%esp
     145:	85 c0                	test   %eax,%eax
     147:	78 58                	js     1a1 <iputtest+0x81>
     149:	83 ec 0c             	sub    $0xc,%esp
     14c:	68 cf 3d 00 00       	push   $0x3dcf
     151:	e8 ed 37 00 00       	call   3943 <chdir>
     156:	83 c4 10             	add    $0x10,%esp
     159:	85 c0                	test   %eax,%eax
     15b:	0f 88 85 00 00 00    	js     1e6 <iputtest+0xc6>
     161:	83 ec 0c             	sub    $0xc,%esp
     164:	68 cc 3d 00 00       	push   $0x3dcc
     169:	e8 b5 37 00 00       	call   3923 <unlink>
     16e:	83 c4 10             	add    $0x10,%esp
     171:	85 c0                	test   %eax,%eax
     173:	78 5a                	js     1cf <iputtest+0xaf>
     175:	83 ec 0c             	sub    $0xc,%esp
     178:	68 f1 3d 00 00       	push   $0x3df1
     17d:	e8 c1 37 00 00       	call   3943 <chdir>
     182:	83 c4 10             	add    $0x10,%esp
     185:	85 c0                	test   %eax,%eax
     187:	78 2f                	js     1b8 <iputtest+0x98>
     189:	83 ec 08             	sub    $0x8,%esp
     18c:	68 74 3e 00 00       	push   $0x3e74
     191:	ff 35 98 5e 00 00    	push   0x5e98
     197:	e8 e4 38 00 00       	call   3a80 <printf>
     19c:	83 c4 10             	add    $0x10,%esp
     19f:	c9                   	leave  
     1a0:	c3                   	ret    
     1a1:	50                   	push   %eax
     1a2:	50                   	push   %eax
     1a3:	68 a8 3d 00 00       	push   $0x3da8
     1a8:	ff 35 98 5e 00 00    	push   0x5e98
     1ae:	e8 cd 38 00 00       	call   3a80 <printf>
     1b3:	e8 1b 37 00 00       	call   38d3 <exit>
     1b8:	50                   	push   %eax
     1b9:	50                   	push   %eax
     1ba:	68 f3 3d 00 00       	push   $0x3df3
     1bf:	ff 35 98 5e 00 00    	push   0x5e98
     1c5:	e8 b6 38 00 00       	call   3a80 <printf>
     1ca:	e8 04 37 00 00       	call   38d3 <exit>
     1cf:	52                   	push   %edx
     1d0:	52                   	push   %edx
     1d1:	68 d7 3d 00 00       	push   $0x3dd7
     1d6:	ff 35 98 5e 00 00    	push   0x5e98
     1dc:	e8 9f 38 00 00       	call   3a80 <printf>
     1e1:	e8 ed 36 00 00       	call   38d3 <exit>
     1e6:	51                   	push   %ecx
     1e7:	51                   	push   %ecx
     1e8:	68 b6 3d 00 00       	push   $0x3db6
     1ed:	ff 35 98 5e 00 00    	push   0x5e98
     1f3:	e8 88 38 00 00       	call   3a80 <printf>
     1f8:	e8 d6 36 00 00       	call   38d3 <exit>
     1fd:	8d 76 00             	lea    0x0(%esi),%esi

00000200 <exitiputtest>:
     200:	55                   	push   %ebp
     201:	89 e5                	mov    %esp,%ebp
     203:	83 ec 10             	sub    $0x10,%esp
     206:	68 03 3e 00 00       	push   $0x3e03
     20b:	ff 35 98 5e 00 00    	push   0x5e98
     211:	e8 6a 38 00 00       	call   3a80 <printf>
     216:	e8 b0 36 00 00       	call   38cb <fork>
     21b:	83 c4 10             	add    $0x10,%esp
     21e:	85 c0                	test   %eax,%eax
     220:	0f 88 8a 00 00 00    	js     2b0 <exitiputtest+0xb0>
     226:	75 50                	jne    278 <exitiputtest+0x78>
     228:	83 ec 0c             	sub    $0xc,%esp
     22b:	68 cf 3d 00 00       	push   $0x3dcf
     230:	e8 06 37 00 00       	call   393b <mkdir>
     235:	83 c4 10             	add    $0x10,%esp
     238:	85 c0                	test   %eax,%eax
     23a:	0f 88 87 00 00 00    	js     2c7 <exitiputtest+0xc7>
     240:	83 ec 0c             	sub    $0xc,%esp
     243:	68 cf 3d 00 00       	push   $0x3dcf
     248:	e8 f6 36 00 00       	call   3943 <chdir>
     24d:	83 c4 10             	add    $0x10,%esp
     250:	85 c0                	test   %eax,%eax
     252:	0f 88 86 00 00 00    	js     2de <exitiputtest+0xde>
     258:	83 ec 0c             	sub    $0xc,%esp
     25b:	68 cc 3d 00 00       	push   $0x3dcc
     260:	e8 be 36 00 00       	call   3923 <unlink>
     265:	83 c4 10             	add    $0x10,%esp
     268:	85 c0                	test   %eax,%eax
     26a:	78 2c                	js     298 <exitiputtest+0x98>
     26c:	e8 62 36 00 00       	call   38d3 <exit>
     271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     278:	e8 5e 36 00 00       	call   38db <wait>
     27d:	83 ec 08             	sub    $0x8,%esp
     280:	68 26 3e 00 00       	push   $0x3e26
     285:	ff 35 98 5e 00 00    	push   0x5e98
     28b:	e8 f0 37 00 00       	call   3a80 <printf>
     290:	83 c4 10             	add    $0x10,%esp
     293:	c9                   	leave  
     294:	c3                   	ret    
     295:	8d 76 00             	lea    0x0(%esi),%esi
     298:	83 ec 08             	sub    $0x8,%esp
     29b:	68 d7 3d 00 00       	push   $0x3dd7
     2a0:	ff 35 98 5e 00 00    	push   0x5e98
     2a6:	e8 d5 37 00 00       	call   3a80 <printf>
     2ab:	e8 23 36 00 00       	call   38d3 <exit>
     2b0:	51                   	push   %ecx
     2b1:	51                   	push   %ecx
     2b2:	68 e9 4c 00 00       	push   $0x4ce9
     2b7:	ff 35 98 5e 00 00    	push   0x5e98
     2bd:	e8 be 37 00 00       	call   3a80 <printf>
     2c2:	e8 0c 36 00 00       	call   38d3 <exit>
     2c7:	52                   	push   %edx
     2c8:	52                   	push   %edx
     2c9:	68 a8 3d 00 00       	push   $0x3da8
     2ce:	ff 35 98 5e 00 00    	push   0x5e98
     2d4:	e8 a7 37 00 00       	call   3a80 <printf>
     2d9:	e8 f5 35 00 00       	call   38d3 <exit>
     2de:	50                   	push   %eax
     2df:	50                   	push   %eax
     2e0:	68 12 3e 00 00       	push   $0x3e12
     2e5:	ff 35 98 5e 00 00    	push   0x5e98
     2eb:	e8 90 37 00 00       	call   3a80 <printf>
     2f0:	e8 de 35 00 00       	call   38d3 <exit>
     2f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     2fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000300 <openiputtest>:
     300:	55                   	push   %ebp
     301:	89 e5                	mov    %esp,%ebp
     303:	83 ec 10             	sub    $0x10,%esp
     306:	68 38 3e 00 00       	push   $0x3e38
     30b:	ff 35 98 5e 00 00    	push   0x5e98
     311:	e8 6a 37 00 00       	call   3a80 <printf>
     316:	c7 04 24 47 3e 00 00 	movl   $0x3e47,(%esp)
     31d:	e8 19 36 00 00       	call   393b <mkdir>
     322:	83 c4 10             	add    $0x10,%esp
     325:	85 c0                	test   %eax,%eax
     327:	0f 88 9f 00 00 00    	js     3cc <openiputtest+0xcc>
     32d:	e8 99 35 00 00       	call   38cb <fork>
     332:	85 c0                	test   %eax,%eax
     334:	78 7f                	js     3b5 <openiputtest+0xb5>
     336:	75 38                	jne    370 <openiputtest+0x70>
     338:	83 ec 08             	sub    $0x8,%esp
     33b:	6a 02                	push   $0x2
     33d:	68 47 3e 00 00       	push   $0x3e47
     342:	e8 cc 35 00 00       	call   3913 <open>
     347:	83 c4 10             	add    $0x10,%esp
     34a:	85 c0                	test   %eax,%eax
     34c:	78 62                	js     3b0 <openiputtest+0xb0>
     34e:	83 ec 08             	sub    $0x8,%esp
     351:	68 cc 4d 00 00       	push   $0x4dcc
     356:	ff 35 98 5e 00 00    	push   0x5e98
     35c:	e8 1f 37 00 00       	call   3a80 <printf>
     361:	e8 6d 35 00 00       	call   38d3 <exit>
     366:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     36d:	8d 76 00             	lea    0x0(%esi),%esi
     370:	83 ec 0c             	sub    $0xc,%esp
     373:	6a 01                	push   $0x1
     375:	e8 e9 35 00 00       	call   3963 <sleep>
     37a:	c7 04 24 47 3e 00 00 	movl   $0x3e47,(%esp)
     381:	e8 9d 35 00 00       	call   3923 <unlink>
     386:	83 c4 10             	add    $0x10,%esp
     389:	85 c0                	test   %eax,%eax
     38b:	75 56                	jne    3e3 <openiputtest+0xe3>
     38d:	e8 49 35 00 00       	call   38db <wait>
     392:	83 ec 08             	sub    $0x8,%esp
     395:	68 70 3e 00 00       	push   $0x3e70
     39a:	ff 35 98 5e 00 00    	push   0x5e98
     3a0:	e8 db 36 00 00       	call   3a80 <printf>
     3a5:	83 c4 10             	add    $0x10,%esp
     3a8:	c9                   	leave  
     3a9:	c3                   	ret    
     3aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     3b0:	e8 1e 35 00 00       	call   38d3 <exit>
     3b5:	52                   	push   %edx
     3b6:	52                   	push   %edx
     3b7:	68 e9 4c 00 00       	push   $0x4ce9
     3bc:	ff 35 98 5e 00 00    	push   0x5e98
     3c2:	e8 b9 36 00 00       	call   3a80 <printf>
     3c7:	e8 07 35 00 00       	call   38d3 <exit>
     3cc:	51                   	push   %ecx
     3cd:	51                   	push   %ecx
     3ce:	68 4d 3e 00 00       	push   $0x3e4d
     3d3:	ff 35 98 5e 00 00    	push   0x5e98
     3d9:	e8 a2 36 00 00       	call   3a80 <printf>
     3de:	e8 f0 34 00 00       	call   38d3 <exit>
     3e3:	50                   	push   %eax
     3e4:	50                   	push   %eax
     3e5:	68 61 3e 00 00       	push   $0x3e61
     3ea:	ff 35 98 5e 00 00    	push   0x5e98
     3f0:	e8 8b 36 00 00       	call   3a80 <printf>
     3f5:	e8 d9 34 00 00       	call   38d3 <exit>
     3fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000400 <opentest>:
     400:	55                   	push   %ebp
     401:	89 e5                	mov    %esp,%ebp
     403:	83 ec 10             	sub    $0x10,%esp
     406:	68 82 3e 00 00       	push   $0x3e82
     40b:	ff 35 98 5e 00 00    	push   0x5e98
     411:	e8 6a 36 00 00       	call   3a80 <printf>
     416:	58                   	pop    %eax
     417:	5a                   	pop    %edx
     418:	6a 00                	push   $0x0
     41a:	68 8d 3e 00 00       	push   $0x3e8d
     41f:	e8 ef 34 00 00       	call   3913 <open>
     424:	83 c4 10             	add    $0x10,%esp
     427:	85 c0                	test   %eax,%eax
     429:	78 36                	js     461 <opentest+0x61>
     42b:	83 ec 0c             	sub    $0xc,%esp
     42e:	50                   	push   %eax
     42f:	e8 c7 34 00 00       	call   38fb <close>
     434:	5a                   	pop    %edx
     435:	59                   	pop    %ecx
     436:	6a 00                	push   $0x0
     438:	68 a5 3e 00 00       	push   $0x3ea5
     43d:	e8 d1 34 00 00       	call   3913 <open>
     442:	83 c4 10             	add    $0x10,%esp
     445:	85 c0                	test   %eax,%eax
     447:	79 2f                	jns    478 <opentest+0x78>
     449:	83 ec 08             	sub    $0x8,%esp
     44c:	68 d0 3e 00 00       	push   $0x3ed0
     451:	ff 35 98 5e 00 00    	push   0x5e98
     457:	e8 24 36 00 00       	call   3a80 <printf>
     45c:	83 c4 10             	add    $0x10,%esp
     45f:	c9                   	leave  
     460:	c3                   	ret    
     461:	50                   	push   %eax
     462:	50                   	push   %eax
     463:	68 92 3e 00 00       	push   $0x3e92
     468:	ff 35 98 5e 00 00    	push   0x5e98
     46e:	e8 0d 36 00 00       	call   3a80 <printf>
     473:	e8 5b 34 00 00       	call   38d3 <exit>
     478:	50                   	push   %eax
     479:	50                   	push   %eax
     47a:	68 b2 3e 00 00       	push   $0x3eb2
     47f:	ff 35 98 5e 00 00    	push   0x5e98
     485:	e8 f6 35 00 00       	call   3a80 <printf>
     48a:	e8 44 34 00 00       	call   38d3 <exit>
     48f:	90                   	nop

00000490 <writetest>:
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	56                   	push   %esi
     494:	53                   	push   %ebx
     495:	83 ec 08             	sub    $0x8,%esp
     498:	68 de 3e 00 00       	push   $0x3ede
     49d:	ff 35 98 5e 00 00    	push   0x5e98
     4a3:	e8 d8 35 00 00       	call   3a80 <printf>
     4a8:	58                   	pop    %eax
     4a9:	5a                   	pop    %edx
     4aa:	68 02 02 00 00       	push   $0x202
     4af:	68 ef 3e 00 00       	push   $0x3eef
     4b4:	e8 5a 34 00 00       	call   3913 <open>
     4b9:	83 c4 10             	add    $0x10,%esp
     4bc:	85 c0                	test   %eax,%eax
     4be:	0f 88 88 01 00 00    	js     64c <writetest+0x1bc>
     4c4:	83 ec 08             	sub    $0x8,%esp
     4c7:	89 c6                	mov    %eax,%esi
     4c9:	31 db                	xor    %ebx,%ebx
     4cb:	68 f5 3e 00 00       	push   $0x3ef5
     4d0:	ff 35 98 5e 00 00    	push   0x5e98
     4d6:	e8 a5 35 00 00       	call   3a80 <printf>
     4db:	83 c4 10             	add    $0x10,%esp
     4de:	66 90                	xchg   %ax,%ax
     4e0:	83 ec 04             	sub    $0x4,%esp
     4e3:	6a 0a                	push   $0xa
     4e5:	68 2c 3f 00 00       	push   $0x3f2c
     4ea:	56                   	push   %esi
     4eb:	e8 03 34 00 00       	call   38f3 <write>
     4f0:	83 c4 10             	add    $0x10,%esp
     4f3:	83 f8 0a             	cmp    $0xa,%eax
     4f6:	0f 85 d9 00 00 00    	jne    5d5 <writetest+0x145>
     4fc:	83 ec 04             	sub    $0x4,%esp
     4ff:	6a 0a                	push   $0xa
     501:	68 37 3f 00 00       	push   $0x3f37
     506:	56                   	push   %esi
     507:	e8 e7 33 00 00       	call   38f3 <write>
     50c:	83 c4 10             	add    $0x10,%esp
     50f:	83 f8 0a             	cmp    $0xa,%eax
     512:	0f 85 d6 00 00 00    	jne    5ee <writetest+0x15e>
     518:	83 c3 01             	add    $0x1,%ebx
     51b:	83 fb 64             	cmp    $0x64,%ebx
     51e:	75 c0                	jne    4e0 <writetest+0x50>
     520:	83 ec 08             	sub    $0x8,%esp
     523:	68 42 3f 00 00       	push   $0x3f42
     528:	ff 35 98 5e 00 00    	push   0x5e98
     52e:	e8 4d 35 00 00       	call   3a80 <printf>
     533:	89 34 24             	mov    %esi,(%esp)
     536:	e8 c0 33 00 00       	call   38fb <close>
     53b:	5b                   	pop    %ebx
     53c:	5e                   	pop    %esi
     53d:	6a 00                	push   $0x0
     53f:	68 ef 3e 00 00       	push   $0x3eef
     544:	e8 ca 33 00 00       	call   3913 <open>
     549:	83 c4 10             	add    $0x10,%esp
     54c:	89 c3                	mov    %eax,%ebx
     54e:	85 c0                	test   %eax,%eax
     550:	0f 88 b1 00 00 00    	js     607 <writetest+0x177>
     556:	83 ec 08             	sub    $0x8,%esp
     559:	68 4d 3f 00 00       	push   $0x3f4d
     55e:	ff 35 98 5e 00 00    	push   0x5e98
     564:	e8 17 35 00 00       	call   3a80 <printf>
     569:	83 c4 0c             	add    $0xc,%esp
     56c:	68 d0 07 00 00       	push   $0x7d0
     571:	68 e0 85 00 00       	push   $0x85e0
     576:	53                   	push   %ebx
     577:	e8 6f 33 00 00       	call   38eb <read>
     57c:	83 c4 10             	add    $0x10,%esp
     57f:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     584:	0f 85 94 00 00 00    	jne    61e <writetest+0x18e>
     58a:	83 ec 08             	sub    $0x8,%esp
     58d:	68 81 3f 00 00       	push   $0x3f81
     592:	ff 35 98 5e 00 00    	push   0x5e98
     598:	e8 e3 34 00 00       	call   3a80 <printf>
     59d:	89 1c 24             	mov    %ebx,(%esp)
     5a0:	e8 56 33 00 00       	call   38fb <close>
     5a5:	c7 04 24 ef 3e 00 00 	movl   $0x3eef,(%esp)
     5ac:	e8 72 33 00 00       	call   3923 <unlink>
     5b1:	83 c4 10             	add    $0x10,%esp
     5b4:	85 c0                	test   %eax,%eax
     5b6:	78 7d                	js     635 <writetest+0x1a5>
     5b8:	83 ec 08             	sub    $0x8,%esp
     5bb:	68 a9 3f 00 00       	push   $0x3fa9
     5c0:	ff 35 98 5e 00 00    	push   0x5e98
     5c6:	e8 b5 34 00 00       	call   3a80 <printf>
     5cb:	83 c4 10             	add    $0x10,%esp
     5ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5d1:	5b                   	pop    %ebx
     5d2:	5e                   	pop    %esi
     5d3:	5d                   	pop    %ebp
     5d4:	c3                   	ret    
     5d5:	83 ec 04             	sub    $0x4,%esp
     5d8:	53                   	push   %ebx
     5d9:	68 f0 4d 00 00       	push   $0x4df0
     5de:	ff 35 98 5e 00 00    	push   0x5e98
     5e4:	e8 97 34 00 00       	call   3a80 <printf>
     5e9:	e8 e5 32 00 00       	call   38d3 <exit>
     5ee:	83 ec 04             	sub    $0x4,%esp
     5f1:	53                   	push   %ebx
     5f2:	68 14 4e 00 00       	push   $0x4e14
     5f7:	ff 35 98 5e 00 00    	push   0x5e98
     5fd:	e8 7e 34 00 00       	call   3a80 <printf>
     602:	e8 cc 32 00 00       	call   38d3 <exit>
     607:	51                   	push   %ecx
     608:	51                   	push   %ecx
     609:	68 66 3f 00 00       	push   $0x3f66
     60e:	ff 35 98 5e 00 00    	push   0x5e98
     614:	e8 67 34 00 00       	call   3a80 <printf>
     619:	e8 b5 32 00 00       	call   38d3 <exit>
     61e:	52                   	push   %edx
     61f:	52                   	push   %edx
     620:	68 ad 42 00 00       	push   $0x42ad
     625:	ff 35 98 5e 00 00    	push   0x5e98
     62b:	e8 50 34 00 00       	call   3a80 <printf>
     630:	e8 9e 32 00 00       	call   38d3 <exit>
     635:	50                   	push   %eax
     636:	50                   	push   %eax
     637:	68 94 3f 00 00       	push   $0x3f94
     63c:	ff 35 98 5e 00 00    	push   0x5e98
     642:	e8 39 34 00 00       	call   3a80 <printf>
     647:	e8 87 32 00 00       	call   38d3 <exit>
     64c:	50                   	push   %eax
     64d:	50                   	push   %eax
     64e:	68 10 3f 00 00       	push   $0x3f10
     653:	ff 35 98 5e 00 00    	push   0x5e98
     659:	e8 22 34 00 00       	call   3a80 <printf>
     65e:	e8 70 32 00 00       	call   38d3 <exit>
     663:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     66a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000670 <writetest1>:
     670:	55                   	push   %ebp
     671:	89 e5                	mov    %esp,%ebp
     673:	56                   	push   %esi
     674:	53                   	push   %ebx
     675:	83 ec 08             	sub    $0x8,%esp
     678:	68 bd 3f 00 00       	push   $0x3fbd
     67d:	ff 35 98 5e 00 00    	push   0x5e98
     683:	e8 f8 33 00 00       	call   3a80 <printf>
     688:	58                   	pop    %eax
     689:	5a                   	pop    %edx
     68a:	68 02 02 00 00       	push   $0x202
     68f:	68 37 40 00 00       	push   $0x4037
     694:	e8 7a 32 00 00       	call   3913 <open>
     699:	83 c4 10             	add    $0x10,%esp
     69c:	85 c0                	test   %eax,%eax
     69e:	0f 88 61 01 00 00    	js     805 <writetest1+0x195>
     6a4:	89 c6                	mov    %eax,%esi
     6a6:	31 db                	xor    %ebx,%ebx
     6a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     6af:	90                   	nop
     6b0:	83 ec 04             	sub    $0x4,%esp
     6b3:	89 1d e0 85 00 00    	mov    %ebx,0x85e0
     6b9:	68 00 02 00 00       	push   $0x200
     6be:	68 e0 85 00 00       	push   $0x85e0
     6c3:	56                   	push   %esi
     6c4:	e8 2a 32 00 00       	call   38f3 <write>
     6c9:	83 c4 10             	add    $0x10,%esp
     6cc:	3d 00 02 00 00       	cmp    $0x200,%eax
     6d1:	0f 85 b3 00 00 00    	jne    78a <writetest1+0x11a>
     6d7:	83 c3 01             	add    $0x1,%ebx
     6da:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     6e0:	75 ce                	jne    6b0 <writetest1+0x40>
     6e2:	83 ec 0c             	sub    $0xc,%esp
     6e5:	56                   	push   %esi
     6e6:	e8 10 32 00 00       	call   38fb <close>
     6eb:	5b                   	pop    %ebx
     6ec:	5e                   	pop    %esi
     6ed:	6a 00                	push   $0x0
     6ef:	68 37 40 00 00       	push   $0x4037
     6f4:	e8 1a 32 00 00       	call   3913 <open>
     6f9:	83 c4 10             	add    $0x10,%esp
     6fc:	89 c3                	mov    %eax,%ebx
     6fe:	85 c0                	test   %eax,%eax
     700:	0f 88 e8 00 00 00    	js     7ee <writetest1+0x17e>
     706:	31 f6                	xor    %esi,%esi
     708:	eb 1d                	jmp    727 <writetest1+0xb7>
     70a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     710:	3d 00 02 00 00       	cmp    $0x200,%eax
     715:	0f 85 9f 00 00 00    	jne    7ba <writetest1+0x14a>
     71b:	a1 e0 85 00 00       	mov    0x85e0,%eax
     720:	39 f0                	cmp    %esi,%eax
     722:	75 7f                	jne    7a3 <writetest1+0x133>
     724:	83 c6 01             	add    $0x1,%esi
     727:	83 ec 04             	sub    $0x4,%esp
     72a:	68 00 02 00 00       	push   $0x200
     72f:	68 e0 85 00 00       	push   $0x85e0
     734:	53                   	push   %ebx
     735:	e8 b1 31 00 00       	call   38eb <read>
     73a:	83 c4 10             	add    $0x10,%esp
     73d:	85 c0                	test   %eax,%eax
     73f:	75 cf                	jne    710 <writetest1+0xa0>
     741:	81 fe 8b 00 00 00    	cmp    $0x8b,%esi
     747:	0f 84 86 00 00 00    	je     7d3 <writetest1+0x163>
     74d:	83 ec 0c             	sub    $0xc,%esp
     750:	53                   	push   %ebx
     751:	e8 a5 31 00 00       	call   38fb <close>
     756:	c7 04 24 37 40 00 00 	movl   $0x4037,(%esp)
     75d:	e8 c1 31 00 00       	call   3923 <unlink>
     762:	83 c4 10             	add    $0x10,%esp
     765:	85 c0                	test   %eax,%eax
     767:	0f 88 af 00 00 00    	js     81c <writetest1+0x1ac>
     76d:	83 ec 08             	sub    $0x8,%esp
     770:	68 5e 40 00 00       	push   $0x405e
     775:	ff 35 98 5e 00 00    	push   0x5e98
     77b:	e8 00 33 00 00       	call   3a80 <printf>
     780:	83 c4 10             	add    $0x10,%esp
     783:	8d 65 f8             	lea    -0x8(%ebp),%esp
     786:	5b                   	pop    %ebx
     787:	5e                   	pop    %esi
     788:	5d                   	pop    %ebp
     789:	c3                   	ret    
     78a:	83 ec 04             	sub    $0x4,%esp
     78d:	53                   	push   %ebx
     78e:	68 e7 3f 00 00       	push   $0x3fe7
     793:	ff 35 98 5e 00 00    	push   0x5e98
     799:	e8 e2 32 00 00       	call   3a80 <printf>
     79e:	e8 30 31 00 00       	call   38d3 <exit>
     7a3:	50                   	push   %eax
     7a4:	56                   	push   %esi
     7a5:	68 38 4e 00 00       	push   $0x4e38
     7aa:	ff 35 98 5e 00 00    	push   0x5e98
     7b0:	e8 cb 32 00 00       	call   3a80 <printf>
     7b5:	e8 19 31 00 00       	call   38d3 <exit>
     7ba:	83 ec 04             	sub    $0x4,%esp
     7bd:	50                   	push   %eax
     7be:	68 3b 40 00 00       	push   $0x403b
     7c3:	ff 35 98 5e 00 00    	push   0x5e98
     7c9:	e8 b2 32 00 00       	call   3a80 <printf>
     7ce:	e8 00 31 00 00       	call   38d3 <exit>
     7d3:	52                   	push   %edx
     7d4:	68 8b 00 00 00       	push   $0x8b
     7d9:	68 1e 40 00 00       	push   $0x401e
     7de:	ff 35 98 5e 00 00    	push   0x5e98
     7e4:	e8 97 32 00 00       	call   3a80 <printf>
     7e9:	e8 e5 30 00 00       	call   38d3 <exit>
     7ee:	51                   	push   %ecx
     7ef:	51                   	push   %ecx
     7f0:	68 05 40 00 00       	push   $0x4005
     7f5:	ff 35 98 5e 00 00    	push   0x5e98
     7fb:	e8 80 32 00 00       	call   3a80 <printf>
     800:	e8 ce 30 00 00       	call   38d3 <exit>
     805:	50                   	push   %eax
     806:	50                   	push   %eax
     807:	68 cd 3f 00 00       	push   $0x3fcd
     80c:	ff 35 98 5e 00 00    	push   0x5e98
     812:	e8 69 32 00 00       	call   3a80 <printf>
     817:	e8 b7 30 00 00       	call   38d3 <exit>
     81c:	50                   	push   %eax
     81d:	50                   	push   %eax
     81e:	68 4b 40 00 00       	push   $0x404b
     823:	ff 35 98 5e 00 00    	push   0x5e98
     829:	e8 52 32 00 00       	call   3a80 <printf>
     82e:	e8 a0 30 00 00       	call   38d3 <exit>
     833:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     83a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000840 <createtest>:
     840:	55                   	push   %ebp
     841:	89 e5                	mov    %esp,%ebp
     843:	53                   	push   %ebx
     844:	bb 30 00 00 00       	mov    $0x30,%ebx
     849:	83 ec 0c             	sub    $0xc,%esp
     84c:	68 58 4e 00 00       	push   $0x4e58
     851:	ff 35 98 5e 00 00    	push   0x5e98
     857:	e8 24 32 00 00       	call   3a80 <printf>
     85c:	c6 05 d0 85 00 00 61 	movb   $0x61,0x85d0
     863:	83 c4 10             	add    $0x10,%esp
     866:	c6 05 d2 85 00 00 00 	movb   $0x0,0x85d2
     86d:	8d 76 00             	lea    0x0(%esi),%esi
     870:	83 ec 08             	sub    $0x8,%esp
     873:	88 1d d1 85 00 00    	mov    %bl,0x85d1
     879:	83 c3 01             	add    $0x1,%ebx
     87c:	68 02 02 00 00       	push   $0x202
     881:	68 d0 85 00 00       	push   $0x85d0
     886:	e8 88 30 00 00       	call   3913 <open>
     88b:	89 04 24             	mov    %eax,(%esp)
     88e:	e8 68 30 00 00       	call   38fb <close>
     893:	83 c4 10             	add    $0x10,%esp
     896:	80 fb 64             	cmp    $0x64,%bl
     899:	75 d5                	jne    870 <createtest+0x30>
     89b:	c6 05 d0 85 00 00 61 	movb   $0x61,0x85d0
     8a2:	bb 30 00 00 00       	mov    $0x30,%ebx
     8a7:	c6 05 d2 85 00 00 00 	movb   $0x0,0x85d2
     8ae:	66 90                	xchg   %ax,%ax
     8b0:	83 ec 0c             	sub    $0xc,%esp
     8b3:	88 1d d1 85 00 00    	mov    %bl,0x85d1
     8b9:	83 c3 01             	add    $0x1,%ebx
     8bc:	68 d0 85 00 00       	push   $0x85d0
     8c1:	e8 5d 30 00 00       	call   3923 <unlink>
     8c6:	83 c4 10             	add    $0x10,%esp
     8c9:	80 fb 64             	cmp    $0x64,%bl
     8cc:	75 e2                	jne    8b0 <createtest+0x70>
     8ce:	83 ec 08             	sub    $0x8,%esp
     8d1:	68 80 4e 00 00       	push   $0x4e80
     8d6:	ff 35 98 5e 00 00    	push   0x5e98
     8dc:	e8 9f 31 00 00       	call   3a80 <printf>
     8e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8e4:	83 c4 10             	add    $0x10,%esp
     8e7:	c9                   	leave  
     8e8:	c3                   	ret    
     8e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008f0 <dirtest>:
     8f0:	55                   	push   %ebp
     8f1:	89 e5                	mov    %esp,%ebp
     8f3:	83 ec 10             	sub    $0x10,%esp
     8f6:	68 6c 40 00 00       	push   $0x406c
     8fb:	ff 35 98 5e 00 00    	push   0x5e98
     901:	e8 7a 31 00 00       	call   3a80 <printf>
     906:	c7 04 24 78 40 00 00 	movl   $0x4078,(%esp)
     90d:	e8 29 30 00 00       	call   393b <mkdir>
     912:	83 c4 10             	add    $0x10,%esp
     915:	85 c0                	test   %eax,%eax
     917:	78 58                	js     971 <dirtest+0x81>
     919:	83 ec 0c             	sub    $0xc,%esp
     91c:	68 78 40 00 00       	push   $0x4078
     921:	e8 1d 30 00 00       	call   3943 <chdir>
     926:	83 c4 10             	add    $0x10,%esp
     929:	85 c0                	test   %eax,%eax
     92b:	0f 88 85 00 00 00    	js     9b6 <dirtest+0xc6>
     931:	83 ec 0c             	sub    $0xc,%esp
     934:	68 1d 46 00 00       	push   $0x461d
     939:	e8 05 30 00 00       	call   3943 <chdir>
     93e:	83 c4 10             	add    $0x10,%esp
     941:	85 c0                	test   %eax,%eax
     943:	78 5a                	js     99f <dirtest+0xaf>
     945:	83 ec 0c             	sub    $0xc,%esp
     948:	68 78 40 00 00       	push   $0x4078
     94d:	e8 d1 2f 00 00       	call   3923 <unlink>
     952:	83 c4 10             	add    $0x10,%esp
     955:	85 c0                	test   %eax,%eax
     957:	78 2f                	js     988 <dirtest+0x98>
     959:	83 ec 08             	sub    $0x8,%esp
     95c:	68 b5 40 00 00       	push   $0x40b5
     961:	ff 35 98 5e 00 00    	push   0x5e98
     967:	e8 14 31 00 00       	call   3a80 <printf>
     96c:	83 c4 10             	add    $0x10,%esp
     96f:	c9                   	leave  
     970:	c3                   	ret    
     971:	50                   	push   %eax
     972:	50                   	push   %eax
     973:	68 a8 3d 00 00       	push   $0x3da8
     978:	ff 35 98 5e 00 00    	push   0x5e98
     97e:	e8 fd 30 00 00       	call   3a80 <printf>
     983:	e8 4b 2f 00 00       	call   38d3 <exit>
     988:	50                   	push   %eax
     989:	50                   	push   %eax
     98a:	68 a1 40 00 00       	push   $0x40a1
     98f:	ff 35 98 5e 00 00    	push   0x5e98
     995:	e8 e6 30 00 00       	call   3a80 <printf>
     99a:	e8 34 2f 00 00       	call   38d3 <exit>
     99f:	52                   	push   %edx
     9a0:	52                   	push   %edx
     9a1:	68 90 40 00 00       	push   $0x4090
     9a6:	ff 35 98 5e 00 00    	push   0x5e98
     9ac:	e8 cf 30 00 00       	call   3a80 <printf>
     9b1:	e8 1d 2f 00 00       	call   38d3 <exit>
     9b6:	51                   	push   %ecx
     9b7:	51                   	push   %ecx
     9b8:	68 7d 40 00 00       	push   $0x407d
     9bd:	ff 35 98 5e 00 00    	push   0x5e98
     9c3:	e8 b8 30 00 00       	call   3a80 <printf>
     9c8:	e8 06 2f 00 00       	call   38d3 <exit>
     9cd:	8d 76 00             	lea    0x0(%esi),%esi

000009d0 <exectest>:
     9d0:	55                   	push   %ebp
     9d1:	89 e5                	mov    %esp,%ebp
     9d3:	83 ec 10             	sub    $0x10,%esp
     9d6:	68 c4 40 00 00       	push   $0x40c4
     9db:	ff 35 98 5e 00 00    	push   0x5e98
     9e1:	e8 9a 30 00 00       	call   3a80 <printf>
     9e6:	5a                   	pop    %edx
     9e7:	59                   	pop    %ecx
     9e8:	68 9c 5e 00 00       	push   $0x5e9c
     9ed:	68 8d 3e 00 00       	push   $0x3e8d
     9f2:	e8 14 2f 00 00       	call   390b <exec>
     9f7:	83 c4 10             	add    $0x10,%esp
     9fa:	85 c0                	test   %eax,%eax
     9fc:	78 02                	js     a00 <exectest+0x30>
     9fe:	c9                   	leave  
     9ff:	c3                   	ret    
     a00:	50                   	push   %eax
     a01:	50                   	push   %eax
     a02:	68 cf 40 00 00       	push   $0x40cf
     a07:	ff 35 98 5e 00 00    	push   0x5e98
     a0d:	e8 6e 30 00 00       	call   3a80 <printf>
     a12:	e8 bc 2e 00 00       	call   38d3 <exit>
     a17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a1e:	66 90                	xchg   %ax,%ax

00000a20 <pipe1>:
     a20:	55                   	push   %ebp
     a21:	89 e5                	mov    %esp,%ebp
     a23:	57                   	push   %edi
     a24:	56                   	push   %esi
     a25:	8d 45 e0             	lea    -0x20(%ebp),%eax
     a28:	53                   	push   %ebx
     a29:	83 ec 38             	sub    $0x38,%esp
     a2c:	50                   	push   %eax
     a2d:	e8 b1 2e 00 00       	call   38e3 <pipe>
     a32:	83 c4 10             	add    $0x10,%esp
     a35:	85 c0                	test   %eax,%eax
     a37:	0f 85 34 01 00 00    	jne    b71 <pipe1+0x151>
     a3d:	e8 89 2e 00 00       	call   38cb <fork>
     a42:	85 c0                	test   %eax,%eax
     a44:	0f 84 85 00 00 00    	je     acf <pipe1+0xaf>
     a4a:	0f 8e 34 01 00 00    	jle    b84 <pipe1+0x164>
     a50:	83 ec 0c             	sub    $0xc,%esp
     a53:	ff 75 e4             	push   -0x1c(%ebp)
     a56:	31 db                	xor    %ebx,%ebx
     a58:	be 01 00 00 00       	mov    $0x1,%esi
     a5d:	e8 99 2e 00 00       	call   38fb <close>
     a62:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     a69:	83 c4 10             	add    $0x10,%esp
     a6c:	83 ec 04             	sub    $0x4,%esp
     a6f:	56                   	push   %esi
     a70:	68 e0 85 00 00       	push   $0x85e0
     a75:	ff 75 e0             	push   -0x20(%ebp)
     a78:	e8 6e 2e 00 00       	call   38eb <read>
     a7d:	83 c4 10             	add    $0x10,%esp
     a80:	89 c7                	mov    %eax,%edi
     a82:	85 c0                	test   %eax,%eax
     a84:	0f 8e a3 00 00 00    	jle    b2d <pipe1+0x10d>
     a8a:	8d 0c 1f             	lea    (%edi,%ebx,1),%ecx
     a8d:	31 c0                	xor    %eax,%eax
     a8f:	90                   	nop
     a90:	89 da                	mov    %ebx,%edx
     a92:	83 c3 01             	add    $0x1,%ebx
     a95:	38 90 e0 85 00 00    	cmp    %dl,0x85e0(%eax)
     a9b:	75 18                	jne    ab5 <pipe1+0x95>
     a9d:	83 c0 01             	add    $0x1,%eax
     aa0:	39 d9                	cmp    %ebx,%ecx
     aa2:	75 ec                	jne    a90 <pipe1+0x70>
     aa4:	01 f6                	add    %esi,%esi
     aa6:	b8 00 20 00 00       	mov    $0x2000,%eax
     aab:	01 7d d4             	add    %edi,-0x2c(%ebp)
     aae:	39 c6                	cmp    %eax,%esi
     ab0:	0f 4f f0             	cmovg  %eax,%esi
     ab3:	eb b7                	jmp    a6c <pipe1+0x4c>
     ab5:	83 ec 08             	sub    $0x8,%esp
     ab8:	68 fe 40 00 00       	push   $0x40fe
     abd:	6a 01                	push   $0x1
     abf:	e8 bc 2f 00 00       	call   3a80 <printf>
     ac4:	83 c4 10             	add    $0x10,%esp
     ac7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     aca:	5b                   	pop    %ebx
     acb:	5e                   	pop    %esi
     acc:	5f                   	pop    %edi
     acd:	5d                   	pop    %ebp
     ace:	c3                   	ret    
     acf:	83 ec 0c             	sub    $0xc,%esp
     ad2:	ff 75 e0             	push   -0x20(%ebp)
     ad5:	31 db                	xor    %ebx,%ebx
     ad7:	e8 1f 2e 00 00       	call   38fb <close>
     adc:	83 c4 10             	add    $0x10,%esp
     adf:	31 c0                	xor    %eax,%eax
     ae1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     ae8:	8d 14 18             	lea    (%eax,%ebx,1),%edx
     aeb:	83 c0 01             	add    $0x1,%eax
     aee:	88 90 df 85 00 00    	mov    %dl,0x85df(%eax)
     af4:	3d 09 04 00 00       	cmp    $0x409,%eax
     af9:	75 ed                	jne    ae8 <pipe1+0xc8>
     afb:	83 ec 04             	sub    $0x4,%esp
     afe:	81 c3 09 04 00 00    	add    $0x409,%ebx
     b04:	68 09 04 00 00       	push   $0x409
     b09:	68 e0 85 00 00       	push   $0x85e0
     b0e:	ff 75 e4             	push   -0x1c(%ebp)
     b11:	e8 dd 2d 00 00       	call   38f3 <write>
     b16:	83 c4 10             	add    $0x10,%esp
     b19:	3d 09 04 00 00       	cmp    $0x409,%eax
     b1e:	75 77                	jne    b97 <pipe1+0x177>
     b20:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     b26:	75 b7                	jne    adf <pipe1+0xbf>
     b28:	e8 a6 2d 00 00       	call   38d3 <exit>
     b2d:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     b34:	75 26                	jne    b5c <pipe1+0x13c>
     b36:	83 ec 0c             	sub    $0xc,%esp
     b39:	ff 75 e0             	push   -0x20(%ebp)
     b3c:	e8 ba 2d 00 00       	call   38fb <close>
     b41:	e8 95 2d 00 00       	call   38db <wait>
     b46:	5a                   	pop    %edx
     b47:	59                   	pop    %ecx
     b48:	68 23 41 00 00       	push   $0x4123
     b4d:	6a 01                	push   $0x1
     b4f:	e8 2c 2f 00 00       	call   3a80 <printf>
     b54:	83 c4 10             	add    $0x10,%esp
     b57:	e9 6b ff ff ff       	jmp    ac7 <pipe1+0xa7>
     b5c:	53                   	push   %ebx
     b5d:	ff 75 d4             	push   -0x2c(%ebp)
     b60:	68 0c 41 00 00       	push   $0x410c
     b65:	6a 01                	push   $0x1
     b67:	e8 14 2f 00 00       	call   3a80 <printf>
     b6c:	e8 62 2d 00 00       	call   38d3 <exit>
     b71:	57                   	push   %edi
     b72:	57                   	push   %edi
     b73:	68 e1 40 00 00       	push   $0x40e1
     b78:	6a 01                	push   $0x1
     b7a:	e8 01 2f 00 00       	call   3a80 <printf>
     b7f:	e8 4f 2d 00 00       	call   38d3 <exit>
     b84:	50                   	push   %eax
     b85:	50                   	push   %eax
     b86:	68 2d 41 00 00       	push   $0x412d
     b8b:	6a 01                	push   $0x1
     b8d:	e8 ee 2e 00 00       	call   3a80 <printf>
     b92:	e8 3c 2d 00 00       	call   38d3 <exit>
     b97:	56                   	push   %esi
     b98:	56                   	push   %esi
     b99:	68 f0 40 00 00       	push   $0x40f0
     b9e:	6a 01                	push   $0x1
     ba0:	e8 db 2e 00 00       	call   3a80 <printf>
     ba5:	e8 29 2d 00 00       	call   38d3 <exit>
     baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000bb0 <preempt>:
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	57                   	push   %edi
     bb4:	56                   	push   %esi
     bb5:	53                   	push   %ebx
     bb6:	83 ec 24             	sub    $0x24,%esp
     bb9:	68 3c 41 00 00       	push   $0x413c
     bbe:	6a 01                	push   $0x1
     bc0:	e8 bb 2e 00 00       	call   3a80 <printf>
     bc5:	e8 01 2d 00 00       	call   38cb <fork>
     bca:	83 c4 10             	add    $0x10,%esp
     bcd:	85 c0                	test   %eax,%eax
     bcf:	75 07                	jne    bd8 <preempt+0x28>
     bd1:	eb fe                	jmp    bd1 <preempt+0x21>
     bd3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     bd7:	90                   	nop
     bd8:	89 c3                	mov    %eax,%ebx
     bda:	e8 ec 2c 00 00       	call   38cb <fork>
     bdf:	89 c6                	mov    %eax,%esi
     be1:	85 c0                	test   %eax,%eax
     be3:	75 0b                	jne    bf0 <preempt+0x40>
     be5:	eb fe                	jmp    be5 <preempt+0x35>
     be7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bee:	66 90                	xchg   %ax,%ax
     bf0:	83 ec 0c             	sub    $0xc,%esp
     bf3:	8d 45 e0             	lea    -0x20(%ebp),%eax
     bf6:	50                   	push   %eax
     bf7:	e8 e7 2c 00 00       	call   38e3 <pipe>
     bfc:	e8 ca 2c 00 00       	call   38cb <fork>
     c01:	83 c4 10             	add    $0x10,%esp
     c04:	89 c7                	mov    %eax,%edi
     c06:	85 c0                	test   %eax,%eax
     c08:	75 3e                	jne    c48 <preempt+0x98>
     c0a:	83 ec 0c             	sub    $0xc,%esp
     c0d:	ff 75 e0             	push   -0x20(%ebp)
     c10:	e8 e6 2c 00 00       	call   38fb <close>
     c15:	83 c4 0c             	add    $0xc,%esp
     c18:	6a 01                	push   $0x1
     c1a:	68 01 47 00 00       	push   $0x4701
     c1f:	ff 75 e4             	push   -0x1c(%ebp)
     c22:	e8 cc 2c 00 00       	call   38f3 <write>
     c27:	83 c4 10             	add    $0x10,%esp
     c2a:	83 f8 01             	cmp    $0x1,%eax
     c2d:	0f 85 b8 00 00 00    	jne    ceb <preempt+0x13b>
     c33:	83 ec 0c             	sub    $0xc,%esp
     c36:	ff 75 e4             	push   -0x1c(%ebp)
     c39:	e8 bd 2c 00 00       	call   38fb <close>
     c3e:	83 c4 10             	add    $0x10,%esp
     c41:	eb fe                	jmp    c41 <preempt+0x91>
     c43:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c47:	90                   	nop
     c48:	83 ec 0c             	sub    $0xc,%esp
     c4b:	ff 75 e4             	push   -0x1c(%ebp)
     c4e:	e8 a8 2c 00 00       	call   38fb <close>
     c53:	83 c4 0c             	add    $0xc,%esp
     c56:	68 00 20 00 00       	push   $0x2000
     c5b:	68 e0 85 00 00       	push   $0x85e0
     c60:	ff 75 e0             	push   -0x20(%ebp)
     c63:	e8 83 2c 00 00       	call   38eb <read>
     c68:	83 c4 10             	add    $0x10,%esp
     c6b:	83 f8 01             	cmp    $0x1,%eax
     c6e:	75 67                	jne    cd7 <preempt+0x127>
     c70:	83 ec 0c             	sub    $0xc,%esp
     c73:	ff 75 e0             	push   -0x20(%ebp)
     c76:	e8 80 2c 00 00       	call   38fb <close>
     c7b:	58                   	pop    %eax
     c7c:	5a                   	pop    %edx
     c7d:	68 6d 41 00 00       	push   $0x416d
     c82:	6a 01                	push   $0x1
     c84:	e8 f7 2d 00 00       	call   3a80 <printf>
     c89:	89 1c 24             	mov    %ebx,(%esp)
     c8c:	e8 72 2c 00 00       	call   3903 <kill>
     c91:	89 34 24             	mov    %esi,(%esp)
     c94:	e8 6a 2c 00 00       	call   3903 <kill>
     c99:	89 3c 24             	mov    %edi,(%esp)
     c9c:	e8 62 2c 00 00       	call   3903 <kill>
     ca1:	59                   	pop    %ecx
     ca2:	5b                   	pop    %ebx
     ca3:	68 76 41 00 00       	push   $0x4176
     ca8:	6a 01                	push   $0x1
     caa:	e8 d1 2d 00 00       	call   3a80 <printf>
     caf:	e8 27 2c 00 00       	call   38db <wait>
     cb4:	e8 22 2c 00 00       	call   38db <wait>
     cb9:	e8 1d 2c 00 00       	call   38db <wait>
     cbe:	5e                   	pop    %esi
     cbf:	5f                   	pop    %edi
     cc0:	68 7f 41 00 00       	push   $0x417f
     cc5:	6a 01                	push   $0x1
     cc7:	e8 b4 2d 00 00       	call   3a80 <printf>
     ccc:	83 c4 10             	add    $0x10,%esp
     ccf:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cd2:	5b                   	pop    %ebx
     cd3:	5e                   	pop    %esi
     cd4:	5f                   	pop    %edi
     cd5:	5d                   	pop    %ebp
     cd6:	c3                   	ret    
     cd7:	83 ec 08             	sub    $0x8,%esp
     cda:	68 5a 41 00 00       	push   $0x415a
     cdf:	6a 01                	push   $0x1
     ce1:	e8 9a 2d 00 00       	call   3a80 <printf>
     ce6:	83 c4 10             	add    $0x10,%esp
     ce9:	eb e4                	jmp    ccf <preempt+0x11f>
     ceb:	83 ec 08             	sub    $0x8,%esp
     cee:	68 46 41 00 00       	push   $0x4146
     cf3:	6a 01                	push   $0x1
     cf5:	e8 86 2d 00 00       	call   3a80 <printf>
     cfa:	83 c4 10             	add    $0x10,%esp
     cfd:	e9 31 ff ff ff       	jmp    c33 <preempt+0x83>
     d02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d10 <exitwait>:
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	56                   	push   %esi
     d14:	be 64 00 00 00       	mov    $0x64,%esi
     d19:	53                   	push   %ebx
     d1a:	eb 14                	jmp    d30 <exitwait+0x20>
     d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d20:	74 68                	je     d8a <exitwait+0x7a>
     d22:	e8 b4 2b 00 00       	call   38db <wait>
     d27:	39 d8                	cmp    %ebx,%eax
     d29:	75 2d                	jne    d58 <exitwait+0x48>
     d2b:	83 ee 01             	sub    $0x1,%esi
     d2e:	74 41                	je     d71 <exitwait+0x61>
     d30:	e8 96 2b 00 00       	call   38cb <fork>
     d35:	89 c3                	mov    %eax,%ebx
     d37:	85 c0                	test   %eax,%eax
     d39:	79 e5                	jns    d20 <exitwait+0x10>
     d3b:	83 ec 08             	sub    $0x8,%esp
     d3e:	68 e9 4c 00 00       	push   $0x4ce9
     d43:	6a 01                	push   $0x1
     d45:	e8 36 2d 00 00       	call   3a80 <printf>
     d4a:	83 c4 10             	add    $0x10,%esp
     d4d:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d50:	5b                   	pop    %ebx
     d51:	5e                   	pop    %esi
     d52:	5d                   	pop    %ebp
     d53:	c3                   	ret    
     d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d58:	83 ec 08             	sub    $0x8,%esp
     d5b:	68 8b 41 00 00       	push   $0x418b
     d60:	6a 01                	push   $0x1
     d62:	e8 19 2d 00 00       	call   3a80 <printf>
     d67:	83 c4 10             	add    $0x10,%esp
     d6a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d6d:	5b                   	pop    %ebx
     d6e:	5e                   	pop    %esi
     d6f:	5d                   	pop    %ebp
     d70:	c3                   	ret    
     d71:	83 ec 08             	sub    $0x8,%esp
     d74:	68 9b 41 00 00       	push   $0x419b
     d79:	6a 01                	push   $0x1
     d7b:	e8 00 2d 00 00       	call   3a80 <printf>
     d80:	83 c4 10             	add    $0x10,%esp
     d83:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d86:	5b                   	pop    %ebx
     d87:	5e                   	pop    %esi
     d88:	5d                   	pop    %ebp
     d89:	c3                   	ret    
     d8a:	e8 44 2b 00 00       	call   38d3 <exit>
     d8f:	90                   	nop

00000d90 <mem>:
     d90:	55                   	push   %ebp
     d91:	89 e5                	mov    %esp,%ebp
     d93:	56                   	push   %esi
     d94:	31 f6                	xor    %esi,%esi
     d96:	53                   	push   %ebx
     d97:	83 ec 08             	sub    $0x8,%esp
     d9a:	68 a8 41 00 00       	push   $0x41a8
     d9f:	6a 01                	push   $0x1
     da1:	e8 da 2c 00 00       	call   3a80 <printf>
     da6:	e8 a8 2b 00 00       	call   3953 <getpid>
     dab:	89 c3                	mov    %eax,%ebx
     dad:	e8 19 2b 00 00       	call   38cb <fork>
     db2:	83 c4 10             	add    $0x10,%esp
     db5:	85 c0                	test   %eax,%eax
     db7:	74 0b                	je     dc4 <mem+0x34>
     db9:	e9 8a 00 00 00       	jmp    e48 <mem+0xb8>
     dbe:	66 90                	xchg   %ax,%ax
     dc0:	89 30                	mov    %esi,(%eax)
     dc2:	89 c6                	mov    %eax,%esi
     dc4:	83 ec 0c             	sub    $0xc,%esp
     dc7:	68 11 27 00 00       	push   $0x2711
     dcc:	e8 df 2e 00 00       	call   3cb0 <malloc>
     dd1:	83 c4 10             	add    $0x10,%esp
     dd4:	85 c0                	test   %eax,%eax
     dd6:	75 e8                	jne    dc0 <mem+0x30>
     dd8:	85 f6                	test   %esi,%esi
     dda:	74 18                	je     df4 <mem+0x64>
     ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     de0:	89 f0                	mov    %esi,%eax
     de2:	83 ec 0c             	sub    $0xc,%esp
     de5:	8b 36                	mov    (%esi),%esi
     de7:	50                   	push   %eax
     de8:	e8 33 2e 00 00       	call   3c20 <free>
     ded:	83 c4 10             	add    $0x10,%esp
     df0:	85 f6                	test   %esi,%esi
     df2:	75 ec                	jne    de0 <mem+0x50>
     df4:	83 ec 0c             	sub    $0xc,%esp
     df7:	68 00 50 00 00       	push   $0x5000
     dfc:	e8 af 2e 00 00       	call   3cb0 <malloc>
     e01:	83 c4 10             	add    $0x10,%esp
     e04:	85 c0                	test   %eax,%eax
     e06:	74 20                	je     e28 <mem+0x98>
     e08:	83 ec 0c             	sub    $0xc,%esp
     e0b:	50                   	push   %eax
     e0c:	e8 0f 2e 00 00       	call   3c20 <free>
     e11:	58                   	pop    %eax
     e12:	5a                   	pop    %edx
     e13:	68 cc 41 00 00       	push   $0x41cc
     e18:	6a 01                	push   $0x1
     e1a:	e8 61 2c 00 00       	call   3a80 <printf>
     e1f:	e8 af 2a 00 00       	call   38d3 <exit>
     e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e28:	83 ec 08             	sub    $0x8,%esp
     e2b:	68 b2 41 00 00       	push   $0x41b2
     e30:	6a 01                	push   $0x1
     e32:	e8 49 2c 00 00       	call   3a80 <printf>
     e37:	89 1c 24             	mov    %ebx,(%esp)
     e3a:	e8 c4 2a 00 00       	call   3903 <kill>
     e3f:	e8 8f 2a 00 00       	call   38d3 <exit>
     e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e48:	8d 65 f8             	lea    -0x8(%ebp),%esp
     e4b:	5b                   	pop    %ebx
     e4c:	5e                   	pop    %esi
     e4d:	5d                   	pop    %ebp
     e4e:	e9 88 2a 00 00       	jmp    38db <wait>
     e53:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000e60 <sharedfd>:
     e60:	55                   	push   %ebp
     e61:	89 e5                	mov    %esp,%ebp
     e63:	57                   	push   %edi
     e64:	56                   	push   %esi
     e65:	53                   	push   %ebx
     e66:	83 ec 34             	sub    $0x34,%esp
     e69:	68 d4 41 00 00       	push   $0x41d4
     e6e:	6a 01                	push   $0x1
     e70:	e8 0b 2c 00 00       	call   3a80 <printf>
     e75:	c7 04 24 e3 41 00 00 	movl   $0x41e3,(%esp)
     e7c:	e8 a2 2a 00 00       	call   3923 <unlink>
     e81:	5b                   	pop    %ebx
     e82:	5e                   	pop    %esi
     e83:	68 02 02 00 00       	push   $0x202
     e88:	68 e3 41 00 00       	push   $0x41e3
     e8d:	e8 81 2a 00 00       	call   3913 <open>
     e92:	83 c4 10             	add    $0x10,%esp
     e95:	85 c0                	test   %eax,%eax
     e97:	0f 88 2a 01 00 00    	js     fc7 <sharedfd+0x167>
     e9d:	89 c7                	mov    %eax,%edi
     e9f:	8d 75 de             	lea    -0x22(%ebp),%esi
     ea2:	bb e8 03 00 00       	mov    $0x3e8,%ebx
     ea7:	e8 1f 2a 00 00       	call   38cb <fork>
     eac:	83 f8 01             	cmp    $0x1,%eax
     eaf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     eb2:	19 c0                	sbb    %eax,%eax
     eb4:	83 ec 04             	sub    $0x4,%esp
     eb7:	83 e0 f3             	and    $0xfffffff3,%eax
     eba:	6a 0a                	push   $0xa
     ebc:	83 c0 70             	add    $0x70,%eax
     ebf:	50                   	push   %eax
     ec0:	56                   	push   %esi
     ec1:	e8 7a 28 00 00       	call   3740 <memset>
     ec6:	83 c4 10             	add    $0x10,%esp
     ec9:	eb 0a                	jmp    ed5 <sharedfd+0x75>
     ecb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ecf:	90                   	nop
     ed0:	83 eb 01             	sub    $0x1,%ebx
     ed3:	74 26                	je     efb <sharedfd+0x9b>
     ed5:	83 ec 04             	sub    $0x4,%esp
     ed8:	6a 0a                	push   $0xa
     eda:	56                   	push   %esi
     edb:	57                   	push   %edi
     edc:	e8 12 2a 00 00       	call   38f3 <write>
     ee1:	83 c4 10             	add    $0x10,%esp
     ee4:	83 f8 0a             	cmp    $0xa,%eax
     ee7:	74 e7                	je     ed0 <sharedfd+0x70>
     ee9:	83 ec 08             	sub    $0x8,%esp
     eec:	68 d4 4e 00 00       	push   $0x4ed4
     ef1:	6a 01                	push   $0x1
     ef3:	e8 88 2b 00 00       	call   3a80 <printf>
     ef8:	83 c4 10             	add    $0x10,%esp
     efb:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     efe:	85 c9                	test   %ecx,%ecx
     f00:	0f 84 f5 00 00 00    	je     ffb <sharedfd+0x19b>
     f06:	e8 d0 29 00 00       	call   38db <wait>
     f0b:	83 ec 0c             	sub    $0xc,%esp
     f0e:	31 db                	xor    %ebx,%ebx
     f10:	57                   	push   %edi
     f11:	8d 7d e8             	lea    -0x18(%ebp),%edi
     f14:	e8 e2 29 00 00       	call   38fb <close>
     f19:	58                   	pop    %eax
     f1a:	5a                   	pop    %edx
     f1b:	6a 00                	push   $0x0
     f1d:	68 e3 41 00 00       	push   $0x41e3
     f22:	e8 ec 29 00 00       	call   3913 <open>
     f27:	83 c4 10             	add    $0x10,%esp
     f2a:	31 d2                	xor    %edx,%edx
     f2c:	89 45 d0             	mov    %eax,-0x30(%ebp)
     f2f:	85 c0                	test   %eax,%eax
     f31:	0f 88 aa 00 00 00    	js     fe1 <sharedfd+0x181>
     f37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f3e:	66 90                	xchg   %ax,%ax
     f40:	83 ec 04             	sub    $0x4,%esp
     f43:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     f46:	6a 0a                	push   $0xa
     f48:	56                   	push   %esi
     f49:	ff 75 d0             	push   -0x30(%ebp)
     f4c:	e8 9a 29 00 00       	call   38eb <read>
     f51:	83 c4 10             	add    $0x10,%esp
     f54:	85 c0                	test   %eax,%eax
     f56:	7e 28                	jle    f80 <sharedfd+0x120>
     f58:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f5b:	89 f0                	mov    %esi,%eax
     f5d:	eb 13                	jmp    f72 <sharedfd+0x112>
     f5f:	90                   	nop
     f60:	80 f9 70             	cmp    $0x70,%cl
     f63:	0f 94 c1             	sete   %cl
     f66:	0f b6 c9             	movzbl %cl,%ecx
     f69:	01 cb                	add    %ecx,%ebx
     f6b:	83 c0 01             	add    $0x1,%eax
     f6e:	39 f8                	cmp    %edi,%eax
     f70:	74 ce                	je     f40 <sharedfd+0xe0>
     f72:	0f b6 08             	movzbl (%eax),%ecx
     f75:	80 f9 63             	cmp    $0x63,%cl
     f78:	75 e6                	jne    f60 <sharedfd+0x100>
     f7a:	83 c2 01             	add    $0x1,%edx
     f7d:	eb ec                	jmp    f6b <sharedfd+0x10b>
     f7f:	90                   	nop
     f80:	83 ec 0c             	sub    $0xc,%esp
     f83:	ff 75 d0             	push   -0x30(%ebp)
     f86:	e8 70 29 00 00       	call   38fb <close>
     f8b:	c7 04 24 e3 41 00 00 	movl   $0x41e3,(%esp)
     f92:	e8 8c 29 00 00       	call   3923 <unlink>
     f97:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f9a:	83 c4 10             	add    $0x10,%esp
     f9d:	81 fa 10 27 00 00    	cmp    $0x2710,%edx
     fa3:	75 5b                	jne    1000 <sharedfd+0x1a0>
     fa5:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
     fab:	75 53                	jne    1000 <sharedfd+0x1a0>
     fad:	83 ec 08             	sub    $0x8,%esp
     fb0:	68 ec 41 00 00       	push   $0x41ec
     fb5:	6a 01                	push   $0x1
     fb7:	e8 c4 2a 00 00       	call   3a80 <printf>
     fbc:	83 c4 10             	add    $0x10,%esp
     fbf:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fc2:	5b                   	pop    %ebx
     fc3:	5e                   	pop    %esi
     fc4:	5f                   	pop    %edi
     fc5:	5d                   	pop    %ebp
     fc6:	c3                   	ret    
     fc7:	83 ec 08             	sub    $0x8,%esp
     fca:	68 a8 4e 00 00       	push   $0x4ea8
     fcf:	6a 01                	push   $0x1
     fd1:	e8 aa 2a 00 00       	call   3a80 <printf>
     fd6:	83 c4 10             	add    $0x10,%esp
     fd9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fdc:	5b                   	pop    %ebx
     fdd:	5e                   	pop    %esi
     fde:	5f                   	pop    %edi
     fdf:	5d                   	pop    %ebp
     fe0:	c3                   	ret    
     fe1:	83 ec 08             	sub    $0x8,%esp
     fe4:	68 f4 4e 00 00       	push   $0x4ef4
     fe9:	6a 01                	push   $0x1
     feb:	e8 90 2a 00 00       	call   3a80 <printf>
     ff0:	83 c4 10             	add    $0x10,%esp
     ff3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ff6:	5b                   	pop    %ebx
     ff7:	5e                   	pop    %esi
     ff8:	5f                   	pop    %edi
     ff9:	5d                   	pop    %ebp
     ffa:	c3                   	ret    
     ffb:	e8 d3 28 00 00       	call   38d3 <exit>
    1000:	53                   	push   %ebx
    1001:	52                   	push   %edx
    1002:	68 f9 41 00 00       	push   $0x41f9
    1007:	6a 01                	push   $0x1
    1009:	e8 72 2a 00 00       	call   3a80 <printf>
    100e:	e8 c0 28 00 00       	call   38d3 <exit>
    1013:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    101a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001020 <fourfiles>:
    1020:	55                   	push   %ebp
    1021:	89 e5                	mov    %esp,%ebp
    1023:	57                   	push   %edi
    1024:	56                   	push   %esi
    1025:	be 0e 42 00 00       	mov    $0x420e,%esi
    102a:	53                   	push   %ebx
    102b:	31 db                	xor    %ebx,%ebx
    102d:	83 ec 34             	sub    $0x34,%esp
    1030:	c7 45 d8 0e 42 00 00 	movl   $0x420e,-0x28(%ebp)
    1037:	68 14 42 00 00       	push   $0x4214
    103c:	6a 01                	push   $0x1
    103e:	c7 45 dc 57 43 00 00 	movl   $0x4357,-0x24(%ebp)
    1045:	c7 45 e0 5b 43 00 00 	movl   $0x435b,-0x20(%ebp)
    104c:	c7 45 e4 11 42 00 00 	movl   $0x4211,-0x1c(%ebp)
    1053:	e8 28 2a 00 00       	call   3a80 <printf>
    1058:	83 c4 10             	add    $0x10,%esp
    105b:	83 ec 0c             	sub    $0xc,%esp
    105e:	56                   	push   %esi
    105f:	e8 bf 28 00 00       	call   3923 <unlink>
    1064:	e8 62 28 00 00       	call   38cb <fork>
    1069:	83 c4 10             	add    $0x10,%esp
    106c:	85 c0                	test   %eax,%eax
    106e:	0f 88 64 01 00 00    	js     11d8 <fourfiles+0x1b8>
    1074:	0f 84 e9 00 00 00    	je     1163 <fourfiles+0x143>
    107a:	83 c3 01             	add    $0x1,%ebx
    107d:	83 fb 04             	cmp    $0x4,%ebx
    1080:	74 06                	je     1088 <fourfiles+0x68>
    1082:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    1086:	eb d3                	jmp    105b <fourfiles+0x3b>
    1088:	e8 4e 28 00 00       	call   38db <wait>
    108d:	31 f6                	xor    %esi,%esi
    108f:	e8 47 28 00 00       	call   38db <wait>
    1094:	e8 42 28 00 00       	call   38db <wait>
    1099:	e8 3d 28 00 00       	call   38db <wait>
    109e:	8b 44 b5 d8          	mov    -0x28(%ebp,%esi,4),%eax
    10a2:	83 ec 08             	sub    $0x8,%esp
    10a5:	31 db                	xor    %ebx,%ebx
    10a7:	6a 00                	push   $0x0
    10a9:	50                   	push   %eax
    10aa:	89 45 d0             	mov    %eax,-0x30(%ebp)
    10ad:	e8 61 28 00 00       	call   3913 <open>
    10b2:	83 c4 10             	add    $0x10,%esp
    10b5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    10b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10bf:	90                   	nop
    10c0:	83 ec 04             	sub    $0x4,%esp
    10c3:	68 00 20 00 00       	push   $0x2000
    10c8:	68 e0 85 00 00       	push   $0x85e0
    10cd:	ff 75 d4             	push   -0x2c(%ebp)
    10d0:	e8 16 28 00 00       	call   38eb <read>
    10d5:	83 c4 10             	add    $0x10,%esp
    10d8:	89 c7                	mov    %eax,%edi
    10da:	85 c0                	test   %eax,%eax
    10dc:	7e 20                	jle    10fe <fourfiles+0xde>
    10de:	31 c0                	xor    %eax,%eax
    10e0:	83 fe 01             	cmp    $0x1,%esi
    10e3:	0f be 88 e0 85 00 00 	movsbl 0x85e0(%eax),%ecx
    10ea:	19 d2                	sbb    %edx,%edx
    10ec:	83 c2 31             	add    $0x31,%edx
    10ef:	39 d1                	cmp    %edx,%ecx
    10f1:	75 5c                	jne    114f <fourfiles+0x12f>
    10f3:	83 c0 01             	add    $0x1,%eax
    10f6:	39 c7                	cmp    %eax,%edi
    10f8:	75 e6                	jne    10e0 <fourfiles+0xc0>
    10fa:	01 fb                	add    %edi,%ebx
    10fc:	eb c2                	jmp    10c0 <fourfiles+0xa0>
    10fe:	83 ec 0c             	sub    $0xc,%esp
    1101:	ff 75 d4             	push   -0x2c(%ebp)
    1104:	e8 f2 27 00 00       	call   38fb <close>
    1109:	83 c4 10             	add    $0x10,%esp
    110c:	81 fb 70 17 00 00    	cmp    $0x1770,%ebx
    1112:	0f 85 d4 00 00 00    	jne    11ec <fourfiles+0x1cc>
    1118:	83 ec 0c             	sub    $0xc,%esp
    111b:	ff 75 d0             	push   -0x30(%ebp)
    111e:	e8 00 28 00 00       	call   3923 <unlink>
    1123:	83 c4 10             	add    $0x10,%esp
    1126:	83 fe 01             	cmp    $0x1,%esi
    1129:	75 1a                	jne    1145 <fourfiles+0x125>
    112b:	83 ec 08             	sub    $0x8,%esp
    112e:	68 52 42 00 00       	push   $0x4252
    1133:	6a 01                	push   $0x1
    1135:	e8 46 29 00 00       	call   3a80 <printf>
    113a:	83 c4 10             	add    $0x10,%esp
    113d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1140:	5b                   	pop    %ebx
    1141:	5e                   	pop    %esi
    1142:	5f                   	pop    %edi
    1143:	5d                   	pop    %ebp
    1144:	c3                   	ret    
    1145:	be 01 00 00 00       	mov    $0x1,%esi
    114a:	e9 4f ff ff ff       	jmp    109e <fourfiles+0x7e>
    114f:	83 ec 08             	sub    $0x8,%esp
    1152:	68 35 42 00 00       	push   $0x4235
    1157:	6a 01                	push   $0x1
    1159:	e8 22 29 00 00       	call   3a80 <printf>
    115e:	e8 70 27 00 00       	call   38d3 <exit>
    1163:	83 ec 08             	sub    $0x8,%esp
    1166:	68 02 02 00 00       	push   $0x202
    116b:	56                   	push   %esi
    116c:	e8 a2 27 00 00       	call   3913 <open>
    1171:	83 c4 10             	add    $0x10,%esp
    1174:	89 c6                	mov    %eax,%esi
    1176:	85 c0                	test   %eax,%eax
    1178:	78 45                	js     11bf <fourfiles+0x19f>
    117a:	83 ec 04             	sub    $0x4,%esp
    117d:	83 c3 30             	add    $0x30,%ebx
    1180:	68 00 02 00 00       	push   $0x200
    1185:	53                   	push   %ebx
    1186:	bb 0c 00 00 00       	mov    $0xc,%ebx
    118b:	68 e0 85 00 00       	push   $0x85e0
    1190:	e8 ab 25 00 00       	call   3740 <memset>
    1195:	83 c4 10             	add    $0x10,%esp
    1198:	83 ec 04             	sub    $0x4,%esp
    119b:	68 f4 01 00 00       	push   $0x1f4
    11a0:	68 e0 85 00 00       	push   $0x85e0
    11a5:	56                   	push   %esi
    11a6:	e8 48 27 00 00       	call   38f3 <write>
    11ab:	83 c4 10             	add    $0x10,%esp
    11ae:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    11b3:	75 4a                	jne    11ff <fourfiles+0x1df>
    11b5:	83 eb 01             	sub    $0x1,%ebx
    11b8:	75 de                	jne    1198 <fourfiles+0x178>
    11ba:	e8 14 27 00 00       	call   38d3 <exit>
    11bf:	51                   	push   %ecx
    11c0:	51                   	push   %ecx
    11c1:	68 af 44 00 00       	push   $0x44af
    11c6:	6a 01                	push   $0x1
    11c8:	e8 b3 28 00 00       	call   3a80 <printf>
    11cd:	e8 01 27 00 00       	call   38d3 <exit>
    11d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11d8:	83 ec 08             	sub    $0x8,%esp
    11db:	68 e9 4c 00 00       	push   $0x4ce9
    11e0:	6a 01                	push   $0x1
    11e2:	e8 99 28 00 00       	call   3a80 <printf>
    11e7:	e8 e7 26 00 00       	call   38d3 <exit>
    11ec:	50                   	push   %eax
    11ed:	53                   	push   %ebx
    11ee:	68 41 42 00 00       	push   $0x4241
    11f3:	6a 01                	push   $0x1
    11f5:	e8 86 28 00 00       	call   3a80 <printf>
    11fa:	e8 d4 26 00 00       	call   38d3 <exit>
    11ff:	52                   	push   %edx
    1200:	50                   	push   %eax
    1201:	68 24 42 00 00       	push   $0x4224
    1206:	6a 01                	push   $0x1
    1208:	e8 73 28 00 00       	call   3a80 <printf>
    120d:	e8 c1 26 00 00       	call   38d3 <exit>
    1212:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001220 <createdelete>:
    1220:	55                   	push   %ebp
    1221:	89 e5                	mov    %esp,%ebp
    1223:	57                   	push   %edi
    1224:	56                   	push   %esi
    1225:	53                   	push   %ebx
    1226:	31 db                	xor    %ebx,%ebx
    1228:	83 ec 44             	sub    $0x44,%esp
    122b:	68 60 42 00 00       	push   $0x4260
    1230:	6a 01                	push   $0x1
    1232:	e8 49 28 00 00       	call   3a80 <printf>
    1237:	83 c4 10             	add    $0x10,%esp
    123a:	e8 8c 26 00 00       	call   38cb <fork>
    123f:	85 c0                	test   %eax,%eax
    1241:	0f 88 c3 01 00 00    	js     140a <createdelete+0x1ea>
    1247:	0f 84 13 01 00 00    	je     1360 <createdelete+0x140>
    124d:	83 c3 01             	add    $0x1,%ebx
    1250:	83 fb 04             	cmp    $0x4,%ebx
    1253:	75 e5                	jne    123a <createdelete+0x1a>
    1255:	e8 81 26 00 00       	call   38db <wait>
    125a:	31 f6                	xor    %esi,%esi
    125c:	8d 7d c8             	lea    -0x38(%ebp),%edi
    125f:	e8 77 26 00 00       	call   38db <wait>
    1264:	e8 72 26 00 00       	call   38db <wait>
    1269:	e8 6d 26 00 00       	call   38db <wait>
    126e:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1272:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1278:	85 f6                	test   %esi,%esi
    127a:	8d 46 30             	lea    0x30(%esi),%eax
    127d:	0f 94 c3             	sete   %bl
    1280:	83 fe 09             	cmp    $0x9,%esi
    1283:	88 45 c7             	mov    %al,-0x39(%ebp)
    1286:	0f 9f c0             	setg   %al
    1289:	09 c3                	or     %eax,%ebx
    128b:	8d 46 ff             	lea    -0x1(%esi),%eax
    128e:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1291:	88 5d c6             	mov    %bl,-0x3a(%ebp)
    1294:	bb 70 00 00 00       	mov    $0x70,%ebx
    1299:	83 ec 08             	sub    $0x8,%esp
    129c:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
    12a0:	88 5d c8             	mov    %bl,-0x38(%ebp)
    12a3:	6a 00                	push   $0x0
    12a5:	57                   	push   %edi
    12a6:	88 45 c9             	mov    %al,-0x37(%ebp)
    12a9:	e8 65 26 00 00       	call   3913 <open>
    12ae:	83 c4 10             	add    $0x10,%esp
    12b1:	80 7d c6 00          	cmpb   $0x0,-0x3a(%ebp)
    12b5:	0f 84 85 00 00 00    	je     1340 <createdelete+0x120>
    12bb:	85 c0                	test   %eax,%eax
    12bd:	0f 88 32 01 00 00    	js     13f5 <createdelete+0x1d5>
    12c3:	83 7d c0 08          	cmpl   $0x8,-0x40(%ebp)
    12c7:	76 7b                	jbe    1344 <createdelete+0x124>
    12c9:	83 ec 0c             	sub    $0xc,%esp
    12cc:	50                   	push   %eax
    12cd:	e8 29 26 00 00       	call   38fb <close>
    12d2:	83 c4 10             	add    $0x10,%esp
    12d5:	83 c3 01             	add    $0x1,%ebx
    12d8:	80 fb 74             	cmp    $0x74,%bl
    12db:	75 bc                	jne    1299 <createdelete+0x79>
    12dd:	83 c6 01             	add    $0x1,%esi
    12e0:	83 fe 14             	cmp    $0x14,%esi
    12e3:	75 93                	jne    1278 <createdelete+0x58>
    12e5:	be 70 00 00 00       	mov    $0x70,%esi
    12ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    12f0:	8d 46 c0             	lea    -0x40(%esi),%eax
    12f3:	bb 04 00 00 00       	mov    $0x4,%ebx
    12f8:	88 45 c7             	mov    %al,-0x39(%ebp)
    12fb:	83 ec 0c             	sub    $0xc,%esp
    12fe:	89 f0                	mov    %esi,%eax
    1300:	57                   	push   %edi
    1301:	88 45 c8             	mov    %al,-0x38(%ebp)
    1304:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
    1308:	88 45 c9             	mov    %al,-0x37(%ebp)
    130b:	e8 13 26 00 00       	call   3923 <unlink>
    1310:	83 c4 10             	add    $0x10,%esp
    1313:	83 eb 01             	sub    $0x1,%ebx
    1316:	75 e3                	jne    12fb <createdelete+0xdb>
    1318:	83 c6 01             	add    $0x1,%esi
    131b:	89 f0                	mov    %esi,%eax
    131d:	3c 84                	cmp    $0x84,%al
    131f:	75 cf                	jne    12f0 <createdelete+0xd0>
    1321:	83 ec 08             	sub    $0x8,%esp
    1324:	68 73 42 00 00       	push   $0x4273
    1329:	6a 01                	push   $0x1
    132b:	e8 50 27 00 00       	call   3a80 <printf>
    1330:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1333:	5b                   	pop    %ebx
    1334:	5e                   	pop    %esi
    1335:	5f                   	pop    %edi
    1336:	5d                   	pop    %ebp
    1337:	c3                   	ret    
    1338:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    133f:	90                   	nop
    1340:	85 c0                	test   %eax,%eax
    1342:	78 91                	js     12d5 <createdelete+0xb5>
    1344:	50                   	push   %eax
    1345:	57                   	push   %edi
    1346:	68 44 4f 00 00       	push   $0x4f44
    134b:	6a 01                	push   $0x1
    134d:	e8 2e 27 00 00       	call   3a80 <printf>
    1352:	e8 7c 25 00 00       	call   38d3 <exit>
    1357:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    135e:	66 90                	xchg   %ax,%ax
    1360:	83 c3 70             	add    $0x70,%ebx
    1363:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1367:	be 01 00 00 00       	mov    $0x1,%esi
    136c:	8d 7d c8             	lea    -0x38(%ebp),%edi
    136f:	88 5d c8             	mov    %bl,-0x38(%ebp)
    1372:	31 db                	xor    %ebx,%ebx
    1374:	eb 15                	jmp    138b <createdelete+0x16b>
    1376:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    137d:	8d 76 00             	lea    0x0(%esi),%esi
    1380:	83 fe 14             	cmp    $0x14,%esi
    1383:	74 6b                	je     13f0 <createdelete+0x1d0>
    1385:	83 c3 01             	add    $0x1,%ebx
    1388:	83 c6 01             	add    $0x1,%esi
    138b:	83 ec 08             	sub    $0x8,%esp
    138e:	8d 43 30             	lea    0x30(%ebx),%eax
    1391:	68 02 02 00 00       	push   $0x202
    1396:	57                   	push   %edi
    1397:	88 45 c9             	mov    %al,-0x37(%ebp)
    139a:	e8 74 25 00 00       	call   3913 <open>
    139f:	83 c4 10             	add    $0x10,%esp
    13a2:	85 c0                	test   %eax,%eax
    13a4:	78 78                	js     141e <createdelete+0x1fe>
    13a6:	83 ec 0c             	sub    $0xc,%esp
    13a9:	50                   	push   %eax
    13aa:	e8 4c 25 00 00       	call   38fb <close>
    13af:	83 c4 10             	add    $0x10,%esp
    13b2:	85 db                	test   %ebx,%ebx
    13b4:	74 cf                	je     1385 <createdelete+0x165>
    13b6:	f6 c3 01             	test   $0x1,%bl
    13b9:	75 c5                	jne    1380 <createdelete+0x160>
    13bb:	83 ec 0c             	sub    $0xc,%esp
    13be:	89 d8                	mov    %ebx,%eax
    13c0:	57                   	push   %edi
    13c1:	d1 f8                	sar    %eax
    13c3:	83 c0 30             	add    $0x30,%eax
    13c6:	88 45 c9             	mov    %al,-0x37(%ebp)
    13c9:	e8 55 25 00 00       	call   3923 <unlink>
    13ce:	83 c4 10             	add    $0x10,%esp
    13d1:	85 c0                	test   %eax,%eax
    13d3:	79 ab                	jns    1380 <createdelete+0x160>
    13d5:	52                   	push   %edx
    13d6:	52                   	push   %edx
    13d7:	68 61 3e 00 00       	push   $0x3e61
    13dc:	6a 01                	push   $0x1
    13de:	e8 9d 26 00 00       	call   3a80 <printf>
    13e3:	e8 eb 24 00 00       	call   38d3 <exit>
    13e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13ef:	90                   	nop
    13f0:	e8 de 24 00 00       	call   38d3 <exit>
    13f5:	83 ec 04             	sub    $0x4,%esp
    13f8:	57                   	push   %edi
    13f9:	68 20 4f 00 00       	push   $0x4f20
    13fe:	6a 01                	push   $0x1
    1400:	e8 7b 26 00 00       	call   3a80 <printf>
    1405:	e8 c9 24 00 00       	call   38d3 <exit>
    140a:	83 ec 08             	sub    $0x8,%esp
    140d:	68 e9 4c 00 00       	push   $0x4ce9
    1412:	6a 01                	push   $0x1
    1414:	e8 67 26 00 00       	call   3a80 <printf>
    1419:	e8 b5 24 00 00       	call   38d3 <exit>
    141e:	83 ec 08             	sub    $0x8,%esp
    1421:	68 af 44 00 00       	push   $0x44af
    1426:	6a 01                	push   $0x1
    1428:	e8 53 26 00 00       	call   3a80 <printf>
    142d:	e8 a1 24 00 00       	call   38d3 <exit>
    1432:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001440 <unlinkread>:
    1440:	55                   	push   %ebp
    1441:	89 e5                	mov    %esp,%ebp
    1443:	56                   	push   %esi
    1444:	53                   	push   %ebx
    1445:	83 ec 08             	sub    $0x8,%esp
    1448:	68 84 42 00 00       	push   $0x4284
    144d:	6a 01                	push   $0x1
    144f:	e8 2c 26 00 00       	call   3a80 <printf>
    1454:	5b                   	pop    %ebx
    1455:	5e                   	pop    %esi
    1456:	68 02 02 00 00       	push   $0x202
    145b:	68 95 42 00 00       	push   $0x4295
    1460:	e8 ae 24 00 00       	call   3913 <open>
    1465:	83 c4 10             	add    $0x10,%esp
    1468:	85 c0                	test   %eax,%eax
    146a:	0f 88 e6 00 00 00    	js     1556 <unlinkread+0x116>
    1470:	83 ec 04             	sub    $0x4,%esp
    1473:	89 c3                	mov    %eax,%ebx
    1475:	6a 05                	push   $0x5
    1477:	68 ba 42 00 00       	push   $0x42ba
    147c:	50                   	push   %eax
    147d:	e8 71 24 00 00       	call   38f3 <write>
    1482:	89 1c 24             	mov    %ebx,(%esp)
    1485:	e8 71 24 00 00       	call   38fb <close>
    148a:	58                   	pop    %eax
    148b:	5a                   	pop    %edx
    148c:	6a 02                	push   $0x2
    148e:	68 95 42 00 00       	push   $0x4295
    1493:	e8 7b 24 00 00       	call   3913 <open>
    1498:	83 c4 10             	add    $0x10,%esp
    149b:	89 c3                	mov    %eax,%ebx
    149d:	85 c0                	test   %eax,%eax
    149f:	0f 88 10 01 00 00    	js     15b5 <unlinkread+0x175>
    14a5:	83 ec 0c             	sub    $0xc,%esp
    14a8:	68 95 42 00 00       	push   $0x4295
    14ad:	e8 71 24 00 00       	call   3923 <unlink>
    14b2:	83 c4 10             	add    $0x10,%esp
    14b5:	85 c0                	test   %eax,%eax
    14b7:	0f 85 e5 00 00 00    	jne    15a2 <unlinkread+0x162>
    14bd:	83 ec 08             	sub    $0x8,%esp
    14c0:	68 02 02 00 00       	push   $0x202
    14c5:	68 95 42 00 00       	push   $0x4295
    14ca:	e8 44 24 00 00       	call   3913 <open>
    14cf:	83 c4 0c             	add    $0xc,%esp
    14d2:	6a 03                	push   $0x3
    14d4:	89 c6                	mov    %eax,%esi
    14d6:	68 f2 42 00 00       	push   $0x42f2
    14db:	50                   	push   %eax
    14dc:	e8 12 24 00 00       	call   38f3 <write>
    14e1:	89 34 24             	mov    %esi,(%esp)
    14e4:	e8 12 24 00 00       	call   38fb <close>
    14e9:	83 c4 0c             	add    $0xc,%esp
    14ec:	68 00 20 00 00       	push   $0x2000
    14f1:	68 e0 85 00 00       	push   $0x85e0
    14f6:	53                   	push   %ebx
    14f7:	e8 ef 23 00 00       	call   38eb <read>
    14fc:	83 c4 10             	add    $0x10,%esp
    14ff:	83 f8 05             	cmp    $0x5,%eax
    1502:	0f 85 87 00 00 00    	jne    158f <unlinkread+0x14f>
    1508:	80 3d e0 85 00 00 68 	cmpb   $0x68,0x85e0
    150f:	75 6b                	jne    157c <unlinkread+0x13c>
    1511:	83 ec 04             	sub    $0x4,%esp
    1514:	6a 0a                	push   $0xa
    1516:	68 e0 85 00 00       	push   $0x85e0
    151b:	53                   	push   %ebx
    151c:	e8 d2 23 00 00       	call   38f3 <write>
    1521:	83 c4 10             	add    $0x10,%esp
    1524:	83 f8 0a             	cmp    $0xa,%eax
    1527:	75 40                	jne    1569 <unlinkread+0x129>
    1529:	83 ec 0c             	sub    $0xc,%esp
    152c:	53                   	push   %ebx
    152d:	e8 c9 23 00 00       	call   38fb <close>
    1532:	c7 04 24 95 42 00 00 	movl   $0x4295,(%esp)
    1539:	e8 e5 23 00 00       	call   3923 <unlink>
    153e:	58                   	pop    %eax
    153f:	5a                   	pop    %edx
    1540:	68 3d 43 00 00       	push   $0x433d
    1545:	6a 01                	push   $0x1
    1547:	e8 34 25 00 00       	call   3a80 <printf>
    154c:	83 c4 10             	add    $0x10,%esp
    154f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1552:	5b                   	pop    %ebx
    1553:	5e                   	pop    %esi
    1554:	5d                   	pop    %ebp
    1555:	c3                   	ret    
    1556:	51                   	push   %ecx
    1557:	51                   	push   %ecx
    1558:	68 a0 42 00 00       	push   $0x42a0
    155d:	6a 01                	push   $0x1
    155f:	e8 1c 25 00 00       	call   3a80 <printf>
    1564:	e8 6a 23 00 00       	call   38d3 <exit>
    1569:	51                   	push   %ecx
    156a:	51                   	push   %ecx
    156b:	68 24 43 00 00       	push   $0x4324
    1570:	6a 01                	push   $0x1
    1572:	e8 09 25 00 00       	call   3a80 <printf>
    1577:	e8 57 23 00 00       	call   38d3 <exit>
    157c:	53                   	push   %ebx
    157d:	53                   	push   %ebx
    157e:	68 0d 43 00 00       	push   $0x430d
    1583:	6a 01                	push   $0x1
    1585:	e8 f6 24 00 00       	call   3a80 <printf>
    158a:	e8 44 23 00 00       	call   38d3 <exit>
    158f:	56                   	push   %esi
    1590:	56                   	push   %esi
    1591:	68 f6 42 00 00       	push   $0x42f6
    1596:	6a 01                	push   $0x1
    1598:	e8 e3 24 00 00       	call   3a80 <printf>
    159d:	e8 31 23 00 00       	call   38d3 <exit>
    15a2:	50                   	push   %eax
    15a3:	50                   	push   %eax
    15a4:	68 d8 42 00 00       	push   $0x42d8
    15a9:	6a 01                	push   $0x1
    15ab:	e8 d0 24 00 00       	call   3a80 <printf>
    15b0:	e8 1e 23 00 00       	call   38d3 <exit>
    15b5:	50                   	push   %eax
    15b6:	50                   	push   %eax
    15b7:	68 c0 42 00 00       	push   $0x42c0
    15bc:	6a 01                	push   $0x1
    15be:	e8 bd 24 00 00       	call   3a80 <printf>
    15c3:	e8 0b 23 00 00       	call   38d3 <exit>
    15c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15cf:	90                   	nop

000015d0 <linktest>:
    15d0:	55                   	push   %ebp
    15d1:	89 e5                	mov    %esp,%ebp
    15d3:	53                   	push   %ebx
    15d4:	83 ec 0c             	sub    $0xc,%esp
    15d7:	68 4c 43 00 00       	push   $0x434c
    15dc:	6a 01                	push   $0x1
    15de:	e8 9d 24 00 00       	call   3a80 <printf>
    15e3:	c7 04 24 56 43 00 00 	movl   $0x4356,(%esp)
    15ea:	e8 34 23 00 00       	call   3923 <unlink>
    15ef:	c7 04 24 5a 43 00 00 	movl   $0x435a,(%esp)
    15f6:	e8 28 23 00 00       	call   3923 <unlink>
    15fb:	58                   	pop    %eax
    15fc:	5a                   	pop    %edx
    15fd:	68 02 02 00 00       	push   $0x202
    1602:	68 56 43 00 00       	push   $0x4356
    1607:	e8 07 23 00 00       	call   3913 <open>
    160c:	83 c4 10             	add    $0x10,%esp
    160f:	85 c0                	test   %eax,%eax
    1611:	0f 88 1e 01 00 00    	js     1735 <linktest+0x165>
    1617:	83 ec 04             	sub    $0x4,%esp
    161a:	89 c3                	mov    %eax,%ebx
    161c:	6a 05                	push   $0x5
    161e:	68 ba 42 00 00       	push   $0x42ba
    1623:	50                   	push   %eax
    1624:	e8 ca 22 00 00       	call   38f3 <write>
    1629:	83 c4 10             	add    $0x10,%esp
    162c:	83 f8 05             	cmp    $0x5,%eax
    162f:	0f 85 98 01 00 00    	jne    17cd <linktest+0x1fd>
    1635:	83 ec 0c             	sub    $0xc,%esp
    1638:	53                   	push   %ebx
    1639:	e8 bd 22 00 00       	call   38fb <close>
    163e:	5b                   	pop    %ebx
    163f:	58                   	pop    %eax
    1640:	68 5a 43 00 00       	push   $0x435a
    1645:	68 56 43 00 00       	push   $0x4356
    164a:	e8 e4 22 00 00       	call   3933 <link>
    164f:	83 c4 10             	add    $0x10,%esp
    1652:	85 c0                	test   %eax,%eax
    1654:	0f 88 60 01 00 00    	js     17ba <linktest+0x1ea>
    165a:	83 ec 0c             	sub    $0xc,%esp
    165d:	68 56 43 00 00       	push   $0x4356
    1662:	e8 bc 22 00 00       	call   3923 <unlink>
    1667:	58                   	pop    %eax
    1668:	5a                   	pop    %edx
    1669:	6a 00                	push   $0x0
    166b:	68 56 43 00 00       	push   $0x4356
    1670:	e8 9e 22 00 00       	call   3913 <open>
    1675:	83 c4 10             	add    $0x10,%esp
    1678:	85 c0                	test   %eax,%eax
    167a:	0f 89 27 01 00 00    	jns    17a7 <linktest+0x1d7>
    1680:	83 ec 08             	sub    $0x8,%esp
    1683:	6a 00                	push   $0x0
    1685:	68 5a 43 00 00       	push   $0x435a
    168a:	e8 84 22 00 00       	call   3913 <open>
    168f:	83 c4 10             	add    $0x10,%esp
    1692:	89 c3                	mov    %eax,%ebx
    1694:	85 c0                	test   %eax,%eax
    1696:	0f 88 f8 00 00 00    	js     1794 <linktest+0x1c4>
    169c:	83 ec 04             	sub    $0x4,%esp
    169f:	68 00 20 00 00       	push   $0x2000
    16a4:	68 e0 85 00 00       	push   $0x85e0
    16a9:	50                   	push   %eax
    16aa:	e8 3c 22 00 00       	call   38eb <read>
    16af:	83 c4 10             	add    $0x10,%esp
    16b2:	83 f8 05             	cmp    $0x5,%eax
    16b5:	0f 85 c6 00 00 00    	jne    1781 <linktest+0x1b1>
    16bb:	83 ec 0c             	sub    $0xc,%esp
    16be:	53                   	push   %ebx
    16bf:	e8 37 22 00 00       	call   38fb <close>
    16c4:	58                   	pop    %eax
    16c5:	5a                   	pop    %edx
    16c6:	68 5a 43 00 00       	push   $0x435a
    16cb:	68 5a 43 00 00       	push   $0x435a
    16d0:	e8 5e 22 00 00       	call   3933 <link>
    16d5:	83 c4 10             	add    $0x10,%esp
    16d8:	85 c0                	test   %eax,%eax
    16da:	0f 89 8e 00 00 00    	jns    176e <linktest+0x19e>
    16e0:	83 ec 0c             	sub    $0xc,%esp
    16e3:	68 5a 43 00 00       	push   $0x435a
    16e8:	e8 36 22 00 00       	call   3923 <unlink>
    16ed:	59                   	pop    %ecx
    16ee:	5b                   	pop    %ebx
    16ef:	68 56 43 00 00       	push   $0x4356
    16f4:	68 5a 43 00 00       	push   $0x435a
    16f9:	e8 35 22 00 00       	call   3933 <link>
    16fe:	83 c4 10             	add    $0x10,%esp
    1701:	85 c0                	test   %eax,%eax
    1703:	79 56                	jns    175b <linktest+0x18b>
    1705:	83 ec 08             	sub    $0x8,%esp
    1708:	68 56 43 00 00       	push   $0x4356
    170d:	68 1e 46 00 00       	push   $0x461e
    1712:	e8 1c 22 00 00       	call   3933 <link>
    1717:	83 c4 10             	add    $0x10,%esp
    171a:	85 c0                	test   %eax,%eax
    171c:	79 2a                	jns    1748 <linktest+0x178>
    171e:	83 ec 08             	sub    $0x8,%esp
    1721:	68 f4 43 00 00       	push   $0x43f4
    1726:	6a 01                	push   $0x1
    1728:	e8 53 23 00 00       	call   3a80 <printf>
    172d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1730:	83 c4 10             	add    $0x10,%esp
    1733:	c9                   	leave  
    1734:	c3                   	ret    
    1735:	50                   	push   %eax
    1736:	50                   	push   %eax
    1737:	68 5e 43 00 00       	push   $0x435e
    173c:	6a 01                	push   $0x1
    173e:	e8 3d 23 00 00       	call   3a80 <printf>
    1743:	e8 8b 21 00 00       	call   38d3 <exit>
    1748:	50                   	push   %eax
    1749:	50                   	push   %eax
    174a:	68 d8 43 00 00       	push   $0x43d8
    174f:	6a 01                	push   $0x1
    1751:	e8 2a 23 00 00       	call   3a80 <printf>
    1756:	e8 78 21 00 00       	call   38d3 <exit>
    175b:	52                   	push   %edx
    175c:	52                   	push   %edx
    175d:	68 8c 4f 00 00       	push   $0x4f8c
    1762:	6a 01                	push   $0x1
    1764:	e8 17 23 00 00       	call   3a80 <printf>
    1769:	e8 65 21 00 00       	call   38d3 <exit>
    176e:	50                   	push   %eax
    176f:	50                   	push   %eax
    1770:	68 ba 43 00 00       	push   $0x43ba
    1775:	6a 01                	push   $0x1
    1777:	e8 04 23 00 00       	call   3a80 <printf>
    177c:	e8 52 21 00 00       	call   38d3 <exit>
    1781:	51                   	push   %ecx
    1782:	51                   	push   %ecx
    1783:	68 a9 43 00 00       	push   $0x43a9
    1788:	6a 01                	push   $0x1
    178a:	e8 f1 22 00 00       	call   3a80 <printf>
    178f:	e8 3f 21 00 00       	call   38d3 <exit>
    1794:	53                   	push   %ebx
    1795:	53                   	push   %ebx
    1796:	68 98 43 00 00       	push   $0x4398
    179b:	6a 01                	push   $0x1
    179d:	e8 de 22 00 00       	call   3a80 <printf>
    17a2:	e8 2c 21 00 00       	call   38d3 <exit>
    17a7:	50                   	push   %eax
    17a8:	50                   	push   %eax
    17a9:	68 64 4f 00 00       	push   $0x4f64
    17ae:	6a 01                	push   $0x1
    17b0:	e8 cb 22 00 00       	call   3a80 <printf>
    17b5:	e8 19 21 00 00       	call   38d3 <exit>
    17ba:	51                   	push   %ecx
    17bb:	51                   	push   %ecx
    17bc:	68 83 43 00 00       	push   $0x4383
    17c1:	6a 01                	push   $0x1
    17c3:	e8 b8 22 00 00       	call   3a80 <printf>
    17c8:	e8 06 21 00 00       	call   38d3 <exit>
    17cd:	50                   	push   %eax
    17ce:	50                   	push   %eax
    17cf:	68 71 43 00 00       	push   $0x4371
    17d4:	6a 01                	push   $0x1
    17d6:	e8 a5 22 00 00       	call   3a80 <printf>
    17db:	e8 f3 20 00 00       	call   38d3 <exit>

000017e0 <concreate>:
    17e0:	55                   	push   %ebp
    17e1:	89 e5                	mov    %esp,%ebp
    17e3:	57                   	push   %edi
    17e4:	56                   	push   %esi
    17e5:	31 f6                	xor    %esi,%esi
    17e7:	53                   	push   %ebx
    17e8:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    17eb:	83 ec 64             	sub    $0x64,%esp
    17ee:	68 01 44 00 00       	push   $0x4401
    17f3:	6a 01                	push   $0x1
    17f5:	e8 86 22 00 00       	call   3a80 <printf>
    17fa:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
    17fe:	83 c4 10             	add    $0x10,%esp
    1801:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
    1805:	eb 4c                	jmp    1853 <concreate+0x73>
    1807:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    180e:	66 90                	xchg   %ax,%ax
    1810:	69 c6 ab aa aa aa    	imul   $0xaaaaaaab,%esi,%eax
    1816:	3d ab aa aa aa       	cmp    $0xaaaaaaab,%eax
    181b:	0f 83 af 00 00 00    	jae    18d0 <concreate+0xf0>
    1821:	83 ec 08             	sub    $0x8,%esp
    1824:	68 02 02 00 00       	push   $0x202
    1829:	53                   	push   %ebx
    182a:	e8 e4 20 00 00       	call   3913 <open>
    182f:	83 c4 10             	add    $0x10,%esp
    1832:	85 c0                	test   %eax,%eax
    1834:	78 5f                	js     1895 <concreate+0xb5>
    1836:	83 ec 0c             	sub    $0xc,%esp
    1839:	83 c6 01             	add    $0x1,%esi
    183c:	50                   	push   %eax
    183d:	e8 b9 20 00 00       	call   38fb <close>
    1842:	83 c4 10             	add    $0x10,%esp
    1845:	e8 91 20 00 00       	call   38db <wait>
    184a:	83 fe 28             	cmp    $0x28,%esi
    184d:	0f 84 9f 00 00 00    	je     18f2 <concreate+0x112>
    1853:	83 ec 0c             	sub    $0xc,%esp
    1856:	8d 46 30             	lea    0x30(%esi),%eax
    1859:	53                   	push   %ebx
    185a:	88 45 ae             	mov    %al,-0x52(%ebp)
    185d:	e8 c1 20 00 00       	call   3923 <unlink>
    1862:	e8 64 20 00 00       	call   38cb <fork>
    1867:	83 c4 10             	add    $0x10,%esp
    186a:	85 c0                	test   %eax,%eax
    186c:	75 a2                	jne    1810 <concreate+0x30>
    186e:	69 f6 cd cc cc cc    	imul   $0xcccccccd,%esi,%esi
    1874:	81 fe cd cc cc cc    	cmp    $0xcccccccd,%esi
    187a:	73 34                	jae    18b0 <concreate+0xd0>
    187c:	83 ec 08             	sub    $0x8,%esp
    187f:	68 02 02 00 00       	push   $0x202
    1884:	53                   	push   %ebx
    1885:	e8 89 20 00 00       	call   3913 <open>
    188a:	83 c4 10             	add    $0x10,%esp
    188d:	85 c0                	test   %eax,%eax
    188f:	0f 89 39 02 00 00    	jns    1ace <concreate+0x2ee>
    1895:	83 ec 04             	sub    $0x4,%esp
    1898:	53                   	push   %ebx
    1899:	68 14 44 00 00       	push   $0x4414
    189e:	6a 01                	push   $0x1
    18a0:	e8 db 21 00 00       	call   3a80 <printf>
    18a5:	e8 29 20 00 00       	call   38d3 <exit>
    18aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    18b0:	83 ec 08             	sub    $0x8,%esp
    18b3:	53                   	push   %ebx
    18b4:	68 11 44 00 00       	push   $0x4411
    18b9:	e8 75 20 00 00       	call   3933 <link>
    18be:	83 c4 10             	add    $0x10,%esp
    18c1:	e8 0d 20 00 00       	call   38d3 <exit>
    18c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    18cd:	8d 76 00             	lea    0x0(%esi),%esi
    18d0:	83 ec 08             	sub    $0x8,%esp
    18d3:	83 c6 01             	add    $0x1,%esi
    18d6:	53                   	push   %ebx
    18d7:	68 11 44 00 00       	push   $0x4411
    18dc:	e8 52 20 00 00       	call   3933 <link>
    18e1:	83 c4 10             	add    $0x10,%esp
    18e4:	e8 f2 1f 00 00       	call   38db <wait>
    18e9:	83 fe 28             	cmp    $0x28,%esi
    18ec:	0f 85 61 ff ff ff    	jne    1853 <concreate+0x73>
    18f2:	83 ec 04             	sub    $0x4,%esp
    18f5:	8d 45 c0             	lea    -0x40(%ebp),%eax
    18f8:	6a 28                	push   $0x28
    18fa:	6a 00                	push   $0x0
    18fc:	50                   	push   %eax
    18fd:	e8 3e 1e 00 00       	call   3740 <memset>
    1902:	5e                   	pop    %esi
    1903:	5f                   	pop    %edi
    1904:	6a 00                	push   $0x0
    1906:	68 1e 46 00 00       	push   $0x461e
    190b:	8d 7d b0             	lea    -0x50(%ebp),%edi
    190e:	e8 00 20 00 00       	call   3913 <open>
    1913:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    191a:	83 c4 10             	add    $0x10,%esp
    191d:	89 c6                	mov    %eax,%esi
    191f:	90                   	nop
    1920:	83 ec 04             	sub    $0x4,%esp
    1923:	6a 10                	push   $0x10
    1925:	57                   	push   %edi
    1926:	56                   	push   %esi
    1927:	e8 bf 1f 00 00       	call   38eb <read>
    192c:	83 c4 10             	add    $0x10,%esp
    192f:	85 c0                	test   %eax,%eax
    1931:	7e 3d                	jle    1970 <concreate+0x190>
    1933:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1938:	74 e6                	je     1920 <concreate+0x140>
    193a:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    193e:	75 e0                	jne    1920 <concreate+0x140>
    1940:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    1944:	75 da                	jne    1920 <concreate+0x140>
    1946:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    194a:	83 e8 30             	sub    $0x30,%eax
    194d:	83 f8 27             	cmp    $0x27,%eax
    1950:	0f 87 60 01 00 00    	ja     1ab6 <concreate+0x2d6>
    1956:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    195b:	0f 85 3d 01 00 00    	jne    1a9e <concreate+0x2be>
    1961:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
    1965:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
    196a:	eb b4                	jmp    1920 <concreate+0x140>
    196c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1970:	83 ec 0c             	sub    $0xc,%esp
    1973:	56                   	push   %esi
    1974:	e8 82 1f 00 00       	call   38fb <close>
    1979:	83 c4 10             	add    $0x10,%esp
    197c:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    1980:	0f 85 05 01 00 00    	jne    1a8b <concreate+0x2ab>
    1986:	31 f6                	xor    %esi,%esi
    1988:	eb 4c                	jmp    19d6 <concreate+0x1f6>
    198a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1990:	85 ff                	test   %edi,%edi
    1992:	74 05                	je     1999 <concreate+0x1b9>
    1994:	83 f8 01             	cmp    $0x1,%eax
    1997:	74 6c                	je     1a05 <concreate+0x225>
    1999:	83 ec 0c             	sub    $0xc,%esp
    199c:	53                   	push   %ebx
    199d:	e8 81 1f 00 00       	call   3923 <unlink>
    19a2:	89 1c 24             	mov    %ebx,(%esp)
    19a5:	e8 79 1f 00 00       	call   3923 <unlink>
    19aa:	89 1c 24             	mov    %ebx,(%esp)
    19ad:	e8 71 1f 00 00       	call   3923 <unlink>
    19b2:	89 1c 24             	mov    %ebx,(%esp)
    19b5:	e8 69 1f 00 00       	call   3923 <unlink>
    19ba:	83 c4 10             	add    $0x10,%esp
    19bd:	85 ff                	test   %edi,%edi
    19bf:	0f 84 fc fe ff ff    	je     18c1 <concreate+0xe1>
    19c5:	e8 11 1f 00 00       	call   38db <wait>
    19ca:	83 c6 01             	add    $0x1,%esi
    19cd:	83 fe 28             	cmp    $0x28,%esi
    19d0:	0f 84 8a 00 00 00    	je     1a60 <concreate+0x280>
    19d6:	8d 46 30             	lea    0x30(%esi),%eax
    19d9:	88 45 ae             	mov    %al,-0x52(%ebp)
    19dc:	e8 ea 1e 00 00       	call   38cb <fork>
    19e1:	89 c7                	mov    %eax,%edi
    19e3:	85 c0                	test   %eax,%eax
    19e5:	0f 88 8c 00 00 00    	js     1a77 <concreate+0x297>
    19eb:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    19f0:	f7 e6                	mul    %esi
    19f2:	89 d0                	mov    %edx,%eax
    19f4:	83 e2 fe             	and    $0xfffffffe,%edx
    19f7:	d1 e8                	shr    %eax
    19f9:	01 c2                	add    %eax,%edx
    19fb:	89 f0                	mov    %esi,%eax
    19fd:	29 d0                	sub    %edx,%eax
    19ff:	89 c1                	mov    %eax,%ecx
    1a01:	09 f9                	or     %edi,%ecx
    1a03:	75 8b                	jne    1990 <concreate+0x1b0>
    1a05:	83 ec 08             	sub    $0x8,%esp
    1a08:	6a 00                	push   $0x0
    1a0a:	53                   	push   %ebx
    1a0b:	e8 03 1f 00 00       	call   3913 <open>
    1a10:	89 04 24             	mov    %eax,(%esp)
    1a13:	e8 e3 1e 00 00       	call   38fb <close>
    1a18:	58                   	pop    %eax
    1a19:	5a                   	pop    %edx
    1a1a:	6a 00                	push   $0x0
    1a1c:	53                   	push   %ebx
    1a1d:	e8 f1 1e 00 00       	call   3913 <open>
    1a22:	89 04 24             	mov    %eax,(%esp)
    1a25:	e8 d1 1e 00 00       	call   38fb <close>
    1a2a:	59                   	pop    %ecx
    1a2b:	58                   	pop    %eax
    1a2c:	6a 00                	push   $0x0
    1a2e:	53                   	push   %ebx
    1a2f:	e8 df 1e 00 00       	call   3913 <open>
    1a34:	89 04 24             	mov    %eax,(%esp)
    1a37:	e8 bf 1e 00 00       	call   38fb <close>
    1a3c:	58                   	pop    %eax
    1a3d:	5a                   	pop    %edx
    1a3e:	6a 00                	push   $0x0
    1a40:	53                   	push   %ebx
    1a41:	e8 cd 1e 00 00       	call   3913 <open>
    1a46:	89 04 24             	mov    %eax,(%esp)
    1a49:	e8 ad 1e 00 00       	call   38fb <close>
    1a4e:	83 c4 10             	add    $0x10,%esp
    1a51:	e9 67 ff ff ff       	jmp    19bd <concreate+0x1dd>
    1a56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1a5d:	8d 76 00             	lea    0x0(%esi),%esi
    1a60:	83 ec 08             	sub    $0x8,%esp
    1a63:	68 66 44 00 00       	push   $0x4466
    1a68:	6a 01                	push   $0x1
    1a6a:	e8 11 20 00 00       	call   3a80 <printf>
    1a6f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a72:	5b                   	pop    %ebx
    1a73:	5e                   	pop    %esi
    1a74:	5f                   	pop    %edi
    1a75:	5d                   	pop    %ebp
    1a76:	c3                   	ret    
    1a77:	83 ec 08             	sub    $0x8,%esp
    1a7a:	68 e9 4c 00 00       	push   $0x4ce9
    1a7f:	6a 01                	push   $0x1
    1a81:	e8 fa 1f 00 00       	call   3a80 <printf>
    1a86:	e8 48 1e 00 00       	call   38d3 <exit>
    1a8b:	51                   	push   %ecx
    1a8c:	51                   	push   %ecx
    1a8d:	68 b0 4f 00 00       	push   $0x4fb0
    1a92:	6a 01                	push   $0x1
    1a94:	e8 e7 1f 00 00       	call   3a80 <printf>
    1a99:	e8 35 1e 00 00       	call   38d3 <exit>
    1a9e:	83 ec 04             	sub    $0x4,%esp
    1aa1:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1aa4:	50                   	push   %eax
    1aa5:	68 49 44 00 00       	push   $0x4449
    1aaa:	6a 01                	push   $0x1
    1aac:	e8 cf 1f 00 00       	call   3a80 <printf>
    1ab1:	e8 1d 1e 00 00       	call   38d3 <exit>
    1ab6:	83 ec 04             	sub    $0x4,%esp
    1ab9:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1abc:	50                   	push   %eax
    1abd:	68 30 44 00 00       	push   $0x4430
    1ac2:	6a 01                	push   $0x1
    1ac4:	e8 b7 1f 00 00       	call   3a80 <printf>
    1ac9:	e8 05 1e 00 00       	call   38d3 <exit>
    1ace:	83 ec 0c             	sub    $0xc,%esp
    1ad1:	50                   	push   %eax
    1ad2:	e8 24 1e 00 00       	call   38fb <close>
    1ad7:	83 c4 10             	add    $0x10,%esp
    1ada:	e9 e2 fd ff ff       	jmp    18c1 <concreate+0xe1>
    1adf:	90                   	nop

00001ae0 <linkunlink>:
    1ae0:	55                   	push   %ebp
    1ae1:	89 e5                	mov    %esp,%ebp
    1ae3:	57                   	push   %edi
    1ae4:	56                   	push   %esi
    1ae5:	53                   	push   %ebx
    1ae6:	83 ec 24             	sub    $0x24,%esp
    1ae9:	68 74 44 00 00       	push   $0x4474
    1aee:	6a 01                	push   $0x1
    1af0:	e8 8b 1f 00 00       	call   3a80 <printf>
    1af5:	c7 04 24 01 47 00 00 	movl   $0x4701,(%esp)
    1afc:	e8 22 1e 00 00       	call   3923 <unlink>
    1b01:	e8 c5 1d 00 00       	call   38cb <fork>
    1b06:	83 c4 10             	add    $0x10,%esp
    1b09:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1b0c:	85 c0                	test   %eax,%eax
    1b0e:	0f 88 b6 00 00 00    	js     1bca <linkunlink+0xea>
    1b14:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1b18:	bb 64 00 00 00       	mov    $0x64,%ebx
    1b1d:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
    1b22:	19 ff                	sbb    %edi,%edi
    1b24:	83 e7 60             	and    $0x60,%edi
    1b27:	83 c7 01             	add    $0x1,%edi
    1b2a:	eb 1e                	jmp    1b4a <linkunlink+0x6a>
    1b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1b30:	83 f8 01             	cmp    $0x1,%eax
    1b33:	74 7b                	je     1bb0 <linkunlink+0xd0>
    1b35:	83 ec 0c             	sub    $0xc,%esp
    1b38:	68 01 47 00 00       	push   $0x4701
    1b3d:	e8 e1 1d 00 00       	call   3923 <unlink>
    1b42:	83 c4 10             	add    $0x10,%esp
    1b45:	83 eb 01             	sub    $0x1,%ebx
    1b48:	74 41                	je     1b8b <linkunlink+0xab>
    1b4a:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    1b50:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    1b56:	89 f8                	mov    %edi,%eax
    1b58:	f7 e6                	mul    %esi
    1b5a:	89 d0                	mov    %edx,%eax
    1b5c:	83 e2 fe             	and    $0xfffffffe,%edx
    1b5f:	d1 e8                	shr    %eax
    1b61:	01 c2                	add    %eax,%edx
    1b63:	89 f8                	mov    %edi,%eax
    1b65:	29 d0                	sub    %edx,%eax
    1b67:	75 c7                	jne    1b30 <linkunlink+0x50>
    1b69:	83 ec 08             	sub    $0x8,%esp
    1b6c:	68 02 02 00 00       	push   $0x202
    1b71:	68 01 47 00 00       	push   $0x4701
    1b76:	e8 98 1d 00 00       	call   3913 <open>
    1b7b:	89 04 24             	mov    %eax,(%esp)
    1b7e:	e8 78 1d 00 00       	call   38fb <close>
    1b83:	83 c4 10             	add    $0x10,%esp
    1b86:	83 eb 01             	sub    $0x1,%ebx
    1b89:	75 bf                	jne    1b4a <linkunlink+0x6a>
    1b8b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b8e:	85 c0                	test   %eax,%eax
    1b90:	74 4b                	je     1bdd <linkunlink+0xfd>
    1b92:	e8 44 1d 00 00       	call   38db <wait>
    1b97:	83 ec 08             	sub    $0x8,%esp
    1b9a:	68 89 44 00 00       	push   $0x4489
    1b9f:	6a 01                	push   $0x1
    1ba1:	e8 da 1e 00 00       	call   3a80 <printf>
    1ba6:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1ba9:	5b                   	pop    %ebx
    1baa:	5e                   	pop    %esi
    1bab:	5f                   	pop    %edi
    1bac:	5d                   	pop    %ebp
    1bad:	c3                   	ret    
    1bae:	66 90                	xchg   %ax,%ax
    1bb0:	83 ec 08             	sub    $0x8,%esp
    1bb3:	68 01 47 00 00       	push   $0x4701
    1bb8:	68 85 44 00 00       	push   $0x4485
    1bbd:	e8 71 1d 00 00       	call   3933 <link>
    1bc2:	83 c4 10             	add    $0x10,%esp
    1bc5:	e9 7b ff ff ff       	jmp    1b45 <linkunlink+0x65>
    1bca:	52                   	push   %edx
    1bcb:	52                   	push   %edx
    1bcc:	68 e9 4c 00 00       	push   $0x4ce9
    1bd1:	6a 01                	push   $0x1
    1bd3:	e8 a8 1e 00 00       	call   3a80 <printf>
    1bd8:	e8 f6 1c 00 00       	call   38d3 <exit>
    1bdd:	e8 f1 1c 00 00       	call   38d3 <exit>
    1be2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001bf0 <bigdir>:
    1bf0:	55                   	push   %ebp
    1bf1:	89 e5                	mov    %esp,%ebp
    1bf3:	57                   	push   %edi
    1bf4:	56                   	push   %esi
    1bf5:	53                   	push   %ebx
    1bf6:	83 ec 24             	sub    $0x24,%esp
    1bf9:	68 98 44 00 00       	push   $0x4498
    1bfe:	6a 01                	push   $0x1
    1c00:	e8 7b 1e 00 00       	call   3a80 <printf>
    1c05:	c7 04 24 a5 44 00 00 	movl   $0x44a5,(%esp)
    1c0c:	e8 12 1d 00 00       	call   3923 <unlink>
    1c11:	5a                   	pop    %edx
    1c12:	59                   	pop    %ecx
    1c13:	68 00 02 00 00       	push   $0x200
    1c18:	68 a5 44 00 00       	push   $0x44a5
    1c1d:	e8 f1 1c 00 00       	call   3913 <open>
    1c22:	83 c4 10             	add    $0x10,%esp
    1c25:	85 c0                	test   %eax,%eax
    1c27:	0f 88 de 00 00 00    	js     1d0b <bigdir+0x11b>
    1c2d:	83 ec 0c             	sub    $0xc,%esp
    1c30:	31 f6                	xor    %esi,%esi
    1c32:	8d 7d de             	lea    -0x22(%ebp),%edi
    1c35:	50                   	push   %eax
    1c36:	e8 c0 1c 00 00       	call   38fb <close>
    1c3b:	83 c4 10             	add    $0x10,%esp
    1c3e:	66 90                	xchg   %ax,%ax
    1c40:	89 f0                	mov    %esi,%eax
    1c42:	83 ec 08             	sub    $0x8,%esp
    1c45:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    1c49:	c1 f8 06             	sar    $0x6,%eax
    1c4c:	57                   	push   %edi
    1c4d:	83 c0 30             	add    $0x30,%eax
    1c50:	68 a5 44 00 00       	push   $0x44a5
    1c55:	88 45 df             	mov    %al,-0x21(%ebp)
    1c58:	89 f0                	mov    %esi,%eax
    1c5a:	83 e0 3f             	and    $0x3f,%eax
    1c5d:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    1c61:	83 c0 30             	add    $0x30,%eax
    1c64:	88 45 e0             	mov    %al,-0x20(%ebp)
    1c67:	e8 c7 1c 00 00       	call   3933 <link>
    1c6c:	83 c4 10             	add    $0x10,%esp
    1c6f:	89 c3                	mov    %eax,%ebx
    1c71:	85 c0                	test   %eax,%eax
    1c73:	75 6e                	jne    1ce3 <bigdir+0xf3>
    1c75:	83 c6 01             	add    $0x1,%esi
    1c78:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    1c7e:	75 c0                	jne    1c40 <bigdir+0x50>
    1c80:	83 ec 0c             	sub    $0xc,%esp
    1c83:	68 a5 44 00 00       	push   $0x44a5
    1c88:	e8 96 1c 00 00       	call   3923 <unlink>
    1c8d:	83 c4 10             	add    $0x10,%esp
    1c90:	89 d8                	mov    %ebx,%eax
    1c92:	83 ec 0c             	sub    $0xc,%esp
    1c95:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    1c99:	c1 f8 06             	sar    $0x6,%eax
    1c9c:	57                   	push   %edi
    1c9d:	83 c0 30             	add    $0x30,%eax
    1ca0:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    1ca4:	88 45 df             	mov    %al,-0x21(%ebp)
    1ca7:	89 d8                	mov    %ebx,%eax
    1ca9:	83 e0 3f             	and    $0x3f,%eax
    1cac:	83 c0 30             	add    $0x30,%eax
    1caf:	88 45 e0             	mov    %al,-0x20(%ebp)
    1cb2:	e8 6c 1c 00 00       	call   3923 <unlink>
    1cb7:	83 c4 10             	add    $0x10,%esp
    1cba:	85 c0                	test   %eax,%eax
    1cbc:	75 39                	jne    1cf7 <bigdir+0x107>
    1cbe:	83 c3 01             	add    $0x1,%ebx
    1cc1:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1cc7:	75 c7                	jne    1c90 <bigdir+0xa0>
    1cc9:	83 ec 08             	sub    $0x8,%esp
    1ccc:	68 e7 44 00 00       	push   $0x44e7
    1cd1:	6a 01                	push   $0x1
    1cd3:	e8 a8 1d 00 00       	call   3a80 <printf>
    1cd8:	83 c4 10             	add    $0x10,%esp
    1cdb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1cde:	5b                   	pop    %ebx
    1cdf:	5e                   	pop    %esi
    1ce0:	5f                   	pop    %edi
    1ce1:	5d                   	pop    %ebp
    1ce2:	c3                   	ret    
    1ce3:	83 ec 08             	sub    $0x8,%esp
    1ce6:	68 be 44 00 00       	push   $0x44be
    1ceb:	6a 01                	push   $0x1
    1ced:	e8 8e 1d 00 00       	call   3a80 <printf>
    1cf2:	e8 dc 1b 00 00       	call   38d3 <exit>
    1cf7:	83 ec 08             	sub    $0x8,%esp
    1cfa:	68 d2 44 00 00       	push   $0x44d2
    1cff:	6a 01                	push   $0x1
    1d01:	e8 7a 1d 00 00       	call   3a80 <printf>
    1d06:	e8 c8 1b 00 00       	call   38d3 <exit>
    1d0b:	50                   	push   %eax
    1d0c:	50                   	push   %eax
    1d0d:	68 a8 44 00 00       	push   $0x44a8
    1d12:	6a 01                	push   $0x1
    1d14:	e8 67 1d 00 00       	call   3a80 <printf>
    1d19:	e8 b5 1b 00 00       	call   38d3 <exit>
    1d1e:	66 90                	xchg   %ax,%ax

00001d20 <subdir>:
    1d20:	55                   	push   %ebp
    1d21:	89 e5                	mov    %esp,%ebp
    1d23:	53                   	push   %ebx
    1d24:	83 ec 0c             	sub    $0xc,%esp
    1d27:	68 f2 44 00 00       	push   $0x44f2
    1d2c:	6a 01                	push   $0x1
    1d2e:	e8 4d 1d 00 00       	call   3a80 <printf>
    1d33:	c7 04 24 7b 45 00 00 	movl   $0x457b,(%esp)
    1d3a:	e8 e4 1b 00 00       	call   3923 <unlink>
    1d3f:	c7 04 24 18 46 00 00 	movl   $0x4618,(%esp)
    1d46:	e8 f0 1b 00 00       	call   393b <mkdir>
    1d4b:	83 c4 10             	add    $0x10,%esp
    1d4e:	85 c0                	test   %eax,%eax
    1d50:	0f 85 b3 05 00 00    	jne    2309 <subdir+0x5e9>
    1d56:	83 ec 08             	sub    $0x8,%esp
    1d59:	68 02 02 00 00       	push   $0x202
    1d5e:	68 51 45 00 00       	push   $0x4551
    1d63:	e8 ab 1b 00 00       	call   3913 <open>
    1d68:	83 c4 10             	add    $0x10,%esp
    1d6b:	89 c3                	mov    %eax,%ebx
    1d6d:	85 c0                	test   %eax,%eax
    1d6f:	0f 88 81 05 00 00    	js     22f6 <subdir+0x5d6>
    1d75:	83 ec 04             	sub    $0x4,%esp
    1d78:	6a 02                	push   $0x2
    1d7a:	68 7b 45 00 00       	push   $0x457b
    1d7f:	50                   	push   %eax
    1d80:	e8 6e 1b 00 00       	call   38f3 <write>
    1d85:	89 1c 24             	mov    %ebx,(%esp)
    1d88:	e8 6e 1b 00 00       	call   38fb <close>
    1d8d:	c7 04 24 18 46 00 00 	movl   $0x4618,(%esp)
    1d94:	e8 8a 1b 00 00       	call   3923 <unlink>
    1d99:	83 c4 10             	add    $0x10,%esp
    1d9c:	85 c0                	test   %eax,%eax
    1d9e:	0f 89 3f 05 00 00    	jns    22e3 <subdir+0x5c3>
    1da4:	83 ec 0c             	sub    $0xc,%esp
    1da7:	68 2c 45 00 00       	push   $0x452c
    1dac:	e8 8a 1b 00 00       	call   393b <mkdir>
    1db1:	83 c4 10             	add    $0x10,%esp
    1db4:	85 c0                	test   %eax,%eax
    1db6:	0f 85 14 05 00 00    	jne    22d0 <subdir+0x5b0>
    1dbc:	83 ec 08             	sub    $0x8,%esp
    1dbf:	68 02 02 00 00       	push   $0x202
    1dc4:	68 4e 45 00 00       	push   $0x454e
    1dc9:	e8 45 1b 00 00       	call   3913 <open>
    1dce:	83 c4 10             	add    $0x10,%esp
    1dd1:	89 c3                	mov    %eax,%ebx
    1dd3:	85 c0                	test   %eax,%eax
    1dd5:	0f 88 24 04 00 00    	js     21ff <subdir+0x4df>
    1ddb:	83 ec 04             	sub    $0x4,%esp
    1dde:	6a 02                	push   $0x2
    1de0:	68 6f 45 00 00       	push   $0x456f
    1de5:	50                   	push   %eax
    1de6:	e8 08 1b 00 00       	call   38f3 <write>
    1deb:	89 1c 24             	mov    %ebx,(%esp)
    1dee:	e8 08 1b 00 00       	call   38fb <close>
    1df3:	58                   	pop    %eax
    1df4:	5a                   	pop    %edx
    1df5:	6a 00                	push   $0x0
    1df7:	68 72 45 00 00       	push   $0x4572
    1dfc:	e8 12 1b 00 00       	call   3913 <open>
    1e01:	83 c4 10             	add    $0x10,%esp
    1e04:	89 c3                	mov    %eax,%ebx
    1e06:	85 c0                	test   %eax,%eax
    1e08:	0f 88 de 03 00 00    	js     21ec <subdir+0x4cc>
    1e0e:	83 ec 04             	sub    $0x4,%esp
    1e11:	68 00 20 00 00       	push   $0x2000
    1e16:	68 e0 85 00 00       	push   $0x85e0
    1e1b:	50                   	push   %eax
    1e1c:	e8 ca 1a 00 00       	call   38eb <read>
    1e21:	83 c4 10             	add    $0x10,%esp
    1e24:	83 f8 02             	cmp    $0x2,%eax
    1e27:	0f 85 3a 03 00 00    	jne    2167 <subdir+0x447>
    1e2d:	80 3d e0 85 00 00 66 	cmpb   $0x66,0x85e0
    1e34:	0f 85 2d 03 00 00    	jne    2167 <subdir+0x447>
    1e3a:	83 ec 0c             	sub    $0xc,%esp
    1e3d:	53                   	push   %ebx
    1e3e:	e8 b8 1a 00 00       	call   38fb <close>
    1e43:	59                   	pop    %ecx
    1e44:	5b                   	pop    %ebx
    1e45:	68 b2 45 00 00       	push   $0x45b2
    1e4a:	68 4e 45 00 00       	push   $0x454e
    1e4f:	e8 df 1a 00 00       	call   3933 <link>
    1e54:	83 c4 10             	add    $0x10,%esp
    1e57:	85 c0                	test   %eax,%eax
    1e59:	0f 85 c6 03 00 00    	jne    2225 <subdir+0x505>
    1e5f:	83 ec 0c             	sub    $0xc,%esp
    1e62:	68 4e 45 00 00       	push   $0x454e
    1e67:	e8 b7 1a 00 00       	call   3923 <unlink>
    1e6c:	83 c4 10             	add    $0x10,%esp
    1e6f:	85 c0                	test   %eax,%eax
    1e71:	0f 85 16 03 00 00    	jne    218d <subdir+0x46d>
    1e77:	83 ec 08             	sub    $0x8,%esp
    1e7a:	6a 00                	push   $0x0
    1e7c:	68 4e 45 00 00       	push   $0x454e
    1e81:	e8 8d 1a 00 00       	call   3913 <open>
    1e86:	83 c4 10             	add    $0x10,%esp
    1e89:	85 c0                	test   %eax,%eax
    1e8b:	0f 89 2c 04 00 00    	jns    22bd <subdir+0x59d>
    1e91:	83 ec 0c             	sub    $0xc,%esp
    1e94:	68 18 46 00 00       	push   $0x4618
    1e99:	e8 a5 1a 00 00       	call   3943 <chdir>
    1e9e:	83 c4 10             	add    $0x10,%esp
    1ea1:	85 c0                	test   %eax,%eax
    1ea3:	0f 85 01 04 00 00    	jne    22aa <subdir+0x58a>
    1ea9:	83 ec 0c             	sub    $0xc,%esp
    1eac:	68 e6 45 00 00       	push   $0x45e6
    1eb1:	e8 8d 1a 00 00       	call   3943 <chdir>
    1eb6:	83 c4 10             	add    $0x10,%esp
    1eb9:	85 c0                	test   %eax,%eax
    1ebb:	0f 85 b9 02 00 00    	jne    217a <subdir+0x45a>
    1ec1:	83 ec 0c             	sub    $0xc,%esp
    1ec4:	68 0c 46 00 00       	push   $0x460c
    1ec9:	e8 75 1a 00 00       	call   3943 <chdir>
    1ece:	83 c4 10             	add    $0x10,%esp
    1ed1:	85 c0                	test   %eax,%eax
    1ed3:	0f 85 a1 02 00 00    	jne    217a <subdir+0x45a>
    1ed9:	83 ec 0c             	sub    $0xc,%esp
    1edc:	68 1b 46 00 00       	push   $0x461b
    1ee1:	e8 5d 1a 00 00       	call   3943 <chdir>
    1ee6:	83 c4 10             	add    $0x10,%esp
    1ee9:	85 c0                	test   %eax,%eax
    1eeb:	0f 85 21 03 00 00    	jne    2212 <subdir+0x4f2>
    1ef1:	83 ec 08             	sub    $0x8,%esp
    1ef4:	6a 00                	push   $0x0
    1ef6:	68 b2 45 00 00       	push   $0x45b2
    1efb:	e8 13 1a 00 00       	call   3913 <open>
    1f00:	83 c4 10             	add    $0x10,%esp
    1f03:	89 c3                	mov    %eax,%ebx
    1f05:	85 c0                	test   %eax,%eax
    1f07:	0f 88 e0 04 00 00    	js     23ed <subdir+0x6cd>
    1f0d:	83 ec 04             	sub    $0x4,%esp
    1f10:	68 00 20 00 00       	push   $0x2000
    1f15:	68 e0 85 00 00       	push   $0x85e0
    1f1a:	50                   	push   %eax
    1f1b:	e8 cb 19 00 00       	call   38eb <read>
    1f20:	83 c4 10             	add    $0x10,%esp
    1f23:	83 f8 02             	cmp    $0x2,%eax
    1f26:	0f 85 ae 04 00 00    	jne    23da <subdir+0x6ba>
    1f2c:	83 ec 0c             	sub    $0xc,%esp
    1f2f:	53                   	push   %ebx
    1f30:	e8 c6 19 00 00       	call   38fb <close>
    1f35:	58                   	pop    %eax
    1f36:	5a                   	pop    %edx
    1f37:	6a 00                	push   $0x0
    1f39:	68 4e 45 00 00       	push   $0x454e
    1f3e:	e8 d0 19 00 00       	call   3913 <open>
    1f43:	83 c4 10             	add    $0x10,%esp
    1f46:	85 c0                	test   %eax,%eax
    1f48:	0f 89 65 02 00 00    	jns    21b3 <subdir+0x493>
    1f4e:	83 ec 08             	sub    $0x8,%esp
    1f51:	68 02 02 00 00       	push   $0x202
    1f56:	68 66 46 00 00       	push   $0x4666
    1f5b:	e8 b3 19 00 00       	call   3913 <open>
    1f60:	83 c4 10             	add    $0x10,%esp
    1f63:	85 c0                	test   %eax,%eax
    1f65:	0f 89 35 02 00 00    	jns    21a0 <subdir+0x480>
    1f6b:	83 ec 08             	sub    $0x8,%esp
    1f6e:	68 02 02 00 00       	push   $0x202
    1f73:	68 8b 46 00 00       	push   $0x468b
    1f78:	e8 96 19 00 00       	call   3913 <open>
    1f7d:	83 c4 10             	add    $0x10,%esp
    1f80:	85 c0                	test   %eax,%eax
    1f82:	0f 89 0f 03 00 00    	jns    2297 <subdir+0x577>
    1f88:	83 ec 08             	sub    $0x8,%esp
    1f8b:	68 00 02 00 00       	push   $0x200
    1f90:	68 18 46 00 00       	push   $0x4618
    1f95:	e8 79 19 00 00       	call   3913 <open>
    1f9a:	83 c4 10             	add    $0x10,%esp
    1f9d:	85 c0                	test   %eax,%eax
    1f9f:	0f 89 df 02 00 00    	jns    2284 <subdir+0x564>
    1fa5:	83 ec 08             	sub    $0x8,%esp
    1fa8:	6a 02                	push   $0x2
    1faa:	68 18 46 00 00       	push   $0x4618
    1faf:	e8 5f 19 00 00       	call   3913 <open>
    1fb4:	83 c4 10             	add    $0x10,%esp
    1fb7:	85 c0                	test   %eax,%eax
    1fb9:	0f 89 b2 02 00 00    	jns    2271 <subdir+0x551>
    1fbf:	83 ec 08             	sub    $0x8,%esp
    1fc2:	6a 01                	push   $0x1
    1fc4:	68 18 46 00 00       	push   $0x4618
    1fc9:	e8 45 19 00 00       	call   3913 <open>
    1fce:	83 c4 10             	add    $0x10,%esp
    1fd1:	85 c0                	test   %eax,%eax
    1fd3:	0f 89 85 02 00 00    	jns    225e <subdir+0x53e>
    1fd9:	83 ec 08             	sub    $0x8,%esp
    1fdc:	68 fa 46 00 00       	push   $0x46fa
    1fe1:	68 66 46 00 00       	push   $0x4666
    1fe6:	e8 48 19 00 00       	call   3933 <link>
    1feb:	83 c4 10             	add    $0x10,%esp
    1fee:	85 c0                	test   %eax,%eax
    1ff0:	0f 84 55 02 00 00    	je     224b <subdir+0x52b>
    1ff6:	83 ec 08             	sub    $0x8,%esp
    1ff9:	68 fa 46 00 00       	push   $0x46fa
    1ffe:	68 8b 46 00 00       	push   $0x468b
    2003:	e8 2b 19 00 00       	call   3933 <link>
    2008:	83 c4 10             	add    $0x10,%esp
    200b:	85 c0                	test   %eax,%eax
    200d:	0f 84 25 02 00 00    	je     2238 <subdir+0x518>
    2013:	83 ec 08             	sub    $0x8,%esp
    2016:	68 b2 45 00 00       	push   $0x45b2
    201b:	68 51 45 00 00       	push   $0x4551
    2020:	e8 0e 19 00 00       	call   3933 <link>
    2025:	83 c4 10             	add    $0x10,%esp
    2028:	85 c0                	test   %eax,%eax
    202a:	0f 84 a9 01 00 00    	je     21d9 <subdir+0x4b9>
    2030:	83 ec 0c             	sub    $0xc,%esp
    2033:	68 66 46 00 00       	push   $0x4666
    2038:	e8 fe 18 00 00       	call   393b <mkdir>
    203d:	83 c4 10             	add    $0x10,%esp
    2040:	85 c0                	test   %eax,%eax
    2042:	0f 84 7e 01 00 00    	je     21c6 <subdir+0x4a6>
    2048:	83 ec 0c             	sub    $0xc,%esp
    204b:	68 8b 46 00 00       	push   $0x468b
    2050:	e8 e6 18 00 00       	call   393b <mkdir>
    2055:	83 c4 10             	add    $0x10,%esp
    2058:	85 c0                	test   %eax,%eax
    205a:	0f 84 67 03 00 00    	je     23c7 <subdir+0x6a7>
    2060:	83 ec 0c             	sub    $0xc,%esp
    2063:	68 b2 45 00 00       	push   $0x45b2
    2068:	e8 ce 18 00 00       	call   393b <mkdir>
    206d:	83 c4 10             	add    $0x10,%esp
    2070:	85 c0                	test   %eax,%eax
    2072:	0f 84 3c 03 00 00    	je     23b4 <subdir+0x694>
    2078:	83 ec 0c             	sub    $0xc,%esp
    207b:	68 8b 46 00 00       	push   $0x468b
    2080:	e8 9e 18 00 00       	call   3923 <unlink>
    2085:	83 c4 10             	add    $0x10,%esp
    2088:	85 c0                	test   %eax,%eax
    208a:	0f 84 11 03 00 00    	je     23a1 <subdir+0x681>
    2090:	83 ec 0c             	sub    $0xc,%esp
    2093:	68 66 46 00 00       	push   $0x4666
    2098:	e8 86 18 00 00       	call   3923 <unlink>
    209d:	83 c4 10             	add    $0x10,%esp
    20a0:	85 c0                	test   %eax,%eax
    20a2:	0f 84 e6 02 00 00    	je     238e <subdir+0x66e>
    20a8:	83 ec 0c             	sub    $0xc,%esp
    20ab:	68 51 45 00 00       	push   $0x4551
    20b0:	e8 8e 18 00 00       	call   3943 <chdir>
    20b5:	83 c4 10             	add    $0x10,%esp
    20b8:	85 c0                	test   %eax,%eax
    20ba:	0f 84 bb 02 00 00    	je     237b <subdir+0x65b>
    20c0:	83 ec 0c             	sub    $0xc,%esp
    20c3:	68 fd 46 00 00       	push   $0x46fd
    20c8:	e8 76 18 00 00       	call   3943 <chdir>
    20cd:	83 c4 10             	add    $0x10,%esp
    20d0:	85 c0                	test   %eax,%eax
    20d2:	0f 84 90 02 00 00    	je     2368 <subdir+0x648>
    20d8:	83 ec 0c             	sub    $0xc,%esp
    20db:	68 b2 45 00 00       	push   $0x45b2
    20e0:	e8 3e 18 00 00       	call   3923 <unlink>
    20e5:	83 c4 10             	add    $0x10,%esp
    20e8:	85 c0                	test   %eax,%eax
    20ea:	0f 85 9d 00 00 00    	jne    218d <subdir+0x46d>
    20f0:	83 ec 0c             	sub    $0xc,%esp
    20f3:	68 51 45 00 00       	push   $0x4551
    20f8:	e8 26 18 00 00       	call   3923 <unlink>
    20fd:	83 c4 10             	add    $0x10,%esp
    2100:	85 c0                	test   %eax,%eax
    2102:	0f 85 4d 02 00 00    	jne    2355 <subdir+0x635>
    2108:	83 ec 0c             	sub    $0xc,%esp
    210b:	68 18 46 00 00       	push   $0x4618
    2110:	e8 0e 18 00 00       	call   3923 <unlink>
    2115:	83 c4 10             	add    $0x10,%esp
    2118:	85 c0                	test   %eax,%eax
    211a:	0f 84 22 02 00 00    	je     2342 <subdir+0x622>
    2120:	83 ec 0c             	sub    $0xc,%esp
    2123:	68 2d 45 00 00       	push   $0x452d
    2128:	e8 f6 17 00 00       	call   3923 <unlink>
    212d:	83 c4 10             	add    $0x10,%esp
    2130:	85 c0                	test   %eax,%eax
    2132:	0f 88 f7 01 00 00    	js     232f <subdir+0x60f>
    2138:	83 ec 0c             	sub    $0xc,%esp
    213b:	68 18 46 00 00       	push   $0x4618
    2140:	e8 de 17 00 00       	call   3923 <unlink>
    2145:	83 c4 10             	add    $0x10,%esp
    2148:	85 c0                	test   %eax,%eax
    214a:	0f 88 cc 01 00 00    	js     231c <subdir+0x5fc>
    2150:	83 ec 08             	sub    $0x8,%esp
    2153:	68 fa 47 00 00       	push   $0x47fa
    2158:	6a 01                	push   $0x1
    215a:	e8 21 19 00 00       	call   3a80 <printf>
    215f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2162:	83 c4 10             	add    $0x10,%esp
    2165:	c9                   	leave  
    2166:	c3                   	ret    
    2167:	50                   	push   %eax
    2168:	50                   	push   %eax
    2169:	68 97 45 00 00       	push   $0x4597
    216e:	6a 01                	push   $0x1
    2170:	e8 0b 19 00 00       	call   3a80 <printf>
    2175:	e8 59 17 00 00       	call   38d3 <exit>
    217a:	50                   	push   %eax
    217b:	50                   	push   %eax
    217c:	68 f2 45 00 00       	push   $0x45f2
    2181:	6a 01                	push   $0x1
    2183:	e8 f8 18 00 00       	call   3a80 <printf>
    2188:	e8 46 17 00 00       	call   38d3 <exit>
    218d:	50                   	push   %eax
    218e:	50                   	push   %eax
    218f:	68 bd 45 00 00       	push   $0x45bd
    2194:	6a 01                	push   $0x1
    2196:	e8 e5 18 00 00       	call   3a80 <printf>
    219b:	e8 33 17 00 00       	call   38d3 <exit>
    21a0:	51                   	push   %ecx
    21a1:	51                   	push   %ecx
    21a2:	68 6f 46 00 00       	push   $0x466f
    21a7:	6a 01                	push   $0x1
    21a9:	e8 d2 18 00 00       	call   3a80 <printf>
    21ae:	e8 20 17 00 00       	call   38d3 <exit>
    21b3:	53                   	push   %ebx
    21b4:	53                   	push   %ebx
    21b5:	68 54 50 00 00       	push   $0x5054
    21ba:	6a 01                	push   $0x1
    21bc:	e8 bf 18 00 00       	call   3a80 <printf>
    21c1:	e8 0d 17 00 00       	call   38d3 <exit>
    21c6:	51                   	push   %ecx
    21c7:	51                   	push   %ecx
    21c8:	68 03 47 00 00       	push   $0x4703
    21cd:	6a 01                	push   $0x1
    21cf:	e8 ac 18 00 00       	call   3a80 <printf>
    21d4:	e8 fa 16 00 00       	call   38d3 <exit>
    21d9:	53                   	push   %ebx
    21da:	53                   	push   %ebx
    21db:	68 c4 50 00 00       	push   $0x50c4
    21e0:	6a 01                	push   $0x1
    21e2:	e8 99 18 00 00       	call   3a80 <printf>
    21e7:	e8 e7 16 00 00       	call   38d3 <exit>
    21ec:	50                   	push   %eax
    21ed:	50                   	push   %eax
    21ee:	68 7e 45 00 00       	push   $0x457e
    21f3:	6a 01                	push   $0x1
    21f5:	e8 86 18 00 00       	call   3a80 <printf>
    21fa:	e8 d4 16 00 00       	call   38d3 <exit>
    21ff:	51                   	push   %ecx
    2200:	51                   	push   %ecx
    2201:	68 57 45 00 00       	push   $0x4557
    2206:	6a 01                	push   $0x1
    2208:	e8 73 18 00 00       	call   3a80 <printf>
    220d:	e8 c1 16 00 00       	call   38d3 <exit>
    2212:	50                   	push   %eax
    2213:	50                   	push   %eax
    2214:	68 20 46 00 00       	push   $0x4620
    2219:	6a 01                	push   $0x1
    221b:	e8 60 18 00 00       	call   3a80 <printf>
    2220:	e8 ae 16 00 00       	call   38d3 <exit>
    2225:	52                   	push   %edx
    2226:	52                   	push   %edx
    2227:	68 0c 50 00 00       	push   $0x500c
    222c:	6a 01                	push   $0x1
    222e:	e8 4d 18 00 00       	call   3a80 <printf>
    2233:	e8 9b 16 00 00       	call   38d3 <exit>
    2238:	50                   	push   %eax
    2239:	50                   	push   %eax
    223a:	68 a0 50 00 00       	push   $0x50a0
    223f:	6a 01                	push   $0x1
    2241:	e8 3a 18 00 00       	call   3a80 <printf>
    2246:	e8 88 16 00 00       	call   38d3 <exit>
    224b:	50                   	push   %eax
    224c:	50                   	push   %eax
    224d:	68 7c 50 00 00       	push   $0x507c
    2252:	6a 01                	push   $0x1
    2254:	e8 27 18 00 00       	call   3a80 <printf>
    2259:	e8 75 16 00 00       	call   38d3 <exit>
    225e:	50                   	push   %eax
    225f:	50                   	push   %eax
    2260:	68 df 46 00 00       	push   $0x46df
    2265:	6a 01                	push   $0x1
    2267:	e8 14 18 00 00       	call   3a80 <printf>
    226c:	e8 62 16 00 00       	call   38d3 <exit>
    2271:	50                   	push   %eax
    2272:	50                   	push   %eax
    2273:	68 c6 46 00 00       	push   $0x46c6
    2278:	6a 01                	push   $0x1
    227a:	e8 01 18 00 00       	call   3a80 <printf>
    227f:	e8 4f 16 00 00       	call   38d3 <exit>
    2284:	50                   	push   %eax
    2285:	50                   	push   %eax
    2286:	68 b0 46 00 00       	push   $0x46b0
    228b:	6a 01                	push   $0x1
    228d:	e8 ee 17 00 00       	call   3a80 <printf>
    2292:	e8 3c 16 00 00       	call   38d3 <exit>
    2297:	52                   	push   %edx
    2298:	52                   	push   %edx
    2299:	68 94 46 00 00       	push   $0x4694
    229e:	6a 01                	push   $0x1
    22a0:	e8 db 17 00 00       	call   3a80 <printf>
    22a5:	e8 29 16 00 00       	call   38d3 <exit>
    22aa:	50                   	push   %eax
    22ab:	50                   	push   %eax
    22ac:	68 d5 45 00 00       	push   $0x45d5
    22b1:	6a 01                	push   $0x1
    22b3:	e8 c8 17 00 00       	call   3a80 <printf>
    22b8:	e8 16 16 00 00       	call   38d3 <exit>
    22bd:	50                   	push   %eax
    22be:	50                   	push   %eax
    22bf:	68 30 50 00 00       	push   $0x5030
    22c4:	6a 01                	push   $0x1
    22c6:	e8 b5 17 00 00       	call   3a80 <printf>
    22cb:	e8 03 16 00 00       	call   38d3 <exit>
    22d0:	53                   	push   %ebx
    22d1:	53                   	push   %ebx
    22d2:	68 33 45 00 00       	push   $0x4533
    22d7:	6a 01                	push   $0x1
    22d9:	e8 a2 17 00 00       	call   3a80 <printf>
    22de:	e8 f0 15 00 00       	call   38d3 <exit>
    22e3:	50                   	push   %eax
    22e4:	50                   	push   %eax
    22e5:	68 e4 4f 00 00       	push   $0x4fe4
    22ea:	6a 01                	push   $0x1
    22ec:	e8 8f 17 00 00       	call   3a80 <printf>
    22f1:	e8 dd 15 00 00       	call   38d3 <exit>
    22f6:	50                   	push   %eax
    22f7:	50                   	push   %eax
    22f8:	68 17 45 00 00       	push   $0x4517
    22fd:	6a 01                	push   $0x1
    22ff:	e8 7c 17 00 00       	call   3a80 <printf>
    2304:	e8 ca 15 00 00       	call   38d3 <exit>
    2309:	50                   	push   %eax
    230a:	50                   	push   %eax
    230b:	68 ff 44 00 00       	push   $0x44ff
    2310:	6a 01                	push   $0x1
    2312:	e8 69 17 00 00       	call   3a80 <printf>
    2317:	e8 b7 15 00 00       	call   38d3 <exit>
    231c:	50                   	push   %eax
    231d:	50                   	push   %eax
    231e:	68 e8 47 00 00       	push   $0x47e8
    2323:	6a 01                	push   $0x1
    2325:	e8 56 17 00 00       	call   3a80 <printf>
    232a:	e8 a4 15 00 00       	call   38d3 <exit>
    232f:	52                   	push   %edx
    2330:	52                   	push   %edx
    2331:	68 d3 47 00 00       	push   $0x47d3
    2336:	6a 01                	push   $0x1
    2338:	e8 43 17 00 00       	call   3a80 <printf>
    233d:	e8 91 15 00 00       	call   38d3 <exit>
    2342:	51                   	push   %ecx
    2343:	51                   	push   %ecx
    2344:	68 e8 50 00 00       	push   $0x50e8
    2349:	6a 01                	push   $0x1
    234b:	e8 30 17 00 00       	call   3a80 <printf>
    2350:	e8 7e 15 00 00       	call   38d3 <exit>
    2355:	53                   	push   %ebx
    2356:	53                   	push   %ebx
    2357:	68 be 47 00 00       	push   $0x47be
    235c:	6a 01                	push   $0x1
    235e:	e8 1d 17 00 00       	call   3a80 <printf>
    2363:	e8 6b 15 00 00       	call   38d3 <exit>
    2368:	50                   	push   %eax
    2369:	50                   	push   %eax
    236a:	68 a6 47 00 00       	push   $0x47a6
    236f:	6a 01                	push   $0x1
    2371:	e8 0a 17 00 00       	call   3a80 <printf>
    2376:	e8 58 15 00 00       	call   38d3 <exit>
    237b:	50                   	push   %eax
    237c:	50                   	push   %eax
    237d:	68 8e 47 00 00       	push   $0x478e
    2382:	6a 01                	push   $0x1
    2384:	e8 f7 16 00 00       	call   3a80 <printf>
    2389:	e8 45 15 00 00       	call   38d3 <exit>
    238e:	50                   	push   %eax
    238f:	50                   	push   %eax
    2390:	68 72 47 00 00       	push   $0x4772
    2395:	6a 01                	push   $0x1
    2397:	e8 e4 16 00 00       	call   3a80 <printf>
    239c:	e8 32 15 00 00       	call   38d3 <exit>
    23a1:	50                   	push   %eax
    23a2:	50                   	push   %eax
    23a3:	68 56 47 00 00       	push   $0x4756
    23a8:	6a 01                	push   $0x1
    23aa:	e8 d1 16 00 00       	call   3a80 <printf>
    23af:	e8 1f 15 00 00       	call   38d3 <exit>
    23b4:	50                   	push   %eax
    23b5:	50                   	push   %eax
    23b6:	68 39 47 00 00       	push   $0x4739
    23bb:	6a 01                	push   $0x1
    23bd:	e8 be 16 00 00       	call   3a80 <printf>
    23c2:	e8 0c 15 00 00       	call   38d3 <exit>
    23c7:	52                   	push   %edx
    23c8:	52                   	push   %edx
    23c9:	68 1e 47 00 00       	push   $0x471e
    23ce:	6a 01                	push   $0x1
    23d0:	e8 ab 16 00 00       	call   3a80 <printf>
    23d5:	e8 f9 14 00 00       	call   38d3 <exit>
    23da:	51                   	push   %ecx
    23db:	51                   	push   %ecx
    23dc:	68 4b 46 00 00       	push   $0x464b
    23e1:	6a 01                	push   $0x1
    23e3:	e8 98 16 00 00       	call   3a80 <printf>
    23e8:	e8 e6 14 00 00       	call   38d3 <exit>
    23ed:	53                   	push   %ebx
    23ee:	53                   	push   %ebx
    23ef:	68 33 46 00 00       	push   $0x4633
    23f4:	6a 01                	push   $0x1
    23f6:	e8 85 16 00 00       	call   3a80 <printf>
    23fb:	e8 d3 14 00 00       	call   38d3 <exit>

00002400 <bigwrite>:
    2400:	55                   	push   %ebp
    2401:	89 e5                	mov    %esp,%ebp
    2403:	56                   	push   %esi
    2404:	53                   	push   %ebx
    2405:	bb f3 01 00 00       	mov    $0x1f3,%ebx
    240a:	83 ec 08             	sub    $0x8,%esp
    240d:	68 05 48 00 00       	push   $0x4805
    2412:	6a 01                	push   $0x1
    2414:	e8 67 16 00 00       	call   3a80 <printf>
    2419:	c7 04 24 14 48 00 00 	movl   $0x4814,(%esp)
    2420:	e8 fe 14 00 00       	call   3923 <unlink>
    2425:	83 c4 10             	add    $0x10,%esp
    2428:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    242f:	90                   	nop
    2430:	83 ec 08             	sub    $0x8,%esp
    2433:	68 02 02 00 00       	push   $0x202
    2438:	68 14 48 00 00       	push   $0x4814
    243d:	e8 d1 14 00 00       	call   3913 <open>
    2442:	83 c4 10             	add    $0x10,%esp
    2445:	89 c6                	mov    %eax,%esi
    2447:	85 c0                	test   %eax,%eax
    2449:	78 7e                	js     24c9 <bigwrite+0xc9>
    244b:	83 ec 04             	sub    $0x4,%esp
    244e:	53                   	push   %ebx
    244f:	68 e0 85 00 00       	push   $0x85e0
    2454:	50                   	push   %eax
    2455:	e8 99 14 00 00       	call   38f3 <write>
    245a:	83 c4 10             	add    $0x10,%esp
    245d:	39 d8                	cmp    %ebx,%eax
    245f:	75 55                	jne    24b6 <bigwrite+0xb6>
    2461:	83 ec 04             	sub    $0x4,%esp
    2464:	53                   	push   %ebx
    2465:	68 e0 85 00 00       	push   $0x85e0
    246a:	56                   	push   %esi
    246b:	e8 83 14 00 00       	call   38f3 <write>
    2470:	83 c4 10             	add    $0x10,%esp
    2473:	39 d8                	cmp    %ebx,%eax
    2475:	75 3f                	jne    24b6 <bigwrite+0xb6>
    2477:	83 ec 0c             	sub    $0xc,%esp
    247a:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    2480:	56                   	push   %esi
    2481:	e8 75 14 00 00       	call   38fb <close>
    2486:	c7 04 24 14 48 00 00 	movl   $0x4814,(%esp)
    248d:	e8 91 14 00 00       	call   3923 <unlink>
    2492:	83 c4 10             	add    $0x10,%esp
    2495:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    249b:	75 93                	jne    2430 <bigwrite+0x30>
    249d:	83 ec 08             	sub    $0x8,%esp
    24a0:	68 47 48 00 00       	push   $0x4847
    24a5:	6a 01                	push   $0x1
    24a7:	e8 d4 15 00 00       	call   3a80 <printf>
    24ac:	83 c4 10             	add    $0x10,%esp
    24af:	8d 65 f8             	lea    -0x8(%ebp),%esp
    24b2:	5b                   	pop    %ebx
    24b3:	5e                   	pop    %esi
    24b4:	5d                   	pop    %ebp
    24b5:	c3                   	ret    
    24b6:	50                   	push   %eax
    24b7:	53                   	push   %ebx
    24b8:	68 35 48 00 00       	push   $0x4835
    24bd:	6a 01                	push   $0x1
    24bf:	e8 bc 15 00 00       	call   3a80 <printf>
    24c4:	e8 0a 14 00 00       	call   38d3 <exit>
    24c9:	83 ec 08             	sub    $0x8,%esp
    24cc:	68 1d 48 00 00       	push   $0x481d
    24d1:	6a 01                	push   $0x1
    24d3:	e8 a8 15 00 00       	call   3a80 <printf>
    24d8:	e8 f6 13 00 00       	call   38d3 <exit>
    24dd:	8d 76 00             	lea    0x0(%esi),%esi

000024e0 <bigfile>:
    24e0:	55                   	push   %ebp
    24e1:	89 e5                	mov    %esp,%ebp
    24e3:	57                   	push   %edi
    24e4:	56                   	push   %esi
    24e5:	53                   	push   %ebx
    24e6:	83 ec 14             	sub    $0x14,%esp
    24e9:	68 54 48 00 00       	push   $0x4854
    24ee:	6a 01                	push   $0x1
    24f0:	e8 8b 15 00 00       	call   3a80 <printf>
    24f5:	c7 04 24 70 48 00 00 	movl   $0x4870,(%esp)
    24fc:	e8 22 14 00 00       	call   3923 <unlink>
    2501:	58                   	pop    %eax
    2502:	5a                   	pop    %edx
    2503:	68 02 02 00 00       	push   $0x202
    2508:	68 70 48 00 00       	push   $0x4870
    250d:	e8 01 14 00 00       	call   3913 <open>
    2512:	83 c4 10             	add    $0x10,%esp
    2515:	85 c0                	test   %eax,%eax
    2517:	0f 88 5e 01 00 00    	js     267b <bigfile+0x19b>
    251d:	89 c6                	mov    %eax,%esi
    251f:	31 db                	xor    %ebx,%ebx
    2521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2528:	83 ec 04             	sub    $0x4,%esp
    252b:	68 58 02 00 00       	push   $0x258
    2530:	53                   	push   %ebx
    2531:	68 e0 85 00 00       	push   $0x85e0
    2536:	e8 05 12 00 00       	call   3740 <memset>
    253b:	83 c4 0c             	add    $0xc,%esp
    253e:	68 58 02 00 00       	push   $0x258
    2543:	68 e0 85 00 00       	push   $0x85e0
    2548:	56                   	push   %esi
    2549:	e8 a5 13 00 00       	call   38f3 <write>
    254e:	83 c4 10             	add    $0x10,%esp
    2551:	3d 58 02 00 00       	cmp    $0x258,%eax
    2556:	0f 85 f8 00 00 00    	jne    2654 <bigfile+0x174>
    255c:	83 c3 01             	add    $0x1,%ebx
    255f:	83 fb 14             	cmp    $0x14,%ebx
    2562:	75 c4                	jne    2528 <bigfile+0x48>
    2564:	83 ec 0c             	sub    $0xc,%esp
    2567:	56                   	push   %esi
    2568:	e8 8e 13 00 00       	call   38fb <close>
    256d:	5e                   	pop    %esi
    256e:	5f                   	pop    %edi
    256f:	6a 00                	push   $0x0
    2571:	68 70 48 00 00       	push   $0x4870
    2576:	e8 98 13 00 00       	call   3913 <open>
    257b:	83 c4 10             	add    $0x10,%esp
    257e:	89 c6                	mov    %eax,%esi
    2580:	85 c0                	test   %eax,%eax
    2582:	0f 88 e0 00 00 00    	js     2668 <bigfile+0x188>
    2588:	31 db                	xor    %ebx,%ebx
    258a:	31 ff                	xor    %edi,%edi
    258c:	eb 30                	jmp    25be <bigfile+0xde>
    258e:	66 90                	xchg   %ax,%ax
    2590:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2595:	0f 85 91 00 00 00    	jne    262c <bigfile+0x14c>
    259b:	89 fa                	mov    %edi,%edx
    259d:	0f be 05 e0 85 00 00 	movsbl 0x85e0,%eax
    25a4:	d1 fa                	sar    %edx
    25a6:	39 d0                	cmp    %edx,%eax
    25a8:	75 6e                	jne    2618 <bigfile+0x138>
    25aa:	0f be 15 0b 87 00 00 	movsbl 0x870b,%edx
    25b1:	39 d0                	cmp    %edx,%eax
    25b3:	75 63                	jne    2618 <bigfile+0x138>
    25b5:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
    25bb:	83 c7 01             	add    $0x1,%edi
    25be:	83 ec 04             	sub    $0x4,%esp
    25c1:	68 2c 01 00 00       	push   $0x12c
    25c6:	68 e0 85 00 00       	push   $0x85e0
    25cb:	56                   	push   %esi
    25cc:	e8 1a 13 00 00       	call   38eb <read>
    25d1:	83 c4 10             	add    $0x10,%esp
    25d4:	85 c0                	test   %eax,%eax
    25d6:	78 68                	js     2640 <bigfile+0x160>
    25d8:	75 b6                	jne    2590 <bigfile+0xb0>
    25da:	83 ec 0c             	sub    $0xc,%esp
    25dd:	56                   	push   %esi
    25de:	e8 18 13 00 00       	call   38fb <close>
    25e3:	83 c4 10             	add    $0x10,%esp
    25e6:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    25ec:	0f 85 9c 00 00 00    	jne    268e <bigfile+0x1ae>
    25f2:	83 ec 0c             	sub    $0xc,%esp
    25f5:	68 70 48 00 00       	push   $0x4870
    25fa:	e8 24 13 00 00       	call   3923 <unlink>
    25ff:	58                   	pop    %eax
    2600:	5a                   	pop    %edx
    2601:	68 ff 48 00 00       	push   $0x48ff
    2606:	6a 01                	push   $0x1
    2608:	e8 73 14 00 00       	call   3a80 <printf>
    260d:	83 c4 10             	add    $0x10,%esp
    2610:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2613:	5b                   	pop    %ebx
    2614:	5e                   	pop    %esi
    2615:	5f                   	pop    %edi
    2616:	5d                   	pop    %ebp
    2617:	c3                   	ret    
    2618:	83 ec 08             	sub    $0x8,%esp
    261b:	68 cc 48 00 00       	push   $0x48cc
    2620:	6a 01                	push   $0x1
    2622:	e8 59 14 00 00       	call   3a80 <printf>
    2627:	e8 a7 12 00 00       	call   38d3 <exit>
    262c:	83 ec 08             	sub    $0x8,%esp
    262f:	68 b8 48 00 00       	push   $0x48b8
    2634:	6a 01                	push   $0x1
    2636:	e8 45 14 00 00       	call   3a80 <printf>
    263b:	e8 93 12 00 00       	call   38d3 <exit>
    2640:	83 ec 08             	sub    $0x8,%esp
    2643:	68 a3 48 00 00       	push   $0x48a3
    2648:	6a 01                	push   $0x1
    264a:	e8 31 14 00 00       	call   3a80 <printf>
    264f:	e8 7f 12 00 00       	call   38d3 <exit>
    2654:	83 ec 08             	sub    $0x8,%esp
    2657:	68 78 48 00 00       	push   $0x4878
    265c:	6a 01                	push   $0x1
    265e:	e8 1d 14 00 00       	call   3a80 <printf>
    2663:	e8 6b 12 00 00       	call   38d3 <exit>
    2668:	53                   	push   %ebx
    2669:	53                   	push   %ebx
    266a:	68 8e 48 00 00       	push   $0x488e
    266f:	6a 01                	push   $0x1
    2671:	e8 0a 14 00 00       	call   3a80 <printf>
    2676:	e8 58 12 00 00       	call   38d3 <exit>
    267b:	50                   	push   %eax
    267c:	50                   	push   %eax
    267d:	68 62 48 00 00       	push   $0x4862
    2682:	6a 01                	push   $0x1
    2684:	e8 f7 13 00 00       	call   3a80 <printf>
    2689:	e8 45 12 00 00       	call   38d3 <exit>
    268e:	51                   	push   %ecx
    268f:	51                   	push   %ecx
    2690:	68 e5 48 00 00       	push   $0x48e5
    2695:	6a 01                	push   $0x1
    2697:	e8 e4 13 00 00       	call   3a80 <printf>
    269c:	e8 32 12 00 00       	call   38d3 <exit>
    26a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    26a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    26af:	90                   	nop

000026b0 <fourteen>:
    26b0:	55                   	push   %ebp
    26b1:	89 e5                	mov    %esp,%ebp
    26b3:	83 ec 10             	sub    $0x10,%esp
    26b6:	68 10 49 00 00       	push   $0x4910
    26bb:	6a 01                	push   $0x1
    26bd:	e8 be 13 00 00       	call   3a80 <printf>
    26c2:	c7 04 24 4b 49 00 00 	movl   $0x494b,(%esp)
    26c9:	e8 6d 12 00 00       	call   393b <mkdir>
    26ce:	83 c4 10             	add    $0x10,%esp
    26d1:	85 c0                	test   %eax,%eax
    26d3:	0f 85 97 00 00 00    	jne    2770 <fourteen+0xc0>
    26d9:	83 ec 0c             	sub    $0xc,%esp
    26dc:	68 08 51 00 00       	push   $0x5108
    26e1:	e8 55 12 00 00       	call   393b <mkdir>
    26e6:	83 c4 10             	add    $0x10,%esp
    26e9:	85 c0                	test   %eax,%eax
    26eb:	0f 85 de 00 00 00    	jne    27cf <fourteen+0x11f>
    26f1:	83 ec 08             	sub    $0x8,%esp
    26f4:	68 00 02 00 00       	push   $0x200
    26f9:	68 58 51 00 00       	push   $0x5158
    26fe:	e8 10 12 00 00       	call   3913 <open>
    2703:	83 c4 10             	add    $0x10,%esp
    2706:	85 c0                	test   %eax,%eax
    2708:	0f 88 ae 00 00 00    	js     27bc <fourteen+0x10c>
    270e:	83 ec 0c             	sub    $0xc,%esp
    2711:	50                   	push   %eax
    2712:	e8 e4 11 00 00       	call   38fb <close>
    2717:	58                   	pop    %eax
    2718:	5a                   	pop    %edx
    2719:	6a 00                	push   $0x0
    271b:	68 c8 51 00 00       	push   $0x51c8
    2720:	e8 ee 11 00 00       	call   3913 <open>
    2725:	83 c4 10             	add    $0x10,%esp
    2728:	85 c0                	test   %eax,%eax
    272a:	78 7d                	js     27a9 <fourteen+0xf9>
    272c:	83 ec 0c             	sub    $0xc,%esp
    272f:	50                   	push   %eax
    2730:	e8 c6 11 00 00       	call   38fb <close>
    2735:	c7 04 24 3c 49 00 00 	movl   $0x493c,(%esp)
    273c:	e8 fa 11 00 00       	call   393b <mkdir>
    2741:	83 c4 10             	add    $0x10,%esp
    2744:	85 c0                	test   %eax,%eax
    2746:	74 4e                	je     2796 <fourteen+0xe6>
    2748:	83 ec 0c             	sub    $0xc,%esp
    274b:	68 64 52 00 00       	push   $0x5264
    2750:	e8 e6 11 00 00       	call   393b <mkdir>
    2755:	83 c4 10             	add    $0x10,%esp
    2758:	85 c0                	test   %eax,%eax
    275a:	74 27                	je     2783 <fourteen+0xd3>
    275c:	83 ec 08             	sub    $0x8,%esp
    275f:	68 5a 49 00 00       	push   $0x495a
    2764:	6a 01                	push   $0x1
    2766:	e8 15 13 00 00       	call   3a80 <printf>
    276b:	83 c4 10             	add    $0x10,%esp
    276e:	c9                   	leave  
    276f:	c3                   	ret    
    2770:	50                   	push   %eax
    2771:	50                   	push   %eax
    2772:	68 1f 49 00 00       	push   $0x491f
    2777:	6a 01                	push   $0x1
    2779:	e8 02 13 00 00       	call   3a80 <printf>
    277e:	e8 50 11 00 00       	call   38d3 <exit>
    2783:	50                   	push   %eax
    2784:	50                   	push   %eax
    2785:	68 84 52 00 00       	push   $0x5284
    278a:	6a 01                	push   $0x1
    278c:	e8 ef 12 00 00       	call   3a80 <printf>
    2791:	e8 3d 11 00 00       	call   38d3 <exit>
    2796:	52                   	push   %edx
    2797:	52                   	push   %edx
    2798:	68 34 52 00 00       	push   $0x5234
    279d:	6a 01                	push   $0x1
    279f:	e8 dc 12 00 00       	call   3a80 <printf>
    27a4:	e8 2a 11 00 00       	call   38d3 <exit>
    27a9:	51                   	push   %ecx
    27aa:	51                   	push   %ecx
    27ab:	68 f8 51 00 00       	push   $0x51f8
    27b0:	6a 01                	push   $0x1
    27b2:	e8 c9 12 00 00       	call   3a80 <printf>
    27b7:	e8 17 11 00 00       	call   38d3 <exit>
    27bc:	51                   	push   %ecx
    27bd:	51                   	push   %ecx
    27be:	68 88 51 00 00       	push   $0x5188
    27c3:	6a 01                	push   $0x1
    27c5:	e8 b6 12 00 00       	call   3a80 <printf>
    27ca:	e8 04 11 00 00       	call   38d3 <exit>
    27cf:	50                   	push   %eax
    27d0:	50                   	push   %eax
    27d1:	68 28 51 00 00       	push   $0x5128
    27d6:	6a 01                	push   $0x1
    27d8:	e8 a3 12 00 00       	call   3a80 <printf>
    27dd:	e8 f1 10 00 00       	call   38d3 <exit>
    27e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    27e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000027f0 <rmdot>:
    27f0:	55                   	push   %ebp
    27f1:	89 e5                	mov    %esp,%ebp
    27f3:	83 ec 10             	sub    $0x10,%esp
    27f6:	68 67 49 00 00       	push   $0x4967
    27fb:	6a 01                	push   $0x1
    27fd:	e8 7e 12 00 00       	call   3a80 <printf>
    2802:	c7 04 24 73 49 00 00 	movl   $0x4973,(%esp)
    2809:	e8 2d 11 00 00       	call   393b <mkdir>
    280e:	83 c4 10             	add    $0x10,%esp
    2811:	85 c0                	test   %eax,%eax
    2813:	0f 85 b0 00 00 00    	jne    28c9 <rmdot+0xd9>
    2819:	83 ec 0c             	sub    $0xc,%esp
    281c:	68 73 49 00 00       	push   $0x4973
    2821:	e8 1d 11 00 00       	call   3943 <chdir>
    2826:	83 c4 10             	add    $0x10,%esp
    2829:	85 c0                	test   %eax,%eax
    282b:	0f 85 1d 01 00 00    	jne    294e <rmdot+0x15e>
    2831:	83 ec 0c             	sub    $0xc,%esp
    2834:	68 1e 46 00 00       	push   $0x461e
    2839:	e8 e5 10 00 00       	call   3923 <unlink>
    283e:	83 c4 10             	add    $0x10,%esp
    2841:	85 c0                	test   %eax,%eax
    2843:	0f 84 f2 00 00 00    	je     293b <rmdot+0x14b>
    2849:	83 ec 0c             	sub    $0xc,%esp
    284c:	68 1d 46 00 00       	push   $0x461d
    2851:	e8 cd 10 00 00       	call   3923 <unlink>
    2856:	83 c4 10             	add    $0x10,%esp
    2859:	85 c0                	test   %eax,%eax
    285b:	0f 84 c7 00 00 00    	je     2928 <rmdot+0x138>
    2861:	83 ec 0c             	sub    $0xc,%esp
    2864:	68 f1 3d 00 00       	push   $0x3df1
    2869:	e8 d5 10 00 00       	call   3943 <chdir>
    286e:	83 c4 10             	add    $0x10,%esp
    2871:	85 c0                	test   %eax,%eax
    2873:	0f 85 9c 00 00 00    	jne    2915 <rmdot+0x125>
    2879:	83 ec 0c             	sub    $0xc,%esp
    287c:	68 bb 49 00 00       	push   $0x49bb
    2881:	e8 9d 10 00 00       	call   3923 <unlink>
    2886:	83 c4 10             	add    $0x10,%esp
    2889:	85 c0                	test   %eax,%eax
    288b:	74 75                	je     2902 <rmdot+0x112>
    288d:	83 ec 0c             	sub    $0xc,%esp
    2890:	68 d9 49 00 00       	push   $0x49d9
    2895:	e8 89 10 00 00       	call   3923 <unlink>
    289a:	83 c4 10             	add    $0x10,%esp
    289d:	85 c0                	test   %eax,%eax
    289f:	74 4e                	je     28ef <rmdot+0xff>
    28a1:	83 ec 0c             	sub    $0xc,%esp
    28a4:	68 73 49 00 00       	push   $0x4973
    28a9:	e8 75 10 00 00       	call   3923 <unlink>
    28ae:	83 c4 10             	add    $0x10,%esp
    28b1:	85 c0                	test   %eax,%eax
    28b3:	75 27                	jne    28dc <rmdot+0xec>
    28b5:	83 ec 08             	sub    $0x8,%esp
    28b8:	68 0e 4a 00 00       	push   $0x4a0e
    28bd:	6a 01                	push   $0x1
    28bf:	e8 bc 11 00 00       	call   3a80 <printf>
    28c4:	83 c4 10             	add    $0x10,%esp
    28c7:	c9                   	leave  
    28c8:	c3                   	ret    
    28c9:	50                   	push   %eax
    28ca:	50                   	push   %eax
    28cb:	68 78 49 00 00       	push   $0x4978
    28d0:	6a 01                	push   $0x1
    28d2:	e8 a9 11 00 00       	call   3a80 <printf>
    28d7:	e8 f7 0f 00 00       	call   38d3 <exit>
    28dc:	50                   	push   %eax
    28dd:	50                   	push   %eax
    28de:	68 f9 49 00 00       	push   $0x49f9
    28e3:	6a 01                	push   $0x1
    28e5:	e8 96 11 00 00       	call   3a80 <printf>
    28ea:	e8 e4 0f 00 00       	call   38d3 <exit>
    28ef:	52                   	push   %edx
    28f0:	52                   	push   %edx
    28f1:	68 e1 49 00 00       	push   $0x49e1
    28f6:	6a 01                	push   $0x1
    28f8:	e8 83 11 00 00       	call   3a80 <printf>
    28fd:	e8 d1 0f 00 00       	call   38d3 <exit>
    2902:	51                   	push   %ecx
    2903:	51                   	push   %ecx
    2904:	68 c2 49 00 00       	push   $0x49c2
    2909:	6a 01                	push   $0x1
    290b:	e8 70 11 00 00       	call   3a80 <printf>
    2910:	e8 be 0f 00 00       	call   38d3 <exit>
    2915:	50                   	push   %eax
    2916:	50                   	push   %eax
    2917:	68 f3 3d 00 00       	push   $0x3df3
    291c:	6a 01                	push   $0x1
    291e:	e8 5d 11 00 00       	call   3a80 <printf>
    2923:	e8 ab 0f 00 00       	call   38d3 <exit>
    2928:	50                   	push   %eax
    2929:	50                   	push   %eax
    292a:	68 ac 49 00 00       	push   $0x49ac
    292f:	6a 01                	push   $0x1
    2931:	e8 4a 11 00 00       	call   3a80 <printf>
    2936:	e8 98 0f 00 00       	call   38d3 <exit>
    293b:	50                   	push   %eax
    293c:	50                   	push   %eax
    293d:	68 9e 49 00 00       	push   $0x499e
    2942:	6a 01                	push   $0x1
    2944:	e8 37 11 00 00       	call   3a80 <printf>
    2949:	e8 85 0f 00 00       	call   38d3 <exit>
    294e:	50                   	push   %eax
    294f:	50                   	push   %eax
    2950:	68 8b 49 00 00       	push   $0x498b
    2955:	6a 01                	push   $0x1
    2957:	e8 24 11 00 00       	call   3a80 <printf>
    295c:	e8 72 0f 00 00       	call   38d3 <exit>
    2961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2968:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    296f:	90                   	nop

00002970 <dirfile>:
    2970:	55                   	push   %ebp
    2971:	89 e5                	mov    %esp,%ebp
    2973:	53                   	push   %ebx
    2974:	83 ec 0c             	sub    $0xc,%esp
    2977:	68 18 4a 00 00       	push   $0x4a18
    297c:	6a 01                	push   $0x1
    297e:	e8 fd 10 00 00       	call   3a80 <printf>
    2983:	5b                   	pop    %ebx
    2984:	58                   	pop    %eax
    2985:	68 00 02 00 00       	push   $0x200
    298a:	68 25 4a 00 00       	push   $0x4a25
    298f:	e8 7f 0f 00 00       	call   3913 <open>
    2994:	83 c4 10             	add    $0x10,%esp
    2997:	85 c0                	test   %eax,%eax
    2999:	0f 88 43 01 00 00    	js     2ae2 <dirfile+0x172>
    299f:	83 ec 0c             	sub    $0xc,%esp
    29a2:	50                   	push   %eax
    29a3:	e8 53 0f 00 00       	call   38fb <close>
    29a8:	c7 04 24 25 4a 00 00 	movl   $0x4a25,(%esp)
    29af:	e8 8f 0f 00 00       	call   3943 <chdir>
    29b4:	83 c4 10             	add    $0x10,%esp
    29b7:	85 c0                	test   %eax,%eax
    29b9:	0f 84 10 01 00 00    	je     2acf <dirfile+0x15f>
    29bf:	83 ec 08             	sub    $0x8,%esp
    29c2:	6a 00                	push   $0x0
    29c4:	68 5e 4a 00 00       	push   $0x4a5e
    29c9:	e8 45 0f 00 00       	call   3913 <open>
    29ce:	83 c4 10             	add    $0x10,%esp
    29d1:	85 c0                	test   %eax,%eax
    29d3:	0f 89 e3 00 00 00    	jns    2abc <dirfile+0x14c>
    29d9:	83 ec 08             	sub    $0x8,%esp
    29dc:	68 00 02 00 00       	push   $0x200
    29e1:	68 5e 4a 00 00       	push   $0x4a5e
    29e6:	e8 28 0f 00 00       	call   3913 <open>
    29eb:	83 c4 10             	add    $0x10,%esp
    29ee:	85 c0                	test   %eax,%eax
    29f0:	0f 89 c6 00 00 00    	jns    2abc <dirfile+0x14c>
    29f6:	83 ec 0c             	sub    $0xc,%esp
    29f9:	68 5e 4a 00 00       	push   $0x4a5e
    29fe:	e8 38 0f 00 00       	call   393b <mkdir>
    2a03:	83 c4 10             	add    $0x10,%esp
    2a06:	85 c0                	test   %eax,%eax
    2a08:	0f 84 46 01 00 00    	je     2b54 <dirfile+0x1e4>
    2a0e:	83 ec 0c             	sub    $0xc,%esp
    2a11:	68 5e 4a 00 00       	push   $0x4a5e
    2a16:	e8 08 0f 00 00       	call   3923 <unlink>
    2a1b:	83 c4 10             	add    $0x10,%esp
    2a1e:	85 c0                	test   %eax,%eax
    2a20:	0f 84 1b 01 00 00    	je     2b41 <dirfile+0x1d1>
    2a26:	83 ec 08             	sub    $0x8,%esp
    2a29:	68 5e 4a 00 00       	push   $0x4a5e
    2a2e:	68 c2 4a 00 00       	push   $0x4ac2
    2a33:	e8 fb 0e 00 00       	call   3933 <link>
    2a38:	83 c4 10             	add    $0x10,%esp
    2a3b:	85 c0                	test   %eax,%eax
    2a3d:	0f 84 eb 00 00 00    	je     2b2e <dirfile+0x1be>
    2a43:	83 ec 0c             	sub    $0xc,%esp
    2a46:	68 25 4a 00 00       	push   $0x4a25
    2a4b:	e8 d3 0e 00 00       	call   3923 <unlink>
    2a50:	83 c4 10             	add    $0x10,%esp
    2a53:	85 c0                	test   %eax,%eax
    2a55:	0f 85 c0 00 00 00    	jne    2b1b <dirfile+0x1ab>
    2a5b:	83 ec 08             	sub    $0x8,%esp
    2a5e:	6a 02                	push   $0x2
    2a60:	68 1e 46 00 00       	push   $0x461e
    2a65:	e8 a9 0e 00 00       	call   3913 <open>
    2a6a:	83 c4 10             	add    $0x10,%esp
    2a6d:	85 c0                	test   %eax,%eax
    2a6f:	0f 89 93 00 00 00    	jns    2b08 <dirfile+0x198>
    2a75:	83 ec 08             	sub    $0x8,%esp
    2a78:	6a 00                	push   $0x0
    2a7a:	68 1e 46 00 00       	push   $0x461e
    2a7f:	e8 8f 0e 00 00       	call   3913 <open>
    2a84:	83 c4 0c             	add    $0xc,%esp
    2a87:	6a 01                	push   $0x1
    2a89:	89 c3                	mov    %eax,%ebx
    2a8b:	68 01 47 00 00       	push   $0x4701
    2a90:	50                   	push   %eax
    2a91:	e8 5d 0e 00 00       	call   38f3 <write>
    2a96:	83 c4 10             	add    $0x10,%esp
    2a99:	85 c0                	test   %eax,%eax
    2a9b:	7f 58                	jg     2af5 <dirfile+0x185>
    2a9d:	83 ec 0c             	sub    $0xc,%esp
    2aa0:	53                   	push   %ebx
    2aa1:	e8 55 0e 00 00       	call   38fb <close>
    2aa6:	58                   	pop    %eax
    2aa7:	5a                   	pop    %edx
    2aa8:	68 f5 4a 00 00       	push   $0x4af5
    2aad:	6a 01                	push   $0x1
    2aaf:	e8 cc 0f 00 00       	call   3a80 <printf>
    2ab4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2ab7:	83 c4 10             	add    $0x10,%esp
    2aba:	c9                   	leave  
    2abb:	c3                   	ret    
    2abc:	50                   	push   %eax
    2abd:	50                   	push   %eax
    2abe:	68 69 4a 00 00       	push   $0x4a69
    2ac3:	6a 01                	push   $0x1
    2ac5:	e8 b6 0f 00 00       	call   3a80 <printf>
    2aca:	e8 04 0e 00 00       	call   38d3 <exit>
    2acf:	52                   	push   %edx
    2ad0:	52                   	push   %edx
    2ad1:	68 44 4a 00 00       	push   $0x4a44
    2ad6:	6a 01                	push   $0x1
    2ad8:	e8 a3 0f 00 00       	call   3a80 <printf>
    2add:	e8 f1 0d 00 00       	call   38d3 <exit>
    2ae2:	51                   	push   %ecx
    2ae3:	51                   	push   %ecx
    2ae4:	68 2d 4a 00 00       	push   $0x4a2d
    2ae9:	6a 01                	push   $0x1
    2aeb:	e8 90 0f 00 00       	call   3a80 <printf>
    2af0:	e8 de 0d 00 00       	call   38d3 <exit>
    2af5:	51                   	push   %ecx
    2af6:	51                   	push   %ecx
    2af7:	68 e1 4a 00 00       	push   $0x4ae1
    2afc:	6a 01                	push   $0x1
    2afe:	e8 7d 0f 00 00       	call   3a80 <printf>
    2b03:	e8 cb 0d 00 00       	call   38d3 <exit>
    2b08:	53                   	push   %ebx
    2b09:	53                   	push   %ebx
    2b0a:	68 d8 52 00 00       	push   $0x52d8
    2b0f:	6a 01                	push   $0x1
    2b11:	e8 6a 0f 00 00       	call   3a80 <printf>
    2b16:	e8 b8 0d 00 00       	call   38d3 <exit>
    2b1b:	50                   	push   %eax
    2b1c:	50                   	push   %eax
    2b1d:	68 c9 4a 00 00       	push   $0x4ac9
    2b22:	6a 01                	push   $0x1
    2b24:	e8 57 0f 00 00       	call   3a80 <printf>
    2b29:	e8 a5 0d 00 00       	call   38d3 <exit>
    2b2e:	50                   	push   %eax
    2b2f:	50                   	push   %eax
    2b30:	68 b8 52 00 00       	push   $0x52b8
    2b35:	6a 01                	push   $0x1
    2b37:	e8 44 0f 00 00       	call   3a80 <printf>
    2b3c:	e8 92 0d 00 00       	call   38d3 <exit>
    2b41:	50                   	push   %eax
    2b42:	50                   	push   %eax
    2b43:	68 a4 4a 00 00       	push   $0x4aa4
    2b48:	6a 01                	push   $0x1
    2b4a:	e8 31 0f 00 00       	call   3a80 <printf>
    2b4f:	e8 7f 0d 00 00       	call   38d3 <exit>
    2b54:	50                   	push   %eax
    2b55:	50                   	push   %eax
    2b56:	68 87 4a 00 00       	push   $0x4a87
    2b5b:	6a 01                	push   $0x1
    2b5d:	e8 1e 0f 00 00       	call   3a80 <printf>
    2b62:	e8 6c 0d 00 00       	call   38d3 <exit>
    2b67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2b6e:	66 90                	xchg   %ax,%ax

00002b70 <iref>:
    2b70:	55                   	push   %ebp
    2b71:	89 e5                	mov    %esp,%ebp
    2b73:	53                   	push   %ebx
    2b74:	bb 33 00 00 00       	mov    $0x33,%ebx
    2b79:	83 ec 0c             	sub    $0xc,%esp
    2b7c:	68 05 4b 00 00       	push   $0x4b05
    2b81:	6a 01                	push   $0x1
    2b83:	e8 f8 0e 00 00       	call   3a80 <printf>
    2b88:	83 c4 10             	add    $0x10,%esp
    2b8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2b8f:	90                   	nop
    2b90:	83 ec 0c             	sub    $0xc,%esp
    2b93:	68 16 4b 00 00       	push   $0x4b16
    2b98:	e8 9e 0d 00 00       	call   393b <mkdir>
    2b9d:	83 c4 10             	add    $0x10,%esp
    2ba0:	85 c0                	test   %eax,%eax
    2ba2:	0f 85 bb 00 00 00    	jne    2c63 <iref+0xf3>
    2ba8:	83 ec 0c             	sub    $0xc,%esp
    2bab:	68 16 4b 00 00       	push   $0x4b16
    2bb0:	e8 8e 0d 00 00       	call   3943 <chdir>
    2bb5:	83 c4 10             	add    $0x10,%esp
    2bb8:	85 c0                	test   %eax,%eax
    2bba:	0f 85 b7 00 00 00    	jne    2c77 <iref+0x107>
    2bc0:	83 ec 0c             	sub    $0xc,%esp
    2bc3:	68 cb 41 00 00       	push   $0x41cb
    2bc8:	e8 6e 0d 00 00       	call   393b <mkdir>
    2bcd:	59                   	pop    %ecx
    2bce:	58                   	pop    %eax
    2bcf:	68 cb 41 00 00       	push   $0x41cb
    2bd4:	68 c2 4a 00 00       	push   $0x4ac2
    2bd9:	e8 55 0d 00 00       	call   3933 <link>
    2bde:	58                   	pop    %eax
    2bdf:	5a                   	pop    %edx
    2be0:	68 00 02 00 00       	push   $0x200
    2be5:	68 cb 41 00 00       	push   $0x41cb
    2bea:	e8 24 0d 00 00       	call   3913 <open>
    2bef:	83 c4 10             	add    $0x10,%esp
    2bf2:	85 c0                	test   %eax,%eax
    2bf4:	78 0c                	js     2c02 <iref+0x92>
    2bf6:	83 ec 0c             	sub    $0xc,%esp
    2bf9:	50                   	push   %eax
    2bfa:	e8 fc 0c 00 00       	call   38fb <close>
    2bff:	83 c4 10             	add    $0x10,%esp
    2c02:	83 ec 08             	sub    $0x8,%esp
    2c05:	68 00 02 00 00       	push   $0x200
    2c0a:	68 00 47 00 00       	push   $0x4700
    2c0f:	e8 ff 0c 00 00       	call   3913 <open>
    2c14:	83 c4 10             	add    $0x10,%esp
    2c17:	85 c0                	test   %eax,%eax
    2c19:	78 0c                	js     2c27 <iref+0xb7>
    2c1b:	83 ec 0c             	sub    $0xc,%esp
    2c1e:	50                   	push   %eax
    2c1f:	e8 d7 0c 00 00       	call   38fb <close>
    2c24:	83 c4 10             	add    $0x10,%esp
    2c27:	83 ec 0c             	sub    $0xc,%esp
    2c2a:	68 00 47 00 00       	push   $0x4700
    2c2f:	e8 ef 0c 00 00       	call   3923 <unlink>
    2c34:	83 c4 10             	add    $0x10,%esp
    2c37:	83 eb 01             	sub    $0x1,%ebx
    2c3a:	0f 85 50 ff ff ff    	jne    2b90 <iref+0x20>
    2c40:	83 ec 0c             	sub    $0xc,%esp
    2c43:	68 f1 3d 00 00       	push   $0x3df1
    2c48:	e8 f6 0c 00 00       	call   3943 <chdir>
    2c4d:	58                   	pop    %eax
    2c4e:	5a                   	pop    %edx
    2c4f:	68 44 4b 00 00       	push   $0x4b44
    2c54:	6a 01                	push   $0x1
    2c56:	e8 25 0e 00 00       	call   3a80 <printf>
    2c5b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2c5e:	83 c4 10             	add    $0x10,%esp
    2c61:	c9                   	leave  
    2c62:	c3                   	ret    
    2c63:	83 ec 08             	sub    $0x8,%esp
    2c66:	68 1c 4b 00 00       	push   $0x4b1c
    2c6b:	6a 01                	push   $0x1
    2c6d:	e8 0e 0e 00 00       	call   3a80 <printf>
    2c72:	e8 5c 0c 00 00       	call   38d3 <exit>
    2c77:	83 ec 08             	sub    $0x8,%esp
    2c7a:	68 30 4b 00 00       	push   $0x4b30
    2c7f:	6a 01                	push   $0x1
    2c81:	e8 fa 0d 00 00       	call   3a80 <printf>
    2c86:	e8 48 0c 00 00       	call   38d3 <exit>
    2c8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2c8f:	90                   	nop

00002c90 <forktest>:
    2c90:	55                   	push   %ebp
    2c91:	89 e5                	mov    %esp,%ebp
    2c93:	53                   	push   %ebx
    2c94:	31 db                	xor    %ebx,%ebx
    2c96:	83 ec 0c             	sub    $0xc,%esp
    2c99:	68 58 4b 00 00       	push   $0x4b58
    2c9e:	6a 01                	push   $0x1
    2ca0:	e8 db 0d 00 00       	call   3a80 <printf>
    2ca5:	83 c4 10             	add    $0x10,%esp
    2ca8:	eb 13                	jmp    2cbd <forktest+0x2d>
    2caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    2cb0:	74 4a                	je     2cfc <forktest+0x6c>
    2cb2:	83 c3 01             	add    $0x1,%ebx
    2cb5:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2cbb:	74 6b                	je     2d28 <forktest+0x98>
    2cbd:	e8 09 0c 00 00       	call   38cb <fork>
    2cc2:	85 c0                	test   %eax,%eax
    2cc4:	79 ea                	jns    2cb0 <forktest+0x20>
    2cc6:	85 db                	test   %ebx,%ebx
    2cc8:	74 14                	je     2cde <forktest+0x4e>
    2cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    2cd0:	e8 06 0c 00 00       	call   38db <wait>
    2cd5:	85 c0                	test   %eax,%eax
    2cd7:	78 28                	js     2d01 <forktest+0x71>
    2cd9:	83 eb 01             	sub    $0x1,%ebx
    2cdc:	75 f2                	jne    2cd0 <forktest+0x40>
    2cde:	e8 f8 0b 00 00       	call   38db <wait>
    2ce3:	83 f8 ff             	cmp    $0xffffffff,%eax
    2ce6:	75 2d                	jne    2d15 <forktest+0x85>
    2ce8:	83 ec 08             	sub    $0x8,%esp
    2ceb:	68 8a 4b 00 00       	push   $0x4b8a
    2cf0:	6a 01                	push   $0x1
    2cf2:	e8 89 0d 00 00       	call   3a80 <printf>
    2cf7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2cfa:	c9                   	leave  
    2cfb:	c3                   	ret    
    2cfc:	e8 d2 0b 00 00       	call   38d3 <exit>
    2d01:	83 ec 08             	sub    $0x8,%esp
    2d04:	68 63 4b 00 00       	push   $0x4b63
    2d09:	6a 01                	push   $0x1
    2d0b:	e8 70 0d 00 00       	call   3a80 <printf>
    2d10:	e8 be 0b 00 00       	call   38d3 <exit>
    2d15:	52                   	push   %edx
    2d16:	52                   	push   %edx
    2d17:	68 77 4b 00 00       	push   $0x4b77
    2d1c:	6a 01                	push   $0x1
    2d1e:	e8 5d 0d 00 00       	call   3a80 <printf>
    2d23:	e8 ab 0b 00 00       	call   38d3 <exit>
    2d28:	50                   	push   %eax
    2d29:	50                   	push   %eax
    2d2a:	68 f8 52 00 00       	push   $0x52f8
    2d2f:	6a 01                	push   $0x1
    2d31:	e8 4a 0d 00 00       	call   3a80 <printf>
    2d36:	e8 98 0b 00 00       	call   38d3 <exit>
    2d3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2d3f:	90                   	nop

00002d40 <sbrktest>:
    2d40:	55                   	push   %ebp
    2d41:	89 e5                	mov    %esp,%ebp
    2d43:	57                   	push   %edi
    2d44:	56                   	push   %esi
    2d45:	31 f6                	xor    %esi,%esi
    2d47:	53                   	push   %ebx
    2d48:	83 ec 64             	sub    $0x64,%esp
    2d4b:	68 98 4b 00 00       	push   $0x4b98
    2d50:	ff 35 98 5e 00 00    	push   0x5e98
    2d56:	e8 25 0d 00 00       	call   3a80 <printf>
    2d5b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d62:	e8 f4 0b 00 00       	call   395b <sbrk>
    2d67:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d6e:	89 45 a4             	mov    %eax,-0x5c(%ebp)
    2d71:	e8 e5 0b 00 00       	call   395b <sbrk>
    2d76:	83 c4 10             	add    $0x10,%esp
    2d79:	89 c3                	mov    %eax,%ebx
    2d7b:	eb 05                	jmp    2d82 <sbrktest+0x42>
    2d7d:	8d 76 00             	lea    0x0(%esi),%esi
    2d80:	89 c3                	mov    %eax,%ebx
    2d82:	83 ec 0c             	sub    $0xc,%esp
    2d85:	6a 01                	push   $0x1
    2d87:	e8 cf 0b 00 00       	call   395b <sbrk>
    2d8c:	83 c4 10             	add    $0x10,%esp
    2d8f:	39 d8                	cmp    %ebx,%eax
    2d91:	0f 85 9c 02 00 00    	jne    3033 <sbrktest+0x2f3>
    2d97:	83 c6 01             	add    $0x1,%esi
    2d9a:	c6 03 01             	movb   $0x1,(%ebx)
    2d9d:	8d 43 01             	lea    0x1(%ebx),%eax
    2da0:	81 fe 88 13 00 00    	cmp    $0x1388,%esi
    2da6:	75 d8                	jne    2d80 <sbrktest+0x40>
    2da8:	e8 1e 0b 00 00       	call   38cb <fork>
    2dad:	89 c6                	mov    %eax,%esi
    2daf:	85 c0                	test   %eax,%eax
    2db1:	0f 88 02 03 00 00    	js     30b9 <sbrktest+0x379>
    2db7:	83 ec 0c             	sub    $0xc,%esp
    2dba:	83 c3 02             	add    $0x2,%ebx
    2dbd:	6a 01                	push   $0x1
    2dbf:	e8 97 0b 00 00       	call   395b <sbrk>
    2dc4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2dcb:	e8 8b 0b 00 00       	call   395b <sbrk>
    2dd0:	83 c4 10             	add    $0x10,%esp
    2dd3:	39 c3                	cmp    %eax,%ebx
    2dd5:	0f 85 3b 03 00 00    	jne    3116 <sbrktest+0x3d6>
    2ddb:	85 f6                	test   %esi,%esi
    2ddd:	0f 84 2e 03 00 00    	je     3111 <sbrktest+0x3d1>
    2de3:	e8 f3 0a 00 00       	call   38db <wait>
    2de8:	83 ec 0c             	sub    $0xc,%esp
    2deb:	6a 00                	push   $0x0
    2ded:	e8 69 0b 00 00       	call   395b <sbrk>
    2df2:	89 c3                	mov    %eax,%ebx
    2df4:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2df9:	29 d8                	sub    %ebx,%eax
    2dfb:	89 04 24             	mov    %eax,(%esp)
    2dfe:	e8 58 0b 00 00       	call   395b <sbrk>
    2e03:	83 c4 10             	add    $0x10,%esp
    2e06:	39 c3                	cmp    %eax,%ebx
    2e08:	0f 85 94 02 00 00    	jne    30a2 <sbrktest+0x362>
    2e0e:	83 ec 0c             	sub    $0xc,%esp
    2e11:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff
    2e18:	6a 00                	push   $0x0
    2e1a:	e8 3c 0b 00 00       	call   395b <sbrk>
    2e1f:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
    2e26:	89 c3                	mov    %eax,%ebx
    2e28:	e8 2e 0b 00 00       	call   395b <sbrk>
    2e2d:	83 c4 10             	add    $0x10,%esp
    2e30:	83 f8 ff             	cmp    $0xffffffff,%eax
    2e33:	0f 84 22 03 00 00    	je     315b <sbrktest+0x41b>
    2e39:	83 ec 0c             	sub    $0xc,%esp
    2e3c:	6a 00                	push   $0x0
    2e3e:	e8 18 0b 00 00       	call   395b <sbrk>
    2e43:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
    2e49:	83 c4 10             	add    $0x10,%esp
    2e4c:	39 d0                	cmp    %edx,%eax
    2e4e:	0f 85 f0 02 00 00    	jne    3144 <sbrktest+0x404>
    2e54:	83 ec 0c             	sub    $0xc,%esp
    2e57:	6a 00                	push   $0x0
    2e59:	e8 fd 0a 00 00       	call   395b <sbrk>
    2e5e:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    2e65:	89 c3                	mov    %eax,%ebx
    2e67:	e8 ef 0a 00 00       	call   395b <sbrk>
    2e6c:	83 c4 10             	add    $0x10,%esp
    2e6f:	89 c6                	mov    %eax,%esi
    2e71:	39 c3                	cmp    %eax,%ebx
    2e73:	0f 85 b4 02 00 00    	jne    312d <sbrktest+0x3ed>
    2e79:	83 ec 0c             	sub    $0xc,%esp
    2e7c:	6a 00                	push   $0x0
    2e7e:	e8 d8 0a 00 00       	call   395b <sbrk>
    2e83:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    2e89:	83 c4 10             	add    $0x10,%esp
    2e8c:	39 c2                	cmp    %eax,%edx
    2e8e:	0f 85 99 02 00 00    	jne    312d <sbrktest+0x3ed>
    2e94:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    2e9b:	0f 84 2f 02 00 00    	je     30d0 <sbrktest+0x390>
    2ea1:	83 ec 0c             	sub    $0xc,%esp
    2ea4:	6a 00                	push   $0x0
    2ea6:	e8 b0 0a 00 00       	call   395b <sbrk>
    2eab:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2eb2:	89 c3                	mov    %eax,%ebx
    2eb4:	e8 a2 0a 00 00       	call   395b <sbrk>
    2eb9:	89 c2                	mov    %eax,%edx
    2ebb:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    2ebe:	29 d0                	sub    %edx,%eax
    2ec0:	89 04 24             	mov    %eax,(%esp)
    2ec3:	e8 93 0a 00 00       	call   395b <sbrk>
    2ec8:	83 c4 10             	add    $0x10,%esp
    2ecb:	39 c3                	cmp    %eax,%ebx
    2ecd:	0f 85 b8 01 00 00    	jne    308b <sbrktest+0x34b>
    2ed3:	bb 00 00 00 80       	mov    $0x80000000,%ebx
    2ed8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2edf:	90                   	nop
    2ee0:	e8 6e 0a 00 00       	call   3953 <getpid>
    2ee5:	89 c6                	mov    %eax,%esi
    2ee7:	e8 df 09 00 00       	call   38cb <fork>
    2eec:	85 c0                	test   %eax,%eax
    2eee:	0f 88 5d 01 00 00    	js     3051 <sbrktest+0x311>
    2ef4:	0f 84 6f 01 00 00    	je     3069 <sbrktest+0x329>
    2efa:	e8 dc 09 00 00       	call   38db <wait>
    2eff:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
    2f05:	81 fb 80 84 1e 80    	cmp    $0x801e8480,%ebx
    2f0b:	75 d3                	jne    2ee0 <sbrktest+0x1a0>
    2f0d:	83 ec 0c             	sub    $0xc,%esp
    2f10:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2f13:	50                   	push   %eax
    2f14:	e8 ca 09 00 00       	call   38e3 <pipe>
    2f19:	83 c4 10             	add    $0x10,%esp
    2f1c:	85 c0                	test   %eax,%eax
    2f1e:	0f 85 da 01 00 00    	jne    30fe <sbrktest+0x3be>
    2f24:	8d 5d c0             	lea    -0x40(%ebp),%ebx
    2f27:	8d 75 e8             	lea    -0x18(%ebp),%esi
    2f2a:	89 df                	mov    %ebx,%edi
    2f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2f30:	e8 96 09 00 00       	call   38cb <fork>
    2f35:	89 07                	mov    %eax,(%edi)
    2f37:	85 c0                	test   %eax,%eax
    2f39:	0f 84 91 00 00 00    	je     2fd0 <sbrktest+0x290>
    2f3f:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f42:	74 14                	je     2f58 <sbrktest+0x218>
    2f44:	83 ec 04             	sub    $0x4,%esp
    2f47:	8d 45 b7             	lea    -0x49(%ebp),%eax
    2f4a:	6a 01                	push   $0x1
    2f4c:	50                   	push   %eax
    2f4d:	ff 75 b8             	push   -0x48(%ebp)
    2f50:	e8 96 09 00 00       	call   38eb <read>
    2f55:	83 c4 10             	add    $0x10,%esp
    2f58:	83 c7 04             	add    $0x4,%edi
    2f5b:	39 f7                	cmp    %esi,%edi
    2f5d:	75 d1                	jne    2f30 <sbrktest+0x1f0>
    2f5f:	83 ec 0c             	sub    $0xc,%esp
    2f62:	68 00 10 00 00       	push   $0x1000
    2f67:	e8 ef 09 00 00       	call   395b <sbrk>
    2f6c:	83 c4 10             	add    $0x10,%esp
    2f6f:	89 c7                	mov    %eax,%edi
    2f71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2f78:	8b 03                	mov    (%ebx),%eax
    2f7a:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f7d:	74 11                	je     2f90 <sbrktest+0x250>
    2f7f:	83 ec 0c             	sub    $0xc,%esp
    2f82:	50                   	push   %eax
    2f83:	e8 7b 09 00 00       	call   3903 <kill>
    2f88:	e8 4e 09 00 00       	call   38db <wait>
    2f8d:	83 c4 10             	add    $0x10,%esp
    2f90:	83 c3 04             	add    $0x4,%ebx
    2f93:	39 de                	cmp    %ebx,%esi
    2f95:	75 e1                	jne    2f78 <sbrktest+0x238>
    2f97:	83 ff ff             	cmp    $0xffffffff,%edi
    2f9a:	0f 84 47 01 00 00    	je     30e7 <sbrktest+0x3a7>
    2fa0:	83 ec 0c             	sub    $0xc,%esp
    2fa3:	6a 00                	push   $0x0
    2fa5:	e8 b1 09 00 00       	call   395b <sbrk>
    2faa:	83 c4 10             	add    $0x10,%esp
    2fad:	39 45 a4             	cmp    %eax,-0x5c(%ebp)
    2fb0:	72 60                	jb     3012 <sbrktest+0x2d2>
    2fb2:	83 ec 08             	sub    $0x8,%esp
    2fb5:	68 40 4c 00 00       	push   $0x4c40
    2fba:	ff 35 98 5e 00 00    	push   0x5e98
    2fc0:	e8 bb 0a 00 00       	call   3a80 <printf>
    2fc5:	83 c4 10             	add    $0x10,%esp
    2fc8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2fcb:	5b                   	pop    %ebx
    2fcc:	5e                   	pop    %esi
    2fcd:	5f                   	pop    %edi
    2fce:	5d                   	pop    %ebp
    2fcf:	c3                   	ret    
    2fd0:	83 ec 0c             	sub    $0xc,%esp
    2fd3:	6a 00                	push   $0x0
    2fd5:	e8 81 09 00 00       	call   395b <sbrk>
    2fda:	89 c2                	mov    %eax,%edx
    2fdc:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2fe1:	29 d0                	sub    %edx,%eax
    2fe3:	89 04 24             	mov    %eax,(%esp)
    2fe6:	e8 70 09 00 00       	call   395b <sbrk>
    2feb:	83 c4 0c             	add    $0xc,%esp
    2fee:	6a 01                	push   $0x1
    2ff0:	68 01 47 00 00       	push   $0x4701
    2ff5:	ff 75 bc             	push   -0x44(%ebp)
    2ff8:	e8 f6 08 00 00       	call   38f3 <write>
    2ffd:	83 c4 10             	add    $0x10,%esp
    3000:	83 ec 0c             	sub    $0xc,%esp
    3003:	68 e8 03 00 00       	push   $0x3e8
    3008:	e8 56 09 00 00       	call   3963 <sleep>
    300d:	83 c4 10             	add    $0x10,%esp
    3010:	eb ee                	jmp    3000 <sbrktest+0x2c0>
    3012:	83 ec 0c             	sub    $0xc,%esp
    3015:	6a 00                	push   $0x0
    3017:	e8 3f 09 00 00       	call   395b <sbrk>
    301c:	89 c2                	mov    %eax,%edx
    301e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    3021:	29 d0                	sub    %edx,%eax
    3023:	89 04 24             	mov    %eax,(%esp)
    3026:	e8 30 09 00 00       	call   395b <sbrk>
    302b:	83 c4 10             	add    $0x10,%esp
    302e:	e9 7f ff ff ff       	jmp    2fb2 <sbrktest+0x272>
    3033:	83 ec 0c             	sub    $0xc,%esp
    3036:	50                   	push   %eax
    3037:	53                   	push   %ebx
    3038:	56                   	push   %esi
    3039:	68 a3 4b 00 00       	push   $0x4ba3
    303e:	ff 35 98 5e 00 00    	push   0x5e98
    3044:	e8 37 0a 00 00       	call   3a80 <printf>
    3049:	83 c4 20             	add    $0x20,%esp
    304c:	e8 82 08 00 00       	call   38d3 <exit>
    3051:	83 ec 08             	sub    $0x8,%esp
    3054:	68 e9 4c 00 00       	push   $0x4ce9
    3059:	ff 35 98 5e 00 00    	push   0x5e98
    305f:	e8 1c 0a 00 00       	call   3a80 <printf>
    3064:	e8 6a 08 00 00       	call   38d3 <exit>
    3069:	0f be 03             	movsbl (%ebx),%eax
    306c:	50                   	push   %eax
    306d:	53                   	push   %ebx
    306e:	68 0c 4c 00 00       	push   $0x4c0c
    3073:	ff 35 98 5e 00 00    	push   0x5e98
    3079:	e8 02 0a 00 00       	call   3a80 <printf>
    307e:	89 34 24             	mov    %esi,(%esp)
    3081:	e8 7d 08 00 00       	call   3903 <kill>
    3086:	e8 48 08 00 00       	call   38d3 <exit>
    308b:	50                   	push   %eax
    308c:	53                   	push   %ebx
    308d:	68 ec 53 00 00       	push   $0x53ec
    3092:	ff 35 98 5e 00 00    	push   0x5e98
    3098:	e8 e3 09 00 00       	call   3a80 <printf>
    309d:	e8 31 08 00 00       	call   38d3 <exit>
    30a2:	56                   	push   %esi
    30a3:	56                   	push   %esi
    30a4:	68 1c 53 00 00       	push   $0x531c
    30a9:	ff 35 98 5e 00 00    	push   0x5e98
    30af:	e8 cc 09 00 00       	call   3a80 <printf>
    30b4:	e8 1a 08 00 00       	call   38d3 <exit>
    30b9:	50                   	push   %eax
    30ba:	50                   	push   %eax
    30bb:	68 be 4b 00 00       	push   $0x4bbe
    30c0:	ff 35 98 5e 00 00    	push   0x5e98
    30c6:	e8 b5 09 00 00       	call   3a80 <printf>
    30cb:	e8 03 08 00 00       	call   38d3 <exit>
    30d0:	51                   	push   %ecx
    30d1:	51                   	push   %ecx
    30d2:	68 bc 53 00 00       	push   $0x53bc
    30d7:	ff 35 98 5e 00 00    	push   0x5e98
    30dd:	e8 9e 09 00 00       	call   3a80 <printf>
    30e2:	e8 ec 07 00 00       	call   38d3 <exit>
    30e7:	50                   	push   %eax
    30e8:	50                   	push   %eax
    30e9:	68 25 4c 00 00       	push   $0x4c25
    30ee:	ff 35 98 5e 00 00    	push   0x5e98
    30f4:	e8 87 09 00 00       	call   3a80 <printf>
    30f9:	e8 d5 07 00 00       	call   38d3 <exit>
    30fe:	52                   	push   %edx
    30ff:	52                   	push   %edx
    3100:	68 e1 40 00 00       	push   $0x40e1
    3105:	6a 01                	push   $0x1
    3107:	e8 74 09 00 00       	call   3a80 <printf>
    310c:	e8 c2 07 00 00       	call   38d3 <exit>
    3111:	e8 bd 07 00 00       	call   38d3 <exit>
    3116:	57                   	push   %edi
    3117:	57                   	push   %edi
    3118:	68 d5 4b 00 00       	push   $0x4bd5
    311d:	ff 35 98 5e 00 00    	push   0x5e98
    3123:	e8 58 09 00 00       	call   3a80 <printf>
    3128:	e8 a6 07 00 00       	call   38d3 <exit>
    312d:	56                   	push   %esi
    312e:	53                   	push   %ebx
    312f:	68 94 53 00 00       	push   $0x5394
    3134:	ff 35 98 5e 00 00    	push   0x5e98
    313a:	e8 41 09 00 00       	call   3a80 <printf>
    313f:	e8 8f 07 00 00       	call   38d3 <exit>
    3144:	50                   	push   %eax
    3145:	53                   	push   %ebx
    3146:	68 5c 53 00 00       	push   $0x535c
    314b:	ff 35 98 5e 00 00    	push   0x5e98
    3151:	e8 2a 09 00 00       	call   3a80 <printf>
    3156:	e8 78 07 00 00       	call   38d3 <exit>
    315b:	53                   	push   %ebx
    315c:	53                   	push   %ebx
    315d:	68 f1 4b 00 00       	push   $0x4bf1
    3162:	ff 35 98 5e 00 00    	push   0x5e98
    3168:	e8 13 09 00 00       	call   3a80 <printf>
    316d:	e8 61 07 00 00       	call   38d3 <exit>
    3172:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003180 <validateint>:
    3180:	c3                   	ret    
    3181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3188:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    318f:	90                   	nop

00003190 <validatetest>:
    3190:	55                   	push   %ebp
    3191:	89 e5                	mov    %esp,%ebp
    3193:	56                   	push   %esi
    3194:	31 f6                	xor    %esi,%esi
    3196:	53                   	push   %ebx
    3197:	83 ec 08             	sub    $0x8,%esp
    319a:	68 4e 4c 00 00       	push   $0x4c4e
    319f:	ff 35 98 5e 00 00    	push   0x5e98
    31a5:	e8 d6 08 00 00       	call   3a80 <printf>
    31aa:	83 c4 10             	add    $0x10,%esp
    31ad:	8d 76 00             	lea    0x0(%esi),%esi
    31b0:	e8 16 07 00 00       	call   38cb <fork>
    31b5:	89 c3                	mov    %eax,%ebx
    31b7:	85 c0                	test   %eax,%eax
    31b9:	74 63                	je     321e <validatetest+0x8e>
    31bb:	83 ec 0c             	sub    $0xc,%esp
    31be:	6a 00                	push   $0x0
    31c0:	e8 9e 07 00 00       	call   3963 <sleep>
    31c5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    31cc:	e8 92 07 00 00       	call   3963 <sleep>
    31d1:	89 1c 24             	mov    %ebx,(%esp)
    31d4:	e8 2a 07 00 00       	call   3903 <kill>
    31d9:	e8 fd 06 00 00       	call   38db <wait>
    31de:	58                   	pop    %eax
    31df:	5a                   	pop    %edx
    31e0:	56                   	push   %esi
    31e1:	68 5d 4c 00 00       	push   $0x4c5d
    31e6:	e8 48 07 00 00       	call   3933 <link>
    31eb:	83 c4 10             	add    $0x10,%esp
    31ee:	83 f8 ff             	cmp    $0xffffffff,%eax
    31f1:	75 30                	jne    3223 <validatetest+0x93>
    31f3:	81 c6 00 10 00 00    	add    $0x1000,%esi
    31f9:	81 fe 00 40 11 00    	cmp    $0x114000,%esi
    31ff:	75 af                	jne    31b0 <validatetest+0x20>
    3201:	83 ec 08             	sub    $0x8,%esp
    3204:	68 81 4c 00 00       	push   $0x4c81
    3209:	ff 35 98 5e 00 00    	push   0x5e98
    320f:	e8 6c 08 00 00       	call   3a80 <printf>
    3214:	83 c4 10             	add    $0x10,%esp
    3217:	8d 65 f8             	lea    -0x8(%ebp),%esp
    321a:	5b                   	pop    %ebx
    321b:	5e                   	pop    %esi
    321c:	5d                   	pop    %ebp
    321d:	c3                   	ret    
    321e:	e8 b0 06 00 00       	call   38d3 <exit>
    3223:	83 ec 08             	sub    $0x8,%esp
    3226:	68 68 4c 00 00       	push   $0x4c68
    322b:	ff 35 98 5e 00 00    	push   0x5e98
    3231:	e8 4a 08 00 00       	call   3a80 <printf>
    3236:	e8 98 06 00 00       	call   38d3 <exit>
    323b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    323f:	90                   	nop

00003240 <bsstest>:
    3240:	55                   	push   %ebp
    3241:	89 e5                	mov    %esp,%ebp
    3243:	83 ec 10             	sub    $0x10,%esp
    3246:	68 8e 4c 00 00       	push   $0x4c8e
    324b:	ff 35 98 5e 00 00    	push   0x5e98
    3251:	e8 2a 08 00 00       	call   3a80 <printf>
    3256:	83 c4 10             	add    $0x10,%esp
    3259:	31 c0                	xor    %eax,%eax
    325b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    325f:	90                   	nop
    3260:	80 b8 c0 5e 00 00 00 	cmpb   $0x0,0x5ec0(%eax)
    3267:	75 22                	jne    328b <bsstest+0x4b>
    3269:	83 c0 01             	add    $0x1,%eax
    326c:	3d 10 27 00 00       	cmp    $0x2710,%eax
    3271:	75 ed                	jne    3260 <bsstest+0x20>
    3273:	83 ec 08             	sub    $0x8,%esp
    3276:	68 a9 4c 00 00       	push   $0x4ca9
    327b:	ff 35 98 5e 00 00    	push   0x5e98
    3281:	e8 fa 07 00 00       	call   3a80 <printf>
    3286:	83 c4 10             	add    $0x10,%esp
    3289:	c9                   	leave  
    328a:	c3                   	ret    
    328b:	83 ec 08             	sub    $0x8,%esp
    328e:	68 98 4c 00 00       	push   $0x4c98
    3293:	ff 35 98 5e 00 00    	push   0x5e98
    3299:	e8 e2 07 00 00       	call   3a80 <printf>
    329e:	e8 30 06 00 00       	call   38d3 <exit>
    32a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    32aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000032b0 <bigargtest>:
    32b0:	55                   	push   %ebp
    32b1:	89 e5                	mov    %esp,%ebp
    32b3:	83 ec 14             	sub    $0x14,%esp
    32b6:	68 b6 4c 00 00       	push   $0x4cb6
    32bb:	e8 63 06 00 00       	call   3923 <unlink>
    32c0:	e8 06 06 00 00       	call   38cb <fork>
    32c5:	83 c4 10             	add    $0x10,%esp
    32c8:	85 c0                	test   %eax,%eax
    32ca:	74 44                	je     3310 <bigargtest+0x60>
    32cc:	0f 88 c5 00 00 00    	js     3397 <bigargtest+0xe7>
    32d2:	e8 04 06 00 00       	call   38db <wait>
    32d7:	83 ec 08             	sub    $0x8,%esp
    32da:	6a 00                	push   $0x0
    32dc:	68 b6 4c 00 00       	push   $0x4cb6
    32e1:	e8 2d 06 00 00       	call   3913 <open>
    32e6:	83 c4 10             	add    $0x10,%esp
    32e9:	85 c0                	test   %eax,%eax
    32eb:	0f 88 8f 00 00 00    	js     3380 <bigargtest+0xd0>
    32f1:	83 ec 0c             	sub    $0xc,%esp
    32f4:	50                   	push   %eax
    32f5:	e8 01 06 00 00       	call   38fb <close>
    32fa:	c7 04 24 b6 4c 00 00 	movl   $0x4cb6,(%esp)
    3301:	e8 1d 06 00 00       	call   3923 <unlink>
    3306:	83 c4 10             	add    $0x10,%esp
    3309:	c9                   	leave  
    330a:	c3                   	ret    
    330b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    330f:	90                   	nop
    3310:	c7 04 85 e0 a5 00 00 	movl   $0x5410,0xa5e0(,%eax,4)
    3317:	10 54 00 00 
    331b:	83 c0 01             	add    $0x1,%eax
    331e:	83 f8 1f             	cmp    $0x1f,%eax
    3321:	75 ed                	jne    3310 <bigargtest+0x60>
    3323:	51                   	push   %ecx
    3324:	51                   	push   %ecx
    3325:	68 c0 4c 00 00       	push   $0x4cc0
    332a:	ff 35 98 5e 00 00    	push   0x5e98
    3330:	c7 05 5c a6 00 00 00 	movl   $0x0,0xa65c
    3337:	00 00 00 
    333a:	e8 41 07 00 00       	call   3a80 <printf>
    333f:	58                   	pop    %eax
    3340:	5a                   	pop    %edx
    3341:	68 e0 a5 00 00       	push   $0xa5e0
    3346:	68 8d 3e 00 00       	push   $0x3e8d
    334b:	e8 bb 05 00 00       	call   390b <exec>
    3350:	59                   	pop    %ecx
    3351:	58                   	pop    %eax
    3352:	68 cd 4c 00 00       	push   $0x4ccd
    3357:	ff 35 98 5e 00 00    	push   0x5e98
    335d:	e8 1e 07 00 00       	call   3a80 <printf>
    3362:	58                   	pop    %eax
    3363:	5a                   	pop    %edx
    3364:	68 00 02 00 00       	push   $0x200
    3369:	68 b6 4c 00 00       	push   $0x4cb6
    336e:	e8 a0 05 00 00       	call   3913 <open>
    3373:	89 04 24             	mov    %eax,(%esp)
    3376:	e8 80 05 00 00       	call   38fb <close>
    337b:	e8 53 05 00 00       	call   38d3 <exit>
    3380:	50                   	push   %eax
    3381:	50                   	push   %eax
    3382:	68 f6 4c 00 00       	push   $0x4cf6
    3387:	ff 35 98 5e 00 00    	push   0x5e98
    338d:	e8 ee 06 00 00       	call   3a80 <printf>
    3392:	e8 3c 05 00 00       	call   38d3 <exit>
    3397:	52                   	push   %edx
    3398:	52                   	push   %edx
    3399:	68 dd 4c 00 00       	push   $0x4cdd
    339e:	ff 35 98 5e 00 00    	push   0x5e98
    33a4:	e8 d7 06 00 00       	call   3a80 <printf>
    33a9:	e8 25 05 00 00       	call   38d3 <exit>
    33ae:	66 90                	xchg   %ax,%ax

000033b0 <fsfull>:
    33b0:	55                   	push   %ebp
    33b1:	89 e5                	mov    %esp,%ebp
    33b3:	57                   	push   %edi
    33b4:	56                   	push   %esi
    33b5:	31 f6                	xor    %esi,%esi
    33b7:	53                   	push   %ebx
    33b8:	83 ec 54             	sub    $0x54,%esp
    33bb:	68 0b 4d 00 00       	push   $0x4d0b
    33c0:	6a 01                	push   $0x1
    33c2:	e8 b9 06 00 00       	call   3a80 <printf>
    33c7:	83 c4 10             	add    $0x10,%esp
    33ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    33d0:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    33d5:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    33da:	83 ec 04             	sub    $0x4,%esp
    33dd:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    33e1:	f7 e6                	mul    %esi
    33e3:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    33e7:	c1 ea 06             	shr    $0x6,%edx
    33ea:	8d 42 30             	lea    0x30(%edx),%eax
    33ed:	88 45 a9             	mov    %al,-0x57(%ebp)
    33f0:	69 c2 e8 03 00 00    	imul   $0x3e8,%edx,%eax
    33f6:	89 f2                	mov    %esi,%edx
    33f8:	29 c2                	sub    %eax,%edx
    33fa:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    33ff:	f7 e2                	mul    %edx
    3401:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3406:	c1 ea 05             	shr    $0x5,%edx
    3409:	83 c2 30             	add    $0x30,%edx
    340c:	88 55 aa             	mov    %dl,-0x56(%ebp)
    340f:	f7 e6                	mul    %esi
    3411:	c1 ea 05             	shr    $0x5,%edx
    3414:	6b c2 64             	imul   $0x64,%edx,%eax
    3417:	89 f2                	mov    %esi,%edx
    3419:	29 c2                	sub    %eax,%edx
    341b:	89 d0                	mov    %edx,%eax
    341d:	f7 e1                	mul    %ecx
    341f:	89 f0                	mov    %esi,%eax
    3421:	c1 ea 03             	shr    $0x3,%edx
    3424:	83 c2 30             	add    $0x30,%edx
    3427:	88 55 ab             	mov    %dl,-0x55(%ebp)
    342a:	f7 e1                	mul    %ecx
    342c:	89 f0                	mov    %esi,%eax
    342e:	c1 ea 03             	shr    $0x3,%edx
    3431:	8d 14 92             	lea    (%edx,%edx,4),%edx
    3434:	01 d2                	add    %edx,%edx
    3436:	29 d0                	sub    %edx,%eax
    3438:	83 c0 30             	add    $0x30,%eax
    343b:	88 45 ac             	mov    %al,-0x54(%ebp)
    343e:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3441:	50                   	push   %eax
    3442:	68 18 4d 00 00       	push   $0x4d18
    3447:	6a 01                	push   $0x1
    3449:	e8 32 06 00 00       	call   3a80 <printf>
    344e:	58                   	pop    %eax
    344f:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3452:	5a                   	pop    %edx
    3453:	68 02 02 00 00       	push   $0x202
    3458:	50                   	push   %eax
    3459:	e8 b5 04 00 00       	call   3913 <open>
    345e:	83 c4 10             	add    $0x10,%esp
    3461:	89 c7                	mov    %eax,%edi
    3463:	85 c0                	test   %eax,%eax
    3465:	78 4f                	js     34b6 <fsfull+0x106>
    3467:	31 db                	xor    %ebx,%ebx
    3469:	eb 07                	jmp    3472 <fsfull+0xc2>
    346b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    346f:	90                   	nop
    3470:	01 c3                	add    %eax,%ebx
    3472:	83 ec 04             	sub    $0x4,%esp
    3475:	68 00 02 00 00       	push   $0x200
    347a:	68 e0 85 00 00       	push   $0x85e0
    347f:	57                   	push   %edi
    3480:	e8 6e 04 00 00       	call   38f3 <write>
    3485:	83 c4 10             	add    $0x10,%esp
    3488:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    348d:	7f e1                	jg     3470 <fsfull+0xc0>
    348f:	83 ec 04             	sub    $0x4,%esp
    3492:	53                   	push   %ebx
    3493:	68 34 4d 00 00       	push   $0x4d34
    3498:	6a 01                	push   $0x1
    349a:	e8 e1 05 00 00       	call   3a80 <printf>
    349f:	89 3c 24             	mov    %edi,(%esp)
    34a2:	e8 54 04 00 00       	call   38fb <close>
    34a7:	83 c4 10             	add    $0x10,%esp
    34aa:	85 db                	test   %ebx,%ebx
    34ac:	74 1e                	je     34cc <fsfull+0x11c>
    34ae:	83 c6 01             	add    $0x1,%esi
    34b1:	e9 1a ff ff ff       	jmp    33d0 <fsfull+0x20>
    34b6:	83 ec 04             	sub    $0x4,%esp
    34b9:	8d 45 a8             	lea    -0x58(%ebp),%eax
    34bc:	50                   	push   %eax
    34bd:	68 24 4d 00 00       	push   $0x4d24
    34c2:	6a 01                	push   $0x1
    34c4:	e8 b7 05 00 00       	call   3a80 <printf>
    34c9:	83 c4 10             	add    $0x10,%esp
    34cc:	bf d3 4d 62 10       	mov    $0x10624dd3,%edi
    34d1:	bb 1f 85 eb 51       	mov    $0x51eb851f,%ebx
    34d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    34dd:	8d 76 00             	lea    0x0(%esi),%esi
    34e0:	89 f0                	mov    %esi,%eax
    34e2:	83 ec 0c             	sub    $0xc,%esp
    34e5:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    34e9:	f7 e7                	mul    %edi
    34eb:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    34ef:	c1 ea 06             	shr    $0x6,%edx
    34f2:	8d 42 30             	lea    0x30(%edx),%eax
    34f5:	88 45 a9             	mov    %al,-0x57(%ebp)
    34f8:	69 c2 e8 03 00 00    	imul   $0x3e8,%edx,%eax
    34fe:	89 f2                	mov    %esi,%edx
    3500:	29 c2                	sub    %eax,%edx
    3502:	89 d0                	mov    %edx,%eax
    3504:	f7 e3                	mul    %ebx
    3506:	89 f0                	mov    %esi,%eax
    3508:	c1 ea 05             	shr    $0x5,%edx
    350b:	83 c2 30             	add    $0x30,%edx
    350e:	88 55 aa             	mov    %dl,-0x56(%ebp)
    3511:	f7 e3                	mul    %ebx
    3513:	c1 ea 05             	shr    $0x5,%edx
    3516:	6b ca 64             	imul   $0x64,%edx,%ecx
    3519:	89 f2                	mov    %esi,%edx
    351b:	29 ca                	sub    %ecx,%edx
    351d:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    3522:	89 d0                	mov    %edx,%eax
    3524:	f7 e1                	mul    %ecx
    3526:	89 f0                	mov    %esi,%eax
    3528:	c1 ea 03             	shr    $0x3,%edx
    352b:	83 c2 30             	add    $0x30,%edx
    352e:	88 55 ab             	mov    %dl,-0x55(%ebp)
    3531:	f7 e1                	mul    %ecx
    3533:	89 f0                	mov    %esi,%eax
    3535:	83 ee 01             	sub    $0x1,%esi
    3538:	c1 ea 03             	shr    $0x3,%edx
    353b:	8d 14 92             	lea    (%edx,%edx,4),%edx
    353e:	01 d2                	add    %edx,%edx
    3540:	29 d0                	sub    %edx,%eax
    3542:	83 c0 30             	add    $0x30,%eax
    3545:	88 45 ac             	mov    %al,-0x54(%ebp)
    3548:	8d 45 a8             	lea    -0x58(%ebp),%eax
    354b:	50                   	push   %eax
    354c:	e8 d2 03 00 00       	call   3923 <unlink>
    3551:	83 c4 10             	add    $0x10,%esp
    3554:	83 fe ff             	cmp    $0xffffffff,%esi
    3557:	75 87                	jne    34e0 <fsfull+0x130>
    3559:	83 ec 08             	sub    $0x8,%esp
    355c:	68 44 4d 00 00       	push   $0x4d44
    3561:	6a 01                	push   $0x1
    3563:	e8 18 05 00 00       	call   3a80 <printf>
    3568:	83 c4 10             	add    $0x10,%esp
    356b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    356e:	5b                   	pop    %ebx
    356f:	5e                   	pop    %esi
    3570:	5f                   	pop    %edi
    3571:	5d                   	pop    %ebp
    3572:	c3                   	ret    
    3573:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    357a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00003580 <uio>:
    3580:	55                   	push   %ebp
    3581:	89 e5                	mov    %esp,%ebp
    3583:	83 ec 10             	sub    $0x10,%esp
    3586:	68 5a 4d 00 00       	push   $0x4d5a
    358b:	6a 01                	push   $0x1
    358d:	e8 ee 04 00 00       	call   3a80 <printf>
    3592:	e8 34 03 00 00       	call   38cb <fork>
    3597:	83 c4 10             	add    $0x10,%esp
    359a:	85 c0                	test   %eax,%eax
    359c:	74 1b                	je     35b9 <uio+0x39>
    359e:	78 3d                	js     35dd <uio+0x5d>
    35a0:	e8 36 03 00 00       	call   38db <wait>
    35a5:	83 ec 08             	sub    $0x8,%esp
    35a8:	68 64 4d 00 00       	push   $0x4d64
    35ad:	6a 01                	push   $0x1
    35af:	e8 cc 04 00 00       	call   3a80 <printf>
    35b4:	83 c4 10             	add    $0x10,%esp
    35b7:	c9                   	leave  
    35b8:	c3                   	ret    
    35b9:	b8 09 00 00 00       	mov    $0x9,%eax
    35be:	ba 70 00 00 00       	mov    $0x70,%edx
    35c3:	ee                   	out    %al,(%dx)
    35c4:	ba 71 00 00 00       	mov    $0x71,%edx
    35c9:	ec                   	in     (%dx),%al
    35ca:	52                   	push   %edx
    35cb:	52                   	push   %edx
    35cc:	68 f0 54 00 00       	push   $0x54f0
    35d1:	6a 01                	push   $0x1
    35d3:	e8 a8 04 00 00       	call   3a80 <printf>
    35d8:	e8 f6 02 00 00       	call   38d3 <exit>
    35dd:	50                   	push   %eax
    35de:	50                   	push   %eax
    35df:	68 e9 4c 00 00       	push   $0x4ce9
    35e4:	6a 01                	push   $0x1
    35e6:	e8 95 04 00 00       	call   3a80 <printf>
    35eb:	e8 e3 02 00 00       	call   38d3 <exit>

000035f0 <argptest>:
    35f0:	55                   	push   %ebp
    35f1:	89 e5                	mov    %esp,%ebp
    35f3:	53                   	push   %ebx
    35f4:	83 ec 0c             	sub    $0xc,%esp
    35f7:	6a 00                	push   $0x0
    35f9:	68 73 4d 00 00       	push   $0x4d73
    35fe:	e8 10 03 00 00       	call   3913 <open>
    3603:	83 c4 10             	add    $0x10,%esp
    3606:	85 c0                	test   %eax,%eax
    3608:	78 39                	js     3643 <argptest+0x53>
    360a:	83 ec 0c             	sub    $0xc,%esp
    360d:	89 c3                	mov    %eax,%ebx
    360f:	6a 00                	push   $0x0
    3611:	e8 45 03 00 00       	call   395b <sbrk>
    3616:	83 c4 0c             	add    $0xc,%esp
    3619:	83 e8 01             	sub    $0x1,%eax
    361c:	6a ff                	push   $0xffffffff
    361e:	50                   	push   %eax
    361f:	53                   	push   %ebx
    3620:	e8 c6 02 00 00       	call   38eb <read>
    3625:	89 1c 24             	mov    %ebx,(%esp)
    3628:	e8 ce 02 00 00       	call   38fb <close>
    362d:	58                   	pop    %eax
    362e:	5a                   	pop    %edx
    362f:	68 85 4d 00 00       	push   $0x4d85
    3634:	6a 01                	push   $0x1
    3636:	e8 45 04 00 00       	call   3a80 <printf>
    363b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    363e:	83 c4 10             	add    $0x10,%esp
    3641:	c9                   	leave  
    3642:	c3                   	ret    
    3643:	51                   	push   %ecx
    3644:	51                   	push   %ecx
    3645:	68 78 4d 00 00       	push   $0x4d78
    364a:	6a 02                	push   $0x2
    364c:	e8 2f 04 00 00       	call   3a80 <printf>
    3651:	e8 7d 02 00 00       	call   38d3 <exit>
    3656:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    365d:	8d 76 00             	lea    0x0(%esi),%esi

00003660 <rand>:
    3660:	69 05 94 5e 00 00 0d 	imul   $0x19660d,0x5e94,%eax
    3667:	66 19 00 
    366a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    366f:	a3 94 5e 00 00       	mov    %eax,0x5e94
    3674:	c3                   	ret    
    3675:	66 90                	xchg   %ax,%ax
    3677:	66 90                	xchg   %ax,%ax
    3679:	66 90                	xchg   %ax,%ax
    367b:	66 90                	xchg   %ax,%ax
    367d:	66 90                	xchg   %ax,%ax
    367f:	90                   	nop

00003680 <strcpy>:
    3680:	55                   	push   %ebp
    3681:	31 c0                	xor    %eax,%eax
    3683:	89 e5                	mov    %esp,%ebp
    3685:	53                   	push   %ebx
    3686:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3689:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    368c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3690:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    3694:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    3697:	83 c0 01             	add    $0x1,%eax
    369a:	84 d2                	test   %dl,%dl
    369c:	75 f2                	jne    3690 <strcpy+0x10>
    369e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    36a1:	89 c8                	mov    %ecx,%eax
    36a3:	c9                   	leave  
    36a4:	c3                   	ret    
    36a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    36ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000036b0 <strcmp>:
    36b0:	55                   	push   %ebp
    36b1:	89 e5                	mov    %esp,%ebp
    36b3:	53                   	push   %ebx
    36b4:	8b 55 08             	mov    0x8(%ebp),%edx
    36b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    36ba:	0f b6 02             	movzbl (%edx),%eax
    36bd:	84 c0                	test   %al,%al
    36bf:	75 17                	jne    36d8 <strcmp+0x28>
    36c1:	eb 3a                	jmp    36fd <strcmp+0x4d>
    36c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    36c7:	90                   	nop
    36c8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    36cc:	83 c2 01             	add    $0x1,%edx
    36cf:	8d 59 01             	lea    0x1(%ecx),%ebx
    36d2:	84 c0                	test   %al,%al
    36d4:	74 1a                	je     36f0 <strcmp+0x40>
    36d6:	89 d9                	mov    %ebx,%ecx
    36d8:	0f b6 19             	movzbl (%ecx),%ebx
    36db:	38 c3                	cmp    %al,%bl
    36dd:	74 e9                	je     36c8 <strcmp+0x18>
    36df:	29 d8                	sub    %ebx,%eax
    36e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    36e4:	c9                   	leave  
    36e5:	c3                   	ret    
    36e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    36ed:	8d 76 00             	lea    0x0(%esi),%esi
    36f0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    36f4:	31 c0                	xor    %eax,%eax
    36f6:	29 d8                	sub    %ebx,%eax
    36f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    36fb:	c9                   	leave  
    36fc:	c3                   	ret    
    36fd:	0f b6 19             	movzbl (%ecx),%ebx
    3700:	31 c0                	xor    %eax,%eax
    3702:	eb db                	jmp    36df <strcmp+0x2f>
    3704:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    370b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    370f:	90                   	nop

00003710 <strlen>:
    3710:	55                   	push   %ebp
    3711:	89 e5                	mov    %esp,%ebp
    3713:	8b 55 08             	mov    0x8(%ebp),%edx
    3716:	80 3a 00             	cmpb   $0x0,(%edx)
    3719:	74 15                	je     3730 <strlen+0x20>
    371b:	31 c0                	xor    %eax,%eax
    371d:	8d 76 00             	lea    0x0(%esi),%esi
    3720:	83 c0 01             	add    $0x1,%eax
    3723:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    3727:	89 c1                	mov    %eax,%ecx
    3729:	75 f5                	jne    3720 <strlen+0x10>
    372b:	89 c8                	mov    %ecx,%eax
    372d:	5d                   	pop    %ebp
    372e:	c3                   	ret    
    372f:	90                   	nop
    3730:	31 c9                	xor    %ecx,%ecx
    3732:	5d                   	pop    %ebp
    3733:	89 c8                	mov    %ecx,%eax
    3735:	c3                   	ret    
    3736:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    373d:	8d 76 00             	lea    0x0(%esi),%esi

00003740 <memset>:
    3740:	55                   	push   %ebp
    3741:	89 e5                	mov    %esp,%ebp
    3743:	57                   	push   %edi
    3744:	8b 55 08             	mov    0x8(%ebp),%edx
    3747:	8b 4d 10             	mov    0x10(%ebp),%ecx
    374a:	8b 45 0c             	mov    0xc(%ebp),%eax
    374d:	89 d7                	mov    %edx,%edi
    374f:	fc                   	cld    
    3750:	f3 aa                	rep stos %al,%es:(%edi)
    3752:	8b 7d fc             	mov    -0x4(%ebp),%edi
    3755:	89 d0                	mov    %edx,%eax
    3757:	c9                   	leave  
    3758:	c3                   	ret    
    3759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003760 <strchr>:
    3760:	55                   	push   %ebp
    3761:	89 e5                	mov    %esp,%ebp
    3763:	8b 45 08             	mov    0x8(%ebp),%eax
    3766:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
    376a:	0f b6 10             	movzbl (%eax),%edx
    376d:	84 d2                	test   %dl,%dl
    376f:	75 12                	jne    3783 <strchr+0x23>
    3771:	eb 1d                	jmp    3790 <strchr+0x30>
    3773:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3777:	90                   	nop
    3778:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    377c:	83 c0 01             	add    $0x1,%eax
    377f:	84 d2                	test   %dl,%dl
    3781:	74 0d                	je     3790 <strchr+0x30>
    3783:	38 d1                	cmp    %dl,%cl
    3785:	75 f1                	jne    3778 <strchr+0x18>
    3787:	5d                   	pop    %ebp
    3788:	c3                   	ret    
    3789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3790:	31 c0                	xor    %eax,%eax
    3792:	5d                   	pop    %ebp
    3793:	c3                   	ret    
    3794:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    379b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    379f:	90                   	nop

000037a0 <gets>:
    37a0:	55                   	push   %ebp
    37a1:	89 e5                	mov    %esp,%ebp
    37a3:	57                   	push   %edi
    37a4:	56                   	push   %esi
    37a5:	8d 7d e7             	lea    -0x19(%ebp),%edi
    37a8:	53                   	push   %ebx
    37a9:	31 db                	xor    %ebx,%ebx
    37ab:	83 ec 1c             	sub    $0x1c,%esp
    37ae:	eb 27                	jmp    37d7 <gets+0x37>
    37b0:	83 ec 04             	sub    $0x4,%esp
    37b3:	6a 01                	push   $0x1
    37b5:	57                   	push   %edi
    37b6:	6a 00                	push   $0x0
    37b8:	e8 2e 01 00 00       	call   38eb <read>
    37bd:	83 c4 10             	add    $0x10,%esp
    37c0:	85 c0                	test   %eax,%eax
    37c2:	7e 1d                	jle    37e1 <gets+0x41>
    37c4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    37c8:	8b 55 08             	mov    0x8(%ebp),%edx
    37cb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    37cf:	3c 0a                	cmp    $0xa,%al
    37d1:	74 1d                	je     37f0 <gets+0x50>
    37d3:	3c 0d                	cmp    $0xd,%al
    37d5:	74 19                	je     37f0 <gets+0x50>
    37d7:	89 de                	mov    %ebx,%esi
    37d9:	83 c3 01             	add    $0x1,%ebx
    37dc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    37df:	7c cf                	jl     37b0 <gets+0x10>
    37e1:	8b 45 08             	mov    0x8(%ebp),%eax
    37e4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
    37e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    37eb:	5b                   	pop    %ebx
    37ec:	5e                   	pop    %esi
    37ed:	5f                   	pop    %edi
    37ee:	5d                   	pop    %ebp
    37ef:	c3                   	ret    
    37f0:	8b 45 08             	mov    0x8(%ebp),%eax
    37f3:	89 de                	mov    %ebx,%esi
    37f5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
    37f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    37fc:	5b                   	pop    %ebx
    37fd:	5e                   	pop    %esi
    37fe:	5f                   	pop    %edi
    37ff:	5d                   	pop    %ebp
    3800:	c3                   	ret    
    3801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3808:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    380f:	90                   	nop

00003810 <stat>:
    3810:	55                   	push   %ebp
    3811:	89 e5                	mov    %esp,%ebp
    3813:	56                   	push   %esi
    3814:	53                   	push   %ebx
    3815:	83 ec 08             	sub    $0x8,%esp
    3818:	6a 00                	push   $0x0
    381a:	ff 75 08             	push   0x8(%ebp)
    381d:	e8 f1 00 00 00       	call   3913 <open>
    3822:	83 c4 10             	add    $0x10,%esp
    3825:	85 c0                	test   %eax,%eax
    3827:	78 27                	js     3850 <stat+0x40>
    3829:	83 ec 08             	sub    $0x8,%esp
    382c:	ff 75 0c             	push   0xc(%ebp)
    382f:	89 c3                	mov    %eax,%ebx
    3831:	50                   	push   %eax
    3832:	e8 f4 00 00 00       	call   392b <fstat>
    3837:	89 1c 24             	mov    %ebx,(%esp)
    383a:	89 c6                	mov    %eax,%esi
    383c:	e8 ba 00 00 00       	call   38fb <close>
    3841:	83 c4 10             	add    $0x10,%esp
    3844:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3847:	89 f0                	mov    %esi,%eax
    3849:	5b                   	pop    %ebx
    384a:	5e                   	pop    %esi
    384b:	5d                   	pop    %ebp
    384c:	c3                   	ret    
    384d:	8d 76 00             	lea    0x0(%esi),%esi
    3850:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3855:	eb ed                	jmp    3844 <stat+0x34>
    3857:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    385e:	66 90                	xchg   %ax,%ax

00003860 <atoi>:
    3860:	55                   	push   %ebp
    3861:	89 e5                	mov    %esp,%ebp
    3863:	53                   	push   %ebx
    3864:	8b 55 08             	mov    0x8(%ebp),%edx
    3867:	0f be 02             	movsbl (%edx),%eax
    386a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    386d:	80 f9 09             	cmp    $0x9,%cl
    3870:	b9 00 00 00 00       	mov    $0x0,%ecx
    3875:	77 1e                	ja     3895 <atoi+0x35>
    3877:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    387e:	66 90                	xchg   %ax,%ax
    3880:	83 c2 01             	add    $0x1,%edx
    3883:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    3886:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
    388a:	0f be 02             	movsbl (%edx),%eax
    388d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    3890:	80 fb 09             	cmp    $0x9,%bl
    3893:	76 eb                	jbe    3880 <atoi+0x20>
    3895:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3898:	89 c8                	mov    %ecx,%eax
    389a:	c9                   	leave  
    389b:	c3                   	ret    
    389c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000038a0 <memmove>:
    38a0:	55                   	push   %ebp
    38a1:	89 e5                	mov    %esp,%ebp
    38a3:	57                   	push   %edi
    38a4:	8b 45 10             	mov    0x10(%ebp),%eax
    38a7:	8b 55 08             	mov    0x8(%ebp),%edx
    38aa:	56                   	push   %esi
    38ab:	8b 75 0c             	mov    0xc(%ebp),%esi
    38ae:	85 c0                	test   %eax,%eax
    38b0:	7e 13                	jle    38c5 <memmove+0x25>
    38b2:	01 d0                	add    %edx,%eax
    38b4:	89 d7                	mov    %edx,%edi
    38b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    38bd:	8d 76 00             	lea    0x0(%esi),%esi
    38c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    38c1:	39 f8                	cmp    %edi,%eax
    38c3:	75 fb                	jne    38c0 <memmove+0x20>
    38c5:	5e                   	pop    %esi
    38c6:	89 d0                	mov    %edx,%eax
    38c8:	5f                   	pop    %edi
    38c9:	5d                   	pop    %ebp
    38ca:	c3                   	ret    

000038cb <fork>:
    38cb:	b8 01 00 00 00       	mov    $0x1,%eax
    38d0:	cd 40                	int    $0x40
    38d2:	c3                   	ret    

000038d3 <exit>:
    38d3:	b8 02 00 00 00       	mov    $0x2,%eax
    38d8:	cd 40                	int    $0x40
    38da:	c3                   	ret    

000038db <wait>:
    38db:	b8 03 00 00 00       	mov    $0x3,%eax
    38e0:	cd 40                	int    $0x40
    38e2:	c3                   	ret    

000038e3 <pipe>:
    38e3:	b8 04 00 00 00       	mov    $0x4,%eax
    38e8:	cd 40                	int    $0x40
    38ea:	c3                   	ret    

000038eb <read>:
    38eb:	b8 05 00 00 00       	mov    $0x5,%eax
    38f0:	cd 40                	int    $0x40
    38f2:	c3                   	ret    

000038f3 <write>:
    38f3:	b8 10 00 00 00       	mov    $0x10,%eax
    38f8:	cd 40                	int    $0x40
    38fa:	c3                   	ret    

000038fb <close>:
    38fb:	b8 15 00 00 00       	mov    $0x15,%eax
    3900:	cd 40                	int    $0x40
    3902:	c3                   	ret    

00003903 <kill>:
    3903:	b8 06 00 00 00       	mov    $0x6,%eax
    3908:	cd 40                	int    $0x40
    390a:	c3                   	ret    

0000390b <exec>:
    390b:	b8 07 00 00 00       	mov    $0x7,%eax
    3910:	cd 40                	int    $0x40
    3912:	c3                   	ret    

00003913 <open>:
    3913:	b8 0f 00 00 00       	mov    $0xf,%eax
    3918:	cd 40                	int    $0x40
    391a:	c3                   	ret    

0000391b <mknod>:
    391b:	b8 11 00 00 00       	mov    $0x11,%eax
    3920:	cd 40                	int    $0x40
    3922:	c3                   	ret    

00003923 <unlink>:
    3923:	b8 12 00 00 00       	mov    $0x12,%eax
    3928:	cd 40                	int    $0x40
    392a:	c3                   	ret    

0000392b <fstat>:
    392b:	b8 08 00 00 00       	mov    $0x8,%eax
    3930:	cd 40                	int    $0x40
    3932:	c3                   	ret    

00003933 <link>:
    3933:	b8 13 00 00 00       	mov    $0x13,%eax
    3938:	cd 40                	int    $0x40
    393a:	c3                   	ret    

0000393b <mkdir>:
    393b:	b8 14 00 00 00       	mov    $0x14,%eax
    3940:	cd 40                	int    $0x40
    3942:	c3                   	ret    

00003943 <chdir>:
    3943:	b8 09 00 00 00       	mov    $0x9,%eax
    3948:	cd 40                	int    $0x40
    394a:	c3                   	ret    

0000394b <dup>:
    394b:	b8 0a 00 00 00       	mov    $0xa,%eax
    3950:	cd 40                	int    $0x40
    3952:	c3                   	ret    

00003953 <getpid>:
    3953:	b8 0b 00 00 00       	mov    $0xb,%eax
    3958:	cd 40                	int    $0x40
    395a:	c3                   	ret    

0000395b <sbrk>:
    395b:	b8 0c 00 00 00       	mov    $0xc,%eax
    3960:	cd 40                	int    $0x40
    3962:	c3                   	ret    

00003963 <sleep>:
    3963:	b8 0d 00 00 00       	mov    $0xd,%eax
    3968:	cd 40                	int    $0x40
    396a:	c3                   	ret    

0000396b <uptime>:
    396b:	b8 0e 00 00 00       	mov    $0xe,%eax
    3970:	cd 40                	int    $0x40
    3972:	c3                   	ret    

00003973 <calculate_sum_of_digits>:
    3973:	b8 16 00 00 00       	mov    $0x16,%eax
    3978:	cd 40                	int    $0x40
    397a:	c3                   	ret    

0000397b <get_parent_pid>:
    397b:	b8 17 00 00 00       	mov    $0x17,%eax
    3980:	cd 40                	int    $0x40
    3982:	c3                   	ret    

00003983 <get_file_sectors>:
    3983:	b8 18 00 00 00       	mov    $0x18,%eax
    3988:	cd 40                	int    $0x40
    398a:	c3                   	ret    

0000398b <set_process_parent>:
    398b:	b8 19 00 00 00       	mov    $0x19,%eax
    3990:	cd 40                	int    $0x40
    3992:	c3                   	ret    

00003993 <change_process_queue>:
    3993:	b8 1a 00 00 00       	mov    $0x1a,%eax
    3998:	cd 40                	int    $0x40
    399a:	c3                   	ret    

0000399b <set_hrrn_priority>:
    399b:	b8 1b 00 00 00       	mov    $0x1b,%eax
    39a0:	cd 40                	int    $0x40
    39a2:	c3                   	ret    

000039a3 <set_ptable_hrrn_priority>:
    39a3:	b8 1c 00 00 00       	mov    $0x1c,%eax
    39a8:	cd 40                	int    $0x40
    39aa:	c3                   	ret    

000039ab <print_processes>:
    39ab:	b8 1d 00 00 00       	mov    $0x1d,%eax
    39b0:	cd 40                	int    $0x40
    39b2:	c3                   	ret    

000039b3 <sem_init>:
    39b3:	b8 1e 00 00 00       	mov    $0x1e,%eax
    39b8:	cd 40                	int    $0x40
    39ba:	c3                   	ret    

000039bb <sem_acquire>:
    39bb:	b8 1f 00 00 00       	mov    $0x1f,%eax
    39c0:	cd 40                	int    $0x40
    39c2:	c3                   	ret    

000039c3 <sem_release>:
    39c3:	b8 20 00 00 00       	mov    $0x20,%eax
    39c8:	cd 40                	int    $0x40
    39ca:	c3                   	ret    
    39cb:	66 90                	xchg   %ax,%ax
    39cd:	66 90                	xchg   %ax,%ax
    39cf:	90                   	nop

000039d0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    39d0:	55                   	push   %ebp
    39d1:	89 e5                	mov    %esp,%ebp
    39d3:	57                   	push   %edi
    39d4:	56                   	push   %esi
    39d5:	53                   	push   %ebx
    39d6:	83 ec 3c             	sub    $0x3c,%esp
    39d9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    39dc:	89 d1                	mov    %edx,%ecx
{
    39de:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    39e1:	85 d2                	test   %edx,%edx
    39e3:	0f 89 7f 00 00 00    	jns    3a68 <printint+0x98>
    39e9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    39ed:	74 79                	je     3a68 <printint+0x98>
    neg = 1;
    39ef:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    39f6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    39f8:	31 db                	xor    %ebx,%ebx
    39fa:	8d 75 d7             	lea    -0x29(%ebp),%esi
    39fd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    3a00:	89 c8                	mov    %ecx,%eax
    3a02:	31 d2                	xor    %edx,%edx
    3a04:	89 cf                	mov    %ecx,%edi
    3a06:	f7 75 c4             	divl   -0x3c(%ebp)
    3a09:	0f b6 92 a0 55 00 00 	movzbl 0x55a0(%edx),%edx
    3a10:	89 45 c0             	mov    %eax,-0x40(%ebp)
    3a13:	89 d8                	mov    %ebx,%eax
    3a15:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    3a18:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    3a1b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    3a1e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    3a21:	76 dd                	jbe    3a00 <printint+0x30>
  if(neg)
    3a23:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    3a26:	85 c9                	test   %ecx,%ecx
    3a28:	74 0c                	je     3a36 <printint+0x66>
    buf[i++] = '-';
    3a2a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    3a2f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    3a31:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    3a36:	8b 7d b8             	mov    -0x48(%ebp),%edi
    3a39:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    3a3d:	eb 07                	jmp    3a46 <printint+0x76>
    3a3f:	90                   	nop
    putc(fd, buf[i]);
    3a40:	0f b6 13             	movzbl (%ebx),%edx
    3a43:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    3a46:	83 ec 04             	sub    $0x4,%esp
    3a49:	88 55 d7             	mov    %dl,-0x29(%ebp)
    3a4c:	6a 01                	push   $0x1
    3a4e:	56                   	push   %esi
    3a4f:	57                   	push   %edi
    3a50:	e8 9e fe ff ff       	call   38f3 <write>
  while(--i >= 0)
    3a55:	83 c4 10             	add    $0x10,%esp
    3a58:	39 de                	cmp    %ebx,%esi
    3a5a:	75 e4                	jne    3a40 <printint+0x70>
}
    3a5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3a5f:	5b                   	pop    %ebx
    3a60:	5e                   	pop    %esi
    3a61:	5f                   	pop    %edi
    3a62:	5d                   	pop    %ebp
    3a63:	c3                   	ret    
    3a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    3a68:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    3a6f:	eb 87                	jmp    39f8 <printint+0x28>
    3a71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3a78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3a7f:	90                   	nop

00003a80 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3a80:	55                   	push   %ebp
    3a81:	89 e5                	mov    %esp,%ebp
    3a83:	57                   	push   %edi
    3a84:	56                   	push   %esi
    3a85:	53                   	push   %ebx
    3a86:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3a89:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
    3a8c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
    3a8f:	0f b6 13             	movzbl (%ebx),%edx
    3a92:	84 d2                	test   %dl,%dl
    3a94:	74 6a                	je     3b00 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
    3a96:	8d 45 10             	lea    0x10(%ebp),%eax
    3a99:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    3a9c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    3a9f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
    3aa1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3aa4:	eb 36                	jmp    3adc <printf+0x5c>
    3aa6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3aad:	8d 76 00             	lea    0x0(%esi),%esi
    3ab0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3ab3:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
    3ab8:	83 f8 25             	cmp    $0x25,%eax
    3abb:	74 15                	je     3ad2 <printf+0x52>
  write(fd, &c, 1);
    3abd:	83 ec 04             	sub    $0x4,%esp
    3ac0:	88 55 e7             	mov    %dl,-0x19(%ebp)
    3ac3:	6a 01                	push   $0x1
    3ac5:	57                   	push   %edi
    3ac6:	56                   	push   %esi
    3ac7:	e8 27 fe ff ff       	call   38f3 <write>
    3acc:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
    3acf:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3ad2:	0f b6 13             	movzbl (%ebx),%edx
    3ad5:	83 c3 01             	add    $0x1,%ebx
    3ad8:	84 d2                	test   %dl,%dl
    3ada:	74 24                	je     3b00 <printf+0x80>
    c = fmt[i] & 0xff;
    3adc:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    3adf:	85 c9                	test   %ecx,%ecx
    3ae1:	74 cd                	je     3ab0 <printf+0x30>
      }
    } else if(state == '%'){
    3ae3:	83 f9 25             	cmp    $0x25,%ecx
    3ae6:	75 ea                	jne    3ad2 <printf+0x52>
      if(c == 'd'){
    3ae8:	83 f8 25             	cmp    $0x25,%eax
    3aeb:	0f 84 07 01 00 00    	je     3bf8 <printf+0x178>
    3af1:	83 e8 63             	sub    $0x63,%eax
    3af4:	83 f8 15             	cmp    $0x15,%eax
    3af7:	77 17                	ja     3b10 <printf+0x90>
    3af9:	ff 24 85 48 55 00 00 	jmp    *0x5548(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3b00:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3b03:	5b                   	pop    %ebx
    3b04:	5e                   	pop    %esi
    3b05:	5f                   	pop    %edi
    3b06:	5d                   	pop    %ebp
    3b07:	c3                   	ret    
    3b08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3b0f:	90                   	nop
  write(fd, &c, 1);
    3b10:	83 ec 04             	sub    $0x4,%esp
    3b13:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    3b16:	6a 01                	push   $0x1
    3b18:	57                   	push   %edi
    3b19:	56                   	push   %esi
    3b1a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    3b1e:	e8 d0 fd ff ff       	call   38f3 <write>
        putc(fd, c);
    3b23:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
    3b27:	83 c4 0c             	add    $0xc,%esp
    3b2a:	88 55 e7             	mov    %dl,-0x19(%ebp)
    3b2d:	6a 01                	push   $0x1
    3b2f:	57                   	push   %edi
    3b30:	56                   	push   %esi
    3b31:	e8 bd fd ff ff       	call   38f3 <write>
        putc(fd, c);
    3b36:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3b39:	31 c9                	xor    %ecx,%ecx
    3b3b:	eb 95                	jmp    3ad2 <printf+0x52>
    3b3d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    3b40:	83 ec 0c             	sub    $0xc,%esp
    3b43:	b9 10 00 00 00       	mov    $0x10,%ecx
    3b48:	6a 00                	push   $0x0
    3b4a:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3b4d:	8b 10                	mov    (%eax),%edx
    3b4f:	89 f0                	mov    %esi,%eax
    3b51:	e8 7a fe ff ff       	call   39d0 <printint>
        ap++;
    3b56:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    3b5a:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3b5d:	31 c9                	xor    %ecx,%ecx
    3b5f:	e9 6e ff ff ff       	jmp    3ad2 <printf+0x52>
    3b64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    3b68:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3b6b:	8b 10                	mov    (%eax),%edx
        ap++;
    3b6d:	83 c0 04             	add    $0x4,%eax
    3b70:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    3b73:	85 d2                	test   %edx,%edx
    3b75:	0f 84 8d 00 00 00    	je     3c08 <printf+0x188>
        while(*s != 0){
    3b7b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
    3b7e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
    3b80:	84 c0                	test   %al,%al
    3b82:	0f 84 4a ff ff ff    	je     3ad2 <printf+0x52>
    3b88:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    3b8b:	89 d3                	mov    %edx,%ebx
    3b8d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    3b90:	83 ec 04             	sub    $0x4,%esp
          s++;
    3b93:	83 c3 01             	add    $0x1,%ebx
    3b96:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3b99:	6a 01                	push   $0x1
    3b9b:	57                   	push   %edi
    3b9c:	56                   	push   %esi
    3b9d:	e8 51 fd ff ff       	call   38f3 <write>
        while(*s != 0){
    3ba2:	0f b6 03             	movzbl (%ebx),%eax
    3ba5:	83 c4 10             	add    $0x10,%esp
    3ba8:	84 c0                	test   %al,%al
    3baa:	75 e4                	jne    3b90 <printf+0x110>
      state = 0;
    3bac:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    3baf:	31 c9                	xor    %ecx,%ecx
    3bb1:	e9 1c ff ff ff       	jmp    3ad2 <printf+0x52>
    3bb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3bbd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    3bc0:	83 ec 0c             	sub    $0xc,%esp
    3bc3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3bc8:	6a 01                	push   $0x1
    3bca:	e9 7b ff ff ff       	jmp    3b4a <printf+0xca>
    3bcf:	90                   	nop
        putc(fd, *ap);
    3bd0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
    3bd3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    3bd6:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
    3bd8:	6a 01                	push   $0x1
    3bda:	57                   	push   %edi
    3bdb:	56                   	push   %esi
        putc(fd, *ap);
    3bdc:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3bdf:	e8 0f fd ff ff       	call   38f3 <write>
        ap++;
    3be4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    3be8:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3beb:	31 c9                	xor    %ecx,%ecx
    3bed:	e9 e0 fe ff ff       	jmp    3ad2 <printf+0x52>
    3bf2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
    3bf8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    3bfb:	83 ec 04             	sub    $0x4,%esp
    3bfe:	e9 2a ff ff ff       	jmp    3b2d <printf+0xad>
    3c03:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3c07:	90                   	nop
          s = "(null)";
    3c08:	ba 3e 55 00 00       	mov    $0x553e,%edx
        while(*s != 0){
    3c0d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    3c10:	b8 28 00 00 00       	mov    $0x28,%eax
    3c15:	89 d3                	mov    %edx,%ebx
    3c17:	e9 74 ff ff ff       	jmp    3b90 <printf+0x110>
    3c1c:	66 90                	xchg   %ax,%ax
    3c1e:	66 90                	xchg   %ax,%ax

00003c20 <free>:
    3c20:	55                   	push   %ebp
    3c21:	a1 60 a6 00 00       	mov    0xa660,%eax
    3c26:	89 e5                	mov    %esp,%ebp
    3c28:	57                   	push   %edi
    3c29:	56                   	push   %esi
    3c2a:	53                   	push   %ebx
    3c2b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3c2e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    3c31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3c38:	89 c2                	mov    %eax,%edx
    3c3a:	8b 00                	mov    (%eax),%eax
    3c3c:	39 ca                	cmp    %ecx,%edx
    3c3e:	73 30                	jae    3c70 <free+0x50>
    3c40:	39 c1                	cmp    %eax,%ecx
    3c42:	72 04                	jb     3c48 <free+0x28>
    3c44:	39 c2                	cmp    %eax,%edx
    3c46:	72 f0                	jb     3c38 <free+0x18>
    3c48:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3c4b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3c4e:	39 f8                	cmp    %edi,%eax
    3c50:	74 30                	je     3c82 <free+0x62>
    3c52:	89 43 f8             	mov    %eax,-0x8(%ebx)
    3c55:	8b 42 04             	mov    0x4(%edx),%eax
    3c58:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3c5b:	39 f1                	cmp    %esi,%ecx
    3c5d:	74 3a                	je     3c99 <free+0x79>
    3c5f:	89 0a                	mov    %ecx,(%edx)
    3c61:	5b                   	pop    %ebx
    3c62:	89 15 60 a6 00 00    	mov    %edx,0xa660
    3c68:	5e                   	pop    %esi
    3c69:	5f                   	pop    %edi
    3c6a:	5d                   	pop    %ebp
    3c6b:	c3                   	ret    
    3c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3c70:	39 c2                	cmp    %eax,%edx
    3c72:	72 c4                	jb     3c38 <free+0x18>
    3c74:	39 c1                	cmp    %eax,%ecx
    3c76:	73 c0                	jae    3c38 <free+0x18>
    3c78:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3c7b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3c7e:	39 f8                	cmp    %edi,%eax
    3c80:	75 d0                	jne    3c52 <free+0x32>
    3c82:	03 70 04             	add    0x4(%eax),%esi
    3c85:	89 73 fc             	mov    %esi,-0x4(%ebx)
    3c88:	8b 02                	mov    (%edx),%eax
    3c8a:	8b 00                	mov    (%eax),%eax
    3c8c:	89 43 f8             	mov    %eax,-0x8(%ebx)
    3c8f:	8b 42 04             	mov    0x4(%edx),%eax
    3c92:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3c95:	39 f1                	cmp    %esi,%ecx
    3c97:	75 c6                	jne    3c5f <free+0x3f>
    3c99:	03 43 fc             	add    -0x4(%ebx),%eax
    3c9c:	89 15 60 a6 00 00    	mov    %edx,0xa660
    3ca2:	89 42 04             	mov    %eax,0x4(%edx)
    3ca5:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    3ca8:	89 0a                	mov    %ecx,(%edx)
    3caa:	5b                   	pop    %ebx
    3cab:	5e                   	pop    %esi
    3cac:	5f                   	pop    %edi
    3cad:	5d                   	pop    %ebp
    3cae:	c3                   	ret    
    3caf:	90                   	nop

00003cb0 <malloc>:
    3cb0:	55                   	push   %ebp
    3cb1:	89 e5                	mov    %esp,%ebp
    3cb3:	57                   	push   %edi
    3cb4:	56                   	push   %esi
    3cb5:	53                   	push   %ebx
    3cb6:	83 ec 1c             	sub    $0x1c,%esp
    3cb9:	8b 45 08             	mov    0x8(%ebp),%eax
    3cbc:	8b 3d 60 a6 00 00    	mov    0xa660,%edi
    3cc2:	8d 70 07             	lea    0x7(%eax),%esi
    3cc5:	c1 ee 03             	shr    $0x3,%esi
    3cc8:	83 c6 01             	add    $0x1,%esi
    3ccb:	85 ff                	test   %edi,%edi
    3ccd:	0f 84 9d 00 00 00    	je     3d70 <malloc+0xc0>
    3cd3:	8b 17                	mov    (%edi),%edx
    3cd5:	8b 4a 04             	mov    0x4(%edx),%ecx
    3cd8:	39 f1                	cmp    %esi,%ecx
    3cda:	73 6a                	jae    3d46 <malloc+0x96>
    3cdc:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3ce1:	39 de                	cmp    %ebx,%esi
    3ce3:	0f 43 de             	cmovae %esi,%ebx
    3ce6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    3ced:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    3cf0:	eb 17                	jmp    3d09 <malloc+0x59>
    3cf2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3cf8:	8b 02                	mov    (%edx),%eax
    3cfa:	8b 48 04             	mov    0x4(%eax),%ecx
    3cfd:	39 f1                	cmp    %esi,%ecx
    3cff:	73 4f                	jae    3d50 <malloc+0xa0>
    3d01:	8b 3d 60 a6 00 00    	mov    0xa660,%edi
    3d07:	89 c2                	mov    %eax,%edx
    3d09:	39 d7                	cmp    %edx,%edi
    3d0b:	75 eb                	jne    3cf8 <malloc+0x48>
    3d0d:	83 ec 0c             	sub    $0xc,%esp
    3d10:	ff 75 e4             	push   -0x1c(%ebp)
    3d13:	e8 43 fc ff ff       	call   395b <sbrk>
    3d18:	83 c4 10             	add    $0x10,%esp
    3d1b:	83 f8 ff             	cmp    $0xffffffff,%eax
    3d1e:	74 1c                	je     3d3c <malloc+0x8c>
    3d20:	89 58 04             	mov    %ebx,0x4(%eax)
    3d23:	83 ec 0c             	sub    $0xc,%esp
    3d26:	83 c0 08             	add    $0x8,%eax
    3d29:	50                   	push   %eax
    3d2a:	e8 f1 fe ff ff       	call   3c20 <free>
    3d2f:	8b 15 60 a6 00 00    	mov    0xa660,%edx
    3d35:	83 c4 10             	add    $0x10,%esp
    3d38:	85 d2                	test   %edx,%edx
    3d3a:	75 bc                	jne    3cf8 <malloc+0x48>
    3d3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3d3f:	31 c0                	xor    %eax,%eax
    3d41:	5b                   	pop    %ebx
    3d42:	5e                   	pop    %esi
    3d43:	5f                   	pop    %edi
    3d44:	5d                   	pop    %ebp
    3d45:	c3                   	ret    
    3d46:	89 d0                	mov    %edx,%eax
    3d48:	89 fa                	mov    %edi,%edx
    3d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3d50:	39 ce                	cmp    %ecx,%esi
    3d52:	74 4c                	je     3da0 <malloc+0xf0>
    3d54:	29 f1                	sub    %esi,%ecx
    3d56:	89 48 04             	mov    %ecx,0x4(%eax)
    3d59:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
    3d5c:	89 70 04             	mov    %esi,0x4(%eax)
    3d5f:	89 15 60 a6 00 00    	mov    %edx,0xa660
    3d65:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3d68:	83 c0 08             	add    $0x8,%eax
    3d6b:	5b                   	pop    %ebx
    3d6c:	5e                   	pop    %esi
    3d6d:	5f                   	pop    %edi
    3d6e:	5d                   	pop    %ebp
    3d6f:	c3                   	ret    
    3d70:	c7 05 60 a6 00 00 64 	movl   $0xa664,0xa660
    3d77:	a6 00 00 
    3d7a:	bf 64 a6 00 00       	mov    $0xa664,%edi
    3d7f:	c7 05 64 a6 00 00 64 	movl   $0xa664,0xa664
    3d86:	a6 00 00 
    3d89:	89 fa                	mov    %edi,%edx
    3d8b:	c7 05 68 a6 00 00 00 	movl   $0x0,0xa668
    3d92:	00 00 00 
    3d95:	e9 42 ff ff ff       	jmp    3cdc <malloc+0x2c>
    3d9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3da0:	8b 08                	mov    (%eax),%ecx
    3da2:	89 0a                	mov    %ecx,(%edx)
    3da4:	eb b9                	jmp    3d5f <malloc+0xaf>
