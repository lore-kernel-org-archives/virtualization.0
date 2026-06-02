Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CA93603DD
	for <virtualization@lists.linux.dev>; Tue,  2 Jun 2026 07:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780383601; cv=none; b=pBemcG0nuUDX0Z3PNz4LCXYqkAqXeTEljPthc9tF1ll+FIIDQme49um6ljBIzkt1ffQwq7/TVMLmq5u+es4U1PRXKBpwh/IwVfmS38XI+6KlJ1kiWrHovW3MhsPn+aWP6QDgD5hhZvP+78cbkezj4ZFf379QI7gaDoMZHDnZofE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780383601; c=relaxed/simple;
	bh=7QyoO1ieaI4jsTguNYCElIKCwJ8XuOu7ct4cE0FyXAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=e0k2DuajGDTncF9Rq7mVpKXWXIixBwICSTqZCVCRGSg0yGBVqNEO1ghvMlLm4ac0GDQ6PtVEEcS5cJdDLeoDN1JbXn9+pMqec7BBZj8XCt0FnDjZGjn2k6Eklb9pI4nLx3sBfIWJ+4T537v42Cr/xPtu4V83p8TixnyHhRfhERc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d0bZ4F4K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0bZ4F4K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780383599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ixKnRwmOoQZDkg++t9iEqrO8e8veh2+T+tcn14siCc0=;
	b=d0bZ4F4KJOXtwx7ZxM3rQi1i9hDCuM6P3VOZ7HGnhi6wgIA8n1i1CQD9Q5XoiP0xowJzId
	EsXIs+MJAJre8IMAfBpvcv6U42nYug2Gzp++UVwMdTJILt3ksJHBVzxDezeTvSN2a7uhgc
	De7BPSIbmwBNK94D8fqI0KOJp0QVaRk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-j0mY0O4JOyeLIWLHjyDl2g-1; Tue, 02 Jun 2026 02:59:58 -0400
X-MC-Unique: j0mY0O4JOyeLIWLHjyDl2g-1
X-Mimecast-MFC-AGG-ID: j0mY0O4JOyeLIWLHjyDl2g_1780383597
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490ab3f6e55so8554205e9.0
        for <virtualization@lists.linux.dev>; Mon, 01 Jun 2026 23:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780383597; x=1780988397;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ixKnRwmOoQZDkg++t9iEqrO8e8veh2+T+tcn14siCc0=;
        b=A3VvFLlUJH/rwCKz54x/NXZsGemfzdZXOa0ho52UpOuPnRX3wNnaozpLFfyLOUe7UJ
         /Q+A4pNBIluxjzqeyv1iZxiTd4a18SQvzyTpvoirdaw7QVricg1AAdIpda/H18s9IOF0
         UGm+gXR+4Ql7Pr4IeoksHvcBuZghttDxnBBtz2v/aiSm47wGGgs2G/EjeykLgUdCdrGs
         Gaf1u6gJc4q+/uFg8p39cFgopnoe0W7hLl6OO+QB1Mg0jrvPCZWla+Sv3Uj2aIR2Ptcr
         chySOBFC/7xXJk6vgbDVJN/ES2YvSy/O7PJy8w5E8Knm7LOBTVAV7MmywiMt+n+aQ7Ku
         JlhQ==
X-Forwarded-Encrypted: i=1; AFNElJ+PGbNsMlf2k7VIIyM2i3919A2zSq5WgA7grEkQlwJqoIQQaaCjuU1zGnd2K/IVegR4rJ41FmpHJyPUckD7ww==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCQse0BH5PrjBfxCVHvjquLmP5QpfNoSSpnfaQN3KoQH5+xM7B
	aAP6WiYT4Zl0qAQszgjZPxbke6zhNi5rDSQFNGxuWy/kYaq0NCBuYzLfIuC9BEvrohozzuBlIFF
	nd61Z9gf4FNOENJdVUEK2bj3veq6+fmkni6y1v4cJMJxkdvmArDhOfcnj5RWqbNe7sBwO
X-Gm-Gg: Acq92OEHlaE0xDdWgPM91ZV44Zr5527Vw1CzDap7wFeTzQXjXHs/yk2KVThcRyIDrgg
	RwN08ajCJRbr89uW6SyNB6BjA1DvuzVACGWf+2dfbNqrKagd/kI0tAtLNAT3aVCTcF7TD0t1uVN
	9ldJGf60D/FrPbL83SBHsXcaOpDy41KJJLN5znnEcQ5KwnHjpD43jBknZO6900lDAluMawQcWj1
	bHKozn5zcOycgvcixIWNAY3wY6j20wYHOPAYB2hcm9esjWfrCWzaKEiRgaz394h12bKRBof/Q2u
	W2KfVRenyiiNBYGiJbDDxj+ym/VPVosxT7AS4kKL1iAmosxYtRnNIHmydnkTgZBM15vE/8l18qA
	PGmhOzeYZ/65QI7jyfiXV5KwDRSbtxOxVSxZspoe3MnRm47Ee7SAovw==
X-Received: by 2002:a05:600c:a111:b0:490:469c:556b with SMTP id 5b1f17b1804b1-490a2933355mr206062365e9.12.1780383596537;
        Mon, 01 Jun 2026 23:59:56 -0700 (PDT)
X-Received: by 2002:a05:600c:a111:b0:490:469c:556b with SMTP id 5b1f17b1804b1-490a2933355mr206061985e9.12.1780383596092;
        Mon, 01 Jun 2026 23:59:56 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46018c87803sm3977286f8f.30.2026.06.01.23.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 23:59:55 -0700 (PDT)
Date: Tue, 2 Jun 2026 02:59:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: yangjiale <yangjiale133@163.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VIRTIO: Update the desc 'flag' fied last in packed ring.
Message-ID: <20260602025930-mutt-send-email-mst@kernel.org>
References: <20260602043123.10207-1-yangjiale133@163.com>
 <CAJaqyWfugEttrQuR5_LrbQaivAqCaixsprUOjEVtdiz_sexFpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWfugEttrQuR5_LrbQaivAqCaixsprUOjEVtdiz_sexFpA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MSKo34B4mvhcohWeGiJ2kxn_L03O2yREHg3-i2ysYkk_1780383597
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jun 02, 2026 at 08:04:13AM +0200, Eugenio Perez Martin wrote:
> On Tue, Jun 2, 2026 at 6:34 AM yangjiale <yangjiale133@163.com> wrote:
> >
> > When a descriptor list spans across cache lines,
> > updating the flag first can lead to a scenario where the device side
> > perceives the flag as valid, yet the corresponding address and length
> > fields remain unupdated—resulting in invalid values.
> > Therefore, the flag field must be updated last.
> >
> > Signed-off-by: yangjiale <yangjiale133@163.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index fbca7ce1c6bf..036b4f90d30f 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1688,6 +1688,10 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
> >                                              &addr, &len, premapped, attr))
> >                                 goto unmap_release;
> >
> > +                       desc[i].addr = cpu_to_le64(addr);
> > +                       desc[i].len = cpu_to_le32(len);
> > +                       desc[i].id = cpu_to_le16(id);
> > +
> >                         flags = cpu_to_le16(vq->packed.avail_used_flags |
> >                                     (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
> >                                     (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
> > @@ -1696,10 +1700,6 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
> >                         else
> >                                 desc[i].flags = flags;
> >
> > -                       desc[i].addr = cpu_to_le64(addr);
> > -                       desc[i].len = cpu_to_le32(len);
> > -                       desc[i].id = cpu_to_le16(id);
> > -
> >                         if (unlikely(vq->use_map_api)) {
> >                                 vq->packed.desc_extra[curr].addr = premapped ?
> >                                         DMA_MAPPING_ERROR : addr;
> 
> These flags are updated before the flags of the head descriptor at the
> end of the function, at "vq->packed.vring.desc[head].flags =
> head_flags", so the device should not see these. Because of that, the
> relative order between the rest of the fields of the same descriptor
> or other descriptors' fields, except for the head descriptor's flags,
> should not matter. There is a write memory barrier just before
> updating the head's flags.
> 
> Also, I don't get why the cache line matters here. Can you expand? Am
> I missing something?

Oh desc is just a local thing. ENOCOFFEE )

