Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0953EAC68
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776274845; cv=none; b=st+aeJgp18YphIiEeeZoU8OPQ4Mqxd9UeQn8DP7EHlLF1BfH1exlv2zy9Ow/QtCgvbiVw9CBrfdw000JmVeWksuclCe4QrPTPQFP/ORLls7vNhBxeejTftFE7nT8FqG+jefLRSt1UK4P4r3SN8O0dkKdjKU3uIq2J9cslavWHbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776274845; c=relaxed/simple;
	bh=/wzY0uR7XsAJFVFm2VHFAgX1e1WWVRZFNs7XSXLzWTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CObyNutqEHGm18tU7rPRIVwT0Kt4Xoy9sMITdb8P9JWUILqiRVonk3O4JiyMhbWHrUv5E1bhS+Ak7lY+RX/QYl3qPEuAYJzy4qzciUc0QudfaoxQ+bYKCEP9AiMu8AyN9sCuQXW8ZtLQgFjLBqJw9xgV7lh9VZvPdwwBQYdYOFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pIEjVVEU; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIEjVVEU"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35691a231a7so4534603a91.3
        for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 10:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776274843; x=1776879643; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s02OsJTTkDH9VQI7tIvBGr+0nakaQaimTmuWsyQJa9E=;
        b=pIEjVVEUgdwNOT4aU1BfYnKwjDxUMrvE0Of6RreTRA6d78LQpj/btXYwtIpJ4RIx91
         jxv+4yvXfJD259NtX1JcidQf9MoetI6CGo9ezxp/VkGrTrFFY0VwTqlGOfHIqq/AEbg/
         xr45IMdtSpzkgrGLPKHuU2mUMmJiZHXnrhANtooykC+e3/y2K/Zel7R+cXxFgQ/1uxFS
         aoTz+axj2PGvAnonRxo3Dsv6Cibf8nz37MPkx868XA74sSR8T33QRn23bBjKVgTjBVa1
         BBVs+ozDhKPH1aH7MPMi9gUt6cVUwoLLifI8XuP71WsoNSblXbpV7rXT0e4Go257aYGB
         KmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776274843; x=1776879643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s02OsJTTkDH9VQI7tIvBGr+0nakaQaimTmuWsyQJa9E=;
        b=kyPyAXri0gv48GvX8b/LSmVwha30xlCmPUNLd0y+RdSB8pUB3abAQsrTU/MTv1VWYC
         SWHt/rWDXnWpeqc9x4pRTYXwrsjcnafCZRPPZOhF8CWc62nmAFijr0kOTKFFp2eaiIQF
         k7/Oz3DjK5/7isTFH98Q+MwzgNAkoicSaRRjrQl9txt49tc09iyefHsJx02DDpsx6o5F
         1E/cSancqX6IWXk/g6y6aIwlVNjHVu2oGpz6U+QKOe/QEWeDDDt4zn4fk3KcbwORFQwI
         PoU9IkuIh3uM8NW+rOOOTgdcqP29PhGwGk1NZZdBzEwP5muGfJakqXAdzaVeMpXV+W/6
         8vwA==
X-Forwarded-Encrypted: i=1; AFNElJ+XaV8S/XT66tg++RixzdA3wd7IyfAdQzwBJW+lXUQb/ya1saND28/Coai3tt7oUYYyXJ3G7Of7/VKwpc1KxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEr4D8RKDVx7FCwGtHypXQaSr0GSC3B3fgcU4CsPBnQLhoFGeU
	nj6MZ+QDgSZ3VRhu6iUktfJD/fzNV29YdpX6kLV3F9vdy7zcqfq0F3y7
X-Gm-Gg: AeBDies8YFBhVwSREkb66UPjM2lrEApvGFGhyscQEaYO4a6CSY8VvPctAMXMeGNZKWD
	OQ6dh2NKwBwgjVqXRELZ0ZWmgz6/GXUfNCKWrBgFo1Eu3GnmzW8LvUofgm63lL18WWJxmrsH5Or
	q2FmVa+WYwmjOU8SzTgFA/+q+pUe3cedrUuMr9xCDcooI60TR4UnTSNk1fgCGfqRoo4L/HQiosg
	Ek46IFZZs1Raak6JrkHyBv5TfJPQesHXt712EkVOJsP9R+BRatvjoo1+cvCvBKNCywlx71RC590
	0ntThuux/qAD0H9oPoD4bSiHWSQK03Iy4sRMvlfwdPqyEd58azzPf2q8P6HMP3VmBjJDUTI7JUM
	fbrDfQ/O2UextK+d6ENKC7OSBqeyTEa/LRvRYLRRVMZUsljlsXhtPXmb6eIyMheERDgtiPOkBC+
	5HdxSAt9mJd00QUpY3/V3vp6ep0TNVTZuTBZxYbmkZ0CFDdr+jYoVBxvG9ALhYrFZ8rNA/KYJSM
	CJ4Tvx7b3qOm1jCBM0pyZ1Ku/rLBme1d78e/g==
X-Received: by 2002:a17:90b:4d0e:b0:35c:b02:b5c1 with SMTP id 98e67ed59e1d1-35e4254fa24mr22085159a91.2.1776274843412;
        Wed, 15 Apr 2026 10:40:43 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd1fe9b50sm2891026a91.3.2026.04.15.10.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 10:40:43 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v1 2/4] virtio_ring: export virtqueue_reinit_vring() for noirq restore
Date: Thu, 16 Apr 2026 02:38:31 +0900
Message-Id: <20260415173833.6319-3-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415173833.6319-1-baver.bae@gmail.com>
References: <20260415173833.6319-1-baver.bae@gmail.com>
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
 drivers/virtio/virtio_ring.c | 19 +++++++++++++++++++
 include/linux/virtio_ring.h  |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fbca7ce1c6bf..a57c625b5936 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3936,5 +3936,24 @@ void virtqueue_map_sync_single_range_for_device(const struct virtqueue *_vq,
 }
 EXPORT_SYMBOL_GPL(virtqueue_map_sync_single_range_for_device);
 
+/**
+ * virtqueue_reinit_vring - reinitialize vring state without reallocation
+ * @_vq: the virtqueue
+ *
+ * Reset the avail/used indices and descriptor state of an existing
+ * virtqueue so it can be reused after a device reset.  No memory is
+ * allocated or freed, making this safe for use in noirq context.
+ */
+void virtqueue_reinit_vring(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
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
2.34.1

