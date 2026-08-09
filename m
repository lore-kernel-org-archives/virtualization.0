Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD09436A009
	for <virtualization@lists.linux.dev>; Sun,  9 Aug 2026 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786299677; cv=none; b=SPToOKKqiPkhaq6OIVnmVQ//F1mLLrdXMA0KLsmjVMBaaP4+hBWyfEY1og0FYlxAi/I9lsai3iL+e0pATxm3UrIpW7s2vTrJwc+5N3jhNyDZfmMC6J5yFSSianRuoeRFFCROAN2qobYOl7GYH/3mpk9Ezd/50Cdf2yC5k4ecMm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786299677; c=relaxed/simple;
	bh=M9pTWXVyco0cyJDI0/8rpL6FKpSOxS9abIbnWnICVuY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frmveFUa5AfdAobPttgL22hY9qMcjmzbWFOtzJCBtfnUBRV8n/XenY7aGqvcPpozTX1JsE7fIjQVtKt1E2wcayBmZmuXp8fSoUeFSCgVTfi7IlGVdogx6YmB9y/FyTfeWVxlEr74MYuvKQtiZMpyohRfFfaZYwL5SoxrDWth5Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=txafXlwk; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="txafXlwk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1786299675; x=1817835675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TZ+BlLRrqjruaH4UmOKdQsXVbVROnHD2B9q6LIv1REc=;
  b=txafXlwki9k/S9lxV6Pqanm2plrEepDvAUcfSFAR8EEgv10JeAUzTSFp
   00pkaTAe0M21SyHge2ktyhOlA2PRc+BW4cYriUnsld4DhwtqOjU/py9qt
   9giq6owdHlB4x6IaP28lqfxTHzv49GhtDTBPrZBhMKVQrPIp3+t799ezx
   5Q7x6iJZ9aDakf815sQHeW4bVodAEmISQoND9iXTRd0lsCuoyEXK5TMNJ
   0eUz2ht59eI2ZYVErewa/FTEtulgDrdNXQ0KDsBAtpxMaR5QhQqU+mA3+
   JqmK//pM8Yzq17SqRlS4GolRTLQmqJB7/2OPs5JsNm/JkMk+7EKxlab/3
   g==;
X-CSE-ConnectionGUID: TnbV6CP9TsulSH/X73M7EA==
X-CSE-MsgGUID: 5SEToIxtSBiMT0U9Xrkxjg==
X-IronPort-AV: E=Sophos;i="6.25,214,1779148800"; 
   d="scan'208";a="25498741"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 18:21:13 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:5771]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.134:2525] with esmtp (Farcaster)
 id 54e962e6-146d-4c73-80ea-8517520215c4; Sun, 9 Aug 2026 18:21:13 +0000 (UTC)
X-Farcaster-Flow-ID: 54e962e6-146d-4c73-80ea-8517520215c4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 9 Aug 2026 18:21:13 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 9 Aug 2026 18:21:11 +0000
From: Alexander Graf <graf@amazon.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>, Stefan Hajnoczi
	<stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 08/12] virtio_pci: support VIRTIO_F_DMB
Date: Sun, 9 Aug 2026 18:20:06 +0000
Message-ID: <20260809182010.32931-9-graf@amazon.com>
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
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Let a modern virtio-pci device place its virtqueues and the buffers they
reference in a Device Memory Buffer of its own: accept VIRTIO_F_DMB from
vp_transport_features(), and implement the get_dmb_shm_id config op on
top of vp_modern_get_dmb_shm_id().

Refuse a device whose common configuration is too short to hold
dmb_shm_id, which would put that read outside what vp_modern_probe()
mapped. The accept commits before the id can be read, so a region we
fail to locate afterwards fails virtio_features_ok() and probe sets the
FAILED status bit.

Four conditions gate the accept:

  1) VIRTIO_F_ACCESS_PLATFORM, because the feature is only defined
     together with it.
  2) VIRTIO_F_ORDER_PLATFORM where the device offers it. Without it
     the ring emits the weaker barriers that assume the device sees
     memory the way another CPU does, and a region that is not
     ordinary host memory breaks that assumption.
  3) CONFIG_VIRTIO_DMB, so a device offering the feature to a kernel
     built without it is driven as an ordinary device.
  4) VIRTIO_F_VERSION_1, because virtio_features_ok() returns early
     without it, which would leave the feature negotiated and the
     region never built. This transport refuses such a device anyway.

vp_dmb_ordering_ok() asks the device with vp_modern_get_features()
instead of reading the feature word vp_transport_features() is handed.
That word holds what the driver accepts, so a device offering
VIRTIO_F_ORDER_PLATFORM to a driver that declined it would read there as
a device that never offered it.

Link: https://lore.kernel.org/virtio-comment/20260804161202.38619-1-graf@amazon.com/
Assisted-by: Kiro:claude-opus-5 checkpatch sparse
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virtio/virtio_pci_modern.c | 65 ++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 565d37b630b3..c43c1fc6e843 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -364,6 +364,36 @@ static void vp_modern_avq_cleanup(struct virtio_device *vdev)
 	}
 }
 
+/*
+ * The proposal makes accepting VIRTIO_F_DMB conditional on accepting
+ * VIRTIO_F_ORDER_PLATFORM where the device offers it.  Without it the barriers
+ * the ring emits order accesses only as seen by a device that can be assumed
+ * to run on identical CPUs in an SMP configuration, which a device whose
+ * region is not ordinary host memory is not.  Accepting
+ * VIRTIO_F_ORDER_PLATFORM is otherwise only a SHOULD, so nothing else couples
+ * the two.
+ *
+ * The offer is read back from the device rather than taken from the feature
+ * word vp_transport_features() is given, because that word is what the driver
+ * still wants rather than what the device offered.  The two differ exactly
+ * where this has to hold: virtio_dev_probe() calls finalize_features() a
+ * second time when a driver's validate() changed the set, and a validate()
+ * that declined VIRTIO_F_ORDER_PLATFORM leaves the bit absent from the word
+ * as well, which would read as an offer that never happened.  virtio_balloon
+ * declines VIRTIO_F_ACCESS_PLATFORM from validate() today, so the shape is
+ * not hypothetical.
+ */
+static bool vp_dmb_ordering_ok(struct virtio_device *vdev)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+
+	if (__virtio_test_bit(vdev, VIRTIO_F_ORDER_PLATFORM))
+		return true;
+
+	return !(vp_modern_get_features(&vp_dev->mdev) &
+		 BIT_ULL(VIRTIO_F_ORDER_PLATFORM));
+}
+
 static void vp_transport_features(struct virtio_device *vdev, u64 features)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
@@ -378,6 +408,27 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
 
 	if (features & BIT_ULL(VIRTIO_F_ADMIN_VQ))
 		__virtio_set_bit(vdev, VIRTIO_F_ADMIN_VQ);
+
+	/*
+	 * VIRTIO_F_DMB is only defined together with
+	 * VIRTIO_F_ACCESS_PLATFORM, so accept it only when the driver accepts
+	 * that too.  vring_transport_features() has already run, so the bit in
+	 * vdev is the one the driver accepts rather than the one the device
+	 * offered, and the proposal words the requirement against what the
+	 * driver accepts.  VIRTIO_F_ORDER_PLATFORM is required where the device
+	 * offers it, for the reason vp_dmb_ordering_ok() gives.
+	 * VIRTIO_F_VERSION_1 is required because the core locates and releases
+	 * the region from virtio_features_ok(), which returns before it gets
+	 * that far for a device without VERSION_1, so accepting the feature
+	 * without it would leave the feature negotiated and the region never
+	 * built.
+	 */
+	if (IS_ENABLED(CONFIG_VIRTIO_DMB) &&
+	    (features & BIT_ULL(VIRTIO_F_DMB)) &&
+	    __virtio_test_bit(vdev, VIRTIO_F_ACCESS_PLATFORM) &&
+	    (features & BIT_ULL(VIRTIO_F_VERSION_1)) &&
+	    vp_dmb_ordering_ok(vdev))
+		__virtio_set_bit(vdev, VIRTIO_F_DMB);
 }
 
 static int __vp_check_common_size_one_feature(struct virtio_device *vdev, u32 fbit,
@@ -413,6 +464,9 @@ static int vp_check_common_size(struct virtio_device *vdev)
 	if (vp_check_common_size_one_feature(vdev, VIRTIO_F_ADMIN_VQ, admin_queue_num))
 		return -EINVAL;
 
+	if (vp_check_common_size_one_feature(vdev, VIRTIO_F_DMB, dmb_shm_id))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -878,6 +932,15 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
 	return true;
 }
 
+static int vp_get_dmb_shm_id(struct virtio_device *vdev, u16 *id)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+
+	*id = vp_modern_get_dmb_shm_id(&vp_dev->mdev);
+
+	return 0;
+}
+
 /*
  * virtio_pci_admin_has_dev_parts - Checks whether the device parts
  * functionality is supported
@@ -1241,6 +1304,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.set_vq_affinity = vp_set_vq_affinity,
 	.get_vq_affinity = vp_get_vq_affinity,
 	.get_shm_region  = vp_get_shm_region,
+	.get_dmb_shm_id = vp_get_dmb_shm_id,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
 };
@@ -1261,6 +1325,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.set_vq_affinity = vp_set_vq_affinity,
 	.get_vq_affinity = vp_get_vq_affinity,
 	.get_shm_region  = vp_get_shm_region,
+	.get_dmb_shm_id = vp_get_dmb_shm_id,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
 };
