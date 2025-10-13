Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2B42C234E
	for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 05:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760333383; cv=none; b=qlLQg4MVvFS/jAIF1gUxu0pDPYlh84/WJmCDDUN9pRVv7r3a3ugKt5DRNRz2XhvNf4tXl4kbIdSQDiHGsAPCJbxWh19mZQWU0CyjamaVg1i6oZ7Oty84veH2OEmsaS/Hl+nHVTB30cvA2Gx+bn9l3AivvpIDwBY5AElZRi8iRTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760333383; c=relaxed/simple;
	bh=/SrM4iWBiCeTl/ERjU6eviZ9JjOQ6nLsu8UTiq9ILR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHjNdeebCImNXXYzg5MBover89+w2CUy/NR8WnmIjnejHqdQSjNS4V5IbcQSmLDjI1a9nWi0qQqrqXf+WqpKfFg0Jl+NIx+LbTH9OA0vmilUP5wlBrgiE5z0Zqp4yhvghXPnJykNHmNtMN1iz28YmDavhUG+lOlA4dZduHo8vYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMCD5NK8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMCD5NK8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760333380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kqo2ykAZEDr50CemvTt+UXIbTlPmHW0pXfnI+jeELFQ=;
	b=UMCD5NK8SaqaCa/hQuBE0s1WL5IPS2vJv1Ap72DD3adX5C+Ak+r3ejvLl5efQyBsBLTdMJ
	AhwvtTmvpMX18QHsSsY12breY/UhfbfF1H/1xy91lnTWS4bue8/RV7xZyVx39bDDEbmj6S
	rafsumI7V2HXWj9wfjrJh3i5uv4o1Ts=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-Nk4jvbKGNby-cQjSkFv1pQ-1; Mon, 13 Oct 2025 01:29:39 -0400
X-MC-Unique: Nk4jvbKGNby-cQjSkFv1pQ-1
X-Mimecast-MFC-AGG-ID: Nk4jvbKGNby-cQjSkFv1pQ_1760333378
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33428befc5bso9870052a91.0
        for <virtualization@lists.linux.dev>; Sun, 12 Oct 2025 22:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760333378; x=1760938178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kqo2ykAZEDr50CemvTt+UXIbTlPmHW0pXfnI+jeELFQ=;
        b=d94trAEX8kps1VEEtcI0LYWGfZThACVIl82A/Sxx3IpKu3/SffkU2x6OLUo/kcqXfN
         fcktKMzwjxC1mFof4yHPdNRwFo2rpeiYGRtg2CAYBV0fDUlOVU492x0ByT3WZR9iqUT0
         50K/jPp0B4hCqXCQs8o0IO9KH+/l89/759qhobfGUmtslOQmUDbHuBzxaNA8ig2qYYL2
         Yrsc3Lqi1LpE7CWJSZ7xdK9fiy7NYdPqhX+Lgjvb95lv4Bh2Ci+u5ChwK+bOHzo/0paN
         uspiyEWUMCtO+CbApWFBZi1zm5vxUqNkVPyLVbrKVySyvceoMHrq3TQdBSZIKgPAkm8a
         AHOg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ4PB2pu+IXSx9abE8mdh7y3wtfzAXqJEeAD4KgkAfWFMYXDWX2kWyv/0XU7zPHNwAcZTE6rJCB/ttqTMldw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwF3Wb5AbkxESKP8xye7eOj7DBv2a/4e9EqHnxNp1tYQUjJWJQY
	t/FG/lI9EdW5mrQYrlklbKot4J1hJ2cdbPdanFTS7BQgG8MD+PMxiGd6IwhhxVIpJ+2P0PpNhv3
	PMHguLeJxaLDRa/cWR0qfwhmH04GfyJAKd5xsirRAWj7NP/EE8huw14BtWU1k+Zqm2m6ha7Tlld
	x9G34xZkFjoSg+BRj3pvq6+DDes081KRVLQYsCeL0RhiM=
X-Gm-Gg: ASbGncurKZKbMl0TlqPef8O01wtsglSKsXtMgJ8YXPFRs6NjS46p6a65a1rVPx+EiVH
	T2WWhOO69d0gBUmm/Z3JjKn3qC+Rwink2oXsE+FktMRnCpbFucNctaTOQTWtTk7iMbl9THKuK8W
	DZqN1LAdLZfIqgsZYeNQ==
X-Received: by 2002:a17:90b:4d8c:b0:32e:9da9:3e60 with SMTP id 98e67ed59e1d1-33b513b4be4mr23985255a91.36.1760333378131;
        Sun, 12 Oct 2025 22:29:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHehWnrGn7DuvJ/xSojls8MCxOSJWhG/ZI0Kv22UDdxDhSF5mF0LLfkXAAkQBSq7nVOxKn9BGX7Xu+k2Kj6giY=
X-Received: by 2002:a17:90b:4d8c:b0:32e:9da9:3e60 with SMTP id
 98e67ed59e1d1-33b513b4be4mr23985245a91.36.1760333377653; Sun, 12 Oct 2025
 22:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <68e96ebf.050a0220.91a22.0177.GAE@google.com> <CACGkMEtnrayDWKFdJ1P22QyCrZuDK0C2LihhOtvhUyTOKSp_HQ@mail.gmail.com>
In-Reply-To: <CACGkMEtnrayDWKFdJ1P22QyCrZuDK0C2LihhOtvhUyTOKSp_HQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Oct 2025 13:29:26 +0800
X-Gm-Features: AS18NWDjkXzbfbcL9GnZvyYpjpGC9qt1RXSQFGkoxNNnNhgsMQJYKM2vjPwpQUQ
Message-ID: <CACGkMEt0aJh1yAj+q1UNnXToLa_yGc9fT_HfeNptHsOQ7vXG+w@mail.gmail.com>
Subject: Re: [syzbot] [virt?] upstream test error: KMSAN: use-after-free in vring_map_one_sg
To: syzbot <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: eperezma@redhat.com, linux-kernel@vger.kernel.org, mst@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
X-Mimecast-Spam-Score: 1
X-Mimecast-MFC-PROC-ID: pdBL4PomMRmBntAH6RgAzRjhgPf9hcLiUl0tlWr9rqw_1760333378
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding Paolo.

On Sat, Oct 11, 2025 at 3:40=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> #syz test
>
> On Sat, Oct 11, 2025 at 4:38=E2=80=AFAM syzbot
> <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com> wrote:

Paolo, it looks like the GSO tunnel features will leave uninitialized
vnet header field which trigger KMSAN warning.

Please have a look at the patch (which has been tested by syzbot) or
propose another one.

Thanks

> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    ba9dac987319 Merge tag 'libnvdimm-for-6.18' of git://gi=
t.k..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D138581e2580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dad506767107=
aacda
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dac856b8b866cc=
a41352c
> > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7=
976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/ce6a737acd38/d=
isk-ba9dac98.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/d7053b626642/vmli=
nux-ba9dac98.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/13f2d7e62179=
/bzImage-ba9dac98.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com
> >
> > 8021q: adding VLAN 0 to HW filter on device bond0
> > eql: remember to turn off Van-Jacobson compression on your slave device=
s
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > BUG: KMSAN: use-after-free in vring_map_one_sg+0x290/0x7b0 drivers/virt=
io/virtio_ring.c:401
> >  vring_map_one_sg+0x290/0x7b0 drivers/virtio/virtio_ring.c:401
> >  virtqueue_add_split drivers/virtio/virtio_ring.c:608 [inline]
> >  virtqueue_add+0x32aa/0x6320 drivers/virtio/virtio_ring.c:2281
> >  virtqueue_add_outbuf+0x89/0xa0 drivers/virtio/virtio_ring.c:2342
> >  virtnet_add_outbuf drivers/net/virtio_net.c:574 [inline]
> >  xmit_skb drivers/net/virtio_net.c:3343 [inline]
> >  start_xmit+0x274d/0x4860 drivers/net/virtio_net.c:3367
> >  __netdev_start_xmit include/linux/netdevice.h:5248 [inline]
> >  netdev_start_xmit include/linux/netdevice.h:5257 [inline]
> >  xmit_one net/core/dev.c:3845 [inline]
> >  dev_hard_start_xmit+0x22c/0xa30 net/core/dev.c:3861
> >  sch_direct_xmit+0x3b2/0xcf0 net/sched/sch_generic.c:344
> >  __dev_xmit_skb net/core/dev.c:4152 [inline]
> >  __dev_queue_xmit+0x3588/0x5e60 net/core/dev.c:4729
> >  dev_queue_xmit include/linux/netdevice.h:3365 [inline]
> >  lapbeth_data_transmit+0x352/0x480 drivers/net/wan/lapbether.c:260
> >  lapb_data_transmit+0x90/0xf0 net/lapb/lapb_iface.c:447
> >  lapb_transmit_buffer+0x260/0x330 net/lapb/lapb_out.c:149
> >  lapb_send_control+0x458/0x5b0 net/lapb/lapb_subr.c:251
> >  lapb_establish_data_link+0xa6/0xd0 net/lapb/lapb_out.c:-1
> >  lapb_device_event+0xb2a/0xbc0 net/lapb/lapb_iface.c:-1
> >  notifier_call_chain kernel/notifier.c:85 [inline]
> >  raw_notifier_call_chain+0xe0/0x410 kernel/notifier.c:453
> >  call_netdevice_notifiers_info+0x1ac/0x2b0 net/core/dev.c:2229
> >  call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
> >  call_netdevice_notifiers net/core/dev.c:2281 [inline]
> >  __dev_notify_flags+0x20d/0x3c0 net/core/dev.c:-1
> >  netif_change_flags+0x162/0x1e0 net/core/dev.c:9705
> >  dev_change_flags+0x18c/0x320 net/core/dev_api.c:68
> >  devinet_ioctl+0x1186/0x2500 net/ipv4/devinet.c:1199
> >  inet_ioctl+0x4c0/0x6f0 net/ipv4/af_inet.c:1003
> >  sock_do_ioctl+0x9c/0x480 net/socket.c:1254
> >  sock_ioctl+0x70b/0xd60 net/socket.c:1375
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:597 [inline]
> >  __se_sys_ioctl+0x239/0x400 fs/ioctl.c:583
> >  __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:583
> >  x64_sys_call+0x1cbc/0x3e30 arch/x86/include/generated/asm/syscalls_64.=
h:17
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Uninit was created at:
> >  slab_free_hook mm/slub.c:2440 [inline]
> >  slab_free mm/slub.c:6566 [inline]
> >  kmem_cache_free+0x2b0/0x1490 mm/slub.c:6676
> >  skb_kfree_head net/core/skbuff.c:1046 [inline]
> >  skb_free_head+0x13c/0x3a0 net/core/skbuff.c:1060
> >  skb_release_data+0x9f7/0xac0 net/core/skbuff.c:1087
> >  skb_release_all net/core/skbuff.c:1152 [inline]
> >  __kfree_skb+0x6b/0x260 net/core/skbuff.c:1166
> >  consume_skb+0x83/0x230 net/core/skbuff.c:1398
> >  skb_free_datagram+0x1e/0x30 net/core/datagram.c:324
> >  netlink_recvmsg+0xad1/0xfe0 net/netlink/af_netlink.c:1974
> >  sock_recvmsg_nosec net/socket.c:1078 [inline]
> >  sock_recvmsg+0x2dc/0x390 net/socket.c:1100
> >  ____sys_recvmsg+0x193/0x610 net/socket.c:2850
> >  ___sys_recvmsg+0x20b/0x850 net/socket.c:2892
> >  __sys_recvmsg net/socket.c:2925 [inline]
> >  __do_sys_recvmsg net/socket.c:2931 [inline]
> >  __se_sys_recvmsg net/socket.c:2928 [inline]
> >  __x64_sys_recvmsg+0x20e/0x3d0 net/socket.c:2928
> >  x64_sys_call+0x35f0/0x3e30 arch/x86/include/generated/asm/syscalls_64.=
h:48
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Bytes 0-17 of 18 are uninitialized
> > Memory access of size 18 starts at ffff88811a0f1000
> >
> > CPU: 1 UID: 0 PID: 5441 Comm: dhcpcd Not tainted syzkaller #0 PREEMPT(n=
one)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 08/18/2025
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
> >

