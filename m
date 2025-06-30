Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B50F28BA99
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288507; cv=none; b=Rzke6ZvZEj3FLRT8+9F5/ufUK+Khfq58pino/JTorMqH9gGRWNAOzZ4KZK60HrrPhcazmcgUZmGjqI7snQ470Oj0O0xVLHnZkkucxaK1qym3a/PH/cTkqtf6TgBI9lmoqpNrk21IfBeOabQbY8y53GBOn2jzAJZ1acppxkPPOdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288507; c=relaxed/simple;
	bh=xmAX6FaG7PwzByxdVNWIboeTPGW5tjq2c62uEFet5m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=r2NuIn4U18hDmAs5b91lfQV4oHQL1qdTV+mLZygsm1ZhYf59wB0XYw+cp+dXodp7tMsIyEv4hxvcErn11llDaySm+w0e3qD2+Ey2t8c+HEhTD28Gvr5x3vqAxczPQ4dnXcogfSXGZ4hPji7Wq7k2yfVUczU3jclD0ZlM8bHa/E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LCavlNZb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCavlNZb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpLhIwgxSmOTAUjcHZTQRVGXB1xFFa6Mgym/mVDU2pw=;
	b=LCavlNZbcg79L35M6TtHe926QweUGam2PNbs26/ErA8pXPu58jqIqMBC35y1HTHloU5gQE
	Rd9VMHHmMNJ0JIoXqBUwKsQw38kDlE+1fNKNGuKg8lWocaYm3IMa+23p34XrPOxZ6/PUxW
	uu9/8d1MCF7aQQkIZ0llG73+50p8q1o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-BEn3NDOMMDSmI-UqvY09UA-1; Mon, 30 Jun 2025 09:01:43 -0400
X-MC-Unique: BEn3NDOMMDSmI-UqvY09UA-1
X-Mimecast-MFC-AGG-ID: BEn3NDOMMDSmI-UqvY09UA_1751288499
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a6df0c67a6so1310263f8f.3
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288499; x=1751893299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpLhIwgxSmOTAUjcHZTQRVGXB1xFFa6Mgym/mVDU2pw=;
        b=H4GgCoNLuBh7KF8Wh9wRpu1mzn/+CHV5cDnP4fHbdo3itkJ2KSLgzVc8/a0TriT/Od
         8BmfDcbbf//gNfJzl/bX5KxBFOHozDVQ+Td+/P+fUuZZKomIkaiId9fbj8fJR/UPHqWv
         wZNVUcmSmNwvTXhhYm6JjR5E6LvlOd/c5d3vMs96qJcyKoz70dtDAbcPNeWkOJ5X6aKO
         rcHHNIKNYIhU9pOHA3DAG5B08Q1g3+1H/inH98NuVVU5FpouzmvJmXVy/ZC7A6SMVSfk
         9ARJYSTbWJaL4mkAP0mKI+p3fRTy3Qb2oQalO1Cyy8VdcYxbsjO1Fei9POQH5tUdoHfS
         S7Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXOb9Vb5Y7djl+rpMHLVpJB/XeAts8xFQwWQPyDGVur6TiwIv0tKNFZ5+ODC7aqy7ffuEeZ63KBhuTEjzovJg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxe9rzcJgMDss9s6EXRwzf3TitMW7i0/njNU3wWL0F1ZJyWpUhr
	kisa4X7i2BWCX5QgAbka5PbTRwrmThTnkswWPgJxWh18mEOaqCrtIfyX6Tx++sxuJ1mUVsHpP9/
	/N38XjFJ459e/tCAiE6BGM+tidFo24n06RX2O9JaD5hXJRBt0k9du+qXIVPF5S+QpiJ6X
X-Gm-Gg: ASbGncuVjYcxwgQr83aYPVlDYvGzc7co43c/D8ot9tOnfzVe0XaRRqKjs6P6TOd03GR
	Pg5f69UX4auFevAKtVdpEIbMBsf3oOsg8OvhKden/8MnVAEERiPFzkyyqed47T+AEzEYNeiSsf5
	aqdsaCD+RRWdNOrcK4yl8W+JN6nMCxFeTjP4GTO7KVX3Sg+sNzB811vVyL6fVUuMtp5PhqqhN1J
	Zo7vY3DJtMzDPvOPnE1zb+LRRY1G27G0Hen+e30tNPkgqd/FdLoRtGe4X/qGa3cwt1k2j84QPl2
	iACDYZwfoBFPSL88wLsQb/J6d9fYnYxc1+u6QE0O1fJrhyf98Yac0NEmCBjnAZoxq7tCfTSjyeS
	LlFttXHQ=
X-Received: by 2002:a5d:5849:0:b0:3a5:8934:4940 with SMTP id ffacd0b85a97d-3a8feb70269mr11468334f8f.50.1751288499081;
        Mon, 30 Jun 2025 06:01:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU/EidvqQvGX4HPGBQwVJZ7hXZfY7F5Qe2rCBAm3bwMmXiBwrV5rV1e++rVLkevEN+RDkRKg==
X-Received: by 2002:a5d:5849:0:b0:3a5:8934:4940 with SMTP id ffacd0b85a97d-3a8feb70269mr11468280f8f.50.1751288498410;
        Mon, 30 Jun 2025 06:01:38 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e5f92esm10485904f8f.90.2025.06.30.06.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:01:37 -0700 (PDT)
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
Subject: [PATCH v1 28/29] mm/balloon_compaction: "movable_ops" doc updates
Date: Mon, 30 Jun 2025 15:00:09 +0200
Message-ID: <20250630130011.330477-29-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 3ckyL1qXol9H6HBHj-pnvKmru_4t2tZwrM09cHAh_p4_1751288499
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's bring the docs up-to-date. Setting PG_movable_ops + page->private
very likely still requires to be performed under documented locks:
it's complicated.

We will rework this in the future, as we will try avoiding using the
page lock.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index b222b0737c466..2fecfead91d26 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -4,12 +4,13 @@
  *
  * Common interface definitions for making balloon pages movable by compaction.
  *
- * Balloon page migration makes use of the general non-lru movable page
+ * Balloon page migration makes use of the general "movable_ops page migration"
  * feature.
  *
  * page->private is used to reference the responsible balloon device.
- * page->mapping is used in context of non-lru page migration to reference
- * the address space operations for page isolation/migration/compaction.
+ * That these pages have movable_ops, and which movable_ops apply,
+ * is derived from the page type (PageOffline()) combined with the
+ * PG_movable_ops flag (PageMovableOps()).
  *
  * As the page isolation scanning step a compaction thread does is a lockless
  * procedure (from a page standpoint), it might bring some racy situations while
@@ -17,12 +18,10 @@
  * and safely perform balloon's page compaction and migration we must, always,
  * ensure following these simple rules:
  *
- *   i. when updating a balloon's page ->mapping element, strictly do it under
- *      the following lock order, independently of the far superior
- *      locking scheme (lru_lock, balloon_lock):
+ *   i. Setting the PG_movable_ops flag and page->private with the following
+ *	lock order
  *	    +-page_lock(page);
  *	      +--spin_lock_irq(&b_dev_info->pages_lock);
- *	            ... page->mapping updates here ...
  *
  *  ii. isolation or dequeueing procedure must remove the page from balloon
  *      device page list under b_dev_info->pages_lock.
-- 
2.49.0

