Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2261FC10E
	for <virtualization@lists.linux.dev>; Tue,  4 Mar 2025 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741125149; cv=none; b=O+fjJm609KDXROq3FE9skcbeRpJdI+b84oI56jeDCd31sFGIYcbfMz0uYudKUcC6U/FPjRT8B82aALiFmaepc5xn7CHivvk1ol+vBklkxgcVsly59Hm3aYuc2Zr8CbsYUYqPXXYzK+KpcUOB4GqmbNP0vtKjvFtLJ2njcOwp+Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741125149; c=relaxed/simple;
	bh=fPEkJZTWhWGkSvyHQx9qG+VOs+4MAg2FdojLghrzEUs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=N6T4EZydNW7bCL49mUZI+zArDQt5SsVEi15LTqIWmOB/8prN18xo6Pf5FNiobU2IPMoEQZOgPAza2gIV0At1NMWvv07DslrWKq2z690fd/GTkkGnHbJf9Fs9zwXYMZhMiJrgwRnG1za7Ca4qHC5SlmIGg0F2WvhxhDBlAl5aEkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d3e14f3638so110658475ab.1
        for <virtualization@lists.linux.dev>; Tue, 04 Mar 2025 13:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741125147; x=1741729947;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eh7fZ3momAvYKWET6wtFNtqSRFn0GlnN16QrylaRDhA=;
        b=ne2m5hzKGirf4nbALmwglkt1orsnU0PR3ONKB1M/w/PR0H2Uv2yVWFxXeZ08p+7zsQ
         77qrk0rtgcwMqOslr6/sgy+FoHhe0IQgHgZZiGIu2FB4E6kgpOleGKwuVMXHqhAP6H0H
         8d+UuWAKsmqxcrYcwsWi5T3FlZaDPHhudu8vlrREoQKzKuWfKWYePfbkZ7eDQH8cvc5l
         1ds+MmUG4Uxqe7OQyNkDeFCC69QfnwbVDYS/IUFULFIn0fiYeEeOpUpjGri59BSXeH0s
         nIxMgqeBrCVpEEM07MsqSMYmsgusQzLwoqwN45U6gRUJ1xHHuiR10C6dmlHBgz+0uzVf
         KL0g==
X-Forwarded-Encrypted: i=1; AJvYcCU01UkZRXbUN7SDXY4iihVOtjKdp0o/vjzyOKHNOKKMZ64BkCznHtbCfWVVxlqVDykD2BAPzBILZrrecTHrzA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwU071XAZO00zuQpuMQTq5JwWalU+7W0dxEFpNXqffekCavRyDb
	8QBO7o0E9Yn6wWi0GEjLWCPtQmzXMvfQKbRENav+sljNFdVIbA5wQS0khP50OwzywT0cdy+8TAA
	7u+6nRaKy9re1SLURYzgWRUSYaAGDxJeLXheFotKUuKHcNYdkVBYgxuA=
X-Google-Smtp-Source: AGHT+IEAxg5QDO8kH0xAi4FrGX5hac33JkTNqmJapyMQzfnaHUGv0Vh5PB+zgboDoI66FUPJrf+EV/P9S9CJYeN05ff7wv5Rkzb3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c4:b0:3d1:a75e:65f6 with SMTP id
 e9e14a558f8ab-3d42b97733cmr12768325ab.18.1741125146944; Tue, 04 Mar 2025
 13:52:26 -0800 (PST)
Date: Tue, 04 Mar 2025 13:52:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c7761a.050a0220.15b4b9.0018.GAE@google.com>
Subject: [syzbot] [virt?] KCSAN: data-race in virtqueue_disable_cb /
 virtqueue_enable_cb_delayed (9)
From: syzbot <syzbot+efe683d57990864b8c8e@syzkaller.appspotmail.com>
To: eperezma@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	mst@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    99fa936e8e4f Merge tag 'affs-6.14-rc5-tag' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14629464580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=523b0e2f15224775
dashboard link: https://syzkaller.appspot.com/bug?extid=efe683d57990864b8c8e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a28c1cb92a01/disk-99fa936e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/229349d043c8/vmlinux-99fa936e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/49768322c46d/bzImage-99fa936e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+efe683d57990864b8c8e@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in virtqueue_disable_cb / virtqueue_enable_cb_delayed

write to 0xffff8881025bc452 of 1 bytes by task 3288 on cpu 0:
 virtqueue_enable_cb_delayed+0x42/0x3c0 drivers/virtio/virtio_ring.c:2653
 start_xmit+0x230/0x1310 drivers/net/virtio_net.c:3264
 __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
 netdev_start_xmit include/linux/netdevice.h:5160 [inline]
 xmit_one net/core/dev.c:3800 [inline]
 dev_hard_start_xmit+0x119/0x3f0 net/core/dev.c:3816
 sch_direct_xmit+0x1a9/0x580 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:4039 [inline]
 __dev_queue_xmit+0xf6a/0x2090 net/core/dev.c:4615
 dev_queue_xmit include/linux/netdevice.h:3313 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip_finish_output2+0x71d/0x880 net/ipv4/ip_output.c:236
 ip_finish_output+0x11a/0x2a0 net/ipv4/ip_output.c:324
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip_output+0xab/0x170 net/ipv4/ip_output.c:434
 dst_output include/net/dst.h:459 [inline]
 ip_local_out net/ipv4/ip_output.c:130 [inline]
 __ip_queue_xmit+0xb2c/0xb50 net/ipv4/ip_output.c:528
 ip_queue_xmit+0x38/0x50 net/ipv4/ip_output.c:542
 __tcp_transmit_skb+0x15ca/0x19d0 net/ipv4/tcp_output.c:1471
 tcp_transmit_skb net/ipv4/tcp_output.c:1489 [inline]
 tcp_write_xmit+0x1217/0x3020 net/ipv4/tcp_output.c:2832
 __tcp_push_pending_frames+0x6a/0x1a0 net/ipv4/tcp_output.c:3015
 tcp_push+0x320/0x340 net/ipv4/tcp.c:751
 tcp_sendmsg_locked+0x21a1/0x26a0 net/ipv4/tcp.c:1326
 tcp_sendmsg+0x30/0x50 net/ipv4/tcp.c:1358
 inet_sendmsg+0x77/0xd0 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg+0x102/0x180 net/socket.c:733
 sock_write_iter+0x15e/0x1a0 net/socket.c:1137
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x77b/0x920 fs/read_write.c:679
 ksys_write+0xe8/0x1b0 fs/read_write.c:731
 __do_sys_write fs/read_write.c:742 [inline]
 __se_sys_write fs/read_write.c:739 [inline]
 __x64_sys_write+0x42/0x50 fs/read_write.c:739
 x64_sys_call+0x287e/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff8881025bc452 of 1 bytes by interrupt on cpu 1:
 virtqueue_disable_cb_split drivers/virtio/virtio_ring.c:880 [inline]
 virtqueue_disable_cb+0x92/0x180 drivers/virtio/virtio_ring.c:2566
 skb_xmit_done+0x5f/0x140 drivers/net/virtio_net.c:777
 vring_interrupt+0x161/0x190 drivers/virtio/virtio_ring.c:2715
 __handle_irq_event_percpu+0x95/0x490 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0x64/0xf0 kernel/irq/handle.c:210
 handle_edge_irq+0x16d/0x5b0 kernel/irq/chip.c:831
 generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
 handle_irq arch/x86/kernel/irq.c:249 [inline]
 call_irq_handler arch/x86/kernel/irq.c:261 [inline]
 __common_interrupt+0x58/0xe0 arch/x86/kernel/irq.c:287
 common_interrupt+0x7c/0x90 arch/x86/kernel/irq.c:280
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
 rep_movs_alternative+0x33/0x70 arch/x86/lib/copy_user_64.S:57
 copy_user_generic arch/x86/include/asm/uaccess_64.h:126 [inline]
 raw_copy_from_user arch/x86/include/asm/uaccess_64.h:141 [inline]
 _inline_copy_from_user include/linux/uaccess.h:178 [inline]
 _copy_from_user+0x6f/0xa0 lib/usercopy.c:18
 copy_from_user include/linux/uaccess.h:212 [inline]
 copy_msghdr_from_user+0x54/0x2a0 net/socket.c:2503
 recvmsg_copy_msghdr net/socket.c:2759 [inline]
 ___sys_recvmsg net/socket.c:2831 [inline]
 do_recvmmsg+0x256/0x6d0 net/socket.c:2930
 __sys_recvmmsg net/socket.c:3004 [inline]
 __do_sys_recvmmsg net/socket.c:3027 [inline]
 __se_sys_recvmmsg net/socket.c:3020 [inline]
 __x64_sys_recvmmsg+0xe2/0x170 net/socket.c:3020
 x64_sys_call+0x2a9a/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:300
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x01 -> 0x00

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 4167 Comm: syz.0.259 Not tainted 6.14.0-rc5-syzkaller-00013-g99fa936e8e4f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
==================================================================


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
