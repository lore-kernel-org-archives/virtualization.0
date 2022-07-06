Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1D6C433EF
	for <virtualization@archiver.kernel.org>; Wed,  6 Jul 2022 12:12:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 621174027A;
	Wed,  6 Jul 2022 12:12:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 621174027A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=T+SyMH5m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BsYtZ5iPb7ms; Wed,  6 Jul 2022 12:12:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 81B934025E;
	Wed,  6 Jul 2022 12:12:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 81B934025E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B527C0033;
	Wed,  6 Jul 2022 12:12:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 136C1C002D;
 Wed,  6 Jul 2022 12:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D26BA40AD6;
 Wed,  6 Jul 2022 12:12:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D26BA40AD6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=T+SyMH5m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ybniTohZki24; Wed,  6 Jul 2022 12:12:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0DA4D404F6
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0DA4D404F6;
 Wed,  6 Jul 2022 12:12:51 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5302F61032;
 Wed,  6 Jul 2022 12:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7099DC3411C;
 Wed,  6 Jul 2022 12:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657109570;
 bh=QHpLGHyLyN/b6QbnN5swFE8qHq/MeprwbhETMjBS7NE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T+SyMH5mpkB1jQPKZy9F50UjS50/4YjeuHJYjvUv2DYwxnaaKls/y4hMo4epqHQ+N
 nXrqLg8WAxiBDcR11EcnsHO0IbItEPu5p7bBpjq8G89OEtSjQt4Fm4QXcy+WnWsu9U
 g0YLb967hCr+xPt/Vttjvc0yZSs/BvlXv29Hmu+G+6UFEDpYEke0PySivW5fQgKgTV
 4qS84j6q4oBPrq5AtZyYOuhM0R3HsDmnB/7jsYvQUwhHTVM0viUzMMnE/e6OqTjdPg
 HC68cCRm/klseXQQvbL3fUPZi4XeCgH1HESUml55uM8B6ODnI2rjHiTziS3/w6l49R
 WPafFdUDf6wzA==
Date: Wed, 6 Jul 2022 13:12:44 +0100
From: Will Deacon <will@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH RESEND v5 1/5] iommu: Refactor iommu_group_store_type()
Message-ID: <20220706121244.GH2403@willie-the-truck>
References: <1649071634-188535-1-git-send-email-john.garry@huawei.com>
 <1649071634-188535-2-git-send-email-john.garry@huawei.com>
 <20220706120059.GE2403@willie-the-truck>
 <5ab934ff-0b16-0b55-e0f1-36366cd33e84@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5ab934ff-0b16-0b55-e0f1-36366cd33e84@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jean-philippe@linaro.org, mst@redhat.com, joro@8bytes.org,
 chenxiang66@hisilicon.com, linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 thunder.leizhen@huawei.com, robin.murphy@arm.com
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

On Wed, Jul 06, 2022 at 01:03:44PM +0100, John Garry wrote:
> On 06/07/2022 13:00, Will Deacon wrote:
> > On Mon, Apr 04, 2022 at 07:27:10PM +0800, John Garry wrote:
> > > Function iommu_group_store_type() supports changing the default domain
> > > of an IOMMU group.
> > > 
> > > Many conditions need to be satisfied and steps taken for this action to be
> > > successful.
> > > 
> > > Satisfying these conditions and steps will be required for setting other
> > > IOMMU group attributes, so factor into a common part and a part specific
> > > to update the IOMMU group attribute.
> > > 
> > > No functional change intended.
> > > 
> > > Some code comments are tidied up also.
> > > 
> > > Signed-off-by: John Garry<john.garry@huawei.com>
> > > ---
> > >   drivers/iommu/iommu.c | 96 ++++++++++++++++++++++++++++---------------
> > >   1 file changed, 62 insertions(+), 34 deletions(-)
> > Acked-by: Will Deacon<will@kernel.org>
> > 
> 
> Thanks, but currently I have no plans to progress this series, in favour of
> this https://lore.kernel.org/linux-iommu/1656590892-42307-1-git-send-email-john.garry@huawei.com/T/#me0e806913050c95f6e6ba2c7f7d96d51ce191204

heh, then I'll stop reviewing it then :) Shame, I quite liked it so far!

Will
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
