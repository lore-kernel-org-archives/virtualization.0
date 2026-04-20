Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9123A2559
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689460; cv=none; b=O57a2XF0k6MIshAvDFCu1OB0AaRgEaIXF3ykZwePaB7RZILYWX56Vf+/N6tM+8uwFq2jQ+Ho0Jdtgq7S0QWUfL2++ahdD0a3+S6Ge64iSBL9qtWeisVyfVawGrQ1hFxa9WoPz5OX4y15dCdGEAlCFgeO/PEptakW4eJyIinrhqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689460; c=relaxed/simple;
	bh=50XETUs8nc1ubnBZr+gLHXgVLxsEJaZTcPzbBRhZBJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nQte2vTaveziz4y96YifBRi9UdZ7HKRwno+T36aECoEZx9Kh6ijr4ixpANkryLTyKk8fdE2WsWZl3WCUrEEGdg1ot64vdBsbIE+rHxlHA2iO8kGas950+oVEQ3vi8wSI4jXdy6he6wRYtFGRjR1gCaRw4IIdtBMeXMKg4sE4ves=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BjpchpzD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjpchpzD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776689458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gARj7YpNrf8B3cZamzB8laaN+/4Ge9ZNHV4aaUa3toY=;
	b=BjpchpzD3/jYyFrKvtwicG2oroD7eDPV7OMMo4mKDemF52UoIHYyWUU5P02hOxMJNIErHb
	gDuCqTejsDvfVs337LNjVbYK98hy9/cOnsd1OoPzlponZnIhmJk2E+AK7WXgRSI+tenqKt
	s/5Iq7NMoeOjYta5xlFWkLOszbsUsEg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-EDEuBwe4MN6dk0wFtSjUkQ-1; Mon, 20 Apr 2026 08:50:57 -0400
X-MC-Unique: EDEuBwe4MN6dk0wFtSjUkQ-1
X-Mimecast-MFC-AGG-ID: EDEuBwe4MN6dk0wFtSjUkQ_1776689456
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d789cebcfso2299437f8f.1
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 05:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776689456; x=1777294256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gARj7YpNrf8B3cZamzB8laaN+/4Ge9ZNHV4aaUa3toY=;
        b=XrGNEjaIhBMT09gbj5knYXkMkVVkK5sEJaE6J79oWI3/uKP1kQ7x6sErVVkkd/w/4o
         SvOhOuMuUWuEn9/viUL8O/UPyrRN6PGC8X91hSlNdrFGazY7XNdWbWN3rbLicL1rtiU8
         2o43bLIO+Ktx77zXbJHOIeqln/ylQU7Kurt9BK4X+zgwNboXt+SBPkdfhA1fczEWANUT
         UBzh5EL0B66fNQyiQEyaCbnPV6E9SgELTD4aBBrG2ki9ejovDaAK0aleVQm8igzh8KTO
         zKFwpekDLaHu93Fbp4rOgKo1Lnf/sljOgger/lNQwURVdqjiJnlsFa77ubXB2MqmLyTi
         WFAA==
X-Forwarded-Encrypted: i=1; AFNElJ8Eb9VgfutMtl1ymF8v+dXP0BfsOvavK1Gf0wKCHF/JuHLJrXlxMaRTT/AZksVGJVJxnaNbglnEjHv5Q/93DQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDf9PucdZv36zq29Wxllj4jiZqdq13aMzvirJKw8g6KTLVjd9T
	Vl8DSjWYJhxo5nkjhgffkmt0NFR0k5DDGAtZgQ6xdurAGiPaLWF1B6cuAgqgktSZKJ6jW8M9tz3
	d6CcTM22Xoumqsz29fgOXe/nLXQQdvBzdTTAsAALn2IAlNq/sDVrQGeCGPqjXCeZuJzVm
X-Gm-Gg: AeBDietcajuJxCZqmTI7r5Xz0hTs4I3KDVG5yaoU8HF0JQMMtqnTc3qWIsF+3yHN0D1
	VoIkM68/aUFMPMuDrVlWAGIRrFQd+7DHUlleeOnzobLnE8M76cQeBK0nI8+OwzesFKzErYhclFy
	z/lgVw2tMM/HwD7D2Oe8N6RjyKqYw4+c3zggqezaGa1V76Id78OVZ5XeY3P5KdNhNZ+mmeQxIFa
	aDy2viiVKGcwEIes5dRamRQE29AI00OLpSdaR6RfSIDWAxl+sOt3K17vhLHiNOWFi+pIGawN8Kp
	rJp477fSRYRX/o8dHCikxTWed9TE/sBu/GQQHvlx/CxUCDaCy/H65oFHPWk2Sj2Wajhl0OpJ9hJ
	HINrO5VfgdISvxjZcVqyuZKjT5fe7wYrJXvk4m5SxKutx5WLSMSQQYg==
X-Received: by 2002:a05:600c:3ba0:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-488fb8b91a7mr175260325e9.12.1776689455569;
        Mon, 20 Apr 2026 05:50:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba0:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-488fb8b91a7mr175259925e9.12.1776689455049;
        Mon, 20 Apr 2026 05:50:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891c320084sm125739585e9.2.2026.04.20.05.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:50:54 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:50:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev, Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH RFC v2 12/18] mm: skip zeroing in alloc_anon_folio for
 pre-zeroed pages
Message-ID: <97780c54dc083b9e3e0bfb4bb9ed7d8b1a576f91.1776689093.git.mst@redhat.com>
References: <cover.1776689093.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776689093.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gZPAz__tzoZHrEDQ57t_TIjCAUIs-JIo_oFWDLNb524_1776689456
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use vma_alloc_folio_hints() and check PGHINT_ZEROED to skip
folio_zero_user() in the mTHP anonymous page allocation path
when the page is already zeroed.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/memory.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c65e82c86fed..066e2c9781dc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5179,8 +5179,10 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 	/* Try allocating the highest of the remaining orders. */
 	gfp = vma_thp_gfp_mask(vma);
 	while (orders) {
+		pghint_t hints;
+
 		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
-		folio = vma_alloc_folio(gfp, order, vma, addr);
+		folio = vma_alloc_folio_hints(gfp, order, vma, addr, &hints);
 		if (folio) {
 			if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
 				count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
@@ -5188,14 +5190,8 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
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
+			if (user_alloc_needs_zeroing() &&
+			    !(hints & PGHINT_ZEROED))
 				folio_zero_user(folio, vmf->address);
 			return folio;
 		}
-- 
MST

