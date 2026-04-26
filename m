Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6366F308F07
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 21:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240109; cv=none; b=erS04xE/FPF/hMdUnoHQcWNQPwmU3POdLBOEonTZTUBeEMAiC1CzXjcVzTQmmCVKNKXNfYVwpovu08OXY44t4O3xfOMElgSOnS+ebkqBPMYjmEkqZlekm4Jw87P7z6slnAEGy51+GIiPg6hb2SSf1VSk+fFXQ5UHYsfkqdBdjyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240109; c=relaxed/simple;
	bh=ddif2Keg7MsypRPUTjBR227ZRe8X6d5tcSgDIOVelv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UZg+5Z/WK0rZTt0nrRnSdwEfVF+nY7VhNEBrt022Yel/L5sZn1gdTiSRkpDMgJevDJ2GAhOaz1NuM0iaKKqWHP52b8qmC5k0F+EGeuVpS9jV6LWVBveTgt9ySd9jRHrXIWlcKasWQY6bBeGgJ1P0Ew5Zc1YDV4QE/t+Gk2mFdvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aRhNMpdU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRhNMpdU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777240107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AlVg98QjuOmMUhZ+nzy6BehsEB+gtg7rKVvx2cLdIro=;
	b=aRhNMpdUfzeK5d68kgPLAPYJMi5OcNDPmhj/HvXJ1I3/KpcvOer07NBeALNGYyzptYskHi
	dZacY6LDuvyx2yneNP3Fl4/jYfqnazpkjlFOiqkVtPH0vQ4R0GF2yodLurM96KxTmHzRb7
	gsrrtIRdZ5BSfB/PGErXr2ac/uuTxG4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-vOqJQOokM2-rhhTPmBNfnQ-1; Sun, 26 Apr 2026 17:48:26 -0400
X-MC-Unique: vOqJQOokM2-rhhTPmBNfnQ-1
X-Mimecast-MFC-AGG-ID: vOqJQOokM2-rhhTPmBNfnQ_1777240105
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43e52dc8a04so8331926f8f.3
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 14:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240105; x=1777844905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlVg98QjuOmMUhZ+nzy6BehsEB+gtg7rKVvx2cLdIro=;
        b=lNNV2WcnMR4m6al4rAgIVKMgITQfImqUShNCabKpnnnaz/Zsdbz+/iITWQICp83PTA
         fTpMsqbPu3slGGSPZCTHYQ98bT2GR8Hzg7llGzMak7JQ3W5MecaPuTCGEVMkXYAqoV30
         +ZfohY0HhTyPs+MuK4zHXlBp87DawTw1XSOjMbzbqVPGIQYzlIVtrD7+m09WkP5tJm+t
         NlKAPM1DnMXKzPpoWHp/Wi7nrGwtLtIyD9Y+tWzkgapAUpFUy4Ycrv5jLWH0FkDBE8Ze
         UWKZ5QVjNVW/7N/V21bCwAUPXvsSLBMqsF7F/Mih4IDL5ZKX3PPUSIfuQHoXcUksZMg+
         0ypg==
X-Forwarded-Encrypted: i=1; AFNElJ8hwNZQaW3/ZCfEs+Wdt1pVpzfW8QuKjJbLAwBRie0CwhgdeCjMHwc17corekLguCmIFqfUVvTQL3AGEqsKOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuWnMWNSclYf5JWqZ4ddC/7gDd8fQG/Ga1A9ZYoRTR/wV4dGiF
	uhRLCnaYzx1Grm78T9XtsgV9YimNwmBHF8yg0TbjHVg/ssiYjFCYM+7VIxY7f01AG043kRLQm7R
	vPwsiIQrU5WFYHHbiWzyVwCdKHzA6nb0jWv8yXosWuK7cUNNAWleAls9ePAcTZH0Vk7Qq
X-Gm-Gg: AeBDies2lLz9wYcsCaG12b9ieZkmdSn3Ls3dWFq7o12B7NBeGqRux7TuULqGasg6zSt
	u/3GJ1coUe5iT+tjStld0QshXqfAShNq98zoddCSTZkglMCJKTpk8uLOzNKKrjNyt3U6mLT9TPK
	efDpI6AWbCZ/HgZ7ft+Yl901s5o30piUXT7YchT27l0Tl421Jp1Qd39jKX0rVsu4/afDUupxJGi
	dmLL7/10Zk6tYw2A/+PgqoRMStRW/heP5WTqdOBgOq3gCxcEeTAXDd2c3Wlz89yvTMPP0VS/K0Q
	+Hum/Q7hoTdCP+eeL3h61XQ7o0XwmosvaEEvZKzBISZ9dmtgN7py/0lQa2yrv0P/AAuqakTkenq
	OrIT607XjrlifL9A12P3m85kpNDsl359pelESl7O2duCSVbCCJRQZBmKM
X-Received: by 2002:a05:6000:24c7:b0:43c:fe0e:5bb9 with SMTP id ffacd0b85a97d-43fe3dd4ca7mr63036140f8f.12.1777240105092;
        Sun, 26 Apr 2026 14:48:25 -0700 (PDT)
X-Received: by 2002:a05:6000:24c7:b0:43c:fe0e:5bb9 with SMTP id ffacd0b85a97d-43fe3dd4ca7mr63036104f8f.12.1777240104579;
        Sun, 26 Apr 2026 14:48:24 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4ffa8sm78084778f8f.35.2026.04.26.14.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:48:24 -0700 (PDT)
Date: Sun, 26 Apr 2026 17:48:21 -0400
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
Subject: [PATCH RFC v4 16/22] mm: page_alloc: preserve PG_zeroed in
 page_del_and_expand
Message-ID: <1db0cfd570fff4b93688619eba55c655be589b35.1777223007.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: ra9Oo_HfETISH0crek4NbwfJBMXz_vXjVhmcL7T7aog_1777240105
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Don't unconditionally clear PG_zeroed for non-reported pages in
page_del_and_expand().  Pages freed via free_frozen_pages_zeroed
(balloon deflate) already have the flag set and should keep it
through buddy allocation, not just PCP reuse.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_alloc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1183ef3e91c9..1169714406e7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1743,7 +1743,8 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
  * -- nyc
  */
 static inline unsigned int expand(struct zone *zone, struct page *page, int low,
-				  int high, int migratetype, bool reported)
+				  int high, int migratetype, bool reported,
+				  bool zeroed)
 {
 	unsigned int size = 1 << high;
 	unsigned int nr_added = 0;
@@ -1774,6 +1775,8 @@ static inline unsigned int expand(struct zone *zone, struct page *page, int low,
 		 */
 		if (reported)
 			__SetPageReported(&page[size]);
+		if (zeroed)
+			__SetPageZeroed(&page[size]);
 	}
 
 	return nr_added;
@@ -1785,10 +1788,12 @@ static __always_inline void page_del_and_expand(struct zone *zone,
 {
 	int nr_pages = 1 << high;
 	bool was_reported = page_reported(page);
+	bool was_zeroed = PageZeroed(page);
 
 	__del_page_from_free_list(page, zone, high, migratetype);
 
-	nr_pages -= expand(zone, page, low, high, migratetype, was_reported);
+	nr_pages -= expand(zone, page, low, high, migratetype, was_reported,
+			   was_zeroed);
 	account_freepages(zone, -nr_pages, migratetype);
 }
 
@@ -2365,11 +2370,13 @@ try_to_claim_block(struct zone *zone, struct page *page,
 	/* Take ownership for orders >= pageblock_order */
 	if (current_order >= pageblock_order) {
 		unsigned int nr_added;
+		bool was_reported = page_reported(page);
+		bool was_zeroed = PageZeroed(page);
 
 		del_page_from_free_list(page, zone, current_order, block_type);
 		change_pageblock_range(page, current_order, start_type);
 		nr_added = expand(zone, page, order, current_order, start_type,
-				  false);
+				  was_reported, was_zeroed);
 		account_freepages(zone, nr_added, start_type);
 		return page;
 	}
-- 
MST

