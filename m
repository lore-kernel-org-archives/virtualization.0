Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68CD3A4F2D
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689475; cv=none; b=gGUOSaKF6yO+fYR0z2AT4AaWQp93taEHi0es3ixOWjpGZm45Lc6lg0SZ0mUDJneQZmMfTEGRS13h0EEneGYMqiUUnSSPI1F2BITRhtiBnj1E5rAyk57WIgqpOiXYru2TjGWsVWYwZXeZcs/1WCKnnrblrly55oG8WT95bDWwvG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689475; c=relaxed/simple;
	bh=b0uEgPLjU9RqUL8qCkAp6CionPNtPZx5K8nQiG2MheA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gkvnnazT4B/b27osLp3mbmRu0+X1rozf92FDhpQ/dyZFW3/DkW2tBsga8sbMF0djcHkTpJ5c9kKaFIxRp234cLdFPq4YXKBhokiuHnGl7f+sFrG44bmHn+DMndZiJhnSLVbg6EN4FvaeTc7Mmh77K33o5LHGrip0XpT7rnZMWJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HwxB/CZ+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwxB/CZ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776689473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bi57iZ++pwWctggr2TvdW1CtXtPNYbcTAE7BCEX37cw=;
	b=HwxB/CZ+vBrlhpgVxDKjQQkuhKh6kuxAVPWzD7rMpf9wfxUqxaxYPRiUmmBwjFfIpXPiMW
	IRF8n15CL7GEzyUkb/2kRycvgW/Yh3aYSmmwDY4c5RjTqMumijHtNYZE1dGQvaQbDxuWgu
	obFsDk20yrgBJIbjSvKIloOlQ/6vvWc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-eXTMozb-Ob-udX-paQkRSA-1; Mon, 20 Apr 2026 08:51:12 -0400
X-MC-Unique: eXTMozb-Ob-udX-paQkRSA-1
X-Mimecast-MFC-AGG-ID: eXTMozb-Ob-udX-paQkRSA_1776689471
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d7e5b98ebso2622702f8f.0
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 05:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776689471; x=1777294271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bi57iZ++pwWctggr2TvdW1CtXtPNYbcTAE7BCEX37cw=;
        b=X1UGjnsQUB+eL+F6tbqbT5Wsu8UlSyA0B5rXbjqagml0tRJBkm8gX3d1kEuzy87F09
         OPzbzyo8qEzODBeZAv/jyfgn5mHPQYz7sLvnrRPp0Q+gLj7udi3krNrf7vmSKJYm7ro/
         WLUT1I5oW8mt5Fn2IQo+uP3kW+0Y9dOoIX0UClc2ELe/lZKjeOvZJpDVxSjhqyLo/TdL
         HD6jNCldkZEZSWf9euMqyH6s0Htsg7Ug8jtmtCK+REAAwmhIAzve7q5gnluB1ROJr6x6
         EGmsMoFGbOriM+qqvn31VYFoOWs9SzNGY5NS3YblzA+kkA+V9emKJGDkd74aE9194Lh+
         d5iA==
X-Forwarded-Encrypted: i=1; AFNElJ9RX42Tf3sWno69qSk7u/Q0GsJYeqyz2XCuuk0QAn9lO/eOm27Nw9ke/HYz+nC87P3DpRFUV8qGLKz53O2x/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQgyH0Byo7PwMFCMUC4Mmqx8X/qlYmiKHuCIMkjzr4DGoudOEx
	oTlrF5k3aRpR7suOTDh1ARAh3ohZeDw0r0rxELsQTNKHPcF9NyNlk5ySUR4KR8fopASZhFwNGvc
	Xj1vdFUWgF+zwv56asnLb0DkM93eQATflVyJnqtYr/vknIEp+UTZrNBqn5svtTEp6bBOF
X-Gm-Gg: AeBDietB7foNi4f6u5SfeIl4CGmGyzPkL1zGoGEVcUP9D7KeTkyTgWkmSpR59lRvF9U
	gRYK+ehS65+GcGWHLbAKTpuixykZ19j/abEVVZP+UdxpJCkw9NHXesGAg8fcCQbNheZABAP/SvM
	rHX4W2xRcINqQSQsdVKMmqr4iMprfyZrWpAOZIuLPtJS3OSZPnnaFywuRzq7RHxztR3QE4mezFa
	qptbQ03MnQem2Y1JsNPZzgA6X58hDMRUsJLhXUceW7kq4W0kIGjD+d2U2aw9pMz8retcoS5ZqV6
	u55LHnBgdv1lhj5PfHNJgNxo3Kxzfa2jmzTHG1QSwksyyjiuku5te4F4R33lkUKPfhl72KbgUYY
	z6P8tQdCrnnfuxbrJslTDi8/YaXBq9WGjcioVmPkr2X8+Dnv0ixZO7g==
X-Received: by 2002:a05:6000:18a6:b0:43d:4e65:303d with SMTP id ffacd0b85a97d-43fe3e14f76mr20125449f8f.37.1776689470609;
        Mon, 20 Apr 2026 05:51:10 -0700 (PDT)
X-Received: by 2002:a05:6000:18a6:b0:43d:4e65:303d with SMTP id ffacd0b85a97d-43fe3e14f76mr20125355f8f.37.1776689469912;
        Mon, 20 Apr 2026 05:51:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4633bsm28592720f8f.26.2026.04.20.05.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:51:09 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:51:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev, Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>
Subject: [PATCH RFC v2 17/18] mm: add free_frozen_pages_hint and
 put_page_hint APIs
Message-ID: <c7094de807c0e963526686e1d245bc76193b1a92.1776689093.git.mst@redhat.com>
References: <cover.1776689093.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776689093.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sf83zoaCMjbmYaJtjJ95GIhbXDQiq5rzre5Qb1KxvSE_1776689471
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add free_frozen_pages_hint(page, order, hints) to free a page
while marking it as pre-zeroed when PGHINT_ZEROED is set.
The PG_zeroed flag is set after __free_pages_prepare so it
survives on the free list.

Add __folio_put_hint(), folio_put_hint(), and put_page_hint()
wrappers for the put_page path.

These APIs are intended for balloon drivers during deflation
when the host has zeroed the pages.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 include/linux/gfp.h |  2 ++
 include/linux/mm.h  | 12 ++++++++++++
 mm/page_alloc.c     | 21 +++++++++++++++------
 mm/swap.c           | 19 +++++++++++++++++++
 4 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 14433a20e60c..b226d5e1930e 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -404,6 +404,8 @@ __meminit void *alloc_pages_exact_nid_noprof(int nid, size_t size, gfp_t gfp_mas
 extern void __free_pages(struct page *page, unsigned int order);
 extern void free_pages_nolock(struct page *page, unsigned int order);
 extern void free_pages(unsigned long addr, unsigned int order);
+void free_frozen_pages_hint(struct page *page, unsigned int order,
+			    pghint_t hints);
 
 #define __free_page(page) __free_pages((page), 0)
 #define free_page(addr) free_pages((addr), 0)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index abb4963c1f06..f4e28c55e2c9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1640,6 +1640,7 @@ static inline struct folio *virt_to_folio(const void *x)
 }
 
 void __folio_put(struct folio *folio);
+void __folio_put_hint(struct folio *folio, pghint_t hints);
 
 void split_page(struct page *page, unsigned int order);
 void folio_copy(struct folio *dst, struct folio *src);
@@ -1817,6 +1818,17 @@ static inline void folio_put(struct folio *folio)
 		__folio_put(folio);
 }
 
+static inline void folio_put_hint(struct folio *folio, pghint_t hints)
+{
+	if (folio_put_testzero(folio))
+		__folio_put_hint(folio, hints);
+}
+
+static inline void put_page_hint(struct page *page, pghint_t hints)
+{
+	folio_put_hint(page_folio(page), hints);
+}
+
 /**
  * folio_put_refs - Reduce the reference count on a folio.
  * @folio: The folio.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a4cfd645599a..f04813db3015 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3000,7 +3000,7 @@ static bool free_frozen_page_commit(struct zone *zone,
  * Free a pcp page
  */
 static void __free_frozen_pages(struct page *page, unsigned int order,
-				fpi_t fpi_flags)
+				fpi_t fpi_flags, pghint_t hints)
 {
 	unsigned long UP_flags;
 	struct per_cpu_pages *pcp;
@@ -3016,6 +3016,9 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 	if (!__free_pages_prepare(page, order, fpi_flags))
 		return;
 
+	if (hints & PGHINT_ZEROED)
+		__SetPageZeroed(page);
+
 	/*
 	 * We only track unmovable, reclaimable and movable on pcp lists.
 	 * Place ISOLATE pages on the isolated list because they are being
@@ -3051,12 +3054,18 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 
 void free_frozen_pages(struct page *page, unsigned int order)
 {
-	__free_frozen_pages(page, order, FPI_NONE);
+	__free_frozen_pages(page, order, FPI_NONE, 0);
+}
+
+void free_frozen_pages_hint(struct page *page, unsigned int order,
+			    pghint_t hints)
+{
+	__free_frozen_pages(page, order, FPI_NONE, hints);
 }
 
 void free_frozen_pages_nolock(struct page *page, unsigned int order)
 {
-	__free_frozen_pages(page, order, FPI_TRYLOCK);
+	__free_frozen_pages(page, order, FPI_TRYLOCK, 0);
 }
 
 /*
@@ -5385,7 +5394,7 @@ static void ___free_pages(struct page *page, unsigned int order,
 	struct alloc_tag *tag = pgalloc_tag_get(page);
 
 	if (put_page_testzero(page))
-		__free_frozen_pages(page, order, fpi_flags);
+		__free_frozen_pages(page, order, fpi_flags, 0);
 	else if (!head) {
 		pgalloc_tag_sub_pages(tag, (1 << order) - 1);
 		while (order-- > 0) {
@@ -5396,7 +5405,7 @@ static void ___free_pages(struct page *page, unsigned int order,
 			 */
 			clear_page_tag_ref(page + (1 << order));
 			__free_frozen_pages(page + (1 << order), order,
-					    fpi_flags);
+					    fpi_flags, 0);
 		}
 	}
 }
@@ -7879,7 +7888,7 @@ struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned
 
 	if (memcg_kmem_online() && page && (gfp_flags & __GFP_ACCOUNT) &&
 	    unlikely(__memcg_kmem_charge_page(page, alloc_gfp, order) != 0)) {
-		__free_frozen_pages(page, order, FPI_TRYLOCK);
+		__free_frozen_pages(page, order, FPI_TRYLOCK, 0);
 		page = NULL;
 	}
 	trace_mm_page_alloc(page, order, alloc_gfp, ac.migratetype);
diff --git a/mm/swap.c b/mm/swap.c
index bb19ccbece46..1dfd232d3944 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -113,6 +113,25 @@ void __folio_put(struct folio *folio)
 }
 EXPORT_SYMBOL(__folio_put);
 
+void __folio_put_hint(struct folio *folio, pghint_t hints)
+{
+	if (unlikely(folio_is_zone_device(folio))) {
+		free_zone_device_folio(folio);
+		return;
+	}
+
+	if (folio_test_hugetlb(folio)) {
+		free_huge_folio(folio);
+		return;
+	}
+
+	page_cache_release(folio);
+	folio_unqueue_deferred_split(folio);
+	mem_cgroup_uncharge(folio);
+	free_frozen_pages_hint(&folio->page, folio_order(folio), hints);
+}
+EXPORT_SYMBOL(__folio_put_hint);
+
 typedef void (*move_fn_t)(struct lruvec *lruvec, struct folio *folio);
 
 static void lru_add(struct lruvec *lruvec, struct folio *folio)
-- 
MST

