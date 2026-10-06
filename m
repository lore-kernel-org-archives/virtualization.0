Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E943DAAAA
	for <virtualization@lists.linux.dev>; Tue,  6 Oct 2026 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791281436; cv=none; b=Acn0TFpa6G1kAuzUh6FOlNCtElBI5ueRN4m/PSnMReE/f6rMGmr+ibkhfFUMX0ZpvsysyN1FF6ShSd6JIei1Loo/gCEzpB0iiTH/MPrXnxLxuUr/Mffij1g8w5sFaRt86yk+Yv2f9NZ6xnDn0STklRnJxrK7ek9NT1kvXRGKJwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791281436; c=relaxed/simple;
	bh=N2sqn3Mrh9cMwgsNdDkjfWDmTzoWYIrPVQyIvXfpLM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rhM0ageb+zC0k2hfu/0rZjShzpwgyHmH5vFXjm/vvEUjfEtM5R5sKq/i3AtQycaAxFZk5plzATn+38BM7uNxo/k/Hk3k7NU4VGzi+psarReOGHof5LZW9NepBBwrzJDRlC3IyHxXSzuKi18kGB8+5NUfWjTowWpqg+kS5iMy4Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ha2RKfcw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ha2RKfcw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791281433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CuhYqf6tY7m4XrIgU7T4atxSrQDOejKxcMknnN8Lwz4=;
	b=ha2RKfcw5vbSxyre9/CDEwVXG+FvC/gVeUyN0X525hqyCI4BSZNntWCiPmXf3wAXe8ZzPK
	zMH6lGm4sIKf0OlAeR1ZUWYP7ldZZ2eSG8t8HoKLYvnTQCQzNGssGPZlg8RzlHC3qlPzKC
	2N37WRwz++6eqpCWgBys1TlHoBksDv8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-U5mQEgxCMUCt5RCnFfD35g-1; Tue, 06 Oct 2026 06:10:32 -0400
X-MC-Unique: U5mQEgxCMUCt5RCnFfD35g-1
X-Mimecast-MFC-AGG-ID: U5mQEgxCMUCt5RCnFfD35g_1791281432
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c437ae81eso1912665f8f.1
        for <virtualization@lists.linux.dev>; Tue, 06 Oct 2026 03:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791281431; x=1791886231;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CuhYqf6tY7m4XrIgU7T4atxSrQDOejKxcMknnN8Lwz4=;
        b=RVZXqS1OCyeX0Z1ZxEClBZ5qcNyVQZzqm9VqKDenuVksKUOCAiEId0uP/FUtU9b58h
         Gufw+cHMSW2EZOG6lOeaCiMy6yrSyygC2sdY5Rh9/R6mXFEwoBmURmk3nMnDMHCZqa3d
         GA13HXY1mSK+SqSoXuA66OTY6ZnZlfJ8CXmM9qDwr9/8INqPn7HMzYJIK+IsFKRM221a
         Q7iq9djAlpKN6IsUiPeoF4PrDBwgwSgLRoZXMWO9hWDd337JtvzBFYKTYpF8bl4MD5I8
         7NV618jwWZDDlztfBNTLtvFg2OsxLw9Rov86US+T/OgmtMshaI2Sxvt+Uhwzmzjh20uw
         mpdg==
X-Forwarded-Encrypted: i=1; AKwUvByKLr6pOka7o8y8raZXXr6NzMkT5ADVS5ljsjbI44PcriEprhqHWBpzAldAOYBXs6nI5kA6GIgmCZMoud/V1w==@lists.linux.dev
X-Gm-Message-State: AFq9FYIixOzNoDIYtdkfqdi9ztbIND+csw6WQiU2D8LLujRAEcJFIUfj
	PZ0zbluYIvL1mvuwQmMWXUONW5H2kb6bLviGhkX46zih8zSfQewYsWd7gx8s2Qy86eSOcUAUQdp
	8DAREJ7pY/kovWGBJZIbZaKl/ZsWpATIM/YFYc0Z8ZfEpvWNh9Iakgz1KsF1BD9T32iDyOL0C3+
	0n
X-Gm-Gg: AYBFou2ALpWRn3R8oEc83cvUePtYLsVlPInWE7SKYpqBy83RRQdBpur+NEsOBHNUwhW
	vQqo61Wcp1D5eGcV7zLYsyEIsPBAmQzK4+bDJH+CFYNnE3NwRqJ+AptFOBpbThQEtQW61xg+F1l
	RMsV7j0Eu3nCJiDjwYRLDrwjIYZnEWdjVC1oCan1RJGhdmoBAm9xh9Ls0GEJX6pCzkvmcotF+49
	lA8YuykBB1qTX2PNY/HuFLhEc7hGTWgTjRXNuj4tCX03lo3S5Djxc2lYBKbeTuZOPpvNHFoYexl
	9lC4Q2feF0/omu0gqIUPCLrsno6Tkp1QgjHX39xYKBfk14oKjAhrZWhD1emaJQ3lzF33la4=
X-Received: by 2002:a05:6000:2610:b0:485:8c16:a34b with SMTP id ffacd0b85a97d-48c47fedcf3mr17075698f8f.35.1791281431381;
        Tue, 06 Oct 2026 03:10:31 -0700 (PDT)
X-Received: by 2002:a05:6000:2610:b0:485:8c16:a34b with SMTP id ffacd0b85a97d-48c47fedcf3mr17075655f8f.35.1791281430798;
        Tue, 06 Oct 2026 03:10:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622ab326sm9129953f8f.35.2026.10.06.03.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:10:30 -0700 (PDT)
Date: Tue, 6 Oct 2026 06:10:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sungbyeongchan <tjdqudcks0424@naver.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: use shadow flags when detaching split
 descriptors
Message-ID: <20261006060900-mutt-send-email-mst@kernel.org>
References: <20261006100400.842345-1-tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20261006100400.842345-1-tjdqudcks0424@naver.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v3VdbBQBn1-E3jGgMVpFfCKyPJmYyTzd8MBl3WTN3sY_1791281432
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 06, 2026 at 07:04:00PM +0900, sungbyeongchan wrote:
> Split virtqueues save descriptor flags and next indexes in desc_extra
> before publishing descriptors to the device. The detach path uses the
> shadow next index, but decides whether to continue by rereading the NEXT
> flag from the shared descriptor.
> 
> A device can change the flag after publication and make
> detach_buf_split_in_order() detach an adjacent active descriptor. This
> overcounts num_free and may put a descriptor on the free list twice.

This seems neither here nor there I'd drop this paragraph.

> Use the shadow flags for the continuation decision as well. This keeps
> all detach metadata in the same driver-owned snapshot and avoids an
> unnecessary shared-ring read.
> 
> A VDUSE/virtio-vdpa test which changed NEXT after publication made six
> valid completions return seven descriptors, with one descriptor ID
> duplicated on refill. With this change, the same test returned six
> unique descriptors, while the unmodified control remained unchanged.

This too.

> Fixes: 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra for split virtqueue")
> Assisted-by: LLM
> Signed-off-by: sungbyeongchan <tjdqudcks0424@naver.com>
> ---
>  drivers/virtio/virtio_ring.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)


Patch itself is good, I always like it when the # of lines of code
drops)

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index db678f5a80e03..b4cb433df1dec 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -905,7 +905,6 @@ static unsigned detach_buf_split_in_order(struct vring_virtqueue *vq,
>  {
>  	struct vring_desc_extra *extra;
>  	unsigned int i;
> -	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
>  
>  	/* Clear data ptr. */
>  	vq->split.desc_state[head].data = NULL;
> @@ -915,7 +914,7 @@ static unsigned detach_buf_split_in_order(struct vring_virtqueue *vq,
>  	/* Put back on free list: unmap first-level descriptors and find end */
>  	i = head;
>  
> -	while (vq->split.vring.desc[i].flags & nextflag) {
> +	while (extra[i].flags & VRING_DESC_F_NEXT) {
>  		i = vring_unmap_one_split(vq, &extra[i]);
>  		vq->vq.num_free++;
>  	}
> -- 
> 2.43.0

