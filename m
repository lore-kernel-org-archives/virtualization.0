Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103D61482E1
	for <virtualization@lists.linux.dev>; Wed,  4 Sep 2024 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725435456; cv=none; b=VUWHq6cluz2OvXvhAikDbRMrslMObDOtMi2RF9m7jBXyx73uRaBFz9cihu3iaSZ1KqGrdeVfMdkECk9KPoFj6nfqI2miPRxl0OJq10v5Xix1aswf8IY21EeOrJP89KjFxTXqc9pWr/KtaTaFdOkLjCBVbGym7i/Y59Dk9TYdwns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725435456; c=relaxed/simple;
	bh=SXoL0Y2uBCH4szH5JIB1/cEQ+UnjAZakw05pl633cJ0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=L5FrfQgyrYZDjoXb0DQquq/onFTOWMqfSx+YFJVJtrNYFRkie7xyD3bvCoSZbVwOzkXu7UXGQFYAh/k3EyYFyofG1oqhjVezn6lnPA5+LAVTisZ34tmijgqfWnb56502QEuZR0yeo5+CpOnuTlJR9G4k1RmCgZmg913+U8GTsQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=j8V7RAgw; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="j8V7RAgw"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725435445; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=ciPN8fkQH+unZgllpAVfdRbO08g5aZIPzLBXvT9Tb5A=;
	b=j8V7RAgwpSE4c8k6ZxXJIsGaoD1+bCwusI0u3LEjQksOKElDAg1FkEUKnr3Uh+umCEeoU5x/Xk22h/k5u0RwM+i+tQqKtQXQbV6xXI0GfzJ5HRyfyJklVRRMhnM2I5yJAtVAHMuHI1s6YE33CJvJvHSWxcCEiftp1Sey7fqdHuI=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEGYzGb_1725435444)
          by smtp.aliyun-inc.com;
          Wed, 04 Sep 2024 15:37:24 +0800
Message-ID: <1725435002.9733856-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [External] Re: [PATCH v2] virtio_net: Fix mismatched buf address when unmapping for small packets
Date: Wed, 4 Sep 2024 15:30:02 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: =?utf-8?b?5paH5Y2a5p2O?= <liwenbo.martin@bytedance.com>
Cc: virtualization@lists.linux.dev,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
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
 <1725432304.274084-1-xuanzhuo@linux.alibaba.com>
 <CABwj4+hMwUQ+=m+XyG=66e+PUbOzOvHEsQzboB17DE+3aBHA3g@mail.gmail.com>
In-Reply-To: <CABwj4+hMwUQ+=m+XyG=66e+PUbOzOvHEsQzboB17DE+3aBHA3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 4 Sep 2024 15:21:28 +0800, =3D?utf-8?b?5paH5Y2a5p2O?=3D <liwenbo.ma=
rtin@bytedance.com> wrote:
> When SWIOTLB is enabled, a DMA map will allocate a bounce buffer for real
> DMA operations,
> and when unmapping, SWIOTLB copies the content in the bounce buffer to the
> driver-allocated
> buffer (the `buf` variable). Such copy only synchronizes data in the buff=
er
> range, not the whole page.
> So we should give the correct offset for DMA unmapping.

I see.

But I think we should pass the "correct" buf to virtio core as the "data" by
virtqueue_add_inbuf_ctx().

In the merge mode, we pass the pointer that points to the virtnet header.
In the small mode, we pass the pointer that points to the virtnet header - =
offset.

But this is not the only problem, we try to get the virtnet header by the b=
uf
inside receive_buf(before receive_small).

	flags =3D ((struct virtio_net_common_hdr *)buf)->hdr.flags;

So I think it is time to unify the buf that passed to the virtio core into a
pointer pointed to the virtnet header.

Thanks.


>
> Thanks.
>
> On Wed, Sep 4, 2024 at 2:46=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> >
> > On Wed,  4 Sep 2024 14:10:09 +0800, Wenbo Li <liwenbo.martin@bytedance.=
com>
> wrote:
> > > Currently, the virtio-net driver will perform a pre-dma-mapping for
> > > small or mergeable RX buffer. But for small packets, a mismatched
> address
> > > without VIRTNET_RX_PAD and xdp_headroom is used for unmapping.
> >
> > Will used virt_to_head_page(), so could you say more about it?
> >
> >         struct page *page =3D virt_to_head_page(buf);
> >
> > Thanks.
> >
> > >
> > > That will result in unsynchronized buffers when SWIOTLB is enabled, f=
or
> > > example, when running as a TDX guest.
> > >
> > > This patch handles small and mergeable packets separately and fixes
> > > the mismatched buffer address.
> > >
> > > Changes from v1: Use ctx to get xdp_headroom.
> > >
> > > Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling
> mergeable buffers")
> > > Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
> > > Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
> > > Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>
> > > ---
> > >  drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++++-
> > >  1 file changed, 28 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index c6af18948..cbc3c0ae4 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -891,6 +891,23 @@ static void *virtnet_rq_get_buf(struct
> receive_queue *rq, u32 *len, void **ctx)
> > >       return buf;
> > >  }
> > >
> > > +static void *virtnet_rq_get_buf_small(struct receive_queue *rq,
> > > +                                   u32 *len,
> > > +                                   void **ctx,
> > > +                                   unsigned int header_offset)
> > > +{
> > > +     void *buf;
> > > +     unsigned int xdp_headroom;
> > > +
> > > +     buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > > +     if (buf) {
> > > +             xdp_headroom =3D (unsigned long)*ctx;
> > > +             virtnet_rq_unmap(rq, buf + VIRTNET_RX_PAD + xdp_headroo=
m,
> *len);
> > > +     }
> > > +
> > > +     return buf;
> > > +}
> > > +
> > >  static void virtnet_rq_init_one_sg(struct receive_queue *rq, void
> *buf, u32 len)
> > >  {
> > >       struct virtnet_rq_dma *dma;
> > > @@ -2692,13 +2709,23 @@ static int virtnet_receive_packets(struct
> virtnet_info *vi,
> > >       int packets =3D 0;
> > >       void *buf;
> > >
> > > -     if (!vi->big_packets || vi->mergeable_rx_bufs) {
> > > +     if (vi->mergeable_rx_bufs) {
> > >               void *ctx;
> > >               while (packets < budget &&
> > >                      (buf =3D virtnet_rq_get_buf(rq, &len, &ctx))) {
> > >                       receive_buf(vi, rq, buf, len, ctx, xdp_xmit,
> stats);
> > >                       packets++;
> > >               }
> > > +     } else if (!vi->big_packets) {
> > > +             void *ctx;
> > > +             unsigned int xdp_headroom =3D virtnet_get_headroom(vi);
> > > +             unsigned int header_offset =3D VIRTNET_RX_PAD +
> xdp_headroom;
> > > +
> > > +             while (packets < budget &&
> > > +                    (buf =3D virtnet_rq_get_buf_small(rq, &len, &ctx,
> header_offset))) {
> > > +                     receive_buf(vi, rq, buf, len, ctx, xdp_xmit,
> stats);
> > > +                     packets++;
> > > +             }
> > >       } else {
> > >               while (packets < budget &&
> > >                      (buf =3D virtqueue_get_buf(rq->vq, &len)) !=3D N=
ULL) {
> > > --
> > > 2.20.1
> > >
>
