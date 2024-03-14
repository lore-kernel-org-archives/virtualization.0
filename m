Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5217813FEE
	for <virtualization@lists.linux.dev>; Thu, 14 Mar 2024 08:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710403543; cv=none; b=eupgg1cJyYS+ZMCS+rNer/yw5PqqgUHUH5i6irJqLRAZvLeXA0vdyXbvhvFAjN5jI1KxZZ6uOPinIfuFLiHbY+NoHz6ORHcNvo3HPpbdYz0JPXIJlGWgNSzPhaLQR92VbcAn6DIS9ITQRTAsREyInClYsXMMQWOi4W1dPHsrJNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710403543; c=relaxed/simple;
	bh=c5dQPIi5+dTdkssS5kHf15ZWVGL4axBW5Y7E08xrRog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GbbowQqzOtkuIZRtMS8mkUkMYmh7VUQUY+9TYMLA5d6Kn+wQQQAxMoZm3X8HRpd2JxPES3AikIKksHX52GyOnODWAdcr0g/5ZIAGoYuAVJSfQOx0CFacBPXOPjjacWEHBigdF3IcYNExVW79FCqPE8OjofX0327K2bf1ixoBkh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DWsKPBDQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWsKPBDQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710403539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=twCf+S12MC6b5Qn4kEy/Qs5P8iL9E+CPn7P9+SqvFCw=;
	b=DWsKPBDQ5v2KMNvgi3cRJq5uavIBRxT0+41AXdi3XybMwuAtEZl1UVhzJlS8NXfDooI6UN
	v1TQaQOmo5dV5oJ9j9cDh0WDfWpDgE/EVYOt5vmzuC3JxqO67p+pFFK0AJb6h46Lh8mZ3Z
	3Dmx2fTnS3HpNm9NnhdGAzqs8iTMC/Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-vP4EvIo3NBylR0UnSNjbfg-1; Thu, 14 Mar 2024 04:05:38 -0400
X-MC-Unique: vP4EvIo3NBylR0UnSNjbfg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4132fe17766so3599245e9.1
        for <virtualization@lists.linux.dev>; Thu, 14 Mar 2024 01:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710403537; x=1711008337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twCf+S12MC6b5Qn4kEy/Qs5P8iL9E+CPn7P9+SqvFCw=;
        b=OvL/SlOQgWjS0K1oD6lqZhAHp0BXKjkG6JbsNA3gEid8KXsLpoYA7JwG9J1HOLlrSQ
         mcZBmFdymmJWpBLkB8qevzGtCYc4fu+spxa70NdM3rssOkeeUCkyM91PpcyuSn9rNlHA
         1wv2aIy5hDgMQy3D5IvB1h1eq6gYrO3SjTysxESMxFhwwpPzHyTcczgvtyCBwA2OUkTI
         NjsPf05zbhfyr1uPyyVCbFLzcpmKqC8JCi3XnoyztdsXs90QdHOFSluoVmCMJNHgxE/t
         MCJIsIlSgq8y2eqLCMUrb9Sx4LwvlbiMlAqGtvuIrq/ovpxJfcSHo1lcOMXNrC/cS7KB
         MIJQ==
X-Gm-Message-State: AOJu0YxmGtyoDgunJuXt0DZmq5Ug2vASWTTp6vq4sT+HnijR+75/2ehS
	f5rNFCyMYYYZTknGxEN4svr85dV9Ir1qZKPt0ZUVC4Wh0luROdfuI0P0juqYQFpKtIeTAiVFj/Q
	q/uEXwECuTc/3p82DExMAPVIdqhswmeb2fmC8kcGgLd9izCJO2+DFZUeor4MdbwDt
X-Received: by 2002:a05:600c:520d:b0:413:e19:337f with SMTP id fb13-20020a05600c520d00b004130e19337fmr726982wmb.22.1710403537073;
        Thu, 14 Mar 2024 01:05:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/vGlZoWw7dKN4Pbvd6mgsDyCr7HSvKmnXXoW0mIUYkLwKgnCpvfwwyLZHJbJ7gvGZhHbB0g==
X-Received: by 2002:a05:600c:520d:b0:413:e19:337f with SMTP id fb13-20020a05600c520d00b004130e19337fmr726952wmb.22.1710403536377;
        Thu, 14 Mar 2024 01:05:36 -0700 (PDT)
Received: from redhat.com ([2.52.134.16])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c315100b00413f76fe7b0sm202255wmo.21.2024.03.14.01.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 01:05:35 -0700 (PDT)
Date: Thu, 14 Mar 2024 04:05:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240314040443-mutt-send-email-mst@kernel.org>
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


I don't get what is going on here. Any explanation why virtio_wmb is not
enough besides "it does not work"?

>  	vq->split.avail_idx_shadow++;
>  	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>  						vq->split.avail_idx_shadow);
> -- 
> 2.44.0

