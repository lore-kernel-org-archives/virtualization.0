Return-Path: <SRS0=hez8=DG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B48BC4346E
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 07:48:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE8452075E
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 07:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wk2EeMrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8452075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6EE0085DD1;
	Tue, 29 Sep 2020 07:48:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tS_Tg2Sjs8WT; Tue, 29 Sep 2020 07:48:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 58E6E85D52;
	Tue, 29 Sep 2020 07:48:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CD0AC0890;
	Tue, 29 Sep 2020 07:48:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C8FDC0895
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:48:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 64DD620555
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:48:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sAZgI6Z4vPuP
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:48:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id BEF26203A3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:48:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601365686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8xO7rZy5t133U8JIyK4JzoQDnu4pz1aGJERQ/woAzd8=;
 b=Wk2EeMrFjSuzNCsB1QhjRVI4H/X4sLt0kQ181LeDpIU1TD1BJwW5LJ/HeZ8Jr4b7Sj60sB
 52dlehXltzBHtGWfyc2xMuXpiGHHMlJeK+krhHRGv5NGPSIkG1g7auu70KBT9kA0BaLIlP
 7Jycih53fMJOCDWYisKM5FKwgLtvacw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-y44v3kvLMK2c3kOI62uMNg-1; Tue, 29 Sep 2020 03:48:03 -0400
X-MC-Unique: y44v3kvLMK2c3kOI62uMNg-1
Received: by mail-wr1-f71.google.com with SMTP id v5so1411674wrr.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 00:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8xO7rZy5t133U8JIyK4JzoQDnu4pz1aGJERQ/woAzd8=;
 b=VZYPR/m/FkO4nFdRdO0RZroOiu8dakjZtmjTu3CZWGNks20pmzWseo9xMK6ZIgkM16
 TVszgxxfIFzUdF8juVXLRj0aoMFnihkgs683qHi90d7bDjsIfrT/oMR9XGwqj4mCJr4H
 z5K0uqadQZIM/RYL07WG0/nD+495NW21paU+yw6fRa3rSTj7s3xzi2ETYbG565gfxjxH
 +bULbHJh1jn+1FLYdvxNo0pqxjP+gAue+z+VpZWfV91ZcRO5MabQpMGb1nv1ctt812lz
 vP5/iZlZEQvf4UQWlVGy330yQo9ECErKc8e8QdaLBdMLyIZR1gpadqI8twZ+ymnlU/nK
 gtAQ==
X-Gm-Message-State: AOAM533GcZszFyU5krk8R7Ik1iaT3p/XlsapdW+eIH2a3nmxYgGraITc
 sRNeKGf2riTlLJSXQ1U5nJedRv4DvJLQLRAeIvKQ6KtJd+dznYxDX23sFza783JTLTf5f0946iw
 TkzZgyM8DLIh3hYgIf5r/XfOQFqVbkWh76pSE7aLNAw==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr2845854wmc.143.1601365682664; 
 Tue, 29 Sep 2020 00:48:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzy9cvP6BH1Mw0CQeNnVZeFoeM27Cd6X6OrMih1YP8wEj9eAKG/lzVukmjjG2bhZg1Xt9CE+Q==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr2845808wmc.143.1601365681993; 
 Tue, 29 Sep 2020 00:48:01 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id 70sm4346876wme.15.2020.09.29.00.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:48:01 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:47:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 -next] vdpa: mlx5: change Kconfig depends to fix build
 errors
Message-ID: <20200929034636-mutt-send-email-mst@kernel.org>
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

OK I went over the history. v1 selected VHOST, that as the issue I think.
A later version switched to VHOST_IOTLB, that is ok to select.

> > I can't see another driver doing that. Perhaps I can set dependency on
> > VHOST which by itself depends on VHOST_IOTLB?
> >>
> >>
> >>>>  	help
> >>>>  	  Support library for Mellanox VDPA drivers. Provides code that is
> >>>>
> >>
> 
> 
> -- 
> ~Randy

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
