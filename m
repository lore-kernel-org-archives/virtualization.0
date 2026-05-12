Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42C4388E5A
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619960; cv=none; b=WRGyu1Wh6MWOEB72K5PMWTRNqBKflf0dS6cNAsqBtoxgsKMUxXwc43Aqf/wpOd9r5ZdX4aYe6niuVCkbWbd3mLszLdst1Xh5Yo+qmniC0WSZhPq06JLAJbs2GmhsC7QSWbZ7ygWqiT9onNszWkLztTAEIWT//3nD/T9yn2BsgTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619960; c=relaxed/simple;
	bh=qfAiB4Mi7HiE1t/8STINyzikxWNwc1bX9dNw7SeomIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iPb/U7mvplnbTVTJFlX9GJl2NIz6+vxdACT+91quVyX/JoDImapZ/vZsGLIZTpe1x6kMcY3CkCoO59OBGQa/yqfpfiY68yM3fbbvB5xPMKqAt8BYGzLNP4XIMzC/YKULT5YwS9jCOkvF2BY8drXJLwAqDittaoRzh+USrI9GeIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cDnNF9V4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cDnNF9V4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778619957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ScNqY6XGVTvavY3RuaxUGlH8VyMDuF0XI3V7nGekON0=;
	b=cDnNF9V4N0tIdUyBLzD6Fi+Jb6fKvdFieqeNmYhZMFD0Rp0kJnDRedL/1fsSAn5pzX+BMQ
	h/iFlPRrm86pBZ1mrNvlZgoSWpG0X5ncq6KoOscyTvlX3XV0cH4Jl1/GqQ7vAbN2Ia/PSK
	SlK7nugS5BOrqjtcpNlVrm9dZkT09fE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-DQGnlb22NACL3YdirtP0pg-1; Tue, 12 May 2026 17:05:56 -0400
X-MC-Unique: DQGnlb22NACL3YdirtP0pg-1
X-Mimecast-MFC-AGG-ID: DQGnlb22NACL3YdirtP0pg_1778619955
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48e6af7a9cdso31232485e9.3
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619955; x=1779224755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScNqY6XGVTvavY3RuaxUGlH8VyMDuF0XI3V7nGekON0=;
        b=It+ATOATR2M6qEv70vpwFQYYSUhasHHVf7lqgowjfFWgwt5ofRx2pWnPcmbPb12/hm
         K5bSN3me733jnRfV2Jk0IZ5PxRB3sjjHrfFFQIAf8OQaMZFGcdzsVoG4t0cMjHELYwxr
         0Hcrhl+qz3/U79/IKhBo0BZCkYo0KyhB+KNbRg8WGz1L3mAM3On1AajzUudz2ZguG3JX
         u8gK9jP7bMGquPtj6lvBcDaX6OktN+Xvgw4ksuknYAH2GtqGyb0WJxXKGcLyfTldiHGb
         KiMk53yg2c0N2ZgXpseDhctAa5lj/ZVhHlONPCSDkBrdsR4sinS07Og4BBC+BgrKuVCH
         kfMg==
X-Forwarded-Encrypted: i=1; AFNElJ+PF0UCAVD9xeYBS1tKK5sVeJlyzL/hKMMUpVRc9ohZTBmKpGvb+CspjqZ2drbxTojidmINahisGTHWwONhdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyC7SPKyLjwS7wXip/3lozPlTyIqta/NW8iX4dCwbQ9f22F9mqM
	r5ULz/idAPZvXQ1zJvXmSVS1wqjPFKb5zkXNsspI4sy/u7qjQ6GJb+YXG4bU+myTkRk24X3lLHT
	NLJRa6vYpA+z4zA0dugqdLBbmUmUn9eyHwUCLu6pNBa2W5LMQ+PIdwS3DKrgFQZQWtkLA
X-Gm-Gg: Acq92OGRlBw7BA5YcCLiUfIg2wJtUlJWCaQKuBbR8zMWLp6SYfPy0ZhasnVSCRDI6rD
	Khejt4oSibhzI9oziAJY0rudp9PIxSsbqNyZOUssy7/u8v4JZ0OEorUBAkrm3lxRkcZnY58HFsR
	S0PIx4dk66fAuY0oNCD3p5OsOxfS2n8LypI4PN7zuNFtf1mR1UETCwKneUOCbl57BSq7g2LZpeY
	Y5o7+vxOIx8qFHbE5nkwHGt7Gt3IgcH+B6zblDW3xw6hRaWmNylpjMX1UWXZL337e0U9Ak0ftEg
	GWEN3Drh0TlriUKyNyfN4nMKTjq+5OzZOT8SMis/2xrlnFJaLye0AYAMwWoPxYk0yGK1H6Sj/lw
	IzXoxJanzoSyeWkhqe1qWh/32IOpbkV6zyzdKphdQ
X-Received: by 2002:a05:600c:8b56:b0:48a:599a:3716 with SMTP id 5b1f17b1804b1-48fc9a45891mr5020005e9.23.1778619954883;
        Tue, 12 May 2026 14:05:54 -0700 (PDT)
X-Received: by 2002:a05:600c:8b56:b0:48a:599a:3716 with SMTP id 5b1f17b1804b1-48fc9a45891mr5019335e9.23.1778619954287;
        Tue, 12 May 2026 14:05:54 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f429fdfsm24854985e9.15.2026.05.12.14.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:05:53 -0700 (PDT)
Date: Tue, 12 May 2026 17:05:49 -0400
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
Subject: [PATCH v7 08/31] mm: page_alloc: move prep_compound_page before
 post_alloc_hook
Message-ID: <71a446816276ef01ce6dde104c4a44993c07e6e5.1778616612.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: YHVvGnUJbBHXPDhVEw48STgj4IbtqMv8AHsZADFBY_U_1778619955
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
index 8c673095c11f..db387dd6b813 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1874,11 +1874,11 @@ static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags
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

