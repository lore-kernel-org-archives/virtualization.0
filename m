Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7221B14BF92
	for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465387; cv=none; b=o/zIkczM3vWtSR3Ok5rI14HriBBYNasMzfaLnKT21XxuQY2RJvXk1dLLve17aRFu7wSLt4juuKg9Frujy0Ov7x3xUVt+KVxgLZfGT6ie5vi+VxRCgqpTnQOc8p/8QKAdPFru5lmaX/y/UEWALFKgoQpp9xRQ5bpZYE3s6/Auplg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465387; c=relaxed/simple;
	bh=zvIgi/JrDpd3uFKVpnFPu0zTuZP5BgxoMlA9LEDO55Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MG8KPZQTGoAwAZeClfIhVo8RPjfyVTcuaE7sY1C/MsEDmRupnAXJIM3MYvJRCdzeDAZ6iXRpFguciJihzaHch3vAJb0zeH3NTU/WlNWMoXfLssTW9+irm6Dfuaqa7+6XioLBT87hbWhLlKC29zHK1roNjYrYNd2+k3uGW0eMwtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jCSskpeb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCSskpeb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768465385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FepNg6RrcQjnyphAxg43fRgBRnrjl9JjAn5yaxq07GI=;
	b=jCSskpebWfyPKW+GD+r9hzHkmchHC9S/G5reH1i2bC4V39enJJ+gBhb8MJKr5emS+ceiBJ
	UgMkMCpqcco0aAhp0ufscwU6awDhKdOkRgYK6E+rRxJMM68xk+MlinxcynaReLutvSNwNG
	GTW+AtNiIoS+iI1+JmXf07m4/08sSAQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-0BXpZl1WM8eb9AzM_G0TDg-1; Thu, 15 Jan 2026 03:23:03 -0500
X-MC-Unique: 0BXpZl1WM8eb9AzM_G0TDg-1
X-Mimecast-MFC-AGG-ID: 0BXpZl1WM8eb9AzM_G0TDg_1768465383
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34ab459c051so1450305a91.0
        for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 00:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768465382; x=1769070182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FepNg6RrcQjnyphAxg43fRgBRnrjl9JjAn5yaxq07GI=;
        b=bZACPxjN15Ey4HaDiprRIQ7p7I+h7M0EbEEbJg8QNJYlRibbz2EURzQAcDTQxXePMZ
         O/5oK6W87Vfs4rNFqwg6zki8rTTZY+DjtUFw6+4q1mhLfzVK/Uogy4gdG1dYLkZrOctX
         rz/nC1AjmvKAO4fKcFpQVoI5LWvNqIpLOvNl3dvy1lFNR/S+wHW26CGdW6CWVtEzdqvu
         nBxAvzrjAvH3XgVzdr0hi3UYY9wHZNJYSPlt6XqJyGpu2Cr09E9Xd02xeuQlAaHlfvAQ
         YteAgXhdAInoqPzgpP95/ZE0JoOjfCtIFkLy1FvuCK/vrZKgZNlNaKBOdf8En6A7ZWnu
         B7Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXtyxpVJB65924jUkK+sWsClzJ5NUK32hrKR85Jyhz4EtbeUPzuhSXlVINaYA98yMKdTGtqjP1EBm3c1bDz9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaCAStZNjpqkRtx2RK4GU38aV1fw45LwL2yFJ9LhoKk36DFgB0
	nozdAEeXYiCJoLBZMEh4llJGQWnDHAdf0jjt1O7rKVl9a/DMEZX/SBcKIU3JcK6myEhB3tgsPxa
	FRJmhUC9CyiY8zO1tzzfpmoJM2zNVQ+DDsOZTYY4RFlr0FiLmVIvZ4c5MjBYYeX1PfJ1Niq6XM9
	diOUNE2xPPQ6PuC4imzyV6WRQNJpxli8i1pe4KmSJA4ZE=
X-Gm-Gg: AY/fxX7yRhKH7b1JMCmVXSw5lqiOZ03XXAprwd3nVx94X0VuDWAhaAVvQhCGyLNktIQ
	c1T8IapUCPMXpVEuObFlZciWiD5oQPqXgmoxqcLjoIzcMeiFjCPqt3Yz1SdcLA7r3MKOVKMwJmn
	miqI8MFusOu5tXQKqhLcfNGLo3lt82hxUNQHY0J7fVR38UwxM3R/L8j30S2BH6jJ0y2X4=
X-Received: by 2002:a17:90b:4c0d:b0:32d:db5b:7636 with SMTP id 98e67ed59e1d1-3510b1454f1mr4536923a91.27.1768465382638;
        Thu, 15 Jan 2026 00:23:02 -0800 (PST)
X-Received: by 2002:a17:90b:4c0d:b0:32d:db5b:7636 with SMTP id
 98e67ed59e1d1-3510b1454f1mr4536902a91.27.1768465382202; Thu, 15 Jan 2026
 00:23:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260114184839.926884-1-eperezma@redhat.com> <20260114184839.926884-10-eperezma@redhat.com>
In-Reply-To: <20260114184839.926884-10-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 15 Jan 2026 16:22:49 +0800
X-Gm-Features: AZwV_Qhvumi-95LbNghpgComZ_dH7xvMlv-idS8798zBQrLE8qmej2vZXaYzTbk
Message-ID: <CACGkMEuMsz8ao0btTixZ=Lh7GadyxdOtu4HQeF=c7=TTirmV+A@mail.gmail.com>
Subject: Re: [PATCH v12 09/13] vduse: take out allocations from vduse_dev_alloc_coherent
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5j-g7QBfvcq01lKX1zas5a8eqICHcmwcFpFbOmqQAU4_1768465383
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 2:49=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> The function vduse_dev_alloc_coherent will be called under rwlock in
> next patches.  Make it out of the lock to avoid increasing its fail
> rate.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v12:
> * Avoid free_pages_exact(NULL, size) in case vduse_domain_alloc_coherent
>   fails (MST).
>
> v11: Remove duplicated call to free_pages_exact (Jason).
> ---
>  drivers/vdpa/vdpa_user/iova_domain.c | 24 +++++++-----------------
>  drivers/vdpa/vdpa_user/iova_domain.h |  5 ++---
>  drivers/vdpa/vdpa_user/vduse_dev.c   | 17 +++++++++++------
>  3 files changed, 20 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_use=
r/iova_domain.c
> index 309cd5a039d1..0a9f668467a8 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -493,17 +493,15 @@ void vduse_domain_unmap_page(struct vduse_iova_doma=
in *domain,
>         vduse_domain_free_iova(iovad, dma_addr, size);
>  }
>
> -void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
> -                                 size_t size, dma_addr_t *dma_addr,
> -                                 gfp_t flag)
> +dma_addr_t vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
> +                                      size_t size, void *orig)
>  {
>         struct iova_domain *iovad =3D &domain->consistent_iovad;
>         unsigned long limit =3D domain->iova_limit;
>         dma_addr_t iova =3D vduse_domain_alloc_iova(iovad, size, limit);
> -       void *orig =3D alloc_pages_exact(size, flag);
>
> -       if (!iova || !orig)
> -               goto err;
> +       if (!iova)
> +               return DMA_MAPPING_ERROR;
>
>         spin_lock(&domain->iotlb_lock);
>         if (vduse_iotlb_add_range(domain, (u64)iova, (u64)iova + size - 1=
,
> @@ -514,17 +512,12 @@ void *vduse_domain_alloc_coherent(struct vduse_iova=
_domain *domain,
>         }
>         spin_unlock(&domain->iotlb_lock);
>
> -       *dma_addr =3D iova;
> +       return iova;
>
> -       return orig;
>  err:
> -       *dma_addr =3D DMA_MAPPING_ERROR;
> -       if (orig)
> -               free_pages_exact(orig, size);
> -       if (iova)
> -               vduse_domain_free_iova(iovad, iova, size);
> +       vduse_domain_free_iova(iovad, iova, size);
>
> -       return NULL;
> +       return DMA_MAPPING_ERROR;
>  }
>
>  void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t=
 size,
> @@ -533,7 +526,6 @@ void vduse_domain_free_coherent(struct vduse_iova_dom=
ain *domain, size_t size,
>         struct iova_domain *iovad =3D &domain->consistent_iovad;
>         struct vhost_iotlb_map *map;
>         struct vdpa_map_file *map_file;
> -       phys_addr_t pa;
>
>         spin_lock(&domain->iotlb_lock);
>         map =3D vhost_iotlb_itree_first(domain->iotlb, (u64)dma_addr,
> @@ -545,12 +537,10 @@ void vduse_domain_free_coherent(struct vduse_iova_d=
omain *domain, size_t size,
>         map_file =3D (struct vdpa_map_file *)map->opaque;
>         fput(map_file->file);
>         kfree(map_file);
> -       pa =3D map->addr;
>         vhost_iotlb_map_free(domain->iotlb, map);
>         spin_unlock(&domain->iotlb_lock);
>
>         vduse_domain_free_iova(iovad, dma_addr, size);
> -       free_pages_exact(phys_to_virt(pa), size);
>  }
>
>  static vm_fault_t vduse_domain_mmap_fault(struct vm_fault *vmf)
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_use=
r/iova_domain.h
> index 081f06c52cdc..e50e55d1396f 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.h
> +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> @@ -65,9 +65,8 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *=
domain,
>                              dma_addr_t dma_addr, size_t size,
>                              enum dma_data_direction dir, unsigned long a=
ttrs);
>
> -void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
> -                                 size_t size, dma_addr_t *dma_addr,
> -                                 gfp_t flag);
> +dma_addr_t vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
> +                                      size_t size, void *orig);
>
>  void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t=
 size,
>                                 dma_addr_t dma_addr, unsigned long attrs)=
;
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 0e3cf5128ad0..6dba1f3224d9 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -916,23 +916,27 @@ static void *vduse_dev_alloc_coherent(union virtio_=
map token, size_t size,
>  {
>         struct vduse_dev *vdev;
>         struct vduse_iova_domain *domain;
> -       unsigned long iova;
>         void *addr;
>
>         *dma_addr =3D DMA_MAPPING_ERROR;
>         if (!token.group)
>                 return NULL;
>
> -       vdev =3D token.group->dev;
> -       domain =3D vdev->domain;
> -       addr =3D vduse_domain_alloc_coherent(domain, size,
> -                                          (dma_addr_t *)&iova, flag);
> +       addr =3D alloc_pages_exact(size, flag);
>         if (!addr)
>                 return NULL;
>
> -       *dma_addr =3D (dma_addr_t)iova;
> +       vdev =3D token.group->dev;
> +       domain =3D vdev->domain;
> +       *dma_addr =3D vduse_domain_alloc_coherent(domain, size, addr);
> +       if (*dma_addr =3D=3D DMA_MAPPING_ERROR)
> +               goto err;
>
>         return addr;
> +
> +err:
> +       free_pages_exact(addr, size);
> +       return NULL;
>  }

I think the code tries to hide the iova domain specific things (e.g
mappings and DMA_MAPPING_ERROR) from vduse core. Could we find a way
to stick to that?

Thanks

>
>  static void vduse_dev_free_coherent(union virtio_map token, size_t size,
> @@ -949,6 +953,7 @@ static void vduse_dev_free_coherent(union virtio_map =
token, size_t size,
>         domain =3D vdev->domain;
>
>         vduse_domain_free_coherent(domain, size, dma_addr, attrs);
> +       free_pages_exact(vaddr, size);
>  }
>
>  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_a=
ddr)
> --
> 2.52.0
>

