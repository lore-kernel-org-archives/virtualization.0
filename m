Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AD6C433EF
	for <virtualization@archiver.kernel.org>; Wed,  6 Jul 2022 12:11:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA59241849;
	Wed,  6 Jul 2022 12:11:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DA59241849
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lwCf+b5Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P2weILjeTJK0; Wed,  6 Jul 2022 12:11:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 01A7141839;
	Wed,  6 Jul 2022 12:11:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 01A7141839
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB736C0033;
	Wed,  6 Jul 2022 12:11:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBB1DC002D;
 Wed,  6 Jul 2022 12:11:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B68B980BFE;
 Wed,  6 Jul 2022 12:11:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B68B980BFE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=lwCf+b5Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LbXgUq1JJGAZ; Wed,  6 Jul 2022 12:11:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6713A80BB8
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6713A80BB8;
 Wed,  6 Jul 2022 12:11:54 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9796E61F8D;
 Wed,  6 Jul 2022 12:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376C8C341C0;
 Wed,  6 Jul 2022 12:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657109512;
 bh=SeP+pP9PIpzAPPpJhtZkpan835Qsg2jX4rok4kM3sRg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lwCf+b5YlgzovcNzoC+4ZeUraeGLv/Sw51y8rFKv9x+kKwiJzJeQm3AGRaDNAfIQv
 OZkf3j+7FfcaTNwmuL58WhUHcLKLnhHBMsSHzmBC3+YsWeK9tZefF3y26C151bH7Qd
 U9svzLMEdPsnlalg7nkHuu2oQnIZRgC1UixyybKFENWTDazFKxTMX5+Q8OqQn1RzdP
 FO2fT6zuwhcTs16IMELy73gL8TPupxG45MRzCuJtz6XWXI4kESHjGGg5dTH709IqA9
 F/QNjICHhh25JoTHiOa8f1KbF4TMtTetdpOhxYgARTqjEAvdUYoTDOT5qVQVipf8fS
 sjAEvTC+KzK7A==
Date: Wed, 6 Jul 2022 13:11:44 +0100
From: Will Deacon <will@kernel.org>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH RESEND v5 2/5] iova: Allow rcache range upper limit to be
 flexible
Message-ID: <20220706121144.GG2403@willie-the-truck>
References: <1649071634-188535-1-git-send-email-john.garry@huawei.com>
 <1649071634-188535-3-git-send-email-john.garry@huawei.com>
 <834447a0-675a-5978-8ffe-285ce09f4213@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <834447a0-675a-5978-8ffe-285ce09f4213@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: chenxiang66@hisilicon.com, mst@redhat.com, joro@8bytes.org,
 John Garry <john.garry@huawei.com>, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, jean-philippe@linaro.org,
 robin.murphy@arm.com
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

On Thu, Apr 07, 2022 at 03:52:53PM +0800, Leizhen (ThunderTown) wrote:
> On 2022/4/4 19:27, John Garry wrote:
> > Some low-level drivers may request DMA mappings whose IOVA length exceeds
> > that of the current rcache upper limit.
> > 
> > This means that allocations for those IOVAs will never be cached, and
> > always must be allocated and freed from the RB tree per DMA mapping cycle.
> > This has a significant effect on performance, more so since commit
> > 4e89dce72521 ("iommu/iova: Retry from last rb tree node if iova search
> > fails"), as discussed at [0].
> > 
> > As a first step towards allowing the rcache range upper limit be
> > configured, hold this value in the IOVA rcache structure, and allocate
> > the rcaches separately.
> > 
> > Delete macro IOVA_RANGE_CACHE_MAX_SIZE in case it's reused by mistake.
> > 
> > [0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
> > 
> > Signed-off-by: John Garry <john.garry@huawei.com>
> > ---
> >  drivers/iommu/iova.c | 20 ++++++++++----------
> >  include/linux/iova.h |  3 +++
> >  2 files changed, 13 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> > index db77aa675145..5c22b9187b79 100644
> > --- a/drivers/iommu/iova.c
> > +++ b/drivers/iommu/iova.c
> > @@ -15,8 +15,6 @@
> >  /* The anchor node sits above the top of the usable address space */
> >  #define IOVA_ANCHOR	~0UL
> >  
> > -#define IOVA_RANGE_CACHE_MAX_SIZE 6	/* log of max cached IOVA range size (in pages) */
> > -
> >  static bool iova_rcache_insert(struct iova_domain *iovad,
> >  			       unsigned long pfn,
> >  			       unsigned long size);
> > @@ -443,7 +441,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
> >  	 * rounding up anything cacheable to make sure that can't happen. The
> >  	 * order of the unadjusted size will still match upon freeing.
> >  	 */
> > -	if (size < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> > +	if (size < (1 << (iovad->rcache_max_size - 1)))
> >  		size = roundup_pow_of_two(size);
> >  
> >  	iova_pfn = iova_rcache_get(iovad, size, limit_pfn + 1);
> > @@ -713,13 +711,15 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
> >  	unsigned int cpu;
> >  	int i, ret;
> >  
> > -	iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_MAX_SIZE,
> > +	iovad->rcache_max_size = 6; /* Arbitrarily high default */
> 
> It would be better to assign this constant value to iovad->rcache_max_size
> in init_iova_domain().

I think it's fine where it is as it's a meaningless number outside of the
rcache code.

Will
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
