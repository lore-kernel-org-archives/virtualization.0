Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A017EEB64D9
	for <virtualization@archiver.kernel.org>; Wed, 12 Jul 2023 08:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 224E340467;
	Wed, 12 Jul 2023 08:02:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 224E340467
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hqEwpiwt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tNqcyaX1qaPJ; Wed, 12 Jul 2023 08:02:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 203A840192;
	Wed, 12 Jul 2023 08:02:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 203A840192
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07894C0071;
	Wed, 12 Jul 2023 08:02:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9965C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A21C64186D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:02:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A21C64186D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hqEwpiwt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mZMjCYisk9rh
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:01:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B55441856
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B55441856
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689148917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K1kRAK006ctKrR77aTHDl6Mckc16Ck68D7m4TBYh8nc=;
 b=hqEwpiwt1ToA1zoL5VPZOz9U3SekXl1qSN06/MYgkIBz/slnitmW8DaxOU2970Mwew+0/j
 PPIDfQsvGCAJg9Y2OmCz6qhIt2EWgUdt9+3mKAk2FrOTpJJj2qI/V3E/hekQJnY5zsSxJg
 1f6hDJxXLqsTsuRT7KyYwz3KlyjQe4Q=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-CZDsTYYDNNq90oEBGdFD6A-1; Wed, 12 Jul 2023 04:01:53 -0400
X-MC-Unique: CZDsTYYDNNq90oEBGdFD6A-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b6fbed5189so63533451fa.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 01:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689148912; x=1691740912;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K1kRAK006ctKrR77aTHDl6Mckc16Ck68D7m4TBYh8nc=;
 b=eXXozOfwFqdlap7322n/6LQvkjpyJ3vj5ifZJQj5sHELVucwtvcYotuCDK5wKdiRso
 FsD2bgF9uU/tyv8oWmADitqdaHZfyAzVwo/O0Hq+5I5AM9LVSjQZ2Ofogao5aTGLuuXN
 x2G/QDCwJASgUc28Z4Nn8jc5m+Y2ebmXgXRV4ORxI9NG3B2YnEj6cBL44YVl7Ql1flXC
 ctDGC9hcyCdZhICeoYNMt9swz7KQKOqxk7HBY593KM9Bcsx1YY2dkhYzf/cO+Eu+LMGp
 duNBt0CfxFv7XtnnnaFIUxA5oZvQ9KkHq1c3cwyblofGhaJ6Z2gfm5mwTZfojsNstwDx
 eH3A==
X-Gm-Message-State: ABy/qLbYBy5X4EEieTR6kYtLartZM11795iXILC4SOu5kob5RpPxEozJ
 neiVQKZJjU59QpfgLsRwuW4j/jY7A5H+TsJQuzdPsA5FUNtjC9rEgy5WnnnT6WBF8SPcMbRkh3k
 0tFKoZ670J5/WOvyvtmjVCqMMdWV5ssXPE7rXajXsWviM0P2sYl5xJTKV9g==
X-Received: by 2002:a2e:6e19:0:b0:2b6:f009:d1b with SMTP id
 j25-20020a2e6e19000000b002b6f0090d1bmr15118891ljc.49.1689148911946; 
 Wed, 12 Jul 2023 01:01:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH0hNXAq9Ko8oi/1zPPeXxp7MfU4FahJDeBu/R23YStQl+9MxXqcyIT2tbEU+3aGINMhrZNxYDnb77j9asofSY=
X-Received: by 2002:a2e:6e19:0:b0:2b6:f009:d1b with SMTP id
 j25-20020a2e6e19000000b002b6f0090d1bmr15118863ljc.49.1689148911648; Wed, 12
 Jul 2023 01:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230710092005.5062-1-gavinl@nvidia.com>
 <20230710092005.5062-4-gavinl@nvidia.com>
In-Reply-To: <20230710092005.5062-4-gavinl@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Jul 2023 16:01:40 +0800
Message-ID: <CACGkMEvKd4PRJpRv6=mvL2XAd6-xaVok86=nhsFie-T-Dchfpw@mail.gmail.com>
Subject: Re: [PATCH net-next V1 3/4] virtio_net: support per queue interrupt
 coalesce command
To: Gavin Li <gavinl@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, hawk@kernel.org, daniel@iogearbox.net,
 mst@redhat.com, netdev@vger.kernel.org, john.fastabend@gmail.com,
 ast@kernel.org, edumazet@google.com, jiri@nvidia.com, kuba@kernel.org,
 bpf@vger.kernel.org, pabeni@redhat.com,
 virtualization@lists.linux-foundation.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============3695772543556782458=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============3695772543556782458==
Content-Type: multipart/alternative; boundary="000000000000da1d1d060045a0ba"

--000000000000da1d1d060045a0ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 5:21=E2=80=AFPM Gavin Li <gavinl@nvidia.com> wrote:

> Add interrupt_coalesce config in send_queue and receive_queue to cache us=
er
> config.
>
> Send per virtqueue interrupt moderation config to underline device in ord=
er
> to have more efficient interrupt moderation and cpu utilization of guest
> VM.
>
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/virtio_net.c        | 117 ++++++++++++++++++++++++++++----
>  include/uapi/linux/virtio_net.h |  14 ++++
>  2 files changed, 119 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 802ed21453f5..333a38e1941f 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -144,6 +144,8 @@ struct send_queue {
>
>         struct virtnet_sq_stats stats;
>
> +       struct virtnet_interrupt_coalesce intr_coal;
> +
>         struct napi_struct napi;
>
>         /* Record whether sq is in reset state. */
> @@ -161,6 +163,8 @@ struct receive_queue {
>
>         struct virtnet_rq_stats stats;
>
> +       struct virtnet_interrupt_coalesce intr_coal;
> +
>         /* Chain pages by the private ptr. */
>         struct page *pages;
>
> @@ -3078,6 +3082,56 @@ static int virtnet_send_notf_coal_cmds(struct
> virtnet_info *vi,
>         return 0;
>  }
>
> +static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
> +                                        u16 vqn, u32 max_usecs, u32
> max_packets)
> +{
> +       struct virtio_net_ctrl_coal_vq coal_vq =3D {};
> +       struct scatterlist sgs;
> +
> +       coal_vq.vqn =3D cpu_to_le16(vqn);
> +       coal_vq.coal.max_usecs =3D cpu_to_le32(max_usecs);
> +       coal_vq.coal.max_packets =3D cpu_to_le32(max_packets);
> +       sg_init_one(&sgs, &coal_vq, sizeof(coal_vq));
> +
> +       if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
> +                                 VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
> +                                 &sgs))
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
> +                                         struct ethtool_coalesce *ec,
> +                                         u16 queue)
> +{
> +       int err;
> +
> +       if (ec->rx_coalesce_usecs || ec->rx_max_coalesced_frames) {
> +               err =3D virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
> +                                                   ec->rx_coalesce_usecs=
,
> +
>  ec->rx_max_coalesced_frames);
> +               if (err)
> +                       return err;
> +               /* Save parameters */
> +               vi->rq[queue].intr_coal.max_usecs =3D ec->rx_coalesce_use=
cs;
> +               vi->rq[queue].intr_coal.max_packets =3D
> ec->rx_max_coalesced_frames;
> +       }
> +
> +       if (ec->tx_coalesce_usecs || ec->tx_max_coalesced_frames) {
> +               err =3D virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
> +                                                   ec->tx_coalesce_usecs=
,
> +
>  ec->tx_max_coalesced_frames);
> +               if (err)
> +                       return err;
> +               /* Save parameters */
> +               vi->sq[queue].intr_coal.max_usecs =3D ec->tx_coalesce_use=
cs;
> +               vi->sq[queue].intr_coal.max_packets =3D
> ec->tx_max_coalesced_frames;
> +       }
> +
> +       return 0;
> +}
> +
>  static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
>  {
>         /* usecs coalescing is supported only if VIRTIO_NET_F_NOTF_COAL
> @@ -3094,23 +3148,36 @@ static int virtnet_coal_params_supported(struct
> ethtool_coalesce *ec)
>  }
>
>  static int virtnet_set_coalesce_one(struct net_device *dev,
> -                                   struct ethtool_coalesce *ec)
> +                                   struct ethtool_coalesce *ec,
> +                                   bool per_queue,
> +                                   u32 queue)
>  {
>         struct virtnet_info *vi =3D netdev_priv(dev);
> -       int ret, i, napi_weight;
> +       int queue_count =3D per_queue ? 1 : vi->max_queue_pairs;
> +       int queue_number =3D per_queue ? queue : 0;
>         bool update_napi =3D false;
> +       int ret, i, napi_weight;
> +
> +       if (queue >=3D vi->max_queue_pairs)
> +               return -EINVAL;
>
>         /* Can't change NAPI weight if the link is up */
>         napi_weight =3D ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : =
0;
> -       if (napi_weight ^ vi->sq[0].napi.weight) {
> -               if (dev->flags & IFF_UP)
> -                       return -EBUSY;
> -               else
> +       for (i =3D queue_number; i < queue_count; i++) {
> +               if (napi_weight ^ vi->sq[i].napi.weight) {
> +                       if (dev->flags & IFF_UP)
> +                               return -EBUSY;
> +
>                         update_napi =3D true;
> +                       queue_number =3D i;
>


This seems to assume all queues that belong to [queue_number, queue_count)
need an updating of the NAPI which is not necessarily the case.  Worth a
comment to mention that the updating of the NAPI might not be necessary.

Thanks


> +                       break;
> +               }
>         }
>
> -       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
> +       if (!per_queue && virtio_has_feature(vi->vdev,
> VIRTIO_NET_F_NOTF_COAL))
>                 ret =3D virtnet_send_notf_coal_cmds(vi, ec);
> +       else if (per_queue && virtio_has_feature(vi->vdev,
> VIRTIO_NET_F_VQ_NOTF_COAL))
> +               ret =3D virtnet_send_notf_coal_vq_cmds(vi, ec, queue);
>         else
>                 ret =3D virtnet_coal_params_supported(ec);
>
> @@ -3118,7 +3185,7 @@ static int virtnet_set_coalesce_one(struct
> net_device *dev,
>                 return ret;
>
>         if (update_napi) {
> -               for (i =3D 0; i < vi->max_queue_pairs; i++)
> +               for (i =3D queue_number; i < queue_count; i++)
>                         vi->sq[i].napi.weight =3D napi_weight;
>         }
>
> @@ -3130,19 +3197,29 @@ static int virtnet_set_coalesce(struct net_device
> *dev,
>                                 struct kernel_ethtool_coalesce
> *kernel_coal,
>                                 struct netlink_ext_ack *extack)
>  {
> -       return virtnet_set_coalesce_one(dev, ec);
> +       return virtnet_set_coalesce_one(dev, ec, false, 0);
>  }
>
>  static int virtnet_get_coalesce_one(struct net_device *dev,
> -                                   struct ethtool_coalesce *ec)
> +                                   struct ethtool_coalesce *ec,
> +                                   bool per_queue,
> +                                   u32 queue)
>  {
>         struct virtnet_info *vi =3D netdev_priv(dev);
>
> -       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
> +       if (queue >=3D vi->max_queue_pairs)
> +               return -EINVAL;
> +
> +       if (!per_queue && virtio_has_feature(vi->vdev,
> VIRTIO_NET_F_NOTF_COAL)) {
>                 ec->rx_coalesce_usecs =3D vi->intr_coal_rx.max_usecs;
>                 ec->tx_coalesce_usecs =3D vi->intr_coal_tx.max_usecs;
>                 ec->tx_max_coalesced_frames =3D vi->intr_coal_tx.max_pack=
ets;
>                 ec->rx_max_coalesced_frames =3D vi->intr_coal_rx.max_pack=
ets;
> +       } else if (per_queue && virtio_has_feature(vi->vdev,
> VIRTIO_NET_F_VQ_NOTF_COAL)) {
> +               ec->rx_coalesce_usecs =3D vi->rq[queue].intr_coal.max_use=
cs;
> +               ec->tx_coalesce_usecs =3D vi->sq[queue].intr_coal.max_use=
cs;
> +               ec->tx_max_coalesced_frames =3D
> vi->sq[queue].intr_coal.max_packets;
> +               ec->rx_max_coalesced_frames =3D
> vi->rq[queue].intr_coal.max_packets;
>         } else {
>                 ec->rx_max_coalesced_frames =3D 1;
>
> @@ -3158,7 +3235,21 @@ static int virtnet_get_coalesce(struct net_device
> *dev,
>                                 struct kernel_ethtool_coalesce
> *kernel_coal,
>                                 struct netlink_ext_ack *extack)
>  {
> -       return virtnet_get_coalesce_one(dev, ec);
> +       return virtnet_get_coalesce_one(dev, ec, false, 0);
> +}
> +
> +static int virtnet_set_per_queue_coalesce(struct net_device *dev,
> +                                         u32 queue,
> +                                         struct ethtool_coalesce *ec)
> +{
> +       return virtnet_set_coalesce_one(dev, ec, true, queue);
> +}
> +
> +static int virtnet_get_per_queue_coalesce(struct net_device *dev,
> +                                         u32 queue,
> +                                         struct ethtool_coalesce *ec)
> +{
> +       return virtnet_get_coalesce_one(dev, ec, true, queue);
>  }
>
>  static void virtnet_init_settings(struct net_device *dev)
> @@ -3291,6 +3382,8 @@ static const struct ethtool_ops virtnet_ethtool_ops
> =3D {
>         .set_link_ksettings =3D virtnet_set_link_ksettings,
>         .set_coalesce =3D virtnet_set_coalesce,
>         .get_coalesce =3D virtnet_get_coalesce,
> +       .set_per_queue_coalesce =3D virtnet_set_per_queue_coalesce,
> +       .get_per_queue_coalesce =3D virtnet_get_per_queue_coalesce,
>         .get_rxfh_key_size =3D virtnet_get_rxfh_key_size,
>         .get_rxfh_indir_size =3D virtnet_get_rxfh_indir_size,
>         .get_rxfh =3D virtnet_get_rxfh,
> diff --git a/include/uapi/linux/virtio_net.h
> b/include/uapi/linux/virtio_net.h
> index 12c1c9699935..cc65ef0f3c3e 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -56,6 +56,7 @@
>  #define VIRTIO_NET_F_MQ        22      /* Device supports Receive Flow
>                                          * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23  /* Set MAC address */
> +#define VIRTIO_NET_F_VQ_NOTF_COAL 52   /* Device supports virtqueue
> notification coalescing */
>  #define VIRTIO_NET_F_NOTF_COAL 53      /* Device supports notifications
> coalescing */
>  #define VIRTIO_NET_F_GUEST_USO4        54      /* Guest can handle USOv4
> in. */
>  #define VIRTIO_NET_F_GUEST_USO6        55      /* Guest can handle USOv6
> in. */
> @@ -391,5 +392,18 @@ struct virtio_net_ctrl_coal_rx {
>  };
>
>  #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET               1
> +#define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET               2
> +#define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET               3
> +
> +struct virtio_net_ctrl_coal {
> +       __le32 max_packets;
> +       __le32 max_usecs;
> +};
> +
> +struct  virtio_net_ctrl_coal_vq {
> +       __le16 vqn;
> +       __le16 reserved;
> +       struct virtio_net_ctrl_coal coal;
> +};
>
>  #endif /* _UAPI_LINUX_VIRTIO_NET_H */
> --
> 2.39.1
>
>

--000000000000da1d1d060045a0ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIE1vbiwgSnVs
IDEwLCAyMDIzIGF0IDU6MjHigK9QTSBHYXZpbiBMaSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmdhdmlu
bEBudmlkaWEuY29tIj5nYXZpbmxAbnZpZGlhLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHgg
MC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0
OjFleCI+QWRkIGludGVycnVwdF9jb2FsZXNjZSBjb25maWcgaW4gc2VuZF9xdWV1ZSBhbmQgcmVj
ZWl2ZV9xdWV1ZSB0byBjYWNoZSB1c2VyPGJyPg0KY29uZmlnLjxicj4NCjxicj4NClNlbmQgcGVy
IHZpcnRxdWV1ZSBpbnRlcnJ1cHQgbW9kZXJhdGlvbiBjb25maWcgdG8gdW5kZXJsaW5lIGRldmlj
ZSBpbiBvcmRlcjxicj4NCnRvIGhhdmUgbW9yZSBlZmZpY2llbnQgaW50ZXJydXB0IG1vZGVyYXRp
b24gYW5kIGNwdSB1dGlsaXphdGlvbiBvZiBndWVzdDxicj4NClZNLjxicj4NCjxicj4NClNpZ25l
ZC1vZmYtYnk6IEdhdmluIExpICZsdDs8YSBocmVmPSJtYWlsdG86Z2F2aW5sQG52aWRpYS5jb20i
IHRhcmdldD0iX2JsYW5rIj5nYXZpbmxAbnZpZGlhLmNvbTwvYT4mZ3Q7PGJyPg0KUmV2aWV3ZWQt
Ynk6IERyYWdvcyBUYXR1bGVhICZsdDs8YSBocmVmPSJtYWlsdG86ZHRhdHVsZWFAbnZpZGlhLmNv
bSIgdGFyZ2V0PSJfYmxhbmsiPmR0YXR1bGVhQG52aWRpYS5jb208L2E+Jmd0Ozxicj4NClJldmll
d2VkLWJ5OiBKaXJpIFBpcmtvICZsdDs8YSBocmVmPSJtYWlsdG86amlyaUBudmlkaWEuY29tIiB0
YXJnZXQ9Il9ibGFuayI+amlyaUBudmlkaWEuY29tPC9hPiZndDs8YnI+DQotLS08YnI+DQrCoGRy
aXZlcnMvbmV0L3ZpcnRpb19uZXQuY8KgIMKgIMKgIMKgIHwgMTE3ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tPGJyPg0KwqBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oIHzC
oCAxNCArKysrPGJyPg0KwqAyIGZpbGVzIGNoYW5nZWQsIDExOSBpbnNlcnRpb25zKCspLCAxMiBk
ZWxldGlvbnMoLSk8YnI+DQo8YnI+DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jPGJyPg0KaW5kZXggODAyZWQyMTQ1M2Y1Li4z
MzNhMzhlMTk0MWYgMTAwNjQ0PGJyPg0KLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jPGJy
Pg0KKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jPGJyPg0KQEAgLTE0NCw2ICsxNDQsOCBA
QCBzdHJ1Y3Qgc2VuZF9xdWV1ZSB7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgc3RydWN0IHZpcnRu
ZXRfc3Ffc3RhdHMgc3RhdHM7PGJyPg0KPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IHZpcnRuZXRf
aW50ZXJydXB0X2NvYWxlc2NlIGludHJfY29hbDs8YnI+DQorPGJyPg0KwqAgwqAgwqAgwqAgc3Ry
dWN0IG5hcGlfc3RydWN0IG5hcGk7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgLyogUmVjb3JkIHdo
ZXRoZXIgc3EgaXMgaW4gcmVzZXQgc3RhdGUuICovPGJyPg0KQEAgLTE2MSw2ICsxNjMsOCBAQCBz
dHJ1Y3QgcmVjZWl2ZV9xdWV1ZSB7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgc3RydWN0IHZpcnRu
ZXRfcnFfc3RhdHMgc3RhdHM7PGJyPg0KPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IHZpcnRuZXRf
aW50ZXJydXB0X2NvYWxlc2NlIGludHJfY29hbDs8YnI+DQorPGJyPg0KwqAgwqAgwqAgwqAgLyog
Q2hhaW4gcGFnZXMgYnkgdGhlIHByaXZhdGUgcHRyLiAqLzxicj4NCsKgIMKgIMKgIMKgIHN0cnVj
dCBwYWdlICpwYWdlczs8YnI+DQo8YnI+DQpAQCAtMzA3OCw2ICszMDgyLDU2IEBAIHN0YXRpYyBp
bnQgdmlydG5ldF9zZW5kX25vdGZfY29hbF9jbWRzKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLDxi
cj4NCsKgIMKgIMKgIMKgIHJldHVybiAwOzxicj4NCsKgfTxicj4NCjxicj4NCitzdGF0aWMgaW50
IHZpcnRuZXRfc2VuZF9jdHJsX2NvYWxfdnFfY21kKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB1MTYgdnFuLCB1MzIgbWF4X3VzZWNzLCB1MzIgbWF4X3BhY2tldHMpPGJyPg0KK3s8
YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgdmlydGlvX25ldF9jdHJsX2NvYWxfdnEgY29hbF92cSA9
IHt9Ozxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBzY2F0dGVybGlzdCBzZ3M7PGJyPg0KKzxicj4N
CivCoCDCoCDCoCDCoGNvYWxfdnEudnFuID0gY3B1X3RvX2xlMTYodnFuKTs8YnI+DQorwqAgwqAg
wqAgwqBjb2FsX3ZxLmNvYWwubWF4X3VzZWNzID0gY3B1X3RvX2xlMzIobWF4X3VzZWNzKTs8YnI+
DQorwqAgwqAgwqAgwqBjb2FsX3ZxLmNvYWwubWF4X3BhY2tldHMgPSBjcHVfdG9fbGUzMihtYXhf
cGFja2V0cyk7PGJyPg0KK8KgIMKgIMKgIMKgc2dfaW5pdF9vbmUoJmFtcDtzZ3MsICZhbXA7Y29h
bF92cSwgc2l6ZW9mKGNvYWxfdnEpKTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKCF2aXJ0
bmV0X3NlbmRfY29tbWFuZCh2aSwgVklSVElPX05FVF9DVFJMX05PVEZfQ09BTCw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBWSVJUSU9fTkVU
X0NUUkxfTk9URl9DT0FMX1ZRX1NFVCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmYW1wO3NncykpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmV0dXJuIC1FSU5WQUw7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHJldHVybiAwOzxi
cj4NCit9PGJyPg0KKzxicj4NCitzdGF0aWMgaW50IHZpcnRuZXRfc2VuZF9ub3RmX2NvYWxfdnFf
Y21kcyhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3QgZXRodG9vbF9j
b2FsZXNjZSAqZWMsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdTE2IHF1ZXVlKTxicj4NCit7PGJyPg0KK8KgIMKgIMKg
IMKgaW50IGVycjs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKGVjLSZndDtyeF9jb2FsZXNj
ZV91c2VjcyB8fCBlYy0mZ3Q7cnhfbWF4X2NvYWxlc2NlZF9mcmFtZXMpIHs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBlcnIgPSB2aXJ0bmV0X3NlbmRfY3RybF9jb2FsX3ZxX2NtZCh2aSwg
cnhxMnZxKHF1ZXVlKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlYy0mZ3Q7cnhfY29hbGVz
Y2VfdXNlY3MsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZWMtJmd0O3J4X21heF9jb2FsZXNj
ZWRfZnJhbWVzKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoZXJyKTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBlcnI7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgLyogU2F2ZSBwYXJhbWV0ZXJzICovPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgdmktJmd0O3JxW3F1ZXVlXS5pbnRyX2NvYWwubWF4X3VzZWNzID0gZWMtJmd0
O3J4X2NvYWxlc2NlX3VzZWNzOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHZpLSZndDty
cVtxdWV1ZV0uaW50cl9jb2FsLm1heF9wYWNrZXRzID0gZWMtJmd0O3J4X21heF9jb2FsZXNjZWRf
ZnJhbWVzOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKGVj
LSZndDt0eF9jb2FsZXNjZV91c2VjcyB8fCBlYy0mZ3Q7dHhfbWF4X2NvYWxlc2NlZF9mcmFtZXMp
IHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlcnIgPSB2aXJ0bmV0X3NlbmRfY3RybF9j
b2FsX3ZxX2NtZCh2aSwgdHhxMnZxKHF1ZXVlKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBl
Yy0mZ3Q7dHhfY29hbGVzY2VfdXNlY3MsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZWMtJmd0
O3R4X21heF9jb2FsZXNjZWRfZnJhbWVzKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
ZiAoZXJyKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBl
cnI7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogU2F2ZSBwYXJhbWV0ZXJzICovPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdmktJmd0O3NxW3F1ZXVlXS5pbnRyX2NvYWwubWF4
X3VzZWNzID0gZWMtJmd0O3R4X2NvYWxlc2NlX3VzZWNzOzxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHZpLSZndDtzcVtxdWV1ZV0uaW50cl9jb2FsLm1heF9wYWNrZXRzID0gZWMtJmd0O3R4
X21heF9jb2FsZXNjZWRfZnJhbWVzOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8Kg
IMKgIMKgIMKgcmV0dXJuIDA7PGJyPg0KK308YnI+DQorPGJyPg0KwqBzdGF0aWMgaW50IHZpcnRu
ZXRfY29hbF9wYXJhbXNfc3VwcG9ydGVkKHN0cnVjdCBldGh0b29sX2NvYWxlc2NlICplYyk8YnI+
DQrCoHs8YnI+DQrCoCDCoCDCoCDCoCAvKiB1c2VjcyBjb2FsZXNjaW5nIGlzIHN1cHBvcnRlZCBv
bmx5IGlmIFZJUlRJT19ORVRfRl9OT1RGX0NPQUw8YnI+DQpAQCAtMzA5NCwyMyArMzE0OCwzNiBA
QCBzdGF0aWMgaW50IHZpcnRuZXRfY29hbF9wYXJhbXNfc3VwcG9ydGVkKHN0cnVjdCBldGh0b29s
X2NvYWxlc2NlICplYyk8YnI+DQrCoH08YnI+DQo8YnI+DQrCoHN0YXRpYyBpbnQgdmlydG5ldF9z
ZXRfY29hbGVzY2Vfb25lKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RydWN0IGV0aHRvb2xf
Y29hbGVzY2UgKmVjKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHN0cnVjdCBldGh0b29sX2NvYWxlc2NlICplYyw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBib29sIHBlcl9x
dWV1ZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB1MzIgcXVldWUpPGJyPg0KwqB7PGJyPg0KwqAgwqAgwqAgwqAgc3RydWN0IHZpcnRu
ZXRfaW5mbyAqdmkgPSBuZXRkZXZfcHJpdihkZXYpOzxicj4NCi3CoCDCoCDCoCDCoGludCByZXQs
IGksIG5hcGlfd2VpZ2h0Ozxicj4NCivCoCDCoCDCoCDCoGludCBxdWV1ZV9jb3VudCA9IHBlcl9x
dWV1ZSA/IDEgOiB2aS0mZ3Q7bWF4X3F1ZXVlX3BhaXJzOzxicj4NCivCoCDCoCDCoCDCoGludCBx
dWV1ZV9udW1iZXIgPSBwZXJfcXVldWUgPyBxdWV1ZSA6IDA7PGJyPg0KwqAgwqAgwqAgwqAgYm9v
bCB1cGRhdGVfbmFwaSA9IGZhbHNlOzxicj4NCivCoCDCoCDCoCDCoGludCByZXQsIGksIG5hcGlf
d2VpZ2h0Ozxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBpZiAocXVldWUgJmd0Oz0gdmktJmd0O21h
eF9xdWV1ZV9wYWlycyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLUVJTlZB
TDs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCAvKiBDYW4mIzM5O3QgY2hhbmdlIE5BUEkgd2VpZ2h0
IGlmIHRoZSBsaW5rIGlzIHVwICovPGJyPg0KwqAgwqAgwqAgwqAgbmFwaV93ZWlnaHQgPSBlYy0m
Z3Q7dHhfbWF4X2NvYWxlc2NlZF9mcmFtZXMgPyBOQVBJX1BPTExfV0VJR0hUIDogMDs8YnI+DQot
wqAgwqAgwqAgwqBpZiAobmFwaV93ZWlnaHQgXiB2aS0mZ3Q7c3FbMF0ubmFwaS53ZWlnaHQpIHs8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoZGV2LSZndDtmbGFncyAmYW1wOyBJRkZf
VVApPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1FQlVT
WTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlbHNlPGJyPg0KK8KgIMKgIMKgIMKgZm9y
IChpID0gcXVldWVfbnVtYmVyOyBpICZsdDsgcXVldWVfY291bnQ7IGkrKykgezxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlmIChuYXBpX3dlaWdodCBeIHZpLSZndDtzcVtpXS5uYXBpLndl
aWdodCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChkZXYt
Jmd0O2ZsYWdzICZhbXA7IElGRl9VUCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLUVCVVNZOzxicj4NCis8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB1cGRhdGVfbmFwaSA9IHRydWU7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcXVldWVfbnVtYmVyID0gaTs8YnI+PC9ibG9j
a3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGlzIHNlZW1z
IHRvIGFzc3VtZSBhbGwgcXVldWVzIHRoYXQgYmVsb25nIHRvIFtxdWV1ZV9udW1iZXIsIHF1ZXVl
X2NvdW50KSBuZWVkIGFuIHVwZGF0aW5nIG9mIHRoZSBOQVBJIHdoaWNoIGlzIG5vdCBuZWNlc3Nh
cmlseSB0aGUgY2FzZS7CoCBXb3J0aCBhIGNvbW1lbnQgdG8gbWVudGlvbiB0aGF0IHRoZSB1cGRh
dGluZyBvZiB0aGUgTkFQSSBtaWdodCBub3QgYmUgbmVjZXNzYXJ5LjwvZGl2PjwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+VGhhbmtzPC9kaXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVm
dDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoH08YnI+DQrCoCDCoCDCoCDCoCB9PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgaWYgKHZp
cnRpb19oYXNfZmVhdHVyZSh2aS0mZ3Q7dmRldiwgVklSVElPX05FVF9GX05PVEZfQ09BTCkpPGJy
Pg0KK8KgIMKgIMKgIMKgaWYgKCFwZXJfcXVldWUgJmFtcDsmYW1wOyB2aXJ0aW9faGFzX2ZlYXR1
cmUodmktJmd0O3ZkZXYsIFZJUlRJT19ORVRfRl9OT1RGX0NPQUwpKTxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHJldCA9IHZpcnRuZXRfc2VuZF9ub3RmX2NvYWxfY21kcyh2aSwgZWMpOzxi
cj4NCivCoCDCoCDCoCDCoGVsc2UgaWYgKHBlcl9xdWV1ZSAmYW1wOyZhbXA7IHZpcnRpb19oYXNf
ZmVhdHVyZSh2aS0mZ3Q7dmRldiwgVklSVElPX05FVF9GX1ZRX05PVEZfQ09BTCkpPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gdmlydG5ldF9zZW5kX25vdGZfY29hbF92cV9jbWRz
KHZpLCBlYywgcXVldWUpOzxicj4NCsKgIMKgIMKgIMKgIGVsc2U8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCByZXQgPSB2aXJ0bmV0X2NvYWxfcGFyYW1zX3N1cHBvcnRlZChlYyk7PGJyPg0K
PGJyPg0KQEAgLTMxMTgsNyArMzE4NSw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9zZXRfY29hbGVz
Y2Vfb25lKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgcmV0dXJuIHJldDs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBpZiAodXBkYXRlX25hcGkpIHs8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmb3IgKGkgPSAwOyBpICZsdDsgdmktJmd0O21h
eF9xdWV1ZV9wYWlyczsgaSsrKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZvciAoaSA9
IHF1ZXVlX251bWJlcjsgaSAmbHQ7IHF1ZXVlX2NvdW50OyBpKyspPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdmktJmd0O3NxW2ldLm5hcGkud2VpZ2h0ID0gbmFwaV93
ZWlnaHQ7PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCjxicj4NCkBAIC0zMTMwLDE5ICszMTk3LDI5
IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9zZXRfY29hbGVzY2Uoc3RydWN0IG5ldF9kZXZpY2UgKmRl
diw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBz
dHJ1Y3Qga2VybmVsX2V0aHRvb2xfY29hbGVzY2UgKmtlcm5lbF9jb2FsLDxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cnVjdCBuZXRsaW5rX2V4
dF9hY2sgKmV4dGFjayk8YnI+DQrCoHs8YnI+DQotwqAgwqAgwqAgwqByZXR1cm4gdmlydG5ldF9z
ZXRfY29hbGVzY2Vfb25lKGRldiwgZWMpOzxicj4NCivCoCDCoCDCoCDCoHJldHVybiB2aXJ0bmV0
X3NldF9jb2FsZXNjZV9vbmUoZGV2LCBlYywgZmFsc2UsIDApOzxicj4NCsKgfTxicj4NCjxicj4N
CsKgc3RhdGljIGludCB2aXJ0bmV0X2dldF9jb2FsZXNjZV9vbmUoc3RydWN0IG5ldF9kZXZpY2Ug
KmRldiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBzdHJ1Y3QgZXRodG9vbF9jb2FsZXNjZSAqZWMpPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RydWN0IGV0aHRvb2xfY29h
bGVzY2UgKmVjLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGJvb2wgcGVyX3F1ZXVlLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHUzMiBxdWV1ZSk8YnI+DQrCoHs8YnI+DQrC
oCDCoCDCoCDCoCBzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IG5ldGRldl9wcml2KGRldik7PGJy
Pg0KPGJyPg0KLcKgIMKgIMKgIMKgaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2aS0mZ3Q7dmRldiwg
VklSVElPX05FVF9GX05PVEZfQ09BTCkpIHs8YnI+DQorwqAgwqAgwqAgwqBpZiAocXVldWUgJmd0
Oz0gdmktJmd0O21heF9xdWV1ZV9wYWlycyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBy
ZXR1cm4gLUVJTlZBTDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKCFwZXJfcXVldWUgJmFt
cDsmYW1wOyB2aXJ0aW9faGFzX2ZlYXR1cmUodmktJmd0O3ZkZXYsIFZJUlRJT19ORVRfRl9OT1RG
X0NPQUwpKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZWMtJmd0O3J4X2NvYWxlc2Nl
X3VzZWNzID0gdmktJmd0O2ludHJfY29hbF9yeC5tYXhfdXNlY3M7PGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgZWMtJmd0O3R4X2NvYWxlc2NlX3VzZWNzID0gdmktJmd0O2ludHJfY29hbF90
eC5tYXhfdXNlY3M7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZWMtJmd0O3R4X21heF9j
b2FsZXNjZWRfZnJhbWVzID0gdmktJmd0O2ludHJfY29hbF90eC5tYXhfcGFja2V0czs8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBlYy0mZ3Q7cnhfbWF4X2NvYWxlc2NlZF9mcmFtZXMgPSB2
aS0mZ3Q7aW50cl9jb2FsX3J4Lm1heF9wYWNrZXRzOzxicj4NCivCoCDCoCDCoCDCoH0gZWxzZSBp
ZiAocGVyX3F1ZXVlICZhbXA7JmFtcDsgdmlydGlvX2hhc19mZWF0dXJlKHZpLSZndDt2ZGV2LCBW
SVJUSU9fTkVUX0ZfVlFfTk9URl9DT0FMKSkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGVjLSZndDtyeF9jb2FsZXNjZV91c2VjcyA9IHZpLSZndDtycVtxdWV1ZV0uaW50cl9jb2FsLm1h
eF91c2Vjczs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlYy0mZ3Q7dHhfY29hbGVzY2Vf
dXNlY3MgPSB2aS0mZ3Q7c3FbcXVldWVdLmludHJfY29hbC5tYXhfdXNlY3M7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZWMtJmd0O3R4X21heF9jb2FsZXNjZWRfZnJhbWVzID0gdmktJmd0
O3NxW3F1ZXVlXS5pbnRyX2NvYWwubWF4X3BhY2tldHM7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZWMtJmd0O3J4X21heF9jb2FsZXNjZWRfZnJhbWVzID0gdmktJmd0O3JxW3F1ZXVlXS5p
bnRyX2NvYWwubWF4X3BhY2tldHM7PGJyPg0KwqAgwqAgwqAgwqAgfSBlbHNlIHs8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBlYy0mZ3Q7cnhfbWF4X2NvYWxlc2NlZF9mcmFtZXMgPSAxOzxi
cj4NCjxicj4NCkBAIC0zMTU4LDcgKzMyMzUsMjEgQEAgc3RhdGljIGludCB2aXJ0bmV0X2dldF9j
b2FsZXNjZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cnVjdCBrZXJuZWxfZXRodG9vbF9jb2FsZXNj
ZSAqa2VybmVsX2NvYWwsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgc3RydWN0IG5ldGxpbmtfZXh0X2FjayAqZXh0YWNrKTxicj4NCsKgezxicj4N
Ci3CoCDCoCDCoCDCoHJldHVybiB2aXJ0bmV0X2dldF9jb2FsZXNjZV9vbmUoZGV2LCBlYyk7PGJy
Pg0KK8KgIMKgIMKgIMKgcmV0dXJuIHZpcnRuZXRfZ2V0X2NvYWxlc2NlX29uZShkZXYsIGVjLCBm
YWxzZSwgMCk7PGJyPg0KK308YnI+DQorPGJyPg0KK3N0YXRpYyBpbnQgdmlydG5ldF9zZXRfcGVy
X3F1ZXVlX2NvYWxlc2NlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdTMyIHF1
ZXVlLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHN0cnVjdCBldGh0b29sX2NvYWxlc2NlICplYyk8YnI+DQorezxicj4N
CivCoCDCoCDCoCDCoHJldHVybiB2aXJ0bmV0X3NldF9jb2FsZXNjZV9vbmUoZGV2LCBlYywgdHJ1
ZSwgcXVldWUpOzxicj4NCit9PGJyPg0KKzxicj4NCitzdGF0aWMgaW50IHZpcnRuZXRfZ2V0X3Bl
cl9xdWV1ZV9jb2FsZXNjZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHUzMiBx
dWV1ZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3QgZXRodG9vbF9jb2FsZXNjZSAqZWMpPGJyPg0KK3s8YnI+
DQorwqAgwqAgwqAgwqByZXR1cm4gdmlydG5ldF9nZXRfY29hbGVzY2Vfb25lKGRldiwgZWMsIHRy
dWUsIHF1ZXVlKTs8YnI+DQrCoH08YnI+DQo8YnI+DQrCoHN0YXRpYyB2b2lkIHZpcnRuZXRfaW5p
dF9zZXR0aW5ncyhzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KTxicj4NCkBAIC0zMjkxLDYgKzMzODIs
OCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGV0aHRvb2xfb3BzIHZpcnRuZXRfZXRodG9vbF9vcHMg
PSB7PGJyPg0KwqAgwqAgwqAgwqAgLnNldF9saW5rX2tzZXR0aW5ncyA9IHZpcnRuZXRfc2V0X2xp
bmtfa3NldHRpbmdzLDxicj4NCsKgIMKgIMKgIMKgIC5zZXRfY29hbGVzY2UgPSB2aXJ0bmV0X3Nl
dF9jb2FsZXNjZSw8YnI+DQrCoCDCoCDCoCDCoCAuZ2V0X2NvYWxlc2NlID0gdmlydG5ldF9nZXRf
Y29hbGVzY2UsPGJyPg0KK8KgIMKgIMKgIMKgLnNldF9wZXJfcXVldWVfY29hbGVzY2UgPSB2aXJ0
bmV0X3NldF9wZXJfcXVldWVfY29hbGVzY2UsPGJyPg0KK8KgIMKgIMKgIMKgLmdldF9wZXJfcXVl
dWVfY29hbGVzY2UgPSB2aXJ0bmV0X2dldF9wZXJfcXVldWVfY29hbGVzY2UsPGJyPg0KwqAgwqAg
wqAgwqAgLmdldF9yeGZoX2tleV9zaXplID0gdmlydG5ldF9nZXRfcnhmaF9rZXlfc2l6ZSw8YnI+
DQrCoCDCoCDCoCDCoCAuZ2V0X3J4ZmhfaW5kaXJfc2l6ZSA9IHZpcnRuZXRfZ2V0X3J4ZmhfaW5k
aXJfc2l6ZSw8YnI+DQrCoCDCoCDCoCDCoCAuZ2V0X3J4ZmggPSB2aXJ0bmV0X2dldF9yeGZoLDxi
cj4NCmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oIGIvaW5jbHVk
ZS91YXBpL2xpbnV4L3ZpcnRpb19uZXQuaDxicj4NCmluZGV4IDEyYzFjOTY5OTkzNS4uY2M2NWVm
MGYzYzNlIDEwMDY0NDxicj4NCi0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fbmV0Lmg8
YnI+DQorKysgYi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oPGJyPg0KQEAgLTU2LDYg
KzU2LDcgQEA8YnI+DQrCoCNkZWZpbmUgVklSVElPX05FVF9GX01RwqAgwqAgwqAgwqAgMjLCoCDC
oCDCoCAvKiBEZXZpY2Ugc3VwcG9ydHMgUmVjZWl2ZSBGbG93PGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqIFN0ZWVyaW5n
ICovPGJyPg0KwqAjZGVmaW5lIFZJUlRJT19ORVRfRl9DVFJMX01BQ19BRERSIDIzwqAgLyogU2V0
IE1BQyBhZGRyZXNzICovPGJyPg0KKyNkZWZpbmUgVklSVElPX05FVF9GX1ZRX05PVEZfQ09BTCA1
MsKgIMKgLyogRGV2aWNlIHN1cHBvcnRzIHZpcnRxdWV1ZSBub3RpZmljYXRpb24gY29hbGVzY2lu
ZyAqLzxicj4NCsKgI2RlZmluZSBWSVJUSU9fTkVUX0ZfTk9URl9DT0FMIDUzwqAgwqAgwqAgLyog
RGV2aWNlIHN1cHBvcnRzIG5vdGlmaWNhdGlvbnMgY29hbGVzY2luZyAqLzxicj4NCsKgI2RlZmlu
ZSBWSVJUSU9fTkVUX0ZfR1VFU1RfVVNPNMKgIMKgIMKgIMKgIDU0wqAgwqAgwqAgLyogR3Vlc3Qg
Y2FuIGhhbmRsZSBVU092NCBpbi4gKi88YnI+DQrCoCNkZWZpbmUgVklSVElPX05FVF9GX0dVRVNU
X1VTTzbCoCDCoCDCoCDCoCA1NcKgIMKgIMKgIC8qIEd1ZXN0IGNhbiBoYW5kbGUgVVNPdjYgaW4u
ICovPGJyPg0KQEAgLTM5MSw1ICszOTIsMTggQEAgc3RydWN0IHZpcnRpb19uZXRfY3RybF9jb2Fs
X3J4IHs8YnI+DQrCoH07PGJyPg0KPGJyPg0KwqAjZGVmaW5lIFZJUlRJT19ORVRfQ1RSTF9OT1RG
X0NPQUxfUlhfU0VUwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAxPGJyPg0KKyNkZWZpbmUgVklSVElP
X05FVF9DVFJMX05PVEZfQ09BTF9WUV9TRVTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDI8YnI+DQor
I2RlZmluZSBWSVJUSU9fTkVUX0NUUkxfTk9URl9DT0FMX1ZRX0dFVMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgMzxicj4NCis8YnI+DQorc3RydWN0IHZpcnRpb19uZXRfY3RybF9jb2FsIHs8YnI+DQor
wqAgwqAgwqAgwqBfX2xlMzIgbWF4X3BhY2tldHM7PGJyPg0KK8KgIMKgIMKgIMKgX19sZTMyIG1h
eF91c2Vjczs8YnI+DQorfTs8YnI+DQorPGJyPg0KK3N0cnVjdMKgIHZpcnRpb19uZXRfY3RybF9j
b2FsX3ZxIHs8YnI+DQorwqAgwqAgwqAgwqBfX2xlMTYgdnFuOzxicj4NCivCoCDCoCDCoCDCoF9f
bGUxNiByZXNlcnZlZDs8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgdmlydGlvX25ldF9jdHJsX2Nv
YWwgY29hbDs8YnI+DQorfTs8YnI+DQo8YnI+DQrCoCNlbmRpZiAvKiBfVUFQSV9MSU5VWF9WSVJU
SU9fTkVUX0ggKi88YnI+DQotLSA8YnI+DQoyLjM5LjE8YnI+DQo8YnI+DQo8L2Jsb2NrcXVvdGU+
PC9kaXY+PC9kaXY+DQo=
--000000000000da1d1d060045a0ba--


--===============3695772543556782458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3695772543556782458==--

