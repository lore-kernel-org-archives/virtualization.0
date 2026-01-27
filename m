Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807EE2BF3F4
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503191; cv=none; b=EIuC/sRYVGDdFCBXf582xFkiNmwR/tqhjG6/d9+Jnceq1w5WHVdRG8LiIiEixMkfB+66QNUrxN8vgSmd/+W5Aj/N2vqVphv/pTL1khb2dzUtxe50rhTRa48ne6tMQNMjWY/ADHiwtUz/BqO+xOhzm/VxCbcmgE7IYV+crdRzPMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503191; c=relaxed/simple;
	bh=9dmXKvIDjyVijaLe1OE+6GiQ10MlwtAtKktf3TzGO+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbgrz5awKsYNdsEZOlgLkd2N7EvQatoaYcEr7qSIOEPPVMmnQ1tBHmg0qlbn5UZeQ3UVk1s06AqxNnDZebRJlgSlP2S8Sznn9bKJvemAmistYOX4JZeVDJDDx/e2e+XJ+l6mEOlTnIpy06uGW+PpPnqAVfEs5mrZbZHGmq6f/To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=P/sxAwMW; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="P/sxAwMW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769503189; x=1801039189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9dmXKvIDjyVijaLe1OE+6GiQ10MlwtAtKktf3TzGO+E=;
  b=P/sxAwMW1HZVhyFOx0n4HIUmeAyLntWVf249hNu3uxRZ16CQ3ldvjso8
   vBwRyjFfyeqamPDzMPmiYIGtD2ldM+Srj4fEc+oDWmr5q5c/FiuxajXiJ
   9XE2upvrVd6WZXYiHspesCZwMtMuyTYsBOpKiTGLRLYfxHfaob2ixaDUR
   fpPIWdnjvAxSB8Nz386xqGYnQNtTcvLpJZcQbwiv23Dw1cip32qKAjtOR
   QPBdCZy6fuxH6GmYPK73mBasr+/tvr6tA+WOV8Fdt0qPNFgbxK9QAEAaO
   GWp5aUVwh4SGzIp0ubhYq5DHTixG8mGJ9kUwim7jBp5JAfn4EVX6jCTqO
   A==;
X-CSE-ConnectionGUID: oBLcQ1C9SBOgL2EbrG1iJg==
X-CSE-MsgGUID: 4UHIN4zCRU6YJ+MrViMXGQ==
X-IronPort-AV: E=Sophos;i="6.21,256,1763395200"; 
   d="scan'208";a="140205743"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2026 16:39:34 +0800
IronPort-SDR: 697879c8_/0yCwaJvvlwhEtTYmmQpuxui1IfkXouPmKf8s9TgE88OPvR
 P2XBUUl7adXIX2ppId+GpJVPRDXALoIKzpGUDlA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2026 00:39:36 -0800
WDCIronportException: Internal
Received: from 5cg02580n2.ad.shared (HELO neo.wdc.com) ([10.224.28.78])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2026 00:39:34 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: virtualization@lists.linux.dev
Cc: Alexander Graf <graf@amazon.com>,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH RFC 2/3] virtio: silence KCSAN warning in virtqueue_get_buf_ctx_split
Date: Tue, 27 Jan 2026 09:39:25 +0100
Message-ID: <20260127083926.865555-3-johannes.thumshirn@wdc.com>
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
the following warning about a data-race in virtqueue_get_buf_ctx_split().

 ==================================================================
 BUG: KCSAN: data-race in virtqueue_get_buf_ctx_split+0x6e/0x260

 race at unknown origin, with read to 0xffff8881020f1942 of 2 bytes by task 1 on cpu 7:
  virtqueue_get_buf_ctx_split+0x6e/0x260
  virtqueue_get_buf+0x4b/0x60
  __send_to_port+0x156/0x170
  put_chars+0xcb/0x110
  hvc_console_print+0x1d6/0x2a0
  console_flush_one_record+0x3dd/0x510
  console_unlock+0x8c/0x160
  vprintk_emit+0x2fe/0x380
  vprintk_default+0x1d/0x30
  vprintk+0xe/0x20
  _printk+0x4c/0x60
  btrfs_test_raid_stripe_tree+0x25/0x90
  btrfs_run_sanity_tests.cold+0xf1/0x13b
  init_btrfs_fs+0x73/0x110
  do_one_initcall+0x5b/0x2d0
  kernel_init_freeable+0x2a2/0x340
  kernel_init+0x1e/0x1b0
  ret_from_fork+0x137/0x1b0
  ret_from_fork_asm+0x1a/0x30

 value changed: 0x0160 -> 0x0161

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 7 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.19.0-rc7+ #219 PREEMPT(none)
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
 ==================================================================

This warning is likely a false positive as the change happens on the
virtio vring.

Annotate the return of more_used_split() with data_race() to silence
the warning.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5f8c8254bb6c..d1033768b6cd 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -829,7 +829,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 		return NULL;
 	}
 
-	if (!more_used_split(vq)) {
+	if (data_race(!more_used_split(vq))) {
 		pr_debug("No more buffers in queue\n");
 		END_USE(vq);
 		return NULL;
-- 
2.52.0

