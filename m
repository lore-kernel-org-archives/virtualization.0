Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8190135BDB7
	for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999967; cv=none; b=hcnuRZJh36dkQLgBBdh01s9iOkkTrXHu/fG21D5hZLQqFb6NKjngyP4lIWaTybbyujhBhhKBAG8NfQTTArId8WrfX1IQEFkPU1oFINH/2F5cm2/btZuBxmaULP8N9OlOIaoBehbYMCyQ+ZgR5SAC4kcKYpfkDw6nL1hnSu/3iqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999967; c=relaxed/simple;
	bh=mhFy3kw0pBtNxl+pMm5FL4NOsSRkTaVTs3CH4v2wuQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=u4tHR1oGADl0BsRuKHmUwFbMD7+XzkB9FBnHdM54tsVb38FqeQzCI5GWKwL9U9p1dRBU2yrSBbzBhGrCf6ZV8ZP58tUcfHTyV+BcHyLFHZxAduAUutVqqlG1hdUzWh+1yC1y5+fp1eAbsI6yEkwNuvkAMfyGoJqx0E9LN+2MmKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIkTYGR7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIkTYGR7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773999965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=07FEaUp+g6rgOtBILVCLBQVXaOzxOR0jWN+qcAWtOUs=;
	b=JIkTYGR7c3dBBvOm7AjpTTamir6tzeiE8i4VH5dKsqbX5bmHIvB95gYoaMgoa4Ub+NHrYU
	CnWHGe0KUKLcvrc1n2fX7NR/J2uqYZtDXtRDuf0MidObYt+hfF4tWyxx3auvdqKZXFM/4G
	F3Ir1JZZNEwd7mErYBW9utRwG74VoC0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-nUhnuDBDORq0w-lyZNp_oQ-1; Fri, 20 Mar 2026 05:46:04 -0400
X-MC-Unique: nUhnuDBDORq0w-lyZNp_oQ-1
X-Mimecast-MFC-AGG-ID: nUhnuDBDORq0w-lyZNp_oQ_1773999963
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4362197d1easo1150953f8f.2
        for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 02:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773999963; x=1774604763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07FEaUp+g6rgOtBILVCLBQVXaOzxOR0jWN+qcAWtOUs=;
        b=kpqGGI9IFQT/ZCr5lzaRaBuMU2IcDW069VYuUQ8Ek9tKu/0z1VIqSSFg0JIPmodood
         EF/VERQ6Ohi2mm1aacLgPToN+8Opsz5/TRLsyx6K3b95T+eM81i+e8fcHLCcGYWfzHIX
         89rsGwLJEnzQW9+GiIB4W8HET57xXAxdFOE5hNT6WfQyq8QoKqOavibTFpUq46oa6jDa
         A2/Xtvzu7SfvFEX+Hm0XnZN4iTF3fM7MyuIAGf5YG+sP5I0dRZDDQnX8YIXH8ioO2soX
         +LeyGYd65w/y3tCvnCD6REYHU+pqU1lsb67l0IFydBI1rCI4cPWDf8iHUUfOZNrkWtrO
         C0gg==
X-Forwarded-Encrypted: i=1; AJvYcCWNrV+2muY92r5X/cfijTiRjKBli/pyWai38zfdRKqRfXzeitM9ZHAs/nQ+NAn2aQVXuGcdEhK1LfH0QA5Zdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHmsPYo1QfssJLq16C6Rt/L0ziEtiJBzmaPuwn/6Ij/1lxP5m0
	IvJnfr5dn5YVZ7MJgi8NbPqew+BWch6ngBjwu2VNLqf79syMmDF3UVk6p+9D/xjOAz0qaIgzcC6
	EuhU1Jn7rZf3QgalaV5I7vIqbTgjJk5x1MCey4u9mW2QyFGdyK9u17mXTJESQxkoHxz2U
X-Gm-Gg: ATEYQzzWiT9dGOf1+fNCL7hRYd4amWaHWkV1HwqZOjMerUYfpRxtZ26UutDdZrkX7Ne
	h9xUHgpWMZCav2Tu9soKsHOl3uYcH7MXD+/mSNiyyStoh6URVaKOkvkEgXdXdDWcrCGwHFR4UTG
	NbeyNmIuyO0a8RT26XRifrMGaQoxIKdgJu6Phm/dq54BKazxRiSTphocZyllY8MIuzTMD+pgpgX
	LPHo7NCQxvBm/295SBSTkV2+jKGXnvf6WRXDWiKPUEEndZUtB9e6q2PwfmdD2qJ8NMMHbU41MYK
	d32uqNkyOvlGKruQSnXRkAeucMFrTphXAiwO6jqebJbDSk9tRvT/XrT/qiu1QIj+KVLB5w0iZ2n
	OwiYUcoVQ3zEptHxR
X-Received: by 2002:a05:6000:24c9:b0:43b:3c32:d8fa with SMTP id ffacd0b85a97d-43b6428269dmr4456096f8f.46.1773999962864;
        Fri, 20 Mar 2026 02:46:02 -0700 (PDT)
X-Received: by 2002:a05:6000:24c9:b0:43b:3c32:d8fa with SMTP id ffacd0b85a97d-43b6428269dmr4456034f8f.46.1773999962228;
        Fri, 20 Mar 2026 02:46:02 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae048sm5323478f8f.1.2026.03.20.02.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 02:46:00 -0700 (PDT)
Date: Fri, 20 Mar 2026 05:45:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net] virtio-net: correct DMA unmap vq mismatch in
 virtnet_xsk_pool_enable()
Message-ID: <20260320054334-mutt-send-email-mst@kernel.org>
References: <20260320013531.36931-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260320013531.36931-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9gKMtzcD3KgU4SFazCEqGoRwM68-0uq_12QVbkd2kFk_1773999963
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Patch itself is fine, thanks!
Yet something to improve in the log:

On Fri, Mar 20, 2026 at 09:35:31AM +0800, Xuan Zhuo wrote:
> When enabling the XSK pool, the header DMA address is mapped against
> the send queue's virtqueue (sq->vq). However, the error handling path
> incorrectly attempts to unmap it against the receive queue's virtqueue
> (rq->vq).
> 
> Ensure the unmap operation uses the same virtqueue used for mapping to
> maintain DMA API consistency.


DMA API is fine: we end up with:

void virtqueue_unmap_page_attrs(const struct virtqueue *_vq,
                                dma_addr_t map_handle,
                                size_t size, enum dma_data_direction dir,
                                unsigned long attrs)
{
        const struct vring_virtqueue *vq = to_vvq(_vq);
        struct virtio_device *vdev = _vq->vdev;

        if (vdev->map)
                vdev->map->unmap_page(vq->map,
                                      map_handle, size, dir, attrs);
        else
                dma_unmap_page_attrs(vring_dma_dev(vq), map_handle,
                                     size, dir, attrs);
}
EXPORT_SYMBOL_GPL(virtqueue_unmap_page_attrs);


So what matters is the device and it's the same for all vqs.
A better way to put it:



	While harmless (both vqs share the same device for DMA) it is cleaner
	to map and unmap using the same vq.


> Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")


And I'd drop the fixes tag.


> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>





> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d6a9c6a5a2..7c6f304b7be5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5917,7 +5917,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
>  err_rq:
>  	xsk_pool_dma_unmap(pool, 0);
>  err_xsk_map:
> -	virtqueue_unmap_single_attrs(rq->vq, hdr_dma, vi->hdr_len,
> +	virtqueue_unmap_single_attrs(sq->vq, hdr_dma, vi->hdr_len,
>  				     DMA_TO_DEVICE, 0);
>  err_free_buffs:
>  	kvfree(rq->xsk_buffs);
> -- 
> 2.32.0.3.g01195cf9f

