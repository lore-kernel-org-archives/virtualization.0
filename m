Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D31C433FE
	for <virtualization@archiver.kernel.org>; Mon, 14 Nov 2022 08:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 294BE81678;
	Mon, 14 Nov 2022 08:07:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 294BE81678
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TYISPv/u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ru5wLXK0PA1c; Mon, 14 Nov 2022 08:07:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A3D648148F;
	Mon, 14 Nov 2022 08:07:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A3D648148F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82BB1C0033;
	Mon, 14 Nov 2022 08:07:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2D1AC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 08:07:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 723E7409E1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 08:07:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 723E7409E1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TYISPv/u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3dpLyS0Qj2l6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 08:07:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89912409D3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 89912409D3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 08:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668413240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TVnIeQwtdstHSZF4xEUKJ/5PTA6Y2F9kx5jkqLUsp8M=;
 b=TYISPv/u2Odp0rb9U4/B+anslTLSwqiARVyRazjePz+k3GFDNo29hBewFZAOFMbu3a7kk3
 Z8zcouiowoFqGDX1grKBJEug/z/TDWBkqv1RqmH5mQTeus/nIFIAJEs8nau7nPTszSneED
 c3lYkAuT+gwmXwGxwhw8ZLJkS6++ykc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-279-LDzCb2IvPQuM8LMnbCw-Vw-1; Mon, 14 Nov 2022 03:07:19 -0500
X-MC-Unique: LDzCb2IvPQuM8LMnbCw-Vw-1
Received: by mail-qk1-f200.google.com with SMTP id
 bs7-20020a05620a470700b006fac7447b1cso10479418qkb.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 00:07:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TVnIeQwtdstHSZF4xEUKJ/5PTA6Y2F9kx5jkqLUsp8M=;
 b=NmevOwU9fOvdiuusECia7EKM8GihgeV4XbrMLZf4jbPIQURlGAgRg0fy7thtLxIozA
 o+H74o7GX0Vaegf+Muwb33Dqu5s9I6MzsX84vrk4NwQL3BhasdELYy0Bys4yCxiY9exc
 LXbQlIRNiQJ1mu6Of6Quw+IJ0IGSxxRpiwvhujsQkAGZ2koBWAZowV9czMgo/pQdeMGO
 jnnEb2U/XZOCQdIPVeXJTr92I++O1zmk5ErRmkZQ/O0TH/9diyTo/sYr8WKKkZqgTzYu
 RwNh81mi+7tnCTSCAahoOkzmo44vw/vZG6MGkk/u4cTv0TUvY22+NfpYC+WHXN8TBDHS
 bkVw==
X-Gm-Message-State: ANoB5pngoufa+9SmMQFCb3bMvNylmbjf+b9BTpm6lFJxujR+tmlg4BoB
 UaY0cE8OmdSV3rcHZzd8DrfI68b+GZRVnD6lar5VN9RLv3DQ1cT+WU//6JF6Mja1yiINAm/m8OA
 ORhOdmVqSU7UX9UaUH+1lXQ7ekYIUU4pENz1XbNCDfA==
X-Received: by 2002:a05:6214:3c89:b0:4bb:8572:999f with SMTP id
 ok9-20020a0562143c8900b004bb8572999fmr11321780qvb.6.1668413238574; 
 Mon, 14 Nov 2022 00:07:18 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4pm2rdiv95qqEXqf4i9Btz1mfW4FcVF1GpGUkqUaJB6DHaE7Ol2z1XRIaI+UYmqbJVmvEtSw==
X-Received: by 2002:a05:6214:3c89:b0:4bb:8572:999f with SMTP id
 ok9-20020a0562143c8900b004bb8572999fmr11321764qvb.6.1668413238353; 
 Mon, 14 Nov 2022 00:07:18 -0800 (PST)
Received: from redhat.com ([37.19.196.93]) by smtp.gmail.com with ESMTPSA id
 bk40-20020a05620a1a2800b006fa4b111c76sm6058153qkb.36.2022.11.14.00.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Nov 2022 00:07:17 -0800 (PST)
Date: Mon, 14 Nov 2022 03:07:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 1/7] vdpa/mlx5: Fix rule forwarding VLAN to TIR
Message-ID: <20221114030644-mutt-send-email-mst@kernel.org>
References: <20221113134442.152695-1-elic@nvidia.com>
 <20221113134442.152695-2-elic@nvidia.com>
 <CACGkMEssbrOaYJDrHb1e_brjteKk4Xfw+sVogeiRbYE0RiMgRA@mail.gmail.com>
 <DM8PR12MB54006C35F5CDB250CA757108AB059@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB54006C35F5CDB250CA757108AB059@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "lulu@redhat.com" <lulu@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>
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

On Mon, Nov 14, 2022 at 06:44:30AM +0000, Eli Cohen wrote:
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Monday, 14 November 2022 6:39
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: mst@redhat.com; linux-kernel@vger.kernel.org; virtualization@lists.linux-
> > foundation.org; si-wei.liu@oracle.com; eperezma@redhat.com;
> > lulu@redhat.com
> > Subject: Re: [PATCH 1/7] vdpa/mlx5: Fix rule forwarding VLAN to TIR
> > 
> > On Sun, Nov 13, 2022 at 9:45 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > Set the VLAN id to the header values field instead of overwriting the
> > > headers criteria field.
> > >
> > > Before this fix, VLAN filtering would not really work and tagged packets
> > > would be forwarded unfiltered to the TIR.
> > >
> > > In addition modify the logic so that VLAN filtering is enforced only
> > > when VIRTIO_NET_F_CTRL_VLAN is negotiated. When not negotiated, all
> > > incoming traffic is accepted as long as it is targeting the net device's
> > > MAC address.
> > >
> > > Fixes: baf2ad3f6a98 ("vdpa/mlx5: Add RX MAC VLAN filter support")
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 90913365def4..ea95081eca0c 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -1468,11 +1468,13 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct
> > mlx5_vdpa_net *ndev, u8 *mac,
> > >         dmac_v = MLX5_ADDR_OF(fte_match_param, headers_v,
> > outer_headers.dmac_47_16);
> > >         eth_broadcast_addr(dmac_c);
> > >         ether_addr_copy(dmac_v, mac);
> > > -       MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
> > > +       if (ndev->mvdev.actual_features & VIRTIO_NET_F_CTRL_VLAN) {
> > > +               MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
> > > +               MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, first_vid);
> > > +       }
> > >         if (tagged) {
> > >                 MLX5_SET(fte_match_set_lyr_2_4, headers_v, cvlan_tag, 1);
> > > -               MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, first_vid);
> > > -               MLX5_SET(fte_match_set_lyr_2_4, headers_c, first_vid, vid);
> > > +               MLX5_SET(fte_match_set_lyr_2_4, headers_v, first_vid, vid);
> > >         }
> > >         flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
> > >         dest.type = MLX5_FLOW_DESTINATION_TYPE_TIR;
> > > @@ -1821,6 +1823,9 @@ static virtio_net_ctrl_ack handle_ctrl_vlan(struct
> > mlx5_vdpa_dev *mvdev, u8 cmd)
> > >         size_t read;
> > >         u16 id;
> > >
> > > +       if (!(ndev->mvdev.actual_features &
> > BIT_ULL(VIRTIO_NET_F_CTRL_VLAN)))
> > > +               return status;
> > 
> > Nit: this seems unrelated to the patch.
> > 
> Will put in another patch


OK since you are doing a new version, please split fixes and
features in two patchsets. Thanks!

> > Other than this.
> > 
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > 
> > > +
> > >         switch (cmd) {
> > >         case VIRTIO_NET_CTRL_VLAN_ADD:
> > >                 read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, &vlan,
> > sizeof(vlan));
> > > --
> > > 2.38.1
> > >
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
