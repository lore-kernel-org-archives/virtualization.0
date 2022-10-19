Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F088C4332F
	for <virtualization@archiver.kernel.org>; Wed, 19 Oct 2022 05:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9CD5D40B68;
	Wed, 19 Oct 2022 05:34:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9CD5D40B68
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dKB0rpGV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vZu38IHjCXu2; Wed, 19 Oct 2022 05:34:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1374140111;
	Wed, 19 Oct 2022 05:34:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1374140111
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D290DC0032;
	Wed, 19 Oct 2022 05:34:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0E98C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 05:34:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C9BF261178
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 05:34:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C9BF261178
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dKB0rpGV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4qWQo2zJE00M
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 05:34:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 55F1B61159
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 55F1B61159
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 05:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666157673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Vfj5MuYwEDLW1gKn2gdMUxDMm1tBwT8JsH+LnyHaeM=;
 b=dKB0rpGVtGVo+7QzmtnKzVA+/H5FuqWnj0Rbw+zMa+ZpXgYzdsxrN2e+FsG3m11xvxeRE4
 qt2Flp1Wq+XcNdelpT6gWraTvhinJZ55KuJyAZE8sLJCJygN6lKPvhyf4Cs8wQ7OYmDpxQ
 rXCPdPz9goCy1vw/mlshSSTJdcI5d9s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-KNq7cv0pOMm0zs5g9mlq7Q-1; Wed, 19 Oct 2022 01:34:32 -0400
X-MC-Unique: KNq7cv0pOMm0zs5g9mlq7Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 o18-20020a05600c4fd200b003c6ceb1339bso126360wmq.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 22:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Vfj5MuYwEDLW1gKn2gdMUxDMm1tBwT8JsH+LnyHaeM=;
 b=AiEMXv9MUXK4c6e8MWSusT6Q42rDf0tVhD1g10PdJwbnQR+Px9LrdsjOKJRc6w/wzP
 z7Dpi3eWuEOEDHHKDFkwmVKyhMu4Ws5ZrwTaegiROiPY9bgfh+nXLPFlsql63/v+diA4
 f8oerEESvpCkcpYNzN++6c+RIXZq8lFPaNvZx1DdlHJtELFcZHRBUY4u8p7yywMS6bvM
 kCwIkDZFvc+LdCsstki90aQ/cRVCUsEC7CDZdRTyfYdiPi+f2P45OEE+9ZdgQJ0139xS
 OXdkgf6yWtW+/JB0mYqc5dSY/eN6JP3kObRyEYa6DoXx//fRzvA69FWoeMmvMBvpjPs8
 YZtA==
X-Gm-Message-State: ACrzQf0UTN4e2F2qjz1WemYLb4rht7pdT3NBEfj29MsOlFuUVwALZItK
 VM4yQ6OpOp+cAtU7uRyaXc7t/1MNSViVMoWIioaN/tlGbD6S7UWfUI9fqDuZMoOPVQQVHBnox4O
 wPWYUiHh21poWZaaCAl499SY/x4m1zcJpj1X0XrD0ww==
X-Received: by 2002:a05:6000:1e17:b0:22e:618f:b9d8 with SMTP id
 bj23-20020a0560001e1700b0022e618fb9d8mr3690572wrb.280.1666157670219; 
 Tue, 18 Oct 2022 22:34:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7o9MFWDHGx4YaY6MVWmGaWkVEK4VcTVqnehSs1l742aYijDHIWJsqEoztB+11w7fU7P2ZjsA==
X-Received: by 2002:a05:6000:1e17:b0:22e:618f:b9d8 with SMTP id
 bj23-20020a0560001e1700b0022e618fb9d8mr3690556wrb.280.1666157669949; 
 Tue, 18 Oct 2022 22:34:29 -0700 (PDT)
Received: from redhat.com ([2.54.191.184]) by smtp.gmail.com with ESMTPSA id
 p39-20020a05600c1da700b003c6d21a19a0sm15231591wms.29.2022.10.18.22.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Oct 2022 22:34:29 -0700 (PDT)
Date: Wed, 19 Oct 2022 01:34:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 1/4] vdpa/mlx5: Fix rule forwarding VLAN to TIR
Message-ID: <20221019013402-mutt-send-email-mst@kernel.org>
References: <20221018111232.4021-1-elic@nvidia.com>
 <20221018111232.4021-2-elic@nvidia.com>
 <7eceaaf2-753a-8ff8-4014-39314b31d47a@oracle.com>
 <DM8PR12MB540062ECEFFA463C69FD08C9AB2B9@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB540062ECEFFA463C69FD08C9AB2B9@DM8PR12MB5400.namprd12.prod.outlook.com>
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

On Wed, Oct 19, 2022 at 05:31:48AM +0000, Eli Cohen wrote:
> > From: Si-Wei Liu <si-wei.liu@oracle.com>
> > Sent: Tuesday, 18 October 2022 22:21
> > To: Eli Cohen <elic@nvidia.com>; mst@redhat.com; jasowang@redhat.com;
> > linux-kernel@vger.kernel.org; virtualization@lists.linux-foundation.org
> > Cc: eperezma@redhat.com; lulu@redhat.com
> > Subject: Re: [PATCH 1/4] vdpa/mlx5: Fix rule forwarding VLAN to TIR
> > 
> > Hi Eli,
> > 
> > It's not for this patch but something related, so just a friendly
> > heads-up. I haven't validated the VLAN tagging behavior yet for mlx5
> > vdpa, but from my quick read of the code it doesn't seem it
> > differentiates the case with and without VIRTIO_NET_F_CTRL_VLAN, to be
> > compatible/compliant with what's been implemented in QEMU software (a
> > spec addendum was filed as requested by Michael):
> > 
> > https://github.com/oasis-tcs/virtio-spec/issues/147
> > 
> > - when VIRTIO_NET_F_CTRL_VLAN is negotiated, the device starts with
> > all VLANs filtered (meaning only untagged traffic can be received,
> > and traffic with VLAN tag will be dropped).
> > 
> > - when VIRTIO_NET_F_CTRL_VLAN is not negotiated, all traffic including
> > untagged and tagged can be received.
> > 
> > Can you please help check if we need further fix in terms of VLAN tagging?
> > 
> 
> Sure. It's broken today. I will fix this to conform to the above requirements and send V1.

Did you mean v2?

> > Thanks,
> > -Siwei
> > 
> > 
> > On 10/18/2022 4:12 AM, Eli Cohen wrote:
> > > Set the VLAN id to the header values field instead of overwriting the
> > > headers criteria field.
> > >
> > > Before this fix, VLAN filtering would not really work and tagged packets
> > > would be forwarded unfiltered to the TIR.
> > >
> > > Fixes: baf2ad3f6a98 ("vdpa/mlx5: Add RX MAC VLAN filter support")
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > 
> > > ---
> > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 90913365def4..dd29fdfc24ed 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -1472,7 +1472,7 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct
> > mlx5_vdpa_net *ndev, u8 *mac,
> > >   	if (tagged) {
> > >   		MLX5_SET(fte_match_set_lyr_2_4, headers_v, cvlan_tag, 1);
> > >   		MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c,
> > first_vid);
> > > -		MLX5_SET(fte_match_set_lyr_2_4, headers_c, first_vid, vid);
> > > +		MLX5_SET(fte_match_set_lyr_2_4, headers_v, first_vid, vid);
> > >   	}
> > >   	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
> > >   	dest.type = MLX5_FLOW_DESTINATION_TYPE_TIR;
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
