Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3119D29429
	for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 02:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926766; cv=none; b=I05VmIuDaVu93BSUNT02cbDDKI7QdeoBIOSVct/TvxClZz0T/YQ4rk0izlkRefKUe9A/SHOdlVuFl44pKyuKzZTZjwZk6CwGDHf6UknH0xThXUdypv8uVjDgIPMJ99ljLwIuB1t4k2NrvwsLawF2lcNl1c+h0ROXcb4t0J7K+EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926766; c=relaxed/simple;
	bh=tH+MhPSlLHd6gxLWbVBzS55Bz3bdEtGedWDKLMCZabQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NaKCPlCpDHh4DbEGmHZnLfNukjQqCnz38mtntm3XekkydeFrKxN3jERhw86BCjC1CptC2ripLa2RzKODLigMl23+uVuFVPE22QbR09z+53HvrjPmR0npIn6upOVafuDrITrW0Y/JaJlEVrZwJYpMVs1/QUJixXLtUs98G31XHLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IS4Ihyqx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IS4Ihyqx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713926764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PDcUXJ8RrDgKQ8C374UuDXdrgd6dC8CTwukcjYO2cM=;
	b=IS4IhyqxrvTuC5mMOw83u0KhoypxVHIn9pmLIa1x+6m7pj55HOs5lG2oZLovZXHgGZLXDi
	VNymrsEgOwo9lBc4g36P8kRsjOiU2ChrK5W4SQUyDVj9wGsfBvc+AdfYAcsm5VzRmPzEqO
	BtcqR1kDRfIeEKoysgGRsL7D5Ms1gU4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-AchpvO0TP4Kn54fzGddieA-1; Tue, 23 Apr 2024 22:46:02 -0400
X-MC-Unique: AchpvO0TP4Kn54fzGddieA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2abc5b4f3c7so6975497a91.0
        for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 19:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713926761; x=1714531561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PDcUXJ8RrDgKQ8C374UuDXdrgd6dC8CTwukcjYO2cM=;
        b=BbULcRh87x5NuZCRcCxfB95YftSjTKDBV020Efzcb8E4F77WatGc2Gg5Rbg/Yoq4+A
         4roTd521r9anwTdMuCVGN9Df65HwyDPagFzGIcu0zj5qiQrnCRdNf9OPq/Zz78hOkB/Q
         j94W4/rNvWau+iAhxzWvZ5YaawBA01Cr16L2bMAf3HVau3Vuoo8bsNit4Bth2gfpxYPi
         ki3Ko0qwTe1Xc9ltc9cs9eddFx0vey6gugV7naxlb9GbCeXVN2DYPPz9RpPG0HC8vCSF
         EHTJmK514pzOKAYyjJjwzpIwMMc8pIBNg2U78plup9V0Mj+zQ7fhl0bg88u4pYkz86Yx
         4ypw==
X-Gm-Message-State: AOJu0Yz6bxcjZO6HZnorPv8GbPcH5MaKZ6csBb6Vp4E1iREhyuBt6jlN
	wv2hJR420j/8SbKAt20AGFmnlZBu5JIzOdVkvrWR44GnMQ4P6P8p4YX1JFBjrT52YnU9RR8F71f
	iCYB4FGjv8WBqavgzMPtnrqF9ppulyasxER64o2ksgqbV1sGDgKCxnkQqExcs8r0IYj0kgTauot
	a5SZl2cN+8zMqKbuXpw6s6ft2VpzwMFJSEd8YDxZzUKEEiA2SDbA==
X-Received: by 2002:a17:90b:1e0b:b0:2ac:5ac2:8c28 with SMTP id pg11-20020a17090b1e0b00b002ac5ac28c28mr1036625pjb.31.1713926761252;
        Tue, 23 Apr 2024 19:46:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVLWC3cCg68wWrhWPKyCFkmNe3tJMb0rw8u3qkxDuKFL5FaKC+QatWIG18k13HrygUjjzyC5Qt0G7kkJaWot0=
X-Received: by 2002:a17:90b:1e0b:b0:2ac:5ac2:8c28 with SMTP id
 pg11-20020a17090b1e0b00b002ac5ac28c28mr1036615pjb.31.1713926760861; Tue, 23
 Apr 2024 19:46:00 -0700 (PDT)
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
 <1713926353.64557-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1713926353.64557-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Apr 2024 10:45:49 +0800
Message-ID: <CACGkMEvtvtauHk5TXM4Yo3X7Fi99Rjnu43OeZiX4zZU+M_akaw@mail.gmail.com>
Subject: Re: [PATCH vhost v2 4/7] virtio_net: big mode support premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 10:42=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Wed, 24 Apr 2024 10:34:56 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Wed, Apr 24, 2024 at 9:10=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Wed, 24 Apr 2024 08:43:21 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Tue, Apr 23, 2024 at 8:38=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > On Tue, 23 Apr 2024 12:36:42 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Mon, Apr 22, 2024 at 3:24=E2=80=AFPM Xuan Zhuo <xuanzhuo@lin=
ux.alibaba.com> wrote:
> > > > > > >
> > > > > > > In big mode, pre-mapping DMA is beneficial because if the pag=
es are not
> > > > > > > used, we can reuse them without needing to unmap and remap.
> > > > > > >
> > > > > > > We require space to store the DMA address. I use the page.dma=
_addr to
> > > > > > > store the DMA address from the pp structure inside the page.
> > > > > > >
> > > > > > > Every page retrieved from get_a_page() is mapped, and its DMA=
 address is
> > > > > > > stored in page.dma_addr. When a page is returned to the chain=
, we check
> > > > > > > the DMA status; if it is not mapped (potentially having been =
unmapped),
> > > > > > > we remap it before returning it to the chain.
> > > > > > >
> > > > > > > Based on the following points, we do not use page pool to man=
age these
> > > > > > > pages:
> > > > > > >
> > > > > > > 1. virtio-net uses the DMA APIs wrapped by virtio core. There=
fore,
> > > > > > >    we can only prevent the page pool from performing DMA oper=
ations, and
> > > > > > >    let the driver perform DMA operations on the allocated pag=
es.
> > > > > > > 2. But when the page pool releases the page, we have no chanc=
e to
> > > > > > >    execute dma unmap.
> > > > > > > 3. A solution to #2 is to execute dma unmap every time before=
 putting
> > > > > > >    the page back to the page pool. (This is actually a waste,=
 we don't
> > > > > > >    execute unmap so frequently.)
> > > > > > > 4. But there is another problem, we still need to use page.dm=
a_addr to
> > > > > > >    save the dma address. Using page.dma_addr while using page=
 pool is
> > > > > > >    unsafe behavior.
> > > > > > >
> > > > > > > More:
> > > > > > >     https://lore.kernel.org/all/CACGkMEu=3DAok9z2imB_c5qVuujS=
h=3Dvjj1kx12fy9N7hqyi+M5Ow@mail.gmail.com/
> > > > > > >
> > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > ---
> > > > > > >  drivers/net/virtio_net.c | 123 +++++++++++++++++++++++++++++=
+++++-----
> > > > > > >  1 file changed, 108 insertions(+), 15 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_ne=
t.c
> > > > > > > index 2c7a67ad4789..d4f5e65b247e 100644
> > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > @@ -439,6 +439,81 @@ skb_vnet_common_hdr(struct sk_buff *skb)
> > > > > > >         return (struct virtio_net_common_hdr *)skb->cb;
> > > > > > >  }
> > > > > > >
> > > > > > > +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t a=
ddr, u32 len)
> > > > > > > +{
> > > > > > > +       sg->dma_address =3D addr;
> > > > > > > +       sg->length =3D len;
> > > > > > > +}
> > > > > > > +
> > > > > > > +/* For pages submitted to the ring, we need to record its dm=
a for unmap.
> > > > > > > + * Here, we use the page.dma_addr and page.pp_magic to store=
 the dma
> > > > > > > + * address.
> > > > > > > + */
> > > > > > > +static void page_chain_set_dma(struct page *p, dma_addr_t ad=
dr)
> > > > > > > +{
> > > > > > > +       if (sizeof(dma_addr_t) > sizeof(unsigned long)) {
> > > > > >
> > > > > > Need a macro like PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA.
> > > > > >
> > > > > > > +               p->dma_addr =3D lower_32_bits(addr);
> > > > > > > +               p->pp_magic =3D upper_32_bits(addr);
> > > > > >
> > > > > > And this uses three fields on page_pool which I'm not sure the =
other
> > > > > > maintainers are happy with. For example, re-using pp_maing migh=
t be
> > > > > > dangerous. See c07aea3ef4d40 ("mm: add a signature in struct pa=
ge").
> > > > > >
> > > > > > I think a more safe way is to reuse page pool, for example intr=
oducing
> > > > > > a new flag with dma callbacks?
> > > > >
> > > > > If we use page pool, how can we chain the pages allocated for a p=
acket?
> > > >
> > > > I'm not sure I get this, it is chained via the descriptor flag.
> > >
> > >
> > > In the big mode, we will commit many pages to the virtio core by
> > > virtqueue_add_inbuf().
> > >
> > > By virtqueue_get_buf_ctx(), we got the data. That is the first page.
> > > Other pages are chained by the "private".
> > >
> > > If we use the page pool, how can we chain the pages.
> > > After virtqueue_add_inbuf(), we need to get the pages to fill the skb=
.
> >
> > Right, technically it could be solved by providing helpers in the
> > virtio core, but considering it's an optimization for big mode which
> > is not popular, it's not worth to bother.
> >
> > >
> > >
> > >
> > > >
> > > > >
> > > > > Yon know the "private" can not be used.
> > > > >
> > > > >
> > > > > If the pp struct inside the page is not safe, how about:
> > > > >
> > > > >                 struct {        /* Page cache and anonymous pages=
 */
> > > > >                         /**
> > > > >                          * @lru: Pageout list, eg. active_list pr=
otected by
> > > > >                          * lruvec->lru_lock.  Sometimes used as a=
 generic list
> > > > >                          * by the page owner.
> > > > >                          */
> > > > >                         union {
> > > > >                                 struct list_head lru;
> > > > >
> > > > >                                 /* Or, for the Unevictable "LRU l=
ist" slot */
> > > > >                                 struct {
> > > > >                                         /* Always even, to negate=
 PageTail */
> > > > >                                         void *__filler;
> > > > >                                         /* Count page's or folio'=
s mlocks */
> > > > >                                         unsigned int mlock_count;
> > > > >                                 };
> > > > >
> > > > >                                 /* Or, free page */
> > > > >                                 struct list_head buddy_list;
> > > > >                                 struct list_head pcp_list;
> > > > >                         };
> > > > >                         /* See page-flags.h for PAGE_MAPPING_FLAG=
S */
> > > > >                         struct address_space *mapping;
> > > > >                         union {
> > > > >                                 pgoff_t index;          /* Our of=
fset within mapping. */
> > > > >                                 unsigned long share;    /* share =
count for fsdax */
> > > > >                         };
> > > > >                         /**
> > > > >                          * @private: Mapping-private opaque data.
> > > > >                          * Usually used for buffer_heads if PageP=
rivate.
> > > > >                          * Used for swp_entry_t if PageSwapCache.
> > > > >                          * Indicates order in the buddy system if=
 PageBuddy.
> > > > >                          */
> > > > >                         unsigned long private;
> > > > >                 };
> > > > >
> > > > > Or, we can map the private space of the page as a new structure.
> > > >
> > > > It could be a way. But such allocation might be huge if we are usin=
g
> > > > indirect descriptors or I may miss something.
> > >
> > > No. we only need to store the "chain next" and the dma as this patch =
set did.
> > > The size of the private space inside the page is  20(32bit)/40(64bit)=
 bytes.
> > > That is enough for us.
> > >
> > > If you worry about the change of the pp structure, we can use the "pr=
ivate" as
> > > origin and use the "struct list_head lru" to store the dma.
> >
> > This looks even worse, as it uses fields belonging to the different
> > structures in the union.
>
> I mean we do not use the elems from the pp structure inside the page,
> if we worry the change of the pp structure.
>
> I mean use the "private" and "lru", these in the same structure.
>
> I think this is a good way.
>
> Thanks.

See this:

https://lore.kernel.org/netdev/20210411114307.5087f958@carbon/

Thanks

