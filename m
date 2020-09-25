Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06891C4363D
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 10:20:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670C121D91
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 10:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiYb2/p+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670C121D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 003CB86B8E;
	Fri, 25 Sep 2020 10:20:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vsBDJF8Ph7xr; Fri, 25 Sep 2020 10:20:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D86BE86BA6;
	Fri, 25 Sep 2020 10:20:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCA80C0889;
	Fri, 25 Sep 2020 10:20:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5733C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 10:20:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A1F2386D41
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 10:20:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id efcbXM29C71d
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 10:20:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E941C86D3F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 10:20:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601029251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=48xx0Uut3LVoJnoZFThGUUKIIpJdqctVHSD98zIttUE=;
 b=SiYb2/p+eIodt2YndD6MirOuwc+ZUyAn41x7Lly9RAJptyRjmiW3tg71ZxZMWKZH0BbhDv
 SH+5+EJTeyQzq+wzvZyFNO+HgR/GlaTM9LCwSrbKS5lqadneKljMn4TLTDaPVNaYVWTe4t
 He6lN+DxGXTPpD7xQxwjVKMTdoKv5G8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-qxzm2csWPG2cINoI2vKIcA-1; Fri, 25 Sep 2020 06:20:50 -0400
X-MC-Unique: qxzm2csWPG2cINoI2vKIcA-1
Received: by mail-wr1-f70.google.com with SMTP id o6so900504wrp.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 03:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=48xx0Uut3LVoJnoZFThGUUKIIpJdqctVHSD98zIttUE=;
 b=IAfGuGWzhlKNZ7S+QX0nJWYoRnMtmC2OOln00uotR0QJwjpgYh57mhJXlN0cVzj6ds
 FdeLndWC2S0GDEfUl5BaototraKPI0urtcUaiTqg4jTTHkaewyXzhnv5ZNPZqrLCcuGO
 jAQHuK+0SP20NsSiL2MkDFPUiyhjQUANsF6nEHoC9dTzwekM+n/cnoAw3MTs7dpwwEU7
 55KRmrWOQc1XAOZGEIgq+BFrgqtdEYuQ6cO+LbPPMeoLwXqqIB5eJMEjvmhNP52mxOQe
 X+gNI/f+77OCXXc/WFlip8rmw6DdEhfd40KY1mPtzJgvPwBjZK3PaZ1LEwO8o8QF/hCA
 6xhA==
X-Gm-Message-State: AOAM532ujAhGGzHEla3DcxMTwqLmhzBY85uTrEWV0v2vi8raIh7fpFFC
 YWQIQ5gaHo7+19N5BIYwiwaD9JVT7XBP/+TbJekoKttDuuV0ny2nQZDZdPdpW/L1aV01gyjB+Xn
 WWOvjgdad+ZLNLrg+5q9VnVpotYXGNbPkUY1RTb2d+Q==
X-Received: by 2002:adf:f852:: with SMTP id d18mr3656009wrq.245.1601029249079; 
 Fri, 25 Sep 2020 03:20:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfMtavSYQxA31Pq1uMCBQpG6U2aRGi/O/F7xWqzFa0O7KFif6IR4vB7jEML7xD/6dY5K4Wow==
X-Received: by 2002:adf:f852:: with SMTP id d18mr3655999wrq.245.1601029248922; 
 Fri, 25 Sep 2020 03:20:48 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id v4sm2244377wml.46.2020.09.25.03.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 03:20:48 -0700 (PDT)
Date: Fri, 25 Sep 2020 06:20:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v3 -next] vdpa: mlx5: change Kconfig depends to fix build
 errors
Message-ID: <20200925061959-mutt-send-email-mst@kernel.org>
References: <73f7e48b-8d16-6b20-07d3-41dee0e3d3bd@infradead.org>
 <20200918082245.GP869610@unreal>
 <20200924052932-mutt-send-email-mst@kernel.org>
 <20200924102413.GD170403@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20200924102413.GD170403@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Leon Romanovsky <leonro@nvidia.com>,
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

On Thu, Sep 24, 2020 at 01:24:13PM +0300, Eli Cohen wrote:
> On Thu, Sep 24, 2020 at 05:30:55AM -0400, Michael S. Tsirkin wrote:
> > > > --- linux-next-20200917.orig/drivers/vdpa/Kconfig
> > > > +++ linux-next-20200917/drivers/vdpa/Kconfig
> > > > @@ -31,7 +31,7 @@ config IFCVF
> > > >
> > > >  config MLX5_VDPA
> > > >  	bool "MLX5 VDPA support library for ConnectX devices"
> > > > -	depends on MLX5_CORE
> > > > +	depends on VHOST_IOTLB && MLX5_CORE
> > > >  	default n
> > > 
> > > While we are here, can anyone who apply this patch delete the "default n" line?
> > > It is by default "n".
> 
> I can do that
> 
> > > 
> > > Thanks
> > 
> > Hmm other drivers select VHOST_IOTLB, why not do the same?
> 
> I can't see another driver doing that.

Well grep VHOST_IOTLB and you will see some examples.

> Perhaps I can set dependency on
> VHOST which by itself depends on VHOST_IOTLB?

VHOST is processing virtio in the kernel. You don't really need that
for mlx, do you?

> > 
> > 
> > > >  	help
> > > >  	  Support library for Mellanox VDPA drivers. Provides code that is
> > > >
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
