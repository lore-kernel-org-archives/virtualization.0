Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E7B36BCC2
	for <virtualization@lists.linux.dev>; Tue, 31 Mar 2026 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774968443; cv=none; b=NOdI/U0W617XS0voFnvJatcJ9qN5Lall3Ad/vgdrpXW3tj2Fm3GZQJjzWBlSUCu9RfP3WYGFOIjfzne+ALcTY87Q+Q7PxhEDWYA50jpNW6C5vmTBgtOe8wVjktPDXTM7dOhAU81fvYqtSWLMZ7D6hGJf4d0r8VTz76ads2YuiWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774968443; c=relaxed/simple;
	bh=rIc9ANVj800QQvZtwiOF0ffCyfD2f+eyh5uvdB9l+lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cs1uEEp66H1w7IsCr8IBGVcfpsGAtx3gpRfPONY724SRew3hjVY6dCGa111I+BWAjItV055e+I4TCvrcf/PiSFomZX1agUlpU9SuH64uQH2/xpIp21h39aiQBqIB3o9MZEhLC5cVHfdCcrSSa2uoGSMqxf37VvLgryG4FLHT4s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hPa7kgzl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPa7kgzl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774968440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EOYndnrcAsBIoMnnUdWSabYvKjlvmPfsxYrWUSFdDi0=;
	b=hPa7kgzl+Z5PF5aD8uuZcFwpxnSX05mO5bgsnNVsi28PUWJVxOgrZxXkBvKGS0cLZxCw0O
	FpBg22desny2gj/rqb8cukOW4Lg5MVS6Xd1H2hnJ4Cc3b0q3bR74qKud8WlfMz0HNris+3
	JzqC5lo1KC0nhkQ2vRfAtMkmNqKmtJ4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-ZTrq_W4tNzqdBCrH0rBURg-1; Tue, 31 Mar 2026 10:47:18 -0400
X-MC-Unique: ZTrq_W4tNzqdBCrH0rBURg-1
X-Mimecast-MFC-AGG-ID: ZTrq_W4tNzqdBCrH0rBURg_1774968438
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43cf906afb8so2572941f8f.3
        for <virtualization@lists.linux.dev>; Tue, 31 Mar 2026 07:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774968437; x=1775573237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOYndnrcAsBIoMnnUdWSabYvKjlvmPfsxYrWUSFdDi0=;
        b=gS6B2U4KNvX6PAVmM6SuQM7azd2wE/cxL1Z5LMVQq3a2b6wj7iSAzPe+XqaHYzLVAY
         fQX2XldoUU5kVivDacDZ/lLyjdtJiUKz/gpDCDFDAc83/dgNhXhU2KP83DNRSrWKQbfQ
         WxpvE6ZBUbenIYrrpNWv4h6MonGIgISv4Hcj4tl/VE+34ADFuAThbQ2g2kKAXAC6NoIE
         N2AQO+eZa12+HP+anrTIM1gGU0920hkpbDwKhCokSL0xiS1VzTAQTE3l5Xo+bTRWkWQj
         iW2If9hdFAFZ2REZ6S+U0JUdnkjVdv4fWA883F7vFLUtMyeokB/GYVirNxtfnRQ0IQGE
         8E6g==
X-Forwarded-Encrypted: i=1; AJvYcCXrjXzimT4dyu0hagXhqPOuXBeAIceVOHiqUaXXMtuynwerZ85cjwV0ldD0BnErHvN+jWwIu/8QM2bcAbeBiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcY+HQwE9YPvdKrz6BUuCDCs106zoYaNmzOy3WgsIrTAC1W1P8
	4uUXzUQANF1fRW3fw/BYWykkAzsrCuLP//fhOV47b8Reo2fyI4D9ZGJ3pewJhooD489+Xagkp2J
	9QgHO8ta4hqcueyPm3MEWJyl5f5xJZwgUGtcETVP+kwe4mCOisF17ZfixHthFMcBHT4H/
X-Gm-Gg: ATEYQzzEI9ksSucvbco0/HxKZf8cWUpUgCe2uS4ZGczlb6f1qglN7myFEo1z4KsuVFk
	SuwcuwIXxhgUcs+G3MyHpxxpr4Fgt77+1Gmzt9utd/A8by8r1QtXMXADkO8ZW7LyhopMoo6nsD2
	w7gx+HrK70s5xiA8F3dacNB1a4f6O4jZhq9LyXUxO88M0KMQxnEEODTV9E8+BVrRyTYm43GLxyO
	9IJbq2C6crgNI0U+tBNy9WMs6mgmNt0aIUwcQlN4JidGgluBRf+fvGN3bonYVN1PLzY01U2A10z
	1whmLqBXnNGNXfV8Ggw8RxF6+6jaPlsatGUCPqnEmSCWSH0K0PYr1Fx33CGBUEy8en97Xrg8b2R
	FDFjd0LZ2H/O4doyO
X-Received: by 2002:a05:600c:3112:b0:485:3b34:2f62 with SMTP id 5b1f17b1804b1-48727ea2803mr314230095e9.14.1774968437315;
        Tue, 31 Mar 2026 07:47:17 -0700 (PDT)
X-Received: by 2002:a05:600c:3112:b0:485:3b34:2f62 with SMTP id 5b1f17b1804b1-48727ea2803mr314229485e9.14.1774968436685;
        Tue, 31 Mar 2026 07:47:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e832585sm87851145e9.6.2026.03.31.07.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:47:15 -0700 (PDT)
Date: Tue, 31 Mar 2026 10:47:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: syzbot <syzbot+574895e85c21fa090ff6@syzkaller.appspotmail.com>
Cc: eperezma@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com,
	Venkatesh Srinivas <venkateshs@google.com>,
	Albert Huang <huangjie.albert@bytedance.com>
Subject: Re: [syzbot] [virt?] KCSAN: data-race in virtqueue_disable_cb /
 virtqueue_enable_cb_delayed (11)
Message-ID: <20260331101829-mutt-send-email-mst@kernel.org>
References: <69cbbb90.050a0220.183828.002b.GAE@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <69cbbb90.050a0220.183828.002b.GAE@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zvbvvpZ8O-23P3X1JUukZtWRI7qK141RrIfOjdVK7R4_1774968438
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 31, 2026 at 05:18:24AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    46b513250491 Merge tag 'v7.0-rc5-smb3-client-fix' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1226df72580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3a78dd265deac3a9
> dashboard link: https://syzkaller.appspot.com/bug?extid=574895e85c21fa090ff6
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/8f19c67785a8/disk-46b51325.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/11dbb9704e20/vmlinux-46b51325.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/190d9812e855/bzImage-46b51325.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+574895e85c21fa090ff6@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in virtqueue_disable_cb / virtqueue_enable_cb_delayed
> 
> write to 0xffff8881027a9588 of 2 bytes by interrupt on cpu 1:
>  virtqueue_enable_cb_delayed_split drivers/virtio/virtio_ring.c:1102 [inline]
>  virtqueue_enable_cb_delayed+0x20f/0x660 drivers/virtio/virtio_ring.c:3196
>  start_xmit+0x15ef/0x1ab0 drivers/net/virtio_net.c:3377
>  __netdev_start_xmit include/linux/netdevice.h:5325 [inline]
>  netdev_start_xmit include/linux/netdevice.h:5334 [inline]
>  xmit_one net/core/dev.c:3883 [inline]
>  dev_hard_start_xmit+0x136/0x3f0 net/core/dev.c:3899
>  sch_direct_xmit+0x192/0x550 net/sched/sch_generic.c:347
>  __dev_xmit_skb net/core/dev.c:4198 [inline]
>  __dev_queue_xmit+0xca9/0x1f20 net/core/dev.c:4814
>  dev_queue_xmit include/linux/netdevice.h:3385 [inline]
>  neigh_hh_output include/net/neighbour.h:540 [inline]
>  neigh_output include/net/neighbour.h:554 [inline]
>  ip_finish_output2+0x705/0x8c0 net/ipv4/ip_output.c:237
>  __ip_finish_output net/ipv4/ip_output.c:-1 [inline]
>  ip_finish_output+0x112/0x290 net/ipv4/ip_output.c:325
>  NF_HOOK_COND include/linux/netfilter.h:307 [inline]
>  ip_output+0xbd/0x1c0 net/ipv4/ip_output.c:438
>  dst_output include/net/dst.h:470 [inline]
>  ip_local_out net/ipv4/ip_output.c:131 [inline]
>  __ip_queue_xmit+0xb68/0xba0 net/ipv4/ip_output.c:534
>  ip_queue_xmit+0x39/0x50 net/ipv4/ip_output.c:548
>  __tcp_transmit_skb+0x1af2/0x1f10 net/ipv4/tcp_output.c:1693
>  tcp_transmit_skb net/ipv4/tcp_output.c:1711 [inline]
>  tcp_write_xmit+0x1597/0x3640 net/ipv4/tcp_output.c:3064
>  __tcp_push_pending_frames+0x6d/0x1b0 net/ipv4/tcp_output.c:3247
>  tcp_push_pending_frames include/net/tcp.h:2285 [inline]
>  tcp_data_snd_check net/ipv4/tcp_input.c:6127 [inline]
>  tcp_rcv_established+0xda2/0x12f0 net/ipv4/tcp_input.c:6610
>  tcp_v4_do_rcv+0x91d/0xa30 net/ipv4/tcp_ipv4.c:1884
>  tcp_v4_rcv+0x19f8/0x1db0 net/ipv4/tcp_ipv4.c:2319
>  ip_protocol_deliver_rcu+0x395/0x790 net/ipv4/ip_input.c:207
>  ip_local_deliver_finish+0x1fc/0x2f0 net/ipv4/ip_input.c:241
>  NF_HOOK include/linux/netfilter.h:318 [inline]
>  ip_local_deliver+0xe8/0x1e0 net/ipv4/ip_input.c:262
>  dst_input include/net/dst.h:480 [inline]
>  ip_sublist_rcv_finish net/ipv4/ip_input.c:584 [inline]
>  ip_list_rcv_finish net/ipv4/ip_input.c:636 [inline]
>  ip_sublist_rcv+0x5a4/0x6a0 net/ipv4/ip_input.c:644
>  ip_list_rcv+0x261/0x290 net/ipv4/ip_input.c:678
>  __netif_receive_skb_list_ptype net/core/dev.c:6219 [inline]
>  __netif_receive_skb_list_core+0x4dc/0x500 net/core/dev.c:6266
>  __netif_receive_skb_list net/core/dev.c:6318 [inline]
>  netif_receive_skb_list_internal+0x47d/0x5f0 net/core/dev.c:6409
>  gro_normal_list include/net/gro.h:523 [inline]
>  gro_flush_normal include/net/gro.h:531 [inline]
>  napi_complete_done+0x19c/0x3f0 net/core/dev.c:6777
>  virtqueue_napi_complete drivers/net/virtio_net.c:749 [inline]
>  virtnet_poll+0x1bb1/0x2040 drivers/net/virtio_net.c:3091
>  __napi_poll+0x61/0x330 net/core/dev.c:7704
>  napi_poll net/core/dev.c:7767 [inline]
>  net_rx_action+0x452/0x930 net/core/dev.c:7924
>  handle_softirqs+0xb9/0x2a0 kernel/softirq.c:622
>  __do_softirq kernel/softirq.c:656 [inline]
>  invoke_softirq kernel/softirq.c:496 [inline]
>  __irq_exit_rcu+0x39/0xc0 kernel/softirq.c:723
>  common_interrupt+0x83/0x90 arch/x86/kernel/irq.c:326
>  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:688
>  finish_task_switch+0x86/0x280 kernel/sched/core.c:5155
>  context_switch kernel/sched/core.c:5301 [inline]
>  __schedule+0x93c/0xd40 kernel/sched/core.c:6911
>  __schedule_loop kernel/sched/core.c:6993 [inline]
>  schedule+0x5e/0xd0 kernel/sched/core.c:7008
>  schedule_timeout+0xca/0x180 kernel/time/sleep_timeout.c:99
>  io_wq_worker+0x3a0/0x970 io_uring/io-wq.c:728
>  ret_from_fork+0x150/0x360 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> read to 0xffff8881027a9588 of 2 bytes by interrupt on cpu 0:
>  virtqueue_disable_cb_split drivers/virtio/virtio_ring.c:1046 [inline]
>  virtqueue_disable_cb+0x4c/0x2c0 drivers/virtio/virtio_ring.c:3108
>  virtqueue_napi_schedule drivers/net/virtio_net.c:738 [inline]
>  skb_xmit_done+0xb0/0x1a0 drivers/net/virtio_net.c:786
>  vring_interrupt+0x2d7/0x310 drivers/virtio/virtio_ring.c:3254
>  __handle_irq_event_percpu+0x9c/0x4d0 kernel/irq/handle.c:209
>  handle_irq_event_percpu kernel/irq/handle.c:246 [inline]
>  handle_irq_event+0x64/0xf0 kernel/irq/handle.c:263
>  handle_edge_irq+0x154/0x470 kernel/irq/chip.c:855
>  generic_handle_irq_desc include/linux/irqdesc.h:186 [inline]
>  handle_irq arch/x86/kernel/irq.c:262 [inline]
>  call_irq_handler arch/x86/kernel/irq.c:-1 [inline]
>  __common_interrupt+0x60/0xb0 arch/x86/kernel/irq.c:333
>  common_interrupt+0x7e/0x90 arch/x86/kernel/irq.c:326
>  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:688
>  decode_watchpoint kernel/kcsan/encoding.h:74 [inline]
>  find_watchpoint kernel/kcsan/core.c:132 [inline]
>  check_access kernel/kcsan/core.c:737 [inline]
>  __tsan_read8+0x31/0x190 kernel/kcsan/core.c:1025
>  _find_next_bit+0x29/0x90 lib/find_bit.c:157
>  find_next_bit include/linux/find.h:73 [inline]
>  ebitmap_next_positive security/selinux/ss/ebitmap.h:72 [inline]
>  context_struct_compute_av+0x496/0xaf0 security/selinux/ss/services.c:661
>  security_compute_av+0x34f/0xa20 security/selinux/ss/services.c:1177
>  avc_compute_av+0x5d/0x430 security/selinux/avc.c:992
>  avc_perm_nonode+0x5e/0xe0 security/selinux/avc.c:1117
>  avc_has_perm_noaudit+0xf2/0x130 security/selinux/avc.c:1160
>  avc_has_perm+0x60/0x190 security/selinux/avc.c:1195
>  inode_has_perm security/selinux/hooks.c:1691 [inline]
>  file_has_perm security/selinux/hooks.c:1787 [inline]
>  selinux_revalidate_file_permission security/selinux/hooks.c:3793 [inline]
>  selinux_file_permission+0x633/0x690 security/selinux/hooks.c:3814
>  security_file_permission+0x3a/0x70 security/security.c:2367
>  rw_verify_area fs/read_write.c:475 [inline]
>  vfs_write+0x135/0x9f0 fs/read_write.c:679
>  ksys_write+0xdc/0x1a0 fs/read_write.c:740
>  __do_sys_write fs/read_write.c:751 [inline]
>  __se_sys_write fs/read_write.c:748 [inline]
>  __x64_sys_write+0x40/0x50 fs/read_write.c:748
>  x64_sys_call+0x27e1/0x3020 arch/x86/include/generated/asm/syscalls_64.h:2
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> value changed: 0x0001 -> 0x0000
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 3302 Comm: syz-executor Tainted: G        W           syzkaller #0 PREEMPT(full) 
> Tainted: [W]=WARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
> ==================================================================
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


The issue seems to be that disable_cb writes flags and flags shadow,
without locks.

so if it sets VRING_AVAIL_F_NO_INTERRUPT in both, it's possible
that we have a race:

CPU1 is in start_xmit() on sq->vq.
It has already done the entry-side virtqueue_disable_cb().
Before it reaches the tail-side virtqueue_enable_cb_delayed(), the device completes something and raises an IRQ on CPU0.
vring_interrupt() calls skb_xmit_done() on the same sq->vq.
That IRQ path calls virtqueue_disable_cb(vq) concurrently with CPU1's virtqueue_enable_cb_delayed(sq->vq).

Now:


disable cb:
	set VRING_AVAIL_F_NO_INTERRUPT in shadow


	enable_cb:
		clear VRING_AVAIL_F_NO_INTERRUPT in shadow
		clear VRING_AVAIL_F_NO_INTERRUPT in flags


	set VRING_AVAIL_F_NO_INTERRUPT in shadow


and now they are out of sync: cleared in shadow (so next enable
will be a nop) and set in flags (so we do not get another interrupt).


I frankly think the only fix is to drop the flags shadow.

Venkatesh, do you know how much perf gain did we get from
not poking at flags directly?


-- 
MST

