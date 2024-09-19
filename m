Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A401E1917CC
	for <virtualization@lists.linux.dev>; Thu, 19 Sep 2024 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726729918; cv=none; b=MH1UL7Xkah64h5ot2P3FIdD1JLZfiu1YpVACn5ZnZHZBx3k9HjEMlHMZxZsW3oPgeHw5uoi90a649ZZy0iiW/aaMYi3gUeVPZ3YlkzCWsNzNh8Vj7mxG7bg70d16RlT/VGfMIjqv5kNNG464mn5otX8tsVCLnxQDhaVuLMImBhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726729918; c=relaxed/simple;
	bh=xcjpsMKI13u3WcKGB0N9zGs0tG0CLFvOvo1y6POEmoI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=SGYeD5a6L45t5/ZsZqlJWZTerXD1azqBHjjz9RCjqZPdoMswohA8xhvCVtlLCpVo4JisKiq1F7fBwXm6SIgVkXgBoEwv2BC55NO0cY98RTWG3xiIUfcNDEgGUxc/dp12wPQwk6t6FkQIFCx+/UDOTueozbE22RzmUl2UdvmCwcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wJy6UIJl; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wJy6UIJl"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726729906; h=Message-ID:Subject:Date:From:To;
	bh=ssL8UI9+cmR3eancWEz3OVmCqRIhQMFqE23fxOHlFWk=;
	b=wJy6UIJlzpxVeqsFEDmQiE4XBYi53bxBJNPeQod4LQ5MPzAWNsR8BcOVApd4R6oxxG+aFgbre3IvlgNgSzBDhPmKZrNasZGAYiuWPj3K9pJM8sVB9mF93KWCO3Zp5SFzbGyjmwirsjchF27mbvEqVysqF32nSVhHJHOGkYApdUk=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WFGjrnj_1726729904)
          by smtp.aliyun-inc.com;
          Thu, 19 Sep 2024 15:11:45 +0800
Message-ID: <1726729783.1689022-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [RESEND PATCH v3] virtio_net: Fix mismatched buf address when unmapping for small packets
Date: Thu, 19 Sep 2024 15:09:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Wenbo Li <liwenbo.martin@bytedance.com>
Cc: virtualization@lists.linux.dev,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Wenbo Li <liwenbo.martin@bytedance.com>,
 Jiahui Cen <cenjiahui@bytedance.com>,
 Ying Fang <fangying.tommy@bytedance.com>,
 mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
References: <20240919035214.41805-1-liwenbo.martin@bytedance.com>
In-Reply-To: <20240919035214.41805-1-liwenbo.martin@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 19 Sep 2024 11:52:14 +0800, Wenbo Li <liwenbo.martin@bytedance.com> wrote:
> Currently, the virtio-net driver will perform a pre-dma-mapping for
> small or mergeable RX buffer. But for small packets, a mismatched address
> without VIRTNET_RX_PAD and xdp_headroom is used for unmapping.
>
> That will result in unsynchronized buffers when SWIOTLB is enabled, for
> example, when running as a TDX guest.
>
> This patch unifies the address passed to the virtio core into the address
> of the virtnet header and fixes the mismatched buffer address.
>
> Changes from v2: unify the buf that passed to the virtio core in small
> and merge mode.
> Changes from v1: Use ctx to get xdp_headroom.
>
> Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
> Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
> Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
> Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>
> ---
>  drivers/net/virtio_net.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 6f4781ec2b36..9446666c84aa 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1804,9 +1804,15 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  				     struct virtnet_rq_stats *stats)
>  {
>  	unsigned int xdp_headroom = (unsigned long)ctx;
> -	struct page *page = virt_to_head_page(buf);
> +	struct page *page;

Because that here is head page, so you can keep the original code.

>  	struct sk_buff *skb;
>
> +	// We passed the address of virtnet header to virtio-core,
> +	// so truncate the padding.

Please check the kernel code style.

Thanks.

> +	buf -= VIRTNET_RX_PAD + xdp_headroom;
> +
> +	page = virt_to_head_page(buf);
> +
>  	len -= vi->hdr_len;
>  	u64_stats_add(&stats->bytes, len);
>
> @@ -2422,8 +2428,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>  	if (unlikely(!buf))
>  		return -ENOMEM;
>
> -	virtnet_rq_init_one_sg(rq, buf + VIRTNET_RX_PAD + xdp_headroom,
> -			       vi->hdr_len + GOOD_PACKET_LEN);
> +	buf += VIRTNET_RX_PAD + xdp_headroom;
> +
> +	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
>
>  	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
>  	if (err < 0) {
> --
> 2.20.1
>
