Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940028F62
	for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 05:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713505603; cv=none; b=Cq6H/g8p/fAVMF7FLwSqDmn6laUE3YcndqJ5LOkn9WnCl+cKR+UDCsHALRpYg9fU0n06Jr8AUDcMvNlKMCuP+h9W3xrJnp8r1dgoFj5mZ1VIHe5qoPLlrEOyy7ah2Ys3pPdMrVrSpfsuCGO7M7WHjUmE2KWP3mVB3PxCWpbuQKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713505603; c=relaxed/simple;
	bh=3/4Om9XArS/GDgc6J3/7qGIMp+gqqVJhE716DUK3MIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIxV8qYuaiJ/MmgFZjDXRo7FXAqqerPvDI11kq0oxt6yjTjhwHPVRPP9Wfatohmci2YQjizCAJSKBgrDSBO34BK/Un5fW8a1kEhfjnofaRBr8/5xHwHuPlSQQXfCOJCjTfFxamemz0GtuzetdJVpc4ky3LOk/O2W+CmmLxwaLG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MuJsHtyG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuJsHtyG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713505600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xO5OkCkwVfVKhznHFvYo//+nXymux3RbsEsLQzsDhTY=;
	b=MuJsHtyGpouFksnbzUNejmqFHJoBYGIGH83NveFZ0HVlfHDRL4EB1yM59hVjr0wu3iOTQn
	EINekiuhaj65l0VgYI44SMzV23R7YHFLLW4OvjpnOtG878GD2vXCwkxV9ETEtOqOVxbqt/
	5AuO+KzunqP1Rp0zd6QaFw7bVvp87do=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-PGgMXrnaN3iczmPkK9PbHA-1; Fri, 19 Apr 2024 01:46:38 -0400
X-MC-Unique: PGgMXrnaN3iczmPkK9PbHA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5dbddee3694so1213327a12.1
        for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 22:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713505597; x=1714110397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xO5OkCkwVfVKhznHFvYo//+nXymux3RbsEsLQzsDhTY=;
        b=JoKE0kZv56csQ2/90cqa6BHbGm26URWMeItgDGHyAXllre3A4wv8Yv0Uy9RfYQC5PX
         CclomOY50BJ3Tw5QQ/HeyVOItYgk2JVtugsxn3uuRUrQQRYPOk3ur/itoHaxMcg1qWhl
         +jn6KplYZIVHOm1kPlfbknkjJrVue44Aq9KjgUE69kVaHu9hp3YnVfQRa5+ZiNRhRMCF
         kyZKd0G6NoFiZf8CGJ3qEOXt6ZdQKZcB/6onLBLibyI3aNxgnTJ0E8YpCaKUToPLFrGo
         qF3It6qviY/64Kl7edAKjZtz1MrRq7yhAyGu2ahfIpNUw7Yw6O6Qu5Ht9qXUoC8bOD2f
         L5ig==
X-Gm-Message-State: AOJu0YzTgIjte8shHTd6EfaAd1vslnvNIRbunk3tmrGWc7UsNW1OYegG
	1nKGFhMpZlslUlNNsFuTA7BYFLERP+Wkm8/Ri6Zi3JEczZ+5F5AfvWw6MjJ4bfFu6ri1HrEnBFF
	yTZ5W17MwHbwOPA1M65XlZcr6PFUOj5KhiwJ2AWA/RH1yBbXylvbt3eBlzypjnZSMY+QtgptvcM
	IlrR7oIyhjmbOJRfNXPGi7BCk5/hGuAN8vYO3+X/4=
X-Received: by 2002:a17:902:eac4:b0:1e4:733c:eac8 with SMTP id p4-20020a170902eac400b001e4733ceac8mr1564865pld.8.1713505597579;
        Thu, 18 Apr 2024 22:46:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwFe19+RxU43RLScHY24LofgUdMQlkqsgimSTrwOI2sZGtTylbmMZL5BgEQ7w2OqGymSIoGarWayL68GsSCG4=
X-Received: by 2002:a17:902:eac4:b0:1e4:733c:eac8 with SMTP id
 p4-20020a170902eac400b001e4733ceac8mr1564849pld.8.1713505597239; Thu, 18 Apr
 2024 22:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
 <20240411025127.51945-5-xuanzhuo@linux.alibaba.com> <CACGkMEvhejnVM=x2+PxnKXcyC4W4nAbhkt4-reWb-7=fYQ6qKw@mail.gmail.com>
 <1713428960.80807-1-xuanzhuo@linux.alibaba.com> <CACGkMEvDQ1Zs3Ya0TR1O8SANDEmBQ-+_2iFt7dpBDeE=i+PExQ@mail.gmail.com>
 <1713500472.3614385-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1713500472.3614385-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Apr 2024 13:46:25 +0800
Message-ID: <CACGkMEsDB+tMFEvRtyDAz83dkd9fpuh51u=KyUZkgh+gizmK7g@mail.gmail.com>
Subject: Re: [PATCH vhost 4/6] virtio_net: big mode support premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 12:23=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Fri, 19 Apr 2024 08:43:43 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Apr 18, 2024 at 4:35=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Thu, 18 Apr 2024 14:25:06 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.=
alibaba.com> wrote:
> > > > >
> > > > > In big mode, pre-mapping DMA is beneficial because if the pages a=
re not
> > > > > used, we can reuse them without needing to unmap and remap.
> > > > >
> > > > > We require space to store the DMA address. I use the page.dma_add=
r to
> > > > > store the DMA address from the pp structure inside the page.
> > > > >
> > > > > Every page retrieved from get_a_page() is mapped, and its DMA add=
ress is
> > > > > stored in page.dma_addr. When a page is returned to the chain, we=
 check
> > > > > the DMA status; if it is not mapped (potentially having been unma=
pped),
> > > > > we remap it before returning it to the chain.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 98 +++++++++++++++++++++++++++++++++-=
------
> > > > >  1 file changed, 81 insertions(+), 17 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 4446fb54de6d..7ea7e9bcd5d7 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -50,6 +50,7 @@ module_param(napi_tx, bool, 0644);
> > > > >
> > > > >  #define page_chain_next(p)     ((struct page *)((p)->pp))
> > > > >  #define page_chain_add(p, n)   ((p)->pp =3D (void *)n)
> > > > > +#define page_dma_addr(p)       ((p)->dma_addr)
> > > > >
> > > > >  /* RX packet size EWMA. The average packet size is used to deter=
mine the packet
> > > > >   * buffer size when refilling RX rings. As the entire RX ring ma=
y be refilled
> > > > > @@ -434,6 +435,46 @@ skb_vnet_common_hdr(struct sk_buff *skb)
> > > > >         return (struct virtio_net_common_hdr *)skb->cb;
> > > > >  }
> > > > >
> > > > > +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr,=
 u32 len)
> > > > > +{
> > > > > +       sg->dma_address =3D addr;
> > > > > +       sg->length =3D len;
> > > > > +}
> > > > > +
> > > > > +static void page_chain_unmap(struct receive_queue *rq, struct pa=
ge *p)
> > > > > +{
> > > > > +       virtqueue_dma_unmap_page_attrs(rq->vq, page_dma_addr(p), =
PAGE_SIZE,
> > > > > +                                      DMA_FROM_DEVICE, 0);
> > > > > +
> > > > > +       page_dma_addr(p) =3D DMA_MAPPING_ERROR;
> > > > > +}
> > > > > +
> > > > > +static int page_chain_map(struct receive_queue *rq, struct page =
*p)
> > > > > +{
> > > > > +       dma_addr_t addr;
> > > > > +
> > > > > +       addr =3D virtqueue_dma_map_page_attrs(rq->vq, p, 0, PAGE_=
SIZE, DMA_FROM_DEVICE, 0);
> > > > > +       if (virtqueue_dma_mapping_error(rq->vq, addr))
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       page_dma_addr(p) =3D addr;
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static void page_chain_release(struct receive_queue *rq)
> > > > > +{
> > > > > +       struct page *p, *n;
> > > > > +
> > > > > +       for (p =3D rq->pages; p; p =3D n) {
> > > > > +               n =3D page_chain_next(p);
> > > > > +
> > > > > +               page_chain_unmap(rq, p);
> > > > > +               __free_pages(p, 0);
> > > > > +       }
> > > > > +
> > > > > +       rq->pages =3D NULL;
> > > > > +}
> > > > > +
> > > > >  /*
> > > > >   * put the whole most recent used list in the beginning for reus=
e
> > > > >   */
> > > > > @@ -441,6 +482,13 @@ static void give_pages(struct receive_queue =
*rq, struct page *page)
> > > > >  {
> > > > >         struct page *end;
> > > > >
> > > > > +       if (page_dma_addr(page) =3D=3D DMA_MAPPING_ERROR) {
> > > >
> > > > This looks strange, the map should be done during allocation. Under
> > > > which condition could we hit this?
> > >
> > > This first page is umapped before we call page_to_skb().
> > > The page can be put back to the link in case of failure.
> >
> > See below.
> >
> > >
> > >
> > > >
> > > > > +               if (page_chain_map(rq, page)) {
> > > > > +                       __free_pages(page, 0);
> > > > > +                       return;
> > > > > +               }
> > > > > +       }
> > > > > +
> > > > >         /* Find end of list, sew whole thing into vi->rq.pages. *=
/
> > > > >         for (end =3D page; page_chain_next(end); end =3D page_cha=
in_next(end));
> > > > >
> > > > > @@ -456,8 +504,15 @@ static struct page *get_a_page(struct receiv=
e_queue *rq, gfp_t gfp_mask)
> > > > >                 rq->pages =3D page_chain_next(p);
> > > > >                 /* clear chain here, it is used to chain pages */
> > > > >                 page_chain_add(p, NULL);
> > > > > -       } else
> > > > > +       } else {
> > > > >                 p =3D alloc_page(gfp_mask);
> > > > > +
> > > > > +               if (page_chain_map(rq, p)) {
> > > > > +                       __free_pages(p, 0);
> > > > > +                       return NULL;
> > > > > +               }
> > > > > +       }
> > > > > +
> > > > >         return p;
> > > > >  }
> > > > >
> > > > > @@ -613,8 +668,6 @@ static struct sk_buff *page_to_skb(struct vir=
tnet_info *vi,
> > > > >                         return NULL;
> > > > >
> > > > >                 page =3D page_chain_next(page);
> > > > > -               if (page)
> > > > > -                       give_pages(rq, page);
> > > > >                 goto ok;
> > > > >         }
> > > > >
> > > > > @@ -640,6 +693,7 @@ static struct sk_buff *page_to_skb(struct vir=
tnet_info *vi,
> > > > >                         skb_add_rx_frag(skb, 0, page, offset, len=
, truesize);
> > > > >                 else
> > > > >                         page_to_free =3D page;
> > > > > +               page =3D NULL;
> > > > >                 goto ok;
> > > > >         }
> > > > >
> > > > > @@ -657,6 +711,11 @@ static struct sk_buff *page_to_skb(struct vi=
rtnet_info *vi,
> > > > >         BUG_ON(offset >=3D PAGE_SIZE);
> > > > >         while (len) {
> > > > >                 unsigned int frag_size =3D min((unsigned)PAGE_SIZ=
E - offset, len);
> > > > > +
> > > > > +               /* unmap the page before using it. */
> > > > > +               if (!offset)
> > > > > +                       page_chain_unmap(rq, page);
> > > > > +
> > > >
> > > > This sounds strange, do we need a virtqueue_sync_for_cpu() helper h=
ere?
> > >
> > > I think we do not need that. Because the umap api does it.
> > > We do not work with DMA_SKIP_SYNC;
> >
> > Well, the problem is unmap is too heavyweight and it reduces the
> > effort of trying to avoid map/umaps as much as possible.
> >
> > For example, for most of the case DMA sync is just a nop. And such
> > unmap() cause strange code in give_pages() as we discuss above?
>
> YES. You are right. For the first page, we just need to sync for cpu.
> And we do not need to check the dma status.
> But here (in page_to_skb), we need to call unmap, because this page is pu=
t
> to the skb.

Right, but issue still,

The only case that we may hit

        if (page_dma_addr(page) =3D=3D DMA_MAPPING_ERROR)

is when the packet is smaller than GOOD_COPY_LEN.

So if we sync_for_cpu for the head page, we don't do:

1) unmap in the receive_big()
2) do snyc_for_cpu() just before skb_put_data(), so the page could be
recycled to the pool without unmapping?

And I think we should do something similar for the mergeable case?

Btw, I found one the misleading comment introduced by f80bd740cb7c9

        /* copy small packet so we can reuse these pages */
        if (!NET_IP_ALIGN && len > GOOD_COPY_LEN && tailroom >=3D shinfo_si=
ze) {

We're not copying but building skb around the head page.

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
>

