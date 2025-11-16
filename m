Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DC12581
	for <virtualization@lists.linux.dev>; Sun, 16 Nov 2025 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763274805; cv=none; b=mpnVkPpw04qPKsTGFNQxs3PHHNQn0CWAdrd7f7YoCdM6W2eWperG8LLNCm5i2u388tVQAc1QOelciJ3/TcEigKe55OJah7k7PlPYhnmQWIiXt4kruQRB4q+fYk9l00mcOuXWr02ZQIspIab0eVhlu+0xxyHsibPV8WD7F7+KK7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763274805; c=relaxed/simple;
	bh=WURvRpuuk12XdsZYvcXdQ1i13F9ybXWwTkb2ajgBfZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EwlSHV6DeGm5b+Cr6ayUNMtiGKWnJlrU77QHbZsWTv0NahER2EAVz/eN8xevSdq5zSv/CI1KlwhrPigafm1NruzTp6H3v5zTjCRBnma53IUcHtp8FFmXJnBwuXhZQv3r+yxz9zXNjflqFzae+2sHdAQ51jBLPOvFJz0tvhbcLgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O62TuyOs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O62TuyOs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763274803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i26Qsd4zcCbdcCUnhvn7MD8Ef78Ua9nu0uaADaCZAtc=;
	b=O62TuyOsGyIj9MukPVDSm7u1CbZvM/FFXcU6Gg9GKPfu9B0XR5NUNYdp/7gal5uo/959Yw
	dKCbqZD1ncLdNlz2PyGc8uHZrEOn1kjAQn/0iriLVXu2Cjn1SG57ZV9kP9mU7RV3nFVtnT
	FaeHfj+0vQQmIhVDUxG6ObcRFhlV31w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-XAVAHDVuMvCDQXQQkano9g-1; Sun, 16 Nov 2025 01:33:21 -0500
X-MC-Unique: XAVAHDVuMvCDQXQQkano9g-1
X-Mimecast-MFC-AGG-ID: XAVAHDVuMvCDQXQQkano9g_1763274801
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47788165c97so19226095e9.0
        for <virtualization@lists.linux.dev>; Sat, 15 Nov 2025 22:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763274800; x=1763879600;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i26Qsd4zcCbdcCUnhvn7MD8Ef78Ua9nu0uaADaCZAtc=;
        b=fD00HFGKseV3E8crHjW93C99ZJ3s04kmg1jTGePmz46Go6Q4CjTq0/Upnwa9qimuwq
         acinvqBv6UMCx6Vg4b+3GVm3D9VQFMPAu116yBJM8TKWwVnccNMECorJxVXMkv9eXnHI
         0IadQgp+CtGCuGihzbnFPJrwY5lUzFErFGKBiDS2uwmJMaRW6acFbwr3uERq6JOnBNLn
         QThCwbtA8LdzVfJlnua7hKLavfuGy+wvKwo2BvLfdm/NiY7IOe+VT9M1R1gMObiin6d+
         rj8JBUW5BMwuTj+8OBxlAOzyK8dxAMYCQ5Z+CmH0IM2wjgqPX3GFyZT6MY33cGzoPirU
         XK2g==
X-Forwarded-Encrypted: i=1; AJvYcCVfLTwSjaIAlDmL0/KxQnq1rpXJ3yZezaWwss8uufssBK3xO5/lUOjun+Q3mBcLcoFjCO+fIYbtjHTmRp18pQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7l1pkGk0x9iGHEx4YjI7g6lFZaOkE3qQ/PTtz3BrQtN6xsNtl
	gwarS/4AHm45pF1y7jMusz2ZNUMo/yHqV+myFxU8Gb2pw17RTAMTItifpbJdb7LFeBhhtA3/N/+
	CN2tnPT+aWipQowojC+/ZxAkVDioboOh4MH0qiIl2zxXWIcXF3NTrJrbRPByPeJ/AHgyp
X-Gm-Gg: ASbGnctbazIThOKuvG9JpCdNZjl6+X2IQIyyhoxH6qjDpctlL0BV9yP4H+UBo4qPAVm
	RXTAXdjTl1F5eIfpS1GkF10/Uw7kfhw3MVwFhE03VxQlXh+QtUbs5tWTbbshp76zmASyY93iNGC
	K5lkBpziJs0P78wnTdAQTFJXnIekU1tDAT0ARilCgKKzUItrfNlaIpiscUhtBNXiMQxru82pHJh
	n3SYEF3jmPfhYy85yy34YhWPzVy6lTKsKFjVWqmxVW6b0F8fCaJ4dKIqwFWI+ARApc+ewBpQc+W
	pNwXKEpEUneXmYSTYB3aBbEMNsEXGIQVIcmnC7iNk3tZAxgVXqQ5PR1RuNVG3+yq9+iO667ahvg
	aBeafq88msdpknSKftjU=
X-Received: by 2002:a05:600c:3546:b0:477:e09:f0f with SMTP id 5b1f17b1804b1-4778fe60310mr85559855e9.8.1763274800417;
        Sat, 15 Nov 2025 22:33:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJqXDNEPo7vrJ8jwAp5iZ9i1v+Q0rScb71Rsvl8FvHj8wP6hyFZpg1OUlCh2Wn2pVS/SsoyQ==
X-Received: by 2002:a05:600c:3546:b0:477:e09:f0f with SMTP id 5b1f17b1804b1-4778fe60310mr85559695e9.8.1763274799990;
        Sat, 15 Nov 2025 22:33:19 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e442c2sm244224345e9.7.2025.11.15.22.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 22:33:19 -0800 (PST)
Date: Sun, 16 Nov 2025 01:33:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] virtio_ring: kernel-doc: fix function name, function
 param warnings
Message-ID: <20251116013303-mutt-send-email-mst@kernel.org>
References: <20251115224534.3832145-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251115224534.3832145-1-rdunlap@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RGJ-3uv97RaJP9Deu_plpOLPLoVnIIAXVNfAwxAmk8U_1763274801
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sat, Nov 15, 2025 at 02:45:33PM -0800, Randy Dunlap wrote:
> Add description for the function parameter @vaddr.
> Correct the function name in a kernel-doc comment.
> 
> Fixes these warning:
> WARNING: drivers/virtio/virtio_ring.c:3174 function parameter 'vaddr' not
>  described in 'virtqueue_map_free_coherent'
> WARNING: drivers/virtio/virtio_ring.c:3308 expecting prototype for
>  virtqueue_mapping_error(). Prototype was for virtqueue_map_mapping_error()
>  instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks, already fixed in my tree.

> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: Eugenio Pérez <eperezma@redhat.com>
> Cc: virtualization@lists.linux.dev
> ---
>  drivers/virtio/virtio_ring.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- linux-next-20251114.orig/drivers/virtio/virtio_ring.c
> +++ linux-next-20251114/drivers/virtio/virtio_ring.c
> @@ -3166,6 +3166,7 @@ EXPORT_SYMBOL_GPL(virtqueue_map_alloc_co
>   * @vdev: the virtio device we are talking to
>   * @map: metadata for performing mapping
>   * @size: the size of the buffer
> + * @vaddr: virtual address of the buffer
>   * @map_handle: the mapped address that needs to be freed
>   *
>   */
> @@ -3299,7 +3300,7 @@ void virtqueue_unmap_single_attrs(const
>  EXPORT_SYMBOL_GPL(virtqueue_unmap_single_attrs);
>  
>  /**
> - * virtqueue_mapping_error - check dma address
> + * virtqueue_map_mapping_error - check dma address
>   * @_vq: the struct virtqueue we're talking about.
>   * @addr: DMA address
>   *

