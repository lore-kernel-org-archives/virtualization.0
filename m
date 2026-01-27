Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE6A35DCEC
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527543; cv=none; b=lFgLX+U66T2f1fLt1hszLy3aJwx4KPSMpdEGkDcoV5zCMWuPto6ohbcjy8JpzrroQ+2S5vDcoIbF6rZOMSHipiKYxDE9+C9mOSpMkdAnIuc6NuSYPaBPnpsQdZ7gRT2FAR3WS+qBBRMKluSfgi9BmVh2+mnBB4HMnZv2WtMhVnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527543; c=relaxed/simple;
	bh=9uEzUxnWE0fjOIf4/MbMNvLVAiSLEPN7pE/dx7Q66Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ab3EAcrCht9zYZkYFfOBQiMlGnhoJTQSvtvV8scKV4NsgXUNJ/NWQFu3LjckLWIF2yeLkRsyILSKGUJhiBRajdhGS+y7R0I6CkrjG0qTczIT7AakijtkDEmhmuIO+YGznpue276NTrN6IOsc34aTf9IYMhSj8l6QYOYwcy1lgWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gbXF5hSi; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gbXF5hSi"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769527541; x=1801063541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9uEzUxnWE0fjOIf4/MbMNvLVAiSLEPN7pE/dx7Q66Uc=;
  b=gbXF5hSilz/4Kc6TEmGGf/fxy2NvHghZVJj3mzGrmq92U+u0mqbNmN3a
   KmnCfC1qN3IHJ0e2+rnjF2ZnfbDleZh7UhrzJPQBpw1oWpG8HkGw7niRI
   8R7+C+d9/TZOCYV3il5soteW3v3Fv8CCuEyOyKdeM0MVE98uyoW1yMOyt
   //iuU6KLhCenKIWU8nxfQX/NdkbaPS3xSFF72gxwiY5mkgDBSb3H7WkpJ
   s08LUUX8QKVAZ+wr0B28uCHbfiR1+6msJ3gVzSqfBEYqCZdKesgiqVWfc
   NfoeGltA8/Us+ZjrPlVGJWt2uppdx1uPUHdxbJDbzDy+/b5jusxjwyCg3
   A==;
X-CSE-ConnectionGUID: mDeRNMlkQCi+pRBOMKBLsg==
X-CSE-MsgGUID: B/5V4aDRSU2woH8QRA/Xpw==
X-IronPort-AV: E=Sophos;i="6.21,257,1763395200"; 
   d="scan'208";a="139288700"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2026 23:25:38 +0800
IronPort-SDR: 6978d8f2_CGFvofBTK4mc2Kw1J2vTmDbwrgIZOEMYDF9EPwc9XbWfnS9
 X6lbMNEWQiRIeri1hmut698NWpfU7iD5pZTTTuw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2026 07:25:39 -0800
WDCIronportException: Internal
Received: from wdap-nm5iivsczy.ad.shared (HELO neo.fritz.box) ([10.224.28.83])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2026 07:25:36 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/2] virtio: silence KCSAN warning in virtqueue_kick_prepare
Date: Tue, 27 Jan 2026 16:25:23 +0100
Message-ID: <20260127152524.200465-3-johannes.thumshirn@wdc.com>
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
the following warning about a data-race in virtqueue_kick_prepare().

 ==================================================================
 BUG: KCSAN: data-race in virtqueue_kick_prepare+0x14d/0x200

 race at unknown origin, with read to 0xffff888101c9cd44 of 2 bytes by task 224 on cpu 2:
  virtqueue_kick_prepare+0x14d/0x200
  virtio_fs_enqueue_req+0x664/0x7d0
  virtio_fs_send_req+0xac/0x230
  flush_bg_queue+0x1a8/0x1f0
  fuse_simple_background+0x312/0x490
  fuse_file_put+0xcf/0x190
  fuse_file_release+0xd3/0xf0
  fuse_release+0x91/0xb0
  __fput+0x200/0x4f0
  ____fput+0x15/0x20
  task_work_run+0xda/0x140
  do_exit+0x414/0x11a0
  do_group_exit+0x53/0xf0
  __x64_sys_exit_group+0x25/0x30
  x64_sys_call+0x1c23/0x1c30
  do_syscall_64+0x5d/0x240
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

 value changed: 0x1ab0 -> 0x1ab3

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 2 UID: 0 PID: 224 Comm: grepconf.sh Not tainted 6.19.0-rc7+ #230 PREEMPT(none)
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
 ==================================================================

 This warning is likely a false positive as the change happens on the
 virtio vring.

 Annotate the return of vring_avail_event() with data_race() to silence
 the warning.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/uapi/linux/virtio_ring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index f8c20d3de8da..32568cfa1c63 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -194,7 +194,7 @@ struct vring {
 /* We publish the used event index at the end of the available ring, and vice
  * versa. They are at the end for backwards compatibility. */
 #define vring_used_event(vr) ((vr)->avail->ring[(vr)->num])
-#define vring_avail_event(vr) (*(__virtio16 *)&(vr)->used->ring[(vr)->num])
+#define vring_avail_event(vr) (data_race(*(__virtio16 *)&(vr)->used->ring[(vr)->num]))
 
 static inline void vring_init(struct vring *vr, unsigned int num, void *p,
 			      unsigned long align)
-- 
2.52.0

