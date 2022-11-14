Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45146C4332F
	for <virtualization@archiver.kernel.org>; Mon, 14 Nov 2022 04:39:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8B1C40860;
	Mon, 14 Nov 2022 04:39:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B8B1C40860
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Oud8eiD7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Tmgn0iVzsJM; Mon, 14 Nov 2022 04:39:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DBCD64069B;
	Mon, 14 Nov 2022 04:39:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DBCD64069B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2391C0032;
	Mon, 14 Nov 2022 04:39:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 151F3C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD77D400F6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:39:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD77D400F6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Oud8eiD7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jhPHVqR8IltE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:39:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1AA97400DA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1AA97400DA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668400750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2P5JLtakyBrCkExNJO7eBOS82+EuGUA4zafN/5TFNYg=;
 b=Oud8eiD7/A7jN6Kk865nmcX0ErfnY2hIrHUp9uNDdmpC9FvoETCKwwlEueDtUK04F2cNam
 NsuKyBwNLebgThDIBqDHR7MHU+3DIBc7QqYtD6aKZpVVMLe6v4lLTdFpkBy5Drt5DFayw6
 6AQRYxJPdymNWFawmJEeLb10m/rGuXs=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-495-AQMUTIU5OeKKqH2CfmY9qA-1; Sun, 13 Nov 2022 23:39:07 -0500
X-MC-Unique: AQMUTIU5OeKKqH2CfmY9qA-1
Received: by mail-ot1-f70.google.com with SMTP id
 cj4-20020a056830640400b0065c0c211f4dso5641916otb.8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 20:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2P5JLtakyBrCkExNJO7eBOS82+EuGUA4zafN/5TFNYg=;
 b=WBfzxVsFfZg6vdCo50rTjIvbZ09JDvE5YbXHxGkqsuEfhtzQpQulye0jM4C73xMvht
 j4iEZl5ynwRmrmndKzH6ZT9zrovyUz+BN1e1TZ5z34PXAwyST4h836GkbY2PfideYlHM
 rhFExHM3GWS89I8quTarAegYE49WflefhDgX90OYNuCBrF3XmRY6NMkn5m4tdC5tUGna
 ODX8gvJAlmXTvhCnfteqfShk9rjUeiGdqGlmnODSTsiTCqzwyEXD0FNR3gFKQTG9RtZw
 NOVmPf7eWKFaZ+d+acMBwaco9EbiFYCPKH26DPl5+aNN1dpWgDHBzFLlOtqJl6W1yA2g
 q6fQ==
X-Gm-Message-State: ANoB5pmqgsSbc31FZ1uvM/ejPDgkmdGnHi7rpWJ3bGjNFjvLffJTSXcz
 Gc5P4BIsCFOnP9NEANrq1tt5uFOM3LtbQUqJK69tMrTUjqZG0GfexwmAxD91mkKju23Srthz6Xr
 NCpY+XQ8gSc3H668h6W+UC9hMz/OiECA+ETxzoSK/Z2Kir67Ci4aSwEJkhQ==
X-Received: by 2002:a05:6808:22a1:b0:359:f5eb:82ec with SMTP id
 bo33-20020a05680822a100b00359f5eb82ecmr4892966oib.280.1668400746091; 
 Sun, 13 Nov 2022 20:39:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7fJUsmjqI+Jmj9tM/5tR+JUN3DdIOrpKo3YC1vWG9405AVoIjCJXIogxKiZwKraUv6o3fb/hS8tFzrq2UyCr4=
X-Received: by 2002:a05:6808:22a1:b0:359:f5eb:82ec with SMTP id
 bo33-20020a05680822a100b00359f5eb82ecmr4892963oib.280.1668400745912; Sun, 13
 Nov 2022 20:39:05 -0800 (PST)
MIME-Version: 1.0
References: <20221113134442.152695-1-elic@nvidia.com>
 <20221113134442.152695-2-elic@nvidia.com>
In-Reply-To: <20221113134442.152695-2-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Nov 2022 12:38:54 +0800
Message-ID: <CACGkMEssbrOaYJDrHb1e_brjteKk4Xfw+sVogeiRbYE0RiMgRA@mail.gmail.com>
Subject: Re: [PATCH 1/7] vdpa/mlx5: Fix rule forwarding VLAN to TIR
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
> Set the VLAN id to the header values field instead of overwriting the
> headers criteria field.
>
> Before this fix, VLAN filtering would not really work and tagged packets
> would be forwarded unfiltered to the TIR.
>
> In addition modify the logic so that VLAN filtering is enforced only
> when VIRTIO_NET_F_CTRL_VLAN is negotiated. When not negotiated, all
> incoming traffic is accepted as long as it is targeting the net device's
> MAC address.
>
> Fixes: baf2ad3f6a98 ("vdpa/mlx5: Add RX MAC VLAN filter support")
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 90913365def4..ea95081eca0c 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1468,11 +1468,13 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
>         dmac_v = MLX5_ADDR_OF(fte_match_param, headers_v, outer_headers.dmac_47_16);
>         eth_broadcast_addr(dmac_c);
>         ether_addr_copy(dmac_v, mac);
> -       MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
> +       if (ndev->mvdev.actual_features & VIRTIO_NET_F_CTRL_VLAN) {
> +               MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
> +               MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, first_vid);
> +       }
>         if (tagged) {
>                 MLX5_SET(fte_match_set_lyr_2_4, headers_v, cvlan_tag, 1);
> -               MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, first_vid);
> -               MLX5_SET(fte_match_set_lyr_2_4, headers_c, first_vid, vid);
> +               MLX5_SET(fte_match_set_lyr_2_4, headers_v, first_vid, vid);
>         }
>         flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
>         dest.type = MLX5_FLOW_DESTINATION_TYPE_TIR;
> @@ -1821,6 +1823,9 @@ static virtio_net_ctrl_ack handle_ctrl_vlan(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>         size_t read;
>         u16 id;
>
> +       if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VLAN)))
> +               return status;

Nit: this seems unrelated to the patch.

Other than this.

Acked-by: Jason Wang <jasowang@redhat.com>

> +
>         switch (cmd) {
>         case VIRTIO_NET_CTRL_VLAN_ADD:
>                 read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, &vlan, sizeof(vlan));
> --
> 2.38.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
