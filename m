Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6229C7EE23
	for <virtualization@archiver.kernel.org>; Fri, 26 May 2023 06:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47DDE83F96;
	Fri, 26 May 2023 06:30:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 47DDE83F96
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NY3JJAcy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BrdULCkKDreI; Fri, 26 May 2023 06:30:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A2F5B83EC0;
	Fri, 26 May 2023 06:30:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A2F5B83EC0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EA1DC0035;
	Fri, 26 May 2023 06:30:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 641C2C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:30:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 380B4403AA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:30:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 380B4403AA
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NY3JJAcy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qIjz0F_E8JEw
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:30:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3CFBD4016B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3CFBD4016B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685082650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EK+N0y/1dvECEUhDxhcais8MqSvPEEely1X6QH3wgtQ=;
 b=NY3JJAcyVDZ3Ql5lQLhKkVx9rmUdVAs035z/s6NJz2t8B1GLHgeB5UxXGInDdBGoFH/SYB
 6/udQH0XiWa1Cn/XUzGEPxM4ohjd9LtQPvGqQf7nKYuLRFIj31Cr6h1rEXdUT/BL6ZMRev
 Zv1HWT3PG6dX9XYQvN2eAMuUOUJJq7w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-3AQUEFLvM7Gx97Hqrv2koQ-1; Fri, 26 May 2023 02:30:46 -0400
X-MC-Unique: 3AQUEFLvM7Gx97Hqrv2koQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19BA280120A;
 Fri, 26 May 2023 06:30:46 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-104.pek2.redhat.com
 [10.72.13.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9415B2166B2B;
 Fri, 26 May 2023 06:30:43 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH] virtio_ring: validate used buffer length
Date: Fri, 26 May 2023 14:30:41 +0800
Message-Id: <20230526063041.18359-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

This patch validate the used buffer length provided by the device
before trying to use it. This is done by remembering the in buffer
length in a dedicated array during virtqueue_add(), then we can fail
the virtqueue_get_buf() when we find the device is trying to give us a
used buffer length which is greater than we stored before.

This validation is disable by default via module parameter to unbreak
some existing devices since some legacy devices are known to report
buggy used length.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes since V4:
- drop the flat for driver to suppress the check
- validation is disabled by default
- don't do validation for legacy device
- rebase and support virtqueue resize
---
 drivers/virtio/virtio_ring.c | 75 ++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 143f380baa1c..5b151605aaf8 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -15,6 +15,9 @@
 #include <linux/spinlock.h>
 #include <xen/xen.h>
 
+static bool force_used_validation = false;
+module_param(force_used_validation, bool, 0444);
+
 #ifdef DEBUG
 /* For development, we want to crash whenever the ring is screwed. */
 #define BAD_RING(_vq, fmt, args...)				\
@@ -105,6 +108,9 @@ struct vring_virtqueue_split {
 	struct vring_desc_state_split *desc_state;
 	struct vring_desc_extra *desc_extra;
 
+	/* Maximum in buffer length, NULL means no used validation */
+	u32 *buflen;
+
 	/* DMA address and size information */
 	dma_addr_t queue_dma_addr;
 	size_t queue_size_in_bytes;
@@ -145,6 +151,9 @@ struct vring_virtqueue_packed {
 	struct vring_desc_state_packed *desc_state;
 	struct vring_desc_extra *desc_extra;
 
+	/* Maximum in buffer length, NULL means no used validation */
+	u32 *buflen;
+
 	/* DMA address and size information */
 	dma_addr_t ring_dma_addr;
 	dma_addr_t driver_event_dma_addr;
@@ -552,6 +561,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	unsigned int i, n, avail, descs_used, prev, err_idx;
 	int head;
 	bool indirect;
+	u32 buflen = 0;
 
 	START_USE(vq);
 
@@ -635,6 +645,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 						     VRING_DESC_F_NEXT |
 						     VRING_DESC_F_WRITE,
 						     indirect);
+			buflen += sg->length;
 		}
 	}
 	/* Last one doesn't continue. */
@@ -675,6 +686,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	else
 		vq->split.desc_state[head].indir_desc = ctx;
 
+	/* Store in buffer length if necessary */
+	if (vq->split.buflen)
+		vq->split.buflen[head] = buflen;
+
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
 	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
@@ -861,6 +876,11 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 		BAD_RING(vq, "id %u is not a head!\n", i);
 		return NULL;
 	}
+	if (vq->split.buflen && unlikely(*len > vq->split.buflen[i])) {
+		BAD_RING(vq, "used len %d is larger than max in buffer len %u\n",
+			*len, vq->split.buflen[i]);
+		return NULL;
+	}
 
 	/* detach_buf_split clears data, so grab it now. */
 	ret = vq->split.desc_state[i].data;
@@ -1085,10 +1105,25 @@ static void vring_free_split(struct vring_virtqueue_split *vring_split,
 			 vring_split->queue_dma_addr,
 			 dma_dev);
 
+	kfree(vring_split->buflen);
 	kfree(vring_split->desc_state);
 	kfree(vring_split->desc_extra);
 }
 
+static bool vring_needs_used_validation(const struct virtio_device *vdev)
+{
+	/*
+	 * Several legacy devices are known to produce buggy used
+	 * length. In order to let driver work, we won't validate used
+	 * buffer length in this case.
+	 */
+	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
+		return false;
+	if (force_used_validation)
+		return true;
+	return false;
+}
+
 static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
 				   struct virtio_device *vdev,
 				   u32 num,
@@ -1137,7 +1172,19 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
 	vring_split->vring_align = vring_align;
 	vring_split->may_reduce_num = may_reduce_num;
 
+	if (vring_needs_used_validation(vdev)) {
+		vring_split->buflen =
+			kmalloc_array(num, sizeof(*vring_split->buflen),
+				      GFP_KERNEL);
+		if (!vring_split->buflen)
+			goto err_buflen;
+	}
+
 	return 0;
+
+err_buflen:
+	vring_free_split(vring_split, vdev, dma_dev);
+	return -ENOMEM;
 }
 
 static struct virtqueue *vring_create_virtqueue_split(
@@ -1297,6 +1344,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	unsigned int i, n, err_idx;
 	u16 head, id;
 	dma_addr_t addr;
+	u32 buflen = 0;
 
 	head = vq->packed.next_avail_idx;
 	desc = alloc_indirect_packed(total_sg, gfp);
@@ -1325,6 +1373,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 			desc[i].addr = cpu_to_le64(addr);
 			desc[i].len = cpu_to_le32(sg->length);
 			i++;
+			if (n >= out_sgs)
+				buflen += sg->length;
 		}
 	}
 
@@ -1379,6 +1429,10 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	vq->packed.desc_state[id].last = id;
 	vq->packed.desc_state[id].premapped = premapped;
 
+	/* Store in buffer length if necessary */
+	if (vq->packed.buflen)
+		vq->packed.buflen[id] = buflen;
+
 	vq->num_added += 1;
 
 	pr_debug("Added buffer head %i to %p\n", head, vq);
@@ -1416,6 +1470,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	__le16 head_flags, flags;
 	u16 head, id, prev, curr, avail_used_flags;
 	int err;
+	u32 buflen = 0;
 
 	START_USE(vq);
 
@@ -1498,6 +1553,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 					1 << VRING_PACKED_DESC_F_AVAIL |
 					1 << VRING_PACKED_DESC_F_USED;
 			}
+			if (n >= out_sgs)
+				buflen += sg->length;
 		}
 	}
 
@@ -1518,6 +1575,10 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	vq->packed.desc_state[id].last = prev;
 	vq->packed.desc_state[id].premapped = premapped;
 
+	/* Store in buffer length if necessary */
+	if (vq->packed.buflen)
+		vq->packed.buflen[id] = buflen;
+
 	/*
 	 * A driver MUST NOT make the first descriptor in the list
 	 * available before all subsequent descriptors comprising
@@ -1718,6 +1779,11 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 		BAD_RING(vq, "id %u is not a head!\n", id);
 		return NULL;
 	}
+	if (vq->packed.buflen && unlikely(*len > vq->packed.buflen[id])) {
+		BAD_RING(vq, "used len %d is larger than max in buffer len %u\n",
+			*len, vq->packed.buflen[id]);
+		return NULL;
+	}
 
 	/* detach_buf_packed clears data, so grab it now. */
 	ret = vq->packed.desc_state[id].data;
@@ -1937,6 +2003,7 @@ static void vring_free_packed(struct vring_virtqueue_packed *vring_packed,
 				 vring_packed->device_event_dma_addr,
 				 dma_dev);
 
+	kfree(vring_packed->buflen);
 	kfree(vring_packed->desc_state);
 	kfree(vring_packed->desc_extra);
 }
@@ -1988,6 +2055,14 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 
 	vring_packed->vring.num = num;
 
+	if (vring_needs_used_validation(vdev)) {
+		vring_packed->buflen =
+			kmalloc_array(num, sizeof(*vring_packed->buflen),
+				      GFP_KERNEL);
+		if (!vring_packed->buflen)
+			goto err;
+	}
+
 	return 0;
 
 err:
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
