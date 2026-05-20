Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830733BFE2F
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315695; cv=none; b=Axu+Gxl6Wv1QRzk1mbbS2Mne5FQAse4AG7EbELM/Lfwp2x6y7wGamEkB8NfUbLAn3TG8TGkU4uS4QEr3HWZu016ai/AE3QNTI0dHFykT5cyQh4FYtj9OYxQAcI7eCwzOpJq5J/jIvHSqdrVOxPXADJMODTeAo/nTeW09sVZzglE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315695; c=relaxed/simple;
	bh=W8/RgV8YlHoI/N38IUKKZXJPftBVftzLE1J25cjwbi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hwu1zNv7NhEb/TnmcdE4Qgyn4fXkrVcvMc6fSRUOBKJyyNZ5b4c3NI0H3gKHT2RlsMsRqwb1iBXMR9HTIY+LCj47kmekSR8lC/9A0WY+umhQjBKhzi5bQNKtlYh5KVCcLZYcafsRd5i2FhP5Q3aAWPKLt4OJ6S8zAxr71T51wfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HcyZHQ85; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcyZHQ85"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kjfty6vgLrS4T7uumYbV6HhVn6mEWZk8nuiVgC9VboM=;
	b=HcyZHQ85q8HuPRKRgqpT5h0WAMTECBNHTrQvGCMDi7MTcUriUrvEItKvhRa+T9CLsDsJnB
	+n8VJ2M5mMo92HJ5KnwIzctb7/VclEWBHE9CS90Fu2jekypgfLu0z9qSX26HgBjjPTMtss
	DRArTxmJIrDrUS0Y3iMA+fCknSfmWH0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-g4cWKAiRP-SaIChBNHN9_A-1; Wed, 20 May 2026 18:21:30 -0400
X-MC-Unique: g4cWKAiRP-SaIChBNHN9_A-1
X-Mimecast-MFC-AGG-ID: g4cWKAiRP-SaIChBNHN9_A_1779315689
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48fd8162ed7so39690035e9.2
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315689; x=1779920489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjfty6vgLrS4T7uumYbV6HhVn6mEWZk8nuiVgC9VboM=;
        b=DsLMyLl2J0CXKYLnn+78gt/w+ca3Qry+UmtzzAcGAACK94rJ06XXPfAIkunLEadJLJ
         B4lfF0vUEf9n471QgR60gSWSpfPqHXgj+VBDUYC8XP+TErr8XGL4oVBRkvdujLiP9zXJ
         Y+fZs1YdeIfq70NkPlEeV0p7Uf+AIfe/W7WYzoWjjPw7RwtLYbz6LxXie9VffuVg/YZF
         i4ZVp9pibhxHfq9alTbcS/f077hKWGK2AvHqyAZsUqWzNrepPB+O73psXMMK/GIhqDAM
         l/NaBmkVoX4VxMrbamswNZFBzt+XdFfRF9T5h8/ZxB8YfqM4VHtSmLjdLO3Kx8Bl7mP6
         2qmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8GZs+9ixUvjA6clpfAYh2z9xOu1DztXRj8VwKDxGcnljxmNT0YqOIvcfH/6kUni3gFNQ3GQUeI+TEKAeZsag==@lists.linux.dev
X-Gm-Message-State: AOJu0YyyZDYuCzxyVAKTzsZINX7eGU7MBoaMMS0E8flUac/muEyO0clh
	CgkGChtmXeq0JVv+Yn/q0QM+wHknW5J8b03VgK+dExCvK5VY5naIZsWzNbHJTHyMUmGEhjv0zyT
	l2sSEi4PKYlYZCFYNLbFAbxd/r8h36Gr7bbiyWI7nS+PhDqKCcfF2s/fWD/co0aNtGGFF
X-Gm-Gg: Acq92OGcPy7sQM6HUw3qo5kSo3gkz1obJ76AMoRqc7fcW736TsZpujZkBr7T2FVB3VG
	f2/4AfdtqPNAgRK/YIKaj0ZQIoh38nS8xcjOMJoND5ANqkO1D1/hud//YnD+kFgzMz7KldQgpKe
	+yj0QXJaCP7BrzZh8hIMausq2tLzfAdsIHnjyZNoLncrzjDRRkdoHLeK9CP9k/3RXkLSMPrmwum
	yHWPrcHkNMQ/RBd0/Rrp25yYPKVBdHjOURnhh1aEkSH2PQcVC0ooMYkpi9xRFJ3FCKxg6C855Fl
	f0FDk1/N+sFaQ8ve5Ra53korD26dd+VBFlq0XvwClKZx6Tf8suQUbPEUmqCUdT3LZPUb9EQp7Gv
	aDC1iq13dL4VO3ujAUQXC0oO9drmJjpoIiLqglkhL5cM=
X-Received: by 2002:a05:600c:5c8:b0:488:f453:b976 with SMTP id 5b1f17b1804b1-490360a9e24mr1509835e9.27.1779315688714;
        Wed, 20 May 2026 15:21:28 -0700 (PDT)
X-Received: by 2002:a05:600c:5c8:b0:488:f453:b976 with SMTP id 5b1f17b1804b1-490360a9e24mr1509455e9.27.1779315688284;
        Wed, 20 May 2026 15:21:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0f72sm61409614f8f.25.2026.05.20.15.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:21:27 -0700 (PDT)
Date: Wed, 20 May 2026 18:21:23 -0400
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
Subject: [PATCH v8 11/37] mm: page_alloc: move prep_compound_page before
 post_alloc_hook
Message-ID: <c4b01862c558c99970b2994ea8fad873fd2529cb.1779315441.git.mst@redhat.com>
References: <cover.1779315441.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1779315441.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YpxBy6YE3zMBIbkMeujUR8oDDTxNfqBDndH4gda6Vmo_1779315689
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Move prep_compound_page() before post_alloc_hook() in prep_new_page().

The next patch adds a folio_zero_user() call to post_alloc_hook(),
which uses folio_nr_pages() to determine how many pages to zero.
Without compound metadata set up first, folio_nr_pages() returns 1
for higher-order allocations, so only the first page would be zeroed.

All other operations in post_alloc_hook() (arch_alloc_page, KASAN,
debug, page owner, etc.) use raw page pointers with explicit order
counts and are unaffected by this reordering.

Also reorder compaction_alloc_noprof() for consistency. Compaction
currently passes USER_ADDR_NONE so folio_zero_user() is not called
there, but keeping the same ordering avoids a future tripping hazard.

Reviewed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/compaction.c | 4 ++--
 mm/page_alloc.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 72684fe81e83..4336e433c99b 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1849,10 +1849,10 @@ static struct folio *compaction_alloc_noprof(struct folio *src, unsigned long da
 		set_page_private(&freepage[size], start_order);
 	}
 	dst = (struct folio *)freepage;
-	post_alloc_hook(&dst->page, order, __GFP_MOVABLE, USER_ADDR_NONE);
-	set_page_refcounted(&dst->page);
 	if (order)
 		prep_compound_page(&dst->page, order);
+	post_alloc_hook(&dst->page, order, __GFP_MOVABLE, USER_ADDR_NONE);
+	set_page_refcounted(&dst->page);
 	cc->nr_freepages -= 1 << order;
 	cc->nr_migratepages -= 1 << order;
 	return page_rmappable_folio(&dst->page);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b725a3b59835..3108ac9061ce 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1877,11 +1877,11 @@ static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags
 							unsigned int alloc_flags,
 							unsigned long user_addr)
 {
-	post_alloc_hook(page, order, gfp_flags, user_addr);
-
 	if (order && (gfp_flags & __GFP_COMP))
 		prep_compound_page(page, order);
 
+	post_alloc_hook(page, order, gfp_flags, user_addr);
+
 	/*
 	 * page is set pfmemalloc when ALLOC_NO_WATERMARKS was necessary to
 	 * allocate the page. The expectation is that the caller is taking
-- 
MST

