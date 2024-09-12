Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4930A18F2FB
	for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128683; cv=none; b=H6jzZXcLTVINpRk3ikCfsf3yTaSU8UG23J17vigVPx/vmyvR/n5RuITmgEd9qv5RqDim2lWNzOT0nuezbR+EiJ6wpcuoiO528H1N+GOME0Oz35DDOkOzGvtjEqkMWUC16FkMPsPqHZm7HlaA9dxByALqtcByJ+MtVyteAlY52uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128683; c=relaxed/simple;
	bh=46sDEFtjw9rDmzGTjxtbVXFeGbK0ohD6ptPEvJdi/oQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IPV/LhW1M7Yh+m8cBSjl8xf+B17gQo3QhKjK1CTd3e5fsx493rkC7gGxNIHQZ/2EwbJhhZaRt4iw9bM+Iv0npN4FrqK9wPGHkBOwqLnzdAVxRQA779LhquOd4iri+vZmS4n6TIgZIvlcHycMnQp8PBDZjrE0JPJWP4v4+WzqXz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a04eef8ed2so11798055ab.1
        for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 01:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726128681; x=1726733481;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IU1L0a8Eh52z552lgQRfW8oNgA34UsiZf+K+o63Sxic=;
        b=Sd/lXAY27Dy0SD3Qi1L2MHbRdbZZIAtKdlaaT94OxxODNiy/32CZ6ntEcTyDzs+bcq
         I8xNoMptiJhgGBYanjjRCYJsEcnt4cx85+1k2wehD+kNcH6AKUItkonHHZ0s4WfKtJGm
         zna9/X3DC1/BZ7cgMXhdB84iaUjcdEMMD6zGGKhDAne/N4sn65/2b+G8o2OwYtsTQFhT
         hdG10W2cS7j/xQB7AcnHxaiNXyrrMTuHxMJPnKDAwR1iJ8sBMFX2sx3N3VfR9OtdmIhD
         7P1610nocx7ly8mFnrvKzty77prRWzfK1JAGl8NWBpy1htKKKWqugj7kj0I7HwbNrdQi
         ua3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1Chpy72+Epx2dlt5HLi6Zi8/S6g2GdiUIX57XkB2zbsTcsR+MVdltk3a+hQkHGmtfX39aTuNGOBUSsoPnDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YylfgdXQYY0CidoODcsHv/am3afbwbonfCXgV+Z2/a48OE74nLE
	LUNNMhXh2U4expUbfWTsLNFdi2IB3ZvArt8HleXCvl8UNZa3acd1t6ugVPbIEhLwQLgmSwdrNZG
	nK9S32yBsXCmRWalfSY828rVbYtJfLGUygc9uvvRIxrjXhzIjHEV/UT8=
X-Google-Smtp-Source: AGHT+IGkq9UVtDYhjtSVER9h4ux/q++b9QvF78WL4PNKcS/8MzRPHacy3Qpym8XA2D8kWJn9l6LX2pCEtIAfWG65s5pDw2s7Awu1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c9:b0:39d:3043:1f2f with SMTP id
 e9e14a558f8ab-3a0849098b0mr21621755ab.14.1726128681250; Thu, 12 Sep 2024
 01:11:21 -0700 (PDT)
Date: Thu, 12 Sep 2024 01:11:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2058e0621e7a637@google.com>
Subject: [syzbot] [virt?] KCSAN: data-race in virtqueue_disable_cb /
 vring_interrupt (4)
From: syzbot <syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com>
To: eperezma@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	mst@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7c6a3a65ace7 minmax: reduce min/max macro expansion in ato..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1608e49f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e7d02549be622b2
dashboard link: https://syzkaller.appspot.com/bug?extid=8a02104389c2e0ef5049
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a1f7496fa21f/disk-7c6a3a65.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f423739e51a9/vmlinux-7c6a3a65.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b65a0f38cbd7/bzImage-7c6a3a65.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in virtqueue_disable_cb / vring_interrupt

write to 0xffff88810285ef52 of 1 bytes by interrupt on cpu 0:
 vring_interrupt+0x12b/0x180 drivers/virtio/virtio_ring.c:2591
 __handle_irq_event_percpu+0x95/0x490 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0x64/0xf0 kernel/irq/handle.c:210
 handle_edge_irq+0x16d/0x5b0 kernel/irq/chip.c:831
 generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
 handle_irq arch/x86/kernel/irq.c:247 [inline]
 call_irq_handler arch/x86/kernel/irq.c:259 [inline]
 __common_interrupt+0x58/0xe0 arch/x86/kernel/irq.c:285
 common_interrupt+0x7c/0x90 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
 __preempt_count_dec_and_test arch/x86/include/asm/preempt.h:94 [inline]
 __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
 _raw_spin_unlock_irq+0x2f/0x50 kernel/locking/spinlock.c:202
 process_one_work kernel/workqueue.c:3200 [inline]
 process_scheduled_works+0x43b/0x9a0 kernel/workqueue.c:3312
 worker_thread+0x526/0x6e0 kernel/workqueue.c:3389
 kthread+0x1d1/0x210 kernel/kthread.c:389
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

read to 0xffff88810285ef52 of 1 bytes by interrupt on cpu 1:
 virtqueue_disable_cb_split drivers/virtio/virtio_ring.c:892 [inline]
 virtqueue_disable_cb+0x92/0x180 drivers/virtio/virtio_ring.c:2446
 start_xmit+0x14b/0x1260 drivers/net/virtio_net.c:3034
 __netdev_start_xmit include/linux/netdevice.h:4913 [inline]
 netdev_start_xmit include/linux/netdevice.h:4922 [inline]
 xmit_one net/core/dev.c:3580 [inline]
 dev_hard_start_xmit+0x119/0x3f0 net/core/dev.c:3596
 sch_direct_xmit+0x1b0/0x580 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:3809 [inline]
 __dev_queue_xmit+0xf3d/0x1fe0 net/core/dev.c:4389
 dev_queue_xmit include/linux/netdevice.h:3105 [inline]
 neigh_hh_output include/net/neighbour.h:526 [inline]
 neigh_output include/net/neighbour.h:540 [inline]
 ip_finish_output2+0x73d/0x8b0 net/ipv4/ip_output.c:235
 ip_finish_output+0x11a/0x2a0 net/ipv4/ip_output.c:323
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip_output+0xab/0x170 net/ipv4/ip_output.c:433
 dst_output include/net/dst.h:450 [inline]
 ip_local_out net/ipv4/ip_output.c:129 [inline]
 __ip_queue_xmit+0xbcc/0xbf0 net/ipv4/ip_output.c:535
 ip_queue_xmit+0x38/0x50 net/ipv4/ip_output.c:549
 __tcp_transmit_skb+0x15b0/0x1970 net/ipv4/tcp_output.c:1466
 tcp_transmit_skb net/ipv4/tcp_output.c:1484 [inline]
 tcp_write_xmit+0x1273/0x31c0 net/ipv4/tcp_output.c:2829
 __tcp_push_pending_frames+0x6a/0x1a0 net/ipv4/tcp_output.c:3014
 tcp_push_pending_frames include/net/tcp.h:2106 [inline]
 tcp_data_snd_check net/ipv4/tcp_input.c:5707 [inline]
 tcp_rcv_established+0xa12/0xef0 net/ipv4/tcp_input.c:6141
 tcp_v4_do_rcv+0x662/0x740 net/ipv4/tcp_ipv4.c:1911
 tcp_v4_rcv+0x1b25/0x1ee0 net/ipv4/tcp_ipv4.c:2346
 ip_protocol_deliver_rcu+0x370/0x720 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x17d/0x210 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_local_deliver+0xec/0x1d0 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_sublist_rcv_finish net/ipv4/ip_input.c:580 [inline]
 ip_list_rcv_finish net/ipv4/ip_input.c:631 [inline]
 ip_sublist_rcv+0x55a/0x640 net/ipv4/ip_input.c:639
 ip_list_rcv+0x25e/0x290 net/ipv4/ip_input.c:674
 __netif_receive_skb_list_ptype net/core/dev.c:5704 [inline]
 __netif_receive_skb_list_core+0x4f0/0x520 net/core/dev.c:5752
 __netif_receive_skb_list net/core/dev.c:5804 [inline]
 netif_receive_skb_list_internal+0x4e4/0x660 net/core/dev.c:5896
 gro_normal_list include/net/gro.h:515 [inline]
 napi_complete_done+0x1cb/0x450 net/core/dev.c:6247
 virtqueue_napi_complete drivers/net/virtio_net.c:694 [inline]
 virtnet_poll+0x1b73/0x1fd0 drivers/net/virtio_net.c:2826
 __napi_poll+0x63/0x3c0 net/core/dev.c:6772
 napi_poll net/core/dev.c:6841 [inline]
 net_rx_action+0x3a1/0x7f0 net/core/dev.c:6963
 handle_softirqs+0xc3/0x280 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0x3e/0x90 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x37/0x80 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

value changed: 0x00 -> 0x01

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 31238 Comm: syz.2.3839 Not tainted 6.11.0-rc7-syzkaller-00021-g7c6a3a65ace7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
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
