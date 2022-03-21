Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3327CC433F5
	for <virtualization@archiver.kernel.org>; Mon, 21 Mar 2022 07:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1C0F82486;
	Mon, 21 Mar 2022 07:36:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 85hIWXOhZUB6; Mon, 21 Mar 2022 07:36:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 767D481753;
	Mon, 21 Mar 2022 07:36:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B925C001A;
	Mon, 21 Mar 2022 07:36:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 257C2C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 07:36:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1482E81815
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 07:36:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OAEsXlEAPt3c
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 07:36:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 546DD81753
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 07:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647848193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qe08beYUx+UYZYqGshctk6NaXdVdumZ1XV+DJA6B5a8=;
 b=K//dOXhcO8TQC+GvgAQffauS7ZKlbsapa6ccvQ2h51Z4URMMuBqr4ToitM9exY5Eg4X0RG
 eQmjbLczk5jPH3JEZ59t7yooIxjCVV9PsQ7zpmD+ZLM+TpGtYSDwkg8HozYH67m3U5iO4a
 Wko+Dbs4YUYN4alcXkurxZXABVRNNkk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-I5MR_4wPM5eWipozW7joAw-1; Mon, 21 Mar 2022 03:36:29 -0400
X-MC-Unique: I5MR_4wPM5eWipozW7joAw-1
Received: by mail-lj1-f200.google.com with SMTP id
 h21-20020a05651c125500b002464536cf4eso5896928ljh.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 00:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qe08beYUx+UYZYqGshctk6NaXdVdumZ1XV+DJA6B5a8=;
 b=bJI6GtfZ46Za2rTYpA+FtzxaJCmOv5CY+LqbQELtpIkhqjOo2fpDGhTAw+ZNRWrtQm
 L1MMJY2l89ZWkkcMZ9E8fA36e5Uju5GxKPuUO3P7wK+ODiS1xWItEc8wUXsN6cRtkZH5
 LN7ZXTuvBsVNdubwCFmC7cuq/tznRNpM/alPHWGw8thXM9w/XdFsQQKMHqeQQIg/0sKQ
 j4H9YCuvB5mrbWCecEG8XQ7UWJgZGYowVPCmMfWGueGEWtHveC3uoUjSfJA8HzairneT
 VGPJQUbHC5c9J+X5gUdAx6XtbhMDUth/+ek88p7vd1n9ckNLUyjEXT3nO+bTA6GDXkWG
 qHYQ==
X-Gm-Message-State: AOAM53001eTpCBX6scQKFQL6SEeBMPKRG7Ve8N/i0DCn1s7ytqZRXFOT
 J96qDm+UDUixpt/mDoDeoWVV/AZw8pSctULfjt4VpFXEJqVzeNPqeB/QqwQGVJ4X685v+gORs9v
 /QuLqPGuc6GxBAkD1vh7GSvsLl2iELoS01KVwX4I8wdCFD3LJYMybFYd9Ng==
X-Received: by 2002:a05:6512:2203:b0:44a:12c9:8696 with SMTP id
 h3-20020a056512220300b0044a12c98696mr8177458lfu.98.1647848187435; 
 Mon, 21 Mar 2022 00:36:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrJCIJF80wb6QJBxaOpt0rFvy2rgLkmZPLA1xItXiYu5J1dt0MCV1yBUyegrVf8EYAl2dqO0mzDVFLFNta2T4=
X-Received: by 2002:a05:6512:2203:b0:44a:12c9:8696 with SMTP id
 h3-20020a056512220300b0044a12c98696mr8177451lfu.98.1647848187178; Mon, 21 Mar
 2022 00:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220321060429.10457-1-jasowang@redhat.com>
 <20220321060429.10457-2-jasowang@redhat.com>
 <20220321032130-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220321032130-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Mar 2022 15:36:16 +0800
Message-ID: <CACGkMEvQCBTk7WVLvRAsgj1OOcE7rh5DEpN91HOdZLZyagcbuw@mail.gmail.com>
Subject: Re: [PATCH 2/2] vdpa: mlx5: synchronize driver status with CVQ
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

On Mon, Mar 21, 2022 at 3:24 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Mar 21, 2022 at 02:04:29PM +0800, Jason Wang wrote:
> > Currently, CVQ doesn't have any synchronization with the driver
> > status. Then CVQ emulation code run in the middle of:
> >
> > 1) device reset
> > 2) device status changed
> > 3) map updating
> >
> > The will lead several unexpected issue like trying to execute CVQ
> > command after the driver has been teared down.
> >
> > Fixing this by using reslock to synchronize CVQ emulation code with
> > the driver status changing:
> >
> > - protect the whole device reset, status changing and map updating
> >   with reslock
> > - protect the CVQ handler with the reslock and check
> >   VIRTIO_CONFIG_S_DRIVER_OK in the CVQ handler
> >
> > This will guarantee that:
> >
> > 1) CVQ handler won't work if VIRTIO_CONFIG_S_DRIVER_OK is not set
> > 2) CVQ handler will see a consistent state of the driver instead of
> >    the partial one when it is running in the middle of the
> >    teardown_driver() or setup_driver().
> >
> > Cc: 5262912ef3cfc ("vdpa/mlx5: Add support for control VQ and MAC setting")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 42 +++++++++++++++++++++++--------
> >  1 file changed, 31 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index d5a6fb3f9c41..524240f55c1c 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -1618,11 +1618,17 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
> >       mvdev = wqent->mvdev;
> >       ndev = to_mlx5_vdpa_ndev(mvdev);
> >       cvq = &mvdev->cvq;
> > +
> > +     mutex_lock(&ndev->reslock);
> > +
> > +     if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> > +             goto done;
> > +
> >       if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> > -             return;
> > +             goto done;
> >
> >       if (!cvq->ready)
> > -             return;
> > +             goto done;
> >
> >       while (true) {
> >               err = vringh_getdesc_iotlb(&cvq->vring, &cvq->riov, &cvq->wiov, &cvq->head,
> > @@ -1663,6 +1669,9 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
> >                       break;
> >               }
> >       }
> > +
> > +done:
> > +     mutex_unlock(&ndev->reslock);
> >  }
> >
> >  static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
> > @@ -2125,6 +2134,8 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
> >       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> >       int err;
> >
> > +     mutex_lock(&ndev->reslock);
> > +
> >       suspend_vqs(ndev);
> >       err = save_channels_info(ndev);
> >       if (err)
> > @@ -2137,18 +2148,20 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
> >               goto err_mr;
> >
> >       if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> > -             return 0;
> > +             goto err_mr;
> >
> >       restore_channels_info(ndev);
> >       err = setup_driver(mvdev);
> >       if (err)
> >               goto err_setup;
> >
> > +     mutex_unlock(&ndev->reslock);
> >       return 0;
> >
> >  err_setup:
> >       mlx5_vdpa_destroy_mr(mvdev);
> >  err_mr:
> > +     mutex_unlock(&ndev->reslock);
> >       return err;
> >  }
> >
> > @@ -2157,7 +2170,8 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
> >       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> >       int err;
> >
> > -     mutex_lock(&ndev->reslock);
> > +     WARN_ON(!mutex_is_locked(&ndev->reslock));
> > +
> >       if (ndev->setup) {
> >               mlx5_vdpa_warn(mvdev, "setup driver called for already setup driver\n");
> >               err = 0;
>
>
> Maybe also add a comment near function header explaining this must be
> called with lock held.

Will do.

Thanks

>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
