Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A0C2C0296
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503192; cv=none; b=swKN1rLTWzpWVxhwlv/hWAmKOL26Nx5oJtYs2+wSfEb+RfcpGxwWJFKBTQYVRUiANp1nmTG1xIFKP+k9Uuzs+47R4uhHN8i30cQBrHnVeZdi2F6eU5fzMxAbVt2fs6PcOW4oYToD97C2KF71AnuGpnIiEtqG0Wip9Lm7jp8fnts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503192; c=relaxed/simple;
	bh=FWQl+ThD6FfnU8sAPTGh3+UCUS6+i6Rts9l/UHPRygg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJRPmLUYdTwMa8pswAY5ur1i3oZNzx5EzS5YJkVhXbfxzU+bOgzHHoteBWhw84s1Os1X8f/2IlN5OaT9jzAWhI/zYm32rC0TRDghDzQF1B/M0EkOiSa1xZuz25+biZfmkPe13+Gnau9udpUtcdojxnp9mBZlD9niLMxylE+BQFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RVGVqXe0; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RVGVqXe0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769503190; x=1801039190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FWQl+ThD6FfnU8sAPTGh3+UCUS6+i6Rts9l/UHPRygg=;
  b=RVGVqXe07Qi9fJiQBd5Lax+XMJckHvgsVJNXy/71i5vOYlwyke42G3L6
   fsPWhf/DZD7Kj+rCyokXMrBVdIf0OFhrfpthudJI9dVSPQxUBqZxH3/Ed
   o5EPwMLLgAbtPTX/FX4u4RSG/iGGTFw1uB7mfB6+44Oo4wbd0fyuOqXf4
   GSuFnGRT6p6gZLjXuLRFyabyQNJsTR1E96rJXK22NAcMmxfVsqhIRnqEu
   nPjuz1XWiT8HmrGAxzxVEcs9yB+AJV8ew8GIobjxheZCQarTjo6pNw3JX
   Cn6b5Q/rFpuImHW9nohMYKXLLOuDQRljT/NFOX8KJ4Tqj7FA/iA9z6dKw
   A==;
X-CSE-ConnectionGUID: ZYO9w2gvS0mGI8JTExjvGQ==
X-CSE-MsgGUID: xXMYSu8VT9u7jHAFh/N8uA==
X-IronPort-AV: E=Sophos;i="6.21,256,1763395200"; 
   d="scan'208";a="140205744"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2026 16:39:37 +0800
IronPort-SDR: 697879ca_wfEKUFaeyu6XFZB6xLxNymj9TCKUyoGdyIZu00kXqCfy1Ls
 x2BDY7I7NP+55LESLvR8c7roRDyiq7nFd0Pnz6w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2026 00:39:38 -0800
WDCIronportException: Internal
Received: from 5cg02580n2.ad.shared (HELO neo.wdc.com) ([10.224.28.78])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2026 00:39:36 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: virtualization@lists.linux.dev
Cc: Alexander Graf <graf@amazon.com>,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH RFC 3/3] virtio: silence KCSAN warning in vring_interrupt
Date: Tue, 27 Jan 2026 09:39:26 +0100
Message-ID: <20260127083926.865555-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127083926.865555-1-johannes.thumshirn@wdc.com>
References: <20260127083926.865555-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When booting a Qemu VM with virtio-blk and KCSAN enabled, KCSAN emits
the following warning about a data-race in vring_interrupt().

 ==================================================================
 BUG: KCSAN: data-race in vring_interrupt+0x125/0x1f0

 race at unknown origin, with read to 0xffff88810218d942 of 2 bytes by interrupt on cpu 7:
  vring_interrupt+0x125/0x1f0
  __handle_irq_event_percpu+0xaf/0x310
  handle_irq_event+0x76/0xf0
  handle_edge_irq+0x1fc/0x3e0
  __common_interrupt+0x79/0x160
  common_interrupt+0xa6/0xe0
  asm_common_interrupt+0x26/0x40
  pv_native_safe_halt+0x17/0x20
  default_idle+0x9/0x10
  default_idle_call+0x3c/0x110
  do_idle+0x166/0x190
  cpu_startup_entry+0x29/0x30
  start_secondary+0x114/0x140
  common_startup_64+0x129/0x138

 value changed: 0x3a3a -> 0x3a3b

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Not tainted 6.19.0-rc7+ #223 PREEMPT(none)
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
 ==================================================================

This warning is likely a false positive as the change happens on the
virtio vring.

Annotate the return of more_used() with data_race() to silence the
warning.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index d1033768b6cd..7fa8f2ebe94e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2695,7 +2695,7 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	if (!more_used(vq)) {
+	if (data_race(!more_used(vq))) {
 		pr_debug("virtqueue interrupt with no work for %p\n", vq);
 		return IRQ_NONE;
 	}
-- 
2.52.0

