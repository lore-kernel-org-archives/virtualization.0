Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85D63BE650
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490227; cv=none; b=n6IeUYoOXVmOCDNmdmc8XKwlzaYpJ/1f/UFcT0/Kh1LMfPyTkAauwyHRjz9FVBMODlackdrOswDS//E5jeSqaMiVdCq066AqJnGtJ3/7Kyk2KvHyqVr2HHzvoyt4kPVIwfUQIABHSh7//R2tmPJ/ZfjB+937BO3IC4tFVCejf0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490227; c=relaxed/simple;
	bh=2qwfIvYMP4MobFXYMZ9IfggvCGLyS5KNS+zvJpAn5WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DKGrFisCjb1hT6cxJqvEdkIzDgu2kro/9nDA1CicON2IdTByNXXEKwxkzP9tsUU2nvUiuTh6aJ1HS/hav1JS7nbkIdA/eI7yi7X3gbFI9X0bfKvnjiedc+lyxj5cK046ubptQ2/Q3sfNGrDaXok8bRFZUDr7GL3G9Fa5J4cjx7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HZqg5Eg4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZqg5Eg4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aIsDJpt3h7ld/REGYicPHvXqVXWObeKhcjO9DGpcUJs=;
	b=HZqg5Eg4/tLEHdNhhGBl05uNKVD3mTL4npZUAfvTmpv8y03M0XcNpz+WLMhSI5sSH41miN
	2vYJ+q/tsIOhHEgafXk1OqKFuOayiQDgcagyErD5uj0dY/5k6jwkOsFOoy40V4Vxne6W6u
	PrW98LjErz+uK+/ksBibvXSU91aKdl0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-3RBn-xUCOeOtY5mgGCUe4A-1; Mon, 11 May 2026 05:03:44 -0400
X-MC-Unique: 3RBn-xUCOeOtY5mgGCUe4A-1
X-Mimecast-MFC-AGG-ID: 3RBn-xUCOeOtY5mgGCUe4A_1778490222
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48d1b294dfeso38016165e9.0
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490222; x=1779095022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIsDJpt3h7ld/REGYicPHvXqVXWObeKhcjO9DGpcUJs=;
        b=QriNWfXP49t6jS/6SotI8NFNn34pOZEXqsLYzydY+FNPjLf+1KsQnNt+J80KD6DOFy
         NmtCmgEpFOno5I+Sds/RKD1zRmWGjFLkqa3Kl8FGXM2I+PhF5tsW5fkz/Mbw4KL5YzGO
         EuCewjeZ0NBIUb2lsjZbSPojfOJsPa/UyYR/8rAENs2u84jdiZt5me/988dHUFBul7KB
         EqWWHuJ3EFZnDvjuqclPcZ0v94GUTnvSbwrooOe4QP0MnaZuN31QisroDa+FrERRsvTq
         dsTyl4h1bN4AXBB1zKQBff9BpBxp+AEHyJVEti9uCJWkOIM9fAeJcxIzAofnznxutapi
         c/xw==
X-Forwarded-Encrypted: i=1; AFNElJ+z14j/o4Q/v6Z5Hz2MaW59u+HX4PFIkaACdeXi7zWAVc8Jsaf9MOnuoR+weiZMIdhQNnTcjJzia3xS83p8Mg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6i71DBrHXmd8t+rsMkA6X2Wcn+ih41uvgVUAJ1FnNmaiSjS9X
	c0kaX04KTosLyhyfqxa9oYNiBtdeSU94XXBw7FGPsTKEfozHMm1Wh1UKN005ufn7lNoRce4mj14
	Vjj5cFw7YFJl0YqaN0aeUB57PFDgC9DBJTzHJKuG4g8rMhM3HtLIWeSdL6NsGG5wGoJFS
X-Gm-Gg: Acq92OHsCKSAhEnnAqN+iQagaklx9YyWP7DCmL6gTabzpiX6Cpj4SfiZeR4x7IlFhPc
	4D4r7Gv/HyM75s1phzaU5ZAk++imCQKH1uP7qVBwxOGdrjgNunHxnMkge1LwtMT40RpIjHQpmzA
	td9F6xs8lCpncoThQSIuj0VfnXH9ELztfvRZwOY/nKxxbddljnKupryy26R7nmupAqp04qzI6QP
	YWC2dMaZBMhxhCNkSq/NeA/osox1FGiSNe+G9jukMsVvomaAydK5kpFe478wd3dYHlaKZnQHp/U
	DX5+5GcZb8syOcfs+tTR8prgqdmJ8qN8KfnHIbLu3lzatze9srjU8njSEpmHjvqbmQCVgAeSbiU
	1y0oHtJgIHHrWPNuAdii/z4hRfNTHDY3fkRZSvGuv
X-Received: by 2002:a05:600c:6299:b0:489:1c32:210d with SMTP id 5b1f17b1804b1-48e706f120fmr146717325e9.15.1778490221539;
        Mon, 11 May 2026 02:03:41 -0700 (PDT)
X-Received: by 2002:a05:600c:6299:b0:489:1c32:210d with SMTP id 5b1f17b1804b1-48e706f120fmr146716725e9.15.1778490220928;
        Mon, 11 May 2026 02:03:40 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6fffb9bdsm160295555e9.1.2026.05.11.02.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:03:40 -0700 (PDT)
Date: Mon, 11 May 2026 05:03:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH resend v6 20/30] mm: page_alloc: clear PG_zeroed on buddy
 merge if not both zero
Message-ID: <a09c1848702368c3545b980c17101b5185ab774d.1778489843.git.mst@redhat.com>
References: <cover.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778489843.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ahd3Wuoc6AofPvrQtRg3kDDNol3_RUXzpW_0yT4U2OM_1778490222
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When two buddy pages merge in __free_one_page(), preserve
PG_zeroed on the merged page only if both buddies have the
flag set.  Otherwise clear it.

The merged page would inherit PG_zeroed, and a later __GFP_ZERO
allocation would skip zeroing stale data in the non-zero half.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_alloc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bd3b909cacdf..d70c9ba6b329 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -940,10 +940,14 @@ static inline void __free_one_page(struct page *page,
 	unsigned long buddy_pfn = 0;
 	unsigned long combined_pfn;
 	struct page *buddy;
+	bool buddy_zeroed;
+	bool page_zeroed;
 	bool to_tail;
 
 	VM_BUG_ON(!zone_is_initialized(zone));
-	VM_BUG_ON_PAGE(page->flags.f & PAGE_FLAGS_CHECK_AT_PREP, page);
+	/* PG_zeroed (aliased to PG_private) is valid on free-list pages */
+	VM_BUG_ON_PAGE(page->flags.f &
+		       (PAGE_FLAGS_CHECK_AT_PREP & ~__PG_ZEROED), page);
 
 	VM_BUG_ON(migratetype == -1);
 	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
@@ -978,6 +982,8 @@ static inline void __free_one_page(struct page *page,
 				goto done_merging;
 		}
 
+		buddy_zeroed = PageZeroed(buddy);
+
 		/*
 		 * Our buddy is free or it is CONFIG_DEBUG_PAGEALLOC guard page,
 		 * merge with it and move up one order.
@@ -996,10 +1002,17 @@ static inline void __free_one_page(struct page *page,
 			change_pageblock_range(buddy, order, migratetype);
 		}
 
+		page_zeroed = PageZeroed(page);
+		__ClearPageZeroed(page);
+		__ClearPageZeroed(buddy);
+
 		combined_pfn = buddy_pfn & pfn;
 		page = page + (combined_pfn - pfn);
 		pfn = combined_pfn;
 		order++;
+
+		if (page_zeroed && buddy_zeroed)
+			__SetPageZeroed(page);
 	}
 
 done_merging:
-- 
MST

