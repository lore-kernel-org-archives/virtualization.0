Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8843B4E81
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907888; cv=none; b=Sao8KQrKEEAK3hBoXb5aLtdxl/YGPEd+4itJi1i4IMSB1/ZjhUm1L4hbLzj2RC8yuPEFUOaohrv1CES/Sqvm8pF9IDIGK5f0Y7sKgRjksJ9mVhsJoPMD5Iyp986FbFSLippfacK1XZrwkUjaDWBtiYdhB/U3yNn3WHZpXqzcx30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907888; c=relaxed/simple;
	bh=TnddcwSWkBVpMxUBPESy99JTSMn25mXLp3afUCWRn7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KAnJXJ62cSFlazbOYVq6owNdiQQgvSz/EvQy8JSqSlDPbgYN3DlNDdbBKhjBPXwsmN9sUMIXICy2XAmi+3MYH6FYrVm/FRrBq1TQdtN9WPiJFvp1x3PiAQ4vAXuTQPxkQfBBr1ocj8uEPhp1xXLYU3aahSEtrQNXTqEu8xEUgG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPsdED8l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPsdED8l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zy4rtaIprLz/f2YXF/2fwOOOF4wr4AdMW87y/Btd5qo=;
	b=HPsdED8lGifQFv3bYyiLv1fqCDl36Phj4YV0urnwsLb4S+wbcSmcloIV/HgnqGjHVBpmiO
	zImddi7n95M9RAvz3MEXm87XKQ0oy7VVFT0gqFaviN7OwDbpu5q9QID7ySun4xGKmHHG1/
	5fp+DYhp0sSdopEgS5at6gRy7qjDV9M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-Cc8jguVWMye01_J4oZf0TQ-1; Mon, 08 Jun 2026 04:37:51 -0400
X-MC-Unique: Cc8jguVWMye01_J4oZf0TQ-1
X-Mimecast-MFC-AGG-ID: Cc8jguVWMye01_J4oZf0TQ_1780907869
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490b8adf8b8so38355795e9.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907869; x=1781512669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zy4rtaIprLz/f2YXF/2fwOOOF4wr4AdMW87y/Btd5qo=;
        b=oOvwU2WfjYMViId6t5a2HC8UpLpfd5iTMCdgjlkBTIzQB4y1VWdsus9pJ5TlCDkqoU
         6yZW+LBeocpcUT/dRnscm8v2EqmV2j1LU8L8F8eUYPUbLZ69w7X8dTwSslzcEDs8jE0p
         qKInOM+UbvUNVVJQL2cXY3wQy2RoCCLCgPszXdowaMH/NAcBhFEU5g7CIqDlytSeFsuL
         v8qnDyXbwjMR5pauPTbpEz8xPOaPmbmFnXpsDqWIjB8cEv/w5P6tnWR1/4y7DfpMOAsu
         Il095y6R1qo1GvM+7FYyeEgsYTfF+Y5xaJ70yPo372TZLt8/dbhKodbEGakhXQ8cxF7Z
         oJbg==
X-Forwarded-Encrypted: i=1; AFNElJ8ZZnuXmROZAM4WXKI+neeL0Vtn1LqwWRs2DUDJNU0U4xuHK1Z/G3tn8fQlaG+CK6AEDaDRmoJ5FWUcShL11Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpBTWXbRNw1+PjywPlHAGbGLcu1DTLf5+ZNTuMyWTMtS4GEgbU
	9Hk+/xFQUvsj1fd8BtB4NWrlxdKoABEJyaJSXYLXvdp9BepodTk4wCvGlusfR8YcxcYaltFquD+
	Dvt4CgVZiKoV/Y32LLqMzwSerjOr6wsAnd58Hnas2O/t/JsquD1qwbELxzl0xpoikN1+0
X-Gm-Gg: Acq92OHYGYJinDU6+rIvl4mjrxLwaL7qbOrbrmDGtdmZuMVZszjzDxsoi7zw9nS1PqI
	v0gogTgyw+dfVSW2Aqzd0Bu6n+Z+ZeqQjiMIBLXCgZ7XpsFS7q5V+ZoeFxHPREWC1moi6g3DO++
	n4UmnLHI08uGyshQOp8chlp911sSBkuTH+8ZAsde06nX3FaAYs5rVcL0khnKqYjlSqHLYo61q5k
	yXzZSc19Be839iUr1X1XvsTPs2JeYSOayOJrma/uHooq9fWS34T1U+JSv1+A2t07KbG2hAENNR4
	Dlsp/C/L+twm3Wv3TtcGLX+BDH6u6ILezN/DbPWzrh+2PHWDXZxjD39WD+1b80vp4mj7ZvTt8X+
	w3Z1akeoH68fsL/nw3EzYbJs=
X-Received: by 2002:a05:600c:1549:b0:490:c7dd:7cc2 with SMTP id 5b1f17b1804b1-490c7dd7defmr154053395e9.24.1780907869218;
        Mon, 08 Jun 2026 01:37:49 -0700 (PDT)
X-Received: by 2002:a05:600c:1549:b0:490:c7dd:7cc2 with SMTP id 5b1f17b1804b1-490c7dd7defmr154052515e9.24.1780907868720;
        Mon, 08 Jun 2026 01:37:48 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc140sm450465175e9.9.2026.06.08.01.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:37:48 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:37:41 -0400
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
Subject: [PATCH v10 16/37] mm: alloc_swap_folio: pass raw fault address to
 vma_alloc_folio
Message-ID: <d2be78654e9dcc7cf5b8a542c2c8f331187c80c9.1780906288.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: ckTKxqvop3ctDzEU8Ql7aMAiBJtbHHoBSVUDOTD7Pwo_1780907869
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Same change as the previous patch but for alloc_swap_folio:
pass vmf->address directly instead of ALIGN_DOWN(vmf->address, ...).

Note: NUMA interleave is not affected by the raw address;
the ilx calculation shifts addr >> PAGE_SHIFT >> order,
dropping sub-page bits regardless of alignment.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 21f640674c4f..6c14b90f558e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4750,8 +4750,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
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

