Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F3625B31E
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751352166; cv=none; b=iVKcN0SY+65m6Y578McKpzszMClb8fJWb+6TZ+Pb4QDAmXaRRv0oPtB6GNr6ATqroh1RPLKFXUuRCAh0Wwo88DaXO7c3ndTcBXU2qI2F7jeSdCVcw3Uje5YwsG/HRIMXxnu1MteCTL8PlAU13dTz4fdqpv/sznTOEKZVvriHEac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751352166; c=relaxed/simple;
	bh=Pn7B9GeTDeFtWMYue92MhPEUhquMznz1o4o0hmqyizs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WcDGRZFAoqQOO6kt9HOqx3YQ0j5oKocC0Ig5JgbRP7ZLkkoXex5nCpct5G/sonRKWpdoaA/6963TmL1Otly70hCiYhPfXCNFxTh483if97bOpGz2EmJY+X188iA31lVLQP+PgCjLqQFUFLd5Kzz0yCc1ImQUHb3ZCbCvQ4Ez1Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/J4X/aH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/J4X/aH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751352163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nt9aO5ssi1t8CygdESv19zrIGluhJLXZKgDo3123Dfc=;
	b=i/J4X/aHtEW/m7y4osg5c/nAMg1wK0vdO0v1hQXCX9cwmJWVbzbqW1vCbDAHEgRuVZKcE5
	tOH/njiTRiEzC1A+mMm6CuOMF0adZzWOVigaoiTKqsKjE2HEbNQZi9AHq25oi7RdNMcDRs
	yd4rd3JB4dmgbUYIKZGkHvrtqJ5tn+Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-BZt8KBKcOPOml6oZa0P3Sw-1; Tue, 01 Jul 2025 02:42:40 -0400
X-MC-Unique: BZt8KBKcOPOml6oZa0P3Sw-1
X-Mimecast-MFC-AGG-ID: BZt8KBKcOPOml6oZa0P3Sw_1751352159
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a6d1394b07so3349791f8f.3
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 23:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751352159; x=1751956959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nt9aO5ssi1t8CygdESv19zrIGluhJLXZKgDo3123Dfc=;
        b=XB4BE/f7UiwTB6i6JIiMZyZHpl4h5GD5Fj3A58lkGSCx6xRn94irnFrmSidPstgc2T
         ZY1swSr5VDhhDOZZCPNAhjLtW8Yop/onGcYrKYC1+cmcXBQQURAbdxEKSEscVmkx2NxY
         QtTpyAEpJKVTgqeRXxPTkebERJD5UqwJADpEZiudLclagTJYpmlvc0NkUKD6Eys/Uui5
         7sNhQy9wXnAF7EPcpmfHkjSlpBLyhVwlJQkuNSg/r6sGxyD9xaaCxaqRTk7+Sbx67QrR
         NiEJsIF7t8CxDfTiaPk0gdm2LgyV4AD2JbCz6xDfVZ1Do2NtZs6JGzMCoRM68N4txgLO
         uuNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyf+Sla6JC1pl0dPJQ/4kWVMhh0Tzr7T/dkqiuwh6sejqW5C4vS1V1ArOm9yaNHtH5vvPijg6MxWuWqgZOlA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yya8WrsC4il2Kp1CrL43Fw/l2ysGdr1CEYjm2bUhxs10hzZyP4e
	0xdnkP92SLrXj2QHaMpzs8CIOYKxINqFKkoUbAO81gR67eet/sX+453/5oO4ylvmJ8K0kaMGT7G
	Wsrgv9eywamUilTUhd/t1FPnXkGS2vTZXEovLrAT+Pd1Ks2frsLEPvL8R1VJuf1oW7nko
X-Gm-Gg: ASbGncuOph1yz/BHjr4ounRslPVQT8zNP2r5dWNNxfFzoc4ykV5Iddc6h2MzDA31bNO
	53cm279d1GEeRI/JJ8bYd3DskQcF7NpL6EPfsj4TNNVrykzD+MCNcFZJOrxGXQmtoPwwtdzhKKK
	I8uBkmNkI8/v79MokBaiRUwbEFccVxxmlxHzDN3Trd9cwKSOkKbOXjLSmFmHE46i/HQ2oFlJIQX
	Lpk285XK/xk/R+r92hM8CK7oSd85AB4NvoS8dO20f3EnzzY9hU2VlqjkvD6+78Mqy3x131pJ5cI
	r+oysK20K3/vD0Nk
X-Received: by 2002:adf:9ccf:0:b0:3a5:1241:c1a3 with SMTP id ffacd0b85a97d-3a91818ca6cmr9550228f8f.50.1751352159127;
        Mon, 30 Jun 2025 23:42:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDjxR68XICmHiVr/QGaYyfS+N2TUgWC0OzSJHuzN9hU5FIv9SmkNToFgbTwtepgk2VkSqSiQ==
X-Received: by 2002:adf:9ccf:0:b0:3a5:1241:c1a3 with SMTP id ffacd0b85a97d-3a91818ca6cmr9550193f8f.50.1751352158142;
        Mon, 30 Jun 2025 23:42:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e7481sm12488983f8f.14.2025.06.30.23.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 23:42:37 -0700 (PDT)
Date: Tue, 1 Jul 2025 02:42:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 14/19] virtio_ring: determine descriptor flags at one
 time
Message-ID: <20250701023157-mutt-send-email-mst@kernel.org>
References: <20250616082518.10411-1-jasowang@redhat.com>
 <20250616082518.10411-15-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250616082518.10411-15-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sgmuJHRbOBkAC4JW2yVsi4FzXjpx7BJFSYoc3xLyvc8_1751352159
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2025 at 04:25:12PM +0800, Jason Wang wrote:
> Let's determine the last descriptor by counting the number of sg. This
> would be consistent with packed virtqueue implementation and ease the
> future in-order implementation.
> 
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index af32d1a1a1db..d5e4d4cd2487 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -570,7 +570,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  	struct vring_desc_extra *extra;
>  	struct scatterlist *sg;
>  	struct vring_desc *desc;
> -	unsigned int i, n, avail, descs_used, prev, err_idx;
> +	unsigned int i, n, c, avail, descs_used, err_idx;
>  	int head;
>  	bool indirect;
>  
> @@ -626,46 +626,47 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  		return -ENOSPC;
>  	}
>  
> +	c = 0;

initialize at point of declaration?

>  	for (n = 0; n < out_sgs; n++) {
> +		sg = sgs[n];
>  		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
>  			dma_addr_t addr;
>  			u32 len;
> +			u16 flags = 0;
>  
>  			if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr, &len, premapped))
>  				goto unmap_release;
>  
> -			prev = i;
> +			if (++c != total_sg)
> +				flags = VRING_DESC_F_NEXT;
> +

Don't like it how the logic is split.
flags isn't used before that.
So I prefer:

	flags = ++c == total_sg ? 0 : VRING_DESC_F_NEXT;

and at that point, we do not really need flags anymore:


>  			/* Note that we trust indirect descriptor
>  			 * table since it use stream DMA mapping.
>  			 */
>  			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
> -						     VRING_DESC_F_NEXT,
> +						     flags,

So just:


	i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
				     ++c == total_sg ? 0 : VRING_DESC_F_NEXT,

here and we are done.


>  						     premapped);
>  		}
>  	}
>  	for (; n < (out_sgs + in_sgs); n++) {
>  		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> +			u16 flags = VRING_DESC_F_WRITE;
>  			dma_addr_t addr;
>  			u32 len;
>  
>  			if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &addr, &len, premapped))
>  				goto unmap_release;
>  
> -			prev = i;
> +			if (++c != total_sg)
> +				flags |= VRING_DESC_F_NEXT;
> +

Don't like it that above it's "=" here it is "|=".
And flags isn't used before that.
So I prefer:

	flags = ++c == total_sg ? VRING_DESC_F_WRITE : VRING_DESC_F_WRITE | VRING_DESC_F_NEXT;

and again we don't really need the variable:


>  			/* Note that we trust indirect descriptor
>  			 * table since it use stream DMA mapping.
>  			 */
>  			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
> -						     VRING_DESC_F_NEXT |
> -						     VRING_DESC_F_WRITE,


so just:

		i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
					     (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
					     VRING_DESC_F_WRITE,


is clearer, and the patch smaller.



> -						     premapped);
> +						     flags, premapped);
>  		}
>  	}
> -	/* Last one doesn't continue. */
> -	desc[prev].flags &= cpu_to_virtio16(vq->vq.vdev, ~VRING_DESC_F_NEXT);
> -	if (!indirect && vring_need_unmap_buffer(vq, &extra[prev]))
> -		vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
> -			~VRING_DESC_F_NEXT;
>  
>  	if (indirect) {
>  		/* Now that the indirect table is filled in, map it. */
> -- 
> 2.34.1

