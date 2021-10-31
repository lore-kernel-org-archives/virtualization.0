Return-Path: <SRS0=Mk6X=PT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385E9C433EF
	for <virtualization@archiver.kernel.org>; Sun, 31 Oct 2021 14:47:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1F060E9B
	for <virtualization@archiver.kernel.org>; Sun, 31 Oct 2021 14:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA1F060E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 88F07401F0;
	Sun, 31 Oct 2021 14:47:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mc0Bfo3VntpH; Sun, 31 Oct 2021 14:47:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 90B1540182;
	Sun, 31 Oct 2021 14:47:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 651C0C0012;
	Sun, 31 Oct 2021 14:47:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86E20C000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 14:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8221A4018E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 14:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cbErH2WClSWQ
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 14:47:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 39FCE40183
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 14:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635691661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+aTdpPdt+qZTV2K6qn3P6EMiUdaOOm0O4jEIWwm0LEA=;
 b=QizHSPNAPKPjbWvcwUHZcy6G4yJ+QRWDc6JZ2QQyskE/viMF5Tn6WQp0ljdBadFMyiCInI
 M3U5TS5A3k0M6Jlb3glW3AM0Zgug2M84F4XcmO126MNwKqCvwz+CsagLf3qIoy6tre66Fa
 y08EyKaThqS0FlXHVFKXaqSSwHdlHFo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-7GZuREV3M8ClUaJTJEsZbQ-1; Sun, 31 Oct 2021 10:47:39 -0400
X-MC-Unique: 7GZuREV3M8ClUaJTJEsZbQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 q5-20020a5d5745000000b00178abb72486so3301229wrw.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 07:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+aTdpPdt+qZTV2K6qn3P6EMiUdaOOm0O4jEIWwm0LEA=;
 b=Bgn+NQW+H/rbwG1yYKRQEgb99LFQ9m5lXQc3W4gxfbobLVy5x5k91WOsEztuwVB7HH
 OtsW+TtxHy5L7Y54tCyomRKLAbXquNj2woMOedVEBa8bp05HyZaYL5tQ4/v7oYg9wqqC
 tw6B7wLz06IiqjFapbOjQbsTaLxxTyoeKT7ZgOrhXO0u49yuNVHFdHiHwgaYjBOClUPM
 apueGpQeX3slzsDZSQLoFZesvlYzif9h3cavSSdI2MR15pwo6fTXQN44gckCUzDlUe1N
 6rrBuwcgIz4Ui8ulqBUZLYViGEXpHBJVFpXCqxau5mHWw+c7SjUvB0XKaF1NK0uKkEVz
 jmvw==
X-Gm-Message-State: AOAM530jWb9+xLUafo/P0pCKGYaTABO0C4lybcPr2e6ggC9RGf7kt5Ku
 XVcJ+edr24NKpJBJcU5LMQC0fg9l02v2AVdbem2mKDOitCgv+aikx3etLmMOwn60he+8Np9aWuQ
 Apu5L/WFSk7lMDLMW5u+z3avE/bcBZeJ7FRbCRFxi9w==
X-Received: by 2002:a05:6000:1449:: with SMTP id
 v9mr30725269wrx.433.1635691658635; 
 Sun, 31 Oct 2021 07:47:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCdYhrCMgEA3FxNjT1vRIEDtuD9fGTQ6F9UBBTnt0VWzkNiycCuVboJgIgZTe0mpPwyjMrAw==
X-Received: by 2002:a05:6000:1449:: with SMTP id
 v9mr30725248wrx.433.1635691658451; 
 Sun, 31 Oct 2021 07:47:38 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:207e:6500:1024:cbd2:401c:e583])
 by smtp.gmail.com with ESMTPSA id g2sm10905799wrq.62.2021.10.31.07.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Oct 2021 07:47:37 -0700 (PDT)
Date: Sun, 31 Oct 2021 10:47:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/3] virtio: cache indirect desc for split
Message-ID: <20211031104700-mutt-send-email-mst@kernel.org>
References: <CACGkMEssaFCNgmRL4b5P5Dpm3WBhpQX37t-_j9Bc6wndTh4UHw@mail.gmail.com>
 <1635401763.7680635-3-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1635401763.7680635-3-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Oct 28, 2021 at 02:16:03PM +0800, Xuan Zhuo wrote:
> On Thu, 28 Oct 2021 10:16:10 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Thu, Oct 28, 2021 at 1:07 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Wed, Oct 27, 2021 at 02:19:11PM +0800, Xuan Zhuo wrote:
> > > > In the case of using indirect, indirect desc must be allocated and
> > > > released each time, which increases a lot of cpu overhead.
> > > >
> > > > Here, a cache is added for indirect. If the number of indirect desc to be
> > > > applied for is less than VIRT_QUEUE_CACHE_DESC_NUM, the desc array with
> > > > the size of VIRT_QUEUE_CACHE_DESC_NUM is fixed and cached for reuse.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/virtio/virtio.c      |  6 ++++
> > > >  drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++++++++++++------
> > > >  include/linux/virtio.h       | 10 ++++++
> > > >  3 files changed, 70 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > index 0a5b54034d4b..04bcb74e5b9a 100644
> > > > --- a/drivers/virtio/virtio.c
> > > > +++ b/drivers/virtio/virtio.c
> > > > @@ -431,6 +431,12 @@ bool is_virtio_device(struct device *dev)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(is_virtio_device);
> > > >
> > > > +void virtio_use_desc_cache(struct virtio_device *dev, bool val)
> > > > +{
> > > > +     dev->desc_cache = val;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(virtio_use_desc_cache);
> > > > +
> > > >  void unregister_virtio_device(struct virtio_device *dev)
> > > >  {
> > > >       int index = dev->index; /* save for after device release */
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > index dd95dfd85e98..0b9a8544b0e8 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -117,6 +117,10 @@ struct vring_virtqueue {
> > > >       /* Hint for event idx: already triggered no need to disable. */
> > > >       bool event_triggered;
> > > >
> > > > +     /* Is indirect cache used? */
> > > > +     bool use_desc_cache;
> > > > +     void *desc_cache_chain;
> > > > +
> > > >       union {
> > > >               /* Available for split ring */
> > > >               struct {
> > > > @@ -423,12 +427,47 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
> > > >       return extra[i].next;
> > > >  }
> > > >
> > > > -static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
> > > > +#define VIRT_QUEUE_CACHE_DESC_NUM 4
> > > > +
> > > > +static void desc_cache_chain_free_split(void *chain)
> > > > +{
> > > > +     struct vring_desc *desc;
> > > > +
> > > > +     while (chain) {
> > > > +             desc = chain;
> > > > +             chain = (void *)desc->addr;
> > > > +             kfree(desc);
> > > > +     }
> > > > +}
> > > > +
> > > > +static void desc_cache_put_split(struct vring_virtqueue *vq,
> > > > +                              struct vring_desc *desc, int n)
> > > > +{
> > > > +     if (vq->use_desc_cache && n <= VIRT_QUEUE_CACHE_DESC_NUM) {
> > > > +             desc->addr = (u64)vq->desc_cache_chain;
> > > > +             vq->desc_cache_chain = desc;
> > > > +     } else {
> > > > +             kfree(desc);
> > > > +     }
> > > > +}
> > > > +
> > >
> > >
> > > So I have a question here. What happens if we just do:
> > >
> > > if (n <= VIRT_QUEUE_CACHE_DESC_NUM) {
> > >         return kmem_cache_alloc(VIRT_QUEUE_CACHE_DESC_NUM * sizeof desc, gfp)
> > > } else {
> > >         return kmalloc_arrat(n, sizeof desc, gfp)
> > > }
> > >
> > > A small change and won't we reap most performance benefits?
> >
> > Yes, I think we need a benchmark to use private cache to see how much
> > it can help.
> 
> I did a test, the code is as follows:
> 
> +static void desc_cache_put_packed(struct vring_virtqueue *vq,
> +                                  struct vring_packed_desc *desc, int n)
> + {
> +       if (n <= VIRT_QUEUE_CACHE_DESC_NUM) {
> +               kmem_cache_free(vq->desc_cache, desc);
> +       } else {
> +               kfree(desc);
> +       }
> 
> 
> @@ -476,11 +452,14 @@ static struct vring_desc *alloc_indirect_split(struct vring_virtqueue *vq,
>          */
>         gfp &= ~__GFP_HIGHMEM;
> 
> -       desc = kmalloc_array(n, sizeof(struct vring_desc), gfp);
> +       if (total_sg <= VIRT_QUEUE_CACHE_DESC_NUM)
> +               desc = kmem_cache_alloc(vq->desc_cache, gfp);
> +       else
> +               desc = kmalloc_array(total_sg, sizeof(struct vring_desc), gfp);
> +
> 
> 	.......
> 
> +       vq->desc_cache = kmem_cache_create("virio_desc",
> +                                          4 * sizeof(struct vring_desc),
> +                                          0, 0, NULL);
> 
> The effect is not good, basically there is no improvement, using perf top can
> see that the overhead of kmem_cache_alloc/kmem_cache_free is also relatively
> large:
> 
>          26.91%  [kernel]  [k] virtqueue_add
>          15.35%  [kernel]  [k] detach_buf_split
>          14.15%  [kernel]  [k] virtnet_xsk_xmit
>          13.24%  [kernel]  [k] virtqueue_add_outbuf
>        >  9.30%  [kernel]  [k] __slab_free
>        >  3.91%  [kernel]  [k] kmem_cache_alloc
>           2.85%  [kernel]  [k] virtqueue_get_buf_ctx
>        >  2.82%  [kernel]  [k] kmem_cache_free
>           2.54%  [kernel]  [k] memset_erms
>           2.37%  [kernel]  [k] xsk_tx_peek_desc
>           1.20%  [kernel]  [k] virtnet_xsk_run
>           0.81%  [kernel]  [k] vring_map_one_sg
>           0.69%  [kernel]  [k] __free_old_xmit_ptr
>           0.69%  [kernel]  [k] virtqueue_kick_prepare
>           0.43%  [kernel]  [k] sg_init_table
>           0.41%  [kernel]  [k] sg_next
>           0.28%  [kernel]  [k] vring_unmap_one_split
>           0.25%  [kernel]  [k] vring_map_single.constprop.34
>           0.24%  [kernel]  [k] net_rx_action
> 
> Thanks.


How about batching these?  E.g. kmem_cache_alloc_bulk/kmem_cache_free_bulk?


> >
> > Thanks
> >
> > >
> > > --
> > > MST
> > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
