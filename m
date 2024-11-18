Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FD518EFDE
	for <virtualization@lists.linux.dev>; Mon, 18 Nov 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943052; cv=none; b=bLTeFo63rpqeEbZ044NMA3KmFRLxDr4wQpVs88uWbHnAwFH4BqEhijMW4Bt6iCnRk0zHJBYMevga+1YJhDgeHvMwgiloUt3WymJOrSfa5M9l5+xUBsXhL62cTjnH32WBSm82huaGBrjDJ3mUX0veToJPSodfJKkrGzQTj4nRSbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943052; c=relaxed/simple;
	bh=qRdu+W3MecDQXrO1b1xbVvcFFHBRaRg27GrWOgzU93w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Td82SEtR/dWuzXWLLKtiGuwLvmq9NjAMlv6Zf9AGrhbcli8kKfCgAk3H1VN4aEze6DTsZ8ywgLhBD0VyP7K570x3wziLjFvdeph8ZEBxu0agiN8KuGTCjWNtL07gtVrdIK8eVqW8nmUYB60GwJvxZvBP2lq1ZGtuiwPwqDWuddo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a71bdd158aso47699855ab.1
        for <virtualization@lists.linux.dev>; Mon, 18 Nov 2024 07:17:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731943050; x=1732547850;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MMrFntecqL6JFmwjB+HrMvBdRfZbPU+p3Yo/qXqmg/Q=;
        b=duM7IOUIGisIl50o+t+0tyrzn/Lj6gXQPDMSYPulyaZi+kHPka6Wr0NcSLpAWz67Dh
         XzYbNqTTEILoCuCwFpemRWray7BZ1hwmxl7HU1shPmcrwWybGL4ABWwV6GO2IMg7jC4J
         5rkojk3sQBUZDyx9SEqJkudQgqe3pNWEj9Sg6qUSI6qoBbpGNxReSarOvvozkB4mifPC
         PqftP+j/fUiqV3Qe/fHgdHwC9E1XAzb182rwJ9s8ixaODqkglWiLuVXTsmKbMVq7WwQN
         Gm6rPPDjfZxnOUpU6G/QQnyji2YZR+7f282k3YwPRZPjoDHok1neW5rR5osiuY9GMUWc
         9LwA==
X-Forwarded-Encrypted: i=1; AJvYcCUlpNh/CUwbYgRQvfbRXd7qGemBgatqw2R/XXFa7SFKMjWpHICdHQZVFA5slr/hnERtiFzw453z7KlqN78vrQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrjzE6r6WceTQfVW5wiPa3ZKDMKo+HlrksVyAAhJGF1rTuUdQt
	t6HrG7xpBTlyAvlIU3LThrjgCfJ6agQnHIUcrJ5EJLfYdDQHJen9ugP1fzKKOLI6Ed2L8v5eot2
	O9XQWOqsCeugIEIDxCj9EaQgYXDxJCBo7LC6pvj2TGQfsAgp+xWp9Ju8=
X-Google-Smtp-Source: AGHT+IGPIsq6/yaP7fwU8ausne4uz0KbEqvEiQQi+jkfH2FRE8pytf9PPBxQPun5r1JkEi+SBQAE/soq4BdR/qAsBcCuxo945xjQ
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:0:b0:3a6:b0a3:5400 with SMTP id
 e9e14a558f8ab-3a748087603mr105580875ab.16.1731943050158; Mon, 18 Nov 2024
 07:17:30 -0800 (PST)
Date: Mon, 18 Nov 2024 07:17:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b5a8a.050a0220.87769.0043.GAE@google.com>
Subject: [syzbot] [virt?] INFO: trying to register non-static key in stats_request
From: syzbot <syzbot+f303608297c771a7de35@syzkaller.appspotmail.com>
To: david@redhat.com, eperezma@redhat.com, jasowang@redhat.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0a9b9d17f3a7 Merge tag 'pm-6.12-rc8' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17bf6ce8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=f303608297c771a7de35
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8a8c49f7786f/disk-0a9b9d17.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0f9c24f45e74/vmlinux-0a9b9d17.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b1f469ce7e16/bzImage-0a9b9d17.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f303608297c771a7de35@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc7-syzkaller-00070-g0a9b9d17f3a7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 assign_lock_key+0x241/0x280 kernel/locking/lockdep.c:981
 register_lock_class+0x1cf/0x980 kernel/locking/lockdep.c:1295
 __lock_acquire+0xf0/0x2050 kernel/locking/lockdep.c:5077
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 start_wakeup_event drivers/virtio/virtio_balloon.c:150 [inline]
 stats_request+0xb3/0x230 drivers/virtio/virtio_balloon.c:440
 vring_interrupt+0x21d/0x380 drivers/virtio/virtio_ring.c:2595
 vp_vring_interrupt drivers/virtio/virtio_pci_common.c:92 [inline]
 vp_interrupt+0x192/0x200 drivers/virtio/virtio_pci_common.c:123
 __handle_irq_event_percpu+0x29a/0xa80 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
 handle_fasteoi_irq+0x48a/0xae0 kernel/irq/chip.c:720
 generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
 handle_irq arch/x86/kernel/irq.c:247 [inline]
 call_irq_handler arch/x86/kernel/irq.c:259 [inline]
 __common_interrupt+0x136/0x230 arch/x86/kernel/irq.c:285
 common_interrupt+0xb4/0xd0 arch/x86/kernel/irq.c:278
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5829
Code: 2b 00 74 08 4c 89 f7 e8 ea 6c 8e 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0000:ffffc90000067360 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff9200000ce78 RCX: c155c4d26c75e500
RDX: dffffc0000000000 RSI: ffffffff8c0adc40 RDI: ffffffff8c610b20
RBP: ffffc900000674a8 R08: ffffffff942d0857 R09: 1ffffffff285a10a
R10: dffffc0000000000 R11: fffffbfff285a10b R12: 1ffff9200000ce74
R13: dffffc0000000000 R14: ffffc900000673c0 R15: 0000000000000246
 down_write+0x99/0x220 kernel/locking/rwsem.c:1577
 __blocking_notifier_chain_register kernel/notifier.c:271 [inline]
 blocking_notifier_chain_register+0x50/0xc0 kernel/notifier.c:290
 virtballoon_probe+0x551/0xf60 drivers/virtio/virtio_balloon.c:1015
 virtio_dev_probe+0x931/0xc80 drivers/virtio/virtio.c:341
 really_probe+0x2b8/0xad0 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
 __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
 bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:370
 bus_add_driver+0x346/0x670 drivers/base/bus.c:675
 driver_register+0x23a/0x320 drivers/base/driver.c:246
 do_one_initcall+0x248/0x880 init/main.c:1269
 do_initcall_level+0x157/0x210 init/main.c:1331
 do_initcalls+0x3f/0x80 init/main.c:1347
 kernel_init_freeable+0x435/0x5d0 init/main.c:1580
 kernel_init+0x1d/0x2b0 init/main.c:1469
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
----------------
Code disassembly (best guess):
   0:	2b 00                	sub    (%rax),%eax
   2:	74 08                	je     0xc
   4:	4c 89 f7             	mov    %r14,%rdi
   7:	e8 ea 6c 8e 00       	call   0x8e6cf6
   c:	f6 44 24 61 02       	testb  $0x2,0x61(%rsp)
  11:	0f 85 85 01 00 00    	jne    0x19c
  17:	41 f7 c7 00 02 00 00 	test   $0x200,%r15d
  1e:	74 01                	je     0x21
  20:	fb                   	sti
  21:	48 c7 44 24 40 0e 36 	movq   $0x45e0360e,0x40(%rsp)
  28:	e0 45
* 2a:	4b c7 44 25 00 00 00 	movq   $0x0,0x0(%r13,%r12,1) <-- trapping instruction
  31:	00 00
  33:	43 c7 44 25 09 00 00 	movl   $0x0,0x9(%r13,%r12,1)
  3a:	00 00
  3c:	43                   	rex.XB
  3d:	c7                   	.byte 0xc7
  3e:	44                   	rex.R
  3f:	25                   	.byte 0x25


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
