Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9276C30BF67
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098229; cv=none; b=uDth7NvbvQVrdbxTTcAMK4NUksITlcE+LAwbO2mvBduXpBw1aib2rNjtt/NXbA9GVdEvl427fOFsL+hhxfpP/tYGaXLIjU7/SI6x65qY8AZJtfdKtGE5EbA4Y4F50n4aW2aIUDtkM+Tlvrsel0I3XuZUiSS6XOr3Z8zAaGFqCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098229; c=relaxed/simple;
	bh=YaHX4Ilu0cFldnPCPxouqSxwI1R6hcaCuGiMkJiyMcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqYy5oHzZeOk1a93ba/rqKMTyeFU3M8MWy9IByyg3rYHM9dpZl8U2CSGq8luTmy9OD1XVN4bjZCGUSEa/yNvqfCZ9e2hP+eG94shOAtOVYtxE8dYY/7OKKtqf2/VJppFi6MpHURSY6IIP1SC3HHNY3SQM7chxTRIsj0LDFFuTM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PEapjxwF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEapjxwF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758098226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWM58CJx3/0eb+V8bSIks8emnTNkc+H6jzdmlyFOyzg=;
	b=PEapjxwFTqEyP7aAVNdpwuKtScq/9jtdGcMGYzzekBJNhDnmcE8adQjI0ZDfMGGXXs9xz7
	JjhCucQzgoxCoIN2QR3pn6YutRJLQlkyYOgPnl3KMv5/3gM9g2nV7yNJLcHBqS8uFAu6yw
	6DtDWLHpkNdbnHcvHHUtFsqzyDdFZkI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-fSOjl0tpMxKj45YwiZ0p6A-1; Wed, 17 Sep 2025 04:37:05 -0400
X-MC-Unique: fSOjl0tpMxKj45YwiZ0p6A-1
X-Mimecast-MFC-AGG-ID: fSOjl0tpMxKj45YwiZ0p6A_1758098224
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32df881dce2so5569211a91.2
        for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 01:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758098224; x=1758703024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWM58CJx3/0eb+V8bSIks8emnTNkc+H6jzdmlyFOyzg=;
        b=pniXFwAI46D3sj536xM/6FriaTEN4RY4y2Hwqg2P79Lq1nwhomMX2CjtdLVaUTcha6
         Lb4tFHDvt0o4sKjaoXQyezgUr0GtIY0r4xKzwfHVlI0NtIgUxNSzMXuEHtN+3wn0TqYh
         iQaCdCf2PMpCHVKZOEO9tHrSMS/ILBD5T8hyn32YYxwKIx+6y4M8LjL7k5XkJNJV5eSR
         LnCbdDtHHmG3rLDG1TDh1CUVeitslkssKVyiGxaszNJ02TlIUQjPuvBvD0AQFJ37Kcnv
         gaeVaI2t1BjqzrQ+gPVeIEwrHaqZUkLlAbbf2/meeW12zMQLuIzmXKV2Bp/Ded29TUo2
         INlA==
X-Forwarded-Encrypted: i=1; AJvYcCUx63d/RzXYNATviiYH5cdQsFprJDFf7HhOQJVJQYuQdCqEVSeyqow5QGKduT4UG2mIj7caEundsrHp/S46pw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyI+LlCxYePdD89sUB33y5M97BCu7k5bkZgOyMTAR/B4o+eZ/UK
	OwnMJT5SZCp1QloiyzgB7ECzs11ToOt10knbBRO2fObs6kR7HTjs+Mi71mLIKLWvwGDo3loNxHf
	BoJx+s6SIBTlcK6nQ79zZxxtCOgZXkDoFROABuciYj3yLcZymC04MuOmkpusCUwsJFveXAjzuwS
	pQrhhwBOTEQQAkauSGAz4TQiy58/sAYZu6KYcf7jQx+vs=
X-Gm-Gg: ASbGncsGjSnbRfi88TXPGAfCK+Mb0r552z5RW7ReQRi6flWW1180gVFhlKXt+oxehSg
	tWVygY3VSuqyLAk76IF5Uc/rUN2lwwYhMGz7RqV/TSXNZWQUxan+qs7xFr5CpbVYCrGt3Mr0SXz
	3mY3nZ1ZzHYvoPt4/SbQ==
X-Received: by 2002:a17:90b:268b:b0:32e:32e4:9775 with SMTP id 98e67ed59e1d1-32ee3ed1932mr1731328a91.12.1758098224057;
        Wed, 17 Sep 2025 01:37:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp0zl3DVOkb3ftYhJrSSSKvJR6WrzW8QKXstXw16gemESkiCdj5Sk6da0m0BEwwiAPW+6eMJkbU7HGa9cvdMs=
X-Received: by 2002:a17:90b:268b:b0:32e:32e4:9775 with SMTP id
 98e67ed59e1d1-32ee3ed1932mr1731304a91.12.1758098223538; Wed, 17 Sep 2025
 01:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250916130833.329087-1-eperezma@redhat.com> <20250916130833.329087-5-eperezma@redhat.com>
In-Reply-To: <20250916130833.329087-5-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Sep 2025 16:36:49 +0800
X-Gm-Features: AS18NWBT5D8UMwseyl5Fy26BYG7p1Lo4vSXkeIjcsSXHFz1mL42zdN8VJSHcWt4
Message-ID: <CACGkMEuY359QtVeTY40Z_L1zhG87rB2te=qc7YM6gZxcKM=m7w@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] vduse: return internal vq group struct as map token
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qSamh623JtGaEmsNJwkYrTXNAoodM28FzAOLgOPII2g_1758098224
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:09=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Return the internal struct that represents the vq group as virtqueue map
> token, instead of the device.  This allows the map functions to access
> the information per group.
>
> At this moment all the virtqueues share the same vq group, that only
> can point to ASID 0.  This change prepares the infrastructure for actual
> per-group address space handling
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> RFC v3:
> * Make the vq groups a dynamic array to support an arbitrary number of
>   them.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 52 ++++++++++++++++++++++++------
>  include/linux/virtio.h             |  6 ++--
>  2 files changed, 46 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 42f8807911d4..9c12ae72abc2 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -23,6 +23,7 @@
>  #include <linux/uio.h>
>  #include <linux/vdpa.h>
>  #include <linux/nospec.h>
> +#include <linux/virtio.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched/mm.h>
>  #include <uapi/linux/vduse.h>
> @@ -85,6 +86,10 @@ struct vduse_umem {
>         struct mm_struct *mm;
>  };
>
> +struct vduse_vq_group_int {
> +       struct vduse_dev *dev;
> +};

I remember we had some discussion over this, and the conclusion is to
have a better name.

Maybe just vduse_vq_group?

And to be conceptually correct, we need to use iova_domain here
instead of the vduse_dev. More below.

> +
>  struct vduse_dev {
>         struct vduse_vdpa *vdev;
>         struct device *dev;
> @@ -118,6 +123,7 @@ struct vduse_dev {
>         u32 vq_align;
>         u32 ngroups;
>         struct vduse_umem *umem;
> +       struct vduse_vq_group_int *groups;
>         struct mutex mem_lock;
>         unsigned int bounce_size;
>         rwlock_t domain_lock;
> @@ -602,6 +608,15 @@ static u32 vduse_get_vq_group(struct vdpa_device *vd=
pa, u16 idx)
>         return dev->vqs[idx]->vq_group;
>  }
>
> +static union virtio_map vduse_get_vq_map(struct vdpa_device *vdpa, u16 i=
dx)
> +{
> +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> +       u32 vq_group =3D dev->vqs[idx]->vq_group;
> +       union virtio_map ret =3D { .group =3D &dev->groups[vq_group] };
> +
> +       return ret;
> +}
> +
>  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
>                                 struct vdpa_vq_state *state)
>  {
> @@ -822,6 +837,7 @@ static const struct vdpa_config_ops vduse_vdpa_config=
_ops =3D {
>         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
>         .reset                  =3D vduse_vdpa_reset,
>         .set_map                =3D vduse_vdpa_set_map,
> +       .get_vq_map             =3D vduse_get_vq_map,
>         .free                   =3D vduse_vdpa_free,
>  };
>
> @@ -829,7 +845,8 @@ static void vduse_dev_sync_single_for_device(union vi=
rtio_map token,
>                                              dma_addr_t dma_addr, size_t =
size,
>                                              enum dma_data_direction dir)
>  {
> -       struct vduse_iova_domain *domain =3D token.iova_domain;
> +       struct vduse_dev *vdev =3D token.group->dev;
> +       struct vduse_iova_domain *domain =3D vdev->domain;

If we really want to do this, we need to move the iova_domian into the grou=
p.

>
>         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
>  }
> @@ -838,7 +855,8 @@ static void vduse_dev_sync_single_for_cpu(union virti=
o_map token,
>                                              dma_addr_t dma_addr, size_t =
size,
>                                              enum dma_data_direction dir)
>  {
> -       struct vduse_iova_domain *domain =3D token.iova_domain;
> +       struct vduse_dev *vdev =3D token.group->dev;
> +       struct vduse_iova_domain *domain =3D vdev->domain;
>
>         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
>  }
> @@ -848,7 +866,8 @@ static dma_addr_t vduse_dev_map_page(union virtio_map=
 token, struct page *page,
>                                      enum dma_data_direction dir,
>                                      unsigned long attrs)
>  {
> -       struct vduse_iova_domain *domain =3D token.iova_domain;
> +       struct vduse_dev *vdev =3D token.group->dev;
> +       struct vduse_iova_domain *domain =3D vdev->domain;
>
>         return vduse_domain_map_page(domain, page, offset, size, dir, att=
rs);
>  }
> @@ -857,7 +876,8 @@ static void vduse_dev_unmap_page(union virtio_map tok=
en, dma_addr_t dma_addr,
>                                  size_t size, enum dma_data_direction dir=
,
>                                  unsigned long attrs)
>  {
> -       struct vduse_iova_domain *domain =3D token.iova_domain;
> +       struct vduse_dev *vdev =3D token.group->dev;
> +       struct vduse_iova_domain *domain =3D vdev->domain;
>
>         return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs=
);
>  }
> @@ -865,7 +885,8 @@ static void vduse_dev_unmap_page(union virtio_map tok=
en, dma_addr_t dma_addr,
>  static void *vduse_dev_alloc_coherent(union virtio_map token, size_t siz=
e,
>                                       dma_addr_t *dma_addr, gfp_t flag)
>  {
> -       struct vduse_iova_domain *domain =3D token.iova_domain;
> +       struct vduse_dev *vdev =3D token.group->dev;
> +       struct vduse_iova_domain *domain =3D vdev->domain;
>         unsigned long iova;
>         void *addr;
>
> @@ -884,14 +905,16 @@ static void vduse_dev_free_coherent(union virtio_ma=
p token, size_t size,
>                                     void *vaddr, dma_addr_t dma_addr,
>                                     unsigned long attrs)
>  {
> -       struct vduse_iova_domain *domain =3D token.iova_domain;
> +       struct vduse_dev *vdev =3D token.group->dev;
> +       struct vduse_iova_domain *domain =3D vdev->domain;
>
>         vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
>  }
>
>  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_a=
ddr)
>  {
> -       struct vduse_iova_domain *domain =3D token.iova_domain;
> +       struct vduse_dev *vdev =3D token.group->dev;
> +       struct vduse_iova_domain *domain =3D vdev->domain;
>
>         return dma_addr < domain->bounce_size;
>  }
> @@ -905,7 +928,8 @@ static int vduse_dev_mapping_error(union virtio_map t=
oken, dma_addr_t dma_addr)
>
>  static size_t vduse_dev_max_mapping_size(union virtio_map token)
>  {
> -       struct vduse_iova_domain *domain =3D token.iova_domain;
> +       struct vduse_dev *vdev =3D token.group->dev;
> +       struct vduse_iova_domain *domain =3D vdev->domain;
>
>         return domain->bounce_size;
>  }
> @@ -1720,6 +1744,7 @@ static int vduse_destroy_dev(char *name)
>         if (dev->domain)
>                 vduse_domain_destroy(dev->domain);
>         kfree(dev->name);
> +       kfree(dev->groups);
>         vduse_dev_destroy(dev);
>         module_put(THIS_MODULE);
>
> @@ -1885,7 +1910,15 @@ static int vduse_create_dev(struct vduse_dev_confi=
g *config,
>         dev->device_features =3D config->features;
>         dev->device_id =3D config->device_id;
>         dev->vendor_id =3D config->vendor_id;
> +
>         dev->ngroups =3D (dev->api_version < 1) ? 1 : (config->ngroups ?:=
 1);
> +       dev->groups =3D kcalloc(dev->ngroups, sizeof(dev->groups[0]),
> +                             GFP_KERNEL);
> +       if (!dev->groups)
> +               goto err_vq_groups;
> +       for (u32 i =3D 0; i < dev->ngroups; ++i)
> +               dev->groups[i].dev =3D dev;
> +
>         dev->name =3D kstrdup(config->name, GFP_KERNEL);
>         if (!dev->name)
>                 goto err_str;
> @@ -1922,6 +1955,8 @@ static int vduse_create_dev(struct vduse_dev_config=
 *config,
>  err_idr:
>         kfree(dev->name);
>  err_str:
> +       kfree(dev->groups);
> +err_vq_groups:
>         vduse_dev_destroy(dev);
>  err:
>         return ret;
> @@ -2083,7 +2118,6 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev,=
 const char *name,
>                 return -ENOMEM;
>         }
>
> -       dev->vdev->vdpa.vmap.iova_domain =3D dev->domain;
>         ret =3D _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
>         if (ret) {
>                 put_device(&dev->vdev->vdpa.dev);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 96c66126c074..5f8db75f7833 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -41,13 +41,13 @@ struct virtqueue {
>         void *priv;
>  };
>
> -struct vduse_iova_domain;
> +struct vduse_vq_group_int;
>
>  union virtio_map {
>         /* Device that performs DMA */
>         struct device *dma_dev;
> -       /* VDUSE specific mapping data */
> -       struct vduse_iova_domain *iova_domain;
> +       /* VDUSE specific virtqueue group for doing map */
> +       struct vduse_vq_group_int *group;
>  };
>
>  int virtqueue_add_outbuf(struct virtqueue *vq,
> --
> 2.51.0
>

Thanks

