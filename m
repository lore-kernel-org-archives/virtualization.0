Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451713F9FB
	for <virtualization@lists.linux.dev>; Wed, 22 Apr 2026 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863467; cv=none; b=rTygIZ6dE0IFBBZhr+AsFO6ybfQTxVNlua/vRX8IKwFg+PIWzeIrAtrY1yBgDUC17BpQ7pr0oZrT5bRLGf3YWVo43RIZZwPK1KWLUnk9kTMQ6QoIGdMVh/c030Xf5YttwXfdM8Fx8cTb3erDFVzwptJq7jmBJv+EiYCMQDItRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863467; c=relaxed/simple;
	bh=6dX0PzOsvQzuVsAQ1OLovx2RSIPr5HJX+ZoCwBnrXJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oxXiMM5GIbsc53fhqqX7Kyq7EY5K7TG0KPtxzVeVaqFTVlkENVwn+6n4orQ32NQj6CklAo6mOktHEjt2Qo2atZ8C4e1WkYYQsChf8ftMwAb9TsIxEo3dO/Vi3o/gE1RfEvDfscYuzjeQiuc9Qp4kNvGPabF9ccxSE/LwBuT73+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxnZF8Vm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxnZF8Vm"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aae4816912so34377695ad.2
        for <virtualization@lists.linux.dev>; Wed, 22 Apr 2026 06:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776863464; x=1777468264; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opyqOEmxu5ONdPehlI5jbPlGmvm0e7vGWmLDp5P5SYs=;
        b=GxnZF8VmblnfS6c5mvPvWUJ39FODF2pF5eQIMgKDG8Et8Msb7I2xaKOwpe2ZUZv5Xu
         UriYCCOkVfkdiehaO7ykKkQKQIRvcxj1G3ikcXpPYtPaGxmapBlH4VrxVOzE7sE8ubEf
         hWe93kdC9lwifo55nr9QoUjBHKhVjZH9wxKNjgGoXVpPiOu4xgqE5Zv9ZplQuyHBo0Oe
         BkioQQ2+nM8O+TdPSffA9cEGQ/PhMnxI8f80EADh8T8OmscZN+HYPle0NYUixFbEZcE1
         TsZHJ2/ZBk8ZDx6TTIK+SwRpEe0Jd57Bz3YTS75noNIeLsAlUpVWQMg0Jsqyp3hCSC+X
         16Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776863464; x=1777468264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=opyqOEmxu5ONdPehlI5jbPlGmvm0e7vGWmLDp5P5SYs=;
        b=LfZFvECarZaAmF8KmbOMXVkMkngcS91ePHhnfcGJx0a0Ay2IScMWxvcoyD9MYN59H5
         aza+jfAKefheKlxeuODbLnhx7o5pVO4ArGqpDLuQWmOPLkSCjlV9x4ytFndBKeWwiney
         eIqzo9ktNGvFtxxz7zTiD3ZgHq7meLlGWoB5dNzQYX5aKSe4sspXoTyT0IgoD1cvJvCc
         1IL39gy9QllERHCGy+4IPJDUbaVzUkr/Tpf0jCV2/EsBtEHcw2KSEXo2wdqithif2vt1
         26qrH3RpORAtNlXctS1aGHqmHNeMvVG20n91UCSeIzm9rRyzXuPVV6Zq7ZJ4gGc98FfK
         G02g==
X-Forwarded-Encrypted: i=1; AFNElJ/uNhFG0X0KU2JIxWR2tCPS9LwLw3hDhHqgltApUyMTo6aX3TJODqNmgr8x/b07FIVErUGsLND34pnmn18ECw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy453S8G/6bYXfgFI9DSDU/OnQeGpkLzRet00HB17PjcCLrZLZn
	wW3lkZt0LUaWCN7+AZ3YnhO3Z/N3oJ8lmJAdhtrsSmS2CcaPjsyb2aOk
X-Gm-Gg: AeBDieuef2g+84ccifsiE0H2WiD6w2J1FlLli3IQ7/4xzHKAEjOjItrhxs1xhAS3KRk
	XOVzStCJC6qEC63HvJ1SrbebBjFzqcHrUtOuxtgN1vPhtJheONorAfQeHkJyngULbiYMf+Ce2dN
	wwBw4dSsQgKEKR99TcmHIeQePfqvQnxnINlqShFxs2IfU/EBRhAIONPVcFjvZnsng6y/IhX6A/C
	Ph04pTiMU6w0pxpV6JJcXi3EC0p6mAzMUebP1vdy3DiRBWZEzTvjKd0NMzNV1OFiwwkys/X99VM
	jURMyZmSy6zLFcSYm1AVO41heip2k7oUSspWa2aWZqzZ7V3zcP4ib3R3XGeJ7oJwiDcP6hJIgvQ
	s/ORbbk0a+IEdICVY2BfyGxW4AOB3MBy5RkY74Q0nKUD1k9lCTMdnC6vnBXa4YxdkYvT+0X9tZi
	ENm78yGIoqbT1yql2b5JzJW253SDEZAJ3dxeEBYvnAKJH8vzBVRbESFU+K8dfgIbvsh1kCUSR2i
	bdX7pAxBUW8vjQlQGv4cUqvowWwG6soX5FzlVlkHswtAqp2
X-Received: by 2002:a17:903:11d0:b0:2b2:ec00:7966 with SMTP id d9443c01a7336-2b5f9f1ab06mr250725425ad.21.1776863462787;
        Wed, 22 Apr 2026 06:11:02 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b606ce9891sm127892235ad.83.2026.04.22.06.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:11:02 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v3 2/4] virtio_ring: export virtqueue_reinit_vring() for noirq restore
Date: Wed, 22 Apr 2026 22:10:12 +0900
Message-Id: <20260422131014.956-3-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260422131014.956-1-baver.bae@gmail.com>
References: <20260422131014.956-1-baver.bae@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sungho Bae <baver.bae@lge.com>

After a device reset in noirq context the existing vrings must be
re-initialized without any memory allocation, because GFP_KERNEL is
not available.

The internal helpers virtqueue_reset_split() and
virtqueue_reset_packed() already reset vring indices and descriptor
state in place.  Add a thin exported wrapper, virtqueue_reinit_vring(),
that dispatches to the appropriate helper based on the ring layout.

This will be used by a subsequent patch that adds noirq system-sleep
PM callbacks for virtio-mmio.

Signed-off-by: Sungho Bae <baver.bae@lge.com>
---
 drivers/virtio/virtio_ring.c | 30 ++++++++++++++++++++++++++++++
 include/linux/virtio_ring.h  |  3 +++
 2 files changed, 33 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fbca7ce1c6bf..528157b1211d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3936,5 +3936,35 @@ void virtqueue_map_sync_single_range_for_device(const struct virtqueue *_vq,
 }
 EXPORT_SYMBOL_GPL(virtqueue_map_sync_single_range_for_device);
 
+/**
+ * virtqueue_reinit_vring - reinitialize vring state without reallocation
+ * @_vq: the virtqueue
+ *
+ * Reset the avail/used indices and descriptor state of an existing
+ * virtqueue so it can be reused after a device reset.  No memory is
+ * allocated or freed, making this safe for use in noirq context.
+ *
+ * The caller must ensure that all in-flight buffers have been completed
+ * or detached before invoking this function.  Calling it with outstanding
+ * descriptors will corrupt the free-list state because num_free is
+ * unconditionally restored to the ring's maximum capacity while the
+ * desc_extra next-chain and free_head reflect only the partial free list
+ * that existed at reset time.
+ */
+void virtqueue_reinit_vring(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	unsigned int num = virtqueue_is_packed(vq) ?
+		vq->packed.vring.num : vq->split.vring.num;
+
+	WARN_ON(vq->vq.num_free != num);
+
+	if (virtqueue_is_packed(vq))
+		virtqueue_reset_packed(vq);
+	else
+		virtqueue_reset_split(vq);
+}
+EXPORT_SYMBOL_GPL(virtqueue_reinit_vring);
+
 MODULE_DESCRIPTION("Virtio ring implementation");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index c97a12c1cda3..26c7c9d0a151 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -118,6 +118,9 @@ void vring_del_virtqueue(struct virtqueue *vq);
 /* Filter out transport-specific feature bits. */
 void vring_transport_features(struct virtio_device *vdev);
 
+/* Reinitialize a virtqueue without reallocation (safe in noirq context) */
+void virtqueue_reinit_vring(struct virtqueue *_vq);
+
 irqreturn_t vring_interrupt(int irq, void *_vq);
 
 u32 vring_notification_data(struct virtqueue *_vq);
-- 
2.43.0

