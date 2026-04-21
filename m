Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6472C1788
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 22:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808900; cv=none; b=tmKgIOSdH0EXABk5I96oz96cDkK8K0TPh6lTj8NUuG2yAdFPb3lXSUFxqk4xbHzYSmrHVNxITepABdmpLkbJu2x6tTkl0ZnEzw+o57bdo2C3RbD1sv7JTxncL6yz1I+aMyzsW++JZn2Ryyk3kdWGVQCYLN7lKGE+dF1L2rA9PkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808900; c=relaxed/simple;
	bh=vQft5FFy4m26TJsCTwjR9OY8cV1I9SP5mZO5ylhP/Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ctN6ZolCcv8l9FpxXxBjns9BFaF11JbEH/I+pjyuMMqnFaHJEJROs94lcdOFNC754EjrHWHTq17uyFr9e0OeBBKHQnjuRGzqWzHLOMRk0Jwb1r9f3jHAugKBoVahcgdNYzxhbZwtufw++XQpnt4UN/gFiD/sdmYRNhwETK/ik94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+FS5YyD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+FS5YyD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776808897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ogU7GmeRIQqtLBfKG+aC0EEQurcY6mw6YDIsyPfIVI4=;
	b=b+FS5YyD7GkCO8Ju/IWQibes3H+Sx354I925lHvpBksEmscPyq9PZm1ohWIYfdIsKAIkIX
	BsGiNcE2EO29rsq6Z1nHwRP7WEkE1uUu7XKt4PRVDQRNoF/ZveMTFk5gILZewxNY+s1EXr
	b3emBCEEAzVHpzShISvlsc6z1kULlEQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-feDkPgDPNB--IuIfO07EjA-1; Tue, 21 Apr 2026 18:01:34 -0400
X-MC-Unique: feDkPgDPNB--IuIfO07EjA-1
X-Mimecast-MFC-AGG-ID: feDkPgDPNB--IuIfO07EjA_1776808893
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a55ecc249so8063585e9.1
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776808893; x=1777413693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogU7GmeRIQqtLBfKG+aC0EEQurcY6mw6YDIsyPfIVI4=;
        b=eEaO4lpGg6IzmuNQRVOxAgVMQtY80QZeNsIn5LDBIS6mBsP7e4Bg9NXO9WvTTWwTT4
         ch30/CzPsjv/Jq1Vl4ZgznNI3ZkkNlf4Vt/QFMHYgC3HjH9U4fvfLk3OztQB/zgF0XBs
         jR2EuoyuD1IbUDfw7lW7Joq2vTmneVR3luO94F3lCMZYGhQAynPyFw1prN32LmTNTIAx
         rL/QJaTGW2MXVncKecAOf2XZ4NZxdybE2UB3TcZrAc368kgn0B+UwGU+MRw2OHVcOywD
         u/GL33R3QTpkYiS2W2iQdjPkdNDrHx3TAlU+WIJpaiwWhz2j0Y7hOe7wAxWOlvxKBNJQ
         bxOA==
X-Forwarded-Encrypted: i=1; AFNElJ9XOR7hovxqYK/ziXn4Z93knNwD4j4sZrEtAa++u+8utB7Mt2h0a6W8963Km/kpfzsew38cVZaQzWG2BwsjRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YytMw7cGOTtz4P9mG09oO1HZtSIxUd6MsnRmzgOAYbBhwSAhTBW
	P/iNLjyWwUHrg0VWyRNtqEEgwkNqexVl8gxPKMJxX5Y3+lqmXUfHFyE+SDSzOwV0fyb0effrhEz
	6d6e/IiKytK2GObyTUi0rZ8t/4OylYL+0gi5ieAZ6QOtBJnNWPMB3JXFXFsCuCp1GzFjf
X-Gm-Gg: AeBDievhSrDU4hMWzdhpJWSfwwwp+mIsRZxEXEmYeIRVv1mM7jMKeaS0JWiOL90Bsx1
	aaCJgQcXHOk8JchWwx4Ta1JK0iBJ+tIB4bcO3/Av7NUgjYM1WCB0Aq8VB33uLCjM7BIYir6TG2i
	6ZwJJ+vA6tAvD2mwG+/8yL9EYCVRb2/rtolM2O9+CUsx6Iq5d1X+HlsRnK4sGDT1huqnEi3hsGI
	tIVDWqi+JIrBhJd2pdb0TctEhxH0vSZ5nbN8eCRZFP2DcdM34MAmonWrA4FYY2UwEY46o4QeEmk
	EvmMBCsINYT9qpbaKVwi+dtftakE1Lpu3nwNJPjywC2wzotOK8lMDl+rRkHoOC5efxO5bVU4GQH
	skEo4gnFU4BRPI9TX+RMrI/N5fGXG3ji3tzL2t9viOYNXQXrAf1b0JQ==
X-Received: by 2002:a05:600c:6085:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-488fb782618mr270881605e9.21.1776808893015;
        Tue, 21 Apr 2026 15:01:33 -0700 (PDT)
X-Received: by 2002:a05:600c:6085:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-488fb782618mr270881225e9.21.1776808892535;
        Tue, 21 Apr 2026 15:01:32 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489201cde98sm158378665e9.7.2026.04.21.15.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:01:31 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:01:29 -0400
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
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH RFC v3 06/19] mm: use __GFP_ZERO in alloc_anon_folio
Message-ID: <41d4e2acba16a35d8572e39a8cf73e33ed9fc30d.1776808210.git.mst@redhat.com>
References: <cover.1776808209.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776808209.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Nc6OXsF4n71I-cmUa-pE0-0sMVcP3zvnv7xszFjI0jk_1776808893
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert alloc_anon_folio() to pass __GFP_ZERO instead of
zeroing at the callsite.  The allocator now handles
cache-friendly zeroing via folio_zero_user() in post_alloc_hook().

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/memory.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 07778814b4a8..ed3797a6e121 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4662,7 +4662,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	gfp = vma_thp_gfp_mask(vma);
 	while (orders) {
 		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
-		folio = vma_alloc_folio(gfp, order, vma, addr);
+		folio = vma_alloc_folio(gfp, order, vma, vmf->address);
 		if (folio) {
 			if (!mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
 							    gfp, entry))
@@ -5176,10 +5176,10 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 		goto fallback;
 
 	/* Try allocating the highest of the remaining orders. */
-	gfp = vma_thp_gfp_mask(vma);
+	gfp = vma_thp_gfp_mask(vma) | __GFP_ZERO;
 	while (orders) {
 		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
-		folio = vma_alloc_folio(gfp, order, vma, addr);
+		folio = vma_alloc_folio(gfp, order, vma, vmf->address);
 		if (folio) {
 			if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
 				count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
@@ -5187,15 +5187,6 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
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

