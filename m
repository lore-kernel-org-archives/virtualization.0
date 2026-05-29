Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A030241C2E8
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068215; cv=none; b=TS3QA3X5ak4vBLF95CLsb2Hbt8LEJ0U7ffhNVq8jtK+Z1MRfMn4nKpurHCDlv7JcnDJ7qKr3g+51LcEBOHuYw0t10RiC8h7IZ064LYOfYVjyKdttJJJpfZ20zcx6rnjRgXmmD0Jb1xYxzvVXkFcZ3wLwcBUuIVq2ZVcE9e1wg2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068215; c=relaxed/simple;
	bh=NCrpBEyb9BtjGhGhnTsHPNPFOIuuUXGjOyr7FM5hCbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OHkFu0zAUYLIZGgYrcsdnzmMH+i/eOhM6FB+1dCoIgiAglPckza7YPVw+DoXx9jS0Hx+1Gr7eL/+e4hb+OqKvmL1aVEGmRDKFRq89cKsU9EvBXyrrS+lFrAvW0p2YoP0hS6FhbLUVEetHZOfE5LpzWpVWUQFPkgBaxbRravo9yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z6hsLO3B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6hsLO3B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YBx6SgN438Kse3DYiPhfWEcJAMkqbJwsQPerWAK4QDs=;
	b=Z6hsLO3BMe8klH2VVDjVJXVVnee73LsklJ2YPGaMPx7LZjO+oVOV9QchRHM9NoIZZO2tm0
	6pfRslmQzACOIWUUEyBTP6XOQg3dsedstUGSlmizy9N+5vTv1V/JssFYxR08sQ7ITj/6lZ
	vnqWBwDjtqvpjra26wa1L7NIRn+NG5E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-b70jrE3CNkOjKBPaWAmu9g-1; Fri, 29 May 2026 11:23:32 -0400
X-MC-Unique: b70jrE3CNkOjKBPaWAmu9g-1
X-Mimecast-MFC-AGG-ID: b70jrE3CNkOjKBPaWAmu9g_1780068211
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef3c7073eso483525f8f.2
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068211; x=1780673011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBx6SgN438Kse3DYiPhfWEcJAMkqbJwsQPerWAK4QDs=;
        b=hpsb90aelSYVlQx6TflbMAypV4L3h+IbH0dD3F6JLasRBS9ZLwQMTiGxwdkv3tuoZk
         6Ib7tFR9JNPTAaR55IWlguo0cHA2/GBpAZbEQ2EYBWYgeK6El/PFn3ADYJA2iti8vTO9
         CoD3tLAN+xcRUj9B9mzMf+Mdrmv1rM1bdAvSQLIN46nt80UiYfARNSPjS0jplzMvZZN4
         6VgnnS6gxrlE++0Qo9SiYVSl2iPv45y/lfIh1lYTZ/QFWSgG8NwaiBc5870+ahCYFn0O
         GaD/4C/gTgOIy9HuUD5J5zLzkAGC1EeBsyI2hU80vlvZnPjJnLc+ALj5GTF+84iP+ZBd
         j+EA==
X-Forwarded-Encrypted: i=1; AFNElJ+pxNe2L8dOH5o0RJBvogO/iwLULYQ4GpliEMowut3gymbyG722QTueKdljyEJ6njYJCnxPPWPvGyGdDYagtw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUI/2nViJeknbWT7SKM4kpcwklhEVqWwGv9gseqjrwk7iuS4em
	/qRj7hSEei1gPp7sH455Y20UCqj6INGhjaJC1Du7fFZB71X9OSIqMw6BGr2gtM5kTDFN0r8FbEV
	TFsNLgcdv2F2uGZNyLTfVSpaNBhSSk/Cy0JZy09xQZx1xsOLHyIe2zfz5CUOmXFkEh3rl
X-Gm-Gg: Acq92OGdYF+TUYTnb8OxECpbQhWQ2tXJZir1XyEhSSxbOWZ8kVSYsWkzDOx8p8jV/zT
	AuhBH2Har3QILtO8gnAn+iEA00OIyf4OH07i/+Z3lQ8Y7+e0pjOBm6FCmrUoc3U+1ibhtqa1GdO
	wboCOLjRbBqT+2n9P+K4qDJHewcNsA5F432R5NrZ/duu9iVDT9Yj2Bw2bIS6lYp0s5KIaLcFLic
	lT1AJilK1LH3VNQ5zHnKaKtjO4ttobS/ozHWgI7pb5H6awuz0PqB0WQD4nGFLYdAHeVCVsD+aEl
	fAYbmEDnth8nAD4kSa0dFysXNg9ejqVAUK7K+GCFVVR+sJP+j7nVYzOyRuuHCIVbQ9b8dw9lYBY
	ZUIzo6qt4j2MtmBkZWMVqQ4dLuFl6WKLVkJqMeBN+IHZssR9eFahUZQ==
X-Received: by 2002:a05:6000:4812:b0:45e:f6d5:7db5 with SMTP id ffacd0b85a97d-45ef6d57f21mr93699f8f.18.1780068210632;
        Fri, 29 May 2026 08:23:30 -0700 (PDT)
X-Received: by 2002:a05:6000:4812:b0:45e:f6d5:7db5 with SMTP id ffacd0b85a97d-45ef6d57f21mr93615f8f.18.1780068210090;
        Fri, 29 May 2026 08:23:30 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35601d7sm5883909f8f.28.2026.05.29.08.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:23:29 -0700 (PDT)
Date: Fri, 29 May 2026 11:23:25 -0400
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
Subject: [PATCH v9 16/37] mm: alloc_swap_folio: pass raw fault address to
 vma_alloc_folio
Message-ID: <b78e766a1efa9f3587ee8787532f4b624e9da032.1780067977.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: n-I_wIycmsZcFiqUfzG5nSM20VqoJxEK16MalXmMWis_1780068211
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

