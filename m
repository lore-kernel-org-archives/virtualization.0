Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50F419049B
	for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 18:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983532; cv=none; b=pO0v+ejPhCIGEGoId8TFjescfJ5TF/E3HhTX80Si5VsTgoMRZKuZnY8zVfUHzo3HVqz3qbJkYjWPeT3102uXMGyl74ICAW0TUZcI7joe403Gl2N1K7R0ls0lcMjLLzqcejLRaTwK81grH4v73Kb8IV5TQ7V8wVvbBEYICzG21lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983532; c=relaxed/simple;
	bh=uiD1heCbyfEANV0HzWxufVPtGQSjmgjqtnG/kBnzihg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pJUYPHtkFPlmBT93zTDKDwMNb/DLBN1mv8fs9Zs53kLOcYew9Ea9bW91JIj1COgmZGhj/36MX8K4Tz10+rm2YpJI4kafXI9awaO4UnrPhXusaqo4mSAJFnhmLb+IuYMUnJ4JF5UuLn1KsCKB2mE8PLJdaC24fFSBFqiFKPcfs60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LrV6LPDA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrV6LPDA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760983529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=36S/ZmC1rovvSywQh09PqWqsI9Syym0VZe1uvVyj7To=;
	b=LrV6LPDADCPKWc9rVrYTZA817vRxQ5d5h167idqCDJcLim6MoGid38f9z78dU+CaRS8R/D
	hQ4WYQps5zP+/LtnE3UdM51WBsH3X2duItOR1IT8dIZTmKx3PL4h+dVB0V82Pg8bR9To/C
	ijrbjODFmjuhzqx+WhyVlbxummXvYjw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-i-hCjip5OC2zRszEWS4ptQ-1; Mon, 20 Oct 2025 14:05:28 -0400
X-MC-Unique: i-hCjip5OC2zRszEWS4ptQ-1
X-Mimecast-MFC-AGG-ID: i-hCjip5OC2zRszEWS4ptQ_1760983527
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47107fcb257so69082195e9.0
        for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 11:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760983527; x=1761588327;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=36S/ZmC1rovvSywQh09PqWqsI9Syym0VZe1uvVyj7To=;
        b=CX0Az8GxTsyI6MUR0XGYSDY5yhVrlTkdQdfiVN6eq4UDu7/oONOkixEfq03Lwbk15V
         lYFr1PbMiQGvW5RC2/6hIfUXfKwG/TpUW8IrCz/L6N3z2btR6Xf7V0WQ6l1ZOrfa4Xez
         1FbeqEYALHqDk0Kt4cFeaOa/3KOLFWMjD/sY7oydnfAgNSM9cr5IbDpsH7pkQm0+qUzI
         mNBq97kOjz4XMgm2it8i+DCDjD0ZuKjDutzL41taclNMZMkEGfjIR6gPEs/lsgZtHxB7
         Ugl+bpNoOhwP6g2iaKAX5BNjD1ibTpWo1/mKm+XeBJaktb7l604UO9UCO1Z2fMAzmzWA
         c0fw==
X-Forwarded-Encrypted: i=1; AJvYcCV1NtuNZ3wqq1in4aJOlU6rgQst8QWdh9cpu1Tcp/+6tE36K+we9AxwTIrMqBtemwCsw4Qg0IKzIuj7a6VEag==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx22rWHZYm7alcbx5iCjnDEhJsDGPfHhpKQ8CcoGR8RIuKMFLQd
	rpdXjGlDX+c9jFsE5M3IoJ8QrMBatyj0alPTLVtreIyDeJfG808x1X3ca5FqCCB4r3iIeFrNmik
	agob7DCNROSvphYTw+Qle4TbFTOV4eWZUQ9/xXb6a8KFkmPQnYj6oSjIsYiDVB/AAa0hz
X-Gm-Gg: ASbGncsRAOrdj1qtUWBUhTCzvouth4XGcJp65AagVW8e0cjg0XyrUFIUDu4PdXAegFf
	JbhfY0L8dvMqqggYzGpfzzfA1wW5m9YjdTH6csgdA4GRYBiKrhDpecybsT8DSkHzWZnGPaczf0b
	eVIoMaffpDJ61fLhKbVVJCkvju5g9aKYpjl4hD8ku7GMO4x1HXXGY6EfPo02HnQhcmB3QHSK/m/
	+Fi66V7a0fC9CjYZGzJg9kzVgV2pXp2Wb+OPXCvdR6ZcSSmaD4xss0M/Lc4dPtzHt0vwy3CAUjH
	xBGTV09m4fWtMHq7x8r3xgSACHQ41qMqXCHsvgTuD0bgDzAmsdPONnzF3/SJ1tEmFpcS
X-Received: by 2002:a05:600c:8b0c:b0:46e:731b:db0f with SMTP id 5b1f17b1804b1-47117912b5fmr117275945e9.28.1760983526904;
        Mon, 20 Oct 2025 11:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKOn2rHJXxk1XGL7fh+oZbTp9TC5fyJbTHX01pmlPdHVguxKM1fW81SYnR+boP0ptXFuQoEg==
X-Received: by 2002:a05:600c:8b0c:b0:46e:731b:db0f with SMTP id 5b1f17b1804b1-47117912b5fmr117275635e9.28.1760983526269;
        Mon, 20 Oct 2025 11:05:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4731c95efb9sm115965645e9.8.2025.10.20.11.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 11:05:25 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:05:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 17/19] virtio_ring: factor out split indirect
 detaching logic
Message-ID: <20251020140158-mutt-send-email-mst@kernel.org>
References: <20251020071003.28834-1-jasowang@redhat.com>
 <20251020071003.28834-18-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251020071003.28834-18-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ukjqZ_Jl0DxcIczAhj3MBi_LbZZJztKxwwtSJv_es8c_1760983527
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Oct 20, 2025 at 03:10:01PM +0800, Jason Wang wrote:
> Factor out the split indirect descriptor detaching logic in order to
> allow it to be reused by the in order support.
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c59e27e2ad68..0f07a6637acb 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -771,11 +771,42 @@ static bool virtqueue_kick_prepare_split(struct vring_virtqueue *vq)
>  	return needs_kick;
>  }
>  
> +static void detach_indirect_split(struct vring_virtqueue *vq,
> +				  unsigned int head)
> +{
> +	struct vring_desc_extra *extra = vq->split.desc_extra;

so extra is initialized here ....

> +	struct vring_desc *indir_desc =
> +	       vq->split.desc_state[head].indir_desc;
> +	unsigned int j;
> +	u32 len, num;
> +
> +	/* Free the indirect table, if any, now that it's unmapped. */
> +	if (!indir_desc)
> +		return;
> +	len = vq->split.desc_extra[head].len;
> +
> +	BUG_ON(!(vq->split.desc_extra[head].flags &
> +			VRING_DESC_F_INDIRECT));
> +	BUG_ON(len == 0 || len % sizeof(struct vring_desc));
> +
> +	num = len / sizeof(struct vring_desc);
> +
> +	extra = (struct vring_desc_extra *)&indir_desc[num];


only to be over-written here.

what's up with this?

> +
> +	if (vq->use_map_api) {
> +		for (j = 0; j < num; j++)
> +			vring_unmap_one_split(vq, &extra[j]);
> +	}
> +
> +	kfree(indir_desc);
> +	vq->split.desc_state[head].indir_desc = NULL;
> +}
> +



