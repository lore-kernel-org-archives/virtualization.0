Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDABC74A5B
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 09:29:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F413840B11;
	Tue, 21 Mar 2023 09:29:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F413840B11
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nef2R0DT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ul4TznDHREKO; Tue, 21 Mar 2023 09:29:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9D82240A09;
	Tue, 21 Mar 2023 09:29:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D82240A09
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A761C0071;
	Tue, 21 Mar 2023 09:29:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B578AC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 09:29:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 841BF40B08
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 09:29:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 841BF40B08
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A-spHvi50UYM
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 09:29:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ABFBA40A09
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ABFBA40A09
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 09:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679390987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YnK+9bZZwPpOS/74aZfJ3wVOv5LWVrjm/j44hbYyduY=;
 b=Nef2R0DTo5z0YE7JLJ/Tx2k9cHT40Ye4YZUMpXQNzIzThQsLOEttvZE7CnEmnX9rfXIfn0
 hHGEQdW0w5hZH+EySiI2lniRuZgnY9YvyGzgyNJZbTtaBiMWhJsMgJDSl23Rt+oRtjLtgZ
 T7pXSwySO/TDJFL59IDgMz3iGi08fkk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-q0MEd-khNXaWev5SQrepuw-1; Tue, 21 Mar 2023 05:29:46 -0400
X-MC-Unique: q0MEd-khNXaWev5SQrepuw-1
Received: by mail-wm1-f72.google.com with SMTP id
 p10-20020a05600c358a00b003edf7d484d4so2140543wmq.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679390985;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YnK+9bZZwPpOS/74aZfJ3wVOv5LWVrjm/j44hbYyduY=;
 b=EK5yzxCghac90NXWm4z2OdZwZmU0XoRG+5jCmw6wrmr0EsD+HbgpNwkAruLUcWJJpZ
 Tm7ILkGLLqIYDIXr/hWLTL6T2uHnh+NYGLjyv9K1Rz1zcKiwhHnyBvyRaoiG/fU0yaTy
 in5JLfVB9/7MAXcGAtXUPBGf87WHmbPfuiev09Mmd/ishOgqgvlo8Rg8bWp2uawLz12C
 7mgTNEjlecglQrsY5fJirbK4BcoxsetCzx7AtLpBbUdXj7gkr+K3qSAwLF+YxDgQvorC
 TuKiJWYwTeM5EF5O4gcySQbCVRhbeNf5s4lbnodtivLnDsXbPZ/LhwwcvEaRo7PgwI8f
 YDpQ==
X-Gm-Message-State: AO0yUKVPF45J0X06CZsitJ2uH6S/Rp+YGH6nFsPgjex1b6x+AEOccSet
 Ukb9gRt+F+HzUnI48K1r0z23HNlB30iIchAr2tQprQOhzONZ4v6B6jrQjNoPT9iIRhiLojyPiBY
 Rd9YDv+rG8B5hXNlKwT9iHItuyYuq65NB7jhaKzEsBw==
X-Received: by 2002:a7b:c7c7:0:b0:3ed:eab9:976a with SMTP id
 z7-20020a7bc7c7000000b003edeab9976amr1865081wmk.5.1679390985272; 
 Tue, 21 Mar 2023 02:29:45 -0700 (PDT)
X-Google-Smtp-Source: AK7set+L8yxrNpkkgsXTefM6KFCtbwCPTbi/L/3SYED9JDBMUnQbcgCYh1jEfCuqLn/5J41gXK4qDA==
X-Received: by 2002:a7b:c7c7:0:b0:3ed:eab9:976a with SMTP id
 z7-20020a7bc7c7000000b003edeab9976amr1865071wmk.5.1679390985023; 
 Tue, 21 Mar 2023 02:29:45 -0700 (PDT)
Received: from redhat.com ([2.52.1.105]) by smtp.gmail.com with ESMTPSA id
 4-20020a05600c028400b003eb192787bfsm12931779wmk.25.2023.03.21.02.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 02:29:44 -0700 (PDT)
Date: Tue, 21 Mar 2023 05:29:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v3 2/2] vdpa/mlx5: Make VIRTIO_NET_F_MRG_RXBUF off by
 default
Message-ID: <20230321052812-mutt-send-email-mst@kernel.org>
References: <20230320114930.8457-1-elic@nvidia.com>
 <20230320114930.8457-3-elic@nvidia.com>
 <20230320155938-mutt-send-email-mst@kernel.org>
 <ff359e29-8249-8a6f-7cd3-77c5c43ff96c@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <ff359e29-8249-8a6f-7cd3-77c5c43ff96c@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, parav@mellanox.com,
 virtualization@lists.linux-foundation.org
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

On Tue, Mar 21, 2023 at 11:24:34AM +0200, Eli Cohen wrote:
> 
> On 20/03/2023 22:02, Michael S. Tsirkin wrote:
> > On Mon, Mar 20, 2023 at 01:49:30PM +0200, Eli Cohen wrote:
> > > One can still enable it when creating the vdpa device using vdpa tool by
> > > providing features that include it.
> > > 
> > > For example:
> > > $ vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 device_features 0x300cb982b
> > > 
> > > Please be aware that this feature was not supported before the previous
> > > patch in this list was introduced so we don't change user experience.
> > so I would  say the patches have to be reordered to avoid a regression?
> Yes, I can do that.
> > 
> > > Current firmware versions show degradation in packet rate when using
> > > MRG_RXBUF. Users who favor memory saving over packet rate could enable
> > > this feature but we want to keep it off by default.
> > > 
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > OK and when future firmware will (maybe) fix this up how
> > will you know it's ok to enable by default?
> > Some version check I guess?
> > It would be better if firmware specified flags to enable
> > by default ...
> Currently there are no flags for that so let's just keep the default off.

Right but I mean, why are mrg buffers slow? It's a firmware bug right?

> > 
> > > ---
> > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 5285dd76c793..24397a71d6f3 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -3146,6 +3146,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> > >   			return -EINVAL;
> > >   		}
> > >   		device_features &= add_config->device_features;
> > > +	} else {
> > > +		device_features &= ~BIT_ULL(VIRTIO_NET_F_MRG_RXBUF);
> > >   	}
> > >   	if (!(device_features & BIT_ULL(VIRTIO_F_VERSION_1) &&
> > >   	      device_features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM))) {
> > > -- 
> > > 2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
