Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE4D3F54D1
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315808; cv=none; b=jAKaOxpYr3M+o8UehaN38YqemzO33wns3srLlmsc0GlBjzxbxP6fA5hEMyXnqo9kF1fc0MjBJPGBnhpWfH3XE/6BLr9bcBGTO5PfLuddg5BrJ8625RbsfuKifTHEl8g0xpoxYq3b8zUGKwG5NOF41rhxg/jETOwhQEnZxvWjdIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315808; c=relaxed/simple;
	bh=6Lm0/uxEF7Jrx82xgvKLV/wotxiG6uz9abF+ckORdaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fFLJp0Gsw34eqjbD+8PwaZ7wiO4yAHZ2k1bzSSB/p/zL8rsW3BpO/yAxceh6nguSIfC9AI2Ju4cNhcIDXlgvO0dTXL6qyf4Gh6sFaxoz9S0ajcLwNn8tvq8yiTCtHzkmjgqDXKy+3nC2GAazwFM9EX4h7rbp6D2SGlKYncwCDBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDMyIEcg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDMyIEcg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4vz+PjXrtbljoW8SfvrGsI8KrTf/iN/5SV/3uQ1i74A=;
	b=ZDMyIEcgIsipVMenGbItEU//dE07ekvpBZ50Xs6W6/aaaPTgMDDecY8bPTEQOCvPnV6VWb
	0b7bHmWrewcKarFpK7/RT+pZPfZqN6Ik1atXuIj/b8UVqJs11VWeGXRyQSPiF+f907FDLe
	mEsrN55LSp5UEVsxlgnBvHN3Qwb8kaI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-NZVWG9DoOKy3pDm27Fqf1Q-1; Wed, 20 May 2026 18:23:24 -0400
X-MC-Unique: NZVWG9DoOKy3pDm27Fqf1Q-1
X-Mimecast-MFC-AGG-ID: NZVWG9DoOKy3pDm27Fqf1Q_1779315804
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4497a0e3acaso5150658f8f.0
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315803; x=1779920603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vz+PjXrtbljoW8SfvrGsI8KrTf/iN/5SV/3uQ1i74A=;
        b=fXPGGh6VdU0cNCGRaFaaZxfddok3v06mHKabY0UpYev/DxUTKns3Z9xkfAiEImnmFS
         dG5MWutfVIvFFqknyCCNnLBVllEUJLN3Zji9ijpTPfo9k6B1w4NX9DNGBxpleX80Vz6h
         Y+RS5dHPkQAZoDAiVniHJNQv9xa+Hm1uk9P2ez43fE6+OOZpJkkdo7YQkKB3OgbBMnkM
         WCQP4dCXy1ypWq37SUQ3fqVXRUBCITZEGvj9T4S7Uf40+Bemjv1j6oDA5EbA/Lga8oAT
         KcLWH0M5rEIuXpkwtvbd0R/38XIiifmdXu+10HN18Pm6bOkvRJgKYC/csXx3ntquiwPd
         SngQ==
X-Forwarded-Encrypted: i=1; AFNElJ8twrYYYeUJWUSIT+Xt9XdmueI6Vkm4EcGIDIoRk5GqoSJ8ch4Ms4nor6PTjqwQOP7WZQKKUedM1kxNUbBw6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfgIdZqeJvg4l4Y3huX0SYhn+aIm1kiC5wEfZhFnY6RpgrLotY
	8iE/aHPbcro1lCBbePSbms5e84ihGWxpIj8HIzLYX04JN3RjjiurnBmuzZhP9mXa+XEVSgPRfKy
	Rj1zniJ7IN9hxeX7z9iAsO7miKUqgAvUKj5V/p4SM3wGkDoy47BzW92Zy0cltwCfwKF3J
X-Gm-Gg: Acq92OHPELXVmwBiLGVcvivtIRcrlkzCPzYGGX4Hj3YRMAZfWnrZSRb4A3Jl+4fznmn
	bsjBpRXJpTb2zMA1v05Yf7qhRYUl+ywd6DjJ4wxYpMaPdrIHw3E32bllM7vuqru7iXI9pIArQ36
	7UCESMRKESjb206PhbrzDn/PWE4Ipg88iMKjctfYX65AVfrvHqfGxU6JMNTAbOtMcN/HgBgkTP2
	BNQLDYtg71nI/m45m4uFT5ArkVCTYtuL/mxTNBbIbmtxQC1NDfWFbUuDGp5kZzo6HLBhkPKk3MD
	f0lRlAiQfeZfV1lBOb6dYnyzKG0e1+d5AkpU86imIVCWQaUvRyk1eqSxe9esQsbe1B8M9oTTejo
	5fsSIZziPQJmkp2bIl1XszmxBLRGSOP+3K+svh0HiG8Y=
X-Received: by 2002:a05:6000:2089:b0:43d:73de:abd2 with SMTP id ffacd0b85a97d-45ea3ae8801mr287874f8f.26.1779315803449;
        Wed, 20 May 2026 15:23:23 -0700 (PDT)
X-Received: by 2002:a05:6000:2089:b0:43d:73de:abd2 with SMTP id ffacd0b85a97d-45ea3ae8801mr287814f8f.26.1779315802825;
        Wed, 20 May 2026 15:23:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2ffdfsm53030712f8f.15.2026.05.20.15.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:23:22 -0700 (PDT)
Date: Wed, 20 May 2026 18:23:18 -0400
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
Subject: [PATCH v8 33/37] mm: add free_frozen_pages_zeroed
Message-ID: <321e9f1a5a15a80dfb25a9b8aa76657ce27b2b2d.1779315441.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: YYOlLDO171Bxxp4v1EqWwuNfZccmtY7x5_soJUeekDQ_1779315804
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
 mm/page_alloc.c     | 29 ++++++++++++++++++++++++++++-
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 73109d4e31a4..d24b61e45861 100644
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
index 702fa2ced1e1..399e2038dcd9 100644
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
@@ -1599,8 +1606,19 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	unsigned long pfn = page_to_pfn(page);
 	struct zone *zone = page_zone(page);
 
-	if (__free_pages_prepare(page, order, fpi_flags))
+	if (__free_pages_prepare(page, order, fpi_flags)) {
+		/*
+		 * Only mark as zeroed if the page is actually still zero.
+		 * kernel_poison_pages() overwrites with PAGE_POISON (0xAA)
+		 * when CONFIG_PAGE_POISONING is enabled.  With init_on_free,
+		 * kernel_init_pages() re-zeroes after poisoning, so the
+		 * page is still zero.
+		 */
+		if ((fpi_flags & FPI_ZEROED) &&
+		    (!page_poisoning_enabled_static() || want_init_on_free()))
+			__SetPageZeroed(page);
 		free_one_page(zone, page, pfn, order, fpi_flags);
+	}
 }
 
 void __meminit __free_pages_core(struct page *page, unsigned int order,
@@ -3021,6 +3039,9 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 	if (!__free_pages_prepare(page, order, fpi_flags))
 		return;
 
+	if (fpi_flags & FPI_ZEROED)
+		__SetPageZeroed(page);
+
 	/*
 	 * We only track unmovable, reclaimable and movable on pcp lists.
 	 * Place ISOLATE pages on the isolated list because they are being
@@ -3059,6 +3080,12 @@ void free_frozen_pages(struct page *page, unsigned int order)
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

