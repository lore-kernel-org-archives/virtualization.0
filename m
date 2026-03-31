Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996ED1A6826
	for <virtualization@lists.linux.dev>; Tue, 31 Mar 2026 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959507; cv=none; b=oAYN/lfjU3qMkn6Sv7XK00I3wRHNAk0XDbuu+B08qgBCXElHyd3CWB217Rz4LNuL0JrKvnevbaPatN0o+S2EdDPCdDR+/gyl+E1cZ+oDEiLfqYMpOTEinajr3bCGQZDx7kfLJPKQiZPoqEtdCJwHWvrBF3IWV6zS7UDa/PhPFsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959507; c=relaxed/simple;
	bh=UCoTzKc5z4HdqAktOmLG49wXJ3iuqvCRjZEro9Uy1eA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=U/BTzwOSlPTWj+7KXY5Csec/MS1mn6PvolyNGoea791kCr8rrtYBeG71tQtIegOU+PhV6Jkoxz0VbuWL3v9WimURxyWqWe7qWAn5DVrUXMKeG48h3YJsJ3Twv3/7kwxzRmP5Wy13vC78/wuSDQmnYkVSqSQeY+zoycHOsF/hX9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-672c40f3873so25588302eaf.2
        for <virtualization@lists.linux.dev>; Tue, 31 Mar 2026 05:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774959504; x=1775564304;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Ua+UwyWqOJSisnJqP9Ewrk9Lq7Kzzh4Vn5weuiPEcE=;
        b=rfVc2yE6w5opLu2saTN7vkilrrKVostYdyBKiw0p3bJDi7rOouaT1JkHccWQBmuelX
         ZnvyXuzWHy9GsybLGdF9ah2b0xz1NZuvUanK20O7SuErLn5N1K28Y2H0jbA2uQP9qvOz
         zsnHX8yTG4DI5sfxA3AomuI5R9hUiDQdmJihpisImOxIFNo8gKnWbHsVJaw6elVt52YG
         ChkfhVpAmBQC6IMv2EHGxe0MBpj40oYAJKxVn6ZvxI8nhFYJQ1p6qF6N0Cpexu/fE6IF
         YIJoB2aLMZZm85qsynLKIyvs4OrqkZGlIWeiXARVVoswatYq02xKlMnsHV9jZA/HznMo
         kcSg==
X-Forwarded-Encrypted: i=1; AJvYcCU4SkEp4plvEMKUQF4QKg3WYPtlZE2iYC9KEiGgjab6YIiWc14c5fE6JM11RFV6BnfcqjIHdPfTu9P5taHN2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzD4tjNX9K5B8Sh7tEF10TNxBHXH3SZhhw+wh338EMPSOuDZXrH
	RKKzPA8yhkfN7HUYx+gIJewaM0+LWXHAQsxPIbGqhHJ6qL52VxXwVysV7sveoGxr76kwovEW6bU
	NRGKqcbIJOfqdX4VOr2bm2hWGMDQv2UOdRaKdxFAu08ZD9/qAQ5aaKFKSyO4=
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c94:b0:67b:f37b:60fe with SMTP id
 006d021491bc7-67e185dcea0mr8987229eaf.14.1774959504471; Tue, 31 Mar 2026
 05:18:24 -0700 (PDT)
Date: Tue, 31 Mar 2026 05:18:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69cbbb90.050a0220.183828.002b.GAE@google.com>
Subject: [syzbot] [virt?] KCSAN: data-race in virtqueue_disable_cb /
 virtqueue_enable_cb_delayed (11)
From: syzbot <syzbot+574895e85c21fa090ff6@syzkaller.appspotmail.com>
To: eperezma@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	mst@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    46b513250491 Merge tag 'v7.0-rc5-smb3-client-fix' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1226df72580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a78dd265deac3a9
dashboard link: https://syzkaller.appspot.com/bug?extid=574895e85c21fa090ff6
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8f19c67785a8/disk-46b51325.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/11dbb9704e20/vmlinux-46b51325.xz
kernel image: https://storage.googleapis.com/syzbot-assets/190d9812e855/bzImage-46b51325.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+574895e85c21fa090ff6@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in virtqueue_disable_cb / virtqueue_enable_cb_delayed

write to 0xffff8881027a9588 of 2 bytes by interrupt on cpu 1:
 virtqueue_enable_cb_delayed_split drivers/virtio/virtio_ring.c:1102 [inline]
 virtqueue_enable_cb_delayed+0x20f/0x660 drivers/virtio/virtio_ring.c:3196
 start_xmit+0x15ef/0x1ab0 drivers/net/virtio_net.c:3377
 __netdev_start_xmit include/linux/netdevice.h:5325 [inline]
 netdev_start_xmit include/linux/netdevice.h:5334 [inline]
 xmit_one net/core/dev.c:3883 [inline]
 dev_hard_start_xmit+0x136/0x3f0 net/core/dev.c:3899
 sch_direct_xmit+0x192/0x550 net/sched/sch_generic.c:347
 __dev_xmit_skb net/core/dev.c:4198 [inline]
 __dev_queue_xmit+0xca9/0x1f20 net/core/dev.c:4814
 dev_queue_xmit include/linux/netdevice.h:3385 [inline]
 neigh_hh_output include/net/neighbour.h:540 [inline]
 neigh_output include/net/neighbour.h:554 [inline]
 ip_finish_output2+0x705/0x8c0 net/ipv4/ip_output.c:237
 __ip_finish_output net/ipv4/ip_output.c:-1 [inline]
 ip_finish_output+0x112/0x290 net/ipv4/ip_output.c:325
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip_output+0xbd/0x1c0 net/ipv4/ip_output.c:438
 dst_output include/net/dst.h:470 [inline]
 ip_local_out net/ipv4/ip_output.c:131 [inline]
 __ip_queue_xmit+0xb68/0xba0 net/ipv4/ip_output.c:534
 ip_queue_xmit+0x39/0x50 net/ipv4/ip_output.c:548
 __tcp_transmit_skb+0x1af2/0x1f10 net/ipv4/tcp_output.c:1693
 tcp_transmit_skb net/ipv4/tcp_output.c:1711 [inline]
 tcp_write_xmit+0x1597/0x3640 net/ipv4/tcp_output.c:3064
 __tcp_push_pending_frames+0x6d/0x1b0 net/ipv4/tcp_output.c:3247
 tcp_push_pending_frames include/net/tcp.h:2285 [inline]
 tcp_data_snd_check net/ipv4/tcp_input.c:6127 [inline]
 tcp_rcv_established+0xda2/0x12f0 net/ipv4/tcp_input.c:6610
 tcp_v4_do_rcv+0x91d/0xa30 net/ipv4/tcp_ipv4.c:1884
 tcp_v4_rcv+0x19f8/0x1db0 net/ipv4/tcp_ipv4.c:2319
 ip_protocol_deliver_rcu+0x395/0x790 net/ipv4/ip_input.c:207
 ip_local_deliver_finish+0x1fc/0x2f0 net/ipv4/ip_input.c:241
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ip_local_deliver+0xe8/0x1e0 net/ipv4/ip_input.c:262
 dst_input include/net/dst.h:480 [inline]
 ip_sublist_rcv_finish net/ipv4/ip_input.c:584 [inline]
 ip_list_rcv_finish net/ipv4/ip_input.c:636 [inline]
 ip_sublist_rcv+0x5a4/0x6a0 net/ipv4/ip_input.c:644
 ip_list_rcv+0x261/0x290 net/ipv4/ip_input.c:678
 __netif_receive_skb_list_ptype net/core/dev.c:6219 [inline]
 __netif_receive_skb_list_core+0x4dc/0x500 net/core/dev.c:6266
 __netif_receive_skb_list net/core/dev.c:6318 [inline]
 netif_receive_skb_list_internal+0x47d/0x5f0 net/core/dev.c:6409
 gro_normal_list include/net/gro.h:523 [inline]
 gro_flush_normal include/net/gro.h:531 [inline]
 napi_complete_done+0x19c/0x3f0 net/core/dev.c:6777
 virtqueue_napi_complete drivers/net/virtio_net.c:749 [inline]
 virtnet_poll+0x1bb1/0x2040 drivers/net/virtio_net.c:3091
 __napi_poll+0x61/0x330 net/core/dev.c:7704
 napi_poll net/core/dev.c:7767 [inline]
 net_rx_action+0x452/0x930 net/core/dev.c:7924
 handle_softirqs+0xb9/0x2a0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x39/0xc0 kernel/softirq.c:723
 common_interrupt+0x83/0x90 arch/x86/kernel/irq.c:326
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:688
 finish_task_switch+0x86/0x280 kernel/sched/core.c:5155
 context_switch kernel/sched/core.c:5301 [inline]
 __schedule+0x93c/0xd40 kernel/sched/core.c:6911
 __schedule_loop kernel/sched/core.c:6993 [inline]
 schedule+0x5e/0xd0 kernel/sched/core.c:7008
 schedule_timeout+0xca/0x180 kernel/time/sleep_timeout.c:99
 io_wq_worker+0x3a0/0x970 io_uring/io-wq.c:728
 ret_from_fork+0x150/0x360 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

read to 0xffff8881027a9588 of 2 bytes by interrupt on cpu 0:
 virtqueue_disable_cb_split drivers/virtio/virtio_ring.c:1046 [inline]
 virtqueue_disable_cb+0x4c/0x2c0 drivers/virtio/virtio_ring.c:3108
 virtqueue_napi_schedule drivers/net/virtio_net.c:738 [inline]
 skb_xmit_done+0xb0/0x1a0 drivers/net/virtio_net.c:786
 vring_interrupt+0x2d7/0x310 drivers/virtio/virtio_ring.c:3254
 __handle_irq_event_percpu+0x9c/0x4d0 kernel/irq/handle.c:209
 handle_irq_event_percpu kernel/irq/handle.c:246 [inline]
 handle_irq_event+0x64/0xf0 kernel/irq/handle.c:263
 handle_edge_irq+0x154/0x470 kernel/irq/chip.c:855
 generic_handle_irq_desc include/linux/irqdesc.h:186 [inline]
 handle_irq arch/x86/kernel/irq.c:262 [inline]
 call_irq_handler arch/x86/kernel/irq.c:-1 [inline]
 __common_interrupt+0x60/0xb0 arch/x86/kernel/irq.c:333
 common_interrupt+0x7e/0x90 arch/x86/kernel/irq.c:326
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:688
 decode_watchpoint kernel/kcsan/encoding.h:74 [inline]
 find_watchpoint kernel/kcsan/core.c:132 [inline]
 check_access kernel/kcsan/core.c:737 [inline]
 __tsan_read8+0x31/0x190 kernel/kcsan/core.c:1025
 _find_next_bit+0x29/0x90 lib/find_bit.c:157
 find_next_bit include/linux/find.h:73 [inline]
 ebitmap_next_positive security/selinux/ss/ebitmap.h:72 [inline]
 context_struct_compute_av+0x496/0xaf0 security/selinux/ss/services.c:661
 security_compute_av+0x34f/0xa20 security/selinux/ss/services.c:1177
 avc_compute_av+0x5d/0x430 security/selinux/avc.c:992
 avc_perm_nonode+0x5e/0xe0 security/selinux/avc.c:1117
 avc_has_perm_noaudit+0xf2/0x130 security/selinux/avc.c:1160
 avc_has_perm+0x60/0x190 security/selinux/avc.c:1195
 inode_has_perm security/selinux/hooks.c:1691 [inline]
 file_has_perm security/selinux/hooks.c:1787 [inline]
 selinux_revalidate_file_permission security/selinux/hooks.c:3793 [inline]
 selinux_file_permission+0x633/0x690 security/selinux/hooks.c:3814
 security_file_permission+0x3a/0x70 security/security.c:2367
 rw_verify_area fs/read_write.c:475 [inline]
 vfs_write+0x135/0x9f0 fs/read_write.c:679
 ksys_write+0xdc/0x1a0 fs/read_write.c:740
 __do_sys_write fs/read_write.c:751 [inline]
 __se_sys_write fs/read_write.c:748 [inline]
 __x64_sys_write+0x40/0x50 fs/read_write.c:748
 x64_sys_call+0x27e1/0x3020 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0001 -> 0x0000

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 3302 Comm: syz-executor Tainted: G        W           syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
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
