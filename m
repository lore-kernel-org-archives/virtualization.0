Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBC831197C
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907934; cv=none; b=P69cqKlDvskBrmTW9v4lJQ4GCI8zAjFbXmXOtUzhuPdmrbgIa19wvse4TpOQmuZRAxQVWYstVwBdyKvi7fFoZPkBqY61lwPr77uCrmfDTiKfi/0XTphCfFCDM07bKXE51Bb2Xr3VAPZT4QqGIwFnqFDULFOJfMzoWW/X4lOR+8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907934; c=relaxed/simple;
	bh=XOxo/dtWeCKwLWC3rRtMtJbaGbjkk6GuaLkok0aBtBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=L87tw714/ITf6H60Q3AF4de7CWG2HPGj63dM8X1XwQsVixbpmEld01KdWB3A7GYTI+GDlIb9W1e+wORpg6b1sS2CRv+8wi22HLD06oC4zr3DXc/NsR8V9Qo71SNzgv0sineB3oIEnPVuXpiiddoM6mxuIJFLscy0LdKs8zwDCZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlTapet2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlTapet2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1lvfH8Mz6BNBeGQvvcXVuozV5D9pusYvRbrmVhIfIf0=;
	b=DlTapet2T4ktiww2FSwxG+lE4KDjZIcaI4onjkGmuFPZWex1/xziDRMfmcplF7OvBOiwWC
	JxEsGtsQPVaNQBh8r61ys2VGLKBFvoEoUerImHnAt+jf9xvb2kC29uQJAp9LF8DNaeplHC
	819B45EDsamu6FNS5ZmjsG62aaaFj3o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-c1o7zJZXMRqtLvvPk83Akw-1; Mon, 08 Jun 2026 04:38:47 -0400
X-MC-Unique: c1o7zJZXMRqtLvvPk83Akw-1
X-Mimecast-MFC-AGG-ID: c1o7zJZXMRqtLvvPk83Akw_1780907927
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490b9cd54f3so33607945e9.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907926; x=1781512726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lvfH8Mz6BNBeGQvvcXVuozV5D9pusYvRbrmVhIfIf0=;
        b=LkZnPWFfbmHGE2gJXnfmPdXwQFb6LYxEbQ5YrJpKkn0yGHKAxKlbPgdLTwZH4n6ahR
         ILLiczLqAU1lRFWixha3agGuaFhaP+t7vwh0gKotdrYmf3mei/o1kq0Rea9Rw8CfJTbl
         5o3uSZMKLUHBG7vUIH3oPjPOGGLhx+qoNuVRY20eim+LOcj0phXHUtTISM6dTs74JvPm
         P2Qy8/KahpXs+meiirLA9e4DSfkcLt7cQkLHYnF58GyYG1JbM91OWZa8V1jHvGB/hIDQ
         n4Kh6zUQ4ENzeb/ndT6PI94qPWnvK/4R6OCvCuL/qYnwRSs9V3VVF/olgm4V/NHjnu4n
         UViw==
X-Forwarded-Encrypted: i=1; AFNElJ8iLxGMW5D2ejYL1KMz3fJjcoSMZj7JF4uecHHwwzhwkqLkAtyZ5pMyPOgJrCYcZ6NC+li9k8JNhI62fJx8lw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0we2M0TP8OzK8GeA296rK7nRS6evG2MxxhXJ7YzGZyJgjWa+K
	GBjLy91L/97zPWZfd2WE/Yuv7hICEL7MhZiTsl63oL0pfmizBPTf3U21/9VEfNXD5Bk/5u2kpBs
	fHmd+t3Em0sw9TAlcGcQc4MvOB/Jd0OC9iJzEuKBMvbdjkppmN7DTO3gWGgclG74mrgKi
X-Gm-Gg: Acq92OEFwREQUizVf7U8ljc5RWnPqyfefAI1YKIV4122nYC7SpQdVBlRWb/VEEcdr8N
	x6kl0Lr+6SceXbaxQNT4Xns7zcv/zO/ezlKmRATDxqhyCUq2tVP+VKZE0mCVq6BVsCf5SARB+2x
	TIP6faIkE04CEjWOh4msy1Oudx8yEtKz1+7TU3XEl1D0oMzRJ0aTlgDINgPV7Sy69vikYHfEwtJ
	7V9UtKWjB5+zXSbSAWZaAiUJV7pfQH6uPMp5SrHfqdbQiJyE1XuTGP90wk53hNh//6fWXw5q+gP
	lFR5teVF5L7CVb5Gf8HlOCTTAahau+qKFvGTQnyqw7T5DhNGtpaPJxE4rqQRBxURzKMHyODIQA5
	UMXI795VlUWYM7YCrgpUcIew=
X-Received: by 2002:a05:600c:628c:b0:48f:e26a:1744 with SMTP id 5b1f17b1804b1-490c25a87f5mr237272575e9.9.1780907926344;
        Mon, 08 Jun 2026 01:38:46 -0700 (PDT)
X-Received: by 2002:a05:600c:628c:b0:48f:e26a:1744 with SMTP id 5b1f17b1804b1-490c25a87f5mr237271745e9.9.1780907925906;
        Mon, 08 Jun 2026 01:38:45 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2eadefsm51854339f8f.11.2026.06.08.01.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:38:45 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:38:37 -0400
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
Subject: [PATCH v10 22/37] mm: add free_frozen_pages_zeroed
Message-ID: <4220116b4d91f3e933fa76ad473106c2e48fd452.1780906288.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: ZNZETqkbXDNQocaPZvLfc5rmfWLVRK-KCMXUELSWFfk_1780907927
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add free_frozen_pages_zeroed(page, order) to free a frozen page
while marking it as zeroed, so the next allocation can skip
redundant zeroing.

An FPI_ZEROED internal flag carries the hint through the free path.
PageZeroed is set after __free_pages_prepare() clears all flags,
so the hint survives on the free list.

__SetPageZeroed is non-atomic but safe here: the page is frozen
(refcount 0) and not yet on any free list.

Note: when want_init_on_free() zeroes the page via
kernel_init_pages(), the page is zero but the direct-map
cache lines may be dirty. A later patch (skip
kernel_init_pages for FPI_ZEROED) avoids the redundant
re-zero, and post_alloc_hook handles the dcache flush
for user pages on aliasing architectures.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/gfp.h |  1 +
 mm/internal.h       |  1 +
 mm/page_alloc.c     | 23 ++++++++++++++++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

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
index 4af5e72742ba..fd910743ddc3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -938,6 +938,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t, unsigned int order, int nid,
 #define __alloc_frozen_pages(...) \
 	alloc_hooks(__alloc_frozen_pages_noprof(__VA_ARGS__))
 void free_frozen_pages(struct page *page, unsigned int order);
+void free_frozen_pages_zeroed(struct page *page, unsigned int order);
 void free_unref_folios(struct folio_batch *fbatch);
 
 #ifdef CONFIG_NUMA
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 21f9e92922f1..008f1a311c40 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -91,6 +91,13 @@ typedef int __bitwise fpi_t;
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
@@ -1596,8 +1603,12 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	unsigned long pfn = page_to_pfn(page);
 	struct zone *zone = page_zone(page);
 
-	if (__free_pages_prepare(page, order, fpi_flags))
+	if (__free_pages_prepare(page, order, fpi_flags)) {
+		/* Don't mark zeroed if poison overwrote with 0xAA. */
+		if ((fpi_flags & FPI_ZEROED) && !page_poisoning_enabled_static())
+			__SetPageZeroed(page);
 		free_one_page(zone, page, pfn, order, fpi_flags);
+	}
 }
 
 void __meminit __free_pages_core(struct page *page, unsigned int order,
@@ -3020,6 +3031,10 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 	if (!__free_pages_prepare(page, order, fpi_flags))
 		return;
 
+	/* Don't mark zeroed if poison overwrote with 0xAA. */
+	if ((fpi_flags & FPI_ZEROED) && !page_poisoning_enabled_static())
+		__SetPageZeroed(page);
+
 	/*
 	 * We only track unmovable, reclaimable and movable on pcp lists.
 	 * Place ISOLATE pages on the isolated list because they are being
@@ -3058,6 +3073,12 @@ void free_frozen_pages(struct page *page, unsigned int order)
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

