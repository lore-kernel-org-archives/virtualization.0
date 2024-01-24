Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5283217C65
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087321; cv=none; b=oio4e7wId9aUnVnlKpjrZ5KPbv57lATbYad0XeTYGS5F0mqGCG2/U2QFqiQAeNXYhpx4g+Z3Gt7dP/vD4o6oAg+u4ODoDmHhwSS1uYnka9cpRD4m9DOlZzrd7ecC0Jh88iwge5IjSY9TGv0LHWmYxY+oHNZDPyvCAfBTP5deBL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087321; c=relaxed/simple;
	bh=JOj8r2f7qR44MX7gLA5NhPnoaPXH4cwBhdfccGRndaM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=jjmvGwX5JvX/jRlPdakeLc8ClsHBS5CcF8HJq//tP7sUcG2OKsQXQazPI7F6YPRpcn6h8UK40Z8L/EHdmRT/EMNq0RixbZREFNQ6nvLtE6VnrBGXcNAjGIcHHhHrJkuGOUzcMn0bmGxiEtAsVJjn+AIfrun6mkI75O+UovxbmsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC28C6150A
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 09:08:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BC28C6150A
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yW3c3BbfecfZ
	for <virtualization@lists.linux-foundation.org>;
	Wed, 24 Jan 2024 09:08:38 +0000 (UTC)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D79E0614E0
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 09:08:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D79E0614E0
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.G5-fL_1706087310;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.G5-fL_1706087310)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 17:08:31 +0800
Message-ID: <1706087207.116824-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 1/3] virtio_net: Preserve virtio header before XDP program execution
Date: Wed, 24 Jan 2024 17:06:47 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org,
 liangchen.linux@gmail.com,
 mst@redhat.com,
 jasowang@redhat.com,
 hengqi@linux.alibaba.com
References: <20240124085721.54442-1-liangchen.linux@gmail.com>
 <20240124085721.54442-2-liangchen.linux@gmail.com>
In-Reply-To: <20240124085721.54442-2-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 24 Jan 2024 16:57:19 +0800, Liang Chen <liangchen.linux@gmail.com> wrote:
> The xdp program may overwrite the inline virtio header. To ensure the
> integrity of the virtio header, it is saved in a data structure that
> wraps both the xdp_buff and the header before running the xdp program.
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
>  drivers/net/virtio_net.c | 43 +++++++++++++++++++++++++++++-----------
>  1 file changed, 31 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d7ce4a1011ea..b56828804e5f 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -349,6 +349,11 @@ struct virtio_net_common_hdr {
>  	};
>  };
>
> +struct virtnet_xdp_buff {
> +	struct xdp_buff xdp;
> +	struct virtio_net_common_hdr hdr;

Not all items of the hdr are useful, we can just save the useful items.

> +};
> +
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>
>  static bool is_xdp_frame(void *ptr)
> @@ -1199,9 +1204,10 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
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
> @@ -1233,17 +1239,23 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
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
> +	/* Copy out the virtio header, as it may be overwritten by the
> +	 * xdp program.
> +	 */
> +	memcpy(&virtnet_xdp.hdr, hdr, vi->hdr_len);

Can we put this into virtnet_xdp_handler?

And just do that when the hash is negotiated.

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
> @@ -1254,7 +1266,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>  		goto err_xdp;
>  	}
>
> -	skb = virtnet_build_skb(buf, buflen, xdp.data - buf, len);
> +	skb = virtnet_build_skb(buf, buflen, xdp->data - buf, len);
>  	if (unlikely(!skb))
>  		goto err;
>
> @@ -1591,10 +1603,11 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
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
> @@ -1604,16 +1617,22 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
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
> +	/* Copy out the virtio header, as it may be overwritten by the
> +	 * xdp program.
> +	 */
> +	memcpy(&virtnet_xdp.hdr, hdr, vi->hdr_len);
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
> @@ -1626,7 +1645,7 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>  		break;
>  	}
>
> -	put_xdp_frags(&xdp);
> +	put_xdp_frags(xdp);
>
>  err_xdp:
>  	put_page(page);
> --
> 2.40.1
>
