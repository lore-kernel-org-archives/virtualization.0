Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5543B3BF0
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490178; cv=none; b=M9SJ1rnYAfom2FjDZGyZWs8WNB14x1HBUUR8rUaOBXzQPC9znWlDB4SKHj4OrcCVATJQgRweV9VSKT0EMmncabMHXV7OgWjqIZfr05sh4DfmpksFapPSF1CHFa/rGzxx3mfyneFlntzM4B8jl/hFfDf2AqSOboxPaN+0eyKYaRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490178; c=relaxed/simple;
	bh=oLC9kYur6b/H/9DjaJgYZkAV9obgkYCnPswl1inVcjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TSvUKg/Nkq0xH0HakecQfX7tOw6ARStAEH8YZlzFH3uUYc8ZQix4tpSbGMv8dnhX9rjdL+nj2OTh1nb492loCQPXfGj7e+Tv8PkXv33WDYFao4nj6uBb4nr3XDpclpkjaemrWK+KJOm9z2iZofbE/8fib545eWZI4QXsG94ReBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ai861k8g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ai861k8g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2eYp/q7ILAhscET8EXyPBKCW0KNcPEmiVquSYEOS+Yg=;
	b=ai861k8gh6mP+7C/9RVQfIea5RTMamZ1JsSraNRSXnV4DtuJCON7spoC+MEWOIS+5E9HE6
	IvPFbQO0pgBCFElIg8BnPWxmrU8mnTW1kWKwIDqEkY8F11ZfkcaUqCsJnL6lVIvws+GSwH
	W6DAqGV1INLPwhuvng4x80sjBNrTxc0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-iytH6inlO1e6zkL9D5Is3A-1; Mon, 11 May 2026 05:02:54 -0400
X-MC-Unique: iytH6inlO1e6zkL9D5Is3A-1
X-Mimecast-MFC-AGG-ID: iytH6inlO1e6zkL9D5Is3A_1778490173
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b8ff07df5e4so345345566b.3
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490173; x=1779094973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eYp/q7ILAhscET8EXyPBKCW0KNcPEmiVquSYEOS+Yg=;
        b=ofqcR0bJdKP2pfGgpmHGOaj+fODkwfZithHyIPhSA9y5uYce+TZrFRPhzktKhuZiDB
         3wRjPK23QSEY6PA7rjv8o0RsmBFZFyKHpVTyZ9XhqidB1+zIGfvY/LHm87NmWOSKg2dS
         y/yTalK9gFzu8viWCeAI7aOguObRtKTIbgVz/OcfKMlvNeNo5Z12d56jDfkyhhZDp+rf
         9fwk6MsZ9sYfaueu7X1k3tnMZxMMBmxJh+7IywxLdU0PtE4XRGeu6SlOBc95xtScLQEB
         Zhqn0KNow/sdeu6nuhN9RJ5FzR0KNRIRUFEMbytLLvqRx9KHdDfktGwldl+M0peE7Upz
         onFg==
X-Forwarded-Encrypted: i=1; AFNElJ9X6RJzw2O16ivAHsdOaFKOuSL5HfA8wVxV//mfDQPqwIAuEvTPqX0qPscqqrJns5hKRJPomCHij5SwaaeCLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJAXIKkyvM1PBtXwx2Iv10z5NwPcxoIIiN0zleKCqhV42irDO+
	mRhWpzHxtmbti8zLJEv4uCIv8yfu1MM8+V74ImoJGmipI43FqvNABdch5G4jOJTLMZANeXXcBTg
	MgLr1m0d64GJZL8Y8IXq3gX5Av3baXvWOyvSZ3YM0IDkPV3lfoAQ/j//6Zrgu6js2aYw/
X-Gm-Gg: Acq92OF9TmLUTTpv3Xvp0h54iSWmwVGn1U9pgVYCqCxFHEikcAy6o8v6IqermmU4771
	3BfkBIhoe0aEbXQednaNgTtomwSkau1JWMqal0LU5lQyFrXGI4vYDx9JCydl0z7pfVUzUMG3qep
	uQ5i1inirq8dzd1JW9EVMO3G2PEQLGCwv74UbbunP/vS5J+FOOfElbUiXChouMYNCJsTtWAsxKs
	ujREwK7pun5XLqyq+8ECObnvD1n11hAsa8HTNtN/L9gAJy+8ngoV9FEBA/LNaTdtELJSgEZbGkx
	twePpG3gQ9PUOpXgn630JMb4Qe5uSrGi3XeS3M0bNis396AS+zb2SB214rkEZDn7gJqKgcJ5cn2
	9IPsgsoDTa+FnTzMrUvm5md/GgNqCLXY6Aizy5Y++EPbfgKJtzx0=
X-Received: by 2002:a17:907:98c:b0:bad:255d:b5bc with SMTP id a640c23a62f3a-bc56df1b69emr1313614966b.39.1778490172579;
        Mon, 11 May 2026 02:02:52 -0700 (PDT)
X-Received: by 2002:a17:907:98c:b0:bad:255d:b5bc with SMTP id a640c23a62f3a-bc56df1b69emr1313602366b.39.1778490171589;
        Mon, 11 May 2026 02:02:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491ca2fd6sm25007169f8f.30.2026.05.11.02.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:02:51 -0700 (PDT)
Date: Mon, 11 May 2026 05:02:45 -0400
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
Subject: [PATCH resend v6 11/30] mm: use __GFP_ZERO in alloc_anon_folio
Message-ID: <99c79224ca94e63dfcbe8523cedb2a8d658bdce1.1778489843.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: XAc9GF2a2lRfix8sXnJd1tUa_r1Zqc3bGIQGmiySJjI_1778490173
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

