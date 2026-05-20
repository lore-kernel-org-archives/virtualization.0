Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D37B3C3429
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315830; cv=none; b=CFIjElVB5nxa9JSd/6AKGHLYUk0svTgqhgbjqe+q0upq2A7NsdljUYIHAA/aYcnx9FqZWA9uvavMo7HqHJqe2fLkEQX5n6g+I9C26ujNnJ2BVGHIubAMdVygrW+LxoDJspnYfHeqdod8dqRHoJ0GCWRnTXYU/zc8VRjgcnmju70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315830; c=relaxed/simple;
	bh=p/E5hRnS5VZWIkTtV/Cpgy5sbv8MptFrLHFQQR1g+04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aa7ShewHAqGdUcRg9MFRcNlbw64Ks1vrzYLXVPtlgFieyG1Bs0xEInAuKKktfy3JcgSTYqQ0TxCSmtHjcHr7XS1IuAdlY16lKijbHE7Xc415prFxzUGeznFeDLfAbSACPCwyvjay8XhrZyB5Q0NxcAs4e4AokFQWQRYbdXHXFK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYupv+Cf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYupv+Cf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K72Es9G8n7K8ecgoDN9zfD/eO+Zd/boK65D6pcX9pF4=;
	b=UYupv+Cfv8TU6mGEpmdaN4DG18rgUtptqu5iGmqKExustP5mD4kiPHbw0XRvQG2K6ZjTdS
	p9vzmUqU5Ih5koC/GkGzkGD/GbshGMAflZMe2VsqP3fIO4zeTXx1dpJ4GBO816ipx4TlMv
	zFRZnYzmqtLbpYFFbFqDOr3t9OMHMcw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-4fWsUc5NMlmZnMS2YMCRLQ-1; Wed, 20 May 2026 18:23:44 -0400
X-MC-Unique: 4fWsUc5NMlmZnMS2YMCRLQ-1
X-Mimecast-MFC-AGG-ID: 4fWsUc5NMlmZnMS2YMCRLQ_1779315823
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fe6894f3fso31909955e9.2
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315823; x=1779920623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K72Es9G8n7K8ecgoDN9zfD/eO+Zd/boK65D6pcX9pF4=;
        b=DL4FrnvE+0WH1Re5C39UBGPXYOXiTQ14pye2l+K5CJaqMjuLXHslNO8I6pcgaoLPqH
         nGudrsjlp+NeXuUl6LsxqmhyiJ0+6wBfdJ8m01lG7464j0imV35RNo4hnwSp5LeGi8FV
         EbR/fhPG3nTnz+V6g/QXUmljIwVKeRnARajvKzJuQvND5hfL2Ogz9xtlRMgNmJcGX7BZ
         xVgk97Pd0TLMTnkohw/Dr5aNlW80AJ1vpxREmGsNLv+M7yl2vp/cxF8AcDFb6gHcy6bz
         HgFI8ACWJYxAXjovPGfitRyUxoJZYBA11Nvz1GLj5iNs8+IwjqpC7/hTJASGRuBY3BAN
         t+yw==
X-Forwarded-Encrypted: i=1; AFNElJ+GgLBQEC4ggLMZUbOaK1MhRNOUcP1+BrX9uzggbw9h13/W1uhOJ3QAGMRGZ6Ls+K4EhXz2p5pAynJVsen/wQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywsh9eaKkpZm1WOA8CHkF4LQ/QCTGaSp5La2rJYwlWN9Dbp9vF7
	IWhLorWowHZX0XxwG9U94XFn07bmtynDc2JpL/Jvil5oQTb/n1b5wEywkBD/FhlYdIiUuW2j9AR
	8rE4eNy2V/EHspXdEKh+BmJi19rX83up58q0hQqJWSS0peUgQ5C/M9yQXjXD59aDhpw7I
X-Gm-Gg: Acq92OFSl0zrNvdkwnsJ7jdeU9U47mPDFxsKuLfBnzaCZoJA0/G1eX8C9m0ip0w/Vjj
	Tu3VBfPCnaiVfqwoz+BmP4rX2fLGJ0NaVIF4w2lxn+1p1T/n2XvP3E/whREQFIXoJMrm+kfT8ay
	x8A6lJjlWF7FkKqItma2RZRBEpSh/esGZl6Y3469bCqg1HgbT3MzpIF1I1eXxBqsfdG6iRKkwog
	iLRLekEOvFXHKaLbm/tC1q/z4sMO+R9h5ZYenR1C7nbKZVv/BGIA3hbc0Je7wGI1qTJUyF6S3LG
	CFFHb2vDbxCIyUJzYknP8MI+Pj0bejK3khJ3XgoK6MKw6eD+Hq0KhFnseXhrbzn7mXurQMpNk9j
	K5DBtjG6FApTQ2lvNh2CBnjYFx/EaFINtSVhg+g2lljo=
X-Received: by 2002:a05:600c:858d:b0:48f:f7cc:f703 with SMTP id 5b1f17b1804b1-490360e4c2amr1777475e9.30.1779315823377;
        Wed, 20 May 2026 15:23:43 -0700 (PDT)
X-Received: by 2002:a05:600c:858d:b0:48f:f7cc:f703 with SMTP id 5b1f17b1804b1-490360e4c2amr1777275e9.30.1779315822889;
        Wed, 20 May 2026 15:23:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d58838sm19711575e9.11.2026.05.20.15.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:23:42 -0700 (PDT)
Date: Wed, 20 May 2026 18:23:38 -0400
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
Subject: [PATCH v8 37/37] mm: balloon: use put_page_zeroed for zeroed balloon
 pages
Message-ID: <61af3e2e956952715b26b51be4afa4ca573ab631.1779315441.git.mst@redhat.com>
References: <cover.1779315441.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1779315441.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L4DKiGnAbzBcoVla1wEiNtQhZtxqeqCmkmW45hxauZE_1779315823
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a balloon page marked PageZeroed is freed during migration,
use put_page_zeroed() to propagate the zeroed hint to the buddy
allocator. Previously the hint was silently lost via plain put_page().

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

