Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B791C5D72
	for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 01:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492733; cv=none; b=YeHUjEPqqPYVtCyf1bZjOuMoClybxvSrPrDiTA94nkVOVR49dHbnI3rMUYvt27xk2pKsSkT4PUkkUKVDi4cJuRVwA+X4IDl9cZ3VyI1uFPXOXV5jLpmxTlJ3H2rqc50ZDSBFcyeY1rbWWU0W6A+DJIyV0a017wecAnn964KVbmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492733; c=relaxed/simple;
	bh=9LN+Zs6NCjQa+t54cqHrhyWKQ1argIw0P9swlzuGlO8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NdIzuCgIx2P6LZZmUWJgzoC4OdMRn5zIhEbwn5nrANsnORr6/BhUG5PPd+59nMGzQZB3KSbr+fBuwfITw/C31Wdrobzg8j+r8kxdoLgxxGoGH27+c0hIVOJzTiePNO4PwcKSM+5kPNlTpo21qEtpWImqg2He38z6Ev5neCGZ050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-927f4207211so1737908639f.3
        for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 18:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760492731; x=1761097531;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J366MR2M7sKoRrXuFnkKIqxbANSCO0h9QS9aVAEV1kM=;
        b=moPtjodAxmg26Dj12VSCuPmR6EBhdE61GxGyAR3XNAtW2M0eCvW8bAnk/n5i6ic/vM
         Vq9AKb6IB7/g/G64iRzN7TX0aLEyVz93opr1Suloja1SuOVI4rD0kL1zBTY3hDE9XhMY
         3mimkk1n92k55rTbBYVdY+7y7u8Hg/+VumYC9FvtF8ITUPJ7FRdbU6x4TE64CyFIQxnd
         e/Kg0wbfhe5PJwoF/F/vR9OBctaTNVxadsGYSiKlujgNO/bSSIxIRVlQKvWeyN7+suXX
         2L0yaw4J7SeWsTizb43BJHWt+ud5Tv5Gj/MyX3KjC7Wux5aKSSLt0yQMs2I3DB8wau5v
         thow==
X-Forwarded-Encrypted: i=1; AJvYcCUU6jZCksndTYJv8Fw7Layi0VyGUJ4Ajq2kfiwNF7aAOqVEKwJKAvs+mhG3OHS2JV+TQlySRelCFhPW2K+LmA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4tj+E8M5AU3gVA94352c+aoW0ARcVP0MQSDLLFKF6dM7jvNCO
	nCAQkGzOa67qukfPrelxfeciSxZ5nXTyRkTYlkC+6NV6L5900mF1VfB+P9/tQwhGbpwiKoRoxPv
	OGdzSpv+y6eRuI+My74OVJORbCauPRwcaOYTPbdO4kQ1zPNFZ8P+VrKOGepU=
X-Google-Smtp-Source: AGHT+IFG4yP9H5c+k6xaEmWTyp3AfP2MgGIsiZlU3OcrCbCiINaRQfeZRXV2R7N4pCbai5xzJzvB1fmB/ddKLZx28OQuBTwb1Yql
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1648:b0:42f:85fb:38be with SMTP id
 e9e14a558f8ab-42f87423707mr292381045ab.29.1760492731092; Tue, 14 Oct 2025
 18:45:31 -0700 (PDT)
Date: Tue, 14 Oct 2025 18:45:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68eefcbb.050a0220.91a22.0228.GAE@google.com>
Subject: [syzbot] [kernfs?] [x86?] [mm?] general protection fault in
 call_timer_fn (2)
From: syzbot <syzbot+dbca4dcd735c25501713@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tj@kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d3abefe89740 selftests/bpf: Fix typos and grammar in test ..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=172edc62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c321f33e4545e2a1
dashboard link: https://syzkaller.appspot.com/bug?extid=dbca4dcd735c25501713
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/067335e1be92/disk-d3abefe8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8ea133347d7e/vmlinux-d3abefe8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5ef631484984/bzImage-d3abefe8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dbca4dcd735c25501713@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 1 UID: 0 PID: 6784 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:trace_event_get_offsets_lock_acquire include/trace/events/lock.h:24 [inline]
RIP: 0010:do_perf_trace_lock_acquire include/trace/events/lock.h:24 [inline]
RIP: 0010:perf_trace_lock_acquire+0xa1/0x410 include/trace/events/lock.h:24
Code: 3c 08 04 f3 f3 f3 48 c7 44 24 60 00 00 00 00 c7 84 24 80 00 00 00 00 00 00 00 48 89 74 24 30 48 8d 5e 18 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 70 7c 86 00 48 8b 03 48 85 c0 48
RSP: 0018:ffffc90000a08940 EFLAGS: 00010006
RAX: 0000000000000006 RBX: 0000000000000030 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000018 RDI: ffffffff8e008e60
RBP: ffffc90000a08a40 R08: 0000000000000000 R09: 0000000000000001
R10: dffffc0000000000 R11: ffffed10044f692f R12: 1ffff92000141130
R13: 0000000000000018 R14: ffffffff8e008e60 R15: dffffc0000000000
FS:  0000555585eed500(0000) GS:ffff888125d1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555f2285c8 CR3: 0000000026022000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 <IRQ>
 __do_trace_lock_acquire include/trace/events/lock.h:24 [inline]
 trace_lock_acquire include/trace/events/lock.h:24 [inline]
 lock_acquire+0x311/0x360 kernel/locking/lockdep.c:5831
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 __queue_work+0x809/0xfb0 kernel/workqueue.c:-1
 call_timer_fn+0x17b/0x5f0 kernel/time/timer.c:1747
 expire_timers kernel/time/timer.c:1793 [inline]
 __run_timers kernel/time/timer.c:2372 [inline]
 __run_timer_base+0x646/0x860 kernel/time/timer.c:2384
 run_timer_base kernel/time/timer.c:2393 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
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
RIP: 0010:lock_is_held_type+0x137/0x190 kernel/locking/lockdep.c:5945
Code: 01 75 44 48 c7 04 24 00 00 00 00 9c 8f 04 24 f7 04 24 00 02 00 00 75 4c 41 f7 c4 00 02 00 00 74 01 fb 65 48 8b 05 f9 03 27 07 <48> 3b 44 24 08 75 43 89 d8 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f
RSP: 0018:ffffc9001d826770 EFLAGS: 00000206
RAX: b973a21ede490300 RBX: 0000000000000001 RCX: b973a21ede490300
RDX: 0000000000000003 RSI: ffffffff8dba5ce5 RDI: ffffffff8be33300
RBP: 00000000ffffffff R08: 0000000000000000 R09: ffffffff825d3aac
R10: dffffc0000000000 R11: ffffed100365ff25 R12: 0000000000000246
R13: ffff88807bd43c00 R14: ffff88801b2ff988 R15: 0000000000000002
 lock_is_held include/linux/lockdep.h:249 [inline]
 kernfs_root_is_locked fs/kernfs/kernfs-internal.h:109 [inline]
 kernfs_rcu_name fs/kernfs/kernfs-internal.h:119 [inline]
 kernfs_sd_compare fs/kernfs/dir.c:349 [inline]
 kernfs_link_sibling+0xf7/0x3e0 fs/kernfs/dir.c:380
 kernfs_add_one+0x1e0/0x520 fs/kernfs/dir.c:810
 __kernfs_create_file+0x22b/0x2e0 fs/kernfs/file.c:1068
 sysfs_add_file_mode_ns+0x238/0x300 fs/sysfs/file.c:319
 create_files fs/sysfs/group.c:76 [inline]
 internal_create_group+0x66d/0x1110 fs/sysfs/group.c:183
 internal_create_groups fs/sysfs/group.c:223 [inline]
 sysfs_create_groups+0x59/0x120 fs/sysfs/group.c:249
 device_add_groups drivers/base/core.c:2836 [inline]
 device_add_attrs+0xe0/0x5a0 drivers/base/core.c:2900
 device_add+0x496/0xb50 drivers/base/core.c:3643
 netdev_register_kobject+0x178/0x310 net/core/net-sysfs.c:2356
 register_netdevice+0x126c/0x1ae0 net/core/dev.c:11189
 veth_newlink+0x5cc/0xa50 drivers/net/veth.c:1884
 rtnl_newlink_create+0x30d/0xb00 net/core/rtnetlink.c:3825
 __rtnl_newlink net/core/rtnetlink.c:3942 [inline]
 rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4057
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 __sys_sendto+0x3bd/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7d15f90a7c
Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
RSP: 002b:00007ffdb7942f30 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f7d16ce4620 RCX: 00007f7d15f90a7c
RDX: 000000000000002c RSI: 00007f7d16ce4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffdb7942f84 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f7d16ce4670 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:trace_event_get_offsets_lock_acquire include/trace/events/lock.h:24 [inline]
RIP: 0010:do_perf_trace_lock_acquire include/trace/events/lock.h:24 [inline]
RIP: 0010:perf_trace_lock_acquire+0xa1/0x410 include/trace/events/lock.h:24
Code: 3c 08 04 f3 f3 f3 48 c7 44 24 60 00 00 00 00 c7 84 24 80 00 00 00 00 00 00 00 48 89 74 24 30 48 8d 5e 18 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 70 7c 86 00 48 8b 03 48 85 c0 48
RSP: 0018:ffffc90000a08940 EFLAGS: 00010006
RAX: 0000000000000006 RBX: 0000000000000030 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000018 RDI: ffffffff8e008e60
RBP: ffffc90000a08a40 R08: 0000000000000000 R09: 0000000000000001
R10: dffffc0000000000 R11: ffffed10044f692f R12: 1ffff92000141130
R13: 0000000000000018 R14: ffffffff8e008e60 R15: dffffc0000000000
FS:  0000555585eed500(0000) GS:ffff888125d1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555f2285c8 CR3: 0000000026022000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
----------------
Code disassembly (best guess):
   0:	3c 08                	cmp    $0x8,%al
   2:	04 f3                	add    $0xf3,%al
   4:	f3 f3 48 c7 44 24 60 	repz xrelease movq $0x0,0x60(%rsp)
   b:	00 00 00 00
   f:	c7 84 24 80 00 00 00 	movl   $0x0,0x80(%rsp)
  16:	00 00 00 00
  1a:	48 89 74 24 30       	mov    %rsi,0x30(%rsp)
  1f:	48 8d 5e 18          	lea    0x18(%rsi),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 70 7c 86 00       	call   0x867ca9
  39:	48 8b 03             	mov    (%rbx),%rax
  3c:	48 85 c0             	test   %rax,%rax
  3f:	48                   	rex.W


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
