Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7666F125A9
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 03:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764213882; cv=none; b=G3yD25D/4e7Si1fSMXh/egjhEkknmM0oRqq71mL0l9aXb/+bEq+M8s6JN4qWnoB9m2W+norKGomtmtATM1nJKpgPEfJbIMP0x6yTb2H66mm8d9cNI69XMY5lz1bBBLwaREsLlnYVDzKTyBDDwHUYbtPDq7R+mR0YS96v5ngay58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764213882; c=relaxed/simple;
	bh=eSPycMrcgRTYshZgYRgI+28skYdb69/F8oO6sCkotx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qUxJXAszbfhJPtdc2dB0Q4EH8ih5YYOugkbKKy/ZyBjUrIAKl8iGKCe0RyCzmguPL4DBaXtjxdAQEWwT2Cpexq/UZEc1kqll6zuoTDSJFmXeO8wUAvPnUAvf6eE0byAW+fAq7MWJYb8mNsTyC6H6Tfid8rW5juupr2++NbkEv3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TPtOQlQl; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TPtOQlQl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Oa
	BNQKUdYeNg6eXmN91FzyM7dwEI/w8itTxqGuT4Q+4=; b=TPtOQlQlBCzagQYbJ7
	4/1TEszto7VivRxDEz4YofitHReL4Ws3fvzcxw5DUlKnAz+oy1Zfm4d8Dz0lkIjH
	Kyh6Utz40vS8qqF+OrIaOC6NMLchMWrCtA/JPflg42edjgWhsxi8jOZ+8Z9jRtcE
	S0Kyk9Z9wtZlm4HzgY2P93pko=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCX4NVfxCdptnYQFg--.3639S5;
	Thu, 27 Nov 2025 11:24:25 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: lange_tang@163.com,
	tanglongjun@kylinos.cn,
	virtualization@lists.linux.dev
Subject: [PATCH v1 3/7] tools/virtio/virtnet_mon: add kprobe start_xmit
Date: Thu, 27 Nov 2025 11:24:03 +0800
Message-Id: <20251127032407.33475-4-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251127032407.33475-1-lange_tang@163.com>
References: <20251127032407.33475-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCX4NVfxCdptnYQFg--.3639S5
X-Coremail-Antispam: 1Uf129KBjvAXoWfAr43CFWfGF4UXw1DAryfCrg_yoW8tF1fAo
	WxXws8Xr1rKr1rCrW5KF1xJryUZ3y0gFsxZr4FvrZ3Xa17Aw15Way7Kw45XF4fWF4fKF4D
	A3y8twn3XFWxtFWfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RmoGQUUUUU
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbBdg8TLmknu4n8JQAAsh

From: Tang Longjun <tanglongjun@kylinos.cn>

track skb and virtqueue through the kprobe start_xmit function

Signed-off-by: Tang Longjun <tanglongjun@kylinos.cn>
---
 tools/virtio/virtnet_mon/virtnet_mon.c | 793 ++++++++++++++++++++++++-
 1 file changed, 772 insertions(+), 21 deletions(-)

diff --git a/tools/virtio/virtnet_mon/virtnet_mon.c b/tools/virtio/virtnet_mon/virtnet_mon.c
index 696e621cf803..36b51d0a13d4 100644
--- a/tools/virtio/virtnet_mon/virtnet_mon.c
+++ b/tools/virtio/virtnet_mon/virtnet_mon.c
@@ -6,15 +6,724 @@
 #include <linux/uaccess.h>
 #include <linux/miscdevice.h>
 #include <linux/poll.h>
+#include <linux/string.h>
+#include <linux/if_ether.h>
+
+#include <linux/kprobes.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
+#include <linux/icmp.h>
+#include <linux/icmpv6.h>
+#include <linux/version.h>
+#include <linux/time.h>
+#include <linux/smp.h>
+#include <linux/virtio.h>
+#include <linux/scatterlist.h>
+#include <linux/bpf.h>
+#include <linux/dim.h>
+#include <linux/mutex.h>
+#include <linux/workqueue.h>
+#include <linux/spinlock.h>
+
+#include <linux/u64_stats_sync.h>
+#include <linux/mm_types_task.h>
+#include <linux/virtio_net.h>
+#include <linux/virtio_ring.h>
+#include <net/xdp.h>
+
 
 #define DEVICE_NAME "virtnet_mon"
-#define KFIFO_SIZE 1024     // ring buffer size
+#define KFIFO_SIZE 65536     // ring buffer size
+#define WRITE_SIZE 1024
+#define READ_SIZE 16384
+#define LINE_MAX_SIZE 1024
+
+#if defined(CONFIG_X86_64)
+#define KP_GET_ARG(regs, idx) \
+	((idx) == 0 ? (unsigned long)(regs)->di : \
+	(idx) == 1 ? (unsigned long)(regs)->si : 0UL)
+#elif defined(CONFIG_ARM64)
+#define KP_GET_ARG(regs, idx) \
+	((idx) < 8 ? (unsigned long)(regs)->regs[(idx)] : 0UL)
+#endif
+
+struct _virtnet_sq_stats {
+	struct u64_stats_sync syncp;
+	u64_stats_t packets;
+	u64_stats_t bytes;
+	u64_stats_t xdp_tx;
+	u64_stats_t xdp_tx_drops;
+	u64_stats_t kicks;
+	u64_stats_t tx_timeouts;
+	u64_stats_t stop;
+	u64_stats_t wake;
+};
+
+struct _virtnet_interrupt_coalesce {
+	u32 max_packets;
+	u32 max_usecs;
+};
+
+struct _send_queue {
+	/* Virtqueue associated with this send _queue */
+	struct virtqueue *vq;
+
+	/* TX: fragments + linear part + virtio header */
+	struct scatterlist sg[MAX_SKB_FRAGS + 2];
+
+	/* Name of the send queue: output.$index */
+	char name[16];
+
+	struct _virtnet_sq_stats stats;
+
+	struct _virtnet_interrupt_coalesce intr_coal;
+
+	struct napi_struct napi;
+
+	/* Record whether sq is in reset state. */
+	bool reset;
+
+	struct xsk_buff_pool *xsk_pool;
+
+	dma_addr_t xsk_hdr_dma_addr;
+};
+
+struct _virtnet_rq_stats {
+	struct u64_stats_sync syncp;
+	u64_stats_t packets;
+	u64_stats_t bytes;
+	u64_stats_t drops;
+	u64_stats_t xdp_packets;
+	u64_stats_t xdp_tx;
+	u64_stats_t xdp_redirects;
+	u64_stats_t xdp_drops;
+	u64_stats_t kicks;
+};
+
+struct _ewma_pkt_len {
+	unsigned long internal;
+};
+
+struct _virtnet_rq_dma {
+	dma_addr_t addr;
+	u32 ref;
+	u16 len;
+	u16 need_sync;
+};
+
+struct _receive_queue {
+	/* Virtqueue associated with this receive_queue */
+	struct virtqueue *vq;
+
+	struct napi_struct napi;
+
+	struct bpf_prog __rcu *xdp_prog;
+
+	struct _virtnet_rq_stats stats;
+
+	/* The number of rx notifications */
+	u16 calls;
+
+	/* Is dynamic interrupt moderation enabled? */
+	bool dim_enabled;
+
+	/* Used to protect dim_enabled and inter_coal */
+	struct mutex dim_lock;
+
+	/* Dynamic Interrupt Moderation */
+	struct dim dim;
+
+	u32 packets_in_napi;
+
+	struct _virtnet_interrupt_coalesce intr_coal;
+
+	/* Chain pages by the private ptr. */
+	struct page *pages;
+
+	/* Average packet length for mergeable receive buffers. */
+	struct _ewma_pkt_len mrg_avg_pkt_len;
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
+	struct _virtnet_rq_dma *last_dma;
+
+	struct xsk_buff_pool *xsk_pool;
+
+	/* xdp rxq used by xsk */
+	struct xdp_rxq_info xsk_rxq_info;
+
+	struct xdp_buff **xsk_buffs;
+};
+
+#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
+
+struct _control_buf {
+	struct virtio_net_ctrl_hdr hdr;
+	virtio_net_ctrl_ack status;
+};
+
+struct _virtnet_info {
+	struct virtio_device *vdev;
+	struct virtqueue *cvq;
+	struct net_device *dev;
+	struct _send_queue *sq;
+	struct _receive_queue *rq;
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
+	struct virtio_net_rss_config_hdr *rss_hdr;
+	struct virtio_net_rss_config_trailer rss_trailer;
+	u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
+
+	/* Has control virtqueue */
+	bool has_cvq;
+
+	/* Lock to protect the control VQ */
+	struct mutex cvq_lock;
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
+	/* UDP tunnel support */
+	bool tx_tnl;
+
+	bool rx_tnl;
+
+	bool rx_tnl_csum;
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
+	/* Work struct for setting rx mode */
+	struct work_struct rx_mode_work;
+
+	/* OK to queue work setting RX mode? */
+	bool rx_mode_work_enabled;
+
+	/* Does the affinity hint is set for virtqueues? */
+
+	bool affinity_hint_set;
+
+	/* CPU hotplug instances for online & dead */
+
+	struct hlist_node node;
+
+	struct hlist_node node_dead;
+
+	struct _control_buf *ctrl;
+
+	/* Ethtool settings */
+	u8 duplex;
+	u32 speed;
+
+	/* Is rx dynamic interrupt moderation enabled? */
+	bool rx_dim_enabled;
+
+	/* Interrupt coalescing settings */
+	struct _virtnet_interrupt_coalesce intr_coal_tx;
+	struct _virtnet_interrupt_coalesce intr_coal_rx;
+
+	unsigned long guest_offloads;
+	unsigned long guest_offloads_capable;
+
+	/* failover when STANDBY feature enabled */
+	struct failover *failover;
+
+	u64 device_stats_cap;
+};
+
+
+struct _vring_desc_state_split {
+	void *data;			/* Data for callback. */
+	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
+};
+
+struct _vring_desc_extra {
+	dma_addr_t addr;		/* Descriptor DMA addr. */
+	u32 len;			/* Descriptor length. */
+	u16 flags;			/* Descriptor flags. */
+	u16 next;			/* The next desc state in a list. */
+};
+
+struct _vring_virtqueue_split {
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
+	struct _vring_desc_state_split *desc_state;
+	struct _vring_desc_extra *desc_extra;
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
+struct _vring_desc_state_packed {
+	void *data;			/* Data for callback. */
+	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
+	u16 num;			/* Descriptor list length. */
+	u16 last;			/* The last desc state in a list. */
+};
+
+struct _vring_virtqueue_packed {
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
+	struct _vring_desc_state_packed *desc_state;
+	struct _vring_desc_extra *desc_extra;
+
+	/* DMA address and size information */
+	dma_addr_t ring_dma_addr;
+	dma_addr_t driver_event_dma_addr;
+	dma_addr_t device_event_dma_addr;
+	size_t ring_size_in_bytes;
+	size_t event_size_in_bytes;
+};
+
+struct _vring_virtqueue {
+	struct virtqueue vq;
+
+	/* Is this a packed ring? */
+	bool packed_ring;
+
+	/* Is DMA API used? */
+	bool use_dma_api;
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
 
-static DEFINE_KFIFO(virtnet_mon_kfifo, char, KFIFO_SIZE);
+	/* Hint for event idx: already triggered no need to disable. */
+	bool event_triggered;
+
+	union {
+		/* Available for split ring */
+		struct _vring_virtqueue_split split;
+
+		/* Available for packed ring */
+		struct _vring_virtqueue_packed packed;
+	};
+
+	/* How to notify other side. FIXME: commonalize hcalls! */
+	bool (*notify)(struct virtqueue *vq);
+
+	/* DMA, allocation, and size information */
+	bool we_own_ring;
+
+	union virtio_map map;
+};
+
+/* RX or TX */
+enum pkt_dir {
+	PKT_DIR_UN = 0,      /* Unknown */
+	PKT_DIR_RX = 1,           /* RX */
+	PKT_DIR_TX = 2,           /* TX */
+	PKT_DIR_MAX
+};
+
+enum event_type {
+	START_XMIT_PRE_EVENT = 1,
+	START_XMIT_POST_EVENT = 2,
+};
+
+struct iph_info {
+	struct sk_buff *skb;        /* SKB */
+	u8 iph_proto;    /* iph protocol type */
+	u32 seq;         /* absolute sequence number */
+};
+
+struct queue_info {
+	struct virtqueue *vq;
+	char name[16];
+	unsigned int num_free;
+	unsigned int num;
+	__virtio16 avail_flags;
+	__virtio16 avail_idx;
+	u16 avail_flags_shadow;
+	u16 avail_idx_shadow;
+	__virtio16 used_flags;
+	__virtio16 used_idx;
+	u16 last_used_idx;
+	bool broken;
+};
+
+struct virtnet_mon_pkt_info {
+	ktime_t timestamp;           /* timestamp */
+	int cpu_id;                  /* CPU id */
+	enum event_type event_type;  /* event type */
+	enum pkt_dir dir;           /* RX or TX */
+	struct iph_info iph_info;   /* iph information */
+	struct queue_info rx_tx_queue_info;   /* rq or sq */
+};
+
+
+static DEFINE_KFIFO(virtnet_mon_kfifo, struct virtnet_mon_pkt_info, KFIFO_SIZE);
 static struct miscdevice virtnet_mon_misc_device;
 
 static DECLARE_WAIT_QUEUE_HEAD(virtnet_mon_wq);
 
+static char read_buf[READ_SIZE];
+
+static struct kprobe start_xmit_kp;
+
+/* convert pkt_dir to string */
+static const char *pkt_dir_to_str(enum pkt_dir dir)
+{
+	switch (dir) {
+	case PKT_DIR_RX:
+		return "RX";
+	case PKT_DIR_TX:
+		return "TX";
+	default:
+		return "UN";
+	}
+}
+
+/* convert protocol to string */
+static const char *protocol_to_str(u8 iph_proto)
+{
+	switch (iph_proto) {
+	case IPPROTO_TCP:
+		return "TCP";
+	case IPPROTO_UDP:
+		return "UDP";
+	case IPPROTO_ICMP:
+		return "ICMP";
+	default:
+		return "Unknown";
+	}
+}
+
+/* convert event type to string */
+static const char *event_type_to_str(enum event_type event_type)
+{
+	switch (event_type) {
+	case START_XMIT_PRE_EVENT:
+		return "START_XMIT_PRE_EVENT";
+	case START_XMIT_POST_EVENT:
+		return "START_XMIT_POST_EVENT";
+	default:
+		return "Unknown";
+	}
+}
+
+/* Format packet info to string line */
+static int format_pkt_info(const struct virtnet_mon_pkt_info *pkt_info,
+						char *line, size_t line_size)
+{
+	struct timespec64 ts;
+	int n = 0;
+	int written = 0;
+
+	if (!pkt_info || !line || line_size == 0)
+		return -EINVAL;
+
+	ts = ktime_to_timespec64(pkt_info->timestamp);
+
+	/* Format common fields: timestamp, cpu_id, dir */
+	written = scnprintf(line + n, line_size - n,
+					"%lld.%09ld cpu=%d dir=%s event_type=%s",
+					(long long)ts.tv_sec, ts.tv_nsec,
+					pkt_info->cpu_id, pkt_dir_to_str(pkt_info->dir),
+					event_type_to_str(pkt_info->event_type));
+	if (written < 0 || (size_t)written >= line_size - n)
+		return written < 0 ? written : (int)(line_size - 1);
+	n += written;
+
+	if (pkt_info->iph_info.skb) {
+		written = scnprintf(line + n, line_size - n,
+					" skb=0x%lx proto=%s seq=%u",
+					(unsigned long)pkt_info->iph_info.skb,
+					protocol_to_str(pkt_info->iph_info.iph_proto),
+					pkt_info->iph_info.seq);
+
+		if (written < 0 || (size_t)written >= line_size - n)
+			return written < 0 ? written : (int)(line_size - 1);
+		n += written;
+	}
+
+	if (pkt_info->rx_tx_queue_info.vq) {
+		written = scnprintf(line + n, line_size - n,
+			" vq=0x%lx queue=%s num_free=%u num=%u"
+			" avail_flags=%u avail_idx=%u avail_flags_shadow=%u avail_idx_shadow=%u"
+			" used_flags=%u used_idx=%u last_used_idx=%u broken=%d",
+			(unsigned long)pkt_info->rx_tx_queue_info.vq,
+			pkt_info->rx_tx_queue_info.name,
+			pkt_info->rx_tx_queue_info.num_free,
+			pkt_info->rx_tx_queue_info.num,
+			(unsigned int)(__virtio16)pkt_info->rx_tx_queue_info.avail_flags,
+			(unsigned int)(__virtio16)pkt_info->rx_tx_queue_info.avail_idx,
+			pkt_info->rx_tx_queue_info.avail_flags_shadow,
+			pkt_info->rx_tx_queue_info.avail_idx_shadow,
+			(unsigned int)(__virtio16)pkt_info->rx_tx_queue_info.used_flags,
+			(unsigned int)(__virtio16)pkt_info->rx_tx_queue_info.used_idx,
+			pkt_info->rx_tx_queue_info.last_used_idx,
+			pkt_info->rx_tx_queue_info.broken ? 1 : 0);
+
+		if (written < 0 || (size_t)written >= line_size - n)
+			return written < 0 ? written : (int)(line_size - 1);
+		n += written;
+	}
+
+	/* Add newline */
+	written = scnprintf(line + n, line_size - n, "\n");
+	if (written < 0 || (size_t)written >= line_size - n)
+		return written < 0 ? written : (int)(line_size - 1);
+	n += written;
+
+	return n;
+}
+
+/* Get ip layer information. include protocal seq ... */
+static int get_iph_info(struct sk_buff *skb, struct iph_info *iph_info)
+{
+	__be16 protocol = skb->protocol;
+	u32 seq = 0;
+
+	struct iphdr *iph;
+	struct tcphdr *th;
+	struct udphdr *uh;
+	struct icmphdr *icmph;
+
+	if (!skb || !iph_info)
+		return -EINVAL;
+
+	iph_info->skb = skb;
+
+	/* Extract ip layer information. include protocal seq ... */
+	if (protocol == htons(ETH_P_IP)) {
+		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+			return -EINVAL;
+
+		iph = ip_hdr(skb);
+		iph_info->iph_proto = iph->protocol;
+
+		if (iph->protocol == IPPROTO_TCP) {
+			if (!pskb_may_pull(skb, iph->ihl * 4 + sizeof(struct tcphdr)))
+				return -EINVAL;
+			th = tcp_hdr(skb);
+			seq = ntohl(th->seq);
+		} else if (iph->protocol == IPPROTO_UDP) {
+			if (!pskb_may_pull(skb, iph->ihl * 4 + sizeof(struct udphdr)))
+				return -EINVAL;
+			uh = udp_hdr(skb);
+			seq = ntohs(uh->source) << 16 | ntohs(uh->dest);
+		} else if (iph->protocol == IPPROTO_ICMP) {
+			if (!pskb_may_pull(skb, iph->ihl * 4 + sizeof(struct icmphdr)))
+				return -EINVAL;
+			icmph = icmp_hdr(skb);
+			seq = ntohs(icmph->un.echo.sequence);
+		}
+
+		iph_info->seq = seq;
+	}
+
+	return 0;
+}
+
+/* Get queue information */
+static int get_queue_info(struct virtqueue *_vq, struct queue_info *queue_info)
+{
+	struct _virtnet_info *vi;
+	struct _vring_virtqueue *vvq = NULL;
+	struct vring *vring = NULL;
+
+
+	if (!_vq || !queue_info)
+		return -EINVAL;
+
+	vi = _vq->vdev->priv;
+	if (!vi)
+		return -EINVAL;
+
+	queue_info->vq = _vq;
+
+	if (_vq->index % 2 == 0)
+		memcpy(&queue_info->name, vi->rq[_vq->index / 2].name, sizeof(queue_info->name));
+	else
+		memcpy(&queue_info->name, vi->sq[(_vq->index - 1) / 2].name,
+				sizeof(queue_info->name));
+
+	vvq = container_of_const(_vq, struct _vring_virtqueue, vq);
+	vring = &vvq->split.vring;
+
+	if (!vring || !vvq)
+		return -EINVAL;
+
+	queue_info->num_free = _vq->num_free;
+	queue_info->num = vring->num;
+	queue_info->last_used_idx = vvq->last_used_idx;
+	queue_info->avail_idx_shadow = vvq->split.avail_idx_shadow;
+	queue_info->avail_flags_shadow = vvq->split.avail_flags_shadow;
+	queue_info->avail_flags = vring->avail->flags;
+	queue_info->avail_idx = vring->avail->idx;
+	queue_info->used_flags = vring->used->flags;
+	queue_info->used_idx = vring->used->idx;
+	queue_info->broken = vvq->broken;
+
+	return 0;
+}
+
+/* Get common information */
+static int get_common_info(enum pkt_dir dir, enum event_type event_type,
+						struct virtnet_mon_pkt_info *info)
+{
+	if (!info)
+		return -EINVAL;
+
+	/* Initialize packet info */
+	info->timestamp = ktime_get();
+	info->cpu_id = smp_processor_id();
+	info->dir = dir;
+	info->event_type = event_type;
+
+	return 0;
+}
+
+/* Kprobe pre-handler for start_xmit */
+static int start_xmit_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct sk_buff *skb;
+	struct _virtnet_info *vi;
+	struct virtnet_mon_pkt_info info;
+	int qnum;
+
+	/* Get skb parameter (first parameter) */
+	skb = (struct sk_buff *)KP_GET_ARG(regs, 0);
+
+	memset(&info, 0, sizeof(struct virtnet_mon_pkt_info));
+
+	get_common_info(PKT_DIR_TX, START_XMIT_PRE_EVENT, &info);
+	if (get_iph_info(skb, &info.iph_info) != 0) {
+		pr_info("virtnet_mon: Failed to get iph information\n");
+		return 0;
+	}
+
+	vi = netdev_priv(skb->dev);
+	qnum = skb_get_queue_mapping(skb);
+	if (get_queue_info(vi->sq[qnum].vq, &info.rx_tx_queue_info) != 0)
+		return 0;
+
+	kfifo_in(&virtnet_mon_kfifo, &info, 1);
+	wake_up_interruptible(&virtnet_mon_wq);
+
+	return 0;
+}
+
 // open device
 static int virtnet_mon_open(struct inode *inode, struct file *file)
 {
@@ -24,7 +733,7 @@ static int virtnet_mon_open(struct inode *inode, struct file *file)
 // close device
 static int virtnet_mon_release(struct inode *inode, struct file *file)
 {
-    //pr_debug(KERN_INFO "virtnet_mon: Device closed\n");
+	//pr_debug(KERN_INFO "virtnet_mon: Device closed\n");
 
 	return 0;
 }
@@ -32,19 +741,49 @@ static int virtnet_mon_release(struct inode *inode, struct file *file)
 // read device
 static ssize_t virtnet_mon_read(struct file *file, char __user *buffer, size_t len, loff_t *offset)
 {
-	unsigned int copied;
-	char kfifo_buffer[KFIFO_SIZE];
+	struct virtnet_mon_pkt_info pkt_info;
+	char line[LINE_MAX_SIZE];
+	size_t copied = 0;
+	size_t remain;
+	int n;
+
+	if (len < LINE_MAX_SIZE)
+		return -EINVAL;
+
+	if (len == 0)
+		return 0;
 
-	// read data from kfifo
 	if (kfifo_is_empty(&virtnet_mon_kfifo))
 		return 0;
 
-	// read data and copy to user space
-	copied = kfifo_out(&virtnet_mon_kfifo, kfifo_buffer, len);
-	if (copy_to_user(buffer, kfifo_buffer, copied))
-		return -EFAULT;
+	remain = len;
+	if (remain > READ_SIZE - 1)
+		remain = READ_SIZE - 1;
+
+	read_buf[0] = '\0';
+
+	while (remain > 1) {
+		if (!kfifo_peek(&virtnet_mon_kfifo, &pkt_info))
+			break;
+
+		n = format_pkt_info(&pkt_info, line, LINE_MAX_SIZE);
+		if (n <= 0 || (size_t)n >= remain)
+			break;
+
+		if (kfifo_out(&virtnet_mon_kfifo, &pkt_info, 1) != 1)
+			break;
 
-	//pr_debug(KERN_INFO "virtnet_mon: Read %u bytes from kfifo\n", copied);
+		memcpy(read_buf + copied, line, n);
+		copied += n;
+		remain -= n;
+	}
+
+	read_buf[copied] = '\0';
+
+	if (copied > 0) {
+		if (copy_to_user(buffer, read_buf, copied))
+			return -EFAULT;
+	}
 
 	return copied;
 }
@@ -53,22 +792,18 @@ static ssize_t virtnet_mon_read(struct file *file, char __user *buffer, size_t l
 static ssize_t virtnet_mon_write(struct file *file, const char __user *buffer,
 							size_t len, loff_t *offset)
 {
-	unsigned int copied;
-	char kfifo_buffer[KFIFO_SIZE];
+	char kfifo_buffer[WRITE_SIZE];
 
 	// copy data from user space to kfifo
-	if (len > KFIFO_SIZE)
-		len = KFIFO_SIZE;
+	if (len > WRITE_SIZE)
+		len = WRITE_SIZE;
 
 	if (copy_from_user(kfifo_buffer, buffer, len))
 		return -EFAULT;
 
-	copied = kfifo_in(&virtnet_mon_kfifo, kfifo_buffer, len);
-	pr_info("virtnet_mon: Written %u bytes to kfifo\n", copied);
+	pr_info("virtnet_mon: Written: %s\n", kfifo_buffer);
 
-	wake_up_interruptible(&virtnet_mon_wq);
-
-	return copied;
+	return len;
 }
 
 // poll method
@@ -110,8 +845,20 @@ static int __init virtnet_mon_init(void)
 
 		return ret;
 	}
-
 	pr_info("virtnet_mon registered with minor number %d\n", virtnet_mon_misc_device.minor);
+
+	/* Setup kprobe for start_xmit */
+	start_xmit_kp.pre_handler = start_xmit_pre_handler;
+	start_xmit_kp.symbol_name = "start_xmit";
+
+	ret = register_kprobe(&start_xmit_kp);
+	if (ret < 0) {
+		pr_info("virtnet_mon: Failed to register kprobe for start_xmit: %d\n", ret);
+		unregister_kprobe(&start_xmit_kp);
+		return ret;
+	}
+	pr_info("virtnet_mon: Registered kprobe for start_xmit\n");
+
 	return 0;
 }
 
@@ -120,6 +867,10 @@ static void __exit virtnet_mon_exit(void)
 {
 	misc_deregister(&virtnet_mon_misc_device);
 	pr_info("virtnet_mon unregistered\n");
+
+	/* Unregister kprobes */
+	unregister_kprobe(&start_xmit_kp);
+	pr_info("virtnet_mon: Unloading module\n");
 }
 
 module_init(virtnet_mon_init);
-- 
2.43.0

