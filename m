Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C894597B
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 06:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710828876; cv=none; b=HmE/wpEJYVTVyOtPR460MVts8od5GwCTwVy+R9/u1MjV3KmyouV8iY0ujuTvOUBFaMDxkP5ggHSd4gjHpe2KPAwd70OAPg6bhiYNfYga+oWTxMRJfLf/Unym4rFLjvTwcWYHFFgNVKZ9UyMfYFZFAnfZg2V63cVIxBiSGSwbUXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710828876; c=relaxed/simple;
	bh=v2pKD6xIQbKNmcB1pUgXdy2M1Ktb7FP3Z2rqu9Hj1HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Mrxy+bxT3OfMv1o3l0jTgp89FeWchZKlAp7XOVg3frzIRSzG/KDrEgoLkNMYcAZUpy1AjLD+ec2NVHlNg7SP5k9EPKkvHbyzl5CbpPZm+hgEaqkeIjvK6tMUArFzb3rKobJjlVsHvGkwU8+F78O9gySoq8FHJXSPgP3D82gklAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EydbctBz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EydbctBz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710828874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nd2WnTQpqJ6t/rcAd5QrbY0+YyvvOiz3e4ifplxSCyk=;
	b=EydbctBz7AA1OfuJXclf1uafiXIRYeFHp4RC56HI8nX9ywR4+mENGIZpNGt4evOrVWfq0P
	SG4Rfgpc4XdPMsLVxsYdzEhcFPRoLAr3tGJIN1aq/AfLXeNAV1lWRai2ikZ63HQUvrg4bI
	G+hJY5mVHOGnwDoKcvj47TDsr9huLCU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-yIr8CjwANhK6A-kN_m5aKw-1; Tue, 19 Mar 2024 02:14:32 -0400
X-MC-Unique: yIr8CjwANhK6A-kN_m5aKw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a46b82df33cso133291266b.0
        for <virtualization@lists.linux.dev>; Mon, 18 Mar 2024 23:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710828871; x=1711433671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nd2WnTQpqJ6t/rcAd5QrbY0+YyvvOiz3e4ifplxSCyk=;
        b=bR/3tSpRO1fNnL/m5rp8uF/JJ0971oTKCOHh0avDhSynUUg1yJ4lLpRR3PTdUWsbAX
         Qwgk64rBcMyEtOjGFgZ48fs+2tvHJcGRR/oWLXRX0eEqLwCgLk2tqreCjdi75g6KmBbj
         RMMOFTWCzHZzWjaAR4DMPNoArndLEl482y+CMVGOPIF/rDRvqJ4I/wSEeFS6ob2Wljfs
         BTCaGLz73lyAhlZZPvTPweHVEKAVecDMXhEbX7SE2fvpZze56IfISse/0HntfPa/QmC2
         gg5mCY2m8zjYusfyWXr7UKaM0AEmtXA8imYJdmpFFZzGVJ1QARhoWG3nXW6VdYIbHC/A
         10EQ==
X-Gm-Message-State: AOJu0YxeeleHUkQ10eZfTiRHShN/kgIenbyyLGJQ5MyZxUub1yA4v62M
	1aR8CWmsZkcb0k307ErrUQGEAQ7TqJRsFpQjNMBI/ed6WAG7iUJzS9a5rDdHgt+6c4hswBoqJKg
	sOdFMtNAkYS7wCR6uPJOC4IpYBmFewZ2aFNQZubQsSN0/9zPzVJz8DsyUJsQqTxnR
X-Received: by 2002:a17:907:7a93:b0:a46:74fe:904f with SMTP id mm19-20020a1709077a9300b00a4674fe904fmr10682761ejc.26.1710828870985;
        Mon, 18 Mar 2024 23:14:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGo/SmdwOaw3x3Vaq0MJ5ceF64rXJYjddl/AfDh1pN5ip0sZk4YZOLeNTJ1ec6BERFY/yXtfQ==
X-Received: by 2002:a17:907:7a93:b0:a46:74fe:904f with SMTP id mm19-20020a1709077a9300b00a4674fe904fmr10682741ejc.26.1710828870515;
        Mon, 18 Mar 2024 23:14:30 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:ca2b:adb0:2501:10a9:c4b2])
        by smtp.gmail.com with ESMTPSA id gf8-20020a170906e20800b00a46d9966ff8sm567031ejb.147.2024.03.18.23.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 23:14:29 -0700 (PDT)
Date: Tue, 19 Mar 2024 02:14:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240319021136-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240314074923.426688-1-gshan@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 14, 2024 at 05:49:23PM +1000, Gavin Shan wrote:
> The issue is reported by Yihuang Yu who have 'netperf' test on
> NVidia's grace-grace and grace-hopper machines. The 'netperf'
> client is started in the VM hosted by grace-hopper machine,
> while the 'netperf' server is running on grace-grace machine.
> 
> The VM is started with virtio-net and vhost has been enabled.
> We observe a error message spew from VM and then soft-lockup
> report. The error message indicates the data associated with
> the descriptor (index: 135) has been released, and the queue
> is marked as broken. It eventually leads to the endless effort
> to fetch free buffer (skb) in drivers/net/virtio_net.c::start_xmit()
> and soft-lockup. The stale index 135 is fetched from the available
> ring and published to the used ring by vhost, meaning we have
> disordred write to the available ring element and available index.
> 
>   /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64              \
>   -accel kvm -machine virt,gic-version=host                            \
>      :                                                                 \
>   -netdev tap,id=vnet0,vhost=on                                        \
>   -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0 \
> 
>   [   19.993158] virtio_net virtio1: output.0:id 135 is not a head!
> 
> Fix the issue by replacing virtio_wmb(vq->weak_barriers) with stronger
> virtio_mb(false), equivalent to replaced 'dmb' by 'dsb' instruction on
> ARM64. It should work for other architectures, but performance loss is
> expected.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Yihuang Yu <yihyu@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 49299b1f9ec7..7d852811c912 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>  	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>  
> -	/* Descriptors and available array need to be set before we expose the
> -	 * new available array entries. */
> -	virtio_wmb(vq->weak_barriers);
> +	/*
> +	 * Descriptors and available array need to be set before we expose
> +	 * the new available array entries. virtio_wmb() should be enough
> +	 * to ensuere the order theoretically. However, a stronger barrier
> +	 * is needed by ARM64. Otherwise, the stale data can be observed
> +	 * by the host (vhost). A stronger barrier should work for other
> +	 * architectures, but performance loss is expected.
> +	 */
> +	virtio_mb(false);
>  	vq->split.avail_idx_shadow++;
>  	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>  						vq->split.avail_idx_shadow);



Something else to try, is to disassemble the code and check the compiler is not broken.

It also might help to replace assigment above with WRITE_ONCE -
it's technically always has been the right thing to do, it's just a big
change (has to be done everywhere if done at all) so we never bothered
and we never hit a compiler that would split or speculate stores ...


> -- 
> 2.44.0

