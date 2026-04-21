Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9A126B2DA
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808887; cv=none; b=fHRDgbTxUxidi7H0wJh8IMRVG90x9YAkVKOjSNSWXY2h5SmvKMihRjvYIgaRY863BPEbrh0Nwc4vkYXX+IQDkt0scECzI8o4FSpLRUkCVNVi023Gr0bXmNAlaQHYK3Ytjdqguz7Zc3Ct8+NNozNFYGXbAEfEQeBQfpreA7zNFJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808887; c=relaxed/simple;
	bh=wKXQYY6FfDI9a/16Lq7irXZnvvpx8cOvs36gzMXBZhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nA5PJAnJA/2WXRaqoSzA2VH6QVKD4DBdsLZSt5fkGIG3ts+RJhjw2pa7U69W+uCW/s8Tc+kVX/P8hSX7BdJIfEeroZJye3OEWLuR+Rvy0TMC9B6yVdS+Wrec0A0MUJpvynZZqCLWWxzPYczGpAs0IK06ZDBJZiAXF4kdjVOQ3lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EvRQgoM7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvRQgoM7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776808885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Et+lyeWTt5FeJ2gsFu/8TUEAo6EEauFnoYjswzfOPc=;
	b=EvRQgoM7zcF3RmfH+PBuWccrZ/UXrg6EuvhX333QjFOrrqgRx/NZgUtwun7FiieDV7HLeA
	D2Ud3soneIpLefYBzng6dGeOSad180tbMFfYh49JrUEBQXUrxKk/nMDRuJ7eHUsn5ijL/V
	v6OZZewuTN8gbHcrtrLSLPQhUM2NJjY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-bxyzFBjJNWesa3zmV8wxNA-1; Tue, 21 Apr 2026 18:01:24 -0400
X-MC-Unique: bxyzFBjJNWesa3zmV8wxNA-1
X-Mimecast-MFC-AGG-ID: bxyzFBjJNWesa3zmV8wxNA_1776808883
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488d3eec9bcso30641465e9.3
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776808883; x=1777413683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Et+lyeWTt5FeJ2gsFu/8TUEAo6EEauFnoYjswzfOPc=;
        b=dKcGc4q3TshHkovAAxL9A3p6wO+Sevh4vG563Dld4F50LQdAsbjrXQwrV8B1c83opG
         XLk9YAoTBE7IQHj0oEJg97El8/SdwfeJkiTdqPj9fn16i7iNhd954mJD+NupswCXdjNB
         9F/UyKBtMrW6ncgcZM9WDJ6Zf7EsL87DA6v/PgGWF8lH5DwV5mEwB13KK1a2mY90QQJW
         bfFjEY7Eg35oJ0xJImika66L+5UXb7UlDw67JPv9OOkcFPtBaujJ1mCWi5UPfdvYlYT4
         Qe9+iuqDfN21Jl0kkToUKyi4ul3lxk0KEMeGuSdy9X3uWajM7a+61ZkyT40y4PY5ccJ1
         LEaQ==
X-Forwarded-Encrypted: i=1; AFNElJ/0f1DobEf9UUpik/2+Hs37JiOhvTt9aPN0SwzsIXNGVbY3gfuAdwf8dHuGZZ+17xp1aiB03ov42L2hGtcw9w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4saL8AZToTjVsjv1cwBKL+l9D5R7rdsGI9stasW9qN07WoOSi
	JygP8/jJRcidrZW3URnsz4g1VIVZpYIYzrao2WuQolfofZR9IMQCxXrd+ooecPaPLNy4d5PMaH4
	0UwWDs+R+FjkZ97qdtrHIwhG6mx+5UVf5uKVNstwibS3xT3O0A9+2DI6vMibXtaWrs63I
X-Gm-Gg: AeBDietmq9oDn4RHSvyoaY4IX6Q9+5AvsESGzrOJIcqeEoc6woapcej+qCMkkUkoGs1
	6aPCL31zrs8ZfLTqkyJKLlSIVT2NWKQ9lZJ1P9KBpEJ8WewVRD1SiFJeAjCIHFTpRLnQZAArD33
	0nnP2a8gPviOyGumWiPnq5tFsuz+H+xDO+RxL2l6+7SkG6S4N1QkLcN/3CNxFHYWtyeJ7a1N4gm
	lbWQsqUZy9qC4pxSdBxg8qlIznJ0NBDEp3vKhG7VceqDst24dQOXygCjsjmzRvSYZQYK7QwDxBe
	SsEN4TPFAx3yRso+OSfBu53T0M28qSBh+0d3ECo8JTLLP0Tmj1h8r18uetC5F/PvPToP+1HdpnB
	X4FULt+KkZ7UPyhgx64AtPciPKRxdAo5MswWL9wAd19nshjsGsuDieA==
X-Received: by 2002:a05:600c:468c:b0:48a:56d5:16f2 with SMTP id 5b1f17b1804b1-48a56d5179amr56678955e9.7.1776808882901;
        Tue, 21 Apr 2026 15:01:22 -0700 (PDT)
X-Received: by 2002:a05:600c:468c:b0:48a:56d5:16f2 with SMTP id 5b1f17b1804b1-48a56d5179amr56678425e9.7.1776808882298;
        Tue, 21 Apr 2026 15:01:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5549f582sm28902765e9.33.2026.04.21.15.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:01:21 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:01:19 -0400
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
Subject: [PATCH RFC v3 03/19] mm: page_alloc: move prep_compound_page before
 post_alloc_hook
Message-ID: <6e574eb533603db74fd03244399df760a174bdea.1776808210.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 6cbT8qQVqH-Q_7r2wF7VEOuvTTN99-cCMxbZnvygPJ0_1776808883
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
index 1cf5551849fe..99c01eb2d59e 100644
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

