Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0E5CD6E54
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 09:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80A42823E3;
	Wed, 11 Oct 2023 09:27:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 80A42823E3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Q3ib-Gn4-8d; Wed, 11 Oct 2023 09:27:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 343F282392;
	Wed, 11 Oct 2023 09:27:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 343F282392
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F6CAC0039;
	Wed, 11 Oct 2023 09:27:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37089C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F1E141B61
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F1E141B61
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8xtHKFOADKzU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:42 +0000 (UTC)
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 12A10416A2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12A10416A2
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VtwMros_1697016455; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VtwMros_1697016455) by smtp.aliyun-inc.com;
 Wed, 11 Oct 2023 17:27:36 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost 06/22] virtio_net: move to virtio_net.h
Date: Wed, 11 Oct 2023 17:27:12 +0800
Message-Id: <20231011092728.105904-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 7e791d85ef9e
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

Move some structure definitions and inline functions into the
virtio_net.h file.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       | 252 +------------------------------
 drivers/net/virtio/virtio_net.h | 256 ++++++++++++++++++++++++++++++++
 2 files changed, 258 insertions(+), 250 deletions(-)
 create mode 100644 drivers/net/virtio/virtio_net.h

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 11125624bcc9..f4b50b8f113c 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -6,7 +6,6 @@
 //#define DEBUG
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
-#include <linux/ethtool.h>
 #include <linux/module.h>
 #include <linux/virtio.h>
 #include <linux/virtio_net.h>
@@ -16,7 +15,6 @@
 #include <linux/if_vlan.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
-#include <linux/average.h>
 #include <linux/filter.h>
 #include <linux/kernel.h>
 #include <net/route.h>
@@ -24,6 +22,8 @@
 #include <net/net_failover.h>
 #include <net/netdev_rx_queue.h>
 
+#include "virtio_net.h"
+
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
 
@@ -45,15 +45,6 @@ module_param(napi_tx, bool, 0644);
 #define VIRTIO_XDP_TX		BIT(0)
 #define VIRTIO_XDP_REDIR	BIT(1)
 
-#define VIRTIO_XDP_FLAG	BIT(0)
-
-/* RX packet size EWMA. The average packet size is used to determine the packet
- * buffer size when refilling RX rings. As the entire RX ring may be refilled
- * at once, the weight is chosen so that the EWMA will be insensitive to short-
- * term, transient changes in packet size.
- */
-DECLARE_EWMA(pkt_len, 0, 64)
-
 #define VIRTNET_DRIVER_VERSION "1.0.0"
 
 static const unsigned long guest_offloads[] = {
@@ -74,36 +65,6 @@ static const unsigned long guest_offloads[] = {
 				(1ULL << VIRTIO_NET_F_GUEST_USO4) | \
 				(1ULL << VIRTIO_NET_F_GUEST_USO6))
 
-struct virtnet_stat_desc {
-	char desc[ETH_GSTRING_LEN];
-	size_t offset;
-};
-
-struct virtnet_sq_stats {
-	struct u64_stats_sync syncp;
-	u64 packets;
-	u64 bytes;
-	u64 xdp_tx;
-	u64 xdp_tx_drops;
-	u64 kicks;
-	u64 tx_timeouts;
-};
-
-struct virtnet_rq_stats {
-	struct u64_stats_sync syncp;
-	u64 packets;
-	u64 bytes;
-	u64 drops;
-	u64 xdp_packets;
-	u64 xdp_tx;
-	u64 xdp_redirects;
-	u64 xdp_drops;
-	u64 kicks;
-};
-
-#define VIRTNET_SQ_STAT(m)	offsetof(struct virtnet_sq_stats, m)
-#define VIRTNET_RQ_STAT(m)	offsetof(struct virtnet_rq_stats, m)
-
 static const struct virtnet_stat_desc virtnet_sq_stats_desc[] = {
 	{ "packets",		VIRTNET_SQ_STAT(packets) },
 	{ "bytes",		VIRTNET_SQ_STAT(bytes) },
@@ -127,80 +88,6 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
 #define VIRTNET_SQ_STATS_LEN	ARRAY_SIZE(virtnet_sq_stats_desc)
 #define VIRTNET_RQ_STATS_LEN	ARRAY_SIZE(virtnet_rq_stats_desc)
 
-struct virtnet_interrupt_coalesce {
-	u32 max_packets;
-	u32 max_usecs;
-};
-
-/* The dma information of pages allocated at a time. */
-struct virtnet_rq_dma {
-	dma_addr_t addr;
-	u32 ref;
-	u16 len;
-	u16 need_sync;
-};
-
-/* Internal representation of a send virtqueue */
-struct send_queue {
-	/* Virtqueue associated with this send _queue */
-	struct virtqueue *vq;
-
-	/* TX: fragments + linear part + virtio header */
-	struct scatterlist sg[MAX_SKB_FRAGS + 2];
-
-	/* Name of the send queue: output.$index */
-	char name[16];
-
-	struct virtnet_sq_stats stats;
-
-	struct virtnet_interrupt_coalesce intr_coal;
-
-	struct napi_struct napi;
-
-	/* Record whether sq is in reset state. */
-	bool reset;
-};
-
-/* Internal representation of a receive virtqueue */
-struct receive_queue {
-	/* Virtqueue associated with this receive_queue */
-	struct virtqueue *vq;
-
-	struct napi_struct napi;
-
-	struct bpf_prog __rcu *xdp_prog;
-
-	struct virtnet_rq_stats stats;
-
-	struct virtnet_interrupt_coalesce intr_coal;
-
-	/* Chain pages by the private ptr. */
-	struct page *pages;
-
-	/* Average packet length for mergeable receive buffers. */
-	struct ewma_pkt_len mrg_avg_pkt_len;
-
-	/* Page frag for packet buffer allocation. */
-	struct page_frag alloc_frag;
-
-	/* RX: fragments + linear part + virtio header */
-	struct scatterlist sg[MAX_SKB_FRAGS + 2];
-
-	/* Min single buffer size for mergeable buffers case. */
-	unsigned int min_buf_len;
-
-	/* Name of this receive queue: input.$index */
-	char name[16];
-
-	struct xdp_rxq_info xdp_rxq;
-
-	/* Record the last dma info to free after new pages is allocated. */
-	struct virtnet_rq_dma *last_dma;
-
-	/* Do dma by self */
-	bool do_dma;
-};
-
 /* This structure can contain rss message with maximum settings for indirection table and keysize
  * Note, that default structure that describes RSS configuration virtio_net_rss_config
  * contains same info but can't handle table values.
@@ -234,88 +121,6 @@ struct control_buf {
 	struct virtio_net_ctrl_coal_vq coal_vq;
 };
 
-struct virtnet_info {
-	struct virtio_device *vdev;
-	struct virtqueue *cvq;
-	struct net_device *dev;
-	struct send_queue *sq;
-	struct receive_queue *rq;
-	unsigned int status;
-
-	/* Max # of queue pairs supported by the device */
-	u16 max_queue_pairs;
-
-	/* # of queue pairs currently used by the driver */
-	u16 curr_queue_pairs;
-
-	/* # of XDP queue pairs currently used by the driver */
-	u16 xdp_queue_pairs;
-
-	/* xdp_queue_pairs may be 0, when xdp is already loaded. So add this. */
-	bool xdp_enabled;
-
-	/* I like... big packets and I cannot lie! */
-	bool big_packets;
-
-	/* number of sg entries allocated for big packets */
-	unsigned int big_packets_num_skbfrags;
-
-	/* Host will merge rx buffers for big packets (shake it! shake it!) */
-	bool mergeable_rx_bufs;
-
-	/* Host supports rss and/or hash report */
-	bool has_rss;
-	bool has_rss_hash_report;
-	u8 rss_key_size;
-	u16 rss_indir_table_size;
-	u32 rss_hash_types_supported;
-	u32 rss_hash_types_saved;
-
-	/* Has control virtqueue */
-	bool has_cvq;
-
-	/* Host can handle any s/g split between our header and packet data */
-	bool any_header_sg;
-
-	/* Packet virtio header size */
-	u8 hdr_len;
-
-	/* Work struct for delayed refilling if we run low on memory. */
-	struct delayed_work refill;
-
-	/* Is delayed refill enabled? */
-	bool refill_enabled;
-
-	/* The lock to synchronize the access to refill_enabled */
-	spinlock_t refill_lock;
-
-	/* Work struct for config space updates */
-	struct work_struct config_work;
-
-	/* Does the affinity hint is set for virtqueues? */
-	bool affinity_hint_set;
-
-	/* CPU hotplug instances for online & dead */
-	struct hlist_node node;
-	struct hlist_node node_dead;
-
-	struct control_buf *ctrl;
-
-	/* Ethtool settings */
-	u8 duplex;
-	u32 speed;
-
-	/* Interrupt coalescing settings */
-	struct virtnet_interrupt_coalesce intr_coal_tx;
-	struct virtnet_interrupt_coalesce intr_coal_rx;
-
-	unsigned long guest_offloads;
-	unsigned long guest_offloads_capable;
-
-	/* failover when STANDBY feature enabled */
-	struct failover *failover;
-};
-
 struct padded_vnet_hdr {
 	struct virtio_net_hdr_v1_hash hdr;
 	/*
@@ -337,45 +142,11 @@ struct virtio_net_common_hdr {
 static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
 
-static bool is_xdp_frame(void *ptr)
-{
-	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
-}
-
 static void *xdp_to_ptr(struct xdp_frame *ptr)
 {
 	return (void *)((unsigned long)ptr | VIRTIO_XDP_FLAG);
 }
 
-static struct xdp_frame *ptr_to_xdp(void *ptr)
-{
-	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
-}
-
-static void __free_old_xmit(struct send_queue *sq, bool in_napi,
-			    struct virtnet_sq_stats *stats)
-{
-	unsigned int len;
-	void *ptr;
-
-	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
-		if (!is_xdp_frame(ptr)) {
-			struct sk_buff *skb = ptr;
-
-			pr_debug("Sent skb %p\n", skb);
-
-			stats->bytes += skb->len;
-			napi_consume_skb(skb, in_napi);
-		} else {
-			struct xdp_frame *frame = ptr_to_xdp(ptr);
-
-			stats->bytes += xdp_get_frame_len(frame);
-			xdp_return_frame(frame);
-		}
-		stats->packets++;
-	}
-}
-
 /* Converting between virtqueue no. and kernel tx/rx queue no.
  * 0:rx0 1:tx0 2:rx1 3:tx1 ... 2N:rxN 2N+1:txN 2N+2:cvq
  */
@@ -446,15 +217,6 @@ static void disable_delayed_refill(struct virtnet_info *vi)
 	spin_unlock_bh(&vi->refill_lock);
 }
 
-static void virtqueue_napi_schedule(struct napi_struct *napi,
-				    struct virtqueue *vq)
-{
-	if (napi_schedule_prep(napi)) {
-		virtqueue_disable_cb(vq);
-		__napi_schedule(napi);
-	}
-}
-
 static void virtqueue_napi_complete(struct napi_struct *napi,
 				    struct virtqueue *vq, int processed)
 {
@@ -786,16 +548,6 @@ static void free_old_xmit(struct send_queue *sq, bool in_napi)
 	u64_stats_update_end(&sq->stats.syncp);
 }
 
-static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
-{
-	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
-		return false;
-	else if (q < vi->curr_queue_pairs)
-		return true;
-	else
-		return false;
-}
-
 static void check_sq_full_and_disable(struct virtnet_info *vi,
 				      struct net_device *dev,
 				      struct send_queue *sq)
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
new file mode 100644
index 000000000000..ddaf0ecf4d9d
--- /dev/null
+++ b/drivers/net/virtio/virtio_net.h
@@ -0,0 +1,256 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __VIRTIO_NET_H__
+#define __VIRTIO_NET_H__
+
+#include <linux/ethtool.h>
+#include <linux/average.h>
+
+#define VIRTIO_XDP_FLAG	BIT(0)
+
+/* RX packet size EWMA. The average packet size is used to determine the packet
+ * buffer size when refilling RX rings. As the entire RX ring may be refilled
+ * at once, the weight is chosen so that the EWMA will be insensitive to short-
+ * term, transient changes in packet size.
+ */
+DECLARE_EWMA(pkt_len, 0, 64)
+
+struct virtnet_stat_desc {
+	char desc[ETH_GSTRING_LEN];
+	size_t offset;
+};
+
+struct virtnet_sq_stats {
+	struct u64_stats_sync syncp;
+	u64 packets;
+	u64 bytes;
+	u64 xdp_tx;
+	u64 xdp_tx_drops;
+	u64 kicks;
+	u64 tx_timeouts;
+};
+
+struct virtnet_rq_stats {
+	struct u64_stats_sync syncp;
+	u64 packets;
+	u64 bytes;
+	u64 drops;
+	u64 xdp_packets;
+	u64 xdp_tx;
+	u64 xdp_redirects;
+	u64 xdp_drops;
+	u64 kicks;
+};
+
+#define VIRTNET_SQ_STAT(m)	offsetof(struct virtnet_sq_stats, m)
+#define VIRTNET_RQ_STAT(m)	offsetof(struct virtnet_rq_stats, m)
+
+struct virtnet_interrupt_coalesce {
+	u32 max_packets;
+	u32 max_usecs;
+};
+
+/* The dma information of pages allocated at a time. */
+struct virtnet_rq_dma {
+	dma_addr_t addr;
+	u32 ref;
+	u16 len;
+	u16 need_sync;
+};
+
+/* Internal representation of a send virtqueue */
+struct send_queue {
+	/* Virtqueue associated with this send _queue */
+	struct virtqueue *vq;
+
+	/* TX: fragments + linear part + virtio header */
+	struct scatterlist sg[MAX_SKB_FRAGS + 2];
+
+	/* Name of the send queue: output.$index */
+	char name[16];
+
+	struct virtnet_sq_stats stats;
+
+	struct virtnet_interrupt_coalesce intr_coal;
+
+	struct napi_struct napi;
+
+	/* Record whether sq is in reset state. */
+	bool reset;
+};
+
+/* Internal representation of a receive virtqueue */
+struct receive_queue {
+	/* Virtqueue associated with this receive_queue */
+	struct virtqueue *vq;
+
+	struct napi_struct napi;
+
+	struct bpf_prog __rcu *xdp_prog;
+
+	struct virtnet_rq_stats stats;
+
+	struct virtnet_interrupt_coalesce intr_coal;
+
+	/* Chain pages by the private ptr. */
+	struct page *pages;
+
+	/* Average packet length for mergeable receive buffers. */
+	struct ewma_pkt_len mrg_avg_pkt_len;
+
+	/* Page frag for packet buffer allocation. */
+	struct page_frag alloc_frag;
+
+	/* RX: fragments + linear part + virtio header */
+	struct scatterlist sg[MAX_SKB_FRAGS + 2];
+
+	/* Min single buffer size for mergeable buffers case. */
+	unsigned int min_buf_len;
+
+	/* Name of this receive queue: input.$index */
+	char name[16];
+
+	struct xdp_rxq_info xdp_rxq;
+
+	/* Record the last dma info to free after new pages is allocated. */
+	struct virtnet_rq_dma *last_dma;
+
+	/* Do dma by self */
+	bool do_dma;
+};
+
+struct virtnet_info {
+	struct virtio_device *vdev;
+	struct virtqueue *cvq;
+	struct net_device *dev;
+	struct send_queue *sq;
+	struct receive_queue *rq;
+	unsigned int status;
+
+	/* Max # of queue pairs supported by the device */
+	u16 max_queue_pairs;
+
+	/* # of queue pairs currently used by the driver */
+	u16 curr_queue_pairs;
+
+	/* # of XDP queue pairs currently used by the driver */
+	u16 xdp_queue_pairs;
+
+	/* xdp_queue_pairs may be 0, when xdp is already loaded. So add this. */
+	bool xdp_enabled;
+
+	/* I like... big packets and I cannot lie! */
+	bool big_packets;
+
+	/* number of sg entries allocated for big packets */
+	unsigned int big_packets_num_skbfrags;
+
+	/* Host will merge rx buffers for big packets (shake it! shake it!) */
+	bool mergeable_rx_bufs;
+
+	/* Host supports rss and/or hash report */
+	bool has_rss;
+	bool has_rss_hash_report;
+	u8 rss_key_size;
+	u16 rss_indir_table_size;
+	u32 rss_hash_types_supported;
+	u32 rss_hash_types_saved;
+
+	/* Has control virtqueue */
+	bool has_cvq;
+
+	/* Host can handle any s/g split between our header and packet data */
+	bool any_header_sg;
+
+	/* Packet virtio header size */
+	u8 hdr_len;
+
+	/* Work struct for delayed refilling if we run low on memory. */
+	struct delayed_work refill;
+
+	/* Is delayed refill enabled? */
+	bool refill_enabled;
+
+	/* The lock to synchronize the access to refill_enabled */
+	spinlock_t refill_lock;
+
+	/* Work struct for config space updates */
+	struct work_struct config_work;
+
+	/* Does the affinity hint is set for virtqueues? */
+	bool affinity_hint_set;
+
+	/* CPU hotplug instances for online & dead */
+	struct hlist_node node;
+	struct hlist_node node_dead;
+
+	struct control_buf *ctrl;
+
+	/* Ethtool settings */
+	u8 duplex;
+	u32 speed;
+
+	/* Interrupt coalescing settings */
+	struct virtnet_interrupt_coalesce intr_coal_tx;
+	struct virtnet_interrupt_coalesce intr_coal_rx;
+
+	unsigned long guest_offloads;
+	unsigned long guest_offloads_capable;
+
+	/* failover when STANDBY feature enabled */
+	struct failover *failover;
+};
+
+static inline bool is_xdp_frame(void *ptr)
+{
+	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
+}
+
+static inline struct xdp_frame *ptr_to_xdp(void *ptr)
+{
+	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
+}
+
+static inline void __free_old_xmit(struct send_queue *sq, bool in_napi,
+				   struct virtnet_sq_stats *stats)
+{
+	unsigned int len;
+	void *ptr;
+
+	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
+		if (!is_xdp_frame(ptr)) {
+			struct sk_buff *skb = ptr;
+
+			pr_debug("Sent skb %p\n", skb);
+
+			stats->bytes += skb->len;
+			napi_consume_skb(skb, in_napi);
+		} else {
+			struct xdp_frame *frame = ptr_to_xdp(ptr);
+
+			stats->bytes += xdp_get_frame_len(frame);
+			xdp_return_frame(frame);
+		}
+		stats->packets++;
+	}
+}
+
+static inline void virtqueue_napi_schedule(struct napi_struct *napi,
+					   struct virtqueue *vq)
+{
+	if (napi_schedule_prep(napi)) {
+		virtqueue_disable_cb(vq);
+		__napi_schedule(napi);
+	}
+}
+
+static inline bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
+{
+	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
+		return false;
+	else if (q < vi->curr_queue_pairs)
+		return true;
+	else
+		return false;
+}
+#endif
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
