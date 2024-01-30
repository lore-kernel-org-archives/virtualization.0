Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D0367E79
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jan 2024 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615602; cv=none; b=tOAgoZH/r4Zvw4BchYVXX3/Q2tgDj6utnJeOG5snyT2w8ff7h4Qd8Grn9gYj2DM/q5Kdjvo4Nhmsqrg4g625y+q6mZQEL/NzqlT2L67MUw3idayfVpbsid02pVunA2jP8EvwB/OueZsmv3LPm35G1QexQ0eNfc9X+9fsMqN96fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615602; c=relaxed/simple;
	bh=JztyLydpOvMohc+UwTatWh0c53pEslI4RUN5TBcmW2Q=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=M2lyIGEenbtee0NcGWvg0pUgNUryy/4Ztkl9NaTFxPlxas032FHEDVL81HWWVz0dDUp4xcuMMKMO2t6sqkJZrLKw4VHcG44EKRMmaQkkln1G7Zo/y8p49y2lQZft6eJECu36lhoq7sG96ceLOqNB2uobmso2mm3ga9a6uP3IeeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jYQXXq+I; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jYQXXq+I"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A49934152D
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jan 2024 11:53:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A49934152D
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jYQXXq+I
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -17.5
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iYCpt1ub1Vu3
	for <virtualization@lists.linux-foundation.org>;
	Tue, 30 Jan 2024 11:53:18 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6DB42414E2
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jan 2024 11:53:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6DB42414E2
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706615593; h=Message-ID:Subject:Date:From:To;
	bh=q2JRxgqAQrdi04QI4nuksa65Pz4ECDDuDGAQKGPG6hQ=;
	b=jYQXXq+IHve6JxgEzbsUxa3PuYIMcfe28BwT9vJgwXqNm8pHSPOqgjko9mkE8Xr1QLvbvkRgTR32MV1MwEaFiPZuaIP5DulQvcLrKR1KEzGbuK6Roi8GsOO7xft3sZP9OirDHmnd0Md3fhNybap8kcmQnq+orbbjksjuLB5gb58=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.g5LPL_1706615590;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.g5LPL_1706615590)
          by smtp.aliyun-inc.com;
          Tue, 30 Jan 2024 19:53:11 +0800
Message-ID: <1706615528.9879212-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3] virtio_net: Support RX hash XDP hint
Date: Tue, 30 Jan 2024 19:52:08 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org,
 liangchen.linux@gmail.com,
 mst@redhat.com,
 jasowang@redhat.com,
 hengqi@linux.alibaba.com
References: <20240125101912.60346-1-liangchen.linux@gmail.com>
In-Reply-To: <20240125101912.60346-1-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 25 Jan 2024 18:19:12 +0800, Liang Chen <liangchen.linux@gmail.com> wrote:
> The RSS hash report is a feature that's part of the virtio specification.
> Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhost
> (still a work in progress as per [1]) support this feature. While the
> capability to obtain the RSS hash has been enabled in the normal path,
> it's currently missing in the XDP path. Therefore, we are introducing
> XDP hints through kfuncs to allow XDP programs to access the RSS hash.
>
> 1.
> https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@daynix.com/#r
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
>  drivers/net/virtio_net.c | 98 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 86 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d7ce4a1011ea..0c845f2223da 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -349,6 +349,12 @@ struct virtio_net_common_hdr {
>  	};
>  };
>
> +struct virtnet_xdp_buff {
> +	struct xdp_buff xdp;
> +	u32 hash_value;
> +	u16 hash_report;
> +};
> +
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>
>  static bool is_xdp_frame(void *ptr)
> @@ -1033,6 +1039,16 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>  	}
>  }
>
> +static void virtnet_xdp_save_rx_hash(struct virtnet_xdp_buff *virtnet_xdp,
> +				     struct net_device *dev,
> +				     struct virtio_net_hdr_v1_hash *hdr_hash)
> +{
> +	if (dev->features & NETIF_F_RXHASH) {
> +		virtnet_xdp->hash_value = __le32_to_cpu(hdr_hash->hash_value);
> +		virtnet_xdp->hash_report = __le16_to_cpu(hdr_hash->hash_report);

Could we put the __leXX_to_cpu to virtnet_xdp_rx_hash?

Other looks good to me.

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Thanks.


> +	}
> +}
> +
>  static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>  			       struct net_device *dev,
>  			       unsigned int *xdp_xmit,
> @@ -1199,9 +1215,10 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>  	unsigned int headroom = vi->hdr_len + header_offset;
>  	struct virtio_net_hdr_mrg_rxbuf *hdr = buf + header_offset;
>  	struct page *page = virt_to_head_page(buf);
> +	struct virtnet_xdp_buff virtnet_xdp;
>  	struct page *xdp_page;
> +	struct xdp_buff *xdp;
>  	unsigned int buflen;
> -	struct xdp_buff xdp;
>  	struct sk_buff *skb;
>  	unsigned int metasize = 0;
>  	u32 act;
> @@ -1233,17 +1250,20 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>  		page = xdp_page;
>  	}
>
> -	xdp_init_buff(&xdp, buflen, &rq->xdp_rxq);
> -	xdp_prepare_buff(&xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
> +	xdp = &virtnet_xdp.xdp;
> +	xdp_init_buff(xdp, buflen, &rq->xdp_rxq);
> +	xdp_prepare_buff(xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
>  			 xdp_headroom, len, true);
>
> -	act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
> +	virtnet_xdp_save_rx_hash(&virtnet_xdp, dev, (void *)hdr);
> +
> +	act = virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
>
>  	switch (act) {
>  	case XDP_PASS:
>  		/* Recalculate length in case bpf program changed it */
> -		len = xdp.data_end - xdp.data;
> -		metasize = xdp.data - xdp.data_meta;
> +		len = xdp->data_end - xdp->data;
> +		metasize = xdp->data - xdp->data_meta;
>  		break;
>
>  	case XDP_TX:
> @@ -1254,7 +1274,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>  		goto err_xdp;
>  	}
>
> -	skb = virtnet_build_skb(buf, buflen, xdp.data - buf, len);
> +	skb = virtnet_build_skb(buf, buflen, xdp->data - buf, len);
>  	if (unlikely(!skb))
>  		goto err;
>
> @@ -1591,10 +1611,11 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>  	int num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
>  	struct page *page = virt_to_head_page(buf);
>  	int offset = buf - page_address(page);
> +	struct virtnet_xdp_buff virtnet_xdp;
>  	unsigned int xdp_frags_truesz = 0;
>  	struct sk_buff *head_skb;
>  	unsigned int frame_sz;
> -	struct xdp_buff xdp;
> +	struct xdp_buff *xdp;
>  	void *data;
>  	u32 act;
>  	int err;
> @@ -1604,16 +1625,19 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>  	if (unlikely(!data))
>  		goto err_xdp;
>
> -	err = virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, data, len, frame_sz,
> +	xdp = &virtnet_xdp.xdp;
> +	err = virtnet_build_xdp_buff_mrg(dev, vi, rq, xdp, data, len, frame_sz,
>  					 &num_buf, &xdp_frags_truesz, stats);
>  	if (unlikely(err))
>  		goto err_xdp;
>
> -	act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
> +	virtnet_xdp_save_rx_hash(&virtnet_xdp, dev, (void *)hdr);
> +
> +	act = virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
>
>  	switch (act) {
>  	case XDP_PASS:
> -		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
> +		head_skb = build_skb_from_xdp_buff(dev, vi, xdp, xdp_frags_truesz);
>  		if (unlikely(!head_skb))
>  			break;
>  		return head_skb;
> @@ -1626,7 +1650,7 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>  		break;
>  	}
>
> -	put_xdp_frags(&xdp);
> +	put_xdp_frags(xdp);
>
>  err_xdp:
>  	put_page(page);
> @@ -4579,6 +4603,55 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
>  	}
>  }
>
> +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> +			       enum xdp_rss_hash_type *rss_type)
> +{
> +	const struct virtnet_xdp_buff *virtnet_xdp = (void *)_ctx;
> +
> +	if (!(virtnet_xdp->xdp.rxq->dev->features & NETIF_F_RXHASH))
> +		return -ENODATA;
> +
> +	switch (virtnet_xdp->hash_report) {
> +	case VIRTIO_NET_HASH_REPORT_TCPv4:
> +		*rss_type = XDP_RSS_TYPE_L4_IPV4_TCP;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_UDPv4:
> +		*rss_type = XDP_RSS_TYPE_L4_IPV4_UDP;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_TCPv6:
> +		*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_UDPv6:
> +		*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> +		*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP_EX;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> +		*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP_EX;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_IPv4:
> +		*rss_type = XDP_RSS_TYPE_L3_IPV4;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_IPv6:
> +		*rss_type = XDP_RSS_TYPE_L3_IPV6;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> +		*rss_type = XDP_RSS_TYPE_L3_IPV6_EX;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_NONE:
> +	default:
> +		*rss_type = XDP_RSS_TYPE_NONE;
> +	}
> +
> +	*hash = virtnet_xdp->hash_value;
> +	return 0;
> +}
> +
> +static const struct xdp_metadata_ops virtnet_xdp_metadata_ops = {
> +	.xmo_rx_hash			= virtnet_xdp_rx_hash,
> +};
> +
>  static int virtnet_probe(struct virtio_device *vdev)
>  {
>  	int i, err = -ENOMEM;
> @@ -4704,6 +4777,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
>
>  		dev->hw_features |= NETIF_F_RXHASH;
> +		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
>  	}
>
>  	if (vi->has_rss_hash_report)
> --
> 2.40.1
>
