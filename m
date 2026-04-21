Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B104225392A
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808892; cv=none; b=EeaFC4jEIDI5dcQwXayuDDLrJW1jyqiZ6AsUdrJv/XNMa37C/Ba9pHPqF1QPk6XOXrdvqDTNU/zOmSQ7ZAhT0KhpXLkwCgvK6+WNlfIcFL5NITJfCsLhnUOczm7i1UmJrMERzkZxiyfxfNvJnct3NRcEQgWtwoS0fxe54JgmoXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808892; c=relaxed/simple;
	bh=HzTLV61VjnP6fPkrfX0cTZjMU7mjfErb3xYIOpy+wWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bFhDNXscreKmotQFCPtUq7YmsdL5HuLs/GZmNU/2g23N+oeZBbLm2UQ60igeHAKiaUBiQ50Nt49tPsH1GZ2Nf3FUbfuTuwdmabnZ/dEp2uVENy6KrbW3k926PKzq3Q3lZ2MwNaan4lQLdtPFfkHA0Rhjs/zdBiehdjp9Jl4qyn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENLvh7jv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENLvh7jv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776808889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XpE7HJIK5tc8NP4T14qa/I9qbq0lyvaV0C1nU6qjpMk=;
	b=ENLvh7jvf7bFXs+/ETIfxvPWdMFnan2RPW9qtQujm3xmySoEvzvqW4yCNZNDVe576WpGFP
	DdM7Y9oV4YNz10dyw0Pj41FqC3hiZunGuw/gxI2i1iw7Tg0NLs+AVhrxtb+9Sx3QXjzvOW
	oDIIW9yNilCjA9seeQvPFkxPbONSXII=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-oxxPAo-dNRGRP3HGIeaTqg-1; Tue, 21 Apr 2026 18:01:28 -0400
X-MC-Unique: oxxPAo-dNRGRP3HGIeaTqg-1
X-Mimecast-MFC-AGG-ID: oxxPAo-dNRGRP3HGIeaTqg_1776808887
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d121c4271so3415318f8f.3
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776808886; x=1777413686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XpE7HJIK5tc8NP4T14qa/I9qbq0lyvaV0C1nU6qjpMk=;
        b=dx34oIXLpV7e/wAa/w5AhR1ULaCacN8JhZFB/E5aEAfDAg5+CImv64MB5IabiewZX/
         NwmHCR1pKxeAgkJahDyyf5Bn2b9ZVhstKz6ZjQ9UVdf+spjfjNC4VwFnCFsh9ncYgxpu
         UfOypvlOQYY8OrAYh66TWMPmfxzrNFAz+V3gWuIsoRgo8zgT99tWkAsBe6ZBypBg/Uii
         AOW4YH7LEcTQ8BKYE/7sXPBNRURwNxK/vBQ6A5wMS/+Yrba5L3NGvBpGYTY5+iyX924B
         +sAgq7vnm8b/5zVUoETU2HveJ/kF1gj6QSa/BnZo/6B6ztmTmlRPTJH2Es2jYe+MrACz
         8shQ==
X-Forwarded-Encrypted: i=1; AFNElJ/yMbyhrGgU4NH+W5wFDnz794tlYA+jGtaHJsms7/+CLmxtN+HND6VuSjtKhJK8PJEfXq4laAAFk4gGdHFyVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHKfkrmNjLZzSB1CKlFyfTMqCN6gg2lnpt7bDjRFIx9uAn7NkH
	8RMymhDJdkvXGbxB2q7j5UFnkgBJTZkvOAfG9hD4x8RD8M7A53gfRNWGQtU2m2zO0TKBr0b5/5I
	VC9C0GbJAcpHn4o2ZD91dLKIjwrNBoZjc2pL3vOXaC3PdiehDV3Hh8ORFsPsaMXksXv11
X-Gm-Gg: AeBDiesxnWtssxaHfP9DknqJmw08u/1578SyORvuVrTJVF/PyAKpgmJ/rQfY5m5Q8gQ
	ZHrsX1Cg74WTKDjXI5kgXqQU59NdvSNqQYuR1007Z6WeKIcasj/ztgxUPBmTgRZQTGrc8lNsp+A
	KrB+IrS5rDkWzsQq2jJE8vv/b5RawRePKpZuNHMxOFtbHR7lOC9xEBcdGrZEhzpz5c2f4M9pT2v
	SfeXqUJAOWNDPXTc3qT7gdlrdgyccgjdbeEHG5apPZ3sYndj+VVNOWw2L2ZINyqD/d8FcXAWiBi
	Yu+T0re6T5FcUpUrL4CYJrzykLJ6H4imvcj7it9gwtSFEnmZySFoAlJQ+khUg7SHUYtixiA9+3E
	6E/WrylPlvy2P4L6bNQJTz35kwznrWPt4b7+t8mO++lHZ6qMe3jyhlQ==
X-Received: by 2002:a05:600c:8115:b0:488:904b:f31 with SMTP id 5b1f17b1804b1-488fb77e27cmr242401685e9.22.1776808886524;
        Tue, 21 Apr 2026 15:01:26 -0700 (PDT)
X-Received: by 2002:a05:600c:8115:b0:488:904b:f31 with SMTP id 5b1f17b1804b1-488fb77e27cmr242401185e9.22.1776808886074;
        Tue, 21 Apr 2026 15:01:26 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a4b329542sm227417095e9.3.2026.04.21.15.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:01:24 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:01:22 -0400
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
Subject: [PATCH RFC v3 04/19] mm: use folio_zero_user for user pages in
 post_alloc_hook
Message-ID: <bf9352d15dd062dcdfa2cb21085e95b52134acb4.1776808210.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: eYFS69VdRs1PAL5pRueznBqNDXbugtzGAb2epswNDaQ_1776808887
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When post_alloc_hook() needs to zero a page for an explicit
__GFP_ZERO allocation and user_addr is set, use folio_zero_user()
instead of kernel_init_pages().  This zeros near the faulting
address last, keeping those cachelines hot for the impending
user access.

folio_zero_user() is only used for explicit __GFP_ZERO, not for
init_on_alloc.  On architectures with virtually-indexed caches
(e.g., ARM), clear_user_highpage() performs per-line cache
operations; using it for init_on_alloc would add overhead that
kernel_init_pages() avoids (the page fault path flushes the
cache at PTE installation time regardless).

No functional change yet: current callers do not pass __GFP_ZERO
for user pages (they zero at the callsite instead).  Subsequent
patches will convert them.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/page_alloc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 99c01eb2d59e..db2192ffc27c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1882,9 +1882,20 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 		for (i = 0; i != 1 << order; ++i)
 			page_kasan_tag_reset(page + i);
 	}
-	/* If memory is still not initialized, initialize it now. */
-	if (init)
-		kernel_init_pages(page, 1 << order);
+	/*
+	 * If memory is still not initialized, initialize it now.
+	 * When __GFP_ZERO was explicitly requested and user_addr is set,
+	 * use folio_zero_user() which zeros near the faulting address
+	 * last, keeping those cachelines hot.  For init_on_alloc, use
+	 * kernel_init_pages() to avoid unnecessary cache flush overhead
+	 * on architectures with virtually-indexed caches.
+	 */
+	if (init) {
+		if ((gfp_flags & __GFP_ZERO) && user_addr != USER_ADDR_NONE)
+			folio_zero_user(page_folio(page), user_addr);
+		else
+			kernel_init_pages(page, 1 << order);
+	}
 
 	set_page_owner(page, order, gfp_flags);
 	page_table_check_alloc(page, order);
-- 
MST

