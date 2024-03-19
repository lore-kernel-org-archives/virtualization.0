Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199BB2628C
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 06:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830624; cv=none; b=YJR+XxH+zfa9+FFrGNUJn4zlap9hgjxri0NVyYhtXEajnFD+QwGdQ2TES+6rDFP8cnp0tV7jRPfLS2X7ZQphZYYwQ0SgFASNP1R4Koc0GPZl0SX2sYFTSp0iouvbb2HpRQwI4pTD8oRSXBrmeZ7RvHgMsfZHu/jgOk39XADGzpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830624; c=relaxed/simple;
	bh=T3mE/JcSP74FHv9QKgT14Tt0WuS2r9wz6NjhGQE/SNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BwT7kF3cmPs+IPd8Ac68Fa4SDxu5/6mgeGxKdKKHxIa8ky+fzHqNFmQkaSfwIM0LmIAuozMby4yoi3yS6S6C94Qy/rdI3H6GH0ZE6fpVuHLJzRL6gLgTDaF5Foiu0iEoxCp6pLPA7sGg5rfBz6sqtZQwlRSl9p+6bSeCeOUFMpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GjqkkDph; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjqkkDph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710830622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ohZmKZ+KwPhgcffK5N1nXKGEgL+2hzErlGYMYgMXGEk=;
	b=GjqkkDphCAUh8xy9PoOoSnanxjNSKNX5u9FQ2B0lHrM7wTBjYdeg7oDOQT1TCebRj4ZFkB
	tmFdPpq0cUJ1x3JjHZYUrrGS6vWqA+TIlMTxpvOx/Pz5o4h0u/Yynf5CrqvM75J1Kdx44/
	/7N6LYTQrY8qMIqhTCOYwehWFurnqy4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-xpPkOXsVOY-yGRYmA_YHHw-1; Tue, 19 Mar 2024 02:43:38 -0400
X-MC-Unique: xpPkOXsVOY-yGRYmA_YHHw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-56b8c7b4fe0so731154a12.0
        for <virtualization@lists.linux.dev>; Mon, 18 Mar 2024 23:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710830617; x=1711435417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohZmKZ+KwPhgcffK5N1nXKGEgL+2hzErlGYMYgMXGEk=;
        b=UL445AkaPH4Pm6P0bXPwbGLrFqqFKI4NiWaFYSEwY7jD7Je0arl4zUX6PY70eb0chm
         WldL62OD4fbTX3lG/fUlIqngDbyuEyOUPP9TB0TmMizwoe2OituzqjDxh06kcXZthBsC
         EG8wkulXLTXHG+dnXuUNRlfBA5Rxruq5pU05MKHu8ISW0iei0PgLraetK1Qx1ox/Jo7f
         gCuxWI77Q+tWCXZ9PlRl2xdRNC6t3I1H3UwahyFCEPKnP3tb5qp6JpLQ52wAc9/acTxI
         4TOushqaKjBSEnrTiJAT6Hi3URoYIRagjzTipO5TZaD8wM8JjZhUxHyJtwWsLVM0EOHD
         SXkA==
X-Forwarded-Encrypted: i=1; AJvYcCUcepS0sA6OWiPhYUdGqQpgyQJcGdkaRxXFvbbBq3uVTZPHQmX4dL8SGUr4JeElQRWoZ0IKSNUVip8YfQmP0iVGYvvpgRv49fdiTaVeQtA=
X-Gm-Message-State: AOJu0YybbAXqMAf7KDAYdx6OgYHKKCgJIRaUKy2CT1RYP3Y6MfmLzdxj
	vQCzWI3DFNjZ5xRw0fryo9q7LYRR+YUMbAfECmmSvMYxIeduCUgPOxCxp4+Od3c1nl3pYq1lHt8
	kpjQ27Oa9j98L5dcu9zDoPP+QxUzui1AAg27PvIjI9slFcsFTmg4q8S5/PVl0zwKd
X-Received: by 2002:a17:906:e59:b0:a46:d718:cd28 with SMTP id q25-20020a1709060e5900b00a46d718cd28mr883348eji.1.1710830617374;
        Mon, 18 Mar 2024 23:43:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY6fpppJjYVQwexsFjrflpwT3duw/rnvrhjmHgbJldVOFDzm08arBFsoQf3CjLD5TtwZ8LBQ==
X-Received: by 2002:a17:906:e59:b0:a46:d718:cd28 with SMTP id q25-20020a1709060e5900b00a46d718cd28mr883325eji.1.1710830616856;
        Mon, 18 Mar 2024 23:43:36 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:ca2b:adb0:2501:10a9:c4b2])
        by smtp.gmail.com with ESMTPSA id jx25-20020a170907761900b00a4503a78dd5sm5780529ejc.17.2024.03.18.23.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 23:43:36 -0700 (PDT)
Date: Tue, 19 Mar 2024 02:43:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Will Deacon <will@kernel.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240319024025-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319020905-mutt-send-email-mst@kernel.org>
 <9b3030d1-cb2c-4ce0-8b24-1074b616fc84@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <9b3030d1-cb2c-4ce0-8b24-1074b616fc84@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 19, 2024 at 04:38:49PM +1000, Gavin Shan wrote:
> On 3/19/24 16:09, Michael S. Tsirkin wrote:
> 
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > index 49299b1f9ec7..7d852811c912 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > > >    	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > > > >    	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > > > -	/* Descriptors and available array need to be set before we expose the
> > > > > -	 * new available array entries. */
> > > > > -	virtio_wmb(vq->weak_barriers);
> > > > > +	/*
> > > > > +	 * Descriptors and available array need to be set before we expose
> > > > > +	 * the new available array entries. virtio_wmb() should be enough
> > > > > +	 * to ensuere the order theoretically. However, a stronger barrier
> > > > > +	 * is needed by ARM64. Otherwise, the stale data can be observed
> > > > > +	 * by the host (vhost). A stronger barrier should work for other
> > > > > +	 * architectures, but performance loss is expected.
> > > > > +	 */
> > > > > +	virtio_mb(false);
> > > > >    	vq->split.avail_idx_shadow++;
> > > > >    	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > > > >    						vq->split.avail_idx_shadow);
> > > > 
> > > > Replacing a DMB with a DSB is _very_ unlikely to be the correct solution
> > > > here, especially when ordering accesses to coherent memory.
> > > > 
> > > > In practice, either the larger timing different from the DSB or the fact
> > > > that you're going from a Store->Store barrier to a full barrier is what
> > > > makes things "work" for you. Have you tried, for example, a DMB SY
> > > > (e.g. via __smb_mb()).
> > > > 
> > > > We definitely shouldn't take changes like this without a proper
> > > > explanation of what is going on.
> > > > 
> > > 
> > > Thanks for your comments, Will.
> > > 
> > > Yes, DMB should work for us. However, it seems this instruction has issues on
> > > NVidia's grace-hopper. It's hard for me to understand how DMB and DSB works
> > > from hardware level. I agree it's not the solution to replace DMB with DSB
> > > before we fully understand the root cause.
> > > 
> > > I tried the possible replacement like below. __smp_mb() can avoid the issue like
> > > __mb() does. __ndelay(10) can avoid the issue, but __ndelay(9) doesn't.
> > > 
> > > static inline int virtqueue_add_split(struct virtqueue *_vq, ...)
> > > {
> > >      :
> > >          /* Put entry in available array (but don't update avail->idx until they
> > >           * do sync). */
> > >          avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > >          vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > 
> > >          /* Descriptors and available array need to be set before we expose the
> > >           * new available array entries. */
> > >          // Broken: virtio_wmb(vq->weak_barriers);
> > >          // Broken: __dma_mb();
> > >          // Work:   __mb();
> > >          // Work:   __smp_mb();
> > >          // Work:   __ndelay(100);
> > >          // Work:   __ndelay(10);
> > >          // Broken: __ndelay(9);
> > > 
> > >         vq->split.avail_idx_shadow++;
> > >          vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > >                                                  vq->split.avail_idx_shadow);
> > 
> > What if you stick __ndelay here?
> > 
> 
>        /* Put entry in available array (but don't update avail->idx until they
>          * do sync). */
>         avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>         vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> 
>         /* Descriptors and available array need to be set before we expose the
>          * new available array entries. */
>         virtio_wmb(vq->weak_barriers);
>         vq->split.avail_idx_shadow++;
>         vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>                                                 vq->split.avail_idx_shadow);
>         /* Try __ndelay(x) here as Michael suggested
>          *
>          * Work:      __ndelay(200);    possiblly make it hard to reproduce
>          * Broken:    __ndelay(100);
>          * Broken:    __ndelay(20);
>          * Broken:    __ndelay(10);
>          */
>         __ndelay(200);

So we see that just changing the timing masks the race.
What are you using on the host side? vhost or qemu?

> 
> > 
> > >          vq->num_added++;
> > > 
> > >          pr_debug("Added buffer head %i to %p\n", head, vq);
> > >          END_USE(vq);
> > >          :
> > > }
> > > 
> > > I also tried to measure the consumed time for various barrier-relative instructions using
> > > ktime_get_ns() which should have consumed most of the time. __smb_mb() is slower than
> > > __smp_wmb() but faster than __mb()
> > > 
> > >      Instruction           Range of used time in ns
> > >      ----------------------------------------------
> > >      __smp_wmb()           [32  1128032]
> > >      __smp_mb()            [32  1160096]
> > >      __mb()                [32  1162496]
> > > 
> 
> Thanks,
> Gavin

