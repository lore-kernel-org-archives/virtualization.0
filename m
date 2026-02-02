Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182BC2D97A5
	for <virtualization@lists.linux.dev>; Mon,  2 Feb 2026 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770019181; cv=none; b=EgwI1swow+tZmIPWDrO0N31OvFkN66t2cIliRoxcHmE1gAp0IwIPGA8iwpnBe1dshGRv+QnzgokmeysUATVn8Os0kuXOz5Wb1v03VFjhx0q+0P+cD01EOKHruUfiMc68RcOeijFm9XvxLc81qs5oAXZF54lxhjnNvhe33gwlgV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770019181; c=relaxed/simple;
	bh=gjneGoWxHALdU8GQA1yNRD5tWtF45ZQOghEiHUhCkhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pSeu39Kwls/3rGbPQmU12HPHHN+Y0K/EW5EF8HOYWtp1riU3oodGaLDSLvzAB3XuFpRBdqsXKxKPql5CQA7vFEX09aka7M5vxSH0BaRYDQgpXnMd2U+ZICqhDrqarBd0wpSIxCdkM2wyV6OVKePfb8T2nZrERF95uVClI0qCilY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dFDR2SBR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFDR2SBR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770019178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DUdYTNDY3+ArzbH2XqDLfxrZg+wmSQMN8VZo/kU83No=;
	b=dFDR2SBR2IvMGkGxqddtM0BGAknirVeq4cdsyKj4SHSghydjO7E0ek2GRZG51M75jDtizs
	TLNRUO2xF9jNR4tmv0SLL7v6gfUtERWmvAvibQs70Q9IR+10unsF1YUDLSYHjYHDFitIVj
	0xyxDEnA1MCkURqxpy2dgW3M6vExLOE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-ijFefx-6NMmNb0QkctNrCw-1; Mon, 02 Feb 2026 02:59:36 -0500
X-MC-Unique: ijFefx-6NMmNb0QkctNrCw-1
X-Mimecast-MFC-AGG-ID: ijFefx-6NMmNb0QkctNrCw_1770019176
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4806cfffca6so49554165e9.2
        for <virtualization@lists.linux.dev>; Sun, 01 Feb 2026 23:59:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770019175; x=1770623975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUdYTNDY3+ArzbH2XqDLfxrZg+wmSQMN8VZo/kU83No=;
        b=wFxwBLYUUXQoa3prSFym+qoxBSftfDlPgs2ZgkBYqvy3VvznfKY3wG1kJ6t/ICXa25
         +JWRX+h24gFtmEFD+nnk7Lki/jIvyzHEVtzfXCJonsPz3SC71Jnyf6y5Wc9w/4oV/O1v
         5E8Gxs42khXJEAVS4F4+P6m04CgQ7T9YV/FRIej88HXPGZnOZO/1LeOznrqXVt1FbhD7
         NMurgXI6APrAnc2f4vWusEYu4U2OH+5ieodhy3b62P1Pn6OzODimM/ipw9Q5+jeHJonV
         SamlyEhB4uKut0+R4Wn2i+npZxouxNuf2rw+45AVPh7I67qJnil4BqTmrQriBv4Swhwn
         uwww==
X-Forwarded-Encrypted: i=1; AJvYcCVou+rL1KmqQ0viLns+/TxwQPsfVxau58GN9az9UWUEsLpUBf64hVqeV0Sg1KcVsL/UC5yw2W4tLlUyey8drQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzbXD+A4yCiF8H0iDHYneu6DdrG6dPGuBz+1Hk5efwKc4gQFVtT
	sdT00Y33GAVDHRxVz86Qzp0fjFRynmQeGDoQ4ygIy3P2Qtunjq6SuxWLOHXx0SDKbnk3Jxj4ZZv
	V3T5yDX+O+e++CYIvQLNZI9bpsQuhCj6dN4jtFm7IgJChcLzI91Cgv2Orr2hz5g2eoB/t
X-Gm-Gg: AZuq6aK7UT8g/auaYvyZ1INOY3WYC5kg54S0J0occjyHg3IRztnDr8ha/WSe5M7KnCV
	Wlsc8HIOUXa0qhk67L4YyO/u/5gpcLjBRgtThLbmu2yYZ+mJIZIt1egmrMmJrkJw9tDiWOsLIw1
	Ba0ynkGL7+2cf1RbdFSvAmXwWzlvg5OkYWp665fo9TebiHRO5W5u6B8vSC8YY8ealIYiLlOhtiq
	JNf5eFuxd7stxHn79j/8GQJialI+w7/YxkmEbPR6Fly5CweuCv5WFphyrqxH3JKApoORV+IY5bV
	8dFr9fjJQ7D6AiexPRaeMr59r7HBAfXUQbUmYUMtcjgFSG0bg/ij+YWlv9ZYajEyapLlhFLMH/+
	hdf2XWLSIKmJdwAF1w9W3V3eBZNwIqY246Q==
X-Received: by 2002:a05:600c:8b42:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-482db49728bmr116146645e9.32.1770019175448;
        Sun, 01 Feb 2026 23:59:35 -0800 (PST)
X-Received: by 2002:a05:600c:8b42:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-482db49728bmr116146405e9.32.1770019174868;
        Sun, 01 Feb 2026 23:59:34 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce5ec6bsm404156725e9.15.2026.02.01.23.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 23:59:34 -0800 (PST)
Date: Mon, 2 Feb 2026 02:59:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/2] virtio-net: support receive timestamp
Message-ID: <20260202025322-mutt-send-email-mst@kernel.org>
References: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
 <20260129-v6-7-topic-virtio-net-ptp-v2-2-30a27dc52760@pengutronix.de>
 <willemdebruijn.kernel.37516e24f10fa@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <willemdebruijn.kernel.37516e24f10fa@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ABKj96R3IHsjH7BCpWP76tXDzfEyOMRY1e941XUKT7U_1770019176
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 01, 2026 at 04:05:54PM -0500, Willem de Bruijn wrote:
> Steffen Trumtrar wrote:
> > Add optional hardware rx timestamp offload for virtio-net.
> > 
> > Introduce virtio feature VIRTIO_NET_F_TSTAMP. If negotiated, the
> > virtio-net header is expanded with room for a timestamp.
> > 
> > To get and set the hwtstamp the functions ndo_hwtstamp_set/get need
> > to be implemented. This allows filtering the packets and only time stamp
> > the packets where the filter matches. This way, the timestamping can
> > be en/disabled at runtime.
> > 
> > Tested:
> >   guest: ./timestamping eth0 \
> >           SOF_TIMESTAMPING_RAW_HARDWARE \
> >           SOF_TIMESTAMPING_RX_HARDWARE
> >   host: nc -4 -u 192.168.1.1 319
> > 
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > 
> > --
> >   Changes to last version:
> >   - rework series to use flow filters
> >   - add new struct virtio_net_hdr_v1_hash_tunnel_ts
> >   - original work done by: Willem de Bruijn <willemb@google.com>
> > ---
> >  drivers/net/virtio_net.c        | 136 ++++++++++++++++++++++++++++++++++++----
> >  include/uapi/linux/virtio_net.h |   9 +++
> >  2 files changed, 133 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 1bb3aeca66c6e..4e8d9b20c1b34 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -429,6 +429,9 @@ struct virtnet_info {
> >  	struct virtio_net_rss_config_trailer rss_trailer;
> >  	u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> >  
> > +	/* Device passes time stamps from the driver */
> > +	bool has_tstamp;
> > +
> >  	/* Has control virtqueue */
> >  	bool has_cvq;
> >  
> > @@ -475,6 +478,8 @@ struct virtnet_info {
> >  
> >  	struct control_buf *ctrl;
> >  
> > +	struct kernel_hwtstamp_config tstamp_config;
> > +
> >  	/* Ethtool settings */
> >  	u8 duplex;
> >  	u32 speed;
> > @@ -511,6 +516,7 @@ struct virtio_net_common_hdr {
> >  		struct virtio_net_hdr_mrg_rxbuf	mrg_hdr;
> >  		struct virtio_net_hdr_v1_hash hash_v1_hdr;
> >  		struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
> > +		struct virtio_net_hdr_v1_hash_tunnel_ts ts_hdr;
> 
> Jason, Michael: creating a new struct for every field is not very
> elegant. Is it time to find a more forward looking approach to
> expanding with new fields? Like a TLV, or how netlink structs like
> tcp_info are extended with support for legacy users that only use
> a truncated struct?

I certainly wouldn't mind, though I suspect tlv is too complex as
hardware implementations can't efficiently follow linked lists.  I'll
try to ping some hardware designers for what works well for offloads.


> >  	};
> >  };
> >  
> > @@ -682,6 +688,13 @@ skb_vnet_common_hdr(struct sk_buff *skb)
> >  	return (struct virtio_net_common_hdr *)skb->cb;
> >  }
> >  
> > +static inline struct virtio_net_hdr_v1_hash_tunnel_ts *skb_vnet_hdr_ts(struct sk_buff *skb)
> > +{
> > +	BUILD_BUG_ON(sizeof(struct virtio_net_hdr_v1_hash_tunnel_ts) > sizeof(skb->cb));
> > +
> > +	return (void *)skb->cb;
> > +}
> > +
> >  /*
> >   * private is used to chain pages for big packets, put the whole
> >   * most recent used list in the beginning for reuse
> > @@ -2560,6 +2573,15 @@ virtio_net_hash_value(const struct virtio_net_hdr_v1_hash *hdr_hash)
> >  		(__le16_to_cpu(hdr_hash->hash_value_hi) << 16);
> >  }
> >  
> > +static inline u64
> > +virtio_net_tstamp_value(const struct virtio_net_hdr_v1_hash_tunnel_ts *hdr_hash_ts)
> > +{
> > +	return  (u64)__le16_to_cpu(hdr_hash_ts->tstamp_0) |
> > +	       ((u64)__le16_to_cpu(hdr_hash_ts->tstamp_1) << 16) |
> > +	       ((u64)__le16_to_cpu(hdr_hash_ts->tstamp_2) << 32) |
> > +	       ((u64)__le16_to_cpu(hdr_hash_ts->tstamp_3) << 48);
> > +}
> > +
> >  static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
> >  				struct sk_buff *skb)
> >  {
> > @@ -2589,6 +2611,18 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
> >  	skb_set_hash(skb, virtio_net_hash_value(hdr_hash), rss_hash_type);
> >  }
> >  
> > +static inline void virtnet_record_rx_tstamp(const struct virtnet_info *vi,
> > +					    struct sk_buff *skb)
> > +{
> > +	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
> > +	const struct virtio_net_hdr_v1_hash_tunnel_ts *h = skb_vnet_hdr_ts(skb);
> > +	u64 ts;
> > +
> > +	ts = virtio_net_tstamp_value(h);
> > +	memset(shhwtstamps, 0, sizeof(struct skb_shared_hwtstamps));
> > +	shhwtstamps->hwtstamp = ns_to_ktime(ts);
> > +}
> > +
> >  static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
> >  				 struct sk_buff *skb, u8 flags)
> >  {
> > @@ -2617,6 +2651,8 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
> >  		goto frame_err;
> >  	}
> >  
> > +	if (vi->has_tstamp && vi->tstamp_config.rx_filter != HWTSTAMP_FILTER_NONE)
> > +		virtnet_record_rx_tstamp(vi, skb);
> >  	skb_record_rx_queue(skb, vq2rxq(rq->vq));
> >  	skb->protocol = eth_type_trans(skb, dev);
> >  	pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
> > @@ -3321,7 +3357,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
> >  {
> >  	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
> >  	struct virtnet_info *vi = sq->vq->vdev->priv;
> > -	struct virtio_net_hdr_v1_hash_tunnel *hdr;
> > +	struct virtio_net_hdr_v1_hash_tunnel_ts *hdr;
> >  	int num_sg;
> >  	unsigned hdr_len = vi->hdr_len;
> >  	bool can_push;
> > @@ -3329,8 +3365,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
> >  	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
> >  
> >  	/* Make sure it's safe to cast between formats */
> > -	BUILD_BUG_ON(__alignof__(*hdr) != __alignof__(hdr->hash_hdr));
> > -	BUILD_BUG_ON(__alignof__(*hdr) != __alignof__(hdr->hash_hdr.hdr));
> > +	BUILD_BUG_ON(__alignof__(*hdr) != __alignof__(hdr->tnl.hash_hdr));
> > +	BUILD_BUG_ON(__alignof__(*hdr) != __alignof__(hdr->tnl.hash_hdr.hdr));
> >  
> >  	can_push = vi->any_header_sg &&
> >  		!((unsigned long)skb->data & (__alignof__(*hdr) - 1)) &&
> > @@ -3338,18 +3374,18 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
> >  	/* Even if we can, don't push here yet as this would skew
> >  	 * csum_start offset below. */
> >  	if (can_push)
> > -		hdr = (struct virtio_net_hdr_v1_hash_tunnel *)(skb->data -
> > -							       hdr_len);
> > +		hdr = (struct virtio_net_hdr_v1_hash_tunnel_ts *)(skb->data -
> > +								  hdr_len);
> >  	else
> > -		hdr = &skb_vnet_common_hdr(skb)->tnl_hdr;
> > +		hdr = &skb_vnet_common_hdr(skb)->ts_hdr;
> >  
> > -	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
> > +	if (virtio_net_hdr_tnl_from_skb(skb, &hdr->tnl, vi->tx_tnl,
> >  					virtio_is_little_endian(vi->vdev), 0,
> >  					false))
> >  		return -EPROTO;
> >  
> >  	if (vi->mergeable_rx_bufs)
> > -		hdr->hash_hdr.hdr.num_buffers = 0;
> > +		hdr->tnl.hash_hdr.hdr.num_buffers = 0;
> >  
> >  	sg_init_table(sq->sg, skb_shinfo(skb)->nr_frags + (can_push ? 1 : 2));
> >  	if (can_push) {
> > @@ -5563,6 +5599,22 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
> >  	return 0;
> >  }
> >  
> > +static int virtnet_get_ts_info(struct net_device *dev,
> > +			       struct kernel_ethtool_ts_info *info)
> > +{
> > +	/* setup default software timestamp */
> > +	ethtool_op_get_ts_info(dev, info);
> > +
> > +	info->rx_filters = (BIT(HWTSTAMP_FILTER_NONE) |
> > +			    BIT(HWTSTAMP_FILTER_PTP_V1_L4_SYNC) |
> > +			    BIT(HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ) |
> > +			    BIT(HWTSTAMP_FILTER_ALL));
> > +
> > +	info->tx_types = HWTSTAMP_TX_OFF;
> > +
> > +	return 0;
> > +}
> > +
> >  static void virtnet_init_settings(struct net_device *dev)
> >  {
> >  	struct virtnet_info *vi = netdev_priv(dev);
> > @@ -5658,7 +5710,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
> >  	.get_ethtool_stats = virtnet_get_ethtool_stats,
> >  	.set_channels = virtnet_set_channels,
> >  	.get_channels = virtnet_get_channels,
> > -	.get_ts_info = ethtool_op_get_ts_info,
> > +	.get_ts_info = virtnet_get_ts_info,
> >  	.get_link_ksettings = virtnet_get_link_ksettings,
> >  	.set_link_ksettings = virtnet_set_link_ksettings,
> >  	.set_coalesce = virtnet_set_coalesce,
> > @@ -6242,6 +6294,58 @@ static void virtnet_tx_timeout(struct net_device *dev, unsigned int txqueue)
> >  		   jiffies_to_usecs(jiffies - READ_ONCE(txq->trans_start)));
> >  }
> >  
> > +static int virtnet_hwtstamp_get(struct net_device *dev,
> > +				struct kernel_hwtstamp_config *tstamp_config)
> > +{
> > +	struct virtnet_info *vi = netdev_priv(dev);
> > +
> > +	if (!netif_running(dev))
> > +		return -EINVAL;
> > +
> > +	*tstamp_config = vi->tstamp_config;
> > +
> > +	return 0;
> > +}
> > +
> > +static int virtnet_hwtstamp_set(struct net_device *dev,
> > +				struct kernel_hwtstamp_config *tstamp_config,
> > +				struct netlink_ext_ack *extack)
> > +{
> > +	struct virtnet_info *vi = netdev_priv(dev);
> > +
> > +	if (!netif_running(dev))
> > +		return -EINVAL;
> > +
> > +	switch (tstamp_config->rx_filter) {
> > +	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> > +	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
> > +		break;
> > +	case HWTSTAMP_FILTER_PTP_V2_EVENT:
> > +	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
> > +	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
> > +	case HWTSTAMP_FILTER_PTP_V2_SYNC:
> > +	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
> > +	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
> > +	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
> > +	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
> > +	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> > +		tstamp_config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
> > +		break;
> > +	case HWTSTAMP_FILTER_NONE:
> > +		break;
> > +	case HWTSTAMP_FILTER_ALL:
> > +		tstamp_config->rx_filter = HWTSTAMP_FILTER_ALL;
> > +		break;
> 
> It's fine to implement filters, but also fine to only support ALL or
> NONE for simplicity.
> 
> In the end it probably depends on what the underlying physical device
> supports.
> 
> > +	default:
> > +		tstamp_config->rx_filter = HWTSTAMP_FILTER_ALL;
> > +		return -ERANGE;
> > +	}
> > +
> > +	vi->tstamp_config = *tstamp_config;
> > +
> > +	return 0;
> > +}
> > +
> >  static int virtnet_init_irq_moder(struct virtnet_info *vi)
> >  {
> >  	u8 profile_flags = 0, coal_flags = 0;
> > @@ -6289,6 +6393,8 @@ static const struct net_device_ops virtnet_netdev = {
> >  	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
> >  	.ndo_set_features	= virtnet_set_features,
> >  	.ndo_tx_timeout		= virtnet_tx_timeout,
> > +	.ndo_hwtstamp_set	= virtnet_hwtstamp_set,
> > +	.ndo_hwtstamp_get	= virtnet_hwtstamp_get,
> >  };
> >
> >  static void virtnet_config_changed_work(struct work_struct *work)
> > @@ -6911,6 +7017,9 @@ static int virtnet_probe(struct virtio_device *vdev)
> >  	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
> >  		vi->has_rss_hash_report = true;
> >  
> > +	if (virtio_has_feature(vdev, VIRTIO_NET_F_TSTAMP))
> > +		vi->has_tstamp = true;
> > +
> >  	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
> >  		vi->has_rss = true;
> >  
> > @@ -6945,8 +7054,10 @@ static int virtnet_probe(struct virtio_device *vdev)
> >  		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
> >  	}
> >  
> > -	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
> > -	    virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
> > +	if (vi->has_tstamp)
> > +		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash_tunnel_ts);
> > +	else if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
> > +		 virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
> >  		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash_tunnel);
> >  	else if (vi->has_rss_hash_report)
> >  		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
> > @@ -7269,7 +7380,8 @@ static struct virtio_device_id id_table[] = {
> >  	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
> >  	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
> >  	VIRTIO_NET_F_VQ_NOTF_COAL, \
> > -	VIRTIO_NET_F_GUEST_HDRLEN, VIRTIO_NET_F_DEVICE_STATS
> > +	VIRTIO_NET_F_GUEST_HDRLEN, VIRTIO_NET_F_DEVICE_STATS, \
> > +	VIRTIO_NET_F_TSTAMP
> >  
> >  static unsigned int features[] = {
> >  	VIRTNET_FEATURES,
> > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> > index 1db45b01532b5..9f967575956b8 100644
> > --- a/include/uapi/linux/virtio_net.h
> > +++ b/include/uapi/linux/virtio_net.h
> > @@ -56,6 +56,7 @@
> >  #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
> >  					 * Steering */
> >  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> > +#define VIRTIO_NET_F_TSTAMP	  49	/* Device sends TAI receive time */
> >  #define VIRTIO_NET_F_DEVICE_STATS 50	/* Device can provide device-level statistics. */
> >  #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
> >  #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
> > @@ -215,6 +216,14 @@ struct virtio_net_hdr_v1_hash_tunnel {
> >  	__le16 inner_nh_offset;
> >  };
> >  
> > +struct virtio_net_hdr_v1_hash_tunnel_ts {
> > +	struct virtio_net_hdr_v1_hash_tunnel tnl;
> > +	__le16 tstamp_0;
> > +	__le16 tstamp_1;
> > +	__le16 tstamp_2;
> > +	__le16 tstamp_3;
> > +};
> 
> Why the multiple fields, rather than u64.
> 
> More broadly: can my old patchset be dusted off as is. Does it require
> significant changes?
> 
> I only paused it at the time, because I did not have a real device
> back-end that was going to support it.
> 
> > +
> >  #ifndef VIRTIO_NET_NO_LEGACY
> >  /* This header comes first in the scatter-gather list.
> >   * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
> > 
> > -- 
> > 2.52.0
> > 
> 

