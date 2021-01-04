Return-Path: <SRS0=kU6l=GH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6813C433DB
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 06:56:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F57B2151B
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 06:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F57B2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 69AB286855;
	Mon,  4 Jan 2021 06:56:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pk-B+O6Z4xt0; Mon,  4 Jan 2021 06:56:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C670B86849;
	Mon,  4 Jan 2021 06:56:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE5A6C0893;
	Mon,  4 Jan 2021 06:56:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAD91C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:56:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C62CC86F9F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:56:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JcXTs+xWdCUB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:56:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 23E0086ECC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609743360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUytbAMZpxnyDVoKEmHdTVZHOLKlLjuSvjiZfZRuJQ0=;
 b=ShNHoWvb8OyUbXuIuCsP7q8wLvX7j6batcIEkLoeQbk9HDnyPe8JW6lYHQYEGPbvmlt7lK
 bP+BTgrH6j3zpYliJv8VURcqWtUzoU91Bjp/sqT2+w4NdXAQWw07rb2FGR77BWa/5mXxRl
 ViM798dNkGOJ1EMTABu00xRz0+ef7uM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-2Z2WPJx7Nxm6pSiWvsHF5w-1; Mon, 04 Jan 2021 01:55:58 -0500
X-MC-Unique: 2Z2WPJx7Nxm6pSiWvsHF5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5994F800D62;
 Mon,  4 Jan 2021 06:55:57 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-91.pek2.redhat.com [10.72.13.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BC281002388;
 Mon,  4 Jan 2021 06:55:54 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH V3 12/19] virtio-pci-modern: introduce helper for
 setting/geting queue size
Date: Mon,  4 Jan 2021 14:54:56 +0800
Message-Id: <20210104065503.199631-13-jasowang@redhat.com>
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

This patch introduces helper for setting/getting queue size for modern
device.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 34 ++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 0e62820b83ff..7a89226135af 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -262,6 +262,36 @@ static bool vp_modern_get_queue_enable(struct virtio_pci_modern_device *mdev,
 	return vp_ioread16(&mdev->common->queue_enable);
 }
 
+/*
+ * vp_modern_set_queue_size - set size for a virtqueue
+ * @mdev: the modern virtio-pci device
+ * @index: the queue index
+ * @size: the size of the virtqueue
+ */
+static void vp_modern_set_queue_size(struct virtio_pci_modern_device *mdev,
+				     u16 index, u16 size)
+{
+	vp_iowrite16(index, &mdev->common->queue_select);
+	vp_iowrite16(size, &mdev->common->queue_size);
+
+}
+
+/*
+ * vp_modern_get_queue_size - get size for a virtqueue
+ * @mdev: the modern virtio-pci device
+ * @index: the queue index
+ *
+ * Returns the size of the virtqueue
+ */
+static u16 vp_modern_get_queue_size(struct virtio_pci_modern_device *mdev,
+				    u16 index)
+{
+	vp_iowrite16(index, &mdev->common->queue_select);
+
+	return vp_ioread16(&mdev->common->queue_size);
+
+}
+
 /* virtio config->finalize_features() implementation */
 static int vp_finalize_features(struct virtio_device *vdev)
 {
@@ -487,7 +517,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	vp_iowrite16(index, &cfg->queue_select);
 
 	/* Check if queue is either not available or already active. */
-	num = vp_ioread16(&cfg->queue_size);
+	num = vp_modern_get_queue_size(mdev, index);
 	if (!num || vp_modern_get_queue_enable(mdev, index))
 		return ERR_PTR(-ENOENT);
 
@@ -510,7 +540,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 		return ERR_PTR(-ENOMEM);
 
 	/* activate the queue */
-	vp_iowrite16(virtqueue_get_vring_size(vq), &cfg->queue_size);
+	vp_modern_set_queue_size(mdev, index, virtqueue_get_vring_size(vq));
 	vp_modern_queue_address(mdev, index, virtqueue_get_desc_addr(vq),
 				virtqueue_get_avail_addr(vq),
 				virtqueue_get_used_addr(vq));
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
