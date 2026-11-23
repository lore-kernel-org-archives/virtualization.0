Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448905;
	b=LnWHkZFCtMJwOE1Ke275NnpbUoLSa+ylNa1uus75jOUr6U7nwfDX5mJ0JYzB5cdS5AAU
	 8Rd9su+eLbJreMXGNAGfV25teIgwjo2sRLHVez82Q84jcGGnm5qSUjJ3taWKTzSjhaKda
	 ahIhqs8BVYSrtXohsyLQW8nyU/WFcIgbLSDk/62qKgy6d4/oiCORN18+TObqPITLGf807
	 9vHNHlnm5MfjDs8BSHg3XHOmW6ComYcir8pf/OO/8+2VnscQDDQyEPI3qdD9B3227pIUr
	 7/kGTGKjE60k41V85papnHDCF8sR6B0LNGi7sw5I/W1TbCno/jQtz400EKsHBB3gQ+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448905;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=OWmsxzAWhp8YogqWe/sWTbGuQ3w1HS7FA6g8w4z3/dM=;
	b=5j0RePrftxyA2pRjPfb56pbTPXYp8ONMsdSI+e0Q+fDrov9qCxefeWDcA4QXfnyqhjHh
	 vrjOxOaijOiN1JdglalE37EO8rqO+oX+tOA7D+ag0qCMjUyiLbuhFKxVgIB+qZXJlkalr
	 +2VOD/728QKTVp3crN6aQRyQvFKhTKaijX2I4QWqlzlxvnTgngnPW1WTp2G9klCEnwaJ/
	 AKhEoOm1vfSJqv4STmqV0WVcihtIeP0lxXQe5yHfq4S2DuWpeksbnpBaSpTZb1iEMumpX
	 K7PauJXT+7oQSfrK4y/z03YCjjw7QjiukW+TZC6Ky0jovoBo4yYvjxfzxe3q9Y2nDNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Nrn0J+p/";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0DC606A31A
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 15:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE0DC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nrn0J+p/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795448903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWmsxzAWhp8YogqWe/sWTbGuQ3w1HS7FA6g8w4z3/dM=;
	b=Nrn0J+p/jfkAywJiyj7fcf9yaNNXT8M8Oip2GKDlIM09y/jh8iHcHlb/AHf+WvVy+bhRNk
	eybeS2p+2tm3SnP5++yIbA4TFsPjJyLH+HutO/fRiSOeHkokdZsbih1IXg6974RzIzgrus
	fbGrxjx2Wv9yef2OVNtrnLNjVq4gcdo=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-ocV_DcxGOCe7pzxvAVTPxg-1; Mon, 23 Nov 2026 15:48:22 +0000
X-MC-Unique: ocV_DcxGOCe7pzxvAVTPxg-1
X-Mimecast-MFC-AGG-ID: ocV_DcxGOCe7pzxvAVTPxg_1795448901
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-679f81d5d7bso5787336d50.2
        for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 07:48:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795448901; x=1796053701;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OWmsxzAWhp8YogqWe/sWTbGuQ3w1HS7FA6g8w4z3/dM=;
        b=ToKDU6EuVy8h6mpnrbJBBDp5RyIT81kNcgDnEwtaLwIXpU235J20Y1LUZk94KnhDjF
         nZpGYvSs7cggXzJkM90okZE9miUVTrCkRL1XGHYzXoxxTZkqTcVIcCP4CJHnORyPCOUd
         qXTXZJE0fUsEvBC8MnFKlvddz8HepVSwcgFZlBEVZuBBychtvPgOJzsj7MgVXX0tlm2i
         mARUE92TdaQO8onHn/v+50clwFuXSrleUEmHcGQIzKowhhWbE+t1WdiIcR1AmyiRAoms
         rBn9SWKt90zmokTw8pHGGNn02LtYCccSFMDmiqJqwy57CsZEuWY0yj+7KthJXlV3IrbV
         f9QQ==
X-Forwarded-Encrypted: i=1; AL+hErHqV1vLaICsOKk3ozuo2w/QAnALci9xu8I6TRL6AbQAYwWHcOTpXmF36YVcsbxoYOgd39q3wl5jcSI5PxqQBA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8ottR2E8/4oR2eY38OkbmJLcIIwrEm79yWfiEgNrhsboFIyFUO
	5gqBswbEZYFcEeRGIFh83hCNa04RneWn9FHP/JQNaoUa3MMiddpWZ7mActDEObmhXGJ345oqBDE
	qMNJKzsrfo0/gdVZ8oEPudxJNqHvKB/033FGLZ8TgAEQqwcRAUS4LEMJUqaX2fuD2QkSF7P1EoY
	o8AwN3HmLDfW/yn0hDhC8GX2Z94sw5IRnbYgI7eKPI6JU=
X-Gm-Gg: AZFdTZdbKHjAv+1KWlA25Jm4EXz0g1l8JpzKPpbv8dCEfrCpksCOrvA/tyGAxOD0vqZ
	57ZI1uBYs4XJ/pTrS1w97gzcuhra0s0p7LZKMOHiiSR3Ub4St+ugpOumCNu2zUBGcnQY5Q7GFUP
	CRuv5pQKesQ2JCcwej0X1Ro1cjgLR2H3ltOJu9GtvfqYI4HON8lwYrMk/WYJlhzTJBibUH3xWuT
	wdKkgi51cxwi9vpnYCfEyIvCYnaz5zJihOcD2CI+5I5ns4B7Keh0uXHZCI=
X-Received: by 2002:a05:690e:150e:b0:677:b670:bc2 with SMTP id 956f58d0204a3-67df4497b11mr3158234d50.131.1795448901306;
        Mon, 23 Nov 2026 07:48:21 -0800 (PST)
X-Received: by 2002:a05:690e:150e:b0:677:b670:bc2 with SMTP id
 956f58d0204a3-67df4497b11mr3158224d50.131.1795448900838; Mon, 23 Nov 2026
 07:48:20 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261123135646.3962652-2-dtatulea@nvidia.com> <20261123135646.3962652-5-dtatulea@nvidia.com>
In-Reply-To: <20261123135646.3962652-5-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 23 Nov 2026 16:47:44 +0100
X-Gm-Features: Aa3M54o4ueCnunOOjRD8BYS6eetZBocpj0aR00-pSGaCcCscH__3XBFasy8mITE
Message-ID: <CAJaqyWeVfFBohQ+x1_MCmNCt0FgvepgKV+H_u4GqR+GLCqf6Mw@mail.gmail.com>
Subject: Re: [PATCH 3/3] vdpa/mlx5: Don't flush the workqueue under reslock
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vlee364glqzleyk7CGxVyVNO8g9rgWtn0gIsIjCJ2y0_1795448901
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 3:00=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> The control VQ work (mlx5_cvq_kick_handler()) runs on mvdev->wq and
> takes reslock. Device reset and the error path of .set_status take
> reslock and then call unregister_link_notifier() which flushes the same
> workqueue. A deadlock occurs if a CVQ kick arrives just before the reset
> for the CVQ work.
>
> Lockdep caught this when QEMU quits (pkill qemu) and closes the
> vhost-vdpa device:
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>  WARNING: possible circular locking dependency detected
>  ------------------------------------------------------
>  qemu-system-x86/5785 is trying to acquire lock:
>  ff110001cd292940 ((wq_completion)mlx5_vdpa_wq){+.+.}-{0:0}, at: touch_wq=
_lockdep_map+0x7a/0x180
>
>  but task is already holding lock:
>  ff11000136eb4928 (&ndev->reslock){+.+.}-{4:4}, at: mlx5_vdpa_compat_rese=
t+0xed/0x760 [mlx5_vdpa]
>
>  which lock already depends on the new lock.
>
>  the existing dependency chain (in reverse order) is:
>
>  -> #2 (&ndev->reslock){+.+.}-{4:4}:
>         lock_acquire+0x126/0x330
>         down_write+0x87/0x1d0
>         mlx5_cvq_kick_handler+0xb1/0x1180 [mlx5_vdpa]
>         process_one_work+0x8df/0x1660
>         worker_thread+0x62c/0x1030
>         kthread+0x377/0x490
>         ret_from_fork+0x4d7/0x720
>         ret_from_fork_asm+0x11/0x20
>
>  -> #1 ((work_completion)(&ndev->cvq_ent.work)){+.+.}-{0:0}:
>         lock_acquire+0x126/0x330
>         process_one_work+0x874/0x1660
>         worker_thread+0x62c/0x1030
>         kthread+0x377/0x490
>         ret_from_fork+0x4d7/0x720
>         ret_from_fork_asm+0x11/0x20
>
>  -> #0 ((wq_completion)mlx5_vdpa_wq){+.+.}-{0:0}:
>         check_prev_add+0xe8/0xdb0
>         __lock_acquire+0x1801/0x23e0
>         lock_acquire+0x126/0x330
>         touch_wq_lockdep_map+0x93/0x180
>         __flush_workqueue+0xed/0x1090
>         unregister_link_notifier+0x10c/0x170 [mlx5_vdpa]
>         mlx5_vdpa_compat_reset+0xfe/0x760 [mlx5_vdpa]
>         mlx5_vdpa_reset+0x15/0x30 [mlx5_vdpa]
>         _compat_vdpa_reset+0x29b/0x3b0 [vhost_vdpa]
>         vhost_vdpa_release+0x16f/0x380 [vhost_vdpa]
>         __fput+0x36a/0xaa0
>         task_work_run+0x111/0x1f0
>         do_exit+0x7ba/0x2590
>         do_group_exit+0xb8/0x250
>         get_signal+0x1f46/0x2020
>         arch_do_signal_or_restart+0x79/0x4a0
>         exit_to_user_mode_loop+0xbe/0x450
>         do_syscall_64+0x257/0x4f0
>         entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>  other info that might help us debug this:
>
>  Chain exists of:
>    (wq_completion)mlx5_vdpa_wq --> (work_completion)(&ndev->cvq_ent.work)=
 --> &ndev->reslock
>
>   Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(&ndev->reslock);
>                                 lock((work_completion)(&ndev->cvq_ent.wor=
k));
>                                 lock(&ndev->reslock);
>    lock((wq_completion)mlx5_vdpa_wq);
>
>   *** DEADLOCK ***
>
>  locks held by qemu-system-x86/5785: 3, last CPU#9:
>   #0: ff1100021d7c2068 (&dev->mutex#3){+.+.}-{4:4}, at: vhost_vdpa_releas=
e+0x4b/0x380 [vhost_vdpa]
>   #1: ff11000136eb44c8 (&vdev->cf_lock){++++}-{4:4}, at: _compat_vdpa_res=
et+0x16b/0x3b0 [vhost_vdpa]
>   #2: ff11000136eb4928 (&ndev->reslock){+.+.}-{4:4}, at: mlx5_vdpa_compat=
_reset+0xed/0x760 [mlx5_vdpa]
>
> vhost_vdpa_release() resets the device before stopping the kick
> handlers, so CVQ kicks can still be queued while the reset runs.
>
> The fix is to move unregister_link_notifier() calls outside of
> reslock. The function doesn't need the reslock.
>
> Fixes: c384c2401eed ("vdpa/mlx5: Avoid losing link state updates")
> Cc: stable@vger.kernel.org

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index f1c5f72032a3..a175f734517d 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2908,6 +2908,8 @@ static void unregister_link_notifier(struct mlx5_vd=
pa_net *ndev)
>
>         ndev->nb_registered =3D false;
>         mlx5_notifier_unregister(ndev->mvdev.mdev, &ndev->nb);
> +       /* mlx5_cvq_kick_handler() work needs the reslock. */
> +       lockdep_assert_not_held(&ndev->reslock);
>         if (ndev->mvdev.wq)
>                 flush_workqueue(ndev->mvdev.wq);
>  }
> @@ -3215,6 +3217,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device=
 *vdev, u8 status)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> +       bool unregister_nb =3D false;
>         int err;
>
>         print_status(mvdev, status, true);
> @@ -3257,12 +3260,14 @@ static void mlx5_vdpa_set_status(struct vdpa_devi=
ce *vdev, u8 status)
>         return;
>
>  err_driver:
> -       unregister_link_notifier(ndev);
> +       unregister_nb =3D true;
>  err_setup:
>         mlx5_vdpa_clean_mrs(&ndev->mvdev);
>         ndev->mvdev.status |=3D VIRTIO_CONFIG_S_FAILED;
>  err_clear:
>         up_write(&ndev->reslock);
> +       if (unregister_nb)
> +               unregister_link_notifier(ndev);
>  }
>
>  static void init_group_to_asid_map(struct mlx5_vdpa_dev *mvdev)
> @@ -3301,9 +3306,9 @@ static int mlx5_vdpa_compat_reset(struct vdpa_devic=
e *vdev, u32 flags)
>
>         print_status(mvdev, 0, true);
>         mlx5_vdpa_info(mvdev, "performing device reset\n");
> +       unregister_link_notifier(ndev);
>
>         down_write(&ndev->reslock);
> -       unregister_link_notifier(ndev);
>         vq_reset =3D needs_vqs_reset(mvdev);
>         if (vq_reset) {
>                 teardown_vq_resources(ndev);
> --
> 2.54.0
>

