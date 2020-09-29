Return-Path: <SRS0=hez8=DG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325E7C4346E
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 06:11:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53C420BED
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 06:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjW0eRA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53C420BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0245F20510;
	Tue, 29 Sep 2020 06:11:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y4m8M8e8Zr6X; Tue, 29 Sep 2020 06:11:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8AEB3204B4;
	Tue, 29 Sep 2020 06:11:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57BD7C0889;
	Tue, 29 Sep 2020 06:11:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46255C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 06:11:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 06653204B4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 06:11:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eaBGrdt45YfX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 06:11:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id F21F71FEAB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 06:11:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601359860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JAxYHRdsbLtzM2kIQHgB0ZgL2sD23xll0p+Cp1/eLJU=;
 b=PjW0eRA4pM5C9/JqUelAkuIIyjdEvfLyNL3rmlLqjhHIsxhYYsSI032U1CQMU4Jlw2bTbh
 W7HaqygNCViATSnN4x6zY/AGZlsS/WGfmuvZdyqOGbSzNVIe8ETqobZhLhC0SYOyLUw4pu
 EpQ96AhWjIiYIVRnXtZe6Y4E7wnJdOU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-BKMyvpcsOECJ003iomQJnQ-1; Tue, 29 Sep 2020 02:10:58 -0400
X-MC-Unique: BKMyvpcsOECJ003iomQJnQ-1
Received: by mail-wr1-f69.google.com with SMTP id y3so1279207wrl.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 23:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JAxYHRdsbLtzM2kIQHgB0ZgL2sD23xll0p+Cp1/eLJU=;
 b=HExybBrGd2zj2DbPHtzUpQiaC9A4OQhy/x8FYl2me8YFbfJtbZoHIacU1nnrPF1MdV
 sN8Dw9ufEJKAxbplCMWZ6Ec3gUVEFGJBekW24spVvmPbH4K3bwAvRtAsl+7mm4QLWFDx
 ngEza8VXPfGkiuYR3q/qm9h7gMzGtoceXvUt3d5wZxEQzq2OjMETi7Yr8fwfxt2swg9m
 QDGpw0VxC05S2x9pX4ETZE+nuVIMdMKzl6b1tBGxbEcFUPYS4N91G8/0L0wdOcHpuzhR
 jGoJnqMaSTGrhmRwwN0xL24aJOjiWpN1Is5xNRU3BwYSGFvbE2Mkq4NJU6j5xmkz5Zgp
 q8qQ==
X-Gm-Message-State: AOAM533kvyBv45IrCS64tEqPmxeZ58K/PPc2TwMq/IKc6RKZ6qrs0cvM
 c7zOz2S0bzQKzRfxg8kCWBRayk12GY7KJkZCSQiSEidhMoxFoRjvDznc17X4fFDZQQGq7/bOma/
 Izgz+PoYSOkwUiXjWrh4zU227TV+wQcbCvRAauEYEeA==
X-Received: by 2002:adf:eb04:: with SMTP id s4mr2366073wrn.81.1601359857388;
 Mon, 28 Sep 2020 23:10:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbRp2Llm5I3cTgA/LEzQYm1zgKOCI/i4yvi7klM6uNyHOo4UgNBNnqGUpXczfJ7duXJzSDAA==
X-Received: by 2002:adf:eb04:: with SMTP id s4mr2366044wrn.81.1601359857144;
 Mon, 28 Sep 2020 23:10:57 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id e13sm4772905wre.60.2020.09.28.23.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 23:10:56 -0700 (PDT)
Date: Tue, 29 Sep 2020 02:10:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v3 -next] vdpa: mlx5: change Kconfig depends to fix build
 errors
Message-ID: <20200929021030-mutt-send-email-mst@kernel.org>
References: <73f7e48b-8d16-6b20-07d3-41dee0e3d3bd@infradead.org>
 <20200918082245.GP869610@unreal>
 <20200924052932-mutt-send-email-mst@kernel.org>
 <20200924102413.GD170403@mtl-vdi-166.wap.labs.mlnx>
 <20200925061959-mutt-send-email-mst@kernel.org>
 <20200929060142.GA120395@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20200929060142.GA120395@mtl-vdi-166.wap.labs.mlnx>
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

On Tue, Sep 29, 2020 at 09:01:42AM +0300, Eli Cohen wrote:
> On Fri, Sep 25, 2020 at 06:20:45AM -0400, Michael S. Tsirkin wrote:
> > > > 
> > > > Hmm other drivers select VHOST_IOTLB, why not do the same?
> > > 
> > > I can't see another driver doing that.
> > 
> > Well grep VHOST_IOTLB and you will see some examples.
> 
> $ git grep -wn VHOST_IOTLB
> drivers/vhost/Kconfig:2:config VHOST_IOTLB
> drivers/vhost/Kconfig:11:       select VHOST_IOTLB
> drivers/vhost/Kconfig:18:       select VHOST_IOTLB
> 
> What am I missing here?

Nothing, there's a select here as expected.

> > > Perhaps I can set dependency on
> > > VHOST which by itself depends on VHOST_IOTLB?
> > 
> > VHOST is processing virtio in the kernel. You don't really need that
> > for mlx, do you?
> > 
> > > > 
> > > > 
> > > > > >  	help
> > > > > >  	  Support library for Mellanox VDPA drivers. Provides code that is
> > > > > >
> > > > 
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
