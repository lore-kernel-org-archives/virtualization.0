Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209DB145B24
	for <virtualization@lists.linux.dev>; Tue, 22 Oct 2024 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729591651; cv=none; b=XHGanJs1gxEug3buCem4Jx6StyuDOqGbC3mHD4oWW3onAFU5fvRW/czXNPPW0JogYXL/IagIRjjfgBL9rtwnMuEdjwj/AXc0NBoU5b1H37Y37lL4Oe+VHEtNL4g3USAD1QTw1mAyq/KjtgQWDkfFWvBB5bpHPBPW31mDu7iD/ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729591651; c=relaxed/simple;
	bh=TH/pFB4OX02AV8pIKa7KxCMott5NL6jdzHG23eePHiU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FFbB01PkdpuLQkkyNGw8eyfa0b4fF5nP96+L1o+vAJrQm/hBIAtZhAXpuXJgnOU3R4AsXKPzO8jGPh9WIs+UuXnBs5iNDXcsfvdGL2chn19tTWkcLwd6FqauX5oBxrvq1q/34OCXCS8gqU8aHW5bkNwqrTo9jVx20PdQL0eka0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ab369a523so533034339f.3
        for <virtualization@lists.linux.dev>; Tue, 22 Oct 2024 03:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729591649; x=1730196449;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9gBPkPXkPepVY/ibei8o+EXVX3iYI5mKC2OJ9oOAALI=;
        b=KHmzSBANofytqitDxrMPHVpHEbgBIFcatcvMyiRlDATKm7ykAtqdXxgc+GwXioPlhp
         AYIxTb+jEU1fVV4e8zFLCY0hffK121qbk10tNpd26PjZOgV7KRJuZ8vR4JQHp8zUcFwH
         ysg3jTISmpdWXxKGfOnkLuhNkO32LpAFwX2LKtdnvfl/L2WOEsiB8AlsNkOiXpGDVQ+x
         v05gmraIPICuKKh/jUCI4WU30iwALGpWCM20OfP7I74RsBe1Dei6jf/LQlPbmOsP/Xgh
         UVdNXpetThUr0sTLRjBh1c5tlOopgPD5JXD9qRHtbCoPJCmmnn0IUYw3cl0Bt+W0aMMa
         n4xw==
X-Forwarded-Encrypted: i=1; AJvYcCVXohxlMfJr/WsQSdKQ3rHGfs63Fon6weMpxOUgb07JC1oZgUysc4udnonm6f0jAkUX+lurSxkId2IvdUiwxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRsbnVg4qrwRZ2mZ+/BT2A+3zXEuYqCLArpjF9zZ7K499em3qP
	8/5im0pwvPUDEM3IfSxHrcqcvyBNPXwHwP36Bsm7GxLnIhBsWovvzLt6RIWVIkunjvK3ew7487O
	N3etVPVeei1LW1DFlKT0QboQmvp59ocY2R+4GIOC09ztZ02TIdnWIpWE=
X-Google-Smtp-Source: AGHT+IF1YcYvWS2xuePCjwkI0PyK72qNk/SBP16dG0bq2Fzl6rNS80RMXgSySPv/c4cR4jQcI42/YcNfyIuGl3C8H2BTNxLO8wh9
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b8c:b0:83a:c384:ea2a with SMTP id
 ca18e2360f4ac-83ae8aaae55mr412311839f.6.1729591649236; Tue, 22 Oct 2024
 03:07:29 -0700 (PDT)
Date: Tue, 22 Oct 2024 03:07:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67177961.050a0220.1e4b4d.0073.GAE@google.com>
Subject: [syzbot] [virt?] KCSAN: data-race in virtqueue_disable_cb /
 virtqueue_disable_cb (5)
From: syzbot <syzbot+9d46c74b27b961b244a9@syzkaller.appspotmail.com>
To: eperezma@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	mst@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3d5ad2d4eca3 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154b7487980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fd83253b74c9c570
dashboard link: https://syzkaller.appspot.com/bug?extid=9d46c74b27b961b244a9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9d112e37e26b/disk-3d5ad2d4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d8f036bdcdb7/vmlinux-3d5ad2d4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/61727d52db48/bzImage-3d5ad2d4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d46c74b27b961b244a9@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in virtqueue_disable_cb / virtqueue_disable_cb

read to 0xffff888102c18178 of 2 bytes by interrupt on cpu 1:
 virtqueue_disable_cb_split drivers/virtio/virtio_ring.c:885 [inline]
 virtqueue_disable_cb+0x63/0x180 drivers/virtio/virtio_ring.c:2446
 skb_xmit_done+0x5f/0x140 drivers/net/virtio_net.c:715
 vring_interrupt+0x161/0x190 drivers/virtio/virtio_ring.c:2595
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
 kcsan_setup_watchpoint+0x404/0x410 kernel/kcsan/core.c:705
 format_decode+0x1d1/0x8a0 lib/vsprintf.c:2554
 vsnprintf+0xc6/0xe30 lib/vsprintf.c:2755
 sprintf+0x89/0xb0 lib/vsprintf.c:3007
 print_caller kernel/printk/printk.c:1373 [inline]
 info_print_prefix+0x142/0x1a0 kernel/printk/printk.c:1390
 record_print_text kernel/printk/printk.c:1437 [inline]
 printk_get_next_message+0x446/0x6f0 kernel/printk/printk.c:2978
 console_emit_next_record kernel/printk/printk.c:3046 [inline]
 console_flush_all+0x28a/0x770 kernel/printk/printk.c:3180
 __console_flush_and_unlock kernel/printk/printk.c:3239 [inline]
 console_unlock+0xab/0x330 kernel/printk/printk.c:3279
 vprintk_emit+0x3f4/0x680 kernel/printk/printk.c:2407
 vprintk_default+0x26/0x30 kernel/printk/printk.c:2422
 vprintk+0x75/0x80 kernel/printk/printk_safe.c:68
 _printk+0x7a/0xa0 kernel/printk/printk.c:2432
 batadv_check_known_mac_addr+0x153/0x180 net/batman-adv/hard-interface.c:528
 batadv_hard_if_event+0x4b0/0x1010 net/batman-adv/hard-interface.c:998
 notifier_call_chain kernel/notifier.c:93 [inline]
 raw_notifier_call_chain+0x6f/0x1d0 kernel/notifier.c:461
 call_netdevice_notifiers_info+0xae/0x100 net/core/dev.c:1996
 call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
 call_netdevice_notifiers net/core/dev.c:2048 [inline]
 dev_set_mac_address+0x1ff/0x260 net/core/dev.c:9104
 dev_set_mac_address_user+0x31/0x50 net/core/dev.c:9118
 do_setlink+0x513/0x2490 net/core/rtnetlink.c:2884
 __rtnl_newlink net/core/rtnetlink.c:3725 [inline]
 rtnl_newlink+0x11a3/0x1690 net/core/rtnetlink.c:3772
 rtnetlink_rcv_msg+0x6aa/0x710 net/core/rtnetlink.c:6675
 netlink_rcv_skb+0x12c/0x230 net/netlink/af_netlink.c:2551
 rtnetlink_rcv+0x1c/0x30 net/core/rtnetlink.c:6693
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x599/0x670 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x5cc/0x6e0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x140/0x180 net/socket.c:744
 __sys_sendto+0x1d6/0x260 net/socket.c:2214
 __do_sys_sendto net/socket.c:2226 [inline]
 __se_sys_sendto net/socket.c:2222 [inline]
 __x64_sys_sendto+0x78/0x90 net/socket.c:2222
 x64_sys_call+0x2959/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

write to 0xffff888102c18178 of 2 bytes by task 3255 on cpu 0:
 virtqueue_disable_cb_split drivers/virtio/virtio_ring.c:886 [inline]
 virtqueue_disable_cb+0x85/0x180 drivers/virtio/virtio_ring.c:2446
 start_xmit+0x14b/0x1260 drivers/net/virtio_net.c:3067
 __netdev_start_xmit include/linux/netdevice.h:4916 [inline]
 netdev_start_xmit include/linux/netdevice.h:4925 [inline]
 xmit_one net/core/dev.c:3588 [inline]
 dev_hard_start_xmit+0x119/0x3f0 net/core/dev.c:3604
 sch_direct_xmit+0x1a9/0x580 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:3821 [inline]
 __dev_queue_xmit+0xf1a/0x2040 net/core/dev.c:4394
 dev_queue_xmit include/linux/netdevice.h:3094 [inline]
 neigh_hh_output include/net/neighbour.h:526 [inline]
 neigh_output include/net/neighbour.h:540 [inline]
 ip_finish_output2+0x73d/0x8b0 net/ipv4/ip_output.c:236
 ip_finish_output+0x11a/0x2a0 net/ipv4/ip_output.c:324
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip_output+0xab/0x170 net/ipv4/ip_output.c:434
 dst_output include/net/dst.h:450 [inline]
 ip_local_out net/ipv4/ip_output.c:130 [inline]
 __ip_queue_xmit+0xbcc/0xbf0 net/ipv4/ip_output.c:536
 ip_queue_xmit+0x38/0x50 net/ipv4/ip_output.c:550
 __tcp_transmit_skb+0x15b0/0x1970 net/ipv4/tcp_output.c:1466
 __tcp_send_ack+0x1de/0x2e0 net/ipv4/tcp_output.c:4268
 tcp_send_ack+0x27/0x30 net/ipv4/tcp_output.c:4274
 __tcp_cleanup_rbuf+0x149/0x280 net/ipv4/tcp.c:1505
 tcp_cleanup_rbuf net/ipv4/tcp.c:1516 [inline]
 tcp_recvmsg_locked+0x1be3/0x2100 net/ipv4/tcp.c:2821
 tcp_recvmsg+0x13c/0x490 net/ipv4/tcp.c:2851
 inet_recvmsg+0xbd/0x290 net/ipv4/af_inet.c:885
 sock_recvmsg_nosec net/socket.c:1051 [inline]
 sock_recvmsg+0xfe/0x170 net/socket.c:1073
 sock_read_iter+0x14c/0x1a0 net/socket.c:1143
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x5f6/0x720 fs/read_write.c:569
 ksys_read+0xeb/0x1b0 fs/read_write.c:712
 __do_sys_read fs/read_write.c:722 [inline]
 __se_sys_read fs/read_write.c:720 [inline]
 __x64_sys_read+0x42/0x50 fs/read_write.c:720
 x64_sys_call+0x27d3/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:1
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000 -> 0x0001

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 3255 Comm: syz-executor Not tainted 6.12.0-rc3-syzkaller-00389-g3d5ad2d4eca3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
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
