Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD6F5B21A
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787087728; cv=none; b=YR5jFbrzN2h5y+NjQgy9b+hzLw4/kpEsEN9koeiNmRL8QJA2sQEYHlY+NGcKvoAc1sJxmj7b1DhaoQIuFmEsSjhybJYS91ztFyVkcPe01WZhAn0k0ZESEDJ42zwyOgwn+g87ZR2+39pgb8wRzJ7TNfGxVeDcplb2Md3mOZaLQuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787087728; c=relaxed/simple;
	bh=ME/0o6kfndA27xeOa9Rly56fuAGjJJUKUBewc7PUJSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i8++y4Jf62exEYUwc+JkLfN2PXgCg8xgXzZVtDcqOrSIU3KVD1TpymMLLNvlK7m/Y4Y48QyFMWLIX4x+eBozYuqqwMB4unlXVxWpQNUVMamOOvjIKs/zBIhMZoPAOct2098iopspbkiw+WXpihAXvbZg3wMF0F1EEORjAV4MNF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=NjZYOfRV; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="NjZYOfRV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1787087726; x=1818623726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hiQF436GCtIot5DFBjg2hcb/c9AhcFAYJYigKmu2aD8=;
  b=NjZYOfRVAA7ctBSpeW28wPxTn/UpyEi27CS8ehMnPwn7O2SDc+BQW/lj
   WqHqCTF5/halwHZvc7BeH2lWu5JyHP63g292Opk3oUBvuzJNiLkQ8gda4
   MUFlw/Vler2B1YM/fTTwLrUI10AwgfsFz07OI86pTrEAnTJFIq6qMGB2J
   KBe+fV6RpB1h9kHJih/6tLZiGXntDJ/rz62eyWrlzPBVU81uxyrKh/MmO
   lW7y/f0S7ygohzzj5ETMgnohjUC8/o5S+ggNapb1sJKbuu/7u3N5mfDRh
   Ptqnx/jxRrHgG9JKCnMKdIdhSkcKLFc9WPFBKKTSL17tULlTcaSjdoe0S
   w==;
X-CSE-ConnectionGUID: kZr9iVmKTMi+HcaL3xx0ow==
X-CSE-MsgGUID: QfVEE/zeRPOztgE+l1PqZA==
X-IronPort-AV: E=Sophos;i="6.25,230,1779148800"; 
   d="scan'208";a="26342991"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 21:15:26 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:14749]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.125:2525] with esmtp (Farcaster)
 id d26ab853-c829-49a4-a83e-bdd8c00e847e; Tue, 18 Aug 2026 21:15:26 +0000 (UTC)
X-Farcaster-Flow-ID: d26ab853-c829-49a4-a83e-bdd8c00e847e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 18 Aug 2026 21:15:25 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 18 Aug 2026 21:15:24 +0000
From: Alexander Graf <graf@amazon.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
CC: <nh-open-source@amazon.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Stefan
 Hajnoczi" <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 06/12] virtio_pci: read the device memory buffer registers
Date: Tue, 18 Aug 2026 21:14:19 +0000
Message-ID: <20260818211425.91009-7-graf@amazon.com>
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
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

In preparation to support VIRTIO_F_DMB, read the two registers a device
uses to describe its Device Memory Buffer. Both are read-only le16
fields at the end of the common configuration structure. dmb_shm_id
names the VIRTIO_PCI_CAP_SHARED_MEMORY_CFG capability that
virtio_pci_find_shm_cap() has to find to map the region, and is valid
once the feature is negotiated. dmb_mem_type describes the memory the
region is made of: VIRTIO_DMB_MEM_TYPE_COHERENT means a write by either
side becomes visible to the other with no cache maintenance by the
driver. It is valid as soon as the device offers the feature, so a
driver that does not support the value it reads can decline the offer
instead of failing the device afterwards.

Add both fields, VIRTIO_PCI_COMMON_DMB_SHM_ID and
VIRTIO_PCI_COMMON_DMB_MEM_TYPE for the offsets check_offsets() asserts
them against, and vp_modern_get_dmb_shm_id() and
vp_modern_get_dmb_mem_type() to read them. vp_modern_probe() capped the
common cfg mapping at the end of admin_queue_num, exactly where
dmb_shm_id starts, so extend it to the end of dmb_mem_type.
vp_modern_map_capability() takes that as an upper bound, so a device with
a shorter common cfg maps what it has and mdev->common_len records how
much.

Link: https://lore.kernel.org/virtio-comment/20260818060255.6853-1-graf@amazon.com/
Assisted-by: Kiro:claude-opus-5 checkpatch sparse
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 47 +++++++++++++++++++++++++-
 include/linux/virtio_pci_modern.h      |  2 ++
 include/uapi/linux/virtio_pci.h        | 19 +++++++++++
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 413a8c353463..270c67fe58ff 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -211,6 +211,10 @@ static inline void check_offsets(void)
 		     offsetof(struct virtio_pci_modern_common_cfg, admin_queue_index));
 	BUILD_BUG_ON(VIRTIO_PCI_COMMON_ADM_Q_NUM !=
 		     offsetof(struct virtio_pci_modern_common_cfg, admin_queue_num));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_DMB_SHM_ID !=
+		     offsetof(struct virtio_pci_modern_common_cfg, dmb_shm_id));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_DMB_MEM_TYPE !=
+		     offsetof(struct virtio_pci_modern_common_cfg, dmb_mem_type));
 }
 
 /*
@@ -300,7 +304,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 	mdev->common = vp_modern_map_capability(mdev, common,
 			      sizeof(struct virtio_pci_common_cfg), 4, 0,
 			      offsetofend(struct virtio_pci_modern_common_cfg,
-					  admin_queue_num),
+					  dmb_mem_type),
 			      &mdev->common_len, NULL);
 	if (!mdev->common)
 		goto err_map_common;
@@ -752,6 +756,47 @@ u16 vp_modern_avq_index(struct virtio_pci_modern_device *mdev)
 }
 EXPORT_SYMBOL_GPL(vp_modern_avq_index);
 
+/*
+ * vp_modern_get_dmb_shm_id - read the Device Memory Buffer shared memory id
+ * @mdev: the modern virtio-pci device
+ *
+ * The value identifies the VIRTIO_PCI_CAP_SHARED_MEMORY_CFG capability that
+ * describes the Device Memory Buffer region.  Only valid once VIRTIO_F_DMB
+ * has been negotiated, and the caller has to have established that the common
+ * configuration structure is long enough to hold the field.
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
+/*
+ * vp_modern_get_dmb_mem_type - read the Device Memory Buffer memory type
+ * @mdev: the modern virtio-pci device
+ *
+ * The value describes the memory the Device Memory Buffer region is made of.
+ * VIRTIO_DMB_MEM_TYPE_COHERENT means the region is cache coherent.  Valid
+ * whenever the device offers VIRTIO_F_DMB, and the caller has to have
+ * established that the common configuration structure is long enough to hold
+ * the field.
+ *
+ * Returns the memory type.
+ */
+u16 vp_modern_get_dmb_mem_type(struct virtio_pci_modern_device *mdev)
+{
+	struct virtio_pci_modern_common_cfg __iomem *cfg;
+
+	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
+	return vp_ioread16(&cfg->dmb_mem_type);
+}
+EXPORT_SYMBOL_GPL(vp_modern_get_dmb_mem_type);
+
 MODULE_VERSION("0.1");
 MODULE_DESCRIPTION("Modern Virtio PCI Device");
 MODULE_AUTHOR("Jason Wang <jasowang@redhat.com>");
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index 9a3f2fc53bd6..80643c895495 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -162,4 +162,6 @@ int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
 void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
 u16 vp_modern_avq_num(struct virtio_pci_modern_device *mdev);
 u16 vp_modern_avq_index(struct virtio_pci_modern_device *mdev);
+u16 vp_modern_get_dmb_shm_id(struct virtio_pci_modern_device *mdev);
+u16 vp_modern_get_dmb_mem_type(struct virtio_pci_modern_device *mdev);
 #endif
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index e732e3456e27..1bd2bb981dc9 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -193,6 +193,23 @@ struct virtio_pci_modern_common_cfg {
 
 	__le16 admin_queue_index;	/* read-only */
 	__le16 admin_queue_num;		/* read-only */
+
+	/*
+	 * Reports the shmid of the Device Memory Buffer region.  Valid once
+	 * VIRTIO_F_DMB has been negotiated.
+	 */
+	__le16 dmb_shm_id;		/* read-only */
+
+	/*
+	 * Reports the memory type of the Device Memory Buffer region.
+	 * VIRTIO_DMB_MEM_TYPE_COHERENT means the region is cache coherent: a
+	 * write by either side becomes visible to the other with no cache
+	 * maintenance by the driver.  Every other value is reserved, and a
+	 * driver must not accept VIRTIO_F_DMB unless the value is one it
+	 * supports.  Valid whenever the device offers VIRTIO_F_DMB, so that a
+	 * driver can read it before it accepts.
+	 */
+	__le16 dmb_mem_type;		/* read-only */
 };
 
 /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
@@ -235,6 +252,8 @@ struct virtio_pci_cfg_cap {
 #define VIRTIO_PCI_COMMON_Q_RESET	58
 #define VIRTIO_PCI_COMMON_ADM_Q_IDX	60
 #define VIRTIO_PCI_COMMON_ADM_Q_NUM	62
+#define VIRTIO_PCI_COMMON_DMB_SHM_ID	64
+#define VIRTIO_PCI_COMMON_DMB_MEM_TYPE	66
 
 #endif /* VIRTIO_PCI_NO_MODERN */
 
