Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96EEE95A8E
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 09:38:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1013282266;
	Sun,  8 Oct 2023 09:38:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1013282266
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id twbgdjGwgI5g; Sun,  8 Oct 2023 09:38:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 72CE081F17;
	Sun,  8 Oct 2023 09:38:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72CE081F17
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 447BBC0071;
	Sun,  8 Oct 2023 09:38:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54E6AC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 09:38:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 319D860899
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 09:38:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 319D860899
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nSO0MDxCnrut
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 09:38:50 +0000 (UTC)
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69F2460B32
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 09:38:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 69F2460B32
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R471e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0VtdtvhW_1696757923; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VtdtvhW_1696757923) by smtp.aliyun-inc.com;
 Sun, 08 Oct 2023 17:38:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v2 1/2] virtio_pci: fix the common map size and add
 check for common size
Date: Sun,  8 Oct 2023 17:38:41 +0800
Message-Id: <20231008093842.87131-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231008093842.87131-1-xuanzhuo@linux.alibaba.com>
References: <20231008093842.87131-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 44354de94c87
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Now, the function vp_modern_map_capability() takes the size parameter,
which corresponds to the size of virtio_pci_common_cfg. As a result,
this indicates the size of memory area to map.

However, if the _F_RING_RESET is negotiated, the extra items will be
used. Therefore, we need to use the size of virtio_pci_modern_common_cfg
to map more space.

Meanwhile, this patch removes the feature(_F_RING_ERSET and
_F_NOTIFICATION_DATA) when the common cfg size does not match
the corresponding feature.

Fixes: 0b50cece0b78 ("virtio_pci: introduce helper to get/set queue reset")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_pci_modern.c     | 20 +++++++++++++++++++-
 drivers/virtio/virtio_pci_modern_dev.c |  4 ++--
 include/linux/virtio_pci_modern.h      |  1 +
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index d6bb68ba84e5..c0b9d2363ddb 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -22,8 +22,26 @@
 static u64 vp_get_features(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	u64 features = vp_modern_get_features(&vp_dev->mdev);
+
+#define check_feature(feature, field)								\
+	do {											\
+		if (features & BIT_ULL(feature)) {						\
+			u32 offset = offsetofend(struct virtio_pci_modern_common_cfg, field);	\
+			if (unlikely(vp_dev->mdev.common_len < offset))				\
+				features &= ~BIT_ULL(feature);					\
+		}										\
+	} while (0)
+
+	/* For buggy devices, if the common len does not match the feature, we
+	 * remove the feature.
+	 */
+	check_feature(VIRTIO_F_NOTIFICATION_DATA, queue_notify_data);
+	check_feature(VIRTIO_F_RING_RESET, queue_reset);
+
+#undef check_feature
 
-	return vp_modern_get_features(&vp_dev->mdev);
+	return features;
 }
 
 static void vp_transport_features(struct virtio_device *vdev, u64 features)
diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index aad7d9296e77..33f319da1558 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -291,8 +291,8 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 	err = -EINVAL;
 	mdev->common = vp_modern_map_capability(mdev, common,
 				      sizeof(struct virtio_pci_common_cfg), 4,
-				      0, sizeof(struct virtio_pci_common_cfg),
-				      NULL, NULL);
+				      0, sizeof(struct virtio_pci_modern_common_cfg),
+				      &mdev->common_len, NULL);
 	if (!mdev->common)
 		goto err_map_common;
 	mdev->isr = vp_modern_map_capability(mdev, isr, sizeof(u8), 1,
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index 067ac1d789bc..edf62bae0474 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -28,6 +28,7 @@ struct virtio_pci_modern_device {
 	/* So we can sanity-check accesses. */
 	size_t notify_len;
 	size_t device_len;
+	size_t common_len;
 
 	/* Capability for when we need to map notifications per-vq. */
 	int notify_map_cap;
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
