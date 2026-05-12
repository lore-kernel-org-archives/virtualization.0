Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BE6388E5A
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619927; cv=none; b=XQ5JOPpRbSiMqglcasxdVCSZ4gL9b5AO+9Dc8bT4MBDgDHN8mbFQvryPI4QsnNiDKa5djvn8nGJJKaSrmTVnBwget7/RcSNIIABmebTuHhBFdNzxFVaBXDFAme+22Yi9Yf6a9kNceeEJnCYu4kVfweByBxSjHxMjRn30tr16UZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619927; c=relaxed/simple;
	bh=bGzF3O3suJfDsEpMco/qz1u2W2qF7rZPHMyZKhViaaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jSvQQNX6AFu2riT8E9YsxHuXbw6njK8iB2xYyQYFE2PBIaKR4leTl6MM7OyU0BieYq/xaIJSqE1FveBGgOcnuxbiPA46Bevys6nmOFHqpa7esF7FiEu7JraizsWohkHZOCBmT3cVoeEVca7qsB5qECzg80eKGR+dsm4SOwBZurY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DCoN7lEJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCoN7lEJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778619925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rtq/ad55zrZyrod+V9Nt+5t6fAHZwxPdckwVickks5c=;
	b=DCoN7lEJAxHm1XPRgKsZvaV/IvnFp2G+Pw2HbiPMUQVZ1LSdsjREa1xoDbiCMKkZr538rQ
	rN8AQPAclCwHdHsAkY66O/2vgVdbJvHLwBNJOb35LcCfEc56UyDcZ6E8ls3ZwWOOuvbUC5
	Onl9MHTkSV3eD8Uoa2osJPvANr86aFQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-Gc6IU6aHN2GngiY2mcf43w-1; Tue, 12 May 2026 17:05:22 -0400
X-MC-Unique: Gc6IU6aHN2GngiY2mcf43w-1
X-Mimecast-MFC-AGG-ID: Gc6IU6aHN2GngiY2mcf43w_1778619921
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48e7572b739so19890015e9.3
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619921; x=1779224721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rtq/ad55zrZyrod+V9Nt+5t6fAHZwxPdckwVickks5c=;
        b=HwVPY02YefIHLUm8JQtfohWXcqNPP5OlD4xwow8n9X0hTGJNA/ShgH5Xzsw1V0FULm
         9vp93FtAI7Zcvk9G7dVAHxF70WS7BZDmvA+798PV+yn98w9DCbToHG3+L0MDQS2+xCoW
         JsjTrbzc89DsjtcKdnZIvGl6+bbltwuQ0iQE2U4MqIAnHbq7ZcXoyoAZN0c2bRdzCSG/
         pRxiPsGyBKj4scYV4Da6llirQPjtNG0YugMF6aqVd22OBdX1B7OcJ/CnmiKx9DAVt/7F
         YQbLK2ufH8lIJZ51r93SiD0kbiMhYnYRtwAa1s9SHftwNGmqcP/0+4RDl8hfpUyCMuCF
         o/mg==
X-Forwarded-Encrypted: i=1; AFNElJ99Pc1s0e5QA4WhlR3bT6kFsEEFXoaqjPXdeNvh3FeBmxS0LTfg7hPVdA+C3wWp1+BKLzWXQxVPTJfYFF1DeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBZ2ZRjopASF1XerxMgfoX895Uj9KKdXidlTU3yfNo2agtilb2
	GqnxiBmavVrMCIruTUGdv5cmPSwqybUdHJ8Wzr5UOFS2O06aIkvinpkws9GNV6KBy+4mGRrXZKM
	wD9eZlLu4I8FfuhRVKlzfwbUTrU1TAmDHBGLQBvdidtBY0CO0Wy0poFQBzWGETwweKHsI
X-Gm-Gg: Acq92OFqzhypIJL95wjxsY12JD4jW3jKd2TxS75jG/afarLiWGQkEZPPvXpSLCvB44V
	8PhMsfyhV1v7A1NCNz27QfzWs2wqfDbTXBaFRC7hd3/VNmrXXbZibf7cvKJ7CjK/ITwRMqLoWeR
	0lCaBd0W9Adsym15maNoTxfi4PNlLxMA0jpdtYp3a8Cp1JiL/rHjyl78lUZpH8IDDVp71rni9AG
	DkMmNGeUZZNU6YNaIcN0jdcYTWwIYhoEzlqW8PsoNizGh2Z1vfaj7Lhsvfo23zpsN4a24XwXrIx
	mpOfd4ZfLHbQHvSqkIPAfBmXn0H63OGKcacDDTiugx/qY5/ehNYxKKf6u+ojt6re1rYpFKSkY/s
	XpzJ/Z9qnWeSkz9SjcGqz5MI2iOt7LD9Aqzie9zQc
X-Received: by 2002:a05:600c:848c:b0:489:e696:8362 with SMTP id 5b1f17b1804b1-48fc9a30a6amr5860735e9.13.1778619921389;
        Tue, 12 May 2026 14:05:21 -0700 (PDT)
X-Received: by 2002:a05:600c:848c:b0:489:e696:8362 with SMTP id 5b1f17b1804b1-48fc9a30a6amr5860115e9.13.1778619920806;
        Tue, 12 May 2026 14:05:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d27667sm18044215e9.7.2026.05.12.14.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:05:20 -0700 (PDT)
Date: Tue, 12 May 2026 17:05:16 -0400
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
Subject: [PATCH v7 02/31] mm: page_alloc: propagate PageReported flag across
 buddy splits
Message-ID: <feab82b370b3e66b58b9cfbc1efaf26fe6061d2f.1778616612.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: xj1luaYQyRgQzQacKtvx-U3Wzgec69Y5acU4vhQyIGo_1778619921
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a reported free page is split via expand() to satisfy a
smaller allocation, the sub-pages placed back on the free lists
lose the PageReported flag.  This means they will be unnecessarily
re-reported to the hypervisor in the next reporting cycle, wasting
work.

While I was unable to quantify the performance difference, it is
an obvious waste, even if small.

Propagate the PageReported flag to sub-pages during expand(),
both in page_del_and_expand() and try_to_claim_block(), so
that they are recognized as already-reported.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/page_alloc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 227d58dc3de6..e40fd39acbd0 100644
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
 
@@ -2288,10 +2298,12 @@ try_to_claim_block(struct zone *zone, struct page *page,
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

