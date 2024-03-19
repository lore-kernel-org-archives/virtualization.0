Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8383450A80
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710832163; cv=none; b=AJ3OBRynGrnVpISEp1Zfe6bBFSoHGkwUQb6d46x8Lm83h9DFhEe0qvkEdhC0TATIj/HfVSh/DPDi6P4SYrDOe8QeEVckMIZ42UhBpSTizeBJJZVQtE+7gdGLTKTwuu5jiiqOA6rk0MpfAOxtIHu4BNn5k2IepOR2CmEnR3w4uRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710832163; c=relaxed/simple;
	bh=FLoIyBRGJQiEioa9cqG2KHqpVvAbYebojTLuuVqIwos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DmXBjA2Na52ghKXvaUs4nGXMnXl4yKA1YezS3+VQaw9boN6VFQ0tpyvrGVw39CuKLT3SiGzdnF6VAssJPRQZwgnTWxkG7bNC1nhrLTrOVRMoFvKD0tOdXtoz6Xyzucv1IF1IPcI/NyLvQxrJ5NXWp8iKEYbAa9Dpzom5xiJDiqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jVuqAWSZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVuqAWSZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710832160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zT5XIluDKuwZj5aovG/lKBNWrNVrDtTPfyq+y1mF4wM=;
	b=jVuqAWSZxSFXOHGlVRRQyzad0ScYzsgKI6UM9cbw6Y2Edklsu2hE4xE5BWNM1T0rVQxHAu
	YCXJ4NgYaabcSSGU9Mymnd5LyrzKA6z4dxjXvUXkitMCUbyJtxwOWD+xVPI8fdzC825lLU
	F6unFkevIXqxnpUaSD1apX/kZKxxesw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-pNuqlsXaNLWqMfvsFnPnxw-1; Tue, 19 Mar 2024 03:09:17 -0400
X-MC-Unique: pNuqlsXaNLWqMfvsFnPnxw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41463916b89so2515175e9.0
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 00:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710832156; x=1711436956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zT5XIluDKuwZj5aovG/lKBNWrNVrDtTPfyq+y1mF4wM=;
        b=HsunsGtE2UCXQq58R5SOlEV5lRIW1UE0oYTYAnxnTMBmJzCJ44kcVUi4bB2DH7t8o2
         AnItuQKJvYaUWRmzXLgp7Ga2Su/8lNZaWmUnIHkexq+deizPBlaARXJdGBy2SKEXjRSa
         bR9L4x4z+o+JrbkccXb5IM3VJZ/MpMz3DlxF7ekfV9oES2lmefmrGALiOhMshIDek5lS
         +bZikkd0IGcVe5o3Sai4r3UXKsntGumaHmPnNkBHmixJxMtD3tXBAFeShiVTs0QlaGNt
         U9M3MV0dUhJ4ey7BvmJUKMRMbeJN/VY0laQ53/SCwx+V/Zd8h4MHyl/LnmAlUp5loJhL
         je9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDebV7IdT4pJX4f5I8QAzIHg8QAsIekSvnmIPJuSKVXAADsyn0xuZNvRN/fzfCbvrPHBuwYqwKWjNDY1GqJIllSRLEKdFPx+sNLeHPPLY=
X-Gm-Message-State: AOJu0YwRwDeeXUBWbbkk90Gl7hH2dJIh20FtoNtX9sOsxNgCKVywdE3/
	WzfvOGUWDkbVWirSaDJ7Doeiz92cMdDRxvgWLLH8aniCw4zI6mg9FqkX9EpZdFGLW6K0Rq8ZJSI
	RN988G74MKmNDMF64VaU7zdBwqfij9ou/NsRWD+VX6JCQQBLPQObeR0RPrfcYftQI
X-Received: by 2002:a05:600c:1992:b0:414:c48:a90 with SMTP id t18-20020a05600c199200b004140c480a90mr4724908wmq.24.1710832155706;
        Tue, 19 Mar 2024 00:09:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHDd1e5i+6nIXQVJmoCwZObgsVI5MrcBSNZUIgRWA3ZiIW85NGxpS9xlncJTrr6vt2SlbA4w==
X-Received: by 2002:a05:600c:1992:b0:414:c48:a90 with SMTP id t18-20020a05600c199200b004140c480a90mr4724883wmq.24.1710832155128;
        Tue, 19 Mar 2024 00:09:15 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c501400b00414112a6159sm5165943wmr.44.2024.03.19.00.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 00:09:14 -0700 (PDT)
Date: Tue, 19 Mar 2024 03:09:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Will Deacon <will@kernel.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240319030505-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319020905-mutt-send-email-mst@kernel.org>
 <9b3030d1-cb2c-4ce0-8b24-1074b616fc84@redhat.com>
 <20240319024025-mutt-send-email-mst@kernel.org>
 <d8387677-7025-4daa-b8b5-5a8f24a671d5@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d8387677-7025-4daa-b8b5-5a8f24a671d5@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 19, 2024 at 04:49:50PM +1000, Gavin Shan wrote:
> 
> On 3/19/24 16:43, Michael S. Tsirkin wrote:
> > On Tue, Mar 19, 2024 at 04:38:49PM +1000, Gavin Shan wrote:
> > > On 3/19/24 16:09, Michael S. Tsirkin wrote:
> > > 
> > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > > index 49299b1f9ec7..7d852811c912 100644
> > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > > > > >     	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > > > > > >     	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > > > > > -	/* Descriptors and available array need to be set before we expose the
> > > > > > > -	 * new available array entries. */
> > > > > > > -	virtio_wmb(vq->weak_barriers);
> > > > > > > +	/*
> > > > > > > +	 * Descriptors and available array need to be set before we expose
> > > > > > > +	 * the new available array entries. virtio_wmb() should be enough
> > > > > > > +	 * to ensuere the order theoretically. However, a stronger barrier
> > > > > > > +	 * is needed by ARM64. Otherwise, the stale data can be observed
> > > > > > > +	 * by the host (vhost). A stronger barrier should work for other
> > > > > > > +	 * architectures, but performance loss is expected.
> > > > > > > +	 */
> > > > > > > +	virtio_mb(false);
> > > > > > >     	vq->split.avail_idx_shadow++;
> > > > > > >     	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > > > > > >     						vq->split.avail_idx_shadow);
> > > > > > 
> > > > > > Replacing a DMB with a DSB is _very_ unlikely to be the correct solution
> > > > > > here, especially when ordering accesses to coherent memory.
> > > > > > 
> > > > > > In practice, either the larger timing different from the DSB or the fact
> > > > > > that you're going from a Store->Store barrier to a full barrier is what
> > > > > > makes things "work" for you. Have you tried, for example, a DMB SY
> > > > > > (e.g. via __smb_mb()).
> > > > > > 
> > > > > > We definitely shouldn't take changes like this without a proper
> > > > > > explanation of what is going on.
> > > > > > 
> > > > > 
> > > > > Thanks for your comments, Will.
> > > > > 
> > > > > Yes, DMB should work for us. However, it seems this instruction has issues on
> > > > > NVidia's grace-hopper. It's hard for me to understand how DMB and DSB works
> > > > > from hardware level. I agree it's not the solution to replace DMB with DSB
> > > > > before we fully understand the root cause.
> > > > > 
> > > > > I tried the possible replacement like below. __smp_mb() can avoid the issue like
> > > > > __mb() does. __ndelay(10) can avoid the issue, but __ndelay(9) doesn't.
> > > > > 
> > > > > static inline int virtqueue_add_split(struct virtqueue *_vq, ...)
> > > > > {
> > > > >       :
> > > > >           /* Put entry in available array (but don't update avail->idx until they
> > > > >            * do sync). */
> > > > >           avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > > > >           vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > > > 
> > > > >           /* Descriptors and available array need to be set before we expose the
> > > > >            * new available array entries. */
> > > > >           // Broken: virtio_wmb(vq->weak_barriers);
> > > > >           // Broken: __dma_mb();
> > > > >           // Work:   __mb();
> > > > >           // Work:   __smp_mb();
> > > > >           // Work:   __ndelay(100);
> > > > >           // Work:   __ndelay(10);
> > > > >           // Broken: __ndelay(9);
> > > > > 
> > > > >          vq->split.avail_idx_shadow++;
> > > > >           vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > > > >                                                   vq->split.avail_idx_shadow);
> > > > 
> > > > What if you stick __ndelay here?
> > > > 
> > > 
> > >         /* Put entry in available array (but don't update avail->idx until they
> > >           * do sync). */
> > >          avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > >          vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > 
> > >          /* Descriptors and available array need to be set before we expose the
> > >           * new available array entries. */
> > >          virtio_wmb(vq->weak_barriers);
> > >          vq->split.avail_idx_shadow++;
> > >          vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > >                                                  vq->split.avail_idx_shadow);
> > >          /* Try __ndelay(x) here as Michael suggested
> > >           *
> > >           * Work:      __ndelay(200);    possiblly make it hard to reproduce
> > >           * Broken:    __ndelay(100);
> > >           * Broken:    __ndelay(20);
> > >           * Broken:    __ndelay(10);
> > >           */
> > >          __ndelay(200);
> > 
> > So we see that just changing the timing masks the race.
> > What are you using on the host side? vhost or qemu?
> > 
> 
> __ndelay(200) may make the issue harder to be reproduce as I understand.
> More delays here will give vhost relief, reducing the race.
> 
> The issue is only reproducible when vhost is turned on. Otherwise, we
> aren't able to hit the issue.
> 
>    -netdev tap,id=vnet0,vhost=true,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown \
>    -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0


Given it's vhost, it's also possible that the issue is host side.
I wonder what happens if we stick a delay or a stronger barrier
in vhost.c - either here:

        /* Make sure buffer is written before we update index. */
        smp_wmb();      


or here:

                /* Only get avail ring entries after they have been
                 * exposed by guest.
                 */
                smp_rmb();

?


> > > 
> > > > 
> > > > >           vq->num_added++;
> > > > > 
> > > > >           pr_debug("Added buffer head %i to %p\n", head, vq);
> > > > >           END_USE(vq);
> > > > >           :
> > > > > }
> > > > > 
> > > > > I also tried to measure the consumed time for various barrier-relative instructions using
> > > > > ktime_get_ns() which should have consumed most of the time. __smb_mb() is slower than
> > > > > __smp_wmb() but faster than __mb()
> > > > > 
> > > > >       Instruction           Range of used time in ns
> > > > >       ----------------------------------------------
> > > > >       __smp_wmb()           [32  1128032]
> > > > >       __smp_mb()            [32  1160096]
> > > > >       __mb()                [32  1162496]
> > > > > 
> 
> Thanks,
> Gavin

