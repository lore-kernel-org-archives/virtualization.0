Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC9D27BF93
	for <virtualization@lists.linux.dev>; Wed,  9 Jul 2025 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050647; cv=none; b=aat3QkZIVh5oLlqIM7FdT63YhG7B3l1/E4h8zBE7p1VoFlv7TZi5SLq0YCtc+Ggrjl9GJ376d/NaOt8VriNY6o85Ijfipd9Vjl/4W/Es2ra8keru/VA3C/tleI8sQDuT4SLbX6mMOI3oIDgh0hEArRFmhswC21k4+2nDepAF7v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050647; c=relaxed/simple;
	bh=bHsjmug2grja7gsO2RB4Ly9zlPTQRyCpVtuLEAc9vgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4aIeAPDj0X6PLc7dhloHNckMGFGeIH9e3FScQv0CyVm4xR0ZTYA7hw53Us8HC5YsFljeffEHRqMMVsuk9wuZRZyiVB6evnedSLXaO7dDRD8/X2ebvWkGokuFB/lbrR6a2FuABPyBKrA4aVPxrZRqAIQM4dsVR8dG2hP3yee4nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QtUsIIt6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtUsIIt6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752050644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4/pa0hMqBRMIIptX2zNZWLrb1Oovg8bbBY/gn6eYOy0=;
	b=QtUsIIt6uLgp+uepZq7KKbjhTrJ0NSnXzWEQZfOr6oE+2oxffFGgEcZX3N/syRkYiOrRHi
	FzSIEbSr6sZT6uUmYUFfLOIc/sZ08/aHMwzWUNZkldbFNe7GitOmCjbDaXRI6F0hXeQu2v
	gIDrXm95kVvEyVdHsNZOzfzas0ZJEcw=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-FRWHs5E2MHOA2_SXb3vpLw-1; Wed, 09 Jul 2025 04:44:03 -0400
X-MC-Unique: FRWHs5E2MHOA2_SXb3vpLw-1
X-Mimecast-MFC-AGG-ID: FRWHs5E2MHOA2_SXb3vpLw_1752050643
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5314d22c2efso5780941e0c.1
        for <virtualization@lists.linux.dev>; Wed, 09 Jul 2025 01:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752050643; x=1752655443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/pa0hMqBRMIIptX2zNZWLrb1Oovg8bbBY/gn6eYOy0=;
        b=QROKeLY92zd9TlAwsGyhCRQJymwQ+S7x0zhKiRP7hz4ynIfzHFuPvJxXewjWuKuSSs
         bSUkw2ks2DppLGzSB7FZfP5mMd0Zv+sLfyRJljxW7XK0IKrhAgl9F7scCetxq6FWrXNj
         5MsSgYKXBWfsRzNuItDBXsc692AF2SgTXcBByjgWDvhgLjumGLcg0E8QS3bF1+Q7MX0T
         rNJNA1cCkMeeW/bOcZ0elcH5y0FzsLWxd2GCPz9l8M1aFEVoUEUk3IVL7O9wrJKeuj+M
         BDLThwZk/oArsMbeUfZxImRfXlORHXSaxxNgYAX0/9inCjOFFDIjm73nUUeLZkgIS3sm
         OAvA==
X-Forwarded-Encrypted: i=1; AJvYcCUiYNxPf80JcCf9rA6vkYYX8Qpy4kusF1QEniGW/vMAxzVuPXHGqkdi/i2FLYM2hGi4WeLMAmxmuD9cMHMsaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPXRXBg/N7iX8pPay4GUCQt4rHsFcPEzKpQ56jc4pLjyk/8XTY
	O2IOAi4vS5QJnuK5PZmtqKJ3YPOYRLyakOJaIVxfHs4Rlo1viPBrgG1ec3OsK9LQPrmjG4+OoMU
	o+KcZ0Q7d5aXaX8oTgyA4vSSWK1ljsTiciAQKv8mcD3dLCQPEacjq4SfjrkhbtCOcFqHGBFY7sr
	vG9UKtbSmMcJfG1EynbP8u3KDPfDIFByI1pCiFWLVYyDw=
X-Gm-Gg: ASbGnctTQ26b8EQYODyuY+4dCLUmcTYHBwRdniDnW35IA3uh65gAsT148iL/vgdoTS4
	+YkOneZdRoFcMQMVlJgYP+VsZqms3U16qcBM5epPOGVxw692PUGLfKcbYGAlfzUYwTs3eCaWMEB
	EMPw==
X-Received: by 2002:a05:6122:4589:b0:52f:4776:f6a7 with SMTP id 71dfb90a1353d-535d71ba489mr629099e0c.0.1752050642657;
        Wed, 09 Jul 2025 01:44:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuGYryrNb2KTUQZ/3oKE/LhSv2IGos3umvvT/pQKeOzeVFsuV6tZF0ROdwhZM9snksHVIlb+NVzDBu43ZG29w=
X-Received: by 2002:a05:6122:4589:b0:52f:4776:f6a7 with SMTP id
 71dfb90a1353d-535d71ba489mr629093e0c.0.1752050642126; Wed, 09 Jul 2025
 01:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250708120424.2363354-2-dtatulea@nvidia.com>
In-Reply-To: <20250708120424.2363354-2-dtatulea@nvidia.com>
From: Wenli Quan <wquan@redhat.com>
Date: Wed, 9 Jul 2025 16:43:50 +0800
X-Gm-Features: Ac12FXw8HPwmkNSHA5tylZwr0bxrn6wh3NKiSpLVr1OfzMxwvnKxTFVXUGHYSyk
Message-ID: <CADZSLS1_cDUGH2_Z20pwdmci+Rd2W6h=7HAWMyqQMCNCT7U3+Q@mail.gmail.com>
Subject: Re: [PATCH vhost] vdpa/mlx5: Fix release of uninitialized resources
 on error path
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lu9QrZZX2lyTMiW3Mbdaz_Ccjdfnwf57DlwDI946A_k_1752050643
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 8:05=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> The commit in the fixes tag made sure that mlx5_vdpa_free()
> is the single entrypoint for removing the vdpa device resources
> added in mlx5_vdpa_dev_add(), even in the cleanup path of
> mlx5_vdpa_dev_add().
>
> This means that all functions from mlx5_vdpa_free() should be able to
> handle uninitialized resources. This was not the case though:
> mlx5_vdpa_destroy_mr_resources() and mlx5_cmd_cleanup_async_ctx()
> were not able to do so. This caused the splat below when adding
> a vdpa device without a MAC address.
>
> This patch fixes these remaining issues:
>
> - Makes mlx5_vdpa_destroy_mr_resources() return early if called on
>   uninitialized resources.
>
> - Moves mlx5_cmd_init_async_ctx() early on during device addition
>   because it can't fail. This means that mlx5_cmd_cleanup_async_ctx()
>   also can't fail. To mirror this, move the call site of
>   mlx5_cmd_cleanup_async_ctx() in mlx5_vdpa_free().
>
> An additional comment was added in mlx5_vdpa_free() to document
> the expectations of functions called from this context.
>
> Splat:
>
>   mlx5_core 0000:b5:03.2: mlx5_vdpa_dev_add:3950:(pid 2306) warning: No m=
ac address provisioned?
>   ------------[ cut here ]------------
>   WARNING: CPU: 13 PID: 2306 at kernel/workqueue.c:4207 __flush_work+0x9a=
/0xb0
>   [...]
>   Call Trace:
>    <TASK>
>    ? __try_to_del_timer_sync+0x61/0x90
>    ? __timer_delete_sync+0x2b/0x40
>    mlx5_vdpa_destroy_mr_resources+0x1c/0x40 [mlx5_vdpa]
>    mlx5_vdpa_free+0x45/0x160 [mlx5_vdpa]
>    vdpa_release_dev+0x1e/0x50 [vdpa]
>    device_release+0x31/0x90
>    kobject_cleanup+0x37/0x130
>    mlx5_vdpa_dev_add+0x327/0x890 [mlx5_vdpa]
>    vdpa_nl_cmd_dev_add_set_doit+0x2c1/0x4d0 [vdpa]
>    genl_family_rcv_msg_doit+0xd8/0x130
>    genl_family_rcv_msg+0x14b/0x220
>    ? __pfx_vdpa_nl_cmd_dev_add_set_doit+0x10/0x10 [vdpa]
>    genl_rcv_msg+0x47/0xa0
>    ? __pfx_genl_rcv_msg+0x10/0x10
>    netlink_rcv_skb+0x53/0x100
>    genl_rcv+0x24/0x40
>    netlink_unicast+0x27b/0x3b0
>    netlink_sendmsg+0x1f7/0x430
>    __sys_sendto+0x1fa/0x210
>    ? ___pte_offset_map+0x17/0x160
>    ? next_uptodate_folio+0x85/0x2b0
>    ? percpu_counter_add_batch+0x51/0x90
>    ? filemap_map_pages+0x515/0x660
>    __x64_sys_sendto+0x20/0x30
>    do_syscall_64+0x7b/0x2c0
>    ? do_read_fault+0x108/0x220
>    ? do_pte_missing+0x14a/0x3e0
>    ? __handle_mm_fault+0x321/0x730
>    ? count_memcg_events+0x13f/0x180
>    ? handle_mm_fault+0x1fb/0x2d0
>    ? do_user_addr_fault+0x20c/0x700
>    ? syscall_exit_work+0x104/0x140
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   RIP: 0033:0x7f0c25b0feca
>   [...]
>   ---[ end trace 0000000000000000 ]---
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Fixes: 83e445e64f48 ("vdpa/mlx5: Fix error path during device add")
> Reported-by: Wenli Quan <wquan@redhat.com>
> Closes: https://lore.kernel.org/virtualization/CADZSLS0r78HhZAStBaN1evCSo=
PqRJU95Lt8AqZNJ6+wwYQ6vPQ@mail.gmail.com/
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

I confirm the bug has been fixed by this commit.

Tested-by: Wenli Quan <wquan@redhat.com>

Thanks

> ---
>  drivers/vdpa/mlx5/core/mr.c       |  3 +++
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 ++++++----
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 61424342c096..c7a20278bc3c 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -908,6 +908,9 @@ void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_=
dev *mvdev)
>  {
>         struct mlx5_vdpa_mr_resources *mres =3D &mvdev->mres;
>
> +       if (!mres->wq_gc)
> +               return;
> +
>         atomic_set(&mres->shutdown, 1);
>
>         flush_delayed_work(&mres->gc_dwork_ent);
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index cccc49a08a1a..571d6502be59 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3432,15 +3432,17 @@ static void mlx5_vdpa_free(struct vdpa_device *vd=
ev)
>
>         ndev =3D to_mlx5_vdpa_ndev(mvdev);
>
> +       /* Functions called here should be able to work with
> +        * uninitialized resources.
> +        */
>         free_fixed_resources(ndev);
>         mlx5_vdpa_clean_mrs(mvdev);
>         mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
> -       mlx5_cmd_cleanup_async_ctx(&mvdev->async_ctx);
> -
>         if (!is_zero_ether_addr(ndev->config.mac)) {
>                 pfmdev =3D pci_get_drvdata(pci_physfn(mvdev->mdev->pdev))=
;
>                 mlx5_mpfs_del_mac(pfmdev, ndev->config.mac);
>         }
> +       mlx5_cmd_cleanup_async_ctx(&mvdev->async_ctx);
>         mlx5_vdpa_free_resources(&ndev->mvdev);
>         free_irqs(ndev);
>         kfree(ndev->event_cbs);
> @@ -3888,6 +3890,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>         mvdev->actual_features =3D
>                         (device_features & BIT_ULL(VIRTIO_F_VERSION_1));
>
> +       mlx5_cmd_init_async_ctx(mdev, &mvdev->async_ctx);
> +
>         ndev->vqs =3D kcalloc(max_vqs, sizeof(*ndev->vqs), GFP_KERNEL);
>         ndev->event_cbs =3D kcalloc(max_vqs + 1, sizeof(*ndev->event_cbs)=
, GFP_KERNEL);
>         if (!ndev->vqs || !ndev->event_cbs) {
> @@ -3960,8 +3964,6 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>                 ndev->rqt_size =3D 1;
>         }
>
> -       mlx5_cmd_init_async_ctx(mdev, &mvdev->async_ctx);
> -
>         ndev->mvdev.mlx_features =3D device_features;
>         mvdev->vdev.dma_dev =3D &mdev->pdev->dev;
>         err =3D mlx5_vdpa_alloc_resources(&ndev->mvdev);
> --
> 2.43.0
>

