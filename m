Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D300C54EE9
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 14:06:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C35318278F;
	Wed,  7 Sep 2022 14:06:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C35318278F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.a=rsa-sha256 header.s=default header.b=rnWXPfkR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WTWybAe1eXug; Wed,  7 Sep 2022 14:06:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3E5EB82784;
	Wed,  7 Sep 2022 14:06:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E5EB82784
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 157ABC0033;
	Wed,  7 Sep 2022 14:06:45 +0000 (UTC)
Received: from smtp3.osuosl.org (unknown
 [IPv6:2605:bc80:3010:0:a800:ff:fe58:3b77])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA995C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:06:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7EA9A60BDC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:06:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7EA9A60BDC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org
 header.a=rsa-sha256 header.s=default header.b=rnWXPfkR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vg2MW4q51NlZ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:06:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ABF8660AEE
Received: from mail.8bytes.org (mail.8bytes.org
 [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABF8660AEE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 14:06:39 +0000 (UTC)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 6118D2409A7;
 Wed,  7 Sep 2022 16:06:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1662559591;
 bh=sD6ntPJavoL+O3jZjBfdlyQKhK42Ee+ATtCC5qSKLek=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rnWXPfkRqiJXCBikZk6JRGP2BockRbTgJPogFW6R24YrO/UYOBdbDIQPctDN3LGpI
 79/xXHT61Edm0n+vSGPYdlczsRRfdkacO6KmQgX/Kv6hNnOMuGvxYRlTiNeRqAdoGh
 5eisSJGFeEPl9sdwLcPf/+l2Yyy8DviLlelMTM4i/bTvjcSo5ebNKYoIEDQy0YTBKO
 jt0uBK0fCmoSFWyU5uIRYNcijnnozfeA7oB/uWHePVQatjmPma4sWvhtPveFHkv/Zd
 5qGfNEp1V9BqTtR+QMkc0IJeFW1j8U5UpZXX6b1OmgcnRAA8Xu95xNZgC6+l1xfUpO
 7YogNayXEccUQ==
Date: Wed, 7 Sep 2022 16:06:29 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v6 1/5] iommu: Return -EMEDIUMTYPE for incompatible
 domain and device/group
Message-ID: <YxilZbRL0WBR97oi@8bytes.org>
References: <20220815181437.28127-1-nicolinc@nvidia.com>
 <20220815181437.28127-2-nicolinc@nvidia.com>
 <YxiRkm7qgQ4k+PIG@8bytes.org> <Yxig+zfA2Pr4vk6K@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yxig+zfA2Pr4vk6K@nvidia.com>
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

On Wed, Sep 07, 2022 at 10:47:39AM -0300, Jason Gunthorpe wrote:
> Would you be happier if we wrote it like
> 
>  #define IOMMU_EINCOMPATIBLE_DEVICE xx
> 
> Which tells "which of the function parameters is actually invalid" ?

Having done some Rust hacking in the last months, I have to say I like
to concept of error handling with Result<> there. Ideally we have a way
to emulate that in our C code without having to change all callers.

What I am proposing is a way this could be emulated here, but I am open
to other suggestions. Still better than re-using random error codes for
special purposes.

Regards,

	Joerg
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
