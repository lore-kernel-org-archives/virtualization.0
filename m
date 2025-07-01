Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC29C26AD9
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 06:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751352300; cv=none; b=fX28jKSuRfyZ4i23P0BCAz1gvEmb2/sRTOMcp9af2EgVAoGQl1YRyjZa0BbUR3a6yjvhrXUoF+Vtjbz14yg3IsChuIuu0UVDJQXMEzyPUjXVdciBqexb4z1DUtOPRcu3GUbJBDegDmpZjfkZBDH2LnnQLTtwf35jTyuWnN/VC8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751352300; c=relaxed/simple;
	bh=2cq/p3Ujf/QZM6znvEBgDgRTAL2DLiphSQdkZ4i4r80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tqEQsfIKV25otr+Iaqqe3XzLFkhF/rHzcsSpgIWvZMRaO8jElY9C+h3aAcICMnMXle0gwhBXdgIEFS63X2mqeDdiUPgcFt7Y0ujPGmWQqZaMxmjbjHXsd6pspHXqLaBY4T/cnXP8peMCw1F9MnPLqMgLahRPAiCliNhEzPfemS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SyovE+x8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyovE+x8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751352297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Biae0HaOibcJc+UiP0IzJsOLAa3a5dn69Z3XEzox1Hg=;
	b=SyovE+x8qK9sdK7g0vePay526vaao6Jr22pS4h11EQnznxLj/WGk9HPsZPxlfUTLFcedPY
	acj4tDYjO4SyHLtX6efsAdkpXeHyT8/btt5sxKo09eDJbLiZFRqjx4oHoYTmTbJs1LLAmv
	a7LnrzMZjC0pwCQLjJJEv9/AGee3YvM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-EP-L9r81PC694xhY6gawgQ-1; Tue, 01 Jul 2025 02:44:56 -0400
X-MC-Unique: EP-L9r81PC694xhY6gawgQ-1
X-Mimecast-MFC-AGG-ID: EP-L9r81PC694xhY6gawgQ_1751352295
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4535ee06160so21513025e9.3
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 23:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751352295; x=1751957095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Biae0HaOibcJc+UiP0IzJsOLAa3a5dn69Z3XEzox1Hg=;
        b=AXoOEnC9WGhqq9kCGm1DDi6E1AMmw26uqfyCwyu7PU82n2b0NwJ4TZ70GAGL50ydTa
         UK2UgmYoN4YGXpEFDGkA/ZrHuOIt7QZR48W6Jzm4ATs2BMjOMZy8gE3IYNAcfJ1xaHBQ
         6BcEZgpezvBK+kuYjXQP2ZJMIFBCXwSYnEBS0dllKIngkzbfh+T+1RStnU9J0qvsJYEb
         bzA8OH1kFI0cfPzNp5AdqFyqQkXfks2/BIegCaJbacGmkDqR1CLKEiOcsY0MwXPWpjOc
         pfNrdmku0wvzVKj0T11Coyz/1ExK5OhPfsl6WMLNlrOlGUZT3fJgP4e8V67fs31VJoa/
         NkcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpH8vBXGglzAqaMV9KcbhKC+CCWfv8+Sjewh7DKM5LzWH08aGBC2FW8YbVLBoIDKtBmC7haDMknHpEWH5ZFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsyI+ciiSDf180YRaDVObhiCP3Iv4RgSI27KlchjYbJWlabty5
	6s4OVGccjglQEGSdOw5LerKKr7lwVshB8g1fLnWp4T+xta+omn9DL3P0mRAEyWVR0uJ8QwhRKoH
	BNENkWQqbXpqzDa6PmUXlAACJ8+Tkjaw9sffHEvJouPSW/GpSH8qTfdJ2qHU38PzkRJZC
X-Gm-Gg: ASbGncs9OALuRfFraJ8sn/7axsQ3t2GMk0WQiQw9qF9pUDoCUeoiE9KKa70qw790Qyl
	G8tgNNZlseyWG0ILzkkoGQmM02+rF6cdOjkWq8UDfY8Y+YITyFNorgAzCTaItNjdTub4PETZWID
	j9Wvn37H8B7LMVjLF8RxOsWIbA412DyMnzAHn8E4QmcwQUl/u2k1BJeb6C2rNuuPaGHU0PpXi/W
	b3PnkHt9ekmy4dRHVjbLgmRq7NPT11WaKTR45W8axisVwa5l5iMOw2gA/giBaEYPRy7HW0AdS4Y
	w4NiCK7OzzY6Oi4P
X-Received: by 2002:a5d:59c7:0:b0:3a4:fc3f:ed28 with SMTP id ffacd0b85a97d-3a8fee64fafmr16298904f8f.29.1751352295489;
        Mon, 30 Jun 2025 23:44:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5SZYUakeo17am0QQzCalgVq4U/8EgA20Q1A9i6qzirA4ICaPsq6bSj8ZyqMWcbiRUOp1koQ==
X-Received: by 2002:a5d:59c7:0:b0:3a4:fc3f:ed28 with SMTP id ffacd0b85a97d-3a8fee64fafmr16298883f8f.29.1751352295096;
        Mon, 30 Jun 2025 23:44:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad03asm187610015e9.23.2025.06.30.23.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 23:44:54 -0700 (PDT)
Date: Tue, 1 Jul 2025 02:44:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 17/19] virtio_ring: factor out split indirect
 detaching logic
Message-ID: <20250701024441-mutt-send-email-mst@kernel.org>
References: <20250616082518.10411-1-jasowang@redhat.com>
 <20250616082518.10411-18-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250616082518.10411-18-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N_L90BjtZp2cIhomeQODqNhhqLAsE5WkcEDi_NrcQAM_1751352295
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2025 at 04:25:15PM +0800, Jason Wang wrote:
> Factor out the split indirect descriptor detaching logic in order to
> make it be reused by the in order support.

allow it to be reused

> 
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index e8e0d1204f52..259380797ec4 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -773,11 +773,42 @@ static bool virtqueue_kick_prepare_split(struct vring_virtqueue *vq)
>  	return needs_kick;
>  }
>  
> +static void detach_indirect_split(struct vring_virtqueue *vq,
> +				  unsigned int head)
> +{
> +	struct vring_desc_extra *extra = vq->split.desc_extra;
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
> +
> +	if (vq->use_dma_api) {
> +		for (j = 0; j < num; j++)
> +			vring_unmap_one_split(vq, &extra[j]);
> +	}
> +
> +	kfree(indir_desc);
> +	vq->split.desc_state[head].indir_desc = NULL;
> +}
> +
>  static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  			     void **ctx)
>  {
>  	struct vring_desc_extra *extra;
> -	unsigned int i, j;
> +	unsigned int i;
>  	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
>  
>  	/* Clear data ptr. */
> @@ -801,34 +832,10 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  	/* Plus final descriptor */
>  	vq->vq.num_free++;
>  
> -	if (vq->indirect) {
> -		struct vring_desc *indir_desc =
> -				vq->split.desc_state[head].indir_desc;
> -		u32 len, num;
> -
> -		/* Free the indirect table, if any, now that it's unmapped. */
> -		if (!indir_desc)
> -			return;
> -		len = vq->split.desc_extra[head].len;
> -
> -		BUG_ON(!(vq->split.desc_extra[head].flags &
> -				VRING_DESC_F_INDIRECT));
> -		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
> -
> -		num = len / sizeof(struct vring_desc);
> -
> -		extra = (struct vring_desc_extra *)&indir_desc[num];
> -
> -		if (vq->use_dma_api) {
> -			for (j = 0; j < num; j++)
> -				vring_unmap_one_split(vq, &extra[j]);
> -		}
> -
> -		kfree(indir_desc);
> -		vq->split.desc_state[head].indir_desc = NULL;
> -	} else if (ctx) {
> +	if (vq->indirect)
> +		detach_indirect_split(vq, head);
> +	else if (ctx)
>  		*ctx = vq->split.desc_state[head].indir_desc;
> -	}
>  }
>  
>  static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
> -- 
> 2.34.1

