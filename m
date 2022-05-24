Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F065CC433EF
	for <virtualization@archiver.kernel.org>; Tue, 24 May 2022 20:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A6D741B99;
	Tue, 24 May 2022 20:23:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YUUy26pUmGlZ; Tue, 24 May 2022 20:23:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B8EC741B93;
	Tue, 24 May 2022 20:23:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96D90C0032;
	Tue, 24 May 2022 20:23:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 994E7C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 20:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 84E9984034
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 20:23:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gbD8klFOtwJL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 20:23:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C17C584008
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 20:23:35 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 21456B81862;
 Tue, 24 May 2022 20:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711B8C34100;
 Tue, 24 May 2022 20:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1653423811;
 bh=1TBccbNXXdkA4yggnTErP3z1KQ5YvTNhTlw2uX3PD+0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=p8uKByO78gwiPvUIrtEW+RfKKx4lPhiAP5F3d+Wq8yHlKPW5HK6fS/Hs0x6HMjtdX
 aUqaytSI5r/DeFrqaaLyeLhjGs+E3H0zChZ50QZRKRiBU7KsZ7TBZa8X/Yx8eCIHm4
 /MROOd+wzqKIesHZFh49zCSmEQ3xemCYvb2Ndqng=
Date: Tue, 24 May 2022 13:23:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH] mm: fix a potential infinite loop in
 start_isolate_page_range().
Message-Id: <20220524132330.eaf1366967d2fa927fdaf995@linux-foundation.org>
In-Reply-To: <20220524194756.1698351-1-zi.yan@sent.com>
References: <20220524194756.1698351-1-zi.yan@sent.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Cc: Qian Cai <quic_qiancai@quicinc.com>, linux-kernel@vger.kernel.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Mike Rapoport <rppt@kernel.org>, Eric Ren <renzhengeek@gmail.com>,
 Zi Yan <zi.yan@sent.com>, Mel Gorman <mgorman@techsingularity.net>,
 Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>
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

On Tue, 24 May 2022 15:47:56 -0400 Zi Yan <zi.yan@sent.com> wrote:

> From: Zi Yan <ziy@nvidia.com>
> 
> In isolate_single_pageblock() called by start_isolate_page_range(),
> there are some pageblock isolation issues causing a potential
> infinite loop when isolating a page range. This is reported by Qian Cai.
> 
> 1. the pageblock was isolated by just changing pageblock migratetype
>    without checking unmovable pages. Calling set_migratetype_isolate() to
>    isolate pageblock properly.
> 2. an off-by-one error caused migrating pages unnecessarily, since the page
>    is not crossing pageblock boundary.
> 3. migrating a compound page across pageblock boundary then splitting the
>    free page later has a small race window that the free page might be
>    allocated again, so that the code will try again, causing an potential
>    infinite loop. Temporarily set the to-be-migrated page's pageblock to
>    MIGRATE_ISOLATE to prevent that and bail out early if no free page is
>    found after page migration.
> 
> An additional fix to split_free_page() aims to avoid crashing in
> __free_one_page(). When the free page is split at the specified
> split_pfn_offset, free_page_order should check both the first bit of
> free_page_pfn and the last bit of split_pfn_offset and use the smaller one.
> For example, if free_page_pfn=0x10000, split_pfn_offset=0xc000,
> free_page_order should first be 0x8000 then 0x4000, instead of 0x4000 then
> 0x8000, which the original algorithm did.
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1114,13 +1114,16 @@ void split_free_page(struct page *free_page,
>  	unsigned long flags;
>  	int free_page_order;
>  
> +	if (split_pfn_offset == 0)
> +		return;
> +
>  	spin_lock_irqsave(&zone->lock, flags);
>  	del_page_from_free_list(free_page, zone, order);
>  	for (pfn = free_page_pfn;
>  	     pfn < free_page_pfn + (1UL << order);) {
>  		int mt = get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
>  
> -		free_page_order = ffs(split_pfn_offset) - 1;
> +		free_page_order = min(pfn ? __ffs(pfn) : order, __fls(split_pfn_offset));

Why is it testing the zeroness of `pfn' here?  Can pfn==0 even happen? 
If so, it's a legitimate value so why does it get special-cased?



_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
