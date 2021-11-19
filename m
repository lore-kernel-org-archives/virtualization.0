Return-Path: <SRS0=gSim=QG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4438C433F5
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 12:33:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405F061AD0
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 12:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 405F061AD0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D867405E3;
	Fri, 19 Nov 2021 12:33:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uUgovbYJv-Mo; Fri, 19 Nov 2021 12:33:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BCDC34062A;
	Fri, 19 Nov 2021 12:33:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 799EFC0037;
	Fri, 19 Nov 2021 12:33:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E7A4C0012;
 Fri, 19 Nov 2021 12:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5614F61BF6;
 Fri, 19 Nov 2021 12:33:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.cz header.b="Rj0Bb7aN";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.cz header.b="37Ndmb7m"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0-7NFhd3j9oM; Fri, 19 Nov 2021 12:33:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 32E9261BF5;
 Fri, 19 Nov 2021 12:33:07 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 014CB1FD3B;
 Fri, 19 Nov 2021 12:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637325185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4eXQRQkyOnlkfqIjP+4InF8CkZnCxzQH+4oBGRF5bzQ=;
 b=Rj0Bb7aNc9Pq/SEl+lwV4pZ0xaw0YNXnDB8He3zLmNU/uVGsBdvudyeinMU5nS85cF1Z+4
 j6sydHcbBQiWua8myjFS7weVD8guJQlxemgIa32po//oxhMSYutsZwDLfrpTOEc5UeCTWl
 A9LRFyBxKr+Zc5EgfzvvwhM3VaJHzyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637325185;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4eXQRQkyOnlkfqIjP+4InF8CkZnCxzQH+4oBGRF5bzQ=;
 b=37Ndmb7me3fMnFCMahzCk8SVpCAyZepl+YuAvScQn2siBak0RgVSkgkQs5eYMHcvE3YEfp
 Z71c+vJs+cLXasAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB59D13B2A;
 Fri, 19 Nov 2021 12:33:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 04/sMICZl2F8SwAAMHmgww
 (envelope-from <vbabka@suse.cz>); Fri, 19 Nov 2021 12:33:04 +0000
Message-ID: <3083463d-978b-fbe6-dadf-670d400ed437@suse.cz>
Date: Fri, 19 Nov 2021 13:33:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [RFC PATCH 0/3] Use pageblock_order for cma and
 alloc_contig_range alignment.
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org
References: <20211115193725.737539-1-zi.yan@sent.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211115193725.737539-1-zi.yan@sent.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
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

On 11/15/21 20:37, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Hi David,
> 
> You suggested to make alloc_contig_range() deal with pageblock_order instead of
> MAX_ORDER - 1 and get rid of MAX_ORDER - 1 dependency in virtio_mem[1]. This
> patchset is my attempt to achieve that. Please take a look and let me know if
> I am doing it correctly or not.
> 
> From what my understanding, cma required alignment of
> max(MAX_ORDER - 1, pageblock_order), because when MIGRATE_CMA was introduced,
> __free_one_page() does not prevent merging two different pageblocks, when
> MAX_ORDER - 1 > pageblock_order. But current __free_one_page() implementation
> does prevent that.

But it does prevent that only for isolated pageblock, not CMA, and yout
patchset doesn't seem to expand that to CMA? Or am I missing something.


> It should be OK to just align cma to pageblock_order.
> alloc_contig_range() relies on MIGRATE_CMA to get free pages, so it can use
> pageblock_order as alignment too.
> 
> In terms of virtio_mem, if I understand correctly, it relies on
> alloc_contig_range() to obtain contiguous free pages and offlines them to reduce
> guest memory size. As the result of alloc_contig_range() alignment change,
> virtio_mem should be able to just align PFNs to pageblock_order.
> 
> Thanks.
> 
> 
> [1] https://lore.kernel.org/linux-mm/28b57903-fae6-47ac-7e1b-a1dd41421349@redhat.com/
> 
> Zi Yan (3):
>   mm: cma: alloc_contig_range: use pageblock_order as the single
>     alignment.
>   drivers: virtio_mem: use pageblock size as the minimum virtio_mem
>     size.
>   arch: powerpc: adjust fadump alignment to be pageblock aligned.
> 
>  arch/powerpc/include/asm/fadump-internal.h |  4 +---
>  drivers/virtio/virtio_mem.c                |  6 ++----
>  include/linux/mmzone.h                     |  5 +----
>  kernel/dma/contiguous.c                    |  2 +-
>  mm/cma.c                                   |  6 ++----
>  mm/page_alloc.c                            | 12 +++++-------
>  6 files changed, 12 insertions(+), 23 deletions(-)
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
