Return-Path: <SRS0=kU6l=GH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C16C433E0
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 06:56:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E882151B
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 06:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E882151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2EBE32011B;
	Mon,  4 Jan 2021 06:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OkvJoCzdxX3G; Mon,  4 Jan 2021 06:56:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 84720203C3;
	Mon,  4 Jan 2021 06:56:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F459C0893;
	Mon,  4 Jan 2021 06:56:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3D9DC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9D46F86842
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WOARgN0tMZJb
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:56:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EF61A86803
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609743372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vh5cz5at1G+5ld0pHqqsQA1nJo4RyhpJ3/S1fZfR/fY=;
 b=MxRUE6yVJPPDouqUbgnl4rR7q1Eogsh3BjB//5hbPK55wxhCi61q0SrFWrij5a8UoJsj24
 AXQnFT4CYTtYqUfcwkp3r3NjlU0CjKwRCpD7497Bpsp6Q4+//sG0P8XmKetISBQocT76c2
 hLsEHRK/e6mfiTVV6kBdCBFj/Us2qSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-aD5CUk07NpOCKarpVvm-pQ-1; Mon, 04 Jan 2021 01:56:11 -0500
X-MC-Unique: aD5CUk07NpOCKarpVvm-pQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E87A9803620;
 Mon,  4 Jan 2021 06:56:09 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-91.pek2.redhat.com [10.72.13.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 481251002388;
 Mon,  4 Jan 2021 06:56:03 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH V3 15/19] virito-pci-modern: rename map_capability() to
 vp_modern_map_capability()
Date: Mon,  4 Jan 2021 14:54:59 +0800
Message-Id: <20210104065503.199631-16-jasowang@redhat.com>
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

To ease the split, map_capability() was renamed to
vp_modern_map_capability(). While at it, add the comments for the
arguments and switch to use virtio_pci_modern_device as the first
parameter.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 46 +++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 217573f2588d..a5e3a5e40323 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -63,12 +63,25 @@ static void vp_iowrite64_twopart(u64 val,
 	vp_iowrite32(val >> 32, hi);
 }
 
-static void __iomem *map_capability(struct pci_dev *dev, int off,
-				    size_t minlen,
-				    u32 align,
-				    u32 start, u32 size,
-				    size_t *len)
+/*
+ * vp_modern_map_capability - map a part of virtio pci capability
+ * @mdev: the modern virtio-pci device
+ * @off: offset of the capability
+ * @minlen: minimal length of the capability
+ * @align: align requirement
+ * @start: start from the capability
+ * @size: map size
+ * @len: the length that is actually mapped
+ *
+ * Returns the io address of for the part of the capability
+ */
+void __iomem *vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
+				       size_t minlen,
+				       u32 align,
+				       u32 start, u32 size,
+				       size_t *len)
 {
+	struct pci_dev *dev = mdev->pci_dev;
 	u8 bar;
 	u32 offset, length;
 	void __iomem *p;
@@ -582,7 +595,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 		vq->priv = (void __force *)mdev->notify_base +
 			off * mdev->notify_offset_multiplier;
 	} else {
-		vq->priv = (void __force *)map_capability(mdev->pci_dev,
+		vq->priv = (void __force *)vp_modern_map_capability(mdev,
 							  mdev->notify_map_cap, 2, 2,
 							  off * mdev->notify_offset_multiplier, 2,
 							  NULL);
@@ -956,15 +969,15 @@ static int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 		return err;
 
 	err = -EINVAL;
-	mdev->common = map_capability(pci_dev, common,
+	mdev->common = vp_modern_map_capability(mdev, common,
 				      sizeof(struct virtio_pci_common_cfg), 4,
 				      0, sizeof(struct virtio_pci_common_cfg),
 				      NULL);
 	if (!mdev->common)
 		goto err_map_common;
-	mdev->isr = map_capability(pci_dev, isr, sizeof(u8), 1,
-				   0, 1,
-				   NULL);
+	mdev->isr = vp_modern_map_capability(mdev, isr, sizeof(u8), 1,
+					     0, 1,
+					     NULL);
 	if (!mdev->isr)
 		goto err_map_isr;
 
@@ -989,9 +1002,10 @@ static int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 	 * Otherwise, map each VQ individually later.
 	 */
 	if ((u64)notify_length + (notify_offset % PAGE_SIZE) <= PAGE_SIZE) {
-		mdev->notify_base = map_capability(pci_dev, notify, 2, 2,
-						   0, notify_length,
-						   &mdev->notify_len);
+		mdev->notify_base = vp_modern_map_capability(mdev, notify,
+							     2, 2,
+							     0, notify_length,
+							     &mdev->notify_len);
 		if (!mdev->notify_base)
 			goto err_map_notify;
 	} else {
@@ -1002,9 +1016,9 @@ static int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 	 * is more than enough for all existing devices.
 	 */
 	if (device) {
-		mdev->device = map_capability(pci_dev, device, 0, 4,
-					      0, PAGE_SIZE,
-					      &mdev->device_len);
+		mdev->device = vp_modern_map_capability(mdev, device, 0, 4,
+							0, PAGE_SIZE,
+							&mdev->device_len);
 		if (!mdev->device)
 			goto err_map_device;
 	}
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
