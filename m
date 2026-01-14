Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018D130EF72
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394200; cv=none; b=hXfYcHEmyBTs4BwJmkXxvQQHRTzTZvsCLVv7f3p1HaRMG3ZWMDDFq5ISdFM16wPzov5r9uS7b663hUY07ZXWgo31+SFwcpwqTqw+F+7A6ze2wyozd+2nnn9VLjWOSbTkXoFhxNHP+n4mmhHBvDTegmxeBKIyQ2QSBIPB8tnV4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394200; c=relaxed/simple;
	bh=aHUJKAoCLIs+lf/ahcJcWt2kD0IjJ+iArS9Nu7OgZhA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=P0xRmLYHFjdWV/tIhnwgLeIPrC7eRLhQ3F8XLX7DVBmO3rzMZ6WMG+wcTUFkXSNIm4g9ombmpu2ujY1Uw8PskKWUdsvKQ2rS/CQvyninY/Jy2JZXsM5kZza+SkN8jgKLQ3HqzrnwGaXeDd/Ua/2Bn2ed9fK1WopmQXpd8VHCmoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AIdKIF5L; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AIdKIF5L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=+Q8bpr6iiNi81XIIibcZxRQnnVZpGIdsRInK/ozNgdI=;
	b=AIdKIF5L0dXIbXnEFJtn8kxJV0gfFLUSNxCpg9QC8wWg9pi00tBEqKDD7egLGN
	OKf5BZWad0eqA+Uf9+sQRPmu6229jRac7hBQCbyYcpmMFkuTUDkre5J3+GnST2Bg
	WNGVr0PdBYO+7vk+QHv/u0pkQYycl92uobCe88qqppYCw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAHAZrLjWdpmu37Fw--.652S2;
	Wed, 14 Jan 2026 20:36:28 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: virtualization@lists.linux.dev,
	tanglongjun@kylinos.cn,
	lange_tang@163.com
Subject: [PATCH v1] virtio_net: add traces for tx/rx and INT response events.
Date: Wed, 14 Jan 2026 20:36:27 +0800
Message-Id: <20260114123627.102579-1-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHAZrLjWdpmu37Fw--.652S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3ZFW8Wr18Cw4UKrWfXFy5Jwb_yoW8XryUCo
	WIqanxXr4rKr18C39Ikry8tF48ZFs2gFW5Zr4YyrZ5Za1xZw4Yya47Zw45JF1fXF1fKFsx
	AFW0q3s8ArsFqFZ3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRgXozUUUUU
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4gzK+GlnjcwrNQAA3N

From: Longjun Tang <tanglongjun@kylinos.cn>

To facilitate tracking the status of virtqueue during rx/tx and
interrupt response, add trace point at  corresponding func.

Also,to avoid perf hured,it olny available under debug condition.

Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
v1：
I did some tests with iperf3, as follow:
host <---> vm

oringnal:
rx pps: 90915  rx bitrate: 28.5 Gbits/s
tx pps: 54659   tx bitrate: 26.4 Gbits/s

added trace:
rx pps: 76810  rx bitrate: 26.7 Gbits/s
tx pps: 54455   tx bitrate: 26.4 Gbits/s

Based on the results of the above tests, adding tracing has a
performance hurt, especially on the rx side. Therefore, these
traces should only be added to the debug virtio_net.

When these traces are needed, uncomment the DEBUG macro definition
in driver/net/virtio_net.c.
---
 drivers/net/virtio_net.c       |  21 ++++-
 drivers/net/virtio_net_trace.h | 124 ++++++++++++++++++++++++++
 drivers/virtio/virtio_ring.c   | 155 --------------------------------
 include/linux/virtio_ring.h    | 156 +++++++++++++++++++++++++++++++++
 4 files changed, 297 insertions(+), 159 deletions(-)
 create mode 100644 drivers/net/virtio_net_trace.h

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 22d894101c01..fabd3e8acb36 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -27,6 +27,11 @@
 #include <net/netdev_queues.h>
 #include <net/xdp_sock_drv.h>
 
+#if defined(DEBUG)
+#define CREATE_TRACE_POINTS
+#include "virtio_net_trace.h"
+#endif
+
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
 
@@ -795,7 +800,9 @@ static void skb_xmit_done(struct virtqueue *vq)
 	unsigned int index = vq2txq(vq);
 	struct send_queue *sq = &vi->sq[index];
 	struct napi_struct *napi = &sq->napi;
-
+#if defined(DEBUG)
+	trace_skb_xmit_done(napi, vq);
+#endif
 	/* Suppress further interrupts. */
 	virtqueue_disable_cb(vq);
 
@@ -2671,7 +2678,9 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 
 	if (unlikely(!skb))
 		return;
-
+#if defined(DEBUG)
+	trace_receive_buf(rq->vq, skb);
+#endif
 	virtnet_receive_done(vi, rq, skb, flags);
 }
 
@@ -2877,7 +2886,9 @@ static void skb_recv_done(struct virtqueue *rvq)
 {
 	struct virtnet_info *vi = rvq->vdev->priv;
 	struct receive_queue *rq = &vi->rq[vq2rxq(rvq)];
-
+#if defined(DEBUG)
+	trace_skb_recv_done(&rq->napi, rvq);
+#endif
 	rq->calls++;
 	virtqueue_napi_schedule(&rq->napi, rvq);
 }
@@ -3389,7 +3400,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	/* timestamp packet in software */
 	skb_tx_timestamp(skb);
-
+#if defined(DEBUG)
+	trace_start_xmit(sq->vq, skb);
+#endif
 	/* Try to transmit */
 	err = xmit_skb(sq, skb, !use_napi);
 
diff --git a/drivers/net/virtio_net_trace.h b/drivers/net/virtio_net_trace.h
new file mode 100644
index 000000000000..0a008cb8f51d
--- /dev/null
+++ b/drivers/net/virtio_net_trace.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#if defined(DEBUG)
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM virtio_net
+
+#if !defined(_TRACE_VIRTIO_NET_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_VIRTIO_NET_H
+
+#include <linux/virtio.h>
+#include <linux/tracepoint.h>
+#include <linux/virtio_ring.h>
+
+DECLARE_EVENT_CLASS(virtio_net_rxtx_temp,
+
+	TP_PROTO(struct virtqueue *vq, const struct sk_buff *skb),
+
+	TP_ARGS(vq, skb),
+
+	TP_STRUCT__entry(
+		__string(	name,	vq->name	)
+		__field(	unsigned int, num_free	)
+		__field(	unsigned int, index	)
+		__field(	bool, packed_ring	)
+		__field(	bool, broken	)
+		__field(	bool, event	)
+		__field(	u16, last_used_idx	)
+		__field(	__virtio16, avail_flags	)
+		__field(	__virtio16, avail_idx	)
+		__field(	__virtio16, used_idx	)
+		__field(	const void *, skbaddr	)
+	),
+
+	TP_fast_assign(
+		__entry->skbaddr = skb;
+
+		__assign_str(name);
+		__entry->num_free = vq->num_free;
+		__entry->index = vq->index;
+
+		struct vring_virtqueue *vvq;
+
+		vvq = container_of_const(vq, struct vring_virtqueue, vq);
+
+		__entry->packed_ring = vvq->packed_ring;
+		__entry->broken = vvq->broken;
+		__entry->event = vvq->event;
+		if (!vvq->packed_ring) {
+			__entry->last_used_idx = vvq->last_used_idx;
+			__entry->avail_flags = vvq->split.vring.avail->flags;
+			__entry->avail_idx = vvq->split.vring.avail->idx;
+			__entry->used_idx = vvq->split.vring.used->idx;
+		}
+	),
+
+	TP_printk("skbaddr=%p vq=%s num_free=%u index=%u packed=%d broken=%d event=%d last_used_idx=%u avail_flags=%u avail_idx=%u used_idx=%u",
+		__entry->skbaddr, __get_str(name), __entry->num_free, __entry->index,
+		__entry->packed_ring, __entry->broken, __entry->event, __entry->last_used_idx,
+		__entry->avail_flags, __entry->avail_idx, __entry->used_idx)
+)
+
+DEFINE_EVENT(virtio_net_rxtx_temp, receive_buf,
+
+	TP_PROTO(struct virtqueue *vq, const struct sk_buff *skb),
+
+	TP_ARGS(vq, skb)
+);
+
+DEFINE_EVENT(virtio_net_rxtx_temp, start_xmit,
+
+	TP_PROTO(struct virtqueue *vq, const struct sk_buff *skb),
+
+	TP_ARGS(vq, skb)
+);
+
+DECLARE_EVENT_CLASS(virtio_net_int_temp,
+
+	TP_PROTO(struct napi_struct *napi, struct virtqueue *vq),
+
+	TP_ARGS(napi, vq),
+
+	TP_STRUCT__entry(
+		__string(	dev_name,	napi->dev->name	)
+		__string(	vq_name,	vq->name)
+		__field(	u32,	napi_id	)
+		__field(	int,	weight	)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name);
+		__assign_str(vq_name);
+		__entry->napi_id = napi->napi_id;
+		__entry->weight = napi->weight;
+	),
+
+	TP_printk("dev=%s vq=%s napi_id=%u weight=%d",
+		__get_str(dev_name), __get_str(vq_name), __entry->napi_id, __entry->weight)
+)
+
+DEFINE_EVENT(virtio_net_int_temp, skb_xmit_done,
+
+	TP_PROTO(struct napi_struct *napi, struct virtqueue *vq),
+
+	TP_ARGS(napi, vq)
+);
+
+DEFINE_EVENT(virtio_net_int_temp, skb_recv_done,
+
+	TP_PROTO(struct napi_struct *napi, struct virtqueue *vq),
+
+	TP_ARGS(napi, vq)
+);
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../drivers/net/
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE virtio_net_trace
+
+#endif /* _TRACE_VIRTIO_NET_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
+
+#endif
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index ddab68959671..d413ebb42729 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -67,161 +67,6 @@
 #define LAST_ADD_TIME_INVALID(vq)
 #endif
 
-struct vring_desc_state_split {
-	void *data;			/* Data for callback. */
-
-	/* Indirect desc table and extra table, if any. These two will be
-	 * allocated together. So we won't stress more to the memory allocator.
-	 */
-	struct vring_desc *indir_desc;
-};
-
-struct vring_desc_state_packed {
-	void *data;			/* Data for callback. */
-
-	/* Indirect desc table and extra table, if any. These two will be
-	 * allocated together. So we won't stress more to the memory allocator.
-	 */
-	struct vring_packed_desc *indir_desc;
-	u16 num;			/* Descriptor list length. */
-	u16 last;			/* The last desc state in a list. */
-};
-
-struct vring_desc_extra {
-	dma_addr_t addr;		/* Descriptor DMA addr. */
-	u32 len;			/* Descriptor length. */
-	u16 flags;			/* Descriptor flags. */
-	u16 next;			/* The next desc state in a list. */
-};
-
-struct vring_virtqueue_split {
-	/* Actual memory layout for this queue. */
-	struct vring vring;
-
-	/* Last written value to avail->flags */
-	u16 avail_flags_shadow;
-
-	/*
-	 * Last written value to avail->idx in
-	 * guest byte order.
-	 */
-	u16 avail_idx_shadow;
-
-	/* Per-descriptor state. */
-	struct vring_desc_state_split *desc_state;
-	struct vring_desc_extra *desc_extra;
-
-	/* DMA address and size information */
-	dma_addr_t queue_dma_addr;
-	size_t queue_size_in_bytes;
-
-	/*
-	 * The parameters for creating vrings are reserved for creating new
-	 * vring.
-	 */
-	u32 vring_align;
-	bool may_reduce_num;
-};
-
-struct vring_virtqueue_packed {
-	/* Actual memory layout for this queue. */
-	struct {
-		unsigned int num;
-		struct vring_packed_desc *desc;
-		struct vring_packed_desc_event *driver;
-		struct vring_packed_desc_event *device;
-	} vring;
-
-	/* Driver ring wrap counter. */
-	bool avail_wrap_counter;
-
-	/* Avail used flags. */
-	u16 avail_used_flags;
-
-	/* Index of the next avail descriptor. */
-	u16 next_avail_idx;
-
-	/*
-	 * Last written value to driver->flags in
-	 * guest byte order.
-	 */
-	u16 event_flags_shadow;
-
-	/* Per-descriptor state. */
-	struct vring_desc_state_packed *desc_state;
-	struct vring_desc_extra *desc_extra;
-
-	/* DMA address and size information */
-	dma_addr_t ring_dma_addr;
-	dma_addr_t driver_event_dma_addr;
-	dma_addr_t device_event_dma_addr;
-	size_t ring_size_in_bytes;
-	size_t event_size_in_bytes;
-};
-
-struct vring_virtqueue {
-	struct virtqueue vq;
-
-	/* Is this a packed ring? */
-	bool packed_ring;
-
-	/* Is DMA API used? */
-	bool use_map_api;
-
-	/* Can we use weak barriers? */
-	bool weak_barriers;
-
-	/* Other side has made a mess, don't try any more. */
-	bool broken;
-
-	/* Host supports indirect buffers */
-	bool indirect;
-
-	/* Host publishes avail event idx */
-	bool event;
-
-	/* Head of free buffer list. */
-	unsigned int free_head;
-	/* Number we've added since last sync. */
-	unsigned int num_added;
-
-	/* Last used index  we've seen.
-	 * for split ring, it just contains last used index
-	 * for packed ring:
-	 * bits up to VRING_PACKED_EVENT_F_WRAP_CTR include the last used index.
-	 * bits from VRING_PACKED_EVENT_F_WRAP_CTR include the used wrap counter.
-	 */
-	u16 last_used_idx;
-
-	/* Hint for event idx: already triggered no need to disable. */
-	bool event_triggered;
-
-	union {
-		/* Available for split ring */
-		struct vring_virtqueue_split split;
-
-		/* Available for packed ring */
-		struct vring_virtqueue_packed packed;
-	};
-
-	/* How to notify other side. FIXME: commonalize hcalls! */
-	bool (*notify)(struct virtqueue *vq);
-
-	/* DMA, allocation, and size information */
-	bool we_own_ring;
-
-	union virtio_map map;
-
-#ifdef DEBUG
-	/* They're supposed to lock for us. */
-	unsigned int in_use;
-
-	/* Figure out if their kicks are too delayed. */
-	bool last_add_time_valid;
-	ktime_t last_add_time;
-#endif
-};
-
 static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
 static void vring_free(struct virtqueue *_vq);
 
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index c97a12c1cda3..1442a02209ec 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -121,4 +121,160 @@ void vring_transport_features(struct virtio_device *vdev);
 irqreturn_t vring_interrupt(int irq, void *_vq);
 
 u32 vring_notification_data(struct virtqueue *_vq);
+
+struct vring_desc_state_split {
+	void *data;			/* Data for callback. */
+
+	/* Indirect desc table and extra table, if any. These two will be
+	 * allocated together. So we won't stress more to the memory allocator.
+	 */
+	struct vring_desc *indir_desc;
+};
+
+struct vring_desc_state_packed {
+	void *data;			/* Data for callback. */
+
+	/* Indirect desc table and extra table, if any. These two will be
+	 * allocated together. So we won't stress more to the memory allocator.
+	 */
+	struct vring_packed_desc *indir_desc;
+	u16 num;			/* Descriptor list length. */
+	u16 last;			/* The last desc state in a list. */
+};
+
+struct vring_desc_extra {
+	dma_addr_t addr;		/* Descriptor DMA addr. */
+	u32 len;			/* Descriptor length. */
+	u16 flags;			/* Descriptor flags. */
+	u16 next;			/* The next desc state in a list. */
+};
+
+struct vring_virtqueue_split {
+	/* Actual memory layout for this queue. */
+	struct vring vring;
+
+	/* Last written value to avail->flags */
+	u16 avail_flags_shadow;
+
+	/*
+	 * Last written value to avail->idx in
+	 * guest byte order.
+	 */
+	u16 avail_idx_shadow;
+
+	/* Per-descriptor state. */
+	struct vring_desc_state_split *desc_state;
+	struct vring_desc_extra *desc_extra;
+
+	/* DMA address and size information */
+	dma_addr_t queue_dma_addr;
+	size_t queue_size_in_bytes;
+
+	/*
+	 * The parameters for creating vrings are reserved for creating new
+	 * vring.
+	 */
+	u32 vring_align;
+	bool may_reduce_num;
+};
+
+struct vring_virtqueue_packed {
+	/* Actual memory layout for this queue. */
+	struct {
+		unsigned int num;
+		struct vring_packed_desc *desc;
+		struct vring_packed_desc_event *driver;
+		struct vring_packed_desc_event *device;
+	} vring;
+
+	/* Driver ring wrap counter. */
+	bool avail_wrap_counter;
+
+	/* Avail used flags. */
+	u16 avail_used_flags;
+
+	/* Index of the next avail descriptor. */
+	u16 next_avail_idx;
+
+	/*
+	 * Last written value to driver->flags in
+	 * guest byte order.
+	 */
+	u16 event_flags_shadow;
+
+	/* Per-descriptor state. */
+	struct vring_desc_state_packed *desc_state;
+	struct vring_desc_extra *desc_extra;
+
+	/* DMA address and size information */
+	dma_addr_t ring_dma_addr;
+	dma_addr_t driver_event_dma_addr;
+	dma_addr_t device_event_dma_addr;
+	size_t ring_size_in_bytes;
+	size_t event_size_in_bytes;
+};
+
+struct vring_virtqueue {
+	struct virtqueue vq;
+
+	/* Is this a packed ring? */
+	bool packed_ring;
+
+	/* Is DMA API used? */
+	bool use_map_api;
+
+	/* Can we use weak barriers? */
+	bool weak_barriers;
+
+	/* Other side has made a mess, don't try any more. */
+	bool broken;
+
+	/* Host supports indirect buffers */
+	bool indirect;
+
+	/* Host publishes avail event idx */
+	bool event;
+
+	/* Head of free buffer list. */
+	unsigned int free_head;
+	/* Number we've added since last sync. */
+	unsigned int num_added;
+
+	/* Last used index  we've seen.
+	 * for split ring, it just contains last used index
+	 * for packed ring:
+	 * bits up to VRING_PACKED_EVENT_F_WRAP_CTR include the last used index.
+	 * bits from VRING_PACKED_EVENT_F_WRAP_CTR include the used wrap counter.
+	 */
+	u16 last_used_idx;
+
+	/* Hint for event idx: already triggered no need to disable. */
+	bool event_triggered;
+
+	union {
+		/* Available for split ring */
+		struct vring_virtqueue_split split;
+
+		/* Available for packed ring */
+		struct vring_virtqueue_packed packed;
+	};
+
+	/* How to notify other side. FIXME: commonalize hcalls! */
+	bool (*notify)(struct virtqueue *vq);
+
+	/* DMA, allocation, and size information */
+	bool we_own_ring;
+
+	union virtio_map map;
+
+#ifdef DEBUG
+	/* They're supposed to lock for us. */
+	unsigned int in_use;
+
+	/* Figure out if their kicks are too delayed. */
+	bool last_add_time_valid;
+	ktime_t last_add_time;
+#endif
+};
+
 #endif /* _LINUX_VIRTIO_RING_H */
-- 
2.48.1

