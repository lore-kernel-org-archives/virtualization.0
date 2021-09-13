Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E318C433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 05:55:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C4960E76
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 05:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D2C4960E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A5CEF40232;
	Mon, 13 Sep 2021 05:55:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0isgpA7LWSE0; Mon, 13 Sep 2021 05:55:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 16114401EF;
	Mon, 13 Sep 2021 05:55:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E770FC000F;
	Mon, 13 Sep 2021 05:54:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33850C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 05:54:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 30A6181774
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 05:54:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dDB9maFaPfzl
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 05:54:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8697680F1B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 05:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631512497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vR9iCzVCROKUiEXD2CzM4Pn1CySsVc/uXehQ5Tcbo98=;
 b=A19UIMP2Epj4UVCbRfYD6u8vfWYIrMzPQjd4QbiR0VlUuvMsMKCFuO7+1K030oHgP4dehj
 O1MgJi0Pl2xjkF67LRq7aJkzYMgQFhK4QiZM66n3BLfqA++v0Umj2qeBrg169uZ/ojEiCY
 lEvkm1HCItwSQFOo0t0wc4zMjiKFhtI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-Ks-V8_G1NDe43t47inVZlQ-1; Mon, 13 Sep 2021 01:54:56 -0400
X-MC-Unique: Ks-V8_G1NDe43t47inVZlQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 740E6362F8;
 Mon, 13 Sep 2021 05:54:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-146.pek2.redhat.com
 [10.72.13.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F0F1C17258;
 Mon, 13 Sep 2021 05:54:48 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 7/9] virtio-pci: harden INTX interrupts
Date: Mon, 13 Sep 2021 13:53:51 +0800
Message-Id: <20210913055353.35219-8-jasowang@redhat.com>
In-Reply-To: <20210913055353.35219-1-jasowang@redhat.com>
References: <20210913055353.35219-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: konrad.wilk@oracle.com, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, david.kaplan@amd.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This patch tries to make sure the virtio interrupt handler for INTX
won't be called after a reset and before virtio_device_ready(). We
can't use IRQF_NO_AUTOEN since we're using shared interrupt
(IRQF_SHARED). So this patch tracks the INTX enabling status in a new
intx_soft_enabled variable and toggle it during in
vp_disable/enable_vectors(). The INTX interrupt handler will check
intx_soft_enabled before processing the actual interrupt.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 18 ++++++++++++++++--
 drivers/virtio/virtio_pci_common.h |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 0b9523e6dd39..835197151dc1 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -30,8 +30,12 @@ void vp_disable_vectors(struct virtio_device *vdev)
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	int i;
 
-	if (vp_dev->intx_enabled)
+	if (vp_dev->intx_enabled) {
+		vp_dev->intx_soft_enabled = false;
+		/* ensure the vp_interrupt see this intx_soft_enabled value */
+		smp_wmb();
 		synchronize_irq(vp_dev->pci_dev->irq);
+	}
 
 	for (i = 0; i < vp_dev->msix_vectors; ++i)
 		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
@@ -43,8 +47,12 @@ void vp_enable_vectors(struct virtio_device *vdev)
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	int i;
 
-	if (vp_dev->intx_enabled)
+	if (vp_dev->intx_enabled) {
+		vp_dev->intx_soft_enabled = true;
+		/* ensure the vp_interrupt see this intx_soft_enabled value */
+		smp_wmb();
 		return;
+	}
 
 	for (i = 0; i < vp_dev->msix_vectors; ++i)
 		enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
@@ -97,6 +105,12 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 	struct virtio_pci_device *vp_dev = opaque;
 	u8 isr;
 
+	if (!vp_dev->intx_soft_enabled)
+		return IRQ_NONE;
+
+	/* read intx_soft_enabled before read others */
+	smp_rmb();
+
 	/* reading the ISR has the effect of also clearing it so it's very
 	 * important to save off the value. */
 	isr = ioread8(vp_dev->isr);
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index a235ce9ff6a5..3c06e0f92ee4 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -64,6 +64,7 @@ struct virtio_pci_device {
 	/* MSI-X support */
 	int msix_enabled;
 	int intx_enabled;
+	bool intx_soft_enabled;
 	cpumask_var_t *msix_affinity_masks;
 	/* Name strings for interrupts. This size should be enough,
 	 * and I'm too lazy to allocate each name separately. */
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
