Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8C43C4579
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489652; cv=none; b=UT5B6U5HrNqY990XriBuP+vrFEhfnGVQU/xueUa4TJkr2Rsya+EkDMn1r98WWSmgGQXcezPniIlcLoSWxdv0uYbzxtXVX3vkJ3RBq1944X0vXL8h9aYM5BPoisC7QZUWVzKsGS2aAjqAtzmDneCCfjIeTRAs+Isbpy7uPH0FAAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489652; c=relaxed/simple;
	bh=m8forpKa92wSEANoV2LwX8iYn506Fg/3SPdqojZoxqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gK1oyvTq6oqDIAiUXdiz+ijfJReW9MAha5K5mXJTGRE4ej11OTKnEa/J48RQJYpqbWk6xtxb8TkpYieyQXTQjgNGTzLR6K9fX4WRuqrjv8AgKaWC8jzU8fl0WAvmJ3H+8oAAnoQO3e1WUl5tdK20FVyGBlX6QuJ5lk/1KpVRl2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ME0N643U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ME0N643U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778489650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=awVRqRC+b/AmjARdxVJbu/50IYPO1xelbVaktsnFd6g=;
	b=ME0N643UwjwPXCsKiWIe1lFoMyc9nd9tS7RTKnvlj1rlr0sLUKZzuTC4TzXTYZA9epHWQ5
	3O0wxRdRLCCb+6F+RMJykfT7VBrksAIUeSEugA64kAJE4krJ5/WD6lN9hEe2zWXhZjEcDp
	SM4WJKNTiHdqPuSOxI96+tZ/o+d57js=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-H28XXWobOfywAr1xG0qLbg-1; Mon, 11 May 2026 04:54:09 -0400
X-MC-Unique: H28XXWobOfywAr1xG0qLbg-1
X-Mimecast-MFC-AGG-ID: H28XXWobOfywAr1xG0qLbg_1778489648
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48a548b585cso26958875e9.2
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 01:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489648; x=1779094448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awVRqRC+b/AmjARdxVJbu/50IYPO1xelbVaktsnFd6g=;
        b=Le2v51qWJL+cjfJMb5ERVHcLX/iGvojn6a47tSA8MbSI01Ly6hiGSN9NYBa5QsrQgx
         47r5bIfiztAwgUGMG5U5RpuMpobX2l5yp4qCL5JxGYkLIWNcqfCuEvrtn5BAecM5jINb
         jChmepS6PX0VWqccdYkY+yZDgBKHaJJzWWyptRFyMEPrcnXgseBFVIx5vbqjMEgWHlnV
         rb0o8Ikz821xtJAVkEUkMrSNIQxSPFk1ytQdXTj3L2g8Oo40vM3dLH0uycUdsrqDgcOo
         cN5vJ5VuktyZlRynAzLotfzitP4VIsLhIe9zNJ4kniflpk8HaHElkaeC6So1CMQrjikZ
         Aw4A==
X-Forwarded-Encrypted: i=1; AFNElJ9/j9eyKPwrYhlvM+glLG/L3ShCQ6mhh+jON89A9uV3AKJ7hJkzy06XbNb1ULKx2KYDFF/MRZEJaXyBWPwZZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwO8jgBaJqmaZxrFnOHnp6xQlvCC8sYIHU8r7J1owV1p+SAOTb
	hMTboDEyqMSiLlb8z2J1wNJNOLzSUmTHZvMCWOQX1AYwuWbP+tGpGhVOlnbc7JK7Q+rxRE38ybi
	D8hru0KXBlBjqsVUIrixcgS0wA1J8QGWMAweFgENr8ThTHtRGsjIAvbxAsyP5vQ8U1ft5
X-Gm-Gg: Acq92OGitE1wh4nqAUrvMGQ7+wPgJfuJNsfWOjUOrkDkF9Y9Ybjed6R9p+5iRfokwjh
	Muoeb0SJvR4QFcdXBVaNjPyDgnkkSl0m3ZBW2NoYuIQXzn6VawWDsRU8WUmoqUXGh7zztztpHXk
	7CyXDKvVCI91J1zWmKs+9Dqan/pxzUI1AdXPuO/n8GhsDOOhD/ooik2yfVZEeF27SjB/fGNR/6W
	7lJWIit8UoNhYjdQGzeVA38mE/Y6yYoatR//QSJg4OwquI6T8A2qWmAYULZ83rfn1BjxgJGfPsz
	2ozWQBRYotvmiAk9q6pF3Oz/oLAF+pzI/jT+FrfcDR0XeANEwaTxbkEQkM+u2xd+SeZNruvTLyV
	kAn/Nbi/yrJ1PFQ4irg1+wAS6j6aDtlblblloY0DG
X-Received: by 2002:a05:600d:849c:20b0:488:a2ac:a34c with SMTP id 5b1f17b1804b1-48e51f220e7mr276899445e9.12.1778489648180;
        Mon, 11 May 2026 01:54:08 -0700 (PDT)
X-Received: by 2002:a05:600d:849c:20b0:488:a2ac:a34c with SMTP id 5b1f17b1804b1-48e51f220e7mr276898665e9.12.1778489647611;
        Mon, 11 May 2026 01:54:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d8f1a57sm60732895e9.14.2026.05.11.01.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:54:07 -0700 (PDT)
Date: Mon, 11 May 2026 04:54:02 -0400
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
Subject: [PATCH v6 11/30] mm: vma_alloc_anon_folio_pmd: pass raw fault
 address to vma_alloc_folio
Message-ID: <65eec790aa9aa96d8090f3be7030bc47fa4ef84d.1778487000.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: kMV0oGGcQpBYnZddq2lDfdQngyVzHTCb17LguBmkZ00_1778489648
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Now that vma_alloc_folio aligns the address internally, drop the
redundant HPAGE_PMD_MASK alignment at the callsite.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 970e077019b7..d689e6491ddb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1337,7 +1337,7 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 	const int order = HPAGE_PMD_ORDER;
 	struct folio *folio;
 
-	folio = vma_alloc_folio(gfp, order, vma, addr & HPAGE_PMD_MASK);
+	folio = vma_alloc_folio(gfp, order, vma, addr);
 
 	if (unlikely(!folio)) {
 		count_vm_event(THP_FAULT_FALLBACK);
-- 
MST

