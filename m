Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0797B3BE651
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490120; cv=none; b=BdWAHXJa1xNr95Soir09Cc5vrZuTkTu9RvP36/EI98r7MxxbP6KvlHaY8PW1OmpdDcFh99y8f1nGw5x1OoXPDrfdXi6zgVHj5d0otZOCKa0yxu3mWsMEHSZKo8ve9k+1GkI4aGDhkM5R6XivLdMiM50U/nUbq63YWEF8bDRk27U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490120; c=relaxed/simple;
	bh=1Vb7u84GjOzr+CW7azCqmocyWDL053FJeunJoBfC3h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bY4rSK2+E3x3T+lSOpO8ux7kgz4nLKz+3MKI2wpUCI31ACGP9LYNVdSl86TQ/5C8tUCzES/IAL57eFJYNDFNG/Rw6VK8w5zbQXoopg0jjjcviMaEavrFtXfLZSJk/K3oQGLVzH52LjHbiHtZivdXT0VSamuwkiY7OdgwjYykb0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iOeX1Mlu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOeX1Mlu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9tuOG0LtkLDTSKD1+Re+ayATul75v5uc/Qit0qQeEcQ=;
	b=iOeX1Mluf5BoyND5wBP/IoH3p6mAfTnTFoMuPtAmdwbV7grQaSJfp2BUFr4XTfFOFmeAMM
	vaoHVPd+zBJfj54q9JEHkhEdDeYQmB+AJ75CknFh4Up4ywRN2vH0GrkOtzZTfKVKblsBdL
	NkwOC79LgJmYJGbRSgZm9mjQi4QNtIU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-yxJXdmIuMuqq_tmpYlN_Ww-1; Mon, 11 May 2026 05:01:57 -0400
X-MC-Unique: yxJXdmIuMuqq_tmpYlN_Ww-1
X-Mimecast-MFC-AGG-ID: yxJXdmIuMuqq_tmpYlN_Ww_1778490116
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488c2aa6becso34016885e9.2
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490116; x=1779094916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tuOG0LtkLDTSKD1+Re+ayATul75v5uc/Qit0qQeEcQ=;
        b=XkEHkp4U+ub7djg3lt2cCRMPOjdNsDGOpZ1x55T8Tr4t00V2vov3Hzmcq7VGFAvLXU
         1W6ZE/TWunkj7WhzxXyixaNJh0KOmoq8Adu4aANpruuhruGKYXw6SgL3hKKFURBmf1t2
         cPkMkJCPSlGKoBvVBkZnHWj2XJqhzVCJZs4A2J5hFOeKZRg49qxNZdtSJ/L15JV4gXKW
         /IMjhs3337VM6mksUckQZgVL3B6/h5C9mCns3Aa05ogDRHUglKby6eGjQ3VGL9C+4tAG
         pOFnvZe+j1oBUWBCszxOgvLvkePEE9ktvcCP+xEQ83MO/Npux5XkS14CklsPIahuqoVp
         I14Q==
X-Forwarded-Encrypted: i=1; AFNElJ8PaEVD6QgOFFaGFC4VLaOVJ1Whx6NA4+2JZQdJmAewi89/F2ImaylWMbtbFUmudtum2ABhhV5v5rR343T/RQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4QEK6qedAP3qWGM4sjUR82AHL8mU7rJ66x7zuXP91WTYodZAy
	wfvBpoQWJ//NxCao3Vl5Y6KF2kxajXvL5WtgWJRjw7t48RhK8gEpKm7pL4eakeGU143XTJzYGv9
	AO5a83kgR/GTSPh4lOV/2zz6GBTtP55xcQT0VZ1Un8rjvaadmxWyNpzrJvE377Jm5RSv2
X-Gm-Gg: Acq92OFKlXX4Lujo6DBSbUczwvmNpdNzt0B03lo5RxLyG2P2F38qAiQdQ2Ra+Zm4itf
	I83QIdoTJGOMZtueDJHD3evU+suOJBLWQmwlKv/0zbngqUYgb/e8YnhklqwdaabYvooeRJN7a9Q
	rJJCvLcfjqnN2GwqvJRZciUkgwY8I28kDStJ3dTypHonmug/CN+7zv22Zp1U0ELBW+xTnPUhZ9l
	hZHsVlAfQrfGf4mLmydylqXnXPK19jeRkzlwCtxOvUxoEogveXaa2zbGfVL5vVToq70daonMD+w
	D4YZmPh9kilLglcfA/OE9IYd9J0mNltQwyq8aWUdt+5Tong5Ngb1+49XmO9XEUJiWlwMTwIGyHv
	hJqU4I7zL6sFv5p1RBAv/5R5PL5SS7rmVUXZ2baXf
X-Received: by 2002:a05:600c:c096:b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-48e51f50982mr286076785e9.24.1778490115554;
        Mon, 11 May 2026 02:01:55 -0700 (PDT)
X-Received: by 2002:a05:600c:c096:b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-48e51f50982mr286076135e9.24.1778490114930;
        Mon, 11 May 2026 02:01:54 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d895781sm104480065e9.0.2026.05.11.02.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:01:54 -0700 (PDT)
Date: Mon, 11 May 2026 05:01:49 -0400
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
	Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH resend v6 02/30] mm: mempolicy: fix interleave index for
 unaligned VMA start
Message-ID: <41bd50fdaae943e1a79215ea4000322e74a823be.1778489843.git.mst@redhat.com>
References: <cover.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778489843.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k3DWPk4wF6LUOgL-Qd2WB4s9T2TDHCqLjDHI4UC2HAM_1778490116
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The NUMA interleave index formula (addr - vm_start) >> shift
gives wrong results when vm_start is not aligned to the folio
size: the subtraction before the shift allows low bits to
affect the result via borrows.

Use (addr >> shift) - (vm_start >> shift) instead, which
independently aligns both values before computing the
difference.

No functional change for current callers: the fix only affects
NUMA interleave and weighted-interleave policies. Current
large-order callers either pre-align the address
(vma_alloc_anon_folio_pmd) or do not use NUMA interleave
(drm_pagemap). All other callers use order 0 where the old
and new formulas are equivalent. However subsequent patches
in this series add large-order callers that pass unaligned
fault addresses, making this fix necessary.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 mm/mempolicy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6832cc68120f..39e556e3d263 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2049,7 +2049,8 @@ struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
 	if (pol->mode == MPOL_INTERLEAVE ||
 	    pol->mode == MPOL_WEIGHTED_INTERLEAVE) {
 		*ilx += vma->vm_pgoff >> order;
-		*ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
+		*ilx += (addr >> (PAGE_SHIFT + order)) -
+			(vma->vm_start >> (PAGE_SHIFT + order));
 	}
 	return pol;
 }
-- 
MST

