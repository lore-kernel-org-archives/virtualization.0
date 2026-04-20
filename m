Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C877137F8A3
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689431; cv=none; b=CRsMMgI4hgQKAJZPFczGy7l0MSODh6q4C5JBnwDEiaVhbxBTrrIQAOYv08z4QeP44MXEoJTkxpJPMQC48IzEuwkERduBIsuWGpb7RVWB4PKHr0fatDK897sGsCDIlSh7U3XhHCwk16Kapd0ooBeS75YOoNiO3ggKwUyDzX7x8a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689431; c=relaxed/simple;
	bh=ElXB4QKq3kqLoKEjiaPaOZnklCWfqoTQmJffudY8v4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZODqQhYwx7TA6zi6ijwBgVdt0aJ8jgcr4BVOoKRMQ5hHFJBpVrNJXMdY+Eg0CFHfPZYlA7P0/tpUilh3ARYD0fLDNB7hgr9XjZk+JiEECKBPeHSXCe1SNyw/jKsGF/+CAuNYIa228IdEgs5uHhVNXRd/bivRI6YGIFUtqjRxNZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OyIUY3ua; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyIUY3ua"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776689428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IelIqVYy/AcgVP/OqP2S72GFWZ6ux/wlNrxvOYGdRd0=;
	b=OyIUY3uaVholhNnLFdAfVnhoG8kGk74Rkot7crb7HAzZZMlYIvOw60bYH/kWvkuKw6rMwy
	5hfXXnyf1CaidK57ODSZvI9Fdyq7TrmmhFVm2ZHdWcllNIsdCHRoYMN3cL9FfJrOdFHKPv
	ww8xSItisPNJSdzJDGCwahce7ejKY5o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-CDpugaxBOS2-cK4IO5qV6g-1; Mon, 20 Apr 2026 08:50:25 -0400
X-MC-Unique: CDpugaxBOS2-cK4IO5qV6g-1
X-Mimecast-MFC-AGG-ID: CDpugaxBOS2-cK4IO5qV6g_1776689424
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43e52dc8a04so2741260f8f.3
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 05:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776689424; x=1777294224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IelIqVYy/AcgVP/OqP2S72GFWZ6ux/wlNrxvOYGdRd0=;
        b=Pnv2c9Y1WdnEMnSsDuWR6sJBlSERrEcMeb8DKgYspHW5ylFZWGGQyuUoPhxA/7WWiX
         HUaxtZMTglIqXHEzZc7c3SyeUjHMtdQA6L5XfP0jSoH8iev675v77swdWQ21qrrdPEVB
         Q5qHpEofw46ZzCv/viJ70Q8G4pPBqQpJ4LUjEQgd/V2LCDWKaoYCvih0OZF6o9SGNoTo
         TxUwunExfR3FjDvjeOuueaLViBxBdYHDhVOtZLakjlWRBaLzeODHDyBhzxkVTYXBRIkp
         ex471DfbwjqY4wadleMUuKmitWZGH5eWt1875n6ZYHMybQmYn4dS2YEKKN9/nqQGEcGt
         HHfQ==
X-Forwarded-Encrypted: i=1; AFNElJ9/S4ZiV5ainH/StpMZCjC14W3aZvKDyGKFlTklHjA1jh0QH2G/XmqbjNlo0ponbb4iK40qlLoddrYSKBIuaA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4FZzMKTwJuhU5RJ1qk3g/BdMme1gHGJHu7qC8lwYZW/wR8co0
	5VBrjyNqs1D5jEZPKTnWzIrTEmOOgJf08lBid1j7Elcv+AbWdxqwp1bk8jPIGRgKK7/1GBgcjyd
	jmMrrQrk5XtBHOUgFXB6+uBXQeSVcUypx3O8J9kDUtP1JKTQH0HhqyA15rUpRhEebMcQ9
X-Gm-Gg: AeBDiesXgcWJeKnoU4UjP5CnntcLTcwQmO6yw84zwnaHEB5W+7iFLpoiU2eCsk1Io66
	IShUmFjMnTDLDp8z+iikEJyyt/hY+aGT6ettwS7GP0xPQCghQnKHbhcPVcCB808HsTr2g0EPGcY
	TpA0G2QP2eLRdorv5FJeNO8HnXjNYfdCI2AzXQ0S2bSCYQIMvMUdcuJ7avlKsDS8uUSD2BTaICr
	hMUjOTzbP2LdPGRRM3HmjKwuaF0ZRngDIaRapKkfLt0UFABMY3eWngUn76tyi0WwtABVZDJG1Kf
	X94+JNFqENJxQ8yIG1+vj3FQ1Wu5IMuRiMYtVw55YyISFUM7IauwEcn0Fq9JELUh8n5ms5IW3nD
	/N/VX6Gng+JNIyFZ1cNmsMfQ/9mfcj+4XdLbR4QYbYtgCJXStvyU/lQ==
X-Received: by 2002:a5d:5f89:0:b0:441:1c95:17e7 with SMTP id ffacd0b85a97d-4411c951810mr250596f8f.15.1776689424156;
        Mon, 20 Apr 2026 05:50:24 -0700 (PDT)
X-Received: by 2002:a5d:5f89:0:b0:441:1c95:17e7 with SMTP id ffacd0b85a97d-4411c951810mr250513f8f.15.1776689423506;
        Mon, 20 Apr 2026 05:50:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a397sm31385276f8f.23.2026.04.20.05.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:50:22 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:50:20 -0400
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
Subject: [PATCH RFC v2 01/18] mm: page_alloc: propagate PageReported flag
 across buddy splits
Message-ID: <8fb5a2dd7eee6fb8ead6b2cb84dc5cc0c45a0f32.1776689093.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: _RDSaLHKeefESeGRAqVY-lk5u1iPC5EXyZF3vvS3JYY_1776689424
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
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_alloc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2d4b6f1a554e..edbb1edf463d 100644
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
 
@@ -2322,7 +2332,8 @@ try_to_claim_block(struct zone *zone, struct page *page,
 
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

