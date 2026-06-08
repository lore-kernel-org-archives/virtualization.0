Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0969B3BADB5
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907954; cv=none; b=OyQRuX/+KxheXZcSAytpHTwkRnd/tviCEYd7P6OhF1QoUhE98kETkNdUuJYIPkAM6RYOvbydphw4zKdK4eT+Qn0iEU3RSVDXd4dJOn1nloSF5G5fjl7TzT5Byx23I6GKSOZWgT2EukMFwSFtoIZYEohz/WcThN+dqoyNq/uEThs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907954; c=relaxed/simple;
	bh=JqpRnHMOZCHNy3L9y89dcwb7zbUTjUHqd7YR7olPip0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VZHDF1dO5V11bOhxuPnoSsoOdDbPxTT8hKQbXifgtMEgHEj7+6c5e5zFreSCAmza4eIs2EpcM+ZlZlowr5HVyymCDbSbZ4hiDcZf9zoc0a2ddg9rvLOxd+fBTJ9/WGlmLU5PlzOWBmx9yjxzSNEiMJUq5toe9pOsfqSmZNAAsys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jp53yUkf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jp53yUkf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DMc8fDrj0D8JcjJ5dRd88tqBSMHmwk7bs26tvZRKcB8=;
	b=Jp53yUkfdIOaMrluPhVgqri5XU7AO0S0z1zKHLyv+Kih09QWeFn00JUMyS3lgI5NLJHR4D
	AydAzJvnaQtT+0aWVOd5wTypFKpjMvBAdyAOYDMZM526X0hxhgXJmlk/zWroZmRX/MvHGh
	aeLDvTw1a0QS8l2C/9LVMp57I+T0uho=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-nFB_xo0oNi2EsTrRG1H0Rw-1; Mon, 08 Jun 2026 04:39:03 -0400
X-MC-Unique: nFB_xo0oNi2EsTrRG1H0Rw-1
X-Mimecast-MFC-AGG-ID: nFB_xo0oNi2EsTrRG1H0Rw_1780907942
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso32922245e9.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907942; x=1781512742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMc8fDrj0D8JcjJ5dRd88tqBSMHmwk7bs26tvZRKcB8=;
        b=G4DI7QKQUouUDDnqWbZyKaJkA/opAMMPu8ofc4QBFx3hsydl0Qntq71pqpPxOXI8l+
         Wf+GI3AIzUv6WfdXc82N4Howa8jmzWBadShzUuvicjPQqLa8+aPD8Kx3kNyixI1LyEPQ
         St6ZtmNufghVAmGVARnbjiwvfNIyLPmwCyyGqKAeM1NM8A9lnfyNbRBb0sBgO3JamcHa
         tZ8HSae4/Tiz0kMKo/eHU9+yjy3bByLs6mXaDNa2dgFSzBgQGX4oAP+FOZNy93NZ+DCu
         NoYHdVxSiZXkx9T6/1vXXMFFZ8aDxi34yEkhbuxFes+pZWYApO0FNXL5S6eTQkMYpl4W
         0tQw==
X-Forwarded-Encrypted: i=1; AFNElJ8Tko9mOA+aQyDeLNluN14+TcEOP1WA/P4u9750zxd3uts2V9uT7pN9ijcU2ylT0TexobPlvvr6N0cy0RYZeg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCY/S/HIskUmb6Fexsi4BQo57LhfHffarUEiJIKZ0Yw7O1LAQM
	gHgoDqBWlYwG40zMuOCGyYeQSLtzesdAsVQGY75S8mgsFX+5rIRjCuvKpVY5PM3BqOHFOkFWUV6
	Nlru5eqcPKDhyk86pN+5EB0DqQUeIVVKTx2es41JWYDE8Ub70ykOq/x8D3JBXDXYFb/7u
X-Gm-Gg: Acq92OHuN6sJrvFIY41DuNEDJjPkGqNKxbIT0qpkNGI2ZHah6ZX9wo87DuxH1CJsnXt
	+brG9GNShIogtDo+OAQU9UPga9qUkiuZTzEPNgpOs0yo0OB6cyj942UF4baDqidce8emeu2AO/I
	Kk00qGBUzhjXfk1H6qH6YCUaekRRg2u5f6MS6BhLoasjl95bW8zhQHnaN1GGJ2ixpYwLQOiBhIZ
	X4afK0Oiv9ZSVm+n1/OJ5rVN31Z/8rqxyBnMJ49MznFBZBtDP0ZWkKPA4q9tGGXEf6j2efaYAvj
	hUYW7xKaC+gHDC8A6xtofdsy3D7vTkO2ogdNWYeS88pKPwrnBOtlshm0z3WvAC0hX3i1qEnOPK0
	dhr+/vt5gtSKZUY5M4nlYdx0=
X-Received: by 2002:a05:600c:5252:b0:490:b2a6:8c1d with SMTP id 5b1f17b1804b1-490c25adb2fmr254958245e9.10.1780907942353;
        Mon, 08 Jun 2026 01:39:02 -0700 (PDT)
X-Received: by 2002:a05:600c:5252:b0:490:b2a6:8c1d with SMTP id 5b1f17b1804b1-490c25adb2fmr254957625e9.10.1780907941897;
        Mon, 08 Jun 2026 01:39:01 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ed944sm52040479f8f.13.2026.06.08.01.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:39:01 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:38:54 -0400
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
Subject: [PATCH v10 24/37] mm: add put_page_zeroed and folio_put_zeroed
Message-ID: <fef7ca7bbf591865defef658b0792b58494aaed5.1780906288.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: irKVEg9IKKYN_uQtihV8ZEfamV-RHBBgOaTm6qSgfO4_1780907942
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add put_page_zeroed() / folio_put_zeroed() for callers that hold
a reference to a page known to be zeroed.

If this drops the last reference, the zeroed hint is
propagated to the buddy allocator.  If someone else still holds a
reference, the hint is simply lost - this is best-effort.

This is useful for balloon drivers during deflation: the host
has already zeroed the pages, and the balloon is typically the
sole owner.  But if the page happens to be shared, silently
dropping the hint is safe and avoids the need for callers to
check the refcount.

Note: put_page_zeroed uses folio_put_testzero() which only
detects sole ownership at the instant of the atomic decrement.
A concurrent reference holder (e.g. migration) means the hint
is silently lost. This is by design: the zeroed hint is a
performance optimization, not a correctness requirement.
Losing it just means the next allocation re-zeroes the page.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/mm.h | 13 +++++++++++++
 mm/swap.c          | 20 ++++++++++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 06bbe9eba636..79b3a8cb9a3b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1913,6 +1913,7 @@ static inline struct folio *virt_to_folio(const void *x)
 }
 
 void __folio_put(struct folio *folio);
+void __folio_put_zeroed(struct folio *folio);
 
 void split_page(struct page *page, unsigned int order);
 void folio_copy(struct folio *dst, struct folio *src);
@@ -2090,6 +2091,18 @@ static inline void folio_put(struct folio *folio)
 		__folio_put(folio);
 }
 
+/* Caller must be sole owner to guarantee page is still zero */
+static inline void folio_put_zeroed(struct folio *folio)
+{
+	if (folio_put_testzero(folio))
+		__folio_put_zeroed(folio);
+}
+
+static inline void put_page_zeroed(struct page *page)
+{
+	folio_put_zeroed(page_folio(page));
+}
+
 /**
  * folio_put_refs - Reduce the reference count on a folio.
  * @folio: The folio.
diff --git a/mm/swap.c b/mm/swap.c
index 5cc44f0de987..ecec780172ad 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -94,13 +94,15 @@ static void page_cache_release(struct folio *folio)
 		lruvec_unlock_irqrestore(lruvec, flags);
 }
 
-void __folio_put(struct folio *folio)
+static void ___folio_put(struct folio *folio, bool zeroed)
 {
+	/* zeroed hint ignored for now, no current user */
 	if (unlikely(folio_is_zone_device(folio))) {
 		free_zone_device_folio(folio);
 		return;
 	}
 
+	/* zeroed hint ignored for now, no current user */
 	if (folio_test_hugetlb(folio)) {
 		free_huge_folio(folio);
 		return;
@@ -109,10 +111,24 @@ void __folio_put(struct folio *folio)
 	page_cache_release(folio);
 	folio_unqueue_deferred_split(folio);
 	mem_cgroup_uncharge(folio);
-	free_frozen_pages(&folio->page, folio_order(folio));
+	if (zeroed)
+		free_frozen_pages_zeroed(&folio->page, folio_order(folio));
+	else
+		free_frozen_pages(&folio->page, folio_order(folio));
+}
+
+void __folio_put(struct folio *folio)
+{
+	___folio_put(folio, false);
 }
 EXPORT_SYMBOL(__folio_put);
 
+void __folio_put_zeroed(struct folio *folio)
+{
+	___folio_put(folio, true);
+}
+EXPORT_SYMBOL(__folio_put_zeroed);
+
 typedef void (*move_fn_t)(struct lruvec *lruvec, struct folio *folio);
 
 static void lru_add(struct lruvec *lruvec, struct folio *folio)
-- 
MST

