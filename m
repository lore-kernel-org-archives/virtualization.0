Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA053CD8B8
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489674; cv=none; b=IO5YE/jkIR1wDni5dFxzFwiTVwgo0lR2HuXqL3LHwz2EIFKLDYXkZhm2ICou0/W2dXeach5LGvAsrEmEjFjJeT0NXeDKAGN0bvuSDN0HdwLrNA09NBHY5h0uM5AipnD8L0E0wX6fEVmtDifuofM7XMqCOgxOk77rC809WD9SihE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489674; c=relaxed/simple;
	bh=tkchtNB3GzzFWMQ1E0X1DKUjhQK/O579SYT7H3vP5sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=guHpBEsuEz6i1jfKjHeFgXijMWni3cSsJu4pO/+AHVr1AFQYVYw60NpLxaBhw8bV9y8d8F5rQTrT39NP1aiN2KATdnChsEKo3Oqw3JBFsaWtvRLsLxxE3lyFdMiTqkHojecbTtY5wmTUBgL4jKBq1JClkbk+/qi94IshwX3w1ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DKm3U3g4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKm3U3g4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778489671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43zcPeyEBahcbXzXBePbjbHiq0vh8NFM/GDJyyFYelY=;
	b=DKm3U3g4cOzdPmFnYpPO85gPh+4r2uQr+xE9prnGY1epa88LFjzkd4ruf+TWrRv0w9ARIi
	Q3h1YuUUf5i8PNf3CAld/FBnI8cKHn3n6JqhXTX8g8t6UN+UpjM9FFvEAjjslP3C9ckeQm
	PZRtGGif/jy9HRyiKtVD4ALIAiIfil0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-pKNcH1UCPPGaGDjhuHTq5g-1; Mon, 11 May 2026 04:54:30 -0400
X-MC-Unique: pKNcH1UCPPGaGDjhuHTq5g-1
X-Mimecast-MFC-AGG-ID: pKNcH1UCPPGaGDjhuHTq5g_1778489669
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48e5eecd0aaso22665445e9.0
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 01:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489669; x=1779094469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43zcPeyEBahcbXzXBePbjbHiq0vh8NFM/GDJyyFYelY=;
        b=M1Uww/DOFoPw5PT9azyuqTR/qXaZfRfDwBO2WpvhdJZk9q75binI7LqsDz15WOxDTh
         z/EFux582fkzs5gMGvh8uWdqD7+uaVsorzvIXwhJ4YVBxc9FMX0NENyCHVx6YW89l7b3
         dcL/PGN3ToQIDG5sk22gh0RV5rHnGs2ra/6QrYH+nemAz9VEHPjAwNS9UKnoWhuj1E/A
         YBhcuQCjP059wqZipnnPpADpLFmmeMEuxoV57EDGp74zYJemsuAlR4pIy05YUGRfmvxe
         EzAIimhJ6E5rWqoB9SlsQVW6gVh/+tcd9ScII4nV3yziA0GV5vJtBrOO7HbzREu2nBSF
         JGkg==
X-Forwarded-Encrypted: i=1; AFNElJ+/NXK45fVQii1meFhQEIg0Q1LH7954vetbR9/GqC9QkJaf3kEEqYXe876s9tMBGyf/BOTKXd6qKlJpxyQb7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMvAxwCflysp3L+nVkbyoTQ56+TOuW7Rv/ucJ1I1HuyINmMZ9c
	xlPhwbkKA4hzwUc0hMuAeWPaRv7TTifwHhY/duu9bzv8ApT/8hj4ysi2SU7zOsgzcqHK/KGWaNr
	UotCZHvXMXCq8S59jVR4H2YJmJKLozCZxx1bgy/fceuXscG7M+pQQQviAhrJdYiUC/Tx+
X-Gm-Gg: Acq92OF4W0y1VDGds0gAh93ZC7BJMMq17u8McdNKq76lb1ni1c+MtMuD9G09lL1AUnP
	6N+n07yNOm/zYJ5hZnEgIKwKMOygh2OU7a1G7frdnp4YBxWQyFHf+/BZeM+zDRL0mY3rn4WQVuw
	pAvz7tcHTttOv7QlIkO5EJNe+/DD6rOPGdQgJUYAvuJX/NCmsnmhLsGpNIuVy5ss1PV7ACKVSZ/
	U1N99GHoP3xc8srfRoYCtVJyQX6/Wkj/veYWImNppan1wJbvh/KZDuhy14FKvPJdLaacQLjVuMZ
	Sm5TIlpE3T20uYcPVDrPUoQ7w8XN5LaJg4I0GVmJ8rrGcLHxc/mg4TU6qSjFrDCLJpiu6bDjZpB
	JcKnUnY/ZE1JWnwPBKI9UfNxI3DPtGyULYnfOVJaq
X-Received: by 2002:a05:600c:8b57:b0:48e:75fd:9f9e with SMTP id 5b1f17b1804b1-48e75fda826mr127047895e9.20.1778489669215;
        Mon, 11 May 2026 01:54:29 -0700 (PDT)
X-Received: by 2002:a05:600c:8b57:b0:48e:75fd:9f9e with SMTP id 5b1f17b1804b1-48e75fda826mr127046835e9.20.1778489668599;
        Mon, 11 May 2026 01:54:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d8d30dbsm91516415e9.1.2026.05.11.01.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:54:28 -0700 (PDT)
Date: Mon, 11 May 2026 04:54:23 -0400
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
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R. Howlett" <liam@infradead.org>
Subject: [PATCH v6 13/30] mm: use __GFP_ZERO in vma_alloc_anon_folio_pmd
Message-ID: <c8768c7c2a4965b5e2dd78680c936b82606cc034.1778488966.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: _Gwjiqw8B4yPT_UX4LisjDYnYnM7WdEOHy4O-y4ngDg_1778489669
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert vma_alloc_anon_folio_pmd() to pass __GFP_ZERO instead of
zeroing at the callsite. post_alloc_hook uses the fault address
passed through vma_alloc_folio for cache-friendly zeroing.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/huge_memory.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d689e6491ddb..9845c920c29c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1333,7 +1333,7 @@ EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
 static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 		unsigned long addr)
 {
-	gfp_t gfp = vma_thp_gfp_mask(vma);
+	gfp_t gfp = vma_thp_gfp_mask(vma) | __GFP_ZERO;
 	const int order = HPAGE_PMD_ORDER;
 	struct folio *folio;
 
@@ -1356,14 +1356,6 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 	}
 	folio_throttle_swaprate(folio, gfp);
 
-       /*
-	* When a folio is not zeroed during allocation (__GFP_ZERO not used)
-	* or user folios require special handling, folio_zero_user() is used to
-	* make sure that the page corresponding to the faulting address will be
-	* hot in the cache after zeroing.
-	*/
-	if (user_alloc_needs_zeroing())
-		folio_zero_user(folio, addr);
 	/*
 	 * The memory barrier inside __folio_mark_uptodate makes sure that
 	 * folio_zero_user writes become visible before the set_pmd_at()
-- 
MST

