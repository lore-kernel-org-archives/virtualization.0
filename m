Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6A6354ADC
	for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973561; cv=none; b=ZK54Czm0mlQnbG/hw6ernwQnWgVeZWiudTtNReFgLgn4Mq7ia4F2zgJOqfyzyKFM0rCpdu1zTQjPw4LMrrMAng9nllte6LpqcM3ibzCa3k6ykxAUjJ1p+CdvGHeYl9Gk6EMlLSnLwcRwBbmc+KQeRbkYutfbcgLGogdVBPMpHWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973561; c=relaxed/simple;
	bh=UES3fuoTB2ke08i+4mK7KHAjMOlzq2Bu3GI/IW3cul4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uYPsR5YuYNOODF/O6bWkQxLRCtoxvJjxSmigpWbNJct3g7xYL8k6JTaVVXh/s5hujv6Sxzj4UdphH0GBvqamXYLb7yowzwUQn4y2s8PLdTCWufP9Dh6BEXrsV6lzhm4AeAixK1AO3zMEQNQZCMVO2274/KadZ44q5mrHo/UIXi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a9NLs1FM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9NLs1FM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760973559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6VzCuiv48XnVTj0yJ2CgCK8h1WFJ+MXvGeTMMKT28eU=;
	b=a9NLs1FM2uCR/UucS9DKj0do3F02+wWNjNUT1R74RLTfl32tmZLy2uJpA3nZPj36TocLP5
	RoNc51AYL1twTfGLEe221yy17uRlJFju4BErHXeu1fYxXkQsiG/RIGArAe/ZV5V0S4cxjx
	obNWdDdaTHegmP6Rz4ZSEs9QoFkOavs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-aM62pJzrOiC81H42-kGlLA-1; Mon, 20 Oct 2025 11:19:18 -0400
X-MC-Unique: aM62pJzrOiC81H42-kGlLA-1
X-Mimecast-MFC-AGG-ID: aM62pJzrOiC81H42-kGlLA_1760973557
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47113538d8cso24758835e9.1
        for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 08:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760973557; x=1761578357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VzCuiv48XnVTj0yJ2CgCK8h1WFJ+MXvGeTMMKT28eU=;
        b=GUhpHNp8t9I0W5MdiAEEK0680oxuTGE9NZE+bIrmLsN8kGnY+CgiXGDAfPnNbiburo
         dgN2MDUTdzrfJMM6rYxncmkLySrFkBBQv7bT+cGCbbnigcaphGjdwREgbPZBYofbBbz6
         BLTfZXHWG+/o2X+pbg74jY0h//JsTM3JUo0MqAbomttOtCsNP1VmhoNxs/DML1KislhR
         1SZQB+COSQTjEoY4TOG+62zTL9aAmrM+FBogJYbPbb3UvGYPcj1KtqHY9FcyYIZBstTU
         HAPP9iVcBHVPQ1y5W00eBVl2eskEHs25HqLBQCAW4QMkbS/YUI8wBBDGfwBItFO1N9if
         xyOg==
X-Forwarded-Encrypted: i=1; AJvYcCW3Q0nVK67zUB152ujSARjEA0KCPk2K3/toH3tsjeg//oJao7CiBsHA5qZhmx/7deDA7UijnaJi/uVZTVRCvg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyi+QfhDJj/EaGNdlnw+im/SsceBb+9brQW6P6FakAR4qSyRAou
	yTE8xqhZ6K2qYHbBGLTGmIu5LQ8iBjJ114ZAwElqgqPzmSH80sDvtdRu+IcilG9fFpko2lZYpWs
	8Tdh2AkOgywKzdN42iuADYFMMLzgK5gcZX6IoD3b9hVVKNL0D+NxwqmmHfSSHEUnsJ75z
X-Gm-Gg: ASbGncupMeY6kfASOblSiuxh8YQawDHXqeBtQ8qheN2KbGgbAA6cUvEfDBojF7iFi1Y
	ehrwvb/qh/9UKsvksMxMGrmEFARgff41USjml9iuo5a+wHx8QtDhlW21kqDbQY4wqeLmCE4cWdD
	omqyBCvTy5QV2nVwgRFXRc+0YfHq+clRfykInMkSsG/X9+jA4RRZ/nz/jymEJYikZ0cICtq1VDj
	48oC07e63dv8p65Mi4zkzTuyJOuV9sthWWIRU5wkr+GsxEsiTQIURxEfgI97co54o36MDDnNdXi
	exVfyJVL1ZEDXnP7J31LxtP+XQUVcpBNIq54RAQC56hYe//KNpDjAO09ZiWuLvvLvDxr
X-Received: by 2002:a05:600c:4e8e:b0:471:a98:99a6 with SMTP id 5b1f17b1804b1-4711789b11emr92630455e9.11.1760973556717;
        Mon, 20 Oct 2025 08:19:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI1dWATaMCNt1gTcEgwdzlqSdzz40gvI3CnKScfnNKuceA65mZfM4HYKBIw5XIwuXHTBVfNA==
X-Received: by 2002:a05:600c:4e8e:b0:471:a98:99a6 with SMTP id 5b1f17b1804b1-4711789b11emr92630175e9.11.1760973556196;
        Mon, 20 Oct 2025 08:19:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce08asm15711045f8f.44.2025.10.20.08.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 08:19:15 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:19:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 00/19] virtio_ring in order support
Message-ID: <20251020111824-mutt-send-email-mst@kernel.org>
References: <20251020071003.28834-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251020071003.28834-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 36cTLu97cj0IGi_nKZh3CowsRRpUx8J921IPFgQqFd0_1760973557
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 20, 2025 at 03:09:44PM +0800, Jason Wang wrote:
> Hello all:
> 
> This sereis tries to implement the VIRTIO_F_IN_ORDER to
> virtio_ring. This is done by introducing virtqueue ops so we can
> implement separate helpers for different virtqueue layout/features
> then the in-order were implemented on top.
> 
> Tests shows 2%-19% imporvment with packed virtqueue PPS with KVM guest
> vhost-net/testpmd on the host.

This is much improved thank you!
There are some coding style comments worth addressing but
I think we are almost there.

> Changes since v7:
> 
> - Rebase on vhost.git linux-next branch
> - Tweak the comment to explain the usage of free_head
> 
> Changes since V6:
> 
> - Rebase on vhost.git linux-next branch
> - Fix poking packed virtqueue in more_used_split_in_order()
> - Fix calling detach_buf_packed_in_order() unconditonally in
>   virtqueue_detach_unused_buf_packed()
> - Typo and indentation fixes
> - Fix wrong changelog of patch 7
> 
> Changes since V5:
> 
> - rebase on vhost.git linux-next branch
> - reorder the total_len to reduce memory comsuming
> 
> Changes since V4:
> 
> - Fix build error when DEBUG is enabled
> - Fix function duplications
> - Remove unnecessary new lines
> 
> Changes since V3:
> 
> - Re-benchmark with the recent vhost-net in order support
> - Rename the batched used id and length
> - Other minor tweaks
> 
> Changes since V2:
> 
> - Fix build warning when DEBUG is enabled
> 
> Changes since V1:
> 
> - use const global array of function pointers to avoid indirect
>   branches to eliminate retpoline when mitigation is enabled
> - fix used length calculation when processing used ids in a batch
> - fix sparse warnings
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
>   virtio: switch to use vring_virtqueue for virtqueue_get variants
>   virtio_ring: switch to use vring_virtqueue for enable_cb_prepare
>     variants
>   virtio_ring: use vring_virtqueue for enable_cb_delayed variants
>   virtio_ring: switch to use vring_virtqueue for disable_cb variants
>   virtio_ring: switch to use vring_virtqueue for detach_unused_buf
>     variants
>   virtio_ring: switch to use unsigned int for virtqueue_poll_packed()
>   virtio_ring: introduce virtqueue ops
>   virtio_ring: determine descriptor flags at one time
>   virtio_ring: factor out core logic of buffer detaching
>   virtio_ring: factor out core logic for updating last_used_idx
>   virtio_ring: factor out split indirect detaching logic
>   virtio_ring: factor out split detaching logic
>   virtio_ring: add in order support
> 
>  drivers/virtio/virtio_ring.c | 905 ++++++++++++++++++++++++++---------
>  1 file changed, 692 insertions(+), 213 deletions(-)
> 
> -- 
> 2.31.1

