Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB063C278A
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489631; cv=none; b=Y5unfJu2mV9xTmInM7iTE6wgUXD6Npxzw4rWCwMDq6/wMc7E7UiBBG3TDgqc1unenS+Np+oRiscdalhsUNkq1Pvqb9bfvVNgkMEutuQyR6TU27PRbyeeGiXE3kQne4rp6VCxTOHtoMx8g0IRRiheAFS7Evr0R4Hjd/CNNSEm0dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489631; c=relaxed/simple;
	bh=WO4MHxi65GFX0xUNciL8bEMuUsPiR9dGIohoqGtzw3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cxgnql6F7NeJdM8D4D3Aq8ppQun1Fpq3tJhpFgJVdlYLj5dl0nW291jZLwXftRSokkgUUQRcG/DxJbaYOTjt91LbtUKhYnWjL55E4zVax/1CGES0RLXfMlmuTgsqtJpxjNsFOCVCOSJ4tJnYcdh2kLUdbZjMCrWuWGhqWtJE72w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RDn6k8vJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDn6k8vJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778489629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XL/pBrxkXlfOOto9pZb2YfWp+jJTrqFtHfQ0Ihv6FSM=;
	b=RDn6k8vJ+nT/toUlq4SL76iPT4oyOMUhRu3HDZKdJLcQBrd9nCe90wTHelEpsIHlT8nar2
	dV1kVDpw9DjmDluewK2qO0p/eFZ6PnaL5+a4vZETYNitZezEEYMNNsuy/KTR+62j5/jU0D
	JPWZXMhUlZF9yR8QYviq2TaDJ5A6AeI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54--pNEFSjtNlWvipBfNIGtLg-1; Mon, 11 May 2026 04:53:48 -0400
X-MC-Unique: -pNEFSjtNlWvipBfNIGtLg-1
X-Mimecast-MFC-AGG-ID: -pNEFSjtNlWvipBfNIGtLg_1778489627
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488f973ddfeso28708165e9.3
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 01:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489627; x=1779094427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XL/pBrxkXlfOOto9pZb2YfWp+jJTrqFtHfQ0Ihv6FSM=;
        b=PqHyppX/sf8sblNmIqRPwuEQkOD7H1QMc7QHQ+Bcdxwp/IbLzQ5a7krdVbWR1Y1XuQ
         lQvaaygThH7HT5rDz9Zpypv/pN+wqc7FAtYZ2IG0giMbcFhmWuh8r/607d3Ao14/GS2Y
         yoQB/dodSLA4zyxHy7fgJYgiyaR706iYXEXV8SYY0jwTkKwgvSzw+Lu9iScpr/a0q+mi
         5tWOLgphP9QB4eAy3B/i8gyUAhhE95Gan9CZlqvJ828ZJ2fAXxT0GX2JdL8BaQKhJFP9
         B72e19tEqGDyjRIVLcmFNoergHE+JCL4N8c/xX2INeP/SX7p3czv/IVrUZzkNVEdbc/r
         HkFg==
X-Forwarded-Encrypted: i=1; AFNElJ8pvCLHbW7bjbN3kKzlZiwTRu9gSLz3NHT8gMiTCisOzF+Wp5mbG047RUQQ21kSViDXtuJGDnCyzyVuGDvdpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbQa4PARPjnqhWN5GpF9LyP8a1o9RbQOq3unkT3SuQ3e0jfhmg
	f/P/gtSRPL+7yUtYt9TI2+DpN9X/8O1AvREYLlgEb7yhn7yN2dxJnHHI+H+fhdSJjE10qeND0E/
	75p6rPmPXvcCdEprTriAQtkuO7BBuFdwkTtusrHIdOCdQC65dtUl5FuSRT6orWbp8ntOJ
X-Gm-Gg: Acq92OH0IJUtiBd738dTHd9toHfgYZYhcLOeyV8wHV8x0YPJzfNwWyuhDqojj3r/8Ho
	Q28stkyXv3iZN++Wdfxpd98csOZRPqtlOM79jwd58kdkbCA8+rJMC49VWt6RATowNwPTrMDtgVo
	Ste6u50xXyVGe3KrdsFNz+dQZiQVvZUpYNrrTeIe7oklj2PzWwlTnq2rYPkC9l9VawHhgLtWYZg
	n2rEEBELk4UyG7XxDpMbX6i4QUfZ+D7Xfkd9SPeGnYi0G4GnlEJF4vJQH1se5+8V1Gj7snkbBIj
	RrCBYhRnMRuLlxsLdG3K/4nNsuYB+aOJ+oaPjHFosCFmBtfkbajrUsoZg/tuYBywYWg1F9iQrMl
	z0gCOdfDL4pHGPdkBRsGvescDOmzD6I3YHrMgvKX0JvlccPZhAPk=
X-Received: by 2002:a05:600c:8211:b0:489:c57:7836 with SMTP id 5b1f17b1804b1-48e51f40ecemr408950665e9.27.1778489626763;
        Mon, 11 May 2026 01:53:46 -0700 (PDT)
X-Received: by 2002:a05:600c:8211:b0:489:c57:7836 with SMTP id 5b1f17b1804b1-48e51f40ecemr408949875e9.27.1778489626227;
        Mon, 11 May 2026 01:53:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491ca2fd6sm24939735f8f.30.2026.05.11.01.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:53:45 -0700 (PDT)
Date: Mon, 11 May 2026 04:53:40 -0400
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
Subject: [PATCH v6 09/30] mm: alloc_swap_folio: pass raw fault address to
 vma_alloc_folio
Message-ID: <7205b70bc71ef0794b5148242ba18254d9e421e6.1778487000.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: jAzN5XeG1DUqrsn33N0aLCUl2dnwQjXKlMZW0LSzs2g_1778489627
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Same change as the previous patch but for alloc_swap_folio:
pass vmf->address directly instead of ALIGN_DOWN(vmf->address, ...).

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0824441a6ba1..74523bc00d8a 100644
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

