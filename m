Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771F223D7F0
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 22:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808916; cv=none; b=WrRfQflGssF82AF9KrglNPyrPXAF+9FLClEMkgeN0p4JwhlDpqGMzoTVNUfzBOG7wyzXHvuWXjREYI8/I7mawtt9Wbnb5kkUXQKV8d1hk76WwcQ30MWWqSlNo5Snkeg96BiNqCGAeOMcGfmnmQ3VPP2dTH3FNjD6xutyO6mvTcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808916; c=relaxed/simple;
	bh=sDo0b8xddYVEGpaxJMvmIOo2W7GKA24+V8mFvrgK7XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hzc/mWeMBn2qXhcferUHGczBmFL00JSnI/hZftWzl/dWDvqMI0cxbyLTLSC6LFSiqPztJ4SavGQOqQLPsyTOv3mNKPciekEqzXSVnc6P8ZgLaTZZDXTVBKDt7lmGRI3Q2NpiRs2EPKhfJuandEoSOKHyIfId9ADOyczcTjrRork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/bqEOVf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/bqEOVf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776808914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXNCfNPQyocyWkSCOxjnq/WqPhuX3fxPK4FCFhhbcx8=;
	b=H/bqEOVfaL1WAPA7faZTBr+Yrrq6SAPRCT6tF89++b6wrodyJnsiD79I7AN/jLlqq2c/jH
	HicscYZfhJHpLtPxCe3jqRPVXRHQkxvInzDOaq4g9p0BOKOy0S1KPMV2cHuCkuQIA/2ZG+
	cARpXVBBG1XGPylwNspqxGYxX3vZyTA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-TmfYgEkwNUSdXodHx6LgcA-1; Tue, 21 Apr 2026 18:01:52 -0400
X-MC-Unique: TmfYgEkwNUSdXodHx6LgcA-1
X-Mimecast-MFC-AGG-ID: TmfYgEkwNUSdXodHx6LgcA_1776808911
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d1dea12aaso3928506f8f.1
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776808911; x=1777413711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXNCfNPQyocyWkSCOxjnq/WqPhuX3fxPK4FCFhhbcx8=;
        b=QpbFCDsP0pdN49+vMYRqHz4PRylSpON8pTzt7+7QvnHnfVzbEnKFdXleEPFf/zuZRQ
         WGd/Pb4q6rQmNIdSF4won4w0aylUIxuKQDM3zzzdxWmfNQ4VxL5KVePgWgvE+qY9mbRB
         8mhrESRPnSzvm+D0EtffPMpADcm407O28cUpyyOWeZZOW4RKh39LhXY3J6ANXAxOGNhd
         IEdZlfquSeqCczbrbdbkRwJSN1AnA1JKqR+SzaR50x4xpZIReyAPDTvqdPbSY2cOB0rT
         /f5ilAofNCnibxAseKzL61UCEy9X3BIhDJHNHnxewv7wRcFIRGnWOJxCU0VdTQEJwnB7
         +0Xg==
X-Forwarded-Encrypted: i=1; AFNElJ+ikKwmTKM6fnNvMx6RG4kittCXdkgV5L861fES1W4LAfzzKDFqMMlc2JMavXZB0r6i053QrPnwE+98liSgWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIJmpWB29eTZSPZgd+av32HN5mWvtb0pFhuX+rEz4WbTlpP+8Z
	EewGPpYJgZIG6Zm9s/W1V/K/DWndSQBbkohlcnDEqJYOxmcSl7JBC8ioULWNLBXVMxIBY6zX6Jf
	0rp1VIU8OwrLceBICZ6We8cgjX81PvvChSkbciDpFT9OSD2oCaE0ekaVio8o4f7BVYS2t
X-Gm-Gg: AeBDies85S/t7ctI0ZxFs4MQnavZofMVFEZmJ8gmTxhKjiVBPeyB0HqrLCSgPidlnIJ
	RIOqKo61jE8SwoXPg2MmRJjdRXpnBgOMOQOwxnZyIm3A4DBkJDiDQiUAPXORGTg2uqbQoOKlBKC
	dJJ1ijEpnzHX9T3laka+UkyXFNlGJn5Nfaf+O6Wt15bWxVLrvg84a1MtYKQSQ0aDCVqxUnIugVW
	QuClbcJBC9P7Xh1s4A1hz6UOkvnJmpvLT1HL713dFAbyDs8Ipapfv+A2Eg8WLP8k1kaR4j6DdCM
	wk/fj1T0ZZP6ZCjkNz4lC/ooQI2ganzIafq4HgBoOM62qmjMAlPdnMzHg0BDCS38q1K6kSJAsBi
	YFLicTMZLOudmoKclnoZ0v5dM2bnwj2hI6z9L+UXFfUKy7Eqmyly1QA==
X-Received: by 2002:a05:6000:2481:b0:43d:77a8:3bb6 with SMTP id ffacd0b85a97d-43fe3e239d9mr31452785f8f.47.1776808910675;
        Tue, 21 Apr 2026 15:01:50 -0700 (PDT)
X-Received: by 2002:a05:6000:2481:b0:43d:77a8:3bb6 with SMTP id ffacd0b85a97d-43fe3e239d9mr31452682f8f.47.1776808909583;
        Tue, 21 Apr 2026 15:01:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc375dsm36898455f8f.14.2026.04.21.15.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:01:48 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:01:46 -0400
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
Subject: [PATCH RFC v3 11/19] mm: page_alloc: propagate PageReported flag
 across buddy splits
Message-ID: <7d1337e364980896be012ab34fd26bb3bf82c7af.1776808210.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: l8GgO5TlKLPTzbMdqvNCqai_64kXO2xyYhpjMBetXJQ_1776808911
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
index db2192ffc27c..211e9e32b91d 100644
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

