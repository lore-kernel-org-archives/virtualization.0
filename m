Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420C63398A
	for <virtualization@lists.linux.dev>; Wed, 28 May 2025 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748436668; cv=none; b=TdNpcPRtCrB0gNYkvtElIhWRVjzYsSc2f1c0nv1OeUXcqqSiZ82JkK8OyiqqbvVRCzLVjEF3rUDtCYUvg3GoXV5IL4TQztxB+QjH1Df/8Mvy0BwBHaTSk0l5OVRRSfAhUXsLWVQDoXSQo5jwzDFquEYmdD4cqwlcOS6R6IqOHC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748436668; c=relaxed/simple;
	bh=QQICW+CypoFjK5BqJ6heT+1m+k+pLORcZ4vDWH1R5VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=b8bhbvPpu015JEB9ndOfchtjJq1OSL0K2piQof8SMuF8BTgS7B2wu4hYz7GGB61nROmhGv2hvbuHCEK3l0sI0Mug33pnxSR8Dx4wsNojTBkpN0zzaNhqgYcdw9n1zT6LLp9Jli9T/M1XtOEWt0dW6GM2TeAupqCDwbQaq8ro2sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNpgaSM9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNpgaSM9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748436666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VWR+5p6ptUR6spJK+eA+18Unm4RrTl1BPCG1yFI4dP4=;
	b=KNpgaSM908NR6AeyS1EM0gs9SKyw09XZUafzxuNUmRQCC6Ohle/9M0Oduei5H8y83iW4i2
	RyiGCueR8gu/j3FgwljeWq02yKrrw9c4VAtOZwNP5KZ5Mu4Q3CjUw9Wyp/msiL8SMOK8Zr
	V9ase9JGjmXGHLgdz0HIjgFeHrHGAfw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-8hnmDj2hPe6709-Ue5mhcg-1; Wed, 28 May 2025 08:51:00 -0400
X-MC-Unique: 8hnmDj2hPe6709-Ue5mhcg-1
X-Mimecast-MFC-AGG-ID: 8hnmDj2hPe6709-Ue5mhcg_1748436658
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a3684a5655so2204588f8f.0
        for <virtualization@lists.linux.dev>; Wed, 28 May 2025 05:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748436658; x=1749041458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWR+5p6ptUR6spJK+eA+18Unm4RrTl1BPCG1yFI4dP4=;
        b=pgIbl5WUuxF8nSImPC+PNe0ztcyoHrgE+jtNWwSUOxq2vAJfIW01KuzUZrcv+0FRDO
         0KjtciivqqIZwn4tKY2gXP74gU4yLRwfRK8Eq4C2TuZZZmlwZJzxphJsdUindRJ+/17c
         1lGKwGyYiJu5kEFQPoIhfsYt2mOex6Tp0nGTP9biu00RZa9RNL69ZVjd3tp8art3qaNW
         2zb+g+iNKEQNq78I+fofhc2jQbEBzc9n1hLAYbBCqTDYGY9UswPFJVvVw0xhgZ2VOtqM
         oLtGbtBI9WU0II0s/6mjS1N/OX+zH6pcg34jKdo/kM9cGpNxNk2CJ7LhKnUKs4mGY6pD
         RdtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0odxzOMG+vrjjtDNatPOTj1eWofa4Ex7iDNnUgspD/1uJntwCVAB2ryNnUThgJSJp72pBO8nnkwxsf0Devg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEJxiEN6ZCRF9FVZk84RLwBcw+M11d94mSOEd7XAAudatGV0qV
	Km7eWLq4epmpaoKivMm9WhFNwhBj14j/5iZy8xJeyTz6+ccqm0q6y9MoweeApzI3cVJDndvXcgU
	+8bqSK3hOzdWPvE1n1aQMOuWO+AZwIJv8X7XhI8oh53GNlFhGgccDPV7PHl8f5H7fX8E+
X-Gm-Gg: ASbGncvTaDWFBLIMa/cQ73klOw+gt8W29LTVI2jaiMRr0Ntg9lNYrLCh2SEWFB3KpGV
	92W1GCJjY+mODgldHQ7JT7/FjidFYlhEyZmrBxV+Lfrf1WDUNnru1FXFsihWvEQ92h2vgE2wKCF
	DsH3a3RofA9ozeuJ9a0N9VNEV+ZYxbqhH9dQcK2lpRkJY1B4VLAbJgEbdSIEz3sp7ineM/8xf+h
	/Bw6x+uERvRvyV+OKzRAQHDgaHkwshFsxouBpRbDUZBpNp6yPJdADiAdMsG7M6VynRv+74FYok8
	d0ifbQ==
X-Received: by 2002:a05:6000:2dc4:b0:3a4:dfc2:2a3e with SMTP id ffacd0b85a97d-3a4e957b210mr1631508f8f.39.1748436658034;
        Wed, 28 May 2025 05:50:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGDT3PcePhhoStWwOcSwIXapMw5WkiamBsXKooLqximtwBRdLGBqfc9aCDPZLpSSxOK/eQEQ==
X-Received: by 2002:a05:6000:2dc4:b0:3a4:dfc2:2a3e with SMTP id ffacd0b85a97d-3a4e957b210mr1631488f8f.39.1748436657639;
        Wed, 28 May 2025 05:50:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4500e1dd6c8sm20848545e9.37.2025.05.28.05.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 05:50:56 -0700 (PDT)
Date: Wed, 28 May 2025 08:50:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 00/19] virtio_ring in order support
Message-ID: <20250528084904-mutt-send-email-mst@kernel.org>
References: <20250528064234.12228-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250528064234.12228-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tfLjld5jaX1uNnr-0SoK5-5rNvrr8JMLhrWhuUiKM7g_1748436658
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 28, 2025 at 02:42:15PM +0800, Jason Wang wrote:
> Hello all:
> 
> This sereis tries to implement the VIRTIO_F_IN_ORDER to
> virtio_ring. This is done by introducing virtqueue ops so we can
> implement separate helpers for different virtqueue layout/features
> then the in-order were implemented on top.
> 
> Tests shows 3%-5% imporvment with packed virtqueue PPS with KVM guest
> testpmd on the host.

ok this looks quite clean. We are in the merge window so not merging new
intrusive stuff, but after rc2 or so pls ping me I will put it in next.

> Changes since V1:
> 
> - use const global array of function pointers to avoid indirect
>   branches to eliminate retpoline when mitigation is enabled
> - fix used length calculation when processing used ids in a batch
> - fix sparse warnings
> 
> Please review.
> 
> Thanks
> 
> Jason Wang (19):
>   virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
>   virtio_ring: switch to use vring_virtqueue in virtqueue_poll variants
>   virtio_ring: unify logic of virtqueue_poll() and more_used()
>   virtio_ring: switch to use vring_virtqueue for virtqueue resize
>     variants
>   virtio_ring: switch to use vring_virtqueue for virtqueue_kick_prepare
>     variants
>   virtio_ring: switch to use vring_virtqueue for virtqueue_add variants
>   virtio: switch to use vring_virtqueue for virtqueue_add variants
>   virtio_ring: switch to use vring_virtqueue for enable_cb_prepare
>     variants
>   virtio_ring: use vring_virtqueue for enable_cb_delayed variants
>   virtio_ring: switch to use vring_virtqueue for disable_cb variants
>   virtio_ring: switch to use vring_virtqueue for detach_unused_buf
>     variants
>   virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
>   virtio_ring: introduce virtqueue ops
>   virtio_ring: determine descriptor flags at one time
>   virtio_ring: factor out core logic of buffer detaching
>   virtio_ring: factor out core logic for updating last_used_idx
>   virtio_ring: factor out split indirect detaching logic
>   virtio_ring: factor out split detaching logic
>   virtio_ring: add in order support
> 
>  drivers/virtio/virtio_ring.c | 896 ++++++++++++++++++++++++++---------
>  1 file changed, 684 insertions(+), 212 deletions(-)
> 
> -- 
> 2.31.1

