Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A62C433F5
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 06:30:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4EA014021F;
	Thu, 25 Nov 2021 06:30:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fn3VTzYi1vtx; Thu, 25 Nov 2021 06:30:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 854E240018;
	Thu, 25 Nov 2021 06:30:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 579E8C0038;
	Thu, 25 Nov 2021 06:30:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAA8EC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 06:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 93E7E608C3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 06:30:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YQamujt3XTc5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 06:30:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D9147608C2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 06:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637821841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2/MroL6oE5BBVYn3KMhwEVkq/8JZw+Q6u+jWrdIUJT8=;
 b=h2XdapUCAGgpN/Gn5G325Phea8clEmEejxqHeFJcKEbSzE/yEr5AIx9u/kBvoWbMU02gF1
 e2OpMHJd7Kt4NVpTjdfUg8lF1ZjpAexYgh4Vwy/ywW7zMmCucK2efkUVKwnmhhnbkj08jl
 UpvjFXFGtj64ZtDfdPxqzj7d+yyYHOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-qBrVQiU3P3yZvxS14D-HYw-1; Thu, 25 Nov 2021 01:30:39 -0500
X-MC-Unique: qBrVQiU3P3yZvxS14D-HYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B21831927800;
 Thu, 25 Nov 2021 06:30:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-162.pek2.redhat.com
 [10.72.12.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1C745D9C0;
 Thu, 25 Nov 2021 06:30:36 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] virtio-mmio: harden interrupt
Date: Thu, 25 Nov 2021 14:30:34 +0800
Message-Id: <20211125063034.12347-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

This patch tries to make sure the virtio interrupt handler for MMIO
won't be called after a reset and before virtio_device_ready(). We
can't use IRQF_NO_AUTOEN since we're using shared interrupt
(IRQF_SHARED). So this patch tracks the interrupt enabling status in a
new intr_soft_enabled variable and toggle it during in
vm_disable/enable_interrupts(). The MMIO interrupt handler will check
intr_soft_enabled before processing the actual interrupt.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_mmio.c | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 56128b9c46eb..796f0c789b09 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -90,6 +90,7 @@ struct virtio_mmio_device {
 	/* a list of queues so we can dispatch IRQs */
 	spinlock_t lock;
 	struct list_head virtqueues;
+	bool intr_soft_enabled;
 };
 
 struct virtio_mmio_vq_info {
@@ -100,7 +101,37 @@ struct virtio_mmio_vq_info {
 	struct list_head node;
 };
 
+/* disable irq handlers */
+void vm_disable_cbs(struct virtio_device *vdev)
+{
+	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+	int irq = platform_get_irq(vm_dev->pdev, 0);
 
+	/*
+	 * The below synchronize() guarantees that any
+	 * interrupt for this line arriving after
+	 * synchronize_irq() has completed is guaranteed to see
+	 * intx_soft_enabled == false.
+	 */
+	WRITE_ONCE(vm_dev->intr_soft_enabled, false);
+	synchronize_irq(irq);
+}
+
+/* enable irq handlers */
+void vm_enable_cbs(struct virtio_device *vdev)
+{
+	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+	int irq = platform_get_irq(vm_dev->pdev, 0);
+
+	disable_irq(irq);
+	/*
+	 * The above disable_irq() provides TSO ordering and
+	 * as such promotes the below store to store-release.
+	 */
+	WRITE_ONCE(vm_dev->intr_soft_enabled, true);
+	enable_irq(irq);
+	return;
+}
 
 /* Configuration interface */
 
@@ -262,6 +293,8 @@ static void vm_reset(struct virtio_device *vdev)
 
 	/* 0 status means a reset. */
 	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
+	/* Disable VQ/configuration callbacks. */
+	vm_disable_cbs(vdev);
 }
 
 
@@ -288,6 +321,9 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
 	unsigned long flags;
 	irqreturn_t ret = IRQ_NONE;
 
+	if (!READ_ONCE(vm_dev->intr_soft_enabled))
+		return IRQ_NONE;
+
 	/* Read and acknowledge interrupts */
 	status = readl(vm_dev->base + VIRTIO_MMIO_INTERRUPT_STATUS);
 	writel(status, vm_dev->base + VIRTIO_MMIO_INTERRUPT_ACK);
@@ -529,6 +565,7 @@ static bool vm_get_shm_region(struct virtio_device *vdev,
 }
 
 static const struct virtio_config_ops virtio_mmio_config_ops = {
+	.enable_cbs     = vm_enable_cbs,
 	.get		= vm_get,
 	.set		= vm_set,
 	.generation	= vm_generation,
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
