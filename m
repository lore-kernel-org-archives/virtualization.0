Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A091BC433B4
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 07:32:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D7C3611F1
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 07:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7C3611F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E3ED0401F9;
	Thu, 15 Apr 2021 07:32:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9EbnsLStEbQM; Thu, 15 Apr 2021 07:32:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 928754012C;
	Thu, 15 Apr 2021 07:32:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EB67C000B;
	Thu, 15 Apr 2021 07:32:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7085AC0018
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:32:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4944C846EC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:32:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JTy7KZDbht4T
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:32:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 92931846D9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618471924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
 bh=tvo70H+X8MJ1qdI3suLeJqKhXV9PcO3VeOoRKkGDd0o=;
 b=K7sxg9bc1yIMD6JtbaAF2ttN8qNADYq37bAQ3DWYevULbaAKGicgrkFfb7+dOLph5yn2DA
 Sv8myHfFoM6ZvYENtfQBLFdx/Wzqb3o8D1UIN+n0JB0FftOjD5+tr+TYpGSrQs/KNoRefp
 0Prry2mQ7GzKDiTQ9SICto5RYc1xx6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-Z79qqh5WMNW6TWg-RZy2nA-1; Thu, 15 Apr 2021 03:32:02 -0400
X-MC-Unique: Z79qqh5WMNW6TWg-RZy2nA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DD6D1883520;
 Thu, 15 Apr 2021 07:32:01 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com
 (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41EB960657;
 Thu, 15 Apr 2021 07:31:59 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 2/7] virtio-pci library: switch to use
 vp_modern_map_vq_notify()
Date: Thu, 15 Apr 2021 03:31:42 -0400
Message-Id: <20210415073147.19331-3-jasowang@redhat.com>
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

This patch switch to use vp_modern_map_notify() for virtio-pci
library.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index fbd4ebc00eb6..29607d9bd95c 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -192,7 +192,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 
 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
 	struct virtqueue *vq;
-	u16 num, off;
+	u16 num;
 	int err;
 
 	if (index >= vp_modern_get_num_queues(mdev))
@@ -208,9 +208,6 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 		return ERR_PTR(-EINVAL);
 	}
 
-	/* get offset of notification word for this vq */
-	off = vp_modern_get_queue_notify_off(mdev, index);
-
 	info->msix_vector = msix_vec;
 
 	/* create the vring */
@@ -227,27 +224,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				virtqueue_get_avail_addr(vq),
 				virtqueue_get_used_addr(vq));
 
-	if (mdev->notify_base) {
-		/* offset should not wrap */
-		if ((u64)off * mdev->notify_offset_multiplier + 2
-		    > mdev->notify_len) {
-			dev_warn(&mdev->pci_dev->dev,
-				 "bad notification offset %u (x %u) "
-				 "for queue %u > %zd",
-				 off, mdev->notify_offset_multiplier,
-				 index, mdev->notify_len);
-			err = -EINVAL;
-			goto err_map_notify;
-		}
-		vq->priv = (void __force *)mdev->notify_base +
-			off * mdev->notify_offset_multiplier;
-	} else {
-		vq->priv = (void __force *)vp_modern_map_capability(mdev,
-							  mdev->notify_map_cap, 2, 2,
-							  off * mdev->notify_offset_multiplier, 2,
-							  NULL);
-	}
-
+	vq->priv = vp_modern_map_vq_notify(mdev, index);
 	if (!vq->priv) {
 		err = -ENOMEM;
 		goto err_map_notify;
-- 
2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
