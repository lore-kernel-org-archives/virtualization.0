Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810114A996
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMkZwRk9"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4A2242111
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 15:19:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E4A2242111
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SMkZwRk9
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p5sY_jzAodet
	for <virtualization@lists.linux-foundation.org>;
	Fri,  1 Dec 2023 15:19:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2125E420F8
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 15:19:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2125E420F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701443963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXm7ORGqBZRQibD2CXBq2iXnUxr20ROajaE6s0OsD8s=;
	b=SMkZwRk9oXe53R/8mGZU8Q1WFaTn+MnPK1Pod+G2xRvo5glfGBd9/AgegEDiZ0gX2Vc2xS
	X5tZlPlZsrZ022yWGPpXYkmc5aW0PhCX8CKvCjFNqdRizllRdP48ruLnOqAPEqG2hdSyfy
	i1TllnRHoF7y6gW0EbqxeJdVUamDxcM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-eoIsJogyNqO5jkoNaEjKkA-1; Fri, 01 Dec 2023 10:19:21 -0500
X-MC-Unique: eoIsJogyNqO5jkoNaEjKkA-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5c87663a873so33067297b3.2
        for <virtualization@lists.linux-foundation.org>; Fri, 01 Dec 2023 07:19:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443960; x=1702048760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXm7ORGqBZRQibD2CXBq2iXnUxr20ROajaE6s0OsD8s=;
        b=NpA81HtSPsjisHgZnIFni6nH1IgSiBztHknlEnOMC+noVQ5JIQzhRHz15Vs5vobPkg
         i55Nv5Y0OU4j8Abka0werXp66zWMy5UgW7lIKYGYriqEXY5ZqLLfEBo5nm3qWM5TJW7O
         sQLkwtmR0r6Jl1AhoAGwpmqGC6ZWoe7mrRKw7qAnBvUKI7L+zbDueR4ivjxGZMpvOUp7
         To9O7c5MCtPbF0okK0Neo4RvsJB6Dz5YprDaYm9WqCkNeNZmfH8BvoeyqHwPPd++WLz7
         1cyiHLBaVPbsz+7zwTgGfUL8VS50eK6VUFUjs1TzElKVs46LpWoP/XVdWsITWBww7ew/
         MhaA==
X-Gm-Message-State: AOJu0YzAOs+vMuEtiWfYpAgOqKi8kEw3HjiMaTgYD5wooAYS3B8Q3X1t
	easTUdtMxhOOGFSQaVEWxRUYi4qMJIDa9PQhwF541mbHqZFQ/oo7bWdsoC/U+abtLyuVIWfcefT
	LdS66MAeXcywSs3VrETvNfLQq+PweVmgCTs3+fF7UU2Uk7WxMu7lFM4yQcg==
X-Received: by 2002:a0d:db0f:0:b0:5d6:b412:19dc with SMTP id d15-20020a0ddb0f000000b005d6b41219dcmr1122970ywe.8.1701443960726;
        Fri, 01 Dec 2023 07:19:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6lDZLBFR1eE1535WBabPzL29pPwJmipsUSBju2+viJweB3LEtTtxcMwvU+ISfzmVUVeodvROTWBtiXJgwI/Y=
X-Received: by 2002:a0d:db0f:0:b0:5d6:b412:19dc with SMTP id
 d15-20020a0ddb0f000000b005d6b41219dcmr1122957ywe.8.1701443960471; Fri, 01 Dec
 2023 07:19:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231201104857.665737-1-dtatulea@nvidia.com> <20231201104857.665737-7-dtatulea@nvidia.com>
In-Reply-To: <20231201104857.665737-7-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 1 Dec 2023 16:18:44 +0100
Message-ID: <CAJaqyWc1msHWR_5BrFM2F3JBcLriNLhE43Zh-LOz490Xzrz5ng@mail.gmail.com>
Subject: Re: [PATCH vhost 6/7] vdpa/mlx5: Mark vq state for modification in hw vq
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, virtualization@lists.linux-foundation.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Gal Pressman <galp@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 11:50=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> .set_vq_state will set the indices and mark the fields to be modified in
> the hw vq.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 8 ++++++++
>  include/linux/mlx5/mlx5_ifc_vdpa.h | 2 ++
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 2277daf4814f..6325aef045e2 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1249,6 +1249,12 @@ static int modify_virtqueue(struct mlx5_vdpa_net *=
ndev,
>                 MLX5_SET64(virtio_q, vq_ctx, available_addr, mvq->driver_=
addr);
>         }
>
> +       if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_AVAIL_=
IDX)
> +               MLX5_SET(virtio_net_q_object, obj_context, hw_available_i=
ndex, mvq->avail_idx);
> +
> +       if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_USED_I=
DX)
> +               MLX5_SET(virtio_net_q_object, obj_context, hw_used_index,=
 mvq->used_idx);
> +
>         MLX5_SET64(virtio_net_q_object, obj_context, modify_field_select,=
 mvq->modified_fields);
>         err =3D mlx5_cmd_exec(ndev->mvdev.mdev, in, inlen, out, sizeof(ou=
t));
>         if (err)
> @@ -2328,6 +2334,8 @@ static int mlx5_vdpa_set_vq_state(struct vdpa_devic=
e *vdev, u16 idx,
>
>         mvq->used_idx =3D state->split.avail_index;
>         mvq->avail_idx =3D state->split.avail_index;
> +       mvq->modified_fields |=3D MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_AVAIL_I=
DX |
> +                               MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_USED_IDX;
>         return 0;
>  }
>
> diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5=
_ifc_vdpa.h
> index 9594ac405740..32e712106e68 100644
> --- a/include/linux/mlx5/mlx5_ifc_vdpa.h
> +++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
> @@ -146,6 +146,8 @@ enum {
>         MLX5_VIRTQ_MODIFY_MASK_DIRTY_BITMAP_PARAMS      =3D (u64)1 << 3,
>         MLX5_VIRTQ_MODIFY_MASK_DIRTY_BITMAP_DUMP_ENABLE =3D (u64)1 << 4,
>         MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_ADDRS           =3D (u64)1 << 6,
> +       MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_AVAIL_IDX       =3D (u64)1 << 7,
> +       MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_USED_IDX        =3D (u64)1 << 8,
>         MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY          =3D (u64)1 << 14,
>  };
>
> --
> 2.42.0
>

