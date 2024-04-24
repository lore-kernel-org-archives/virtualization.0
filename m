Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B639313340B
	for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 03:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930661; cv=none; b=T/FZyVYREAlaoOCGYTP/Il5WJ1L+jxDHFpDCirFYVqaQXKJ3A71dkJVykgYNm6nnqXeij8XQPue8R4T8w8qhEsdQ2P6St4Y3VNwpHsDozqFvHKwhf6sXmDfdLJCyuweujVVdqEBYxudlFp6lWV7zb5YnFOB887V8MSEWZhDMvxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930661; c=relaxed/simple;
	bh=ektCeJP0IcloJUtFfxfk1rmzt1NkF9oT1k1GRRAqnOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kd7JauLjj0cFKBOgzMFKa/jD5Q9TZNFm8icHVqHSSOSg/k4Rq+YtofUTEI/p+j2Im7aozRhQxtV7FIHwPSSoGcJI21MEH8X0KFrUTNP/bZqqD3QDSi0v6jJoS8ejyg90ztd9mPIOo2JEwQpnqUCSZcXHa1Tj16Gh1hy6N9038Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5s/D9QQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5s/D9QQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713930658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yuZgGvtdvrOd5KzZVZZ9LDBbgjnvMc3W2Tm9oKYellU=;
	b=E5s/D9QQppBrUPUAvtevGePGlYGtrvUzEtUTfm6vLV1ay+ZVYyJQpBPfnANvQCF0CYh1n1
	X4E3DIikVW6YRJJiRoZjYftmRWQUAJuenwD8d9OwFYDrk6EWGLaVbnCckXQ8e1nRyh5wRg
	PKvIyoxOF4iQbrTQSYMFcUFxjWbSLy8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-F9CwkZORN-qIQh3BvP3MQQ-1; Tue, 23 Apr 2024 23:50:57 -0400
X-MC-Unique: F9CwkZORN-qIQh3BvP3MQQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a473ba0632so7975722a91.0
        for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 20:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713930656; x=1714535456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuZgGvtdvrOd5KzZVZZ9LDBbgjnvMc3W2Tm9oKYellU=;
        b=cEi7E45ubssLF64s2aF0B7K6cf9DOdB5BlHCKKekvvHK8evLOkXumQM8p9uTF/lbRn
         xuTgsS45m+8abvK2nRLEFRL9y/ZWtRhj/7Cw/d31XaAVs6IgQCAzeUkvDL9vkOIztC20
         Zvb9KgLEmLNieYGZBd8rd+KpHRXt32j0SNLccjWzkGPCcEzZNpPcgz/buDsy2ML+92gm
         xOF7g+tcj7033E5aEgp9MqBRa/ZtkRVeAi9tv6fWIBvrzOVQ9Vp8eagnw9cLhsxYijAe
         Fb01OZQyY8ZoMJIQWuBsN4BhbgvbD1GXvi1SpnyAYTYcs03qvaEHNT9kCz/aLNwfL+nW
         3Csw==
X-Gm-Message-State: AOJu0YwZ3w0NpvMzz5b56EtP7Mv0LPui1vEptoF8ot7eurKnaokGub5o
	0UsJmamHc7sKFg0IxmiNX7fUim2T4F0ais3LEG3s2G18OgBJaGHKyqOsgFHCvcM/rxlasD8Pi8c
	UyDLjZ0/JhwCZpD4UjHPL82nUTJAy5E3bf44YvoiypM5QhLIZW6MqjPoZ2ijnI2m7NoTwnoUmoQ
	ZfbCQz9JrgjpYj2vku3TExbdpt5t0D6FJLxBTDBbY=
X-Received: by 2002:a17:90b:5307:b0:2a6:f14a:ba7a with SMTP id sq7-20020a17090b530700b002a6f14aba7amr1407675pjb.25.1713930656035;
        Tue, 23 Apr 2024 20:50:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB37S3Rqwef3hn9UuiP1t3AQPNFvbkjDbVMZ9wnHn6WAC3SHET0gfJsicMX5k/O8k0kCmFpP8f1E6dLkS6X4Y=
X-Received: by 2002:a17:90b:5307:b0:2a6:f14a:ba7a with SMTP id
 sq7-20020a17090b530700b002a6f14aba7amr1407662pjb.25.1713930655711; Tue, 23
 Apr 2024 20:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240422072408.126821-1-xuanzhuo@linux.alibaba.com>
 <20240422072408.126821-5-xuanzhuo@linux.alibaba.com> <CACGkMEuEYwR_QE-hhnD0KYujD6MVEArz3FPyjsfmJ-jk_02hZw@mail.gmail.com>
 <1713875473.8690095-1-xuanzhuo@linux.alibaba.com> <CACGkMEs=6Xfc1hELudF=+xvoJN+npQw11BqP0jjCxmUy2jaikg@mail.gmail.com>
 <1713919985.3490202-1-xuanzhuo@linux.alibaba.com> <CACGkMEu21VCPnuNM-MURnq40LKxysOJD0aJhPQE4Dbt2qT5rEg@mail.gmail.com>
 <1713926353.64557-3-xuanzhuo@linux.alibaba.com> <CACGkMEvtvtauHk5TXM4Yo3X7Fi99Rjnu43OeZiX4zZU+M_akaw@mail.gmail.com>
 <1713927254.7707088-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1713927254.7707088-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Apr 2024 11:50:44 +0800
Message-ID: <CACGkMEuyeJ9mMgYnnB42=hw6umNuo=agn7VBqBqYPd7GN=+39Q@mail.gmail.com>
Subject: Re: [PATCH vhost v2 4/7] virtio_net: big mode support premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 10:58=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Wed, 24 Apr 2024 10:45:49 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Wed, Apr 24, 2024 at 10:42=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > On Wed, 24 Apr 2024 10:34:56 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Wed, Apr 24, 2024 at 9:10=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > On Wed, 24 Apr 2024 08:43:21 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Tue, Apr 23, 2024 at 8:38=E2=80=AFPM Xuan Zhuo <xuanzhuo@lin=
ux.alibaba.com> wrote:
> > > > > > >
> > > > > > > On Tue, 23 Apr 2024 12:36:42 +0800, Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > > > > On Mon, Apr 22, 2024 at 3:24=E2=80=AFPM Xuan Zhuo <xuanzhuo=
@linux.alibaba.com> wrote:
> > > > > > > > >
> > > > > > > > > In big mode, pre-mapping DMA is beneficial because if the=
 pages are not
> > > > > > > > > used, we can reuse them without needing to unmap and rema=
p.
> > > > > > > > >
> > > > > > > > > We require space to store the DMA address. I use the page=
.dma_addr to
> > > > > > > > > store the DMA address from the pp structure inside the pa=
ge.
> > > > > > > > >
> > > > > > > > > Every page retrieved from get_a_page() is mapped, and its=
 DMA address is
> > > > > > > > > stored in page.dma_addr. When a page is returned to the c=
hain, we check
> > > > > > > > > the DMA status; if it is not mapped (potentially having b=
een unmapped),
> > > > > > > > > we remap it before returning it to the chain.
> > > > > > > > >
> > > > > > > > > Based on the following points, we do not use page pool to=
 manage these
> > > > > > > > > pages:
> > > > > > > > >
> > > > > > > > > 1. virtio-net uses the DMA APIs wrapped by virtio core. T=
herefore,
> > > > > > > > >    we can only prevent the page pool from performing DMA =
operations, and
> > > > > > > > >    let the driver perform DMA operations on the allocated=
 pages.
> > > > > > > > > 2. But when the page pool releases the page, we have no c=
hance to
> > > > > > > > >    execute dma unmap.
> > > > > > > > > 3. A solution to #2 is to execute dma unmap every time be=
fore putting
> > > > > > > > >    the page back to the page pool. (This is actually a wa=
ste, we don't
> > > > > > > > >    execute unmap so frequently.)
> > > > > > > > > 4. But there is another problem, we still need to use pag=
e.dma_addr to
> > > > > > > > >    save the dma address. Using page.dma_addr while using =
page pool is
> > > > > > > > >    unsafe behavior.
> > > > > > > > >
> > > > > > > > > More:
> > > > > > > > >     https://lore.kernel.org/all/CACGkMEu=3DAok9z2imB_c5qV=
uujSh=3Dvjj1kx12fy9N7hqyi+M5Ow@mail.gmail.com/
> > > > > > > > >
> > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/net/virtio_net.c | 123 +++++++++++++++++++++++++=
+++++++++-----
> > > > > > > > >  1 file changed, 108 insertions(+), 15 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virti=
o_net.c
> > > > > > > > > index 2c7a67ad4789..d4f5e65b247e 100644
> > > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > > @@ -439,6 +439,81 @@ skb_vnet_common_hdr(struct sk_buff *=
skb)
> > > > > > > > >         return (struct virtio_net_common_hdr *)skb->cb;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static void sg_fill_dma(struct scatterlist *sg, dma_addr=
_t addr, u32 len)
> > > > > > > > > +{
> > > > > > > > > +       sg->dma_address =3D addr;
> > > > > > > > > +       sg->length =3D len;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +/* For pages submitted to the ring, we need to record it=
s dma for unmap.
> > > > > > > > > + * Here, we use the page.dma_addr and page.pp_magic to s=
tore the dma
> > > > > > > > > + * address.
> > > > > > > > > + */
> > > > > > > > > +static void page_chain_set_dma(struct page *p, dma_addr_=
t addr)
> > > > > > > > > +{
> > > > > > > > > +       if (sizeof(dma_addr_t) > sizeof(unsigned long)) {
> > > > > > > >
> > > > > > > > Need a macro like PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA.
> > > > > > > >
> > > > > > > > > +               p->dma_addr =3D lower_32_bits(addr);
> > > > > > > > > +               p->pp_magic =3D upper_32_bits(addr);
> > > > > > > >
> > > > > > > > And this uses three fields on page_pool which I'm not sure =
the other
> > > > > > > > maintainers are happy with. For example, re-using pp_maing =
might be
> > > > > > > > dangerous. See c07aea3ef4d40 ("mm: add a signature in struc=
t page").
> > > > > > > >
> > > > > > > > I think a more safe way is to reuse page pool, for example =
introducing
> > > > > > > > a new flag with dma callbacks?
> > > > > > >
> > > > > > > If we use page pool, how can we chain the pages allocated for=
 a packet?
> > > > > >
> > > > > > I'm not sure I get this, it is chained via the descriptor flag.
> > > > >
> > > > >
> > > > > In the big mode, we will commit many pages to the virtio core by
> > > > > virtqueue_add_inbuf().
> > > > >
> > > > > By virtqueue_get_buf_ctx(), we got the data. That is the first pa=
ge.
> > > > > Other pages are chained by the "private".
> > > > >
> > > > > If we use the page pool, how can we chain the pages.
> > > > > After virtqueue_add_inbuf(), we need to get the pages to fill the=
 skb.
> > > >
> > > > Right, technically it could be solved by providing helpers in the
> > > > virtio core, but considering it's an optimization for big mode whic=
h
> > > > is not popular, it's not worth to bother.
> > > >
> > > > >
> > > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Yon know the "private" can not be used.
> > > > > > >
> > > > > > >
> > > > > > > If the pp struct inside the page is not safe, how about:
> > > > > > >
> > > > > > >                 struct {        /* Page cache and anonymous p=
ages */
> > > > > > >                         /**
> > > > > > >                          * @lru: Pageout list, eg. active_lis=
t protected by
> > > > > > >                          * lruvec->lru_lock.  Sometimes used =
as a generic list
> > > > > > >                          * by the page owner.
> > > > > > >                          */
> > > > > > >                         union {
> > > > > > >                                 struct list_head lru;
> > > > > > >
> > > > > > >                                 /* Or, for the Unevictable "L=
RU list" slot */
> > > > > > >                                 struct {
> > > > > > >                                         /* Always even, to ne=
gate PageTail */
> > > > > > >                                         void *__filler;
> > > > > > >                                         /* Count page's or fo=
lio's mlocks */
> > > > > > >                                         unsigned int mlock_co=
unt;
> > > > > > >                                 };
> > > > > > >
> > > > > > >                                 /* Or, free page */
> > > > > > >                                 struct list_head buddy_list;
> > > > > > >                                 struct list_head pcp_list;
> > > > > > >                         };
> > > > > > >                         /* See page-flags.h for PAGE_MAPPING_=
FLAGS */
> > > > > > >                         struct address_space *mapping;
> > > > > > >                         union {
> > > > > > >                                 pgoff_t index;          /* Ou=
r offset within mapping. */
> > > > > > >                                 unsigned long share;    /* sh=
are count for fsdax */
> > > > > > >                         };
> > > > > > >                         /**
> > > > > > >                          * @private: Mapping-private opaque d=
ata.
> > > > > > >                          * Usually used for buffer_heads if P=
agePrivate.
> > > > > > >                          * Used for swp_entry_t if PageSwapCa=
che.
> > > > > > >                          * Indicates order in the buddy syste=
m if PageBuddy.
> > > > > > >                          */
> > > > > > >                         unsigned long private;
> > > > > > >                 };
> > > > > > >
> > > > > > > Or, we can map the private space of the page as a new structu=
re.
> > > > > >
> > > > > > It could be a way. But such allocation might be huge if we are =
using
> > > > > > indirect descriptors or I may miss something.
> > > > >
> > > > > No. we only need to store the "chain next" and the dma as this pa=
tch set did.
> > > > > The size of the private space inside the page is  20(32bit)/40(64=
bit) bytes.
> > > > > That is enough for us.
> > > > >
> > > > > If you worry about the change of the pp structure, we can use the=
 "private" as
> > > > > origin and use the "struct list_head lru" to store the dma.
> > > >
> > > > This looks even worse, as it uses fields belonging to the different
> > > > structures in the union.
> > >
> > > I mean we do not use the elems from the pp structure inside the page,
> > > if we worry the change of the pp structure.
> > >
> > > I mean use the "private" and "lru", these in the same structure.
> > >
> > > I think this is a good way.
> > >
> > > Thanks.
> >
> > See this:
> >
> > https://lore.kernel.org/netdev/20210411114307.5087f958@carbon/
>
>
> I think that is because that the page pool will share the page with
> the skbs.  I'm not entirely sure.
>
> In our case, virtio-net fully owns the page. After the page is referenced=
 by skb,
> virtio-net no longer references the page. I don't think there is any prob=
lem
> here.

Well, in the rx path, though the page is allocated by the virtio-net,
unlike the page pool, those pages are not freed by virtio-net. So it
may leave things in the page structure which is problematic. I don't
think we can introduce a virtio-net specific hook for kfree_skb() in
this case. That's why I think leveraging the page pool is better.

For reusing page pool. Maybe we can reuse __pp_mapping_pad for
virtio-net specific use cases like chaining, and clear it in
page_pool_clear_pp_info(). And we need to make sure we don't break
things like TCP RX zerocopy since mapping is aliasied with
__pp_mapping_pad at a first glance.

>
> The key is that who owns the page, who can use the page private space (20=
/40 bytes).
>
> Is that?

I'm not saying we can't investigate in this direction. But it needs
more comments from mm guys and we need to evaluate the price we pay
for that.

The motivation is to drop the fallback code when pre mapping is not
supported to improve the maintainability of the code and ease the
AF_XDP support for virtio-net. But it turns out to be not easy.

Considering the rx fallback code we need to maintain is not too huge,
maybe we can leave it as is, for example forbid AF_XDP in big modes.

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
>

