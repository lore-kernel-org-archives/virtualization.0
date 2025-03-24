Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811C66125
	for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827444; cv=none; b=idQ8yw9qQ1DwS7udnohPJcshc95aD0XO/o2Qp2GsHMGsC2XQ+3hido5d0lkjp9PO4ZW9MQNAzyh3NybYR2VoA4mMFzXq5w0yqaubG4Lghj4Ix30Br3/bX7xkWl/GuwizOhdBMNo3DlvQZ4R2/JOfEnDbYE14HVtt1UuR5lRg8f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827444; c=relaxed/simple;
	bh=kWGmO5Fe9n1QZBql/9XX3gMxWfQD39pTNi6RUSi7VkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjhPSzlApJu21gvVIZJ5CXxHGUuz9gBqh41KbcVVqyVw5cDKZ6lBiEUtiblUz4v40rcgknMWi428bxaqZXpZTqNNXvAx81wZkXpDeD0bJijgBvs8/6cZe+jvwLyFdfb3FvrBPgRVZYWxxp3rXOtRsFKqBs3Z8AZJ0LFJEovDkQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T2yXWHLK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2yXWHLK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742827441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EKtNS87VKI3qBZ7UZtNdNXHh6kQ26WV+OsLcli3oRo0=;
	b=T2yXWHLK9wXs4pi0mGoeu14CpxuaODe1tsrna9LrJjnBvt8IKjOCQ376qtP9r6OhgqVPzK
	NXRDvDDUzhRgze+v8lrnK5ycehQ1TROI6QN7QtSWnuOvIZiBGWQhL3r9Wi+hygplIAZgcA
	D6ay/ODndIAfTlrhrScItskQk2c94L8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-VbheBH4zMgGAf8X5aqAnvw-1; Mon, 24 Mar 2025 10:43:59 -0400
X-MC-Unique: VbheBH4zMgGAf8X5aqAnvw-1
X-Mimecast-MFC-AGG-ID: VbheBH4zMgGAf8X5aqAnvw_1742827438
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac27d8ac365so281793466b.2
        for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 07:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742827438; x=1743432238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKtNS87VKI3qBZ7UZtNdNXHh6kQ26WV+OsLcli3oRo0=;
        b=tR7L1zROmFRJpRU8Y1FQN0GHr2zNt6xixq96VC3q/dmEdF8m+8/STIJSBhmMF0cjMj
         wdOiWfpBCq4FuJGrNHyvf9y9vYkdamrMvW0GTE20BhIq2A8F6zmnlP+EpPxyoMJqk1rx
         2Uwmm5vk+f8K/u2IxEZRJlUYnXUVRq3vZq4h1UR8N5ySBuN5vmHI830ik/ginvArQ1ql
         T8tJl+yYy175SBkJF9G/WP3pt9wt1PnNtwcK5zRGLh1PHwDHreiMztZdtICPymGeUvwN
         OtPYcaMWqfdPyTFHk/nzUrVWZhiZSd26WqZ2Vep0m97+jyrIt5CFr2Ge89zQbpMydv7s
         ciXg==
X-Forwarded-Encrypted: i=1; AJvYcCUb+9tSyZud7GOcnuQnNfafnYm9EYRvVKwqYKdD1YLK8pr6uxhFDvuM2j7ea2rM2+lZm+i2clV2rkTDHcpJ2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFj8HTwTgHa3d++hU327UVyohSAzBFP3tju+ktAP8HOMLxliZx
	sffvo3s5AzEhN0vouAkVCSpG+WSWbUdYDNYQT9/PGz3oMAaR5oNyDKA8JE2o1YaeUsDOKw1pV6K
	hrpPw6O6bm+iv+stoVAoCnc9bxozPiIKTvBzxrgUvog8Jacy3XIGeZ3KTDK92Viypxp1trpEki6
	jJxVwTvyh0GKOjnhrrl8LvffXhXu6Si7IZTztyoTY=
X-Gm-Gg: ASbGncu+M26812erte6cpYMGQKYsKFCS18zkGxBdLVR/M4yqWw2DP8lZ3L+VRqaRx9J
	w1TZP9EYvbTsewjuW9xkcMTD0tphydvPxINb11YH7kyzIBNVXG3lX8Z7DmbHSB4T8CeYxNtK7WA
	==
X-Received: by 2002:a17:907:1b2a:b0:ac2:8784:4bea with SMTP id a640c23a62f3a-ac3f20d30dbmr1419332566b.8.1742827438449;
        Mon, 24 Mar 2025 07:43:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZAeQO5AXXjuoyLKgLAtV81kTmhy/K3XnGUy84KHZoby/SQototvIvcST30HTNJ8fj33AYAC+idf9EUDSDIY8=
X-Received: by 2002:a17:907:1b2a:b0:ac2:8784:4bea with SMTP id
 a640c23a62f3a-ac3f20d30dbmr1419328866b.8.1742827438007; Mon, 24 Mar 2025
 07:43:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-1-jasowang@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 24 Mar 2025 22:43:20 +0800
X-Gm-Features: AQ5f1JrXfkHTzuma5AqSaSU6COxpwVpHkbBrjXnrgtbUVryJALh0TzOw4CmentQ
Message-ID: <CAPpAL=x4BWNh__YpzkzpErkseh04FT7WNLmg=xMXtfZ0S9BabQ@mail.gmail.com>
Subject: Re: [PATCH 00/19] virtio_ring in order support
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v8eQvQTfKgtumI4oLhq3GKW_G6Wdv28B693uWS1G7P8_1742827438
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Mar 24, 2025 at 1:45=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Hello all:
>
> This sereis tries to implement the VIRTIO_F_IN_ORDER to
> virtio_ring. This is done by introducing virtqueue ops so we can
> implement separate helpers for different virtqueue layout/features
> then the in-order were implmeented on top.
>
> Tests shows 5% imporvemnt in RX PPS with KVM guest + testpmd on the
> host.
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
>   virtio_ring: move next_avail_idx to vring_virtqueue
>   virtio_ring: factor out split indirect detaching logic
>   virtio_ring: add in order support
>
>  drivers/virtio/virtio_ring.c | 856 ++++++++++++++++++++++++++---------
>  1 file changed, 653 insertions(+), 203 deletions(-)
>
> --
> 2.42.0
>
>

