Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CC538396
	for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718611110; cv=none; b=WqR0lG+jixSf4QIT3KGllYy7aoMncCCBwImTER3dHLR/WgUGfdUVd9dtHHAJuS+M4Aw/tMtT7RSjEyXuOWTDD/KN0f0mZaQT0jjE/XO+312uHfKHDYLBW1RK9+hb2DUuK6JVEDYcM5orZ65cV8J0RMyxkcF2/HPgcWi+uzqwpk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718611110; c=relaxed/simple;
	bh=BUwe8NWB4XMebs6DN66UkxIZma16VsDQo8lFih4wqx8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=ok0tVgDX0dL0BcxpeblzDNZokxRxAvAuBsJZt9UzMwfjsHr/CPm21OeG3g+p33imFG0iXGZn8YKnYiG6HWES+VL+VQTsbQ6VtyokzBgMsM2jFeH8A71aEuQXUGfoudOgvP0iNBDmtHv0G00rsU2S6FIrEImcz7wDl0+fVriZOfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JUB6DCP1; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JUB6DCP1"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718611106; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=KkXyNy4nPWs5iLXPRTfMZfZK1JRxusa9+ju97vFjvsw=;
	b=JUB6DCP1j2bjWlbz8GNkma5xzfxTZ+hfl4hUiAIaq/w3fhF7VJ2bIO6FKrXFIVZ58kKRyTgPpiqEUcXeZwnS4fGxN/TRER8yNf2CKk7Y12CFXYnTXlOgWyk5FdZT6RSrh7K2Ui+ltJFB87Mz5STGfSn3yx/dm8aib+gs9L1ABvY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8a1ykr_1718611104;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8a1ykr_1718611104)
          by smtp.aliyun-inc.com;
          Mon, 17 Jun 2024 15:58:25 +0800
Message-ID: <1718610955.756943-6-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 15/15] virtio_net: xsk: rx: support recv small mode
Date: Mon, 17 Jun 2024 15:55:55 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
 <20240614063933.108811-16-xuanzhuo@linux.alibaba.com>
 <CACGkMEtzWQLN9D9+5jZFcn4MNNfDPQ77TK3D5B78NXPyq5u-Gg@mail.gmail.com>
In-Reply-To: <CACGkMEtzWQLN9D9+5jZFcn4MNNfDPQ77TK3D5B78NXPyq5u-Gg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 17 Jun 2024 15:10:48 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Fri, Jun 14, 2024 at 2:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > The virtnet_xdp_handler() is re-used. But
> >
> > 1. We need to copy data to create skb for XDP_PASS.
> > 2. We need to call xsk_buff_free() to release the buffer.
> > 3. The handle for xdp_buff is difference.
> >
> > If we pushed this logic into existing receive handle(merge and small),
> > we would have to maintain code scattered inside merge and small (and bi=
g).
> > So I think it is a good choice for us to put the xsk code into an
> > independent function.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 142 +++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 138 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 4e5645d8bb7d..72c4d2f0c0ea 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -534,8 +534,10 @@ struct virtio_net_common_hdr {
> >
> >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf=
);
> >  static void virtnet_xsk_completed(struct send_queue *sq, int num);
> > -static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct rec=
eive_queue *rq,
> > -                                  struct xsk_buff_pool *pool, gfp_t gf=
p);
> > +static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_b=
uff *xdp,
> > +                              struct net_device *dev,
> > +                              unsigned int *xdp_xmit,
> > +                              struct virtnet_rq_stats *stats);
> >
> >  enum virtnet_xmit_type {
> >         VIRTNET_XMIT_TYPE_SKB,
> > @@ -1218,6 +1220,11 @@ static void virtnet_rq_unmap_free_buf(struct vir=
tqueue *vq, void *buf)
> >
> >         rq =3D &vi->rq[i];
> >
> > +       if (rq->xsk.pool) {
> > +               xsk_buff_free((struct xdp_buff *)buf);
> > +               return;
> > +       }
> > +
> >         if (!vi->big_packets || vi->mergeable_rx_bufs)
> >                 virtnet_rq_unmap(rq, buf, 0);
> >
> > @@ -1308,6 +1315,120 @@ static void sg_fill_dma(struct scatterlist *sg,=
 dma_addr_t addr, u32 len)
> >         sg->length =3D len;
> >  }
> >
> > +static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
> > +                                  struct receive_queue *rq, void *buf,=
 u32 len)
> > +{
> > +       struct xdp_buff *xdp;
> > +       u32 bufsize;
> > +
> > +       xdp =3D (struct xdp_buff *)buf;
> > +
> > +       bufsize =3D xsk_pool_get_rx_frame_size(rq->xsk.pool) + vi->hdr_=
len;
> > +
> > +       if (unlikely(len > bufsize)) {
> > +               pr_debug("%s: rx error: len %u exceeds truesize %u\n",
> > +                        vi->dev->name, len, bufsize);
> > +               DEV_STATS_INC(vi->dev, rx_length_errors);
> > +               xsk_buff_free(xdp);
> > +               return NULL;
> > +       }
> > +
> > +       xsk_buff_set_size(xdp, len);
> > +       xsk_buff_dma_sync_for_cpu(xdp);
> > +
> > +       return xdp;
> > +}
> > +
> > +static struct sk_buff *xdp_construct_skb(struct receive_queue *rq,
> > +                                        struct xdp_buff *xdp)
> > +{
> > +       unsigned int metasize =3D xdp->data - xdp->data_meta;
> > +       struct sk_buff *skb;
> > +       unsigned int size;
> > +
> > +       size =3D xdp->data_end - xdp->data_hard_start;
> > +       skb =3D napi_alloc_skb(&rq->napi, size);
> > +       if (unlikely(!skb)) {
> > +               xsk_buff_free(xdp);
> > +               return NULL;
> > +       }
> > +
> > +       skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
> > +
> > +       size =3D xdp->data_end - xdp->data_meta;
> > +       memcpy(__skb_put(skb, size), xdp->data_meta, size);
> > +
> > +       if (metasize) {
> > +               __skb_pull(skb, metasize);
> > +               skb_metadata_set(skb, metasize);
> > +       }
> > +
> > +       xsk_buff_free(xdp);
> > +
> > +       return skb;
> > +}
> > +
> > +static struct sk_buff *virtnet_receive_xsk_small(struct net_device *de=
v, struct virtnet_info *vi,
> > +                                                struct receive_queue *=
rq, struct xdp_buff *xdp,
> > +                                                unsigned int *xdp_xmit,
> > +                                                struct virtnet_rq_stat=
s *stats)
> > +{
> > +       struct bpf_prog *prog;
> > +       u32 ret;
> > +
> > +       ret =3D XDP_PASS;
> > +       rcu_read_lock();
> > +       prog =3D rcu_dereference(rq->xdp_prog);
> > +       if (prog)
> > +               ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, s=
tats);
> > +       rcu_read_unlock();
> > +
> > +       switch (ret) {
> > +       case XDP_PASS:
> > +               return xdp_construct_skb(rq, xdp);
> > +
> > +       case XDP_TX:
> > +       case XDP_REDIRECT:
> > +               return NULL;
> > +
> > +       default:
> > +               /* drop packet */
> > +               xsk_buff_free(xdp);
> > +               u64_stats_inc(&stats->drops);
> > +               return NULL;
> > +       }
> > +}
>
> Let's use a separate patch for this to decouple new functions with refact=
oring.
>
> Or even use a separate series for rx zerocopy.


This is for xsk. I can not get you.


>
> > +
> > +static struct sk_buff *virtnet_receive_xsk_buf(struct virtnet_info *vi=
, struct receive_queue *rq,
> > +                                              void *buf, u32 len,
> > +                                              unsigned int *xdp_xmit,
> > +                                              struct virtnet_rq_stats =
*stats)
> > +{
> > +       struct net_device *dev =3D vi->dev;
> > +       struct sk_buff *skb =3D NULL;
> > +       struct xdp_buff *xdp;
> > +
> > +       len -=3D vi->hdr_len;
> > +
> > +       u64_stats_add(&stats->bytes, len);
> > +
> > +       xdp =3D buf_to_xdp(vi, rq, buf, len);
> > +       if (!xdp)
> > +               return NULL;
>
> Don't we need to check if XDP is enabled before those operations?
>
> > +
> > +       if (unlikely(len < ETH_HLEN)) {
> > +               pr_debug("%s: short packet %i\n", dev->name, len);
> > +               DEV_STATS_INC(dev, rx_length_errors);
> > +               xsk_buff_free(xdp);
> > +               return NULL;
> > +       }
> > +
> > +       if (!vi->mergeable_rx_bufs)
> > +               skb =3D virtnet_receive_xsk_small(dev, vi, rq, xdp, xdp=
_xmit, stats);
> > +
> > +       return skb;
> > +}
> > +
> >  static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct rec=
eive_queue *rq,
> >                                    struct xsk_buff_pool *pool, gfp_t gf=
p)
> >  {
> > @@ -2713,9 +2834,22 @@ static int virtnet_receive(struct receive_queue =
*rq, int budget,
> >         void *buf;
> >         int i;
> >
> > -       if (!vi->big_packets || vi->mergeable_rx_bufs) {
> > -               void *ctx;
> > +       if (rq->xsk.pool) {
> > +               struct sk_buff *skb;
> > +
> > +               while (packets < budget) {
> > +                       buf =3D virtqueue_get_buf(rq->vq, &len);
> > +                       if (!buf)
> > +                               break;
> >
> > +                       skb =3D virtnet_receive_xsk_buf(vi, rq, buf, le=
n, xdp_xmit, &stats);
>
> The function name is confusing for example, xsk might not be even enabled.


If rq->xsk.pool is true, the xsk is enable.

Thanks.


>
> > +                       if (skb)
> > +                               virtnet_receive_done(vi, rq, skb);
> > +
> > +                       packets++;
> > +               }
> > +       } else if (!vi->big_packets || vi->mergeable_rx_bufs) {
> > +               void *ctx;
> >                 while (packets < budget &&
> >                        (buf =3D virtnet_rq_get_buf(rq, &len, &ctx))) {
> >                         receive_buf(vi, rq, buf, len, ctx, xdp_xmit, &s=
tats);
> > --
> > 2.32.0.3.g01195cf9f
> >
>
> Thanks
>
