Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD02651004
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710831905; cv=none; b=kjMF3yL+fYPc8nXPnNkxzQZ3B2CPjHrqFLOJk7gM6ZbAV4UFG2MHsSt6cwtUiJs8pdL7PVBK8/Iw0In5f9ygg29BevOORXEtQUg0RaDUYAwfI9BqyYoa6iYCjtlRbHACUAwHDFcz2rq5qIumEMfxUYIuFhE+gHMSi8eGpprgZLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710831905; c=relaxed/simple;
	bh=Ndfh/nh824nN5WcyANy2Uoh6V4Gixx5ZzpqNUelrwP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WLBnoCWASK5N5o1SrPENzjlWyNjtFxBp3dQ934lZpN7XK+8HwDnhmCjstOTF+0j+x1JvUlQL1smkPZMmVlkYu2YCxLKemlYTPE7nnkkEMuxNT8+HlVRc7U1CIOb17NeNagsb/22iUdQ6b/hBksJm6M2P1yqbQwzRocnD3U5tpUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NZ/LBBef; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZ/LBBef"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710831902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=msk7w1tinlaWzEk2KKg0h88gDmDQY/OKdF9U/8feTqI=;
	b=NZ/LBBef1NxzRlJwlf4O/37ybmvClMzqIWrUVcst3hkWddtcL0SXWX2K31N+/ykd1dyuPv
	bNCDYSFG+UkyuiOIslC1UykaiIwU7FaN0SrHXQFiubLJvzyYw0wJH3cmsZYCuTeKqwaf+N
	y9+Pr754ntqWeur45n0qyt8gvE3SXG4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-U_JN15QmPUGVATYDkPDqpw-1; Tue, 19 Mar 2024 03:05:01 -0400
X-MC-Unique: U_JN15QmPUGVATYDkPDqpw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41465603c0dso1745685e9.2
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 00:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710831900; x=1711436700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msk7w1tinlaWzEk2KKg0h88gDmDQY/OKdF9U/8feTqI=;
        b=mcRzpbgvIN6z0GMJR8fFB2aCqq7rThESUzF0z6RSn5l2I/oNnV3XT7m/HPBgWCTVoe
         eZVNPolEqxmKEEkM8tIV8YYNi0wFIUx8+bDgXiqFQXfaS1oUQyzzdH4Ziv/1+Zk7GQxG
         LP2mkzic6d+T7vHSbifGEpYNPy3tbKkWqfp7EEwVZhHXBQ26I/k9fzOPlt+m2403VQB6
         mptX9U4tgcNZnZvkptQD44/y9EAA6t0yDTu4//5pa7gmsv2krOPtsUktIHsTs7vT7HuE
         xQS93o8nzIOiksEDFumvp4odP2yTnDBk15z0vjvhs7+Jfa/lsaaScnDnuFteOeRGYMtV
         OZfw==
X-Forwarded-Encrypted: i=1; AJvYcCWDX7fHuhPo4+lSNNDVlZoxcTdx+hESDd5FCj61bC6kKnzKLo0AMvDFSPx631xpp6EwR5p7lY3ZRbt4zOynpQITnR6+SxKfsgMLvRArtLs=
X-Gm-Message-State: AOJu0YwfCvHCHRw2IHgG+sHQvj3pwXwopK5HqxtyYrovExlhh1H5JMc3
	L1zMDD60y6feDiJ7DqLZD1Goe90vLbx+LmYvESkLhktbargPQyDHfefKwyxrXmoASW88WfLy6Xo
	W7NwSdsvLLAgL2amprrVAnZDJ+vkKwUAly9SY6W/l7gV/ounlXa/9dfQIeU6ENUab
X-Received: by 2002:a05:600c:4eca:b0:414:1e0:2afa with SMTP id g10-20020a05600c4eca00b0041401e02afamr8358551wmq.3.1710831900148;
        Tue, 19 Mar 2024 00:05:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz4xz32UCYWB9lnqEcxFh5GXgSTBxzG1zltbsajW5LUv/qBjfGkKiOalU52s/Yd0zHsKkWFA==
X-Received: by 2002:a05:600c:4eca:b0:414:1e0:2afa with SMTP id g10-20020a05600c4eca00b0041401e02afamr8358522wmq.3.1710831899535;
        Tue, 19 Mar 2024 00:04:59 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b0041408af4b34sm9695750wmo.10.2024.03.19.00.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 00:04:59 -0700 (PDT)
Date: Tue, 19 Mar 2024 03:04:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Will Deacon <will@kernel.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240319030148-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319020905-mutt-send-email-mst@kernel.org>
 <20240319020949-mutt-send-email-mst@kernel.org>
 <6b829cfc-9cbe-42eb-9935-62d2cf5fbcc4@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6b829cfc-9cbe-42eb-9935-62d2cf5fbcc4@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 19, 2024 at 04:54:15PM +1000, Gavin Shan wrote:
> On 3/19/24 16:10, Michael S. Tsirkin wrote:
> > On Tue, Mar 19, 2024 at 02:09:34AM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Mar 19, 2024 at 02:59:23PM +1000, Gavin Shan wrote:
> > > > On 3/19/24 02:59, Will Deacon wrote:
> [...]
> > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > index 49299b1f9ec7..7d852811c912 100644
> > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > > > >    	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > > > > >    	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > > > > -	/* Descriptors and available array need to be set before we expose the
> > > > > > -	 * new available array entries. */
> > > > > > -	virtio_wmb(vq->weak_barriers);
> > > > > > +	/*
> > > > > > +	 * Descriptors and available array need to be set before we expose
> > > > > > +	 * the new available array entries. virtio_wmb() should be enough
> > > > > > +	 * to ensuere the order theoretically. However, a stronger barrier
> > > > > > +	 * is needed by ARM64. Otherwise, the stale data can be observed
> > > > > > +	 * by the host (vhost). A stronger barrier should work for other
> > > > > > +	 * architectures, but performance loss is expected.
> > > > > > +	 */
> > > > > > +	virtio_mb(false);
> > > > > >    	vq->split.avail_idx_shadow++;
> > > > > >    	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > > > > >    						vq->split.avail_idx_shadow);
> > > > > 
> > > > > Replacing a DMB with a DSB is _very_ unlikely to be the correct solution
> > > > > here, especially when ordering accesses to coherent memory.
> > > > > 
> > > > > In practice, either the larger timing different from the DSB or the fact
> > > > > that you're going from a Store->Store barrier to a full barrier is what
> > > > > makes things "work" for you. Have you tried, for example, a DMB SY
> > > > > (e.g. via __smb_mb()).
> > > > > 
> > > > > We definitely shouldn't take changes like this without a proper
> > > > > explanation of what is going on.
> > > > > 
> > > > 
> > > > Thanks for your comments, Will.
> > > > 
> > > > Yes, DMB should work for us. However, it seems this instruction has issues on
> > > > NVidia's grace-hopper. It's hard for me to understand how DMB and DSB works
> > > > from hardware level. I agree it's not the solution to replace DMB with DSB
> > > > before we fully understand the root cause.
> > > > 
> > > > I tried the possible replacement like below. __smp_mb() can avoid the issue like
> > > > __mb() does. __ndelay(10) can avoid the issue, but __ndelay(9) doesn't.
> > > > 
> > > > static inline int virtqueue_add_split(struct virtqueue *_vq, ...)
> > > > {
> > > >      :
> > > >          /* Put entry in available array (but don't update avail->idx until they
> > > >           * do sync). */
> > > >          avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > > >          vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > > 
> > > >          /* Descriptors and available array need to be set before we expose the
> > > >           * new available array entries. */
> > > >          // Broken: virtio_wmb(vq->weak_barriers);
> > > >          // Broken: __dma_mb();
> > > >          // Work:   __mb();
> > > >          // Work:   __smp_mb();
> > 
> > Did you try __smp_wmb ? And wmb?
> > 
> 
> virtio_wmb(false) is equivalent to __smb_wmb(), which is broken.
> 
> __wmb() works either. No issue found with it.

Oh interesting. So how do smp_mb() and wmb() disassemble on this
platform? Can you please check?


> > > >          // Work:   __ndelay(100);
> > > >          // Work:   __ndelay(10);
> > > >          // Broken: __ndelay(9);
> > > > 
> > > >         vq->split.avail_idx_shadow++;
> > > >          vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > > >                                                  vq->split.avail_idx_shadow);
> > > 
> > > What if you stick __ndelay here?
> > 
> > And keep virtio_wmb above?
> > 
> 
> The result has been shared through a separate reply.
> 
> > > 
> > > >          vq->num_added++;
> > > > 
> > > >          pr_debug("Added buffer head %i to %p\n", head, vq);
> > > >          END_USE(vq);
> > > >          :
> > > > }
> > > > 
> > > > I also tried to measure the consumed time for various barrier-relative instructions using
> > > > ktime_get_ns() which should have consumed most of the time. __smb_mb() is slower than
> > > > __smp_wmb() but faster than __mb()
> > > > 
> > > >      Instruction           Range of used time in ns
> > > >      ----------------------------------------------
> > > >      __smp_wmb()           [32  1128032]
> > > >      __smp_mb()            [32  1160096]
> > > >      __mb()                [32  1162496]
> > > > 
> 
> Thanks,
> Gavin

