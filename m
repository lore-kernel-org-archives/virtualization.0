Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB16FC38145
	for <virtualization@archiver.kernel.org>; Thu,  8 Sep 2022 13:28:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D0B483372;
	Thu,  8 Sep 2022 13:28:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D0B483372
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.a=rsa-sha256 header.s=default header.b=Nbzo8AaK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gT6Ugj3YMNjQ; Thu,  8 Sep 2022 13:28:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BB110832B0;
	Thu,  8 Sep 2022 13:28:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB110832B0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D90FC0033;
	Thu,  8 Sep 2022 13:28:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 826E1C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 13:28:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 649E4415EF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 13:28:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 649E4415EF
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org
 header.a=rsa-sha256 header.s=default header.b=Nbzo8AaK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4kSLm0NSfcdo
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 13:28:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 15B2B415EE
Received: from mail.8bytes.org (mail.8bytes.org
 [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
 by smtp2.osuosl.org (Postfix) with ESMTP id 15B2B415EE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 13:28:27 +0000 (UTC)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 6ACB624069C;
 Thu,  8 Sep 2022 15:28:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1662643704;
 bh=tDuhKm9wQfdx7sUd4hZrnBHJRGruWciJVuKdXgXOhg8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Nbzo8AaKCmLcJF6ywBTO/rjFGCww8jqPWoQ6WcBpBVILlVrrzm/ywTVSN6gtAJpvI
 A4WA5AxpHDg5Sd62NU3n5V/Vi1+huBSshzEAQAZS7xn++DhH0oznzPGAGwNcfBbTfq
 Twt1k1zJR6eHTY8BdmbO1Ww2bxQuZSP3YVyPip5R53rnIHglAbsB0bCYX0JzWlq5Om
 M3nAYqpIKCggsduzZcJAnKN/jYWRx4aw2vg7FWSxO/QqqKt7N7pAfFXxtOG8goJGLV
 xuiUyCTz0ghn5xX8vuVnC49wxhLLFEBrREVNPwdgKbdzr/ZwBoayTRYmgPniXvM4Pl
 wZdcX65MXNFqw==
Date: Thu, 8 Sep 2022 15:28:22 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v6 1/5] iommu: Return -EMEDIUMTYPE for incompatible
 domain and device/group
Message-ID: <Yxnt9uQTmbqul5lf@8bytes.org>
References: <20220815181437.28127-1-nicolinc@nvidia.com>
 <20220815181437.28127-2-nicolinc@nvidia.com>
 <YxiRkm7qgQ4k+PIG@8bytes.org> <Yxig+zfA2Pr4vk6K@nvidia.com>
 <YxilZbRL0WBR97oi@8bytes.org> <YxjQiVnpU0dr7SHC@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YxjQiVnpU0dr7SHC@nvidia.com>
Cc: linux-s390@vger.kernel.org, marcan@marcan.st, mjrosato@linux.ibm.com,
 linux-kernel@vger.kernel.org, thierry.reding@gmail.com, will@kernel.org,
 alyssa@rosenzweig.io, jean-philippe@linaro.org, kvm@vger.kernel.org,
 zhang.lyra@gmail.com, jon@solid-run.com, jonathanh@nvidia.com,
 iommu@lists.linux.dev, Nicolin Chen <nicolinc@nvidia.com>,
 yangyingliang@huawei.com, orsonzhai@gmail.com, gerald.schaefer@linux.ibm.com,
 sven@svenpeter.dev, linux-arm-msm@vger.kernel.org, vdumpa@nvidia.com,
 christophe.jaillet@wanadoo.fr, baolin.wang@linux.alibaba.com,
 thunder.leizhen@huawei.com, linux-tegra@vger.kernel.org, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, dwmw2@infradead.org, cohuck@redhat.com,
 shameerali.kolothum.thodi@huawei.com, robdclark@gmail.com,
 asahi@lists.linux.dev, suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
 baolu.lu@linux.intel.com
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

On Wed, Sep 07, 2022 at 02:10:33PM -0300, Jason Gunthorpe wrote:
> Sure, rust has all sorts of nice things. But the kernel doesn't follow
> rust idioms, and I don't think this is a great place to start
> experimenting with them.

It is actually a great place to start experimenting. The IOMMU
interfaces are rather domain specific and if we get something wrong the
damage is limited to a few callers. There are APIs much more exposed in
the kernel which would be worse for that.

But anyway, I am not insisting on it.

> It has been 3 months since EMEDIUMTYPE was first proposed and 6
> iterations of the series, don't you think it is a bit late in the game
> to try to experiment with rust error handling idioms?

If I am not mistaken, I am the person who gets blamed when crappy IOMMU
code is sent upstream. So it is also up to me to decide in which state
and how close to merging a given patch series is an whether it is
already 'late in the game'.

> So, again, would you be happy with a simple 
> 
>  #define IOMMU_EINCOMPATIBLE_DEVICE xx
> 
> to make it less "re-using random error codes"?

I am wondering if this can be solved by better defining what the return
codes mean and adjust the call-back functions to match the definition.
Something like:

	-ENODEV : Device not mapped my an IOMMU
	-EBUSY  : Device attached and domain can not be changed
	-EINVAL : Device and domain are incompatible
	...

That would be much more intuitive than using something obscure like
EMEDIUMTYPE.

Regards,

	Joerg
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
