Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400611E521D
	for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074765; cv=none; b=H8CZWc2emKDaS7JxlUqXkrffz7iqkLzaPAzqN2ifpj6ma4lodcEIqd5IA4nCo4YXMqIoxui7JoY5OkijYipBH97JX5J3hKwiQse//JVocyaCkTK87WSUavH3mmnJyFi9+HpRZ8U4I5XHyV99Ds2NxO8awe5MpaddDsiJndRrv0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074765; c=relaxed/simple;
	bh=LWhj/IaL5MQHp1B+6KkXJgwwAwzS0lWuLvW+1kHkl44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEAEJ/N6qE+XvkHPIEbyRTxeE0hMWCSVC2sMQSfB+1lAIpWwbzE0sdKczbA0Xlm10BH7ytbA4Y/jTYYnt/zmQ+YtaWW28K1bOZQK29tAnwhsinhOcPPtsGVDqvyRtwIW7uCzT2ECAWOAQd+S7vC0x0dZ+sYR5ogb4u2Bs+EVbMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z2hjfgiY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2hjfgiY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755074762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2GYH5EM4vma6GEKoWWfsxzkeakzkoLpuU9VkluJSPkA=;
	b=Z2hjfgiYjg1KsP8j5q8PlnGBBlVZYgretH6cFS7NbryZSNEg4QnlVp0h+TuezjGNDzSIpr
	O/NV1qvkhBKaW2Aur5M1zMrIjzqpCynRTEXnnvhtukAoV8WERPrgpg7tIzBry30q+iH8bV
	434YPV+SzB9pVWUz+Q1XNhVhG5NL/JM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-JA8kd25cNHqfFL7Dn_Ucww-1; Wed, 13 Aug 2025 04:46:00 -0400
X-MC-Unique: JA8kd25cNHqfFL7Dn_Ucww-1
X-Mimecast-MFC-AGG-ID: JA8kd25cNHqfFL7Dn_Ucww_1755074759
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76bf30ca667so11911000b3a.1
        for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 01:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755074759; x=1755679559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GYH5EM4vma6GEKoWWfsxzkeakzkoLpuU9VkluJSPkA=;
        b=ZhgI8WxB23Od/OuEmn/D2xqTd5+INUmj1VBAS9eCdybF0xVdIu9AFuvCowHfKx/ujz
         l76NTZTHZlnBYe4ow9auG37D2gCdyeiwVlgUiVBGb+yDzoWzKCLFS2uYtFoRYZkEYjPR
         QtjIZyDuPB06Hf85XNkYKbb60C8Ief1l68Nwrirj7soE++99VXzb/3zA4u8XVLPIKs/z
         H7qW3vNZGig5A8BWZbcamj33cYFVV46IOuGrgHseFCSqzgIxPGPp+ny+PESBHHRxow2Z
         jOzVdtWKouOMmpjum6SFJL1TBtknRy8X+f2fIH4HqW+EA9TfCpMc6s0OV6gizeH3DaYK
         KhMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpPcLYtKKQD1xwIBCmoP9gDsCHKhDsST/9N437D1W5Pt4XUfPwf1sHBMXEwnzZEe29F8XQUHYPN1I1oE6iTA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzi8uY44HUXkQlcNXfkmMBqiQHB4BL0GqMLLHsq6pdRQkmMh1RZ
	11yYmkuOsaMIh1j6q2kNPbbTVbyaC1P6q93yw0Yz7+8bsshIExojg2HupF1BqCgMiyZllMk4dHo
	oGwDbvM2f3/hEOzoVpeiFv9ougSX0KwMuphF2OGCUiyoFe/5fw7WljRFct2TWnmXngLkFteBaHE
	eWsVg0nls7DsmvDtqpeJOWccaiQUBHKtQBZfOcpeMLSTA=
X-Gm-Gg: ASbGncsWh6K7ZHvwVKaXJX8a4J/1pSU+05aaIbm1D3Ts5fEjv8o0hRTTn6wjX/hbEIC
	WEjW4SQyCirhr0tfsSOuuHviHlvDT5sSA8Baba0DgZVW1lDTS87ltfUtccW+hRJaxATbVTnjRPq
	xqUKmXuNU+qqkO0CTP4+aW7qn5B/77FtOBftE7EkHaY43zH8bWUdsZ9LY=
X-Received: by 2002:a05:6300:2109:b0:240:489:beab with SMTP id adf61e73a8af0-240a8b3e8b0mr4048231637.34.1755074759189;
        Wed, 13 Aug 2025 01:45:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWkhSYX6P32NzB3fPrSNoC5Cn3T/6HPBuBW9DgRHBLx7E4wtfw0v7kSPDcfE85zsk24xBo1UP+JIAajAuiI6E=
X-Received: by 2002:a05:6300:2109:b0:240:489:beab with SMTP id
 adf61e73a8af0-240a8b3e8b0mr4048194637.34.1755074758655; Wed, 13 Aug 2025
 01:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250813054831.25865-1-jasowang@redhat.com> <20250813054831.25865-8-jasowang@redhat.com>
In-Reply-To: <20250813054831.25865-8-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 13 Aug 2025 10:45:21 +0200
X-Gm-Features: Ac12FXw8DPTfdUKmlI3BPIQ6_7DcqNaScDEKdItBYkhRtcRSAAcid-qh7wEE0iY
Message-ID: <CAJaqyWdnhR7B+Nf3Cp=hFKG_8Gz7vh4rjXLFzCET5C9dJh+17A@mail.gmail.com>
Subject: Re: [PATCH V5 7/9] vdpa: support mapping token
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, hch@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FFNO_G4Rh2BK4_pYQ9TxpUhMg5QZoOyF4_YHIKWRUFk_1755074759
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 7:49=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Virtio core switches from DMA device to mapping token, let's do that
> as well for vDPA.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/alibaba/eni_vdpa.c          |  2 +-
>  drivers/vdpa/ifcvf/ifcvf_main.c          |  2 +-
>  drivers/vdpa/mlx5/core/mr.c              |  4 ++--
>  drivers/vdpa/mlx5/net/mlx5_vnet.c        | 13 ++++++++-----
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c |  2 +-
>  drivers/vdpa/pds/vdpa_dev.c              |  2 +-
>  drivers/vdpa/solidrun/snet_main.c        |  4 ++--
>  drivers/vdpa/vdpa.c                      |  2 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c         |  2 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c       |  2 +-
>  drivers/vdpa/virtio_pci/vp_vdpa.c        |  2 +-
>  drivers/vhost/vdpa.c                     |  8 ++++++--
>  drivers/virtio/virtio_vdpa.c             | 11 +++++------
>  include/linux/vdpa.h                     | 15 ++++++++-------
>  14 files changed, 39 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_v=
dpa.c
> index ad7f3447fe90..cbec3fcffaef 100644
> --- a/drivers/vdpa/alibaba/eni_vdpa.c
> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> @@ -496,7 +496,7 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const=
 struct pci_device_id *id)
>         pci_set_master(pdev);
>         pci_set_drvdata(pdev, eni_vdpa);
>
> -       eni_vdpa->vdpa.dma_dev =3D &pdev->dev;
> +       eni_vdpa->vdpa.mapping_token.dma_dev =3D &pdev->dev;
>         eni_vdpa->queues =3D eni_vdpa_get_num_queues(eni_vdpa);
>
>         eni_vdpa->vring =3D devm_kcalloc(&pdev->dev, eni_vdpa->queues,
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_m=
ain.c
> index ccf64d7bbfaa..520a7d4db435 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -713,7 +713,7 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *m=
dev, const char *name,
>
>         ifcvf_mgmt_dev->adapter =3D adapter;
>         adapter->pdev =3D pdev;
> -       adapter->vdpa.dma_dev =3D &pdev->dev;
> +       adapter->vdpa.mapping_token.dma_dev =3D &pdev->dev;
>         adapter->vdpa.mdev =3D mdev;
>         adapter->vf =3D vf;
>         vdpa_dev =3D &adapter->vdpa;
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index c7a20278bc3c..b4806324afa0 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -378,7 +378,7 @@ static int map_direct_mr(struct mlx5_vdpa_dev *mvdev,=
 struct mlx5_vdpa_direct_mr
>         u64 pa, offset;
>         u64 paend;
>         struct scatterlist *sg;
> -       struct device *dma =3D mvdev->vdev.dma_dev;
> +       struct device *dma =3D mvdev->vdev.mapping_token.dma_dev;
>
>         for (map =3D vhost_iotlb_itree_first(iotlb, mr->start, mr->end - =
1);
>              map; map =3D vhost_iotlb_itree_next(map, mr->start, mr->end =
- 1)) {
> @@ -432,7 +432,7 @@ static int map_direct_mr(struct mlx5_vdpa_dev *mvdev,=
 struct mlx5_vdpa_direct_mr
>
>  static void unmap_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdp=
a_direct_mr *mr)
>  {
> -       struct device *dma =3D mvdev->vdev.dma_dev;
> +       struct device *dma =3D mvdev->vdev.mapping_token.dma_dev;
>
>         destroy_direct_mr(mvdev, mr);
>         dma_unmap_sg_attrs(dma, mr->sg_head.sgl, mr->nsg, DMA_BIDIRECTION=
AL, 0);
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 0ed2fc28e1ce..4a1a8b0a0123 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3395,14 +3395,17 @@ static int mlx5_vdpa_reset_map(struct vdpa_device=
 *vdev, unsigned int asid)
>         return err;
>  }
>
> -static struct device *mlx5_get_vq_dma_dev(struct vdpa_device *vdev, u16 =
idx)
> +static union vring_mapping_token mlx5_get_vq_mapping_token(struct vdpa_d=
evice *vdev, u16 idx)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> +       union vring_mapping_token mapping_token;
>
>         if (is_ctrl_vq_idx(mvdev, idx))
> -               return &vdev->dev;
> +               mapping_token.dma_dev =3D &vdev->dev;
> +       else
> +               mapping_token.dma_dev =3D mvdev->vdev.mapping_token.dma_d=
ev;
>
> -       return mvdev->vdev.dma_dev;
> +       return mapping_token;
>  }
>
>  static void free_irqs(struct mlx5_vdpa_net *ndev)
> @@ -3686,7 +3689,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops =
=3D {
>         .set_map =3D mlx5_vdpa_set_map,
>         .reset_map =3D mlx5_vdpa_reset_map,
>         .set_group_asid =3D mlx5_set_group_asid,
> -       .get_vq_dma_dev =3D mlx5_get_vq_dma_dev,
> +       .get_vq_mapping_token =3D mlx5_get_vq_mapping_token,
>         .free =3D mlx5_vdpa_free,
>         .suspend =3D mlx5_vdpa_suspend,
>         .resume =3D mlx5_vdpa_resume, /* Op disabled if not supported. */
> @@ -3965,7 +3968,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>         }
>
>         ndev->mvdev.mlx_features =3D device_features;
> -       mvdev->vdev.dma_dev =3D &mdev->pdev->dev;
> +       mvdev->vdev.mapping_token.dma_dev =3D &mdev->pdev->dev;
>         err =3D mlx5_vdpa_alloc_resources(&ndev->mvdev);
>         if (err)
>                 goto err_alloc;
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octe=
on_ep/octep_vdpa_main.c
> index 9b49efd24391..e229b421d194 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> @@ -516,7 +516,7 @@ static int octep_vdpa_dev_add(struct vdpa_mgmt_dev *m=
dev, const char *name,
>         }
>
>         oct_vdpa->pdev =3D pdev;
> -       oct_vdpa->vdpa.dma_dev =3D &pdev->dev;
> +       oct_vdpa->vdpa.mapping_token.dma_dev =3D &pdev->dev;
>         oct_vdpa->vdpa.mdev =3D mdev;
>         oct_vdpa->oct_hw =3D oct_hw;
>         vdpa_dev =3D &oct_vdpa->vdpa;
> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
> index 301d95e08596..c9da0e519d5c 100644
> --- a/drivers/vdpa/pds/vdpa_dev.c
> +++ b/drivers/vdpa/pds/vdpa_dev.c
> @@ -643,7 +643,7 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
>
>         pdev =3D vdpa_aux->padev->vf_pdev;
>         dma_dev =3D &pdev->dev;
> -       pdsv->vdpa_dev.dma_dev =3D dma_dev;
> +       pdsv->vdpa_dev.mapping_token.dma_dev =3D dma_dev;
>
>         status =3D pds_vdpa_get_status(&pdsv->vdpa_dev);
>         if (status =3D=3D 0xff) {
> diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/sn=
et_main.c
> index 55ec51c17ab3..d7b4eff77c95 100644
> --- a/drivers/vdpa/solidrun/snet_main.c
> +++ b/drivers/vdpa/solidrun/snet_main.c
> @@ -1052,8 +1052,8 @@ static int snet_vdpa_probe_vf(struct pci_dev *pdev)
>          */
>         snet_reserve_irq_idx(pf_irqs ? pdev_pf : pdev, snet);
>
> -       /*set DMA device*/
> -       snet->vdpa.dma_dev =3D &pdev->dev;
> +       /* set map token */
> +       snet->vdpa.mapping_token.dma_dev =3D &pdev->dev;
>
>         /* Register VDPA device */
>         ret =3D vdpa_register_device(&snet->vdpa, snet->cfg->vq_num);
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 8a372b51c21a..0115ce04979c 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -151,7 +151,7 @@ static void vdpa_release_dev(struct device *d)
>   * Driver should use vdpa_alloc_device() wrapper macro instead of
>   * using this directly.
>   *
> - * Return: Returns an error when parent/config/dma_dev is not set or fai=
l to get
> + * Return: Returns an error when parent/config/mapping_token is not set =
or fail to get
>   *        ida.
>   */
>  struct vdpa_device *__vdpa_alloc_device(struct device *parent,
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index c204fc8e471a..9a07063aaff7 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -272,7 +272,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_att=
r *dev_attr,
>                 vringh_set_iotlb(&vdpasim->vqs[i].vring, &vdpasim->iommu[=
0],
>                                  &vdpasim->iommu_lock);
>
> -       vdpasim->vdpa.dma_dev =3D dev;
> +       vdpasim->vdpa.mapping_token.dma_dev =3D dev;
>
>         return vdpasim;
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 04620bb77203..8e32b3db8608 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -2022,7 +2022,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *de=
v, const char *name)
>                 return ret;
>         }
>         set_dma_ops(&vdev->vdpa.dev, &vduse_dev_dma_ops);
> -       vdev->vdpa.dma_dev =3D &vdev->vdpa.dev;
> +       vdev->vdpa.mapping_token.dma_dev =3D &vdev->vdpa.dev;
>         vdev->vdpa.mdev =3D &vduse_mgmt->mgmt_dev;
>
>         return 0;
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/=
vp_vdpa.c
> index 8787407f75b0..2cb0dbf1740e 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -520,7 +520,7 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_md=
ev, const char *name,
>
>         vp_vdpa_mgtdev->vp_vdpa =3D vp_vdpa;
>
> -       vp_vdpa->vdpa.dma_dev =3D &pdev->dev;
> +       vp_vdpa->vdpa.mapping_token.dma_dev =3D &pdev->dev;
>         vp_vdpa->queues =3D vp_modern_get_num_queues(mdev);
>         vp_vdpa->mdev =3D mdev;
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 5a49b5a6d496..3d4c44b3f2b7 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1320,7 +1320,9 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdp=
a *v)
>  {
>         struct vdpa_device *vdpa =3D v->vdpa;
>         const struct vdpa_config_ops *ops =3D vdpa->config;
> -       struct device *dma_dev =3D vdpa_get_dma_dev(vdpa);
> +       union vring_mapping_token *mapping_token =3D
> +             vdpa_get_mapping_token(vdpa);
> +       struct device *dma_dev =3D mapping_token->dma_dev;
>         int ret;
>
>         /* Device want to do DMA by itself */
> @@ -1355,7 +1357,9 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdp=
a *v)
>  static void vhost_vdpa_free_domain(struct vhost_vdpa *v)
>  {
>         struct vdpa_device *vdpa =3D v->vdpa;
> -       struct device *dma_dev =3D vdpa_get_dma_dev(vdpa);
> +       union vring_mapping_token *mapping_token =3D
> +             vdpa_get_mapping_token(vdpa);
> +       struct device *dma_dev =3D mapping_token->dma_dev;
>
>         if (v->domain) {
>                 iommu_detach_device(v->domain, dma_dev);
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index acea98ab08ee..1a10024a8e4f 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -133,7 +133,6 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsi=
gned int index,
>                      const char *name, bool ctx)
>  {
>         struct vdpa_device *vdpa =3D vd_get_vdpa(vdev);
> -       struct device *dma_dev;
>         const struct vdpa_config_ops *ops =3D vdpa->config;
>         bool (*notify)(struct virtqueue *vq) =3D virtio_vdpa_notify;
>         struct vdpa_callback cb;
> @@ -182,11 +181,11 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, un=
signed int index,
>         /* Create the vring */
>         align =3D ops->get_vq_align(vdpa);
>
> -       if (ops->get_vq_dma_dev)
> -               dma_dev =3D ops->get_vq_dma_dev(vdpa, index);
> +       if (ops->get_vq_mapping_token)
> +               mapping_token =3D ops->get_vq_mapping_token(vdpa, index);
>         else
> -               dma_dev =3D vdpa_get_dma_dev(vdpa);
> -       mapping_token.dma_dev =3D dma_dev;
> +               mapping_token =3D *vdpa_get_mapping_token(vdpa);
> +
>         vq =3D vring_create_virtqueue_map(index, max_num, align, vdev,
>                                         true, may_reduce_num, ctx,
>                                         notify, callback, name, &mapping_=
token);
> @@ -463,7 +462,7 @@ static int virtio_vdpa_probe(struct vdpa_device *vdpa=
)
>         if (!vd_dev)
>                 return -ENOMEM;
>
> -       vd_dev->vdev.dev.parent =3D vdpa_get_dma_dev(vdpa);
> +       vd_dev->vdev.dev.parent =3D vdpa_get_mapping_token(vdpa)->dma_dev=
;
>         vd_dev->vdev.dev.release =3D virtio_vdpa_release_dev;
>         vd_dev->vdev.config =3D &virtio_vdpa_config_ops;
>         vd_dev->vdpa =3D vdpa;
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 2e7a30fe6b92..f806f13ca260 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -5,6 +5,7 @@
>  #include <linux/kernel.h>
>  #include <linux/device.h>
>  #include <linux/interrupt.h>
> +#include <linux/virtio.h>
>  #include <linux/vhost_iotlb.h>
>  #include <linux/virtio_net.h>
>  #include <linux/virtio_blk.h>
> @@ -70,7 +71,7 @@ struct vdpa_mgmt_dev;
>  /**
>   * struct vdpa_device - representation of a vDPA device
>   * @dev: underlying device
> - * @dma_dev: the actual device that is performing DMA
> + * @mapping_token: the token passed to upper layer to be used for mappin=
g
>   * @driver_override: driver name to force a match; do not set directly,
>   *                   because core frees it; use driver_set_override() to
>   *                   set or clear it.
> @@ -87,7 +88,7 @@ struct vdpa_mgmt_dev;
>   */
>  struct vdpa_device {
>         struct device dev;
> -       struct device *dma_dev;
> +       union vring_mapping_token mapping_token;
>         const char *driver_override;
>         const struct vdpa_config_ops *config;
>         struct rw_semaphore cf_lock; /* Protects get/set config */
> @@ -352,11 +353,11 @@ struct vdpa_map_file {
>   *                             @vdev: vdpa device
>   *                             @asid: address space identifier
>   *                             Returns integer: success (0) or error (< =
0)
> - * @get_vq_dma_dev:            Get the dma device for a specific
> + * @get_vq_mapping_token:              Get the map token for a specific
>   *                             virtqueue (optional)
>   *                             @vdev: vdpa device
>   *                             @idx: virtqueue index
> - *                             Returns pointer to structure device or er=
ror (NULL)
> + *                             Returns map token union error (NULL)

Nit again, maybe we can define a macro for UNION_TOKEN_ERROR as we're
returning it by value. But I'm happy with dev / token =3D=3D NULL too.
Maybe to document it here?

>   * @bind_mm:                   Bind the device to a specific address spa=
ce
>   *                             so the vDPA framework can use VA when thi=
s
>   *                             callback is implemented. (optional)
> @@ -436,7 +437,7 @@ struct vdpa_config_ops {
>         int (*reset_map)(struct vdpa_device *vdev, unsigned int asid);
>         int (*set_group_asid)(struct vdpa_device *vdev, unsigned int grou=
p,
>                               unsigned int asid);
> -       struct device *(*get_vq_dma_dev)(struct vdpa_device *vdev, u16 id=
x);
> +       union vring_mapping_token (*get_vq_mapping_token)(struct vdpa_dev=
ice *vdev, u16 idx);
>         int (*bind_mm)(struct vdpa_device *vdev, struct mm_struct *mm);
>         void (*unbind_mm)(struct vdpa_device *vdev);
>
> @@ -520,9 +521,9 @@ static inline void vdpa_set_drvdata(struct vdpa_devic=
e *vdev, void *data)
>         dev_set_drvdata(&vdev->dev, data);
>  }
>
> -static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
> +static inline union vring_mapping_token *vdpa_get_mapping_token(struct v=
dpa_device *vdev)
>  {
> -       return vdev->dma_dev;
> +       return &vdev->mapping_token;
>  }
>
>  static inline int vdpa_reset(struct vdpa_device *vdev, u32 flags)
> --
> 2.31.1
>

