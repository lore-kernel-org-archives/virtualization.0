Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB752749E1
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288425; cv=none; b=K4CptV++8XEpmUfAFbELXqXhPptelk0E0rQtdtK8ard98KHUoz/KelB+ILSHm9dqTrmn/FE7UDVUIib3y6TdPA+HzZLRavXegMJsRDxLpMir/nPXWUquE9uvsYWMQ+R3QC0/FWYQSowJhrvX5H2ISJWzY2Bv24g6bZecs3vs5Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288425; c=relaxed/simple;
	bh=RPaleElAAsDd8ZXcp7V7mHwwcGHXNcadS42UzjFFaPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=M8aU+9X9hxYvhYZ+XeHfZkfVm+ykgeSU+7g9qWSZINUP9bRszLrf3UmRed4+OFIOYAMB0EVzPsVm5jLdgDIK8KsgbRIP4oOBUg+Gf9U/DUtMRNBbesFzW3cSZ5AF5w1pr2lwiOFX4v6EvuNSkoHfmkAVKbN6eCm1jcy2GKLiJUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d+WyZIX+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+WyZIX+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLYHGg19bG0clXk7rQPjR4hvYWmeZvg7QKQ5c0snrQE=;
	b=d+WyZIX+CPaz4b/evHWnabk1EJiHFSQSkF4d8KimBCXPaXENy3TY1LlHJti7d+fWnUSycH
	8btlgRqtzzOEJt/emCkuvHEl4CNpBo1cmV4TzrwsjyEK78xe0tfiljfjnOVWsYCHTEOAGD
	5M6o2Gzi33HEJVLBLnX2o+HzbcfVNQs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-TVpa7UdsOeuRoz1bvKqGDw-1; Mon, 30 Jun 2025 09:00:20 -0400
X-MC-Unique: TVpa7UdsOeuRoz1bvKqGDw-1
X-Mimecast-MFC-AGG-ID: TVpa7UdsOeuRoz1bvKqGDw_1751288418
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4538f375e86so21118195e9.3
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288418; x=1751893218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLYHGg19bG0clXk7rQPjR4hvYWmeZvg7QKQ5c0snrQE=;
        b=vw2JKl7SMtcExjV+I4pw/DdVKMOGD+WCi53s6ugzb9KQunpPvqrpLuMdvy0S54XAcI
         PXa2ool2TjGOaRHsDCZ09MCYsYCfu86f4Bd0oKbFU92ispm5gKlARdKEF+5cT0DDEk+C
         K6ssapgqE3sPRbiDJhytu0XdRwDB8faqeFiY2filu40yDQR+pLn9LKzFkhCkJ8X7KDyL
         tPxiJBy/47D2YiR7gDg7lJ1hHJKoQGbdFwFKW1DDoipgSmlQBEOWGszydL2FqS9EZ2vv
         oX1xzk83eGaEp0KKaQnMlQqfj1/8Fbir4xbE32DQUD0E5oYgk36sm/oczJYFZMZwQkn/
         1sYA==
X-Forwarded-Encrypted: i=1; AJvYcCXnNlgS2LkCh3b9uQi9+ZQWIwH4kZ5jAufNFpu+Gj/FXnoXTvMEMlB3gMiOhnA6+hPNDxEeGOZSI7CXRcPbSg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxU6k2Vs4r6S4fasCskP4lIhUBJCZbEGI8n/tr3PyBYRr3x72Ue
	sqpk1riK1igydESm0abiRNmc1FTpYztXnFkHa+PWk/yOACzkChWZ/+jTqFQnocpDiWmkTETKU0o
	Wz5fM+DDR+PniCPlaLLwLywQpcb2fmsI59fSbO73VHgRCJqdDfl4DWayMaV/EL0IpwR/r
X-Gm-Gg: ASbGncttQ7LfvVMhS7hfDFmKKUlCwa+fVZ81kgyVa7au2pYkkBgCdG5j4Gx2oOs2rXv
	xvQGaywINXNY9Qyt/KkWUWNJLFLYA/e0m5lcst7+ZQXc/171DtcU/4jmpYsD+uISq450nPX/4dp
	70Z6ipDtHD8TjQYKnTm2trd7Yd8OV2kfFRs0wQNpkwIGP2wTrOfDw8ItGGU9HqHTB7IVwcBbV1g
	mJkkVYNYuJUnXO+43tpNpTQpI/sBvAVARzPnwCGLantWkZ3O3KaSaHc6Umjg5K4jYC5LG2Onwzb
	jq/xxrVwX/p2fQ8PIGKVB72XW7/cxh3mBL7B+gKFkwe3HdS758mxvEqB0CzQNuTtwAF9IYdopFs
	0hrsmX6s=
X-Received: by 2002:a05:600c:35c9:b0:453:608:a18b with SMTP id 5b1f17b1804b1-453947d8ff2mr103853385e9.9.1751288417740;
        Mon, 30 Jun 2025 06:00:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb/NAxjgNou29rgmmNKmV3zZO0Mb6cYoPiX5R9Zf8/khrmrYWUc/XyFqJpcvry+rGAxO8smA==
X-Received: by 2002:a05:600c:35c9:b0:453:608:a18b with SMTP id 5b1f17b1804b1-453947d8ff2mr103852575e9.9.1751288417169;
        Mon, 30 Jun 2025 06:00:17 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e59659sm10376420f8f.77.2025.06.30.06.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:16 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH v1 01/29] mm/balloon_compaction: we cannot have isolated pages in the balloon list
Date: Mon, 30 Jun 2025 14:59:42 +0200
Message-ID: <20250630130011.330477-2-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630130011.330477-1-david@redhat.com>
References: <20250630130011.330477-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8rQm4VFTskkXwKfVwWphPAw4vUxILhvDsaBjOXrUSvc_1751288418
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The core will set PG_isolated only after mops->isolate_page() was
called. In case of the balloon, that is where we will remove it from
the balloon list. So we cannot have isolated pages in the balloon list.

Let's drop this unnecessary check.

Acked-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/balloon_compaction.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index d3e00731e2628..fcb60233aa35d 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -94,12 +94,6 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 		if (!trylock_page(page))
 			continue;
 
-		if (IS_ENABLED(CONFIG_BALLOON_COMPACTION) &&
-		    PageIsolated(page)) {
-			/* raced with isolation */
-			unlock_page(page);
-			continue;
-		}
 		balloon_page_delete(page);
 		__count_vm_event(BALLOON_DEFLATE);
 		list_add(&page->lru, pages);
-- 
2.49.0

