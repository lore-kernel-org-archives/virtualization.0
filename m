Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993C0C433FE
	for <virtualization@archiver.kernel.org>; Tue, 15 Nov 2022 03:33:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39495812B2;
	Tue, 15 Nov 2022 03:33:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 39495812B2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=URuJlBBG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 01Jt5rB1kmWs; Tue, 15 Nov 2022 03:33:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1117F80E55;
	Tue, 15 Nov 2022 03:33:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1117F80E55
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D120EC0032;
	Tue, 15 Nov 2022 03:33:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F117C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 03:33:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5BDBE40324
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 03:33:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5BDBE40324
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=URuJlBBG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hl5kQJ_ktDfa
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 03:33:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A0F1740363
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A0F1740363
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 03:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668483224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U7m6ao4IK6/aZ743Uu/e3L1NAClXd0BGmK8TQZZjy5A=;
 b=URuJlBBG5Ku7tnzFd+xWVMOCArFnAd8GxOB9qcIa2nFA72Xx2jW7/kRMQ/DG5mKYi0shvm
 wtsKa/AYqz/XDXS4M8giKZl6qK+/GmPBgLebi5opRGg4tpJXZmF7nO07rDV6od15fFA0v8
 LK73cQN1i3ncp3RA0hieLWz6pbVuAX8=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-115-8FOzHHrdPKmFSfl0Ml84kg-1; Mon, 14 Nov 2022 22:33:42 -0500
X-MC-Unique: 8FOzHHrdPKmFSfl0Ml84kg-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-13cbfc38be2so6262867fac.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 19:33:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U7m6ao4IK6/aZ743Uu/e3L1NAClXd0BGmK8TQZZjy5A=;
 b=PFzT7RAUifUh2UvwW5+PdBf8/jnB8QY5pN3igEuyYCqeeiU7xlQo+yIdMnoEzhDFHR
 +W/7BZ/rlW9isLfpqXpevCOy9i7GxnSXoqyXvXAfgGBCFeGyiTVSWQKe9DaTyB53v0a7
 JZyM9AoZCcQSchWIVTufT4yFempQjooi0m5vwiUhLaVvif0EkHi+dAV5n7hOVLZmE2Tz
 aNTt/CTv3PDyOBoakH1+pFNlKDyXj8dDFSHhoEx/dMpE6yC6bl7dsnuDCvOeQDt8Cm+j
 YGPA5QihPS1BG00RmDofN34UJbJ3ColLu7Ew/Qa3rLipoqIxTQ1A+/39rhC7oXivWdKN
 SE/A==
X-Gm-Message-State: ANoB5pmQc9L7mpBgv+NlBUfuuSv2Or0FMA3ymvcw5igR/lTewEljBKYo
 IHctUev7RshpZ2elNjlY4Lo9vz/xZOJoJU2fcDgIST8yWEdEjrrODEHYJYv9XmYnNYRxxDb6/OG
 u4Bc4IudfYO9qq0/uc6ohuywdmd+RB5oVemHW7SW6yezPxUqID3EFCYbTZQ==
X-Received: by 2002:a05:6870:638b:b0:132:7b3:29ac with SMTP id
 t11-20020a056870638b00b0013207b329acmr102854oap.35.1668483221827; 
 Mon, 14 Nov 2022 19:33:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5r7QzYsTy5/acwIsDQm+bUQzdhSXFtHnPYtqFtvuSwLauIORNv8s4arrMyuMKjiPeGZ9un+n4fqU/na3lvlK0=
X-Received: by 2002:a05:6870:638b:b0:132:7b3:29ac with SMTP id
 t11-20020a056870638b00b0013207b329acmr102844oap.35.1668483221475; Mon, 14 Nov
 2022 19:33:41 -0800 (PST)
MIME-Version: 1.0
References: <20221114131759.57883-1-elic@nvidia.com>
 <20221114131759.57883-9-elic@nvidia.com>
In-Reply-To: <20221114131759.57883-9-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Nov 2022 11:33:30 +0800
Message-ID: <CACGkMEvedzOtzUX0q_XPb_9cURRzStBjWZGscJ6=rKu--QSrww@mail.gmail.com>
Subject: Re: [PATH v2 8/8] vdpa/mlx5: Add RX counters to debugfs
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

On Mon, Nov 14, 2022 at 9:18 PM Eli Cohen <elic@nvidia.com> wrote:
>
> For each interface, either VLAN tagged or untagged, add two hardware
> counters: one for unicast and another for multicast. The counters count
> RX packets and bytes and can be read through debugfs:
>
> $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/mcast/packets
> $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/ucast/bytes
>
> This feature is controlled via the config option
> MLX5_VDPA_STEERING_DEBUG. It is off by default as it may have some
> impact on performance.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/Kconfig              |  12 ++++
>  drivers/vdpa/mlx5/net/debug.c     |  86 ++++++++++++++++++++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 116 +++++++++++++++++++++++-------
>  drivers/vdpa/mlx5/net/mlx5_vnet.h |  30 ++++++++
>  4 files changed, 217 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 50f45d037611..43b716ec2d18 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -71,6 +71,18 @@ config MLX5_VDPA_NET
>           be executed by the hardware. It also supports a variety of stateless
>           offloads depending on the actual device used and firmware version.
>
> +config MLX5_VDPA_STEERING_DEBUG
> +       bool "expose steering counters on debugfs"
> +       select MLX5_VDPA
> +       help
> +         Expose RX steering counters in debugfs to aid in debugging. For each VLAN
> +         or non VLAN interface, two hardware counters are added to the RX flow
> +         table: one for unicast and one for multicast.
> +         The counters counts the number of packets and bytes and exposes them in
> +         debugfs. Once can read the counters using, e.g.:
> +         cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/ucast/packets
> +         cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/mcast/bytes
> +
>  config VP_VDPA
>         tristate "Virtio PCI bridge vDPA driver"
>         select VIRTIO_PCI_LIB
> diff --git a/drivers/vdpa/mlx5/net/debug.c b/drivers/vdpa/mlx5/net/debug.c
> index 95e4801df211..60d6ac68cdc4 100644
> --- a/drivers/vdpa/mlx5/net/debug.c
> +++ b/drivers/vdpa/mlx5/net/debug.c
> @@ -49,6 +49,92 @@ void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev)
>                                                   ndev, &rx_flow_table_fops);
>  }
>
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +static int packets_show(struct seq_file *file, void *priv)
> +{
> +       struct mlx5_vdpa_counter *counter = file->private;
> +       u64 packets;
> +       u64 bytes;
> +       int err;
> +
> +       err = mlx5_fc_query(counter->mdev, counter->counter, &packets, &bytes);
> +       if (err)
> +               return err;
> +
> +       seq_printf(file, "0x%llx\n", packets);
> +       return 0;
> +}
> +
> +static int bytes_show(struct seq_file *file, void *priv)
> +{
> +       struct mlx5_vdpa_counter *counter = file->private;
> +       u64 packets;
> +       u64 bytes;
> +       int err;
> +
> +       err = mlx5_fc_query(counter->mdev, counter->counter, &packets, &bytes);
> +       if (err)
> +               return err;
> +
> +       seq_printf(file, "0x%llx\n", bytes);
> +       return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(packets);
> +DEFINE_SHOW_ATTRIBUTE(bytes);
> +
> +static void add_counter_node(struct mlx5_vdpa_counter *counter,
> +                            struct dentry *parent)
> +{
> +       debugfs_create_file("packets", 0444, parent, counter,
> +                           &packets_fops);
> +       debugfs_create_file("bytes", 0444, parent, counter,
> +                           &bytes_fops);
> +}
> +
> +void mlx5_vdpa_add_rx_counters(struct mlx5_vdpa_net *ndev,
> +                              struct macvlan_node *node)
> +{
> +       static const char *ut = "untagged";
> +       char vidstr[9];
> +       u16 vid;
> +
> +       node->ucast_counter.mdev = ndev->mvdev.mdev;
> +       node->mcast_counter.mdev = ndev->mvdev.mdev;
> +       if (node->tagged) {
> +               vid = key2vid(node->macvlan);
> +               snprintf(vidstr, sizeof(vidstr), "0x%x", vid);
> +       } else {
> +               strcpy(vidstr, ut);
> +       }
> +
> +       node->dent = debugfs_create_dir(vidstr, ndev->rx_dent);
> +       if (IS_ERR(node->dent)) {
> +               node->dent = NULL;
> +               return;
> +       }
> +
> +       node->ucast_counter.dent = debugfs_create_dir("ucast", node->dent);
> +       if (IS_ERR(node->ucast_counter.dent))
> +               return;
> +
> +       add_counter_node(&node->ucast_counter, node->ucast_counter.dent);
> +
> +       node->mcast_counter.dent = debugfs_create_dir("mcast", node->dent);
> +       if (IS_ERR(node->mcast_counter.dent))
> +               return;
> +
> +       add_counter_node(&node->mcast_counter, node->mcast_counter.dent);
> +}
> +
> +void mlx5_vdpa_remove_rx_counters(struct mlx5_vdpa_net *ndev,
> +                                 struct macvlan_node *node)
> +{
> +       if (node->dent && ndev->debugfs)
> +               debugfs_remove_recursive(node->dent);
> +}
> +#endif
> +
>  void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev)
>  {
>         struct mlx5_core_dev *mdev;
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 4b097e6ddba0..6632651b1e54 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1404,12 +1404,55 @@ static void destroy_tir(struct mlx5_vdpa_net *ndev)
>  #define MAX_STEERING_ENT 0x8000
>  #define MAX_STEERING_GROUPS 2
>
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +       #define NUM_DESTS 2
> +#else
> +       #define NUM_DESTS 1
> +#endif
> +
> +static int add_steering_counters(struct mlx5_vdpa_net *ndev,
> +                                struct macvlan_node *node,
> +                                struct mlx5_flow_act *flow_act,
> +                                struct mlx5_flow_destination *dests)
> +{
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +       int err;
> +
> +       node->ucast_counter.counter = mlx5_fc_create(ndev->mvdev.mdev, false);
> +       if (IS_ERR(node->ucast_counter.counter))
> +               return PTR_ERR(node->ucast_counter.counter);
> +
> +       node->mcast_counter.counter = mlx5_fc_create(ndev->mvdev.mdev, false);
> +       if (IS_ERR(node->mcast_counter.counter)) {
> +               err = PTR_ERR(node->mcast_counter.counter);
> +               goto err_mcast_counter;
> +       }
> +
> +       dests[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
> +       flow_act->action |= MLX5_FLOW_CONTEXT_ACTION_COUNT;
> +       return 0;
> +
> +err_mcast_counter:
> +       mlx5_fc_destroy(ndev->mvdev.mdev, node->ucast_counter.counter);
> +       return err;
> +#else
> +       return 0;
> +#endif
> +}
> +
> +static void remove_steering_counters(struct mlx5_vdpa_net *ndev,
> +                                    struct macvlan_node *node)
> +{
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +       mlx5_fc_destroy(ndev->mvdev.mdev, node->mcast_counter.counter);
> +       mlx5_fc_destroy(ndev->mvdev.mdev, node->ucast_counter.counter);
> +#endif
> +}
> +
>  static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
> -                                       u16 vid, bool tagged,
> -                                       struct mlx5_flow_handle **ucast,
> -                                       struct mlx5_flow_handle **mcast)
> +                                       struct macvlan_node *node)
>  {
> -       struct mlx5_flow_destination dest = {};
> +       struct mlx5_flow_destination dests[NUM_DESTS] = {};
>         struct mlx5_flow_act flow_act = {};
>         struct mlx5_flow_handle *rule;
>         struct mlx5_flow_spec *spec;
> @@ -1418,11 +1461,13 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
>         u8 *dmac_c;
>         u8 *dmac_v;
>         int err;
> +       u16 vid;
>
>         spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
>         if (!spec)
>                 return -ENOMEM;
>
> +       vid = key2vid(node->macvlan);
>         spec->match_criteria_enable = MLX5_MATCH_OUTER_HEADERS;
>         headers_c = MLX5_ADDR_OF(fte_match_param, spec->match_criteria, outer_headers);
>         headers_v = MLX5_ADDR_OF(fte_match_param, spec->match_value, outer_headers);
> @@ -1434,44 +1479,58 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
>                 MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
>                 MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, first_vid);
>         }
> -       if (tagged) {
> +       if (node->tagged) {
>                 MLX5_SET(fte_match_set_lyr_2_4, headers_v, cvlan_tag, 1);
>                 MLX5_SET(fte_match_set_lyr_2_4, headers_v, first_vid, vid);
>         }
>         flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
> -       dest.type = MLX5_FLOW_DESTINATION_TYPE_TIR;
> -       dest.tir_num = ndev->res.tirn;
> -       rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
> -       if (IS_ERR(rule))
> -               return PTR_ERR(rule);
> +       dests[0].type = MLX5_FLOW_DESTINATION_TYPE_TIR;
> +       dests[0].tir_num = ndev->res.tirn;
> +       err = add_steering_counters(ndev, node, &flow_act, dests);
> +       if (err)
> +               goto out_free;
> +
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +       dests[1].counter_id = mlx5_fc_id(node->ucast_counter.counter);
> +#endif
> +       node->ucast_rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dests, NUM_DESTS);
> +       if (IS_ERR(rule)) {
> +               err = PTR_ERR(rule);
> +               goto err_ucast;
> +       }
>
> -       *ucast = rule;
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +       dests[1].counter_id = mlx5_fc_id(node->mcast_counter.counter);
> +#endif
>
>         memset(dmac_c, 0, ETH_ALEN);
>         memset(dmac_v, 0, ETH_ALEN);
>         dmac_c[0] = 1;
>         dmac_v[0] = 1;
> -       rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
> -       kvfree(spec);
> +       node->mcast_rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dests, NUM_DESTS);
>         if (IS_ERR(rule)) {
>                 err = PTR_ERR(rule);
>                 goto err_mcast;
>         }
> -
> -       *mcast = rule;
> +       kvfree(spec);
> +       mlx5_vdpa_add_rx_counters(ndev, node);
>         return 0;
>
>  err_mcast:
> -       mlx5_del_flow_rules(*ucast);
> +       mlx5_del_flow_rules(node->ucast_rule);
> +err_ucast:
> +       remove_steering_counters(ndev, node);
> +out_free:
> +       kvfree(spec);
>         return err;
>  }
>
>  static void mlx5_vdpa_del_mac_vlan_rules(struct mlx5_vdpa_net *ndev,
> -                                        struct mlx5_flow_handle *ucast,
> -                                        struct mlx5_flow_handle *mcast)
> +                                        struct macvlan_node *node)
>  {
> -       mlx5_del_flow_rules(ucast);
> -       mlx5_del_flow_rules(mcast);
> +       mlx5_vdpa_remove_rx_counters(ndev, node);
> +       mlx5_del_flow_rules(node->ucast_rule);
> +       mlx5_del_flow_rules(node->mcast_rule);
>  }
>
>  static u64 search_val(u8 *mac, u16 vlan, bool tagged)
> @@ -1505,14 +1564,14 @@ static struct macvlan_node *mac_vlan_lookup(struct mlx5_vdpa_net *ndev, u64 valu
>         return NULL;
>  }
>
> -static int mac_vlan_add(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tagged) // vlan -> vid
> +static int mac_vlan_add(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vid, bool tagged)
>  {
>         struct macvlan_node *ptr;
>         u64 val;
>         u32 idx;
>         int err;
>
> -       val = search_val(mac, vlan, tagged);
> +       val = search_val(mac, vid, tagged);
>         if (mac_vlan_lookup(ndev, val))
>                 return -EEXIST;
>
> @@ -1520,12 +1579,13 @@ static int mac_vlan_add(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tagg
>         if (!ptr)
>                 return -ENOMEM;
>
> -       err = mlx5_vdpa_add_mac_vlan_rules(ndev, ndev->config.mac, vlan, tagged,
> -                                          &ptr->ucast_rule, &ptr->mcast_rule);
> +       ptr->tagged = tagged;
> +       ptr->macvlan = val;
> +       ptr->ndev = ndev;
> +       err = mlx5_vdpa_add_mac_vlan_rules(ndev, ndev->config.mac, ptr);
>         if (err)
>                 goto err_add;
>
> -       ptr->macvlan = val;
>         idx = hash_64(val, 8);
>         hlist_add_head(&ptr->hlist, &ndev->macvlan_hash[idx]);
>         return 0;
> @@ -1544,7 +1604,8 @@ static void mac_vlan_del(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tag
>                 return;
>
>         hlist_del(&ptr->hlist);
> -       mlx5_vdpa_del_mac_vlan_rules(ndev, ptr->ucast_rule, ptr->mcast_rule);
> +       mlx5_vdpa_del_mac_vlan_rules(ndev, ptr);
> +       remove_steering_counters(ndev, ptr);
>         kfree(ptr);
>  }
>
> @@ -1557,7 +1618,8 @@ static void clear_mac_vlan_table(struct mlx5_vdpa_net *ndev)
>         for (i = 0; i < MLX5V_MACVLAN_SIZE; i++) {
>                 hlist_for_each_entry_safe(pos, n, &ndev->macvlan_hash[i], hlist) {
>                         hlist_del(&pos->hlist);
> -                       mlx5_vdpa_del_mac_vlan_rules(ndev, pos->ucast_rule, pos->mcast_rule);
> +                       mlx5_vdpa_del_mac_vlan_rules(ndev, pos);
> +                       remove_steering_counters(ndev, pos);
>                         kfree(pos);
>                 }
>         }
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> index f2cef3925e5b..c90a89e1de4d 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> @@ -21,6 +21,11 @@ struct mlx5_vdpa_net_resources {
>
>  #define MLX5V_MACVLAN_SIZE 256
>
> +static inline u16 key2vid(u64 key)
> +{
> +       return (u16)(key >> 48) & 0xfff;
> +}
> +
>  struct mlx5_vdpa_net {
>         struct mlx5_vdpa_dev mvdev;
>         struct mlx5_vdpa_net_resources res;
> @@ -47,11 +52,24 @@ struct mlx5_vdpa_net {
>         struct dentry *debugfs;
>  };
>
> +struct mlx5_vdpa_counter {
> +       struct mlx5_fc *counter;
> +       struct dentry *dent;
> +       struct mlx5_core_dev *mdev;
> +};
> +
>  struct macvlan_node {
>         struct hlist_node hlist;
>         struct mlx5_flow_handle *ucast_rule;
>         struct mlx5_flow_handle *mcast_rule;
>         u64 macvlan;
> +       struct mlx5_vdpa_net *ndev;
> +       bool tagged;
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +       struct dentry *dent;
> +       struct mlx5_vdpa_counter ucast_counter;
> +       struct mlx5_vdpa_counter mcast_counter;
> +#endif
>  };
>
>  void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev);
> @@ -60,5 +78,17 @@ void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev);
>  void mlx5_vdpa_remove_rx_flow_table(struct mlx5_vdpa_net *ndev);
>  void mlx5_vdpa_add_tirn(struct mlx5_vdpa_net *ndev);
>  void mlx5_vdpa_remove_tirn(struct mlx5_vdpa_net *ndev);
> +#if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
> +void mlx5_vdpa_add_rx_counters(struct mlx5_vdpa_net *ndev,
> +                              struct macvlan_node *node);
> +void mlx5_vdpa_remove_rx_counters(struct mlx5_vdpa_net *ndev,
> +                                 struct macvlan_node *node);
> +#else
> +static inline void mlx5_vdpa_add_rx_counters(struct mlx5_vdpa_net *ndev,
> +                                            struct macvlan_node *node) {}
> +static inline void mlx5_vdpa_remove_rx_counters(struct mlx5_vdpa_net *ndev,
> +                                               struct macvlan_node *node) {}
> +#endif
> +
>
>  #endif /* __MLX5_VNET_H__ */
> --
> 2.38.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
