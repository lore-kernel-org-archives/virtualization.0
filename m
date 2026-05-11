Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B13C0610
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490138; cv=none; b=qsWfRKvDc+qNMUipFEM1P5h64fQ5P1K78rw+Rj5pUjtUkeO21klZmp7vsxNXA9s9YV1U7WeaVMZNPBtK/cbiUE4UVhYfZxPZk6EhAvEkgSICgZff/hacdZF5BfymVKYIx9vXS8Diu4PgTU0Dh6Hwpc8Us8xA++TUyg7K/1NmwO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490138; c=relaxed/simple;
	bh=XgkToM0l5fC6A+WA27EumzbdOVH3Y/tvtIPE5N6fvlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tOdHKXmwcCLI7vAT1iCzXvdTUMSAkuz12XPQshvE9xc3XxKvgF678ZZKRn45fnEI5iwSracZjmuvH1XWYe8/V+ydnZP2V76z1IcLwK81RCwC8WyH1v9E5ZsQp24RCcT8fEdQ40aaaUcDNV2J8HvKbz2WiO2WvZXMTNmjHWS5vb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ggzYbS77; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggzYbS77"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mz2Z32/qoGa6ei05M/PHSG1PfYksVkCsfkbIzcH2BdQ=;
	b=ggzYbS77R7NMdRsdBQcTxVQZ5nG0Sxdz1bOjiAfjM7jh9K3YALZA53i6gUcwSlk7XAOG57
	LY9TKJ55RMhSh4zRBqMEBMb9RBfrKfUOsmG6BDWzqOpaxalEIPOf+082VQzi395dmuwKD0
	Vjv/7stxV1qe09r70FSphdudrqVmewM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-A1BQB4bnNIioYLih-aCICA-1; Mon, 11 May 2026 05:02:15 -0400
X-MC-Unique: A1BQB4bnNIioYLih-aCICA-1
X-Mimecast-MFC-AGG-ID: A1BQB4bnNIioYLih-aCICA_1778490134
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44a122a5128so3130461f8f.0
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490134; x=1779094934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mz2Z32/qoGa6ei05M/PHSG1PfYksVkCsfkbIzcH2BdQ=;
        b=dmNaBaVuvDnW7KUUMxOPJDiYkhQkReU3ASNpOrVPpBjJTGHnMfBUvTBXI6GO4ex2zA
         QFsRaKS62r+HyDVyq0V64yjtDnzlikml8G4h2Bgnzk2NuB6JUJaM77uDyPPRIkirC0Au
         bWrxw/ZxpRYPUC9j9jZ7d0lAkiiXZOvsGM3ob7ZYPpPkG+nGcAEDw9ELJFbt9vDiJBik
         lDjbqBvhccwMjuQlw2lFSyWRxTyh8DE3bcdWauoSspZf28BPucIkmaG4dFz7krDufJsm
         PBoxAJ2pbOj/byT1oBI2NTfYHxC28iUQgs3JmQbAorESHPa/3a+ZZBGXDZm3fdwRlwk0
         niIA==
X-Forwarded-Encrypted: i=1; AFNElJ+2GoE8PbWYCE7Ulik9hAND0Apk2XHtSJ1kqNnZLSIgwE7hFZB1wNvUYMq6OPlsrU0y/WLjUY545/b8O6Q/hA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywkpl+qxcsuvaN5ko0UBYZvOCjSwVWtXRioXwWSL+rnUs75fDjH
	cTGztPC6mLqhrzbmpAvGO0IVEU3sKuXgcg0bTtRu44+e5IyAvXwXm94bkjvhcONdZakN97rdNrn
	V0IDJ8kVKgJSfITr/Obf30qDXi1gNEsaRFmeT61g7gUhPrHp/k8FqqmWyr7dM2IDzbI9g
X-Gm-Gg: Acq92OGEdYPbhbneeRyBkPp9ZlrTgwCbHbw+anhI8BFMMskHdZiQG380JrdjpbdercQ
	56SAKLWNnLO3y58Rxi8UCD6vwxoqm1dVZaHOGlpM5uP1OEscV1VIFmHLMUvD46Xu24MrqPq2Dgj
	44J/h8mT4DIZL2UA/omtEigL900p+gYYyHHTGd1WGQaaD74L9WIRG2zBV4/Pd6ehs0xCYfu0lVX
	cHprPWKbQOrozWEzCam5q9gr4/JVFBJrTIej6lWiyoN+tON4R0BNWMSRZBmMz7I/XUIavT4/FAN
	dI50KNj28glrP57+8Kskdc+YJPJwO3IV75OmogQZ/zPrY3RDOfaivBBv1NHaJ8L0r8T9zogjRZF
	7fBggPB90mhzAAwUNHlDbE8L30hTAS5j9/poE7d0U
X-Received: by 2002:a05:6000:2502:b0:43f:dd40:bbc8 with SMTP id ffacd0b85a97d-45462c341d9mr21397097f8f.24.1778490133381;
        Mon, 11 May 2026 02:02:13 -0700 (PDT)
X-Received: by 2002:a05:6000:2502:b0:43f:dd40:bbc8 with SMTP id ffacd0b85a97d-45462c341d9mr21396993f8f.24.1778490132555;
        Mon, 11 May 2026 02:02:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a6a64sm25368230f8f.6.2026.05.11.02.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:02:12 -0700 (PDT)
Date: Mon, 11 May 2026 05:02:06 -0400
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
Subject: [PATCH resend v6 05/30] mm: page_alloc: move prep_compound_page
 before post_alloc_hook
Message-ID: <6345727fdfa76157ba0518e2148d1848e0bdbc16.1778489843.git.mst@redhat.com>
References: <cover.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778489843.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MNzFMk-0nTfwfUCPRumPo5gfg2XKGKG9LI_JIKm22jA_1778490134
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

