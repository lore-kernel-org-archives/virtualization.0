Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F823126D9
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315676; cv=none; b=Fpa9lSA8nIpJmusGvSTAwdpr1Cs4WcY3UNZZ0UsIpdFNkcHv8l8WYlPmIB1VNVca7XHXEJJ9CQug+qHacFH20ww7Q/CONJ+hx9OSQx+lx/nSNKYAJd4loTTagZEu94N20PZxvbQOHIIhblwF1D6a3rdAMmJp6F9md23AjYCbrY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315676; c=relaxed/simple;
	bh=8w0BAdcYEx1DYP7LpA2admc4ftuLWgtvGXP7cauVxpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LGQazlL1Z/YTnxJ5xTrcCIKsNk1UmIV/yvWAkd8i34pjJXQ2bVVQiCGT+UPiAfNo9IJrp0KCUHhg0VNARVFKn7eE2D2dEsHYxZHNLy1ib0p+Yz3/2xLBR+r5PotwOVy0vA58BYZoHMjxvuG2dQ0r5USD4Xa29KEbcd2n1skiBhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GMXnREsD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMXnREsD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VBSoYVls/goaUOaeb0ArVPkRixJg6uACMT8ZdsicbY4=;
	b=GMXnREsDaprFpzAtZfqm8EbgOYMApfAAA4DrgM309W64Mh5JF68LyPr/6lU/7jyy4VNQK8
	wQSyudThi18iPolQ978gTPaLvIvqPcBzneol8klXHlZZRYlk5FWrbOzerbqGn02jkQWR5W
	iSpLjuCcaMM3Vu6J3cS5R2wExZNvB9w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-K90VgIudOZC5N5CC0voZzw-1; Wed, 20 May 2026 18:21:13 -0400
X-MC-Unique: K90VgIudOZC5N5CC0voZzw-1
X-Mimecast-MFC-AGG-ID: K90VgIudOZC5N5CC0voZzw_1779315672
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-67b88d32946so4831007a12.3
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315672; x=1779920472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBSoYVls/goaUOaeb0ArVPkRixJg6uACMT8ZdsicbY4=;
        b=Eq+b8y2nPFP7bYZ54+C1IVsNSsHPGp4rM5ib74q9vJRWte1hgTgX9BSCnWm2bA2IH8
         +z9jmFmJjEwdzdk85MFWXtSCoD0jXmyNX7H6QEcdER9/92LXDEiGmZpGduVRUOuJmuKC
         2whrqv7o1faPKgR/pDvH/SP94M6FWrC6ACwAYoErims3MzP6fAQ1R4PxESPxDusdAvDf
         AwF92M389TmyuNw6wDlRofmC1b3JWsIdfpjKDmCcyvstZY17SIzbXygm3S856zZ40E7b
         5d30bia3gr5+Z0o+WLNZBYUxMmUOzYeApEpv/CDc/OwU4SvJHHoEh86rgV+RhMZyWBIy
         jT8w==
X-Forwarded-Encrypted: i=1; AFNElJ8GEAQsLYIjC4PaBppY3DzylGN1+aTel1uplmKcpAaI3iSWcdn36LlERTTFjadIKDG3bRR/O05t1+S+2cXgCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlX8FUkjckvLu0ClxqAaFtqRD3WZbKAiYI7YPkAqJVvqZehfc8
	6Cxk+KWu44OD8ZbJFIub32B72FtY35GvlMfPDqyxdHsPvVuR5xaToB1bPHrHY/fnzgaA/a52l9r
	2pjHwrM4J/8qmLQNnIUaMX1JGtAGRr50465ja8/ZjbYldLugi1JvrB9ulsTqEJnhy5cNw
X-Gm-Gg: Acq92OFZFHvC5z+dqRPWUrtUnpdc3mx68OL7VkZo4kelLm6mQfgZ4xTU1MSO8PgQOKO
	kReW5mam8M2920E/rjPKTl/JXAj6U4+Xm4fwdiG5lQik6P3bGDTgZbiN/paHksAQiKiFaDv3PGL
	3kuRrJj2gurwbk5l87wzJiWsR4KSsNdOAbFfwM3NFXecJpnI/7Uy0gKQXuOP+fSgtznaWwsgjOH
	Jf+QzXOGqlHsil9RA4QUrNunzJ+c6gmxl9513sUNhgm4+Xl5NIqnJWZ1uqE4Sg7bV8wwzryhMqu
	UeoimX6qGGu5y2yYF0gmc0hM6TSCqtOesz0u9sW3Wf70IuF6PKYOxAz6aHNsT7+XWmG67wqANCi
	wAvaYY5g2bBaGoHRPlaleyXgENvTtKImqjkVvCyxM+Tk=
X-Received: by 2002:a05:6402:278b:b0:66a:19bd:5cb8 with SMTP id 4fb4d7f45d1cf-68836ace712mr19636a12.18.1779315671623;
        Wed, 20 May 2026 15:21:11 -0700 (PDT)
X-Received: by 2002:a05:6402:278b:b0:66a:19bd:5cb8 with SMTP id 4fb4d7f45d1cf-68836ace712mr19586a12.18.1779315671078;
        Wed, 20 May 2026 15:21:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310b3e8e5sm8646938a12.4.2026.05.20.15.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:21:09 -0700 (PDT)
Date: Wed, 20 May 2026 18:21:04 -0400
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
Subject: [PATCH v8 08/37] mm: add alloc_contig_frozen_pages_user for
 cache-friendly zeroing
Message-ID: <001e0eaa4ea51951e0a78cea5d6a61ddbc6a099a.1779315441.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: w6elSIrsKkggCsNNsMKei9-zsHPDGhDdH6gHTlCW5o8_1779315672
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

