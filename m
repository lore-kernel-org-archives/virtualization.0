Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D54C47096
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 02:15:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4982C613D1
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 02:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4982C613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 280C6402AA;
	Wed,  2 Jun 2021 02:15:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C5mHjHh2Mg4d; Wed,  2 Jun 2021 02:15:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id CFFB0402B6;
	Wed,  2 Jun 2021 02:15:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA256C000D;
	Wed,  2 Jun 2021 02:15:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C21BC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 02:15:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF189402BE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 02:15:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Jeekk2_mhSV
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 02:15:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5BDE3402AA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 02:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622600152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xpp86MKQOz0QZsgGameycFz6/zr05nCyS0wGULJidQo=;
 b=EEyZRWdnzxJ92DOiM4xZpPhMV6brZBY4HgLm4kRwuSqCWhMFHsOWbb6da0BNA/1R8CDw1A
 MFCni970uAFv8tAEsBnNjfZ39XkN/u7PYlPLQc5hM0psO5FujFsv8LaIYugNHmDH2Hl/j8
 H/ncTp7B9eFaB9L8MTMbr9dB9OlR9Ck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-MBW2L-pqMV-XN_dfTNrBqQ-1; Tue, 01 Jun 2021 22:15:51 -0400
X-MC-Unique: MBW2L-pqMV-XN_dfTNrBqQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 548CD10082E0;
 Wed,  2 Jun 2021 02:15:50 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-99.pek2.redhat.com [10.72.12.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C719B6A03C;
 Wed,  2 Jun 2021 02:15:47 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH V2 RESEND 2/4] virtio-pci library: introduce
 vp_modern_get_driver_features()
Date: Wed,  2 Jun 2021 10:15:34 +0800
Message-Id: <20210602021536.39525-3-jasowang@redhat.com>
In-Reply-To: <20210602021536.39525-1-jasowang@redhat.com>
References: <20210602021536.39525-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: eli@mellanox.com
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

This patch introduce a helper to get driver/guest features from the
device.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 21 +++++++++++++++++++++
 include/linux/virtio_pci_modern.h      |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 54f297028586..e11ed748e661 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -383,6 +383,27 @@ u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev)
 }
 EXPORT_SYMBOL_GPL(vp_modern_get_features);
 
+/*
+ * vp_modern_get_driver_features - get driver features from device
+ * @mdev: the modern virtio-pci device
+ *
+ * Returns the driver features read from the device
+ */
+u64 vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)
+{
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+
+	u64 features;
+
+	vp_iowrite32(0, &cfg->guest_feature_select);
+	features = vp_ioread32(&cfg->guest_feature);
+	vp_iowrite32(1, &cfg->guest_feature_select);
+	features |= ((u64)vp_ioread32(&cfg->guest_feature) << 32);
+
+	return features;
+}
+EXPORT_SYMBOL_GPL(vp_modern_get_driver_features);
+
 /*
  * vp_modern_set_features - set features to device
  * @mdev: the modern virtio-pci device
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index 6a95b58fd0f4..eb2bd9b4077d 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -79,6 +79,7 @@ static inline void vp_iowrite64_twopart(u64 val,
 }
 
 u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev);
+u64 vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev);
 void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
 		     u64 features);
 u32 vp_modern_generation(struct virtio_pci_modern_device *mdev);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
