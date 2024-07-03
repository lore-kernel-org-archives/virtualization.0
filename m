Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B0517B51A
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019345; cv=none; b=tkRze+PYUHnR+kwgrtNAG6+3dKpO7Gu78voofAsjUQKrznx9/v/XEvHoWjpwa9K2lKL8I/Ji7oLHYG80oHopx8uL59F6/Q2MEvzUOayvsn4xkLJ7P8xerxD//hvS1Wur5PhD9TzdQUXRmsHmWttDI2zi4L7PUPQD5nJrvbb1fqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019345; c=relaxed/simple;
	bh=jr1zoQlesMQk4r7o3HlIip0zDDWr+3fEo4jdfJsQNtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdg3UlTekAy88WcjH/My2ztOt/1Qnfca+61qz0psrmvf8cziWNQuJNvgt3EL1XJetgB8lrdaX037BrICfFROaCrnB9BBlFMJe+lmNBIaEXWW2cnuQ4PoCJ8INH6ND+U0FIGGmh/LArhxfWa6+myO/GKPkYWTz1lwAoduuXZoeAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bEdJhdGI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEdJhdGI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720019343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJxP5plkEqtGT2+Fyxc7Jfw1c1Ky2bpGqcVIJ84Skao=;
	b=bEdJhdGIBtvLFgSi0C3HiAg3lD8r6PxNFzrQgUcFD7jv+qqy8tT8nQmYM0EiF6y3AGEZZz
	FT3yYOGCQcQ9//imaVBzS/0b7guLnvfnRUVNP136zRNc55dMXnTMiOBp9d+r8TuBUcdbbO
	YOqexfY7vXvcOazTyBdAa1qxsp2d5ig=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-wS7uNYuTN7yWOsOC6UMkUQ-1; Wed, 03 Jul 2024 11:09:02 -0400
X-MC-Unique: wS7uNYuTN7yWOsOC6UMkUQ-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-701ef03180dso5021078a34.0
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 08:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720019341; x=1720624141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJxP5plkEqtGT2+Fyxc7Jfw1c1Ky2bpGqcVIJ84Skao=;
        b=ABZphMGU94RPegsm2pMssRDEyzk17W/NsfQtOtBb4YyuaR5Z2EQ253e7g9C5JSHX3V
         uKESAVqWUEBo13wfSSCe4MdkI1WNf1lC75Cxx9okuPCuxf81iTRryUOU1jbJZ7rWwvA5
         tNloh/av+kGuSq3qOhGMB0CmNc8hMrh2EYAkwVhmqt9eYmH+VPB9bVTnaN/w3nWmmsEs
         5vPEuhoWnUPA+LdxeciQvhijHatiV8pNPjyQ6D9nTWmamXKY8k1Ur1j0O8QBHudjdOjC
         Rxxnt0DKOAV1eI0MGGo3//IbCup8wtiUw7VfXP8KPf9hACLUhAxIifvSWiihV/uDe+q0
         QLHA==
X-Forwarded-Encrypted: i=1; AJvYcCXR24RlrkxC27sVpDwNdLE77cWCh+Am7tXPP9VQv5ba5Ad+JrB/o4nKqr3pvDNTZfuty5OcHRmUlgRMsuxa+cItRYhHhsQkdJ1Lq6MLlCg=
X-Gm-Message-State: AOJu0YzhWVBiDVdvpbejuTmagNqC6b95MNPFCKuYpUNqZ7e684cha7es
	t/t1E+jOp/udT8hJZjtwl3lK9YChSIOoXGuR56xhLtQgOVh6bWhA9mboOPYqHZHJuZq9106+qW+
	1R2DTmApvzuuH58tbErMjiA6K+FrPtrmw+2HdLt6esPOIh7IuHb7TrNwZ36Gs7KOjJGXX4HRzTv
	VTzTISwJ7geB3vAqwwMJnQa831oi3Q3pmQCAQvmwU=
X-Received: by 2002:a9d:68d8:0:b0:702:2550:4e2c with SMTP id 46e09a7af769-702255051e8mr4714177a34.14.1720019340947;
        Wed, 03 Jul 2024 08:09:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZVFTIESQ8I8751zJPQrUjeFOeuFR0etgZWdHlMXhxuGEMPW7TYqK1PmAoORoUI/N+D8s9cfchZbSZ1h971QY=
X-Received: by 2002:a9d:68d8:0:b0:702:2550:4e2c with SMTP id
 46e09a7af769-702255051e8mr4714149a34.14.1720019340676; Wed, 03 Jul 2024
 08:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com> <20240626-stage-vdpa-vq-precreate-v2-9-560c491078df@nvidia.com>
In-Reply-To: <20240626-stage-vdpa-vq-precreate-v2-9-560c491078df@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Jul 2024 17:08:24 +0200
Message-ID: <CAJaqyWf-MRS9ahonzAvuHVQ4dfgm6FQPmqk_vKMiRag7XDB8Sw@mail.gmail.com>
Subject: Re: [PATCH vhost v2 09/24] vdpa/mlx5: Rename init_mvqs
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 12:27=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> Function is used to set default values, so name it accordingly.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index de013b5a2815..739c2886fc33 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -155,7 +155,7 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mvde=
v, u16 idx)
>  }
>
>  static void free_fixed_resources(struct mlx5_vdpa_net *ndev);
> -static void init_mvqs(struct mlx5_vdpa_net *ndev);
> +static void mvqs_set_defaults(struct mlx5_vdpa_net *ndev);
>  static int setup_vq_resources(struct mlx5_vdpa_net *ndev);
>  static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
>
> @@ -2810,7 +2810,7 @@ static void restore_channels_info(struct mlx5_vdpa_=
net *ndev)
>         int i;
>
>         mlx5_clear_vqs(ndev);
> -       init_mvqs(ndev);
> +       mvqs_set_defaults(ndev);
>         for (i =3D 0; i < ndev->mvdev.max_vqs; i++) {
>                 mvq =3D &ndev->vqs[i];
>                 ri =3D &mvq->ri;
> @@ -3023,7 +3023,7 @@ static int mlx5_vdpa_compat_reset(struct vdpa_devic=
e *vdev, u32 flags)
>         down_write(&ndev->reslock);
>         unregister_link_notifier(ndev);
>         teardown_vq_resources(ndev);
> -       init_mvqs(ndev);
> +       mvqs_set_defaults(ndev);
>
>         if (flags & VDPA_RESET_F_CLEAN_MAP)
>                 mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
> @@ -3485,7 +3485,7 @@ static void free_fixed_resources(struct mlx5_vdpa_n=
et *ndev)
>         res->valid =3D false;
>  }
>
> -static void init_mvqs(struct mlx5_vdpa_net *ndev)
> +static void mvqs_set_defaults(struct mlx5_vdpa_net *ndev)
>  {
>         struct mlx5_vdpa_virtqueue *mvq;
>         int i;
> @@ -3635,7 +3635,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>         }
>         ndev->cur_num_vqs =3D MLX5V_DEFAULT_VQ_COUNT;
>
> -       init_mvqs(ndev);
> +       mvqs_set_defaults(ndev);
>         allocate_irqs(ndev);
>         init_rwsem(&ndev->reslock);
>         config =3D &ndev->config;
>
> --
> 2.45.1
>

