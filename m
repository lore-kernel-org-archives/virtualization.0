Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0F2198A3E
	for <virtualization@lists.linux.dev>; Thu, 19 Sep 2024 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735191; cv=none; b=XpX34sukqliTwJ5yU2lp82U7iafk+qCsoqjzM3Da7EsiCBWQrLrJvcDzNQ1NXIoEdBcTiIx1XwKWsv/JHmibjMp+ZzvngoTsaK1YVNvNrAh/6//YMsWK9wYgsPREWVMSN8H9VIu0rrFntxMtzpR4yqhT2iZDbhX1JN8kI75FGg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735191; c=relaxed/simple;
	bh=YVqE/L1HV4wg6Vyzyh1P6f6l8hRfOphwe2DO+KyoSgg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=CRmgRZm/vJvUDpNiAzUW4t7DCLyP8nWsKjcGIOBPKh6b+auml653A0IR/7nyQSssw3JJ0SKtHaaUQgVD6FGFRSON6ak3LKjD9Jprb4OOjboLVmg3Kxyh7+XMYZ9LKoYx/6oJKGQ+Y1n9yGSBFPGxM2FemZWn+A8Nvalm1JT5qzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jmEUQ6ze; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jmEUQ6ze"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726735186; h=Message-ID:Subject:Date:From:To;
	bh=9DsAdYuAPv2ZkLquz5j1q/urZ0rt5W51A+rUAsh1me8=;
	b=jmEUQ6zexYykPaACmxLnf3KEIVfB1Aya4OMTlY0a6ldj4oTC3nnsIIBISBoQC2FwfAQy/lAnMr49EGzvIpewt3qIfasPCjuJpf5wom11wRXGB5IGXEi8mUZhyuify8Hx+4KPb2RR5zwSMXRkq+FykjzBoEAj+dXvbZMXoTReYwo=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WFH-KpM_1726735185)
          by smtp.aliyun-inc.com;
          Thu, 19 Sep 2024 16:39:46 +0800
Message-ID: <1726734803.547666-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [RESEND PATCH v3] virtio_net: Fix mismatched buf address when unmapping for small packets
Date: Thu, 19 Sep 2024 16:33:23 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
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
 pabeni@redhat.com,
 Wenbo Li <liwenbo.martin@bytedance.com>
References: <20240919081351.51772-1-liwenbo.martin@bytedance.com>
 <1726734765.9623058-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1726734765.9623058-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 19 Sep 2024 16:32:45 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> On Thu, 19 Sep 2024 16:13:51 +0800, Wenbo Li <liwenbo.martin@bytedance.com> wrote:
> > Currently, the virtio-net driver will perform a pre-dma-mapping for
> > small or mergeable RX buffer. But for small packets, a mismatched address
> > without VIRTNET_RX_PAD and xdp_headroom is used for unmapping.
> >
> > That will result in unsynchronized buffers when SWIOTLB is enabled, for
> > example, when running as a TDX guest.
> >
> > This patch unifies the address passed to the virtio core as the address of
> > the virtnet header and fixes the mismatched buffer address.
> >
> > Changes from v2: unify the buf that passed to the virtio core in small
> > and merge mode.
> > Changes from v1: Use ctx to get xdp_headroom.
> >
> > Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
> > Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
> > Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
> > Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>
>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

For net/virtio maintainers:

Because the premapped mode is closed by default for virtio-net rx. So this bug
will not be triggered. DO NOT worry about it.

So that is ok if we merge it into next version. (The merge window is closed).

Thanks.



>
> Thanks.
>
> > ---
> >  drivers/net/virtio_net.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 6f4781ec2b36..f8131f92a392 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1807,6 +1807,11 @@ static struct sk_buff *receive_small(struct net_device *dev,
> >  	struct page *page = virt_to_head_page(buf);
> >  	struct sk_buff *skb;
> >
> > +	/* We passed the address of virtnet header to virtio-core,
> > +	 * so truncate the padding.
> > +	 */
> > +	buf -= VIRTNET_RX_PAD + xdp_headroom;
> > +
> >  	len -= vi->hdr_len;
> >  	u64_stats_add(&stats->bytes, len);
> >
> > @@ -2422,8 +2427,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
> >  	if (unlikely(!buf))
> >  		return -ENOMEM;
> >
> > -	virtnet_rq_init_one_sg(rq, buf + VIRTNET_RX_PAD + xdp_headroom,
> > -			       vi->hdr_len + GOOD_PACKET_LEN);
> > +	buf += VIRTNET_RX_PAD + xdp_headroom;
> > +
> > +	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
> >
> >  	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
> >  	if (err < 0) {
> > --
> > 2.20.1
> >
