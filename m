Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DBD3C3C16
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489599; cv=none; b=rPP1GOX/o0F/Ko1m0c/ZS02o852nKeJAONghnjKRhVi5cet19hmib7HL0jGg9oHuTVnOKM5FkKvS07SkDmAWS4cu3+7w8ld0Ccl/whdPTgBzFZ/v87rI9jFpual9Jyy4Pjmufs7cCX7ibKQ3pTrWzrEARj1k7PdgYcDX356NJRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489599; c=relaxed/simple;
	bh=XgkToM0l5fC6A+WA27EumzbdOVH3Y/tvtIPE5N6fvlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bKQYoljdU8x4ZxDpW488aOPGp/zhWFMt+ox1/6KSUML8SZDiE/C3I48fWLFYwLFZgbnrg8lHA3v1CH69sBWZ0bgKiMZ7smIw4GFbJ1P9R9L+i4SQPpQJZV1nRtSBSckLdlFbb8diuIsTbkhXovK2VydbgQr2Q5wReUb8aNgNFhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IxuGz4Ca; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxuGz4Ca"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778489596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mz2Z32/qoGa6ei05M/PHSG1PfYksVkCsfkbIzcH2BdQ=;
	b=IxuGz4CaaZrxM50Z9RWifH2hA9EwDLCEw+dJriOdVzQAoeZ8E25ba1wKDIRYpvKFp74C2/
	Z1+QTz1ptbaQ3BI7gkJ7pUjVwjUpFFzl1Q6lrEZZ/f+0FgP8leqQurWTbr5EOickk90yVR
	Ha2ibtAeVufhcLScdQWK8bDQ6x4KAuA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-2WYE2ZsqM-Ga8qkRMHp8kQ-1; Mon, 11 May 2026 04:53:15 -0400
X-MC-Unique: 2WYE2ZsqM-Ga8qkRMHp8kQ-1
X-Mimecast-MFC-AGG-ID: 2WYE2ZsqM-Ga8qkRMHp8kQ_1778489594
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48e86e6c6b7so1940575e9.1
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 01:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489594; x=1779094394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mz2Z32/qoGa6ei05M/PHSG1PfYksVkCsfkbIzcH2BdQ=;
        b=AGarFbo3V8hQKuCi5g4g1I8gubL4C2wqLVbEInvjv+Cs6KfiI0wS7Y7WVUWzGNl8se
         9z5/SlkVFJB9T9WK82PhHkJd2GPfcO0ho9tCMN2n/oV1qUvmLNMNQN7YUyvOnwE6e3RC
         sAKnayQGop+A4ot+RRGQM/sTEmBr85xtJYMjZYAzumVpBvbtz2XqRcQYphmiDfCQg74q
         9XlhZi//vU5ojulGY1IrEErQlwo6C0CT1gJm4CrARYYbc3Z8zQXJVq4TH+7z27eqoHNE
         a1r0yv4sORHvGJFuqND7wBSpuTcLtmdD5LK8EMxzmR9xN7YEe6PGDIKvJGX/HIaEyGUa
         tD9w==
X-Forwarded-Encrypted: i=1; AFNElJ+VL+jaOjQpG7EKQOpsCpBd/IJnja5ZgOLZ+LGHi7MZu/ta4IW9dOHpW7X7MD/5RxJRpyxWQ+p/AXFNKP1f4g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1aRIJHpke7YF6pdbHMpsFJ5CF15Nx86IvyEuszcfmIs6xZ2sj
	yXOVULwAGN75YztmnlTfQFMIKnQL4Ko5YrA2gjyty7rlJjw+7nG2UjJybMloyk3ezMzfx8aoKxB
	c+FjRI37uBG1vM7Mxuo2DGopb3X1DJ9o5RQ2uGA1Gc4QZAxLfQiXwtlWBsQpSt+V5guJg
X-Gm-Gg: Acq92OG1I426O3WPGzPSjjcRaHVAsu3p3A/O2VTD1ky87len8CDj/WUpyGYDqnlbXPx
	+o0Ntp5GPkWPNxvUkVgYWdT5TiV2RUjweXooD7QrOjsZJHpzRnSamsHMy227Wh667lyGVcrNJxA
	dh02b8IPyqzdMDbBaJnHHEpET/NFS8Yg3Q5Ul+EssqRzFM/izHYnFqhARyAXHOljrncVBulH7tX
	VwUrtZHGZiJRJumZzAwTnQVenFidFq2B9HqeYTdSsWVBclqtynBtoBioLE+P91kQ+CMU+lyX9Fi
	PQGvxFbtXdMzwdtwqJovzU329ViRiQjZiU+u6YumpTMsXFwthe3ZovAc4DZjFVY//2PwG3xbreD
	d2k9uVXpWSx44T5VkUzJunBCNpv2BL5aK066rzE7y
X-Received: by 2002:a05:600c:c094:b0:488:b14f:b8ed with SMTP id 5b1f17b1804b1-48e51dd89ffmr269712585e9.0.1778489593884;
        Mon, 11 May 2026 01:53:13 -0700 (PDT)
X-Received: by 2002:a05:600c:c094:b0:488:b14f:b8ed with SMTP id 5b1f17b1804b1-48e51dd89ffmr269711995e9.0.1778489593191;
        Mon, 11 May 2026 01:53:13 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6fffba5fsm164913515e9.2.2026.05.11.01.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:53:12 -0700 (PDT)
Date: Mon, 11 May 2026 04:53:08 -0400
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
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Subject: [PATCH v6 05/30] mm: page_alloc: move prep_compound_page before
 post_alloc_hook
Message-ID: <6345727fdfa76157ba0518e2148d1848e0bdbc16.1778488966.git.mst@redhat.com>
References: <cover.1778488966.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778488966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ENrFfYU03HV-gSIoq_2SdRhIe0Im2WKsrRAgHTmwCSg_1778489594
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Move prep_compound_page() before post_alloc_hook() in prep_new_page().

The next patch adds a folio_zero_user() call to post_alloc_hook(),
which uses folio_nr_pages() to determine how many pages to zero.
Without compound metadata set up first, folio_nr_pages() returns 1
for higher-order allocations, so only the first page would be zeroed.

All other operations in post_alloc_hook() (arch_alloc_page, KASAN,
debug, page owner, etc.) use raw page pointers with explicit order
counts and are unaffected by this reordering.

Note: compaction_alloc_noprof() has the opposite ordering
(post_alloc_hook before prep_compound_page).  This is fine because
compaction always passes USER_ADDR_NONE, so folio_zero_user() is
never called there and folio_nr_pages() is never reached inside
post_alloc_hook().

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c3c0f4e2baa7..f76d5271b5c6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1864,11 +1864,11 @@ static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags
 							unsigned int alloc_flags,
 							unsigned long user_addr)
 {
-	post_alloc_hook(page, order, gfp_flags, user_addr);
-
 	if (order && (gfp_flags & __GFP_COMP))
 		prep_compound_page(page, order);
 
+	post_alloc_hook(page, order, gfp_flags, user_addr);
+
 	/*
 	 * page is set pfmemalloc when ALLOC_NO_WATERMARKS was necessary to
 	 * allocate the page. The expectation is that the caller is taking
-- 
MST

