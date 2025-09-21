Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F014A0A
	for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758479437; cv=none; b=RoJqN+4VuQDipVttzfiiqiwgPrhpIwqXV8EcNI63Kv5Nycw2LSoIUcM0zSQxFJTWzc3G1Cuye+zI67hshCnBaFtbIMl9/lkZyTDscjia1Nv1pEAZRTiBaobmX4jsq0U8z5Rordt0ayG2Zz0F/YXm/ykP4Gob3om9q8bzFCww0iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758479437; c=relaxed/simple;
	bh=PMDUKQQmZGqLpivLY4JWsbJn9ktkVyhHNKqEF0O+HkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ILmLwT0G/kF6oI/AfVxOs2zqhyAnViFwPXft800RIlK/V/SPrI3Hewq6qFIY2va4fdsfSYWwax+A11UVcMGPQXfitVwQLCUIlktkVXrZsmecEVe/DK0NGIKTmFGHhbLxnug9Gd4Cf4ttMZ+GMM25Q09CCfGl/7hijDbtIfCRAkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NTukhB4y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTukhB4y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758479434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtLN1C8BH/iw2KBS7duzlUD7pYh8eLvynIT5XvElx4c=;
	b=NTukhB4yshk92HKWGu9RCFOsBDB/67NpD+dJXJcGSjUBlK+ru2lr1lsCFrQnhmhowg4kRl
	yaBAT/e8PuOGDwQ3TKdUGDvfbZNySWTzaQZElXsYRQlTryxEAqfc6uIbovUFqNTDdOlUyn
	ic5iB72/BjbwtJ0Kdcy7ga9Bit+QwXQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-IYyqEnGKP32XCGEGFTXNIw-1; Sun, 21 Sep 2025 14:30:33 -0400
X-MC-Unique: IYyqEnGKP32XCGEGFTXNIw-1
X-Mimecast-MFC-AGG-ID: IYyqEnGKP32XCGEGFTXNIw_1758479432
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f456d4db0aso725454f8f.1
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 11:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758479432; x=1759084232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtLN1C8BH/iw2KBS7duzlUD7pYh8eLvynIT5XvElx4c=;
        b=XjgJ3+PFKaMCSz+F9M3bJApbtEbMNDkOo94pS+dLA40SIrrWlDxaULJDezDBA18Mwx
         ON/bZPIwGLCsylj71MvlWcyHZvAu8yms3hslpUTz+eq4jsZARoE4F6q5mBf6liCw2lZg
         ffktsvNIim5xgzqzWcwxSsmdAS+eNqlEtskTVN/R6hUG6R2AS+eoQA+5UdbM8dBmXkav
         Muo54Pg1UmL6Bx7E9ABvJCCBs1WIy3wFcd7yzKW/FFqqBDnESZYta+u9OrQ0UFToLAU+
         8+rOBdbgeClA/0os+SpIHSefZRY2hy7vxSs6H/i2g4VYaooBSqGuAMTluWBFjyLpgUJr
         qnJw==
X-Forwarded-Encrypted: i=1; AJvYcCUdhF3NL3cH8AV7/EwNTzAMGR01pwHGzxQLrlYyYauWmmAkXjWWXB0gs2r1nSzIe0ZWv9hV/ceJZSeR5U2dsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxP0f6diFoLD9PGg+0ji86GhrmvxgERIwJHvzsCUOPaZ+F7Q9Du
	C3yHALCmjqqPQb8MZAsEc7H92ZRgEYvJx/lVgkddP2ONCqiUr66wySNJ3ekp5PQUfcJ4vTnw0nm
	RNbEJ5NGaOIoXezyGmvNkL/4i0du/PcPbCfHKNVKCUgKfCTxaF8Lw/Lxk0/scbsaK+Ixy
X-Gm-Gg: ASbGnct1vaIU/AuRIFNTlQSzSnAZsty2rFLQ2BpkatN/5AvNUsEWE6kkca/DjsVHuT1
	V0ClVTASNPleXE1nXL6U069D+bij2Te5fpgHC+VPNZT5rYny4rMgA1vsGIcTuFMTE3sbCFeq5nd
	d3QQFeyE70xb7S/jRx4qJAa5s+ZfZPYo7t5eCXwO6MQHoB9wiqiT47OELp39/Lk3Olwieoebleh
	0BJ0id+h4mLTVENHPY1Hr7+KlIi7Tk/fesglHVZAp/RoGFd6Zc40h9xYXjPIpeYaIZyUsaUFI+z
	r7lgldAAxmwdLF7mORQZMV3k+XG3DVf0LGE=
X-Received: by 2002:a05:6000:4210:b0:3e7:6197:9947 with SMTP id ffacd0b85a97d-3ee868a74bamr9345042f8f.53.1758479431879;
        Sun, 21 Sep 2025 11:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3f4teE4HzWpOGKP+JaITqWsn77PVM6zJ/ttnb3obDGEXcGZ4GaGHy94uIwfy2e7Adqzj5HQ==
X-Received: by 2002:a05:6000:4210:b0:3e7:6197:9947 with SMTP id ffacd0b85a97d-3ee868a74bamr9345017f8f.53.1758479431238;
        Sun, 21 Sep 2025 11:30:31 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f325c3c29sm128771735e9.3.2025.09.21.11.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 11:30:30 -0700 (PDT)
Date: Sun, 21 Sep 2025 14:30:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 17/19] virtio_ring: factor out split indirect
 detaching logic
Message-ID: <20250921143014-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: OjT2uXwV2qeC88j2AL0fE3EaQ9WMreBstizu7nbPYRY_1758479432
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Sep 19, 2025 at 03:31:52PM +0800, Jason Wang wrote:
> Factor out the split indirect descriptor detaching logic in order to
> make it be reused by the in order support.

and I think you mean "allow it to be reused"

> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 28 deletions(-)
> 
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
> +	if (vq->use_map_api) {
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

