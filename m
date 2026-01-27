Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460D635D60B
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527542; cv=none; b=sJvl5pgNrvw3r7GNpWk5ekqZF0R9eBGY/88TBbczeRR6ZO3yTyZNIfFIbBqO0AAKFZiS8CXtAL1Gx3wj9bE35LqX3HMuTqk+Y3SqJbTVTWsFGQc4v26rXbd+HuciEiph1AtDY3hDFNINvapMBGRjdioGdRULfY7KomaNiPmSyw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527542; c=relaxed/simple;
	bh=7sBrf0Xd+tKmMEUiMyBd8Vqg7Shnvuqfge/ILid7h+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQRs6J1SrjY3XMEyvUk+Yup0YYlPBnxDV+47VVqrn5SXIYh6f0wIInH350d4MjDCaazaBEkM2sLzDtw1i/TyEIq1oEUyT3NZp+p1Fvs7NCqbew/+B0eb+QrCng2KCZQrXwYNIGa+2dahai3SbWJmYafLEdX33WHJkNchkuxLXLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nZY09RFP; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nZY09RFP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769527540; x=1801063540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7sBrf0Xd+tKmMEUiMyBd8Vqg7Shnvuqfge/ILid7h+s=;
  b=nZY09RFPmXmaWs500hdfIAsZZBmooWb788Z5sGB5M3sUZg/qBJqQgwF4
   MmUDEUHSt4hqTpFoJZC+wfrhYUpXSzrDpO3M7cP/faoSMIg2qRek5l9LM
   2VSFnNVU2Y06QZe5cL/F6rjg4nMYRJyM2x4QeMP208vP0q56r1LF0j4kA
   j1f6UieID56e6Ga2pbcCwLVejXXt8Mkv8h55BLtyC8xHfngNEAVmQ0CXp
   8U3Zj7pCVvyZs5kzYmHcB2/fuX5v25M/m41VtRsu4a1BJ7bdGMRADM17h
   Lw3Z/vndOl7Y9DF8HYXs3P77d1qsuWdudlRj4jbMvoWCwRBB4pbW46sZQ
   w==;
X-CSE-ConnectionGUID: GVaPq5b1QdCfjpDFIFCHkA==
X-CSE-MsgGUID: tzJHMwgrS/WiaeEfEuqzfA==
X-IronPort-AV: E=Sophos;i="6.21,257,1763395200"; 
   d="scan'208";a="139288698"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2026 23:25:35 +0800
IronPort-SDR: 6978d8ef_Swb5ueulaIkBrn5IMYdgMF8Y0sz0lM+4wh0GO+H/DOyK2n9
 1NkLXcLyTYL9NE4Zg/LoU576knANR1o4v3EctxQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2026 07:25:36 -0800
WDCIronportException: Internal
Received: from wdap-nm5iivsczy.ad.shared (HELO neo.fritz.box) ([10.224.28.83])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2026 07:25:33 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/2] virtio: silence KCSAN warning in virtqueue_get_buf_ctx_split
Date: Tue, 27 Jan 2026 16:25:22 +0100
Message-ID: <20260127152524.200465-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127152524.200465-1-johannes.thumshirn@wdc.com>
References: <20260127152524.200465-1-johannes.thumshirn@wdc.com>
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
 drivers/virtio/virtio_ring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index ddab68959671..1db27ee2d89f 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -808,8 +808,8 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 
 static bool more_used_split(const struct vring_virtqueue *vq)
 {
-	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev,
-			vq->split.vring.used->idx);
+	return data_race(vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev,
+				vq->split.vring.used->idx));
 }
 
 static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
-- 
2.52.0

