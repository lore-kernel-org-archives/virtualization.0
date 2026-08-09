Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F0F306B3D
	for <virtualization@lists.linux.dev>; Sun,  9 Aug 2026 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786299646; cv=none; b=mwSAXJ3FfOv+LtFIHxsRgjCM/slepwmlxR7NvXx3qsdsS634fGs6mYq23pp3XeCEIHM+Vy5rEOmF+3DnzlC20HotA5NfbWwbFuoetFI5ID0K+feZ3ZJPXkpp3S0qPd9lTbNvNfvEedu443hZ0ZbI6lIDDMBiA7ynoylBWTlnKJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786299646; c=relaxed/simple;
	bh=VQxsBCBv3cflFMsN0lZ7zQ5TL/y8JS8pQ3kpAcS9A80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrsK74E03Gj66EhqYqSuYXXfBK6BEXG92NorfZd1DC/kXJXCaVHhwpHnkDZov8JzvOz+pTSLfbGKfTKpB7dlJyG/M+JReuCAQeuHh9Ady8KCMZUdERZopmhZZ9Stt7T2hqxS/36voDveBvjsU3ENl2U1B9+UgsKgdw/+DVNtbps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=cITf8BgQ; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="cITf8BgQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1786299645; x=1817835645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c5qlgOuPfQrZFw2BxM5Ltl1DEUaFpcSxDb9rLnEjs6E=;
  b=cITf8BgQKvsGl9toh/R8M+0EalQX9OOmBrIaWKNuVn6Q7CwoASkokcUz
   mD90gfkvQTP67VuBZI90tbcdpVckOv1A0MP/GwWlFzyXDxruRs6BAJwXx
   zKranprRnc43o1OAbJRJvjRPby8ybnAXxkOSYCGbpE5V5lIUWflP2QSZv
   FLkotuXqLu7EvgCRdUA/Ncb3MTmUNegHkx0E9KMrOEWO3F38diMVU0RJ7
   PUmHCarIQm7+2BZPEB2qbJYKDQv3oCzQ6nBCUHjkowR+vO32pXhwpbt1H
   jHbwfn+ZLILo+kd8Ber5jOZ9bKUMYEokBuJYo4YhtoL+JjsKTbTA7Xq69
   Q==;
X-CSE-ConnectionGUID: 0pNN5iPJTCmBu/xl52gJ4Q==
X-CSE-MsgGUID: ztppbCuCT/2miS+w/ePxQA==
X-IronPort-AV: E=Sophos;i="6.25,214,1779148800"; 
   d="scan'208";a="25395390"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 18:20:45 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:9195]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.171:2525] with esmtp (Farcaster)
 id eb4c9b36-36ab-44c4-8e42-937775d9e01d; Sun, 9 Aug 2026 18:20:44 +0000 (UTC)
X-Farcaster-Flow-ID: eb4c9b36-36ab-44c4-8e42-937775d9e01d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 9 Aug 2026 18:20:44 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 9 Aug 2026 18:20:42 +0000
From: Alexander Graf <graf@amazon.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>, Stefan Hajnoczi
	<stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 04/12] virtio_pci: read the device memory buffer shared memory id
Date: Sun, 9 Aug 2026 18:20:02 +0000
Message-ID: <20260809182010.32931-5-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260809182010.32931-1-graf@amazon.com>
References: <20260809182010.32931-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

In preparation to support VIRTIO_F_DMB, read the shared memory id of
the Device Memory Buffer. A device that negotiates VIRTIO_F_DMB reports
it in a read-only le16 at the end of the common configuration
structure, and it names the VIRTIO_PCI_CAP_SHARED_MEMORY_CFG capability
that virtio_pci_find_shm_cap() has to find to map the region.

Add the dmb_shm_id field, VIRTIO_PCI_COMMON_DMB_SHM_ID for the offset
check_offsets() asserts it against, and vp_modern_get_dmb_shm_id() to
read the register. vp_modern_probe() capped the common cfg mapping at
the end of admin_queue_num, exactly where the new field starts, so
extend it to the end of dmb_shm_id. vp_modern_map_capability() takes
that as an upper bound, so a device with a shorter common cfg maps what
it has and mdev->common_len records how much.

The offset and VIRTIO_F_DMB are provisional until the virtio Technical
Committee allocates them.

Link: https://lore.kernel.org/virtio-comment/20260804161202.38619-1-graf@amazon.com/
Assisted-by: Kiro:claude-opus-5 checkpatch sparse
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 23 ++++++++++++++++++++++-
 include/linux/virtio_pci_modern.h      |  1 +
 include/uapi/linux/virtio_pci.h        | 10 ++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 413a8c353463..7fbfcb305a62 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -211,6 +211,8 @@ static inline void check_offsets(void)
 		     offsetof(struct virtio_pci_modern_common_cfg, admin_queue_index));
 	BUILD_BUG_ON(VIRTIO_PCI_COMMON_ADM_Q_NUM !=
 		     offsetof(struct virtio_pci_modern_common_cfg, admin_queue_num));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_DMB_SHM_ID !=
+		     offsetof(struct virtio_pci_modern_common_cfg, dmb_shm_id));
 }
 
 /*
@@ -300,7 +302,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 	mdev->common = vp_modern_map_capability(mdev, common,
 			      sizeof(struct virtio_pci_common_cfg), 4, 0,
 			      offsetofend(struct virtio_pci_modern_common_cfg,
-					  admin_queue_num),
+					  dmb_shm_id),
 			      &mdev->common_len, NULL);
 	if (!mdev->common)
 		goto err_map_common;
@@ -752,6 +754,25 @@ u16 vp_modern_avq_index(struct virtio_pci_modern_device *mdev)
 }
 EXPORT_SYMBOL_GPL(vp_modern_avq_index);
 
+/*
+ * vp_modern_get_dmb_shm_id - read the Device Memory Buffer shared memory id
+ * @mdev: the modern virtio-pci device
+ *
+ * The value identifies the VIRTIO_PCI_CAP_SHARED_MEMORY_CFG capability that
+ * describes the Device Memory Buffer region.  Only valid once VIRTIO_F_DMB
+ * has been negotiated.
+ *
+ * Returns the shared memory id.
+ */
+u16 vp_modern_get_dmb_shm_id(struct virtio_pci_modern_device *mdev)
+{
+	struct virtio_pci_modern_common_cfg __iomem *cfg;
+
+	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
+	return vp_ioread16(&cfg->dmb_shm_id);
+}
+EXPORT_SYMBOL_GPL(vp_modern_get_dmb_shm_id);
+
 MODULE_VERSION("0.1");
 MODULE_DESCRIPTION("Modern Virtio PCI Device");
 MODULE_AUTHOR("Jason Wang <jasowang@redhat.com>");
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index 9a3f2fc53bd6..c396f8e6055b 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -162,4 +162,5 @@ int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
 void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
 u16 vp_modern_avq_num(struct virtio_pci_modern_device *mdev);
 u16 vp_modern_avq_index(struct virtio_pci_modern_device *mdev);
+u16 vp_modern_get_dmb_shm_id(struct virtio_pci_modern_device *mdev);
 #endif
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index e732e3456e27..052a1047f48f 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -193,6 +193,15 @@ struct virtio_pci_modern_common_cfg {
 
 	__le16 admin_queue_index;	/* read-only */
 	__le16 admin_queue_num;		/* read-only */
+
+	/*
+	 * Reports the shmid of the Device Memory Buffer region.  The feature
+	 * is a specification proposal before the virtio Technical Committee,
+	 * and both this offset and the VIRTIO_F_DMB feature bit are
+	 * provisional: neither has been allocated, so a device must not rely
+	 * on either until they have been.
+	 */
+	__le16 dmb_shm_id;		/* read-only */
 };
 
 /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
@@ -235,6 +244,7 @@ struct virtio_pci_cfg_cap {
 #define VIRTIO_PCI_COMMON_Q_RESET	58
 #define VIRTIO_PCI_COMMON_ADM_Q_IDX	60
 #define VIRTIO_PCI_COMMON_ADM_Q_NUM	62
+#define VIRTIO_PCI_COMMON_DMB_SHM_ID	64
 
 #endif /* VIRTIO_PCI_NO_MODERN */
 
