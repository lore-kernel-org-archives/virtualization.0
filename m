Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A54AC433EF
	for <virtualization@archiver.kernel.org>; Wed,  6 Apr 2022 08:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 23D404027A;
	Wed,  6 Apr 2022 08:36:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gmxS-om1TSC9; Wed,  6 Apr 2022 08:36:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9E72340193;
	Wed,  6 Apr 2022 08:36:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77BC1C002C;
	Wed,  6 Apr 2022 08:36:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7065C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 08:36:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B2F9C417C4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 08:36:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z9nsuxYE0rCn
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 08:36:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B0405417C3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 08:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649234201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXRl5yVraFjtAHNeuo8Tj/7VeEPbPvmJda7LXPVTN00=;
 b=RikE92o/kxvWj/75Bxg+5qCSXgMeey8Qg6d3qciE8i9a0yibFBXxNWiBSr6ZfJ/wqIoq/p
 mpHk5XDGV45RM3z5YI4lvPi+21VpuL8mjV6EIRu+PT7/TBsHe8kQg6Pt9h3FyTPKEiJpaJ
 dAYcwlMbYR3/6h5l4F0CwnBijmdw/6E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-ipVoKGptOI24T9gwiW2-gA-1; Wed, 06 Apr 2022 04:36:38 -0400
X-MC-Unique: ipVoKGptOI24T9gwiW2-gA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBC763822204;
 Wed,  6 Apr 2022 08:36:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-58.pek2.redhat.com [10.72.12.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97A9F1121319;
 Wed,  6 Apr 2022 08:36:20 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 5/5] virtio: harden vring IRQ
Date: Wed,  6 Apr 2022 16:35:38 +0800
Message-Id: <20220406083538.16274-6-jasowang@redhat.com>
In-Reply-To: <20220406083538.16274-1-jasowang@redhat.com>
References: <20220406083538.16274-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Cc: "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
 maz@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, tglx@linutronix.de
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
by introducing a global device_ready variable for each
virtio_device. Then we can to toggle it during
virtio_reset_device()/virtio_device_ready(). A
virtio_synchornize_vqs() is used in both virtio_device_ready() and
virtio_reset_device() to synchronize with the vring callbacks. With
this, vring_interrupt() can return check and early if driver_ready is
false.

Note that the hardening is only done for vring interrupt since the
config interrupt hardening is already done in commit 22b7050a024d7
("virtio: defer config changed notifications"). But the method that is
used by config interrupt can't be reused by the vring interrupt
handler because it uses spinlock to do the synchronization which is
expensive.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio.c       | 11 +++++++++++
 drivers/virtio/virtio_ring.c  |  9 ++++++++-
 include/linux/virtio.h        |  2 ++
 include/linux/virtio_config.h |  8 ++++++++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 8dde44ea044a..2f3a6f8e3d9c 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -220,6 +220,17 @@ static int virtio_features_ok(struct virtio_device *dev)
  * */
 void virtio_reset_device(struct virtio_device *dev)
 {
+	if (READ_ONCE(dev->driver_ready)) {
+		/*
+		 * The below virtio_synchronize_vqs() guarantees that any
+		 * interrupt for this line arriving after
+		 * virtio_synchronize_vqs() has completed is guaranteed to see
+		 * driver_ready == false.
+		 */
+		WRITE_ONCE(dev->driver_ready, false);
+		virtio_synchronize_vqs(dev);
+	}
+
 	dev->config->reset(dev);
 }
 EXPORT_SYMBOL_GPL(virtio_reset_device);
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cfb028ca238e..a4592e55c9f8 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2127,10 +2127,17 @@ static inline bool more_used(const struct vring_virtqueue *vq)
 	return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
 }
 
-irqreturn_t vring_interrupt(int irq, void *_vq)
+irqreturn_t vring_interrupt(int irq, void *v)
 {
+	struct virtqueue *_vq = v;
+	struct virtio_device *vdev = _vq->vdev;
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
+	if (!READ_ONCE(vdev->driver_ready)) {
+		dev_warn_once(&vdev->dev, "virtio vring IRQ raised before DRIVER_OK");
+		return IRQ_NONE;
+	}
+
 	if (!more_used(vq)) {
 		pr_debug("virtqueue interrupt with no work for %p\n", vq);
 		return IRQ_NONE;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 5464f398912a..dfa2638a293e 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -95,6 +95,7 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
  * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for restore)
  * @config_enabled: configuration change reporting enabled
  * @config_change_pending: configuration change reported while disabled
+ * @driver_ready: whehter the driver is ready (e.g for vring callbacks)
  * @config_lock: protects configuration change reporting
  * @dev: underlying device.
  * @id: the device type identification (used to match it with a driver).
@@ -109,6 +110,7 @@ struct virtio_device {
 	bool failed;
 	bool config_enabled;
 	bool config_change_pending;
+	bool driver_ready;
 	spinlock_t config_lock;
 	spinlock_t vqs_list_lock; /* Protects VQs list access */
 	struct device dev;
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 08b73d9bbff2..c9e207bf2c9c 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -246,6 +246,14 @@ void virtio_device_ready(struct virtio_device *dev)
 {
 	unsigned status = dev->config->get_status(dev);
 
+	virtio_synchronize_vqs(dev);
+        /*
+         * The above virtio_synchronize_vqs() make sure
+         * vring_interrupt() will see the driver specific setup if it
+         * see driver_ready as true.
+         */
+	WRITE_ONCE(dev->driver_ready, true);
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
