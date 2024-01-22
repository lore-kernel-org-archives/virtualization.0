Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A7A748A
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921848; cv=none; b=sBApn1MnlLNSXCQqcZ30V59PiGQ372Kg8FUMxXBYYIuUCJMa2MMclZVnBSOg+fsbZNZybuHhy6452Dges8LsJg+9VSgt2L97+vCrqbJSoDdtUdeKXAZpgivekVTj4HKVquq3wfbP9xP7VbVeXQG2mQ9TdYCY/vtGIvDvbRUK1AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921848; c=relaxed/simple;
	bh=cuK6dlsAqqCyuHKmfg4fbsKC82Budl4OWQwU5QWb5N8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJtbz9A5QTUM1+n4/5nnki/fVWNiOeVeiJgrOlNQ3FzthoddtLz4ay1AIiljqN256WwVZGYUFdWbxQTrXsE8xA3iY4cG0QIyqKdYEMEahXhBd7CcEpFftP7kJFIN3+1r+ScvilFJzkFZOFoMyGXpgZGJS2LGxTqAHm9u43fpCdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 396C982540
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 11:10:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 396C982540
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KMV_qhhAbQjL
	for <virtualization@lists.linux-foundation.org>;
	Mon, 22 Jan 2024 11:10:45 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9F16182538
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 11:10:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F16182538
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W.7NcCV_1705921837;
Received: from 30.221.149.111(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W.7NcCV_1705921837)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 19:10:38 +0800
Message-ID: <4ada64aa-87ec-4340-9892-be52c1f27a97@linux.alibaba.com>
Date: Mon, 22 Jan 2024 19:10:36 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_net: Support RX hash XDP hint
To: Liang Chen <liangchen.linux@gmail.com>, mst@redhat.com,
 jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20240122102256.261374-1-liangchen.linux@gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240122102256.261374-1-liangchen.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Liang Chen,

在 2024/1/22 下午6:22, Liang Chen 写道:
> The RSS hash report is a feature that's part of the virtio specification.
> Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhost
> (still a work in progress as per [1]) support this feature. While the
> capability to obtain the RSS hash has been enabled in the normal path,
> it's currently missing in the XDP path. Therefore, we are introducing XDP
> hints through kfuncs to allow XDP programs to access the RSS hash.
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
>   drivers/net/virtio_net.c | 56 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d7ce4a1011ea..1463a4709e3c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4579,6 +4579,60 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
>   	}
>   }
>   
> +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> +			   enum xdp_rss_hash_type *rss_type)
> +{
> +	const struct xdp_buff *xdp = (void *)_ctx;
> +	struct virtio_net_hdr_v1_hash *hdr_hash;
> +	struct virtnet_info *vi;
> +
> +	if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))

I think 'vi->has_rss_hash_report' should be used here.
NETIF_F_RXHASH cannot guarantee that the hash report feature is negotiated,
and accessing hash_report and hash_value is unsafe at this time.

> +		return -ENODATA;
> +
> +	vi = netdev_priv(xdp->rxq->dev);
> +	hdr_hash = (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hdr_len);

If the virtio-net-hdr is overrided by the XDP prog, how can this be done 
correctly and as expected?

Thanks,
Heng

> +
> +	switch (__le16_to_cpu(hdr_hash->hash_report)) {
> +		case VIRTIO_NET_HASH_REPORT_TCPv4:
> +			*rss_type = XDP_RSS_TYPE_L4_IPV4_TCP;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_UDPv4:
> +			*rss_type = XDP_RSS_TYPE_L4_IPV4_UDP;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_TCPv6:
> +			*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_UDPv6:
> +			*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> +			*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP_EX;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> +			*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP_EX;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_IPv4:
> +			*rss_type = XDP_RSS_TYPE_L3_IPV4;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_IPv6:
> +			*rss_type = XDP_RSS_TYPE_L3_IPV6;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> +			*rss_type = XDP_RSS_TYPE_L3_IPV6_EX;
> +			break;
> +		case VIRTIO_NET_HASH_REPORT_NONE:
> +		default:
> +			*rss_type = XDP_RSS_TYPE_NONE;
> +	}
> +
> +	*hash = __le32_to_cpu(hdr_hash->hash_value);
> +	return 0;
> +}
> +
> +static const struct xdp_metadata_ops virtnet_xdp_metadata_ops = {
> +	.xmo_rx_hash			= virtnet_xdp_rx_hash,
> +};
> +
>   static int virtnet_probe(struct virtio_device *vdev)
>   {
>   	int i, err = -ENOMEM;
> @@ -4613,6 +4667,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>   	dev->ethtool_ops = &virtnet_ethtool_ops;
>   	SET_NETDEV_DEV(dev, &vdev->dev);
>   
> +	dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
> +
>   	/* Do we support "hardware" checksums? */
>   	if (virtio_has_feature(vdev, VIRTIO_NET_F_CSUM)) {
>   		/* This opens up the world of extra features. */

