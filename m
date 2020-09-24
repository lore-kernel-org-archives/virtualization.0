Return-Path: <SRS0=sVkE=DB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE748C4727D
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 09:31:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238DB2068D
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 09:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhARyFvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238DB2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8B0E286A1D;
	Thu, 24 Sep 2020 09:31:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ct6NEYeSQezJ; Thu, 24 Sep 2020 09:31:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EA35786A24;
	Thu, 24 Sep 2020 09:31:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1C73C0859;
	Thu, 24 Sep 2020 09:31:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAC42C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:31:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B23A32E0F1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:31:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id APKqYuw0R3dy
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:31:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 0AF8A2E0D9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Cn5Bd+L14KVOkBy3I0zvESfB5G1klOhcdE8jhSzxAk=;
 b=IhARyFvHvpZlZ/krID/fIRf4vc0YsxwBi81i28Mxh3xHWc5vtmrV48qwdkI1z0WTYPtXuR
 3v49Xz3+dCAJadXSQy2HNVKytYPwDfKl+CiTEIBcFxvu4z3VZJRhgU/gPC6VZyuPPOBs5v
 +SxZ1tp6Lp2ecCrUT4cBgJVm8Q7/C+g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-xqCs-dQaMfSobIUw21Xluw-1; Thu, 24 Sep 2020 05:31:01 -0400
X-MC-Unique: xqCs-dQaMfSobIUw21Xluw-1
Received: by mail-wr1-f70.google.com with SMTP id o6so1009265wrp.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 02:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4Cn5Bd+L14KVOkBy3I0zvESfB5G1klOhcdE8jhSzxAk=;
 b=EW3UkVH+aOFZvxP70vr2gDPdGKGSras4CZDYfaKMphRGIjKGcR8fPpTr4aB6FerWP1
 v3S5Zsk3OlVTHI1u7jxykSyrsjqfmOhOWqfn5Kj55aE//BuOxx07K9oiE9mRs3/KQno6
 7UomSqV+QsojRu68DrBGdd17W7lbcfR+bjYMFlCHLHgcjRR5PGyn1sWPdOLV9EfGVomQ
 /q4hjpUZvOSBph38dA/rOf0puXw8XuPFnBHzBBib65KyqZ0KzqwRO+at9usI4YD+fSta
 rx/CK0vjJFE2DuJJP1mqu+/De8OnJL/CniKbmjGKG4l+mpOTQiK4l/A0FAnG9KZUHu06
 8keQ==
X-Gm-Message-State: AOAM5304rvthPwVG2Mt1p1vcQT3KZ+VTIkeFp+YyIAPxakeRhiOJN6ZQ
 SbWxDPsPg1wkAWFtevt6jvQB8UXNuov0n103yi6M7AmuuHxpqedgqrrl6n7UouVm8GiJ/dTiveX
 WUV/VayOqbdJeIv4Lugup7bXplBE3g9+eIFgSY5EqHA==
X-Received: by 2002:adf:dfc9:: with SMTP id q9mr4019267wrn.400.1600939859786; 
 Thu, 24 Sep 2020 02:30:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzNr9iTqIQuESzVSCPAV8Mwoq5mFq1pIRj7KbtcjUI1Z0WuhkhVRABCz6hVxbGoGui7GYmBg==
X-Received: by 2002:adf:dfc9:: with SMTP id q9mr4019248wrn.400.1600939859611; 
 Thu, 24 Sep 2020 02:30:59 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id p11sm2641023wma.11.2020.09.24.02.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 02:30:58 -0700 (PDT)
Date: Thu, 24 Sep 2020 05:30:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v3 -next] vdpa: mlx5: change Kconfig depends to fix build
 errors
Message-ID: <20200924052932-mutt-send-email-mst@kernel.org>
References: <73f7e48b-8d16-6b20-07d3-41dee0e3d3bd@infradead.org>
 <20200918082245.GP869610@unreal>
MIME-Version: 1.0
In-Reply-To: <20200918082245.GP869610@unreal>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Eli Cohen <elic@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>
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

On Fri, Sep 18, 2020 at 11:22:45AM +0300, Leon Romanovsky wrote:
> On Thu, Sep 17, 2020 at 07:35:03PM -0700, Randy Dunlap wrote:
> > From: Randy Dunlap <rdunlap@infradead.org>
> >
> > drivers/vdpa/mlx5/ uses vhost_iotlb*() interfaces, so add a dependency
> > on VHOST to eliminate build errors.
> >
> > ld: drivers/vdpa/mlx5/core/mr.o: in function `add_direct_chain':
> > mr.c:(.text+0x106): undefined reference to `vhost_iotlb_itree_first'
> > ld: mr.c:(.text+0x1cf): undefined reference to `vhost_iotlb_itree_next'
> > ld: mr.c:(.text+0x30d): undefined reference to `vhost_iotlb_itree_first'
> > ld: mr.c:(.text+0x3e8): undefined reference to `vhost_iotlb_itree_next'
> > ld: drivers/vdpa/mlx5/core/mr.o: in function `_mlx5_vdpa_create_mr':
> > mr.c:(.text+0x908): undefined reference to `vhost_iotlb_itree_first'
> > ld: mr.c:(.text+0x9e6): undefined reference to `vhost_iotlb_itree_next'
> > ld: drivers/vdpa/mlx5/core/mr.o: in function `mlx5_vdpa_handle_set_map':
> > mr.c:(.text+0xf1d): undefined reference to `vhost_iotlb_itree_first'
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: virtualization@lists.linux-foundation.org
> > Cc: Saeed Mahameed <saeedm@nvidia.com>
> > Cc: Leon Romanovsky <leonro@nvidia.com>
> > Cc: netdev@vger.kernel.org
> > ---
> > v2: change from select to depends on VHOST (Saeed)
> > v3: change to depends on VHOST_IOTLB (Jason)
> >
> >  drivers/vdpa/Kconfig |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > --- linux-next-20200917.orig/drivers/vdpa/Kconfig
> > +++ linux-next-20200917/drivers/vdpa/Kconfig
> > @@ -31,7 +31,7 @@ config IFCVF
> >
> >  config MLX5_VDPA
> >  	bool "MLX5 VDPA support library for ConnectX devices"
> > -	depends on MLX5_CORE
> > +	depends on VHOST_IOTLB && MLX5_CORE
> >  	default n
> 
> While we are here, can anyone who apply this patch delete the "default n" line?
> It is by default "n".
> 
> Thanks

Hmm other drivers select VHOST_IOTLB, why not do the same?


> >  	help
> >  	  Support library for Mellanox VDPA drivers. Provides code that is
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
