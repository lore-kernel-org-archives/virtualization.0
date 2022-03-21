Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379A7C433F5
	for <virtualization@archiver.kernel.org>; Mon, 21 Mar 2022 09:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBFBA410AA;
	Mon, 21 Mar 2022 09:00:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NHDTMiMWp7AT; Mon, 21 Mar 2022 09:00:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 37B2C410A8;
	Mon, 21 Mar 2022 09:00:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4282C0012;
	Mon, 21 Mar 2022 09:00:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF2A2C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 09:00:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CE32A410AA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 09:00:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k-D3-sgIg1NP
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 09:00:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0E6AE410A8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 09:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647853224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zi0LCjDAYk+S/zu+NPNaBC8I7MaqvlSf7KQP5E7mH5M=;
 b=DUpwOPbNRrkjUKwgMKa0eB3GwIoJ7Zo7Bkmy71Ka/oYJDezIpI4H8pnrbx1E9DAEYIpmex
 58cscXWQYaMp5IgRuU+73t9TIfETWbcBxx6wPmY82gHjCfqQ0+NZsXI2DDPIV5c8jhCGwK
 vSBFkCAR5RjLC114/21Ix8Hr8Tv8kt4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-f74B7wH8N-KaH0v2mfgRyg-1; Mon, 21 Mar 2022 05:00:22 -0400
X-MC-Unique: f74B7wH8N-KaH0v2mfgRyg-1
Received: by mail-lf1-f72.google.com with SMTP id
 q19-20020ac24a73000000b0044a100bb508so1276848lfp.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 02:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zi0LCjDAYk+S/zu+NPNaBC8I7MaqvlSf7KQP5E7mH5M=;
 b=BhGuuXUyxJhmuUP5zYsxZLPkAs9w5wpk2auh374Z6ryu/uln4ei1d2ZmN4/E5bJpHn
 RhVjcWSae+aNjvmDUBx4kvpo8Yj+f12ZJ/WmERw8MtrhpDJ0MTIJLOnY9XkSfNJfx4Ot
 A6/9SdN9gL/MeZf+AANX/Am1pyz8LSkhQNZNpJ4iClTEi6gL/kUyqxVHmhXbqFRPOjQg
 ZKVPY3dWQa67t0wJuMJnoRFIwaEi7Al0wzVx5lFCw+P2qs+RBmdu4krJANl06QfRLVC4
 CQRA7v8cd+bIK39O2WzY+3KtdTJoX3xVw0cy9ISCL8eQu5DovhIS0CDO8A63LGAbX33k
 m2yA==
X-Gm-Message-State: AOAM530uNiuaANIZpohArJS+JKEfYS9uvAwz5OMeyaZ0O94RsVM8GIkv
 a2EFbvBsq+WfwhCpcoAZKcF4PwRshKQc8gZ7bBgq842q/3oNjBE8U3YFxHHbkok9clpcvEOze7O
 zE8vSEFFEnGh96Ks4FeAu75xpUlr3lCIByZNWdia7GeUaClbaq55jbBSidQ==
X-Received: by 2002:a05:6512:ad2:b0:448:ac0a:2df8 with SMTP id
 n18-20020a0565120ad200b00448ac0a2df8mr13811480lfu.376.1647853220827; 
 Mon, 21 Mar 2022 02:00:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6eY13JvJYlkBv2Mfu/ghdIXoGSVHRwlTasKtcGWyQzfA2K117O5iFJoTLZaFYQuideQsrs1cWKzNPT5++gGI=
X-Received: by 2002:a05:6512:ad2:b0:448:ac0a:2df8 with SMTP id
 n18-20020a0565120ad200b00448ac0a2df8mr13811467lfu.376.1647853220582; Mon, 21
 Mar 2022 02:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220321060429.10457-1-jasowang@redhat.com>
 <20220321085317.3148-1-hdanton@sina.com>
 <CACGkMEvF80FuU0uD+RZMOrySQ0K2RZVh7Pmn4UhNtz_Exs3c2w@mail.gmail.com>
In-Reply-To: <CACGkMEvF80FuU0uD+RZMOrySQ0K2RZVh7Pmn4UhNtz_Exs3c2w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Mar 2022 17:00:09 +0800
Message-ID: <CACGkMEvLqox3QZxpxeQdrjBnM6zRr_wGfddoN45RUSsZEOe=bQ@mail.gmail.com>
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

On Mon, Mar 21, 2022 at 4:59 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Mar 21, 2022 at 4:53 PM Hillf Danton <hdanton@sina.com> wrote:
> >
> > On Mon, 21 Mar 2022 14:04:28 +0800 Jason Wang wrote:
> > > A userspace triggerable infinite loop could happen in
> > > mlx5_cvq_kick_handler() if userspace keeps sending a huge amount of
> > > cvq requests.
> > >
> > > Fixing this by introducing a quota and re-queue the work if we're out
> > > of the budget. While at it, using a per device workqueue to avoid on
> > > demand memory allocation for cvq.
> > >
> > > Fixes: 5262912ef3cfc ("vdpa/mlx5: Add support for control VQ and MAC setting")
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 28 +++++++++++++++-------------
> > >  1 file changed, 15 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index d0f91078600e..d5a6fb3f9c41 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -163,6 +163,7 @@ struct mlx5_vdpa_net {
> > >       u32 cur_num_vqs;
> > >       struct notifier_block nb;
> > >       struct vdpa_callback config_cb;
> > > +     struct mlx5_vdpa_wq_ent cvq_ent;
> > >  };
> > >
> > >  static void free_resources(struct mlx5_vdpa_net *ndev);
> > > @@ -1600,6 +1601,8 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
> > >       return status;
> > >  }
> > >
> > > +#define MLX5_CVQ_BUDGET 16
> > > +
> >
> > This is not needed as given a single thread workqueue, a cond_resched()
> > can do the job in the worker context instead of requeue of work.
> >
> > Hillf
>
> I'm not sure I get this, but there's a loop in the work fn:
>
> while(true) {
> }
>
> Where there could be no chance for the cond_resched() to run?

Ok, speak too fast. So you meant to add a cond_resched() in the loop?

Thanks

>
> Thanks
>
> >
> > >  static void mlx5_cvq_kick_handler(struct work_struct *work)
> > >  {
> > >       virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
> > > @@ -1609,17 +1612,17 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
> > >       struct mlx5_control_vq *cvq;
> > >       struct mlx5_vdpa_net *ndev;
> > >       size_t read, write;
> > > -     int err;
> > > +     int err, n = 0;
> > >
> > >       wqent = container_of(work, struct mlx5_vdpa_wq_ent, work);
> > >       mvdev = wqent->mvdev;
> > >       ndev = to_mlx5_vdpa_ndev(mvdev);
> > >       cvq = &mvdev->cvq;
> > >       if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> > > -             goto out;
> > > +             return;
> > >
> > >       if (!cvq->ready)
> > > -             goto out;
> > > +             return;
> > >
> > >       while (true) {
> > >               err = vringh_getdesc_iotlb(&cvq->vring, &cvq->riov, &cvq->wiov, &cvq->head,
> > > @@ -1653,9 +1656,13 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
> > >
> > >               if (vringh_need_notify_iotlb(&cvq->vring))
> > >                       vringh_notify(&cvq->vring);
> > > +
> > > +             n++;
> > > +             if (n > MLX5_CVQ_BUDGET) {
> > > +                     queue_work(mvdev->wq, &wqent->work);
> > > +                     break;
> > > +             }
> > >       }
> > > -out:
> > > -     kfree(wqent);
> > >  }
> > >
> > >  static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
> > > @@ -1663,7 +1670,6 @@ static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
> > >       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > >       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > >       struct mlx5_vdpa_virtqueue *mvq;
> > > -     struct mlx5_vdpa_wq_ent *wqent;
> > >
> > >       if (!is_index_valid(mvdev, idx))
> > >               return;
> > > @@ -1672,13 +1678,7 @@ static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
> > >               if (!mvdev->cvq.ready)
> > >                       return;
> > >
> > > -             wqent = kzalloc(sizeof(*wqent), GFP_ATOMIC);
> > > -             if (!wqent)
> > > -                     return;
> > > -
> > > -             wqent->mvdev = mvdev;
> > > -             INIT_WORK(&wqent->work, mlx5_cvq_kick_handler);
> > > -             queue_work(mvdev->wq, &wqent->work);
> > > +             queue_work(mvdev->wq, &ndev->cvq_ent.work);
> > >               return;
> > >       }
> > >
> > > @@ -2668,6 +2668,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> > >       if (err)
> > >               goto err_mr;
> > >
> > > +     ndev->cvq_ent.mvdev = mvdev;
> > > +     INIT_WORK(&ndev->cvq_ent.work, mlx5_cvq_kick_handler);
> > >       mvdev->wq = create_singlethread_workqueue("mlx5_vdpa_wq");
> > >       if (!mvdev->wq) {
> > >               err = -ENOMEM;
> > > --
> > > 2.18.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
