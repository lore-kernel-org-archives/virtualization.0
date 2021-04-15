Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8D4C433ED
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 07:32:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9AE561249
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 07:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AE561249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C879846ED;
	Thu, 15 Apr 2021 07:32:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fHkv8NMwltF0; Thu, 15 Apr 2021 07:32:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CF10846EA;
	Thu, 15 Apr 2021 07:32:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BB01C000B;
	Thu, 15 Apr 2021 07:32:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3819AC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:32:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 26E5160D74
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:32:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zQKqSDZDQar0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:32:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EF0AA60816
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618471922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
 bh=SakyL2xDOEGFzy/jZi6mME+ezuJj78cuYX6cQVP57+M=;
 b=efLanosNdGuZq2RfqFYbJnluCmLZdwfHlHnWXmK+z/RIFztwBcOkA6gIHkIQtiJzeD8aCK
 DQZKTp16nWvc2bK9zt5nmPQGsnlddiaYYNCN/dqToUeZw7yFM00mst9WalGJL2QeIUk0PD
 CF/kLbmGU0SKb2wA27+wKAMpIlwJXV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-pY5_qzDwNoSR44FbqT7Rrw-1; Thu, 15 Apr 2021 03:31:59 -0400
X-MC-Unique: pY5_qzDwNoSR44FbqT7Rrw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B83591883522;
 Thu, 15 Apr 2021 07:31:58 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com
 (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD0DF69FD0;
 Thu, 15 Apr 2021 07:31:56 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 1/7] virtio_pci_modern: introduce helper to map vq notify area
Date: Thu, 15 Apr 2021 03:31:41 -0400
Message-Id: <20210415073147.19331-2-jasowang@redhat.com>
In-Reply-To: <20210415073147.19331-1-jasowang@redhat.com>
References: <20210415073147.19331-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: elic@nvidia.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This patch factors out the logic of vq notify area mapping. Following
patches will switch to use this common helpers for both virtio_pci
library and virtio-pci vDPA driver.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 35 ++++++++++++++++++++++++++
 include/linux/virtio_pci_modern.h      |  2 ++
 2 files changed, 37 insertions(+)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index cbd667496bb1..28cb5847fafa 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -593,6 +593,41 @@ u16 vp_modern_get_queue_notify_off(struct virtio_pci_modern_device *mdev,
 }
 EXPORT_SYMBOL_GPL(vp_modern_get_queue_notify_off);
 
+/*
+ * vp_modern_map_vq_notify - map notification area for a
+ * specific virtqueue
+ * @mdev: the modern virtio-pci device
+ * @index: the queue index
+ *
+ * Returns the address of the notification area
+ */
+void *vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
+			      u16 index)
+{
+	u16 off = vp_modern_get_queue_notify_off(mdev, index);
+
+	if (mdev->notify_base) {
+		/* offset should not wrap */
+		if ((u64)off * mdev->notify_offset_multiplier + 2
+			> mdev->notify_len) {
+			dev_warn(&mdev->pci_dev->dev,
+				 "bad notification offset %u (x %u) "
+				 "for queue %u > %zd",
+				 off, mdev->notify_offset_multiplier,
+				 index, mdev->notify_len);
+			return NULL;
+		}
+		return (void __force *)mdev->notify_base +
+			off * mdev->notify_offset_multiplier;
+	} else {
+		return (void __force *)vp_modern_map_capability(mdev,
+				       mdev->notify_map_cap, 2, 2,
+				       off * mdev->notify_offset_multiplier, 2,
+				       NULL);
+	}
+}
+EXPORT_SYMBOL_GPL(vp_modern_map_vq_notify);
+
 MODULE_VERSION("0.1");
 MODULE_DESCRIPTION("Modern Virtio PCI Device");
 MODULE_AUTHOR("Jason Wang <jasowang@redhat.com>");
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index f26acbeec965..1b95d39b00fc 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -106,6 +106,8 @@ void __iomem *vp_modern_map_capability(struct virtio_pci_modern_device *mdev, in
 				       u32 align,
 				       u32 start, u32 size,
 				       size_t *len);
+void *vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
+                              u16 index);
 int vp_modern_probe(struct virtio_pci_modern_device *mdev);
 void vp_modern_remove(struct virtio_pci_modern_device *mdev);
 #endif
-- 
2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
