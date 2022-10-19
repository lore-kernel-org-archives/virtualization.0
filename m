Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB6AC433FE
	for <virtualization@archiver.kernel.org>; Wed, 19 Oct 2022 05:39:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35A0C402F3;
	Wed, 19 Oct 2022 05:39:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 35A0C402F3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BOIIu+wk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6rC5cq6_4B9E; Wed, 19 Oct 2022 05:39:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 567E640305;
	Wed, 19 Oct 2022 05:39:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 567E640305
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 052CBC0032;
	Wed, 19 Oct 2022 05:39:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14613C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 05:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D0B1D402F3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 05:39:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D0B1D402F3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EOoie51ryFKE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 05:39:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 51D0F402E0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 51D0F402E0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 05:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666157964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TkKMuh+55DvT4EGTiPQiYJq9SDhwxssmhp76qd3oqnI=;
 b=BOIIu+wkDe4PuLk8/Na1TyibYDu4ZaQG6BBD7tpZ5O08BVItXdtAzHeD/c3m3EsGDyvopE
 s37xiGIJh3s0QItV5DSxwfoVK9mbOXzxKf6XMWn5ooFHUCkoOicSz0hpYkOSDwuyfn9/ew
 f/S5gQR6Nx74q+sIGqqQ3Te315+ZAmw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-vPzhEkb0OM-82ZzfMWlQ0A-1; Wed, 19 Oct 2022 01:39:23 -0400
X-MC-Unique: vPzhEkb0OM-82ZzfMWlQ0A-1
Received: by mail-ej1-f71.google.com with SMTP id
 ht14-20020a170907608e00b0078d437c268dso7618990ejc.20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 22:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TkKMuh+55DvT4EGTiPQiYJq9SDhwxssmhp76qd3oqnI=;
 b=eQHAtDTkDqcG3a6LJCHie+kSDqj01LnfcPvPLvAF5OUfB2CSciNbv7cw8KVScrWgTC
 hHEA8sQZ43kUpQIFCIRQxvv3LuBcUukkgdfFkxg7JqRcpgqzMvXK6mkgPpv6eTu8kHV2
 n0WMGi+sv6GCoFjOXXlXqAqxU88wfZqt4VguRTNJyLogcK6rhqYQXjsi4tmutuEt7Kpf
 xk8yDINb1aEEnCSkWHRkHX+TfA70J2ivlEmpRck3sCXxUWkwP13Smf2+xWmBjQxzg76V
 vYu+0zCgTC3F0oYUyWNSRsA8TqvEcp3mk9GCjhiQR87SEepzeSF5ai4dkcpWlVIkYj1y
 Cr/g==
X-Gm-Message-State: ACrzQf20Z7iGuidgkPpU+Vvtpasz/szxZfXrxrpZIIDxmYqWYP7ilXIk
 ZFhauINzkl2qwhO6m7Xh41gMZUV52g4i5z5HIAsVI8yyWg9tWsHt4KOuUWxXfvwKGZnB57YUNDc
 cIgRSVnraVrO6u6xJAt04iHyuao/6bgxHMSPOZLD9vA==
X-Received: by 2002:a17:907:970b:b0:78d:8d70:e4e8 with SMTP id
 jg11-20020a170907970b00b0078d8d70e4e8mr5096292ejc.614.1666157961863; 
 Tue, 18 Oct 2022 22:39:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7UHOeLw30fRkiNTxXa4b/V8OQ9Xj1Rly0I9lVeDKrAnPncM8RKf+ScmJKpOWADpEfwADI6vA==
X-Received: by 2002:a17:907:970b:b0:78d:8d70:e4e8 with SMTP id
 jg11-20020a170907970b00b0078d8d70e4e8mr5096282ejc.614.1666157961674; 
 Tue, 18 Oct 2022 22:39:21 -0700 (PDT)
Received: from redhat.com ([2.54.191.184]) by smtp.gmail.com with ESMTPSA id
 c21-20020a17090603d500b00764a76d5888sm8346925eja.27.2022.10.18.22.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Oct 2022 22:39:21 -0700 (PDT)
Date: Wed, 19 Oct 2022 01:39:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 1/4] vdpa/mlx5: Fix rule forwarding VLAN to TIR
Message-ID: <20221019013733-mutt-send-email-mst@kernel.org>
References: <20221018111232.4021-1-elic@nvidia.com>
 <20221018111232.4021-2-elic@nvidia.com>
 <7eceaaf2-753a-8ff8-4014-39314b31d47a@oracle.com>
 <DM8PR12MB540062ECEFFA463C69FD08C9AB2B9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20221019013402-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400D576AB4F9EE03205A919AB2B9@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB5400D576AB4F9EE03205A919AB2B9@DM8PR12MB5400.namprd12.prod.outlook.com>
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

On Wed, Oct 19, 2022 at 05:36:17AM +0000, Eli Cohen wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, 19 October 2022 8:34
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: Si-Wei Liu <si-wei.liu@oracle.com>; jasowang@redhat.com; linux-
> > kernel@vger.kernel.org; virtualization@lists.linux-foundation.org;
> > eperezma@redhat.com; lulu@redhat.com
> > Subject: Re: [PATCH 1/4] vdpa/mlx5: Fix rule forwarding VLAN to TIR
> > 
> > On Wed, Oct 19, 2022 at 05:31:48AM +0000, Eli Cohen wrote:
> > > > From: Si-Wei Liu <si-wei.liu@oracle.com>
> > > > Sent: Tuesday, 18 October 2022 22:21
> > > > To: Eli Cohen <elic@nvidia.com>; mst@redhat.com; jasowang@redhat.com;
> > > > linux-kernel@vger.kernel.org; virtualization@lists.linux-foundation.org
> > > > Cc: eperezma@redhat.com; lulu@redhat.com
> > > > Subject: Re: [PATCH 1/4] vdpa/mlx5: Fix rule forwarding VLAN to TIR
> > > >
> > > > Hi Eli,
> > > >
> > > > It's not for this patch but something related, so just a friendly
> > > > heads-up. I haven't validated the VLAN tagging behavior yet for mlx5
> > > > vdpa, but from my quick read of the code it doesn't seem it
> > > > differentiates the case with and without VIRTIO_NET_F_CTRL_VLAN, to be
> > > > compatible/compliant with what's been implemented in QEMU software (a
> > > > spec addendum was filed as requested by Michael):
> > > >
> > > > https://github.com/oasis-tcs/virtio-spec/issues/147
> > > >
> > > > - when VIRTIO_NET_F_CTRL_VLAN is negotiated, the device starts with
> > > > all VLANs filtered (meaning only untagged traffic can be received,
> > > > and traffic with VLAN tag will be dropped).
> > > >
> > > > - when VIRTIO_NET_F_CTRL_VLAN is not negotiated, all traffic including
> > > > untagged and tagged can be received.
> > > >
> > > > Can you please help check if we need further fix in terms of VLAN tagging?
> > > >
> > >
> > > Sure. It's broken today. I will fix this to conform to the above requirements
> > and send V1.
> > 
> > Did you mean v2?
> > 
> 
> I count from 0 and have been following this scheme but I can make it v2 if that's the norm.

Yes, most people seem to count patches from 1 so [PATCH] is followed by
[PATCH v2].  I don't know why. But it doesn't matter much - I just
wanted to understand whether you will be sending a new version of this
patchset. I know now.


> > > > Thanks,
> > > > -Siwei
> > > >
> > > >
> > > > On 10/18/2022 4:12 AM, Eli Cohen wrote:
> > > > > Set the VLAN id to the header values field instead of overwriting the
> > > > > headers criteria field.
> > > > >
> > > > > Before this fix, VLAN filtering would not really work and tagged packets
> > > > > would be forwarded unfiltered to the TIR.
> > > > >
> > > > > Fixes: baf2ad3f6a98 ("vdpa/mlx5: Add RX MAC VLAN filter support")
> > > > >
> > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > > >
> > > > > ---
> > > > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
> > > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > index 90913365def4..dd29fdfc24ed 100644
> > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > @@ -1472,7 +1472,7 @@ static int
> > mlx5_vdpa_add_mac_vlan_rules(struct
> > > > mlx5_vdpa_net *ndev, u8 *mac,
> > > > >   	if (tagged) {
> > > > >   		MLX5_SET(fte_match_set_lyr_2_4, headers_v, cvlan_tag, 1);
> > > > >   		MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c,
> > > > first_vid);
> > > > > -		MLX5_SET(fte_match_set_lyr_2_4, headers_c, first_vid, vid);
> > > > > +		MLX5_SET(fte_match_set_lyr_2_4, headers_v, first_vid, vid);
> > > > >   	}
> > > > >   	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
> > > > >   	dest.type = MLX5_FLOW_DESTINATION_TYPE_TIR;
> > >
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
