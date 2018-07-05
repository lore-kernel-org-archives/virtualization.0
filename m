From: Dmitry Vyukov via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: Re: KASAN: stack-out-of-bounds Read in __netif_receive_skb_core
Date: Thu, 5 Jul 2018 18:18:18 +0200
Message-ID: <CACT4Y+aP5D67grd-Ca7+BKfGfu_MWJmDAa8cn1Pa7=zr-cY-GQ@mail.gmail.com>
References: <000000000000ea6148057039671d@google.com>
Reply-To: Dmitry Vyukov <dvyukov@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <000000000000ea6148057039671d@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: syzbot <syzbot+4e955f82549d361ed655@syzkaller.appspotmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev <netdev@vger.kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 5, 2018 at 6:59 AM, syzbot
<syzbot+4e955f82549d361ed655@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    2bdea157b999 Merge branch 'sctp-fully-support-for-dscp-and..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=178c5e68400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f62553dc846b0692
> dashboard link: https://syzkaller.appspot.com/bug?extid=4e955f82549d361ed655
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=15038ad0400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1465b670400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4e955f82549d361ed655@syzkaller.appspotmail.com

#syz dup: KASAN: stack-out-of-bounds Read in timerqueue_add

> ==================================================================
> BUG: KASAN: stack-out-of-bounds in __read_once_size
> include/linux/compiler.h:188 [inline]
> BUG: KASAN: stack-out-of-bounds in __netif_receive_skb_core+0x2e09/0x3680
> net/core/dev.c:4657
> Read of size 8 at addr ffff8801a852d1e8 by task swapper/0/0
>
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.18.0-rc3+ #45
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  __read_once_size include/linux/compiler.h:188 [inline]
>  __netif_receive_skb_core+0x2e09/0x3680 net/core/dev.c:4657
>  __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:4807
>  netif_receive_skb_internal+0x12e/0x680 net/core/dev.c:4881
>  napi_skb_finish net/core/dev.c:5270 [inline]
>  napi_gro_receive+0x465/0x5c0 net/core/dev.c:5301
>  receive_buf+0xc97/0x2bf0 drivers/net/virtio_net.c:996
>  virtnet_receive drivers/net/virtio_net.c:1252 [inline]
>  virtnet_poll+0x3d5/0xe3d drivers/net/virtio_net.c:1334
>  napi_poll net/core/dev.c:5926 [inline]
>  net_rx_action+0x7a5/0x1950 net/core/dev.c:5992
>  __do_softirq+0x2e8/0xb17 kernel/softirq.c:288
>  invoke_softirq kernel/softirq.c:368 [inline]
>  irq_exit+0x1d1/0x200 kernel/softirq.c:408
>  exiting_irq arch/x86/include/asm/apic.h:527 [inline]
>  do_IRQ+0xf1/0x190 arch/x86/kernel/irq.c:257
>  common_interrupt+0xf/0xf arch/x86/entry/entry_64.S:642
>  </IRQ>
> RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:54
> Code: c7 48 89 45 d8 e8 7a b1 25 fa 48 8b 45 d8 e9 d2 fe ff ff 48 89 df e8
> 69 b1 25 fa eb 8a 90 90 90 90 90 90 90 55 48 89 e5 fb f4 <5d> c3 0f 1f 84 00
> 00 00 00 00 55 48 89 e5 f4 5d c3 90 90 90 90 90
> RSP: 0018:ffffffff88e07bc0 EFLAGS: 00000282 ORIG_RAX: ffffffffffffffd9
> RAX: dffffc0000000000 RBX: 1ffffffff11c0f7b RCX: ffffffff81667982
> RDX: 1ffffffff11e3610 RSI: 0000000000000004 RDI: ffffffff88f1b080
> RBP: ffffffff88e07bc0 R08: ffffed003b5c46d7 R09: ffffed003b5c46d6
> R10: ffffed003b5c46d6 R11: ffff8801dae236b3 R12: 0000000000000000
> R13: ffffffff88e07c78 R14: ffffffff899ebe60 R15: 0000000000000000
>  arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
>  default_idle+0xc7/0x450 arch/x86/kernel/process.c:500
>  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:491
>  default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
>  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
>  do_idle+0x3aa/0x570 kernel/sched/idle.c:262
>  cpu_startup_entry+0x10c/0x120 kernel/sched/idle.c:368
>  rest_init+0xe1/0xe4 init/main.c:442
>  start_kernel+0x90e/0x949 init/main.c:738
>  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:452
>  x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:433
>  secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242
>
> Allocated by task 0:
> (stack is not available)
>
> Freed by task 0:
> (stack is not available)
>
> The buggy address belongs to the object at ffff8801a852ca80
>  which belongs to the cache kmalloc-2048 of size 2048
> The buggy address is located 1896 bytes inside of
>  2048-byte region [ffff8801a852ca80, ffff8801a852d280)
> The buggy address belongs to the page:
> page:ffffea0006a14b00 count:1 mapcount:0 mapping:ffff8801da800c40 index:0x0
> compound_mapcount: 0
> flags: 0x2fffc0000008100(slab|head)
> raw: 02fffc0000008100 ffffea0006c6bd08 ffffea0006c7f688 ffff8801da800c40
> raw: 0000000000000000 ffff8801a852c200 0000000100000003 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801a852d080: f2 f2 f2 f8 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 00
>  ffff8801a852d100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>
>> ffff8801a852d180: 00 00 00 00 f1 f1 f1 f1 00 f2 f2 f2 f2 f2 f2 f2
>
>                                                           ^
>  ffff8801a852d200: 00 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2 f2 f2 f2
>  ffff8801a852d280: f8 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 00 00 00 00
> ==================================================================
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000ea6148057039671d%40google.com.
> For more options, visit https://groups.google.com/d/optout.
