Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC74C43334
	for <virtualization@archiver.kernel.org>; Mon, 20 Jun 2022 08:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B40EC408EB;
	Mon, 20 Jun 2022 08:56:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B40EC408EB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HUsbwZ8R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kx5HiD-Dhfqh; Mon, 20 Jun 2022 08:56:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 84789408D8;
	Mon, 20 Jun 2022 08:56:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 84789408D8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F4EEC0032;
	Mon, 20 Jun 2022 08:56:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16D7CC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:56:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF4FA82EA5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:56:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF4FA82EA5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HUsbwZ8R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Whji7ea01IbR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:56:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 07C2F813B0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 07C2F813B0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655715388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xrcQNn+Ra/Wmk9UclwpSlnyoXDjxFRvBSfAIpCmWbBM=;
 b=HUsbwZ8RXNQXWfnxOHPavtSPdXfSDPmtt3kzmomBEw2IcvknaoTAWs0dhRBEOoi5f22I2r
 UU7UrE0madGQq+1ipzXHgoba7exdAa4/qqYl8JQHJHwHd1JtUX3Bb4kHedbGRpgwBdDODw
 nJ4iWxgNNYWzaFRx8Me5eGA2L/XzQ5Y=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-ONclkRtgPPWcMEhVANYKOA-1; Mon, 20 Jun 2022 04:56:25 -0400
X-MC-Unique: ONclkRtgPPWcMEhVANYKOA-1
Received: by mail-lf1-f71.google.com with SMTP id
 h35-20020a0565123ca300b00479113319f9so5240556lfv.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 01:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xrcQNn+Ra/Wmk9UclwpSlnyoXDjxFRvBSfAIpCmWbBM=;
 b=YXtEg6cay+xdS978osC3Zqy5mt26JWvcdvv9LnnNAOfYl7AwHKiYyVJALFuhMqTFNq
 4kj9bxeYa/7QYmixyk0g35TRxGI4F7evnei4ySGWDx9GizrCMLweKzrshRWybIqwVh5o
 y5v1OIyc3jiwiO+nAnodziMbyERn0boYm+WcEvS5CVj172q9xey7HWc1afhtkoTUHZGy
 MLJEKAifEYpg6DpOjmjCzVoPLTdvtnA0eXqu7xJKK7Ic+5aX5XUeonIbcpctjLtPE7B7
 NyuStVswpJUI31ye88NN5XaXuDZg9nXJjOjo4QcbaZ4t6ovFb6iFczp5HVyLCzi38lVx
 8Yhg==
X-Gm-Message-State: AJIora/I5Yq7cjdhSoovI1kbaSz4hr0sxQ6SQQyXp0dVAJzaqkir0rra
 n6x7KGVkQgEbvEiI117UFyXgxe6L91Zd7re3Qsik/Ogt1TIZDNxDQXNKJNHACV20mR3n17wS9yV
 tk2LTd4j80A04k7jZDAhi0FuqNsnYbwTSxVlYZDg/Ig9uUqg5Fea2SVTjgw==
X-Received: by 2002:a2e:3c11:0:b0:25a:7397:94ea with SMTP id
 j17-20020a2e3c11000000b0025a739794eamr317512lja.323.1655715383661; 
 Mon, 20 Jun 2022 01:56:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tpjJXgF3f2rNJJAuO7/ogDPQq7NS3aWvyPEEYwA0wIcZC8D9ot1Ib/elCPZiMD9rO8Q7lLni5edQHYV0gYp1s=
X-Received: by 2002:a2e:3c11:0:b0:25a:7397:94ea with SMTP id
 j17-20020a2e3c11000000b0025a739794eamr317504lja.323.1655715383436; Mon, 20
 Jun 2022 01:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220616132725.50599-1-elic@nvidia.com>
 <20220616132725.50599-2-elic@nvidia.com>
In-Reply-To: <20220616132725.50599-2-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Jun 2022 16:56:12 +0800
Message-ID: <CACGkMEue-X8-u0Z=EwUbBSV6vmomwNy52Tot3Zf+0pu4Pztutg@mail.gmail.com>
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

On Thu, Jun 16, 2022 at 9:27 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Implement the suspend callback allowing to suspend the virtqueues so
> they stop processing descriptors. This is required to allow the shadow
> virtqueue to kick in.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 68 +++++++++++++++++++++++++++++-
>  include/linux/mlx5/mlx5_ifc_vdpa.h |  8 ++++
>  2 files changed, 75 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index fb0b23e71383..ea4bc8a0cd25 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -895,6 +895,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
>         if (err)
>                 goto err_cmd;
>
> +       mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT;
>         kfree(in);
>         mvq->virtq_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
>
> @@ -922,6 +923,7 @@ static void destroy_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq
>                 mlx5_vdpa_warn(&ndev->mvdev, "destroy virtqueue 0x%x\n", mvq->virtq_id);
>                 return;
>         }
> +       mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
>         umems_destroy(ndev, mvq);
>  }
>
> @@ -1121,6 +1123,20 @@ static int query_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueu
>         return err;
>  }
>
> +static bool is_valid_state_change(int oldstate, int newstate)
> +{
> +       switch (oldstate) {
> +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
> +               return newstate == MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY;
> +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
> +               return newstate == MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND;
> +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
> +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_ERR:
> +       default:
> +               return false;
> +       }
> +}
> +
>  static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int state)
>  {
>         int inlen = MLX5_ST_SZ_BYTES(modify_virtio_net_q_in);
> @@ -1130,6 +1146,12 @@ static int modify_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
>         void *in;
>         int err;
>
> +       if (mvq->fw_state == MLX5_VIRTIO_NET_Q_OBJECT_NONE)
> +               return 0;
> +
> +       if (!is_valid_state_change(mvq->fw_state, state))
> +               return -EINVAL;
> +
>         in = kzalloc(inlen, GFP_KERNEL);
>         if (!in)
>                 return -ENOMEM;
> @@ -1991,6 +2013,7 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
>         struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>         struct mlx5_vdpa_virtqueue *mvq;
> +       int err;
>
>         if (!mvdev->actual_features)
>                 return;
> @@ -2004,8 +2027,16 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
>         }
>
>         mvq = &ndev->vqs[idx];
> -       if (!ready)
> +       if (!ready) {
>                 suspend_vq(ndev, mvq);
> +       } else {
> +               err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
> +               if (err) {
> +                       mlx5_vdpa_warn(mvdev, "modify VQ %d to ready failed (%d)\n", idx, err);
> +                       ready = false;
> +               }
> +       }
> +
>
>         mvq->ready = ready;
>  }
> @@ -2732,6 +2763,39 @@ static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, u16 idx,
>         return err;
>  }
>
> +static void mlx5_vdpa_cvq_suspend(struct mlx5_vdpa_dev *mvdev, bool suspend)
> +{
> +       struct mlx5_control_vq *cvq;
> +
> +       if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> +               return;
> +
> +       cvq = &mvdev->cvq;
> +       cvq->ready = !suspend;
> +}

It looks to me we need to synchronize this with reslock. And this
probably deserve a dedicated fix.

> +
> +static int mlx5_vdpa_suspend(struct vdpa_device *vdev, bool suspend)
> +{
> +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> +       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> +       struct mlx5_vdpa_virtqueue *mvq;
> +       int i;
> +
> +       if (!suspend) {
> +               mlx5_vdpa_warn(mvdev, "Resume of virtqueues is not supported\n");
> +               return -EOPNOTSUPP;
> +       }
> +
> +       down_write(&ndev->reslock);
> +       for (i = 0; i < ndev->cur_num_vqs; i++) {
> +               mvq = &ndev->vqs[i];
> +               suspend_vq(ndev, mvq);
> +       }
> +       mlx5_vdpa_cvq_suspend(mvdev, suspend);

Do we need to synchronize with the carrier work here? Otherwise we may
get config notification after suspending.

> +       up_write(&ndev->reslock);
> +       return 0;
> +}
> +
>  static const struct vdpa_config_ops mlx5_vdpa_ops = {
>         .set_vq_address = mlx5_vdpa_set_vq_address,
>         .set_vq_num = mlx5_vdpa_set_vq_num,
> @@ -2762,6 +2826,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
>         .get_generation = mlx5_vdpa_get_generation,
>         .set_map = mlx5_vdpa_set_map,
>         .free = mlx5_vdpa_free,
> +       .suspend = mlx5_vdpa_suspend,

I don't see the vDPA bus patch to enable this method. Or anything I missed here?

Thanks

>  };
>
>  static int query_mtu(struct mlx5_core_dev *mdev, u16 *mtu)
> @@ -2827,6 +2892,7 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
>                 mvq->index = i;
>                 mvq->ndev = ndev;
>                 mvq->fwqp.fw = true;
> +               mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
>         }
>         for (; i < ndev->mvdev.max_vqs; i++) {
>                 mvq = &ndev->vqs[i];
> diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5_ifc_vdpa.h
> index 4414ed5b6ed2..423562f39d3c 100644
> --- a/include/linux/mlx5/mlx5_ifc_vdpa.h
> +++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
> @@ -150,6 +150,14 @@ enum {
>         MLX5_VIRTIO_NET_Q_OBJECT_STATE_ERR      = 0x3,
>  };
>
> +/* This indicates that the object was not created or has alreadyi
> + * been desroyed. It is very safe to assume that this object will never
> + * have so many states
> + */
> +enum {
> +       MLX5_VIRTIO_NET_Q_OBJECT_NONE = 0xffffffff
> +};
> +
>  enum {
>         MLX5_RQTC_LIST_Q_TYPE_RQ            = 0x0,
>         MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q  = 0x1,
> --
> 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
