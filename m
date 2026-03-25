Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C90C3FADF0
	for <virtualization@lists.linux.dev>; Wed, 25 Mar 2026 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457757; cv=none; b=qyHEsoHe5CpkeUnasyQpCJaSd0wBD4yUZXGpy3sMZZB26129XS5vqKgbRWJaO4YMCP/M54OJNpRtbJ7T4P19Mrnpoj2YsymVvBRUDRX98IYJDK5DIo/JKc8it0lHGd53Rdd8++nFYeP63hriXVMiHhhlPjUNlqQ5zaiAUmY+0K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457757; c=relaxed/simple;
	bh=+OjMb5092maQp2iEGHKWjP63NT/l3FVLEKtpncsAeD4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gn060QBwMZ/JXsj57orBdcZfI7HL1rSJKxdJjoRZQU1EYEcnmG+2khgYjTflhU5DCnwF7FUMGULTagWZV3Vsvjd40nFXo8MgS0p5+pNCgSzZGDiQB8t9rTWBUsig4kFgiBWLAWJsosmBHuozshEGU4L3UPPp1UmTZV52qZGm8kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ewzOSV46; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewzOSV46"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774457752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5gZ/S9pbjjkoQ+gcMJJTXTQUJ/FjVdC55bH/vaTcEqo=;
	b=ewzOSV46u1ANS/Rf7aHfXMgM9RPRU+yErI82+z7BjptmN6dQj8pqInI2Z/Ffg1KQBWW0ya
	b6ohzlc2QYLqwPJ9pb4n7A/BrEltJWoc72bk7WEdmBGZMLykpwo4Cs3qmI0LbWj0XlEWGr
	ZPLcw4Iecd9zeo3FClUGfjZMek7TOKI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-2l0-pabQMkaNGLXp_E35HQ-1; Wed, 25 Mar 2026 12:55:50 -0400
X-MC-Unique: 2l0-pabQMkaNGLXp_E35HQ-1
X-Mimecast-MFC-AGG-ID: 2l0-pabQMkaNGLXp_E35HQ_1774457749
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43b4a9a3bf6so8164f8f.0
        for <virtualization@lists.linux.dev>; Wed, 25 Mar 2026 09:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774457749; x=1775062549;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gZ/S9pbjjkoQ+gcMJJTXTQUJ/FjVdC55bH/vaTcEqo=;
        b=cgRI5EWCoD5vwYMuuvQ2SCq75p4hz143kWSfC63oO62ZSZUVkI37swkgydSEKrtqo1
         aay2UFcn0wXmx/5MMOEBlLFt9pRrVdI2kg3eNeolDGzloUAbVqA9DFBgZXRH3gMohHZU
         E7zt4u/5TsTWqJI0UbXJui7g6skpOamlyz6ejIosYwkXa4JfIHn9L8RacQ32Vonr3FKc
         in29aj6Eh0kVxyZOqJbz+RQSR+WW/dZFWkVFXXagd1Ti6vM3fhXrFds8E7XgCSxullr5
         SMGyZ3+sw3JHQdAYrFuzdTVnmc1+T94q9wC1PfCRSR9CjQn7NJ+y+3zgwlq9QXvJ695h
         FBzw==
X-Forwarded-Encrypted: i=1; AJvYcCUZKAlawzdEet8Ml/6Q4lGqqSP6PVgIE+WZ+ZN8Olo/yOyzuIAZp8z8eqi4RW3Z4wgYEq6fW4hfUb3aD8Dh/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpeqPccvjDzEKsseYT5UpCoSCTZmgkg+XzGCxx5TcpnOF82w46
	hxaTf+IsHLRjQDPBYtcFwawXm1NDLd5ZQ5moz/K1VEPbjnXZWNIP9I2Rww+67mNniKlCCGiqb5W
	PcHxcBDzndWHTx8Z2kMGwERcHYMxNP7iWidKEBfhQ1aiGwTDfCsTNYzX6FolkuuANA6ON
X-Gm-Gg: ATEYQzwDP6U2l5pzM+UC9IXn6FaEmegEpSkC/HDzq9QEu5reg21yzWRkMoIMb0/FGYA
	kuLSa7TSteTg9CC6zzHX+sznfUnstuZAMyELqm8DcTF6pRih64Iv8CtTfcrE4xP6Wa82udhtRtN
	5JJL4u6ImSQtm2TE9ImvWEVja8uAeEtZYmRlFP7wsAwFeZIQRwiKnL0N567bWq5Hpwd3Xobflyp
	2f1YBqRAAi4ks0C7LV25h8rjzc6+KUxgZAC6rM9ioYOGDGIuNYBZVrnHElR5Z/FLFZe81hVZ1bM
	GXN28cGQ82sjyXBAWdI+hlJI4pM7NNhM28UJoL9W+eT3R32fXPiYyoXdEhWiuPIRjNHnuFjGHRt
	N+Tptb6Kw/IBEHcUe
X-Received: by 2002:a5d:64e7:0:b0:43b:4960:60f2 with SMTP id ffacd0b85a97d-43b88a399aemr5997834f8f.47.1774457749415;
        Wed, 25 Mar 2026 09:55:49 -0700 (PDT)
X-Received: by 2002:a5d:64e7:0:b0:43b:4960:60f2 with SMTP id ffacd0b85a97d-43b88a399aemr5997793f8f.47.1774457748903;
        Wed, 25 Mar 2026 09:55:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b91943184sm1001694f8f.14.2026.03.25.09.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 09:55:48 -0700 (PDT)
Date: Wed, 25 Mar 2026 12:55:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org, Simon Schippers <simon.schippers@tu-dortmund.de>,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, eperezma@redhat.com, leiyang@redhat.com,
	stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>
Subject: [PATCH net] ptr_ring: disable KCSAN warnings
Message-ID: <97d39458d8dd7a00341f0be391b580650896ce42.1774457524.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fwWBiZASlIYs-5tgNixECAiTs5PmajjpJC7Hkzh8xCY_1774457749
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Eric Dumazet reported KCSAN warnings:

BUG: KCSAN: data-race in pfifo_fast_dequeue / pfifo_fast_enqueue

write to 0xffff88811d5ccc00 of 8 bytes by interrupt on cpu 0:
__ptr_ring_zero_tail include/linux/ptr_ring.h:259 [inline]
__ptr_ring_discard_one include/linux/ptr_ring.h:291 [inline]
__ptr_ring_consume include/linux/ptr_ring.h:311 [inline]
__skb_array_consume include/linux/skb_array.h:98 [inline]
pfifo_fast_dequeue+0x770/0x8f0 net/sched/sch_generic.c:770
dequeue_skb net/sched/sch_generic.c:297 [inline]
qdisc_restart net/sched/sch_generic.c:402 [inline]
__qdisc_run+0x189/0xc80 net/sched/sch_generic.c:420
qdisc_run include/net/pkt_sched.h:120 [inline]
net_tx_action+0x379/0x590 net/core/dev.c:5793
handle_softirqs+0xb9/0x280 kernel/softirq.c:622
do_softirq+0x45/0x60 kernel/softirq.c:523
__local_bh_enable_ip+0x70/0x80 kernel/softirq.c:450
local_bh_enable include/linux/bottom_half.h:33 [inline]
bpf_test_run+0x2db/0x620 net/bpf/test_run.c:426
bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
__sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
__do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
__se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
__x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811d5ccc00 of 8 bytes by task 22632 on cpu 1:
__ptr_ring_produce include/linux/ptr_ring.h:106 [inline]
ptr_ring_produce include/linux/ptr_ring.h:129 [inline]
skb_array_produce include/linux/skb_array.h:44 [inline]
pfifo_fast_enqueue+0xd5/0x2c0 net/sched/sch_generic.c:741
dev_qdisc_enqueue net/core/dev.c:4144 [inline]
__dev_xmit_skb net/core/dev.c:4188 [inline]
__dev_queue_xmit+0x6a4/0x1f20 net/core/dev.c:4795
dev_queue_xmit include/linux/netdevice.h:3384 [inline]
__bpf_tx_skb net/core/filter.c:2153 [inline]
__bpf_redirect_common net/core/filter.c:2197 [inline]
__bpf_redirect+0x862/0x990 net/core/filter.c:2204
____bpf_clone_redirect net/core/filter.c:2487 [inline]
bpf_clone_redirect+0x20c/0x290 net/core/filter.c:2450
bpf_prog_53f18857bc887b09+0x22/0x2a
bpf_dispatcher_nop_func include/linux/bpf.h:1402 [inline]
__bpf_prog_run include/linux/filter.h:723 [inline]
bpf_prog_run include/linux/filter.h:730 [inline]
bpf_test_run+0x29d/0x620 net/bpf/test_run.c:423
bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
__sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
__do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
__se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
__x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0xffff888104a93a00 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 22632 Comm: syz.0.4135 Tainted: G W syzkaller #0
PREEMPT(full)
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/24/2026

There is no race here: reading/writing a partial pointer
would be fine, because the reading is always done by the producer
which merely cares about NULL/non NULL.
Document this / disable the warnings using data_race().

Link: https://lore.kernel.org/all/CANn89iLHwZ4foPEL2TdQhYx3Ps3zXiwygb%3DQr7OTKW2R7Ldixg@mail.gmail.com/
Tested-by: Opus Sonnet 4.6 1M window.
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/ptr_ring.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 534531807d95..87ff669b0c57 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -103,7 +103,7 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
  */
 static inline int __ptr_ring_produce(struct ptr_ring *r, void *ptr)
 {
-	if (unlikely(!r->size) || r->queue[r->producer])
+	if (unlikely(!r->size) || data_race(r->queue[r->producer]))
 		return -ENOSPC;
 
 	/* Make sure the pointer we are storing points to a valid data. */
@@ -256,7 +256,7 @@ static inline void __ptr_ring_zero_tail(struct ptr_ring *r, int consumer_head)
 	 * besides the first one until we write out all entries.
 	 */
 	while (likely(head > r->consumer_tail))
-		r->queue[--head] = NULL;
+		data_race(r->queue[--head] = NULL);
 
 	r->consumer_tail = consumer_head;
 }
-- 
MST

