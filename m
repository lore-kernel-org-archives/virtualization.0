Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DF13B8958
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489659; cv=none; b=KwJeVzzm+6AVZlnxEewE+coliK/qyAFceOyCrXk3Epo8pxdWHo9J1lx0OilFuE3tM6RpMWFMi1iPuAJ/3LXeQ3w0euvF8IrP/DGfhavfx8fxH2VkIM6msRBXXIFzn1V0GCm/UYBy1gGFybw1A9+xVsIuAx+jsRc2gaXa3Nb/k9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489659; c=relaxed/simple;
	bh=tkchtNB3GzzFWMQ1E0X1DKUjhQK/O579SYT7H3vP5sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hD71NXVnMGPbCQqMO1Tw4xBuLmFaYCeh8JDDgCwz32EuHXnk9S+utdVtmWydU0SQ6hUS7G0i0lcmIDp2rJ3413/vnT6lbwgxnjSJOE+yFWC2fpI46QVFX897EyAcovTZwIh7l/ErzWrlq8CwAggd1RiR/ZwWJwNrOGwCsZIejDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FQ4Yz4k7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQ4Yz4k7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778489657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43zcPeyEBahcbXzXBePbjbHiq0vh8NFM/GDJyyFYelY=;
	b=FQ4Yz4k7FlLZGMBn3c3i6E88YXsWbKYXLdfq7v5XecAgjIb6TBzxo/TEvVSmn2UAdcjqF2
	JKN3OwooHIuqCQUnXX4x7pir26rsD+bWWHizkPDt3LNDUP3e/VAft4vM94kwhGlRXEgBJW
	msIifDQNidyviDq/3P+RYMpu5eyv2OI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-EB8w9kd1PHmDIw5XypuOGg-1; Mon, 11 May 2026 04:54:14 -0400
X-MC-Unique: EB8w9kd1PHmDIw5XypuOGg-1
X-Mimecast-MFC-AGG-ID: EB8w9kd1PHmDIw5XypuOGg_1778489653
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a589c7879so38687995e9.1
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 01:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489653; x=1779094453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43zcPeyEBahcbXzXBePbjbHiq0vh8NFM/GDJyyFYelY=;
        b=ndCTOMDWUxqdHXlOP7ZN8rVXpG17vzDa07hTtIMj8sXd5/8KFtbMtHkCTwwgxVBc0g
         OJTKwgr9iH780Xb1Ef5o9UEjne4zrz3vykkNE6uF0IF73bI6dUAhfdLmB45LVZabCa86
         UkVpuNTUN0QNtKeDbZpqivZX5XLiVF1TdG1WJtMd62FKl5arDffsyfWMfTO/FRISJAjj
         ls4CayG0LRPVeZ03Um9t/ssNSM+6pwoh7+Kh549xnMImuSWDvpaFsQM5sCic2wVAZ4yg
         6YkuiyuOe1SG2hBCtP8wjx2lXgk6E+H+PAkBdWeN4jsUV2wCtheqqhwCqp3/eUXf0Uw6
         uvcg==
X-Forwarded-Encrypted: i=1; AFNElJ9sP3bgqL64Ezk73STaSsndSG5FuC+pan4XQlISpqgpELJbUNvt46iWv3QRPyATwsSZNoEN2P/G5jTghJUdkw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywe0mRR8tJcX+bY03wSIY3IOEDF2QZZXdjTk4k31UvL2grcXxTC
	c7E9HDWufWQWDObrUV58d5ICT0kINlPhpafSSXt+xCnPU32dFjTna2MFo6BcEWtd3OxRvXj+Fc/
	w7BOeEDmuGAjCIn1kdlx1/eO9kEaBCfM9MziuHU3of4ozBeLNSweSkWPagHcYtaBnv7dT
X-Gm-Gg: Acq92OE0NfgxIkg1Ei3PAyGZckvhjg4uxfI5LVDxLxT0KvWu0EiPRo1E61XKEqo00Tu
	sT7spy7bOOBQDIx5QIbauM8t7iCX2NeSXxp0ewCKyJ4ypX8MaB3zCE7UA3AtrKFSUR49DIEihpD
	54M0EScGraI5pM/P7tjL0yGaQF04wZEAB51/GeMa2wpP1nrpL2A50BfpKN4Ifm2JBfAWsGUDdAe
	OO8o/sq0d1TW+k7EduWp/b8jLYOHC7GvZdh7MtUyAnkxMExBZ3z84w/W+In9lh+RmWS0vH+Uuar
	RQWnn7BgwDT3oZc0a3JZFwVya5fSgtOTFbFxvDZ0ak/0AoB6fWTMwTsHEuxEEAggacbE6e0OwyK
	5P8v3IBT6SxgVAuRmxWouFiCFHTvcFOogRepjfWsy
X-Received: by 2002:a05:600c:8710:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48e6d79b006mr166663815e9.8.1778489653294;
        Mon, 11 May 2026 01:54:13 -0700 (PDT)
X-Received: by 2002:a05:600c:8710:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48e6d79b006mr166663275e9.8.1778489652743;
        Mon, 11 May 2026 01:54:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702e5614sm174868625e9.9.2026.05.11.01.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:54:12 -0700 (PDT)
Date: Mon, 11 May 2026 04:54:07 -0400
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
Subject: [PATCH v6 12/30] mm: use __GFP_ZERO in vma_alloc_anon_folio_pmd
Message-ID: <709da61903c6e395ea51caa48eb5e5733d2f3d49.1778487000.git.mst@redhat.com>
References: <cover.1778487000.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778487000.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uaBvGIJcXnz_iXc1XDkscVVqss5RiO-I_5_OMihfEe8_1778489653
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

