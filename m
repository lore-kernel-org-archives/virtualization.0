Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CE7C433F5
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 06:53:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD1FF6103D
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 06:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD1FF6103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D39D80F86;
	Tue, 12 Oct 2021 06:53:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ukbjQXbEVbS5; Tue, 12 Oct 2021 06:53:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 288B980E5F;
	Tue, 12 Oct 2021 06:53:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F869C000F;
	Tue, 12 Oct 2021 06:53:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A8DEC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:53:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0CE8880F9F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:53:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2UCnJVmcdHR8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:53:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3EC3780E5F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634021602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g0tYArasr8oWFNs1Jmhkp7snjhybF68hNhg2YnABW1Q=;
 b=Rcpc8DEwX8hL2emTg3DAbGFKeSCB2iHdnyGtlSQAQl6SeVFiNnecK03zNoF59IkW+ad7Cq
 c4dg6D6TF9YaUXiWQy9zXKDqIL21SbqfDJXyysHu7yag9plNH3akOKWx+aLvoBWx+/qa0i
 IHp5aH4GHf/crVupRRen+ZZSfi8UZ10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-q0q7LrV-Moazbaxe_QDSwQ-1; Tue, 12 Oct 2021 02:53:18 -0400
X-MC-Unique: q0q7LrV-Moazbaxe_QDSwQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FFFD1089A85;
 Tue, 12 Oct 2021 06:52:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-111.pek2.redhat.com
 [10.72.13.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A13265F4E6;
 Tue, 12 Oct 2021 06:52:50 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 06/12] virtio_pci: harden MSI-X interrupts
Date: Tue, 12 Oct 2021 14:52:21 +0800
Message-Id: <20211012065227.9953-7-jasowang@redhat.com>
In-Reply-To: <20211012065227.9953-1-jasowang@redhat.com>
References: <20211012065227.9953-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: "Paul E . McKenney" <paulmck@kernel.org>, david.kaplan@amd.com,
 konrad.wilk@oracle.com, Peter Zijlstra <peterz@infradead.org>,
 f.hetzelt@tu-berlin.de, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Thomas Gleixner <tglx@linutronix.de>
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

We used to synchronize pending MSI-X irq handlers via
synchronize_irq(), this may not work for the untrusted device which
may keep sending interrupts after reset which may lead unexpected
results. Similarly, we should not enable MSI-X interrupt until the
device is ready. So this patch fixes those two issues by:

1) switching to use disable_irq() to prevent the virtio interrupt
   handlers to be called after the device is reset.
2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()

This can make sure the virtio interrupt handler won't be called before
virtio_device_ready() and after reset.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 27 +++++++++++++++++++++------
 drivers/virtio/virtio_pci_common.h |  6 ++++--
 drivers/virtio/virtio_pci_legacy.c |  5 +++--
 drivers/virtio/virtio_pci_modern.c |  6 ++++--
 4 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index b35bb2d57f62..0b9523e6dd39 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,
 		 "Force legacy mode for transitional virtio 1 devices");
 #endif
 
-/* wait for pending irq handlers */
-void vp_synchronize_vectors(struct virtio_device *vdev)
+/* disable irq handlers */
+void vp_disable_vectors(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	int i;
@@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
 		synchronize_irq(vp_dev->pci_dev->irq);
 
 	for (i = 0; i < vp_dev->msix_vectors; ++i)
-		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
+		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
+}
+
+/* enable irq handlers */
+void vp_enable_vectors(struct virtio_device *vdev)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	int i;
+
+	if (vp_dev->intx_enabled)
+		return;
+
+	for (i = 0; i < vp_dev->msix_vectors; ++i)
+		enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
 }
 
 /* the notify function used when creating a virt queue */
@@ -141,7 +154,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 	snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
 		 "%s-config", name);
 	err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
-			  vp_config_changed, 0, vp_dev->msix_names[v],
+			  vp_config_changed, IRQF_NO_AUTOEN,
+			  vp_dev->msix_names[v],
 			  vp_dev);
 	if (err)
 		goto error;
@@ -160,7 +174,8 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
 			 "%s-virtqueues", name);
 		err = request_irq(pci_irq_vector(vp_dev->pci_dev, v),
-				  vp_vring_interrupt, 0, vp_dev->msix_names[v],
+				  vp_vring_interrupt, IRQF_NO_AUTOEN,
+				  vp_dev->msix_names[v],
 				  vp_dev);
 		if (err)
 			goto error;
@@ -337,7 +352,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 			 "%s-%s",
 			 dev_name(&vp_dev->vdev.dev), names[i]);
 		err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
-				  vring_interrupt, 0,
+				  vring_interrupt, IRQF_NO_AUTOEN,
 				  vp_dev->msix_names[msix_vec],
 				  vqs[i]);
 		if (err)
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index beec047a8f8d..a235ce9ff6a5 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -102,8 +102,10 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
 	return container_of(vdev, struct virtio_pci_device, vdev);
 }
 
-/* wait for pending irq handlers */
-void vp_synchronize_vectors(struct virtio_device *vdev);
+/* disable irq handlers */
+void vp_disable_vectors(struct virtio_device *vdev);
+/* enable irq handlers */
+void vp_enable_vectors(struct virtio_device *vdev);
 /* the notify function used when creating a virt queue */
 bool vp_notify(struct virtqueue *vq);
 /* the config->del_vqs() implementation */
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index d62e9835aeec..bdf6bc667ab5 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -97,8 +97,8 @@ static void vp_reset(struct virtio_device *vdev)
 	/* Flush out the status write, and flush in device writes,
 	 * including MSi-X interrupts, if any. */
 	ioread8(vp_dev->ioaddr + VIRTIO_PCI_STATUS);
-	/* Flush pending VQ/configuration callbacks. */
-	vp_synchronize_vectors(vdev);
+	/* Disable VQ/configuration callbacks. */
+	vp_disable_vectors(vdev);
 }
 
 static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
@@ -194,6 +194,7 @@ static void del_vq(struct virtio_pci_vq_info *info)
 }
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
+	.ready		= vp_enable_vectors,
 	.get		= vp_get,
 	.set		= vp_set,
 	.get_status	= vp_get_status,
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 30654d3a0b41..acf0f6b6381d 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -172,8 +172,8 @@ static void vp_reset(struct virtio_device *vdev)
 	 */
 	while (vp_modern_get_status(mdev))
 		msleep(1);
-	/* Flush pending VQ/configuration callbacks. */
-	vp_synchronize_vectors(vdev);
+	/* Disable VQ/configuration callbacks. */
+	vp_disable_vectors(vdev);
 }
 
 static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
@@ -380,6 +380,7 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
 }
 
 static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
+	.ready		= vp_enable_vectors,
 	.get		= NULL,
 	.set		= NULL,
 	.generation	= vp_generation,
@@ -397,6 +398,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 };
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
+	.ready		= vp_enable_vectors,
 	.get		= vp_get,
 	.set		= vp_set,
 	.generation	= vp_generation,
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
