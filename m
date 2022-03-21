Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EE1C433F5
	for <virtualization@archiver.kernel.org>; Mon, 21 Mar 2022 07:35:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B18B88175E;
	Mon, 21 Mar 2022 07:35:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uPtf6thoiH9o; Mon, 21 Mar 2022 07:35:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 39F3E8174D;
	Mon, 21 Mar 2022 07:35:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EAE2C001A;
	Mon, 21 Mar 2022 07:35:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6614C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 07:35:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BFC9A81753
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 07:35:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 53qEYTDgxWzd
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 07:35:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7971F8174D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 07:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647848152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jN9EzqA/aDWgWsm6Qj9+fUo2briM9lSf7r09izKJQBM=;
 b=NwMF2sidYHKgKTG0hEPEfhOPiosH4hGOnWjyMm817vjhp21N6lVJTDq6wkKTOxQ3fv56ZD
 AArjr0yAkQDIgWsi7o+3w6IXkBOAcyynrkhqKAwN578f8SDVyG51Nc+JDmSQaoLVh/8g7i
 1zgFhdmivL1S80NkBARF0Nc55yrCz2k=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-qvLaVNS7MaGjbF9m6RXYow-1; Mon, 21 Mar 2022 03:35:50 -0400
X-MC-Unique: qvLaVNS7MaGjbF9m6RXYow-1
Received: by mail-lj1-f198.google.com with SMTP id
 h4-20020a2ea484000000b002480c04898aso5917402lji.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 00:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jN9EzqA/aDWgWsm6Qj9+fUo2briM9lSf7r09izKJQBM=;
 b=j1ni1l8vI1IBzhREDKZMjTwBlCzAg1j8ndsrm+qw7LpTRBJ/mmXbos5MrfE0wp9E6b
 8gmQoC1xpCUOhQeaheGdksOAS3gRSHW4Zcpl72VY5e6ANxUl8DBj8gzqAkPuRocxH0+Z
 low8OpZoImhZC+0hCa3RNWGZgp9whCmj+PSrk9X7U+uQIItMTaHdIexYOgew26q7AGDq
 0kfo+gG1R6jW1PG2AmKFqTsAcmAEvCYG/3gWfi7lBKdAaM/S2l/dYrkrqyD520OP4dLk
 5GHoXOtYOU1PsoWgAe7D5Pe77f3v9Qn5/5H2v4+aKDLbLJBEZLChL323UoHHjy0XZaxE
 nlFA==
X-Gm-Message-State: AOAM533mjVo3X5G0n2q4Sfg/KcWOCUcDbVL/jxdZkTTTvJalgcN75/sH
 +nPuyPqH+gCTjqJsLV2s60Z3OmBltWM8PSpGttDqmMZA6y7BDamolurC8VDyYtw+QHGKAPvjpZl
 nf9zjufH7iEUCdKHDRXgz6H/Ju/9/7X4AZDZJcxIICEjLkQBqSIbpC0TsnQ==
X-Received: by 2002:a05:6512:ad2:b0:448:ac0a:2df8 with SMTP id
 n18-20020a0565120ad200b00448ac0a2df8mr13635398lfu.376.1647848149035; 
 Mon, 21 Mar 2022 00:35:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDFZx9DdlliH40AAebAUR97H2Zr+7VcnEgwq/1wWtU+sQWoGuORbz6lplhmHV8rINCndgEdYrFgFzhxLqCInU=
X-Received: by 2002:a05:6512:ad2:b0:448:ac0a:2df8 with SMTP id
 n18-20020a0565120ad200b00448ac0a2df8mr13635389lfu.376.1647848148808; Mon, 21
 Mar 2022 00:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220321060429.10457-1-jasowang@redhat.com>
 <20220321032019-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220321032019-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Mar 2022 15:35:37 +0800
Message-ID: <CACGkMEtWqR06fAmtrT2E5BXeYxi4vaoCxMKrOSKkgrzC8kaPWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eli Cohen <elic@nvidia.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Mon, Mar 21, 2022 at 3:20 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Mar 21, 2022 at 02:04:28PM +0800, Jason Wang wrote:
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
>
> Shouldn't there be a flush during cleanup somewhere?

I think the destory_workqueue() in mlx5_vdpa_dev_del() will do the flush/drain.

Thanks

>
> > --
> > 2.18.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
