Return-Path: <SRS0=SHSW=II=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BDEC433E0
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 10:56:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A6864FBA
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 10:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A6864FBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2DE384352;
	Wed, 10 Mar 2021 10:56:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rYT_-Tyq-VrL; Wed, 10 Mar 2021 10:56:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34BFF84330;
	Wed, 10 Mar 2021 10:56:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD03EC0011;
	Wed, 10 Mar 2021 10:56:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1460C0001;
 Wed, 10 Mar 2021 10:55:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 788E34EC58;
 Wed, 10 Mar 2021 10:55:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FknPplhW73ik; Wed, 10 Mar 2021 10:55:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BA2EA4EC57;
 Wed, 10 Mar 2021 10:55:58 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0375464FBA;
 Wed, 10 Mar 2021 10:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615373758;
 bh=l5F4mRFTlCcuvK65v3+ubAAIjsEOKjTToYBZnVrSV8Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Snrq3o6NQfFy8T13bWkjeS0t+DUxWxLJ7ItwwsFvYQUN059elyy12JfOlinrWY9b9
 HZXz58NlMVNMAanXaV4jMPtH+wZ63zpj4onuFCjkYAw0y6Itf99qSovicg/AvxjLlu
 dC1gGgjIjClyM+tZEQc82j0YPmrepv2haKqVn9pXRXBSHMvhcAemlq17an5DZjsRLD
 GavAs3RvhjKvztQsc6QzDP7siwQGDfGWNWfSNCMIjao9k51gQwMEycEcBk2+iaZ2FD
 GfnBGnq0Lliwgyj+ZV+DmU7+2pHmPC7dDWTA6KQMdLwYszXdvPO5XE4k7J4bo7MxuP
 Ok+UecEar6NwQ==
Date: Wed, 10 Mar 2021 10:55:51 +0000
From: Will Deacon <will@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [Freedreno] [PATCH 16/17] iommu: remove DOMAIN_ATTR_IO_PGTABLE_CFG
Message-ID: <20210310105550.GA29270@willie-the-truck>
References: <20210301084257.945454-1-hch@lst.de>
 <20210301084257.945454-17-hch@lst.de>
 <d567ad5c-5f89-effa-7260-88c6d86b4695@arm.com>
 <CAF6AEGtTs-=aO-Ntp0Qn6mYDSv4x0-q3y217QxU7kZ6H1b1fiQ@mail.gmail.com>
 <20210305100012.GB22536@willie-the-truck>
 <20210310085806.GB5928@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210310085806.GB5928@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: freedreno <freedreno@lists.freedesktop.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>, kvm@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Joerg Roedel <joro@8bytes.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Li Yang <leoyang.li@nxp.com>,
 Rob Clark <robdclark@gmail.com>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 netdev@vger.kernel.org,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On Wed, Mar 10, 2021 at 09:58:06AM +0100, Christoph Hellwig wrote:
> On Fri, Mar 05, 2021 at 10:00:12AM +0000, Will Deacon wrote:
> > > But one thing I'm not sure about is whether
> > > IO_PGTABLE_QUIRK_ARM_OUTER_WBWA is something that other devices
> > > *should* be using as well, but just haven't gotten around to yet.
> > 
> > The intention is certainly that this would be a place to collate per-domain
> > pgtable quirks, so I'd prefer not to tie that to the GPU.
> 
> So the overall consensus is to just keep this as-is for now?

Yes, please. If it doesn't see wider adoption then we can revisit it.

Will
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
