Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A8812B93
	for <virtualization@lists.linux.dev>; Mon, 11 Aug 2025 03:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754882506; cv=none; b=dI0a4lFqfmKwDQwmUH+2jdyyRQDnca3x45cq2iBYj1rvEiROcAmdo6Kge0wmjWgQmMj9+F6ZtSOHvEBOy78+DxK2n2fgl49e9o/Jqsgn2riSTOzvONwDbQwl4n62MBitKwPWO53MXma2JB5g7irEmGQHXbWakTUIhyl8lPLcc/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754882506; c=relaxed/simple;
	bh=18C/63UZnDCEs16eM1O3JLqj+xTaZ9Cmm6mFfMh2Vb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihqdUCwNzMMNmoaEPaoW8XvHjOfIk9J2Aaqob/kbg58B3VsaAnkitYyA3J8nCCxIChH83GgtBDo9kO1Mzf6TZ4X8+DguyD4sHPwf6crHgFB7jk3jgyeb3c0CqIJqD8W3BjLBqDflZdU4B4MnZXptog3kpxNNbxV78H4hQgI/fSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hQzHoD+B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQzHoD+B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754882502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHUwFmq0mQy0zgiJHXSBHqXWC566aP9YBhBsduHyFQ4=;
	b=hQzHoD+Bt8MDGkK5Fj2oX2qs52ou/ysSLF/yWLWpP8i9pyRyYN6TO9Kv4YDJSiHmYCHfHg
	EsS03BaxoVlb9/nP4CSEyag7/39m0WMTf2S0s/PymgYRUFcaeQ1v6EbK0UEPe4o++E5sys
	zNIuk7I2U4L9aqABrYvknaXLfTF5/9k=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-waavcPZmOMe0R2fjzJEorA-1; Sun, 10 Aug 2025 23:21:41 -0400
X-MC-Unique: waavcPZmOMe0R2fjzJEorA-1
X-Mimecast-MFC-AGG-ID: waavcPZmOMe0R2fjzJEorA_1754882500
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76bf30ca667so7726878b3a.1
        for <virtualization@lists.linux.dev>; Sun, 10 Aug 2025 20:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754882500; x=1755487300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHUwFmq0mQy0zgiJHXSBHqXWC566aP9YBhBsduHyFQ4=;
        b=Zz+PcwhrxhLwjFZACPuydTzp/I34gom7d2i7E9YrLQK7cWlJgQmshO9l2D3P4YGAEr
         AqVtYUUQk5i/y2kq+gtLrHggcCeDSTMAVTgos3B3OwaHFrliahKqmhLuWT7IuaAjPMHu
         0MLy2ESZz/N1BwWkHWDvuxKcp7bMeicz8oyit1k7z8Ss/sYUTitBIprLMVDNQ6p4L3RT
         zDEZ7q51SiEqPvV4kFzDZTzppm/x3F0YD0IkdG/re50ADd6+PYLzE5hbn7UUnq+khMjE
         /9TOtM4514+q43bPeb4w3VhqhM8BeHrta2TA5WbzBzVzZa+0qUNTrvmhBDfEotScIxmh
         U5Hg==
X-Forwarded-Encrypted: i=1; AJvYcCX1sGbXpdwN16RHIjWDBVMWJdhESdgQ57IZsNWZeQOyC1ENtZF2iiTIB57jU8/3jgGIRRaAnVR/5UdOOuKGgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvCyyd+mK897PNjbvCbA7jo5a4bwAKSWCFa+yMW6eKAgliCBEM
	b7yCyoUA8MzydryPTlWPg+9BxjeqJNpojru9P+++OiPrzwE3/U8vlPa0rcIAbTWeJrjYQK3BtaM
	IVGdoMxMwDRagkqtCl901iLU56VeWV8j5S91PBOH3AfcVdN9pjs5TsXZEjIqtqG7DaUph7QM2NP
	YsZcHWVlkmvt7T7A5QOqFl6q/Vi5Ues1hYFHmNeg6ukWA=
X-Gm-Gg: ASbGncvGb94FqUQmukC/bAJQeW/EzoOSIIJno+l35Tx94/Llq7BrjTlJewZ2/LKQ4P2
	YNEnoYrmfxZYTBkiMS0J/Q8GJAue/BGom3pZRri4zmBYAEv6ySE1h1PPFMUXmdI3pkBgiJypN5h
	rfvZjW8VD122vGrF4Jm7g=
X-Received: by 2002:a05:6a20:5493:b0:240:1c56:6495 with SMTP id adf61e73a8af0-24055030297mr18452454637.14.1754882500023;
        Sun, 10 Aug 2025 20:21:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkSJxc9PhQl2g6/gqiU/MMH818/McADMtwPAglxRtAmcb5aGkbuZXE1+1GH8er3xL4dqbJ3y768tx5tWm31XE=
X-Received: by 2002:a05:6a20:5493:b0:240:1c56:6495 with SMTP id
 adf61e73a8af0-24055030297mr18452418637.14.1754882499329; Sun, 10 Aug 2025
 20:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250807115752.1663383-1-eperezma@redhat.com> <20250807115752.1663383-6-eperezma@redhat.com>
In-Reply-To: <20250807115752.1663383-6-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Aug 2025 11:21:28 +0800
X-Gm-Features: Ac12FXzsUHiLKHoQMr2QA6nbXA171PdtyWUti59JpctZ7nNz_gK-vgaLvGMbu6I
Message-ID: <CACGkMEu0vaWaMO7Mm0CC5R1KgNw9Y6jr156PwBD=e6-tGEUT3Q@mail.gmail.com>
Subject: Re: [RFC v2 5/7] vduse: add vq group asid support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VOf4u8xcQXmJt0ArygXAKIWmVUQw6WkiFS1jIKAh1xM_1754882500
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 7:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> group.  This enables mapping each group into a distinct memory space.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v2: Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
> part of the struct is the same.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 259 ++++++++++++++++++++++-------
>  include/uapi/linux/vduse.h         |  36 +++-
>  2 files changed, 230 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index a7a2749f5818..145147c49930 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -51,6 +51,12 @@
>   */
>  #define VDUSE_MAX_VQ_GROUPS 3
>
> +/*
> + * We can do ASID thanks to (ab)using the vduse device and the vdpa one.=
 So no
> + * more than 2.
> + */
> +#define VDUSE_MAX_ASID 2

Similar to group limitation, I'd like to either make it larger to 64
or make it changable via sysfs.

> +
>  #define IRQ_UNBOUND -1
>
>  struct vduse_virtqueue {
> @@ -91,6 +97,7 @@ struct vduse_umem {
>  };
>
>  struct vduse_vq_group_int {
> +       struct vduse_iova_domain *domain;
>         struct vduse_dev *dev;
>  };
>
> @@ -98,7 +105,7 @@ struct vduse_dev {
>         struct vduse_vdpa *vdev;
>         struct device *dev;
>         struct vduse_virtqueue **vqs;
> -       struct vduse_iova_domain *domain;
> +       struct vduse_iova_domain *domain[VDUSE_MAX_ASID];
>         char *name;
>         struct mutex lock;
>         spinlock_t msg_lock;
> @@ -126,7 +133,8 @@ struct vduse_dev {
>         u32 vq_num;
>         u32 vq_align;
>         u32 ngroups;
> -       struct vduse_umem *umem;
> +       u32 nas;
> +       struct vduse_umem *umem[VDUSE_MAX_ASID];
>         struct vduse_vq_group_int groups[VDUSE_MAX_VQ_GROUPS];
>         struct mutex mem_lock;
>         unsigned int bounce_size;
> @@ -440,14 +448,28 @@ static __poll_t vduse_dev_poll(struct file *file, p=
oll_table *wait)
>         return mask;
>  }
>
> +/* Force set the asid to a vq group without a message to the VDUSE devic=
e */
> +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> +                                      unsigned int group, unsigned int a=
sid)
> +{
> +       guard(mutex)(&dev->domain_lock);
> +       dev->groups[group].domain =3D dev->domain[asid];
> +}
> +
>  static void vduse_dev_reset(struct vduse_dev *dev)
>  {
>         int i;
> -       struct vduse_iova_domain *domain =3D dev->domain;
>
>         /* The coherent mappings are handled in vduse_dev_free_coherent()=
 */
> -       if (domain && domain->bounce_map)
> -               vduse_domain_reset_bounce_map(domain);
> +       for (i =3D 0; i < dev->nas; i++) {
> +               struct vduse_iova_domain *domain =3D dev->domain[i];
> +
> +               if (domain && domain->bounce_map)
> +                       vduse_domain_reset_bounce_map(domain);
> +       }
> +
> +       for (i =3D 0; i < dev->ngroups; i++)
> +               vduse_set_group_asid_nomsg(dev, i, 0);

I vaguely remember Siwei has invented a feature that forbids the reset
of the mapping during virtio reset. If it's true, let's check that
feature flag.

Btw even if we device to reset the mapping, should it be implied via
reset message itself instead of having more operations here?

>
>         down_write(&dev->rwsem);
>
> @@ -619,6 +641,29 @@ static u32 vduse_get_vq_desc_group(struct vdpa_devic=
e *vdpa, u16 idx)
>         return dev->vqs[idx]->vq_desc_group;
>  }
>
> +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned int g=
roup,
> +                               unsigned int asid)
> +{
> +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> +       struct vduse_dev_msg msg =3D { 0 };
> +       int r;
> +
> +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> +           group > dev->ngroups || asid > dev->nas)
> +               return -EINVAL;
> +
> +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> +       msg.req.vq_group_asid.group =3D group;
> +       msg.req.vq_group_asid.asid =3D asid;

I wonder if this could be part of the shared memory?

> +
> +       r =3D vduse_dev_msg_sync(dev, &msg);
> +       if (r < 0)
> +               return r;
> +
> +       vduse_set_group_asid_nomsg(dev, group, asid);
> +       return 0;
> +}
> +
>  static void *vduse_get_vq_map_token(struct vdpa_device *vdpa, u16 idx)
>  {
>         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> @@ -833,13 +878,13 @@ static int vduse_vdpa_set_map(struct vdpa_device *v=
dpa,
>         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
>         int ret;
>
> -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> +       ret =3D vduse_domain_set_map(dev->domain[asid], iotlb);
>         if (ret)
>                 return ret;
>
>         ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
>         if (ret) {
> -               vduse_domain_clear_map(dev->domain, iotlb);
> +               vduse_domain_clear_map(dev->domain[asid], iotlb);
>                 return ret;
>         }
>
> @@ -883,6 +928,7 @@ static const struct vdpa_config_ops vduse_vdpa_config=
_ops =3D {
>         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
>         .reset                  =3D vduse_vdpa_reset,
>         .set_map                =3D vduse_vdpa_set_map,
> +       .set_group_asid         =3D vduse_set_group_asid,
>         .get_vq_map_token       =3D vduse_get_vq_map_token,
>         .free                   =3D vduse_vdpa_free,
>  };
> @@ -893,8 +939,10 @@ static void vduse_dev_sync_single_for_device(void *t=
oken,
>  {
>         struct vduse_vq_group_int *group =3D token;
>         struct vduse_dev *vdev =3D group->dev;
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain;
>
> +       guard(mutex)(&vdev->domain_lock);
> +       domain =3D group->domain;
>         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
>  }
>
> @@ -904,8 +952,10 @@ static void vduse_dev_sync_single_for_cpu(void *toke=
n,
>  {
>         struct vduse_vq_group_int *group =3D token;
>         struct vduse_dev *vdev =3D group->dev;
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain;
>
> +       guard(mutex)(&vdev->domain_lock);
> +       domain =3D group->domain;
>         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
>  }
>
> @@ -916,8 +966,10 @@ static dma_addr_t vduse_dev_map_page(void *token, st=
ruct page *page,
>  {
>         struct vduse_vq_group_int *group =3D token;
>         struct vduse_dev *vdev =3D group->dev;
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain;
>
> +       guard(mutex)(&vdev->domain_lock);
> +       domain =3D group->domain;
>         return vduse_domain_map_page(domain, page, offset, size, dir, att=
rs);
>  }
>
> @@ -927,8 +979,10 @@ static void vduse_dev_unmap_page(void *token, dma_ad=
dr_t dma_addr,
>  {
>         struct vduse_vq_group_int *group =3D token;
>         struct vduse_dev *vdev =3D group->dev;
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain;
>
> +       guard(mutex)(&vdev->domain_lock);
> +       domain =3D group->domain;
>         return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs=
);
>  }
>
> @@ -937,11 +991,13 @@ static void *vduse_dev_alloc_coherent(void *token, =
size_t size,
>  {
>         struct vduse_vq_group_int *group =3D token;
>         struct vduse_dev *vdev =3D group->dev;
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain;
>         unsigned long iova;
>         void *addr;
>
>         *dma_addr =3D DMA_MAPPING_ERROR;
> +       guard(mutex)(&vdev->domain_lock);
> +       domain =3D group->domain;
>         addr =3D vduse_domain_alloc_coherent(domain, size,
>                                            (dma_addr_t *)&iova, flag);
>         if (!addr)
> @@ -958,8 +1014,10 @@ static void vduse_dev_free_coherent(void *token, si=
ze_t size,
>  {
>         struct vduse_vq_group_int *group =3D token;
>         struct vduse_dev *vdev =3D group->dev;
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain;
>
> +       guard(mutex)(&vdev->domain_lock);
> +       domain =3D group->domain;
>         vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
>  }
>
> @@ -967,8 +1025,10 @@ static size_t vduse_dev_max_mapping_size(void *toke=
n)
>  {
>         struct vduse_vq_group_int *group =3D token;
>         struct vduse_dev *vdev =3D group->dev;
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain;
>
> +       guard(mutex)(&vdev->domain_lock);
> +       domain =3D group->domain;
>         return domain->bounce_size;
>  }
>
> @@ -1107,31 +1167,32 @@ static int vduse_dev_queue_irq_work(struct vduse_=
dev *dev,
>         return ret;
>  }
>
> -static int vduse_dev_dereg_umem(struct vduse_dev *dev,
> +static int vduse_dev_dereg_umem(struct vduse_dev *dev, u32 asid,
>                                 u64 iova, u64 size)
>  {
>         int ret;
>
>         mutex_lock(&dev->mem_lock);
>         ret =3D -ENOENT;
> -       if (!dev->umem)
> +       if (!dev->umem[asid])
>                 goto unlock;
>
>         ret =3D -EINVAL;
> -       if (!dev->domain)
> +       if (!dev->domain[asid])
>                 goto unlock;
>
> -       if (dev->umem->iova !=3D iova || size !=3D dev->domain->bounce_si=
ze)
> +       if (dev->umem[asid]->iova !=3D iova ||
> +           size !=3D dev->domain[asid]->bounce_size)
>                 goto unlock;
>
> -       vduse_domain_remove_user_bounce_pages(dev->domain);
> -       unpin_user_pages_dirty_lock(dev->umem->pages,
> -                                   dev->umem->npages, true);
> -       atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
> -       mmdrop(dev->umem->mm);
> -       vfree(dev->umem->pages);
> -       kfree(dev->umem);
> -       dev->umem =3D NULL;
> +       vduse_domain_remove_user_bounce_pages(dev->domain[asid]);
> +       unpin_user_pages_dirty_lock(dev->umem[asid]->pages,
> +                                   dev->umem[asid]->npages, true);
> +       atomic64_sub(dev->umem[asid]->npages, &dev->umem[asid]->mm->pinne=
d_vm);
> +       mmdrop(dev->umem[asid]->mm);
> +       vfree(dev->umem[asid]->pages);
> +       kfree(dev->umem[asid]);
> +       dev->umem[asid] =3D NULL;
>         ret =3D 0;
>  unlock:
>         mutex_unlock(&dev->mem_lock);
> @@ -1139,7 +1200,7 @@ static int vduse_dev_dereg_umem(struct vduse_dev *d=
ev,
>  }
>
>  static int vduse_dev_reg_umem(struct vduse_dev *dev,
> -                             u64 iova, u64 uaddr, u64 size)
> +                             u32 asid, u64 iova, u64 uaddr, u64 size)
>  {
>         struct page **page_list =3D NULL;
>         struct vduse_umem *umem =3D NULL;
> @@ -1147,14 +1208,14 @@ static int vduse_dev_reg_umem(struct vduse_dev *d=
ev,
>         unsigned long npages, lock_limit;
>         int ret;
>
> -       if (!dev->domain || !dev->domain->bounce_map ||
> -           size !=3D dev->domain->bounce_size ||
> +       if (!dev->domain[asid] || !dev->domain[asid]->bounce_map ||
> +           size !=3D dev->domain[asid]->bounce_size ||
>             iova !=3D 0 || uaddr & ~PAGE_MASK)
>                 return -EINVAL;
>
>         mutex_lock(&dev->mem_lock);
>         ret =3D -EEXIST;
> -       if (dev->umem)
> +       if (dev->umem[asid])
>                 goto unlock;
>
>         ret =3D -ENOMEM;
> @@ -1178,7 +1239,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev=
,
>                 goto out;
>         }
>
> -       ret =3D vduse_domain_add_user_bounce_pages(dev->domain,
> +       ret =3D vduse_domain_add_user_bounce_pages(dev->domain[asid],
>                                                  page_list, pinned);
>         if (ret)
>                 goto out;
> @@ -1191,7 +1252,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev=
,
>         umem->mm =3D current->mm;
>         mmgrab(current->mm);
>
> -       dev->umem =3D umem;
> +       dev->umem[asid] =3D umem;
>  out:
>         if (ret && pinned > 0)
>                 unpin_user_pages(page_list, pinned);
> @@ -1234,26 +1295,43 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
>
>         switch (cmd) {
>         case VDUSE_IOTLB_GET_FD: {
> -               struct vduse_iotlb_entry entry;
> +               struct vduse_iotlb_entry_v2 entry;
> +               struct vduse_iotlb_entry entry_old;
>                 struct vhost_iotlb_map *map;
>                 struct vdpa_map_file *map_file;
>                 struct file *f =3D NULL;
>
>                 ret =3D -EFAULT;
> -               if (copy_from_user(&entry, argp, sizeof(entry)))
> -                       break;
> +               if (dev->api_version >=3D VDUSE_API_VERSION_1) {
> +                       if (copy_from_user(&entry, argp, sizeof(entry)))
> +                               break;
> +               } else {
> +                       if (copy_from_user(&entry_old, argp,
> +                                          sizeof(entry_old)))
> +                               break;
> +
> +                       entry.offset =3D entry_old.offset;
> +                       entry.start =3D entry_old.start;
> +                       entry.last =3D entry_old.last;
> +                       entry.asid =3D 0;
> +                       entry.perm =3D entry_old.perm;
> +               }
>
>                 ret =3D -EINVAL;
>                 if (entry.start > entry.last)
>                         break;
>
> +               if (entry.asid > dev->nas)
> +                       break;
> +
>                 mutex_lock(&dev->domain_lock);
> -               if (!dev->domain) {
> +               /* TODO accessing an array with idx from userspace, mitig=
ations? */
> +               if (!dev->domain[entry.asid]) {
>                         mutex_unlock(&dev->domain_lock);
>                         break;
>                 }
> -               spin_lock(&dev->domain->iotlb_lock);
> -               map =3D vhost_iotlb_itree_first(dev->domain->iotlb,
> +               spin_lock(&dev->domain[entry.asid]->iotlb_lock);
> +               map =3D vhost_iotlb_itree_first(dev->domain[entry.asid]->=
iotlb,
>                                               entry.start, entry.last);
>                 if (map) {
>                         map_file =3D (struct vdpa_map_file *)map->opaque;
> @@ -1263,7 +1341,7 @@ static long vduse_dev_ioctl(struct file *file, unsi=
gned int cmd,
>                         entry.last =3D map->last;
>                         entry.perm =3D map->perm;
>                 }
> -               spin_unlock(&dev->domain->iotlb_lock);
> +               spin_unlock(&dev->domain[entry.asid]->iotlb_lock);
>                 mutex_unlock(&dev->domain_lock);
>                 ret =3D -EINVAL;
>                 if (!f)
> @@ -1413,12 +1491,16 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
>                         break;
>
>                 ret =3D -EINVAL;
> +               /* TODO: Using asid from userspace, need to mitigate? */
>                 if (!is_mem_zero((const char *)umem.reserved,
> -                                sizeof(umem.reserved)))
> +                                sizeof(umem.reserved)) ||
> +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> +                    umem.asid !=3D 0) ||
> +                    umem.asid > dev->nas)
>                         break;
>
>                 mutex_lock(&dev->domain_lock);
> -               ret =3D vduse_dev_reg_umem(dev, umem.iova,
> +               ret =3D vduse_dev_reg_umem(dev, umem.asid, umem.iova,
>                                          umem.uaddr, umem.size);
>                 mutex_unlock(&dev->domain_lock);
>                 break;
> @@ -1431,15 +1513,24 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
>                         break;
>
>                 ret =3D -EINVAL;
> +               /* TODO: Using asid from userspace, need to mitigate? */
>                 if (!is_mem_zero((const char *)umem.reserved,
> -                                sizeof(umem.reserved)))
> +                                sizeof(umem.reserved)) ||
> +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> +                    umem.asid !=3D 0) ||
> +                    umem.asid > dev->nas)
> +                       break;
> +
> +
> +               if (umem.asid > dev->nas)
>                         break;
>                 mutex_lock(&dev->domain_lock);
> -               ret =3D vduse_dev_dereg_umem(dev, umem.iova,
> +               ret =3D vduse_dev_dereg_umem(dev, umem.asid, umem.iova,
>                                            umem.size);
>                 mutex_unlock(&dev->domain_lock);
>                 break;
>         }
> +       /* TODO can we merge this with GET_FD? */

Probably but might be too late.

>         case VDUSE_IOTLB_GET_INFO: {
>                 struct vduse_iova_info info;
>                 struct vhost_iotlb_map *map;
> @@ -1452,27 +1543,32 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
>                 if (info.start > info.last)
>                         break;
>
> +               if (info.asid > dev->nas)
> +                       break;
> +
>                 if (!is_mem_zero((const char *)info.reserved,
>                                  sizeof(info.reserved)))
>                         break;
>
>                 mutex_lock(&dev->domain_lock);
> -               if (!dev->domain) {
> +               /* TODO asid comes from userspace. mitigations? */

We should do sanity check to avoid OOB at least?

> +               if (!dev->domain[info.asid]) {
>                         mutex_unlock(&dev->domain_lock);
>                         break;
>                 }
> -               spin_lock(&dev->domain->iotlb_lock);
> -               map =3D vhost_iotlb_itree_first(dev->domain->iotlb,
> +               spin_lock(&dev->domain[info.asid]->iotlb_lock);
> +               map =3D vhost_iotlb_itree_first(dev->domain[info.asid]->i=
otlb,
>                                               info.start, info.last);
>                 if (map) {
>                         info.start =3D map->start;
>                         info.last =3D map->last;
>                         info.capability =3D 0;
> -                       if (dev->domain->bounce_map && map->start =3D=3D =
0 &&
> -                           map->last =3D=3D dev->domain->bounce_size - 1=
)
> +                       if (dev->domain[info.asid]->bounce_map &&
> +                           map->start =3D=3D 0 &&
> +                           map->last =3D=3D dev->domain[info.asid]->boun=
ce_size - 1)
>                                 info.capability |=3D VDUSE_IOVA_CAP_UMEM;
>                 }
> -               spin_unlock(&dev->domain->iotlb_lock);
> +               spin_unlock(&dev->domain[info.asid]->iotlb_lock);
>                 mutex_unlock(&dev->domain_lock);
>                 if (!map)
>                         break;
> @@ -1497,8 +1593,13 @@ static int vduse_dev_release(struct inode *inode, =
struct file *file)
>         struct vduse_dev *dev =3D file->private_data;
>
>         mutex_lock(&dev->domain_lock);
> -       if (dev->domain)
> -               vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
> +       for (int i =3D 0; i < dev->nas; i++) {
> +               if (dev->domain[i]) {
> +                       vduse_dev_dereg_umem(dev, i, 0,
> +                                            dev->domain[i]->bounce_size)=
;
> +                       dev->domain[i] =3D NULL;
> +               }
> +       }
>         mutex_unlock(&dev->domain_lock);
>         spin_lock(&dev->msg_lock);
>         /* Make sure the inflight messages can processed after reconncect=
ion */
> @@ -1768,9 +1869,12 @@ static int vduse_destroy_dev(char *name)
>         idr_remove(&vduse_idr, dev->minor);
>         kvfree(dev->config);
>         vduse_dev_deinit_vqs(dev);
> -       if (dev->domain)
> -               vduse_domain_destroy(dev->domain);
> +       for (int i =3D 0; i < dev->nas; i++) {
> +               if (dev->domain[i])
> +                       vduse_domain_destroy(dev->domain[i]);
> +       }
>         kfree(dev->name);
> +       kfree(dev->umem);
>         vduse_dev_destroy(dev);
>         module_put(THIS_MODULE);
>
> @@ -1877,7 +1981,8 @@ static ssize_t bounce_size_store(struct device *dev=
ice,
>
>         ret =3D -EPERM;
>         mutex_lock(&dev->domain_lock);
> -       if (dev->domain)
> +       /* Assuming that if the first domain is allocated, all are alloca=
ted */
> +       if (dev->domain[0])
>                 goto unlock;
>
>         ret =3D kstrtouint(buf, 10, &bounce_size);
> @@ -1933,11 +2038,20 @@ static int vduse_create_dev(struct vduse_dev_conf=
ig *config,
>                 if (config->ngroups > VDUSE_MAX_VQ_GROUPS) {
>                         pr_err("Not creating a VDUSE device with %u vq gr=
oups. Max: %u",
>                                 config->ngroups, VDUSE_MAX_VQ_GROUPS);
> +                       /* TODO: Need to destroy dev here too! */
>                         goto err;
>                 }
> +               if (config->nas > VDUSE_MAX_ASID) {
> +                       pr_err("Not creating a VDUSE device with %u asid.=
 Max: %u",
> +                               config->nas, VDUSE_MAX_ASID);
> +                       goto err_nas;
> +               }
> +
>                 dev->ngroups =3D config->ngroups ?: 1;
> +               dev->nas =3D config->nas ?: 1;
>         } else {
>                 dev->ngroups =3D 1;
> +               dev->nas =3D 1;
>         }
>         for (u32 i =3D 0; i < dev->ngroups; ++i)
>                 dev->groups[i].dev =3D dev;
> @@ -1977,6 +2091,7 @@ static int vduse_create_dev(struct vduse_dev_config=
 *config,
>  err_idr:
>         kfree(dev->name);
>  err_str:
> +err_nas:
>         vduse_dev_destroy(dev);
>  err:
>         return ret;
> @@ -2069,7 +2184,6 @@ static int vduse_open(struct inode *inode, struct f=
ile *file)
>         if (!control)
>                 return -ENOMEM;
>
> -       control->api_version =3D VDUSE_API_VERSION;
>         file->private_data =3D control;
>
>         return 0;
> @@ -2101,7 +2215,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *de=
v, const char *name)
>
>         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
>                                  &vduse_vdpa_config_ops, &vduse_map_ops,
> -                                dev->ngroups, 1, name, true);
> +                                dev->ngroups, dev->nas, name, true);
>         if (IS_ERR(vdev))
>                 return PTR_ERR(vdev);
>
> @@ -2137,11 +2251,23 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
>                 return ret;
>
>         mutex_lock(&dev->domain_lock);
> -       if (!dev->domain)
> -               dev->domain =3D vduse_domain_create(VDUSE_IOVA_SIZE - 1,
> -                                                 dev->bounce_size);
> +       ret =3D 0;
> +
> +       /* TODO we could delay the creation of the domain */

I don't get what this means?

> +       for (int i =3D 0; i < dev->nas; ++i) {
> +               if (!dev->domain[i])
> +                       dev->domain[i] =3D vduse_domain_create(VDUSE_IOVA=
_SIZE - 1,
> +                                                            dev->bounce_=
size);
> +               if (!dev->domain[i]) {
> +                       ret =3D -ENOMEM;
> +                       for (int j =3D 0; j < i; ++j)
> +                               vduse_domain_destroy(dev->domain[j]);

Why not move the above error handling to the err label?

> +                       goto err_domain;
> +               }
> +       }
> +
>         mutex_unlock(&dev->domain_lock);
> -       if (!dev->domain) {
> +       if (ret =3D=3D -ENOMEM) {
>                 put_device(&dev->vdev->vdpa.dev);
>                 return -ENOMEM;
>         }
> @@ -2150,13 +2276,22 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
>         if (ret) {
>                 put_device(&dev->vdev->vdpa.dev);
>                 mutex_lock(&dev->domain_lock);
> -               vduse_domain_destroy(dev->domain);
> -               dev->domain =3D NULL;
> +               for (int i =3D 0; i < dev->nas; i++) {
> +                       if (dev->domain[i]) {
> +                               vduse_domain_destroy(dev->domain[i]);
> +                               dev->domain[i] =3D NULL;
> +                       }
> +               }
>                 mutex_unlock(&dev->domain_lock);
>                 return ret;
>         }
>
>         return 0;
> +
> +err_domain:
> +       /* TODO do I need to call put_device? */

If it comes after the success of vduse_dev_init_vdpa().

> +       mutex_unlock(&dev->domain_lock);
> +       return ret;
>  }
>
>  static void vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_device =
*dev)
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index b4b139dc76bb..d300fd5f867f 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -47,7 +47,8 @@ struct vduse_dev_config {
>         __u32 vq_num;
>         __u32 vq_align;
>         __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> -       __u32 reserved[12];
> +       __u32 nas; /* if VDUSE_API_VERSION >=3D 1 */
> +       __u32 reserved[11];
>         __u32 config_size;
>         __u8 config[];
>  };
> @@ -82,6 +83,17 @@ struct vduse_iotlb_entry {
>         __u8 perm;
>  };
>
> +struct vduse_iotlb_entry_v2 {
> +       __u64 offset;
> +       __u64 start;
> +       __u64 last;
> +#define VDUSE_ACCESS_RO 0x1
> +#define VDUSE_ACCESS_WO 0x2
> +#define VDUSE_ACCESS_RW 0x3
> +       __u8 perm;

We can embed vduse_iotlb_entry here. This will ease the userspace developme=
nt.

> +       __u32 asid;
> +};
> +
>  /*
>   * Find the first IOVA region that overlaps with the range [start, last]
>   * and return the corresponding file descriptor. Return -EINVAL means th=
e
> @@ -172,6 +184,16 @@ struct vduse_vq_group {
>         __u32 num;
>  };
>
> +/**
> + * struct vduse_vq_group - virtqueue group
> + @ @group: Index of the virtqueue group
> + * @asid: Address space ID of the group
> + */
> +struct vduse_vq_group_asid {
> +       __u32 group;
> +       __u32 asid;
> +};
> +
>  /**
>   * struct vduse_vq_info - information of a virtqueue
>   * @index: virtqueue index
> @@ -232,6 +254,7 @@ struct vduse_vq_eventfd {
>   * @uaddr: start address of userspace memory, it must be aligned to page=
 size
>   * @iova: start of the IOVA region
>   * @size: size of the IOVA region
> + * @asid: Address space ID of the IOVA region
>   * @reserved: for future use, needs to be initialized to zero
>   *
>   * Structure used by VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM
> @@ -241,7 +264,8 @@ struct vduse_iova_umem {
>         __u64 uaddr;
>         __u64 iova;
>         __u64 size;
> -       __u64 reserved[3];
> +       __u32 asid;
> +       __u32 reserved[5];
>  };
>
>  /* Register userspace memory for IOVA regions */
> @@ -265,7 +289,8 @@ struct vduse_iova_info {
>         __u64 last;
>  #define VDUSE_IOVA_CAP_UMEM (1 << 0)
>         __u64 capability;
> -       __u64 reserved[3];
> +       __u32 asid; /* Only if device API version >=3D 1 */
> +       __u32 reserved[5];
>  };
>
>  /*
> @@ -289,6 +314,7 @@ enum vduse_req_type {
>         VDUSE_UPDATE_IOTLB,
>         VDUSE_GET_VQ_GROUP,
>         VDUSE_GET_VRING_DESC_GROUP,
> +       VDUSE_SET_VQ_GROUP_ASID,
>  };
>
>  /**
> @@ -344,6 +370,8 @@ struct vduse_dev_request {
>                 struct vduse_dev_status s;
>                 struct vduse_iova_range iova;
>                 struct vduse_vq_group vq_group; /* Only if vduse api vers=
ion >=3D 1 */
> +               /* Only if vduse api version >=3D 1 */

We can use:

/* Only if vduse api version >=3D 1 */
struct vduse_vq_group vq_group;
struct vduse_vq_group_asid vq_group_asid;

> +               struct vduse_vq_group_asid vq_group_asid;
>                 __u32 padding[32];
>         };
>  };
> @@ -367,6 +395,8 @@ struct vduse_dev_response {
>         union {
>                 struct vduse_vq_state vq_state;
>                 struct vduse_vq_group vq_group; /* Only if vduse api vers=
ion >=3D 1 */
> +               /* Only if vduse api version >=3D 1 */
> +               struct vduse_vq_group_asid vq_group_asid;
>                 __u32 padding[32];
>         };
>  };
> --
> 2.50.1
>

Thanks

