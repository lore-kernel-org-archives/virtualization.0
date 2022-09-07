Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0013C38145
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 12:42:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C5DF60AF0;
	Wed,  7 Sep 2022 12:42:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C5DF60AF0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.a=rsa-sha256 header.s=default header.b=60gm7iJb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k7SwOjrNx08O; Wed,  7 Sep 2022 12:42:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C935860AEE;
	Wed,  7 Sep 2022 12:42:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C935860AEE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3852C0033;
	Wed,  7 Sep 2022 12:42:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1AFDC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:42:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9AFDE408B4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:42:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9AFDE408B4
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org
 header.a=rsa-sha256 header.s=default header.b=60gm7iJb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RP7X31DsICEB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:41:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD08540887
Received: from mail.8bytes.org (mail.8bytes.org
 [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD08540887
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:41:58 +0000 (UTC)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 6FAA4240857;
 Wed,  7 Sep 2022 14:41:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1662554516;
 bh=JzhvE6AKnt05k9hUcUfcBmLyd7x5XDIZ52BK23fxpSg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=60gm7iJb3a9EHDRBPPmkRhjnPxPdo8Gl8tCIOOIov74tc9nJYqxwRN3f9BaD/uBTh
 ZoV5WBylA/H+HpQRYy6dC/0WalBc7Xg2gQ/EGr7HOKkp3DB6I7K2VtL5rWe+yHaFHo
 3GC6YDahBrvwp1lTMhPP0vwiUslxcaImFmKevknjuQ++PrHb+32Kb+SwW1OGoiSniC
 j5WIwf2zsHXP7Dwv+Ps3tJybqv0ASdmzh/SRgK2OM7/c76yEAtXi01DBWO3CrfKkfR
 V7IV9Z/HY1tQSVYITH64oKsBfN+UYoyf/xQA2uGwpPthodTETsq7ja03Rs0zm47WBI
 eNx1oHFYz53Og==
Date: Wed, 7 Sep 2022 14:41:54 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v6 1/5] iommu: Return -EMEDIUMTYPE for incompatible
 domain and device/group
Message-ID: <YxiRkm7qgQ4k+PIG@8bytes.org>
References: <20220815181437.28127-1-nicolinc@nvidia.com>
 <20220815181437.28127-2-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220815181437.28127-2-nicolinc@nvidia.com>
Cc: linux-s390@vger.kernel.org, marcan@marcan.st, mjrosato@linux.ibm.com,
 linux-kernel@vger.kernel.org, thierry.reding@gmail.com, will@kernel.org,
 alyssa@rosenzweig.io, jean-philippe@linaro.org, kvm@vger.kernel.org,
 zhang.lyra@gmail.com, jon@solid-run.com, jonathanh@nvidia.com,
 iommu@lists.linux.dev, jgg@nvidia.com, yangyingliang@huawei.com,
 orsonzhai@gmail.com, gerald.schaefer@linux.ibm.com, sven@svenpeter.dev,
 linux-arm-msm@vger.kernel.org, christophe.jaillet@wanadoo.fr,
 baolin.wang@linux.alibaba.com, thunder.leizhen@huawei.com,
 linux-tegra@vger.kernel.org, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, dwmw2@infradead.org, cohuck@redhat.com,
 vdumpa@nvidia.com, shameerali.kolothum.thodi@huawei.com, robdclark@gmail.com,
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

On Mon, Aug 15, 2022 at 11:14:33AM -0700, Nicolin Chen wrote:
> Provide a dedicated errno from the IOMMU driver during attach that the
> reason attached failed is because of domain incompatability. EMEDIUMTYPE
> is chosen because it is never used within the iommu subsystem today and
> evokes a sense that the 'medium' aka the domain is incompatible.

I am not a fan of re-using EMEDIUMTYPE or any other special value. What
is needed here in EINVAL, but with a way to tell the caller which of the
function parameters is actually invalid.

For that I prefer adding an additional pointer parameter to the attach
functions in which the reason for the failure can be communicated up the
chain.

For the top-level iommu_attach_device() function I am okay with having a
special version which has this additional paremter.

Regards,

	Joerg
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
