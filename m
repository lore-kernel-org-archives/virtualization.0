Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B32261B70
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240089; cv=none; b=DwoyIz8HvM1vUhu0CizB545EyX88TiG3G0s7w3f8fNBxWIbAY9Ki4E4abD+ruYDX/filRsX2g1J7FVPdRe/hlZ7Raial9bhgGv+mI1sj671MaM1H0b15GZhe1BFloxRqHmh6HB9uMtBMeXR1qbGsTVn8Bis8fEcyM2hQvaVhocw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240089; c=relaxed/simple;
	bh=ojtPzu7q3ge/eAe4Ro2eoAuMOwfc296i2Q9/KCCbkM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Z3IZP3M0Z5h1k0NtJ5K8N/XuB+TZ4CJJaF9uEXXNFmbvU5CfTW2ZBS1c3JhXgn3bsv2pxp9JGPQHf2h+GYCWpUVXscS+rC0Qmt4nzPneJZd90dqMWACLvCFHAxb1c+jjd+uuBFb0yGvg+mcX5UdtzTlfIYthjIcpn5QKUg6pS8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QnA/nKN2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnA/nKN2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777240086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CI0eARfgql4LoyAd3/aNb/WcXh5TjMiJ3J1/62uF7XY=;
	b=QnA/nKN2504jfoxv0bGhwImtgqQaIKkJdHtIlPiyM1jSeL+OyDCL/XuIULu80+KnL7juaH
	eq7nkCzrT7op6lRVQbmF4vHHfykkDCdpKfAschtlDTMea+pPqiJEdxtAk9UJXC+l/Yt1Wu
	zY2s10KX/H5Z0QggO5+45i9uBQDCNlg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-jNAUgwvDOj616s361HPD2Q-1; Sun, 26 Apr 2026 17:48:05 -0400
X-MC-Unique: jNAUgwvDOj616s361HPD2Q-1
X-Mimecast-MFC-AGG-ID: jNAUgwvDOj616s361HPD2Q_1777240084
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488e097a270so65730935e9.1
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 14:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240084; x=1777844884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CI0eARfgql4LoyAd3/aNb/WcXh5TjMiJ3J1/62uF7XY=;
        b=duEw3PQ74UTCZ5gj/brBFi4yy6+4lPBJjtRvgh8Noz6ZacHxDU1SKQTedfJQubPJin
         oIjApfoo8HDH9a5PcosV7dLu/6CauUihW9n2ZLMd0r52B9v2qdVm8WEnCFRy8/jT9WiS
         6DmseLD1INV6DJ4FMz2gtiP07CogXEqZ9WwRoDpjSkEZ9UES+NditJuo54LmP8Np3MSr
         g3byL8o0uRobMqnav62w9wVmZ2CD2DpqvMlprHOZ0oy4djMm5gJLQZBVq309ku0Ze6mE
         R1XYKSo8pSrmT7Hd2SXWYa7MZYU6gEOvtgYI3o6aWSeyMbG56dgbNDH1KIMqGUyQ196s
         dtjA==
X-Forwarded-Encrypted: i=1; AFNElJ99DEYYvf96dQp48yiMx2tl8nvlGem5hIsAw3iDE7Ty9IIfyFTv/nlDBPOsP+AQRwd1x2SzBZZbhx4A8GDroA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywr1pNp3lry1MeJV/AyJSGpMALl5TWtKzmyFtjzKKJCHIj1qiM7
	hVPAypRjcJs/3Uz6Yp3KRwjpikiSCt1z+0AGBshQma2Sp0PLoHFu1df4EdxVY2Mo9N40xhRyZ/0
	bxhetMN3bhz1LohpcTnlQ25J/DQ+2Y5B44upKoqrqgo9xANiE1RMiOUucnffbdBiYw3bs
X-Gm-Gg: AeBDievaQmAyK7TcKHXfKkHVbOhWbX35dgGP70cpEP+WGZJqgYMtLHLKlYVdDntppZe
	i17vPzxRzH0uKe/xSmcPi7Ues0BTeOhOTR8zmQwfTlySgyDUWFWaGOFx8VNriXo1zfZA1FrlY2Y
	k3YXjFfauQ8R2hFrv9y7b1+NLl33BHZf1LbimQ+unhHa6bWegM8hvwJ6yOdsbqrEpl+WG0dWTvI
	ctnmkFCUVWhRnBNiS63FERLQ3sCV5dkcF+5+2gXLnfNnp9kW5AmZ7K5/dvOWzIlRMeTaqgrTClT
	fEW9xonYVjYZmKRwgMIBwxfVzmbiPs31euvBwsqWabShFQ/JmqsVPI3w2etWrKN3xVKaTcQ2vT7
	pLHFuC8A3p7/6MhZG+0xdGlDKobu/uVxCMQhcSRnmMtMh4Klv4DOT4nQO
X-Received: by 2002:a05:600c:8587:b0:485:3f30:6250 with SMTP id 5b1f17b1804b1-488fb7856b9mr439936935e9.20.1777240083841;
        Sun, 26 Apr 2026 14:48:03 -0700 (PDT)
X-Received: by 2002:a05:600c:8587:b0:485:3f30:6250 with SMTP id 5b1f17b1804b1-488fb7856b9mr439936725e9.20.1777240083430;
        Sun, 26 Apr 2026 14:48:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4899dc95920sm158861425e9.6.2026.04.26.14.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:48:02 -0700 (PDT)
Date: Sun, 26 Apr 2026 17:47:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH RFC v4 09/22] mm: use __GFP_ZERO in vma_alloc_anon_folio_pmd
Message-ID: <da7623084753450711764033f879ad3c1b9828a6.1777223007.git.mst@redhat.com>
References: <cover.1777223007.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1777223007.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HUNdRe95nlD7BSTFcMLKdgWx1_qaZzcFGozp_WHFBBI_1777240084
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert vma_alloc_anon_folio_pmd() to pass __GFP_ZERO instead of
zeroing at the callsite.

Use vma_alloc_folio_user_addr() to pass the PMD-aligned haddr
for NUMA policy and the raw vmf->address for cache-friendly zeroing.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 mm/huge_memory.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8e2746ea74ad..752f0b2e5bac 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1254,13 +1254,13 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
 
 static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
-		unsigned long addr)
+		unsigned long haddr, unsigned long user_addr)
 {
-	gfp_t gfp = vma_thp_gfp_mask(vma);
+	gfp_t gfp = vma_thp_gfp_mask(vma) | __GFP_ZERO;
 	const int order = HPAGE_PMD_ORDER;
 	struct folio *folio;
 
-	folio = vma_alloc_folio(gfp, order, vma, addr & HPAGE_PMD_MASK);
+	folio = vma_alloc_folio_user_addr(gfp, order, vma, haddr, user_addr);
 
 	if (unlikely(!folio)) {
 		count_vm_event(THP_FAULT_FALLBACK);
@@ -1279,14 +1279,6 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 	}
 	folio_throttle_swaprate(folio, gfp);
 
-       /*
-	* When a folio is not zeroed during allocation (__GFP_ZERO not used)
-	* or user folios require special handling, folio_zero_user() is used to
-	* make sure that the page corresponding to the faulting address will be
-	* hot in the cache after zeroing.
-	*/
-	if (user_alloc_needs_zeroing())
-		folio_zero_user(folio, addr);
 	/*
 	 * The memory barrier inside __folio_mark_uptodate makes sure that
 	 * folio_zero_user writes become visible before the set_pmd_at()
@@ -1328,7 +1320,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	pgtable_t pgtable;
 	vm_fault_t ret = 0;
 
-	folio = vma_alloc_anon_folio_pmd(vma, vmf->address);
+	folio = vma_alloc_anon_folio_pmd(vma, haddr, vmf->address);
 	if (unlikely(!folio))
 		return VM_FAULT_FALLBACK;
 
@@ -2033,7 +2025,7 @@ static vm_fault_t do_huge_zero_wp_pmd(struct vm_fault *vmf)
 	struct folio *folio;
 	vm_fault_t ret = 0;
 
-	folio = vma_alloc_anon_folio_pmd(vma, vmf->address);
+	folio = vma_alloc_anon_folio_pmd(vma, haddr, vmf->address);
 	if (unlikely(!folio))
 		return VM_FAULT_FALLBACK;
 
-- 
MST

