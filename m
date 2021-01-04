Return-Path: <SRS0=kU6l=GH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B6EC433E6
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 06:55:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C99912151B
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 06:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99912151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 83E6186FD0;
	Mon,  4 Jan 2021 06:55:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dcd7ILj6O888; Mon,  4 Jan 2021 06:55:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EE14886ECC;
	Mon,  4 Jan 2021 06:55:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9F77C0893;
	Mon,  4 Jan 2021 06:55:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6045FC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5CA4E2011B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9mmNF4j-pWgA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 930D220111
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609743346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jWQOtPyifN/PjEn3xTBf4iGLE1QrxjMiv/aT+1c7dfI=;
 b=CnrHMRtDf7KixdkbJ9IdpbE5wXfn+kLZmSat/uorh6FyX+uXMrNNVXV6M0ZSJWs6PTIiFG
 w9ltjq6M09JN2ZuwQom1HYjP4ztiad5Sw338i3WCgyb21OE/sx1MzX47rfgWAU3Wa280yz
 sqncjsqqifGmsQQdmXI9xuqMFOuYqto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-PR6Oina1Mji3ezzOKe1c0w-1; Mon, 04 Jan 2021 01:55:42 -0500
X-MC-Unique: PR6Oina1Mji3ezzOKe1c0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5095E800D55;
 Mon,  4 Jan 2021 06:55:41 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-91.pek2.redhat.com [10.72.13.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AD5D1002388;
 Mon,  4 Jan 2021 06:55:38 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH V3 08/19] virtio-pci-modern: introduce vp_modern_generation()
Date: Mon,  4 Jan 2021 14:54:52 +0800
Message-Id: <20210104065503.199631-9-jasowang@redhat.com>
In-Reply-To: <20210104065503.199631-1-jasowang@redhat.com>
References: <20210104065503.199631-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: shahafs@mellanox.com, rdunlap@infradead.org, lulu@redhat.com
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

This patch introduces vp_modern_generation() to get device generation.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index cb14fc334a9c..a128e5814045 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -289,15 +289,26 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 	}
 }
 
-static u32 vp_generation(struct virtio_device *vdev)
+/*
+ * vp_modern_generation - get the device genreation
+ * @mdev: the modern virtio-pci device
+ *
+ * Returns the genreation read from device
+ */
+static u32 vp_modern_generation(struct virtio_pci_modern_device *mdev)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 
 	return vp_ioread8(&cfg->config_generation);
 }
 
+static u32 vp_generation(struct virtio_device *vdev)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+
+	return vp_modern_generation(&vp_dev->mdev);
+}
+
 /*
  * vp_modern_get_status - get the device status
  * @mdev: the modern virtio-pci device
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
