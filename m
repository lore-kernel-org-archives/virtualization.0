Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F248C433F5
	for <virtualization@archiver.kernel.org>; Mon, 21 Mar 2022 08:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09D3360E15;
	Mon, 21 Mar 2022 08:59:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jsrJK-MIH_PP; Mon, 21 Mar 2022 08:59:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9785D60BA6;
	Mon, 21 Mar 2022 08:59:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F02FC0012;
	Mon, 21 Mar 2022 08:59:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67258C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 08:59:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 53E96402D0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 08:59:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zqIzDDYYcLWD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 08:59:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E3E354021C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 08:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647853160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TACjk6R4PSYbfRZ6CJuCtZCZ4dHNbrWklt+lsL+W/vQ=;
 b=PxOFo+0nmtETNQ5V/4vGTKVlZHKsbydfMsGF7D96AkFHatkNyZvrWZmmN3+dc2LSOp9Dp7
 JuwPIkVriOEwxlxn2alQoiiDbn0uIDEri/G1itISd14/k9PXs11S43ucoek4rqihykbMAH
 xS4TQ3EEmJ8RregR4icQDUYPz4p/5B0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-eh_qH1zFPbqA7aDfbFnvkw-1; Mon, 21 Mar 2022 04:59:19 -0400
X-MC-Unique: eh_qH1zFPbqA7aDfbFnvkw-1
Received: by mail-lj1-f199.google.com with SMTP id
 h21-20020a05651c125500b002464536cf4eso5976398ljh.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 01:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TACjk6R4PSYbfRZ6CJuCtZCZ4dHNbrWklt+lsL+W/vQ=;
 b=gSc7SIpAJNSUfbXUNA9mKOWXnrBukaFYz36JgXDIBzKS5Csx71Uql5nxlgAqgVLyBp
 KXImeyNjctwTXpD330LbR4d+a3tQIunb7MtUpX5pIGLzfC30O65B+m1LWQaf2MAiOAn7
 K93ByfvEaRl3mHBHoRnzk+WRXrkjGermamVbRy8AwM5fCnMSXtY71CikeCnLs0bsXmnF
 ksvq4s8+zvX0Szdw1cX/JGIaU6fp5oF0NDDioKgPB02Doc2ee+qcWZgU19+7IP0JT6Dm
 A8DWrrXAfsw5A+RZKYL9l3fDtzj0QzXX6jDXMhZLJ9CKk+YBtLCkjP/vUo3tlPhO+wsC
 gLgg==
X-Gm-Message-State: AOAM530C/v4kAA6P6XnYIH8E9LlPzvzhEmRswdkQxx5T0ON42q0r3BcC
 KBUpdxZe6cpbmuicTTx2HVkLWDT2fbOUm26JxTHNnMoELOJeetcYxag2AlmFB8Li2rNQX1OXFnz
 pJxmalnmyPoA46pWHoyEKpMOUeeg2GpOEq2RA4Siq2ypG2vGDaVRIOW/X4A==
X-Received: by 2002:a05:651c:1543:b0:249:218f:2228 with SMTP id
 y3-20020a05651c154300b00249218f2228mr14691142ljp.492.1647853157671; 
 Mon, 21 Mar 2022 01:59:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwspRa/3XED/kMS/oaqPukHOIHrr/aJEo+WZJYEMmSggzLodu+d9PjVSsSV3ywTkJ6I5lvN0albgWIWncZqhMk=
X-Received: by 2002:a05:651c:1543:b0:249:218f:2228 with SMTP id
 y3-20020a05651c154300b00249218f2228mr14691129ljp.492.1647853157450; Mon, 21
 Mar 2022 01:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220321060429.10457-1-jasowang@redhat.com>
 <20220321085317.3148-1-hdanton@sina.com>
In-Reply-To: <20220321085317.3148-1-hdanton@sina.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Mar 2022 16:59:06 +0800
Message-ID: <CACGkMEvF80FuU0uD+RZMOrySQ0K2RZVh7Pmn4UhNtz_Exs3c2w@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
To: Hillf Danton <hdanton@sina.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eli Cohen <elic@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mst <mst@redhat.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Mar 21, 2022 at 4:53 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Mon, 21 Mar 2022 14:04:28 +0800 Jason Wang wrote:
> > A userspace triggerable infinite loop could happen in
> > mlx5_cvq_kick_handler() if userspace keeps sending a huge amount of
> > cvq requests.
> >
> > Fixing this by introducing a quota and re-queue the work if we're out
> > of the budget. While at it, using a per device workqueue to avoid on
> > demand memory allocation for cvq.
> >
> > Fixes: 5262912ef3cfc ("vdpa/mlx5: Add support for control VQ and MAC setting")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 28 +++++++++++++++-------------
> >  1 file changed, 15 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index d0f91078600e..d5a6fb3f9c41 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -163,6 +163,7 @@ struct mlx5_vdpa_net {
> >       u32 cur_num_vqs;
> >       struct notifier_block nb;
> >       struct vdpa_callback config_cb;
> > +     struct mlx5_vdpa_wq_ent cvq_ent;
> >  };
> >
> >  static void free_resources(struct mlx5_vdpa_net *ndev);
> > @@ -1600,6 +1601,8 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
> >       return status;
> >  }
> >
> > +#define MLX5_CVQ_BUDGET 16
> > +
>
> This is not needed as given a single thread workqueue, a cond_resched()
> can do the job in the worker context instead of requeue of work.
>
> Hillf

I'm not sure I get this, but there's a loop in the work fn:

while(true) {
}

Where there could be no chance for the cond_resched() to run?

Thanks

>
> >  static void mlx5_cvq_kick_handler(struct work_struct *work)
> >  {
> >       virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
> > @@ -1609,17 +1612,17 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
> >       struct mlx5_control_vq *cvq;
> >       struct mlx5_vdpa_net *ndev;
> >       size_t read, write;
> > -     int err;
> > +     int err, n = 0;
> >
> >       wqent = container_of(work, struct mlx5_vdpa_wq_ent, work);
> >       mvdev = wqent->mvdev;
> >       ndev = to_mlx5_vdpa_ndev(mvdev);
> >       cvq = &mvdev->cvq;
> >       if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> > -             goto out;
> > +             return;
> >
> >       if (!cvq->ready)
> > -             goto out;
> > +             return;
> >
> >       while (true) {
> >               err = vringh_getdesc_iotlb(&cvq->vring, &cvq->riov, &cvq->wiov, &cvq->head,
> > @@ -1653,9 +1656,13 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
> >
> >               if (vringh_need_notify_iotlb(&cvq->vring))
> >                       vringh_notify(&cvq->vring);
> > +
> > +             n++;
> > +             if (n > MLX5_CVQ_BUDGET) {
> > +                     queue_work(mvdev->wq, &wqent->work);
> > +                     break;
> > +             }
> >       }
> > -out:
> > -     kfree(wqent);
> >  }
> >
> >  static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
> > @@ -1663,7 +1670,6 @@ static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
> >       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> >       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> >       struct mlx5_vdpa_virtqueue *mvq;
> > -     struct mlx5_vdpa_wq_ent *wqent;
> >
> >       if (!is_index_valid(mvdev, idx))
> >               return;
> > @@ -1672,13 +1678,7 @@ static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
> >               if (!mvdev->cvq.ready)
> >                       return;
> >
> > -             wqent = kzalloc(sizeof(*wqent), GFP_ATOMIC);
> > -             if (!wqent)
> > -                     return;
> > -
> > -             wqent->mvdev = mvdev;
> > -             INIT_WORK(&wqent->work, mlx5_cvq_kick_handler);
> > -             queue_work(mvdev->wq, &wqent->work);
> > +             queue_work(mvdev->wq, &ndev->cvq_ent.work);
> >               return;
> >       }
> >
> > @@ -2668,6 +2668,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >       if (err)
> >               goto err_mr;
> >
> > +     ndev->cvq_ent.mvdev = mvdev;
> > +     INIT_WORK(&ndev->cvq_ent.work, mlx5_cvq_kick_handler);
> >       mvdev->wq = create_singlethread_workqueue("mlx5_vdpa_wq");
> >       if (!mvdev->wq) {
> >               err = -ENOMEM;
> > --
> > 2.18.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
