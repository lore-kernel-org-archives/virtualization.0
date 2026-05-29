Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414DC40960A
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068211; cv=none; b=YLk7Lj+RCscWiPPEkYCOpgppYDMDituvjmEO4qCymMUh7coKNh7L5u+hOBF765kwE5Ye4GOlF+2Cy81njWgbx9WXoDNe7eR1FKbYcMJo7SXYPIKi4bqt/IoyQ5EyQkjeM8mPdBglTMehahlQmPYbcDEElF3rOIjc6bBRaR/Yta4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068211; c=relaxed/simple;
	bh=iDiOdN3wLJj9wOdkZsdqwIAEdg+4DXjaS99pBUtFYbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WZCZibB1HMSpbTuFGySDYwsJUXlLS9qgAOGVA6NFuvkeooKMM3WVlo5ufYH8N77xfTRQJf/seG7c/yI2jvGG5PWQxJgiauvlkcX+OSMd5hJrV7OSYkNvKIQEYUpBJCtE8bSkGbmnlByIQgOoPFaMbw0WDPdFxl5pdzcLbHVcB8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pg2zASL1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pg2zASL1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vK+J6BapUtjwGwdYlifbIYhLZtsZgN3kLB9idS28qTQ=;
	b=Pg2zASL1T4cBF2bJg7he+z8k68kRb6XlEXjnEE+uKA8CGYuYyJ3IXfR/ABBrzJ1q1j2cVj
	v/WbbawNVhNkh9qYLhE9wBghBXqXgr3BmtVAhqKlBQehg+8J3IshWy/AdvlyuWIw2Qc9cw
	bQtpmSc9sdIu9ODzgZAGfCRQaC49m+4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-S9I6mfvNOGCir2UFW0q7bQ-1; Fri, 29 May 2026 11:23:27 -0400
X-MC-Unique: S9I6mfvNOGCir2UFW0q7bQ-1
X-Mimecast-MFC-AGG-ID: S9I6mfvNOGCir2UFW0q7bQ_1780068206
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49045243094so101808905e9.2
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068206; x=1780673006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vK+J6BapUtjwGwdYlifbIYhLZtsZgN3kLB9idS28qTQ=;
        b=rn4RH6A+RhkCLL7hpmpE1pD+Cl3Tlgyeo4i6LVFQWKvFg+eIfmgZZxphsjVXV27CI0
         HuYuI9JEy1iIvnubO6t+psPe2gjlRzRyqhI0kO5DZlb6jGCbSTnfSIJ4iPqSlD7kDYPY
         QX6rhTAbnTDRBcGzkCZ592t5yBi91ndmLgsVQ1GqcJhcE9S2IpFgtcXZqskBLZD4IcVD
         2SXXE9jhQ2jCquiQ3uUHa1x2TrTxvz2SqvgUctZsATbSnU0fvMNtUf8wP/mqNWcOqMyF
         Dc42lhwVnZCirxJBRJDUu5qSvOYXNUq3Ks8imGqAdWxaFGA2q3v+8dUhWF0BbifIfnD3
         HnWg==
X-Forwarded-Encrypted: i=1; AFNElJ9OROQEyzmE6nkasdzcdKCaTrAQK6MyMdc5XGMv7lp0BVPr5sTjLGtiLiuV7ucrv9CdDXIiYQ7JXPcMtSPoiw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcPIQW64/q39WQKZNF36CpVFGxC6zJu2vq1Oo3vgJ0zCwMVOWC
	iPnjhYHyZeN2Z0b1di1bJSiu1swiZKf+wEYd64Z+lkZn0j5F0hPeRGUR9phjKpmbCb6fDIAcNPM
	iM00mDo9Qaf9lVNOe0talRpMYYgUpt17cN+mDCBs4nAPo5WDd72g7Z4Vnko+zWFo1cw5g
X-Gm-Gg: Acq92OHV2wvxSZf/rfSqgPre+6w/ScgAUF51TPtDdIupsVMuwbE6roQA7cbqG/eUSQl
	5EgIkwZ8eA5RjM1JC5359APTISWEna9yNkFvcLC3/0FjuC2+koIOI2zWRsAWiTgI0SwYpxyBOFG
	BkqZxTf9MFxRHCciu9KyHnSalH2/u4XnpvJbawXQMmzpQbTUABY5M7/+5occbGMLWA/VkwUus6Z
	SNgrXiVFqZpENOH17jETmphG2vNNr+iMFLrxuGffghOwq9lKtFNZFOmvkTIn9Qt7yutWunyKkWQ
	dwg9ZklGQT2p9O/5yw7o3rmBHvifP8H+nU6O+WgAjnPupozKJxJRum2+zOciDZMcdot7spodxJO
	BPlA8Tfm0FNnQOpr8IABn5dJIJq6MRL5A92aIRpULVRHzgu2TM2vtmw==
X-Received: by 2002:a05:600c:1592:b0:490:58e0:f466 with SMTP id 5b1f17b1804b1-490a2977dd7mr371935e9.33.1780068205593;
        Fri, 29 May 2026 08:23:25 -0700 (PDT)
X-Received: by 2002:a05:600c:1592:b0:490:58e0:f466 with SMTP id 5b1f17b1804b1-490a2977dd7mr370945e9.33.1780068205067;
        Fri, 29 May 2026 08:23:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34b47eesm4815815f8f.9.2026.05.29.08.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:23:24 -0700 (PDT)
Date: Fri, 29 May 2026 11:23:20 -0400
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
Subject: [PATCH v9 15/37] mm: alloc_anon_folio: pass raw fault address to
 vma_alloc_folio
Message-ID: <552604621ff4b05b9ebb69ca75abb83ac8c0912e.1780067977.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: So1KhrsYpKQs0zzdVp5FR2qaOojzH-IkA17QhchbBMI_1780068206
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Pass vmf->address directly instead of ALIGN_DOWN(vmf->address, ...).
vma_alloc_folio_noprof now aligns internally for NUMA interleave,
and post_alloc_hook will use the raw address for cache-friendly
zeroing via folio_zero_user().

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 02d3e53fc91b..75bee9501666 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5252,8 +5252,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 	/* Try allocating the highest of the remaining orders. */
 	gfp = vma_thp_gfp_mask(vma);
 	while (orders) {
-		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
-		folio = vma_alloc_folio(gfp, order, vma, addr);
+		folio = vma_alloc_folio(gfp, order, vma, vmf->address);
 		if (folio) {
 			if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
 				count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
-- 
MST

