Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603578;
	b=ctbwmf2dMxvAteJRfGk3M4N7fEYUe2gQJAZsh91+Dujb3HXQ4fgsGyiJTDedwK1/Sw1B
	 wzsc+xkTVZyljmZ60sYE4BHyazvO0GxsHb7NaDntRdG0qnCR50kftwCefvjIKeVoNvyTE
	 JJ6JyzRbE2QzFqLPi7o2/ulZuFuwR1JUq+dTAos7VBKlu16PgHmf+mXipeAGMERHT7RnL
	 2xpkFxBCkkWMj7u0cq7RZgdIjSMIZMxToMAtPopngO2uxw19NaBJBcX8Gryaz2qcx3Ibh
	 +an9F1QOG0mLw9kEfzgbse28h7xboJ7T+6o24SM5Y3G/b24CI+Fs4+NVaHqG+t9tu0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603578;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=J0xbpu1QOArMZW7hFhhmtZ4gk401vyBEZ/yHioUPp3Q=;
	b=AOtW+qrGO6g1L1TlBmmNhBs3MmJGdQc01RwfQmzVLW93Im7W48Q093RmKR+tgg8zvAf1
	 HwekUNh7R9ssAukyewAh8CMG2z35kPb980wgJvp+vDgemBnXGNbh1o2mk+IA8DTdKnZkT
	 1VdauGMKCXya7SNWJZejm6+lQVsKX67LO3zUomlV0a07DebaXzYeL1RdikNSRPmHSJaAW
	 xVTOBJJjZI8US5WaEIiqRHjWLv0jJ/5g60/QkL+rYJze0ynanmxMfdVbfoXcu2QGY1hI5
	 0AWV/rYYz+gYGpWkbqWafrweI2j8TrcVqsWdVZ0edtdLiRFOmOJ0recqiqqNwpGVW0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iM4wN1pU;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559FD606A31E
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 10:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 559FD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iM4wN1pU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795603577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J0xbpu1QOArMZW7hFhhmtZ4gk401vyBEZ/yHioUPp3Q=;
	b=iM4wN1pU4ZiBlnCjaZtTZAkW15geOZqs5zI9rL182bhz+3mimqhQ1B+maFH80OzZrk07QB
	hsUUKyrLSML/qiXAMV/mPjyDacvMqP6xpg7GBLzMOjZ4VeNw3WkgRLONbPXF8dFH5IPsgc
	ICcd6i6A6/VgFi4E3JuA/hATkBf594U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-5E5-i5PmPImb3-o3IgK6CA-1; Wed, 25 Nov 2026 10:46:15 +0000
X-MC-Unique: 5E5-i5PmPImb3-o3IgK6CA-1
X-Mimecast-MFC-AGG-ID: 5E5-i5PmPImb3-o3IgK6CA_1795603574
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4bb69d84053so40077325e9.0
        for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 02:46:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795603574; x=1796208374;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J0xbpu1QOArMZW7hFhhmtZ4gk401vyBEZ/yHioUPp3Q=;
        b=nqGUVVoXsnFcHr4hWN+sm3uEdu5zONuLz8H0sVbIgWj02VWpZ3GrJ7YNQ67BuDQQiF
         v9sZzk1UnqgirWvunb8plUkmqLLCAKn01w0ldhcDBqR4zggIGc7As6WCGX2UPTLI/3CK
         aggSDEp5nxcCwLwE5HrPXM2mvM0cYaKPSDwI8FICeqyKSE/00EX1aOMnxbBKmbX1OJOX
         oGyVSCG101KUxotVNBYPFcMT3S4uWznylzPPj8VLSm01eCJhIRm9La4MrfdSArHNN9yf
         +59Mav//EAqwjcQAKpRh+E9JOyy/wP+L9CHqYAYi8BSWbJX1GqGBdzmPxsQ7uEikLSrI
         iHTA==
X-Forwarded-Encrypted: i=1; AL+hErGOA/Qy+fgDJclhtD3BUNTM7qCpVF02mVknMjRWMRg0oD6o4SzlxCtXbIo8psVZnPnT+5yZk0wDMgsIwmGuOg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/5w4sGLjgEEEHMDFwlwik2HrFQMbeVrcRaMSUcUXIu6oXx6Jrg
	7dKpn8ypb3j7SBD2Cp7dIBOcA0LJdzUxMcgRHbUrC9ZZg6oBGjjKH+9QbPx4kdzWWWUn/9cDmxO
	uQG3Wx9kl/E6QQIRzp9ivW/sNjDyj2/BfJ9lZMLo/rGUJ/wzttIXzHRUr3YHFbasRIU9F
X-Gm-Gg: AZFdTZeNwX2GRejAhPaiC46wXuKxPXJB9/L2FatCO+o5aY2n2ohaYwpXjEztSQUpalB
	3ykz79V1eKhhGURI2KkAWKBzilw3eAwVLKVxU2a4a2QUbP/xIOdm/WfJ0Gp7zYOnE71+K1Jx3ah
	+1bVOFpOqJwUb5/M2IhIl0hP3GMZTKxtihSoJ8Cn+OhLC5LGwzHn1JQfXS+ht0EuZ1YMDVkZLDX
	jBx+x7Cj5whQdnbP4P6OVs3YB5NQmIBSexvleUyg+MjA+ga2vIKuCi85kkmksFw9EeSa25vnnaL
	ZZ9zB5SzvXlKwRtufzwQPEO6C4iQo+uMM5DpBH3pvjxzNH6v47MPrESy3RfkDkorKYb95NZgGfq
	NWV2zuSaaQZ0AzsFuJZ09WpfjUaVW9vR4BtlDcJvSBus=
X-Received: by 2002:a05:600c:5246:b0:4a7:9006:b176 with SMTP id 5b1f17b1804b1-4bb887fe892mr375982875e9.7.1795603573926;
        Wed, 25 Nov 2026 02:46:13 -0800 (PST)
X-Received: by 2002:a05:600c:5246:b0:4a7:9006:b176 with SMTP id 5b1f17b1804b1-4bb887fe892mr375982235e9.7.1795603573317;
        Wed, 25 Nov 2026 02:46:13 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1529:2e00:86ec:bef7:c309:ba1f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a9687sm568878595e9.10.2026.11.25.02.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:46:12 -0800 (PST)
Date: Wed, 25 Nov 2026 05:46:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Wang <liwang@kylinos.cn>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	fuse-devel@lists.linux.dev, virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, virtio-fs@lists.linux.dev,
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] virtiofs: fix lost reply due to unaligned cache line
 sharing
Message-ID: <20261125053116-mutt-send-email-mst@kernel.org>
References: <20261125093908.48619-1-liwang@kylinos.cn>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261125093908.48619-1-liwang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vcWay2Ls5pdIr1inFDvcrh7Oh3PCamDKVOpgCEq7wik_1795603574
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Thanks for the patch! yet something to improve:

On Wed, Nov 25, 2026 at 05:39:08PM +0800, Li Wang wrote:
> virtio_fs_enqueue_req() maps fuse_req::out.h for DMA_FROM_DEVICE in
> place. fuse_req comes from the "fuse_request" slab with no DMA-granule
> alignment, so out.h shares a CPU cache line with the waitq field.
> request_wait_answer() updates waitq while the DMA is active.
> 
> Note: Sashiko correctly identified the bug, but the resulting behavior
> is not as described. Sashiko reported that unmap invalidates this shared
> cache line and drops the waitq updates made by request_wait_answer(),
> so wake_up() walks a damaged list, the waiter never runs, and a later
> wait-queue operation can panic. That is not what current arm64 does for
> this buffer. fuse_out_header is 16 bytes and does not cover a whole cache
> line. dcache_inval_poc() uses dc civac on that partial line: a dirty line
> is written back and then invalidated. The waitq update is kept, but the
> out.h written by the device is lost and reverts to its initial all-zero
> values. virtio_fs_verify_response() rejects that header, because
> its unique and length do not match, and the request finishes with -EIO.
> 
> Place out.h on its own DMA granule and start waitq on the following
> one. Allocate the slab at __alignof__(struct fuse_req) so those
> offsets are granule-aligned in memory. Coherent architectures keep
> ARCH_DMA_MINALIGN at the natural alignment, so fuse_req does not grow
> there. The padding is compiled in only when virtiofs is enabled.

Is this not all completely theoretical for when virtio fs
device is on a real hardware chip as opposed to running
on a cache coherent cpu? With LLMs hallucinating real life
impact?

But anyway, this is not how one should write commit logs.

Should be, for example:

Currently .... as a result, when ... then ...
but ... so we can not ... . To fix ... as a result ....
Tested by ...





> Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")

theoretical cleanups, as I suspect this one is, do not need a fixes tag.

> Cc: stable@vger.kernel.org


and accordingly it is not appropriate for stable.

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-41eaaf0f-0eb9-4809-99cf-5f83439eb848
> Signed-off-by: Li Wang <liwang@kylinos.cn>
> ---
>  fs/fuse/dev.c        |  3 ++-
>  fs/fuse/fuse_dev_i.h | 18 ++++++++++++++++--
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index b198cc729cba..00e637d5e552 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2342,7 +2342,8 @@ int __init fuse_dev_init(void)
>  	int err = -ENOMEM;
>  	fuse_req_cachep = kmem_cache_create("fuse_request",
>  					    sizeof(struct fuse_req),
> -					    0, 0, NULL);
> +					    __alignof__(struct fuse_req),
> +					    0, NULL);
>  	if (!fuse_req_cachep)
>  		goto out;
>  
> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index a8eba46a3e51..e42f3dc30d3b 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -12,6 +12,18 @@
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
>  #include <linux/fs.h>
> +#include <linux/cache.h>
> +
> +/*
> + * virtiofs DMA-maps fuse_req::out.h for DMA_FROM_DEVICE in place.
> + * Put @out on its own granule and start @waitq on the next one.
> + * fuse_dev_init() allocates the slab at this alignment.
> + */
> +#if IS_ENABLED(CONFIG_VIRTIO_FS)
> +#define FUSE_REQ_DMA_ALIGN __aligned(ARCH_DMA_MINALIGN)
> +#else
> +#define FUSE_REQ_DMA_ALIGN
> +#endif

virtio fs specific code in fuse headers. not good.

>  
>  /* Ordinary requests have even IDs, while interrupts IDs are odd */
>  #define FUSE_INT_REQ_BIT (1ULL << 0)
> @@ -94,10 +106,10 @@ struct fuse_req {
>  	struct {
>  		/** @out.h: The request output header */
>  		struct fuse_out_header h;
> -	} out;
> +	} out FUSE_REQ_DMA_ALIGN;

Ugh.
You want __dma_from_device_group_begin/end 


Maybe. If it even is ok to dma here directly.



>  
>  	/** @waitq: Used to wake up the task waiting for completion of request */
> -	wait_queue_head_t waitq;
> +	wait_queue_head_t waitq FUSE_REQ_DMA_ALIGN;
>  
>  #if IS_ENABLED(CONFIG_VIRTIO_FS)
>  	/**
> @@ -118,6 +130,8 @@ struct fuse_req {
>  	unsigned long create_time;
>  };
>  
> +#undef FUSE_REQ_DMA_ALIGN
> +

>  /* One forget request */
>  struct fuse_forget_link {
>  	struct fuse_forget_one forget_one;
> -- 
> 2.34.1

