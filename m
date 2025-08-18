Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF91D2877ED
	for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503974; cv=none; b=S2Qz+lNCigoJZgZSuPi9JR2YdXHDvCrzVHkBFBCZebKFMYBTpRbvFaZMPtqH+N6Agl0bg+/9U45oW1t2ltQ5ENsFsVs27tgkeKw+oKn12N3O6P2J2rEyKwrxTceIctrra4ngvBWyP0sIfUhCoTMsRVOYjiR437+DWoppRWY8gDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503974; c=relaxed/simple;
	bh=/pqSSPndeW94Qw0Cfkt0F2CGstz9Z4x1ZQ9UDaUe6nw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LDxRTlMYOn8DGmlQLu3Wk6z9jkHyBfphjXtBlnSIF3PEiAEPF7Sjr8qQRRM182eHCYghVvtavMothbbMU4uNCrrD3VasawT9Q09JXWpfywCcef0rtDsPCJVjPFv6HosvHr/n1nTiAQqXk+hxL01fCkCIUcFoAxDlSoaCMPoxAGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-88432d9d5c1so389698439f.1
        for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 00:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755503972; x=1756108772;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7BSYpuBDwucpyaMQl070i2SR5XklPKyoMcgXiBMplEo=;
        b=gslIMr1NUAxCnwCK/vQRpjdyXTVAqXr1JXcgQPvU2F2djWwTTYvCmjUWTqk00RiAs8
         o6Ck8ATxrPom3a2rVp7wpmakrxoOifa4Vvjg/WEBfb4kCNlThA2PSpXwyfcv8gVJjmTe
         YnoD3tg5NjXIcwzXws27BPeg7kfzTFKlQzwuYVTMOxXI+rNONvecB+s793Pq2/ChinkZ
         MJh20zHt6F1RdWmsGHyPdTJ8ceDJDF2UORgqx5U6AD6neqnrf6S6neleZHuaYZjzTaH/
         RcaD267KHG9KxEPR5dmZaA1MqSqkUtfbgksssYb5w40V9q0cvQJrUGRlWNO9lY86tZBc
         0fpw==
X-Forwarded-Encrypted: i=1; AJvYcCWnO/sGc5FUyHtdq5kNuLwurqwklxyokvA6WvwHCzXL2BfHoqCBpPt6+LD3flHAjiLWSTSoEFIG1VavPvMyCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywj5jghxmFG/XtRCYwgM/WOGkZgUXXXrxAP6WAfJKhD0X9wpH3j
	lFUrJyXvq+4C8n2TCoVlWEkeMBBGgcWnuqOPgbNuxsyTqUxlSR9q8GlxaUSfe/blB/aCXYpXkNF
	R9ZQyG/QZv3bh27//2E8gHCOaFQZxahNc9vWvosd9ZDeFNi9oO6S+8iVyfxU=
X-Google-Smtp-Source: AGHT+IHtYz4hPIB7+FEXGrEHfyEu8Yul6+5/2gTfNNCoOVB/vSVR4PTAaAc5Z7UAjnRZpnyan7q6zpHbTfm1inicvQhxuhqDFer8
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160a:b0:3e5:81ef:b099 with SMTP id
 e9e14a558f8ab-3e5837f086fmr155291385ab.1.1755503972053; Mon, 18 Aug 2025
 00:59:32 -0700 (PDT)
Date: Mon, 18 Aug 2025 00:59:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a2dd64.050a0220.e29e5.0096.GAE@google.com>
Subject: [syzbot] [x86?] BUG: soft lockup in xfrm_timer_handler
From: syzbot <syzbot+b6ae1c4eede4e0ea287f@syzkaller.appspotmail.com>
To: ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, jgross@suse.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8742b2d8935f Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=109d2af0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=412ee2f8b704a5e6
dashboard link: https://syzkaller.appspot.com/bug?extid=b6ae1c4eede4e0ea287f
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/306c9da968d7/disk-8742b2d8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/30ecb8c8194f/vmlinux-8742b2d8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ed161655b985/bzImage-8742b2d8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6ae1c4eede4e0ea287f@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 144s! [swapper/0:0]
Modules linked in:
irq event stamp: 2440187
hardirqs last  enabled at (2440186): [<ffffffff8172210b>] kvm_wait+0x1fb/0x290 arch/x86/kernel/kvm.c:-1
hardirqs last disabled at (2440187): [<ffffffff8b792e6e>] sysvec_apic_timer_interrupt+0xe/0xc0 arch/x86/kernel/apic/apic.c:1050
softirqs last  enabled at (2386480): [<ffffffff8184f4da>] __do_softirq kernel/softirq.c:613 [inline]
softirqs last  enabled at (2386480): [<ffffffff8184f4da>] invoke_softirq kernel/softirq.c:453 [inline]
softirqs last  enabled at (2386480): [<ffffffff8184f4da>] __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
softirqs last disabled at (2386487): [<ffffffff8184f4da>] __do_softirq kernel/softirq.c:613 [inline]
softirqs last disabled at (2386487): [<ffffffff8184f4da>] invoke_softirq kernel/softirq.c:453 [inline]
softirqs last disabled at (2386487): [<ffffffff8184f4da>] __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.17.0-rc1-syzkaller-00016-g8742b2d8935f #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: 13 e8 02 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 33 f7 0e 00 f3 0f 1e fa fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900000077b8 EFLAGS: 00000246
RAX: ffffffff8172213d RBX: 0000000000000003 RCX: ffffffff8de95100
RDX: 0000000000000100 RSI: ffffffff8d9b6da5 RDI: ffffffff8be33400
RBP: ffffc90000007890 R08: ffffffff8fa37e37 R09: 1ffffffff1f46fc6
R10: dffffc0000000000 R11: fffffbfff1f46fc7 R12: dffffc0000000000
R13: 0000000000000200 R14: 0000000000000003 R15: 1ffff92000000efc
FS:  0000000000000000(0000) GS:ffff888125c1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563a9e26fa58 CR3: 000000000df36000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 kvm_wait+0x232/0x290 arch/x86/kernel/kvm.c:1064
 pv_wait arch/x86/include/asm/paravirt.h:569 [inline]
 pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:466 [inline]
 __pv_queued_spin_lock_slowpath+0x7bf/0xb60 kernel/locking/qspinlock.c:325
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:557 [inline]
 queued_spin_lock_slowpath+0x43/0x50 arch/x86/include/asm/qspinlock.h:51
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x21f/0x290 kernel/locking/spinlock_debug.c:116
 spin_lock include/linux/spinlock.h:351 [inline]
 __xfrm_state_delete+0xba/0xca0 net/xfrm/xfrm_state.c:818
 xfrm_timer_handler+0x18f/0xa00 net/xfrm/xfrm_state.c:716
 __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
 __hrtimer_run_queues+0x52c/0xc60 kernel/time/hrtimer.c:1825
 hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1842
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: 13 e8 02 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 33 f7 0e 00 f3 0f 1e fa fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffffff8de07d80 EFLAGS: 000002c2
RAX: 3d439e448e506a00 RBX: ffffffff81968308 RCX: 3d439e448e506a00
RDX: 0000000000000001 RSI: ffffffff8d9b6da5 RDI: ffffffff8be33400
RBP: ffffffff8de07eb8 R08: ffff8880b8632f9b R09: 1ffff110170c65f3
R10: dffffc0000000000 R11: ffffed10170c65f4 R12: ffffffff8fa37e30
R13: 0000000000000000 R14: 0000000000000000 R15: 1ffffffff1bd2a20
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:757
 default_idle_call+0x74/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:190 [inline]
 do_idle+0x1e8/0x510 kernel/sched/idle.c:330
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:428
 rest_init+0x2de/0x300 init/main.c:744
 start_kernel+0x3a9/0x410 init/main.c:1097
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:307
 x86_64_start_kernel+0x143/0x1c0 arch/x86/kernel/head64.c:288
 common_startup_64+0x13e/0x147
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 7440 Comm: syz.2.420 Not tainted 6.17.0-rc1-syzkaller-00016-g8742b2d8935f #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:check_kcov_mode kernel/kcov.c:183 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x18/0x70 kernel/kcov.c:217
Code: cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 04 24 65 48 8b 0c 25 08 40 a0 92 65 8b 15 68 94 e0 10 <81> e2 00 01 ff 00 74 11 81 fa 00 01 00 00 75 35 83 b9 3c 16 00 00
RSP: 0000:ffffc9001d36f0d8 EFLAGS: 00000297
RAX: ffffffff8a216ca4 RBX: 0000000001000000 RCX: ffff888028cb8000
RDX: 0000000000000402 RSI: 000000000007ffff RDI: 0000000000080000
RBP: ffffc9001d36f230 R08: 0000000000000000 R09: ffffffff8a216a10
R10: dffffc0000000000 R11: fffff52003a6de0c R12: dffffc0000000000
R13: ffff88805489b300 R14: 0000000007000000 R15: ffffc9001d36f6a0
FS:  0000000000000000(0000) GS:ffff888125d1c000(0063) knlGS:00000000f54ceb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000072956000 CR4: 00000000003526f0
DR0: 0000040000000000 DR1: 000000000000064f DR2: 0000000000000006
DR3: 0000000000000006 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 xfrm_state_lookup_spi_proto net/xfrm/xfrm_state.c:1707 [inline]
 xfrm_alloc_spi+0x534/0xf30 net/xfrm/xfrm_state.c:2589
 xfrm_alloc_userspi+0x70b/0xc90 net/xfrm/xfrm_user.c:1873
 xfrm_user_rcv_msg+0x7a0/0xab0 net/xfrm/xfrm_user.c:3501
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3523
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg+0x164/0x220 net/socket.c:2700
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xb6/0x2b0 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x34/0x80 arch/x86/entry/syscall_32.c:331
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf70de539
Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f54ce55c EFLAGS: 00000206 ORIG_RAX: 0000000000000172
RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 0000000080000740
RDX: 0000000000000050 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
