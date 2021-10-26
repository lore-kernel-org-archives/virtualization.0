Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54787C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:14:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8BC61029
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EA8BC61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A25DC404AD;
	Tue, 26 Oct 2021 04:14:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Jppd0sXqsOH; Tue, 26 Oct 2021 04:14:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 272B540493;
	Tue, 26 Oct 2021 04:14:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE564C0019;
	Tue, 26 Oct 2021 04:13:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44F79C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:13:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2D5A580E68
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:13:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2cimdUzkxxS1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:13:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58C6280E56
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635221637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2kF+JMXiP5LNRETAKxd1Ni5uiN6I3D+RyXIRQCALsK8=;
 b=S2S7jS22XwP+iHl5XkGd94WXkBiY49Ttbc6GxF0GiA5pDQhki7g/Ln8CNPhCW38KnEF3BZ
 Yp8L6s/ROTKv30QV8aH/B/ODsOnAOE3C1O+BdGzpOJ5nW6xtzupO27+sCEuldM6SNZiGUX
 TGheUZW/89o51CxNDDoZSQUen2Jq4F4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-KpgvfQG0Ngq9SdqXa6oBpQ-1; Tue, 26 Oct 2021 00:13:55 -0400
X-MC-Unique: KpgvfQG0Ngq9SdqXa6oBpQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 k15-20020a0565123d8f00b003ffb31e2ea9so1272561lfv.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 21:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2kF+JMXiP5LNRETAKxd1Ni5uiN6I3D+RyXIRQCALsK8=;
 b=slxlWGjPw55lNOgROGBoQp3zWSi73MC8FY2EpgT/THU14OaofN6ko4GDWvjZC//dYN
 0qrDInWuDfbNw21nf6OBLu9Xb7+BlBp+fp+R3UavvOdXQ/CTCGpxXmo15OgraSWGzz/8
 /5SeJmfUNfMHHLwuJYPBuwa+fUy6UpOAIV0cZFf+8wswvyQZ3kQELEtCscv8PHqnw6Dn
 rrHnKovdx7Mdfm9pB5SspLWoQ66s4DiVsMoPj2GNfXjuj3GjJum9+EdP9lk2RndZ6GKR
 TMhyJfuD8dFQznZ4KFqwXb7igWR2q7rG8TjDasBDxW77tPka5ujExzJyJjCS6kefhmM2
 RPaw==
X-Gm-Message-State: AOAM530Axz9ffw02iAdJVvwat9L3H4WHArwH4lcj2SvAPoOi1XCXG9EW
 yV67d9D9tF/elTE/7rLeASh3jy/DnkHDAE9NolzU9qOgD4tZVW1ptWiEl21meOh+Z90SwpQujPd
 dyZ6mv+Ijs52Qu518PMagKGcGL9Ob2738WJLQz8p8J866N+ufv0rp8eK1qg==
X-Received: by 2002:a2e:5344:: with SMTP id t4mr23426437ljd.362.1635221634310; 
 Mon, 25 Oct 2021 21:13:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxJC/9jfNCRntlywyCF3l38wk4v37CvSRXfyLc6BqmDPpPMM8w8sLflZHy+XgnD9uuE/iCwUK2aGiloNqbObM=
X-Received: by 2002:a2e:5344:: with SMTP id t4mr23426420ljd.362.1635221634100; 
 Mon, 25 Oct 2021 21:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211026040243.79005-1-parav@nvidia.com>
 <20211026040243.79005-9-parav@nvidia.com>
In-Reply-To: <20211026040243.79005-9-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Oct 2021 12:13:43 +0800
Message-ID: <CACGkMEtaE_wfGrjDdDwqKEQtxMFvUnxWmaA7ztwQ6r=RBT4Qug@mail.gmail.com>
Subject: Re: [PATCH linux-next v6 8/8] vdpa/mlx5: Forward only packets with
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

On Tue, Oct 26, 2021 at 12:03 PM Parav Pandit <parav@nvidia.com> wrote:
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
