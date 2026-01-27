Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243A92BD5AF
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503191; cv=none; b=glmYAB/r6Bg0b8rNKdJ6YaEgiP61zknTwETkNsoyfXb6eEkiw3NQRzNyIBbSqet1JtaXTrmm1D77SV9T+t6quiVcwV+h/F9whjrX293W8C5+LQ+gC8QA/gDXN/AkxWnUrP8zLcpSZGlogafmQud5YeO89Hkw6yrrkX6Q1Mj0qOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503191; c=relaxed/simple;
	bh=XBzWm4v6PSi/oXWq52MxC83lY+5UYxtqQ1gZlDpzeuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9MDr3bUBsj6kf8Qacybso26PB9zeQRzQ/vZ1pIF+D+lszvgdd4J0yjcYrQ8O62gDVXgP1W0XZ9zWr/yv/MzifUQsEICvPLZE4+oHPrCpf0fUv7PTh4hyK3RaUGjwwX0nlBLIlBDSj8LaGhphiFKZk4PBhTlGh3PNVV3v6G+WfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WXiLHXxP; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WXiLHXxP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769503188; x=1801039188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XBzWm4v6PSi/oXWq52MxC83lY+5UYxtqQ1gZlDpzeuE=;
  b=WXiLHXxPpcjcKamyp3nZ9+Dt2aqQrKivVwU+wjdTHu1/9QkrbCJVMl9U
   VTJ5tO4h45s4DefS3eDMLQuRNlz1kMHiUeRiOYVZ4p4a+p3aMIDdc4vOz
   gr2F2oYWAFI04eNuKUHYmmfG9rbpAZrdvHL+ox3RCQzJmzGvqn+DNQ9EN
   KmVaeZSv70Y4SkaL4QPlyBlNGwh65AH5VQPNpwB/5SPOcFMs82jiQpSQy
   WxkH2WI/9jz58x86ygwXGqxYTiTBfbrYq0zhq7BA5EGX4FIAqXtlrtcgx
   zCkTtt3RQqpd+uehH/bh8Re7zGJ1TfYcZR6TeSM1yVx01nx2Ua9+RsrXS
   A==;
X-CSE-ConnectionGUID: 0HTvxdh8ROKJSz81nYZfgw==
X-CSE-MsgGUID: EiWEMOmkRLiZhMLhHtFMUg==
X-IronPort-AV: E=Sophos;i="6.21,256,1763395200"; 
   d="scan'208";a="140205738"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2026 16:39:32 +0800
IronPort-SDR: 697879c5_biunx7bgDpyNkP+M0Rx+s8i42qDmDX5KgkH87+dFO2+n2ft
 I0UvKVr7ytGAt7zTnIiAicCBGalOBevPkea3zww==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2026 00:39:33 -0800
WDCIronportException: Internal
Received: from 5cg02580n2.ad.shared (HELO neo.wdc.com) ([10.224.28.78])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2026 00:39:31 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: virtualization@lists.linux.dev
Cc: Alexander Graf <graf@amazon.com>,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH RFC 1/3] virtio: silence KCSAN warning in virtqueue_kick_prepare
Date: Tue, 27 Jan 2026 09:39:24 +0100
Message-ID: <20260127083926.865555-2-johannes.thumshirn@wdc.com>
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
the following warning about a data-race in virtqueue_kick_prepare().

 ==================================================================
 BUG: KCSAN: data-race in virtqueue_kick_prepare+0x14d/0x200

 race at unknown origin, with read to 0xffff888101cd6d44 of 2 bytes by task 162 on cpu 0:
  virtqueue_kick_prepare+0x14d/0x200
  virtio_fs_enqueue_req+0x664/0x7d0
  virtio_fs_send_req+0xac/0x230
  __fuse_simple_request+0x1e1/0x580
  fuse_readlink_folio+0x1dc/0x2a0
  fuse_get_link+0xd6/0x190
  vfs_get_link+0x70/0x80
  ovl_get_link+0x4d/0x90
  pick_link+0x2c6/0x6a0
  step_into_slowpath+0x2ea/0x590
  path_openat+0x5bf/0x1b30
  do_filp_open+0x177/0x260
  do_sys_openat2+0x69/0xc0
  __x64_sys_openat+0x7a/0xc0
  x64_sys_call+0x10cf/0x1c30
  do_syscall_64+0x5d/0x240
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

 value changed: 0x0e63 -> 0x0e65

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 0 UID: 0 PID: 162 Comm: systemctl Not tainted 6.19.0-rc7+ #220 PREEMPT(none)
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
 ==================================================================

This warning is likely a false positive as the change happens on the
virtio vring.

Annotate the return of vring_avail_event() with data_race() to silence
the warning.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/virtio/virtio_ring.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index ddab68959671..5f8c8254bb6c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -736,9 +736,10 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 	LAST_ADD_TIME_INVALID(vq);
 
 	if (vq->event) {
-		needs_kick = vring_need_event(virtio16_to_cpu(_vq->vdev,
-					vring_avail_event(&vq->split.vring)),
-					      new, old);
+		needs_kick = vring_need_event(
+			virtio16_to_cpu(_vq->vdev, data_race(vring_avail_event(
+							   &vq->split.vring))),
+			new, old);
 	} else {
 		needs_kick = !(vq->split.vring.used->flags &
 					cpu_to_virtio16(_vq->vdev,
-- 
2.52.0

