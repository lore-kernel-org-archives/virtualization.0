Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8D51E487
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573483; cv=none; b=nSqRT40wItg/NLweje0ifmMu3zE/vtyqWw2JGOousM0dFdw9HBN/0aLGae0Y3fLxsuALtx+uB8v4zEgQl+KGvyO11nQEgK155ZhDdQYAIFmtsRD3T0dpkVOczD4H9jWVJWmqUUzOuPCurW5Bdmpuwhmt65QxuUjeHK+ZSIW/jHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573483; c=relaxed/simple;
	bh=KB31fWp1xQrgG040Mlf2ElwUzGbs6A/75GH2CHRZv9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ucwOqPTCNvHiXpzcgQnvtaXc83QI7Dm4LBsPvpU4U39qNs/xU+w8oUyKR8M6Np5DPPzlL4ZL+pCWYKA2es72PHUpZ84bQz30oZKe7uK9sp4+y/yGjyZsGLm9Po8VAUFK71804dYi7RWoLarbWzSjD6u3TIloEQBBjJt5qnNC7O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HJmRenKe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJmRenKe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z1VeWdPuiBqILm73rm3vCe0GB4AUiqLL2VU0aM8SPXo=;
	b=HJmRenKecbmhzhnriz5Z75ELIck0PnMOIzcKm1vx4RgjANTvBwTIOmg0vWsaiA8n4beeWK
	miFbBy7oHKWEI+odaWHo5M3o0hUjGtoPTETnT0r4W9zbrzJcLEcc0n3TbOyY5k+QDA1pP3
	qFIccr+J9RBZFZbMZQuqkeHODT9h+bo=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-OoCwGJR1P5W0upbwq23FLA-1; Tue, 15 Jul 2025 05:57:59 -0400
X-MC-Unique: OoCwGJR1P5W0upbwq23FLA-1
X-Mimecast-MFC-AGG-ID: OoCwGJR1P5W0upbwq23FLA_1752573478
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748fd21468cso4447620b3a.1
        for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 02:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573478; x=1753178278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1VeWdPuiBqILm73rm3vCe0GB4AUiqLL2VU0aM8SPXo=;
        b=srTk3Ur0Tw1wiazYsR2YyqiOhadU/bs7YPyNpEzJuBBWpsFwB/48AYNzXqnbLQDkjX
         KXllS3ipZF2Nh4J59G8QSvFo4CCHXnWPi5TLBErGLWRZsG7FSwLzpv0BiHrDZO+Rbb10
         OSuyCWi8/BlhKe+0e9vGj7HYzG3dUQ0d10IC/7d3sNxMDcLFI1ItraFzph4WaoxWkIfp
         yPJmNOrmqMCtaXBJ4U7kqhLfV8Fnk5o77Oxc/XJ+leriLZhUeqNfP7FXGWupxIXgX4bZ
         4ICuydrCu5CULf7OTqDuWeeiNy+fS1k3BLW0ERX4WDzStz1so6B7Fi9IVxTAWTBKCtaN
         +0rA==
X-Forwarded-Encrypted: i=1; AJvYcCVos/GIPJ9vLx8a8byxFX8BywN8RTEK3rytDQgo70SkRpkZqEAuSB2xbn5k2WI2G4izrzCxTVyp3mXEuphcqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjoiUxrQ5GY0MarpmrRJU0hNkm8frO/WwP7O5eoFU4ns80VwPK
	WlB3JGyn/MLaHF8v9Om66WDR7PO5T5H1gre+so8aZEJzq84ABUoWOfkGXi86RKeM6rMH+j/tChH
	OgyrSbvBuNs2nqptwE4kKWN1Y6pUguLkPR7iZdTlgM3B/IlqKIe1wFVdRKntOjReQ/HCr
X-Gm-Gg: ASbGncsq9mSfYKndroKp86KEyTxuFk8jmdLVuiquwdUNlJoP546TLIBTsj3WbAigcfe
	EvLOZ/xg2VNZbrrBWwDx2uy6xDs6N+QbPJidVqJDdgUoHhGYkyPQwEI9hfvQJ5IP8/C+P+tjexf
	lhSMjzUToez1Nh6R+Kqx77yFCCvF7z0UyjlWFIBk2Rl3QFxRK5YKHHQvGSJZLjBlOma078XKfjV
	naDTq3EgygkPj9f784kRHsp2NFf/TDFoVlj4rI+llMvLikrZ9TWSVxxNJYpIZhDzyjpnCXBZs4E
	XQEpS3/T+Hje8WqqwVGLmr2iT+iG+Lb8n16dnkyK0w==
X-Received: by 2002:a05:6a20:914e:b0:21f:4ecc:11ab with SMTP id adf61e73a8af0-2317dbd4f1dmr22897069637.9.1752573478224;
        Tue, 15 Jul 2025 02:57:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWQGcFR1RyTALwdsG+0AcGsG1+kH2rVM1KjDsLtN/xS5dDJPTTql59MnYtr/kxTQlIq0P5Iw==
X-Received: by 2002:a05:6a20:914e:b0:21f:4ecc:11ab with SMTP id adf61e73a8af0-2317dbd4f1dmr22897034637.9.1752573477769;
        Tue, 15 Jul 2025 02:57:57 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e064a9sm11751862b3a.47.2025.07.15.02.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:57:56 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:57:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 6/9] vsock/virtio: Move SKB allocation lower-bound
 check to callers
Message-ID: <kcntvqjud6wixfoq6w2heqqdblurjigzaasz7333fsd2p22vai@ettf5254doz5>
References: <20250714152103.6949-1-will@kernel.org>
 <20250714152103.6949-7-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250714152103.6949-7-will@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hblQGOqajEx0RVcoKLyQy0vsIhxlxEYhVrPsujmyiHc_1752573478
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jul 14, 2025 at 04:21:00PM +0100, Will Deacon wrote:
>virtio_vsock_alloc_linear_skb() checks that the requested size is at
>least big enough for the packet header (VIRTIO_VSOCK_SKB_HEADROOM).
>
>Of the three callers of virtio_vsock_alloc_linear_skb(), only
>vhost_vsock_alloc_skb() can potentially pass a packet smaller than the
>header size and, as it already has a check against the maximum packet
>size, extend its bounds checking to consider the minimum packet size
>and remove the check from virtio_vsock_alloc_linear_skb().
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c        | 3 ++-
> include/linux/virtio_vsock.h | 3 ---
> 2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 1ad96613680e..24b7547b05a6 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -344,7 +344,8 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>
> 	len = iov_length(vq->iov, out);
>
>-	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
>+	if (len < VIRTIO_VSOCK_SKB_HEADROOM ||
>+	    len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
> 		return NULL;
>
> 	/* len contains both payload and hdr */
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 4504ea29ff82..36dd0cd55368 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -57,9 +57,6 @@ virtio_vsock_alloc_linear_skb(unsigned int size, gfp_t mask)
> {
> 	struct sk_buff *skb;
>
>-	if (size < VIRTIO_VSOCK_SKB_HEADROOM)
>-		return NULL;
>-
> 	skb = alloc_skb(size, mask);
> 	if (!skb)
> 		return NULL;
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>

