Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADE23A6410
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 22:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808936; cv=none; b=GOcxb9VfpWxP9Z+QucbzD0JB3sFUnBDzCd1lZEk8iMq3+cuW4OEUeJDWSzhJymWmUZ/NISm3LdRANlUmdDC05L5nKtNvmLzaM2fIE2bhfQDBkerfm9PifWNgr+JmJ8+Qmt7Ea6SXpCqaB6D73OKpK58ZqdDEpJDrnioqtrfH58M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808936; c=relaxed/simple;
	bh=qSEJ1Kijx5ZivGiuuv5dmsRR2ofsgHwqXpUDJzbMbi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OumqjoBepUj+EQx23b+DLGcFr8JIlp4+nGBa1vYXct8HK6hd+vTJSpqn+nKLO9G5DfdgwkzUgjbKiIK8uu+MJn3sy75iw6Yph8zwyR73YMB5cB3rgJP2wOW4hPCEsPTwz6wCOr62aJWU+zBpWld2RxLQC7LhxEj7NPxcrdKIo6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WGq7VUbs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGq7VUbs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776808933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B71z8WI6bGkbALDtbCGicFiZB6WFkZ9HcNzSfAqdU04=;
	b=WGq7VUbsDyQhZZb5x+ipSM+sRgM2bixYifM3Jaq60RQ+3MDEZ9pIKFdQEiE1tqO2cYlsBm
	zc7aiDPFdYw+HpgHV/UYXALP6S0/PCXDAO3uFNRpvhwq0epUtiPnb5lZM9W5r1wFRecjlN
	KKcbi6lffvOoOAFN2vUymFCRmsoRn4g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-rAVlQGN9Nc6mFMPyZID23Q-1; Tue, 21 Apr 2026 18:02:12 -0400
X-MC-Unique: rAVlQGN9Nc6mFMPyZID23Q-1
X-Mimecast-MFC-AGG-ID: rAVlQGN9Nc6mFMPyZID23Q_1776808931
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a5775d647so9448175e9.2
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776808931; x=1777413731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B71z8WI6bGkbALDtbCGicFiZB6WFkZ9HcNzSfAqdU04=;
        b=cK5VNB7bYLilsgZa8KPwflxKs8Z2xonFZydRulHfAto2WG3o5642HA/H1NPk8G80an
         zo1yeaTPNsmruFyDLOcV4exO8eax8RPKsiHT4VvzNHkiQi3KUNLDPIHXL5UxToWAbcCJ
         La7HdRAXqFMSYMeo6PBCh8OI5e5elkkZ5NUePziavfdzxc47Evx2GKCzXPZKWfLLFPR4
         V82DuBihzih4GyEo7XV4GVu9IBkgk2SbiEI+phGusiWapVD6Y6KvMM9bJNrLkF+2epr0
         ST00Zy1qyRjo9BMQW4hPsL3p6MIA8NTG5ar6oAMbyU6ifF6kG4+FR1SQvOuZl3m74NKO
         lEyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+fEBAhaLu7RNeL1r70qNK238HD3UBTl0JuvASMTo4DZq1rNjdQT2L4JgUaz4OchsvQlmwQqg+bDzPQL0Jp4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWsXOr/56mpeiRwVeY5dnP0VmV1yBOU3mewdyIjfFXruE+xB+A
	Elygqak75wfDcwojJ51DGaoHf9XDimTjalMrPu9HBN0TiuEHgGpr4NzRgVY4fYDO4M1vhMpl4lD
	lVDCK1XYMJKM+FU5vK7/YJnb3cnL2quMAUAUoPynastfBD/9Mj5eJjfODtMhMH1u/PwcH
X-Gm-Gg: AeBDieu3yfHylhOWSUnWJr8DVafAepoR93JQa9sf2u3SxMa/MwV2+F5Szrs2tY1Ryrd
	450bYu0O81lF/OZVlMACwXEXtJsPb5C3oTlyNw6kD58F3CbA+DWJGYUq1XDtdK6lpQnSFZrhu79
	UXAKGuaCgWBuKtRXrE/upf1OGqYgy+Sfd9Q+njo3pC+6QIxDpXdOY7AoaCpMtNCTdQP1j9xTa45
	umNXYwwYPS6QG9H59xvKbjrtszlNFoM1wCXzux1Phd+7npB+CzlmnDklaL+q9JKfjGK3mtJSG0B
	gP5Jc4PPxsUl16FVqce0EVr0wrxZ/6Uj3fHtdVSOATPRIQB6M4WWmo/j5OuSRMJ9h5he9tUNLOd
	NrpeFDmIyMLec0B16MVLTFx9lKHC7synicMW150AohzgSuRfuCIoEaw==
X-Received: by 2002:a05:600c:4ec6:b0:489:1f98:71e3 with SMTP id 5b1f17b1804b1-4891f987487mr132175415e9.28.1776808931364;
        Tue, 21 Apr 2026 15:02:11 -0700 (PDT)
X-Received: by 2002:a05:600c:4ec6:b0:489:1f98:71e3 with SMTP id 5b1f17b1804b1-4891f987487mr132175005e9.28.1776808930932;
        Tue, 21 Apr 2026 15:02:10 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d525sm38750206f8f.31.2026.04.21.15.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:02:10 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:02:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC v3 17/19] mm: page_alloc: clear PG_zeroed on buddy merge
 if not both zero
Message-ID: <6992d257f953733586275aa766add3195aa93770.1776808210.git.mst@redhat.com>
References: <cover.1776808209.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776808209.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rdGg-Rn3OUHgiV4o43AKxm3dzYJXhN2hngQH7lXvETc_1776808931
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When two buddy pages merge in __free_one_page(), preserve
PG_zeroed on the merged page only if both buddies have the
flag set.  Otherwise clear it.

Without this, a zeroed page (freed via free_frozen_pages_zeroed
from balloon deflate) could merge with a non-zero buddy.  The merged
page would inherit PG_zeroed, and a later __GFP_ZERO allocation
would skip zeroing stale data in the non-zero half.

The page reporting path is not affected: it sets PG_zeroed during
allocation (page_del_and_expand), not on free list pages.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_alloc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9311374bbd2d..122b49a6d435 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -991,6 +991,8 @@ static inline void __free_one_page(struct page *page,
 	unsigned long buddy_pfn = 0;
 	unsigned long combined_pfn;
 	struct page *buddy;
+	bool buddy_zeroed;
+	bool page_zeroed;
 	bool to_tail;
 
 	VM_BUG_ON(!zone_is_initialized(zone));
@@ -1029,6 +1031,8 @@ static inline void __free_one_page(struct page *page,
 				goto done_merging;
 		}
 
+		buddy_zeroed = PageZeroed(buddy);
+
 		/*
 		 * Our buddy is free or it is CONFIG_DEBUG_PAGEALLOC guard page,
 		 * merge with it and move up one order.
@@ -1047,10 +1051,17 @@ static inline void __free_one_page(struct page *page,
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

