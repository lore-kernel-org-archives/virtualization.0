Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA2B3C345B
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315736; cv=none; b=fs33o+DoQRYQhBHYdP6DRb6T3xWX51Ow4l818YS2Uj483a77BlukCH4brRIZRiwCpTnPhSASqt1vtNL6w61bDUtsPM1d9H0pebSyR3Lhk5w5D4eu3bKjYp5DYFA00ikT8BSf5AXGxGq1zafrdCKqIDUKWBjoMrGIUig3jdoc0Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315736; c=relaxed/simple;
	bh=+9Q5fGlUrZYlSCWgLoOvdSgXnGUe3WMtEgfY+DGuKBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qTf8397QX4CezYKN6KSoewIrmJQPS+0JGubB5mbjm5JZaN/EGiMLyXOiT3iw63eWEmFKBjKY3CQTjqrLSOtN7FHbCOzVy9rZcKf743s7qAoQLMfGT/qCUnW/n0O/oceR+ynwT7XT3mQUpANjMBYrPK7aqMDijXLr/m013S2vcDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gcZ2T4AC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcZ2T4AC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwGlO3yG5EtH2T+AQMoYdXPNyVEDsUWFS+ozJXrj1vA=;
	b=gcZ2T4ACk2BL8KCO2q7IvGLy6+4O/uAfZ8JANfTpayir5/H5Op7cbFrkrge8LlPSsSpyg5
	LEwHsaFOILu5ow8XcxMEuZrdF7XCLdn5+pEQaIa8LCuZgZ2lbnca1qZzCd+gk/xFYA9VQS
	6HpasHKHN1Krn2jX010QkGUK7G7UPgE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-0x-Iwk6wNZ2Um0wZEx24fw-1; Wed, 20 May 2026 18:22:13 -0400
X-MC-Unique: 0x-Iwk6wNZ2Um0wZEx24fw-1
X-Mimecast-MFC-AGG-ID: 0x-Iwk6wNZ2Um0wZEx24fw_1779315732
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45e81291d62so3752484f8f.1
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315732; x=1779920532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwGlO3yG5EtH2T+AQMoYdXPNyVEDsUWFS+ozJXrj1vA=;
        b=MR0vPZHyiq5TR+Jy918Uriz6MXRRIv9fUDgpNA+YGv0/oQQhi/OQ6g9bIUl8RpP18a
         GbrQxZvkFi0U1pq0Gi5/ttIoMUi3J8AImDyWiJHfhwQ9fzai1Q7vPoEE30v2tD+J6PgE
         e2hmcN2iXkP+zZe5U6t+CPkDW4lUQaB7ott4mpU/RHVRHhRNP+Rl45Jea2Ftfzfg4PJ0
         h1iIYAZXlHjHdrDrvS/Wbv39p3XCcAcnIyKKJj/CDSz59B6LsK8zgrh8ZjB9zPpShydw
         Hl/R+3jDT6Dv/j+kV+kjBu35z/kg28GlN+rGJ4l+92Si/NYA4yP2laU+8+lx/h0+sX7r
         lUrg==
X-Forwarded-Encrypted: i=1; AFNElJ+SruP4HuBl4AdIK3GoMh+WERiESYThyeKGjr2tJlHsyXqyaFJB1PXhW91M5FMRRoku1Pg/i2QKHYrVRmW6Qg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDjdARPsGg3rOxv/Xhq7p9tBYTjLiXKx15t9lXlaUZal/6pqTd
	q73wAXUUlcuO2I/M/AKOWjUQ+wch2l1AL5/al35q1QDC7WfIcaXIxUmSNaDpdes5pbQ4r/NlO5X
	2kvZgcifmEkraDmoozlLmGIJGBnjV+tjk7WTEpbdTn45ltf+Yk+m+0F9OS/k2UJxwrN6X
X-Gm-Gg: Acq92OEqMtgUt3SGG8YdtCCmTVx/8O1nrQ0RvCwHmmNDjz9eX9CeKNFyBi35WOvOeZi
	0QZFgcOyu99XXV7WWk6qq5fp60KxH7PnCKS1b7eirVlzzBEGR1Ry1OdQjMQDF0rhMqQCg/tfBN7
	Ef27JaLk+xmEkdxLbfTgL2hTE38wgkGByPxwKBjQ5b2s65KAEab6/MwRlLakTw3AppDUBotxEY9
	1v40GV9anppzYt6Y+PJluuqXl4dCiXX61GRPwj85TEtw2azvvKyULD4Vd0ngUbh8RK9UWQX7AW7
	1x5Jo56B5vZmlDjkaGLPboq3chZm0m6r38JAocqaq3U+Zk9/vE3mu+R5Hj2jgkXdqHCi2bnTXwi
	uf+3259Ding0zWk0AneqQzmjfPhLwaI4gW7x/DGcMfzo=
X-Received: by 2002:a05:6000:402b:b0:45e:73b3:8118 with SMTP id ffacd0b85a97d-45ea3bee76fmr278646f8f.29.1779315731712;
        Wed, 20 May 2026 15:22:11 -0700 (PDT)
X-Received: by 2002:a05:6000:402b:b0:45e:73b3:8118 with SMTP id ffacd0b85a97d-45ea3bee76fmr278599f8f.29.1779315731226;
        Wed, 20 May 2026 15:22:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19b1dsm56913999f8f.17.2026.05.20.15.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:22:10 -0700 (PDT)
Date: Wed, 20 May 2026 18:22:06 -0400
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
Subject: [PATCH v8 19/37] mm: use __GFP_ZERO in vma_alloc_anon_folio_pmd
Message-ID: <0ec029361949c492b10accc8cd787aa0d2fef0df.1779315441.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 2UtLPb5-48QsqO9DG2b_wXGWDqpxjzIaApnGnpsfTmI_1779315732
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert vma_alloc_anon_folio_pmd() to pass __GFP_ZERO instead of
zeroing at the callsite. post_alloc_hook uses the fault address
passed through vma_alloc_folio for cache-friendly zeroing.

Note: with __GFP_ZERO, the folio is zeroed before
mem_cgroup_charge().  If the charge fails, the zeroing work is
wasted.  Previously zeroing was done after a successful charge.
This is inherent to moving zeroing into the allocator.
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
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

