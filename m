Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331FC3B1EF1
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907772; cv=none; b=WST95/7fkKQvvyT54RU8aAAaAx99VfzGHFYVGeTvg+PAz1iXom1AkSVzNHxuAMYJkzPkH16jiDiTNvtVX3tVDyqhW+gWmvfZbM5WQ7G7XH6nStQCv9EWQuC297CAHU7hxsjjDeNr4z1haYPhQNrf7VJ9XWLW/OknAgg+vpCsBPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907772; c=relaxed/simple;
	bh=vsZYN921BalqZjT91Mi+kZYvPDWSYuKfHJCbMesIOlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tOIWluNYS6EBSFkg3l88u28NFbyg5qEnma4uKJj1IuUYU1KOA5pHbq8/t11+VjIib7M1JZ2R8j7UoLZPPg9alVfV/Q1c5GBIBeN1Ou8SNapI06Wp7QfFm1bt3izdgbxWyE6kslLoBvlqISeCB6aSlguXz33QcrqoeqIJDRc8hh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bPGpzErd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPGpzErd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hi0+oeNecn4eOEAyUzBbvo1srbN9H1YpFSy6pKNCWwo=;
	b=bPGpzErds6FSQ98XFDWl5Aa7Z5tMKZsOnMGhTCu+rQYWzh+vlu2vqzaz5De5o8bXO1tGIv
	nIcuDdtLmY5PfwivCE44HVGFFLS/3jd+TVfV8t6SMtA41a3l4AwyI+3gxwlXrcMgrd+FmN
	19uYXZ2nmWW0nwlL0pZtn8SnxdLmAdQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-PsewwbjcNYqiCqY9Pbkl2A-1; Mon, 08 Jun 2026 04:36:03 -0400
X-MC-Unique: PsewwbjcNYqiCqY9Pbkl2A-1
X-Mimecast-MFC-AGG-ID: PsewwbjcNYqiCqY9Pbkl2A_1780907763
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef6b407b4so1651250f8f.1
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907762; x=1781512562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hi0+oeNecn4eOEAyUzBbvo1srbN9H1YpFSy6pKNCWwo=;
        b=Dsi4SO72VvWRvE5pvDJosesTnc8Elf3KYNR6bIVyFFsYHTg7b5r617P6Y2cvfYs95k
         c3RrqgW3wVLrtguB9Vwkzv62Vw0m8fBALaFEPK1NasFjgvXX/tut010yiyaoDivEdQbM
         k0611tX/KvMLf1RCIlxd6mt8MhTTuv3HtKwxmfqtliaZYiIWvhDN2nE0oB6IErJn69/I
         +hIBr7+W8XbjTbpzNBj/C4B/NaAgudGBgJhuZDEpNDHMaqPjLCDLpjsUPJHeU4zbQgBu
         tDp00u1lS78FeDo7Ml5IVCFk4XvKNXreGIHNfY1JRidoBun3SOob91c4XcF7pAqud0Ol
         PpTw==
X-Forwarded-Encrypted: i=1; AFNElJ8IFvrTTnGFr7g7x4fLpEuypQYewX301jiUwdD84ebygSZ8jUI9SQhBIXFGd0ekcmfFYKs1XkNqZaUf7OTRag==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx585koVWrv5qJaVQ9wUxzrybzYK1JQShKxjwBaeDrvGH5dL+yy
	g41Et5hWpTBtDbUzxdHwOMucBrQnhXlKGp+t5kq82VlRFUERfQ52OBEtg1W/wNjtnr0TXqDv5dG
	BGgmA3MpjfGgOUUmOgh4JsGS+P+olvxAaI/TZv1OQUuXon5ig/fNskcXjwb2/9SzCuY+p
X-Gm-Gg: Acq92OFwGI81hAHgJNth7bxsAOhVP6nmE11J/QCYam6JbjzAv2lE5l93iCPeaGYNnvL
	x/8Mcm9XvrkyCW3hgha3p/MTSvCJWCje2FS2d1BHHw1hupubNXFlAxjopAdmFtA8iLgQnO0Wt6O
	//FIrO2jJneS6rXRJ/V/wOkanqOskqjieCJTrQ1xCeIoqiJ+EIGUUGRdGbFcvjw47ja7qP4BSAU
	KjTxwTe8GXuM34O/KIWHCmpFX74bP2zk35D9R33bB95QBs5kUdxgmjTUi6f2cEIbXhtIJlgRzZW
	fhLm1FUSCiGgoHODO5BEng6uUzbHE2ESDWJm6PWn5p7atzJrBaWBCasnofvNwTpT+LVMg9z4Aae
	3Fc79+dUSJmyfybxa4B+c8aQ=
X-Received: by 2002:a05:600c:6096:b0:490:b115:e03f with SMTP id 5b1f17b1804b1-490c25ba56cmr240971635e9.8.1780907762503;
        Mon, 08 Jun 2026 01:36:02 -0700 (PDT)
X-Received: by 2002:a05:600c:6096:b0:490:b115:e03f with SMTP id 5b1f17b1804b1-490c25ba56cmr240971115e9.8.1780907762056;
        Mon, 08 Jun 2026 01:36:02 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2c9ea37sm425199295e9.0.2026.06.08.01.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:36:01 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:35:44 -0400
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
Subject: [PATCH v10 09/37] mm: hugetlb: thread user_addr through gigantic
 page allocation
Message-ID: <c52f3d4252a63ac75ef7eaf07c1ee65784a3024e.1780906288.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: I57K4D9doGANAZy2gV0p-uv8z-C1jDBVv0iUrLizOvA_1780907763
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Thread the user_addr parameter through alloc_gigantic_frozen_folio so that
gigantic page allocations can benefit from cache-friendly zeroing.

Note: the CMA path (hugetlb_cma_alloc_frozen_folio) does not
receive user_addr because CMA uses alloc_contig_frozen_pages,
not the _user variant. CMA-allocated pages get zeroed via
the normal __GFP_ZERO path without cache-friendly addressing.
This is acceptable: gigantic pages are rare and the CMA path
is a fallback when buddy allocation fails.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/hugetlb.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f3bc15a7889a..5d7e546565f5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1355,7 +1355,7 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 
 #if defined(CONFIG_ARCH_HAS_GIGANTIC_PAGE) && defined(CONFIG_CONTIG_ALLOC)
 static struct folio *alloc_gigantic_frozen_folio(int order, gfp_t gfp_mask,
-		int nid, nodemask_t *nodemask)
+		int nid, nodemask_t *nodemask, unsigned long addr)
 {
 	struct folio *folio;
 
@@ -1366,13 +1366,15 @@ static struct folio *alloc_gigantic_frozen_folio(int order, gfp_t gfp_mask,
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
@@ -1842,7 +1844,8 @@ static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
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

