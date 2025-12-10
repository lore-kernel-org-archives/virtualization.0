Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE011C860C
	for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765357251; cv=none; b=M8PtG41RtdfPJBkGnwc2LMIF9DSb5pt30fjISDKYU+AzxQ0FcYDw0tnKhzUO7JTVMs3g/D+tRuMe8lyCzsEIHI5DHS5vEKvRLf4i46E9uevNaCUPzn4ND3XG0J7VS9KZLR7COOAN+f2Cq0gwJoodW0aMUnek0jdoWKKHg6hNvLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765357251; c=relaxed/simple;
	bh=d6Nei3NZn5zSxxP5ybHgwWaCmSFTgXzq/YIC7D8Y0Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oe8d6qrOTqwz8KWjHx2qml5kFwf2b6rNHLqsYUuH7iZM2S2GCss0ttRusuYzeQuG2qUHOCOT2xHsXHaA4UwVunXzjMYx9KB6e4LLABi0meI6BwFTehpPtBLl80H+M2mZN0t1xkwuEbeMvjdYhmgCnJkMkWl0vJAvctvpOLiDDRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXzQIogI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXzQIogI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765357247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X6+jFRyVm6N+FtnOpG1GeL7ww+mTLR6QrTsDrnCLq0I=;
	b=SXzQIogIaA4KOZ8mdMjeaS8Q6BdfkXwGoM3DA6EizY97QkiYqjAqeFOyAEv9fbFTuFOJzg
	X1Y33sTuvI5dmFO/ZbVcDTy+hMUVgxO1KVPxOjapSrbawRbL86D1KnMhmCdvOZy2x4+t+Z
	lVQbss85w+R5zonooESWKb4HUlxBsP0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-cvkvdlBdPReplumu71Z_Xw-1; Wed, 10 Dec 2025 04:00:46 -0500
X-MC-Unique: cvkvdlBdPReplumu71Z_Xw-1
X-Mimecast-MFC-AGG-ID: cvkvdlBdPReplumu71Z_Xw_1765357245
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47904cdb9bbso5340505e9.1
        for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 01:00:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765357245; x=1765962045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6+jFRyVm6N+FtnOpG1GeL7ww+mTLR6QrTsDrnCLq0I=;
        b=V3mUdqPJzmJ2VKw+jXtvzHDyzC0BKy6f3cLr57qUKNYL0nWPf4yWG/Il4Nbnlv3MQ6
         o7Qfkbi4BDK/J/zb1D4eirtVH/u5MC7DBTHOL2rvZl0deCvzkb1gN+e+9ilhzPYF8mYS
         pelwAjk/PEyHFlQc6xx3zdo6+cya8zuSXWTvFScuaPpHtNMKqotiSEHg0oFp2y9+OzPL
         0y9A7b0XPLy++d2h36kWqFNqfqjPSe51uB4IN1eBQknatJbEYKvgIl8Y+b/T4KJ6h42B
         yUor8YKcJAd0Tn63HPbh/g9sP3X7JLJN39CKwOhByxhIb4fzQK/GDCV+KCoT8y69w2t9
         QhDg==
X-Forwarded-Encrypted: i=1; AJvYcCVCO+mmsy0AdzsjiuEkS+F4twOm6svs6j854tvVEa8LuqlVGbaeALpy2bZKFnleYCr0b7oZnuDPE/UMrIHJTw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwppXbJkYUfPYWm4IZ/9N9MQXpQYVf3+F0X2/MNgXjdBhcF+eX
	RyyhHxDFFTMv6c+UvgZ+oazXVE8bx+HAkHtG6wmGhb2Fu0RGMqfDJFBSHZBTUmrufjV5EWtxISA
	0Duk5hJJ1QtEPUuairxkcTRYOa0OR/X3WpY3poDF6ih6hdAbG1bD3odrJCxbjn/BZOZHR
X-Gm-Gg: ASbGncuNcwg2tMyFhliIzJkhsO2kG/kYK92zz6pXYMD4sI03p/DeD+rF5HfU2fWeiAf
	PLrWRp2XVyeHPzGq7gk4NukKkQdH+tYANNm2IyI2L0+riJ8rmwgoVW4dA2pSszvLQ4VdChs71DR
	O/bHZqcwqsGq+hyT68MjO60q+TN9v1Dksvld51lxRGLQ7wL3v2Mzeg4ZdcYAjYz8vWhYZlFx/zv
	KFcJK2064mKgprnElMa5jpX+kk45P2tnW9Rc8xX7f5W3EkqrRsU0MF7W87bQQTQnDh7XNrVf3bo
	H2Y/wjhbDfDfMMCfj3EsBoAj8YUyywaL5pLNMaFhTlcSWNxeZr5mOWnb01dClVan4oX0jxQwgFS
	TWovGgPibBbf4JxhK1ahgUrLScA12IFU=
X-Received: by 2002:a05:600c:1796:b0:475:dadd:c474 with SMTP id 5b1f17b1804b1-47a7f94e5bdmr29121245e9.10.1765357244832;
        Wed, 10 Dec 2025 01:00:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPxx0KMRIRX8j3btiZinX+GID5lAN1DYAilF3S0rKhfOYQfGrXLaVuAUQ26OXUpi+8I8i2tw==
X-Received: by 2002:a05:600c:1796:b0:475:dadd:c474 with SMTP id 5b1f17b1804b1-47a7f94e5bdmr29120815e9.10.1765357244045;
        Wed, 10 Dec 2025 01:00:44 -0800 (PST)
Received: from redhat.com (IGLD-80-230-33-27.inter.net.il. [80.230.33.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d3e6651sm36858485e9.7.2025.12.10.01.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 01:00:43 -0800 (PST)
Date: Wed, 10 Dec 2025 04:00:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yufeng Wang <r4o5m6e8o@163.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Yuedong Wang <wyd20130109@163.com>
Subject: Re: [PATCH v2 2/2] tools: virtio: Fix no definition of
 dma_map_page_attrs
Message-ID: <20251210035947-mutt-send-email-mst@kernel.org>
References: <20251206032318.19084-1-r4o5m6e8o@163.com>
 <20251207142807.10808-1-r4o5m6e8o@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251207142807.10808-1-r4o5m6e8o@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IyNc1eOPLCUejYQTqLnMz1rTJ-OIvovC63k0fYG89LQ_1765357245
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 07, 2025 at 10:28:07PM +0800, Yufeng Wang wrote:
> Fix tools/virtio compiler error, port over the definition
> of dma_map_page_attrs, dma_unmap_page_attrs, dev_WARN_ONCE
> 
> v2: remove do {} while (0).
> 
> Fixes: 447beec8065b ("virtio_ring: switch to use dma_{map|unmap}_page()")
> Signed-off-by: Yufeng Wang <r4o5m6e8o@163.com>
> Tested-by: Yuedong Wang <wyd20130109@163.com>

Can you pls check whether
https://lore.kernel.org/all/cover.1764873799.git.mst@redhat.com/
addresses the issues for you?

Thanks!


> ---
>  tools/virtio/linux/dma-mapping.h | 3 +++
>  tools/virtio/linux/kernel.h      | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/tools/virtio/linux/dma-mapping.h b/tools/virtio/linux/dma-mapping.h
> index 095958461788..de251a1f0c37 100644
> --- a/tools/virtio/linux/dma-mapping.h
> +++ b/tools/virtio/linux/dma-mapping.h
> @@ -22,6 +22,7 @@ enum dma_data_direction {
>  #define dma_free_coherent(d, s, p, h) kfree(p)
>  
>  #define dma_map_page(d, p, o, s, dir) (page_to_phys(p) + (o))
> +#define dma_map_page_attrs(d, p, o, s, dir, a) (page_to_phys(p) + (o))
>  
>  #define dma_map_single(d, p, s, dir) (virt_to_phys(p))
>  #define dma_map_single_attrs(d, p, s, dir, a) (virt_to_phys(p))
> @@ -29,6 +30,8 @@ enum dma_data_direction {
>  
>  #define dma_unmap_single(d, a, s, r) do { (void)(d); (void)(a); (void)(s); (void)(r); } while (0)
>  #define dma_unmap_page(d, a, s, r) do { (void)(d); (void)(a); (void)(s); (void)(r); } while (0)
> +#define dma_unmap_page_attrs(d, a, s, r, t) \
> +	do { (void)(d); (void)(a); (void)(s); (void)(r); (void)(t); } while (0)
>  
>  #define sg_dma_address(sg) (0)
>  #define sg_dma_len(sg) (0)
> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> index 6702008f7f5c..460df937ba9d 100644
> --- a/tools/virtio/linux/kernel.h
> +++ b/tools/virtio/linux/kernel.h
> @@ -134,6 +134,7 @@ static inline void *krealloc_array(void *p, size_t new_n, size_t new_size, gfp_t
>  #define dev_err(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
>  #define dev_warn(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
>  #define dev_warn_once(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
> +#define dev_WARN_ONCE(dev, condition, format, ...) fprintf(stderr, format, ## __VA_ARGS__)
>  
>  #define min(x, y) ({				\
>  	typeof(x) _min1 = (x);			\
> -- 
> 2.43.0

