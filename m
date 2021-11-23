Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E39C433EF
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 17:32:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C0DD8186A;
	Tue, 23 Nov 2021 17:32:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GKUT00XyLwbg; Tue, 23 Nov 2021 17:32:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2960580C76;
	Tue, 23 Nov 2021 17:32:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90E37C0037;
	Tue, 23 Nov 2021 17:32:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 887A4C0012;
 Tue, 23 Nov 2021 17:32:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F2C260A8B;
 Tue, 23 Nov 2021 17:32:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.cz header.b="r66JtRer";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.cz header.b="am4OCcex"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zlZQVBF_aCLL; Tue, 23 Nov 2021 17:32:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EE02E60A6F;
 Tue, 23 Nov 2021 17:32:40 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D89BE212BC;
 Tue, 23 Nov 2021 17:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637688757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6JdPmib3v3gvcHABOETzZ3g4yrxlrjaBoIvxgUisgUk=;
 b=r66JtRer23NJRk+k29auveGw9fDYYnj0ZMA02hzpnaNq9sbA2d2i9wNaNeUo+j2IJ+Q+S3
 uZerhJbz8BNYQq0PXN0sjeLAHJ/BQxGW+GlZPuTTa6dU/wQemLh4eMQlVi3PXr5f4INu5y
 KMzb0hwlvKwk2q6GiaAjfIfmzPpQnng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637688757;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6JdPmib3v3gvcHABOETzZ3g4yrxlrjaBoIvxgUisgUk=;
 b=am4OCcexfMnSxTwGto3ZBFdx8gLwbJTA6JYc4MlBNIz2Levx3vwYlKj26iSJoKTHit3rsa
 GhHA2+pzc6oSP7Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A564313E41;
 Tue, 23 Nov 2021 17:32:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZCVIJ7UlnWGZfgAAMHmgww
 (envelope-from <vbabka@suse.cz>); Tue, 23 Nov 2021 17:32:37 +0000
Message-ID: <52dbf824-76be-cc34-3983-d45510b1b618@suse.cz>
Date: Tue, 23 Nov 2021 18:32:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>
References: <20211115193725.737539-1-zi.yan@sent.com>
 <3083463d-978b-fbe6-dadf-670d400ed437@suse.cz>
 <AEFF28CF-0ED8-450F-96A4-A6CD59CB1F3D@nvidia.com>
 <BF8FB68A-6E1D-4465-8A2B-884FC034660B@nvidia.com>
From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH 0/3] Use pageblock_order for cma and
 alloc_contig_range alignment.
In-Reply-To: <BF8FB68A-6E1D-4465-8A2B-884FC034660B@nvidia.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
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

On 11/23/21 17:35, Zi Yan wrote:
> On 19 Nov 2021, at 10:15, Zi Yan wrote:
>>>> From what my understanding, cma required alignment of
>>>> max(MAX_ORDER - 1, pageblock_order), because when MIGRATE_CMA was introduced,
>>>> __free_one_page() does not prevent merging two different pageblocks, when
>>>> MAX_ORDER - 1 > pageblock_order. But current __free_one_page() implementation
>>>> does prevent that.
>>>
>>> But it does prevent that only for isolated pageblock, not CMA, and yout
>>> patchset doesn't seem to expand that to CMA? Or am I missing something.
>>
>> Yeah, you are right. Originally, I thought preventing merging isolated pageblock
>> with other types of pageblocks is sufficient, since MIGRATE_CMA is always
>> converted from MIGRATE_ISOLATE. But that is not true. I will rework the code.
>> Thanks for pointing this out.
>>
> 
> I find that two pageblocks with different migratetypes, like MIGRATE_RECLAIMABLE
> and MIGRATE_MOVABLE can be merged into a single free page after I checked
> __free_one_page() in detail and printed pageblock information during buddy page
> merging.

Yes, that can happen.

I am not sure what consequence it will cause. Do you have any idea?

For MIGRATE_RECLAIMABLE or MIGRATE_MOVABLE or even MIGRATE_UNMOVABLE it's
absolutely fine. As long as these pageblocks are fully free (and they are if
it's a single free page spanning 2 pageblocks), they can be of any of these
type, as they can be reused as needed without causing fragmentation.

But in case of MIGRATE_CMA and MIGRATE_ISOLATE, uncontrolled merging would
break the specifics of those types. That's why the code is careful for
MIGRATE_ISOLATE, and MIGRATE_CMA was until now done in MAX_ORDER granularity.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
