Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7561EC4332F
	for <virtualization@archiver.kernel.org>; Thu, 22 Dec 2022 06:05:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEE6481F24;
	Thu, 22 Dec 2022 06:05:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EEE6481F24
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U/l7PCNO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UmDcwiOQWwZ9; Thu, 22 Dec 2022 06:05:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6CF7581EF2;
	Thu, 22 Dec 2022 06:05:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6CF7581EF2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42B3BC0071;
	Thu, 22 Dec 2022 06:05:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A9B3C0070
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 06:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 45FC9403E5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 06:05:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 45FC9403E5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=U/l7PCNO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AzqrWIaThO53
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 06:05:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8944240153
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8944240153
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 06:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671689099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3AagJqkYYDM80wKW6v4HoTlfL3zWbTRSgD3VOT9tZZo=;
 b=U/l7PCNOVp5nEdyFhIRzM4RFzXTa4SnKcHX7sJ066Dz+YP6QVY1F8QurLT3V00XSKfy6yd
 9ppY0H0MP+HLt4o7qIVokekQ9aMOqljcugr87n6hzR/54idceEwmEHS5HBvxDkqX67C3xY
 65VGP+aE72nKqbd84DPPGGK+zfhnbKc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-LoPDdRuFMEmvKTedKAP_YA-1; Thu, 22 Dec 2022 01:04:55 -0500
X-MC-Unique: LoPDdRuFMEmvKTedKAP_YA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D0341C04B79;
 Thu, 22 Dec 2022 06:04:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-179.pek2.redhat.com
 [10.72.13.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B80E112132C;
 Thu, 22 Dec 2022 06:04:49 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [RFC PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
Date: Thu, 22 Dec 2022 14:04:26 +0800
Message-Id: <20221222060427.21626-4-jasowang@redhat.com>
In-Reply-To: <20221222060427.21626-1-jasowang@redhat.com>
References: <20221222060427.21626-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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
 drivers/virtio/virtio_ring.c | 31 +++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  4 ++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 90c2034a77f3..4a2d5ac30b0f 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -13,6 +13,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/kmsan.h>
 #include <linux/spinlock.h>
+#include <linux/wait.h>
 #include <xen/xen.h>
 
 #ifdef DEBUG
@@ -59,6 +60,7 @@
 		dev_err(&_vq->vq.vdev->dev,			\
 			"%s:"fmt, (_vq)->vq.name, ##args);	\
 		(_vq)->broken = true;				\
+		wake_up_interruptible(&(_vq)->wq);		\
 	} while (0)
 #define START_USE(vq)
 #define END_USE(vq)
@@ -202,6 +204,9 @@ struct vring_virtqueue {
 	/* DMA, allocation, and size information */
 	bool we_own_ring;
 
+	/* Wait for buffer to be used */
+	wait_queue_head_t wq;
+
 #ifdef DEBUG
 	/* They're supposed to lock for us. */
 	unsigned int in_use;
@@ -2023,6 +2028,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
 		vq->weak_barriers = false;
 
+	init_waitqueue_head(&vq->wq);
+
 	err = vring_alloc_state_extra_packed(&vring_packed);
 	if (err)
 		goto err_state_extra;
@@ -2516,6 +2523,8 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
 		vq->weak_barriers = false;
 
+	init_waitqueue_head(&vq->wq);
+
 	err = vring_alloc_state_extra_split(vring_split);
 	if (err) {
 		kfree(vq);
@@ -2653,6 +2662,8 @@ static void vring_free(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
+	wake_up_interruptible(&vq->wq);
+
 	if (vq->we_own_ring) {
 		if (vq->packed_ring) {
 			vring_free_queue(vq->vq.vdev,
@@ -2863,4 +2874,24 @@ const struct vring *virtqueue_get_vring(struct virtqueue *vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_vring);
 
+int virtqueue_wait_for_used(struct virtqueue *_vq,
+			    unsigned int *len)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	/* Use a better timeout or simply start from no timeout */
+	return wait_event_interruptible_timeout(vq->wq,
+						virtqueue_get_buf(_vq, len),
+						HZ);
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
index dcab9c7e8784..4df098b8f1ca 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -72,6 +72,10 @@ void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
 void *virtqueue_get_buf_ctx(struct virtqueue *vq, unsigned int *len,
 			    void **ctx);
 
+int virtqueue_wait_for_used(struct virtqueue *vq,
+			    unsigned int *len);
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
