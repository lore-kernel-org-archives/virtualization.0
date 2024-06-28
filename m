Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18044502D
	for <virtualization@lists.linux.dev>; Fri, 28 Jun 2024 05:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553434; cv=none; b=M52yYiGZ9vYcavibfmIqNY9eNCnDzOBUsC+xWcJwCTZfosWfjI6yhY93KFqV4sZY2yc1hm4GDvoz4LOX7WYJU573XiJf4gle4Bk17kwhHrfuuLnRAXi10y8JfxV8oaU/RTIqrQHchVZgepmmANcXMZ7HVpWSbzFJM5l36Hy6OLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553434; c=relaxed/simple;
	bh=6hGeZecioq+y13J2GuEtEopfpkVV0aXCZs+PJruPyw8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=bi2GNzk6D9d4iSUwoyOBB85oZD5BwRs0/nw9qLvY+ijj16ioIVPsH7O79ibqNugOSsfI1jBIs88T3I++m/BbIFnug1CENus+zB0FBMyiu1Cjuqc9C9ystCs3okbPdNm96EpqeMA/Z/HvFOb5Vap9bhylhbULAev88uABtGxxcAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mK+khEOM; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mK+khEOM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719553429; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=oigxU9OW11eqdIXlUMNJSXXFugkZpgKFvvLNvvI4pQY=;
	b=mK+khEOM8Jq2ReRkJJNuo29JbHjKXt4dCvqbgzL0QHOQR3u/lcrH0GuwuND2oN7Zt0Plf4tRxizJHgFwQZUjM3h4iErfza9vP2vRfL0KkjhD4ivroCp0/J+xQ+xXg7ops8vGOTLKVjymQwmdT+fOmQZG7fXH7KBMWJjtOkFg9Ko=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W9PGH13_1719553427;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W9PGH13_1719553427)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 13:43:48 +0800
Message-ID: <1719553356.2373846-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 07/10] virtio_net: xsk: rx: support fill with xsk buffer
Date: Fri, 28 Jun 2024 13:42:36 +0800
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
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
 <20240618075643.24867-8-xuanzhuo@linux.alibaba.com>
 <CACGkMEta9o97cqUy+wV=1Xpu8MBoFt4CEtWS35dhTMs0Dm4AKg@mail.gmail.com>
In-Reply-To: <CACGkMEta9o97cqUy+wV=1Xpu8MBoFt4CEtWS35dhTMs0Dm4AKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Fri, 28 Jun 2024 10:19:37 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Jun 18, 2024 at 3:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > Implement the logic of filling rq with XSK buffers.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 68 ++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 66 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 2bbc715f22c6..2ac5668a94ce 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -355,6 +355,8 @@ struct receive_queue {
> >
> >                 /* xdp rxq used by xsk */
> >                 struct xdp_rxq_info xdp_rxq;
> > +
> > +               struct xdp_buff **xsk_buffs;
> >         } xsk;
> >  };
> >
> > @@ -1032,6 +1034,53 @@ static void check_sq_full_and_disable(struct vir=
tnet_info *vi,
> >         }
> >  }
> >
> > +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 l=
en)
> > +{
> > +       sg->dma_address =3D addr;
> > +       sg->length =3D len;
> > +}
> > +
> > +static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct rec=
eive_queue *rq,
> > +                                  struct xsk_buff_pool *pool, gfp_t gf=
p)
> > +{
> > +       struct xdp_buff **xsk_buffs;
> > +       dma_addr_t addr;
> > +       u32 len, i;
> > +       int err =3D 0;
> > +       int num;
> > +
> > +       xsk_buffs =3D rq->xsk.xsk_buffs;
> > +
> > +       num =3D xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
> > +       if (!num)
> > +               return -ENOMEM;
> > +
> > +       len =3D xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> > +
> > +       for (i =3D 0; i < num; ++i) {
> > +               /* use the part of XDP_PACKET_HEADROOM as the virtnet h=
dr space */
> > +               addr =3D xsk_buff_xdp_get_dma(xsk_buffs[i]) - vi->hdr_l=
en;
>
> We had VIRTIO_XDP_HEADROOM, can we reuse it? Or if it's redundant
> let's send a patch to switch to XDP_PACKET_HEADROOM.

Do you mean replace it inside the comment?

I want to describe use the headroom of xsk, the size of the headroom is
XDP_PACKET_HEADROOM.

>
> Btw, the code assumes vi->hdr_len < xsk_pool_get_headroom(). It's
> better to fail if it's not true when enabling xsk.

It is ok.

Thanks.


>
> Thanks
>
