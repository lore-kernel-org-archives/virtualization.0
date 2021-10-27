Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A128DC433EF
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 06:14:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B711610C7
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 06:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B711610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA10B401CC;
	Wed, 27 Oct 2021 06:14:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DL7c-NQ8epJF; Wed, 27 Oct 2021 06:14:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 35B624019F;
	Wed, 27 Oct 2021 06:14:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0CEAC0019;
	Wed, 27 Oct 2021 06:14:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A3AAC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 06:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 209674019F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 06:14:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AZGOVn2KuuG9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 06:14:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0A47240109
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 06:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635315265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M26eZ4ihHacIjdwpo4MV2lHW4ttYDDBi/nWXN0gDWSk=;
 b=Va2aXc+IdHgsXj2KjsFmivSwI4mUhOXbk3yZeBtaYU9hmkQ4xrObihPpYAAwAFvP9E8sxt
 U8xkgVoZF7+HDZcGuWYTxP9vfkq54grdp+aWKdc2tjBbuC+FrKUspICYi8kjfCbHQnsJYI
 /11Of3lothVCyKUdzN2yU0VY2ddztgw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-vUbcvqxDMOSx_t72YVPLQA-1; Wed, 27 Oct 2021 02:14:24 -0400
X-MC-Unique: vUbcvqxDMOSx_t72YVPLQA-1
Received: by mail-lj1-f198.google.com with SMTP id
 s5-20020a2e98c5000000b002112895b3f6so254321ljj.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 23:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M26eZ4ihHacIjdwpo4MV2lHW4ttYDDBi/nWXN0gDWSk=;
 b=7uHt8GXerlbjBs9O3t6yta2F4mjhIyABgerX4cbq0+131hahqumKfQ0rn00heoqL2v
 g2d0lU4zmUsVa0dxM54Y3BK95yMeOwIXotTh3GHQ9dQScVHYGayrnm59r9Q1cfb2N7Qq
 0em0wcMriI6wVSOKXQFCv7y2Z7vDX8du0I7oG7El6N/7WExow9i4myY/rLUWVXy0PUGm
 v3cWdvrJPROMNatkdTHvE6jv4TcoFPUKvWMdzpUD2/UgCX4c+RdZBaLQR8b47gEmNFI/
 S46Kr0u8ZYan2ddtkTsomvRx2bsUFYl4yFwY1C/RnEZ1ZsILqpTnY31RFBpoO0QD+5Nq
 isfA==
X-Gm-Message-State: AOAM531s9dm/0V4koueAFWHNmb+D5hIecIqGXx7KqPa7DgRiZYlRwM0y
 MTfEBlyG8qVBWPDJriRJhxOcpebIUg4LTZ5BCGnGvlx0aSdwZB2VFDW/7D0RxbmvUeMpGv3RcqU
 IkPs2OO/1ci9nJZMtIdWHAEL0XwoTB0mqClDgUSypKACgVt1oCQV7xtqZPA==
X-Received: by 2002:a05:6512:3d11:: with SMTP id
 d17mr22902555lfv.481.1635315262874; 
 Tue, 26 Oct 2021 23:14:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytge2BF9wvQ3ok+7Sl92yCoKoRRPlFkgB6J8lsN2F2AS8+7UJlaZCLcth1SlgdHbSdFzyaddJCb+asNkAuPB0=
X-Received: by 2002:a05:6512:3d11:: with SMTP id
 d17mr22902543lfv.481.1635315262687; 
 Tue, 26 Oct 2021 23:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211026175519.87795-1-parav@nvidia.com>
 <20211026175519.87795-9-parav@nvidia.com>
In-Reply-To: <20211026175519.87795-9-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Oct 2021 14:14:11 +0800
Message-ID: <CACGkMEsNy04AeYndnfBGQMGMFxuLXusnKiix9SR9CrUSMJgGRg@mail.gmail.com>
Subject: Re: [PATCH linux-next v7 8/8] vdpa/mlx5: Forward only packets with
 allowed MAC address
To: Parav Pandit <parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eli Cohen <elic@nvidia.com>, mst <mst@redhat.com>,
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

On Wed, Oct 27, 2021 at 1:56 AM Parav Pandit <parav@nvidia.com> wrote:
>
> From: Eli Cohen <elic@nvidia.com>
>
> Add rules to forward packets to the net device's TIR only if the
> destination MAC is equal to the configured MAC. This is required to
> prevent the netdevice from receiving traffic not destined to its
> configured MAC.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 76 +++++++++++++++++++++++--------
>  1 file changed, 58 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index cc027499c4d3..9b7d8c721354 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -158,7 +158,8 @@ struct mlx5_vdpa_net {
>         struct mutex reslock;
>         struct mlx5_flow_table *rxft;
>         struct mlx5_fc *rx_counter;
> -       struct mlx5_flow_handle *rx_rule;
> +       struct mlx5_flow_handle *rx_rule_ucast;
> +       struct mlx5_flow_handle *rx_rule_mcast;
>         bool setup;
>         u32 cur_num_vqs;
>         struct notifier_block nb;
> @@ -1383,21 +1384,33 @@ static int add_fwd_to_tir(struct mlx5_vdpa_net *ndev)
>         struct mlx5_flow_table_attr ft_attr = {};
>         struct mlx5_flow_act flow_act = {};
>         struct mlx5_flow_namespace *ns;
> +       struct mlx5_flow_spec *spec;
> +       void *headers_c;
> +       void *headers_v;
> +       u8 *dmac_c;
> +       u8 *dmac_v;
>         int err;
>
> -       /* for now, one entry, match all, forward to tir */
> -       ft_attr.max_fte = 1;
> -       ft_attr.autogroup.max_num_groups = 1;
> +       spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
> +       if (!spec)
> +               return -ENOMEM;
> +
> +       spec->match_criteria_enable = MLX5_MATCH_OUTER_HEADERS;
> +       ft_attr.max_fte = 2;
> +       ft_attr.autogroup.max_num_groups = 2;
>
>         ns = mlx5_get_flow_namespace(ndev->mvdev.mdev, MLX5_FLOW_NAMESPACE_BYPASS);
>         if (!ns) {
> -               mlx5_vdpa_warn(&ndev->mvdev, "get flow namespace\n");
> -               return -EOPNOTSUPP;
> +               mlx5_vdpa_warn(&ndev->mvdev, "failed to get flow namespace\n");
> +               err = -EOPNOTSUPP;
> +               goto err_ns;
>         }
>
>         ndev->rxft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
> -       if (IS_ERR(ndev->rxft))
> -               return PTR_ERR(ndev->rxft);
> +       if (IS_ERR(ndev->rxft)) {
> +               err = PTR_ERR(ndev->rxft);
> +               goto err_ns;
> +       }
>
>         ndev->rx_counter = mlx5_fc_create(ndev->mvdev.mdev, false);
>         if (IS_ERR(ndev->rx_counter)) {
> @@ -1405,37 +1418,64 @@ static int add_fwd_to_tir(struct mlx5_vdpa_net *ndev)
>                 goto err_fc;
>         }
>
> +       headers_c = MLX5_ADDR_OF(fte_match_param, spec->match_criteria, outer_headers);
> +       dmac_c = MLX5_ADDR_OF(fte_match_param, headers_c, outer_headers.dmac_47_16);
> +       memset(dmac_c, 0xff, ETH_ALEN);
> +       headers_v = MLX5_ADDR_OF(fte_match_param, spec->match_value, outer_headers);
> +       dmac_v = MLX5_ADDR_OF(fte_match_param, headers_v, outer_headers.dmac_47_16);
> +       ether_addr_copy(dmac_v, ndev->config.mac);
> +
>         flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST | MLX5_FLOW_CONTEXT_ACTION_COUNT;
>         dest[0].type = MLX5_FLOW_DESTINATION_TYPE_TIR;
>         dest[0].tir_num = ndev->res.tirn;
>         dest[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
>         dest[1].counter_id = mlx5_fc_id(ndev->rx_counter);
> -       ndev->rx_rule = mlx5_add_flow_rules(ndev->rxft, NULL, &flow_act, dest, 2);
> -       if (IS_ERR(ndev->rx_rule)) {
> -               err = PTR_ERR(ndev->rx_rule);
> -               ndev->rx_rule = NULL;
> -               goto err_rule;
> +       ndev->rx_rule_ucast = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dest, 2);
> +
> +       if (IS_ERR(ndev->rx_rule_ucast)) {
> +               err = PTR_ERR(ndev->rx_rule_ucast);
> +               ndev->rx_rule_ucast = NULL;
> +               goto err_rule_ucast;
> +       }
> +
> +       memset(dmac_c, 0, ETH_ALEN);
> +       memset(dmac_v, 0, ETH_ALEN);
> +       dmac_c[0] = 1;
> +       dmac_v[0] = 1;
> +       flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
> +       ndev->rx_rule_mcast = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dest, 1);
> +       if (IS_ERR(ndev->rx_rule_mcast)) {
> +               err = PTR_ERR(ndev->rx_rule_mcast);
> +               ndev->rx_rule_mcast = NULL;
> +               goto err_rule_mcast;
>         }
>
> +       kvfree(spec);
>         return 0;
>
> -err_rule:
> +err_rule_mcast:
> +       mlx5_del_flow_rules(ndev->rx_rule_ucast);
> +       ndev->rx_rule_ucast = NULL;
> +err_rule_ucast:
>         mlx5_fc_destroy(ndev->mvdev.mdev, ndev->rx_counter);
>  err_fc:
>         mlx5_destroy_flow_table(ndev->rxft);
> +err_ns:
> +       kvfree(spec);
>         return err;
>  }
>
>  static void remove_fwd_to_tir(struct mlx5_vdpa_net *ndev)
>  {
> -       if (!ndev->rx_rule)
> +       if (!ndev->rx_rule_ucast)
>                 return;
>
> -       mlx5_del_flow_rules(ndev->rx_rule);
> +       mlx5_del_flow_rules(ndev->rx_rule_mcast);
> +       ndev->rx_rule_mcast = NULL;
> +       mlx5_del_flow_rules(ndev->rx_rule_ucast);
> +       ndev->rx_rule_ucast = NULL;
>         mlx5_fc_destroy(ndev->mvdev.mdev, ndev->rx_counter);
>         mlx5_destroy_flow_table(ndev->rxft);
> -
> -       ndev->rx_rule = NULL;
>  }
>
>  static virtio_net_ctrl_ack handle_ctrl_mac(struct mlx5_vdpa_dev *mvdev, u8 cmd)
> --
> 2.25.4
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
