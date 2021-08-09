Return-Path: <SRS0=ROIW=NA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE17C4320E
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 07:35:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B94286105A
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 07:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B94286105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7A5F44011F;
	Mon,  9 Aug 2021 07:35:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id donNAudHGNBq; Mon,  9 Aug 2021 07:35:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A7F62400BE;
	Mon,  9 Aug 2021 07:35:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D752C001A;
	Mon,  9 Aug 2021 07:35:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8151C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 07:35:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 94977400C8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 07:35:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oFMZQILnMGZk
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 07:35:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 577CD400BE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 07:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628494516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rl8X9okvlYfR8iDE1jtv9Hzx9xj5s4hp+iTOYsKFl2Y=;
 b=NUakwVHoYBkJrBgHPtMf80tJ0vhA5RFYBYY3KIeGlIfwTZFGjjfskCSvwTMJSnOkG4+E7g
 Tb73P1KS0GELEKX4uOjwG6kFDnXYoeyE1YnLF2pAXNyaw7nMCnQGQmauODVSgyqPZsGlLn
 zOAItQmRSPBBy8Te/2cX5j40CoVIXAM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-x-5d-DXkNvyojZ3_NYtkow-1; Mon, 09 Aug 2021 03:35:15 -0400
X-MC-Unique: x-5d-DXkNvyojZ3_NYtkow-1
Received: by mail-wm1-f70.google.com with SMTP id
 e21-20020a05600c4b95b029025b007a168dso6530580wmp.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Aug 2021 00:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:organization:subject
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=rl8X9okvlYfR8iDE1jtv9Hzx9xj5s4hp+iTOYsKFl2Y=;
 b=ZHkePBOMh1FusB87SDy2uBiVlkoXBD+hknydzvkhFG7NYE9zMR+R7T8W0YuMjyPa+e
 C3gEsuN9vENKX8mEskieAi0bKWe0tuja5XcRqyqqg8SA1eTMGPMLks+vNM7o0D3rSw2g
 AjudlqOa+bVl4U2qZ5hG+jYQl8e4BIVux/pjW9TFRSFt3dz9Sy26zgwOIY+3Bb6tGGtw
 7JPqug32v3HXBgNHAx1+5efyfNKcuoueSv19OMtzhwNb5UxZWnNeLmqQ9qz1dz8xWc3m
 LBKMRGKPJnMpcWLC7YfSl2ylvbx0CusLen2l1CTQHNlE+HAKOu8/Vw1fo+Bu/2mBJ4LE
 Pzow==
X-Gm-Message-State: AOAM530QdJIeMEdbNT549Aw3V1BJ62gzlt0fiAVQ8eaLiifAw4voUS7F
 99Y5zq1yBYfxsW8Ig7ZaisF5QyjR5vlsTi3d1Ay5CMPqyiFSK99sV5tzrGCNm0NtilyeK4F62I0
 MYGDb0CPBEkFn7ATIZuIcp+0OgV19KEJ0jIAthaCXezFg5+EvHThg5+kHjS6ATkazkYhreLPyKN
 MCmXKjgTm0JirB8A==
X-Received: by 2002:a5d:55cb:: with SMTP id i11mr23249409wrw.158.1628494513961; 
 Mon, 09 Aug 2021 00:35:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwET0FjNJfOicoIvhPZYDAmrbe03wsX0H3c356yu3WbSOtd2PSqPGq14qTm/tUGbraB0CrFDg==
X-Received: by 2002:a5d:55cb:: with SMTP id i11mr23249373wrw.158.1628494513694; 
 Mon, 09 Aug 2021 00:35:13 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f?
 (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de.
 [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
 by smtp.gmail.com with ESMTPSA id p14sm155887wmi.42.2021.08.09.00.35.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Aug 2021 00:35:13 -0700 (PDT)
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <20210805190253.2795604-10-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 09/15] virtio: virtio_mem: use PAGES_PER_SECTION
 instead of MAX_ORDER_NR_PAGES
Message-ID: <3e2f1910-e7d9-ddf9-063b-d702793f1525@redhat.com>
Date: Mon, 9 Aug 2021 09:35:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805190253.2795604-10-zi.yan@sent.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 virtualization@lists.linux-foundation.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 05.08.21 21:02, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> It keeps the existing behavior when MAX_ORDER grows beyond a section
> size.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/virtio/virtio_mem.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 19036922f7ef..bab5a81fa796 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -1105,11 +1105,11 @@ static void virtio_mem_clear_fake_offline(unsigned long pfn,
>    */
>   static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
>   {
> -	const unsigned long max_nr_pages = MAX_ORDER_NR_PAGES;
> +	const unsigned long max_nr_pages = PAGES_PER_SECTION;
>   	unsigned long i;
>   
>   	/*
> -	 * We are always called at least with MAX_ORDER_NR_PAGES
> +	 * We are always called at least with PAGES_PER_SECTION
>   	 * granularity/alignment (e.g., the way subblocks work). All pages
>   	 * inside such a block are alike.
>   	 */
> @@ -1125,7 +1125,7 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
>   		if (PageDirty(page)) {
>   			virtio_mem_clear_fake_offline(pfn + i, max_nr_pages,
>   						      false);
> -			generic_online_page(page, MAX_ORDER - 1);
> +			generic_online_page(page, PAGES_PER_SECTION - 1);
>   		} else {
>   			virtio_mem_clear_fake_offline(pfn + i, max_nr_pages,
>   						      true);
> @@ -1228,7 +1228,7 @@ static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
>   		if (vm->in_sbm) {
>   			/*
>   			 * We exploit here that subblocks have at least
> -			 * MAX_ORDER_NR_PAGES size/alignment - so we cannot
> +			 * PAGES_PER_SECTION size/alignment - so we cannot
>   			 * cross subblocks within one call.
>   			 */
>   			id = virtio_mem_phys_to_mb_id(addr);
> @@ -2438,14 +2438,14 @@ static int virtio_mem_init(struct virtio_mem *vm)
>   				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
>   
>   	/*
> -	 * We want subblocks to span at least MAX_ORDER_NR_PAGES and
> +	 * We want subblocks to span at least PAGES_PER_SECTION and
>   	 * pageblock_nr_pages pages. This:
>   	 * - Simplifies our page onlining code (virtio_mem_online_page_cb)
>   	 *   and fake page onlining code (virtio_mem_fake_online).
>   	 * - Is required for now for alloc_contig_range() to work reliably -
>   	 *   it doesn't properly handle smaller granularity on ZONE_NORMAL.
>   	 */
> -	sb_size = max_t(uint64_t, MAX_ORDER_NR_PAGES,
> +	sb_size = max_t(uint64_t, PAGES_PER_SECTION,
>   			pageblock_nr_pages) * PAGE_SIZE;
>   	sb_size = max_t(uint64_t, vm->device_block_size, sb_size);
>   
> 

This is very much completely broken and destroys most of the purpose of 
virtio-mem. It even is broken once MAX_ORDER would exceed a single 
memory section I think.

Whatever you do, keep virtio-mem working *as is* unless someone 
explicitly sets MAX_ORDER on the command line to something bigger.


virtio-mem will require some minor adjustments once MAX_ORDER_NR_PAGES 
would exceed the memory section size -- the functionality will, however, 
be heavily degraded once you increase MAX_ORDER_NR_PAGES in any way 
(again, which is fine if it's explicitly done by an admin on the command 
line).

As mentioned somewhere else already, we'll have to tackle 
alloc_contig_range() to properly deal with pageblock_order granularity, 
then we can rework virtio-mem code to be based on that instead of 
MAX_ORDER - 1.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
