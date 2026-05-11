Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628853C3C07
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489648; cv=none; b=JuC6o/kqqHG1y/zdh5W4djRUCxJaFA1pOBO8YWYUPnFBewmsubvIMt9GulNvCwiEsz/3sL59AHsjiOrxEAbKpseqyO0xV5lykCasK60olgOew3WByrIwu/2LAb2d1hgBEFtDyugT1i+d8mqkBRqvFWr3HlX0YSaXGt+0DKW/J48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489648; c=relaxed/simple;
	bh=oLC9kYur6b/H/9DjaJgYZkAV9obgkYCnPswl1inVcjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sb/FoKcihfgzmVxdz+T7v2M3K/kRmoqSOA+v557IuJWnTHB1+/b8GDaAABbq9riaufLE5rYM+bymsZ+GSGXy5yPAdQmpRYZ0/XKqov3DqbELawS5zElj57Py0foI3bJJFoE9tUTigSNGszJerHw660zWx4UolswyPQtlwq+oTDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hPDCr3AG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPDCr3AG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778489646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2eYp/q7ILAhscET8EXyPBKCW0KNcPEmiVquSYEOS+Yg=;
	b=hPDCr3AGiw+3TO8MCauNbWx3CzDak5ca+Kfk4RVYH4x/db4MK20ykpnGYSJ4xqGGlKc6ew
	mZQM4ipqskuFifz4PAIGVBPTUrpSmriitFTRWKoa+eUthgatsItmE/OQ2R+e4NOkN7nPf2
	olX+qVtiT4XKj4GJMJYrnviy7H/Vk6k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-rjVC_5qgMnaUjKQQxRu18w-1; Mon, 11 May 2026 04:54:04 -0400
X-MC-Unique: rjVC_5qgMnaUjKQQxRu18w-1
X-Mimecast-MFC-AGG-ID: rjVC_5qgMnaUjKQQxRu18w_1778489643
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488bd1ee9e7so44627505e9.1
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 01:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489643; x=1779094443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eYp/q7ILAhscET8EXyPBKCW0KNcPEmiVquSYEOS+Yg=;
        b=Fh/UL1siQAFBiQ9KizT+WnESBxta/SHPKiZGdwUm7FLS9rJNtiUtAaKZw7J12zndoL
         RGeHjaki5mGWQPyMK2qxK1aINSxHScCPKv0MmSL8NuWPZEcTyeJ+Knowpghy70VrnM/F
         5teZT/GbBZhPRhXIaZBRvrHg82EzsVIXvJNerBn68oiLvwqD8y/VqDcRF1Ze3ETX7TAK
         fwiPKVN0lb7if2eVlGZQKg2cICLYqD3NlGYTm1Xd4VpONxGl6GS13vlpNmVyuwHoUD81
         qLVD8aWFTpMsWJ6auJEkEpGBOXTyHaIycuxzVXLyiUFQzGs8bGcGNu8QjvmIfHlYkI+1
         Moqw==
X-Forwarded-Encrypted: i=1; AFNElJ+XDP6VU9CFjxgWLD6E1c8D5ek2O70nMbviz+p74ZPINARgcvi1DgmR41BVaETZ+zS4OYfio+SnKi+vKTQjtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXBIGoVr+B45zymFp7jCnkytGbYkJxwbAPZMQvU/GyHAqbvrWs
	aHs8nJBClVywqOTUaD8TVvMjZeJ3yg3OFurtv12Xi4IYb8/HbAOFiEqV1tnlk+a9kxsZYHa5wz6
	ehMxyVDopfEF6H3QNtPdxZuvR0K2Vhu6Z7E+ukXvHmCsGOWJwzSuBce9GmR1fmr2bAWDg
X-Gm-Gg: Acq92OFF557YVSHpca9NvR1AWloLRt8kWi7TGlq0HUy8LcrJexfSWQBdvchuRC1DzIb
	0bXUJNBqCKXCT0o92FsTWH3Z6f6AJvWn9Z4rXDmU/EnBjkqz7uV1K+mywDRncNuKXLaXyv+7npN
	4qhNiu9VpNx27h77DkAITwGU7pjEi/VHejVqhoxQ2YpDJpSaFhdyOtRZA+Iye+ux8eml12mOeE/
	SgqYpgiLJ76vzUNR49IHGlqJS+LiI/NW07CCAwFVVqATjGm5GWJkyfmn1aeFRQuGceG+oKQPLgY
	S3OQGAKD+di3Zd4lS7wwlB7EE8I4LPcQf/T9jxfDjGTIRZHJAiipDqqEB+Qpb41l54mn8vMIDXn
	MSIOcTXUnj5oeQ549OTlpwRXECwANcCYJ3IuEeTUt
X-Received: by 2002:a05:600c:a02:b0:489:1c1f:35f1 with SMTP id 5b1f17b1804b1-48e706ad0damr139910825e9.4.1778489642534;
        Mon, 11 May 2026 01:54:02 -0700 (PDT)
X-Received: by 2002:a05:600c:a02:b0:489:1c1f:35f1 with SMTP id 5b1f17b1804b1-48e706ad0damr139909775e9.4.1778489641820;
        Mon, 11 May 2026 01:54:01 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702f407asm172879455e9.13.2026.05.11.01.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:54:01 -0700 (PDT)
Date: Mon, 11 May 2026 04:53:56 -0400
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
Subject: [PATCH v6 11/30] mm: use __GFP_ZERO in alloc_anon_folio
Message-ID: <99c79224ca94e63dfcbe8523cedb2a8d658bdce1.1778488966.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: dVnLAFCVFp6xNqyBiErjnw6Mjw7UNthImFlKF8lI8BA_1778489643
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert alloc_anon_folio() to pass __GFP_ZERO instead of zeroing
at the callsite. post_alloc_hook uses the fault address passed
through vma_alloc_folio for cache-friendly zeroing.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/memory.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 74523bc00d8a..f3f1bc66366d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5249,7 +5249,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 		goto fallback;
 
 	/* Try allocating the highest of the remaining orders. */
-	gfp = vma_thp_gfp_mask(vma);
+	gfp = vma_thp_gfp_mask(vma) | __GFP_ZERO;
 	while (orders) {
 		folio = vma_alloc_folio(gfp, order, vma, vmf->address);
 		if (folio) {
@@ -5259,15 +5259,6 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 				goto next;
 			}
 			folio_throttle_swaprate(folio, gfp);
-			/*
-			 * When a folio is not zeroed during allocation
-			 * (__GFP_ZERO not used) or user folios require special
-			 * handling, folio_zero_user() is used to make sure
-			 * that the page corresponding to the faulting address
-			 * will be hot in the cache after zeroing.
-			 */
-			if (user_alloc_needs_zeroing())
-				folio_zero_user(folio, vmf->address);
 			return folio;
 		}
 next:
-- 
MST

