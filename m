Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602F13C0606
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315623; cv=none; b=iYVn3DXlDeqJmeWvK1SHI57B7W1fOwREC54ReDGXxzuhcxQFF6uURlDmmCODO4qmNYuyX5CLrtEGkzpA/uIfyBWK3zV7CuQ+feG/RMwMBF1TZPdML960idFY7Mm+xQiLZHTzgnQeQdSTxq3XvsDb76Eu1Gf8Yn7+sqFjoBN87jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315623; c=relaxed/simple;
	bh=ivSgG/97imSLXWE5yAu9GDoEGm+2i+hvCGOloJMpUro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YiexDFYRZnI4onLofUw8N0EYPtmO9LMWT9zG4+EfPWerkQTtdtp3Tym7hzTTEpqYc7ncwDV8/B/y6L6KAQ3FOLbyN3Le47RnyUwAiP1AC/J17AZPOYOKdiDoK0eZy4rOG+bpbmmawK/5FVAbCuKvdqjP9gbHABuLN1BtPFSDHYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QjOFcpWd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QjOFcpWd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=piBMwx0YNR4u+eZF7dD5f/57awj2BSKfWqeLUqtqejA=;
	b=QjOFcpWdQNVCSnM5ANpyENzcuvc0JmLtdWpXpftMJ22M3p/0SlFUzIium+CpizjWR2QR2B
	kiWs9kgdAysHqx+EBPHO+FeavTz88L+5wAE/ZMhXggjQ3i46mLti/p+R0FDHzJXNnAVHru
	LnM3I4by3qouVHb13JZV+u3uz03PxiA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-aQCDZFCbOP2gppfQYBMXmQ-1; Wed, 20 May 2026 18:20:20 -0400
X-MC-Unique: aQCDZFCbOP2gppfQYBMXmQ-1
X-Mimecast-MFC-AGG-ID: aQCDZFCbOP2gppfQYBMXmQ_1779315619
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48e79219704so37858615e9.1
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315619; x=1779920419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piBMwx0YNR4u+eZF7dD5f/57awj2BSKfWqeLUqtqejA=;
        b=bVOx9vfz8vPwcHVlTteUwwhhJDdI5H6DqPVDXRjPQ8ZmPxNZDmlKlG29YgVwaNQgHo
         xNcVeMT2zMzks6dYKj8k2qofzdCvLbbr60jMR1tdSkTvXYooQs9G0P+84D2BJfLTddkc
         cNRX/8k05hu472gJbDGOaNd/LVfDxMsnrhVMTtgJloewC7SnGYTDiA54xKVcKgjbGwN7
         l7bqPSxvBz8bOsDLO3+ZLhV69T46xmxbcEprWplURgTBJZNqSLaEg34aSAwXNKAHXPdC
         LbnAi9Wme5P+YQ+pWIzNG7zwGaLXoIrH5QCN7nRcQmA0HYH/+2UI7T1xwNbiswdnP/Ib
         eDPw==
X-Forwarded-Encrypted: i=1; AFNElJ9eUdbBV5Vzrl9k4MpgRxmCEsBP2oXCH1LT1kac15poAEUHw8jz8JAkAIF3Gz3aujy5YCGQllS0qf1U4HchuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzE4MZWI3bAvvp7dAfX6Iw9HqSDxVm6m9fGXDSB/WEjnHsHpHrL
	TPEN4B16csa/tiW+jAmC2JipUEMYjrcL3tbriEguFarG8f7PXLYQNU4x+U+P0jl97CJm/wfeG7l
	n5j2YzuJM3gQl8aUBAClvwPoIz3Gw4i1Pa9fwExP/jKw5A4hs7sAcXqA3P4ab2fa/Z1vt
X-Gm-Gg: Acq92OGsZ1JOC/5ussIYdsv2VjUHGgCjxEg1n782HXWfkccAGiMr+j6nPLvbpuThTl0
	tTwSLAaU/WfuALcm65hHGp4FcBfvEtF9mBTIUGIMuYJBPw5NNWYA5OLMVMo4IhYA4L+hlTkX+aa
	78MZsOGJM7F00A4IFctEu8NCGrpgT69FOM8lH1WFAJUosQDVWLv/cDsgfLKfDCBIOMnBHysknhS
	dusZnPkJSmEJnIcxBBohd8HwWWeeAew0fdMmc0E+7NVZQecUjrMTwCenxlQuBjQL7yJLBGmvf42
	CSd0TnPrEZG/lq2AiAIzl/8MEx1+B0VXSpHN+Uvy90gMIZeaF1/5UFu+Nzsx3Q3+C0MKdCbN6rO
	UkZ3VJxdYUNhLPLzMKkGJHODel2B+TNjTKn5tar6rGsM=
X-Received: by 2002:a05:600c:4753:b0:48a:7a10:4f17 with SMTP id 5b1f17b1804b1-490360485f7mr2619345e9.6.1779315618519;
        Wed, 20 May 2026 15:20:18 -0700 (PDT)
X-Received: by 2002:a05:600c:4753:b0:48a:7a10:4f17 with SMTP id 5b1f17b1804b1-490360485f7mr2618645e9.6.1779315618045;
        Wed, 20 May 2026 15:20:18 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d4ad9bsm18916095e9.8.2026.05.20.15.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:20:17 -0700 (PDT)
Date: Wed, 20 May 2026 18:20:13 -0400
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
Subject: [PATCH v8 01/37] mm: mempolicy: fix interleave index for unaligned
 VMA start
Message-ID: <2cc8a28608f548d582c4e5609eb036ac24f7ae6f.1779315441.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: rU65VU_GhxmRDehiRhKj1JO3qku7fiChE3P5r9PxREQ_1779315619
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
Assisted-by: Claude:claude-opus-4-6
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 mm/mempolicy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4e4421b22b59..b2c21ed1fd84 100644
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

