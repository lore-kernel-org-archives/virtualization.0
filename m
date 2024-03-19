Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FB04597B
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 06:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710828581; cv=none; b=Xkywt/irWxoivGq0GyKW6zjT6MBRqog9hcjs5itP5XuiEw6LFPGPWi/kW6koeq2SYJ6eyVSCjRFCld787vk8K9sZRPhfjdY68j9m0WqD/nElSSLTd1KvBQfcS2iiaUdl14R/NBFpSlNYC7xbO9zE1qtHHHZuCOZnJLMiKL3stvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710828581; c=relaxed/simple;
	bh=FaN2AkTW/1g3b49U2gJ5dKMIWrQenSLsL/3wj1y2eF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fi29e9o9yxTbYxs5GG26Etvyp9Q0hVq9oX/Nc5herEO9RwKbSZub8hUX3eWCi8xbkvkCbi1hURaasFWAzZ6Fy98E+bO+bF4QcrgVauN7WSuAZrTqH5BeIW1xhNp5ACEZ5vsPmG7nVsNltZtU5GSyby8771nKOVbjZPnl/3Zp9dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOQhMrRG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOQhMrRG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710828578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4gAjOoqwe4WiMjHGtvLfdIjhk3lra6uGlC6+BOty9fk=;
	b=UOQhMrRGq/914+C516h2/ozemiAdeOpflCdM4Uo5hkpu3uWYQJFi4uATTf1b6CQdlF0fhJ
	0H/MUZAhNd+i3fhz/REnLwjEQmEVTKIA1YZ42ze+Mqh3XtLz4PnQdHtqUa/UEt42++8mnT
	Msis52U8/IfJ1AC/svNxgwJFhKoJ4t4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404--hPORX74M_uXqkqXHZbcoQ-1; Tue, 19 Mar 2024 02:09:36 -0400
X-MC-Unique: -hPORX74M_uXqkqXHZbcoQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a469d3547c7so289159266b.0
        for <virtualization@lists.linux.dev>; Mon, 18 Mar 2024 23:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710828575; x=1711433375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gAjOoqwe4WiMjHGtvLfdIjhk3lra6uGlC6+BOty9fk=;
        b=J3BIPBObw3b5cyBpOJ0GAgd84KCIpGFhBqWp+4xPRrifLUPLO8TBI7rjbTyeDap/FL
         iJm6m8pzJwmLmzcz3vhi+G0F3XxrGAJ/vA33QGKcEPHpAVRYCWN9zYs+qh/0hQx6grNP
         4NZLxW7zfDRKHZM8ClzPG1ksjeefbHQJEcqrrG0smlkjbRPcUbWiAhI7H/1HiotfQCzn
         82mOhNTnquRe/4xEFzIOXHUuyxykm7BTte2Qms4+PCEodCXJ+9NmgxbyvIEgUFH1rZwG
         0FNeQHsSX4vWmoTrCQFkBKoGXjVrRjZd8dROc7ql1kMJdXYN/fFTMByEgYFGJsKp5c8z
         CEKA==
X-Forwarded-Encrypted: i=1; AJvYcCUl2b4ut5Y5uAE/+aq4lYzuwZNvu3csdSzCxzuj+9EanO3FQSZy6PB3W0AEx98fsfU/HlihYHnPXl0zRXsuXhwwM8CWeU5IkLZ5P+5ZdFA=
X-Gm-Message-State: AOJu0YzzbJTEcFA/YpwaM3BGfiRiS+7HXITaEtDGmPwpaOKWLJRHQ9gR
	acSF5In5Kx/2/zw2YPuIbnu7SVruCLI3NAHA/LKx1mTTIIQZ2MeIFvbkdxTK1otf8B0e0RRs+pf
	WzsXuBrN1uwnW+PbUI7c9IPSpOr9DdysJElj2KCBqL0AVJvt2HUZSO6q9d4QXRmnC
X-Received: by 2002:a17:906:124b:b0:a46:ba8f:bcdc with SMTP id u11-20020a170906124b00b00a46ba8fbcdcmr1669822eja.8.1710828574827;
        Mon, 18 Mar 2024 23:09:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw2+yzvjo1VeEiJREnOUKPOQ5D+EoiV8KYmOyYmQdeAA6iIav3ruMjKj36kIfnfcmj2dr5aA==
X-Received: by 2002:a17:906:124b:b0:a46:ba8f:bcdc with SMTP id u11-20020a170906124b00b00a46ba8fbcdcmr1669795eja.8.1710828574200;
        Mon, 18 Mar 2024 23:09:34 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:ca2b:adb0:2501:10a9:c4b2])
        by smtp.gmail.com with ESMTPSA id d10-20020a1709067f0a00b00a413d1eda4bsm5647087ejr.87.2024.03.18.23.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 23:09:33 -0700 (PDT)
Date: Tue, 19 Mar 2024 02:09:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Will Deacon <will@kernel.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240319020905-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 19, 2024 at 02:59:23PM +1000, Gavin Shan wrote:
> On 3/19/24 02:59, Will Deacon wrote:
> > On Thu, Mar 14, 2024 at 05:49:23PM +1000, Gavin Shan wrote:
> > > The issue is reported by Yihuang Yu who have 'netperf' test on
> > > NVidia's grace-grace and grace-hopper machines. The 'netperf'
> > > client is started in the VM hosted by grace-hopper machine,
> > > while the 'netperf' server is running on grace-grace machine.
> > > 
> > > The VM is started with virtio-net and vhost has been enabled.
> > > We observe a error message spew from VM and then soft-lockup
> > > report. The error message indicates the data associated with
> > > the descriptor (index: 135) has been released, and the queue
> > > is marked as broken. It eventually leads to the endless effort
> > > to fetch free buffer (skb) in drivers/net/virtio_net.c::start_xmit()
> > > and soft-lockup. The stale index 135 is fetched from the available
> > > ring and published to the used ring by vhost, meaning we have
> > > disordred write to the available ring element and available index.
> > > 
> > >    /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64              \
> > >    -accel kvm -machine virt,gic-version=host                            \
> > >       :                                                                 \
> > >    -netdev tap,id=vnet0,vhost=on                                        \
> > >    -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0 \
> > > 
> > >    [   19.993158] virtio_net virtio1: output.0:id 135 is not a head!
> > > 
> > > Fix the issue by replacing virtio_wmb(vq->weak_barriers) with stronger
> > > virtio_mb(false), equivalent to replaced 'dmb' by 'dsb' instruction on
> > > ARM64. It should work for other architectures, but performance loss is
> > > expected.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Yihuang Yu <yihyu@redhat.com>
> > > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > > ---
> > >   drivers/virtio/virtio_ring.c | 12 +++++++++---
> > >   1 file changed, 9 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 49299b1f9ec7..7d852811c912 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > >   	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > >   	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > -	/* Descriptors and available array need to be set before we expose the
> > > -	 * new available array entries. */
> > > -	virtio_wmb(vq->weak_barriers);
> > > +	/*
> > > +	 * Descriptors and available array need to be set before we expose
> > > +	 * the new available array entries. virtio_wmb() should be enough
> > > +	 * to ensuere the order theoretically. However, a stronger barrier
> > > +	 * is needed by ARM64. Otherwise, the stale data can be observed
> > > +	 * by the host (vhost). A stronger barrier should work for other
> > > +	 * architectures, but performance loss is expected.
> > > +	 */
> > > +	virtio_mb(false);
> > >   	vq->split.avail_idx_shadow++;
> > >   	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > >   						vq->split.avail_idx_shadow);
> > 
> > Replacing a DMB with a DSB is _very_ unlikely to be the correct solution
> > here, especially when ordering accesses to coherent memory.
> > 
> > In practice, either the larger timing different from the DSB or the fact
> > that you're going from a Store->Store barrier to a full barrier is what
> > makes things "work" for you. Have you tried, for example, a DMB SY
> > (e.g. via __smb_mb()).
> > 
> > We definitely shouldn't take changes like this without a proper
> > explanation of what is going on.
> > 
> 
> Thanks for your comments, Will.
> 
> Yes, DMB should work for us. However, it seems this instruction has issues on
> NVidia's grace-hopper. It's hard for me to understand how DMB and DSB works
> from hardware level. I agree it's not the solution to replace DMB with DSB
> before we fully understand the root cause.
> 
> I tried the possible replacement like below. __smp_mb() can avoid the issue like
> __mb() does. __ndelay(10) can avoid the issue, but __ndelay(9) doesn't.
> 
> static inline int virtqueue_add_split(struct virtqueue *_vq, ...)
> {
>     :
>         /* Put entry in available array (but don't update avail->idx until they
>          * do sync). */
>         avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>         vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> 
>         /* Descriptors and available array need to be set before we expose the
>          * new available array entries. */
>         // Broken: virtio_wmb(vq->weak_barriers);
>         // Broken: __dma_mb();
>         // Work:   __mb();
>         // Work:   __smp_mb();
>         // Work:   __ndelay(100);
>         // Work:   __ndelay(10);
>         // Broken: __ndelay(9);
> 
>        vq->split.avail_idx_shadow++;
>         vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>                                                 vq->split.avail_idx_shadow);

What if you stick __ndelay here?


>         vq->num_added++;
> 
>         pr_debug("Added buffer head %i to %p\n", head, vq);
>         END_USE(vq);
>         :
> }
> 
> I also tried to measure the consumed time for various barrier-relative instructions using
> ktime_get_ns() which should have consumed most of the time. __smb_mb() is slower than
> __smp_wmb() but faster than __mb()
> 
>     Instruction           Range of used time in ns
>     ----------------------------------------------
>     __smp_wmb()           [32  1128032]
>     __smp_mb()            [32  1160096]
>     __mb()                [32  1162496]
> 
> Thanks,
> Gavin

