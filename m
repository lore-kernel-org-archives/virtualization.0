Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1FE183093
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023567; cv=none; b=C+5yCmjEDYFVizSS8pO8s2v5iIy+5QCVmBbuhg2612EDUDSezM+LSgtkoJ7H9MJ/51XUchG6Ewl1XCRE6Gi4oFH4IgHciReZI8V3d7e3tkMuIa7pu/mKLqFxptUr5WL+aPlzrE6yduEYY/d+iiM0yUzEitR2XWKFcQjooNIvK60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023567; c=relaxed/simple;
	bh=XZQ2khpGw92ayYyOOjfsbAZCVbk4sLWNq5yArPaelbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kc9A48o/x9EBdjSrfH5LBBva2mpxbgzUeCERILGcciGPkvWHOHoTPWOOeov6XGztOlP+/OhTESv2J8v4WYMjiS+EhVXpNGDJTdAFORIH7gFTfyxlQNvudzTQIb6921O3mPjfPLWOj6XdAFdq39VM1AihffPlOkB5Igw0h01ovGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aX6ZtfEb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aX6ZtfEb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720023564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c65T9aGcCrnJaJaWK+o0SC+aJQfT0XzRMaqMZ/EJDM4=;
	b=aX6ZtfEbo98pypUCvf4AMeZ1spGLC32UTmmcXs+aK7ozjLJHnoFUZ7HmLrpnjMTAxsdZP/
	ayB7dawGtYr4FgEVTR9ILLN/mUjWd3IUCXJWxnPzzmC0MtTfA4kGfv/765ZlPeLzjweqS3
	njOP0lMWO5o/ZBR+CobUU8MV4E6gv8A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-WtwScTU_ONyCI-xKvYavmg-1; Wed, 03 Jul 2024 12:19:23 -0400
X-MC-Unique: WtwScTU_ONyCI-xKvYavmg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-58b92b79a46so1154313a12.0
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 09:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023562; x=1720628362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c65T9aGcCrnJaJaWK+o0SC+aJQfT0XzRMaqMZ/EJDM4=;
        b=YAS+VszEsl07JmW2zDSVW5uYFt3nGAZtqkjCNB7Jv7KJIMQwvk/c3w9mVV/N8bEJNs
         OYbQRl5QP3F6mcuggS0oVvmjfvz7xYGPdN+uKA+KSOfPJjXRk2e+aNhyfR5faj3jR7aA
         j4jmZb9hqfXXIU/gS0H9WkYVejU//g4mamncOxUWBrxEiEnSp0Mdqc49M2SapnaA3gN7
         SYcUjBrDfoudefRDBv0Gb2SEDyW0YcR/wi4B82Dxma6BdIgPVBPqiIAyjlZ7/St6ZVrc
         KHW9IWOOl30uge6PKd6LuRlGfEK4GSAqJcTfrgwm1Z5VdcILHuZgcjEXJ7lx/SzOVNFm
         OT5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0SbKcc/ovaMemMOCUVCbaOHhAciNgBbCYE3EJwjfmreuU7TO0tgyYKbOlRP/DJdwBj1kslkfHmxdBkq2I02kiRQwRDS+Md6H0udD0McA=
X-Gm-Message-State: AOJu0Yy/fz6iKkAr6sitKVrta8IJeMaIV/x7mxFB9rmDT7Nng0SwraiT
	wHRb9tpJ3707UXAUBNtmzArgcUuvTRtpRshFVpKsbVMjTc63z6y6baNa/Oeb7jXYFn+J5F2Y4q6
	kIZuI3Ebg5L3msTYSruTMSnZaoeiI01SxTtwsiA13bqTkb5yHUy4z0DELK6T9+oDi/tnC0Da+mk
	qNb53gEbCd2ChJxP2oJjehAee4Zk7uJZzybbtYvRY=
X-Received: by 2002:a05:6402:3591:b0:58c:b2b8:31b2 with SMTP id 4fb4d7f45d1cf-58ce5ef6ad8mr1719690a12.17.1720023562396;
        Wed, 03 Jul 2024 09:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOPm2RKAFqhIP4SkrsoOYtpsOdJlOeWv6pMlJEn55IU/y69hvTL9KLEEXmYY5vce/n+pf4qv0hzVawdzxulgw=
X-Received: by 2002:a05:6402:3591:b0:58c:b2b8:31b2 with SMTP id
 4fb4d7f45d1cf-58ce5ef6ad8mr1719679a12.17.1720023562050; Wed, 03 Jul 2024
 09:19:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com> <20240626-stage-vdpa-vq-precreate-v2-15-560c491078df@nvidia.com>
In-Reply-To: <20240626-stage-vdpa-vq-precreate-v2-15-560c491078df@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Jul 2024 18:18:44 +0200
Message-ID: <CAJaqyWfEv9KLKDSZidiO=ZoJvKVLaHzHW3+ModPxfGEiu1xMUw@mail.gmail.com>
Subject: Re: [PATCH vhost v2 15/24] vdpa/mlx5: Allow creation of blank VQs
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

On Wed, Jun 26, 2024 at 12:28=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> Based on the filled flag, create VQs that are filled or blank.
> Blank VQs will be filled in later through VQ modify.
>
> Downstream patches will make use of this to pre-create blank VQs at
> vdpa device creation.
>

s/Downstream/Later/ ?

> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 85 +++++++++++++++++++++++++--------=
------
>  1 file changed, 55 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index a8ac542f30f7..0a62ce0b4af8 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -158,7 +158,7 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mvde=
v, u16 idx)
>
>  static void free_fixed_resources(struct mlx5_vdpa_net *ndev);
>  static void mvqs_set_defaults(struct mlx5_vdpa_net *ndev);
> -static int setup_vq_resources(struct mlx5_vdpa_net *ndev);
> +static int setup_vq_resources(struct mlx5_vdpa_net *ndev, bool filled);
>  static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
>
>  static bool mlx5_vdpa_debug;
> @@ -874,13 +874,16 @@ static bool msix_mode_supported(struct mlx5_vdpa_de=
v *mvdev)
>                 pci_msix_can_alloc_dyn(mvdev->mdev->pdev);
>  }
>
> -static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa=
_virtqueue *mvq)
> +static int create_virtqueue(struct mlx5_vdpa_net *ndev,
> +                           struct mlx5_vdpa_virtqueue *mvq,
> +                           bool filled)
>  {
>         int inlen =3D MLX5_ST_SZ_BYTES(create_virtio_net_q_in);
>         u32 out[MLX5_ST_SZ_DW(create_virtio_net_q_out)] =3D {};
>         struct mlx5_vdpa_dev *mvdev =3D &ndev->mvdev;
>         struct mlx5_vdpa_mr *vq_mr;
>         struct mlx5_vdpa_mr *vq_desc_mr;
> +       u64 features =3D filled ? mvdev->actual_features : mvdev->mlx_fea=
tures;
>         void *obj_context;
>         u16 mlx_features;
>         void *cmd_hdr;
> @@ -898,7 +901,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *nde=
v, struct mlx5_vdpa_virtque
>                 goto err_alloc;
>         }
>
> -       mlx_features =3D get_features(ndev->mvdev.actual_features);
> +       mlx_features =3D get_features(features);
>         cmd_hdr =3D MLX5_ADDR_OF(create_virtio_net_q_in, in, general_obj_=
in_cmd_hdr);
>
>         MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, opcode, MLX5_CMD_OP_CRE=
ATE_GENERAL_OBJECT);
> @@ -906,8 +909,6 @@ static int create_virtqueue(struct mlx5_vdpa_net *nde=
v, struct mlx5_vdpa_virtque
>         MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.ui=
d);
>
>         obj_context =3D MLX5_ADDR_OF(create_virtio_net_q_in, in, obj_cont=
ext);
> -       MLX5_SET(virtio_net_q_object, obj_context, hw_available_index, mv=
q->avail_idx);
> -       MLX5_SET(virtio_net_q_object, obj_context, hw_used_index, mvq->us=
ed_idx);
>         MLX5_SET(virtio_net_q_object, obj_context, queue_feature_bit_mask=
_12_3,
>                  mlx_features >> 3);
>         MLX5_SET(virtio_net_q_object, obj_context, queue_feature_bit_mask=
_2_0,
> @@ -929,17 +930,36 @@ static int create_virtqueue(struct mlx5_vdpa_net *n=
dev, struct mlx5_vdpa_virtque
>         MLX5_SET(virtio_q, vq_ctx, queue_index, mvq->index);
>         MLX5_SET(virtio_q, vq_ctx, queue_size, mvq->num_ent);
>         MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0,
> -                !!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_F_VERSIO=
N_1)));
> -       MLX5_SET64(virtio_q, vq_ctx, desc_addr, mvq->desc_addr);
> -       MLX5_SET64(virtio_q, vq_ctx, used_addr, mvq->device_addr);
> -       MLX5_SET64(virtio_q, vq_ctx, available_addr, mvq->driver_addr);
> -       vq_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]];
> -       if (vq_mr)
> -               MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, vq_mr->mkey);
> -
> -       vq_desc_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_DESC_=
GROUP]];
> -       if (vq_desc_mr && MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, desc_g=
roup_mkey_supported))
> -               MLX5_SET(virtio_q, vq_ctx, desc_group_mkey, vq_desc_mr->m=
key);
> +                !!(features & BIT_ULL(VIRTIO_F_VERSION_1)));
> +
> +       if (filled) {
> +               MLX5_SET(virtio_net_q_object, obj_context, hw_available_i=
ndex, mvq->avail_idx);
> +               MLX5_SET(virtio_net_q_object, obj_context, hw_used_index,=
 mvq->used_idx);
> +
> +               MLX5_SET64(virtio_q, vq_ctx, desc_addr, mvq->desc_addr);
> +               MLX5_SET64(virtio_q, vq_ctx, used_addr, mvq->device_addr)=
;
> +               MLX5_SET64(virtio_q, vq_ctx, available_addr, mvq->driver_=
addr);
> +
> +               vq_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GR=
OUP]];
> +               if (vq_mr)
> +                       MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, vq_mr->=
mkey);
> +
> +               vq_desc_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATA=
VQ_DESC_GROUP]];
> +               if (vq_desc_mr &&
> +                   MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, desc_group_m=
key_supported))
> +                       MLX5_SET(virtio_q, vq_ctx, desc_group_mkey, vq_de=
sc_mr->mkey);
> +       } else {
> +               /* If there is no mr update, make sure that the existing =
ones are set
> +                * modify to ready.
> +                */
> +               vq_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GR=
OUP]];
> +               if (vq_mr)
> +                       mvq->modified_fields |=3D MLX5_VIRTQ_MODIFY_MASK_=
VIRTIO_Q_MKEY;
> +
> +               vq_desc_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATA=
VQ_DESC_GROUP]];
> +               if (vq_desc_mr)
> +                       mvq->modified_fields |=3D MLX5_VIRTQ_MODIFY_MASK_=
DESC_GROUP_MKEY;
> +       }
>
>         MLX5_SET(virtio_q, vq_ctx, umem_1_id, mvq->umem1.id);
>         MLX5_SET(virtio_q, vq_ctx, umem_1_size, mvq->umem1.size);
> @@ -959,12 +979,15 @@ static int create_virtqueue(struct mlx5_vdpa_net *n=
dev, struct mlx5_vdpa_virtque
>         kfree(in);
>         mvq->virtq_id =3D MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
>
> -       mlx5_vdpa_get_mr(mvdev, vq_mr);
> -       mvq->vq_mr =3D vq_mr;
> +       if (filled) {
> +               mlx5_vdpa_get_mr(mvdev, vq_mr);
> +               mvq->vq_mr =3D vq_mr;
>
> -       if (vq_desc_mr && MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, desc_g=
roup_mkey_supported)) {
> -               mlx5_vdpa_get_mr(mvdev, vq_desc_mr);
> -               mvq->desc_mr =3D vq_desc_mr;
> +               if (vq_desc_mr &&
> +                   MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, desc_group_m=
key_supported)) {
> +                       mlx5_vdpa_get_mr(mvdev, vq_desc_mr);
> +                       mvq->desc_mr =3D vq_desc_mr;
> +               }
>         }
>
>         return 0;
> @@ -1442,7 +1465,9 @@ static void dealloc_vector(struct mlx5_vdpa_net *nd=
ev,
>                 }
>  }
>
> -static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque=
ue *mvq)
> +static int setup_vq(struct mlx5_vdpa_net *ndev,
> +                   struct mlx5_vdpa_virtqueue *mvq,
> +                   bool filled)
>  {
>         u16 idx =3D mvq->index;
>         int err;
> @@ -1471,7 +1496,7 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, str=
uct mlx5_vdpa_virtqueue *mvq)
>                 goto err_connect;
>
>         alloc_vector(ndev, mvq);
> -       err =3D create_virtqueue(ndev, mvq);
> +       err =3D create_virtqueue(ndev, mvq, filled);
>         if (err)
>                 goto err_vq;
>
> @@ -2062,7 +2087,7 @@ static int change_num_qps(struct mlx5_vdpa_dev *mvd=
ev, int newqps)
>         } else {
>                 ndev->cur_num_vqs =3D 2 * newqps;
>                 for (i =3D cur_qps * 2; i < 2 * newqps; i++) {
> -                       err =3D setup_vq(ndev, &ndev->vqs[i]);
> +                       err =3D setup_vq(ndev, &ndev->vqs[i], true);
>                         if (err)
>                                 goto clean_added;
>                 }
> @@ -2558,14 +2583,14 @@ static int verify_driver_features(struct mlx5_vdp=
a_dev *mvdev, u64 features)
>         return 0;
>  }
>
> -static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev)
> +static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev, bool filled)
>  {
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
>         int err;
>         int i;
>
>         for (i =3D 0; i < mvdev->max_vqs; i++) {
> -               err =3D setup_vq(ndev, &ndev->vqs[i]);
> +               err =3D setup_vq(ndev, &ndev->vqs[i], filled);
>                 if (err)
>                         goto err_vq;
>         }
> @@ -2877,7 +2902,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev,
>
>         if (teardown) {
>                 restore_channels_info(ndev);
> -               err =3D setup_vq_resources(ndev);
> +               err =3D setup_vq_resources(ndev, true);
>                 if (err)
>                         return err;
>         }
> @@ -2888,7 +2913,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev,
>  }
>
>  /* reslock must be held for this function */
> -static int setup_vq_resources(struct mlx5_vdpa_net *ndev)
> +static int setup_vq_resources(struct mlx5_vdpa_net *ndev, bool filled)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D &ndev->mvdev;
>         int err;
> @@ -2906,7 +2931,7 @@ static int setup_vq_resources(struct mlx5_vdpa_net =
*ndev)
>         if (err)
>                 goto err_setup;
>
> -       err =3D setup_virtqueues(mvdev);
> +       err =3D setup_virtqueues(mvdev, filled);
>         if (err) {
>                 mlx5_vdpa_warn(mvdev, "setup_virtqueues\n");
>                 goto err_setup;
> @@ -3000,7 +3025,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device=
 *vdev, u8 status)
>                                 goto err_setup;
>                         }
>                         register_link_notifier(ndev);
> -                       err =3D setup_vq_resources(ndev);
> +                       err =3D setup_vq_resources(ndev, true);
>                         if (err) {
>                                 mlx5_vdpa_warn(mvdev, "failed to setup dr=
iver\n");
>                                 goto err_driver;
>
> --
> 2.45.1
>

