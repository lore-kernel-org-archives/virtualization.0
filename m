Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1526A291882
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830668; cv=none; b=HSJ0ItSy3eMOmNxp3IYOLdvvkqRJxTdi7GzmxfLIIuzHw6BEcLPGe30o9Vr7CW87xDtqCugRjolpV/Za+ME73AXocqhlx0JjwD8BgWhAq+lG5bpjH9/Wd7opK5oljddv1pBEegE1PfH4LY3YuaxtTgc7uqv7sH+n3AEtkmYwoiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830668; c=relaxed/simple;
	bh=zTRXW59GWUG6//PWOoBmocGYTzYAoUuOHfwjho2BEmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSZmQ4X0DWfso64c6/qLMJEUPTPzf1wyGN3rmy3cKY0G8UKrN8HDPbOydheAKDL/HFASWzVQGf3uW8Ssc5ATsi2rIwQkGamPZU/y2R+pcGWxTEKrsitjckEpjug05780GmFUdfPsuHpm7ef0NxVPKdBemBxfa0DA/VrDjk2p6sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOuN3gwR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOuN3gwR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73651C4CEF0
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 09:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752830667;
	bh=zTRXW59GWUG6//PWOoBmocGYTzYAoUuOHfwjho2BEmQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nOuN3gwRr4eAI/0vkxX5r4+S1aIfOdtAZBWiLNY0RF1GdCF4uTvvTk191zdG3W5VP
	 cpVa3MEa2PHpfUJGQp88sOw17rtz/FSgcPDfKS0un5RMgi9jCJeBFHeQlZpxlyqzw9
	 bG1Y6qhGX3usvKVDCVOFv+1EhuoWC28VzNfziPcXxqaSdLWkQaZO6Cq1f7bORnWMH2
	 IivS+0pZwFzLJhXuKdIp/nrulKUmKsHuuGgRQhcYZUmDNs/3dVwf0r5Cb2ZMm/lHO6
	 EDeXYFXTFqdFOYyJnWvmJyCY1vHwc4beltSpwBm564sRkfxRlhl1IOAkB4TS4BxDfE
	 r8HVQU2KtSypg==
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so1851394a91.1
        for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 02:24:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVznqDunsn4K6wjdfBG12jnMHWr7MDYh0JU9PBAjIA8GzKj8n5OxW4pTOIvd33YAdNvRoJjPcp8qs+AvH0eSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxog43ASPkiNzZSG6CmhQFHqPBaZ6cYrPghrWnRYya39ZcD0Jeg
	5DXoFvFVQ67akMeFctvqnWIfnUmTRAxEcoz+qEi56hHeg9+RVwCpdUjh3DBAj3LPeXMzl38gMve
	9GiUwDWAD0K/TdDqAv3AY0raG5eKz6P0=
X-Google-Smtp-Source: AGHT+IHL+l4POpCjtilr+TLy9upDChjxOgO99ow3lOWin1Age97II489mmRptmUUCGquoRkdmUzEbAFciKzZ57TWlrQ=
X-Received: by 2002:a17:90b:1643:b0:312:db8f:9a09 with SMTP id
 98e67ed59e1d1-31caf856c3emr9080601a91.14.1752830666870; Fri, 18 Jul 2025
 02:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250718091616.6140-1-jasowang@redhat.com> <20250718091616.6140-8-jasowang@redhat.com>
In-Reply-To: <20250718091616.6140-8-jasowang@redhat.com>
From: Zhu Lingshan <lingshan.zhu@kernel.org>
Date: Fri, 18 Jul 2025 17:24:15 +0800
X-Gmail-Original-Message-ID: <CAL=tH4anwHJEB09UGvUFLE4dedjRKdAkeLsQze7whXH1jq7y7Q@mail.gmail.com>
X-Gm-Features: Ac12FXz_VNmLBqlsZqHg9kpYm0ZAFpDTNW9UgebpPJpH4b4JMaBJW9ERnEU41zU
Message-ID: <CAL=tH4anwHJEB09UGvUFLE4dedjRKdAkeLsQze7whXH1jq7y7Q@mail.gmail.com>
Subject: Re: [PATCH V4 7/9] vdpa: rename dma_dev to map_token
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, hch@infradead.org, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by Zhu Lingshan <lingshan.zhu@kernel.org>

Jason Wang <jasowang@redhat.com> =E4=BA=8E2025=E5=B9=B47=E6=9C=8818=E6=97=
=A5=E5=91=A8=E4=BA=94 17:17=E5=86=99=E9=81=93=EF=BC=9A
>
> Virtio core switches from DMA device to mapping token, let's do that
> as well for vDPA.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/alibaba/eni_vdpa.c          |  2 +-
>  drivers/vdpa/ifcvf/ifcvf_main.c          |  2 +-
>  drivers/vdpa/mlx5/core/mr.c              |  4 ++--
>  drivers/vdpa/mlx5/net/mlx5_vnet.c        |  8 ++++----
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c |  2 +-
>  drivers/vdpa/pds/vdpa_dev.c              |  2 +-
>  drivers/vdpa/solidrun/snet_main.c        |  4 ++--
>  drivers/vdpa/vdpa.c                      |  2 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c         |  2 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c       |  2 +-
>  drivers/vdpa/virtio_pci/vp_vdpa.c        |  2 +-
>  drivers/vhost/vdpa.c                     |  4 ++--
>  drivers/virtio/virtio_vdpa.c             | 12 ++++++------
>  include/linux/vdpa.h                     | 12 ++++++------
>  14 files changed, 30 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_v=
dpa.c
> index ad7f3447fe90..34bf726dc660 100644
> --- a/drivers/vdpa/alibaba/eni_vdpa.c
> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> @@ -496,7 +496,7 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const=
 struct pci_device_id *id)
>         pci_set_master(pdev);
>         pci_set_drvdata(pdev, eni_vdpa);
>
> -       eni_vdpa->vdpa.dma_dev =3D &pdev->dev;
> +       eni_vdpa->vdpa.map_token =3D &pdev->dev;
>         eni_vdpa->queues =3D eni_vdpa_get_num_queues(eni_vdpa);
>
>         eni_vdpa->vring =3D devm_kcalloc(&pdev->dev, eni_vdpa->queues,
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_m=
ain.c
> index ccf64d7bbfaa..64d28ec97136 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -713,7 +713,7 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *m=
dev, const char *name,
>
>         ifcvf_mgmt_dev->adapter =3D adapter;
>         adapter->pdev =3D pdev;
> -       adapter->vdpa.dma_dev =3D &pdev->dev;
> +       adapter->vdpa.map_token =3D &pdev->dev;
>         adapter->vdpa.mdev =3D mdev;
>         adapter->vf =3D vf;
>         vdpa_dev =3D &adapter->vdpa;
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index c7a20278bc3c..9175d7441fec 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -378,7 +378,7 @@ static int map_direct_mr(struct mlx5_vdpa_dev *mvdev,=
 struct mlx5_vdpa_direct_mr
>         u64 pa, offset;
>         u64 paend;
>         struct scatterlist *sg;
> -       struct device *dma =3D mvdev->vdev.dma_dev;
> +       struct device *dma =3D mvdev->vdev.map_token;
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
> +       struct device *dma =3D mvdev->vdev.map_token;
>
>         destroy_direct_mr(mvdev, mr);
>         dma_unmap_sg_attrs(dma, mr->sg_head.sgl, mr->nsg, DMA_BIDIRECTION=
AL, 0);
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 0ed2fc28e1ce..1c2342942200 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3395,14 +3395,14 @@ static int mlx5_vdpa_reset_map(struct vdpa_device=
 *vdev, unsigned int asid)
>         return err;
>  }
>
> -static struct device *mlx5_get_vq_dma_dev(struct vdpa_device *vdev, u16 =
idx)
> +static struct device *mlx5_get_vq_map_token(struct vdpa_device *vdev, u1=
6 idx)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>
>         if (is_ctrl_vq_idx(mvdev, idx))
>                 return &vdev->dev;
>
> -       return mvdev->vdev.dma_dev;
> +       return mvdev->vdev.map_token;
>  }
>
>  static void free_irqs(struct mlx5_vdpa_net *ndev)
> @@ -3686,7 +3686,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops =
=3D {
>         .set_map =3D mlx5_vdpa_set_map,
>         .reset_map =3D mlx5_vdpa_reset_map,
>         .set_group_asid =3D mlx5_set_group_asid,
> -       .get_vq_dma_dev =3D mlx5_get_vq_dma_dev,
> +       .get_vq_map_token =3D mlx5_get_vq_map_token,
>         .free =3D mlx5_vdpa_free,
>         .suspend =3D mlx5_vdpa_suspend,
>         .resume =3D mlx5_vdpa_resume, /* Op disabled if not supported. */
> @@ -3965,7 +3965,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>         }
>
>         ndev->mvdev.mlx_features =3D device_features;
> -       mvdev->vdev.dma_dev =3D &mdev->pdev->dev;
> +       mvdev->vdev.map_token =3D &mdev->pdev->dev;
>         err =3D mlx5_vdpa_alloc_resources(&ndev->mvdev);
>         if (err)
>                 goto err_alloc;
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octe=
on_ep/octep_vdpa_main.c
> index 9b49efd24391..42a4df4613dd 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> @@ -516,7 +516,7 @@ static int octep_vdpa_dev_add(struct vdpa_mgmt_dev *m=
dev, const char *name,
>         }
>
>         oct_vdpa->pdev =3D pdev;
> -       oct_vdpa->vdpa.dma_dev =3D &pdev->dev;
> +       oct_vdpa->vdpa.map_token =3D &pdev->dev;
>         oct_vdpa->vdpa.mdev =3D mdev;
>         oct_vdpa->oct_hw =3D oct_hw;
>         vdpa_dev =3D &oct_vdpa->vdpa;
> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
> index 301d95e08596..cff9c9811d8e 100644
> --- a/drivers/vdpa/pds/vdpa_dev.c
> +++ b/drivers/vdpa/pds/vdpa_dev.c
> @@ -643,7 +643,7 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
>
>         pdev =3D vdpa_aux->padev->vf_pdev;
>         dma_dev =3D &pdev->dev;
> -       pdsv->vdpa_dev.dma_dev =3D dma_dev;
> +       pdsv->vdpa_dev.map_token =3D dma_dev;
>
>         status =3D pds_vdpa_get_status(&pdsv->vdpa_dev);
>         if (status =3D=3D 0xff) {
> diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/sn=
et_main.c
> index 55ec51c17ab3..1864fd1655ea 100644
> --- a/drivers/vdpa/solidrun/snet_main.c
> +++ b/drivers/vdpa/solidrun/snet_main.c
> @@ -1052,8 +1052,8 @@ static int snet_vdpa_probe_vf(struct pci_dev *pdev)
>          */
>         snet_reserve_irq_idx(pf_irqs ? pdev_pf : pdev, snet);
>
> -       /*set DMA device*/
> -       snet->vdpa.dma_dev =3D &pdev->dev;
> +       /* set map token */
> +       snet->vdpa.map_token =3D &pdev->dev;
>
>         /* Register VDPA device */
>         ret =3D vdpa_register_device(&snet->vdpa, snet->cfg->vq_num);
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 8a372b51c21a..1cc4285ebd67 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -151,7 +151,7 @@ static void vdpa_release_dev(struct device *d)
>   * Driver should use vdpa_alloc_device() wrapper macro instead of
>   * using this directly.
>   *
> - * Return: Returns an error when parent/config/dma_dev is not set or fai=
l to get
> + * Return: Returns an error when parent/config/map_token is not set or f=
ail to get
>   *        ida.
>   */
>  struct vdpa_device *__vdpa_alloc_device(struct device *parent,
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index c204fc8e471a..7c8e468f2f8c 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -272,7 +272,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_att=
r *dev_attr,
>                 vringh_set_iotlb(&vdpasim->vqs[i].vring, &vdpasim->iommu[=
0],
>                                  &vdpasim->iommu_lock);
>
> -       vdpasim->vdpa.dma_dev =3D dev;
> +       vdpasim->vdpa.map_token =3D dev;
>
>         return vdpasim;
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 04620bb77203..cf4e3525aac4 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -2022,7 +2022,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *de=
v, const char *name)
>                 return ret;
>         }
>         set_dma_ops(&vdev->vdpa.dev, &vduse_dev_dma_ops);
> -       vdev->vdpa.dma_dev =3D &vdev->vdpa.dev;
> +       vdev->vdpa.map_token =3D &vdev->vdpa.dev;
>         vdev->vdpa.mdev =3D &vduse_mgmt->mgmt_dev;
>
>         return 0;
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/=
vp_vdpa.c
> index 8787407f75b0..6e22e95245fa 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -520,7 +520,7 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_md=
ev, const char *name,
>
>         vp_vdpa_mgtdev->vp_vdpa =3D vp_vdpa;
>
> -       vp_vdpa->vdpa.dma_dev =3D &pdev->dev;
> +       vp_vdpa->vdpa.map_token =3D &pdev->dev;
>         vp_vdpa->queues =3D vp_modern_get_num_queues(mdev);
>         vp_vdpa->mdev =3D mdev;
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 5a49b5a6d496..732ed118c138 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1320,7 +1320,7 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdp=
a *v)
>  {
>         struct vdpa_device *vdpa =3D v->vdpa;
>         const struct vdpa_config_ops *ops =3D vdpa->config;
> -       struct device *dma_dev =3D vdpa_get_dma_dev(vdpa);
> +       struct device *dma_dev =3D vdpa_get_map_token(vdpa);
>         int ret;
>
>         /* Device want to do DMA by itself */
> @@ -1355,7 +1355,7 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdp=
a *v)
>  static void vhost_vdpa_free_domain(struct vhost_vdpa *v)
>  {
>         struct vdpa_device *vdpa =3D v->vdpa;
> -       struct device *dma_dev =3D vdpa_get_dma_dev(vdpa);
> +       struct device *dma_dev =3D vdpa_get_map_token(vdpa);
>
>         if (v->domain) {
>                 iommu_detach_device(v->domain, dma_dev);
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index dbf207cd3996..7b9bc123166d 100644
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
> @@ -143,6 +142,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsi=
gned int index,
>         struct vdpa_vq_state state =3D {0};
>         u32 align, max_num, min_num =3D 1;
>         bool may_reduce_num =3D true;
> +       void *map_token;
>         int err;
>
>         if (!name)
> @@ -181,13 +181,13 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, un=
signed int index,
>         /* Create the vring */
>         align =3D ops->get_vq_align(vdpa);
>
> -       if (ops->get_vq_dma_dev)
> -               dma_dev =3D ops->get_vq_dma_dev(vdpa, index);
> +       if (ops->get_vq_map_token)
> +               map_token =3D ops->get_vq_map_token(vdpa, index);
>         else
> -               dma_dev =3D vdpa_get_dma_dev(vdpa);
> +               map_token =3D vdpa_get_map_token(vdpa);
>         vq =3D vring_create_virtqueue_map(index, max_num, align, vdev,
>                                         true, may_reduce_num, ctx,
> -                                       notify, callback, name, dma_dev);
> +                                       notify, callback, name, map_token=
);
>         if (!vq) {
>                 err =3D -ENOMEM;
>                 goto error_new_virtqueue;
> @@ -461,7 +461,7 @@ static int virtio_vdpa_probe(struct vdpa_device *vdpa=
)
>         if (!vd_dev)
>                 return -ENOMEM;
>
> -       vd_dev->vdev.dev.parent =3D vdpa_get_dma_dev(vdpa);
> +       vd_dev->vdev.dev.parent =3D vdpa_get_map_token(vdpa);
>         vd_dev->vdev.dev.release =3D virtio_vdpa_release_dev;
>         vd_dev->vdev.config =3D &virtio_vdpa_config_ops;
>         vd_dev->vdpa =3D vdpa;
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 2e7a30fe6b92..352ca5609c9a 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -70,7 +70,7 @@ struct vdpa_mgmt_dev;
>  /**
>   * struct vdpa_device - representation of a vDPA device
>   * @dev: underlying device
> - * @dma_dev: the actual device that is performing DMA
> + * @map_token: the token passed to upper layer to be used for mappping
>   * @driver_override: driver name to force a match; do not set directly,
>   *                   because core frees it; use driver_set_override() to
>   *                   set or clear it.
> @@ -87,7 +87,7 @@ struct vdpa_mgmt_dev;
>   */
>  struct vdpa_device {
>         struct device dev;
> -       struct device *dma_dev;
> +       void *map_token;
>         const char *driver_override;
>         const struct vdpa_config_ops *config;
>         struct rw_semaphore cf_lock; /* Protects get/set config */
> @@ -352,7 +352,7 @@ struct vdpa_map_file {
>   *                             @vdev: vdpa device
>   *                             @asid: address space identifier
>   *                             Returns integer: success (0) or error (< =
0)
> - * @get_vq_dma_dev:            Get the dma device for a specific
> + * @get_vq_map_token:          Get the map token for a specific
>   *                             virtqueue (optional)
>   *                             @vdev: vdpa device
>   *                             @idx: virtqueue index
> @@ -436,7 +436,7 @@ struct vdpa_config_ops {
>         int (*reset_map)(struct vdpa_device *vdev, unsigned int asid);
>         int (*set_group_asid)(struct vdpa_device *vdev, unsigned int grou=
p,
>                               unsigned int asid);
> -       struct device *(*get_vq_dma_dev)(struct vdpa_device *vdev, u16 id=
x);
> +       struct device *(*get_vq_map_token)(struct vdpa_device *vdev, u16 =
idx);
>         int (*bind_mm)(struct vdpa_device *vdev, struct mm_struct *mm);
>         void (*unbind_mm)(struct vdpa_device *vdev);
>
> @@ -520,9 +520,9 @@ static inline void vdpa_set_drvdata(struct vdpa_devic=
e *vdev, void *data)
>         dev_set_drvdata(&vdev->dev, data);
>  }
>
> -static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
> +static inline void *vdpa_get_map_token(struct vdpa_device *vdev)
>  {
> -       return vdev->dma_dev;
> +       return vdev->map_token;
>  }
>
>  static inline int vdpa_reset(struct vdpa_device *vdev, u32 flags)
> --
> 2.47.3
>
>
