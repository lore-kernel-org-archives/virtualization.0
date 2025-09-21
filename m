Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33E218EB0
	for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758476830; cv=none; b=fVAvV1tZglwlJQ515oehqqcvinTuOg3+5Uj21mt/PdwihnTcxELjcK+mNbJZeQkafJEOztwqfDWTPjpCoA7ipyIp9zzEP9NQrdkR8tYAvhS7/PB6MsqG4gTmkf6R8cbmR+EovcPveo7SITcWtvDsgJKvenEGHr4kUmI0Z+TU5tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758476830; c=relaxed/simple;
	bh=+95EJpfbtm4S9OdNcUzPzqQu+cNcUrTSmKMmlF66Bzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EhpU3gFeXO5w1WLXBQu2tADlpIEQ/27dQREEGDl1zBGSZj2wKyakGQaZBWIUWV+Xgnj5x+Jnd5wo2cHMdWEqpp9ZGo2VX0jYHPFxoaZilJVkV9k5JAFoqy7nfS7GZ3xPPUK5zek/tloMkvzJu8MsCsZ5f12ybYp8YQKVao/YEaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClQ5GO8p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClQ5GO8p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758476827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWQDJIxZ9xQus8Xy+3Cne3CrBxdggcAgVrBwiy0GpC4=;
	b=ClQ5GO8pjTyy/JO2fve4wakmo3lng1zg5AbypIIA9tSyvC3/iSAj2QI2+yY+TMU292SIB4
	IoJPsjKraNhiLdEk4m4vAP5ivbjK3yRmg0jwUmdUMwPBQEpPRdcrhXnb5nbaqsBu3JIJHj
	G3hXTYtRX3OKtEsj154ZlcJrD92guDY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-9gpQ-fbfOdS2IN_vyhzrdA-1; Sun, 21 Sep 2025 13:47:06 -0400
X-MC-Unique: 9gpQ-fbfOdS2IN_vyhzrdA-1
X-Mimecast-MFC-AGG-ID: 9gpQ-fbfOdS2IN_vyhzrdA_1758476825
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45de27bf706so19546175e9.0
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 10:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758476825; x=1759081625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BWQDJIxZ9xQus8Xy+3Cne3CrBxdggcAgVrBwiy0GpC4=;
        b=JR6WK+h2pHf/+BD3Zu8MQ/X1gaM5iTcZzn3Y/D7mTF7KAbK78YmID2bNmVkhSxO+Sk
         ws3DlCrKjLs6TufdoG4mKI6z8l1ZWknU+FHE2dNgqkCjSGEEoWJSgdWdTnQbVoQzoQiX
         VkZLcbw++HI03K/qcPJMRGU2kG+R8hJ5Y4ArbAh/oF/gLE6KS58n6MjPDS0U91P40xRK
         gNkdtz4e2W0UAdAQufDL0Wl6PKaeIUrfnTQP20rc7sCBnSJHAhLTyTl5g90NoZTc2h3Z
         dEptJb1ZEW4x0+FzXJMVMAmY5PKalGSXH4UVDHDrlGr/EBWihFOJvvTS7xXUdQ1LxGxC
         Y1sw==
X-Forwarded-Encrypted: i=1; AJvYcCUKgY+XaWUuzgpi3wyBwVunQyoCCFujHLRxBOaYwiyPpMJ6k5sTkl2SBeBKGdlJqUXbO8HGke2JiRiL127qkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtB29DD2obM88vpu7dK/n/PMfrayBUKJEexKM1MBUPXGpXueFD
	aGF5iwekF/+3EldLjCf8i3+y1pZ2aMaKr5vmjUBtlRcMKR2ok34v38Iv9d9x8p1N2nNulxXav9B
	zY9t6LgBnJAr3hhZKnBhoSeECF9W08YEUujTjQXIiv6ZBeJHP+HPjYrZOgkI0EpIDJ0tJ
X-Gm-Gg: ASbGncvEXa/WtqfUNPWaY2gx2uogEkdg65Pf9pUQC2Kd/aTDmxPWmy8IEnrFWjES+YJ
	Wy1iJ6ozjtskwkHK+0lU0AaVhp6ZFWWnyIiXVwPZFdYZxVX18EqQ3TOYYZDpY250sIMgRYW+BEC
	SmWMJCL2jwiWs+B062N5ApfU3zWHNqZXpj4y+gkZ4vWlZ7z6B9CtPObd7636FPULcSmM1G0Rh8h
	UfGrexqZXoGPpPcjZ+Ry00+i14/NNunzAFicH9WYpWfDLCMH2unTzVgew0ae7y1SKaZ97U+EXQ3
	u/vePtz+rjUhuyQLurIpuNzwFrmZZiMcMfE=
X-Received: by 2002:a05:600c:4ed1:b0:45f:2940:d186 with SMTP id 5b1f17b1804b1-467efeda4bcmr76869965e9.32.1758476824775;
        Sun, 21 Sep 2025 10:47:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4VjCQVZf6TthDuRaqyhVdUIeEJi6lt+Y/Gp2dhJjTZmoG1ti5YvU6HiwKPLRgLeOaiCmXIA==
X-Received: by 2002:a05:600c:4ed1:b0:45f:2940:d186 with SMTP id 5b1f17b1804b1-467efeda4bcmr76869895e9.32.1758476824343;
        Sun, 21 Sep 2025 10:47:04 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f1549285c9sm9585991f8f.52.2025.09.21.10.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 10:47:03 -0700 (PDT)
Date: Sun, 21 Sep 2025 13:47:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 06/19] virtio_ring: switch to use vring_virtqueue for
 virtqueue_add variants
Message-ID: <20250921134601-mutt-send-email-mst@kernel.org>
References: <20250919073154.49278-1-jasowang@redhat.com>
 <20250919073154.49278-7-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250919073154.49278-7-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3acTaa7bB-mo3FRZlZE-Am3c8ucoGSHtQL6uq1hDacg_1758476825
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Sep 19, 2025 at 03:31:41PM +0800, Jason Wang wrote:
> Those variants are used internally so let's switch to use
> vring_virtqueue as parameter to be consistent with other internal
> virtqueue helpers.
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 40 +++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index aadeab66e57c..93c36314b5e7 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -476,7 +476,7 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
>  	return extra->next;
>  }
>  
> -static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
> +static struct vring_desc *alloc_indirect_split(struct vring_virtqueue *vq,
>  					       unsigned int total_sg,
>  					       gfp_t gfp)
>  {
> @@ -505,7 +505,7 @@ static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
>  	return desc;
>  }
>  
> -static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
> +static inline unsigned int virtqueue_add_desc_split(struct vring_virtqueue *vq,
>  						    struct vring_desc *desc,
>  						    struct vring_desc_extra *extra,
>  						    unsigned int i,
> @@ -513,11 +513,12 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
>  						    unsigned int len,
>  						    u16 flags, bool premapped)
>  {
> +	struct virtio_device *vdev = vq->vq.vdev;
>  	u16 next;
>  
> -	desc[i].flags = cpu_to_virtio16(vq->vdev, flags);
> -	desc[i].addr = cpu_to_virtio64(vq->vdev, addr);
> -	desc[i].len = cpu_to_virtio32(vq->vdev, len);
> +	desc[i].flags = cpu_to_virtio16(vdev, flags);
> +	desc[i].addr = cpu_to_virtio64(vdev, addr);
> +	desc[i].len = cpu_to_virtio32(vdev, len);
>  
>  	extra[i].addr = premapped ? DMA_MAPPING_ERROR : addr;
>  	extra[i].len = len;
> @@ -525,12 +526,12 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
>  
>  	next = extra[i].next;
>  
> -	desc[i].next = cpu_to_virtio16(vq->vdev, next);
> +	desc[i].next = cpu_to_virtio16(vdev, next);
>  
>  	return next;
>  }
>  
> -static inline int virtqueue_add_split(struct virtqueue *_vq,
> +static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  				      struct scatterlist *sgs[],
>  				      unsigned int total_sg,
>  				      unsigned int out_sgs,
> @@ -540,7 +541,6 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  				      bool premapped,
>  				      gfp_t gfp)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	struct vring_desc_extra *extra;
>  	struct scatterlist *sg;
>  	struct vring_desc *desc;
> @@ -565,7 +565,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	head = vq->free_head;
>  
>  	if (virtqueue_use_indirect(vq, total_sg))
> -		desc = alloc_indirect_split(_vq, total_sg, gfp);
> +		desc = alloc_indirect_split(vq, total_sg, gfp);
>  	else {
>  		desc = NULL;
>  		WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
> @@ -612,7 +612,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  			/* Note that we trust indirect descriptor
>  			 * table since it use stream DMA mapping.
>  			 */
> -			i = virtqueue_add_desc_split(_vq, desc, extra, i, addr, len,
> +			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
>  						     VRING_DESC_F_NEXT,
>  						     premapped);
>  		}
> @@ -629,14 +629,14 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  			/* Note that we trust indirect descriptor
>  			 * table since it use stream DMA mapping.
>  			 */
> -			i = virtqueue_add_desc_split(_vq, desc, extra, i, addr, len,
> +			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
>  						     VRING_DESC_F_NEXT |
>  						     VRING_DESC_F_WRITE,
>  						     premapped);
>  		}
>  	}
>  	/* Last one doesn't continue. */
> -	desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> +	desc[prev].flags &= cpu_to_virtio16(vq->vq.vdev, ~VRING_DESC_F_NEXT);
>  	if (!indirect && vring_need_unmap_buffer(vq, &extra[prev]))
>  		vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
>  			~VRING_DESC_F_NEXT;
> @@ -649,7 +649,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  		if (vring_mapping_error(vq, addr))
>  			goto unmap_release;
>  
> -		virtqueue_add_desc_split(_vq, vq->split.vring.desc,
> +		virtqueue_add_desc_split(vq, vq->split.vring.desc,
>  					 vq->split.desc_extra,
>  					 head, addr,
>  					 total_sg * sizeof(struct vring_desc),
> @@ -675,13 +675,13 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	/* Put entry in available array (but don't update avail->idx until they
>  	 * do sync). */
>  	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> -	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> +	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(vq->vq.vdev, head);
>  
>  	/* Descriptors and available array need to be set before we expose the
>  	 * new available array entries. */
>  	virtio_wmb(vq->weak_barriers);
>  	vq->split.avail_idx_shadow++;
> -	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> +	vq->split.vring.avail->idx = cpu_to_virtio16(vq->vq.vdev,
>  						vq->split.avail_idx_shadow);
>  	vq->num_added++;
>  
> @@ -691,7 +691,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	/* This is very unlikely, but theoretically possible.  Kick
>  	 * just in case. */
>  	if (unlikely(vq->num_added == (1 << 16) - 1))
> -		virtqueue_kick(_vq);
> +		virtqueue_kick(&vq->vq);
>  
>  	return 0;
>  
> @@ -706,7 +706,6 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	for (n = 0; n < total_sg; n++) {
>  		if (i == err_idx)
>  			break;
> -
>  		i = vring_unmap_one_split(vq, &extra[i]);
>  	}
>

can't say I like this, error handling is better separated visually from
good path.
  
> @@ -1440,7 +1439,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	return -ENOMEM;
>  }
>  
> -static inline int virtqueue_add_packed(struct virtqueue *_vq,
> +static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
>  				       struct scatterlist *sgs[],
>  				       unsigned int total_sg,
>  				       unsigned int out_sgs,
> @@ -1450,7 +1449,6 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  				       bool premapped,
>  				       gfp_t gfp)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	struct vring_packed_desc *desc;
>  	struct scatterlist *sg;
>  	unsigned int i, n, c, descs_used, err_idx, len;
> @@ -2262,9 +2260,9 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, total_sg,
> +	return vq->packed_ring ? virtqueue_add_packed(vq, sgs, total_sg,
>  					out_sgs, in_sgs, data, ctx, premapped, gfp) :
> -				 virtqueue_add_split(_vq, sgs, total_sg,
> +				 virtqueue_add_split(vq, sgs, total_sg,
>  					out_sgs, in_sgs, data, ctx, premapped, gfp);
>  }
>  
> -- 
> 2.31.1

