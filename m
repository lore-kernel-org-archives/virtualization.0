Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F9BC43334
	for <virtualization@archiver.kernel.org>; Tue, 12 Jul 2022 08:14:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 986B56108C;
	Tue, 12 Jul 2022 08:14:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 986B56108C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jBd7LIVs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S3t8lI3JzLSm; Tue, 12 Jul 2022 08:14:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E73066103C;
	Tue, 12 Jul 2022 08:14:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E73066103C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F9A5C0033;
	Tue, 12 Jul 2022 08:14:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5335C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:14:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7E63461040
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:14:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E63461040
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kDqmy2TokLaR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:14:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 67CE36103C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 67CE36103C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657613691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=edEnIp4KEOYQimLV5gIofCXnTuRf4SrGccQllW6sGbY=;
 b=jBd7LIVsJqBKNWagQ7dF0e9ZoXCcfRrCznrOdMB7h8fSjpxx3L3SfI5AwSrt6c6zt+ALWA
 WI8Vvsy0aQvGoYpNMZsPCePi0w+VdG7TcmfmdRYiGTjzDuzwv5fkGTVIkvGgn94kYI48aX
 h+f8aM2t4QiPiYYViF4cJKZSwu8reKY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-VQjt2DsZOECbHsXPCzY46g-1; Tue, 12 Jul 2022 04:14:49 -0400
X-MC-Unique: VQjt2DsZOECbHsXPCzY46g-1
Received: by mail-lf1-f70.google.com with SMTP id
 d12-20020a056512368c00b00489f92be8c4so314887lfs.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 01:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=edEnIp4KEOYQimLV5gIofCXnTuRf4SrGccQllW6sGbY=;
 b=d93Ex7ehchxUIDo7kfXUQP60IrAN2rH4g6USDSjdo9lam6pWghqKL092bwY3/q3Sbj
 XEbeiTSmgERH0wGkKaBWc4mAZ2+ttQ0b/7htd4q3vbmF6UGhYafuiUaK7lurovruZmnj
 L/Qs0pUX40wXl8i62yHStR/sU7QyqSNrIuF3u9fMrkSsTZwzw3YGXgZ9DjUg7FHzHC6v
 JOqhyK/5MSZmF3qnzkBohEikoLI8lEblll2q574/fDrt8D9cipx4EgWuN0G6XfMDM+8x
 KmkzT7ogai3fwaDg2QVqLSxuNZZLhLcxDaPtpV3NOppax/fkKIdXB/quYb91S0L9DvLc
 x9Qw==
X-Gm-Message-State: AJIora89+L+Bp9MycOy6X8LEZgbFo0bER0gNkdGHPy8m+iaCYKZ04Hyj
 ngVaSyHlv6GFmHw+Gn1DEcT/ltyF8lvYhMF9XOAQSZAjf+6ZdXGL+227x8VVkLKy3tSCtRBHSuC
 ptPNcAgSxiTETRWNAq4C+AyrNrmUD+u6PZg/Jblndljeh45IDPCCZDwdX9Q==
X-Received: by 2002:a2e:557:0:b0:25d:466a:31b8 with SMTP id
 84-20020a2e0557000000b0025d466a31b8mr12375155ljf.243.1657613688259; 
 Tue, 12 Jul 2022 01:14:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tth8KnFTUZ1RSiClz+H8/Y2gvA8yKQwOrfRQJ2OzLl/3446yxITjXdriRgqt3CHvFf1fhDje0//E9rNPHZW4E=
X-Received: by 2002:a2e:557:0:b0:25d:466a:31b8 with SMTP id
 84-20020a2e0557000000b0025d466a31b8mr12375146ljf.243.1657613688028; Tue, 12
 Jul 2022 01:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220616132725.50599-1-elic@nvidia.com>
 <20220616132725.50599-2-elic@nvidia.com>
 <CACGkMEue-X8-u0Z=EwUbBSV6vmomwNy52Tot3Zf+0pu4Pztutg@mail.gmail.com>
 <CAJaqyWfTG_jVW6Vzf64QO=255kfwWKn4gCUMeGog-1shHx3O_g@mail.gmail.com>
 <CACGkMEtcs9e1NJ7ArkibQSrDN7j_eyciZo=yDfbd5Jsb4gvzZA@mail.gmail.com>
 <DM8PR12MB5400FDBB177693A55074D19EAB879@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5400FDBB177693A55074D19EAB879@DM8PR12MB5400.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Jul 2022 16:14:37 +0800
Message-ID: <CACGkMEu4iRHa_D+1jQHq65UZch-102-MhnRD22Umz94XP9+CJA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] vdpa/mlx5: Implement susupend virtqueue callback
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eugenio Perez Martin <eperezma@redhat.com>
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

On Mon, Jul 11, 2022 at 2:14 PM Eli Cohen <elic@nvidia.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Tuesday, June 21, 2022 6:05 AM
> > To: Eugenio Perez Martin <eperezma@redhat.com>
> > Cc: Eli Cohen <elic@nvidia.com>; mst <mst@redhat.com>; virtualization <virtualization@lists.linux-foundation.org>; linux-kernel
> > <linux-kernel@vger.kernel.org>; Si-Wei Liu <si-wei.liu@oracle.com>; Parav Pandit <parav@nvidia.com>
> > Subject: Re: [PATCH RFC 1/3] vdpa/mlx5: Implement susupend virtqueue callback
> >
> > On Mon, Jun 20, 2022 at 5:59 PM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Mon, Jun 20, 2022 at 10:56 AM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Thu, Jun 16, 2022 at 9:27 PM Eli Cohen <elic@nvidia.com> wrote:
> > > > >
> > > > > Implement the suspend callback allowing to suspend the virtqueues so
> > > > > they stop processing descriptors. This is required to allow the shadow
> > > > > virtqueue to kick in.
> > > > >
> > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > ---
> > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 68 +++++++++++++++++++++++++++++-
> > > > >  include/linux/mlx5/mlx5_ifc_vdpa.h |  8 ++++
> > > > >  2 files changed, 75 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > index fb0b23e71383..ea4bc8a0cd25 100644
> > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > @@ -895,6 +895,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> > > > >         if (err)
> > > > >                 goto err_cmd;
> > > > >
> > > > > +       mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT;
> > > > >         kfree(in);
> > > > >         mvq->virtq_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
> > > > >
> > > > > @@ -922,6 +923,7 @@ static void destroy_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq
> > > > >                 mlx5_vdpa_warn(&ndev->mvdev, "destroy virtqueue 0x%x\n", mvq->virtq_id);
> > > > >                 return;
> > > > >         }
> > > > > +       mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
> > > > >         umems_destroy(ndev, mvq);
> > > > >  }
> > > > >
> > > > > @@ -1121,6 +1123,20 @@ static int query_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueu
> > > > >         return err;
> > > > >  }
> > > > >
> > > > > +static bool is_valid_state_change(int oldstate, int newstate)
> > > > > +{
> > > > > +       switch (oldstate) {
> > > > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
> > > > > +               return newstate == MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY;
> > > > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
> > > > > +               return newstate == MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND;
> > > > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
> > > > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_ERR:
> > > > > +       default:
> > > > > +               return false;
> > > > > +       }
> > > > > +}
> > > > > +
> > > > >  static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int state)
> > > > >  {
> > > > >         int inlen = MLX5_ST_SZ_BYTES(modify_virtio_net_q_in);
> > > > > @@ -1130,6 +1146,12 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> > > > >         void *in;
> > > > >         int err;
> > > > >
> > > > > +       if (mvq->fw_state == MLX5_VIRTIO_NET_Q_OBJECT_NONE)
> > > > > +               return 0;
> > > > > +
> > > > > +       if (!is_valid_state_change(mvq->fw_state, state))
> > > > > +               return -EINVAL;
> > > > > +
> > > > >         in = kzalloc(inlen, GFP_KERNEL);
> > > > >         if (!in)
> > > > >                 return -ENOMEM;
> > > > > @@ -1991,6 +2013,7 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
> > > > >         struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > > >         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > >         struct mlx5_vdpa_virtqueue *mvq;
> > > > > +       int err;
> > > > >
> > > > >         if (!mvdev->actual_features)
> > > > >                 return;
> > > > > @@ -2004,8 +2027,16 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
> > > > >         }
> > > > >
> > > > >         mvq = &ndev->vqs[idx];
> > > > > -       if (!ready)
> > > > > +       if (!ready) {
> > > > >                 suspend_vq(ndev, mvq);
> > > > > +       } else {
> > > > > +               err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
> > > > > +               if (err) {
> > > > > +                       mlx5_vdpa_warn(mvdev, "modify VQ %d to ready failed (%d)\n", idx, err);
> > > > > +                       ready = false;
> > > > > +               }
> > > > > +       }
> > > > > +
> > > > >
> > > > >         mvq->ready = ready;
> > > > >  }
> > > > > @@ -2732,6 +2763,39 @@ static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, u16 idx,
> > > > >         return err;
> > > > >  }
> > > > >
> > > > > +static void mlx5_vdpa_cvq_suspend(struct mlx5_vdpa_dev *mvdev, bool suspend)
> > > > > +{
> > > > > +       struct mlx5_control_vq *cvq;
> > > > > +
> > > > > +       if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> > > > > +               return;
> > > > > +
> > > > > +       cvq = &mvdev->cvq;
> > > > > +       cvq->ready = !suspend;
> > > > > +}
> > > >
> > > > It looks to me we need to synchronize this with reslock. And this
> > > > probably deserve a dedicated fix.
> > > >
> > > > > +
> > > > > +static int mlx5_vdpa_suspend(struct vdpa_device *vdev, bool suspend)
> > > > > +{
> > > > > +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > > > +       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > > +       struct mlx5_vdpa_virtqueue *mvq;
> > > > > +       int i;
> > > > > +
> > > > > +       if (!suspend) {
> > > > > +               mlx5_vdpa_warn(mvdev, "Resume of virtqueues is not supported\n");
> > > > > +               return -EOPNOTSUPP;
> > > > > +       }
> > > > > +
> > > > > +       down_write(&ndev->reslock);
> > > > > +       for (i = 0; i < ndev->cur_num_vqs; i++) {
> > > > > +               mvq = &ndev->vqs[i];
> > > > > +               suspend_vq(ndev, mvq);
> > > > > +       }
> > > > > +       mlx5_vdpa_cvq_suspend(mvdev, suspend);
> > > >
> > > > Do we need to synchronize with the carrier work here? Otherwise we may
> > > > get config notification after suspending.
> > > >
> > > > > +       up_write(&ndev->reslock);
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > >  static const struct vdpa_config_ops mlx5_vdpa_ops = {
> > > > >         .set_vq_address = mlx5_vdpa_set_vq_address,
> > > > >         .set_vq_num = mlx5_vdpa_set_vq_num,
> > > > > @@ -2762,6 +2826,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
> > > > >         .get_generation = mlx5_vdpa_get_generation,
> > > > >         .set_map = mlx5_vdpa_set_map,
> > > > >         .free = mlx5_vdpa_free,
> > > > > +       .suspend = mlx5_vdpa_suspend,
> > > >
> > > > I don't see the vDPA bus patch to enable this method. Or anything I missed here?
> > > >
> > >
> > > Should we add
> > > Based-on: <20220526124338.36247-1-eperezma@redhat.com>
> > >
> > > To this series?
> >
> > Probably, but that series seems to support resume while this series doesn't.
> >
> > Any reason for this?
>
> I think Eugenio agreed that resume is not really required since we're going stop using this
> instance and migrate. In any case, we don't support resume for the hardware object
> though it could be simulated should it be absolutely necessary.

This is fine if everything is fine during the live migration. But when
migration fails due to some reason, management (libvirt) may choose to
restart the device in the source.

This means we should either

1) support resume in the parent
2) emulate it in the qemu (with a lot of restoring of the states)

And it is not only used for live migration, it could be used for vmstop/start.

Thanks

>
> >
> > (I don't see any blocker for this especially considering parents can
> > choose to do reset + set_vring_state etc.)
> >
> > Thanks
> >
> > >
> > > > Thanks
> > > >
> > > > >  };
> > > > >
> > > > >  static int query_mtu(struct mlx5_core_dev *mdev, u16 *mtu)
> > > > > @@ -2827,6 +2892,7 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
> > > > >                 mvq->index = i;
> > > > >                 mvq->ndev = ndev;
> > > > >                 mvq->fwqp.fw = true;
> > > > > +               mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
> > > > >         }
> > > > >         for (; i < ndev->mvdev.max_vqs; i++) {
> > > > >                 mvq = &ndev->vqs[i];
> > > > > diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > > > index 4414ed5b6ed2..423562f39d3c 100644
> > > > > --- a/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > > > +++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > > > @@ -150,6 +150,14 @@ enum {
> > > > >         MLX5_VIRTIO_NET_Q_OBJECT_STATE_ERR      = 0x3,
> > > > >  };
> > > > >
> > > > > +/* This indicates that the object was not created or has alreadyi
> > > > > + * been desroyed. It is very safe to assume that this object will never
> > > > > + * have so many states
> > > > > + */
> > > > > +enum {
> > > > > +       MLX5_VIRTIO_NET_Q_OBJECT_NONE = 0xffffffff
> > > > > +};
> > > > > +
> > > > >  enum {
> > > > >         MLX5_RQTC_LIST_Q_TYPE_RQ            = 0x0,
> > > > >         MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q  = 0x1,
> > > > > --
> > > > > 2.35.1
> > > > >
> > > >
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
