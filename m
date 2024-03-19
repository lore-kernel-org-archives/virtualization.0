Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998314595A
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 06:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710828658; cv=none; b=WYiAdK2MSsmqpu0ZD7xOmInU4eJXdlK6l0ROsQiHQcVUBSBLZxCRilghJ2zk4uVMAcajyfVCxAGa337zJ/yxg7VsUrqKAlAVRU9U5wgIY4742T/1wLbs7d1SrMKi3+ryy+iS3glVv3ctzbLRQUs0sEXr0HWV2YIradR6aH+PE4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710828658; c=relaxed/simple;
	bh=DSgRF3NOJJSXwxPevctd1hwrhQzT0H19mpGBvc38K0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=g4vjBDqqtKhn49g/YurOd7R5MoQKFN8jm2FKfbDuOoAERTnrbHLx1cOjBNinYNHpxsTWdtSdVl7xPM8w1YVPCCXZ0m9ymtofEPU3OgH5fd3cJaypJ8rGdc2PhmmYJSNeIuakt09mn0zpciecNrFPFu1eJWSGDwSqvxvCS+wkEmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNuqtdbx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNuqtdbx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710828655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nQM06Led4nBkY/5H4TAdx3L4rBMTREUu3N4cA/nbU7E=;
	b=aNuqtdbxgKM5ZhdJIBGpLe6634ab+bbjtil40kyuOBMGlE3o9ibfxIT4z9o1EmtgqFroAw
	6Kc2uYq5j2In6ERoDet5z698xeCJOblXzyFhLdu2RT/AvHE2T0qbllWukMlM/Eu/RhEmqM
	cwehoI/QGsRBQ37lPXrHRrXX/4lNUAo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-xREdikawP_qTYhpl0XyaGA-1; Tue, 19 Mar 2024 02:10:54 -0400
X-MC-Unique: xREdikawP_qTYhpl0XyaGA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a467a6d4e3eso239487866b.3
        for <virtualization@lists.linux.dev>; Mon, 18 Mar 2024 23:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710828653; x=1711433453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQM06Led4nBkY/5H4TAdx3L4rBMTREUu3N4cA/nbU7E=;
        b=xCSHwfMJ6lEl7GNjgZHdGszX3Ei56i1eFfb4GOyE+nSAJzmEsNXxsUIrFzLMcQXURK
         gSQIVRYEw0l6pjHGnR0HrF0RzAfGrbw+eG1FfHj5lHwt3FDE0/H5Vs+sOBEWZcqCIaOs
         xHW8WWxYtTRnMAyVnJE7DZyj4A0d6E5ZdPbMGLi0vigmaYfvWETGJ9tJFCiODdC2CaVz
         UAx8q0oGN4lZUb/T/Zqt9km77JhCZMCoj9MJAt+/t+HxlC3IXVoQ4O0/qcTVFIZpTvVc
         67MamE05cZmJmaQU+/NUmlmGmk0lPR7sMHqSu4BTVAo39Gm0/xlrLKticEJ8CfRXLPJt
         ZNlw==
X-Forwarded-Encrypted: i=1; AJvYcCXK72slUzUPe/MyhRPB1SNO584B1V43Ljkvx0b2iEnxAH6y76JOn6rtg5F/ikYgiMwxUg/c3F5SgmwQxs/fp8yFDo9cisqvwtf+r1rfmIc=
X-Gm-Message-State: AOJu0YzJ8zPLoDgLE/cy4+SM5+wLEn3mssjRJdNHcrCDvDwzOmjhPvtk
	BdJV9yc0VFt7Lcsvtc1IP3zGDfmNonWIWJ9iiu0Nfh3LwUaxt6ep7YHdInTY30OSnC/ixuh2Zok
	u2Vm47VtT9s7IsFGt1oeYYBqKKt8fJ6Ntj3+p0QEGtGwFp3n3gERAqzWRF9bJNMsJ
X-Received: by 2002:a17:906:6957:b0:a46:cee9:e412 with SMTP id c23-20020a170906695700b00a46cee9e412mr827859ejs.15.1710828652666;
        Mon, 18 Mar 2024 23:10:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+MZG1/sLvxBhr5KequJbrCjOwJU37GUr6rBcMvanUONXVGNXLhisuE9UAu2p9rEbzTXvgrw==
X-Received: by 2002:a17:906:6957:b0:a46:cee9:e412 with SMTP id c23-20020a170906695700b00a46cee9e412mr827846ejs.15.1710828652054;
        Mon, 18 Mar 2024 23:10:52 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:ca2b:adb0:2501:10a9:c4b2])
        by smtp.gmail.com with ESMTPSA id hj11-20020a170906874b00b00a46a04d7daesm3709896ejb.115.2024.03.18.23.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 23:10:51 -0700 (PDT)
Date: Tue, 19 Mar 2024 02:10:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Will Deacon <will@kernel.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240319020949-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319020905-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240319020905-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 19, 2024 at 02:09:34AM -0400, Michael S. Tsirkin wrote:
> On Tue, Mar 19, 2024 at 02:59:23PM +1000, Gavin Shan wrote:
> > On 3/19/24 02:59, Will Deacon wrote:
> > > On Thu, Mar 14, 2024 at 05:49:23PM +1000, Gavin Shan wrote:
> > > > The issue is reported by Yihuang Yu who have 'netperf' test on
> > > > NVidia's grace-grace and grace-hopper machines. The 'netperf'
> > > > client is started in the VM hosted by grace-hopper machine,
> > > > while the 'netperf' server is running on grace-grace machine.
> > > > 
> > > > The VM is started with virtio-net and vhost has been enabled.
> > > > We observe a error message spew from VM and then soft-lockup
> > > > report. The error message indicates the data associated with
> > > > the descriptor (index: 135) has been released, and the queue
> > > > is marked as broken. It eventually leads to the endless effort
> > > > to fetch free buffer (skb) in drivers/net/virtio_net.c::start_xmit()
> > > > and soft-lockup. The stale index 135 is fetched from the available
> > > > ring and published to the used ring by vhost, meaning we have
> > > > disordred write to the available ring element and available index.
> > > > 
> > > >    /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64              \
> > > >    -accel kvm -machine virt,gic-version=host                            \
> > > >       :                                                                 \
> > > >    -netdev tap,id=vnet0,vhost=on                                        \
> > > >    -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0 \
> > > > 
> > > >    [   19.993158] virtio_net virtio1: output.0:id 135 is not a head!
> > > > 
> > > > Fix the issue by replacing virtio_wmb(vq->weak_barriers) with stronger
> > > > virtio_mb(false), equivalent to replaced 'dmb' by 'dsb' instruction on
> > > > ARM64. It should work for other architectures, but performance loss is
> > > > expected.
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Reported-by: Yihuang Yu <yihyu@redhat.com>
> > > > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > > > ---
> > > >   drivers/virtio/virtio_ring.c | 12 +++++++++---
> > > >   1 file changed, 9 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > index 49299b1f9ec7..7d852811c912 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > >   	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > > >   	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > > -	/* Descriptors and available array need to be set before we expose the
> > > > -	 * new available array entries. */
> > > > -	virtio_wmb(vq->weak_barriers);
> > > > +	/*
> > > > +	 * Descriptors and available array need to be set before we expose
> > > > +	 * the new available array entries. virtio_wmb() should be enough
> > > > +	 * to ensuere the order theoretically. However, a stronger barrier
> > > > +	 * is needed by ARM64. Otherwise, the stale data can be observed
> > > > +	 * by the host (vhost). A stronger barrier should work for other
> > > > +	 * architectures, but performance loss is expected.
> > > > +	 */
> > > > +	virtio_mb(false);
> > > >   	vq->split.avail_idx_shadow++;
> > > >   	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > > >   						vq->split.avail_idx_shadow);
> > > 
> > > Replacing a DMB with a DSB is _very_ unlikely to be the correct solution
> > > here, especially when ordering accesses to coherent memory.
> > > 
> > > In practice, either the larger timing different from the DSB or the fact
> > > that you're going from a Store->Store barrier to a full barrier is what
> > > makes things "work" for you. Have you tried, for example, a DMB SY
> > > (e.g. via __smb_mb()).
> > > 
> > > We definitely shouldn't take changes like this without a proper
> > > explanation of what is going on.
> > > 
> > 
> > Thanks for your comments, Will.
> > 
> > Yes, DMB should work for us. However, it seems this instruction has issues on
> > NVidia's grace-hopper. It's hard for me to understand how DMB and DSB works
> > from hardware level. I agree it's not the solution to replace DMB with DSB
> > before we fully understand the root cause.
> > 
> > I tried the possible replacement like below. __smp_mb() can avoid the issue like
> > __mb() does. __ndelay(10) can avoid the issue, but __ndelay(9) doesn't.
> > 
> > static inline int virtqueue_add_split(struct virtqueue *_vq, ...)
> > {
> >     :
> >         /* Put entry in available array (but don't update avail->idx until they
> >          * do sync). */
> >         avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> >         vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > 
> >         /* Descriptors and available array need to be set before we expose the
> >          * new available array entries. */
> >         // Broken: virtio_wmb(vq->weak_barriers);
> >         // Broken: __dma_mb();
> >         // Work:   __mb();
> >         // Work:   __smp_mb();

Did you try __smp_wmb ? And wmb?

> >         // Work:   __ndelay(100);
> >         // Work:   __ndelay(10);
> >         // Broken: __ndelay(9);
> > 
> >        vq->split.avail_idx_shadow++;
> >         vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> >                                                 vq->split.avail_idx_shadow);
> 
> What if you stick __ndelay here?

And keep virtio_wmb above?

> 
> >         vq->num_added++;
> > 
> >         pr_debug("Added buffer head %i to %p\n", head, vq);
> >         END_USE(vq);
> >         :
> > }
> > 
> > I also tried to measure the consumed time for various barrier-relative instructions using
> > ktime_get_ns() which should have consumed most of the time. __smb_mb() is slower than
> > __smp_wmb() but faster than __mb()
> > 
> >     Instruction           Range of used time in ns
> >     ----------------------------------------------
> >     __smp_wmb()           [32  1128032]
> >     __smp_mb()            [32  1160096]
> >     __mb()                [32  1162496]
> > 
> > Thanks,
> > Gavin

