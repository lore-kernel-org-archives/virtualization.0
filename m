Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489924CE0E
	for <virtualization@lists.linux.dev>; Tue, 26 Dec 2023 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wpgjh86z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703582377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k4k4Ebf4XpIv7S4JQnnYlFgdRvKu1O82Xmor+UnmBuM=;
	b=Wpgjh86zAa7NdIKWp+OEvne7dn1JDZAjFNduQ4xUsp3F4huFCZI+6zMLV/kRZoAwM7XkMJ
	eJlYhKlbsWt8Oo4lEbdKBJzDY+kc4P+QkpXLav2XcShctXeZOYZdqOE57BpOs2wn0AUymm
	uitG9d9u4jOk4UU+yEXJ1GXv+g7tswU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-9jHEXwAcNjGJNNl5HVSBiQ-1; Tue, 26 Dec 2023 04:19:34 -0500
X-MC-Unique: 9jHEXwAcNjGJNNl5HVSBiQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-336a56ff1e5so1121063f8f.1
        for <virtualization@lists.linux.dev>; Tue, 26 Dec 2023 01:19:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703582371; x=1704187171;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4k4Ebf4XpIv7S4JQnnYlFgdRvKu1O82Xmor+UnmBuM=;
        b=JiphoGdJqeE8QZ3r2gOjNkpPRUjB7KBuL77PlPvGt6LhOaMHwgXRNj4ZoK+/GyOXFN
         K+r5Kjiwen0elw+3HMmC9NBbbHuCCE4Eef3Zat2FDGZxnNJYheQDb6Y8O2isCaWwH0cz
         7z1AoMXR7xL9MafV35aGijyfehsU9xGdhRnLO7cOMNwWolP6TWXXe5cQWb/hz0wpb3HK
         VtZM5bFKPva1gmqCp851bz/vX4qPzdU6uhAf2hvgBzwCdyzjNyVk8iAFtDyQQF5aGzW+
         lKmoaAiGXK5gkrLzH2GTVMEPSZOHbOBjy/BOeoQ3EpJEOjxARHtPtpB/XCNybenFolt+
         jY8A==
X-Gm-Message-State: AOJu0YzWXlefEyUmh/NUNBZpGzAaKd9lZf71du3lkRRSwVO4DiUCR8YX
	XoCJJL+bbdWumkNDbTdTY7q4YwPPXGZwCwhYiSu+N2US4KnhBDxh4isaTIsA388bHlRanmtrxMX
	clGBqqaTo87Vmv+cT/Vwd9YXshwFPqPglSb4=
X-Received: by 2002:a7b:cd0e:0:b0:40c:2cb4:f168 with SMTP id f14-20020a7bcd0e000000b0040c2cb4f168mr3380508wmj.56.1703582371165;
        Tue, 26 Dec 2023 01:19:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdpYxrmVzlQJxkgN8xqw8z3IZ1orszdPMd43ExiUr02+IiRGxy9xDomV3LH232XwQtaav7hQ==
X-Received: by 2002:a7b:cd0e:0:b0:40c:2cb4:f168 with SMTP id f14-20020a7bcd0e000000b0040c2cb4f168mr3380500wmj.56.1703582370842;
        Tue, 26 Dec 2023 01:19:30 -0800 (PST)
Received: from redhat.com ([2.55.177.189])
        by smtp.gmail.com with ESMTPSA id c18-20020a05600c0a5200b0040c6d559490sm20418322wmq.3.2023.12.26.01.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 01:19:30 -0800 (PST)
Date: Tue, 26 Dec 2023 04:19:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/6] virtio_net: introduce device stats feature
 and structures
Message-ID: <20231226041848-mutt-send-email-mst@kernel.org>
References: <20231222033021.20649-1-xuanzhuo@linux.alibaba.com>
 <20231222033021.20649-2-xuanzhuo@linux.alibaba.com>
 <f6cea3db-aef6-43a9-96a9-04fe42e6a1f3@linux.dev>
 <1703571463.67622-2-xuanzhuo@linux.alibaba.com>
 <20231226035811-mutt-send-email-mst@kernel.org>
 <1703581225.0317998-2-xuanzhuo@linux.alibaba.com>
 <20231226040518-mutt-send-email-mst@kernel.org>
 <1703581761.8691342-3-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1703581761.8691342-3-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Dec 26, 2023 at 05:09:21PM +0800, Xuan Zhuo wrote:
> On Tue, 26 Dec 2023 04:08:01 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Tue, Dec 26, 2023 at 05:00:25PM +0800, Xuan Zhuo wrote:
> > > On Tue, 26 Dec 2023 03:58:37 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Tue, Dec 26, 2023 at 02:17:43PM +0800, Xuan Zhuo wrote:
> > > > > On Mon, 25 Dec 2023 16:01:39 +0800, Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
> > > > > > 在 2023/12/22 11:30, Xuan Zhuo 写道:
> > > > > > > The virtio-net device stats spec:
> > > > > > >
> > > > > > > https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
> > > > > > >
> > > > > > > This commit introduces the relative feature and structures.
> > > > > >
> > > > > > Hi, Xuan
> > > > > >
> > > > > > After applying this patch series, withe ethtool version 6.5,
> > > > > > I got the following NIC statistics. But I do not find the statistics
> > > > > > mentioned in this patch series.
> > > > > > Do I miss something?
> > > > >
> > > > > This needs the new virtio-net feature VIRTIO_NET_F_DEVICE_STATS.
> > > > > You need to update the hypervisor. But the qemu may not support this.
> > > > >
> > > > > Thanks.
> > > >
> > > > Why not? Can you add this to QEMU?
> > >
> > >
> > > Yes. It is in my list.
> > >
> > > But in my plan, I want the kernel to support this firstly.
> > >
> > > Thanks.
> >
> > QEMU support would mean it's much better tested.
> > How did you test this one?
> 
> With our DPU.
> 
> Thanks.
> 

Well if QEMU support is there then Zhu Yanjun here can test it.


> >
> > >
> > > >
> > > >
> > > > >
> > > > >
> > > > > >
> > > > > > "
> > > > > > NIC statistics:
> > > > > >       rx_packets: 3434812669
> > > > > >       rx_bytes: 5168475253690
> > > > > >       rx_drops: 0
> > > > > >       rx_xdp_packets: 0
> > > > > >       rx_xdp_tx: 0
> > > > > >       rx_xdp_redirects: 0
> > > > > >       rx_xdp_drops: 0
> > > > > >       rx_kicks: 57179891
> > > > > >       tx_packets: 187694230
> > > > > >       tx_bytes: 12423799040
> > > > > >       tx_xdp_tx: 0
> > > > > >       tx_xdp_tx_drops: 0
> > > > > >       tx_kicks: 187694230
> > > > > >       tx_timeouts: 0
> > > > > >       rx_queue_0_packets: 866027381
> > > > > >       rx_queue_0_bytes: 1302726908150
> > > > > >       rx_queue_0_drops: 0
> > > > > >       rx_queue_0_xdp_packets: 0
> > > > > >       rx_queue_0_xdp_tx: 0
> > > > > >       rx_queue_0_xdp_redirects: 0
> > > > > >       rx_queue_0_xdp_drops: 0
> > > > > >       rx_queue_0_kicks: 14567691
> > > > > >       rx_queue_1_packets: 856758801
> > > > > >       rx_queue_1_bytes: 1289899049042
> > > > > >       rx_queue_1_drops: 0
> > > > > >       rx_queue_1_xdp_packets: 0
> > > > > >       rx_queue_1_xdp_tx: 0
> > > > > >       rx_queue_1_xdp_redirects: 0
> > > > > >       rx_queue_1_xdp_drops: 0
> > > > > >       rx_queue_1_kicks: 14265201
> > > > > >       rx_queue_2_packets: 839291053
> > > > > >       rx_queue_2_bytes: 1261620863886
> > > > > >       rx_queue_2_drops: 0
> > > > > >       rx_queue_2_xdp_packets: 0
> > > > > >       rx_queue_2_xdp_tx: 0
> > > > > >       rx_queue_2_xdp_redirects: 0
> > > > > >       rx_queue_2_xdp_drops: 0
> > > > > >       rx_queue_2_kicks: 13857653
> > > > > >       rx_queue_3_packets: 872735434
> > > > > >       rx_queue_3_bytes: 1314228432612
> > > > > >       rx_queue_3_drops: 0
> > > > > >       rx_queue_3_xdp_packets: 0
> > > > > >       rx_queue_3_xdp_tx: 0
> > > > > >       rx_queue_3_xdp_redirects: 0
> > > > > >       rx_queue_3_xdp_drops: 0
> > > > > >       rx_queue_3_kicks: 14489346
> > > > > >       tx_queue_0_packets: 75723
> > > > > >       tx_queue_0_bytes: 4999030
> > > > > >       tx_queue_0_xdp_tx: 0
> > > > > >       tx_queue_0_xdp_tx_drops: 0
> > > > > >       tx_queue_0_kicks: 75723
> > > > > >       tx_queue_0_timeouts: 0
> > > > > >       tx_queue_1_packets: 62262921
> > > > > >       tx_queue_1_bytes: 4134803914
> > > > > >       tx_queue_1_xdp_tx: 0
> > > > > >       tx_queue_1_xdp_tx_drops: 0
> > > > > >       tx_queue_1_kicks: 62262921
> > > > > >       tx_queue_1_timeouts: 0
> > > > > >       tx_queue_2_packets: 83
> > > > > >       tx_queue_2_bytes: 5478
> > > > > >       tx_queue_2_xdp_tx: 0
> > > > > >       tx_queue_2_xdp_tx_drops: 0
> > > > > >       tx_queue_2_kicks: 83
> > > > > >       tx_queue_2_timeouts: 0
> > > > > >       tx_queue_3_packets: 125355503
> > > > > >       tx_queue_3_bytes: 8283990618
> > > > > >       tx_queue_3_xdp_tx: 0
> > > > > >       tx_queue_3_xdp_tx_drops: 0
> > > > > >       tx_queue_3_kicks: 125355503
> > > > > >       tx_queue_3_timeouts: 0
> > > > > > "
> > > > > >
> > > > > > >
> > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > ---
> > > > > > >   include/uapi/linux/virtio_net.h | 137 ++++++++++++++++++++++++++++++++
> > > > > > >   1 file changed, 137 insertions(+)
> > > > > > >
> > > > > > > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> > > > > > > index cc65ef0f3c3e..129e0871d28f 100644
> > > > > > > --- a/include/uapi/linux/virtio_net.h
> > > > > > > +++ b/include/uapi/linux/virtio_net.h
> > > > > > > @@ -56,6 +56,7 @@
> > > > > > >   #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
> > > > > > >   					 * Steering */
> > > > > > >   #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> > > > > > > +#define VIRTIO_NET_F_DEVICE_STATS 50	/* Device can provide device-level statistics. */
> > > > > > >   #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
> > > > > > >   #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
> > > > > > >   #define VIRTIO_NET_F_GUEST_USO4	54	/* Guest can handle USOv4 in. */
> > > > > > > @@ -406,4 +407,140 @@ struct  virtio_net_ctrl_coal_vq {
> > > > > > >   	struct virtio_net_ctrl_coal coal;
> > > > > > >   };
> > > > > > >
> > > > > > > +/*
> > > > > > > + * Device Statistics
> > > > > > > + */
> > > > > > > +#define VIRTIO_NET_CTRL_STATS         8
> > > > > > > +#define VIRTIO_NET_CTRL_STATS_QUERY   0
> > > > > > > +#define VIRTIO_NET_CTRL_STATS_GET     1
> > > > > > > +
> > > > > > > +struct virtio_net_stats_capabilities {
> > > > > > > +
> > > > > > > +#define VIRTIO_NET_STATS_TYPE_CVQ       (1L << 32)
> > > > > > > +
> > > > > > > +#define VIRTIO_NET_STATS_TYPE_RX_BASIC  (1 << 0)
> > > > > > > +#define VIRTIO_NET_STATS_TYPE_RX_CSUM   (1 << 1)
> > > > > > > +#define VIRTIO_NET_STATS_TYPE_RX_GSO    (1 << 2)
> > > > > > > +#define VIRTIO_NET_STATS_TYPE_RX_SPEED  (1 << 3)
> > > > > > > +
> > > > > > > +#define VIRTIO_NET_STATS_TYPE_TX_BASIC  (1 << 16)
> > > > > > > +#define VIRTIO_NET_STATS_TYPE_TX_CSUM   (1 << 17)
> > > > > > > +#define VIRTIO_NET_STATS_TYPE_TX_GSO    (1 << 18)
> > > > > > > +#define VIRTIO_NET_STATS_TYPE_TX_SPEED  (1 << 19)
> > > > > > > +
> > > > > > > +	__le64 supported_stats_types[1];
> > > > > > > +};
> > > > > > > +
> > > > > > > +struct virtio_net_ctrl_queue_stats {
> > > > > > > +	struct {
> > > > > > > +		__le16 vq_index;
> > > > > > > +		__le16 reserved[3];
> > > > > > > +		__le64 types_bitmap[1];
> > > > > > > +	} stats[1];
> > > > > > > +};
> > > > > > > +
> > > > > > > +struct virtio_net_stats_reply_hdr {
> > > > > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_CVQ       32
> > > > > > > +
> > > > > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_BASIC  0
> > > > > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_CSUM   1
> > > > > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_GSO    2
> > > > > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_SPEED  3
> > > > > > > +
> > > > > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_BASIC  16
> > > > > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_CSUM   17
> > > > > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_GSO    18
> > > > > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_SPEED  19
> > > > > > > +	u8 type;
> > > > > > > +	u8 reserved;
> > > > > > > +	__le16 vq_index;
> > > > > > > +	__le16 reserved1;
> > > > > > > +	__le16 size;
> > > > > > > +};
> > > > > > > +
> > > > > > > +struct virtio_net_stats_cvq {
> > > > > > > +	struct virtio_net_stats_reply_hdr hdr;
> > > > > > > +
> > > > > > > +	__le64 command_num;
> > > > > > > +	__le64 ok_num;
> > > > > > > +};
> > > > > > > +
> > > > > > > +struct virtio_net_stats_rx_basic {
> > > > > > > +	struct virtio_net_stats_reply_hdr hdr;
> > > > > > > +
> > > > > > > +	__le64 rx_notifications;
> > > > > > > +
> > > > > > > +	__le64 rx_packets;
> > > > > > > +	__le64 rx_bytes;
> > > > > > > +
> > > > > > > +	__le64 rx_interrupts;
> > > > > > > +
> > > > > > > +	__le64 rx_drops;
> > > > > > > +	__le64 rx_drop_overruns;
> > > > > > > +};
> > > > > > > +
> > > > > > > +struct virtio_net_stats_tx_basic {
> > > > > > > +	struct virtio_net_stats_reply_hdr hdr;
> > > > > > > +
> > > > > > > +	__le64 tx_notifications;
> > > > > > > +
> > > > > > > +	__le64 tx_packets;
> > > > > > > +	__le64 tx_bytes;
> > > > > > > +
> > > > > > > +	__le64 tx_interrupts;
> > > > > > > +
> > > > > > > +	__le64 tx_drops;
> > > > > > > +	__le64 tx_drop_malformed;
> > > > > > > +};
> > > > > > > +
> > > > > > > +struct virtio_net_stats_rx_csum {
> > > > > > > +	struct virtio_net_stats_reply_hdr hdr;
> > > > > > > +
> > > > > > > +	__le64 rx_csum_valid;
> > > > > > > +	__le64 rx_needs_csum;
> > > > > > > +	__le64 rx_csum_none;
> > > > > > > +	__le64 rx_csum_bad;
> > > > > > > +};
> > > > > > > +
> > > > > > > +struct virtio_net_stats_tx_csum {
> > > > > > > +	struct virtio_net_stats_reply_hdr hdr;
> > > > > > > +
> > > > > > > +	__le64 tx_csum_none;
> > > > > > > +	__le64 tx_needs_csum;
> > > > > > > +};
> > > > > > > +
> > > > > > > +struct virtio_net_stats_rx_gso {
> > > > > > > +	struct virtio_net_stats_reply_hdr hdr;
> > > > > > > +
> > > > > > > +	__le64 rx_gso_packets;
> > > > > > > +	__le64 rx_gso_bytes;
> > > > > > > +	__le64 rx_gso_packets_coalesced;
> > > > > > > +	__le64 rx_gso_bytes_coalesced;
> > > > > > > +};
> > > > > > > +
> > > > > > > +struct virtio_net_stats_tx_gso {
> > > > > > > +	struct virtio_net_stats_reply_hdr hdr;
> > > > > > > +
> > > > > > > +	__le64 tx_gso_packets;
> > > > > > > +	__le64 tx_gso_bytes;
> > > > > > > +	__le64 tx_gso_segments;
> > > > > > > +	__le64 tx_gso_segments_bytes;
> > > > > > > +	__le64 tx_gso_packets_noseg;
> > > > > > > +	__le64 tx_gso_bytes_noseg;
> > > > > > > +};
> > > > > > > +
> > > > > > > +struct virtio_net_stats_rx_speed {
> > > > > > > +	struct virtio_net_stats_reply_hdr hdr;
> > > > > > > +
> > > > > > > +	__le64 rx_packets_allowance_exceeded;
> > > > > > > +	__le64 rx_bytes_allowance_exceeded;
> > > > > > > +};
> > > > > > > +
> > > > > > > +struct virtio_net_stats_tx_speed {
> > > > > > > +	struct virtio_net_stats_reply_hdr hdr;
> > > > > > > +
> > > > > > > +	__le64 tx_packets_allowance_exceeded;
> > > > > > > +	__le64 tx_bytes_allowance_exceeded;
> > > > > > > +};
> > > > > > > +
> > > > > > >   #endif /* _UAPI_LINUX_VIRTIO_NET_H */
> > > > > >
> > > >
> > > >
> >

