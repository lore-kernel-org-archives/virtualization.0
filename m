Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AEB3BE631
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489629; cv=none; b=r6iE/rGN/npw9VYvQNpCLBgQi8XMTH1vegGw7tQZ/8uSmGwu6ZdmbU/tT/4G2VsgR51LBfBjNLbVAyeyIYWW1jy+Ih6g0SK/R9TbrIhjiHfAGWnds22Qf1FzNwrCf8QrbMxrhOAiFuSRYC/z5aVfNJISUq/AzMF8QfRRGnObztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489629; c=relaxed/simple;
	bh=MamMMWXXtV18pX2Nm4tlwaTMDaamkDfpCh9w7kBXTEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KTfT6qWVsaf/3WxMi6iuI/2UmXAXUWOOrkvdONNv5kg1Vh79tH4NlY3O5LYvVmnsZvpQBQ99WTZh+0gBKQ7MwzEzPJkQYUr87cn0D/sfqKXp68IL7eVJCVJyY098RY2tes7W5C8GKc4jQmK4GZ5xJjsb2XEyo1KQUjRmohSfkQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VezzadrZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VezzadrZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778489627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PyhJPD76XSlXOLIxrgX26vlRXB2m99TPkgzm+4tnrhY=;
	b=VezzadrZMeJUlkeVX5tMz9GhIjCauObtLJGC2c79RwRk2h5ELZsf/g+zFATt8+5XpBM8la
	MaNLYzKzsVzqjmcMlguqU1W6hBtDOIUlqWeY+Y7crarjUTdKQVOoDNJYUibPHefZ+vNSY+
	jln623TXNq1cMn5K6u6Gtyl1enRTiOo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-cA23ZFWsOnqA6dJSCIA1ZQ-1; Mon, 11 May 2026 04:53:44 -0400
X-MC-Unique: cA23ZFWsOnqA6dJSCIA1ZQ-1
X-Mimecast-MFC-AGG-ID: cA23ZFWsOnqA6dJSCIA1ZQ_1778489624
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488bd1ee9e7so44622665e9.1
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 01:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489621; x=1779094421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyhJPD76XSlXOLIxrgX26vlRXB2m99TPkgzm+4tnrhY=;
        b=OM3AWt5us5/RmiCnvHY++hVuT0r6/thhCm22pijrbPk6gPGoL55/8sVFVz6+Ekfadr
         PrUULOln902EI1Y4TI062urXmyGj9PbAUHPu/JL3GUsdJV3mhrI5TXmVtXrdpyXaPtqG
         RKN2ln2WRMp9m97BnnmEK/kif2TDCWPWbJL2iOa4GkyZninbeesHCGA0lmU7DUEvZ2Bs
         LgTCMtO7k8iE2XeM6K8xRfhZH5LGVXrRfQM5FnhRRNLMT5eOJxI9x72HwkNr205gbfdj
         nDXEHabpTsPVq8aDYqkCsLek2fhobpu3ouKpHA/S4q13hXu1v+mlyehV0f+ccdBzN2sF
         O+iQ==
X-Forwarded-Encrypted: i=1; AFNElJ/BqND5hpLqJjuDetIU07q0XfwcpfH1mPqtjKWLo+UhTbCDFvN4wLPsZ6vd779VdrY7AKTDP38YanURKa3Cpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHgIUv+xS6DXgHQqAuYYkHVzz8XvpCCihOM1dea9UhL93SP3cF
	xl1gbAt/VGRUpUux7EsBTx61bkh3trgeiBMdivfR8SDMo5FrIVTjaHRWfWLVbrder8h2CFHRXuc
	oQ6fYd2YLYfkANpiMIph5kK9hpEK5H/Mh3vt72LrO3W3QE7KiaTV2G5Zr1H8pR7QYontB
X-Gm-Gg: Acq92OHwK2qe8pwHhF8J4geQ+7hEA2WkqzdtQNWzsDJ7yYV8hwtGIRCaqlY6VCs3+bX
	oZbSyPDgwB9BUspr3SXE9NR8fM/mqh4gksy0q/fB8TLplTvdbu5Eaq6zzy1MCkQDFHU/qsHxsOD
	LYItAJYOraIt90iPqFxf0+F1UWQX2mX2eNGx0fOGVh4XiJZWMnFa+0nVo4wtcoRJhFOImhTsXFg
	Cqeh8TBwHb68n6QmEdK0CYQE9P2WCE/Y6CHTnjDH/v0ETWBG0TLKUx60RVzttcj5WCh0TmtvMO/
	KRq+vvFVZyUYRdxY+GzmBEzPn8OPlH4iYRuNHsD79MquwuXx3sDMBypo4wKByPT7imvJS6aDCvL
	9smqsdJTsSnV8+lwLpJZBPd0kLbbMQQwsd4HNfft2
X-Received: by 2002:a05:600c:3ba8:b0:48a:97b6:7420 with SMTP id 5b1f17b1804b1-48e707fbac7mr149916715e9.24.1778489621259;
        Mon, 11 May 2026 01:53:41 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba8:b0:48a:97b6:7420 with SMTP id 5b1f17b1804b1-48e707fbac7mr149916025e9.24.1778489620562;
        Mon, 11 May 2026 01:53:40 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e7e45ff89sm115577295e9.8.2026.05.11.01.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:53:40 -0700 (PDT)
Date: Mon, 11 May 2026 04:53:35 -0400
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
Subject: [PATCH v6 09/30] mm: alloc_anon_folio: pass raw fault address to
 vma_alloc_folio
Message-ID: <96bbd5dcc37aed93a9b7733780bdcba4fdacfa3d.1778488966.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: MVjLqc5_bRv3wY4i-DMjOj-CkmY_3PHLCR849Se6JXs_1778489624
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Pass vmf->address directly instead of ALIGN_DOWN(vmf->address, ...).
vma_alloc_folio_noprof now aligns internally for NUMA interleave,
and post_alloc_hook will use the raw address for cache-friendly
zeroing via folio_zero_user().

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ea6568571131..0824441a6ba1 100644
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

