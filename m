Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2FECCA479
	for <virtualization@archiver.kernel.org>; Fri, 17 Jun 2022 07:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E834940A09;
	Fri, 17 Jun 2022 07:26:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E834940A09
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ctD5eM55
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q-QLPk62970m; Fri, 17 Jun 2022 07:26:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6D639409D7;
	Fri, 17 Jun 2022 07:26:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6D639409D7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A76EC0039;
	Fri, 17 Jun 2022 07:26:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB747C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 07:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D7404026E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 07:26:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D7404026E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ctD5eM55
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id szKsgEsEcldB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 07:26:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6557640248
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6557640248
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 07:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655450795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=v1OzxUTdVxm25FyB56AWfj0qHOMIBXGWkHMr1WYBfyA=;
 b=ctD5eM550QlkuYp9dKkZZSiJ9bLVj5Ficba/1fdMFfrUlsJoq4RdvYYEoDR7RzMt40IG/g
 /9T6ics5yt0nZx6Zx9q3cAQjPfD3H4UZsjmZtWwExa7UUwUKVzB8wBnd7mAf+Luxg4yhhH
 bQ12MKRbe4lICiSmaYX+/5PSNXDzJjI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-h6hkhi_fM2KAFgmeglqjfw-1; Fri, 17 Jun 2022 03:26:31 -0400
X-MC-Unique: h6hkhi_fM2KAFgmeglqjfw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 180A4101AA46;
 Fri, 17 Jun 2022 07:26:31 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-87.pek2.redhat.com [10.72.13.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0694910725;
 Fri, 17 Jun 2022 07:26:28 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] virtio: disable notification hardening by default
Date: Fri, 17 Jun 2022 15:26:26 +0800
Message-Id: <20220617072626.30503-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
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
 drivers/virtio/Kconfig        |  6 ++++++
 drivers/virtio/virtio.c       |  2 ++
 drivers/virtio/virtio_ring.c  | 12 ++++++++++++
 include/linux/virtio_config.h |  2 ++
 4 files changed, 22 insertions(+)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index b5adf6abd241..b059c39af3d4 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -35,6 +35,12 @@ menuconfig VIRTIO_MENU
 
 if VIRTIO_MENU
 
+config VIRTIO_HARDEN_NOTIFICATION
+        bool "Harden virtio notification"
+        help
+          Enable to this to harden the device notifications and
+          supress the ones that are illegal.
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
