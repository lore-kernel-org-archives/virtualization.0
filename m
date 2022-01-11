Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D0EC433EF
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 16:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 538AD60E98;
	Tue, 11 Jan 2022 16:54:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UUszDsCA72EI; Tue, 11 Jan 2022 16:54:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E913860E8F;
	Tue, 11 Jan 2022 16:54:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD222C002F;
	Tue, 11 Jan 2022 16:54:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BD21C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 16:54:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 09D8F81D4F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 16:54:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eyImXnpoqgGe
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 16:54:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BE71C81BB2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 16:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641920069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BS2c0kmuzOx/lsNyYPfwTxQigdp6Fcgt6qDOyFgpphA=;
 b=Z2c3HjvovwvCGSwleF3L8e/7O34lxu6LBsq98xVzfdvNh4ryb73cJkDLj9WF3XLFth8Drg
 Z6+/dWM0yMP8vY9Ll87mkrCN1kHWgzFn1jkpBv7zyDVa3OuALxY554X0czs3gAEzD7g5IE
 xqRKA+Y6h97gDamfE8OAU3VkYx9npDk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-CysEDZ_cPGypbU9ZXC3RKg-1; Tue, 11 Jan 2022 11:54:22 -0500
X-MC-Unique: CysEDZ_cPGypbU9ZXC3RKg-1
Received: by mail-ed1-f71.google.com with SMTP id
 s7-20020a056402520700b003f841380832so13867003edd.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 08:54:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BS2c0kmuzOx/lsNyYPfwTxQigdp6Fcgt6qDOyFgpphA=;
 b=WEZaM6UQVmF7NkSschWtiN2i5qGNX0Lr0ZwgJdTl8NcOXRgzO2UAQzxvn6FqPXmlgv
 +QhYGujS+a2Pi/rDOlJxe6e45HK5HidEUnJX3V9Bi7XjAi4MriWSySkEIXTrrqSocurO
 vAo955oxpwZU5TVUSx6oeDeRbo3l1mK1SqzZlTq4uRdJVytlIPxAXM11StXcgVXLBknT
 63VylnZCOpwSzH63dC4dmxUiSPVTdwv7SIKIsVk9t8wEY/W7/EisIsITSkB1lPp8l5wq
 Z9e42FZw+CerGXupsIsZEUTlwmsKGWVBNFkQgXZPvPjQOldlZeWWCSjm7/gML81HK/vP
 b1RA==
X-Gm-Message-State: AOAM533j20mb09OZe0NLaUWTvRogMAOtOXLGO5+KquZDhE2NA0fPyMpo
 /zoDJI08p6rze8c2d/EH8x3VM8nujw2Ep1QnwlwMmg+NcmsFNhFdUwRelt8cfHzQjD/xB375H92
 xh/kJ5om45e4j/2ftv+3v26nNME1slS3po7JARq3Vfg==
X-Received: by 2002:a17:906:a01a:: with SMTP id
 p26mr4317648ejy.441.1641920060692; 
 Tue, 11 Jan 2022 08:54:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWcnHGClz5IqRCCLuorrmFayDZCy4UmEr8dymqkBvsiNUwFV6DPxGjTmhINYQpQ74n/OwvQA==
X-Received: by 2002:a17:906:a01a:: with SMTP id
 p26mr4317630ejy.441.1641920060450; 
 Tue, 11 Jan 2022 08:54:20 -0800 (PST)
Received: from redhat.com ([2.55.5.100])
 by smtp.gmail.com with ESMTPSA id p25sm5220376edw.75.2022.01.11.08.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jan 2022 08:54:19 -0800 (PST)
Date: Tue, 11 Jan 2022 11:54:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 2/4] vdpa/mlx5: Fix is_index_valid() to refer to features
Message-ID: <20220111115311-mutt-send-email-mst@kernel.org>
References: <20220111072253.101884-1-elic@nvidia.com>
 <20220111105509-mutt-send-email-mst@kernel.org>
 <20220111160357.GA168085@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20220111160357.GA168085@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, si-wei.liu@oracle.com
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

On Tue, Jan 11, 2022 at 06:03:57PM +0200, Eli Cohen wrote:
> On Tue, Jan 11, 2022 at 10:57:57AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Jan 11, 2022 at 09:22:53AM +0200, Eli Cohen wrote:
> > > Make sure the decision whether an index received trough a callback is
> > 
> > through
> 
> Wil fix.
> 
> > 
> > > valid or not consults the negotiated features.
> > > 
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > 
> > Which commit does this fix?
> 
> No specific commit. It's just that I get called for VQ rellated
> callbacks (e.g. get_vq_state), after the device has been reset. So this
> patch provides protection against such cases. I hit this issue while
> testing locally.

To include in the commit log then.
The point of providing the fixes tag with the commit is that it's
then easier to figure out how do changes interact with each other.

> > 
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index d1ff65065fb1..9eacfdb48434 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -133,10 +133,14 @@ struct mlx5_vdpa_virtqueue {
> > >  
> > >  static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
> > >  {
> > > -	if (unlikely(idx > mvdev->max_idx))
> > > -		return false;
> > > +	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ))) {
> > > +		if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> > > +			return idx < 2;
> > > +		else
> > > +			return idx < 3;
> > > +	}
> > >  
> > > -	return true;
> > > +	return idx <= mvdev->max_idx;
> > >  }
> > >  
> > >  struct mlx5_vdpa_net {
> > > -- 
> > > 2.34.1
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
