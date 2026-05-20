Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52924379988
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315716; cv=none; b=r6Rk3Hx9E6j0CS9cO8ZjcdKnXj70bM71RzhDEJDfDM4zqqwe8YmUz6AP/KN+xqHHvLsDt2a7Iu0vMmzV6/ry7hidAMO24oj3yqGBlBcvRGpflEeq8qKM4dqCRDKLMeUq/J570Ik4R6wj9/bQ9h9QP34rsufgpgRP88+TR9zBzXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315716; c=relaxed/simple;
	bh=iDiOdN3wLJj9wOdkZsdqwIAEdg+4DXjaS99pBUtFYbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ccPY+qK9e2wO83KDnFAS2yyPLx5CRRSbhK8ufnOgHkizVq9C1fVT7pn+mJ1zA57bFeTu4VKxwJaVGxeEtR+bbDSzF6Vf6oXqFnvccRATcLKEEC0af1y1gBfEo179j1tm9YYYEOJlUrbnYb+yIz4kpb2ThN/SYeHDiIUBJK/KaTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Or9Wjf9r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Or9Wjf9r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vK+J6BapUtjwGwdYlifbIYhLZtsZgN3kLB9idS28qTQ=;
	b=Or9Wjf9rpZ2eDPZ84DZljytx+8Ygj3NUJ8QU7IoMyzvu2AUhq6Vof1z7Xs+yq8fqBnolWV
	GKwF7OjxnK4hCxF1vxjw+wtUunr4nJYv4JPB5Qe1ttOnbtzX3CzBT8xPWbFs1dfsUuCE8K
	ees5KMRj67eI3M77eA7TBPEuBpHFaS4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-qqVJmyVXPdeeD4unEbcKcw-1; Wed, 20 May 2026 18:21:52 -0400
X-MC-Unique: qqVJmyVXPdeeD4unEbcKcw-1
X-Mimecast-MFC-AGG-ID: qqVJmyVXPdeeD4unEbcKcw_1779315711
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45e7c7289c3so3707961f8f.1
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315711; x=1779920511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vK+J6BapUtjwGwdYlifbIYhLZtsZgN3kLB9idS28qTQ=;
        b=CTjrc9+ba2I/aQBswfPP7iL3kZDWsCO0znC7DuVu+KYb1WGA0UbJUAMKhrhxjqN8+N
         RgGIGHuWA4LbkhS7W2cSmgdC64RWAMF5ExGatBF2IxVAMXQPPLn/atK3yUROWh7aDc9D
         mx6axFi/a/QCXJqZbc6zeitJnqX+RaAsKjh28yE4M8Ji2/ppQo2ys3zo+ZcqjjzIQ37O
         uerhR3hiTYf9e73w+RM/v86AW3MBBo43RVzPwn3HO2rLizM8G1Oy5lqoNcTPzmvSuJKW
         F/axNWNOqxU2z97SielXCMSgeaWpO5i+TmcuhepJ8S2A9ogJOnlywTPtQHkKojsXi8Bt
         SQ+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+utWz1vT2ZiohDy/DWJZ1BRKtaA9ak8CoqqLqvobwx+9bYbTQYHi7q96M22sA5vgtY6dv+VZDHTEZAUC0Jqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWHCPOISxJS+vgQ2QyvN839OBBmjbXyrrbvH0zfdlJyJFWNYp2
	CavB+9xeRCBcHabuAhYWOM8owHBSxD0+qIRCPa1b3K/82nu9/y/P27Y3VQk/GgDeJr4TOD1DQxc
	Gd8iVox+iNagj9T7VHFurS2XxL/mVnjhlDgG4uoQgXIQ3EqlGxKG1z/E3glIQP20tEHxs
X-Gm-Gg: Acq92OEKKoaa/Gm/FLaS6qFZZkZtbDjMxOn3k3rk4M+NDM5JvqfhKJfXKPEIEgHyffK
	KSH6MP91rvziY9QL1wyy9sQCvkp6fJMtJen3lwpA62n7YOs8xhJkYnSPMhPDK1ZI4SVe8Zv5Noy
	+WPIfyyWbXT6QFMhr42CQXJATOSvyqcQ9+5Jx7m5Uz4RjsuA92WbI499xhl4JeHtH7mjT2h+/Wk
	PKtbThHRDqOJlk3QqSkau7l8RYQkMj5DnUcVV1oenRjrjTIbTsWEO+9EOYb7nkGA7plwEkNu9bO
	05ZJHG5VGKHw+wx3EO2zDeJrpLZzcGP3cVyJyzHSe8FSRMlX9cDSAPTMjLatCgjWjv3tvDA6rIQ
	xOLFuNcmtWoEjHiJ+GiF1pJ0hRK0JMp7QzD5Gssgg3koTDofNik5FmA==
X-Received: by 2002:a05:6000:29db:b0:452:bc74:b129 with SMTP id ffacd0b85a97d-45ea34accaamr165797f8f.16.1779315711115;
        Wed, 20 May 2026 15:21:51 -0700 (PDT)
X-Received: by 2002:a05:6000:29db:b0:452:bc74:b129 with SMTP id ffacd0b85a97d-45ea34accaamr165775f8f.16.1779315710727;
        Wed, 20 May 2026 15:21:50 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13a7sm59869358f8f.29.2026.05.20.15.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:21:50 -0700 (PDT)
Date: Wed, 20 May 2026 18:21:45 -0400
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
Subject: [PATCH v8 15/37] mm: alloc_anon_folio: pass raw fault address to
 vma_alloc_folio
Message-ID: <467ed47f63a499c8d4c6b8209f6a818fb30229b0.1779315441.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: rVboZ3brGluLDkHNaZqL-0DUzRlxNBgbxT47245aZNc_1779315711
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

