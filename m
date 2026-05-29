Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942193F4DEC
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068178; cv=none; b=FlzZ2+ZlRLlW2foGTnJP0TmIV3GTMc/pn/g9BKfuust/E5ZU0xvDaaac6mF1k6gdRNOk6BdldOJhBzkQwC5Xfibfom7vkHL3DySkJYCVboG4+BNrhr4tWu93CSnSLOKWFOkLn6hz+P80cqVQEJqKFL729yZUDXF3ISPW+njuBWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068178; c=relaxed/simple;
	bh=nrsmIXcyZYzWzlqPkl9t9uUpVmTvW8/nYuSQvt237DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GnTibKQV+AuA0xwmoxK+hrUd7Im2hkZntBFbg/1gdtrjDWoZBB0OmiAIYlA9aazvkDcvnEcrOM+YD7Wj14ykN0TSokdQJPZ+4K57eu6ChIbFXcHKDF7Uk935NhotGSJhkCaSGolZg5bxsTZ7408f0raXeWbPg5aR1uCHbFFWDZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NrMS/+Av; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrMS/+Av"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gi0K9k7DoK/Ig5tkAzEbdYCqiHQSfFH4LjBzL6zaPFI=;
	b=NrMS/+AvGK8G2UU45iMquP7C7KhQCiXeZlRAbzH6ec3m4VlbdMXu6H8NmNPqBK5yH6ZHWU
	gbofqMKvv//7dfSO1a4q/dhDAggAn0SezuQpAY5jKgOu52Vx5qWEvikizj9hMPYzidSvEb
	spvV39dSneHl8hiLzVrGJmqvevkxL8E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-_7tnjPpMOt-HA4wYxm8JmA-1; Fri, 29 May 2026 11:22:54 -0400
X-MC-Unique: _7tnjPpMOt-HA4wYxm8JmA-1
X-Mimecast-MFC-AGG-ID: _7tnjPpMOt-HA4wYxm8JmA_1780068173
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490479c2911so83509095e9.2
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068173; x=1780672973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gi0K9k7DoK/Ig5tkAzEbdYCqiHQSfFH4LjBzL6zaPFI=;
        b=d6tiBtcMoWYoS5NI6H+bjhYPnfBoxdNU1ESHVofSFKWhs+7Flt8kT6x5lLPxbftlmH
         1B2Q9UCnmwRB0BXuTuBXIo8NEaJwKsqy9pLvzlEKW0SDwL2pwlObTCSPpqlwUqQKgLhl
         tPvs/Q6kU98jRk0niaR1LfP0Vd+P5XMgxtIi9cqdhAxBPHYoMfZdAJ18CxaWNOyGxuO6
         RO33s57wEkGSKQdWNWLkKGJbMgYib6w2d9QmQ/7cMAKXEGrgOEYu/Ugru49eb2hoPB9k
         oiER6qwHMKF/ukNq057aTVHJjYff+DYZreYpMquPrq163mCm0Np5GWrjj0cAvT7x96Mn
         TX5w==
X-Forwarded-Encrypted: i=1; AFNElJ/QUOE3KxxqaG429iRjN2qa9Kc61YgHyEWqUNrIeTcGuQ2+yiGYkTjqPG0VWEr3LbjvZrxJaT7q9HFu5Jvjxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjDS/Z07Huh0a2GON6CgN+e5VwJeQE9GXjSsDsB2kWAXJel073
	d79DmHwWxn73YknfcOSTMPoRovIOzQo9L5XD53lvXSnuqL4oMZw3Wji2NIhQ3+WrbZboZwRQvik
	WcDSunxCsVBWXYlJ2JJQ+/24EERo0ldh6h4eTQKIhpQepigatoaYbiMpnoQ4K7NN40q6R
X-Gm-Gg: Acq92OE6wq5t+Y5D3Gx4j2xyf1iWKS9gp8M/IHKFBiG1WRvbU24QzlT1KaxnfWTPe77
	8jcTG0ZJAjL2Bthvsk23DyGbqM8V7XvOjgz3Tym4buqB8dmAI8507ZoKgFMT+29wBlrXGo14cgq
	Irt0gxdUZ4eXCbRenf/ZPdSAD31/5FLLKEK1A62cAKzPfmMdCg0zQ8EEv5U8cdgX7/OMab1l9kA
	fpxDeL0Ij2nXrYDRkwJWG55EQECpKaKTcqq1qVQJNOfPb08bIjriDyfadQLk/FZ+nVDbPHPHS6X
	/IDHHM/cbQtezVbN5SGT+p9nBB+t/dY/KHtLufd7n7QxER7ar1OJ1ul0hRFqsU08QcSxCvvQ7zQ
	ajgBE1WvOcrRG8Q3tIF9ZQccDySBvDJGY2xuqwKD1vWesi6qZFe76+Q==
X-Received: by 2002:a05:600c:4715:b0:48f:be94:d82c with SMTP id 5b1f17b1804b1-490a293bcaamr1010415e9.19.1780068172613;
        Fri, 29 May 2026 08:22:52 -0700 (PDT)
X-Received: by 2002:a05:600c:4715:b0:48f:be94:d82c with SMTP id 5b1f17b1804b1-490a293bcaamr1009735e9.19.1780068172085;
        Fri, 29 May 2026 08:22:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6975e2sm75634355e9.6.2026.05.29.08.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:22:51 -0700 (PDT)
Date: Fri, 29 May 2026 11:22:47 -0400
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
Subject: [PATCH v9 09/37] mm: hugetlb: thread user_addr through gigantic page
 allocation
Message-ID: <cb0902af6b75ffbba69d091189090b9850152ec7.1780067977.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: B2grmq0LezrXTV2Q7YvNpnKB8pacgSkLOTXxUE0_-UM_1780068173
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Thread the user_addr parameter through alloc_gigantic_frozen_folio so that
gigantic page allocations can benefit from cache-friendly zeroing.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/hugetlb.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a999f3ead852..3a6afbe99116 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1375,7 +1375,7 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 
 #if defined(CONFIG_ARCH_HAS_GIGANTIC_PAGE) && defined(CONFIG_CONTIG_ALLOC)
 static struct folio *alloc_gigantic_frozen_folio(int order, gfp_t gfp_mask,
-		int nid, nodemask_t *nodemask)
+		int nid, nodemask_t *nodemask, unsigned long addr)
 {
 	struct folio *folio;
 
@@ -1386,13 +1386,15 @@ static struct folio *alloc_gigantic_frozen_folio(int order, gfp_t gfp_mask,
 	if (hugetlb_cma_exclusive_alloc())
 		return NULL;
 
-	folio = (struct folio *)alloc_contig_frozen_pages(1 << order, gfp_mask,
-							  nid, nodemask);
+	folio = (struct folio *)alloc_contig_frozen_pages_user(1 << order,
+							      gfp_mask,
+							      nid, nodemask,
+							      addr);
 	return folio;
 }
 #else /* !CONFIG_ARCH_HAS_GIGANTIC_PAGE || !CONFIG_CONTIG_ALLOC */
 static struct folio *alloc_gigantic_frozen_folio(int order, gfp_t gfp_mask, int nid,
-					  nodemask_t *nodemask)
+					  nodemask_t *nodemask, unsigned long addr)
 {
 	return NULL;
 }
@@ -1862,7 +1864,8 @@ static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
 		nid = numa_mem_id();
 
 	if (order_is_gigantic(order))
-		folio = alloc_gigantic_frozen_folio(order, gfp_mask, nid, nmask);
+		folio = alloc_gigantic_frozen_folio(order, gfp_mask, nid, nmask,
+						    addr);
 	else
 		folio = alloc_buddy_frozen_folio(order, gfp_mask, nid, nmask,
 						 node_alloc_noretry, addr);
-- 
MST

