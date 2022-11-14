Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7498C4332F
	for <virtualization@archiver.kernel.org>; Mon, 14 Nov 2022 04:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6211040888;
	Mon, 14 Nov 2022 04:41:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6211040888
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EaGMNGM1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sO4ZgmI9cXCv; Mon, 14 Nov 2022 04:41:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6D82A40868;
	Mon, 14 Nov 2022 04:41:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6D82A40868
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46B92C0032;
	Mon, 14 Nov 2022 04:41:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4A3EC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:41:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B164481469
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:41:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B164481469
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EaGMNGM1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W6Kvf9pIaSgZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:41:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DCB9C81468
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DCB9C81468
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668400886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MKjDmIAt0prUKa9dsHOjZqBINBMFFGgMprh04cvIpSE=;
 b=EaGMNGM1/T8PpWYrQ93w2VPEKlUOY9N1jWVB1P3dfq5sa67IKQNP26ZqMkCrUbbQxxqOn5
 fXG7nh608dFcu1RVnIoz0fzjbHApIcm7ubt3qfwRZxyqSJNG2jH6zPCyECm1HLwAKWQrbJ
 HV3I9jqt5aRGqVSi5A0yBzKsFRyDw5g=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-477-Jf3FCucdPZGAb-oeo6oRVg-1; Sun, 13 Nov 2022 23:41:22 -0500
X-MC-Unique: Jf3FCucdPZGAb-oeo6oRVg-1
Received: by mail-oo1-f72.google.com with SMTP id
 w18-20020a4a6d52000000b0049f209d84bbso3340991oof.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 20:41:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MKjDmIAt0prUKa9dsHOjZqBINBMFFGgMprh04cvIpSE=;
 b=MgRwN4kGRkGkXUWW4nLBg5b/uJva7V5NHO1dOTocC/AGWyeY3JzjHa8GGgPESG3gDk
 ijRhBdYK35TfpufM9BjWfV6lWxMGCgZ9FtPk3XiMwUBrAg00P6CsWTOWqgDaP+ab9+e5
 ukI9tQprCxJQtoKFpvdA7Vf55vNk1aDF0NdHSOZQSnqpsUf4fwzo2EEv+lrVO3VIlrD9
 9feIpgHMvNBfPSPBrq4QlO7WSmycIJNijxro0W6dExNCKQH7w3ZgF6KSOeXLmgKdS3Wq
 I4NwmekNEeodPiosmxJjNtgDHzEdKtGgZZXYlFtKQfCMoEcSwlNfzp59YQNz1LClToX6
 kk1w==
X-Gm-Message-State: ANoB5pn5+0fgAg5vhsjA50dBELpCOi7Z88QDv6ZYxxjK9c0HOAdIE1JD
 cqTF2VRPxvmeJ1JmxFk77OG3W9gSP7hve6e6i/1S/p/Njerp3Fx23AQX42PjbLAcpS6sLDwrOi4
 otScQYhFW+IzYsJjLRq2bjCwyl9UR57uXu578jotv3vRDawMoUOVlCi1iTA==
X-Received: by 2002:a4a:5704:0:b0:49f:449a:5f6c with SMTP id
 u4-20020a4a5704000000b0049f449a5f6cmr4541460ooa.93.1668400881569; 
 Sun, 13 Nov 2022 20:41:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4157B6oXCXw3RByikzI77lJ0hjf54Is1etpUu0/uYC5dlkUqPYlH8kcl1nJLGCLNnaGKUBBQSU5CZcdPgp04k=
X-Received: by 2002:a4a:5704:0:b0:49f:449a:5f6c with SMTP id
 u4-20020a4a5704000000b0049f449a5f6cmr4541452ooa.93.1668400881317; Sun, 13 Nov
 2022 20:41:21 -0800 (PST)
MIME-Version: 1.0
References: <20221113134442.152695-1-elic@nvidia.com>
 <20221113134442.152695-4-elic@nvidia.com>
In-Reply-To: <20221113134442.152695-4-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Nov 2022 12:41:10 +0800
Message-ID: <CACGkMEupWx6YZToNqxyJ9sD5v41ouOeKe2=0_ASbWPFt8s1uGA@mail.gmail.com>
Subject: Re: [PATCH 3/7] vdpa/mlx5: Move some definitions to a new header file
To: Eli Cohen <elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: lulu@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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

On Sun, Nov 13, 2022 at 9:45 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Move some definitions from mlx5_vnet.c to newly added header file
> mlx5_vnet.h. We need these definitions for the following patches that
> add debugfs tree to expose information vital for debug.
>
> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 45 +------------------------
>  drivers/vdpa/mlx5/net/mlx5_vnet.h | 55 +++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+), 44 deletions(-)
>  create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index c54d5088ed4f..e45b83527b41 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -18,15 +18,12 @@
>  #include <linux/mlx5/mlx5_ifc_vdpa.h>
>  #include <linux/mlx5/mpfs.h>
>  #include "mlx5_vdpa.h"
> +#include "mlx5_vnet.h"
>
>  MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
>  MODULE_DESCRIPTION("Mellanox VDPA driver");
>  MODULE_LICENSE("Dual BSD/GPL");
>
> -#define to_mlx5_vdpa_ndev(__mvdev)                                             \
> -       container_of(__mvdev, struct mlx5_vdpa_net, mvdev)
> -#define to_mvdev(__vdev) container_of((__vdev), struct mlx5_vdpa_dev, vdev)
> -
>  #define VALID_FEATURES_MASK                                                                        \
>         (BIT_ULL(VIRTIO_NET_F_CSUM) | BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |                                   \
>          BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) | BIT_ULL(VIRTIO_NET_F_MTU) | BIT_ULL(VIRTIO_NET_F_MAC) |   \
> @@ -50,14 +47,6 @@ MODULE_LICENSE("Dual BSD/GPL");
>
>  #define MLX5V_UNTAGGED 0x1000
>
> -struct mlx5_vdpa_net_resources {
> -       u32 tisn;
> -       u32 tdn;
> -       u32 tirn;
> -       u32 rqtn;
> -       bool valid;
> -};
> -
>  struct mlx5_vdpa_cq_buf {
>         struct mlx5_frag_buf_ctrl fbc;
>         struct mlx5_frag_buf frag_buf;
> @@ -146,38 +135,6 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
>         return idx <= mvdev->max_idx;
>  }
>
> -#define MLX5V_MACVLAN_SIZE 256
> -
> -struct mlx5_vdpa_net {
> -       struct mlx5_vdpa_dev mvdev;
> -       struct mlx5_vdpa_net_resources res;
> -       struct virtio_net_config config;
> -       struct mlx5_vdpa_virtqueue *vqs;
> -       struct vdpa_callback *event_cbs;
> -
> -       /* Serialize vq resources creation and destruction. This is required
> -        * since memory map might change and we need to destroy and create
> -        * resources while driver in operational.
> -        */
> -       struct rw_semaphore reslock;
> -       struct mlx5_flow_table *rxft;
> -       bool setup;
> -       u32 cur_num_vqs;
> -       u32 rqt_size;
> -       bool nb_registered;
> -       struct notifier_block nb;
> -       struct vdpa_callback config_cb;
> -       struct mlx5_vdpa_wq_ent cvq_ent;
> -       struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
> -};
> -
> -struct macvlan_node {
> -       struct hlist_node hlist;
> -       struct mlx5_flow_handle *ucast_rule;
> -       struct mlx5_flow_handle *mcast_rule;
> -       u64 macvlan;
> -};
> -
>  static void free_resources(struct mlx5_vdpa_net *ndev);
>  static void init_mvqs(struct mlx5_vdpa_net *ndev);
>  static int setup_driver(struct mlx5_vdpa_dev *mvdev);
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> new file mode 100644
> index 000000000000..6691c879a6ca
> --- /dev/null
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> +/* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
> +
> +#ifndef __MLX5_VNET_H__
> +#define __MLX5_VNET_H__
> +
> +#include "mlx5_vdpa.h"
> +
> +#define to_mlx5_vdpa_ndev(__mvdev)                                             \
> +       container_of(__mvdev, struct mlx5_vdpa_net, mvdev)
> +#define to_mvdev(__vdev) container_of((__vdev), struct mlx5_vdpa_dev, vdev)
> +
> +struct mlx5_vdpa_net_resources {
> +       u32 tisn;
> +       u32 tdn;
> +       u32 tirn;
> +       u32 rqtn;
> +       bool valid;
> +};
> +
> +#define MLX5V_MACVLAN_SIZE 256
> +
> +struct mlx5_vdpa_net {
> +       struct mlx5_vdpa_dev mvdev;
> +       struct mlx5_vdpa_net_resources res;
> +       struct virtio_net_config config;
> +       struct mlx5_vdpa_virtqueue *vqs;
> +       struct vdpa_callback *event_cbs;
> +
> +       /* Serialize vq resources creation and destruction. This is required
> +        * since memory map might change and we need to destroy and create
> +        * resources while driver in operational.
> +        */
> +       struct rw_semaphore reslock;
> +       struct mlx5_flow_table *rxft;
> +       struct dentry *rx_dent;
> +       struct dentry *rx_table_dent;
> +       bool setup;
> +       u32 cur_num_vqs;
> +       u32 rqt_size;
> +       bool nb_registered;
> +       struct notifier_block nb;
> +       struct vdpa_callback config_cb;
> +       struct mlx5_vdpa_wq_ent cvq_ent;
> +       struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
> +};
> +
> +struct macvlan_node {
> +       struct hlist_node hlist;
> +       struct mlx5_flow_handle *ucast_rule;
> +       struct mlx5_flow_handle *mcast_rule;
> +       u64 macvlan;
> +};
> +
> +#endif /* __MLX5_VNET_H__ */
> --
> 2.38.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
