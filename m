Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2B22500D4
	for <virtualization@lists.linux.dev>; Wed,  5 Mar 2025 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195676; cv=none; b=PLhSNwsD+rH+YRj/+nQMfQxThNzDV4TD9pZ+pCPp1td3J4+To4hBXWTkJA42YPpI06MvI/sGJGVfd+Ptx71uKREoYufy6D8tpN2fvMdh8nZtfqiX70FJkUBqYW+Vjuq3vEzBt3w44cukPQYTQJBLzM/Eo8zDMiIsszyGfIWkdOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195676; c=relaxed/simple;
	bh=jcn3gLjOzkthIuq4y5X/wwgHzFPhszYjMUSsslUbHsE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBepRn+1On2g8OtOZM+bzHQFqbhcDsZRMjSAruMXSERisze4z1Fyh5v+45tkh2gMB6y5PFcpJdavZpYvjRQUiDdMnbZXZ9CBS5R9aXTQ4U6ju4M3Exm9Q0YQXpnF99wq82gJNgfPnX6gOxsRwmWS2DexrU0PQXTkm+T6qVGNChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDF5KNmD; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDF5KNmD"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54963160818so4931440e87.2
        for <virtualization@lists.linux.dev>; Wed, 05 Mar 2025 09:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741195672; x=1741800472; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mQfPowMtzeZLUBwXZYQU5v1yt0PyPUIi7t8i3xRpFoI=;
        b=LDF5KNmDZ5TFH4XloiNZASJtcwva4Ywk6wjE1TY3d7qLn2MAMSzUrr4c/3Fz5xv+X3
         5bDeXl9h2Tlzq2C9tEt/69dmAEfWLkAMF2qnMhsMJCiTHVa1Wk/YEVbNhhv3q5+QVBa2
         HOQDb4QUPjFkUeRhSS2eTuF/eccCxC6J1c+B3hsuGKOkuGh+a20sccnTeI4YT4gULw92
         Bel1tcCs/AveVILd9o0fEtaYh+R2GuzXMCoItpLPPqscMy1jDcAqfyZVUJCt0mIRWfR3
         whghdHs0biiMw/a/rz40CZG025JtOq2D0SEZtOeC6YMZ7MlpGuaQvyUGegA5Oy3k0SCo
         zMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741195672; x=1741800472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQfPowMtzeZLUBwXZYQU5v1yt0PyPUIi7t8i3xRpFoI=;
        b=L9Emszm6Eb/mnhzE12ra+CRt3mHE+7I1RJnJh37CUfJN0JeR/rCBVueeBH5SgB450M
         GQVevGD9UCRaU7MPTn5n/oNfdTxNK0DR1byW4bukrOac4TpQlEhdQE/EloYFd2gETond
         JpInLLA9Y8tF3/j8mNKF/hDyjyv2eE2XpHbKIi88gc7etZiOBdWKS0iE1CSunEzvwrmD
         xezbA/Bj4jDirK5GVCyIgKYyQzLnTu0rWuRZPFfEkvGjqVHugy2nnLLYnT4j/fVzUKEW
         SVnqPBvpO3ehmOK+bxeNuUsAl9/mtRkm5KLh7aKqqA6U0xa7DWlcx6hc3g1llMc5UOx2
         eIXw==
X-Forwarded-Encrypted: i=1; AJvYcCWaMGxeDeoPKAuOExy9FKSoyThs4gMrbw7HQrC1anMuZ6EFOlrCEyPkiGyKyk8dNOs7oJY8JbzqzUCxvun1Rg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMHU0OQvm+bVPpZp1ijXuhUN1GTkFiM3q571CHbQklPvFR3jBb
	v8jAhObtEb6bRahoLc9tx3m9rXIkZiDoQ3oWemNNgWNWZLPK6bfK
X-Gm-Gg: ASbGncsbgTPlUfwEYI53KtqYhHPeiX+lXlxJgcx9RO6lYRQIfFXQZwlhxW1jOcs9A1h
	9tZHLPnIj4wftD7Ue3Iwu2djl0I5q/BSZSrSXJDp/my9Bkwpp/hLCySXoFzlRiQdNHnGKKZkDHn
	EcHkGcq94VTgjoVLPERslwf30K2Nwl12Nv6hAH6D6/0wAMc/TsL1UiWRMhq0Vz+p80cb7VO4hW3
	MQibX/kYRnsC2hlFMQlqIFQm2R4D9UCqbWKQHyESIWKHVduye60TPTL5dJfpWbkUoghJAToJdNd
	No5b5+3IEastusnBY18xBaul7dtEBYZ02Pm4j13zgkwh/eGVjYLzBf5kA9DE0UgRMtU=
X-Google-Smtp-Source: AGHT+IHyD6K0X+cwMdho8elbWUJdV3bSzGzUYT8hcFGebMzXlBqxa8XmfvT3QC4L7DaVDpeBC8TCQg==
X-Received: by 2002:a05:6512:39c5:b0:549:58d5:f899 with SMTP id 2adb3069b0e04-5497d37a98cmr1313981e87.37.1741195671718;
        Wed, 05 Mar 2025 09:27:51 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54963962fe4sm1070504e87.240.2025.03.05.09.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:27:51 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 5 Mar 2025 18:27:48 +0100
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
	akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	dmitry.osipenko@collabora.com, jfalempe@redhat.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH drm-next 1/2] vmalloc: Add atomic_vmap
Message-ID: <Z8iJlOyBjsGfqvM_@pc636>
References: <20250305152555.318159-1-ryasuoka@redhat.com>
 <20250305152555.318159-2-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305152555.318159-2-ryasuoka@redhat.com>

On Thu, Mar 06, 2025 at 12:25:53AM +0900, Ryosuke Yasuoka wrote:
> Some drivers can use vmap in drm_panic, however, vmap is sleepable and
> takes locks. Since drm_panic will vmap in panic handler, atomic_vmap
> requests pages with GFP_ATOMIC and maps KVA without locks and sleep.
> 
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
>  include/linux/vmalloc.h |   2 +
>  mm/internal.h           |   5 ++
>  mm/vmalloc.c            | 105 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 112 insertions(+)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 31e9ffd936e3..c7a2a9a1976d 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -190,6 +190,8 @@ void * __must_check vrealloc_noprof(const void *p, size_t size, gfp_t flags)
>  extern void vfree(const void *addr);
>  extern void vfree_atomic(const void *addr);
>  
> +extern void *atomic_vmap(struct page **pages, unsigned int count,
> +			 unsigned long flags, pgprot_t prot);
>  extern void *vmap(struct page **pages, unsigned int count,
>  			unsigned long flags, pgprot_t prot);
>  void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot);
> diff --git a/mm/internal.h b/mm/internal.h
> index 109ef30fee11..134b332bf5b9 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1278,6 +1278,11 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
>  void free_zone_device_folio(struct folio *folio);
>  int migrate_device_coherent_folio(struct folio *folio);
>  
> +struct vm_struct *atomic_get_vm_area_node(unsigned long size, unsigned long align,
> +					  unsigned long shift, unsigned long flags,
> +					  unsigned long start, unsigned long end, int node,
> +					  gfp_t gfp_mask, const void *caller);
> +
>  struct vm_struct *__get_vm_area_node(unsigned long size,
>  				     unsigned long align, unsigned long shift,
>  				     unsigned long flags, unsigned long start,
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a6e7acebe9ad..f5c93779c60a 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1945,6 +1945,57 @@ static inline void setup_vmalloc_vm(struct vm_struct *vm,
>  	va->vm = vm;
>  }
>  
> +static struct vmap_area *atomic_alloc_vmap_area(unsigned long size,
> +						unsigned long align,
> +						unsigned long vstart, unsigned long vend,
> +						int node, gfp_t gfp_mask,
> +						unsigned long va_flags, struct vm_struct *vm)
> +{
> +	struct vmap_node *vn;
> +	struct vmap_area *va;
> +	unsigned long addr;
> +
> +	if (unlikely(!size || offset_in_page(size) || !is_power_of_2(align)))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (unlikely(!vmap_initialized))
> +		return ERR_PTR(-EBUSY);
> +
> +	va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
> +	if (unlikely(!va))
> +		return ERR_PTR(-ENOMEM);
> +
> +	/*
> +	 * Only scan the relevant parts containing pointers to other objects
> +	 * to avoid false negatives.
> +	 */
> +	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask);
> +
> +	addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
> +				 size, align, vstart, vend);
> +
> +	trace_alloc_vmap_area(addr, size, align, vstart, vend, addr == vend);
> +
> +	va->va_start = addr;
> +	va->va_end = addr + size;
> +	va->vm = NULL;
> +	va->flags = va_flags;
> +
> +	vm->addr = (void *)va->va_start;
> +	vm->size = va_size(va);
> +	va->vm = vm;
> +
> +	vn = addr_to_node(va->va_start);
> +
> +	insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
> +
> +	BUG_ON(!IS_ALIGNED(va->va_start, align));
> +	BUG_ON(va->va_start < vstart);
> +	BUG_ON(va->va_end > vend);
> +
> +	return va;
> +}
> +
>  /*
>   * Allocate a region of KVA of the specified size and alignment, within the
>   * vstart and vend. If vm is passed in, the two will also be bound.
> @@ -3106,6 +3157,33 @@ static void clear_vm_uninitialized_flag(struct vm_struct *vm)
>  	vm->flags &= ~VM_UNINITIALIZED;
>  }
>  
> +struct vm_struct *atomic_get_vm_area_node(unsigned long size, unsigned long align,
> +					  unsigned long shift, unsigned long flags,
> +					  unsigned long start, unsigned long end, int node,
> +					  gfp_t gfp_mask, const void *caller)
> +{
> +	struct vmap_area *va;
> +	struct vm_struct *area;
> +
> +	size = ALIGN(size, 1ul << shift);
> +	if (unlikely(!size))
> +		return NULL;
> +
> +	area = kzalloc_node(sizeof(*area), gfp_mask, node);
> +	if (unlikely(!area))
> +		return NULL;
> +
> +	size += PAGE_SIZE;
> +	area->flags = flags;
> +	area->caller = caller;
> +
> +	va = atomic_alloc_vmap_area(size, align, start, end, node, gfp_mask, 0, area);
> +	if (IS_ERR(va))
> +		return NULL;
> +
> +	return area;
> +}
> +
>  struct vm_struct *__get_vm_area_node(unsigned long size,
>  		unsigned long align, unsigned long shift, unsigned long flags,
>  		unsigned long start, unsigned long end, int node,
> @@ -3418,6 +3496,33 @@ void vunmap(const void *addr)
>  }
>  EXPORT_SYMBOL(vunmap);
>  
> +void *atomic_vmap(struct page **pages, unsigned int count,
> +		  unsigned long flags, pgprot_t prot)
> +{
> +	struct vm_struct *area;
> +	unsigned long addr;
> +	unsigned long size;		/* In bytes */
> +
> +	if (count > totalram_pages())
> +		return NULL;
> +
> +	size = (unsigned long)count << PAGE_SHIFT;
> +	area = atomic_get_vm_area_node(size, 1, PAGE_SHIFT, flags,
> +				       VMALLOC_START, VMALLOC_END,
> +				       NUMA_NO_NODE, GFP_ATOMIC,
> +				       __builtin_return_address(0));
> +	if (!area)
> +		return NULL;
> +
> +	addr = (unsigned long)area->addr;
> +	if (vmap_pages_range(addr, addr + size, pgprot_nx(prot),
> +			     pages, PAGE_SHIFT) < 0) {
> +		return NULL;
> +	}
> +
> +	return area->addr;
> +}
> +
>  /**
>   * vmap - map an array of pages into virtually contiguous space
>   * @pages: array of page pointers
> -- 
> 2.48.1
> 
It is copy-paste code, so it is odd. The proposal is not a way forward
to me. Unfortunately vmalloc is not compatible with GFP_ATOMIC, there
is at least one place it is a page-table allocation entries where it is
hard-coded to the GFP_KERNEL.

Doing this without locks and synchronizations is not possible.

--
Uladzislau Rezki
