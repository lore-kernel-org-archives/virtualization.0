Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB903CA48E
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620030; cv=none; b=dzaUCXBATXMXFsDl3yW7/iuBbmySXO4NL+6j/AP/9ulHL6pLXZbq6VedWTvieu3cOG6fm0RK6sebwsG4UhaTbmbRcnJNBzLrDBmWP+d0FZ3NYapm3jy4LrnP0an4QopG9y9yA8mHOu7VrxWuqYD1LFiwlak49QPaBPaCqhFBvYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620030; c=relaxed/simple;
	bh=qkFNOprhooUNjKQ1PSjbgi8DkKCpI8tpPK659v+JSEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=f8w9AzgyIRWrhdWQbdrs8mej252fD1ne8CBvwu2fhCpxkwU6F1ZZFcFqQ0EG/1IFabyCbbvreE5lpBaEoK5CLsbOUkwrO6Rb+h1ImNUVNgddZ7Vm4K5zJY6cfI/Rfk8EbWg6UUYRvo+6imougxNlcNGUhh8F3HhgOTBNYLNyaso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZ+Eg4Tw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZ+Eg4Tw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778620028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nFn1v/uAu4PP6s5g6sRwXKMfyXh1YJ87r2wzrnOTcOk=;
	b=aZ+Eg4TwJ/pME31dLRK1LGV3bldQHgLDA7rlwthNu7jFNJ4ItjO+PH82TzOt5WD2hsccCH
	ze8/gnJMZALD7HtDRFECAoGoKvjSs13zkJX4IBdtlhpzxRIkTaubSPhk9kREqzErM+usiL
	uudelBK5BT9ZaVnPCdAp5yBpNM4kR24=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-MH9xDNE0NbKIpvbkO-i32Q-1; Tue, 12 May 2026 17:07:06 -0400
X-MC-Unique: MH9xDNE0NbKIpvbkO-i32Q-1
X-Mimecast-MFC-AGG-ID: MH9xDNE0NbKIpvbkO-i32Q_1778620026
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48e5df7e6ecso37089085e9.1
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620025; x=1779224825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFn1v/uAu4PP6s5g6sRwXKMfyXh1YJ87r2wzrnOTcOk=;
        b=kLc0cSaw+pqr0jRMxRvBY+00I6Da2IVsmISe0zk/iB9zV51FItaA6O9k7h+i6Y4cZC
         Mz6zdiPbFkynVcXC4PJUz8qVrgqOtOcTURzVlNmcL48ycwRaiFtfX01GiZKh43JAE+DS
         Kv9znb32WmLWOssRMEb+8B6xjxuLuRw6n8OFJSC260+nskCYFrvwGtwVy5M+kgdzf9EN
         wkIpBsHm42pk4UCotYULzSSq1z3zOvFCq6cKTXt1vBj1R+kvGHWPQOjz3JDCG3c/rQ+H
         6MePkAl6db9nDOiyVfQaH3zj+BChFPL5sLe86sV4Yp5MOSzlNcFcy+h7qID1+u42j6Mb
         jE8g==
X-Forwarded-Encrypted: i=1; AFNElJ+pJBPU++P5Bhd3G//APHTCuEsBe21DpDoRe/R/2XEQoWrpcobZFuK0f2A7/qZfpydVdNowqXCCSwjUklLupQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyStlZ5jLDZBxr+XGeLPo/DFwtU0xf9yFwlcaM15wxof/0r8X/Y
	unSQ8CZJ43EnNkJ/1sV/W2Q4B3aex0zzzkjtNbp5crdHdscgrMSbZwjdhqZfmZm4x64+UmOufTm
	EegHas2XfdBv+1BKXVcazhtMpyhJdURLluAchs5zKHJmsWgbLtGuElzUnWqHuP/23GlXw
X-Gm-Gg: Acq92OHT3pAV0mTnz6y8ZPTFPWSwp/v3Ob1cQnIXPcWkklt43LoRBJT5VAbERAVqcVB
	i6u3T9letppPHlvWt58thFv4ooPXVCj/+wm3Hj4JYxnhIEZU1czlfxABzXvUAIDkA2dvu7e/Ki/
	qxJeszc2aqYkDTORffdXQqk62t0y8L4bw1uaCXZPWVvg2wQGYajkDPFo7dMG7fO+fTeMW9YXyS3
	X+bFgA8R+HVYOD0DEGqZJFh0z+72c9wZq17I0AI0LeZO/1eKEl+iCcXeVncUpCpT4EwwMUbbjuB
	wAsaew1tvqg7tbkrCgk6Nlzfrgqb0hmOgQGbU9RpQ4D1Kto6Vykai0+Ir9bgCw0o6CUmNuC2jyn
	JAgS8QTAG1Ts28q5slzbBl+BiLKCz7R5zotA7ZxlR
X-Received: by 2002:a05:600c:3b20:b0:487:2439:b7c8 with SMTP id 5b1f17b1804b1-48fc9a029d4mr6486165e9.1.1778620025331;
        Tue, 12 May 2026 14:07:05 -0700 (PDT)
X-Received: by 2002:a05:600c:3b20:b0:487:2439:b7c8 with SMTP id 5b1f17b1804b1-48fc9a029d4mr6485625e9.1.1778620024852;
        Tue, 12 May 2026 14:07:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f42a845sm24872145e9.20.2026.05.12.14.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:07:03 -0700 (PDT)
Date: Tue, 12 May 2026 17:06:59 -0400
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
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: [PATCH v7 21/31] mm: page_alloc: clear PG_zeroed on buddy merge if
 not both zero
Message-ID: <f6573c9680357fe749cb578a4ecb1bd70ff50e32.1778616612.git.mst@redhat.com>
References: <cover.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778616612.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HkbcRNRsEwxyrn98UV6_lc6vvkK5coKBeEVPEe9MqxA_1778620026
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When two buddy pages merge in __free_one_page(), preserve
PG_zeroed on the merged page only if both buddies have the
flag set.  Otherwise clear it.

The merged page would inherit PG_zeroed, and a later __GFP_ZERO
allocation would skip zeroing stale data in the non-zero half.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
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

