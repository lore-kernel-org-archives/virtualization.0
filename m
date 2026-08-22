Received: from mail-oi2-f4.google.com (mail-oi2-f4.google.com [74.125.231.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2003235975
	for <virtualization@lists.linux.dev>; Sat, 22 Aug 2026 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787357493; cv=none; b=o97PsuSVDUOXTnQeRfRhdIK8fBJIuRsi7YY40vLO1agHHvJ0O+7xWUWDJCXccbDZv1b2ngVIEZvLG55Nv7LkUI0k+VgEYNSyTwAruzaokuBKbB2m1htBKUPSZjwWopHgk4DaHXD1g8COnU3UbVyEPSrz9u5szCaqqnfCmxWuACk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787357493; c=relaxed/simple;
	bh=N0D/teIsmZ7fW/EZu9+ia+BVEim+zssLdeSW8iNRk0M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EQJ3MGb/cK1+b3LPvznrr2q8M05JoRPrjTo58mq7KLMyV98TVAl7FumQLfTLenvCpr05W/zZH1upBLMovHMha6+U0LIKdl0g4OJ9WbL/jbzkb+qlo/fxMPKZqVG8eWQyY879YtrpgEas0cNXOMtv//EaDVz5R2BKlZK3eKkp2Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f4.google.com with SMTP id 5614622812f47-4ab2d8e7e4cso477652b6e.1
        for <virtualization@lists.linux.dev>; Fri, 21 Aug 2026 17:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787357491; x=1787962291;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MHY+GG1XMj8jOyI2nQEJSmbDvkuJ4F4JEIj+l5769w8=;
        b=qa5lgigSmSZgltD2E0YIW1M80H2n+LmEoMkIOxX6repS17El6mTUniYlPyavX2mQb6
         pY7tv8AfuiOQL21bu9izFTKW8M0u3ndmFVgSX8AVPL/g+RLrinXdG4F/yzFAzD00SOxw
         bGdu5BAjwgN/izu41QE+T5lYv+v5zW6AX3lU+6+DYIh0ubxccnDbIsVt/W2Vwa1mXd6M
         jP7dy948OgMdftfwg8gVf8y+tar4qQgeypiDsCchPfWb29T1zPtMk8EEMRm2VYVgqDrW
         FE7RAXUUDQgdAudC3yHYknZf2IWgdSqUh+Dfrxmb71ZsFcad6B/HYz0uDT5SmOysG/ib
         FNnQ==
X-Forwarded-Encrypted: i=1; AHgh+RpcB2Q40hLtba4voBd0RPfpJQVZOS3FL6OqwU1O3IO3PCofPet2Dz6GdUlrxPreDIr5T3HRcT7uCGv8kuLZMA==@lists.linux.dev
X-Gm-Message-State: AFuF++mAzfp85PDFXagrVJBqISIqYIj5JIasZeHawhDVk8GLph5bbbv/
	o54C0uSPGq+yIARPtSqRM8awktuPFX8RFOSJnvuzdxHhNYIU9WPcVKdKZ2OEJvQN7GilSdpj1Fb
	o4Bwlw1AMuMlA1PrWAxwV7SsOgom5I/de16QUiacqruHKOKd4hE81DSsC8ac=
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1c08:b0:4ab:32ea:95f6 with SMTP id
 5614622812f47-4b2ef3b0a4dmr11966986b6e.13.1787357491091; Fri, 21 Aug 2026
 17:11:31 -0700 (PDT)
Date: Fri, 21 Aug 2026 17:11:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a88e933.ae6ddae5.3da009.0046.GAE@google.com>
Subject: [syzbot] [virt?] INFO: trying to register non-static key in
 stats_request (2)
From: syzbot <syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com>
To: david@kernel.org, eperezma@redhat.com, jasowangio@gmail.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8d3ae59288f1 Linux 7.2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10240679580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c9eb8e593cf8c5c
dashboard link: https://syzkaller.appspot.com/bug?extid=13df72e0dc4be5c62215
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cd49b631c498/disk-8d3ae592.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/05d3ad83c130/vmlinux-8d3ae592.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3a2efa4a6769/bzImage-8d3ae592.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 20235 Comm: irq/10-virtio2 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 assign_lock_key+0x133/0x150 kernel/locking/lockdep.c:984
 register_lock_class+0xcc/0x2e0 kernel/locking/lockdep.c:1299
 __lock_acquire+0xab/0x2ce0 kernel/locking/lockdep.c:5112
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
 rt_spin_lock+0x83/0x400 kernel/locking/spinlock_rt.c:56
 spin_lock include/linux/spinlock_rt.h:45 [inline]
 start_wakeup_event drivers/virtio/virtio_balloon.c:150 [inline]
 stats_request+0xa5/0x1f0 drivers/virtio/virtio_balloon.c:435
 vring_interrupt+0x408/0x680 drivers/virtio/virtio_ring.c:3297
 vp_vring_interrupt drivers/virtio/virtio_pci_common.c:92 [inline]
 vp_interrupt+0x183/0x200 drivers/virtio/virtio_pci_common.c:123
 irq_thread_fn kernel/irq/manage.c:1143 [inline]
 irq_forced_thread_fn+0x98/0x120 kernel/irq/manage.c:1165
 irq_thread+0x455/0x690 kernel/irq/manage.c:1271
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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
