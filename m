Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E7AC43334
	for <virtualization@archiver.kernel.org>; Tue, 21 Jun 2022 03:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 044D661024;
	Tue, 21 Jun 2022 03:05:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 044D661024
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RU9cwfsV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zrO5NJNnyW66; Tue, 21 Jun 2022 03:05:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 508C360D6D;
	Tue, 21 Jun 2022 03:05:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 508C360D6D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30080C0032;
	Tue, 21 Jun 2022 03:05:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 523F3C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 03:05:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1EC7E61024
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 03:05:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1EC7E61024
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RyZ3ddi53SrK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 03:05:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 17E0960D6D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 17E0960D6D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 03:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655780707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IEDQbrqCDnnzlN2lESJGmEW8kKV42M3tmKohr7BwJIQ=;
 b=RU9cwfsVAXWn9RyPKJ/yDeSwOvB+Y4ljRwlvWpDi+VtoTlmbMsKnsnf7UNJRvuYNPUyRyi
 H0Lcm7/QwwiHhEJ+e7wGo5Ds3iEhp3/0j2agoQ6zqIdTrrBosNchJF/j+mS8ty8oHWsb3T
 5y14Gx4hy4I1PDnWNbSsa8HrS8x5dK0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-TGNktfGgM4y-NsnlA2c4dA-1; Mon, 20 Jun 2022 23:05:05 -0400
X-MC-Unique: TGNktfGgM4y-NsnlA2c4dA-1
Received: by mail-lf1-f69.google.com with SMTP id
 j3-20020a05651231c300b0047dbea7b031so6265711lfe.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 20:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IEDQbrqCDnnzlN2lESJGmEW8kKV42M3tmKohr7BwJIQ=;
 b=L3QetiaaaktNP5GaTEbv7lHEo73LrGX6eXvciCB4TJxwqPDvicVvi5yb9Nj1QWQUqW
 y3wGEj75goXHJjmyZAXy/QU/5H+um7srdensaaB0qScRaDaKnq//H6zeuucKkhOybqa0
 5p2CsKVBt+mS04Ov1Sk/y7sGqpaIwQETeIdr6DSDgX5uuozBRpid58THovtGaDtHWxC5
 aJvKR4hUuZrNjLOdBflfff5iodf5IQdhcSngl22Q6vE0RSA/2UJAFFt8UwIxTkvDJfh+
 z21ZMzNhD+RZ9462NPzF1iJ5v3hdOD5PrqQ1FAVdu55eicpMjcYfI6BcqWvv3JeW7ItA
 j1UQ==
X-Gm-Message-State: AJIora8BYvMXUTxzZe72B6GfIEl7RCn5P4MdGPkNcpg8TUN5SqJAc1yA
 LgJu5LIYVh8Bkt5Vu/xJzX40LvidTqRjSWucdxRH5fQO5/P5qKqXy/Xi/ldtsc69i0jsJNVQSE7
 36b/i+WlY50OoQ3pwv8AwXXCUH1zq106E8/GQuFKtrmxyV3QhrfsyendTsQ==
X-Received: by 2002:a05:6512:13a5:b0:47d:c1d9:dea8 with SMTP id
 p37-20020a05651213a500b0047dc1d9dea8mr15453652lfa.442.1655780701979; 
 Mon, 20 Jun 2022 20:05:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ve2/AO9/k7M96rrzDPn68BkBow1Mx7UHpUi3NZ41WbMnslBgJ0QvWYbJnGXCZahSfxmqxjVuchsJS0VLaHD/c=
X-Received: by 2002:a05:6512:13a5:b0:47d:c1d9:dea8 with SMTP id
 p37-20020a05651213a500b0047dc1d9dea8mr15453640lfa.442.1655780701719; Mon, 20
 Jun 2022 20:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220616132725.50599-1-elic@nvidia.com>
 <20220616132725.50599-2-elic@nvidia.com>
 <CACGkMEue-X8-u0Z=EwUbBSV6vmomwNy52Tot3Zf+0pu4Pztutg@mail.gmail.com>
 <CAJaqyWfTG_jVW6Vzf64QO=255kfwWKn4gCUMeGog-1shHx3O_g@mail.gmail.com>
In-Reply-To: <CAJaqyWfTG_jVW6Vzf64QO=255kfwWKn4gCUMeGog-1shHx3O_g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Jun 2022 11:04:50 +0800
Message-ID: <CACGkMEtcs9e1NJ7ArkibQSrDN7j_eyciZo=yDfbd5Jsb4gvzZA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] vdpa/mlx5: Implement susupend virtqueue callback
To: Eugenio Perez Martin <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <elic@nvidia.com>
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

On Mon, Jun 20, 2022 at 5:59 PM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Jun 20, 2022 at 10:56 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, Jun 16, 2022 at 9:27 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > Implement the suspend callback allowing to suspend the virtqueues so
> > > they stop processing descriptors. This is required to allow the shadow
> > > virtqueue to kick in.
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 68 +++++++++++++++++++++++++++++-
> > >  include/linux/mlx5/mlx5_ifc_vdpa.h |  8 ++++
> > >  2 files changed, 75 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index fb0b23e71383..ea4bc8a0cd25 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -895,6 +895,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> > >         if (err)
> > >                 goto err_cmd;
> > >
> > > +       mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT;
> > >         kfree(in);
> > >         mvq->virtq_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
> > >
> > > @@ -922,6 +923,7 @@ static void destroy_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq
> > >                 mlx5_vdpa_warn(&ndev->mvdev, "destroy virtqueue 0x%x\n", mvq->virtq_id);
> > >                 return;
> > >         }
> > > +       mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
> > >         umems_destroy(ndev, mvq);
> > >  }
> > >
> > > @@ -1121,6 +1123,20 @@ static int query_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueu
> > >         return err;
> > >  }
> > >
> > > +static bool is_valid_state_change(int oldstate, int newstate)
> > > +{
> > > +       switch (oldstate) {
> > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
> > > +               return newstate == MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY;
> > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
> > > +               return newstate == MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND;
> > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
> > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_ERR:
> > > +       default:
> > > +               return false;
> > > +       }
> > > +}
> > > +
> > >  static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int state)
> > >  {
> > >         int inlen = MLX5_ST_SZ_BYTES(modify_virtio_net_q_in);
> > > @@ -1130,6 +1146,12 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> > >         void *in;
> > >         int err;
> > >
> > > +       if (mvq->fw_state == MLX5_VIRTIO_NET_Q_OBJECT_NONE)
> > > +               return 0;
> > > +
> > > +       if (!is_valid_state_change(mvq->fw_state, state))
> > > +               return -EINVAL;
> > > +
> > >         in = kzalloc(inlen, GFP_KERNEL);
> > >         if (!in)
> > >                 return -ENOMEM;
> > > @@ -1991,6 +2013,7 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
> > >         struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > >         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > >         struct mlx5_vdpa_virtqueue *mvq;
> > > +       int err;
> > >
> > >         if (!mvdev->actual_features)
> > >                 return;
> > > @@ -2004,8 +2027,16 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
> > >         }
> > >
> > >         mvq = &ndev->vqs[idx];
> > > -       if (!ready)
> > > +       if (!ready) {
> > >                 suspend_vq(ndev, mvq);
> > > +       } else {
> > > +               err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
> > > +               if (err) {
> > > +                       mlx5_vdpa_warn(mvdev, "modify VQ %d to ready failed (%d)\n", idx, err);
> > > +                       ready = false;
> > > +               }
> > > +       }
> > > +
> > >
> > >         mvq->ready = ready;
> > >  }
> > > @@ -2732,6 +2763,39 @@ static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, u16 idx,
> > >         return err;
> > >  }
> > >
> > > +static void mlx5_vdpa_cvq_suspend(struct mlx5_vdpa_dev *mvdev, bool suspend)
> > > +{
> > > +       struct mlx5_control_vq *cvq;
> > > +
> > > +       if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> > > +               return;
> > > +
> > > +       cvq = &mvdev->cvq;
> > > +       cvq->ready = !suspend;
> > > +}
> >
> > It looks to me we need to synchronize this with reslock. And this
> > probably deserve a dedicated fix.
> >
> > > +
> > > +static int mlx5_vdpa_suspend(struct vdpa_device *vdev, bool suspend)
> > > +{
> > > +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > +       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > +       struct mlx5_vdpa_virtqueue *mvq;
> > > +       int i;
> > > +
> > > +       if (!suspend) {
> > > +               mlx5_vdpa_warn(mvdev, "Resume of virtqueues is not supported\n");
> > > +               return -EOPNOTSUPP;
> > > +       }
> > > +
> > > +       down_write(&ndev->reslock);
> > > +       for (i = 0; i < ndev->cur_num_vqs; i++) {
> > > +               mvq = &ndev->vqs[i];
> > > +               suspend_vq(ndev, mvq);
> > > +       }
> > > +       mlx5_vdpa_cvq_suspend(mvdev, suspend);
> >
> > Do we need to synchronize with the carrier work here? Otherwise we may
> > get config notification after suspending.
> >
> > > +       up_write(&ndev->reslock);
> > > +       return 0;
> > > +}
> > > +
> > >  static const struct vdpa_config_ops mlx5_vdpa_ops = {
> > >         .set_vq_address = mlx5_vdpa_set_vq_address,
> > >         .set_vq_num = mlx5_vdpa_set_vq_num,
> > > @@ -2762,6 +2826,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
> > >         .get_generation = mlx5_vdpa_get_generation,
> > >         .set_map = mlx5_vdpa_set_map,
> > >         .free = mlx5_vdpa_free,
> > > +       .suspend = mlx5_vdpa_suspend,
> >
> > I don't see the vDPA bus patch to enable this method. Or anything I missed here?
> >
>
> Should we add
> Based-on: <20220526124338.36247-1-eperezma@redhat.com>
>
> To this series?

Probably, but that series seems to support resume while this series doesn't.

Any reason for this?

(I don't see any blocker for this especially considering parents can
choose to do reset + set_vring_state etc.)

Thanks

>
> > Thanks
> >
> > >  };
> > >
> > >  static int query_mtu(struct mlx5_core_dev *mdev, u16 *mtu)
> > > @@ -2827,6 +2892,7 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
> > >                 mvq->index = i;
> > >                 mvq->ndev = ndev;
> > >                 mvq->fwqp.fw = true;
> > > +               mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
> > >         }
> > >         for (; i < ndev->mvdev.max_vqs; i++) {
> > >                 mvq = &ndev->vqs[i];
> > > diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > index 4414ed5b6ed2..423562f39d3c 100644
> > > --- a/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > +++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > @@ -150,6 +150,14 @@ enum {
> > >         MLX5_VIRTIO_NET_Q_OBJECT_STATE_ERR      = 0x3,
> > >  };
> > >
> > > +/* This indicates that the object was not created or has alreadyi
> > > + * been desroyed. It is very safe to assume that this object will never
> > > + * have so many states
> > > + */
> > > +enum {
> > > +       MLX5_VIRTIO_NET_Q_OBJECT_NONE = 0xffffffff
> > > +};
> > > +
> > >  enum {
> > >         MLX5_RQTC_LIST_Q_TYPE_RQ            = 0x0,
> > >         MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q  = 0x1,
> > > --
> > > 2.35.1
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
