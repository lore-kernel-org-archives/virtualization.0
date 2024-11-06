Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175DF1917C0
	for <virtualization@lists.linux.dev>; Wed,  6 Nov 2024 05:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730872684; cv=none; b=WGqQQ1DHScFyaWucoZqzQlztTiXYV8LZY6ig0S05IK6k6TqWYcsZVrAJ0ABm23lUOcFG5IaD03OFSZPLr9GYozh2wjpOy5igrwsdaDQy+DuSuj8bvW7fc2+bpX8D891nJO3fzzxL5WCSlvqGHeSlVJT502EDy+C6BNauiqcEeFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730872684; c=relaxed/simple;
	bh=L1Hh/Vk/G7s+OL6QbLLN4/mYGEVEtxWBlqR8DL+v4ac=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=MsFtFuKesPAxOblepobQGWHAeA2TudHy2KS2FXmbzxlddVvk7dRFJ7Ut3ylke7aP63fKq9Nq71oji8gguNHErrJqbSlKOHjN1/vpLI10de5WFGvWSr6nUpEVOBr4gl5NGnQIw8Rfj1TY96K20aeVO3mAaiy6S5qLssTfhnN0CAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RNkZula6; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RNkZula6"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730872674; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=pGbeKEew91gTlVqW6Q/fBFUenDoHgcHItAmKMn4mAdY=;
	b=RNkZula6UsL7dKRSfosK0M1qvr3t6aG6e1tal3KKYmSL938wlftMzt+PFuDAZdPaTZOQb99BCDbcw+Wlxb9NepvfpTcoHLUNVROmGbcZ0TrQqeUQHKXqOM711bmGR4CA9pXEDBS3jHmiQhjdJAQ0QbThqpB4M0+1vbcoIeyZH9Q=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIq.YET_1730872672 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Nov 2024 13:57:53 +0800
Message-ID: <1730872553.1898103-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 06/13] virtio-net: rq submits premapped per-buffer
Date: Wed, 6 Nov 2024 13:55:53 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
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
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com>
 <20241030082453.97310-7-xuanzhuo@linux.alibaba.com>
 <CACGkMEviCSEo4thkFo8gYnv+FCm-v65umJ65fdOwtxbAF_F2Ag@mail.gmail.com>
 <1730790584.4657414-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuqXWznXVR+e_gBuhybTSnEePxXqrmDYFsFGOcuWXbzRg@mail.gmail.com>
In-Reply-To: <CACGkMEuqXWznXVR+e_gBuhybTSnEePxXqrmDYFsFGOcuWXbzRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 6 Nov 2024 09:56:55 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Nov 5, 2024 at 3:23=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> >
> > On Tue, 5 Nov 2024 11:23:50 +0800, Jason Wang <jasowang@redhat.com> wro=
te:
> > > On Wed, Oct 30, 2024 at 4:25=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > virtio-net rq submits premapped per-buffer by setting sg page to NU=
LL;
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 24 +++++++++++++-----------
> > > >  1 file changed, 13 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 792e9eadbfc3..09757fa408bd 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -542,6 +542,12 @@ static struct sk_buff *ptr_to_skb(void *ptr)
> > > >         return (struct sk_buff *)((unsigned long)ptr & ~VIRTIO_ORPH=
AN_FLAG);
> > > >  }
> > > >
> > > > +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u=
32 len)
> > > > +{
> > > > +       sg->dma_address =3D addr;
> > > > +       sg->length =3D len;
> > >
> > > This may work but I think it's better to reuse existing dma sg helper=
s like:
> > >
> > > sg_dma_address(sg) =3D addr;
> > > sg_dma_length(sg) =3D len;
> > >
> > > And we probably need to fix the virtio core which only uses
> > > sg_dma_address() but not sg_dma_length().
> > >
> > > This helps us to avoid future issues when CONFIG_NEED_SG_DMA_LENGTH i=
s set.
> >
> >
> > I don't think so.
> >
> > For no-premapped mode, we pass the sg as no-dma sg to virtio core,
> > so the virtio core uses the sg->length directly.
>
> This is fine.
>
> > If virtio core do dma map for sg, we do not use the dma_mag_sg_attrs(),
> > so we must use sg->length directly.
>
> I meant it's a hack. It may work now but will be a bug in the future.
>
> For example, I'm playing a prototype to do pre mapping for virtio-blk,
> the idea is to move the expensive DMA mappings in the case of swiotlb
> etc to be done outside the pre virtqueue lock. In that case, the
> driver may want to use dma_map_sg() instead of dma_map_page().
>
> I'd suppose we will finally go with the way where DMA mappings needs
> to be handled by the driver, and dma_map_sg() is faster than per sg
> dma_map_page() anyhow.
>
> >
> > In this case, for the driver, we can not use sg_dma_length(),
> > if CONFIG_NEED_SG_DMA_LENGTH is set, sg_dma_length() will set sg->dma_l=
ength,
> > but virtio core use sg->length.
>
> Well, we just need a minor tweak to get the length from
> vring_map_one_sg(), then everything should be fine?
>
> if (sg_is_premapped) {
>       *addr =3D sg_dma_address(sg);
>       *len =3D sg_dma_len(sg);
> }

For now, let us start from:

 if (sg_is_premapped) {
       *addr =3D sg_dma_address(sg);
       sg->length =3D sg_dma_len(sg);
 }

Then virtio core needs to be refactor to use dma_map_sg() in future.

Thanks.


>
> >
> > For sg->dma_address, it is ok for me to use sg_dma_address or not.
> > But for consistency to sg->length, I use the sg->dma_address directly.
> >
> > I noticed this is special, so I put them into an independent function.
> >
> > Thanks.
>
> Actually, the code like sg_fill_dma() calls for a virtqueue dma
> mapping helper, I think we've agreed that core needs to hide DMA
> details from the driver.  That is something like
> virtqueue_dma_map_sg() etc.
>
> Thanks
>
> >
> > >
> > > Others look good.
> > >
> > > Thanks
> > >
> > > > +}
> > > > +
> > > >  static void __free_old_xmit(struct send_queue *sq, struct netdev_q=
ueue *txq,
> > > >                             bool in_napi, struct virtnet_sq_free_st=
ats *stats)
> > > >  {
> > > > @@ -915,8 +921,7 @@ static void virtnet_rq_init_one_sg(struct recei=
ve_queue *rq, void *buf, u32 len)
> > > >         addr =3D dma->addr - sizeof(*dma) + offset;
> > > >
> > > >         sg_init_table(rq->sg, 1);
> > > > -       rq->sg[0].dma_address =3D addr;
> > > > -       rq->sg[0].length =3D len;
> > > > +       sg_fill_dma(rq->sg, addr, len);
> > > >  }
> > > >
> > > >  static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, =
gfp_t gfp)
> > > > @@ -1068,12 +1073,6 @@ static void check_sq_full_and_disable(struct=
 virtnet_info *vi,
> > > >         }
> > > >  }
> > > >
> > > > -static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u=
32 len)
> > > > -{
> > > > -       sg->dma_address =3D addr;
> > > > -       sg->length =3D len;
> > > > -}
> > > > -
> > > >  static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
> > > >                                    struct receive_queue *rq, void *=
buf, u32 len)
> > > >  {
> > > > @@ -1354,7 +1353,8 @@ static int virtnet_add_recvbuf_xsk(struct vir=
tnet_info *vi, struct receive_queue
> > > >                 sg_init_table(rq->sg, 1);
> > > >                 sg_fill_dma(rq->sg, addr, len);
> > > >
> > > > -               err =3D virtqueue_add_inbuf(rq->vq, rq->sg, 1, xsk_=
buffs[i], gfp);
> > > > +               err =3D virtqueue_add_inbuf_premapped(rq->vq, rq->s=
g, 1, xsk_buffs[i],
> > > > +                                                   NULL, true, gfp=
);
> > > >                 if (err)
> > > >                         goto err;
> > > >         }
> > > > @@ -2431,7 +2431,8 @@ static int add_recvbuf_small(struct virtnet_i=
nfo *vi, struct receive_queue *rq,
> > > >
> > > >         virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_L=
EN);
> > > >
> > > > -       err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx=
, gfp);
> > > > +       err =3D virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, bu=
f, ctx,
> > > > +                                           rq->do_dma, gfp);
> > > >         if (err < 0) {
> > > >                 if (rq->do_dma)
> > > >                         virtnet_rq_unmap(rq, buf, 0);
> > > > @@ -2546,7 +2547,8 @@ static int add_recvbuf_mergeable(struct virtn=
et_info *vi,
> > > >         virtnet_rq_init_one_sg(rq, buf, len);
> > > >
> > > >         ctx =3D mergeable_len_to_ctx(len + room, headroom);
> > > > -       err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx=
, gfp);
> > > > +       err =3D virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, bu=
f, ctx,
> > > > +                                           rq->do_dma, gfp);
> > > >         if (err < 0) {
> > > >                 if (rq->do_dma)
> > > >                         virtnet_rq_unmap(rq, buf, 0);
> > > > --
> > > > 2.32.0.3.g01195cf9f
> > > >
> > >
> >
>
