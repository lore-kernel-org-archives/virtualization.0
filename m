Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02263A55
	for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514355; cv=none; b=UNIZ7YoS88mkptuUhWa4VvFZID2/b1FLDfYMwdXWccSzcATrTOdmMSg/EK5TItpFMjNJ3pGP+oMgvVaf4xkk7Zxg3UqH0gDhx6kYH+u/c8Taktt3/zuyDQcuZXAilllvPQejh/eDC2QYaTj2i2xqCIm9ZB+6UrxVAOhygba3wVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514355; c=relaxed/simple;
	bh=TMX98DwlbkqG8eL+Ay6EOUMn6hOIrXiwnNxfqwQ2raQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnZ6G58qr61nG89SYmnQbRyn4UfZlUDBZntAFmi/Rw7FYRavUIyURM1+Npx+UWwbPqUKOvZP9MFXi/wAg2zUyB0UQNX73a2Pt1SZS2k6NwF+yneYmQK4hKWHTPrFYFWxpMZaeJQe2ndPFEQpjM9TXVVzkjNH0cWajXXEzWymrfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+dSQiOs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+dSQiOs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713514352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3zSfL8fhl7SKwLqQRYVdyG+YLMA384Q0+z85p+oShYg=;
	b=T+dSQiOsa/zo/H4/BcTbT9eRHBil8cixtJqoHTVRXI7Xck2xWtOaLf+kcYLD5/m05Kcg+M
	dE5HF8j1k4lNzfjl6PyEC6PgGyYYKZ31pJ/ZlmOoL68QJVy1Ht0Res2QAHJGVwv4Xmo3vW
	QIwSP5W2NGl3w11chCXlsQpokX28H7g=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-9Zmz52Y7NbWa3LaGNblekw-1; Fri, 19 Apr 2024 04:12:29 -0400
X-MC-Unique: 9Zmz52Y7NbWa3LaGNblekw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1e8f68d0a67so283415ad.0
        for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 01:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514348; x=1714119148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zSfL8fhl7SKwLqQRYVdyG+YLMA384Q0+z85p+oShYg=;
        b=mgE75X3Gqg2LMbjoXegWCwT4WpQtoI2Bu0z+OnsAlHRuF9Yjp4dhu8Z3XZaxzWnzpq
         97WZZ4/tZbBzp+IsPFB6HhC9hSItZgiAV9N6tFoeNxvcE253xxthWAcwqmemIIXuikjJ
         wxzqXKAYWNFUPH3yh4PTqkBaSXg3Pc8j4ka0miFv9R8YPlsx8PVvxIK1v5Grvzcv0T4I
         EOcFsDO7ehVYn8ids/pqQ64/rlz52iJ7ifjcyV3hzPA2mWuKoj0b5RCCcz5FX87mX7il
         wUCaNvHn4qwGSdIU4oElTMUP/2QWowr3oBi5j0FQMMI10QyDmdUxia5BPEud8uvI+Wrw
         tY7g==
X-Gm-Message-State: AOJu0Yw357SwuHO7zEVkVZwA2recwt3H2P6CrLdS32F88sxB+4SF0ewy
	Bk1wC8FPmYfyOTJgcf9XtSeMtFkqgmiT+cEOlm0IhY6R/KTdgp1m5ziQEkA+k4/+Kr4jasvONPH
	tF0nEtu8OBhtAbaMbfZPDnTiljcI/X7HER1lXWJW9wl5LeZsa4DCbgEvBzsJNaKNoji5RiLTPVN
	sv1PfqmcEAnAteYmsdea1GWxW7/J85hzvpAH0cXEY=
X-Received: by 2002:a17:903:244e:b0:1e4:3dd0:8ce0 with SMTP id l14-20020a170903244e00b001e43dd08ce0mr1612142pls.20.1713514348206;
        Fri, 19 Apr 2024 01:12:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx3LFKTktGFsoGuanwAGQcxrd56pbD3Ad3MKDjFQfb+EzsCkYh8uEkYHNVrGqNp6LcmQ05Vi3QdBlqj/IKXsw=
X-Received: by 2002:a17:903:244e:b0:1e4:3dd0:8ce0 with SMTP id
 l14-20020a170903244e00b001e43dd08ce0mr1612125pls.20.1713514347748; Fri, 19
 Apr 2024 01:12:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
 <20240411025127.51945-5-xuanzhuo@linux.alibaba.com> <CACGkMEvhejnVM=x2+PxnKXcyC4W4nAbhkt4-reWb-7=fYQ6qKw@mail.gmail.com>
 <1713428960.80807-1-xuanzhuo@linux.alibaba.com> <CACGkMEvDQ1Zs3Ya0TR1O8SANDEmBQ-+_2iFt7dpBDeE=i+PExQ@mail.gmail.com>
 <1713500472.3614385-1-xuanzhuo@linux.alibaba.com> <CACGkMEsDB+tMFEvRtyDAz83dkd9fpuh51u=KyUZkgh+gizmK7g@mail.gmail.com>
 <1713510204.1357317-1-xuanzhuo@linux.alibaba.com> <CACGkMEvconuYjrg1Oi6mgLAWCw5Pq=i_CrivnzTJ+ONavV8Rzw@mail.gmail.com>
 <1713511597.5359378-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1713511597.5359378-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Apr 2024 16:12:15 +0800
Message-ID: <CACGkMEu-SXDrnUX2jcVepxOo-QYo7QhwDRs-4_Rrc3Pf1K1Q6g@mail.gmail.com>
Subject: Re: [PATCH vhost 4/6] virtio_net: big mode support premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 3:28=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Fri, 19 Apr 2024 15:24:25 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Fri, Apr 19, 2024 at 3:07=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Fri, 19 Apr 2024 13:46:25 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Fri, Apr 19, 2024 at 12:23=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.=
alibaba.com> wrote:
> > > > >
> > > > > On Fri, 19 Apr 2024 08:43:43 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Thu, Apr 18, 2024 at 4:35=E2=80=AFPM Xuan Zhuo <xuanzhuo@lin=
ux.alibaba.com> wrote:
> > > > > > >
> > > > > > > On Thu, 18 Apr 2024 14:25:06 +0800, Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > > > > On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhu=
o@linux.alibaba.com> wrote:
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
> > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/net/virtio_net.c | 98 ++++++++++++++++++++++++++=
+++++++-------
> > > > > > > > >  1 file changed, 81 insertions(+), 17 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virti=
o_net.c
> > > > > > > > > index 4446fb54de6d..7ea7e9bcd5d7 100644
> > > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > > @@ -50,6 +50,7 @@ module_param(napi_tx, bool, 0644);
> > > > > > > > >
> > > > > > > > >  #define page_chain_next(p)     ((struct page *)((p)->pp)=
)
> > > > > > > > >  #define page_chain_add(p, n)   ((p)->pp =3D (void *)n)
> > > > > > > > > +#define page_dma_addr(p)       ((p)->dma_addr)
> > > > > > > > >
> > > > > > > > >  /* RX packet size EWMA. The average packet size is used =
to determine the packet
> > > > > > > > >   * buffer size when refilling RX rings. As the entire RX=
 ring may be refilled
> > > > > > > > > @@ -434,6 +435,46 @@ skb_vnet_common_hdr(struct sk_buff *=
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
> > > > > > > > > +static void page_chain_unmap(struct receive_queue *rq, s=
truct page *p)
> > > > > > > > > +{
> > > > > > > > > +       virtqueue_dma_unmap_page_attrs(rq->vq, page_dma_a=
ddr(p), PAGE_SIZE,
> > > > > > > > > +                                      DMA_FROM_DEVICE, 0=
);
> > > > > > > > > +
> > > > > > > > > +       page_dma_addr(p) =3D DMA_MAPPING_ERROR;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static int page_chain_map(struct receive_queue *rq, stru=
ct page *p)
> > > > > > > > > +{
> > > > > > > > > +       dma_addr_t addr;
> > > > > > > > > +
> > > > > > > > > +       addr =3D virtqueue_dma_map_page_attrs(rq->vq, p, =
0, PAGE_SIZE, DMA_FROM_DEVICE, 0);
> > > > > > > > > +       if (virtqueue_dma_mapping_error(rq->vq, addr))
> > > > > > > > > +               return -ENOMEM;
> > > > > > > > > +
> > > > > > > > > +       page_dma_addr(p) =3D addr;
> > > > > > > > > +       return 0;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static void page_chain_release(struct receive_queue *rq)
> > > > > > > > > +{
> > > > > > > > > +       struct page *p, *n;
> > > > > > > > > +
> > > > > > > > > +       for (p =3D rq->pages; p; p =3D n) {
> > > > > > > > > +               n =3D page_chain_next(p);
> > > > > > > > > +
> > > > > > > > > +               page_chain_unmap(rq, p);
> > > > > > > > > +               __free_pages(p, 0);
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > > +       rq->pages =3D NULL;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  /*
> > > > > > > > >   * put the whole most recent used list in the beginning =
for reuse
> > > > > > > > >   */
> > > > > > > > > @@ -441,6 +482,13 @@ static void give_pages(struct receiv=
e_queue *rq, struct page *page)
> > > > > > > > >  {
> > > > > > > > >         struct page *end;
> > > > > > > > >
> > > > > > > > > +       if (page_dma_addr(page) =3D=3D DMA_MAPPING_ERROR)=
 {
> > > > > > > >
> > > > > > > > This looks strange, the map should be done during allocatio=
n. Under
> > > > > > > > which condition could we hit this?
> > > > > > >
> > > > > > > This first page is umapped before we call page_to_skb().
> > > > > > > The page can be put back to the link in case of failure.
> > > > > >
> > > > > > See below.
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > > +               if (page_chain_map(rq, page)) {
> > > > > > > > > +                       __free_pages(page, 0);
> > > > > > > > > +                       return;
> > > > > > > > > +               }
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > >         /* Find end of list, sew whole thing into vi->rq.=
pages. */
> > > > > > > > >         for (end =3D page; page_chain_next(end); end =3D =
page_chain_next(end));
> > > > > > > > >
> > > > > > > > > @@ -456,8 +504,15 @@ static struct page *get_a_page(struc=
t receive_queue *rq, gfp_t gfp_mask)
> > > > > > > > >                 rq->pages =3D page_chain_next(p);
> > > > > > > > >                 /* clear chain here, it is used to chain =
pages */
> > > > > > > > >                 page_chain_add(p, NULL);
> > > > > > > > > -       } else
> > > > > > > > > +       } else {
> > > > > > > > >                 p =3D alloc_page(gfp_mask);
> > > > > > > > > +
> > > > > > > > > +               if (page_chain_map(rq, p)) {
> > > > > > > > > +                       __free_pages(p, 0);
> > > > > > > > > +                       return NULL;
> > > > > > > > > +               }
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > >         return p;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > @@ -613,8 +668,6 @@ static struct sk_buff *page_to_skb(st=
ruct virtnet_info *vi,
> > > > > > > > >                         return NULL;
> > > > > > > > >
> > > > > > > > >                 page =3D page_chain_next(page);
> > > > > > > > > -               if (page)
> > > > > > > > > -                       give_pages(rq, page);
> > > > > > > > >                 goto ok;
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > > @@ -640,6 +693,7 @@ static struct sk_buff *page_to_skb(st=
ruct virtnet_info *vi,
> > > > > > > > >                         skb_add_rx_frag(skb, 0, page, off=
set, len, truesize);
> > > > > > > > >                 else
> > > > > > > > >                         page_to_free =3D page;
> > > > > > > > > +               page =3D NULL;
> > > > > > > > >                 goto ok;
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > > @@ -657,6 +711,11 @@ static struct sk_buff *page_to_skb(s=
truct virtnet_info *vi,
> > > > > > > > >         BUG_ON(offset >=3D PAGE_SIZE);
> > > > > > > > >         while (len) {
> > > > > > > > >                 unsigned int frag_size =3D min((unsigned)=
PAGE_SIZE - offset, len);
> > > > > > > > > +
> > > > > > > > > +               /* unmap the page before using it. */
> > > > > > > > > +               if (!offset)
> > > > > > > > > +                       page_chain_unmap(rq, page);
> > > > > > > > > +
> > > > > > > >
> > > > > > > > This sounds strange, do we need a virtqueue_sync_for_cpu() =
helper here?
> > > > > > >
> > > > > > > I think we do not need that. Because the umap api does it.
> > > > > > > We do not work with DMA_SKIP_SYNC;
> > > > > >
> > > > > > Well, the problem is unmap is too heavyweight and it reduces th=
e
> > > > > > effort of trying to avoid map/umaps as much as possible.
> > > > > >
> > > > > > For example, for most of the case DMA sync is just a nop. And s=
uch
> > > > > > unmap() cause strange code in give_pages() as we discuss above?
> > > > >
> > > > > YES. You are right. For the first page, we just need to sync for =
cpu.
> > > > > And we do not need to check the dma status.
> > > > > But here (in page_to_skb), we need to call unmap, because this pa=
ge is put
> > > > > to the skb.
> > > >
> > > > Right, but issue still,
> > > >
> > > > The only case that we may hit
> > > >
> > > >         if (page_dma_addr(page) =3D=3D DMA_MAPPING_ERROR)
> > > >
> > > > is when the packet is smaller than GOOD_COPY_LEN.
> > > >
> > > > So if we sync_for_cpu for the head page, we don't do:
> > > >
> > > > 1) unmap in the receive_big()
> > > > 2) do snyc_for_cpu() just before skb_put_data(), so the page could =
be
> > > > recycled to the pool without unmapping?
> > >
> > >
> > > I do not get.
> >
> > I meant something like e1000_copybreak().
> >
> > >
> > > I think we can remove the code "if (page_dma_addr(page) =3D=3D DMA_MA=
PPING_ERROR)"
> > > from give_pages(). We just do unmap when the page is leaving virtio-n=
et.
> >
> > That's the point.
> >
> > >
> > > >
> > > > And I think we should do something similar for the mergeable case?
> > >
> > > Do what?
> > >
> > > We have used the sync api for mergeable case.
> >
> > Where?
> >
> > I see virtnet_rq_get_buf which did sync but it is done after the page_t=
o_skb().
>
> What means "done"?
>
> Do you want to reuse the buffer?

Nope, I think I misread the code. Mergeable buffers should be fine as
the unmap were during virtnet_receive().

But the code might needs some tweak in the future

in virtnet_receive() we had:

if (!vi->big_packets || vi->mergeable_rx_bufs) {
        virtnet_rq_get_buf
        receive_buf()
} else {
        virtqueue_get_buf()
}

but there's another switch in receive_buf():

if (vi->mergeable_rx_bufs)
else if (vi->big_packets)
else
...

Which is kind of a mess somehow.

Thanks
>
> Thanks.
>
> >
> > >
> > >
> > > >
> > > > Btw, I found one the misleading comment introduced by f80bd740cb7c9
> > > >
> > > >         /* copy small packet so we can reuse these pages */
> > > >         if (!NET_IP_ALIGN && len > GOOD_COPY_LEN && tailroom >=3D s=
hinfo_size) {
> > > >
> > > > We're not copying but building skb around the head page.
> > >
> > > Will fix.
> > >
> > > Thanks.
> >
> > Thanks
> >
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > Thanks.
> > > > >
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > >
> > > >
> > >
> >
>

