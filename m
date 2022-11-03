Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA6AC433FE
	for <virtualization@archiver.kernel.org>; Thu,  3 Nov 2022 14:53:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 913FE81F18;
	Thu,  3 Nov 2022 14:53:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 913FE81F18
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.a=rsa-sha256 header.s=default header.b=inVtOODT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id asYuyJcNCNHq; Thu,  3 Nov 2022 14:53:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 34F9D81F19;
	Thu,  3 Nov 2022 14:53:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 34F9D81F19
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0677AC0032;
	Thu,  3 Nov 2022 14:53:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 374BFC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Nov 2022 14:53:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1283A60FA2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Nov 2022 14:53:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1283A60FA2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org
 header.a=rsa-sha256 header.s=default header.b=inVtOODT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UnuPOOQM18gA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Nov 2022 14:53:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3525160B14
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3525160B14
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Nov 2022 14:53:19 +0000 (UTC)
Received: from 8bytes.org (p5b00664c.dip0.t-ipconnect.de [91.0.102.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 0E894260033;
 Thu,  3 Nov 2022 15:53:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1667487197;
 bh=W+503lTP2jRAK3Vj/frLD3iD/xxYLTMy9NfG9rA+raI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=inVtOODTjwGgyJlA7Iw794Ad9BngxsaqLHg7pXU8cE21CYQBhPuH9VdUpIQOeaTSA
 fJRx4FJ0TaD8loMduyufhX8+Le3tGOOTTSCzJkzEbwBKjIrdm/eN28sgxmf+v0n8Aq
 3PFZrjec5c0TcKVsuoVv048G4EeBWwcabN+T7uc6MXQoi+GwA8IWO8eAfAM/qbbB+6
 PqSTLVX+5sgCz7aSyOxDrkdrzQFN7TnyvR6B1E8PpBd97S+SidrA2xTFoaLtyIY69b
 0jUBi9bVQBURoAIydeT86AZeQ/oLUb0hIbNNjzY2aYTLZEbhFbCGKSy7KiYEeAbsC5
 lMxXjvVEer9cQ==
Date: Thu, 3 Nov 2022 15:53:15 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [GIT PULL iommu] Please pull iommu errno changes
Message-ID: <Y2PV26igcbY6Atu+@8bytes.org>
References: <Y2Jn7Jskqzz95XB4@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y2Jn7Jskqzz95XB4@nvidia.com>
Cc: quic_saipraka@quicinc.com, yangyicong@hisilicon.com,
 linux-tegra@vger.kernel.org, thierry.reding@gmail.com, will@kernel.org,
 jean-philippe@linaro.org, zhang.lyra@gmail.com, jon@solid-run.com,
 jonathanh@nvidia.com, iommu@lists.linux.dev,
 Nicolin Chen <nicolinc@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 yangyingliang@huawei.com, orsonzhai@gmail.com, dwmw2@infradead.org,
 linux-arm-msm@vger.kernel.org, vdumpa@nvidia.com,
 christophe.jaillet@wanadoo.fr, baolin.wang@linux.alibaba.com,
 matthias.bgg@gmail.com, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, yong.wu@mediatek.com,
 quic_jjohnson@quicinc.com, linux-kernel@vger.kernel.org,
 shameerali.kolothum.thodi@huawei.com, robdclark@gmail.com,
 suravee.suthikulpanit@amd.com, linux-mediatek@lists.infradead.org,
 robin.murphy@arm.com, baolu.lu@linux.intel.com
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

On Wed, Nov 02, 2022 at 09:51:56AM -0300, Jason Gunthorpe wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-joerg

Pulled, thanks Jason and Nicolin.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
