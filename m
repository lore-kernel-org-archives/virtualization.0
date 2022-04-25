Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A422C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Apr 2022 02:46:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0F81E401B7;
	Mon, 25 Apr 2022 02:46:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RV0St33fEukU; Mon, 25 Apr 2022 02:46:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8D19D40112;
	Mon, 25 Apr 2022 02:46:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6653CC0039;
	Mon, 25 Apr 2022 02:46:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 776E8C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 02:46:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 652DF819D2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 02:46:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M2XaKVoweenl
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 02:46:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 79E0F81A39
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 02:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650854765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=227dRco3LciEMlYpAOelI9La2vayTwzPn6lkq/Y4WKA=;
 b=QndhI8IRkzV+p+SzM1sHxJAz7ddwJH+wI9EWS2FNP2uQGakFl06K663iWqZJyMpX1Bbr13
 /oe3WaKeex0qSSkrBqvWy6TEh7LcorHDRvsx9HKahjrQ6l303U19YWPYH7CONQSPVCfAuY
 QW0e8z2EFFBjD/2arurr7ND5fsSn1SE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-knYGpcPIMFW66DIkLynGAw-1; Sun, 24 Apr 2022 22:46:04 -0400
X-MC-Unique: knYGpcPIMFW66DIkLynGAw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 248AB82A682;
 Mon, 25 Apr 2022 02:46:03 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-160.pek2.redhat.com
 [10.72.13.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A91C97B7C;
 Mon, 25 Apr 2022 02:45:54 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH V3 8/9] virtio: harden vring IRQ
Date: Mon, 25 Apr 2022 10:44:17 +0800
Message-Id: <20220425024418.8415-9-jasowang@redhat.com>
In-Reply-To: <20220425024418.8415-1-jasowang@redhat.com>
References: <20220425024418.8415-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Cc: lulu@redhat.com, paulmck@kernel.org, peterz@infradead.org, maz@kernel.org,
 cohuck@redhat.com, pasic@linux.ibm.com, eperezma@redhat.com,
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

The vq->broken is re-used in this patch for implementing the IRQ
hardening. The vq->broken is set to true during both initialization
and reset. And the vq->broken is set to false in
virtio_device_ready(). Then vring_interrupt can check and return when
vq->broken is true. And in this case, switch to return IRQ_NONE to let
the interrupt core aware of such invalid interrupt to prevent IRQ
storm.

The reason of using a per queue variable instead of a per device one
is that we may need it for per queue reset hardening in the future.

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
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio.c       | 15 ++++++++++++---
 drivers/virtio/virtio_ring.c  | 11 +++++++----
 include/linux/virtio_config.h | 12 ++++++++++++
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 8dde44ea044a..f575df1f85d0 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -220,6 +220,15 @@ static int virtio_features_ok(struct virtio_device *dev)
  * */
 void virtio_reset_device(struct virtio_device *dev)
 {
+	/*
+	 * The below virtio_synchronize_cbs() guarantees that any
+	 * interrupt for this line arriving after
+	 * virtio_synchronize_vqs() has completed is guaranteed to see
+	 * driver_ready == false.
+	 */
+	virtio_break_device(dev, true);
+	virtio_synchronize_cbs(dev);
+
 	dev->config->reset(dev);
 }
 EXPORT_SYMBOL_GPL(virtio_reset_device);
@@ -428,6 +437,9 @@ int register_virtio_device(struct virtio_device *dev)
 	dev->config_enabled = false;
 	dev->config_change_pending = false;
 
+	INIT_LIST_HEAD(&dev->vqs);
+	spin_lock_init(&dev->vqs_list_lock);
+
 	/* We always start by resetting the device, in case a previous
 	 * driver messed it up.  This also tests that code path a little. */
 	virtio_reset_device(dev);
@@ -435,9 +447,6 @@ int register_virtio_device(struct virtio_device *dev)
 	/* Acknowledge that we've seen the device. */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
 
-	INIT_LIST_HEAD(&dev->vqs);
-	spin_lock_init(&dev->vqs_list_lock);
-
 	/*
 	 * device_add() causes the bus infrastructure to look for a matching
 	 * driver.
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6da13495a70c..12f5fe2ee8ef 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1690,7 +1690,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->we_own_ring = true;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
-	vq->broken = false;
+	vq->broken = true;
 	vq->last_used_idx = 0;
 	vq->event_triggered = false;
 	vq->num_added = 0;
@@ -2136,8 +2136,11 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 		return IRQ_NONE;
 	}
 
-	if (unlikely(vq->broken))
-		return IRQ_HANDLED;
+	if (unlikely(vq->broken)) {
+		dev_warn_once(&vq->vq.vdev->dev,
+			      "virtio vring IRQ raised before DRIVER_OK");
+		return IRQ_NONE;
+	}
 
 	/* Just a hint for performance: so it's ok that this can be racy! */
 	if (vq->event)
@@ -2179,7 +2182,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->we_own_ring = false;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
-	vq->broken = false;
+	vq->broken = true;
 	vq->last_used_idx = 0;
 	vq->event_triggered = false;
 	vq->num_added = 0;
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 14fe89ff99c7..3e2bc8aff51e 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -255,6 +255,18 @@ void virtio_device_ready(struct virtio_device *dev)
 	unsigned status = dev->config->get_status(dev);
 
 	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
+
+	/*
+	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
+	 * will see the driver specific setup if it sees vq->broken
+	 * as false.
+	 */
+	virtio_synchronize_cbs(dev);
+	virtio_break_device(dev, false);
+	/*
+	 * The transport is expected ensure the visibility of
+	 * vq->broken before setting VIRTIO_CONFIG_S_DRIVER_OK.
+	 */
 	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
 }
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
