Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700F138C41E
	for <virtualization@lists.linux.dev>; Fri,  5 Jun 2026 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681419; cv=none; b=b4fh49JVGuegDqFb6EHlw1CUeMo0Z/hNLSpL9o9lk5JZR64kbbUr2DPtYKxElR9l3NxmoHdPkXnAg/bSGu5cNM7+EwPA5zDFaTfAyhU2g/Cvv3msQZ2o4/k6ejZynyEEHXvCLiM0QPRnSRcgTQ6ffxax3xjVzGTWlbj5CgWD1ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681419; c=relaxed/simple;
	bh=xNvpHZWuLTFXifz2OTwSBTgpatv1/x92dWcx9K1NRUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cSdFTTXJwuekjF+QhkBLDpKyMDvIhOmpgxcBFX9n6vFdACIj5+7acgEE8aQTqRTNTxvzoS/3eF+NRpGHihdKEALgQ0ujumO1GNAkhBrbiD1GgSkkE+yLY6bTWlA+6v55EMxEuBDW+t4QYH85dWMW3n16BqTexj/Q8KyzNZcpr3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gGk4lYbl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGk4lYbl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780681406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cS4LK8y+wuXywD2/Nv3NzFYo7N64GVpkm4CNJMS1g3g=;
	b=gGk4lYbluypnZy6X4iSS24KAtFuC+vTVtK/cIaDsSLComDz0Fb8rWja4b3tXGRio2sLZGt
	pPk0gWNZgFpH7UdgROW8gvjyUssGewEOqXshTgmvTBe5D9/QVT1iLmqkBFbMlZYgJ4uqVO
	VXotDsSXDkuBte2GZoQxswlf7/IeqoI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-40Le8WRaNu2XsAufgVGBWg-1; Fri, 05 Jun 2026 13:43:24 -0400
X-MC-Unique: 40Le8WRaNu2XsAufgVGBWg-1
X-Mimecast-MFC-AGG-ID: 40Le8WRaNu2XsAufgVGBWg_1780681403
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490b3ec3f7fso15246935e9.1
        for <virtualization@lists.linux.dev>; Fri, 05 Jun 2026 10:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780681403; x=1781286203;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cS4LK8y+wuXywD2/Nv3NzFYo7N64GVpkm4CNJMS1g3g=;
        b=dejIpVb8XYPglstOLUPRWd6ddxNi/FOsHVtaWdIVmg6a4RABtIFKsYMPAmMS/w9Z5w
         B+V+navrc3z20/VtZoW5qdCbePPQg8Ap30kAxAoeuxgkiuB698Yp3CikKndLR/sbaiGR
         f2weQFFvuQb0AXW0rfWuKwplrZ+0Hz7h9Bkv5vPSsgX68putGEodf6lBg3AuEkkORI1c
         OtyAWqro/6irzyn7HfykahNEXczCrgyM/6Kw1QTaSDpv5s6Zm7yXOjCmhtJE5UI/bjFu
         SnVavUYLxTOBhuJJmDd2+Cg51rShYGbIyGf0f6IAiYTfHo2/sTBdnSZs+e5wANPRzv5e
         Swlg==
X-Forwarded-Encrypted: i=1; AFNElJ8BMDMWhtDBNdO9au2CHzQrIHmXeneTYoUV/eAqtjJwIpOOuiD4kgNuSwJX5hHScDLqWEHwp1imAUYzUbPyDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz20aP2TIQP073Eu8VqhRTbuPPTgnAxVnSM1KPksWPKx1D+ip37
	zXS1jkhBObBTfbgOhnCw7pm+/zlZJXn55hO9boHdwNDRNA6evWqs1cs5kxtd4/mkIyFSwa6VoTb
	pdpxrUHAn1bq74/gINPs8BCuxB0F8RYs5mSYWTqG5q1J7GsHDHmJBFrLaldg2Cktpo1m+
X-Gm-Gg: Acq92OHcgWSkv98AJCsX3N5L+mquLZ6vpg0xnnstmcQcabZEYDj9b99fBHmLv0+SyfT
	ARaral7Zh9s55X9HGUE1MjMDIN7xdldjhU3vfD5fUHUqnKKhFnLnsLIKBouwh3cQW+ELrEJVHAh
	TpPMNQxhXYjXxrBKJd6EKszbR6FNy9F+SGyAP2pT5Oe7meBbw1LAQj9ax2EVrjNkJN3f6ipv06c
	RMr+O9wt/wrdL00LCa3pehzhlyoYhwogTDFHlaIETx5c6JAKBFoMjsiryUFZogj34TgFW2G3t/y
	czBkYbdAsTyInMwJWi61l5VMbR3vYUPooQNkFEAd3cYnXsTPn1XDV0m4YuyDss0CyR95YHPv25d
	hrj9W4MVmW7Gvleg1TEwjwSO6GF0tk1urF3d0D5i4WeS3UBY/u8DbA6o=
X-Received: by 2002:a05:600c:1394:b0:490:b0f1:c27e with SMTP id 5b1f17b1804b1-490c25f1ad2mr81592855e9.24.1780681402792;
        Fri, 05 Jun 2026 10:43:22 -0700 (PDT)
X-Received: by 2002:a05:600c:1394:b0:490:b0f1:c27e with SMTP id 5b1f17b1804b1-490c25f1ad2mr81592195e9.24.1780681402265;
        Fri, 05 Jun 2026 10:43:22 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fd502sm168343035e9.11.2026.06.05.10.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 10:43:21 -0700 (PDT)
Date: Fri, 5 Jun 2026 13:43:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
	yangjiale <yangjiale133@163.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew.Boyer@amd.com
Subject: Re: [PATCH] VIRTIO: Update the desc 'flag' fied last in packed ring.
Message-ID: <20260605134252-mutt-send-email-mst@kernel.org>
References: <20260602043123.10207-1-yangjiale133@163.com>
 <CAJaqyWfugEttrQuR5_LrbQaivAqCaixsprUOjEVtdiz_sexFpA@mail.gmail.com>
 <6035a8f3-e225-45b0-9f48-55de953bff15@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6035a8f3-e225-45b0-9f48-55de953bff15@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fSzoF85aAx2LNGGSKPTaZv8GpLCkhVl0Dmo1RiMEc5U_1780681403
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jun 05, 2026 at 09:03:36AM -0700, Si-Wei Liu wrote:
> 
> 
> On 6/1/2026 11:04 PM, Eugenio Perez Martin wrote:
> > On Tue, Jun 2, 2026 at 6:34 AM yangjiale <yangjiale133@163.com> wrote:
> > > When a descriptor list spans across cache lines,
> > > updating the flag first can lead to a scenario where the device side
> > > perceives the flag as valid, yet the corresponding address and length
> > > fields remain unupdated—resulting in invalid values.
> > > Therefore, the flag field must be updated last.
> > > 
> > > Signed-off-by: yangjiale <yangjiale133@163.com>
> > > ---
> > >   drivers/virtio/virtio_ring.c | 8 ++++----
> > >   1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index fbca7ce1c6bf..036b4f90d30f 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -1688,6 +1688,10 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
> > >                                               &addr, &len, premapped, attr))
> > >                                  goto unmap_release;
> > > 
> > > +                       desc[i].addr = cpu_to_le64(addr);
> > > +                       desc[i].len = cpu_to_le32(len);
> > > +                       desc[i].id = cpu_to_le16(id);
> > > +
> > >                          flags = cpu_to_le16(vq->packed.avail_used_flags |
> > >                                      (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
> > >                                      (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
> > > @@ -1696,10 +1700,6 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
> > >                          else
> > >                                  desc[i].flags = flags;
> > > 
> > > -                       desc[i].addr = cpu_to_le64(addr);
> > > -                       desc[i].len = cpu_to_le32(len);
> > > -                       desc[i].id = cpu_to_le16(id);
> > > -
> > >                          if (unlikely(vq->use_map_api)) {
> > >                                  vq->packed.desc_extra[curr].addr = premapped ?
> > >                                          DMA_MAPPING_ERROR : addr;
> > These flags are updated before the flags of the head descriptor at the
> > end of the function, at "vq->packed.vring.desc[head].flags =
> > head_flags", so the device should not see these. Because of that, the
> > relative order between the rest of the fields of the same descriptor
> > or other descriptors' fields, except for the head descriptor's flags,
> > should not matter. There is a write memory barrier just before
> > updating the head's flags.
> The above analysis is absolutely correct. Though one hardware vendor told me
> that this driver implementation kinda stops them from reading ahead of
> descriptors already posted beyond the available index., ending up with
> suboptimal performance that is hard to make up by other means. Would it be a
> bad idea to go with this change and add write barrier in a gentle way for a
> small flit in the batch, e.g. commit to memory after every cache line size
> worth of descriptors are posted? Would the memory barrier have negative
> performance overhead to other backend implementation variants than real
> hardware PCI device?
> 
> -Siwei

this would need a new feature bit, won't it?

> > 
> > Also, I don't get why the cache line matters here. Can you expand? Am
> > I missing something?
> 

me too.

