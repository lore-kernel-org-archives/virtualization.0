Return-Path: <SRS0=sVkE=DB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC8DC2D0E2
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 16:02:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 453C4235FD
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 16:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtUGW9q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453C4235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9F8B82E112;
	Thu, 24 Sep 2020 16:02:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QfYCT2QoJRu5; Thu, 24 Sep 2020 16:02:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C1E462E0B5;
	Thu, 24 Sep 2020 16:02:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACE9AC0890;
	Thu, 24 Sep 2020 16:02:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39B5BC0859
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 16:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2B9652E112
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 16:02:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SRpYzPlsGZmX
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 16:02:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 2CDCD2E0B5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 16:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600963372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HjfyIqm+fMI2qwxuazO2r9o7hq0du7rjNYxWCh/yhH8=;
 b=GtUGW9q+zB9MgQZmrhRyJFX/kb1pme9TVP835tiFSQbMCzaXvpNOibvVaqP7HHoYYXNElU
 4FXwX77eBkJi6k6F6hU57R2nT32lsQw6YdtYRwIoA57ibkifHPZ2zaeRJdgJufgdMFPXwf
 hs77CLxAFkSaR7H95YPO8qWOhfANpAw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-ncVqmIioPdiC7ZrLGwx19A-1; Thu, 24 Sep 2020 12:02:50 -0400
X-MC-Unique: ncVqmIioPdiC7ZrLGwx19A-1
Received: by mail-wr1-f71.google.com with SMTP id a10so1389211wrw.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HjfyIqm+fMI2qwxuazO2r9o7hq0du7rjNYxWCh/yhH8=;
 b=jMtVTrvQ4wXNL+N9xSioa8hTqwkJ+g68ZB/hGHzEia1j9vp/uloUyX8gVFfxkFTfiS
 TgumU0RwJ2B1pDyu2gN9s3oIXLkYKjRpDpoABas96XdQJyWYI7inJLy0C4T+RI+H5Pzc
 eGBlpWfgxlvYDvWzE8ECJt2BKAiQs0Oe5Fv920KXCICrl88HCo5zD/4EZuYAcPF5uDMr
 sb8uAx+4aiGeR1Fl++4MQ2RtRr6Iy1sipADlbrSxnT7h3FbTRwSpr2ceeztKQlCd+fjw
 XijIALVJPswF3zn5Lz8r7C/Q4cdD6R46lhZxXXM/vOL32QOiH5L64PJoBQ4d7ffvcZsC
 up+Q==
X-Gm-Message-State: AOAM5328Gv8C/HDuhVL9srCvWv/QXeJkzAv8SzHtb9YJh7KgBX42ViWq
 z9lDm+xkBVzeX/6aLr1nUaI7c6vw7RKNIs771sQZ1rU1IpGiVKnyikmGSvARV7WG0bUFMo7DF8P
 OJDZpr/ucR+L/QjRe1DUYKKhFOb7ZxDn5PhG8RohRdg==
X-Received: by 2002:a1c:3985:: with SMTP id g127mr42199wma.32.1600963368765;
 Thu, 24 Sep 2020 09:02:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCPrKe4Frc7EN7ceX89EofTC20FnVIrKVkqVACJHY7m+Y40fca3g0NY1X+dwbg7ouM3QMnaA==
X-Received: by 2002:a1c:3985:: with SMTP id g127mr42161wma.32.1600963368443;
 Thu, 24 Sep 2020 09:02:48 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id t6sm4065953wre.30.2020.09.24.09.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 09:02:47 -0700 (PDT)
Date: Thu, 24 Sep 2020 12:02:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 -next] vdpa: mlx5: change Kconfig depends to fix build
 errors
Message-ID: <20200924120217-mutt-send-email-mst@kernel.org>
References: <73f7e48b-8d16-6b20-07d3-41dee0e3d3bd@infradead.org>
 <20200918082245.GP869610@unreal>
 <20200924052932-mutt-send-email-mst@kernel.org>
 <20200924102413.GD170403@mtl-vdi-166.wap.labs.mlnx>
 <079c831e-214d-22c1-028e-05d84e3b7f04@infradead.org>
MIME-Version: 1.0
In-Reply-To: <079c831e-214d-22c1-028e-05d84e3b7f04@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org,
 Eli Cohen <elic@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
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

On Thu, Sep 24, 2020 at 08:47:05AM -0700, Randy Dunlap wrote:
> On 9/24/20 3:24 AM, Eli Cohen wrote:
> > On Thu, Sep 24, 2020 at 05:30:55AM -0400, Michael S. Tsirkin wrote:
> >>>> --- linux-next-20200917.orig/drivers/vdpa/Kconfig
> >>>> +++ linux-next-20200917/drivers/vdpa/Kconfig
> >>>> @@ -31,7 +31,7 @@ config IFCVF
> >>>>
> >>>>  config MLX5_VDPA
> >>>>  	bool "MLX5 VDPA support library for ConnectX devices"
> >>>> -	depends on MLX5_CORE
> >>>> +	depends on VHOST_IOTLB && MLX5_CORE
> >>>>  	default n
> >>>
> >>> While we are here, can anyone who apply this patch delete the "default n" line?
> >>> It is by default "n".
> > 
> > I can do that
> > 
> >>>
> >>> Thanks
> >>
> >> Hmm other drivers select VHOST_IOTLB, why not do the same?
> 
> v1 used select, but Saeed requested use of depends instead because
> select can cause problems.
> 
> > I can't see another driver doing that. Perhaps I can set dependency on
> > VHOST which by itself depends on VHOST_IOTLB?
> >>
> >>
> >>>>  	help
> >>>>  	  Support library for Mellanox VDPA drivers. Provides code that is
> >>>>
> >>
> 

Saeed what kind of problems? It's used with select in other places,
isn't it?

> -- 
> ~Randy

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
