Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB90DCDB465
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 03:49:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46E9542726;
	Thu, 19 Oct 2023 03:49:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 46E9542726
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id amnVJNT5MYn0; Thu, 19 Oct 2023 03:49:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 668CC4271B;
	Thu, 19 Oct 2023 03:49:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 668CC4271B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16441C0039;
	Thu, 19 Oct 2023 03:49:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F012FC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 03:49:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB3E583A52
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 03:49:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB3E583A52
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nmuRfJR6pQuA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 03:49:10 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E4F2D83A56
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 03:49:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E4F2D83A56
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0VuSdeJd_1697687342; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VuSdeJd_1697687342) by smtp.aliyun-inc.com;
 Thu, 19 Oct 2023 11:49:03 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v4] virtio_pci: add check for common cfg size
Date: Thu, 19 Oct 2023 11:49:02 +0800
Message-Id: <20231019034902.7346-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
X-Git-Hash: d80e81fb647f
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

Some buggy devices, the common cfg size may not match the features.

This patch checks the common cfg size for the
features(VIRTIO_F_NOTIF_CONFIG_DATA, VIRTIO_F_RING_RESET). When the
common cfg size does not match the corresponding feature, we fail the
probe and print error message.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---

v4: fix printing size_t with format %zu

 drivers/virtio/virtio_pci_modern.c     | 36 ++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_modern_dev.c |  2 +-
 include/linux/virtio_pci_modern.h      |  1 +
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index d6bb68ba84e5..ee6a386d250b 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -39,6 +39,39 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
 		__virtio_set_bit(vdev, VIRTIO_F_RING_RESET);
 }

+static int __vp_check_common_size_one_feature(struct virtio_device *vdev, u32 fbit,
+					    u32 offset, const char *fname)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+
+	if (!__virtio_test_bit(vdev, fbit))
+		return 0;
+
+	if (likely(vp_dev->mdev.common_len >= offset))
+		return 0;
+
+	dev_err(&vdev->dev,
+		"virtio: common cfg size(%zu) does not match the feature %s\n",
+		vp_dev->mdev.common_len, fname);
+
+	return -EINVAL;
+}
+
+#define vp_check_common_size_one_feature(vdev, fbit, field) \
+	__vp_check_common_size_one_feature(vdev, fbit, \
+		offsetofend(struct virtio_pci_modern_common_cfg, field), #fbit)
+
+static int vp_check_common_size(struct virtio_device *vdev)
+{
+	if (vp_check_common_size_one_feature(vdev, VIRTIO_F_NOTIF_CONFIG_DATA, queue_notify_data))
+		return -EINVAL;
+
+	if (vp_check_common_size_one_feature(vdev, VIRTIO_F_RING_RESET, queue_reset))
+		return -EINVAL;
+
+	return 0;
+}
+
 /* virtio config->finalize_features() implementation */
 static int vp_finalize_features(struct virtio_device *vdev)
 {
@@ -57,6 +90,9 @@ static int vp_finalize_features(struct virtio_device *vdev)
 		return -EINVAL;
 	}

+	if (vp_check_common_size(vdev))
+		return -EINVAL;
+
 	vp_modern_set_features(&vp_dev->mdev, vdev->features);

 	return 0;
diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index d312443d6569..e2a1fe7bb66c 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -296,7 +296,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 	mdev->common = vp_modern_map_capability(mdev, common,
 				      sizeof(struct virtio_pci_common_cfg), 4,
 				      0, sizeof(struct virtio_pci_modern_common_cfg),
-				      NULL, NULL);
+				      &mdev->common_len, NULL);
 	if (!mdev->common)
 		goto err_map_common;
 	mdev->isr = vp_modern_map_capability(mdev, isr, sizeof(u8), 1,
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index a38c729d1973..d0f2797420f7 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -45,6 +45,7 @@ struct virtio_pci_modern_device {

 	size_t notify_len;
 	size_t device_len;
+	size_t common_len;

 	int notify_map_cap;

--
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
