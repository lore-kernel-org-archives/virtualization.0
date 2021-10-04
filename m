Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8555DC4332F
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 11:38:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 390696120D
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 11:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 390696120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C51E61B68;
	Mon,  4 Oct 2021 11:38:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cYPxrMn1ZDlA; Mon,  4 Oct 2021 11:38:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1980D61B65;
	Mon,  4 Oct 2021 11:38:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2E4CC0023;
	Mon,  4 Oct 2021 11:38:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F07AC000D;
 Mon,  4 Oct 2021 11:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 30A2B84BA6;
 Mon,  4 Oct 2021 11:38:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1PCknOnya97n; Mon,  4 Oct 2021 11:38:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E8EA84BA5;
 Mon,  4 Oct 2021 11:38:42 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 290916126A;
 Mon,  4 Oct 2021 11:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633347522;
 bh=N/fKuI91VrRX38cUMG86Df37anLTauMrP0OpxJCi4EI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TTkrdlhm3/0e4WSPrswiuvJ6yxGZZH6vwcl2WDPCFYPZr2jn45FbEWl3hH51TPZvb
 OWXVdGRV0O6Uohq6cjITxcYuib0OlvL0GzKGkIvXCwVElxgH6mwQZvj2z2q50wDJJt
 pDBBqywaPqY9+lEuXNzdZW6MW3ye2F6EX4AU9RVSgZOZqZjESk8d60SzEM1tqICqU2
 t2iCEUHmxKSxoEMmRcVQOLsxQGKG6CeJSOV8snLisDSgnLUztVaO6zaGbg4gS1An2d
 EP1YYfA/rty+mBnTxaOkZuFgcYgw78alWYM37TcB7FHtZ1s92B0EqQdli+cv6N1v6W
 +/PJFJ3akjvmg==
Date: Mon, 4 Oct 2021 12:38:36 +0100
From: Will Deacon <will@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 5/5] iommu/iova: Avoid double-negatives in magazine helpers
Message-ID: <20211004113836.GB27373@willie-the-truck>
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <1632477717-5254-6-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1632477717-5254-6-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mst@redhat.com, joro@8bytes.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, iommu@lists.linux-foundation.org,
 thunder.leizhen@huawei.com, robin.murphy@arm.com, baolu.lu@linux.intel.com
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

On Fri, Sep 24, 2021 at 06:01:57PM +0800, John Garry wrote:
> A similar crash to the following could be observed if initial CPU rcache
> magazine allocations fail in init_iova_rcaches():
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> Mem abort info:
> 
>   free_iova_fast+0xfc/0x280
>   iommu_dma_free_iova+0x64/0x70
>   __iommu_dma_unmap+0x9c/0xf8
>   iommu_dma_unmap_sg+0xa8/0xc8
>   dma_unmap_sg_attrs+0x28/0x50
>   cq_thread_v3_hw+0x2dc/0x528
>   irq_thread_fn+0x2c/0xa0
>   irq_thread+0x130/0x1e0
>   kthread+0x154/0x158
>   ret_from_fork+0x10/0x34
> 
> The issue is that expression !iova_magazine_full(NULL) evaluates true; this
> falls over in __iova_rcache_insert() when we attempt to cache a mag and
> cpu_rcache->loaded == NULL:
> 
> if (!iova_magazine_full(cpu_rcache->loaded)) {
> 	can_insert = true;
> ...
> 
> if (can_insert)
> 	iova_magazine_push(cpu_rcache->loaded, iova_pfn);
> 
> As above, can_insert is evaluated true, which it shouldn't be, and we try
> to insert pfns in a NULL mag, which is not safe.
> 
> To avoid this, stop using double-negatives, like !iova_magazine_full() and
> !iova_magazine_empty(), and use positive tests, like
> iova_magazine_has_space() and iova_magazine_has_pfns(), respectively; these
> can safely deal with cpu_rcache->{loaded, prev} = NULL.

I don't understand why you're saying that things like !iova_magazine_empty()
are double-negatives. What about e.g. !list_empty() elsewhre in the kernel?

The crux of the fix seems to be:

> @@ -783,8 +787,9 @@ static bool __iova_rcache_insert(struct iova_caching_domain *rcached,
>  		if (new_mag) {
>  			spin_lock(&rcache->lock);
>  			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
> -				rcache->depot[rcache->depot_size++] =
> -						cpu_rcache->loaded;
> +				if (cpu_rcache->loaded)
> +					rcache->depot[rcache->depot_size++] =
> +							cpu_rcache->loaded;

Which could be independent of the renaming?

Will
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
