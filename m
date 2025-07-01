Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27389270EBC
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366720; cv=none; b=JWuKCyLT3G/L/879DxNjvyi0sNij+C+jtP3/IsvXE9pvYl8NOEhJJ6Jpv1ivcT6P5l3F8rpkUZQ68VQjmMulZFDQD4+MmCN1mk1lMc4qe4LyP4JSbgoNl90BgMcMYyO5I+FVcbDuGK0V9rH+gnHecz943yWd+CIVyQ4GlstSY2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366720; c=relaxed/simple;
	bh=yRYgHbSrAkuxw8GaLfZBFA+ZmVUCpG/7oEaKEc3z3Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Y5wU4vnW4aeHxbu6bZATKX9t9qwRaaO0hlIp+2Ln7cwp6O5Xujo6kZ36jbKt8INefiiellCMHiAG4kfHx/1fAAEofKDiD7lCinfO6xpqmOwOFhYzGjlZaa6bn1JrTmh2SNSH/4vAAEE6Mjvpt8pL1EFsJOe3xLaUHXXT8YSOxa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OrLatmeO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrLatmeO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751366715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bvtILH89149LI+zD04GPMfILWdmEwPt3/05vd+118lg=;
	b=OrLatmeOQS6lHO07Lh5ZmPgQ671xsGrlj4L5z8i1Lf5suEKcJ1a695dm4FbOFJHmdvoFX+
	ANOb1ODoyveRNsoQPjsJtWxDmvls64YvT+AjZVmCkV2g4PuMhcIEyhDKOv6VMQTeO6vg+c
	4rLU9qbMQuvT31ZCGAOmrwfjtJOj2Gg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-5IqyTa81ObqQevMkk4nKWw-1; Tue, 01 Jul 2025 06:45:12 -0400
X-MC-Unique: 5IqyTa81ObqQevMkk4nKWw-1
X-Mimecast-MFC-AGG-ID: 5IqyTa81ObqQevMkk4nKWw_1751366712
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-40b4d900decso2790671b6e.2
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 03:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751366712; x=1751971512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvtILH89149LI+zD04GPMfILWdmEwPt3/05vd+118lg=;
        b=r82xvC4r3BpjB8uuytJfc8x7odt6yVZ1w+UXd6/WFJlSzTAo8MOIIR0IAs6ow6vZQe
         DOcpyKr2dsq9ESRLUDnNjpb8qF1RxB6zfB1LHu2zdd8/TDoYArIYAWMTWvqCzJoR+uYw
         KzX23taUf/v6gLMAw5GkKFhw9qlhdSVoOZH22bzh5Z4bbIACzWP1YjxRu/t9Ogo8lyfG
         GL8cs6JV3aGmlWUfbs5msat9PSSc4NMeo6SxyI/Jk/4zG9b7Iu2glwr4hw4uFq4CUXd0
         nRLi+PLMf7VLK9GuxiKSDVRRb1R9O5d8MXjOetkHPdF2LlIh51vHybZuDUdF3jhTjLGO
         q8iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk1u2QterTsJHuyjb2//+KjsxXzfeZnvj/Zgps6w70qRWYkUkPm1BG8xbRq3jDZI6yAryssPUFeveVP4CpaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfEN8Hk73q6Txi1x/i3jMupKEvwsBW+M79hFS8EPGqYYKcPzOR
	06jy5jqxigbkzNjzgt/K3i9riyDd2ght4Rafe++8fkFBusU84jJEtmh7vz0zoN16D7Vg6D4f5nU
	B7lF4ODFJcR4q5sSm5iPhZsNUt1c+qDastHoUJBqqqDpHMxwrSX5zQqpYwxaGRIbt+1/k
X-Gm-Gg: ASbGnct6anfgv9rHFNx/Ycgq/vIpwsjFUoXIE02SNnHev/uRGB0OZ4QVRIUUv+pv93l
	u1qMGWW/65TNsILhTQ1obxyNDun+CPlqk+tRWrHR+J0Qlhc+nKxqEQRS/2nT2imTBY0XeMNIDS9
	oQnRa5MOqLP4KJwp6rdI3sGiKjtci81YYnRDkfV3h5PzZ5qAYtIsyxJNNF5eU86+QksAeXkJdAZ
	EI51hbYt2kt3qtlmhQWootRy+hFcT3V0nhXE3a+7Q70NLbF6nSF8NLUgoT1ZpQ1zzaXMgE2n9Yj
	DpAaeUjRw7PZhiMhfYUkvPB5Zxma
X-Received: by 2002:a05:6808:2202:b0:3fe:aecb:5c49 with SMTP id 5614622812f47-40b33e324abmr14762131b6e.21.1751366711682;
        Tue, 01 Jul 2025 03:45:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZqLNSFn4u/OltyPDVZCfPxB24s1GVT0ZUzyLOd0CNhrAGYaI9Si2fr1rfeL4ixA2goyWYoA==
X-Received: by 2002:a05:6808:2202:b0:3fe:aecb:5c49 with SMTP id 5614622812f47-40b33e324abmr14762107b6e.21.1751366711199;
        Tue, 01 Jul 2025 03:45:11 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.144.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b322b1d89sm2072981b6e.19.2025.07.01.03.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 03:45:10 -0700 (PDT)
Date: Tue, 1 Jul 2025 12:44:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 3/5] vhost/vsock: Allocate nonlinear SKBs for handling
 large receive buffers
Message-ID: <6shb4fowdw43df7pod5kstmtynhrqigd3wdcyrqnni4svgfor2@dgiqw3t2zhfx>
References: <20250625131543.5155-1-will@kernel.org>
 <20250625131543.5155-4-will@kernel.org>
 <orht2imwke5xhnmeewxrbey3xbn2ivjzujksqnrtfe3cjtgrg2@6ls6dyexnkvc>
 <aGKdSVJTjg_vi-12@willie-the-truck>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aGKdSVJTjg_vi-12@willie-the-truck>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3fPHwx4AODWmsMK01gJ2Hhk_OEC5MUredWnmWLSMBoU_1751366712
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jun 30, 2025 at 03:20:57PM +0100, Will Deacon wrote:
>On Fri, Jun 27, 2025 at 12:45:45PM +0200, Stefano Garzarella wrote:
>> On Wed, Jun 25, 2025 at 02:15:41PM +0100, Will Deacon wrote:
>> > When receiving a packet from a guest, vhost_vsock_handle_tx_kick()
>> > calls vhost_vsock_alloc_skb() to allocate and fill an SKB with the
>> > receive data. Unfortunately, these are always linear allocations and can
>> > therefore result in significant pressure on kmalloc() considering that
>> > the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
>> > VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
>> > allocation for each packet.
>> >
>> > Rework the vsock SKB allocation so that, for sizes with page order
>> > greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
>> > instead with the packet header in the SKB and the receive data in the
>> > fragments.
>> >
>> > Signed-off-by: Will Deacon <will@kernel.org>
>> > ---
>> > drivers/vhost/vsock.c        | 15 +++++++++------
>> > include/linux/virtio_vsock.h | 31 +++++++++++++++++++++++++------
>> > 2 files changed, 34 insertions(+), 12 deletions(-)
>> >
>> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> > index 66a0f060770e..cfa4e1bcf367 100644
>> > --- a/drivers/vhost/vsock.c
>> > +++ b/drivers/vhost/vsock.c
>> > @@ -344,11 +344,16 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>> >
>> > 	len = iov_length(vq->iov, out);
>> >
>> > -	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
>> > +	if (len < VIRTIO_VSOCK_SKB_HEADROOM ||
>>
>> Why moving this check here?
>
>I moved it here because virtio_vsock_alloc_skb_with_frags() does:
>
>+       size -= VIRTIO_VSOCK_SKB_HEADROOM;
>+       return __virtio_vsock_alloc_skb_with_frags(VIRTIO_VSOCK_SKB_HEADROOM,
>+                                                  size, mask);
>
>and so having the check in __virtio_vsock_alloc_skb_with_frags() looks
>strange as, by then, it really only applies to the linear case. It also
>feels weird to me to have the upper-bound of the length checked by the
>caller but the lower-bound checked in the callee. I certainly find it
>easier to reason about if they're in the same place.
>
>Additionally, the lower-bound check is only needed by the vhost receive
>code, as the transmit path uses virtio_vsock_alloc_skb(), which never
>passes a size smaller than VIRTIO_VSOCK_SKB_HEADROOM.
>
>Given all that, moving it to the one place that needs it seemed like the
>best option. What do you think?

Okay, I see now. Yep, it's fine, but please mention in the commit 
description.

>
>> > +	    len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
>> > 		return NULL;
>> >
>> > 	/* len contains both payload and hdr */
>> > -	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
>> > +	if (len > SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
>> > +		skb = virtio_vsock_alloc_skb_with_frags(len, GFP_KERNEL);
>> > +	else
>> > +		skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
>>
>> Can we do this directly in virtio_vsock_alloc_skb() so we don't need
>> to duplicate code on virtio/vhost code?
>
>We can, but then I think we should do something different for the
>rx_fill() path -- it feels fragile to rely on that using small-enough
>buffers to guarantee linear allocations. How about I:
>
> 1. Add virtio_vsock_alloc_linear_skb(), which always performs a linear
>    allocation.
>
> 2. Change virtio_vsock_alloc_skb() to use nonlinear SKBs for sizes
>    greater than SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER)
>
> 3. Use virtio_vsock_alloc_linear_skb() to fill the guest RX buffers
>
> 4. Use virtio_vsock_alloc_skb() for everything else
>
>If you like the idea, I'll rework the series along those lines.
>Diff below... (see end of mail)

I really like it :-) let's go in that direction!

>
>> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>> > index 67ffb64325ef..8f9fa1cab32a 100644
>> > --- a/include/linux/virtio_vsock.h
>> > +++ b/include/linux/virtio_vsock.h
>> > @@ -51,27 +51,46 @@ static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
>> > {
>> > 	u32 len;
>> >
>> > +	DEBUG_NET_WARN_ON_ONCE(skb->len);
>>
>> Should we mention in the commit message?
>
>Sure, I'll add something. The non-linear handling doesn't accumulate len,
>so it's a debug check to ensure that len hasn't been messed with between
>allocation and here.
>
>> > 	len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
>> >
>> > -	if (len > 0)
>>
>> Why removing this check?
>
>I think it's redundant: len is a u32, so we're basically just checking
>to see if it's non-zero. All the callers have already checked for this
>but, even if they didn't, skb_put(skb, 0) is harmless afaict.

Yep, I see, but now I don't remember why we have it, could it be more
expensive to call `skb_put(skb, 0)`, instead of just having the if for
control packets with no payload?

Thanks,
Stefano

>
>Will
>
>--->8
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 3799c0aeeec5..a6cd72a32f63 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -349,11 +349,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> 		return NULL;
>
> 	/* len contains both payload and hdr */
>-	if (len > SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
>-		skb = virtio_vsock_alloc_skb_with_frags(len, GFP_KERNEL);
>-	else
>-		skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
>-
>+	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
> 	if (!skb)
> 		return NULL;
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 0e265921be03..ed5eab46e3dc 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -79,16 +79,19 @@ __virtio_vsock_alloc_skb_with_frags(unsigned int header_len,
> }
>
> static inline struct sk_buff *
>-virtio_vsock_alloc_skb_with_frags(unsigned int size, gfp_t mask)
>+virtio_vsock_alloc_linear_skb(unsigned int size, gfp_t mask)
> {
>-	size -= VIRTIO_VSOCK_SKB_HEADROOM;
>-	return __virtio_vsock_alloc_skb_with_frags(VIRTIO_VSOCK_SKB_HEADROOM,
>-						   size, mask);
>+	return __virtio_vsock_alloc_skb_with_frags(size, 0, mask);
> }
>
> static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
> {
>-	return __virtio_vsock_alloc_skb_with_frags(size, 0, mask);
>+	if (size <= SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
>+		return virtio_vsock_alloc_linear_skb(size, mask);
>+
>+	size -= VIRTIO_VSOCK_SKB_HEADROOM;
>+	return __virtio_vsock_alloc_skb_with_frags(VIRTIO_VSOCK_SKB_HEADROOM,
>+						   size, mask);
> }
>
> static inline void
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 4ae714397ca3..8c9ca0cb0d4e 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -321,7 +321,7 @@ static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
> 	vq = vsock->vqs[VSOCK_VQ_RX];
>
> 	do {
>-		skb = virtio_vsock_alloc_skb(total_len, GFP_KERNEL);
>+		skb = virtio_vsock_alloc_linear_skb(total_len, GFP_KERNEL);
> 		if (!skb)
> 			break;
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 424eb69e84f9..f74677c3511e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -262,11 +262,7 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
> 	if (!zcopy)
> 		skb_len += payload_len;
>
>-	if (skb_len > SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
>-		skb = virtio_vsock_alloc_skb_with_frags(skb_len, GFP_KERNEL);
>-	else
>-		skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
>-
>+	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
> 	if (!skb)
> 		return NULL;
>
>

