Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084EBCCA47A
	for <virtualization@archiver.kernel.org>; Mon, 20 Jun 2022 02:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 752F682F39;
	Mon, 20 Jun 2022 02:42:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 752F682F39
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HXDz325o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2ErvEOwUvahr; Mon, 20 Jun 2022 02:42:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CFDC882ECF;
	Mon, 20 Jun 2022 02:42:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CFDC882ECF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B9CBC0039;
	Mon, 20 Jun 2022 02:42:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91739C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 02:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D2AA82EDB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 02:42:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D2AA82EDB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3fZLSlTWKvYr
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 02:42:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2927F82ECF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2927F82ECF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 02:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655692934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/oknfccPAIxyEAuYdT4y1IrsCu7NWdjJuGzW6X5z710=;
 b=HXDz325oPXHTNJoGVdKbvLFRUtJihHyHUxPOLeOQmFKIhMsGJRXCsbiRp1JecyYyk8f7ll
 7MNxPw5PsFXNEFL9+tSlX2wlS0AYx0eaGZ3OtMBcdrAq0tWw2VQp+9PWUexZSXBWQVqMvT
 l6yVNUlL3HyhZeQHAwbJDBJp1EfgxY8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-ROevF3OlOLOOELPM_umplw-1; Sun, 19 Jun 2022 22:42:06 -0400
X-MC-Unique: ROevF3OlOLOOELPM_umplw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66EDE101A56C;
 Mon, 20 Jun 2022 02:42:05 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-16.pek2.redhat.com [10.72.12.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CB65C08087;
 Mon, 20 Jun 2022 02:42:00 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: cohuck@redhat.com, pasic@linux.ibm.com, jasowang@redhat.com, mst@redhat.com
Subject: [PATCH V2] virtio: disable notification hardening by default
Date: Mon, 20 Jun 2022 10:41:58 +0800
Message-Id: <20220620024158.2505-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Cc: linux-s390@vger.kernel.org, gor@linux.ibm.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 borntraeger@de.ibm.com, agordeev@linux.ibm.com
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

We try to harden virtio device notifications in 8b4ec69d7e09 ("virtio:
harden vring IRQ"). It works with the assumption that the driver or
core can properly call virtio_device_ready() at the right
place. Unfortunately, this seems to be not true and uncover various
bugs of the existing drivers, mainly the issue of using
virtio_device_ready() incorrectly.

So let's having a Kconfig option and disable it by default. It gives
us a breath to fix the drivers and then we can consider to enable it
by default.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes since V1:
- tweak the Kconfig prompt
- don't hold spinlock for IRQ path in s390
---
 drivers/s390/virtio/virtio_ccw.c |  4 ++++
 drivers/virtio/Kconfig           | 11 +++++++++++
 drivers/virtio/virtio.c          |  2 ++
 drivers/virtio/virtio_ring.c     | 12 ++++++++++++
 include/linux/virtio_config.h    |  2 ++
 5 files changed, 31 insertions(+)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 97e51c34e6cf..89bbf7ccfdd1 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -1136,8 +1136,10 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 			vcdev->err = -EIO;
 	}
 	virtio_ccw_check_activity(vcdev, activity);
+#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
 	/* Interrupts are disabled here */
 	read_lock(&vcdev->irq_lock);
+#endif
 	for_each_set_bit(i, indicators(vcdev),
 			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
 		/* The bit clear must happen before the vring kick. */
@@ -1146,7 +1148,9 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 		vq = virtio_ccw_vq_by_ind(vcdev, i);
 		vring_interrupt(0, vq);
 	}
+#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
 	read_unlock(&vcdev->irq_lock);
+#endif
 	if (test_bit(0, indicators2(vcdev))) {
 		virtio_config_changed(&vcdev->vdev);
 		clear_bit(0, indicators2(vcdev));
diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index b5adf6abd241..96ec56d44b91 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -35,6 +35,17 @@ menuconfig VIRTIO_MENU
 
 if VIRTIO_MENU
 
+config VIRTIO_HARDEN_NOTIFICATION
+        bool "Harden virtio notification"
+        help
+          Enable this to harden the device notifications and supress
+          the ones that are illegal.
+
+          Experimental: not all drivers handle this correctly at this
+          point.
+
+          If unsure, say N.
+
 config VIRTIO_PCI
 	tristate "PCI driver for virtio devices"
 	depends on PCI
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index ef04a96942bf..21dc08d2f32d 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -220,6 +220,7 @@ static int virtio_features_ok(struct virtio_device *dev)
  * */
 void virtio_reset_device(struct virtio_device *dev)
 {
+#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
 	/*
 	 * The below virtio_synchronize_cbs() guarantees that any
 	 * interrupt for this line arriving after
@@ -228,6 +229,7 @@ void virtio_reset_device(struct virtio_device *dev)
 	 */
 	virtio_break_device(dev);
 	virtio_synchronize_cbs(dev);
+#endif
 
 	dev->config->reset(dev);
 }
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 13a7348cedff..d9d3b6e201fb 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1688,7 +1688,11 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->we_own_ring = true;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
+#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
 	vq->broken = true;
+#else
+	vq->broken = false;
+#endif
 	vq->last_used_idx = 0;
 	vq->event_triggered = false;
 	vq->num_added = 0;
@@ -2135,9 +2139,13 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 	}
 
 	if (unlikely(vq->broken)) {
+#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
 		dev_warn_once(&vq->vq.vdev->dev,
 			      "virtio vring IRQ raised before DRIVER_OK");
 		return IRQ_NONE;
+#else
+		return IRQ_HANDLED;
+#endif
 	}
 
 	/* Just a hint for performance: so it's ok that this can be racy! */
@@ -2180,7 +2188,11 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->we_own_ring = false;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
+#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
 	vq->broken = true;
+#else
+	vq->broken = false;
+#endif
 	vq->last_used_idx = 0;
 	vq->event_triggered = false;
 	vq->num_added = 0;
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 9a36051ceb76..d15c3cdda2d2 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -257,6 +257,7 @@ void virtio_device_ready(struct virtio_device *dev)
 
 	WARN_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
 
+#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
 	/*
 	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
 	 * will see the driver specific setup if it sees vq->broken
@@ -264,6 +265,7 @@ void virtio_device_ready(struct virtio_device *dev)
 	 */
 	virtio_synchronize_cbs(dev);
 	__virtio_unbreak_device(dev);
+#endif
 	/*
 	 * The transport should ensure the visibility of vq->broken
 	 * before setting DRIVER_OK. See the comments for the transport
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
