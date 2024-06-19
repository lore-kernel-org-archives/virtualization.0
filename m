Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E086012D1E7
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793516; cv=none; b=MFsaasbRkwXSV8dHj8i+GfVxqPhA6DOY2Qw5JAuBuyarXuuwMZnsi4P0KTksO62NDs0Zw8PlS1xCBE8i/KzkYINk85mdv+UrPkVI78fFyRDz2W66p9fZ2t6YsYvutNqitH75wkikDL0b+F6TIf0rMueHWy7Xw9XHri7X4KHWfRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793516; c=relaxed/simple;
	bh=PS7tU6jZVP4LbinvvKWXnk1S71spD9IDGMpNJb3ZvhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aylWYDYxsV5bjzA3sq8BAMM3fiPfoL2IbsEP3g/FGNZl3KRjhmaXk8B2FpVMwjSDrQ9hhcKNBPqPGs2DQGF46Y/Ddz+FwfXeH/xtQF7UF4Fu5j6pBvOWH1SI4Ua7akfA4hEAE0iHJDBbBq050ykqL4ecmkzDhUAsPj4Em47yY7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPGAHYke; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPGAHYke"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718793512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFr9xFq64BkKhpQnfsn6Q49bj2wjStk9VDMgy0oc5n0=;
	b=cPGAHYkefc2TL4gTt62oXqCAz9dbPVb1FdrbK3RswUe/uqHM2tsIL3ZTqdMhTiGOp6rrXr
	/5L2edERAFAjI2OerVoBc1XqPiQIwbet9L1lLv7Xxif+LnS3YMANsSJJU6w5JC+QGV5NVS
	Gdne8jA3tUJUXq5idI7DZl0Ps+6+Ops=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-Kbu59SbsOHODnwbTrgpJ5w-1; Wed, 19 Jun 2024 06:38:31 -0400
X-MC-Unique: Kbu59SbsOHODnwbTrgpJ5w-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-627f20cff42so127236097b3.0
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 03:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718793511; x=1719398311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFr9xFq64BkKhpQnfsn6Q49bj2wjStk9VDMgy0oc5n0=;
        b=lmIKL6hJVD53aSrhtFSjdAYj9DCXT5K8B7TQCDG+4cU35NiPgx9GmO15RVADkQkTIF
         +aPeCTUsJVSvWjVbz00X3BR2KeQ1z3lRqyB10FUQBv/cdXcCyzBgkp48w7ZUQUbYnVzG
         JbF2cnzkLMveG77m2I7pN6OSZKJiPiHONKQPdOX9n4kmBeGsqAPUKpZ5BzHE/0PGkMrl
         REY28vviycvE/UlSKn6Ps3q+GBuX0iU7YjPcXPIIlSdTWIxCGezaaXHjW23FoesdSc8R
         6qWGf0LsA+RFCBEW7d4PvKJo3HmFTILICmy/C9/paEhX8K4QrckFYLOdJ2FlQu8CnoK/
         SS/A==
X-Forwarded-Encrypted: i=1; AJvYcCWZscKixPkDdCJH01J2RpeDpfXevsRyWXh/JaZEx28NY6C6OkXQbUYFDfW34mzHjNaG6yQhqfOHaVbcbhv5182XVhu23pTi5EyJCjNIkLA=
X-Gm-Message-State: AOJu0Yy53Mth37OVx3CQLthAuFW/55E16Ufr+gDfTsDdV4DBE7e7rB2H
	NZqXx2lK0SruvQNUIu2GsPhBpcDpaosQ3vRrhv2/4AWcFVrqnKnP41tqjHMY++S0KiMIYLE88bo
	likymkPZntnQazbS9wWq5SUoYIfZG/xe6QqxQcLQ8C9FGN61gSr4+H+PMDFIEgGCIg11tfWdj24
	4/0NV0Fg+z5fbcYfP0m5vVtjMtqnXM4ZStODmMGT0=
X-Received: by 2002:a81:b048:0:b0:632:587b:c970 with SMTP id 00721157ae682-63a900bebd9mr21335247b3.51.1718793509660;
        Wed, 19 Jun 2024 03:38:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5B5Ize3zl4/hDjuYJ+SiolBj12vgsVgj6dxiSrIi4vKCGZjz+/HKOtCxYIMf2/iiZn2sv3msEdL+1a5UWubM=
X-Received: by 2002:a81:b048:0:b0:632:587b:c970 with SMTP id
 00721157ae682-63a900bebd9mr21335127b3.51.1718793509247; Wed, 19 Jun 2024
 03:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-1-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-1-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 12:37:53 +0200
Message-ID: <CAJaqyWfGTcrb63=mya5tvxcrQttHqVL6GBc3JqXSkLMXcH-L5g@mail.gmail.com>
Subject: Re: [PATCH vhost 01/23] vdpa/mlx5: Clarify meaning thorough function rename
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	Cosmin Ratiu <cratiu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 5:08=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> setup_driver()/teardown_driver() are a bit vague. These functions are
> used for virtqueue resources.
>
> Same for alloc_resources()/teardown_resources(): they represent fixed
> resources that are meant to exist during the device lifetime.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index ecfc16151d61..3422da0e344b 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -144,10 +144,10 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mv=
dev, u16 idx)
>         return idx <=3D mvdev->max_idx;
>  }
>
> -static void free_resources(struct mlx5_vdpa_net *ndev);
> +static void free_fixed_resources(struct mlx5_vdpa_net *ndev);
>  static void init_mvqs(struct mlx5_vdpa_net *ndev);
> -static int setup_driver(struct mlx5_vdpa_dev *mvdev);
> -static void teardown_driver(struct mlx5_vdpa_net *ndev);
> +static int setup_vq_resources(struct mlx5_vdpa_dev *mvdev);
> +static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
>
>  static bool mlx5_vdpa_debug;
>
> @@ -2848,7 +2848,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev,
>                 if (err)
>                         return err;
>
> -               teardown_driver(ndev);
> +               teardown_vq_resources(ndev);
>         }
>
>         mlx5_vdpa_update_mr(mvdev, new_mr, asid);
> @@ -2862,7 +2862,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev,
>
>         if (teardown) {
>                 restore_channels_info(ndev);
> -               err =3D setup_driver(mvdev);
> +               err =3D setup_vq_resources(mvdev);
>                 if (err)
>                         return err;
>         }
> @@ -2873,7 +2873,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev,
>  }
>
>  /* reslock must be held for this function */
> -static int setup_driver(struct mlx5_vdpa_dev *mvdev)
> +static int setup_vq_resources(struct mlx5_vdpa_dev *mvdev)
>  {
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
>         int err;
> @@ -2931,7 +2931,7 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev=
)
>  }
>
>  /* reslock must be held for this function */
> -static void teardown_driver(struct mlx5_vdpa_net *ndev)
> +static void teardown_vq_resources(struct mlx5_vdpa_net *ndev)
>  {
>
>         WARN_ON(!rwsem_is_locked(&ndev->reslock));
> @@ -2997,7 +2997,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device=
 *vdev, u8 status)
>                                 goto err_setup;
>                         }
>                         register_link_notifier(ndev);
> -                       err =3D setup_driver(mvdev);
> +                       err =3D setup_vq_resources(mvdev);
>                         if (err) {
>                                 mlx5_vdpa_warn(mvdev, "failed to setup dr=
iver\n");
>                                 goto err_driver;
> @@ -3040,7 +3040,7 @@ static int mlx5_vdpa_compat_reset(struct vdpa_devic=
e *vdev, u32 flags)
>
>         down_write(&ndev->reslock);
>         unregister_link_notifier(ndev);
> -       teardown_driver(ndev);
> +       teardown_vq_resources(ndev);
>         clear_vqs_ready(ndev);
>         if (flags & VDPA_RESET_F_CLEAN_MAP)
>                 mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
> @@ -3197,7 +3197,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev=
)
>
>         ndev =3D to_mlx5_vdpa_ndev(mvdev);
>
> -       free_resources(ndev);
> +       free_fixed_resources(ndev);
>         mlx5_vdpa_destroy_mr_resources(mvdev);
>         if (!is_zero_ether_addr(ndev->config.mac)) {
>                 pfmdev =3D pci_get_drvdata(pci_physfn(mvdev->mdev->pdev))=
;
> @@ -3467,7 +3467,7 @@ static int query_mtu(struct mlx5_core_dev *mdev, u1=
6 *mtu)
>         return 0;
>  }
>
> -static int alloc_resources(struct mlx5_vdpa_net *ndev)
> +static int alloc_fixed_resources(struct mlx5_vdpa_net *ndev)
>  {
>         struct mlx5_vdpa_net_resources *res =3D &ndev->res;
>         int err;
> @@ -3494,7 +3494,7 @@ static int alloc_resources(struct mlx5_vdpa_net *nd=
ev)
>         return err;
>  }
>
> -static void free_resources(struct mlx5_vdpa_net *ndev)
> +static void free_fixed_resources(struct mlx5_vdpa_net *ndev)
>  {
>         struct mlx5_vdpa_net_resources *res =3D &ndev->res;
>
> @@ -3735,7 +3735,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>                         goto err_res;
>         }
>
> -       err =3D alloc_resources(ndev);
> +       err =3D alloc_fixed_resources(ndev);
>         if (err)
>                 goto err_mr;
>
> @@ -3758,7 +3758,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>  err_reg:
>         destroy_workqueue(mvdev->wq);
>  err_res2:
> -       free_resources(ndev);
> +       free_fixed_resources(ndev);
>  err_mr:
>         mlx5_vdpa_destroy_mr_resources(mvdev);
>  err_res:
>
> --
> 2.45.1
>

