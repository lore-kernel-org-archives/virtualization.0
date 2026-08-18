Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A677237BE86
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 21:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787087710; cv=none; b=lO+RoRsBRXAh7oxoLz5KwoXr/ZRnHR6AfAPI1DXc5KVBcBDZszMh6M3RxX2HG+Mz/0GYykCKssQajdOsbMjxOBlzQz/L5ZM6O3HBemTrqKzM2ya87d5T0p1GH7ZlV27ZTPud3OPxK8MHtUxPqPmFRdniYoSgcYeb/8p7xYRf2U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787087710; c=relaxed/simple;
	bh=cKXYNudEb054REsSvwpzPBuTIQStBcbUDNbgNSMgiQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqJ5v5qSXF5+eEVGDyO0itEYCXkes7FRkTpiU9JLnIMi9TjMh9/aHgf++vDfNMqMQ7/eIeCIUdLlqws3nsr7XsRYZza22aGkM4Vl171y8LSESQ71seeCM17dr1wqfnzhum921fuZmAcFfp08HrxJUbr+bD8OgSQidmlzf+nYOyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=OKd4WL0S; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="OKd4WL0S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1787087705; x=1818623705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B5ptABUTxopofhvaFxrmGngjiBMHjwSHnlfrc5bfAck=;
  b=OKd4WL0S4d74PJB5YoOneNpg+Y2spj2gKIG6L4uIj48FGLuzJeak8q8A
   dS8Gh0DGQINtrsPodjNmdK0QrnJcYVgvYI5cYbODI05nJLXF764YHP85s
   2NW6TCo7IR7+Nvu059xsT9XDrha9Vn9cGifMow3Ye2PZZJ7WeUMhKsHuU
   Hc0B0Xs6NyNsnoLXvHtix/9JFklxIEqzudBYZDceLon21X5MT+vt+8DK2
   Q+r0Bvves7U1RHfhbOksvlSO7Sa9CcEicfEbTtvvu9P7DW2VRslAUvc1h
   +ZjWJKOmBOs8sth36pwrcuHkP7PQEGDLEvEkbvgE0wNXVC/ukcL9x7LiG
   w==;
X-CSE-ConnectionGUID: jc4FDRXvRKuSUQvDnwZRYQ==
X-CSE-MsgGUID: tYsSmpwKSTeevVU8unrQXQ==
X-IronPort-AV: E=Sophos;i="6.25,230,1779148800"; 
   d="scan'208";a="26342968"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 21:15:03 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:18479]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.46:2525] with esmtp (Farcaster)
 id 30cc3ea7-b828-492a-8ea7-ea4ed5f5b7ab; Tue, 18 Aug 2026 21:15:02 +0000 (UTC)
X-Farcaster-Flow-ID: 30cc3ea7-b828-492a-8ea7-ea4ed5f5b7ab
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 18 Aug 2026 21:15:02 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 18 Aug 2026 21:15:00 +0000
From: Alexander Graf <graf@amazon.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
CC: <nh-open-source@amazon.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Stefan
 Hajnoczi" <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 05/12] virtio: add the VIRTIO_F_DMB feature bit
Date: Tue, 18 Aug 2026 21:14:18 +0000
Message-ID: <20260818211425.91009-6-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260818211425.91009-1-graf@amazon.com>
References: <20260818211425.91009-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

In preparation to support VIRTIO_F_DMB, define the feature bit. A device
that negotiates it holds its virtqueues and the buffers they reference in
a Device Memory Buffer, a shared memory region the device owns. The data
DMA of such a device is routed through a per-device transparent IOMMU
whose bus address space maps 1:1 onto that region, so every address the
driver places in a virtqueue is an address in that space and the device
can reach nothing the driver has not published there.

Define VIRTIO_F_DMB as 44 and raise VIRTIO_TRANSPORT_F_END to 45, so
virtio_dev_probe() preserves the bit into finalize_features() where a
transport can act on it. VIRTIO_DEVICE_F_MASK derives from the same bound
and moves with it. vdpa reads the bound as VIRTIO_TRANSPORT_F_END + 1
while vring_transport_features() stops below it, so the mask drops bits
43 to 45 from the device_features vdpa reports over netlink, one bit
beyond the last bit a transport can act on.

Define VIRTIO_DMB_MEM_TYPE_COHERENT too. A device reports the memory
type of its region, and this is the one type that says a write by either
side becomes visible to the other with no cache maintenance by the
driver. Every transport reports the same type, so the name belongs here
beside the feature bit and not in the header of one of them.

Link: https://lore.kernel.org/virtio-comment/20260818060255.6853-1-graf@amazon.com/
Assisted-by: Kiro:claude-opus-5 checkpatch sparse
Signed-off-by: Alexander Graf <graf@amazon.com>
---

  - Say bus address space rather than IOVA space

---
 include/uapi/linux/virtio_config.h | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 2445f365bce7..8cfd9436a09e 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -52,7 +52,7 @@
  * rest are per-device feature bits.
  */
 #define VIRTIO_TRANSPORT_F_START	28
-#define VIRTIO_TRANSPORT_F_END		42
+#define VIRTIO_TRANSPORT_F_END		45
 
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
@@ -120,4 +120,26 @@
  */
 #define VIRTIO_F_ADMIN_VQ		41
 
+/*
+ * This feature indicates that the device offers a Device Memory Buffer: a
+ * shared memory region, owned by the device, that holds the virtqueues and
+ * the buffers they reference.  When this feature is negotiated, the data DMA
+ * of the device is routed through a per-device transparent IOMMU whose bus
+ * address space maps 1:1 onto that region, so every address the driver
+ * places in a virtqueue is an address in that space and the device can
+ * reach nothing the driver has not published there.  Interrupts are
+ * unaffected.
+ */
+#define VIRTIO_F_DMB			44
+
+/*
+ * The memory type of a Device Memory Buffer region, as the device reports it.
+ * VIRTIO_DMB_MEM_TYPE_COHERENT means a write by either side becomes visible to
+ * the other with no cache maintenance by the driver.  Every other value is
+ * reserved.  A device reports the type from the moment it offers
+ * VIRTIO_F_DMB, and a driver must not accept the feature unless the type is
+ * one it supports.
+ */
+#define VIRTIO_DMB_MEM_TYPE_COHERENT	0
+
 #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
