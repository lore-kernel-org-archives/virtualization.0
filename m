Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C7C1B1403
	for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942303; cv=none; b=RUhZnsn6R7sRvEBbJQqzU0IGSBig7Z6TbZ0W+G8diPZHIJF17iVz52qtEVfrLy9jmbbW7Yz+RIgwW7FZ93YgYDUzCb04bJYK2jKrNBJuJ3XCl1PDm7+IOKGjtTgTYmvG3necXoup8oW18wBRYs6jOOqALNDXMVSQ96C2ZV8Jv8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942303; c=relaxed/simple;
	bh=dQT+LA/IzZSB8C3sdyssDAKv/Xg3VRBV4cRfN3pDZrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sz/rFiFeS/VK/jT52UBqoDhwwHuijF/f0Q18EZAZ81Sit/MqlxXSv/bpu6GpSWMlxpPKk8tCH+qyh4z+qPQPn1Oh0I8wbPWnpZr5ravhhDeHllzHBqULSAkG2p/uiB3OcLP1tQ8es7iFd5BYfxuD85KTaxwo1bqxtDV9kOsYhwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXRGNSUt; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXRGNSUt"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD9BC40B67
	for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 14:38:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mru17hjDhyIm for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Aug 2024 14:38:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A248B403EF
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A248B403EF
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bXRGNSUt
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A248B403EF
	for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 14:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724942299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5UccTC0S6V3eGjBBJPNDrYhEx7B8yw4mGjSWxQn/Mg=;
	b=bXRGNSUtZ5e2b3s2iPXoAijddUlZpV97xtIhS8O7s7emqa27CzI9yfoqzQhmkd8l/uVm/p
	OD0wuegZGiKPfrWeYNtMEbvmjbjkjt4K1drvb5kVgY+0JYUDofdwOeUGWZYdruMSEkTdNU
	Ypjy/83xQUj3zKj46w0flAJ4jsm5XW8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-AOsIk8UUP3SS1Wq2GDqMjg-1; Thu, 29 Aug 2024 10:38:16 -0400
X-MC-Unique: AOsIk8UUP3SS1Wq2GDqMjg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a868c4d16a6so62601066b.0
        for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 07:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942295; x=1725547095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5UccTC0S6V3eGjBBJPNDrYhEx7B8yw4mGjSWxQn/Mg=;
        b=FjkvDtiiuey1gMEh9NKXkdCVVH4HaOKfgTchb/8mQ8G7th+DtQNDLHnnSLlzsAm6o2
         PxW1ysJfCbqQRSSlOf3HDVSkj7YWCQ/EjmSVUGwoJZHKwIojwBVlooQJ7etN+wIFhCiv
         oHkACIuVcUIGn/rDa9y+Y5j0I5MYqrBjTneGpVbWnKHA27lgMJoaCiyoKidzu2OeFb2b
         fCrW1575/SubWra/99P6aizMyJMdItDlEBujM5JYK9SAMvLrFvXJrRpQRyI+tQ6ZHiSO
         gPqxnl0xzKCymhjPpP8JWv0hl0xXcz8QDnaBd89fzyXN7eYvQuPQYNEsxJBJm9EWm107
         SXFg==
X-Forwarded-Encrypted: i=1; AJvYcCWHETtKdiSqlDECbGMRFEL6Axw3tuMxYXfE3eDRJWcywg0fPupcboc/HBir+Z8khXbTYoptyMt/PN/MrGcQPQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yycjj30pRm13aCC8/uXejhyt21h4J6hhdLhh/1UeB8joiLlILm6
	NgYcbKwxBzZ3F1U/+AkhdILjEkFteC4xQ5M1mtvKalK6QYTCMc3sxYTjFjIY6NHA3iObCZhESDU
	sPJgrecIvAvmzp5s1jFrfCwBNHEAG6jVrpnyxsrymrjozizVeAu8zJMN3RDOkvLXxFXE+Bs2DYE
	46HTOeihaIJUalD4E/2A3i7+To9uDOSn7zy8Iix2n0/V3O9jx+hwxQdw==
X-Received: by 2002:a17:907:6d03:b0:a86:84b8:1797 with SMTP id a640c23a62f3a-a897fad6213mr257355866b.67.1724942295425;
        Thu, 29 Aug 2024 07:38:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsvC4E6UsmVy/Ze5IGvygaFHFdEutsQpGstF70/D4htNreS9do5qHupMeEjRpKTrCSdG9K4ofLbVE6EHTsEbU=
X-Received: by 2002:a17:907:6d03:b0:a86:84b8:1797 with SMTP id
 a640c23a62f3a-a897fad6213mr257349266b.67.1724942294844; Thu, 29 Aug 2024
 07:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240821114100.2261167-2-dtatulea@nvidia.com> <20240821114100.2261167-8-dtatulea@nvidia.com>
In-Reply-To: <20240821114100.2261167-8-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 29 Aug 2024 16:37:37 +0200
Message-ID: <CAJaqyWe29MmDZgUkrOKibWN4MGjt+sWvsNfk6SeRHhEHPJYC5g@mail.gmail.com>
Subject: Re: [PATCH vhost 6/7] vdpa/mlx5: Introduce init/destroy for MR resources
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, virtualization@lists.linux-foundation.org, 
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 1:42=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> There's currently not a lot of action happening during
> the init/destroy of MR resources. But more will be added
> in the upcoming patches.

If the series doesn't receive new patches, it is just the next patch :).

>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  2 ++
>  drivers/vdpa/mlx5/core/mr.c        | 17 +++++++++++++++++
>  drivers/vdpa/mlx5/core/resources.c |  3 ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 10 ++++++++--
>  4 files changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/=
mlx5_vdpa.h
> index 89b564cecddf..c3e17bc888e8 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -138,6 +138,8 @@ int mlx5_vdpa_create_mkey(struct mlx5_vdpa_dev *mvdev=
, u32 *mkey, u32 *in,
>  int mlx5_vdpa_destroy_mkey(struct mlx5_vdpa_dev *mvdev, u32 mkey);
>  struct mlx5_vdpa_mr *mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
>                                          struct vhost_iotlb *iotlb);
> +int mlx5_vdpa_init_mr_resources(struct mlx5_vdpa_dev *mvdev);
> +void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev);
>  void mlx5_vdpa_clean_mrs(struct mlx5_vdpa_dev *mvdev);
>  void mlx5_vdpa_get_mr(struct mlx5_vdpa_dev *mvdev,
>                       struct mlx5_vdpa_mr *mr);
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index f20f2a8a701d..ec75f165f832 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -843,3 +843,20 @@ int mlx5_vdpa_reset_mr(struct mlx5_vdpa_dev *mvdev, =
unsigned int asid)
>
>         return 0;
>  }
> +
> +int mlx5_vdpa_init_mr_resources(struct mlx5_vdpa_dev *mvdev)
> +{
> +       struct mlx5_vdpa_mr_resources *mres =3D &mvdev->mres;
> +
> +       INIT_LIST_HEAD(&mres->mr_list_head);
> +       mutex_init(&mres->lock);
> +
> +       return 0;

I'd leave this function return void here and remove the caller error
control path.

> +}
> +
> +void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
> +{
> +       struct mlx5_vdpa_mr_resources *mres =3D &mvdev->mres;
> +
> +       mutex_destroy(&mres->lock);
> +}
> diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/=
resources.c
> index fe2ca3458f6c..aeae31d0cefa 100644
> --- a/drivers/vdpa/mlx5/core/resources.c
> +++ b/drivers/vdpa/mlx5/core/resources.c
> @@ -256,7 +256,6 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *m=
vdev)
>                 mlx5_vdpa_warn(mvdev, "resources already allocated\n");
>                 return -EINVAL;
>         }
> -       mutex_init(&mvdev->mres.lock);
>         res->uar =3D mlx5_get_uars_page(mdev);
>         if (IS_ERR(res->uar)) {
>                 err =3D PTR_ERR(res->uar);
> @@ -301,7 +300,6 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *m=
vdev)
>  err_uctx:
>         mlx5_put_uars_page(mdev, res->uar);
>  err_uars:
> -       mutex_destroy(&mvdev->mres.lock);

Maybe it is just me, but this patch is also moving the lock lifetime
from mlx5_vdpa_alloc_resources / mlx5_vdpa_free_resources to
mlx5_vdpa_dev_add / mlx5_vdpa_free. I guess it has a justification we
can either clarify in the patch message or split in its own patch.

>         return err;
>  }
>
> @@ -318,7 +316,6 @@ void mlx5_vdpa_free_resources(struct mlx5_vdpa_dev *m=
vdev)
>         dealloc_pd(mvdev, res->pdn, res->uid);
>         destroy_uctx(mvdev, res->uid);
>         mlx5_put_uars_page(mvdev->mdev, res->uar);
> -       mutex_destroy(&mvdev->mres.lock);
>         res->valid =3D false;
>  }
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 8a51c492a62a..1cadcb05a5c7 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3434,6 +3434,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev=
)
>
>         free_fixed_resources(ndev);
>         mlx5_vdpa_clean_mrs(mvdev);
> +       mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
>         if (!is_zero_ether_addr(ndev->config.mac)) {
>                 pfmdev =3D pci_get_drvdata(pci_physfn(mvdev->mdev->pdev))=
;
>                 mlx5_mpfs_del_mac(pfmdev, ndev->config.mac);
> @@ -3962,12 +3963,15 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev=
 *v_mdev, const char *name,
>         if (err)
>                 goto err_mpfs;
>
> -       INIT_LIST_HEAD(&mvdev->mres.mr_list_head);
> +       err =3D mlx5_vdpa_init_mr_resources(mvdev);
> +       if (err)
> +               goto err_res;
> +

Extra newline here.

>
>         if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
>                 err =3D mlx5_vdpa_create_dma_mr(mvdev);
>                 if (err)
> -                       goto err_res;
> +                       goto err_mr_res;
>         }
>
>         err =3D alloc_fixed_resources(ndev);
> @@ -4009,6 +4013,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>         free_fixed_resources(ndev);
>  err_mr:
>         mlx5_vdpa_clean_mrs(mvdev);
> +err_mr_res:
> +       mlx5_vdpa_destroy_mr_resources(mvdev);
>  err_res:
>         mlx5_vdpa_free_resources(&ndev->mvdev);
>  err_mpfs:
> --
> 2.45.1
>

