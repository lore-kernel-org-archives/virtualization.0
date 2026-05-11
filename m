Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E3F3BED31
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489585; cv=none; b=WJIUa/I2XdNUUCk66+7obzxVuqp/Ic7RQ9xvR8jmDbShJNPH8PrNJI08DGpRqsO5MbD/WL3BBaMUBGG/H+y5PX4vc03a9KB99BvAE42b57ZKW50focb17ZYJEdRvPxsKpUNFWigBx6BgxJbhbkrnoZSnQrZlRsONXvtiR9nCEf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489585; c=relaxed/simple;
	bh=1Vb7u84GjOzr+CW7azCqmocyWDL053FJeunJoBfC3h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=H8r+LtIXsIMoZPeTCXyvsUZDCFsbdDZQHvIi0qc4uE3GGFlTp7uVHGAp9LUAx/1MSQ8AatydF0TLEFGExITtx4Oilzs4jJ3ox7OKs6frxC+ZNr/E56K5DLD6F9qs9wWCa7ViIZyEomX73KuwscBYw2ANk/SKWKznrBI/eNSYlTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FwXz27to; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwXz27to"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778489583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9tuOG0LtkLDTSKD1+Re+ayATul75v5uc/Qit0qQeEcQ=;
	b=FwXz27toO+eVPUNPGnmucymtYcD1u1geHukxotuu0QVJqtRNoZBFJu2mUzUlxBQGfQ8Zpa
	Y3B6nvZZbsQzLxvGWzByZTmFuT9BFk8qdroGBGGGHDItnUTQcI9XB/pHi7lPPAqwG2+Gme
	UWheRL46M40LDleLr6gwEJOyfA5HQ6A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-_sQDtGhTM5WZzWbJWM1vOQ-1; Mon, 11 May 2026 04:52:59 -0400
X-MC-Unique: _sQDtGhTM5WZzWbJWM1vOQ-1
X-Mimecast-MFC-AGG-ID: _sQDtGhTM5WZzWbJWM1vOQ_1778489578
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48a9592f666so26551365e9.1
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 01:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489578; x=1779094378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tuOG0LtkLDTSKD1+Re+ayATul75v5uc/Qit0qQeEcQ=;
        b=bpRH/2ssX5LHoJuf7Th5w+4pgp6fVBGkLRyjUhvYaJalrR1DrqIei7jt5YJ3+ye2Qk
         HXwAxomsI9/JgX20yW+VmsF/ZfxKSpHjLDx8LLXpxjAktQVuyQSsoYioyHfxQEXOrY3l
         a5E7EypESnNOOvZXb1yXBBtJ4+3ffzeXA/PgbQNfeNGBKvJZw3qqGjY402Xl+Tir2bjK
         GcNt+pxIsNZ2vDTHAZO3ZQ8QN0z0mdVjS0pL3ddWDSCQgy/QZr6yt2+i3VjPda6DHa3F
         SFrcCV9Ebv5JMS4Ur4bEZUItYSeWBR59qtLYkjgCvXTfiXV0VOgQ08hWB0aebw14NOVg
         Wf1A==
X-Forwarded-Encrypted: i=1; AFNElJ/pkv58dYxywpd4+wNs4K1PS4PJiV5RdgzPEO9EUOGI5D+FkerGXCn7qR9W0HJUwIIZQ3dHABCLvUiHOnMFcw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwSsGkuIApegpPnymVjE4i0kPT7wB7h7SuCpArgdsl4cWMV8LX
	3eOze3dy2GHnagTbiPLN0ABltUbYjZUXumWo7QUXa63L7x2kt36dZhkCuE8YF7iq2QMNvnOF/n+
	N3+zusJ7G7IvHF3EW5VtQA/6jVbqrRmKnt+yux5lXDQvuwyJNb5Y/DSkYJTDiy8xOIxxa
X-Gm-Gg: Acq92OEXG3eRk4iqGQQ0k71Y3pAEUNQRbh4YU+qaH+gYCZ8I+DlwIvvmzB1ybWGcyBm
	QE1/naC4Q3SVCP+QcouNnfaMK+ZJgLLeZd5CNab8IL01SZ//Gka131oXh57n34Lu369vHyEVDT5
	kW2IT1RtCcPjlsnkqTECyZ5vgrZtaEAqgsW8nvu2AWKdd2ki3QPONP+SIBKyAX3F7hNOzCPSR1M
	6UJhDcr8Vi3Gtg6RHbOlphwX75Ge+BSYy3N9h2KUAQ8Un5qsW0UR/wam02DwciHzHml5bAlZNXJ
	sfU0nI0jBkNbdBRlih/EBkI/QjovvGaB7pcb4nEqVi0H/c9VYfo2XZXSvEO52k7YHWnoKrW/hS7
	NaY3ZOroElTJ0rywdgvi/0us71DNdzUKbFACHs4CurqveJrRMw/s=
X-Received: by 2002:a05:600c:6299:b0:489:1f97:6b1d with SMTP id 5b1f17b1804b1-48e706edd0dmr143157415e9.28.1778489578207;
        Mon, 11 May 2026 01:52:58 -0700 (PDT)
X-Received: by 2002:a05:600c:6299:b0:489:1f97:6b1d with SMTP id 5b1f17b1804b1-48e706edd0dmr143156535e9.28.1778489577648;
        Mon, 11 May 2026 01:52:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e80ca2666sm90929945e9.10.2026.05.11.01.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:52:57 -0700 (PDT)
Date: Mon, 11 May 2026 04:52:52 -0400
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
Subject: [PATCH v6 02/30] mm: mempolicy: fix interleave index for unaligned
 VMA start
Message-ID: <41bd50fdaae943e1a79215ea4000322e74a823be.1778488966.git.mst@redhat.com>
References: <cover.1778488966.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778488966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Qp3mjSWXzWqoHapCMxlIalp5ba8L_5ySTK-NTctlDLI_1778489578
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

