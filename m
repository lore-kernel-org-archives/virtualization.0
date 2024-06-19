Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F391814F9F1
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812059; cv=none; b=SlVCeK1RDI/U++vm8haxAypHWdiyCE/fyqzYGoG67aFeqnO6oy9FiK65b69yg/cNMwWm+5mJyrZptm0A3UeN9fiWjtoKHYuqWquQF99r3IWpGrsDRbPIqIVgAHEeyNdoRZkPzs8725vJDNUw4RR/AZQNxv9/HGFQIIGvsEIBBZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812059; c=relaxed/simple;
	bh=JYrn5yh+hnO7LhELR0hV0l6YRXobPrRRbY9BLOUoMfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQsO0YudMn9qMKF3mYe10zSY8OnVdKQ4Is5f2z7wEAmyn9MkKM+ED9S9VBrEQ7982yuqihRKyaQ3HIlJtu0CPNokvTVS/ZP2NsN+MEy6/26MK8JX+CjNMU8P/ky1352MNxmN8IuUx/SrhJzLghVjjTFSIN/Rezs+0cSzeaVRE5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avO952vx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avO952vx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718812057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdE1JwX4XUPlHCUNEa7GPYLNmBeA++RuMxTVFfl0GYk=;
	b=avO952vxPUbG5LB6hSkjqaCT3bKLetsueqFr9mhOkZYee8FnQHVC2mb8ICACNEssihdnsY
	XMtwpTtr1vxpmt+CFiPZ4UjChi7FB2ugnzS8qjCTb8J+SgcigtHkMdIgSUIWqTXzZvaRsp
	TvzcBQjujm84BN8iyNryXYejlsfpY3o=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-71c_JbywNV-kXyJYhOrgPg-1; Wed, 19 Jun 2024 11:47:35 -0400
X-MC-Unique: 71c_JbywNV-kXyJYhOrgPg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6344d164c35so83178077b3.1
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 08:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718812055; x=1719416855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdE1JwX4XUPlHCUNEa7GPYLNmBeA++RuMxTVFfl0GYk=;
        b=kVtuMcS5ujqDbdOzRbE4cuAzyB/Tswhok6ShkhLKMGtBhvVMdeo8mrTHaJLjFd/thl
         reC0ZR4vajfmFNOZTGcmvaxG7FvxNhA4RmOe8HNsHNR2dXPUxhSLX03guV3zo/Jy+/cE
         hXdgEcClnp+VbIH/UgDNwgdZcyHFose/K4vdgErbqm4Gss2+O+hs8aGMirE+QmRCsJwm
         Kh8XwjLVqBdJLBu5L7dJ6nb8b0wQs+ftxz6+2qlUw95VA99+kQ4ijMd3PMWYfGwTvC0i
         YmnTV+FZZU5DbQ3R0tOsRcKrXa1UPe0vkQkmRtBg4c5QYu72FMxY4TLcD+gad/7ucYlA
         JDOA==
X-Forwarded-Encrypted: i=1; AJvYcCV8E9K4Nougnx+u5AaozaCVyNmYQD4oR8wy17OfddeWGJRmn2qCZF+wz0iEwGeTXg1RuBeYUu7wsqPUI6Tn+93qlRgBEd1LLrrpl6JbTnQ=
X-Gm-Message-State: AOJu0YwY1dtt8q8ucrX7deWOvUnuN/4j1xXlUtbcQiO6z6F0GsqM1dMm
	ZlpjUlDQe4K/Ecn1V4+7ZzcHGWI0x5HgWMM3P+8uIB9O8QCvGnV9tFTWei3acY2RaSMNi9vk/yT
	S86ACzJaivwOFt/0nx3smdu7RHXM5tg0azouEpR2g3e9F7dXskKKYrkduGcg6rgI+F5sdcXy8sT
	O4H4G/33wZXM6TZLAvVlHPVM+TN8ORnkGCJI0tKUE=
X-Received: by 2002:a81:87c6:0:b0:622:c964:7e24 with SMTP id 00721157ae682-63a8e89bed9mr28085827b3.27.1718812054988;
        Wed, 19 Jun 2024 08:47:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGARc89i/ByokkRmsf8KW6yRGKzxLntpgug1yeSYVGWvi8wS+8L3zugBKbhE/rnCTMx3tu5/cQQG/VU5SbeX3c=
X-Received: by 2002:a81:87c6:0:b0:622:c964:7e24 with SMTP id
 00721157ae682-63a8e89bed9mr28085337b3.27.1718812053908; Wed, 19 Jun 2024
 08:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-19-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-19-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 17:46:57 +0200
Message-ID: <CAJaqyWc5rJT666R672f2RQZvAHxy1QdoUKRfCH_wV1F61pQ2Gg@mail.gmail.com>
Subject: Re: [PATCH vhost 19/23] vdpa/mlx5: Use suspend/resume during VQP change
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

On Mon, Jun 17, 2024 at 5:09=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Resume a VQ if it is already created when the number of VQ pairs
> increases. This is done in preparation for VQ pre-creation which is
> coming in a later patch. It is necessary because calling setup_vq() on
> an already created VQ will return early and will not enable the queue.
>
> For symmetry, suspend a VQ instead of tearing it down when the number of
> VQ pairs decreases. But only if the resume operation is supported.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 0e1c1b7ff297..249b5afbe34a 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2130,14 +2130,22 @@ static int change_num_qps(struct mlx5_vdpa_dev *m=
vdev, int newqps)
>                 if (err)
>                         return err;
>
> -               for (i =3D ndev->cur_num_vqs - 1; i >=3D 2 * newqps; i--)
> -                       teardown_vq(ndev, &ndev->vqs[i]);
> +               for (i =3D ndev->cur_num_vqs - 1; i >=3D 2 * newqps; i--)=
 {
> +                       struct mlx5_vdpa_virtqueue *mvq =3D &ndev->vqs[i]=
;
> +
> +                       if (is_resumable(ndev))
> +                               suspend_vq(ndev, mvq);
> +                       else
> +                               teardown_vq(ndev, mvq);
> +               }
>
>                 ndev->cur_num_vqs =3D 2 * newqps;
>         } else {
>                 ndev->cur_num_vqs =3D 2 * newqps;
>                 for (i =3D cur_qps * 2; i < 2 * newqps; i++) {
> -                       err =3D setup_vq(ndev, &ndev->vqs[i], true);
> +                       struct mlx5_vdpa_virtqueue *mvq =3D &ndev->vqs[i]=
;
> +
> +                       err =3D mvq->initialized ? resume_vq(ndev, mvq) :=
 setup_vq(ndev, mvq, true);
>                         if (err)
>                                 goto clean_added;
>                 }
>
> --
> 2.45.1
>

