Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DBA18BC0F
	for <virtualization@lists.linux.dev>; Tue,  3 Dec 2024 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211063; cv=none; b=thLvZzPunRl5/PMc4GsK9sXotKxpHmDyCRNqi/yXeJiWfjyLYik4F3Dq6F/H5A9MOmJnXAnMCr9x+/C/aUnSkcPH6sgNd+oFzLP64dA/33XsZOeCPvvVGLOMUSC2TDbVBiYG+sHzXFdDaRAWwIGy49b7kVZfeUWnQZl/xnm9voo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211063; c=relaxed/simple;
	bh=hM3TSWI+eWAZK1GQuQ4ljeW5GtUNvTvSlHAiQfkse1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmMw/kU2oHJ1pCB/mibj4K9QWWqaNciOO1ozDULagkqvUiVTkptul0yRFGZqoNLYsSse5GJlcTTQHdNEth5+8HizJtIr4uGhlcn0VIa6Asful3O2IbEsv+27zL77gpuW/zHcceH9/0WwHZYfjvF+o140dRO22gi7+SqEczo1AfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=H/AroOl6; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="H/AroOl6"
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1E6AE40C4B
	for <virtualization@lists.linux.dev>; Tue,  3 Dec 2024 07:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733211058;
	bh=rn0yafvxR+rgXFWM/3BvoQL8ErZXVisWsjUhy9aKjNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=H/AroOl60rE8XvEHn+GjTV6awt+rlyxhqA0IJxu3m9SGcJVNNiytfUwmjbGPJbvQL
	 8+6CzX9sA3RbDB1sFHSfa9d2bz1rI2/JuQz5+T9E1jY+ECkK9BaJVWTGEc0W5GA1x+
	 oloGd/eg47oLmyWvdMeqfUfPQDMdl5jk2by+CAIQ7BpDtv0/lsBi7r2oLrVT7ipjOX
	 iEpK9ezKvmrIupsSia7v5RwMGwmOTFoQnhDJdV5jbEnfeSfzMI9y13JoJ3fqCR0OPe
	 rj9CIezhFTnXka+OVln9J2I7aErZbss3ulIeMy5aoQZEj+IUH3t5wYC+rK+JiO/K8J
	 WqixcdNWrNJjg==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2150e4a9f3cso45215455ad.1
        for <virtualization@lists.linux.dev>; Mon, 02 Dec 2024 23:30:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733211056; x=1733815856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rn0yafvxR+rgXFWM/3BvoQL8ErZXVisWsjUhy9aKjNw=;
        b=sO/UADbh3ClgWzAKKf98dtRIPeSZ6ytue+tGwA/lPgUvUrTWttDW+9psyUTTwfIJTJ
         jAVfiTsh7tfMdc+gO5RA/2is11ke63Vno79Ljv2U9PVCRNsLnd/2K2WpS9iBraw3IQLm
         CZfCXCm/vcV+qdFVnUZDI7QkH1g1hJD4mFU3djDhMIP2DWCKFkwZWmc/TuLzA4yzPP6g
         3F65U6FCRHjcZBbO3DJWnzxLzAmPObJqwsbMHQQZix/1xpJARetq8Uw+S/qCA38+eek2
         eyB1vomXsMZRjuAniI44IC5CeSbupPDttNZJ9e9YZ2s0FFErZRkieaXkiZcxRZ9qO15B
         AzIA==
X-Gm-Message-State: AOJu0YyPwEQcHUF7gAhy84f6sgway3aomWDvHoti2Tf4czIcKx0FZcLQ
	4fh8QP+6t4X7/HfWR+fZLQQxaDI6x3FxTGQCTIidLrUcIiQqI9PmnfMqA1R0ynSbYfa6E93ljMv
	xU4l67TkUgk+HmBx33x7D2Si8TIuqtXJAXgRIauXust2yaF8wGDBMyqzo3tgW/0Cg7eYV0cCzoG
	eQAFXUP06XRW+g
X-Gm-Gg: ASbGncslY60BQxggDJ4jBwvD8+vVXAUwXN1vpPVO/MbCEP85kIgmciFFV2jqn4t0ron
	jGKeSuyG4AuIjogm8/QfnUNbTO4vJPpLTcZXfwSSWnZUiSAMB+dK7FDpFy2lm1yxLJ/htSw0q//
	I0i2nn1AbcfcvZ+/XrgwdLWhfl33duLVE+5PHbrrMMIc3GJ8/UHAgFUHhc0N+ALtSTRQ1LDzKn9
	O2zQ4YhY5xIJOGri674IAnbERQPx7wBsukIUdj2GQVHbJwwiTyP3yPfi0v+ji8NdzyY
X-Received: by 2002:a17:903:191:b0:215:7cd2:1132 with SMTP id d9443c01a7336-215bd0e7d81mr19717785ad.29.1733211056502;
        Mon, 02 Dec 2024 23:30:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7gi3gIAf+lQKauh1LZNO6nUm9eJREawvVeJIpAEFisTXFFb5l8sD9JG8LDx7etuoxazJyYg==
X-Received: by 2002:a17:903:191:b0:215:7cd2:1132 with SMTP id d9443c01a7336-215bd0e7d81mr19717435ad.29.1733211056018;
        Mon, 02 Dec 2024 23:30:56 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:b2b6:e8c2:50d0:c558])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21586d40afasm35735165ad.270.2024.12.02.23.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 23:30:55 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net-next v2 1/5] virtio_net: correct netdev_tx_reset_queue() invocation point
Date: Tue,  3 Dec 2024 16:30:21 +0900
Message-ID: <20241203073025.67065-2-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203073025.67065-1-koichiro.den@canonical.com>
References: <20241203073025.67065-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When virtnet_close is followed by virtnet_open, some TX completions can
possibly remain unconsumed, until they are finally processed during the
first NAPI poll after the netdev_tx_reset_queue(), resulting in a crash
[1]. Commit b96ed2c97c79 ("virtio_net: move netdev_tx_reset_queue() call
before RX napi enable") was not sufficient to eliminate all BQL crash
cases for virtio-net.

This issue can be reproduced with the latest net-next master by running:
`while :; do ip l set DEV down; ip l set DEV up; done` under heavy network
TX load from inside the machine.

netdev_tx_reset_queue() can actually be dropped from virtnet_open path;
the device is not stopped in any case. For BQL core part, it's just like
traffic nearly ceases to exist for some period. For stall detector added
to BQL, even if virtnet_close could somehow lead to some TX completions
delayed for long, followed by virtnet_open, we can just take it as stall
as mentioned in commit 6025b9135f7a ("net: dqs: add NIC stall detector
based on BQL"). Note also that users can still reset stall_max via sysfs.

So, drop netdev_tx_reset_queue() from virtnet_enable_queue_pair(). This
eliminates the BQL crashes. Note that netdev_tx_reset_queue() is now
explicitly required in freeze/restore path, so this patch adds it to
free_unused_bufs().

[1]:
------------[ cut here ]------------
kernel BUG at lib/dynamic_queue_limits.c:99!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 7 UID: 0 PID: 1598 Comm: ip Tainted: G    N 6.12.0net-next_main+ #2
Tainted: [N]=TEST
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), \
BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:dql_completed+0x26b/0x290
Code: b7 c2 49 89 e9 44 89 da 89 c6 4c 89 d7 e8 ed 17 47 00 58 65 ff 0d
4d 27 90 7e 0f 85 fd fe ff ff e8 ea 53 8d ff e9 f3 fe ff ff <0f> 0b 01
d2 44 89 d1 29 d1 ba 00 00 00 00 0f 48 ca e9 28 ff ff ff
RSP: 0018:ffffc900002b0d08 EFLAGS: 00010297
RAX: 0000000000000000 RBX: ffff888102398c80 RCX: 0000000080190009
RDX: 0000000000000000 RSI: 000000000000006a RDI: 0000000000000000
RBP: ffff888102398c00 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000000ca R11: 0000000000015681 R12: 0000000000000001
R13: ffffc900002b0d68 R14: ffff88811115e000 R15: ffff8881107aca40
FS:  00007f41ded69500(0000) GS:ffff888667dc0000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556ccc2dc1a0 CR3: 0000000104fd8003 CR4: 0000000000772ef0
PKRU: 55555554
Call Trace:
 <IRQ>
 ? die+0x32/0x80
 ? do_trap+0xd9/0x100
 ? dql_completed+0x26b/0x290
 ? dql_completed+0x26b/0x290
 ? do_error_trap+0x6d/0xb0
 ? dql_completed+0x26b/0x290
 ? exc_invalid_op+0x4c/0x60
 ? dql_completed+0x26b/0x290
 ? asm_exc_invalid_op+0x16/0x20
 ? dql_completed+0x26b/0x290
 __free_old_xmit+0xff/0x170 [virtio_net]
 free_old_xmit+0x54/0xc0 [virtio_net]
 virtnet_poll+0xf4/0xe30 [virtio_net]
 ? __update_load_avg_cfs_rq+0x264/0x2d0
 ? update_curr+0x35/0x260
 ? reweight_entity+0x1be/0x260
 __napi_poll.constprop.0+0x28/0x1c0
 net_rx_action+0x329/0x420
 ? enqueue_hrtimer+0x35/0x90
 ? trace_hardirqs_on+0x1d/0x80
 ? kvm_sched_clock_read+0xd/0x20
 ? sched_clock+0xc/0x30
 ? kvm_sched_clock_read+0xd/0x20
 ? sched_clock+0xc/0x30
 ? sched_clock_cpu+0xd/0x1a0
 handle_softirqs+0x138/0x3e0
 do_softirq.part.0+0x89/0xc0
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xa7/0xb0
 virtnet_open+0xc8/0x310 [virtio_net]
 __dev_open+0xfa/0x1b0
 __dev_change_flags+0x1de/0x250
 dev_change_flags+0x22/0x60
 do_setlink.isra.0+0x2df/0x10b0
 ? rtnetlink_rcv_msg+0x34f/0x3f0
 ? netlink_rcv_skb+0x54/0x100
 ? netlink_unicast+0x23e/0x390
 ? netlink_sendmsg+0x21e/0x490
 ? ____sys_sendmsg+0x31b/0x350
 ? avc_has_perm_noaudit+0x67/0xf0
 ? cred_has_capability.isra.0+0x75/0x110
 ? __nla_validate_parse+0x5f/0xee0
 ? __pfx___probestub_irq_enable+0x3/0x10
 ? __create_object+0x5e/0x90
 ? security_capable+0x3b/0x70
 rtnl_newlink+0x784/0xaf0
 ? avc_has_perm_noaudit+0x67/0xf0
 ? cred_has_capability.isra.0+0x75/0x110
 ? stack_depot_save_flags+0x24/0x6d0
 ? __pfx_rtnl_newlink+0x10/0x10
 rtnetlink_rcv_msg+0x34f/0x3f0
 ? do_syscall_64+0x6c/0x180
 ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
 ? __pfx_rtnetlink_rcv_msg+0x10/0x10
 netlink_rcv_skb+0x54/0x100
 netlink_unicast+0x23e/0x390
 netlink_sendmsg+0x21e/0x490
 ____sys_sendmsg+0x31b/0x350
 ? copy_msghdr_from_user+0x6d/0xa0
 ___sys_sendmsg+0x86/0xd0
 ? __pte_offset_map+0x17/0x160
 ? preempt_count_add+0x69/0xa0
 ? __call_rcu_common.constprop.0+0x147/0x610
 ? preempt_count_add+0x69/0xa0
 ? preempt_count_add+0x69/0xa0
 ? _raw_spin_trylock+0x13/0x60
 ? trace_hardirqs_on+0x1d/0x80
 __sys_sendmsg+0x66/0xc0
 do_syscall_64+0x6c/0x180
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f41defe5b34
Code: 15 e1 12 0f 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00 00
f3 0f 1e fa 80 3d 35 95 0f 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00
f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
RSP: 002b:00007ffe5336ecc8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f41defe5b34
RDX: 0000000000000000 RSI: 00007ffe5336ed30 RDI: 0000000000000003
RBP: 00007ffe5336eda0 R08: 0000000000000010 R09: 0000000000000001
R10: 00007ffe5336f6f9 R11: 0000000000000202 R12: 0000000000000003
R13: 0000000067452259 R14: 0000556ccc28b040 R15: 0000000000000000
 </TASK>
[...]
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 64c87bb48a41..48ce8b3881b6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3054,7 +3054,6 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 	if (err < 0)
 		goto err_xdp_reg_mem_model;
 
-	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qp_index));
 	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
 	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
 
@@ -6243,6 +6242,7 @@ static void free_unused_bufs(struct virtnet_info *vi)
 		struct virtqueue *vq = vi->sq[i].vq;
 		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
 			virtnet_sq_free_unused_buf(vq, buf);
+		netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, i));
 		cond_resched();
 	}
 
-- 
2.43.0

