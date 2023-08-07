Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785CDC04A6A
	for <virtualization@archiver.kernel.org>; Mon,  7 Aug 2023 13:09:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ED40340B51;
	Mon,  7 Aug 2023 13:09:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ED40340B51
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.a=rsa-sha256 header.s=default header.b=JPMPMNcX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gIqg92E6OCxA; Mon,  7 Aug 2023 13:09:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7761A40B68;
	Mon,  7 Aug 2023 13:09:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7761A40B68
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FC00C0072;
	Mon,  7 Aug 2023 13:09:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D1F8C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Aug 2023 13:09:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 559F1408D8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Aug 2023 13:09:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 559F1408D8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org
 header.a=rsa-sha256 header.s=default header.b=JPMPMNcX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8KlXhuBTlYGl
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Aug 2023 13:09:24 +0000 (UTC)
X-Greylist: delayed 546 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 07 Aug 2023 13:09:23 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EAB1F401E5
Received: from mail.8bytes.org (mail.8bytes.org
 [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
 by smtp4.osuosl.org (Postfix) with ESMTP id EAB1F401E5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Aug 2023 13:09:23 +0000 (UTC)
Received: from 8bytes.org (pd9fe94eb.dip0.t-ipconnect.de [217.254.148.235])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id CB3112802C0;
 Mon,  7 Aug 2023 15:00:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1691413215;
 bh=7JkbUbcsQYDUm7+d1Qwf9eXdnSaQOoOuTXAnXPF6eXs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JPMPMNcXrYSDEc82SoNmtOqraBcGews6IPyM7KqoT53fWXP892yQrt6FntitNudOw
 aIZudgFHjcWlsw8HCeSgY9qxqkdFRAgpuvTl753O1uV1Sp4cNTC71xOxvpmfH50yb7
 0rsRVjsm3j1M2pQRDzFnq1Sq/Ez4f8w+eOaD5QrOdnAh0QTwXHdo3dFg68vtgetqmo
 PraCiPeh53gllj0O0TljM9b6kC4EiPum0LZGv+qgFvl6qajCl0Eo5b1J9EzUkGrqRr
 TvO9A7Nez2tJI3c5SbUT2557k5CxQlNq7XH7JrP7+PVM/M8cCYN9APgtwcNs9SN6ZH
 LeUd395XfXWrQ==
Date: Mon, 7 Aug 2023 15:00:13 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] iommu: Explicitly include correct DT includes
Message-ID: <ZNDq3da76i13WuqA@8bytes.org>
References: <20230714174640.4058404-1-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230714174640.4058404-1-robh@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, iommu@lists.linux.dev,
 Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
 Chunyan Zhang <zhang.lyra@gmail.com>, linux-kernel@vger.kernel.org,
 Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-arm-msm@vger.kernel.org,
 linux-tegra@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
 virtualization@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

On Fri, Jul 14, 2023 at 11:46:39AM -0600, Rob Herring wrote:
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c | 2 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c            | 1 -
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c          | 3 +--
>  drivers/iommu/ipmmu-vmsa.c                       | 1 -
>  drivers/iommu/sprd-iommu.c                       | 1 +
>  drivers/iommu/tegra-smmu.c                       | 2 +-
>  drivers/iommu/virtio-iommu.c                     | 2 +-
>  7 files changed, 5 insertions(+), 7 deletions(-)

Applied, thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
