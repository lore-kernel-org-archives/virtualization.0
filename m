Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162E4C433EF
	for <virtualization@archiver.kernel.org>; Tue, 21 Jun 2022 02:59:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99C2A41876;
	Tue, 21 Jun 2022 02:59:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 99C2A41876
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XVjDyTmp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UAxmtyLwrIOy; Tue, 21 Jun 2022 02:59:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 812FA417E3;
	Tue, 21 Jun 2022 02:59:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 812FA417E3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E1DBC0032;
	Tue, 21 Jun 2022 02:59:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 827CDC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 02:59:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47AC040194
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 02:59:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47AC040194
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XVjDyTmp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kxas3nmVfnDi
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 02:59:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA24F40135
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA24F40135
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 02:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655780345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dhNf5VQ2CZlb1zUdYetihyiK9C1Amm6yrig07SxOLrA=;
 b=XVjDyTmpMNVSouaW12zb3WMTNxS7i9oRC94wJ6JWeJOG19GMpnbx8SZBv2VZgxOquJwJNA
 dS3vuJ6PQG9OjSajFRelIzT3DrlZGNNOjfmPY9uvF+WnVzgv7GdtSt37VhG1MJ/5pI3ok1
 N47V477PpdAD/Hwe1t3Nyliu/N4Ljz0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-Qor4mhAaNQSl_2KejwNmJA-1; Mon, 20 Jun 2022 22:59:04 -0400
X-MC-Unique: Qor4mhAaNQSl_2KejwNmJA-1
Received: by mail-lf1-f72.google.com with SMTP id
 i3-20020a056512318300b0047f86b47910so3585lfe.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 19:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dhNf5VQ2CZlb1zUdYetihyiK9C1Amm6yrig07SxOLrA=;
 b=1HrXxN/LE/5pWCvUjJvSzmIcpvfCccR09o7Vae2u7mOBjIISz6SDF5B2TH5X1UoOOp
 +Mr7Ksjfteo769THDhujnMvZ1pNkN49yw7lC+lT/IpTVg/8tH4ubMU/61W7Qt3qUH9U+
 ZXs7KaK74HrmD21A204FL0+TEh7RtohxNYYOpGoUfNO0KX93tacvD1VLWOonYXFsXR8M
 GXsroZchQnTO+asSkhbKzCzzn2WFxzL1XxvhTVf74moy2AkqnU/3kYCdKy+pjB8SMvXh
 qSGpR4ZhGkOAirBuFgodSk3VZ9sXFPUxSsV/KIe9Hc5psA9eEJC3YKHH3S119MMM/Zzr
 NeYA==
X-Gm-Message-State: AJIora9al764XKzDqUeGSuMjfSx9gqcLBT4ZI2VUyA6s2zZPa7qXwGXt
 vGAfCWkmL2/mkadVQeie1R01izRBBvwsR5TK8dfwsyfgDQsfeyTT7NKQ5ShxR1+bxztiLJpRP+i
 A2Yo4mizXnMzXgv8XmgEyUQak+T/Kw+//WYUqnrkxrdIaypCd9JWr0qrr0A==
X-Received: by 2002:a05:651c:895:b0:250:c5ec:bc89 with SMTP id
 d21-20020a05651c089500b00250c5ecbc89mr13499810ljq.251.1655780342878; 
 Mon, 20 Jun 2022 19:59:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s5BLy+ZqwEf9mB09ZKSQV92I6GPkiZ5JusIUOOeAvPSFUNj/tkmDvxSH81jDgGB5d0TqIUiNTGN8kE+P9NQhQ=
X-Received: by 2002:a05:651c:895:b0:250:c5ec:bc89 with SMTP id
 d21-20020a05651c089500b00250c5ecbc89mr13499797ljq.251.1655780342664; Mon, 20
 Jun 2022 19:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220616132725.50599-1-elic@nvidia.com>
 <20220616132725.50599-2-elic@nvidia.com>
 <CACGkMEue-X8-u0Z=EwUbBSV6vmomwNy52Tot3Zf+0pu4Pztutg@mail.gmail.com>
 <DM8PR12MB54004277F21D682A3EE6D1C1ABB09@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB54004277F21D682A3EE6D1C1ABB09@DM8PR12MB5400.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Jun 2022 10:58:51 +0800
Message-ID: <CACGkMEth7Nw4pwsa9zwmhacZ22Oue44gSa+YaCKF8qP_R+3gJw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] vdpa/mlx5: Implement susupend virtqueue callback
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>
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

On Mon, Jun 20, 2022 at 9:09 PM Eli Cohen <elic@nvidia.com> wrote:
>
> > -----Original Message-----
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Monday, June 20, 2022 11:56 AM
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: eperezma <eperezma@redhat.com>; mst <mst@redhat.com>; virtualization <virtualization@lists.linux-foundation.org>; linux-
> > kernel <linux-kernel@vger.kernel.org>; Si-Wei Liu <si-wei.liu@oracle.com>; Parav Pandit <parav@nvidia.com>
> > Subject: Re: [PATCH RFC 1/3] vdpa/mlx5: Implement susupend virtqueue callback
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
>
> It's already being held by mlx5_vdpa_suspend

Right, but I meant this seems kind of duplicated with set_cvq_ready(),
can we unify them? (We don't hold reslock there).

>
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
>
> Are you saying we should not allow carrier updates after the VQs have been suspended?
> Link state should not be related to suspension of VQs.

Yes, it's not related to the VQ but we suspend the device here. So we
probably need to flush the carrier work.

Thanks

>
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
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
