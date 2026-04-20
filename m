Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9085A3016FB
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689440; cv=none; b=fEufV6MXV3+RvOCaHg2JpgONTXU55k4DOojCdAk+Uegnp6TxG71r3sSU1ghiS/P9UYM19zeCvHkdfRAHFfMgJrwPkKZiPcA+fNB8OKOzidQ8ZR1xNkLyWwDkaV660lQwr4S7RPMPfqZC+m81BnWmpJgb6MwAS/aercFmw3H9alM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689440; c=relaxed/simple;
	bh=SSlJYD4HhH0/DNIli18gkk7d7BXgedl64d82fyPnD40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YbaBIG1Fw2F0mhsuHhJo1tRkEehAGpa3HCHNY6A0jWyaPW1LAtJNzP+QGhV3RB0xeKa3TOorgW3YvpS2IAqLloCKsrA6dHDQrteBa4r1uxYI8ll4h7mkWxwp0o2iak/LrC4cIcTEWVvIVq6pZkv+eJuMX+SGlB9gbGOjqXse+lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bxkYD4Nr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxkYD4Nr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776689438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L5nC5ya61lMqmOhAB+HMSdub/zT5DYdzZ4+bbmAFmmI=;
	b=bxkYD4Nrqfa3ao//ZlIW4q1fH9eXPdPiEGOz/Jm5PqCMjPZAqYr3GE3tdNYZrr3HZVMdJJ
	E87YvZxFYEUe/kE/v3l4oNsj5kPZx1AlMOAF++Aau4yUAl96W4b4pscGsvnHS4Sm0wOmrS
	gcru+ueFJcU/IWAeKlHD0bxAoS+oVpY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-OD7XIhVDPZuo0rX5uc3j8Q-1; Mon, 20 Apr 2026 08:50:35 -0400
X-MC-Unique: OD7XIhVDPZuo0rX5uc3j8Q-1
X-Mimecast-MFC-AGG-ID: OD7XIhVDPZuo0rX5uc3j8Q_1776689433
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d7757463eso2242760f8f.0
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 05:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776689433; x=1777294233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5nC5ya61lMqmOhAB+HMSdub/zT5DYdzZ4+bbmAFmmI=;
        b=T9IH9EdCU2TkNOqjCGTUvntPtv3fvWEM3SQeCCJlQhqoBpQl6GPodFv17d3rxktNTm
         BNIGxs7Tj2hdo1qDXpphlnPQ4PE+kP1Y4StkzOMAicyJYnzjG7zU29eced12xeC11z4L
         PguigIDzKZvrbkCy8QHW5bEpy5CJ35P/2HT8XLIZSU6HbCHPsMGXHriuoVYZ7x/9uB/S
         8QLWU8Cbd65HredMWbjtPHfRltSQ7ONf/gDn39RtpUfKTQ+1z+t40SDi/W2bhj86B9yS
         yZhn5HwQcstfaGWzom3GsDVb10T3u4o6SbkJpVKLu7aUY1z7358nOg4lqnLjBUHF+B3C
         +maQ==
X-Forwarded-Encrypted: i=1; AFNElJ/F1ca/eZ/QONj2DtESmOdqt2KWkppfeibJGFuevPVEeazdGXPZUPcEVMuAzoRYhdR42sRhTTpSjjJFX5Yk9g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxr+ZqU4hQTYNHsOJt52cjZVYwF5HKHZK6TMDmLFOLgp6bFu+3R
	YCf/PVhflVdSAvERzaGEvEl3abeClaMkYZ0ttjKGOB5JPd7xgTLuFDBKOOL/7w12E2lont5trvp
	pQEtcRQlDGFwVa3bXRiBZTsHv6Oe8qzTBfq0Q8oo7KVj9BTz4SagkwZRItIH0zb8trQsI
X-Gm-Gg: AeBDiesodoXUNxl5YK12gupPNSlCmmVblQcNB7d3RS/CNl2ppId3zjRj6f5+64eM5Tn
	lb6dfqdPurOKi9uShrejsKDurrvul7ZSHa+bDzBuIpc+OMXnsOWO0c6EpZPPO075i0Z32CTfPxm
	b2NhWcX9oPwU9tKj7JmISA2klI2i3QUTN7uXyS7/RR+89eW2aYWUq49qblEetdxM9gF98vS1hBD
	KxT/hklFsHse2njiHUC40pEN9WrY6qd+SBRI4tgN0AxdAoFiAe6Rcjosd66SacijeUWaBJPBE/F
	8Shtj4QDzcXPhAe7gE8jfUOaXIRI5U7q7AfE8MGVxHb27xs+1TilQ7flN88OD1DBdMeG21bCXBt
	72v3h+lfwh2dZwoDZxs0sedE7mmFFJ588c/UjqzAWJfDimoo3GwUkpQ==
X-Received: by 2002:a5d:6f13:0:b0:43e:a703:3675 with SMTP id ffacd0b85a97d-43fe40329ecmr17814946f8f.5.1776689433164;
        Mon, 20 Apr 2026 05:50:33 -0700 (PDT)
X-Received: by 2002:a5d:6f13:0:b0:43e:a703:3675 with SMTP id ffacd0b85a97d-43fe40329ecmr17814892f8f.5.1776689432659;
        Mon, 20 Apr 2026 05:50:32 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d112sm32443947f8f.29.2026.04.20.05.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:50:32 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:50:30 -0400
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
	virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC v2 04/18] mm: page_alloc: track PG_zeroed across buddy
 merges
Message-ID: <f3b87e8302b177b305af9f120306fb5292d1b782.1776689093.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: RPJXIQxeLSbFCfjTSHasZ2QY_kc4JFlt-oM9cgvdWSY_1776689433
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Preserve PG_zeroed when two buddy pages merge in __free_one_page().
Set it on the merged page only if both buddies are known-zero.  A buddy is
known-zero if it has PG_zeroed set, or if it is reported and the
host zeroes reported pages.

Without this, a zeroed page freed via free_frozen_pages_hint could
merge with a non-zero buddy, and the merged page would falsely
appear zeroed.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_alloc.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f7abbc46e725..6adc894748c8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -984,6 +984,8 @@ static inline void __free_one_page(struct page *page,
 	unsigned long buddy_pfn = 0;
 	unsigned long combined_pfn;
 	struct page *buddy;
+	bool buddy_zeroed;
+	bool page_zeroed;
 	bool to_tail;
 
 	VM_BUG_ON(!zone_is_initialized(zone));
@@ -1022,6 +1024,8 @@ static inline void __free_one_page(struct page *page,
 				goto done_merging;
 		}
 
+		buddy_zeroed = PageZeroed(buddy);
+
 		/*
 		 * Our buddy is free or it is CONFIG_DEBUG_PAGEALLOC guard page,
 		 * merge with it and move up one order.
@@ -1040,10 +1044,17 @@ static inline void __free_one_page(struct page *page,
 			change_pageblock_range(buddy, order, migratetype);
 		}
 
+		page_zeroed = PageZeroed(page);
+		__ClearPageZeroed(page);
+		__ClearPageZeroed(buddy);
+
 		combined_pfn = buddy_pfn & pfn;
 		page = page + (combined_pfn - pfn);
 		pfn = combined_pfn;
 		order++;
+
+		if (page_zeroed && buddy_zeroed)
+			__SetPageZeroed(page);
 	}
 
 done_merging:
@@ -1730,7 +1741,8 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
  * -- nyc
  */
 static inline unsigned int expand(struct zone *zone, struct page *page, int low,
-				  int high, int migratetype, bool reported)
+				  int high, int migratetype, bool reported,
+				  bool zeroed)
 {
 	unsigned int size = 1 << high;
 	unsigned int nr_added = 0;
@@ -1761,6 +1773,8 @@ static inline unsigned int expand(struct zone *zone, struct page *page, int low,
 		 */
 		if (reported)
 			__SetPageReported(&page[size]);
+		if (zeroed)
+			__SetPageZeroed(&page[size]);
 	}
 
 	return nr_added;
@@ -1772,9 +1786,11 @@ static __always_inline void page_del_and_expand(struct zone *zone,
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
 
@@ -2333,7 +2349,7 @@ try_to_claim_block(struct zone *zone, struct page *page,
 		del_page_from_free_list(page, zone, current_order, block_type);
 		change_pageblock_range(page, current_order, start_type);
 		nr_added = expand(zone, page, order, current_order, start_type,
-				  false);
+				  false, false);
 		account_freepages(zone, nr_added, start_type);
 		return page;
 	}
-- 
MST

