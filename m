Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0423D6479
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489708; cv=none; b=fJSuxgdGVEa+bQ9ugdy1VWFJ7FIBfEQSJkISx2rv5ECEV7kw5tg7yYY/NeMX5jAoY8BCHu278XA3KDNeP/neJKelk/mAR6T8DxT76zQQh4/2hcz2QJp9Cn5SJpIhVgjALiCYYWdSIjj87R3oK8Nc1W9aHx7yAdGNCNy0h7Ui5SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489708; c=relaxed/simple;
	bh=jg72mm9srvK1uE2wmvtubyBWSeDnP4AXuR+h0vGBnIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pe57e4R+6KD/qdlnYvlbmrsb3lVJ0ZnYFHSvJRX0xNrnO6UtePKJzx2VTeP2//O/PKrWlx7foHF1e26cBucAV84kxk+SkHX2EeK7FqWEYM5Q9/r3yg8jAbHQxYeDGbjUSg3wIDX2X4UQ10umvhQMkeNn7JGL8XgiKbfy0eqOReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZlLMF5D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZlLMF5D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778489705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=huIB05uLC0/aRI1yhZqtcpv3ok57gc+RgGl8EPTE8A0=;
	b=eZlLMF5D0QS65QdwP0wIt1xinzAYW4NaJgp+5JtNVeC2kVLWrwDCesYVJ12prr0xNSRyT/
	D2Knjg9Q48HLSYV4U6RM/Zuw04VBRHnUy82SMUKunPFWLzk7NPC9oV2XK96DL621ADWKi2
	WdEtd98aRXbaPIwjbW3qvq/klIzor1s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-Ipo6-r6KO4Koc9FmWuaUXQ-1; Mon, 11 May 2026 04:55:04 -0400
X-MC-Unique: Ipo6-r6KO4Koc9FmWuaUXQ-1
X-Mimecast-MFC-AGG-ID: Ipo6-r6KO4Koc9FmWuaUXQ_1778489703
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488c0120047so24122905e9.0
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 01:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489703; x=1779094503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huIB05uLC0/aRI1yhZqtcpv3ok57gc+RgGl8EPTE8A0=;
        b=I0gOCB4RmODQkUB8wf4OGvzGkIRrLoCej3ve8XpGOex8Fr/vDOWrNM0ppS+uka/ksG
         90o0R71t0as5UR+UK5rXC/uz+zhhmzX6exhmdOxDq2rFo5S/VFGypa+rc7eu0DS7iqj0
         iIlIM04XVALGhxRabGrPdR90HvNZZWw5u/Cldiw5BXvEy1TFn9OQG+8yrTgtonU0gVtr
         rXL3/OUtAFf/h76Jo1U6HhP/FKUhSXuLhA/VE0DOPQ0woAULvFXPC+skqic1IIP9LJTh
         POdTGop4XQLFfHLCsj8YXXvKxpbsqgKY5a8t9wptQHyi8EjC5DhVn88qUn2TKS1wKI1R
         mqMw==
X-Forwarded-Encrypted: i=1; AFNElJ+0B4OR31hYaZieqPUDuZla1IGZsIYu+g8zlkOrZok9f0Vhsrgy1teRCJI61uhd59W2QXwig7oAnRYwcMdw2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw66shde8a9cFqP4TVuay+6W1znRsnLxmcBw5xY4nEcozm+0BaZ
	kcQ2uy5qzucoOcvvdUZgwciFt+JsSFMSFQkNGEHFP7SnNodZpwnwGpEWmvGQLZwnzLQLXMxdRrZ
	t/Bsg3fg+M0FHE+qBt0K+vGdR91EqZbsUZ9M46QZI07mDrX9hW5+1SVl7gqF8hYenxxFM
X-Gm-Gg: Acq92OF0/w+XlZc5PEl1CVEZdqfN+vxd6vjeo0AQpHv8l83lUiMhI6CQTH6tbOPsv8P
	fHBHDl4ofzM4b1tK4rnjNZau8K8hMbe0MNUsgmusq0Mz4UFD3kOsmOBYgKwm+8OPKart+ml/qe0
	qtiZB+Bjtp5X0ETcGIQ8FMzcEp6UIQqbbz70fdRrmYOwAyLmjVjATC3TEgPoFQtBfymSESB8GFB
	iqHDJlxuQTKJWH9dm3uLre8DkPIItBKuOKJ1zHUfJXsguGwSIoXk+LUXfjoPGzHvZ/eLVPpwec1
	KdCbfBvfBdWIglzuROoX7iFoDMdyb5kgk27hIyJBzsa1SqxcaRyH/gEdNUbcVsK7wYfqitAI5/G
	KoWISehS6FrKTNLrG8IrgvPXTUBs/NG7zUwjkuQhPxrUgvB4e7Es=
X-Received: by 2002:a05:600c:8115:b0:48a:53ea:1408 with SMTP id 5b1f17b1804b1-48e51e1804amr355371295e9.8.1778489702684;
        Mon, 11 May 2026 01:55:02 -0700 (PDT)
X-Received: by 2002:a05:600c:8115:b0:48a:53ea:1408 with SMTP id 5b1f17b1804b1-48e51e1804amr355370355e9.8.1778489701969;
        Mon, 11 May 2026 01:55:01 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702ec599sm154989305e9.11.2026.05.11.01.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:55:01 -0700 (PDT)
Date: Mon, 11 May 2026 04:54:57 -0400
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
Subject: [PATCH v6 17/30] mm: page_alloc: propagate PageReported flag across
 buddy splits
Message-ID: <6d98a35c94fa44b550afa66923c620511e2826f0.1778488966.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: dANEmNrgjd47525KXXc5s9mk9nKIYfaByj-Wzhh2tss_1778489703
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a reported free page is split via expand() to satisfy a
smaller allocation, the sub-pages placed back on the free lists
lose the PageReported flag.  This means they will be unnecessarily
re-reported to the hypervisor in the next reporting cycle, wasting
work.

Propagate the PageReported flag to sub-pages during expand(),
both in page_del_and_expand() and try_to_claim_block(), so
that they are recognized as already-reported.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/page_alloc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 842f5080d728..76f39dd026ff 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1699,7 +1699,7 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
  * -- nyc
  */
 static inline unsigned int expand(struct zone *zone, struct page *page, int low,
-				  int high, int migratetype)
+				  int high, int migratetype, bool reported)
 {
 	unsigned int size = 1 << high;
 	unsigned int nr_added = 0;
@@ -1721,6 +1721,15 @@ static inline unsigned int expand(struct zone *zone, struct page *page, int low,
 		__add_to_free_list(&page[size], zone, high, migratetype, false);
 		set_buddy_order(&page[size], high);
 		nr_added += size;
+
+		/*
+		 * The parent page has been reported to the host.  The
+		 * sub-pages are part of the same reported block, so mark
+		 * them reported too.  This avoids re-reporting pages that
+		 * the host already knows about.
+		 */
+		if (reported)
+			__SetPageReported(&page[size]);
 	}
 
 	return nr_added;
@@ -1731,9 +1740,10 @@ static __always_inline void page_del_and_expand(struct zone *zone,
 						int high, int migratetype)
 {
 	int nr_pages = 1 << high;
+	bool was_reported = page_reported(page);
 
 	__del_page_from_free_list(page, zone, high, migratetype);
-	nr_pages -= expand(zone, page, low, high, migratetype);
+	nr_pages -= expand(zone, page, low, high, migratetype, was_reported);
 	account_freepages(zone, -nr_pages, migratetype);
 }
 
@@ -2300,10 +2310,12 @@ try_to_claim_block(struct zone *zone, struct page *page,
 	/* Take ownership for orders >= pageblock_order */
 	if (current_order >= pageblock_order) {
 		unsigned int nr_added;
+		bool was_reported = page_reported(page);
 
 		del_page_from_free_list(page, zone, current_order, block_type);
 		change_pageblock_range(page, current_order, start_type);
-		nr_added = expand(zone, page, order, current_order, start_type);
+		nr_added = expand(zone, page, order, current_order, start_type,
+				  was_reported);
 		account_freepages(zone, nr_added, start_type);
 		return page;
 	}
-- 
MST

