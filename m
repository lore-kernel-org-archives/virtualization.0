Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042183ED3A3
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068172; cv=none; b=sHTb6Q7IdC++cOC/NHW9tdu3YQUM0eE2N2LBs5U9ejJzR/AhmVlFe0Pr6EJCrF2Az+8Zj2/wtDW1TDb06hWotN5yLHcVwHASXFj8gYamAjB7fw4m3sa89qo6R92p0irFhVRZal2+2XRdkyXjOippJG86TohK7sVlHG7O26NIlGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068172; c=relaxed/simple;
	bh=8w0BAdcYEx1DYP7LpA2admc4ftuLWgtvGXP7cauVxpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KRrgvI4RFFfaM71nKV5S3ClyaA8tHG7MsI5I9Ljia+XF69rJ2fyQbm0zmXNJ0CarZQSF6DYMkYPpPFSUcbMBXKN64tuZWsF+nmDT1HdeoHcnVnV7ycKQAa0LxBNwfY3uZdrwcwI+mU7Qi0uVl0ZI/JYC2nqIWLZ+iK8EQ7ucgUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ErqOQrWV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErqOQrWV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VBSoYVls/goaUOaeb0ArVPkRixJg6uACMT8ZdsicbY4=;
	b=ErqOQrWVLJzuVZwWYDc0q1rLvwdOrOxMrbMMDsuZVy+QMsW0NTjdQ1v+VkV09ffsuEUY3D
	6JqlWmVKzNK5cfUbM8lTtbetDIalQnVFkUoXqMuWdWYncClZGA5af73vuL10GPSP48X53g
	uhgcmVs+EbjbtzgWu6T1rqdLQmKFSKo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-hzpy4TZOPaWheE-7e7xsvA-1; Fri, 29 May 2026 11:22:49 -0400
X-MC-Unique: hzpy4TZOPaWheE-7e7xsvA-1
X-Mimecast-MFC-AGG-ID: hzpy4TZOPaWheE-7e7xsvA_1780068168
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45ef4931de5so316916f8f.1
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068168; x=1780672968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBSoYVls/goaUOaeb0ArVPkRixJg6uACMT8ZdsicbY4=;
        b=JEpsH1/XwN505eseNzaU6RzSWpxubtdzFN3lm9om9J1I6o1Pj7O5qlDKjbTXzIxPK5
         ZpM5wTLbGk0ynE/Sb1hKGil69xp8VY8qeY1pOXaUWoz8I8W48xfTx9VDC1nNVt0VNc4U
         2aAaPtXdlhuiiN86mOwx7/FFgoPvWgSplw7NXbgqFW+V6S5Al3xmIjp4DCKcopOugEcN
         mRk1EFeirYxIMnDVLl+aUPSI+408R1QA6WSGv5alzJqdeU4YjpvY77+kRMSQmPPv+RqQ
         ijaEsFjiPIbyT+gpYAhe+vEyosSiLdCBa6+S2GZQGRbGGf7z0gRBeJvG9BiH3QoblYuO
         U0fg==
X-Forwarded-Encrypted: i=1; AFNElJ9bk8bTHzBx4PvNO0+TwWeubovHN4IXzgjuPch6HQgMbhSmXYjfwMBCbaTK1aTnV9uegjK+ElRY9CnzkQI4vQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwC+7o0SRanIEndOwQiGoLB5BsZn3BgY3uy/sHf1Z7Nvki4iYCk
	c4Vtm6xkt5z9bodeULD0lU7hP9pLyDCksVpkE2xx0ZXhEXRn/bFZ+xon6ZHVFHaGqrv86/dUghM
	hVfFSA7TGLTQW6cTAB4E9BjEELYu5qjdD6vnhiT5PK9G7OpvqnwY7yNiin/eagBPWiUCr
X-Gm-Gg: Acq92OHh2JskgQzSugII+18SSqS1N0UUgr8RaQTYOg/HOxk76BK132OVRO3fizDICkU
	Tn62kkd7vHahgjKbOYqwELJaa935H3kN1MgtQye6wjoXGZf8acawt/vrEVvLrZl9t8mIm21EMiQ
	I+fLFVzzOPDV/6xIiLtDXHtFsRFPscXdVzQwCwU2zsv4659jR/q6lpSiyXL/+Z1ZOsGk3qz9qPr
	ijZ7r8scF053fx8/TSLTuRxDo0jy+p7fN6kBvobrvzG/OJPxK1kPie0HlkOGrjjX8HUOou/7yZv
	cxtW602wNdygUO5y2T/CFs6q7C7/JyRw2XBIgvLq9wXgHqlr+zZPfCiigv7m9Hh69V5aszChV2G
	CK+If9MeOlNyC5s8Z92UN13dto0W0gbpSORBlkSj2oR1PsDuSk3NOFg==
X-Received: by 2002:a05:600c:8207:b0:48f:e044:927d with SMTP id 5b1f17b1804b1-4909c62336fmr43494935e9.10.1780068167471;
        Fri, 29 May 2026 08:22:47 -0700 (PDT)
X-Received: by 2002:a05:600c:8207:b0:48f:e044:927d with SMTP id 5b1f17b1804b1-4909c62336fmr43494295e9.10.1780068166844;
        Fri, 29 May 2026 08:22:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909caa7faasm50679705e9.11.2026.05.29.08.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:22:46 -0700 (PDT)
Date: Fri, 29 May 2026 11:22:42 -0400
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
Subject: [PATCH v9 08/37] mm: add alloc_contig_frozen_pages_user for
 cache-friendly zeroing
Message-ID: <ce3658f2d412af44e3e678a901b7f411f49d13bd.1780067977.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Q1We_L3owhJyBqw9y-U-sOzK-vnMNL6GOiYjXni9gsc_1780068168
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add a _user variant of alloc_contig_frozen_pages that accepts a user_addr
parameter for cache-friendly zeroing of contiguous allocations.

No functional change; all existing callers continue to pass
USER_ADDR_NONE.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/gfp.h |  6 ++++++
 mm/page_alloc.c     | 32 +++++++++++++++++++++++++-------
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index ee35c5367abc..73109d4e31a4 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -453,6 +453,12 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
 #define alloc_contig_frozen_pages(...) \
 	alloc_hooks(alloc_contig_frozen_pages_noprof(__VA_ARGS__))
 
+struct page *alloc_contig_frozen_pages_user_noprof(unsigned long nr_pages,
+		gfp_t gfp_mask, int nid, nodemask_t *nodemask,
+		unsigned long user_addr);
+#define alloc_contig_frozen_pages_user(...) \
+	alloc_hooks(alloc_contig_frozen_pages_user_noprof(__VA_ARGS__))
+
 struct page *alloc_contig_pages_noprof(unsigned long nr_pages, gfp_t gfp_mask,
 		int nid, nodemask_t *nodemask);
 #define alloc_contig_pages(...)	\
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b96c9892f6c6..b725a3b59835 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6999,8 +6999,9 @@ static void __free_contig_frozen_range(unsigned long pfn, unsigned long nr_pages
  *
  * Return: zero on success or negative error code.
  */
-int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
-		acr_flags_t alloc_flags, gfp_t gfp_mask)
+static int __alloc_contig_frozen_range(unsigned long start, unsigned long end,
+		acr_flags_t alloc_flags, gfp_t gfp_mask,
+		unsigned long user_addr)
 {
 	const unsigned int order = ilog2(end - start);
 	unsigned long outer_start, outer_end;
@@ -7127,7 +7128,7 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
 		struct page *head = pfn_to_page(start);
 
 		check_new_pages(head, order);
-		prep_new_page(head, order, gfp_mask, 0, USER_ADDR_NONE);
+		prep_new_page(head, order, gfp_mask, 0, user_addr);
 	} else {
 		ret = -EINVAL;
 		WARN(true, "PFN range: requested [%lu, %lu), allocated [%lu, %lu)\n",
@@ -7137,6 +7138,13 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
 	undo_isolate_page_range(start, end);
 	return ret;
 }
+
+int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
+		acr_flags_t alloc_flags, gfp_t gfp_mask)
+{
+	return __alloc_contig_frozen_range(start, end, alloc_flags, gfp_mask,
+					   USER_ADDR_NONE);
+}
 EXPORT_SYMBOL(alloc_contig_frozen_range_noprof);
 
 /**
@@ -7255,8 +7263,9 @@ static bool zone_spans_last_pfn(const struct zone *zone,
  *
  * Return: pointer to contiguous frozen pages on success, or NULL if not successful.
  */
-struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
-		gfp_t gfp_mask, int nid, nodemask_t *nodemask)
+struct page *alloc_contig_frozen_pages_user_noprof(unsigned long nr_pages,
+		gfp_t gfp_mask, int nid, nodemask_t *nodemask,
+		unsigned long user_addr)
 {
 	unsigned long ret, pfn, flags;
 	struct zonelist *zonelist;
@@ -7284,10 +7293,11 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
 				 * win the race and cause allocation to fail.
 				 */
 				spin_unlock_irqrestore(&zone->lock, flags);
-				ret = alloc_contig_frozen_range_noprof(pfn,
+				ret = __alloc_contig_frozen_range(pfn,
 							pfn + nr_pages,
 							ACR_FLAGS_NONE,
-							gfp_mask);
+							gfp_mask,
+							user_addr);
 				if (!ret)
 					return pfn_to_page(pfn);
 				spin_lock_irqsave(&zone->lock, flags);
@@ -7309,6 +7319,14 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
 	}
 	return NULL;
 }
+EXPORT_SYMBOL(alloc_contig_frozen_pages_user_noprof);
+
+struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
+		gfp_t gfp_mask, int nid, nodemask_t *nodemask)
+{
+	return alloc_contig_frozen_pages_user_noprof(nr_pages, gfp_mask, nid,
+						     nodemask, USER_ADDR_NONE);
+}
 EXPORT_SYMBOL(alloc_contig_frozen_pages_noprof);
 
 /**
-- 
MST

