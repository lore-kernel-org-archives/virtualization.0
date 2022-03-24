Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4945DC433F5
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 08:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBC0860D5A;
	Thu, 24 Mar 2022 08:40:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lIwXjfckhL3O; Thu, 24 Mar 2022 08:40:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5795A60C2B;
	Thu, 24 Mar 2022 08:40:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1973DC001A;
	Thu, 24 Mar 2022 08:40:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C25FCC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A411B41859
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:40:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oJ6tC4wJWk4o
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:40:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF1C441856
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648111242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0iOPye1X7Vtyc3J8stsAHjudlMNGe87EZLWi7Y1Xry4=;
 b=OeLXwvJliaDvj2mYsmKv64cxRRkNIyjq48Rs2EdelOD6icnCKf4Rl3hEdRt4L03e7CBnaC
 qAwQ/JriKFjpGyf40OsMJApGhFU108CiZgMPAKH7YhVYx5DM0DIWIt+5S0DDSzw5az+NKw
 IkJ8GdnZNVSGqLLn9goj/BacWpKmYBk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-6zlLP0GmNDKs0IBkNsupOQ-1; Thu, 24 Mar 2022 04:40:39 -0400
X-MC-Unique: 6zlLP0GmNDKs0IBkNsupOQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC08585A5BC;
 Thu, 24 Mar 2022 08:40:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-240.pek2.redhat.com
 [10.72.13.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2E7740CF8ED;
 Thu, 24 Mar 2022 08:40:34 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 3/3] virtio: harden vring IRQ
Date: Thu, 24 Mar 2022 16:40:04 +0800
Message-Id: <20220324084004.14349-4-jasowang@redhat.com>
In-Reply-To: <20220324084004.14349-1-jasowang@redhat.com>
References: <20220324084004.14349-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Cc: peterz@infradead.org, maz@kernel.org, keirf@google.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 tglx@linutronix.de
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

This is a rework on the previous IRQ hardening that is done for
virtio-pci where several drawbacks were found and were reverted:

1) try to use IRQF_NO_AUTOEN which is not friendly to affinity managed IRQ
   that is used by some device such as virtio-blk
2) done only for PCI transport

In this patch, we tries to borrow the idea from the INTX IRQ hardening
in the reverted commit 080cd7c3ac87 ("virtio-pci: harden INTX interrupts")
by introducing a global irq_soft_enabled variable for each
virtio_device. Then we can to toggle it during
virtio_reset_device()/virtio_device_ready(). A synchornize_rcu() is
used in virtio_reset_device() to synchronize with the IRQ handlers. In
the future, we may provide config_ops for the transport that doesn't
use IRQ. With this, vring_interrupt() can return check and early if
irq_soft_enabled is false. This lead to smp_load_acquire() to be used
but the cost should be acceptable.

To avoid breaking legacy device which can send IRQ before DRIVER_OK, a
module parameter is introduced to enable the hardening so function
hardening is disabled by default.

Note that the hardening is only done for vring interrupt since the
config interrupt hardening is already done in commit 22b7050a024d7
("virtio: defer config changed notifications"). But the method that is
used by config interrupt can't be reused by the vring interrupt
handler because it uses spinlock to do the synchronization which is
expensive.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio.c       | 19 +++++++++++++++++++
 drivers/virtio/virtio_ring.c  |  9 ++++++++-
 include/linux/virtio.h        |  4 ++++
 include/linux/virtio_config.h | 25 +++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 8dde44ea044a..85e331efa9cc 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -7,6 +7,12 @@
 #include <linux/of.h>
 #include <uapi/linux/virtio_ids.h>
 
+static bool irq_hardening = false;
+
+module_param(irq_hardening, bool, 0444);
+MODULE_PARM_DESC(irq_hardening,
+		 "Disalbe IRQ software processing when it is not expected");
+
 /* Unique numbering for virtio devices. */
 static DEFINE_IDA(virtio_index_ida);
 
@@ -220,6 +226,15 @@ static int virtio_features_ok(struct virtio_device *dev)
  * */
 void virtio_reset_device(struct virtio_device *dev)
 {
+	/*
+	 * The below synchronize_rcu() guarantees that any
+	 * interrupt for this line arriving after
+	 * synchronize_rcu() has completed is guaranteed to see
+	 * irq_soft_enabled == false.
+	 */
+	WRITE_ONCE(dev->irq_soft_enabled, false);
+	synchronize_rcu();
+
 	dev->config->reset(dev);
 }
 EXPORT_SYMBOL_GPL(virtio_reset_device);
@@ -427,6 +442,10 @@ int register_virtio_device(struct virtio_device *dev)
 	spin_lock_init(&dev->config_lock);
 	dev->config_enabled = false;
 	dev->config_change_pending = false;
+	dev->irq_soft_check = irq_hardening;
+
+	if (dev->irq_soft_check)
+		dev_info(&dev->dev, "IRQ hardening is enabled\n");
 
 	/* We always start by resetting the device, in case a previous
 	 * driver messed it up.  This also tests that code path a little. */
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 962f1477b1fa..0170f8c784d8 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2144,10 +2144,17 @@ static inline bool more_used(const struct vring_virtqueue *vq)
 	return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
 }
 
-irqreturn_t vring_interrupt(int irq, void *_vq)
+irqreturn_t vring_interrupt(int irq, void *v)
 {
+	struct virtqueue *_vq = v;
+	struct virtio_device *vdev = _vq->vdev;
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
+	if (!virtio_irq_soft_enabled(vdev)) {
+		dev_warn_once(&vdev->dev, "virtio vring IRQ raised before DRIVER_OK");
+		return IRQ_NONE;
+	}
+
 	if (!more_used(vq)) {
 		pr_debug("virtqueue interrupt with no work for %p\n", vq);
 		return IRQ_NONE;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 5464f398912a..957d6ad604ac 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -95,6 +95,8 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
  * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for restore)
  * @config_enabled: configuration change reporting enabled
  * @config_change_pending: configuration change reported while disabled
+ * @irq_soft_check: whether or not to check @irq_soft_enabled
+ * @irq_soft_enabled: callbacks enabled
  * @config_lock: protects configuration change reporting
  * @dev: underlying device.
  * @id: the device type identification (used to match it with a driver).
@@ -109,6 +111,8 @@ struct virtio_device {
 	bool failed;
 	bool config_enabled;
 	bool config_change_pending;
+	bool irq_soft_check;
+	bool irq_soft_enabled;
 	spinlock_t config_lock;
 	spinlock_t vqs_list_lock; /* Protects VQs list access */
 	struct device dev;
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index dafdc7f48c01..9c1b61f2e525 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -174,6 +174,24 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
 	return __virtio_test_bit(vdev, fbit);
 }
 
+/*
+ * virtio_irq_soft_enabled: whether we can execute callbacks
+ * @vdev: the device
+ */
+static inline bool virtio_irq_soft_enabled(const struct virtio_device *vdev)
+{
+	if (!vdev->irq_soft_check)
+		return true;
+
+	/*
+	 * Read irq_soft_enabled before reading other device specific
+	 * data. Paried with smp_store_relase() in
+	 * virtio_device_ready() and WRITE_ONCE()/synchronize_rcu() in
+	 * virtio_reset_device().
+	 */
+	return smp_load_acquire(&vdev->irq_soft_enabled);
+}
+
 /**
  * virtio_has_dma_quirk - determine whether this device has the DMA quirk
  * @vdev: the device
@@ -236,6 +254,13 @@ void virtio_device_ready(struct virtio_device *dev)
 	if (dev->config->enable_cbs)
                   dev->config->enable_cbs(dev);
 
+	/*
+	 * Commit the driver setup before enabling the virtqueue
+	 * callbacks. Paried with smp_load_acuqire() in
+	 * virtio_irq_soft_enabled()
+	 */
+	smp_store_release(&dev->irq_soft_enabled, true);
+
 	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
 	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
 }
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
