Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D37554673
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836900; cv=none; b=QYynnVr0YkvNNRGKd9aYBWpR9A90hZ6R4pLYgTevMOjkRqjLXbNOV2bIF4RYtj+i0uHyBXuLmX/AkiX7y1Eu5jKA876wCGMI747DwMWH+7cgkrn1Bj6L/INKtanA5Xh+dBQJYFhvtVDxtRl0NnUQnd3c5Hp6OqK9xvHDxu9mTb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836900; c=relaxed/simple;
	bh=+xJo6B2RUfy6w3seqt7BSg8FYfwp1yJGm7MHWDDAG1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XI8LMZnrJRFcUwevDvVvTod3IhrhOyD8RVvyZ9wMlzNWstmHlQzEArwveKt9jJrdrmFHRwdhbCByAbOmUK/us1A+1eSKIzGp0pn0L1oV6LoMrwhGozVBb3dMLd1WXREE8EffVnmon6vPnXI1GRE70gygIxLBo8JHp0fkS8iFKK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOTqT7qa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOTqT7qa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710836897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CB0QtuwNQuGoMD7qtCWhc1XdgMcxMk46b8pSVshJge8=;
	b=cOTqT7qaSGepXJF3QljK8EseOEuqBEG3ZmFqXlATQY269FqH1vN8RqEb3cCG73IJfyh/mJ
	uaPWr8pfbyq7DCcSLb2TDoIIeOuhfpohO21rfFG6uEYJYTIzE3lZnwIhiuZef8Zy83R8eP
	Q+AhvCtTo9NfaCekpE10+PNJiAL79Tk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-kCstqzqUMCCvgCIdvt1AIA-1; Tue, 19 Mar 2024 04:28:14 -0400
X-MC-Unique: kCstqzqUMCCvgCIdvt1AIA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4140225e68aso18808755e9.1
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 01:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710836893; x=1711441693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CB0QtuwNQuGoMD7qtCWhc1XdgMcxMk46b8pSVshJge8=;
        b=m75qNy5pi1+CDVCknt6ZAtJgMCrAVbhCdRrEqzEUU5tMPRM3yV70gO5s2o3IC2/bdj
         p5Hb3zDn7QMGS6m5tIY8UhBZqZhQvWfd6HHTKmvFpen91nkfR+Y79tQpMybtbwz98x4J
         dfmpDubGrLQX3tV+2hJGZgzhNFeu25W/WgM8DNYisZQmMGcVojTnKZBixWdKy/CwDqeW
         vsjUenu7PDTKqMA1EJXw4j2cS/3cRFczhDnnVgoTMMW6T3KiBh1WqO8XaORUFu/bHtbd
         JDIAayB4SpBlurjGYMku5v8O31LkkbFMeD/djzJwSXnWrKZPTSB30g0GP3u3QgR/1a8e
         VG8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRRHIPS8uaZgsGP/VUE5Ccft5YDpPe28C3jc6v9QWTlqlQBFXgUdwyaNjkJDLiwx4W2z/+SqNgn6hqB+ZSHyI87leB7loLT9h1m5b2ixs=
X-Gm-Message-State: AOJu0Yw3k7JCaMiC/7IG41+fxvW0yOl5L7wzZF5qKwZsjj4fr+g85Rmj
	3MiYkrU0O4h8H2RNYeEVSkNBwavLRWizYAM3GLsbNqXQQx1sclF/wWdF0hQXqtl+oYw5zLQinuP
	mjl+VDnCuSgXUU6riKgdJTG4GcGBO3eFS4CrFP/SuU4nPfXtwcWYecV+SsmwodKSY
X-Received: by 2002:a05:600c:358a:b0:414:22b5:c33a with SMTP id p10-20020a05600c358a00b0041422b5c33amr2168373wmq.1.1710836893033;
        Tue, 19 Mar 2024 01:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqzZ3RSqI5aruFYvzTdmxlY7UT5zKZE8Kju5PdfFuBjeOEHAE4vfQF7dVW+EegfweCjpcAiA==
X-Received: by 2002:a05:600c:358a:b0:414:22b5:c33a with SMTP id p10-20020a05600c358a00b0041422b5c33amr2168349wmq.1.1710836892497;
        Tue, 19 Mar 2024 01:28:12 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b0041408af4b34sm9936953wmo.10.2024.03.19.01.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 01:28:11 -0700 (PDT)
Date: Tue, 19 Mar 2024 04:28:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Will Deacon <will@kernel.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240319034110-mutt-send-email-mst@kernel.org>
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


> __wmb() works either. No issue found with it.

So this is 
arch/arm64/include/asm/barrier.h:#define __smp_wmb()    dmb(ishst)

versus

arch/arm64/include/asm/barrier.h:#define __wmb()                dsb(st)


right?

Really interesting. And you are saying dma_wmb does not work either:

arch/arm64/include/asm/barrier.h:#define __dma_wmb()    dmb(oshst)


Really strange.




However I found this:
https://developer.arm.com/documentation/den0024/a/Memory-Ordering/Memory-attributes/Cacheable-and-shareable-memory-attributes



Going by this picture, all CPUs are in the innner shareable domain so
ishst should be enough to synchronize, right?


However, there are two points that give me pause here:


Inner shareable
This represents a shareability domain that can be shared by multiple
processors, but not necessarily all of the agents in the system. A
system might have multiple Inner Shareable domains. An operation that
affects one Inner Shareable domain does not affect other Inner Shareable
domains in the system. An example of such a domain might be a quad-core
Cortex-A57 cluster.


Point 1 - so is it possible that there are multiple inner
shareable domains in this system? With vhost running
inside one and guest inside another? Anyone knows if that
is the case on nvidia grace hopper and how to find out?



Outer shareable
An outer shareable (OSH) domain re-order is shared by multiple agents and
can consist of one or more inner shareable domains. An operation that
affects an outer shareable domain also implicitly affects all inner
shareable domains inside it. However, it does not otherwise behave as an
inner shareable operation.


I do not get this last sentence. If it affects all inner domains then
how it "does not behave as an inner shareable operation"?






> 
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

