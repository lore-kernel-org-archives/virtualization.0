Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E09C433F5
	for <virtualization@archiver.kernel.org>; Wed, 22 Dec 2021 17:18:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B214240273;
	Wed, 22 Dec 2021 17:18:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id neJtsbHTe1tN; Wed, 22 Dec 2021 17:18:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0FED44098A;
	Wed, 22 Dec 2021 17:18:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFC8FC001E;
	Wed, 22 Dec 2021 17:18:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F315C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 17:18:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 47ACA60FCE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 17:18:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qYanLYvOfXfL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 17:18:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 575E660E61
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 17:18:54 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id i187so842536qkf.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 09:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/L5NSqmnmp0JrNCe4jEZo1LjnyYAG3Zj1ZGvlLyNRww=;
 b=LXqfRFsU799kS6etQx2wny/MKAWaffuWQk76RfpfJW+3X5OCImXg1Dp90Y0mRBI1EG
 WNjZzNDzZKIcmS8X1m46mdALXkuotSNdEczKGUd/PBewYiLrbLh2zbN/CaonWPBMBbDx
 LHnygp0gSkx2zU/yGMCtl+rcj3S3J3Cw2iqmWXTzbF9xYnXxu99hrM6LBcYVQrggMDeJ
 2E+MC79QzCOqtuTTypNlhmVcPYm8OP5ZRavMcgb9yx/5gpRRO0HB1BziVlKih5ozJC/8
 M0ic/La1wfEsbcI58LTI+gJPcyj/M/6EKryf3RVyZBHv/tF5fEsE7drF8k3qsF+r9v3q
 +Ryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/L5NSqmnmp0JrNCe4jEZo1LjnyYAG3Zj1ZGvlLyNRww=;
 b=L69d2kanc73y1Ix49CpDleasdPMg6SDx4uoRG+/tjoGjKvEIMattKSR7YuPEA1TDPD
 9DvbZcOvEIukw/I8idR1az44STEAucB4IXf2k9Rp0fudMbLtcj8udLO4u/x+ez4QbzDf
 N8cry+Bium5kPaQE/9ZY3PX0PKvlAhyHfeWu2fHLn08WTpxGzluaPZobm/3usMZrSdNR
 qDbZyRioF+ggSMH9oOizH1X72lmU5l8ORkQnN9cBsT4WgAMPdBNNOJ+CDEbVRgAqByO8
 4VTP3B3eL1RxT2terWNfpsEy+lHVGibxd+sZd3T+5o56mZE2Qx3A3P81BcxOkD3EQzZf
 WVXA==
X-Gm-Message-State: AOAM5326k/lrRvNoYceXwjubhTbzS2rt23Xrs02/MhlRmYudsiYQdCaO
 LUpg2L6bCuVQFBdiWmCoW1pQ/Q==
X-Google-Smtp-Source: ABdhPJwP5NJyymLKCRDlLyH4OX0k1lbimBfGNffLbMt6CEmyfRjzYEMg0Rxlwp8mOtStmN8qCKq7rQ==
X-Received: by 2002:ae9:df87:: with SMTP id t129mr2774584qkf.67.1640193533176; 
 Wed, 22 Dec 2021 09:18:53 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id de33sm2244073qkb.5.2021.12.22.09.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Dec 2021 09:18:52 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1n05GN-007SI7-Km; Wed, 22 Dec 2021 13:18:51 -0400
Date: Wed, 22 Dec 2021 13:18:51 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "David E. Box" <david.e.box@linux.intel.com>
Subject: Re: [PATCH 0/4] driver_core: Auxiliary drvdata helper cleanup
Message-ID: <20211222171851.GO6467@ziepe.ca>
References: <20211221235852.323752-1-david.e.box@linux.intel.com>
 <20211222000905.GN6467@ziepe.ca>
 <35bca887e697597f7b3e1944b3dd7347c6defca1.camel@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <35bca887e697597f7b3e1944b3dd7347c6defca1.camel@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 mustafa.ismail@intel.com, leon@kernel.org, mst@redhat.com,
 linux-rdma@vger.kernel.org, gregkh@linuxfoundation.org,
 virtualization@lists.linux-foundation.org, vkoul@kernel.org,
 davem@davemloft.net, hdegoede@redhat.com, dledford@redhat.com,
 yung-chuan.liao@linux.intel.com, netdev@vger.kernel.org, kuba@kernel.org,
 andriy.shevchenko@linux.intel.com, shiraz.saleem@intel.com, saeedm@nvidia.com,
 linux-kernel@vger.kernel.org
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

On Tue, Dec 21, 2021 at 04:48:17PM -0800, David E. Box wrote:
> On Tue, 2021-12-21 at 20:09 -0400, Jason Gunthorpe wrote:
> > On Tue, Dec 21, 2021 at 03:58:48PM -0800, David E. Box wrote:
> > > Depends on "driver core: auxiliary bus: Add driver data helpers" patch [1].
> > > Applies the helpers to all auxiliary device drivers using
> > > dev_(get/set)_drvdata. Drivers were found using the following search:
> > > 
> > >     grep -lr "struct auxiliary_device" $(grep -lr "drvdata" .)
> > > 
> > > Changes were build tested using the following configs:
> > > 
> > >     vdpa/mlx5:       CONFIG_MLX5_VDPA_NET
> > >     net/mlx53:       CONFIG_MLX5_CORE_EN
> > >     soundwire/intel: CONFIG_SOUNDWIRE_INTEL
> > >     RDAM/irdma:      CONFIG_INFINIBAND_IRDMA
> > >                      CONFIG_MLX5_INFINIBAND
> > > 
> > > [1] https://www.spinics.net/lists/platform-driver-x86/msg29940.html 
> > 
> > I have to say I don't really find this to be a big readability
> > improvement.
> 
> I should have referenced the thread [1] discussing the benefit of this change
> since the question was asked and answered already. The idea is that drivers
> shouldn't have to touch the device API directly if they are already using a
> higher level core API (auxiliary bus) that can do that on its behalf.

Driver writers should rarely use the auxilary device type directly, the
should always immediately container_of it to their proper derived
type.

> > Also, what use is 'to_auxiliary_dev()' ? I didn't see any users added..
>
> This was not added by that patch.

It was added by the referenced patch, and seems totally pointless cut
and paste, again because nothing should be using the auxiliary_device
type for anything more than container_of'ing to their own type.

We've been ripping out bus specific APIs in favour of generic ones
(see the work on the DMA API for instance) so this whole concept seems
regressive, particularly when applied to auxiliary bus which does not
have an API of its own.

Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
