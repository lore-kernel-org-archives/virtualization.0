Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C1F275872
	for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758479398; cv=none; b=mQzLdVBN8YBObJm/E/gFRbrCerBlUcDnSQwHaDuOwG8BMNFimABWH5uMishj+ZckGy/p1PURmec+qnb7ZRoAsgb2gXvfHjbpFTUjIVPdLgs5NrAebvyH2fJ6Beko5eOXbq3YnAHf8RGl/YvpMv/VkWe5Bq+JPylUXdpjvpox8ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758479398; c=relaxed/simple;
	bh=pMyxOGeb5oVjj4fEP0W1iI+2iew8pDxqBbAOsvbwy1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=V3bSWuXvGCDobki6yCBb5MH33wM+3w58v03OMdJ0jV/KRNUZ2oBwrOAnAjTyJoVwup0GT4W7iRjc7xt0AU+thvKm7bCcOraiWo255IwyyWz9U2duJIVHHZGoMEoQfDUbxeKYOK7GjIKHf5mVulAVd1H6v4tdeJXY9ei6F4k+Jfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NOPIvULw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOPIvULw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758479395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xi3Q36Umb1ocjAnnL+rb74WQIv9fN4aAewp/7ADKp5s=;
	b=NOPIvULwLlQdRH4MSq5+UWCq1tvlYJBUmhVuxasPo9NAUcUvtCNvoL/dpq+YLs/WwGgPIX
	u6vqZE7mz6HW+BgE/REwDL5sXPKtEN765RJCVq7OTt6aaBYv6V4FwbUFdmIs/eVr4xeGsX
	cLELD+aY9zCoim04TrMM5DGXt+WMNy8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-msQmj7LkNKm1jDZDljI0uA-1; Sun, 21 Sep 2025 14:29:48 -0400
X-MC-Unique: msQmj7LkNKm1jDZDljI0uA-1
X-Mimecast-MFC-AGG-ID: msQmj7LkNKm1jDZDljI0uA_1758479387
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45f28552927so28674415e9.2
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 11:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758479387; x=1759084187;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xi3Q36Umb1ocjAnnL+rb74WQIv9fN4aAewp/7ADKp5s=;
        b=iwMtH8iEcnAXXoYUKWf4ma7jSI54ujxZFIbq6ZqCtdEcXjTXI9HbSHiKT8zBZl20Ik
         R9yjH+cOFywEj38lVs7JFSROxfj72yDItsU7Rngq47gA5iBgQylUpzYCnfExyZYM/9Fo
         IfLm7/2YuQ/Y22rBx/v3couXeeQqmSxZhXpsszlJ16vB38W83NSdcYom6MWSY9tm9o74
         HdRiCV0FBBY6XUL7DjqZ4z4vIV6PAHb1HPj2Vz6TOzd16YDwu5BJYF4GRSE8E0NrqU6S
         OWMEU6rgZJtSsrDLCMPxluMOTVgmh7JL2vTYZxVudVG4Haizu9dUJUje4n5dGX7dYl7e
         brhw==
X-Forwarded-Encrypted: i=1; AJvYcCVjGvbd2yYIr0eaTlWL/ZYzO9Fyj4WaDVj8BgPyZg720BN42I0bm9FS21mp2FlWJgEBSkWhtBXvik2SfbkgMA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6C6RqcnMS5pSXyGhsKAYME9jQfgDXLykZsE5BQhNENQBXfh8O
	Ol+PwC2eL4pwdaui5Cz44NZB/ZbBH2t5qhBvVi7iEiAPSVd226Lp6j6kAucrsH/9rTeJtWgfjxP
	ZnRWfpbJ46PjLGoFjeYEHwbuoDzPuZQ8y1qJ6P5gXI6VsK0B/UGfqpB5Zo0etBAHC2Kzr
X-Gm-Gg: ASbGncu42q1DzPd55C5zzpTA9xryvgRIBJ20IAZ63zFLYQFKvTjsE0XcPBOgqIdLkzk
	XI/cssAVDHPS23A6VYro5+spATsXJsQfcYVUN6qJvntzLK1N3632eaEM0yHgipk++el0Z45Aeox
	USc7mSpqamYpR3GwcCz1e50z7ga098SvPGtCF6/vWvjulUwrNMPkYOQWF6UyAWkNNLUnyFeYbgz
	oqqlcTdE+WhV8dkrikGQv3PUCWlXnvAdX2qAI8OwMpnFk2wpDZum+DhlsmGnVPcNgRABvPrA6tr
	vnMsRBrA9omKgn/jVk3n30WGyS4VImAarNo=
X-Received: by 2002:a05:6000:1885:b0:3de:78c8:120e with SMTP id ffacd0b85a97d-3ee7c5542dcmr7437646f8f.6.1758479387337;
        Sun, 21 Sep 2025 11:29:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu+sBvIt0LD21VK9jjeR773Ft05O6meMKTSw+bHki1OLH+aCrewOi3MGKyVBlQ1Z0xCPojyQ==
X-Received: by 2002:a05:6000:1885:b0:3de:78c8:120e with SMTP id ffacd0b85a97d-3ee7c5542dcmr7437632f8f.6.1758479386938;
        Sun, 21 Sep 2025 11:29:46 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f95c5cdaaesm4751670f8f.4.2025.09.21.11.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 11:29:46 -0700 (PDT)
Date: Sun, 21 Sep 2025 14:29:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 17/19] virtio_ring: factor out split indirect
 detaching logic
Message-ID: <20250921142505-mutt-send-email-mst@kernel.org>
References: <20250919073154.49278-1-jasowang@redhat.com>
 <20250919073154.49278-18-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250919073154.49278-18-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qOfiqYBZ9ucuLDkFRYslm_RO29GirTQAEanHFYYwYjs_1758479387
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Sep 19, 2025 at 03:31:52PM +0800, Jason Wang wrote:
> Factor out the split indirect descriptor detaching logic in order to
> make it be reused by the in order support.
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 28 deletions(-)


it is just a refactoring but the code can be prettified a bit. see
below. you can make it a separate patch if you prefer but i think
it is ok to do here.

> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f376f717c8e4..5aa0cd785362 100644
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
> +	struct vring_desc *indir_desc =
> +	       vq->split.desc_state[head].indir_desc;

We no longer need to split this.
It was like this because it was indented.
By itself  it fits under 80 chars even without and
that is no longer a hard limit.

> +	unsigned int j;
> +	u32 len, num;
> +
> +	/* Free the indirect table, if any, now that it's unmapped. */
> +	if (!indir_desc)
> +		return;


en empty line won't hurt here.

> +	len = vq->split.desc_extra[head].len;
> +
> +	BUG_ON(!(vq->split.desc_extra[head].flags &
> +			VRING_DESC_F_INDIRECT));

same thing here. no need to wrap anymore.


> +	BUG_ON(len == 0 || len % sizeof(struct vring_desc));
> +
> +	num = len / sizeof(struct vring_desc);
> +
> +	extra = (struct vring_desc_extra *)&indir_desc[num];
> +
> +	if (vq->use_map_api) {
> +		for (j = 0; j < num; j++)
> +			vring_unmap_one_split(vq, &extra[j]);
> +	}

use of {} questionable. we can keep it if you prefer though.

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
> @@ -799,34 +830,10 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
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
> -		if (vq->use_map_api) {
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
> 2.31.1

