Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C7D235045
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 00:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776733152; cv=none; b=XaZO9YqPmBnzL1U7o+AjLxJEZ4b8xSVyLqWxXqoe69iIqO/F0K9AYbJcsQh1zYqrPnesjqEFfMu4HDJxW/9w38IVcrNbt5lFqC0qD9Y0nO5jGkb8qWn/25HZwqu2C40MCgLiW5kHZ3+b7ana1nEfjGXJ2FDBgrXkJHWPt8wTTvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776733152; c=relaxed/simple;
	bh=6C73BwFjiB4Uhl+iXeqGHDpJY45ehmJvEvP3w2YzlwM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t/bKgohfbYdD3pJOqYkNTEtz3WV3465PGlqhzCEKXLN48F5s+MCz9fwgJsJ7DXIo7ywM4Zq+Tlhwmm2bZvpanc6yPAtrlPnwcyKWMgbiqkQgXCAMsBeMhV67pINDHnK7TBAynjKVh2+5PzWoS6koqsKGieu1mtZTapMtTisjQ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RguoVPRK; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RguoVPRK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776733142; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=7yi+xUZCUd5yeE272YJMQ5iJ3vo6smTP4Z4GqGgtzU4=;
	b=RguoVPRKAQbcH2h0/QWfnQtOzTdRCnmcfM0RzqxiQtcq56cyUN+Ff1svS1CkwBqiozM1adJS1Slu1QBphIA9w2IZkoB49D5GaDsY3gArAdXXc0j2ehL7orVFkAmyXyQUrO7XGToT0nWUHwGrdwpIH/biGAOGJ3vC+aErbpPMEHg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=ying.huang@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0X1RC5RC_1776733139;
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0X1RC5RC_1776733139 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Apr 2026 08:59:00 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,  Andrew Morton
 <akpm@linux-foundation.org>,  David Hildenbrand <david@kernel.org>,
  Vlastimil Babka <vbabka@kernel.org>,  Brendan Jackman
 <jackmanb@google.com>,  Michal Hocko <mhocko@suse.com>,  Suren
 Baghdasaryan <surenb@google.com>,  Jason Wang <jasowang@redhat.com>,
  Andrea Arcangeli <aarcange@redhat.com>,  linux-mm@kvack.org,
  virtualization@lists.linux.dev,  Johannes Weiner <hannes@cmpxchg.org>,
  Zi Yan <ziy@nvidia.com>,  Lorenzo Stoakes <ljs@kernel.org>,  "Liam R.
 Howlett" <Liam.Howlett@oracle.com>,  Mike Rapoport <rppt@kernel.org>,
  Matthew Brost <matthew.brost@intel.com>,  Joshua Hahn
 <joshua.hahnjy@gmail.com>,  Rakie Kim <rakie.kim@sk.com>,  Byungchul Park
 <byungchul@sk.com>,  Gregory Price <gourry@gourry.net>,  Alistair Popple
 <apopple@nvidia.com>
Subject: Re: [PATCH RFC v2 02/18] mm: add pghint_t type and
 vma_alloc_folio_hints API
In-Reply-To: <290d615a001cf121dc0c604eb79451bcc7917baa.1776689093.git.mst@redhat.com>
	(Michael S. Tsirkin's message of "Mon, 20 Apr 2026 08:50:23 -0400")
References: <cover.1776689093.git.mst@redhat.com>
	<290d615a001cf121dc0c604eb79451bcc7917baa.1776689093.git.mst@redhat.com>
Date: Tue, 21 Apr 2026 08:58:59 +0800
Message-ID: <87pl3ti0x8.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Add pghint_t, a bitwise type for communicating page allocation hints
> between the allocator and callers.  Define PGHINT_ZEROED to indicate
> that the allocated page contents are known to be zero.
>
> Add _hints variants of the allocation functions that accept a
> pghint_t *hints output parameter:
>
>   vma_alloc_folio_hints()  -> folio_alloc_mpol_hints (internal)
>                            -> __alloc_frozen_pages_hints()
>
> The existing APIs are unchanged and continue to work without hints.
> For now, hints is always initialized to 0.  A subsequent patch will
> set PGHINT_ZEROED when the page was pre-zeroed by the host.

Why do we need this feature?  Is there any performance impact?  If so,
please provide some performance data.

[snip]

---
Best Regards,
Huang, Ying
