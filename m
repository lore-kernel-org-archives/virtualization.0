Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF76C43334
	for <virtualization@archiver.kernel.org>; Wed, 13 Jul 2022 03:29:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CBE2B40C40;
	Wed, 13 Jul 2022 03:29:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CBE2B40C40
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JvQiwVu7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oC6rJcMpX4Zz; Wed, 13 Jul 2022 03:29:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 147D64025F;
	Wed, 13 Jul 2022 03:29:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 147D64025F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBB2AC0035;
	Wed, 13 Jul 2022 03:29:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 124FBC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 03:29:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E0B8641B6B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 03:29:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E0B8641B6B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JvQiwVu7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KmM1rq5f5HV8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 03:29:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6A294419F9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A294419F9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 03:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657682977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3QQVGHiCE5MKmgZTyiKOvJGL8kakTxZI99KhXYZZc+Q=;
 b=JvQiwVu7wFBlZ5Z1BKVg0IbqFqeSK/FbzHO9DyyPLcJfMZ2RboBXcMKm+Im7+5eTbxtHKr
 mgwLKD2hGXo+bpjEJrPScrsuWlcxgKC7KSjrkAxEA0sWRibpEmocushLLiBgw90ukWPx1A
 vcxfr03Fw9PkwEqEnWyzGdRIEYfp/Lk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-e1RAB12lPXS1mVQtA6vHWg-1; Tue, 12 Jul 2022 23:29:35 -0400
X-MC-Unique: e1RAB12lPXS1mVQtA6vHWg-1
Received: by mail-lf1-f71.google.com with SMTP id
 t7-20020ac243a7000000b00489e8cb9450so2380888lfl.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 20:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3QQVGHiCE5MKmgZTyiKOvJGL8kakTxZI99KhXYZZc+Q=;
 b=LQMLgrfKr9AA3AfGO8MkCuuuyYaIoHhcIuT1N8oi3gCCslE9vf08mpiluH4Jzvesrh
 A3txNt4KEGSBovziOmA9mE5fEEYB4uJuVEyeqv1VwaPzy77484D3qcYRSE4PcrNHtUTL
 bWBOow1H2z3l/NysSd0XjABovazVgxAVBWFpYSKr9j6HSCMCI7qfS0F6X0T38LMbqJhT
 Zea56WclDzPfKmceMNYgXBgvOrVyWZIjOTfZMSGqyRuEm1zReQq7x63DDqkNXg2GIxc0
 yDjMHowOu9QX8z0iVBgJhoQkCwp4kt6vbczFpSZjzMzX2fjTuRgzM9vODc3xx0SwgI5Y
 eqDA==
X-Gm-Message-State: AJIora9suEkPgTOsZi3jxPCizFDJP1N3UNL+9zfjSotf+47kVTsIJj5M
 9BWrjIl9YeFWXn9gg+VQTuOuNuaU0o4sZEBtM4i3YCcun7Jzhkbni5b0qJX95WLV2PWyQq0MFj9
 ByNdctuqGoQdnd0S8P4rkATUaGH445LY+AO66eo9XdcY6pY1qjeNTwUqUOw==
X-Received: by 2002:ac2:50d1:0:b0:489:fb36:cde1 with SMTP id
 h17-20020ac250d1000000b00489fb36cde1mr679923lfm.411.1657682974325; 
 Tue, 12 Jul 2022 20:29:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vR++2/deF9gVb9a2Zd9gCVPFExHzk7dcWERBChP5SyrtGB86dwpXLnig8ahnOxWPZ3ryzHyDbEm/0qIO6boII=
X-Received: by 2002:ac2:50d1:0:b0:489:fb36:cde1 with SMTP id
 h17-20020ac250d1000000b00489fb36cde1mr679908lfm.411.1657682974086; Tue, 12
 Jul 2022 20:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220616132725.50599-1-elic@nvidia.com>
 <20220616132725.50599-2-elic@nvidia.com>
 <CACGkMEue-X8-u0Z=EwUbBSV6vmomwNy52Tot3Zf+0pu4Pztutg@mail.gmail.com>
 <CAJaqyWfTG_jVW6Vzf64QO=255kfwWKn4gCUMeGog-1shHx3O_g@mail.gmail.com>
 <CACGkMEtcs9e1NJ7ArkibQSrDN7j_eyciZo=yDfbd5Jsb4gvzZA@mail.gmail.com>
 <DM8PR12MB5400FDBB177693A55074D19EAB879@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CACGkMEu4iRHa_D+1jQHq65UZch-102-MhnRD22Umz94XP9+CJA@mail.gmail.com>
 <CAJaqyWcUUk1H2+aeoj7yAFKXSg1gdV2GzTdWUTAGi0AiW9r64w@mail.gmail.com>
In-Reply-To: <CAJaqyWcUUk1H2+aeoj7yAFKXSg1gdV2GzTdWUTAGi0AiW9r64w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 13 Jul 2022 11:29:22 +0800
Message-ID: <CACGkMEvGQrDdZ+g3jJF6kM=cTqi+tmxiddZYLGP6gMPKC2A68Q@mail.gmail.com>
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

On Tue, Jul 12, 2022 at 5:16 PM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Tue, Jul 12, 2022 at 10:14 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Jul 11, 2022 at 2:14 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Tuesday, June 21, 2022 6:05 AM
> > > > To: Eugenio Perez Martin <eperezma@redhat.com>
> > > > Cc: Eli Cohen <elic@nvidia.com>; mst <mst@redhat.com>; virtualization <virtualization@lists.linux-foundation.org>; linux-kernel
> > > > <linux-kernel@vger.kernel.org>; Si-Wei Liu <si-wei.liu@oracle.com>; Parav Pandit <parav@nvidia.com>
> > > > Subject: Re: [PATCH RFC 1/3] vdpa/mlx5: Implement susupend virtqueue callback
> > > >
> > > > On Mon, Jun 20, 2022 at 5:59 PM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Mon, Jun 20, 2022 at 10:56 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Jun 16, 2022 at 9:27 PM Eli Cohen <elic@nvidia.com> wrote:
> > > > > > >
> > > > > > > Implement the suspend callback allowing to suspend the virtqueues so
> > > > > > > they stop processing descriptors. This is required to allow the shadow
> > > > > > > virtqueue to kick in.
> > > > > > >
> > > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > > > ---
> > > > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 68 +++++++++++++++++++++++++++++-
> > > > > > >  include/linux/mlx5/mlx5_ifc_vdpa.h |  8 ++++
> > > > > > >  2 files changed, 75 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > index fb0b23e71383..ea4bc8a0cd25 100644
> > > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > @@ -895,6 +895,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> > > > > > >         if (err)
> > > > > > >                 goto err_cmd;
> > > > > > >
> > > > > > > +       mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT;
> > > > > > >         kfree(in);
> > > > > > >         mvq->virtq_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
> > > > > > >
> > > > > > > @@ -922,6 +923,7 @@ static void destroy_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq
> > > > > > >                 mlx5_vdpa_warn(&ndev->mvdev, "destroy virtqueue 0x%x\n", mvq->virtq_id);
> > > > > > >                 return;
> > > > > > >         }
> > > > > > > +       mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
> > > > > > >         umems_destroy(ndev, mvq);
> > > > > > >  }
> > > > > > >
> > > > > > > @@ -1121,6 +1123,20 @@ static int query_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueu
> > > > > > >         return err;
> > > > > > >  }
> > > > > > >
> > > > > > > +static bool is_valid_state_change(int oldstate, int newstate)
> > > > > > > +{
> > > > > > > +       switch (oldstate) {
> > > > > > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
> > > > > > > +               return newstate == MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY;
> > > > > > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
> > > > > > > +               return newstate == MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND;
> > > > > > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
> > > > > > > +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_ERR:
> > > > > > > +       default:
> > > > > > > +               return false;
> > > > > > > +       }
> > > > > > > +}
> > > > > > > +
> > > > > > >  static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int state)
> > > > > > >  {
> > > > > > >         int inlen = MLX5_ST_SZ_BYTES(modify_virtio_net_q_in);
> > > > > > > @@ -1130,6 +1146,12 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> > > > > > >         void *in;
> > > > > > >         int err;
> > > > > > >
> > > > > > > +       if (mvq->fw_state == MLX5_VIRTIO_NET_Q_OBJECT_NONE)
> > > > > > > +               return 0;
> > > > > > > +
> > > > > > > +       if (!is_valid_state_change(mvq->fw_state, state))
> > > > > > > +               return -EINVAL;
> > > > > > > +
> > > > > > >         in = kzalloc(inlen, GFP_KERNEL);
> > > > > > >         if (!in)
> > > > > > >                 return -ENOMEM;
> > > > > > > @@ -1991,6 +2013,7 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
> > > > > > >         struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > > > > >         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > > > >         struct mlx5_vdpa_virtqueue *mvq;
> > > > > > > +       int err;
> > > > > > >
> > > > > > >         if (!mvdev->actual_features)
> > > > > > >                 return;
> > > > > > > @@ -2004,8 +2027,16 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
> > > > > > >         }
> > > > > > >
> > > > > > >         mvq = &ndev->vqs[idx];
> > > > > > > -       if (!ready)
> > > > > > > +       if (!ready) {
> > > > > > >                 suspend_vq(ndev, mvq);
> > > > > > > +       } else {
> > > > > > > +               err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
> > > > > > > +               if (err) {
> > > > > > > +                       mlx5_vdpa_warn(mvdev, "modify VQ %d to ready failed (%d)\n", idx, err);
> > > > > > > +                       ready = false;
> > > > > > > +               }
> > > > > > > +       }
> > > > > > > +
> > > > > > >
> > > > > > >         mvq->ready = ready;
> > > > > > >  }
> > > > > > > @@ -2732,6 +2763,39 @@ static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, u16 idx,
> > > > > > >         return err;
> > > > > > >  }
> > > > > > >
> > > > > > > +static void mlx5_vdpa_cvq_suspend(struct mlx5_vdpa_dev *mvdev, bool suspend)
> > > > > > > +{
> > > > > > > +       struct mlx5_control_vq *cvq;
> > > > > > > +
> > > > > > > +       if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> > > > > > > +               return;
> > > > > > > +
> > > > > > > +       cvq = &mvdev->cvq;
> > > > > > > +       cvq->ready = !suspend;
> > > > > > > +}
> > > > > >
> > > > > > It looks to me we need to synchronize this with reslock. And this
> > > > > > probably deserve a dedicated fix.
> > > > > >
> > > > > > > +
> > > > > > > +static int mlx5_vdpa_suspend(struct vdpa_device *vdev, bool suspend)
> > > > > > > +{
> > > > > > > +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > > > > > +       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > > > > +       struct mlx5_vdpa_virtqueue *mvq;
> > > > > > > +       int i;
> > > > > > > +
> > > > > > > +       if (!suspend) {
> > > > > > > +               mlx5_vdpa_warn(mvdev, "Resume of virtqueues is not supported\n");
> > > > > > > +               return -EOPNOTSUPP;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       down_write(&ndev->reslock);
> > > > > > > +       for (i = 0; i < ndev->cur_num_vqs; i++) {
> > > > > > > +               mvq = &ndev->vqs[i];
> > > > > > > +               suspend_vq(ndev, mvq);
> > > > > > > +       }
> > > > > > > +       mlx5_vdpa_cvq_suspend(mvdev, suspend);
> > > > > >
> > > > > > Do we need to synchronize with the carrier work here? Otherwise we may
> > > > > > get config notification after suspending.
> > > > > >
> > > > > > > +       up_write(&ndev->reslock);
> > > > > > > +       return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > >  static const struct vdpa_config_ops mlx5_vdpa_ops = {
> > > > > > >         .set_vq_address = mlx5_vdpa_set_vq_address,
> > > > > > >         .set_vq_num = mlx5_vdpa_set_vq_num,
> > > > > > > @@ -2762,6 +2826,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
> > > > > > >         .get_generation = mlx5_vdpa_get_generation,
> > > > > > >         .set_map = mlx5_vdpa_set_map,
> > > > > > >         .free = mlx5_vdpa_free,
> > > > > > > +       .suspend = mlx5_vdpa_suspend,
> > > > > >
> > > > > > I don't see the vDPA bus patch to enable this method. Or anything I missed here?
> > > > > >
> > > > >
> > > > > Should we add
> > > > > Based-on: <20220526124338.36247-1-eperezma@redhat.com>
> > > > >
> > > > > To this series?
> > > >
> > > > Probably, but that series seems to support resume while this series doesn't.
> > > >
> > > > Any reason for this?
> > >
> > > I think Eugenio agreed that resume is not really required since we're going stop using this
> > > instance and migrate. In any case, we don't support resume for the hardware object
> > > though it could be simulated should it be absolutely necessary.
> >
> > This is fine if everything is fine during the live migration. But when
> > migration fails due to some reason, management (libvirt) may choose to
> > restart the device in the source.
> >
> > This means we should either
> >
> > 1) support resume in the parent
> > 2) emulate it in the qemu (with a lot of restoring of the states)
> >
>
> I think it should be handled in qemu (at least the POC reset the
> device), but I didn't exercise a lot of the failure paths there
> because, well, it was a POC :).

It looks like a must in the production environment. The failure is not
necessarily related to shadow virtqueue itself.

Thanks

>
> > And it is not only used for live migration, it could be used for vmstop/start.
> >
>
> I think it would be easier if we dedicate a feature flag for resuming
> the device in the future. Qemu could take advantage of it at some
> error paths of live migration, but less than it seems because it
> overrides things like ring addresses. And, obviously, in the
> vmstop/vmstart.
>
> Actually, net devices should be ok to restore with a full reset. The
> problem should be filesystems etc that are not part of vdpa at the
> moment.
>
> Thanks!
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
