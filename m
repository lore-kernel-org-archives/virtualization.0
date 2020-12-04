Return-Path: <SRS0=VsiN=FI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8146C433FE
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 04:04:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405A4222B6
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 04:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405A4222B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E4D6F87BC8;
	Fri,  4 Dec 2020 04:04:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mzqGsLcLForn; Fri,  4 Dec 2020 04:04:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CD22C87B40;
	Fri,  4 Dec 2020 04:04:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5E9EC163C;
	Fri,  4 Dec 2020 04:04:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7314EC0FA7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 04:04:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5F56687BB3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 04:04:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oPx2-3ZysDTn
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 04:04:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 90C8B87B3F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 04:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607054654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WjwOvxc/H63/yuRAiv4FstjGXxdKxusKOd3E2oWbPlQ=;
 b=O0+x+wgpQmI9Vz1I4+CyVtoVDoRyOf9gsVt4y0Qkw/Nas0Ftx/cwj1ot1wB9C0IPt85doR
 kOYyPgSA2cPRt1R4T7i/MP05u+7BvQyKbkLafcgxx3vMwkdDoW+GzFY1wQC8LozTfo4p1u
 YMCqD0buOVDSmetW0vSXhema6WbVeXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-20DYteYmM0OLAhIsnQ25ZA-1; Thu, 03 Dec 2020 23:04:12 -0500
X-MC-Unique: 20DYteYmM0OLAhIsnQ25ZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2658E80EF80;
 Fri,  4 Dec 2020 04:04:11 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-12-116.pek2.redhat.com [10.72.12.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFA181A4D0;
 Fri,  4 Dec 2020 04:04:08 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 03/19] virtio-pci-modern: factor out modern device
 initialization logic
Date: Fri,  4 Dec 2020 12:03:37 +0800
Message-Id: <20201204040353.21679-4-jasowang@redhat.com>
In-Reply-To: <20201204040353.21679-1-jasowang@redhat.com>
References: <20201204040353.21679-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: shahafs@mellanox.com
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

This patch factors out the modern device initialization logic into a
helper. Note that it still depends on the caller to enable pci device
which allows the caller to use e.g devres.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 50 +++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 524490a94ca4..5d2d2ae0dfdb 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -703,11 +703,16 @@ static inline void check_offsets(void)
 		     offsetof(struct virtio_pci_common_cfg, queue_used_hi));
 }
 
-/* the PCI probing function */
-int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
+/*
+ * vp_modern_probe: probe the modern virtio pci device, note that the
+ * caller is required to enable PCI device before calling this function.
+ * @mdev: the modern virtio-pci device
+ *
+ * Return 0 on succeed otherwise fail
+ */
+static int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 {
-	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
-	struct pci_dev *pci_dev = vp_dev->pci_dev;
+	struct pci_dev *pci_dev = mdev->pci_dev;
 	int err, common, isr, notify, device;
 	u32 notify_length;
 	u32 notify_offset;
@@ -826,18 +831,8 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 					      &mdev->device_len);
 		if (!mdev->device)
 			goto err_map_device;
-
-		vp_dev->vdev.config = &virtio_pci_config_ops;
-	} else {
-		vp_dev->vdev.config = &virtio_pci_config_nodev_ops;
 	}
 
-	vp_dev->config_vector = vp_config_vector;
-	vp_dev->setup_vq = setup_vq;
-	vp_dev->del_vq = del_vq;
-	vp_dev->isr = mdev->isr;
-	vp_dev->vdev.id = mdev->id;
-
 	return 0;
 
 err_map_device:
@@ -851,6 +846,33 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 	return err;
 }
 
+/* the PCI probing function */
+int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
+{
+	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+	struct pci_dev *pci_dev = vp_dev->pci_dev;
+	int err;
+
+	mdev->pci_dev = pci_dev;
+
+	err = vp_modern_probe(mdev);
+	if (err)
+		return err;
+
+	if (mdev->device)
+		vp_dev->vdev.config = &virtio_pci_config_ops;
+	else
+		vp_dev->vdev.config = &virtio_pci_config_nodev_ops;
+
+	vp_dev->config_vector = vp_config_vector;
+	vp_dev->setup_vq = setup_vq;
+	vp_dev->del_vq = del_vq;
+	vp_dev->isr = mdev->isr;
+	vp_dev->vdev.id = mdev->id;
+
+	return 0;
+}
+
 void virtio_pci_modern_remove(struct virtio_pci_device *vp_dev)
 {
 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
