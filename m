Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB77238C08
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 05:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693199; cv=none; b=oVus3EeWp61FgY9FOxkWZYoDsdCVuhQGccdlV9TX46vXYB27IZZRB6AQF7PONy1ySHARzVkESLXLlUJj2VRHuzY1u2YFywKiShLERyuF7VJuI8sE9lnrgFV1/wSblzC1IfijBvRshWCS6S6l1p0x7NE8a1B2BrX4DBnO9j3OPU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693199; c=relaxed/simple;
	bh=B4a/YXURiaBCO958SfHF2Xk2HSl7/Z/CLzlwsOlqiGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ELut9Zg7oA7zNr2W+gNWfCgbcWbS0jpGQOd3vq35EGv9maregz/Rt8cKKpwKstCRYJphB6tuPSXU5XhuMu7Kbr63bbszDrnS4Mu1kaEoS0JzTIEiPlyBrH9ig3Qqtjjk/rSlFFUpNk+rINE/WFaWQX0sESpvKnav43MmJfp8kfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PsAvZUca; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsAvZUca"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758693194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0yqy5sIF/mbVon/4aCf6DGj9oZ/rod69vebQth4ROk=;
	b=PsAvZUcaG6ng0o24jlMpliQ9qRsQtA+WDlL5mdf1k7Je28S/NIdh8m9zolT49ggYnpwxSt
	4hW9DFAoH1huUIehyunMY/eGI8zkGVVwNjjyas7CGX1ENZSjQxBFXUGmmCOhIy6Uzuu/xp
	Z1Hy880CzlrxH5xkTp7tfqjJUH/OhLc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-Yr-N0wJHPVCoBu6lO6KJWQ-1; Wed, 24 Sep 2025 01:53:13 -0400
X-MC-Unique: Yr-N0wJHPVCoBu6lO6KJWQ-1
X-Mimecast-MFC-AGG-ID: Yr-N0wJHPVCoBu6lO6KJWQ_1758693192
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ece14b9231so3109322f8f.0
        for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 22:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758693192; x=1759297992;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0yqy5sIF/mbVon/4aCf6DGj9oZ/rod69vebQth4ROk=;
        b=uqjmLZPWkqEnKfiUMy9NhSTiNIiOqYQLEGpl/5qK6LmWTbeWfPistdfORV/uJ//R+0
         z20C17UD5d0jaNSQB981AIzX2k5i8mOvPotHINbTzDKlYbFhcstxtDhP8qhTpoD01Aat
         YxY1qEmMuBB0zj8qvXBWcclVggDVotTS4FPriFhIV3mmM/Wsl3ph53RTycyUnMlUxpch
         J2plVEtYhM43nIi4Sk+dnTx9RYu3tPY2QukK7RvFw2AasSX5RN9cheRN5VrsuN+dOAIR
         bnZ1j5REPaAHX71nCOW0rgyeh8wR8NyU/nxUs02/E3emZap7n7VkA4CxgXV1cuzwdBDW
         kq4g==
X-Forwarded-Encrypted: i=1; AJvYcCUGILII28v3W+g3dlaTgeVzf6JufMBgS0CjdbxF/gcuk42zchYTfSiUwsK61sZWwX/A70dYTxPEU8ePIELBXg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/oNA+Mz2wxSax+IIw3oKZJHRWA0WrzJkx/WM/Vje31txXT/TO
	fhJdrxjI+b8G/WwlSL9YGOQgw0Wbd2ol1GMwZFgnRkypIppR09K+i+zhO4Ef+NX7WH8QGGArQV7
	Pi6uCf6nzQfr/SAY6r4aV7Ftnrw4QvIskIgnFGL5bMflhHyuOG5u5sjBK8/EhD1gdSgWc
X-Gm-Gg: ASbGncuvKnhlHGX9oBaoCp7OYeviDR+Web+/Ul9psj4jo2+tXIwI/NFuAO668KIkBBx
	3vaDkcGF6KPXDXeC1ToPgvVU3N7Mwl2CrVv1yH+NuA/gJtcxiOflZdm+h6mnyKJtsCBLv+Whj3Y
	rAUg5IJysexf83kwypx1IwKng8STvcp54IaMOUpdz7muFzQj5VohVqEv4ZGuNzZwrRUC6FVOArD
	UKFk6uyY4R0PxJOKGPnlLvumauBcpyXfW5Tj155zBXusVmY9ci7dAmLvV1fKjBivlUPI/vkpWJp
	PlGJODW9bvhW5pOSCf42Vil+x6/3pnRcvb8=
X-Received: by 2002:a05:6000:2586:b0:3e9:3b91:e846 with SMTP id ffacd0b85a97d-405c33a34eamr4440446f8f.10.1758693191701;
        Tue, 23 Sep 2025 22:53:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf5TUC9BgLaAZU+9i2E0pf8rESa23VSVR25Y+2lgkMUPVr60byXGFMw9MFF8HuzBo6Cn0UjA==
X-Received: by 2002:a05:6000:2586:b0:3e9:3b91:e846 with SMTP id ffacd0b85a97d-405c33a34eamr4440430f8f.10.1758693191242;
        Tue, 23 Sep 2025 22:53:11 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a998321sm15579915e9.1.2025.09.23.22.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 22:53:10 -0700 (PDT)
Date: Wed, 24 Sep 2025 01:53:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 19/19] virtio_ring: add in order support
Message-ID: <20250924015115-mutt-send-email-mst@kernel.org>
References: <20250919073154.49278-1-jasowang@redhat.com>
 <20250919073154.49278-20-jasowang@redhat.com>
 <20250921142053-mutt-send-email-mst@kernel.org>
 <CACGkMEtFRyzafYqrfuT6gYeosAADL94T5-abEwQ3ThTMn7HQkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtFRyzafYqrfuT6gYeosAADL94T5-abEwQ3ThTMn7HQkw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b0k2TPgwh1tl_PN2NnXVSSoIrfCLvw_GnOU3OGOPBzU_1758693192
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Sep 24, 2025 at 01:38:03PM +0800, Jason Wang wrote:
> On Mon, Sep 22, 2025 at 2:24 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Sep 19, 2025 at 03:31:54PM +0800, Jason Wang wrote:
> > > This patch implements in order support for both split virtqueue and
> > > packed virtqueue. Perfomance could be gained for the device where the
> > > memory access could be expensive (e.g vhost-net or a real PCI device):
> > >
> > > Benchmark with KVM guest:
> > >
> > > Vhost-net on the host: (pktgen + XDP_DROP):
> > >
> > >          in_order=off | in_order=on | +%
> > >     TX:  5.20Mpps     | 6.20Mpps    | +19%
> > >     RX:  3.47Mpps     | 3.61Mpps    | + 4%
> > >
> > > Vhost-user(testpmd) on the host: (pktgen/XDP_DROP):
> > >
> > > For split virtqueue:
> > >
> > >          in_order=off | in_order=on | +%
> > >     TX:  5.60Mpps     | 5.60Mpps    | +0.0%
> > >     RX:  9.16Mpps     | 9.61Mpps    | +4.9%
> > >
> > > For packed virtqueue:
> > >
> > >          in_order=off | in_order=on | +%
> > >     TX:  5.60Mpps     | 5.70Mpps    | +1.7%
> > >     RX:  10.6Mpps     | 10.8Mpps    | +1.8%
> > >
> > > Benchmark also shows no performance impact for in_order=off for queue
> > > size with 256 and 1024.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 421 +++++++++++++++++++++++++++++++++--
> > >  1 file changed, 401 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index b700aa3e56c3..c00b5e57f2fc 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -70,6 +70,8 @@
> > >  enum vq_layout {
> > >       SPLIT = 0,
> > >       PACKED,
> > > +     SPLIT_IN_ORDER,
> > > +     PACKED_IN_ORDER,
> > >       VQ_TYPE_MAX,
> > >  };
> > >
> > > @@ -80,6 +82,7 @@ struct vring_desc_state_split {
> > >        * allocated together. So we won't stress more to the memory allocator.
> > >        */
> > >       struct vring_desc *indir_desc;
> > > +     u32 total_len;                  /* Buffer Length */
> > >  };
> > >
> > >  struct vring_desc_state_packed {
> > > @@ -91,6 +94,7 @@ struct vring_desc_state_packed {
> > >       struct vring_packed_desc *indir_desc;
> > >       u16 num;                        /* Descriptor list length. */
> > >       u16 last;                       /* The last desc state in a list. */
> > > +     u32 total_len;                  /* Buffer Length */
> > >  };
> > >
> > >  struct vring_desc_extra {
> > > @@ -206,6 +210,17 @@ struct vring_virtqueue {
> > >
> > >       /* Head of free buffer list. */
> > >       unsigned int free_head;
> > > +
> > > +     /*
> > > +      * With IN_ORDER, devices write a single used ring entry with
> > > +      * the id corresponding to the head entry of the descriptor chain
> > > +      * describing the last buffer in the batch
> > > +      */
> > > +     struct used_entry {
> > > +             u32 id;
> > > +             u32 len;
> > > +     } batch_last;
> > > +
> > >       /* Number we've added since last sync. */
> > >       unsigned int num_added;
> > >
> > > @@ -258,7 +273,12 @@ static void vring_free(struct virtqueue *_vq);
> > >
> > >  static inline bool virtqueue_is_packed(const struct vring_virtqueue *vq)
> > >  {
> > > -     return vq->layout == PACKED;
> > > +     return vq->layout == PACKED || vq->layout == PACKED_IN_ORDER;
> > > +}
> > > +
> > > +static inline bool virtqueue_is_in_order(const struct vring_virtqueue *vq)
> > > +{
> > > +     return vq->layout == SPLIT_IN_ORDER || vq->layout == PACKED_IN_ORDER;
> > >  }
> > >
> > >  static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
> > > @@ -575,6 +595,8 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
> > >       struct scatterlist *sg;
> > >       struct vring_desc *desc;
> > >       unsigned int i, n, avail, descs_used, err_idx, c = 0;
> > > +     /* Total length for in-order */
> > > +     unsigned int total_len = 0;
> > >       int head;
> > >       bool indirect;
> > >
> > > @@ -646,6 +668,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
> > >                                                    ++c == total_sg ?
> > >                                                    0 : VRING_DESC_F_NEXT,
> > >                                                    premapped);
> > > +                     total_len += len;
> > >               }
> > >       }
> > >       for (; n < (out_sgs + in_sgs); n++) {
> > > @@ -663,6 +686,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
> > >                               i, addr, len,
> > >                               (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
> > >                               VRING_DESC_F_WRITE, premapped);
> > > +                     total_len += len;
> > >               }
> > >       }
> > >
> > > @@ -685,7 +709,12 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
> > >       vq->vq.num_free -= descs_used;
> > >
> > >       /* Update free pointer */
> > > -     if (indirect)
> > > +     if (virtqueue_is_in_order(vq)) {
> > > +             vq->free_head += descs_used;
> > > +             if (vq->free_head >= vq->split.vring.num)
> > > +                     vq->free_head -= vq->split.vring.num;
> > > +             vq->split.desc_state[head].total_len = total_len;;
> > > +     } else if (indirect)
> > >               vq->free_head = vq->split.desc_extra[head].next;
> > >       else
> > >               vq->free_head = i;
> > > @@ -858,6 +887,14 @@ static bool more_used_split(const struct vring_virtqueue *vq)
> > >       return virtqueue_poll_split(vq, vq->last_used_idx);
> > >  }
> > >
> > > +static bool more_used_split_in_order(const struct vring_virtqueue *vq)
> > > +{
> > > +     if (vq->batch_last.id != vq->packed.vring.num)
> > > +             return true;
> >
> > Hmm why ->packed?
> 
> Right, it's a bug. Let me fix that.
> 
> >
> > This is actually a problem in this approach, kinda easy to get confused
> > which variant to call where.
> 
> Probably, but we have been doing this since the introduction of packed
> virtqueue.
> 
> >
> > Worth thinking how to fix this.
> >
> 
> Yes, but I think this series improves this by introducing the
> virtqueue ops. Optimization could be done on top.
> 
> For example, having separate files for packed and split with private structure.
> 
> Thanks

sure


Besides, LLMs are getting good at catching this kind of bug.


It might be enough to just add a file under Documentation/
describing the rules, at this point, plus a code comment
pointing there.


-- 
MST

