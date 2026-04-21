Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D035F3A3E82
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 22:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808939; cv=none; b=bR2Dm/f9hgEzaMfktoth4D7iLDzFQS2A2DG/esNnjTFrjY5d9DzqOlpKtm1CWgDy8Y6WX5X8SJaFtNqQ9BfJL03zkRlB2m45/g5ijTnXwARBXeo9uAKCN6mmOZXBRDJl0eQUajBizCJmk20FeFk9U7QHGgPB2KVDmVVeu0QIL/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808939; c=relaxed/simple;
	bh=t6QdLjw1QOnLG7lxO09z0R2n3QTY09HOSu8w9aFfJ3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XoJhaTpvEM9AfkNzDyOpdCPJ3WGNZuhsxZTllte2XgX4lPq0NXIFvJ+6ukzmCBG2WxlTS+kTJop5jCoVlJ1szPjmjiog3ibNxpKCDtbBP7vVOgC++WpK99suh4j0cAc0nLT97RQ/e99PylghpBbRgF7z3moFfP3qbHLkb+cIQOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fDv61e8p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDv61e8p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776808937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=83Or3bPRvcXeLqEVqfcTGNmNcJ2rHHbe/Ydh3aV3puc=;
	b=fDv61e8p+C+rHNLwKwFrhAjcVbHZ0rTZMXvVCeHkTBp6d0hVv+lFNhzAEgbCopJLfhPl+a
	GTRh1cccuAOFCzZH6dMdSTg3lmJ2em45Nf5NZsSUeBA6O8ccV/XGlmT0YpES2f0/Umg7qw
	QzrQ/tPJytxpCmzuVk6EpKUBaNV3clo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-HMTSRvy2P2icXnDy0tS8QQ-1; Tue, 21 Apr 2026 18:02:15 -0400
X-MC-Unique: HMTSRvy2P2icXnDy0tS8QQ-1
X-Mimecast-MFC-AGG-ID: HMTSRvy2P2icXnDy0tS8QQ_1776808935
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4836abfc742so50806905e9.0
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776808934; x=1777413734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83Or3bPRvcXeLqEVqfcTGNmNcJ2rHHbe/Ydh3aV3puc=;
        b=alTcz7E16wyChIyWIuZzaR1J7L8eXxIw7oWsApc31jKTT9dxO2DMlllQRgGhp2W+Yd
         cSWdAtdfTdPMzEHR36hEzMfTVhW26B7l5GMEIRzv1WROaLtMqy1dcsgG69f38NAkrO1v
         +Qy+EED4NNDlHPEida9JFO0ptx1Z3wmG6YGvJe3G24j3nf9y9igdZ9abd3XIojVsIcMt
         5SqquUvKd/XeCEDgYfhYfTlm1uw0WUpCdIey7LfALTpfUAeUBaJSGuZZMa8GdqHmKMPo
         BA+Yd201r20+fE/+mlWIAdApRji49Qhx1PdtwfblBG/SL0iTxOs+5Xk0ysbxbNVFwR5T
         PB8g==
X-Forwarded-Encrypted: i=1; AFNElJ9ShuCwNPWjNWzpqydOmzCFEYALtHdSgx2/LMUUqaOENV3jTzCDXaMQQCqtGonepkixz1m8bbRU4xy7IKhPcw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyP6zSMTWGtQj6/7/ws8z6zvKcKEUWeh/FENnMxZXJb36bHQw3A
	1/kyOcHK+Gq+ic2nnrzQOLLmqV6KHMJrfRZ7JpeDgwcH3ckDG2Hw21HFMw2F5KpOK0O9Fi2c4jm
	3RFpUhPBRZbAFIz3w4W7LNs63WTOPBhCL4q0tu4v5BI6k5wiyozKX1+8dCAXgg740KL8h
X-Gm-Gg: AeBDieuUS0ltzuQUzJOMuHfMsqs9RZRhwfpY8TowGF5z1QXafbxGUs4QFsir3OsBXDj
	qN6bV278yD8EQH4P8WUTZLkITQzr67uURagzSxvNmz/LFNXWrUjaY7WwNgmbQv4J8CAwuooo39p
	l0AmU5iQbWBJYcdi4vJMRfXH+BtqO1+8QTBIfsFambmMeVsSQBBtX+iv/t9xoAY4j8KB6fyyFV3
	m1BXpR1AF8hjOsBzs7yUUJYFGj3t1krNLiVveK+GeT0oL9n595roA2WYT8HuRz6PevBo1WTUKQO
	z8d+SADL6zY5mi8Xo69OStJwKJxqKa27447DccmXOnHs0V5yt9m+Wp6DihsAc/dFEWdadyQ5y7D
	EsDkrUzbES9FIVO8UyBUKREyWH8i9mNzbPdmSMSJyWJT8uxYYTCrNqg==
X-Received: by 2002:a05:600c:a105:b0:486:fb69:4960 with SMTP id 5b1f17b1804b1-488fb7786e4mr201642705e9.19.1776808934555;
        Tue, 21 Apr 2026 15:02:14 -0700 (PDT)
X-Received: by 2002:a05:600c:a105:b0:486:fb69:4960 with SMTP id 5b1f17b1804b1-488fb7786e4mr201642415e9.19.1776808934123;
        Tue, 21 Apr 2026 15:02:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5aa3ae83sm884845e9.12.2026.04.21.15.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:02:13 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:02:11 -0400
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
Subject: [PATCH RFC v3 18/19] mm: page_alloc: preserve PG_zeroed in
 page_del_and_expand
Message-ID: <23f51ec61026f598a30a2a031fcf88100afc1f98.1776808210.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 3Sw8RNbVESrc9t3RI-LQtK42xBiOc1KemS3UhRlgbgY_1776808935
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
index 122b49a6d435..3f5ed022cb9c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1751,7 +1751,8 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
  * -- nyc
  */
 static inline unsigned int expand(struct zone *zone, struct page *page, int low,
-				  int high, int migratetype, bool reported)
+				  int high, int migratetype, bool reported,
+				  bool zeroed)
 {
 	unsigned int size = 1 << high;
 	unsigned int nr_added = 0;
@@ -1782,6 +1783,8 @@ static inline unsigned int expand(struct zone *zone, struct page *page, int low,
 		 */
 		if (reported)
 			__SetPageReported(&page[size]);
+		if (zeroed)
+			__SetPageZeroed(&page[size]);
 	}
 
 	return nr_added;
@@ -1793,10 +1796,12 @@ static __always_inline void page_del_and_expand(struct zone *zone,
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
 
@@ -2373,11 +2378,13 @@ try_to_claim_block(struct zone *zone, struct page *page,
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

