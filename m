Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5E93D301D
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490210; cv=none; b=AfqaarYxZJ6GFxyPL6M9niT1UJnXnqOwt8asJ2LgphUCJNgEs/45KUnKMXJxEvLLtNU65/A1dzhAnz9igkUegrsInE5pSIpqhmRT1PEP5NJ1X/FweGrewYKpGIqfty3aT67vOYLskc40SGzpICUWn7VxX1WXf1pmoC4MrskAdt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490210; c=relaxed/simple;
	bh=jg72mm9srvK1uE2wmvtubyBWSeDnP4AXuR+h0vGBnIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RB75MP20tI4vn9FA47syihEDslKeaXqg4S2XKTQw/uErm5W6EP4eeeLc1BqD4O3wVgNUm5X8anNDO7aAcW3cnqigcMFHpmSFeMBdLOBqqAYta7gn2QmgvcXV0hbiHR1JhRtp7UjEdioyUQS3A8vBK5vbV8AAgkZXiq04OUUmLuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LRp8hoHh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRp8hoHh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=huIB05uLC0/aRI1yhZqtcpv3ok57gc+RgGl8EPTE8A0=;
	b=LRp8hoHh/I4yBDeMlZMB/SsWa7nqga++p8ya/eYcps8LWatf9eXo/M68IcLW+YJ9dMa/PP
	ymcvyxG34zsXduzsY/xnMfTHk896Z0sWaaSp+h1g1n89iJicUpf07v4E+020nWOKsa0FVm
	WL1UO6c/fgBfCDGEy1o4uAqryG6Ox5w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-n2Tf6R45OauUVGKfphqftA-1; Mon, 11 May 2026 05:03:26 -0400
X-MC-Unique: n2Tf6R45OauUVGKfphqftA-1
X-Mimecast-MFC-AGG-ID: n2Tf6R45OauUVGKfphqftA_1778490206
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44a3aee3813so2070948f8f.3
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490205; x=1779095005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huIB05uLC0/aRI1yhZqtcpv3ok57gc+RgGl8EPTE8A0=;
        b=OGMGSlbNSjyzyMiiVrQM5nNkr+PQjnzgeUuuTckD53biJVOex0rwlxXTd4u+yLzY7k
         W3VGhLGlLMTi1w+JEPf/PSPltJ9I6ZkVelb2mZz1klRTVjhLQdCP33tU8x/qvUTsMBGL
         UPMq/y+j+JRVzP+l2P0CZqKXThuFz21EDv8+dkre78ao0BpOeiJTOaPeEoNLcxNQ+WHH
         H1Ii63/Po1j4IQBQvm/MFvxuC7jTGOq9upvZx0Bg7g7HDJW13w5fX8/2o5cTfPrl7wIr
         y04yxHbRbgweNP4Qavfie/WNOon1Xv7Iq6nGnozE4aR/qRdhmj//92rc9bYfEV6LMHWU
         QYQw==
X-Forwarded-Encrypted: i=1; AFNElJ9JnLuP4loK0H84ATMe1HoCkMXVtblkfmJA9lOSMz+fCLhbx6kU4yHlkVDHby9XLePmllSsjYbEIaLhDuBFWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnBWtUrv7kjMJl9r3nJit5sfjLGoNLgCLpYCIRtMFzVuiskSQQ
	VUAqA+MC5o65q2k2wrA376ZWZxpipbH4u8/orLjeQrfSqWepuAzRiM23KeDjMh5rbeur+Y7wx6f
	eUtSoKwWGMS5kLaLpGbchm3SrB8ilOnqd65bM/qNWvaVn1G00voBEL178glDZi5Uljv3B
X-Gm-Gg: Acq92OGw+uz7ye9UN6GDTJIwklIhvcaA/M+nAaKLQVrXMN5nx3VK8JJY5kr1Scc0l7H
	HUcF/qOqIAJBUL0XH3IwggaC1Lx2H4mUkdOa9SuwFBvqInt3x52G6c9RFr9dtpO8McUe+SGBH2f
	x/yNw16GwKUpSwDQ9MnhZ9E6kHjLSpWjlrB6Q+irI8uPUj18Wf+HsJOODO2IGctzwgVR5PhCLbd
	2gx0AnwC4IW7c/9cGnBGQ7Vc/NAz1X0x3HeGOJEUwXdNdEAs8UpDswHZ18G6cCex6rYYsEShKf+
	4qum/FYKRlCJ56McSC19X5FIxDDGl+Y7l1evzOCbH0vFXNIG/Y6RwjPOJ681ydjm88dst6LxAXz
	+naCIZimRNPNN+LSV2utLXsk9LJOfl/FenXm9tWbnj+pKJqVpcVM=
X-Received: by 2002:a05:6000:26c2:b0:43d:70de:1c71 with SMTP id ffacd0b85a97d-4515b61a7a5mr36392528f8f.11.1778490205223;
        Mon, 11 May 2026 02:03:25 -0700 (PDT)
X-Received: by 2002:a05:6000:26c2:b0:43d:70de:1c71 with SMTP id ffacd0b85a97d-4515b61a7a5mr36392444f8f.11.1778490204503;
        Mon, 11 May 2026 02:03:24 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-458b3664e3esm8476641f8f.3.2026.05.11.02.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:03:24 -0700 (PDT)
Date: Mon, 11 May 2026 05:03:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH resend v6 17/30] mm: page_alloc: propagate PageReported flag
 across buddy splits
Message-ID: <6d98a35c94fa44b550afa66923c620511e2826f0.1778489843.git.mst@redhat.com>
References: <cover.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778489843.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: spcl3our5m5-GxSgLAgO6cjBcsvVJgGiGrDbUzN3RsI_1778490206
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a reported free page is split via expand() to satisfy a
smaller allocation, the sub-pages placed back on the free lists
lose the PageReported flag.  This means they will be unnecessarily
re-reported to the hypervisor in the next reporting cycle, wasting
work.

Propagate the PageReported flag to sub-pages during expand(),
both in page_del_and_expand() and try_to_claim_block(), so
that they are recognized as already-reported.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/page_alloc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 842f5080d728..76f39dd026ff 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1699,7 +1699,7 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
  * -- nyc
  */
 static inline unsigned int expand(struct zone *zone, struct page *page, int low,
-				  int high, int migratetype)
+				  int high, int migratetype, bool reported)
 {
 	unsigned int size = 1 << high;
 	unsigned int nr_added = 0;
@@ -1721,6 +1721,15 @@ static inline unsigned int expand(struct zone *zone, struct page *page, int low,
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
@@ -1731,9 +1740,10 @@ static __always_inline void page_del_and_expand(struct zone *zone,
 						int high, int migratetype)
 {
 	int nr_pages = 1 << high;
+	bool was_reported = page_reported(page);
 
 	__del_page_from_free_list(page, zone, high, migratetype);
-	nr_pages -= expand(zone, page, low, high, migratetype);
+	nr_pages -= expand(zone, page, low, high, migratetype, was_reported);
 	account_freepages(zone, -nr_pages, migratetype);
 }
 
@@ -2300,10 +2310,12 @@ try_to_claim_block(struct zone *zone, struct page *page,
 	/* Take ownership for orders >= pageblock_order */
 	if (current_order >= pageblock_order) {
 		unsigned int nr_added;
+		bool was_reported = page_reported(page);
 
 		del_page_from_free_list(page, zone, current_order, block_type);
 		change_pageblock_range(page, current_order, start_type);
-		nr_added = expand(zone, page, order, current_order, start_type);
+		nr_added = expand(zone, page, order, current_order, start_type,
+				  was_reported);
 		account_freepages(zone, nr_added, start_type);
 		return page;
 	}
-- 
MST

