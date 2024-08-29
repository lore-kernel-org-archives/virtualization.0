Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6729E1B012A
	for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941132; cv=none; b=kS0Byu+aU2y+GQOhlhZ7W2+1xBj2Qt02N/V0Ps9NofMPO7cp16gZYE//vGEVDCw3imnsaH0gItXjycr6pdHozVfB6qZ6cpMyH0hiSZqzC5SdtIuXMGq4Q5W25l+70S+8dY2lpOd5ZwFZVlQHf9A4RVelXttTE3lQ5XY27YA0Vws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941132; c=relaxed/simple;
	bh=xJNP5vrR8GfpfLwJtjfUAKx5jsEgeVULY0gNeKS3n1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0gOU2ct/DZty28Vsa+vp23mUI3bJsziBKBiH5Z0dYb0UN971vEhRNUINPTLna4EoFUFRPRiu6Qr0HnU5HvU29k9+juexgkFdyoZTrRQT4BCEFXpbX0VA1SPsI2glAQ3zDRVlewhngxSET01HBLLRZQi8zMQnCc2Uo3eMgbsgPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=do0Ottyz; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="do0Ottyz"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00A8760635
	for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 14:18:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KU39I9D8X0PD for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Aug 2024 14:18:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 07BC460630
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 07BC460630
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=do0Ottyz
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 07BC460630
	for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 14:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724941128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYrWURiNhNxaDhZpfvFbKbwERayt+0+/jmKfxf9PB4c=;
	b=do0OttyzsaGaLLGI6NmJwgJcWLNv0eYEDXqoC/JNIkOqqmAFFU5IkxehT/U6VpjclK5tNS
	Ad9xavtwir5hEm7rsBeausmI9KKgwa2+3Vo0Ywo1hsYhliqkusL27nGmpGvzIDh3ButTJZ
	m/VGKgpRwXO/emGNVP+MzEbJp231y+U=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-mSZcVDn1PK2P_bS5gKSPTw-1; Thu, 29 Aug 2024 10:18:44 -0400
X-MC-Unique: mSZcVDn1PK2P_bS5gKSPTw-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6af8f7a30dbso15639887b3.2
        for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 07:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941124; x=1725545924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYrWURiNhNxaDhZpfvFbKbwERayt+0+/jmKfxf9PB4c=;
        b=qCI2gwjOiV8UmpQZJmoBxIg64MDu3FSvV9NgsCuSrLIrZzQlC35MO+UCbqFnlLrgcP
         djCr+ePl0k/9cnhtFTBAT9XZDFZ1cB6KMP1/i0emNjxylO2tc8QXRDYgReY2Dmn3erNB
         Il+20cCikLSxYzavaoP2PL612OeFsnco+10acW+fOzz4hMQV9710hbov6o+V4Xis2IWd
         aXHUaeBvFUTVuS2VXlpccx29582IoogJbXG6I4Jxr3HOtzO4aP07fPvkHDGl86T9qX17
         nJYEsFegXsVuRrL8OE/qlA4hdwK5F9kQeCRCJpGJ3bN1P4EdNiOlFfBIju83pMOqh0Vk
         9ieg==
X-Forwarded-Encrypted: i=1; AJvYcCWxvl2F2lGc2ld+t2iy6vdNNalDqf7bTL0TtFJVkUZSVnFmxkEauhl3u8oRvVuif4S8KkzDYZflfI1ktbw6lg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yyx5DZf4LrAdJZ/wE5jzrKkdJAAVL+qEUY4D2wsfydDOsED6ST+
	n5A6ghWfBZvnVigk5cv5bOTVEI0w+KstdZqvSTRLWciQbHQFTxvXV7IkeETDH87hDiaDQbi4Em+
	cAA327wax8HAlz18mfFw8+ilMgHWgScHq4OmATW2BJVDDxFSyyAXb47jFBP4zzIGlP37CIqHYTs
	cdztO+ZkC8sl59fwzQXoS9Uphl061s9Tw9D/DzbKFQAT2J+K9R3DcDxw==
X-Received: by 2002:a05:6902:260b:b0:e0b:6bb1:fba with SMTP id 3f1490d57ef6-e1a5ac957efmr2795158276.30.1724941124214;
        Thu, 29 Aug 2024 07:18:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpF1PqlLutsjoAOxniJsGr7lS0v1cnWucZnw8FQwcS+ipQsyyw6OmZ1K70s0kquo8STj73Yc8uL2QRZq4gFvo=
X-Received: by 2002:a05:6902:260b:b0:e0b:6bb1:fba with SMTP id
 3f1490d57ef6-e1a5ac957efmr2795125276.30.1724941123845; Thu, 29 Aug 2024
 07:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240821114100.2261167-2-dtatulea@nvidia.com> <20240821114100.2261167-7-dtatulea@nvidia.com>
In-Reply-To: <20240821114100.2261167-7-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 29 Aug 2024 16:18:08 +0200
Message-ID: <CAJaqyWfCeAmx7cZ49PCxwRmCFnS7cXigO294rLG7OtJNaaGqnQ@mail.gmail.com>
Subject: Re: [PATCH vhost 5/7] vdpa/mlx5: Rename mr_mtx -> lock
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
> Now that the mr resources have their own namespace in the
> struct, give the lock a clearer name.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  2 +-
>  drivers/vdpa/mlx5/core/mr.c        | 20 ++++++++++----------
>  drivers/vdpa/mlx5/core/resources.c |  6 +++---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  |  4 ++--
>  4 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/=
mlx5_vdpa.h
> index 5ae6deea2a8a..89b564cecddf 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -87,7 +87,7 @@ struct mlx5_vdpa_mr_resources {
>         struct mlx5_vdpa_mr *mr[MLX5_VDPA_NUM_AS];
>         unsigned int group2asid[MLX5_VDPA_NUMVQ_GROUPS];
>         struct list_head mr_list_head;
> -       struct mutex mr_mtx;
> +       struct mutex lock;
>  };
>
>  struct mlx5_vdpa_dev {
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 2c8660e5c0de..f20f2a8a701d 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -666,9 +666,9 @@ static void _mlx5_vdpa_put_mr(struct mlx5_vdpa_dev *m=
vdev,
>  void mlx5_vdpa_put_mr(struct mlx5_vdpa_dev *mvdev,
>                       struct mlx5_vdpa_mr *mr)
>  {
> -       mutex_lock(&mvdev->mres.mr_mtx);
> +       mutex_lock(&mvdev->mres.lock);
>         _mlx5_vdpa_put_mr(mvdev, mr);
> -       mutex_unlock(&mvdev->mres.mr_mtx);
> +       mutex_unlock(&mvdev->mres.lock);
>  }
>
>  static void _mlx5_vdpa_get_mr(struct mlx5_vdpa_dev *mvdev,
> @@ -683,9 +683,9 @@ static void _mlx5_vdpa_get_mr(struct mlx5_vdpa_dev *m=
vdev,
>  void mlx5_vdpa_get_mr(struct mlx5_vdpa_dev *mvdev,
>                       struct mlx5_vdpa_mr *mr)
>  {
> -       mutex_lock(&mvdev->mres.mr_mtx);
> +       mutex_lock(&mvdev->mres.lock);
>         _mlx5_vdpa_get_mr(mvdev, mr);
> -       mutex_unlock(&mvdev->mres.mr_mtx);
> +       mutex_unlock(&mvdev->mres.lock);
>  }
>
>  void mlx5_vdpa_update_mr(struct mlx5_vdpa_dev *mvdev,
> @@ -694,19 +694,19 @@ void mlx5_vdpa_update_mr(struct mlx5_vdpa_dev *mvde=
v,
>  {
>         struct mlx5_vdpa_mr *old_mr =3D mvdev->mres.mr[asid];
>
> -       mutex_lock(&mvdev->mres.mr_mtx);
> +       mutex_lock(&mvdev->mres.lock);
>
>         _mlx5_vdpa_put_mr(mvdev, old_mr);
>         mvdev->mres.mr[asid] =3D new_mr;
>
> -       mutex_unlock(&mvdev->mres.mr_mtx);
> +       mutex_unlock(&mvdev->mres.lock);
>  }
>
>  static void mlx5_vdpa_show_mr_leaks(struct mlx5_vdpa_dev *mvdev)
>  {
>         struct mlx5_vdpa_mr *mr;
>
> -       mutex_lock(&mvdev->mres.mr_mtx);
> +       mutex_lock(&mvdev->mres.lock);
>
>         list_for_each_entry(mr, &mvdev->mres.mr_list_head, mr_list) {
>
> @@ -715,7 +715,7 @@ static void mlx5_vdpa_show_mr_leaks(struct mlx5_vdpa_=
dev *mvdev)
>                                        mr, mr->mkey, refcount_read(&mr->r=
efcount));
>         }
>
> -       mutex_unlock(&mvdev->mres.mr_mtx);
> +       mutex_unlock(&mvdev->mres.lock);
>
>  }
>
> @@ -779,9 +779,9 @@ struct mlx5_vdpa_mr *mlx5_vdpa_create_mr(struct mlx5_=
vdpa_dev *mvdev,
>         if (!mr)
>                 return ERR_PTR(-ENOMEM);
>
> -       mutex_lock(&mvdev->mres.mr_mtx);
> +       mutex_lock(&mvdev->mres.lock);
>         err =3D _mlx5_vdpa_create_mr(mvdev, mr, iotlb);
> -       mutex_unlock(&mvdev->mres.mr_mtx);
> +       mutex_unlock(&mvdev->mres.lock);
>
>         if (err)
>                 goto out_err;
> diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/=
resources.c
> index 3e3b3049cb08..fe2ca3458f6c 100644
> --- a/drivers/vdpa/mlx5/core/resources.c
> +++ b/drivers/vdpa/mlx5/core/resources.c
> @@ -256,7 +256,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *m=
vdev)
>                 mlx5_vdpa_warn(mvdev, "resources already allocated\n");
>                 return -EINVAL;
>         }
> -       mutex_init(&mvdev->mres.mr_mtx);
> +       mutex_init(&mvdev->mres.lock);
>         res->uar =3D mlx5_get_uars_page(mdev);
>         if (IS_ERR(res->uar)) {
>                 err =3D PTR_ERR(res->uar);
> @@ -301,7 +301,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *m=
vdev)
>  err_uctx:
>         mlx5_put_uars_page(mdev, res->uar);
>  err_uars:
> -       mutex_destroy(&mvdev->mres.mr_mtx);
> +       mutex_destroy(&mvdev->mres.lock);
>         return err;
>  }
>
> @@ -318,7 +318,7 @@ void mlx5_vdpa_free_resources(struct mlx5_vdpa_dev *m=
vdev)
>         dealloc_pd(mvdev, res->pdn, res->uid);
>         destroy_uctx(mvdev, res->uid);
>         mlx5_put_uars_page(mvdev->mdev, res->uar);
> -       mutex_destroy(&mvdev->mres.mr_mtx);
> +       mutex_destroy(&mvdev->mres.lock);
>         res->valid =3D false;
>  }
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 3e55a7f1afcd..8a51c492a62a 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3639,10 +3639,10 @@ static int mlx5_set_group_asid(struct vdpa_device=
 *vdev, u32 group,
>
>         mvdev->mres.group2asid[group] =3D asid;
>
> -       mutex_lock(&mvdev->mres.mr_mtx);
> +       mutex_lock(&mvdev->mres.lock);
>         if (group =3D=3D MLX5_VDPA_CVQ_GROUP && mvdev->mres.mr[asid])
>                 err =3D mlx5_vdpa_update_cvq_iotlb(mvdev, mvdev->mres.mr[=
asid]->iotlb, asid);
> -       mutex_unlock(&mvdev->mres.mr_mtx);
> +       mutex_unlock(&mvdev->mres.lock);
>
>         return err;
>  }
> --
> 2.45.1
>

