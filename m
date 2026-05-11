Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063E93BF660
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489604; cv=none; b=U9uXKB1OMd/B3woswgpzqtRFEaLTTG5bFppVeBKDY5r3jfECar3G5XEkxyfOBvI1U1gif306lJMRsbPuM/XRzsLB9wdm0Cu0bxgLTBC7YhBOzs3fGU55HL/Ndw/sTN6JbuVMdhEewsZjs84mDJ84fZ+7G0wnsMKs30F6Tw4DRZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489604; c=relaxed/simple;
	bh=B3Elvsk2QbFB4j/MM54kU4HNtRj52gz2EfVB/ero4mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gCoqUyO044HUOGsbcsM0Zb+tVABPiZ+YCCVWUAO2atZvu2sdZfjTwBpZwupX36zpoa7R5oI2BFOAZFjjAzvBb0+fZTGzevbLLQQ1THYmjvIWaNmSxdWXZiUY3UnW516AVQS5YR97ld6GK/HIyAvc4nS7rB5LBB9hx9YHsdcPgbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aTaJV9ZW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTaJV9ZW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778489602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zuBj5G8Fe8DfsQghniXtZy4OYrf8Ud9rSYDvYLkW/0M=;
	b=aTaJV9ZWBT8HZtVPOeHjb85AA5Q9FnAW/dPlqMxlaFPO960Q4mKPm0gTCYXojCYu31qJPR
	JR1D0vFqIiyVjvCIVRT7g7Wr3o6B1jcp5uu2WQ8tVXmHYCha0gHLRB1Soihqpqem7LVihv
	KSwRDf0BZWNqticdLe86VJXjkJwve5I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204--SiGKb1KNwSUYocua44zHw-1; Mon, 11 May 2026 04:53:20 -0400
X-MC-Unique: -SiGKb1KNwSUYocua44zHw-1
X-Mimecast-MFC-AGG-ID: -SiGKb1KNwSUYocua44zHw_1778489599
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48a5952c635so46796965e9.2
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 01:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489599; x=1779094399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuBj5G8Fe8DfsQghniXtZy4OYrf8Ud9rSYDvYLkW/0M=;
        b=WpJNUMWrdEl6bC3Sv/cj9S9BhqpsPW5TxI9HKYdA/30fvlBzlxbk+UTg0yLj9dLbSO
         8cPYqRvWvaMB8Zw6+3+/ybasaWawqb1a+ifIlmWHGxBvG7qWJSoOrNE1Peb4NmJXQaEe
         +OJIhwfFWw/KIaurk09VvL/rR7kUjnFCndETqE9ePs8jkY/451gN+r2ymAZX9kzRFjTm
         x/fbuEmJwxBwwAYViaxPIN3lG2mITNWlmojlD1uR2k9n6WgcFV4L9KADEbS3cae0CteK
         GOfPspKMskOcFIJAzfwwjAMPp7lm2JrB7fI1JqgsuM74UFShtWdQ+N2K6i8sh4KYZSqr
         Th2g==
X-Forwarded-Encrypted: i=1; AFNElJ9bpyLKq6KzK+2Tg+DbpV5Lx0SkvXg3CloVf0X3WYK/3P59OV1Ho/MTktM3Ju7mBPbxV2CNdGdOgiS1r8jL0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqIxuHYx24Fe/Ap/NUj8Z6FvCPOHMvUxNm2MADH0Gws4Ejz+yA
	HDfNqL2D3egIh9wu4sSGkKZA50oCGbol+wKgWBE6agqMUdx9AhVVuiXHESMB5ojXuHUqMZ+XcgC
	yyw5V0TzyCt/+v0typEbywFXLiOJgUCi2RfaLbyqCrmE6y8d+y0NoTbPuiQTq/l0MgYf2
X-Gm-Gg: Acq92OGubbLdEQCHJkr+F9vt6gZ2HUjnudCMRuyvpWkCMCPsrypkF9ehqrNjYigYCjY
	Ctp0zyzj8DgR8afZVkuIhDCmPm1vMpFpXSt271RElGwCbV1WEd+2IlokKshp/frLeR2uxwSOxJn
	PmmK+ZUUwzpf8a6wPF9Az8WIM9Tp4YH0LMC7spNg5of+86lil59LMth2PeWDOLQKLklPHDVATUP
	eZFcweVq5atv1iKNYhJeKWN5YlDEj56xKeRqyaDYHgYSVfXip2XzLyA1BVdNIl/yFx5qI4B4+w8
	4ufIXXyDgrXfDPieayN70K1djcO6Q5mgcZ8jE7j315fodjG4GQ22JSq5l4gxeZmGgZZ0kyi659f
	Aswxn+rXpyxaT1UF7sZJcS0cCWqVeE9iYrfHrknPJLBWSNuuUGvw=
X-Received: by 2002:a05:600c:46d2:b0:485:364e:9328 with SMTP id 5b1f17b1804b1-48e51f32aebmr334680315e9.16.1778489599032;
        Mon, 11 May 2026 01:53:19 -0700 (PDT)
X-Received: by 2002:a05:600c:46d2:b0:485:364e:9328 with SMTP id 5b1f17b1804b1-48e51f32aebmr334679535e9.16.1778489598330;
        Mon, 11 May 2026 01:53:18 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702e5516sm263733725e9.7.2026.05.11.01.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:53:17 -0700 (PDT)
Date: Mon, 11 May 2026 04:53:13 -0400
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
Subject: [PATCH v6 06/30] mm: use folio_zero_user for user pages in
 post_alloc_hook
Message-ID: <87e7ec6a9722ebe27a837a29781547d0d210147f.1778488966.git.mst@redhat.com>
References: <cover.1778488966.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778488966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8DIqIeJplDRc-_MdSyJiW4Yc3kQ-D4-HHEYt968EFzs_1778489599
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When post_alloc_hook() needs to zero a page for an explicit
__GFP_ZERO allocation for a user page (user_addr is set), use folio_zero_user()
instead of kernel_init_pages().  This zeros near the faulting
address last, keeping those cachelines hot for the impending
user access.

folio_zero_user() is only used for explicit __GFP_ZERO, not for
init_on_alloc.  On architectures with virtually-indexed caches
(e.g., ARM), clear_user_highpage() performs per-line cache
operations; using it for init_on_alloc would add overhead that
kernel_init_pages() avoids (the page fault path flushes the
cache at PTE installation time regardless).

No functional change yet: current callers do not pass __GFP_ZERO
for user pages (they zero at the callsite instead).  Subsequent
patches will convert them.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/page_alloc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f76d5271b5c6..842f5080d728 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1851,9 +1851,20 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 		for (i = 0; i != 1 << order; ++i)
 			page_kasan_tag_reset(page + i);
 	}
-	/* If memory is still not initialized, initialize it now. */
-	if (init)
-		kernel_init_pages(page, 1 << order);
+	/*
+	 * If memory is still not initialized, initialize it now.
+	 * When __GFP_ZERO was explicitly requested and user_addr is set,
+	 * use folio_zero_user() which zeros near the faulting address
+	 * last, keeping those cachelines hot.  For init_on_alloc, use
+	 * kernel_init_pages() to avoid unnecessary cache flush overhead
+	 * on architectures with virtually-indexed caches.
+	 */
+	if (init) {
+		if ((gfp_flags & __GFP_ZERO) && user_addr != USER_ADDR_NONE)
+			folio_zero_user(page_folio(page), user_addr);
+		else
+			kernel_init_pages(page, 1 << order);
+	}
 
 	set_page_owner(page, order, gfp_flags);
 	page_table_check_alloc(page, order);
-- 
MST

