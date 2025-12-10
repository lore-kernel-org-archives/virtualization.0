Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA961A724C
	for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765357415; cv=none; b=JNXZ60Zlo56y9gU4T78S87zWP+l182YYFW5iD+flcvX1WaBVqs6lecV/f+lE2LsXZY9wUopJhHS3USM8TEcrBjqQl3Iaq0doc+MnI80GQARVw7GwHmofEpIZobbhd89LeUAE4Ub5+E4svWbGwTw9GST+DMeOl3EfO6qZOKJFo0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765357415; c=relaxed/simple;
	bh=YCxbT7StcCsTSTbreVdSVsRc6TSbBB7zTsNuWzWa9zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LujxdUhyMO271xOirH1rQkjxz2rwrLka8vaGUh3H/qQXUIFVErybZQc91oESs1pz+2I7YbqSguFiCpCD4IW23CoQnqOnyGcbj0n+7uZLF7gqJ6IMLVy7Ib/fgn8MjMQY7i94isethxOZaHpcHo5wh0vJt/Ca9HpQbmM5meieNS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAU4OdK6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAU4OdK6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765357407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9GHk20LK7pXMd/axVEWCyOTPc98kp9aGBB5Mkc417YA=;
	b=eAU4OdK6r4nTfNfr82KTn29wvaHVnQbcraXjJj9qKrJEMyjZVvSGwV+Z90V4RC6wxMpw7u
	IJmjgKSAj5yqq5vBGmIVQuXqvfEslPFYQdpbVeLFYnf/Z9eHSWdjhPrzedpwUIS/YTtcRm
	ysngHnFDoKIFPV641qO/aCjI0p3Mv/0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-k70IgZ5HOGqfDezDZGUV9Q-1; Wed, 10 Dec 2025 04:03:26 -0500
X-MC-Unique: k70IgZ5HOGqfDezDZGUV9Q-1
X-Mimecast-MFC-AGG-ID: k70IgZ5HOGqfDezDZGUV9Q_1765357405
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b2ad29140so2832379f8f.0
        for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 01:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765357405; x=1765962205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GHk20LK7pXMd/axVEWCyOTPc98kp9aGBB5Mkc417YA=;
        b=UlMjrsjpkfyZD9dux72mtVJ7aWXilkK/riGy3rcdV67JirigKx4rSJzbbsK+GSCb8W
         o1zjvXCCQhUYEdSBOYDug1v89c1MVzaUYInT3WDAle7PCsw+H9eC2Xz7u07Q9HOFfWKO
         pZKmzqyCTGW1uoOnX1Ff4DrjX8mbcm6e28nzruDjwLa2a/Wdm1tz3O2MtlMoOBKBPl8a
         Znfmvdw1Z49VZjGgTS1WxY/6ke45fINC1W+FayvckkwqzTFhf2e60/n8EfTJ1Sf5WwwG
         7UsM0gZuQJT+cMeuRisaq3UB6OqlOIk2P3y94C+h8kpLWgJaVIG0Y8eou+rqR97EtxJa
         xqKw==
X-Forwarded-Encrypted: i=1; AJvYcCXxqv+QS4Imm7D6UjAlHmWKSR3HT/E/ig+nsYmTAaTqYBaN6j5T40iR2FJJZdzg+qHfaXlBExlb2Y7yuD8ptg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzbmtg/kJGnCrksnvgnyZhxvyM+Guv/eu+kCkxsa5UnKHiQcPbj
	1tEqRpyElbp33lZD2As41/g95rjs+SDxcJ8U3xPGUrdEB70mxW3len2Mag2gZEZx2qRLz03Tonl
	1JonLYlHbv9xBAk/DMFRl87WxftpP+/bRkb7LKMqraE28qEJGBK4e+RBRdZqffrLQLKYwO1By9j
	NN
X-Gm-Gg: AY/fxX45UOr56ali3USAERurCjwo5oomWMv7NE0YDPvlg/yvxiRPmjc6D/RtusFXZXI
	+Qa5oPJakxGZg8QtGl/RSTNJsInAF4ZEyHNLIGvfG7TUM/NAdrsghhDO9GpL+1CaWL+wYKIAh8l
	5bYN71+QWD9jQyOxCazd7WxzJn+WSd3JMkaHEEwmiW2EM1nhiBCOzT+APJdQo62jhA2RNqo+YW8
	JM6YGb03XTxnHh2/239TQqj0jlvjUCL9PAg69v3cmVrK+5410karbqn6qjCHWEfxyGEwbpGyIz7
	sHvKS04lmSj3Cx+A4TgA4tvFySs4ffiD4XrZJ0ZgD3irp/XVE0l8Z0XreAdYm8L6lRKmLPqgYA0
	lVacWhQrDZoXWPJ4J/FxWXcgI98yaraM=
X-Received: by 2002:a05:6000:402c:b0:42b:2f79:755e with SMTP id ffacd0b85a97d-42fa39d8607mr1748007f8f.3.1765357404821;
        Wed, 10 Dec 2025 01:03:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFytng6S2XdTu+AfI2mAHGEVbvApsL/MVXZxH/a8nIsx/iEEVQs9TIwgv0WPAN1i7z1d4gIiQ==
X-Received: by 2002:a05:6000:402c:b0:42b:2f79:755e with SMTP id ffacd0b85a97d-42fa39d8607mr1747952f8f.3.1765357404249;
        Wed, 10 Dec 2025 01:03:24 -0800 (PST)
Received: from redhat.com (IGLD-80-230-33-27.inter.net.il. [80.230.33.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbe9065sm36180052f8f.8.2025.12.10.01.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 01:03:23 -0800 (PST)
Date: Wed, 10 Dec 2025 04:03:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Longjun Tang <lange_tang@163.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, tanglongjun@kylinos.cn,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v1 3/7] tools/virtio/virtnet_mon: add kprobe start_xmit
Message-ID: <20251210040228-mutt-send-email-mst@kernel.org>
References: <20251127032407.33475-1-lange_tang@163.com>
 <20251127032407.33475-4-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251127032407.33475-4-lange_tang@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ktvXsB1hVCNpDU9HOYl4ZfOdpMxg6UaytpwrN3xvZ3w_1765357405
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 27, 2025 at 11:24:03AM +0800, Longjun Tang wrote:
> From: Tang Longjun <tanglongjun@kylinos.cn>
> 
> track skb and virtqueue through the kprobe start_xmit function
> 
> Signed-off-by: Tang Longjun <tanglongjun@kylinos.cn>
> ---
>  tools/virtio/virtnet_mon/virtnet_mon.c | 793 ++++++++++++++++++++++++-
>  1 file changed, 772 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/virtio/virtnet_mon/virtnet_mon.c b/tools/virtio/virtnet_mon/virtnet_mon.c
> index 696e621cf803..36b51d0a13d4 100644
> --- a/tools/virtio/virtnet_mon/virtnet_mon.c
> +++ b/tools/virtio/virtnet_mon/virtnet_mon.c
> @@ -6,15 +6,724 @@
>  #include <linux/uaccess.h>
>  #include <linux/miscdevice.h>
>  #include <linux/poll.h>
> +#include <linux/string.h>
> +#include <linux/if_ether.h>
> +
> +#include <linux/kprobes.h>
> +#include <linux/netdevice.h>
> +#include <linux/skbuff.h>
> +#include <linux/ip.h>
> +#include <linux/ipv6.h>
> +#include <linux/tcp.h>
> +#include <linux/udp.h>
> +#include <linux/icmp.h>
> +#include <linux/icmpv6.h>
> +#include <linux/version.h>
> +#include <linux/time.h>
> +#include <linux/smp.h>
> +#include <linux/virtio.h>
> +#include <linux/scatterlist.h>
> +#include <linux/bpf.h>
> +#include <linux/dim.h>
> +#include <linux/mutex.h>
> +#include <linux/workqueue.h>
> +#include <linux/spinlock.h>
> +
> +#include <linux/u64_stats_sync.h>
> +#include <linux/mm_types_task.h>
> +#include <linux/virtio_net.h>
> +#include <linux/virtio_ring.h>
> +#include <net/xdp.h>
> +
>  
>  #define DEVICE_NAME "virtnet_mon"
> -#define KFIFO_SIZE 1024     // ring buffer size
> +#define KFIFO_SIZE 65536     // ring buffer size
> +#define WRITE_SIZE 1024
> +#define READ_SIZE 16384
> +#define LINE_MAX_SIZE 1024
> +
> +#if defined(CONFIG_X86_64)
> +#define KP_GET_ARG(regs, idx) \
> +	((idx) == 0 ? (unsigned long)(regs)->di : \
> +	(idx) == 1 ? (unsigned long)(regs)->si : 0UL)
> +#elif defined(CONFIG_ARM64)
> +#define KP_GET_ARG(regs, idx) \
> +	((idx) < 8 ? (unsigned long)(regs)->regs[(idx)] : 0UL)
> +#endif
> +
> +struct _virtnet_sq_stats {
> +	struct u64_stats_sync syncp;
> +	u64_stats_t packets;
> +	u64_stats_t bytes;
> +	u64_stats_t xdp_tx;
> +	u64_stats_t xdp_tx_drops;
> +	u64_stats_t kicks;
> +	u64_stats_t tx_timeouts;
> +	u64_stats_t stop;
> +	u64_stats_t wake;
> +};
> +
> +struct _virtnet_interrupt_coalesce {
> +	u32 max_packets;
> +	u32 max_usecs;
> +};
> +
> +struct _send_queue {
> +	/* Virtqueue associated with this send _queue */
> +	struct virtqueue *vq;
> +
> +	/* TX: fragments + linear part + virtio header */
> +	struct scatterlist sg[MAX_SKB_FRAGS + 2];
> +
> +	/* Name of the send queue: output.$index */
> +	char name[16];
> +
> +	struct _virtnet_sq_stats stats;
> +
> +	struct _virtnet_interrupt_coalesce intr_coal;
> +
> +	struct napi_struct napi;
> +
> +	/* Record whether sq is in reset state. */
> +	bool reset;
> +
> +	struct xsk_buff_pool *xsk_pool;
> +
> +	dma_addr_t xsk_hdr_dma_addr;
> +};
> +
> +struct _virtnet_rq_stats {
> +	struct u64_stats_sync syncp;
> +	u64_stats_t packets;
> +	u64_stats_t bytes;
> +	u64_stats_t drops;
> +	u64_stats_t xdp_packets;
> +	u64_stats_t xdp_tx;
> +	u64_stats_t xdp_redirects;
> +	u64_stats_t xdp_drops;
> +	u64_stats_t kicks;
> +};
> +
> +struct _ewma_pkt_len {
> +	unsigned long internal;
> +};
> +
> +struct _virtnet_rq_dma {
> +	dma_addr_t addr;
> +	u32 ref;
> +	u16 len;
> +	u16 need_sync;
> +};
> +
> +struct _receive_queue {
> +	/* Virtqueue associated with this receive_queue */
> +	struct virtqueue *vq;
> +
> +	struct napi_struct napi;
> +
> +	struct bpf_prog __rcu *xdp_prog;
> +
> +	struct _virtnet_rq_stats stats;
> +
> +	/* The number of rx notifications */
> +	u16 calls;
> +
> +	/* Is dynamic interrupt moderation enabled? */
> +	bool dim_enabled;
> +
> +	/* Used to protect dim_enabled and inter_coal */
> +	struct mutex dim_lock;
> +
> +	/* Dynamic Interrupt Moderation */
> +	struct dim dim;
> +
> +	u32 packets_in_napi;
> +
> +	struct _virtnet_interrupt_coalesce intr_coal;
> +
> +	/* Chain pages by the private ptr. */
> +	struct page *pages;
> +
> +	/* Average packet length for mergeable receive buffers. */
> +	struct _ewma_pkt_len mrg_avg_pkt_len;
> +
> +	/* Page frag for packet buffer allocation. */
> +	struct page_frag alloc_frag;
> +
> +	/* RX: fragments + linear part + virtio header */
> +	struct scatterlist sg[MAX_SKB_FRAGS + 2];
> +
> +	/* Min single buffer size for mergeable buffers case. */
> +	unsigned int min_buf_len;
> +
> +	/* Name of this receive queue: input.$index */
> +	char name[16];
> +
> +	struct xdp_rxq_info xdp_rxq;
> +
> +	/* Record the last dma info to free after new pages is allocated. */
> +	struct _virtnet_rq_dma *last_dma;
> +
> +	struct xsk_buff_pool *xsk_pool;
> +
> +	/* xdp rxq used by xsk */
> +	struct xdp_rxq_info xsk_rxq_info;
> +
> +	struct xdp_buff **xsk_buffs;
> +};
> +
> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> +
> +struct _control_buf {
> +	struct virtio_net_ctrl_hdr hdr;
> +	virtio_net_ctrl_ack status;
> +};
> +
> +struct _virtnet_info {
> +	struct virtio_device *vdev;
> +	struct virtqueue *cvq;
> +	struct net_device *dev;
> +	struct _send_queue *sq;
> +	struct _receive_queue *rq;
> +	unsigned int status;
> +
> +	/* Max # of queue pairs supported by the device */
> +	u16 max_queue_pairs;
> +
> +	/* # of queue pairs currently used by the driver */
> +	u16 curr_queue_pairs;
> +
> +	/* # of XDP queue pairs currently used by the driver */
> +	u16 xdp_queue_pairs;
> +
> +	/* xdp_queue_pairs may be 0, when xdp is already loaded. So add this. */
> +	bool xdp_enabled;
> +
> +	/* I like... big packets and I cannot lie! */
> +	bool big_packets;
> +
> +	/* number of sg entries allocated for big packets */
> +	unsigned int big_packets_num_skbfrags;
> +
> +	/* Host will merge rx buffers for big packets (shake it! shake it!) */
> +	bool mergeable_rx_bufs;
> +
> +	/* Host supports rss and/or hash report */
> +	bool has_rss;
> +	bool has_rss_hash_report;
> +	u8 rss_key_size;
> +	u16 rss_indir_table_size;
> +	u32 rss_hash_types_supported;
> +	u32 rss_hash_types_saved;
> +	struct virtio_net_rss_config_hdr *rss_hdr;
> +	struct virtio_net_rss_config_trailer rss_trailer;
> +	u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> +
> +	/* Has control virtqueue */
> +	bool has_cvq;
> +
> +	/* Lock to protect the control VQ */
> +	struct mutex cvq_lock;
> +
> +	/* Host can handle any s/g split between our header and packet data */
> +	bool any_header_sg;
> +
> +	/* Packet virtio header size */
> +	u8 hdr_len;
> +
> +	/* Work struct for delayed refilling if we run low on memory. */
> +	struct delayed_work refill;
> +
> +	/* UDP tunnel support */
> +	bool tx_tnl;
> +
> +	bool rx_tnl;
> +
> +	bool rx_tnl_csum;
> +
> +	/* Is delayed refill enabled? */
> +	bool refill_enabled;
> +
> +	/* The lock to synchronize the access to refill_enabled */
> +	spinlock_t refill_lock;
> +
> +	/* Work struct for config space updates */
> +	struct work_struct config_work;
> +
> +	/* Work struct for setting rx mode */
> +	struct work_struct rx_mode_work;
> +
> +	/* OK to queue work setting RX mode? */
> +	bool rx_mode_work_enabled;
> +
> +	/* Does the affinity hint is set for virtqueues? */
> +
> +	bool affinity_hint_set;
> +
> +	/* CPU hotplug instances for online & dead */
> +
> +	struct hlist_node node;
> +
> +	struct hlist_node node_dead;
> +
> +	struct _control_buf *ctrl;
> +
> +	/* Ethtool settings */
> +	u8 duplex;
> +	u32 speed;
> +
> +	/* Is rx dynamic interrupt moderation enabled? */
> +	bool rx_dim_enabled;
> +
> +	/* Interrupt coalescing settings */
> +	struct _virtnet_interrupt_coalesce intr_coal_tx;
> +	struct _virtnet_interrupt_coalesce intr_coal_rx;
> +
> +	unsigned long guest_offloads;
> +	unsigned long guest_offloads_capable;
> +
> +	/* failover when STANDBY feature enabled */
> +	struct failover *failover;
> +
> +	u64 device_stats_cap;
> +};
> +
> +
> +struct _vring_desc_state_split {
> +	void *data;			/* Data for callback. */
> +	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
> +};
> +
> +struct _vring_desc_extra {
> +	dma_addr_t addr;		/* Descriptor DMA addr. */
> +	u32 len;			/* Descriptor length. */
> +	u16 flags;			/* Descriptor flags. */
> +	u16 next;			/* The next desc state in a list. */
> +};
> +
> +struct _vring_virtqueue_split {
> +	/* Actual memory layout for this queue. */
> +	struct vring vring;
> +
> +	/* Last written value to avail->flags */
> +	u16 avail_flags_shadow;
> +
> +	/*
> +	 * Last written value to avail->idx in
> +	 * guest byte order.
> +	 */
> +	u16 avail_idx_shadow;
> +
> +	/* Per-descriptor state. */
> +	struct _vring_desc_state_split *desc_state;
> +	struct _vring_desc_extra *desc_extra;
> +
> +	/* DMA address and size information */
> +	dma_addr_t queue_dma_addr;
> +	size_t queue_size_in_bytes;
> +
> +	/*
> +	 * The parameters for creating vrings are reserved for creating new
> +	 * vring.
> +	 */
> +	u32 vring_align;
> +	bool may_reduce_num;
> +};
> +
> +struct _vring_desc_state_packed {
> +	void *data;			/* Data for callback. */
> +	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
> +	u16 num;			/* Descriptor list length. */
> +	u16 last;			/* The last desc state in a list. */
> +};
> +
> +struct _vring_virtqueue_packed {
> +	/* Actual memory layout for this queue. */
> +	struct {
> +		unsigned int num;
> +		struct vring_packed_desc *desc;
> +		struct vring_packed_desc_event *driver;
> +		struct vring_packed_desc_event *device;
> +	} vring;
> +
> +	/* Driver ring wrap counter. */
> +	bool avail_wrap_counter;
> +
> +	/* Avail used flags. */
> +	u16 avail_used_flags;
> +
> +	/* Index of the next avail descriptor. */
> +	u16 next_avail_idx;
> +
> +	/*
> +	 * Last written value to driver->flags in
> +	 * guest byte order.
> +	 */
> +	u16 event_flags_shadow;
> +
> +	/* Per-descriptor state. */
> +	struct _vring_desc_state_packed *desc_state;
> +	struct _vring_desc_extra *desc_extra;
> +
> +	/* DMA address and size information */
> +	dma_addr_t ring_dma_addr;
> +	dma_addr_t driver_event_dma_addr;
> +	dma_addr_t device_event_dma_addr;
> +	size_t ring_size_in_bytes;
> +	size_t event_size_in_bytes;
> +};
> +
> +struct _vring_virtqueue {
> +	struct virtqueue vq;
> +
> +	/* Is this a packed ring? */
> +	bool packed_ring;
> +
> +	/* Is DMA API used? */
> +	bool use_dma_api;
> +
> +	/* Can we use weak barriers? */
> +	bool weak_barriers;
> +
> +	/* Other side has made a mess, don't try any more. */
> +	bool broken;
> +
> +	/* Host supports indirect buffers */
> +	bool indirect;
> +
> +	/* Host publishes avail event idx */
> +	bool event;
> +
> +	/* Head of free buffer list. */
> +	unsigned int free_head;
> +	/* Number we've added since last sync. */
> +	unsigned int num_added;
> +
> +	/* Last used index  we've seen.
> +	 * for split ring, it just contains last used index
> +	 * for packed ring:
> +	 * bits up to VRING_PACKED_EVENT_F_WRAP_CTR include the last used index.
> +	 * bits from VRING_PACKED_EVENT_F_WRAP_CTR include the used wrap counter.
> +	 */
> +	u16 last_used_idx;
>  
> -static DEFINE_KFIFO(virtnet_mon_kfifo, char, KFIFO_SIZE);
> +	/* Hint for event idx: already triggered no need to disable. */
> +	bool event_triggered;
> +
> +	union {
> +		/* Available for split ring */
> +		struct _vring_virtqueue_split split;
> +
> +		/* Available for packed ring */
> +		struct _vring_virtqueue_packed packed;
> +	};
> +
> +	/* How to notify other side. FIXME: commonalize hcalls! */
> +	bool (*notify)(struct virtqueue *vq);
> +
> +	/* DMA, allocation, and size information */
> +	bool we_own_ring;
> +
> +	union virtio_map map;
> +};
> +
> +/* RX or TX */
> +enum pkt_dir {
> +	PKT_DIR_UN = 0,      /* Unknown */
> +	PKT_DIR_RX = 1,           /* RX */
> +	PKT_DIR_TX = 2,           /* TX */
> +	PKT_DIR_MAX
> +};
> +
> +enum event_type {
> +	START_XMIT_PRE_EVENT = 1,
> +	START_XMIT_POST_EVENT = 2,
> +};
> +
> +struct iph_info {
> +	struct sk_buff *skb;        /* SKB */
> +	u8 iph_proto;    /* iph protocol type */
> +	u32 seq;         /* absolute sequence number */
> +};
> +
> +struct queue_info {
> +	struct virtqueue *vq;
> +	char name[16];
> +	unsigned int num_free;
> +	unsigned int num;
> +	__virtio16 avail_flags;
> +	__virtio16 avail_idx;
> +	u16 avail_flags_shadow;
> +	u16 avail_idx_shadow;
> +	__virtio16 used_flags;
> +	__virtio16 used_idx;
> +	u16 last_used_idx;
> +	bool broken;
> +};


Not at all excited about all the code duplication going on here.

