Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156C9C433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 03:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B036240CA5;
	Wed, 23 Mar 2022 03:15:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5kI04EiOTgCV; Wed, 23 Mar 2022 03:15:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 188D040C98;
	Wed, 23 Mar 2022 03:15:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0636C0012;
	Wed, 23 Mar 2022 03:15:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 151BCC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 03:15:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E36CD419BF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 03:15:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Kf0KUE8qe6q
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 03:15:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2DC21419B3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 03:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648005334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RzU9qqeaoBp/Yii+Yq3KaDZTZqiOvzziYtFqIGNvnWw=;
 b=FuMlEfDPx1Ffc4Ba/ETKx2W7XlPLu0BEtIdg6DIxWte7zhQmBTXjMv34ZgWdpFF/dQ+vhE
 um3N/smgpPstSn/9RkheeU/pOU2huGoaDLU7H9wOhxZctQEvOM8b4Jy54Hoamgz1ta/hnk
 K3EYwNwH5smz24EEw984p3JM/ZynF3E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-f43DsdMhMTi3hwG3iEVDBw-1; Tue, 22 Mar 2022 23:15:30 -0400
X-MC-Unique: f43DsdMhMTi3hwG3iEVDBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A86F3804078;
 Wed, 23 Mar 2022 03:15:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-49.pek2.redhat.com [10.72.12.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F26E11400E70;
 Wed, 23 Mar 2022 03:15:26 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Revert "virtio-pci: harden INTX interrupts"
Date: Wed, 23 Mar 2022 11:15:23 +0800
Message-Id: <20220323031524.6555-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Cc: peterz@infradead.org, tglx@linutronix.de
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

This reverts commit 080cd7c3ac8701081d143a15ba17dd9475313188. Since
the MSI-X interrupts hardening will be reverted in the next patch. We
will rework the interrupt hardening in the future.

Fixes: 080cd7c3ac87 ("virtio-pci: harden INTX interrupts")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 23 ++---------------------
 drivers/virtio/virtio_pci_common.h |  1 -
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index fdbde1db5ec5..3f51fdb7be45 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -30,16 +30,8 @@ void vp_disable_cbs(struct virtio_device *vdev)
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	int i;
 
-	if (vp_dev->intx_enabled) {
-		/*
-		 * The below synchronize() guarantees that any
-		 * interrupt for this line arriving after
-		 * synchronize_irq() has completed is guaranteed to see
-		 * intx_soft_enabled == false.
-		 */
-		WRITE_ONCE(vp_dev->intx_soft_enabled, false);
+	if (vp_dev->intx_enabled)
 		synchronize_irq(vp_dev->pci_dev->irq);
-	}
 
 	for (i = 0; i < vp_dev->msix_vectors; ++i)
 		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
@@ -51,16 +43,8 @@ void vp_enable_cbs(struct virtio_device *vdev)
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	int i;
 
-	if (vp_dev->intx_enabled) {
-		disable_irq(vp_dev->pci_dev->irq);
-		/*
-		 * The above disable_irq() provides TSO ordering and
-		 * as such promotes the below store to store-release.
-		 */
-		WRITE_ONCE(vp_dev->intx_soft_enabled, true);
-		enable_irq(vp_dev->pci_dev->irq);
+	if (vp_dev->intx_enabled)
 		return;
-	}
 
 	for (i = 0; i < vp_dev->msix_vectors; ++i)
 		enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
@@ -113,9 +97,6 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 	struct virtio_pci_device *vp_dev = opaque;
 	u8 isr;
 
-	if (!READ_ONCE(vp_dev->intx_soft_enabled))
-		return IRQ_NONE;
-
 	/* reading the ISR has the effect of also clearing it so it's very
 	 * important to save off the value. */
 	isr = ioread8(vp_dev->isr);
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 23f6c5c678d5..d3c6f72c7390 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -63,7 +63,6 @@ struct virtio_pci_device {
 	/* MSI-X support */
 	int msix_enabled;
 	int intx_enabled;
-	bool intx_soft_enabled;
 	cpumask_var_t *msix_affinity_masks;
 	/* Name strings for interrupts. This size should be enough,
 	 * and I'm too lazy to allocate each name separately. */
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
