Return-Path: <SRS0=bDZb=GJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E4FC433E0
	for <virtualization@archiver.kernel.org>; Wed,  6 Jan 2021 09:41:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 920B323106
	for <virtualization@archiver.kernel.org>; Wed,  6 Jan 2021 09:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920B323106
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EDF93204B5;
	Wed,  6 Jan 2021 09:41:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6GRq-82tTER7; Wed,  6 Jan 2021 09:41:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2121B204A4;
	Wed,  6 Jan 2021 09:41:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AE72C088B;
	Wed,  6 Jan 2021 09:41:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCDC9C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 09:41:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B33EB86DCA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 09:41:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tgPDG7gD9UgW
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 09:41:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 958C886D88
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 09:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609926082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9CA1AR5nXWGzRi5gkPRl8C2ixPan6lcvaX7CUQMGuI=;
 b=SZZM7f9UOCBnFa/DkD2Q9sh+KD5oZkkvAn6aXRulfnUKLzNdUPvWxS721XBd/n/QC03tdP
 o0Z7ksy28Ro3NcHwcAbL9cBS4ru5bET6sjeUw2ZyH+rwevIjjlJLI2jpIQQ0q24V+DvBhZ
 kKS9Z8/U+VL7zScjHFIPzdF3aVafDOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-yV9DYsxyOcmAP7AkRXFbng-1; Wed, 06 Jan 2021 04:41:18 -0500
X-MC-Unique: yV9DYsxyOcmAP7AkRXFbng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBF57800D53;
 Wed,  6 Jan 2021 09:41:15 +0000 (UTC)
Received: from [10.36.112.160] (ovpn-112-160.ams2.redhat.com [10.36.112.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA58F71CA1;
 Wed,  6 Jan 2021 09:41:09 +0000 (UTC)
Subject: Re: [PATCH 0/6] hugetlbfs: support free page reporting
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>,
 Liang Li <liliangleo@didiglobal.com>, Mike Kravetz
 <mike.kravetz@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
References: <20210106034623.GA1128@open-light-1.localdomain>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <effc0673-0452-08d8-819b-70aee14643c5@redhat.com>
Date: Wed, 6 Jan 2021 10:41:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210106034623.GA1128@open-light-1.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

On 06.01.21 04:46, Liang Li wrote:
> A typical usage of hugetlbfs it's to reserve amount of memory
> during the kernel booting stage, and the reserved pages are
> unlikely to return to the buddy system. When application need
> hugepages, kernel will allocate them from the reserved pool.
> when application terminates, huge pages will return to the
> reserved pool and are kept in the free list for hugetlbfs,
> these free pages will not return to buddy freelist unless the
> size of reserved pool is changed. 
> Free page reporting only supports buddy pages, it can't report
> the free pages reserved for hugetlbfs. On the other hand,
> hugetlbfs is a good choice for system with a huge amount of RAM,
> because it can help to reduce the memory management overhead and
> improve system performance.
> This patch add the support for reporting hugepages in the free
> list of hugetlbfs, it can be used by virtio_balloon driver for
> memory overcommit and pre zero out free pages for speeding up
> memory population and page fault handling.

You should lay out the use case + measurements. Further you should
describe what this patch set actually does, how behavior can be tuned,
pros and cons, etc... And you should most probably keep this RFC.

> 
> Most of the code are 'copied' from free page reporting because
> they are working in the same way. So the code can be refined to
> remove duplication. It can be done later.

Nothing speaks about getting it right from the beginning. Otherwise it
will most likely never happen.

> 
> Since some guys have some concern about side effect of the 'buddy
> free page pre zero out' feature brings, I remove it from this
> serier.

You should really point out what changed size the last version. I
remember Alex and Mike had some pretty solid points of what they don't
want to see (especially: don't use free page reporting infrastructure
and don't temporarily allocate huge pages for processing them).

I am not convinced that we want to use the free page reporting
infrastructure for this (pre-zeroing huge pages). What speaks about a
thread simply iterating over huge pages one at a time, zeroing them? The
whole free page reporting infrastructure was invented because we have to
do expensive coordination (+ locking) when going via the hypervisor. For
the main use case of zeroing huge pages in the background, I don't see a
real need for that. If you believe this is the right thing to do, please
add a discussion regarding this.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
