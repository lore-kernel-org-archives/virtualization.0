Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EC33909A8
	for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776107301; cv=pass; b=MgxTYr4zOPIjti/DXNN+BtstoKdApatmuw+SQCmPC7Xv46IhC546m65jH6i1lrDww9GMWB5H8b2IiL9giHCOmqIUpniO1qg56XwrteGAycQ3HNNROJW/yKKzVwwd4wbFVD3ZliGkZLqQSdyga2reHzF8RxjRsme3Pw3N3rsplNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776107301; c=relaxed/simple;
	bh=SHZa33Lb+ZJZiy4C63d50OOc6efk6Mz27FdQIp0P5ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jyqm+npXQ1u2SMqhXVSi3FIhjIEaj69QElagL60ND/GOscegsCS1vv6PHQ2gWI/c0Ebw4Nr8XajHGak24BrEfdXfTgJip2Jfn3HzLwO0HW5lcdDe9izty/n9k16irc9RIanhtGrlkVhbOrXjEV7oGg5QJopPCmJ8M8V5e4Jx+rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IMBPTkNU; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IMBPTkNU"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82748257f5fso2685754b3a.1
        for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 12:08:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776107299; cv=none;
        d=google.com; s=arc-20240605;
        b=YuPumU9TRBoUV1VkmLB5O9zPmyRRQcdtnWEqf1XA66VVt3RHO90sBfBPEjKM/BYEDD
         U7NQfA75U+3INQjee5NgjoBcRbN7x7S3yaP37wW1LjD8YIWQE1BGYyZwzcdsnrEetI6c
         uhQvKiy8c3NkoxTnVq9jRLgYWBO1yvSFPOobWKhjCx6aeixYbgMQuuDL5Ot8xP2twpDS
         Ou11TF6e9LSlMk3nPbwSvyTca9VqWPfj3mkw8Ob8TAV2Va+BkBJ9HX7BzXmdFiX83xdR
         V03XVwr27WBATHu67t7k7ZyS82OOJxU2lT0bhh+wMwgUluB7ekrPl45qUdxpjL/Zn1lh
         qb8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qk37SInzaS8bHWBRBhqV2TXgDbof15448eQ6BjI7Ba4=;
        fh=AZBkuTwGYeVUuwmaExs8yQH1GiQN+h5DSb6CKm25Y8E=;
        b=AgDUq7ZbgHOFBtLSDRcs6YdhTL+tXRO17ufx5LZLcm+nE67yEzvODtBLQnWXNPIMZo
         U9LfNt7Nt4RkniDMTzxeYzauSJSMnvrTdUMQqVeG3sOzd3TJBLWQjCYW0fFj1QOGrtkE
         ad4nRO4x1ABSk4uRZsipFq57fAskZOa7OyCX6bPCSBk7eR7NrIfq8uDEajQYjnEtBghP
         gBdag2FCZ0icP6lfnyJtJ10YNYphMMndVfXvFVFU7RwLlXvtASyRQM9mL8l6NnY8QjmF
         mlRSeq4lF03SLajqohMF2nnnGZZSYyzHw/9ps9StBaPReia4XuDZ5bR28oJX4Qiu7AFu
         /DTA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776107299; x=1776712099; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qk37SInzaS8bHWBRBhqV2TXgDbof15448eQ6BjI7Ba4=;
        b=IMBPTkNUNZv1bUPzWA4lq5i8SY6dx72zsGvSv/gyleXOfly6whkMsjkucQqrMC4NeI
         N6tkzbjXwHPetBxgihdKqk7UHVcEkCx82hL5dXHJVjXqiBny3bgkOorYu1fjcB5WPwXg
         hZZmEh2/s69jUDIqRIUgcpP+LxRGInyo1n2fA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776107299; x=1776712099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qk37SInzaS8bHWBRBhqV2TXgDbof15448eQ6BjI7Ba4=;
        b=hAmP3FJqTEOunJWbWOmgtZODwccjZ7/ScRHgVZKxQhZY5XGeV3+lWp5iU3fmDI+twQ
         i4V+hxtbAudgiqYwpwwJDZFBY+owH7waSAc1SMgZk6EFypfX16v4niY9xBNdogFIWDj2
         RonXIgPTuJTRSjgVhA1rP33T1k08KwQkCs1I4m1uDQ9qd0cp/2zawT9staov2Paw8mBT
         ZjNF2Utr4fW6BNq8FvXS3SdJFD7zdfxTiQdPyfxo0FRnxTbiYN15t/T9uuN90gqj9xBM
         1VP7Hj0rk6II+cIwbpLOW+3a6ZJqsslqR/elCfVSjsv9/KNfZ5xSSqxMpJZbVxrh/kl/
         87lg==
X-Forwarded-Encrypted: i=1; AFNElJ96JbYIZ0Ed1dKJZa+73nXcuAhQvH9MxitbE+P04oz6AKEx2k0wfyAAWqUnqNr7qAdIvfUvRp7mh7E3jfotNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwK8nZFyW6nBCtib0uhX0fjXi7fteRImfk+NjPvIHam6EkpSK0K
	fOAQnJedQDSeadKx7eHOVANbuPWaTrH2FNFT+I05HQQGUovM+WTdDnBfdxN2bCbfX2fzxGLFcdV
	1oJFAyY7vVZ+gL3W4sHDxNg3Kr1CQLCR/2S6l+f0i
X-Gm-Gg: AeBDieuOR6drdJ3hTuyNC72q5IpkSa//DMZysCqZ0JqyWrakKhmbf05Sux4Qqhn+cgI
	O76wRUCEGKnt87JYTL2GkZ1bv7phLMRNsKoIvu9U+ypqACOb29XGkUg1nzzmVp7h12CsuvOdh53
	pRJcYHLRobzkS1MnmmKZp1G98LboyLEjgx5uXIBK+Mm9hJLtVMojS5NwCb5erwr2aZzDJyW3WsS
	UljIm02wPeIUnFv7udPSkvNR1ilurPe/f1q5K00r9JmAiXgCwWA9w6vBwgbRT6WRGodsx6D1rM4
	m5ij8mKy7A==
X-Received: by 2002:a05:6a00:3498:b0:81f:544b:3998 with SMTP id
 d2e1a72fcca58-82f0d37a0c3mr11325137b3a.26.1776107299363; Mon, 13 Apr 2026
 12:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <69cbbb90.050a0220.183828.002b.GAE@google.com> <20260331101829-mutt-send-email-mst@kernel.org>
 <CAA0tLEpJhOPnW8JzJjcvZ3toAh=ab=EG+f4TGWvcOwxXD3WsTQ@mail.gmail.com> <20260406154926-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260406154926-mutt-send-email-mst@kernel.org>
From: Venkatesh Srinivas <venkateshs@chromium.org>
Date: Mon, 13 Apr 2026 13:08:06 -0600
X-Gm-Features: AQROBzBLSufCOAMuFC9GJtrwQkrgxH9NAu17rjLjmR1n5fFf5Lcq2nhdq52FzkQ
Message-ID: <CAA0tLErPP4ajyeVc2QroPemmCkkCVrMnBDhnpSbRx0hVgs15vA@mail.gmail.com>
Subject: Re: [syzbot] [virt?] KCSAN: data-race in virtqueue_disable_cb /
 virtqueue_enable_cb_delayed (11)
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: syzbot <syzbot+574895e85c21fa090ff6@syzkaller.appspotmail.com>, 
	eperezma@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, Venkatesh Srinivas <venkateshs@google.com>, 
	Albert Huang <huangjie.albert@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 1:50=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Apr 06, 2026 at 11:03:26AM -0600, Venkatesh Srinivas wrote:
> > On Tue, Mar 31, 2026 at 8:51=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Tue, Mar 31, 2026 at 05:18:24AM -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    46b513250491 Merge tag 'v7.0-rc5-smb3-client-fix' o=
f git:/..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1226df7=
2580000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D3a78dd2=
65deac3a9
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D574895e85=
c21fa090ff6
> > > > compiler:       Debian clang version 21.1.8 (++20251221033036+2078d=
a43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/8f19c67785=
a8/disk-46b51325.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/11dbb9704e20/=
vmlinux-46b51325.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/190d9812=
e855/bzImage-46b51325.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+574895e85c21fa090ff6@syzkaller.appspotmail.com
> > > >
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > BUG: KCSAN: data-race in virtqueue_disable_cb / virtqueue_enable_cb=
_delayed
> > > >
> > > > write to 0xffff8881027a9588 of 2 bytes by interrupt on cpu 1:
> > > >  virtqueue_enable_cb_delayed_split drivers/virtio/virtio_ring.c:110=
2 [inline]
> > > >  virtqueue_enable_cb_delayed+0x20f/0x660 drivers/virtio/virtio_ring=
.c:3196
> > > >  start_xmit+0x15ef/0x1ab0 drivers/net/virtio_net.c:3377
> > > >  __netdev_start_xmit include/linux/netdevice.h:5325 [inline]
> > > >  netdev_start_xmit include/linux/netdevice.h:5334 [inline]
> > > >  xmit_one net/core/dev.c:3883 [inline]
> > > >  dev_hard_start_xmit+0x136/0x3f0 net/core/dev.c:3899
> > > >  sch_direct_xmit+0x192/0x550 net/sched/sch_generic.c:347
> > > >  __dev_xmit_skb net/core/dev.c:4198 [inline]
> > > >  __dev_queue_xmit+0xca9/0x1f20 net/core/dev.c:4814
> > > >  dev_queue_xmit include/linux/netdevice.h:3385 [inline]
> > > >  neigh_hh_output include/net/neighbour.h:540 [inline]
> > > >  neigh_output include/net/neighbour.h:554 [inline]
> > > >  ip_finish_output2+0x705/0x8c0 net/ipv4/ip_output.c:237
> > > >  __ip_finish_output net/ipv4/ip_output.c:-1 [inline]
> > > >  ip_finish_output+0x112/0x290 net/ipv4/ip_output.c:325
> > > >  NF_HOOK_COND include/linux/netfilter.h:307 [inline]
> > > >  ip_output+0xbd/0x1c0 net/ipv4/ip_output.c:438
> > > >  dst_output include/net/dst.h:470 [inline]
> > > >  ip_local_out net/ipv4/ip_output.c:131 [inline]
> > > >  __ip_queue_xmit+0xb68/0xba0 net/ipv4/ip_output.c:534
> > > >  ip_queue_xmit+0x39/0x50 net/ipv4/ip_output.c:548
> > > >  __tcp_transmit_skb+0x1af2/0x1f10 net/ipv4/tcp_output.c:1693
> > > >  tcp_transmit_skb net/ipv4/tcp_output.c:1711 [inline]
> > > >  tcp_write_xmit+0x1597/0x3640 net/ipv4/tcp_output.c:3064
> > > >  __tcp_push_pending_frames+0x6d/0x1b0 net/ipv4/tcp_output.c:3247
> > > >  tcp_push_pending_frames include/net/tcp.h:2285 [inline]
> > > >  tcp_data_snd_check net/ipv4/tcp_input.c:6127 [inline]
> > > >  tcp_rcv_established+0xda2/0x12f0 net/ipv4/tcp_input.c:6610
> > > >  tcp_v4_do_rcv+0x91d/0xa30 net/ipv4/tcp_ipv4.c:1884
> > > >  tcp_v4_rcv+0x19f8/0x1db0 net/ipv4/tcp_ipv4.c:2319
> > > >  ip_protocol_deliver_rcu+0x395/0x790 net/ipv4/ip_input.c:207
> > > >  ip_local_deliver_finish+0x1fc/0x2f0 net/ipv4/ip_input.c:241
> > > >  NF_HOOK include/linux/netfilter.h:318 [inline]
> > > >  ip_local_deliver+0xe8/0x1e0 net/ipv4/ip_input.c:262
> > > >  dst_input include/net/dst.h:480 [inline]
> > > >  ip_sublist_rcv_finish net/ipv4/ip_input.c:584 [inline]
> > > >  ip_list_rcv_finish net/ipv4/ip_input.c:636 [inline]
> > > >  ip_sublist_rcv+0x5a4/0x6a0 net/ipv4/ip_input.c:644
> > > >  ip_list_rcv+0x261/0x290 net/ipv4/ip_input.c:678
> > > >  __netif_receive_skb_list_ptype net/core/dev.c:6219 [inline]
> > > >  __netif_receive_skb_list_core+0x4dc/0x500 net/core/dev.c:6266
> > > >  __netif_receive_skb_list net/core/dev.c:6318 [inline]
> > > >  netif_receive_skb_list_internal+0x47d/0x5f0 net/core/dev.c:6409
> > > >  gro_normal_list include/net/gro.h:523 [inline]
> > > >  gro_flush_normal include/net/gro.h:531 [inline]
> > > >  napi_complete_done+0x19c/0x3f0 net/core/dev.c:6777
> > > >  virtqueue_napi_complete drivers/net/virtio_net.c:749 [inline]
> > > >  virtnet_poll+0x1bb1/0x2040 drivers/net/virtio_net.c:3091
> > > >  __napi_poll+0x61/0x330 net/core/dev.c:7704
> > > >  napi_poll net/core/dev.c:7767 [inline]
> > > >  net_rx_action+0x452/0x930 net/core/dev.c:7924
> > > >  handle_softirqs+0xb9/0x2a0 kernel/softirq.c:622
> > > >  __do_softirq kernel/softirq.c:656 [inline]
> > > >  invoke_softirq kernel/softirq.c:496 [inline]
> > > >  __irq_exit_rcu+0x39/0xc0 kernel/softirq.c:723
> > > >  common_interrupt+0x83/0x90 arch/x86/kernel/irq.c:326
> > > >  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:688
> > > >  finish_task_switch+0x86/0x280 kernel/sched/core.c:5155
> > > >  context_switch kernel/sched/core.c:5301 [inline]
> > > >  __schedule+0x93c/0xd40 kernel/sched/core.c:6911
> > > >  __schedule_loop kernel/sched/core.c:6993 [inline]
> > > >  schedule+0x5e/0xd0 kernel/sched/core.c:7008
> > > >  schedule_timeout+0xca/0x180 kernel/time/sleep_timeout.c:99
> > > >  io_wq_worker+0x3a0/0x970 io_uring/io-wq.c:728
> > > >  ret_from_fork+0x150/0x360 arch/x86/kernel/process.c:158
> > > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > > >
> > > > read to 0xffff8881027a9588 of 2 bytes by interrupt on cpu 0:
> > > >  virtqueue_disable_cb_split drivers/virtio/virtio_ring.c:1046 [inli=
ne]
> > > >  virtqueue_disable_cb+0x4c/0x2c0 drivers/virtio/virtio_ring.c:3108
> > > >  virtqueue_napi_schedule drivers/net/virtio_net.c:738 [inline]
> > > >  skb_xmit_done+0xb0/0x1a0 drivers/net/virtio_net.c:786
> > > >  vring_interrupt+0x2d7/0x310 drivers/virtio/virtio_ring.c:3254
> > > >  __handle_irq_event_percpu+0x9c/0x4d0 kernel/irq/handle.c:209
> > > >  handle_irq_event_percpu kernel/irq/handle.c:246 [inline]
> > > >  handle_irq_event+0x64/0xf0 kernel/irq/handle.c:263
> > > >  handle_edge_irq+0x154/0x470 kernel/irq/chip.c:855
> > > >  generic_handle_irq_desc include/linux/irqdesc.h:186 [inline]
> > > >  handle_irq arch/x86/kernel/irq.c:262 [inline]
> > > >  call_irq_handler arch/x86/kernel/irq.c:-1 [inline]
> > > >  __common_interrupt+0x60/0xb0 arch/x86/kernel/irq.c:333
> > > >  common_interrupt+0x7e/0x90 arch/x86/kernel/irq.c:326
> > > >  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:688
> > > >  decode_watchpoint kernel/kcsan/encoding.h:74 [inline]
> > > >  find_watchpoint kernel/kcsan/core.c:132 [inline]
> > > >  check_access kernel/kcsan/core.c:737 [inline]
> > > >  __tsan_read8+0x31/0x190 kernel/kcsan/core.c:1025
> > > >  _find_next_bit+0x29/0x90 lib/find_bit.c:157
> > > >  find_next_bit include/linux/find.h:73 [inline]
> > > >  ebitmap_next_positive security/selinux/ss/ebitmap.h:72 [inline]
> > > >  context_struct_compute_av+0x496/0xaf0 security/selinux/ss/services=
.c:661
> > > >  security_compute_av+0x34f/0xa20 security/selinux/ss/services.c:117=
7
> > > >  avc_compute_av+0x5d/0x430 security/selinux/avc.c:992
> > > >  avc_perm_nonode+0x5e/0xe0 security/selinux/avc.c:1117
> > > >  avc_has_perm_noaudit+0xf2/0x130 security/selinux/avc.c:1160
> > > >  avc_has_perm+0x60/0x190 security/selinux/avc.c:1195
> > > >  inode_has_perm security/selinux/hooks.c:1691 [inline]
> > > >  file_has_perm security/selinux/hooks.c:1787 [inline]
> > > >  selinux_revalidate_file_permission security/selinux/hooks.c:3793 [=
inline]
> > > >  selinux_file_permission+0x633/0x690 security/selinux/hooks.c:3814
> > > >  security_file_permission+0x3a/0x70 security/security.c:2367
> > > >  rw_verify_area fs/read_write.c:475 [inline]
> > > >  vfs_write+0x135/0x9f0 fs/read_write.c:679
> > > >  ksys_write+0xdc/0x1a0 fs/read_write.c:740
> > > >  __do_sys_write fs/read_write.c:751 [inline]
> > > >  __se_sys_write fs/read_write.c:748 [inline]
> > > >  __x64_sys_write+0x40/0x50 fs/read_write.c:748
> > > >  x64_sys_call+0x27e1/0x3020 arch/x86/include/generated/asm/syscalls=
_64.h:2
> > > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > > >  do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
> > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > >
> > > > value changed: 0x0001 -> 0x0000
> > > >
> > > > Reported by Kernel Concurrency Sanitizer on:
> > > > CPU: 0 UID: 0 PID: 3302 Comm: syz-executor Tainted: G        W     =
      syzkaller #0 PREEMPT(full)
> > > > Tainted: [W]=3DWARN
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 02/12/2026
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > >
> > > > ---
> > > > This report is generated by a bot. It may contain errors.
> > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > >
> > > > syzbot will keep track of this issue. See:
> > > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > >
> > > > If the report is already addressed, let syzbot know by replying wit=
h:
> > > > #syz fix: exact-commit-title
> > > >
> > > > If you want to overwrite report's subsystems, reply with:
> > > > #syz set subsystems: new-subsystem
> > > > (See the list of subsystem names on the web dashboard)
> > > >
> > > > If the report is a duplicate of another one, reply with:
> > > > #syz dup: exact-subject-of-another-report
> > > >
> > > > If you want to undo deduplication, reply with:
> > > > #syz undup
> > >
> > >
> > > The issue seems to be that disable_cb writes flags and flags shadow,
> > > without locks.
> > >
> > > so if it sets VRING_AVAIL_F_NO_INTERRUPT in both, it's possible
> > > that we have a race:
> > >
> > > CPU1 is in start_xmit() on sq->vq.
> > > It has already done the entry-side virtqueue_disable_cb().
> > > Before it reaches the tail-side virtqueue_enable_cb_delayed(), the de=
vice completes something and raises an IRQ on CPU0.
> > > vring_interrupt() calls skb_xmit_done() on the same sq->vq.
> > > That IRQ path calls virtqueue_disable_cb(vq) concurrently with CPU1's=
 virtqueue_enable_cb_delayed(sq->vq).
> > >
> > > Now:
> > >
> > >
> > > disable cb:
> > >         set VRING_AVAIL_F_NO_INTERRUPT in shadow
> > >
> > >
> > >         enable_cb:
> > >                 clear VRING_AVAIL_F_NO_INTERRUPT in shadow
> > >                 clear VRING_AVAIL_F_NO_INTERRUPT in flags
> > >
> > >
> > >         set VRING_AVAIL_F_NO_INTERRUPT in shadow
> > >
> > >
> > > and now they are out of sync: cleared in shadow (so next enable
> > > will be a nop) and set in flags (so we do not get another interrupt).
> > >
> > >
> > > I frankly think the only fix is to drop the flags shadow.
> >
> > I'm working on a kcsan-safe fix right now.
> >
> > > Venkatesh, do you know how much perf gain did we get from
> > > not poking at flags directly?
> >
> > On the obsolete h/w described in the original commit,
> > 2 - 3% on a microbenchmark. Newer hardware not
> > widely available at the time (Skylake-SP) saw similar
> > wins. Can revive the microbenchmark and get new
> > data.
> >
> > The real motivation was alluded to in the commit -- if
> > you implement a physical (PCIe) virtio device and put
> > the vring in device memory, writes are reasonably
> > fast (buffered, posted), but reads were very heavyweight.
> > Shadowing the flags field removed this read and made
> > the performance of that teneble.
> >
> >
> > -- vs;
>
>
> So to be specific, unconditionally writing into
> the ring field would be ok?

Yes, unconditionally writing would be fine!


-- vs;
