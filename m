Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64806EB68
	for <virtualization@lists.linux.dev>; Thu, 14 Mar 2024 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710417031; cv=none; b=uQRJaU7Gyksw64rKzyHX9uj67GMz9wMh4w3Xw1UCO24QYHC8OsOgODiIy2Wj0CBbdaYAviwc+th86jy7vNosnVAf/DJ6M/FISGV7ttPK3w+gLWppNQdtzH5WtLqPEofHz0bnAw6X3xWhe2E1MKKSJQR1GzAjE/D6RoJg+lN4jaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710417031; c=relaxed/simple;
	bh=HKRn+9y+a3/rYvZ3ESCh1LVIrsTcWcf9pLYDRmbMyvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GNu/Ker3AuKDJiWl3/AjXzi3UEbD3H/DTHHRcDBv2a1s78nc9kHlpg47qUgW0X+SIsTZp08nC7WH+LWRVILmvh8DrrozmEDK+pEPX7Nq2iSlDzen9RSwW9gD6H3cD0Mx9FJEWaLAtLaLKqymUSVvBWvnsh7664zGR6j6kk6EVXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fPeaQu8L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPeaQu8L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710417028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O2unAqCq7zZuuI1ZYRAH4h5wote2AeO/niw40LSxCFo=;
	b=fPeaQu8LKzJiH+afz4kXkHx2FqUZiZ//7+wJkqO2rbnidbK5yRLBgQUpvsUXtYsFwonWzn
	nCxhPueaAU6Yo18JclL9Sf140qarsQf/k2kI4Ap8HJCrau46b6mxxkNyb1/jiF3xzWtXUL
	u9zh9kodNwNEhgeD6EFdQEqACpZv+38=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-M__WNL3qPVOn_YfSdNLB6A-1; Thu, 14 Mar 2024 07:50:27 -0400
X-MC-Unique: M__WNL3qPVOn_YfSdNLB6A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-412e79148d8so3801145e9.1
        for <virtualization@lists.linux.dev>; Thu, 14 Mar 2024 04:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710417025; x=1711021825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2unAqCq7zZuuI1ZYRAH4h5wote2AeO/niw40LSxCFo=;
        b=THQ7ow4vQluDnPzF857KnaumLf7YaZn2prmtSSQ00+ZGAJggE6swxtHENvP+3GfOn7
         3m+9O6tIUins4tpZHgY4hUvvasWgP4yDaUUsZfvZKEAd5seuR5dDmlFAtd4sFQpum5fW
         mjYrxaqWGtq0ifi8Wat2tfI8Ed0pAmtWL8A0afKVMGEiyagcxyQoaHsUathr7EOd2aRl
         dgenS4BOqZV5KVbQPER7IVm9EknvnqcJzJqc2DT2r8TH4oLwmzJ9fa0BGFbrtWIU4Vc4
         rkByCGrA/lJ3V4jw5c9d9qMBKvwFW2qQjguoLd35PGDuBpENphXf0bjbTJh7iBQQ9+O+
         YdEg==
X-Gm-Message-State: AOJu0Yyg7rg29J41R30WYHuydD3DN6lbvAuH+5u/g+nsh7eZ0gLk6Oe8
	xwsNj/Qq47G4g2wTAZv3C8xMVqg9C+q0hHDb0lsNdeLMo4Wli7Qy8TphRKE1krPNdINyG6KWB8y
	hzxX1wuS2qKtRRl6wO5DZnjxpgj91Z92Qw0a2WO7VBT59r8ztMbcvocWK2RxY6tSghMKSm697jF
	Y=
X-Received: by 2002:a05:600c:1c89:b0:413:1047:362f with SMTP id k9-20020a05600c1c8900b004131047362fmr1397174wms.30.1710417025085;
        Thu, 14 Mar 2024 04:50:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJLLDY0RyHbIH1gFJUzQ32Tf6XFj1+IC9BnOXJcgAK7I7BmfcwPWrV4fkL4c6OxDwa5aQ+0Q==
X-Received: by 2002:a05:600c:1c89:b0:413:1047:362f with SMTP id k9-20020a05600c1c8900b004131047362fmr1397136wms.30.1710417024344;
        Thu, 14 Mar 2024 04:50:24 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
        by smtp.gmail.com with ESMTPSA id z14-20020a05600c0a0e00b00413ebce316fsm2246588wmp.0.2024.03.14.04.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 04:50:23 -0700 (PDT)
Date: Thu, 14 Mar 2024 07:50:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240314074216-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240314040443-mutt-send-email-mst@kernel.org>
 <9b148de7-b687-4d10-b177-5608b8dc7046@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <9b148de7-b687-4d10-b177-5608b8dc7046@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 14, 2024 at 08:15:22PM +1000, Gavin Shan wrote:
> On 3/14/24 18:05, Michael S. Tsirkin wrote:
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
> > 
> > 
> > I don't get what is going on here. Any explanation why virtio_wmb is not
> > enough besides "it does not work"?
> > 
> 
> The change is replacing instruction "dmb" with "dsb". "dsb" is stronger barrier
> than "dmb" because "dsb" ensures that all memory accesses raised before this
> instruction is completed when the 'dsb' instruction completes. However, "dmb"
> doesn't guarantee the order of completion of the memory accesses.
>
> So 'vq->split.vring.avail->idx = cpu_to_virtio(_vq->vdev, vq->split.avail_idx_shadow)'
> can be completed before 'vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head)'.

Completed as observed by which CPU?
We have 2 writes that we want observed by another CPU in order.
So if CPU observes a new value of idx we want it to see
new value in ring.
This is standard use of smp_wmb()
How are these 2 writes different?

What DMB does, is that is seems to ensure that effects
of 'vq->split.vring.avail->idx = cpu_to_virtio(_vq->vdev, vq->split.avail_idx_shadow)'
are observed after effects of
'vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head)'.




> The stronger barrier 'dsb' ensures the completion order as we expected.
> 
>     virtio_wmb(true)         virt_mb(false)
>       virt_wmb                 mb
>         __smp_wmb               __mb
>           dmb(ishst)              dsb(sy)

First, why would you want a non smp barrier when you are
synchronizing with another CPU? This is what smp_ means ...


> Extraced from ARMv9 specificaton
> ================================
> The DMB instruction is a memory barrier instruction that ensures the relative
> order of memory accesses before the barrier with memory accesses after the
> barrier. The DMB instruction _does not_ ensure the completion of any of the
> memory accesses for which it ensures relative order.

Isn't this exactly what we need?

> A DSB instruction is a memory barrier that ensures that memory accesses that
> occur before the DSB instruction have __completed__ before the completion of
> the DSB instruction.

This seems appropriate for when you want to order things more
strongly. I do not get why it's necessary here.

> In doing this, it acts as a stronger barrier than a DMB
> and all ordering that is created by a DMB with specific options is also generated
> by a DSB with the same options.
> 
> > >   	vq->split.avail_idx_shadow++;
> > >   	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > >   						vq->split.avail_idx_shadow);
> > > -- 
> > > 2.44.0
> > 
> 
> Thanks,
> Gavin

