Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DDC3F888D
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068183; cv=none; b=H3IjH887j0f+0c0ZEf7mKzhJ99i0EzAm2V0OO0ttC/Kqv0G8xAKlzOYvPjaoFiV8l4mbGuWJm80kMJFSFS6QdtYa0TO0xOZrItVWxjNZfBkmzLCq8xTBX/BdE1G3R1j4IrdykEZrw2pWsoNrR71PtnkJXZWMyScjzjTV1307jNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068183; c=relaxed/simple;
	bh=nrMNVIUtRT6KxUfPFXjAD5jr466RgmTT9RZMroXpfzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IDJz21WjhGqMSueztI49vppjUyh8K0C95KYvscr/NYXc6b7e0cVqJ1O+sOjv0NZ0m2JnQOvtwzUyZ81/Fb2Om/9EVBjdC5jmSOFTJRkxnMNUbqemMCjVXm17nzbh1xXEG3aqjaPWDPsz3rCI0nN6RK5nc0M6j++j33+v8KlQSYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g0VISnFq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0VISnFq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=phYVyxy4NXZDWgDwVjZEeX0+DVaGt3sk04puvAHm6ak=;
	b=g0VISnFq54Kkft4xfuZLosv+akj/F8h1a5848NldffwZnpiusF3CMwL6UI4KEANG9BZjdt
	41xVdANJJsTdwh3wYkXT/q9++yg5v43g+Umno09DiwdSxsNfci5FViF3ozEeprwPtAnk5u
	B7aQI41ciQ6I64LE1lqcjeR8McdzHXo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-ePL5tL1QO9OiMZF_b20CMg-1; Fri, 29 May 2026 11:23:00 -0400
X-MC-Unique: ePL5tL1QO9OiMZF_b20CMg-1
X-Mimecast-MFC-AGG-ID: ePL5tL1QO9OiMZF_b20CMg_1780068179
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4909e29e78fso5207965e9.3
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068179; x=1780672979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phYVyxy4NXZDWgDwVjZEeX0+DVaGt3sk04puvAHm6ak=;
        b=cMKlzooPuuxsyZiTp4p6YmuJx2jrhnpUOsNs3C7eugCbtzZncQJuMYq5WNIC91KM2e
         CIucsu1f6uMLjqbA7Ksk7d2+zyS379xV21Zc83kZh0BNUTt4rMhPgihmbhBlBxzLZeW1
         KFBKikEmiXGvtciIXbUSqf4ko52NqQDJRkr0xP947eTjgWWdBjZHK+DI92JXe8sxLiAt
         kuqUeRxBNSQLilqKY1h9rqtFvSsej27DHwnNGR75WQhWo8jJA70BQWrFlewLf0AoZ/yX
         yvgpyOZgXWt2BMVX4xq6NINHt9FwdpAIvSsa9hwq1zAT1Mip3C0NdX3r18etLR8qTSp+
         +lhg==
X-Forwarded-Encrypted: i=1; AFNElJ9IvFY9T5lIMcrL3hkXpHgQWZV7wTiHW+4J6srTa39wHblokdfW7Fy8FcKzH8+5okjyYEDv5IbpKTHL99Wp+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yys5z+VBaZbZeuwXxXddz2VPOdxUUphUVnu4CX39H/gA4IM+FUD
	P8+Phhzi/iT4mTOXj0LchxyYubJMr5y8h0OacoihR1/aY/BzHKuebK7ZcuREAa+FIkt440Pv0KR
	RQPLJtaeJtR0rqjAGOZ9LQmgfIuzINGmxt6+fF5OGGGO5vNVh8xO1bVk89gv5q32zN7dI
X-Gm-Gg: Acq92OHt9XkCSPUXlfGiKzMbkr52XG0jPVAR9aOxaZLMfT2AtwZ0wxN3f9F5qQu6aof
	W/R9lsB/ADouVg3oge3TnHDG+/3VweQcLFQ3GFdtpDAmKGrApzF4iqbf/WBqSRw+Ks73reU/ok7
	8nSw/XbdSBuzpyoOvBWqphtNocu4uu4My1my8SR3RyDG0a7uWSRbTeL7n6A8tAVXZK6b1sdwuSj
	Z+6oko1iKCVuKz9p4W/0P3uc59mDpI/j9cz7TLau6nd+nWG/QsdhS+Ajw9MUp9o6Fnucgy3QhI1
	JEVi2eyk2PKZW/nxMKsvpNPQdo+/ejCNHeNDwUVwaUHhUG8DEPe3QtFItI857EbpVqIaKem4/xc
	tsF0cnIlLQbqCNuijuZCekE1WL+Tk59CPNrblfK/EBWpxab373C2tBQ==
X-Received: by 2002:a05:600c:4686:b0:489:1b10:d896 with SMTP id 5b1f17b1804b1-490a28d3f2emr3053335e9.0.1780068178575;
        Fri, 29 May 2026 08:22:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4686:b0:489:1b10:d896 with SMTP id 5b1f17b1804b1-490a28d3f2emr3052135e9.0.1780068177967;
        Fri, 29 May 2026 08:22:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0498e0sm23826835e9.0.2026.05.29.08.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:22:57 -0700 (PDT)
Date: Fri, 29 May 2026 11:22:52 -0400
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
Subject: [PATCH v9 10/37] mm: add folio_zero_user stub for configs without
 THP/HUGETLBFS
Message-ID: <806b21ab94d4e92e78a092ac6dfbc2564fc6d0ca.1780067977.git.mst@redhat.com>
References: <cover.1780067977.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780067977.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nTogA9QiWPK9Jr8UMoaKV4NTZhPkIyjj_j8UMBu40Gc_1780068179
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

folio_zero_user() is defined in mm/memory.c under
CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS.  A subsequent patch
will call it from post_alloc_hook() for all user page zeroing, so
configs without THP or HUGETLBFS will need a stub.

Add a stub that uses clear_user_highpages() with aligned
addr_hint.

Without THP/HUGETLBFS, only order-0 user pages are allocated, so
the locality optimization in the real folio_zero_user() (zero near
the faulting address last) is not needed.
This also matches what vma_alloc_zeroed_movable_folio currently does.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 include/linux/mm.h | 2 ++
 mm/memory.c        | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index af23453e9dbd..d1e768dcda13 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5070,6 +5070,8 @@ long copy_folio_from_user(struct folio *dst_folio,
 			   const void __user *usr_src,
 			   bool allow_pagefault);
 
+#else /* !CONFIG_TRANSPARENT_HUGEPAGE && !CONFIG_HUGETLBFS */
+void folio_zero_user(struct folio *folio, unsigned long addr_hint);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
 
 #if MAX_NUMNODES > 1
diff --git a/mm/memory.c b/mm/memory.c
index ea6568571131..02d3e53fc91b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7546,6 +7546,15 @@ long copy_folio_from_user(struct folio *dst_folio,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
 
+#if !defined(CONFIG_TRANSPARENT_HUGEPAGE) && !defined(CONFIG_HUGETLBFS)
+void folio_zero_user(struct folio *folio, unsigned long addr_hint)
+{
+	unsigned long base = ALIGN_DOWN(addr_hint, folio_size(folio));
+
+	clear_user_highpages(&folio->page, base, folio_nr_pages(folio));
+}
+#endif
+
 #if defined(CONFIG_SPLIT_PTE_PTLOCKS) && ALLOC_SPLIT_PTLOCKS
 
 static struct kmem_cache *page_ptl_cachep;
-- 
MST

