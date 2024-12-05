Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767C91DAC88
	for <virtualization@lists.linux.dev>; Thu,  5 Dec 2024 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395313; cv=none; b=XNf653DZ70a/Exew70l5FM1dLrrAsUK4u52gTPkqFZPl559kEmFdNO34z5icLIQeybaZqT+VWe7/sAxuzC9kAgVULg4Xfd+MoaJfegbr/zvyD9zS1cyZ1NxX4BQoCoSEZOt2ZSNUDZelt6i+Oa6WfCsv+YeA6985kwGAxkg5xw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395313; c=relaxed/simple;
	bh=cXARSPhsnyjYJ9FOE9GYKj1fnkgO9hcDyG/Dm5/mYbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZBY+6WWZW0aeE1YNWHfAAq+FtfvvYLpXHC/UhPSoHUTrYKGh+nzxV7lqWv9Xn43ALz71tvmv4EPzrk2xbsjUUfykc2M7MUIOcJ2YA8h7wufhOOMyTXtuzKYcAvAJ17jXM3kVOK48m1W3dlyhFjZa3Vv/oZONFMQ8aQCmDIyJ93U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BNshgVuF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNshgVuF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733395310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7p73LHjrqjBpK0dMpMgAy+lYmo0uHU88LvaJ9IE33+0=;
	b=BNshgVuFVUGmfAWID+8P05c8Mbf14aSTxkvQlB5puesb05UIHNpduE5dAOgFKkKBCqvGFy
	JbJf3c3Jvmcm41nG7bDaAnpObzgW3sCgyAk3flfjXcWEQn4KNq9fxzAzHrPWcGhR29nwxs
	7K02xkjcQp768OOFTngUH5HdkJYCswM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-BgReepGPMLSIDwNc94kHyg-1; Thu, 05 Dec 2024 05:41:47 -0500
X-MC-Unique: BgReepGPMLSIDwNc94kHyg-1
X-Mimecast-MFC-AGG-ID: BgReepGPMLSIDwNc94kHyg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385e9c698e7so478301f8f.0
        for <virtualization@lists.linux.dev>; Thu, 05 Dec 2024 02:41:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395306; x=1734000106;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FW+Wg7pQ3qsEcbqboe84VPuYnkq5MUKmVJHnWAGTL9I=;
        b=d2i8lVAincWsBXjnCXToVgJhwFJeWOU9LJKehTqAGkyGxpq7Vba9IZ0Ltt3QRyejzM
         6tuwb0fcQfugiSXbJzuJd4MLd4Wcd5sncd1lCov2244G9YDsFp6ZuE4K+xwx45IWAvWU
         2BZZX3pAbfGNUxO7GNGewWJF+476fzt7eh5bdKE2OLGDskF0fewS6B43z6BAT7bd56pY
         7SwZCIs/qFZWoQ8jatqp7L7DsKpnTMcYjc320uEnls5BXXtA7gYdT6jFy0j5fw/xTy0Z
         CdRGEWUM3+LynqNw49fvd9iXRPNMwP2zaLNx3Xao3KAs5kGaU4pof7C4EISkZj5XtUNl
         Wuxg==
X-Gm-Message-State: AOJu0Yz/kuVQqw60P5QN1tn+P9mQBF79r3HZgHJfGIFJIReKKqwVUdtW
	yHJ6LK5hUT2EhhYlKRZMtJoX/kkjcpzUlsDm6oFdXIoBssO92EXvlxrCzvnv3KB7Kzsh281CRa4
	CFqU5dM5uU33UGOx05muO0+KOb3b2F3ngzej3LVCxb6XgZWlghtezR7+nJTPjvOFE
X-Gm-Gg: ASbGnctnxFRK2/gFLRAH59wyUmJTsBwl27ZqZzE6W/PmB/hoy22958lFejwqRiB3l3Y
	n6Wrqoxj+WOKqGiQvoCAPahr68MQI7VpzFfDbUtUUKgj/WG7fipF+pYKvR1SeTwvFW5xMFZD37I
	3JnFpuA/pQwW18knsIlsz15adt4eKTXtIHtUIVce2alVxv0d6Jn5ZGIUEPSyoxlFCysfzTwLcI1
	Z/YDz78BVVxQWboeUZ4DW8EQagBSlkfDWb4RqM=
X-Received: by 2002:a5d:5f4b:0:b0:385:e879:45cf with SMTP id ffacd0b85a97d-3861bb4c763mr2295332f8f.1.1733395306002;
        Thu, 05 Dec 2024 02:41:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGL2yo4llIHnvMvig5JL3mvdVA/OxJnDLLXJIS5OXUqG2qNZSrXvpP6Ku+Mc1G3x72lXMnRZA==
X-Received: by 2002:a5d:5f4b:0:b0:385:e879:45cf with SMTP id ffacd0b85a97d-3861bb4c763mr2295298f8f.1.1733395305568;
        Thu, 05 Dec 2024 02:41:45 -0800 (PST)
Received: from redhat.com ([2.55.188.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386219096d8sm1623386f8f.78.2024.12.05.02.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:41:43 -0800 (PST)
Date: Thu, 5 Dec 2024 05:41:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/7] virtio_net: correct
 netdev_tx_reset_queue() invocation points
Message-ID: <20241205054100-mutt-send-email-mst@kernel.org>
References: <20241204050724.307544-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241204050724.307544-1-koichiro.den@canonical.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -x-L6Ws2z4wDsoH1x5XaVG5qwCeIVCZ1r_wvcjZjRhE_1733395306
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2024 at 02:07:17PM +0900, Koichiro Den wrote:
> When virtnet_close is followed by virtnet_open, some TX completions can
> possibly remain unconsumed, until they are finally processed during the
> first NAPI poll after the netdev_tx_reset_queue(), resulting in a crash
> [1]. Commit b96ed2c97c79 ("virtio_net: move netdev_tx_reset_queue() call
> before RX napi enable") was not sufficient to eliminate all BQL crash
> cases for virtio-net.
>=20
> This issue can be reproduced with the latest net-next master by running:
> `while :; do ip l set DEV down; ip l set DEV up; done` under heavy networ=
k
> TX load from inside the machine.
>=20
> This patch series resolves the issue and also addresses similar existing
> problems:
>=20
> (a). Drop netdev_tx_reset_queue() from open/close path. This eliminates t=
he
>      BQL crashes due to the problematic open/close path.
>=20
> (b). As a result of (a), netdev_tx_reset_queue() is now explicitly requir=
ed
>      in freeze/restore path. Add netdev_tx_reset_queue() to
>      free_unused_bufs().
>=20
> (c). Fix missing resetting in virtnet_tx_resize().
>      virtnet_tx_resize() has lacked proper resetting since commit
>      c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits").
>=20
> (d). Fix missing resetting in the XDP_SETUP_XSK_POOL path.
>      Similar to (c), this path lacked proper resetting. Call
>      netdev_tx_reset_queue() when virtqueue_reset() has actually recycled
>      unused buffers.
>=20
> This patch series consists of five commits:
>   [1/7]: Resolves (a) and (b).
>   [2/7[: Minor fix to make [3/7] streamlined.
>   [3/7]: Prerequisite for (c) and (d).
>   [4/7]: Prerequisite for (c).
>   [5/7]: Resolves (c).
>   [6/7]: Preresuisite for (d).
>   [7/7]: Resolves (d).
>=20
> Changes for v3:
>   - replace 'flushed' argument with 'recycle_done'
> Changes for v2:
>   - add tx queue resetting for (b) to (d) above
>=20
> v2: https://lore.kernel.org/all/20241203073025.67065-1-koichiro.den@canon=
ical.com/
> v1: https://lore.kernel.org/all/20241130181744.3772632-1-koichiro.den@can=
onical.com/



Overall looks good, but I think this is net material, not net-next.

Sent some suggestions for cosmetic changes.

>=20
> [1]:
> ------------[ cut here ]------------
> kernel BUG at lib/dynamic_queue_limits.c:99!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 7 UID: 0 PID: 1598 Comm: ip Tainted: G    N 6.12.0net-next_main+ #2
> Tainted: [N]=3DTEST
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), \
> BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> RIP: 0010:dql_completed+0x26b/0x290
> Code: b7 c2 49 89 e9 44 89 da 89 c6 4c 89 d7 e8 ed 17 47 00 58 65 ff 0d
> 4d 27 90 7e 0f 85 fd fe ff ff e8 ea 53 8d ff e9 f3 fe ff ff <0f> 0b 01
> d2 44 89 d1 29 d1 ba 00 00 00 00 0f 48 ca e9 28 ff ff ff
> RSP: 0018:ffffc900002b0d08 EFLAGS: 00010297
> RAX: 0000000000000000 RBX: ffff888102398c80 RCX: 0000000080190009
> RDX: 0000000000000000 RSI: 000000000000006a RDI: 0000000000000000
> RBP: ffff888102398c00 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000000000ca R11: 0000000000015681 R12: 0000000000000001
> R13: ffffc900002b0d68 R14: ffff88811115e000 R15: ffff8881107aca40
> FS:  00007f41ded69500(0000) GS:ffff888667dc0000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000556ccc2dc1a0 CR3: 0000000104fd8003 CR4: 0000000000772ef0
> PKRU: 55555554
> Call Trace:
>  <IRQ>
>  ? die+0x32/0x80
>  ? do_trap+0xd9/0x100
>  ? dql_completed+0x26b/0x290
>  ? dql_completed+0x26b/0x290
>  ? do_error_trap+0x6d/0xb0
>  ? dql_completed+0x26b/0x290
>  ? exc_invalid_op+0x4c/0x60
>  ? dql_completed+0x26b/0x290
>  ? asm_exc_invalid_op+0x16/0x20
>  ? dql_completed+0x26b/0x290
>  __free_old_xmit+0xff/0x170 [virtio_net]
>  free_old_xmit+0x54/0xc0 [virtio_net]
>  virtnet_poll+0xf4/0xe30 [virtio_net]
>  ? __update_load_avg_cfs_rq+0x264/0x2d0
>  ? update_curr+0x35/0x260
>  ? reweight_entity+0x1be/0x260
>  __napi_poll.constprop.0+0x28/0x1c0
>  net_rx_action+0x329/0x420
>  ? enqueue_hrtimer+0x35/0x90
>  ? trace_hardirqs_on+0x1d/0x80
>  ? kvm_sched_clock_read+0xd/0x20
>  ? sched_clock+0xc/0x30
>  ? kvm_sched_clock_read+0xd/0x20
>  ? sched_clock+0xc/0x30
>  ? sched_clock_cpu+0xd/0x1a0
>  handle_softirqs+0x138/0x3e0
>  do_softirq.part.0+0x89/0xc0
>  </IRQ>
>  <TASK>
>  __local_bh_enable_ip+0xa7/0xb0
>  virtnet_open+0xc8/0x310 [virtio_net]
>  __dev_open+0xfa/0x1b0
>  __dev_change_flags+0x1de/0x250
>  dev_change_flags+0x22/0x60
>  do_setlink.isra.0+0x2df/0x10b0
>  ? rtnetlink_rcv_msg+0x34f/0x3f0
>  ? netlink_rcv_skb+0x54/0x100
>  ? netlink_unicast+0x23e/0x390
>  ? netlink_sendmsg+0x21e/0x490
>  ? ____sys_sendmsg+0x31b/0x350
>  ? avc_has_perm_noaudit+0x67/0xf0
>  ? cred_has_capability.isra.0+0x75/0x110
>  ? __nla_validate_parse+0x5f/0xee0
>  ? __pfx___probestub_irq_enable+0x3/0x10
>  ? __create_object+0x5e/0x90
>  ? security_capable+0x3b/0x7=1B[I0
>  rtnl_newlink+0x784/0xaf0
>  ? avc_has_perm_noaudit+0x67/0xf0
>  ? cred_has_capability.isra.0+0x75/0x110
>  ? stack_depot_save_flags+0x24/0x6d0
>  ? __pfx_rtnl_newlink+0x10/0x10
>  rtnetlink_rcv_msg+0x34f/0x3f0
>  ? do_syscall_64+0x6c/0x180
>  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
>  netlink_rcv_skb+0x54/0x100
>  netlink_unicast+0x23e/0x390
>  netlink_sendmsg+0x21e/0x490
>  ____sys_sendmsg+0x31b/0x350
>  ? copy_msghdr_from_user+0x6d/0xa0
>  ___sys_sendmsg+0x86/0xd0
>  ? __pte_offset_map+0x17/0x160
>  ? preempt_count_add+0x69/0xa0
>  ? __call_rcu_common.constprop.0+0x147/0x610
>  ? preempt_count_add+0x69/0xa0
>  ? preempt_count_add+0x69/0xa0
>  ? _raw_spin_trylock+0x13/0x60
>  ? trace_hardirqs_on+0x1d/0x80
>  __sys_sendmsg+0x66/0xc0
>  do_syscall_64+0x6c/0x180
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7f41defe5b34
> Code: 15 e1 12 0f 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00 00
> f3 0f 1e fa 80 3d 35 95 0f 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00
> f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
> RSP: 002b:00007ffe5336ecc8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f41defe5b34
> RDX: 0000000000000000 RSI: 00007ffe5336ed30 RDI: 0000000000000003
> RBP: 00007ffe5336eda0 R08: 0000000000000010 R09: 0000000000000001
> R10: 00007ffe5336f6f9 R11: 0000000000000202 R12: 0000000000000003
> R13: 0000000067452259 R14: 0000556ccc28b040 R15: 0000000000000000
>  </TASK>
> [...]
> ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
>=20
>=20
> Koichiro Den (7):
>   virtio_net: correct netdev_tx_reset_queue() invocation point
>   virtio_ring: add a func argument 'recycle_done' to virtqueue_resize()
>   virtio_net: replace vq2rxq with vq2txq where appropriate
>   virtio_net: introduce virtnet_sq_free_unused_buf_done()
>   virtio_net: ensure netdev_tx_reset_queue is called on tx ring resize
>   virtio_ring: add a func argument 'recycle_done' to virtqueue_reset()
>   virtio_net: ensure netdev_tx_reset_queue is called on bind xsk for tx
>=20
>  drivers/net/virtio_net.c     | 23 +++++++++++++++++------
>  drivers/virtio/virtio_ring.c | 12 ++++++++++--
>  include/linux/virtio.h       |  6 ++++--
>  3 files changed, 31 insertions(+), 10 deletions(-)
>=20
> --=20
> 2.43.0

