Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583481D63FB
	for <virtualization@lists.linux.dev>; Sat, 11 Oct 2025 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760168429; cv=none; b=bTvz8jYdMLYFvcg3cmYJeX3aGY2V1Cc90JsahLscJqF1AyUsrVn7pEKkk7T1ea3qWvLRvL+xX2u7X8NPwNx/xQ0OxE7TcNOlp+hOsWW4Z8Mu9FzYt8OcYP+fl10tM4iQZg67RUKw7L8763ejqvuKVIww+4fKQNjgZYHRfk+cmmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760168429; c=relaxed/simple;
	bh=TA0k3YjRjA41KEErlQdnBBCx3Ah3J39R3wyDKbIiZjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUxdLCe4JS1CunHfaEXepmcC9rJlJUZ8ciaeyGp+RMDz7foYN/NvieACy6D2qpSYT754boIDTn4XBNXvxKYXSnC/1C1/0d9p9jI1jbNbTQGQjYBUmKz3fWWs2rVI6fyRPFCJ09T7n61swctiSW0zAt/W3+mNa7h7oJ+hhHqPDbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2a4TPOU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2a4TPOU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760168426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G+HvFgleKoEagtaoLLdopN7AaVq6KkyOiEGfh/tU+/A=;
	b=H2a4TPOUmW5nt41sDnfvYAyKRvU+KpFGRBhoeZIYV5Ad+hfuf4nDDrHbqUuAFA8sdgprxP
	0xbE8nUAwqzZlIGxAWLOPWXpOVIUS9HMklyY9KtjoS6aV/yqjeAH5Ilw/LiKa5P6cTlb4/
	lmiGsHVydEzNfUC9BcGOWgqn7JYRqLw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-bQQ5-wvsNl6ZzWSSSKjR6Q-1; Sat, 11 Oct 2025 03:40:24 -0400
X-MC-Unique: bQQ5-wvsNl6ZzWSSSKjR6Q-1
X-Mimecast-MFC-AGG-ID: bQQ5-wvsNl6ZzWSSSKjR6Q_1760168424
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-28a5b8b12bbso133144165ad.2
        for <virtualization@lists.linux.dev>; Sat, 11 Oct 2025 00:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760168424; x=1760773224;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+HvFgleKoEagtaoLLdopN7AaVq6KkyOiEGfh/tU+/A=;
        b=rlXoVaSX7SVs36GRe57CqzypxB3ZtI9D8CnY1896bkHsxkeNE4tfl93dq+7y93HeGn
         LxP65COHoPhMXYGmNdrAKxUTqMYnV/w22j1Lpuft6UPPO1axyW479uj6WDsOQe/WQMRm
         iHTBvvr1e4HM3x1ou/CEYv+P62bBvY5kJfyyodzA20/s0iwZgh1ftLSs15gs/Lgb+7K4
         g7tCNRhYn036ClerTNU++aPiP7EMdak8KfacVEoAT9pH2hvlrbQRXuW4t9UZAPetWkTr
         L9jpCjpHMrY5HeEtJik/1TwSmbz6/P/+geDwxhagI3J3Gg375+WWzYGOCwmGFrBzRMYR
         yYxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH4eOkJ4t/sScGxt17JSamTd389Grm3SnT2/njafJwRTNNq0d/cCu+jqyD2ZxC/hnxwTFYK16idx/QBvQ8/w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7tErdP50wGeA7UxzoY+w+GqcL0Vxc8KWDDu1Y4Z/z2DAXwm4Q
	SyDfxbnl+X+VJqrPEzb/jbmiHIUlvD3icB8XnzNWrMLWm6xR2IgoqoE7K/it2Gn75hs2kwxEzOg
	DVb42m2pztBLY/JKhAuY5YjDG+cvE1qoQ89CNjcu5GAQ3A+VtRdcU2Vq+/ytvMjKNgTumna7+IC
	FuOp98MYhAeLt5oVRbGCNM+fsaX/sVb2EJAzKeWALmYwY=
X-Gm-Gg: ASbGncscX8qKsBZIa1bTFkPkK3/fNily1PAr84UWDSnMxzkBJFYgDZs3H1IWTNtrlnX
	Azr9uWMiuReobXFq/CUZVKocm0ut6wox5lxaV9mwfEINowiHiVMN316EZPOjXFnYBT/m8kxuqMl
	Xn5MnBwAETXoPy3RAVpA==
X-Received: by 2002:a17:903:2f0e:b0:272:f9c3:31f7 with SMTP id d9443c01a7336-290273ffd9cmr167006335ad.50.1760168423817;
        Sat, 11 Oct 2025 00:40:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtZnhcv6BoIZIaKDbrheN308bKIg6JD6364MjrrRlaN98aWPPIfk9wzVrdt6B2sDalpgU8WktFlvIEeukqn9s=
X-Received: by 2002:a17:903:2f0e:b0:272:f9c3:31f7 with SMTP id
 d9443c01a7336-290273ffd9cmr167006105ad.50.1760168423369; Sat, 11 Oct 2025
 00:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <68e96ebf.050a0220.91a22.0177.GAE@google.com>
In-Reply-To: <68e96ebf.050a0220.91a22.0177.GAE@google.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 11 Oct 2025 15:40:09 +0800
X-Gm-Features: AS18NWCxQITizDxkLHpEORO_VmTjmunEoBUKbnws2H-p5oQv6hSe8QHTD5zU0RY
Message-ID: <CACGkMEtnrayDWKFdJ1P22QyCrZuDK0C2LihhOtvhUyTOKSp_HQ@mail.gmail.com>
Subject: Re: [syzbot] [virt?] upstream test error: KMSAN: use-after-free in vring_map_one_sg
To: syzbot <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com>
Cc: eperezma@redhat.com, linux-kernel@vger.kernel.org, mst@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
X-Mimecast-Spam-Score: 1
X-Mimecast-MFC-PROC-ID: JM0su5G3WonjkuUVhqKbsiNJ2ncwbSeGYYB29UYhAMw_1760168424
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="0000000000009ed7190640dd25dc"

--0000000000009ed7190640dd25dc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Sat, Oct 11, 2025 at 4:38=E2=80=AFAM syzbot
<syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    ba9dac987319 Merge tag 'libnvdimm-for-6.18' of git://git.=
k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D138581e258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dad506767107aa=
cda
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dac856b8b866cca4=
1352c
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b797=
6-1~exp1~20250708183702.136), Debian LLD 20.1.8
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ce6a737acd38/dis=
k-ba9dac98.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d7053b626642/vmlinu=
x-ba9dac98.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/13f2d7e62179/b=
zImage-ba9dac98.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com
>
> 8021q: adding VLAN 0 to HW filter on device bond0
> eql: remember to turn off Van-Jacobson compression on your slave devices
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: use-after-free in vring_map_one_sg+0x290/0x7b0 drivers/virtio=
/virtio_ring.c:401
>  vring_map_one_sg+0x290/0x7b0 drivers/virtio/virtio_ring.c:401
>  virtqueue_add_split drivers/virtio/virtio_ring.c:608 [inline]
>  virtqueue_add+0x32aa/0x6320 drivers/virtio/virtio_ring.c:2281
>  virtqueue_add_outbuf+0x89/0xa0 drivers/virtio/virtio_ring.c:2342
>  virtnet_add_outbuf drivers/net/virtio_net.c:574 [inline]
>  xmit_skb drivers/net/virtio_net.c:3343 [inline]
>  start_xmit+0x274d/0x4860 drivers/net/virtio_net.c:3367
>  __netdev_start_xmit include/linux/netdevice.h:5248 [inline]
>  netdev_start_xmit include/linux/netdevice.h:5257 [inline]
>  xmit_one net/core/dev.c:3845 [inline]
>  dev_hard_start_xmit+0x22c/0xa30 net/core/dev.c:3861
>  sch_direct_xmit+0x3b2/0xcf0 net/sched/sch_generic.c:344
>  __dev_xmit_skb net/core/dev.c:4152 [inline]
>  __dev_queue_xmit+0x3588/0x5e60 net/core/dev.c:4729
>  dev_queue_xmit include/linux/netdevice.h:3365 [inline]
>  lapbeth_data_transmit+0x352/0x480 drivers/net/wan/lapbether.c:260
>  lapb_data_transmit+0x90/0xf0 net/lapb/lapb_iface.c:447
>  lapb_transmit_buffer+0x260/0x330 net/lapb/lapb_out.c:149
>  lapb_send_control+0x458/0x5b0 net/lapb/lapb_subr.c:251
>  lapb_establish_data_link+0xa6/0xd0 net/lapb/lapb_out.c:-1
>  lapb_device_event+0xb2a/0xbc0 net/lapb/lapb_iface.c:-1
>  notifier_call_chain kernel/notifier.c:85 [inline]
>  raw_notifier_call_chain+0xe0/0x410 kernel/notifier.c:453
>  call_netdevice_notifiers_info+0x1ac/0x2b0 net/core/dev.c:2229
>  call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
>  call_netdevice_notifiers net/core/dev.c:2281 [inline]
>  __dev_notify_flags+0x20d/0x3c0 net/core/dev.c:-1
>  netif_change_flags+0x162/0x1e0 net/core/dev.c:9705
>  dev_change_flags+0x18c/0x320 net/core/dev_api.c:68
>  devinet_ioctl+0x1186/0x2500 net/ipv4/devinet.c:1199
>  inet_ioctl+0x4c0/0x6f0 net/ipv4/af_inet.c:1003
>  sock_do_ioctl+0x9c/0x480 net/socket.c:1254
>  sock_ioctl+0x70b/0xd60 net/socket.c:1375
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl+0x239/0x400 fs/ioctl.c:583
>  __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:583
>  x64_sys_call+0x1cbc/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:=
17
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was created at:
>  slab_free_hook mm/slub.c:2440 [inline]
>  slab_free mm/slub.c:6566 [inline]
>  kmem_cache_free+0x2b0/0x1490 mm/slub.c:6676
>  skb_kfree_head net/core/skbuff.c:1046 [inline]
>  skb_free_head+0x13c/0x3a0 net/core/skbuff.c:1060
>  skb_release_data+0x9f7/0xac0 net/core/skbuff.c:1087
>  skb_release_all net/core/skbuff.c:1152 [inline]
>  __kfree_skb+0x6b/0x260 net/core/skbuff.c:1166
>  consume_skb+0x83/0x230 net/core/skbuff.c:1398
>  skb_free_datagram+0x1e/0x30 net/core/datagram.c:324
>  netlink_recvmsg+0xad1/0xfe0 net/netlink/af_netlink.c:1974
>  sock_recvmsg_nosec net/socket.c:1078 [inline]
>  sock_recvmsg+0x2dc/0x390 net/socket.c:1100
>  ____sys_recvmsg+0x193/0x610 net/socket.c:2850
>  ___sys_recvmsg+0x20b/0x850 net/socket.c:2892
>  __sys_recvmsg net/socket.c:2925 [inline]
>  __do_sys_recvmsg net/socket.c:2931 [inline]
>  __se_sys_recvmsg net/socket.c:2928 [inline]
>  __x64_sys_recvmsg+0x20e/0x3d0 net/socket.c:2928
>  x64_sys_call+0x35f0/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:=
48
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Bytes 0-17 of 18 are uninitialized
> Memory access of size 18 starts at ffff88811a0f1000
>
> CPU: 1 UID: 0 PID: 5441 Comm: dhcpcd Not tainted syzkaller #0 PREEMPT(non=
e)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/18/2025
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

--0000000000009ed7190640dd25dc
Content-Type: application/octet-stream; 
	name="0001-virtio-net-zero-unused-hash-fields.patch"
Content-Disposition: attachment; 
	filename="0001-virtio-net-zero-unused-hash-fields.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mglytnn90>
X-Attachment-Id: f_mglytnn90

RnJvbSA0M2RlOWYzYmIyMmJiZGYyMmE3ZjUwZWEwNmZlOTFmZWEwMzM3ODMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgpEYXRl
OiBTYXQsIDExIE9jdCAyMDI1IDE1OjM4OjEyICswODAwClN1YmplY3Q6IFtQQVRDSF0gdmlydGlv
LW5ldDogemVybyB1bnVzZWQgaGFzaCBmaWVsZHMKQ29udGVudC10eXBlOiB0ZXh0L3BsYWluCgpT
aWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgotLS0KIGluY2x1
ZGUvbGludXgvdmlydGlvX25ldC5oIHwgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW9fbmV0LmggYi9pbmNsdWRl
L2xpbnV4L3ZpcnRpb19uZXQuaAppbmRleCAyMGUwNTg0ZGIxZGQuLjRkMTc4MDg0OGQwZSAxMDA2
NDQKLS0tIGEvaW5jbHVkZS9saW51eC92aXJ0aW9fbmV0LmgKKysrIGIvaW5jbHVkZS9saW51eC92
aXJ0aW9fbmV0LmgKQEAgLTQwMSw2ICs0MDEsMTAgQEAgdmlydGlvX25ldF9oZHJfdG5sX2Zyb21f
c2tiKGNvbnN0IHN0cnVjdCBza19idWZmICpza2IsCiAJaWYgKCF0bmxfaGRyX25lZ290aWF0ZWQp
CiAJCXJldHVybiAtRUlOVkFMOwogCisgICAgICAgIHZoZHItPmhhc2hfaGRyLmhhc2hfdmFsdWUg
PSAwOworICAgICAgICB2aGRyLT5oYXNoX2hkci5oYXNoX3JlcG9ydCA9IDA7CisgICAgICAgIHZo
ZHItPmhhc2hfaGRyLnBhZGRpbmcgPSAwOworCiAJLyogTGV0IHRoZSBiYXNpYyBwYXJzaW5nIGRl
YWwgd2l0aCBwbGFpbiBHU08gZmVhdHVyZXMuICovCiAJc2tiX3NoaW5mbyhza2IpLT5nc29fdHlw
ZSAmPSB+dG5sX2dzb190eXBlOwogCXJldCA9IHZpcnRpb19uZXRfaGRyX2Zyb21fc2tiKHNrYiwg
aGRyLCB0cnVlLCBmYWxzZSwgdmxhbl9obGVuKTsKLS0gCjIuNDIuMAoK
--0000000000009ed7190640dd25dc--

