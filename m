Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD44B3BFAD3
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315721; cv=none; b=Fm/gwQ9MRoPPSem/07esTzX28ksVFrDh350dcLCB6ez4zHbrziGKcZenwxsV8fF+L/DTx8MFl9oJeHfPYRXOWlYV7l+uytdYqHZvEi5Ir4qsdWHT3hvvOoM8ZeKO/FeLB+KfQDqayWO3F4mpWIY91eAG9COfFJT9+oRoOvDGYvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315721; c=relaxed/simple;
	bh=NCrpBEyb9BtjGhGhnTsHPNPFOIuuUXGjOyr7FM5hCbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YjWHYh3usCTdRDw+psh6AcrLVDKtioBR+2s0DSuymhDeRNcSo3TYWldOe27ghHWCtHPdfqBZevApql/bVH0WWlmunsKleBX5nezbuEt2Sqt9tePw6yiECHIWSwazumwQMxijyQcP0PSJ9tZoK1J4alUIS+ZKjg/iB7rihBT/rkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FOmWFIeS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOmWFIeS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YBx6SgN438Kse3DYiPhfWEcJAMkqbJwsQPerWAK4QDs=;
	b=FOmWFIeSTS+zNvu8+MauBMQxLM1cANz9iuQiVvPahmES2vXoh96l/47b9NNSxjiDmQ8To9
	/IwZwFGxyldQEWZMqnD1DhDu7FNRyd9lXBaStiJ80YnYfh4ZWdSNvhGqyIuuoJRaGWer2Y
	88VghoU06zeDwg8uu0tLzHu72yHsEHk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-n6MwfV2NN5q2Gv07pfH71g-1; Wed, 20 May 2026 18:21:57 -0400
X-MC-Unique: n6MwfV2NN5q2Gv07pfH71g-1
X-Mimecast-MFC-AGG-ID: n6MwfV2NN5q2Gv07pfH71g_1779315716
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45e73a4f1dfso3758798f8f.0
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315716; x=1779920516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBx6SgN438Kse3DYiPhfWEcJAMkqbJwsQPerWAK4QDs=;
        b=V0MgpjCxLrmWKs84SCKzfo1cMTYqcahiGD2B1AU++d2y4cJT7WGfn4Tzn8KDGFt9km
         rfRfAN1zNdVfBaBfSijkMAVgLOC7+tykeXrzzrbbhe0Y8qWMQjw4y+72REvFoViIMoae
         3qqNPNN8wdUHvORSbmCI5k5u/TK6PcPqfB8N0rTKGETCNLCe4/G2Au8XFNsG5rLaSWKd
         qozeA/QMgEhjZof/7kn2ATCKxaIqNXmXZITVARxLoPxXyyyh6ki7xxSILZkbqfCq8wwN
         2BoWfK2PE64piuT5thAC6jk3tlWtnpE/JB2aWuQVM/Of0noKd0ScW/AYGZX/eZWHI1k1
         xEqg==
X-Forwarded-Encrypted: i=1; AFNElJ+LHKyZDjDC8UpT5/X6IJQTcuscfds+ptakF+to6bPENKl/8cebSSIuKA6zUmyhTjAPHDyOGlJw/9bCisxTDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywt0Xisx3Fehn4cLcBiFNaNpE5cMv1lU470DVcQN+ym++0Sx7pW
	/4hrmR3GB+PZQTKY9L455br8Jj72Sof8FXw0Hxt+tGMpZjnedJ4VOJ8Is/fQ7h2NXW0Z8harfuJ
	bY/44yUZEXftNxxv6I1tU01gjt8Y23KK1SDOXYVn9QuBOnKKN0xfH8WxdoRB47Wd7Cp7R
X-Gm-Gg: Acq92OHf3zO8pUZyv+N/uAW+NM6twoeJHc4vYJ2g2HtSE8gziQNZCDGTonVQJJHvx9g
	poZHE1FqhYPVQbSecEYgwFlHVkFzrPR3ZvtBt87mtZb1nRtJXlKy6vxMlWPYU4Qd7F4m+yZIk51
	bmygsiRF1mdfSdRhUvyffJXkKc6ituJ+JnksOcG9oPnzpf+Ap3L8ZoB7xSi6n4sAiPevs5zTAXy
	0tax2kf+LYBJbGbqWy43UfPO/GWtahPgsYNggs0ucFXMrc0pU2k7rgnpYDI7Eo9oEEF8DABko8Z
	m6fGRppxfOfKWZZfYR2yYPos9JX7iYMs2yHhW4jqVK5kn4dYrqmRV1VJz8oYSwGPBdJXS7LyBP8
	RfX7PbelyCn7sa/5kiLE3FEc2T5Ukr8jjUJVmaYpQarYyhir4W5SpFg==
X-Received: by 2002:a05:600c:468b:b0:488:aa33:dcbd with SMTP id 5b1f17b1804b1-490360c12cbmr2778505e9.26.1779315716138;
        Wed, 20 May 2026 15:21:56 -0700 (PDT)
X-Received: by 2002:a05:600c:468b:b0:488:aa33:dcbd with SMTP id 5b1f17b1804b1-490360c12cbmr2778335e9.26.1779315715676;
        Wed, 20 May 2026 15:21:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035ecc679sm2541065e9.6.2026.05.20.15.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:21:55 -0700 (PDT)
Date: Wed, 20 May 2026 18:21:50 -0400
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
Subject: [PATCH v8 16/37] mm: alloc_swap_folio: pass raw fault address to
 vma_alloc_folio
Message-ID: <00a4571e8ae75a457353726e1ec9111aebf76e31.1779315441.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: a8f9z2NwNBJWLJmHhWH1C9izZXpquAdKWZ11XkaVkkU_1779315716
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Same change as the previous patch but for alloc_swap_folio:
pass vmf->address directly instead of ALIGN_DOWN(vmf->address, ...).

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 75bee9501666..adc228fe3578 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4734,8 +4734,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	/* Try allocating the highest of the remaining orders. */
 	gfp = vma_thp_gfp_mask(vma);
 	while (orders) {
-		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
-		folio = vma_alloc_folio(gfp, order, vma, addr);
+		folio = vma_alloc_folio(gfp, order, vma, vmf->address);
 		if (folio) {
 			if (!mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
 							    gfp, entry))
-- 
MST

