Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61303B38B8
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908059; cv=none; b=NonClibJz/LDIACHV7rSmAGIwrxRNEby6lrCkL93GxK1TtarEpprhD3DppNE7sQe+Mjd+KrD9mS5YSy/nLjyiiU3ljfKbkW66bP7xpyaGNxPFfo3JuWUBnYuRamdRT84+RNquJC+AvEOW6aOp7pB0Gw7Y7g8LFy6PlPDR7E2OTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908059; c=relaxed/simple;
	bh=vnQVlmpg+g0un4bccRkR6WRPQgTaTQW+RONtjX7TAow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lK9d7yIaiXcUqGh76Lf441Fl8wl5PQUmEUXN0U7t9ArX/AJtX/zg4nZ4IZjY8OyQzT/nfwsxqzjo9ic9bS6ihLXtSowS3lno2+fmkS1uqzXYQfPPjBUfqOQfg0iF9CQAEiYKU802yYDjLKy6bZlj2pITUmy3WD6R4zdbq+7fFmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gpyB1DFB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpyB1DFB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780908056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P4H6i1o8NtKwI7+T7msfk1MScFiiY05veUMkpUANhzw=;
	b=gpyB1DFBHBqRt8TxVV/0gphRmaODaMN1xJs+swGqMZ9a9kF/mA6ZLs/ZG6hOZBguTyARiq
	JyT+MhUgWZ2JimftVCXXQ8sJ4lNZGz0DUKXZuv/oRAusGAqz8jPUgQtoh2z2yNlAEF/PaC
	PaoaENrZ6/9K9536Dd6V7FYl9X/tjk0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-eTWKJ3ApOByT8NXwT4srVA-1; Mon, 08 Jun 2026 04:40:55 -0400
X-MC-Unique: eTWKJ3ApOByT8NXwT4srVA-1
X-Mimecast-MFC-AGG-ID: eTWKJ3ApOByT8NXwT4srVA_1780908055
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490b37e1f48so33645245e9.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780908054; x=1781512854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4H6i1o8NtKwI7+T7msfk1MScFiiY05veUMkpUANhzw=;
        b=bdp+puMgydvS8OAzhBM02lPWUhYqh8pOqWACoygd+29G3Qw0jj8DvMq3A7+fwlcrIq
         u9h1vS1tEZVQoUZ5CAfJLjcEBRkbXZLHlWVGe9rYQH7XDVN3SJ/lsAKkXCxQalAFAkV4
         PQMfRvEwIkZoDVuVq/0vj7r6dTcH2DS+cPCKrJrpikP2Yn3tVL3OWWrwhK7ozJUqMubM
         xLZV7So37+KyeURPY2AROtqy1TgOR6IGqolu/D/gK1g5Fa0hmz7nREfSasLgnA4jqi/w
         3Q8RR0SlAGQCnBQNpXcPkN2awvjBucgsS+wffbUgHfXKIwRpqTaMBbMwPy9ZJJqjxKX8
         rIWA==
X-Forwarded-Encrypted: i=1; AFNElJ+1gInanT/sMp94qxD/Ta4xYNh7IKjvkX7oGD4mP/CGKvCinP87tfGLenpGcMgOVBh/MUVqOb+nQUrGb7PXsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyId1sQMzFwd1aZ/IPttL8D/hMzmS7B+LG5zXaPNQRQ8unrmQu2
	L29dwqHXfmTB5e3OrFZt8K/n+8rdj+JfayVsZh5Vc0a/PlUEVW2iiClvwBsC5AdDSW8DneYGz57
	cfpHO12xeBxQrsIIPeD0N8wyyBpnhYOMHdSxjw0JERV2QL0dVYyLVUtDCH+o9AotlmhUB
X-Gm-Gg: Acq92OFP5Zk5Booj/2orqDwGmx7x5hVkMJx7AbDG6JrCUOixAT3LjlozLavSQKPtoHY
	uy2hTeFWsAz2l6m1zn/KKgKT4EqBYr6jihS4qPXp0GAB3aPgmVTmlVbsNmk84darDWGe03oiC32
	uwVy4opBBrnz5jaFi1ZhCEekjXCkeRJ5YmKQJwjvgFHtFLEaWV8Kpi05GsYYV838dIdCv9T1WsK
	j5XkLun/LXGpRH8LJvFRNGBqwjLyq87djhTF9qEwsrEj4etXOpgPRpFVds0japF2tKrt69oRXBx
	HeqcWdKaKpqXrKa7oS9AbYp23m9QK07OJlHQ9g4zSlr1IrUu9WaQ2z93p2mB2AJo713zlKcSYym
	5olStly/qqv83MGTQBPfgVjc=
X-Received: by 2002:a05:600c:c16f:b0:490:b8e6:be40 with SMTP id 5b1f17b1804b1-490c25fc0d5mr237785115e9.21.1780908054484;
        Mon, 08 Jun 2026 01:40:54 -0700 (PDT)
X-Received: by 2002:a05:600c:c16f:b0:490:b8e6:be40 with SMTP id 5b1f17b1804b1-490c25fc0d5mr237784245e9.21.1780908053964;
        Mon, 08 Jun 2026 01:40:53 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b5b06sm343164275e9.3.2026.06.08.01.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:40:53 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:40:45 -0400
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
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: [PATCH v10 36/37] mm: balloon: use put_page_zeroed for zeroed
 balloon pages
Message-ID: <619342ca2c01c60862fe49cd4a790d171cd65ef3.1780906288.git.mst@redhat.com>
References: <cover.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780906288.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J8ff9ZCr7dHflanHs91wgGoY5_-3OYRuAwGD8IdMPf4_1780908055
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a balloon page marked PageZeroed is freed during migration,
use put_page_zeroed() to propagate the zeroed hint to the buddy
allocator. Previously the hint was silently lost via plain put_page().

No page has PageZeroed set yet; the next patch
(VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE) will set it on
pages the host has zeroed during inflate.
Note: during balloon migration, the migration core holds an
extra reference, so put_page_zeroed() will not be the final
put. The zeroed hint is lost in that case, which is
acceptable: it is a best-effort optimization.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/balloon.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/balloon.c b/mm/balloon.c
index 96a8f1e20bc6..6c9dd8ab0c5d 100644
--- a/mm/balloon.c
+++ b/mm/balloon.c
@@ -324,7 +324,15 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
 	balloon_page_finalize(page);
 	spin_unlock_irqrestore(&balloon_pages_lock, flags);
 
-	put_page(page);
+	if (PageZeroed(page)) {
+		/* Atomic to serialize with memory_failure's
+		 * TestSetPageHWPoison; not under zone->lock here.
+		 */
+		ClearPageZeroed(page);
+		put_page_zeroed(page);
+	} else {
+		put_page(page);
+	}
 
 	return 0;
 }
-- 
MST

