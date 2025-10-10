Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB35221FF38
	for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760128706; cv=none; b=GGJ5NWC5Htb+Z4EFMMrhkUDhWrDlNsawoTfRaXXEpW3C2UPfx7XHuBUDn9CrRQ/aqAQDyKkFpmyNTcOijNqkm73sbsIgNj+fQPKFlsyiF5mhbb4HL2oUPNhyMkJMDy22XzXtwe5A1mdtKMhAR0O8rq7QEh6DoZ6InA7yJLC0kME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760128706; c=relaxed/simple;
	bh=yLew8Rl01k3KaW6flGFWAhuUGx9UAQv84e7MoJrKvkc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EOZmHsBVTbhYVp8vArA33heMTOWmAsfL9gGaR4boNWJsYvBH4Dx5/LuIPng0WkKFAN0n0OS3ur1OA3q5yrNSqtIcfOt+0b8qK9+h6BvJ40467FfU3KskzXGSpnFzhv0FFy/LN2n98sZJ1mKw/1XgWBVHN8gf7OvuPJUV6teedjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-426d38c1e8fso59618025ab.0
        for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 13:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760128704; x=1760733504;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ui6K6YF+spReZ25GO2naUTGC6+wguMdNBIkM6SNvYNg=;
        b=VcjiN6j0n7wDN5bt/+ZkCqeqnPs2fUiamXQQb523e/M4LO8aUpzhhEmxsu3UysIUf2
         zSBgMPM9HEPlhvN2skQHVIlI2r0g5pzfWBacFy2fVY3S7RmsE5xvOudgPhgDPTsddu+0
         XUncVWR7Wo7uEvJCaArmMdeQYywO1uD2bEastHfplqcH2vWj7oNRwyKyjoxNEuyN+n6H
         q7tegRux2VCdHl3UH64hdHDJFavZQkALvDQskZ5FHolj06tISWPFKkicJJwlSVB0/gbt
         r0a8r6bVitWoix8WGSPUEsMHz4X47Xyhpyp5T0bUSPUaRtoDEiSZm07Bsml0gVA5bgG/
         sarg==
X-Forwarded-Encrypted: i=1; AJvYcCX+SnuGiDjYvgDySdnzndoPxCamU52M2VYhw2i2t3z29idnIW4bVQXFXff6TogBvSiCwI86rX7u9ZI6AqT01Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywy/wazGroKOAD7LMla+qbdJOEN1UDLV5Dncc3dZxtNUftZZGVn
	ssoQyGrtD6IOophL+2y5ZKy4XtwxGU9Y9CnQc9Ve9F7TWz0xQLPUBQ+6e6cXiFX6QfJISxCrspM
	+E81F+Wfv7lZJgpap/XvNNgeKJ034QKeWqrGN//G3tjfY3xu5Hvk9SIntwb4=
X-Google-Smtp-Source: AGHT+IFKU/qp78m9hPZWGHOoYx9KU8423H9AQ6Dc2vVvGyhXIIH4zeHoBYjozxRonn+wsYf586Uut8Jo6UgY64keydg4uoJLIHel
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c7:b0:42d:8a3f:ec8b with SMTP id
 e9e14a558f8ab-42f87362229mr135800235ab.3.1760128703882; Fri, 10 Oct 2025
 13:38:23 -0700 (PDT)
Date: Fri, 10 Oct 2025 13:38:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e96ebf.050a0220.91a22.0177.GAE@google.com>
Subject: [syzbot] [virt?] upstream test error: KMSAN: use-after-free in vring_map_one_sg
From: syzbot <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com>
To: eperezma@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	mst@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ba9dac987319 Merge tag 'libnvdimm-for-6.18' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138581e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ad506767107aacda
dashboard link: https://syzkaller.appspot.com/bug?extid=ac856b8b866cca41352c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ce6a737acd38/disk-ba9dac98.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d7053b626642/vmlinux-ba9dac98.xz
kernel image: https://storage.googleapis.com/syzbot-assets/13f2d7e62179/bzImage-ba9dac98.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device bond0
eql: remember to turn off Van-Jacobson compression on your slave devices
=====================================================
BUG: KMSAN: use-after-free in vring_map_one_sg+0x290/0x7b0 drivers/virtio/virtio_ring.c:401
 vring_map_one_sg+0x290/0x7b0 drivers/virtio/virtio_ring.c:401
 virtqueue_add_split drivers/virtio/virtio_ring.c:608 [inline]
 virtqueue_add+0x32aa/0x6320 drivers/virtio/virtio_ring.c:2281
 virtqueue_add_outbuf+0x89/0xa0 drivers/virtio/virtio_ring.c:2342
 virtnet_add_outbuf drivers/net/virtio_net.c:574 [inline]
 xmit_skb drivers/net/virtio_net.c:3343 [inline]
 start_xmit+0x274d/0x4860 drivers/net/virtio_net.c:3367
 __netdev_start_xmit include/linux/netdevice.h:5248 [inline]
 netdev_start_xmit include/linux/netdevice.h:5257 [inline]
 xmit_one net/core/dev.c:3845 [inline]
 dev_hard_start_xmit+0x22c/0xa30 net/core/dev.c:3861
 sch_direct_xmit+0x3b2/0xcf0 net/sched/sch_generic.c:344
 __dev_xmit_skb net/core/dev.c:4152 [inline]
 __dev_queue_xmit+0x3588/0x5e60 net/core/dev.c:4729
 dev_queue_xmit include/linux/netdevice.h:3365 [inline]
 lapbeth_data_transmit+0x352/0x480 drivers/net/wan/lapbether.c:260
 lapb_data_transmit+0x90/0xf0 net/lapb/lapb_iface.c:447
 lapb_transmit_buffer+0x260/0x330 net/lapb/lapb_out.c:149
 lapb_send_control+0x458/0x5b0 net/lapb/lapb_subr.c:251
 lapb_establish_data_link+0xa6/0xd0 net/lapb/lapb_out.c:-1
 lapb_device_event+0xb2a/0xbc0 net/lapb/lapb_iface.c:-1
 notifier_call_chain kernel/notifier.c:85 [inline]
 raw_notifier_call_chain+0xe0/0x410 kernel/notifier.c:453
 call_netdevice_notifiers_info+0x1ac/0x2b0 net/core/dev.c:2229
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 __dev_notify_flags+0x20d/0x3c0 net/core/dev.c:-1
 netif_change_flags+0x162/0x1e0 net/core/dev.c:9705
 dev_change_flags+0x18c/0x320 net/core/dev_api.c:68
 devinet_ioctl+0x1186/0x2500 net/ipv4/devinet.c:1199
 inet_ioctl+0x4c0/0x6f0 net/ipv4/af_inet.c:1003
 sock_do_ioctl+0x9c/0x480 net/socket.c:1254
 sock_ioctl+0x70b/0xd60 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0x239/0x400 fs/ioctl.c:583
 __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:583
 x64_sys_call+0x1cbc/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_free_hook mm/slub.c:2440 [inline]
 slab_free mm/slub.c:6566 [inline]
 kmem_cache_free+0x2b0/0x1490 mm/slub.c:6676
 skb_kfree_head net/core/skbuff.c:1046 [inline]
 skb_free_head+0x13c/0x3a0 net/core/skbuff.c:1060
 skb_release_data+0x9f7/0xac0 net/core/skbuff.c:1087
 skb_release_all net/core/skbuff.c:1152 [inline]
 __kfree_skb+0x6b/0x260 net/core/skbuff.c:1166
 consume_skb+0x83/0x230 net/core/skbuff.c:1398
 skb_free_datagram+0x1e/0x30 net/core/datagram.c:324
 netlink_recvmsg+0xad1/0xfe0 net/netlink/af_netlink.c:1974
 sock_recvmsg_nosec net/socket.c:1078 [inline]
 sock_recvmsg+0x2dc/0x390 net/socket.c:1100
 ____sys_recvmsg+0x193/0x610 net/socket.c:2850
 ___sys_recvmsg+0x20b/0x850 net/socket.c:2892
 __sys_recvmsg net/socket.c:2925 [inline]
 __do_sys_recvmsg net/socket.c:2931 [inline]
 __se_sys_recvmsg net/socket.c:2928 [inline]
 __x64_sys_recvmsg+0x20e/0x3d0 net/socket.c:2928
 x64_sys_call+0x35f0/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:48
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Bytes 0-17 of 18 are uninitialized
Memory access of size 18 starts at ffff88811a0f1000

CPU: 1 UID: 0 PID: 5441 Comm: dhcpcd Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
=====================================================


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
