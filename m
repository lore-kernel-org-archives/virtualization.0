Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4068523E358
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240074; cv=none; b=k0xXDUJE0faITTZoFaXkTQTNP1f2VVR0RdLOI04Su5Tvsq0gscxv4FdtlY5I0y6NGAZc9L45vtJnT+BaDxDfBfem+dTV2s59PCPhzfd3YINvoEWWKBl5C7Tn1m2PKiWYwNc+RvVrkrWrggtWhWU6fzYFax6ZqGY6z7qHWpUBSsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240074; c=relaxed/simple;
	bh=JlDejs9gYAIkoE2XJP/rDDJpTLoWc0jBBYztgwi8/CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sShEGE6DFbZNsLYbKvt7YQeM/Yl8Aylbc2K8Do6hJ2H+hPUs4mbWPNzwAwiGiGIdf1CMj8h9UkOKIBgNKdYd4TnlYwhP+ntN6eX/smU3Aijg4nEdmjN0VPTjLxs4X9jUvxM2WhoGvpT9f7ILFLATyy0KWvab2jgWTalsJt1kK0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3uh4aj4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3uh4aj4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777240072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ri4XPy9sNyekDQ8kcO16tmq8sU4MreY6RcvDvpK2Y+0=;
	b=a3uh4aj4se+XzHVAbNm8N+S2YrIKEnIYTfxYeZlnWCN1fO10EfrNyQLu5zYNSZwiOEu6tk
	4ruTktYQLL5IwVa/nwM5o1AysDkGfB8Df5KatynyW7BeRLIUQXQpz9CYL26qsHl3Z0m8jl
	INQpuh+V0I9hz+gn1O1L8XE+gNL6vvo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-YorNsGIUNRiGIIpVdFUK_g-1; Sun, 26 Apr 2026 17:47:50 -0400
X-MC-Unique: YorNsGIUNRiGIIpVdFUK_g-1
X-Mimecast-MFC-AGG-ID: YorNsGIUNRiGIIpVdFUK_g_1777240070
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4440c5944fbso448746f8f.2
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 14:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240069; x=1777844869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ri4XPy9sNyekDQ8kcO16tmq8sU4MreY6RcvDvpK2Y+0=;
        b=jMdsQq1ypZYg1W3cha+VfChKV5pe20YGK4Is1DRcBYUeJUsJ07/G4JDdly6nwIWrmy
         /EUvHgdxgzLnTIgsU7ghFgvqUHMr9KJclCLP+/nVASnfnx/qvUHslVUMTfHwGkNjcADy
         UADH3okY3dacVAyWkkJDuk46AhEEEOSg5CYZ0St2Nf8d7I55NIo8bGhU96WUDCvjvtFf
         xmUzUGxaEA7TldzDGhF7WA+RXMInGC3kmTRxnguA+Jrc/C6r2FypTWC9I9ImCjRXfFWF
         E3rpOB6dpnh1grjY+gkLvkn/wSF/npi+LJWB80p7Tf+I53rsLAt2ZtBHZs2Rsmyl5EAj
         kkiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/SllhlhHiayV/RvWCotHeHZYtaS5FgUXzjmD+167u7D6qVBnspaNT8ijmTNl27Ui9c1MrGgUmWy2aTOGpwFA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6iEFypQ5qD+0P36A0DEMPahpWbxjqs4/9ZvM5x392brkDGhDv
	1qHI1g6tMSSVboMB1WJo1GEp68UXRVPrWktXbHQNgMgAqO+ecLa6Zpx/fX4Lrg18+KU0+3T2IfN
	yKTQzpBDtEcmiedJaZ0OZkgon7SGGN5R7QY0lMC/YpRlejEwL2MggJFNY97+Vs01fbjiM
X-Gm-Gg: AeBDieu53ZzqsfWaS1qAAMQvGjDr/h/Rcl9bUNjBpDwswgQ/mdtx6tRR9tozhLdTII2
	5pCKfHODJMjrDnc3EQQ2Z57QG3UZs5jhUMzFp/YsX4lo4I00pVqkUHqNGtgoMW25UT1Lk7ICuIP
	lem3KZW2loN59TVHkZqaKlrxEonbINc4ChX7ftNiOLvTZbWwb8h7bd/MxlYoQ/NFWS7TNNxjfIo
	VNz9hNwmvA20G0+/NOrif0HZz2ibjDG4nUDqRXjk+MyLRkkRxry5vU09k2DmOTEMTQquE0a/fbq
	dPLgwLnxrinSf35Muk6E6078dtMr4FcHP85rYEh9EOIOutEObjDTIU4Tesw1q/MUnU2sUXtiznj
	CG2H4+5QTyTHtk6HjUn+5xTz7UUw9e0GT5xOSr94WEq2vXVCtS0yg9s1x
X-Received: by 2002:a05:600c:4714:b0:48a:5574:3a5b with SMTP id 5b1f17b1804b1-48a55743d05mr350691865e9.27.1777240069570;
        Sun, 26 Apr 2026 14:47:49 -0700 (PDT)
X-Received: by 2002:a05:600c:4714:b0:48a:5574:3a5b with SMTP id 5b1f17b1804b1-48a55743d05mr350691515e9.27.1777240069081;
        Sun, 26 Apr 2026 14:47:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc10019bsm765744485e9.4.2026.04.26.14.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:47:48 -0700 (PDT)
Date: Sun, 26 Apr 2026 17:47:46 -0400
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
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC v4 05/22] mm: page_alloc: move prep_compound_page before
 post_alloc_hook
Message-ID: <9c4c4cacb2cd5d1fd32219ab00f27e70600c3900.1777223007.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: saG2tG_TFyd-rlBI8oolO67Z4Ggq6LpSHC1L4F8wJbU_1777240070
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Move prep_compound_page() before post_alloc_hook() in prep_new_page().

The next patch adds a folio_zero_user() call to post_alloc_hook(),
which uses folio_nr_pages() to determine how many pages to zero.
Without compound metadata set up first, folio_nr_pages() returns 1
for higher-order allocations, so only the first page would be zeroed.

All other operations in post_alloc_hook() (arch_alloc_page, KASAN,
debug, page owner, etc.) use raw page pointers with explicit order
counts and are unaffected by this reordering.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c19eaf76607c..04c03c56abec 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1895,11 +1895,11 @@ static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags
 							unsigned int alloc_flags,
 							unsigned long user_addr)
 {
-	post_alloc_hook(page, order, gfp_flags, user_addr);
-
 	if (order && (gfp_flags & __GFP_COMP))
 		prep_compound_page(page, order);
 
+	post_alloc_hook(page, order, gfp_flags, user_addr);
+
 	/*
 	 * page is set pfmemalloc when ALLOC_NO_WATERMARKS was necessary to
 	 * allocate the page. The expectation is that the caller is taking
-- 
MST

