Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027201AED49
	for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944117; cv=none; b=qCex/8CPQnpFSEUYNZYfuVCLW4diN2DcfIbvO3lYTbJP4dAPH9kms1DWtIc/bUq08o05sPil6bQtdmQguSR6tTf/EjYu/U7fvPia38bwpSXVsGrFYMDkgr0ht4hVfhpZe2oN6YY9Zr+CdM2kLLpWI0DiJgBvvOH/kU6fkijfBBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944117; c=relaxed/simple;
	bh=frp7UiZ9uA3qdMJCGGtG1pTt+xvfCPNxmXXBHBILYCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVtLeQayKw6pItZBp0/CttAC7eaOUJUULH+yDbJkltwsgxs1+xwj5r5nJ00AtFjunCtVVKdmkZwh0EDq7eWAzkvu5he6jWyhkRJdyfiNTEybb10pPxiAOWOkQXDxGY2JGjcPUsumVZrtLEDkXQQ+R7+DFkqbRhr7tBcJKGw8/FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CN1x9eOz; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CN1x9eOz"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A41C9401CE
	for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 15:08:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z8iMnwOXgT0p for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Aug 2024 15:08:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4C1F04050C
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C1F04050C
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CN1x9eOz
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4C1F04050C
	for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 15:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724944112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z6Yzp/6LFU+uaePv6a7iTxSs5DZS0Gfztb2UUYJbc4s=;
	b=CN1x9eOz6qj3zgVwi2KfvMdVFnpr62VFptEbVDey/jOEjgEo5meC1bSmcMiTDcW913As5I
	4XXFjj8D7+ifG8JPiE3hul5zs5nNSkXEBCJhngmnWlBP48K2kmTv3FjhJvobs9VrINZsoS
	UXaV+8PJVtgXFa6+o2vMWhmKEcYMjJY=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-z-qg78LDPIqwLTnECNrDzw-1; Thu, 29 Aug 2024 11:08:31 -0400
X-MC-Unique: z-qg78LDPIqwLTnECNrDzw-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e0b8fa94718so1293084276.0
        for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 08:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724944111; x=1725548911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6Yzp/6LFU+uaePv6a7iTxSs5DZS0Gfztb2UUYJbc4s=;
        b=bC311i9Q0hiCIYnQanc/8OawahCWkpWIKILIB3AFgPLCBXPfkmfo7nP5BG7exX0Mtk
         LhEnHUQwzfIZtYMmB4qH6jwosUK29gNZi0iBt7EifkvasB0hD70b/7XQ0dpMHznj5zX9
         O7xAicA/dJCJrMvM2aY6AWrDYnN++RUPpE+Pl4pnOjLRmp/MzI2AjRZcwtRmc+YMulIH
         76O1HJr/Lg+0dCGL5MlZUtb8YYDn9mRmSUXSb4EjtTRTN0t5EPUtbjmSo0HzD87oPc+L
         mMBZkW529mIchpzeYZtPq9/VxU2MAC6LZep5X2On6BY0DPJtdMPoKDocLNbaSXoyKttM
         Zwww==
X-Forwarded-Encrypted: i=1; AJvYcCUoGtTViUkORRKRcZGc8hVVdOQige73n34dTjvj27i4Kps0wrnud6TZO509HDXHJfV657nHG+2fUsJh54oD0A==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx4eJ+4Y5nFw5MGTBCtn7Yejh/Jk1OhXjn4l6EqVwngqxMUY/pj
	10PIv6R4hODE/lFgb7ROyG4MwpSHLCjoq2tHa6EoTmmZTR3a/kVY5V7FlxhoY2e+7TgeXsNQ0C9
	cyqnrqve8UFjOPpYx7XUneuhvuiWV4SrFBkwWhnStYLD+dQ+f3ZL289NFUF41vILPzz4fnTo4fi
	W9ePyysl35nClzsvBhv5AfOAZhUaQ3kK3RjjxrWisMNhVzwG+aQEGduA==
X-Received: by 2002:a05:6902:158d:b0:e11:5f3c:1324 with SMTP id 3f1490d57ef6-e1a5af374aamr3084072276.57.1724944111030;
        Thu, 29 Aug 2024 08:08:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERKkALAGk22ztFkcfNvM3ojpK7Wn916DypmZXhvgDXtua3Vleb/v7Hf7cbJA74slinumaT5/x4A58ca+anPXI=
X-Received: by 2002:a05:6902:158d:b0:e11:5f3c:1324 with SMTP id
 3f1490d57ef6-e1a5af374aamr3084036276.57.1724944110532; Thu, 29 Aug 2024
 08:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240821114100.2261167-2-dtatulea@nvidia.com> <20240821114100.2261167-9-dtatulea@nvidia.com>
In-Reply-To: <20240821114100.2261167-9-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 29 Aug 2024 17:07:54 +0200
Message-ID: <CAJaqyWfANjzrKk9J=hJrdv6c8xd5Xx81XyigPBvc--AxQQK_gg@mail.gmail.com>
Subject: Re: [PATCH vhost 7/7] vdpa/mlx5: Postpone MR deletion
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
> Currently, when a new MR is set up, the old MR is deleted. MR deletion
> is about 30-40% the time of MR creation. As deleting the old MR is not
> important for the process of setting up the new MR, this operation
> can be postponed.
>
> This series adds a workqueue that does MR garbage collection at a later
> point. If the MR lock is taken, the handler will back off and
> reschedule. The exception during shutdown: then the handler must
> not postpone the work.
>
> Note that this is only a speculative optimization: if there is some
> mapping operation that is triggered while the garbage collector handler
> has the lock taken, this operation it will have to wait for the handler
> to finish.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h | 10 ++++++
>  drivers/vdpa/mlx5/core/mr.c        | 51 ++++++++++++++++++++++++++++--
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  |  3 +-
>  3 files changed, 60 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/=
mlx5_vdpa.h
> index c3e17bc888e8..2cedf7e2dbc4 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -86,8 +86,18 @@ enum {
>  struct mlx5_vdpa_mr_resources {
>         struct mlx5_vdpa_mr *mr[MLX5_VDPA_NUM_AS];
>         unsigned int group2asid[MLX5_VDPA_NUMVQ_GROUPS];
> +
> +       /* Pre-deletion mr list */
>         struct list_head mr_list_head;
> +
> +       /* Deferred mr list */
> +       struct list_head mr_gc_list_head;
> +       struct workqueue_struct *wq_gc;
> +       struct delayed_work gc_dwork_ent;
> +
>         struct mutex lock;
> +
> +       atomic_t shutdown;
>  };
>
>  struct mlx5_vdpa_dev {
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index ec75f165f832..43fce6b39cf2 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -653,14 +653,46 @@ static void _mlx5_vdpa_destroy_mr(struct mlx5_vdpa_=
dev *mvdev, struct mlx5_vdpa_
>         kfree(mr);
>  }
>
> +#define MLX5_VDPA_MR_GC_TRIGGER_MS 2000
> +
> +static void mlx5_vdpa_mr_gc_handler(struct work_struct *work)
> +{
> +       struct mlx5_vdpa_mr_resources *mres;
> +       struct mlx5_vdpa_mr *mr, *tmp;
> +       struct mlx5_vdpa_dev *mvdev;
> +
> +       mres =3D container_of(work, struct mlx5_vdpa_mr_resources, gc_dwo=
rk_ent.work);
> +
> +       if (atomic_read(&mres->shutdown)) {
> +               mutex_lock(&mres->lock);
> +       } else if (!mutex_trylock(&mres->lock)) {

Is the trylock worth it? My understanding is that mutex_lock will add
the kthread to the waitqueue anyway if it is not able to acquire the
lock.

> +               queue_delayed_work(mres->wq_gc, &mres->gc_dwork_ent,
> +                                  msecs_to_jiffies(MLX5_VDPA_MR_GC_TRIGG=
ER_MS));
> +               return;
> +       }
> +
> +       mvdev =3D container_of(mres, struct mlx5_vdpa_dev, mres);
> +
> +       list_for_each_entry_safe(mr, tmp, &mres->mr_gc_list_head, mr_list=
) {
> +               _mlx5_vdpa_destroy_mr(mvdev, mr);
> +       }
> +
> +       mutex_unlock(&mres->lock);
> +}
> +
>  static void _mlx5_vdpa_put_mr(struct mlx5_vdpa_dev *mvdev,
>                               struct mlx5_vdpa_mr *mr)
>  {
> +       struct mlx5_vdpa_mr_resources *mres =3D &mvdev->mres;
> +
>         if (!mr)
>                 return;
>
> -       if (refcount_dec_and_test(&mr->refcount))
> -               _mlx5_vdpa_destroy_mr(mvdev, mr);
> +       if (refcount_dec_and_test(&mr->refcount)) {
> +               list_move_tail(&mr->mr_list, &mres->mr_gc_list_head);
> +               queue_delayed_work(mres->wq_gc, &mres->gc_dwork_ent,
> +                                  msecs_to_jiffies(MLX5_VDPA_MR_GC_TRIGG=
ER_MS));

Why the delay?

> +       }
>  }
>
>  void mlx5_vdpa_put_mr(struct mlx5_vdpa_dev *mvdev,
> @@ -848,9 +880,17 @@ int mlx5_vdpa_init_mr_resources(struct mlx5_vdpa_dev=
 *mvdev)
>  {
>         struct mlx5_vdpa_mr_resources *mres =3D &mvdev->mres;
>
> -       INIT_LIST_HEAD(&mres->mr_list_head);
> +       mres->wq_gc =3D create_singlethread_workqueue("mlx5_vdpa_mr_gc");
> +       if (!mres->wq_gc)
> +               return -ENOMEM;
> +
> +       INIT_DELAYED_WORK(&mres->gc_dwork_ent, mlx5_vdpa_mr_gc_handler);
> +
>         mutex_init(&mres->lock);
>
> +       INIT_LIST_HEAD(&mres->mr_list_head);
> +       INIT_LIST_HEAD(&mres->mr_gc_list_head);
> +
>         return 0;
>  }
>
> @@ -858,5 +898,10 @@ void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa=
_dev *mvdev)
>  {
>         struct mlx5_vdpa_mr_resources *mres =3D &mvdev->mres;
>
> +       atomic_set(&mres->shutdown, 1);
> +
> +       flush_delayed_work(&mres->gc_dwork_ent);
> +       destroy_workqueue(mres->wq_gc);
> +       mres->wq_gc =3D NULL;
>         mutex_destroy(&mres->lock);
>  }
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 1cadcb05a5c7..ee9482ef51e6 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3435,6 +3435,8 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev=
)
>         free_fixed_resources(ndev);
>         mlx5_vdpa_clean_mrs(mvdev);
>         mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
> +       mlx5_cmd_cleanup_async_ctx(&mvdev->async_ctx);
> +
>         if (!is_zero_ether_addr(ndev->config.mac)) {
>                 pfmdev =3D pci_get_drvdata(pci_physfn(mvdev->mdev->pdev))=
;
>                 mlx5_mpfs_del_mac(pfmdev, ndev->config.mac);
> @@ -4044,7 +4046,6 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev =
*v_mdev, struct vdpa_device *
>         destroy_workqueue(wq);
>         mgtdev->ndev =3D NULL;
>

Extra newline here.

> -       mlx5_cmd_cleanup_async_ctx(&mvdev->async_ctx);
>  }
>
>  static const struct vdpa_mgmtdev_ops mdev_ops =3D {
> --
> 2.45.1
>

