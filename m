Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58741384
	for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 00:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713487440; cv=none; b=FVe3ZOieUAwTyiKAYKRKroCVoS+oqa2urYK8p9nMKUhl0SutjMQXmtfzgPjhUI34wwHTArkSG3LjzQRmnXZyKhgt4XGtTm+lcWCWOFkwsVDJhSW4btX5VybkVyU9c0Rz53Ve5CIs4HS9eG+pFkwiuq7lkERmQJ45nLFPFrJ7UYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713487440; c=relaxed/simple;
	bh=NvoYWXcUCeCLBGu4JtBttdXFdcj5n8AVLrl7v+iJurg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qetqb5aSO+OoAEHB6RVGGfvQlZFDqD+dGStgJk2aTUcXV4KPRSwHPFmZhp2so8f8soQBdcwMRx2jqpErVF2CrESq7+nsvbIG+oeQavFWGbeGBFykpH8GS2/G3avFOWOO+jICSoyfLh1GtOoMtUass5lgH5drNS7pXCTKfnyMKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bASrT6NA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bASrT6NA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713487438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l1/ROMRzU9L10Q/AcL4DdXj4QCJvFgWW3GT0kUr3mQA=;
	b=bASrT6NAF/qCKp7aaT4gtwW2JXuNy7QSeRY1X3ZRtShBukIi88FtwwXkcubavKAtBBPPuU
	qwYjLJXF30/tnzN+j12/nPPKEZ9nyidLBxVUWbA9xy3B1mCwWNl5v8U/znqHbaEjwUogwR
	U+kIGJH0U57lyBaqR2I8Qr2wkxqqYxs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-UhZcmtINPcKy9oTmSF_E2A-1; Thu, 18 Apr 2024 20:43:57 -0400
X-MC-Unique: UhZcmtINPcKy9oTmSF_E2A-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a6f2c7c1b8so1679344a91.1
        for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 17:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713487436; x=1714092236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1/ROMRzU9L10Q/AcL4DdXj4QCJvFgWW3GT0kUr3mQA=;
        b=gKaWztNMtI4fjF2zFWtyZ8ziOnwEdQ2QPR21R0LT+D1BnV22NUkLxEng6TT0/5g1dH
         qjNInLJSskQji2F14y+EGltFV9RvttM8Z8Qbg+DvwmDYLQ4dvJFzkkogyai4oy9uDpPc
         lKx9mLYNptZOEm3/SQMPa0ysP1O+PLaC/jePFPiyNM5yqRcMo1nGXPRW8Gq4IawwjTHk
         DL9KCYY75NT2vzivkwMNoyi8QOOsXp/LmWLX0bVn+rQ2gc1UZcRoyUzXAV6oKpO2MZOB
         3bZIyU/AY2tFNAduK95/1frdkA4R5s7m2KcDCNeAId44mSOkofNHMWttw2x5qg+glUVf
         ww6w==
X-Gm-Message-State: AOJu0YyApMt+JR+/lRyWKAnSRkg9adu3XusOx/fbcKgbOrWkYPB9sVxm
	XBaRt4Hcxb+pmSqCxDhCilf/S+hwh4fhkWFgAVOmX54Gy7OpvRGxHinjajC6Kld/WV4etOT8ItM
	DbNG/OUoC/OmPOGIflczOEz+hCasVmgK5HZNnxlSMM1j0qWupxc7dCq5WZR88HR8mZUL0+0d0Tv
	7GK7rmyOxioGpgXKEuLjj+mR9kbx2iXtYzdxpLH+4=
X-Received: by 2002:a17:90a:2d86:b0:2a4:ca45:ded1 with SMTP id p6-20020a17090a2d8600b002a4ca45ded1mr754671pjd.28.1713487435835;
        Thu, 18 Apr 2024 17:43:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrJODgxjjhks1FNB/GrFAp9si5jpRmKYLUhr+/7QN32X49c1Nx9rzgCOYSFWHw1aayJzKwrOp7geWlPkC9TJM=
X-Received: by 2002:a17:90a:2d86:b0:2a4:ca45:ded1 with SMTP id
 p6-20020a17090a2d8600b002a4ca45ded1mr754656pjd.28.1713487435495; Thu, 18 Apr
 2024 17:43:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
 <20240411025127.51945-5-xuanzhuo@linux.alibaba.com> <CACGkMEvhejnVM=x2+PxnKXcyC4W4nAbhkt4-reWb-7=fYQ6qKw@mail.gmail.com>
 <1713428960.80807-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1713428960.80807-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Apr 2024 08:43:43 +0800
Message-ID: <CACGkMEvDQ1Zs3Ya0TR1O8SANDEmBQ-+_2iFt7dpBDeE=i+PExQ@mail.gmail.com>
Subject: Re: [PATCH vhost 4/6] virtio_net: big mode support premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 4:35=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 18 Apr 2024 14:25:06 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > In big mode, pre-mapping DMA is beneficial because if the pages are n=
ot
> > > used, we can reuse them without needing to unmap and remap.
> > >
> > > We require space to store the DMA address. I use the page.dma_addr to
> > > store the DMA address from the pp structure inside the page.
> > >
> > > Every page retrieved from get_a_page() is mapped, and its DMA address=
 is
> > > stored in page.dma_addr. When a page is returned to the chain, we che=
ck
> > > the DMA status; if it is not mapped (potentially having been unmapped=
),
> > > we remap it before returning it to the chain.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 98 +++++++++++++++++++++++++++++++++-----=
--
> > >  1 file changed, 81 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 4446fb54de6d..7ea7e9bcd5d7 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -50,6 +50,7 @@ module_param(napi_tx, bool, 0644);
> > >
> > >  #define page_chain_next(p)     ((struct page *)((p)->pp))
> > >  #define page_chain_add(p, n)   ((p)->pp =3D (void *)n)
> > > +#define page_dma_addr(p)       ((p)->dma_addr)
> > >
> > >  /* RX packet size EWMA. The average packet size is used to determine=
 the packet
> > >   * buffer size when refilling RX rings. As the entire RX ring may be=
 refilled
> > > @@ -434,6 +435,46 @@ skb_vnet_common_hdr(struct sk_buff *skb)
> > >         return (struct virtio_net_common_hdr *)skb->cb;
> > >  }
> > >
> > > +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32=
 len)
> > > +{
> > > +       sg->dma_address =3D addr;
> > > +       sg->length =3D len;
> > > +}
> > > +
> > > +static void page_chain_unmap(struct receive_queue *rq, struct page *=
p)
> > > +{
> > > +       virtqueue_dma_unmap_page_attrs(rq->vq, page_dma_addr(p), PAGE=
_SIZE,
> > > +                                      DMA_FROM_DEVICE, 0);
> > > +
> > > +       page_dma_addr(p) =3D DMA_MAPPING_ERROR;
> > > +}
> > > +
> > > +static int page_chain_map(struct receive_queue *rq, struct page *p)
> > > +{
> > > +       dma_addr_t addr;
> > > +
> > > +       addr =3D virtqueue_dma_map_page_attrs(rq->vq, p, 0, PAGE_SIZE=
, DMA_FROM_DEVICE, 0);
> > > +       if (virtqueue_dma_mapping_error(rq->vq, addr))
> > > +               return -ENOMEM;
> > > +
> > > +       page_dma_addr(p) =3D addr;
> > > +       return 0;
> > > +}
> > > +
> > > +static void page_chain_release(struct receive_queue *rq)
> > > +{
> > > +       struct page *p, *n;
> > > +
> > > +       for (p =3D rq->pages; p; p =3D n) {
> > > +               n =3D page_chain_next(p);
> > > +
> > > +               page_chain_unmap(rq, p);
> > > +               __free_pages(p, 0);
> > > +       }
> > > +
> > > +       rq->pages =3D NULL;
> > > +}
> > > +
> > >  /*
> > >   * put the whole most recent used list in the beginning for reuse
> > >   */
> > > @@ -441,6 +482,13 @@ static void give_pages(struct receive_queue *rq,=
 struct page *page)
> > >  {
> > >         struct page *end;
> > >
> > > +       if (page_dma_addr(page) =3D=3D DMA_MAPPING_ERROR) {
> >
> > This looks strange, the map should be done during allocation. Under
> > which condition could we hit this?
>
> This first page is umapped before we call page_to_skb().
> The page can be put back to the link in case of failure.

See below.

>
>
> >
> > > +               if (page_chain_map(rq, page)) {
> > > +                       __free_pages(page, 0);
> > > +                       return;
> > > +               }
> > > +       }
> > > +
> > >         /* Find end of list, sew whole thing into vi->rq.pages. */
> > >         for (end =3D page; page_chain_next(end); end =3D page_chain_n=
ext(end));
> > >
> > > @@ -456,8 +504,15 @@ static struct page *get_a_page(struct receive_qu=
eue *rq, gfp_t gfp_mask)
> > >                 rq->pages =3D page_chain_next(p);
> > >                 /* clear chain here, it is used to chain pages */
> > >                 page_chain_add(p, NULL);
> > > -       } else
> > > +       } else {
> > >                 p =3D alloc_page(gfp_mask);
> > > +
> > > +               if (page_chain_map(rq, p)) {
> > > +                       __free_pages(p, 0);
> > > +                       return NULL;
> > > +               }
> > > +       }
> > > +
> > >         return p;
> > >  }
> > >
> > > @@ -613,8 +668,6 @@ static struct sk_buff *page_to_skb(struct virtnet=
_info *vi,
> > >                         return NULL;
> > >
> > >                 page =3D page_chain_next(page);
> > > -               if (page)
> > > -                       give_pages(rq, page);
> > >                 goto ok;
> > >         }
> > >
> > > @@ -640,6 +693,7 @@ static struct sk_buff *page_to_skb(struct virtnet=
_info *vi,
> > >                         skb_add_rx_frag(skb, 0, page, offset, len, tr=
uesize);
> > >                 else
> > >                         page_to_free =3D page;
> > > +               page =3D NULL;
> > >                 goto ok;
> > >         }
> > >
> > > @@ -657,6 +711,11 @@ static struct sk_buff *page_to_skb(struct virtne=
t_info *vi,
> > >         BUG_ON(offset >=3D PAGE_SIZE);
> > >         while (len) {
> > >                 unsigned int frag_size =3D min((unsigned)PAGE_SIZE - =
offset, len);
> > > +
> > > +               /* unmap the page before using it. */
> > > +               if (!offset)
> > > +                       page_chain_unmap(rq, page);
> > > +
> >
> > This sounds strange, do we need a virtqueue_sync_for_cpu() helper here?
>
> I think we do not need that. Because the umap api does it.
> We do not work with DMA_SKIP_SYNC;

Well, the problem is unmap is too heavyweight and it reduces the
effort of trying to avoid map/umaps as much as possible.

For example, for most of the case DMA sync is just a nop. And such
unmap() cause strange code in give_pages() as we discuss above?

Thanks

