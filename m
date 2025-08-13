Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4812F0681
	for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755075803; cv=none; b=EH6Nk5v1IS3cSNswy1FKrES7XjHwRB8HTjRMyMQAVaEt/W8EjaGgc7WxMPo/UlB7cp0mjUNlIAiEtAMGrTC0UceCPnpu3Vv/EVH+PWsHFgzbvYrcYdyFWYKaiUVGPzoeE87QvRr8HDUzRkOFnyTO+i0s2AziJKEIt8mtkGsI2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755075803; c=relaxed/simple;
	bh=Aj52hjGpFwDKOEkg+yoVubJt3cZKtQEFLNv5e/Q++kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIw6KlGdHdcxcPZmksfKT07Rvi1/5cbCeIxbOPmMxHZtvtW3K8B64pEeo7iEESwd6XunkAEjEUUAoe5d8XTFr6qSQ4uUAkDBieHcjCplSXb47xmyNbDMqpIwJ3Wyuk02+J5XuZifwJ6cPgPwhJUkfHYBtqIa2NYbmmTOTAjj3bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GAZegAa6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAZegAa6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755075799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ced2zugqerKUWoRnDLqpVCEfNS36g0dc3X5IsE9iu9w=;
	b=GAZegAa6ygiINJcv56ltU1hj+dz8agDZ6cQoOhWtN2WB77McOL0l/isaDkIXZD4ghMV7qw
	hH9Kb9ggcItcDCQMPSSHjPS5S7W8YRjIXHUNrZyUoEBbWMP0wnh4QBTLbjMVPbEIb6DTXH
	TMzQdeRq0pxpPxsZl5qFEbiWYxassUo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-wzVchrJqMlusnShmxhmh9A-1; Wed, 13 Aug 2025 05:03:18 -0400
X-MC-Unique: wzVchrJqMlusnShmxhmh9A-1
X-Mimecast-MFC-AGG-ID: wzVchrJqMlusnShmxhmh9A_1755075797
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2425364e0b2so74111185ad.1
        for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 02:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755075797; x=1755680597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ced2zugqerKUWoRnDLqpVCEfNS36g0dc3X5IsE9iu9w=;
        b=HGR3ZkemMCw1NsdCIrtXCj+YUxOSwKmhj1EtjkDaAPWA1v7rujkNRq3ep/O5daRGNG
         i6H1uoZOQcSrEMnLXhjW2BClT6YciZQqMdLRxneHTIkbZDY4YTtl5k1VO5TffKvFMBwE
         3i8Hj+5fw3VwbkLtUYTzEC/zvPTSthHwf3DeGa6ufDd9z2VQ8zZ4xzhIrlTZCcQdrcpj
         kUhM2nON8HJJjgQ+8qwrkrbMIRAUz8zZuDFKEUQazKbTV8UoZOg0X8rUTiADO3Z487mw
         NhP5hil5TSGkFjE9bTu0HiUh/jft4ebLYK7nQ3PToK3r5aBu8jEunKcKC3rirPYWxznw
         zuuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdvWcVXrOMdsTKUR4zjDCHLQ7f3n0D7lfawGu4k5WpGyXOI6oHOABMLgct2kMAyiP8R+iizGERnoD2aIH+mQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YywxPG9CtY6SFp4DAnljaKCuzNOLI2anTeeNNemlTnLH1nfg8Vl
	Ye+lM5MhxDbA3Tv3vvBiNeI66JF60dQuXD+nNuasgcCYKRGxz3lWv3AKh36Yj39shYi/kta61xT
	+oR2mS26k8yn2aC4DmqSMYW4aTSBCnKR1kRdC5vtG6pr/JeIDIJ2/daaT74Xgnk0z61Wsm0XQ6K
	HExJ4hOYlg+dOa24NmJKWGLgVqC4MmyXiy8oPvasuQUb8=
X-Gm-Gg: ASbGncutrwaLHCokLn6QLV3fHmYgzbRjAITOCnOXlDCFsG0J/RB9yenNd0hhO2iKKVo
	GlOxzjwYVbb9NkuNwr04A1zwJD6iSAfdlk0QEvpBUN+KqzzaF80zd4cHaqsQ9LDJy4Br2dQwrj3
	G161ylwuq3cs8e3+77iOFDZVdf+UuXN0/ye3DG5DZbFHa1ozSH04zjhw8=
X-Received: by 2002:a17:902:e748:b0:242:3105:1788 with SMTP id d9443c01a7336-2430d26ec8amr37711725ad.45.1755075796763;
        Wed, 13 Aug 2025 02:03:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcIRJqmQuwKANiz/+p3nsKkxnTguY11utBfiv/zk5L3YGSk5MKsG5FVN18bi13oyLxTZNPbBQf74wdJECdvcw=
X-Received: by 2002:a17:902:e748:b0:242:3105:1788 with SMTP id
 d9443c01a7336-2430d26ec8amr37711305ad.45.1755075796292; Wed, 13 Aug 2025
 02:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250813054831.25865-1-jasowang@redhat.com> <20250813054831.25865-10-jasowang@redhat.com>
In-Reply-To: <20250813054831.25865-10-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 13 Aug 2025 11:02:40 +0200
X-Gm-Features: Ac12FXx21ljdLj-EkoI0xvLjH0x-RBhy426HTvbSRhe1Al8_JoP9Uoq32NRk8-4
Message-ID: <CAJaqyWdZv30TMedrdb-iF6qwwis7d_GJpVyk2dCur2J27+ywog@mail.gmail.com>
Subject: Re: [PATCH V5 9/9] vduse: switch to use virtio map API instead of DMA API
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, hch@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9CId13g_zkdia8K0p4y7RlgQayn61hoYDa_bZxGzlz0_1755075797
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 7:49=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Lacking the support of device specific mapping supported in virtio,
> VDUSE must trick the DMA API in order to make virtio-vdpa transport
> work. This is done by advertising vDPA device as dma device with a
> VDUSE specific dma_ops even if it doesn't do DMA at all.
>
> This will be fixed by this patch. Thanks to the new mapping operations
> support by virtio and vDPA. VDUSE can simply switch to advertise its
> specific mappings operations to virtio via virtio-vdpa then DMA API is
> not needed for VDUSE any more and iova domain could be used as the
> mapping token instead.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/Kconfig                 |  8 +--
>  drivers/vdpa/vdpa_user/iova_domain.c |  2 +-
>  drivers/vdpa/vdpa_user/iova_domain.h |  2 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c   | 75 ++++++++++++++--------------
>  4 files changed, 41 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 559fb9d3271f..857cf288c876 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -34,13 +34,7 @@ config VDPA_SIM_BLOCK
>
>  config VDPA_USER
>         tristate "VDUSE (vDPA Device in Userspace) support"
> -       depends on EVENTFD && MMU && HAS_DMA
> -       #
> -       # This driver incorrectly tries to override the dma_ops.  It shou=
ld
> -       # never have done that, but for now keep it working on architectu=
res
> -       # that use dma ops
> -       #
> -       depends on ARCH_HAS_DMA_OPS
> +       depends on EVENTFD && MMU
>         select VHOST_IOTLB
>         select IOMMU_IOVA
>         help
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_use=
r/iova_domain.c
> index 58116f89d8da..ccaed24b7ef8 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -447,7 +447,7 @@ void vduse_domain_unmap_page(struct vduse_iova_domain=
 *domain,
>
>  void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
>                                   size_t size, dma_addr_t *dma_addr,
> -                                 gfp_t flag, unsigned long attrs)
> +                                 gfp_t flag)
>  {
>         struct iova_domain *iovad =3D &domain->consistent_iovad;
>         unsigned long limit =3D domain->iova_limit;
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_use=
r/iova_domain.h
> index 7f3f0928ec78..1f3c30be272a 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.h
> +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> @@ -64,7 +64,7 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *=
domain,
>
>  void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
>                                   size_t size, dma_addr_t *dma_addr,
> -                                 gfp_t flag, unsigned long attrs);
> +                                 gfp_t flag);
>
>  void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t=
 size,
>                                 void *vaddr, dma_addr_t dma_addr,
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index f161059d543e..3260edefdf0d 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -88,6 +88,7 @@ struct vduse_dev {
>         struct device *dev;
>         struct vduse_virtqueue **vqs;
>         struct vduse_iova_domain *domain;
> +       struct vduse_iova_domain *dom;

*dom is not used

>         char *name;
>         struct mutex lock;
>         spinlock_t msg_lock;
> @@ -814,59 +815,53 @@ static const struct vdpa_config_ops vduse_vdpa_conf=
ig_ops =3D {
>         .free                   =3D vduse_vdpa_free,
>  };
>
> -static void vduse_dev_sync_single_for_device(struct device *dev,
> +static void vduse_dev_sync_single_for_device(void *token,
>                                              dma_addr_t dma_addr, size_t =
size,
>                                              enum dma_data_direction dir)
>  {
> -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain =3D token;

If I add ASID support to VDUSE I'll need to replace the token by a vq
group representor. Is that ok?

I think it is as I like how using *domain here makes this patch
clearer, and adding something else will make this patch harder to
review.

>
>         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
>  }
>
> -static void vduse_dev_sync_single_for_cpu(struct device *dev,
> +static void vduse_dev_sync_single_for_cpu(void *token,
>                                              dma_addr_t dma_addr, size_t =
size,
>                                              enum dma_data_direction dir)
>  {
> -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain =3D token;
>
>         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
>  }
>
> -static dma_addr_t vduse_dev_map_page(struct device *dev, struct page *pa=
ge,
> +static dma_addr_t vduse_dev_map_page(void *token, struct page *page,
>                                      unsigned long offset, size_t size,
>                                      enum dma_data_direction dir,
>                                      unsigned long attrs)
>  {
> -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain =3D token;
>
>         return vduse_domain_map_page(domain, page, offset, size, dir, att=
rs);
>  }
>
> -static void vduse_dev_unmap_page(struct device *dev, dma_addr_t dma_addr=
,
> +static void vduse_dev_unmap_page(void *token, dma_addr_t dma_addr,
>                                 size_t size, enum dma_data_direction dir,
>                                 unsigned long attrs)
>  {
> -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain =3D token;
>
>         return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs=
);
>  }
>
> -static void *vduse_dev_alloc_coherent(struct device *dev, size_t size,
> -                                       dma_addr_t *dma_addr, gfp_t flag,
> -                                       unsigned long attrs)
> +static void *vduse_dev_alloc_coherent(void *token, size_t size,
> +                                     dma_addr_t *dma_addr, gfp_t flag)
>  {
> -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain =3D token;
>         unsigned long iova;
>         void *addr;
>
>         *dma_addr =3D DMA_MAPPING_ERROR;
>         addr =3D vduse_domain_alloc_coherent(domain, size,
> -                               (dma_addr_t *)&iova, flag, attrs);
> +                                          (dma_addr_t *)&iova, flag);
>         if (!addr)
>                 return NULL;
>
> @@ -875,31 +870,45 @@ static void *vduse_dev_alloc_coherent(struct device=
 *dev, size_t size,
>         return addr;
>  }
>
> -static void vduse_dev_free_coherent(struct device *dev, size_t size,
> -                                       void *vaddr, dma_addr_t dma_addr,
> -                                       unsigned long attrs)
> +static void vduse_dev_free_coherent(void *token, size_t size,
> +                                   void *vaddr, dma_addr_t dma_addr,
> +                                   unsigned long attrs)
>  {
> -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain =3D token;
>
>         vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
>  }
>
> -static size_t vduse_dev_max_mapping_size(struct device *dev)
> +static bool vduse_dev_need_sync(void *token, dma_addr_t dma_addr)
>  {
> -       struct vduse_dev *vdev =3D dev_to_vduse(dev);
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain =3D token;
> +
> +       return dma_addr < domain->bounce_size;
> +}
> +
> +static int vduse_dev_mapping_error(void *token, dma_addr_t dma_addr)
> +{
> +       if (unlikely(dma_addr =3D=3D DMA_MAPPING_ERROR))
> +               return -ENOMEM;
> +       return 0;
> +}
> +
> +static size_t vduse_dev_max_mapping_size(void *token)
> +{
> +       struct vduse_iova_domain *domain =3D token;
>
>         return domain->bounce_size;
>  }
>
> -static const struct dma_map_ops vduse_dev_dma_ops =3D {
> +static const struct virtio_map_ops vduse_map_ops =3D {
>         .sync_single_for_device =3D vduse_dev_sync_single_for_device,
>         .sync_single_for_cpu =3D vduse_dev_sync_single_for_cpu,
>         .map_page =3D vduse_dev_map_page,
>         .unmap_page =3D vduse_dev_unmap_page,
>         .alloc =3D vduse_dev_alloc_coherent,
>         .free =3D vduse_dev_free_coherent,
> +       .need_sync =3D vduse_dev_need_sync,
> +       .mapping_error =3D vduse_dev_mapping_error,

I think that adding these functions here is problematic,

In the case of mapping error vring_mapping_error only checks for
vdev->map, not for vdev->map->mapping_error:

static int vring_mapping_error(const struct vring_virtqueue *vq,
                              dma_addr_t addr)
{
       struct virtio_device *vdev =3D vq->vq.vdev;

       if (!vq->use_map_api)
               return 0;

       if (vdev->map)
               return vdev->map->mapping_error(vring_mapping_token(vq), add=
r);
       else
               return dma_mapping_error(vring_dma_dev(vq), addr);
}

So we either add the check for the member or we define them from the beginn=
ing.

>         .max_mapping_size =3D vduse_dev_max_mapping_size,
>  };
>
> @@ -2003,27 +2012,18 @@ static struct vduse_mgmt_dev *vduse_mgmt;
>  static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
>  {
>         struct vduse_vdpa *vdev;
> -       int ret;
>
>         if (dev->vdev)
>                 return -EEXIST;
>
>         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> -                                &vduse_vdpa_config_ops, NULL,
> +                                &vduse_vdpa_config_ops, &vduse_map_ops,
>                                  1, 1, name, true);
>         if (IS_ERR(vdev))
>                 return PTR_ERR(vdev);
>
>         dev->vdev =3D vdev;
>         vdev->dev =3D dev;
> -       vdev->vdpa.dev.dma_mask =3D &vdev->vdpa.dev.coherent_dma_mask;
> -       ret =3D dma_set_mask_and_coherent(&vdev->vdpa.dev, DMA_BIT_MASK(6=
4));
> -       if (ret) {
> -               put_device(&vdev->vdpa.dev);
> -               return ret;
> -       }
> -       set_dma_ops(&vdev->vdpa.dev, &vduse_dev_dma_ops);
> -       vdev->vdpa.mapping_token.dma_dev =3D &vdev->vdpa.dev;
>         vdev->vdpa.mdev =3D &vduse_mgmt->mgmt_dev;
>
>         return 0;
> @@ -2056,6 +2056,7 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev,=
 const char *name,
>                 return -ENOMEM;
>         }
>
> +       dev->vdev->vdpa.mapping_token.token =3D dev->domain;
>         ret =3D _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
>         if (ret) {
>                 put_device(&dev->vdev->vdpa.dev);
> --
> 2.31.1
>

