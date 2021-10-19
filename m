Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCFEC433F5
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 07:03:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D173611BF
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 07:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D173611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 002FD402F1;
	Tue, 19 Oct 2021 07:03:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mHOtLOJ-phPu; Tue, 19 Oct 2021 07:03:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 60EF640394;
	Tue, 19 Oct 2021 07:03:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 286EFC0011;
	Tue, 19 Oct 2021 07:03:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DDDAC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 07:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 196E6404CC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 07:03:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6F4Oh_bJfWmC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 07:03:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1EE07402F1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 07:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634627018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=29Tl2XIWb4fkaZTXpgIA0U7aKxrMPir07JupUJnTbKw=;
 b=b0YN/b5CITe1lYkZyGWGvXCNylJty660v/JNVlg6Zslor+3j5o8tJPNkESZ0DdljxkUaYv
 pb43DqJssUnFARI+SO0YvICmo2yuSovCj+gtxAcFOnBEXd81xO+FC0QWMvQbEVD9W0Iqy7
 OJni5JLAl21TD9MBGr25iVmcmC8vSCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-97pc6wwLPaKyflMK5mPTgA-1; Tue, 19 Oct 2021 03:03:34 -0400
X-MC-Unique: 97pc6wwLPaKyflMK5mPTgA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EC7780A5C6;
 Tue, 19 Oct 2021 07:03:32 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-155.pek2.redhat.com
 [10.72.12.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF93D5BB0D;
 Tue, 19 Oct 2021 07:03:24 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V3 05/10] virtio-pci: harden INTX interrupts
Date: Tue, 19 Oct 2021 15:01:47 +0800
Message-Id: <20211019070152.8236-6-jasowang@redhat.com>
In-Reply-To: <20211019070152.8236-1-jasowang@redhat.com>
References: <20211019070152.8236-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: "Paul E . McKenney" <paulmck@kernel.org>, david.kaplan@amd.com,
 konrad.wilk@oracle.com, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
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

This patch tries to make sure the virtio interrupt handler for INTX
won't be called after a reset and before virtio_device_ready(). We
can't use IRQF_NO_AUTOEN since we're using shared interrupt
(IRQF_SHARED). So this patch tracks the INTX enabling status in a new
intx_soft_enabled variable and toggle it during in
vp_disable/enable_vectors(). The INTX interrupt handler will check
intx_soft_enabled before processing the actual interrupt.

Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 23 +++++++++++++++++++++--
 drivers/virtio/virtio_pci_common.h |  1 +
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 8d8f83aca721..1bce254a462a 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -30,8 +30,16 @@ void vp_disable_cbs(struct virtio_device *vdev)
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	int i;
 
-	if (vp_dev->intx_enabled)
+	if (vp_dev->intx_enabled) {
+		/*
+		 * The below synchronize() guarantees that any
+		 * interrupt for this line arriving after
+		 * synchronize_irq() has completed is guaranteed to see
+		 * intx_soft_enabled == false.
+		 */
+		WRITE_ONCE(vp_dev->intx_soft_enabled, false);
 		synchronize_irq(vp_dev->pci_dev->irq);
+	}
 
 	for (i = 0; i < vp_dev->msix_vectors; ++i)
 		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
@@ -43,8 +51,16 @@ void vp_enable_cbs(struct virtio_device *vdev)
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	int i;
 
-	if (vp_dev->intx_enabled)
+	if (vp_dev->intx_enabled) {
+		disable_irq(vp_dev->pci_dev->irq);
+		/*
+		 * The above disable_irq() provides TSO ordering and
+		 * as such promotes the below store to store-release.
+		 */
+		WRITE_ONCE(vp_dev->intx_soft_enabled, true);
+		enable_irq(vp_dev->pci_dev->irq);
 		return;
+	}
 
 	for (i = 0; i < vp_dev->msix_vectors; ++i)
 		enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
@@ -97,6 +113,9 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 	struct virtio_pci_device *vp_dev = opaque;
 	u8 isr;
 
+	if (!READ_ONCE(vp_dev->intx_soft_enabled))
+		return IRQ_NONE;
+
 	/* reading the ISR has the effect of also clearing it so it's very
 	 * important to save off the value. */
 	isr = ioread8(vp_dev->isr);
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 52e924603075..7b59e10063c3 100644
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
