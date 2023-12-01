Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E5D21378
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPoWitbd"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85B4B847FB
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 11:47:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 85B4B847FB
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GPoWitbd
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I1cv6osmWaTY
	for <virtualization@lists.linux-foundation.org>;
	Fri,  1 Dec 2023 11:47:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9470D847F6
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 11:47:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9470D847F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701431244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6uHVtje56LWat5Vmv+PcEyAck+di+XL9VN6HEiOJE+M=;
	b=GPoWitbd6ghvph4382uGlvJ8gRpNWuWmCjIVumwaw1h0HsuuL3vZk9Z/SRAfxQm8093/eP
	6XAsJTsKD4UUKAiGhJ8nPxnMgLdAJ3CEburMVmReV4JRaCdh9koEQjvdoQGQdNTpMIMNcv
	yqSMYV98lc5yxmHculR9LgEhBDsQYE4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-Zbn0bGtLOjuo6g7MGupLiA-1; Fri, 01 Dec 2023 06:47:22 -0500
X-MC-Unique: Zbn0bGtLOjuo6g7MGupLiA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5ca61d84dc3so35707867b3.0
        for <virtualization@lists.linux-foundation.org>; Fri, 01 Dec 2023 03:47:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701431242; x=1702036042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uHVtje56LWat5Vmv+PcEyAck+di+XL9VN6HEiOJE+M=;
        b=FYBzpR2uc0gTsW4j6eikkTH5WDh2+wLy2UQORnlqsMJl/CBazgUS9DLquaWMvxnpqg
         FOT84NK4pIFd5CMgf6+wslNe/3f3aN2IOpeaHmq4w4ntExuTHVXqBKL+1S1amJwSCZ2C
         25TLnN76ChkucICEqXt20vQ3felqhu64MvvKathj9kehR6wzBwv2EfIDTnDIdxWCTE39
         26moFAyF+CN2F2QN2ty1z8tP66KJC3DpSLdvr1lHxYNPBZg9U3Bxv12mMl0U4NMZcEtU
         BLgzFV9FlURqoKx26qMcLkVUupodXhR0eO3Ob6QVwCGUh274g1hnqbmCB4kq93+iGz02
         YByQ==
X-Gm-Message-State: AOJu0YzBo3zKRGCUaRv/947w8oxyrHiFlj2VlHZ01SfRTZl8MQyUlto3
	pvJFdv/OSQ3b17DIonn537cxTH2B4Ee8iQ7Ffn73wNy3BolKYhmH7zYRWaKvGqJbdDBreVa0hYZ
	LZx14ZOVSX7F+/hazyc0LtSoGuMM2s23Q+qty4tWlUMQxIIjgJcZZStldwA==
X-Received: by 2002:a81:b60c:0:b0:5d4:226f:69a4 with SMTP id u12-20020a81b60c000000b005d4226f69a4mr1446074ywh.28.1701431241868;
        Fri, 01 Dec 2023 03:47:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGg2MuyiMF1tTj3uUQulmb0jD2AozD8K6xVD0pM3BW790ulvznuBYypSmkNfOvOQQkPXQZjksPtzVYkngc8Se0=
X-Received: by 2002:a81:b60c:0:b0:5d4:226f:69a4 with SMTP id
 u12-20020a81b60c000000b005d4226f69a4mr1446054ywh.28.1701431241604; Fri, 01
 Dec 2023 03:47:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231201104857.665737-1-dtatulea@nvidia.com> <20231201104857.665737-3-dtatulea@nvidia.com>
In-Reply-To: <20231201104857.665737-3-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 1 Dec 2023 12:46:45 +0100
Message-ID: <CAJaqyWc3Xa9abmS+MxFbgQHUao0_=tcx4mres2AeDWqvtmZ5Jg@mail.gmail.com>
Subject: Re: [PATCH vhost 2/7] vdpa/mlx5: Split function into locked and
 unlocked variants
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

On Fri, Dec 1, 2023 at 11:49=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> mlx5_vdpa_destroy_mr contains more logic than _mlx5_vdpa_destroy_mr.
> There is no reason for this to be the case. All the logic can go into
> the unlocked variant.
>
> Using the unlocked version is needed in a follow-up patch. And it also
> makes it more consistent with mlx5_vdpa_create_mr.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/core/mr.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 2197c46e563a..8c80d9e77935 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -498,32 +498,32 @@ static void destroy_user_mr(struct mlx5_vdpa_dev *m=
vdev, struct mlx5_vdpa_mr *mr
>
>  static void _mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, struct ml=
x5_vdpa_mr *mr)
>  {
> +       if (!mr)
> +               return;
> +
>         if (mr->user_mr)
>                 destroy_user_mr(mvdev, mr);
>         else
>                 destroy_dma_mr(mvdev, mr);
>
> +       for (int i =3D 0; i < MLX5_VDPA_NUM_AS; i++) {
> +               if (mvdev->mr[i] =3D=3D mr)
> +                       mvdev->mr[i] =3D NULL;
> +       }
> +
>         vhost_iotlb_free(mr->iotlb);
> +
> +       kfree(mr);
>  }
>
>  void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev,
>                           struct mlx5_vdpa_mr *mr)
>  {
> -       if (!mr)
> -               return;
> -
>         mutex_lock(&mvdev->mr_mtx);
>
>         _mlx5_vdpa_destroy_mr(mvdev, mr);
>
> -       for (int i =3D 0; i < MLX5_VDPA_NUM_AS; i++) {
> -               if (mvdev->mr[i] =3D=3D mr)
> -                       mvdev->mr[i] =3D NULL;
> -       }
> -
>         mutex_unlock(&mvdev->mr_mtx);
> -
> -       kfree(mr);
>  }
>
>  void mlx5_vdpa_update_mr(struct mlx5_vdpa_dev *mvdev,
> @@ -535,10 +535,7 @@ void mlx5_vdpa_update_mr(struct mlx5_vdpa_dev *mvdev=
,
>         mutex_lock(&mvdev->mr_mtx);
>
>         mvdev->mr[asid] =3D new_mr;
> -       if (old_mr) {
> -               _mlx5_vdpa_destroy_mr(mvdev, old_mr);
> -               kfree(old_mr);
> -       }
> +       _mlx5_vdpa_destroy_mr(mvdev, old_mr);
>
>         mutex_unlock(&mvdev->mr_mtx);
>
> @@ -546,8 +543,12 @@ void mlx5_vdpa_update_mr(struct mlx5_vdpa_dev *mvdev=
,
>
>  void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
>  {
> +       mutex_lock(&mvdev->mr_mtx);
> +
>         for (int i =3D 0; i < MLX5_VDPA_NUM_AS; i++)
> -               mlx5_vdpa_destroy_mr(mvdev, mvdev->mr[i]);
> +               _mlx5_vdpa_destroy_mr(mvdev, mvdev->mr[i]);
> +
> +       mutex_unlock(&mvdev->mr_mtx);
>
>         prune_iotlb(mvdev->cvq.iotlb);
>  }
> --
> 2.42.0
>

