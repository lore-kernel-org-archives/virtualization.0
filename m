Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C748A3126D9
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315699; cv=none; b=YN8VIgnBEk63n8yirTC+lW9hhGn9LrQ9kOrFdUNvjjvaf9ea0tUNJmj9Yh59xl8sWhQ+gF64oSSa5JjUafomrWWZ2ToK1CwMu0FbYgmWdayNfZr6KqrPHBQ+uJ+nEHyo12FR1h45zyanLrovTCf+VjPJBPGzWuCfXxEBPXdXLUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315699; c=relaxed/simple;
	bh=Y8nJwk5bnDwHUaiRuu38UiZrbZgOyq6/yOrVYrwIdY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FaVTxZaRiuLnfKj069RQ2+Yh5mVGjbG3tdVP/rSrMlllk8tuQMjK/4FMyMQmlbiJLo3fDeUXIzRwu8gEkLnE5uPhO/fTO5F0sAv8ef+hjVuuqaQUDMw32Us4ZIpl3SKq+JMqfM5gRxb9OyZm2Iz/4i8Iz2DuoxeLOKNVaMCC3po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYecUrwP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYecUrwP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xr0Wq/tgum3c1wWvimcTvl9O1enHA5UssViDpRUdduM=;
	b=cYecUrwPZa/hhtr7MX0GRTaYJi/OPqOMb+zriZa6xHteKkiQRuYRz4lH2bbwUVMLiHzSgD
	TSykOdb31kkIpcd+KjNdVpEXQybMZXa0idWA86nWzBndmMkJZng8XLAm4rIAXmiTOHHQsl
	JQ3DvyG3eVg+A8LrfP7eFjHuYGZZNVc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-hIE4r8u9MjqNTH176vuzOg-1; Wed, 20 May 2026 18:21:35 -0400
X-MC-Unique: hIE4r8u9MjqNTH176vuzOg-1
X-Mimecast-MFC-AGG-ID: hIE4r8u9MjqNTH176vuzOg_1779315694
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fd3dbd16aso44800025e9.0
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315694; x=1779920494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xr0Wq/tgum3c1wWvimcTvl9O1enHA5UssViDpRUdduM=;
        b=fITzt/NU06paXR3ETLXfnwmtRjVEYL1+b9UhLueUiA6razNFpdRPod4TtLtFfz33jE
         SEoWm82iH9bBwPEgNZej5fMFtwr/yjsowMFw5nVcqSF9ecBhM6TKgcD18d4EvlP8Za3l
         EIDW29i0AqSgY8y/At03lfj/+oXP2p38n3Yx1LibCCXKMT4H48SFjQfzAsWWJDhlG1NO
         0MAyqGGEUiLwAW1FzF+Wqwypjrj1Kvk9IeAiq9ScAuwxqvUf1SL1nnnqBaIogPQq+XKC
         hcGw1yrIFg/An7b2gOgPxTz4/mdCrOs+kazpF1i5cliyep6N+10VSfPmwYOyGdEL4Cdf
         G6ZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8NwNJoEaoAhdaZ7eglk9O9l5B3EsAwoYsWo+08TQjfaf1awH/FPRhGMLQx9fF5i3PAaCBlttfBF0jBMcjG+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YycCrtUl84hYipFuKCiAjQ0JvXtdU/7nDe2gjeF6JoDI0N6Ti+i
	V4BcdfxuF5mJsW9p+9u1dlbbHho+5z1E8t5ZI5C4+3EJXHPIn+oYMDSNLzEqXfHQDkKGgzuDaRS
	VjvOGcBOZrSCEeNqs1KPK3Q65V8BhKJQgPfMeOVgkyisn1jinbjsWDEHRjxVn1Gmeddgs
X-Gm-Gg: Acq92OE1CPnW1m6ERWMd2NJECdAOl3TUQvWHNpFCVYp30JDDv/RiWteJk2mXFrHVpCy
	keB9hnnQKyntPf73qiy0hgRordyL1JjoWsREiaVDE13NnGNvarIASuD7QEswZG2pvJBB0QPcIfb
	Roo0DImy3W9fgD9gzs9Y56u82DPF4b0juH0U2sFM2sH3qBPHA7E6euwNJ+LN3XwGwRUymoBC57Y
	2weTrslz03GE6Iml79ZIZpXAgtiw6aZFIO3R+mSi24gRTvz95EkhYXr1Pot1KfTL69W910RDOnS
	uN7ym2d2I2WpDGo8d0sxiY4+SguBUsflclc1qFqrNGa0lhY6thXuDuqUgK/cC5DI/FzAiL4klQF
	c9Ku7Gn3uGwobfFsVuyA2VoxerM+riESKef6k3JIi+AI=
X-Received: by 2002:a05:600c:1f89:b0:489:201c:dc46 with SMTP id 5b1f17b1804b1-49036068fb7mr2635195e9.12.1779315694138;
        Wed, 20 May 2026 15:21:34 -0700 (PDT)
X-Received: by 2002:a05:600c:1f89:b0:489:201c:dc46 with SMTP id 5b1f17b1804b1-49036068fb7mr2634915e9.12.1779315693632;
        Wed, 20 May 2026 15:21:33 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035c2159esm1982445e9.4.2026.05.20.15.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:21:33 -0700 (PDT)
Date: Wed, 20 May 2026 18:21:28 -0400
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
Subject: [PATCH v8 12/37] mm: use folio_zero_user for user pages in
 post_alloc_hook
Message-ID: <b2cfe19293b5b4fc644fad344f02785a3b1882e9.1779315441.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: _D9QdNePUrw7r7swcOUNdj8Bn9Mst218IRMG2JL4lw0_1779315694
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When post_alloc_hook() needs to zero a page for an explicit
__GFP_ZERO allocation for a user page (user_addr is set), use folio_zero_user()
instead of kernel_init_pages().  This zeros near the faulting
address last, keeping those cachelines hot for the impending
user access.

folio_zero_user() is only used for explicit __GFP_ZERO, not for
init_on_alloc.  On architectures with virtually-indexed caches
(e.g., ARM), clear_user_highpage() performs per-line cache
operations; using it for init_on_alloc would add overhead that
kernel_init_pages() avoids (the page fault path flushes the
cache at PTE installation time regardless).

No functional change yet: current callers do not pass __GFP_ZERO
for user pages (they zero at the callsite instead).  Subsequent
patches will convert them.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/page_alloc.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3108ac9061ce..ad0655387e9d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1864,9 +1864,38 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 		for (i = 0; i != 1 << order; ++i)
 			page_kasan_tag_reset(page + i);
 	}
-	/* If memory is still not initialized, initialize it now. */
-	if (init)
-		kernel_init_pages(page, 1 << order);
+	/*
+	 * On architectures with cache aliasing, pages zeroed via the
+	 * kernel direct map (e.g. init_on_free) must be re-zeroed
+	 * through a user-congruent mapping.  Host-zeroed pages
+	 * (zeroed flag) don't need this: physical RAM is clean.
+	 */
+	if (!init && (gfp_flags & __GFP_ZERO) &&
+	    user_addr != USER_ADDR_NONE &&
+	    user_alloc_needs_zeroing())
+		init = true;
+	/*
+	 * If memory is still not initialized, initialize it now.
+	 * When __GFP_ZERO was explicitly requested and user_addr is set,
+	 * use folio_zero_user() which zeros near the faulting address
+	 * last, keeping those cachelines hot.  For init_on_alloc, use
+	 * kernel_init_pages() to avoid unnecessary cache flush overhead
+	 * on architectures with virtually-indexed caches.
+	 */
+	if (init) {
+		if ((gfp_flags & __GFP_ZERO) && user_addr != USER_ADDR_NONE) {
+			/*
+			 * folio_zero_user relies on folio_nr_pages which
+			 * requires __GFP_COMP for order > 0.  All user folio
+			 * allocations set __GFP_COMP via __folio_alloc.
+			 * user_addr != USER_ADDR_NONE implies sleepable
+			 * context (user page fault).
+			 */
+			VM_WARN_ON_ONCE(order && !(gfp_flags & __GFP_COMP));
+			folio_zero_user(page_folio(page), user_addr);
+		} else
+			kernel_init_pages(page, 1 << order);
+	}
 
 	set_page_owner(page, order, gfp_flags);
 	page_table_check_alloc(page, order);
-- 
MST

