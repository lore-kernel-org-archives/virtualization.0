Return-Path: <SRS0=mw42=CF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D952C433E1
	for <virtualization@archiver.kernel.org>; Thu, 27 Aug 2020 08:01:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD29422BF3
	for <virtualization@archiver.kernel.org>; Thu, 27 Aug 2020 08:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lksoy1ND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD29422BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A76BA87E91;
	Thu, 27 Aug 2020 08:01:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NDja1Bczua+6; Thu, 27 Aug 2020 08:01:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E1C3487DB7;
	Thu, 27 Aug 2020 08:01:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCAA3C016F;
	Thu, 27 Aug 2020 08:01:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96EA0C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 08:01:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 84B418820F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 08:01:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rEyrpApmGgPa
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 08:01:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 27B9787AC9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 08:01:45 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id d11so6352479ejt.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 01:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KLXKGCMrEd+HEPdG/6Veb0H0KiwUV4QwzjuW5uI1H7Y=;
 b=lksoy1NDScckuAYD4sTllL1Iurtev0e+pvnwfQDJMxCxa7JLt2eW5ZALN6jCFFbZwt
 rnEIqFZ/Kn7iFNQBzR0yn6m4899J5aaMisCuWUNBKBwGamGybczhroFIaIi7M4S6KV5c
 S+kw8klrcatEGIZexnu+yfdz1Z8LWp5yN2mGP2UZC2fgzT1VNci0x8Xk2e6UkXtkY3Xz
 tckKKot1hODrYWrRvUV2p46fu3xJLkQSm2MOsm3V+N4oOz00v50T77zCoYVtf5I2MypU
 G0P7T05k6eFA6lGOrHA5r0uEGiMiQ7ECn6imLPHHN+m6uzMSJMTGSN11V00WRZOer7LJ
 SfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KLXKGCMrEd+HEPdG/6Veb0H0KiwUV4QwzjuW5uI1H7Y=;
 b=GznI3m9Rd4MJvqZKdf+Bidck0p13WpV11ZAeStGVAu2YQIGdU2wGClEhIKFjnjjV+T
 y5FlKGxcjnU9TUUFmuA0zQt8UqAoWpK+0fpgU/3x8Pf68Eode89uXEKY/V2J5xeKs9DM
 033ocxvbMoOkPKrmA+O5shQeADtxPzIsahENbNTeDvo31+Czuz1ZwBUXc2V3KjBQipEs
 OMD/cIpprjPXQMGFtdI4ybXJ9avlpqc/jT1tnSI8dvPDwxNoJ6+8YzFiDZNJj2Scgh09
 FVJHVGpEJdtJq6Sn8mJ/CYf8BuabtkjqJmBmCQVNs8b4K4RHqzed8hy+va0m0WQf/G/4
 i4ow==
X-Gm-Message-State: AOAM53135kt4CceRgcAUtlZ775HQe8pYzmZPHT54EUcv8Gl0m0+YuOA4
 T6IhTvxXUpOG/ummDaWIh4Z29A==
X-Google-Smtp-Source: ABdhPJy3u3bRyTUX8lEQynqXU4hAdCiT/PYeb2x0IdTm6vsd6r4sfZTB0YNbGlWTbOWqcKJT0ea+2Q==
X-Received: by 2002:a17:906:fa15:: with SMTP id
 lo21mr20503865ejb.42.1598515303348; 
 Thu, 27 Aug 2020 01:01:43 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id i25sm954760edt.1.2020.08.27.01.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 01:01:42 -0700 (PDT)
Date: Thu, 27 Aug 2020 10:01:25 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200827080125.GC3399702@myrica>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200826092542-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200826092542-mutt-send-email-mst@kernel.org>
Cc: virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, bhelgaas@google.com
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

On Wed, Aug 26, 2020 at 09:26:02AM -0400, Michael S. Tsirkin wrote:
> On Fri, Aug 21, 2020 at 03:15:34PM +0200, Jean-Philippe Brucker wrote:
> > Add a topology description to the virtio-iommu driver and enable x86
> > platforms.
> > 
> > Since [v2] we have made some progress on adding ACPI support for
> > virtio-iommu, which is the preferred boot method on x86. It will be a
> > new vendor-agnostic table describing para-virtual topologies in a
> > minimal format. However some platforms don't use either ACPI or DT for
> > booting (for example microvm), and will need the alternative topology
> > description method proposed here. In addition, since the process to get
> > a new ACPI table will take a long time, this provides a boot method even
> > to ACPI-based platforms, if only temporarily for testing and
> > development.
> 
> OK should I park this in next now? Seems appropriate ...

Yes that sounds like a good idea. It could uncover new bugs since there is
more automated testing happening for x86.

Thanks,
Jean
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
