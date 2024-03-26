Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F23B13048E
	for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711438374; cv=none; b=kBJHTMHfF2wx6Etiz1Wdxkx16CKk567cZarZs3CaGCMTdbzfd4iJotdY4wgFmCw8B6NOdm4HZuLq6a4T4Kxfj842GGiL1e6UDxtNy+ojvIw2GrNzDmejPWz8ZfpAGc5X33YVgU4PYnan+rKXBadCR+mQ6P4DZG2CNiy5Inrz2dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711438374; c=relaxed/simple;
	bh=QZY1zpBKJTgKeMl7yHZrKr0DI88L9kHK0I41SbbfbiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SgRG6/5EN/PfMz30IW0uF6tYyR7ncn+pxK4POIt3vUKTXWsNDIY9oZYhSounHSBH+aapic5nPAbibFSUqDZFzIS28/CKVJBUbMwsuKxh8pKOOsRMepBHPSS/hiv4mOofWvuwUTq4Rb75iwqeQer79cT5tBODT2Qkcgjjjhl/I9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iNs8RwXx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNs8RwXx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711438371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ngtvy3dvqyLM6AWq5NHSfQeWKdAHG67CLuN1yByvAj8=;
	b=iNs8RwXxlHXMcWZxwl7X4RbYzw0tDMI8UrtaGp+ttyUOsmfHbMvHVjKak/8cRn/MuFkawM
	58YIcBWkVdiHUb9ts+WVLl/IevOlEqAUmdD6liK82iIBCdOWAsN/Ig8uL1GhaAKFgLmJTu
	5bOEO0fWJgY3ORDCSkFrnJvLSVbwGgI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-FNEKsw1qPi2U-GrFFFeAoA-1; Tue, 26 Mar 2024 03:32:49 -0400
X-MC-Unique: FNEKsw1qPi2U-GrFFFeAoA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41489176bd5so8929675e9.0
        for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 00:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711438368; x=1712043168;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ngtvy3dvqyLM6AWq5NHSfQeWKdAHG67CLuN1yByvAj8=;
        b=Il8lA40UIY6m0q7uc+h9R7DCG05iQ+oqdHTxx4LNePTrFPtwfkM+8Mj7z+tkKKRt57
         E3faE48tfyltWyFP3CfbFZ0wLc2KHfuFg50ddrog9L9SerAdqGWBc008WoLt8+qbjQfg
         1l/HNTvvdVIR5TStOCCTNQsd4lv9IWcZ5/P9114CvcStE140bN93tWCAqZvyqYKeLuGP
         DLgroYtFPH2zqNryAm1N7iYXRLl38hmsnEnyU3tGa2BG4zcnYqyV9lTbsV9wHFTHUU4+
         wlGQfzAc7S8Dv9N0kp9JjrIt2rD8qHeCRJ+evldoe3h8wHJD2NJcyunVMrDxTtA2VYAW
         tTMw==
X-Forwarded-Encrypted: i=1; AJvYcCUw3bkMaUGzE1RXOyjxMoABKEQIlbgPwVQuNSk4c+FOUvlsMcr5eWdImL7pdfhgJZkLmKh1ozvqNfPPin/uLGSpfou+cnJXr5UmNmmMEtY=
X-Gm-Message-State: AOJu0YwhUyJfR7wXDdi7+v8Eumbtu9+yPTGm7bsBSSS5LLcCvW8XoYsR
	KAU3g8tTnjEEEj1Tp1Rempzh/A3qq1FiGDGqWzY25MymmslddIwueDihHcQBn4NWIcprD2iMqQ+
	yPwMSyOA9b6Z2V1mhmlLNVylibCh615pu/09TFjHys2CLs273RJeaINPTsZdACitQ
X-Received: by 2002:a05:600c:5249:b0:414:1fc:1081 with SMTP id fc9-20020a05600c524900b0041401fc1081mr1134404wmb.36.1711438368187;
        Tue, 26 Mar 2024 00:32:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH6ByjBb9paVWMRwHR22n3GwKEgtxE156r/yuCSuhMyYRp7iX79OKWNQm74inTE0skT9WrGg==
X-Received: by 2002:a05:600c:5249:b0:414:1fc:1081 with SMTP id fc9-20020a05600c524900b0041401fc1081mr1134381wmb.36.1711438367536;
        Tue, 26 Mar 2024 00:32:47 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e8:4f00:4a9d:49ee:c7ac:ea36])
        by smtp.gmail.com with ESMTPSA id cl1-20020a5d5f01000000b00341b9737fc5sm10439980wrb.96.2024.03.26.00.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 00:32:46 -0700 (PDT)
Date: Tue, 26 Mar 2024 03:32:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH vhost v4 02/10] virtio_ring: packed: remove double check
 of the unmap ops
Message-ID: <20240326033031-mutt-send-email-mst@kernel.org>
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
 <20240312033557.6351-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEtd1L=Cm0DWLZbfSazxxHr+iPP77B1kM=PmjdqeYoAz4w@mail.gmail.com>
 <1711009209.0488706-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1711009209.0488706-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Mar 21, 2024 at 04:20:09PM +0800, Xuan Zhuo wrote:
> On Thu, 21 Mar 2024 13:57:06 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Tue, Mar 12, 2024 at 11:36 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > In the functions vring_unmap_extra_packed and vring_unmap_desc_packed,
> > > multiple checks are made whether unmap is performed and whether it is
> > > INDIRECT.
> > >
> > > These two functions are usually called in a loop, and we should put the
> > > check outside the loop.
> > >
> > > And we unmap the descs with VRING_DESC_F_INDIRECT on the same path with
> > > other descs, that make the thing more complex. If we distinguish the
> > > descs with VRING_DESC_F_INDIRECT before unmap, thing will be clearer.
> > >
> > > 1. only one desc of the desc table is used, we do not need the loop
> > > 2. the called unmap api is difference from the other desc
> > > 3. the vq->premapped is not needed to check
> > > 4. the vq->indirect is not needed to check
> > > 5. the state->indir_desc must not be null
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 78 ++++++++++++++++++------------------
> > >  1 file changed, 40 insertions(+), 38 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index c2779e34aac7..0dfbd17e5a87 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -1214,6 +1214,7 @@ static u16 packed_last_used(u16 last_used_idx)
> > >         return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
> > >  }
> > >
> > > +/* caller must check vring_need_unmap_buffer() */
> > >  static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
> > >                                      const struct vring_desc_extra *extra)
> > >  {
> > > @@ -1221,33 +1222,18 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
> > >
> > >         flags = extra->flags;
> > >
> > > -       if (flags & VRING_DESC_F_INDIRECT) {
> > > -               if (!vq->use_dma_api)
> > > -                       return;
> > > -
> > > -               dma_unmap_single(vring_dma_dev(vq),
> > > -                                extra->addr, extra->len,
> > > -                                (flags & VRING_DESC_F_WRITE) ?
> > > -                                DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > > -       } else {
> > > -               if (!vring_need_unmap_buffer(vq))
> > > -                       return;
> > > -
> > > -               dma_unmap_page(vring_dma_dev(vq),
> > > -                              extra->addr, extra->len,
> > > -                              (flags & VRING_DESC_F_WRITE) ?
> > > -                              DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > > -       }
> > > +       dma_unmap_page(vring_dma_dev(vq),
> > > +                      extra->addr, extra->len,
> > > +                      (flags & VRING_DESC_F_WRITE) ?
> > > +                      DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > >  }
> > >
> > > +/* caller must check vring_need_unmap_buffer() */
> > >  static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
> > >                                     const struct vring_packed_desc *desc)
> > >  {
> > >         u16 flags;
> > >
> > > -       if (!vring_need_unmap_buffer(vq))
> > > -               return;
> > > -
> > >         flags = le16_to_cpu(desc->flags);
> > >
> > >         dma_unmap_page(vring_dma_dev(vq),
> > > @@ -1323,7 +1309,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > >                         total_sg * sizeof(struct vring_packed_desc),
> > >                         DMA_TO_DEVICE);
> > >         if (vring_mapping_error(vq, addr)) {
> > > -               if (vq->premapped)
> > > +               if (!vring_need_unmap_buffer(vq))
> > >                         goto free_desc;
> > >
> > >                 goto unmap_release;
> > > @@ -1338,10 +1324,11 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > >                 vq->packed.desc_extra[id].addr = addr;
> > >                 vq->packed.desc_extra[id].len = total_sg *
> > >                                 sizeof(struct vring_packed_desc);
> > > -               vq->packed.desc_extra[id].flags = VRING_DESC_F_INDIRECT |
> > > -                                                 vq->packed.avail_used_flags;
> > >         }
> > >
> > > +       vq->packed.desc_extra[id].flags = VRING_DESC_F_INDIRECT |
> > > +               vq->packed.avail_used_flags;
> > > +
> > >         /*
> > >          * A driver MUST NOT make the first descriptor in the list
> > >          * available before all subsequent descriptors comprising
> > > @@ -1382,6 +1369,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > >  unmap_release:
> > >         err_idx = i;
> > >
> > > +       WARN_ON(!vring_need_unmap_buffer(vq));
> > > +
> > >         for (i = 0; i < err_idx; i++)
> > >                 vring_unmap_desc_packed(vq, &desc[i]);
> > >
> > > @@ -1475,12 +1464,13 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > >                         desc[i].len = cpu_to_le32(sg->length);
> > >                         desc[i].id = cpu_to_le16(id);
> > >
> > > -                       if (unlikely(vq->use_dma_api)) {
> > > +                       if (vring_need_unmap_buffer(vq)) {
> > >                                 vq->packed.desc_extra[curr].addr = addr;
> > >                                 vq->packed.desc_extra[curr].len = sg->length;
> > > -                               vq->packed.desc_extra[curr].flags =
> > > -                                       le16_to_cpu(flags);
> > >                         }
> > > +
> > > +                       vq->packed.desc_extra[curr].flags = le16_to_cpu(flags);
> > > +
> > >                         prev = curr;
> > >                         curr = vq->packed.desc_extra[curr].next;
> > >
> > > @@ -1530,6 +1520,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > >
> > >         vq->packed.avail_used_flags = avail_used_flags;
> > >
> > > +       WARN_ON(!vring_need_unmap_buffer(vq));
> > > +
> > >         for (n = 0; n < total_sg; n++) {
> > >                 if (i == err_idx)
> > >                         break;
> > > @@ -1599,7 +1591,9 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
> > >         struct vring_desc_state_packed *state = NULL;
> > >         struct vring_packed_desc *desc;
> > >         unsigned int i, curr;
> > > +       u16 flags;
> > >
> > > +       flags = vq->packed.desc_extra[id].flags;
> > >         state = &vq->packed.desc_state[id];
> > >
> > >         /* Clear data ptr. */
> > > @@ -1609,22 +1603,32 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
> > >         vq->free_head = id;
> > >         vq->vq.num_free += state->num;
> > >
> > > -       if (unlikely(vq->use_dma_api)) {
> > > -               curr = id;
> > > -               for (i = 0; i < state->num; i++) {
> > > -                       vring_unmap_extra_packed(vq,
> > > -                                                &vq->packed.desc_extra[curr]);
> > > -                       curr = vq->packed.desc_extra[curr].next;
> > > +       if (!(flags & VRING_DESC_F_INDIRECT)) {
> > > +               if (vring_need_unmap_buffer(vq)) {
> > > +                       curr = id;
> > > +                       for (i = 0; i < state->num; i++) {
> > > +                               vring_unmap_extra_packed(vq,
> > > +                                                        &vq->packed.desc_extra[curr]);
> > > +                               curr = vq->packed.desc_extra[curr].next;
> > > +                       }
> > >                 }
> > > -       }
> > >
> > > -       if (vq->indirect) {
> > > +               if (ctx)
> > > +                       *ctx = state->indir_desc;
> > > +       } else {
> > > +               const struct vring_desc_extra *extra;
> > >                 u32 len;
> > >
> > > +               if (vq->use_dma_api) {
> > > +                       extra = &vq->packed.desc_extra[id];
> > > +                       dma_unmap_single(vring_dma_dev(vq),
> > > +                                        extra->addr, extra->len,
> > > +                                        (flags & VRING_DESC_F_WRITE) ?
> > > +                                        DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > > +               }
> >
> > Theoretically, indirect descriptors could be chained. It is supported
> > without this patch but not here.
> 
> 
> YES. But now, that is not supported by "add", so I think we
> do not need to think about it.
> 
> Thanks.


the "add" you are referring to is virtio drivers in the linux guest?
That's not the only guest and there's no way to be sure
no one does it. We can make some unusual operations go somewhat
slower but breaking them outright is not a good idea.

> >
> > Thanks
> >
> > > +
> > >                 /* Free the indirect table, if any, now that it's unmapped. */
> > >                 desc = state->indir_desc;
> > > -               if (!desc)
> > > -                       return;
> > >
> > >                 if (vring_need_unmap_buffer(vq)) {
> > >                         len = vq->packed.desc_extra[id].len;
> > > @@ -1634,8 +1638,6 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
> > >                 }
> > >                 kfree(desc);
> > >                 state->indir_desc = NULL;
> > > -       } else if (ctx) {
> > > -               *ctx = state->indir_desc;
> > >         }
> > >  }
> > >
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >

