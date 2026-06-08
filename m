Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE753B42F6
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907822; cv=none; b=ofwa8gZZUFQzhsRd8WpHO4fqRFlh+333QAGK8MANUNlSrjXWaUxMiKVRgnudM4wy9ZDBWFFglCAp49EpXp7Bl5gdHbf5CzsywHdZYg+1AK45mGf/nuIUIXh2yf4Qqw+8UsQKUBTxpZWB1mjDJw7i1xZrK8mv8gFMhem+qcfaI24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907822; c=relaxed/simple;
	bh=y+61YvUymd++YcmeYOOWPNpu5ycFdBgEhoiyVksZMFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QKaHUZOoIOd+m8+xX+xSv6zAD1iYTUuKTGMDbgnP9i31tjX+h1S1YzhPQMlMfKBO/J6TdZff3ul1xso++eJsBX/aWA3y12pkOgOrkeUbZ6/l/gKuzMl4LDAkvleYo6yU1etwPSFkk0d2RW0crOz8u0YaKRRh0AiHLSYR9uCBk2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a5s+vpeE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5s+vpeE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AR0svr1Wd/OcNae1i4toNU59Y7b0yC0WCO1bghbpkVI=;
	b=a5s+vpeEDPoNeOB6erw1oWxWfpq9ZAqCmExbi1LcwgnoS+SX1TOydMfNlwKquBJ7tCBoCc
	6Blp5OuGUpRNmXoSaNx396qOI8d90bjn0w0ZI22tC7P37iN7UqyOtHZUhJDkyPghz7LVka
	jJr1wuN1svJNc87uYQsdwfOoDD3uaE4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-Lt6VftS-Oy6m3e1Oq9RYWw-1; Mon, 08 Jun 2026 04:36:53 -0400
X-MC-Unique: Lt6VftS-Oy6m3e1Oq9RYWw-1
X-Mimecast-MFC-AGG-ID: Lt6VftS-Oy6m3e1Oq9RYWw_1780907812
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767b782so32507185e9.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907812; x=1781512612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AR0svr1Wd/OcNae1i4toNU59Y7b0yC0WCO1bghbpkVI=;
        b=HuUizC8bOJBxSu/VnqyMZ3wzp/xYLsejmidU45za1zjHWAMde6V7xeCQ1VywjyzfNC
         UKyaZZUiiixy1dbFpubQtXL4UDGAw7klXR9thUDXuJx6SP+U9mnUm4ju3uOa4y/DX021
         JZqc+yJolLHsuhPQgPmKrBSlQLwDd+i4sRi4KWnEGXKDlnWHYKlEpQWOOyIfwKVSSMEN
         bHnryJNFSemE+JxtyFiHRBj3YRXB2jvUivY2jj9Acpmsj1v5yOg7v6II1XpE/N0eJbeM
         Ss56mAh+sxnL4eFL0roIiRsUfaO8xMLaRSiZQDxyzKltQ7Fyrwje+gIKR8Tzow9j9oJg
         cQfg==
X-Forwarded-Encrypted: i=1; AFNElJ/5jHCbiCx+ZgMqly122WorprsTdc/NmzG3RcL+UwuOoxnLIuyK3cozthqliSJSDWDS2SGeH0PIBAcu8G5eCg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxu7zVBfB7aRWyTYBHbCisNAnWQWYDi3N+OAEXsNRvqOGQJN++D
	v/cMCQ4EvY1hw6a4O5HYXBjHq6mCBmuR8YFpfroPtj4o4gOEJrqT1UlgYanLmrGrZWA/OQxtxUV
	SnKS4HA76v0qAiGssa5xSLrlnHln9+erCjonehTmaf3VPpSfAey0IEpGA8p5iISVtjlxl
X-Gm-Gg: Acq92OH+HlyfWpE1lkjGDkcA/9nh2xpdrdh5bHAeN9FMM6b1oM+9NDrdEBym7o/5Tvh
	+5TsjDxtsRokfRRpoYV7D/voqRlNQxuC8Kiv51OOQH3Md61bF8qNGQ7VL20BBF3JteoyrDixCiN
	UOMjucMKTBNXS6AqYMLVhU3wUr/fONI9qmBzes/wVOMsChVOwkBjOI4v4D0VWoguAq/QB1P4Mmb
	AycEKdpKx2tyyYtlo3Z2/Eu4qOZsrGlOLUoO8Cxc25Vf1ecv0Z/jQY1uMdwcNTJTxAzLzSHA9A8
	9IROea6babAZZy/bCpRXLhuWMz01iXaOM+vZY03p26gmfOmdvMcYxFxqiXAs3CR3FjRPYemQZ23
	bB28Dv+DtdxpHHodNsUmihEg=
X-Received: by 2002:a05:600c:4ec7:b0:490:b8ee:d6a5 with SMTP id 5b1f17b1804b1-490c2589927mr241065525e9.6.1780907811914;
        Mon, 08 Jun 2026 01:36:51 -0700 (PDT)
X-Received: by 2002:a05:600c:4ec7:b0:490:b8ee:d6a5 with SMTP id 5b1f17b1804b1-490c2589927mr241064915e9.6.1780907811451;
        Mon, 08 Jun 2026 01:36:51 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39e024sm500006545e9.4.2026.06.08.01.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:36:51 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:36:38 -0400
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
Subject: [PATCH v10 12/37] mm: use folio_zero_user for user pages in
 post_alloc_hook
Message-ID: <f92f6f06e5804b4ea7f68b8664b7e69953b50f4e.1780906288.git.mst@redhat.com>
References: <cover.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780906288.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hbzg0uG8nUPrAlGXgQeWaWAK8Wy6wqQXQM_rEFJdxek_1780907812
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
 mm/page_alloc.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4676fd49819e..d4fbf1861a8a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1861,9 +1861,38 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 		for (i = 0; i != 1 << order; ++i)
 			page_kasan_tag_reset(page + i);
 	}
-	/* If memory is still not initialized, initialize it now. */
-	if (init)
-		kernel_init_pages(page, 1 << order);
+	/*
+	 * On architectures with cache aliasing, pages zeroed via the
+	 * kernel direct map (e.g. init_on_free) must be re-zeroed
+	 * through a user-congruent mapping.  Host-zeroed pages
+	 * (zeroed flag) don't need this: physical RAM is clean.
+	 */
+	if (!init && (gfp_flags & __GFP_ZERO) &&
+	    user_addr != USER_ADDR_NONE &&
+	    user_alloc_needs_zeroing())
+		init = true;
+	/*
+	 * If memory is still not initialized, initialize it now.
+	 * When __GFP_ZERO was explicitly requested and user_addr is set,
+	 * use folio_zero_user() which zeros near the faulting address
+	 * last, keeping those cachelines hot.  For init_on_alloc, use
+	 * kernel_init_pages() to avoid unnecessary cache flush overhead
+	 * on architectures with virtually-indexed caches.
+	 */
+	if (init) {
+		if ((gfp_flags & __GFP_ZERO) && user_addr != USER_ADDR_NONE) {
+			/*
+			 * folio_zero_user relies on folio_nr_pages which
+			 * requires __GFP_COMP for order > 0.  All user folio
+			 * allocations set __GFP_COMP via __folio_alloc.
+			 * user_addr != USER_ADDR_NONE implies sleepable
+			 * context (user page fault).
+			 */
+			VM_WARN_ON_ONCE(order && !(gfp_flags & __GFP_COMP));
+			folio_zero_user(page_folio(page), user_addr);
+		} else
+			kernel_init_pages(page, 1 << order);
+	}
 
 	set_page_owner(page, order, gfp_flags);
 	page_table_check_alloc(page, order);
-- 
MST

