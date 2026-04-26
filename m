Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047362853F8
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240077; cv=none; b=rX7CxRORApNRNHiZAtXT/XIH3ZqlaPDNKYtLmhHiIUoesVRWAYJn1Pus6kv8+9l7cEMy3cIuXJq18yTzBRzLsYklfz2w5BXwsdmWHsUm8zvxYoCBsRTwnQfLzDko7jpHnlPGAfwUHLPuiaVDkSlFHR+Gicz/sZWVCGVCMy2kmdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240077; c=relaxed/simple;
	bh=eoqyj7rvtCF30mdMOUUqj/fkCg1yPgf0J85njMHy46U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=U6W42pzceJ2FsxNxF0nJnLltNlSoPEs1mhw5UcyzhxEMAQPSOK9YYF9XF/R3FhG+gSStd6OJRcq38v+Druas+cplNtW6KLlDYLhnxxsWIGdckKaarA69N6ZehZXC8D+9u/N7mrsjlaOQdtsWdsdlNHmAxI92O6xhfKF+O/Cph+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IKUGJIuo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKUGJIuo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777240075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XUA6w1XPigv17O5YNh9KAjtaq44ytBpbajfhTmLgsNY=;
	b=IKUGJIuo0B5nvL5/QhHuO+Khi0bd3LZrg93w4rGT9/kGRXKLtIHqciQhJ8PA21fZXdhojz
	87+0FhNads8mZRPf7Bi0HHYrAGOB+Y8+Pwfp657Z6/D5LR6BnSo3M7l6yNX6IMBcjvRqrd
	CLM6BTRSqv364DS1C3S+hXukR/OHpsw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-qxPuEsy9OB-1qeHas8VJGw-1; Sun, 26 Apr 2026 17:47:53 -0400
X-MC-Unique: qxPuEsy9OB-1qeHas8VJGw-1
X-Mimecast-MFC-AGG-ID: qxPuEsy9OB-1qeHas8VJGw_1777240072
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488bd1ee9e7so84268595e9.1
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 14:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240072; x=1777844872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUA6w1XPigv17O5YNh9KAjtaq44ytBpbajfhTmLgsNY=;
        b=IH89RyzYAI4S9W9wvF2M3vcJEHyRu4MEPBEjlAvmR7NG+dEVw/v5xmrJQk5HlSI3Iv
         sxmtwYAa/0P3JcZch9xNvvxa45N+rn8t+NjMJ1RXB4dym8Odsp0LKpz8EU6zhB2z/O9v
         6zUILfS47tFnS8LkNERdA0dwarPAk8Nqk22n1L/nsK+WcB2K/k8V+YjtnUdVYgDl+29O
         FaC51YBUp/auR38jqrasBfZpfZe5aghqCy5ADxOIxG1O97lo+lf8BToKTaI7057Ds0O8
         zNP9oGtkNQawEsvNRp67OWHm19e/Bzrl7/xEfmWomKQZyr+Jxnm5QPs2BHgiHx4peljs
         vZGA==
X-Forwarded-Encrypted: i=1; AFNElJ9ZF5duQ7o+KTCwlM/V/2PRCP6jsewithiFGox90v9JJtuqt6LkpeAm7Mq/LrejGFXcUxV4lnQGj2xmyfn2hQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwiFCiGx5rSAdtrFUGphDi8Q4NcjdFCT/pcF7ZJscp9zHuEq/0M
	iMvpl6V6VHuJVC3D2H90ST6k3ysOQurDHYafA16R8vlLKNpz2PIQ84Nuqs593YA6AvJII2rojkh
	bR4wJF1EJXxq+UzfZDRDuv4q1K5kcispa1U9+cKZWSFkDGTVxWmuRj4dqZD7fdqQqxyWG
X-Gm-Gg: AeBDies18J5Waz0WD39HOFRASoDzUPv7wb4B05xpGhGn03W+rqioYLOSuHzIMaevvT6
	CUN2ZJ7I1EximyQverOMQ4KafwE5iTSPvEOE3JzbpvCx4ODec7mh6fBo/Yea9uRsKjgs6RMGtda
	Dfwkm9aIjuofYpdaT+7YtY4vG/COm8ymmciRCpcTfTD7dv+tkR03Fc3QPSIrCSvaGykjitPhVmY
	GDKwpD6woWAybuNiYVHipR627IjZSX2qUKiCj2c+JQ8XRcCekPPOccMBX6W4eJhvsehsKxiDRAa
	Lgn7FilO56ZFC/A9MBJNoDbeEOBzXj9UdBtuQMggZKM4BJ4k4C7RINLGAjxh6IwrNEWwBU3wBhA
	FOkBDiIW9jtxqn8Z5yc56MwvXKU64m26Y+pBQ5SvUXc3k0wm4yvXuBfir
X-Received: by 2002:a05:600c:2d4b:b0:489:c57:75da with SMTP id 5b1f17b1804b1-4890c57760emr286456155e9.31.1777240072469;
        Sun, 26 Apr 2026 14:47:52 -0700 (PDT)
X-Received: by 2002:a05:600c:2d4b:b0:489:c57:75da with SMTP id 5b1f17b1804b1-4890c57760emr286455905e9.31.1777240072037;
        Sun, 26 Apr 2026 14:47:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb75c695sm225077675e9.14.2026.04.26.14.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:47:51 -0700 (PDT)
Date: Sun, 26 Apr 2026 17:47:49 -0400
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
Subject: [PATCH RFC v4 06/22] mm: use folio_zero_user for user pages in
 post_alloc_hook
Message-ID: <fee207ee31232226c00921d568962b55e7450641.1777223007.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 9bNtDG93d4rs52CSn3asp5EWKtUuwnwGKOCpTB0xCxE_1777240072
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
index 04c03c56abec..7791bc1eeefa 100644
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

