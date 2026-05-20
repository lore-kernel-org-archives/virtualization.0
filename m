Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474213BCD15
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315732; cv=none; b=RBZMyPmvQ2BGK/dJrOMeqqJ+z5WEzcM9qNpdiunrpke61QVZwVNNm/AhwYEtWj8XxHb7Xtl39cxtgajfHG/QfSp82H/RNnRaeGS4F6dTS/qfF06J6lqPzPrq9KYdkpdK2FQrMqpYbTG62RhJqWCnZ0sGNeo3YJhYBCf0vo2aj20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315732; c=relaxed/simple;
	bh=3uGUVJNy6kGsME3V8gAHY8oH+alSOzgrnDm2DGDTDks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=r6KNlGDT4Kr0kitNHzu/Y8miGS4esX8pWktIqmps+HI4Qr8ahHWk8ad+/2slYfACCBwNFsR45se1ovOuE09bWio3zJqMeQl2qGxG+ILzWxzXT5NddB6/FfizcgsWnLncGTspEdnuiiLEi/ep+YRbklC9dh/XVOtlMfw+y0PaEms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9XdPD1M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9XdPD1M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yH/Aq3jRD/J0BW4aKC2BcM/dVQFsNlzLQi2tKUktXO0=;
	b=P9XdPD1MYma22hfdj3JqzGrZhm5fSINAlUEfd+u0rYhUoCVkZjZrW6qRmEaiclkCCXH1ZL
	ferDOrLO/NKnOtehiwDLAwpXcg08e9JhLFh+4hQba/U/AnbglTVvQWi081xBcj2hOkxZMs
	Xy/3nCuryeDFkfAsaWD4UI+ptY/61Bw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-LiDwaIhoOFK8XsTTdPfSiw-1; Wed, 20 May 2026 18:22:07 -0400
X-MC-Unique: LiDwaIhoOFK8XsTTdPfSiw-1
X-Mimecast-MFC-AGG-ID: LiDwaIhoOFK8XsTTdPfSiw_1779315727
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48fdb2b0cb8so34017285e9.0
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315726; x=1779920526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yH/Aq3jRD/J0BW4aKC2BcM/dVQFsNlzLQi2tKUktXO0=;
        b=NA7cJaQ853ZF4craz6jvTUW2WXZABNmRpvv4y1WrJLCoh/Pe/5PWkMlekb1GyNzhNn
         lQZ8wdY7dBw96wijipOTWzmHjtpqtyDBjvEJG+0i83guTN0MqCS6rPVQSHWnBBDZrmyd
         yB5T9OsHYw1k2lk4iLkVnWk6BEkQDHUQtOFtofm0rLisTKLPQ0xLvt69FRyK2B0YhlAz
         e81LpOSwlSlzWlyd8GhBxAC3e/n4ryfnAmCFoGbYeRi0tevwZWGgmzw0xIItdbgToRkO
         ccNN5KHwleiML/BPojgx3xz4m+jz0P8QRAWMAzN6JVtWMjPZKIAdp9QOe2TMK9C3wwQa
         Ld1A==
X-Forwarded-Encrypted: i=1; AFNElJ81q8LKMq/cXnxd3fUzRrisIyt7CKV0z/6v63z72JAjbSv5rLh2QDgjZFXf6y45G15OewrZg+fOZck6igpaaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWSWYDPt8jE3DQWolYYl/1R00kYQ7TKO7ooW8URs6IQiuY7uXP
	TAwNWmKnXHAmRlS24UTMNu+stmuRIjWIo7KSpQwcQ9KWRyPmLUDbN93M+Nrwths0JCOfhIr7l8i
	TyggypTX7s+0eHGycDSbpiiugTwqluqo9D3M8JpEbJlDI7L9FJGVTrG5yHIl84pIENlcz
X-Gm-Gg: Acq92OF4OU/QGBfhSPNVQtlkSILwDwm3bWLZkxsBYxz3GtbJBnCdTQkSbywW52OzahG
	5dcv3Dl6lrs2e5lLOw2DgPgt77oZsOZaJWrloGAKG8GSENzhAU4D+SaEeLgx1UMPjwkhr17pIqk
	yoWU+cw39XP1Hche9XeqM7s52VDL3YC7f1XsRARfLXkaSZkxZkqF8x6GWaG/YlwCFfxcpkch/Gh
	C8TtJ7IiCmqH+1hqq3qZCsGV2Aqxpu0WTq1a1jEOl4VT25o4oaG/q3RzapQgpxzlWeq8uf9mwrR
	d3OTjgedzhMjibcAL1oFfuMmwbWytDHo031zP+wo5poznvNKoslLAR2E538B/K7s6yPbD0/Oosb
	idKAkHj2aHx2RZcKnN6yuqdeVDm32OPJQsu+LHaOLNVw=
X-Received: by 2002:a05:600c:468b:b0:488:a824:fdff with SMTP id 5b1f17b1804b1-490360c53c8mr2627405e9.22.1779315726535;
        Wed, 20 May 2026 15:22:06 -0700 (PDT)
X-Received: by 2002:a05:600c:468b:b0:488:a824:fdff with SMTP id 5b1f17b1804b1-490360c53c8mr2627125e9.22.1779315726026;
        Wed, 20 May 2026 15:22:06 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035edd7cfsm1709205e9.27.2026.05.20.15.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:22:05 -0700 (PDT)
Date: Wed, 20 May 2026 18:22:00 -0400
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
Subject: [PATCH v8 18/37] mm: vma_alloc_anon_folio_pmd: pass raw fault
 address to vma_alloc_folio
Message-ID: <ecf3d8b129863a662a79c8d1c541c6855b1417c5.1779315441.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: kFoksP6RvrAyO7mOeLkeSn80f3rcigl3mn86XhnHyZ0_1779315727
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Now that vma_alloc_folio aligns the address internally, drop the
redundant HPAGE_PMD_MASK alignment at the callsite.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Reviewed-by: Gregory Price <gourry@gourry.net>
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

