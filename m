Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C781B1404
	for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941032; cv=none; b=tKhXKnyWAivu719uE7vnavBoDOxs2nnniCJWAFfJWKXCmbyRspRTpVB/6ttXGK0qgLFHTilGuGxnXLfExVSd9ZA0PGzWj44cxFLb08PMAbl0Yrsqd02v3Xr0KKBsRe0PsaSeQJm8BufItVqks7BK6uyaxWuwhuh3YxrMfCJtePQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941032; c=relaxed/simple;
	bh=iNIpqfIrEDON6UXVcfcmHUxtEG7Hn7SMSjYyOW75rdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ife4+nK8pYg3bIhzTxGTyAWzJBIufxbpZwFpAeIEoyfe1iBKobBphtZA5VOemioecxl4OUKgA0R8DhodBEt+YPTT9GTy5yTSxaINEEyIZnNeJSqu3U5ctWtQNj6exzgTU+/chaNzKjdk5FBN7KUsxo5ibzIdeHr/yoyvTiiDv+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jVPGWPrV; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVPGWPrV"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A92C640B40
	for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 14:17:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sg-vo5pRkzMJ for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Aug 2024 14:17:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D97074058B
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D97074058B
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jVPGWPrV
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D97074058B
	for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 14:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724941025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+DKNkyMY4EZ5Xqh2peJOI4nIbaDQ7uX+nxKmlbKxUQ=;
	b=jVPGWPrVtkO6SPxlVDLQMD0V91m3cNCS4VU9y9dq9MLfQOoBpVJwMaTj+V1HKG/dUtkcEN
	+N10kQZWWIOWYgsJMlT4GGGEbKIn6n2qvHzIljv5AYkjaqQfXMEWQV6JFrrvRDD8Ok7jxU
	m+nYCX3WSbJuC3OgECPJQshcB3hX85U=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-stOewLUpMcaMmP2eA5nP_A-1; Thu, 29 Aug 2024 10:17:04 -0400
X-MC-Unique: stOewLUpMcaMmP2eA5nP_A-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e163641feb9so1567334276.0
        for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 07:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941024; x=1725545824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+DKNkyMY4EZ5Xqh2peJOI4nIbaDQ7uX+nxKmlbKxUQ=;
        b=PeEQfg8ixxJcY49o76+/K8zCdmMJalx6jl/ma8PI/FQBCZl8Ictl4sSvnKwqDXo6W1
         nXDRv2n1ZtZ5EiDo5eG8wtrXJm22puodmUhSRSgGBgNd2IivlyoBvbpV+uCRpu+3KhXU
         06vwM2ydC1dpDAP8sOcEd5F2KRNQuRtyI3MrMuGaYZ7xdjivWnf6k8zpHRm18ofScVDl
         owzjSlktBRWhCHBB6PiKqjo6UyHkp1ej98kuiLsmOz9Ex4R7LdN+EhzvZ7OFK5nlScR0
         ncbHPDM6VUlR7X/PXnleJZJm7Q98wa0M722afxtJ7fdZ3A8dRotnrTWad9y9dX27HYc6
         ONSg==
X-Forwarded-Encrypted: i=1; AJvYcCV7Bs/nawFuyLJ1GJ+WugNcd8UozQ2d3fLIb0lGINu5W1EFRj8CvFlUGi2/KRvWdCkRrC6/PI2qwkjQiRFipg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzcEqLOdeEZqPQm8Ua9qsucfshBZeiaJl6z6Sq74DTtND3eQ0Au
	pQC0nr3O/OlNuqHYucJo18Y8GFcNFFDIc62pfcgPkM5jNFDX8Ld06eDX8dexPX/V9Dl4K1AJaiC
	zV8z0GFd3bgkxXaIW1PRdl9IkYqee3tf9rtjNZVfJpBztnNwYj2Scw5LmKUYDodA1A59yBgR1OG
	EktpyyAIWeJGWVE3FAkLI74a9tKzp0IGZay+yGGlE/9E9hZXAaDaOrjQ==
X-Received: by 2002:a05:6902:b20:b0:e1a:2fe5:b1a0 with SMTP id 3f1490d57ef6-e1a5c613d19mr2541483276.5.1724941023862;
        Thu, 29 Aug 2024 07:17:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9DNxXRMVBKz5elcwfOm/jk4XcpPNT3kOaWAuKzTlcOoUFJuljG8imonkTisscr6DsUj+BvvElWn+QObox7WM=
X-Received: by 2002:a05:6902:b20:b0:e1a:2fe5:b1a0 with SMTP id
 3f1490d57ef6-e1a5c613d19mr2541367276.5.1724941023071; Thu, 29 Aug 2024
 07:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240821114100.2261167-2-dtatulea@nvidia.com> <20240821114100.2261167-6-dtatulea@nvidia.com>
In-Reply-To: <20240821114100.2261167-6-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 29 Aug 2024 16:16:26 +0200
Message-ID: <CAJaqyWfsOfkxcgh6Pdn7rb4qj4ZnpcXQ0ATUS+-8epybTbArew@mail.gmail.com>
Subject: Re: [PATCH vhost 4/7] vdpa/mlx5: Extract mr members in own resource struct
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
> Group all mapping related resources into their own structure.
>
> Upcoming patches will add more members in this new structure.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h | 13 ++++++-----
>  drivers/vdpa/mlx5/core/mr.c        | 30 ++++++++++++-------------
>  drivers/vdpa/mlx5/core/resources.c |  6 ++---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 36 +++++++++++++++---------------
>  4 files changed, 44 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/=
mlx5_vdpa.h
> index 4d217d18239c..5ae6deea2a8a 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -83,10 +83,18 @@ enum {
>         MLX5_VDPA_NUM_AS =3D 2
>  };
>
> +struct mlx5_vdpa_mr_resources {
> +       struct mlx5_vdpa_mr *mr[MLX5_VDPA_NUM_AS];
> +       unsigned int group2asid[MLX5_VDPA_NUMVQ_GROUPS];
> +       struct list_head mr_list_head;
> +       struct mutex mr_mtx;
> +};
> +
>  struct mlx5_vdpa_dev {
>         struct vdpa_device vdev;
>         struct mlx5_core_dev *mdev;
>         struct mlx5_vdpa_resources res;
> +       struct mlx5_vdpa_mr_resources mres;
>
>         u64 mlx_features;
>         u64 actual_features;
> @@ -95,13 +103,8 @@ struct mlx5_vdpa_dev {
>         u16 max_idx;
>         u32 generation;
>
> -       struct mlx5_vdpa_mr *mr[MLX5_VDPA_NUM_AS];
> -       struct list_head mr_list_head;
> -       /* serialize mr access */
> -       struct mutex mr_mtx;
>         struct mlx5_control_vq cvq;
>         struct workqueue_struct *wq;
> -       unsigned int group2asid[MLX5_VDPA_NUMVQ_GROUPS];
>         bool suspended;
>
>         struct mlx5_async_ctx async_ctx;
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 149edea09c8f..2c8660e5c0de 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -666,9 +666,9 @@ static void _mlx5_vdpa_put_mr(struct mlx5_vdpa_dev *m=
vdev,
>  void mlx5_vdpa_put_mr(struct mlx5_vdpa_dev *mvdev,
>                       struct mlx5_vdpa_mr *mr)
>  {
> -       mutex_lock(&mvdev->mr_mtx);
> +       mutex_lock(&mvdev->mres.mr_mtx);
>         _mlx5_vdpa_put_mr(mvdev, mr);
> -       mutex_unlock(&mvdev->mr_mtx);
> +       mutex_unlock(&mvdev->mres.mr_mtx);
>  }
>
>  static void _mlx5_vdpa_get_mr(struct mlx5_vdpa_dev *mvdev,
> @@ -683,39 +683,39 @@ static void _mlx5_vdpa_get_mr(struct mlx5_vdpa_dev =
*mvdev,
>  void mlx5_vdpa_get_mr(struct mlx5_vdpa_dev *mvdev,
>                       struct mlx5_vdpa_mr *mr)
>  {
> -       mutex_lock(&mvdev->mr_mtx);
> +       mutex_lock(&mvdev->mres.mr_mtx);
>         _mlx5_vdpa_get_mr(mvdev, mr);
> -       mutex_unlock(&mvdev->mr_mtx);
> +       mutex_unlock(&mvdev->mres.mr_mtx);
>  }
>
>  void mlx5_vdpa_update_mr(struct mlx5_vdpa_dev *mvdev,
>                          struct mlx5_vdpa_mr *new_mr,
>                          unsigned int asid)
>  {
> -       struct mlx5_vdpa_mr *old_mr =3D mvdev->mr[asid];
> +       struct mlx5_vdpa_mr *old_mr =3D mvdev->mres.mr[asid];
>
> -       mutex_lock(&mvdev->mr_mtx);
> +       mutex_lock(&mvdev->mres.mr_mtx);
>
>         _mlx5_vdpa_put_mr(mvdev, old_mr);
> -       mvdev->mr[asid] =3D new_mr;
> +       mvdev->mres.mr[asid] =3D new_mr;
>
> -       mutex_unlock(&mvdev->mr_mtx);
> +       mutex_unlock(&mvdev->mres.mr_mtx);
>  }
>
>  static void mlx5_vdpa_show_mr_leaks(struct mlx5_vdpa_dev *mvdev)
>  {
>         struct mlx5_vdpa_mr *mr;
>
> -       mutex_lock(&mvdev->mr_mtx);
> +       mutex_lock(&mvdev->mres.mr_mtx);
>
> -       list_for_each_entry(mr, &mvdev->mr_list_head, mr_list) {
> +       list_for_each_entry(mr, &mvdev->mres.mr_list_head, mr_list) {
>
>                 mlx5_vdpa_warn(mvdev, "mkey still alive after resource de=
lete: "
>                                       "mr: %p, mkey: 0x%x, refcount: %u\n=
",
>                                        mr, mr->mkey, refcount_read(&mr->r=
efcount));
>         }
>
> -       mutex_unlock(&mvdev->mr_mtx);
> +       mutex_unlock(&mvdev->mres.mr_mtx);
>
>  }
>
> @@ -753,7 +753,7 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev =
*mvdev,
>         if (err)
>                 goto err_iotlb;
>
> -       list_add_tail(&mr->mr_list, &mvdev->mr_list_head);
> +       list_add_tail(&mr->mr_list, &mvdev->mres.mr_list_head);
>
>         return 0;
>
> @@ -779,9 +779,9 @@ struct mlx5_vdpa_mr *mlx5_vdpa_create_mr(struct mlx5_=
vdpa_dev *mvdev,
>         if (!mr)
>                 return ERR_PTR(-ENOMEM);
>
> -       mutex_lock(&mvdev->mr_mtx);
> +       mutex_lock(&mvdev->mres.mr_mtx);
>         err =3D _mlx5_vdpa_create_mr(mvdev, mr, iotlb);
> -       mutex_unlock(&mvdev->mr_mtx);
> +       mutex_unlock(&mvdev->mres.mr_mtx);
>
>         if (err)
>                 goto out_err;
> @@ -801,7 +801,7 @@ int mlx5_vdpa_update_cvq_iotlb(struct mlx5_vdpa_dev *=
mvdev,
>  {
>         int err;
>
> -       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] !=3D asid)
> +       if (mvdev->mres.group2asid[MLX5_VDPA_CVQ_GROUP] !=3D asid)
>                 return 0;
>
>         spin_lock(&mvdev->cvq.iommu_lock);
> diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/=
resources.c
> index 22ea32fe007b..3e3b3049cb08 100644
> --- a/drivers/vdpa/mlx5/core/resources.c
> +++ b/drivers/vdpa/mlx5/core/resources.c
> @@ -256,7 +256,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *m=
vdev)
>                 mlx5_vdpa_warn(mvdev, "resources already allocated\n");
>                 return -EINVAL;
>         }
> -       mutex_init(&mvdev->mr_mtx);
> +       mutex_init(&mvdev->mres.mr_mtx);
>         res->uar =3D mlx5_get_uars_page(mdev);
>         if (IS_ERR(res->uar)) {
>                 err =3D PTR_ERR(res->uar);
> @@ -301,7 +301,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *m=
vdev)
>  err_uctx:
>         mlx5_put_uars_page(mdev, res->uar);
>  err_uars:
> -       mutex_destroy(&mvdev->mr_mtx);
> +       mutex_destroy(&mvdev->mres.mr_mtx);
>         return err;
>  }
>
> @@ -318,7 +318,7 @@ void mlx5_vdpa_free_resources(struct mlx5_vdpa_dev *m=
vdev)
>         dealloc_pd(mvdev, res->pdn, res->uid);
>         destroy_uctx(mvdev, res->uid);
>         mlx5_put_uars_page(mvdev->mdev, res->uar);
> -       mutex_destroy(&mvdev->mr_mtx);
> +       mutex_destroy(&mvdev->mres.mr_mtx);
>         res->valid =3D false;
>  }
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index cf2b77ebc72b..3e55a7f1afcd 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -941,11 +941,11 @@ static int create_virtqueue(struct mlx5_vdpa_net *n=
dev,
>                 MLX5_SET64(virtio_q, vq_ctx, used_addr, mvq->device_addr)=
;
>                 MLX5_SET64(virtio_q, vq_ctx, available_addr, mvq->driver_=
addr);
>
> -               vq_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GR=
OUP]];
> +               vq_mr =3D mvdev->mres.mr[mvdev->mres.group2asid[MLX5_VDPA=
_DATAVQ_GROUP]];
>                 if (vq_mr)
>                         MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, vq_mr->=
mkey);
>
> -               vq_desc_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATA=
VQ_DESC_GROUP]];
> +               vq_desc_mr =3D mvdev->mres.mr[mvdev->mres.group2asid[MLX5=
_VDPA_DATAVQ_DESC_GROUP]];
>                 if (vq_desc_mr &&
>                     MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, desc_group_m=
key_supported))
>                         MLX5_SET(virtio_q, vq_ctx, desc_group_mkey, vq_de=
sc_mr->mkey);
> @@ -953,11 +953,11 @@ static int create_virtqueue(struct mlx5_vdpa_net *n=
dev,
>                 /* If there is no mr update, make sure that the existing =
ones are set
>                  * modify to ready.
>                  */
> -               vq_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GR=
OUP]];
> +               vq_mr =3D mvdev->mres.mr[mvdev->mres.group2asid[MLX5_VDPA=
_DATAVQ_GROUP]];
>                 if (vq_mr)
>                         mvq->modified_fields |=3D MLX5_VIRTQ_MODIFY_MASK_=
VIRTIO_Q_MKEY;
>
> -               vq_desc_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATA=
VQ_DESC_GROUP]];
> +               vq_desc_mr =3D mvdev->mres.mr[mvdev->mres.group2asid[MLX5=
_VDPA_DATAVQ_DESC_GROUP]];
>                 if (vq_desc_mr)
>                         mvq->modified_fields |=3D MLX5_VIRTQ_MODIFY_MASK_=
DESC_GROUP_MKEY;
>         }
> @@ -1354,7 +1354,7 @@ static void fill_modify_virtqueue_cmd(struct mlx5_v=
dpa_net *ndev,
>         }
>
>         if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_MKEY) =
{
> -               vq_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GR=
OUP]];
> +               vq_mr =3D mvdev->mres.mr[mvdev->mres.group2asid[MLX5_VDPA=
_DATAVQ_GROUP]];
>
>                 if (vq_mr)
>                         MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, vq_mr->=
mkey);
> @@ -1363,7 +1363,7 @@ static void fill_modify_virtqueue_cmd(struct mlx5_v=
dpa_net *ndev,
>         }
>
>         if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY=
) {
> -               desc_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_=
DESC_GROUP]];
> +               desc_mr =3D mvdev->mres.mr[mvdev->mres.group2asid[MLX5_VD=
PA_DATAVQ_DESC_GROUP]];
>
>                 if (desc_mr && MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, d=
esc_group_mkey_supported))
>                         MLX5_SET(virtio_q, vq_ctx, desc_group_mkey, desc_=
mr->mkey);
> @@ -1381,8 +1381,8 @@ static void modify_virtqueue_end(struct mlx5_vdpa_n=
et *ndev,
>         struct mlx5_vdpa_dev *mvdev =3D &ndev->mvdev;
>
>         if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_MKEY) =
{
> -               unsigned int asid =3D mvdev->group2asid[MLX5_VDPA_DATAVQ_=
GROUP];
> -               struct mlx5_vdpa_mr *vq_mr =3D mvdev->mr[asid];
> +               unsigned int asid =3D mvdev->mres.group2asid[MLX5_VDPA_DA=
TAVQ_GROUP];
> +               struct mlx5_vdpa_mr *vq_mr =3D mvdev->mres.mr[asid];
>
>                 mlx5_vdpa_put_mr(mvdev, mvq->vq_mr);
>                 mlx5_vdpa_get_mr(mvdev, vq_mr);
> @@ -1390,8 +1390,8 @@ static void modify_virtqueue_end(struct mlx5_vdpa_n=
et *ndev,
>         }
>
>         if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY=
) {
> -               unsigned int asid =3D mvdev->group2asid[MLX5_VDPA_DATAVQ_=
DESC_GROUP];
> -               struct mlx5_vdpa_mr *desc_mr =3D mvdev->mr[asid];
> +               unsigned int asid =3D mvdev->mres.group2asid[MLX5_VDPA_DA=
TAVQ_DESC_GROUP];
> +               struct mlx5_vdpa_mr *desc_mr =3D mvdev->mres.mr[asid];
>
>                 mlx5_vdpa_put_mr(mvdev, mvq->desc_mr);
>                 mlx5_vdpa_get_mr(mvdev, desc_mr);
> @@ -3235,7 +3235,7 @@ static void init_group_to_asid_map(struct mlx5_vdpa=
_dev *mvdev)
>
>         /* default mapping all groups are mapped to asid 0 */
>         for (i =3D 0; i < MLX5_VDPA_NUMVQ_GROUPS; i++)
> -               mvdev->group2asid[i] =3D 0;
> +               mvdev->mres.group2asid[i] =3D 0;
>  }
>
>  static bool needs_vqs_reset(const struct mlx5_vdpa_dev *mvdev)
> @@ -3353,7 +3353,7 @@ static int set_map_data(struct mlx5_vdpa_dev *mvdev=
, struct vhost_iotlb *iotlb,
>                 new_mr =3D NULL;
>         }
>
> -       if (!mvdev->mr[asid]) {
> +       if (!mvdev->mres.mr[asid]) {
>                 mlx5_vdpa_update_mr(mvdev, new_mr, asid);
>         } else {
>                 err =3D mlx5_vdpa_change_map(mvdev, new_mr, asid);
> @@ -3637,12 +3637,12 @@ static int mlx5_set_group_asid(struct vdpa_device=
 *vdev, u32 group,
>         if (group >=3D MLX5_VDPA_NUMVQ_GROUPS)
>                 return -EINVAL;
>
> -       mvdev->group2asid[group] =3D asid;
> +       mvdev->mres.group2asid[group] =3D asid;
>
> -       mutex_lock(&mvdev->mr_mtx);
> -       if (group =3D=3D MLX5_VDPA_CVQ_GROUP && mvdev->mr[asid])
> -               err =3D mlx5_vdpa_update_cvq_iotlb(mvdev, mvdev->mr[asid]=
->iotlb, asid);
> -       mutex_unlock(&mvdev->mr_mtx);
> +       mutex_lock(&mvdev->mres.mr_mtx);
> +       if (group =3D=3D MLX5_VDPA_CVQ_GROUP && mvdev->mres.mr[asid])
> +               err =3D mlx5_vdpa_update_cvq_iotlb(mvdev, mvdev->mres.mr[=
asid]->iotlb, asid);
> +       mutex_unlock(&mvdev->mres.mr_mtx);
>
>         return err;
>  }
> @@ -3962,7 +3962,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>         if (err)
>                 goto err_mpfs;
>
> -       INIT_LIST_HEAD(&mvdev->mr_list_head);
> +       INIT_LIST_HEAD(&mvdev->mres.mr_list_head);
>
>         if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
>                 err =3D mlx5_vdpa_create_dma_mr(mvdev);
> --
> 2.45.1
>

