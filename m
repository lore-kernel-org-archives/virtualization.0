Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7783029C355
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288502; cv=none; b=K1FQJaCFvdL4jQN3pVeQX64g05F8/oF7c4w0fPNVwtOv0fxqAMFYX2UaTSKTIIT/1mtq+XHbi/FZcvFJ8/Ylsqv6Ueedb4cKnz/jvSEFxR0PfeLbNIBxNbuB0sr6mplqxsY1nbPjkORoY95g1bt8mJsMm/5Qgo7aJShZXKjg66o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288502; c=relaxed/simple;
	bh=UE0+puqslU6Vod0/Tnuw7OVCa6Yv44yCJDBwHPhWm7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=MMuY7dNfIwu1poCzqsspN/A81tOX/b+h61rB1/6m8GU9nfz8Byo8oejP8AmPqKWsilKS3HTLOR/uKMAg+Z5adPC8zw3w47WraVUzjK2Xn0sPes++QbrQmzNhZbXWbqbogemVxHtWmBsJ2y6Dh1BECH0gBHI4JyVqBVM+aF6nYcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oi/z5ZRg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oi/z5ZRg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zjoj4LwixqS2sGyUbKyFkbKZVx00WcQgc8KQk63N+Nk=;
	b=Oi/z5ZRgVcFcKhG3SfZRQL5UUFDIqI6fJGMLdLEkV9xYAqDKRpvkGsnRkGSfeNbeL393NO
	Isjye7Abuk+vjcFzmXWLDN2DKtMVnqqV30QZnpZx1KF7AKDqrRReMbv+Fjcdv0JjTB1WC1
	xKuGC8LjL7Qd6bqx/q5EnzOKr8/NxlE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-nyR-V7sSMxeblPDXEqNjwQ-1; Mon, 30 Jun 2025 09:01:38 -0400
X-MC-Unique: nyR-V7sSMxeblPDXEqNjwQ-1
X-Mimecast-MFC-AGG-ID: nyR-V7sSMxeblPDXEqNjwQ_1751288497
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a6df0c67a6so1310212f8f.3
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288497; x=1751893297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zjoj4LwixqS2sGyUbKyFkbKZVx00WcQgc8KQk63N+Nk=;
        b=Wp9VPciObzvc/h9Hvno/e7LYc39DdiJl7RLHjyItkIybCXQSQ+L8ztSlHcw2xGwGkQ
         SJoxZLq3ijis8KJnzJ969CaBkDYQ3qTlNAqVhH99EjnDOsGNnxEnC/QgrekmxdIClAZF
         chzweOhihZOHzwAmQoOFR8d0Z5kUyVoqWOdQJUXZ04irfBNNdURWnP9zHc9qUiEkHGO6
         YGu8VDFdIErnkKRISc5YHoLAZBnEmzzm5gc4AQakbJVfHJz5uqazI4Znw226cvccgO0Z
         d5q63TYHRV3q1GIM9NZ6yRfYP1qbwXQGeEOY5wUSvjJM0T1FIo8hrwZyiYAFBxo/5CRs
         Bq1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHo+GMjOMCoztVTLLGrwqyHp6PKBg0Tciqm8GTdb0vO5nBfmJcubgayd/ySl2C3DQOqHohcIMrfwzk/bcsZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWIjRHrcQWKo962h1dQDsUU56keiV2G5NQUuRoqicIR8/gJs3i
	Y57oyVhqtM5ZREqTYa9Ao5I+Wy7DCUqzb7x2WcumE/xoM2bx1OMSVxaZ8RR+9HOVFTG7TWzTchH
	jgvkNUXE8kRHBd2Mp+M4h+Is5qjSnQACx6q8EQo8MRfCJexc65TKhOIjYNJwEk9uIlpKd
X-Gm-Gg: ASbGnculMvMpbMsI67rLmFPxnjcpZVzc9VBuie867gk4473zGimmpLh6+6ezkF/B0p1
	pegFXXOPInD4t5hOly8ZjDfruPgWXW8EbLcFz1AzW2rpAjhuvLZc48WSVV41m1f+kD6PIkgXXtX
	wbenXWsGv105sF5JzL2cw4H3/NOiaW18g3YEBt/2fPqp3EiNNKH6OYxEAVzcYz02K28zMy4LuEo
	W7/wqVLgfBI7fZmxlO0RKxvlj2ZW62Ve3tXIGhgPrfTMXl1zZfqf9675quXMqb70yvt2bY9eD77
	jlNVfDnMZF84p/5AU0V5kf8ZzOAqIQa/erYv5JsuoyDN9Hjo96u5ZYaE2y59qZtXELBsc9piRB6
	chIUeZ+Y=
X-Received: by 2002:a05:6000:41f2:b0:3a4:efc0:c90b with SMTP id ffacd0b85a97d-3a8f482bd78mr11299185f8f.15.1751288496459;
        Mon, 30 Jun 2025 06:01:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUx6MnmvL38m+UjxsSHRmCnwJ9csff/jtPLhL/sKkb+ObakA6KxkyBM5ParmF0iwuWxCWprQ==
X-Received: by 2002:a05:6000:41f2:b0:3a4:efc0:c90b with SMTP id ffacd0b85a97d-3a8f482bd78mr11299087f8f.15.1751288495708;
        Mon, 30 Jun 2025 06:01:35 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ac6ee0d0b9sm4643102f8f.18.2025.06.30.06.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:01:35 -0700 (PDT)
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
Subject: [PATCH v1 27/29] docs/mm: convert from "Non-LRU page migration" to "movable_ops page migration"
Date: Mon, 30 Jun 2025 15:00:08 +0200
Message-ID: <20250630130011.330477-28-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: REXDHtSdRbiGiEFIfMIBoxsS3B07pBQxfNPdb4LJh7Y_1751288497
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's bring the docs up-to-date.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/mm/page_migration.rst | 39 ++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/Documentation/mm/page_migration.rst b/Documentation/mm/page_migration.rst
index 519b35a4caf5b..d611bc21920d7 100644
--- a/Documentation/mm/page_migration.rst
+++ b/Documentation/mm/page_migration.rst
@@ -146,18 +146,33 @@ Steps:
 18. The new page is moved to the LRU and can be scanned by the swapper,
     etc. again.
 
-Non-LRU page migration
-======================
-
-Although migration originally aimed for reducing the latency of memory
-accesses for NUMA, compaction also uses migration to create high-order
-pages.  For compaction purposes, it is also useful to be able to move
-non-LRU pages, such as zsmalloc and virtio-balloon pages.
-
-If a driver wants to make its pages movable, it should define a struct
-movable_operations.  It then needs to call __SetPageMovable() on each
-page that it may be able to move.  This uses the ``page->mapping`` field,
-so this field is not available for the driver to use for other purposes.
+movable_ops page migration
+==========================
+
+Selected typed, non-folio pages (e.g., pages inflated in a memory balloon,
+zsmalloc pages) can be migrated using the movable_ops migration framework.
+
+The "struct movable_operations" provide callbacks specific to a page type
+for isolating, migrating and un-isolating (putback) these pages.
+
+Once a page is indicated as having movable_ops, that condition must not
+change until the page was freed back to the buddy. This includes not
+changing/clearing the page type and not changing/clearing the
+PG_movable_ops page flag.
+
+Arbitrary drivers cannot currently make use of this framework, as it
+requires:
+
+(a) a page type
+(b) indicating them as possibly having movable_ops in page_has_movable_ops()
+    based on the page type
+(c) returning the movable_ops from page_has_movable_ops() based on the page
+    type
+(d) not reusing the PG_movable_ops and PG_movable_ops_isolated page flags
+    for other purposes
+
+For example, balloon drivers can make use of this framework through the
+balloon-compaction infrastructure residing in the core kernel.
 
 Monitoring Migration
 =====================
-- 
2.49.0

