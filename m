Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AD62040BC
	for <virtualization@lists.linux.dev>; Wed,  6 Nov 2024 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906989; cv=none; b=Rgp9FRJNFi73TLs+SAdKBwA2rr8x+cFw7dnub2xKUR01uhki87GAknW7lz7nEn/20gYUH8eL8vwD8n2cYoK1AqzL+DeVEgNxMnEeZ9HattqP21/MO22g291GYc1RjyI2ih52nzMqvLe45vGunmNr8eV2cCiJwEVtXE/vgryGwvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906989; c=relaxed/simple;
	bh=slDITeVaZJdLWTmohyTCR5uLP4r1HBqbMUAWjzsYL20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8NuQPobJJQ/gBqhVadItJPr/qeC5sTMpzAYkFELfEZ1t5+Dp/Z2XgVk9OHlPypkmT67XB45YCpIPOWLHhNtpaW2gsPn0ThG26Fdo+WYU9/Bppi2/8hkdEjUJv3QGXp346FyTl0qpOtHMKJiUDeDPi2q4h9tI1/0JiHAWSIlkQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NwXuqDyI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwXuqDyI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730906986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOPbnWiJRNPBK8Iuorno9W+gLQNQbKU697K4rUrZaZA=;
	b=NwXuqDyIlWRs+N/YRuYh5GsjDeLcovHWeWn2W7THuO+z3BP8AMFioekN+33ry/sfzlIPkV
	k7LzBJMp+EcgUyucDElnrCw7jdz/I2rtm/odqEBYwUOMh/9+QLfae23RGLXoYquYWfnc3j
	O9w++R+s26dfd5sC/kvG7769h2EkL4M=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-Jd7L38FnNs6O31V6PRlACw-1; Wed, 06 Nov 2024 10:29:45 -0500
X-MC-Unique: Jd7L38FnNs6O31V6PRlACw-1
X-Mimecast-MFC-AGG-ID: Jd7L38FnNs6O31V6PRlACw
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6ea258fe4b6so137166037b3.1
        for <virtualization@lists.linux.dev>; Wed, 06 Nov 2024 07:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730906985; x=1731511785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOPbnWiJRNPBK8Iuorno9W+gLQNQbKU697K4rUrZaZA=;
        b=F7K0iidmPop/fz6oBAHZJfMFaZOyEb4pmKuEvDlUmAHf+OlgEiij0NSbMFjPLD6kNq
         C49rwBPRM0l9j0Z3lOvjRCk+e75VUQFmGyIeqQfdCj08Vjd7lPiqOHOtvtXGYrHs229C
         vr6dyWvzjCzpwD8Fgu6XdEXBZQa5DrmZB3AG1HLjxzMChZkoct1jr8Qhx54S9+iq0hl0
         O3fbwg4MuBQB7rgj9jh1VvVuXI4FeY8qVbcPBbyqgkPr2PfGLgxeHNwjTtopkAxcZa7e
         QqmIj0BC5/QMgi34Ow5YN8hYl30kBCyHu8MiJorbOROeX1kiqtC0uZJxZQHfSXPZ14g/
         ZSqg==
X-Forwarded-Encrypted: i=1; AJvYcCX0fu1MNB+S9hFpI5ZRkNeFQmVQBTmur4iBSL8klhKRuuGaYy/xF0EppJV11SPxJEQND+Hk9/eIJ+s+8906uw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQc8kaZ6WO8ryCyZ1qSqSrO57NYxltEOoN8mdb9NG0fK/+9GmC
	c4ZTwbtMTQJqSHnMGo/ozGoVfgunZnDUQpcC1U0prbWFremedNdAr+3H97me+EVexnWETjjcMOx
	Co+pTXjeh1N7MbUXWMstItNlB1n+GwPt2mWnK+MWZA1FxJKg1QdT/34Q16QvTdiNjy0uD1yZ6ZB
	aeoUf9lpYg7RXFalBYQDvAIkbEvgqfOAmAC9SPIpo=
X-Received: by 2002:a05:690c:3709:b0:6de:2ae:811f with SMTP id 00721157ae682-6ea64bf4929mr214868897b3.35.1730906984673;
        Wed, 06 Nov 2024 07:29:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9nPBTHJqeZMQrOB+AjpFwft6nmjDkLsM/1siwtBJuUveAw1rOQNtWk+iPD8sPue9NKKJFYwcetid08rljtMM=
X-Received: by 2002:a05:690c:3709:b0:6de:2ae:811f with SMTP id
 00721157ae682-6ea64bf4929mr214868357b3.35.1730906984105; Wed, 06 Nov 2024
 07:29:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241105185101.1323272-2-dtatulea@nvidia.com>
In-Reply-To: <20241105185101.1323272-2-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 6 Nov 2024 16:29:08 +0100
Message-ID: <CAJaqyWeCNfq=M1JSaBjVQLq8_zTpZyMJk0_CWLXVo7v_DGRQFw@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix error path during device add
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, virtualization@lists.linux.dev, 
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G5srpI7eN0NrPA7WwBv0GwXesszedCkr7onTKqm2Iyc_1730906985
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 7:52=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> In the error recovery path of mlx5_vdpa_dev_add(), the cleanup is
> executed and at the end put_device() is called which ends up calling
> mlx5_vdpa_free(). This function will execute the same cleanup all over
> again. Most resources support being cleaned up twice, but the recent
> mlx5_vdpa_destroy_mr_resources() doesn't.
>
> This change drops the explicit cleanup from within the
> mlx5_vdpa_dev_add() and lets mlx5_vdpa_free() do its work.
>
> This issue was discovered while trying to add 2 vdpa devices with the
> same name:
> $> vdpa dev add name vdpa-0 mgmtdev auxiliary/mlx5_core.sf.2
> $> vdpa dev add name vdpa-0 mgmtdev auxiliary/mlx5_core.sf.3
>
> ... yields the following dump:
>
>   BUG: kernel NULL pointer dereference, address: 00000000000000b8
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: Oops: 0000 [#1] SMP
>   CPU: 4 UID: 0 PID: 2811 Comm: vdpa Not tainted 6.12.0-rc6 #1
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-g=
f21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>   RIP: 0010:destroy_workqueue+0xe/0x2a0
>   Code: ...
>   RSP: 0018:ffff88814920b9a8 EFLAGS: 00010282
>   RAX: 0000000000000000 RBX: ffff888105c10000 RCX: 0000000000000000
>   RDX: 0000000000000001 RSI: ffff888100400168 RDI: 0000000000000000
>   RBP: 0000000000000000 R08: ffff888100120c00 R09: ffffffff828578c0
>   R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>   R13: ffff888131fd99a0 R14: 0000000000000000 R15: ffff888105c10580
>   FS:  00007fdfa6b4f740(0000) GS:ffff88852ca00000(0000) knlGS:00000000000=
00000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00000000000000b8 CR3: 000000018db09006 CR4: 0000000000372eb0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   Call Trace:
>    <TASK>
>    ? __die+0x20/0x60
>    ? page_fault_oops+0x150/0x3e0
>    ? exc_page_fault+0x74/0x130
>    ? asm_exc_page_fault+0x22/0x30
>    ? destroy_workqueue+0xe/0x2a0
>    mlx5_vdpa_destroy_mr_resources+0x2b/0x40 [mlx5_vdpa]
>    mlx5_vdpa_free+0x45/0x150 [mlx5_vdpa]
>    vdpa_release_dev+0x1e/0x50 [vdpa]
>    device_release+0x31/0x90
>    kobject_put+0x8d/0x230
>    mlx5_vdpa_dev_add+0x328/0x8b0 [mlx5_vdpa]
>    vdpa_nl_cmd_dev_add_set_doit+0x2b8/0x4c0 [vdpa]
>    genl_family_rcv_msg_doit+0xd0/0x120
>    genl_rcv_msg+0x180/0x2b0
>    ? __vdpa_alloc_device+0x1b0/0x1b0 [vdpa]
>    ? genl_family_rcv_msg_dumpit+0xf0/0xf0
>    netlink_rcv_skb+0x54/0x100
>    genl_rcv+0x24/0x40
>    netlink_unicast+0x1fc/0x2d0
>    netlink_sendmsg+0x1e4/0x410
>    __sock_sendmsg+0x38/0x60
>    ? sockfd_lookup_light+0x12/0x60
>    __sys_sendto+0x105/0x160
>    ? __count_memcg_events+0x53/0xe0
>    ? handle_mm_fault+0x100/0x220
>    ? do_user_addr_fault+0x40d/0x620
>    __x64_sys_sendto+0x20/0x30
>    do_syscall_64+0x4c/0x100
>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
>   RIP: 0033:0x7fdfa6c66b57
>   Code: ...
>   RSP: 002b:00007ffeace22998 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
>   RAX: ffffffffffffffda RBX: 000055a498608350 RCX: 00007fdfa6c66b57
>   RDX: 000000000000006c RSI: 000055a498608350 RDI: 0000000000000003
>   RBP: 00007ffeace229c0 R08: 00007fdfa6d35200 R09: 000000000000000c
>   R10: 0000000000000000 R11: 0000000000000202 R12: 000055a4986082a0
>   R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffeace233f3
>    </TASK>
>   Modules linked in: ...
>   CR2: 00000000000000b8
>
> Fixes: 62111654481d ("vdpa/mlx5: Postpone MR deletion")

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index dee019977716..5f581e71e201 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3963,28 +3963,28 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev=
 *v_mdev, const char *name,
>         mvdev->vdev.dma_dev =3D &mdev->pdev->dev;
>         err =3D mlx5_vdpa_alloc_resources(&ndev->mvdev);
>         if (err)
> -               goto err_mpfs;
> +               goto err_alloc;
>
>         err =3D mlx5_vdpa_init_mr_resources(mvdev);
>         if (err)
> -               goto err_res;
> +               goto err_alloc;
>
>         if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
>                 err =3D mlx5_vdpa_create_dma_mr(mvdev);
>                 if (err)
> -                       goto err_mr_res;
> +                       goto err_alloc;
>         }
>
>         err =3D alloc_fixed_resources(ndev);
>         if (err)
> -               goto err_mr;
> +               goto err_alloc;
>
>         ndev->cvq_ent.mvdev =3D mvdev;
>         INIT_WORK(&ndev->cvq_ent.work, mlx5_cvq_kick_handler);
>         mvdev->wq =3D create_singlethread_workqueue("mlx5_vdpa_wq");
>         if (!mvdev->wq) {
>                 err =3D -ENOMEM;
> -               goto err_res2;
> +               goto err_alloc;
>         }
>
>         mvdev->vdev.mdev =3D &mgtdev->mgtdev;
> @@ -4010,17 +4010,6 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev =
*v_mdev, const char *name,
>         _vdpa_unregister_device(&mvdev->vdev);
>  err_reg:
>         destroy_workqueue(mvdev->wq);
> -err_res2:
> -       free_fixed_resources(ndev);
> -err_mr:
> -       mlx5_vdpa_clean_mrs(mvdev);
> -err_mr_res:
> -       mlx5_vdpa_destroy_mr_resources(mvdev);
> -err_res:
> -       mlx5_vdpa_free_resources(&ndev->mvdev);
> -err_mpfs:
> -       if (!is_zero_ether_addr(config->mac))
> -               mlx5_mpfs_del_mac(pfmdev, config->mac);
>  err_alloc:
>         put_device(&mvdev->vdev.dev);
>         return err;
> --
> 2.47.0
>

