Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BBA33A9C3
	for <virtualization@lists.linux.dev>; Sun, 15 Mar 2026 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773588610; cv=none; b=ek6oNNhU2boyQmYimAVDrk08XJzZWcAZMEiyAguB/I0KN/q1vbCBWtFmLn/VulUe7YXyexjeSk5SaMR+FASNX14GWoNbyXiMDlepf9QNzD0DFE4qezLisZblG+dfQJ75dVqnZF6nNC8yw++tmkmjRNc1QIKqAjjshmEY1dEPBbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773588610; c=relaxed/simple;
	bh=EyOiydOuPLuOTj6QEmQI4rH9HhV6xLu3F9vI8CesZBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CyNLq3AlrNZrIXLKHggrBKVj0n0Q2lEp37hGl6wMkqb0pMq0qIsJdmqgJ3Z1Z0mwZZz34xqNXaNXNTYcG3R4a/3G3lAGQrWDrJC7riY5bcePu7mCnfP2hSLJHGbrn1Ac0NicQdCcHjGeZDYOZp6zk217joGdqcuszsfj14KFJ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=imZ0JMxT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imZ0JMxT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773588608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iiiFUzJ9tbUShPW9dcm9hP1jmyIzZs8zb+I7tXGQA24=;
	b=imZ0JMxT5V6DBcSTtGbdlG9fd/3k9OPKW9ewyflLOPXQzWjFt+1ABLxDQusfoUVLAJDpwv
	a4kHSo6xOGxqnOXeZaqccLH1kxzp9mW9J40kRzcYSwdPj4Cd5mlBfLpZUakDklcCnbRC58
	+G1EW/BZuw0aKn1buDHi959iwBkmMHs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-udA0rprLODOvdMVU0iWVTA-1; Sun, 15 Mar 2026 11:30:06 -0400
X-MC-Unique: udA0rprLODOvdMVU0iWVTA-1
X-Mimecast-MFC-AGG-ID: udA0rprLODOvdMVU0iWVTA_1773588605
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48532df52c5so52200235e9.1
        for <virtualization@lists.linux.dev>; Sun, 15 Mar 2026 08:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773588605; x=1774193405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiiFUzJ9tbUShPW9dcm9hP1jmyIzZs8zb+I7tXGQA24=;
        b=OTTvaIs05Fcp/Pfb6NGIdAeHtznFJbRhz4mOImfA5KHhgEuH3R+ayoxlKPFt2g4iEB
         vG5EY6kyFnld1gCPkgAoReIjCWS1cbvvboEJR3ySJL5ig1AOUGU/ylGp0LOASMG0FGXO
         qkaNSJmgUTQz0D6uXXd1JItRHFC2PH4B4OTae7ZceG/v7iZEFmBhltNWNiV8pT+bbIX5
         6iqajDFjNLpcMceHciyy7tXJgk9MW94Bjkwyfh2chRx2dlDG95r3SA/caVK/OgMtZ7IK
         Lk9RuxfjTDzpaXf/z+XFT7rAJd1nih/Yow1pfvncXiO6YHEdbPFnOT0aanE27W4tj+e+
         EULw==
X-Forwarded-Encrypted: i=1; AJvYcCXkSXTQmN6RO2FSC8nQdtIBexgsts5v65EFVC5eQGEUdaff3vPPDG6XweALbcfuPCNI3BaqinsOlueKrJcvqQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMyKd+GnH0q6v3na9TjNkBZT7OwkV+wNHLNk6KE1uVmzG9f0ZR
	lhBvETPHIVT1AVuIgKrPfYKnfg9Lq4EWYdeiX4VDLxa9Wfnmd32iLzQ5NkGfJC7K5dqDRTHfLo6
	t/JtlbCKcn5uR9cJR0Qm7Vo/wmbaR4C45OqAyHyywdZRTnQShVF1SvMcTWCXSGqdIuoI8u7UyXD
	Fe
X-Gm-Gg: ATEYQzyc4Zt5upkvK5VpEPgYdYtGi4wuARbi9TsQaIBkJqiQaenHlB7Ljs8Seh0QJQt
	o8lbDap2h1CobiJ2QZPx+4cwlR8JQ6klR8FDG3YdFseXp++vxJivmwd1x6GX5P3rDADUka+t9tl
	KWr0g7H5m7/hh+zHuSKdWWttgyLmfduH4iopjNn/CLdDcK8Pko13ZZRCBrQ3TJ9dI+uOely/EKn
	jSKHVkxNpQrwN/jbHPCTu7ttJR2KauuqEAGnbGAMriL7Slu9I9omo/A/8CndKIjmIjWDhWPVKfy
	tENfCVm9tWRj6E79TlzvOrscIPZHlsj3ovqqBR70myvxAf9qkej+CNSLxPrPHeEdgeiBg9RZ6v4
	55gzRbZdxeArk0nHNyW1fq+3Mf35ivyK3UKQVxqXxrW4ssQ==
X-Received: by 2002:a05:600c:c162:b0:485:3fd1:992c with SMTP id 5b1f17b1804b1-485566d2fe7mr153624665e9.1.1773588605010;
        Sun, 15 Mar 2026 08:30:05 -0700 (PDT)
X-Received: by 2002:a05:600c:c162:b0:485:3fd1:992c with SMTP id 5b1f17b1804b1-485566d2fe7mr153624055e9.1.1773588604468;
        Sun, 15 Mar 2026 08:30:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854e67ea40sm301596055e9.7.2026.03.15.08.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 08:30:03 -0700 (PDT)
Date: Sun, 15 Mar 2026 11:30:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shengwen Cheng <shengwen1997.tw@gmail.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: reject NULL recycle callback in
 reset/resize helpers
Message-ID: <20260315112904-mutt-send-email-mst@kernel.org>
References: <20260315152403.127645-1-shengwen1997.tw@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260315152403.127645-1-shengwen1997.tw@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tnu_R884CtP2n8hQdpLqge2bonUDlA2wAccZL3tDzbg_1773588605
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 15, 2026 at 11:24:03PM +0800, Shengwen Cheng wrote:
> virtqueue_reset() and virtqueue_resize() rely on the recycle callback
> to release each detached unused buffer after disable_vq_and_reset().
> 
> As a defensive change, reject a NULL recycle callback explicitly to make
> this requirement clear. Update virtqueue_disable_and_recycle() to warn
> and return -EINVAL when @recycle is NULL, and update the descriptions
> for virtqueue_reset() and virtqueue_resize() to document that @recycle
> must not be %NULL.

I see little point in this change, sorry.

> ---
>  drivers/virtio/virtio_ring.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 335692d41617..563cee634426 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2698,6 +2698,9 @@ static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
>  	void *buf;
>  	int err;
>  
> +	if (WARN_ON_ONCE(!recycle))
> +		return -EINVAL;
> +
>  	if (!vq->we_own_ring)
>  		return -EPERM;
>  
> @@ -3311,7 +3314,7 @@ EXPORT_SYMBOL_GPL(vring_create_virtqueue_map);
>   * virtqueue_resize - resize the vring of vq
>   * @_vq: the struct virtqueue we're talking about.
>   * @num: new ring num
> - * @recycle: callback to recycle unused buffers
> + * @recycle: callback to recycle unused buffers, must not be %NULL
>   * @recycle_done: callback to be invoked when recycle for all unused buffers done
>   *
>   * When it is really necessary to create a new vring, it will set the current vq
> @@ -3367,7 +3370,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
>  /**
>   * virtqueue_reset - detach and recycle all unused buffers
>   * @_vq: the struct virtqueue we're talking about.
> - * @recycle: callback to recycle unused buffers
> + * @recycle: callback to recycle unused buffers, must not be %NULL
>   * @recycle_done: callback to be invoked when recycle for all unused buffers done
>   *
>   * Caller must ensure we don't call this with other virtqueue operations
> -- 
> 2.34.1

