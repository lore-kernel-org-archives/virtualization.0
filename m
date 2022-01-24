Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3129AC433F5
	for <virtualization@archiver.kernel.org>; Mon, 24 Jan 2022 16:43:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2F4960B21;
	Mon, 24 Jan 2022 16:43:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aL5_SnHj-IiS; Mon, 24 Jan 2022 16:43:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7EDF4600C9;
	Mon, 24 Jan 2022 16:43:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47B0CC0039;
	Mon, 24 Jan 2022 16:43:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F5BFC002F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 16:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 60B584005C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 16:43:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DYu26FKGxyrU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 16:43:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from outbound-smtp41.blacknight.com (outbound-smtp41.blacknight.com
 [46.22.139.224])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2D780400F1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 16:43:33 +0000 (UTC)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
 by outbound-smtp41.blacknight.com (Postfix) with ESMTPS id 242301DDB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 16:43:31 +0000 (GMT)
Received: (qmail 22301 invoked from network); 24 Jan 2022 16:43:30 -0000
Received: from unknown (HELO techsingularity.net)
 (mgorman@techsingularity.net@[84.203.17.223])
 by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated);
 24 Jan 2022 16:43:30 -0000
Date: Mon, 24 Jan 2022 16:43:29 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v4 1/7] mm: page_alloc: avoid merging non-fallbackable
 pageblocks with others.
Message-ID: <20220124164329.GF3366@techsingularity.net>
References: <20220119190623.1029355-1-zi.yan@sent.com>
 <20220119190623.1029355-2-zi.yan@sent.com>
 <20220124140203.GE3366@techsingularity.net>
 <06467F5D-25F9-42DC-9FEC-6559E6058D01@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <06467F5D-25F9-42DC-9FEC-6559E6058D01@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Eric Ren <renzhengeek@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, Vlastimil Babka <vbabka@suse.cz>,
 Marek Szyprowski <m.szyprowski@samsung.com>
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

On Mon, Jan 24, 2022 at 11:12:07AM -0500, Zi Yan wrote:
> On 24 Jan 2022, at 9:02, Mel Gorman wrote:
> 
> > On Wed, Jan 19, 2022 at 02:06:17PM -0500, Zi Yan wrote:
> >> From: Zi Yan <ziy@nvidia.com>
> >>
> >> This is done in addition to MIGRATE_ISOLATE pageblock merge avoidance.
> >> It prepares for the upcoming removal of the MAX_ORDER-1 alignment
> >> requirement for CMA and alloc_contig_range().
> >>
> >> MIGRARTE_HIGHATOMIC should not merge with other migratetypes like
> >> MIGRATE_ISOLATE and MIGRARTE_CMA[1], so this commit prevents that too.
> >> Also add MIGRARTE_HIGHATOMIC to fallbacks array for completeness.
> >>
> >> [1] https://lore.kernel.org/linux-mm/20211130100853.GP3366@techsingularity.net/
> >>
> >> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >>
> >> <SNIP>
> >>
> >> @@ -2484,6 +2483,7 @@ static int fallbacks[MIGRATE_TYPES][3] = {
> >>  	[MIGRATE_UNMOVABLE]   = { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE,   MIGRATE_TYPES },
> >>  	[MIGRATE_MOVABLE]     = { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE, MIGRATE_TYPES },
> >>  	[MIGRATE_RECLAIMABLE] = { MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE,   MIGRATE_TYPES },
> >> +	[MIGRATE_HIGHATOMIC] = { MIGRATE_TYPES }, /* Never used */
> >>  #ifdef CONFIG_CMA
> >>  	[MIGRATE_CMA]         = { MIGRATE_TYPES }, /* Never used */
> >>  #endif
> >
> > If it's never used, why is it added?
> 
> Just to make the fallbacks list complete, since MIGRATE_CMA and
> MIGRATE_ISOLATE are in the list. Instead, I can remove MIGRATE_CMA and
> MIGRATE_ISOLATE. WDYT?
> 

It probably makes more sense to remove them or replace them with a comment
stating what migratetypes do not have a fallback list. Do it as a separate
patch that stands alone. It does not need to be part of this series.

-- 
Mel Gorman
SUSE Labs
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
