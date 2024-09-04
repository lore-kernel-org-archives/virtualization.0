Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F95A145B2E
	for <virtualization@lists.linux.dev>; Wed,  4 Sep 2024 06:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725432381; cv=none; b=XbsQW1gxLHmUN8w0Dnhz2ezZJnDSXlYBjBvmEQoG1P/Zfcsi+74rN9fDDYwuayenR6/VKbDi5qCWC+wFc250Vqlg+vcAntwZghk8RLQ0rOw0o2MbflUKIN8ESTw0yS8OWpSJEIpsQyvAc1BuHm6nZIfvDEnOdTCQzjP2iXKYa6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725432381; c=relaxed/simple;
	bh=5f/PYhXt0RMma+L76lP1Tn8q8D2Khez0KEbRlwxSaFA=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=riYvkZnvMXlUHs11qiXEAVWan95PlC5sMtVYs2EhXMFHcV8X9Xc2greliSt703xTJjgL1+BZhHitKGlElxwNFCQQIq2FDTlkl/BIKkr57I05f6wOq7OjhcysM6OgzfBT1OqR7DTJvIRSkiQ9puegu96NzBzmVn8ioGtZEzITkhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pO3wEPOP; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pO3wEPOP"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725432374; h=Message-ID:Subject:Date:From:To;
	bh=Y22uid/xR/mynPf9pRoIZffXD1FEymenAoEvZ++51sg=;
	b=pO3wEPOPTdbG+QxqddFkU7jBlevXuHZJI5vq7+rXfMrjiZcfem5K/ewg3VU/UupQvEQliuU68+I4qSPE4Ahm2+2rdIqFPAzYMDbDn9pHdy+aOwNFm5C6bvmzE4dKyxMGTEJwlXSsYW176htgT3DbJIH7hOXJ+TLL651Jbv2oGuI=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEGR9Ak_1725432372)
          by smtp.aliyun-inc.com;
          Wed, 04 Sep 2024 14:46:13 +0800
Message-ID: <1725432304.274084-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2] virtio_net: Fix mismatched buf address when unmapping for small packets
Date: Wed, 4 Sep 2024 14:45:04 +0800
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
References: <20240904061009.90785-1-liwenbo.martin@bytedance.com>
In-Reply-To: <20240904061009.90785-1-liwenbo.martin@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed,  4 Sep 2024 14:10:09 +0800, Wenbo Li <liwenbo.martin@bytedance.com> wrote:
> Currently, the virtio-net driver will perform a pre-dma-mapping for
> small or mergeable RX buffer. But for small packets, a mismatched address
> without VIRTNET_RX_PAD and xdp_headroom is used for unmapping.

Will used virt_to_head_page(), so could you say more about it?

	struct page *page = virt_to_head_page(buf);

Thanks.

>
> That will result in unsynchronized buffers when SWIOTLB is enabled, for
> example, when running as a TDX guest.
>
> This patch handles small and mergeable packets separately and fixes
> the mismatched buffer address.
>
> Changes from v1: Use ctx to get xdp_headroom.
>
> Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
> Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
> Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
> Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>
> ---
>  drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c6af18948..cbc3c0ae4 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -891,6 +891,23 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>  	return buf;
>  }
>
> +static void *virtnet_rq_get_buf_small(struct receive_queue *rq,
> +				      u32 *len,
> +				      void **ctx,
> +				      unsigned int header_offset)
> +{
> +	void *buf;
> +	unsigned int xdp_headroom;
> +
> +	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> +	if (buf) {
> +		xdp_headroom = (unsigned long)*ctx;
> +		virtnet_rq_unmap(rq, buf + VIRTNET_RX_PAD + xdp_headroom, *len);
> +	}
> +
> +	return buf;
> +}
> +
>  static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
>  {
>  	struct virtnet_rq_dma *dma;
> @@ -2692,13 +2709,23 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
>  	int packets = 0;
>  	void *buf;
>
> -	if (!vi->big_packets || vi->mergeable_rx_bufs) {
> +	if (vi->mergeable_rx_bufs) {
>  		void *ctx;
>  		while (packets < budget &&
>  		       (buf = virtnet_rq_get_buf(rq, &len, &ctx))) {
>  			receive_buf(vi, rq, buf, len, ctx, xdp_xmit, stats);
>  			packets++;
>  		}
> +	} else if (!vi->big_packets) {
> +		void *ctx;
> +		unsigned int xdp_headroom = virtnet_get_headroom(vi);
> +		unsigned int header_offset = VIRTNET_RX_PAD + xdp_headroom;
> +
> +		while (packets < budget &&
> +		       (buf = virtnet_rq_get_buf_small(rq, &len, &ctx, header_offset))) {
> +			receive_buf(vi, rq, buf, len, ctx, xdp_xmit, stats);
> +			packets++;
> +		}
>  	} else {
>  		while (packets < budget &&
>  		       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
> --
> 2.20.1
>
