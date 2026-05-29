Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23C94218BA
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068220; cv=none; b=JgoQXepJo8RVjCL14X/o/PnyRJK9dHsztwshEKuT1D4ido14XMb2hNxvEey2L+wwp8l5js01eGw5AA8RQqRAjWnKrMqcQIzv7B4D9WStMRIw8UlTmL3o/vx5AQcGCMxKS3rF8Vh1ezE3m5bDr22qjlr1+mBDQWFzK5eUTDaQHrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068220; c=relaxed/simple;
	bh=OWZLv3RcZNMXBK++VDzgdX5Eo6g4iZLM958nD4m3nTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nUfIVfRY6WW1CHD2vP4jBQvTqXjbTs53sFnGecIFlKYr9HwrfuPp+sXqMSnxWYO91cJnniUoj7cvtraLFYzOyecAG30Le5SXQDccOMA/2+l0dkhk3RWuwlTn9OmXJL5KHhmIGnWvpkhMo9k1LbucaBvQZi/F5P60uUS0aTT+DQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQeqNzRo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQeqNzRo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JxMX/pzMUOtdSR/DFO8X8z+nr68xKXZK5hfRbiRHySU=;
	b=DQeqNzRo4y/+kHxJuj8wduNCkZxFW6vw3ruaUq+XY5TGBfN9L7qE34iGxOf3b4oiVeCEDJ
	hhCxZEYkDgMugHl/OMLt9ccn4lqUGw+91F8dllfflNmn5duyrvrQR+8gvRQ1XvhzBqCJxv
	G09KW7yuWHvfjJgRTBBnDzOQLEwWL/Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-md17IW4oM_GSJI2OtyICHA-1; Fri, 29 May 2026 11:23:37 -0400
X-MC-Unique: md17IW4oM_GSJI2OtyICHA-1
X-Mimecast-MFC-AGG-ID: md17IW4oM_GSJI2OtyICHA_1780068216
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fed2519daso66351305e9.0
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068216; x=1780673016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxMX/pzMUOtdSR/DFO8X8z+nr68xKXZK5hfRbiRHySU=;
        b=lVNR5sZp5kZFVyVQDVTbvRa10Q1CRhpcp7l3lI8JqlFxK679eV6hwDIiDQafRUVrDi
         9fkyWUh+gR8EYXTEhUJsE13Qlo/bhnjfApqr3QFoypMDtN+gwOwS8QjxCx5THXCQiLU4
         9c0x+YgemvKxuNFhQ+9kh24xW/X1Y7TAzB6zxpeYZ5wdaGhRV3j+qYvfrhyhKUDgBneE
         w38v9JnOoZgFDNzc/tGpuohPga26vZHPLof1QX5uBRUBlfJtTZcqBLB57NPQGc0Vh1K3
         t5r4W4ndRYGr8mQ9itHA2GKxT+yRX0Q8k5O9pEA6qVrhNjSYzaJhzifCQpjBsMGqxMoB
         MDDg==
X-Forwarded-Encrypted: i=1; AFNElJ9LQrMvSbuXf/oAdPSht2Vp4XL11+xhC3wMuvQayERM6HCc+AKlxsNnDrIh2A83J1spRjr1qTeIjG5hM1Qz1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlV4/N79ekJgrd0tcPH14SDXT6ABDj3EOawBOnWy3+n0NC8/S9
	ct0jMJshNKLB6JIO9naZorArT/RMS13FRtAxQd/9a8we/M4JG1z8qlKp2+iGKDinWai0zO5/w0U
	5Kb1wCfUyL76i8yeJJ2NOjupPV+BfqtTidA6lcZ6v7oIbJpQk6dvibAkPUFyfUhtgknW9
X-Gm-Gg: Acq92OFG0NWhJB7qeQyx6LgXjbhPangbudWN3yqLKDX6OmmadOepx64tlOUxtYcM2e2
	JBcnAPrTn24CrF5Pgo0+LY0I3yY6OoQYINRNAO15YWQtoYhuG8I1zbkMJK/MVtC6w/zx7p9wzla
	5i8qdji7EOsEsNYs9onsdb3DQRJffE+Ka/DXmcmV7CXm50YrEYd83oPDP8Dpx8Ng7eeb1I4FmiF
	FWHhv7DyRFt1j8J4cofLozprN4g3fVydhCX+PXAtVGHakOoPqBRuZlOxtomVgWWZsAdE8Wa+TX8
	hvSA0MVE5X/Tz489r09tlPjHdr04AK2cmigjoaGtG2aSA1UHuNirfrSuS+wEgDYLZ2QPwUGEZsn
	p/YFTqvniwWH7s9lHqSta0ZOyn4jHBwP3M5nIvVSjXuqA0FgEjB5edg==
X-Received: by 2002:a05:600c:3587:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-490a2941425mr1584535e9.29.1780068216235;
        Fri, 29 May 2026 08:23:36 -0700 (PDT)
X-Received: by 2002:a05:600c:3587:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-490a2941425mr1583165e9.29.1780068215553;
        Fri, 29 May 2026 08:23:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909dff2a80sm52414665e9.3.2026.05.29.08.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:23:35 -0700 (PDT)
Date: Fri, 29 May 2026 11:23:30 -0400
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
Subject: [PATCH v9 17/37] mm: use __GFP_ZERO in alloc_anon_folio
Message-ID: <b2e1b8ea0c076e0a94a31d0a50f192f6c85e8ff9.1780067977.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: uniTRlS0fYxYgKRk-EXnmQqrP7SjrtgxcF4_nFzBVK8_1780068216
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert alloc_anon_folio() to pass __GFP_ZERO instead of zeroing
at the callsite. post_alloc_hook uses the fault address passed
through vma_alloc_folio for cache-friendly zeroing.

Note: with __GFP_ZERO, the folio is zeroed before
mem_cgroup_charge().  If the charge fails, the zeroing work is
wasted.  Previously zeroing was done after a successful charge.
This is inherent to moving zeroing into the allocator.
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-4-6
---
 mm/memory.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index adc228fe3578..895ac72121fe 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5249,7 +5249,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 		goto fallback;
 
 	/* Try allocating the highest of the remaining orders. */
-	gfp = vma_thp_gfp_mask(vma);
+	gfp = vma_thp_gfp_mask(vma) | __GFP_ZERO;
 	while (orders) {
 		folio = vma_alloc_folio(gfp, order, vma, vmf->address);
 		if (folio) {
@@ -5259,15 +5259,6 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 				goto next;
 			}
 			folio_throttle_swaprate(folio, gfp);
-			/*
-			 * When a folio is not zeroed during allocation
-			 * (__GFP_ZERO not used) or user folios require special
-			 * handling, folio_zero_user() is used to make sure
-			 * that the page corresponding to the faulting address
-			 * will be hot in the cache after zeroing.
-			 */
-			if (user_alloc_needs_zeroing())
-				folio_zero_user(folio, vmf->address);
 			return folio;
 		}
 next:
-- 
MST

