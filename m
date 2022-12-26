Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A50C46467
	for <virtualization@archiver.kernel.org>; Mon, 26 Dec 2022 07:49:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 724D340376;
	Mon, 26 Dec 2022 07:49:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 724D340376
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g07FrQHu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qpW9_wVD2en1; Mon, 26 Dec 2022 07:49:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E4DA240104;
	Mon, 26 Dec 2022 07:49:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E4DA240104
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C92FAC0035;
	Mon, 26 Dec 2022 07:49:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C163BC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 07:49:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F47680D6B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 07:49:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F47680D6B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=g07FrQHu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jm4CC3NakxG8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 07:49:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC95B80C3B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CC95B80C3B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 07:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672040974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H/Y/p/qkj6rtja+GTIriOAzlecVLNXF/oN1BvsWBKKY=;
 b=g07FrQHuFKizmKBDHbtKSII5lRBSZWY/oaSQTCPKwDZaKYy3sOftsoG27E+EH1paIp/Be6
 2MD8T1Pv5Lir6o8aqUxrueo2rKjGKCxY532Wj09JyV3XHb7jNODO1DMopPcK5+6uVEWgC3
 ZvPUQ5j9o/cvQEdQmCQ1zhJyv9eorDE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-Cl6FKtC-O92R4jqHTvdGlQ-1; Mon, 26 Dec 2022 02:49:31 -0500
X-MC-Unique: Cl6FKtC-O92R4jqHTvdGlQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DD1A101A521;
 Mon, 26 Dec 2022 07:49:31 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-100.pek2.redhat.com
 [10.72.13.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7642D492B00;
 Mon, 26 Dec 2022 07:49:26 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
Date: Mon, 26 Dec 2022 15:49:07 +0800
Message-Id: <20221226074908.8154-4-jasowang@redhat.com>
In-Reply-To: <20221226074908.8154-1-jasowang@redhat.com>
References: <20221226074908.8154-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

This patch introduces a per virtqueue waitqueue to allow driver to
sleep and wait for more used. Two new helpers are introduced to allow
driver to sleep and wake up.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes since V1:
- check virtqueue_is_broken() as well
- use more_used() instead of virtqueue_get_buf() to allow caller to
  get buffers afterwards
---
 drivers/virtio/virtio_ring.c | 29 +++++++++++++++++++++++++++++
 include/linux/virtio.h       |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5cfb2fa8abee..9c83eb945493 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -13,6 +13,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/kmsan.h>
 #include <linux/spinlock.h>
+#include <linux/wait.h>
 #include <xen/xen.h>
 
 #ifdef DEBUG
@@ -60,6 +61,7 @@
 			"%s:"fmt, (_vq)->vq.name, ##args);	\
 		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */ \
 		WRITE_ONCE((_vq)->broken, true);		       \
+		wake_up_interruptible(&(_vq)->wq);		       \
 	} while (0)
 #define START_USE(vq)
 #define END_USE(vq)
@@ -203,6 +205,9 @@ struct vring_virtqueue {
 	/* DMA, allocation, and size information */
 	bool we_own_ring;
 
+	/* Wait for buffer to be used */
+	wait_queue_head_t wq;
+
 #ifdef DEBUG
 	/* They're supposed to lock for us. */
 	unsigned int in_use;
@@ -2024,6 +2029,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
 		vq->weak_barriers = false;
 
+	init_waitqueue_head(&vq->wq);
+
 	err = vring_alloc_state_extra_packed(&vring_packed);
 	if (err)
 		goto err_state_extra;
@@ -2517,6 +2524,8 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
 		vq->weak_barriers = false;
 
+	init_waitqueue_head(&vq->wq);
+
 	err = vring_alloc_state_extra_split(vring_split);
 	if (err) {
 		kfree(vq);
@@ -2654,6 +2663,8 @@ static void vring_free(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
+	wake_up_interruptible(&vq->wq);
+
 	if (vq->we_own_ring) {
 		if (vq->packed_ring) {
 			vring_free_queue(vq->vq.vdev,
@@ -2863,4 +2874,22 @@ const struct vring *virtqueue_get_vring(struct virtqueue *vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_vring);
 
+int virtqueue_wait_for_used(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	/* TODO: Tweak the timeout. */
+	return wait_event_interruptible_timeout(vq->wq,
+	       virtqueue_is_broken(_vq) || more_used(vq), HZ);
+}
+EXPORT_SYMBOL_GPL(virtqueue_wait_for_used);
+
+void virtqueue_wake_up(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	wake_up_interruptible(&vq->wq);
+}
+EXPORT_SYMBOL_GPL(virtqueue_wake_up);
+
 MODULE_LICENSE("GPL");
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index dcab9c7e8784..2eb62c774895 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -72,6 +72,9 @@ void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
 void *virtqueue_get_buf_ctx(struct virtqueue *vq, unsigned int *len,
 			    void **ctx);
 
+int virtqueue_wait_for_used(struct virtqueue *vq);
+void virtqueue_wake_up(struct virtqueue *vq);
+
 void virtqueue_disable_cb(struct virtqueue *vq);
 
 bool virtqueue_enable_cb(struct virtqueue *vq);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
