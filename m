Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F503CA4A9
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620068; cv=none; b=Ch//+NQ/2P3iyoyx71MnX36wLJJRJSB/NdPcsAAjjXnNFLaJUKHKeQMKJs5pah+NimexCwCBxEttz2YXORDeYMPzNp8hHtDZRsJN6m54TbdSeHc4elUofHT8JFQy672qaWdsyZsOGiQM8TFF6phkzggzwlauTO7ObmCwBGxsD8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620068; c=relaxed/simple;
	bh=wEvn415Fgtrq2ovu0Be2ECwe90TsK5RJeb5vnfFQo5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QSQvfjbVxFCZsygOHE+MUPeFWZ1nYguzQVq8jMFp0gup1g423eJGlV95mr/7AqexUSqm7ttVcjvHIxO3YeALk6e/X7V/9h7sYw0AeNzJa43P8a9hnTXv7/g9u+qPDUknw1GWSSwpGpQI4nO3PNL0YObC31cQ1Su9ncFaLM8jBaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cTnY2tyl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTnY2tyl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778620066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D/8VBBw0J+b0eTIG6c4Ba4jQebQb6vF38rsggt16jgI=;
	b=cTnY2tylTs046MJYEQqgdN0DZIQVdBm1g3l2n6jG/WKYxZQYjCAPJ6h+603K7C55INsK6l
	DX4DSf1lPJ0B0oDcZX1b58dyqRvIaVUhBZn8emmapans6vfX7sxLjjTeFNop0ssEjAZDDB
	GcFbMfjyBEdRAeSBfhMAz0fAmRAf8u0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-28D6SFDSPI25zDS-ZJYToA-1; Tue, 12 May 2026 17:07:42 -0400
X-MC-Unique: 28D6SFDSPI25zDS-ZJYToA-1
X-Mimecast-MFC-AGG-ID: 28D6SFDSPI25zDS-ZJYToA_1778620061
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43ff19e54beso4180695f8f.2
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620061; x=1779224861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/8VBBw0J+b0eTIG6c4Ba4jQebQb6vF38rsggt16jgI=;
        b=Ptz3aXlYlCxuVRZsPDzDCg8xunPODpGcW0am/nCGcSUJIB45c4ZbO9FPAyABOU21xg
         IbSRCnr6WI4ZR+WA5iaagsRgFsR8QDF82iBpjxvP/VCm4Xvi1odCqw3G2FecoX+6EBbb
         Ip9FEA+K5Bdem4akF5wfjNzchvfdez5XFwP/HKps2DOUsS22F2nrZTC9KfGrAgL3qen7
         rsRhC+N78jHNS6XxZDTEE/e00pJFwE1HyHhLwdvJJzV2Npfd+dU1nKw8iz7TStY6CfFX
         qIFzHt1u/0JzsEUSVpO2WpRJ4og9JN+Ml33hgWvCvMoEOQDJwTlS6aCkvE0obABYdBCT
         g+qA==
X-Forwarded-Encrypted: i=1; AFNElJ/Xf79Apyjg5JuyX+TNJZoJl1wd3zxNOFChSPzYm/1bOpdLARyHtwY+thI5a2qfUUrzRtExrUnbqTafrdIPVw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6sI7TA+hLoW1KyKDx8nYUri1jmDgEgtEPXmcvAGVdR5N1VLuf
	A8Kye0NuHxv3XT+aoL98zCS6wRV0yV1zADVlWU6yOChOu5i1XQvrKRNw+hvUDWQQQniHQpB9NlX
	dqoT5o0nMgPqKP4AwkM4J/ZqnOc6NLeTNvM6kpSW3PXCl7NWZNu0b4+rUHGA6ReVr2//5
X-Gm-Gg: Acq92OHEX/U9McXR++PSAiGlS2QPgYFOe+8q1X9ZLo6Icl8Cp0XOJJAAjwkh8San0jL
	pn9PTLTvsc8TyEkCkVCJVqFYv8jNW2xz0rT7FFa3e8vSRCOXUnY3N32UAfmjF4zd+PJertebK4J
	sVyO+uQUdfW3f6ZK8L7sQ+TtBBkKNt871cGML42wF4+XinebVuecJU1ZT3pFCcjjvHZyuOKFzS1
	jxhe8QujThOd18kjMSzgGVNcN4gGKo8FkMrxAH40bTy54xQAi/NyisuL2pjsqvQIianalwq6Qt5
	HDUFLeabTLvYHBSJSgAYgBCZnwzW6+OCMGDAOVQFNb2h7+5a/qbURL+eZ/fIdwaJSCpA/HNEgU/
	5hDvrCDqXVFjqpAh+9IvtjeInWCjh++gZGcH4a4tj
X-Received: by 2002:a05:6000:2384:b0:43d:71f4:7ed5 with SMTP id ffacd0b85a97d-45c58698080mr544129f8f.17.1778620061398;
        Tue, 12 May 2026 14:07:41 -0700 (PDT)
X-Received: by 2002:a05:6000:2384:b0:43d:71f4:7ed5 with SMTP id ffacd0b85a97d-45c58698080mr544054f8f.17.1778620060883;
        Tue, 12 May 2026 14:07:40 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a66bfsm30848344f8f.4.2026.05.12.14.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:07:40 -0700 (PDT)
Date: Tue, 12 May 2026 17:07:36 -0400
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
Subject: [PATCH v7 28/31] mm: add free_frozen_pages_zeroed
Message-ID: <df9554006e7db532d9b246cc3059a52626ad5829.1778616612.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: B7Qz__g58CZJ9OrexgXQmRrxBAk1KGYJKEBBiDZGKyU_1778620061
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add free_frozen_pages_zeroed(page, order) to free a frozen page
while marking it as zeroed, so the next allocation can skip
redundant zeroing.

An FPI_ZEROED internal flag carries the hint through the free path.
PageZeroed is set after __free_pages_prepare() clears all flags,
so the hint survives on the free list.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/gfp.h |  1 +
 mm/internal.h       |  1 -
 mm/page_alloc.c     | 21 ++++++++++++++++++++-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index ee35c5367abc..e0d5743de68d 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -384,6 +384,7 @@ __meminit void *alloc_pages_exact_nid_noprof(int nid, size_t size, gfp_t gfp_mas
 extern void __free_pages(struct page *page, unsigned int order);
 extern void free_pages_nolock(struct page *page, unsigned int order);
 extern void free_pages(unsigned long addr, unsigned int order);
+void free_frozen_pages_zeroed(struct page *page, unsigned int order);
 
 #define __free_page(page) __free_pages((page), 0)
 #define free_page(addr) free_pages((addr), 0)
diff --git a/mm/internal.h b/mm/internal.h
index fd910743ddc3..4af5e72742ba 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -938,7 +938,6 @@ struct page *__alloc_frozen_pages_noprof(gfp_t, unsigned int order, int nid,
 #define __alloc_frozen_pages(...) \
 	alloc_hooks(__alloc_frozen_pages_noprof(__VA_ARGS__))
 void free_frozen_pages(struct page *page, unsigned int order);
-void free_frozen_pages_zeroed(struct page *page, unsigned int order);
 void free_unref_folios(struct folio_batch *fbatch);
 
 #ifdef CONFIG_NUMA
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ce43f5a3dbaa..8eebe01cda80 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -90,6 +90,13 @@ typedef int __bitwise fpi_t;
 /* Free the page without taking locks. Rely on trylock only. */
 #define FPI_TRYLOCK		((__force fpi_t)BIT(2))
 
+/*
+ * The page contents are known to be zero (e.g., the host zeroed them
+ * during balloon deflate).  Set PageZeroed after free so the next
+ * allocation can skip redundant zeroing.
+ */
+#define FPI_ZEROED		((__force fpi_t)BIT(3))
+
 /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
 static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
@@ -1596,8 +1603,11 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	unsigned long pfn = page_to_pfn(page);
 	struct zone *zone = page_zone(page);
 
-	if (__free_pages_prepare(page, order, fpi_flags))
+	if (__free_pages_prepare(page, order, fpi_flags)) {
+		if (fpi_flags & FPI_ZEROED)
+			__SetPageZeroed(page);
 		free_one_page(zone, page, pfn, order, fpi_flags);
+	}
 }
 
 void __meminit __free_pages_core(struct page *page, unsigned int order,
@@ -3000,6 +3010,9 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 	if (!__free_pages_prepare(page, order, fpi_flags))
 		return;
 
+	if (fpi_flags & FPI_ZEROED)
+		__SetPageZeroed(page);
+
 	/*
 	 * We only track unmovable, reclaimable and movable on pcp lists.
 	 * Place ISOLATE pages on the isolated list because they are being
@@ -3038,6 +3051,12 @@ void free_frozen_pages(struct page *page, unsigned int order)
 	__free_frozen_pages(page, order, FPI_NONE);
 }
 
+void free_frozen_pages_zeroed(struct page *page, unsigned int order)
+{
+	__free_frozen_pages(page, order, FPI_ZEROED);
+}
+EXPORT_SYMBOL(free_frozen_pages_zeroed);
+
 void free_frozen_pages_nolock(struct page *page, unsigned int order)
 {
 	__free_frozen_pages(page, order, FPI_TRYLOCK);
-- 
MST

