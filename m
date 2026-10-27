Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094176;
	b=RQmM6iQRzkb5OSRngs+RLgLFJa+fAbPLJclq+kvsIuq9epdt/YMM1TjS7e6PyRkSQxmL
	 3LFjqq7Yukr3M2uzGub17LmEX6+SE6K4XxLIKVOY/XWZ3Dkztw+oWcge2yjqVZK5lezOj
	 Shof/8+xm92E6grj/vu71P32bHojK+mas3J8M4yzN8eNubB4znRs+uNTFsvOZz6GsqHh6
	 AV3oUFNs/7WjaV8J8WpnFBINtXC7K2lWvHH8PStuiE2ESNWE4aPt7ItiXtjyWgUEFK3oq
	 EmaYQ63irfCaJyMOR1U4lzLJp9M7eiBBz1yELCd0vgVRNNUYo/zgAUbQnTIqpCvYqfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094176;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=+oMimfwV7cZjftt0OWdyMqPpN9ija5vYYfza+1oRCE4=;
	b=du7VxhaygA4WL/Icl+B5GuPjl93j8P7MffdlOWRTOcMlufkfi01vxsXjJkdVt9+ffRZc
	 KMEyOa3u6JLThULvtXQQKCoXzK/Mh6wVt45fJskjszkv//Xh9/gRwUuADjPbFmPPUWDV/
	 FmnCEm34JGM6bmKedZrMTdCtTXh/MRCZCsYCYYnoGOPmRcd5tYUhkHf9qCgzDJoMdHtg2
	 b7Y+1sD7Kts8jHfm9V6RHp6SINp+4oTKCqAjHVOl5vi7Hhab7pHGYfqNYNgVp5pcijxxj
	 2kboHW79u+Ct2nAHjSdSYj13FJUI+kPLORVMzjvsw0m+vMb3MXzxmzfdkEUyflCj4QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DVrTuZc6;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3DE606A31A
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 09:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E3DE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DVrTuZc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793094174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+oMimfwV7cZjftt0OWdyMqPpN9ija5vYYfza+1oRCE4=;
	b=DVrTuZc6aN+ZiCxZU6SP/cuYh2ldVZ2ZoQK7fsNDVA8kpEqzbnXduZLsAwsGUrkjHK9esw
	+0eJwOt6Q9QMCH5fCxhiKJgLUhyP0PRVEsDUd1hHSbxauoOdWgaNIX0vv+LZnF/lsLiUbL
	q8xct7s/8KmPhoYVwd1LtoXV/6FBb9o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-hTdkH15DNjSzFADfT4QPyg-1; Tue, 27 Oct 2026 05:42:53 -0400
X-MC-Unique: hTdkH15DNjSzFADfT4QPyg-1
X-Mimecast-MFC-AGG-ID: hTdkH15DNjSzFADfT4QPyg_1793094172
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e17d30a79so2369685f8f.3
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 02:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793094172; x=1793698972;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+oMimfwV7cZjftt0OWdyMqPpN9ija5vYYfza+1oRCE4=;
        b=cX1LZ7xmjPLVmJiP/t0dwPnB0y816mmo55WJRDsQmNdFuUFej3w566Hv6bw0OsnLRI
         j4VIDxX4FEMio8omN45NgbKv9+PpD4GARR3jsT9Q8LlyeRc2AQqwHAoI3l4V/yjLOzrs
         Yid7eY/DLkGBIfSKHigs8inHewn2ohOe5ILy4WM1zFbhjqzuVOv6ySa574Cm3UXYQa2z
         3owMB3hewVnzl60pR2x9fzNsjySgCwmDoVae8vLf/1gqbW8YdxuITYOUVNyozUvjr4Py
         YolOGb5DFT8yLloS6eOVnEYl1A0Q55Jeu4nXMHscMsMCd3TD2tbYpS86XVrtuOrgfjJx
         HbsQ==
X-Forwarded-Encrypted: i=1; AKwUvBwT9z4trjDFE41z6IN1XCE4ofM8UQBGaXgOWHvcT2TatU3/2lqaSPsjx8nBZ67TJ6Qar2XBOGPsP391d2zH1Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYLlmXM45akfS5ugNEDWlOuK8rnw42QMxr3ugFS8g0mGAw9pJqxn
	vqJ4V2896mdcTuA/SP8cdfUMy6jBzh/hj9p00iYTmy76nsLpDqRoVXrO6oy8dsxvXc4AKqkcDCP
	jMxQxy/Hc+SMbyG+GCE2aYyYGI/wCbI+7LCIF0+vsIB589JdNHQGTZA9gHOL4o7za5rEn
X-Gm-Gg: AYBFou3jqg38U+mWzSn1S9bINvZdVewV21+N9YoU1ZCkuWLb6LeE/vAnv3+/eyGm/5x
	JQlJoOzeIf9gukTfLYgTS2UmN8o5w823SnbU+/nA0NxXAGCcb1RW+Aep0+xfUnJ/w1IMQeWNmpA
	WRpsSjZpSQEZvS+4Es1nocynjtG/gQ1c57PtnDLTIijOoRIwINcUfwWbn8Qzkcjw6LR6c2JLa+r
	9f+V2gU27G48UAUw3260U7ia9RzM4VEjVf4IMTacW0bgyPaTm6txQ54YdjRnHwrgrEkKh4SXtuZ
	TPywxbSlAP3OKx9MgHgDK1P/KKINNL2/57YXb3pNfBrH8cjFVEPxjFQBTK4yEW78mpM=
X-Received: by 2002:a05:6000:2289:b0:48d:f6d2:9c88 with SMTP id ffacd0b85a97d-48e3eb9fe3emr17684503f8f.47.1793094171559;
        Tue, 27 Oct 2026 02:42:51 -0700 (PDT)
X-Received: by 2002:a05:6000:2289:b0:48d:f6d2:9c88 with SMTP id ffacd0b85a97d-48e3eb9fe3emr17684427f8f.47.1793094170889;
        Tue, 27 Oct 2026 02:42:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd3705sm25694707f8f.45.2026.10.27.02.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 02:42:49 -0700 (PDT)
Date: Tue, 27 Oct 2026 05:42:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: David Hildenbrand <david@kernel.org>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Ard Biesheuvel <ardb@kernel.org>, Kiryl Shutsemau <kas@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	virtualization@lists.linux.dev, linux-coco@lists.linux.dev,
	linux-efi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sidharth Telang <sidtelang@google.com>,
	Punit Salian <psalian@google.com>, Peter Gonda <pgonda@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Jacky Li <jackyli@google.com>,
	Steve Rutherford <srutherford@google.com>,
	David Skidmore <davidskidmore@google.com>
Subject: Re: [PATCH 01/13] virtio_ring: support per-virtqueue DMA mapping ops
Message-ID: <20261027053843-mutt-send-email-mst@kernel.org>
References: <20261027025616.1632690-1-kevinloughlin@google.com>
 <20261027025616.1632690-2-kevinloughlin@google.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261027025616.1632690-2-kevinloughlin@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mtvCjrv2zxUcjrfvVD3iuKxrtc76oPtwyC8YMshcZOM_1793094172
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2026 at 02:56:04AM +0000, Kevin Loughlin wrote:
> Allow individual virtqueues to override the device-wide DMA mapping
> operations via virtqueue_set_map_ops(). When custom per-virtqueue
> mapping operations are configured, vring_map_one_sg(), vring_unmap_one(),
> vring_mapping_error(), and the DMA sync helpers dispatch through
> vq->map_ops instead of the parent virtio_device DMA API path.
> 
> Replace vring_map_single() with vring_map_indirect() and
> vring_unmap_indirect() using the device-level mapping path (vdev->map
> or dma_map_page_attrs()) so that indirect descriptor tables continue to
> be DMA-mapped for host VMM access even when a virtqueue overrides buffer
> mapping via vq->map_ops.
> 
> Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>

Please, don't. The automatic mappings inside virtio core are there
to keep simple things, simple.

Everyone doing something funky with mappings should use the premapped API.


> ---
>  drivers/virtio/virtio_ring.c | 136 ++++++++++++++++++++++++-----------
>  include/linux/virtio.h       |   4 ++
>  2 files changed, 98 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index db678f5a80e0..9c6a1e9f0a0b 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -261,6 +261,7 @@ struct vring_virtqueue {
>  	bool we_own_ring;
>  
>  	union virtio_map map;
> +	const struct virtio_map_ops *map_ops;
>  
>  #ifdef DEBUG
>  	/* They're supposed to lock for us. */
> @@ -477,16 +478,32 @@ static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
>  	return vq->map.dma_dev;
>  }
>  
> +static inline const struct virtio_map_ops *vring_get_map_ops(const struct vring_virtqueue *vq)
> +{
> +	if (vq->map_ops)
> +		return vq->map_ops;
> +	return vq->vq.vdev->map;
> +}
> +
> +void virtqueue_set_map_ops(struct virtqueue *_vq,
> +			   const struct virtio_map_ops *map_ops)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	vq->map_ops = map_ops;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_set_map_ops);
> +
>  static int vring_mapping_error(const struct vring_virtqueue *vq,
>  			       dma_addr_t addr)
>  {
> -	struct virtio_device *vdev = vq->vq.vdev;
> +	const struct virtio_map_ops *map_ops = vring_get_map_ops(vq);
>  
>  	if (!vq->use_map_api)
>  		return 0;
>  
> -	if (vdev->map)
> -		return vdev->map->mapping_error(vq->map, addr);
> +	if (map_ops)
> +		return map_ops->mapping_error(vq->map, addr);
>  	else
>  		return dma_mapping_error(vring_dma_dev(vq), addr);
>  }
> @@ -530,15 +547,45 @@ static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist
>  	return 0;
>  }
>  
> -static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
> -				   void *cpu_addr, size_t size,
> -				   enum dma_data_direction direction)
> +static int vring_map_indirect(const struct vring_virtqueue *vq, void *cpu_addr,
> +			      size_t size, dma_addr_t *addr)
>  {
> -	if (!vq->use_map_api)
> -		return (dma_addr_t)virt_to_phys(cpu_addr);
> +	struct virtio_device *vdev = vq->vq.vdev;
> +
> +	if (!vq->use_map_api) {
> +		kmsan_handle_dma(virt_to_phys(cpu_addr), size, DMA_TO_DEVICE);
> +		*addr = (dma_addr_t)virt_to_phys(cpu_addr);
> +		return 0;
> +	}
> +
> +	if (vdev->map) {
> +		*addr = vdev->map->map_page(vq->map, virt_to_page(cpu_addr),
> +					    offset_in_page(cpu_addr), size,
> +					    DMA_TO_DEVICE, 0);
> +		if (vdev->map->mapping_error(vq->map, *addr))
> +			return -ENOMEM;
> +		return 0;
> +	}
> +
> +	*addr = dma_map_page_attrs(vring_dma_dev(vq), virt_to_page(cpu_addr),
> +				   offset_in_page(cpu_addr), size,
> +				   DMA_TO_DEVICE, 0);
> +	if (dma_mapping_error(vring_dma_dev(vq), *addr))
> +		return -ENOMEM;
>  
> -	return virtqueue_map_single_attrs(&vq->vq, cpu_addr,
> -					  size, direction, 0);
> +	return 0;
> +}
> +
> +static void vring_unmap_indirect(const struct vring_virtqueue *vq,
> +				 dma_addr_t addr, size_t size)
> +{
> +	struct virtio_device *vdev = vq->vq.vdev;
> +
> +	if (vdev->map)
> +		vdev->map->unmap_page(vq->map, addr, size, DMA_TO_DEVICE, 0);
> +	else
> +		dma_unmap_page_attrs(vring_dma_dev(vq), addr, size,
> +				     DMA_TO_DEVICE, 0);
>  }
>  
>  static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
> @@ -576,6 +623,8 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
>  	if (flags & VRING_DESC_F_INDIRECT) {
>  		if (!vq->use_map_api)
>  			goto out;
> +		vring_unmap_indirect(vq, extra->addr, extra->len);
> +		goto out;
>  	} else if (!vring_need_unmap_buffer(vq, extra))
>  		goto out;
>  
> @@ -761,10 +810,11 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  
>  	if (indirect) {
>  		/* Now that the indirect table is filled in, map it. */
> -		dma_addr_t addr = vring_map_single(
> -			vq, desc, total_sg * sizeof(struct vring_desc),
> -			DMA_TO_DEVICE);
> -		if (vring_mapping_error(vq, addr))
> +		dma_addr_t addr;
> +
> +		if (vring_map_indirect(vq, desc,
> +				       total_sg * sizeof(struct vring_desc),
> +				       &addr))
>  			goto unmap_release;
>  
>  		virtqueue_add_desc_split(vq, vq->split.vring.desc,
> @@ -1370,6 +1420,7 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
>  #endif
>  	vq->map = map;
>  	vq->use_map_api = vring_use_map_api(vdev);
> +	vq->map_ops = NULL;
>  
>  	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
>  		!context;
> @@ -1488,6 +1539,8 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>  	if (flags & VRING_DESC_F_INDIRECT) {
>  		if (!vq->use_map_api)
>  			return;
> +		vring_unmap_indirect(vq, extra->addr, extra->len);
> +		return;
>  	} else if (!vring_need_unmap_buffer(vq, extra))
>  		return;
>  
> @@ -1585,10 +1638,9 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	}
>  
>  	/* Now that the indirect table is filled in, map it. */
> -	addr = vring_map_single(vq, desc,
> -			total_sg * sizeof(struct vring_packed_desc),
> -			DMA_TO_DEVICE);
> -	if (vring_mapping_error(vq, addr))
> +	if (vring_map_indirect(vq, desc,
> +			       total_sg * sizeof(struct vring_packed_desc),
> +			       &addr))
>  		goto unmap_release;
>  
>  	vq->packed.vring.desc[head].addr = cpu_to_le64(addr);
> @@ -2620,6 +2672,7 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
>  #endif
>  	vq->map = map;
>  	vq->use_map_api = vring_use_map_api(vdev);
> +	vq->map_ops = NULL;
>  
>  	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
>  		!context;
> @@ -3064,7 +3117,7 @@ struct device *virtqueue_dma_dev(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	if (vq->use_map_api && !_vq->vdev->map)
> +	if (vq->use_map_api && !vring_get_map_ops(vq))
>  		return vq->map.dma_dev;
>  	else
>  		return NULL;
> @@ -3809,18 +3862,17 @@ EXPORT_SYMBOL_GPL(virtqueue_map_free_coherent);
>   */
>  dma_addr_t virtqueue_map_page_attrs(const struct virtqueue *_vq,
>  				    struct page *page,
> -				    unsigned long offset,
> -				    size_t size,
> +				    unsigned long offset, size_t size,
>  				    enum dma_data_direction dir,
>  				    unsigned long attrs)
>  {
>  	const struct vring_virtqueue *vq = to_vvq(_vq);
> -	struct virtio_device *vdev = _vq->vdev;
> +	const struct virtio_map_ops *map_ops = vring_get_map_ops(vq);
>  
> -	if (vdev->map)
> -		return vdev->map->map_page(vq->map,
> -					   page, offset, size,
> -					   dir, attrs);
> +	if (map_ops)
> +		return map_ops->map_page(vq->map,
> +					 page, offset, size,
> +					 dir, attrs);
>  
>  	return dma_map_page_attrs(vring_dma_dev(vq),
>  				  page, offset, size,
> @@ -3842,11 +3894,11 @@ void virtqueue_unmap_page_attrs(const struct virtqueue *_vq,
>  				unsigned long attrs)
>  {
>  	const struct vring_virtqueue *vq = to_vvq(_vq);
> -	struct virtio_device *vdev = _vq->vdev;
> +	const struct virtio_map_ops *map_ops = vring_get_map_ops(vq);
>  
> -	if (vdev->map)
> -		vdev->map->unmap_page(vq->map,
> -				      map_handle, size, dir, attrs);
> +	if (map_ops)
> +		map_ops->unmap_page(vq->map,
> +				    map_handle, size, dir, attrs);
>  	else
>  		dma_unmap_page_attrs(vring_dma_dev(vq), map_handle,
>  				     size, dir, attrs);
> @@ -3941,13 +3993,13 @@ EXPORT_SYMBOL_GPL(virtqueue_map_mapping_error);
>  bool virtqueue_map_need_sync(const struct virtqueue *_vq, dma_addr_t addr)
>  {
>  	const struct vring_virtqueue *vq = to_vvq(_vq);
> -	struct virtio_device *vdev = _vq->vdev;
> +	const struct virtio_map_ops *map_ops = vring_get_map_ops(vq);
>  
>  	if (!vq->use_map_api)
>  		return false;
>  
> -	if (vdev->map)
> -		return vdev->map->need_sync(vq->map, addr);
> +	if (map_ops)
> +		return map_ops->need_sync(vq->map, addr);
>  	else
>  		return dma_need_sync(vring_dma_dev(vq), addr);
>  }
> @@ -3971,14 +4023,14 @@ void virtqueue_map_sync_single_range_for_cpu(const struct virtqueue *_vq,
>  					     enum dma_data_direction dir)
>  {
>  	const struct vring_virtqueue *vq = to_vvq(_vq);
> -	struct virtio_device *vdev = _vq->vdev;
> +	const struct virtio_map_ops *map_ops = vring_get_map_ops(vq);
>  
>  	if (!vq->use_map_api)
>  		return;
>  
> -	if (vdev->map)
> -		vdev->map->sync_single_for_cpu(vq->map,
> -					       addr + offset, size, dir);
> +	if (map_ops)
> +		map_ops->sync_single_for_cpu(vq->map,
> +					     addr + offset, size, dir);
>  	else
>  		dma_sync_single_range_for_cpu(vring_dma_dev(vq),
>  					      addr, offset, size, dir);
> @@ -4002,15 +4054,15 @@ void virtqueue_map_sync_single_range_for_device(const struct virtqueue *_vq,
>  						enum dma_data_direction dir)
>  {
>  	const struct vring_virtqueue *vq = to_vvq(_vq);
> -	struct virtio_device *vdev = _vq->vdev;
> +	const struct virtio_map_ops *map_ops = vring_get_map_ops(vq);
>  
>  	if (!vq->use_map_api)
>  		return;
>  
> -	if (vdev->map)
> -		vdev->map->sync_single_for_device(vq->map,
> -						  addr + offset,
> -						  size, dir);
> +	if (map_ops)
> +		map_ops->sync_single_for_device(vq->map,
> +						addr + offset,
> +						size, dir);
>  	else
>  		dma_sync_single_range_for_device(vring_dma_dev(vq), addr,
>  						 offset, size, dir);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index f923e42cfd01..20fe333d6778 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -44,6 +44,7 @@ struct virtqueue {
>  };
>  
>  struct vduse_vq_group;
> +struct virtio_map_ops;
>  
>  union virtio_map {
>  	/* Device that performs DMA */
> @@ -294,6 +295,9 @@ void virtqueue_map_free_coherent(struct virtio_device *vdev,
>  				 size_t size, void *vaddr,
>  				 dma_addr_t dma_handle);
>  
> +void virtqueue_set_map_ops(struct virtqueue *_vq,
> +			   const struct virtio_map_ops *map_ops);
> +
>  dma_addr_t virtqueue_map_page_attrs(const struct virtqueue *_vq,
>  				    struct page *page,
>  				    unsigned long offset,
> -- 
> 2.56.0.307.g5fe7bd680c-goog

