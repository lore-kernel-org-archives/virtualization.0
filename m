Return-Path: <SRS0=66oW=FA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FEAC6379D
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 09:26:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 166822173E
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 09:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfQxVX/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166822173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B009B876B5;
	Thu, 26 Nov 2020 09:26:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 953aQ7QgcUs5; Thu, 26 Nov 2020 09:26:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9D1F0876A4;
	Thu, 26 Nov 2020 09:26:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81628C1DA0;
	Thu, 26 Nov 2020 09:26:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D29FC0052
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 09:26:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3BC218769F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 09:26:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id skh7Ue71tCQ5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 09:26:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 876128769C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 09:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606382785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5vAaTuyjpc3k087BgLURQpk+B64VgFJLoCQx8GPQxT0=;
 b=cfQxVX/6X2Xvq26Bsi5bI+tXs3zvkkhxZv+3f1xZqx6rm9S8ANwRbng0pIgBe90QmwRddU
 qvdaQUNtZ4u6SlSR9tQEbw57cNnFCkxxAEyYaXLOQD/3dkV+WCl22OLRDLLav0nxuP+9MT
 DsgK4sC0YE3fu3TfXnaF00JDJl3mGmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-l5soPUjZPJKwGcX35IObxQ-1; Thu, 26 Nov 2020 04:26:23 -0500
X-MC-Unique: l5soPUjZPJKwGcX35IObxQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C8031006C94;
 Thu, 26 Nov 2020 09:26:22 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-213.pek2.redhat.com [10.72.13.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E29B19C71;
 Thu, 26 Nov 2020 09:26:20 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 04/14] virtio-pci: move the notification sanity check to
 vp_modern_probe()
Date: Thu, 26 Nov 2020 17:25:54 +0800
Message-Id: <20201126092604.208033-5-jasowang@redhat.com>
In-Reply-To: <20201126092604.208033-1-jasowang@redhat.com>
References: <20201126092604.208033-1-jasowang@redhat.com>
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

This patch moves the notification sanity check to
vp_modern_probe(). This can make sure the logic could be reused by
modules other than virtio-pci.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 34 +++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 02688c3b3fbd..d001c74beefe 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -384,17 +384,6 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	vp_iowrite64_twopart(virtqueue_get_used_addr(vq),
 			     &cfg->queue_used_lo, &cfg->queue_used_hi);
 
-	/* offset should not wrap */
-	if ((u64)off * mdev->notify_offset_multiplier + 2
-		> mdev->notify_len) {
-		dev_warn(&vp_dev->pci_dev->dev,
-			 "bad notification offset %u (x %u) "
-			 "for queue %u > %zd",
-			 off, mdev->notify_offset_multiplier,
-			 index, mdev->notify_len);
-		err = -EINVAL;
-		goto err_map_notify;
-	}
 	vq->priv = (void __force *)mdev->notify_base +
 		off * mdev->notify_offset_multiplier;
 
@@ -695,9 +684,11 @@ static inline void check_offsets(void)
 static int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 {
 	struct pci_dev *pci_dev = mdev->pci_dev;
-	int err, common, isr, notify, device;
+	int err, common, isr, notify, device, i;
+	unsigned int num_queues;
 	u32 notify_length;
 	u32 notify_offset;
+	u16 off;
 
 	/* We only own devices >= 0x1000 and <= 0x107f: leave the rest. */
 	if (pci_dev->device < 0x1000 || pci_dev->device > 0x107f)
@@ -796,6 +787,25 @@ static int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 	if (!mdev->notify_base)
 		goto err;
 
+	num_queues = vp_ioread16(&mdev->common->num_queues);
+
+	/* offset should not wrap */
+	for (i = 0; i < num_queues; i++) {
+		vp_iowrite16(i, &mdev->common->queue_select);
+		off = vp_ioread16(&mdev->common->queue_notify_off);
+
+		if ((u64)off * mdev->notify_offset_multiplier + 2
+			> mdev->notify_len) {
+			dev_warn(&pci_dev->dev,
+			 "bad notification offset %u (x %u) "
+			 "for queue %u > %zd",
+			 off, mdev->notify_offset_multiplier,
+			 i, mdev->notify_len);
+			err = -EINVAL;
+			goto err;
+		}
+	}
+
 	/* We don't know how much we should map, but PAGE_SIZE
 	 * is more than enough for all existing devices.
 	 */
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
