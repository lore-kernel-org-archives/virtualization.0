Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24A239A05E
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 22:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808929; cv=none; b=jJ/pxUXeAGXUlJlGg+6vKmWopxZoUb9VEytDpkrYuYyt5tOPj2gbJdu4EeZjFjkAuHfTCEci5Qrejz8XEYSCVOOe4/9ka53ZwxREJfx/0G5qKnOJYkKZ/nueJvYu4vtlhysW254oTWVPUmLvKcGWortolmMd1476sEOS9cg2Qbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808929; c=relaxed/simple;
	bh=I+6H8EURLdFuL8zgQfH6lh8KyVwVos3w3eBqKRjNL0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Xk4djsYDX53IuyTkTzcnhRZ2APieH/zQdbweJZSinTLNfNz95FPp8YBczI9HoOlWbQbuECsPKB9gJ8Xs+pxr3Cuo7VdLrTMH5XTDrZzAKVQbaJDvcmOLFb7CV8M5x2stJfKi4noWdtTTORrA6y4FrYTokGAP9pRb7h0FIvy5huk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EsWkuM1h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsWkuM1h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776808927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DqibEu51w521jmMlLo0nOiOBZCjTDi4b9M623UPDLCI=;
	b=EsWkuM1h2sKQoPuOC+H9Y1XOuqI6MRz5WFdTmGvgMlo3JjwZvPnZ9WVnf/V8wE79vlK3tU
	KQTKO9nRC5s8Pa9+wB4Vxv9mnrFLbqQ6LvdCMHaCevjif/AD1HlQq8MGNOgLqTrA+ESXNd
	0IlJb8wfZgnvOwYTexnFoUoxuSp3qDQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-rQ8yvdV1NfCutVQtBlYrjQ-1; Tue, 21 Apr 2026 18:02:05 -0400
X-MC-Unique: rQ8yvdV1NfCutVQtBlYrjQ-1
X-Mimecast-MFC-AGG-ID: rQ8yvdV1NfCutVQtBlYrjQ_1776808924
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488bd1ee9e7so37750675e9.1
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776808924; x=1777413724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqibEu51w521jmMlLo0nOiOBZCjTDi4b9M623UPDLCI=;
        b=PbDTkc9iRf1bwIVryAlXi/MPzoiuLWJgoGfEp+OWILm27b80XGdLIg/wkzdWyiCywy
         R+hs+Eo+z6qCi4TGRLmjCtRG/wRERv27xiBWmfPT7XwNb9YiHud51xV9bJ2ouIqI6Afj
         reROfKStph09r4fBGOjWzd1cjNt0Kc9lJSW2MgfVSNrHVxY+tSwyCPeOah7Ls1MrfySp
         LNjy6EhBJRaXyDls1zWixgvz/eCBe/9tS0NK6iQ1DQYHCeFWjqds6Qo5l2nF1ygz7kTP
         Vngoc+dFJxbblEBLDfxhCgvUvEY4KY9mDvk2Ftt63wQ6OomEeh/JoFfc7G41TZ7bC2la
         i/uQ==
X-Forwarded-Encrypted: i=1; AFNElJ9cQU6UvvoQMFXrAIt7/7PZs+86gwWSkAGP7zbcaCxUIM5VHIld1ELyj4B9mgui9In/VEDOmRHkNxCRx+wZBA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEMEdaeIh4IY+7mgnFlayxTHDs4do7Zz4W57q24esvB3BIlFbx
	e2lKTpXN7ZBC761o4Hqu61+HZR+hQO3IHTYv6nwv/04WjWjdBj3tcvvMVlbvKwjUhs5SmGuBOuU
	7sSGkVU259wjUeiep2x5apDyX/pRQ+AVHt7JHJ4EFNOBAAzRCzFxVwWynkrlMq05fquiOARenyN
	L4
X-Gm-Gg: AeBDieu9sMkLoKMl3rKBej3+2Vb1QKsEbFyJFgvGsrR0sArBgfbjBe2HeTzdHbGG9RQ
	9hiwskCoZ6LD7M4bRuDZ1jZzretbTDl1BlmyeBCwavwD5d7765A2Z1zzMLvkD0eIaQYhzAxKGoA
	LVlu7pNiZPYNlTCmK/ZqCQRNcfPhtBk6C8R77M9NAfvhzI9s1XO2sxDdXK1vLi5oq3wJ19IapES
	9NYLMy+5pJZdZXtKOOmFmB8B9v+TkzcEzQFjZqcsi6PdavqGe0Kmz7oAaIP7oH0J+Wm86+hxPTp
	HZMTqUfxZCNzTzzMW/HYD4RNttSRaahahaZ23iPELF6N5U5lh9Ig/u8iCQweqZcy1FckcodqVaj
	myTRrFsTn+WfS355zdJ1ES/N3HQvDMO+9aJjDEn3Kqem89I/0U+4ViA==
X-Received: by 2002:a05:600c:8483:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-488fb782d91mr292621275e9.21.1776808923880;
        Tue, 21 Apr 2026 15:02:03 -0700 (PDT)
X-Received: by 2002:a05:600c:8483:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-488fb782d91mr292620925e9.21.1776808923421;
        Tue, 21 Apr 2026 15:02:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc17f642sm364997035e9.5.2026.04.21.15.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:02:02 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:01:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH RFC v3 15/19] mm: add free_frozen_pages_zeroed
Message-ID: <86755bb7ab63e2374a242ce24a9a3f1981f10583.1776808210.git.mst@redhat.com>
References: <cover.1776808209.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776808209.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _WzjY7aGEwy8ERZyu2jj2caoltj2HknA_to7vYD9iT4_1776808924
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
index 10f653338042..12ab91e2ed57 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -398,6 +398,7 @@ __meminit void *alloc_pages_exact_nid_noprof(int nid, size_t size, gfp_t gfp_mas
 extern void __free_pages(struct page *page, unsigned int order);
 extern void free_pages_nolock(struct page *page, unsigned int order);
 extern void free_pages(unsigned long addr, unsigned int order);
+void free_frozen_pages_zeroed(struct page *page, unsigned int order);
 
 #define __free_page(page) __free_pages((page), 0)
 #define free_page(addr) free_pages((addr), 0)
diff --git a/mm/internal.h b/mm/internal.h
index 4c33249e03f0..e655385b269c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -899,7 +899,6 @@ struct page *__alloc_frozen_pages_noprof(gfp_t, unsigned int order, int nid,
 #define __alloc_frozen_pages(...) \
 	alloc_hooks(__alloc_frozen_pages_noprof(__VA_ARGS__))
 void free_frozen_pages(struct page *page, unsigned int order);
-void free_frozen_pages_zeroed(struct page *page, unsigned int order);
 void free_unref_folios(struct folio_batch *fbatch);
 
 #ifdef CONFIG_NUMA
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2098d569d80c..9311374bbd2d 100644
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
@@ -1611,8 +1618,11 @@ static void __free_pages_ok(struct page *page, unsigned int order,
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
@@ -3012,6 +3022,9 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 	if (!__free_pages_prepare(page, order, fpi_flags))
 		return;
 
+	if (fpi_flags & FPI_ZEROED)
+		__SetPageZeroed(page);
+
 	/*
 	 * We only track unmovable, reclaimable and movable on pcp lists.
 	 * Place ISOLATE pages on the isolated list because they are being
@@ -3050,6 +3063,12 @@ void free_frozen_pages(struct page *page, unsigned int order)
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

