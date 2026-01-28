Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3853612F7
	for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769621420; cv=none; b=bMUx+LZkQ95D8mlipamthwa3RWQ80BdjCQR0/R8zOhXBd4w4A4c9aAMXXBoy416ZjIqNo0NvwZOS1PKO38ncULbOAJ7dHpdUbBJppVZkmSN6ccoklSL748GemvHQataqZE1TlzBoqlIqzSat/jAgjAIYea4VlmGQygu8OFsZfps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769621420; c=relaxed/simple;
	bh=kZrAcSW4YDTUmKwPS5oi3/SIfvsJS8/euEp/KZsX2wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=I3n/UXHP+DgQAuGB/xSR8+M3sKFPutnwztWWXWo3LYG+bSu8oZYxwj7TiDn7P6XoY/1VKoI2nkiCC4XOKiOqbrxsWezdQMIbHX+Ew2jN8oCGAix97OtAO61hrHP18B8PZMhtJUSWCam9TwP36mozhlg294FTZSEPmIfDa5FL068=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S0sK3ESb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0sK3ESb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769621412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WUdlpeBd63Y3o3yMh9UlAkQqXRfFsRr+ONmWRJo5MJQ=;
	b=S0sK3ESbFYyKrVJ4y90FIlirdrSiNsvHmNiOI1wOS3fUbL4MfH6sXX1IDQ2TmqYJBqYZNi
	qMyj+V4h0J6DDexf5xv16kfsFMG5RVolu409xUHib3GFvHxfULTVWKUasvuJQEnTNMCF+Z
	ahyzviMi3OshNCJueiDKm1p5GYbkEhA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-wOFTdcQ6MciuQac0gsknUA-1; Wed, 28 Jan 2026 12:30:09 -0500
X-MC-Unique: wOFTdcQ6MciuQac0gsknUA-1
X-Mimecast-MFC-AGG-ID: wOFTdcQ6MciuQac0gsknUA_1769621408
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4806b12ad3fso696265e9.0
        for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 09:30:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769621408; x=1770226208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUdlpeBd63Y3o3yMh9UlAkQqXRfFsRr+ONmWRJo5MJQ=;
        b=w5R3uy83NHC94fAgEeUdNPhfxbS97ZlofzoMSJpeeUt3SNyuKg7Qdgn0+5/1fn1FLC
         SMJ0jqGjNUDnpufgpL3tDKPhyVI+Sy6i9+lp8EnrN+ofCvMxZH8x2gVm3R6gLBpJc7tU
         r4Qr70ZlUtitINn3R8JchrAqOfxAG3m1DfNkdQPp5UOlec+uSUbD14OukC7iFZA2o006
         /t7jsXadZ3P7jUMBNACf9fzK/qFmPqcQV3eZsjynHhdT/d5sVeYvxjCaVG6Ke0jv/pAF
         hYcknSnXzAiQ2tzkYXcYHSLupoAuhCE20AA5h1DelQ8N7LbpP89X18R1XMPova69BXtL
         xdtw==
X-Forwarded-Encrypted: i=1; AJvYcCUrVJWrHSygmr6IgTZ3KUQGF/CmbQDBOPV9/AOszkRO7RVR8De7siEQAEcrqyGECY117zmeDFxlW/0ARppBlg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjRCvn27xb9bOpNhc8rHEJjajh8PcwrmsH2PgD9RDmh0+Ar6Y1
	j2MIEeo1AKkshmJkm/lKKbraRYimrlMNUAf6IRwKBXDa0hcaQ3BAtMFEuQJqzHtvQ8QL5eEGutN
	7QZUsBb5ibGp/+c+qUybIbnGgQYoSNl996Ma3ucHT9Rieb4vs1lzGjdimK48FnFPODQmx
X-Gm-Gg: AZuq6aJU/gbmJh5ypgSjvkHIMqaPbUnVRDyJ82cndWOMXTeCSO+hOt9n+P6MXhQUftx
	mu6ZXGiAEG3ths4zp6o+uSQxqm16VYpQ362hPqBxeqN58CjuJ+4SbGNwAUE38zJYS6braFehloX
	PKY7PNN5Tr0GG7vnM9bv9mQDZbpsTBZjnwZ83VCJBrh3bnxLkKuaXkJbUB7g7jU2fO9c4569g4L
	rW6CeYmj9rXiFH04ZM4+N1Z+gYXjU3lV0N4GRBzyJTeyCeiMhFkbDaKdZ7+6J3mcNYH8kfPhqEP
	JHwXKR7XmQyKdxTcOeA779/oMdQHcLXPEU00xX0HlIjSUHSbdz5WR5SVP5dnTJ0RcjclUjKRvof
	vS//gICwkQT5eyTopR/jAvjWa/6duWDR+zQ==
X-Received: by 2002:a05:600c:4f0c:b0:477:9cdb:e337 with SMTP id 5b1f17b1804b1-48069bfaa18mr91359915e9.7.1769621407677;
        Wed, 28 Jan 2026 09:30:07 -0800 (PST)
X-Received: by 2002:a05:600c:4f0c:b0:477:9cdb:e337 with SMTP id 5b1f17b1804b1-48069bfaa18mr91359115e9.7.1769621407003;
        Wed, 28 Jan 2026 09:30:07 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806e2a065asm4644515e9.6.2026.01.28.09.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 09:30:06 -0800 (PST)
Date: Wed, 28 Jan 2026 12:30:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"open list:VIRTIO CORE" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_ring: Add READ_ONCE annotations for
 device-writable fields
Message-ID: <20260128122439-mutt-send-email-mst@kernel.org>
References: <20260128135947.455686-1-johannes.thumshirn@wdc.com>
 <9494f555-0b18-41f6-9e8d-fc0b198c27cd@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <9494f555-0b18-41f6-9e8d-fc0b198c27cd@amazon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CiJC-pJpTevvcSat7keNbGPgInoY7TCnrHneg6ouc_0_1769621408
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 28, 2026 at 03:47:27PM +0100, Alexander Graf wrote:
> 
> On 28.01.26 14:59, Johannes Thumshirn wrote:
> > From: Alexander Graf <graf@amazon.com>
> > 
> > KCSAN reports data races when accessing virtio ring fields that are
> > concurrently written by the device (host). These are legitimate
> > concurrent accesses where the CPU reads fields that the device updates
> > via DMA-like mechanisms.
> > 
> > Add accessor functions that use READ_ONCE() to properly annotate these
> > device-writable fields and prevent compiler optimizations that could
> > break the code. This also serves as documentation showing which fields
> > are shared with the device.
> > 
> > The affected fields are:
> > - Split ring: used->idx, used->ring[].id, used->ring[].len
> > - Packed ring: desc[].flags, desc[].id, desc[].len
> > 
> > Reported-by: Kernel Concurrency Sanitizer (KCSAN)
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> 
> 
> Thanks for persistently trying to fix these KCSAN warnings! :)
> 
> This patch was an initial AI generated stab at seeing whether READ_ONCE
> would work and how to make it pretty. It was not meant to go to the mailing
> list as is. Some comments on what we would need to improve to bring it to a
> mergeable state.


According to latest Docs, use of AI should be documented.
Just a statement to this end is probably going to be enough.

> 
> Given this is not a subsystem-contributor relationship, I also think it
> would be Co-developed-by instead of signed-off-by :).
> 
> > [jth: Add READ_ONCE in virtqueue_kick_prepare_split ]
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > ---
> >   drivers/virtio/virtio_ring.c | 88 ++++++++++++++++++++++++++++++------
> >   1 file changed, 73 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index ddab68959671..74957c83e138 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -222,6 +222,63 @@ struct vring_virtqueue {
> >   #endif
> >   };
> > 
> > +/*
> > + * Accessors for device-writable fields in virtio rings.
> > + * These fields are concurrently written by the device and read by the driver.
> > + * Use READ_ONCE() to prevent compiler optimizations and document the
> > + * intentional data race.
> 
> 
> Should mention that this is necessary for KCSAN.
> 
> 
> > + */
> > +
> > +/* Split ring: read device-written fields from used ring */
> 
> 
> Useless comment
> 
> 
> > +static inline u16 vring_used_idx_read(const struct vring_virtqueue *vq)
> 
> 
> Just do a complete sed s/_read// on this patch. Nobody needs these _read
> suffixes.

That's fine, too.

> 
> > +{
> > +       return virtio16_to_cpu(vq->vq.vdev,
> > +                              READ_ONCE(vq->split.vring.used->idx));
> > +}
> > +
> > +static inline u32 vring_used_id_read(const struct vring_virtqueue *vq,
> > +                                    u16 idx)
> > +{
> > +       return virtio32_to_cpu(vq->vq.vdev,
> > +                              READ_ONCE(vq->split.vring.used->ring[idx].id));
> > +}
> > +
> > +static inline u32 vring_used_len_read(const struct vring_virtqueue *vq,
> > +                                     u16 idx)
> > +{
> > +       return virtio32_to_cpu(vq->vq.vdev,
> > +                              READ_ONCE(vq->split.vring.used->ring[idx].len));
> > +}
> > +
> > +/* Packed ring: read device-written fields from descriptors */
> 
> 
> Useless comment
> 
> 
> > +static inline u16 vring_packed_desc_flags_read(const struct vring_virtqueue *vq,
> > +                                              u16 idx)
> > +{
> > +       return le16_to_cpu(READ_ONCE(vq->packed.vring.desc[idx].flags));
> > +}
> > +
> > +static inline u16 vring_packed_desc_id_read(const struct vring_virtqueue *vq,
> > +                                           u16 idx)
> > +{
> > +       return le16_to_cpu(READ_ONCE(vq->packed.vring.desc[idx].id));
> > +}
> > +
> > +static inline u32 vring_packed_desc_len_read(const struct vring_virtqueue *vq,
> > +                                            u16 idx)
> > +{
> > +       return le32_to_cpu(READ_ONCE(vq->packed.vring.desc[idx].len));
> > +}
> > +
> > +/*
> > + * Note: We don't need READ_ONCE for driver->device fields like:
> > + * - split.vring.avail->idx (driver writes, device reads)
> > + * - packed.vring.desc[].addr (driver writes, device reads)
> > + * These are written by the driver and only read by the device, so the
> > + * driver can safely access them without READ_ONCE. The device must use
> > + * appropriate barriers on its side.
> > + */
> 
> 
> Useless comment really. If you think it's worthwhile to mention the above,
> put it into the patch description.
> 
> 
> > +
> > +
> >   static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
> >   static void vring_free(struct virtqueue *_vq);
> > 
> > @@ -736,9 +793,10 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
> >          LAST_ADD_TIME_INVALID(vq);
> > 
> >          if (vq->event) {
> > -               needs_kick = vring_need_event(virtio16_to_cpu(_vq->vdev,
> > -                                       vring_avail_event(&vq->split.vring)),
> > -                                             new, old);
> > +               u16 event = virtio16_to_cpu(_vq->vdev,
> > +                               READ_ONCE(vring_avail_event(&vq->split.vring)));
> > +
> > +               needs_kick = vring_need_event(event, new, old);
> >          } else {
> >                  needs_kick = !(vq->split.vring.used->flags &
> >                                          cpu_to_virtio16(_vq->vdev,
> > @@ -808,8 +866,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> > 
> >   static bool more_used_split(const struct vring_virtqueue *vq)
> >   {
> > -       return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev,
> > -                       vq->split.vring.used->idx);
> > +       return vq->last_used_idx != vring_used_idx_read(vq);
> >   }
> > 
> >   static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > @@ -838,10 +895,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> >          virtio_rmb(vq->weak_barriers);
> > 
> >          last_used = (vq->last_used_idx & (vq->split.vring.num - 1));
> > -       i = virtio32_to_cpu(_vq->vdev,
> > -                       vq->split.vring.used->ring[last_used].id);
> > -       *len = virtio32_to_cpu(_vq->vdev,
> > -                       vq->split.vring.used->ring[last_used].len);
> > +       i = vring_used_id_read(vq, last_used);
> > +       *len = vring_used_len_read(vq, last_used);
> > 
> >          if (unlikely(i >= vq->split.vring.num)) {
> >                  BAD_RING(vq, "id %u out of range\n", i);
> > @@ -923,8 +978,7 @@ static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned int last_used_i
> >   {
> >          struct vring_virtqueue *vq = to_vvq(_vq);
> > 
> > -       return (u16)last_used_idx != virtio16_to_cpu(_vq->vdev,
> > -                       vq->split.vring.used->idx);
> > +       return (u16)last_used_idx != vring_used_idx_read(vq);
> >   }
> > 
> >   static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
> > @@ -1701,10 +1755,10 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
> >   static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
> >                                         u16 idx, bool used_wrap_counter)
> >   {
> > -       bool avail, used;
> >          u16 flags;
> > +       bool avail, used;
> > 
> > -       flags = le16_to_cpu(vq->packed.vring.desc[idx].flags);
> > +       flags = vring_packed_desc_flags_read(vq, idx);
> >          avail = !!(flags & (1 << VRING_PACKED_DESC_F_AVAIL));
> >          used = !!(flags & (1 << VRING_PACKED_DESC_F_USED));
> > 
> > @@ -1751,8 +1805,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> >          last_used_idx = READ_ONCE(vq->last_used_idx);
> >          used_wrap_counter = packed_used_wrap_counter(last_used_idx);
> >          last_used = packed_last_used(last_used_idx);
> > -       id = le16_to_cpu(vq->packed.vring.desc[last_used].id);
> > -       *len = le32_to_cpu(vq->packed.vring.desc[last_used].len);
> > +       id = vring_packed_desc_id_read(vq, last_used);
> > +       *len = vring_packed_desc_len_read(vq, last_used);
> > 
> >          if (unlikely(id >= vq->packed.vring.num)) {
> >                  BAD_RING(vq, "id %u out of range\n", id);
> > @@ -1850,6 +1904,10 @@ static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
> >          bool wrap_counter;
> >          u16 used_idx;
> > 
> > +       /*
> > +        * Note: off_wrap is from virtqueue_enable_cb_prepare_packed() which
> > +        * already used READ_ONCE on vq->last_used_idx, so we don't need it again.
> > +        */
> 
> 
> On its own in this code base 5 years from now, this comment will be super
> confusing. Because nobody has context what this note is about. I'd say just
> remove it.
> 
> 
> Alex
> 
> 
> >          wrap_counter = off_wrap >> VRING_PACKED_EVENT_F_WRAP_CTR;
> >          used_idx = off_wrap & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR);
> > 
> > --
> > 2.52.0
> > 
> 
> 
> 
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597

