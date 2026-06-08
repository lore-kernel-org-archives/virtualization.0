Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5542C3B14B1
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907868; cv=none; b=RNQ62JF1DwtI8NIMTdsnFQLqxgq+EtTiHDj66y7CyUv1MWsocjV8fFmliaEwkIFkErJiuxGAFoxUnX+dEsowJic5dD3npMg1KoJtgVfO/SlCuKqcPQHye6QDYOe9oz4jJj6BIZgfCYjiZBVCt4QPMFYns29PUSXRiWgEQfOGLUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907868; c=relaxed/simple;
	bh=1zyTUpR/sEiqxyRibjnxckO9DMK4cSEFuMxiLpElRYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JUeA0D8/ml4iCdkGLzHrVN4IOLeEbBiiUQu50BCdy7sUpPniEK2N8pdvI3TRTX3OyvKza5HKuZwJksP/SL63nWaT/ddVWhVsKVkfEW8wIiOXnL4VlJVyurZnmZY/yqpByNXFZJ46sFSSBE4Jg8M05J8hJ+mhTjTIyRqrcZO1Ji0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/5XROuV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/5XROuV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5nfUkrh3UXXGBEBXNDRnqOIydAOk6SYQWb2HusQDLsM=;
	b=a/5XROuVFhFXf8AlswwpL9GXWpSJHYH6hwUdVBWff4UwjwzCN2NEiP3TXF+LD2GNacTzxF
	qHNST+PsVMeOPnnimWjLCv7T7LXRR4mUQs392Dq6G0qe92ieoYYhWnUkPXOwzF8rFISd72
	rdDBOhmQOkBwevN0znrrCC+smvlg2oU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-VzmL-SOxNYuU4nuxXpFm3w-1; Mon, 08 Jun 2026 04:37:43 -0400
X-MC-Unique: VzmL-SOxNYuU4nuxXpFm3w-1
X-Mimecast-MFC-AGG-ID: VzmL-SOxNYuU4nuxXpFm3w_1780907862
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45efb6e60e4so3798530f8f.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907862; x=1781512662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nfUkrh3UXXGBEBXNDRnqOIydAOk6SYQWb2HusQDLsM=;
        b=pKX65edBKc1t2MLVwUlQ25l9EU17CZSzaG1dFSANA46VtX6HEMMv6WTkTsGKQJs0Do
         A2NHK5wTIrhttYi9Xjt7+GpTAEDowusUo8vwPDr5xd4mnQHE8S51mMM5x1XrNjM5cv14
         ePag0b31q165ibnBVcKzqM7wz1xyYx3Ik452pcRcYjsf9RnEnyGj3e/TXA3O0itv7C26
         OIIsxHS6XTmxbJpIH+kDNBOzJFdisFZ5xrWSyQB+hr31Jp02l2EbXM8gUJpDNQzbgqTd
         lhyvoYNKx5HOLIHczntVtdrEl60V1vhqhDN074cJaGcm6VrnII6/o947uWIm/llHACSu
         kOVw==
X-Forwarded-Encrypted: i=1; AFNElJ+usE7v+Fxw5Dvlp9RJay16GviKGR4KqGFe2YxwT13o1kRkJkZ+tWiOaquy43umUPYX0Muny3UgjRzScLhKEA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yza00b9xkFPMuTkZev6q2HS+/Zf4+kxIZeuIO7iv4uyTRgElS/Z
	EOOxzJZb7BTY3VUwnA1yQ3+8s8mRxbmWtnB8EvalN0Dh6V01sN6diUKDpyaIaygC8RiK04p5+2h
	wnNFshMCoLsDqmRUf2QYirSHdjCkzjiijCCFgf3jVqV+XdBnp41mtdS6BjyUv7dH+qxoV
X-Gm-Gg: Acq92OH/oGeOJFCO0Ezf7YlwS+8rC8PwKnuNubyUN7xkUKUmRlXhA0I5SpL0OxAs5+A
	jB47XCWYy546ZVR7V8ZWGXGhaBquzRhkS0C2Gbgwt+s8ibwbaMTxvoeB+kBPXyhS0aR0WKGEnh1
	Y6yhU3M8T0u99rZGCgVorknO5kDlnZ8k1GCd/58xwCLAaPlUCRwnuUPClitxMbGCY6iaZ/UP7MS
	idV0f4kSMQiQRWtBB8s19lM8Uo49FlGwNoakrM+ZMvo5v+I1zDqU6GcBCv/tr6YowoVs8CDCcEu
	+VJay3pumP8zjoGe1E6UFvfaq+wuIP6bIaKpXkCynv+DowSUZsVnK70sF8uUTFFClbwnohxB89o
	mpfMMCP9JNNyEulah25FfP9g=
X-Received: by 2002:a05:6000:25c4:b0:45e:e3ee:98b1 with SMTP id ffacd0b85a97d-4603061f968mr23332573f8f.32.1780907861710;
        Mon, 08 Jun 2026 01:37:41 -0700 (PDT)
X-Received: by 2002:a05:6000:25c4:b0:45e:e3ee:98b1 with SMTP id ffacd0b85a97d-4603061f968mr23332507f8f.32.1780907861145;
        Mon, 08 Jun 2026 01:37:41 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f368e9fsm49322612f8f.37.2026.06.08.01.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:37:40 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:37:25 -0400
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
Subject: [PATCH v10 15/37] mm: alloc_anon_folio: pass raw fault address to
 vma_alloc_folio
Message-ID: <2e931dc3daa76b57eaedd5b2d3d49f1075797252.1780906288.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: d2Q6Ur-XZ4S7WbcfKaWmbCchrCBeI2hDT-tyVhVKiuo_1780907862
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Pass vmf->address directly instead of ALIGN_DOWN(vmf->address, ...).
NUMA interleave is not affected: the ilx calculation in
get_vma_policy() shifts addr >> PAGE_SHIFT >> order, which
drops sub-page bits regardless of alignment. post_alloc_hook
will use the raw address for cache-friendly zeroing via
folio_zero_user().

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 86a973119bd4..21f640674c4f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5268,8 +5268,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
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

