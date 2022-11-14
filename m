Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC732C433FE
	for <virtualization@archiver.kernel.org>; Mon, 14 Nov 2022 07:27:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49425813A9;
	Mon, 14 Nov 2022 07:27:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49425813A9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EUDIQ9f5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gmIUqiyJzrjF; Mon, 14 Nov 2022 07:27:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A4602813D7;
	Mon, 14 Nov 2022 07:27:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A4602813D7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D9FEC0033;
	Mon, 14 Nov 2022 07:27:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93CA7C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 07:27:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6127060D89
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 07:27:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6127060D89
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EUDIQ9f5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JddFFEIprz1d
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 07:27:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F27D760D80
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F27D760D80
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 07:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668410820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MOMWpm5CCVU3kUo0zgauw8Rj2SwIfM2Q5f5rHRWKMIU=;
 b=EUDIQ9f5sIxU6weuR/pXgDfByUZG9YtLXKVw4Er5hrFcj1ZtRp3ojyqvIj8BxmsephX9TK
 y4iuQ3pIa8jqXvEuNQ538doo8qfuonO+V54fxvj/DIjsa5x6GsjQGORYy/WAEL+64XNYqJ
 UrZP56Eb5PqQQUVrGCQq8BJ+69zDN6w=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-403-agdmpSsuNsaN4l-8flG-bw-1; Mon, 14 Nov 2022 02:26:59 -0500
X-MC-Unique: agdmpSsuNsaN4l-8flG-bw-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-13cc24bcecbso5068402fac.14
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 23:26:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MOMWpm5CCVU3kUo0zgauw8Rj2SwIfM2Q5f5rHRWKMIU=;
 b=o5DieC4Jc03bUN2CY1jKUmAs38o9jIsU/Vt836/xKoycKGlSu67VFyMpclf4tRq3Ex
 gKVI5YBWTUoOtL1JFoykqLNmim0KT4mDoEQTb+ohvaSBEPlwhc9z+EI8hnJJFi1OIIGH
 lCj/j0UdPFCvBvGxbHFJ4tQs0ijjp5GYdl2gV8xGYBtdQRwF5NCAuH1ODNaceDAnzcbx
 3oEWPSsRUqBHsqLQYU31m+9MUENFwyR0EIAh1UsiO7lsPs34jH0TY1rLlXPGuTQ+LVYR
 BSweCPTBDlPQ9fg3onIaTOGE0HkZnH/CtjY3WC9QPPfGP0l9aGRPGRjEclI/FrXEHmhL
 KltQ==
X-Gm-Message-State: ANoB5pnUVkR+4dCcHDzSLDbwZHbIePhPuUEHrHrZMcAHdhUNKRE/MImA
 2nfXt6d4MedqwnjHhaguzZNnoMNK3mGQkO79tkoPxJlG66jXqTtVnjB9qsrbcObNt+aAR44tanT
 0NaO17tvvjVzl1vasnA6I9rsmeEMa+5ZvQ2MhpDsDXyE7nEgJMa/nwNYlvQ==
X-Received: by 2002:a54:4605:0:b0:354:68aa:9c59 with SMTP id
 p5-20020a544605000000b0035468aa9c59mr5184756oip.35.1668410818399; 
 Sun, 13 Nov 2022 23:26:58 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5C84VexBmAOzE61dCyw9QsbIJnHVsDzgFJer5/jEMAQ8yPSAWkeqlIJU/M8//CIQ5zkOkg3LjzGkZPhWF85AM=
X-Received: by 2002:a54:4605:0:b0:354:68aa:9c59 with SMTP id
 p5-20020a544605000000b0035468aa9c59mr5184750oip.35.1668410818105; Sun, 13 Nov
 2022 23:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20221113134442.152695-1-elic@nvidia.com>
 <20221113134442.152695-6-elic@nvidia.com>
In-Reply-To: <20221113134442.152695-6-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Nov 2022 15:26:46 +0800
Message-ID: <CACGkMEs4YpUUtkW-rWkQpYQY4vFLh2YcwY6bSqUGTd60Xq37_w@mail.gmail.com>
Subject: Re: [PATCH 5/7] vdpa/mlx5: Add RX counters to debugfs
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
> ---
>  drivers/vdpa/Kconfig              |  12 +++
>  drivers/vdpa/mlx5/net/debug.c     |  86 ++++++++++++++++++++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 118 +++++++++++++++++++++++-------
>  drivers/vdpa/mlx5/net/mlx5_vnet.h |  30 ++++++++
>  4 files changed, 218 insertions(+), 28 deletions(-)
>

[...]

> +       vid = key2vid(node->macvlan);
>         spec->match_criteria_enable = MLX5_MATCH_OUTER_HEADERS;
>         headers_c = MLX5_ADDR_OF(fte_match_param, spec->match_criteria, outer_headers);
>         headers_v = MLX5_ADDR_OF(fte_match_param, spec->match_value, outer_headers);
> @@ -1430,48 +1475,62 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
>         dmac_v = MLX5_ADDR_OF(fte_match_param, headers_v, outer_headers.dmac_47_16);
>         eth_broadcast_addr(dmac_c);
>         ether_addr_copy(dmac_v, mac);
> -       if (ndev->mvdev.actual_features & VIRTIO_NET_F_CTRL_VLAN) {
> +       if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VLAN)) {


This seems like a fix for patch 1? If yes, let's just squash this.

Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
