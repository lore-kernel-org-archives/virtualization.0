Return-Path: <SRS0=i4sF=I4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A874FC433E1
	for <virtualization@archiver.kernel.org>; Tue, 30 Mar 2021 12:54:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF99619B4
	for <virtualization@archiver.kernel.org>; Tue, 30 Mar 2021 12:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF99619B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20304607C1;
	Tue, 30 Mar 2021 12:54:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3fHUk7RSXJzK; Tue, 30 Mar 2021 12:54:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAC21607EA;
	Tue, 30 Mar 2021 12:54:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75B65C0013;
	Tue, 30 Mar 2021 12:54:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E07DC000A;
 Tue, 30 Mar 2021 12:54:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1E6FE8305A;
 Tue, 30 Mar 2021 12:54:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V-YAIEP282NQ; Tue, 30 Mar 2021 12:54:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 97BAB82D62;
 Tue, 30 Mar 2021 12:54:04 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBEC161955;
 Tue, 30 Mar 2021 12:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617108844;
 bh=MUsAReQl36x7SR3EX7iZh5BEyF4eEO7patp68iu3zYw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RvhuDRnnjbhKmZxor1XvWHCMInipWXvRtxAnhtWSHyskQigqXOQJZBpmkmtBZyI42
 Hzk9YR+zXiAqh+GqCuQsV/e9VwUlbbLL2WBWuGxyEgIjksxNm4QjWpE80+c+eJgjxa
 CDgfI0Go46YGTQMxgFvBCCBuNUOdQ5A9e4RX4fJZrV2JQkPw15LXMK/zAx+kh0z7vL
 kyRwRMIu/q/vE1ATdrsCa4384znPHm83guJWxqP2Cv0dXtUc4fw5FRdDw0Q8vG1MD6
 rhCut5ZrQW9EjJtIgqABXSUdPcCMBGGg98+FfQp3aOd/QWoqSzA6/B7VI2jDOm1MH1
 7esynnh6eCt1Q==
Date: Tue, 30 Mar 2021 13:53:58 +0100
From: Will Deacon <will@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 10/18] iommu/fsl_pamu: enable the liodn when attaching a
 device
Message-ID: <20210330125358.GJ5908@willie-the-truck>
References: <20210316153825.135976-1-hch@lst.de>
 <20210316153825.135976-11-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210316153825.135976-11-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: freedreno@lists.freedesktop.org, kvm@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Joerg Roedel <joro@8bytes.org>,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Lu Baolu <baolu.lu@linux.intel.com>
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

On Tue, Mar 16, 2021 at 04:38:16PM +0100, Christoph Hellwig wrote:
> Instead of a separate call to enable all devices from the list, just
> enablde the liodn one the device is attached to the iommu domain.

(typos: "enablde" and "one" probably needs to be "once"?)

> This also remove the DOMAIN_ATTR_FSL_PAMU_ENABLE iommu_attr.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Li Yang <leoyang.li@nxp.com>
> ---
>  drivers/iommu/fsl_pamu_domain.c     | 47 ++---------------------------
>  drivers/iommu/fsl_pamu_domain.h     | 10 ------
>  drivers/soc/fsl/qbman/qman_portal.c | 11 -------
>  include/linux/iommu.h               |  1 -
>  4 files changed, 3 insertions(+), 66 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
