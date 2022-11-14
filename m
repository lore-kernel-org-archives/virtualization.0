Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB722C4332F
	for <virtualization@archiver.kernel.org>; Mon, 14 Nov 2022 04:42:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 60DA84017E;
	Mon, 14 Nov 2022 04:42:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 60DA84017E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BcmIr1S7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H4l0XFTvpsPE; Mon, 14 Nov 2022 04:42:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B0012400F6;
	Mon, 14 Nov 2022 04:42:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B0012400F6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C018C0032;
	Mon, 14 Nov 2022 04:42:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3130C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:42:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD78A60C29
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:42:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD78A60C29
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BcmIr1S7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MD4w7YLgGNj7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:42:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D161E60C24
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D161E60C24
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668400942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z5uwOVwFgI5IfGkeQ8z5UfE4vHlHFDxyEJXxCbesoTE=;
 b=BcmIr1S7BBNS3b4/UcVAbwifrn+S8auFl9UieQmLvT/KmwDsb67KHbM53+DD2r2yMMgD+r
 VYguy1jfRAdrU4t1tJGH4tNrE4jqqxRMmDIDHYpsu//LZu8whziqEQfTTnpYpDGiJQBJg1
 41kiGriTBkbY+Q8NMthrHCWyiIiCmbQ=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-339-nTOSgCOtP7aXjBHnxVCBdA-1; Sun, 13 Nov 2022 23:42:21 -0500
X-MC-Unique: nTOSgCOtP7aXjBHnxVCBdA-1
Received: by mail-ot1-f72.google.com with SMTP id
 p19-20020a056830319300b0066c34a214f2so5651824ots.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 20:42:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z5uwOVwFgI5IfGkeQ8z5UfE4vHlHFDxyEJXxCbesoTE=;
 b=RI9EYlYMSkR9apaYO4OkD2wDRzZ1aKQAPv2dDuaTz7OcjZKr8piFEna5yICyrY68rK
 96RYJT/HAyJuz6Le+PP4R/0CMmqOFNgOyB2tat3esqTlBIAcqUGbh6aSeob4fx1JgUSR
 e0hbQ32UxknBXCp/heIz0YButCyRQyGbag77msJVfTxXI9KsUcydp6lgE6nLKtkAXyhL
 HP1MO3OLU6GPCYjaLypE1DDTFE8w5+nTp2TkWzc7o247lylLqKafN4VyZ1VwdncNViSY
 iVfrUs6O4MsUIooMt8La4DcBkqdHGxQoBuGaH+0T/9+m5KvqClBEhd/lEU3+HAmHqttL
 8ekQ==
X-Gm-Message-State: ANoB5pkAL9o3Buyw0BDfruRYRfJ81Ub2hlJ/DzE/smbHdo7UR0L842gW
 QkmwQyO/Vsmc9ZeW4yhIsr32r7czNQKBCLPhl9lhDpgeRFMk1zqU84tQvz38xN4InPZwPDhOP6+
 y/hU9GN1Rhok+gPVdYiYsXK+IneVDzSirvaiZKgBHDDACVi7zR2zmyt1ubg==
X-Received: by 2002:a05:6830:124d:b0:66c:64d6:1bb4 with SMTP id
 s13-20020a056830124d00b0066c64d61bb4mr5719962otp.201.1668400940796; 
 Sun, 13 Nov 2022 20:42:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6JtpSaHDpx92dpZPqyGUu0IEsp01m8fgC0wohlG48WvH6rUideVtK9G8V7RxyU6XXbp0f0HNIRD6AefHyMPgo=
X-Received: by 2002:a05:6830:124d:b0:66c:64d6:1bb4 with SMTP id
 s13-20020a056830124d00b0066c64d61bb4mr5719953otp.201.1668400940555; Sun, 13
 Nov 2022 20:42:20 -0800 (PST)
MIME-Version: 1.0
References: <20221113134442.152695-1-elic@nvidia.com>
 <20221113134442.152695-5-elic@nvidia.com>
In-Reply-To: <20221113134442.152695-5-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Nov 2022 12:42:09 +0800
Message-ID: <CACGkMEvV9FOHU6R8hjqeOH2wEaVBSbvojmRa77jbKfEkH+rKaw@mail.gmail.com>
Subject: Re: [PATCH 4/7] vdpa/mlx5: Add debugfs subtree
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
> Add debugfs subtree and expose flow table ID and TIR number. This
> information can be used by external tools to do extended
> troubleshooting.
>
> The information can be retrieved like so:
> $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/table_id
> $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/tirn
>
> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/Makefile        |  2 +-
>  drivers/vdpa/mlx5/net/debug.c     | 66 +++++++++++++++++++++++++++++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 11 ++++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.h |  9 +++++
>  4 files changed, 87 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/vdpa/mlx5/net/debug.c
>
> diff --git a/drivers/vdpa/mlx5/Makefile b/drivers/vdpa/mlx5/Makefile
> index f717978c83bf..e791394c33e3 100644
> --- a/drivers/vdpa/mlx5/Makefile
> +++ b/drivers/vdpa/mlx5/Makefile
> @@ -1,4 +1,4 @@
>  subdir-ccflags-y += -I$(srctree)/drivers/vdpa/mlx5/core
>
>  obj-$(CONFIG_MLX5_VDPA_NET) += mlx5_vdpa.o
> -mlx5_vdpa-$(CONFIG_MLX5_VDPA_NET) += net/mlx5_vnet.o core/resources.o core/mr.o
> +mlx5_vdpa-$(CONFIG_MLX5_VDPA_NET) += net/mlx5_vnet.o core/resources.o core/mr.o net/debug.o
> diff --git a/drivers/vdpa/mlx5/net/debug.c b/drivers/vdpa/mlx5/net/debug.c
> new file mode 100644
> index 000000000000..95e4801df211
> --- /dev/null
> +++ b/drivers/vdpa/mlx5/net/debug.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
> +
> +#include <linux/debugfs.h>
> +#include <linux/mlx5/fs.h>
> +#include "mlx5_vnet.h"
> +
> +static int tirn_show(struct seq_file *file, void *priv)
> +{
> +       struct mlx5_vdpa_net *ndev = file->private;
> +
> +       seq_printf(file, "0x%x\n", ndev->res.tirn);
> +       return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(tirn);
> +
> +void mlx5_vdpa_remove_tirn(struct mlx5_vdpa_net *ndev)
> +{
> +       if (ndev->debugfs)
> +               debugfs_remove(ndev->res.tirn_dent);
> +}
> +
> +void mlx5_vdpa_add_tirn(struct mlx5_vdpa_net *ndev)
> +{
> +       ndev->res.tirn_dent = debugfs_create_file("tirn", 0444, ndev->rx_dent,
> +                                                 ndev, &tirn_fops);
> +}
> +
> +static int rx_flow_table_show(struct seq_file *file, void *priv)
> +{
> +       struct mlx5_vdpa_net *ndev = file->private;
> +
> +       seq_printf(file, "0x%x\n", mlx5_flow_table_id(ndev->rxft));
> +       return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(rx_flow_table);
> +
> +void mlx5_vdpa_remove_rx_flow_table(struct mlx5_vdpa_net *ndev)
> +{
> +       if (ndev->debugfs)
> +               debugfs_remove(ndev->rx_table_dent);
> +}
> +
> +void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev)
> +{
> +       ndev->rx_table_dent = debugfs_create_file("table_id", 0444, ndev->rx_dent,
> +                                                 ndev, &rx_flow_table_fops);
> +}
> +
> +void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev)
> +{
> +       struct mlx5_core_dev *mdev;
> +
> +       mdev = ndev->mvdev.mdev;
> +       ndev->debugfs = debugfs_create_dir(dev_name(&ndev->mvdev.vdev.dev),
> +                                          mlx5_debugfs_get_dev_root(mdev));
> +       if (!IS_ERR(ndev->debugfs))
> +               ndev->rx_dent = debugfs_create_dir("rx", ndev->debugfs);
> +}
> +
> +void mlx5_vdpa_remove_debugfs(struct dentry *dbg)
> +{
> +       debugfs_remove_recursive(dbg);
> +}
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index e45b83527b41..ce2f478a93f5 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1388,11 +1388,16 @@ static int create_tir(struct mlx5_vdpa_net *ndev)
>
>         err = mlx5_vdpa_create_tir(&ndev->mvdev, in, &ndev->res.tirn);
>         kfree(in);
> +       if (err)
> +               return err;
> +
> +       mlx5_vdpa_add_tirn(ndev);
>         return err;
>  }
>
>  static void destroy_tir(struct mlx5_vdpa_net *ndev)
>  {
> +       mlx5_vdpa_remove_tirn(ndev);
>         mlx5_vdpa_destroy_tir(&ndev->mvdev, ndev->res.tirn);
>  }
>
> @@ -1578,6 +1583,7 @@ static int setup_steering(struct mlx5_vdpa_net *ndev)
>                 mlx5_vdpa_warn(&ndev->mvdev, "failed to create flow table\n");
>                 return PTR_ERR(ndev->rxft);
>         }
> +       mlx5_vdpa_add_rx_flow_table(ndev);
>
>         err = mac_vlan_add(ndev, ndev->config.mac, 0, false);
>         if (err)
> @@ -1586,6 +1592,7 @@ static int setup_steering(struct mlx5_vdpa_net *ndev)
>         return 0;
>
>  err_add:
> +       mlx5_vdpa_remove_rx_flow_table(ndev);
>         mlx5_destroy_flow_table(ndev->rxft);
>         return err;
>  }
> @@ -1593,6 +1600,7 @@ static int setup_steering(struct mlx5_vdpa_net *ndev)
>  static void teardown_steering(struct mlx5_vdpa_net *ndev)
>  {
>         clear_mac_vlan_table(ndev);
> +       mlx5_vdpa_remove_rx_flow_table(ndev);
>         mlx5_destroy_flow_table(ndev->rxft);
>  }
>
> @@ -3172,6 +3180,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>         if (err)
>                 goto err_reg;
>
> +       mlx5_vdpa_add_debugfs(ndev);
>         mgtdev->ndev = ndev;
>         return 0;
>
> @@ -3198,6 +3207,8 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
>         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>         struct workqueue_struct *wq;
>
> +       mlx5_vdpa_remove_debugfs(ndev->debugfs);
> +       ndev->debugfs = NULL;
>         if (ndev->nb_registered) {
>                 mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
>                 ndev->nb_registered = false;
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> index 6691c879a6ca..f2cef3925e5b 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> @@ -16,6 +16,7 @@ struct mlx5_vdpa_net_resources {
>         u32 tirn;
>         u32 rqtn;
>         bool valid;
> +       struct dentry *tirn_dent;
>  };
>
>  #define MLX5V_MACVLAN_SIZE 256
> @@ -43,6 +44,7 @@ struct mlx5_vdpa_net {
>         struct vdpa_callback config_cb;
>         struct mlx5_vdpa_wq_ent cvq_ent;
>         struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
> +       struct dentry *debugfs;
>  };
>
>  struct macvlan_node {
> @@ -52,4 +54,11 @@ struct macvlan_node {
>         u64 macvlan;
>  };
>
> +void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev);
> +void mlx5_vdpa_remove_debugfs(struct dentry *dbg);
> +void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev);
> +void mlx5_vdpa_remove_rx_flow_table(struct mlx5_vdpa_net *ndev);
> +void mlx5_vdpa_add_tirn(struct mlx5_vdpa_net *ndev);
> +void mlx5_vdpa_remove_tirn(struct mlx5_vdpa_net *ndev);
> +
>  #endif /* __MLX5_VNET_H__ */
> --
> 2.38.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
