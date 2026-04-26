Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69728221FBD
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240102; cv=none; b=gsA1Whh6g/CeqaQ6Bs34b8vqxN7jmpJ92whhWbX5xKGZvKN4E7Joub8ifmQwRMGsqpJLx7Ozx5doiMKKCbrVJMGq2Iuns54WCrwCQvziM+f/gHczCpkjEJ8GNlaIWWZ2SGvDEZ/c/j8IQgpjQ5QilLFDpqguNls+LNprTAjDe9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240102; c=relaxed/simple;
	bh=IxckQwCgbZJbxxjvhlOEmINi1CgwfFxzwO5yadjBe7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Mt/tsUoSVDzvqyczEGEYgLDO1d+2sOs/SimArWTCdDTnOSG69/ftNdRz1V8Ku3lCjEzFEaGlBOfRqiWXOgCfuqv3IPyMbeaRHKSgIC4WzNQG4fJpCKmwEnZONE+3GiTeWGYweOoA4HyEffxiimbEoZYbMQHv2q4YLmtsnY9oSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TtVzh1Gp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtVzh1Gp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777240100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8jzD5+aaEj/qpAoN4ceRyyQr8AzYBOgh6GvhLOGpHCU=;
	b=TtVzh1GpwTZ6sFD5XrO3B9wFk9o4B8Fl3rVjvuCFZPeRsH8QswRpjuJgHoQDq/gllUynhS
	KQ1Ujk6zRBDMA39mHgywDaRQPE05MI1egqTZd9zUjjPN0TgxviymXsSrq29v+INBQhjv3/
	FKfBlVaaIZysGjRDlKm5YEtPIzPO3y4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-iT8qzgXWNkWcQvsCyhwimg-1; Sun, 26 Apr 2026 17:48:17 -0400
X-MC-Unique: iT8qzgXWNkWcQvsCyhwimg-1
X-Mimecast-MFC-AGG-ID: iT8qzgXWNkWcQvsCyhwimg_1777240096
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43ea7a5da42so5410339f8f.1
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 14:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240096; x=1777844896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jzD5+aaEj/qpAoN4ceRyyQr8AzYBOgh6GvhLOGpHCU=;
        b=VvdHj6RzXI4Jwa1IJnk5Lt7nN6/JaliiCes4tfbgQVEzYqZsJCIAnBU93pWQZRP8at
         Q+dvosAQgd3ROOLF2Gim/MUcodrOPo0aaO7pLtmXFoI9JRIynKUK6c0Mp850WMFvfBRq
         C1qujVB2cc21vCJ1Gsq/yPbIQGQGC5w8QNgwI0cYevR/q2b5IdjqsnG0PeVby5uEbav3
         9Jgpbb2Goq/rzT/7JYpoCmUtg5SLOXcjUehPE7Gv8X1K4/aDT3fMTMANwZ+acQ+bXuW4
         flCeMijLML/AsjZTmPQXLMv7SHL1+fZescRaoPlEjYlmWeZIg4ZsdrWvMH1rQjPVFmt0
         11Vw==
X-Forwarded-Encrypted: i=1; AFNElJ9wiorf+QGcNztUFCUUvPYZNSDXjZCN4YgqfnkHC5sta9RykKq5dFiPHI2UfCDlVd4TylE8kaBiTJEz+Q9O+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPoxoppv58ebrxh0Cqe6aUNXpn6i8vGSZMVE31zdMRqjgOSEe6
	STIgAyh1BrfAYNmUP75ovqbRgrYkVKbhAbLftde0E8AyAi2vSA4Tb0kyppJi9i3YTXACfMUHmqL
	bojUcnXXzigMJC6QO1CJj5RpBLT9BFDbdBQxtv4llnkNpf7jm7i7y2txRDsZav0+EmMsz
X-Gm-Gg: AeBDietQgu70XL95LDqB5bvU7RU6SsiOYjl0p7NX3+G0MorsDM/kAXral27MyCuO5Fz
	A/DpR+lkv+ExpL/pyFgJEbfjlJ8x3EoICGnmTpOdrZk5zUCj3Nrsw20CXNzyltsbFmLlW6L8NfD
	6pxR2giYtfTa/7NsMlJ2gvT5ahjAz1ugb8OLPFQy8/jbVmpWQqi/ZcWtcBhuibTESVuiuC3xa4h
	N7NORLiYlNdWAqnT/0tgmWc8wuN02mvdKtgJHxURuLMM2ddBAhLiz37NCeIcgRol+GnmkNZqMKP
	sX9zj5YvwKuStiUSliff6WmAaCQ9ETd68e13cNSW1Zc6xO3J22NoX2Ytvkrz2UM6/m+gB7vrj1p
	SQkfca814PEcT1zM7T6Y0ofWLFfiTCkF9lY/iJ0OOvFeUz7DiFyWZ+6oI
X-Received: by 2002:a05:600c:820d:b0:48a:569c:abab with SMTP id 5b1f17b1804b1-48a569cadacmr341609915e9.14.1777240096109;
        Sun, 26 Apr 2026 14:48:16 -0700 (PDT)
X-Received: by 2002:a05:600c:820d:b0:48a:569c:abab with SMTP id 5b1f17b1804b1-48a569cadacmr341609585e9.14.1777240095687;
        Sun, 26 Apr 2026 14:48:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412150a071sm39398823f8f.21.2026.04.26.14.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:48:15 -0700 (PDT)
Date: Sun, 26 Apr 2026 17:48:13 -0400
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
Subject: [PATCH RFC v4 13/22] mm: page_alloc: propagate PageReported flag
 across buddy splits
Message-ID: <68154113e50456eb8adab9bc5419c30effc59144.1777223007.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 23vn_VWhk2vT3VQjNMu_7FJjvQJ68oCVClSiw9R-rKM_1777240096
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a reported free page is split via expand() to satisfy a
smaller allocation, the sub-pages placed back on the free lists
lose the PageReported flag.  This means they will be unnecessarily
re-reported to the hypervisor in the next reporting cycle, wasting
work.

Propagate the PageReported flag to sub-pages during expand() so
that they are recognized as already-reported.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/page_alloc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7791bc1eeefa..ca4f9c0948af 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1730,7 +1730,7 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
  * -- nyc
  */
 static inline unsigned int expand(struct zone *zone, struct page *page, int low,
-				  int high, int migratetype)
+				  int high, int migratetype, bool reported)
 {
 	unsigned int size = 1 << high;
 	unsigned int nr_added = 0;
@@ -1752,6 +1752,15 @@ static inline unsigned int expand(struct zone *zone, struct page *page, int low,
 		__add_to_free_list(&page[size], zone, high, migratetype, false);
 		set_buddy_order(&page[size], high);
 		nr_added += size;
+
+		/*
+		 * The parent page has been reported to the host.  The
+		 * sub-pages are part of the same reported block, so mark
+		 * them reported too.  This avoids re-reporting pages that
+		 * the host already knows about.
+		 */
+		if (reported)
+			__SetPageReported(&page[size]);
 	}
 
 	return nr_added;
@@ -1762,9 +1771,10 @@ static __always_inline void page_del_and_expand(struct zone *zone,
 						int high, int migratetype)
 {
 	int nr_pages = 1 << high;
+	bool was_reported = page_reported(page);
 
 	__del_page_from_free_list(page, zone, high, migratetype);
-	nr_pages -= expand(zone, page, low, high, migratetype);
+	nr_pages -= expand(zone, page, low, high, migratetype, was_reported);
 	account_freepages(zone, -nr_pages, migratetype);
 }
 
@@ -2334,7 +2344,8 @@ try_to_claim_block(struct zone *zone, struct page *page,
 
 		del_page_from_free_list(page, zone, current_order, block_type);
 		change_pageblock_range(page, current_order, start_type);
-		nr_added = expand(zone, page, order, current_order, start_type);
+		nr_added = expand(zone, page, order, current_order, start_type,
+				  false);
 		account_freepages(zone, nr_added, start_type);
 		return page;
 	}
-- 
MST

