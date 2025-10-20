Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABA6354ADC
	for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973501; cv=none; b=aBvVcc9VpTsPjRw2NNxeUiNBnq57Xh2KjCpnpXNLg+lhpH32q4QAlZZ7a8BaJfLEf4NgzQlem/hq2x11hCjWSoZsVaqVkRPJMKr7d83hmE+3gZpNlFHQhyLOkR12amBb5hv+ybpPkys+tIBFcQ0I5CRrMrukTCjaZ3NeuuCOxzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973501; c=relaxed/simple;
	bh=R8UYyT4mUt4Cb7l78TIXqfvb6Gy3loaTBotcwJd+Pp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=AonE9H2rfVKxwPTqv2i4GkyY7c1EQ31nJxxfOO2mHSVXXysNDdFTwzh6mLoodC90MUTsZzT/X7P3E1z/bvpQJiKhXplfmgI/NWdmQ9k9wP6bM+4Y0efd5HHupBNrAq7dMpElceYRXVq3G8XtK1x1ClBa5ZRwJjUF9hnu3c235ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lzj8noMv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lzj8noMv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760973498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abiKkoYwk0LU0Chy1s73mlMtOEyiPZi25aoSUUGEVVI=;
	b=Lzj8noMvzxMT9dnTnGc9sX1d76way4sdh0kpEKtGmHJhRYc6nbHvGXcggbP4rF4PdeDREl
	O6ZuAXECpEZW53reHXTRrl+asGBBK+ExIzBftSqgM+j/WLWGHynOXdinmKBU4QEtuZFIkU
	k2Eb/jyD/96gE9MoSmXNPExgA+bzAB0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-h7-gThnsP_aEU6iL-T8GVQ-1; Mon, 20 Oct 2025 11:18:14 -0400
X-MC-Unique: h7-gThnsP_aEU6iL-T8GVQ-1
X-Mimecast-MFC-AGG-ID: h7-gThnsP_aEU6iL-T8GVQ_1760973493
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-470fd49f185so37422995e9.2
        for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 08:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760973493; x=1761578293;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abiKkoYwk0LU0Chy1s73mlMtOEyiPZi25aoSUUGEVVI=;
        b=Ey/jcKFmgqPtbKFk8BBH4/v+4HMK+i+K8O5RPajF34h80AsAXKxyjR32ro5anJMoG7
         dPj3OWDA8bkBWjiYRCTnq9LV9FJcqbOQdUoCnnw8UZ5B9tL0WnbH+yA968uCQMQKw9vn
         637UiLYfokmOfpmATvvhQrf9dthnUcJoLKDO9KQrQEg9OSgo9XYRa5LARvnGWVaKztcy
         iOk1E+aLbj+kSdsWcI4w7XOhmLANvMGyZd4K2XoZY+9kOjwnijfQp6FAqlZMealJQQZy
         pF1ZOD13036wcsfQgIjcIX4RSFY3cnGtCrTOdnC5ks3WN3He/OuInncGLXAVMj/iYfXs
         Fbhg==
X-Forwarded-Encrypted: i=1; AJvYcCUaXLQZ+eZzORAdk2TzScQfGSWEx6935VIqnYNeSfcAWwI4Tm71r1hnzrHazmRRHkFRYbsbOj/ZwUgBPEEIbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwM5CHJt72T4Vu4lFh8A2Tp3X/k8hhbN4tMzX1m+4vfz9+bDMxi
	ikmpseRlomxA7i70IYUVmh76jAYyzhtyAJ3lP43iK4XGM/XZgrz746IeYieToVy217lIir9JMCb
	15cRcRpoD0Oeyh7/1Q25V7ks/KoJi2qIfWh3cDgGkKdj3QlndBG5YvWx+aVRjGeD4P5oQ
X-Gm-Gg: ASbGncsI/ZYrtq98GBMcIkJfIiumfNwdGeIkMlJJ7WFjrygVl/gnHmfaLctFRwh2Kwd
	siUthT0NLX3Pmjw2JlIievSuTSGzsoGd61UXW1g+nmNNXTOXjz0Zr+dCtvZvC9j1/cV42Bbs7EN
	eQeSrIlQTmQEnUPRSl4rafuifHVGF3qqhjI3fplnHj9/FDYD0t9gKC47Bpd4OExTmrqwUI0JPKF
	epwY2fCQViuEbKZIw41i8N+LV0df37MV0QhHnT17dGxSm+Ft0FdXrsdAelcP1Bvx2Vx5pn8j522
	OWr/771RwMKgqnGL3ubkoNOFzLzSQzko5KHRKsN9MI4k82XUOHFqmkbuoe7H96rJpeua
X-Received: by 2002:a05:600c:350b:b0:46e:19f8:88d8 with SMTP id 5b1f17b1804b1-4711791cd8fmr127221935e9.34.1760973493041;
        Mon, 20 Oct 2025 08:18:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwoVeE8+iKkdW6UYxdhmFrKR4TN/PEWt9sSgfJ9uAbOJbQBv4uJr+4CkF5F/sLf7VzK33szQ==
X-Received: by 2002:a05:600c:350b:b0:46e:19f8:88d8 with SMTP id 5b1f17b1804b1-4711791cd8fmr127221515e9.34.1760973492486;
        Mon, 20 Oct 2025 08:18:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b9f9dsm15881960f8f.39.2025.10.20.08.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 08:18:12 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:18:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 18/19] virtio_ring: factor out split detaching logic
Message-ID: <20251020111413-mutt-send-email-mst@kernel.org>
References: <20251020071003.28834-1-jasowang@redhat.com>
 <20251020071003.28834-19-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251020071003.28834-19-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fKrlRR8j-2N5f_T6kE9o3-WhSNSZ8pHY4Fe8GxFnZDk_1760973493
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Oct 20, 2025 at 03:10:02PM +0800, Jason Wang wrote:
> This patch factors out the split core detaching logic that could be
> reused by in order feature into a dedicated function.
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 0f07a6637acb..96d7f165ec88 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -802,8 +802,9 @@ static void detach_indirect_split(struct vring_virtqueue *vq,
>  	vq->split.desc_state[head].indir_desc = NULL;
>  }
>  
> -static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> -			     void **ctx)
> +static unsigned detach_buf_split_in_order(struct vring_virtqueue *vq,
> +					  unsigned int head,
> +					  void **ctx)


Well not really _inorder, right? This is a common function.
You want to call it __detach_buf_split or something maybe.

Additionally the very first line in there is:

        __virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);

and the byte swap is not needed for inorder.
you could just do __cpu_to_virtio16(true, VRING_DESC_F_NEXT)




>  {
>  	struct vring_desc_extra *extra;
>  	unsigned int i;
> @@ -824,8 +825,6 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  	}
>  
>  	vring_unmap_one_split(vq, &extra[i]);
> -	vq->split.desc_extra[i].next = vq->free_head;
> -	vq->free_head = head;
>  
>  	/* Plus final descriptor */
>  	vq->vq.num_free++;
> @@ -834,6 +833,17 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  		detach_indirect_split(vq, head);
>  	else if (ctx)
>  		*ctx = vq->split.desc_state[head].indir_desc;
> +
> +	return i;
> +}
> +
> +static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> +			     void **ctx)
> +{
> +	unsigned int i = detach_buf_split_in_order(vq, head, ctx);
> +
> +	vq->split.desc_extra[i].next = vq->free_head;
> +	vq->free_head = head;
>  }
>  
>  static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
> -- 
> 2.31.1

